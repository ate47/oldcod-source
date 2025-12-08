#using script_3dc93ca9902a9cda;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\stealth\player;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace threat_sight;

// Namespace threat_sight/threat_sight
// Params 2
// Checksum 0xf4fc32b8, Offset: 0x208
// Size: 0x14
function scalevolume( *ent, *vol )
{
    
}

#namespace stealth_threat_sight;

// Namespace stealth_threat_sight/threat_sight
// Params 0, eflags: 0x6
// Checksum 0x704e38d8, Offset: 0x228
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"stealth_threat_sight", &preinit, undefined, undefined, undefined );
}

// Namespace stealth_threat_sight/threat_sight
// Params 0, eflags: 0x4
// Checksum 0x1940a45e, Offset: 0x270
// Size: 0x1b4
function private preinit()
{
    register_clientfields();
    level.var_53ad6e22 = [];
    util::init_dvar( "ai_threatForcedRate", 0.4, &function_4c75a19 );
    util::init_dvar( "ai_threatForcedMax", 0.5, &function_4c75a19 );
    util::init_dvar( "ai_threatsight", 0, &function_4c75a19 );
    util::init_dvar( "ai_threatForcedRate", 0, &function_4c75a19 );
    util::init_dvar( "ai_threatsightFakeThreat", 0, &function_4c75a19 );
    util::init_dvar( "ai_threatsightFakeX", 0, &function_4c75a19 );
    util::init_dvar( "ai_threatsightFakeY", 0, &function_4c75a19 );
    util::init_dvar( "ai_threatsightFakeZ", 0, &function_4c75a19 );
    util::init_dvar( "ai_threatUseDisplay", 0, &function_4c75a19 );
}

// Namespace stealth_threat_sight/threat_sight
// Params 0, eflags: 0x4
// Checksum 0x266aaea1, Offset: 0x430
// Size: 0x64
function private register_clientfields()
{
    clientfield::register( "actor", "threat_sight", 1, 6, "int" );
    clientfield::register( "actor", "threat_state", 1, 2, "int" );
}

// Namespace stealth_threat_sight/threat_sight
// Params 1, eflags: 0x4
// Checksum 0xf2bce5f, Offset: 0x4a0
// Size: 0x28
function private function_4c75a19( dvar )
{
    level.var_53ad6e22[ dvar.name ] = dvar.value;
}

