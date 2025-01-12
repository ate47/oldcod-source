#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\zm_spawner;

#namespace zm_behavior_utility;

// Namespace zm_behavior_utility/zm_behavior_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xd5843578, Offset: 0xc8
// Size: 0x3a
function setupattackproperties() {
    self val::reset(#"attack_properties", "ignoreall");
    self.meleeattackdist = 64;
}

// Namespace zm_behavior_utility/zm_behavior_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x74253a02, Offset: 0x110
// Size: 0x3c
function enteredplayablearea() {
    self zm_spawner::zombie_complete_emerging_into_playable_area();
    self.pushable = 1;
    self setupattackproperties();
}

