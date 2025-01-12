#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/visionset_mgr_shared;

#namespace gadget_combat_efficiency;

// Namespace gadget_combat_efficiency/gadget_combat_efficiency
// Params 0, eflags: 0x2
// Checksum 0x6ddc96e6, Offset: 0x298
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_combat_efficiency", &__init__, undefined, undefined);
}

// Namespace gadget_combat_efficiency/gadget_combat_efficiency
// Params 0, eflags: 0x0
// Checksum 0x10a0bfd, Offset: 0x2d8
// Size: 0xe4
function __init__() {
    ability_player::register_gadget_activation_callbacks(15, &gadget_combat_efficiency_on_activate, &gadget_combat_efficiency_on_off);
    ability_player::register_gadget_possession_callbacks(15, &function_ce638c14, &function_c4a4c062);
    ability_player::register_gadget_flicker_callbacks(15, &function_1fb7ea1d);
    ability_player::register_gadget_is_inuse_callbacks(15, &gadget_combat_efficiency_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(15, &gadget_combat_efficiency_is_flickering);
    ability_player::register_gadget_ready_callbacks(15, &gadget_combat_efficiency_ready);
}

// Namespace gadget_combat_efficiency/gadget_combat_efficiency
// Params 1, eflags: 0x0
// Checksum 0xb3cdba25, Offset: 0x3c8
// Size: 0x22
function gadget_combat_efficiency_is_inuse(slot) {
    return self gadgetisactive(slot);
}

// Namespace gadget_combat_efficiency/gadget_combat_efficiency
// Params 1, eflags: 0x0
// Checksum 0xcf8d6f93, Offset: 0x3f8
// Size: 0x22
function gadget_combat_efficiency_is_flickering(slot) {
    return self gadgetflickering(slot);
}

// Namespace gadget_combat_efficiency/gadget_combat_efficiency
// Params 2, eflags: 0x0
// Checksum 0x9bceb172, Offset: 0x428
// Size: 0x14
function function_1fb7ea1d(slot, weapon) {
    
}

// Namespace gadget_combat_efficiency/gadget_combat_efficiency
// Params 2, eflags: 0x0
// Checksum 0x41eb8afa, Offset: 0x448
// Size: 0x14
function function_ce638c14(slot, weapon) {
    
}

// Namespace gadget_combat_efficiency/gadget_combat_efficiency
// Params 2, eflags: 0x0
// Checksum 0x2d23b8c0, Offset: 0x468
// Size: 0x14
function function_c4a4c062(slot, weapon) {
    
}

// Namespace gadget_combat_efficiency/gadget_combat_efficiency
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x488
// Size: 0x4
function function_4efdcefb() {
    
}

// Namespace gadget_combat_efficiency/gadget_combat_efficiency
// Params 0, eflags: 0x0
// Checksum 0x1ea70214, Offset: 0x498
// Size: 0x10
function function_66bfd148() {
    self.combatefficiencylastontime = 0;
}

// Namespace gadget_combat_efficiency/gadget_combat_efficiency
// Params 2, eflags: 0x0
// Checksum 0x90d6a900, Offset: 0x4b0
// Size: 0x48
function gadget_combat_efficiency_on_activate(slot, weapon) {
    self._gadget_combat_efficiency = 1;
    self._gadget_combat_efficiency_success = 0;
    self.scorestreaksearnedperuse = 0;
    self.combatefficiencylastontime = gettime();
}

// Namespace gadget_combat_efficiency/gadget_combat_efficiency
// Params 2, eflags: 0x0
// Checksum 0xed13a6f9, Offset: 0x500
// Size: 0x100
function gadget_combat_efficiency_on_off(slot, weapon) {
    self._gadget_combat_efficiency = 0;
    self.combatefficiencylastontime = gettime();
    self addweaponstat(self.heroability, "scorestreaks_earned_2", int(self.scorestreaksearnedperuse / 2));
    self addweaponstat(self.heroability, "scorestreaks_earned_3", int(self.scorestreaksearnedperuse / 3));
    if (isalive(self) && isdefined(level.playgadgetsuccess)) {
        self [[ level.playgadgetsuccess ]](weapon);
    }
}

// Namespace gadget_combat_efficiency/gadget_combat_efficiency
// Params 2, eflags: 0x0
// Checksum 0xdfe4bbc, Offset: 0x608
// Size: 0x14
function gadget_combat_efficiency_ready(slot, weapon) {
    
}

// Namespace gadget_combat_efficiency/gadget_combat_efficiency
// Params 3, eflags: 0x0
// Checksum 0xae0eca97, Offset: 0x628
// Size: 0xb4
function set_gadget_combat_efficiency_status(weapon, status, time) {
    timestr = "";
    if (isdefined(time)) {
        timestr = "^3" + ", time: " + time;
    }
    if (getdvarint("scr_cpower_debug_prints") > 0) {
        self iprintlnbold("Gadget Combat Efficiency " + weapon.name + ": " + status + timestr);
    }
}