// Namespace stealth_threat_sight/threat_sight
// Params 1
// Checksum 0x3c2f8316, Offset: 0x4d0
// Size: 0x260
function threat_sight_set_enabled( enabled )
{
    assert( isdefined( level.stealth ) );
    wasenabled = isdefined( level.stealth.threat_sight_enabled ) && level.stealth.threat_sight_enabled;
    level.stealth.threat_sight_enabled = enabled;
    threat_sight_set_dvar( enabled );
    
    if ( !enabled && wasenabled )
    {
        level notify( #"threat_sight_disabled" );
        
        foreach ( player in getplayers() )
        {
            player.stealth.threat_thread = undefined;
        }
    }
    else if ( enabled && !wasenabled )
    {
        level notify( #"threat_sight_enabled" );
    }
    
    allai = getactorarray();
    
    foreach ( guy in allai )
    {
        if ( isalive( guy ) && isdefined( guy.stealth ) && isdefined( guy.stealth.threat_sight_state ) )
        {
            guy threat_sight_set_state( guy.stealth.threat_sight_state );
        }
    }
}

// Namespace stealth_threat_sight/threat_sight
// Params 1
// Checksum 0x4b978249, Offset: 0x738
// Size: 0x84
function threat_sight_set_dvar( enabled )
{
    if ( enabled && ( !isdefined( level.stealth.threat_sight_enabled ) || !level.stealth.threat_sight_enabled ) )
    {
        return;
    }
    
    setsaveddvar( #"ai_threatsight", enabled );
    level thread threat_sight_set_dvar_display( enabled );
}

// Namespace stealth_threat_sight/threat_sight
// Params 1
// Checksum 0x70f81fb6, Offset: 0x7c8
// Size: 0x9c
function threat_sight_set_dvar_display( enabled )
{
    self notify( #"threat_sight_set_dvar_display" );
    self endon( #"threat_sight_set_dvar_display" );
    
    if ( !enabled )
    {
        wait 1;
    }
    
    if ( level.var_53ad6e22[ #"ai_threatusedisplay" ] )
    {
        setsaveddvar( #"hash_7bf40e4b6a830d11", enabled );
    }
    
    setdvar( #"hash_28758912434b7866", enabled );
}

// Namespace stealth_threat_sight/threat_sight
// Params 0
// Checksum 0xb215f86a, Offset: 0x870
// Size: 0x74, Type: bool
function threat_sight_enabled()
{
    if ( !level.var_53ad6e22[ #"ai_threatsight" ] )
    {
        return false;
    }
    
    if ( self == level )
    {
        return ( isdefined( level.stealth.threat_sight_enabled ) && level.stealth.threat_sight_enabled );
    }
    
    return isdefined( self.threatsight ) && self.threatsight;
}

// Namespace stealth_threat_sight/threat_sight
// Params 1
// Checksum 0xbc46f6d1, Offset: 0x8f0
// Size: 0x2e4
function threat_sight_set_state( statename )
{
    if ( isdefined( self.stealth ) )
    {
        self.stealth.threat_sight_state = statename;
    }
    
    if ( !isdefined( level.stealth.threat_sight_enabled ) || !level.stealth.threat_sight_enabled )
    {
        if ( !is_true( self.threat_sight_immediate_thread ) )
        {
            self thread threat_sight_immediate_thread();
            self.threat_sight_immediate_thread = 1;
        }
        
        return;
    }
    else if ( is_true( self.threat_sight_immediate_thread ) )
    {
        self notify( #"threat_sight_immediate_thread" );
        self.threat_sight_immediate_thread = undefined;
    }
    
    switch ( statename )
    {
        case #"hidden":
            self.threatsight = 1;
            self.stealth.threat_sight_count = undefined;
            self.stealth.threat_sight_lost = undefined;
            break;
        case #"investigate":
            self.threatsight = 1;
            break;
        case #"hash_5689f41e8c0ad00":
        case #"combat_hunt":
            self.threatsight = 1;
            break;
        case #"blind":
        case #"spotted":
            break;
        case #"death":
            self.threatsight = 0;
            break;
        default:
            /#
                iprintlnbold( "<dev string:x38>" + statename + "<dev string:x5e>" );
            #/
            
            break;
    }
    
    foreach ( player in getplayers() )
    {
        if ( isdefined( player ) )
        {
            player threat_sight_player_entity_state_set( self, statename );
        }
    }
    
    if ( statename != "death" )
    {
        self threat_sight_set_state_parameters( statename );
    }
    
    if ( self.threatsight )
    {
        self thread function_3a739b35();
    }
}

// Namespace stealth_threat_sight/threat_sight
// Params 1
// Checksum 0xf3d04a0c, Offset: 0xbe0
// Size: 0x70
function threat_sight_set_state_parameters( statename )
{
    assert( isdefined( level.stealth ) );
    assert( isdefined( level.stealth.fnthreatsightsetstateparameters ) );
    self [[ level.stealth.fnthreatsightsetstateparameters ]]( statename );
}

// Namespace stealth_threat_sight/threat_sight
// Params 1, eflags: 0x4
// Checksum 0x3fabe0a9, Offset: 0xc58
// Size: 0x4c
function private function_eefd0bb3( *str_notify )
{
    self clientfield::set( "threat_sight", 0 );
    self clientfield::set( "threat_state", 0 );
}

// Namespace stealth_threat_sight/threat_sight
// Params 0
// Checksum 0xad1bc117, Offset: 0xcb0
// Size: 0x16
function function_60514e0b()
{
    self notify( #"hash_247b691774e7a2e2" );
}

// Namespace stealth_threat_sight/threat_sight
// Params 0, eflags: 0x4
// Checksum 0x2c91b62c, Offset: 0xcd0
// Size: 0x2f8
function private function_3a739b35()
{
    self notify( #"hash_3b836f1c1e601c4d" );
    self endoncallback( &function_eefd0bb3, #"hash_3b836f1c1e601c4d", #"hash_247b691774e7a2e2", #"death" );
    var_403d799 = 0;
    
    while ( true )
    {
        waitframe( 1 );
        
        if ( level.var_6eed8aea === 0 || self.var_6eed8aea === 0 )
        {
            self clientfield::set( "threat_sight", 0 );
            self clientfield::set( "threat_state", 0 );
            continue;
        }
        
        if ( getplayers().size > 0 )
        {
            player = getplayers()[ 0 ];
            threat_sight = self getthreatsight( player );
            var_97c4563c = 0;
            
            if ( self.awarenesslevelcurrent === "combat" )
            {
                var_97c4563c = 3;
            }
            else if ( self.stealth.bsmstate === 2 )
            {
                var_97c4563c = 2;
            }
            else if ( self.awarenesslevelcurrent !== "unaware" )
            {
                var_3f0097e8 = isdefined( self.stealth.investigateevent ) && self.stealth.investigateevent.typeorig == "sight";
                
                if ( threat_sight >= 1 || !var_3f0097e8 )
                {
                    var_97c4563c = 1;
                }
            }
            
            var_91b6ad45 = int( threat_sight * ( ( 1 << 6 ) - 1 ) );
            
            if ( ( var_97c4563c == 1 || var_97c4563c == 2 ) && var_91b6ad45 == 0 )
            {
                var_403d799 += float( function_60d95f53() ) / 1000;
                
                if ( var_403d799 > 1 )
                {
                    var_97c4563c = 0;
                }
            }
            else
            {
                var_403d799 = 0;
            }
            
            self clientfield::set( "threat_sight", var_91b6ad45 );
            self clientfield::set( "threat_state", var_97c4563c );
        }
    }
}

// Namespace stealth_threat_sight/threat_sight
// Params 0
// Checksum 0xf42c168d, Offset: 0xfd0
// Size: 0x194
function threat_sight_immediate_thread()
{
    self notify( #"threat_sight_immediate_thread" );
    self endon( #"threat_sight_immediate_thread", #"death" );
    level endon( #"threat_sight_enabled" );
    
    while ( true )
    {
        level flag::wait_till( "stealth_enabled" );
        level flag::wait_till_clear( "stealth_spotted" );
        wait randomfloatrange( 0.4, 0.6 );
        
        foreach ( player in getplayers() )
        {
            if ( isdefined( player.ignore_stealth_sight ) )
            {
                continue;
            }
            
            if ( player.ignoreme )
            {
                continue;
            }
            
            if ( self cansee( player ) )
            {
                self function_a3fcf9e0( "sight", player, player.origin );
            }
        }
    }
}

// Namespace stealth_threat_sight/threat_sight
// Params 0
// Checksum 0xcfe5e412, Offset: 0x1170
// Size: 0xa2
function threat_sight_player_init()
{
    if ( !isdefined( self.stealth.threat_entities ) )
    {
        self.stealth.threat_entities = [];
    }
    
    if ( !isdefined( self.stealth.threat_visible ) )
    {
        self.stealth.threat_visible = 0;
    }
    
    if ( !isdefined( self.stealth.threat_combat ) )
    {
        self.stealth.threat_combat = 0;
    }
    
    if ( !isdefined( self.stealth.threat_sighted ) )
    {
        self.stealth.threat_sighted = [];
    }
}

// Namespace stealth_threat_sight/threat_sight
// Params 2
// Checksum 0x3698497c, Offset: 0x1220
// Size: 0x224
function threat_sight_player_entity_state_set( ai, statename )
{
    if ( !isdefined( self.stealth ) )
    {
        self thread stealth_player::main();
    }
    
    self threat_sight_player_init();
    entid = ai getentitynumber();
    
    switch ( statename )
    {
        case #"hidden":
            self.stealth.threat_sighted[ entid ] = undefined;
            break;
        case #"combat_hunt":
            ai setthreatsight( self, 0 );
            break;
        case #"investigate":
            if ( isdefined( ai.enemy ) && ai.enemy == self )
            {
                ai setthreatsight( self, 1 );
            }
            
            break;
        case #"death":
            ai setthreatsight( self, 0 );
            break;
    }
    
    switch ( statename )
    {
        case #"death":
            self.stealth.threat_entities[ entid ] = undefined;
            self.stealth.threat_sighted[ entid ] = undefined;
            break;
        default:
            self.stealth.threat_entities[ entid ] = ai;
            break;
    }
    
    if ( !isdefined( self.stealth.threat_thread ) )
    {
        self.stealth.threat_thread = 1;
        self thread threat_sight_player_entity_state_thread();
    }
}

// Namespace stealth_threat_sight/threat_sight
// Params 1
// Checksum 0xa7295dc3, Offset: 0x1450
// Size: 0x304
function threat_sight_sighted( player )
{
    self endon( #"death", #"stealth_idle" );
    player endon( #"death" );
    assert( isdefined( player.stealth ) );
    assert( isdefined( player.stealth.threat_sighted ) );
    snd::play( "uin_stealth_spotted" );
    entid = self getentitynumber();
    
    if ( self [[ self.fnisinstealthhunt ]]() )
    {
        self getenemyinfo( player );
        self function_a3fcf9e0( "combat", player, player.origin );
        return;
    }
    
    player.stealth.threat_sighted[ entid ] = self;
    self function_a3fcf9e0( "sight", player, player.origin );
    
    if ( !isdefined( self.stealth.threat_sight_count ) )
    {
        self.stealth.threat_sight_count = 0;
    }
    else
    {
        self.stealth.threat_sight_count++;
    }
    
    waittime = self namespace_979752dc::alert_delay_distance_time( player );
    waittime /= pow( 2, self.stealth.threat_sight_count );
    waittime *= 1000;
    curtime = gettime();
    self.stealth.reactendtime = curtime + waittime;
    starttime = curtime;
    reactendtime = curtime + waittime;
    
    while ( gettime() < reactendtime )
    {
        if ( is_true( self.stealth.blind ) || !isdefined( self.stealth.threat_sight_count ) )
        {
            break;
        }
        
        waittime = self namespace_979752dc::alert_delay_distance_time( player );
        waittime /= pow( 2, self.stealth.threat_sight_count );
        waittime *= 1000;
        
        if ( starttime + waittime < reactendtime )
        {
            reactendtime = starttime + waittime;
        }
        
        waitframe( 1 );
    }
    
    self thread threat_sight_sighted_wait_lost( player );
}

// Namespace stealth_threat_sight/threat_sight
// Params 1
// Checksum 0x9802d736, Offset: 0x1760
// Size: 0xfc
function threat_sight_sighted_wait_lost( player )
{
    var_4897dbc7 = player getentitynumber();
    self notify( "threat_sight_sighted_wait_lost_" + var_4897dbc7 );
    self endon( "threat_sight_sighted_wait_lost_" + var_4897dbc7, #"death" );
    player endon( #"death" );
    entid = self getentitynumber();
    player.stealth.threat_sighted[ entid ] = undefined;
    
    while ( true )
    {
        self.stealth.threat_sight_lost = self getthreatsight( player ) < 0.75;
        
        if ( self.stealth.threat_sight_lost )
        {
            return;
        }
        
        wait 0.05;
    }
}

// Namespace stealth_threat_sight/threat_sight
// Params 2
// Checksum 0x63b8202, Offset: 0x1868
// Size: 0x174
function threat_sight_force_visible( othersentient, durationseconds )
{
    end = gettime() + int( 1000 * durationseconds );
    entnum = othersentient getentitynumber();
    
    if ( !isdefined( self.stealth.force_visible ) )
    {
        self.stealth.force_visible = [];
    }
    
    if ( isdefined( self.stealth.force_visible[ entnum ] ) )
    {
        self.stealth.force_visible[ entnum ].end = max( self.stealth.force_visible[ entnum ].end, end );
    }
    else
    {
        self.stealth.force_visible[ entnum ] = spawnstruct();
        self.stealth.force_visible[ entnum ].end = end;
    }
    
    self.stealth.force_visible[ entnum ].ent = othersentient;
    self thread threat_sight_force_visible_thread();
}

// Namespace stealth_threat_sight/threat_sight
// Params 0
// Checksum 0x841e599b, Offset: 0x19e8
// Size: 0x406
function threat_sight_force_visible_thread()
{
    if ( is_true( self.stealth.force_visible_thread ) )
    {
        return;
    }
    
    self notify( #"threat_sight_force_visible_thread" );
    self endon( #"threat_sight_force_visible_thread", #"death" );
    self.stealth.force_visible_thread = 1;
    waittime = 0.05;
    notified = 0;
    
    while ( isdefined( self.stealth.force_visible ) && self.stealth.force_visible.size > 0 )
    {
        now = gettime();
        remove = [];
        delta = level.var_53ad6e22[ #"ai_threatforcedrate" ] * waittime;
        
        foreach ( key, forcedvis in self.stealth.force_visible )
        {
            if ( now < forcedvis.end && issentient( forcedvis.ent ) && !self cansee( forcedvis.ent ) )
            {
                newthreat = self getthreatsight( forcedvis.ent );
                
                if ( isplayer( forcedvis.ent ) )
                {
                    forcedvis.ent thread threat_sight_player_sight_audio( 1, max( forcedvis.ent.stealth.maxthreat, newthreat ) );
                }
                
                if ( newthreat + delta < level.var_53ad6e22[ #"ai_threatforcedmax" ] )
                {
                    newthreat += delta;
                    self setthreatsight( forcedvis.ent, newthreat );
                    
                    if ( level.var_53ad6e22[ #"ai_threatforcedmax" ] >= 1 && newthreat >= 1 && !notified )
                    {
                        self function_a3fcf9e0( "sight", forcedvis.ent, forcedvis.ent.origin );
                        notified = 1;
                    }
                    else if ( newthreat < 0.75 && notified )
                    {
                        notified = 0;
                    }
                }
                
                continue;
            }
            
            remove[ remove.size ] = key;
        }
        
        foreach ( key in remove )
        {
            self.stealth.force_visible[ key ] = undefined;
        }
        
        wait waittime;
    }
    
    self.stealth.force_visible = undefined;
    self.stealth.force_visible_thread = undefined;
}

// Namespace stealth_threat_sight/threat_sight
// Params 0
// Checksum 0x1f37c25d, Offset: 0x1df8
// Size: 0x54c
function threat_sight_player_entity_state_thread()
{
    self endon( #"death" );
    level endon( #"threat_sight_disabled" );
    var_94603cb7 = 0;
    
    while ( true )
    {
        var_6330dd7b = 0;
        self.stealth.maxthreat = 0;
        self.stealth.maxalertlevel = -1;
        playereye = self getplayercamerapos();
        var_2efc79ea = 0.2588;
        
        foreach ( entity in self.stealth.threat_entities )
        {
            if ( !isalive( entity ) )
            {
                continue;
            }
            
            if ( is_true( entity.in_melee_death ) )
            {
                continue;
            }
            
            entid = entity getentitynumber();
            self.stealth.maxalertlevel = max( self.stealth.maxalertlevel, entity.alertlevelint );
            
            if ( level.var_53ad6e22[ #"ai_threatsight" ] )
            {
                if ( !isdefined( entity.fnisinstealthcombat ) || entity [[ entity.fnisinstealthcombat ]]() )
                {
                    continue;
                }
                
                var_17c874ba = entity getthreatsight( self );
                var_566de12 = entity cansee( self );
                
                if ( var_566de12 )
                {
                    var_94603cb7 = gettime();
                }
                
                if ( var_566de12 && isplayer( self ) && var_17c874ba > 0.09 && self player_is_sprinting_at_me( entity ) )
                {
                    entity function_a3fcf9e0( "sight", self, self.origin );
                }
                else if ( !is_true( entity.var_c5553760 ) && !is_true( entity.stealth.var_56d82ea8 ) && var_17c874ba >= 0.5 )
                {
                    entity function_a3fcf9e0( "sight", self, self.origin );
                    entity.stealth.var_56d82ea8 = 1;
                }
                else if ( var_17c874ba >= 1 )
                {
                    if ( !isdefined( self.stealth.threat_sighted[ entid ] ) )
                    {
                        entity thread threat_sight_sighted( self );
                    }
                }
                
                var_8735c97f = self.stealth.maxthreat;
                self.stealth.maxthreat = max( self.stealth.maxthreat, entity getthreatsight( self ) );
                
                if ( self.stealth.maxthreat > 0.05 )
                {
                    if ( !isdefined( self.stealth.maxthreat_enemy ) || self.stealth.maxthreat !== var_8735c97f )
                    {
                        self.stealth.maxthreat_enemy = entity;
                    }
                }
            }
            
            if ( entity.alertlevel == "combat" || !entity.threatsight )
            {
                var_6330dd7b = 1;
            }
        }
        
        anycansee = !var_6330dd7b && var_94603cb7 > 0 && gettime() - var_94603cb7 < 250;
        
        if ( level.var_53ad6e22[ #"ai_threatsightfakethreat" ] <= 0 )
        {
            self thread threat_sight_player_sight_audio( anycansee, self.stealth.maxthreat );
        }
        
        self.stealth.threat_visible = anycansee;
        wait 0.05;
    }
}

// Namespace stealth_threat_sight/threat_sight
// Params 1
// Checksum 0xc170c3cd, Offset: 0x2350
// Size: 0x54, Type: bool
function player_is_sprinting_at_me( ai )
{
    return self issprinting() && util::within_fov( self.origin, self.angles, ai.origin, 0.93969 );
}

// Namespace stealth_threat_sight/threat_sight
// Params 2
// Checksum 0x40fb209d, Offset: 0x23b0
// Size: 0x184
function threat_sight_fake( origin, amount )
{
    self notify( #"threat_sight_fake" );
    self endon( #"threat_sight_fake" );
    setsaveddvar( #"ai_threatsightfakethreat", amount );
    setsaveddvar( #"ai_threatsightfakex", origin[ 0 ] );
    setsaveddvar( #"ai_threatsightfakey", origin[ 1 ] );
    setsaveddvar( #"ai_threatsightfakez", origin[ 2 ] );
    
    if ( !isdefined( self.stealth.maxthreat ) )
    {
        self.stealth.maxthreat = 0;
    }
    
    while ( amount > 0 )
    {
        self thread threat_sight_player_sight_audio( 1, max( self.stealth.maxthreat, amount ) );
        wait 0.05;
    }
    
    self thread threat_sight_player_sight_audio( 0, max( self.stealth.maxthreat, amount ) );
}

// Namespace stealth_threat_sight/threat_sight
// Params 3
// Checksum 0xd547e656, Offset: 0x2540
// Size: 0x68
function threat_sight_player_sight_audio( anycansee, maxthreat, willdebugprint )
{
    if ( isdefined( level.stealth ) && isdefined( level.stealth.fnthreatsightplayersightaudio ) )
    {
        self thread [[ level.stealth.fnthreatsightplayersightaudio ]]( anycansee, maxthreat, willdebugprint );
    }
}

