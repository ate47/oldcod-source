#using scripts\abilities\ability_player;
#using scripts\core_common\util_shared;

#namespace ability_util;

// Namespace ability_util/ability_util
// Params 2, eflags: 0x0
// Checksum 0xdf52f86, Offset: 0x90
// Size: 0x44
function gadget_is_type(slot, type) {
    if (!isdefined(self._gadgets_player[slot])) {
        return false;
    }
    return self._gadgets_player[slot].gadget_type == type;
}

// Namespace ability_util/ability_util
// Params 1, eflags: 0x0
// Checksum 0x1c4e265a, Offset: 0xe0
// Size: 0x6e
function gadget_slot_for_type(type) {
    invalid = 3;
    for (i = 0; i < 3; i++) {
        if (!self gadget_is_type(i, type)) {
            continue;
        }
        return i;
    }
    return invalid;
}

// Namespace ability_util/ability_util
// Params 0, eflags: 0x0
// Checksum 0xd8d156b2, Offset: 0x158
// Size: 0x1a
function gadget_combat_efficiency_enabled() {
    if (isdefined(self._gadget_combat_efficiency)) {
        return self._gadget_combat_efficiency;
    }
    return 0;
}

// Namespace ability_util/ability_util
// Params 0, eflags: 0x0
// Checksum 0x5873bf76, Offset: 0x180
// Size: 0xb2
function function_955639fe() {
    if (isdefined(self.team)) {
        teammates = getplayers(self.team);
        foreach (player in teammates) {
            if (player gadget_combat_efficiency_enabled()) {
                return true;
            }
        }
    }
    return false;
}

// Namespace ability_util/ability_util
// Params 2, eflags: 0x0
// Checksum 0xbdf3bc4f, Offset: 0x240
// Size: 0xfe
function function_c336ad48(&suppliers, var_2e5ec5a8) {
    if (isdefined(self.team)) {
        teammates = getplayers(self.team);
        foreach (teammate in teammates) {
            if (!isdefined(teammate)) {
                continue;
            }
            if (teammate == self && var_2e5ec5a8) {
                continue;
            }
            if (teammate gadget_combat_efficiency_enabled()) {
                suppliers[teammate getentitynumber()] = teammate;
            }
        }
    }
}

