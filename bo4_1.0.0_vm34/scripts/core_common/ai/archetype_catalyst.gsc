#using scripts\core_common\ai\archetype_catalyst_interface;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\animation_state_machine_mocomp;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\spawner_shared;

#namespace archetypecatalyst;

// Namespace archetypecatalyst/archetype_catalyst
// Params 0, eflags: 0x2
// Checksum 0xfcf63b17, Offset: 0xe8
// Size: 0x74
function autoexec main() {
    registerbehaviorscriptfunctions();
    spawner::add_archetype_spawn_function("catalyst", &function_961ef2ad);
    spawner::add_archetype_spawn_function("catalyst", &function_7556ceb8);
    catalystinterface::registercatalystinterfaceattributes();
}

// Namespace archetypecatalyst/archetype_catalyst
// Params 0, eflags: 0x4
// Checksum 0x98f8e74c, Offset: 0x168
// Size: 0x9c
function private registerbehaviorscriptfunctions() {
    assert(isscriptfunctionptr(&iscatalyst));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"iscatalyst", &iscatalyst);
    animationstatenetwork::registeranimationmocomp("mocomp_teleport_traversal@catalyst", &function_81513af0, undefined, undefined);
}

// Namespace archetypecatalyst/archetype_catalyst
// Params 1, eflags: 0x0
// Checksum 0xcebfb01b, Offset: 0x210
// Size: 0x1c
function iscatalyst(entity) {
    return self.archetype === "catalyst";
}

// Namespace archetypecatalyst/archetype_catalyst
// Params 0, eflags: 0x0
// Checksum 0x6b84fb62, Offset: 0x238
// Size: 0xc4
function function_7556ceb8() {
    self.zombie_move_speed = "walk";
    var_b9928116 = [];
    var_b9928116[#"catalyst_corrosive"] = 1;
    var_b9928116[#"catalyst_electric"] = 3;
    var_b9928116[#"catalyst_plasma"] = 2;
    var_b9928116[#"catalyst_water"] = 4;
    if (isdefined(self.var_ea94c12a) && isdefined(var_b9928116[self.var_ea94c12a])) {
        function_cb42c01d(self, var_b9928116[self.var_ea94c12a]);
    }
}

// Namespace archetypecatalyst/archetype_catalyst
// Params 0, eflags: 0x4
// Checksum 0x7feb4142, Offset: 0x308
// Size: 0x4a
function private function_961ef2ad() {
    blackboard::createblackboardforentity(self);
    ai::createinterfaceforentity(self);
    self.___archetypeonanimscriptedcallback = &function_a3d5bb8b;
}

// Namespace archetypecatalyst/archetype_catalyst
// Params 2, eflags: 0x0
// Checksum 0xc6d419d2, Offset: 0x360
// Size: 0x150
function function_cb42c01d(entity, catalyst_type) {
    entity function_d2cf5c0(catalyst_type);
    if (isdefined(level.var_cc1b14da)) {
        if (level.var_cc1b14da[0].size > 0) {
            foreach (spawn_func in level.var_cc1b14da[0]) {
                entity [[ spawn_func ]]();
            }
        }
        if (level.var_cc1b14da[catalyst_type].size > 0) {
            foreach (spawn_func in level.var_cc1b14da[catalyst_type]) {
                entity [[ spawn_func ]]();
            }
        }
    }
    return entity;
}

// Namespace archetypecatalyst/archetype_catalyst
// Params 3, eflags: 0x0
// Checksum 0x90bd7103, Offset: 0x4b8
// Size: 0xe0
function function_49aae13b(spawner, catalyst_type, location) {
    spawner.script_forcespawn = 1;
    entity = zombie_utility::spawn_zombie(spawner, undefined, location);
    if (!isdefined(entity)) {
        return;
    }
    if (isdefined(entity.catalyst_type)) {
        return;
    }
    entity = function_cb42c01d(entity, catalyst_type);
    if (!isdefined(location.angles)) {
        angles = (0, 0, 0);
    } else {
        angles = location.angles;
    }
    entity forceteleport(location.origin, angles);
    return entity;
}

// Namespace archetypecatalyst/archetype_catalyst
// Params 1, eflags: 0x4
// Checksum 0x36c3e7ba, Offset: 0x5a0
// Size: 0x1a
function private function_d2cf5c0(catalyst_type) {
    self.catalyst_type = catalyst_type;
}

// Namespace archetypecatalyst/archetype_catalyst
// Params 1, eflags: 0x4
// Checksum 0x1963b638, Offset: 0x5c8
// Size: 0x2c
function private function_a3d5bb8b(entity) {
    entity.__blackboard = undefined;
    entity function_961ef2ad();
}

// Namespace archetypecatalyst/archetype_catalyst
// Params 2, eflags: 0x0
// Checksum 0xde7cb0a1, Offset: 0x600
// Size: 0xd4
function function_a303213c(catalyst_type, func) {
    if (!isdefined(level.var_cc1b14da)) {
        level.var_cc1b14da = [];
        level.var_cc1b14da[0] = [];
        level.var_cc1b14da[1] = [];
        level.var_cc1b14da[3] = [];
        level.var_cc1b14da[2] = [];
        level.var_cc1b14da[4] = [];
    }
    if (isdefined(level.var_cc1b14da[catalyst_type])) {
        level.var_cc1b14da[catalyst_type][level.var_cc1b14da[catalyst_type].size] = func;
    }
}

// Namespace archetypecatalyst/archetype_catalyst
// Params 5, eflags: 0x0
// Checksum 0xc6ea165c, Offset: 0x6e0
// Size: 0x194
function function_81513af0(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity orientmode("face angle", entity.angles[1]);
    entity animmode("normal");
    if (isdefined(entity.traverseendnode)) {
        /#
            print3d(entity.traversestartnode.origin, "<dev string:x30>", (1, 0, 0), 1, 1, 60);
            print3d(entity.traverseendnode.origin, "<dev string:x30>", (0, 1, 0), 1, 1, 60);
            line(entity.traversestartnode.origin, entity.traverseendnode.origin, (0, 1, 0), 1, 0, 60);
        #/
        entity forceteleport(entity.traverseendnode.origin, entity.traverseendnode.angles, 0);
    }
}

