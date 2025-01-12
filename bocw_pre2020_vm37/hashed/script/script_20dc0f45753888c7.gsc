#using script_24c32478acf44108;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace zombie_dog_toxic_cloud;

// Namespace zombie_dog_toxic_cloud/zombie_dog_toxic_cloud
// Params 0, eflags: 0x6
// Checksum 0x6570e880, Offset: 0x148
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_33449a50d9656246", &init_shared, undefined, undefined, undefined);
}

// Namespace zombie_dog_toxic_cloud/zombie_dog_toxic_cloud
// Params 0, eflags: 0x1 linked
// Checksum 0x4d7ca85c, Offset: 0x190
// Size: 0x154
function init_shared() {
    clientfield::register("actor", "" + #"hash_584428de7fdfefe2", 1, 1, "int");
    clientfield::register("toplayer", "" + #"hash_313a6af163e4bef1", 1, 1, "counter");
    clientfield::register("toplayer", "" + #"hash_10eff6a8464fb235", 1, 1, "counter");
    clientfield::register("actor", "pustule_pulse_plague", 1, 1, "int");
    namespace_9ff9f642::register_slowdown(#"hash_10d83afaeb265fde", 0.75, 2);
    spawner::add_archetype_spawn_function(#"zombie_dog", &function_4f3cd1f0);
}

// Namespace zombie_dog_toxic_cloud/zombie_dog_toxic_cloud
// Params 0, eflags: 0x1 linked
// Checksum 0x24772773, Offset: 0x2f0
// Size: 0x7c
function function_4f3cd1f0() {
    if (self.var_9fde8624 === #"hash_2a5479b83161cb35") {
        self.var_90d0c0ff = "anim_spawn_plaguehound";
        self clientfield::set("pustule_pulse_plague", 1);
        self callback::function_d8abfc3d(#"on_dog_killed", &function_a6c93300);
    }
}

// Namespace zombie_dog_toxic_cloud/zombie_dog_toxic_cloud
// Params 1, eflags: 0x1 linked
// Checksum 0x548a2aec, Offset: 0x378
// Size: 0x144
function function_a6c93300(params) {
    self function_5b8201e0();
    if (!isdefined(self.exploded) && !is_true(self.var_270befd2)) {
        self.exploded = 1;
        self clientfield::set("" + #"hash_584428de7fdfefe2", 1);
        var_659d1778 = spawn("script_origin", self.origin);
        var_659d1778 thread function_659d1778(params);
        self.var_7a68cd0c = 1;
        self ghost();
        self notsolid();
        if (isalive(self)) {
            self kill(undefined, undefined, undefined, undefined, undefined, 1);
        }
    }
}

// Namespace zombie_dog_toxic_cloud/zombie_dog_toxic_cloud
// Params 1, eflags: 0x1 linked
// Checksum 0x67f24dce, Offset: 0x4c8
// Size: 0x294
function function_659d1778(params) {
    var_9a4ca881 = gettime() + 5000;
    var_7e6e7f9f = getweapon(#"tear_gas");
    params = getstatuseffect("dot_toxic_cloud");
    while (true) {
        alive_players = function_a1ef346b(undefined, self.origin, 110);
        foreach (player in alive_players) {
            if (player laststand::player_is_in_laststand() === 0) {
                player status_effect::status_effect_apply(params, var_7e6e7f9f, self);
                player clientfield::increment_to_player("" + #"hash_313a6af163e4bef1", 1);
            }
        }
        var_98d232c6 = getentitiesinradius(self.origin, 110, 15);
        foreach (ai in var_98d232c6) {
            if (isalive(ai)) {
                ai dodamage(5, self.origin, undefined, undefined, "none", "MOD_BURNED", 0, undefined);
                ai namespace_9ff9f642::slowdown(#"hash_10d83afaeb265fde");
            }
        }
        if (var_9a4ca881 < gettime()) {
            break;
        }
        wait 0.2;
    }
}

// Namespace zombie_dog_toxic_cloud/zombie_dog_toxic_cloud
// Params 1, eflags: 0x1 linked
// Checksum 0x2d564a91, Offset: 0x768
// Size: 0x2c
function function_5b8201e0(*params) {
    self clientfield::set("pustule_pulse_plague", 0);
}

