#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/player_role;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/mp_common/gametypes/globallogic;
#using scripts/mp_common/gametypes/globallogic_audio;
#using scripts/mp_common/gametypes/globallogic_player;
#using scripts/mp_common/gametypes/globallogic_spawn;
#using scripts/mp_common/gametypes/loadout;

#namespace draft;

// Namespace draft/draft
// Params 0, eflags: 0x2
// Checksum 0xbbf3bf1b, Offset: 0x3a8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "draft", &__init__, undefined, undefined );
}

// Namespace draft/draft
// Params 0
// Checksum 0xba123920, Offset: 0x3e8
// Size: 0xd4
function __init__()
{
    clientfield::register( "world", "draft", 1, 3, "int" );
    clientfield::register( "clientuimodel", "PositionDraft.stage", 1, 3, "int" );
    clientfield::register( "clientuimodel", "PositionDraft.autoSelected", 1, 1, "int" );
    clientfield::register( "worlduimodel", "PositionDraft.timeRemaining", 1, 7, "int" );
    level.draftstage = 0;
}

// Namespace draft/draft
// Params 0
// Checksum 0xaadb73bf, Offset: 0x4c8
// Size: 0x92
function is_enabled()
{
    if ( getdvarint( "mp_prototype", 0 ) == 0 )
    {
        return 0;
    }
    
    autoselectcharacter = getdvarint( "auto_select_character", -1 );
    
    if ( player_role::is_valid( autoselectcharacter ) )
    {
        return 0;
    }
    
    if ( level.disableclassselection )
    {
        return 0;
    }
    
    return getgametypesetting( "draftEnabled" );
}

// Namespace draft/draft
// Params 0
// Checksum 0x940a977f, Offset: 0x568
// Size: 0x6a, Type: bool
function is_draft_this_round()
{
    if ( !is_enabled() )
    {
        return false;
    }
    
    if ( getgametypesetting( "draftEveryRound" ) == 1 )
    {
        return true;
    }
    
    if ( util::isoneround() )
    {
        return true;
    }
    
    return util::isfirstround();
}

