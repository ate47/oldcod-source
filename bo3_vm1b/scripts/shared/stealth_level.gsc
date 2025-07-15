#using scripts/codescripts/struct;
#using scripts/shared/ai_shared;
#using scripts/shared/ai_sniper_shared;
#using scripts/shared/array_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/stealth;
#using scripts/shared/stealth_actor;
#using scripts/shared/stealth_aware;
#using scripts/shared/stealth_debug;
#using scripts/shared/stealth_player;
#using scripts/shared/stealth_vo;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace stealth_level;

// Namespace stealth_level
// Params 0
// Checksum 0x16a07126, Offset: 0x3c0
// Size: 0x2e2
function init()
{
    assert( !isdefined( self.stealth ) );
    
    if ( !isdefined( self.stealth ) )
    {
        self.stealth = spawnstruct();
    }
    
    self.stealth.enabled_level = 1;
    self.stealth.enemies = [];
    self.stealth.awareness_index = [];
    self.stealth.awareness_index[ "unaware" ] = 0;
    self.stealth.awareness_index[ "low_alert" ] = 1;
    self.stealth.awareness_index[ "high_alert" ] = 1;
    self.stealth.awareness_index[ "combat" ] = 2;
    level flag::init( "stealth_alert", 0 );
    level flag::init( "stealth_combat", 0 );
    level flag::init( "stealth_discovered", 0 );
    init_parms();
    spawner::add_global_spawn_function( "axis", &stealth::agent_init );
    self stealth_vo::init();
    self thread function_7bf2f7ba();
    self thread update_thread();
    self thread function_a3cf57bf();
    self thread function_f8b0594a();
    self thread stealth_music_thread();
    self thread function_945a718();
    
    /#
        self stealth_debug::init_debug();
    #/
    
    level.using_awareness = 1;
    setdvar( "ai_stumbleSightRange", -56 );
    setdvar( "ai_awarenessenabled", 1 );
    setdvar( "stealth_display", 0 );
    setdvar( "stealth_audio", 1 );
    
    if ( getdvarstring( "stealth_indicator" ) == "" )
    {
        setdvar( "stealth_indicator", 0 );
    }
    
    setdvar( "stealth_group_radius", 1000 );
    setdvar( "stealth_all_aware", 1 );
    setdvar( "stealth_no_return", 1 );
    setdvar( "stealth_events", "sentientevents_vengeance_default" );
}

// Namespace stealth_level
// Params 0
// Checksum 0x4a890761, Offset: 0x6b0
// Size: 0x109
function stop()
{
    spawner::remove_global_spawn_function( "axis", &stealth::agent_init );
    level.using_awareness = 0;
    setdvar( "ai_stumbleSightRange", 0 );
    setdvar( "ai_awarenessenabled", 0 );
    
    if ( isdefined( level.stealth.music_ent ) )
    {
        foreach ( ent in level.stealth.music_ent )
        {
            ent stoploopsound( 1 );
            ent util::deleteaftertime( 1.5 );
        }
        
        level.stealth.music_ent = undefined;
    }
}

// Namespace stealth_level
// Params 0
// Checksum 0xe3fb40d5, Offset: 0x7c8
// Size: 0x5a
function reset()
{
    level flag::clear( "stealth_alert" );
    level flag::clear( "stealth_combat" );
    level flag::clear( "stealth_discovered" );
    self thread function_f8b0594a();
}

// Namespace stealth_level
// Params 0
// Checksum 0x358aa969, Offset: 0x830
// Size: 0x1e, Type: bool
function enabled()
{
    return isdefined( self.stealth ) && isdefined( self.stealth.enabled_level );
}

