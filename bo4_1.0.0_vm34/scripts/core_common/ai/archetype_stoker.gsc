#using scripts\core_common\ai\archetype_stoker_interface;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\spawner_shared;

#namespace archetype_stoker;

// Namespace archetype_stoker/archetype_stoker
// Params 0, eflags: 0x2
// Checksum 0x799d5e8e, Offset: 0x90
// Size: 0x78
function autoexec init_shared() {
    if (isdefined(level.stokerinit)) {
        return;
    }
    level.stokerinit = 1;
    function_c54a3c4e();
    spawner::add_archetype_spawn_function("stoker", &function_61c7452a);
    stokerinterface::registerstokerinterfaceattributes();
    /#
    #/
}

// Namespace archetype_stoker/archetype_stoker
// Params 0, eflags: 0x4
// Checksum 0x80f724d1, Offset: 0x110
// Size: 0x4
function private function_c54a3c4e() {
    
}

// Namespace archetype_stoker/archetype_stoker
// Params 0, eflags: 0x4
// Checksum 0xc6ebd76b, Offset: 0x120
// Size: 0x4a
function private function_61c7452a() {
    blackboard::createblackboardforentity(self);
    ai::createinterfaceforentity(self);
    self.___archetypeonanimscriptedcallback = &function_c179924c;
}

// Namespace archetype_stoker/archetype_stoker
// Params 1, eflags: 0x4
// Checksum 0x7a34dfc7, Offset: 0x178
// Size: 0x2c
function private function_c179924c(entity) {
    entity.__blackboard = undefined;
    entity function_61c7452a();
}

// Namespace archetype_stoker/archetype_stoker
// Params 4, eflags: 0x0
// Checksum 0x36f7f258, Offset: 0x1b0
// Size: 0x58
function function_d9cde0cf(entity, attribute, oldvalue, value) {
    if (isdefined(entity.var_83103966)) {
        entity [[ entity.var_83103966 ]](entity, attribute, oldvalue, value);
    }
}

