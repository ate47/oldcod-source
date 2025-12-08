#using script_37f9ff47f340fbe8;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\serverfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\util;

#namespace parabolic_mic;

// Namespace parabolic_mic/parabolic_mic
// Params 0, eflags: 0x6
// Checksum 0xf5759768, Offset: 0x1a0
// Size: 0x34
function private autoexec __init__system__()
{
    system::register( "parabolic_mic", &preinit, undefined, undefined, undefined );
}

// Namespace parabolic_mic/parabolic_mic
// Params 0, eflags: 0x4
// Checksum 0xaddc5351, Offset: 0x1e0
// Size: 0x16c
function private preinit()
{
    callback::on_weapon_change( &on_weapon_change );
    var_1e935eba = array( "scriptmover" );
    
    foreach ( str_type in var_1e935eba )
    {
        clientfield::register( str_type, "parabolic_mic_volume_scale", 1, 5, "float" );
    }
    
    clientfield::register_clientuimodel( "hudItems.ParabolicMic.active", 1, 1, "int" );
    level.parabolic_mic = spawnstruct();
    level.parabolic_mic.weapon = getweapon( "eq_parabolic_mic" );
    
    /#
        function_5ac4dc99( "<dev string:x38>", 0 );
    #/
}

// Namespace parabolic_mic/parabolic_mic
// Params 1
// Checksum 0x6527ad2a, Offset: 0x358
// Size: 0x33a
function init( var_e00524ce )
{
    level.parabolic_mic.trace = undefined;
    thread init_static();
    level.parabolic_mic.static_alias = var_e00524ce;
    level.parabolic_mic.sounds = [];
    level.parabolic_mic.viewents = [];
    level.parabolic_mic.volumes = getentarray( "listening_device_volume", "targetname" );
    
    foreach ( volume in level.parabolic_mic.volumes )
    {
        volume.is_volume = 1;
        volume.var_62a70840 = 0;
    }
    
    a_structs = struct::get_array( "listening_device_targets", "targetname" );
    a_ents = getentarray( "listening_device_targets", "targetname" );
    level.parabolic_mic.points = arraycombine( a_structs, a_ents );
    
    foreach ( point in level.parabolic_mic.points )
    {
        point.var_62a70840 = 0;
    }
    
    level.parabolic_mic.ai = [];
    a_ai = getaiarray();
    
    foreach ( ai in a_ai )
    {
        if ( isalive( ai ) && isdefined( ai.listening_func ) )
        {
            level.parabolic_mic.ai[ level.parabolic_mic.ai.size ] = ai;
            ai.var_62a70840 = 0;
        }
    }
    
    level.parabolic_mic.funcs = [];
}

// Namespace parabolic_mic/parabolic_mic
// Params 0
// Checksum 0x5c9f71b5, Offset: 0x6a0
// Size: 0x2c
function function_765c50e5()
{
    self giveweapon( level.parabolic_mic.weapon );
}

// Namespace parabolic_mic/parabolic_mic
// Params 0
// Checksum 0x1f7088f9, Offset: 0x6d8
// Size: 0x3c
function function_f0404f70()
{
    self takeweapon( level.parabolic_mic.weapon );
    cleanup();
}

