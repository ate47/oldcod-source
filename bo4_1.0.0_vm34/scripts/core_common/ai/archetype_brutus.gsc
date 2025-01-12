#using scripts\core_common\ai\archetype_brutus_interface;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\spawner_shared;

#namespace archetypebrutus;

// Namespace archetypebrutus/archetype_brutus
// Params 0, eflags: 0x2
// Checksum 0x3086dde, Offset: 0x90
// Size: 0x4c
function autoexec init() {
    brutusinterface::registerbrutusinterfaceattributes();
    registerbehaviorscriptfunctions();
    spawner::add_archetype_spawn_function("brutus", &function_64aa2fe4);
}

/#

    // Namespace archetypebrutus/archetype_brutus
    // Params 0, eflags: 0x4
    // Checksum 0x75922d70, Offset: 0xe8
    // Size: 0x24
    function private function_fe1b2543() {
        assert(isdefined(self.ai));
    }

#/

// Namespace archetypebrutus/archetype_brutus
// Params 0, eflags: 0x4
// Checksum 0x577b06a0, Offset: 0x118
// Size: 0x62
function private function_64aa2fe4() {
    blackboard::createblackboardforentity(self);
    ai::createinterfaceforentity(self);
    self.___archetypeonanimscriptedcallback = &function_ea0b818a;
    self.___archetypeonbehavecallback = &function_fcad52c6;
}

// Namespace archetypebrutus/archetype_brutus
// Params 1, eflags: 0x4
// Checksum 0xf68b3d4e, Offset: 0x188
// Size: 0xc
function private function_fcad52c6(entity) {
    
}

// Namespace archetypebrutus/archetype_brutus
// Params 1, eflags: 0x4
// Checksum 0xbebcb96f, Offset: 0x1a0
// Size: 0x2c
function private function_ea0b818a(entity) {
    self.__blackboard = undefined;
    self function_64aa2fe4();
}

// Namespace archetypebrutus/archetype_brutus
// Params 0, eflags: 0x4
// Checksum 0x80f724d1, Offset: 0x1d8
// Size: 0x4
function private registerbehaviorscriptfunctions() {
    
}

/#

    // Namespace archetypebrutus/archetype_brutus
    // Params 1, eflags: 0x4
    // Checksum 0x1d0aec3c, Offset: 0x1e8
    // Size: 0x54
    function private function_f5bc0c64(message) {
        if (getdvarint(#"scr_brutusdebug", 0)) {
            println("<dev string:x30>" + message);
        }
    }

#/

// Namespace archetypebrutus/archetype_brutus
// Params 4, eflags: 0x0
// Checksum 0xfeac8f84, Offset: 0x248
// Size: 0x44
function function_186daff5(entity, attribute, oldvalue, value) {
    if (value) {
        entity function_9f59031e();
    }
}

