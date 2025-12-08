#using script_35ae72be7b4fec10;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\rank_shared;
#using scripts\core_common\system_shared;
#using scripts\cp_common\gametypes\globallogic;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\load;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;

#namespace menus;

// Namespace menus/menus
// Params 0, eflags: 0x6
// Checksum 0xa4a7e5ea, Offset: 0x340
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"menus", &preinit, undefined, undefined, undefined );
}

// Namespace menus/menus
// Params 0, eflags: 0x4
// Checksum 0x3f2eb8ef, Offset: 0x388
// Size: 0x44
function private preinit()
{
    callback::on_start_gametype( &init );
    callback::on_connect( &on_player_connect );
}

// Namespace menus/menus
// Params 0
// Checksum 0x99c7c65a, Offset: 0x3d8
// Size: 0x1bc
function init()
{
    game.menu = [];
    game.menu[ #"menu_team" ] = "ChangeTeam";
    game.menu[ #"menu_start_menu" ] = "StartMenu_Main";
    game.menu[ #"menu_class" ] = "class";
    game.menu[ #"menu_changeclass" ] = "mobile_armory_loadout";
    game.menu[ #"menu_changeclass_offline" ] = "mobile_armory_loadout";
    game.menu[ #"menu_draft" ] = "PositionDraft";
    
    foreach ( str_team in level.teams )
    {
        game.menu[ "menu_changeclass_" + str_team ] = "mobile_armory_loadout";
    }
    
    game.menu[ #"menu_controls" ] = "ingame_controls";
    game.menu[ #"menu_options" ] = "ingame_options";
    game.menu[ #"menu_leavegame" ] = "popup_leavegame";
}

// Namespace menus/menus
// Params 0
// Checksum 0x9e88a1d, Offset: 0x5a0
// Size: 0x1c
function on_player_connect()
{
    self thread on_menu_response();
}

// Namespace menus/menus
// Params 0
// Checksum 0xc99493b0, Offset: 0x5c8
// Size: 0xc68
function on_menu_response()
{
    self endon( #"disconnect" );
    
    for ( ;; )
    {
        waitresult = self waittill( #"menuresponse" );
        menu = waitresult.menu;
        response = waitresult.response;
        intpayload = waitresult.intpayload;
        
        if ( response == "back" )
        {
            self closeingamemenu();
            
            if ( level.console )
            {
                if ( menu == game.menu[ #"menu_changeclass" ] || menu == game.menu[ #"menu_changeclass_offline" ] || menu == game.menu[ #"menu_team" ] || menu == game.menu[ #"menu_controls" ] )
                {
                    if ( isdefined( level.teams[ self.pers[ #"team" ] ] ) )
                    {
                        self openmenu( game.menu_start_menu );
                    }
                }
            }
            
            continue;
        }
        
        if ( response == "changeteam" && level.allow_teamchange )
        {
            self closeingamemenu();
            self openmenu( game.menu[ #"menu_team" ] );
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
                self closeingamemenu();
                
                if ( self ishost() )
                {
                    foreach ( player in getplayers() )
                    {
                        var_a37e0b6f = player stats::get_stat( #"unlocks", 0 );
                        var_7ab22044 = player stats::get_stat( #"playerstatslist", #"hash_275f021a92a63aee", #"statvalue" );
                        
                        if ( var_a37e0b6f > var_7ab22044 )
                        {
                            player stats::function_dad108fa( #"hash_275f021a92a63aee", var_a37e0b6f - var_7ab22044 );
                        }
                    }
                    
                    uploadstats();
                    level thread globallogic::forceend();
                }
            }
            else
            {
                self closeingamemenu();
                self iprintln( #"mp/host_endgame_response" );
            }
            
            continue;
        }
        
        if ( response == #"first_snapshot" )
        {
            if ( level flag::get( #"hud_initialized" ) )
            {
                /#
                    globallogic_ui::function_3f278444();
                #/
                
                globallogic_ui::function_cdbb5c49( 0 );
            }
            
            level flag::set( #"hud_initialized" );
            continue;
        }
        
        if ( response == #"restartmission" )
        {
            player = getplayers()[ 0 ];
            player savegame::set_player_data( "saved_weapon", undefined );
            player savegame::set_player_data( "saved_weapon_attachemnts", undefined );
            player savegame::set_player_data( "saved_weapondata", undefined );
            player savegame::set_player_data( "lives", undefined );
            player savegame::set_player_data( "savegame_score", undefined );
            player savegame::set_player_data( "savegame_kills", undefined );
            player savegame::set_player_data( "savegame_assists", undefined );
            player savegame::set_player_data( "savegame_incaps", undefined );
            player savegame::set_player_data( "savegame_revives", undefined );
            player savegame::function_81534803( #"transient" );
            
            if ( !isdefined( getrootmapname() ) )
            {
                continue;
            }
            
            player clearallnoncheckpointdata();
            world.var_b86bf11e = undefined;
            globallogic_ui::function_760546ce();
            missionname = savegame::function_8136eb5a();
            mapbundle = getmapscriptbundle( missionname );
            
            if ( isdefined( mapbundle ) && isdefined( mapbundle.var_a04dfce6 ) )
            {
                var_a04dfce6 = mapbundle.var_a04dfce6;
                
                if ( var_a04dfce6 != "" )
                {
                    skipto::function_8722a51a( var_a04dfce6, 1 );
                    map_restart();
                }
            }
            else
            {
                missionrestart();
            }
            
            continue;
        }
        
        if ( response == #"restartcheckpoint" )
        {
            globallogic_ui::function_760546ce();
            globallogic_ui::function_cdbb5c49( 1 );
            level.var_5be43b2d = 1;
            function_f31af5ab();
            continue;
        }
        
        if ( response == #"hash_30abbfec4597c191" )
        {
            load::function_cc51116c( "cp_ger_hub" );
            continue;
        }
        
        if ( response == "autocontrol" )
        {
            self [[ level.autocontrolplayer ]]();
            continue;
        }
        
        if ( response == "typing_complete" )
        {
            level notify( #"typing_complete", { #line:intpayload } );
            continue;
        }
        
        if ( response == "personnel_profile_closed" )
        {
            level notify( #"personnel_profile_closed", { #isconfirmed:intpayload } );
            continue;
        }
        
        if ( response == "note_closed" )
        {
            level notify( #"note_closed" );
            continue;
        }
        
        if ( response == "evidence_board_option_selected" )
        {
            level notify( #"evidence_board_option_selected", { #optindex:intpayload } );
            continue;
        }
        
        if ( response == "mission_option_selected" )
        {
            level notify( #"mission_option_selected", { #optindex:intpayload } );
            continue;
        }
        
        if ( response == "dialog_tree_option_selected" )
        {
            level notify( #"dialog_tree_option_selected", { #optindex:intpayload } );
            continue;
        }
        
        if ( response == "lui_unpause_game" )
        {
            level notify( #"lui_unpause_game", { #success:intpayload == 1 } );
            continue;
        }
        
        if ( response == "objective_splash" && intpayload === 0 )
        {
            level notify( #"objectives_shown" );
            continue;
        }
        
        if ( response == #"lui_button" )
        {
            level notify( #"lui_button", { #button:"" + intpayload } );
            continue;
        }
        
        if ( menu == game.menu[ #"menu_team" ] && level.allow_teamchange )
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
        
        if ( menu == game.menu[ #"menu_draft" ] )
        {
            self [[ level.draftmenu ]]( response, intpayload );
            continue;
        }
        
        if ( menu == game.menu[ #"menu_changeclass" ] || menu == game.menu[ #"menu_changeclass_offline" ] )
        {
            if ( response != "back" && response != "cancel" && ( !isdefined( self.var_efc9bc54 ) || !self.var_efc9bc54 ) )
            {
                self closeingamemenu();
                self.selectedclass = 1;
                self [[ level.curclass ]]( response );
            }
            else
            {
                self [[ level.curclass ]]( response );
            }
            
            continue;
        }
        
        if ( menu == "spectate" )
        {
            player = util::getplayerfromclientnum( waitresult.intpayload );
            
            if ( isdefined( player ) )
            {
                self setcurrentspectatorclient( player );
            }
        }
    }
}

