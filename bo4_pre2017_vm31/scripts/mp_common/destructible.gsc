#using scripts/core_common/challenges_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/mp_common/challenges;
#using scripts/mp_common/gametypes/battlechatter;
#using scripts/mp_common/gametypes/globallogic_player;

#namespace destructible;

// Namespace destructible/destructible
// Params 0, eflags: 0x2
// Checksum 0xe4cba553, Offset: 0x488
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "destructible", &__init__, undefined, undefined );
}

// Namespace destructible/destructible
// Params 0
// Checksum 0x19b40189, Offset: 0x4c8
// Size: 0x174
function __init__()
{
    clientfield::register( "scriptmover", "start_destructible_explosion", 1, 10, "int" );
    level.destructible_callbacks = [];
    destructibles = getentarray( "destructible", "targetname" );
    
    if ( destructibles.size <= 0 )
    {
        return;
    }
    
    for ( i = 0; i < destructibles.size ; i++ )
    {
        if ( getsubstr( destructibles[ i ].destructibledef, 0, 4 ) == "veh_" )
        {
            destructibles[ i ] thread car_death_think();
            destructibles[ i ] thread car_grenade_stuck_think();
            continue;
        }
        
        if ( destructibles[ i ].destructibledef == "fxdest_upl_metal_tank_01" )
        {
            destructibles[ i ] thread tank_grenade_stuck_think();
        }
    }
    
    function_1a193c6();
}

// Namespace destructible/destructible
// Params 0
// Checksum 0x15f1ac2b, Offset: 0x648
// Size: 0x168
function function_1a193c6()
{
    level.var_ea11bb1e = spawnstruct();
    level.var_ea11bb1e.count = 0;
    level.var_ea11bb1e.var_111e074d = [];
    
    for ( i = 0; i < 32 ; i++ )
    {
        var_7d0c93e1 = spawn( "script_model", ( 0, 0, 0 ) );
        
        if ( !isdefined( level.var_ea11bb1e.var_111e074d ) )
        {
            level.var_ea11bb1e.var_111e074d = [];
        }
        else if ( !isarray( level.var_ea11bb1e.var_111e074d ) )
        {
            level.var_ea11bb1e.var_111e074d = array( level.var_ea11bb1e.var_111e074d );
        }
        
        level.var_ea11bb1e.var_111e074d[ level.var_ea11bb1e.var_111e074d.size ] = var_7d0c93e1;
    }
}

// Namespace destructible/destructible
// Params 0
// Checksum 0xf80df997, Offset: 0x7b8
// Size: 0xc0
function function_aeee3204()
{
    foreach ( explosion in level.var_ea11bb1e.var_111e074d )
    {
        if ( !( isdefined( explosion.in_use ) && explosion.in_use ) )
        {
            return explosion;
        }
    }
    
    return level.var_ea11bb1e.var_111e074d[ 0 ];
}

// Namespace destructible/destructible
// Params 3
// Checksum 0x15fcb5fe, Offset: 0x880
// Size: 0xfc
function physics_explosion_and_rumble( origin, radius, physics_explosion )
{
    var_7d0c93e1 = function_aeee3204();
    var_7d0c93e1.in_use = 1;
    var_7d0c93e1.origin = origin;
    assert( radius <= pow( 2, 10 ) - 1 );
    
    if ( isdefined( physics_explosion ) && physics_explosion )
    {
        radius += 1 << 9;
    }
    
    waitframe( 1 );
    var_7d0c93e1 clientfield::set( "start_destructible_explosion", radius );
    var_7d0c93e1.in_use = 0;
}

