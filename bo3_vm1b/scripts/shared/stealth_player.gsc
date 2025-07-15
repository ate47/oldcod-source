#using scripts/cp/_util;
#using scripts/cp/gametypes/_globallogic_score;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/stealth;
#using scripts/shared/stealth_aware;
#using scripts/shared/stealth_debug;
#using scripts/shared/stealth_level;
#using scripts/shared/stealth_status;
#using scripts/shared/stealth_tagging;
#using scripts/shared/stealth_vo;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace stealth_player;

// Namespace stealth_player
// Params 0
// Checksum 0x71ad7c93, Offset: 0x3d8
// Size: 0x102
function init()
{
    assert( isplayer( self ) );
    assert( !isdefined( self.stealth ) );
    
    if ( !isdefined( self.stealth ) )
    {
        self.stealth = spawnstruct();
    }
    
    self.stealth.player_detected = 0;
    self.stealth.player_detect_count = 0;
    self thread stance_monitor_thread();
    self thread detected_monitor_thread();
    self stealth_tagging::init();
    self stealth_vo::init();
    
    /#
        self stealth_debug::init_debug();
    #/
    
    self thread function_7300ae66();
    self thread function_bb9ffa41();
    self thread function_ff057a95();
}

// Namespace stealth_player
// Params 0
// Checksum 0xe9c07cd6, Offset: 0x4e8
// Size: 0x2
function stop()
{
    
}

// Namespace stealth_player
// Params 0
// Checksum 0x1a194f56, Offset: 0x4f8
// Size: 0x42
function reset()
{
    self.stealth.vo_deck = undefined;
    self.stealth.var_b9ae563d = undefined;
    self.stealth.var_23eafafa = undefined;
    self.stealth.var_9f4ce919 = [];
}

// Namespace stealth_player
// Params 0
// Checksum 0xf1168d43, Offset: 0x548
// Size: 0x1e, Type: bool
function enabled()
{
    return isdefined( self.stealth ) && isdefined( self.stealth.player_detected );
}

// Namespace stealth_player
// Params 2
// Checksum 0xfd779d1e, Offset: 0x570
// Size: 0x22
function inc_detected( detector, alertvalue )
{
    self.stealth.player_detect_count++;
}

// Namespace stealth_player
// Params 2
// Checksum 0x30fdaf22, Offset: 0x5a0
// Size: 0x1c3
function inc_aware( detector, alertvalue )
{
    if ( !isdefined( self.stealth.sensing ) )
    {
        self.stealth.sensing = [];
    }
    
    furthestsq = 0;
    replace = -1;
    
    for ( i = 0; i < self.stealth.sensing.size ; i++ )
    {
        value = self detection_value( self.stealth.sensing[ i ] );
        
        if ( value == 127 || !isdefined( self.stealth.sensing[ i ] ) || self.stealth.sensing[ i ] == detector )
        {
            self.stealth.sensing[ i ] = detector;
            return;
        }
        
        distsq = distancesquared( self.stealth.sensing[ i ].origin, self.origin );
        
        if ( distsq > furthestsq )
        {
            furthestsq = distsq;
            replace = i;
        }
    }
    
    if ( self.stealth.sensing.size < 4 )
    {
        self.stealth.sensing[ self.stealth.sensing.size ] = detector;
        return;
    }
    
    distsq = distancesquared( detector.origin, self.origin );
    
    if ( distsq < furthestsq )
    {
        self.stealth.sensing[ replace ] = detector;
    }
}

