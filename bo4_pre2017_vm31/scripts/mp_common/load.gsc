#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/archetype_shared/archetype_shared;
#using scripts/core_common/audio_shared;
#using scripts/core_common/burnplayer;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/demo_shared;
#using scripts/core_common/entityheadicons_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/hostmigration_shared;
#using scripts/core_common/load_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/medals_shared;
#using scripts/core_common/music_shared;
#using scripts/core_common/oob;
#using scripts/core_common/player_shared;
#using scripts/core_common/popups_shared;
#using scripts/core_common/scene_shared;
#using scripts/core_common/serverfaceanim_shared;
#using scripts/core_common/spawning_shared;
#using scripts/core_common/status_effects/status_effects;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/turret_shared;
#using scripts/core_common/tweakables_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/vehicle_ai_shared;
#using scripts/core_common/weapons/ballistic_knife;
#using scripts/core_common/weapons/bouncingbetty;
#using scripts/core_common/weapons/flashgrenades;
#using scripts/core_common/weapons/grapple;
#using scripts/core_common/weapons/hive_gun;
#using scripts/core_common/weapons/lightninggun;
#using scripts/core_common/weapons/multilockapguidance;
#using scripts/core_common/weapons/pineapple_gun;
#using scripts/core_common/weapons/proximity_grenade;
#using scripts/core_common/weapons/riotshield;
#using scripts/core_common/weapons/satchel_charge;
#using scripts/core_common/weapons/sensor_arrow;
#using scripts/core_common/weapons/sensor_grenade;
#using scripts/core_common/weapons/sticky_grenade;
#using scripts/core_common/weapons/tacticalinsertion;
#using scripts/core_common/weapons/trophy_system;
#using scripts/core_common/weapons/weaponobjects;
#using scripts/mp_common/abilities/abilities;
#using scripts/mp_common/arena;
#using scripts/mp_common/armblade;
#using scripts/mp_common/art;
#using scripts/mp_common/ballistic_knife;
#using scripts/mp_common/bb;
#using scripts/mp_common/blackjack_challenges;
#using scripts/mp_common/bouncingbetty;
#using scripts/mp_common/callbacks;
#using scripts/mp_common/contracts;
#using scripts/mp_common/destructible;
#using scripts/mp_common/devgui;
#using scripts/mp_common/draft;
#using scripts/mp_common/explosive_bolt;
#using scripts/mp_common/flashgrenades;
#using scripts/mp_common/gametypes/classicmode;
#using scripts/mp_common/gametypes/globallogic_audio;
#using scripts/mp_common/hacker_tool;
#using scripts/mp_common/heatseekingmissile;
#using scripts/mp_common/hive_gun;
#using scripts/mp_common/incendiary;
#using scripts/mp_common/killstreaks/ai_tank;
#using scripts/mp_common/killstreaks/ammo_station;
#using scripts/mp_common/killstreaks/armor_station;
#using scripts/mp_common/killstreaks/counteruav;
#using scripts/mp_common/killstreaks/dogs;
#using scripts/mp_common/killstreaks/drone_strike;
#using scripts/mp_common/killstreaks/killstreak_detect;
#using scripts/mp_common/killstreaks/placeables;
#using scripts/mp_common/killstreaks/rcbomb;
#using scripts/mp_common/killstreaks/satellite;
#using scripts/mp_common/killstreaks/uav;
#using scripts/mp_common/lightninggun;
#using scripts/mp_common/load;
#using scripts/mp_common/perks;
#using scripts/mp_common/pickup_items;
#using scripts/mp_common/proximity_grenade;
#using scripts/mp_common/riotshield;
#using scripts/mp_common/satchel_charge;
#using scripts/mp_common/sensor_grenade;
#using scripts/mp_common/smokegrenade;
#using scripts/mp_common/spawnbeacon;
#using scripts/mp_common/sprint_boost_grenade;
#using scripts/mp_common/tacticalinsertion;
#using scripts/mp_common/teams/teamset_allies;
#using scripts/mp_common/teams/teamset_axis;
#using scripts/mp_common/threat_detector;
#using scripts/mp_common/trophy_system;
#using scripts/mp_common/userspawnselection;
#using scripts/mp_common/util;
#using scripts/mp_common/vehicle;

#namespace load;