// Namespace destructible/destructible
// Params 3
// Checksum 0xe37cf1b9, Offset: 0x988
// Size: 0x402
function event_callback( destructible_event, attacker, weapon )
{
    explosion_radius = 0;
    
    if ( issubstr( destructible_event, "explode" ) && destructible_event != "explode" )
    {
        tokens = strtok( destructible_event, "_" );
        explosion_radius = tokens[ 1 ];
        
        if ( explosion_radius == "sm" )
        {
            explosion_radius = 150;
        }
        else if ( explosion_radius == "lg" )
        {
            explosion_radius = 450;
        }
        else
        {
            explosion_radius = int( explosion_radius );
        }
        
        destructible_event = "explode_complex";
    }
    
    if ( issubstr( destructible_event, "explosive" ) )
    {
        tokens = strtok( destructible_event, "_" );
        explosion_radius_type = tokens[ 3 ];
        
        if ( explosion_radius_type == "small" )
        {
            explosion_radius = 150;
        }
        else if ( explosion_radius_type == "large" )
        {
            explosion_radius = 450;
        }
        else
        {
            explosion_radius = 300;
        }
    }
    
    if ( issubstr( destructible_event, "simple_timed_explosion" ) )
    {
        self thread simple_timed_explosion( destructible_event, attacker );
        return;
    }
    
    switch ( destructible_event )
    {
        case #"destructible_car_explosion":
            self car_explosion( attacker );
            
            if ( isdefined( weapon ) )
            {
                self.destroyingweapon = weapon;
            }
            
            break;
        case #"destructible_car_fire":
            level thread battlechatter::on_player_near_explodable( self, "car" );
            self thread car_fire_think( attacker );
            
            if ( isdefined( weapon ) )
            {
                self.destroyingweapon = weapon;
            }
            
            break;
        case #"explode":
            self thread simple_explosion( attacker );
            break;
        case #"explode_complex":
            self thread complex_explosion( attacker, explosion_radius );
            break;
        case #"destructible_explosive_incendiary_large":
        case #"destructible_explosive_incendiary_small":
            self explosive_incendiary_explosion( attacker, explosion_radius, 0 );
            
            if ( isdefined( weapon ) )
            {
                self.destroyingweapon = weapon;
            }
            
            break;
        case #"destructible_explosive_electrical_large":
        case #"destructible_explosive_electrical_small":
            self explosive_electrical_explosion( attacker, explosion_radius, 0 );
            
            if ( isdefined( weapon ) )
            {
                self.destroyingweapon = weapon;
            }
            
            break;
        case #"destructible_explosive_concussive_large":
        case #"destructible_explosive_concussive_small":
            self explosive_concussive_explosion( attacker, explosion_radius, 0 );
            
            if ( isdefined( weapon ) )
            {
                self.destroyingweapon = weapon;
            }
            
            break;
        default:
            break;
    }
    
    if ( isdefined( level.destructible_callbacks[ destructible_event ] ) )
    {
        self thread [[ level.destructible_callbacks[ destructible_event ] ]]( destructible_event, attacker, weapon );
    }
}

// Namespace destructible/destructible
// Params 1
// Checksum 0xff0e9c1e, Offset: 0xd98
// Size: 0x144
function simple_explosion( attacker )
{
    if ( isdefined( self.exploded ) && self.exploded )
    {
        return;
    }
    
    self.exploded = 1;
    offset = ( 0, 0, 5 );
    self radiusdamage( self.origin + offset, 256, 300, 75, attacker, "MOD_EXPLOSIVE", getweapon( "explodable_barrel" ) );
    physics_explosion_and_rumble( self.origin, 255, 1 );
    
    if ( isdefined( attacker ) )
    {
        self dodamage( self.health + 10000, self.origin + offset, attacker );
        return;
    }
    
    self dodamage( self.health + 10000, self.origin + offset );
}

