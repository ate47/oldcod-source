#using scripts\core_common\ai\archetype_cover_utility;
#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\ai\archetype_human;
#using scripts\core_common\ai\archetype_human_cover;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\ai_blackboard;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\init;
#using scripts\core_common\ai\systems\shared;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\dialogue;
#using scripts\weapons\smokegrenade;

#namespace namespace_631d466b;

// Namespace namespace_631d466b/namespace_54e681de
// Params 0, eflags: 0x2
// Checksum 0x3e81755f, Offset: 0x428
// Size: 0x54c
function autoexec registerbehaviorscriptfunctions()
{
    assert( isscriptfunctionptr( &function_79851615 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_47be693473e9692c", &function_79851615 );
    assert( isscriptfunctionptr( &function_7824de4c ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_654ce4348b98bfde", &function_7824de4c );
    assert( isscriptfunctionptr( &function_5b111fb9 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_15601f0c63b984a6", &function_5b111fb9 );
    assert( isscriptfunctionptr( &function_10f4a44d ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_18f1d5133fa14804", &function_10f4a44d );
    assert( isscriptfunctionptr( &function_910f816c ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_503a578ed715f79d", &function_910f816c );
    assert( isscriptfunctionptr( &function_663b2f25 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_2f13f6acaa6b6315", &function_663b2f25 );
    assert( isscriptfunctionptr( &function_710d93da ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_3257b2c808bda49a", &function_710d93da );
    assert( isscriptfunctionptr( &function_23828655 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_62e92c17d57b75c8", &function_23828655 );
    assert( isscriptfunctionptr( &function_7e8e056c ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_2a3755babdf15b3c", &function_7e8e056c );
    assert( isscriptfunctionptr( &function_5364406f ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_157f5426deea01a7", &function_5364406f );
    assert( isscriptfunctionptr( &function_1d556d92 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_cfcee0fc40b300b", &function_1d556d92 );
    assert( isscriptfunctionptr( &function_23828655 ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"hash_62e92c17d57b75c8", &function_23828655 );
    assert( isscriptfunctionptr( &function_d086ffd3 ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"hash_26f309f92f859f46", &function_d086ffd3 );
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 3
// Checksum 0x58149a64, Offset: 0x980
// Size: 0x62
function function_6aedb63( goalpos, goalradius, goalheight = 128 )
{
    self.var_6d5624e1 = getclosestpointonnavmesh( goalpos, 400 );
    self.var_61ec1050 = goalradius;
    self.var_2295e0e8 = goalheight;
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 0
// Checksum 0x6fa56478, Offset: 0x9f0
// Size: 0x1e
function function_3d1e9e1c()
{
    self.var_6d5624e1 = undefined;
    self.var_61ec1050 = undefined;
    self.var_2295e0e8 = undefined;
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 2
// Checksum 0x51501aeb, Offset: 0xa18
// Size: 0xea
function function_efd568bc( goalpos, goalradius )
{
    self endon( #"death" );
    self.juggernautdisablemovebehavior = 1;
    self.var_419d64f3 = 1;
    waitframe( 2 );
    self ai::set_behavior_attribute( "demeanor", "combat" );
    self setdesiredspeed( 170 );
    self.ignorepathenemyfightdist = 1;
    self setgoal( goalpos, 0, goalradius, 128 );
    self waittill( #"goal" );
    self.ignorepathenemyfightdist = 0;
    self.juggernautdisablemovebehavior = 0;
    self.var_419d64f3 = undefined;
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 1
// Checksum 0x273afed8, Offset: 0xb10
// Size: 0xba
function function_19eec9a6( enable )
{
    if ( enable )
    {
        self.ignoreall = 1;
        self.juggernautdisablemovebehavior = 1;
        self.var_419d64f3 = 1;
        waitframe( 2 );
        self ai::set_behavior_attribute( "demeanor", "cqb" );
        self setdesiredspeed( 50 );
        self.ignorepathenemyfightdist = 1;
        return;
    }
    
    self.ignoreall = 0;
    self.ignorepathenemyfightdist = 0;
    self.juggernautdisablemovebehavior = 0;
    self.var_419d64f3 = undefined;
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 1
// Checksum 0x1c4988db, Offset: 0xbd8
// Size: 0x5a
function function_f94404c3( stop )
{
    if ( stop )
    {
        self.juggernautdisablemovebehavior = 1;
        waitframe( 2 );
        self setgoal( self.origin, 0, 64, 128 );
        return;
    }
    
    self.juggernautdisablemovebehavior = 0;
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 1
// Checksum 0xa12a2971, Offset: 0xc40
// Size: 0x96
function function_712776a6( enable )
{
    if ( enable )
    {
        self ai::set_behavior_attribute( #"demeanor", "patrol" );
        self.juggernautdisablemovebehavior = 1;
        self.var_419d64f3 = 1;
        return;
    }
    
    self ai::set_behavior_attribute( #"demeanor", "combat" );
    self.juggernautdisablemovebehavior = 0;
    self.var_419d64f3 = undefined;
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 1
// Checksum 0x7d5775bc, Offset: 0xce0
// Size: 0x2e
function function_eaf1039d( timeinseconds )
{
    self.var_dc3a7edb = gettime() + timeinseconds * 1000;
    self.forcefire = 1;
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 0
// Checksum 0x38beca90, Offset: 0xd18
// Size: 0xe
function function_8ddee935()
{
    self.var_dc3a7edb = undefined;
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 1
// Checksum 0xa996adfd, Offset: 0xd30
// Size: 0x4c
function function_57a875b1( use )
{
    if ( use )
    {
        self function_94575fdf();
        return;
    }
    
    self function_678d90a1( 0.001001 );
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 1
// Checksum 0xb3af0e01, Offset: 0xd88
// Size: 0x1a
function function_2709867b( target )
{
    self.var_2709867b = target;
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 1
// Checksum 0xb77e10a, Offset: 0xdb0
// Size: 0x1a
function function_90791fca( target )
{
    self.var_90791fca = target;
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 0, eflags: 0x4
// Checksum 0x8978c641, Offset: 0xdd8
// Size: 0x32, Type: bool
function private function_8fa0d5bb()
{
    return isdefined( self.weapon.weapclass ) && self.weapon.weapclass == "spread";
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 0, eflags: 0x4
// Checksum 0xbaaeb375, Offset: 0xe18
// Size: 0x2e
function private function_d94c6dc3()
{
    goalheight = 128;
    
    if ( isdefined( self.var_2295e0e8 ) )
    {
        goalheight = self.var_2295e0e8;
    }
    
    return goalheight;
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 1, eflags: 0x4
// Checksum 0xdb3039b8, Offset: 0xe50
// Size: 0x9a
function private function_c13c8494( newweapon )
{
    self aiutility::setprimaryweapon( newweapon );
    self aiutility::setcurrentweapon( self.primaryweapon );
    self init::initweapon( self.primaryweapon );
    shared::placeweaponon( self.primaryweapon, "right" );
    self.bulletsinclip = self.weapon.clipsize;
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 0, eflags: 0x4
// Checksum 0x4d846d6d, Offset: 0xef8
// Size: 0x474
function private function_d4384490()
{
    self.var_64d9b494 = 2000;
    self.juggernautgoalradius = 25;
    self.juggernautoutsidegoalradius = 200;
    self.juggernautacceleration = 50;
    self.juggernautcanseeenemydelaymin = 1000;
    self.juggernautcanseeenemydelaymax = 2000;
    self.juggernautrundelaymin = 1000;
    self.juggernautrundelaymax = 2000;
    self.var_537b6b78 = 5;
    self.var_80b41b50 = 1250;
    self.var_f9175e43 = 300;
    self.var_a9e18506 = 100;
    self.var_e53dfc1f = 1000;
    self.var_c60594c9 = 2500;
    self.var_1fd9bbb3 = 500;
    self.var_331669d0 = 10;
    self.var_400176c9 = 5;
    self.var_1a382d61 = sqr( 400 );
    self.var_e35951cc = 15;
    self.var_eb130816 = 20;
    self.var_97dd5ffd = 0;
    self.var_83fcb9db = 2;
    self.var_5e31da98 = 90000;
    self.var_882d3d5 = "juggernaut_strafe_tacquery";
    self.var_f87cb2a2 = "juggernaut_strafe_avoid_tacquery";
    self.var_f722fc63 = "juggernaut_flank_tacquery";
    self.var_53d1f3ac = 400;
    self.var_e476f092 = 150;
    self.var_ea308069 = 100;
    self.var_7953693a = 10000;
    self.var_539db273 = 50;
    
    if ( self function_8fa0d5bb() )
    {
        self.juggernautwalkdist = 500;
        self.juggernautstopdistance = 300;
        self.var_bad61c0 = 1;
        self.var_d87cb1ab = 1;
        self.var_c3d1e9bb = 1;
        self.var_400176c9 = 3;
        self.var_eb130816 = 5;
        self.var_97dd5ffd = 1;
        self.var_83fcb9db = 1;
        self.var_882d3d5 = "juggernaut_shotgun_tacquery";
        self.var_f87cb2a2 = "juggernaut_shotgun_avoid_tacquery";
        self.var_53d1f3ac = 150;
        self.var_539db273 = 80;
        self.juggernautcanseeenemydelaymin = 1000;
        self.juggernautcanseeenemydelaymax = 2000;
        self.var_5e31da98 = 10000;
        shotgun = getweapon( #"hash_3140acb46e8a7fc4", "steadyaim", "sprintout", "reflex" );
        self function_c13c8494( shotgun );
    }
    else
    {
        self.juggernautwalkdist = 1400;
        self.juggernautstopdistance = 850;
        self.var_bad61c0 = 1;
        self.var_d87cb1ab = 1;
        self.var_c3d1e9bb = 1;
        lmg = getweapon( #"hash_228ab35af2dae712", "reflex", "fastreload", "light" );
        self function_c13c8494( lmg );
    }
    
    self.var_d3fb5ec5 = 1;
    self.var_c681e4c1 = 1;
    self.canbemeleed = 0;
    self.ignoresuppression = 1;
    self.var_d53c164a = gettime();
    aiutility::addaioverridedamagecallback( self, &function_be9a301c );
    self.var_fe72f961 = &function_defc3831;
    self.var_b7884e7f = &function_6ca9ecd8;
    
    if ( !isdefined( level.juggernauts ) )
    {
        level.juggernauts = [ self ];
    }
    else
    {
        array::add( level.juggernauts, self, 0 );
    }
    
    self thread function_af0da1ce();
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 0, eflags: 0x4
// Checksum 0x19d616ee, Offset: 0x1378
// Size: 0x6c
function private function_af0da1ce()
{
    self waittill( #"death" );
    function_1eaaceab( level.juggernauts, 0 );
    
    if ( isdefined( self.var_27ee369f.shoottarget ) )
    {
        self.var_27ee369f.shoottarget delete();
    }
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 1, eflags: 0x4
// Checksum 0xf24b6dd4, Offset: 0x13f0
// Size: 0xa6, Type: bool
function private function_f5711280( enemy )
{
    if ( is_true( self.juggernautdisablemovebehavior ) )
    {
        return false;
    }
    
    if ( isdefined( self.go_to_node ) )
    {
        return false;
    }
    
    if ( !isdefined( enemy ) )
    {
        return false;
    }
    
    if ( !issentient( enemy ) )
    {
        return false;
    }
    
    if ( self lastknowntime( enemy ) <= 0 )
    {
        return false;
    }
    
    if ( isdefined( self.meleeenemy ) )
    {
        self.juggernautlastmeleetime = gettime();
        return false;
    }
    
    return true;
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 1, eflags: 0x4
// Checksum 0x38a7cfee, Offset: 0x14a0
// Size: 0x1fa
function private function_250ee533( enemy )
{
    canseeenemy = self cansee( enemy, 250 ) && self canshootenemy( 250 );
    
    if ( canseeenemy )
    {
        self.var_104bdc52.var_22215135 = undefined;
        var_4da29fa1 = angleclamp180( vectortopitch( enemy.origin - self.origin ) );
        
        if ( var_4da29fa1 > self.upaimlimit || var_4da29fa1 < self.downaimlimit )
        {
            canseeenemy = 0;
        }
    }
    
    if ( !canseeenemy && ( !is_true( self.var_c3d1e9bb ) || self isatgoal() ) )
    {
        if ( !isdefined( self.var_104bdc52.canseeenemytime ) && is_true( self.var_104bdc52.var_56aa83a7 ) )
        {
            self.var_104bdc52.canseeenemytime = gettime() + randomintrange( self.juggernautcanseeenemydelaymin, self.juggernautcanseeenemydelaymax );
        }
        
        if ( isdefined( self.var_104bdc52.canseeenemytime ) && self.var_104bdc52.canseeenemytime > gettime() )
        {
            canseeenemy = 1;
        }
    }
    else
    {
        self.var_104bdc52.canseeenemytime = undefined;
    }
    
    if ( canseeenemy )
    {
        self.var_104bdc52.var_22215135 = undefined;
    }
    
    self.var_104bdc52.var_56aa83a7 = canseeenemy;
    return canseeenemy;
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 1, eflags: 0x4
// Checksum 0x5bdffd10, Offset: 0x16a8
// Size: 0x17e
function private function_eec699a0( position )
{
    self.var_104bdc52.targetoutsidegoal = 0;
    
    if ( !( isdefined( self.var_6d5624e1 ) && isdefined( self.var_61ec1050 ) ) )
    {
        return position;
    }
    
    if ( distancesquared( position, self.var_6d5624e1 ) <= sqr( self.var_61ec1050 ) )
    {
        return position;
    }
    
    self.var_104bdc52.targetoutsidegoal = 1;
    var_9482199b = position - self.var_6d5624e1;
    var_9482199b = vectornormalize( var_9482199b );
    newposition = self.var_6d5624e1 + self.var_61ec1050 * var_9482199b;
    var_db87855d = 150;
    verticaloffset = 70;
    startposition = newposition + ( 0, 0, verticaloffset - var_db87855d );
    droppedpos = function_9cc082d2( startposition, var_db87855d );
    
    if ( isdefined( droppedpos[ #"point" ] ) )
    {
        newposition = droppedpos[ #"point" ];
    }
    
    return newposition;
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 1, eflags: 0x4
// Checksum 0xaf2eaf98, Offset: 0x1830
// Size: 0x1c2
function private function_8f80ae76( goalposition )
{
    var_e3dbb13d = 0;
    newgoalposition = goalposition;
    
    foreach ( other in level.juggernauts )
    {
        if ( other != self && isdefined( other.var_104bdc52.enemy ) && other.var_104bdc52.enemy == self.var_104bdc52.enemy && distancesquared( other.origin, goalposition ) < sqr( 128 ) )
        {
            var_ce7b333c = goalposition - other.origin;
            var_ce7b333c = ( var_ce7b333c[ 0 ], var_ce7b333c[ 1 ], 0 );
            newgoalposition += vectornormalize( var_ce7b333c ) * 128;
            var_e3dbb13d = 1;
        }
    }
    
    if ( var_e3dbb13d )
    {
        goalposition = self function_eec699a0( newgoalposition );
        goalposition = getclosestpointonnavmesh( goalposition, 500, 25 );
    }
    
    return goalposition;
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 3, eflags: 0x4
// Checksum 0xfec49d45, Offset: 0x1a00
// Size: 0x1f6
function private function_e3a04b59( distancetotarget, currentspeed, walkdist )
{
    var_533af8f8 = !is_true( self.juggernautforcewalk ) && distancetotarget > walkdist;
    
    if ( var_533af8f8 && ( !isdefined( self.var_104bdc52.running ) || !self.var_104bdc52.running ) )
    {
        if ( !isdefined( self.var_104bdc52.rundelay ) )
        {
            self.var_104bdc52.rundelay = gettime() + randomintrange( self.juggernautrundelaymin, self.juggernautrundelaymax );
        }
        
        if ( self.var_104bdc52.rundelay > gettime() )
        {
            var_533af8f8 = 0;
        }
    }
    
    if ( !isdefined( self.var_104bdc52.running ) || self.var_104bdc52.runcooldown < gettime() && var_533af8f8 != self.var_104bdc52.running )
    {
        if ( var_533af8f8 )
        {
            if ( !isdefined( self.var_104bdc52.running ) || currentspeed > 0 )
            {
                self.var_104bdc52.runcooldown = gettime() + self.var_64d9b494;
                self.var_104bdc52.running = 1;
                self.var_104bdc52.targetmovespeed = 170;
                self.var_104bdc52.rundelay = undefined;
            }
            
            return;
        }
        
        self.var_104bdc52.runcooldown = gettime() + self.var_64d9b494;
        self.var_104bdc52.running = 0;
        self.var_104bdc52.targetmovespeed = self.var_539db273;
    }
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 3, eflags: 0x4
// Checksum 0x782dc49e, Offset: 0x1c00
// Size: 0x946
function private function_420d19e0( enemy, currentspeed, canseeenemy )
{
    curtime = gettime();
    
    if ( curtime >= self.var_104bdc52.nextupdatetime )
    {
        self.var_104bdc52.targetpos = function_eec699a0( enemy.origin );
        self.var_104bdc52.targetpos = getclosestpointonnavmesh( self.var_104bdc52.targetpos, 500, 25 );
        self getenemyinfo( enemy );
    }
    
    if ( !isdefined( self.var_104bdc52.targetpos ) )
    {
        self function_ff58993b();
        return;
    }
    
    var_2c6a6e68 = generatenavmeshpath( self.origin, self.var_104bdc52.targetpos, self );
    
    if ( isdefined( var_2c6a6e68 ) && isdefined( var_2c6a6e68.pathpoints ) )
    {
        distancetotarget = var_2c6a6e68.pathdistance;
    }
    else
    {
        distancetotarget = distance( self.origin, self.var_104bdc52.targetpos );
    }
    
    goalposition = undefined;
    var_2760151b = 1;
    var_11dbb576 = enemy.origin;
    
    if ( !canseeenemy || is_true( self.var_104bdc52.targetoutsidegoal ) )
    {
        var_d3e584bc = distance2dsquared( self.var_104bdc52.targetpos, self.origin ) < 4 && abs( self.var_104bdc52.targetpos[ 2 ] - self.origin[ 2 ] ) < 60;
        
        if ( var_d3e584bc || is_true( self.var_104bdc52.backup ) )
        {
            var_11dbb576 = self.var_104bdc52.targetpos;
        }
        else
        {
            self.var_104bdc52.stopping = 0;
            goalposition = self.var_104bdc52.targetpos;
            var_2760151b = 0;
        }
    }
    
    stopdistance = self.juggernautstopdistance;
    
    if ( isdefined( self.var_29aecd37 ) && self.var_29aecd37 > gettime() )
    {
        stopdistance = self.var_ea308069;
    }
    
    if ( var_2760151b )
    {
        var_ef8ccbb8 = stopdistance + 150;
        insmoke = 0;
        
        if ( isdefined( self.var_df0989d ) && isdefined( self.smokegrenadetime ) && isdefined( self.var_47a7add4 ) && isdefined( self.smokegrenadeposition ) && !util::time_has_passed( self.smokegrenadetime, self.var_47a7add4 ) && distance( self.smokegrenadeposition, self.origin ) < self.var_df0989d )
        {
            insmoke = 1;
        }
        
        if ( !insmoke && distance( self.origin, var_11dbb576 ) < 150 )
        {
            if ( !isdefined( self.var_104bdc52.backuptime ) )
            {
                self.var_104bdc52.backuptime = gettime() + 1000;
            }
            
            if ( self.var_104bdc52.backuptime < gettime() && !is_true( self.var_104bdc52.backup ) || curtime >= self.var_104bdc52.nextupdatetime )
            {
                var_d7231236 = self.origin - var_11dbb576;
                var_d7231236 = ( var_d7231236[ 0 ], var_d7231236[ 1 ], 0 );
                self.var_104bdc52.stopposition = var_11dbb576 + vectornormalize( var_d7231236 ) * 150;
                self.var_104bdc52.stopposition = getclosestpointonnavmesh( self.var_104bdc52.stopposition, 500, 25 );
                self.var_104bdc52.stopping = 1;
                self.var_104bdc52.backup = 1;
            }
        }
        else
        {
            self.var_104bdc52.backup = 0;
            self.var_104bdc52.backuptime = undefined;
        }
        
        if ( is_true( self.var_104bdc52.backup ) )
        {
            goalposition = self.var_104bdc52.stopposition;
        }
        else
        {
            if ( is_true( self.var_104bdc52.stopping ) )
            {
                testdistance = var_ef8ccbb8 + 50;
            }
            else
            {
                testdistance = stopdistance + 50;
            }
            
            if ( distancetotarget > testdistance )
            {
                self.var_104bdc52.stopping = 0;
                goalposition = self.var_104bdc52.targetpos;
            }
            else if ( !is_true( self.var_104bdc52.stopping ) )
            {
                self.var_104bdc52.stopping = 1;
                goalposition = self getposonpath( 50 );
                goalposition = self function_8f80ae76( goalposition );
                self.var_104bdc52.stopposition = goalposition;
            }
            else
            {
                goalposition = self.var_104bdc52.stopposition;
            }
        }
    }
    
    goalradius = self.juggernautgoalradius;
    
    if ( is_true( self.var_104bdc52.targetoutsidegoal ) && canseeenemy )
    {
        goalradius = self.juggernautoutsidegoalradius;
    }
    
    toenemy = enemy.origin - goalposition;
    faceangles = vectortoangles( toenemy );
    self setgoal( goalposition, 0, goalradius, self function_d94c6dc3(), faceangles );
    
    /#
        if ( getdvarint( #"hash_66f7f4e4b4f61e99", 0 ) == 1 )
        {
            sphere( goalposition, 5, ( 0, 0, 1 ), 1, 0, 10, 1 );
            line( self.origin, goalposition, ( 0, 0, 1 ), 1, 0, 1 );
            recordsphere( goalposition, 5, ( 0, 0, 1 ), "<dev string:x38>", self );
            recordline( self.origin, goalposition, ( 0, 0, 1 ), "<dev string:x38>", self );
        }
    #/
    
    self function_e3a04b59( distancetotarget, currentspeed, self.juggernautwalkdist );
    
    /#
        if ( getdvarint( #"hash_7362b665dd679b46", 0 ) == 1 )
        {
            text = "<dev string:x42>" + canseeenemy + "<dev string:x4e>" + distancetotarget + "<dev string:x59>" + self.juggernautwalkdist;
            print3d( self.origin + ( 0, 0, 60 ), text );
            record3dtext( text, self.origin + ( 0, 0, 60 ), ( 1, 1, 1 ), "<dev string:x38>", self, 1 );
        }
    #/
    
    if ( curtime >= self.var_104bdc52.nextupdatetime )
    {
        self.var_104bdc52.nextupdatetime = curtime + 500;
    }
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 1, eflags: 0x4
// Checksum 0x647ae885, Offset: 0x2550
// Size: 0x33c
function private function_7d6831f7( enemy )
{
    self.var_104bdc52.var_ca3a6f54 = undefined;
    self.var_104bdc52.var_15576457 = gettime();
    self.var_104bdc52.var_be1be68b = enemy.origin;
    self.var_104bdc52.var_ae99337 = undefined;
    
    /#
        self.var_ffe5c2cc = 0;
    #/
    
    var_35d04e24 = self function_eec699a0( self.var_104bdc52.var_be1be68b );
    
    if ( isdefined( self.smokegrenadetime ) && isdefined( self.var_47a7add4 ) && !util::time_has_passed( self.smokegrenadetime, self.var_47a7add4 ) )
    {
        tacpoints = tacticalquery( self.var_f722fc63, enemy, self );
        self.var_104bdc52.var_ae99337 = 1;
    }
    else
    {
        if ( !( isdefined( self.var_61ec1050 ) && isdefined( self.var_6d5624e1 ) && isdefined( self.var_2295e0e8 ) ) )
        {
            cylinder = ai::t_cylinder( enemy.origin, 700, 64 );
            var_e0995b29 = enemy.origin;
        }
        else
        {
            cylinder = ai::t_cylinder( self.var_6d5624e1, self.var_61ec1050, self.var_2295e0e8 / 2 );
            var_e0995b29 = self.var_6d5624e1;
        }
        
        if ( isdefined( self.var_90791fca ) )
        {
            tacpoints = tacticalquery( self.var_f87cb2a2, enemy, self, self.var_90791fca, cylinder, var_e0995b29 );
        }
        else
        {
            tacpoints = tacticalquery( self.var_882d3d5, enemy, self, cylinder, var_e0995b29 );
        }
    }
    
    if ( !isdefined( tacpoints ) || tacpoints.size == 0 )
    {
        /#
            if ( getdvarint( #"hash_6683a7e64b5079ce", 0 ) )
            {
                record3dtext( "<dev string:x60>", self.origin, ( 1, 0, 0 ), "<dev string:x77>", self, 0.5 );
            }
        #/
        
        self.var_104bdc52.tacpoints = undefined;
        self.var_104bdc52.var_bd6cc3ff = undefined;
        return 0;
    }
    
    self.var_104bdc52.tacpoints = [];
    
    for ( i = 0; i < 10 && i < tacpoints.size ; i++ )
    {
        self.var_104bdc52.tacpoints[ self.var_104bdc52.tacpoints.size ] = tacpoints[ i ];
    }
    
    self.var_104bdc52.var_bd6cc3ff = -1;
    return 1;
}

/#

    // Namespace namespace_631d466b/namespace_54e681de
    // Params 3, eflags: 0x4
    // Checksum 0x70909a5b, Offset: 0x2898
    // Size: 0xdc, Type: dev
    function private function_daa06c57( tacpoint, success, message )
    {
        /#
            if ( !isdefined( self.var_ffe5c2cc ) )
            {
                self.var_ffe5c2cc = 0;
            }
        #/
        
        self.var_ffe5c2cc += 1;
        
        if ( getdvarint( #"hash_6683a7e64b5079ce", 0 ) )
        {
            color = ( 1, 0, 0 );
            
            if ( success )
            {
                color = ( 0, 1, 0 );
            }
            
            record3dtext( self.var_ffe5c2cc + "<dev string:x81>" + message, tacpoint.origin, color, "<dev string:x77>", self, 0.5 );
        }
    }

#/

// Namespace namespace_631d466b/namespace_54e681de
// Params 1, eflags: 0x4
// Checksum 0xafba61cf, Offset: 0x2980
// Size: 0x5b0, Type: bool
function private function_e2a815e9( enemy )
{
    if ( !( isdefined( self.var_104bdc52.tacpoints ) && isdefined( self.var_104bdc52.var_bd6cc3ff ) ) )
    {
        return true;
    }
    
    self.var_104bdc52.var_bd6cc3ff += 1;
    
    if ( self.var_104bdc52.var_bd6cc3ff >= self.var_104bdc52.tacpoints.size )
    {
        tacpoint = self.var_104bdc52.tacpoints[ 0 ];
        self.var_104bdc52.var_bd6cc3ff = undefined;
        self.var_104bdc52.tacpoints = undefined;
        self.var_104bdc52.stopposition = tacpoint.origin;
        self.var_104bdc52.var_22215135 = 1;
        toenemy = enemy.origin - tacpoint.origin;
        faceangles = vectortoangles( toenemy );
        self setgoal( tacpoint.origin, 0, self.juggernautgoalradius, self function_d94c6dc3(), faceangles );
        
        /#
            self function_daa06c57( tacpoint, 1, "<dev string:x87>" );
        #/
        
        return true;
    }
    
    tacpoint = self.var_104bdc52.tacpoints[ self.var_104bdc52.var_bd6cc3ff ];
    
    if ( isdefined( self.var_61ec1050 ) && isdefined( self.var_6d5624e1 ) && isdefined( self.var_2295e0e8 ) )
    {
        if ( distance( tacpoint.origin, self.var_6d5624e1 ) > self.var_61ec1050 )
        {
            /#
                self function_daa06c57( tacpoint, 0, "<dev string:x9a>" );
            #/
            
            return true;
        }
        
        if ( abs( tacpoint.origin[ 2 ] - self.var_6d5624e1[ 2 ] ) > self.var_2295e0e8 )
        {
            /#
                self function_daa06c57( tacpoint, 0, "<dev string:xb1>" );
            #/
            
            return true;
        }
    }
    
    if ( isdefined( self.var_104bdc52.var_960e4dad ) && distancesquared( self.var_104bdc52.var_960e4dad, tacpoint.origin ) <= 1 )
    {
        /#
            self function_daa06c57( tacpoint, 0, "<dev string:xc8>" );
        #/
        
        return true;
    }
    
    if ( self isposinclaimedlocation( tacpoint.origin ) )
    {
        /#
            self function_daa06c57( tacpoint, 0, "<dev string:xde>" );
        #/
        
        return true;
    }
    
    traceoffset = ( 0, 0, 30 );
    tracestart = tacpoint.origin + traceoffset;
    traceend = enemy.origin + traceoffset;
    
    if ( !is_true( self.var_104bdc52.var_ae99337 ) && !sighttracepassed( tracestart, traceend, 0, enemy, self ) )
    {
        /#
            self function_daa06c57( tacpoint, 0, "<dev string:xf2>" );
        #/
        
        return true;
    }
    
    result = generatenavmeshpath( self.origin, tacpoint.origin, self );
    
    if ( !isdefined( result ) || !isdefined( result.pathpoints ) || result.pathpoints.size == 0 )
    {
        /#
            self function_daa06c57( tacpoint, 0, "<dev string:x10b>" );
        #/
        
        return true;
    }
    
    if ( isdefined( self.var_104bdc52.stopposition ) )
    {
        self.var_104bdc52.var_960e4dad = self.var_104bdc52.stopposition;
    }
    
    /#
        self function_daa06c57( tacpoint, 1, "<dev string:x11f>" );
    #/
    
    self.var_104bdc52.var_bd6cc3ff = undefined;
    self.var_104bdc52.tacpoints = undefined;
    self.var_104bdc52.stopposition = tacpoint.origin;
    toenemy = enemy.origin - tacpoint.origin;
    faceangles = vectortoangles( toenemy );
    self setgoal( tacpoint.origin, 0, self.juggernautgoalradius, self function_d94c6dc3(), faceangles );
    return true;
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 3, eflags: 0x4
// Checksum 0xb955dac1, Offset: 0x2f38
// Size: 0x6b0, Type: bool
function private function_c3d1e9bb( enemy, currentspeed, canseeenemy )
{
    var_1d1d42ba = 0;
    
    if ( !isdefined( self.var_104bdc52.var_be1be68b ) )
    {
        var_1d1d42ba = 1;
    }
    else if ( !isdefined( self.var_104bdc52.var_15576457 ) || util::time_has_passed( self.var_104bdc52.var_15576457, self.var_400176c9 ) )
    {
        if ( !self isatgoal() )
        {
            self.var_104bdc52.var_ca3a6f54 = undefined;
            self.var_104bdc52.stopping = 0;
            
            if ( distancesquared( self.var_104bdc52.var_be1be68b, enemy.origin ) > self.var_1a382d61 )
            {
                var_1d1d42ba = 1;
            }
            else if ( isdefined( self.var_104bdc52.var_15576457 ) && util::time_has_passed( self.var_104bdc52.var_15576457, self.var_e35951cc ) )
            {
                var_1d1d42ba = 1;
            }
        }
        else
        {
            self.var_104bdc52.stopping = 1;
            
            if ( !isdefined( self.var_104bdc52.var_ca3a6f54 ) )
            {
                self.var_104bdc52.var_ca3a6f54 = gettime();
            }
            
            if ( isdefined( self.var_104bdc52.var_ca3a6f54 ) && util::time_has_passed( self.var_104bdc52.var_ca3a6f54, self.var_eb130816 ) )
            {
                var_1d1d42ba = 1;
            }
            else if ( !canseeenemy && !is_true( self.var_104bdc52.var_22215135 ) )
            {
                var_1d1d42ba = 1;
            }
            else if ( isdefined( self.var_104bdc52.var_ca3a6f54 ) && util::time_has_passed( self.var_104bdc52.var_ca3a6f54, self.var_83fcb9db ) )
            {
                if ( distancesquared( enemy.origin, self.origin ) < self.var_5e31da98 )
                {
                    var_1d1d42ba = 1;
                }
                else if ( isdefined( self.var_90791fca ) )
                {
                    var_e3483df5 = self.var_90791fca.origin;
                    
                    if ( isdefined( self.var_90791fca.var_104bdc52.stopposition ) )
                    {
                        var_e3483df5 = self.var_90791fca.var_104bdc52.stopposition;
                    }
                    
                    if ( distancesquared( var_e3483df5, self.origin ) < self.var_5e31da98 )
                    {
                        var_1d1d42ba = 1;
                    }
                }
            }
        }
    }
    
    if ( var_1d1d42ba )
    {
        if ( !self function_7d6831f7( enemy ) )
        {
            return false;
        }
    }
    
    var_86d1b13c = var_1d1d42ba && !isdefined( self.var_104bdc52.stopposition );
    
    /#
        if ( getdvarint( #"hash_6683a7e64b5079ce", 0 ) )
        {
            var_86d1b13c = 1;
        }
    #/
    
    if ( var_86d1b13c )
    {
        while ( isdefined( self.var_104bdc52.tacpoints ) )
        {
            if ( !function_e2a815e9( enemy ) )
            {
                return false;
            }
        }
    }
    else if ( !function_e2a815e9( enemy ) )
    {
        return false;
    }
    
    if ( !isdefined( self.var_104bdc52.stopposition ) )
    {
        return false;
    }
    
    walkdist = self.var_53d1f3ac;
    
    if ( !canseeenemy )
    {
        walkdist = self.var_e476f092;
    }
    
    distancetotarget = distance( self.var_104bdc52.stopposition, self.origin );
    self function_e3a04b59( distancetotarget, currentspeed, walkdist );
    toenemy = enemy.origin - self.var_104bdc52.stopposition;
    faceangles = vectortoangles( toenemy );
    self setgoal( self.var_104bdc52.stopposition, 0, self.juggernautgoalradius, self function_d94c6dc3(), faceangles );
    
    /#
        if ( isdefined( self.var_104bdc52.stopposition ) && getdvarint( #"hash_66f7f4e4b4f61e99", 0 ) == 1 )
        {
            sphere( self.var_104bdc52.stopposition, 5, ( 0, 0, 1 ), 1, 0, 10, 1 );
            line( self.origin, self.var_104bdc52.stopposition, ( 0, 0, 1 ), 1, 0, 1 );
        }
        
        if ( getdvarint( #"hash_7362b665dd679b46", 0 ) == 1 )
        {
            text = "<dev string:x12a>" + canseeenemy + "<dev string:x4e>" + distance( self.origin, enemy.origin );
            print3d( self.origin + ( 0, 0, 60 ), text, ( 0, 1, 0 ) );
            record3dtext( text, self.origin + ( 0, 0, 60 ), ( 1, 1, 1 ), "<dev string:x38>", self, 1 );
        }
    #/
    
    return true;
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 0, eflags: 0x4
// Checksum 0x3fa02b56, Offset: 0x35f0
// Size: 0x7c
function private function_ff58993b()
{
    if ( isdefined( self.var_61ec1050 ) && isdefined( self.var_6d5624e1 ) && isdefined( self.var_2295e0e8 ) )
    {
        self setgoal( self.var_6d5624e1, 0, self.var_61ec1050, self.var_2295e0e8 );
        return;
    }
    
    self setgoal( self.origin, 0, 2000, 2000 );
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 1, eflags: 0x4
// Checksum 0xb3974662, Offset: 0x3678
// Size: 0x3c, Type: bool
function private function_1d556d92( entity )
{
    return !aiutility::shouldstopmoving( entity ) && btapi_locomotionbehaviorcondition( entity );
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 1, eflags: 0x4
// Checksum 0xa0c7ef13, Offset: 0x36c0
// Size: 0xc00
function private function_79851615( *entity )
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( !is_true( self.var_d3fb5ec5 ) )
    {
        self function_d4384490();
    }
    
    enemy = self.enemy;
    
    if ( isdefined( self.var_2709867b ) && isalive( self.var_2709867b ) )
    {
        enemy = self.var_2709867b;
        
        if ( !isdefined( self.var_27ee369f ) )
        {
            self.var_27ee369f = spawnstruct();
            self.var_27ee369f.shoottarget = spawn( "script_model", enemy.origin );
            self.var_27ee369f.shoottarget makesentient();
            self.var_27ee369f.shoottarget setteam( enemy.team );
            self setentitytarget( self.var_27ee369f.shoottarget );
            self.favoriteenemy = self.var_27ee369f.shoottarget;
        }
        
        self function_3fc3c5ba( enemy );
    }
    else if ( isdefined( self.var_27ee369f ) )
    {
        self.favoriteenemy = undefined;
        self clearentitytarget();
        self.var_27ee369f.shoottarget delete();
        self.var_27ee369f = undefined;
    }
    
    var_ac2db49a = isdefined( self.var_104bdc52 );
    shouldmove = self function_f5711280( enemy );
    currentvelocity = self getvelocity();
    currentspeed = length( currentvelocity );
    
    if ( !shouldmove )
    {
        if ( isdefined( self.var_104bdc52 ) )
        {
            self.var_104bdc52 = undefined;
            self.forcefire = 0;
            self.perfectaim = 0;
            function_ff58993b();
        }
    }
    else
    {
        if ( !isdefined( self.var_104bdc52 ) )
        {
            self.var_104bdc52 = spawnstruct();
            self.var_104bdc52.nextupdatetime = 0;
            self.var_104bdc52.runcooldown = 0;
            self.var_104bdc52.currentmovespeed = 0;
            self.var_104bdc52.targetmovespeed = self.var_104bdc52.currentmovespeed;
            
            if ( currentspeed == 0 )
            {
                self.var_104bdc52.stopping = 1;
                self.var_104bdc52.stopposition = self.origin;
            }
        }
        
        self.var_104bdc52.enemy = enemy;
        
        if ( isdefined( self.var_dc3a7edb ) && self.var_dc3a7edb >= gettime() )
        {
            self.forcefire = 1;
            self.perfectaim = 1;
        }
        else
        {
            self.forcefire = 0;
            self.perfectaim = 0;
        }
        
        canseeenemy = self function_250ee533( enemy );
        
        if ( isdefined( self.juggernautlastmeleetime ) && gettime() - self.juggernautlastmeleetime < 500 )
        {
            self setgoal( self.origin, 0, self.juggernautgoalradius, 128 );
            return 1;
        }
        
        if ( isdefined( self.grenade ) )
        {
            if ( util::time_has_passed( self.grenade.birthtime, 1.5 ) && distance( self.grenade.origin, self.origin ) < self.grenade.weapon.explosionradius * 1.4 )
            {
                self.var_d5688d21 = self.grenade.origin + vectornormalize( self.origin - self.grenade.origin ) * self.grenade.weapon.explosionradius * 1.2;
                self.var_d5688d21 = getclosestpointonnavmesh( self.var_d5688d21, 64, 25 );
            }
        }
        else
        {
            self.var_d5688d21 = undefined;
        }
        
        if ( isdefined( self.var_d5688d21 ) )
        {
            self.var_104bdc52.targetmovespeed = 170;
            self.var_104bdc52.running = 1;
            self.var_104bdc52.rundelay = undefined;
            self.var_104bdc52.runcooldown = gettime() + self.var_64d9b494;
            self setgoal( self.var_d5688d21, 0, self.juggernautgoalradius, 128 );
        }
        else if ( isdefined( self.var_6d5624e1 ) && isdefined( self.var_61ec1050 ) && self.var_61ec1050 <= 100 )
        {
            toenemy = enemy.origin - self.var_6d5624e1;
            faceangles = vectortoangles( toenemy );
            self setgoal( self.var_6d5624e1, 0, self.var_61ec1050, self function_d94c6dc3(), faceangles );
            distancetotarget = distance( self.var_6d5624e1, self.origin );
            self function_e3a04b59( distancetotarget, currentspeed, self.juggernautwalkdist );
        }
        else
        {
            if ( isdefined( self.var_9c584383 ) && util::time_has_passed( self.var_9c584383, self.var_331669d0 ) && self isatgoal() )
            {
                self.var_c3d1e9bb = 1;
            }
            
            if ( isdefined( self.var_29aecd37 ) && self.var_29aecd37 > gettime() )
            {
                self function_420d19e0( enemy, currentspeed, canseeenemy );
            }
            else if ( !is_true( self.var_c3d1e9bb ) || !self function_c3d1e9bb( enemy, currentspeed, canseeenemy ) )
            {
                self function_420d19e0( enemy, currentspeed, canseeenemy );
                
                if ( isdefined( self.var_c3d1e9bb ) )
                {
                    self.var_c3d1e9bb = undefined;
                    self.var_9c584383 = gettime();
                }
            }
        }
        
        diff = self.var_104bdc52.targetmovespeed - self.var_104bdc52.currentmovespeed;
        
        if ( diff < 0 || currentspeed > 0 )
        {
            assert( isdefined( self.juggernautacceleration ) && self.juggernautacceleration > 0 );
            acceleration = self.juggernautacceleration * float( function_60d95f53() ) / 1000;
            
            if ( diff < acceleration * -1 )
            {
                diff = acceleration * -1;
            }
            else if ( diff > acceleration )
            {
                diff = acceleration;
            }
            
            self.var_104bdc52.currentmovespeed += diff;
        }
        
        if ( self.var_104bdc52.currentmovespeed > 113 )
        {
            self ai::set_behavior_attribute( "demeanor", "combat" );
        }
        else
        {
            self ai::set_behavior_attribute( "demeanor", "cqb" );
        }
        
        self.var_104bdc52.currentmovespeed = max( self.var_104bdc52.currentmovespeed, 20 );
        self setdesiredspeed( self.var_104bdc52.currentmovespeed );
        
        if ( is_true( self.var_104bdc52.stopping ) )
        {
            self.script_accuracy = self.var_d87cb1ab;
        }
        else
        {
            self.script_accuracy = self.var_bad61c0;
        }
        
        /#
            if ( getdvarint( #"hash_7362b665dd679b46", 0 ) == 1 )
            {
                movetext = "<dev string:x141>";
                
                if ( is_true( self.var_104bdc52.backup ) )
                {
                    movetext = "<dev string:x14c>";
                }
                else if ( is_true( self.var_104bdc52.stopping ) )
                {
                    movetext = "<dev string:x156>";
                }
                else if ( is_true( self.var_104bdc52.running ) )
                {
                    movetext = "<dev string:x162>";
                }
                
                movetext = movetext + "<dev string:x16d>" + self.var_104bdc52.currentmovespeed;
                print3d( self.origin + ( 0, 0, 100 ), movetext );
                record3dtext( movetext, self.origin + ( 0, 0, 100 ), ( 1, 1, 1 ), "<dev string:x38>", self, 1 );
            }
        #/
        
        /#
            if ( getdvarint( #"hash_66f7f4e4b4f61e99", 0 ) == 1 )
            {
                if ( isdefined( self.var_6d5624e1 ) && isdefined( self.var_61ec1050 ) )
                {
                    circle( self.var_6d5624e1, self.var_61ec1050, ( 0, 1, 0 ), 0, 1, 1 );
                    debugaxis( self.var_6d5624e1, ( 0, 0, 0 ), 16, 1, 0, 1 );
                }
            }
        #/
    }
    
    return 1;
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 1, eflags: 0x4
// Checksum 0xae72fff7, Offset: 0x42c8
// Size: 0xd4, Type: bool
function private function_7824de4c( entity )
{
    if ( is_true( self.var_afc00716 ) )
    {
        if ( isdefined( entity.attacker ) && !isplayer( entity.attacker ) )
        {
            return false;
        }
        
        if ( isdefined( entity.damagelocation ) && isinarray( array( "helmet", "head", "neck" ), entity.damagelocation ) )
        {
            return true;
        }
    }
    
    if ( entity.damageweapon.name == "hatchet" )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 1, eflags: 0x4
// Checksum 0x7d11d78b, Offset: 0x43a8
// Size: 0x64, Type: bool
function private function_d086ffd3( entity )
{
    return entity hasvalidinterrupt( "pain" ) && entity function_7824de4c( entity ) && entity archetypehuman::function_3e09cbf3( entity );
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 1, eflags: 0x4
// Checksum 0x394b02c8, Offset: 0x4418
// Size: 0x3a, Type: bool
function private function_5b111fb9( entity )
{
    if ( isdefined( entity.var_40543c03 ) )
    {
        entity.var_b22fa5be = undefined;
        entity.var_1dbd366f = 1;
        return true;
    }
    
    return false;
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 1, eflags: 0x4
// Checksum 0x394ef51d, Offset: 0x4460
// Size: 0x32
function private function_910f816c( entity )
{
    if ( isdefined( entity.var_3081e854 ) )
    {
        return entity.var_3081e854;
    }
    
    return entity.var_1fd9bbb3;
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 1, eflags: 0x4
// Checksum 0xf1d1841b, Offset: 0x44a0
// Size: 0x146, Type: bool
function private function_10f4a44d( entity )
{
    if ( is_true( entity.var_52f0b384 ) )
    {
        entity.var_52f0b384 = undefined;
        entity.var_3081e854 = entity.var_1fd9bbb3;
        return true;
    }
    
    if ( entity.damageweapon.name == "hatchet" && isinarray( array( "helmet", "head", "neck" ), entity.damagelocation ) || entity.damagemod == "MOD_GRENADE_SPLASH" || entity.damagemod == "MOD_EXPLOSIVE" || entity.damagemod == "MOD_PROJECTILE_SPLASH" )
    {
        entity.var_3081e854 = entity.var_c60594c9;
        return true;
    }
    
    if ( is_true( entity.var_b22fa5be ) )
    {
        entity.var_3081e854 = entity.var_1fd9bbb3;
        return true;
    }
    
    return false;
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 1, eflags: 0x4
// Checksum 0xc0e93067, Offset: 0x45f0
// Size: 0x44
function private function_663b2f25( entity )
{
    entity.var_b22fa5be = undefined;
    entity.var_1dbd366f = 1;
    entity dialogue::queue( "vox_rus0_casualty", undefined, 1 );
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 1, eflags: 0x4
// Checksum 0x39a6ca0f, Offset: 0x4640
// Size: 0x2e
function private function_710d93da( entity )
{
    entity.var_1dbd366f = undefined;
    entity.var_3081e854 = undefined;
    entity.var_23e5e045 = gettime();
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 0, eflags: 0x4
// Checksum 0x4a496754, Offset: 0x4678
// Size: 0xa4
function private function_f6d75c44()
{
    if ( !is_true( self.var_afc00716 ) )
    {
        if ( isdefined( self.hatmodel ) )
        {
            self detach( self.hatmodel, "" );
        }
        
        self forcepainon();
        self.var_afc00716 = 1;
        self.var_52f0b384 = 1;
        playfxontag( "maps/cp_rus_siege/fx9_juggernaut_impact_head_explosion", self, "j_neck" );
    }
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 12, eflags: 0x4
// Checksum 0x69f1ae0b, Offset: 0x4728
// Size: 0x49e
function private function_be9a301c( *einflictor, eattacker, idamage, *idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, *psoffsettime, *boneindex, *modelindex )
{
    isexplosive = ( vdir == "MOD_EXPLOSIVE" || vdir == "MOD_GRENADE_SPLASH" || vdir == "MOD_PROJECTILE_SPLASH" ) && ( !isdefined( self.var_40543c03 ) || self.var_40543c03 != "flash" );
    isheadshot = isdefined( weapon ) && isplayer( weapon ) && ( vdir === "MOD_RIFLE_BULLET" || vdir === "MOD_PISTOL_BULLET" || vdir === "MOD_HEAD_SHOT" || vdir === "MOD_IMPACT" ) && isdefined( modelindex ) && isinarray( array( "helmet", "head", "neck" ), modelindex );
    var_1ea69304 = shitloc.name == "hatchet";
    
    if ( !isheadshot )
    {
        playfx( "maps/cp_rus_siege/fx9_juggernaut_impact_body", psoffsettime, boneindex * -1 );
    }
    else if ( !is_true( self.var_afc00716 ) )
    {
        playfx( "maps/cp_rus_siege/fx9_juggernaut_impact_head", psoffsettime, boneindex * -1 );
    }
    
    if ( is_true( self.var_afc00716 ) )
    {
        if ( isheadshot )
        {
            level.var_d7e2833c = self.var_a9e18506 > 1;
            vpoint = int( vpoint * self.var_a9e18506 );
            
            if ( var_1ea69304 )
            {
                vpoint = self.health + 1;
            }
        }
    }
    else
    {
        if ( !isexplosive && vpoint > self.var_e53dfc1f )
        {
            vpoint = self.var_e53dfc1f;
        }
        
        if ( isheadshot && var_1ea69304 )
        {
            vpoint = int( max( vpoint, self.var_80b41b50 / 2 + 1 ) );
        }
        
        if ( isexplosive || isheadshot || var_1ea69304 )
        {
            if ( !isdefined( self.var_33d2ead7 ) )
            {
                self.var_33d2ead7 = 0;
            }
            
            self.var_33d2ead7 += vpoint;
            
            if ( self.var_33d2ead7 > self.var_80b41b50 || vpoint > self.health )
            {
                self function_f6d75c44();
            }
            else if ( !is_true( self.var_1dbd366f ) && ( !isdefined( self.var_23e5e045 ) || util::time_has_passed( self.var_23e5e045, self.var_537b6b78 ) ) )
            {
                if ( !( isdefined( self.var_26cb85ef ) && isdefined( self.var_85c754 ) ) || util::time_has_passed( self.var_26cb85ef, 1 ) )
                {
                    self.var_85c754 = 0;
                }
                
                self.var_26cb85ef = gettime();
                self.var_85c754 += vpoint;
                
                if ( self.var_85c754 > self.var_f9175e43 )
                {
                    self forcepainon();
                    self.var_b22fa5be = 1;
                }
            }
        }
    }
    
    return vpoint;
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 1, eflags: 0x4
// Checksum 0x1bc714f6, Offset: 0x4bd0
// Size: 0x36
function private function_defc3831( *ratio )
{
    if ( is_true( self.var_1dbd366f ) )
    {
        return "heavy";
    }
    
    return "light";
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 0, eflags: 0x4
// Checksum 0x72e99bc1, Offset: 0x4c10
// Size: 0x2a
function private function_6ca9ecd8()
{
    if ( is_true( self.var_1dbd366f ) )
    {
        return "head";
    }
    
    return undefined;
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 0, eflags: 0x4
// Checksum 0x936072e5, Offset: 0x4c48
// Size: 0x24, Type: bool
function private function_27cfa452()
{
    return self.grenadeweapon.name == #"hash_34fa23e332e34886";
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 1, eflags: 0x4
// Checksum 0x42648a62, Offset: 0x4c78
// Size: 0x780, Type: bool
function private function_23828655( entity )
{
    if ( !self aiutility::function_e0454a8b( entity ) )
    {
        return false;
    }
    
    if ( is_true( level.aidisablegrenadethrows ) )
    {
        return false;
    }
    
    if ( !isdefined( entity.enemy ) )
    {
        return false;
    }
    
    if ( !issentient( entity.enemy ) )
    {
        return false;
    }
    
    if ( !isplayer( entity.enemy ) && ( !isdefined( self.var_27ee369f.shoottarget ) || self.var_27ee369f.shoottarget != entity.enemy ) )
    {
        return false;
    }
    
    if ( isvehicle( entity.enemy ) && isairborne( entity.enemy ) )
    {
        return false;
    }
    
    if ( !util::time_has_passed( self.var_d53c164a, 10 ) )
    {
        return false;
    }
    
    if ( isdefined( self.var_c12e0cea ) && !util::time_has_passed( self.var_c12e0cea, 1 ) )
    {
        return false;
    }
    
    if ( is_true( self.var_419d64f3 ) )
    {
        return false;
    }
    
    if ( !isdefined( entity.grenadeammo ) || entity.grenadeammo <= 0 )
    {
        entity.grenadeammo = 10;
    }
    
    if ( ai::hasaiattribute( entity, "useGrenades" ) && !ai::getaiattribute( entity, "useGrenades" ) )
    {
        return false;
    }
    
    grenadethrowinfos = blackboard::getblackboardevents( "juggernaut_grenade_throw" );
    
    if ( isdefined( grenadethrowinfos ) && grenadethrowinfos.size > 0 )
    {
        return false;
    }
    
    entityangles = entity.angles;
    toenemy = entity.enemy.origin - entity.origin;
    toenemy = vectornormalize( ( toenemy[ 0 ], toenemy[ 1 ], 0 ) );
    entityforward = anglestoforward( entityangles );
    entityforward = vectornormalize( ( entityforward[ 0 ], entityforward[ 1 ], 0 ) );
    
    if ( vectordot( toenemy, entityforward ) < 0.5 )
    {
        return false;
    }
    
    allplayers = getplayers();
    
    if ( isdefined( allplayers ) && allplayers.size )
    {
        foreach ( player in allplayers )
        {
            if ( isdefined( player ) && player laststand::player_is_in_laststand() && distancesquared( entity.enemy.origin, player.origin ) <= 640000 )
            {
                return false;
            }
        }
    }
    
    throw_pos = entity lastknownpos( entity.enemy );
    throw_dist = distance2dsquared( entity.origin, throw_pos );
    var_50ef4b12 = self function_27cfa452();
    
    if ( !var_50ef4b12 )
    {
        if ( !self canshootenemy( 300 ) )
        {
            self.var_c12e0cea = gettime();
            tacpoints = tacticalquery( "juggernaut_grenade_tacquery", throw_pos, entity.origin );
            
            if ( isdefined( tacpoints ) && tacpoints.size > 0 )
            {
                throw_pos = tacpoints[ 0 ].origin;
                throw_dist = distance2dsquared( entity.origin, throw_pos );
            }
            else
            {
                return false;
            }
        }
    }
    else
    {
        trace_pos = self.origin + anglestoforward( self.angles ) * 100;
        result = bullettrace( trace_pos + ( 0, 0, 50 ), trace_pos + ( 0, 0, -300 ), 0, self );
        
        if ( !is_true( result[ #"startsolid" ] ) && result[ #"fraction" ] < 1 )
        {
            throw_pos = result[ #"position" ];
        }
        else
        {
            return false;
        }
    }
    
    if ( var_50ef4b12 )
    {
        if ( throw_dist < sqr( 250 ) || throw_dist > sqr( 1250 ) )
        {
            return false;
        }
    }
    else if ( throw_dist < sqr( 300 ) || throw_dist > sqr( 1250 ) )
    {
        return false;
    }
    
    arm_offset = archetype_human_cover::temp_get_arm_offset( entity, throw_pos );
    entity.var_38754eac = throw_pos;
    throw_vel = entity canthrowgrenadepos( arm_offset, throw_pos );
    
    if ( !isdefined( throw_vel ) )
    {
        entity.var_38754eac = undefined;
        return false;
    }
    
    grenadethrowinfo = spawnstruct();
    grenadethrowinfo.grenadethrower = entity;
    grenadethrowinfo.grenadethrowerteam = entity.team;
    grenadethrowinfo.grenadethrownat = entity.enemy;
    grenadethrowinfo.grenadethrownposition = entity.var_38754eac;
    blackboard::addblackboardevent( "juggernaut_grenade_throw", grenadethrowinfo, 2000 );
    return true;
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 1, eflags: 0x4
// Checksum 0xa63b1f02, Offset: 0x5400
// Size: 0x146
function private function_7e8e056c( entity )
{
    aiutility::keepclaimednodeandchoosecoverdirection( entity );
    entity.grenadethrowposition = entity.var_38754eac;
    grenadethrowinfo = spawnstruct();
    grenadethrowinfo.grenadethrower = entity;
    grenadethrowinfo.grenadethrowerteam = entity.team;
    grenadethrowinfo.grenadethrownat = entity.enemy;
    grenadethrowinfo.grenadethrownposition = entity.grenadethrowposition;
    blackboard::addblackboardevent( "juggernaut_grenade_throw", grenadethrowinfo, randomintrange( 20000, 25000 ) );
    blackboard::addblackboardevent( "team_grenade_throw", grenadethrowinfo, randomintrange( 5000, 10000 ) );
    blackboard::addblackboardevent( "target_grenade_throw", grenadethrowinfo, randomintrange( 30000, 60000 ) );
    entity.preparegrenadeammo = entity.grenadeammo;
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 1, eflags: 0x4
// Checksum 0xe64f42f6, Offset: 0x5550
// Size: 0x27a
function private function_5364406f( entity )
{
    aiutility::resetcoverparameters( entity );
    aiutility::releaseclaimnode( entity );
    
    if ( entity.preparegrenadeammo == entity.grenadeammo )
    {
        if ( entity.health <= 0 )
        {
            grenade = undefined;
            
            if ( isactor( entity.enemy ) && isdefined( entity.grenadeweapon ) )
            {
                grenade = entity.enemy magicgrenadetype( entity.grenadeweapon, entity gettagorigin( "j_wrist_ri" ), ( 0, 0, 0 ), float( entity.grenadeweapon.aifusetime ) / 1000 );
            }
            else if ( isplayer( entity.enemy ) && isdefined( entity.grenadeweapon ) )
            {
                grenade = entity.enemy magicgrenadeplayer( entity.grenadeweapon, entity gettagorigin( "j_wrist_ri" ), ( 0, 0, 0 ) );
            }
            
            if ( isdefined( grenade ) )
            {
                grenade.owner = entity;
                grenade.team = entity.team;
                grenade setcontents( grenade setcontents( 0 ) & ~( 32768 | 16777216 | 2097152 | 8388608 ) );
            }
        }
    }
    
    if ( self function_27cfa452() && entity.health > 0 )
    {
        self.var_47a7add4 = entity smokegrenade::function_f199623f( self.grenadeweapon );
        self.var_df0989d = entity smokegrenade::function_79d42bea( self.grenadeweapon );
        self.var_104bdc52.var_be1be68b = undefined;
    }
}

// Namespace namespace_631d466b/namespace_54e681de
// Params 1, eflags: 0x4
// Checksum 0x9df01ca, Offset: 0x57d8
// Size: 0x33c
function private function_3fc3c5ba( enemy )
{
    var_18779b5c = 0.3;
    
    /#
        var_18779b5c = getdvarfloat( #"hash_2bfc95c2e9325ec9", 0.3 );
    #/
    
    if ( !isdefined( self.var_27ee369f.var_f8f51306 ) || length( self.var_27ee369f.var_f8f51306 - enemy.origin ) != 0 )
    {
        if ( issentient( enemy ) )
        {
            self.var_27ee369f.var_f8f51306 = enemy geteye() - ( 0, 0, 10 );
        }
        else
        {
            self.var_27ee369f.var_f8f51306 = enemy.origin;
        }
        
        self.var_27ee369f.var_126c242e = 0;
    }
    
    self.var_27ee369f.var_126c242e += float( function_60d95f53() ) / 1000;
    
    if ( self.var_27ee369f.var_126c242e < var_18779b5c )
    {
        time = self.var_27ee369f.var_126c242e / var_18779b5c;
        self.var_27ee369f.shoottarget.origin = lerpvector( self.var_27ee369f.shoottarget.origin, self.var_27ee369f.var_f8f51306, time );
    }
    else
    {
        self.var_27ee369f.shoottarget.origin = self.var_27ee369f.var_f8f51306;
        self.var_27ee369f.var_126c242e = var_18779b5c;
    }
    
    /#
        if ( getdvarint( #"hash_747737fad8f899cb", 0 ) == 1 )
        {
            recordsphere( self.var_27ee369f.shoottarget.origin, 5, ( 1, 0, 0 ), "<dev string:x38>", self );
            recordline( self.var_27ee369f.shoottarget.origin, self.origin, ( 1, 0, 0 ), "<dev string:x38>", self );
            recordsphere( enemy.origin, 4, ( 0, 0, 1 ), "<dev string:x38>", self );
            recordline( enemy.origin, self.origin, ( 0, 0, 1 ), "<dev string:x38>", self );
        }
    #/
}

