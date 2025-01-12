#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\zm_common\zm_sq;
#using scripts\zm_common\zm_zonemgr;

#namespace namespace_c831ca5c;

// Namespace namespace_c831ca5c/zm_towers_side_quests
// Params 0, eflags: 0x0
// Checksum 0xf23a358e, Offset: 0xa0
// Size: 0xb4
function init() {
    level flag::init(#"hash_26c0c05d0a3e382f");
    if (!getdvarint(#"zm_ee_enabled", 0)) {
        return;
    }
    level.var_b7402c = spawnstruct();
    level.var_b7402c.var_7ba06a5e = 0;
    callback::on_ai_killed(&function_df118efe);
    level thread function_e6e821ec();
}

// Namespace namespace_c831ca5c/zm_towers_side_quests
// Params 0, eflags: 0x0
// Checksum 0x9a83b6ba, Offset: 0x160
// Size: 0x50
function function_df118efe() {
    str_zone = zm_zonemgr::get_zone_from_position(self.origin);
    if (str_zone === "zone_zeus_basement") {
        level notify(#"bloodbath_kill");
    }
}

// Namespace namespace_c831ca5c/zm_towers_side_quests
// Params 0, eflags: 0x0
// Checksum 0x42995faf, Offset: 0x1b8
// Size: 0xc0
function function_e6e821ec() {
    level endon(#"end_game", #"hash_26c0c05d0a3e382f");
    while (true) {
        level waittill(#"bloodbath_kill");
        level.var_b7402c.var_7ba06a5e++;
        if (level.var_b7402c.var_7ba06a5e >= 831) {
            level flag::set(#"hash_26c0c05d0a3e382f");
            callback::remove_on_ai_killed(&function_df118efe);
        }
    }
}

