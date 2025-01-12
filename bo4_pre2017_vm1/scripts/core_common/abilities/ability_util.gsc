#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_power;
#using scripts/core_common/util_shared;

#namespace ability_util;

// Namespace ability_util/ability_util
// Params 2, eflags: 0x0
// Checksum 0x3dd9d9d2, Offset: 0x180
// Size: 0x4c
function gadget_is_type(slot, type) {
    if (!isdefined(self._gadgets_player[slot])) {
        return false;
    }
    return self._gadgets_player[slot].gadget_type == type;
}

// Namespace ability_util/ability_util
// Params 1, eflags: 0x0
// Checksum 0xdccc4a77, Offset: 0x1d8
// Size: 0x76
function gadget_slot_for_type(type) {
    invalid = 4;
    for (i = 0; i < 4; i++) {
        if (!self gadget_is_type(i, type)) {
            continue;
        }
        return i;
    }
    return invalid;
}

// Namespace ability_util/ability_util
// Params 0, eflags: 0x0
// Checksum 0xd0b5a7a8, Offset: 0x258
// Size: 0x1a
function function_7bf047db() {
    return gadget_is_active(2);
}

// Namespace ability_util/ability_util
// Params 0, eflags: 0x0
// Checksum 0x1a3873a9, Offset: 0x280
// Size: 0x22
function gadget_combat_efficiency_enabled() {
    if (isdefined(self._gadget_combat_efficiency)) {
        return self._gadget_combat_efficiency;
    }
    return 0;
}

// Namespace ability_util/ability_util
// Params 1, eflags: 0x0
// Checksum 0x2293484f, Offset: 0x2b0
// Size: 0x94
function gadget_combat_efficiency_power_drain(score) {
    powerchange = -1 * score * getdvarfloat("scr_combat_efficiency_power_loss_scalar", 0.275);
    slot = gadget_slot_for_type(15);
    if (slot != 4) {
        self gadgetpowerchange(slot, powerchange);
    }
}

// Namespace ability_util/ability_util
// Params 0, eflags: 0x0
// Checksum 0x62a673b6, Offset: 0x350
// Size: 0x66
function function_625fb64c() {
    slot = self gadget_slot_for_type(2);
    if (slot >= 0 && slot < 4) {
        if (self ability_player::gadget_is_flickering(slot)) {
            return true;
        }
    }
    return false;
}

// Namespace ability_util/ability_util
// Params 0, eflags: 0x0
// Checksum 0x8c5dad1a, Offset: 0x3c0
// Size: 0x1a
function function_db4e8ae0() {
    return gadget_is_active(5);
}

// Namespace ability_util/ability_util
// Params 1, eflags: 0x0
// Checksum 0x9477bb3e, Offset: 0x3e8
// Size: 0x96
function is_weapon_gadget(weapon) {
    foreach (var_493ae09d, var_1ca59e0d in level._gadgets_level) {
        if (var_493ae09d == weapon) {
            return true;
        }
    }
    return false;
}

// Namespace ability_util/ability_util
// Params 1, eflags: 0x0
// Checksum 0x576d6d48, Offset: 0x488
// Size: 0x84
function gadget_power_reset(gadgetweapon) {
    slot = self gadgetgetslot(gadgetweapon);
    if (slot >= 0 && slot < 4) {
        self gadgetpowerreset(slot);
        self gadgetcharging(slot, 1);
    }
}

// Namespace ability_util/ability_util
// Params 1, eflags: 0x0
// Checksum 0x10495d4d, Offset: 0x518
// Size: 0x7c
function function_aa8c40c1(gadgetweapon) {
    slot = self gadgetgetslot(gadgetweapon);
    if (slot >= 0 && slot < 4) {
        self gadgetpowerset(slot, 100);
        self gadgetcharging(slot, 0);
    }
}

