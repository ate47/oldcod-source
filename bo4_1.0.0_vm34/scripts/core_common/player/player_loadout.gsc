#using scripts\core_common\util_shared;

#namespace loadout;

// Namespace loadout/player_loadout
// Params 0, eflags: 0x0
// Checksum 0xd8ab7d92, Offset: 0xb8
// Size: 0x10c
function function_fbd52c88() {
    if (!isdefined(self.pers[#"loadout"])) {
        self.pers[#"loadout"] = spawnstruct();
    }
    self init_loadout_slot("primary");
    self init_loadout_slot("secondary");
    self init_loadout_slot("herogadget");
    self init_loadout_slot("ultimate");
    self init_loadout_slot("primarygrenade");
    self init_loadout_slot("specialgrenade");
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x0
// Checksum 0xd8ad57fa, Offset: 0x1d0
// Size: 0x92
function init_loadout_slot(slot_index) {
    self.pers[#"loadout"].slots[slot_index] = {#slot:slot_index, #weapon:level.weaponnone, #var_e87c20da:level.weaponnone, #count:0, #killed:0};
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x0
// Checksum 0x254695a5, Offset: 0x270
// Size: 0x50
function get_loadout_slot(slot_index) {
    if (isdefined(self.pers[#"loadout"])) {
        return self.pers[#"loadout"].slots[slot_index];
    }
    return undefined;
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x0
// Checksum 0xff0baaa1, Offset: 0x2c8
// Size: 0xa0
function function_4fc5e765(weapon) {
    foreach (slot, slot_index in self.pers[#"loadout"].slots) {
        if (slot.weapon == weapon) {
            return slot_index;
        }
    }
    return undefined;
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x0
// Checksum 0x3eb78fd8, Offset: 0x370
// Size: 0xc0
function find_loadout_slot(weapon) {
    if (isdefined(self.pers[#"loadout"])) {
        foreach (slot in self.pers[#"loadout"].slots) {
            if (slot.weapon == weapon) {
                return slot;
            }
        }
    }
    return undefined;
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x0
// Checksum 0x68a7d976, Offset: 0x438
// Size: 0x8e
function function_3d8b02a0(slot_index) {
    if (isdefined(self.pers[#"loadout"])) {
        assert(isdefined(self.pers[#"loadout"].slots[slot_index]));
        return self.pers[#"loadout"].slots[slot_index].weapon;
    }
    return undefined;
}

// Namespace loadout/player_loadout
// Params 2, eflags: 0x0
// Checksum 0xb068b9b, Offset: 0x4d0
// Size: 0xbe
function function_51315abd(slot_index, weapon) {
    assert(isdefined(self.pers[#"loadout"].slots[slot_index]));
    assert(isplayer(self));
    assert(isdefined(weapon));
    self.pers[#"loadout"].slots[slot_index].weapon = weapon;
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x0
// Checksum 0x16d682d8, Offset: 0x598
// Size: 0x8a
function gadget_is_in_use(slot_index) {
    player = self;
    weapon = function_3d8b02a0(slot_index);
    if (!isdefined(weapon)) {
        return 0;
    }
    slot = player gadgetgetslot(weapon);
    active = player util::gadget_is_in_use(slot);
    return active;
}

