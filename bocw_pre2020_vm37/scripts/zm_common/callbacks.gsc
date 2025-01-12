#using scripts\core_common\ai\systems\blackboard;
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
// Params 0, eflags: 0x6
// Checksum 0x58fda1d3, Offset: 0xc8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"callback", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace callback/callbacks
// Params 0, eflags: 0x5 linked
// Checksum 0x6f10de1b, Offset: 0x110
// Size: 0x1c
function private function_70a657d8() {
    level thread setup_callbacks();
}

// Namespace callback/callbacks
// Params 0, eflags: 0x1 linked
// Checksum 0xfa8aa9f2, Offset: 0x138
// Size: 0xf0
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
    level.var_598c4d23 = 16384;
    level.var_681a9181 = 32768;
}

// Namespace callback/callbacks
// Params 0, eflags: 0x1 linked
// Checksum 0x96dba5e7, Offset: 0x230
// Size: 0x14c
function setdefaultcallbacks() {
    level.callbackstartgametype = &globallogic::callback_startgametype;
    level.callbackplayerconnect = &globallogic_player::callback_playerconnect;
    level.callbackplayerdisconnect = &globallogic_player::callback_playerdisconnect;
    level.callbackplayermelee = &globallogic_player::callback_playermelee;
    level.callbackactorspawned = &globallogic_actor::callback_actorspawned;
    level.callbackactorcloned = &globallogic_actor::callback_actorcloned;
    level.var_6788bf11 = &globallogic_scriptmover::function_8c7ec52f;
    level.callbackvehiclespawned = &globallogic_vehicle::callback_vehiclespawned;
    level.callbackplayermigrated = &globallogic_player::callback_playermigrated;
    level.callbackhostmigration = &hostmigration::callback_hostmigration;
    level.callbackhostmigrationsave = &hostmigration::callback_hostmigrationsave;
    level.callbackprehostmigrationsave = &hostmigration::callback_prehostmigrationsave;
    level.var_69959686 = &deployable::function_209fda28;
    level._gametype_default = "zclassic";
}

// Namespace callback/callbacks
// Params 2, eflags: 0x0
// Checksum 0xeb0b726c, Offset: 0x388
// Size: 0x3c
function function_6e6149a6(func, obj) {
    add_callback(#"hash_1eda827ff5e6895b", func, obj);
}

// Namespace callback/callbacks
// Params 2, eflags: 0x0
// Checksum 0x14f3fc45, Offset: 0x3d0
// Size: 0x3c
function function_823e7181(func, obj) {
    remove_callback(#"hash_34edc1c4f45e5572", func, obj);
}

// Namespace callback/callbacks
// Params 2, eflags: 0x0
// Checksum 0x790dd17a, Offset: 0x418
// Size: 0x3c
function function_4b58e5ab(func, obj) {
    add_callback(#"hash_210adcf09e99fba1", func, obj);
}

// Namespace callback/callbacks
// Params 2, eflags: 0x0
// Checksum 0xe0e6a495, Offset: 0x460
// Size: 0x3c
function function_66d5d485(func, obj) {
    remove_callback(#"hash_1863ba8e81df2a64", func, obj);
}

// Namespace callback/callbacks
// Params 2, eflags: 0x1 linked
// Checksum 0x5ac5e6f5, Offset: 0x4a8
// Size: 0x3c
function function_74872db6(func, obj) {
    add_callback(#"hash_6df5348c2fb9a509", func, obj);
}

// Namespace callback/callbacks
// Params 2, eflags: 0x1 linked
// Checksum 0x6cb9f0b2, Offset: 0x4f0
// Size: 0x3c
function function_50fdac80(func, obj) {
    remove_callback(#"hash_6df5348c2fb9a509", func, obj);
}

// Namespace callback/callbacks
// Params 2, eflags: 0x1 linked
// Checksum 0x3b82dad2, Offset: 0x538
// Size: 0x3c
function on_round_end(func, obj) {
    add_callback(#"on_round_end", func, obj);
}

// Namespace callback/callbacks
// Params 2, eflags: 0x1 linked
// Checksum 0xb6bfb7cb, Offset: 0x580
// Size: 0x3c
function remove_on_round_end(func, obj) {
    remove_callback(#"on_round_end", func, obj);
}

// Namespace callback/callbacks
// Params 2, eflags: 0x0
// Checksum 0x17726a63, Offset: 0x5c8
// Size: 0x3c
function function_b3c9adb7(func, obj) {
    add_callback(#"hash_7d40e25056b9275c", func, obj);
}

// Namespace callback/callbacks
// Params 2, eflags: 0x0
// Checksum 0xf759a4b2, Offset: 0x610
// Size: 0x3c
function function_342b2f6(func, obj) {
    remove_callback(#"hash_7d40e25056b9275c", func, obj);
}

// Namespace callback/callbacks
// Params 2, eflags: 0x0
// Checksum 0xf3c2557f, Offset: 0x658
// Size: 0x3c
function function_aebeafc0(func, obj) {
    add_callback(#"hash_790b67aca1bf8fc0", func, obj);
}

// Namespace callback/callbacks
// Params 2, eflags: 0x0
// Checksum 0x20e0391e, Offset: 0x6a0
// Size: 0x3c
function function_3e2ed898(func, obj) {
    remove_callback(#"hash_790b67aca1bf8fc0", func, obj);
}

