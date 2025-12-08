#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_455b9cb22d561924;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_774302f762d76254;
#using scripts\core_common\ai\archetype_locomotion_utility;
#using scripts\core_common\ai\systems\ai_blackboard;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\animation_state_machine_mocomp;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\oob;
#using scripts\core_common\util_shared;

#namespace namespace_53a8fe5e;

// Namespace namespace_53a8fe5e/namespace_53a8fe5e
// Params 0
// Checksum 0x1742cd35, Offset: 0x318
// Size: 0xfc
function init()
{
    clientfield::register( "actor", "hellhound_fx", 1, 1, "int" );
    namespace_250e9486::function_252dff4d( "wolf_ghosthound", &function_ebb53c52, &function_df18852 );
    namespace_250e9486::function_252dff4d( "wolf_hellhound", &function_ebb53c52, &function_df18852 );
    namespace_250e9486::function_252dff4d( "wolf_plaguehound", &function_ebb53c52, &function_df18852 );
    registerbehaviorscriptfunctions();
    function_8c1ad7f9();
}

// Namespace namespace_53a8fe5e/namespace_53a8fe5e
// Params 0
// Checksum 0x42138e13, Offset: 0x420
// Size: 0x31c
function registerbehaviorscriptfunctions()
{
    assert( isscriptfunctionptr( &function_52fd1aa8 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_347361909496bb67", &function_52fd1aa8 );
    assert( isscriptfunctionptr( &function_ee68dfca ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_589814e7ae852fb7", &function_ee68dfca );
    assert( isscriptfunctionptr( &function_86104a92 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_2c51dac6b31ae16e", &function_86104a92 );
    assert( isscriptfunctionptr( &function_cf98d4f7 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_4d690a74a315c5c3", &function_cf98d4f7 );
    assert( isscriptfunctionptr( &function_ad163d5a ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_4c13ee431006ea01", &function_ad163d5a );
    assert( !isdefined( &wolfmeleeaction ) || isscriptfunctionptr( &wolfmeleeaction ) );
    assert( !isdefined( undefined ) || isscriptfunctionptr( undefined ) );
    assert( !isdefined( &function_8d42c979 ) || isscriptfunctionptr( &function_8d42c979 ) );
    behaviortreenetworkutility::registerbehaviortreeaction( "wolfMeleeAction", &wolfmeleeaction, undefined, &function_8d42c979 );
}

// Namespace namespace_53a8fe5e/namespace_53a8fe5e
// Params 0
// Checksum 0x30e8436c, Offset: 0x748
// Size: 0xcc
function function_8c1ad7f9()
{
    ai::registermatchedinterface( #"zombie_dog", #"min_run_dist", 500 );
    ai::registermatchedinterface( #"zombie_dog", #"sprint", 0, array( 1, 0 ) );
    ai::registermatchedinterface( #"zombie_dog", #"patrol", 0, array( 1, 0 ) );
}

// Namespace namespace_53a8fe5e/namespace_53a8fe5e
// Params 0
// Checksum 0xd790f55b, Offset: 0x820
// Size: 0x14a
function function_ebb53c52()
{
    self namespace_250e9486::function_25b2c8a9();
    self namespace_ec06fe4a::function_8c808737();
    self.shouldrun = 0;
    self.var_3b227abd = randomintrange( 10, 30 ) * 1000;
    self.var_717a48cb = 0;
    self.var_f506c5cd = 1200;
    self.var_c8b974fe = self.origin;
    self.var_cc28f8dc = 35;
    self.showdelay = 2;
    self.health = 8000;
    self.var_1c8b76d3 = 1;
    self.no_gib = 1;
    self thread function_7923d25a();
    self thread function_92312127();
    self thread function_47c86b9e( self );
    
    if ( namespace_4dae815d::function_59a9cf1d() == 0 )
    {
        self namespace_250e9486::function_4b49bf0d();
        self.hasseenfavoriteenemy = 1;
    }
}

// Namespace namespace_53a8fe5e/namespace_53a8fe5e
// Params 0
// Checksum 0xa8355d5d, Offset: 0x978
// Size: 0xb4
function damagewatch()
{
    self notify( "7aa572bfbb815d4" );
    self endon( "7aa572bfbb815d4" );
    self endon( #"death" );
    result = self waittill( #"damage" );
    
    if ( isdefined( result.attacker ) && issentient( result.attacker ) )
    {
        function_e856134( self, result.attacker );
    }
    
    wait 8;
    self thread damagewatch();
}

// Namespace namespace_53a8fe5e/namespace_53a8fe5e
// Params 0
// Checksum 0xaab2318c, Offset: 0xa38
// Size: 0x1ce
function function_df18852()
{
    self endon( #"death" );
    self thread damagewatch();
    self thread function_a47b7e79( 1 );
    self function_56bb65ac( "WALK" );
    self.var_84f9cc2e = gettime() + 1000;
    var_30d02a4c = 0;
    
    while ( true )
    {
        self function_2e6b2ca9();
        
        while ( self function_ad163d5a() )
        {
            wait 0.5;
        }
        
        self.shouldrun = need_to_run();
        self function_56bb65ac( self.shouldrun ? "RUN" : "WALK" );
        
        /#
            if ( !is_true( self.hasseenfavoriteenemy ) && getdvarint( #"hash_6518ba687e18a514", 0 ) && isdefined( self.lasttargetposition ) )
            {
                self thread namespace_1e25ad94::debugline( self.origin, self.lasttargetposition, 1, ( 1, 0, 0 ) );
                self thread namespace_1e25ad94::function_1d1f2c26( self.lasttargetposition, 1, 24, ( 1, 0, 0 ) );
            }
        #/
        
        waitframe( 1 );
    }
}

// Namespace namespace_53a8fe5e/namespace_53a8fe5e
// Params 1
// Checksum 0xb973d9ee, Offset: 0xc10
// Size: 0x350
function function_47c86b9e( ai )
{
    ai endon( #"death" );
    ai namespace_ec06fe4a::function_8c808737();
    ai.takedamage = 0;
    ai setfreecameralockonallowed( 0 );
    
    if ( mayspawnentity() && validateorigin( ai.origin ) )
    {
        playsoundatposition( #"zmb_hellhound_prespawn", ai.origin );
    }
    
    if ( mayspawnentity() && validateorigin( ai.origin ) )
    {
        playsoundatposition( #"zmb_hellhound_bolt", ai.origin );
    }
    
    earthquake( 0.5, 0.75, ai.origin, 1000 );
    
    if ( mayspawnentity() && validateorigin( ai.origin ) )
    {
        playsoundatposition( #"zmb_hellhound_spawn", ai.origin );
    }
    
    if ( isdefined( ai.favoriteenemy ) )
    {
        angle = vectortoangles( ai.favoriteenemy.origin - ai.origin );
        angles = ( ai.angles[ 0 ], angle[ 1 ], ai.angles[ 2 ] );
    }
    else
    {
        angles = ai.angles;
    }
    
    ai dontinterpolate();
    ai forceteleport( ai.origin, angles );
    
    if ( ai.script_noteworthy === "wolf_plaguehound" )
    {
        ai namespace_83eb6304::function_3ecfde67( "nova_crawler_burst" );
    }
    else
    {
        ai namespace_83eb6304::function_3ecfde67( "lightningStrike" );
    }
    
    ai.takedamage = 1;
    wait 0.4;
    ai namespace_ec06fe4a::function_4f72130c();
    ai setfreecameralockonallowed( 1 );
    
    if ( ai.script_noteworthy === "wolf_hellhound" )
    {
        ai clientfield::set( "hellhound_fx", 1 );
    }
    
    ai notify( #"hash_6f1cd023691af538" );
}

// Namespace namespace_53a8fe5e/namespace_53a8fe5e
// Params 0
// Checksum 0xb41cccc, Offset: 0xf68
// Size: 0x1e6
function function_7923d25a()
{
    self notify( "2eb338bba848d7a" );
    self endon( "2eb338bba848d7a" );
    
    while ( true )
    {
        waitresult = self waittill( #"damage" );
        
        if ( waitresult.amount >= self.health )
        {
            break;
        }
    }
    
    self stoploopsound();
    
    if ( mayspawnentity() && validateorigin( self.origin ) )
    {
        playsoundatposition( #"zmb_hellhound_explode", self.origin );
    }
    
    if ( self.script_noteworthy === "wolf_ghosthound" )
    {
        self namespace_83eb6304::function_3ecfde67( "ghosthound_death" );
        self namespace_ec06fe4a::function_8c808737();
        self notsolid();
        self thread namespace_ec06fe4a::function_52afe5df( 0.3 );
        return;
    }
    
    if ( self.script_noteworthy === "wolf_hellhound" )
    {
        self namespace_83eb6304::function_3ecfde67( "hellhound_death" );
        self namespace_ec06fe4a::function_8c808737();
        self notsolid();
        self thread namespace_ec06fe4a::function_52afe5df( 0.3 );
        return;
    }
}

// Namespace namespace_53a8fe5e/namespace_53a8fe5e
// Params 0
// Checksum 0xb9a60319, Offset: 0x1158
// Size: 0x3fe
function function_2e6b2ca9()
{
    if ( !is_target_valid( self, self.favoriteenemy ) )
    {
        if ( isdefined( self.favoriteenemy ) )
        {
            function_ea61b64a( self );
            self.hasseenfavoriteenemy = 0;
        }
        
        self.favoriteenemy = get_favorite_enemy( self );
    }
    
    infov = 0;
    
    if ( isdefined( self.favoriteenemy ) )
    {
        infov = self util::point_in_fov( self.favoriteenemy.origin, 0.8, 1 );
    }
    
    cansee = infov && self cansee( self.favoriteenemy );
    
    /#
        if ( isdefined( self.favoriteenemy ) && isplayer( self.favoriteenemy ) && self.favoriteenemy isinmovemode( "<dev string:x38>", "<dev string:x3f>" ) )
        {
            cansee = 0;
        }
    #/
    
    if ( !is_true( self.hasseenfavoriteenemy ) && isdefined( self.favoriteenemy ) && cansee )
    {
        self.hasseenfavoriteenemy = 1;
        self thread function_a47b7e79( 1 );
    }
    
    if ( isdefined( self.favoriteenemy ) && is_true( self.hasseenfavoriteenemy ) )
    {
        locomotion_target = get_locomotion_target( self, cansee );
        
        if ( isdefined( locomotion_target ) )
        {
            if ( !isdefined( self.lasttargetposition ) || distancesquared( self.lasttargetposition, locomotion_target ) > sqr( 16 ) || !self haspath() )
            {
                self namespace_250e9486::function_41354e51( locomotion_target );
                self.lasttargetposition = locomotion_target;
            }
            
            self.var_717a48cb = 0;
        }
        else
        {
            self.hasseenfavoriteenemy = 0;
        }
    }
    
    if ( !isdefined( self.lasttargetposition ) || !is_true( self.hasseenfavoriteenemy ) )
    {
        time = gettime();
        
        if ( self.var_717a48cb < time )
        {
            var_86faa86d = doa_enemy::function_4b2f19cb();
            self.var_717a48cb = time + randomintrange( 12000, 24000 );
            
            if ( isdefined( var_86faa86d ) )
            {
                self namespace_250e9486::function_41354e51( var_86faa86d );
                self.lasttargetposition = var_86faa86d;
            }
        }
        
        return;
    }
    
    goalinfo = self function_4794d6a3();
    
    if ( !is_true( self.hasseenfavoriteenemy ) && is_true( goalinfo.isatgoal ) )
    {
        function_a47b7e79( randomint( 100 ) > 80 );
        self.lasttargetposition = undefined;
    }
}

// Namespace namespace_53a8fe5e/namespace_53a8fe5e
// Params 2
// Checksum 0x671211c4, Offset: 0x1560
// Size: 0x222
function get_locomotion_target( behaviortreeentity, *cansee )
{
    if ( !isdefined( cansee.favoriteenemy ) )
    {
        return undefined;
    }
    
    last_valid_position = cansee.favoriteenemy.origin;
    locomotion_target = last_valid_position;
    
    if ( ai::has_behavior_attribute( "spacing_value" ) )
    {
        spacing_near_dist = ai::get_behavior_attribute( "spacing_near_dist" );
        spacing_far_dist = ai::get_behavior_attribute( "spacing_far_dist" );
        spacing_horz_dist = ai::get_behavior_attribute( "spacing_horz_dist" );
        spacing_value = ai::get_behavior_attribute( "spacing_value" );
        to_enemy = cansee.favoriteenemy.origin - cansee.origin;
        perp = vectornormalize( ( to_enemy[ 1 ] * -1, to_enemy[ 0 ], 0 ) );
        offset = perp * spacing_horz_dist * spacing_value;
        spacing_dist = math::clamp( length( to_enemy ), spacing_near_dist, spacing_far_dist );
        lerp_amount = math::clamp( ( spacing_dist - spacing_near_dist ) / ( spacing_far_dist - spacing_near_dist ), 0, 1 );
        desired_point = last_valid_position + offset * lerp_amount;
        desired_point = getclosestpointonnavmesh( desired_point, spacing_horz_dist * 1.2, 16 );
        
        if ( isdefined( desired_point ) )
        {
            locomotion_target = desired_point;
        }
    }
    
    return locomotion_target;
}

// Namespace namespace_53a8fe5e/namespace_53a8fe5e
// Params 0
// Checksum 0x422c6089, Offset: 0x1790
// Size: 0x19a, Type: bool
function need_to_run()
{
    run_yaw = 35;
    run_pitch = 30;
    run_height = 64;
    
    if ( self.health < self.maxhealth )
    {
        return true;
    }
    
    if ( !isdefined( self.enemy ) || !isalive( self.enemy ) )
    {
        return false;
    }
    
    if ( isdefined( self.favoriteenemy ) && !is_true( self.hasseenfavoriteenemy ) )
    {
        return false;
    }
    
    height = self.origin[ 2 ] - self.enemy.origin[ 2 ];
    
    if ( abs( height ) > run_height )
    {
        return false;
    }
    
    yaw = self namespace_ec06fe4a::absyawtoenemy();
    
    if ( yaw > run_yaw )
    {
        return false;
    }
    
    pitch = angleclamp180( vectortoangles( self.origin - self.enemy.origin )[ 0 ] );
    
    if ( abs( pitch ) > run_pitch )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_53a8fe5e/namespace_53a8fe5e
// Params 1
// Checksum 0x62a0904c, Offset: 0x1938
// Size: 0x3c
function function_56bb65ac( speed = "WALK" )
{
    self setblackboardattribute( "_wolf_should_run", speed );
}

// Namespace namespace_53a8fe5e/namespace_53a8fe5e
// Params 1
// Checksum 0x85bed330, Offset: 0x1980
// Size: 0x34, Type: bool
function function_ad163d5a( *behaviortreeentity )
{
    return self getblackboardattribute( "_wolf_should_howl" ) === "HOWL";
}

// Namespace namespace_53a8fe5e/namespace_53a8fe5e
// Params 1
// Checksum 0x64a3c5da, Offset: 0x19c0
// Size: 0x9c
function function_a47b7e79( howl = 1 )
{
    self endon( #"death" );
    
    if ( howl )
    {
        self setblackboardattribute( "_wolf_should_howl", "HOWL" );
        self waittilltimeout( 2, #"damage" );
    }
    
    self setblackboardattribute( "_wolf_should_howl", "DONT_HOWL" );
}

// Namespace namespace_53a8fe5e/namespace_53a8fe5e
// Params 1
// Checksum 0xe455f570, Offset: 0x1a68
// Size: 0xc
function get_last_valid_position( *bimmediate )
{
    
}

// Namespace namespace_53a8fe5e/namespace_53a8fe5e
// Params 2
// Checksum 0xbd1df6f9, Offset: 0x1a80
// Size: 0xce, Type: bool
function is_target_valid( dog, target )
{
    if ( !isdefined( target ) )
    {
        return false;
    }
    
    if ( !isalive( target ) )
    {
        return false;
    }
    
    if ( dog.team == target.team )
    {
        return false;
    }
    
    if ( isplayer( target ) && !namespace_7f5aeb59::isplayervalid( target ) )
    {
        return false;
    }
    
    if ( is_true( target.ignoreme ) )
    {
        return false;
    }
    
    if ( target isnotarget() )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_53a8fe5e/namespace_53a8fe5e
// Params 2
// Checksum 0xaa58a1b1, Offset: 0x1b58
// Size: 0x9e
function function_e856134( dog, new_target )
{
    function_ea61b64a( dog );
    
    if ( !isdefined( new_target.hunted_by ) )
    {
        new_target.hunted_by = 0;
    }
    
    dog.favoriteenemy = new_target;
    dog.hasseenfavoriteenemy = 1;
    dog.favoriteenemy.hunted_by++;
    dog namespace_250e9486::function_41354e51( new_target.origin );
    dog.lasttargetposition = new_target.origin;
}

// Namespace namespace_53a8fe5e/namespace_53a8fe5e
// Params 1
// Checksum 0x8b82a0a6, Offset: 0x1c00
// Size: 0x6e
function function_ea61b64a( dog )
{
    if ( isdefined( dog.favoriteenemy ) && isdefined( dog.favoriteenemy.hunted_by ) && dog.favoriteenemy.hunted_by > 0 )
    {
        dog.favoriteenemy.hunted_by--;
    }
    
    dog.favoriteenemy = undefined;
}

// Namespace namespace_53a8fe5e/namespace_53a8fe5e
// Params 1, eflags: 0x4
// Checksum 0xb429f9e5, Offset: 0x1c78
// Size: 0x18c
function private get_favorite_enemy( dog )
{
    dog_targets = [];
    dog_targets = namespace_7f5aeb59::function_23e1f90f();
    least_hunted = dog_targets[ 0 ];
    closest_target_dist_squared = undefined;
    
    for ( i = 0; i < dog_targets.size ; i++ )
    {
        if ( !isdefined( dog_targets[ i ].hunted_by ) )
        {
            dog_targets[ i ].hunted_by = 0;
        }
        
        if ( !is_target_valid( dog, dog_targets[ i ] ) )
        {
            continue;
        }
        
        if ( !is_target_valid( dog, least_hunted ) )
        {
            least_hunted = dog_targets[ i ];
        }
        
        dist_squared = distancesquared( dog.origin, dog_targets[ i ].origin );
        
        if ( dog_targets[ i ].hunted_by <= least_hunted.hunted_by && ( !isdefined( closest_target_dist_squared ) || dist_squared < closest_target_dist_squared ) )
        {
            least_hunted = dog_targets[ i ];
            closest_target_dist_squared = dist_squared;
        }
    }
    
    if ( !is_target_valid( dog, least_hunted ) )
    {
        return undefined;
    }
    
    least_hunted.hunted_by += 1;
    return least_hunted;
}

// Namespace namespace_53a8fe5e/namespace_53a8fe5e
// Params 1
// Checksum 0x5f1da7b, Offset: 0x1e10
// Size: 0x34, Type: bool
function function_52fd1aa8( behaviortreeentity )
{
    return behaviortreeentity getblackboardattribute( "_wolf_should_run" ) === "WALK";
}

// Namespace namespace_53a8fe5e/namespace_53a8fe5e
// Params 1
// Checksum 0xe94df926, Offset: 0x1e50
// Size: 0x34, Type: bool
function function_ee68dfca( behaviortreeentity )
{
    return behaviortreeentity getblackboardattribute( "_wolf_should_run" ) === "RUN";
}

// Namespace namespace_53a8fe5e/namespace_53a8fe5e
// Params 1
// Checksum 0x7cdddebc, Offset: 0x1e90
// Size: 0x34, Type: bool
function function_86104a92( behaviortreeentity )
{
    return behaviortreeentity getblackboardattribute( "_wolf_should_run" ) === "SPRINT";
}

// Namespace namespace_53a8fe5e/namespace_53a8fe5e
// Params 1
// Checksum 0xc9595e92, Offset: 0x1ed0
// Size: 0xc0, Type: bool
function function_cf98d4f7( behaviortreeentity )
{
    if ( behaviortreeentity.ignoreall || !is_target_valid( behaviortreeentity, behaviortreeentity.favoriteenemy ) )
    {
        return false;
    }
    
    meleedist = 72;
    
    if ( distancesquared( behaviortreeentity.origin, behaviortreeentity.favoriteenemy.origin ) < sqr( meleedist ) && behaviortreeentity cansee( behaviortreeentity.favoriteenemy ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_53a8fe5e/namespace_53a8fe5e
// Params 1
// Checksum 0xf87529b5, Offset: 0x1f98
// Size: 0x1fc
function function_a19ebce9( target )
{
    if ( !isdefined( target ) )
    {
        return;
    }
    
    if ( distancesquared( self.origin, target.origin ) > sqr( 36 ) )
    {
        return;
    }
    
    registernotice_walla = anglestoforward( self.angles );
    var_2f706708 = self gettagorigin( "j_neck" );
    var_c1324bcf = vectornormalize( target.origin - self.origin );
    var_aa74cdcb = vectordot( var_c1324bcf, registernotice_walla );
    
    if ( var_aa74cdcb > 0.8 )
    {
        in_front = 1;
    }
    
    if ( !is_true( in_front ) )
    {
        return;
    }
    
    target_origin = ( target.origin[ 0 ], target.origin[ 1 ], target.origin[ 2 ] + 32 );
    
    if ( bullettracepassed( var_2f706708, target_origin, 0, self ) )
    {
        target dodamage( self.var_cc28f8dc, self.origin, self, self, "none", "MOD_MELEE" );
        
        if ( isplayer( target ) )
        {
            target playrumbleonentity( "damage_heavy" );
        }
    }
}

// Namespace namespace_53a8fe5e/namespace_53a8fe5e
// Params 0
// Checksum 0xcb7bd1e7, Offset: 0x21a0
// Size: 0x68
function function_92312127()
{
    self endon( #"death" );
    
    while ( true )
    {
        result = self waittill( #"dog_melee" );
        self function_a19ebce9( self.enemy );
    }
}

// Namespace namespace_53a8fe5e/namespace_53a8fe5e
// Params 0
// Checksum 0x2d6f6e2b, Offset: 0x2210
// Size: 0x166, Type: bool
function use_low_attack()
{
    if ( !isdefined( self.enemy ) || !isplayer( self.enemy ) )
    {
        return false;
    }
    
    height_diff = self.enemy.origin[ 2 ] - self.origin[ 2 ];
    low_enough = 30;
    
    if ( height_diff < low_enough && self.enemy getstance() == "prone" )
    {
        return true;
    }
    
    melee_origin = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + 65 );
    enemy_origin = ( self.enemy.origin[ 0 ], self.enemy.origin[ 1 ], self.enemy.origin[ 2 ] + 32 );
    
    if ( !bullettracepassed( melee_origin, enemy_origin, 0, self ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_53a8fe5e/namespace_53a8fe5e
// Params 2
// Checksum 0xab100950, Offset: 0x2380
// Size: 0xa0
function wolfmeleeaction( behaviortreeentity, asmstatename )
{
    behaviortreeentity clearpath();
    context = "high";
    
    if ( behaviortreeentity use_low_attack() )
    {
        context = "low";
    }
    
    behaviortreeentity setblackboardattribute( "_context", context );
    animationstatenetworkutility::requeststate( behaviortreeentity, asmstatename );
    return 5;
}

// Namespace namespace_53a8fe5e/namespace_53a8fe5e
// Params 2
// Checksum 0x5805c2d3, Offset: 0x2428
// Size: 0x38
function function_8d42c979( behaviortreeentity, *asmstatename )
{
    asmstatename setblackboardattribute( "_context", undefined );
    return 4;
}

