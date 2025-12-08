#using script_1510b5c03c279e8f;
#using script_15ddefec0f2c1a92;
#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ce46999727f2f2b;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_2c5daa95f8fec03c;
#using script_2c7754f0e88c7dd4;
#using script_307a2be76314653b;
#using script_3faf478d5b0850fe;
#using script_40eb62810357ba9b;
#using script_40f967ad5d18ea74;
#using script_44dc341d87a68571;
#using script_46777b16a6ea6667;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_5133d88c555e460;
#using script_5701633066d199f2;
#using script_5e8f7ecf981ad9a3;
#using script_5f20d3b434d24884;
#using script_6281e493de3ff80b;
#using script_6dce1fe6a7dd35c7;
#using script_71971f45043d4dfe;
#using script_736b4607e813f2e5;
#using script_74a56359b7d02ab6;
#using script_761ab8de8f97d130;
#using script_774302f762d76254;
#using script_7857e1ad7dfdbc95;
#using script_79cafc73107dd980;
#using script_7a9e25472d14a1ff;
#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\ai\archetype_locomotion_utility;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\ai_blackboard;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\animation_state_machine_mocomp;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\throttle_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;

#namespace namespace_250e9486;

// Namespace namespace_250e9486/namespace_250e9486
// Params 0
// Checksum 0x9d5ef9b8, Offset: 0x528
// Size: 0x374
function init()
{
    clientfield::register( "actor", "enable_on_radar", 1, 1, "int" );
    clientfield::register( "vehicle", "enable_on_radar", 1, 1, "int" );
    level.callbackactordamage = &function_dab7edc;
    level.callbackactorkilled = &function_9b31d191;
    level.callbackvehicledamage = &function_c36e5cab;
    level.callbackvehiclekilled = &function_5800e038;
    val::register( "allowoffnavmesh", 1 );
    val::default_value( "allowoffnavmesh", 1 );
    namespace_81522b3c::init();
    namespace_df4fbf0::init();
    namespace_f6712ec9::init();
    namespace_be2ae534::init();
    namespace_a204c0f4::init();
    namespace_a0fa2b5::init();
    namespace_d1abdcb5::init();
    namespace_58e19d6::init();
    namespace_6479037a::init();
    namespace_b5ca279a::init();
    namespace_2a445563::init();
    namespace_53a8fe5e::init();
    namespace_79e108ed::init();
    namespace_146875e::init();
    namespace_8c89a9e9::init();
    namespace_6e561646::init();
    namespace_7457b8d5::init();
    level.var_deb2145c = &function_52fd55a;
    registerbehaviorscriptfunctions();
    
    if ( !isdefined( level.var_7d6449a0 ) )
    {
        level.var_7d6449a0 = new throttle();
        level.var_48894e85 = new throttle();
        level.var_79a3ec93 = new throttle();
        [[ level.var_7d6449a0 ]]->initialize( 12, float( function_60d95f53() ) / 1000 );
        [[ level.var_48894e85 ]]->initialize( 8, float( function_60d95f53() ) / 1000 );
        [[ level.var_79a3ec93 ]]->initialize( 4, float( function_60d95f53() ) / 1000 );
    }
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 0
// Checksum 0x2ec0cac, Offset: 0x8a8
// Size: 0xf64
function registerbehaviorscriptfunctions()
{
    assert( isscriptfunctionptr( &function_33f06519 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_459fdfeaf87cae96", &function_33f06519 );
    assert( isscriptfunctionptr( &function_dbce9550 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_2aebaa8271a615b", &function_dbce9550 );
    assert( isscriptfunctionptr( &function_b87b3fef ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"doawaskilledbytesla", &function_b87b3fef );
    assert( isscriptfunctionptr( &function_e90927b7 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_2e09996956de0a27", &function_e90927b7 );
    assert( !isdefined( &function_1f0241e ) || isscriptfunctionptr( &function_1f0241e ) );
    assert( !isdefined( undefined ) || isscriptfunctionptr( undefined ) );
    assert( !isdefined( undefined ) || isscriptfunctionptr( undefined ) );
    behaviortreenetworkutility::registerbehaviortreeaction( #"hash_1a0fd593ee4f4d13", &function_1f0241e, undefined, undefined );
    assert( !isdefined( undefined ) || isscriptfunctionptr( undefined ) );
    assert( !isdefined( undefined ) || isscriptfunctionptr( undefined ) );
    assert( !isdefined( undefined ) || isscriptfunctionptr( undefined ) );
    behaviortreenetworkutility::registerbehaviortreeaction( #"hash_73a2a53598a6f94c", undefined, undefined, undefined );
    assert( !isdefined( undefined ) || isscriptfunctionptr( undefined ) );
    assert( !isdefined( undefined ) || isscriptfunctionptr( undefined ) );
    assert( !isdefined( undefined ) || isscriptfunctionptr( undefined ) );
    behaviortreenetworkutility::registerbehaviortreeaction( #"hash_3793e8ada1f18447", undefined, undefined, undefined );
    assert( !isdefined( &function_1f0241e ) || isscriptfunctionptr( &function_1f0241e ) );
    assert( !isdefined( undefined ) || isscriptfunctionptr( undefined ) );
    assert( !isdefined( undefined ) || isscriptfunctionptr( undefined ) );
    behaviortreenetworkutility::registerbehaviortreeaction( #"hash_2e49b8797978f93e", &function_1f0241e, undefined, undefined );
    assert( !isdefined( undefined ) || isscriptfunctionptr( undefined ) );
    assert( !isdefined( undefined ) || isscriptfunctionptr( undefined ) );
    assert( !isdefined( undefined ) || isscriptfunctionptr( undefined ) );
    behaviortreenetworkutility::registerbehaviortreeaction( #"hash_16f749aefbd4ce23", undefined, undefined, undefined );
    assert( !isdefined( undefined ) || isscriptfunctionptr( undefined ) );
    assert( !isdefined( undefined ) || isscriptfunctionptr( undefined ) );
    assert( !isdefined( undefined ) || isscriptfunctionptr( undefined ) );
    behaviortreenetworkutility::registerbehaviortreeaction( #"zombieidleaction", undefined, undefined, undefined );
    assert( !isdefined( &zombietraverseaction ) || isscriptfunctionptr( &zombietraverseaction ) );
    assert( !isdefined( undefined ) || isscriptfunctionptr( undefined ) );
    assert( !isdefined( &zombietraverseactionterminate ) || isscriptfunctionptr( &zombietraverseactionterminate ) );
    behaviortreenetworkutility::registerbehaviortreeaction( #"zombietraverseaction", &zombietraverseaction, undefined, &zombietraverseactionterminate );
    assert( isscriptfunctionptr( &function_abb6c18a ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_70f5a4ae6dc526d3", &function_abb6c18a );
    assert( isscriptfunctionptr( &function_e5fc1f3c ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_18eef53c3b7c9c68", &function_e5fc1f3c );
    assert( isscriptfunctionptr( &function_99ed5179 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_5ceb7142be5709e8", &function_99ed5179 );
    assert( isscriptfunctionptr( &function_50547dae ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_6c4bbcf0db9f4832", &function_50547dae );
    assert( isscriptfunctionptr( &zombieshouldknockdown ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"zombieshouldknockdown", &zombieshouldknockdown );
    assert( isscriptfunctionptr( &zombieknockdownactionstart ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"zombieknockdownactionstart", &zombieknockdownactionstart );
    assert( isscriptfunctionptr( &function_c8939973 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_a6273a84b4237ce", &function_c8939973 );
    assert( isscriptfunctionptr( &zombiegetupactionterminate ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"zombiegetupactionterminate", &zombiegetupactionterminate );
    assert( isscriptfunctionptr( &shouldstun ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"zombieshouldstun", &shouldstun );
    assert( isscriptfunctionptr( &shouldstun ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_ed5637600484f3c", &shouldstun );
    assert( !isdefined( &function_645230f8 ) || isscriptfunctionptr( &function_645230f8 ) );
    assert( !isdefined( &function_83a9ca0f ) || isscriptfunctionptr( &function_83a9ca0f ) );
    assert( !isdefined( &function_4bc5ddbb ) || isscriptfunctionptr( &function_4bc5ddbb ) );
    behaviortreenetworkutility::registerbehaviortreeaction( #"stunaction", &function_645230f8, &function_83a9ca0f, &function_4bc5ddbb );
    assert( isscriptfunctionptr( &stunstart ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_6f551ce50701a441", &stunstart );
    assert( !isdefined( undefined ) || isscriptfunctionptr( undefined ) );
    assert( !isdefined( &function_83a9ca0f ) || isscriptfunctionptr( &function_83a9ca0f ) );
    assert( !isdefined( undefined ) || isscriptfunctionptr( undefined ) );
    behaviortreenetworkutility::registerbehaviortreeaction( #"hash_5ab8d15ff77f1b6f", undefined, &function_83a9ca0f, undefined );
    assert( isscriptfunctionptr( &function_de68bf47 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_e568b63ec039220", &function_de68bf47 );
    assert( isscriptfunctionptr( &function_e2da0652 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_2363b19a9d5f0aa8", &function_e2da0652 );
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 0
// Checksum 0x80f724d1, Offset: 0x1818
// Size: 0x4
function function_52fd55a()
{
    
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 0
// Checksum 0xd62fd872, Offset: 0x1828
// Size: 0x88
function function_17d3b57()
{
    curcount = namespace_ec06fe4a::function_38de0ce8();
    
    if ( isdefined( level.doa.var_39e3fa99 ) && namespace_4dae815d::function_59a9cf1d() == 0 )
    {
        available = [[ level.doa.var_39e3fa99 ]]->function_c892290a() - curcount;
        return available;
    }
    
    return 40 - curcount;
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 0
// Checksum 0x627a655a, Offset: 0x18b8
// Size: 0x8a, Type: bool
function function_60f6a9e()
{
    curcount = namespace_ec06fe4a::function_38de0ce8();
    
    if ( isdefined( level.doa.var_39e3fa99 ) && namespace_4dae815d::function_59a9cf1d() == 0 )
    {
        if ( curcount >= [[ level.doa.var_39e3fa99 ]]->function_c892290a() )
        {
            return false;
        }
    }
    
    if ( curcount >= 40 )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 5
// Checksum 0x7eacbe99, Offset: 0x1950
// Size: 0x100
function function_252dff4d( name, var_d240d5de, var_41157a40, var_c8ceaddf = undefined, chance = 100 )
{
    if ( !isdefined( level.doa.var_3a73503f ) )
    {
        level.doa.var_3a73503f = [];
    }
    
    struct = spawnstruct();
    struct.name = name;
    struct.var_d240d5de = var_d240d5de;
    struct.var_41157a40 = var_41157a40;
    struct.var_c8ceaddf = var_c8ceaddf;
    struct.spawnchance = chance;
    struct.var_71e54e3a = [];
    level.doa.var_3a73503f[ level.doa.var_3a73503f.size ] = struct;
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 1
// Checksum 0x39317ff6, Offset: 0x1a58
// Size: 0xa4
function function_2c6dd74c( spawner )
{
    foreach ( reg in level.doa.var_3a73503f )
    {
        if ( reg.name === spawner.script_noteworthy )
        {
            return reg;
        }
    }
    
    return undefined;
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 1
// Checksum 0x6e43ad37, Offset: 0x1b08
// Size: 0xa0
function function_3dd94c25( name )
{
    foreach ( reg in level.doa.var_3a73503f )
    {
        if ( reg.name === name )
        {
            return reg;
        }
    }
    
    return undefined;
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 3
// Checksum 0xc0d50aee, Offset: 0x1bb0
// Size: 0x3ec
function function_25b2c8a9( *spawner, *str_targetname, *force_spawn )
{
    self function_166a9ab7();
    self clientfield::set( "enable_on_radar", 1 );
    self callback::function_d8abfc3d( #"on_ai_melee", &function_448dac71 );
    self callback::function_d8abfc3d( #"on_ai_killed", &function_21ef174b );
    self.doa = spawnstruct();
    self.doa.stunned = 0;
    self.doa.original_origin = self.origin;
    self.ignoreall = 0;
    self.ignoreme = 0;
    self.pacifist = 0;
    self.goalradius = 42;
    self.predict_time = 0.25;
    self.var_a84a3d40 = sqr( 1300 );
    self.var_f578c3a2 = sqr( 36 );
    self.shouldspawn = 1;
    self.var_c0bd8c06 = 0;
    self.var_f6b9e96d = 0;
    self.missinglegs = 0;
    self.var_f9d01c76 = 0;
    self.var_4bd563dd = 0;
    self.var_f95bc76f = 0;
    self.meleedistsq = 2304;
    self.updatesight = 0;
    self.var_1b2af7dc = 1;
    self.entnum = self getentitynumber();
    self.var_f7f65924 = is_true( self.var_d55f22cb ) ? 5 : 10;
    self.zombie_move_speed = isdefined( level.doa.var_13e8f9c9 ) ? level.doa.var_13e8f9c9 : "walk";
    self.var_72283e28 = 0;
    self.health = level.doa.zombie_health;
    self.maxhealth = level.doa.zombie_health;
    self.lastposition = self.origin;
    self.var_2a85c480 = 0;
    self.startposition = self.origin;
    self.zombie_type = isdefined( self.spawndef ) ? [[ self.spawndef ]]->getname() : "unknown AI";
    
    if ( isactor( self ) )
    {
        self pathmode( "move allowed" );
        self setavoidancemask( "avoid actor" );
        self collidewithactors( 0 );
        self thread updatespeed();
    }
    
    self thread function_9ee1ee56();
    self thread namespace_9fc66ac::play_ambient_zombie_vocals();
    self thread function_60c093e1();
    self thread function_fc77d638();
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 0
// Checksum 0x382181b5, Offset: 0x1fa8
// Size: 0x54
function function_fc77d638()
{
    self endon( #"death" );
    
    while ( is_true( self.var_1f2d0447 ) )
    {
        wait 1;
    }
    
    self enableaimassist();
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 0
// Checksum 0xf2aa60a, Offset: 0x2008
// Size: 0x94
function function_60c093e1()
{
    self endon( #"death" );
    var_8d747a1 = 1;
    
    while ( var_8d747a1 )
    {
        var_8d747a1 = !( level flag::get( "doa_players_all_dead" ) || level flag::get( "doa_game_is_over" ) );
        wait 1;
    }
    
    self thread namespace_ec06fe4a::function_570729f0( 0 );
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 0
// Checksum 0x4341a1c, Offset: 0x20a8
// Size: 0x6a
function function_166a9ab7()
{
    self.__blackboard = undefined;
    blackboard::createblackboardforentity( self );
    ai::createinterfaceforentity( self );
    self.___archetypeonanimscriptedcallback = &function_deb871fd;
    self.___archetypeonbehavecallback = &function_c61d79a9;
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 1, eflags: 0x4
// Checksum 0x54830c02, Offset: 0x2120
// Size: 0xc
function private function_c61d79a9( *entity )
{
    
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 1, eflags: 0x4
// Checksum 0x7a42d5d2, Offset: 0x2138
// Size: 0x2c
function private function_deb871fd( *entity )
{
    self.__blackboard = undefined;
    self function_166a9ab7();
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 0
// Checksum 0xb92db474, Offset: 0x2170
// Size: 0x21c
function function_c1f37cab()
{
    if ( is_true( self.boss ) )
    {
        return;
    }
    
    if ( is_true( self.var_76cb41b3 ) )
    {
        return;
    }
    
    if ( isdefined( self.var_28313669 ) )
    {
        return;
    }
    
    if ( gettime() < self.var_f9d01c76 )
    {
        return;
    }
    
    self.var_f9d01c76 = gettime() + 1000;
    dist = distancesquared( self.lastposition, self.origin );
    self.lastposition = self.origin;
    
    if ( dist < sqr( 12 ) )
    {
        self.var_4bd563dd++;
    }
    else
    {
        self.var_4bd563dd = 0;
    }
    
    if ( isdefined( self.var_c8b974fe ) )
    {
        distsq = distancesquared( self.origin, self.var_c8b974fe );
        
        if ( distsq > self.var_32d07c96 )
        {
            distsq = distancesquared( self.origin, self.goalpos );
            
            if ( distsq < sqr( 512 ) )
            {
                self.var_4bd563dd++;
            }
            else
            {
                self.var_4bd563dd = self.var_f7f65924;
            }
        }
    }
    
    if ( self.var_4bd563dd >= self.var_f7f65924 )
    {
        if ( isdefined( self.var_5603780 ) )
        {
            self doa_enemy::function_c89f6305();
            [[ self.var_5603780 ]]();
            return;
        }
        
        self.var_c0bd8c06 = 1;
        self.var_28313669 = gettime();
        self thread namespace_ec06fe4a::deletemeonnotify( #"hash_12b1eb419a23e3bd" );
        self thread namespace_ec06fe4a::function_570729f0( 10 );
    }
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 1
// Checksum 0x92488a27, Offset: 0x2398
// Size: 0x8c
function function_8f172270( *target )
{
    if ( is_true( self.var_1f2d0447 ) )
    {
        return;
    }
    
    if ( self isatgoal() == 0 )
    {
        function_c1f37cab();
    }
    
    self.lastknownenemypos = self function_bd5a9fa6();
    self function_41354e51( self.lastknownenemypos );
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 0
// Checksum 0x96270f25, Offset: 0x2430
// Size: 0x228
function function_9ee1ee56()
{
    self endon( #"death" );
    
    if ( !isdefined( self.arena ) )
    {
        return;
    }
    
    center = [[ self.arena ]]->function_ffcf1d1();
    minz = center[ 2 ] - 1000;
    
    while ( true )
    {
        if ( self.arena !== level.doa.var_39e3fa99 )
        {
            namespace_1e25ad94::debugmsg( "Enemy " + self.aitype + " at (" + self.origin + ") was killed for not being in the active arena!", 1 );
            self thread namespace_ec06fe4a::function_570729f0( 0.5 );
            return;
        }
        
        if ( self.origin[ 2 ] < minz )
        {
            namespace_1e25ad94::debugmsg( "Enemy " + self.aitype + " at (" + self.origin + ") was killed for being beneath the minZ value!", 1 );
            self thread namespace_ec06fe4a::function_570729f0( 0.5 );
            return;
        }
        
        distsq = distancesquared( center, self.origin );
        
        if ( distsq > sqr( 2048 ) )
        {
            namespace_1e25ad94::debugmsg( "Enemy " + self.aitype + " at (" + self.origin + ") was killed for being to far from center (" + center + ") Dist:" + distsq, 1 );
            self thread namespace_ec06fe4a::function_570729f0( 0.5 );
            return;
        }
        
        wait 1;
    }
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 0
// Checksum 0x345b9c95, Offset: 0x2660
// Size: 0x56
function function_8971bbb7()
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( self function_cf2c9af() )
        {
            function_e00f51af( self );
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 2
// Checksum 0x5fae39f7, Offset: 0x26c0
// Size: 0x4a6
function function_1bbf4511( origin, *onpath )
{
    self notify( "aef9482e7a9fcf5" );
    self endon( "aef9482e7a9fcf5" );
    
    if ( !isdefined( self.boss ) )
    {
        gamestate = namespace_4dae815d::function_59a9cf1d();
        
        if ( gamestate == 5 )
        {
            var_9b6df834 = level.var_79a3ec93;
        }
        else if ( gamestate == 4 )
        {
            var_9b6df834 = level.var_48894e85;
        }
        else if ( gamestate == 0 )
        {
            var_9b6df834 = level.var_7d6449a0;
        }
        
        if ( isdefined( var_9b6df834 ) )
        {
            if ( [[ var_9b6df834 ]]->wm_ht_posidlestart( self ) )
            {
                return;
            }
            
            self endon( #"death" );
            [[ var_9b6df834 ]]->waitinqueue( self );
        }
    }
    
    time = gettime();
    
    if ( is_true( self.basic ) && isdefined( self.enemy ) && isdefined( self.enemy.doa.closestpointonnavmesh ) )
    {
        adjustedorigin = self.enemy.doa.closestpointonnavmesh;
    }
    else
    {
        radius = self getpathfindingradius();
        adjustedorigin = getclosestpointonnavmesh( onpath, self.goalradius, radius );
        
        if ( !isdefined( adjustedorigin ) && isdefined( self.enemy ) )
        {
            adjustedorigin = self.enemy.last_valid_position;
        }
    }
    
    if ( isdefined( adjustedorigin ) )
    {
        onpath = adjustedorigin;
        self setgoal( adjustedorigin );
        self.var_c36d109 = time;
    }
    
    distsq = distancesquared( self.origin, onpath );
    frac = math::clamp( distsq / sqr( 800 ), 0, 1 );
    
    if ( isdefined( self.zombie_move_speed ) )
    {
        if ( self.zombie_move_speed == "walk" || is_true( self.missinglegs ) )
        {
            frac += 0.2;
        }
        
        if ( self.zombie_move_speed == "run" )
        {
            frac -= 0.1;
        }
        
        if ( self.zombie_move_speed == "sprint" )
        {
            frac -= 0.2;
        }
        
        if ( frac < 0 )
        {
            frac = 0;
        }
    }
    
    repathdelay = int( frac * 800 );
    
    if ( repathdelay < 50 )
    {
        repathdelay = 50;
    }
    
    if ( isdefined( self.doa.var_492aef80 ) && repathdelay > self.doa.var_492aef80 )
    {
        repathdelay = self.doa.var_492aef80;
    }
    
    self.var_72283e28 = gettime() + repathdelay;
    
    if ( !self haspath() )
    {
        if ( isdefined( self.enemy ) && isdefined( self.enemy.last_valid_position ) )
        {
            self setgoal( self.enemy.last_valid_position );
            self.var_c36d109 = time;
        }
        
        self.var_f95bc76f = math::clamp( self.var_f95bc76f + 1, 0, 10 );
        self.var_72283e28 += randomintrange( 200 * self.var_f95bc76f, 500 * self.var_f95bc76f );
        return;
    }
    
    self.var_f95bc76f = 0;
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 2
// Checksum 0xb250c7d9, Offset: 0x2b70
// Size: 0x194
function function_41354e51( origin, force = 0 )
{
    if ( !isdefined( origin ) )
    {
        return;
    }
    
    if ( force || gettime() >= self.var_72283e28 || !self haspath() )
    {
        setpath = 1;
    }
    else
    {
        setpath = 0;
    }
    
    if ( !setpath )
    {
        distsq = distancesquared( origin, self.goalpos );
        var_5aad8687 = distancesquared( self.origin, self.goalpos );
        scale = max( 1, var_5aad8687 / sqr( 256 ) );
        var_2773df6d = int( self.var_f578c3a2 * scale );
        
        if ( distsq > var_2773df6d )
        {
            self.var_72283e28 -= 150;
        }
    }
    
    if ( setpath )
    {
        self thread function_1bbf4511( origin, self haspath() );
    }
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 2
// Checksum 0x2e854675, Offset: 0x2d10
// Size: 0x4e
function function_49a5cb51( origin, dist = 1024 )
{
    self.var_f86340fb = sqr( dist );
    self.anchorpos = origin;
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 0
// Checksum 0xe880d59a, Offset: 0x2d68
// Size: 0x33e
function function_4b49bf0d()
{
    if ( isdefined( self.favoriteenemy ) && is_true( self.var_4f1b8d2b ) && isalive( self.favoriteenemy ) )
    {
        return self.favoriteenemy;
    }
    
    if ( is_true( self.ignoreall ) )
    {
        self clearenemy();
        self.favoriteenemy = undefined;
        return undefined;
    }
    
    if ( self.team != #"allies" )
    {
        validtargets = arraycombine( getaiteamarray( "allies" ), namespace_7f5aeb59::function_518c4c78(), 0, 0 );
        sorted = arraysortclosest( validtargets, self.origin );
    }
    else
    {
        sorted = arraysortclosest( getaiteamarray( "axis" ), self.origin );
    }
    
    foreach ( target in sorted )
    {
        if ( is_true( target.ignoreme ) )
        {
            continue;
        }
        
        closest = target;
        break;
    }
    
    var_f65b257b = 99999999;
    
    if ( isdefined( closest ) && isdefined( self.var_a84a3d40 ) )
    {
        var_f65b257b = distancesquared( closest.origin, self.origin );
        
        if ( var_f65b257b >= self.var_a84a3d40 )
        {
            closest = undefined;
        }
    }
    
    if ( isdefined( closest ) && isdefined( self.anchorpos ) )
    {
        if ( var_f65b257b > sqr( 400 ) )
        {
            distsq = distancesquared( self.anchorpos, self.origin );
            
            if ( distsq >= self.var_f86340fb )
            {
                closest = undefined;
            }
        }
    }
    
    if ( isdefined( closest ) )
    {
        self setentitytarget( closest );
        self.favoriteenemy = closest;
    }
    else
    {
        self clearenemy();
        self.favoriteenemy = undefined;
    }
    
    return self.favoriteenemy;
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 1
// Checksum 0x91be9799, Offset: 0x30b0
// Size: 0x348
function function_e00f51af( behaviortreeentity )
{
    if ( !isdefined( behaviortreeentity.doa ) )
    {
        return;
    }
    
    if ( level flag::get( "doa_game_is_over" ) )
    {
        behaviortreeentity function_41354e51( behaviortreeentity.origin );
        return 1;
    }
    
    if ( isdefined( behaviortreeentity.var_860a34b9 ) )
    {
        behaviortreeentity clearenemy();
        behaviortreeentity function_41354e51( behaviortreeentity.var_860a34b9 );
        return 5;
    }
    
    if ( isdefined( behaviortreeentity.doa ) && behaviortreeentity.doa.stunned != 0 )
    {
        if ( !is_true( behaviortreeentity.doa.var_74e4ded8 ) )
        {
            behaviortreeentity function_41354e51( behaviortreeentity.doa.original_origin, behaviortreeentity.doa.stunned == 1 );
            behaviortreeentity.doa.stunned = 2;
        }
        else
        {
            behaviortreeentity function_41354e51( behaviortreeentity.origin );
        }
        
        return 5;
    }
    
    if ( !is_true( behaviortreeentity.var_1c8b76d3 ) )
    {
        poi = namespace_ec06fe4a::function_ff7594d7( behaviortreeentity.origin );
        
        if ( isdefined( poi ) )
        {
            behaviortreeentity.doa.poi = poi;
            
            if ( isdefined( poi.var_9eba8716 ) )
            {
                behaviortreeentity function_41354e51( poi.var_9eba8716 );
            }
            else
            {
                behaviortreeentity function_41354e51( poi.origin );
            }
            
            return 5;
        }
    }
    
    if ( isdefined( behaviortreeentity.enemy ) && behaviortreeentity.enemy.team == behaviortreeentity.team )
    {
        behaviortreeentity clearenemy();
    }
    
    time = gettime();
    
    if ( time > behaviortreeentity.var_2a85c480 )
    {
        behaviortreeentity.var_2a85c480 = time + 1500;
        behaviortreeentity clearenemy();
        behaviortreeentity.favoriteenemy = undefined;
    }
    
    if ( isdefined( behaviortreeentity.enemy ) )
    {
        if ( is_true( behaviortreeentity.enemy.laststand ) )
        {
            behaviortreeentity clearenemy();
            behaviortreeentity.favoriteenemy = undefined;
        }
    }
    
    if ( !isdefined( behaviortreeentity.enemy ) )
    {
        behaviortreeentity function_4b49bf0d();
    }
    
    function_8f172270( behaviortreeentity.enemy );
    return 5;
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 1
// Checksum 0x8aabcf5c, Offset: 0x3400
// Size: 0x62
function function_bb0817aa( curspeed )
{
    if ( curspeed == "walk" )
    {
        return "run";
    }
    else if ( curspeed == "run" )
    {
        return "sprint";
    }
    else if ( curspeed == "sprint" )
    {
        return "super_sprint";
    }
    
    return "sprint";
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 1
// Checksum 0xe2cff486, Offset: 0x3470
// Size: 0x62
function function_6caf68( curspeed )
{
    if ( curspeed == "run" )
    {
        return "walk";
    }
    else if ( curspeed == "sprint" )
    {
        return "run";
    }
    else if ( curspeed == "super_sprint" )
    {
        return "sprint";
    }
    
    return "walk";
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 0, eflags: 0x4
// Checksum 0x828b15df, Offset: 0x34e0
// Size: 0x210
function private function_16aba2a6()
{
    self endon( #"death" );
    self endon( #"hash_f7f7d6234100d72" );
    
    while ( level flag::get( "doa_round_spawning" ) )
    {
        wait 1;
    }
    
    while ( true )
    {
        wait randomfloatrange( 15, 25 );
        
        if ( self.team != #"axis" )
        {
            continue;
        }
        
        speed = self.zombie_move_speed;
        
        if ( is_true( self.var_bb68380c ) )
        {
            left = namespace_ec06fe4a::function_fb4eb048( "axis" );
            
            if ( left <= 10 && is_true( self.missinglegs ) && !is_true( self.var_c3ce559a ) )
            {
                self thread namespace_ec06fe4a::function_570729f0( randomfloatrange( 1, 5 ) );
            }
            
            self.zombie_move_speed = function_bb0817aa( self.zombie_move_speed );
        }
        
        if ( !is_true( self.var_bb68380c ) && isdefined( self.var_4bd563dd ) && self.var_4bd563dd > 2 )
        {
            self.zombie_move_speed = function_6caf68( self.zombie_move_speed );
        }
        
        if ( speed != self.zombie_move_speed )
        {
            self notify( #"speed_change" );
            wait randomint( 10 );
        }
    }
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 0
// Checksum 0x979ff267, Offset: 0x36f8
// Size: 0x196
function updatespeed()
{
    self thread function_16aba2a6();
    
    if ( isdefined( level.doa.var_13e8f9c9 ) )
    {
        self.zombie_move_speed = level.doa.var_13e8f9c9;
        return;
    }
    
    if ( is_true( level.doa.world_state == 4 ) )
    {
        self.var_9658ee9f = 1;
    }
    
    if ( isdefined( self.var_35ee5f2c ) )
    {
        self.zombie_move_speed = "crawl";
        return;
    }
    
    if ( isdefined( self.var_f00db61 ) )
    {
        self.zombie_move_speed = "walk";
        return;
    }
    
    if ( isdefined( self.var_237cb7a4 ) )
    {
        self.zombie_move_speed = "run";
        return;
    }
    
    if ( isdefined( self.var_9658ee9f ) )
    {
        self.zombie_move_speed = "sprint";
        return;
    }
    
    rand = randomintrange( level.doa.var_f4cf4e3 - 25, level.doa.var_f4cf4e3 + 20 );
    
    if ( rand <= 40 )
    {
        self.zombie_move_speed = "walk";
        return;
    }
    
    if ( rand <= 70 )
    {
        self.zombie_move_speed = "run";
        return;
    }
    
    self.zombie_move_speed = "sprint";
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 0
// Checksum 0x484cf9a2, Offset: 0x3898
// Size: 0x1b6
function function_bd5a9fa6()
{
    if ( isdefined( self.enemy ) )
    {
        if ( isdefined( self.enemy.doa ) && isdefined( self.enemy.doa.vehicle ) )
        {
            self.lastknownenemypos = self.enemy.doa.vehicle.origin;
            
            if ( !isdefined( self.lastknownenemypos ) && isdefined( self.enemy.doa.vehicle.groundpos ) )
            {
                self.lastknownenemypos = self.enemy.doa.vehicle.groundpos;
            }
            
            if ( isdefined( self.enemy.doa.var_baad518e ) )
            {
                self.lastknownenemypos = self.enemy.doa.var_baad518e;
            }
            
            return self.lastknownenemypos;
        }
        else
        {
            predict_time = isdefined( self.predict_time ) ? self.predict_time : 0.5;
            velocity = self.enemy getvelocity();
            predicted_pos = self.enemy.origin + velocity * predict_time;
            return predicted_pos;
        }
    }
    
    if ( isdefined( self.var_860a34b9 ) )
    {
        return self.var_860a34b9;
    }
    
    if ( isdefined( self.lastknownenemypos ) )
    {
        return self.lastknownenemypos;
    }
    
    return self.goalpos;
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 0
// Checksum 0x90cffb2f, Offset: 0x3a58
// Size: 0xba
function getyawtoenemy()
{
    pos = undefined;
    
    if ( isdefined( self.enemy ) )
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

// Namespace namespace_250e9486/namespace_250e9486
// Params 1
// Checksum 0x10bc1a8f, Offset: 0x3b20
// Size: 0x3e
function getyaw( org )
{
    angles = vectortoangles( org - self.origin );
    return angles[ 1 ];
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 1
// Checksum 0x3b32a0d8, Offset: 0x3b68
// Size: 0xf2, Type: bool
function function_33f06519( behaviortreeentity )
{
    if ( !isdefined( behaviortreeentity.enemy ) )
    {
        return false;
    }
    
    if ( is_true( behaviortreeentity.enemy.ignoreme ) )
    {
        return false;
    }
    
    if ( is_true( behaviortreeentity.ignoreall ) )
    {
        return false;
    }
    
    targetorigin = behaviortreeentity.enemy.origin;
    
    if ( distance2dsquared( behaviortreeentity.origin, targetorigin ) > behaviortreeentity.meleedistsq )
    {
        return false;
    }
    
    yaw = abs( getyawtoenemy() );
    
    if ( yaw > 45 )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 1
// Checksum 0xf337651f, Offset: 0x3c68
// Size: 0x2e, Type: bool
function function_b87b3fef( behaviortreeentity )
{
    if ( is_true( behaviortreeentity.tesla_death ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 1
// Checksum 0x4bc2558b, Offset: 0x3ca0
// Size: 0xf0
function function_21ef174b( s_params )
{
    self.meleeinfo = undefined;
    roll = randomint( 200 );
    
    if ( roll == 0 )
    {
        namespace_dfc652ee::function_68442ee7( self.origin, 1, 12, 1, 1 );
    }
    
    if ( isdefined( s_params.eattacker ) && isplayer( s_params.eattacker ) && !is_true( self.var_d55f22cb ) )
    {
        s_params.eattacker namespace_eccff4fb::enemykill( self.zombie_type );
        level notify( #"hash_7ca039481b460ed2" );
    }
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 0
// Checksum 0x37798cbb, Offset: 0x3d98
// Size: 0xe
function function_448dac71()
{
    self.var_4bd563dd = 0;
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 2
// Checksum 0x712b8072, Offset: 0x3db0
// Size: 0x30
function function_1f0241e( behaviortreeentity, asmstatename )
{
    animationstatenetworkutility::requeststate( behaviortreeentity, asmstatename );
    return 5;
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 0
// Checksum 0x2ffe5f77, Offset: 0x3de8
// Size: 0x40, Type: bool
function function_6aac668f()
{
    if ( is_true( self.var_e5ad72a0 ) || is_true( self.var_1f2d0447 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 0
// Checksum 0xa1df474f, Offset: 0x3e30
// Size: 0x3e, Type: bool
function function_cf2c9af()
{
    if ( is_true( self.var_834ad023 ) )
    {
        return false;
    }
    
    if ( self function_6aac668f() )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 1
// Checksum 0x44f61ba8, Offset: 0x3e78
// Size: 0x4c
function stunstart( behaviortreeentity )
{
    behaviortreeentity pathmode( "dont move", 1 );
    callback::callback( #"hash_1eda827ff5e6895b" );
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 1
// Checksum 0x726dbea3, Offset: 0x3ed0
// Size: 0x4c
function function_de68bf47( behaviortreeentity )
{
    behaviortreeentity pathmode( "move allowed" );
    callback::callback( #"hash_210adcf09e99fba1" );
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 2
// Checksum 0x6c9e8e01, Offset: 0x3f28
// Size: 0x48
function function_645230f8( behaviortreeentity, asmstatename )
{
    stunstart( behaviortreeentity );
    animationstatenetworkutility::requeststate( behaviortreeentity, asmstatename );
    return 5;
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 2
// Checksum 0x39ae4626, Offset: 0x3f78
// Size: 0x38
function function_83a9ca0f( behaviortreeentity, *asmstatename )
{
    if ( asmstatename ai::is_stunned() )
    {
        return 5;
    }
    
    return 4;
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 2
// Checksum 0x30b167a5, Offset: 0x3fb8
// Size: 0x30
function function_4bc5ddbb( behaviortreeentity, *asmstatename )
{
    function_de68bf47( asmstatename );
    return 4;
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 1
// Checksum 0xbb69610d, Offset: 0x3ff0
// Size: 0x52
function function_dbce9550( behaviortreeentity )
{
    if ( self function_6aac668f() )
    {
        return 0;
    }
    
    if ( self isatgoal() )
    {
        return 0;
    }
    
    return behaviortreeentity haspath();
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 1, eflags: 0x4
// Checksum 0xbcf8b062, Offset: 0x4050
// Size: 0x1c, Type: bool
function private function_e90927b7( entity )
{
    return entity.var_85c3882d === 1;
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 1
// Checksum 0xd6cb4241, Offset: 0x4078
// Size: 0x3c, Type: bool
function shouldstun( entity )
{
    return entity ai::is_stunned() && function_5c82fd66( entity );
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 1, eflags: 0x4
// Checksum 0xdf2833d8, Offset: 0x40c0
// Size: 0x10, Type: bool
function private function_5c82fd66( *entity )
{
    return true;
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 2
// Checksum 0x82b60896, Offset: 0x40d8
// Size: 0x88
function zombietraverseaction( behaviortreeentity, asmstatename )
{
    aiutility::traverseactionstart( behaviortreeentity, asmstatename );
    behaviortreeentity.var_9ed3cc11 = behaviortreeentity function_e827fc0e();
    behaviortreeentity pushplayer( 1 );
    behaviortreeentity callback::callback( #"hash_1518febf00439d5" );
    return 5;
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 2
// Checksum 0x89dfdb5, Offset: 0x4168
// Size: 0xf0
function zombietraverseactionterminate( behaviortreeentity, asmstatename )
{
    aiutility::wpn_debug_bot_joinleave( behaviortreeentity, asmstatename );
    
    if ( behaviortreeentity asmgetstatus() == "asm_status_complete" )
    {
        if ( !is_true( behaviortreeentity.missinglegs ) )
        {
            behaviortreeentity collidewithactors( 0 );
            behaviortreeentity.enablepushtime = gettime() + 1000;
        }
        
        if ( isdefined( behaviortreeentity.var_9ed3cc11 ) )
        {
            behaviortreeentity pushplayer( behaviortreeentity.var_9ed3cc11 );
            behaviortreeentity.var_9ed3cc11 = undefined;
        }
    }
    
    behaviortreeentity callback::callback( #"hash_34b65342cbfdadac" );
    return 4;
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 1
// Checksum 0xfa208f82, Offset: 0x4260
// Size: 0xc0
function function_abb6c18a( entity )
{
    if ( !is_true( entity.var_e5ad72a0 ) )
    {
        if ( isdefined( entity.var_d1bf288 ) )
        {
            if ( !isdefined( entity.despawntimer ) )
            {
                entity.despawntimer = gettime() + entity.var_d1bf288;
            }
        }
        
        if ( isdefined( entity.var_1038c5e0 ) )
        {
            entity namespace_83eb6304::function_3ecfde67( entity.var_1038c5e0 );
        }
        
        entity.var_c0bd8c06 = undefined;
        entity.var_e5ad72a0 = 1;
        entity pathmode( "dont move", 1 );
    }
    
    return 4;
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 1
// Checksum 0xd0fcc004, Offset: 0x4328
// Size: 0x34
function function_e5fc1f3c( entity )
{
    if ( isdefined( entity.despawntimer ) )
    {
        if ( gettime() < entity.despawntimer )
        {
            return 5;
        }
    }
    
    return 4;
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 1
// Checksum 0xf6b7ec1b, Offset: 0x4368
// Size: 0x8e
function function_99ed5179( entity )
{
    if ( isdefined( entity.var_df416181 ) )
    {
        entity namespace_83eb6304::function_3ecfde67( entity.var_df416181 );
    }
    
    entity ghost();
    entity notsolid();
    entity notify( #"hash_12b1eb419a23e3bd" );
    entity.var_e5ad72a0 = undefined;
    return 4;
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 1
// Checksum 0x747cbd1c, Offset: 0x4400
// Size: 0x22
function function_50547dae( entity )
{
    return is_true( entity.var_c0bd8c06 );
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 15
// Checksum 0x9a5d5026, Offset: 0x4430
// Size: 0x63c
function function_dab7edc( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, modelindex, surfacetype, surfacenormal )
{
    self endon( #"death" );
    
    if ( isdefined( eattacker ) && isdefined( eattacker.meleedamage ) )
    {
        idamage = eattacker.meleedamage;
    }
    
    if ( self.team == "allies" )
    {
        /#
            namespace_1e25ad94::debugmsg( "<dev string:x38>" + self.archetype + "<dev string:x4c>" + idamage );
        #/
    }
    
    if ( isdefined( self.allowdeath ) && self.allowdeath == 0 && idamage >= self.health )
    {
        idamage = self.health - 1;
    }
    
    if ( isdefined( einflictor ) && einflictor.team == self.team || isdefined( eattacker ) && eattacker.team == self.team )
    {
        self finishactordamage( einflictor, eattacker, 10, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, surfacetype, surfacenormal );
        return;
    }
    
    if ( isdefined( self.fx ) && self.health <= idamage )
    {
        self namespace_83eb6304::turnofffx( self.fx );
        self.fx = undefined;
    }
    
    if ( isdefined( weapon ) && isdefined( level.doa.var_d7e090f7[ weapon.name ] ) )
    {
        var_36ee3765 = level [[ level.doa.var_d7e090f7[ weapon.name ] ]]( self, idamage, eattacker, vdir, smeansofdeath, weapon );
        
        if ( isdefined( var_36ee3765 ) )
        {
            idamage += int( var_36ee3765 );
        }
    }
    
    if ( !is_true( self.boss ) )
    {
        self namespace_ed80aead::function_5e680689( eattacker, idamage, smeansofdeath, weapon, shitloc, vdir );
    }
    
    if ( smeansofdeath == "MOD_BURNED" )
    {
        /#
            namespace_1e25ad94::debugmsg( "<dev string:x5e>" + idamage + "<dev string:x6d>" + self.health + ( idamage < self.health ? "<dev string:x8f>" : "<dev string:x7e>" ) );
        #/
    }
    
    if ( smeansofdeath == "MOD_CRUSH" )
    {
        if ( is_true( self.boss ) )
        {
            idamage = 0;
        }
        else
        {
            idamage = self.health;
        }
    }
    
    if ( isdefined( self.overrideactordamage ) )
    {
        idamage = self [[ self.overrideactordamage ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, timeoffset, boneindex, modelindex );
    }
    else if ( isdefined( level.overrideactordamage ) )
    {
        idamage = self [[ level.overrideactordamage ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, timeoffset, boneindex, modelindex );
    }
    
    if ( isdefined( self.aioverridedamage ) )
    {
        if ( isarray( self.aioverridedamage ) )
        {
            foreach ( cb in self.aioverridedamage )
            {
                idamage = self [[ cb ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, timeoffset, boneindex, modelindex );
            }
        }
        else
        {
            idamage = self [[ self.aioverridedamage ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, timeoffset, boneindex, modelindex );
        }
    }
    
    if ( idamage >= self.health )
    {
        self zombie_eye_glow_stop();
    }
    
    if ( isdefined( eattacker ) && isdefined( eattacker.owner ) )
    {
        eattacker = eattacker.owner;
    }
    
    params = spawnstruct();
    params.einflictor = einflictor;
    params.eattacker = eattacker;
    params.idamage = idamage;
    params.idflags = idflags;
    params.smeansofdeath = smeansofdeath;
    params.weapon = weapon;
    params.vpoint = vpoint;
    params.vdir = vdir;
    params.shitloc = shitloc;
    params.vdamageorigin = vdamageorigin;
    params.psoffsettime = timeoffset;
    self.var_ce1aa55f = gettime();
    self callback::callback( #"on_ai_damage", params );
    self finishactordamage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, surfacetype, surfacenormal );
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 14
// Checksum 0x1403a605, Offset: 0x4a78
// Size: 0x3fc
function function_9b31d191( einflictor, eattacker, idamage, smeansofdeath, weapon, *vpoint, vdir, shitloc, *vdamageorigin, timeoffset, *damagefromunderneath, *modelindex, *partname, *vsurfacenormal )
{
    if ( isdefined( vdir ) )
    {
        self.damageinflictor = vdir;
    }
    
    self asmsetanimationrate( 1 );
    
    if ( self.team == "allies" )
    {
        /#
            namespace_1e25ad94::debugmsg( "<dev string:x93>" + self.archetype );
        #/
    }
    
    if ( isdefined( self.fx ) )
    {
        self namespace_83eb6304::turnofffx( self.fx );
    }
    
    if ( randomint( 100 ) < 50 )
    {
        switch ( randomint( 3 ) )
        {
            case 0:
                self namespace_83eb6304::function_3ecfde67( "headshot" );
                break;
            case 1:
                self namespace_83eb6304::function_3ecfde67( "headshot_nochunks" );
                break;
            default:
                self namespace_83eb6304::function_3ecfde67( "bloodspurt" );
                break;
        }
    }
    
    if ( is_true( self.interdimensional_gun_kill ) || isdefined( damagefromunderneath ) && is_true( damagefromunderneath.bulletimpactexplode ) )
    {
        self namespace_ed80aead::function_586ef822();
    }
    
    if ( isdefined( shitloc ) )
    {
        if ( isactor( shitloc ) && isdefined( shitloc.owner ) && isplayer( shitloc.owner ) )
        {
            shitloc = shitloc.owner;
        }
    }
    
    if ( timeoffset == "MOD_CRUSH" )
    {
        assert( !is_true( self.boss ) );
        self namespace_ed80aead::function_1f275794( undefined, shitloc );
        
        if ( isdefined( shitloc ) )
        {
            shitloc notify( #"hash_6d92185248475f65" );
        }
    }
    
    if ( timeoffset == "MOD_ELECTROCUTED" && isdefined( vdir ) )
    {
        dir = self.origin - vdir.origin;
        self thread namespace_ec06fe4a::function_5678f0d( dir );
    }
    
    params = spawnstruct();
    params.einflictor = vdir;
    params.eattacker = shitloc;
    params.idamage = vdamageorigin;
    params.smeansofdeath = timeoffset;
    params.weapon = damagefromunderneath;
    params.vdir = modelindex;
    params.shitloc = partname;
    params.psoffsettime = vsurfacenormal;
    self callback::callback( #"on_ai_killed", params );
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 15
// Checksum 0x1552d21e, Offset: 0x4e80
// Size: 0x1fc
function function_c36e5cab( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal )
{
    if ( isdefined( eattacker ) && eattacker.team == self.team )
    {
        idamage = 0;
    }
    
    if ( isdefined( self.owner ) && isplayer( self.owner ) && is_true( self.playercontrolled ) )
    {
        if ( isdefined( eattacker ) && is_true( eattacker.var_98801d44 ) )
        {
        }
        
        idamage = 0;
    }
    
    if ( isdefined( self.overridevehicledamage ) )
    {
        idamage = self [[ self.overridevehicledamage ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal );
    }
    else if ( isdefined( level.overridevehicledamage ) )
    {
        idamage = self [[ level.overridevehicledamage ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal );
    }
    
    if ( idamage == 0 )
    {
        return;
    }
    
    idamage = int( idamage );
    self finishvehicledamage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname, 0 );
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 8
// Checksum 0xe8eead8f, Offset: 0x5088
// Size: 0x14c
function function_5800e038( einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime )
{
    if ( isdefined( einflictor ) )
    {
        self.damageinflictor = einflictor;
    }
    
    params = spawnstruct();
    params.einflictor = einflictor;
    params.eattacker = eattacker;
    params.idamage = idamage;
    params.smeansofdeath = smeansofdeath;
    params.weapon = weapon;
    params.vdir = vdir;
    params.shitloc = shitloc;
    params.psoffsettime = psoffsettime;
    self callback::callback( #"on_vehicle_killed", params );
    self callback::callback( #"on_ai_killed", params );
    
    if ( isdefined( self.overridevehiclekilled ) )
    {
        self [[ self.overridevehiclekilled ]]( einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime );
    }
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 0
// Checksum 0x4b7fd55e, Offset: 0x51e0
// Size: 0x2e
function zombie_eye_glow_stop()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.no_eye_glow ) || !self.no_eye_glow )
    {
    }
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 1
// Checksum 0xd00e4dc7, Offset: 0x5218
// Size: 0x130
function approximate_path_dist( player )
{
    aiprofile_beginentry( "approximate_path_dist" );
    goal_pos = player.origin;
    
    if ( isdefined( player.last_valid_position ) )
    {
        goal_pos = player.last_valid_position;
    }
    
    if ( is_true( player.b_teleporting ) )
    {
        if ( isdefined( player.teleport_location ) )
        {
            goal_pos = player.teleport_location;
            
            if ( !ispointonnavmesh( goal_pos, self ) )
            {
                position = getclosestpointonnavmesh( goal_pos, 100, 15 );
                
                if ( isdefined( position ) )
                {
                    goal_pos = position;
                }
            }
        }
    }
    
    approx_dist = pathdistance( self.origin, goal_pos, 1, self );
    aiprofile_endentry();
    return approx_dist;
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 1
// Checksum 0xa9ed1973, Offset: 0x5350
// Size: 0x4e, Type: bool
function zombieshouldknockdown( behaviortreeentity )
{
    if ( !zombiehaslegs( behaviortreeentity ) )
    {
        return false;
    }
    
    if ( is_true( behaviortreeentity.knockdown ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 1
// Checksum 0xd30ba732, Offset: 0x53a8
// Size: 0x28, Type: bool
function zombiehaslegs( entity )
{
    if ( entity.missinglegs === 1 )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 1
// Checksum 0x85b4c571, Offset: 0x53d8
// Size: 0xaa
function zombieknockdownactionstart( behaviortreeentity )
{
    behaviortreeentity setblackboardattribute( "_knockdown_direction", behaviortreeentity.knockdown_direction );
    behaviortreeentity setblackboardattribute( "_knockdown_type", behaviortreeentity.knockdown_type );
    behaviortreeentity setblackboardattribute( "_getup_direction", behaviortreeentity.getup_direction );
    behaviortreeentity collidewithactors( 0 );
    behaviortreeentity.blockingpain = 1;
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 1, eflags: 0x4
// Checksum 0xe636bb1d, Offset: 0x5490
// Size: 0x4c
function private function_c8939973( behaviortreeentity )
{
    if ( is_true( behaviortreeentity.missinglegs ) )
    {
        behaviortreeentity.knockdown = 0;
        behaviortreeentity collidewithactors( 1 );
    }
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 1, eflags: 0x4
// Checksum 0x334edb55, Offset: 0x54e8
// Size: 0x34
function private zombiegetupactionterminate( behaviortreeentity )
{
    behaviortreeentity.knockdown = 0;
    behaviortreeentity collidewithactors( 1 );
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 1
// Checksum 0x30aba7a5, Offset: 0x5528
// Size: 0x12e
function function_e2da0652( entity )
{
    enemies = getaiarchetypearray( #"zombie" );
    enemies = arraycombine( enemies, getaiarchetypearray( #"catalyst" ), 0, 0 );
    enemies = array::filter( enemies, 0, &function_3d752709, entity );
    
    foreach ( enemy in enemies )
    {
        enemy setup_zombie_knockdown( entity );
        enemy.knockdown_type = "knockdown_shoved";
    }
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 2
// Checksum 0x9324f8e7, Offset: 0x5660
// Size: 0x342
function setup_zombie_knockdown( var_5f02306b, var_43b3242 )
{
    if ( !isactor( self ) || is_true( self.missinglegs ) || is_true( self.var_5dd07a80 ) || is_true( self.isinmantleaction ) || self isplayinganimscripted() || self function_dd070839() && !is_true( var_43b3242 ) )
    {
        return;
    }
    
    if ( !isdefined( var_5f02306b ) )
    {
        return;
    }
    
    self.knockdown = 1;
    
    if ( isvec( var_5f02306b ) )
    {
        zombie_to_entity = var_5f02306b - self.origin;
    }
    else
    {
        zombie_to_entity = var_5f02306b.origin - self.origin;
    }
    
    zombie_to_entity_2d = vectornormalize( ( zombie_to_entity[ 0 ], zombie_to_entity[ 1 ], 0 ) );
    zombie_forward = anglestoforward( self.angles );
    zombie_forward_2d = vectornormalize( ( zombie_forward[ 0 ], zombie_forward[ 1 ], 0 ) );
    zombie_right = anglestoright( self.angles );
    zombie_right_2d = vectornormalize( ( zombie_right[ 0 ], zombie_right[ 1 ], 0 ) );
    dot = vectordot( zombie_to_entity_2d, zombie_forward_2d );
    
    if ( dot >= 0.5 )
    {
        self.knockdown_direction = "front";
        self.getup_direction = "getup_back";
        return;
    }
    
    if ( dot < 0.5 && dot > -0.5 )
    {
        dot = vectordot( zombie_to_entity_2d, zombie_right_2d );
        
        if ( dot > 0 )
        {
            self.knockdown_direction = "right";
            
            if ( math::cointoss() )
            {
                self.getup_direction = "getup_back";
            }
            else
            {
                self.getup_direction = "getup_belly";
            }
        }
        else
        {
            self.knockdown_direction = "left";
            self.getup_direction = "getup_belly";
        }
        
        return;
    }
    
    self.knockdown_direction = "back";
    self.getup_direction = "getup_belly";
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 2
// Checksum 0x750ac96a, Offset: 0x59b0
// Size: 0x190, Type: bool
function function_3d752709( enemy, var_bd97c6ae )
{
    if ( !isdefined( enemy ) || !isdefined( var_bd97c6ae ) )
    {
        return false;
    }
    
    if ( is_true( enemy.knockdown ) )
    {
        return false;
    }
    
    if ( gibserverutils::isgibbed( enemy, 384 ) )
    {
        return false;
    }
    
    if ( distancesquared( enemy.origin, var_bd97c6ae.origin ) > sqr( 60 ) )
    {
        return false;
    }
    
    facingvec = anglestoforward( var_bd97c6ae.angles );
    enemyvec = enemy.origin - var_bd97c6ae.origin;
    var_3e3c8075 = ( enemyvec[ 0 ], enemyvec[ 1 ], 0 );
    var_c2ee8451 = ( facingvec[ 0 ], facingvec[ 1 ], 0 );
    var_3e3c8075 = vectornormalize( var_3e3c8075 );
    var_c2ee8451 = vectornormalize( var_c2ee8451 );
    enemydot = vectordot( var_c2ee8451, var_3e3c8075 );
    
    if ( enemydot < 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 2
// Checksum 0xe4da19e9, Offset: 0x5b48
// Size: 0x15c
function function_5a481a84( player, dist = 100 )
{
    dist = distance( self.origin, player.origin );
    targetorigin = ( player.origin[ 0 ], player.origin[ 1 ], self.origin[ 2 ] );
    var_a6470558 = vectornormalize( targetorigin - self.origin );
    aimeleerange = self.meleeweapon.aimeleerange;
    var_32708f81 = dist + aimeleerange;
    var_8cf8f805 = mapfloat( 0, aimeleerange, dist, var_32708f81, dist );
    player playerknockback( 1 );
    player applyknockback( int( var_8cf8f805 ), var_a6470558 );
    player playerknockback( 0 );
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 11
// Checksum 0xff5d40fa, Offset: 0x5cb0
// Size: 0x1e4
function function_422fdfd4( *entity, attacker, *weapon, var_5457dc44, hitloc, point, var_ebcb86d6, *var_b85996d4, *var_159ce525, *var_ddd319d6, *var_d2314927 )
{
    var_8d3f5b7d = isalive( var_ebcb86d6 ) && isplayer( var_ebcb86d6 );
    var_84ed9a13 = function_de3dda83( var_b85996d4, var_159ce525, var_ddd319d6, var_d2314927 );
    registerzombie_bgb_used_reinforce = isdefined( var_84ed9a13 ) && namespace_81245006::function_f29756fe( var_84ed9a13 ) == 1;
    var_30362eca = registerzombie_bgb_used_reinforce && var_84ed9a13.type !== #"armor";
    var_b1c1c5cf = 1;
    
    if ( var_8d3f5b7d )
    {
        has_weakpoints = isdefined( namespace_81245006::function_fab3ee3e( self ) );
        
        if ( var_30362eca && var_ebcb86d6 hasperk( #"specialty_mod_awareness" ) )
        {
            if ( var_b1c1c5cf < 1 )
            {
                var_b1c1c5cf += 0.2;
            }
            else
            {
                var_b1c1c5cf *= 1.2;
            }
        }
    }
    
    return { #damage_scale:var_b1c1c5cf, #var_84ed9a13:var_84ed9a13, #registerzombie_bgb_used_reinforce:registerzombie_bgb_used_reinforce };
}

// Namespace namespace_250e9486/namespace_250e9486
// Params 4
// Checksum 0x18d532a1, Offset: 0x5ea0
// Size: 0xaa
function function_de3dda83( var_5457dc44, hitloc, point, var_ebcb86d6 )
{
    if ( isdefined( var_ebcb86d6 ) )
    {
        var_84ed9a13 = var_ebcb86d6;
    }
    else
    {
        var_84ed9a13 = namespace_81245006::function_3131f5dd( self, hitloc, 1 );
        
        if ( !isdefined( var_84ed9a13 ) )
        {
            var_84ed9a13 = namespace_81245006::function_37e3f011( self, var_5457dc44 );
        }
        
        if ( !isdefined( var_84ed9a13 ) )
        {
            var_84ed9a13 = namespace_81245006::function_73ab4754( self, point, 1 );
        }
    }
    
    return var_84ed9a13;
}

