#using scripts\core_common\ai\archetype_blight_father_interface;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\spawner_shared;

#namespace archetypeblightfather;

// Namespace archetypeblightfather/archetype_blight_father
// Params 0, eflags: 0x2
// Checksum 0x5423f979, Offset: 0xa0
// Size: 0x4c
function autoexec main() {
    registerbehaviorscriptfunctions();
    spawner::add_archetype_spawn_function("blight_father", &function_83bf9b24);
    blightfatherinterface::registerblightfatherinterfaceattributes();
}

// Namespace archetypeblightfather/archetype_blight_father
// Params 0, eflags: 0x4
// Checksum 0xcd30304c, Offset: 0xf8
// Size: 0x4a
function private function_83bf9b24() {
    blackboard::createblackboardforentity(self);
    ai::createinterfaceforentity(self);
    self.___archetypeonanimscriptedcallback = &function_c2f2f621;
}

// Namespace archetypeblightfather/archetype_blight_father
// Params 1, eflags: 0x4
// Checksum 0xd8662731, Offset: 0x150
// Size: 0xae
function private function_c2f2f621(entity) {
    entity.__blackboard = undefined;
    entity function_83bf9b24();
    if (isdefined(entity.var_e01f007d)) {
        foreach (callback in entity.var_e01f007d) {
            [[ callback ]](entity);
        }
    }
}

// Namespace archetypeblightfather/archetype_blight_father
// Params 0, eflags: 0x4
// Checksum 0x80f724d1, Offset: 0x208
// Size: 0x4
function private registerbehaviorscriptfunctions() {
    
}

// Namespace archetypeblightfather/archetype_blight_father
// Params 2, eflags: 0x0
// Checksum 0xe7e28354, Offset: 0x218
// Size: 0xa8
function spawnblightfather(spawner, location) {
    spawner.script_forcespawn = 1;
    entity = zombie_utility::spawn_zombie(spawner, undefined, location);
    if (!isdefined(entity)) {
        return;
    }
    if (!isdefined(location.angles)) {
        angles = (0, 0, 0);
    } else {
        angles = location.angles;
    }
    entity forceteleport(location.origin, angles);
    return entity;
}

// Namespace archetypeblightfather/archetype_blight_father
// Params 1, eflags: 0x4
// Checksum 0x4f1e0c66, Offset: 0x2c8
// Size: 0x24
function private function_6829289a(entity) {
    entity melee();
}

// Namespace archetypeblightfather/archetype_blight_father
// Params 4, eflags: 0x0
// Checksum 0x2027a405, Offset: 0x2f8
// Size: 0x58
function function_723e62dd(entity, attribute, oldvalue, value) {
    if (isdefined(entity.var_83103966)) {
        entity [[ entity.var_83103966 ]](entity, attribute, oldvalue, value);
    }
}

// Namespace archetypeblightfather/archetype_blight_father
// Params 4, eflags: 0x0
// Checksum 0x44c84ef9, Offset: 0x358
// Size: 0x58
function function_355b7d09(entity, attribute, oldvalue, value) {
    if (isdefined(entity.var_3201a22f)) {
        entity [[ entity.var_3201a22f ]](entity, attribute, oldvalue, value);
    }
}

