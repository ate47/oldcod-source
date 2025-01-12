#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_mod_bandolier;

// Namespace zm_perk_mod_bandolier/zm_perk_mod_bandolier
// Params 0, eflags: 0x2
// Checksum 0x2a55afa6, Offset: 0x88
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_perk_mod_bandolier", &__init__, undefined, undefined);
}

// Namespace zm_perk_mod_bandolier/zm_perk_mod_bandolier
// Params 0, eflags: 0x0
// Checksum 0xa9773b8d, Offset: 0xd0
// Size: 0x14
function __init__() {
    function_1b8229bc();
}

// Namespace zm_perk_mod_bandolier/zm_perk_mod_bandolier
// Params 0, eflags: 0x0
// Checksum 0x6306dab9, Offset: 0xf0
// Size: 0x84
function function_1b8229bc() {
    zm_perks::register_perk_mod_basic_info(#"specialty_mod_extraammo", "mod_bandolier", #"specialty_extraammo", 3500);
    zm_perks::register_perk_threads(#"specialty_mod_extraammo", &give_mod_perk, &function_1e3ecae4);
}

// Namespace zm_perk_mod_bandolier/zm_perk_mod_bandolier
// Params 0, eflags: 0x0
// Checksum 0x18ee0610, Offset: 0x180
// Size: 0x1c
function give_mod_perk() {
    self thread function_2806a1e1();
}

// Namespace zm_perk_mod_bandolier/zm_perk_mod_bandolier
// Params 3, eflags: 0x0
// Checksum 0xf07312d5, Offset: 0x1a8
// Size: 0x2e
function function_1e3ecae4(b_pause, str_perk, str_result) {
    self notify(#"hash_73b1e35c66a4e898");
}

// Namespace zm_perk_mod_bandolier/zm_perk_mod_bandolier
// Params 0, eflags: 0x0
// Checksum 0x94e4344c, Offset: 0x1e0
// Size: 0x294
function function_2806a1e1() {
    self endon(#"disconnect", #"hash_73b1e35c66a4e898");
    while (true) {
        wait 1;
        a_weapons = self getweaponslistprimaries();
        foreach (weapon in a_weapons) {
            if (self getcurrentweapon() == weapon) {
                continue;
            }
            n_clip = self getweaponammoclip(weapon);
            n_clip_size = weapon.clipsize;
            n_stock_size = self getweaponammostock(weapon);
            if (isdefined(n_clip) && isdefined(n_clip_size) && n_clip < n_clip_size) {
                var_8502f83e = int(ceil(n_clip_size * 0.05));
                if (n_stock_size >= var_8502f83e) {
                    self setweaponammoclip(weapon, n_clip + var_8502f83e);
                    self setweaponammostock(weapon, n_stock_size - var_8502f83e);
                    if (n_clip + var_8502f83e >= n_clip_size) {
                        self playsoundtoplayer(#"hash_1306cd3cf0ce7b64", self);
                    }
                    continue;
                }
                if (n_stock_size > 0) {
                    self setweaponammoclip(weapon, n_clip + 1);
                    self setweaponammostock(weapon, n_stock_size - 1);
                    self playsoundtoplayer(#"hash_1306cd3cf0ce7b64", self);
                }
            }
        }
    }
}

