#using scripts/core_common/callbacks_shared;
#using scripts/core_common/player_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/mp_common/gametypes/globallogic_player;

#namespace healthoverlay;

// Namespace healthoverlay/healthoverlay
// Params 0, eflags: 0x2
// Checksum 0x6aced5cc, Offset: 0x1c8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "healthoverlay", &__init__, undefined, undefined );
}

// Namespace healthoverlay/healthoverlay
// Params 0
// Checksum 0x6044def5, Offset: 0x208
// Size: 0x1b0
function __init__()
{
    callback::on_start_gametype( &init );
    
    if ( level.new_health_model )
    {
        callback::on_joined_team( &end_health_regen );
        callback::on_joined_spectate( &end_health_regen );
        callback::on_spawned( &player_health_regen );
        callback::on_disconnect( &end_health_regen );
        callback::on_player_killed( &end_health_regen );
        level.start_player_health_regen = &player_health_regen;
        return;
    }
    
    callback::on_joined_team( &end_health_regen );
    callback::on_joined_spectate( &end_health_regen );
    callback::on_spawned( &player_health_regen_t7 );
    callback::on_disconnect( &end_health_regen );
    callback::on_player_killed( &end_health_regen );
    level.start_player_health_regen = &player_health_regen_t7;
}

// Namespace healthoverlay/healthoverlay
// Params 0
// Checksum 0x3b350b2d, Offset: 0x3c0
// Size: 0x18
function init()
{
    level.healthoverlaycutoff = 0.55;
}

// Namespace healthoverlay/healthoverlay
// Params 0
// Checksum 0x7a3c92d3, Offset: 0x3e0
// Size: 0x30
function restart_player_health_regen()
{
    self end_health_regen();
    self thread [[ level.start_player_health_regen ]]();
}

