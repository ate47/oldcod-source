#using script_198f1b397865a5ad;
#using script_3dc93ca9902a9cda;
#using scripts\core_common\array_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\snd_debug;
#using scripts\cp_common\snd_draw;
#using scripts\cp_common\snd_utility;

#namespace snd;

// Namespace snd/snd
// Params 0, eflags: 0x6
// Checksum 0xb6625cd, Offset: 0x280
// Size: 0x19a
function private autoexec function_4047919b()
{
    if ( !isdefined( level._snd ) )
    {
        level._snd = spawnstruct();
        level._snd.var_2dd09170 = 1;
        level._snd._callbacks = [];
        level._snd.var_3cc765a3 = [];
        level._snd.var_92f63ad0 = [];
        level._snd.var_d37e94ca = #"gentity";
        level._snd.var_90903fc0 = 0;
        level._snd._callbacks[ #"player_view" ] = &function_9d361345;
        level._snd._callbacks[ #"player_angles" ] = &function_d33afb70;
        level._snd._callbacks[ #"player_fov" ] = &function_51436f04;
    }
    
    util::registerclientsys( "clientSoundCommand" );
    function_3ffa0089();
    
    /#
        function_ce893a25();
    #/
    
    waittillframeend();
    level._snd.isinitialized = 1;
}

// Namespace snd/snd
// Params 2
// Checksum 0x1b1930bf, Offset: 0x428
// Size: 0x248
function client_msg( msg, players )
{
    var_9077d19c = isstring( msg ) && msg.size > 0 || ishash( msg );
    
    if ( function_81fac19d( !var_9077d19c, "snd_client_msg must be a string or hash" ) )
    {
        return;
    }
    
    assert( var_9077d19c );
    state = "";
    
    if ( ishash( msg ) )
    {
        state = "# " + msg;
    }
    else if ( isstring( msg ) )
    {
        if ( function_81fac19d( msg.size > 16, "snd: client_msg > 16 chars " + function_783b69( msg, "'" ) ) )
        {
            /#
                if ( function_f984063f() )
                {
                    debugbreak();
                }
            #/
        }
        
        state = "M " + msg;
    }
    
    players = function_ea2f17d1( players, getplayerssafe() );
    
    foreach ( player in function_f218bff5( players ) )
    {
        util::setclientsysstate( "clientSoundCommand", state, player );
    }
}

// Namespace snd/snd
// Params 2
// Checksum 0xf25e2abf, Offset: 0x678
// Size: 0x1c8
function client_targetname( ent, targetname )
{
    isvalidtarget = isentity( ent );
    
    if ( function_81fac19d( !isvalidtarget, "snd_client_targetname is not an entity" ) )
    {
        return;
    }
    
    assert( isvalidtarget );
    targetname = function_ea2f17d1( targetname, ent.targetname );
    
    if ( function_81fac19d( !isdefined( targetname ), "snd_client_targetname targetname is undefined" ) )
    {
        return;
    }
    
    assert( isdefined( targetname ) );
    entitynumber = ent getentitynumber();
    state = "T " + entitynumber + " " + targetname;
    players = getplayerssafe();
    
    foreach ( player in players )
    {
        util::setclientsysstate( "clientSoundCommand", state, player );
    }
}

// Namespace snd/snd
// Params 2
// Checksum 0x29616089, Offset: 0x848
// Size: 0x21c
function client_voice( ent, soundalias )
{
    isvalidtarget = isentity( ent );
    
    if ( function_81fac19d( !isvalidtarget, "snd client_vo was not given an entity" ) )
    {
        return 0;
    }
    
    assert( isvalidtarget );
    var_3dd9dcff = soundexists( soundalias );
    
    if ( function_81fac19d( isdefined( soundalias ) && !var_3dd9dcff, "snd client_vo alias does not exist: " + soundalias ) )
    {
        return 0;
    }
    
    entitynumber = ent getentitynumber();
    state = "V " + entitynumber;
    players = getplayerssafe();
    
    if ( var_3dd9dcff )
    {
        state += " " + soundalias;
    }
    
    foreach ( player in players )
    {
        util::setclientsysstate( "clientSoundCommand", state, player );
    }
    
    waittime = 0;
    
    if ( var_3dd9dcff )
    {
        waittime = soundgetplaybacktime( soundalias );
        waittime /= 1000;
    }
    
    return waittime;
}

#namespace namespace_afa8e18b;

// Namespace namespace_afa8e18b/snd
// Params 4
// Checksum 0x5d46da89, Offset: 0xa70
// Size: 0x188
function function_b5959278( ent, var_1d25915, linkedentity, linkedbonetag )
{
    assert( isdefined( ent ), "<dev string:x38>" );
    assert( isdefined( ent.soundkey ), "<dev string:x52>" );
    
    if ( isdefined( linkedentity ) )
    {
        linkedbonetag = linkedentity snd::gettagsafe( linkedbonetag );
        linkedoffset = ( 0, 0, 0 );
        linkedangles = ( 0, 0, 0 );
        
        if ( isdefined( var_1d25915 ) )
        {
            linkedoffset = var_1d25915;
        }
        
        assert( isdefined( linkedbonetag ), "<dev string:x6d>" );
        
        if ( linkedbonetag == "tag_origin" )
        {
            linkedbonetag = "";
        }
        
        ent enablelinkto();
        ent linkto( linkedentity, linkedbonetag, linkedoffset, linkedangles );
        
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
// Checksum 0x41dbb8e2, Offset: 0xc00
// Size: 0x206
function function_85daf9f0( soundalias, var_1d25915, linkedentity, linkedbonetag )
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
        ent = spawn( "script_model", spawnorigin );
        ent setmodel( "tag_origin" );
    }
    else
    {
        ent = spawn( "script_origin", spawnorigin );
    }
    
    assert( isdefined( ent ), "<dev string:x8d>" );
    ent.soundlinkedentity = linkedentity;
    ent.soundtype = #"gentity";
    ent.soundkey = ent getentitynumber();
    ent.targetname = "snd " + soundalias;
    return ent;
}

// Namespace namespace_afa8e18b/snd
// Params 1
// Checksum 0xa3e5bc02, Offset: 0xe10
// Size: 0x174
function function_6ac5b570( ent )
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
// Checksum 0x95209e58, Offset: 0xf90
// Size: 0x2da
function function_2dde45d9( soundobject, soundalias, initialvolume, delaytime )
{
    ent = soundobject;
    currentvolume = undefined;
    ent endon( #"death" );
    assert( isdefined( ent ) );
    assert( isstring( soundalias ) );
    currentvolume = snd::get_volume( ent );
    
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
    
    assert( soundexists( soundalias ), "<dev string:xb5>" + soundalias );
    
    if ( soundislooping( soundalias ) == 1 )
    {
        ent playloopsound( soundalias );
    }
    else
    {
        donenotifystr = "sounddone";
        
        if ( sessionmodeiscampaigngame() )
        {
            ent playsoundwithnotify( soundalias, donenotifystr );
            ent thread function_bd8d70b0( donenotifystr );
        }
        else
        {
            if ( isdefined( ent.soundlinkedentity ) && isdefined( level._snd.fnplaysoundonmovingent ) )
            {
                waitframe( 1 );
                ent [[ level._snd.fnplaysoundonmovingent ]]( soundalias );
            }
            else
            {
                ent playsound( soundalias );
            }
            
            ent thread function_94954510( soundalias, donenotifystr );
        }
    }
    
    ent.soundalias = soundalias;
}

// Namespace namespace_afa8e18b/snd
// Params 2
// Checksum 0x75f4bc75, Offset: 0x1278
// Size: 0x19c
function function_9f156b27( soundobject, fadeoutseconds )
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
    fadeoutseconds = snd::function_ea2f17d1( fadeoutseconds, 0 );
    
    if ( isstring( soundalias ) )
    {
        if ( is_true( soundislooping( soundalias ) ) )
        {
            ent stoploopsound( fadeoutseconds );
        }
        else
        {
            ent stopsounds();
            ent stopsound( ent.soundalias );
        }
        
        waitframe( 1 );
        ent.soundalias = undefined;
    }
    
    ent.soundtype = undefined;
    function_6ac5b570( ent );
}

// Namespace namespace_afa8e18b/snd
// Params 2, eflags: 0x4
// Checksum 0x4fc23fa1, Offset: 0x1420
// Size: 0xa4
function private function_94954510( soundalias, done )
{
    ent = self;
    ent endon( #"death" );
    waittime = soundgetplaybacktime( soundalias );
    waittime *= 1.25;
    waittime /= 1000;
    wait waittime;
    ent notify( done, ent.soundalias );
    function_6ac5b570( ent );
}

// Namespace namespace_afa8e18b/snd
// Params 1, eflags: 0x4
// Checksum 0xf5000bb3, Offset: 0x14d0
// Size: 0x64
function private function_bd8d70b0( done )
{
    ent = self;
    ent endon( #"death" );
    ent waittill( done );
    ent notify( done, ent.soundalias );
    function_6ac5b570( ent );
}

/#

    // Namespace namespace_afa8e18b/snd
    // Params 4
    // Checksum 0x7680b6df, Offset: 0x1540
    // Size: 0x44, Type: dev
    function function_2761fc04( *ent, *var_1d25915, *linkedentity, *linkedbonetag )
    {
        assert( 0, "<dev string:xd3>" );
    }

#/

// Namespace namespace_afa8e18b/snd
// Params 4
// Checksum 0x805e574c, Offset: 0x1590
// Size: 0x46
function function_5275752c( *soundalias, *var_1d25915, *linkedentity, *linkedbonetag )
{
    assert( 0, "<dev string:xd3>" );
    return undefined;
}

/#

    // Namespace namespace_afa8e18b/snd
    // Params 1
    // Checksum 0x1eeb9ed2, Offset: 0x15e0
    // Size: 0x2c, Type: dev
    function function_bdc44456( *ent )
    {
        assert( 0, "<dev string:xd3>" );
    }

    // Namespace namespace_afa8e18b/snd
    // Params 4
    // Checksum 0x5b088fd6, Offset: 0x1618
    // Size: 0x44, Type: dev
    function function_bb749fc3( *soundobject, *soundalias, *initialvolume, *delaytime )
    {
        assert( 0, "<dev string:xd3>" );
    }

    // Namespace namespace_afa8e18b/snd
    // Params 2
    // Checksum 0x125ca746, Offset: 0x1668
    // Size: 0x34, Type: dev
    function function_273d939b( *soundobject, *fadeoutseconds )
    {
        assert( 0, "<dev string:xd3>" );
    }

#namespace snd;

#/

// Namespace snd/snd
// Params 0, eflags: 0x4
// Checksum 0xd205a335, Offset: 0x16a8
// Size: 0x32
function private function_9d361345()
{
    player = self;
    vieworigin = player getplayercamerapos();
    return vieworigin;
}

// Namespace snd/snd
// Params 0, eflags: 0x4
// Checksum 0xdac1e80e, Offset: 0x16e8
// Size: 0x32
function private function_d33afb70()
{
    player = self;
    viewangles = player getplayerangles();
    return viewangles;
}

// Namespace snd/snd
// Params 0, eflags: 0x4
// Checksum 0x7a03b736, Offset: 0x1728
// Size: 0x42
function private function_51436f04()
{
    player = self;
    fov = getdvarfloat( #"cg_fov", 65 );
    return fov;
}

// Namespace snd/snd
// Params 1, eflags: 0x4
// Checksum 0x93ca017, Offset: 0x1778
// Size: 0x34
function private function_7f94241b( ent )
{
    if ( ent == level )
    {
        ent = function_da785aa8()[ 0 ];
    }
    
    return ent;
}

// Namespace snd/snd
// Params 3
// Checksum 0x96f5c09a, Offset: 0x17b8
// Size: 0x126
function function_13246855( soundalias, notifystring, *player_or_team )
{
    ent = function_7f94241b( self );
    
    if ( !isentity( ent ) || issentient( ent ) && !isalive( ent ) )
    {
        return;
    }
    
    ent endon( #"death" );
    snd = play( notifystring, [ ent, "j_head" ] );
    stop_on_ent_death( snd, ent );
    
    if ( isdefined( player_or_team ) )
    {
        function_2fdc4fb( snd );
        ent notify( player_or_team );
    }
}

// Namespace snd/snd
// Params 1
// Checksum 0xb95631ab, Offset: 0x18e8
// Size: 0x44
function function_fb9b8ef4( soundalias )
{
    ent = function_7f94241b( self );
    stop_alias( soundalias, ent );
}

// Namespace snd/snd
// Params 3
// Checksum 0xbed7dcd5, Offset: 0x1938
// Size: 0xc4
function function_aeea7f5e( soundalias, notifystring, *player_or_team )
{
    ent = function_7f94241b( self );
    
    if ( !isentity( ent ) || issentient( ent ) && !isalive( ent ) )
    {
        return;
    }
    
    waittime = client_voice( ent, notifystring );
    
    if ( isdefined( player_or_team ) )
    {
        wait waittime;
        self notify( player_or_team );
    }
}

// Namespace snd/snd
// Params 1
// Checksum 0xc747ed93, Offset: 0x1a08
// Size: 0x44
function function_4264ab7c( *soundalias )
{
    ent = function_7f94241b( self );
    client_voice( ent );
}

