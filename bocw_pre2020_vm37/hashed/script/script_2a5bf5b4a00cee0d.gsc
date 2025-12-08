#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_40f967ad5d18ea74;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_74a56359b7d02ab6;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_ec06fe4a;

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 1
// Checksum 0x2ea26f64, Offset: 0x2c0
// Size: 0x104
function function_ae010bb4( player )
{
    assert( isdefined( self ), "<dev string:x38>" );
    assert( isdefined( player ), "<dev string:x5c>" );
    assert( isplayer( player ), "<dev string:x82>" );
    self endon( #"death" );
    player waittill( #"disconnect" );
    
    if ( isdefined( self ) )
    {
        if ( isdefined( self.trigger ) )
        {
            self.trigger delete();
        }
        
        if ( isdefined( self.pickup ) )
        {
            self.pickup = undefined;
        }
        
        if ( isdefined( self ) )
        {
            self delete();
        }
    }
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 1
// Checksum 0x59e99ac3, Offset: 0x3d0
// Size: 0x52
function function_8ff7f92c( myteam = "allies" )
{
    team = util::getotherteam( myteam );
    return getaiteamarray( team );
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 1
// Checksum 0x3c35a92d, Offset: 0x430
// Size: 0x8c
function getclosestenemy( myteam = "allies" )
{
    team = util::getotherteam( myteam );
    enemy = getaiteamarray( team );
    guys = arraysortclosest( enemy, self.origin );
    return guys[ 0 ];
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 1
// Checksum 0x13801761, Offset: 0x4c8
// Size: 0x60
function addpoi( ent )
{
    arrayremovevalue( level.doa.var_af6d47dd, undefined );
    level.doa.var_af6d47dd[ level.doa.var_af6d47dd.size ] = ent;
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 2
// Checksum 0x332156ce, Offset: 0x530
// Size: 0x16a
function function_ff7594d7( origin, var_5e23c42a = sqr( 200 ) )
{
    arrayremovevalue( level.doa.var_af6d47dd, undefined );
    
    if ( level.doa.var_af6d47dd.size > 0 )
    {
        pois = arraysortclosest( level.doa.var_af6d47dd, origin );
        
        foreach ( poi in pois )
        {
            var_5e23c42a = isdefined( poi.var_7f3187c5 ) ? poi.var_7f3187c5 : var_5e23c42a;
            distsq = distancesquared( poi.origin, origin );
            
            if ( distsq < var_5e23c42a )
            {
                return poi;
            }
        }
    }
    
    return undefined;
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 1
// Checksum 0x84ae0756, Offset: 0x6a8
// Size: 0x24
function function_fb4eb048( team )
{
    return getaiteamarray( team ).size;
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 0
// Checksum 0x9bf08f29, Offset: 0x6d8
// Size: 0x14
function function_38de0ce8()
{
    return getaiarray().size;
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 1
// Checksum 0xb1fa1425, Offset: 0x6f8
// Size: 0x156
function function_9788bacc( myteam = "allies" )
{
    team = util::getotherteam( myteam );
    teamsize = 0;
    
    if ( isdefined( level.doa.var_e2e8967b ) )
    {
        if ( level.doa.var_e2e8967b.size )
        {
            arrayremovevalue( level.doa.var_e2e8967b, undefined );
        }
        
        foreach ( guy in level.doa.var_e2e8967b )
        {
            if ( guy.oldteam === team )
            {
                teamsize++;
            }
        }
    }
    
    teamsize += getaiteamarray( team ).size;
    return teamsize;
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 1
// Checksum 0xb8a9e53a, Offset: 0x858
// Size: 0x8c
function function_52afe5df( time )
{
    self endon( #"death" );
    wait time;
    
    if ( isdefined( self.anchor ) )
    {
        self.anchor delete();
    }
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger delete();
    }
    
    self delete();
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 0
// Checksum 0x3cfc1655, Offset: 0x8f0
// Size: 0x22
function function_b6b79fd1()
{
    while ( function_9788bacc() > 0 )
    {
        wait 1;
    }
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 2
// Checksum 0x2759bad7, Offset: 0x920
// Size: 0x58
function function_3b3bb5c( var_687ec70b, dmg )
{
    self endon( #"death" );
    
    while ( true )
    {
        wait var_687ec70b;
        self dodamage( dmg, self.origin );
    }
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 0
// Checksum 0xab6d61ba, Offset: 0x980
// Size: 0xea
function function_de70888a()
{
    while ( function_9788bacc() > 0 )
    {
        level.doa.var_dcbded2 = [];
        enemies = function_8ff7f92c();
        
        foreach ( badguy in enemies )
        {
            badguy thread function_570729f0( randomfloatrange( 0.1, 1 ) );
        }
        
        wait 1;
    }
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 1
// Checksum 0xff8175fb, Offset: 0xa78
// Size: 0xb8
function function_445bad70( frozen = 1 )
{
    players = getplayers();
    
    foreach ( player in players )
    {
        player freezecontrols( frozen );
    }
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 3
// Checksum 0xa3a382ad, Offset: 0xb38
// Size: 0x134
function function_570729f0( time, attacker, mod = "MOD_HIT_BY_OBJECT" )
{
    assert( !isplayer( self ) );
    self endon( #"death" );
    self.marked_for_death = 1;
    
    if ( time > 0 )
    {
        wait time;
    }
    
    self.takedamage = 1;
    self.allowdeath = 1;
    
    if ( isdefined( attacker ) )
    {
        self dodamage( self.health + 187, self.origin, attacker, attacker, "none", mod, 0, getweapon( "none" ) );
        return;
    }
    
    self dodamage( self.health + 187, self.origin );
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 4
// Checksum 0x12eceb9e, Offset: 0xc78
// Size: 0x144
function function_5678f0d( dir, var_594fccd3 = 100, var_f44be073 = 0.1, attacker )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self thread function_570729f0( var_f44be073, attacker );
    
    if ( is_true( self.var_e66cd6fb ) )
    {
        return;
    }
    
    namespace_1e25ad94::debugmsg( "ragdolling entity:" + self getentitynumber() + " of type:" + self.classname );
    self endon( #"death" );
    self setplayercollision( 0 );
    self startragdoll();
    
    if ( isdefined( dir ) )
    {
        dir = vectornormalize( dir );
        self launchragdoll( dir * var_594fccd3 );
    }
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 0
// Checksum 0x21c628a6, Offset: 0xdc8
// Size: 0xfc
function function_592e0d6b()
{
    self notify( "66ae2cdd7c7dbe40" );
    self endon( "66ae2cdd7c7dbe40" );
    
    while ( true )
    {
        wait 1;
        corpse_array = getcorpsearray();
        
        foreach ( corpse in corpse_array )
        {
            if ( !isdefined( corpse.var_b0d4cf4b ) )
            {
                corpse.var_b0d4cf4b = 5;
                corpse thread function_52afe5df( corpse.var_b0d4cf4b );
            }
        }
    }
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 1
// Checksum 0x543891fd, Offset: 0xed0
// Size: 0xdc
function clearallcorpses( num = 99 )
{
    level thread function_592e0d6b();
    corpse_array = getcorpsearray();
    
    if ( num == 99 )
    {
        total = corpse_array.size;
    }
    else
    {
        total = num;
    }
    
    for ( i = 0; i < total ; i++ )
    {
        if ( is_true( corpse_array[ i ].var_931f033a ) )
        {
            continue;
        }
        
        if ( isdefined( corpse_array[ i ] ) )
        {
            corpse_array[ i ] delete();
        }
    }
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 2
// Checksum 0x1bd1f89c, Offset: 0xfb8
// Size: 0xfc
function function_d55f042c( other, note )
{
    if ( !isdefined( other ) )
    {
        return;
    }
    
    self endon( #"death" );
    killnote = function_7fcca25d( "DeleteNote" );
    self thread function_719951d3( other, killnote );
    
    if ( isplayer( other ) )
    {
        if ( note == "disconnect" )
        {
            other waittill( note, killnote );
        }
        else
        {
            other waittill( note, #"disconnect", killnote );
        }
    }
    else
    {
        other waittill( note, killnote );
    }
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 3
// Checksum 0x5b600419, Offset: 0x10c0
// Size: 0xf6
function function_203591b7( other, note, var_df2b8649 )
{
    if ( !isdefined( other ) )
    {
        return;
    }
    
    self endon( #"death" );
    killnote = function_7fcca25d( "DeleteNote" );
    self thread function_719951d3( other, killnote );
    
    if ( isplayer( other ) )
    {
        if ( note == "disconnect" )
        {
            other waittill( note, killnote );
        }
        else
        {
            other waittill( note, #"disconnect", killnote );
        }
    }
    else
    {
        other waittill( note, killnote );
    }
    
    if ( isdefined( self ) )
    {
        self notify( var_df2b8649 );
    }
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 2
// Checksum 0x1089cf10, Offset: 0x11c0
// Size: 0x5c
function function_719951d3( other, note )
{
    self endon( note );
    other endon( #"death" );
    self waittill( #"death" );
    
    if ( isdefined( other ) )
    {
        other notify( note );
    }
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 2
// Checksum 0xb4e48452, Offset: 0x1228
// Size: 0x124
function function_ad852085( other, note )
{
    if ( !isdefined( other ) )
    {
        return;
    }
    
    self endon( #"death" );
    killnote = function_7fcca25d( "killNote" );
    self thread function_719951d3( other, killnote );
    
    if ( isplayer( other ) )
    {
        if ( note == "disconnect" )
        {
            other waittill( note, killnote );
        }
        else
        {
            other waittill( note, #"disconnect", killnote );
        }
    }
    else
    {
        other waittill( note, killnote );
    }
    
    if ( isdefined( self ) )
    {
        self notify( killnote );
        self.aioverridedamage = undefined;
        self.takedamage = 1;
        self.allowdeath = 1;
        self thread function_570729f0( 0 );
    }
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 2
// Checksum 0x13e32900, Offset: 0x1358
// Size: 0x5c
function deletemeonnotify( note, delay = 1 )
{
    self endon( #"death" );
    self waittill( note );
    wait delay;
    self delete();
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 1
// Checksum 0x3d5d0cab, Offset: 0x13c0
// Size: 0x60
function function_7fcca25d( note )
{
    if ( !isdefined( level.doa.var_3898afe7 ) )
    {
        level.doa.var_3898afe7 = 0;
    }
    
    level.doa.var_3898afe7++;
    return note + level.doa.var_3898afe7;
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 0
// Checksum 0x8bd61603, Offset: 0x1428
// Size: 0x58
function function_3390402b()
{
    if ( !isdefined( level.doa.var_8f229afa ) )
    {
        level.doa.var_8f229afa = 0;
    }
    
    level.doa.var_8f229afa++;
    return "doa_dynamic_" + level.doa.var_8f229afa;
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 1
// Checksum 0x1e6f9177, Offset: 0x1488
// Size: 0x2c
function function_9d713536( vel )
{
    return length( vel ) * 0.0568182;
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 1
// Checksum 0x2e921a2e, Offset: 0x14c0
// Size: 0x34
function function_f506b4c7( time = 4 )
{
    self thread function_2d920b3c( time );
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 2
// Checksum 0x1e68e62, Offset: 0x1500
// Size: 0xae
function function_2d920b3c( var_bf710acd = 0.6, clockwise = 1 )
{
    self endon( #"death" );
    angle = clockwise ? ( 0, 180, 0 ) : ( 0, -180, 0 );
    
    while ( isdefined( self ) )
    {
        self rotateto( self.angles + angle, var_bf710acd );
        wait var_bf710acd;
    }
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 3
// Checksum 0xdeaa0a4f, Offset: 0x15b8
// Size: 0x166
function function_8b1ae345( time = 2, dist = 24, killnote )
{
    self endon( #"death" );
    
    if ( isdefined( killnote ) )
    {
        self endon( killnote );
    }
    
    cycle_time = time;
    var_c421a5fd = dist;
    var_e9fa66c6 = cycle_time / 2;
    start_origin = self.origin;
    top = self.origin + ( 0, 0, var_c421a5fd );
    bottom = self.origin - ( 0, 0, var_c421a5fd );
    
    while ( true )
    {
        self moveto( top, var_e9fa66c6, 0.2, 0.2 );
        wait var_e9fa66c6;
        self moveto( bottom, var_e9fa66c6, 0.2, 0.2 );
        wait var_e9fa66c6;
    }
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 3
// Checksum 0x6a323ad3, Offset: 0x1728
// Size: 0xd6
function function_1ebe83a7( startscale, endscale = 1, timems = 3000 )
{
    self endon( #"death" );
    var_44bf347e = startscale;
    var_c7fbfa53 = ( endscale - startscale ) / timems / 50;
    endtime = gettime() + timems;
    
    while ( isdefined( self ) && gettime() < endtime )
    {
        var_44bf347e += var_c7fbfa53;
        self setscale( var_44bf347e );
        waitframe( 1 );
    }
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 1
// Checksum 0x9ea81311, Offset: 0x1808
// Size: 0x62
function getyawtospot( spot )
{
    pos = spot;
    yaw = self.angles[ 1 ] - getyaw( pos );
    yaw = angleclamp180( yaw );
    return yaw;
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 0
// Checksum 0xba4d7345, Offset: 0x1878
// Size: 0xca
function getyawtoenemy()
{
    pos = undefined;
    
    if ( isvalidenemy( self.enemy ) )
    {
        pos = self.enemy.origin;
    }
    else
    {
        forward = anglestoforward( self.angles );
        forward = vectorscale( forward, 150 );
        pos = self.origin + forward;
    }
    
    yaw = self.angles[ 1 ] - getyaw( pos );
    yaw = angleclamp180( yaw );
    return yaw;
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 1
// Checksum 0x45e2d825, Offset: 0x1950
// Size: 0x1c, Type: bool
function isvalidenemy( enemy )
{
    if ( !isdefined( enemy ) )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 1
// Checksum 0x13fe91e1, Offset: 0x1978
// Size: 0x3e
function getyaw( org )
{
    angles = vectortoangles( org - self.origin );
    return angles[ 1 ];
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 1
// Checksum 0x92f1f913, Offset: 0x19c0
// Size: 0x66
function getyaw2d( org )
{
    angles = vectortoangles( ( org[ 0 ], org[ 1 ], 0 ) - ( self.origin[ 0 ], self.origin[ 1 ], 0 ) );
    return angles[ 1 ];
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 0
// Checksum 0xe8717c40, Offset: 0x1a30
// Size: 0xa2
function absyawtoenemy()
{
    assert( isvalidenemy( self.enemy ) );
    yaw = self.angles[ 1 ] - getyaw( self.enemy.origin );
    yaw = angleclamp180( yaw );
    
    if ( yaw < 0 )
    {
        yaw = -1 * yaw;
    }
    
    return yaw;
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 0
// Checksum 0x8bfdd941, Offset: 0x1ae0
// Size: 0xa2
function absyawtoenemy2d()
{
    assert( isvalidenemy( self.enemy ) );
    yaw = self.angles[ 1 ] - getyaw2d( self.enemy.origin );
    yaw = angleclamp180( yaw );
    
    if ( yaw < 0 )
    {
        yaw = -1 * yaw;
    }
    
    return yaw;
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 1
// Checksum 0x982dcc61, Offset: 0x1b90
// Size: 0x6a
function absyawtoorigin( org )
{
    yaw = self.angles[ 1 ] - getyaw( org );
    yaw = angleclamp180( yaw );
    
    if ( yaw < 0 )
    {
        yaw = -1 * yaw;
    }
    
    return yaw;
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 1
// Checksum 0x43e7ec28, Offset: 0x1c08
// Size: 0x5a
function absyawtoangles( angles )
{
    yaw = self.angles[ 1 ] - angles;
    yaw = angleclamp180( yaw );
    
    if ( yaw < 0 )
    {
        yaw = -1 * yaw;
    }
    
    return yaw;
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 2
// Checksum 0xd1072219, Offset: 0x1c70
// Size: 0x3e
function getyawfromorigin( org, start )
{
    angles = vectortoangles( org - start );
    return angles[ 1 ];
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 2
// Checksum 0xb96eae52, Offset: 0x1cb8
// Size: 0x7a
function getyawtotag( tag, org )
{
    yaw = self gettagangles( tag )[ 1 ] - getyawfromorigin( org, self gettagorigin( tag ) );
    yaw = angleclamp180( yaw );
    return yaw;
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 1
// Checksum 0x64cb7168, Offset: 0x1d40
// Size: 0x52
function getyawtoorigin( org )
{
    yaw = self.angles[ 1 ] - getyaw( org );
    yaw = angleclamp180( yaw );
    return yaw;
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 1
// Checksum 0xf4bbf2ac, Offset: 0x1da0
// Size: 0x6a
function geteyeyawtoorigin( org )
{
    yaw = self gettagangles( "TAG_EYE" )[ 1 ] - getyaw( org );
    yaw = angleclamp180( yaw );
    return yaw;
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 1
// Checksum 0x958831c8, Offset: 0x1e18
// Size: 0x82
function getcovernodeyawtoorigin( org )
{
    yaw = self.covernode.angles[ 1 ] + self.animarray[ #"angle_step_out" ][ self.a.cornermode ] - getyaw( org );
    yaw = angleclamp180( yaw );
    return yaw;
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 2
// Checksum 0xcfdbd553, Offset: 0x1ea8
// Size: 0x98
function rotatevec( vector, angle )
{
    return ( vector[ 0 ] * cos( angle ) - vector[ 1 ] * sin( angle ), vector[ 0 ] * sin( angle ) + vector[ 1 ] * cos( angle ), vector[ 2 ] );
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 3
// Checksum 0x8d7755e9, Offset: 0x1f48
// Size: 0x86
function function_65ee50ba( start, updelta = 48, var_51a8354e = -1024 )
{
    s_trace = groundtrace( start + ( 0, 0, updelta ), start + ( 0, 0, var_51a8354e ), 0, self );
    return s_trace[ #"position" ];
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 2
// Checksum 0x1bd5c6f, Offset: 0x1fd8
// Size: 0xfe
function function_1a117d29( location, timesec = 1 )
{
    self notify( #"hash_1a927c82f4391e40" );
    self endon( #"hash_1a927c82f4391e40" );
    
    if ( timesec <= 0 )
    {
        timesec = 1;
    }
    
    frame = 1000 / function_60d95f53();
    increment = ( self.origin - location ) / timesec * 20;
    targettime = gettime() + timesec * 1000;
    
    while ( gettime() < targettime )
    {
        self.origin -= increment;
        waitframe( 1 );
    }
    
    self notify( #"movedone" );
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 0
// Checksum 0x13112583, Offset: 0x20e0
// Size: 0x10c
function function_ecec1794()
{
    self endon( #"death" );
    sticks = 0;
    lastorigin = self.origin;
    lastangles = self.angles;
    
    while ( sticks < 20 )
    {
        waitframe( 1 );
        var_bcb6ea2 = lengthsquared( lastangles - self.angles );
        var_4d6917c7 = distancesquared( lastorigin, self.origin );
        
        if ( var_4d6917c7 < sqr( 4 ) && var_bcb6ea2 < 0.1 )
        {
            sticks++;
            continue;
        }
        
        lastorigin = self.origin;
        lastangles = self.angles;
        sticks = 0;
    }
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 0
// Checksum 0xc4b23566, Offset: 0x21f8
// Size: 0x3a
function function_8c808737()
{
    self notify( #"hash_5251ab0953e7989f" );
    self ghost();
    self.var_cd7dffa1 = 1;
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 0
// Checksum 0xd00df1cd, Offset: 0x2240
// Size: 0x26
function function_4f72130c()
{
    self show();
    self.var_cd7dffa1 = 0;
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 2
// Checksum 0x1c89676a, Offset: 0x2270
// Size: 0x6c
function function_6eacecf5( origin, dist = 1024 )
{
    players = getplayers();
    closest = arraysortclosest( players, origin, 1, 0, dist );
    return closest[ 0 ];
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 2
// Checksum 0xecad560b, Offset: 0x22e8
// Size: 0x6c
function function_bd3709ce( origin, dist = 1024 )
{
    actors = getactorarray();
    closest = arraysortclosest( actors, origin, 1, 0, dist );
    return closest[ 0 ];
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 2
// Checksum 0x30b841c6, Offset: 0x2360
// Size: 0xa0
function function_f3eab80e( origin, dist = 1024 )
{
    ents = arraycombine( getplayers(), getactorarray() );
    closest = arraysortclosest( ents, origin, 1, 0, dist );
    
    if ( !closest.size )
    {
        return;
    }
    
    return closest[ 0 ];
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 5
// Checksum 0x16650d34, Offset: 0x2408
// Size: 0x7c
function function_87612422( spot, angles, priority = 1, lifetime = 3, lightstate = 0 )
{
    level thread util::create_streamer_hint( spot, angles, priority, lifetime, lightstate );
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 1
// Checksum 0x40eb04a7, Offset: 0x2490
// Size: 0x94
function function_2f4b0f9( health )
{
    if ( health <= 0 )
    {
        health = 0;
    }
    else
    {
        health = health / self.maxhealth * ( ( 1 << 8 ) - 1 );
    }
    
    self clientfield::set( "set_health_bar", int( health ) );
    self clientfield::set( "show_health_bar", 1 );
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 1
// Checksum 0xdfbb3800, Offset: 0x2530
// Size: 0x52
function spawnorigin( origin )
{
    if ( !mayspawnentity() )
    {
        return;
    }
    
    if ( !validateorigin( origin ) )
    {
        return;
    }
    
    return spawn( "script_origin", origin );
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 4
// Checksum 0xca81aea9, Offset: 0x2590
// Size: 0xda
function spawnmodel( origin, modelname = "tag_origin", angles, targetname )
{
    if ( !mayspawnentity() )
    {
        return;
    }
    
    if ( !validateorigin( origin ) )
    {
        return;
    }
    
    mdl = spawn( "script_model", origin );
    
    if ( isdefined( modelname ) )
    {
        mdl setmodel( modelname );
    }
    
    if ( isdefined( angles ) )
    {
        mdl.angles = angles;
    }
    
    if ( isdefined( targetname ) )
    {
        mdl.targetname = targetname;
    }
    
    return mdl;
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 6
// Checksum 0xe1b6807c, Offset: 0x2678
// Size: 0x118
function spawntrigger( triggertype, origin, flags = 1, var_bacb72c4, height, width )
{
    if ( !mayspawnfakeentity() )
    {
        return;
    }
    
    if ( !validateorigin( origin ) )
    {
        return;
    }
    
    if ( triggertype == "trigger_radius" || triggertype == "trigger_radius_use" )
    {
        trigger = spawn( triggertype, origin, flags, var_bacb72c4, height );
    }
    else if ( triggertype == "trigger_box" )
    {
        trigger = spawn( triggertype, origin, flags, var_bacb72c4, width, height );
    }
    else
    {
        assert( 0, "<dev string:xaa>" );
    }
    
    return trigger;
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 2
// Checksum 0x786bb60f, Offset: 0x2798
// Size: 0x124, Type: bool
function is_facing( facee, requireddot = 0.9 )
{
    orientation = self getplayerangles();
    forwardvec = anglestoforward( orientation );
    forwardvec2d = ( forwardvec[ 0 ], forwardvec[ 1 ], 0 );
    unitforwardvec2d = vectornormalize( forwardvec2d );
    tofaceevec = facee.origin - self.origin;
    tofaceevec2d = ( tofaceevec[ 0 ], tofaceevec[ 1 ], 0 );
    unittofaceevec2d = vectornormalize( tofaceevec2d );
    dotproduct = vectordot( unitforwardvec2d, unittofaceevec2d );
    return dotproduct > requireddot;
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 1
// Checksum 0x5c3bf105, Offset: 0x28c8
// Size: 0x7e, Type: bool
function is_explosive_damage( mod )
{
    if ( !isdefined( mod ) )
    {
        return false;
    }
    
    if ( mod == "MOD_GRENADE" || mod == "MOD_GRENADE_SPLASH" || mod == "MOD_PROJECTILE" || mod == "MOD_PROJECTILE_SPLASH" || mod == "MOD_EXPLOSIVE" )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 2
// Checksum 0xe664854, Offset: 0x2950
// Size: 0x16a
function function_2017393e( array, weights )
{
    assert( array.size == weights.size );
    
    if ( array.size > 0 )
    {
        var_766a145f = 0;
        keys = getarraykeys( array );
        
        foreach ( key in keys )
        {
            var_766a145f += weights[ key ];
        }
        
        var_ca23d24f = function_7ae7bf61( 0, var_766a145f );
        var_da00fb33 = keys[ 0 ];
        
        for ( i = 0; i < keys.size && var_ca23d24f >= 0 ; i++ )
        {
            var_da00fb33 = keys[ i ];
            var_ca23d24f -= weights[ var_da00fb33 ];
        }
        
        return array[ var_da00fb33 ];
    }
    
    return undefined;
}

// Namespace namespace_ec06fe4a/namespace_ec06fe4a
// Params 1
// Checksum 0x2b94b03c, Offset: 0x2ac8
// Size: 0x6c
function function_73d79e7d( parent )
{
    self notify( "58506a4282c94a80" );
    self endon( "58506a4282c94a80" );
    self endon( #"death", #"unlink" );
    
    while ( isdefined( parent ) )
    {
        self.origin = parent.origin;
        waitframe( 1 );
    }
}

