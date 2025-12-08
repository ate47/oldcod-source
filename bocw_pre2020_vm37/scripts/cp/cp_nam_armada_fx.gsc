#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\util;

#namespace namespace_9a981837;

// Namespace namespace_9a981837/cp_nam_armada_fx
// Params 0
// Checksum 0x4d546e7, Offset: 0x3d0
// Size: 0x154
function function_c44464c8()
{
    clientfield::register( "toplayer", "pstfx_sprite_rain_loop", 1, 1, "int" );
    clientfield::register( "toplayer", "pstfx_slowed", 1, 1, "int" );
    clientfield::register( "toplayer", "pstfx_vignette", 1, 1, "int" );
    clientfield::register( "vehicle", "firebase_smoke_fx", 1, 1, "int" );
    clientfield::register( "vehicle", "bamboo_heli_landing_rain_fx", 1, 1, "int" );
    clientfield::register( "toplayer", "postfx_bundle_explosive_damage", 1, 1, "int" );
    clientfield::register( "toplayer", "forest_pbg_switch", 1, 1, "int" );
}

// Namespace namespace_9a981837/cp_nam_armada_fx
// Params 0
// Checksum 0x937366ad, Offset: 0x530
// Size: 0x1ac
function init_fx()
{
    thread function_8cc931ef();
    thread function_4de82ed();
    thread function_d54bb61();
    level._effect[ #"hash_75a6e0287f64b467" ] = #"hash_b6ab7aa2e4af0ce";
    level._effect[ #"hash_1d9204870892bf9c" ] = #"hash_3d58577d8964749b";
    level._effect[ #"hash_7e6d961e2c87c2c9" ] = #"hash_1195c44b2991b9e";
    level._effect[ #"hash_430013754d2d4603" ] = #"hash_5cad1a1b9fdc43ee";
    thread exploder::exploder( "fx_firebase_smoke_fire" );
    thread exploder::exploder( "fx_bamboo_orbit_pillar" );
    thread exploder::kill_exploder( "fx_bamboo_close_pillar" );
    thread exploder::kill_exploder( "fx_bamboo_exfil_downdraft" );
    thread exploder::kill_exploder( "fx_firebase_nukeretrieve" );
    thread exploder::kill_exploder( "fx_firebase_nukeretrieve_downdraft" );
    thread exploder::exploder( "firebase_landing_kill" );
    thread exploder::exploder( "firebase_rear_kill" );
    thread exploder::exploder( "firebase_front_kill" );
}

// Namespace namespace_9a981837/cp_nam_armada_fx
// Params 0
// Checksum 0xaa9558f9, Offset: 0x6e8
// Size: 0x44
function function_82a143d2()
{
    playfx( level._effect[ #"hash_7e6d961e2c87c2c9" ], self.origin + ( 0, 0, -150 ) );
}

// Namespace namespace_9a981837/cp_nam_armada_fx
// Params 0
// Checksum 0x2537aa10, Offset: 0x738
// Size: 0xbc
function function_d54bb61()
{
    level flag::wait_till( "all_players_spawned" );
    getplayers()[ 0 ] endon( #"death" );
    level waittill( #"hash_7bfe2feb57babd0b" );
    level.player clientfield::set_to_player( "postfx_bundle_explosive_damage", 1 );
    level waittill( #"hash_291826dce45def2d" );
    level.player clientfield::set_to_player( "postfx_bundle_explosive_damage", 0 );
}

// Namespace namespace_9a981837/cp_nam_armada_fx
// Params 0
// Checksum 0x518c2c7d, Offset: 0x800
// Size: 0xc8
function function_8cc931ef()
{
    while ( !isdefined( level.var_7466d419 ) )
    {
        waitframe( 1 );
    }
    
    var_565e7b99 = getentarray( "orbit_smoke_trigger", "targetname" );
    
    foreach ( trig in var_565e7b99 )
    {
        trig thread function_29d53e24();
    }
}

// Namespace namespace_9a981837/cp_nam_armada_fx
// Params 0
// Checksum 0x5970787c, Offset: 0x8d0
// Size: 0xfa
function function_29d53e24()
{
    while ( true )
    {
        waitresult = self waittill( #"trigger" );
        
        if ( isdefined( waitresult ) && isdefined( waitresult.activator ) && waitresult.activator == level.var_7466d419 )
        {
            level flag::set( "flag_firebase_smoke_fx" );
            waitresult.activator clientfield::set( "firebase_smoke_fx", 1 );
            level flag::wait_till_clear( "flag_firebase_smoke_fx" );
            waitresult.activator clientfield::set( "firebase_smoke_fx", 0 );
            continue;
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_9a981837/cp_nam_armada_fx
// Params 0
// Checksum 0x80bfe4ed, Offset: 0x9d8
// Size: 0xf0
function function_4de82ed()
{
    while ( !( isdefined( level.var_7466d419 ) && isdefined( level.player ) ) )
    {
        waitframe( 1 );
    }
    
    level.player endon( #"death" );
    level.var_7466d419 endon( #"death" );
    
    while ( true )
    {
        level flag::wait_till( "flag_bamboo_heli_landing_rain_fx" );
        level.var_7466d419 clientfield::set( "bamboo_heli_landing_rain_fx", 1 );
        level flag::wait_till_clear( "flag_bamboo_heli_landing_rain_fx" );
        level.var_7466d419 clientfield::set( "bamboo_heli_landing_rain_fx", 0 );
    }
}

// Namespace namespace_9a981837/cp_nam_armada_fx
// Params 0
// Checksum 0x8475b093, Offset: 0xad0
// Size: 0x50
function function_121aeba5()
{
    while ( true )
    {
        wait 80;
        exploder::exploder( "Flying_ocean" );
        wait 91.5;
        exploder::exploder( "Flying_ambience" );
    }
}

// Namespace namespace_9a981837/cp_nam_armada_fx
// Params 0
// Checksum 0x78fac5f0, Offset: 0xb28
// Size: 0xe4
function function_62dae110()
{
    level.player endon( #"death" );
    level.var_7466d419 endon( #"death" );
    level waittill( #"hash_7a85fc4b002ec719" );
    playfxontag( level._effect[ #"hash_75a6e0287f64b467" ], level.var_7466d419, "tag_attach" );
    level.player clientfield::set_to_player( "pstfx_sprite_rain_loop", 1 );
    level waittill( #"hash_2d8371713a24b057" );
    level.player clientfield::set_to_player( "pstfx_sprite_rain_loop", 0 );
}

// Namespace namespace_9a981837/cp_nam_armada_fx
// Params 0
// Checksum 0x6610022d, Offset: 0xc18
// Size: 0x1c
function function_2fa3ab91()
{
    exploder::exploder( "bamboo_hurricane_blades" );
}

// Namespace namespace_9a981837/cp_nam_armada_fx
// Params 0
// Checksum 0x43febf52, Offset: 0xc40
// Size: 0x24
function function_fc65375a()
{
    wait 30;
    exploder::exploder( "bamboo_hurricane_ground" );
}

// Namespace namespace_9a981837/cp_nam_armada_fx
// Params 0
// Checksum 0xda1ea174, Offset: 0xc70
// Size: 0x1e
function pstfx_vignette()
{
    level.player endon( #"death" );
}

// Namespace namespace_9a981837/cp_nam_armada_fx
// Params 0
// Checksum 0x3dda5caa, Offset: 0xc98
// Size: 0x84
function intro_dof()
{
    level flag::wait_till( "flag_vo_gearup_reach_chopper" );
    level.vip endon( #"death" );
    level.player endon( #"death" );
    self endon( #"death" );
    level flag::wait_till( "flag_vo_chopper_chatter_2" );
}

// Namespace namespace_9a981837/cp_nam_armada_fx
// Params 0
// Checksum 0x1c582129, Offset: 0xd28
// Size: 0x27c
function function_ee673d3d()
{
    self endon( #"death" );
    level notify( #"hash_1849624165c8255f" );
    level.var_7466d419.var_6bbdd0a5 = spawn( "script_model", level.var_7466d419.origin );
    level.var_7466d419.var_6bbdd0a5 setmodel( #"tag_origin" );
    level.var_7466d419.var_6bbdd0a5 enablelinkto();
    level.var_7466d419.var_6bbdd0a5 linkto( level.var_7466d419, "tag_fire_extinguisher_attach", ( 0, 0, 35 ), ( 90, 0, 0 ) );
    level.var_7466d419.var_585ee020 = #"hash_7401be881ac98bd9";
    level waittill( #"hash_227cc8ce5802e6b5" );
    level.var_7466d419.var_6bbdd0a5 delete();
    level waittill( #"hash_1849624165c8255f" );
    level.var_7466d419.var_6bbdd0a5 = spawn( "script_model", level.var_7466d419.origin );
    level.var_7466d419.var_6bbdd0a5 setmodel( #"tag_origin" );
    level.var_7466d419.var_6bbdd0a5 enablelinkto();
    level.var_7466d419.var_6bbdd0a5 linkto( level.var_7466d419, "tag_fire_extinguisher_attach", ( 0, 0, 35 ), ( 90, 0, 0 ) );
    playfxontag( level.var_7466d419.var_585ee020, level.var_7466d419.var_6bbdd0a5, "tag_origin" );
}

// Namespace namespace_9a981837/cp_nam_armada_fx
// Params 1
// Checksum 0x8233e7f4, Offset: 0xfb0
// Size: 0x1c
function function_fcea30b4( *var_c38706bb )
{
    thread function_bffbd256();
}

// Namespace namespace_9a981837/cp_nam_armada_fx
// Params 0
// Checksum 0xda53ac77, Offset: 0xfd8
// Size: 0x54
function function_bffbd256()
{
    level.player setnosunshadow();
    level flag::wait_till( "flag_vo_chopper_chatter_2" );
    level.player removenosunshadow();
}

// Namespace namespace_9a981837/cp_nam_armada_fx
// Params 1
// Checksum 0xa94a3840, Offset: 0x1038
// Size: 0x1a4
function function_a9a0debb( params )
{
    if ( isarray( params ) )
    {
    }
    else
    {
        args = strtok( params, "," );
        
        foreach ( arg in args )
        {
            var_102cf4ae = strtok( arg, "=" );
            
            switch ( var_102cf4ae[ 0 ] )
            {
                case #"f_fstop":
                    f_fstop = float( var_102cf4ae[ 1 ] );
                    break;
                case #"f_fstop_time":
                    f_fstop_time = float( var_102cf4ae[ 1 ] );
                    break;
            }
        }
    }
    
    if ( !isdefined( f_fstop ) )
    {
        f_fstop = 108;
    }
    
    if ( !isdefined( f_fstop_time ) )
    {
        freqpitch = 1;
    }
    
    thread auto_dof( f_fstop, f_fstop_time );
}

// Namespace namespace_9a981837/cp_nam_armada_fx
// Params 2
// Checksum 0xa65f1d14, Offset: 0x11e8
// Size: 0x6c
function auto_dof( f_fstop, f_fstop_time )
{
    if ( isdefined( level.player ) )
    {
        level.player thread fx::function_82104e32( f_fstop, f_fstop_time );
        return;
    }
    
    wait 1;
    level.player thread fx::function_82104e32( f_fstop, f_fstop_time );
}

// Namespace namespace_9a981837/cp_nam_armada_fx
// Params 0
// Checksum 0xec54630a, Offset: 0x1260
// Size: 0x24
function function_7e002ff8()
{
    level.player flag::clear( "flag_autofocus_on" );
}

// Namespace namespace_9a981837/cp_nam_armada_fx
// Params 1
// Checksum 0xa09c86c0, Offset: 0x1290
// Size: 0x54
function function_633130e5( a_ents )
{
    level.player thread fx::lighting_target_dof( a_ents[ 0 ], 0.025, 0.05 );
    wait 7;
    thread function_7e002ff8();
}

// Namespace namespace_9a981837/cp_nam_armada_fx
// Params 0
// Checksum 0xd3ac37cf, Offset: 0x12f0
// Size: 0x2c
function function_5c261946()
{
    setdvar( #"r_dofmode", 1 );
}

// Namespace namespace_9a981837/cp_nam_armada_fx
// Params 0
// Checksum 0xc928f422, Offset: 0x1328
// Size: 0x44
function forest_pbg_switch()
{
    level.player endon( #"death" );
    level.player clientfield::set_to_player( "forest_pbg_switch", 1 );
}

// Namespace namespace_9a981837/cp_nam_armada_fx
// Params 0
// Checksum 0x18a0ff7d, Offset: 0x1378
// Size: 0x44
function function_3f0940c0()
{
    level.player endon( #"death" );
    level.player clientfield::set_to_player( "forest_pbg_switch", 0 );
}

