#using scripts\core_common\ai\systems\ai_interface;
#using scripts\zm\ai\zm_ai_ghost;

#namespace zm_ai_ghost_interface;

// Namespace zm_ai_ghost_interface/zm_ai_ghost_interface
// Params 0, eflags: 0x0
// Checksum 0xc9b4628d, Offset: 0x88
// Size: 0x4c
function function_673ef04a() {
    ai::registermatchedinterface("ghost", "run", 0, array(1, 0), &zm_ai_ghost::function_e30271);
}

