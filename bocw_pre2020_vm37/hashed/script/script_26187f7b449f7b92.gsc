#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_350cffecd05ef6cf;
#using script_40f967ad5d18ea74;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_74a56359b7d02ab6;
#using scripts\core_common\animation_shared;
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

#namespace namespace_4ff32993;

// Namespace namespace_4ff32993/namespace_11d7d604
// Params 0
// Checksum 0x5d4d50a8, Offset: 0x2c0
// Size: 0x3a
function init()
{
    level.doa.var_69216afe = [];
    level.doa.var_44b1769d = getweapon( "zombietron_lmg" );
}

// Namespace namespace_4ff32993/namespace_11d7d604
// Params 1
// Checksum 0x6360d511, Offset: 0x308
// Size: 0x22e
function function_174651ce( bird )
{
    bird notify( #"hash_44f0d6121a2adcc6" );
    bird endon( #"hash_44f0d6121a2adcc6" );
    bird endon( #"death" );
    bird useanimtree( "generic" );
    curanim = "a_chicken_react_up_down";
    lastanim = "a_chicken_idle_peck";
    
    while ( isdefined( bird ) )
    {
        if ( is_true( self.var_89dad306 ) )
        {
            curanim = "a_chicken_react_up_down";
        }
        else if ( is_true( self.var_e1e5d308 ) )
        {
            curanim = "a_chicken_react_up_down";
        }
        else if ( is_true( self.var_329aedd ) )
        {
            curanim = "a_chicken_react_up_down";
            self.var_329aedd = undefined;
        }
        else if ( is_true( self.var_1ad5202b ) )
        {
            curanim = "a_chicken_react_to_front_notrans";
        }
        else if ( is_true( self.is_moving ) )
        {
            curanim = "a_chicken_run";
        }
        
        animlength = getanimlength( curanim );
        bird thread animation::play( curanim );
        wait animlength;
        lastanim = curanim;
        
        switch ( randomint( 3 ) )
        {
            case 0:
                curanim = "a_chicken_idle_peck";
                break;
            case 1:
                curanim = "a_chicken_idle_a";
                break;
            case 2:
                curanim = "a_chicken_idle";
                break;
        }
    }
}

// Namespace namespace_4ff32993/namespace_11d7d604
// Params 0
// Checksum 0xd5eed9, Offset: 0x540
// Size: 0x2c
function chicken_idle()
{
    self.angles = ( 0, 0, 0 );
    self thread function_174651ce( self );
}

// Namespace namespace_4ff32993/namespace_11d7d604
// Params 4
// Checksum 0x32d4b0ad, Offset: 0x578
// Size: 0x540
function add_a_chicken( model, scale, var_56fa7962, *var_706dd25e )
{
    if ( !isdefined( self.doa ) )
    {
        return;
    }
    
    if ( !mayspawnentity() )
    {
        return;
    }
    
    orb = namespace_ec06fe4a::spawnmodel( self.origin + ( 0, 0, 50 ), "tag_origin" );
    
    if ( isdefined( orb ) )
    {
        orb.targetname = "add_a_chicken";
        orb enablelinkto();
        orb notsolid();
    }
    else
    {
        return;
    }
    
    bird = namespace_ec06fe4a::spawnmodel( orb.origin, scale );
    
    if ( isdefined( bird ) )
    {
        bird.targetname = "chicken";
        bird linkto( orb, "tag_origin" );
        bird notsolid();
        bird setscale( var_56fa7962 );
    }
    else
    {
        orb delete();
        return;
    }
    
    orb.basescale = var_56fa7962;
    orb.bird = bird;
    bird.orb = orb;
    orb.player = self;
    orb.owner = self;
    bird.owner = self;
    bird.team = self.team;
    bird.donotdamageowner = 1;
    orb.team = self.team;
    orb.special = var_706dd25e;
    orb.var_3e3b0c6e = 0;
    orb.var_7d2d343c = 0;
    orb.var_ce3eecd4 = self.doa.var_20c63763.size == 0 ? self : self.doa.var_20c63763[ self.doa.var_20c63763.size - 1 ];
    orb enablelinkto();
    orb thread function_174651ce( bird );
    
    if ( is_true( orb.special ) && self.doa.var_20c63763.size > 0 )
    {
        arrayinsert( self.doa.var_20c63763, orb, 0 );
        var_62d4927b = self;
        
        foreach ( chicken in self.doa.var_20c63763 )
        {
            chicken.var_ce3eecd4 = var_62d4927b;
            var_62d4927b = chicken;
        }
    }
    else
    {
        self.doa.var_20c63763[ self.doa.var_20c63763.size ] = orb;
    }
    
    if ( self.doa.var_20c63763.size > 5 )
    {
        foreach ( chicken in self.doa.var_20c63763 )
        {
            if ( !isdefined( chicken ) )
            {
                continue;
            }
            
            if ( !is_true( chicken.special ) )
            {
                chicken notify( #"spin_out" );
                break;
            }
        }
    }
    
    orb thread function_a083a332( self );
    orb thread function_1284a4d7( self );
    orb thread function_723d0c4c( self );
    orb thread function_26d43617( self );
    orb thread function_a5d7e43d();
    orb thread function_e4dfa7dc();
    orb thread function_9d0fe581( self );
    orb thread function_5d7057fa();
    return orb;
}

// Namespace namespace_4ff32993/namespace_11d7d604
// Params 0
// Checksum 0xa985fec8, Offset: 0xac0
// Size: 0xcc
function function_f30a62f4()
{
    if ( !isdefined( self.doa.var_20c63763 ) )
    {
        return;
    }
    
    foreach ( bird in self.doa.var_20c63763 )
    {
        if ( is_true( bird.special ) )
        {
            continue;
        }
        
        bird notify( #"spin_out", 1 );
    }
}

// Namespace namespace_4ff32993/namespace_11d7d604
// Params 1
// Checksum 0x24a38be4, Offset: 0xb98
// Size: 0x7e
function function_a083a332( player )
{
    self endon( #"death" );
    player waittill( #"disconnect" );
    
    if ( is_true( self.special ) )
    {
        self function_a7be9625();
        return;
    }
    
    self notify( #"spin_out" );
}

// Namespace namespace_4ff32993/namespace_11d7d604
// Params 0
// Checksum 0x65c88e80, Offset: 0xc20
// Size: 0xe6
function function_a7be9625()
{
    if ( is_true( self.special ) )
    {
        self namespace_e32bb68::function_3a59ec34( "evt_doa_pickup_chicken_squawk_spinout" );
        self namespace_e32bb68::function_3a59ec34( "evt_doa_pickup_chicken_explode" );
        self.bird namespace_83eb6304::function_3ecfde67( "chicken_explode" );
        util::wait_network_frame();
        
        if ( isdefined( self.bird ) )
        {
            self.bird delete();
        }
        
        self delete();
        return;
    }
    
    self notify( #"spin_out" );
}

// Namespace namespace_4ff32993/namespace_11d7d604
// Params 0
// Checksum 0x2df43035, Offset: 0xd10
// Size: 0x44
function function_5d7057fa()
{
    self endon( #"death" );
    level waittill( #"game_over" );
    self function_a7be9625();
}

// Namespace namespace_4ff32993/namespace_11d7d604
// Params 1
// Checksum 0xa29b0864, Offset: 0xd60
// Size: 0x324
function function_1284a4d7( player )
{
    self notify( "496544837d6dce57" );
    self endon( "496544837d6dce57" );
    self endon( #"death" );
    
    if ( is_true( self.special ) )
    {
        return;
    }
    
    result = self waittill( #"spin_out" );
    waittillframeend();
    self notify( #"spinning_out" );
    
    if ( isdefined( player ) )
    {
        arrayremovevalue( player.doa.var_20c63763, self );
    }
    
    if ( !is_true( result.immediate ) )
    {
        self.var_89dad306 = 1;
        self.var_4d2a40eb = 0;
        
        if ( isdefined( player ) )
        {
            var_92400dd7 = player;
            
            foreach ( chicken in player.doa.var_20c63763 )
            {
                chicken.var_ce3eecd4 = var_92400dd7;
                var_92400dd7 = chicken;
            }
            
            weapon = function_26c8b67( player );
            firetime = 0.15;
            self.var_4d2a40eb = randomfloatrange( 5, 8 );
        }
        
        while ( self.var_4d2a40eb > 0 )
        {
            var_45263d51 = 1;
            self rotateto( self.angles + ( 0, 180, 0 ), var_45263d51 );
            var_44f689f3 = var_45263d51;
            
            while ( var_44f689f3 > 0 )
            {
                self function_ecec052c( player, weapon );
                wait firetime;
                var_44f689f3 -= firetime;
            }
            
            self.var_4d2a40eb -= var_45263d51;
        }
    }
    
    self namespace_e32bb68::function_3a59ec34( "evt_doa_pickup_chicken_explode" );
    self.bird namespace_83eb6304::function_3ecfde67( "chicken_explode" );
    util::wait_network_frame();
    
    if ( isdefined( self.bird ) )
    {
        self.bird delete();
    }
    
    self delete();
}

// Namespace namespace_4ff32993/namespace_11d7d604
// Params 2
// Checksum 0x83ca0fb9, Offset: 0x1090
// Size: 0x44
function function_30bf476d( &var_f8b35ef5, var_39be60d3 )
{
    for ( i = 0; i < var_39be60d3 ; i++ )
    {
        var_f8b35ef5[ i ] = self.origin;
    }
}

// Namespace namespace_4ff32993/namespace_11d7d604
// Params 1
// Checksum 0x81d9f069, Offset: 0x10e0
// Size: 0x260
function function_9d0fe581( player )
{
    self endon( #"death" );
    self endon( #"spinning_out" );
    player endon( #"disconnect" );
    var_b39a52ca = 0;
    next_index = var_b39a52ca + 1;
    var_39be60d3 = 5;
    var_f8b35ef5 = [];
    self.var_85f8774c = 1;
    
    while ( true )
    {
        util::wait_network_frame();
        
        if ( self.var_85f8774c )
        {
            self.var_85f8774c = 0;
            function_30bf476d( var_f8b35ef5, var_39be60d3 );
        }
        
        if ( isdefined( self.var_ce3eecd4 ) )
        {
            angles = player getplayerangles();
            self.angles = ( angles[ 0 ], angles[ 1 ], 0 );
            self.is_moving = 0;
            
            if ( distance2dsquared( self.var_ce3eecd4.origin, var_f8b35ef5[ var_b39a52ca ] ) > sqr( 4 ) )
            {
                var_ad847a7d = self.var_ce3eecd4.origin;
                
                if ( isplayer( self.var_ce3eecd4 ) )
                {
                    if ( is_true( self.var_ce3eecd4.doa.infps ) || isdefined( self.var_706dd25e ) )
                    {
                        z = 20;
                    }
                    else
                    {
                        z = 50;
                    }
                    
                    var_ad847a7d += ( 0, 0, z );
                }
                
                var_f8b35ef5[ next_index ] = var_ad847a7d;
                var_b39a52ca = next_index;
                next_index++;
                next_index %= var_39be60d3;
                self.is_moving = 1;
                self moveto( var_f8b35ef5[ next_index ], 0.15, 0, 0 );
            }
        }
    }
}

// Namespace namespace_4ff32993/namespace_11d7d604
// Params 1
// Checksum 0xc6cfaf6e, Offset: 0x1348
// Size: 0x19e
function function_723d0c4c( player )
{
    self endon( #"spinning_out" );
    self endon( #"death" );
    timesec = player namespace_1c2a96f9::function_4808b985( 60 );
    
    if ( player namespace_1c2a96f9::function_d5b51f1e() )
    {
        timesec += 20;
    }
    
    time = timesec * 1000;
    timeout = gettime() + time;
    
    while ( !namespace_dfc652ee::function_f759a457() )
    {
        waitframe( 1 );
    }
    
    while ( gettime() < timeout )
    {
        if ( !isdefined( player ) || is_true( player.laststand ) )
        {
            self notify( #"spin_out" );
        }
        
        if ( level flag::get( "doa_game_is_over" ) )
        {
            self notify( #"spin_out" );
        }
        
        wait 0.25;
    }
    
    while ( is_true( self.var_e1e5d308 ) || is_true( self.var_1ad5202b ) )
    {
        wait 1;
    }
    
    self notify( #"spin_out" );
}

// Namespace namespace_4ff32993/namespace_11d7d604
// Params 1
// Checksum 0x3e314db8, Offset: 0x14f0
// Size: 0x7e
function function_26c8b67( player )
{
    if ( is_true( level.var_4bf9ea19 ) )
    {
        weapon = player getcurrentweapon();
    }
    else
    {
        weapon = [[ player.doa.weaponpack ]]->function_91c18b19( player.doa.weaponlevel );
    }
    
    return weapon;
}

// Namespace namespace_4ff32993/namespace_11d7d604
// Params 1
// Checksum 0x2762ca68, Offset: 0x1578
// Size: 0x13a
function function_56f05e91( player )
{
    player endon( #"disconnect" );
    self endon( #"death" );
    
    while ( isdefined( self ) && !is_true( self.var_89dad306 ) )
    {
        if ( isdefined( player.doa.vehicle ) )
        {
            msg = player.doa.vehicle waittilltimeout( 0.1, #"weapon_fired", #"gunner_weapon_fired", #"death" );
        }
        else
        {
            msg = player waittilltimeout( 0.1, #"weapon_fired", #"gunner_weapon_fired" );
        }
        
        if ( msg._notify != "timeout" )
        {
            self notify( #"chicken_fire" );
        }
    }
}

// Namespace namespace_4ff32993/namespace_11d7d604
// Params 1
// Checksum 0xf6683f6a, Offset: 0x16c0
// Size: 0x110
function function_26d43617( player )
{
    self endon( #"death" );
    self endon( #"spinning_out" );
    player endon( #"disconnect" );
    self thread function_56f05e91( player );
    
    while ( true )
    {
        self waittill( #"chicken_fire" );
        
        if ( is_true( self.var_a446cf09 ) )
        {
            continue;
        }
        
        weapon = self function_26c8b67( player );
        self function_ecec052c( player, weapon );
        extrawait = weapon.firetime - 0.05;
        
        if ( extrawait > 0 )
        {
            wait extrawait;
        }
    }
}

// Namespace namespace_4ff32993/namespace_11d7d604
// Params 2, eflags: 0x4
// Checksum 0x26daeab8, Offset: 0x17d8
// Size: 0x1e4
function private function_ecec052c( *player, weapon )
{
    angles = ( self.angles[ 0 ], self.angles[ 1 ], 0 );
    forward = anglestoforward( angles );
    offset = forward * 12 + ( 0, 0, 6 );
    start = self.bird.origin + offset;
    
    if ( getdvarint( #"hash_688eef6045c14ea9", 0 ) )
    {
        level thread namespace_1e25ad94::function_1d1f2c26( start, 5, 20, ( 1, 0, 0 ) );
        level thread namespace_1e25ad94::debugline( start, self.origin + forward * 1000, 5, ( 1, 0, 0 ) );
    }
    
    if ( weapon != level.weaponnone )
    {
        if ( level.doa.var_69216afe.size && isinarray( level.doa.var_69216afe, weapon ) )
        {
            weapon = level.doa.var_44b1769d;
        }
        
        projectile = magicbullet( weapon, start, start + forward * 1000, self.bird );
        
        if ( isdefined( projectile ) )
        {
            projectile thread namespace_ec06fe4a::function_52afe5df( 10 );
        }
    }
}

// Namespace namespace_4ff32993/namespace_11d7d604
// Params 0
// Checksum 0x38a94102, Offset: 0x19c8
// Size: 0x98
function function_e4dfa7dc()
{
    self endon( #"spinning_out" );
    self endon( #"death" );
    
    while ( isdefined( self ) )
    {
        rand = randomintrange( 0, 100 );
        
        if ( rand > 50 )
        {
            self namespace_e32bb68::function_3a59ec34( "evt_doa_pickup_chicken_squawk" );
        }
        
        wait randomfloatrange( 1, 3 );
    }
}

// Namespace namespace_4ff32993/namespace_11d7d604
// Params 0
// Checksum 0x7d5b6169, Offset: 0x1a68
// Size: 0x70
function function_a5d7e43d()
{
    self endon( #"death" );
    self waittill( #"spinning_out" );
    
    while ( isdefined( self ) )
    {
        self namespace_e32bb68::function_3a59ec34( "evt_doa_pickup_chicken_squawk_spinout" );
        wait randomfloatrange( 0.5, 1 );
    }
}

// Namespace namespace_4ff32993/namespace_11d7d604
// Params 0
// Checksum 0xa8eb7189, Offset: 0x1ae0
// Size: 0x13c
function function_73b8cd81()
{
    self notify( #"hash_5e13e601fac1829b" );
    self endon( #"hash_5e13e601fac1829b" );
    msg = self waittill( #"death", #"disconnect", #"hash_5e13e601fac1829b" );
    
    foreach ( chicken in self.doa.var_20c63763 )
    {
        if ( !isdefined( chicken ) )
        {
            continue;
        }
        
        if ( msg._notify == "disconnect" || !is_true( chicken.special ) )
        {
            chicken notify( #"spin_out" );
        }
    }
}

// Namespace namespace_4ff32993/namespace_11d7d604
// Params 3
// Checksum 0x9a2ac039, Offset: 0x1c28
// Size: 0x9a
function function_f69400ca( model, var_56fa7962 = 0, scale = 1 )
{
    if ( !isdefined( self.doa.var_20c63763 ) )
    {
        self.doa.var_20c63763 = [];
    }
    
    self thread function_73b8cd81();
    return self add_a_chicken( model, scale, var_56fa7962 != 0, var_56fa7962 == 2 );
}

// Namespace namespace_4ff32993/namespace_11d7d604
// Params 1
// Checksum 0x4ae64ec5, Offset: 0x1cd0
// Size: 0xaa
function function_13c591b6( player )
{
    number = 0;
    
    foreach ( chicken in player.doa.var_20c63763 )
    {
        if ( chicken == self )
        {
            break;
        }
        
        number++;
    }
    
    return number;
}

