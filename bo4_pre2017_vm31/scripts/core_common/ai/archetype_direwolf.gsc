#using scripts/core_common/ai/behavior_zombie_dog;
#using scripts/core_common/ai/systems/ai_interface;
#using scripts/core_common/ai_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace namespace_46de4034;

// Namespace namespace_46de4034/archetype_direwolf
// Params 0, eflags: 0x2
// Checksum 0x5d070e4d, Offset: 0x250
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("direwolf", &__init__, undefined, undefined);
}

// Namespace namespace_46de4034/archetype_direwolf
// Params 0, eflags: 0x0
// Checksum 0xff70e8f1, Offset: 0x290
// Size: 0x1cc
function __init__() {
    spawner::add_archetype_spawn_function("direwolf", &namespace_1db6d2c9::archetypezombiedogblackboardinit);
    spawner::add_archetype_spawn_function("direwolf", &function_722f5b6f);
    ai::registermatchedinterface("direwolf", "sprint", 0, array(1, 0));
    ai::registermatchedinterface("direwolf", "howl_chance", 0.3);
    ai::registermatchedinterface("direwolf", "can_initiateaivsaimelee", 1, array(1, 0));
    ai::registermatchedinterface("direwolf", "spacing_near_dist", 120);
    ai::registermatchedinterface("direwolf", "spacing_far_dist", 480);
    ai::registermatchedinterface("direwolf", "spacing_horz_dist", 144);
    ai::registermatchedinterface("direwolf", "spacing_value", 0);
    if (ai::shouldregisterclientfieldforarchetype("direwolf")) {
        clientfield::register("actor", "direwolf_eye_glow_fx", 1, 1, "int");
    }
}

// Namespace namespace_46de4034/archetype_direwolf
// Params 0, eflags: 0x4
// Checksum 0x4379a963, Offset: 0x468
// Size: 0xe4
function private function_722f5b6f() {
    self setteam("team3");
    self allowpitchangle(1);
    self setpitchorient();
    self setavoidancemask("avoid all");
    self collidewithactors(1);
    self ai::set_behavior_attribute("spacing_value", randomfloatrange(-1, 1));
    self clientfield::set("direwolf_eye_glow_fx", 1);
}

