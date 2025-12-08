#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/gameobjects_shared;
#using scripts/core_common/hostmigration_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/spectating;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/mp_common/gametypes/globallogic_audio;
#using scripts/mp_common/gametypes/globallogic_score;
#using scripts/mp_common/gametypes/hostmigration;
#using scripts/mp_common/util;

#namespace dogtags;

// Namespace dogtags/dogtags
// Params 0
// Checksum 0x7e5c3533, Offset: 0x3f8
// Size: 0x5c
function init()
{
    level.antiboostdistance = getgametypesetting( "antiBoostDistance" );
    level.dogtags = [];
    callback::on_spawned( &on_spawn_player );
}

// Namespace dogtags/dogtags
// Params 4
// Checksum 0xbac950a8, Offset: 0x460
// Size: 0xab4
function spawn_dog_tag( victim, attacker, on_use_function, objectives_for_attacker_and_victim_only )
{
    if ( isdefined( level.dogtags[ victim.entnum ] ) )
    {
        playfx( "ui/fx_kill_confirmed_vanish", level.dogtags[ victim.entnum ].curorigin );
        level.dogtags[ victim.entnum ] notify( #"reset" );
    }
    else
    {
        visuals[ 0 ] = spawn( "script_model", ( 0, 0, 0 ) );
        visuals[ 0 ] setmodel( victim getenemydogtagmodel() );
        visuals[ 1 ] = spawn( "script_model", ( 0, 0, 0 ) );
        visuals[ 1 ] setmodel( victim getfriendlydogtagmodel() );
        trigger = spawn( "trigger_radius", ( 0, 0, 0 ), 0, 32, 32 );
        level.dogtags[ victim.entnum ] = gameobjects::create_use_object( "any", trigger, visuals, ( 0, 0, 16 ) );
        level.dogtags[ victim.entnum ] gameobjects::set_use_time( 0 );
        level.dogtags[ victim.entnum ].onuse = &onuse;
        level.dogtags[ victim.entnum ].custom_onuse = on_use_function;
        level.dogtags[ victim.entnum ].victim = victim;
        level.dogtags[ victim.entnum ].victimteam = victim.team;
        level thread clear_on_victim_disconnect( victim );
        victim thread team_updater( level.dogtags[ victim.entnum ] );
        
        foreach ( team in level.teams )
        {
            objective_add( level.dogtags[ victim.entnum ].objid[ team ], "invisible", ( 0, 0, 0 ) );
            objective_setteam( level.dogtags[ victim.entnum ].objid[ team ], team );
            
            if ( team == attacker.team )
            {
                objective_setcolor( level.dogtags[ victim.entnum ].objid[ team ], &"EnemyOrange" );
                continue;
            }
            
            objective_setcolor( level.dogtags[ victim.entnum ].objid[ team ], &"FriendlyBlue" );
        }
    }
    
    pos = victim.origin + ( 0, 0, 14 );
    level.dogtags[ victim.entnum ].curorigin = pos;
    level.dogtags[ victim.entnum ].trigger.origin = pos;
    level.dogtags[ victim.entnum ].visuals[ 0 ].origin = pos;
    level.dogtags[ victim.entnum ].visuals[ 1 ].origin = pos;
    level.dogtags[ victim.entnum ].visuals[ 0 ] dontinterpolate();
    level.dogtags[ victim.entnum ].visuals[ 1 ] dontinterpolate();
    level.dogtags[ victim.entnum ] gameobjects::allow_use( "any" );
    level.dogtags[ victim.entnum ].visuals[ 0 ] thread show_to_team( level.dogtags[ victim.entnum ], attacker.team );
    level.dogtags[ victim.entnum ].visuals[ 1 ] thread show_to_enemy_teams( level.dogtags[ victim.entnum ], attacker.team );
    level.dogtags[ victim.entnum ].attacker = attacker;
    level.dogtags[ victim.entnum ].attackerteam = attacker.team;
    level.dogtags[ victim.entnum ].unreachable = undefined;
    level.dogtags[ victim.entnum ].tacinsert = 0;
    
    foreach ( team in level.teams )
    {
        if ( isdefined( level.dogtags[ victim.entnum ].objid[ team ] ) )
        {
            objective_setposition( level.dogtags[ victim.entnum ].objid[ team ], pos );
            objective_setstate( level.dogtags[ victim.entnum ].objid[ team ], "active" );
        }
    }
    
    if ( objectives_for_attacker_and_victim_only )
    {
        objective_setinvisibletoall( level.dogtags[ victim.entnum ].objid[ attacker.team ] );
        
        if ( isplayer( attacker ) )
        {
            objective_setvisibletoplayer( level.dogtags[ victim.entnum ].objid[ attacker.team ], attacker );
        }
        
        objective_setinvisibletoall( level.dogtags[ victim.entnum ].objid[ victim.team ] );
        
        if ( isplayer( victim ) )
        {
            objective_setvisibletoplayer( level.dogtags[ victim.entnum ].objid[ victim.team ], victim );
        }
    }
    
    level.dogtags[ victim.entnum ] thread bounce();
    level notify( #"dogtag_spawned" );
}

// Namespace dogtags/dogtags
// Params 2
// Checksum 0x4b5233d8, Offset: 0xf20
// Size: 0xd4
function show_to_team( gameobject, show_team )
{
    self show();
    
    foreach ( team in level.teams )
    {
        self hidefromteam( team );
    }
    
    self showtoteam( show_team );
}

// Namespace dogtags/dogtags
// Params 2
// Checksum 0x4d0331ef, Offset: 0x1000
// Size: 0xd4
function show_to_enemy_teams( gameobject, friend_team )
{
    self show();
    
    foreach ( team in level.teams )
    {
        self showtoteam( team );
    }
    
    self hidefromteam( friend_team );
}

// Namespace dogtags/dogtags
// Params 1
// Checksum 0x64e36282, Offset: 0x10e0
// Size: 0x234
function onuse( player )
{
    self.visuals[ 0 ] playsound( "mpl_killconfirm_tags_pickup" );
    tacinsertboost = 0;
    
    if ( player.team != self.attackerteam )
    {
        player addplayerstat( "KILLSDENIED", 1 );
        player recordgameevent( "return" );
        
        if ( self.victim == player )
        {
            if ( self.tacinsert == 0 )
            {
                event = "retrieve_own_tags";
            }
            else
            {
                tacinsertboost = 1;
            }
        }
        else
        {
            event = "kill_denied";
        }
        
        if ( !tacinsertboost )
        {
            player.pers[ "killsdenied" ]++;
            player.killsdenied = player.pers[ "killsdenied" ];
        }
    }
    else
    {
        event = "kill_confirmed";
        player addplayerstat( "KILLSCONFIRMED", 1 );
        player recordgameevent( "capture" );
        
        if ( isdefined( self.attacker ) && self.attacker != player )
        {
            self.attacker onpickup( "teammate_kill_confirmed" );
        }
    }
    
    if ( !tacinsertboost && isdefined( player ) )
    {
        player onpickup( event );
    }
    
    [[ self.custom_onuse ]]( player );
    self reset_tags();
}

// Namespace dogtags/dogtags
// Params 0
// Checksum 0xec7b4fb2, Offset: 0x1320
// Size: 0x1b2
function reset_tags()
{
    self.attacker = undefined;
    self.unreachable = undefined;
    self notify( #"reset" );
    self.visuals[ 0 ] hide();
    self.visuals[ 1 ] hide();
    self.curorigin = ( 0, 0, 1000 );
    self.trigger.origin = ( 0, 0, 1000 );
    self.visuals[ 0 ].origin = ( 0, 0, 1000 );
    self.visuals[ 1 ].origin = ( 0, 0, 1000 );
    self.tacinsert = 0;
    self gameobjects::allow_use( "none" );
    
    foreach ( team in level.teams )
    {
        objective_setstate( self.objid[ team ], "invisible" );
    }
}

// Namespace dogtags/dogtags
// Params 1
// Checksum 0x9feae47d, Offset: 0x14e0
// Size: 0x24
function onpickup( event )
{
    scoreevents::processscoreevent( event, self );
}

// Namespace dogtags/dogtags
// Params 1
// Checksum 0xf8355d57, Offset: 0x1510
// Size: 0x26c
function clear_on_victim_disconnect( victim )
{
    level endon( #"game_ended" );
    guid = victim.entnum;
    victim waittill( "disconnect" );
    
    if ( isdefined( level.dogtags[ guid ] ) )
    {
        level.dogtags[ guid ] gameobjects::allow_use( "none" );
        playfx( "ui/fx_kill_confirmed_vanish", level.dogtags[ guid ].curorigin );
        level.dogtags[ guid ] notify( #"reset" );
        waitframe( 1 );
        
        if ( isdefined( level.dogtags[ guid ] ) )
        {
            foreach ( team in level.teams )
            {
                objective_delete( level.dogtags[ guid ].objid[ team ] );
            }
            
            level.dogtags[ guid ].trigger delete();
            
            for ( i = 0; i < level.dogtags[ guid ].visuals.size ; i++ )
            {
                level.dogtags[ guid ].visuals[ i ] delete();
            }
            
            level.dogtags[ guid ] notify( #"deleted" );
            level.dogtags[ guid ] = undefined;
        }
    }
}

// Namespace dogtags/dogtags
// Params 0
// Checksum 0x82e4f32b, Offset: 0x1788
// Size: 0x114
function on_spawn_player()
{
    if ( !( isdefined( level.droppedtagrespawn ) && level.droppedtagrespawn ) )
    {
        return;
    }
    
    if ( level.rankedmatch || level.leaguematch )
    {
        if ( isdefined( self.tacticalinsertiontime ) && self.tacticalinsertiontime + 100 > gettime() )
        {
            mindist = level.antiboostdistance;
            mindistsqr = mindist * mindist;
            distsqr = distancesquared( self.origin, level.dogtags[ self.entnum ].curorigin );
            
            if ( distsqr < mindistsqr )
            {
                level.dogtags[ self.entnum ].tacinsert = 1;
            }
        }
    }
}

// Namespace dogtags/dogtags
// Params 1
// Checksum 0xded2e363, Offset: 0x18a8
// Size: 0x70
function team_updater( tags )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( "joined_team" );
        tags.victimteam = self.team;
        tags reset_tags();
    }
}

// Namespace dogtags/dogtags
// Params 1
// Checksum 0x9ee1af6b, Offset: 0x1920
// Size: 0x154
function time_out( victim )
{
    level endon( #"game_ended" );
    victim endon( #"disconnect" );
    self notify( #"timeout" );
    self endon( #"timeout" );
    level hostmigration::waitlongdurationwithhostmigrationpause( 30 );
    self.visuals[ 0 ] hide();
    self.visuals[ 1 ] hide();
    self.curorigin = ( 0, 0, 1000 );
    self.trigger.origin = ( 0, 0, 1000 );
    self.visuals[ 0 ].origin = ( 0, 0, 1000 );
    self.visuals[ 1 ].origin = ( 0, 0, 1000 );
    self.tacinsert = 0;
    self gameobjects::allow_use( "none" );
}

// Namespace dogtags/dogtags
// Params 0
// Checksum 0x9f6b5b15, Offset: 0x1a80
// Size: 0x238
function bounce()
{
    level endon( #"game_ended" );
    self endon( #"reset" );
    bottompos = self.curorigin;
    toppos = self.curorigin + ( 0, 0, 12 );
    
    while ( true )
    {
        self.visuals[ 0 ] moveto( toppos, 0.5, 0.15, 0.15 );
        self.visuals[ 0 ] rotateyaw( 180, 0.5 );
        self.visuals[ 1 ] moveto( toppos, 0.5, 0.15, 0.15 );
        self.visuals[ 1 ] rotateyaw( 180, 0.5 );
        wait 0.5;
        self.visuals[ 0 ] moveto( bottompos, 0.5, 0.15, 0.15 );
        self.visuals[ 0 ] rotateyaw( 180, 0.5 );
        self.visuals[ 1 ] moveto( bottompos, 0.5, 0.15, 0.15 );
        self.visuals[ 1 ] rotateyaw( 180, 0.5 );
        wait 0.5;
    }
}

// Namespace dogtags/dogtags
// Params 0
// Checksum 0x3cc08674, Offset: 0x1cc0
// Size: 0x2c
function checkallowspectating()
{
    self endon( #"disconnect" );
    waitframe( 1 );
    spectating::update_settings();
}

// Namespace dogtags/dogtags
// Params 9
// Checksum 0x48079e2a, Offset: 0x1cf8
// Size: 0x15c, Type: bool
function should_spawn_tags( einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration )
{
    if ( isalive( self ) )
    {
        return false;
    }
    
    if ( isdefined( self.switching_teams ) )
    {
        return false;
    }
    
    if ( isdefined( attacker ) && attacker == self )
    {
        return false;
    }
    
    if ( level.teambased && isdefined( attacker ) && isdefined( attacker.team ) && attacker.team == self.team )
    {
        return false;
    }
    
    if ( attacker.classname == "trigger_hurt" || ( !isdefined( attacker.team ) || isdefined( attacker ) && attacker.team == "free" ) && attacker.classname == "worldspawn" )
    {
        return false;
    }
    
    return true;
}

// Namespace dogtags/dogtags
// Params 1
// Checksum 0x5b0bea17, Offset: 0x1e60
// Size: 0xa4
function onusedogtag( player )
{
    if ( player.pers[ "team" ] == self.victimteam )
    {
        player.pers[ "rescues" ]++;
        player.rescues = player.pers[ "rescues" ];
        
        if ( isdefined( self.victim ) )
        {
            if ( !level.gameended )
            {
                self.victim thread dt_respawn();
            }
        }
    }
}

// Namespace dogtags/dogtags
// Params 0
// Checksum 0x10a37950, Offset: 0x1f10
// Size: 0x1c
function dt_respawn()
{
    self thread waittillcanspawnclient();
}

// Namespace dogtags/dogtags
// Params 0
// Checksum 0x2fbbae50, Offset: 0x1f38
// Size: 0x7e
function waittillcanspawnclient()
{
    for ( ;; )
    {
        wait 0.05;
        
        if ( self.sessionstate == "spectator" || isdefined( self ) && !isalive( self ) )
        {
            self.pers[ "lives" ] = 1;
            self thread [[ level.spawnclient ]]();
            continue;
        }
        
        return;
    }
}

