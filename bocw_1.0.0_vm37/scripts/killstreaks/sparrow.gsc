#using scripts\core_common\callbacks_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\weapons\weapons;

#namespace sparrow;

// Namespace sparrow/sparrow
// Params 0, eflags: 0x6
// Checksum 0xb66cbb29, Offset: 0x108
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"sparrow", &__init__, undefined, undefined, #"killstreaks");
}

// Namespace sparrow/sparrow
// Params 0, eflags: 0x0
// Checksum 0xc27627bc, Offset: 0x158
// Size: 0x84
function __init__() {
    killstreaks::register_killstreak("killstreak_sparrow", &killstreaks::function_fc82c544);
    status_effect::function_30e7d622(getweapon(#"inventory_sig_bow_flame"), "flakjacket");
    callback::on_player_damage(&onplayerdamage);
}

// Namespace sparrow/missile_fire
// Params 1, eflags: 0x40
// Checksum 0x60dcca6a, Offset: 0x1e8
// Size: 0x22c
function event_handler[missile_fire] function_8cd77cf6(eventstruct) {
    if (!isplayer(self)) {
        return;
    }
    missile = eventstruct.projectile;
    weapon = eventstruct.weapon;
    missile thread function_1bb4a86d();
    if (function_119a2a90(weapon)) {
        missile.soundmod = "player";
        missile thread weapons::check_stuck_to_player(1, 0, weapon);
        waitresult = missile waittill(#"projectile_impact_explode", #"bow_projectile_deleted");
        position = waitresult.position;
        if (waitresult._notify == "projectile_impact_explode") {
            if (!is_under_water(position)) {
                normal = waitresult.normal;
                playertrace = bullettrace(position, position - vectorscale(normal, 4), 1, missile);
                if (isplayer(playertrace[#"entity"]) || isactor(playertrace[#"entity"])) {
                    explosionfx = #"hash_68f22c5fa8133ec1";
                } else {
                    explosionfx = #"hash_50f125069e98a03d";
                }
                angles = vectortoangles(normal);
                playfx(explosionfx, position, normal, anglestoup(angles));
            }
        }
    }
}

// Namespace sparrow/sparrow
// Params 0, eflags: 0x0
// Checksum 0xebe9ab46, Offset: 0x420
// Size: 0x2e
function function_1bb4a86d() {
    self waittill(#"death");
    waittillframeend();
    self notify(#"bow_projectile_deleted");
}

// Namespace sparrow/sparrow
// Params 1, eflags: 0x0
// Checksum 0x3e0a2ff6, Offset: 0x458
// Size: 0x42
function is_under_water(position) {
    water_depth = getwaterheight(position) - position[2];
    return water_depth >= 24;
}

// Namespace sparrow/sparrow
// Params 1, eflags: 0x4
// Checksum 0xb8808a19, Offset: 0x4a8
// Size: 0xac
function private onplayerdamage(params) {
    weapon = params.weapon;
    if (!function_119a2a90(weapon)) {
        return;
    }
    if (params.smeansofdeath == "MOD_DOT") {
        return;
    }
    statuseffect = getstatuseffect("dot_sig_bow_flame");
    self status_effect::status_effect_apply(statuseffect, weapon, params.eattacker, 0, undefined, undefined, params.vpoint);
}

// Namespace sparrow/sparrow
// Params 1, eflags: 0x4
// Checksum 0x1257cfc8, Offset: 0x560
// Size: 0x20
function private function_119a2a90(weapon) {
    return weapon.statname == "sig_bow_flame";
}

