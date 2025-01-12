#using scripts\abilities\ability_player;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;

#namespace hero_weapon;

// Namespace hero_weapon/gadget_hero_weapon
// Params 0, eflags: 0x6
// Checksum 0x754415ee, Offset: 0xa8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"gadget_hero_weapon", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace hero_weapon/gadget_hero_weapon
// Params 0, eflags: 0x5 linked
// Checksum 0x73231ba0, Offset: 0xf0
// Size: 0xc4
function private function_70a657d8() {
    ability_player::register_gadget_activation_callbacks(11, &gadget_hero_weapon_on_activate, &gadget_hero_weapon_on_off);
    ability_player::register_gadget_possession_callbacks(11, &gadget_hero_weapon_on_give, &gadget_hero_weapon_on_take);
    ability_player::register_gadget_is_inuse_callbacks(11, &gadget_hero_weapon_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(11, &gadget_hero_weapon_is_flickering);
    ability_player::register_gadget_ready_callbacks(11, &gadget_hero_weapon_ready);
}

// Namespace hero_weapon/gadget_hero_weapon
// Params 1, eflags: 0x1 linked
// Checksum 0x72e4b085, Offset: 0x1c0
// Size: 0x22
function gadget_hero_weapon_is_inuse(slot) {
    return self gadgetisactive(slot);
}

// Namespace hero_weapon/gadget_hero_weapon
// Params 1, eflags: 0x1 linked
// Checksum 0x1aab68d3, Offset: 0x1f0
// Size: 0x22
function gadget_hero_weapon_is_flickering(slot) {
    return self gadgetflickering(slot);
}

// Namespace hero_weapon/gadget_hero_weapon
// Params 2, eflags: 0x1 linked
// Checksum 0xc3119718, Offset: 0x220
// Size: 0x1b4
function gadget_hero_weapon_on_give(slot, weapon) {
    if (!isdefined(self.pers[#"held_hero_weapon_ammo_count"])) {
        self.pers[#"held_hero_weapon_ammo_count"] = [];
    }
    if (weapon.gadget_power_consume_on_ammo_use || weapon.var_bec5136b || !isdefined(self.pers[#"held_hero_weapon_ammo_count"][weapon])) {
        self.pers[#"held_hero_weapon_ammo_count"][weapon] = 0;
    }
    self setweaponammoclip(weapon, self.pers[#"held_hero_weapon_ammo_count"][weapon]);
    n_ammo = self getammocount(weapon);
    if (n_ammo > 0) {
        stock = self.pers[#"held_hero_weapon_ammo_count"][weapon] - n_ammo;
        if (stock > 0 && !weapon.iscliponly) {
            self setweaponammostock(weapon, stock);
        }
        self hero_handle_ammo_save(slot, weapon);
        return;
    }
    self gadgetcharging(slot, 1);
}

// Namespace hero_weapon/gadget_hero_weapon
// Params 2, eflags: 0x1 linked
// Checksum 0xa7f65616, Offset: 0x3e0
// Size: 0x14
function gadget_hero_weapon_on_take(*slot, *weapon) {
    
}

// Namespace hero_weapon/gadget_hero_weapon
// Params 2, eflags: 0x1 linked
// Checksum 0xcf83f4ff, Offset: 0x400
// Size: 0x94
function gadget_hero_weapon_on_activate(slot, weapon) {
    self.heavyweaponkillcount = 0;
    self.heavyweaponshots = 0;
    self.heavyweaponhits = 0;
    self notify(#"hero_weapon_active");
    if (function_de324246(slot, weapon)) {
        self hero_give_ammo(slot, weapon);
        self hero_handle_ammo_save(slot, weapon);
    }
}

// Namespace hero_weapon/gadget_hero_weapon
// Params 2, eflags: 0x1 linked
// Checksum 0x28bcb595, Offset: 0x4a0
// Size: 0x6c
function gadget_hero_weapon_on_off(*slot, weapon) {
    self setweaponammoclip(weapon, 0);
    if (isalive(self) && isdefined(level.playgadgetoff)) {
        self [[ level.playgadgetoff ]](weapon);
    }
}

// Namespace hero_weapon/gadget_hero_weapon
// Params 2, eflags: 0x1 linked
// Checksum 0x83d0d09d, Offset: 0x518
// Size: 0x44
function gadget_hero_weapon_ready(slot, weapon) {
    if (function_98056dc4(slot, weapon)) {
        hero_give_ammo(slot, weapon);
    }
}

// Namespace hero_weapon/gadget_hero_weapon
// Params 2, eflags: 0x1 linked
// Checksum 0x9d51ccb6, Offset: 0x568
// Size: 0x16
function function_de324246(*slot, *weapon) {
    return false;
}

// Namespace hero_weapon/gadget_hero_weapon
// Params 2, eflags: 0x1 linked
// Checksum 0xba46511, Offset: 0x588
// Size: 0x2c
function function_98056dc4(*slot, weapon) {
    return weapon.gadget_power_consume_on_ammo_use || weapon.var_bec5136b;
}

// Namespace hero_weapon/gadget_hero_weapon
// Params 2, eflags: 0x1 linked
// Checksum 0x91cf2216, Offset: 0x5c0
// Size: 0x4c
function hero_give_ammo(*slot, weapon) {
    self givemaxammo(weapon);
    self setweaponammoclip(weapon, weapon.clipsize);
}

// Namespace hero_weapon/gadget_hero_weapon
// Params 2, eflags: 0x1 linked
// Checksum 0x522689b, Offset: 0x618
// Size: 0x74
function hero_handle_ammo_save(slot, weapon) {
    self thread hero_wait_for_out_of_ammo(slot, weapon);
    self thread hero_wait_for_death(slot, weapon);
    self callback::function_d8abfc3d(#"on_end_game", &on_end_game);
}

// Namespace hero_weapon/gadget_hero_weapon
// Params 2, eflags: 0x1 linked
// Checksum 0xd0bdf62, Offset: 0x698
// Size: 0x4c
function on_end_game(slot, weapon) {
    if (isalive(self)) {
        self hero_save_ammo(slot, weapon);
    }
}

// Namespace hero_weapon/gadget_hero_weapon
// Params 2, eflags: 0x1 linked
// Checksum 0xa6ad3470, Offset: 0x6f0
// Size: 0xbc
function hero_wait_for_death(slot, weapon) {
    self endon(#"disconnect");
    self endon(#"give_map");
    self notify(#"hero_ondeath");
    self endon(#"hero_ondeath");
    self waittill(#"death");
    gadgetslot = self gadgetgetslot(weapon);
    if (gadgetslot != slot) {
        return;
    }
    self hero_save_ammo(slot, weapon);
}

// Namespace hero_weapon/gadget_hero_weapon
// Params 2, eflags: 0x1 linked
// Checksum 0x6568d330, Offset: 0x7b8
// Size: 0x4e
function hero_save_ammo(*slot, weapon) {
    if (isdefined(weapon)) {
        self.pers[#"held_hero_weapon_ammo_count"][weapon] = self getammocount(weapon);
    }
}

// Namespace hero_weapon/gadget_hero_weapon
// Params 2, eflags: 0x1 linked
// Checksum 0xa57522a0, Offset: 0x810
// Size: 0x11c
function hero_wait_for_out_of_ammo(slot, weapon) {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"give_map");
    self notify(#"hero_noammo");
    self endon(#"hero_noammo");
    while (true) {
        wait 0.1;
        gadgetslot = self gadgetgetslot(weapon);
        if (gadgetslot != slot) {
            return;
        }
        n_ammo = self getammocount(weapon);
        if (n_ammo == 0) {
            break;
        }
    }
    self gadgetpowerreset(slot);
    self gadgetcharging(slot, 1);
}

// Namespace hero_weapon/gadget_hero_weapon
// Params 3, eflags: 0x0
// Checksum 0xf3e729af, Offset: 0x938
// Size: 0xb4
function set_gadget_hero_weapon_status(weapon, status, time) {
    timestr = "";
    if (isdefined(time)) {
        timestr = "^3" + ", time: " + time;
    }
    if (getdvarint(#"scr_cpower_debug_prints", 0) > 0) {
        self iprintlnbold("Hero Weapon " + weapon.name + ": " + status + timestr);
    }
}
