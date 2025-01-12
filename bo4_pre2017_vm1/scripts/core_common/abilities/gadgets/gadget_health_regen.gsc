#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace gadget_health_regen;

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x2
// Checksum 0xff41eb45, Offset: 0x278
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_health_regen", &__init__, undefined, undefined);
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x0
// Checksum 0xbc352917, Offset: 0x2b8
// Size: 0xe4
function __init__() {
    ability_player::register_gadget_activation_callbacks(54, &gadget_health_regen_on, &gadget_health_regen_off);
    ability_player::register_gadget_possession_callbacks(54, &gadget_health_regen_on_give, &gadget_health_regen_on_take);
    ability_player::register_gadget_flicker_callbacks(54, &gadget_health_regen_on_flicker);
    ability_player::register_gadget_is_inuse_callbacks(54, &gadget_health_regen_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(54, &gadget_health_regen_is_flickering);
    callback::on_spawned(&on_player_spawned);
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 1, eflags: 0x0
// Checksum 0x301536f7, Offset: 0x3a8
// Size: 0x22
function gadget_health_regen_is_inuse(slot) {
    return self gadgetisactive(slot);
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 1, eflags: 0x0
// Checksum 0x5261c0f4, Offset: 0x3d8
// Size: 0x22
function gadget_health_regen_is_flickering(slot) {
    return self gadgetflickering(slot);
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 2, eflags: 0x0
// Checksum 0x8fe5e808, Offset: 0x408
// Size: 0x14
function gadget_health_regen_on_flicker(slot, weapon) {
    
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 2, eflags: 0x0
// Checksum 0x1c81b59b, Offset: 0x428
// Size: 0x5c
function gadget_health_regen_on_give(slot, weapon) {
    self.has_gadget_health_regen = 1;
    self.gadget_health_regen_slot = slot;
    weapon.ignore_grenade = 1;
    self thread watch_player_damage_taken();
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 2, eflags: 0x0
// Checksum 0x1968c150, Offset: 0x490
// Size: 0x36
function gadget_health_regen_on_take(slot, weapon) {
    self.has_gadget_health_regen = 0;
    self.gadget_health_regen_slot = undefined;
    self notify(#"gadget_health_regen_taken");
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x0
// Checksum 0x1c86c67, Offset: 0x4d0
// Size: 0x34
function on_player_spawned() {
    self disable_healing();
    self thread temp_watch_gadget_power_workaround();
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 2, eflags: 0x0
// Checksum 0x38e0cf93, Offset: 0x510
// Size: 0x2c
function gadget_health_regen_on(slot, weapon) {
    self thread enable_healing_after_wait();
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 2, eflags: 0x0
// Checksum 0xb2943919, Offset: 0x548
// Size: 0x2c
function gadget_health_regen_off(slot, weapon) {
    self disable_healing();
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x0
// Checksum 0x54bb76d1, Offset: 0x580
// Size: 0x7c
function enable_healing_after_wait() {
    self notify(#"healing_preamble");
    waitresult = self waittilltimeout(0.5, "death", "disconnect", "healing_disabled", "healing_preamble");
    if (waitresult._notify != "timeout") {
        return;
    }
    self enable_healing();
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x0
// Checksum 0xe0568f49, Offset: 0x608
// Size: 0x2c
function enable_healing() {
    self.healing_enabled = 1;
    self thread watch_full_health();
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x0
// Checksum 0x1d29a605, Offset: 0x640
// Size: 0x34
function disable_healing() {
    self.healing_enabled = 0;
    self notify(#"healing_disabled");
    self update_gadget_power();
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x0
// Checksum 0xf1685901, Offset: 0x680
// Size: 0x14
function has_gadget_health_regen() {
    return self.has_gadget_health_regen === 1;
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x0
// Checksum 0x36a48f0d, Offset: 0x6a0
// Size: 0x32
function is_regen_active() {
    if (!self has_gadget_health_regen()) {
        return 0;
    }
    return self secondaryoffhandbuttonpressed();
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x0
// Checksum 0x1ccbf030, Offset: 0x6e0
// Size: 0xa4
function watch_full_health() {
    waitresult = self waittill("fully_healed", "death", "disconnect", "healing_disabled");
    if (waitresult._notify != "fully_healed") {
        return;
    }
    if (isdefined(self)) {
        if (self is_regen_active()) {
            self playsoundtoplayer("mpl_full_health_plr", self);
        }
        self update_gadget_power();
    }
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x0
// Checksum 0x78785ac3, Offset: 0x790
// Size: 0x90
function watch_player_damage_taken() {
    while (true) {
        waitresult = self waittill("damage", "death", "disconnect", "gadget_health_regen_taken");
        if (waitresult._notify != "damage") {
            return;
        }
        if (!isdefined(self)) {
            return;
        }
        if (!isdefined(self.gadget_health_regen_slot)) {
            continue;
        }
        self update_gadget_power();
    }
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x0
// Checksum 0xbd103853, Offset: 0x828
// Size: 0x5c
function update_gadget_power() {
    if (!isdefined(self)) {
        return;
    }
    if (isdefined(self.gadget_health_regen_slot)) {
        self gadgetpowerset(self.gadget_health_regen_slot, self.health < self.maxhealth ? 100 : 0);
    }
}

// Namespace gadget_health_regen/gadget_health_regen
// Params 0, eflags: 0x0
// Checksum 0x551bde9a, Offset: 0x890
// Size: 0x146
function temp_watch_gadget_power_workaround() {
    self notify(#"TEMP_watch_gadget_power_workaround_singleton");
    while (true) {
        if (!isdefined(self)) {
            return;
        }
        if (isdefined(self.gadget_health_regen_slot)) {
            current_power = self gadgetpowerget(self.gadget_health_regen_slot);
            if (self.health < self.maxhealth && current_power != 100) {
                self gadgetpowerset(self.gadget_health_regen_slot, 100);
            } else if (self.health == self.maxhealth && current_power != 0) {
                self gadgetpowerset(self.gadget_health_regen_slot, 0);
            }
        }
        waitresult = self waittilltimeout(0.25, "TEMP_watch_gadget_power_workaround_singleton", "death", "disconnect");
        if (waitresult._notify != "timeout") {
            return;
        }
    }
}