// Namespace stealth_level
// Params 0
// Checksum 0xf913732, Offset: 0x858
// Size: 0x362
function init_parms()
{
    assert( self enabled() );
    
    if ( !isdefined( self.stealth.parm ) )
    {
        self.stealth.parm = spawnstruct();
    }
    
    self.stealth.parm.awareness[ "unaware" ] = spawnstruct();
    self.stealth.parm.awareness[ "low_alert" ] = spawnstruct();
    self.stealth.parm.awareness[ "high_alert" ] = spawnstruct();
    self.stealth.parm.awareness[ "combat" ] = spawnstruct();
    vals = self.stealth.parm.awareness[ "unaware" ];
    vals.fovcosine = cos( 45 );
    vals.fovcosinez = cos( 10 );
    vals.maxsightdist = 600;
    setstealthsight( "unaware", 4, 0.5, 5, 100, 600, 0 );
    vals = self.stealth.parm.awareness[ "low_alert" ];
    vals.fovcosine = cos( 60 );
    vals.fovcosinez = cos( 20 );
    vals.maxsightdist = 800;
    setstealthsight( "low_alert", 0, 0, 1, 100, 800, 0 );
    vals = self.stealth.parm.awareness[ "high_alert" ];
    vals.fovcosine = cos( 60 );
    vals.fovcosinez = cos( 20 );
    vals.maxsightdist = 1000;
    setstealthsight( "high_alert", 16, 0.25, 4, 100, 1000, 0 );
    vals = self.stealth.parm.awareness[ "combat" ];
    vals.fovcosine = 0;
    vals.fovcosinez = 0;
    vals.maxsightdist = 8192;
    setstealthsight( "combat", 32, 0.01, 0.01, 100, 1500, 1 );
}

// Namespace stealth_level
// Params 1
// Checksum 0x297629fe, Offset: 0xbc8
// Size: 0x3a
function get_parms( strawareness )
{
    assert( isdefined( level.stealth ) );
    return level.stealth.parm.awareness[ strawareness ];
}

// Namespace stealth_level
// Params 0
// Checksum 0x6baefd07, Offset: 0xc10
// Size: 0x82
function function_7bf2f7ba()
{
    array::thread_all( getentarray( "_stealth_shadow", "targetname" ), &stealth_shadow_volumes );
    array::thread_all( getentarray( "stealth_shadow", "targetname" ), &stealth_shadow_volumes );
}

// Namespace stealth_level
// Params 0
// Checksum 0x3efb63b7, Offset: 0xca0
// Size: 0x95
function stealth_shadow_volumes()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger", other );
        
        if ( !isalive( other ) )
        {
            continue;
        }
        
        if ( isdefined( other.stealth.in_shadow ) && ( !isdefined( other.stealth ) || other.stealth.in_shadow ) )
        {
            continue;
        }
        
        other thread function_9f3c4fa( self );
    }
}

