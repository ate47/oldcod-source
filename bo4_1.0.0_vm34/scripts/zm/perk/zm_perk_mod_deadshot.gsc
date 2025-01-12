#using scripts\core_common\callbacks_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_mod_deadshot;

// Namespace zm_perk_mod_deadshot/zm_perk_mod_deadshot
// Params 0, eflags: 0x2
// Checksum 0x328633b1, Offset: 0xa8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_perk_mod_deadshot", &__init__, undefined, undefined);
}

// Namespace zm_perk_mod_deadshot/zm_perk_mod_deadshot
// Params 0, eflags: 0x0
// Checksum 0x9f1f23d4, Offset: 0xf0
// Size: 0x42
function __init__() {
    enable_mod_deadshot_perk_for_level();
    level._effect[#"hash_950ebbfb250b43e"] = #"hash_1695e8ac20dd5629";
}

// Namespace zm_perk_mod_deadshot/zm_perk_mod_deadshot
// Params 0, eflags: 0x0
// Checksum 0x9459a419, Offset: 0x140
// Size: 0xc4
function enable_mod_deadshot_perk_for_level() {
    zm_perks::register_perk_mod_basic_info(#"specialty_mod_deadshot", "mod_deadshot", #"specialty_deadshot", 3000);
    zm_perks::register_perk_threads(#"specialty_mod_deadshot", &function_b18d1361, &function_62b2ab33);
    zm::register_actor_damage_callback(&function_19ac44c4);
    callback::on_ai_killed(&on_ai_killed);
}

// Namespace zm_perk_mod_deadshot/zm_perk_mod_deadshot
// Params 0, eflags: 0x0
// Checksum 0x44dc8afd, Offset: 0x210
// Size: 0x1c
function function_b18d1361() {
    self reset_counter();
}

// Namespace zm_perk_mod_deadshot/zm_perk_mod_deadshot
// Params 3, eflags: 0x0
// Checksum 0x6ef04fdb, Offset: 0x238
// Size: 0x34
function function_62b2ab33(b_pause, str_perk, str_result) {
    self zm_perks::function_2b57e880(3, 0);
}

// Namespace zm_perk_mod_deadshot/zm_perk_mod_deadshot
// Params 1, eflags: 0x0
// Checksum 0x869f6f82, Offset: 0x278
// Size: 0x222
function on_ai_killed(params) {
    e_attacker = params.eattacker;
    if (isplayer(e_attacker) && e_attacker hasperk(#"specialty_mod_deadshot")) {
        switch (params.smeansofdeath) {
        case #"mod_rifle_bullet":
        case #"mod_pistol_bullet":
        case #"mod_aat":
            switch (params.shitloc) {
            case #"head":
            case #"helmet":
            case #"neck":
                e_attacker.var_c6adaac8++;
                n_counter = math::clamp(e_attacker.var_c6adaac8, 0, 5);
                n_counter /= 5;
                e_attacker zm_perks::function_2b57e880(3, n_counter);
                if (e_attacker.var_c6adaac8 == 5) {
                    e_attacker playsoundtoplayer(#"hash_6f931d032000253a", e_attacker);
                }
                break;
            default:
                if (params.smeansofdeath != "MOD_AAT") {
                    e_attacker reset_counter();
                }
                break;
            }
            break;
        case #"mod_unknown":
        case #"mod_grenade_splash":
            break;
        default:
            e_attacker reset_counter();
            break;
        }
    }
}

// Namespace zm_perk_mod_deadshot/zm_perk_mod_deadshot
// Params 0, eflags: 0x0
// Checksum 0x489b66c2, Offset: 0x4a8
// Size: 0x2c
function reset_counter() {
    self.var_c6adaac8 = 0;
    self zm_perks::function_2b57e880(3, 0.05);
}

// Namespace zm_perk_mod_deadshot/zm_perk_mod_deadshot
// Params 12, eflags: 0x0
// Checksum 0x1e24a5a1, Offset: 0x4e0
// Size: 0x118
function function_19ac44c4(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (isplayer(attacker) && attacker hasperk(#"specialty_mod_deadshot")) {
        if (isdefined(attacker.var_c6adaac8) && attacker.var_c6adaac8 >= 5) {
            playfx(level._effect[#"hash_950ebbfb250b43e"], vpoint);
            return int(damage * 1.25);
        }
    }
    return -1;
}

