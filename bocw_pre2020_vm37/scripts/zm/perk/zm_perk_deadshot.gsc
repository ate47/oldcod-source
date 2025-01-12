#using script_2c5daa95f8fec03c;
#using script_3751b21462a54a7d;
#using script_5f261a5d57de5f7c;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\scoreevents;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;

#namespace zm_perk_deadshot;

// Namespace zm_perk_deadshot/zm_perk_deadshot
// Params 0, eflags: 0x6
// Checksum 0x97ada84f, Offset: 0x1d0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"zm_perk_deadshot", &function_70a657d8, undefined, undefined, #"hash_2d064899850813e2");
}

// Namespace zm_perk_deadshot/zm_perk_deadshot
// Params 0, eflags: 0x5 linked
// Checksum 0x39f7bb1d, Offset: 0x220
// Size: 0xd4
function private function_70a657d8() {
    enable_deadshot_perk_for_level();
    zm_perks::register_actor_damage_override(#"hash_1f95b48e4a49df4a", &function_4d088c19);
    zm_perks::register_actor_damage_override(#"hash_1f95b38e4a49dd97", &function_4d088c19);
    zm_perks::register_actor_damage_override(#"hash_1f95b28e4a49dbe4", &function_4d088c19);
    zm_perks::register_actor_damage_override(#"hash_210097a75bb6c49a", &function_4d088c19);
}

// Namespace zm_perk_deadshot/zm_perk_deadshot
// Params 0, eflags: 0x1 linked
// Checksum 0x89511024, Offset: 0x300
// Size: 0x17c
function enable_deadshot_perk_for_level() {
    zm_perks::register_perk_basic_info(#"hash_210097a75bb6c49a", #"perk_dead_shot", 2000, #"zombie/perk_deadshot", getweapon("zombie_perk_bottle_deadshot"), undefined, #"zmperksdeadshot");
    zm_perks::register_perk_precache_func(#"hash_210097a75bb6c49a", &deadshot_precache);
    zm_perks::register_perk_clientfields(#"hash_210097a75bb6c49a", &deadshot_register_clientfield, &deadshot_set_clientfield);
    zm_perks::register_perk_machine(#"hash_210097a75bb6c49a", &deadshot_perk_machine_setup);
    zm_perks::register_perk_threads(#"hash_210097a75bb6c49a", &give_deadshot_perk, &take_deadshot_perk);
    zm_perks::register_perk_host_migration_params(#"hash_210097a75bb6c49a", "vending_deadshot", "deadshot_light");
}

// Namespace zm_perk_deadshot/zm_perk_deadshot
// Params 0, eflags: 0x1 linked
// Checksum 0x65676fe, Offset: 0x488
// Size: 0xf6
function deadshot_precache() {
    if (isdefined(level.var_bc5f9f6a)) {
        [[ level.var_bc5f9f6a ]]();
        return;
    }
    level._effect[#"deadshot_light"] = "zombie/fx_perk_daiquiri_factory_zmb";
    level.machine_assets[#"hash_210097a75bb6c49a"] = spawnstruct();
    level.machine_assets[#"hash_210097a75bb6c49a"].weapon = getweapon("zombie_perk_bottle_deadshot");
    level.machine_assets[#"hash_210097a75bb6c49a"].off_model = "p9_sur_vending_ads";
    level.machine_assets[#"hash_210097a75bb6c49a"].on_model = "p9_sur_vending_ads";
}

// Namespace zm_perk_deadshot/zm_perk_deadshot
// Params 0, eflags: 0x1 linked
// Checksum 0xe940c07, Offset: 0x588
// Size: 0x34
function deadshot_register_clientfield() {
    clientfield::register("toplayer", "deadshot_perk", 1, 1, "int");
}

// Namespace zm_perk_deadshot/zm_perk_deadshot
// Params 1, eflags: 0x1 linked
// Checksum 0x2917397a, Offset: 0x5c8
// Size: 0xc
function deadshot_set_clientfield(*state) {
    
}

// Namespace zm_perk_deadshot/zm_perk_deadshot
// Params 4, eflags: 0x1 linked
// Checksum 0x7eb13d4e, Offset: 0x5e0
// Size: 0x9a
function deadshot_perk_machine_setup(use_trigger, perk_machine, bump_trigger, *collision) {
    perk_machine.script_sound = "mus_perks_deadshot_jingle";
    perk_machine.script_string = "deadshot_perk";
    perk_machine.script_label = "mus_perks_deadshot_sting";
    perk_machine.target = "vending_deadshot";
    bump_trigger.script_string = "deadshot_vending";
    bump_trigger.targetname = "vending_deadshot";
    if (isdefined(collision)) {
        collision.script_string = "deadshot_vending";
    }
}

// Namespace zm_perk_deadshot/zm_perk_deadshot
// Params 0, eflags: 0x1 linked
// Checksum 0x34ce1c22, Offset: 0x688
// Size: 0x24
function give_deadshot_perk() {
    self clientfield::set_to_player("deadshot_perk", 1);
}

// Namespace zm_perk_deadshot/zm_perk_deadshot
// Params 4, eflags: 0x1 linked
// Checksum 0x44135500, Offset: 0x6b8
// Size: 0x44
function take_deadshot_perk(*b_pause, *str_perk, *str_result, *n_slot) {
    self clientfield::set_to_player("deadshot_perk", 0);
}

// Namespace zm_perk_deadshot/zm_perk_deadshot
// Params 12, eflags: 0x1 linked
// Checksum 0x5fc9b332, Offset: 0x708
// Size: 0x27e
function function_4d088c19(*inflictor, attacker, damage, *flags, *meansofdeath, weapon, vpoint, *vdir, shitloc, *psoffsettime, boneindex, *surfacetype) {
    if (isplayer(vpoint)) {
        weaponclass = util::getweaponclass(shitloc);
        weap_min_dmg_range = scoreevents::get_distance_for_weapon(shitloc, weaponclass);
        disttovictim = distancesquared(self.origin, vpoint.origin);
        if (disttovictim > weap_min_dmg_range) {
            vdir += vdir * 0.1;
        }
        if (vpoint namespace_e86ffa8::function_7bf30775(4)) {
            var_84ed9a13 = self zm_ai_utility::function_de3dda83(surfacetype, boneindex, psoffsettime);
            if (isdefined(var_84ed9a13) && namespace_81245006::function_f29756fe(var_84ed9a13) == 1 && var_84ed9a13.type !== #"armor") {
                vdir += vdir * 0.1;
            }
        }
        if (vpoint namespace_791d0451::function_56cedda7(#"hash_1f95b08e4a49d87e")) {
            if (!isdefined(vpoint.var_39f18bc3)) {
                vpoint.var_39f18bc3 = 0;
            }
            if (self === vpoint.var_9c098a96) {
                vpoint.var_39f18bc3++;
                if (vpoint.var_39f18bc3 < vpoint.var_39f18bc3) {
                    vpoint.var_39f18bc3 = vpoint.var_39f18bc3;
                } else if (vpoint.var_39f18bc3 > 10) {
                    vpoint.var_39f18bc3 = 10;
                }
                vdir += vdir * 0.02 * vpoint.var_39f18bc3;
            } else {
                vpoint.var_39f18bc3 = 0;
            }
            vpoint.var_9c098a96 = self;
        }
    }
    return vdir;
}

