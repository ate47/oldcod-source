#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/end_game_taunts;
#using scripts/core_common/scene_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace end_game_flow;

// Namespace end_game_flow/end_game_flow
// Params 0, eflags: 0x2
// Checksum 0x1a4b95cc, Offset: 0x300
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "end_game_flow", &__init__, undefined, undefined );
}

// Namespace end_game_flow/end_game_flow
// Params 0
// Checksum 0xb4901484, Offset: 0x340
// Size: 0x184
function __init__()
{
    clientfield::register( "world", "displayTop3Players", 1, 1, "int", &function_ae4f634e, 0, 0 );
    clientfield::register( "world", "triggerScoreboardCamera", 1, 1, "int", &showscoreboard, 0, 0 );
    clientfield::register( "world", "playTop0Gesture", 1000, 3, "int", &function_67142c9f, 0, 0 );
    clientfield::register( "world", "playTop1Gesture", 1000, 3, "int", &function_912ca9dc, 0, 0 );
    clientfield::register( "world", "playTop2Gesture", 1000, 3, "int", &function_10ad2f85, 0, 0 );
    level thread function_32cc2aa4();
}

#using_animtree( "all_player" );

// Namespace end_game_flow/end_game_flow
// Params 3
// Checksum 0x701d3629, Offset: 0x4d0
// Size: 0xbc
function function_2d7e91bf( localclientnum, charactermodel, var_c55b8047 )
{
    anim_name = end_game_taunts::function_466e285f( localclientnum, charactermodel, var_c55b8047 );
    
    if ( isdefined( anim_name ) )
    {
        charactermodel util::waittill_dobj( localclientnum );
        
        if ( !charactermodel hasanimtree() )
        {
            charactermodel useanimtree( #animtree );
        }
        
        charactermodel setanim( anim_name );
    }
}

// Namespace end_game_flow/end_game_flow
// Params 3
// Checksum 0x1a5c0680, Offset: 0x598
// Size: 0x464
function function_478d992c( localclientnum, charactermodel, var_c55b8047 )
{
    assert( isdefined( charactermodel ) );
    bodymodel = gettopplayersbodymodel( localclientnum, var_c55b8047 );
    var_e289d4b4 = createuimodel( getuimodelforcontroller( localclientnum ), "displayTopPlayer" + var_c55b8047 + 1 );
    setuimodelvalue( var_e289d4b4, 1 );
    
    if ( !isdefined( bodymodel ) || bodymodel == "" )
    {
        setuimodelvalue( var_e289d4b4, 0 );
        return;
    }
    
    charactermodel setmodel( bodymodel );
    helmetmodel = gettopplayershelmetmodel( localclientnum, var_c55b8047 );
    
    if ( !charactermodel isattached( helmetmodel, "" ) )
    {
        charactermodel.helmetmodel = helmetmodel;
        charactermodel attach( helmetmodel, "" );
    }
    
    var_957cc42 = getcharactermoderenderoptions( currentsessionmode() );
    var_6f30937d = gettopplayersbodyrenderoptions( localclientnum, var_c55b8047 );
    var_d44a8060 = gettopplayershelmetrenderoptions( localclientnum, var_c55b8047 );
    weaponrenderoptions = gettopplayersweaponrenderoptions( localclientnum, var_c55b8047 );
    charactermodel.bodymodel = bodymodel;
    charactermodel.var_957cc42 = var_957cc42;
    charactermodel.var_6f30937d = var_6f30937d;
    charactermodel.var_d44a8060 = var_d44a8060;
    charactermodel.var_ebda9e17 = var_d44a8060;
    weapon_right = gettopplayersweaponinfo( localclientnum, var_c55b8047 );
    
    if ( !isdefined( level.weaponnone ) )
    {
        level.weaponnone = getweapon( "none" );
    }
    
    charactermodel setbodyrenderoptions( var_957cc42, var_6f30937d, var_d44a8060, var_d44a8060 );
    
    if ( weapon_right[ "weapon" ] == level.weaponnone )
    {
        weapon_right[ "weapon" ] = getweapon( "ar_standard" );
        charactermodel.showcaseweapon = weapon_right[ "weapon" ];
        charactermodel attachweapon( weapon_right[ "weapon" ] );
        return;
    }
    
    charactermodel.showcaseweapon = weapon_right[ "weapon" ];
    charactermodel.var_7ff9e1d4 = weaponrenderoptions;
    charactermodel.var_4b073b25 = weapon_right[ "acvi" ];
    charactermodel attachweapon( weapon_right[ "weapon" ], weaponrenderoptions, weapon_right[ "acvi" ] );
    charactermodel useweaponhidetags( weapon_right[ "weapon" ] );
}

// Namespace end_game_flow/end_game_flow
// Params 3
// Checksum 0x6be4704, Offset: 0xa08
// Size: 0x6c
function function_d9779084( localclientnum, charactermodel, var_c55b8047 )
{
    charactermodel endon( #"death" );
    function_478d992c( localclientnum, charactermodel, var_c55b8047 );
    function_2d7e91bf( localclientnum, charactermodel, var_c55b8047 );
}

// Namespace end_game_flow/end_game_flow
// Params 1
// Checksum 0x8ae1e9b5, Offset: 0xa80
// Size: 0x126
function function_6b822cb1( localclientnum )
{
    numclients = gettopscorercount( localclientnum );
    position = struct::get( "endgame_top_players_struct", "targetname" );
    
    if ( !isdefined( position ) )
    {
        return;
    }
    
    for ( index = 0; index < 3 ; index++ )
    {
        if ( index < numclients )
        {
            model = spawn( localclientnum, position.origin, "script_model" );
            function_478d992c( localclientnum, model, index );
            model hide();
            model sethighdetail( 1 );
        }
    }
}

// Namespace end_game_flow/end_game_flow
// Params 1
// Checksum 0x7867db36, Offset: 0xbb0
// Size: 0x3cc
function function_edb35629( localclientnum )
{
    level.var_62c15215 = [];
    var_538e08ea = [];
    var_538e08ea[ 0 ] = struct::get( "TopPlayer1", "targetname" );
    var_538e08ea[ 1 ] = struct::get( "TopPlayer2", "targetname" );
    var_538e08ea[ 2 ] = struct::get( "TopPlayer3", "targetname" );
    
    foreach ( index, scriptstruct in var_538e08ea )
    {
        level.var_62c15215[ index ] = spawn( localclientnum, scriptstruct.origin, "script_model" );
        level.var_62c15215[ index ].angles = scriptstruct.angles;
    }
    
    numclients = gettopscorercount( localclientnum );
    
    foreach ( index, charactermodel in level.var_62c15215 )
    {
        if ( index < numclients )
        {
            thread function_d9779084( localclientnum, charactermodel, index );
            
            if ( index == 0 )
            {
                thread end_game_taunts::function_206ff6ca( localclientnum, charactermodel, index );
            }
        }
    }
    
    /#
        level thread end_game_taunts::function_93ddf1a2();
        level thread end_game_taunts::function_d90bdba7();
        level thread end_game_taunts::function_41f59618();
    #/
    
    position = struct::get( "endgame_top_players_struct", "targetname" );
    playmaincamxcam( localclientnum, level.endgamexcamname, 0, "cam_topscorers", "topscorers", position.origin, position.angles );
    playradiantexploder( localclientnum, "exploder_mp_endgame_lights" );
    
    if ( !isstreamerready() )
    {
        while ( !isstreamerready() )
        {
            waitframe( 1 );
        }
        
        wait 0.25;
    }
    
    setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "displayTop3Players" ), 1 );
    thread function_4d13985c( localclientnum );
}

