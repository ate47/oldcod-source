#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_bgb;

#namespace zm_bgb_head_scan;

// Namespace zm_bgb_head_scan/zm_bgb_head_scan
// Params 0, eflags: 0x2
// Checksum 0x58fb84f6, Offset: 0x98
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_bgb_head_scan", &__init__, undefined, "bgb");
}

// Namespace zm_bgb_head_scan/zm_bgb_head_scan
// Params 0, eflags: 0x0
// Checksum 0x4e837f50, Offset: 0xe0
// Size: 0x94
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register(#"zm_bgb_head_scan", "time", 120, &enable, &disable, undefined, undefined);
    zm::register_actor_damage_callback(&function_19ac44c4);
}

// Namespace zm_bgb_head_scan/zm_bgb_head_scan
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x180
// Size: 0x4
function enable() {
    
}

// Namespace zm_bgb_head_scan/zm_bgb_head_scan
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x190
// Size: 0x4
function disable() {
    
}

// Namespace zm_bgb_head_scan/zm_bgb_head_scan
// Params 12, eflags: 0x0
// Checksum 0x9deeb729, Offset: 0x1a0
// Size: 0x186
function function_19ac44c4(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (isplayer(attacker) && attacker bgb::is_enabled(#"zm_bgb_head_scan")) {
        switch (shitloc) {
        case #"head":
        case #"helmet":
        case #"neck":
            switch (self.var_29ed62b2) {
            case #"popcorn":
            case #"basic":
                if (function_c4926047(25)) {
                    gibserverutils::gibhead(self);
                    return self.health;
                }
                break;
            }
            break;
        default:
            return -1;
        }
    }
    return -1;
}

// Namespace zm_bgb_head_scan/zm_bgb_head_scan
// Params 1, eflags: 0x0
// Checksum 0xca4edcab, Offset: 0x330
// Size: 0x44
function function_c4926047(n_target) {
    n_roll = randomintrangeinclusive(1, 100);
    if (n_roll <= n_target) {
        return true;
    }
    return false;
}

