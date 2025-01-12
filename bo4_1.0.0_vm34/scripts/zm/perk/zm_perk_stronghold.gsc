#using scripts\core_common\clientfield_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_utility;

#namespace zm_perk_stronghold;

// Namespace zm_perk_stronghold/zm_perk_stronghold
// Params 0, eflags: 0x2
// Checksum 0x1f19460, Offset: 0x190
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_perk_stronghold", &__init__, &__main__, undefined);
}

// Namespace zm_perk_stronghold/zm_perk_stronghold
// Params 0, eflags: 0x0
// Checksum 0x3681092, Offset: 0x1e0
// Size: 0x14
function __init__() {
    enable_stronghold_perk_for_level();
}

// Namespace zm_perk_stronghold/zm_perk_stronghold
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x200
// Size: 0x4
function __main__() {
    
}

// Namespace zm_perk_stronghold/zm_perk_stronghold
// Params 0, eflags: 0x0
// Checksum 0x2645fe27, Offset: 0x210
// Size: 0x18c
function enable_stronghold_perk_for_level() {
    zm_perks::register_perk_basic_info(#"specialty_camper", "perk_stronghold", 2500, #"zombie/perk_stronghold", getweapon("zombie_perk_bottle_nuke"), getweapon("zombie_perk_totem_stronghold"), #"zmperksstonecold");
    zm_perks::register_perk_precache_func(#"specialty_camper", &function_99d4f811);
    zm_perks::register_perk_clientfields(#"specialty_camper", &function_88ea7b8b, &function_3ae4d800);
    zm_perks::register_perk_machine(#"specialty_camper", &function_dcfa81f6, &init_stronghold);
    zm_perks::register_perk_threads(#"specialty_camper", &function_972f4ba2, &function_2bf941cc);
    zm::register_actor_damage_callback(&function_4f92218f);
}

// Namespace zm_perk_stronghold/zm_perk_stronghold
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x3a8
// Size: 0x4
function init_stronghold() {
    
}

// Namespace zm_perk_stronghold/zm_perk_stronghold
// Params 0, eflags: 0x0
// Checksum 0xbcaab933, Offset: 0x3b8
// Size: 0x10e
function function_99d4f811() {
    if (isdefined(level.var_d3c7ad61)) {
        [[ level.var_d3c7ad61 ]]();
        return;
    }
    level._effect[#"divetonuke_light"] = #"hash_2225287695ddf9c9";
    level.machine_assets[#"specialty_camper"] = spawnstruct();
    level.machine_assets[#"specialty_camper"].weapon = getweapon("zombie_perk_bottle_nuke");
    level.machine_assets[#"specialty_camper"].off_model = "p7_zm_vending_nuke";
    level.machine_assets[#"specialty_camper"].on_model = "p7_zm_vending_nuke";
}

// Namespace zm_perk_stronghold/zm_perk_stronghold
// Params 0, eflags: 0x0
// Checksum 0xd7f95a47, Offset: 0x4d0
// Size: 0x74
function function_88ea7b8b() {
    clientfield::register("clientuimodel", "hudItems.perks.stronghold", 1, 1, "int");
    clientfield::register("toplayer", "" + #"hash_24e322568c9492c5", 1, 1, "int");
}

// Namespace zm_perk_stronghold/zm_perk_stronghold
// Params 1, eflags: 0x0
// Checksum 0x78b474bd, Offset: 0x550
// Size: 0x2c
function function_3ae4d800(state) {
    self clientfield::set_player_uimodel("hudItems.perks.stronghold", state);
}

// Namespace zm_perk_stronghold/zm_perk_stronghold
// Params 4, eflags: 0x0
// Checksum 0xa2198159, Offset: 0x588
// Size: 0xb6
function function_dcfa81f6(use_trigger, perk_machine, bump_trigger, collision) {
    use_trigger.script_sound = "mus_perks_phd_jingle";
    use_trigger.script_string = "divetonuke_perk";
    use_trigger.script_label = "mus_perks_phd_sting";
    use_trigger.target = "vending_divetonuke";
    perk_machine.script_string = "divetonuke_perk";
    perk_machine.targetname = "vending_divetonuke";
    if (isdefined(bump_trigger)) {
        bump_trigger.script_string = "divetonuke_perk";
    }
}

// Namespace zm_perk_stronghold/zm_perk_stronghold
// Params 0, eflags: 0x0
// Checksum 0x2fd07c48, Offset: 0x648
// Size: 0x1c
function function_972f4ba2() {
    self thread function_fd84cbc6();
}

// Namespace zm_perk_stronghold/zm_perk_stronghold
// Params 3, eflags: 0x0
// Checksum 0x23fbeae6, Offset: 0x670
// Size: 0x4c
function function_2bf941cc(b_pause, str_perk, str_result) {
    self notify(#"specialty_camper" + "_take");
    self function_614392a7();
}

// Namespace zm_perk_stronghold/zm_perk_stronghold
// Params 0, eflags: 0x0
// Checksum 0x3f4dbcd8, Offset: 0x6c8
// Size: 0x148
function function_fd84cbc6() {
    self endon(#"specialty_camper" + "_take", #"disconnect");
    while (true) {
        if (!self laststand::player_is_in_laststand() && !self util::is_spectating()) {
            v_current = self.origin;
            if (!isdefined(self.var_22c4c9b)) {
                self.var_22c4c9b = v_current;
            }
            n_dist = distance(self.var_22c4c9b, v_current);
            if (n_dist <= 130) {
                if (!isdefined(self.var_688579d3)) {
                    self.var_688579d3 = 0;
                }
                self.var_688579d3++;
                self thread function_cc4f6dc1(self.var_688579d3);
            } else {
                self function_614392a7();
            }
        } else {
            self function_614392a7();
        }
        wait 0.25;
    }
}

// Namespace zm_perk_stronghold/zm_perk_stronghold
// Params 0, eflags: 0x0
// Checksum 0x85e90550, Offset: 0x818
// Size: 0x6e
function function_614392a7() {
    self clientfield::set_to_player("" + #"hash_24e322568c9492c5", 0);
    self zm_utility::function_34517e89(#"stronghold_armor", 1);
    self.var_22c4c9b = undefined;
    self.var_688579d3 = undefined;
    self.var_e284d502 = undefined;
}

// Namespace zm_perk_stronghold/zm_perk_stronghold
// Params 1, eflags: 0x0
// Checksum 0xb734a71f, Offset: 0x890
// Size: 0xbc
function function_cc4f6dc1(var_cb069944) {
    var_63b8485b = int(3 / 0.25);
    if (var_cb069944 == var_63b8485b) {
        self clientfield::set_to_player("" + #"hash_24e322568c9492c5", 1);
    }
    if (var_cb069944 % var_63b8485b == 0) {
        self add_armor();
        self function_6189aee2();
    }
}

// Namespace zm_perk_stronghold/zm_perk_stronghold
// Params 0, eflags: 0x0
// Checksum 0xb73f0e54, Offset: 0x958
// Size: 0x2c
function add_armor() {
    self zm_utility::add_armor(#"stronghold_armor", 5, 50);
}

// Namespace zm_perk_stronghold/zm_perk_stronghold
// Params 0, eflags: 0x0
// Checksum 0x81b2feae, Offset: 0x990
// Size: 0x5a
function function_6189aee2() {
    if (!isdefined(self.var_e284d502)) {
        self.var_e284d502 = 0;
    }
    self.var_e284d502 += 1;
    self.var_e284d502 = math::clamp(self.var_e284d502, 0, 15);
}

// Namespace zm_perk_stronghold/zm_perk_stronghold
// Params 12, eflags: 0x0
// Checksum 0x82feaac3, Offset: 0x9f8
// Size: 0xda
function function_4f92218f(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (isplayer(attacker) && attacker hasperk(#"specialty_camper")) {
        if (isdefined(attacker.var_e284d502)) {
            damage += damage * attacker.var_e284d502 / 100;
            return damage;
        }
    }
    return -1;
}