// Namespace end_game_flow/end_game_flow
// Params 1
// Checksum 0xa49305c8, Offset: 0xf88
// Size: 0x76
function function_4d13985c( localclientnum )
{
    localplayers = getlocalplayers();
    
    for ( i = 0; i < localplayers.size ; i++ )
    {
        thread function_8bb13743( localclientnum, localplayers[ i ], i );
    }
}

// Namespace end_game_flow/end_game_flow
// Params 3
// Checksum 0xcb6746dc, Offset: 0x1008
// Size: 0xec
function function_8bb13743( localclientnum, localplayer, playerindex )
{
    var_678d2f60 = localplayer gettopplayersindex( localclientnum );
    
    if ( !isdefined( var_678d2f60 ) || !isdefined( level.var_62c15215 ) || var_678d2f60 >= level.var_62c15215.size )
    {
        return;
    }
    
    charactermodel = level.var_62c15215[ var_678d2f60 ];
    
    if ( var_678d2f60 > 0 )
    {
        wait 3;
    }
    else if ( isdefined( charactermodel.var_7ca854a3 ) )
    {
        charactermodel waittill( "tauntFinished" );
    }
    
    function_bf2df096( localclientnum, playerindex );
}

// Namespace end_game_flow/end_game_flow
// Params 2
// Checksum 0x386add53, Offset: 0x1100
// Size: 0x8c
function function_bf2df096( localclientnum, playerindex )
{
    var_c3201eac = getuimodel( getuimodelforcontroller( localclientnum ), "topPlayerInfo.showGestures" );
    
    if ( isdefined( var_c3201eac ) )
    {
        setuimodelvalue( var_c3201eac, 1 );
        allowactionslotinput( playerindex );
    }
}

