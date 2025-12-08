#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_36fc02e86719d0f5;
#using script_3faf478d5b0850fe;
#using script_40f967ad5d18ea74;
#using script_413ab8fe25a61c50;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_5133d88c555e460;
#using script_5549681e1669c11a;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_634ae70c663d1cc9;
#using script_74a56359b7d02ab6;
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

#namespace namespace_8c04284b;

// Namespace namespace_8c04284b
// Method(s) 59 Total 59
class class_f4bf8a8
{

    var m_center;
    var m_name;
    var maxs;
    var origin;
    var script_int;
    var script_noteworthy;
    var script_parameters;
    var tweakcam;
    var var_24df6bfb;
    var var_2e06f9d4;
    var var_35760f46;
    var var_36f9408;
    var var_486c1553;
    var var_5479b5f3;
    var var_5d3a1;
    var var_5e72455f;
    var var_622da539;
    var var_63f7cb8f;
    var var_694b395b;
    var var_73ab8b47;
    var var_73c16a24;
    var var_79baa471;
    var var_7c7691d6;
    var var_80292cd;
    var var_81e9b5ca;
    var var_9cd25248;
    var var_a1fa7529;
    var var_b198ac5a;
    var var_b60ab5fd;
    var var_be31d6d6;
    var var_bedb7d90;
    var var_c83ce53f;
    var var_cb3e8eba;
    var var_e2a6dd61;

    // Namespace class_f4bf8a8/namespace_8c04284b
    // Params 0, eflags: 0x8
    // Checksum 0xb57c4c00, Offset: 0xbe0
    // Size: 0x9e
    constructor()
    {
        var_81e9b5ca = [];
        var_c83ce53f = [];
        var_73ab8b47 = [];
        var_486c1553 = undefined;
        var_622da539 = undefined;
        var_9cd25248 = undefined;
        var_2e06f9d4 = 1;
        var_24df6bfb = 40;
        var_e2a6dd61 = [];
        var_5d3a1 = [];
        var_bedb7d90 = 5;
        var_5e72455f = 10;
        var_35760f46 = 0;
    }

