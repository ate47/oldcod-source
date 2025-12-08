#using scripts\core_common\callbacks_shared;
#using scripts\core_common\globallogic\globallogic_vehicle;
#using scripts\core_common\system_shared;
#using scripts\cp_common\challenges;
#using scripts\cp_common\gametypes\globallogic;
#using scripts\cp_common\gametypes\globallogic_actor;
#using scripts\cp_common\gametypes\globallogic_player;
#using scripts\cp_common\gametypes\globallogic_scriptmover;
#using scripts\weapons\deployable;

#namespace callback;

// Namespace callback/callbacks
// Params 0, eflags: 0x6
// Checksum 0x9b418156, Offset: 0xb0
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"callback", &preinit, undefined, undefined, undefined );
}

// Namespace callback/callbacks
// Params 0, eflags: 0x4
// Checksum 0x51394103, Offset: 0xf8
// Size: 0x14
function private preinit()
{
    set_default_callbacks();
}

// Namespace callback/callbacks
// Params 2
// Checksum 0x8a6a6883, Offset: 0x118
// Size: 0x3c
function function_8a0395cd( func, obj )
{
    function_d8abfc3d( #"hash_31c83c1c404a846b", func, obj );
}

// Namespace callback/callbacks
// Params 2
// Checksum 0xac49ce47, Offset: 0x160
// Size: 0x3c
function function_b9e4759f( func, obj )
{
    function_52ac9652( #"hash_31c83c1c404a846b", func, obj );
}

// Namespace callback/event_bcae220e
// Params 1, eflags: 0x40
// Checksum 0x8aa91281, Offset: 0x1a8
// Size: 0x2c
function event_handler[event_bcae220e] function_980de2d1( eventstruct )
{
    self callback( #"hash_31c83c1c404a846b", eventstruct );
}

// Namespace callback/callbacks
// Params 0
// Checksum 0x7b1c4c8c, Offset: 0x1e0
// Size: 0x20c
function set_default_callbacks()
{
    level.callbackstartgametype = &globallogic::callback_startgametype;
    level.callbackplayerconnect = &globallogic_player::callback_playerconnect;
    level.callbackplayerdisconnect = &globallogic_player::callback_playerdisconnect;
    level.callbackplayerdamage = &globallogic_player::callback_playerdamage;
    level.callbackplayerkilled = &globallogic_player::callback_playerkilled;
    level.callbackplayershielddamageblocked = &globallogic_player::callback_playershielddamageblocked;
    level.var_3a9881cb = &globallogic_player::function_74b6d714;
    level.callbackplayermelee = &globallogic_player::callback_playermelee;
    level.callbackactorspawned = &globallogic_actor::callback_actorspawned;
    level.callbackactordamage = &globallogic_actor::callback_actordamage;
    level.callbackactorkilled = &globallogic_actor::callback_actorkilled;
    level.callbackactorcloned = &globallogic_actor::callback_actorcloned;
    level.var_6788bf11 = &globallogic_scriptmover::function_8c7ec52f;
    level.callbackvehiclespawned = &globallogic_vehicle::callback_vehiclespawned;
    level.callbackvehicledamage = &globallogic_vehicle::callback_vehicledamage;
    level.callbackvehiclekilled = &globallogic_vehicle::callback_vehiclekilled;
    level.callbackvehicleradiusdamage = &globallogic_vehicle::callback_vehicleradiusdamage;
    level.callbackplayermigrated = &globallogic_player::callback_playermigrated;
    level.callbackdecorationawarded = &challenges::function_f901cb3c;
    level.var_69959686 = &deployable::function_209fda28;
    level._custom_weapon_damage_func = &callback_weapon_damage;
    level._gametype_default = "coop";
}

