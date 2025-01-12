#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\bots\bot;
#using scripts\core_common\bots\bot_traversals;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\globallogic\globallogic_vehicle;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\weapons\deployable;
#using scripts\zm_common\gametypes\globallogic;
#using scripts\zm_common\gametypes\globallogic_actor;
#using scripts\zm_common\gametypes\globallogic_player;
#using scripts\zm_common\gametypes\globallogic_scriptmover;
#using scripts\zm_common\gametypes\hostmigration;

#namespace callback;

// Namespace callback/callbacks
// Params 0, eflags: 0x2
// Checksum 0xa62bd9e5, Offset: 0xe0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"callback", &__init__, undefined, undefined);
}

// Namespace callback/callbacks
// Params 0, eflags: 0x0
// Checksum 0xb0fac97f, Offset: 0x128
// Size: 0x1c
function __init__() {
    level thread setup_callbacks();
}

// Namespace callback/callbacks
// Params 0, eflags: 0x0
// Checksum 0xfcd95f71, Offset: 0x150
// Size: 0xf2
function setup_callbacks() {
    setdefaultcallbacks();
    level.idflags_noflag = 0;
    level.idflags_radius = 1;
    level.idflags_no_armor = 2;
    level.idflags_no_knockback = 4;
    level.idflags_penetration = 8;
    level.idflags_destructible_entity = 16;
    level.idflags_shield_explosive_impact = 32;
    level.idflags_shield_explosive_impact_huge = 64;
    level.idflags_shield_explosive_splash = 128;
    level.idflags_hurt_trigger_allow_laststand = 256;
    level.idflags_disable_ragdoll_skip = 512;
    level.idflags_no_team_protection = 8192;
    level.var_eedc82f2 = 16384;
    level.var_8883166b = 32768;
}

// Namespace callback/callbacks
// Params 0, eflags: 0x0
// Checksum 0x8e339373, Offset: 0x250
// Size: 0x19a
function setdefaultcallbacks() {
    level.callbackstartgametype = &globallogic::callback_startgametype;
    level.callbackplayerconnect = &globallogic_player::callback_playerconnect;
    level.callbackplayerdisconnect = &globallogic_player::callback_playerdisconnect;
    level.callbackplayermelee = &globallogic_player::callback_playermelee;
    level.callbackactorspawned = &globallogic_actor::callback_actorspawned;
    level.callbackactorcloned = &globallogic_actor::callback_actorcloned;
    level.var_e66ba0a3 = &globallogic_scriptmover::function_d786279a;
    level.callbackvehiclespawned = &globallogic_vehicle::callback_vehiclespawned;
    level.callbackplayermigrated = &globallogic_player::callback_playermigrated;
    level.callbackhostmigration = &hostmigration::callback_hostmigration;
    level.callbackhostmigrationsave = &hostmigration::callback_hostmigrationsave;
    level.callbackprehostmigrationsave = &hostmigration::callback_prehostmigrationsave;
    level.callbackbotentereduseredge = &bot::callback_botentereduseredge;
    level.callbackbotcreateplayerbot = &bot::function_3894691d;
    level.callbackbotshutdown = &bot::function_8747b717;
    level.var_d280b204 = &deployable::function_1d161d95;
    level._gametype_default = "zclassic";
}

// Namespace callback/callbacks
// Params 2, eflags: 0x0
// Checksum 0x19f2d4a6, Offset: 0x3f8
// Size: 0x3c
function function_9b1e3217(func, obj) {
    add_callback(#"hash_1eda827ff5e6895b", func, obj);
}

// Namespace callback/callbacks
// Params 2, eflags: 0x0
// Checksum 0x8f218056, Offset: 0x440
// Size: 0x3c
function function_8fd41f68(func, obj) {
    remove_callback(#"hash_34edc1c4f45e5572", func, obj);
}

// Namespace callback/callbacks
// Params 2, eflags: 0x0
// Checksum 0xebd55c39, Offset: 0x488
// Size: 0x3c
function function_5a6e6389(func, obj) {
    add_callback(#"hash_210adcf09e99fba1", func, obj);
}

// Namespace callback/callbacks
// Params 2, eflags: 0x0
// Checksum 0x801a4d2a, Offset: 0x4d0
// Size: 0x3c
function function_9c8587e(func, obj) {
    remove_callback(#"hash_1863ba8e81df2a64", func, obj);
}

// Namespace callback/callbacks
// Params 2, eflags: 0x0
// Checksum 0x9ee1b49c, Offset: 0x518
// Size: 0x3c
function function_8def5e51(func, obj) {
    add_callback(#"hash_6df5348c2fb9a509", func, obj);
}

// Namespace callback/callbacks
// Params 2, eflags: 0x0
// Checksum 0x4f73c8bd, Offset: 0x560
// Size: 0x3c
function function_327f8a2c(func, obj) {
    remove_callback(#"hash_6df5348c2fb9a509", func, obj);
}

// Namespace callback/callbacks
// Params 2, eflags: 0x0
// Checksum 0xbf9683bf, Offset: 0x5a8
// Size: 0x3c
function on_round_end(func, obj) {
    add_callback(#"on_round_end", func, obj);
}

// Namespace callback/callbacks
// Params 2, eflags: 0x0
// Checksum 0xe59fe13b, Offset: 0x5f0
// Size: 0x3c
function remove_on_round_end(func, obj) {
    remove_callback(#"on_round_end", func, obj);
}

// Namespace callback/callbacks
// Params 2, eflags: 0x0
// Checksum 0xf052ac27, Offset: 0x638
// Size: 0x3c
function function_3089d7a2(func, obj) {
    add_callback(#"hash_7d40e25056b9275c", func, obj);
}

// Namespace callback/callbacks
// Params 2, eflags: 0x0
// Checksum 0x3a4d373b, Offset: 0x680
// Size: 0x3c
function function_7d5c48f3(func, obj) {
    remove_callback(#"hash_7d40e25056b9275c", func, obj);
}

// Namespace callback/callbacks
// Params 2, eflags: 0x0
// Checksum 0x4e830019, Offset: 0x6c8
// Size: 0x3c
function function_388eb102(func, obj) {
    add_callback(#"hash_790b67aca1bf8fc0", func, obj);
}

// Namespace callback/callbacks
// Params 2, eflags: 0x0
// Checksum 0xb94ed83a, Offset: 0x710
// Size: 0x3c
function function_9d2f5a23(func, obj) {
    remove_callback(#"hash_790b67aca1bf8fc0", func, obj);
}

