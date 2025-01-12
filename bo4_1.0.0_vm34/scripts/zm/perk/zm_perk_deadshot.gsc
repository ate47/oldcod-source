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

#namespace zm_perk_deadshot;

// Namespace zm_perk_deadshot/zm_perk_deadshot
// Params 0, eflags: 0x2
// Checksum 0x70189536, Offset: 0x1b8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_perk_deadshot", &__init__, undefined, undefined);
}

// Namespace zm_perk_deadshot/zm_perk_deadshot
// Params 0, eflags: 0x0
// Checksum 0xdc0b35c5, Offset: 0x200
// Size: 0x14
function __init__() {
    enable_deadshot_perk_for_level();
}

// Namespace zm_perk_deadshot/zm_perk_deadshot
// Params 0, eflags: 0x0
// Checksum 0x7dac0024, Offset: 0x220
// Size: 0x18c
function enable_deadshot_perk_for_level() {
    zm_perks::register_perk_basic_info(#"specialty_deadshot", "perk_dead_shot", 2000, #"zombie/perk_deadshot", getweapon("zombie_perk_bottle_deadshot"), getweapon("zombie_perk_totem_deadshot"), #"zmperksdeadshot");
    zm_perks::register_perk_precache_func(#"specialty_deadshot", &deadshot_precache);
    zm_perks::register_perk_clientfields(#"specialty_deadshot", &deadshot_register_clientfield, &deadshot_set_clientfield);
    zm_perks::register_perk_machine(#"specialty_deadshot", &deadshot_perk_machine_setup);
    zm_perks::register_perk_threads(#"specialty_deadshot", &give_deadshot_perk, &take_deadshot_perk);
    zm_perks::register_perk_host_migration_params(#"specialty_deadshot", "vending_deadshot", "deadshot_light");
}

// Namespace zm_perk_deadshot/zm_perk_deadshot
// Params 0, eflags: 0x0
// Checksum 0xc3ad582b, Offset: 0x3b8
// Size: 0x10e
function deadshot_precache() {
    if (isdefined(level.var_72a62e0d)) {
        [[ level.var_72a62e0d ]]();
        return;
    }
    level._effect[#"deadshot_light"] = #"hash_2225287695ddf9c9";
    level.machine_assets[#"specialty_deadshot"] = spawnstruct();
    level.machine_assets[#"specialty_deadshot"].weapon = getweapon("zombie_perk_bottle_deadshot");
    level.machine_assets[#"specialty_deadshot"].off_model = "p7_zm_vending_ads";
    level.machine_assets[#"specialty_deadshot"].on_model = "p7_zm_vending_ads";
}

// Namespace zm_perk_deadshot/zm_perk_deadshot
// Params 0, eflags: 0x0
// Checksum 0xdd88b7c1, Offset: 0x4d0
// Size: 0x64
function deadshot_register_clientfield() {
    clientfield::register("toplayer", "deadshot_perk", 1, 1, "int");
    clientfield::register("clientuimodel", "hudItems.perks.dead_shot", 1, 2, "int");
}

// Namespace zm_perk_deadshot/zm_perk_deadshot
// Params 1, eflags: 0x0
// Checksum 0x984f671d, Offset: 0x540
// Size: 0x2c
function deadshot_set_clientfield(state) {
    self clientfield::set_player_uimodel("hudItems.perks.dead_shot", state);
}

// Namespace zm_perk_deadshot/zm_perk_deadshot
// Params 4, eflags: 0x0
// Checksum 0xb8504c84, Offset: 0x578
// Size: 0xb6
function deadshot_perk_machine_setup(use_trigger, perk_machine, bump_trigger, collision) {
    use_trigger.script_sound = "mus_perks_deadshot_jingle";
    use_trigger.script_string = "deadshot_perk";
    use_trigger.script_label = "mus_perks_deadshot_sting";
    use_trigger.target = "vending_deadshot";
    perk_machine.script_string = "deadshot_vending";
    perk_machine.targetname = "vending_deadshot";
    if (isdefined(bump_trigger)) {
        bump_trigger.script_string = "deadshot_vending";
    }
}

// Namespace zm_perk_deadshot/zm_perk_deadshot
// Params 0, eflags: 0x0
// Checksum 0x38568546, Offset: 0x638
// Size: 0x24
function give_deadshot_perk() {
    self clientfield::set_to_player("deadshot_perk", 1);
}

// Namespace zm_perk_deadshot/zm_perk_deadshot
// Params 3, eflags: 0x0
// Checksum 0x668ba27a, Offset: 0x668
// Size: 0x3c
function take_deadshot_perk(b_pause, str_perk, str_result) {
    self clientfield::set_to_player("deadshot_perk", 0);
}

