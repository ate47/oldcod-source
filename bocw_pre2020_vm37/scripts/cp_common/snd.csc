#using script_1cd690a97dfca36e;
#using scripts\core_common\array_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\snd_debug;
#using scripts\cp_common\snd_draw;
#using scripts\cp_common\snd_utility;

#namespace snd;

// Namespace snd/snd
// Params 0, eflags: 0x6
// Checksum 0xf4f9d813, Offset: 0x3b8
// Size: 0x2ca
function private autoexec function_4047919b()
{
    if ( !isdefined( level._snd ) )
    {
        level._snd = spawnstruct();
        level._snd.var_8c37ff34 = 1;
        level._snd._callbacks = [];
        level._snd.var_3cc765a3 = [];
        level._snd.var_92f63ad0 = [];
        level._snd.var_d37e94ca = #"centity";
        level._snd.var_90903fc0 = 0;
        level._snd._callbacks[ #"pitch_get" ] = &function_6f94855d;
        level._snd._callbacks[ #"pitch_set" ] = &function_679011ab;
        level._snd._callbacks[ #"volume_get" ] = &function_7308d4d0;
        level._snd._callbacks[ #"volume_set" ] = &function_a43df3ac;
        level._snd._callbacks[ #"player_view" ] = &function_959bbfdb;
        level._snd._callbacks[ #"player_angles" ] = &function_2c0c5fbc;
        level._snd._callbacks[ #"player_fov" ] = &function_bf76eea3;
    }
    
    util::register_system( "clientSoundCommand", &function_8610d024 );
    function_3ffa0089();
    
    /#
        function_ce893a25();
        dvar( "<dev string:x38>", "<dev string:x58>", &function_360bb421 );
        dvar( "<dev string:x5c>", "<dev string:x58>", &function_360bb421 );
    #/
    
    waittillframeend();
    level._snd.isinitialized = 1;
}

// Namespace snd/snd
// Params 2, eflags: 0x4
// Checksum 0x917e422a, Offset: 0x690
// Size: 0x212
function private function_8610d024( localclientnum, _cmd )
{
    waitforplayers();
    player = function_a8210e43( localclientnum );
    args = strtok( _cmd, " " );
    waittillframeend();
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( isarray( args ) && args.size >= 2 )
    {
        cmd = args[ 0 ];
        
        switch ( cmd )
        {
            case #"#":
            case #"m":
                function_21d71e38( player, cmd, args );
                break;
            case #"t":
                function_6d366059( player, cmd, args );
                break;
            case #"v":
                function_cc4bf5ee( player, cmd, args );
                break;
            default:
                /#
                    function_81fac19d( function_d78e3644(), "<dev string:x7c>" + cmd + "<dev string:x9b>" );
                #/
                
                break;
        }
    }
    
    if ( isscriptfunctionptr( level._snd._callbacks[ #"clientsoundcommand" ] ) )
    {
        [[ level._snd._callbacks[ #"clientsoundcommand" ] ]]( localclientnum, _cmd );
    }
}

// Namespace snd/snd
// Params 3, eflags: 0x4
// Checksum 0xb7d648a2, Offset: 0x8b0
// Size: 0x22a
function private function_21d71e38( player, cmd, args )
{
    assert( isplayer( player ) );
    assert( isdefined( player.localclientnum ) );
    assert( isstring( cmd ) && ( cmd == "<dev string:xa0>" || cmd == "<dev string:xa5>" ) );
    assert( isarray( args ) && args.size >= 2 );
    
    if ( function_81fac19d( !isscriptfunctionptr( level._snd._callbacks[ #"client_msg" ] ), "snd: client msg without initialization" ) )
    {
        return;
    }
    
    msg = undefined;
    
    if ( cmd == "#" )
    {
        msg = function_35dccf3f( args[ 1 ] );
    }
    else if ( cmd == "M" )
    {
        msg = args[ 1 ];
    }
    
    var_65cde9d7 = isstring( msg ) || ishash( msg );
    
    if ( function_81fac19d( !var_65cde9d7, "snd: invalid client msg" ) )
    {
        return;
    }
    
    level thread [[ level._snd._callbacks[ #"client_msg" ] ]]( player, msg );
}

// Namespace snd/snd
// Params 3, eflags: 0x4
// Checksum 0x84a7b3f4, Offset: 0xae8
// Size: 0x2f4
function private function_6d366059( player, cmd, args )
{
    assert( isplayer( player ) );
    assert( isdefined( player.localclientnum ) );
    assert( isstring( cmd ) && cmd == "<dev string:xaa>" );
    assert( isarray( args ) );
    
    if ( function_81fac19d( !isscriptfunctionptr( level._snd._callbacks[ #"client_targetname" ] ), "snd: client targetname without initialization" ) )
    {
        return;
    }
    
    var_1ef003e2 = int( args[ 1 ] );
    targetname = string( args[ 2 ] );
    
    if ( args.size > 3 )
    {
        for ( i = 3; i < args.size ; i++ )
        {
            targetname += " " + string( args[ i ] );
        }
    }
    
    ent = undefined;
    framecount = 0;
    
    while ( true )
    {
        ent = getentbynum( player.localclientnum, var_1ef003e2 );
        
        if ( isentity( ent ) )
        {
            ent.targetname = targetname;
            ent thread [[ level._snd._callbacks[ #"client_targetname" ] ]]( ent, targetname );
            break;
        }
        
        framecount++;
        
        if ( function_81fac19d( framecount % 60 == 0, "snd: client targetname not found '" + targetname + "' (" + var_1ef003e2 + ")" ) )
        {
            if ( function_81fac19d( framecount % 1800 == 0, "snd: client targetname ABORTED '" + targetname + "' (" + var_1ef003e2 + ")" ) )
            {
                break;
            }
        }
        
        waitframe( 1 );
    }
}

// Namespace snd/snd
// Params 3, eflags: 0x4
// Checksum 0xd024d9c, Offset: 0xde8
// Size: 0x544
function private function_cc4bf5ee( player, cmd, args )
{
    assert( isplayer( player ) );
    assert( isdefined( player.localclientnum ) );
    assert( isstring( cmd ) && cmd == "<dev string:xaf>" );
    assert( isarray( args ) );
    var_e1fb96c7 = isdefined( level._snd._callbacks[ #"client_voice" ] ) && isscriptfunctionptr( level._snd._callbacks[ #"client_voice" ] );
    entitynumber = int( args[ 1 ] );
    soundalias = undefined;
    
    if ( args.size >= 3 && isdefined( args[ 2 ] ) )
    {
        soundalias = string( args[ 2 ] );
    }
    
    if ( args.size > 3 )
    {
        assert( isstring( soundalias ) );
        
        for ( i = 3; i < args.size ; i++ )
        {
            soundalias += " " + string( args[ i ] );
        }
    }
    
    ent = undefined;
    framecount = 0;
    
    while ( true )
    {
        ent = getentbynum( player.localclientnum, entitynumber );
        
        if ( isentity( ent ) )
        {
            if ( var_e1fb96c7 )
            {
                ent thread [[ level._snd._callbacks[ #"client_voice" ] ]]( ent, soundalias );
            }
            else
            {
                var_90709302 = isdefined( soundalias );
                var_2115c64c = function_a6779cbd( ent.var_6d22c36f );
                
                if ( var_90709302 )
                {
                    if ( !isarray( ent.var_bfe14559 ) )
                    {
                        ent.var_bfe14559 = [ soundalias ];
                    }
                    else
                    {
                        ent.var_bfe14559[ ent.var_bfe14559.size ] = soundalias;
                    }
                }
                
                if ( var_2115c64c && !var_90709302 )
                {
                    stop( ent.var_6d22c36f );
                    ent.var_bfe14559 = undefined;
                    ent.var_6d22c36f = undefined;
                }
                
                if ( !isdefined( ent.var_6d22c36f ) )
                {
                    while ( isarray( ent.var_bfe14559 ) )
                    {
                        alias = ent.var_bfe14559[ 0 ];
                        arrayremoveindex( ent.var_bfe14559, 0, 0 );
                        ent.var_6d22c36f = play( alias, [ ent, "j_head" ] );
                        function_2fdc4fb( ent.var_6d22c36f );
                        wait 0.666;
                        
                        if ( isarray( ent.var_bfe14559 ) && ent.var_bfe14559.size == 0 )
                        {
                            ent.var_bfe14559 = undefined;
                        }
                        
                        if ( isdefined( ent ) )
                        {
                            ent.var_6d22c36f = undefined;
                        }
                    }
                }
            }
            
            break;
        }
        
        framecount++;
        
        if ( function_81fac19d( framecount % 60 == 0, "snd: client voice entity not found '" + soundalias + "' (" + entitynumber + ")" ) )
        {
            if ( function_81fac19d( framecount % 1800 == 0, "snd: client soundalias ABORTED '" + soundalias + "' (" + entitynumber + ")" ) )
            {
                break;
            }
        }
        
        waitframe( 1 );
    }
}

// Namespace snd/snd
// Params 1
// Checksum 0x8c1efefe, Offset: 0x1338
// Size: 0x94
function function_d4ec748e( callback )
{
    if ( function_81fac19d( !isscriptfunctionptr( callback ), "snd_client_msg_init: invalid function" ) )
    {
        /#
            if ( function_f984063f() )
            {
                debugbreak();
            }
        #/
        
        return;
    }
    
    level._snd._callbacks[ #"client_msg" ] = callback;
}

// Namespace snd/snd
// Params 1
// Checksum 0x2a73aea1, Offset: 0x13d8
// Size: 0x94
function function_ce78b33b( callback )
{
    if ( function_81fac19d( !isscriptfunctionptr( callback ), "snd_client_targetname_init: invalid function" ) )
    {
        /#
            if ( function_f984063f() )
            {
                debugbreak();
            }
        #/
        
        return;
    }
    
    level._snd._callbacks[ #"client_targetname" ] = callback;
}

#namespace namespace_afa8e18b;

// Namespace namespace_afa8e18b/snd
// Params 4
// Checksum 0xae17e91d, Offset: 0x1478
// Size: 0x1b0
function function_2761fc04( ent, var_1d25915, linkedentity, linkedbonetag )
{
    assert( isdefined( ent ), "<dev string:xb4>" );
    assert( isdefined( ent.soundkey ), "<dev string:xce>" );
    
    if ( isdefined( linkedentity ) )
    {
        linkedbonetag = linkedentity snd::gettagsafe( linkedbonetag );
        linkedoffset = ( 0, 0, 0 );
        linkedangles = ( 0, 0, 0 );
        
        if ( isdefined( var_1d25915 ) )
        {
            linkedoffset = var_1d25915;
        }
        
        assert( isdefined( linkedbonetag ), "<dev string:xe9>" );
        
        if ( isstring( linkedbonetag ) && linkedbonetag != "" && linkedbonetag != "tag_origin" )
        {
            ent linkto( linkedentity, linkedbonetag );
        }
        else
        {
            ent linkto( linkedentity );
        }
        
        if ( !isarray( linkedentity.var_a415b6d6 ) )
        {
            linkedentity.var_a415b6d6 = [];
        }
        
        linkedentity.var_a415b6d6[ ent.soundkey ] = ent;
        return;
    }
    
    level._snd.var_92f63ad0[ ent.soundkey ] = ent;
}

// Namespace namespace_afa8e18b/snd
// Params 4
// Checksum 0x3ea21e9, Offset: 0x1630
// Size: 0x216
function function_5275752c( soundalias, var_1d25915, linkedentity, linkedbonetag )
{
    ent = undefined;
    spawnorigin = undefined;
    
    if ( isdefined( linkedentity ) && isdefined( linkedbonetag ) && isdefined( var_1d25915 ) )
    {
        spawnorigin = linkedentity gettagorigin( linkedbonetag );
        spawnorigin += var_1d25915;
    }
    else if ( isdefined( linkedentity ) && isdefined( linkedbonetag ) )
    {
        spawnorigin = linkedentity gettagorigin( linkedbonetag );
    }
    else if ( isdefined( linkedentity ) )
    {
        spawnorigin = linkedentity.origin;
    }
    else if ( !isdefined( linkedentity ) && !isdefined( var_1d25915 ) )
    {
        var_3692a397 = ( 0, 0, -32768 );
        spawnorigin = var_3692a397;
    }
    else
    {
        spawnorigin = var_1d25915;
    }
    
    assert( isdefined( spawnorigin ) );
    ent = undefined;
    
    if ( isdefined( linkedentity ) )
    {
        ent = spawn( 0, spawnorigin, "script_model" );
        ent setmodel( "tag_origin" );
    }
    else
    {
        ent = spawn( 0, spawnorigin, "script_origin" );
    }
    
    assert( isdefined( ent ), "<dev string:x109>" );
    ent.soundlinkedentity = linkedentity;
    ent.soundtype = #"centity";
    ent.soundkey = ent getentitynumber();
    ent.targetname = "snd " + soundalias;
    return ent;
}

// Namespace namespace_afa8e18b/snd
// Params 1
// Checksum 0x511b60d, Offset: 0x1850
// Size: 0x174
function function_bdc44456( ent )
{
    if ( snd::function_81fac19d( !isdefined( ent ) || function_3132f113( ent ), "snd: free on deleted entity!" ) )
    {
        /#
            if ( snd::function_f984063f() )
            {
                debugbreak();
            }
        #/
        
        return;
    }
    
    if ( isdefined( ent.soundlinkedentity ) && isarray( ent.soundlinkedentity.var_a415b6d6 ) )
    {
        linkedentity = ent.soundlinkedentity;
        var_5244aa9 = isdefined( linkedentity.var_a415b6d6[ ent.soundkey ] );
        
        if ( var_5244aa9 == 1 )
        {
            linkedentity.var_a415b6d6[ ent.soundkey ] = undefined;
        }
        else
        {
            /#
                if ( snd::function_f984063f() )
                {
                    debugbreak();
                }
            #/
        }
    }
    else
    {
        level._snd.var_92f63ad0[ ent.soundkey ] = undefined;
    }
    
    waittillframeend();
    ent delete();
}

// Namespace namespace_afa8e18b/snd
// Params 4
// Checksum 0x35a92165, Offset: 0x19d0
// Size: 0x27e
function function_bb749fc3( soundobject, soundalias, initialvolume, delaytime )
{
    ent = soundobject;
    currentvolume = undefined;
    ent endon( #"death" );
    assert( isdefined( ent ) );
    assert( isstring( soundalias ) || ishash( soundalias ) );
    currentvolume = 1;
    
    if ( !isdefined( initialvolume ) && isdefined( currentvolume ) )
    {
        initialvolume = currentvolume;
    }
    
    if ( snd::did_init() == 0 )
    {
        var_cd7344db = !isdefined( delaytime ) || snd::isnumber( delaytime ) && delaytime == 0;
        
        if ( snd::function_81fac19d( var_cd7344db, "snd: delayed due to first frame!" ) )
        {
            delaytime = 0.05;
        }
    }
    
    if ( snd::isnumber( delaytime ) && delaytime > 0 )
    {
        wait delaytime;
    }
    
    soundhandle = -1;
    assert( soundexists( soundalias ), "<dev string:x131>" + soundalias );
    
    if ( soundislooping( soundalias ) == 1 )
    {
        soundhandle = ent playloopsound( soundalias );
    }
    else
    {
        donenotifystr = "sounddone";
        soundhandle = ent playsound( 0, soundalias );
        ent.soundhandle = soundhandle;
        ent thread function_297cdf07( donenotifystr, soundhandle );
    }
    
    ent.soundalias = soundalias;
    ent.soundhandle = soundhandle;
}

// Namespace namespace_afa8e18b/snd
// Params 2
// Checksum 0xc31f89d2, Offset: 0x1c58
// Size: 0x18c
function function_273d939b( soundobject, fadeoutseconds )
{
    soundobject endon( #"death" );
    ent = soundobject;
    
    if ( snd::function_81fac19d( !isdefined( ent ) || function_3132f113( ent ), "snd: stop on deleted entity!" ) )
    {
        /#
            if ( snd::function_f984063f() )
            {
                debugbreak();
            }
        #/
        
        return;
    }
    
    soundalias = ent.soundalias;
    
    if ( isstring( soundalias ) )
    {
        if ( is_true( soundislooping( soundalias ) ) )
        {
            ent stoploopsound( ent.soundhandle, fadeoutseconds );
        }
        else
        {
            ent stopsounds();
            stopsound( ent.soundhandle );
        }
        
        waitframe( 1 );
        ent.soundalias = undefined;
        ent.soundhandle = undefined;
    }
    
    ent.soundtype = undefined;
    function_bdc44456( ent );
}

// Namespace namespace_afa8e18b/snd
// Params 2, eflags: 0x4
// Checksum 0xb356fbbf, Offset: 0x1df0
// Size: 0xa4
function private function_5834ae26( soundalias, done )
{
    ent = self;
    ent endon( #"death" );
    waittime = soundgetplaybacktime( soundalias );
    waittime *= 1.25;
    waittime /= 1000;
    wait waittime;
    ent notify( done, ent.soundalias );
    function_bdc44456( ent );
}

// Namespace namespace_afa8e18b/snd
// Params 1, eflags: 0x4
// Checksum 0x3a918bb8, Offset: 0x1ea0
// Size: 0x64
function private function_7b0e43ab( done )
{
    ent = self;
    ent endon( #"death" );
    ent waittill( done );
    ent notify( done, ent.soundalias );
    function_bdc44456( ent );
}

// Namespace namespace_afa8e18b/snd
// Params 2, eflags: 0x4
// Checksum 0x2512fdec, Offset: 0x1f10
// Size: 0x7c
function private function_297cdf07( done, soundhandle )
{
    ent = self;
    ent endon( #"death" );
    
    while ( soundplaying( soundhandle ) )
    {
        waitframe( 1 );
    }
    
    ent notify( done, ent.soundalias );
    function_bdc44456( ent );
}

/#

    // Namespace namespace_afa8e18b/snd
    // Params 4
    // Checksum 0x2f4d15, Offset: 0x1f98
    // Size: 0x44, Type: dev
    function function_b5959278( *ent, *var_1d25915, *linkedentity, *linkedbonetag )
    {
        assert( 0, "<dev string:x14f>" );
    }

#/

// Namespace namespace_afa8e18b/snd
// Params 4
// Checksum 0xf71fedd8, Offset: 0x1fe8
// Size: 0x46
function function_85daf9f0( *soundalias, *var_1d25915, *linkedentity, *linkedbonetag )
{
    assert( 0, "<dev string:x14f>" );
    return undefined;
}

/#

    // Namespace namespace_afa8e18b/snd
    // Params 1
    // Checksum 0xaceb74d6, Offset: 0x2038
    // Size: 0x2c, Type: dev
    function function_6ac5b570( *ent )
    {
        assert( 0, "<dev string:x14f>" );
    }

    // Namespace namespace_afa8e18b/snd
    // Params 4
    // Checksum 0x97459134, Offset: 0x2070
    // Size: 0x44, Type: dev
    function function_2dde45d9( *soundobject, *soundalias, *initialvolume, *delaytime )
    {
        assert( 0, "<dev string:x14f>" );
    }

    // Namespace namespace_afa8e18b/snd
    // Params 2
    // Checksum 0x8dc0cf1f, Offset: 0x20c0
    // Size: 0x34, Type: dev
    function function_9f156b27( *soundobject, *fadeoutseconds )
    {
        assert( 0, "<dev string:x14f>" );
    }

#namespace snd;

#/

// Namespace snd/snd
// Params 1, eflags: 0x4
// Checksum 0xf9b4065f, Offset: 0x2100
// Size: 0xcc
function private function_3323ac64( soundobject )
{
    if ( isdefined( soundobject ) == 1 && function_3132f113( soundobject ) == 0 && isdefined( soundobject.var_aceb47b0 ) == 0 )
    {
        soundobject.var_aceb47b0 = spawnstruct();
        soundobject.var_aceb47b0.volume = 1;
        soundobject.var_aceb47b0.pitch = 1;
        soundobject.var_aceb47b0.threads = [];
        function_f2a84378( soundobject, function_6cfa7975() );
    }
}

// Namespace snd/snd
// Params 3, eflags: 0x4
// Checksum 0x219db530, Offset: 0x21d8
// Size: 0x8c
function private function_5803da43( sound, volume, time )
{
    if ( isdefined( sound ) && isdefined( sound.soundhandle ) )
    {
        if ( time > 0 )
        {
            time = 1 / time;
        }
        
        setsoundvolumerate( sound.soundhandle, time );
        setsoundvolume( sound.soundhandle, volume );
    }
}

// Namespace snd/snd
// Params 3, eflags: 0x4
// Checksum 0xb3972e4a, Offset: 0x2270
// Size: 0x8c
function private function_d7b79aea( sound, pitch, time )
{
    if ( isdefined( sound ) && isdefined( sound.soundhandle ) )
    {
        if ( time > 0 )
        {
            time = 1 / time;
        }
        
        setsoundpitchrate( sound.soundhandle, time );
        setsoundpitch( sound.soundhandle, pitch );
    }
}

// Namespace snd/snd
// Params 3, eflags: 0x4
// Checksum 0x64abef5, Offset: 0x2308
// Size: 0xf2
function private function_d72fc2b9( soundobject, value, scalefunc )
{
    if ( function_3132f113( soundobject ) == 1 || isdefined( soundobject ) == 0 )
    {
        return;
    }
    
    function_3323ac64( soundobject );
    assert( isdefined( soundobject.var_aceb47b0 ) == 1 );
    
    if ( isdefined( scalefunc ) == 1 )
    {
        if ( scalefunc == &function_5803da43 )
        {
            soundobject.var_aceb47b0.volume = value;
            return;
        }
        
        if ( scalefunc == &function_d7b79aea )
        {
            soundobject.var_aceb47b0.pitch = value;
        }
    }
}

// Namespace snd/snd
// Params 2, eflags: 0x4
// Checksum 0x69550dde, Offset: 0x2408
// Size: 0x9e
function private function_2530f85d( soundobject, scalefunc )
{
    assert( isdefined( soundobject ) );
    
    if ( isdefined( soundobject.var_aceb47b0 ) == 1 )
    {
        if ( scalefunc == &function_5803da43 )
        {
            return soundobject.var_aceb47b0.volume;
        }
        else if ( scalefunc == &function_d7b79aea )
        {
            return soundobject.var_aceb47b0.pitch;
        }
    }
    
    return undefined;
}

// Namespace snd/snd
// Params 1, eflags: 0x4
// Checksum 0x7fb460ad, Offset: 0x24b0
// Size: 0x15e
function private function_6c660df4( scalefunc )
{
    var_5a2568f4 = 0;
    scalestring = undefined;
    self endon( #"death" );
    self waittill( #"snd_scale_completed" );
    assert( isdefined( scalefunc ) == 1, "<dev string:x172>" );
    
    if ( scalefunc == &function_5803da43 )
    {
        self.var_aceb47b0.isscalingvolume = undefined;
        scalestring = "volume";
    }
    
    if ( scalefunc == &function_d7b79aea )
    {
        self.var_aceb47b0.isscalingpitch = undefined;
        scalestring = "pitch";
    }
    
    assert( isdefined( scalestring ) == 1 );
    self.var_aceb47b0.threads[ scalestring ] = undefined;
    
    if ( isdefined( self.var_aceb47b0.isscalingvolume ) == 0 && isdefined( self.var_aceb47b0.isscalingpitch ) == 0 )
    {
        self.var_aceb47b0.isscaling = undefined;
    }
    
    self notify( "snd_stop_scale_" + scalestring );
    waittillframeend();
}

// Namespace snd/snd
// Params 5, eflags: 0x4
// Checksum 0x99a01039, Offset: 0x2618
// Size: 0x762
function private function_48e190dd( curve, scale, time, scalefunc, callbackfunc )
{
    self endon( #"death", #"disconnect" );
    assert( isdefined( self.var_aceb47b0 ) == 1 );
    assert( isdefined( self.var_aceb47b0.threads ) == 1 );
    assert( isdefined( scalefunc ) == 1 );
    assert( time > 0 );
    curvepts = function_fc955f31( curve );
    assert( curvepts > 0, "<dev string:x58>" );
    frametime = float( function_6cfa7975() );
    timeremainder = function_a18ae88f( float( time ), frametime );
    time = float( time ) + frametime - timeremainder;
    timeinterval = float( time ) / float( curvepts );
    timeintervalremainder = function_a18ae88f( timeinterval, frametime );
    timeinterval = timeinterval + frametime - timeintervalremainder;
    timeinterval = max( timeinterval, frametime );
    timeintervalms = int( timeinterval * 1000 + 0.5 );
    timems = int( time * 1000 + 0.5 );
    timecounterms = int( 0 );
    
    if ( isdefined( self.var_aceb47b0.isscaling ) == 1 )
    {
        var_e971cedf = 0;
        
        if ( isdefined( self.var_aceb47b0.isscalingvolume ) == 1 && scalefunc == &function_5803da43 || isdefined( self.var_aceb47b0.isscalingpitch ) == 1 && scalefunc == &function_d7b79aea )
        {
            var_e971cedf = 1;
        }
        
        if ( var_e971cedf == 1 )
        {
            self notify( #"snd_scale_completed" );
            waittillframeend();
            self notify( #"snd_scale_interrupted" );
        }
    }
    
    scalestart = function_2530f85d( self, scalefunc );
    inversecurve = 0;
    
    if ( scalestart > scale )
    {
        inversecurve = 1;
    }
    
    while ( isdefined( self.soundalias ) == 0 )
    {
        waitframe( 1 );
    }
    
    waittillframeend();
    self thread function_6c660df4( scalefunc );
    self.var_aceb47b0.isscaling = 1;
    scalestring = undefined;
    
    if ( scalefunc == &function_5803da43 )
    {
        self.var_aceb47b0.isscalingvolume = 1;
        scalestring = "volume";
    }
    
    if ( scalefunc == &function_d7b79aea )
    {
        self.var_aceb47b0.isscalingpitch = 1;
        scalestring = "pitch";
    }
    
    assert( isdefined( scalestring ) == 1 );
    self.var_aceb47b0.threads[ scalestring ] = 1;
    self endon( "snd_stop_scale_" + scalestring );
    
    while ( timecounterms < timems && isdefined( self ) == 1 && isdefined( self.var_aceb47b0.threads[ scalestring ] ) == 1 )
    {
        remainingtime = ( timems - timecounterms ) * 0.001;
        
        if ( isdefined( self.var_aceb47b0.waitinterval ) == 1 )
        {
            timeinterval = max( self.var_aceb47b0.waitinterval, frametime );
        }
        
        waittime = min( timeinterval, remainingtime );
        timecounterms += int( waittime * 1000 + 0.5 );
        timefrac = float( timecounterms ) / float( timems );
        scalevalue = 1;
        
        if ( inversecurve > 0 )
        {
            timefrac = math::clamp( 1 - timefrac, 0, 1 );
            curvevalue = function_b918d683( timefrac, curve );
            scalevalue = lerpfloat( scale, scalestart, curvevalue );
        }
        else
        {
            curvevalue = function_b918d683( timefrac, curve );
            scalevalue = lerpfloat( scalestart, scale, curvevalue );
        }
        
        /#
        #/
        
        [[ scalefunc ]]( self, scalevalue, waittime );
        wait waittime;
        
        if ( isdefined( self ) == 1 && function_3132f113( self ) == 0 )
        {
            function_d72fc2b9( self, scalevalue, scalefunc );
        }
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isdefined( self ) == 1 )
    {
        self notify( #"snd_scale_completed", scalefunc );
    }
    
    if ( isdefined( callbackfunc ) == 1 )
    {
        self [[ callbackfunc ]]();
    }
}

// Namespace snd/snd
// Params 2
// Checksum 0x7a876240, Offset: 0x2d88
// Size: 0xaa
function function_f2a84378( soundobject, waitinterval )
{
    assert( isdefined( soundobject ) == 1 );
    function_3323ac64( soundobject );
    assert( isdefined( soundobject.var_aceb47b0 ) == 1 );
    soundobject.var_aceb47b0.waitinterval = max( waitinterval, function_6cfa7975() );
}

// Namespace snd/snd
// Params 6
// Checksum 0x8cc26980, Offset: 0x2e40
// Size: 0x478
function snd_scale( soundobject, scalewhat, value, time, curve, callbackfunc )
{
    var_43b6ef7d = 0.00390625;
    var_16f452ed = 2;
    var_7a9a68cb = 0;
    var_69111be2 = 4;
    
    if ( function_81fac19d( isdefined( soundobject ) == 0, "snd_scale: called on undefined entity" ) )
    {
        return;
    }
    
    if ( function_81fac19d( function_3132f113( soundobject ) == 1, "snd_scale: called on removed entity" ) )
    {
        return;
    }
    
    assert( isdefined( soundobject ) == 1, "<dev string:x19c>" );
    assert( function_3132f113( soundobject ) == 0, "<dev string:x1c5>" );
    assert( isdefined( value ) == 1 );
    function_3323ac64( soundobject );
    clampedvalue = value;
    scalefunc = undefined;
    scalestring = undefined;
    
    switch ( scalewhat )
    {
        case #"volume":
        case #"volume":
        case #"v":
        case #"v":
        case #"vol":
        case #"vol":
            curve = function_ea2f17d1( curve, "easeout" );
            scalefunc = &function_5803da43;
            scalestring = "volume";
            clampedvalue = math::clamp( value, var_7a9a68cb, var_69111be2 );
            function_81fac19d( value != clampedvalue, "snd_scale: clamped volume " + value + " -> " + clampedvalue );
            break;
        case #"p":
        case #"p":
        case #"pitch":
        case #"pitch":
            curve = function_ea2f17d1( curve, "linear" );
            scalefunc = &function_d7b79aea;
            scalestring = "pitch";
            clampedvalue = math::clamp( value, var_43b6ef7d, var_16f452ed );
            function_81fac19d( value != clampedvalue, "snd_scale: clamped pitch " + value + " -> " + clampedvalue );
            break;
    }
    
    assert( isdefined( soundobject ) == 1 );
    
    if ( isdefined( time ) == 0 || time == 0 )
    {
        [[ scalefunc ]]( soundobject, clampedvalue, 0 );
        function_d72fc2b9( soundobject, clampedvalue, scalefunc );
        soundobject notify( #"snd_scale_completed", scalefunc );
        soundobject notify( #"snd_scale_interrupted" );
        soundobject notify( "snd_stop_scale_" + scalestring );
        return;
    }
    
    soundobject thread function_48e190dd( curve, clampedvalue, time, scalefunc, callbackfunc );
    
    if ( scalefunc == &function_5803da43 )
    {
        soundobject notify( #"stopfade" );
    }
}

// Namespace snd/snd
// Params 5
// Checksum 0x83ba8c60, Offset: 0x32c0
// Size: 0x54
function function_a43df3ac( soundobject, volume, time, curve, callbackfunc )
{
    snd_scale( soundobject, "volume", volume, time, curve, callbackfunc );
}

// Namespace snd/snd
// Params 5
// Checksum 0x7514b56f, Offset: 0x3320
// Size: 0x54
function function_679011ab( soundobject, pitch, time, curve, callbackfunc )
{
    snd_scale( soundobject, "pitch", pitch, time, curve, callbackfunc );
}

// Namespace snd/snd
// Params 1
// Checksum 0xc7d5f1c6, Offset: 0x3380
// Size: 0xba
function function_7308d4d0( soundobject )
{
    if ( function_81fac19d( isdefined( soundobject ) == 0, "snd_scale: called on undefined entity" ) )
    {
        return 0;
    }
    
    if ( function_81fac19d( function_3132f113( soundobject ) == 1, "snd_scale: called on removed entity" ) )
    {
        return 0;
    }
    
    assert( isdefined( soundobject ) == 1 );
    return function_2530f85d( soundobject, &function_5803da43 );
}

// Namespace snd/snd
// Params 1
// Checksum 0x324669e2, Offset: 0x3448
// Size: 0xba
function function_6f94855d( soundobject )
{
    if ( function_81fac19d( isdefined( soundobject ) == 0, "snd_scale: called on undefined entity" ) )
    {
        return 0;
    }
    
    if ( function_81fac19d( function_3132f113( soundobject ) == 1, "snd_scale: called on removed entity" ) )
    {
        return 0;
    }
    
    assert( isdefined( soundobject ) == 1 );
    return function_2530f85d( soundobject, &function_d7b79aea );
}

// Namespace snd/snd
// Params 0, eflags: 0x4
// Checksum 0xf248a3b8, Offset: 0x3510
// Size: 0x32
function private function_959bbfdb()
{
    player = self;
    vieworigin = player getcampos();
    return vieworigin;
}

// Namespace snd/snd
// Params 0, eflags: 0x4
// Checksum 0xb47f43ad, Offset: 0x3550
// Size: 0x32
function private function_2c0c5fbc()
{
    player = self;
    viewangles = player getcamangles();
    return viewangles;
}

// Namespace snd/snd
// Params 0, eflags: 0x4
// Checksum 0x1820bbb6, Offset: 0x3590
// Size: 0x32
function private function_bf76eea3()
{
    player = self;
    fov = player function_9169401e();
    return fov;
}

/#

    // Namespace snd/snd
    // Params 2, eflags: 0x4
    // Checksum 0x68f011c8, Offset: 0x35d0
    // Size: 0x226, Type: dev
    function private function_360bb421( key, value )
    {
        values = strtok( value, "<dev string:x1ec>" );
        
        if ( isarray( values ) && values.size > 0 )
        {
            contextkey = values[ 0 ];
            contextvalue = function_ea2f17d1( values[ 1 ], "<dev string:x58>" );
            var_23614cc2 = function_ea2f17d1( values[ 2 ], 0 );
            
            if ( key == "<dev string:x38>" )
            {
                iprintlnbold( "<dev string:x1f3>" + "<dev string:x1fe>" + contextkey + "<dev string:x204>" + contextvalue + "<dev string:x9b>" );
                setsoundcontext( contextkey, contextvalue );
            }
            else if ( key == "<dev string:x5c>" )
            {
                iprintlnbold( "<dev string:x20d>" + "<dev string:x1fe>" + contextkey + "<dev string:x204>" + contextvalue + "<dev string:x9b>" );
                
                foreach ( player in getplayerssafe() )
                {
                    player setsoundentcontext( contextkey, contextvalue );
                }
            }
        }
        
        return value;
    }

#/
