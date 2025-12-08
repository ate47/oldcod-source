#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/archetype_shared/archetype_shared;
#using scripts/core_common/audio_shared;
#using scripts/core_common/burnplayer;
#using scripts/core_common/clientfaceanim_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/footsteps_shared;
#using scripts/core_common/load_shared;
#using scripts/core_common/music_shared;
#using scripts/core_common/oob;
#using scripts/core_common/player_shared;
#using scripts/core_common/postfx_shared;
#using scripts/core_common/scene_shared;
#using scripts/core_common/status_effects/status_effects;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/turret_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/vehicle_shared;
#using scripts/core_common/weapons/bouncingbetty;
#using scripts/core_common/weapons/grapple;
#using scripts/core_common/weapons/gravity_spikes;
#using scripts/core_common/weapons/hive_gun;
#using scripts/core_common/weapons/lightninggun;
#using scripts/core_common/weapons/multilockapguidance;
#using scripts/core_common/weapons/pineapple_gun;
#using scripts/core_common/weapons/proximity_grenade;
#using scripts/core_common/weapons/riotshield;
#using scripts/core_common/weapons/satchel_charge;
#using scripts/core_common/weapons/sensor_arrow;
#using scripts/core_common/weapons/spike_charge;
#using scripts/core_common/weapons/sticky_grenade;
#using scripts/core_common/weapons/tacticalinsertion;
#using scripts/core_common/weapons/trophy_system;
#using scripts/core_common/weapons/weaponobjects;
#using scripts/mp_common/abilities/abilities;
#using scripts/mp_common/ambient;
#using scripts/mp_common/bouncingbetty;
#using scripts/mp_common/callbacks;
#using scripts/mp_common/claymore;
#using scripts/mp_common/decoy;
#using scripts/mp_common/destructible;
#using scripts/mp_common/draft;
#using scripts/mp_common/end_game_flow;
#using scripts/mp_common/explosive_bolt;
#using scripts/mp_common/flashgrenades;
#using scripts/mp_common/gametypes/classicmode;
#using scripts/mp_common/gametypes/weaponobjects;
#using scripts/mp_common/global_fx;
#using scripts/mp_common/hacker_tool;
#using scripts/mp_common/helicopter_sounds;
#using scripts/mp_common/hive_gun;
#using scripts/mp_common/killstreaks/ammo_station;
#using scripts/mp_common/killstreaks/armor_station;
#using scripts/mp_common/killstreaks/counteruav;
#using scripts/mp_common/killstreaks/dart;
#using scripts/mp_common/killstreaks/emp;
#using scripts/mp_common/killstreaks/flak_drone;
#using scripts/mp_common/killstreaks/helicopter;
#using scripts/mp_common/killstreaks/helicopter_gunner;
#using scripts/mp_common/killstreaks/killstreak_detect;
#using scripts/mp_common/killstreaks/microwave_turret;
#using scripts/mp_common/killstreaks/mini_turret;
#using scripts/mp_common/killstreaks/planemortar;
#using scripts/mp_common/killstreaks/raps;
#using scripts/mp_common/killstreaks/remotemissile;
#using scripts/mp_common/killstreaks/turret;
#using scripts/mp_common/lightninggun;
#using scripts/mp_common/mpdialog;
#using scripts/mp_common/multi_extracam;
#using scripts/mp_common/perks;
#using scripts/mp_common/proximity_grenade;
#using scripts/mp_common/radiant_live_update;
#using scripts/mp_common/rewindobjects;
#using scripts/mp_common/riotshield;
#using scripts/mp_common/rotating_object;
#using scripts/mp_common/satchel_charge;
#using scripts/mp_common/spawnbeacon;
#using scripts/mp_common/tacticalinsertion;
#using scripts/mp_common/threat_detector;
#using scripts/mp_common/trophy_system;
#using scripts/mp_common/userspawnselection;
#using scripts/mp_common/util;
#using scripts/mp_common/vehicle;

#namespace load;

// Namespace load/load
// Params 3
// Checksum 0x759efcc8, Offset: 0xe30
// Size: 0x46
function levelnotifyhandler( clientnum, state, oldstate )
{
    if ( state != "" )
    {
        level notify( state, { #localclientnum:clientnum } );
    }
}

// Namespace load/load
// Params 0
// Checksum 0x9defbc2b, Offset: 0xe80
// Size: 0xfc
function main()
{
    assert( isdefined( level.first_frame ), "There should be no waits before load::main." );
    level thread util::servertime();
    level thread util::init_utility();
    util::registersystem( "levelNotify", &levelnotifyhandler );
    register_clientfields();
    level.createfx_disable_fx = getdvarint( "disable_fx" ) == 1;
    system::wait_till( "all" );
    level flagsys::set( "load_main_complete" );
}

// Namespace load/load
// Params 0
// Checksum 0x87e716f0, Offset: 0xf88
// Size: 0xdc
function register_clientfields()
{
    clientfield::register( "missile", "cf_m_proximity", 1, 1, "int", &callback::callback_proximity, 0, 0 );
    clientfield::register( "missile", "cf_m_emp", 1, 1, "int", &callback::callback_emp, 0, 0 );
    clientfield::register( "missile", "cf_m_stun", 1, 1, "int", &callback::callback_stunned, 0, 0 );
}

