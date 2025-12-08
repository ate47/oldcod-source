#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2474a362752098d2;
#using script_2a5bf5b4a00cee0d;
#using script_40f967ad5d18ea74;
#using script_4611af4073d18808;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_5549681e1669c11a;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_634ae70c663d1cc9;
#using script_683a55734f15d50e;
#using script_68cdf0ca5df5e;
#using script_6b6510e124bad778;
#using script_74a56359b7d02ab6;
#using script_77357b2d180aa2b8;
#using script_774302f762d76254;
#using script_f38dc50f0e82277;
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

#namespace doa_wild;

// Namespace doa_wild
// Method(s) 29 Total 29
class class_744b99c
{

    var doa;
    var m_center;
    var m_name;
    var script_noteworthy;
    var target;
    var var_2a0f52f3;
    var var_3fe6d9f7;
    var var_45e27b4f;
    var var_6c9ec3e8;
    var var_7c1b05a1;
    var var_9c618072;
    var var_9d4c1dcc;
    var var_a04d7049;
    var var_a1fa7529;
    var var_a26d9c0d;
    var var_bb4d9604;
    var var_be31d6d6;
    var var_c1958f8c;
    var var_c7395a06;
    var var_dc9b8143;
    var var_e2a6dd61;
    var visited;

    // Namespace class_744b99c/doa_wild
    // Params 0, eflags: 0x8
    // Checksum 0x58e4a06b, Offset: 0x4f0
    // Size: 0xc2
    constructor()
    {
        var_be31d6d6 = undefined;
        m_center = undefined;
        m_name = undefined;
        var_9c618072 = [];
        var_a04d7049 = [];
        var_45e27b4f = [];
        var_dc9b8143 = [];
        var_2a0f52f3 = [];
        var_7c1b05a1 = undefined;
        var_c1958f8c = 0;
        var_9d4c1dcc = 1;
        var_a1fa7529 = [];
        var_c7395a06 = undefined;
        var_6c9ec3e8 = undefined;
        var_e2a6dd61 = [];
        var_3fe6d9f7 = [];
    }

    // Namespace class_744b99c/doa_wild
    // Params 0, eflags: 0x10
    // Checksum 0xe3e5346c, Offset: 0x5c0
    // Size: 0x14
    destructor()
    {
        deactivate();
    }

    // Namespace namespace_744b99c/doa_wild
    // Params 0
    // Checksum 0xa8dbbb32, Offset: 0x1fc8
    // Size: 0x90
    function function_1137c8bb()
    {
        foreach ( exit in var_45e27b4f )
        {
            exit clientfield::set( "set_icon", 0 );
        }
    }

    // Namespace namespace_744b99c/doa_wild
    // Params 1
    // Checksum 0x1d7ae9f6, Offset: 0x1ee8
    // Size: 0x34
    function function_20212fba( section )
    {
        var_6c9ec3e8 = section;
        self thread function_40ee47dc( var_6c9ec3e8 );
    }

