#using script_498cf7685befe7bf;
#using script_77f51076c7c89596;
#using scripts\core_common\array_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\struct;
#using scripts\core_common\turret_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicleriders_shared;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\util;

#namespace fav;

// Namespace fav/namespace_e8e5d007
// Params 0
// Checksum 0x2cc81f59, Offset: 0x168
// Size: 0x34
function init()
{
    function_714074a0();
    function_ae7ec56a();
    function_3204d0a4();
}

// Namespace fav/namespace_e8e5d007
// Params 0
// Checksum 0xca29a19c, Offset: 0x1a8
// Size: 0x12c
function function_714074a0()
{
    while ( !isdefined( level.var_77be18d2 ) )
    {
        waitframe( 1 );
    }
    
    level.var_77be18d2 setteam( "allies" );
    level.var_77be18d2 val::set( #"intro", "takedamage", 0 );
    waitframe( 2 );
    level.var_77be18d2 turret::_init_turret( 2 );
    level.var_77be18d2 turret::_init_turret( 3 );
    level.var_77be18d2 turret::enable( 2 );
    level.var_77be18d2 turret::enable( 3 );
    level.var_77be18d2 vehicle::lights_on();
    level thread function_880b83fd( "flg_exit_fav" );
}

// Namespace fav/namespace_e8e5d007
// Params 0
// Checksum 0x64b9bc8a, Offset: 0x2e0
// Size: 0x64
function function_ae7ec56a()
{
    while ( !isdefined( level.var_7b278a4f ) || !isdefined( level.var_5d798cf2 ) )
    {
        waitframe( 1 );
    }
    
    level.var_7b278a4f function_eebd1c52();
    level.var_5d798cf2 function_eebd1c52();
}

// Namespace fav/namespace_e8e5d007
// Params 0
// Checksum 0x8609cd21, Offset: 0x350
// Size: 0xc4
function function_eebd1c52()
{
    self.overridevehicledamage = &damage_override;
    self turret::_init_turret( 1 );
    self turret::_init_turret( 2 );
    self turret::_init_turret( 3 );
    self turret::enable( 1 );
    self turret::enable( 2 );
    self turret::enable( 3 );
    self vehicle::lights_on();
}

// Namespace fav/namespace_e8e5d007
// Params 0
// Checksum 0x6df5794b, Offset: 0x420
// Size: 0x22c
function function_3204d0a4()
{
    var_8e4bb68e = spawn( "script_origin", level.var_77be18d2.origin + anglestoforward( level.var_77be18d2.angles ) * -10 );
    var_8e4bb68e.angles = level.var_77be18d2.angles;
    var_8e4bb68e linkto( level.var_77be18d2 );
    level.player setplayerangles( ( level.var_77be18d2.angles[ 0 ], -40, level.var_77be18d2.angles[ 2 ] ) );
    level.player playerlinktodelta( level.var_77be18d2, "tag_passenger1", 0, 60, 60, 80, 20, 1 );
    level.player val::set( #"intro", "allow_crouch", 0 );
    level.player val::set( #"intro", "allow_prone", 0 );
    level.adler vehicle::get_in( level.adler, level.var_77be18d2, "gunner1" );
    level.woods vehicle::get_in( level.woods, level.var_5d798cf2, "gunner1" );
    level.mason vehicle::get_in( level.mason, level.var_5d798cf2, "passenger1" );
    level thread function_a73b8839();
}

// Namespace fav/namespace_e8e5d007
// Params 15
// Checksum 0xfb218527, Offset: 0x658
// Size: 0x80, Type: bool
function damage_override( *einflictor, *eattacker, *idamage, *idflags, *smeansofdeath, *weapon, *vpoint, *vdir, *shitloc, *vdamageorigin, *psoffsettime, *damagefromunderneath, *modelindex, *partname, *vsurfacenormal )
{
    return true;
}

// Namespace fav/namespace_e8e5d007
// Params 2
// Checksum 0xb47f78d6, Offset: 0x6e0
// Size: 0x6c
function enter( vh, n_seat )
{
    while ( !isdefined( vh ) )
    {
        waitframe( 1 );
    }
    
    vh makevehicleusable();
    vh usevehicle( self, n_seat );
    vh makevehicleunusable();
}

// Namespace fav/namespace_e8e5d007
// Params 0
// Checksum 0xb81adfb2, Offset: 0x758
// Size: 0x1a8
function function_a73b8839()
{
    level waittill( #"hash_465d6bb5960c37f8" );
    var_3e3877e9 = getaiteamarray( "allies" );
    arrayremovevalue( var_3e3877e9, level.adler );
    arrayremovevalue( var_3e3877e9, level.mason );
    
    foreach ( ai in var_3e3877e9 )
    {
        if ( isvehicle( ai ) )
        {
            arrayremovevalue( var_3e3877e9, ai );
        }
    }
    
    foreach ( ai in var_3e3877e9 )
    {
        ai val::reset( #"intro", "takedamage" );
    }
}

// Namespace fav/namespace_e8e5d007
// Params 1
// Checksum 0xdc924afa, Offset: 0x908
// Size: 0x1bc
function function_880b83fd( flg_exit_fav )
{
    level waittill( flg_exit_fav );
    level.player namespace_534279a::function_6e9256df();
    level.player namespace_534279a::function_a3c3a2b0();
    level.var_77be18d2 makevehicleusable();
    level.var_77be18d2 usevehicle( level.player, 5 );
    level.var_77be18d2 usevehicle( level.player, 5 );
    level.var_77be18d2 makevehicleunusable();
    level.player val::reset( #"intro", "allow_crouch" );
    level.player val::reset( #"intro", "allow_prone" );
    level.player enableweaponcycling();
    s_player_fav_exit_loc = struct::get( "s_player_fav_exit_loc" );
    level.player setorigin( s_player_fav_exit_loc.origin );
    level.player setplayerangles( s_player_fav_exit_loc.angles );
    savegame::checkpoint_save();
}