// Namespace stealth_player
// Params 0
// Checksum 0x3abbf2cd, Offset: 0x770
// Size: 0x381
function function_ff057a95()
{
    self notify( #"hash_ff057a95" );
    self endon( #"hash_ff057a95" );
    self endon( #"disconnect" );
    self endon( #"stop_stealth" );
    assert( isdefined( self.stealth ) );
    
    if ( !isdefined( self.stealth.var_9f4ce919 ) )
    {
        self.stealth.var_9f4ce919 = [];
    }
    
    while ( true )
    {
        if ( !( isdefined( level.stealth.vo_callouts ) && level.stealth.vo_callouts ) )
        {
            wait 1;
            continue;
        }
        
        if ( self playerads() > 0.3 )
        {
            var_bd8fb968 = self hascybercomability( "cybercom_hijack" );
            eye = self geteye();
            eye_dir = anglestoforward( self getplayerangles() );
            targets = getaiteamarray( "axis" );
            
            if ( isdefined( level.stealth.var_581c13ae ) )
            {
                var_2680d17d = [];
                
                foreach ( tgt in level.stealth.var_581c13ae )
                {
                    if ( !isdefined( tgt ) )
                    {
                        continue;
                    }
                    
                    targets[ targets.size ] = tgt;
                    var_2680d17d[ var_2680d17d.size ] = tgt;
                }
                
                if ( var_2680d17d.size != level.stealth.var_581c13ae.size )
                {
                    level.stealth.var_581c13ae = var_2680d17d;
                }
            }
            
            foreach ( tgt in targets )
            {
                warnmsg = "careful";
                tgteye = tgt.origin;
                
                if ( issentient( tgt ) )
                {
                    tgteye = tgt geteye();
                }
                
                if ( isdefined( tgt.stealth_callout ) )
                {
                    warnmsg = tgt.stealth_callout;
                }
                else if ( isvehicle( tgt ) )
                {
                    if ( var_bd8fb968 && tgt isremotecontrol() )
                    {
                        warnmsg = "careful_hack";
                    }
                    else
                    {
                        warnmsg = "careful_" + tgt.archetype;
                    }
                }
                
                if ( isdefined( self.stealth.var_9f4ce919[ warnmsg ] ) )
                {
                    continue;
                }
                
                dir = vectornormalize( tgteye - eye );
                
                if ( vectordot( eye_dir, dir ) > 0.99 )
                {
                    if ( sighttracepassed( tgteye, eye, 0, undefined ) )
                    {
                        self stealth_vo::function_e3ae87b3( warnmsg );
                        self.stealth.var_9f4ce919[ warnmsg ] = 1;
                    }
                }
            }
        }
        
        wait 0.05;
    }
}

// Namespace stealth_player
// Params 1
// Checksum 0xb7308d19, Offset: 0xb00
// Size: 0x164
function detection_value( other )
{
    if ( !isdefined( other ) )
    {
        return 127;
    }
    
    if ( getdvarint( "stealth_display", 1 ) == 1 && isalive( other ) && !other.ignoreall )
    {
        value = other getstealthsightvalue( self ) * 49;
        bcansee = other stealth::can_see( self );
        bcombat = isdefined( other.stealth.aware_combat ) && isdefined( other.stealth.aware_combat[ self getentitynumber() ] );
        balert = isdefined( other.stealth.aware_alerted ) && isdefined( other.stealth.aware_alerted[ self getentitynumber() ] );
        
        if ( value > 0 || balert || bcombat )
        {
            if ( bcombat )
            {
                value = 50;
            }
            else if ( balert )
            {
                value = 49;
            }
            
            if ( bcansee || bcombat )
            {
                value += 50;
            }
            
            return int( value );
        }
    }
    
    return 127;
}

// Namespace stealth_player
// Params 1
// Checksum 0xdc30f6dc, Offset: 0xc70
// Size: 0x10a
function function_b9393d6c( awareness )
{
    vals = level stealth_level::get_parms( awareness );
    assert( isdefined( vals ) );
    maxvisibledist = vals.maxsightdist;
    
    if ( awareness != "combat" )
    {
        stance = self getstance();
        
        if ( isdefined( self.stealth.in_shadow ) && self.stealth.in_shadow )
        {
            maxvisibledist *= 0.5;
        }
        
        if ( stance == "prone" )
        {
            maxvisibledist *= 0.25;
        }
        else if ( stance == "crouch" )
        {
            maxvisibledist *= 0.5;
        }
    }
    
    self.maxvisibledist = maxvisibledist;
    self.maxseenfovcosine = vals.fovcosine;
    self.maxseenfovcosinez = vals.fovcosinez;
}

// Namespace stealth_player
// Params 1
// Checksum 0xc965aa39, Offset: 0xd88
// Size: 0x1a
function set_detected( detected )
{
    self.stealth.player_detected = detected;
}

// Namespace stealth_player
// Params 0
// Checksum 0x8a4232a2, Offset: 0xdb0
// Size: 0x25
function get_detected()
{
    if ( !self enabled() )
    {
        return 0;
    }
    
    return self.stealth.player_detected;
}

// Namespace stealth_player
// Params 0
// Checksum 0xc6d01e9a, Offset: 0xde0
// Size: 0xc1
function stance_monitor_thread()
{
    self endon( #"disconnect" );
    
    while ( true )
    {
        stance = self getstance();
        maxvisibledist = 1600;
        
        switch ( stance )
        {
            case "crouch":
                maxvisibledist = 800;
                break;
            default:
                maxvisibledist = 400;
                break;
        }
        
        if ( isdefined( self.stealth.in_shadow ) && isdefined( self.stealth ) && self.stealth.in_shadow )
        {
            maxvisibledist *= 0.5;
        }
        
        self.maxvisibledist = maxvisibledist;
        wait 0.25;
    }
}

// Namespace stealth_player
// Params 0
// Checksum 0x1c30f69f, Offset: 0xeb0
// Size: 0x5d
function detected_monitor_thread()
{
    self endon( #"disconnect" );
    self endon( #"stop_stealth" );
    
    while ( true )
    {
        self.stealth.player_detect_count = 0;
        wait 1;
        
        if ( self.stealth.player_detect_count <= 0 )
        {
            self set_detected( 0 );
        }
    }
}

// Namespace stealth_player
// Params 0
// Checksum 0x785f9677, Offset: 0xf18
// Size: 0x75
function function_7300ae66()
{
    self endon( #"disconnect" );
    self endon( #"stop_stealth" );
    wait 0.05;
    self set_ignore_me_one_to_one( 1 );
    
    while ( true )
    {
        self util::waittill_any( "spawned" );
        self function_b9393d6c( "high_alert" );
        wait 0.05;
        self set_ignore_me_one_to_one( 1 );
    }
}

// Namespace stealth_player
// Params 0
// Checksum 0x6ceecf26, Offset: 0xf98
// Size: 0x17d
function function_bb9ffa41()
{
    self endon( #"disconnect" );
    self endon( #"stop_stealth" );
    killedquickly = 0;
    
    while ( true )
    {
        kills = self globallogic_score::getpersstat( "kills" );
        
        if ( !isdefined( kills ) )
        {
            kills = 0;
        }
        
        lastkillcount = kills;
        lastkilltime = gettime();
        self waittill( #"killed_ai", victim, smeansofdeath, weapon );
        waittillframeend();
        
        if ( isdefined( victim ) && isdefined( victim.team ) && victim.team != "axis" )
        {
            self thread stealth_vo::function_e3ae87b3( "fail_kill" );
            continue;
        }
        
        kills = self globallogic_score::getpersstat( "kills" );
        
        if ( !isdefined( kills ) )
        {
            kills = 1;
        }
        
        deltakills = kills - lastkillcount;
        
        if ( gettime() - lastkilltime > 1000 )
        {
            killedquickly = 0;
        }
        
        if ( deltakills >= 2 && isdefined( smeansofdeath ) && util::isbulletimpactmod( smeansofdeath ) )
        {
            self notify( #"double_kill" );
        }
        
        killedquickly += deltakills;
        
        if ( !isdefined( self.stealth ) )
        {
            return;
        }
        
        if ( !isdefined( level.stealth ) )
        {
            return;
        }
        
        self thread function_e507ced8( victim, smeansofdeath, weapon, killedquickly );
    }
}

// Namespace stealth_player
// Params 4
// Checksum 0xda04eed2, Offset: 0x1120
// Size: 0x119
function function_e507ced8( victim, smeansofdeath, weapon, killcount )
{
    self notify( #"hash_e507ced8" );
    self endon( #"hash_e507ced8" );
    self endon( #"disconnect" );
    self endon( #"stop_stealth" );
    self endon( #"death" );
    
    if ( !level flag::get( "stealth_alert" ) && !level flag::get( "stealth_combat" ) && !level flag::get( "stealth_discovered" ) )
    {
        if ( isdefined( victim ) && isdefined( victim.var_99baf927 ) )
        {
            self stealth_vo::function_e3ae87b3( victim.var_99baf927 );
            return;
        }
        
        if ( !( isdefined( level.stealth.var_30d9fcc6 ) && level.stealth.var_30d9fcc6 ) )
        {
            if ( killcount > 1 )
            {
                return;
            }
            
            if ( isdefined( weapon ) && weapon.type == "bullet" )
            {
            }
        }
    }
}

// Namespace stealth_player
// Params 1
// Checksum 0x49ed1751, Offset: 0x1248
// Size: 0xdb
function set_ignore_me_one_to_one( ignore )
{
    if ( !isdefined( level.stealth ) )
    {
        return;
    }
    
    if ( !isdefined( level.stealth.enemies ) )
    {
        return;
    }
    
    if ( !isdefined( level.stealth.enemies[ self.team ] ) )
    {
        return;
    }
    
    foreach ( enemy in level.stealth.enemies[ self.team ] )
    {
        if ( !isdefined( enemy ) )
        {
            continue;
        }
        
        if ( enemy stealth_aware::enabled() )
        {
            enemy stealth_aware::set_ignore_sentient( self, ignore );
        }
    }
}

// Namespace stealth_player
// Params 3
// Checksum 0x95b4a73c, Offset: 0x1330
// Size: 0xca
function update_audio( e_other, bcansee, awareness )
{
    if ( getdvarint( "stealth_audio", 1 ) == 0 )
    {
        return;
    }
    
    bcombat = awareness == "combat";
    
    if ( !self enabled() )
    {
        return;
    }
    
    if ( !( isdefined( self.stealth.player_detected ) && self.stealth.player_detected ) )
    {
        if ( !bcombat )
        {
            if ( bcansee )
            {
                self thread sighting_thread( awareness );
            }
        }
        
        if ( bcombat )
        {
            self.stealth.player_detected = 1;
            self thread function_e6e6afd7( e_other );
        }
    }
}

// Namespace stealth_player
// Params 1
// Checksum 0x1dbf8c4e, Offset: 0x1408
// Size: 0x5a
function function_e6e6afd7( e_other )
{
    self endon( #"disconnect" );
    result = e_other util::waittill_any_timeout( 0.25, "death" );
    
    if ( result == "timeout" )
    {
        self thread stealth_broken_sound();
    }
}

// Namespace stealth_player
// Params 1
// Checksum 0xaa67592, Offset: 0x1470
// Size: 0x8a
function sighting_thread( awareness )
{
    self notify( #"sighting_thread" );
    self endon( #"sighting_thread" );
    self endon( #"disconnect" );
    self endon( #"stop_stealth" );
    self endon( #"death" );
    sighting_field = 1;
    
    if ( awareness == "high_alert" )
    {
        sighting_field = 2;
    }
    
    self clientfield::set_to_player( "stealth_sighting", sighting_field );
    wait 0.15;
    self clientfield::set_to_player( "stealth_sighting", 0 );
}

// Namespace stealth_player
// Params 0
// Checksum 0x2d92e7ff, Offset: 0x1508
// Size: 0x62
function alerted_thread()
{
    self notify( #"alerted_thread" );
    self endon( #"alerted_thread" );
    self endon( #"disconnect" );
    self endon( #"stop_stealth" );
    self endon( #"death" );
    self clientfield::set_to_player( "stealth_alerted", 1 );
    wait 0.15;
    self clientfield::set_to_player( "stealth_alerted", 0 );
}

// Namespace stealth_player
// Params 0
// Checksum 0x2b893bf3, Offset: 0x1578
// Size: 0x1a
function stealth_broken_sound()
{
    stealth::function_e0319e51( "combat" );
}

// Namespace stealth_player
// Params 1
// Checksum 0xa38e79da, Offset: 0x15a0
// Size: 0x62
function function_ca6a0809( enemy )
{
    if ( enemy stealth_aware::enabled() && enemy stealth_aware::get_awareness() == "combat" )
    {
        return;
    }
    
    self thread function_509ca7a6( enemy );
    self thread function_3f6bd04c( enemy );
}

// Namespace stealth_player
// Params 1
// Checksum 0xc4022a92, Offset: 0x1610
// Size: 0x532
function function_509ca7a6( enemy )
{
    now = gettime();
    starttimems = now;
    entnum = self getentitynumber();
    assert( isdefined( enemy ) );
    assert( isdefined( enemy.stealth ) );
    
    if ( isdefined( self.stealth.incombat ) && self.stealth.incombat )
    {
        return;
    }
    
    if ( isdefined( enemy.stealth.var_d1c69a51 ) && isdefined( enemy.stealth.var_d1c69a51[ entnum ] ) && now - enemy.stealth.var_d1c69a51[ entnum ] < 20000 )
    {
        return;
    }
    
    if ( getdvarint( "stealth_indicator", 0 ) )
    {
        enemy notify( "sight_indicator_" + entnum );
        enemy endon( "sight_indicator_" + entnum );
        enemy endon( #"death" );
        
        if ( !isdefined( enemy.stealth.var_d1c69a51 ) )
        {
            enemy.stealth.var_d1c69a51 = [];
        }
        
        enemy.stealth.var_d1c69a51[ entnum ] = now;
        basealpha = 0.67;
        var_f69107b4 = 1000;
        index = entnum + var_f69107b4;
        enemy stealth_status::icon_show( self, var_f69107b4 );
        str_shader = "white_stealth_spotting";
        color = ( 1, 1, 1 );
        
        if ( isdefined( enemy.stealth.status.icon_ent ) && isdefined( enemy.stealth.status.icons[ index ] ) )
        {
            enemy.stealth.status.icons[ index ] settargetent( enemy.stealth.status.icon_ent );
            enemy.stealth.status.icons[ index ] setshader( str_shader, 5, 5 );
            enemy.stealth.status.icons[ index ] setwaypoint( 0, str_shader, 0, 0 );
            enemy.stealth.status.icons[ index ].color = color;
            enemy.stealth.status.icons[ index ].alpha = basealpha;
            enemy.stealth.status.icons[ index ].var_c3d91e16 = gettime();
        }
        
        var_8c974758 = 1 * 1000;
        var_61fba14c = min( 1000, var_8c974758 );
        currenttimems = 0;
        
        while ( currenttimems < var_8c974758 )
        {
            if ( enemy stealth_aware::get_awareness() == "combat" )
            {
                currenttimems = max( var_8c974758 - var_61fba14c, currenttimems );
            }
            
            var_ddb74378 = basealpha + sin( float( gettime() ) ) * ( 1 - basealpha );
            
            if ( var_8c974758 - currenttimems <= var_61fba14c && isdefined( enemy.stealth.status.icon_ent ) && isdefined( enemy.stealth.status.icons[ index ] ) )
            {
                alpha = var_ddb74378 * float( var_8c974758 - currenttimems ) / float( var_61fba14c );
                enemy.stealth.status.icons[ index ].alpha = min( max( alpha, 0 ), 1 );
            }
            else
            {
                enemy.stealth.status.icons[ index ].alpha = min( max( var_ddb74378, 0 ), 1 );
            }
            
            wait 0.05;
            currenttimems += 50;
        }
        
        enemy stealth_status::function_180adb28( index, var_f69107b4 );
    }
}

// Namespace stealth_player
// Params 1
// Checksum 0xc431a1e1, Offset: 0x1b50
// Size: 0x1f2
function function_3f6bd04c( enemy )
{
    assert( isdefined( self.stealth ) );
    now = gettime();
    
    if ( isdefined( self.stealth.incombat ) && self.stealth.incombat )
    {
        return;
    }
    
    if ( isdefined( self.stealth.var_45848ab ) && now - self.stealth.var_45848ab < 20000 )
    {
        return;
    }
    
    self notify( #"hash_3f6bd04c" );
    self endon( #"hash_3f6bd04c" );
    self endon( #"disconnect" );
    self endon( #"stop_stealth" );
    self.stealth.var_45848ab = now;
    localyaw = self.angles[ 1 ] - vectortoangles( enemy.origin - self.origin )[ 1 ];
    var_a113a204 = vectortoangles( enemy.origin - self.origin )[ 0 ];
    var_a113a204 = angleclamp180( var_a113a204 );
    
    if ( localyaw < 0 )
    {
        localyaw += 360;
    }
    
    var_be26784d = "enemy_behind";
    
    if ( var_a113a204 > 45 )
    {
        var_be26784d = "enemy_below";
    }
    else if ( var_a113a204 < -45 )
    {
        var_be26784d = "enemy_above";
    }
    else if ( localyaw >= 315 || localyaw <= 45 )
    {
        var_be26784d = "enemy_ahead";
    }
    else if ( localyaw >= 45 && localyaw <= -121 )
    {
        var_be26784d = "enemy_right";
    }
    else if ( localyaw >= -31 && localyaw <= 315 )
    {
        var_be26784d = "enemy_left";
    }
    
    self stealth_vo::function_866c6270( var_be26784d, 1 );
}

