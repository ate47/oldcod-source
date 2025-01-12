#using script_165beea08a63a243;
#using script_1cc417743d7c262d;
#using script_2a30ac7aa0ee8988;
#using script_54f593f5beb1464a;
#using script_655e1025200f4d5b;
#using script_d5e47f3a0e95613;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\item_drop;
#using scripts\core_common\item_inventory;
#using scripts\core_common\item_supply_drop;
#using scripts\core_common\item_world;
#using scripts\core_common\item_world_cleanup;
#using scripts\core_common\item_world_debug;
#using scripts\core_common\load_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\mp_common\util;

#namespace load;

// Namespace load/load
// Params 0, eflags: 0x2
// Checksum 0xe7e332a4, Offset: 0x140
// Size: 0x3c
function autoexec function_aeb1baea() {
    assert(!isdefined(level.var_f18a6bd6));
    level.var_f18a6bd6 = &function_5e443ed1;
}

// Namespace load/load
// Params 0, eflags: 0x1 linked
// Checksum 0x5120d560, Offset: 0x188
// Size: 0x12c
function function_5e443ed1() {
    assert(isdefined(level.first_frame), "<dev string:x38>");
    level._loadstarted = 1;
    /#
        util::check_art_mode();
    #/
    /#
        util::apply_dev_overrides();
    #/
    setclearanceceiling(30);
    register_clientfields();
    level.aitriggerspawnflags = getaitriggerflags();
    level.vehicletriggerspawnflags = getvehicletriggerflags();
    setup_traversals();
    level.globallogic_audio_dialog_on_player_override = &globallogic_audio::leader_dialog_on_player;
    level.growing_hitmarker = 1;
    system::function_c11b0642();
    level flag::set(#"load_main_complete");
}

// Namespace load/load
// Params 0, eflags: 0x1 linked
// Checksum 0x17f2453b, Offset: 0x2c0
// Size: 0xae
function init_traverse() {
    point = getent(self.target, "targetname");
    if (isdefined(point)) {
        self.traverse_height = point.origin[2];
        point delete();
        return;
    }
    point = struct::get(self.target, "targetname");
    if (isdefined(point)) {
        self.traverse_height = point.origin[2];
    }
}

// Namespace load/load
// Params 0, eflags: 0x1 linked
// Checksum 0x22b29f85, Offset: 0x378
// Size: 0x84
function setup_traversals() {
    potential_traverse_nodes = getallnodes();
    for (i = 0; i < potential_traverse_nodes.size; i++) {
        node = potential_traverse_nodes[i];
        if (node.type == #"begin") {
            node init_traverse();
        }
    }
}

// Namespace load/load
// Params 0, eflags: 0x1 linked
// Checksum 0x4e2a42a3, Offset: 0x408
// Size: 0x94
function register_clientfields() {
    clientfield::register("missile", "cf_m_proximity", 1, 1, "int");
    clientfield::register("missile", "cf_m_emp", 1, 1, "int");
    clientfield::register("missile", "cf_m_stun", 1, 1, "int");
}

