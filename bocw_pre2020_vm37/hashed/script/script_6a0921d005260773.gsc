#using scripts\core_common\ai\systems\gib;
#using scripts\cp_common\bb;

#namespace abilities;

/#

    // Namespace abilities/namespace_c78c9cc2
    // Params 0
    // Checksum 0x7f24b74e, Offset: 0xc0
    // Size: 0x46, Type: dev
    function function_9b38e79c()
    {
        self endon( #"death" );
        
        for ( ;; )
        {
            debug_arrow( self.origin, self.angles );
            waitframe( 1 );
        }
    }

    // Namespace abilities/namespace_c78c9cc2
    // Params 3
    // Checksum 0xa9f7c93a, Offset: 0x110
    // Size: 0x27c, Type: dev
    function debug_arrow( org, ang, opcolor )
    {
        forward = anglestoforward( ang );
        forwardfar = vectorscale( forward, 50 );
        forwardclose = vectorscale( forward, 50 * 0.8 );
        right = anglestoright( ang );
        leftdraw = vectorscale( right, 50 * -0.2 );
        rightdraw = vectorscale( right, 50 * 0.2 );
        up = anglestoup( ang );
        right = vectorscale( right, 50 );
        up = vectorscale( up, 50 );
        red = ( 0.9, 0.2, 0.2 );
        green = ( 0.2, 0.9, 0.2 );
        blue = ( 0.2, 0.2, 0.9 );
        
        if ( isdefined( opcolor ) )
        {
            red = opcolor;
            green = opcolor;
            blue = opcolor;
        }
        
        line( org, org + forwardfar, red, 0.9 );
        line( org + forwardfar, org + forwardclose + rightdraw, red, 0.9 );
        line( org + forwardfar, org + forwardclose + leftdraw, red, 0.9 );
        line( org, org + right, blue, 0.9 );
        line( org, org + up, green, 0.9 );
    }

    // Namespace abilities/namespace_c78c9cc2
    // Params 4
    // Checksum 0xba863f4f, Offset: 0x398
    // Size: 0x94, Type: dev
    function debug_circle( origin, radius, seconds, color )
    {
        if ( !isdefined( seconds ) )
        {
            seconds = 1;
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 1, 0, 0 );
        }
        
        frames = int( 20 * seconds );
        circle( origin, radius, color, 0, 1, frames );
    }

#/

// Namespace abilities/namespace_c78c9cc2
// Params 3
// Checksum 0xbcbaa675, Offset: 0x438
// Size: 0x6a
function function_519ae1ed( origin, entarray, max )
{
    if ( !isdefined( entarray ) )
    {
        return;
    }
    
    if ( entarray.size == 0 )
    {
        return;
    }
    
    arraysortclosest( entarray, origin, 1, 0, isdefined( max ) ? max : 2048 );
    return entarray[ 0 ];
}

// Namespace abilities/namespace_c78c9cc2
// Params 1
// Checksum 0x72a0442, Offset: 0x4b0
// Size: 0xc
function function_f9b48b95( *name )
{
    
}

// Namespace abilities/namespace_c78c9cc2
// Params 0
// Checksum 0x757921ee, Offset: 0x4c8
// Size: 0xfe
function function_23c1f0b0()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self function_6d4cf28e();
    
    foreach ( ability in level.abilities.abilities )
    {
        if ( !isdefined( ability ) )
        {
            continue;
        }
        
        flag = function_f9b48b95( ability.name );
        
        if ( isdefined( flag ) )
        {
            self.abilities.var_b10e8797 |= flag;
        }
    }
}

// Namespace abilities/namespace_c78c9cc2
// Params 1
// Checksum 0x35ff772a, Offset: 0x5d0
// Size: 0x76
function function_f204ea98( name )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    flag = function_f9b48b95( name );
    
    if ( !isdefined( flag ) )
    {
        return;
    }
    
    self function_6d4cf28e();
    self.abilities.var_b10e8797 |= flag;
}

// Namespace abilities/namespace_c78c9cc2
// Params 1
// Checksum 0x36c7d6af, Offset: 0x650
// Size: 0x7e
function function_8fe77681( name )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self function_6d4cf28e();
    flag = function_f9b48b95( name );
    
    if ( !isdefined( flag ) )
    {
        return;
    }
    
    self.abilities.var_b10e8797 &= ~flag;
}

// Namespace abilities/namespace_c78c9cc2
// Params 1
// Checksum 0x11949c62, Offset: 0x6d8
// Size: 0xa4, Type: bool
function function_113a6123( name )
{
    if ( !isdefined( self ) )
    {
        return false;
    }
    
    if ( is_true( self.nocybercom ) )
    {
        return true;
    }
    
    self function_6d4cf28e();
    flag = function_f9b48b95( name );
    
    if ( !isdefined( flag ) )
    {
        return false;
    }
    
    if ( self.abilities.var_b10e8797 & flag )
    {
        return true;
    }
    
    return false;
}

