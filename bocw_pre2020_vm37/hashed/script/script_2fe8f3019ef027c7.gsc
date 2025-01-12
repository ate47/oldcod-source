#using script_1940fc077a028a81;
#using script_3357acf79ce92f4b;
#using script_3411bb48d41bd3b;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;

#namespace namespace_45b55437;

// Namespace namespace_45b55437/namespace_45b55437
// Params 0, eflags: 0x6
// Checksum 0x321598fe, Offset: 0x98
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_7d755ebddd333af6", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_45b55437/namespace_45b55437
// Params 0, eflags: 0x0
// Checksum 0xc01a4522, Offset: 0xe0
// Size: 0x34
function function_70a657d8() {
    spawner::add_archetype_spawn_function(#"hash_da8fcc11dab30f", &function_a8e554a7);
}

// Namespace namespace_45b55437/namespace_45b55437
// Params 0, eflags: 0x0
// Checksum 0x6a4686d1, Offset: 0x120
// Size: 0x2c
function function_a8e554a7() {
    function_db7f78a1();
    setup_awareness(self);
}

// Namespace namespace_45b55437/namespace_45b55437
// Params 0, eflags: 0x4
// Checksum 0x32ce3bfd, Offset: 0x158
// Size: 0x32
function private function_db7f78a1() {
    blackboard::createblackboardforentity(self);
    self.___archetypeonanimscriptedcallback = &function_4668e5c8;
}

// Namespace namespace_45b55437/namespace_45b55437
// Params 1, eflags: 0x4
// Checksum 0x2faa3782, Offset: 0x198
// Size: 0x2c
function private function_4668e5c8(entity) {
    entity.__blackboard = undefined;
    entity function_db7f78a1();
}

// Namespace namespace_45b55437/namespace_45b55437
// Params 1, eflags: 0x4
// Checksum 0x7c219d78, Offset: 0x1d0
// Size: 0x214
function private setup_awareness(entity) {
    entity.fovcosine = 0.5;
    entity.maxsightdistsqrd = function_a3f6cdac(1000);
    entity.has_awareness = 1;
    entity.ignorelaststandplayers = 1;
    entity.var_1267fdea = 1;
    self callback::function_d8abfc3d(#"on_ai_damage", &awareness::function_5f511313);
    awareness::register_state(entity, #"wander", &awareness::function_9c9d96b5, &awareness::function_4ebe4a6d, &awareness::function_b264a0bc, undefined, &awareness::function_555d960b);
    awareness::register_state(entity, #"investigate", &awareness::function_b41f0471, &awareness::function_9eefc327, &awareness::function_34162a25, undefined, &awareness::function_a360dd00);
    awareness::register_state(entity, #"chase", &awareness::function_978025e4, &awareness::function_39da6c3c, &awareness::function_b9f81e8b, &awareness::function_5c40e824);
    awareness::set_state(entity, #"wander");
    entity callback::function_d8abfc3d(#"hash_10ab46b52df7967a", &function_bf7037e9);
    entity thread awareness::function_fa6e010d();
}

// Namespace namespace_45b55437/namespace_45b55437
// Params 1, eflags: 0x0
// Checksum 0x6703b31c, Offset: 0x3f0
// Size: 0x64
function function_bf7037e9(*params) {
    self endon(#"death");
    if (isdefined(self.attackable)) {
        namespace_85745671::function_2b925fa5(self);
    }
    self kill(undefined, undefined, undefined, undefined, 0, 1);
}

