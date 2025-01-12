#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\trials\zm_trial_restrict_loadout;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_utility;

#namespace zm_perk_slider;

// Namespace zm_perk_slider/zm_perk_slider
// Params 0, eflags: 0x2
// Checksum 0xf8f8682b, Offset: 0x200
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_perk_slider", &__init__, &__main__, undefined);
}

// Namespace zm_perk_slider/zm_perk_slider
// Params 0, eflags: 0x0
// Checksum 0x8c4de32, Offset: 0x250
// Size: 0x14
function __init__() {
    enable_slider_perk_for_level();
}

// Namespace zm_perk_slider/zm_perk_slider
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x270
// Size: 0x4
function __main__() {
    
}

// Namespace zm_perk_slider/zm_perk_slider
// Params 0, eflags: 0x0
// Checksum 0xa754b035, Offset: 0x280
// Size: 0x1cc
function enable_slider_perk_for_level() {
    zm_perks::register_perk_basic_info(#"specialty_phdflopper", "perk_slider", 4000, #"zombie/perk_slider", getweapon("zombie_perk_bottle_nuke"), getweapon("zombie_perk_totem_slider"), #"zmperksphdslider");
    zm_perks::register_perk_precache_func(#"specialty_phdflopper", &function_f6b33b4a);
    zm_perks::register_perk_clientfields(#"specialty_phdflopper", &function_a42a2468, &function_49c09ce1);
    zm_perks::register_perk_machine(#"specialty_phdflopper", &function_7575f2dd, &init_slider);
    zm_perks::register_perk_host_migration_params(#"specialty_phdflopper", "p7_zm_vending_nuke", "divetonuke_light");
    zm_perks::register_perk_threads(#"specialty_phdflopper", &function_de1843b5, &function_bce2b497, &reset_charge);
    zm_perks::register_perk_damage_override_func(&function_86264dc1);
}

// Namespace zm_perk_slider/zm_perk_slider
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x458
// Size: 0x4
function init_slider() {
    
}

// Namespace zm_perk_slider/zm_perk_slider
// Params 0, eflags: 0x0
// Checksum 0xf7e2fe06, Offset: 0x468
// Size: 0xbe
function function_f6b33b4a() {
    level.machine_assets[#"specialty_phdflopper"] = spawnstruct();
    level.machine_assets[#"specialty_phdflopper"].weapon = getweapon("zombie_perk_bottle_nuke");
    level.machine_assets[#"specialty_phdflopper"].off_model = "p7_zm_vending_nuke";
    level.machine_assets[#"specialty_phdflopper"].on_model = "p7_zm_vending_nuke";
}

// Namespace zm_perk_slider/zm_perk_slider
// Params 0, eflags: 0x0
// Checksum 0x5907d865, Offset: 0x530
// Size: 0x74
function function_a42a2468() {
    clientfield::register("clientuimodel", "hudItems.perks.slider", 1, 1, "int");
    clientfield::register("allplayers", "" + #"hash_7b8ad0ed3ef67813", 1, 1, "counter");
}

// Namespace zm_perk_slider/zm_perk_slider
// Params 1, eflags: 0x0
// Checksum 0x8acd0c7, Offset: 0x5b0
// Size: 0x2c
function function_49c09ce1(state) {
    self clientfield::set_player_uimodel("hudItems.perks.slider", state);
}

// Namespace zm_perk_slider/zm_perk_slider
// Params 4, eflags: 0x0
// Checksum 0xd21acd9f, Offset: 0x5e8
// Size: 0xb6
function function_7575f2dd(use_trigger, perk_machine, bump_trigger, collision) {
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

// Namespace zm_perk_slider/zm_perk_slider
// Params 0, eflags: 0x0
// Checksum 0x7efbd55c, Offset: 0x6a8
// Size: 0x44
function function_de1843b5() {
    n_slot = zm_perks::function_ec1dff78(#"specialty_phdflopper");
    self thread function_61c080d6(n_slot);
}

// Namespace zm_perk_slider/zm_perk_slider
// Params 3, eflags: 0x0
// Checksum 0x33d92320, Offset: 0x6f8
// Size: 0x74
function function_bce2b497(b_pause, str_perk, str_result) {
    self notify(#"hash_6939dd7af68cec");
    n_slot = zm_perks::function_ec1dff78(#"specialty_phdflopper");
    self zm_perks::function_2b57e880(n_slot, 0);
}

// Namespace zm_perk_slider/zm_perk_slider
// Params 1, eflags: 0x0
// Checksum 0x87225a5f, Offset: 0x778
// Size: 0x152
function function_61c080d6(n_slot) {
    self notify(#"hash_6939dd7af68cec");
    self endon(#"disconnect", #"hash_6939dd7af68cec");
    self slide_explosion(n_slot);
    self.var_a63aca62 = 0;
    while (true) {
        self waittill(#"slide_begin");
        v_start_position = self.origin;
        self waittill(#"slide_end");
        n_distance = distance(v_start_position, self.origin);
        self.var_a63aca62 += n_distance;
        self zm_perks::function_2b57e880(n_slot, min(1, self.var_a63aca62 / 550));
        if (self.var_a63aca62 >= 550) {
            self slide_explosion(n_slot);
            self.var_a63aca62 = 0;
        }
    }
}

// Namespace zm_perk_slider/zm_perk_slider
// Params 0, eflags: 0x0
// Checksum 0xed72d635, Offset: 0x8d8
// Size: 0x64
function reset_charge() {
    n_slot = zm_perks::function_ec1dff78(#"specialty_phdflopper");
    self zm_perks::function_2b57e880(n_slot, 1);
    self thread function_61c080d6(n_slot);
}

// Namespace zm_perk_slider/zm_perk_slider
// Params 1, eflags: 0x0
// Checksum 0xf5b3c5ed, Offset: 0x948
// Size: 0x63a
function slide_explosion(n_slot) {
    while (true) {
        self waittill(#"slide_begin");
        var_335bd514 = 1200;
        var_b6bbcd31 = self.var_b6bbcd31;
        if (isdefined(var_b6bbcd31)) {
            var_335bd514 += var_b6bbcd31 * 6;
            var_335bd514 = int(var_335bd514);
        }
        while (self issliding()) {
            var_5b97ccdc = self getenemiesinradius(self.origin, 80);
            var_4863aa4d = vectornormalize(self getvelocity());
            var_7eca4943 = [];
            foreach (ai in var_5b97ccdc) {
                if (vectordot(var_4863aa4d, vectornormalize(ai.origin - self.origin)) > 0.8) {
                    if (!isdefined(var_7eca4943)) {
                        var_7eca4943 = [];
                    } else if (!isarray(var_7eca4943)) {
                        var_7eca4943 = array(var_7eca4943);
                    }
                    var_7eca4943[var_7eca4943.size] = ai;
                }
            }
            if (var_7eca4943.size) {
                break;
            }
            waitframe(1);
        }
        if (var_7eca4943.size) {
            a_ai = self getenemiesinradius(self.origin, 256);
            a_ai = arraysortclosest(a_ai, self.origin);
            self clientfield::increment("" + #"hash_7b8ad0ed3ef67813");
            self zm_perks::function_2b57e880(n_slot, 0.05);
            var_5fc79289 = 0;
            if (zm_trial_restrict_loadout::is_active()) {
                a_ai = [];
            }
            n_kill_count = 0;
            foreach (ai in a_ai) {
                if (ai.health <= var_335bd514) {
                    ai.marked_for_death = 1;
                    n_kill_count++;
                    if (var_5fc79289 < 3) {
                        if (vectordot(anglestoforward(self.angles), vectornormalize(ai.origin - self.origin)) > 0.6) {
                            v_fling = vectornormalize(ai.origin - self.origin) * 150;
                            v_fling = (v_fling[0], v_fling[1], 75);
                            ai zm_utility::function_620780d9(v_fling, self);
                            ai.var_6c5137d0 = 1;
                            var_5fc79289++;
                        }
                    }
                }
            }
            foreach (ai in a_ai) {
                if (isalive(ai) && !(isdefined(ai.var_6c5137d0) && ai.var_6c5137d0)) {
                    if (ai.health > var_335bd514) {
                        if (ai.var_29ed62b2 === #"heavy" || ai.var_29ed62b2 === #"miniboss") {
                            ai ai::stun();
                        } else {
                            ai zombie_utility::setup_zombie_knockdown(self);
                        }
                    } else if (ai.var_29ed62b2 == #"basic") {
                        ai zm_spawner::zombie_explodes_intopieces(0);
                    }
                    ai dodamage(var_335bd514, self.origin, self, self, "none", "MOD_UNKNOWN");
                    waitframe(1);
                }
            }
            if (isdefined(var_b6bbcd31) && var_b6bbcd31 >= 120) {
                if (n_kill_count >= 10) {
                    self zm_utility::giveachievement_wrapper("zm_trophy_doctor_is_in");
                }
            }
            return;
        }
    }
}

// Namespace zm_perk_slider/zm_perk_slider
// Params 10, eflags: 0x0
// Checksum 0xcf9452a1, Offset: 0xf90
// Size: 0xec
function function_86264dc1(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime) {
    if (self hasperk(#"specialty_phdflopper")) {
        if (smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH") {
            return int(idamage * 0.2);
        }
    }
}

