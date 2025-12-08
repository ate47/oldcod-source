#using script_2c9bc8b876b81af8;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;

#namespace spawn_manager;

// Namespace spawn_manager/spawn_manager
// Params 0, eflags: 0x6
// Checksum 0x5d5254d8, Offset: 0x1b8
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"spawn_manager", &preinit, undefined, undefined, undefined );
}

// Namespace spawn_manager/spawn_manager
// Params 0, eflags: 0x4
// Checksum 0x36dfa227, Offset: 0x200
// Size: 0xe4
function private preinit()
{
    level.var_7c90ec19 = 0;
    level.var_539b11be = 50;
    level.var_e4fdd7dd = 0;
    level.var_ec8c9d99 = 0;
    level.spawn_managers = [];
    level.spawn_managers = getentarray( "spawn_manager", "classname" );
    array::thread_all( level.spawn_managers, &function_b574e20c );
    function_edad3267();
    
    /#
        callback::on_connect( &on_player_connect );
        level thread function_50a58f3();
    #/
}

// Namespace spawn_manager/spawn_manager
// Params 0
// Checksum 0x8091eb8f, Offset: 0x2f0
// Size: 0x1c2
function function_21b5cb9e()
{
    assert( isdefined( self ) );
    assert( isdefined( self.target ) );
    assert( self.sm_group_size_max >= self.sm_group_size_min, "<dev string:x38>" + self.sm_id );
    
    if ( !isdefined( self.sm_spawner_count_min ) || self.sm_spawner_count_min > self.allspawners.size )
    {
        self.sm_spawner_count_min = self.allspawners.size;
    }
    
    if ( !isdefined( self.sm_spawner_count_max ) || self.sm_spawner_count_max > self.allspawners.size )
    {
        self.sm_spawner_count_max = self.allspawners.size;
    }
    
    assert( self.sm_spawner_count_max >= self.sm_spawner_count_min, "<dev string:x38>" + self.sm_id );
    self.var_82a78b41 = randomintrange( self.sm_spawner_count_min, self.sm_spawner_count_max + 1 );
    self.spawners = self function_bf4a387a();
    function_405a4f7c();
    assert( self.sm_group_size_min <= self.sm_active_count_max, "<dev string:x90>" );
    
    if ( !isdefined( self.script_forcespawn ) )
    {
        self.script_forcespawn = 0;
    }
}

// Namespace spawn_manager/spawn_manager
// Params 1
// Checksum 0x5b64d6b1, Offset: 0x4c0
// Size: 0x16e
function function_7051aeac( spawngroupsize )
{
    totalfree = self.count >= 0 ? self.count : level.var_539b11be;
    var_54642189 = self.sm_active_count_max - self.var_5ee53e3.size;
    var_514ec5ff = var_54642189 >= spawngroupsize && totalfree >= spawngroupsize && spawngroupsize > 0;
    var_7d4f7444 = level.var_539b11be - level.var_e4fdd7dd;
    assert( self.enable == level flag::get( "<dev string:xc3>" + self.sm_id + "<dev string:xca>" ), "<dev string:xd6>" );
    
    if ( self.script_forcespawn == 0 )
    {
        return ( totalfree > 0 && var_54642189 > 0 && var_7d4f7444 > 0 && var_514ec5ff && self.enable );
    }
    
    return totalfree > 0 && var_54642189 > 0 && self.enable;
}

