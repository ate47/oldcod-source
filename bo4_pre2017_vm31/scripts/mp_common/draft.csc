#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/character_customization;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/duplicaterender_mgr;
#using scripts/core_common/end_game_taunts;
#using scripts/core_common/player_role;
#using scripts/core_common/scene_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/mp_common/draft;

#namespace draft;

// Namespace draft/draft
// Params 0, eflags: 0x2
// Checksum 0xacbe322c, Offset: 0x3e8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "draft", &__init__, undefined, undefined );
}

// Namespace draft/draft
// Params 0
// Checksum 0xcdf88263, Offset: 0x428
// Size: 0xc4
function __init__()
{
    clientfield::register( "world", "draft", 1, 3, "int", &handledraftstage, 0, 0 );
    clientfield::register( "worlduimodel", "PositionDraft.timeRemaining", 1, 7, "int", undefined, 0, 0 );
    level.var_5b6469a4 = [];
    level thread function_5571859f();
    level thread function_1ec0d0d3();
}

// Namespace draft/draft
// Params 1
// Checksum 0x8c09a142, Offset: 0x4f8
// Size: 0xb4, Type: bool
function is_valid( index )
{
    if ( !isdefined( index ) )
    {
        return false;
    }
    
    /#
        if ( getdvarint( "<dev string:x28>", 0 ) == 1 )
        {
            return ( index >= 0 && index < getplayerroletemplatecount( currentsessionmode() ) );
        }
    #/
    
    return index > 0 && index < getplayerroletemplatecount( currentsessionmode() );
}

// Namespace draft/draft
// Params 7
// Checksum 0x3c071569, Offset: 0x5b8
// Size: 0x8c
function handledraftstage( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( isdefined( newval ) )
    {
        setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "PositionDraft.stage" ), newval );
    }
}

// Namespace draft/draft
// Params 1
// Checksum 0x4e407ce7, Offset: 0x650
// Size: 0x5de
function function_f6420b95( localclientnum )
{
    println( "<dev string:x3c>" );
    localplayer = getlocalplayer( localclientnum );
    controllermodel = getuimodelforcontroller( localclientnum );
    positiondraftclientsmodel = getuimodel( controllermodel, "PositionDraftClients" );
    
    for ( i = 0; i < 5 ; i++ )
    {
        characterindex = 0;
        weapon = "";
        clientnum = -1;
        player = undefined;
        
        if ( isdefined( positiondraftclientsmodel ) )
        {
            luaindex = i + 1;
            positionmodel = getuimodel( positiondraftclientsmodel, luaindex );
            clientnum = getuimodelvalue( getuimodel( positionmodel, "clientNum" ) );
            
            if ( clientnum >= 0 )
            {
                player = getentbynum( localclientnum, clientnum );
                
                if ( isdefined( player ) )
                {
                    characterindex = player getselectedcharacterindex();
                    weapon = player getprimaryweapon();
                }
                
                if ( getpositionforlocalclient( localclientnum ) == i )
                {
                    positiondraftmodel = getuimodel( controllermodel, "PositionDraft" );
                    
                    if ( isdefined( positiondraftmodel ) )
                    {
                        focusedcharacterindex = getuimodelvalue( getuimodel( positiondraftmodel, "focusedCharacterIndex" ) );
                        focusedCharacterWeapon = getuimodelvalue( getuimodel( positiondraftmodel, "focusedCharacterWeapon" ) );
                        
                        if ( player_role::is_valid( focusedcharacterindex ) )
                        {
                            characterindex = focusedcharacterindex;
                            weapon = focusedCharacterWeapon;
                        }
                    }
                }
            }
        }
        
        params = spawnstruct();
        params.sessionmode = currentsessionmode();
        params.anim_name = end_game_taunts::function_466e285f( localclientnum, level.draftcharacters[ i ], i % 3 );
        level.draftcharacters[ i ].var_418b6e8a = 0;
        level.draftcharacters[ i ].var_8f9c1e31 = getweapon( "none" );
        level.draftcharacters[ i ].var_a7a58d47 = "";
        
        if ( player_role::is_valid( characterindex ) )
        {
            character_customization::function_d79d6d7( localclientnum, level.draftcharacters[ i ], characterindex, params );
            level.draftcharacters[ i ].charactermodel duplicate_render::set_entity_draft_unselected( localclientnum, 0 );
            
            if ( isdefined( weapon ) && weapon != "" )
            {
                level.draftcharacters[ i ].var_418b6e8a = 1;
                level.draftcharacters[ i ].var_8f9c1e31 = getweapon( weapon );
                level.draftcharacters[ i ].var_a7a58d47 = weapon;
                character_customization::function_5eb98c9a( level.draftcharacters[ i ] );
            }
        }
        else
        {
            character_customization::function_d79d6d7( localclientnum, level.draftcharacters[ i ], 1, params );
            level.draftcharacters[ i ].charactermodel duplicate_render::set_entity_draft_unselected( localclientnum, 1 );
        }
        
        character_customization::update( localclientnum, level.draftcharacters[ i ], params );
        println( "<dev string:x55>" + i + "<dev string:x6a>" + clientnum + "<dev string:x77>" + characterindex );
    }
}

