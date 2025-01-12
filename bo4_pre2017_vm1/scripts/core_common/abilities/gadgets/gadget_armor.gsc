#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_power;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/scene_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/weaponobjects;

#namespace armor;

// Namespace armor/gadget_armor
// Params 0, eflags: 0x2
// Checksum 0x847c3042, Offset: 0x538
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_armor", &__init__, undefined, undefined);
}

// Namespace armor/gadget_armor
// Params 0, eflags: 0x0
// Checksum 0xcbe04a93, Offset: 0x578
// Size: 0x144
function __init__() {
    ability_player::register_gadget_activation_callbacks(4, &function_27d2ab93, &function_ef8f7527);
    ability_player::register_gadget_possession_callbacks(4, &function_f593f079, &function_c03e583);
    ability_player::register_gadget_flicker_callbacks(4, &function_9b27736e);
    ability_player::register_gadget_is_inuse_callbacks(4, &function_24782613);
    ability_player::register_gadget_is_flickering_callbacks(4, &function_e4e11f03);
    clientfield::register("allplayers", "armor_status", 1, 5, "int");
    clientfield::register("toplayer", "player_damage_type", 1, 1, "int");
    callback::on_connect(&function_362bc1a8);
}

// Namespace armor/gadget_armor
// Params 1, eflags: 0x0
// Checksum 0x4af22e65, Offset: 0x6c8
// Size: 0x22
function function_24782613(slot) {
    return self gadgetisactive(slot);
}

// Namespace armor/gadget_armor
// Params 1, eflags: 0x0
// Checksum 0x2f8cc9ac, Offset: 0x6f8
// Size: 0x22
function function_e4e11f03(slot) {
    return self gadgetflickering(slot);
}

// Namespace armor/gadget_armor
// Params 2, eflags: 0x0
// Checksum 0x74a47136, Offset: 0x728
// Size: 0x34
function function_9b27736e(slot, weapon) {
    self thread function_29961c34(slot, weapon);
}

// Namespace armor/gadget_armor
// Params 2, eflags: 0x0
// Checksum 0x5d517cce, Offset: 0x768
// Size: 0x54
function function_f593f079(slot, weapon) {
    self clientfield::set("armor_status", 0);
    self.var_5f5848a3 = slot;
    self.var_f3bad013 = weapon;
}

// Namespace armor/gadget_armor
// Params 2, eflags: 0x0
// Checksum 0x3eb57987, Offset: 0x7c8
// Size: 0x34
function function_c03e583(slot, weapon) {
    self function_ef8f7527(slot, weapon);
}

// Namespace armor/gadget_armor
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x808
// Size: 0x4
function function_362bc1a8() {
    
}

// Namespace armor/gadget_armor
// Params 2, eflags: 0x0
// Checksum 0x255179c2, Offset: 0x818
// Size: 0xfc
function function_27d2ab93(slot, weapon) {
    if (isalive(self)) {
        self flagsys::set("gadget_armor_on");
        self.shock_onpain = 0;
        self.var_442c2e3d = isdefined(weapon.gadget_max_hitpoints) && weapon.gadget_max_hitpoints > 0 ? weapon.gadget_max_hitpoints : undefined;
        if (isdefined(self.overrideplayerdamage)) {
            self.var_6b5f7ec4 = self.overrideplayerdamage;
        }
        self.overrideplayerdamage = &function_37346b5a;
        self thread function_98b378e(slot, weapon);
    }
}

