#using scripts\abilities\ability_player;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\weapons\weaponobjects;

#namespace grapple;

// Namespace grapple/grapple
// Params 0, eflags: 0x2
// Checksum 0x6c6a492c, Offset: 0x98
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"grapple", &__init__, undefined, undefined);
}

// Namespace grapple/grapple
// Params 0, eflags: 0x0
// Checksum 0x59234b2e, Offset: 0xe0
// Size: 0xc4
function __init__() {
    callback::on_spawned(&function_151898f1);
    ability_player::register_gadget_activation_callbacks(20, undefined, &gadget_grapple_off);
    globallogic_score::register_kill_callback(getweapon(#"eq_grapple"), &function_b06e88c);
    weaponobjects::function_f298eae6(#"eq_grapple", &function_9712c910, 1);
}

// Namespace grapple/grapple
// Params 1, eflags: 0x0
// Checksum 0xa2d93571, Offset: 0x1b0
// Size: 0x26
function function_9712c910(watcher) {
    watcher.ondamage = &function_e60d616a;
}

// Namespace grapple/grapple
// Params 5, eflags: 0x0
// Checksum 0x115878d8, Offset: 0x1e0
// Size: 0x98
function function_b06e88c(attacker, victim, weapon, attackerweapon, meansofdeath) {
    if (!isdefined(attacker) || isdefined(attackerweapon) && attackerweapon == weapon) {
        return false;
    }
    return attacker isgrappling() || isdefined(attacker.var_f25a80c2) && attacker.var_f25a80c2 + 2000 > gettime();
}

// Namespace grapple/grapple
// Params 2, eflags: 0x0
// Checksum 0x3d6fd70c, Offset: 0x280
// Size: 0x58
function gadget_grapple_off(slot, weapon) {
    if (!function_b06e88c(self) && isdefined(level.var_57918348)) {
        self [[ level.var_57918348 ]](weapon);
    }
}

// Namespace grapple/grapple
// Params 0, eflags: 0x0
// Checksum 0x33b8863d, Offset: 0x2e0
// Size: 0x1c
function function_151898f1() {
    self thread function_f92707d4();
}

// Namespace grapple/grapple
// Params 0, eflags: 0x0
// Checksum 0x3f22f44a, Offset: 0x308
// Size: 0x42
function function_f92707d4() {
    self endon(#"death");
    while (isdefined(self)) {
        self waittill(#"grapple_cancel");
        self.var_f25a80c2 = gettime();
    }
}

// Namespace grapple/grapple
// Params 1, eflags: 0x0
// Checksum 0xa0dcfce7, Offset: 0x358
// Size: 0x24
function function_e60d616a(watcher) {
    self setcandamage(0);
}

