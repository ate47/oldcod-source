#using scripts\abilities\ability_power;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\dog_shared;
#using scripts\killstreaks\killstreaks_shared;

#namespace dog;

// Namespace dog/dog
// Params 0, eflags: 0x2
// Checksum 0xfab27159, Offset: 0xb8
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"killstreak_dog", &__init__, undefined, #"killstreaks");
}

// Namespace dog/dog
// Params 0, eflags: 0x0
// Checksum 0xe349e419, Offset: 0x108
// Size: 0x11c
function __init__() {
    init_shared();
    bundle = struct::get_script_bundle("killstreak", #"killstreak_dog");
    if (isdefined(bundle)) {
        bundle.var_2ce63078 = "actor_spawner_boct_mp_dog";
    }
    killstreaks::register_bundle(bundle, &spawned);
    killstreaks::allow_assists(bundle.var_e409027f, 1);
    level.var_65ac87e5 = getweapon(#"ability_dog");
    level.var_69a57fbd = getweapon(#"dog_ai_defaultmelee");
    ability_power::function_db8f789(level.var_65ac87e5, level.var_69a57fbd);
}