// Namespace abilities/namespace_c78c9cc2
// Params 0
// Checksum 0xa7f2ac82, Offset: 0x788
// Size: 0x52
function function_6d4cf28e()
{
    if ( !isdefined( self.abilities ) )
    {
        self.abilities = spawnstruct();
    }
    
    if ( !isdefined( self.abilities.var_b10e8797 ) )
    {
        self.abilities.var_b10e8797 = 0;
    }
}

// Namespace abilities/namespace_c78c9cc2
// Params 2
// Checksum 0x286dbe0b, Offset: 0x7e8
// Size: 0x5c
function function_571f1a4b( note, animname )
{
    self endon( note, #"death" );
    self waittillmatch( { #notetrack:"end" }, animname );
    self notify( note );
}

// Namespace abilities/namespace_c78c9cc2
// Params 5
// Checksum 0xe078379d, Offset: 0x850
// Size: 0x15c
function function_196c351c( note, animname, kill = 0, attacker, weapon )
{
    self notify( "stopOnNotify" + note + animname );
    self endon( "stopOnNotify" + note + animname );
    
    if ( isdefined( animname ) )
    {
        self thread function_571f1a4b( "stopOnNotify" + note + animname, animname );
    }
    
    self waittill( note, #"death" );
    
    if ( isdefined( self ) && self isinscriptedstate() )
    {
        self stopanimscripted( 0.3 );
    }
    
    if ( isalive( self ) && is_true( kill ) )
    {
        self kill( self.origin, isdefined( attacker ) ? attacker : undefined, undefined, weapon );
    }
}

// Namespace abilities/namespace_c78c9cc2
// Params 0
// Checksum 0x4231cf26, Offset: 0x9b8
// Size: 0xd2, Type: bool
function function_ee76cb20()
{
    if ( isdefined( self.allowdeath ) )
    {
        if ( self.allowdeath == 0 )
        {
            return false;
        }
    }
    
    if ( is_true( self.var_4bc8b4c4 ) )
    {
        return true;
    }
    
    if ( isdefined( self.var_8fbb3e63 ) )
    {
        return true;
    }
    
    if ( isdefined( self.archetype ) && self.archetype == "robot" && !function_4b870e5a( self ) )
    {
        return true;
    }
    
    if ( isactor( self ) && !self isonground() )
    {
        return true;
    }
    
    return false;
}

// Namespace abilities/namespace_c78c9cc2
// Params 0
// Checksum 0xaf11ca57, Offset: 0xa98
// Size: 0x1c, Type: bool
function islinked()
{
    return isdefined( self getlinkedent() );
}

// Namespace abilities/namespace_c78c9cc2
// Params 2
// Checksum 0x34d72c59, Offset: 0xac0
// Size: 0xe2
function function_733a4915( context, max = 2 )
{
    if ( !isdefined( self.abilities.variants ) )
    {
        self.abilities.variants = [];
    }
    
    if ( isdefined( self.abilities.variants[ context ] ) )
    {
        self.abilities.variants[ context ] = undefined;
    }
    
    self.abilities.variants[ context ] = spawnstruct();
    self.abilities.variants[ context ].var_20f37629 = 0;
    self.abilities.variants[ context ].var_67ce2ba5 = max;
}

// Namespace abilities/namespace_c78c9cc2
// Params 1
// Checksum 0xc0fa158, Offset: 0xbb0
// Size: 0x12
function function_566e25f9( *context )
{
    return "";
}

/#

    // Namespace abilities/namespace_c78c9cc2
    // Params 6
    // Checksum 0xcc5c9ec, Offset: 0xbd0
    // Size: 0x8c, Type: dev
    function function_e20f02eb( origin, mins, maxs, yaw, frames, color )
    {
        if ( !isdefined( yaw ) )
        {
            yaw = 0;
        }
        
        if ( !isdefined( frames ) )
        {
            frames = 20;
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 1, 0, 0 );
        }
        
        box( origin, mins, maxs, yaw, color, 1, 0, frames );
    }

    // Namespace abilities/namespace_c78c9cc2
    // Params 5
    // Checksum 0xf14db597, Offset: 0xc68
    // Size: 0xcc, Type: dev
    function debug_sphere( origin, radius, color, alpha, timeframes )
    {
        if ( !isdefined( color ) )
        {
            color = ( 1, 0, 0 );
        }
        
        if ( !isdefined( alpha ) )
        {
            alpha = 0.1;
        }
        
        if ( !isdefined( timeframes ) )
        {
            timeframes = 1;
        }
        
        sides = int( 10 * ( 1 + int( radius ) % 100 ) );
        sphere( origin, radius, color, alpha, 1, sides, timeframes );
    }

#/

// Namespace abilities/namespace_c78c9cc2
// Params 2
// Checksum 0x5e9d1011, Offset: 0xd40
// Size: 0x3a
function function_eb47c624( note, seconds )
{
    self endon( note, #"death" );
    wait seconds;
    self notify( note );
}

// Namespace abilities/namespace_c78c9cc2
// Params 2
// Checksum 0xb11e0f31, Offset: 0xd88
// Size: 0x40
function function_2a64e6ca( note, var_9b99ed8a )
{
    self endon( note, #"death" );
    self waittill( var_9b99ed8a );
    self notify( note );
}

// Namespace abilities/namespace_c78c9cc2
// Params 2
// Checksum 0x5924a9c9, Offset: 0xdd0
// Size: 0x54
function function_edf9c875( note, ent )
{
    ent endon( #"death" );
    self waittill( note );
    
    if ( isdefined( ent ) )
    {
        ent delete();
    }
}

// Namespace abilities/namespace_c78c9cc2
// Params 0
// Checksum 0xb1614613, Offset: 0xe30
// Size: 0xb4
function getentitypose()
{
    assert( isactor( self ) || isplayer( self ), "<dev string:x38>" );
    
    if ( isactor( self ) )
    {
        return self getblackboardattribute( "_stance" );
    }
    
    if ( isplayer( self ) )
    {
        return self getstance();
    }
}

// Namespace abilities/namespace_c78c9cc2
// Params 0
// Checksum 0x16b1f873, Offset: 0xef0
// Size: 0xa6
function function_650c0f8f()
{
    assert( isactor( self ) || isplayer( self ), "<dev string:x38>" );
    stance = self getentitypose();
    
    if ( stance == "stand" )
    {
        return "stn";
    }
    
    if ( stance == "crouch" )
    {
        return "crc";
    }
    
    return "";
}

/#

    // Namespace abilities/namespace_c78c9cc2
    // Params 1
    // Checksum 0xcd099beb, Offset: 0xfa0
    // Size: 0x34, Type: dev
    function debugmsg( txt )
    {
        println( "<dev string:x62>" + txt );
    }

#/

// Namespace abilities/namespace_c78c9cc2
// Params 1
// Checksum 0xb23f832, Offset: 0xfe0
// Size: 0x74
function function_4b870e5a( entity )
{
    if ( is_true( entity.missinglegs ) )
    {
        return 0;
    }
    
    if ( is_true( entity.iscrawler ) )
    {
        return 0;
    }
    
    return gibserverutils::isgibbed( entity, 384 ) == 0 ? 1 : 0;
}

// Namespace abilities/namespace_c78c9cc2
// Params 4
// Checksum 0xd6e45ff, Offset: 0x1060
// Size: 0x5c
function function_e0a4efa( slot, weapon, var_55cd789e, endnote )
{
    self endon( #"death", endnote );
    self waittill( var_55cd789e );
    self gadgetdeactivate( slot, weapon );
}

// Namespace abilities/namespace_c78c9cc2
// Params 1
// Checksum 0xe4336f49, Offset: 0x10c8
// Size: 0x62
function getyawtospot( spot )
{
    pos = spot;
    yaw = self.angles[ 1 ] - getyaw( pos );
    yaw = angleclamp180( yaw );
    return yaw;
}

// Namespace abilities/namespace_c78c9cc2
// Params 1
// Checksum 0x9e4a65a2, Offset: 0x1138
// Size: 0x3e
function getyaw( org )
{
    angles = vectortoangles( org - self.origin );
    return angles[ 1 ];
}

// Namespace abilities/namespace_c78c9cc2
// Params 3
// Checksum 0xc8cbc1cb, Offset: 0x1180
// Size: 0x160
function function_cc83a141( eattacker, eplayer, idamage )
{
    if ( !isplayer( eplayer ) || !isdefined( eattacker ) || !isdefined( eattacker.aitype ) )
    {
        return idamage;
    }
    
    if ( !isdefined( eplayer.abilities.var_69544378 ) || !eplayer.abilities.var_69544378 )
    {
        return idamage;
    }
    
    var_32419617 = level.var_277e6832[ eattacker.aitype ];
    
    if ( !isdefined( var_32419617 ) )
    {
        var_32419617 = level.var_277e6832[ #"default" ];
    }
    
    damage_scale = 1;
    distancetoplayer = distance( eattacker.origin, eplayer.origin );
    
    if ( distancetoplayer < 750 )
    {
        damage_scale = var_32419617.var_79b26a3f;
    }
    else if ( distancetoplayer < 1500 )
    {
        damage_scale = var_32419617.var_9fa71cab;
    }
    else
    {
        damage_scale = var_32419617.var_b9d1b33b;
    }
    
    return idamage * damage_scale;
}

// Namespace abilities/namespace_c78c9cc2
// Params 0
// Checksum 0x5e0b9b20, Offset: 0x12e8
// Size: 0x6c, Type: bool
function function_8107e1c2()
{
    if ( isdefined( self.currentweapon ) && ( self.currentweapon == getweapon( #"gadget_unstoppable_force" ) || self.currentweapon == getweapon( #"gadget_unstoppable_force_upgraded" ) ) )
    {
        return true;
    }
    
    return false;
}

