#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\bots\bot_action;
#using scripts\core_common\bots\bot_position;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace zm_bot_position;

// Namespace zm_bot_position/zm_bot_position
// Params 0, eflags: 0x2
// Checksum 0xe5ccc26, Offset: 0xb8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_bot_position", &__init__, undefined, undefined);
}

// Namespace zm_bot_position/zm_bot_position
// Params 0, eflags: 0x0
// Checksum 0x1656fffd, Offset: 0x100
// Size: 0x124
function __init__() {
    bot_position::function_63f593f5(#"zombie_in_combat", &zombie_in_combat);
    bot_position::function_63f593f5(#"hash_7cf5d8ae94c74382", &function_1648ce34);
    bot_position::function_63f593f5(#"zombie_interact", &zombie_interact);
    bot_position::function_63f593f5(#"zombie_weapon_upgrade", &zombie_weapon_upgrade);
    bot_position::function_56bef20(#"zombie_interact", &function_24a78575);
    bot_position::function_56bef20(#"zombie_weapon_upgrade", &function_f4803376);
}

// Namespace zm_bot_position/zm_bot_position
// Params 2, eflags: 0x0
// Checksum 0x6528404c, Offset: 0x230
// Size: 0x3a
function zombie_in_combat(params, tacbundle) {
    if (!isdefined(self.enemy)) {
        return 0;
    }
    return bot_position::function_2a1ba227(params, tacbundle);
}

// Namespace zm_bot_position/zm_bot_position
// Params 2, eflags: 0x0
// Checksum 0xb3d63471, Offset: 0x278
// Size: 0x3a
function function_1648ce34(params, tacbundle) {
    if (isdefined(self.enemy)) {
        return 0;
    }
    return bot_position::function_2a1ba227(params, tacbundle);
}

// Namespace zm_bot_position/zm_bot_position
// Params 2, eflags: 0x0
// Checksum 0x7d0e04ad, Offset: 0x2c0
// Size: 0x4a
function zombie_interact(params, tacbundle) {
    if (!self bot::function_ccdf4349()) {
        return 0;
    }
    return bot_position::function_2a1ba227(params, tacbundle);
}

// Namespace zm_bot_position/zm_bot_position
// Params 2, eflags: 0x0
// Checksum 0x9cd07951, Offset: 0x318
// Size: 0x4a
function zombie_weapon_upgrade(params, tacbundle) {
    if (!self bot::function_cdf20f6b()) {
        return 0;
    }
    return bot_position::function_2a1ba227(params, tacbundle);
}

// Namespace zm_bot_position/zm_bot_position
// Params 0, eflags: 0x0
// Checksum 0x2285dce8, Offset: 0x370
// Size: 0x102
function function_24a78575() {
    if (!self bot::function_ccdf4349()) {
        return undefined;
    }
    pathfindingradius = self getpathfindingradius();
    interact = self bot::get_interact();
    if (isentity(interact)) {
        return self bot::function_75b62024(interact);
    }
    if (isdefined(interact.trigger_stub)) {
        return self bot::function_80dce372(interact.trigger_stub);
    } else if (isdefined(interact.unitrigger_stub)) {
        return self bot::function_80dce372(interact.unitrigger_stub);
    }
    return self bot::function_80dce372(interact);
}

// Namespace zm_bot_position/zm_bot_position
// Params 0, eflags: 0x0
// Checksum 0x10d35911, Offset: 0x480
// Size: 0x5a
function function_f4803376() {
    if (!self bot::function_cdf20f6b()) {
        return undefined;
    }
    upgrade = self bot::get_interact();
    return self bot::function_80dce372(upgrade.trigger_stub);
}

