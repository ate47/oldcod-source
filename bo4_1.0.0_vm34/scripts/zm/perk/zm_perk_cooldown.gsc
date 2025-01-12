#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;

#namespace zm_perk_cooldown;

// Namespace zm_perk_cooldown/zm_perk_cooldown
// Params 0, eflags: 0x2
// Checksum 0x7def907b, Offset: 0x1a0
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_perk_cooldown", &__init__, &__main__, undefined);
}

// Namespace zm_perk_cooldown/zm_perk_cooldown
// Params 0, eflags: 0x0
// Checksum 0xeef6ebad, Offset: 0x1f0
// Size: 0x14
function __init__() {
    enable_cooldown_perk_for_level();
}

// Namespace zm_perk_cooldown/zm_perk_cooldown
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x210
// Size: 0x4
function __main__() {
    
}

// Namespace zm_perk_cooldown/zm_perk_cooldown
// Params 0, eflags: 0x0
// Checksum 0x1193196c, Offset: 0x220
// Size: 0x19c
function enable_cooldown_perk_for_level() {
    zm_perks::register_perk_basic_info(#"specialty_cooldown", "perk_cooldown", 1500, #"zombie/perk_cooldown", getweapon("zombie_perk_bottle_nuke"), getweapon("zombie_perk_totem_timeslip"), #"zmperkscooldown");
    zm_perks::register_perk_precache_func(#"specialty_cooldown", &function_4da7846);
    zm_perks::register_perk_clientfields(#"specialty_cooldown", &function_4dba177c, &function_bb31acd);
    zm_perks::register_perk_machine(#"specialty_cooldown", &function_1d1216f1, &init_cooldown);
    zm_perks::register_perk_host_migration_params(#"specialty_cooldown", "p7_zm_vending_nuke", "divetonuke_light");
    zm_perks::register_perk_threads(#"specialty_cooldown", &function_bc240d69, &function_c6756093);
}

// Namespace zm_perk_cooldown/zm_perk_cooldown
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x3c8
// Size: 0x4
function init_cooldown() {
    
}

// Namespace zm_perk_cooldown/zm_perk_cooldown
// Params 0, eflags: 0x0
// Checksum 0x9704b429, Offset: 0x3d8
// Size: 0x10e
function function_4da7846() {
    if (isdefined(level.var_5585de5a)) {
        [[ level.var_5585de5a ]]();
        return;
    }
    level._effect[#"divetonuke_light"] = #"hash_2225287695ddf9c9";
    level.machine_assets[#"specialty_cooldown"] = spawnstruct();
    level.machine_assets[#"specialty_cooldown"].weapon = getweapon("zombie_perk_bottle_nuke");
    level.machine_assets[#"specialty_cooldown"].off_model = "p7_zm_vending_nuke";
    level.machine_assets[#"specialty_cooldown"].on_model = "p7_zm_vending_nuke";
}

// Namespace zm_perk_cooldown/zm_perk_cooldown
// Params 0, eflags: 0x0
// Checksum 0xc10557e3, Offset: 0x4f0
// Size: 0x34
function function_4dba177c() {
    clientfield::register("clientuimodel", "hudItems.perks.cooldown", 1, 1, "int");
}

// Namespace zm_perk_cooldown/zm_perk_cooldown
// Params 1, eflags: 0x0
// Checksum 0x9c208642, Offset: 0x530
// Size: 0x2c
function function_bb31acd(state) {
    self clientfield::set_player_uimodel("hudItems.perks.cooldown", state);
}

// Namespace zm_perk_cooldown/zm_perk_cooldown
// Params 4, eflags: 0x0
// Checksum 0x84724111, Offset: 0x568
// Size: 0xb6
function function_1d1216f1(use_trigger, perk_machine, bump_trigger, collision) {
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

// Namespace zm_perk_cooldown/zm_perk_cooldown
// Params 0, eflags: 0x0
// Checksum 0xcbe8e03d, Offset: 0x628
// Size: 0x32
function function_5585de5a() {
    level._effect[#"divetonuke_light"] = #"hash_2225287695ddf9c9";
}

// Namespace zm_perk_cooldown/zm_perk_cooldown
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x668
// Size: 0x4
function function_bc240d69() {
    
}

// Namespace zm_perk_cooldown/zm_perk_cooldown
// Params 3, eflags: 0x0
// Checksum 0x8fb4096e, Offset: 0x678
// Size: 0x1c
function function_c6756093(b_pause, str_perk, str_result) {
    
}