// Namespace stealth_level
// Params 1
// Checksum 0x6ffc7e28, Offset: 0xd40
// Size: 0x6a
function function_9f3c4fa( volume )
{
    self endon( #"death" );
    
    if ( !isdefined( self.stealth ) )
    {
        return;
    }
    
    self.stealth.in_shadow = 1;
    
    while ( isdefined( volume ) && self istouching( volume ) )
    {
        wait 0.05;
    }
    
    self.stealth.in_shadow = 0;
}

// Namespace stealth_level
// Params 0
// Checksum 0x5c5d9ff1, Offset: 0xdb8
// Size: 0xb5
function update_thread()
{
    assert( self enabled() );
    self endon( #"stop_stealth" );
    
    while ( true )
    {
        self update_arrays();
        sentientevents = getdvarstring( "stealth_events" );
        
        if ( !isdefined( level.var_1e44252f ) || sentientevents != "" && level.var_1e44252f != sentientevents )
        {
            loadsentienteventparameters( sentientevents );
        }
        
        level.var_1e44252f = sentientevents;
        wait 0.25;
    }
}

// Namespace stealth_level
// Params 0
// Checksum 0x8ed243ef, Offset: 0xe78
// Size: 0x5ea
function update_arrays()
{
    assert( self enabled() );
    self.stealth.enemies[ "axis" ] = [];
    self.stealth.enemies[ "allies" ] = [];
    self.stealth.seek = [];
    playerlist = getplayers();
    ailist = getaiarray();
    
    foreach ( player in playerlist )
    {
        if ( !isdefined( player.stealth ) )
        {
            player stealth::agent_init();
        }
        
        if ( isdefined( player.ignoreme ) && player.ignoreme )
        {
            continue;
        }
        
        if ( player.team == "allies" )
        {
            self.stealth.enemies[ "axis" ][ player getentitynumber() ] = player;
        }
        
        player stealth_player::function_b9393d6c( "high_alert" );
        player.stealth.incombat = 0;
    }
    
    alertcount = 0;
    level.combatcount = 0;
    level.stealth.var_e7ad9c1f = 0;
    
    foreach ( ai in ailist )
    {
        if ( isdefined( ai.ignoreme ) && ai.ignoreme )
        {
            continue;
        }
        
        entnum = ai getentitynumber();
        counted = 0;
        
        if ( isalive( ai ) && ai stealth_aware::enabled() && !( isdefined( ai.silenced ) && ai.silenced ) )
        {
            var_96b139a9 = isactor( ai ) && ai_sniper::is_firing( ai ) && isdefined( ai.lase_ent ) && isplayer( ai.lase_ent.lase_override );
            
            if ( !( isdefined( ai.ignoreall ) && ai.ignoreall ) && ai stealth_aware::get_awareness() != "unaware" )
            {
                alertcount += 1;
            }
            
            if ( ai stealth_aware::get_awareness() == "combat" || var_96b139a9 )
            {
                if ( var_96b139a9 )
                {
                    ai.stealth.aware_combat[ ai.lase_ent.lase_override getentitynumber() ] = ai.lase_ent.lase_override;
                }
                
                counted = 0;
                
                if ( isdefined( ai.stealth.aware_combat ) )
                {
                    foreach ( combatant in ai.stealth.aware_combat )
                    {
                        if ( !isalive( combatant ) )
                        {
                            continue;
                        }
                        
                        var_146dd427 = combatant getentitynumber();
                        
                        if ( !isdefined( self.stealth.seek[ var_146dd427 ] ) )
                        {
                            self.stealth.seek[ var_146dd427 ] = combatant;
                        }
                        
                        if ( isplayer( combatant ) )
                        {
                            if ( !counted && !( isdefined( ai.ignoreall ) && ai.ignoreall ) )
                            {
                                level.combatcount += 1;
                                counted = 1;
                            }
                            
                            combatant stealth_player::function_b9393d6c( "combat" );
                            
                            if ( !combatant.stealth.incombat )
                            {
                                level.stealth.var_e7ad9c1f++;
                            }
                            
                            combatant.stealth.incombat = 1;
                        }
                    }
                }
            }
        }
        
        if ( ai.team == "allies" )
        {
            self.stealth.enemies[ "axis" ][ entnum ] = ai;
            continue;
        }
        
        if ( ai.team == "axis" )
        {
            self.stealth.enemies[ "allies" ][ entnum ] = ai;
        }
    }
    
    if ( alertcount > 0 )
    {
        level flag::set( "stealth_alert" );
    }
    else
    {
        level flag::clear( "stealth_alert" );
    }
    
    if ( level.combatcount > 0 )
    {
        level flag::set( "stealth_combat" );
        return;
    }
    
    level flag::clear( "stealth_combat" );
}

// Namespace stealth_level
// Params 0
// Checksum 0xe5be1d17, Offset: 0x1470
// Size: 0xe9
function function_a3cf57bf()
{
    self endon( #"stop_stealth" );
    grace_period = 6;
    
    while ( true )
    {
        level flag::wait_till( "stealth_combat" );
        
        if ( level.stealth.var_e7ad9c1f == 0 )
        {
            wait 0.05;
            continue;
        }
        
        level.stealth.var_30d9fcc6 = 1;
        wait grace_period;
        level.stealth.var_30d9fcc6 = 0;
        
        if ( flag::get( "stealth_combat" ) )
        {
            level flag::set( "stealth_discovered" );
            thread wake_all();
        }
        
        level flag::wait_till_clear( "stealth_combat" );
        
        if ( isdefined( level.combatcount ) )
        {
            level.combatcount = 0;
        }
    }
}

// Namespace stealth_level
// Params 0
// Checksum 0x63772a5, Offset: 0x1568
// Size: 0x1f5
function function_f8b0594a()
{
    self notify( #"hash_f8b0594a" );
    self endon( #"hash_f8b0594a" );
    self endon( #"stop_stealth" );
    
    while ( true )
    {
        level flag::wait_till( "stealth_alert" );
        level flag::wait_till_clear( "stealth_alert" );
        wait randomfloatrange( 1.5, 3 );
        var_c6d0ac06 = isdefined( level.stealth.var_30d9fcc6 ) && isdefined( level.stealth ) && level.stealth.var_30d9fcc6;
        
        while ( isdefined( level.stealth.var_30d9fcc6 ) && isdefined( level.stealth ) && level.stealth.var_30d9fcc6 )
        {
            wait 0.05;
        }
        
        if ( !level flag::get( "stealth_alert" ) && !level flag::get( "stealth_discovered" ) && !level flag::get( "stealth_combat" ) )
        {
            foreach ( player in level.activeplayers )
            {
                if ( player stealth_player::enabled() )
                {
                    if ( var_c6d0ac06 )
                    {
                        player stealth_vo::function_e3ae87b3( "close_call" );
                        continue;
                    }
                    
                    player stealth_vo::function_e3ae87b3( "returning" );
                }
            }
        }
        
        wait randomfloatrange( 1.5, 3 );
    }
}

// Namespace stealth_level
// Params 0
// Checksum 0x4b70d7f9, Offset: 0x1768
// Size: 0x1eb
function wake_all()
{
    self notify( #"wake_all" );
    self endon( #"wake_all" );
    
    if ( getdvarint( "stealth_no_return" ) )
    {
        enemies = getaiteamarray( "axis" );
        
        foreach ( enemy in enemies )
        {
            if ( !isalive( enemy ) )
            {
                continue;
            }
            
            if ( isdefined( enemy.stealth ) )
            {
                enemy notify( #"wake_all" );
                enemy notify( #"alert", "combat", enemy.origin, undefined, "wake_all" );
                enemy stealth::stop();
            }
            
            foreach ( player in level.activeplayers )
            {
                enemy getperfectinfo( player, 1 );
            }
            
            enemy stopanimscripted();
            
            if ( isdefined( enemy.patroller ) && enemy.patroller )
            {
                enemy ai::end_and_clean_patrol_behaviors();
            }
            
            enemy ai_sniper::actor_lase_stop();
            
            if ( isactor( enemy ) )
            {
                enemy thread stealth_actor::function_1064f733();
            }
            
            wait 0.25;
        }
    }
}

// Namespace stealth_level
// Params 0
// Checksum 0x3e292af4, Offset: 0x1960
// Size: 0xb5
function stealth_music_thread()
{
    self endon( #"stop_stealth" );
    stealth::function_862e861f();
    
    while ( true )
    {
        if ( !level flag::get( "stealth_discovered" ) )
        {
            if ( level flag::get( "stealth_combat" ) )
            {
                stealth::function_e0319e51( "combat" );
            }
            else if ( level flag::get( "stealth_alert" ) )
            {
                stealth::function_e0319e51( "high_alert" );
            }
            else
            {
                stealth::function_e0319e51( "unaware" );
            }
        }
        
        wait 0.05;
    }
}

// Namespace stealth_level
// Params 0
// Checksum 0xf38db692, Offset: 0x1a20
// Size: 0x21b
function function_945a718()
{
    wait 0.05;
    var_e3fe91b2 = struct::get_array( "stealth_callout", "targetname" );
    
    foreach ( ent in var_e3fe91b2 )
    {
        ent stealth_vo::function_4970c8b8( ent.script_parameters );
    }
    
    var_e3fe91b2 = struct::get_array( "stealth_callout", "script_noteworthy" );
    
    foreach ( ent in var_e3fe91b2 )
    {
        ent stealth_vo::function_4970c8b8( ent.script_parameters );
    }
    
    var_e3fe91b2 = getentarray( "stealth_callout", "targetname" );
    
    foreach ( ent in var_e3fe91b2 )
    {
        ent stealth_vo::function_4970c8b8( ent.script_parameters );
    }
    
    var_e3fe91b2 = getentarray( "stealth_callout", "script_noteworthy" );
    
    foreach ( ent in var_e3fe91b2 )
    {
        ent stealth_vo::function_4970c8b8( ent.script_parameters );
    }
}

