#using scripts\abilities\gadgets\gadget_concertina_wire;
#using scripts\abilities\gadgets\gadget_smart_cover;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\bots\bot_action;
#using scripts\core_common\bots\bot_position;
#using scripts\core_common\debug_shared;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\mp_common\supplypod;
#using scripts\mp_common\teams\teams;
#using scripts\weapons\deployable;
#using scripts\weapons\localheal;

#namespace mp_bot_action;

// Namespace mp_bot_action/mp_bot_action
// Params 0, eflags: 0x2
// Checksum 0xa3d5c6c, Offset: 0x140
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"mp_bot_action", &__init__, &__main__, undefined);
}

// Namespace mp_bot_action/mp_bot_action
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x190
// Size: 0x4
function __init__() {
    
}

// Namespace mp_bot_action/mp_bot_action
// Params 0, eflags: 0x0
// Checksum 0x6d50a9e9, Offset: 0x1a0
// Size: 0x94
function __main__() {
    level bot_action::register_actions();
    level bot_action::register_weapons();
    level bot_action::function_47e27c09();
    level register_actions();
    level register_weapons();
    level function_47e27c09();
}

// Namespace mp_bot_action/mp_bot_action
// Params 0, eflags: 0x0
// Checksum 0x3a0058d1, Offset: 0x240
// Size: 0x184
function register_actions() {
    bot_action::register_action(#"activate_health_gadget", &bot_action::weapon_rank, &function_858b2fc5, &bot_action::activate_health_gadget);
    bot_action::register_action(#"hash_63c5000998c406e2", &bot_action::weapon_rank, &bot_action::function_a2af4bd4, &bot_action::test_gadget);
    bot_action::register_action(#"hash_7f17997c50415cb7", &bot_action::weapon_rank, &bot_action::function_1ed83677, &bot_action::test_gadget);
    bot_action::register_action(#"hash_291f02a64600bb72", &bot_action::weapon_rank, &bot_action::function_dcf6e9c8, &bot_action::test_gadget);
    if (!sessionmodeiswarzonegame()) {
        self function_f56197a6();
        self function_36bf8ccf();
    }
}

// Namespace mp_bot_action/mp_bot_action
// Params 0, eflags: 0x0
// Checksum 0x69cfa501, Offset: 0x3d0
// Size: 0xd4
function register_weapons() {
    bot_action::register_weapon(#"knife_held", &bot_action::function_b0efcdba);
    bot_action::register_weapon(#"bare_hands", &bot_action::function_b0efcdba);
    bot_action::function_60a0d9d4(#"gadget_health_regen", &bot_action::function_dde10d2d, &bot_action::function_56ed213a);
    self function_92cc182c();
    self function_58ecb955();
}

// Namespace mp_bot_action/mp_bot_action
// Params 0, eflags: 0x0
// Checksum 0x8b87d55b, Offset: 0x4b0
// Size: 0xc4
function function_47e27c09() {
    bot_action::function_eeecc088(#"knife_held", #"melee_enemy");
    bot_action::function_eeecc088(#"bare_hands", #"melee_enemy");
    bot_action::function_3800d421(#"gadget_health_regen", #"activate_health_gadget");
    self function_2067a951();
    self function_89277242();
}

// Namespace mp_bot_action/mp_bot_action
// Params 0, eflags: 0x0
// Checksum 0x4b18cd28, Offset: 0x580
// Size: 0x644
function function_f56197a6() {
    bot_action::register_action(#"hash_a6fbea4921c5d8e", &bot_action::weapon_rank, &function_443ece83, &bot_action::throw_offhand);
    bot_action::register_action(#"hash_6aa707f0052e859e", &bot_action::weapon_rank, &function_d238266f, &function_5165b86c);
    bot_action::register_action(#"hash_1d80baac9c58b08a", &bot_action::weapon_rank, &function_443ece83, &bot_action::throw_offhand);
    bot_action::register_action(#"hash_114186051577bd71", &bot_action::weapon_rank, &function_895a8fc8, &function_9ffae835);
    bot_action::register_action(#"hash_263b2b7d778dd52c", &bot_action::weapon_rank, &function_bb6ac7b5, &function_23401dd2);
    bot_action::register_action(#"activate_localheal", &bot_action::weapon_rank, &function_10815e3, &activate_localheal);
    bot_action::register_action(#"activate_radiation_field", &bot_action::weapon_rank, &function_b723a226, &activate_radiation_field);
    bot_action::register_action(#"hash_6f125d5b8b441bc9", &bot_action::weapon_rank, &function_c4c480f8, &function_e7df1ea5);
    bot_action::register_action(#"use_tripwire", &bot_action::weapon_rank, &function_50a93b1e, &use_tripwire);
    bot_action::register_action(#"activate_dog", &bot_action::weapon_rank, &function_5859eef8, &activate_dog);
    bot_action::register_action(#"hash_2130f8922bfb5fcb", &bot_action::weapon_rank, &function_91d4449a, &function_7a0bed17);
    bot_action::register_action(#"hash_1b15f82869ce09f5", &bot_action::weapon_rank, &function_e651c3f8, &function_bb6d77a5);
    bot_action::register_action(#"hash_4600e058d958fc21", &bot_action::weapon_rank, &bot_action::function_dcf6e9c8, &function_9e3fd2b1);
    bot_action::register_action(#"activate_vision_pulse", &bot_action::weapon_rank, &bot_action::function_dcf6e9c8, &activate_vision_pulse);
    bot_action::register_action(#"activate_noncombat_grapple", &bot_action::weapon_rank, &function_a494bae5, &function_87105e02);
    bot_action::register_action(#"activate_gravity_slam", &bot_action::weapon_rank, &function_7120ed6a, &activate_gravity_slam);
    bot_action::register_action(#"deploy_spawnbeacon", &bot_action::weapon_rank, &function_a1a70a3, &deploy_spawnbeacon);
    bot_action::register_action(#"hash_1a86e37616fff7c0", &bot_action::weapon_rank, &function_ae68b6e5, &function_9b139202);
    bot_action::register_action(#"hash_17f1a25f8c10e1cd", &bot_action::weapon_rank, &function_f9d881c, &function_ead4e8e9);
    bot_action::register_action(#"hash_5d6b13cfb592ee04", &bot_action::weapon_rank, &function_8971279, &function_12572886);
}

// Namespace mp_bot_action/mp_bot_action
// Params 0, eflags: 0x0
// Checksum 0xa867b300, Offset: 0xbd0
// Size: 0x4b4
function function_36bf8ccf() {
    bot_action::register_action(#"ac130", &bot_action::function_63fd8e23, &function_f26245f2, &function_5e4b3210);
    bot_action::register_action(#"tank_robot", &bot_action::function_63fd8e23, &function_3937668a, &function_7bd59908);
    bot_action::register_action(#"counteruav", &bot_action::function_63fd8e23, &function_4ebe60b1, &function_5e4b3210);
    bot_action::register_action(#"dart", &bot_action::function_63fd8e23, &function_29cee5f1, &function_50b82c89);
    bot_action::register_action(#"drone_squadron", &bot_action::function_63fd8e23, &function_f26245f2, &function_5e4b3210);
    bot_action::register_action(#"helicopter_comlink", &bot_action::function_63fd8e23, &function_f26245f2, &function_5e4b3210);
    bot_action::register_action(#"overwatch_helicopter", &bot_action::function_63fd8e23, &function_f26245f2, &function_5e4b3210);
    bot_action::register_action(#"planemortar", &bot_action::function_63fd8e23, &function_f26245f2, &function_1d5644ef);
    bot_action::register_action(#"recon_car", &bot_action::function_63fd8e23, &function_f26245f2, &function_5e4b3210);
    bot_action::register_action(#"remote_missile", &bot_action::function_63fd8e23, &function_f26245f2, &function_95ecb3a4);
    bot_action::register_action(#"straferun", &bot_action::function_63fd8e23, &function_f26245f2, &function_5e4b3210);
    bot_action::register_action(#"supply_drop", &bot_action::function_63fd8e23, &function_3937668a, &function_7bd59908);
    bot_action::register_action(#"swat_team", &bot_action::function_63fd8e23, &function_3937668a, &function_7bd59908);
    bot_action::register_action(#"uav", &bot_action::function_63fd8e23, &function_f26245f2, &function_5e4b3210);
    bot_action::register_action(#"ultimate_turret", &bot_action::function_63fd8e23, &function_498a51f3, &activate_turret);
}

// Namespace mp_bot_action/mp_bot_action
// Params 0, eflags: 0x0
// Checksum 0x7d8d40c3, Offset: 0x1090
// Size: 0x604
function function_92cc182c() {
    bot_action::function_60a0d9d4(#"eq_swat_grenade", &bot_action::function_2407c50c, &bot_action::function_56ed213a);
    bot_action::function_60a0d9d4(#"sig_buckler_dw", &bot_action::function_fdf4c25, &bot_action::function_6e41259d);
    bot_action::function_60a0d9d4(#"eq_cluster_semtex_grenade", &bot_action::function_2407c50c, &bot_action::function_56ed213a);
    bot_action::function_60a0d9d4(#"hero_pineapplegun", &bot_action::function_fdf4c25, &bot_action::function_6e41259d);
    bot_action::function_60a0d9d4(#"gadget_supplypod", &bot_action::function_fdf4c25, &bot_action::function_56ed213a);
    bot_action::function_60a0d9d4(#"eq_localheal", &bot_action::function_2407c50c, &bot_action::function_56ed213a);
    bot_action::function_60a0d9d4(#"gadget_radiation_field", &bot_action::function_fdf4c25, &bot_action::function_56ed213a);
    bot_action::function_60a0d9d4(#"hero_flamethrower", &bot_action::function_dde10d2d, &bot_action::function_6e41259d);
    bot_action::function_60a0d9d4(#"eq_tripwire", &bot_action::function_2407c50c, &bot_action::function_56ed213a);
    bot_action::function_60a0d9d4(#"ability_dog", &bot_action::function_fdf4c25, &bot_action::function_ae33d394);
    bot_action::function_60a0d9d4(#"eq_seeker_mine", &bot_action::function_2407c50c, &bot_action::function_56ed213a);
    bot_action::function_60a0d9d4(#"shock_rifle", &bot_action::function_fdf4c25, &bot_action::function_6e41259d);
    bot_action::function_60a0d9d4(#"eq_sensor", &bot_action::function_2407c50c, &bot_action::function_56ed213a);
    bot_action::function_60a0d9d4(#"gadget_vision_pulse", &bot_action::function_fdf4c25, &bot_action::function_56ed213a);
    bot_action::function_60a0d9d4(#"eq_grapple", &bot_action::function_2407c50c, &bot_action::function_56ed213a);
    bot_action::function_60a0d9d4(#"eq_gravityslam", &bot_action::function_fdf4c25, &bot_action::function_56ed213a);
    bot_action::function_60a0d9d4(#"gadget_spawnbeacon", &bot_action::function_2407c50c, &bot_action::function_56ed213a);
    bot_action::function_60a0d9d4(#"hero_annihilator", &bot_action::function_dde10d2d, &bot_action::function_6e41259d);
    bot_action::function_60a0d9d4(#"eq_concertina_wire", &bot_action::function_2407c50c, &bot_action::function_56ed213a);
    bot_action::function_60a0d9d4(#"ability_smart_cover", &bot_action::function_fdf4c25, &bot_action::function_56ed213a);
    bot_action::function_60a0d9d4(#"eq_sticky_grenade", &bot_action::function_2407c50c, &bot_action::function_56ed213a);
    bot_action::function_60a0d9d4(#"eq_slow_grenade", &bot_action::function_2407c50c, &bot_action::function_56ed213a);
    bot_action::function_60a0d9d4(#"frag_grenade", &bot_action::function_2407c50c, &bot_action::function_56ed213a);
    bot_action::function_60a0d9d4(#"hatchet", &bot_action::function_2407c50c, &bot_action::function_56ed213a);
}

// Namespace mp_bot_action/mp_bot_action
// Params 0, eflags: 0x0
// Checksum 0x9bd6a547, Offset: 0x16a0
// Size: 0x3c4
function function_58ecb955() {
    bot_action::function_b25b7c5a(#"ac130", &bot_action::function_d269dfe1, &bot_action::function_d68a136d);
    bot_action::function_b25b7c5a(#"ai_tank_marker", &bot_action::function_d269dfe1, &bot_action::function_d68a136d);
    bot_action::function_b25b7c5a(#"counteruav", &bot_action::function_d269dfe1, &bot_action::function_d68a136d);
    bot_action::function_b25b7c5a(#"dart", &bot_action::function_d269dfe1, &bot_action::function_d68a136d);
    bot_action::function_b25b7c5a(#"drone_squadron", &bot_action::function_d269dfe1, &bot_action::function_d68a136d);
    bot_action::function_b25b7c5a(#"helicopter_comlink", &bot_action::function_d269dfe1, &bot_action::function_d68a136d);
    bot_action::function_b25b7c5a(#"overwatch_helicopter", &bot_action::function_d269dfe1, &bot_action::function_d68a136d);
    bot_action::function_b25b7c5a(#"planemortar", &bot_action::function_d269dfe1, &bot_action::function_d68a136d);
    bot_action::function_b25b7c5a(#"recon_car", &bot_action::function_d269dfe1, &bot_action::function_d68a136d);
    bot_action::function_b25b7c5a(#"remote_missile", &bot_action::function_d269dfe1, &bot_action::function_d68a136d);
    bot_action::function_b25b7c5a(#"straferun", &bot_action::function_d269dfe1, &bot_action::function_d68a136d);
    bot_action::function_b25b7c5a(#"supplydrop_marker", &bot_action::function_d269dfe1, &bot_action::function_d68a136d);
    bot_action::function_b25b7c5a(#"swat_team", &bot_action::function_d269dfe1, &bot_action::function_d68a136d);
    bot_action::function_b25b7c5a(#"uav", &bot_action::function_d269dfe1, &bot_action::function_d68a136d);
    bot_action::function_b25b7c5a(#"ultimate_turret", &bot_action::function_d269dfe1, &bot_action::function_d68a136d);
}

// Namespace mp_bot_action/mp_bot_action
// Params 0, eflags: 0x0
// Checksum 0xfc04e82a, Offset: 0x1a70
// Size: 0x634
function function_2067a951() {
    bot_action::function_3800d421(#"eq_swat_grenade", #"hash_a6fbea4921c5d8e");
    bot_action::function_3800d421(#"sig_buckler_dw", #"hash_6aa707f0052e859e");
    bot_action::function_eeecc088(#"sig_buckler_dw", #"hash_7aaeac32a4e1bf84");
    bot_action::function_eeecc088(#"sig_buckler_dw", #"hash_434716893aa869f3");
    bot_action::function_3800d421(#"eq_cluster_semtex_grenade", #"hash_1d80baac9c58b08a");
    bot_action::function_3800d421(#"hero_pineapplegun", #"hash_114186051577bd71");
    bot_action::function_eeecc088(#"hero_pineapplegun", #"fire_grenade");
    bot_action::function_3800d421(#"gadget_supplypod", #"hash_263b2b7d778dd52c");
    bot_action::function_3800d421(#"eq_localheal", #"activate_localheal");
    bot_action::function_3800d421(#"gadget_radiation_field", #"activate_radiation_field");
    bot_action::function_3800d421(#"hero_flamethrower", #"hash_6f125d5b8b441bc9");
    bot_action::function_eeecc088(#"hero_flamethrower", #"hash_7aaeac32a4e1bf84");
    bot_action::function_eeecc088(#"hero_flamethrower", #"hash_434716893aa869f3");
    bot_action::function_3800d421(#"eq_tripwire", #"use_tripwire");
    bot_action::function_3800d421(#"ability_dog", #"activate_dog");
    bot_action::function_3800d421(#"eq_seeker_mine", #"hash_2130f8922bfb5fcb");
    bot_action::function_3800d421(#"shock_rifle", #"hash_1b15f82869ce09f5");
    bot_action::function_eeecc088(#"shock_rifle", #"hash_7aaeac32a4e1bf84");
    bot_action::function_eeecc088(#"shock_rifle", #"hash_434716893aa869f3");
    bot_action::function_3800d421(#"eq_sensor", #"hash_4600e058d958fc21");
    bot_action::function_3800d421(#"gadget_vision_pulse", #"activate_vision_pulse");
    bot_action::function_3800d421(#"eq_grapple", #"activate_noncombat_grapple");
    bot_action::function_3800d421(#"eq_gravityslam", #"activate_gravity_slam");
    bot_action::function_3800d421(#"gadget_spawnbeacon", #"deploy_spawnbeacon");
    bot_action::function_3800d421(#"hero_annihilator", #"hash_1a86e37616fff7c0");
    bot_action::function_eeecc088(#"hero_annihilator", #"hash_7aaeac32a4e1bf84");
    bot_action::function_eeecc088(#"hero_annihilator", #"hash_434716893aa869f3");
    bot_action::function_3800d421(#"eq_concertina_wire", #"hash_17f1a25f8c10e1cd");
    bot_action::function_3800d421(#"ability_smart_cover", #"hash_5d6b13cfb592ee04");
    bot_action::function_3800d421(#"eq_sticky_grenade", #"hash_1d80baac9c58b08a");
    bot_action::function_3800d421(#"eq_slow_grenade", #"hash_a6fbea4921c5d8e");
    bot_action::function_3800d421(#"frag_grenade", #"hash_a6fbea4921c5d8e");
    bot_action::function_3800d421(#"hatchet", #"hash_a6fbea4921c5d8e");
}

// Namespace mp_bot_action/mp_bot_action
// Params 0, eflags: 0x0
// Checksum 0x13d15e71, Offset: 0x20b0
// Size: 0x2d4
function function_89277242() {
    bot_action::function_3800d421(#"ac130", #"ac130");
    bot_action::function_3800d421(#"ai_tank_marker", #"tank_robot");
    bot_action::function_3800d421(#"counteruav", #"counteruav");
    bot_action::function_3800d421(#"dart", #"dart");
    bot_action::function_3800d421(#"drone_squadron", #"drone_squadron");
    bot_action::function_3800d421(#"helicopter_comlink", #"helicopter_comlink");
    bot_action::function_3800d421(#"overwatch_helicopter", #"overwatch_helicopter");
    bot_action::function_3800d421(#"planemortar", #"planemortar");
    bot_action::function_3800d421(#"recon_car", #"recon_car");
    bot_action::function_3800d421(#"remote_missile", #"remote_missile");
    bot_action::function_3800d421(#"straferun", #"straferun");
    bot_action::function_3800d421(#"supplydrop_marker", #"supply_drop");
    bot_action::function_3800d421(#"swat_team", #"swat_team");
    bot_action::function_3800d421(#"uav", #"uav");
    bot_action::function_3800d421(#"ultimate_turret", #"ultimate_turret");
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0xaf1f4ad1, Offset: 0x2390
// Size: 0x542
function function_858b2fc5(actionparams) {
    weapon = actionparams.weapon;
    slot = self gadgetgetslot(weapon);
    if (!self bot_action::function_70df76df(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x30>";
        #/
        return undefined;
    }
    if (isdefined(self.heal.enabled) && self.heal.enabled) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x52>";
        #/
        return undefined;
    }
    pathenemyfightdist = self.bot.tacbundle.pathenemyfightdist;
    if (!self ai::get_behavior_attribute("ignorepathenemyfightdist") && isdefined(self.enemy) && isdefined(pathenemyfightdist) && pathenemyfightdist > 0 && distance2dsquared(self.origin, self.enemy.origin) < pathenemyfightdist * pathenemyfightdist) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x5a>";
        #/
        return undefined;
    }
    /#
        if (!isdefined(actionparams.debug)) {
            actionparams.debug = [];
        } else if (!isarray(actionparams.debug)) {
            actionparams.debug = array(actionparams.debug);
        }
        actionparams.debug[actionparams.debug.size] = "<dev string:x66>" + self.health + "<dev string:x6f>" + self.maxhealth;
    #/
    healthratio = self.health / self.maxhealth;
    if (healthratio > self.bot.tacbundle.var_b7baa2a0) {
        return undefined;
    }
    power = self gadgetpowerget(slot);
    /#
        if (!isdefined(actionparams.debug)) {
            actionparams.debug = [];
        } else if (!isarray(actionparams.debug)) {
            actionparams.debug = array(actionparams.debug);
        }
        actionparams.debug[actionparams.debug.size] = "<dev string:x71>" + power;
    #/
    if (!self gadgetisready(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x79>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0xb454dd35, Offset: 0x28e0
// Size: 0x582
function function_633f7b3(actionparams) {
    actionparams.target = self.enemy;
    weapon = actionparams.weapon;
    slot = self gadgetgetslot(weapon);
    if (!self bot_action::function_70df76df(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x30>";
        #/
        return undefined;
    }
    if (!self gadgetisready(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x83>";
        #/
        return undefined;
    }
    if (!self bot::in_combat()) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x94>";
        #/
        return undefined;
    }
    if (!self bot_action::is_target_visible(actionparams)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:xa2>";
        #/
        return undefined;
    }
    if (self bot_action::function_417d9dbe(actionparams)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:xb3>";
        #/
        return undefined;
    }
    self bot_action::function_3e1dfdce(actionparams, "tag_origin");
    self bot_action::function_e9fddff3(actionparams);
    self bot_action::function_8b5bb921(actionparams);
    if (!isdefined(actionparams.var_7ac9e90b)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:xc7>";
        #/
        return undefined;
    }
    self bot_action::function_7e5f837a(actionparams);
    if (!self bot_action::function_ed41018(actionparams)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:xe9>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0x6c8903ab, Offset: 0x2e70
// Size: 0x562
function function_443ece83(actionparams) {
    actionparams.target = self.enemy;
    weapon = actionparams.weapon;
    slot = self gadgetgetslot(weapon);
    if (!self bot_action::function_70df76df(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x30>";
        #/
        return undefined;
    }
    if (!self gadgetisready(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x83>";
        #/
        return undefined;
    }
    if (!self bot::in_combat()) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x94>";
        #/
        return undefined;
    }
    if (!self bot_action::is_target_visible(actionparams)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:xa2>";
        #/
        return undefined;
    }
    if (self bot_action::function_417d9dbe(actionparams)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:xb3>";
        #/
        return undefined;
    }
    self bot_action::function_e9fddff3(actionparams);
    self bot_action::function_8b5bb921(actionparams);
    if (!isdefined(actionparams.var_7ac9e90b)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:xc7>";
        #/
        return undefined;
    }
    self bot_action::function_7e5f837a(actionparams);
    if (!self bot_action::function_ed41018(actionparams)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:xe9>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0x66f4f462, Offset: 0x33e0
// Size: 0x56a
function function_b723a226(actionparams) {
    actionparams.target = self.enemy;
    weapon = actionparams.weapon;
    slot = self gadgetgetslot(weapon);
    if (!self bot_action::function_70df76df(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x30>";
        #/
        return undefined;
    }
    if (!self bot::in_combat()) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x94>";
        #/
        return undefined;
    }
    if (!self bot_action::is_target_visible(actionparams)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:xa2>";
        #/
        return undefined;
    }
    if (distance2dsquared(self.origin, self.enemy.origin) > 40000) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x101>";
        #/
        return undefined;
    }
    if (!self gadgetisready(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x83>";
        #/
        return undefined;
    }
    if (isdefined(self.heal.enabled) && self.heal.enabled) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x52>";
        #/
        return undefined;
    }
    healthratio = self.health / self.maxhealth;
    if (healthratio <= self.bot.tacbundle.var_b7baa2a0) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x117>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0x932aeef9, Offset: 0x3958
// Size: 0x196
function activate_radiation_field(actionparams) {
    weapon = actionparams.weapon;
    self bot_action::function_a5d700ec(weapon);
    slot = self gadgetgetslot(weapon);
    button = self function_628f19f9(weapon);
    while (!self gadgetisactive(slot)) {
        self bottapbutton(button);
        self waittill(#"hash_347a612b61067eb3");
    }
    while (self gadgetisactive(slot) && self.health > 20) {
        self bottapbutton(button);
        self waittill(#"hash_347a612b61067eb3");
    }
    while (self isthrowinggrenade() || !self function_a3ec3e() || self getcurrentweapon() == level.weaponnone) {
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0xbf560eb3, Offset: 0x3af8
// Size: 0x32a
function function_7120ed6a(actionparams) {
    actionparams.target = self.enemy;
    weapon = actionparams.weapon;
    slot = self gadgetgetslot(weapon);
    if (!self bot_action::function_70df76df(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x30>";
        #/
        return undefined;
    }
    if (!self bot::in_combat()) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x94>";
        #/
        return undefined;
    }
    if (!self bot_action::is_target_visible(actionparams)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:xa2>";
        #/
        return undefined;
    }
    if (distance2dsquared(self.origin, self.enemy.origin) > 40000) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x101>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0xdb25b95f, Offset: 0x3e30
// Size: 0xae
function activate_gravity_slam(actionparams) {
    weapon = actionparams.weapon;
    self bot_action::function_a5d700ec(weapon);
    while (self isthrowinggrenade() || !self function_a3ec3e() || self getcurrentweapon() == level.weaponnone) {
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0x7f2c46d, Offset: 0x3ee8
// Size: 0x31a
function function_ae68b6e5(actionparams) {
    weapon = actionparams.weapon;
    slot = self gadgetgetslot(weapon);
    if (!self bot_action::function_70df76df(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x30>";
        #/
        return undefined;
    }
    if (!self gadgetisready(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x83>";
        #/
        return undefined;
    }
    if (!self bot::in_combat()) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x94>";
        #/
        return undefined;
    }
    if (!isdefined(self.enemy) || !isalive(self.enemy)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x122>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0x204e2012, Offset: 0x4210
// Size: 0x6e
function function_9b139202(actionparams) {
    weapon = actionparams.weapon;
    self bot_action::function_a5d700ec(weapon);
    while (self isswitchingweapons()) {
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0x7f7aba53, Offset: 0x4288
// Size: 0x31a
function function_e651c3f8(actionparams) {
    weapon = actionparams.weapon;
    slot = self gadgetgetslot(weapon);
    if (!self bot_action::function_70df76df(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x30>";
        #/
        return undefined;
    }
    if (!self gadgetisready(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x83>";
        #/
        return undefined;
    }
    if (!self bot::in_combat()) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x94>";
        #/
        return undefined;
    }
    if (!isdefined(self.enemy) || !isalive(self.enemy)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x122>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0x8bc7c217, Offset: 0x45b0
// Size: 0x6e
function function_bb6d77a5(actionparams) {
    weapon = actionparams.weapon;
    self bot_action::function_a5d700ec(weapon);
    while (self isswitchingweapons()) {
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0x5421c7cf, Offset: 0x4628
// Size: 0x31a
function function_895a8fc8(actionparams) {
    weapon = actionparams.weapon;
    slot = self gadgetgetslot(weapon);
    if (!self bot_action::function_70df76df(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x30>";
        #/
        return undefined;
    }
    if (!self gadgetisready(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x83>";
        #/
        return undefined;
    }
    if (!self bot::in_combat()) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x94>";
        #/
        return undefined;
    }
    if (!isdefined(self.enemy) || !isalive(self.enemy)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x122>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0x18534cdf, Offset: 0x4950
// Size: 0x6e
function function_9ffae835(actionparams) {
    weapon = actionparams.weapon;
    self bot_action::function_a5d700ec(weapon);
    while (self isswitchingweapons()) {
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0xe8dd15a5, Offset: 0x49c8
// Size: 0x31a
function function_c4c480f8(actionparams) {
    weapon = actionparams.weapon;
    slot = self gadgetgetslot(weapon);
    if (!self bot_action::function_70df76df(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x30>";
        #/
        return undefined;
    }
    if (!self gadgetisready(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x83>";
        #/
        return undefined;
    }
    if (!self bot::in_combat()) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x94>";
        #/
        return undefined;
    }
    if (!isdefined(self.enemy) || !isalive(self.enemy)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x122>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0x7c48a55a, Offset: 0x4cf0
// Size: 0x6e
function function_e7df1ea5(actionparams) {
    weapon = actionparams.weapon;
    self bot_action::function_a5d700ec(weapon);
    while (self isswitchingweapons()) {
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0x19045de9, Offset: 0x4d68
// Size: 0x25e
function function_4caebcd4(actionparams) {
    weapon = actionparams.weapon;
    self bot_action::function_a5d700ec(weapon);
    while (!self function_a3ec3e() || self getcurrentweapon() == level.weaponnone) {
        self waittill(#"hash_347a612b61067eb3");
    }
    shots_fired = 0;
    players = getplayers();
    foreach (player in players) {
        if (player.team != self.team && isalive(player)) {
            self notify(#"confirm_location", {#position:player.origin, #yaw:0});
            shots_fired++;
            if (shots_fired == 3) {
                break;
            }
            self waittill(#"hash_347a612b61067eb3");
        }
    }
    while (shots_fired < 3) {
        self botpressbutton(16);
        self waittill(#"hash_347a612b61067eb3");
        shots_fired++;
    }
    while (!self function_a3ec3e() || self getcurrentweapon() == level.weaponnone) {
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0xe3132e8d, Offset: 0x4fd0
// Size: 0x1de
function function_1ccb07f8(actionparams) {
    weapon = actionparams.weapon;
    self bot_action::function_a5d700ec(weapon);
    while (!self function_a3ec3e() || self getcurrentweapon() == level.weaponnone) {
        self waittill(#"hash_347a612b61067eb3");
    }
    players = getplayers();
    foreach (player in players) {
        if (player.team != self.team && isalive(player)) {
            self notify(#"confirm_location", {#position:player.origin, #yaw:0});
            break;
        }
    }
    while (!self function_a3ec3e() || self getcurrentweapon() == level.weaponnone) {
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0x1430317, Offset: 0x51b8
// Size: 0x40a
function function_a494bae5(actionparams) {
    weapon = actionparams.weapon;
    slot = self gadgetgetslot(weapon);
    if (!self bot_action::function_70df76df(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x30>";
        #/
        return undefined;
    }
    if (!self gadgetisready(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x83>";
        #/
        return undefined;
    }
    if (self bot::has_visible_enemy()) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x12b>";
        #/
        return undefined;
    }
    var_2d0df182 = self function_28dbe634();
    if (!isdefined(var_2d0df182)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x139>";
        #/
        return undefined;
    }
    target = var_2d0df182.var_92706ab9 + (0, 0, 100);
    if (distance2dsquared(target, self.origin) < 22500) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x143>";
        #/
        return undefined;
    }
    actionparams.target = target;
    return 100;
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0x141fb5e, Offset: 0x55d0
// Size: 0x20e
function function_87105e02(actionparams) {
    weapon = actionparams.weapon;
    if (!isdefined(weapon)) {
        /#
            self botprinterror("<invalid>" + "<dev string:x179>");
        #/
        self waittill(#"hash_347a612b61067eb3");
        return;
    }
    self bot_action::function_a5d700ec(weapon);
    button = self function_628f19f9(weapon);
    self bot_action::function_e9fddff3(actionparams);
    self bot_action::aim_at_target(actionparams);
    while (self botgetlookdot() < 0.98 || self istraversing()) {
        self bottapbutton(button);
        self waittill(#"hash_347a612b61067eb3");
        self bot_action::function_e9fddff3(actionparams);
        self bot_action::aim_at_target(actionparams);
    }
    slot = self gadgetgetslot(weapon);
    while (!self gadgetisprimed(slot)) {
        self waittill(#"hash_347a612b61067eb3");
    }
    while (!self isgrappling()) {
        if (!self gadgetisprimed(slot)) {
            break;
        }
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0x23f0aec6, Offset: 0x57e8
// Size: 0xde
function function_bb5deacf(actionparams) {
    weapon = actionparams.weapon;
    if (!isdefined(weapon)) {
        /#
            self botprinterror("<invalid>" + "<dev string:x179>");
        #/
        self waittill(#"hash_347a612b61067eb3");
        return;
    }
    self bot_action::function_a5d700ec(weapon);
    while (!self function_a3ec3e() || self getcurrentweapon() == level.weaponnone) {
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0xf444dbf1, Offset: 0x58d0
// Size: 0x38e
function function_a1a70a3(actionparams) {
    weapon = actionparams.weapon;
    slot = self gadgetgetslot(weapon);
    if (!self bot_action::function_70df76df(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x30>";
        #/
        return undefined;
    }
    if (!self gadgetisready(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x83>";
        #/
        return undefined;
    }
    if (self bot::has_visible_enemy()) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x12b>";
        #/
        return undefined;
    }
    var_72de6a50 = getarraykeys(level.spawnbeaconsettings.userspawnbeacons);
    foreach (var_b26b1ab8 in var_72de6a50) {
        if (var_b26b1ab8 == self.clientid) {
            /#
                if (!isdefined(actionparams.debug)) {
                    actionparams.debug = [];
                } else if (!isarray(actionparams.debug)) {
                    actionparams.debug = array(actionparams.debug);
                }
                actionparams.debug[actionparams.debug.size] = "<dev string:x1a9>";
            #/
            return undefined;
        }
    }
    return 100;
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0x282d80cb, Offset: 0x5c68
// Size: 0xde
function deploy_spawnbeacon(actionparams) {
    weapon = actionparams.weapon;
    if (!isdefined(weapon)) {
        /#
            self botprinterror("<invalid>" + "<dev string:x179>");
        #/
        self waittill(#"hash_347a612b61067eb3");
        return;
    }
    self bot_action::function_a5d700ec(weapon);
    while (!self function_a3ec3e() || self getcurrentweapon() == level.weaponnone) {
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0xd6587fa9, Offset: 0x5d50
// Size: 0xd6
function function_7be40469(actionparams) {
    weapon = actionparams.weapon;
    if (!isdefined(weapon)) {
        /#
            self botprinterror("<invalid>" + "<dev string:x179>");
        #/
        self waittill(#"hash_347a612b61067eb3");
        return;
    }
    self bot_action::function_a5d700ec(weapon);
    slot = self gadgetgetslot(weapon);
    while (self gadgetisready(slot)) {
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0x95a5a0b9, Offset: 0x5e30
// Size: 0x35a
function function_f9d881c(actionparams) {
    weapon = actionparams.weapon;
    slot = self gadgetgetslot(weapon);
    if (!self bot_action::function_70df76df(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x30>";
        #/
        return undefined;
    }
    if (!self gadgetisready(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x83>";
        #/
        return undefined;
    }
    if (self bot::has_visible_enemy()) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x12b>";
        #/
        return undefined;
    }
    angles = self getplayerangles();
    location = self.origin + vectorscale(anglestoforward(angles), 30);
    if (!concertina_wire::function_d90c4119(self).isvalid) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x20a>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0xdb07f2fc, Offset: 0x6198
// Size: 0xde
function function_ead4e8e9(actionparams) {
    weapon = actionparams.weapon;
    if (!isdefined(weapon)) {
        /#
            self botprinterror("<invalid>" + "<dev string:x179>");
        #/
        self waittill(#"hash_347a612b61067eb3");
        return;
    }
    self bot_action::function_a5d700ec(weapon);
    while (!self function_a3ec3e() || self getcurrentweapon() == level.weaponnone) {
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0xced64730, Offset: 0x6280
// Size: 0x35a
function function_8971279(actionparams) {
    weapon = actionparams.weapon;
    slot = self gadgetgetslot(weapon);
    if (!self bot_action::function_70df76df(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x30>";
        #/
        return undefined;
    }
    if (!self gadgetisready(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x83>";
        #/
        return undefined;
    }
    if (self bot::has_visible_enemy()) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x12b>";
        #/
        return undefined;
    }
    angles = self getplayerangles();
    location = self.origin + vectorscale(anglestoforward(angles), 30);
    if (!smart_cover::function_ace879c6(self).isvalid) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x20a>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0xbb683d3, Offset: 0x65e8
// Size: 0xde
function function_12572886(actionparams) {
    weapon = actionparams.weapon;
    if (!isdefined(weapon)) {
        /#
            self botprinterror("<invalid>" + "<dev string:x179>");
        #/
        self waittill(#"hash_347a612b61067eb3");
        return;
    }
    self bot_action::function_a5d700ec(weapon);
    while (!self function_a3ec3e() || self getcurrentweapon() == level.weaponnone) {
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0x774e5066, Offset: 0x66d0
// Size: 0x25a
function function_a345bc9c(actionparams) {
    weapon = actionparams.weapon;
    slot = self gadgetgetslot(weapon);
    if (!self bot_action::function_70df76df(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x30>";
        #/
        return undefined;
    }
    if (!self gadgetisready(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x83>";
        #/
        return undefined;
    }
    if (self bot::has_visible_enemy()) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x12b>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0xbbe03d23, Offset: 0x6938
// Size: 0x126
function function_9c565e69(actionparams) {
    weapon = actionparams.weapon;
    if (!isdefined(weapon)) {
        /#
            self botprinterror("<invalid>" + "<dev string:x179>");
        #/
        self waittill(#"hash_347a612b61067eb3");
        return;
    }
    self bot_action::function_a5d700ec(weapon);
    while (!self function_7229e29e()) {
        self waittill(#"hash_347a612b61067eb3");
    }
    self bottapbutton(0);
    while (!self function_a3ec3e() || self getcurrentweapon() == level.weaponnone) {
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0xeeed5b13, Offset: 0x6a68
// Size: 0xe6
function function_9e3fd2b1(actionparams) {
    weapon = actionparams.weapon;
    if (!isdefined(weapon)) {
        /#
            self botprinterror("<invalid>" + "<dev string:x179>");
        #/
        self waittill(#"hash_347a612b61067eb3");
        return;
    }
    self bot_action::function_a5d700ec(weapon);
    wait 1;
    while (!self function_a3ec3e() || self getcurrentweapon() == level.weaponnone) {
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0x8877d993, Offset: 0x6b58
// Size: 0xde
function activate_vision_pulse(actionparams) {
    weapon = actionparams.weapon;
    if (!isdefined(weapon)) {
        /#
            self botprinterror("<invalid>" + "<dev string:x179>");
        #/
        self waittill(#"hash_347a612b61067eb3");
        return;
    }
    self bot_action::function_a5d700ec(weapon);
    while (!self function_a3ec3e() || self getcurrentweapon() == level.weaponnone) {
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0xac4a73b, Offset: 0x6c40
// Size: 0xde
function function_705e26b4(actionparams) {
    weapon = actionparams.weapon;
    if (!isdefined(weapon)) {
        /#
            self botprinterror("<invalid>" + "<dev string:x179>");
        #/
        self waittill(#"hash_347a612b61067eb3");
        return;
    }
    self bot_action::function_a5d700ec(weapon);
    while (!self function_a3ec3e() || self getcurrentweapon() == level.weaponnone) {
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0x8711eb10, Offset: 0x6d28
// Size: 0x25a
function function_10815e3(actionparams) {
    weapon = actionparams.weapon;
    slot = self gadgetgetslot(weapon);
    if (!self bot_action::function_70df76df(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x30>";
        #/
        return undefined;
    }
    if (!self gadgetisready(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x83>";
        #/
        return undefined;
    }
    if (!isdefined(self locaheal::has_target())) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x2dc>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0xf99aa222, Offset: 0x6f90
// Size: 0xde
function activate_localheal(actionparams) {
    weapon = actionparams.weapon;
    if (!isdefined(weapon)) {
        /#
            self botprinterror("<invalid>" + "<dev string:x179>");
        #/
        self waittill(#"hash_347a612b61067eb3");
        return;
    }
    self bot_action::function_a5d700ec(weapon);
    while (!self function_a3ec3e() || self getcurrentweapon() == level.weaponnone) {
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0x47f69a70, Offset: 0x7078
// Size: 0x312
function function_bb6ac7b5(actionparams) {
    weapon = actionparams.weapon;
    slot = self gadgetgetslot(weapon);
    if (!self bot_action::function_70df76df(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x30>";
        #/
        return undefined;
    }
    if (!self gadgetisready(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x83>";
        #/
        return undefined;
    }
    player_pos = self.origin;
    player_angles = self getplayerangles();
    player_eye_pos = self geteye();
    ignore_entity = undefined;
    results = deployable::function_50e68132(player_pos, player_angles, player_eye_pos, weapon, ignore_entity);
    gameplay_allows_deploy = supplypod::function_4387fa50(results.origin, results.angles, self);
    if (!gameplay_allows_deploy) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x313>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0xb0218d19, Offset: 0x7398
// Size: 0xde
function function_23401dd2(actionparams) {
    weapon = actionparams.weapon;
    if (!isdefined(weapon)) {
        /#
            self botprinterror("<invalid>" + "<dev string:x179>");
        #/
        self waittill(#"hash_347a612b61067eb3");
        return;
    }
    self bot_action::function_a5d700ec(weapon);
    while (!self function_a3ec3e() || self getcurrentweapon() == level.weaponnone) {
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0xbcd908ef, Offset: 0x7480
// Size: 0x1aa
function function_cdaba533(actionparams) {
    weapon = actionparams.weapon;
    slot = self gadgetgetslot(weapon);
    if (!self bot_action::function_70df76df(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x30>";
        #/
        return undefined;
    }
    if (!self gadgetisready(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x83>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0x7bde6e64, Offset: 0x7638
// Size: 0xde
function function_35079e40(actionparams) {
    weapon = actionparams.weapon;
    if (!isdefined(weapon)) {
        /#
            self botprinterror("<invalid>" + "<dev string:x179>");
        #/
        self waittill(#"hash_347a612b61067eb3");
        return;
    }
    self bot_action::function_a5d700ec(weapon);
    while (!self function_a3ec3e() || self getcurrentweapon() == level.weaponnone) {
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0xd1e92cbb, Offset: 0x7720
// Size: 0x582
function function_15b6f8a3(actionparams) {
    actionparams.target = self.enemy;
    weapon = actionparams.weapon;
    slot = self gadgetgetslot(weapon);
    if (!self bot_action::function_70df76df(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x30>";
        #/
        return undefined;
    }
    if (!self gadgetisready(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x83>";
        #/
        return undefined;
    }
    if (!self bot::in_combat()) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x94>";
        #/
        return undefined;
    }
    if (!self bot_action::is_target_visible(actionparams)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:xa2>";
        #/
        return undefined;
    }
    if (self bot_action::function_417d9dbe(actionparams)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:xb3>";
        #/
        return undefined;
    }
    self bot_action::function_3e1dfdce(actionparams, "tag_origin");
    self bot_action::function_e9fddff3(actionparams);
    self bot_action::function_8b5bb921(actionparams);
    if (!isdefined(actionparams.var_7ac9e90b)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:xc7>";
        #/
        return undefined;
    }
    self bot_action::function_7e5f837a(actionparams);
    if (!self bot_action::function_ed41018(actionparams)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:xe9>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0x49276db5, Offset: 0x7cb0
// Size: 0x31a
function function_d238266f(actionparams) {
    weapon = actionparams.weapon;
    slot = self gadgetgetslot(weapon);
    if (!self bot_action::function_70df76df(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x30>";
        #/
        return undefined;
    }
    if (!self gadgetisready(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x83>";
        #/
        return undefined;
    }
    if (!self bot::in_combat()) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x94>";
        #/
        return undefined;
    }
    if (!isdefined(self.enemy) || !isalive(self.enemy)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x122>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0x41cd5bc4, Offset: 0x7fd8
// Size: 0x6e
function function_5165b86c(actionparams) {
    weapon = actionparams.weapon;
    self bot_action::function_a5d700ec(weapon);
    while (self isswitchingweapons()) {
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0x6b70ac46, Offset: 0x8050
// Size: 0x1aa
function function_91d4449a(actionparams) {
    weapon = actionparams.weapon;
    slot = self gadgetgetslot(weapon);
    if (!self bot_action::function_70df76df(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x30>";
        #/
        return undefined;
    }
    if (!self gadgetisready(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x83>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0x99da12fb, Offset: 0x8208
// Size: 0xae
function function_7a0bed17(actionparams) {
    weapon = actionparams.weapon;
    self bot_action::function_a5d700ec(weapon);
    while (self isthrowinggrenade() || !self function_a3ec3e() || self getcurrentweapon() == level.weaponnone) {
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0xead1079e, Offset: 0x82c0
// Size: 0x25a
function function_16054dab(actionparams) {
    weapon = actionparams.weapon;
    slot = self gadgetgetslot(weapon);
    if (!self bot_action::function_70df76df(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x30>";
        #/
        return undefined;
    }
    if (!self gadgetisready(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x83>";
        #/
        return undefined;
    }
    if (self bot::has_visible_enemy()) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x12b>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0xc562534b, Offset: 0x8528
// Size: 0x106
function function_fb697bf8(actionparams) {
    weapon = actionparams.weapon;
    self bot_action::function_a5d700ec(weapon);
    while (!self function_a3ec3e() || self getcurrentweapon() == level.weaponnone) {
        self waittill(#"hash_347a612b61067eb3");
    }
    self bottapbutton(16);
    while (!self function_a3ec3e() || self getcurrentweapon() == level.weaponnone) {
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0x853ec68c, Offset: 0x8638
// Size: 0x1aa
function function_5859eef8(actionparams) {
    weapon = actionparams.weapon;
    slot = self gadgetgetslot(weapon);
    if (!self bot_action::function_70df76df(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x30>";
        #/
        return undefined;
    }
    if (!self gadgetisready(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x83>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0xc4b62825, Offset: 0x87f0
// Size: 0x96
function activate_dog(actionparams) {
    weapon = actionparams.weapon;
    self bot_action::function_a5d700ec(weapon);
    while (!self function_a3ec3e() || self getcurrentweapon() == level.weaponnone) {
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0xd713193a, Offset: 0x8890
// Size: 0x56a
function function_50a93b1e(actionparams) {
    weapon = actionparams.weapon;
    slot = self gadgetgetslot(weapon);
    if (!self bot_action::function_70df76df(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x30>";
        #/
        return undefined;
    }
    if (!self gadgetisready(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x83>";
        #/
        return undefined;
    }
    if (self bot::has_visible_enemy()) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x12b>";
        #/
        return undefined;
    }
    var_2d0df182 = self function_28dbe634();
    if (!isdefined(var_2d0df182)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x139>";
        #/
        return undefined;
    }
    target = vectorlerp(var_2d0df182.var_92706ab9, var_2d0df182.var_7c104b66, 0.5) + (0, 0, 50);
    eye = self geteye();
    trace = bullettrace(eye, target, 0, self);
    target = trace[#"position"];
    if (distance2dsquared(target, self.origin) > 22500) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x365>";
        #/
        return undefined;
    }
    var_541cca24 = vectorcross(var_2d0df182.var_7c104b66 - self.origin, var_2d0df182.var_92706ab9 - self.origin);
    direction = self getplayerangles();
    offsetvec = vectorcross(var_2d0df182.var_92706ab9 - self.origin, anglestoup(direction));
    if (var_541cca24[2] < 0) {
        offsetvec = vectorscale(offsetvec, -3);
    }
    actionparams.target = target;
    actionparams.target2 = target + offsetvec;
    return 100;
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0x2c952f56, Offset: 0x8e08
// Size: 0x2ce
function use_tripwire(actionparams) {
    weapon = actionparams.weapon;
    if (!isdefined(weapon)) {
        /#
            self botprinterror("<invalid>" + "<dev string:x179>");
        #/
        self waittill(#"hash_347a612b61067eb3");
        return;
    }
    self bot_action::function_a5d700ec(weapon);
    button = self function_628f19f9(weapon);
    self bot_action::function_e9fddff3(actionparams);
    self bot_action::aim_at_target(actionparams);
    while (self botgetlookdot() < 0.98 || self istraversing()) {
        self bottapbutton(button);
        self waittill(#"hash_347a612b61067eb3");
        self bot_action::function_e9fddff3(actionparams);
        self bot_action::aim_at_target(actionparams);
    }
    var_3c87ac3f = gettime();
    actionparams.target = actionparams.target2;
    self bot_action::function_e9fddff3(actionparams);
    self bot_action::aim_at_target(actionparams);
    while (self botgetlookdot() < 0.98 || self istraversing() || gettime() - var_3c87ac3f < 3000) {
        self waittill(#"hash_347a612b61067eb3");
        self bot_action::function_e9fddff3(actionparams);
        self bot_action::aim_at_target(actionparams);
    }
    self bottapbutton(button);
    while (!self function_a3ec3e() || self getcurrentweapon() == level.weaponnone) {
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0xc8c4135, Offset: 0x90e0
// Size: 0x3f2
function function_5fe843de(actionparams) {
    weapon = actionparams.weapon;
    slot = self gadgetgetslot(weapon);
    if (!self bot_action::function_70df76df(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x30>";
        #/
        return undefined;
    }
    if (!self gadgetisready(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x83>";
        #/
        return undefined;
    }
    if (self bot::has_visible_enemy()) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x12b>";
        #/
        return undefined;
    }
    mask = 1;
    radius = 50;
    location = self.origin + vectorscale(anglestoforward(self getplayerangles()), 50);
    trace = physicstrace(location + (0, 0, 5000), location + (0, 0, 10), (radius * -1, radius * -1, 0), (radius, radius, 2 * radius), undefined, mask);
    if (trace[#"fraction"] >= 1) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x390>";
        #/
        return undefined;
    }
    actionparams.target = location;
    return 100;
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0xae2b2eb7, Offset: 0x94e0
// Size: 0x2ce
function function_499a344b(actionparams) {
    weapon = actionparams.weapon;
    if (!isdefined(weapon)) {
        /#
            self botprinterror("<invalid>" + "<dev string:x179>");
        #/
        self waittill(#"hash_347a612b61067eb3");
        return;
    }
    self bot_position::stop();
    self function_3c8dce03(self.origin);
    self bot_action::function_a5d700ec(weapon);
    while (!self function_a3ec3e() || self getcurrentweapon() == level.weaponnone) {
        self waittill(#"hash_347a612b61067eb3");
    }
    location = self.origin + vectorscale(anglestoforward(self getplayerangles()), 50);
    if (!isdefined(actionparams.target)) {
        actionparams.target = self.origin + vectorscale(anglestoforward(self getplayerangles()), 50);
    }
    self bot_action::function_e9fddff3(actionparams);
    self bot_action::aim_at_target(actionparams);
    while (self botgetlookdot() < 0.98 || self istraversing()) {
        self waittill(#"hash_347a612b61067eb3");
        self bot_action::function_e9fddff3(actionparams);
        self bot_action::aim_at_target(actionparams);
    }
    self bottapbutton(0);
    while (!self function_a3ec3e() || self getcurrentweapon() == level.weaponnone) {
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0x2803e995, Offset: 0x97b8
// Size: 0x25a
function function_10d2a156(actionparams) {
    weapon = actionparams.weapon;
    slot = self gadgetgetslot(weapon);
    if (!self bot_action::function_70df76df(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x30>";
        #/
        return undefined;
    }
    if (!self gadgetisready(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x83>";
        #/
        return undefined;
    }
    if (self bot::has_visible_enemy()) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x12b>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0xf95fb9da, Offset: 0x9a20
// Size: 0x5c
function function_3e933063(actionparams) {
    weapon = actionparams.weapon;
    self ai::set_behavior_attribute("control", "autonomous");
    self bot_action::function_a5d700ec(weapon);
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0x696e8a4c, Offset: 0x9a88
// Size: 0x25a
function function_19488da(actionparams) {
    weapon = actionparams.weapon;
    slot = self gadgetgetslot(weapon);
    if (!self bot_action::function_70df76df(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x30>";
        #/
        return undefined;
    }
    if (!self gadgetisready(slot)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x83>";
        #/
        return undefined;
    }
    if (self bot::has_visible_enemy()) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x12b>";
        #/
        return undefined;
    }
    return 100;
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0x92347b23, Offset: 0x9cf0
// Size: 0x5c
function function_9a162d57(actionparams) {
    weapon = actionparams.weapon;
    self ai::set_behavior_attribute("control", "autonomous");
    self bot_action::function_a5d700ec(weapon);
}

// Namespace mp_bot_action/mp_bot_action
// Params 2, eflags: 0x0
// Checksum 0x7834fd0e, Offset: 0x9d58
// Size: 0x362
function function_d526750e(actionparams, var_8211bcd1) {
    if (!self bot_action::function_b211d748()) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x3bf>";
        #/
        return false;
    }
    var_a9dfd0da = actionparams.action.name;
    scorestreakweapon = actionparams.weapon;
    haskillstreak = self killstreaks::has_killstreak(var_a9dfd0da);
    var_2102cb7a = self killstreaks::get_killstreak_quantity(scorestreakweapon) > 0;
    hasscorestreak = haskillstreak || var_2102cb7a;
    if (!hasscorestreak) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x3e1>";
        #/
        return false;
    }
    if (self killstreakrules::iskillstreakallowed(var_a9dfd0da, self.team) == 0) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x3fa>";
        #/
        return false;
    }
    if (var_8211bcd1 == self bot::has_visible_enemy()) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x412>";
        #/
        return false;
    }
    return true;
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0xd2132d38, Offset: 0xa0c8
// Size: 0x2e
function function_f26245f2(actionparams) {
    if (!function_d526750e(actionparams, 1)) {
        return undefined;
    }
    return 100;
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0x259e3755, Offset: 0xa100
// Size: 0x2e
function function_29cee5f1(actionparams) {
    if (!function_d526750e(actionparams, 0)) {
        return undefined;
    }
    return 100;
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0x67c933a, Offset: 0xa138
// Size: 0x2ba
function function_4ebe60b1(actionparams) {
    if (!function_d526750e(actionparams, 1)) {
        return undefined;
    }
    if (level.teambased) {
        var_4a94f812 = 0;
        foreach (team in level.teams) {
            if (isdefined(self.team) && self.team != team && killstreaks::hasuav(team)) {
                var_4a94f812 = 1;
            }
        }
        if (!var_4a94f812) {
            /#
                if (!isdefined(actionparams.debug)) {
                    actionparams.debug = [];
                } else if (!isarray(actionparams.debug)) {
                    actionparams.debug = array(actionparams.debug);
                }
                actionparams.debug[actionparams.debug.size] = "<dev string:x425>";
            #/
            return undefined;
        }
    } else {
        foreach (enabled, uavowner in level.activeuavs) {
            var_d572de23 = 0;
            if (enabled && uavowner != self.entnum) {
                var_d572de23 = 1;
            }
        }
        if (!var_d572de23) {
            /#
                if (!isdefined(actionparams.debug)) {
                    actionparams.debug = [];
                } else if (!isarray(actionparams.debug)) {
                    actionparams.debug = array(actionparams.debug);
                }
                actionparams.debug[actionparams.debug.size] = "<dev string:x425>";
            #/
            return undefined;
        }
    }
    return 100;
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0x17d38608, Offset: 0xa400
// Size: 0x592
function function_3937668a(actionparams) {
    if (!function_d526750e(actionparams, 1)) {
        return undefined;
    }
    if (isdefined(self.var_f9a0ed79) && gettime() - self.var_f9a0ed79 < 5000) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x43b>";
        #/
        return undefined;
    }
    var_5aa1eed4 = getclosesttacpoint(self.origin);
    if (!isdefined(var_5aa1eed4)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x454>";
        #/
        return undefined;
    }
    cylinder = ai::t_cylinder(self.origin, 512, 512);
    var_7ee4a5fa = tacticalquery("stratcom_tacquery_position", cylinder);
    var_a056619d = array::randomize(var_7ee4a5fa);
    botdir = anglestoforward(self getplayerangles());
    var_2545d0f7 = vectornormalize(botdir * (1, 1, 0));
    var_84cad787 = undefined;
    foreach (point in var_a056619d) {
        if (function_c80ec59e(var_5aa1eed4, point.origin)) {
            var_69e65b6d = vectornormalize((point.origin - self.origin) * (1, 1, 0));
            dot = vectordot(var_69e65b6d, var_2545d0f7);
            if (dot > 0.707) {
                var_84cad787 = point;
                break;
            }
        }
    }
    if (!isdefined(var_84cad787)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x47a>";
        #/
        return undefined;
    }
    mask = 1;
    from = var_84cad787.origin + (0, 0, 10);
    to = var_84cad787.origin + (0, 0, 2000);
    trace = physicstrace(from, to, (-50, -50, 0), (50, 50, 100), undefined, mask);
    if (trace[#"fraction"] < 1) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x390>";
        #/
        return undefined;
    }
    actionparams.target = var_84cad787.origin + (0, 0, 20);
    return 100;
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0x325bd12f, Offset: 0xa9a0
// Size: 0x1da
function function_498a51f3(actionparams) {
    if (!function_d526750e(actionparams, 1)) {
        return undefined;
    }
    var_2d0df182 = self function_28dbe634();
    if (!isdefined(var_2d0df182)) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x139>";
        #/
        return undefined;
    }
    target = var_2d0df182.var_92706ab9 + (0, 0, 55);
    if (distance2dsquared(target, self.origin) < 40000) {
        /#
            if (!isdefined(actionparams.debug)) {
                actionparams.debug = [];
            } else if (!isarray(actionparams.debug)) {
                actionparams.debug = array(actionparams.debug);
            }
            actionparams.debug[actionparams.debug.size] = "<dev string:x143>";
        #/
        return undefined;
    }
    actionparams.target = target;
    return 100;
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0x3e96e1d0, Offset: 0xab88
// Size: 0x96
function function_5e4b3210(actionparams) {
    scorestreakweapon = actionparams.weapon;
    self bot_action::function_795fbbe2(scorestreakweapon);
    while (!self function_a3ec3e() || self getcurrentweapon() == level.weaponnone) {
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0x28e56623, Offset: 0xac28
// Size: 0x224
function function_7bd59908(actionparams) {
    scorestreakweapon = actionparams.weapon;
    self bot_position::stop();
    self function_3c8dce03(self.origin);
    self bot_action::function_795fbbe2(scorestreakweapon);
    while (!self function_a3ec3e() || self getcurrentweapon() != scorestreakweapon) {
        self waittill(#"hash_347a612b61067eb3");
    }
    wait 0.5;
    self bot_action::function_e9fddff3(actionparams);
    self bot_action::aim_at_target(actionparams);
    while (self botgetlookdot() < 0.999 || self istraversing()) {
        self waittill(#"hash_347a612b61067eb3");
        self bot_action::function_e9fddff3(actionparams);
        self bot_action::aim_at_target(actionparams);
    }
    self bottapbutton(0);
    self.var_f9a0ed79 = gettime();
    while (!self function_a3ec3e() || self getcurrentweapon() == scorestreakweapon || self getcurrentweapon() == level.weaponnone) {
        self waittill(#"hash_347a612b61067eb3");
    }
    self function_9f59031e();
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0xe8a25cd2, Offset: 0xae58
// Size: 0x31e
function function_1d5644ef(actionparams) {
    scorestreakweapon = actionparams.weapon;
    self bot_action::function_795fbbe2(scorestreakweapon);
    while (!self function_a3ec3e() || self getcurrentweapon() != scorestreakweapon) {
        self waittill(#"hash_347a612b61067eb3");
    }
    shots_fired = 0;
    enemies = self teams::getenemyplayers();
    aliveenemies = [];
    foreach (enemy in enemies) {
        if (isalive(enemy)) {
            aliveenemies[aliveenemies.size] = enemy;
        }
    }
    targetlocations = [];
    for (i = 0; i < aliveenemies.size; i++) {
        targetlocations[i] = aliveenemies[i].origin;
    }
    if (targetlocations.size > 0) {
        while (shots_fired < 3) {
            location = array::random(targetlocations) + (randomfloatrange(0, 200), randomfloatrange(0, 200), 0);
            self notify(#"confirm_location", {#position:location, #yaw:0});
            shots_fired++;
            if (shots_fired == 3) {
                break;
            }
            self waittill(#"hash_347a612b61067eb3");
        }
    } else {
        while (shots_fired < 3) {
            self botpressbutton(16);
            self waittill(#"hash_347a612b61067eb3");
            shots_fired++;
        }
    }
    while (!self function_a3ec3e() || self getcurrentweapon() == level.weaponnone) {
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0x226acf69, Offset: 0xb180
// Size: 0x24c
function activate_turret(actionparams) {
    scorestreakweapon = actionparams.weapon;
    self bot_action::function_795fbbe2(scorestreakweapon);
    self bot_position::stop();
    self function_3c8dce03(self.origin);
    while (self getcurrentweapon() != scorestreakweapon) {
        self waittill(#"hash_347a612b61067eb3");
    }
    self bot_action::function_e9fddff3(actionparams);
    self bot_action::aim_at_target(actionparams);
    while (self botgetlookdot() < 0.999 || self istraversing()) {
        self waittill(#"hash_347a612b61067eb3");
        self bot_action::function_e9fddff3(actionparams);
        self bot_action::aim_at_target(actionparams);
    }
    wait 0.5;
    starttime = gettime();
    while (self getcurrentweapon() == scorestreakweapon && gettime() - starttime < 1000) {
        self bottapbutton(0);
        self waittill(#"hash_347a612b61067eb3");
    }
    wait 1;
    while (!self function_a3ec3e() || self getcurrentweapon() == level.weaponnone) {
        self waittill(#"hash_347a612b61067eb3");
    }
    self function_9f59031e();
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0x396b5842, Offset: 0xb3d8
// Size: 0xb6
function function_95ecb3a4(actionparams) {
    scorestreakweapon = actionparams.weapon;
    self bot_action::function_795fbbe2(scorestreakweapon);
    wait 5;
    self bottapbutton(0);
    while (!self function_a3ec3e() || self getcurrentweapon() == level.weaponnone) {
        self waittill(#"hash_347a612b61067eb3");
    }
}

// Namespace mp_bot_action/mp_bot_action
// Params 1, eflags: 0x0
// Checksum 0x78f45293, Offset: 0xb498
// Size: 0x198
function function_50b82c89(actionparams) {
    scorestreakweapon = actionparams.weapon;
    self bot_action::function_795fbbe2(scorestreakweapon);
    self bot_position::stop();
    self function_3c8dce03(self.origin);
    while (!self function_a3ec3e() || self getcurrentweapon() != scorestreakweapon) {
        self waittill(#"hash_347a612b61067eb3");
    }
    while (!self isinvehicle() && self getcurrentweapon() == scorestreakweapon) {
        if (isdefined(self.enemy)) {
            actionparams.target = self.enemy.origin + (0, 0, 45);
        }
        if (isdefined(actionparams.target)) {
            self bot_action::function_e9fddff3(actionparams);
            self bot_action::aim_at_target(actionparams);
        }
        self bottapbutton(0);
        wait 0.5;
    }
}

