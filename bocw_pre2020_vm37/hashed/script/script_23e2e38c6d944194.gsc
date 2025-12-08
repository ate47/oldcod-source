#using scripts\core_common\system_shared;

#namespace namespace_90310f6a;

// Namespace namespace_90310f6a/namespace_90310f6a
// Params 0, eflags: 0x6
// Checksum 0x9bd1323c, Offset: 0xf8
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"hash_727cd08e2b1432e6", &init, undefined, undefined, undefined );
}

// Namespace namespace_90310f6a/namespace_90310f6a
// Params 0
// Checksum 0x64158918, Offset: 0x140
// Size: 0x14
function init()
{
    thread function_32e330d();
}

// Namespace namespace_90310f6a/namespace_90310f6a
// Params 0
// Checksum 0xbba9cbe7, Offset: 0x160
// Size: 0x200
function function_32e330d()
{
    var_78856083 = getentarray( "male_mannequin_trigger", "targetname" );
    
    foreach ( trigger in var_78856083 )
    {
        trigger thread function_c46b4b94();
    }
    
    var_2eec21b8 = getentarray( "female_mannequin_trigger", "targetname" );
    
    foreach ( trigger in var_2eec21b8 )
    {
        trigger thread function_69e2587b();
    }
    
    var_83d5c6a0 = getentarray( "child_mannequin_trigger", "targetname" );
    
    foreach ( trigger in var_83d5c6a0 )
    {
        trigger thread function_42a285bf();
    }
}

