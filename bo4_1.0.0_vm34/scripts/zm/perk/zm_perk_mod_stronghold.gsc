#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\zm\perk\zm_perk_stronghold;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_mod_stronghold;

// Namespace zm_perk_mod_stronghold/zm_perk_mod_stronghold
// Params 0, eflags: 0x2
// Checksum 0x55971e0a, Offset: 0xa0
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_perk_mod_stronghold", &__init__, &__main__, undefined);
}

// Namespace zm_perk_mod_stronghold/zm_perk_mod_stronghold
// Params 0, eflags: 0x0
// Checksum 0xb5236250, Offset: 0xf0
// Size: 0x14
function __init__() {
    function_7520d4c();
}

// Namespace zm_perk_mod_stronghold/zm_perk_mod_stronghold
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x110
// Size: 0x4
function __main__() {
    
}

// Namespace zm_perk_mod_stronghold/zm_perk_mod_stronghold
// Params 0, eflags: 0x0
// Checksum 0x2220dbf1, Offset: 0x120
// Size: 0x84
function function_7520d4c() {
    zm_perks::register_perk_mod_basic_info(#"specialty_mod_camper", "mod_stronghold", #"specialty_camper", 3000);
    zm_perks::register_perk_threads(#"specialty_mod_camper", &function_f5f6a0b1, &function_6e23e363);
}

// Namespace zm_perk_mod_stronghold/zm_perk_mod_stronghold
// Params 0, eflags: 0x0
// Checksum 0x358ab347, Offset: 0x1b0
// Size: 0x24
function function_f5f6a0b1() {
    level callback::on_ai_killed(&function_b420cf46);
}

// Namespace zm_perk_mod_stronghold/zm_perk_mod_stronghold
// Params 3, eflags: 0x0
// Checksum 0x658d99c3, Offset: 0x1e0
// Size: 0x3c
function function_6e23e363(b_pause, str_perk, str_result) {
    level callback::remove_on_ai_killed(&function_b420cf46);
}

// Namespace zm_perk_mod_stronghold/zm_perk_mod_stronghold
// Params 1, eflags: 0x0
// Checksum 0x31d2b7db, Offset: 0x228
// Size: 0xfc
function function_b420cf46(s_params) {
    player = s_params.eattacker;
    if (isplayer(player) && player hasperk(#"specialty_mod_camper")) {
        if (!player clientfield::get_to_player("" + #"hash_24e322568c9492c5")) {
            return;
        }
        n_dist = distance(player.var_22c4c9b, self.origin);
        if (n_dist <= 130) {
            player zm_perk_stronghold::add_armor();
            player zm_perk_stronghold::function_6189aee2();
        }
    }
}

