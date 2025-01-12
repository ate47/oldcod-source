#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_deadshot;

// Namespace zm_perk_deadshot/zm_perk_deadshot
// Params 0, eflags: 0x2
// Checksum 0x4bc34e2e, Offset: 0x118
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_perk_deadshot", &__init__, undefined, undefined);
}

// Namespace zm_perk_deadshot/zm_perk_deadshot
// Params 0, eflags: 0x0
// Checksum 0x9a6ed0cd, Offset: 0x160
// Size: 0x14
function __init__() {
    enable_deadshot_perk_for_level();
}

// Namespace zm_perk_deadshot/zm_perk_deadshot
// Params 0, eflags: 0x0
// Checksum 0xf2141555, Offset: 0x180
// Size: 0xd4
function enable_deadshot_perk_for_level() {
    zm_perks::register_perk_clientfields(#"specialty_deadshot", &deadshot_client_field_func, &deadshot_code_callback_func);
    zm_perks::register_perk_effects(#"specialty_deadshot", "deadshot_light");
    zm_perks::register_perk_init_thread(#"specialty_deadshot", &init_deadshot);
    zm_perks::function_32b099ec(#"specialty_deadshot", #"p8_zm_vapor_altar_icon_01_deadshot", "zombie/fx8_perk_altar_symbol_ambient_dead_shot");
}

// Namespace zm_perk_deadshot/zm_perk_deadshot
// Params 0, eflags: 0x0
// Checksum 0x6602a60, Offset: 0x260
// Size: 0x52
function init_deadshot() {
    if (isdefined(level.enable_magic) && level.enable_magic) {
        level._effect[#"deadshot_light"] = #"hash_2225287695ddf9c9";
    }
}

// Namespace zm_perk_deadshot/zm_perk_deadshot
// Params 0, eflags: 0x0
// Checksum 0x43c2aaba, Offset: 0x2c0
// Size: 0x84
function deadshot_client_field_func() {
    clientfield::register("toplayer", "deadshot_perk", 1, 1, "int", &player_deadshot_perk_handler, 0, 1);
    clientfield::register("clientuimodel", "hudItems.perks.dead_shot", 1, 2, "int", undefined, 0, 1);
}

// Namespace zm_perk_deadshot/zm_perk_deadshot
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x350
// Size: 0x4
function deadshot_code_callback_func() {
    
}

// Namespace zm_perk_deadshot/zm_perk_deadshot
// Params 7, eflags: 0x0
// Checksum 0xa4616b0f, Offset: 0x360
// Size: 0xdc
function player_deadshot_perk_handler(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self) || !is_local_player(self)) {
        return;
    }
    if (!self util::function_162f7df2(localclientnum)) {
        return;
    }
    if (!isdefined(self) || !is_local_player(self)) {
        return;
    }
    if (newval) {
        self usealternateaimparams();
        return;
    }
    self clearalternateaimparams();
}

// Namespace zm_perk_deadshot/zm_perk_deadshot
// Params 1, eflags: 0x4
// Checksum 0xbd56c735, Offset: 0x448
// Size: 0x3a
function private is_local_player(player) {
    if (!isdefined(player)) {
        return 0;
    }
    return isinarray(getlocalplayers(), player);
}

