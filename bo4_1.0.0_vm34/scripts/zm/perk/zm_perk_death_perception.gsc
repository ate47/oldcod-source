#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_death_perception;

// Namespace zm_perk_death_perception/zm_perk_death_perception
// Params 0, eflags: 0x2
// Checksum 0x41687817, Offset: 0x1a0
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_perk_death_perception", &__init__, &__main__, undefined);
}

// Namespace zm_perk_death_perception/zm_perk_death_perception
// Params 0, eflags: 0x0
// Checksum 0x1d55d909, Offset: 0x1f0
// Size: 0x14
function __init__() {
    enable_death_perception_perk_for_level();
}

// Namespace zm_perk_death_perception/zm_perk_death_perception
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x210
// Size: 0x4
function __main__() {
    
}

// Namespace zm_perk_death_perception/zm_perk_death_perception
// Params 0, eflags: 0x0
// Checksum 0x1b613ac6, Offset: 0x220
// Size: 0x19c
function enable_death_perception_perk_for_level() {
    zm_perks::register_perk_basic_info(#"specialty_awareness", "perk_death_perception", 2000, #"hash_44056ea72a6d4fd5", getweapon("zombie_perk_bottle_nuke"), getweapon("zombie_perk_totem_death_perception"), #"zmperksdeathperception");
    zm_perks::register_perk_precache_func(#"specialty_awareness", &function_e6c10593);
    zm_perks::register_perk_clientfields(#"specialty_awareness", &function_6bee1529, &function_a7d80dae);
    zm_perks::register_perk_machine(#"specialty_awareness", &function_5ea3f998, &function_450f0786);
    zm_perks::register_perk_host_migration_params(#"specialty_awareness", "p7_zm_vending_nuke", "divetonuke_light");
    zm_perks::register_perk_threads(#"specialty_awareness", &function_aa495970, &function_4b7488fe);
}

// Namespace zm_perk_death_perception/zm_perk_death_perception
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x3c8
// Size: 0x4
function function_450f0786() {
    
}

// Namespace zm_perk_death_perception/zm_perk_death_perception
// Params 0, eflags: 0x0
// Checksum 0xfe559bd4, Offset: 0x3d8
// Size: 0xbe
function function_e6c10593() {
    level.machine_assets[#"specialty_awareness"] = spawnstruct();
    level.machine_assets[#"specialty_awareness"].weapon = getweapon("zombie_perk_bottle_nuke");
    level.machine_assets[#"specialty_awareness"].off_model = "p7_zm_vending_nuke";
    level.machine_assets[#"specialty_awareness"].on_model = "p7_zm_vending_nuke";
}

// Namespace zm_perk_death_perception/zm_perk_death_perception
// Params 0, eflags: 0x0
// Checksum 0xc8ad013c, Offset: 0x4a0
// Size: 0x64
function function_6bee1529() {
    clientfield::register("clientuimodel", "hudItems.perks.death_perception", 1, 1, "int");
    clientfield::register("toplayer", "perk_death_perception_visuals", 1, 1, "int");
}

// Namespace zm_perk_death_perception/zm_perk_death_perception
// Params 1, eflags: 0x0
// Checksum 0x1e522117, Offset: 0x510
// Size: 0x2c
function function_a7d80dae(state) {
    self clientfield::set_player_uimodel("hudItems.perks.death_perception", state);
}

// Namespace zm_perk_death_perception/zm_perk_death_perception
// Params 4, eflags: 0x0
// Checksum 0xa5ad74b3, Offset: 0x548
// Size: 0xb6
function function_5ea3f998(use_trigger, perk_machine, bump_trigger, collision) {
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

// Namespace zm_perk_death_perception/zm_perk_death_perception
// Params 0, eflags: 0x0
// Checksum 0x92cf280b, Offset: 0x608
// Size: 0x24
function function_aa495970() {
    self clientfield::set_to_player("perk_death_perception_visuals", 1);
}

// Namespace zm_perk_death_perception/zm_perk_death_perception
// Params 3, eflags: 0x0
// Checksum 0x1df777dc, Offset: 0x638
// Size: 0x3c
function function_4b7488fe(b_pause, str_perk, str_result) {
    self clientfield::set_to_player("perk_death_perception_visuals", 0);
}