    // Namespace class_f4bf8a8/namespace_8c04284b
    // Params 0, eflags: 0x10
    // Checksum 0xa15b1942, Offset: 0xc88
    // Size: 0x98
    destructor()
    {
        foreach ( exit in var_b198ac5a )
        {
            if ( isdefined( exit.fakemodel ) )
            {
                exit.fakemodel delete();
            }
        }
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 0
    // Checksum 0xd7b8f61a, Offset: 0x1688
    // Size: 0x12
    function function_ffcf1d1()
    {
        return m_center.origin;
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 0
    // Checksum 0x3eb67d3c, Offset: 0x19d0
    // Size: 0xa
    function function_14b480d1()
    {
        return var_622da539;
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 0
    // Checksum 0xb01b52e8, Offset: 0x18f8
    // Size: 0xa
    function ispaused()
    {
        return var_7c7691d6;
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 1
    // Checksum 0xb7c877dc, Offset: 0x2b98
    // Size: 0xa0
    function function_20b2a1e4( mask )
    {
        self endon( #"deactivate" );
        
        while ( true )
        {
            if ( level.doa.var_ecff3871 )
            {
                self triggerenable( ( mask & 2 ) != 0 );
            }
            else
            {
                self triggerenable( ( mask & 1 ) != 0 );
            }
            
            level waittill( #"hash_180d4d3b6b7ea3f3" );
        }
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 1
    // Checksum 0xbeedae9, Offset: 0x3378
    // Size: 0x1a
    function function_20b4ef55( side )
    {
        return var_5d3a1[ side ].size;
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 1
    // Checksum 0x8bd6e51b, Offset: 0x1838
    // Size: 0x7a
    function function_21d1be3d( side )
    {
        assert( isdefined( var_63f7cb8f[ side ] ), "<dev string:x97>" + side + "<dev string:xb3>" + m_name );
        return var_63f7cb8f[ side ][ randomint( var_63f7cb8f[ side ].size ) ];
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 2
    // Checksum 0xd7205fcf, Offset: 0x1788
    // Size: 0xa2
    function function_23476287( idx, side )
    {
        assert( isdefined( var_73c16a24[ side ] ), "<dev string:x97>" + side + "<dev string:xb3>" + m_name );
        assert( idx < var_73c16a24.size, "<dev string:xc9>" + side + "<dev string:xf4>" + m_name );
        return var_73c16a24[ side ][ idx ];
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 1
    // Checksum 0x877a31d4, Offset: 0x1d80
    // Size: 0xc2
    function function_242886d5( type )
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

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 1
    // Checksum 0x527b97ab, Offset: 0x3228
    // Size: 0xc6
    function function_25962665( wave )
    {
        if ( !isdefined( var_5d3a1[ wave.spawn_side ] ) )
        {
            var_5d3a1[ wave.spawn_side ] = [];
        }
        else if ( !isarray( var_5d3a1[ wave.spawn_side ] ) )
        {
            var_5d3a1[ wave.spawn_side ] = array( var_5d3a1[ wave.spawn_side ] );
        }
        
        var_5d3a1[ wave.spawn_side ][ var_5d3a1[ wave.spawn_side ].size ] = wave;
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 0
    // Checksum 0x2f9f767a, Offset: 0x1640
    // Size: 0xa
    function getname()
    {
        return m_name;
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 0
    // Checksum 0x2afa0a1e, Offset: 0x1670
    // Size: 0xa
    function getcenter()
    {
        return m_center;
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 0
    // Checksum 0x2f5818c2, Offset: 0x16e0
    // Size: 0xa
    function function_3476ff6d()
    {
        return var_79baa471;
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 0
    // Checksum 0x5ccd207, Offset: 0x1960
    // Size: 0xa
    function function_3bf5b85d()
    {
        return var_486c1553;
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 1
    // Checksum 0xdd7223ff, Offset: 0x19e8
    // Size: 0x1a
    function function_3e91f789( val )
    {
        var_9cd25248 = val;
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 2
    // Checksum 0x787d4f47, Offset: 0xd28
    // Size: 0x90c
    function initialize( arena_struct, index )
    {
        m_center = arena_struct;
        m_name = arena_struct.script_noteworthy;
        var_be31d6d6 = index;
        var_b60ab5fd = struct::get_array( m_name + "_safe_spot", "targetname" );
        var_79baa471 = struct::get_array( m_name + "_rise_spot", "targetname" );
        var_5479b5f3 = struct::get_array( m_name + "_pickup", "targetname" );
        var_a1fa7529 = struct::get_array( m_name + "_hazard", "targetname" );
        var_80292cd = struct::get_array( m_name + "_player_spawnpoint", "targetname" );
        var_73ab8b47 = struct::get_array( m_name + "_silverback_spawn", "targetname" );
        var_b198ac5a = [];
        exits = getentarray( m_name + "_doa_exit", "targetname" );
        objectiveid = 10;
        var_c83ce53f = struct::get_array( m_name + "_wild_spot", "targetname" );
        var_e2a6dd61 = getentarray( m_name + "_camera_tweak", "targetname" );
        
        foreach ( exit in exits )
        {
            exit.objectiveid = objectiveid;
            objectiveid++;
            assert( !isdefined( var_b198ac5a[ exit.script_noteworthy ] ), "<dev string:x38>" );
            var_b198ac5a[ exit.script_noteworthy ] = exit;
        }
        
        assert( var_b198ac5a.size == 4, "<dev string:x53>" );
        var_63f7cb8f = [];
        var_63f7cb8f[ #"bottom" ] = struct::get_array( m_name + "_enemy_spawn_bottom", "targetname" );
        var_63f7cb8f[ #"left" ] = struct::get_array( m_name + "_enemy_spawn_left", "targetname" );
        var_63f7cb8f[ #"top" ] = struct::get_array( m_name + "_enemy_spawn_top", "targetname" );
        var_63f7cb8f[ #"right" ] = struct::get_array( m_name + "_enemy_spawn_right", "targetname" );
        var_73c16a24 = [];
        var_73c16a24[ #"bottom" ] = struct::get_array( m_name + "_exit_start_bottom", "targetname" );
        var_73c16a24[ #"left" ] = struct::get_array( m_name + "_exit_start_left", "targetname" );
        var_73c16a24[ #"top" ] = struct::get_array( m_name + "_exit_start_top", "targetname" );
        var_73c16a24[ #"right" ] = struct::get_array( m_name + "_exit_start_right", "targetname" );
        var_36f9408 = [];
        var_36f9408[ #"bottom" ] = getent( m_name + "_blocker_bottom", "targetname" );
        var_36f9408[ #"left" ] = getent( m_name + "_blocker_left", "targetname" );
        var_36f9408[ #"top" ] = getent( m_name + "_blocker_top", "targetname" );
        var_36f9408[ #"right" ] = getent( m_name + "_blocker_right", "targetname" );
        var_36f9408[ #"bottom" ].var_e603ff2c = var_36f9408[ #"bottom" ].origin;
        var_36f9408[ #"left" ].var_e603ff2c = var_36f9408[ #"left" ].origin;
        var_36f9408[ #"top" ].var_e603ff2c = var_36f9408[ #"top" ].origin;
        var_36f9408[ #"right" ].var_e603ff2c = var_36f9408[ #"right" ].origin;
        var_36f9408[ #"bottom" ].side = "bottom";
        var_36f9408[ #"left" ].side = "left";
        var_36f9408[ #"top" ].side = "top";
        var_36f9408[ #"right" ].side = "right";
        var_5d3a1[ #"top" ] = [];
        var_5d3a1[ #"bottom" ] = [];
        var_5d3a1[ #"left" ] = [];
        var_5d3a1[ #"right" ] = [];
        var_694b395b = getent( m_name + "_safezone", "targetname" );
        var_cb3e8eba = getentarray( m_name + "_doa_exit", "targetname" );
        var_7c7691d6 = 0;
        deactivate();
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 0
    // Checksum 0x87b812ba, Offset: 0x1f50
    // Size: 0x84
    function function_464d882c()
    {
        foreach ( hazard in var_a1fa7529 )
        {
            hazard notify( #"destroy_hazard" );
        }
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 4
    // Checksum 0xe919d003, Offset: 0x2788
    // Size: 0x20e
    function function_4774f263( type, trigger, var_6a1dbbf3 = 0, var_fe263624 = 0 )
    {
        self notify( "19ed541b45b78537" );
        self endon( "19ed541b45b78537" );
        self endon( #"disconnect" );
        var_6a1dbbf3 = int( var_6a1dbbf3 );
        var_425999f6 = int( var_fe263624 );
        maxamount = 32 - 1;
        var_753de10b = trigger.maxs[ var_6a1dbbf3 ];
        var_974c88c7 = maxs[ var_fe263624 ];
        
        while ( isdefined( trigger ) && self istouching( trigger ) && trigger istriggerenabled() )
        {
            dist = abs( trigger.origin[ var_fe263624 ] - origin[ var_fe263624 ] ) - var_974c88c7;
            amount = 1 - dist / var_753de10b;
            mapamount = int( mapfloat( 0, 1, 0, maxamount, amount ) );
            self clientfield::set_to_player( type, mapamount );
            util::wait_network_frame();
        }
        
        self clientfield::set_to_player( type, 0 );
        tweakcam = undefined;
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 1
    // Checksum 0x8da384d9, Offset: 0x1910
    // Size: 0x1a
    function setpaused( val )
    {
        var_7c7691d6 = val;
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 0
    // Checksum 0x9c030b3f, Offset: 0x1b18
    // Size: 0x4c
    function function_51dd0a59()
    {
        if ( !isdefined( var_c83ce53f ) || var_c83ce53f.size == 0 )
        {
            return;
        }
        
        return var_c83ce53f[ randomint( var_c83ce53f.size ) ];
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 0
    // Checksum 0x48f8f4, Offset: 0x1990
    // Size: 0xa
    function function_55916d40()
    {
        return var_35760f46;
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 0
    // Checksum 0x3e3f4286, Offset: 0x16a8
    // Size: 0x2c
    function function_59fc184c()
    {
        return var_79baa471[ randomint( var_79baa471.size ) ];
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 0
    // Checksum 0x4ef6664d, Offset: 0x1ce0
    // Size: 0x92
    function function_635991ca()
    {
        if ( var_73ab8b47.size )
        {
            return var_73ab8b47[ randomint( var_73ab8b47.size ) ];
        }
        
        sides = array( "top", "bottom", "left", "right" );
        return function_21d1be3d( sides[ randomint( sides.size ) ] );
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 0
    // Checksum 0xc1a88989, Offset: 0x1658
    // Size: 0xa
    function getid()
    {
        return var_be31d6d6;
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 1
    // Checksum 0xd412f9b3, Offset: 0x1a28
    // Size: 0x1a
    function function_68400720( val )
    {
        var_2e06f9d4 = val;
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 1
    // Checksum 0xa6bff7d3, Offset: 0x1a70
    // Size: 0x1a
    function function_6d5262dc( val )
    {
        var_24df6bfb = val;
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 3
    // Checksum 0xf8984169, Offset: 0x1c08
    // Size: 0xd0
    function function_70fb5745( nearby, min = 256, max = 512 )
    {
        if ( !isdefined( nearby ) )
        {
            return var_b60ab5fd[ randomint( var_b60ab5fd.size ) ];
        }
        
        spots = arraysortclosest( var_b60ab5fd, nearby, undefined, min, max );
        
        if ( spots.size > 0 )
        {
            return spots[ randomint( spots.size ) ];
        }
        
        return m_center;
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 1
    // Checksum 0xfb6837ab, Offset: 0x26b8
    // Size: 0x84
    function function_73ec120c( side )
    {
        var_36f9408[ side ].origin = var_36f9408[ side ].var_e603ff2c + ( 0, 0, -50000 );
        namespace_1e25ad94::debugmsg( "Moving blocker: " + side + " to origin " + var_36f9408[ side ].origin );
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 1
    // Checksum 0x9939f87, Offset: 0x19a8
    // Size: 0x1a
    function function_774497ee( var_49983302 )
    {
        var_622da539 = var_49983302;
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 0
    // Checksum 0xb3f780f9, Offset: 0x1b00
    // Size: 0xa
    function function_786b9d39()
    {
        return var_5e72455f;
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 0
    // Checksum 0x268fdc29, Offset: 0x2c40
    // Size: 0x162
    function function_7ce9bb97()
    {
        foreach ( exit in var_b198ac5a )
        {
            exit triggerenable( 0 );
            exit.enabled = 0;
            namespace_1e25ad94::debugmsg( "Disabling trigger: " + exit.script_noteworthy );
            objective_setstate( exit.objectiveid, "invisible" );
            namespace_1e25ad94::debugmsg( "Hiding Objective at exit: " + exit.script_noteworthy + " Objective ID: " + exit.objectiveid );
            
            if ( isdefined( exit.fakemodel ) )
            {
                exit.fakemodel namespace_83eb6304::turnofffx( "exit_fog_marker" );
            }
        }
        
        level notify( #"hash_69b4bed202ddfa69" );
        var_81e9b5ca = [];
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 0
    // Checksum 0x3914e97c, Offset: 0x1b98
    // Size: 0xa
    function function_8054e011()
    {
        return var_b60ab5fd;
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 0
    // Checksum 0xa2516c31, Offset: 0x2748
    // Size: 0x34
    function function_82fd5391()
    {
        self waittill( #"deactivate" );
        self triggerenable( 0 );
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 0
    // Checksum 0x926c8ae5, Offset: 0x1a10
    // Size: 0xa
    function function_8a7cec70()
    {
        return var_9cd25248;
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 0
    // Checksum 0xebde00c6, Offset: 0x2f30
    // Size: 0x1d0
    function function_8bca81f0()
    {
        self notify( "25daa083fe019ab3" );
        self endon( "25daa083fe019ab3" );
        level endon( #"hash_69b4bed202ddfa69" );
        wait 1;
        
        while ( true )
        {
            result = self waittilltimeout( 10, #"trigger" );
            
            if ( result._notify == #"timeout" )
            {
                continue;
            }
            
            if ( isbot( result.activator ) )
            {
                continue;
            }
            
            break;
        }
        
        namespace_1e25ad94::debugmsg( "Exit Taken Trigger: " + script_noteworthy );
        
        foreach ( player in namespace_7f5aeb59::function_23e1f90f() )
        {
            player notify( #"hash_279998c5df86c04d" );
            player thread namespace_7f5aeb59::turnplayershieldon();
        }
        
        result.activator notify( #"doa_exit_taken" );
        level notify( #"doa_exit_taken", { #activator:result.activator, #direction:script_noteworthy } );
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 0
    // Checksum 0x43a0c1de, Offset: 0x1e50
    // Size: 0xf4
    function function_90de0b96()
    {
        level thread namespace_268747c0::function_3874b272( "explo_barrel" );
        level thread namespace_268747c0::function_3874b272( "elec_pole", function_8a7cec70() );
        level thread namespace_268747c0::function_3874b272( "killbox" );
        level thread namespace_268747c0::function_3874b272( "killzone" );
        level thread namespace_268747c0::function_3874b272( "pungi" );
        level thread namespace_268747c0::function_3874b272( "flogger" );
        level thread namespace_268747c0::function_3874b272( "logdrop" );
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 1
    // Checksum 0xb00fe90, Offset: 0x1a50
    // Size: 0x12
    function function_9485c2a9( *val )
    {
        return var_2e06f9d4;
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 1
    // Checksum 0xb5f629e4, Offset: 0x18c0
    // Size: 0x2a
    function function_94e37da2( player )
    {
        return player istouching( var_694b395b );
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 0
    // Checksum 0x871db8fa, Offset: 0x25f8
    // Size: 0xb8
    function function_9f494a87()
    {
        foreach ( blocker in var_36f9408 )
        {
            blocker.origin = blocker.var_e603ff2c;
            namespace_1e25ad94::debugmsg( "Moving blocker: " + blocker.side + " to origin " + blocker.origin );
        }
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 1
    // Checksum 0xa238468d, Offset: 0x2f10
    // Size: 0x18
    function function_aad69885( side )
    {
        return var_b198ac5a[ side ];
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 0
    // Checksum 0xba93e7dc, Offset: 0x2398
    // Size: 0x256
    function deactivate()
    {
        level notify( #"arena_deactivated" );
        function_464d882c();
        function_7ce9bb97();
        function_9f494a87();
        
        foreach ( exit in var_b198ac5a )
        {
            if ( isdefined( exit.fakemodel ) )
            {
                exit.fakemodel delete();
            }
            
            namespace_1e25ad94::debugmsg( "Hiding Objective at exit: " + exit.script_noteworthy + " Objective ID: " + exit.objectiveid );
            objective_setstate( exit.objectiveid, "invisible" );
        }
        
        foreach ( var_f0ce243e in var_e2a6dd61 )
        {
            if ( isdefined( var_f0ce243e ) )
            {
                var_f0ce243e notify( #"deactivate" );
            }
        }
        
        var_5d3a1[ #"top" ] = [];
        var_5d3a1[ #"bottom" ] = [];
        var_5d3a1[ #"left" ] = [];
        var_5d3a1[ #"right" ] = [];
        var_ac834eea = function_14b480d1();
        
        if ( isdefined( var_ac834eea ) )
        {
            level thread [[ var_ac834eea ]]();
        }
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 0
    // Checksum 0x39504470, Offset: 0x1978
    // Size: 0xe
    function function_b2f9e813()
    {
        var_35760f46 = gettime();
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 1
    // Checksum 0x688a40b1, Offset: 0x1938
    // Size: 0x1a
    function function_b6954aba( var_e74c8f7 )
    {
        var_486c1553 = var_e74c8f7;
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 0
    // Checksum 0x943ff65d, Offset: 0x1bb0
    // Size: 0xa
    function function_c0402c8a()
    {
        return var_5479b5f3;
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 0
    // Checksum 0x5f78790a, Offset: 0x1fe0
    // Size: 0x3aa
    function activate()
    {
        level clientfield::set_world_uimodel( "DOA_GLOBALUIMODEL_ARENANUMBER", getid() );
        
        foreach ( exit in var_b198ac5a )
        {
            origin = exit namespace_ec06fe4a::function_65ee50ba( exit.origin, 12 );
            
            if ( !isdefined( exit.fakemodel ) )
            {
                exit.fakemodel = namespace_ec06fe4a::spawnmodel( origin + ( 0, 0, 16 ), "tag_origin" );
                exit.fakemodel.targetname = m_name + "_exit_" + exit.script_noteworthy;
            }
            
            assert( isdefined( exit.fakemodel ), "<dev string:x102>" );
            namespace_1e25ad94::debugmsg( "Updating Objective at exit: " + exit.script_noteworthy + " Objective ID: " + exit.objectiveid );
            objective_onentity( exit.objectiveid, exit.fakemodel );
            namespace_1e25ad94::debugmsg( "Hiding Objective at exit: " + exit.script_noteworthy + " Objective ID: " + exit.objectiveid );
            objective_setstate( exit.objectiveid, "invisible" );
        }
        
        foreach ( var_f0ce243e in var_e2a6dd61 )
        {
            var_f0ce243e thread function_e7bbc8d1();
        }
        
        function_90de0b96();
        function_7ce9bb97();
        function_9f494a87();
        
        while ( !loadnavvolume( m_name ) )
        {
            waitframe( 1 );
        }
        
        function_6d5262dc( 40 );
        var_5d3a1[ #"top" ] = [];
        var_5d3a1[ #"bottom" ] = [];
        var_5d3a1[ #"left" ] = [];
        var_5d3a1[ #"right" ] = [];
        var_2f0b512f = [[ level.doa.var_39e3fa99 ]]->function_3bf5b85d();
        
        if ( isdefined( var_2f0b512f ) )
        {
            level thread [[ var_2f0b512f ]]();
        }
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 1
    // Checksum 0x5a21d978, Offset: 0x2db0
    // Size: 0x13c
    function function_c8300b0e( side )
    {
        exit = function_aad69885( side );
        function_73ec120c( exit.script_noteworthy );
        exit triggerenable( 1 );
        exit.enabled = 1;
        namespace_1e25ad94::debugmsg( "Enabling trigger: " + exit.script_noteworthy );
        exit thread function_8bca81f0();
        exit.fakemodel namespace_83eb6304::function_3ecfde67( "exit_fog_marker" );
        objective_setstate( exit.objectiveid, "active" );
        namespace_1e25ad94::debugmsg( "Activating Objective at exit: " + exit.script_noteworthy + " Objective ID: " + exit.objectiveid );
        var_81e9b5ca[ var_81e9b5ca.size ] = exit;
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 0
    // Checksum 0xf5ab61b2, Offset: 0x1a98
    // Size: 0xa
    function function_c892290a()
    {
        return var_24df6bfb;
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 0
    // Checksum 0xe37ce184, Offset: 0x3108
    // Size: 0x112
    function function_c9f6682b()
    {
        profilestart();
        var_81e9b5ca = [];
        num = randomint( 4 ) + 1;
        var_41629194 = [];
        
        while ( num )
        {
            side = namespace_8c04284b::function_7802d126();
            
            if ( !isinarray( var_41629194, side ) )
            {
                var_41629194[ var_41629194.size ] = side;
                num--;
            }
        }
        
        foreach ( side in var_41629194 )
        {
            function_c8300b0e( side );
        }
        
        profilestop();
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 1
    // Checksum 0xf0408e2b, Offset: 0x1b70
    // Size: 0x1a
    function setwild( set )
    {
        var_c83ce53f = set;
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 0
    // Checksum 0x230d8b4e, Offset: 0x1ae8
    // Size: 0xa
    function function_cc773c53()
    {
        return var_bedb7d90;
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 0
    // Checksum 0xa7f9752f, Offset: 0x2ef8
    // Size: 0xa
    function function_dfb49846()
    {
        return var_81e9b5ca;
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 2
    // Checksum 0x2d693653, Offset: 0x1ab0
    // Size: 0x2e
    function function_e0de916a( var_cc6976cf, var_fd3fce8b )
    {
        var_bedb7d90 = var_cc6976cf;
        var_5e72455f = var_fd3fce8b;
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 0
    // Checksum 0x708ac70, Offset: 0x29a0
    // Size: 0x1f0
    function function_e7bbc8d1()
    {
        self endon( #"deactivate" );
        self triggerenable( 1 );
        self thread function_82fd5391();
        type = isdefined( script_noteworthy ) ? script_noteworthy : "setCameraDown";
        
        if ( isdefined( script_int ) )
        {
            self thread function_20b2a1e4( int( script_int ) );
        }
        
        var_6a1dbbf3 = 0;
        var_fe263624 = 0;
        
        if ( isdefined( script_parameters ) )
        {
            toks = strtok( script_parameters, ";" );
            assert( toks.size >= 2 );
            var_6a1dbbf3 = int( toks[ 0 ] );
            var_fe263624 = int( toks[ 1 ] );
        }
        
        while ( true )
        {
            result = self waittill( #"trigger" );
            
            if ( isplayer( result.activator ) && !isdefined( result.activator.tweakcam ) )
            {
                result.activator.tweakcam = self;
                result.activator thread function_4774f263( type, self, var_6a1dbbf3, var_fe263624 );
            }
        }
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 1
    // Checksum 0x754efd9b, Offset: 0x1bc8
    // Size: 0x34
    function function_eca91fd8( origin )
    {
        return arraysort( var_b60ab5fd, origin )[ var_b60ab5fd.size - 1 ];
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 1
    // Checksum 0x8d5589ea, Offset: 0x32f8
    // Size: 0x74
    function function_ee30f092( side )
    {
        if ( function_20b4ef55( side ) > 0 )
        {
            wave = var_5d3a1[ side ][ 0 ];
            arrayremoveindex( var_5d3a1[ side ], 0 );
            return wave;
        }
        
        return undefined;
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 0
    // Checksum 0x298593db, Offset: 0x33a0
    // Size: 0x64
    function function_f231126a()
    {
        return function_20b4ef55( "top" ) + function_20b4ef55( "bottom" ) + function_20b4ef55( "left" ) + function_20b4ef55( "right" );
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 1
    // Checksum 0x8c187185, Offset: 0x1730
    // Size: 0x50
    function function_fc81ec00( idx )
    {
        assert( idx < var_80292cd.size, "<dev string:x71>" + m_name );
        return var_80292cd[ idx ];
    }

    // Namespace namespace_f4bf8a8/namespace_8c04284b
    // Params 0
    // Checksum 0x8c98c64a, Offset: 0x16f8
    // Size: 0x2c
    function function_fdea25f1()
    {
        return var_5479b5f3[ randomint( var_5479b5f3.size ) ];
    }

}

// Namespace namespace_8c04284b/namespace_8c04284b
// Params 0
// Checksum 0x14e41554, Offset: 0x3f48
// Size: 0x38c
function init()
{
    clientfield::register( "world", "flipCamera", 1, 2, "int" );
    clientfield::register( "world", "setArena", 1, 5, "int" );
    clientfield::register( "world", "setTOD", 1, 3, "int" );
    level flag::init( "arena_zero_rounds", 0 );
    level flag::init( "arena_hold_presentation", 0 );
    level flag::init( "arena_hold_banner_presentation", 0 );
    level.doa.arenas = [];
    level.doa.var_ecff3871 = 0;
    level.doa.var_7f0b4a69 = 0;
    arenas = struct::get_array( "arena_center", "targetname" );
    var_7f6c6c04 = [];
    
    foreach ( arena in arenas )
    {
        assert( isdefined( arena.script_parameters ), "<dev string:x112>" );
        order = int( arena.script_parameters );
        assert( !isdefined( var_7f6c6c04[ order ] ), "<dev string:x172>" + arena.script_noteworthy );
        var_7f6c6c04[ order ] = arena;
    }
    
    id = 0;
    
    for ( index = 0; index < 100 ; index++ )
    {
        if ( isdefined( var_7f6c6c04[ index ] ) )
        {
            function_afa7d50a( var_7f6c6c04[ index ], id );
            id++;
        }
    }
    
    objective_add( 10 + 0, "invisible", ( 0, 0, 0 ), #"exit_objective" );
    objective_add( 10 + 1, "invisible", ( 0, 0, 0 ), #"exit_objective" );
    objective_add( 10 + 2, "invisible", ( 0, 0, 0 ), #"exit_objective" );
    objective_add( 10 + 3, "invisible", ( 0, 0, 0 ), #"exit_objective" );
}

// Namespace namespace_8c04284b/namespace_8c04284b
// Params 0
// Checksum 0x755e634b, Offset: 0x42e0
// Size: 0x416
function main()
{
    level.doa.var_e5ef2ab4 = 0;
    level.doa.var_a77e4601 = [];
    level.doa.var_11623c49 = randomintrange( 200, 600 );
    level flag::clear( "arena_zero_rounds" );
    level flag::clear( "arena_hold_presentation" );
    level flag::clear( "arena_hold_banner_presentation" );
    
    if ( level.doa.arenas.size == 0 )
    {
        return;
    }
    
    if ( isdefined( level.doa.var_39e3fa99 ) )
    {
        [[ level.doa.var_39e3fa99 ]]->deactivate();
    }
    
    level endon( #"game_over" );
    level waittill( #"hash_671684f03a58b3a3" );
    wait 0.25;
    level.doa.var_23fd3659 = 0;
    
    while ( true )
    {
        level thread function_6d6bfe1f( level.doa.var_23fd3659 );
        result = level waittill( #"waiting_on_player_exit_teleporteronly", #"waiting_on_player_exit_decidechoice" );
        
        if ( result._notify == "waiting_on_player_exit_teleporterOnly" )
        {
            nextarena = level.doa.var_23fd3659 + 1;
            
            if ( nextarena >= level.doa.arenas.size )
            {
                nextarena = 0;
            }
            
            arena = level.doa.arenas[ nextarena ];
            namespace_ec06fe4a::function_87612422( [[ arena ]]->function_ffcf1d1(), undefined, 1, 999999 );
        }
        
        result = level waittill( #"teleporter_taken", #"enter_the_wild" );
        
        if ( result._notify == #"enter_the_wild" )
        {
            level thread doa_wild::function_7c5bc025( result.param, result.data );
            level waittill( #"hash_325440d5433be263" );
        }
        
        level doa_banner::function_7a0e5387();
        level.doa.var_23fd3659++;
        
        /#
            if ( getdvarint( #"hash_d874e4e73e9f18" ) == 4 )
            {
                level.doa.var_23fd3659--;
            }
        #/
        
        if ( level.doa.var_23fd3659 >= level.doa.arenas.size )
        {
            level.doa.var_23fd3659 = 0;
            level.doa.var_6c58d51++;
            level.doa.var_e5ef2ab4 = 0;
        }
        
        level clientfield::set_world_uimodel( "DOA_GLOBALUIMODEL_ARENANUMBER", level.doa.var_23fd3659 );
        level.doa.var_a3e53b88 = 1;
        wait 5;
        level.doa.var_a3e53b88 = undefined;
    }
}

// Namespace namespace_8c04284b/namespace_8c04284b
// Params 2
// Checksum 0xaf64d849, Offset: 0x4700
// Size: 0xe4
function function_afa7d50a( arena_struct, index )
{
    arena = new class_f4bf8a8();
    [[ arena ]]->initialize( arena_struct, index );
    level.doa.arenas[ [[ arena ]]->getid() ] = arena;
    var_663588d = "Zombietron/Arenas/";
    cmdline = "scr_arena_activate " + [[ arena ]]->getname() + "; zombie_devgui arena";
    util::add_devgui( var_663588d + [[ arena ]]->getname() + ":" + [[ arena ]]->getid(), cmdline );
}

// Namespace namespace_8c04284b/namespace_8c04284b
// Params 1
// Checksum 0xc95a1860, Offset: 0x47f0
// Size: 0xb0
function function_a7c5291d( name )
{
    foreach ( arena in level.doa.arenas )
    {
        if ( [[ arena ]]->getname() == name )
        {
            return [[ arena ]]->getid();
        }
    }
    
    return -1;
}

// Namespace namespace_8c04284b/namespace_8c04284b
// Params 1
// Checksum 0x8b379afd, Offset: 0x48a8
// Size: 0xa2
function function_85c7d70e( name )
{
    foreach ( arena in level.doa.arenas )
    {
        if ( [[ arena ]]->getname() == name )
        {
            return arena;
        }
    }
}

// Namespace namespace_8c04284b/namespace_8c04284b
// Params 1
// Checksum 0x7b42ccfd, Offset: 0x4958
// Size: 0xac
function function_1ced05a1( id )
{
    foreach ( arena in level.doa.arenas )
    {
        if ( [[ arena ]]->getid() == id )
        {
            return [[ arena ]]->getname();
        }
    }
}

// Namespace namespace_8c04284b/namespace_8c04284b
// Params 1
// Checksum 0xa33cefb1, Offset: 0x4a10
// Size: 0x23c
function function_27960a04( arenaid )
{
    assert( isdefined( level.doa.arenas[ arenaid ] ), "<dev string:x1bb>" + arenaid );
    level clientfield::set( "setArena", arenaid );
    level clientfield::set( "setTOD", 0 );
    level util::set_lighting_state( 0, 0 );
    level.doa.var_a598a835 = undefined;
    level notify( #"arena_switching" );
    util::wait_network_frame();
    level.doa.var_39e3fa99 = level.doa.arenas[ arenaid ];
    [[ level.doa.var_39e3fa99 ]]->activate();
    [[ level.doa.var_39e3fa99 ]]->setpaused( 1 );
    [[ level.doa.var_39e3fa99 ]]->function_68400720( 1 );
    namespace_ec06fe4a::function_87612422( [[ level.doa.var_39e3fa99 ]]->function_ffcf1d1() );
    function_8405d534();
    function_a70ff03e( 0 );
    level util::streamer_wait( undefined, 0, 2 );
    namespace_9fc66ac::function_5beeba99();
    namespace_1e25ad94::debugmsg( "Arena " + arenaid + " activated (" + [[ level.doa.var_39e3fa99 ]]->getname() + ")" );
}

// Namespace namespace_8c04284b/namespace_8c04284b
// Params 1
// Checksum 0x959f84bb, Offset: 0x4c58
// Size: 0xe8
function function_a70ff03e( var_cebfca7c )
{
    level.doa.var_ecff3871 = var_cebfca7c;
    
    if ( level.doa.var_ecff3871 )
    {
        level clientfield::set( "flipCamera", 2 );
        settopdowncamerayaw( 180 );
    }
    else
    {
        level clientfield::set( "flipCamera", 1 );
        settopdowncamerayaw( 0 );
    }
    
    level notify( #"hash_180d4d3b6b7ea3f3", { #var_5078f168:level.doa.var_ecff3871 } );
}

// Namespace namespace_8c04284b/namespace_8c04284b
// Params 1
// Checksum 0xfd7cbbec, Offset: 0x4d48
// Size: 0x214
function function_8405d534( side )
{
    players = namespace_7f5aeb59::function_23e1f90f();
    idx = 0;
    
    foreach ( player in players )
    {
        player.doa.var_3cf36932 = getdvarint( #"hash_78552e57522c596d", 1 );
        
        if ( isdefined( side ) )
        {
            spot = [[ level.doa.var_39e3fa99 ]]->function_23476287( idx, side );
            assert( isdefined( spot ), "<dev string:x1dc>" );
        }
        else
        {
            spot = [[ level.doa.var_39e3fa99 ]]->function_fc81ec00( idx );
            assert( isdefined( spot ), "<dev string:x205>" );
        }
        
        player setorigin( spot.origin );
        player setplayerangles( spot.angles );
        player clientfield::increment_to_player( "controlBinding" );
        idx++;
    }
    
    level.doa.var_dcbded2 = [];
    level namespace_7f5aeb59::function_d0251f76();
    level thread function_37dc18ca();
}

// Namespace namespace_8c04284b/namespace_8c04284b
// Params 0
// Checksum 0x23e9f048, Offset: 0x4f68
// Size: 0x23c
function function_37dc18ca()
{
    self notify( "4dbe31496523f6d8" );
    self endon( "4dbe31496523f6d8" );
    level endon( #"game_over" );
    
    while ( true )
    {
        players = namespace_7f5aeb59::function_23e1f90f();
        
        foreach ( player in players )
        {
            if ( player isinmovemode( "ufo", "noclip" ) )
            {
                continue;
            }
            
            if ( isdefined( level.doa.var_6f3d327 ) )
            {
                continue;
            }
            
            if ( !is_true( player.doa.var_3cf36932 ) )
            {
                continue;
            }
            
            if ( isdefined( level.doa.var_a77e6349 ) )
            {
                continue;
            }
            
            if ( ![[ level.doa.var_39e3fa99 ]]->function_94e37da2( player ) )
            {
                spot = [[ level.doa.var_39e3fa99 ]]->function_70fb5745();
                namespace_1e25ad94::debugmsg( "Safe Zone Monitor teleporting player (" + player.doa.color + ") at: " + player.origin + " to a safe spot in (" + [[ level.doa.var_39e3fa99 ]]->getname() + ") at :" + spot.origin, 1 );
                player setorigin( spot.origin );
            }
        }
        
        wait 0.5;
    }
}

// Namespace namespace_8c04284b/namespace_8c04284b
// Params 0
// Checksum 0x1039c4fd, Offset: 0x51b0
// Size: 0xc6
function function_9f0eb43e()
{
    if ( is_true( level.doa.var_8f710e5d ) || level.doa.roundnumber > 4 && randomint( 100 ) < 15 || level.doa.roundnumber - level.doa.var_7f0b4a69 > 7 )
    {
        level thread namespace_58e19d6::function_571bb3ac();
        level.doa.var_7f0b4a69 = level.doa.roundnumber;
    }
}

// Namespace namespace_8c04284b/namespace_8c04284b
// Params 2
// Checksum 0x7531c5b5, Offset: 0x5280
// Size: 0xda0
function function_6d6bfe1f( arenaid, rounds = 4 )
{
    self notify( "60ec52d1d0cd2101" );
    self endon( "60ec52d1d0cd2101" );
    level endon( #"game_over" );
    level flag::clear( "arena_zero_rounds" );
    assert( arenaid != -1, "<dev string:x22a>" );
    namespace_4dae815d::function_21cd3890( 0 );
    currentlightstate = 0;
    namespace_ec06fe4a::function_de70888a();
    function_27960a04( arenaid );
    level doa_banner::function_7a0e5387();
    level thread function_e1916608();
    level thread function_16902251();
    level thread function_17e79564();
    level thread function_1b42a0bb();
    level thread doa_enemy::function_7495bd30();
    var_d0cb8cd4 = gettime();
    var_4a140058 = function_1ced05a1( arenaid );
    var_6e1767b4 = getdvarint( #"hash_41e6782116433285", 1 );
    
    while ( rounds > 0 )
    {
        roundstarttime = gettime();
        level.doa.var_9fcf26ea = 0;
        namespace_1e25ad94::debugmsg( "Arena (" + var_4a140058 + ") round starting at: " + roundstarttime + " RoundNumber: " + level.doa.roundnumber + " Rounds Left on this Arena: " + rounds );
        level function_3d25cb06();
        [[ level.doa.var_39e3fa99 ]]->function_9f494a87();
        [[ level.doa.var_39e3fa99 ]]->function_7ce9bb97();
        wait 1.5;
        level notify( #"round_about_to_start" );
        level thread namespace_7f5aeb59::function_836aeb74( 1.5 );
        function_1eaaceab( level.doa.var_7829ebb7 );
        assert( level.doa.var_7829ebb7.size == 0, "<dev string:x24c>" );
        
        if ( namespace_77eccc4f::function_379191c( var_4a140058 ) )
        {
            result = level waittill( #"challenge_ready" );
        }
        
        [[ level.doa.var_39e3fa99 ]]->setpaused( 0 );
        level notify( #"round_begin" );
        level namespace_7f5aeb59::function_ec758d18();
        
        if ( is_true( level.doa.var_7ada373e ) )
        {
            if ( level.doa.roundnumber % 2 == 0 )
            {
                namespace_1e25ad94::function_4e3cfad( "Using arenaEnemyHerdSpawner for round " + level.doa.roundnumber, undefined, undefined, undefined, 10 );
                level thread function_9e0d71e5();
            }
            else
            {
                namespace_1e25ad94::function_4e3cfad( "Using arenaEnemyWaveSpawner for round " + level.doa.roundnumber, undefined, undefined, undefined, 10 );
                level thread function_81282ad3();
            }
        }
        else if ( var_6e1767b4 )
        {
            level thread function_81282ad3();
        }
        else
        {
            level thread function_9e0d71e5();
        }
        
        level flag::wait_till_clear( "doa_round_spawning" );
        [[ level.doa.var_39e3fa99 ]]->setpaused( 1 );
        namespace_ec06fe4a::function_b6b79fd1();
        
        while ( level flag::get( "doa_round_paused" ) || is_true( level.hostmigrationtimer ) )
        {
            waitframe( 1 );
        }
        
        var_c59f32d7 = gettime();
        var_543a89a0 = int( float( var_c59f32d7 - roundstarttime ) / 1000 );
        
        if ( level.doa.roundnumber > 55 && var_543a89a0 < 100 )
        {
            namespace_1e25ad94::debugmsg( "WTF !!!!!!  Arena (" + var_4a140058 + ") round [" + level.doa.roundnumber + "] finished at: " + gettime() + " Total Time:" + var_543a89a0 + " seconds" );
        }
        
        if ( !is_true( level.doa.var_3ec3c9aa ) )
        {
            eventparams = { #roundnumber:level.doa.roundnumber, #roundduration:var_543a89a0 };
            function_92d1707f( #"hash_70c149ea78c8a7ac", eventparams );
        }
        else
        {
            namespace_1e25ad94::debugmsg( "Arena (" + var_4a140058 + ") round [" + level.doa.roundnumber + "] skipping DLOG event due to interference" );
        }
        
        level.doa.var_3ec3c9aa = undefined;
        namespace_1e25ad94::debugmsg( "Arena (" + var_4a140058 + ") round [" + level.doa.roundnumber + "] finished at: " + gettime() + " Total Time:" + var_543a89a0 + " seconds" );
        
        if ( is_true( level.doa.var_7ada373e ) )
        {
            namespace_1e25ad94::function_4e3cfad( "\tArena (" + var_4a140058 + ") round [" + level.doa.roundnumber + "] finished at: " + gettime() + " Total Time:" + var_543a89a0 + " seconds" + " AI Spawned:" + level.doa.var_9fcf26ea, undefined, undefined, undefined, 10 );
        }
        
        level notify( #"round_over" );
        waitframe( 1 );
        
        if ( level flag::get( "arena_zero_rounds" ) )
        {
            rounds = 0;
        }
        
        if ( rounds > 1 )
        {
            spot = [[ level.doa.var_39e3fa99 ]]->function_fdea25f1();
            roll = randomint( 100 );
            radius = spot.radius;
            
            if ( !isdefined( radius ) )
            {
                radius = 32;
            }
            
            if ( roll == 0 )
            {
                namespace_dfc652ee::function_68442ee7( spot.origin, 1, radius, 1 );
            }
            
            namespace_dfc652ee::function_68442ee7( spot.origin, randomintrange( 4, 10 ), radius, 0 );
            [[ level.doa.var_39e3fa99 ]]->function_c9f6682b();
            function_9f0eb43e();
            namespace_1e25ad94::debugmsg( "Arena (" + var_4a140058 + ") waiting for doa_exit_taken" );
            level doa_banner::function_7a0e5387( 2 );
            result = level waittill( #"doa_exit_taken" );
            namespace_1e25ad94::debugmsg( "Arena (" + var_4a140058 + ") waiting for doa_exit_taken recieved" );
            [[ level.doa.var_39e3fa99 ]]->function_7ce9bb97();
            var_1075516b = result.direction;
            level thread namespace_7f5aeb59::function_67f054d7( 1.5 );
            level waittill( #"hash_1b322de3d2e3e781" );
            level doa_banner::function_7a0e5387();
            
            if ( namespace_5a917022::function_7230f033() )
            {
                level waittill( #"hash_7dd47c99b7707b1c" );
            }
            
            function_a70ff03e( !level.doa.var_ecff3871 );
            currentlightstate++;
            
            if ( currentlightstate > 3 )
            {
                currentlightstate = 0;
            }
            
            level util::set_lighting_state( currentlightstate, 0 );
            level clientfield::set( "setTOD", currentlightstate );
            namespace_dfc652ee::function_19fa261e();
            namespace_ec06fe4a::clearallcorpses();
            
            if ( isdefined( var_1075516b ) )
            {
                function_8405d534( var_1075516b );
            }
        }
        
        rounds--;
        level.doa.var_9a86a331 = [];
        level.doa.var_f4cf4e3 += 2;
        level.doa.zombie_health += 100;
        namespace_4dae815d::function_e22d3978( level.doa.roundnumber + 1 );
    }
    
    clusters = 2;
    
    while ( clusters > 0 )
    {
        clusters--;
        spot = [[ level.doa.var_39e3fa99 ]]->function_fdea25f1();
        radius = spot.radius;
        
        if ( !isdefined( radius ) )
        {
            radius = 32;
        }
        
        roll = randomint( 100 );
        
        if ( roll == 0 )
        {
            namespace_dfc652ee::function_68442ee7( spot.origin, 1, radius, 1 );
        }
        
        namespace_dfc652ee::function_68442ee7( spot.origin, randomintrange( 4, 10 ), radius, 0 );
    }
    
    level thread function_3f18205d();
    timesec = float( gettime() - var_d0cb8cd4 ) / 1000;
    level.doa.game_duration += timesec;
    namespace_1e25ad94::debugmsg( "Arena (" + var_4a140058 + ") time spent: " + timesec + " seconds." );
    level notify( #"arena_completed" );
}

// Namespace namespace_8c04284b/namespace_8c04284b
// Params 0
// Checksum 0x1f20d14a, Offset: 0x6028
// Size: 0xa46
function function_3f18205d()
{
    level endon( #"game_over" );
    level notify( #"hash_de33bd076cde122" );
    waitframe( 1 );
    
    while ( level flag::get( "arena_hold_presentation" ) )
    {
        waitframe( 1 );
    }
    
    var_dd3eca11 = [[ level.doa.var_39e3fa99 ]]->function_9485c2a9();
    var_c6906ae1 = [[ level.doa.var_39e3fa99 ]]->function_51dd0a59();
    
    if ( isdefined( var_c6906ae1 ) )
    {
        var_9f6855ea = isdefined( level.doa.var_e15152e6 ) ? level.doa.var_e15152e6 : var_c6906ae1.script_noteworthy;
        var_c4f905c2 = isdefined( var_c6906ae1.script_int ) ? int( var_c6906ae1.script_int ) : isdefined( level.doa.var_baeb966b ) ? level.doa.var_baeb966b : 0;
        wild = doa_wild::function_e5e987ae( var_9f6855ea );
        var_82dd2bd0 = isdefined( var_c6906ae1 ) ? var_c6906ae1.origin : [[ level.doa.var_39e3fa99 ]]->function_70fb5745( [[ level.doa.var_39e3fa99 ]]->function_ffcf1d1() ).origin;
    }
    
    /#
        if ( getdvarint( #"hash_d874e4e73e9f18" ) != 0 || is_true( level.doa.var_1f2c7d5f ) )
        {
            var_dd3eca11 = 1;
            wild = undefined;
        }
    #/
    
    id = [[ level.doa.var_39e3fa99 ]]->getid();
    
    if ( var_dd3eca11 )
    {
        namespace_1e25ad94::debugmsg( "Arena " + id + " spawning teleporter" );
        origin = [[ level.doa.var_39e3fa99 ]]->function_ffcf1d1();
        var_45041f7 = namespace_ec06fe4a::spawnmodel( origin + ( 0, 0, -115 ), "zombietron_teleporter" );
        
        if ( isdefined( var_45041f7 ) )
        {
            var_45041f7 thread namespace_ec06fe4a::function_d55f042c( level, "game_over" );
            var_45041f7 setmodel( "zombietron_teleporter" );
            var_45041f7 solid();
            var_45041f7 setmovingplatformenabled( 1 );
            var_45041f7 namespace_83eb6304::function_3ecfde67( "teleporter_dungeon_light" );
            var_45041f7 thread namespace_ec06fe4a::function_f506b4c7();
            var_45041f7 moveto( origin + ( 0, 0, 12 ), 1.5 );
            level notify( #"teleporter_spawned", { #teleporter:var_45041f7 } );
            var_45041f7 waittill( #"movedone" );
            level.doa.teleporter = var_45041f7;
            var_45041f7.trigger = namespace_ec06fe4a::spawntrigger( "trigger_radius", var_45041f7.origin + ( 0, 0, -100 ), 0, 20, 200 );
            
            if ( isdefined( var_45041f7.trigger ) )
            {
                var_45041f7.trigger thread namespace_ec06fe4a::function_d55f042c( var_45041f7, "death" );
            }
            else
            {
                assert( 0, "<dev string:x278>" );
            }
            
            while ( level flag::get( "arena_hold_banner_presentation" ) )
            {
                waitframe( 1 );
            }
            
            var_c2366736 = isdefined( wild ) ? 4 : 3;
            level doa_banner::function_7a0e5387( var_c2366736 );
        }
        else
        {
            assert( 0, "<dev string:x278>" );
        }
    }
    else
    {
        assert( isdefined( wild ) );
        
        while ( level flag::get( "arena_hold_banner_presentation" ) )
        {
            waitframe( 1 );
        }
        
        level doa_banner::function_7a0e5387( 5 );
    }
    
    note = "teleporter_taken";
    param = undefined;
    data = undefined;
    
    if ( isdefined( wild ) )
    {
        var_6c225512 = namespace_ec06fe4a::spawnmodel( var_82dd2bd0, "tag_origin" );
        
        if ( isdefined( var_6c225512 ) )
        {
            var_6c225512 namespace_83eb6304::function_3ecfde67( "wild_portal" );
            var_6c225512 namespace_83eb6304::function_3ecfde67( "wild_portal_elec_burst" );
            var_6c225512 thread namespace_ec06fe4a::function_d55f042c( level, "game_over" );
        }
        else
        {
            assert( 0, "<dev string:x278>" );
        }
        
        var_6c225512.trigger = namespace_ec06fe4a::spawntrigger( "trigger_radius", var_6c225512.origin + ( 0, 0, -100 ), 0, 40, 100 );
        level.doa.var_6c225512 = var_6c225512;
        
        if ( isdefined( var_6c225512.trigger ) )
        {
            var_6c225512.trigger thread namespace_ec06fe4a::function_d55f042c( var_6c225512, "death" );
        }
        else
        {
            assert( 0, "<dev string:x278>" );
        }
        
        wait 1;
        var_6c225512 namespace_83eb6304::function_3ecfde67( "wild_portal_radial_burst" );
        var_6c225512.trigger thread function_ba702ab7( "enter_the_wild" );
        
        if ( isdefined( var_45041f7 ) && !is_true( var_45041f7.malfunction ) )
        {
            var_45041f7.trigger thread function_ba702ab7( "teleporter_taken" );
        }
        
        level notify( #"waiting_on_player_exit_decidechoice" );
        note = function_df020ff4();
        
        if ( note == "enter_the_wild" )
        {
            param = var_9f6855ea;
            data = var_c4f905c2;
        }
    }
    else
    {
        assert( isdefined( var_45041f7 ) );
        level notify( #"waiting_on_player_exit_teleporteronly" );
        result = var_45041f7.trigger waittill( #"trigger" );
        var_45041f7.trigger delete();
    }
    
    level thread namespace_7f5aeb59::function_67f054d7( 1.5 );
    level waittill( #"hash_1b322de3d2e3e781" );
    [[ level.doa.var_39e3fa99 ]]->deactivate();
    
    if ( isdefined( var_45041f7 ) )
    {
        var_45041f7 namespace_83eb6304::turnofffx( "teleporter_dungeon_light" );
        var_45041f7 namespace_83eb6304::turnofffx( "glow_red" );
        var_45041f7 namespace_83eb6304::turnofffx( "glow_green" );
        var_45041f7 namespace_83eb6304::turnofffx( "glow_blue" );
        util::wait_network_frame();
        var_45041f7 delete();
    }
    
    if ( isdefined( var_6c225512 ) )
    {
        var_6c225512.trigger delete();
        var_6c225512 delete();
        level.doa.var_6c225512 = undefined;
    }
    
    level.doa.teleporter = undefined;
    namespace_dfc652ee::function_19fa261e();
    namespace_ec06fe4a::clearallcorpses();
    level notify( note, { #param:param, #data:data } );
}

// Namespace namespace_8c04284b/namespace_8c04284b
// Params 1
// Checksum 0x27ac7b88, Offset: 0x6a78
// Size: 0x60
function function_ba702ab7( note )
{
    self endon( #"death" );
    self waittill( #"trigger" );
    level notify( #"hash_45f77908e3043522", { #note:note } );
}

// Namespace namespace_8c04284b/namespace_8c04284b
// Params 0
// Checksum 0x6d8e9748, Offset: 0x6ae0
// Size: 0x36
function function_df020ff4()
{
    result = level waittill( #"hash_45f77908e3043522" );
    return result.note;
}

// Namespace namespace_8c04284b/namespace_8c04284b
// Params 0
// Checksum 0xf9844b6e, Offset: 0x6b20
// Size: 0x220
function function_e1916608()
{
    self notify( "6288619db554887f" );
    self endon( "6288619db554887f" );
    level endon( #"arena_completed" );
    level endon( #"game_over" );
    minitems = 4;
    maxitems = 10;
    minwait = 10;
    maxwait = 20;
    var_627acedf = undefined;
    
    while ( true )
    {
        wait randomfloatrange( minwait, maxwait );
        
        if ( isdefined( var_627acedf ) )
        {
            if ( gettime() > var_627acedf )
            {
                while ( [[ level.doa.var_39e3fa99 ]]->ispaused() )
                {
                    waitframe( 1 );
                }
            }
        }
        else if ( [[ level.doa.var_39e3fa99 ]]->ispaused() )
        {
            var_627acedf = gettime() + 30000;
        }
        
        if ( doa_enemy::function_e7e91016() )
        {
            /#
                namespace_1e25ad94::function_4e3cfad( "<dev string:x292>", ( 1, 0, 0 ), undefined, 1.5 );
                namespace_1e25ad94::debugmsg( "<dev string:x2b9>" );
            #/
            
            continue;
        }
        
        spot = [[ level.doa.var_39e3fa99 ]]->function_fdea25f1();
        radius = spot.radius;
        
        if ( !isdefined( radius ) )
        {
            radius = 72;
        }
        
        namespace_dfc652ee::function_68442ee7( spot.origin, randomintrange( minitems, maxitems ), radius, randomint( 100 ) > 98 );
    }
}

// Namespace namespace_8c04284b/namespace_8c04284b
// Params 0
// Checksum 0x109bf594, Offset: 0x6d48
// Size: 0x190
function function_16902251()
{
    self notify( "1d096fe64b8ed2f1" );
    self endon( "1d096fe64b8ed2f1" );
    level endon( #"arena_completed" );
    level endon( #"game_over" );
    level endon( #"arena_deactivated" );
    minwait = 10;
    maxwait = 15;
    
    while ( true )
    {
        wait randomfloatrange( minwait, maxwait );
        
        while ( [[ level.doa.var_39e3fa99 ]]->ispaused() )
        {
            waitframe( 1 );
        }
        
        if ( doa_enemy::function_e7e91016() )
        {
            /#
                namespace_1e25ad94::function_4e3cfad( "<dev string:x2ec>", ( 1, 0, 0 ), undefined, 1.5 );
                namespace_1e25ad94::debugmsg( "<dev string:x312>" );
            #/
            
            continue;
        }
        
        spot = [[ level.doa.var_39e3fa99 ]]->function_fdea25f1();
        radius = spot.radius;
        
        if ( !isdefined( radius ) )
        {
            radius = 72;
        }
        
        namespace_dfc652ee::function_ad7ac41b( spot.origin, 1, radius );
    }
}

// Namespace namespace_8c04284b/namespace_8c04284b
// Params 0
// Checksum 0x7fe22cba, Offset: 0x6ee0
// Size: 0x2c0
function function_17e79564()
{
    self notify( "1da7f0aa923ce753" );
    self endon( "1da7f0aa923ce753" );
    level endon( #"arena_completed" );
    level endon( #"game_over" );
    wait 5;
    minwait = 20;
    maxwait = 30;
    nextweapon = 0;
    var_e36d70e2 = undefined;
    var_d7f489eb = array::randomize( arraycombine( [[ level.doa.var_39e3fa99 ]]->function_8054e011(), [[ level.doa.var_39e3fa99 ]]->function_c0402c8a() ) );
    var_9a572c4e = 0;
    
    while ( true )
    {
        if ( isdefined( var_e36d70e2 ) )
        {
            if ( gettime() > var_e36d70e2 )
            {
                while ( [[ level.doa.var_39e3fa99 ]]->ispaused() )
                {
                    waitframe( 1 );
                }
            }
        }
        else if ( [[ level.doa.var_39e3fa99 ]]->ispaused() )
        {
            var_e36d70e2 = gettime() + 30000;
        }
        
        if ( gettime() > nextweapon )
        {
            if ( isdefined( level.doa.var_cfa10fcf ) )
            {
                var_9e20508c = level.doa.var_cfa10fcf;
                level.doa.var_cfa10fcf = undefined;
            }
            else
            {
                var_9e20508c = 1;
                
                if ( randomint( 100 ) > 98 )
                {
                    var_9e20508c += randomint( 3 );
                }
            }
            
            def = namespace_dfc652ee::function_57160cba( 6 );
            spot = var_d7f489eb[ var_9a572c4e ];
            var_9a572c4e++;
            
            if ( var_9a572c4e >= var_d7f489eb.size )
            {
                var_9a572c4e = 0;
            }
            
            radius = spot.radius;
            
            if ( !isdefined( radius ) )
            {
                radius = 72;
            }
            
            namespace_dfc652ee::function_83aea294( spot.origin, var_9e20508c, radius, def );
            nextweapon = gettime() + randomintrange( minwait, maxwait ) * 1000;
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_8c04284b/namespace_8c04284b
// Params 1
// Checksum 0xe93affce, Offset: 0x71a8
// Size: 0x10, Type: bool
function function_80bb0f94( *name )
{
    return true;
}

// Namespace namespace_8c04284b/namespace_8c04284b
// Params 0
// Checksum 0xe824095a, Offset: 0x71c0
// Size: 0x19c
function function_1b42a0bb()
{
    self notify( "6a8b72fd96a8b74f" );
    self endon( "6a8b72fd96a8b74f" );
    level endon( #"arena_completed" );
    level endon( #"game_over" );
    
    if ( function_80bb0f94( [[ level.doa.var_39e3fa99 ]]->getname() ) == 0 )
    {
        return;
    }
    
    while ( true )
    {
        while ( !is_true( level.doa.var_a6cd0cb7 ) && [[ level.doa.var_39e3fa99 ]]->ispaused() || isdefined( level.doa.var_6f3d327 ) )
        {
            waitframe( 1 );
        }
        
        level.doa.var_11623c49--;
        
        if ( level.doa.var_11623c49 <= 0 )
        {
            level.doa.var_a6cd0cb7 = undefined;
            level function_8f63849();
            
            while ( isdefined( level.doa.weaponcharger ) )
            {
                wait 1;
            }
            
            level.doa.var_11623c49 = randomintrange( 200, 600 );
        }
        
        wait 1;
    }
}

// Namespace namespace_8c04284b/namespace_8c04284b
// Params 0
// Checksum 0xaa211899, Offset: 0x7368
// Size: 0x45c
function function_8f63849()
{
    self notify( "76ca58594e01a7d" );
    self endon( "76ca58594e01a7d" );
    level endon( #"arena_completed" );
    level endon( #"game_over" );
    
    if ( isdefined( level.doa.weaponcharger ) )
    {
        level.doa.weaponcharger.light delete();
        level.doa.weaponcharger delete();
    }
    
    spot = [[ level.doa.var_39e3fa99 ]]->function_70fb5745();
    var_d6e32de9 = [[ level.doa.var_39e3fa99 ]]->function_70fb5745( spot.origin, 24, 256 );
    
    if ( isdefined( var_d6e32de9 ) )
    {
        def = namespace_dfc652ee::function_57160cba( 6 );
        namespace_dfc652ee::function_83aea294( var_d6e32de9.origin, 1, 8, def );
    }
    
    origin = namespace_ec06fe4a::function_65ee50ba( spot.origin ) + ( 0, 0, 6 );
    var_70527f67 = namespace_ec06fe4a::spawnmodel( origin + ( 0, 0, -115 ), "zombietron_weapon_charging_pad" );
    
    if ( isdefined( var_70527f67 ) )
    {
        var_70527f67 enablelinkto();
        var_70527f67.targetname = "weaponCharger";
        var_70527f67 solid();
        var_70527f67 setmovingplatformenabled( 1 );
        var_70527f67 namespace_83eb6304::function_3ecfde67( "glow_yellow" );
        var_3525a228 = namespace_ec06fe4a::spawnmodel( origin + ( 0, 0, -115 ) );
        
        if ( isdefined( var_3525a228 ) )
        {
            var_3525a228 enablelinkto();
            var_3525a228 linkto( var_70527f67, undefined, ( 0, 0, 1 ) );
            var_3525a228.targetname = "weaponChargerLight";
            var_70527f67.light = var_3525a228;
            var_70527f67 function_15a2b166( "green" );
        }
        
        var_70527f67.var_81b02b86 = 120;
        var_70527f67 thread namespace_ec06fe4a::function_f506b4c7();
        var_70527f67 moveto( origin, 1.5 );
        var_70527f67 waittill( #"movedone" );
        var_70527f67 disconnectpaths( undefined, 0 );
        var_70527f67.trigger = namespace_ec06fe4a::spawntrigger( "trigger_radius", origin + ( 0, 0, -20 ), 0, 20, 72 );
        var_70527f67 namespace_83eb6304::function_3ecfde67( "weaponChargerActive" );
        var_70527f67 namespace_e32bb68::function_3a59ec34( "evt_doa_weapon_charge_start" );
        var_70527f67 namespace_e32bb68::function_3a59ec34( "evt_doa_weapon_charge_lp" );
        level.doa.weaponcharger = var_70527f67;
        level.doa.weaponcharger thread function_6aa1d6a();
        level.doa.weaponcharger thread function_b0a158d7();
        level.doa.weaponcharger thread function_f39d5561();
    }
}

// Namespace namespace_8c04284b/namespace_8c04284b
// Params 0
// Checksum 0x1a08d8fc, Offset: 0x77d0
// Size: 0x410
function function_b0a158d7()
{
    self endon( #"death" );
    
    if ( !isdefined( self.trigger ) )
    {
        level notify( #"hash_bc1b9c6675b1faa" );
        return;
    }
    
    var_666e15ce = 150;
    def = namespace_dfc652ee::function_2c9923d7( 36 );
    var_7cc1c2b2 = array( def, def, def, def );
    
    while ( self.var_81b02b86 > 0 && isdefined( self.trigger ) )
    {
        players = namespace_7f5aeb59::function_23e1f90f();
        
        foreach ( player in players )
        {
            entnum = player.doa.entnum;
            player.doa.var_57eaec6e = 0;
            
            if ( player istouching( self.trigger ) )
            {
                if ( is_true( player.laststand ) )
                {
                    continue;
                }
                
                if ( player.doa.weaponlevel == 2 && player.doa.var_d8955419 == 1024 )
                {
                    continue;
                }
                
                player.doa.var_57eaec6e = 1;
                
                if ( player.doa.weaponlevel == 0 )
                {
                    player.doa.var_d8955419 = 1024;
                }
                
                switch ( player.doa.weaponlevel )
                {
                    case 0:
                        type = 36;
                        glow = "glow_white";
                        break;
                    case 1:
                        type = 37;
                        glow = "glow_red";
                        break;
                    case 2:
                        type = 38;
                        glow = "glow_blue";
                        break;
                }
                
                if ( type === [[ var_7cc1c2b2[ entnum ] ]]->gettype() )
                {
                    def = var_7cc1c2b2[ entnum ];
                }
                else
                {
                    def = namespace_dfc652ee::function_2c9923d7( type );
                    var_7cc1c2b2[ entnum ] = def;
                }
                
                namespace_dfc652ee::itemspawn( def, player.origin, player.angles, undefined, 1, glow, undefined, undefined, player, 0 );
                player.doa.var_6b4163f1 = 0;
                
                if ( self.var_81b02b86 > var_666e15ce && self.var_81b02b86 - 5 <= var_666e15ce )
                {
                    self function_15a2b166( "yellow" );
                }
                
                self.var_81b02b86 -= 5;
            }
        }
        
        wait 1;
    }
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger delete();
    }
    
    level notify( #"hash_bc1b9c6675b1faa" );
}

// Namespace namespace_8c04284b/namespace_8c04284b
// Params 0
// Checksum 0x23149fe7, Offset: 0x7be8
// Size: 0x68
function function_f39d5561()
{
    self endon( #"death" );
    var_20fae15 = 25;
    wait var_20fae15;
    self function_15a2b166( "yellow" );
    wait 5;
    level notify( #"hash_bc1b9c6675b1faa" );
}

// Namespace namespace_8c04284b/namespace_8c04284b
// Params 1
// Checksum 0xa5ad0b8d, Offset: 0x7c58
// Size: 0x6c
function function_15a2b166( color = "green" )
{
    if ( isdefined( self.light ) && self.curcolor !== color )
    {
        self.curcolor = color;
        self.light setmodel( "zombietron_weapon_charging_pad_light_" + color );
    }
}

// Namespace namespace_8c04284b/namespace_8c04284b
// Params 0
// Checksum 0xe78765a9, Offset: 0x7cd0
// Size: 0x294
function function_6aa1d6a()
{
    self endon( #"death" );
    level waittill( #"arena_completed", #"game_over", #"exit_taken", #"hash_bc1b9c6675b1faa" );
    self function_15a2b166( "red" );
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger delete();
    }
    
    wait 3;
    self namespace_83eb6304::turnofffx( "weaponChargerActive" );
    self namespace_e32bb68::function_ae271c0b( "evt_doa_weapon_charge_lp" );
    self namespace_83eb6304::function_3ecfde67( "weaponChargerDone" );
    self namespace_e32bb68::function_3a59ec34( "evt_doa_weapon_charge_end" );
    self moveto( self.origin + ( 0, 0, -115 ), 1.5 );
    self waittill( #"movedone" );
    self connectpaths();
    self namespace_83eb6304::turnofffx( "weaponChargerActive" );
    
    if ( isdefined( self.light ) )
    {
        self.light delete();
    }
    
    level.doa.weaponcharger = undefined;
    players = namespace_7f5aeb59::function_23e1f90f();
    
    foreach ( player in players )
    {
        player.doa.var_57eaec6e = 0;
    }
    
    self delete();
}

// Namespace namespace_8c04284b/namespace_8c04284b
// Params 0
// Checksum 0x2705c658, Offset: 0x7f70
// Size: 0x2a6
function function_81282ad3()
{
    self notify( "443ea10959c71230" );
    self endon( "443ea10959c71230" );
    level endon( #"game_over" );
    level endon( #"round_over" );
    level flag::set( "doa_round_spawning" );
    starttime = gettime();
    
    if ( level flag::get( "challenge_round_spawnOverride" ) )
    {
        level flag::wait_till_clear( "challenge_round_spawnOverride" );
    }
    else
    {
        namespace_1e25ad94::debugmsg( "Round " + level.doa.roundnumber + " starting at: " + starttime + " Waves expected: " + level.doa.var_9a86a331.size );
        
        for ( wave = 0; wave < level.doa.var_9a86a331.size ; wave++ )
        {
            while ( level flag::get( "doa_round_paused" ) || is_true( level.hostmigrationtimer ) )
            {
                waitframe( 1 );
            }
            
            if ( level flag::get( "doa_game_is_over" ) )
            {
                break;
            }
            
            level thread function_a87190c4( level.doa.var_9a86a331[ wave ] );
            wait level.doa.var_9a86a331[ wave ].var_bd90dbbc;
        }
    }
    
    while ( level.doa.var_dcbded2.size )
    {
        wait 1;
    }
    
    endtime = gettime();
    namespace_1e25ad94::debugmsg( "Round " + level.doa.roundnumber + " took (" + ( endtime - starttime ) / 1000 + ") seconds to complete." );
    level flag::clear( "doa_round_spawning" );
    level.doa.var_9a86a331 = [];
}

// Namespace namespace_8c04284b/namespace_8c04284b
// Params 1
// Checksum 0xd88513c0, Offset: 0x8220
// Size: 0x358
function function_a87190c4( wave )
{
    level endon( #"round_over" );
    level endon( #"game_over" );
    endtime = gettime() + wave.var_d89d85d0 * 1000;
    
    while ( gettime() < endtime || wave.var_3ed31a82 > 0 )
    {
        while ( level flag::get( "doa_round_paused" ) || is_true( level.hostmigrationtimer ) )
        {
            waitframe( 1 );
        }
        
        if ( level flag::get( "doa_game_is_over" ) )
        {
            break;
        }
        
        wait 0.35;
        spot = [[ level.doa.var_39e3fa99 ]]->function_21d1be3d( wave.spawn_side );
        
        if ( level.doa.var_a77e4601.size )
        {
            var_7a8f2a62 = level.doa.var_a77e4601[ randomint( level.doa.var_a77e4601.size ) ];
        }
        else
        {
            var_7a8f2a62 = level.doa.var_329c97a3[ randomint( level.doa.var_329c97a3.size ) ];
        }
        
        if ( var_7a8f2a62 != level.doa.var_65a70dc )
        {
            if ( [[ var_7a8f2a62 ]]->function_baae6c9d( [[ level.doa.var_39e3fa99 ]]->getname() ) )
            {
                var_7a8f2a62 = level.doa.var_65a70dc;
            }
            
            var_9d97ad8e = [[ var_7a8f2a62 ]]->function_7f3e577e() || gettime() - [[ level.doa.var_39e3fa99 ]]->function_55916d40() > 60000;
            
            if ( !isinarray( level.doa.var_a77e4601, var_7a8f2a62 ) && var_9d97ad8e == 0 )
            {
                var_7a8f2a62 = level.doa.var_65a70dc;
            }
            
            if ( [[ var_7a8f2a62 ]]->canspawn() == 0 )
            {
                var_7a8f2a62 = level.doa.var_65a70dc;
            }
            
            if ( var_7a8f2a62 != level.doa.var_65a70dc )
            {
                [[ level.doa.var_39e3fa99 ]]->function_b2f9e813();
            }
        }
        
        wave.var_3ed31a82--;
        doa_enemy::function_a6b807ea( var_7a8f2a62, 1, spot.origin, 0, undefined, undefined, undefined, level.doa.var_39e3fa99 );
    }
    
    wave notify( #"done_spawning" );
}

// Namespace namespace_8c04284b/namespace_8c04284b
// Params 1
// Checksum 0xf498eec9, Offset: 0x8580
// Size: 0xf0
function function_3d25cb06( roundnumber = level.doa.roundnumber )
{
    level.doa.var_9a86a331 = [];
    max = 30 + level.doa.var_6c58d51 * 30;
    waves = 6 + int( roundnumber * 1.2 );
    
    if ( waves > max )
    {
        waves = max;
    }
    
    for ( i = 0; i < waves ; i++ )
    {
        level.doa.var_9a86a331[ i ] = function_2419e70a( i, roundnumber );
    }
}

// Namespace namespace_8c04284b/namespace_8c04284b
// Params 0
// Checksum 0x1506f5fd, Offset: 0x8678
// Size: 0x9a
function function_7802d126()
{
    switch ( randomint( 4 ) )
    {
        case 0:
            return "bottom";
        case 1:
            return "top";
        case 2:
            return "right";
        case 3:
            return "left";
    }
}

// Namespace namespace_8c04284b/namespace_8c04284b
// Params 1
// Checksum 0x620ae20, Offset: 0x8720
// Size: 0x92
function function_d60e0e9a( side )
{
    switch ( side )
    {
        case #"top":
            return "bottom";
        case #"bottom":
            return "top";
        case #"left":
            return "right";
        case #"right":
            return "left";
    }
}

// Namespace namespace_8c04284b/namespace_8c04284b
// Params 2, eflags: 0x4
// Checksum 0x3a7115ab, Offset: 0x87c0
// Size: 0x122
function private function_2419e70a( wave_number, round_number )
{
    wave = spawnstruct();
    wave.var_d89d85d0 = 1 + randomfloatrange( 0, 1 + wave_number * 0.3 ) + randomfloatrange( 0, 1 + round_number * 0.2 );
    wave.spawn_side = function_7802d126();
    wave.var_bd90dbbc = 1 + randomfloatrange( 0, wave.var_d89d85d0 * 0.6 );
    wave.var_3ed31a82 = int( wave.var_d89d85d0 / 0.35 * 0.35 );
    wave.wavenumber = wave_number;
    return wave;
}

// Namespace namespace_8c04284b/namespace_8c04284b
// Params 0
// Checksum 0xc8fda893, Offset: 0x88f0
// Size: 0x30, Type: bool
function function_3af22009()
{
    if ( !isdefined( self.endtime ) )
    {
        return false;
    }
    
    return gettime() > self.endtime && self.var_3ed31a82 <= 0;
}

// Namespace namespace_8c04284b/namespace_8c04284b
// Params 0
// Checksum 0x6ea1c0e2, Offset: 0x8928
// Size: 0x356
function function_67a3bb43()
{
    level endon( #"round_over" );
    level endon( #"game_over" );
    self notify( "3c792a52f0915283" );
    self endon( "3c792a52f0915283" );
    result = self waittill( #"hash_b1f03f83d7dde45" );
    
    if ( !isdefined( self.starttime ) )
    {
        self.starttime = gettime();
        self.endtime = self.starttime + self.var_d89d85d0 * 1000;
    }
    
    while ( !self function_3af22009() )
    {
        self.var_1834860 = result.var_1834860;
        self.wanted = result.wanted;
        
        while ( self.wanted )
        {
            spot = [[ level.doa.var_39e3fa99 ]]->function_21d1be3d( self.spawn_side );
            
            if ( level.doa.var_a77e4601.size )
            {
                var_7a8f2a62 = level.doa.var_a77e4601[ randomint( level.doa.var_a77e4601.size ) ];
            }
            else
            {
                var_7a8f2a62 = level.doa.var_329c97a3[ randomint( level.doa.var_329c97a3.size ) ];
            }
            
            if ( [[ var_7a8f2a62 ]]->function_baae6c9d( [[ level.doa.var_39e3fa99 ]]->getname() ) )
            {
                var_7a8f2a62 = level.doa.var_65a70dc;
            }
            
            if ( !isinarray( level.doa.var_a77e4601, var_7a8f2a62 ) && [[ var_7a8f2a62 ]]->function_7f3e577e() == 0 )
            {
                var_7a8f2a62 = level.doa.var_65a70dc;
            }
            
            if ( [[ var_7a8f2a62 ]]->canspawn() == 0 )
            {
                var_7a8f2a62 = level.doa.var_65a70dc;
            }
            
            self.var_3ed31a82 -= 1;
            self.wanted--;
            doa_enemy::function_a6b807ea( var_7a8f2a62, 1, spot.origin, 0, undefined, undefined, undefined, level.doa.var_39e3fa99, self.var_1834860 );
        }
        
        /#
            if ( is_true( level.doa.var_2409dcb5 ) )
            {
                level thread namespace_1e25ad94::debugline( spot.origin, [[ level.doa.var_39e3fa99 ]]->function_ffcf1d1(), self.var_7f9fdec7, ( 1, 0, 0 ) );
            }
        #/
    }
    
    self.alldone = 1;
}

// Namespace namespace_8c04284b/namespace_8c04284b
// Params 0
// Checksum 0x5b4cbd0c, Offset: 0x8c88
// Size: 0x73c
function function_9e0d71e5()
{
    self notify( "1a1bc0ddc2889cfa" );
    self endon( "1a1bc0ddc2889cfa" );
    level endon( #"game_over" );
    level endon( #"round_over" );
    level flag::set( "doa_round_spawning" );
    starttime = gettime();
    var_d517bf3a = 1;
    
    if ( level flag::get( "challenge_round_spawnOverride" ) )
    {
        level flag::wait_till_clear( "challenge_round_spawnOverride" );
        var_d517bf3a = level.doa.var_6c58d51 > 0;
    }
    
    if ( var_d517bf3a )
    {
        namespace_1e25ad94::debugmsg( "Round " + level.doa.roundnumber + " starting at: " + starttime + " Waves expected: " + level.doa.var_9a86a331.size );
        
        for ( wave = 0; wave < level.doa.var_9a86a331.size ; wave++ )
        {
            [[ level.doa.var_39e3fa99 ]]->function_25962665( level.doa.var_9a86a331[ wave ] );
        }
        
        level.doa.var_9a86a331 = [];
        var_68280a24 = [[ level.doa.var_39e3fa99 ]]->function_cc773c53();
        var_fe3c2d16 = [[ level.doa.var_39e3fa99 ]]->function_786b9d39();
        waves = [];
        waves[ #"top" ] = [[ level.doa.var_39e3fa99 ]]->function_ee30f092( "top" );
        
        if ( isdefined( waves[ #"top" ] ) )
        {
            waves[ #"top" ] thread function_67a3bb43();
        }
        
        waves[ #"bottom" ] = [[ level.doa.var_39e3fa99 ]]->function_ee30f092( "bottom" );
        
        if ( isdefined( waves[ #"bottom" ] ) )
        {
            waves[ #"bottom" ] thread function_67a3bb43();
        }
        
        waves[ #"left" ] = [[ level.doa.var_39e3fa99 ]]->function_ee30f092( "left" );
        
        if ( isdefined( waves[ #"left" ] ) )
        {
            waves[ #"left" ] thread function_67a3bb43();
        }
        
        waves[ #"right" ] = [[ level.doa.var_39e3fa99 ]]->function_ee30f092( "right" );
        
        if ( isdefined( waves[ #"right" ] ) )
        {
            waves[ #"right" ] thread function_67a3bb43();
        }
        
        done = 0;
        var_1834860 = 100;
        
        while ( !done )
        {
            waves = array::randomize( waves );
            
            foreach ( wave in waves )
            {
                wave notify( #"hash_b1f03f83d7dde45", { #var_1834860:var_1834860, #wanted:randomintrange( var_68280a24, var_fe3c2d16 ) } );
                var_1834860++;
                
                while ( wave.var_bd90dbbc > 0 )
                {
                    wait 0.2;
                    wave.var_bd90dbbc -= 0.2;
                }
            }
            
            waitframe( 1 );
            done = 1;
            var_77fcdba0 = [];
            
            foreach ( wave in waves )
            {
                nextside = undefined;
                
                if ( is_true( wave.alldone ) )
                {
                    nextside = [[ level.doa.var_39e3fa99 ]]->function_ee30f092( wave.spawn_side );
                    
                    if ( isdefined( nextside ) )
                    {
                        nextside thread function_67a3bb43();
                        
                        if ( !isdefined( var_77fcdba0 ) )
                        {
                            var_77fcdba0 = [];
                        }
                        else if ( !isarray( var_77fcdba0 ) )
                        {
                            var_77fcdba0 = array( var_77fcdba0 );
                        }
                        
                        var_77fcdba0[ var_77fcdba0.size ] = nextside;
                    }
                    
                    continue;
                }
                
                if ( !isdefined( var_77fcdba0 ) )
                {
                    var_77fcdba0 = [];
                }
                else if ( !isarray( var_77fcdba0 ) )
                {
                    var_77fcdba0 = array( var_77fcdba0 );
                }
                
                var_77fcdba0[ var_77fcdba0.size ] = wave;
            }
            
            waves = var_77fcdba0;
            
            if ( waves.size )
            {
                done = 0;
            }
        }
    }
    
    level notify( #"hash_7ebdbe412d2fed17" );
    wait 1;
    
    while ( level.doa.var_dcbded2.size )
    {
        waitframe( 1 );
    }
    
    endtime = gettime();
    namespace_1e25ad94::debugmsg( "Round " + level.doa.roundnumber + " took (" + ( endtime - starttime ) / 1000 + ") seconds to complete." );
    level flag::clear( "doa_round_spawning" );
}

