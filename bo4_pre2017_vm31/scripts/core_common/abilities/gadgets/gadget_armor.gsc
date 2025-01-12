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
function autoexec __init__sytem__() {
    system::register("gadget_armor", &__init__, undefined, undefined);
}

// Namespace armor/gadget_armor
// Params 0, eflags: 0x0
// Checksum 0xcbe04a93, Offset: 0x578
// Size: 0x144
function __init__() {
    ability_player::register_gadget_activation_callbacks(4, &gadget_armor_on, &gadget_armor_off);
    ability_player::register_gadget_possession_callbacks(4, &gadget_armor_on_give, &gadget_armor_on_take);
    ability_player::register_gadget_flicker_callbacks(4, &gadget_armor_on_flicker);
    ability_player::register_gadget_is_inuse_callbacks(4, &gadget_armor_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(4, &gadget_armor_is_flickering);
    clientfield::register("allplayers", "armor_status", 1, 5, "int");
    clientfield::register("toplayer", "player_damage_type", 1, 1, "int");
    callback::on_connect(&gadget_armor_on_connect);
}

// Namespace armor/gadget_armor
// Params 1, eflags: 0x0
// Checksum 0x4af22e65, Offset: 0x6c8
// Size: 0x22
function gadget_armor_is_inuse(slot) {
    return self gadgetisactive(slot);
}

// Namespace armor/gadget_armor
// Params 1, eflags: 0x0
// Checksum 0x2f8cc9ac, Offset: 0x6f8
// Size: 0x22
function gadget_armor_is_flickering(slot) {
    return self gadgetflickering(slot);
}

// Namespace armor/gadget_armor
// Params 2, eflags: 0x0
// Checksum 0x74a47136, Offset: 0x728
// Size: 0x34
function gadget_armor_on_flicker(slot, weapon) {
    self thread gadget_armor_flicker(slot, weapon);
}

// Namespace armor/gadget_armor
// Params 2, eflags: 0x0
// Checksum 0x5d517cce, Offset: 0x768
// Size: 0x54
function gadget_armor_on_give(slot, weapon) {
    self clientfield::set("armor_status", 0);
    self._gadget_armor_slot = slot;
    self._gadget_armor_weapon = weapon;
}

// Namespace armor/gadget_armor
// Params 2, eflags: 0x0
// Checksum 0x3eb57987, Offset: 0x7c8
// Size: 0x34
function gadget_armor_on_take(slot, weapon) {
    self gadget_armor_off(slot, weapon);
}

// Namespace armor/gadget_armor
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x808
// Size: 0x4
function gadget_armor_on_connect() {
    
}

// Namespace armor/gadget_armor
// Params 2, eflags: 0x0
// Checksum 0x255179c2, Offset: 0x818
// Size: 0xfc
function gadget_armor_on(slot, weapon) {
    if (isalive(self)) {
        self flagsys::set("gadget_armor_on");
        self.shock_onpain = 0;
        self.gadgethitpoints = isdefined(weapon.gadget_max_hitpoints) && weapon.gadget_max_hitpoints > 0 ? weapon.gadget_max_hitpoints : undefined;
        if (isdefined(self.overrideplayerdamage)) {
            self.originaloverrideplayerdamage = self.overrideplayerdamage;
        }
        self.overrideplayerdamage = &armor_player_damage;
        self thread gadget_armor_status(slot, weapon);
    }
}

// Namespace armor/gadget_armor
// Params 2, eflags: 0x0
// Checksum 0xff67efa2, Offset: 0x920
// Size: 0x108
function gadget_armor_off(slot, weapon) {
    armoron = flagsys::get("gadget_armor_on");
    self notify(#"gadget_armor_off");
    self flagsys::clear("gadget_armor_on");
    self.shock_onpain = 1;
    self clientfield::set("armor_status", 0);
    if (isdefined(self.originaloverrideplayerdamage)) {
        self.overrideplayerdamage = self.originaloverrideplayerdamage;
        self.originaloverrideplayerdamage = undefined;
    }
    if (armoron && isalive(self) && isdefined(level.playgadgetsuccess)) {
        self [[ level.playgadgetsuccess ]](weapon);
    }
}

// Namespace armor/gadget_armor
// Params 2, eflags: 0x0
// Checksum 0x6d0a669e, Offset: 0xa30
// Size: 0xdc
function gadget_armor_flicker(slot, weapon) {
    self endon(#"disconnect");
    if (!self gadget_armor_is_inuse(slot)) {
        return;
    }
    eventtime = self._gadgets_player[slot].gadget_flickertime;
    self set_gadget_status("Flickering", eventtime);
    while (true) {
        if (!self gadgetflickering(slot)) {
            self set_gadget_status("Normal");
            return;
        }
        wait 0.5;
    }
}

// Namespace armor/gadget_armor
// Params 2, eflags: 0x0
// Checksum 0x46a778f9, Offset: 0xb18
// Size: 0x9c
function set_gadget_status(status, time) {
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
function armor_damage_type_multiplier(smeansofdeath) {
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
function armor_damage_mod_allowed(weapon, smeansofdeath) {
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
function armor_should_take_damage(eattacker, weapon, smeansofdeath, shitloc) {
    if (isdefined(eattacker) && !weaponobjects::friendlyfirecheck(self, eattacker)) {
        return false;
    }
    if (!armor_damage_mod_allowed(weapon, smeansofdeath)) {
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
function armor_player_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, modelindex, psoffsettime) {
    damage = idamage;
    self.power_armor_took_damage = 0;
    if (self armor_should_take_damage(eattacker, weapon, smeansofdeath, shitloc) && isdefined(self._gadget_armor_slot)) {
        self clientfield::set_to_player("player_damage_type", 1);
        if (self gadget_armor_is_inuse(self._gadget_armor_slot)) {
            armor_damage = damage * armor_damage_type_multiplier(smeansofdeath);
            damage = 0;
            if (armor_damage > 0) {
                if (isdefined(self.gadgethitpoints)) {
                    hitpointsleft = self.gadgethitpoints;
                } else {
                    hitpointsleft = self gadgetpowerchange(self._gadget_armor_slot, 0);
                }
                if (weapon === level.weaponlightninggun || weapon === level.weaponlightninggunarc) {
                    armor_damage = hitpointsleft;
                } else if (hitpointsleft < armor_damage) {
                    damage = armor_damage - hitpointsleft;
                }
                if (isdefined(self.gadgethitpoints)) {
                    self hitpoints_loss_event(armor_damage);
                } else {
                    self ability_power::power_loss_event(self._gadget_armor_slot, eattacker, armor_damage, "armor damage");
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
function hitpoints_loss_event(val) {
    if (val > 0) {
        self.gadgethitpoints -= val;
    }
}

// Namespace armor/gadget_armor
// Params 2, eflags: 0x0
// Checksum 0x63768655, Offset: 0x1230
// Size: 0x27c
function gadget_armor_status(slot, weapon) {
    self endon(#"disconnect");
    maxhitpoints = isdefined(weapon.gadget_max_hitpoints) && weapon.gadget_max_hitpoints > 0 ? weapon.gadget_max_hitpoints : 100;
    while (self flagsys::get("gadget_armor_on")) {
        if (self scene::is_igc_active()) {
            self gadgetdeactivate(slot, weapon);
            self gadgetpowerset(slot, 0);
            break;
        }
        if (isdefined(self.gadgethitpoints) && self.gadgethitpoints <= 0) {
            self playsoundtoplayer("wpn_power_armor_destroyed_plr", self);
            self playsoundtoallbutplayer("wpn_power_armor_destroyed_npc", self);
            self gadgetdeactivate(slot, weapon);
            self gadgetpowerset(slot, 0);
            break;
        }
        if (isdefined(self.gadgethitpoints)) {
            hitpointsratio = self.gadgethitpoints / maxhitpoints;
        } else {
            hitpointsratio = self gadgetpowerchange(self._gadget_armor_slot, 0) / maxhitpoints;
        }
        stage = 1 + int(hitpointsratio * 5);
        if (stage > 5) {
            stage = 5;
        }
        self clientfield::set("armor_status", stage);
        waitframe(1);
    }
    self clientfield::set("armor_status", 0);
}

