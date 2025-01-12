#using scripts\core_common\bots\bot;
#using scripts\core_common\bots\bot_traversals;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\globallogic\globallogic_vehicle;
#using scripts\core_common\system_shared;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_actor;
#using scripts\mp_common\gametypes\globallogic_scriptmover;
#using scripts\mp_common\gametypes\hostmigration;
#using scripts\mp_common\player\player_callbacks;
#using scripts\mp_common\player\player_connect;
#using scripts\mp_common\player\player_damage;
#using scripts\mp_common\player\player_disconnect;
#using scripts\mp_common\player\player_killed;
#using scripts\weapons\deployable;

#namespace callback;

// Namespace callback/callbacks
// Params 0, eflags: 0x2
// Checksum 0x856b75a, Offset: 0xe8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"callback", &__init__, undefined, undefined);
}

// Namespace callback/callbacks
// Params 0, eflags: 0x0
// Checksum 0x5fd7bb75, Offset: 0x130
// Size: 0x14
function __init__() {
    set_default_callbacks();
}

// Namespace callback/callbacks
// Params 2, eflags: 0x0
// Checksum 0x9262c559, Offset: 0x150
// Size: 0x6c
function on_prematch_end(func, obj) {
    if (self == level) {
        add_callback(#"prematch_end", func, obj);
        return;
    }
    function_1dea870d(#"prematch_end", func, obj);
}

// Namespace callback/callbacks
// Params 2, eflags: 0x0
// Checksum 0x36d9a7c2, Offset: 0x1c8
// Size: 0x3c
function on_changed_specialist(func, obj) {
    add_callback(#"changed_specialist", func, obj);
}

// Namespace callback/callbacks
// Params 0, eflags: 0x0
// Checksum 0x9a476062, Offset: 0x210
// Size: 0x2d2
function set_default_callbacks() {
    level.callbackstartgametype = &globallogic::callback_startgametype;
    level.callbackplayerconnect = &player::callback_playerconnect;
    level.callbackplayerdisconnect = &player::callback_playerdisconnect;
    level.callbackplayerdamage = &player::callback_playerdamage;
    level.callbackplayerkilled = &player::callback_playerkilled;
    level.var_dcb50c4e = &player::function_72e649b3;
    level.callbackplayershielddamageblocked = &player::callback_playershielddamageblocked;
    level.callbackplayermelee = &player::callback_playermelee;
    level.callbackplayerlaststand = &player::callback_playerlaststand;
    level.callbackactorspawned = &globallogic_actor::callback_actorspawned;
    level.callbackactordamage = &globallogic_actor::callback_actordamage;
    level.callbackactorkilled = &globallogic_actor::callback_actorkilled;
    level.callbackactorcloned = &globallogic_actor::callback_actorcloned;
    level.var_e66ba0a3 = &globallogic_scriptmover::function_d786279a;
    level.callbackvehiclespawned = &globallogic_vehicle::callback_vehiclespawned;
    level.callbackvehicledamage = &globallogic_vehicle::callback_vehicledamage;
    level.callbackvehiclekilled = &globallogic_vehicle::callback_vehiclekilled;
    level.callbackvehicleradiusdamage = &globallogic_vehicle::callback_vehicleradiusdamage;
    level.callbackplayermigrated = &player::callback_playermigrated;
    level.callbackhostmigration = &hostmigration::callback_hostmigration;
    level.callbackhostmigrationsave = &hostmigration::callback_hostmigrationsave;
    level.callbackprehostmigrationsave = &hostmigration::callback_prehostmigrationsave;
    level.callbackbotentereduseredge = &bot::callback_botentereduseredge;
    level.callbackbotcreateplayerbot = &bot::function_3894691d;
    level.callbackbotshutdown = &bot::function_8747b717;
    level.var_d280b204 = &deployable::function_1d161d95;
    level.var_8a4a1aa6 = &deployable::function_97fb14cf;
    level.var_b6c73b45 = &deployable::function_d403fc64;
    level._custom_weapon_damage_func = &callback_weapon_damage;
    level._gametype_default = "tdm";
}

