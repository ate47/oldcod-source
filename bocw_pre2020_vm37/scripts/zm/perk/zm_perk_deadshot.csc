#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_deadshot;

// Namespace zm_perk_deadshot/zm_perk_deadshot
// Params 0, eflags: 0x6
// Checksum 0x856a75b9, Offset: 0xf0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_perk_deadshot", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_perk_deadshot/zm_perk_deadshot
// Params 0, eflags: 0x5 linked
// Checksum 0x15bfa1be, Offset: 0x138
// Size: 0x14
function private function_70a657d8() {
    enable_deadshot_perk_for_level();
}

// Namespace zm_perk_deadshot/zm_perk_deadshot
// Params 0, eflags: 0x1 linked
// Checksum 0x370b2b79, Offset: 0x158
// Size: 0x9c
function enable_deadshot_perk_for_level() {
    zm_perks::register_perk_clientfields(#"hash_210097a75bb6c49a", &deadshot_client_field_func, &deadshot_code_callback_func);
    zm_perks::register_perk_effects(#"hash_210097a75bb6c49a", "deadshot_light");
    zm_perks::register_perk_init_thread(#"hash_210097a75bb6c49a", &init_deadshot);
}

// Namespace zm_perk_deadshot/zm_perk_deadshot
// Params 0, eflags: 0x1 linked
// Checksum 0x650e3d1b, Offset: 0x200
// Size: 0x3c
function init_deadshot() {
    if (is_true(level.enable_magic)) {
        level._effect[#"deadshot_light"] = "zombie/fx_perk_daiquiri_factory_zmb";
    }
}

// Namespace zm_perk_deadshot/zm_perk_deadshot
// Params 0, eflags: 0x1 linked
// Checksum 0xe980480e, Offset: 0x248
// Size: 0x4c
function deadshot_client_field_func() {
    clientfield::register("toplayer", "deadshot_perk", 1, 1, "int", &player_deadshot_perk_handler, 0, 1);
}

// Namespace zm_perk_deadshot/zm_perk_deadshot
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0x2a0
// Size: 0x4
function deadshot_code_callback_func() {
    
}

// Namespace zm_perk_deadshot/zm_perk_deadshot
// Params 7, eflags: 0x1 linked
// Checksum 0x9e90240e, Offset: 0x2b0
// Size: 0xcc
function player_deadshot_perk_handler(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!is_local_player(self)) {
        return;
    }
    self endon(#"death");
    if (self util::function_50ed1561(fieldname)) {
        if (is_local_player(self)) {
            if (bwastimejump) {
                self usealternateaimparams();
                return;
            }
            self clearalternateaimparams();
        }
    }
}

// Namespace zm_perk_deadshot/zm_perk_deadshot
// Params 1, eflags: 0x5 linked
// Checksum 0xd9264815, Offset: 0x388
// Size: 0x6a
function private is_local_player(player) {
    if (!isdefined(player) || !isplayer(player)) {
        return 0;
    }
    a_players = getlocalplayers();
    return isinarray(a_players, player);
}