// Namespace draft/draft
// Params 1
// Checksum 0x18e57173, Offset: 0xc38
// Size: 0x62
function getpositionforlocalclient( localclientnum )
{
    localclientmapping = [];
    localclientmapping[ 0 ] = 2;
    localclientmapping[ 1 ] = 1;
    localclientmapping[ 2 ] = 3;
    localclientmapping[ 3 ] = 0;
    return localclientmapping[ localclientnum ];
}

// Namespace draft/draft
// Params 1
// Checksum 0x6200c4f0, Offset: 0xca8
// Size: 0x80
function function_cf7a93f9( localclientnum )
{
    level endon( #"disconnect" );
    level endon( #"hash_f68db147" );
    
    while ( true )
    {
        level waittill( "PositionDraft_Reject" );
        println( "<dev string:x84>" );
        function_f6420b95( localclientnum );
    }
}

// Namespace draft/draft
// Params 1
// Checksum 0x3be3f381, Offset: 0xd30
// Size: 0x68
function watchupdate( localclientnum )
{
    level endon( #"disconnect" );
    level endon( #"hash_f68db147" );
    
    while ( true )
    {
        waitresult = level waittill( "PositionDraft_Update" );
        function_f6420b95( localclientnum );
    }
}

// Namespace draft/draft
// Params 1
// Checksum 0x24c97712, Offset: 0xda0
// Size: 0x250
function function_29c35eb9( localclientnum )
{
    level endon( #"disconnect" );
    level endon( #"hash_f68db147" );
    
    while ( true )
    {
        waitresult = level waittill( "PositionDraft_Loadout" );
        var_cb13ff74 = waitresult.param1;
        position = struct::get( "draft_team_struct", "targetname" );
        
        if ( var_cb13ff74 == "1" )
        {
            for ( i = 0; i < level.draftcharacters.size ; i++ )
            {
                if ( i != getpositionforlocalclient( localclientnum ) )
                {
                    level.draftcharacters[ i ].charactermodel hide();
                }
            }
            
            playmaincamxcam( localclientnum, "ui_cam_frontend_loadout_mp", 0, "cam_loadout_mp", "", position.origin, position.angles );
            continue;
        }
        
        foreach ( character in level.draftcharacters )
        {
            character.charactermodel show();
        }
        
        playmaincamxcam( localclientnum, level.draftxcamname, 0, "cam_draft_ingame", "", position.origin, position.angles );
    }
}

// Namespace draft/draft
// Params 0
// Checksum 0xb49ca14c, Offset: 0xff8
// Size: 0x58
function function_5571859f()
{
    level endon( #"disconnect" );
    
    while ( true )
    {
        waitresult = level waittill( "PositionDraft_Open" );
        function_aecd18e4( waitresult.localclientnum );
    }
}

// Namespace draft/draft
// Params 0
// Checksum 0xa203d656, Offset: 0x1058
// Size: 0x58
function function_1ec0d0d3()
{
    level endon( #"disconnect" );
    
    while ( true )
    {
        waitresult = level waittill( "PositionDraft_Close" );
        function_b137c2bd( waitresult.localclientnum );
    }
}

// Namespace draft/draft
// Params 1
// Checksum 0x7eaf9922, Offset: 0x10b8
// Size: 0x254
function function_73412cc4( localclientnum )
{
    level.draftcharacters = [];
    playerscriptstructs = [];
    
    for ( i = 0; i < 5 ; i++ )
    {
        playerscriptstructs[ i ] = struct::get( "draft_player_struct_" + i, "targetname" );
    }
    
    if ( playerscriptstructs.size != 5 )
    {
        println( "<dev string:xb0>" + 5 + "<dev string:xdc>" + playerscriptstructs.size );
        level.var_c228cbc2 = 1;
        return;
    }
    
    level.var_53cab23e = [];
    
    for ( i = 0; i < 18 ; i++ )
    {
        level.var_53cab23e[ i ] = -1;
    }
    
    foreach ( index, scriptstruct in playerscriptstructs )
    {
        model = util::spawn_model( localclientnum, "tag_origin", scriptstruct.origin, scriptstruct.angles );
        model.targetname = scriptstruct.targetname;
        level.draftcharacters[ index ] = character_customization::function_b79cb078( model, localclientnum, 0 );
    }
    
    level.draftintroplayed = 1;
    println( "<dev string:xe3>" );
}

// Namespace draft/draft
// Params 1
// Checksum 0x76967e01, Offset: 0x1318
// Size: 0x2b4
function function_aecd18e4( localclientnum )
{
    if ( isdefined( level.draftactive ) && level.draftactive )
    {
        return;
    }
    
    if ( !isdefined( level.draftxcamname ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_5b6469a4[ localclientnum ] ) )
    {
        function_73412cc4( localclientnum );
        level.var_5b6469a4[ localclientnum ] = 1;
    }
    
    if ( isdefined( level.var_c228cbc2 ) && level.var_c228cbc2 )
    {
        return;
    }
    
    println( "<dev string:x102>" );
    level thread watchupdate( localclientnum );
    level thread function_29c35eb9( localclientnum );
    level thread function_cf7a93f9( localclientnum );
    level.draftactive = 1;
    
    foreach ( character in level.draftcharacters )
    {
        character.charactermodel show();
    }
    
    function_f6420b95( localclientnum );
    position = struct::get( "draft_team_struct", "targetname" );
    
    if ( !level.draftintroplayed )
    {
        playmaincamxcam( localclientnum, level.draftxcamname, 0, "cam_draft_intro", "", position.origin, position.angles );
        level.draftintroplayed = 1;
        return;
    }
    
    playmaincamxcam( localclientnum, level.draftxcamname, 0, "cam_draft_ingame", "", position.origin, position.angles );
}

// Namespace draft/draft
// Params 1
// Checksum 0x1db822ab, Offset: 0x15d8
// Size: 0x13c
function function_b137c2bd( localclientnum )
{
    if ( !( isdefined( level.draftactive ) && level.draftactive ) )
    {
        return;
    }
    
    println( "<dev string:x11b>" );
    level notify( #"hash_f68db147" );
    
    foreach ( character in level.draftcharacters )
    {
        character.charactermodel duplicate_render::set_entity_draft_unselected( localclientnum, 0 );
        character.charactermodel hide();
    }
    
    stopmaincamxcam( localclientnum );
    level.draftactive = 0;
}

