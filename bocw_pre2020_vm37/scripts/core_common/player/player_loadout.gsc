#using scripts\core_common\util_shared;

#namespace loadout;

// Namespace loadout/player_loadout
// Params 0, eflags: 0x1 linked
// Checksum 0x855d1485, Offset: 0xd8
// Size: 0x78
function function_87bcb1b() {
    if (!isdefined(level.var_d0e6b79d) || level.var_d0e6b79d == 0) {
        return 0;
    }
    if (sessionmodeiswarzonegame()) {
        return is_true(getdvarint(#"hash_613aa8df1f03f054", 1));
    }
    return 1;
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x1 linked
// Checksum 0x4e72a311, Offset: 0x158
// Size: 0x12c
function function_c67222df() {
    if (!isdefined(self.pers[#"loadout"])) {
        self.pers[#"loadout"] = spawnstruct();
    }
    self init_loadout_slot("primary");
    self init_loadout_slot("secondary");
    self init_loadout_slot("herogadget");
    self init_loadout_slot("ultimate");
    self init_loadout_slot("primarygrenade");
    self init_loadout_slot("secondarygrenade");
    self init_loadout_slot("specialgrenade");
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x1 linked
// Checksum 0xe5714465, Offset: 0x290
// Size: 0x90
function init_loadout_slot(slot_index) {
    self.pers[#"loadout"].slots[slot_index] = {#slot:slot_index, #weapon:level.weaponnone, #var_4cfdfa9b:level.weaponnone, #count:0, #killed:0};
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x0
// Checksum 0x7b9f61a0, Offset: 0x328
// Size: 0x50
function get_loadout_slot(slot_index) {
    if (isdefined(self.pers[#"loadout"])) {
        return self.pers[#"loadout"].slots[slot_index];
    }
    return undefined;
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x0
// Checksum 0xf209c2a, Offset: 0x380
// Size: 0xac
function function_8435f729(weapon) {
    foreach (slot, slot_index in self.pers[#"loadout"].slots) {
        if (slot.weapon == weapon) {
            return slot_index;
        }
    }
    return undefined;
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x1 linked
// Checksum 0x9a6ad535, Offset: 0x438
// Size: 0xcc
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
// Params 1, eflags: 0x1 linked
// Checksum 0xa56a4711, Offset: 0x510
// Size: 0xb6
function function_18a77b37(slot_index) {
    if (function_87bcb1b() && isdefined(self) && isdefined(self.pers) && isdefined(self.pers[#"loadout"])) {
        assert(isdefined(self.pers[#"loadout"].slots[slot_index]));
        return self.pers[#"loadout"].slots[slot_index].weapon;
    }
    return undefined;
}

// Namespace loadout/player_loadout
// Params 2, eflags: 0x0
// Checksum 0x5622a631, Offset: 0x5d0
// Size: 0xb6
function function_442539(slot_index, weapon) {
    assert(isdefined(self.pers[#"loadout"].slots[slot_index]));
    assert(isplayer(self));
    assert(isdefined(weapon));
    self.pers[#"loadout"].slots[slot_index].weapon = weapon;
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x0
// Checksum 0x8e8443c9, Offset: 0x690
// Size: 0x8a
function gadget_is_in_use(slot_index) {
    player = self;
    weapon = function_18a77b37(slot_index);
    if (!isdefined(weapon)) {
        return 0;
    }
    slot = player gadgetgetslot(weapon);
    active = player util::gadget_is_in_use(slot);
    return active;
}

