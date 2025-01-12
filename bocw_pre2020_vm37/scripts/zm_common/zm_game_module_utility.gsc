#using scripts\core_common\array_shared;
#using scripts\core_common\struct;

#namespace zm_game_module_utility;

// Namespace zm_game_module_utility/zm_game_module_utility
// Params 1, eflags: 0x0
// Checksum 0x282d857a, Offset: 0x80
// Size: 0x122
function move_ring(ring) {
    positions = struct::get_array(ring.target, "targetname");
    positions = array::randomize(positions);
    level endon(#"end_game");
    while (true) {
        foreach (position in positions) {
            self moveto(position.origin, randomintrange(30, 45));
            self waittill(#"movedone");
        }
    }
}

// Namespace zm_game_module_utility/zm_game_module_utility
// Params 1, eflags: 0x0
// Checksum 0x22615d00, Offset: 0x1b0
// Size: 0x6e
function rotate_ring(forward) {
    level endon(#"end_game");
    dir = -360;
    if (forward) {
        dir = 360;
    }
    while (true) {
        self rotateyaw(dir, 9);
        wait 9;
    }
}

