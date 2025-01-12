#using scripts\core_common\callbacks_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace deathicons;

// Namespace deathicons/deathicons
// Params 0, eflags: 0x2
// Checksum 0x110c8b2e, Offset: 0xa0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"deathicons", &__init__, undefined, undefined);
}

// Namespace deathicons/deathicons
// Params 0, eflags: 0x0
// Checksum 0xc3ae52db, Offset: 0xe8
// Size: 0x44
function __init__() {
    callback::on_start_gametype(&init);
    callback::on_connect(&on_player_connect);
}

// Namespace deathicons/deathicons
// Params 0, eflags: 0x0
// Checksum 0xa3aace8e, Offset: 0x138
// Size: 0x3c
function init() {
    if (!isdefined(level.ragdoll_override)) {
        level.ragdoll_override = &ragdoll_override;
    }
    if (!level.teambased) {
        return;
    }
}

// Namespace deathicons/deathicons
// Params 0, eflags: 0x0
// Checksum 0x24bd9fa8, Offset: 0x180
// Size: 0xe
function on_player_connect() {
    self.selfdeathicons = [];
}

// Namespace deathicons/deathicons
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x198
// Size: 0x4
function update_enabled() {
    
}

// Namespace deathicons/deathicons
// Params 3, eflags: 0x0
// Checksum 0x6976c1d5, Offset: 0x1a8
// Size: 0x20c
function add(entity, dyingplayer, team) {
    if (!level.teambased) {
        return;
    }
    timeout = getdvarfloat(#"scr_deathicon_time", 5);
    iconorg = entity.origin;
    dyingplayer endon(#"spawned_player");
    dyingplayer endon(#"disconnect");
    waitframe(1);
    util::waittillslowprocessallowed();
    assert(isdefined(level.teams[team]));
    assert(isdefined(level.teamindex[team]));
    if (getdvarint(#"ui_hud_showdeathicons", 1) == 0) {
        return;
    }
    if (level.hardcoremode || sessionmodeiswarzonegame()) {
        return;
    }
    deathiconobjid = gameobjects::get_next_obj_id();
    objective_add(deathiconobjid, "active", iconorg, #"headicon_dead", dyingplayer);
    objective_setteam(deathiconobjid, team);
    function_c3a2445a(deathiconobjid, team, 1);
    level thread destroy_slowly(timeout, deathiconobjid);
}

// Namespace deathicons/deathicons
// Params 2, eflags: 0x0
// Checksum 0xc1abf355, Offset: 0x3c0
// Size: 0x6c
function destroy_slowly(timeout, deathiconobjid) {
    wait timeout;
    objective_setstate(deathiconobjid, "done");
    wait 1;
    objective_delete(deathiconobjid);
    gameobjects::release_obj_id(deathiconobjid);
}

// Namespace deathicons/deathicons
// Params 10, eflags: 0x0
// Checksum 0xc37d1b35, Offset: 0x438
// Size: 0xd4
function ragdoll_override(idamage, smeansofdeath, sweapon, shitloc, vdir, vattackerorigin, deathanimduration, einflictor, ragdoll_jib, body) {
    if (smeansofdeath == "MOD_FALLING" && self isonground() == 1) {
        body startragdoll();
        if (!isdefined(self.switching_teams)) {
            thread add(body, self, self.team);
        }
        return true;
    }
    return false;
}

