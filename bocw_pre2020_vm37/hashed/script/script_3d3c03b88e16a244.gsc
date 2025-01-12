#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\spawner_shared;

#namespace namespace_baa4b777;

// Namespace namespace_baa4b777/namespace_a84b7a30
// Params 0, eflags: 0x2
// Checksum 0x20096cbb, Offset: 0x78
// Size: 0x44
function autoexec init() {
    registerbehaviorscriptfunctions();
    spawner::add_archetype_spawn_function(#"hash_7c0d83ac1e845ac2", &function_f9fa2bbb);
}

/#

    // Namespace namespace_baa4b777/namespace_a84b7a30
    // Params 0, eflags: 0x4
    // Checksum 0x28a5c03, Offset: 0xc8
    // Size: 0x24
    function private function_acf96b05() {
        assert(isdefined(self.ai));
    }

#/

// Namespace namespace_baa4b777/namespace_a84b7a30
// Params 0, eflags: 0x5 linked
// Checksum 0x1fae30d4, Offset: 0xf8
// Size: 0x7a
function private function_f9fa2bbb() {
    blackboard::createblackboardforentity(self);
    ai::createinterfaceforentity(self);
    self.___archetypeonanimscriptedcallback = &function_b8053d02;
    self.___archetypeonbehavecallback = &function_2c84ab00;
    self.var_7401c936 = &function_580889d1;
}

// Namespace namespace_baa4b777/namespace_a84b7a30
// Params 1, eflags: 0x5 linked
// Checksum 0x6967ebcb, Offset: 0x180
// Size: 0x1c
function private function_580889d1(*entity) {
    function_fa765ef3();
}

// Namespace namespace_baa4b777/namespace_a84b7a30
// Params 1, eflags: 0x5 linked
// Checksum 0x8845963, Offset: 0x1a8
// Size: 0x1c
function private function_2c84ab00(*entity) {
    function_fa765ef3();
}

// Namespace namespace_baa4b777/namespace_a84b7a30
// Params 1, eflags: 0x5 linked
// Checksum 0xea976514, Offset: 0x1d0
// Size: 0x2c
function private function_b8053d02(*entity) {
    self.__blackboard = undefined;
    self function_f9fa2bbb();
}

// Namespace namespace_baa4b777/namespace_a84b7a30
// Params 0, eflags: 0x5 linked
// Checksum 0x80f724d1, Offset: 0x208
// Size: 0x4
function private registerbehaviorscriptfunctions() {
    
}

// Namespace namespace_baa4b777/namespace_a84b7a30
// Params 0, eflags: 0x5 linked
// Checksum 0xf0e6ce0a, Offset: 0x218
// Size: 0x2a
function private function_fa765ef3() {
    if (is_true(self.var_d003d23c)) {
        self.pushable = 0;
    }
}

/#

    // Namespace namespace_baa4b777/namespace_a84b7a30
    // Params 1, eflags: 0x4
    // Checksum 0x4462df70, Offset: 0x250
    // Size: 0x54
    function private function_ee21651d(message) {
        if (getdvarint(#"hash_71bbda417e2a07e9", 0)) {
            println("<dev string:x38>" + message);
        }
    }

#/