// Namespace healthoverlay/healthoverlay
// Params 0
// Checksum 0x183393d4, Offset: 0x418
// Size: 0x12
function end_health_regen()
{
    self notify( #"end_healthregen" );
}

// Namespace healthoverlay/healthoverlay
// Params 0
// Checksum 0x55b90f7a, Offset: 0x438
// Size: 0x534
function player_health_regen_t7()
{
    self endon( #"end_healthregen" );
    
    if ( self.health <= 0 )
    {
        assert( !isalive( self ) );
        return;
    }
    
    maxhealth = self.health;
    oldhealth = maxhealth;
    player = self;
    var_4d2b26fb = 0;
    regenrate = 0.1;
    usetrueregen = 0;
    veryhurt = 0;
    player.breathingstoptime = -10000;
    thread player_breathing_sound( maxhealth * 0.35 );
    thread player_heartbeat_sound( maxhealth * 0.35 );
    lastsoundtime_recover = 0;
    hurttime = 0;
    newhealth = 0;
    
    for ( ;; )
    {
        waitframe( 1 );
        
        if ( isdefined( player.regenrate ) )
        {
            regenrate = player.regenrate;
            usetrueregen = 1;
        }
        
        if ( player.health == maxhealth )
        {
            veryhurt = 0;
            
            if ( self.atbrinkofdeath === 1 )
            {
                self notify( #"challenge_survived_from_death" );
            }
            
            self.atbrinkofdeath = 0;
            continue;
        }
        
        if ( player.health <= 0 )
        {
            return;
        }
        
        if ( isdefined( player.laststand ) && player.laststand )
        {
            continue;
        }
        
        wasveryhurt = veryhurt;
        ratio = player.health / maxhealth;
        
        if ( ratio <= level.healthoverlaycutoff )
        {
            veryhurt = 1;
            self.atbrinkofdeath = 1;
            self.isneardeath = 1;
            
            if ( !wasveryhurt )
            {
                hurttime = gettime();
            }
        }
        else
        {
            self.isneardeath = 0;
        }
        
        if ( player.health >= oldhealth )
        {
            regentime = 5000;
            
            if ( player hasperk( "specialty_healthregen" ) )
            {
                regentime = int( regentime / getdvarfloat( "perk_healthRegenMultiplier" ) );
            }
            
            if ( gettime() - hurttime < regentime )
            {
                continue;
            }
            
            if ( regentime <= 0 )
            {
                continue;
            }
            
            if ( gettime() - lastsoundtime_recover > regentime )
            {
                lastsoundtime_recover = gettime();
                self notify( #"snd_breathing_better" );
            }
            
            if ( veryhurt )
            {
                newhealth = ratio;
                veryhurttime = 3000;
                
                if ( player hasperk( "specialty_healthregen" ) )
                {
                    veryhurttime = int( veryhurttime / getdvarfloat( "perk_healthRegenMultiplier" ) );
                }
                
                if ( gettime() > hurttime + veryhurttime )
                {
                    newhealth += regenrate;
                }
            }
            else if ( usetrueregen )
            {
                newhealth = ratio + regenrate;
            }
            else
            {
                newhealth = 1;
            }
            
            if ( newhealth >= 1 )
            {
                self player::reset_attacker_list();
                newhealth = 1;
            }
            
            if ( newhealth <= 0 )
            {
                return;
            }
            
            player setnormalhealth( newhealth );
            change = player.health - oldhealth;
            
            if ( change > 0 )
            {
                player decay_player_damages( change );
            }
            
            oldhealth = player.health;
            continue;
        }
        
        oldhealth = player.health;
        var_4d2b26fb = 0;
        hurttime = gettime();
        player.breathingstoptime = hurttime + 6000;
    }
}

// Namespace healthoverlay/healthoverlay
// Params 0
// Checksum 0x4a98596a, Offset: 0x978
// Size: 0x55c
function player_health_regen()
{
    self notify( #"hash_85de04b3" );
    self endon( #"hash_85de04b3" );
    self endon( #"end_healthregen" );
    
    if ( self.health <= 0 )
    {
        assert( !isalive( self ) );
        return;
    }
    
    maxhealth = self.health;
    oldhealth = maxhealth;
    player = self;
    var_4d2b26fb = 0;
    veryhurt = 0;
    player.breathingstoptime = -10000;
    lastsoundtime_recover = 0;
    hurttime = 0;
    var_e4a073c0 = 0;
    waittime = 0.1;
    
    while ( true )
    {
        lasttime = gettime();
        wait waittime;
        now = gettime();
        elapsedtime = now - lasttime;
        
        if ( elapsedtime <= 0 )
        {
            continue;
        }
        
        maxhealth = player.maxhealth;
        
        if ( maxhealth == 0 )
        {
            continue;
        }
        
        if ( player.health == maxhealth )
        {
            veryhurt = 0;
            
            if ( self.atbrinkofdeath === 1 )
            {
                self notify( #"challenge_survived_from_death" );
            }
            
            self.atbrinkofdeath = 0;
            continue;
        }
        
        if ( player.health <= 0 )
        {
            return;
        }
        
        if ( isdefined( player.laststand ) && player.laststand )
        {
            continue;
        }
        
        ratio = player.health / maxhealth;
        
        if ( ratio <= level.healthoverlaycutoff )
        {
            veryhurt = 1;
            self.atbrinkofdeath = 1;
            self.isneardeath = 1;
        }
        else
        {
            self.isneardeath = 0;
        }
        
        if ( player.health >= oldhealth )
        {
            regentime = int( self.healthregentime * 1000 );
            specialty_healthregen_enabled = 0;
            
            if ( specialty_healthregen_enabled && player hasperk( "specialty_healthregen" ) )
            {
                regentime = int( regentime / getdvarfloat( "perk_healthRegenMultiplier" ) );
            }
            
            healing_enabled = player.healing_enabled === 1;
            
            if ( healing_enabled )
            {
                regentime = 1;
            }
            
            if ( now - hurttime < regentime )
            {
                continue;
            }
            
            if ( regentime <= 0 )
            {
                continue;
            }
            
            if ( now - lastsoundtime_recover > regentime )
            {
                lastsoundtime_recover = now;
                self notify( #"snd_breathing_better" );
            }
            
            regenrate = healing_enabled ? player.playerrole.healthhealrate : player.playerrole.healthregenrate;
            regenamount = regenrate * elapsedtime / 1000 / maxhealth;
            var_e4a073c0 = ratio + regenamount;
            
            if ( var_e4a073c0 >= 1 )
            {
                self player::reset_attacker_list();
                var_e4a073c0 = 1;
                
                if ( oldhealth < maxhealth )
                {
                    player notify( #"fully_healed" );
                }
            }
            
            if ( var_e4a073c0 <= 0 )
            {
                return;
            }
            
            player setnormalhealth( var_e4a073c0 );
            change = player.health - oldhealth;
            
            if ( change > 0 )
            {
                player decay_player_damages( change );
            }
            
            oldhealth = player.health;
            continue;
        }
        
        oldhealth = player.health;
        var_4d2b26fb = 0;
        hurttime = gettime();
        player.breathingstoptime = hurttime + 6000;
    }
}

// Namespace healthoverlay/healthoverlay
// Params 1
// Checksum 0xfee8af5a, Offset: 0xee0
// Size: 0x102
function decay_player_damages( decay )
{
    if ( !isdefined( self.attackerdamage ) )
    {
        return;
    }
    
    for ( i = 0; i < self.attackerdamage.size ; i++ )
    {
        if ( !isdefined( self.attackerdamage[ i ] ) || !isdefined( self.attackerdamage[ i ].damage ) )
        {
            continue;
        }
        
        self.attackerdamage[ i ].damage -= decay;
        
        if ( self.attackerdamage[ i ].damage < 0 )
        {
            self.attackerdamage[ i ].damage = 0;
        }
    }
}

// Namespace healthoverlay/healthoverlay
// Params 1
// Checksum 0x1e2a9fe2, Offset: 0xff0
// Size: 0xf2
function player_breathing_sound( healthcap )
{
    self endon( #"end_healthregen" );
    wait 2;
    player = self;
    
    for ( ;; )
    {
        wait 0.2;
        
        if ( player.health <= 0 )
        {
            return;
        }
        
        if ( player util::isusingremote() )
        {
            continue;
        }
        
        if ( player.health >= healthcap )
        {
            continue;
        }
        
        if ( player.healthregentime <= 0 && gettime() > player.breathingstoptime )
        {
            continue;
        }
        
        player notify( #"snd_breathing_hurt" );
        wait 0.784;
        wait 0.1 + randomfloat( 0.8 );
    }
}

// Namespace healthoverlay/healthoverlay
// Params 1
// Checksum 0xe2f5760, Offset: 0x10f0
// Size: 0x14c
function player_heartbeat_sound( healthcap )
{
    self endon( #"end_healthregen" );
    self.hearbeatwait = 0.2;
    wait 2;
    player = self;
    
    for ( ;; )
    {
        wait 0.2;
        
        if ( player.health <= 0 )
        {
            return;
        }
        
        if ( player util::isusingremote() )
        {
            continue;
        }
        
        if ( player.health >= healthcap )
        {
            self.hearbeatwait = 0.3;
            continue;
        }
        
        if ( player.healthregentime <= 0 && gettime() > player.breathingstoptime )
        {
            self.hearbeatwait = 0.3;
            continue;
        }
        
        player playlocalsound( "mpl_player_heartbeat" );
        wait self.hearbeatwait;
        
        if ( self.hearbeatwait <= 0.6 )
        {
            self.hearbeatwait += 0.1;
        }
    }
}

