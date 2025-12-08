#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1b01e95a6b5270fd;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_3faf478d5b0850fe;
#using script_47851dbeea22fe66;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_6b6510e124bad778;
#using scripts\core_common\ai\archetype_locomotion_utility;
#using scripts\core_common\ai\systems\ai_blackboard;
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

#namespace namespace_58e19d6;

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 0
// Checksum 0xc26d1a2d, Offset: 0x420
// Size: 0xa4
function init()
{
    level.doa.var_78fe553b = [];
    level.doa.var_7829ebb7 = [];
    clientfield::register( "actor", "silverback_spawn", 1, 1, "counter" );
    namespace_250e9486::function_252dff4d( "silverback", &function_644621c0, &function_12462f60 );
    registerbehaviorscriptfunctions();
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 0
// Checksum 0xebefff4f, Offset: 0x4d0
// Size: 0x8b4
function registerbehaviorscriptfunctions()
{
    assert( isscriptfunctionptr( &function_7ea2ce80 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_13a7c5f0e3443c41", &function_7ea2ce80 );
    assert( isscriptfunctionptr( &function_5ea59a34 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_2e4df6a195ecfec9", &function_5ea59a34 );
    assert( isscriptfunctionptr( &function_f23c95c0 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_5842fe16f70c7666", &function_f23c95c0 );
    assert( isscriptfunctionptr( &function_57a2b7f5 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_4d98d9c9ffa44e4a", &function_57a2b7f5 );
    assert( isscriptfunctionptr( &function_393e6415 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_5e697a4c27f75b89", &function_393e6415 );
    assert( isscriptfunctionptr( &function_300bba8c ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_54f2476b821b6122", &function_300bba8c );
    assert( !isdefined( &function_33d8ef00 ) || isscriptfunctionptr( &function_33d8ef00 ) );
    assert( !isdefined( &function_3e4a0d4f ) || isscriptfunctionptr( &function_3e4a0d4f ) );
    assert( !isdefined( &function_a0e76e3c ) || isscriptfunctionptr( &function_a0e76e3c ) );
    behaviortreenetworkutility::registerbehaviortreeaction( #"hash_40d132fce22a5e1f", &function_33d8ef00, &function_3e4a0d4f, &function_a0e76e3c );
    assert( !isdefined( &function_6d8dd464 ) || isscriptfunctionptr( &function_6d8dd464 ) );
    assert( !isdefined( &function_3eb8351a ) || isscriptfunctionptr( &function_3eb8351a ) );
    assert( !isdefined( &function_fcbe1c10 ) || isscriptfunctionptr( &function_fcbe1c10 ) );
    behaviortreenetworkutility::registerbehaviortreeaction( #"hash_2154c6eadedb4030", &function_6d8dd464, &function_3eb8351a, &function_fcbe1c10 );
    assert( !isdefined( &function_a1f4593d ) || isscriptfunctionptr( &function_a1f4593d ) );
    assert( !isdefined( &function_78e41d77 ) || isscriptfunctionptr( &function_78e41d77 ) );
    assert( !isdefined( &function_aacc3221 ) || isscriptfunctionptr( &function_aacc3221 ) );
    behaviortreenetworkutility::registerbehaviortreeaction( #"hash_3f09038802c74759", &function_a1f4593d, &function_78e41d77, &function_aacc3221 );
    assert( !isdefined( &function_ea163d5b ) || isscriptfunctionptr( &function_ea163d5b ) );
    assert( !isdefined( &function_cea06112 ) || isscriptfunctionptr( &function_cea06112 ) );
    assert( !isdefined( &function_ebaf98e0 ) || isscriptfunctionptr( &function_ebaf98e0 ) );
    behaviortreenetworkutility::registerbehaviortreeaction( #"hash_507d2a221b595a43", &function_ea163d5b, &function_cea06112, &function_ebaf98e0 );
    assert( !isdefined( &function_77e73b0 ) || isscriptfunctionptr( &function_77e73b0 ) );
    assert( !isdefined( &function_ae656597 ) || isscriptfunctionptr( &function_ae656597 ) );
    assert( !isdefined( &function_3a5a0b29 ) || isscriptfunctionptr( &function_3a5a0b29 ) );
    behaviortreenetworkutility::registerbehaviortreeaction( #"hash_32d2aabab53b4ba6", &function_77e73b0, &function_ae656597, &function_3a5a0b29 );
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 0
// Checksum 0x472a061b, Offset: 0xd90
// Size: 0x354
function function_644621c0()
{
    self namespace_250e9486::function_25b2c8a9();
    self.animrate = 1;
    self.boss = 1;
    self.var_6e5b38d9 = 0;
    self.var_3b0b5ef8 = 0;
    self.var_434f2387 = 0;
    self.var_aff8ab1 = 0;
    self.var_131a202d = 0;
    self.var_1c8b76d3 = 1;
    self.health = 500000;
    self.maxhealth = self.health;
    self.meleedistsq = sqr( 80 );
    self.var_b0f99546 = undefined;
    self setavoidancemask( "avoid none" );
    self.goalradius = 80;
    self.doa.var_ad888d1f = [];
    self.doa.var_6b4163f1 = 0;
    self setteam( #"neutral" );
    self.no_gib = 1;
    self.var_b467f3a1 = &function_256f6f3c;
    self.var_5603780 = &function_ddfdaf41;
    self callback::function_d8abfc3d( #"on_ai_killed", &function_31f5e5b );
    self thread namespace_ec06fe4a::function_d55f042c( level, "round_about_to_start" );
    self.var_febfd0 = namespace_ec06fe4a::spawnorigin( self.origin );
    
    if ( isdefined( self.var_febfd0 ) )
    {
        self.var_febfd0 thread namespace_ec06fe4a::function_d55f042c( self, "death" );
    }
    
    self.trigger = namespace_ec06fe4a::spawntrigger( "trigger_radius", self.origin, 2 | 1 | 512, 50, 50 );
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger thread function_f87ac23b( self );
        self.trigger enablelinkto();
        self.trigger linkto( self );
        self.trigger thread namespace_ec06fe4a::function_d55f042c( self, "death" );
    }
    
    self namespace_83eb6304::function_3ecfde67( "player_trail_red" );
    self thread function_fa03570e();
    self thread function_27adf2ff();
    self function_add8c81a();
    level.doa.var_7829ebb7[ level.doa.var_7829ebb7.size ] = self;
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 0
// Checksum 0x3c237f5c, Offset: 0x10f0
// Size: 0x160
function function_12462f60()
{
    self endon( #"death" );
    self thread namespace_250e9486::function_8971bbb7();
    var_9a615a35 = 0;
    
    while ( true )
    {
        if ( var_9a615a35 < 200 && self.zombie_move_speed == "run" || self.zombie_move_speed == "walk" )
        {
            var_9a615a35++;
        }
        
        if ( var_9a615a35 > 0 && self.zombie_move_speed == "sprint" )
        {
            var_9a615a35 -= 4;
            
            if ( var_9a615a35 <= 0 )
            {
                var_9a615a35 = 0;
                self function_add8c81a( self.var_993e6488 );
            }
        }
        
        if ( self.zombie_move_speed == "run" && var_9a615a35 == 200 )
        {
            self function_add8c81a( "sprint" );
        }
        
        self namespace_dfc652ee::function_d936944a();
        self namespace_dfc652ee::function_cbae9ca3();
        wait 0.2;
    }
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 1
// Checksum 0xfdcdc97, Offset: 0x1258
// Size: 0x10e
function function_add8c81a( rate = "run" )
{
    if ( rate == "next" && self.zombie_move_speed == "walk" )
    {
        rate = "run";
    }
    
    if ( rate == "next" && self.zombie_move_speed == "run" )
    {
        rate = "sprint";
    }
    
    if ( rate == "next" && self.zombie_move_speed == "sprint" )
    {
        rate = "super_sprint";
    }
    
    if ( rate == "walk" )
    {
    }
    else if ( rate == "run" )
    {
    }
    else if ( rate == "sprint" )
    {
    }
    
    self.var_993e6488 = self.zombie_move_speed;
    self.zombie_move_speed = rate;
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 1
// Checksum 0x141b0f33, Offset: 0x1370
// Size: 0x44
function function_ca4a3a4f( position )
{
    self.var_860a34b9 = position;
    self.ignoreall = 1;
    self namespace_250e9486::function_41354e51( self.var_860a34b9 );
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 2
// Checksum 0xf52a161f, Offset: 0x13c0
// Size: 0xdc
function function_27adf2ff( on = 1, var_a53a6d94 = 1 )
{
    if ( isdefined( self.trigger ) )
    {
        if ( on )
        {
            self namespace_83eb6304::function_3ecfde67( "silverback_shield" );
            self.takedamage = 0;
        }
        else
        {
            self namespace_83eb6304::turnofffx( "silverback_shield" );
            self.takedamage = 1;
        }
        
        self.trigger triggerenable( var_a53a6d94 );
        return;
    }
    
    assert( 0, "<dev string:x38>" );
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 1
// Checksum 0x9fdfd13, Offset: 0x14a8
// Size: 0x136
function function_f87ac23b( owner )
{
    self endon( #"death" );
    
    while ( true )
    {
        result = self waittill( #"trigger" );
        
        if ( isdefined( result.activator ) )
        {
            if ( result.activator.team == #"allies" )
            {
                result.activator dodamage( result.activator.health, self.origin, owner, owner );
                continue;
            }
            
            if ( result.activator.team == #"axis" )
            {
                if ( namespace_250e9486::function_3d752709( result.activator ) )
                {
                    result.activator namespace_250e9486::setup_zombie_knockdown( owner );
                    result.activator.knockdown_type = "knockdown_shoved";
                }
            }
        }
    }
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 0
// Checksum 0x80f724d1, Offset: 0x15e8
// Size: 0x4
function function_ddfdaf41()
{
    
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 0
// Checksum 0x89c6b8e5, Offset: 0x15f8
// Size: 0x60
function function_fa03570e()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"hash_c7574e887244a9c" );
        radiusdamage( self.origin, 100, 2000, 2000, self, "MOD_CRUSH" );
    }
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 1
// Checksum 0xcbdf7bca, Offset: 0x1660
// Size: 0x11c
function function_31f5e5b( *params )
{
    self playsound( #"hash_1a98249973c13340" );
    
    if ( isdefined( self.wig ) )
    {
        self.wig delete();
    }
    
    if ( isdefined( self.glasses ) )
    {
        self.glasses delete();
    }
    
    if ( isdefined( self.spoon ) )
    {
        self.spoon delete();
    }
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger delete();
    }
    
    if ( isdefined( self.var_febfd0 ) )
    {
        self.var_febfd0 delete();
    }
    
    arrayremovevalue( level.doa.var_7829ebb7, self );
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 1
// Checksum 0x919198b2, Offset: 0x1788
// Size: 0x21a, Type: bool
function function_7ea2ce80( entity )
{
    if ( is_true( entity.collector ) )
    {
        return false;
    }
    
    if ( isdefined( entity.var_b0f99546 ) )
    {
        return true;
    }
    
    if ( !isdefined( entity.enemy ) )
    {
        return false;
    }
    
    time = gettime();
    
    if ( time < entity.var_6e5b38d9 )
    {
        return false;
    }
    
    if ( randomint( 100 ) > 30 )
    {
        entity.var_6e5b38d9 = time + 3000;
        return false;
    }
    
    var_92423047 = [];
    
    if ( time > entity.var_aff8ab1 && randomint( 100 ) < 40 )
    {
        var_92423047[ var_92423047.size ] = #"hash_aea0ed21dcd8548";
    }
    
    if ( time > entity.var_434f2387 && randomint( 100 ) < 20 )
    {
        var_92423047[ var_92423047.size ] = #"hash_3dd480845ef2e135";
    }
    
    if ( time > entity.var_131a202d && randomint( 100 ) < 40 )
    {
        distsq = distancesquared( entity.origin, entity.enemy.origin );
        
        if ( distsq > sqr( 128 ) )
        {
            var_92423047[ var_92423047.size ] = #"hash_65e4e48a8b85b3ac";
        }
    }
    
    if ( var_92423047.size == 0 )
    {
        return false;
    }
    
    entity.var_b0f99546 = var_92423047[ randomint( var_92423047.size ) ];
    return true;
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 1
// Checksum 0xdfb9ee95, Offset: 0x19b0
// Size: 0x78
function function_6ae08d6c( origin )
{
    silverback = doa_enemy::function_db55a448( doa_enemy::function_d7c5adee( "silverback" ), origin );
    silverback.targetname = "silverback";
    silverback clientfield::increment( "silverback_spawn", 1 );
    return silverback;
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 0
// Checksum 0x366d4a38, Offset: 0x1a30
// Size: 0x28c
function function_571bb3ac()
{
    sides = array( "top", "bottom", "left", "right" );
    center = [[ level.doa.var_39e3fa99 ]]->function_ffcf1d1();
    spot = [[ level.doa.var_39e3fa99 ]]->function_635991ca();
    silverback = function_6ae08d6c( spot.origin );
    
    if ( isdefined( silverback ) )
    {
        level.doa.silverback = silverback;
        silverback endon( #"death" );
        silverback function_add8c81a( "walk" );
        silverback.collector = 1;
        silverback.var_6ea9e4cf = 1;
        silverback.goalradius = 16;
        silverback function_2c4249ed( sqr( 28 ) );
        silverback thread function_b8b0ddc9();
        result = level waittilltimeout( 60, #"doa_exit_taken", #"teleporter_taken", #"enter_the_wild", #"hash_72523790f36bd2a8", #"hash_7270a59e1f502d96" );
        silverback notify( #"hash_12a971f135d4af7c" );
        silverback notify( #"hash_72523790f36bd2a8" );
        silverback.var_6ea9e4cf = undefined;
        silverback.var_b0f99546 = #"hash_3dd480845ef2e135";
        level waittilltimeout( 3, #"move_to_pos_downward_cycle", #"hash_1b322de3d2e3e781" );
        silverback.var_febfd0 notify( #"hash_6a084b9f99f4ada5" );
        silverback delete();
    }
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 1
// Checksum 0xe179bdf6, Offset: 0x1cc8
// Size: 0x98
function function_2c4249ed( distsq )
{
    self notify( "4fca17aef68a8bd4" );
    self endon( "4fca17aef68a8bd4" );
    self endon( #"death" );
    self endon( #"hash_726c573f1b22d654" );
    
    while ( true )
    {
        if ( distancesquared( self.origin, self.goalpos ) <= distsq )
        {
            self notify( #"near_goal" );
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 1
// Checksum 0xda03e13b, Offset: 0x1d68
// Size: 0x22
function function_5ea59a34( entity )
{
    return is_true( entity.var_6ea9e4cf );
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 2, eflags: 0x4
// Checksum 0xb7528599, Offset: 0x1d98
// Size: 0x80
function private function_77e73b0( entity, asmstatename )
{
    animationstatenetworkutility::requeststate( entity, asmstatename );
    self playsound( "zmb_simianaut_roar" );
    entity thread function_8a27e135();
    entity thread function_89406011();
    return 5;
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 2, eflags: 0x4
// Checksum 0x24106b16, Offset: 0x1e20
// Size: 0x38
function private function_ae656597( entity, *asmstatename )
{
    if ( is_true( asmstatename.var_6ea9e4cf ) )
    {
        return 5;
    }
    
    return 4;
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 2, eflags: 0x4
// Checksum 0x4ef3317, Offset: 0x1e60
// Size: 0x58
function private function_3a5a0b29( entity, *asmstatename )
{
    asmstatename.var_6ea9e4cf = undefined;
    asmstatename.ignoreall = 0;
    asmstatename.var_860a34b9 = undefined;
    asmstatename thread namespace_6e90e490::function_47e11416( 6 );
    return 4;
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 0
// Checksum 0x1ed051ed, Offset: 0x1ec0
// Size: 0x4a
function function_8a27e135()
{
    self notify( "b431d0935f85c1e" );
    self endon( "b431d0935f85c1e" );
    self endon( #"death" );
    self waittill( #"hash_12a971f135d4af7c" );
    self.var_6ea9e4cf = undefined;
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 0
// Checksum 0xd4f1fde, Offset: 0x1f18
// Size: 0xc4
function function_b8b0ddc9()
{
    self notify( "59fe151301d648e7" );
    self endon( "59fe151301d648e7" );
    self endon( #"death" );
    self endon( #"hash_72523790f36bd2a8" );
    wait 8;
    waitresult = self waittill( #"damage" );
    
    if ( isdefined( waitresult.attacker ) && isplayer( waitresult.attacker ) )
    {
        self.var_6ea9e4cf = undefined;
        self.favoriteenemy = waitresult.attacker;
    }
    
    self thread function_b8b0ddc9();
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 0
// Checksum 0x3dd686a, Offset: 0x1fe8
// Size: 0x34a
function function_89406011()
{
    self notify( "17e46aae9d232c5c" );
    self endon( "17e46aae9d232c5c" );
    self endon( #"death" );
    self endon( #"hash_72523790f36bd2a8" );
    wait 1;
    start = gettime();
    self.targetent = undefined;
    var_16fa4836 = 0;
    var_eef86c22 = 4;
    
    while ( is_true( self.var_6ea9e4cf ) )
    {
        time = gettime();
        
        if ( time - start > 12000 )
        {
            start = time;
            self function_add8c81a( "run" );
        }
        
        if ( isdefined( self.targetent ) )
        {
            if ( is_true( self.targetent.pickedup ) || isplayer( self.targetent ) && self.targetent.health <= 0 )
            {
                self.targetent = undefined;
            }
        }
        
        if ( !isdefined( self.targetent ) )
        {
            if ( level.doa.var_cc831548.size > 3 )
            {
                tries = 4;
                
                while ( tries )
                {
                    tries--;
                    self.targetent = level.doa.var_cc831548[ randomint( level.doa.var_cc831548.size ) ];
                    
                    if ( self.var_e9f01cea === self.targetent )
                    {
                        continue;
                    }
                    
                    if ( self.var_e9f01cea === self.targetent )
                    {
                        self.targetent = undefined;
                        continue;
                    }
                    
                    break;
                }
            }
            
            if ( !isdefined( self.targetent ) )
            {
                self.targetent = namespace_ec06fe4a::function_6eacecf5( self.origin, 2048 );
            }
        }
        
        if ( isdefined( self.targetent ) )
        {
            var_16fa4836 = 0;
            self function_ca4a3a4f( self.targetent.origin );
            
            if ( !isplayer( self.targetent ) )
            {
                self waittill( #"near_goal" );
                self.var_e9f01cea = self.targetent;
                self.targetent = undefined;
                var_eef86c22--;
                
                if ( var_eef86c22 <= 0 )
                {
                    self.var_6ea9e4cf = undefined;
                    break;
                }
                
                continue;
            }
        }
        
        if ( !isdefined( self.targetent ) )
        {
            var_16fa4836++;
            
            if ( var_16fa4836 > 20 )
            {
                level notify( #"hash_72523790f36bd2a8" );
                return;
            }
        }
        
        wait 0.5;
    }
    
    self notify( #"hash_726c573f1b22d654" );
    self.ignoreall = 0;
    self.var_860a34b9 = undefined;
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 1
// Checksum 0x11dff773, Offset: 0x2340
// Size: 0x80, Type: bool
function function_f23c95c0( entity )
{
    if ( is_true( entity.var_ba88972 ) )
    {
        return true;
    }
    
    if ( gettime() < entity.var_3b0b5ef8 )
    {
        return false;
    }
    
    entity.var_3b0b5ef8 += randomint( 1000 );
    return randomint( 100 ) < 5;
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 2, eflags: 0x4
// Checksum 0xf749892c, Offset: 0x23c8
// Size: 0x70
function private function_33d8ef00( entity, asmstatename )
{
    entity.var_3b0b5ef8 = gettime() + 8000 + randomint( 6000 );
    animationstatenetworkutility::requeststate( entity, asmstatename );
    entity thread function_5dfb821d();
    return 5;
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 2, eflags: 0x4
// Checksum 0x387518e9, Offset: 0x2440
// Size: 0x38
function private function_3e4a0d4f( entity, *asmstatename )
{
    if ( is_true( asmstatename.var_ba88972 ) )
    {
        return 5;
    }
    
    return 4;
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 2, eflags: 0x4
// Checksum 0xf28fab2a, Offset: 0x2480
// Size: 0x22
function private function_a0e76e3c( entity, *asmstatename )
{
    asmstatename.var_ba88972 = undefined;
    return 4;
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 0
// Checksum 0xd859a4ee, Offset: 0x24b0
// Size: 0x82
function function_5dfb821d()
{
    self notify( "6edbd50f2f6609a8" );
    self endon( "6edbd50f2f6609a8" );
    self endon( #"death" );
    self.var_ba88972 = 1;
    result = self waittilltimeout( 2, #"taunt_end", #"end" );
    self.var_ba88972 = undefined;
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 1
// Checksum 0x4d475e69, Offset: 0x2540
// Size: 0x24, Type: bool
function function_393e6415( entity )
{
    return entity.var_b0f99546 === #"hash_aea0ed21dcd8548";
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 2, eflags: 0x4
// Checksum 0x68ee78ec, Offset: 0x2570
// Size: 0x120
function private function_6d8dd464( entity, asmstatename )
{
    animationstatenetworkutility::requeststate( entity, asmstatename );
    entity pathmode( "dont move" );
    entity.var_febfd0.angles = entity.angles;
    entity.var_febfd0.origin = entity.origin;
    entity linkto( entity.var_febfd0 );
    entity.var_c4b93228 = randomint( 2 ) + 1;
    entity thread function_396fbf53( entity.var_febfd0, entity.var_c4b93228 );
    
    if ( isdefined( entity.trigger ) )
    {
        entity.trigger triggerenable( 1 );
    }
    
    return 5;
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 2, eflags: 0x4
// Checksum 0x73910fc5, Offset: 0x2698
// Size: 0x38
function private function_3eb8351a( entity, *asmstatename )
{
    if ( function_393e6415( asmstatename ) )
    {
        return 5;
    }
    
    return 4;
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 2, eflags: 0x4
// Checksum 0x99bdba34, Offset: 0x26d8
// Size: 0xc6
function private function_fcbe1c10( entity, *asmstatename )
{
    asmstatename pathmode( "move allowed" );
    asmstatename unlink();
    
    if ( isdefined( asmstatename.trigger ) )
    {
        asmstatename.trigger triggerenable( 0 );
    }
    
    asmstatename.var_aff8ab1 = gettime() + 5000;
    asmstatename.var_6e5b38d9 = gettime() + 3000 + randomint( 3000 );
    asmstatename.var_b0f99546 = undefined;
    return 4;
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 2
// Checksum 0x5e29c066, Offset: 0x27a8
// Size: 0x4c6
function function_396fbf53( var_febfd0, numattacks = 1 )
{
    if ( !isdefined( self.enemy ) )
    {
        return;
    }
    
    self endon( #"death" );
    var_accea2d5 = sqr( 64 );
    anim_ang = vectortoangles( self.enemy.origin - self.origin );
    var_febfd0 rotateto( ( 0, anim_ang[ 1 ], 0 ), 0.5 );
    self waittill( #"hash_4effc2ad460c79a6" );
    
    while ( numattacks && isdefined( self.enemy ) )
    {
        numattacks--;
        targetorigin = self.enemy.origin;
        anim_ang = vectortoangles( targetorigin - self.origin );
        var_febfd0 rotateto( ( 0, anim_ang[ 1 ], 0 ), 0.5 );
        var_febfd0 waittill( #"rotatedone" );
        self playsound( "zmb_speed_boost_activate_boss" );
        playrumbleonposition( "explosion_generic", self.origin );
        dist = distance( targetorigin, self.origin ) + 256;
        forward = anglestoforward( var_febfd0.angles );
        var_49e4e4be = var_febfd0.origin + forward * dist;
        trace = groundtrace( var_febfd0.origin + ( 0, 0, 30 ), var_49e4e4be + ( 0, 0, 30 ), 0, self );
        var_49e4e4be = trace[ #"position" ] + forward * -64;
        distsq = distancesquared( var_febfd0.origin, var_49e4e4be );
        var_e1f43424 = math::clamp( int( distsq / var_accea2d5 ), 1, 9999 );
        traveltime = math::clamp( var_e1f43424 * 0.005, 0, 0.7 );
        
        if ( getdvarint( #"hash_370090a969cdbc39", 0 ) )
        {
            level thread namespace_1e25ad94::debugcircle( var_49e4e4be + ( 0, 0, 20 ), 30, 3, ( 1, 0, 0 ) );
            level thread namespace_1e25ad94::debugline( var_49e4e4be + ( 0, 0, 20 ), self.origin + ( 0, 0, 20 ), 3, ( 1, 0, 0 ) );
            var_febfd0 thread namespace_1e25ad94::debugorigin( 3, 20, ( 1, 0, 0 ) );
        }
        
        var_febfd0 thread function_51226983( self.enemy );
        self.boosting = 1;
        var_febfd0 moveto( var_49e4e4be, traveltime );
        var_febfd0 waittilltimeout( traveltime + 2, #"movedone" );
        self.boosting = undefined;
        var_febfd0 notify( #"hash_531e95963631c569" );
        
        if ( getdvarint( #"hash_370090a969cdbc39", 0 ) )
        {
            var_febfd0 notify( #"hash_60eabc6ae83239fe" );
        }
    }
    
    self.var_b0f99546 = undefined;
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 1, eflags: 0x4
// Checksum 0xb46fed20, Offset: 0x2c78
// Size: 0x106
function private function_51226983( target )
{
    if ( !isdefined( target ) )
    {
        return;
    }
    
    self endon( #"death" );
    self endon( #"hash_531e95963631c569" );
    self notify( #"hash_6a084b9f99f4ada5" );
    self endon( #"hash_6a084b9f99f4ada5" );
    target endon( #"death" );
    target endon( #"disconnect" );
    
    while ( isdefined( target ) )
    {
        anim_ang = vectortoangles( target.origin - self.origin );
        self rotateto( ( 0, anim_ang[ 1 ], 0 ), 0.5 );
        self waittill( #"rotatedone" );
    }
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 1
// Checksum 0xe554efc2, Offset: 0x2d88
// Size: 0x24, Type: bool
function function_300bba8c( entity )
{
    return entity.var_b0f99546 === #"hash_3dd480845ef2e135";
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 2, eflags: 0x4
// Checksum 0x5703e24a, Offset: 0x2db8
// Size: 0x120
function private function_a1f4593d( entity, asmstatename )
{
    animationstatenetworkutility::requeststate( entity, asmstatename );
    entity pathmode( "dont move" );
    entity.var_febfd0.angles = entity.angles;
    entity.var_febfd0.origin = entity.origin;
    entity linkto( entity.var_febfd0 );
    entity.var_66f5fb1a = randomint( 2 ) + 1;
    entity thread function_de1c2fc3( entity.var_febfd0, entity.var_66f5fb1a );
    
    if ( isdefined( entity.trigger ) )
    {
        entity.trigger triggerenable( 1 );
    }
    
    return 5;
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 2, eflags: 0x4
// Checksum 0xe2409606, Offset: 0x2ee0
// Size: 0x38
function private function_78e41d77( entity, *asmstatename )
{
    if ( function_300bba8c( asmstatename ) )
    {
        return 5;
    }
    
    return 4;
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 2, eflags: 0x4
// Checksum 0xe2505e4d, Offset: 0x2f20
// Size: 0xc6
function private function_aacc3221( entity, *asmstatename )
{
    asmstatename pathmode( "move allowed" );
    asmstatename unlink();
    
    if ( isdefined( asmstatename.trigger ) )
    {
        asmstatename.trigger triggerenable( 0 );
    }
    
    asmstatename.var_7d10766 = gettime() + 3000;
    asmstatename.var_6e5b38d9 = gettime() + 3000 + randomint( 3000 );
    asmstatename.var_b0f99546 = undefined;
    return 4;
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 2
// Checksum 0xd8369415, Offset: 0x2ff0
// Size: 0x426
function function_de1c2fc3( var_febfd0, numattacks = 1 )
{
    self endon( #"death" );
    self waittill( #"hash_3b8882dbdaef63bf" );
    self notify( #"jumping" );
    
    while ( numattacks )
    {
        numattacks--;
        players = namespace_7f5aeb59::function_23e1f90f();
        
        if ( players.size == 1 )
        {
            self.favoriteenemy = players[ 0 ];
        }
        else
        {
            if ( isdefined( self.enemy ) )
            {
                arrayremovevalue( players, self.enemy );
            }
            
            if ( players.size == 1 )
            {
                self.favoriteenemy = players[ 0 ];
            }
            else
            {
                self.favoriteenemy = players[ randomint( players.size ) ];
            }
        }
        
        if ( isdefined( self.favoriteenemy ) && function_7d0161cb( self.favoriteenemy ) )
        {
            targetpos = self.favoriteenemy.origin;
        }
        
        if ( !isdefined( targetpos ) )
        {
            targetpos = self.origin;
        }
        
        self namespace_e32bb68::function_3a59ec34( "evt_turret_takeoff" );
        self namespace_83eb6304::function_3ecfde67( "silverback_launch" );
        playrumbleonposition( "explosion_generic", self.origin );
        height = 1000;
        timems = height / 1000 * 3000;
        var_febfd0.angles = self.angles;
        var_febfd0.origin = self.origin;
        self linkto( var_febfd0 );
        
        if ( getdvarint( #"hash_225943d24ee71d", 0 ) )
        {
            level thread namespace_1e25ad94::debugcircle( targetpos + ( 0, 0, 20 ), 30, 3, ( 1, 0, 0 ) );
            var_febfd0 thread namespace_1e25ad94::debugorigin( 3, 20, ( 1, 0, 0 ) );
        }
        
        var_febfd0 thread function_51226983( self.enemy );
        self thread function_535befda( "move_to_pos_downward_cycle" );
        var_febfd0 function_36e94670( targetpos, timems, height );
        
        if ( isdefined( self.var_617140d4 ) )
        {
            self.var_617140d4 unlink();
            self.var_617140d4 = undefined;
        }
        
        var_febfd0 notify( #"hash_531e95963631c569" );
        
        if ( getdvarint( #"hash_225943d24ee71d", 0 ) )
        {
            var_febfd0 notify( #"hash_60eabc6ae83239fe" );
        }
        
        self namespace_83eb6304::function_3ecfde67( "silverback_land" );
        self namespace_e32bb68::function_3a59ec34( "evt_turret_land" );
        physicsexplosionsphere( self.origin, 200, 128, 2 );
        earthquake( 0.6, 0.75, self.origin, 200 );
        targetpos = undefined;
    }
    
    self.var_b0f99546 = undefined;
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 1, eflags: 0x4
// Checksum 0xf388297, Offset: 0x3420
// Size: 0xc
function private function_535befda( *var_8767c017 )
{
    
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 1
// Checksum 0x5ff1232e, Offset: 0x3438
// Size: 0xa2, Type: bool
function function_7d0161cb( ent )
{
    if ( !isdefined( ent ) )
    {
        return false;
    }
    
    if ( !isplayer( ent ) )
    {
        return false;
    }
    
    if ( isdefined( ent.doa ) && isdefined( ent.doa.vehicle ) )
    {
        return false;
    }
    
    if ( !isdefined( level.doa.var_39e3fa99 ) || ![[ level.doa.var_39e3fa99 ]]->function_94e37da2( ent ) )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 3
// Checksum 0x81ed1d00, Offset: 0x34e8
// Size: 0x2a8
function function_36e94670( destination, timems, var_fbe64ccb )
{
    self endon( #"death" );
    frames = timems / 50;
    delta = ( destination - self.origin ) / frames;
    stoptime = gettime() + timems;
    var_9843db1b = 0;
    
    if ( isdefined( var_fbe64ccb ) )
    {
        deltaz = var_fbe64ccb / frames / 2;
        var_aa3b6b10 = gettime() + timems / 2;
        
        while ( true )
        {
            time = gettime();
            
            if ( time > stoptime )
            {
                break;
            }
            
            if ( time < var_aa3b6b10 )
            {
                var_9b7b5074 = delta + ( 0, 0, deltaz );
                var_9843db1b = 1;
            }
            else
            {
                if ( is_true( var_9843db1b ) )
                {
                    level notify( #"move_to_pos_downward_cycle" );
                    self notify( #"move_to_pos_downward_cycle" );
                }
                
                var_9843db1b = 0;
                var_9b7b5074 = delta - ( 0, 0, deltaz );
            }
            
            newspot = self.origin + var_9b7b5074;
            
            if ( !var_9843db1b && newspot[ 2 ] < destination[ 2 ] )
            {
                newspot = ( newspot[ 0 ], newspot[ 1 ], destination[ 2 ] );
                
                if ( isai( self ) )
                {
                    self forceteleport( newspot );
                    return;
                }
                
                self.origin = newspot;
                return;
            }
            
            if ( isai( self ) )
            {
                self forceteleport( newspot );
            }
            else
            {
                self.origin = newspot;
            }
            
            waitframe( 1 );
        }
        
        return;
    }
    
    while ( gettime() < stoptime )
    {
        if ( isai( self ) )
        {
            self forceteleport( self.origin + delta );
        }
        else
        {
            self.origin += delta;
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 1
// Checksum 0xa8e47c15, Offset: 0x3798
// Size: 0x24, Type: bool
function function_57a2b7f5( entity )
{
    return entity.var_b0f99546 === #"hash_65e4e48a8b85b3ac";
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 2, eflags: 0x4
// Checksum 0x6f3f7a98, Offset: 0x37c8
// Size: 0x1e8
function private function_ea163d5b( entity, asmstatename )
{
    animationstatenetworkutility::requeststate( entity, asmstatename );
    self thread function_36f40887();
    
    if ( function_1d0310f4() )
    {
        banana1 = namespace_ec06fe4a::spawnmodel( self.origin, "zombietron_banana" );
        
        if ( isdefined( banana1 ) )
        {
            banana1.targetname = "banana1";
            banana1 setmodel( "zombietron_banana" );
            banana1 enablelinkto();
            banana1 linkto( self, "j_thumb_ri_3", ( 0, 0, 0 ), ( 0, 0, 0 ) );
            banana1 thread function_bcfd19b2( self, "fire_banana_right" );
        }
    }
    
    if ( function_1d0310f4() )
    {
        banana2 = namespace_ec06fe4a::spawnmodel( self.origin, "zombietron_banana" );
        
        if ( isdefined( banana2 ) )
        {
            banana2.targetname = "banana2";
            banana2 setmodel( "zombietron_banana" );
            banana2 enablelinkto();
            banana2 linkto( self, "j_thumb_le_3", ( 0, 0, 0 ), ( 0, 0, 0 ) );
            banana2 thread function_bcfd19b2( self, "fire_banana_left" );
        }
    }
    
    return 5;
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 2, eflags: 0x4
// Checksum 0xfe707c3c, Offset: 0x39b8
// Size: 0x38
function private function_cea06112( entity, *asmstatename )
{
    if ( function_57a2b7f5( asmstatename ) )
    {
        return 5;
    }
    
    return 4;
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 2, eflags: 0x4
// Checksum 0xb9885e76, Offset: 0x39f8
// Size: 0x5e
function private function_ebaf98e0( entity, *asmstatename )
{
    asmstatename.var_131a202d = gettime() + 3000;
    asmstatename.var_6e5b38d9 = gettime() + 3000 + randomint( 3000 );
    asmstatename.var_b0f99546 = undefined;
    return 4;
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 0
// Checksum 0x40248a32, Offset: 0x3a60
// Size: 0x1e, Type: bool
function function_1d0310f4()
{
    return level.doa.var_78fe553b.size <= 6;
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 0
// Checksum 0x124c7455, Offset: 0x3a88
// Size: 0x32
function function_36f40887()
{
    self endon( #"death" );
    self waittill( #"hash_25e58964d378516" );
    self.var_b0f99546 = undefined;
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 2
// Checksum 0x89dfd070, Offset: 0x3ac8
// Size: 0x324
function function_bcfd19b2( silverback, note )
{
    level.doa.var_78fe553b[ level.doa.var_78fe553b.size ] = self;
    forward = anglestoforward( silverback.angles );
    target_point = silverback.origin + 64 * forward + ( randomfloatrange( 2 * -1, 2 ), randomfloatrange( 2 * -1, 2 ), 130 );
    dir = vectornormalize( target_point - silverback.origin );
    silverback waittilltimeout( 2, note, #"death" );
    self unlink();
    vel = mapfloat( sqr( 32 ), sqr( 1600 ), 1.8, 5.5, distancesquared( target_point, self.origin ) );
    throw = dir * vel;
    self notsolid();
    self physicslaunch( self.origin, throw );
    wait 0.2;
    self solid();
    self namespace_83eb6304::function_3ecfde67( "explo_warning_light" );
    wait 5;
    self namespace_83eb6304::function_3ecfde67( "silverback_banana_explo" );
    waitframe( 1 );
    trigger = namespace_ec06fe4a::spawntrigger( "trigger_radius", self.origin, 0, 128, 64 );
    trigger thread namespace_ec06fe4a::function_52afe5df( 5 + 0.1 );
    arrayremovevalue( level.doa.var_78fe553b, self );
    self delete();
    
    if ( isdefined( trigger ) )
    {
        trigger.targetname = "banana";
        trigger thread function_d70f65d0();
        wait 5;
        trigger delete();
    }
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 0, eflags: 0x4
// Checksum 0x4b8bedf, Offset: 0x3df8
// Size: 0xca
function private function_d70f65d0()
{
    self endon( #"death" );
    
    while ( true )
    {
        result = self waittill( #"trigger" );
        
        if ( isplayer( result.activator ) )
        {
            if ( !isdefined( result.activator.var_76eebaf0 ) || gettime() > result.activator.var_76eebaf0 )
            {
                result.activator thread namespace_7f5aeb59::function_ec9a307f();
                result.activator.var_76eebaf0 = gettime() + 1000;
            }
        }
    }
}

// Namespace namespace_58e19d6/namespace_58e19d6
// Params 1
// Checksum 0xdfa635c3, Offset: 0x3ed0
// Size: 0x20a
function function_256f6f3c( eventstruct )
{
    notify_string = eventstruct.action;
    
    switch ( notify_string )
    {
        case #"death":
            if ( is_true( self.bgb_tone_death ) )
            {
                level thread namespace_9fc66ac::function_c6daa0fc( self, "death_whimsy", 1, 4 );
            }
            else
            {
                level thread namespace_9fc66ac::function_c6daa0fc( self, notify_string, 1, 4 );
            }
            
            break;
        case #"pain":
            level thread namespace_9fc66ac::function_c6daa0fc( self, notify_string, 1, 3 );
            break;
        case #"scream":
            level thread namespace_9fc66ac::function_c6daa0fc( self, notify_string, 1, 3, 1 );
            break;
        case #"leap":
        case #"attack_melee":
        case #"attack_bite":
            level thread namespace_9fc66ac::function_c6daa0fc( self, notify_string, 1, 2, 1 );
            break;
        case #"sprint":
        case #"ambient":
            level thread namespace_9fc66ac::function_c6daa0fc( self, notify_string, 0, 1 );
            break;
        default:
            level thread namespace_9fc66ac::function_c6daa0fc( self, notify_string, 0, 2 );
            break;
    }
}

