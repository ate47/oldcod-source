#using script_3fbe90dd521a8e2d;
#using script_5f261a5d57de5f7c;
#using scripts\core_common\aat_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\item_inventory;

#namespace ammomod_electriccherry;

// Namespace ammomod_electriccherry/ammomod_electriccherry
// Params 0, eflags: 0x1 linked
// Checksum 0x18ca6e28, Offset: 0x118
// Size: 0xac
function function_4b66248d() {
    if (!is_true(level.aat_in_use)) {
        return;
    }
    aat::register("ammomod_electriccherry", 0.1, 0, 5, 5, 1, &result, "t7_hud_zm_aat_deadwire", "wpn_aat_dead_wire_plr", undefined, #"electrical");
    clientfield::register("allplayers", "ammomod_electric_cherry_explode", 1, 1, "counter");
}

// Namespace ammomod_electriccherry/ammomod_electriccherry
// Params 5, eflags: 0x1 linked
// Checksum 0xbf4fcf77, Offset: 0x1d0
// Size: 0x2c
function result(*death, *attacker, *mod, *weapon, *vpoint) {
    
}

// Namespace ammomod_electriccherry/reload
// Params 1, eflags: 0x40
// Checksum 0xf425060a, Offset: 0x208
// Size: 0x84
function event_handler[reload] function_b4174270(*eventstruct) {
    weapon = self getcurrentweapon();
    item = item_inventory::function_230ceec4(weapon);
    if (item.var_a6762160.var_b079a6e6 === #"ammomod_electriccherry") {
        self function_aa4171b9();
    }
}

// Namespace ammomod_electriccherry/ammomod_electriccherry
// Params 0, eflags: 0x1 linked
// Checksum 0x15331544, Offset: 0x298
// Size: 0x17c
function function_aa4171b9() {
    self clientfield::increment("ammomod_electric_cherry_explode", 1);
    s_params = level.var_7659ca85;
    n_range = self namespace_e86ffa8::function_cd6787b(2) ? 512 : 256;
    a_zombies = getentitiesinradius(self.origin, n_range, 15);
    count = 0;
    foreach (e_zombie in a_zombies) {
        if (count >= 30) {
            return;
        }
        if (e_zombie == self) {
            continue;
        }
        if (e_zombie.var_6f84b820 === #"elite") {
            continue;
        }
        e_zombie ammomod_deadwire::function_de99f2ad(self, e_zombie, s_params, 5);
        count++;
    }
}