    // Namespace namespace_744b99c/doa_wild
    // Params 1
    // Checksum 0x444de42b, Offset: 0x2440
    // Size: 0x13a
    function function_2c3a3e50( zone )
    {
        self endon( #"disconnect" );
        zone endon( #"deactivate" );
        var_bb4d9604 = 1;
        assert( zone.script_noteworthy == "<dev string:x13a>" );
        
        if ( !is_true( doa.infps ) )
        {
            self thread namespace_a4bedd45::function_1f704cee( 1 );
        }
        
        misses = 5;
        
        while ( true )
        {
            if ( self istouching( zone ) )
            {
                misses = 5;
            }
            else
            {
                misses--;
                
                if ( misses <= 0 )
                {
                    break;
                }
            }
            
            wait 0.5;
        }
        
        self notify( #"hash_7893364bd228d63e", { #var_cff8d1e:1 } );
        var_bb4d9604 = 0;
    }

    // Namespace namespace_744b99c/doa_wild
    // Params 0
    // Checksum 0x3b507a47, Offset: 0x1e30
    // Size: 0xa
    function getname()
    {
        return m_name;
    }

    // Namespace namespace_744b99c/doa_wild
    // Params 0
    // Checksum 0xc83e942e, Offset: 0x1e60
    // Size: 0xa
    function function_31ca9ed1()
    {
        return var_c1958f8c;
    }

    // Namespace namespace_744b99c/doa_wild
    // Params 0
    // Checksum 0xc8a5bf1, Offset: 0x2588
    // Size: 0x2ec
    function function_33300d38()
    {
        self triggerenable( !is_true( visited ) );
        result = self waittill( #"deactivate", #"trigger" );
        self triggerenable( 0 );
        
        if ( result._notify == "trigger" )
        {
            assert( isdefined( script_noteworthy ), "<dev string:x149>" );
            room = namespace_5a917022::function_c8892b0f( script_noteworthy );
            assert( isdefined( room ), "<dev string:x167>" + script_noteworthy );
            visited = 1;
            level thread namespace_7f5aeb59::function_67f054d7( 1.5 );
            level waittill( #"hash_1b322de3d2e3e781" );
            level thread namespace_5a917022::function_898ca25f( room );
            level waittill( #"hash_7dd47c99b7707b1c" );
            var_4200bfbf = struct::get_array( target );
            assert( isdefined( var_4200bfbf ) && var_4200bfbf.size >= 4, "<dev string:x188>" );
            players = namespace_7f5aeb59::function_23e1f90f();
            idx = 0;
            
            foreach ( player in players )
            {
                player setorigin( var_4200bfbf[ idx ].origin );
                player setplayerangles( var_4200bfbf[ idx ].angles );
                player clientfield::increment_to_player( "resetCamera" );
                idx++;
            }
            
            wait 1;
            level thread namespace_7f5aeb59::function_836aeb74( 1.5 );
        }
    }

    // Namespace namespace_744b99c/doa_wild
    // Params 5
    // Checksum 0xe794c211, Offset: 0x1c90
    // Size: 0x11c
    function function_39d2eb74( loc, var_c9d9522c, chance, count, permanent )
    {
        loc.script_noteworthy = var_c9d9522c;
        loc.chance = chance;
        loc.count = count;
        loc.permanent = permanent;
        loc.activated = 0;
        loc.totalspawned = 0;
        loc.var_82725140 = 0;
        loc.canspawn = randomint( 100 ) < loc.chance;
        
        if ( !isdefined( var_7c1b05a1 ) )
        {
            var_7c1b05a1 = [];
        }
        else if ( !isarray( var_7c1b05a1 ) )
        {
            var_7c1b05a1 = array( var_7c1b05a1 );
        }
        
        var_7c1b05a1[ var_7c1b05a1.size ] = loc;
    }

    // Namespace namespace_744b99c/doa_wild
    // Params 0
    // Checksum 0x44605e6f, Offset: 0x1e78
    // Size: 0xa
    function function_39f259cc()
    {
        return var_9d4c1dcc;
    }

    // Namespace namespace_744b99c/doa_wild
    // Params 1
    // Checksum 0x6d4a3408, Offset: 0x1f28
    // Size: 0x98
    function function_40ee47dc( section )
    {
        self notify( "7aed761cdcf6c927" );
        self endon( "7aed761cdcf6c927" );
        teleporter = function_5acbc98e( section );
        
        if ( !isdefined( teleporter ) )
        {
            return;
        }
        
        teleporter endon( #"death" );
        teleporter.trigger waittill( #"trigger" );
        level notify( #"hash_7626a6770055d63c" );
    }

    // Namespace namespace_744b99c/doa_wild
    // Params 1
    // Checksum 0xe4430191, Offset: 0x5e0
    // Size: 0x61a
    function initialize( var_96c645bc )
    {
        m_center = var_96c645bc;
        m_name = var_96c645bc.script_noteworthy;
        var_be31d6d6 = int( var_96c645bc.script_int );
        assert( isdefined( m_name ) && isdefined( var_be31d6d6 ), "<dev string:x38>" );
        
        if ( isdefined( var_96c645bc.script_parameters ) )
        {
            params = strtok( var_96c645bc.script_parameters, ";" );
            
            if ( params.size > 0 )
            {
                var_c1958f8c = int( params[ 0 ] );
            }
            
            if ( params.size > 1 )
            {
                var_9d4c1dcc = int( params[ 1 ] );
            }
        }
        
        var_9c618072 = [];
        starts = struct::get_array( m_name + "_wild_player_start" );
        
        foreach ( loc in starts )
        {
            var_4768c05f = int( loc.script_int );
            loc.var_d1fc07a7 = var_4768c05f;
            
            if ( !isdefined( var_9c618072[ loc.var_d1fc07a7 ] ) )
            {
                var_9c618072[ loc.var_d1fc07a7 ] = [];
            }
            
            var_9c618072[ loc.var_d1fc07a7 ][ var_9c618072[ loc.var_d1fc07a7 ].size ] = loc;
        }
        
        for ( i = 0; i < var_9c618072.size ; i++ )
        {
            assert( var_9c618072[ i ].size >= 4, "<dev string:x5c>" );
        }
        
        var_a04d7049 = struct::get_array( m_name + "_wild_exit" );
        assert( var_a04d7049.size > 0, "<dev string:x83>" + m_name );
        var_6c9ec3e8 = 0;
        var_a1fa7529 = arraycombine( getentarray( m_name + "_wild_hazard", "targetname" ), struct::get_array( m_name + "_wild_hazard", "targetname" ) );
        var_a26d9c0d = getentarray( m_name + "_wild_forced_zone", "targetname" );
        var_2a0f52f3 = struct::get_array( m_name + "_wild_dungeons" );
        
        foreach ( dungeon in var_2a0f52f3 )
        {
            params = strtok( dungeon.script_parameters, ";" );
            assert( params.size == 7, "<dev string:xa5>" + m_name + "<dev string:xd5>" );
            dungeon.name = params[ 0 ];
            dungeon.type = params[ 1 ];
            dungeon.var_c9569a5c = params[ 2 ];
            dungeon.var_27264bb4 = params[ 3 ];
            dungeon.var_a69f4ab4 = params[ 4 ];
            dungeon.var_efa6dcc2 = params[ 5 ];
            dungeon.var_7efce95 = params[ 6 ];
            dungeon.var_93ed3009 = struct::get_array( dungeon.name + "_dungeon_player_exits" );
            assert( dungeon.var_93ed3009.size >= 4, "<dev string:x5c>" );
        }
        
        var_7c1b05a1 = struct::get_array( m_name + "_wild_object" );
        var_c7395a06 = struct::get_array( m_name + "_wild_npc" );
        var_e2a6dd61 = getentarray( m_name + "_wild_camera_tweak", "targetname" );
        var_3fe6d9f7 = getentarray( m_name + "_wild_room", "targetname" );
    }

    // Namespace namespace_744b99c/doa_wild
    // Params 0
    // Checksum 0x1cd68f17, Offset: 0xe08
    // Size: 0x84
    function function_464d882c()
    {
        foreach ( hazard in var_a1fa7529 )
        {
            hazard notify( #"destroy_hazard" );
        }
    }

    // Namespace namespace_744b99c/doa_wild
    // Params 2
    // Checksum 0xb00f5259, Offset: 0x2138
    // Size: 0xbe
    function function_4774f263( type, player )
    {
        self notify( "20671a3cb1012c15" );
        self endon( "20671a3cb1012c15" );
        self endon( #"death" );
        player endon( #"disconnect" );
        player clientfield::set_to_player( type, 32 - 1 );
        
        while ( player istouching( self ) )
        {
            waitframe( 1 );
        }
        
        player clientfield::set_to_player( type, 0 );
        player.tweakcam = undefined;
    }

    // Namespace namespace_744b99c/doa_wild
    // Params 1
    // Checksum 0xa0fd8370, Offset: 0x1e90
    // Size: 0x4e
    function function_5acbc98e( section = self.var_6c9ec3e8 )
    {
        if ( section >= 0 && section < var_45e27b4f.size )
        {
            return var_45e27b4f[ section ];
        }
    }

    // Namespace namespace_744b99c/doa_wild
    // Params 1
    // Checksum 0xa0bdf8f6, Offset: 0x1dd0
    // Size: 0x58
    function function_5dfb6d67( section = 0 )
    {
        assert( section >= 0 && section < var_9c618072.size );
        return var_9c618072[ section ];
    }

    // Namespace namespace_744b99c/doa_wild
    // Params 0
    // Checksum 0xb453155, Offset: 0x1e48
    // Size: 0xa
    function getid()
    {
        return var_be31d6d6;
    }

    // Namespace namespace_744b99c/doa_wild
    // Params 0
    // Checksum 0xfe8a86c, Offset: 0x20f8
    // Size: 0x34
    function function_82fd5391()
    {
        self waittill( #"deactivate" );
        self triggerenable( 0 );
    }

    // Namespace namespace_744b99c/doa_wild
    // Params 1
    // Checksum 0x857da72f, Offset: 0xc08
    // Size: 0xc2
    function function_87f950c1( type )
    {
        if ( !isdefined( type ) )
        {
            return var_a1fa7529;
        }
        
        var_f9c9c0 = [];
        
        foreach ( hazard in var_a1fa7529 )
        {
            if ( hazard.script_noteworthy === type )
            {
                var_f9c9c0[ var_f9c9c0.size ] = hazard;
            }
        }
        
        return var_f9c9c0;
    }

    // Namespace namespace_744b99c/doa_wild
    // Params 0
    // Checksum 0xd577cb0, Offset: 0xcd8
    // Size: 0x124
    function function_90de0b96()
    {
        level thread namespace_268747c0::function_3874b272( "explo_barrel" );
        level thread namespace_268747c0::function_3874b272( "killbox" );
        level thread namespace_268747c0::function_3874b272( "killzone" );
        level thread namespace_268747c0::function_3874b272( "pungi" );
        level thread namespace_268747c0::function_3874b272( "elec_pole" );
        level thread namespace_268747c0::function_3874b272( "flogger" );
        level thread namespace_268747c0::function_3874b272( "logdrop" );
        level thread namespace_268747c0::function_3874b272( "dragonhead" );
        level thread namespace_268747c0::function_3874b272( "fireball" );
    }

    // Namespace namespace_744b99c/doa_wild
    // Params 0
    // Checksum 0x5182eaaf, Offset: 0x2300
    // Size: 0x34
    function function_9b22d331()
    {
        self waittill( #"deactivate" );
        self triggerenable( 0 );
    }

    // Namespace namespace_744b99c/doa_wild
    // Params 0
    // Checksum 0x56691ca7, Offset: 0x2340
    // Size: 0xf8
    function function_a7380338()
    {
        self endon( #"deactivate" );
        self triggerenable( 1 );
        self thread function_9b22d331();
        
        while ( true )
        {
            result = self waittill( #"trigger" );
            
            if ( isdefined( result.activator ) && !is_true( result.activator.laststand ) )
            {
                if ( is_true( result.activator.var_bb4d9604 ) )
                {
                    continue;
                }
                
                result.activator thread function_2c3a3e50( self );
            }
        }
    }

    // Namespace namespace_744b99c/doa_wild
    // Params 0
    // Checksum 0x5b841cbb, Offset: 0x1db8
    // Size: 0xa
    function function_a9d5a03d()
    {
        return var_c7395a06;
    }

    // Namespace namespace_744b99c/doa_wild
    // Params 0
    // Checksum 0x60edb1ac, Offset: 0x1898
    // Size: 0x3be
    function deactivate()
    {
        objective_setstate( 15, "invisible" );
        function_464d882c();
        
        foreach ( zone in var_a26d9c0d )
        {
            if ( isdefined( zone ) )
            {
                zone notify( #"deactivate" );
            }
        }
        
        foreach ( var_f0ce243e in var_e2a6dd61 )
        {
            if ( isdefined( var_f0ce243e ) )
            {
                var_f0ce243e notify( #"deactivate" );
            }
        }
        
        foreach ( dungeon in var_2a0f52f3 )
        {
            if ( isdefined( dungeon.trigger ) )
            {
                dungeon.trigger delete();
            }
        }
        
        foreach ( exit in var_45e27b4f )
        {
            if ( isdefined( exit.trigger ) )
            {
                exit.trigger delete();
            }
            
            if ( isdefined( exit ) )
            {
                exit delete();
            }
        }
        
        var_45e27b4f = [];
        var_6c9ec3e8 = 0;
        
        foreach ( npc in var_c7395a06 )
        {
            npc.activated = 0;
        }
        
        foreach ( room in var_3fe6d9f7 )
        {
            if ( isdefined( room ) )
            {
                room notify( #"deactivate" );
            }
        }
        
        self notify( #"deactivated" );
    }

    // Namespace namespace_744b99c/doa_wild
    // Params 1
    // Checksum 0x94fbcbc2, Offset: 0xe98
    // Size: 0x9f4
    function activate( section = 0 )
    {
        level.doa.var_8dc464fe = gettime();
        
        foreach ( dungeon in var_2a0f52f3 )
        {
            dungeon.trigger = namespace_ec06fe4a::spawntrigger( "trigger_box", dungeon.origin, 2, dungeon.var_27264bb4, dungeon.var_efa6dcc2, dungeon.var_a69f4ab4 );
        }
        
        if ( !isdefined( section ) )
        {
            section = 0;
        }
        
        org = function_5dfb6d67( section )[ 0 ];
        namespace_ec06fe4a::function_87612422( org.origin, org.angles );
        var_45e27b4f = [];
        i = 0;
        
        foreach ( exit in var_a04d7049 )
        {
            var_b458883a = namespace_ec06fe4a::spawnmodel( exit.origin, "zombietron_teleporter" );
            
            if ( isdefined( var_b458883a ) )
            {
                var_b458883a.var_d1fc07a7 = i;
                var_45e27b4f[ var_45e27b4f.size ] = var_b458883a;
                var_b458883a namespace_83eb6304::function_3ecfde67( "teleporter_dungeon_light" );
                var_b458883a clientfield::set( "set_icon", 1 );
                var_b458883a setmodel( "zombietron_teleporter" );
                var_b458883a setmovingplatformenabled( 1 );
                var_b458883a thread namespace_ec06fe4a::function_f506b4c7();
                var_b458883a.trigger = namespace_ec06fe4a::spawntrigger( "trigger_radius", var_b458883a.origin, 0, 40, 80 );
            }
        }
        
        function_20212fba( section );
        
        if ( section < var_45e27b4f.size && isdefined( var_45e27b4f[ section ] ) )
        {
            objective_onentity( 15, var_45e27b4f[ section ] );
            objective_setstate( 15, "active" );
        }
        
        function_90de0b96();
        
        foreach ( zone in var_a26d9c0d )
        {
            zone thread function_a7380338();
        }
        
        foreach ( loc in var_7c1b05a1 )
        {
            loc.chance = 100;
            
            if ( isdefined( loc.script_parameters ) )
            {
                args = strtok( loc.script_parameters, ";" );
                
                if ( args.size >= 1 )
                {
                    loc.chance = int( args[ 0 ] );
                }
            }
            
            if ( loc.script_noteworthy === "zombietron_skeleton_key" )
            {
                loc.chance -= 25 * level.doa.var_be74bf2c;
                
                if ( loc.chance < 1 )
                {
                    loc.chance = 1;
                }
            }
            
            loc.canspawn = randomint( 100 ) < loc.chance;
            loc.count = isdefined( loc.script_int ) ? int( loc.script_int ) : 1;
            loc.activated = 0;
            loc.totalspawned = 0;
            loc.var_82725140 = 0;
            loc.permanent = 0;
            
            if ( isdefined( loc.script_noteworthy ) && issubstr( loc.script_noteworthy, "world_" ) )
            {
                loc.permanent = 1;
            }
        }
        
        foreach ( npc in var_c7395a06 )
        {
            npc.activated = 0;
            npc.permanent = 0;
            npc.chance = 100;
            assert( isdefined( npc.script_parameters ) );
            
            if ( isdefined( npc.script_parameters ) && isdefined( "wild_npc requires script_parameters <type>,[chance],[radius],[permanent],[boss]" ) )
            {
                args = strtok( npc.script_parameters, ";" );
                assert( args.size > 0, "<dev string:xe7>" );
                
                if ( args.size >= 1 )
                {
                    npc.type = args[ 0 ];
                }
                
                if ( args.size >= 2 )
                {
                    npc.chance = int( args[ 0 ] );
                }
                
                if ( args.size >= 3 )
                {
                    npc.radius = int( args[ 1 ] );
                }
                
                if ( args.size >= 4 )
                {
                    npc.permanent = int( args[ 2 ] ) ? 1 : 0;
                }
                
                if ( args.size >= 5 )
                {
                    npc.boss = int( args[ 3 ] ) ? 1 : 0;
                }
            }
            
            npc.canspawn = randomint( 100 ) < npc.chance;
            npc.count = isdefined( npc.script_int ) ? int( npc.script_int ) : 1;
            level notify( #"hash_62332fcf2ebc16d1" );
        }
        
        foreach ( var_f0ce243e in var_e2a6dd61 )
        {
            var_f0ce243e thread function_e7bbc8d1();
        }
        
        foreach ( room in var_3fe6d9f7 )
        {
            room thread function_33300d38();
        }
        
        while ( !loadnavvolume( m_name ) )
        {
            waitframe( 1 );
        }
        
        if ( !isnavvolumeloaded() )
        {
            var_a82c51e1 = 1;
        }
        
        level thread doa_wild::function_e8146c4c();
    }

    // Namespace namespace_744b99c/doa_wild
    // Params 0
    // Checksum 0x3b2be78b, Offset: 0x1c60
    // Size: 0xc
    function getnumsections()
    {
        return var_9c618072.size;
    }

    // Namespace namespace_744b99c/doa_wild
    // Params 0
    // Checksum 0x30d5fb1c, Offset: 0x2060
    // Size: 0x90
    function function_ce6bb21b()
    {
        foreach ( exit in var_45e27b4f )
        {
            exit clientfield::set( "set_icon", 1 );
        }
    }

    // Namespace namespace_744b99c/doa_wild
    // Params 0
    // Checksum 0xf6fe3d82, Offset: 0x1c78
    // Size: 0xa
    function function_d9ad5c49()
    {
        return var_7c1b05a1;
    }

    // Namespace namespace_744b99c/doa_wild
    // Params 0
    // Checksum 0x40ea58ff, Offset: 0x2200
    // Size: 0xf8
    function function_e7bbc8d1()
    {
        self endon( #"deactivate" );
        self triggerenable( 1 );
        self thread function_82fd5391();
        type = isdefined( script_noteworthy ) ? script_noteworthy : "setCameraDown";
        
        while ( true )
        {
            result = self waittill( #"trigger" );
            
            if ( !isdefined( result.activator.tweakcam ) )
            {
                result.activator.tweakcam = self;
                self thread function_4774f263( type, result.activator );
            }
        }
    }

}

// Namespace doa_wild/doa_wild
// Params 0
// Checksum 0x4f731814, Offset: 0x2e18
// Size: 0x2b8
function init()
{
    objective_add( 15, "invisible", ( 0, 0, 0 ), #"hash_712c19ea98a115ee" );
    objective_add( 15 + 1, "invisible", ( 0, 0, 0 ), #"hash_93a5b32fcbc4d3c" );
    var_581c8f9a = struct::get_array( "doa_wild" );
    level.doa.var_d7dbacba = [];
    
    foreach ( wild in var_581c8f9a )
    {
        var_3d2cc936 = new class_744b99c();
        [[ var_3d2cc936 ]]->initialize( wild );
        level.doa.var_d7dbacba[ level.doa.var_d7dbacba.size ] = var_3d2cc936;
        var_663588d = "Zombietron/Wilds/";
        sections = [[ var_3d2cc936 ]]->getnumsections();
        
        if ( sections > 1 )
        {
            for ( i = 0; i < sections ; i++ )
            {
                cmdline = "scr_wild_activate " + [[ var_3d2cc936 ]]->getname() + "@" + i + "; zombie_devgui wild";
                util::add_devgui( var_663588d + [[ var_3d2cc936 ]]->getname() + "    Section " + i + 1 + ":" + [[ var_3d2cc936 ]]->getid(), cmdline );
            }
            
            continue;
        }
        
        cmdline = "scr_wild_activate " + [[ var_3d2cc936 ]]->getname() + "; zombie_devgui wild";
        util::add_devgui( var_663588d + [[ var_3d2cc936 ]]->getname() + ":" + [[ var_3d2cc936 ]]->getid(), cmdline );
    }
}

// Namespace doa_wild/doa_wild
// Params 0
// Checksum 0x72b7978e, Offset: 0x30d8
// Size: 0x12e
function main()
{
    level endon( #"game_over" );
    level waittill( #"hash_671684f03a58b3a3" );
    
    foreach ( wild in level.doa.var_d7dbacba )
    {
        [[ wild ]]->deactivate();
    }
    
    level namespace_c85a46fe::function_edfcfa44();
    objective_setstate( 15, "invisible" );
    objective_setstate( 15 + 1, "invisible" );
    level.doa.var_8dc464fe = undefined;
}

// Namespace doa_wild/doa_wild
// Params 1
// Checksum 0xd73e7065, Offset: 0x3210
// Size: 0x9c
function function_e5e987ae( name )
{
    level.doa.var_e15152e6 = undefined;
    level.doa.var_baeb966b = undefined;
    
    if ( !isdefined( name ) )
    {
        return;
    }
    
    if ( level.doa.var_6c58d51 > getdvarint( #"hash_2743236aa9857bee", 0 ) )
    {
        return;
    }
    
    wild = function_d5e7454f( name );
    
    if ( !isdefined( wild ) )
    {
        return;
    }
    
    return wild;
}

// Namespace doa_wild/doa_wild
// Params 2
// Checksum 0xecbf5ed7, Offset: 0x32b8
// Size: 0x600
function function_7c5bc025( name, section )
{
    if ( isdefined( level.doa.var_a77e6349 ) )
    {
        [[ level.doa.var_a77e6349 ]]->deactivate();
        level namespace_c85a46fe::function_edfcfa44();
    }
    
    level.doa.var_a77e6349 = function_d5e7454f( name );
    assert( isdefined( level.doa.var_a77e6349 ), "<dev string:x1b5>" + name );
    namespace_8c04284b::function_a70ff03e( [[ level.doa.var_a77e6349 ]]->function_31ca9ed1() );
    level util::set_lighting_state( [[ level.doa.var_a77e6349 ]]->function_39f259cc() );
    level doa_banner::function_7a0e5387();
    namespace_4dae815d::function_21cd3890( 4 );
    level notify( #"hash_77a8f97f2648672", { #name:name, #section:section } );
    level.doa.var_3902985f = &function_c6dcd966;
    level.doa.var_a71b0305 = &function_a1832a08;
    level thread function_715ea8aa( level.doa.var_a77e6349 );
    level thread function_3efbdeb3( level.doa.var_a77e6349 );
    [[ level.doa.var_a77e6349 ]]->activate( section );
    starts = [[ level.doa.var_a77e6349 ]]->function_5dfb6d67( section );
    players = namespace_7f5aeb59::function_23e1f90f();
    
    for ( i = 0; i < players.size ; i++ )
    {
        spot = starts[ i ];
        players[ i ] setorigin( spot.origin );
        players[ i ] setplayerangles( spot.angles );
    }
    
    level namespace_7f5aeb59::function_d0251f76( 0 );
    level thread namespace_c85a46fe::function_782e605e( name );
    level thread namespace_7f5aeb59::function_836aeb74( 2 );
    level waittill( #"hash_58caf0ade03043bb" );
    level doa_banner::function_7a0e5387( 6 );
    
    if ( isdefined( level.doa.var_6b57e2f ) )
    {
        level thread [[ level.doa.var_6b57e2f ]]( name );
    }
    
    result = level waittill( #"hash_7626a6770055d63c", #"game_over" );
    
    if ( result._notify != "game_over" )
    {
        level namespace_c85a46fe::function_edfcfa44();
        namespace_ec06fe4a::function_de70888a();
        banner = isdefined( result.banner ) ? result.banner : 7;
        level doa_banner::function_7a0e5387( banner );
        wait 3.5;
        
        foreach ( player in namespace_7f5aeb59::function_23e1f90f() )
        {
            player namespace_7f5aeb59::turnplayershieldon();
        }
        
        level thread namespace_7f5aeb59::function_67f054d7( 1.5 );
        level doa_banner::function_7a0e5387();
    }
    
    level waittill( #"hash_1b322de3d2e3e781" );
    [[ level.doa.var_a77e6349 ]]->deactivate();
    level namespace_c85a46fe::function_edfcfa44();
    namespace_491fa2b2::function_df55eb9d( 0 );
    namespace_dfc652ee::function_19fa261e();
    namespace_ec06fe4a::function_de70888a();
    level.doa.var_2bc99c8d = [];
    level.doa.var_a77e6349 = undefined;
    level.doa.var_3902985f = undefined;
    level.doa.var_a71b0305 = undefined;
    level notify( #"hash_325440d5433be263" );
}

// Namespace doa_wild/doa_wild
// Params 1
// Checksum 0x23792506, Offset: 0x38c0
// Size: 0xa2
function function_d5e7454f( name )
{
    foreach ( wild in level.doa.var_d7dbacba )
    {
        if ( [[ wild ]]->getname() === name )
        {
            return wild;
        }
    }
}

// Namespace doa_wild/doa_wild
// Params 1
// Checksum 0xaf99d919, Offset: 0x3970
// Size: 0x76
function function_c6dcd966( item )
{
    if ( isdefined( item.var_aa1b5d45 ) )
    {
        item.var_aa1b5d45.var_82725140++;
        item.var_aa1b5d45.canspawn = 0;
        
        if ( [[ item.def ]]->gettype() == 14 )
        {
            item.var_aa1b5d45.norespawn = 1;
        }
    }
}

// Namespace doa_wild/doa_wild
// Params 1
// Checksum 0xf2cc1e7b, Offset: 0x39f0
// Size: 0xba
function function_a1832a08( item )
{
    item.var_aa1b5d45 = level.doa.var_aa1b5d45;
    
    if ( isdefined( item.var_aa1b5d45 ) )
    {
        item notify( #"hash_2a866f50cc161ca8" );
        level.doa.var_aa1b5d45.pickups[ level.doa.var_aa1b5d45.pickups.size ] = item;
        level.doa.var_aa1b5d45.totalspawned = level.doa.var_aa1b5d45.pickups.size;
    }
}

// Namespace doa_wild/doa_wild
// Params 1
// Checksum 0x9cf5145f, Offset: 0x3ab8
// Size: 0x29a
function spawnitem( item )
{
    if ( is_true( item.activated ) )
    {
        return;
    }
    
    item.pickups = [];
    item.activated = 1;
    level.doa.var_aa1b5d45 = item;
    
    switch ( item.script_noteworthy )
    {
        case #"world_door":
            namespace_f63bdb08::function_2a1e5c1f( item.origin, item.angles, item.script_string, isdefined( item.script_int ) ? int( item.script_int ) : undefined, isdefined( item.script_objective ) ? int( item.script_objective ) : undefined, 1, item.script_parameters );
            break;
        case #"world_loot":
            namespace_41f5b853::spawnlootitem( item.origin, item.angles, item.script_string, item.radius, 1 );
            break;
        case #"treasure_blob":
            namespace_dfc652ee::function_68442ee7( item.origin, 20 );
            break;
        default:
            def = namespace_dfc652ee::function_6265bde4( item.script_noteworthy );
            
            if ( isdefined( def ) )
            {
                if ( [[ def ]]->gettype() == 13 )
                {
                    level namespace_dfc652ee::function_d06cbfe8( item.origin, item.count, 64, 1, def, 1 );
                }
                else
                {
                    level namespace_dfc652ee::function_83aea294( item.origin, item.count, 12, def, undefined, 1 );
                }
            }
            
            break;
    }
    
    if ( !item.permanent )
    {
        level thread function_612fa49c( item );
    }
    else
    {
        item.canspawn = 0;
    }
    
    level.doa.var_aa1b5d45 = undefined;
}

// Namespace doa_wild/doa_wild
// Params 2
// Checksum 0x8800d025, Offset: 0x3d60
// Size: 0x21a
function function_612fa49c( item, distance = 1600 )
{
    while ( item.activated && isdefined( level.doa.var_a77e6349 ) )
    {
        players = namespace_7f5aeb59::function_23e1f90f();
        active = 0;
        
        foreach ( player in players )
        {
            if ( distancesquared( item.origin, player.origin ) < sqr( distance ) )
            {
                active = 1;
                break;
            }
        }
        
        item.activated = active;
        wait 1;
    }
    
    remove = 1;
    
    if ( item.var_82725140 == 0 )
    {
        remove = 0;
    }
    
    if ( remove )
    {
        item.canspawn = 0;
    }
    
    arrayremovevalue( item.pickups, undefined );
    
    foreach ( pickup in item.pickups )
    {
        pickup delete();
    }
    
    item.pickups = [];
}

// Namespace doa_wild/doa_wild
// Params 1
// Checksum 0x25a4dbe0, Offset: 0x3f88
// Size: 0x232
function function_715ea8aa( wild )
{
    self notify( "199bae157000fe97" );
    self endon( "199bae157000fe97" );
    level endon( #"hash_325440d5433be263" );
    level.doa.var_2bc99c8d = [[ wild ]]->function_d9ad5c49();
    
    while ( true )
    {
        players = namespace_7f5aeb59::function_23e1f90f();
        items = [];
        
        foreach ( player in players )
        {
            items = arraycombine( items, arraysortclosest( level.doa.var_2bc99c8d, player.origin, undefined, 0, 1200 ) );
        }
        
        foreach ( item in items )
        {
            if ( is_true( item.activated ) )
            {
                continue;
            }
            
            if ( !is_true( item.canspawn ) )
            {
                continue;
            }
            
            if ( is_true( item.norespawn ) )
            {
                continue;
            }
            
            level spawnitem( item );
        }
        
        wait 1;
    }
}

// Namespace doa_wild/doa_wild
// Params 1
// Checksum 0x2d1f8a52, Offset: 0x41c8
// Size: 0x376
function function_904157ac( radius = 1024 )
{
    self endon( #"death" );
    baseorigin = self.origin;
    
    if ( isdefined( self.target ) )
    {
        base = struct::get( self.target );
        
        if ( isdefined( base ) )
        {
            baseorigin = base.origin;
        }
    }
    
    radiussq = sqr( radius );
    self.var_a84a3d40 = radiussq;
    self namespace_250e9486::function_49a5cb51( baseorigin, 2 * radius );
    self.var_2dc9f085 = 0;
    self.goalradius = 128;
    var_7603c769 = sqr( 128 );
    self namespace_250e9486::function_41354e51( baseorigin, 1 );
    self.var_101082d1 = randomint( 20 );
    var_92c9a6e = int( self.maxhealth * 0.02 );
    
    while ( true )
    {
        wait 1;
        time = gettime();
        self.var_4bd563dd = 0;
        
        if ( !isdefined( self.enemy ) )
        {
            if ( time < self.var_2dc9f085 + 5000 )
            {
                continue;
            }
            
            distsq = distancesquared( self.origin, baseorigin );
            
            if ( distsq <= var_7603c769 )
            {
                self namespace_250e9486::function_41354e51( self.origin, 1 );
                
                if ( self.health < self.maxhealth )
                {
                    self.health += var_92c9a6e;
                    
                    if ( self.health > self.maxhealth )
                    {
                        self.health = self.maxhealth;
                    }
                }
                
                self.var_101082d1--;
                
                if ( self.var_101082d1 > 0 )
                {
                    continue;
                }
            }
            
            distsq = distancesquared( self.origin, baseorigin );
            point = baseorigin;
            points = getrandomnavpoints( baseorigin, 64, 4 );
            
            if ( points.size )
            {
                point = points[ randomint( points.size ) ];
            }
            
            self.zombie_move_speed = "walk";
            self namespace_250e9486::function_41354e51( point, 1 );
            self waittill( #"goal", #"enemy" );
            self.var_101082d1 = randomint( 20 );
            continue;
        }
        
        self.var_2dc9f085 = time;
    }
}

// Namespace doa_wild/doa_wild
// Params 1
// Checksum 0x6b7001a, Offset: 0x4548
// Size: 0xba
function function_e5488243( npc )
{
    mode = "guard";
    
    if ( isdefined( npc.script_string ) )
    {
        mode = npc.script_string;
    }
    
    switch ( mode )
    {
        case #"none":
            return;
        case #"patrol":
            break;
        case #"guard":
        default:
            self thread function_904157ac( npc.radius );
            break;
    }
}

// Namespace doa_wild/doa_wild
// Params 0
// Checksum 0x215861ed, Offset: 0x4610
// Size: 0x1b0
function function_d81916f4()
{
    self notify( "14af182035701949" );
    self endon( "14af182035701949" );
    level endon( #"gameover" );
    
    while ( self.activated )
    {
        result = self waittill( #"hash_4c72e79bdad8315e" );
        namespace_1e25ad94::debugmsg( "ai_queue_spawned notify recieved for ent:" + result.ai getentitynumber() + " at: " + gettime() + " note typestamp:" + result.time );
        
        if ( isdefined( result.ai ) && !isinarray( self.enemylist, result.ai ) )
        {
            result.ai.boss = isdefined( self.boss ) ? self.boss : result.ai.boss;
            result.ai.script_noteworthy = self.script_noteworthy;
            self.enemylist[ self.enemylist.size ] = result.ai;
            self.count--;
            assert( self.count >= 0 );
            result.ai thread function_e5488243( self );
        }
    }
}

// Namespace doa_wild/doa_wild
// Params 1
// Checksum 0x25d6ee78, Offset: 0x47c8
// Size: 0x15e
function function_72405345( npc )
{
    profilestart();
    
    if ( isdefined( level.doa.var_182fb75a ) )
    {
        profilestop();
        return;
    }
    
    if ( is_true( npc.activated ) )
    {
        profilestop();
        return;
    }
    
    if ( npc.count <= 0 )
    {
        profilestop();
        return;
    }
    
    npc.enemylist = [];
    npc.activated = 1;
    
    if ( !isdefined( npc.spawndef ) )
    {
        npc.spawndef = doa_enemy::function_d7c5adee( npc.type );
    }
    
    npc thread function_d81916f4();
    radius = 0;
    
    if ( npc.count > 1 )
    {
        radius = 30;
    }
    
    doa_enemy::function_a6b807ea( npc.spawndef, npc.count, npc.origin, radius, undefined, undefined, npc );
    
    if ( !npc.permanent )
    {
        level thread function_7d406bae( npc );
    }
    else
    {
        arrayremovevalue( level.doa.var_95cc492a, npc );
    }
    
    profilestop();
}

// Namespace doa_wild/doa_wild
// Params 2
// Checksum 0x7b39b311, Offset: 0x4930
// Size: 0x2dc
function function_7d406bae( npc, distance = 2400 )
{
    while ( npc.activated && isdefined( level.doa.var_a77e6349 ) )
    {
        players = namespace_7f5aeb59::function_23e1f90f();
        active = 0;
        
        foreach ( player in players )
        {
            if ( distancesquared( npc.origin, player.origin ) < sqr( distance ) )
            {
                active = 1;
                break;
            }
        }
        
        npc.activated = active;
        wait 1;
    }
    
    items = doa_enemy::function_924423d( npc );
    unspawned = 0;
    
    foreach ( item in items )
    {
        unspawned += item.count;
    }
    
    arrayremovevalue( npc.enemylist, undefined );
    npc.count = npc.enemylist.size + unspawned;
    
    foreach ( guy in npc.enemylist )
    {
        guy thread namespace_ec06fe4a::function_52afe5df( 0.1 );
    }
    
    npc.enemylist = [];
    
    if ( npc.count <= 0 )
    {
        arrayremovevalue( level.doa.var_95cc492a, npc );
    }
}

// Namespace doa_wild/doa_wild
// Params 1
// Checksum 0x2ee271e5, Offset: 0x4c18
// Size: 0x22a
function function_3efbdeb3( wild )
{
    self notify( "7a9fa7c382eabb8f" );
    self endon( "7a9fa7c382eabb8f" );
    level endon( #"hash_325440d5433be263" );
    level endon( #"gameover" );
    level.doa.var_95cc492a = [[ wild ]]->function_a9d5a03d();
    
    while ( true )
    {
        players = namespace_7f5aeb59::function_23e1f90f();
        npcs = [];
        
        foreach ( player in players )
        {
            npcs = arraycombine( npcs, arraysortclosest( level.doa.var_95cc492a, player.origin, undefined, 0, 2000 ) );
        }
        
        foreach ( npc in npcs )
        {
            if ( is_true( npc.activated ) )
            {
                continue;
            }
            
            if ( !is_true( npc.canspawn ) )
            {
                continue;
            }
            
            level function_72405345( npc );
        }
        
        wait 1;
    }
}

// Namespace doa_wild/doa_wild
// Params 0
// Checksum 0xfebdec57, Offset: 0x4e50
// Size: 0xa0
function function_e8146c4c()
{
    wait 5;
    
    foreach ( player in getplayers() )
    {
        player namespace_6e90e490::showhint( 11 );
    }
}