// Namespace armor/gadget_armor
// Params 2, eflags: 0x0
// Checksum 0xff67efa2, Offset: 0x920
// Size: 0x108
function function_ef8f7527(slot, weapon) {
    var_3ca1a1ad = flagsys::get("gadget_armor_on");
    self notify(#"hash_ef8f7527");
    self flagsys::clear("gadget_armor_on");
    self.shock_onpain = 1;
    self clientfield::set("armor_status", 0);
    if (isdefined(self.var_6b5f7ec4)) {
        self.overrideplayerdamage = self.var_6b5f7ec4;
        self.var_6b5f7ec4 = undefined;
    }
    if (var_3ca1a1ad && isalive(self) && isdefined(level.playgadgetsuccess)) {
        self [[ level.playgadgetsuccess ]](weapon);
    }
}

// Namespace armor/gadget_armor
// Params 2, eflags: 0x0
// Checksum 0x6d0a669e, Offset: 0xa30
// Size: 0xdc
function function_29961c34(slot, weapon) {
    self endon(#"disconnect");
    if (!self function_24782613(slot)) {
        return;
    }
    eventtime = self._gadgets_player[slot].gadget_flickertime;
    self function_39b1b87b("Flickering", eventtime);
    while (true) {
        if (!self gadgetflickering(slot)) {
            self function_39b1b87b("Normal");
            return;
        }
        wait 0.5;
    }
}

// Namespace armor/gadget_armor
// Params 2, eflags: 0x0
// Checksum 0x46a778f9, Offset: 0xb18
// Size: 0x9c
function function_39b1b87b(status, time) {
    timestr = "";
    if (isdefined(time)) {
        timestr = "^3" + ", time: " + time;
    }
    if (getdvarint("scr_cpower_debug_prints") > 0) {
        self iprintlnbold("Gadget Armor: " + status + timestr);
    }
}

// Namespace armor/gadget_armor
// Params 1, eflags: 0x0
// Checksum 0x8e0cdb95, Offset: 0xbc0
// Size: 0x15a
function function_46ec01fd(smeansofdeath) {
    switch (smeansofdeath) {
    case #"mod_crush":
    case #"mod_drown":
    case #"mod_falling":
    case #"mod_hit_by_object":
    case #"mod_suicide":
    case #"mod_telefrag":
        return 0;
    case #"mod_projectile":
        return getdvarfloat("scr_armor_mod_proj_mult", 1);
    case #"mod_melee":
    case #"mod_melee_weapon_butt":
        return getdvarfloat("scr_armor_mod_melee_mult", 2);
    case #"mod_explosive":
    case #"mod_grenade":
    case #"mod_grenade_splash":
    case #"mod_projectile_splash":
        return getdvarfloat("scr_armor_mod_expl_mult", 1);
    case #"mod_pistol_bullet":
    case #"mod_rifle_bullet":
        return getdvarfloat("scr_armor_mod_bullet_mult", 0.7);
    case #"mod_burned":
    case #"mod_trigger_hurt":
    case #"mod_unknown":
    default:
        return getdvarfloat("scr_armor_mod_misc_mult", 1);
    }
}

// Namespace armor/gadget_armor
// Params 2, eflags: 0x0
// Checksum 0xf4034ff0, Offset: 0xd28
// Size: 0x8a
function function_db3ccbce(weapon, smeansofdeath) {
    switch (weapon.name) {
    case #"hero_lightninggun":
    case #"hero_lightninggun_arc":
        return false;
    default:
        break;
    }
    switch (smeansofdeath) {
    case #"mod_burned":
    case #"mod_crush":
    case #"mod_drown":
    case #"mod_explosive":
    case #"mod_falling":
    case #"mod_grenade":
    case #"mod_grenade_splash":
    case #"mod_hit_by_object":
    case #"mod_melee":
    case #"mod_melee_weapon_butt":
    case #"mod_projectile_splash":
    case #"mod_suicide":
    case #"mod_telefrag":
    case #"mod_trigger_hurt":
    case #"mod_unknown":
        return false;
    case #"mod_pistol_bullet":
    case #"mod_rifle_bullet":
        return true;
    case #"mod_projectile":
        if (weapon.explosionradius == 0) {
            return true;
        }
        return false;
    default:
        return false;
    }
}

// Namespace armor/gadget_armor
// Params 4, eflags: 0x0
// Checksum 0x700954be, Offset: 0xe60
// Size: 0x9c
function function_4a835afe(eattacker, weapon, smeansofdeath, shitloc) {
    if (isdefined(eattacker) && !weaponobjects::friendlyfirecheck(self, eattacker)) {
        return false;
    }
    if (!function_db3ccbce(weapon, smeansofdeath)) {
        return false;
    }
    if (shitloc == "head" || isdefined(shitloc) && shitloc == "helmet") {
        return false;
    }
    return true;
}

// Namespace armor/gadget_armor
// Params 11, eflags: 0x0
// Checksum 0x7fb60d25, Offset: 0xf08
// Size: 0x2e0
function function_37346b5a(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, modelindex, psoffsettime) {
    damage = idamage;
    self.power_armor_took_damage = 0;
    if (self function_4a835afe(eattacker, weapon, smeansofdeath, shitloc) && isdefined(self.var_5f5848a3)) {
        self clientfield::set_to_player("player_damage_type", 1);
        if (self function_24782613(self.var_5f5848a3)) {
            armor_damage = damage * function_46ec01fd(smeansofdeath);
            damage = 0;
            if (armor_damage > 0) {
                if (isdefined(self.var_442c2e3d)) {
                    var_7f37e5f2 = self.var_442c2e3d;
                } else {
                    var_7f37e5f2 = self gadgetpowerchange(self.var_5f5848a3, 0);
                }
                if (weapon === level.weaponlightninggun || weapon === level.weaponlightninggunarc) {
                    armor_damage = var_7f37e5f2;
                } else if (var_7f37e5f2 < armor_damage) {
                    damage = armor_damage - var_7f37e5f2;
                }
                if (isdefined(self.var_442c2e3d)) {
                    self function_edc0b538(armor_damage);
                } else {
                    self ability_power::power_loss_event(self.var_5f5848a3, eattacker, armor_damage, "armor damage");
                }
                self.power_armor_took_damage = 1;
                self.power_armor_last_took_damage_time = gettime();
                self addtodamageindicator(int(armor_damage * getdvarfloat("scr_armor_mod_view_kick_mult", 0.001)), vdir);
            }
        } else {
            self clientfield::set_to_player("player_damage_type", 0);
        }
    } else {
        self clientfield::set_to_player("player_damage_type", 0);
    }
    return damage;
}

// Namespace armor/gadget_armor
// Params 1, eflags: 0x0
// Checksum 0x2c228073, Offset: 0x11f0
// Size: 0x34
function function_edc0b538(val) {
    if (val > 0) {
        self.var_442c2e3d -= val;
    }
}

// Namespace armor/gadget_armor
// Params 2, eflags: 0x0
// Checksum 0x63768655, Offset: 0x1230
// Size: 0x27c
function function_98b378e(slot, weapon) {
    self endon(#"disconnect");
    var_3eea3245 = isdefined(weapon.gadget_max_hitpoints) && weapon.gadget_max_hitpoints > 0 ? weapon.gadget_max_hitpoints : 100;
    while (self flagsys::get("gadget_armor_on")) {
        if (self scene::is_igc_active()) {
            self gadgetdeactivate(slot, weapon);
            self gadgetpowerset(slot, 0);
            break;
        }
        if (isdefined(self.var_442c2e3d) && self.var_442c2e3d <= 0) {
            self playsoundtoplayer("wpn_power_armor_destroyed_plr", self);
            self playsoundtoallbutplayer("wpn_power_armor_destroyed_npc", self);
            self gadgetdeactivate(slot, weapon);
            self gadgetpowerset(slot, 0);
            break;
        }
        if (isdefined(self.var_442c2e3d)) {
            var_73c6f93e = self.var_442c2e3d / var_3eea3245;
        } else {
            var_73c6f93e = self gadgetpowerchange(self.var_5f5848a3, 0) / var_3eea3245;
        }
        stage = 1 + int(var_73c6f93e * 5);
        if (stage > 5) {
            stage = 5;
        }
        self clientfield::set("armor_status", stage);
        waitframe(1);
    }
    self clientfield::set("armor_status", 0);
}