// Namespace namespace_90310f6a/namespace_90310f6a
// Params 0
// Checksum 0x653d78a3, Offset: 0x368
// Size: 0x3fc
function function_c46b4b94()
{
    self endon( #"hash_27629c40b49f163c" );
    self setcandamage( 1 );
    self disconnectpaths();
    n_outer_radius = 5;
    n_inner_radius = 1;
    var_67b43134 = 1;
    var_b6680570 = 5;
    var_a62ea1f = 10;
    origin = self.origin;
    s_notify = self waittill( #"damage" );
    var_947d01ee = s_notify.weapon.weapclass;
    var_18acfe18 = s_notify.amount;
    
    while ( self.health > 0 )
    {
        self.health += 0;
        waitframe( 1 );
    }
    
    if ( self.health <= 0 )
    {
        switch ( var_947d01ee )
        {
            case #"pistol":
                n_magnitude = var_18acfe18 * 0.02;
                break;
            case #"rifle":
                n_magnitude = var_18acfe18 * 0.02;
                break;
            case #"mg":
                n_magnitude = var_18acfe18 * 0.02;
                break;
            case #"spread":
                n_magnitude = var_18acfe18 * 0.02;
                break;
            case #"smg":
                n_magnitude = var_18acfe18 * 0.02;
                break;
            case #"grenade":
                n_magnitude = var_18acfe18 * 0.02;
                break;
            case #"rocketlauncher":
                n_magnitude = var_18acfe18 * 0.02;
                break;
            case #"turret":
                n_magnitude = var_18acfe18 * 0.02;
                break;
            default:
                n_magnitude = 0.01;
                break;
        }
        
        playfx( "maps/cp_rus_amerika/fx9_impact_mannequin_sm", self.origin );
        self connectpaths();
        self deletedelay();
        radiusdamage( origin + ( 0, 0, -10 ), 5, 10, 3 );
        radiusdamage( origin + ( 0, 0, -5 ), 5, 10, 3 );
        radiusdamage( origin + ( 0, 0, 20 ), 5, 10, 3 );
        radiusdamage( origin + ( 0, 0, 30 ), 5, 10, 3 );
        physicsexplosionsphere( origin + ( 0, 0, -10 ), n_outer_radius, n_inner_radius, n_magnitude );
        physicsexplosionsphere( origin + ( 0, 0, 20 ), n_outer_radius, n_inner_radius, n_magnitude );
    }
}

// Namespace namespace_90310f6a/namespace_90310f6a
// Params 0
// Checksum 0xf9614a67, Offset: 0x770
// Size: 0x454
function function_69e2587b()
{
    self endon( #"hash_27629c40b49f163c" );
    self setcandamage( 1 );
    self disconnectpaths();
    n_outer_radius = 4;
    n_inner_radius = 1;
    var_67b43134 = 1;
    var_b6680570 = 5;
    var_a62ea1f = 10;
    origin = self.origin;
    s_notify = self waittill( #"damage" );
    var_947d01ee = s_notify.weapon.weapclass;
    var_18acfe18 = s_notify.amount;
    
    while ( self.health > 0 )
    {
        self.health += 0;
        waitframe( 1 );
    }
    
    if ( self.health <= 0 )
    {
        switch ( var_947d01ee )
        {
            case #"pistol":
                n_magnitude = var_18acfe18 * 0.02;
                break;
            case #"rifle":
                n_magnitude = var_18acfe18 * 0.025;
                break;
            case #"mg":
                n_magnitude = var_18acfe18 * 0.025;
                break;
            case #"spread":
                n_magnitude = var_18acfe18 * 0.025;
                break;
            case #"smg":
                n_magnitude = var_18acfe18 * 0.025;
                break;
            case #"grenade":
                n_magnitude = var_18acfe18 * 0.025;
                break;
            case #"rocketlauncher":
                n_magnitude = var_18acfe18 * 0.025;
                break;
            case #"turret":
                n_magnitude = var_18acfe18 * 0.025;
                break;
            default:
                n_magnitude = 0.01;
                break;
        }
        
        playfx( "maps/cp_rus_amerika/fx9_impact_mannequin_sm", self.origin );
        self connectpaths();
        self deletedelay();
        radiusdamage( origin + ( 0, 0, -10 ), 5, 10, 3 );
        radiusdamage( origin + ( 0, 0, -5 ), 5, 10, 3 );
        radiusdamage( origin + ( 0, 0, 10 ), 5, 10, 3 );
        radiusdamage( origin + ( 0, 0, 20 ), 5, 10, 3 );
        radiusdamage( origin + ( 0, 0, 30 ), 5, 10, 3 );
        physicsexplosionsphere( origin + ( 0, 0, -10 ), n_outer_radius, n_inner_radius, n_magnitude );
        physicsexplosionsphere( origin + ( 0, 0, -5 ), n_outer_radius, n_inner_radius, n_magnitude );
        physicsexplosionsphere( origin + ( 0, 0, 20 ), n_outer_radius, n_inner_radius, n_magnitude );
    }
}

// Namespace namespace_90310f6a/namespace_90310f6a
// Params 0
// Checksum 0xbef92433, Offset: 0xbd0
// Size: 0x444
function function_42a285bf()
{
    self endon( #"hash_27629c40b49f163c" );
    self setcandamage( 1 );
    self disconnectpaths();
    n_outer_radius = 5;
    n_inner_radius = 1;
    var_67b43134 = 1;
    var_b6680570 = 5;
    var_a62ea1f = 10;
    origin = self.origin;
    s_notify = self waittill( #"damage" );
    var_947d01ee = s_notify.weapon.weapclass;
    var_18acfe18 = s_notify.amount;
    
    while ( self.health > 0 )
    {
        self.health += 0;
        waitframe( 1 );
    }
    
    if ( self.health <= 0 )
    {
        switch ( var_947d01ee )
        {
            case #"pistol":
                n_magnitude = var_18acfe18 * 0.02;
                break;
            case #"rifle":
                n_magnitude = var_18acfe18 * 0.025;
                break;
            case #"mg":
                n_magnitude = var_18acfe18 * 0.025;
                break;
            case #"spread":
                n_magnitude = var_18acfe18 * 0.025;
                break;
            case #"smg":
                n_magnitude = var_18acfe18 * 0.025;
                break;
            case #"grenade":
                n_magnitude = var_18acfe18 * 0.025;
                break;
            case #"rocketlauncher":
                n_magnitude = var_18acfe18 * 0.025;
                break;
            case #"turret":
                n_magnitude = var_18acfe18 * 0.025;
                break;
            default:
                n_magnitude = 0.01;
                break;
        }
        
        playfx( "maps/cp_rus_amerika/fx9_impact_mannequin_sm", self.origin );
        self connectpaths();
        self deletedelay();
        radiusdamage( origin + ( 0, 0, -10 ), 5, 10, 3 );
        radiusdamage( origin + ( 0, 0, -5 ), 5, 10, 3 );
        radiusdamage( origin + ( 0, 0, 0 ), 5, 10, 3 );
        radiusdamage( origin + ( 0, 0, 5 ), 5, 10, 3 );
        radiusdamage( origin + ( 0, 0, 10 ), 5, 10, 3 );
        physicsexplosionsphere( origin + ( 0, 0, -10 ), n_outer_radius, n_inner_radius, n_magnitude );
        physicsexplosionsphere( origin + ( 0, 0, 0 ), n_outer_radius, n_inner_radius, n_magnitude );
        physicsexplosionsphere( origin + ( 0, 0, 10 ), n_outer_radius, n_inner_radius, n_magnitude );
    }
}

