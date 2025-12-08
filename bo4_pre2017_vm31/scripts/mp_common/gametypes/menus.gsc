#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/player_role;
#using scripts/core_common/rank_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/mp_common/draft;
#using scripts/mp_common/gametypes/globallogic;
#using scripts/mp_common/util;

#namespace menus;

// Namespace menus/menus
// Params 0, eflags: 0x2
// Checksum 0xa680d3a0, Offset: 0x3f0
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "menus", &__init__, undefined, undefined );
}

// Namespace menus/menus
// Params 0
// Checksum 0x2c1a460e, Offset: 0x430
// Size: 0x44
function __init__()
{
    callback::on_start_gametype( &init );
    callback::on_connect( &on_player_connect );
}

// Namespace menus/menus
// Params 0
// Checksum 0xff5cd718, Offset: 0x480
// Size: 0x252
function init()
{
    game.menu = [];
    game.menu[ "menu_start_menu" ] = "StartMenu_Main";
    game.menu[ "menu_team" ] = "ChangeTeam";
    game.menu[ "menu_class" ] = "class";
    
    if ( getdvarint( "mp_prototype" ) != 0 )
    {
        game.menu[ "menu_changeclass" ] = "PositionDraft";
        game.menu[ "menu_changeclass_offline" ] = "PositionDraft";
    }
    else
    {
        game.menu[ "menu_changeclass" ] = "ChooseClass_InGame";
        game.menu[ "menu_changeclass_offline" ] = "ChooseClass_InGame";
    }
    
    foreach ( team in level.teams )
    {
        if ( getdvarint( "mp_prototype" ) != 0 )
        {
            game.menu[ "menu_changeclass_" + team ] = "PositionDraft";
            continue;
        }
        
        game.menu[ "menu_changeclass_" + team ] = "ChooseClass_InGame";
    }
    
    game.menu[ "menu_controls" ] = "ingame_controls";
    game.menu[ "menu_options" ] = "ingame_options";
    game.menu[ "menu_leavegame" ] = "popup_leavegame";
}

// Namespace menus/menus
// Params 0
// Checksum 0x44ce79c7, Offset: 0x6e0
// Size: 0x24
function on_player_connect()
{
    self.menu_response_callbacks = [];
    self thread on_menu_response();
}

// Namespace menus/menus
// Params 0
// Checksum 0x6c393ddc, Offset: 0x710
// Size: 0x6f8
function on_menu_response()
{
    self endon( #"disconnect" );
    
    for ( ;; )
    {
        waitresult = self waittill( "menuresponse" );
        menu = waitresult.menu;
        args = strtok( waitresult.response, "," );
        response = args[ 0 ];
        
        if ( isdefined( self.menu_response_callbacks[ menu ] ) )
        {
            self thread [[ self.menu_response_callbacks[ menu ] ]]( waitresult.response );
        }
        
        if ( response == "back" )
        {
            self closeingamemenu();
            
            if ( level.console )
            {
                if ( menu == game.menu[ "menu_changeclass" ] || menu == game.menu[ "menu_changeclass_offline" ] || menu == game.menu[ "menu_team" ] || menu == game.menu[ "menu_controls" ] )
                {
                    if ( isdefined( level.teams[ self.pers[ "team" ] ] ) )
                    {
                        self openmenu( game.menu[ "menu_start_menu" ] );
                    }
                }
            }
            
            continue;
        }
        
        if ( response == "changeteam" && level.allow_teamchange == "1" )
        {
            self closeingamemenu();
            self openmenu( game.menu[ "menu_team" ] );
        }
        
        if ( response == "endgame" )
        {
            if ( level.splitscreen )
            {
                level.skipvote = 1;
                
                if ( !level.gameended )
                {
                    level thread globallogic::forceend();
                }
            }
            
            continue;
        }
        
        if ( response == "killserverpc" )
        {
            level thread globallogic::killserverpc();
            continue;
        }
        
        if ( response == "endround" )
        {
            if ( !level.gameended )
            {
                self globallogic::gamehistoryplayerquit();
                level thread globallogic::forceend();
            }
            else
            {
                self closeingamemenu();
                self iprintln( &"MP_HOST_ENDGAME_RESPONSE" );
            }
            
            continue;
        }
        
        if ( response == "autocontrol" )
        {
            self [[ level.autocontrolplayer ]]();
            continue;
        }
        
        if ( menu == game.menu[ "menu_team" ] && level.allow_teamchange == "1" )
        {
            switch ( response )
            {
                case #"autoassign":
                    self [[ level.autoassign ]]( 1 );
                    break;
                case #"spectator":
                    self [[ level.spectator ]]();
                    break;
                default:
                    self [[ level.teammenu ]]( response );
                    break;
            }
            
            continue;
        }
        
        if ( menu == game.menu[ "menu_changeclass" ] || menu == game.menu[ "menu_changeclass_offline" ] )
        {
            if ( response == "changecharacter" || response == "randomcharacter" || response == "opendraft" || response == "closedraft" )
            {
                self [[ level.draftmenu ]]( response );
            }
            else if ( response == "weapon_updated" )
            {
                itemname = args[ 1 ];
                self iprintlnbold( game.strings[ "item_on_respawn" ], makelocalizedstring( itemname ) );
            }
            else if ( response != "cancel" )
            {
                if ( getdvarint( "mp_prototype" ) == 0 )
                {
                    self closeingamemenu();
                }
                
                if ( issubstr( response, "draft" ) )
                {
                    characterindex = int( getsubstr( response, 5 ) );
                    draft::select_character( characterindex );
                    continue;
                }
                
                if ( level.rankedmatch && issubstr( response, "custom" ) )
                {
                    if ( self isitemlocked( rank::getitemindex( "feature_cac" ) ) )
                    {
                        kick( self getentitynumber() );
                    }
                }
                
                self [[ level.curclass ]]( response, undefined, 1 );
            }
            
            continue;
        }
        
        if ( menu == "spectate" )
        {
            player = util::getplayerfromclientnum( int( response ) );
            
            if ( isdefined( player ) )
            {
                self setcurrentspectatorclient( player );
            }
        }
    }
}

// Namespace menus/menus
// Params 2
// Checksum 0xdab829e2, Offset: 0xe10
// Size: 0x46
function register_menu_response_callback( menu, callback )
{
    if ( !isdefined( self.menu_response_callbacks ) )
    {
        self.menu_response_callbacks = [];
    }
    
    self.menu_response_callbacks[ menu ] = callback;
}