// Namespace destructible/destructible
// Params 2
// Checksum 0x9fc3fd8a, Offset: 0xee8
// Size: 0x13c
function simple_timed_explosion( destructible_event, attacker )
{
    self endon( #"death" );
    wait_times = [];
    str = getsubstr( destructible_event, 23 );
    tokens = strtok( str, "_" );
    
    for ( i = 0; i < tokens.size ; i++ )
    {
        wait_times[ wait_times.size ] = int( tokens[ i ] );
    }
    
    if ( wait_times.size <= 0 )
    {
        wait_times[ 0 ] = 5;
        wait_times[ 1 ] = 10;
    }
    
    wait randomintrange( wait_times[ 0 ], wait_times[ 1 ] );
    simple_explosion( attacker );
}

// Namespace destructible/destructible
// Params 2
// Checksum 0x3d5be9ee, Offset: 0x1030
// Size: 0x11c
function complex_explosion( attacker, max_radius )
{
    offset = ( 0, 0, 5 );
    
    if ( isdefined( attacker ) )
    {
        self radiusdamage( self.origin + offset, max_radius, 300, 100, attacker );
    }
    else
    {
        self radiusdamage( self.origin + offset, max_radius, 300, 100 );
    }
    
    physics_explosion_and_rumble( self.origin, max_radius, 1 );
    
    if ( isdefined( attacker ) )
    {
        self dodamage( 20000, self.origin + offset, attacker );
        return;
    }
    
    self dodamage( 20000, self.origin + offset );
}

// Namespace destructible/destructible
// Params 2
// Checksum 0x25c3e7f9, Offset: 0x1158
// Size: 0x1bc
function car_explosion( attacker, physics_explosion )
{
    if ( self.car_dead )
    {
        return;
    }
    
    if ( !isdefined( physics_explosion ) )
    {
        physics_explosion = 1;
    }
    
    self notify( #"car_dead" );
    self.car_dead = 1;
    
    if ( isdefined( attacker ) )
    {
        self radiusdamage( self.origin, 256, 300, 75, attacker, "MOD_EXPLOSIVE", getweapon( "destructible_car" ) );
    }
    else
    {
        self radiusdamage( self.origin, 256, 300, 75 );
    }
    
    physics_explosion_and_rumble( self.origin, 255, physics_explosion );
    
    if ( isdefined( attacker ) )
    {
        attacker thread challenges::destroyed_car();
    }
    
    level.globalcarsdestroyed++;
    
    if ( isdefined( attacker ) )
    {
        self dodamage( self.health + 10000, self.origin + ( 0, 0, 1 ), attacker );
    }
    else
    {
        self dodamage( self.health + 10000, self.origin + ( 0, 0, 1 ) );
    }
    
    self markdestructibledestroyed();
}

// Namespace destructible/destructible
// Params 0
// Checksum 0xd542a0ee, Offset: 0x1320
// Size: 0xe8
function tank_grenade_stuck_think()
{
    self endon( #"destructible_base_piece_death" );
    self endon( #"death" );
    
    for ( ;; )
    {
        waitresult = self waittill( "grenade_stuck" );
        missile = waitresult.projectile;
        
        if ( !isdefined( missile ) || !isdefined( missile.model ) )
        {
            continue;
        }
        
        if ( missile.model == "t5_weapon_crossbow_bolt" || missile.model == "t6_wpn_grenade_semtex_projectile" || missile.model == "wpn_t7_c4_world" )
        {
            self thread tank_grenade_stuck_explode( missile );
        }
    }
}

// Namespace destructible/destructible
// Params 1
// Checksum 0xa72225a6, Offset: 0x1410
// Size: 0x13c
function tank_grenade_stuck_explode( missile )
{
    self endon( #"destructible_base_piece_death" );
    self endon( #"death" );
    owner = getmissileowner( missile );
    
    if ( isdefined( owner ) && missile.model == "wpn_t7_c4_world" )
    {
        owner endon( #"disconnect" );
        owner endon( #"weapon_object_destroyed" );
        missile endon( #"picked_up" );
        missile thread tank_hacked_c4( self );
    }
    
    missile waittill( "explode" );
    
    if ( isdefined( owner ) )
    {
        self dodamage( self.health + 10000, self.origin + ( 0, 0, 1 ), owner );
        return;
    }
    
    self dodamage( self.health + 10000, self.origin + ( 0, 0, 1 ) );
}

// Namespace destructible/destructible
// Params 1
// Checksum 0xb29e22d1, Offset: 0x1558
// Size: 0x6c
function tank_hacked_c4( tank )
{
    tank endon( #"destructible_base_piece_death" );
    tank endon( #"death" );
    self endon( #"death" );
    self waittill( "hacked" );
    self notify( #"picked_up" );
    tank thread tank_grenade_stuck_explode( self );
}

// Namespace destructible/destructible
// Params 0
// Checksum 0x29521aa2, Offset: 0x15d0
// Size: 0x7c
function car_death_think()
{
    self endon( #"car_dead" );
    self.car_dead = 0;
    self thread car_death_notify();
    waitresult = self waittill( "destructible_base_piece_death" );
    
    if ( isdefined( self ) )
    {
        self thread car_explosion( waitresult.attacker, 0 );
    }
}

// Namespace destructible/destructible
// Params 0
// Checksum 0xc519f090, Offset: 0x1658
// Size: 0xf0
function car_grenade_stuck_think()
{
    self endon( #"destructible_base_piece_death" );
    self endon( #"car_dead" );
    self endon( #"death" );
    
    for ( ;; )
    {
        waitresult = self waittill( "grenade_stuck" );
        missile = waitresult.projectile;
        
        if ( !isdefined( missile ) || !isdefined( missile.model ) )
        {
            continue;
        }
        
        if ( missile.model == "t5_weapon_crossbow_bolt" || missile.model == "t6_wpn_grenade_semtex_projectile" || missile.model == "wpn_t7_c4_world" )
        {
            self thread car_grenade_stuck_explode( missile );
        }
    }
}

// Namespace destructible/destructible
// Params 1
// Checksum 0x26cb15ce, Offset: 0x1750
// Size: 0x144
function car_grenade_stuck_explode( missile )
{
    self endon( #"destructible_base_piece_death" );
    self endon( #"car_dead" );
    self endon( #"death" );
    owner = getmissileowner( missile );
    
    if ( isdefined( owner ) && missile.model == "wpn_t7_c4_world" )
    {
        owner endon( #"disconnect" );
        owner endon( #"weapon_object_destroyed" );
        missile endon( #"picked_up" );
        missile thread car_hacked_c4( self );
    }
    
    missile waittill( "explode" );
    
    if ( isdefined( owner ) )
    {
        self dodamage( self.health + 10000, self.origin + ( 0, 0, 1 ), owner );
        return;
    }
    
    self dodamage( self.health + 10000, self.origin + ( 0, 0, 1 ) );
}

// Namespace destructible/destructible
// Params 1
// Checksum 0xa2e0d6d2, Offset: 0x18a0
// Size: 0x7c
function car_hacked_c4( car )
{
    car endon( #"destructible_base_piece_death" );
    car endon( #"car_dead" );
    car endon( #"death" );
    self endon( #"death" );
    self waittill( "hacked" );
    self notify( #"picked_up" );
    car thread car_grenade_stuck_explode( self );
}

// Namespace destructible/destructible
// Params 0
// Checksum 0xb55a9323, Offset: 0x1928
// Size: 0x2a
function car_death_notify()
{
    self endon( #"car_dead" );
    self notify( #"destructible_base_piece_death", self waittill( "death" ) );
}

// Namespace destructible/destructible
// Params 1
// Checksum 0x2a01b82a, Offset: 0x1960
// Size: 0x4c
function car_fire_think( attacker )
{
    self endon( #"death" );
    wait randomintrange( 7, 10 );
    self thread car_explosion( attacker );
}

// Namespace destructible/destructible
// Params 1, eflags: 0x40
// Checksum 0xab3949b5, Offset: 0x19b8
// Size: 0xfc
function event_handler[destructible] codecallback_destructibleevent( eventstruct )
{
    if ( eventstruct.event == "broken" )
    {
        event_callback( eventstruct.notify_type, eventstruct.attacker, eventstruct.weapon );
        self notify( eventstruct.event, { #type:eventstruct.notify_type, #attacker:eventstruct.attacker } );
        return;
    }
    
    if ( eventstruct.event == "breakafter" )
    {
        self thread breakafter( eventstruct.time, eventstruct.amount, eventstruct.piece );
    }
}

// Namespace destructible/destructible
// Params 3
// Checksum 0xb37e334f, Offset: 0x1ac0
// Size: 0x64
function breakafter( time, damage, piece )
{
    self notify( #"breakafter" );
    self endon( #"breakafter" );
    wait time;
    self dodamage( damage, self.origin, undefined, undefined );
}

// Namespace destructible/destructible
// Params 3
// Checksum 0xd1bfc4c5, Offset: 0x1b30
// Size: 0x174
function explosive_incendiary_explosion( attacker, explosion_radius, physics_explosion )
{
    if ( !isvehicle( self ) )
    {
        offset = ( 0, 0, 5 );
        
        if ( isdefined( attacker ) )
        {
            self radiusdamage( self.origin + offset, explosion_radius, 256, 75, attacker, "MOD_BURNED", getweapon( "incendiary_fire" ) );
        }
        else
        {
            self radiusdamage( self.origin + offset, explosion_radius, 256, 75 );
        }
        
        physics_explosion_and_rumble( self.origin, 255, physics_explosion );
    }
    
    if ( isdefined( self.target ) )
    {
        dest_clip = getent( self.target, "targetname" );
        
        if ( isdefined( dest_clip ) )
        {
            dest_clip delete();
        }
    }
    
    self markdestructibledestroyed();
}

// Namespace destructible/destructible
// Params 3
// Checksum 0xe32e6ea2, Offset: 0x1cb0
// Size: 0x15c
function explosive_electrical_explosion( attacker, explosion_radius, physics_explosion )
{
    if ( !isvehicle( self ) )
    {
        offset = ( 0, 0, 5 );
        
        if ( isdefined( attacker ) )
        {
            self radiusdamage( self.origin + offset, explosion_radius, 256, 75, attacker, "MOD_ELECTROCUTED" );
        }
        else
        {
            self radiusdamage( self.origin + offset, explosion_radius, 256, 75 );
        }
        
        physics_explosion_and_rumble( self.origin, 255, physics_explosion );
    }
    
    if ( isdefined( self.target ) )
    {
        dest_clip = getent( self.target, "targetname" );
        
        if ( isdefined( dest_clip ) )
        {
            dest_clip delete();
        }
    }
    
    self markdestructibledestroyed();
}

// Namespace destructible/destructible
// Params 3
// Checksum 0xedf982a8, Offset: 0x1e18
// Size: 0x15c
function explosive_concussive_explosion( attacker, explosion_radius, physics_explosion )
{
    if ( !isvehicle( self ) )
    {
        offset = ( 0, 0, 5 );
        
        if ( isdefined( attacker ) )
        {
            self radiusdamage( self.origin + offset, explosion_radius, 256, 75, attacker, "MOD_GRENADE" );
        }
        else
        {
            self radiusdamage( self.origin + offset, explosion_radius, 256, 75 );
        }
        
        physics_explosion_and_rumble( self.origin, 255, physics_explosion );
    }
    
    if ( isdefined( self.target ) )
    {
        dest_clip = getent( self.target, "targetname" );
        
        if ( isdefined( dest_clip ) )
        {
            dest_clip delete();
        }
    }
    
    self markdestructibledestroyed();
}