// Namespace ability_util/ability_util
// Params 4, eflags: 0x0
// Checksum 0x20cb694b, Offset: 0x5a0
// Size: 0x354
function gadget_reset(gadgetweapon, changedclass, roundbased, firstround) {
    if (getdvarint("gadgetEnabled") == 0) {
        return;
    }
    slot = self gadgetgetslot(gadgetweapon);
    if (slot >= 0 && slot < 4) {
        if (isdefined(self.pers["held_gadgets_power"]) && isdefined(self.pers["held_gadgets_power"][gadgetweapon])) {
            self gadgetpowerset(slot, self.pers["held_gadgets_power"][gadgetweapon]);
        } else if (isdefined(self.pers["held_gadgets_power"]) && isdefined(self.pers[#"hash_c35f137f"]) && isdefined(self.pers["held_gadgets_power"][self.pers[#"hash_c35f137f"]])) {
            self gadgetpowerset(slot, self.pers["held_gadgets_power"][self.pers[#"hash_c35f137f"]]);
        } else if (isdefined(self.pers["held_gadgets_power"]) && isdefined(self.pers[#"hash_65987563"]) && isdefined(self.pers["held_gadgets_power"][self.pers[#"hash_65987563"]])) {
            self gadgetpowerset(slot, self.pers["held_gadgets_power"][self.pers[#"hash_65987563"]]);
        }
        resetonclasschange = changedclass && gadgetweapon.gadget_power_reset_on_class_change;
        resetonfirstround = !roundbased || !isdefined(self.firstspawn) && firstround;
        resetonroundswitch = !isdefined(self.firstspawn) && roundbased && !firstround && gadgetweapon.gadget_power_reset_on_round_switch;
        resetonteamchanged = isdefined(self.switchedteamsresetgadgets) && isdefined(self.firstspawn) && self.switchedteamsresetgadgets && gadgetweapon.gadget_power_reset_on_team_change;
        resetonroundswitch = 0;
        if (resetonclasschange || resetonfirstround || resetonroundswitch || resetonteamchanged) {
            self gadgetpowerreset(slot);
            self gadgetcharging(slot, 1);
        }
    }
}

// Namespace ability_util/ability_util
// Params 0, eflags: 0x0
// Checksum 0x216abffa, Offset: 0x900
// Size: 0x1a
function gadget_power_armor_on() {
    return gadget_is_active(4);
}

// Namespace ability_util/ability_util
// Params 1, eflags: 0x0
// Checksum 0xd99502aa, Offset: 0x928
// Size: 0x6e
function gadget_is_active(gadgettype) {
    slot = self gadget_slot_for_type(gadgettype);
    if (slot >= 0 && slot < 4) {
        if (self ability_player::gadget_is_in_use(slot)) {
            return true;
        }
    }
    return false;
}

// Namespace ability_util/ability_util
// Params 1, eflags: 0x0
// Checksum 0x4531fe84, Offset: 0x9a0
// Size: 0x52
function gadget_has_type(gadgettype) {
    slot = self gadget_slot_for_type(gadgettype);
    if (slot >= 0 && slot < 4) {
        return true;
    }
    return false;
}

// Namespace ability_util/ability_util
// Params 2, eflags: 0x0
// Checksum 0x8e7643b4, Offset: 0xa00
// Size: 0x384
function aoe_friendlies(weapon, aoe) {
    self endon(#"disconnect");
    self endon(aoe.aoe_think_singleton_event);
    start_time = gettime();
    end_time = start_time + aoe.duration;
    if (!isdefined(self) || !isdefined(self.team)) {
        return;
    }
    profile_script = getdvarint("scr_profile_aoe", 0);
    if (profile_script) {
        profile_start_time = util::get_start_time();
        profile_elapsed_times = [];
        extra_profile_time = 1000;
        end_time += extra_profile_time;
    }
    has_reapply_check = isdefined(aoe.check_reapply_time_func);
    aoe_team = self.team;
    aoe_applied = 0;
    while (gettime() < end_time || aoe_applied > 0) {
        radius = (gettime() - start_time) / aoe.duration * weapon.gadget_cleanse_radius;
        aoe_applied = 0;
        if (isdefined(self) && isdefined(self.origin)) {
            aoe_origin = self.origin;
        }
        friendlies_in_radius = getplayers(aoe_team, aoe_origin, radius);
        foreach (player in friendlies_in_radius) {
            if (has_reapply_check && player [[ aoe.check_reapply_time_func ]](aoe)) {
                continue;
            }
            if (!isalive(player)) {
                continue;
            }
            if ([[ aoe.can_apply_aoe_func ]](player, weapon, aoe)) {
                [[ aoe.apply_aoe_func ]](player, weapon, aoe);
                aoe_applied++;
                if (aoe_applied >= aoe.max_applies_per_frame) {
                    break;
                }
            }
        }
        if (profile_script) {
            util::record_elapsed_time(profile_start_time, profile_elapsed_times);
            waitframe(1);
            profile_start_time = util::get_start_time();
            continue;
        }
        waitframe(1);
    }
    if (profile_script) {
        util::note_elapsed_times(profile_elapsed_times, "util aoe friendlies");
    }
}

// Namespace ability_util/ability_util
// Params 3, eflags: 0x0
// Checksum 0x77ac8bf8, Offset: 0xd90
// Size: 0xa8
function aoe_trace_entity(entity, aoe, trace_z_offset) {
    entitypoint = entity.origin + (0, 0, trace_z_offset);
    if (!bullettracepassed(aoe.origin, entitypoint, 1, self, undefined, 0, 1)) {
        return false;
    }
    /#
        thread util::draw_debug_line(aoe.origin, entitypoint, 1);
    #/
    return true;
}

