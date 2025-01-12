#using scripts\core_common\ai\systems\destructible_character;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\globallogic\globallogic_player;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\zm_common\bb;
#using scripts\zm_common\gametypes\globallogic_player;
#using scripts\zm_common\gametypes\globallogic_utils;

#namespace globallogic_actor;

// Namespace globallogic_actor/globallogic_actor
// Params 1, eflags: 0x1 linked
// Checksum 0xa3ebb9ef, Offset: 0xa8
// Size: 0x3c
function callback_actorspawned(spawner) {
    self thread spawner::spawn_think(spawner);
    bb::logaispawn(self, spawner);
}

// Namespace globallogic_actor/globallogic_actor
// Params 1, eflags: 0x1 linked
// Checksum 0x9f7f292e, Offset: 0xf0
// Size: 0x3c
function callback_actorcloned(original) {
    destructserverutils::copydestructstate(original, self);
    gibserverutils::copygibstate(original, self);
}

