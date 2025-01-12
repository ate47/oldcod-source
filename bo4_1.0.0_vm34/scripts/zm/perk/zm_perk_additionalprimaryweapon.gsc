#using scripts\core_common\aat_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_perk_additionalprimaryweapon;

// Namespace zm_perk_additionalprimaryweapon/zm_perk_additionalprimaryweapon
// Params 0, eflags: 0x2
// Checksum 0xb2930358, Offset: 0x230
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_perk_additionalprimaryweapon", &__init__, undefined, undefined);
}

// Namespace zm_perk_additionalprimaryweapon/zm_perk_additionalprimaryweapon
// Params 0, eflags: 0x0
// Checksum 0xc9f76d03, Offset: 0x278
// Size: 0x24
function __init__() {
    level.additionalprimaryweapon_limit = 3;
    enable_additional_primary_weapon_perk_for_level();
}

// Namespace zm_perk_additionalprimaryweapon/zm_perk_additionalprimaryweapon
// Params 0, eflags: 0x0
// Checksum 0x86c98cb3, Offset: 0x2a8
// Size: 0x18c
function enable_additional_primary_weapon_perk_for_level() {
    zm_perks::register_perk_basic_info(#"specialty_additionalprimaryweapon", "perk_additional_primary_weapon", 4000, #"zombie/perk_additionalprimaryweapon", getweapon("zombie_perk_bottle_additionalprimaryweapon"), getweapon("zombie_perk_totem_mule_kick"), #"zmperksmulekick");
    zm_perks::register_perk_precache_func(#"specialty_additionalprimaryweapon", &additional_primary_weapon_precache);
    zm_perks::register_perk_clientfields(#"specialty_additionalprimaryweapon", &additional_primary_weapon_register_clientfield, &additional_primary_weapon_set_clientfield);
    zm_perks::register_perk_machine(#"specialty_additionalprimaryweapon", &additional_primary_weapon_perk_machine_setup);
    zm_perks::register_perk_threads(#"specialty_additionalprimaryweapon", &give_additional_primary_weapon_perk, &take_additional_primary_weapon_perk);
    zm_perks::register_perk_host_migration_params(#"specialty_additionalprimaryweapon", "vending_additionalprimaryweapon", "additionalprimaryweapon_light");
}

// Namespace zm_perk_additionalprimaryweapon/zm_perk_additionalprimaryweapon
// Params 0, eflags: 0x0
// Checksum 0x7fd0f8a, Offset: 0x440
// Size: 0x106
function additional_primary_weapon_precache() {
    if (isdefined(level.var_796aeab4)) {
        [[ level.var_796aeab4 ]]();
        return;
    }
    level._effect[#"additionalprimaryweapon_light"] = "zombie/fx_perk_mule_kick_zmb";
    level.machine_assets[#"specialty_additionalprimaryweapon"] = spawnstruct();
    level.machine_assets[#"specialty_additionalprimaryweapon"].weapon = getweapon("zombie_perk_bottle_additionalprimaryweapon");
    level.machine_assets[#"specialty_additionalprimaryweapon"].off_model = "p7_zm_vending_three_gun";
    level.machine_assets[#"specialty_additionalprimaryweapon"].on_model = "p7_zm_vending_three_gun";
}

// Namespace zm_perk_additionalprimaryweapon/zm_perk_additionalprimaryweapon
// Params 0, eflags: 0x0
// Checksum 0x541e339d, Offset: 0x550
// Size: 0x34
function additional_primary_weapon_register_clientfield() {
    clientfield::register("clientuimodel", "hudItems.perks.additional_primary_weapon", 1, 2, "int");
}

// Namespace zm_perk_additionalprimaryweapon/zm_perk_additionalprimaryweapon
// Params 1, eflags: 0x0
// Checksum 0xfac6152d, Offset: 0x590
// Size: 0xc
function additional_primary_weapon_set_clientfield(state) {
    
}

// Namespace zm_perk_additionalprimaryweapon/zm_perk_additionalprimaryweapon
// Params 4, eflags: 0x0
// Checksum 0x9860eb46, Offset: 0x5a8
// Size: 0xb6
function additional_primary_weapon_perk_machine_setup(use_trigger, perk_machine, bump_trigger, collision) {
    use_trigger.script_sound = "mus_perks_mulekick_jingle";
    use_trigger.script_string = "tap_perk";
    use_trigger.script_label = "mus_perks_mulekick_sting";
    use_trigger.target = "vending_additionalprimaryweapon";
    perk_machine.script_string = "tap_perk";
    perk_machine.targetname = "vending_additionalprimaryweapon";
    if (isdefined(bump_trigger)) {
        bump_trigger.script_string = "tap_perk";
    }
}

// Namespace zm_perk_additionalprimaryweapon/zm_perk_additionalprimaryweapon
// Params 0, eflags: 0x0
// Checksum 0x2f6f135f, Offset: 0x668
// Size: 0x34
function give_additional_primary_weapon_perk() {
    self thread function_80fecb96();
    self function_4a176de();
}

// Namespace zm_perk_additionalprimaryweapon/zm_perk_additionalprimaryweapon
// Params 3, eflags: 0x0
// Checksum 0x7e955b3a, Offset: 0x6a8
// Size: 0x27c
function take_additional_primary_weapon_perk(b_pause, str_perk, str_result) {
    if (b_pause || str_result == str_perk) {
        self notify(#"hash_4dba2ff9e70127f5");
        if (isdefined(self.laststandpistol)) {
            self endon(#"disconnect", #"hash_499749b8848c21fd");
            if (self.laststandpistol !== self.var_7d93cc5e) {
                self clientfield::set_player_uimodel("hudItems.perks.additional_primary_weapon", 0);
            }
            self waittill(#"hash_9b426cce825928d");
        }
        var_d2f4cbdf = self getweaponslistprimaries();
        var_dd27188c = zm_utility::get_player_weapon_limit(self);
        if (var_d2f4cbdf.size > var_dd27188c) {
            if (isdefined(self.var_7d93cc5e) && self hasweapon(self.var_7d93cc5e)) {
                if (isdefined(self.var_2bd7c22) && self.var_2bd7c22) {
                    self.var_ccccd7af = {#var_5f707f88:zm_weapons::get_player_weapondata(self, self.var_7d93cc5e), #str_aat:self.aat[self.var_7d93cc5e]};
                    self.var_2bd7c22 = undefined;
                }
                if (self.var_7d93cc5e == self getcurrentweapon() && var_d2f4cbdf.size > 1) {
                    self switchtoweapon();
                }
                self takeweapon(self.var_7d93cc5e);
            } else if (zm_trial::is_trial_mode()) {
                assert("<dev string:x30>");
            }
        }
        self.var_7d93cc5e = undefined;
        self clientfield::set_player_uimodel("hudItems.perks.additional_primary_weapon", 0);
    }
}

// Namespace zm_perk_additionalprimaryweapon/zm_perk_additionalprimaryweapon
// Params 0, eflags: 0x0
// Checksum 0x5d773bd2, Offset: 0x930
// Size: 0x238
function function_80fecb96() {
    self notify(#"hash_499749b8848c21fd");
    self endon(#"disconnect", #"hash_4dba2ff9e70127f5", #"hash_499749b8848c21fd");
    var_d2f4cbdf = self getweaponslistprimaries();
    if (var_d2f4cbdf.size < level.additionalprimaryweapon_limit) {
        self.var_7d93cc5e = undefined;
    }
    while (true) {
        s_result = self waittill(#"weapon_change", #"hash_29c66728ccd27f03");
        if (isdefined(self.laststandpistol)) {
            self clientfield::set_player_uimodel("hudItems.perks.additional_primary_weapon", 0);
            continue;
        }
        if (!isinarray(var_d2f4cbdf, s_result.weapon)) {
            var_c72a1288 = self getweaponslistprimaries();
            if (var_c72a1288.size >= level.additionalprimaryweapon_limit) {
                if (!isdefined(self.var_7d93cc5e) && var_c72a1288.size > var_d2f4cbdf.size) {
                    self.var_7d93cc5e = s_result.weapon;
                } else if (isdefined(self.var_7d93cc5e) && !isinarray(var_c72a1288, self.var_7d93cc5e)) {
                    self.var_7d93cc5e = s_result.weapon;
                }
            }
            var_d2f4cbdf = var_c72a1288;
        }
        if (isdefined(self.var_7d93cc5e) && self.var_7d93cc5e == self getcurrentweapon()) {
            self clientfield::set_player_uimodel("hudItems.perks.additional_primary_weapon", 1);
            continue;
        }
        self clientfield::set_player_uimodel("hudItems.perks.additional_primary_weapon", 0);
    }
}

// Namespace zm_perk_additionalprimaryweapon/zm_perk_additionalprimaryweapon
// Params 0, eflags: 0x0
// Checksum 0x3b11d205, Offset: 0xb70
// Size: 0x94
function function_4a176de() {
    if (isdefined(self.var_ccccd7af)) {
        var_5f707f88 = self.var_ccccd7af.var_5f707f88;
        str_aat = self.var_ccccd7af.str_aat;
        self.var_ccccd7af = undefined;
        weapon = zm_weapons::weapondata_give(var_5f707f88);
        if (isdefined(str_aat)) {
            self aat::acquire(weapon, str_aat);
        }
    }
}