// Namespace ability_util/ability_util
// Params 1, eflags: 0x0
// Checksum 0x6633598a, Offset: 0x348
// Size: 0x8c
function gadget_combat_efficiency_power_drain(score) {
    powerchange = -1 * score * getdvarfloat(#"scr_combat_efficiency_power_loss_scalar", 0);
    slot = gadget_slot_for_type(12);
    if (slot != 3) {
        self gadgetpowerchange(slot, powerchange);
    }
}

// Namespace ability_util/ability_util
// Params 0, eflags: 0x0
// Checksum 0x73a4a773, Offset: 0x3e0
// Size: 0xb0
function function_a26c5cd1() {
    a_weaponlist = self getweaponslist();
    foreach (weapon in a_weaponlist) {
        if (isdefined(weapon) && weapon.isgadget) {
            self takeweapon(weapon);
        }
    }
}

// Namespace ability_util/ability_util
// Params 1, eflags: 0x0
// Checksum 0xcae5d604, Offset: 0x498
// Size: 0x44
function ability_give(weapon_name) {
    weapon = getweapon(weapon_name);
    self giveweapon(weapon);
}

// Namespace ability_util/ability_util
// Params 1, eflags: 0x0
// Checksum 0xae36f5a7, Offset: 0x4e8
// Size: 0x1a
function is_weapon_gadget(weapon) {
    return weapon.gadget_type != 0;
}

// Namespace ability_util/ability_util
// Params 1, eflags: 0x0
// Checksum 0xb68843f9, Offset: 0x510
// Size: 0xe6
function gadget_power_reset(gadgetweapon) {
    if (isdefined(gadgetweapon)) {
        slot = self gadgetgetslot(gadgetweapon);
        if (slot >= 0 && slot < 3) {
            self gadgetpowerreset(slot);
            self gadgetcharging(slot, 1);
        }
        return;
    }
    for (slot = 0; slot < 3; slot++) {
        self gadgetpowerreset(slot);
        self gadgetcharging(slot, 1);
    }
}

// Namespace ability_util/ability_util
// Params 1, eflags: 0x0
// Checksum 0xd5182fce, Offset: 0x600
// Size: 0xd6
function function_aa8c40c1(gadgetweapon) {
    if (isdefined(gadgetweapon)) {
        slot = self gadgetgetslot(gadgetweapon);
        if (slot >= 0 && slot < 3) {
            self gadgetpowerset(slot, 100);
            self gadgetcharging(slot, 0);
        }
        return;
    }
    for (slot = 0; slot < 3; slot++) {
        self gadgetpowerset(slot, 100);
        self gadgetcharging(slot, 0);
    }
}

// Namespace ability_util/ability_util
// Params 1, eflags: 0x0
// Checksum 0x3a251e29, Offset: 0x6e0
// Size: 0xae
function function_42a37459(gadgetweapon) {
    if (isdefined(gadgetweapon)) {
        slot = self gadgetgetslot(gadgetweapon);
        if (isdefined(slot) && slot >= 0 && slot < 3) {
            self function_53265cac(slot, 0);
        }
        return;
    }
    for (slot = 0; slot < 3; slot++) {
        self function_53265cac(slot, 0);
    }
}

// Namespace ability_util/ability_util
// Params 1, eflags: 0x0
// Checksum 0x1a5114d0, Offset: 0x798
// Size: 0xe6
function function_65154ac0(gadgetweapon) {
    if (isdefined(gadgetweapon)) {
        slot = self gadgetgetslot(gadgetweapon);
        if (slot >= 0 && slot < 3) {
            self gadgetpowerreset(slot);
            self function_53265cac(slot, 1);
        }
        return;
    }
    for (slot = 0; slot < 3; slot++) {
        self gadgetpowerreset(slot);
        self function_53265cac(slot, 1);
    }
}

// Namespace ability_util/ability_util
// Params 1, eflags: 0x0
// Checksum 0x12636f04, Offset: 0x888
// Size: 0x9c
function function_3247ae27(fill_power) {
    if (isdefined(self.playerrole) && isdefined(self.playerrole.primaryequipment)) {
        gadget_weapon = getweapon(self.playerrole.primaryequipment);
        if (isdefined(gadget_weapon)) {
            self function_42a37459(gadget_weapon);
            if (isdefined(fill_power) && fill_power) {
                self function_aa8c40c1(gadget_weapon);
            }
        }
    }
}

// Namespace ability_util/ability_util
// Params 1, eflags: 0x0
// Checksum 0x16e9fd3c, Offset: 0x930
// Size: 0x9c
function function_8ffa6259(fill_power) {
    if (isdefined(self.playerrole) && isdefined(self.playerrole.var_4c698c3d)) {
        gadget_weapon = getweapon(self.playerrole.var_4c698c3d);
        if (isdefined(gadget_weapon)) {
            self function_42a37459(gadget_weapon);
            if (isdefined(fill_power) && fill_power) {
                self function_aa8c40c1(gadget_weapon);
            }
        }
    }
}

// Namespace ability_util/ability_util
// Params 1, eflags: 0x0
// Checksum 0xb9d7173c, Offset: 0x9d8
// Size: 0x9c
function function_c83c2764(fill_power) {
    if (isdefined(self.playerrole) && isdefined(self.playerrole.ultimateweapon)) {
        gadget_weapon = getweapon(self.playerrole.ultimateweapon);
        if (isdefined(gadget_weapon)) {
            self function_42a37459(gadget_weapon);
            if (isdefined(fill_power) && fill_power) {
                self function_aa8c40c1(gadget_weapon);
            }
        }
    }
}

// Namespace ability_util/ability_util
// Params 0, eflags: 0x0
// Checksum 0xea5e9a33, Offset: 0xa80
// Size: 0x6c
function function_191ae36a() {
    if (isdefined(self.playerrole) && isdefined(self.playerrole.primaryequipment)) {
        gadget_weapon = getweapon(self.playerrole.primaryequipment);
        if (isdefined(gadget_weapon)) {
            self function_65154ac0(gadget_weapon);
        }
    }
}

// Namespace ability_util/ability_util
// Params 0, eflags: 0x0
// Checksum 0xa933bb44, Offset: 0xaf8
// Size: 0x6c
function function_d598c3f0() {
    if (isdefined(self.playerrole) && isdefined(self.playerrole.var_4c698c3d)) {
        gadget_weapon = getweapon(self.playerrole.var_4c698c3d);
        if (isdefined(gadget_weapon)) {
            self function_65154ac0(gadget_weapon);
        }
    }
}

// Namespace ability_util/ability_util
// Params 0, eflags: 0x0
// Checksum 0xcd07c54c, Offset: 0xb70
// Size: 0x6c
function function_e5e2d20d() {
    if (isdefined(self.playerrole) && isdefined(self.playerrole.ultimateweapon)) {
        gadget_weapon = getweapon(self.playerrole.ultimateweapon);
        if (isdefined(gadget_weapon)) {
            self function_65154ac0(gadget_weapon);
        }
    }
}

// Namespace ability_util/ability_util
// Params 5, eflags: 0x0
// Checksum 0x58e79077, Offset: 0xbe8
// Size: 0x63c
function gadget_reset(gadgetweapon, changedclass, roundbased, firstround, changedspecialist) {
    slot = self gadgetgetslot(gadgetweapon);
    if (slot >= 0 && slot < 3) {
        if (isdefined(self.pers[#"held_gadgets_power"]) && isdefined(self.pers[#"held_gadgets_power"][gadgetweapon])) {
            self gadgetpowerset(slot, self.pers[#"held_gadgets_power"][gadgetweapon]);
        } else if (isdefined(self.pers[#"held_gadgets_power"]) && isdefined(self.pers[#"thiefweapon"]) && isdefined(self.pers[#"held_gadgets_power"][self.pers[#"thiefweapon"]])) {
            self gadgetpowerset(slot, self.pers[#"held_gadgets_power"][self.pers[#"thiefweapon"]]);
        } else if (isdefined(self.pers[#"held_gadgets_power"]) && isdefined(self.pers[#"rouletteweapon"]) && isdefined(self.pers[#"held_gadgets_power"][self.pers[#"rouletteweapon"]])) {
            self gadgetpowerset(slot, self.pers[#"held_gadgets_power"][self.pers[#"rouletteweapon"]]);
        }
        if (isdefined(self.pers[#"hash_7a954c017d693f69"]) && isdefined(self.pers[#"hash_7a954c017d693f69"][gadgetweapon])) {
            self function_1d590050(slot, self.pers[#"hash_7a954c017d693f69"][gadgetweapon]);
        }
        isfirstspawn = isdefined(self.firstspawn) ? self.firstspawn : 1;
        resetonclasschange = changedclass && gadgetweapon.gadget_power_reset_on_class_change;
        resetonfirstround = isfirstspawn && (!roundbased || firstround);
        resetonroundswitch = roundbased && !firstround && gadgetweapon.gadget_power_reset_on_round_switch;
        resetonteamchanged = !isfirstspawn && isdefined(self.switchedteamsresetgadgets) && self.switchedteamsresetgadgets && gadgetweapon.gadget_power_reset_on_team_change;
        var_f0100663 = changedspecialist && getdvarint(#"hash_256144ebda864b87", 0) && !(isdefined(level.ingraceperiod) && level.ingraceperiod && !(isdefined(self.hasdonecombat) && self.hasdonecombat));
        var_be3c7b85 = isdefined(self.switchedteamsresetgadgets) && self.switchedteamsresetgadgets && getdvarint(#"hash_8351525729015ab", 0);
        deployed = 0;
        if (isdefined(self.pers[#"hash_68cdf8807cfaabff"]) && isdefined(self.pers[#"hash_68cdf8807cfaabff"][gadgetweapon]) && self.pers[#"hash_68cdf8807cfaabff"][gadgetweapon]) {
            if ((gadgetweapon.var_54385664 || !changedclass) && !isfirstspawn) {
                deployed = 1;
                self function_c4526e40(slot, gadgetweapon);
            }
        }
        if (var_f0100663 || var_be3c7b85) {
            self gadgetpowerset(slot, 0);
            self.pers[#"herogadgetnotified"][slot] = 0;
            if (!deployed) {
                self gadgetcharging(slot, 1);
            }
            return;
        }
        if (resetonclasschange || resetonfirstround || resetonroundswitch || resetonteamchanged) {
            self gadgetpowerreset(slot, isfirstspawn);
            self.pers[#"herogadgetnotified"][slot] = 0;
            if (!deployed) {
                self gadgetcharging(slot, 1);
            }
        }
    }
}

// Namespace ability_util/ability_util
// Params 0, eflags: 0x0
// Checksum 0x48f3de9b, Offset: 0x1230
// Size: 0x1a
function gadget_power_armor_on() {
    return gadget_is_active(3);
}

// Namespace ability_util/ability_util
// Params 1, eflags: 0x0
// Checksum 0x519e458b, Offset: 0x1258
// Size: 0x6e
function gadget_is_active(gadgettype) {
    slot = self gadget_slot_for_type(gadgettype);
    if (slot >= 0 && slot < 3) {
        if (self util::gadget_is_in_use(slot)) {
            return true;
        }
    }
    return false;
}

// Namespace ability_util/ability_util
// Params 1, eflags: 0x0
// Checksum 0x47afc919, Offset: 0x12d0
// Size: 0x52
function gadget_has_type(gadgettype) {
    slot = self gadget_slot_for_type(gadgettype);
    if (slot >= 0 && slot < 3) {
        return true;
    }
    return false;
}

// Namespace ability_util/ability_util
// Params 2, eflags: 0x0
// Checksum 0x70496683, Offset: 0x1330
// Size: 0x3ac
function aoe_friendlies(weapon, aoe) {
    self endon(#"disconnect");
    self endon(aoe.aoe_think_singleton_event);
    start_time = gettime();
    end_time = start_time + aoe.duration;
    if (!isdefined(self) || !isdefined(self.team)) {
        return;
    }
    profile_script = getdvarint(#"scr_profile_aoe", 0);
    if (profile_script) {
        profile_start_time = util::get_start_time();
        profile_elapsed_times = [];
        extra_profile_time = 1000;
        end_time += extra_profile_time;
    }
    has_reapply_check = isdefined(aoe.check_reapply_time_func);
    aoe_team = self.team;
    aoe_applied = 0;
    frac = 0;
    while (frac < 1 || aoe_applied > 0) {
        settings = getscriptbundle(weapon.customsettings);
        frac = (gettime() - start_time) / aoe.duration;
        if (frac > 1) {
            frac = 1;
        }
        radius = settings.cleanseradius;
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
            if (!isdefined(aoe.can_apply_aoe_func) || [[ aoe.can_apply_aoe_func ]](player, aoe.origin)) {
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
// Checksum 0xb6863ed1, Offset: 0x16e8
// Size: 0x90
function aoe_trace_entity(entity, origin, trace_z_offset) {
    entitypoint = entity.origin + (0, 0, trace_z_offset);
    if (!bullettracepassed(origin, entitypoint, 1, self, undefined, 0, 1)) {
        return false;
    }
    /#
        thread util::draw_debug_line(origin, entitypoint, 1);
    #/
    return true;
}

// Namespace ability_util/ability_util
// Params 1, eflags: 0x0
// Checksum 0x580ef5ba, Offset: 0x1780
// Size: 0x4a
function is_hero_weapon(gadgetweapon) {
    if ((gadgetweapon.isheavyweapon || gadgetweapon.issignatureweapon) && gadgetweapon.gadget_type == 11) {
        return true;
    }
    return false;
}