// Namespace spawn_manager/spawn_manager
// Params 1
// Checksum 0xe30a3054, Offset: 0x638
// Size: 0x8c
function spawn_manager_spawn( maxdelay )
{
    self endon( #"death" );
    start = gettime();
    
    while ( true )
    {
        ai = self spawner::spawn();
        
        if ( isdefined( ai ) || gettime() - start > 1000 * maxdelay )
        {
            return ai;
        }
        
        wait 0.5;
    }
}

// Namespace spawn_manager/spawn_manager
// Params 2
// Checksum 0x8c8ad90d, Offset: 0x6d0
// Size: 0x104
function function_ae26af62( spawner, spawngroupsize )
{
    for ( i = 0; i < spawngroupsize ; i++ )
    {
        ai = undefined;
        
        if ( isdefined( spawner ) && isdefined( spawner.targetname ) )
        {
            ai = spawner spawn_manager_spawn( 2 );
            
            if ( isdefined( ai ) )
            {
                ai.sm_id = self.sm_id;
            }
        }
        else
        {
            continue;
        }
        
        if ( !spawner::spawn_failed( ai ) )
        {
            if ( isdefined( self.script_radius ) )
            {
                ai.script_radius = self.script_radius;
            }
            
            if ( isdefined( spawner.script_radius ) )
            {
                ai.script_radius = spawner.script_radius;
            }
            
            ai thread function_39f8667d( spawner, self );
        }
    }
}

// Namespace spawn_manager/spawn_manager
// Params 2
// Checksum 0x59aaaf19, Offset: 0x7e0
// Size: 0x130
function function_39f8667d( spawner, manager )
{
    targetname = manager.targetname;
    classname = spawner.classname;
    level.var_7c90ec19++;
    manager.spawncount++;
    
    if ( manager.count > 0 )
    {
        manager.count--;
    }
    
    level.var_e4fdd7dd++;
    origin = spawner.origin;
    manager.var_5ee53e3[ manager.var_5ee53e3.size ] = self;
    spawner.var_5ee53e3[ spawner.var_5ee53e3.size ] = self;
    self waittill( #"death" );
    
    if ( isdefined( spawner ) )
    {
        arrayremovevalue( spawner.var_5ee53e3, self );
    }
    
    if ( isdefined( manager ) )
    {
        arrayremovevalue( manager.var_5ee53e3, self );
    }
    
    level.var_e4fdd7dd--;
}

// Namespace spawn_manager/spawn_manager
// Params 0
// Checksum 0x7893555f, Offset: 0x918
// Size: 0x196
function function_b4ecf5f4()
{
    if ( isdefined( self.name ) )
    {
        /#
            function_827b4278( self.name );
        #/
        
        self.sm_id = self.name;
    }
    else if ( isdefined( self.targetname ) && !strstartswith( self.targetname, "pf" ) )
    {
        /#
            function_827b4278( self.targetname );
        #/
        
        self.sm_id = self.targetname;
    }
    else
    {
        auto_id();
    }
    
    if ( !isdefined( self.var_439d74d6 ) )
    {
        self.var_439d74d6 = self.count;
    }
    
    if ( !isdefined( self.var_897f477f ) )
    {
        self.var_897f477f = isdefined( self.sm_active_count_min ) ? self.sm_active_count_min : level.var_539b11be;
    }
    
    if ( !isdefined( self.var_97077fdd ) )
    {
        self.var_97077fdd = isdefined( self.sm_active_count_max ) ? self.sm_active_count_max : level.var_539b11be;
    }
    
    if ( !isdefined( self.var_2fda6f65 ) )
    {
        self.var_2fda6f65 = isdefined( self.sm_group_size_min ) ? self.sm_group_size_min : 1;
    }
    
    if ( !isdefined( self.var_47f22892 ) )
    {
        self.var_47f22892 = isdefined( self.sm_group_size_max ) ? self.sm_group_size_max : 1;
    }
}

/#

    // Namespace spawn_manager/spawn_manager
    // Params 1
    // Checksum 0xa5d0dac2, Offset: 0xab8
    // Size: 0x128, Type: dev
    function function_827b4278( str_name )
    {
        var_2f99f0ac = getentarray( "<dev string:x114>", "<dev string:x125>" );
        
        foreach ( sm in var_2f99f0ac )
        {
            if ( sm != self )
            {
                if ( sm.targetname === str_name || sm.name === str_name )
                {
                    assertmsg( "<dev string:x132>" + str_name + "<dev string:x162>" + self.origin + "<dev string:x17b>" + sm.origin );
                }
            }
        }
    }

#/

// Namespace spawn_manager/spawn_manager
// Params 0
// Checksum 0xd04fac77, Offset: 0xbe8
// Size: 0x44
function auto_id()
{
    if ( !isdefined( level.var_f64196ab ) )
    {
        level.var_f64196ab = 0;
    }
    
    self.sm_id = "sm_auto" + level.var_f64196ab;
    level.var_f64196ab++;
}

// Namespace spawn_manager/spawn_manager
// Params 0
// Checksum 0x980b5969, Offset: 0xc38
// Size: 0xde
function function_224fb326()
{
    if ( level.players.size >= 4 && isdefined( self.sm_count_4player ) )
    {
        n_count = self.sm_count_4player;
    }
    else if ( level.players.size >= 3 && isdefined( self.sm_count_3player ) )
    {
        n_count = self.sm_count_3player;
    }
    else if ( level.players.size >= 2 && isdefined( self.sm_count_2player ) )
    {
        n_count = self.sm_count_2player;
    }
    else
    {
        n_count = self.var_439d74d6;
    }
    
    if ( n_count > 0 )
    {
        self.count = n_count;
        return;
    }
    
    self.count = -1;
}

// Namespace spawn_manager/spawn_manager
// Params 0
// Checksum 0xe97abfc8, Offset: 0xd20
// Size: 0xbe
function function_1038fe33()
{
    if ( level.players.size >= 4 && isdefined( self.sm_active_count_min_4player ) )
    {
        self.sm_active_count_min = self.sm_active_count_min_4player;
        return;
    }
    
    if ( level.players.size >= 3 && isdefined( self.sm_active_count_min_3player ) )
    {
        self.sm_active_count_min = self.sm_active_count_min_3player;
        return;
    }
    
    if ( level.players.size >= 2 && isdefined( self.sm_active_count_min_2player ) )
    {
        self.sm_active_count_min = self.sm_active_count_min_2player;
        return;
    }
    
    self.sm_active_count_min = self.var_897f477f;
}

// Namespace spawn_manager/spawn_manager
// Params 0
// Checksum 0x5a389643, Offset: 0xde8
// Size: 0xbe
function function_ddc537ad()
{
    if ( level.players.size >= 4 && isdefined( self.sm_active_count_max_4player ) )
    {
        self.sm_active_count_max = self.sm_active_count_max_4player;
        return;
    }
    
    if ( level.players.size >= 3 && isdefined( self.sm_active_count_max_3player ) )
    {
        self.sm_active_count_max = self.sm_active_count_max_3player;
        return;
    }
    
    if ( level.players.size >= 2 && isdefined( self.sm_active_count_max_2player ) )
    {
        self.sm_active_count_max = self.sm_active_count_max_2player;
        return;
    }
    
    self.sm_active_count_max = self.var_97077fdd;
}

// Namespace spawn_manager/spawn_manager
// Params 0
// Checksum 0x988450c6, Offset: 0xeb0
// Size: 0xbe
function function_570206ab()
{
    if ( level.players.size >= 4 && isdefined( self.sm_group_size_min_4player ) )
    {
        self.sm_group_size_min = self.sm_group_size_min_4player;
        return;
    }
    
    if ( level.players.size >= 3 && isdefined( self.sm_group_size_min_3player ) )
    {
        self.sm_group_size_min = self.sm_group_size_min_3player;
        return;
    }
    
    if ( level.players.size >= 2 && isdefined( self.sm_group_size_min_2player ) )
    {
        self.sm_group_size_min = self.sm_group_size_min_2player;
        return;
    }
    
    self.sm_group_size_min = self.var_2fda6f65;
}

// Namespace spawn_manager/spawn_manager
// Params 0
// Checksum 0x3145e4b9, Offset: 0xf78
// Size: 0xbe
function function_162ab3ec()
{
    if ( level.players.size >= 4 && isdefined( self.sm_group_size_max_4player ) )
    {
        self.sm_group_size_max = self.sm_group_size_max_4player;
        return;
    }
    
    if ( level.players.size >= 3 && isdefined( self.sm_group_size_max_3player ) )
    {
        self.sm_group_size_max = self.sm_group_size_max_3player;
        return;
    }
    
    if ( level.players.size >= 2 && isdefined( self.sm_group_size_max_2player ) )
    {
        self.sm_group_size_max = self.sm_group_size_max_2player;
        return;
    }
    
    self.sm_group_size_max = self.var_47f22892;
}

// Namespace spawn_manager/spawn_manager
// Params 0
// Checksum 0x9315cea6, Offset: 0x1040
// Size: 0x108
function function_405a4f7c()
{
    function_224fb326();
    function_1038fe33();
    function_ddc537ad();
    function_570206ab();
    function_162ab3ec();
    
    foreach ( sp in self.spawners )
    {
        sp function_224fb326();
        sp function_1038fe33();
        sp function_ddc537ad();
    }
}

// Namespace spawn_manager/spawn_manager
// Params 0
// Checksum 0x822228ee, Offset: 0x1150
// Size: 0x94
function function_18b42a8b()
{
    if ( !isdefined( self.sm_wave_wait_min ) )
    {
        self.sm_wave_wait_min = 0;
    }
    
    if ( !isdefined( self.sm_wave_wait_max ) )
    {
        self.sm_wave_wait_max = 0;
    }
    
    if ( self.sm_wave_wait_max > 0 && self.sm_wave_wait_max > self.sm_wave_wait_min )
    {
        wait randomfloatrange( self.sm_wave_wait_min, self.sm_wave_wait_max );
        return;
    }
    
    if ( self.sm_wave_wait_min > 0 )
    {
        wait self.sm_wave_wait_min;
    }
}

// Namespace spawn_manager/spawn_manager
// Params 0
// Checksum 0x63ff77fb, Offset: 0x11f0
// Size: 0x704
function function_b574e20c()
{
    self endon( #"death" );
    self function_b4ecf5f4();
    self function_a239f3bc();
    self thread function_415ef8f();
    self thread function_16231fe();
    self.enable = 0;
    self.var_5ee53e3 = [];
    self.spawncount = 0;
    isfirsttime = 1;
    self.allspawners = getentarray( self.target, "targetname" );
    assert( self.allspawners.size, "<dev string:x186>" + self.sm_id + "<dev string:x199>" );
    level flag::wait_till( "sm_" + self.sm_id + "_enabled" );
    util::script_delay();
    self function_21b5cb9e();
    var_73138af8 = 1;
    self function_5bc5bce6();
    
    while ( self.count != 0 && self.spawners.size > 0 )
    {
        function_423f86ff();
        n_active = self.var_5ee53e3.size;
        var_3ed9a82e = self.sm_active_count_max - n_active;
        
        if ( !var_73138af8 && self.var_5ee53e3.size <= self.sm_active_count_min )
        {
            var_73138af8 = 1;
            function_18b42a8b();
        }
        else if ( var_73138af8 && var_3ed9a82e < self.var_ed3f1bbb )
        {
            var_73138af8 = 0;
        }
        
        if ( !var_73138af8 )
        {
            waitframe( 1 );
            continue;
        }
        
        self function_5bc5bce6();
        
        if ( self.count > 0 )
        {
            if ( self.var_ed3f1bbb > self.count )
            {
                self.var_ed3f1bbb = self.count;
            }
        }
        
        spawned = 0;
        
        while ( !spawned )
        {
            function_423f86ff();
            
            if ( self.spawners.size <= 0 )
            {
                break;
            }
            
            if ( self function_7051aeac( self.var_ed3f1bbb ) )
            {
                assert( self.var_ed3f1bbb > 0 );
                var_33440dfa = [];
                var_76d7ba22 = [];
                
                for ( i = 0; i < self.spawners.size ; i++ )
                {
                    current_spawner = self.spawners[ i ];
                    
                    if ( isdefined( current_spawner ) )
                    {
                        if ( current_spawner.var_5ee53e3.size > current_spawner.sm_active_count_min )
                        {
                            continue;
                        }
                        
                        if ( !function_42a4d0d8( current_spawner ) )
                        {
                            continue;
                        }
                        
                        var_20c0d5a8 = current_spawner.sm_active_count_max - current_spawner.var_5ee53e3.size;
                        
                        if ( var_20c0d5a8 >= self.var_ed3f1bbb )
                        {
                            if ( isdefined( current_spawner.spawnflags ) && ( current_spawner.spawnflags & 32 ) == 32 )
                            {
                                var_76d7ba22[ var_76d7ba22.size ] = current_spawner;
                                continue;
                            }
                            
                            var_33440dfa[ var_33440dfa.size ] = current_spawner;
                        }
                    }
                }
                
                if ( var_33440dfa.size > 0 || var_76d7ba22.size > 0 )
                {
                    if ( var_76d7ba22.size > 0 )
                    {
                        spawner = array::random( var_76d7ba22 );
                    }
                    else
                    {
                        spawner = array::random( var_33440dfa );
                    }
                    
                    if ( !( isdefined( spawner.spawnflags ) && ( spawner.spawnflags & 64 ) == 64 ) && spawner.count < self.var_ed3f1bbb )
                    {
                        self.var_ed3f1bbb = spawner.count;
                    }
                    
                    if ( !isfirsttime )
                    {
                        function_26374d3f();
                    }
                    else
                    {
                        isfirsttime = 0;
                    }
                    
                    if ( !self.enable )
                    {
                        continue;
                    }
                    
                    self function_ae26af62( spawner, self.var_ed3f1bbb );
                    spawned = 1;
                }
                else
                {
                    var_7fdb9de8 = 0;
                    
                    for ( i = 0; i < self.spawners.size ; i++ )
                    {
                        current_spawner = self.spawners[ i ];
                        
                        if ( isdefined( current_spawner ) )
                        {
                            if ( current_spawner.sm_active_count_max > var_7fdb9de8 )
                            {
                                var_7fdb9de8 = current_spawner.sm_active_count_max;
                            }
                        }
                    }
                    
                    if ( var_7fdb9de8 < self.sm_group_size_max )
                    {
                        self.sm_group_size_max = var_7fdb9de8;
                        self function_5bc5bce6();
                    }
                }
            }
            
            waitframe( 1 );
        }
        
        waitframe( 1 );
        assert( !level flag::get( "<dev string:xc3>" + self.sm_id + "<dev string:x1bb>" ), "<dev string:xd6>" );
        assert( !level flag::get( "<dev string:xc3>" + self.sm_id + "<dev string:x1c6>" ), "<dev string:xd6>" );
    }
    
    self function_f00c27f1();
    
    if ( isdefined( self.var_5ee53e3 ) && self.var_5ee53e3.size != 0 )
    {
        array::wait_till( self.var_5ee53e3, "death" );
    }
    
    function_257e48e2();
    self delete();
}

// Namespace spawn_manager/spawn_manager
// Params 0
// Checksum 0x9c3d4ba6, Offset: 0x1900
// Size: 0x94
function function_415ef8f()
{
    self endon( #"death" );
    
    while ( isdefined( self ) )
    {
        self waittill( #"enable" );
        self.enable = 1;
        self function_2b1e3e5f();
        self waittill( #"disable" );
        self function_e6bfc4ff();
    }
    
    self function_e6bfc4ff();
}

// Namespace spawn_manager/spawn_manager
// Params 1
// Checksum 0xd232e527, Offset: 0x19a0
// Size: 0x70
function function_9db43c7f( spawn_manager )
{
    spawn_manager endon( #"death", #"enable" );
    self endon( #"death" );
    self waittill( #"trigger" );
    spawn_manager notify( #"enable" );
}

// Namespace spawn_manager/spawn_manager
// Params 0
// Checksum 0x386e6afd, Offset: 0x1a18
// Size: 0x16c
function function_16231fe()
{
    self waittill( #"death" );
    sm_id = self.sm_id;
    a_spawners = self.allspawners;
    var_61262c99 = self.var_5ee53e3;
    level flag::clear( "sm_" + sm_id + "_enabled" );
    level flag::set( "sm_" + sm_id + "_killed" );
    level flag::set( "sm_" + sm_id + "_complete" );
    function_257e48e2();
    
    if ( var_61262c99.size )
    {
        array::wait_till( var_61262c99, "death" );
    }
    
    level flag::set( "sm_" + sm_id + "_cleared" );
    arrayremovevalue( level.spawn_managers, undefined );
}

// Namespace spawn_manager/spawn_manager
// Params 1
// Checksum 0x7a376e5d, Offset: 0x1b90
// Size: 0x17c
function function_edad3267( *var_8bfffc1b )
{
    triggers = trigger::get_all( "trigger_multiple", "trigger_once", "trigger_use", "trigger_radius", "trigger_lookat", "trigger_damage", "trigger_box" );
    
    foreach ( trig in triggers )
    {
        if ( isdefined( trig.target ) )
        {
            targets = function_aaa872c1( trig.target );
            
            foreach ( target in targets )
            {
                trig thread function_9db43c7f( target );
            }
        }
    }
}

// Namespace spawn_manager/spawn_manager
// Params 1
// Checksum 0xc1b607f, Offset: 0x1d18
// Size: 0x114
function function_aaa872c1( targetname )
{
    if ( isdefined( targetname ) )
    {
        var_a900263 = [];
        
        for ( i = 0; i < level.spawn_managers.size ; i++ )
        {
            if ( isdefined( level.spawn_managers[ i ] ) )
            {
                if ( level.spawn_managers[ i ].targetname === targetname || level.spawn_managers[ i ].name === targetname )
                {
                    if ( !isdefined( var_a900263 ) )
                    {
                        var_a900263 = [];
                    }
                    else if ( !isarray( var_a900263 ) )
                    {
                        var_a900263 = array( var_a900263 );
                    }
                    
                    var_a900263[ var_a900263.size ] = level.spawn_managers[ i ];
                }
            }
        }
        
        return var_a900263;
    }
    
    return level.spawn_managers;
}

// Namespace spawn_manager/spawn_manager
// Params 0
// Checksum 0x2eeaf9d4, Offset: 0x1e38
// Size: 0x324
function function_bf4a387a()
{
    arrayremovevalue( self.allspawners, undefined );
    exclude = [];
    
    for ( i = 0; i < self.allspawners.size ; i++ )
    {
        if ( isdefined( level.var_6a15351c ) && self.allspawners[ i ].classname == "actor_enemy_dog_sp" )
        {
            if ( !isdefined( exclude ) )
            {
                exclude = [];
            }
            else if ( !isarray( exclude ) )
            {
                exclude = array( exclude );
            }
            
            exclude[ exclude.size ] = self.allspawners[ i ];
        }
    }
    
    self.allspawners = array::exclude( self.allspawners, exclude );
    var_698d805a = 0;
    
    foreach ( sp in self.allspawners )
    {
        if ( !isdefined( sp.var_439d74d6 ) )
        {
            sp.var_439d74d6 = sp.count;
        }
        
        if ( !isdefined( sp.var_97077fdd ) )
        {
            sp.var_97077fdd = isdefined( sp.sm_active_count_max ) ? sp.sm_active_count_max : level.var_539b11be;
        }
        
        if ( !isdefined( sp.var_897f477f ) )
        {
            sp.var_897f477f = isdefined( sp.sm_active_count_min ) ? sp.sm_active_count_min : sp.var_97077fdd;
        }
        
        sp.var_5ee53e3 = [];
    }
    
    var_7b00ead3 = arraycopy( self.allspawners );
    var_92174f16 = self.var_82a78b41;
    
    if ( var_92174f16 > self.allspawners.size )
    {
        var_92174f16 = self.allspawners.size;
    }
    
    spawners = [];
    
    while ( spawners.size < var_92174f16 )
    {
        spawner = array::random( var_7b00ead3 );
        
        if ( !isdefined( spawners ) )
        {
            spawners = [];
        }
        else if ( !isarray( spawners ) )
        {
            spawners = array( spawners );
        }
        
        spawners[ spawners.size ] = spawner;
        arrayremovevalue( var_7b00ead3, spawner );
    }
    
    return spawners;
}

// Namespace spawn_manager/spawn_manager
// Params 0
// Checksum 0x72120038, Offset: 0x2168
// Size: 0x5e
function function_5bc5bce6()
{
    if ( self.sm_group_size_min < self.sm_group_size_max )
    {
        self.var_ed3f1bbb = randomintrange( self.sm_group_size_min, self.sm_group_size_max + 1 );
    }
    else
    {
        self.var_ed3f1bbb = self.sm_group_size_min;
    }
    
    return self.var_ed3f1bbb;
}

// Namespace spawn_manager/spawn_manager
// Params 0
// Checksum 0xb4448d5e, Offset: 0x21d0
// Size: 0xc2
function function_257e48e2()
{
    if ( isdefined( self.spawners ) )
    {
        foreach ( spawner in self.spawners )
        {
            if ( isdefined( spawner ) && !is_false( spawner.script_delete ) )
            {
                spawner delete();
            }
        }
        
        self.spawners = undefined;
    }
}

// Namespace spawn_manager/spawn_manager
// Params 0
// Checksum 0x194c017b, Offset: 0x22a0
// Size: 0xb2
function function_423f86ff()
{
    spawners = [];
    
    for ( i = 0; i < self.spawners.size ; i++ )
    {
        if ( isdefined( self.spawners[ i ] ) )
        {
            if ( self.spawners[ i ].count != 0 )
            {
                spawners[ spawners.size ] = self.spawners[ i ];
                continue;
            }
            
            self.spawners[ i ] delete();
        }
    }
    
    self.spawners = spawners;
}

// Namespace spawn_manager/spawn_manager
// Params 0
// Checksum 0x813bec12, Offset: 0x2360
// Size: 0x19a
function function_26374d3f()
{
    if ( isdefined( self.script_wait ) )
    {
        wait self.script_wait;
        
        if ( isdefined( self.script_wait_add ) )
        {
            self.script_wait += self.script_wait_add;
        }
        
        return;
    }
    
    if ( isdefined( self.script_wait_min ) && isdefined( self.script_wait_max ) )
    {
        var_8d59d673 = 1;
        players = getplayers();
        
        if ( players.size == 2 )
        {
            var_8d59d673 = 0.7;
        }
        else if ( players.size == 3 )
        {
            var_8d59d673 = 0.5;
        }
        else if ( players.size == 4 )
        {
            var_8d59d673 = 0.3;
        }
        
        diff = self.script_wait_max - self.script_wait_min;
        
        if ( abs( diff ) > 0 )
        {
            wait randomfloatrange( self.script_wait_min, self.script_wait_min + diff * var_8d59d673 );
        }
        else
        {
            wait self.script_wait_min;
        }
        
        if ( isdefined( self.script_wait_add ) )
        {
            self.script_wait_min += self.script_wait_add;
            self.script_wait_max += self.script_wait_add;
        }
    }
}

// Namespace spawn_manager/spawn_manager
// Params 1
// Checksum 0x9873e689, Offset: 0x2508
// Size: 0x13c, Type: bool
function function_42a4d0d8( spawner )
{
    if ( !isdefined( spawner.sm_player_safety_dist ) )
    {
        return true;
    }
    
    radius = isdefined( spawner.sm_player_safety_dist ) ? spawner.sm_player_safety_dist : 0;
    players = getplayers();
    
    if ( !isdefined( players ) || players.size == 0 )
    {
        return true;
    }
    
    foreach ( player in players )
    {
        if ( distancesquared( spawner.origin, player.origin ) <= sqr( spawner.sm_player_safety_dist ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace spawn_manager/spawn_manager
// Params 0
// Checksum 0x8f41cca1, Offset: 0x2650
// Size: 0xc4
function function_a239f3bc()
{
    level flag::init( "sm_" + self.sm_id + "_enabled" );
    level flag::init( "sm_" + self.sm_id + "_complete" );
    level flag::init( "sm_" + self.sm_id + "_killed" );
    level flag::init( "sm_" + self.sm_id + "_cleared" );
}

// Namespace spawn_manager/spawn_manager
// Params 0
// Checksum 0x8e77481f, Offset: 0x2720
// Size: 0x84
function function_2b1e3e5f()
{
    assert( !level flag::get( "<dev string:xc3>" + self.sm_id + "<dev string:xca>" ), "<dev string:xd6>" );
    level flag::set( "sm_" + self.sm_id + "_enabled" );
}

// Namespace spawn_manager/spawn_manager
// Params 0
// Checksum 0xbacc6f9b, Offset: 0x27b0
// Size: 0x3c
function function_e6bfc4ff()
{
    self.enable = 0;
    level flag::clear( "sm_" + self.sm_id + "_enabled" );
}

// Namespace spawn_manager/spawn_manager
// Params 0
// Checksum 0x84495247, Offset: 0x27f8
// Size: 0x84
function function_c81f3c84()
{
    assert( !level flag::get( "<dev string:xc3>" + self.sm_id + "<dev string:x1bb>" ), "<dev string:xd6>" );
    level flag::set( "sm_" + self.sm_id + "_killed" );
}

// Namespace spawn_manager/spawn_manager
// Params 0
// Checksum 0x48fc324e, Offset: 0x2888
// Size: 0x84
function function_f00c27f1()
{
    assert( !level flag::get( "<dev string:xc3>" + self.sm_id + "<dev string:x1c6>" ), "<dev string:xd6>" );
    level flag::set( "sm_" + self.sm_id + "_complete" );
}

// Namespace spawn_manager/spawn_manager
// Params 0
// Checksum 0x6421d6b3, Offset: 0x2918
// Size: 0x84
function function_a1dec600()
{
    assert( !level flag::get( "<dev string:xc3>" + self.sm_id + "<dev string:x1d3>" ), "<dev string:xd6>" );
    level flag::set( "sm_" + self.sm_id + "_cleared" );
}

// Namespace spawn_manager/spawn_manager
// Params 1
// Checksum 0x65bde855, Offset: 0x29a8
// Size: 0x44
function function_3c035c82( var_2594900 )
{
    assert( var_2594900 <= 32, "<dev string:x1df>" );
    level.var_539b11be = var_2594900;
}

// Namespace spawn_manager/spawn_manager
// Params 4
// Checksum 0x3b7d465, Offset: 0x29f8
// Size: 0x14c
function function_883b9499( var_368d405d, trig_name, var_66d7c971, once_only )
{
    if ( isdefined( once_only ) && once_only )
    {
        trigger = getent( trig_name, var_66d7c971 );
        assert( isdefined( trigger ), "<dev string:x21f>" + var_66d7c971 + "<dev string:x22f>" + trig_name + "<dev string:x236>" );
        trigger endon( #"trigger" );
    }
    
    if ( level flag::exists( "sm_" + var_368d405d + "_enabled" ) )
    {
        level flag::wait_till( "sm_" + var_368d405d + "_complete" );
        trigger::use( trig_name, var_66d7c971 );
        return;
    }
    
    assertmsg( "<dev string:x24a>" + var_368d405d + "<dev string:x275>" );
}

// Namespace spawn_manager/spawn_manager
// Params 4
// Checksum 0x29790846, Offset: 0x2b50
// Size: 0x14c
function function_fc60286c( var_368d405d, trig_name, var_66d7c971, once_only )
{
    if ( isdefined( once_only ) && once_only )
    {
        trigger = getent( trig_name, var_66d7c971 );
        assert( isdefined( trigger ), "<dev string:x21f>" + var_66d7c971 + "<dev string:x22f>" + trig_name + "<dev string:x236>" );
        trigger endon( #"trigger" );
    }
    
    if ( level flag::exists( "sm_" + var_368d405d + "_enabled" ) )
    {
        level flag::wait_till( "sm_" + var_368d405d + "_cleared" );
        trigger::use( trig_name, var_66d7c971 );
        return;
    }
    
    assertmsg( "<dev string:x285>" + var_368d405d + "<dev string:x275>" );
}

// Namespace spawn_manager/spawn_manager
// Params 4
// Checksum 0x4413b54c, Offset: 0x2ca8
// Size: 0x14c
function function_eba7c12( var_368d405d, trig_name, var_66d7c971, once_only )
{
    if ( isdefined( once_only ) && once_only )
    {
        trigger = getent( trig_name, var_66d7c971 );
        assert( isdefined( trigger ), "<dev string:x21f>" + var_66d7c971 + "<dev string:x22f>" + trig_name + "<dev string:x236>" );
        trigger endon( #"trigger" );
    }
    
    if ( level flag::exists( "sm_" + var_368d405d + "_enabled" ) )
    {
        level flag::wait_till( "sm_" + var_368d405d + "_enabled" );
        trigger::use( trig_name, var_66d7c971 );
        return;
    }
    
    assertmsg( "<dev string:x285>" + var_368d405d + "<dev string:x275>" );
}

// Namespace spawn_manager/spawn_manager
// Params 8
// Checksum 0xcd43e547, Offset: 0x2e00
// Size: 0xf4
function function_cf623c0e( var_368d405d, process, ent, var1, var2, var3, var4, var5 )
{
    assert( isdefined( process ), "<dev string:x2b2>" );
    assert( level flag::exists( "<dev string:xc3>" + var_368d405d + "<dev string:xca>" ), "<dev string:x2e9>" + var_368d405d + "<dev string:x275>" );
    wait_till_complete( var_368d405d );
    util::single_func( ent, process, var1, var2, var3, var4, var5 );
}

// Namespace spawn_manager/spawn_manager
// Params 8
// Checksum 0xa85ab251, Offset: 0x2f00
// Size: 0xf4
function function_685f0f0b( var_368d405d, process, ent, var1, var2, var3, var4, var5 )
{
    assert( isdefined( process ), "<dev string:x314>" );
    assert( level flag::exists( "<dev string:xc3>" + var_368d405d + "<dev string:xca>" ), "<dev string:x34a>" + var_368d405d + "<dev string:x275>" );
    wait_till_cleared( var_368d405d );
    util::single_func( ent, process, var1, var2, var3, var4, var5 );
}

// Namespace spawn_manager/spawn_manager
// Params 8
// Checksum 0x5f2a4251, Offset: 0x3000
// Size: 0xf4
function function_2886c4a9( var_368d405d, process, ent, var1, var2, var3, var4, var5 )
{
    assert( isdefined( process ), "<dev string:x374>" );
    assert( level flag::exists( "<dev string:xc3>" + var_368d405d + "<dev string:xca>" ), "<dev string:x3aa>" + var_368d405d + "<dev string:x275>" );
    function_58415221( var_368d405d );
    util::single_func( ent, process, var1, var2, var3, var4, var5 );
}

// Namespace spawn_manager/spawn_manager
// Params 2
// Checksum 0x56dd1003, Offset: 0x3100
// Size: 0x12c
function enable( var_368d405d, var_6ea96389 )
{
    if ( level flag::exists( "sm_" + var_368d405d + "_enabled" ) )
    {
        foreach ( sm in level.spawn_managers )
        {
            if ( isdefined( sm ) && sm.sm_id == var_368d405d )
            {
                sm notify( #"enable" );
                return;
            }
        }
        
        return;
    }
    
    if ( !is_true( var_6ea96389 ) )
    {
        assertmsg( "<dev string:x3d4>" + var_368d405d + "<dev string:x275>" );
    }
}

// Namespace spawn_manager/spawn_manager
// Params 2
// Checksum 0xcec496a8, Offset: 0x3238
// Size: 0x12c
function disable( var_368d405d, var_6ea96389 )
{
    if ( level flag::exists( "sm_" + var_368d405d + "_enabled" ) )
    {
        foreach ( sm in level.spawn_managers )
        {
            if ( isdefined( sm ) && sm.sm_id == var_368d405d )
            {
                sm notify( #"disable" );
                return;
            }
        }
        
        return;
    }
    
    if ( !is_true( var_6ea96389 ) )
    {
        assertmsg( "<dev string:x3ef>" + var_368d405d + "<dev string:x275>" );
    }
}

// Namespace spawn_manager/spawn_manager
// Params 2
// Checksum 0x4591c959, Offset: 0x3370
// Size: 0x154
function kill( var_368d405d, var_6ea96389 )
{
    if ( level flag::exists( "sm_" + var_368d405d + "_enabled" ) )
    {
        foreach ( sm in level.spawn_managers )
        {
            if ( isdefined( sm ) && sm.sm_id == var_368d405d )
            {
                sm delete();
                arrayremovevalue( level.spawn_managers, undefined );
                return;
            }
        }
        
        return;
    }
    
    if ( !is_true( var_6ea96389 ) )
    {
        assertmsg( "<dev string:x40b>" + var_368d405d + "<dev string:x275>" );
    }
}

// Namespace spawn_manager/spawn_manager
// Params 1
// Checksum 0x96700398, Offset: 0x34d0
// Size: 0xac
function is_enabled( var_368d405d )
{
    if ( level flag::exists( "sm_" + var_368d405d + "_enabled" ) )
    {
        if ( level flag::get( "sm_" + var_368d405d + "_enabled" ) )
        {
            return 1;
        }
        
        return 0;
    }
    
    assertmsg( "<dev string:x424>" + var_368d405d + "<dev string:x275>" );
}

// Namespace spawn_manager/spawn_manager
// Params 1
// Checksum 0xc00d1f8e, Offset: 0x3588
// Size: 0xac
function is_complete( var_368d405d )
{
    if ( level flag::exists( "sm_" + var_368d405d + "_enabled" ) )
    {
        if ( level flag::get( "sm_" + var_368d405d + "_complete" ) )
        {
            return 1;
        }
        
        return 0;
    }
    
    assertmsg( "<dev string:x443>" + var_368d405d + "<dev string:x275>" );
}

// Namespace spawn_manager/spawn_manager
// Params 1
// Checksum 0xbbff2943, Offset: 0x3640
// Size: 0xac
function function_abe43927( var_368d405d )
{
    if ( level flag::exists( "sm_" + var_368d405d + "_enabled" ) )
    {
        if ( level flag::get( "sm_" + var_368d405d + "_cleared" ) )
        {
            return 1;
        }
        
        return 0;
    }
    
    assertmsg( "<dev string:x463>" + var_368d405d + "<dev string:x275>" );
}

// Namespace spawn_manager/spawn_manager
// Params 1
// Checksum 0x6bdf0944, Offset: 0x36f8
// Size: 0xac
function is_killed( var_368d405d )
{
    if ( level flag::exists( "sm_" + var_368d405d + "_enabled" ) )
    {
        if ( level flag::get( "sm_" + var_368d405d + "_killed" ) )
        {
            return 1;
        }
        
        return 0;
    }
    
    assertmsg( "<dev string:x482>" + var_368d405d + "<dev string:x275>" );
}

// Namespace spawn_manager/spawn_manager
// Params 1
// Checksum 0xbc15ddd4, Offset: 0x37b0
// Size: 0x9c
function wait_till_cleared( var_368d405d )
{
    if ( level flag::exists( "sm_" + var_368d405d + "_enabled" ) )
    {
        level flag::wait_till( "sm_" + var_368d405d + "_cleared" );
        return;
    }
    
    assertmsg( "<dev string:x4a0>" + var_368d405d + "<dev string:x275>" );
}

// Namespace spawn_manager/spawn_manager
// Params 2
// Checksum 0x3c58d5bf, Offset: 0x3858
// Size: 0x140
function function_1e9819fa( var_368d405d, var_e672b95b )
{
    assert( isdefined( var_e672b95b ), "<dev string:x4c6>" );
    assert( var_e672b95b, "<dev string:x50f>" );
    
    if ( level flag::exists( "sm_" + var_368d405d + "_enabled" ) )
    {
        level flag::wait_till( "sm_" + var_368d405d + "_complete" );
    }
    else
    {
        assertmsg( "<dev string:x570>" + var_368d405d + "<dev string:x275>" );
    }
    
    if ( level flag::get( "sm_" + var_368d405d + "_cleared" ) )
    {
        return;
    }
    
    while ( get_ai( var_368d405d ).size > var_e672b95b )
    {
        wait 0.1;
    }
}

// Namespace spawn_manager/spawn_manager
// Params 1
// Checksum 0xbd8db1c2, Offset: 0x39a0
// Size: 0x9c
function wait_till_complete( var_368d405d )
{
    if ( level flag::exists( "sm_" + var_368d405d + "_enabled" ) )
    {
        level flag::wait_till( "sm_" + var_368d405d + "_complete" );
        return;
    }
    
    assertmsg( "<dev string:x59b>" + var_368d405d + "<dev string:x275>" );
}

// Namespace spawn_manager/spawn_manager
// Params 1
// Checksum 0x93d56dfb, Offset: 0x3a48
// Size: 0x9c
function function_58415221( var_368d405d )
{
    if ( level flag::exists( "sm_" + var_368d405d + "_enabled" ) )
    {
        level flag::wait_till( "sm_" + var_368d405d + "_enabled" );
        return;
    }
    
    assertmsg( "<dev string:x5c2>" + var_368d405d + "<dev string:x275>" );
}

// Namespace spawn_manager/spawn_manager
// Params 2
// Checksum 0x91dda66e, Offset: 0x3af0
// Size: 0x178
function function_371d10c1( var_368d405d, count )
{
    if ( level flag::exists( "sm_" + var_368d405d + "_enabled" ) )
    {
        level flag::wait_till( "sm_" + var_368d405d + "_enabled" );
    }
    else
    {
        assertmsg( "<dev string:x5e8>" + var_368d405d + "<dev string:x275>" );
    }
    
    spawn_manager = function_aaa872c1( var_368d405d );
    assert( spawn_manager.size, "<dev string:x614>" );
    assert( spawn_manager.size == 1, "<dev string:x660>" );
    
    while ( true )
    {
        if ( isdefined( spawn_manager[ 0 ].spawncount ) && spawn_manager[ 0 ].spawncount < count && !is_killed( var_368d405d ) )
        {
            wait 0.5;
            continue;
        }
        
        break;
    }
}

// Namespace spawn_manager/spawn_manager
// Params 1
// Checksum 0x71d41a95, Offset: 0x3c78
// Size: 0x3a
function get_ai( var_368d405d )
{
    a_ai = getaiarray( var_368d405d, "sm_id" );
    return a_ai;
}

