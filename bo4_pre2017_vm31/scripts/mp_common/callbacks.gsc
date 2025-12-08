#using scripts/core_common/ai/systems/blackboard;
#using scripts/core_common/audio_shared;
#using scripts/core_common/bots/bot;
#using scripts/core_common/bots/bot_traversals;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/globallogic/globallogic_vehicle;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/mp_common/gametypes/globallogic;
#using scripts/mp_common/gametypes/globallogic_actor;
#using scripts/mp_common/gametypes/globallogic_player;
#using scripts/mp_common/gametypes/hostmigration;

#namespace callback;

// Namespace callback/callbacks
// Params 0, eflags: 0x2
// Checksum 0x667f0076, Offset: 0x290
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "callback", &__init__, undefined, undefined );
}

// Namespace callback/callbacks
// Params 0
// Checksum 0x50b3353c, Offset: 0x2d0
// Size: 0x14
function __init__()
{
    set_default_callbacks();
}

// Namespace callback/callbacks
// Params 0
// Checksum 0x59f2fee0, Offset: 0x2f0
// Size: 0x244
function set_default_callbacks()
{
    level.callbackstartgametype = &globallogic::callback_startgametype;
    level.callbackplayerconnect = &globallogic_player::callback_playerconnect;
    level.callbackplayerdisconnect = &globallogic_player::callback_playerdisconnect;
    level.callbackplayerdamage = &globallogic_player::callback_playerdamage;
    level.callbackplayerkilled = &globallogic_player::callback_playerkilled;
    level.callbackplayermelee = &globallogic_player::callback_playermelee;
    level.callbackplayerlaststand = &globallogic_player::callback_playerlaststand;
    level.callbackactorspawned = &globallogic_actor::callback_actorspawned;
    level.callbackactordamage = &globallogic_actor::callback_actordamage;
    level.callbackactorkilled = &globallogic_actor::callback_actorkilled;
    level.callbackactorcloned = &globallogic_actor::callback_actorcloned;
    level.callbackvehiclespawned = &globallogic_vehicle::callback_vehiclespawned;
    level.callbackvehicledamage = &globallogic_vehicle::callback_vehicledamage;
    level.callbackvehiclekilled = &globallogic_vehicle::callback_vehiclekilled;
    level.callbackvehicleradiusdamage = &globallogic_vehicle::callback_vehicleradiusdamage;
    level.callbackplayermigrated = &globallogic_player::callback_playermigrated;
    level.callbackhostmigration = &hostmigration::callback_hostmigration;
    level.callbackhostmigrationsave = &hostmigration::callback_hostmigrationsave;
    level.callbackprehostmigrationsave = &hostmigration::callback_prehostmigrationsave;
    level.callbackbotentereduseredge = &bot::callback_botentereduseredge;
    level.callbackbotcreateplayerbot = &bot::callback_createplayerbot;
    level.callbackbotshutdown = &bot::callback_stopupdate;
    level._custom_weapon_damage_func = &callback_weapon_damage;
    level._gametype_default = "tdm";
}

