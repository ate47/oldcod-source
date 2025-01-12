#using script_1940fc077a028a81;
#using script_3357acf79ce92f4b;
#using script_3411bb48d41bd3b;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;
#using scripts\zm\ai\zm_ai_mimic;

#namespace namespace_3d98def3;

// Namespace namespace_3d98def3/namespace_3d98def3
// Params 0, eflags: 0x6
// Checksum 0xcecbf30c, Offset: 0xf0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_e87958e045f8b8d", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_3d98def3/namespace_3d98def3
// Params 0, eflags: 0x0
// Checksum 0x821bc400, Offset: 0x138
// Size: 0x64
function function_70a657d8() {
    spawner::add_archetype_spawn_function(#"mimic", &function_76433e31);
    spawner::function_89a2cd87(#"mimic", &function_820e5ac3);
}

// Namespace namespace_3d98def3/namespace_3d98def3
// Params 0, eflags: 0x0
// Checksum 0xdf024e82, Offset: 0x1a8
// Size: 0x5c
function function_76433e31() {
    self.ai.var_870d0893 = 1;
    self callback::function_d8abfc3d(#"on_entity_hidden_in_prop", &function_5c2b66f6);
    setup_awareness(self);
}

// Namespace namespace_3d98def3/namespace_3d98def3
// Params 0, eflags: 0x0
// Checksum 0xa3e8e9f9, Offset: 0x210
// Size: 0x34
function function_820e5ac3() {
    self callback::function_d8abfc3d(#"on_entity_revealed", &on_entity_revealed);
}

// Namespace namespace_3d98def3/namespace_3d98def3
// Params 1, eflags: 0x4
// Checksum 0xb32d2b4f, Offset: 0x250
// Size: 0x214
function private setup_awareness(entity) {
    entity.fovcosine = 0.5;
    entity.maxsightdistsqrd = function_a3f6cdac(1000);
    entity.has_awareness = 1;
    entity.ignorelaststandplayers = 1;
    entity.var_1267fdea = 1;
    self callback::function_d8abfc3d(#"on_ai_damage", &awareness::function_5f511313);
    awareness::register_state(entity, #"wander", &function_eee7ec28, &awareness::function_4ebe4a6d, &awareness::function_b264a0bc, undefined, &awareness::function_555d960b);
    awareness::register_state(entity, #"chase", &function_f5ed7704, &awareness::function_39da6c3c, &awareness::function_b9f81e8b, &awareness::function_5c40e824);
    awareness::register_state(entity, #"investigate", &function_24c7396d, &awareness::function_9eefc327, &awareness::function_34162a25, undefined, &awareness::function_a360dd00);
    awareness::set_state(entity, #"wander");
    entity callback::function_d8abfc3d(#"hash_10ab46b52df7967a", &function_5394f283);
    entity thread awareness::function_fa6e010d();
}

// Namespace namespace_3d98def3/namespace_3d98def3
// Params 1, eflags: 0x0
// Checksum 0x32ce4d4d, Offset: 0x470
// Size: 0x64
function function_5394f283(*params) {
    self endon(#"death");
    if (isdefined(self.attackable)) {
        namespace_85745671::function_2b925fa5(self);
    }
    self kill(undefined, undefined, undefined, undefined, 0, 1);
}

// Namespace namespace_3d98def3/namespace_3d98def3
// Params 1, eflags: 0x0
// Checksum 0x5afc8514, Offset: 0x4e0
// Size: 0x24
function function_5c2b66f6(*prop) {
    awareness::pause(self);
}

// Namespace namespace_3d98def3/namespace_3d98def3
// Params 1, eflags: 0x0
// Checksum 0x4874b806, Offset: 0x510
// Size: 0x64
function on_entity_revealed(params) {
    awareness::resume(self);
    var_1be227f1 = array::random(params.var_ef7458f2);
    awareness::function_c241ef9a(self, var_1be227f1, 10);
}

// Namespace namespace_3d98def3/namespace_3d98def3
// Params 1, eflags: 0x0
// Checksum 0x9b595fb4, Offset: 0x580
// Size: 0x4c
function function_eee7ec28(entity) {
    entity setblackboardattribute("_locomotion_speed", "locomotion_speed_walk");
    awareness::function_9c9d96b5(entity);
}

// Namespace namespace_3d98def3/namespace_3d98def3
// Params 1, eflags: 0x0
// Checksum 0x580cce18, Offset: 0x5d8
// Size: 0x4c
function function_24c7396d(entity) {
    entity setblackboardattribute("_locomotion_speed", "locomotion_speed_run");
    awareness::function_b41f0471(entity);
}

// Namespace namespace_3d98def3/namespace_3d98def3
// Params 1, eflags: 0x0
// Checksum 0xf16e97c8, Offset: 0x630
// Size: 0x4c
function function_f5ed7704(entity) {
    entity setblackboardattribute("_locomotion_speed", "locomotion_speed_run");
    awareness::function_978025e4(entity);
}

