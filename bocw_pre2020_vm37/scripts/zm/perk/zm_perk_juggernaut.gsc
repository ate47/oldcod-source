#using script_3751b21462a54a7d;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;

#namespace namespace_7461932d;

// Namespace namespace_7461932d/namespace_7461932d
// Params 0, eflags: 0x6
// Checksum 0xdfd6b8ad, Offset: 0x1c0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_6f1ab109254f7a8e", &function_70a657d8, undefined, undefined, #"hash_2d064899850813e2");
}

// Namespace namespace_7461932d/namespace_7461932d
// Params 0, eflags: 0x5 linked
// Checksum 0x6f6c2b81, Offset: 0x210
// Size: 0x4c
function private function_70a657d8() {
    function_485b89e9();
    zm_perks::register_perk_damage_override_func(&function_366a682a);
    level.var_8cc294a7 = &function_7486dbf4;
}

// Namespace namespace_7461932d/namespace_7461932d
// Params 1, eflags: 0x1 linked
// Checksum 0xd08f2858, Offset: 0x268
// Size: 0x22
function function_7486dbf4(var_2cacdde7) {
    var_2cacdde7 += var_2cacdde7 * 0.25;
    return var_2cacdde7;
}

// Namespace namespace_7461932d/namespace_7461932d
// Params 10, eflags: 0x1 linked
// Checksum 0x343cdbf2, Offset: 0x298
// Size: 0x15e
function function_366a682a(*einflictor, eattacker, idamage, *idflags, smeansofdeath, *weapon, *vpoint, *vdir, *shitloc, *psoffsettime) {
    if (self namespace_791d0451::function_56cedda7(#"hash_afdc67f440fb7d3") || self namespace_791d0451::function_56cedda7(#"hash_afdc57f440fb620")) {
        if ((psoffsettime == "MOD_EXPLOSIVE" || psoffsettime == "MOD_GRENADE" || psoffsettime == "MOD_GRENADE_SPLASH") && vdir == self) {
            shitloc = 0;
        }
    }
    if (self namespace_791d0451::function_56cedda7(#"hash_afdc57f440fb620")) {
        var_b66f2623 = self.health - shitloc;
        if (var_b66f2623 <= 0 && self.armor > 0) {
            self.armor = 0;
            shitloc -= 1 - var_b66f2623;
        }
    }
    return shitloc;
}

// Namespace namespace_7461932d/namespace_7461932d
// Params 0, eflags: 0x1 linked
// Checksum 0x2bccec75, Offset: 0x400
// Size: 0x18c
function function_485b89e9() {
    zm_perks::register_perk_basic_info(#"talent_juggernog", #"perk_juggernog", 2500, #"hash_27b60f868a13cc91", getweapon("zombie_perk_bottle_jugg"), undefined, #"zmperksjuggernaut");
    zm_perks::register_perk_precache_func(#"talent_juggernog", &function_166eeafc);
    zm_perks::register_perk_clientfields(#"talent_juggernog", &function_370cba1f, &function_a710e34a);
    zm_perks::register_perk_machine(#"talent_juggernog", &function_1ff28887, &function_545fe52d);
    zm_perks::register_perk_threads(#"talent_juggernog", &function_535de102, &function_8a2f8354);
    zm_perks::register_perk_host_migration_params(#"talent_juggernog", "vending_jugg", "jugger_light");
}

// Namespace namespace_7461932d/namespace_7461932d
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0x598
// Size: 0x4
function function_545fe52d() {
    
}

// Namespace namespace_7461932d/namespace_7461932d
// Params 0, eflags: 0x1 linked
// Checksum 0x2ba8ef12, Offset: 0x5a8
// Size: 0xf6
function function_166eeafc() {
    if (isdefined(level.var_7aa19444)) {
        [[ level.var_7aa19444 ]]();
        return;
    }
    level._effect[#"jugger_light"] = "zombie/fx_perk_juggernaut_factory_zmb";
    level.machine_assets[#"talent_juggernog"] = spawnstruct();
    level.machine_assets[#"talent_juggernog"].weapon = getweapon("zombie_perk_bottle_jugg");
    level.machine_assets[#"talent_juggernog"].off_model = "p7_zm_vending_jugg";
    level.machine_assets[#"talent_juggernog"].on_model = "p7_zm_vending_jugg";
}

// Namespace namespace_7461932d/namespace_7461932d
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0x6a8
// Size: 0x4
function function_370cba1f() {
    
}

// Namespace namespace_7461932d/namespace_7461932d
// Params 1, eflags: 0x1 linked
// Checksum 0x1315b890, Offset: 0x6b8
// Size: 0xc
function function_a710e34a(*state) {
    
}

// Namespace namespace_7461932d/namespace_7461932d
// Params 4, eflags: 0x1 linked
// Checksum 0xc945908b, Offset: 0x6d0
// Size: 0xa6
function function_1ff28887(use_trigger, perk_machine, bump_trigger, *collision) {
    perk_machine.script_sound = "mus_perks_jugganog_jingle";
    perk_machine.script_string = "jugg_perk";
    perk_machine.script_label = "mus_perks_jugganog_sting";
    perk_machine.var_7619f1b6 = 1;
    perk_machine.target = "vending_jugg";
    bump_trigger.script_string = "jugg_perk";
    bump_trigger.targetname = "vending_jugg";
    if (isdefined(collision)) {
        collision.script_string = "jugg_perk";
    }
}

// Namespace namespace_7461932d/namespace_7461932d
// Params 0, eflags: 0x1 linked
// Checksum 0xe38cd01c, Offset: 0x780
// Size: 0x5c
function function_535de102() {
    self player::function_2a67df65(#"talent_juggernog", zombie_utility::function_d2dfacfd(#"zombie_perk_juggernaut_health"));
    self zm_utility::set_max_health();
}

// Namespace namespace_7461932d/namespace_7461932d
// Params 4, eflags: 0x1 linked
// Checksum 0xcc9ce466, Offset: 0x7e8
// Size: 0x44
function function_8a2f8354(*b_pause, *str_perk, *str_result, *n_slot) {
    self player::function_b933de24(#"talent_juggernog");
}