// Namespace parabolic_mic/parabolic_mic
// Params 0
// Checksum 0xd33c6298, Offset: 0x720
// Size: 0x96
function cleanup()
{
    level notify( #"end_parabolic_mic" );
    
    if ( isdefined( level.parabolic_mic.static ) )
    {
        level.parabolic_mic.static delete();
    }
    
    if ( isdefined( level.parabolic_mic.volumes ) )
    {
        array::delete_all( level.parabolic_mic.volumes );
    }
    
    level.parabolic_mic = undefined;
}

// Namespace parabolic_mic/parabolic_mic
// Params 1, eflags: 0x4
// Checksum 0x848e6f89, Offset: 0x7c0
// Size: 0x64
function private on_weapon_change( params )
{
    if ( params.weapon === level.parabolic_mic.weapon )
    {
        self thread function_8ca53cc6( params.weapon );
        return;
    }
    
    self thread function_af74deb4();
}

// Namespace parabolic_mic/parabolic_mic
// Params 0, eflags: 0x4
// Checksum 0xdb533a5c, Offset: 0x830
// Size: 0x74
function private function_af74deb4()
{
    self notify( #"hash_68632710a76257a1" );
    self clientfield::set_player_uimodel( "hudItems.ParabolicMic.active", 0 );
    self stop_static();
    
    if ( isdefined( level.parabolic_mic ) )
    {
        level.parabolic_mic function_5cc7f362();
    }
}

// Namespace parabolic_mic/parabolic_mic
// Params 1, eflags: 0x4
// Checksum 0x1845d480, Offset: 0x8b0
// Size: 0x1a6
function private function_8ca53cc6( *weapon )
{
    self endon( #"death", #"hash_68632710a76257a1" );
    level endon( #"end_parabolic_mic" );
    
    /#
        function_5ac4dc99( "<dev string:x4f>", 0 );
    #/
    
    was_ads = 0;
    self play_static();
    
    while ( true )
    {
        waitframe( 1 );
        
        if ( self playerads() > 0.75 )
        {
            self clientfield::set_player_uimodel( "hudItems.ParabolicMic.active", 1 );
            self trace();
            self function_c5979d91();
            
            if ( !was_ads )
            {
                self val::set( "parabolic_mic", "show_hud", 0 );
            }
            
            was_ads = 1;
            continue;
        }
        
        if ( was_ads )
        {
            self clientfield::set_player_uimodel( "hudItems.ParabolicMic.active", 0 );
            self function_5cc7f362();
            self val::reset( "parabolic_mic", "show_hud" );
            was_ads = 0;
        }
    }
}

// Namespace parabolic_mic/parabolic_mic
// Params 0, eflags: 0x4
// Checksum 0x33e375c7, Offset: 0xa60
// Size: 0xe4
function private init_static()
{
    if ( isdefined( level.parabolic_mic.static ) )
    {
        level.parabolic_mic.static delete();
    }
    
    ent = util::spawn_model( "tag_origin", ( 0, 0, 0 ) );
    ent.volumescale = 0.1;
    level.parabolic_mic.static = ent;
    util::wait_network_frame( 1 );
    level.parabolic_mic.static clientfield::set( "parabolic_mic_volume_scale", level.parabolic_mic.static.volumescale );
}

// Namespace parabolic_mic/parabolic_mic
// Params 0, eflags: 0x4
// Checksum 0xdcd29719, Offset: 0xb50
// Size: 0x114
function private play_static()
{
    if ( !level.parabolic_mic.static islinkedto( self ) )
    {
        level.parabolic_mic.static dontinterpolate();
        level.parabolic_mic.static.origin = self geteye();
        level.parabolic_mic.static linkto( self );
    }
    
    level.parabolic_mic.static playloopsound( level.parabolic_mic.static_alias );
    level.parabolic_mic.static clientfield::set( "parabolic_mic_volume_scale", level.parabolic_mic.static.volumescale );
}

// Namespace parabolic_mic/parabolic_mic
// Params 0, eflags: 0x4
// Checksum 0xce851af9, Offset: 0xc70
// Size: 0x3c
function private stop_static()
{
    if ( isdefined( level.parabolic_mic.static ) )
    {
        level.parabolic_mic.static stoploopsound();
    }
}

// Namespace parabolic_mic/parabolic_mic
// Params 2
// Checksum 0xbe902ba5, Offset: 0xcb8
// Size: 0x54
function function_ce0dfadd( name, func )
{
    if ( !isdefined( level.parabolic_mic.funcs ) )
    {
        level.parabolic_mic.funcs = [];
    }
    
    level.parabolic_mic.funcs[ name ] = func;
}

// Namespace parabolic_mic/parabolic_mic
// Params 1
// Checksum 0x84dc3541, Offset: 0xd18
// Size: 0x5c
function function_afd5613e( name )
{
    if ( isdefined( level.parabolic_mic.funcs ) && isdefined( level.parabolic_mic.funcs[ name ] ) )
    {
        level.parabolic_mic.funcs[ name ] = undefined;
    }
}

// Namespace parabolic_mic/parabolic_mic
// Params 0, eflags: 0x4
// Checksum 0xba4bffe4, Offset: 0xd80
// Size: 0xb50
function private trace()
{
    level endon( #"end_parabolic_mic" );
    min_dist = 300;
    min_dist_squared = min_dist * min_dist;
    max_dist = 4096;
    var_11ecc9fe = max_dist * max_dist;
    eye = self geteye();
    fwd = anglestoforward( self getplayerangles() );
    dotlimit = 0.9986;
    level.parabolic_mic.viewents = [];
    level.parabolic_mic.trace = beamtrace( eye + fwd * min_dist, eye + fwd * max_dist, 1, self, 1, 1 );
    
    /#
        if ( getdvarint( #"hash_1a81e6400daa0c60" ) )
        {
            print3d( level.parabolic_mic.trace[ #"position" ], "<dev string:x66>" + level.parabolic_mic.trace[ #"position" ][ 0 ] + "<dev string:x6a>" + level.parabolic_mic.trace[ #"position" ][ 1 ] + "<dev string:x6a>" + level.parabolic_mic.trace[ #"position" ][ 2 ], ( 1, 1, 1 ), 1, 0.35 );
            sphere( level.parabolic_mic.trace[ #"position" ] );
        }
    #/
    
    arrayremovevalue( level.parabolic_mic.volumes, undefined );
    
    foreach ( volume in level.parabolic_mic.volumes )
    {
        if ( !isdefined( volume ) )
        {
            break;
        }
        
        if ( is_true( volume.hasplayed ) )
        {
            continue;
        }
        
        if ( istouching( level.parabolic_mic.trace[ #"position" ], volume ) )
        {
            /#
                if ( getdvarint( #"hash_1a81e6400daa0c60" ) )
                {
                    print3d( level.parabolic_mic.trace[ #"position" ] + ( 0, 0, 6 ), "<dev string:x70>" + volume.script_noteworthy + "<dev string:x78>", ( 1, 1, 1 ), 1, 0.35, 2 );
                }
            #/
            
            level.parabolic_mic.var_55e793a5 = level.parabolic_mic.trace[ #"position" ];
            level.parabolic_mic.viewents[ level.parabolic_mic.viewents.size ] = volume;
            self function_4383ffd( volume );
            break;
        }
        
        volume.var_62a70840 -= 5;
        volume.var_62a70840 = int( max( 0, volume.var_62a70840 ) );
        
        /#
            if ( getdvarint( #"hash_1a81e6400daa0c60" ) )
            {
                print3d( volume.origin, volume.var_62a70840, ( 1, 0, 1 ), 1, 1, 2 );
            }
        #/
    }
    
    foreach ( item in level.parabolic_mic.points )
    {
        if ( is_true( item.hasplayed ) )
        {
            continue;
        }
        
        delta = item.origin - eye;
        dir = vectornormalize( delta );
        vector_dot = vectordot( dir, fwd );
        dist = distance2dsquared( item.origin, eye );
        
        if ( vector_dot > dotlimit && dist < var_11ecc9fe )
        {
            if ( sighttracepassed( eye + fwd * min_dist, item.origin, 1, self, item ) )
            {
                /#
                    if ( getdvarint( #"hash_1a81e6400daa0c60" ) )
                    {
                        print3d( item.origin + ( 0, 0, 4 ), "<dev string:x70>" + item.script_noteworthy + "<dev string:x83>", ( 1, 1, 1 ), 1, 0.35, 2 );
                    }
                #/
                
                level.parabolic_mic.viewents[ level.parabolic_mic.viewents.size ] = item;
                self function_4383ffd( item );
            }
            else
            {
                item.var_62a70840 -= 5;
                item.var_62a70840 = int( max( 0, item.var_62a70840 ) );
            }
            
            continue;
        }
        
        item.var_62a70840 -= 5;
        item.var_62a70840 = int( max( 0, item.var_62a70840 ) );
    }
    
    function_1eaaceab( level.parabolic_mic.ai );
    arrayremovevalue( level.parabolic_mic.ai, undefined );
    
    foreach ( item in level.parabolic_mic.ai )
    {
        offset = item.origin + ( 0, 0, 64 );
        delta = offset - eye;
        dir = vectornormalize( delta );
        vector_dot = vectordot( dir, fwd );
        dist = distance2dsquared( offset, eye );
        
        if ( vector_dot > dotlimit && dist < var_11ecc9fe )
        {
            if ( sighttracepassed( eye + fwd * min_dist, item.origin, 1, self, item ) )
            {
                /#
                    if ( getdvarint( #"hash_1a81e6400daa0c60" ) )
                    {
                        print3d( offset + ( 0, 0, 26 ), "<dev string:x70>" + item.script_noteworthy + "<dev string:x8d>", ( 1, 1, 1 ), 1, 0.35, 2 );
                    }
                #/
                
                level.parabolic_mic.viewents[ level.parabolic_mic.viewents.size ] = item;
                self function_4383ffd( item );
            }
            else
            {
                item.var_62a70840 -= 5;
                item.var_62a70840 = int( max( 0, item.var_62a70840 ) );
                
                /#
                    if ( getdvarint( #"hash_1a81e6400daa0c60" ) )
                    {
                        print3d( item.origin, item.var_62a70840, ( 1, 0, 1 ), 1, 1, 2 );
                    }
                #/
            }
            
            continue;
        }
        
        item.var_62a70840 -= 5;
        item.var_62a70840 = int( max( 0, item.var_62a70840 ) );
        
        /#
            if ( getdvarint( #"hash_1a81e6400daa0c60" ) )
            {
                print3d( item.origin, item.var_62a70840, ( 1, 0, 1 ), 1, 1, 2 );
            }
        #/
    }
}

// Namespace parabolic_mic/parabolic_mic
// Params 0, eflags: 0x4
// Checksum 0x30bdb68c, Offset: 0x18d8
// Size: 0x6b0
function private function_c5979d91()
{
    level endon( #"end_parabolic_mic" );
    
    if ( level.parabolic_mic.viewents.size > 0 )
    {
        level.parabolic_mic.static.volumescale -= 0.1;
    }
    else
    {
        level.parabolic_mic.static.volumescale += 0.1;
    }
    
    level.parabolic_mic.static.volumescale = math::clamp( level.parabolic_mic.static.volumescale, 0, 1 );
    level.parabolic_mic.static clientfield::set( "parabolic_mic_volume_scale", level.parabolic_mic.static.volumescale );
    eye = self geteye();
    fwd = anglestoforward( self getplayerangles() );
    
    /#
        if ( getdvarint( #"hash_1a81e6400daa0c60" ) )
        {
            iprintln( "<dev string:x94>" + level.parabolic_mic.static.volumescale );
        }
    #/
    
    arrayremovevalue( level.parabolic_mic.sounds, undefined );
    
    foreach ( ent in level.parabolic_mic.sounds )
    {
        var_21397691 = 0;
        
        foreach ( var_1d5586e8 in level.parabolic_mic.viewents )
        {
            if ( ent.traceent == var_1d5586e8 )
            {
                var_21397691 = 1;
                break;
            }
        }
        
        delta = ent.traceent.origin - eye;
        
        if ( isai( ent.traceent ) )
        {
            delta = ent.traceent.origin + ( 0, 0, 64 ) - eye;
        }
        
        if ( is_true( ent.traceent.is_volume ) )
        {
            delta = level.parabolic_mic.var_55e793a5 - eye;
        }
        
        dir = vectornormalize( delta );
        vector_dot = vectordot( dir, fwd );
        
        if ( is_true( ent.traceent.is_volume ) && isdefined( level.parabolic_mic.trace ) )
        {
            range = 0.00139999;
            ent.volumescale = 1 - ( 1 - vector_dot ) / range;
            ent.volumescale = math::clamp( ent.volumescale, 0, 1 );
            ent clientfield::set( "parabolic_mic_volume_scale", ent.volumescale );
            
            /#
                if ( getdvarint( #"hash_1a81e6400daa0c60" ) )
                {
                    if ( isdefined( level.parabolic_mic.var_55e793a5 ) )
                    {
                        print3d( level.parabolic_mic.var_55e793a5 + ( 0, 0, 18 ), ent.traceent.script_noteworthy + "<dev string:xa9>" + ent.volumescale, ( 1, 1, 0 ), 1, 0.35, 2 );
                    }
                }
            #/
            
            continue;
        }
        
        range = 0.00139999;
        ent.volumescale = 1 - ( 1 - vector_dot ) / range;
        ent.volumescale = math::clamp( ent.volumescale, 0, 1 );
        ent clientfield::set( "parabolic_mic_volume_scale", ent.volumescale );
        
        /#
            if ( getdvarint( #"hash_1a81e6400daa0c60" ) )
            {
                print3d( ent.traceent.origin + ( 0, 0, 18 ), ent.traceent.script_noteworthy + "<dev string:xa9>" + ent.volumescale, ( 1, 1, 0 ), 1, 0.35, 2 );
            }
        #/
    }
}

// Namespace parabolic_mic/parabolic_mic
// Params 0, eflags: 0x4
// Checksum 0xb662471a, Offset: 0x1f90
// Size: 0x268
function private function_5cc7f362()
{
    level endon( #"end_parabolic_mic" );
    
    if ( isdefined( level.parabolic_mic.static ) )
    {
        level.parabolic_mic.static.volumescale = 0.1;
        level.parabolic_mic.static.volumescale = math::clamp( level.parabolic_mic.static.volumescale, 0, 1 );
        level.parabolic_mic.static clientfield::set( "parabolic_mic_volume_scale", level.parabolic_mic.static.volumescale );
    }
    
    if ( isarray( level.parabolic_mic.sounds ) )
    {
        arrayremovevalue( level.parabolic_mic.sounds, undefined );
        
        foreach ( ent in level.parabolic_mic.sounds )
        {
            ent.volumescale = 0;
            ent clientfield::set( "parabolic_mic_volume_scale", ent.volumescale );
            
            /#
                if ( getdvarint( #"hash_1a81e6400daa0c60" ) )
                {
                    print3d( ent.traceent.origin + ( 0, 0, 18 ), ent.traceent.script_noteworthy + "<dev string:xa9>" + ent.volumescale, ( 1, 1, 0 ), 1, 1, 2 );
                }
            #/
        }
    }
}

// Namespace parabolic_mic/parabolic_mic
// Params 0
// Checksum 0xec7d9a48, Offset: 0x2200
// Size: 0x288
function function_9a3bbf32()
{
    level endon( #"end_parabolic_mic" );
    was_ads = 0;
    
    foreach ( item in level.parabolic_mic.points )
    {
        item.isplaying = undefined;
        item.hasplayed = undefined;
    }
    
    max_dist = function_8a7dffe8( level.parabolic_mic.max_dist, 4096 );
    
    while ( true )
    {
        wait 0.1;
        level.parabolic_mic.viewents = [];
        
        foreach ( item in level.parabolic_mic.points )
        {
            eye = level.players[ 0 ] geteye();
            distance = distance( item.origin, eye );
            
            if ( distance < max_dist )
            {
                level.parabolic_mic.viewents[ level.parabolic_mic.viewents.size ] = item;
                self function_4383ffd( item );
                continue;
            }
            
            item.var_62a70840 -= 5;
            item.var_62a70840 = int( max( 0, item.var_62a70840 ) );
        }
        
        self function_3ed9a402();
    }
}

// Namespace parabolic_mic/parabolic_mic
// Params 0
// Checksum 0xe8549a9c, Offset: 0x2490
// Size: 0x4c
function radial_sound_end()
{
    level notify( #"end_parabolic_mic" );
    wait 0.25;
    self function_5cc7f362();
    waitframe( 1 );
    cleanup();
}

// Namespace parabolic_mic/parabolic_mic
// Params 0, eflags: 0x4
// Checksum 0xfd94f021, Offset: 0x24e8
// Size: 0x538
function private function_3ed9a402()
{
    level endon( #"end_parabolic_mic" );
    dotlimit = function_8a7dffe8( level.parabolic_mic.dotlimit, 0.9986 );
    eye = self geteye();
    fwd = anglestoforward( self getplayerangles() );
    
    /#
        if ( getdvarint( #"hash_1a81e6400daa0c60" ) )
        {
            iprintln( "<dev string:x94>" + level.parabolic_mic.static.volumescale );
        }
    #/
    
    arrayremovevalue( level.parabolic_mic.sounds, undefined );
    
    foreach ( ent in level.parabolic_mic.sounds )
    {
        var_21397691 = 0;
        
        foreach ( var_1d5586e8 in level.parabolic_mic.viewents )
        {
            if ( ent.traceent == var_1d5586e8 )
            {
                var_21397691 = 1;
                break;
            }
        }
        
        delta = ent.traceent.origin - eye;
        
        if ( isai( ent.traceent ) )
        {
            delta = ent.traceent.origin + ( 0, 0, 64 ) - eye;
        }
        
        if ( is_true( ent.traceent.is_volume ) )
        {
            delta = level.parabolic_mic.var_55e793a5 - eye;
        }
        
        dir = vectornormalize( delta );
        vectordot = vectordot( dir, fwd );
        
        if ( is_true( ent.traceent.is_volume ) && isdefined( level.parabolic_mic.trace ) )
        {
            ent.volumescale = ent function_57f5f925( dotlimit, vectordot );
            ent function_51ee7f9b( ent.volumescale, "parabolic_mic_volume_scale" );
            
            /#
                if ( getdvarint( #"hash_1a81e6400daa0c60" ) )
                {
                    if ( isdefined( level.parabolic_mic.var_55e793a5 ) )
                    {
                        print3d( level.parabolic_mic.var_55e793a5 + ( 0, 0, 18 ), ent.traceent.script_noteworthy + "<dev string:xa9>" + ent.volumescale, ( 1, 1, 0 ), 1, 0.35, 2 );
                    }
                }
            #/
            
            continue;
        }
        
        ent.volumescale = ent function_57f5f925( dotlimit, vectordot );
        ent function_51ee7f9b( ent.volumescale, "parabolic_mic_volume_scale" );
        
        /#
            if ( getdvarint( #"hash_1a81e6400daa0c60" ) )
            {
                print3d( ent.traceent.origin + ( 0, 0, 18 ), ent.traceent.script_noteworthy + "<dev string:xa9>" + ent.volumescale, ( 1, 1, 0 ), 1, 0.35, 2 );
            }
        #/
    }
}

// Namespace parabolic_mic/parabolic_mic
// Params 1, eflags: 0x4
// Checksum 0xb0c7d9cf, Offset: 0x2a28
// Size: 0xe4
function private function_66b4e486( vectordot )
{
    if ( isdefined( level.parabolic_mic.var_7b9d607e ) )
    {
        dotlimit = level.parabolic_mic.var_7b9d607e;
    }
    else
    {
        dotlimit = function_8a7dffe8( level.parabolic_mic.dotlimit, 0.9986 );
    }
    
    level.parabolic_mic.static.volumescale = self function_57f5f925( dotlimit, vectordot, 1 );
    level.parabolic_mic.static function_51ee7f9b( level.parabolic_mic.static.volumescale, "parabolic_mic_volume_scale" );
}

// Namespace parabolic_mic/parabolic_mic
// Params 3, eflags: 0x4
// Checksum 0x6286318b, Offset: 0x2b18
// Size: 0x2fe
function private function_57f5f925( dotlimit, vectordot, isstatic )
{
    range = 1 - dotlimit;
    min_dist = function_8a7dffe8( level.parabolic_mic.min_dist, 300 );
    max_dist = function_8a7dffe8( level.parabolic_mic.max_dist, 4096 );
    eye = level.players[ 0 ] geteye();
    distance = distance( self.traceent.origin, eye );
    
    if ( isdefined( isstatic ) )
    {
        volumescale = ( 1 - vectordot ) / range;
        volumescale = math::clamp( volumescale, 0, 1 );
        
        if ( volumescale < 1 )
        {
            ratio = 1 - ( distance - min_dist ) / ( max_dist - min_dist );
            volumescale = ratio * volumescale;
        }
        else if ( volumescale == 0 )
        {
            ratio = 1 - ( distance - min_dist ) / ( max_dist - min_dist );
            volumescale = ratio;
        }
    }
    else
    {
        if ( distance >= max_dist )
        {
            return 0;
        }
        
        var_3eb55f86 = 0.75;
        
        if ( level.players[ 0 ] playerads() > 0.75 )
        {
            var_3eb55f86 = 1;
        }
        
        var_9e29ef18 = 1;
        
        if ( isdefined( level.var_731c10af.var_42659717 ) )
        {
            if ( level.var_731c10af.var_42659717 == 1 )
            {
                var_9e29ef18 = 0.5;
            }
            else if ( level.var_731c10af.var_42659717 == 2 )
            {
                var_9e29ef18 = 0.75;
            }
        }
        
        volumescale = 1 - ( 1 - vectordot ) / range;
        volumescale = math::clamp( volumescale, 0, 1 );
        ratio = ( 1 + distance - min_dist ) / ( max_dist - min_dist );
        var_4d090353 = 1 - ratio;
        volumescale = var_4d090353 * volumescale * var_3eb55f86 * var_9e29ef18;
    }
    
    return volumescale;
}

// Namespace parabolic_mic/parabolic_mic
// Params 2, eflags: 0x4
// Checksum 0x3c82a927, Offset: 0x2e20
// Size: 0x54
function private function_51ee7f9b( var_f6287736, var_b62cd9d4 )
{
    var_f6287736 = math::clamp( var_f6287736, 0, 1 );
    self clientfield::set( var_b62cd9d4, var_f6287736 );
}

// Namespace parabolic_mic/parabolic_mic
// Params 5
// Checksum 0x83f67e6f, Offset: 0x2e80
// Size: 0x11c
function function_18b589f0( alias, var_21290857 = 0, var_7b80750a, endnotify, var_43a9c16 )
{
    /#
        if ( soundislooping( alias ) === 1 && !isdefined( endnotify ) )
        {
            assertmsg( "<dev string:xb8>" + alias + "<dev string:xe9>" );
        }
    #/
    
    self.queue[ self.queue.size ] = [ alias, float( soundgetplaybacktime( alias ) ) / 1000, var_21290857, var_7b80750a, endnotify, var_43a9c16 ];
}

// Namespace parabolic_mic/parabolic_mic
// Params 1, eflags: 0x4
// Checksum 0xb144ee73, Offset: 0x2fa8
// Size: 0x10c
function private function_4383ffd( ent )
{
    if ( isdefined( ent.hasplayed ) )
    {
        return;
    }
    
    ent.var_62a70840 += 5;
    ent.var_62a70840 = int( min( 100, ent.var_62a70840 ) );
    
    /#
        if ( getdvarint( #"hash_1a81e6400daa0c60" ) )
        {
            print3d( ent.origin, ent.var_62a70840, ( 1, 0, 1 ), 1, 1, 2 );
        }
    #/
    
    if ( isdefined( ent.isplaying ) )
    {
        return;
    }
    
    if ( ent.script_parameters === "off" )
    {
        /#
        #/
        
        return;
    }
    
    self thread prep_sound( ent );
}

// Namespace parabolic_mic/parabolic_mic
// Params 1, eflags: 0x4
// Checksum 0x64d44f5, Offset: 0x30c0
// Size: 0x13a
function private prep_sound( ent )
{
    ent endon( #"entitydeleted" );
    ent endon( #"death" );
    soundent = util::spawn_model( "tag_origin", self geteye() );
    soundent linkto( self );
    soundent.volumescale = 0;
    soundent.traceent = ent;
    soundent clientfield::set( "parabolic_mic_volume_scale", soundent.volumescale );
    level.parabolic_mic.sounds[ level.parabolic_mic.sounds.size ] = soundent;
    ent.isplaying = 1;
    soundent play_sound();
    
    if ( isdefined( ent ) )
    {
        ent.isplaying = 0;
        ent.hasplayed = 1;
    }
}

// Namespace parabolic_mic/parabolic_mic
// Params 0, eflags: 0x4
// Checksum 0x80167dc0, Offset: 0x3208
// Size: 0x134
function private play_sound()
{
    strfunc = undefined;
    
    if ( isdefined( self.traceent.listening_func ) )
    {
        strfunc = self.traceent.listening_func;
    }
    else if ( isdefined( self.traceent.script_noteworthy ) )
    {
        strfunc = self.traceent.script_noteworthy;
    }
    
    level endon( #"stop_listening_vo" );
    self thread function_85eb609f();
    
    if ( isdefined( strfunc ) )
    {
        if ( isdefined( level.parabolic_mic.funcs[ strfunc ] ) )
        {
            data = [[ level.parabolic_mic.funcs[ strfunc ] ]]();
            
            if ( isdefined( data ) && isdefined( data.queue ) && data.queue.size > 0 )
            {
                self function_4384e133( data );
            }
        }
    }
    
    self delete();
}

// Namespace parabolic_mic/parabolic_mic
// Params 1, eflags: 0x4
// Checksum 0x59944d5c, Offset: 0x3348
// Size: 0x2c
function private function_4384e133( data )
{
    self util::function_stack( &function_622d474a, data );
}

// Namespace parabolic_mic/parabolic_mic
// Params 1, eflags: 0x4
// Checksum 0xfb6715f9, Offset: 0x3380
// Size: 0x24a
function private function_622d474a( data )
{
    function_9716db11( data );
    level endon( #"stop_listening_vo" );
    data endon( #"hash_7893b918a25583b7" );
    
    foreach ( item in data.queue )
    {
        alias = item[ 0 ];
        var_d6819a9f = item[ 1 ];
        delaytime = item[ 2 ];
        var_7b80750a = item[ 3 ];
        endnotify = item[ 4 ];
        var_43a9c16 = item[ 5 ];
        
        if ( isdefined( var_43a9c16 ) )
        {
            level waittill( var_43a9c16 );
        }
        
        if ( delaytime !== 0 )
        {
            wait delaytime;
        }
        
        if ( isdefined( var_7b80750a ) )
        {
            level notify( var_7b80750a );
        }
        
        if ( !soundexists( alias ) )
        {
            /#
                iprintlnbold( "<dev string:x11c>" + function_9e72a96( alias ) + "<dev string:x135>" );
            #/
            
            wait 3;
            
            if ( isdefined( endnotify ) )
            {
                level notify( endnotify );
            }
            
            continue;
        }
        
        if ( soundislooping( alias ) === 1 )
        {
            self function_32c867ae( alias, endnotify );
            continue;
        }
        
        self playsound( alias );
        
        if ( var_d6819a9f > 0 )
        {
            wait var_d6819a9f;
        }
        
        if ( isdefined( endnotify ) )
        {
            level notify( endnotify );
        }
    }
}

// Namespace parabolic_mic/parabolic_mic
// Params 2, eflags: 0x4
// Checksum 0x1d5a285, Offset: 0x35d8
// Size: 0x5a
function private function_32c867ae( alias, endnotify )
{
    if ( isdefined( alias ) )
    {
        self playloopsound( alias );
        level waittill( endnotify );
        self stoploopsound();
        waitframe( 1 );
    }
}

// Namespace parabolic_mic/parabolic_mic
// Params 1, eflags: 0x4
// Checksum 0x1e7cfc6a, Offset: 0x3640
// Size: 0xb8
function private function_9716db11( data )
{
    if ( isdefined( data.interruptable ) )
    {
        level notify( #"stop_listening_vo" );
        
        foreach ( item in data.queue )
        {
            self stopsounds();
        }
    }
}

// Namespace parabolic_mic/parabolic_mic
// Params 0, eflags: 0x4
// Checksum 0x6c9c7b83, Offset: 0x3700
// Size: 0x44
function private function_85eb609f()
{
    self endon( #"death" );
    level waittill( #"stop_listening_vo" );
    self delete();
}

// Namespace parabolic_mic/parabolic_mic
// Params 2, eflags: 0x4
// Checksum 0x57fc6d65, Offset: 0x3750
// Size: 0x3c
function private function_8a7dffe8( var_a8cdbaa5, var_53bfdf6b )
{
    if ( isdefined( var_a8cdbaa5 ) )
    {
        value = var_a8cdbaa5;
    }
    else
    {
        value = var_53bfdf6b;
    }
    
    return value;
}

