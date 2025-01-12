#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/visionset_mgr_shared;

#namespace gadget_hero_weapon;

// Namespace gadget_hero_weapon/gadget_hero_weapon
// Params 0, eflags: 0x2
// Checksum 0xdadf75cb, Offset: 0x280
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_hero_weapon", &__init__, undefined, undefined);
}

// Namespace gadget_hero_weapon/gadget_hero_weapon
// Params 0, eflags: 0x0
// Checksum 0xd64cc7f, Offset: 0x2c0
// Size: 0xe4
function __init__() {
    ability_player::register_gadget_activation_callbacks(14, &gadget_hero_weapon_on_activate, &gadget_hero_weapon_on_off);
    ability_player::register_gadget_possession_callbacks(14, &gadget_hero_weapon_on_give, &gadget_hero_weapon_on_take);
    ability_player::register_gadget_flicker_callbacks(14, &function_967bd520);
    ability_player::register_gadget_is_inuse_callbacks(14, &gadget_hero_weapon_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(14, &gadget_hero_weapon_is_flickering);
    ability_player::register_gadget_ready_callbacks(14, &gadget_hero_weapon_ready);
}

// Namespace gadget_hero_weapon/gadget_hero_weapon
// Params 1, eflags: 0x0
// Checksum 0x7fbf6f7d, Offset: 0x3b0
// Size: 0x22
function gadget_hero_weapon_is_inuse(slot) {
    return self gadgetisactive(slot);
}

// Namespace gadget_hero_weapon/gadget_hero_weapon
// Params 1, eflags: 0x0
// Checksum 0xea8dbd58, Offset: 0x3e0
// Size: 0x22
function gadget_hero_weapon_is_flickering(slot) {
    return self gadgetflickering(slot);
}

// Namespace gadget_hero_weapon/gadget_hero_weapon
// Params 2, eflags: 0x0
// Checksum 0x22314123, Offset: 0x410
// Size: 0x14
function function_967bd520(slot, weapon) {
    
}

// Namespace gadget_hero_weapon/gadget_hero_weapon
// Params 2, eflags: 0x0
// Checksum 0x9b725f4d, Offset: 0x430
// Size: 0x194
function gadget_hero_weapon_on_give(slot, weapon) {
    if (!isdefined(self.pers["held_hero_weapon_ammo_count"])) {
        self.pers["held_hero_weapon_ammo_count"] = [];
    }
    if (weapon.gadget_power_consume_on_ammo_use || !isdefined(self.pers["held_hero_weapon_ammo_count"][weapon])) {
        self.pers["held_hero_weapon_ammo_count"][weapon] = 0;
    }
    self setweaponammoclip(weapon, self.pers["held_hero_weapon_ammo_count"][weapon]);
    n_ammo = self getammocount(weapon);
    if (n_ammo > 0) {
        stock = self.pers["held_hero_weapon_ammo_count"][weapon] - n_ammo;
        if (stock > 0 && !weapon.iscliponly) {
            self setweaponammostock(weapon, stock);
        }
        self hero_handle_ammo_save(slot, weapon);
        return;
    }
    self gadgetcharging(slot, 1);
}

// Namespace gadget_hero_weapon/gadget_hero_weapon
// Params 2, eflags: 0x0
// Checksum 0x5cda1046, Offset: 0x5d0
// Size: 0x14
function gadget_hero_weapon_on_take(slot, weapon) {
    
}

// Namespace gadget_hero_weapon/gadget_hero_weapon
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x5f0
// Size: 0x4
function function_fb88e576() {
    
}

// Namespace gadget_hero_weapon/gadget_hero_weapon
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x600
// Size: 0x4
function function_c4a7cc89() {
    
}

// Namespace gadget_hero_weapon/gadget_hero_weapon
// Params 2, eflags: 0x0
// Checksum 0xd034419b, Offset: 0x610
// Size: 0x84
function gadget_hero_weapon_on_activate(slot, weapon) {
    self.heavyweaponkillcount = 0;
    self.heavyweaponshots = 0;
    self.heavyweaponhits = 0;
    if (!weapon.gadget_power_consume_on_ammo_use) {
        self hero_give_ammo(slot, weapon);
        self hero_handle_ammo_save(slot, weapon);
    }
}

// Namespace gadget_hero_weapon/gadget_hero_weapon
// Params 2, eflags: 0x0
// Checksum 0x2daef9e6, Offset: 0x6a0
// Size: 0x88
function gadget_hero_weapon_on_off(slot, weapon) {
    if (weapon.gadget_power_consume_on_ammo_use) {
        self setweaponammoclip(weapon, 0);
    }
    if (isalive(self) && isdefined(level.playgadgetoff)) {
        self [[ level.playgadgetoff ]](weapon);
    }
}

// Namespace gadget_hero_weapon/gadget_hero_weapon
// Params 2, eflags: 0x0
// Checksum 0x1b676bbd, Offset: 0x730
// Size: 0x44
function gadget_hero_weapon_ready(slot, weapon) {
    if (weapon.gadget_power_consume_on_ammo_use) {
        hero_give_ammo(slot, weapon);
    }
}

// Namespace gadget_hero_weapon/gadget_hero_weapon
// Params 2, eflags: 0x0
// Checksum 0x2077e7f9, Offset: 0x780
// Size: 0x54
function hero_give_ammo(slot, weapon) {
    self givemaxammo(weapon);
    self setweaponammoclip(weapon, weapon.clipsize);
}

// Namespace gadget_hero_weapon/gadget_hero_weapon
// Params 2, eflags: 0x0
// Checksum 0xafef6a4, Offset: 0x7e0
// Size: 0x74
function hero_handle_ammo_save(slot, weapon) {
    self thread hero_wait_for_out_of_ammo(slot, weapon);
    self thread function_20226d3a(slot, weapon);
    self thread hero_wait_for_death(slot, weapon);
}

// Namespace gadget_hero_weapon/gadget_hero_weapon
// Params 2, eflags: 0x0
// Checksum 0xebab827f, Offset: 0x860
// Size: 0x84
function function_20226d3a(slot, weapon) {
    self endon(#"disconnect");
    self notify(#"hash_8e221e2c");
    self endon(#"hash_8e221e2c");
    level waittill("game_ended");
    if (isalive(self)) {
        self hero_save_ammo(slot, weapon);
    }
}

// Namespace gadget_hero_weapon/gadget_hero_weapon
// Params 2, eflags: 0x0
// Checksum 0xa9716e3f, Offset: 0x8f0
// Size: 0x64
function hero_wait_for_death(slot, weapon) {
    self endon(#"disconnect");
    self notify(#"hero_ondeath");
    self endon(#"hero_ondeath");
    self waittill("death");
    self hero_save_ammo(slot, weapon);
}

// Namespace gadget_hero_weapon/gadget_hero_weapon
// Params 2, eflags: 0x0
// Checksum 0x9d4adeb0, Offset: 0x960
// Size: 0x44
function hero_save_ammo(slot, weapon) {
    self.pers["held_hero_weapon_ammo_count"][weapon] = self getammocount(weapon);
}

// Namespace gadget_hero_weapon/gadget_hero_weapon
// Params 2, eflags: 0x0
// Checksum 0xd0f9b58a, Offset: 0x9b0
// Size: 0xcc
function hero_wait_for_out_of_ammo(slot, weapon) {
    self endon(#"disconnect");
    self endon(#"death");
    self notify(#"hero_noammo");
    self endon(#"hero_noammo");
    while (true) {
        wait 0.1;
        n_ammo = self getammocount(weapon);
        if (n_ammo == 0) {
            break;
        }
    }
    self gadgetpowerreset(slot);
    self gadgetcharging(slot, 1);
}

// Namespace gadget_hero_weapon/gadget_hero_weapon
// Params 3, eflags: 0x0
// Checksum 0xde7ba09f, Offset: 0xa88
// Size: 0xb4
function set_gadget_hero_weapon_status(weapon, status, time) {
    timestr = "";
    if (isdefined(time)) {
        timestr = "^3" + ", time: " + time;
    }
    if (getdvarint("scr_cpower_debug_prints") > 0) {
        self iprintlnbold("Hero Weapon " + weapon.name + ": " + status + timestr);
    }
}

