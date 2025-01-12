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

#namespace zm_perk_staminup;

// Namespace zm_perk_staminup/zm_perk_staminup
// Params 0, eflags: 0x2
// Checksum 0xf9b808d, Offset: 0x1b8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_perk_staminup", &__init__, undefined, undefined);
}

// Namespace zm_perk_staminup/zm_perk_staminup
// Params 0, eflags: 0x0
// Checksum 0x6200283c, Offset: 0x200
// Size: 0x14
function __init__() {
    enable_staminup_perk_for_level();
}

// Namespace zm_perk_staminup/zm_perk_staminup
// Params 0, eflags: 0x0
// Checksum 0x4ab43c02, Offset: 0x220
// Size: 0x14c
function enable_staminup_perk_for_level() {
    zm_perks::register_perk_basic_info(#"specialty_staminup", "perk_staminup", 2000, #"zombie/perk_marathon", getweapon("zombie_perk_bottle_marathon"), getweapon("zombie_perk_totem_staminup"), #"zmperksstaminup");
    zm_perks::register_perk_precache_func(#"specialty_staminup", &staminup_precache);
    zm_perks::register_perk_clientfields(#"specialty_staminup", &staminup_register_clientfield, &staminup_set_clientfield);
    zm_perks::register_perk_machine(#"specialty_staminup", &staminup_perk_machine_setup);
    zm_perks::register_perk_host_migration_params(#"specialty_staminup", "vending_marathon", "marathon_light");
}

// Namespace zm_perk_staminup/zm_perk_staminup
// Params 0, eflags: 0x0
// Checksum 0xc2a4b0e8, Offset: 0x378
// Size: 0x106
function staminup_precache() {
    if (isdefined(level.var_5a8d1a8c)) {
        [[ level.var_5a8d1a8c ]]();
        return;
    }
    level._effect[#"marathon_light"] = "zombie/fx_perk_stamin_up_zmb";
    level.machine_assets[#"specialty_staminup"] = spawnstruct();
    level.machine_assets[#"specialty_staminup"].weapon = getweapon("zombie_perk_bottle_marathon");
    level.machine_assets[#"specialty_staminup"].off_model = "p7_zm_vending_marathon";
    level.machine_assets[#"specialty_staminup"].on_model = "p7_zm_vending_marathon";
}

// Namespace zm_perk_staminup/zm_perk_staminup
// Params 0, eflags: 0x0
// Checksum 0x505ececf, Offset: 0x488
// Size: 0x34
function staminup_register_clientfield() {
    clientfield::register("clientuimodel", "hudItems.perks.marathon", 1, 2, "int");
}

// Namespace zm_perk_staminup/zm_perk_staminup
// Params 1, eflags: 0x0
// Checksum 0x3ff080, Offset: 0x4c8
// Size: 0x2c
function staminup_set_clientfield(state) {
    self clientfield::set_player_uimodel("hudItems.perks.marathon", state);
}

// Namespace zm_perk_staminup/zm_perk_staminup
// Params 4, eflags: 0x0
// Checksum 0x99885568, Offset: 0x500
// Size: 0xb6
function staminup_perk_machine_setup(use_trigger, perk_machine, bump_trigger, collision) {
    use_trigger.script_sound = "mus_perks_stamin_jingle";
    use_trigger.script_string = "marathon_perk";
    use_trigger.script_label = "mus_perks_stamin_sting";
    use_trigger.target = "vending_marathon";
    perk_machine.script_string = "marathon_perk";
    perk_machine.targetname = "vending_marathon";
    if (isdefined(bump_trigger)) {
        bump_trigger.script_string = "marathon_perk";
    }
}