// Namespace load/load
// Params 0
// Checksum 0x871be7db, Offset: 0x1070
// Size: 0x154
function main()
{
    assert( isdefined( level.first_frame ), "There should be no waits before load::main." );
    level._loadstarted = 1;
    
    /#
        util::check_art_mode();
    #/
    
    /#
        util::apply_dev_overrides();
    #/
    
    setclearanceceiling( 30 );
    register_clientfields();
    level.aitriggerspawnflags = getaitriggerflags();
    level.vehicletriggerspawnflags = getvehicletriggerflags();
    setup_traversals();
    level.globallogic_audio_dialog_on_player_override = &globallogic_audio::leader_dialog_on_player;
    level.growing_hitmarker = 1;
    system::wait_till( "all" );
    level flagsys::set( "load_main_complete" );
}

// Namespace load/load
// Params 2
// Checksum 0x2ed138a2, Offset: 0x11d0
// Size: 0xc2
function setfootstepeffect( name, fx )
{
    assert( isdefined( name ), "Need to define the footstep surface type." );
    assert( isdefined( fx ), "Need to define the mud footstep effect." );
    
    if ( !isdefined( anim.optionalstepeffects ) )
    {
        anim.optionalstepeffects = [];
    }
    
    anim.optionalstepeffects[ anim.optionalstepeffects.size ] = name;
    level._effect[ "step_" + name ] = fx;
}

// Namespace load/load
// Params 0
// Checksum 0x520febae, Offset: 0x12a0
// Size: 0x224
function footsteps()
{
    setfootstepeffect( "asphalt", "_t6/bio/player/fx_footstep_dust" );
    setfootstepeffect( "brick", "_t6/bio/player/fx_footstep_dust" );
    setfootstepeffect( "carpet", "_t6/bio/player/fx_footstep_dust" );
    setfootstepeffect( "cloth", "_t6/bio/player/fx_footstep_dust" );
    setfootstepeffect( "concrete", "_t6/bio/player/fx_footstep_dust" );
    setfootstepeffect( "dirt", "_t6/bio/player/fx_footstep_sand" );
    setfootstepeffect( "foliage", "_t6/bio/player/fx_footstep_sand" );
    setfootstepeffect( "gravel", "_t6/bio/player/fx_footstep_dust" );
    setfootstepeffect( "grass", "_t6/bio/player/fx_footstep_dust" );
    setfootstepeffect( "metal", "_t6/bio/player/fx_footstep_dust" );
    setfootstepeffect( "mud", "_t6/bio/player/fx_footstep_mud" );
    setfootstepeffect( "paper", "_t6/bio/player/fx_footstep_dust" );
    setfootstepeffect( "plaster", "_t6/bio/player/fx_footstep_dust" );
    setfootstepeffect( "rock", "_t6/bio/player/fx_footstep_dust" );
    setfootstepeffect( "sand", "_t6/bio/player/fx_footstep_sand" );
    setfootstepeffect( "water", "_t6/bio/player/fx_footstep_water" );
    setfootstepeffect( "wood", "_t6/bio/player/fx_footstep_dust" );
}

// Namespace load/load
// Params 0
// Checksum 0xa1b8d9b2, Offset: 0x14d0
// Size: 0xc0
function init_traverse()
{
    point = getent( self.target, "targetname" );
    
    if ( isdefined( point ) )
    {
        self.traverse_height = point.origin[ 2 ];
        point delete();
        return;
    }
    
    point = struct::get( self.target, "targetname" );
    
    if ( isdefined( point ) )
    {
        self.traverse_height = point.origin[ 2 ];
    }
}

// Namespace load/load
// Params 0
// Checksum 0xe822fb4f, Offset: 0x1598
// Size: 0x96
function setup_traversals()
{
    potential_traverse_nodes = getallnodes();
    
    for ( i = 0; i < potential_traverse_nodes.size ; i++ )
    {
        node = potential_traverse_nodes[ i ];
        
        if ( node.type == "Begin" )
        {
            node init_traverse();
        }
    }
}

// Namespace load/load
// Params 0
// Checksum 0x1277ff91, Offset: 0x1638
// Size: 0x94
function register_clientfields()
{
    clientfield::register( "missile", "cf_m_proximity", 1, 1, "int" );
    clientfield::register( "missile", "cf_m_emp", 1, 1, "int" );
    clientfield::register( "missile", "cf_m_stun", 1, 1, "int" );
}