// Namespace draft/draft
// Params 1
// Checksum 0xa4a894de, Offset: 0x5e0
// Size: 0x15e, Type: bool
function can_select_character( characterindex )
{
    maxuniqueroles = getgametypesetting( "maxUniqueRolesPerTeam", characterindex );
    rolecount = 0;
    
    foreach ( player in level.players )
    {
        if ( player == self )
        {
            continue;
        }
        
        playercharacterindex = player player_role::get();
        
        if ( isdefined( player.pers[ "team" ] ) && player.pers[ "team" ] == self.pers[ "team" ] && playercharacterindex == characterindex )
        {
            rolecount++;
            
            if ( rolecount >= maxuniqueroles )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Namespace draft/draft
// Params 2
// Checksum 0xb5d5e4b6, Offset: 0x748
// Size: 0xf6, Type: bool
function select_character( characterindex, forceselection )
{
    assert( player_role::is_valid( characterindex ) );
    
    if ( !( isdefined( forceselection ) && forceselection ) && !can_select_character( characterindex ) )
    {
        return false;
    }
    
    if ( self player_role::set( characterindex ) )
    {
        if ( level.draftstage == 0 )
        {
            self close();
        }
        
        return true;
    }
    else
    {
        self player_role::clear();
        self util::clientnotify( "PositionDraft_Reject" );
    }
    
    return false;
}

// Namespace draft/draft
// Params 0
// Checksum 0xbd26d549, Offset: 0x848
// Size: 0xd2
function draft_initialize()
{
    level.inprematchperiod = 1;
    globallogic::mpintro_visionset_activate_func();
    level thread globallogic::sndsetmatchsnapshot( 1 );
    
    foreach ( player in level.players )
    {
        player clientfield::set_player_uimodel( "PositionDraft.autoSelected", 0 );
    }
}

// Namespace draft/draft
// Params 0
// Checksum 0xfb475865, Offset: 0x928
// Size: 0x44e
function wait_for_players()
{
    starttime = gettime();
    ready = 0;
    required = getgametypesetting( "draftRequiredClients" );
    
    if ( required <= 0 )
    {
        foreach ( player in level.players )
        {
            if ( player getconnectionstate() == 11 )
            {
                return;
            }
            
            wait 1;
        }
    }
    
    while ( !ready )
    {
        foreach ( team in level.teams )
        {
            teamcount[ team ] = 0;
        }
        
        foreach ( player in level.players )
        {
            if ( isdefined( level.teams[ player.team ] ) && player getconnectionstate() == 11 )
            {
                teamcount[ player.team ]++;
            }
        }
        
        ready = 1;
        
        foreach ( team in level.teams )
        {
            if ( teamcount[ team ] < required )
            {
                ready = 0;
            }
        }
        
        if ( !ready && gettime() - starttime > 120000 )
        {
            println( "<dev string:x28>" + required + "<dev string:x39>" );
            globallogic::exit_level();
            
            while ( true )
            {
                wait 10;
            }
        }
        
        /#
            println( "<dev string:x77>" + required + "<dev string:x8b>" );
            
            foreach ( team in level.teams )
            {
                println( "<dev string:x9e>" + team + "<dev string:xac>" + teamcount[ team ] );
            }
            
            println( "<dev string:xb5>" + ready );
        #/
        
        waitframe( 1 );
    }
}

// Namespace draft/draft
// Params 1
// Checksum 0x17c1c67f, Offset: 0xd80
// Size: 0x42
function decrement( timeremaining )
{
    /#
        if ( getdvarint( "<dev string:xc4>", 0 ) != 0 )
        {
            return timeremaining;
        }
    #/
    
    return timeremaining - 1;
}

// Namespace draft/draft
// Params 0
// Checksum 0x573e022b, Offset: 0xdd0
// Size: 0x1cc
function draft_run()
{
    timeremaining = getgametypesetting( "draftTime" );
    
    if ( timeremaining == 0 )
    {
        level clientfield::set_world_uimodel( "PositionDraft.timeRemaining", 0 );
        ready = 0;
        
        while ( !ready )
        {
            ready = 1;
            
            foreach ( player in level.players )
            {
                if ( player.pers[ "team" ] == "spectator" )
                {
                    continue;
                }
                
                characterindex = player player_role::get();
                
                if ( !player_role::is_valid( characterindex ) )
                {
                    ready = 0;
                }
            }
            
            wait 1;
        }
        
        return;
    }
    
    while ( timeremaining > 0 && !level.gameended )
    {
        level clientfield::set_world_uimodel( "PositionDraft.timeRemaining", timeremaining );
        timeremaining = decrement( timeremaining );
        wait 1;
    }
}

// Namespace draft/draft
// Params 3
// Checksum 0x226f29d, Offset: 0xfa8
// Size: 0x2a, Type: bool
function sort_categories( left, right, param )
{
    return left.size > right.size;
}

// Namespace draft/draft
// Params 1
// Checksum 0x7c8094db, Offset: 0xfe0
// Size: 0xb48
function assign_remaining_players( only_assign_player )
{
    teams = [];
    characters = [];
    validcharacters = [];
    categorymap = [];
    playerroletemplatecount = getplayerroletemplatecount( currentsessionmode() );
    
    for ( i = 0; i < playerroletemplatecount ; i++ )
    {
        characters[ i ] = spawnstruct();
        characters[ i ].index = i;
        characters[ i ].available = 0;
        characters[ i ].category = player_role::get_category_for_index( i );
        
        if ( player_role::is_valid( i ) && characters[ i ].category != "default" )
        {
            characters[ i ].available = 1;
            
            if ( !isdefined( validcharacters ) )
            {
                validcharacters = [];
            }
            else if ( !isarray( validcharacters ) )
            {
                validcharacters = array( validcharacters );
            }
            
            validcharacters[ validcharacters.size ] = characters[ i ];
            
            if ( !isdefined( categorymap[ characters[ i ].category ] ) )
            {
                categorymap[ characters[ i ].category ] = categorymap.size;
            }
        }
    }
    
    foreach ( player in level.players )
    {
        if ( player.pers[ "team" ] == "spectator" )
        {
            continue;
        }
        
        if ( !isdefined( teams[ player.team ] ) )
        {
            teams[ player.team ] = [];
        }
        
        if ( !isdefined( teams[ player.team ] ) )
        {
            teams[ player.team ] = [];
        }
        else if ( !isarray( teams[ player.team ] ) )
        {
            teams[ player.team ] = array( teams[ player.team ] );
        }
        
        teams[ player.team ][ teams[ player.team ].size ] = player;
    }
    
    foreach ( team in teams )
    {
        println( "<dev string:xd0>" + team[ 0 ].team );
        playersneedingassignment = [];
        
        foreach ( character in characters )
        {
            character.available = 1;
        }
        
        /#
            println( "<dev string:xfe>" );
            
            foreach ( player in team )
            {
                characterindex = player player_role::get();
                println( "<dev string:x119>" + player.name + "<dev string:x129>" + characterindex );
            }
        #/
        
        foreach ( player in team )
        {
            characterindex = player player_role::get();
            
            if ( player_role::is_valid( characterindex ) )
            {
                characters[ characterindex ].available = 0;
                continue;
            }
            
            if ( !isdefined( only_assign_player ) )
            {
                player player_role::clear();
                
                if ( !isdefined( playersneedingassignment ) )
                {
                    playersneedingassignment = [];
                }
                else if ( !isarray( playersneedingassignment ) )
                {
                    playersneedingassignment = array( playersneedingassignment );
                }
                
                playersneedingassignment[ playersneedingassignment.size ] = player;
                player clientfield::set_player_uimodel( "PositionDraft.autoSelected", 1 );
                continue;
            }
            
            if ( only_assign_player == player )
            {
                player player_role::clear();
                
                if ( !isdefined( playersneedingassignment ) )
                {
                    playersneedingassignment = [];
                }
                else if ( !isarray( playersneedingassignment ) )
                {
                    playersneedingassignment = array( playersneedingassignment );
                }
                
                playersneedingassignment[ playersneedingassignment.size ] = player;
            }
        }
        
        println( "<dev string:x13c>" );
        
        foreach ( player in playersneedingassignment )
        {
            categories = [];
            categorynames = getarraykeys( categorymap );
            
            for ( i = 0; i < categorymap.size ; i++ )
            {
                categories[ i ] = [];
            }
            
            foreach ( character in characters )
            {
                if ( character.category == "default" )
                {
                    continue;
                }
                
                if ( character.available == 1 )
                {
                    categoryindex = categorymap[ character.category ];
                    
                    if ( !isdefined( categories[ categoryindex ] ) )
                    {
                        categories[ categoryindex ] = [];
                    }
                    else if ( !isarray( categories[ categoryindex ] ) )
                    {
                        categories[ categoryindex ] = array( categories[ categoryindex ] );
                    }
                    
                    categories[ categoryindex ][ categories[ categoryindex ].size ] = character.index;
                }
            }
            
            categories = array::randomize( categories );
            categories = array::merge_sort( categories, &sort_categories );
            selectedcategory = categories[ 0 ];
            selectedcharacter = array::random( selectedcategory );
            
            if ( !isdefined( selectedcharacter ) )
            {
                randomcharacter = array::random( validcharacters );
                selectedcharacter = randomcharacter.index;
            }
            
            oldspecialistindex = player getspecialistindex();
            
            if ( isdefined( oldspecialistindex ) && oldspecialistindex != selectedcharacter )
            {
                player.pers[ "class" ] = undefined;
            }
            
            println( "<dev string:x15d>" + player.name + "<dev string:x177>" + selectedcharacter );
            
            if ( player select_character( selectedcharacter, 1 ) )
            {
                characters[ selectedcharacter ].available = 0;
            }
        }
    }
}

// Namespace draft/draft
// Params 0
// Checksum 0x41b4f27f, Offset: 0x1b30
// Size: 0x194
function game_start()
{
    timeremaining = level.prematchperiod;
    
    while ( timeremaining > 0 && !level.gameended )
    {
        level clientfield::set_world_uimodel( "PositionDraft.timeRemaining", timeremaining );
        
        if ( timeremaining == 3 )
        {
            level thread globallogic::sndsetmatchsnapshot( 0 );
            
            foreach ( player in level.players )
            {
                if ( player.hasspawned || player.pers[ "team" ] == "spectator" )
                {
                    player globallogic_audio::set_music_on_player( "spawnPreRise" );
                }
            }
        }
        
        if ( timeremaining == 2 )
        {
            globallogic::mpintro_visionset_deactivate_func();
        }
        
        timeremaining = decrement( timeremaining );
        wait 1;
    }
}

// Namespace draft/draft
// Params 0
// Checksum 0xd5e7cd12, Offset: 0x1cd0
// Size: 0x25c
function draft_finalize()
{
    level.inprematchperiod = 0;
    
    foreach ( player in level.players )
    {
        if ( player.sessionstate == "playing" )
        {
            println( "<dev string:x17d>" + player.name + "<dev string:x196>" + player.curclass + "<dev string:x19f>" + player getspecialistindex() );
            player loadout::giveloadout( player.team, player.curclass, 0 );
            player.pers[ "lastCurClass" ] = player.curclass;
            player.pers[ "lastSpecialistIndex" ] = player.curclass;
            player util::freeze_player_controls( 0 );
            player enableweapons();
        }
    }
    
    foreach ( player in level.players )
    {
        player clientfield::set_player_uimodel( "PositionDraft.autoSelected", 0 );
    }
    
    level notify( #"draft_complete" );
    set_draft_stage( 0 );
}

// Namespace draft/draft
// Params 1
// Checksum 0xbbabaa91, Offset: 0x1f38
// Size: 0x244
function set_draft_stage( draftstage )
{
    level.draftstage = draftstage;
    level clientfield::set( "draft", level.draftstage );
    
    /#
        if ( draftstage == 0 )
        {
            println( "<dev string:x1b1>" );
        }
        else if ( draftstage == 1 )
        {
            println( "<dev string:x1c4>" );
        }
        else if ( draftstage == 2 )
        {
            println( "<dev string:x1dd>" );
        }
        else if ( draftstage == 3 )
        {
            println( "<dev string:x1ff>" );
        }
        else if ( draftstage == 4 )
        {
            println( "<dev string:x213>" );
        }
        else if ( draftstage == 5 )
        {
            println( "<dev string:x22c>" );
        }
        else if ( draftstage == 6 )
        {
            println( "<dev string:x245>" );
        }
    #/
    
    if ( draftstage == 1 )
    {
        draft_initialize();
        return;
    }
    
    if ( draftstage == 2 )
    {
        wait_for_players();
        return;
    }
    
    if ( draftstage == 3 )
    {
        draft_run();
        return;
    }
    
    if ( draftstage == 4 )
    {
        assign_remaining_players();
        return;
    }
    
    if ( draftstage == 5 )
    {
        game_start();
        return;
    }
    
    if ( draftstage == 6 )
    {
        draft_finalize();
    }
}

// Namespace draft/draft
// Params 0
// Checksum 0x33ce5daf, Offset: 0x2188
// Size: 0x2c
function watch_game_ended()
{
    level waittill( "game_ended" );
    set_draft_stage( 6 );
}

// Namespace draft/draft
// Params 0
// Checksum 0x143a90dd, Offset: 0x21c0
// Size: 0xdc
function start()
{
    level endon( #"game_ended" );
    level thread watch_game_ended();
    waitframe( 1 );
    println( "<dev string:x25c>" );
    set_draft_stage( 1 );
    set_draft_stage( 2 );
    set_draft_stage( 3 );
    set_draft_stage( 4 );
    set_draft_stage( 5 );
    set_draft_stage( 6 );
}

// Namespace draft/draft
// Params 0
// Checksum 0x2fb25be1, Offset: 0x22a8
// Size: 0xd4
function open()
{
    player = self;
    assert( isplayer( self ) );
    
    /#
        autoselection = getdvarint( "<dev string:x269>", -1 );
        
        if ( player_role::is_valid( autoselection ) )
        {
            player player_role::set( autoselection );
            return;
        }
    #/
    
    player player_role::clear();
    player clientfield::set_player_uimodel( "PositionDraft.stage", 3 );
}

// Namespace draft/draft
// Params 0
// Checksum 0x81d40a8b, Offset: 0x2388
// Size: 0x24
function close()
{
    self clientfield::set_player_uimodel( "PositionDraft.stage", 0 );
}

