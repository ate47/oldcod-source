#using script_1cc417743d7c262d;
#using script_4721de209091b1a6;
#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\tweakables_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\airsupport;
#using scripts\killstreaks\killstreak_detect;
#using scripts\killstreaks\killstreak_hacking;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\mp_common\teams\teams;
#using scripts\weapons\heatseekingmissile;

#namespace counteruav;

// Namespace counteruav/counteruav
// Params 0, eflags: 0x6
// Checksum 0xef4de009, Offset: 0x278
// Size: 0x54
function private autoexec __init__system__() {
    system::register(#"counteruav", &function_70a657d8, undefined, &function_3675de8b, #"killstreaks");
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x5 linked
// Checksum 0x9265d5cf, Offset: 0x2d8
// Size: 0x2c
function private function_1f11d560() {
    if (sessionmodeiswarzonegame()) {
        return "killstreak_counteruav_wz";
    }
    return "killstreak_counteruav";
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x5 linked
// Checksum 0xdb2634ef, Offset: 0x310
// Size: 0x204
function private function_70a657d8() {
    level.counter_uav_offsets = buildoffsetlist((0, 0, 0), 3, 450, 450);
    level.activecounteruavs = [];
    level.activeplayercounteruavs = [];
    level.counter_uav_entities = [];
    if (tweakables::gettweakablevalue("killstreak", "allowcounteruav")) {
        killstreaks::register_killstreak(function_1f11d560(), &activatecounteruav);
    }
    level.var_69f91847 = &function_eb065a52;
    level.var_3d960463 = &function_4148fbc9;
    level.hasindexactivecounteruav = &hasindexactivecounteruav;
    clientfield::register("scriptmover", "counteruav", 1, 1, "int");
    clientfield::register("scriptmover", "counteruav_fx", 1, 1, "int");
    callback::add_callback(#"hash_425352b435722271", &fx_flesh_hit_neck_fatal);
    globallogic_score::register_kill_callback(getweapon("counteruav"), &function_c9938281);
    /#
        if (getdvarint(#"scr_cuav_offset_debug", 0)) {
            level thread waitanddebugdrawoffsetlist();
        }
    #/
    airsupport::init_shared();
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x1 linked
// Checksum 0x56073a91, Offset: 0x520
// Size: 0x32
function function_337a8f70() {
    return isdefined(level.activeplayercounteruavs[self.entnum]) && level.activeplayercounteruavs[self.entnum] > 0;
}

// Namespace counteruav/counteruav
// Params 5, eflags: 0x1 linked
// Checksum 0x1e0ffc27, Offset: 0x560
// Size: 0x144
function function_c9938281(attacker, victim, *weapon, *attackerweapon, *meansofdeath) {
    if (attackerweapon util::isenemyplayer(meansofdeath) && attackerweapon function_337a8f70() && !meansofdeath hasperk("specialty_immunecounteruav")) {
        arrayremovevalue(level.counter_uav_entities, undefined);
        foreach (var_49ddebb in level.counter_uav_entities) {
            if (attackerweapon === var_49ddebb.owner && var_49ddebb function_eb065a52(meansofdeath)) {
                return true;
            }
        }
    }
    return false;
}

// Namespace counteruav/counteruav
// Params 1, eflags: 0x1 linked
// Checksum 0x306351f8, Offset: 0x6b0
// Size: 0x204
function fx_flesh_hit_neck_fatal(params) {
    if (!self hasperk("specialty_immunecounteruav")) {
        foreach (player in params.players) {
            if (player function_337a8f70()) {
                arrayremovevalue(level.counter_uav_entities, undefined);
                foreach (var_49ddebb in level.counter_uav_entities) {
                    if (player === var_49ddebb.owner && var_49ddebb function_eb065a52(self)) {
                        scoregiven = scoreevents::processscoreevent(#"counter_uav_assist", player, undefined, undefined);
                        if (isdefined(scoregiven)) {
                            player challenges::earnedcuavassistscore(scoregiven);
                            killstreakindex = level.killstreakindices[#"counteruav"];
                            killstreaks::killstreak_assist(player, self, killstreakindex);
                        }
                    }
                }
            }
        }
    }
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x1 linked
// Checksum 0x43ddcfe4, Offset: 0x8c0
// Size: 0xa8
function function_3675de8b() {
    if (false) {
        profilestart();
        level.var_f6bf445b = killstreaks::function_f3875fb0(level.var_38c5815f, isdefined(level.var_8ac94558) ? level.var_8ac94558 : 6000, 60, 1, 1);
        profilestop();
    }
    if (isdefined(level.var_1b900c1d)) {
        [[ level.var_1b900c1d ]](getweapon(#"counteruav"), &function_bff5c062);
    }
}

// Namespace counteruav/counteruav
// Params 1, eflags: 0x5 linked
// Checksum 0x5bb39cbe, Offset: 0x970
// Size: 0xe0
function private function_eb065a52(ent) {
    if (!(isdefined(ent) && isdefined(self))) {
        return;
    }
    bundle = killstreaks::get_script_bundle("counteruav");
    var_e96f821a = function_a3f6cdac(isdefined(bundle.var_c23de6e6) ? bundle.var_c23de6e6 : 0);
    if (1 && isdefined(self.var_f6bf445b)) {
        var_54faa045 = self.var_f6bf445b.origin;
    } else {
        var_54faa045 = self.origin;
    }
    return distance2dsquared(ent.origin, var_54faa045) <= var_e96f821a;
}

// Namespace counteruav/counteruav
// Params 2, eflags: 0x1 linked
// Checksum 0x882e1c3c, Offset: 0xa58
// Size: 0x124
function function_bff5c062(cuav, attackingplayer) {
    cuav hackedprefunction(attackingplayer);
    cuav.owner = attackingplayer;
    cuav setowner(attackingplayer);
    cuav killstreaks::configure_team_internal(attackingplayer, 1);
    if (isdefined(level.var_f1edf93f)) {
        cuav notify(#"hacked");
        cuav notify(#"cancel_timeout");
        var_eb79e7c3 = int([[ level.var_f1edf93f ]]() * 1000);
        cuav thread killstreaks::waitfortimeout("counteruav", 30000, &ontimeout, "delete", "death", "crashing");
    }
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x1 linked
// Checksum 0x37e6fe01, Offset: 0xb88
// Size: 0x34
function assignfirstavailableoffsetindex() {
    self.cuav_offset_index = getfirstavailableoffsetindex();
    arrayremovevalue(level.counter_uav_entities, undefined);
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x1 linked
// Checksum 0xf2c9aa5c, Offset: 0xbc8
// Size: 0x11e
function getfirstavailableoffsetindex() {
    available_offsets = [];
    for (i = 0; i < level.counter_uav_offsets.size; i++) {
        available_offsets[i] = 1;
    }
    foreach (cuav in level.counter_uav_entities) {
        if (isdefined(cuav)) {
            available_offsets[cuav.cuav_offset_index] = 0;
        }
    }
    for (i = 0; i < available_offsets.size; i++) {
        if (available_offsets[i]) {
            return i;
        }
    }
    /#
        util::warning("<dev string:x38>");
    #/
    return 0;
}

/#

    // Namespace counteruav/counteruav
    // Params 0, eflags: 0x0
    // Checksum 0x9c8d4413, Offset: 0xcf0
    // Size: 0x34
    function waitanddebugdrawoffsetlist() {
        level endon(#"game_ended");
        wait 10;
        debugdrawoffsetlist();
    }

    // Namespace counteruav/counteruav
    // Params 0, eflags: 0x0
    // Checksum 0x903ded5a, Offset: 0xd30
    // Size: 0xd8
    function debugdrawoffsetlist() {
        baseposition = level.counter_uav_positions[0];
        foreach (offset in level.counter_uav_offsets) {
            util::debug_sphere(baseposition + offset, 24, (0.95, 0.05, 0.05), 0.75, 9999999);
        }
    }

#/

// Namespace counteruav/counteruav
// Params 4, eflags: 0x1 linked
// Checksum 0x53dcbc79, Offset: 0xe10
// Size: 0x120
function buildoffsetlist(startoffset, depth, offset_x, offset_y) {
    offsets = [];
    for (col = 0; col < depth; col++) {
        itemcount = math::pow(2, col);
        startingindex = itemcount - 1;
        for (i = 0; i < itemcount; i++) {
            x = offset_x * col;
            y = 0;
            if (itemcount > 1) {
                y = i * offset_y;
                total_y = offset_y * startingindex;
                y -= total_y / 2;
            }
            offsets[startingindex + i] = startoffset + (x, y, 0);
        }
    }
    return offsets;
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x1 linked
// Checksum 0x10b1747, Offset: 0xf38
// Size: 0x6c
function function_af281272() {
    self endon(#"delete");
    waitresult = self waittill(#"death");
    if (!isdefined(self)) {
        return;
    }
    destroycounteruav(waitresult.attacker, waitresult.weapon);
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x1 linked
// Checksum 0xce941c73, Offset: 0xfb0
// Size: 0x628
function activatecounteruav() {
    if (self killstreakrules::iskillstreakallowed("counteruav", self.team) == 0) {
        return false;
    }
    killstreak_id = self killstreakrules::killstreakstart("counteruav", self.team);
    if (killstreak_id == -1) {
        return false;
    }
    bundle = getscriptbundle(function_1f11d560());
    counteruav = spawncounteruav(self, killstreak_id, bundle);
    if (!isdefined(counteruav)) {
        return false;
    }
    counteruav clientfield::set("enemyvehicle", 1);
    counteruav clientfield::set("counteruav_fx", 1);
    counteruav clientfield::set("scorestreakActive", 1);
    counteruav killstreaks::function_a781e8d2();
    counteruav.killstreak_id = killstreak_id;
    counteruav.var_48d842c3 = 1;
    counteruav thread killstreaks::waittillemp(&destroycounteruavbyemp);
    counteruav thread killstreaks::waitfortimeout("counteruav", 30000, &ontimeout, "delete", "death", "crashing");
    counteruav thread killstreaks::waitfortimecheck(30000 / 2, &ontimecheck, "delete", "death", "crashing");
    counteruav thread function_af281272();
    counteruav thread function_f724cfe4(100000);
    counteruav thread killstreaks::function_2b6aa9e8("counteruav", &destroycounteruav, &onlowhealth, undefined);
    if (false) {
        counteruav killstreaks::function_67d553c4(level.var_f6bf445b, isdefined(level.uav_rotation_radius) ? level.uav_rotation_radius : 4000, isdefined(level.uav_rotation_random_offset) ? level.uav_rotation_random_offset : 1000, 1);
        counteruav clientfield::set("counteruav", 1);
    } else {
        if (sessionmodeiswarzonegame()) {
            var_b0490eb9 = getheliheightlockheight(self.origin);
            trace = groundtrace((self.origin[0], self.origin[1], var_b0490eb9), self.origin - (0, 0, 5000), 0, counteruav);
            var_6be9958b = trace[#"position"][2];
            var_5f8c899e = var_6be9958b + (var_b0490eb9 - var_6be9958b) * bundle.var_ff73e08c;
            var_5f8c899e -= killstreaks::function_43f4782d();
        } else {
            var_5f8c899e = 6000;
        }
        counteruav.var_f6bf445b = killstreaks::function_f3875fb0(self.origin, isdefined(level.var_8ac94558) ? level.var_8ac94558 : var_5f8c899e, 60, 1, 1);
        counteruav killstreaks::function_67d553c4(counteruav.var_f6bf445b, isdefined(level.uav_rotation_radius) ? level.uav_rotation_radius : 4000, isdefined(level.uav_rotation_random_offset) ? level.uav_rotation_random_offset : 1000, 1);
        counteruav.var_f6bf445b clientfield::set("counteruav", 1);
        counteruav.var_f6bf445b setteam(counteruav.team);
    }
    counteruav killstreakrules::function_2e6ff61a("uav", killstreak_id, {#origin:counteruav.var_f6bf445b.origin, #team:counteruav.team});
    self namespace_f9b02f80::play_killstreak_start_dialog("counteruav", self.team, killstreak_id);
    counteruav namespace_f9b02f80::play_pilot_dialog_on_owner("arrive", "counteruav", killstreak_id);
    counteruav thread killstreaks::player_killstreak_threat_tracking("counteruav", 0.965926);
    self stats::function_e24eec31(getweapon("counteruav"), #"used", 1);
    return true;
}

// Namespace counteruav/counteruav
// Params 1, eflags: 0x1 linked
// Checksum 0x60f457d9, Offset: 0x15e0
// Size: 0x1e
function function_f724cfe4(health) {
    waitframe(1);
    self.health = health;
}

// Namespace counteruav/counteruav
// Params 1, eflags: 0x1 linked
// Checksum 0x39094f6, Offset: 0x1608
// Size: 0x2c
function hackedprefunction(*hacker) {
    cuav = self;
    cuav resetactivecounteruav();
}

// Namespace counteruav/counteruav
// Params 3, eflags: 0x1 linked
// Checksum 0x456fdead, Offset: 0x1640
// Size: 0x28c
function spawncounteruav(owner, killstreak_id, bundle) {
    minflyheight = killstreaks::function_43f4782d();
    cuav = spawn("script_model", owner.origin + (0, 0, minflyheight + (isdefined(level.counter_uav_position_z_offset) ? level.counter_uav_position_z_offset : 1000)));
    cuav setmodel(bundle.var_c6eab8b5);
    cuav setenemymodel(bundle.var_aa0b97e1);
    cuav assignfirstavailableoffsetindex();
    cuav killstreaks::configure_team("counteruav", killstreak_id, owner, undefined, undefined, &configureteampost);
    cuav killstreak_hacking::enable_hacking("counteruav", &hackedprefunction, undefined);
    cuav.targetname = "counteruav";
    cuav util::make_sentient();
    cuav.weapon = getweapon("counteruav");
    cuav setweapon(cuav.weapon);
    cuav.victimsoundmod = "vehicle";
    killstreak_detect::killstreaktargetset(cuav);
    cuav thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile(bundle, "crashing", undefined, 1);
    cuav setdrawinfrared(1);
    cuav thread killstreaks::function_5a7ecb6b();
    if (!isdefined(level.counter_uav_entities)) {
        level.counter_uav_entities = [];
    } else if (!isarray(level.counter_uav_entities)) {
        level.counter_uav_entities = array(level.counter_uav_entities);
    }
    level.counter_uav_entities[level.counter_uav_entities.size] = cuav;
    return cuav;
}

// Namespace counteruav/counteruav
// Params 2, eflags: 0x1 linked
// Checksum 0x7e3ad7c6, Offset: 0x18d8
// Size: 0x9c
function configureteampost(owner, *ishacked) {
    cuav = self;
    cuav thread teams::waituntilteamchangesingleton(ishacked, "CUAV_watch_team_change_" + cuav getentitynumber(), &onteamchange, self.entnum, "death", "leaving", "crashing");
    cuav addactivecounteruav();
}

// Namespace counteruav/counteruav
// Params 1, eflags: 0x1 linked
// Checksum 0x1254bbb9, Offset: 0x1980
// Size: 0x54
function playfx(name) {
    self endon(#"death");
    wait 0.1;
    if (isdefined(self)) {
        playfxontag(name, self, "tag_origin");
    }
}

// Namespace counteruav/counteruav
// Params 2, eflags: 0x1 linked
// Checksum 0xf970badc, Offset: 0x19e0
// Size: 0x94
function onlowhealth(*attacker, *weapon) {
    self.is_damaged = 1;
    params = killstreaks::get_script_bundle("counteruav");
    if (isdefined(params.fxlowhealth)) {
        playfxontag(params.fxlowhealth, self, "tag_origin");
    }
    self killstreaks::function_8b4513ca();
}

// Namespace counteruav/counteruav
// Params 2, eflags: 0x1 linked
// Checksum 0x326ac821, Offset: 0x1a80
// Size: 0x2c
function onteamchange(*entnum, *event) {
    destroycounteruav(undefined, undefined);
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x1 linked
// Checksum 0xb2c6ad7f, Offset: 0x1ab8
// Size: 0x1bc
function ontimeout() {
    self.leaving = 1;
    self clientfield::set("counteruav_fx", 0);
    if (false) {
        self clientfield::set("counteruav", 0);
    } else {
        self.var_f6bf445b clientfield::set("counteruav", 0);
    }
    if (isdefined(level.var_14151f16)) {
        [[ level.var_14151f16 ]](self, 0);
    }
    self.owner globallogic_audio::play_taacom_dialog("timeout", "counteruav");
    self removeactivecounteruav();
    if (sessionmodeiswarzonegame()) {
        var_384be02f = 4000;
    }
    self airsupport::leave(5, var_384be02f);
    self util::delay(5 - 2, undefined, &killstreaks::function_3696d106);
    wait 5;
    self killstreaks::function_90e951f2();
    waitframe(1);
    if (target_istarget(self)) {
        target_remove(self);
    }
    self delete();
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x1 linked
// Checksum 0x21a70e20, Offset: 0x1c80
// Size: 0x34
function ontimecheck() {
    self namespace_f9b02f80::play_pilot_dialog_on_owner("timecheck", "counteruav", self.killstreak_id);
}

// Namespace counteruav/counteruav
// Params 2, eflags: 0x1 linked
// Checksum 0xaa6edae7, Offset: 0x1cc0
// Size: 0x44
function destroycounteruavbyemp(attacker, *arg) {
    destroycounteruav(arg, getweapon(#"emp"));
}

// Namespace counteruav/counteruav
// Params 2, eflags: 0x1 linked
// Checksum 0xf7491ba6, Offset: 0x1d10
// Size: 0x214
function destroycounteruav(attacker, weapon) {
    if (self.leaving !== 1) {
        self namespace_f9b02f80::play_destroyed_dialog_on_owner("counteruav", self.killstreak_id);
    }
    if (isdefined(self.var_f6bf445b)) {
        self.var_f6bf445b delete();
    }
    attacker = self [[ level.figure_out_attacker ]](attacker);
    if (isdefined(attacker) && (!isdefined(self.owner) || self.owner util::isenemyplayer(attacker))) {
        attacker battlechatter::function_eebf94f6("counteruav");
        challenges::destroyedaircraft(attacker, weapon, 0, 0);
        self killstreaks::function_73566ec7(attacker, weapon, self.owner);
        luinotifyevent(#"player_callout", 2, #"hash_3544b7c59fa5c59c", attacker.entnum);
        attacker challenges::addflyswatterstat(weapon, self);
        self playsound(#"exp_veh_large");
    }
    self.var_d02ddb8e = weapon;
    self playsound(#"evt_helicopter_midair_exp");
    self removeactivecounteruav();
    if (target_istarget(self)) {
        target_remove(self);
    }
    self thread deletecounteruav();
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x1 linked
// Checksum 0x875dfedd, Offset: 0x1f30
// Size: 0x18c
function deletecounteruav() {
    self notify(#"crashing");
    params = killstreaks::get_script_bundle("counteruav");
    if (isdefined(params.ksexplosionfx)) {
        self thread playfx(params.ksexplosionfx);
    }
    if (isdefined(params.var_bb6c29b4) && isdefined(self.var_d02ddb8e) && self.var_d02ddb8e == getweapon(#"shock_rifle")) {
        self thread playfx(params.var_bb6c29b4);
    }
    self killstreaks::function_90e951f2();
    self killstreaks::function_7d265bd3();
    wait 0.1;
    if (isdefined(self)) {
        self setmodel(#"tag_origin");
        self setenemymodel(#"tag_origin");
    }
    wait 0.2;
    if (isdefined(self)) {
        self notify(#"delete");
        self delete();
    }
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x5 linked
// Checksum 0x951d4010, Offset: 0x20c8
// Size: 0x11c
function private function_4148fbc9() {
    if (isplayer(self) && self hasperk(#"specialty_immunecounteruav")) {
        return false;
    }
    arrayremovevalue(level.counter_uav_entities, undefined);
    foreach (var_49ddebb in level.counter_uav_entities) {
        if (util::function_fbce7263(var_49ddebb.team, self.team) && var_49ddebb function_eb065a52(self)) {
            return true;
        }
    }
    return false;
}

// Namespace counteruav/counteruav
// Params 1, eflags: 0x1 linked
// Checksum 0xfc100a4e, Offset: 0x21f0
// Size: 0x36
function hasindexactivecounteruav(team_or_entnum) {
    return isdefined(level.activecounteruavs[team_or_entnum]) && level.activecounteruavs[team_or_entnum] > 0;
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x1 linked
// Checksum 0x1b50e503, Offset: 0x2230
// Size: 0x148
function addactivecounteruav() {
    if (!isdefined(level.activecounteruavs[self.team])) {
        level.activecounteruavs[self.team] = 0;
    }
    level.activecounteruavs[self.team]++;
    foreach (team, _ in level.teams) {
        if (!util::function_fbce7263(team, self.team)) {
            continue;
        }
        if (killstreaks::hassatellite(team)) {
            self.owner challenges::blockedsatellite();
        }
    }
    if (!isdefined(level.activeplayercounteruavs[self.ownerentnum])) {
        level.activeplayercounteruavs[self.ownerentnum] = 0;
    }
    level.activeplayercounteruavs[self.ownerentnum]++;
    level notify(#"counter_uav_updated");
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x1 linked
// Checksum 0x283e7def, Offset: 0x2380
// Size: 0x7c
function removeactivecounteruav() {
    cuav = self;
    if (cuav.var_f52c102f === 1) {
        return;
    }
    profilestart();
    cuav resetactivecounteruav();
    cuav killstreakrules::killstreakstop("counteruav", self.originalteam, self.killstreak_id);
    cuav.var_f52c102f = 1;
    profilestop();
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x1 linked
// Checksum 0x292bfb96, Offset: 0x2408
// Size: 0x118
function resetactivecounteruav() {
    if (!isdefined(level.activecounteruavs[self.team])) {
        return;
    }
    level.activecounteruavs[self.team]--;
    assert(level.activecounteruavs[self.team] >= 0);
    if (level.activecounteruavs[self.team] <= 0) {
        level.activecounteruavs[self.team] = undefined;
    }
    if (isdefined(level.activeplayercounteruavs[self.ownerentnum])) {
        level.activeplayercounteruavs[self.ownerentnum]--;
        assert(level.activeplayercounteruavs[self.ownerentnum] >= 0);
        if (level.activeplayercounteruavs[self.ownerentnum] <= 0) {
            level.activeplayercounteruavs[self.ownerentnum] = undefined;
        }
    }
    level notify(#"counter_uav_updated");
}

