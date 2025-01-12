#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\trials\zm_trial_restrict_loadout;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_spawner;

#namespace zm_perk_tortoise;

// Namespace zm_perk_tortoise/zm_perk_tortoise
// Params 0, eflags: 0x2
// Checksum 0x2b1b3e50, Offset: 0x1b8
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_perk_tortoise", &__init__, &__main__, undefined);
}

// Namespace zm_perk_tortoise/zm_perk_tortoise
// Params 0, eflags: 0x0
// Checksum 0x1159f73d, Offset: 0x208
// Size: 0x14
function __init__() {
    enable_tortoise_perk_for_level();
}

// Namespace zm_perk_tortoise/zm_perk_tortoise
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x228
// Size: 0x4
function __main__() {
    
}

// Namespace zm_perk_tortoise/zm_perk_tortoise
// Params 0, eflags: 0x0
// Checksum 0xbe9c7e98, Offset: 0x238
// Size: 0x19c
function enable_tortoise_perk_for_level() {
    zm_perks::register_perk_basic_info(#"specialty_shield", "perk_tortoise", 2500, #"zombie/perk_tortoise", getweapon("zombie_perk_bottle_nuke"), getweapon("zombie_perk_totem_tortoise"), #"zmperksvictorious");
    zm_perks::register_perk_precache_func(#"specialty_shield", &function_62dc2128);
    zm_perks::register_perk_clientfields(#"specialty_shield", &function_63f04e8a, &function_80eaa0d3);
    zm_perks::register_perk_machine(#"specialty_shield", &function_49190e2b, &function_c7044943);
    zm_perks::register_perk_host_migration_params(#"specialty_shield", "p7_zm_vending_nuke", "divetonuke_light");
    zm_perks::register_perk_threads(#"specialty_shield", &function_b7485b07, &function_c3e68c69);
}

// Namespace zm_perk_tortoise/zm_perk_tortoise
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x3e0
// Size: 0x4
function function_c7044943() {
    
}

// Namespace zm_perk_tortoise/zm_perk_tortoise
// Params 0, eflags: 0x0
// Checksum 0xd30e8054, Offset: 0x3f0
// Size: 0xbe
function function_62dc2128() {
    level.machine_assets[#"specialty_shield"] = spawnstruct();
    level.machine_assets[#"specialty_shield"].weapon = getweapon("zombie_perk_bottle_nuke");
    level.machine_assets[#"specialty_shield"].off_model = "p7_zm_vending_nuke";
    level.machine_assets[#"specialty_shield"].on_model = "p7_zm_vending_nuke";
}

// Namespace zm_perk_tortoise/zm_perk_tortoise
// Params 0, eflags: 0x0
// Checksum 0x1c90499a, Offset: 0x4b8
// Size: 0x64
function function_63f04e8a() {
    clientfield::register("clientuimodel", "hudItems.perks.tortoise", 1, 1, "int");
    clientfield::register("allplayers", "perk_tortoise_explosion", 1, 1, "counter");
}

// Namespace zm_perk_tortoise/zm_perk_tortoise
// Params 1, eflags: 0x0
// Checksum 0xd191e7d2, Offset: 0x528
// Size: 0x2c
function function_80eaa0d3(state) {
    self clientfield::set_player_uimodel("hudItems.perks.tortoise", state);
}

// Namespace zm_perk_tortoise/zm_perk_tortoise
// Params 4, eflags: 0x0
// Checksum 0xf419011e, Offset: 0x560
// Size: 0xb6
function function_49190e2b(use_trigger, perk_machine, bump_trigger, collision) {
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

// Namespace zm_perk_tortoise/zm_perk_tortoise
// Params 0, eflags: 0x0
// Checksum 0x6f3dbb34, Offset: 0x620
// Size: 0x1a
function function_b7485b07() {
    self.var_8c31eb8b = &function_d954e326;
}

// Namespace zm_perk_tortoise/zm_perk_tortoise
// Params 3, eflags: 0x0
// Checksum 0x3487dbae, Offset: 0x648
// Size: 0x26
function function_c3e68c69(b_pause, str_perk, str_result) {
    self.var_8c31eb8b = undefined;
}

// Namespace zm_perk_tortoise/zm_perk_tortoise
// Params 0, eflags: 0x0
// Checksum 0xf6717663, Offset: 0x678
// Size: 0x26e
function function_d954e326() {
    a_ai = self getenemiesinradius(self.origin, 320);
    a_ai = arraysortclosest(a_ai, self.origin);
    if (zm_trial_restrict_loadout::is_active()) {
        a_ai = [];
    }
    foreach (ai in a_ai) {
        if (ai.health <= 1200) {
            ai.marked_for_death = 1;
        }
    }
    self thread explosion_fx();
    foreach (ai in a_ai) {
        ai dodamage(1200, self.origin, self, self, "none", "MOD_UNKNOWN");
        if (isalive(ai)) {
            if (ai.var_29ed62b2 === #"heavy" || ai.var_29ed62b2 === #"miniboss") {
                ai ai::stun();
            } else {
                ai zombie_utility::setup_zombie_knockdown(self);
            }
        } else if (ai.var_29ed62b2 == #"basic") {
            ai zm_spawner::zombie_explodes_intopieces(0);
        }
        waitframe(1);
    }
}

// Namespace zm_perk_tortoise/zm_perk_tortoise
// Params 0, eflags: 0x0
// Checksum 0x8e78fc59, Offset: 0x8f0
// Size: 0x2c
function explosion_fx() {
    wait 0.3;
    self clientfield::increment("perk_tortoise_explosion");
}

