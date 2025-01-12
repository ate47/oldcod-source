#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_bandolier;

// Namespace zm_perk_bandolier/zm_perk_bandolier
// Params 0, eflags: 0x2
// Checksum 0x2a45970c, Offset: 0x168
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_perk_bandolier", &__init__, undefined, undefined);
}

// Namespace zm_perk_bandolier/zm_perk_bandolier
// Params 0, eflags: 0x0
// Checksum 0x6eee7c20, Offset: 0x1b0
// Size: 0x14
function __init__() {
    function_1b8229bc();
}

// Namespace zm_perk_bandolier/zm_perk_bandolier
// Params 0, eflags: 0x0
// Checksum 0x326586dc, Offset: 0x1d0
// Size: 0x18c
function function_1b8229bc() {
    zm_perks::register_perk_basic_info(#"specialty_extraammo", "perk_bandolier", 3000, #"zombie/perk_bandolier", getweapon("zombie_perk_bottle_sleight"), getweapon("zombie_perk_totem_bandolier"), #"zmperksbandolier");
    zm_perks::register_perk_precache_func(#"specialty_extraammo", &perk_precache);
    zm_perks::register_perk_clientfields(#"specialty_extraammo", &perk_register_clientfield, &perk_set_clientfield);
    zm_perks::register_perk_machine(#"specialty_extraammo", &perk_machine_setup);
    zm_perks::register_perk_host_migration_params(#"specialty_extraammo", "vending_bandolier", "sleight_light");
    zm_perks::register_perk_threads(#"specialty_extraammo", &give_perk, &take_perk);
}

// Namespace zm_perk_bandolier/zm_perk_bandolier
// Params 0, eflags: 0x0
// Checksum 0xf49883d8, Offset: 0x368
// Size: 0xe6
function perk_precache() {
    if (isdefined(level.var_311e4d3d)) {
        [[ level.var_311e4d3d ]]();
        return;
    }
    level.machine_assets[#"specialty_extraammo"] = spawnstruct();
    level.machine_assets[#"specialty_extraammo"].weapon = getweapon("zombie_perk_bottle_sleight");
    level.machine_assets[#"specialty_extraammo"].off_model = "p7_zm_vending_sleight";
    level.machine_assets[#"specialty_extraammo"].on_model = "p7_zm_vending_sleight";
}

// Namespace zm_perk_bandolier/zm_perk_bandolier
// Params 0, eflags: 0x0
// Checksum 0xc0ac613a, Offset: 0x458
// Size: 0x34
function perk_register_clientfield() {
    clientfield::register("clientuimodel", "hudItems.perks.bandolier", 1, 2, "int");
}

// Namespace zm_perk_bandolier/zm_perk_bandolier
// Params 1, eflags: 0x0
// Checksum 0x4d6ee686, Offset: 0x498
// Size: 0x2c
function perk_set_clientfield(state) {
    self clientfield::set_player_uimodel("hudItems.perks.bandolier", state);
}

// Namespace zm_perk_bandolier/zm_perk_bandolier
// Params 4, eflags: 0x0
// Checksum 0x169d21f2, Offset: 0x4d0
// Size: 0xb6
function perk_machine_setup(use_trigger, perk_machine, bump_trigger, collision) {
    use_trigger.script_sound = "mus_perks_speed_jingle";
    use_trigger.script_string = "bandolier_perk";
    use_trigger.script_label = "mus_perks_speed_sting";
    use_trigger.target = "vending_bandolier";
    perk_machine.script_string = "bandolier_perk";
    perk_machine.targetname = "vending_bandolier";
    if (isdefined(bump_trigger)) {
        bump_trigger.script_string = "bandolier_perk";
    }
}

// Namespace zm_perk_bandolier/zm_perk_bandolier
// Params 0, eflags: 0x0
// Checksum 0xf165035c, Offset: 0x590
// Size: 0x1c
function give_perk() {
    self set_ammo();
}

// Namespace zm_perk_bandolier/zm_perk_bandolier
// Params 3, eflags: 0x0
// Checksum 0x7d6e6c22, Offset: 0x5b8
// Size: 0x34
function take_perk(b_pause, str_perk, str_result) {
    self set_ammo(0);
}

// Namespace zm_perk_bandolier/zm_perk_bandolier
// Params 1, eflags: 0x0
// Checksum 0xb36cf61c, Offset: 0x5f8
// Size: 0x170
function set_ammo(b_max_ammo = 1) {
    a_weapons = self getweaponslistprimaries();
    foreach (weapon in a_weapons) {
        if (weapon !== self.laststandpistol) {
            if (b_max_ammo) {
                var_f657c43c = weapon.maxammo - weapon.startammo;
                var_f189a14 = self getweaponammostock(weapon);
                var_6cd3c191 = var_f189a14 + var_f657c43c;
                self setweaponammostock(weapon, var_6cd3c191);
                continue;
            }
            if (self getweaponammostock(weapon) > weapon.startammo) {
                self setweaponammostock(weapon, weapon.startammo);
            }
        }
    }
}