// Namespace end_game_flow/end_game_flow
// Params 7
// Checksum 0x2f2be7c7, Offset: 0x1198
// Size: 0x5c
function function_67142c9f( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    function_5949cb92( localclientnum, 0, newval );
}

// Namespace end_game_flow/end_game_flow
// Params 7
// Checksum 0x51d77fd4, Offset: 0x1200
// Size: 0x5c
function function_912ca9dc( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    function_5949cb92( localclientnum, 1, newval );
}

// Namespace end_game_flow/end_game_flow
// Params 7
// Checksum 0xda308080, Offset: 0x1268
// Size: 0x5c
function function_10ad2f85( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    function_5949cb92( localclientnum, 2, newval );
}

// Namespace end_game_flow/end_game_flow
// Params 3
// Checksum 0x2d331041, Offset: 0x12d0
// Size: 0xd4
function function_5949cb92( localclientnum, var_c55b8047, gesturetype )
{
    if ( gesturetype > 2 || !isdefined( level.var_62c15215 ) || var_c55b8047 >= level.var_62c15215.size )
    {
        return;
    }
    
    charactermodel = level.var_62c15215[ var_c55b8047 ];
    
    if ( isdefined( charactermodel.var_1e465ba6 ) && ( isdefined( charactermodel.var_7ca854a3 ) || charactermodel.var_1e465ba6 ) )
    {
        return;
    }
    
    thread end_game_taunts::function_2794f71c( localclientnum, charactermodel, var_c55b8047, gesturetype );
}

// Namespace end_game_flow/end_game_flow
// Params 0
// Checksum 0xf270bb13, Offset: 0x13b0
// Size: 0x48
function function_32cc2aa4()
{
    while ( true )
    {
        waitresult = level waittill( "streamFKsl" );
        function_6b822cb1( waitresult.localclientnum );
    }
}

// Namespace end_game_flow/end_game_flow
// Params 7
// Checksum 0x112b6634, Offset: 0x1400
// Size: 0x8c
function function_ae4f634e( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( isdefined( newval ) && newval > 0 && isdefined( level.endgamexcamname ) )
    {
        level.showedtopthreeplayers = 1;
        function_edb35629( localclientnum );
    }
}

// Namespace end_game_flow/end_game_flow
// Params 7
// Checksum 0x86461d5d, Offset: 0x1498
// Size: 0x134
function showscoreboard( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( isdefined( newval ) && newval > 0 && isdefined( level.endgamexcamname ) )
    {
        position = struct::get( "endgame_top_players_struct", "targetname" );
        playmaincamxcam( localclientnum, level.endgamexcamname, 0, "cam_topscorers", "", position.origin, position.angles );
        setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "forceScoreboard" ), 1 );
        level.var_4104e7ed = 1;
    }
}

