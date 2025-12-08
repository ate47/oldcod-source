#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2440f86f9cd325ac;
#using script_2474a362752098d2;
#using script_2a5bf5b4a00cee0d;
#using script_3faf478d5b0850fe;
#using script_40f967ad5d18ea74;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_50fca1a24ae351;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_634ae70c663d1cc9;
#using script_683a55734f15d50e;
#using script_68cdf0ca5df5e;
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

#namespace namespace_5a917022;

// Namespace namespace_5a917022/namespace_5a917022
// Params 0
// Checksum 0x53092434, Offset: 0x4d0
// Size: 0x548
function init()
{
    objective_add( 14, "invisible", ( 0, 0, 0 ), #"hash_3c82fb0aa0fa4fed" );
    clientfield::register( "world", "set_bonus_room", 1, 4, "int" );
    level.doa.var_8f6ccf63 = [];
    rooms = struct::get_array( "zombietron_bonus_room", "targetname" );
    
    foreach ( room in rooms )
    {
        room.name = room.script_noteworthy;
        room.id = function_b3411080( room.name );
        room.var_d52d06ee = function_d52d06ee( room.id );
        room.var_8028986b = 0;
        room.var_74606c86 = 1;
        room.var_7d320f40 = 1;
        room.flipcamera = 0;
        room.timeout = 60;
        room.lightstate = 0;
        
        if ( isdefined( room.script_int ) )
        {
            room.var_8028986b = int( room.script_int );
        }
        
        if ( isdefined( room.script_parameters ) )
        {
            args = strtok( room.script_parameters, ";" );
            room.freecam = int( args[ 0 ] );
            
            if ( args.size > 1 )
            {
                room.flipcamera = int( args[ 1 ] );
            }
            
            if ( args.size > 2 )
            {
                room.var_74606c86 = int( args[ 2 ] );
            }
            
            if ( args.size > 3 )
            {
                room.var_7d320f40 = int( args[ 3 ] );
            }
            
            if ( args.size > 4 )
            {
                room.timeout = int( args[ 4 ] );
            }
            
            if ( args.size > 5 )
            {
                room.lightstate = int( args[ 5 ] );
            }
        }
        
        level.doa.var_8f6ccf63[ room.script_noteworthy ] = room;
        room.var_12ae4b83 = struct::get_array( "zombietron_bonus_room_player_starts_" + room.name );
        room.items = struct::get_array( "zombietron_bonus_room_item_" + room.name );
        room.npcs = struct::get_array( "zombietron_bonus_room_npc_" + room.name );
        room.var_f9c9c0 = struct::get_array( "zombietron_bonus_room_hazard_" + room.name );
        room.generators = struct::get_array( "zombietron_bonus_room_generator_" + room.name );
        room.doors = struct::get_array( "zombietron_bonus_room_door_" + room.name );
        room.dungeon = struct::get( "zombietron_bonus_room_dungeon_" + room.name, "script_noteworthy" );
        room.spawned_items = [];
        room.var_1406397f = getent( "zombietron_bonus_room_exit_trigger_" + room.name, "targetname" );
        assert( room.var_12ae4b83.size == 4 );
        assert( isdefined( room.var_1406397f ), "<dev string:x38>" );
        var_663588d = "Zombietron/Debug/AutoTesting/BonusRoomSoak/";
        cmdline = "scr_bonus_room_activate " + room.name + "; zombie_devgui bonusroomsoak";
        util::add_devgui( var_663588d + room.name, cmdline );
    }
}

// Namespace namespace_5a917022/namespace_5a917022
// Params 0
// Checksum 0xff106a14, Offset: 0xa20
// Size: 0x250
function function_85615bbb()
{
    rooms = struct::get_array( "zombietron_bonus_room", "targetname" );
    var_663588d = "Zombietron/Bonus Rooms/";
    label = "Disable Room Timeouts (TRUE):0";
    util::function_85c62761( var_663588d + label );
    label = "Disable Room Timeouts (FALSE):0";
    util::function_85c62761( var_663588d + label );
    
    foreach ( room in rooms )
    {
        util::function_85c62761( var_663588d + room.name );
    }
    
    util::function_85c62761( var_663588d );
    util::wait_network_frame();
    label = is_true( level.doa.var_206393b4 ) ? "Disable Room Timeouts (TRUE):0" : "Disable Room Timeouts (FALSE):0";
    util::add_devgui( var_663588d + label, "zombie_devgui bonusTimeoutDisableToggle" );
    
    foreach ( room in rooms )
    {
        cmdline = "scr_bonus_room_activate " + room.name + "; zombie_devgui bonusroom";
        util::add_devgui( var_663588d + room.name, cmdline );
    }
}

// Namespace namespace_5a917022/namespace_5a917022
// Params 0
// Checksum 0x8198108f, Offset: 0xc78
// Size: 0x3c
function main()
{
    level.doa.var_6f3d327 = undefined;
    level.doa.var_206393b4 = 0;
    function_85615bbb();
}

// Namespace namespace_5a917022/namespace_5a917022
// Params 0
// Checksum 0x10fbfe71, Offset: 0xcc0
// Size: 0x3c
function function_9da359eb()
{
    level.doa.var_206393b4 = !level.doa.var_206393b4;
    function_85615bbb();
}

// Namespace namespace_5a917022/namespace_5a917022
// Params 1
// Checksum 0xa40dbd4b, Offset: 0xd08
// Size: 0x36, Type: bool
function function_d52d06ee( id )
{
    if ( id == 6 )
    {
        return true;
    }
    
    if ( id == 7 )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_5a917022/namespace_5a917022
// Params 1
// Checksum 0x5fde86e4, Offset: 0xd48
// Size: 0xfa
function function_b3411080( name )
{
    switch ( name )
    {
        case #"armory":
            return 1;
        case #"coop":
            return 2;
        case #"treasure":
            return 3;
        case #"tradingpost":
            return 4;
        case #"nukebunker":
            return 5;
        case #"templeofdoom":
            return 6;
        case #"crypt":
            return 7;
        case #"cellar":
            return 8;
        default:
            assert( 0, "<dev string:x69>" );
            break;
    }
}

// Namespace namespace_5a917022/namespace_5a917022
// Params 1
// Checksum 0xa0d7a618, Offset: 0xe50
// Size: 0xfa
function function_d496f180( name )
{
    switch ( name )
    {
        case #"armory":
            return 13;
        case #"coop":
            return 14;
        case #"treasure":
            return 15;
        case #"tradingpost":
            return 16;
        case #"nukebunker":
            return 17;
        case #"templeofdoom":
            return 18;
        case #"crypt":
            return 19;
        case #"cellar":
            return 20;
        default:
            assert( 0, "<dev string:x7e>" );
            break;
    }
}

// Namespace namespace_5a917022/namespace_5a917022
// Params 1
// Checksum 0x7ab29220, Offset: 0xf58
// Size: 0x9e
function function_c8892b0f( name )
{
    foreach ( room in level.doa.var_8f6ccf63 )
    {
        if ( room.name === name )
        {
            return room;
        }
    }
}

// Namespace namespace_5a917022/namespace_5a917022
// Params 1
// Checksum 0x556153eb, Offset: 0x1000
// Size: 0x128
function function_3db4a0b1( roundnumber = level.doa.roundnumber )
{
    var_851aa222 = [];
    
    foreach ( room in level.doa.var_8f6ccf63 )
    {
        if ( is_true( room.var_d52d06ee ) && !isdefined( room.var_5250d109 ) )
        {
            continue;
        }
        
        if ( roundnumber >= room.var_8028986b )
        {
            var_851aa222[ var_851aa222.size ] = room;
        }
    }
    
    if ( var_851aa222.size > 0 )
    {
        return var_851aa222[ randomint( var_851aa222.size ) ];
    }
}

// Namespace namespace_5a917022/namespace_5a917022
// Params 0
// Checksum 0xfa975dad, Offset: 0x1130
// Size: 0xe8, Type: bool
function function_7230f033()
{
    if ( isdefined( level.doa.var_848746c8 ) )
    {
        room = function_c8892b0f( level.doa.var_848746c8 );
        level thread function_898ca25f( room );
        level.doa.var_848746c8 = undefined;
        return true;
    }
    
    roll = randomint( 100 );
    
    if ( roll > 15 )
    {
        return false;
    }
    
    room = function_3db4a0b1();
    
    if ( !isdefined( room ) )
    {
        return false;
    }
    
    level thread function_898ca25f( room );
    return true;
}

// Namespace namespace_5a917022/namespace_5a917022
// Params 0
// Checksum 0x2ffc21ef, Offset: 0x1220
// Size: 0x210
function function_8dd06da3()
{
    if ( level.doa.teleporter_locs.size > 0 )
    {
        level.doa.teleporter_locs = arraysortclosest( level.doa.teleporter_locs, level.doa.var_187ed224.origin );
        furthest = level.doa.teleporter_locs[ level.doa.teleporter_locs.size - 1 ];
        level.doa.teleporter_locs = [];
        level.doa.var_9f48249a = namespace_dfc652ee::itemspawn( namespace_dfc652ee::function_2c9923d7( 39 ), furthest.origin, undefined, undefined, 1 );
        
        if ( isdefined( level.doa.var_9f48249a ) )
        {
            level.doa.var_9f48249a clientfield::set( "set_icon", 9 );
            level.doa.var_9f48249a notify( #"hash_2a866f50cc161ca8" );
            objective_onentity( 15 + 1, level.doa.var_9f48249a );
            objective_setstate( 15 + 1, "active" );
            objective_setstate( 15, "invisible" );
            level thread function_160237df( level.doa.var_9f48249a );
        }
    }
    
    level notify( #"hash_40456743c6415fcd" );
}

// Namespace namespace_5a917022/namespace_5a917022
// Params 1
// Checksum 0x6a8002b5, Offset: 0x1438
// Size: 0xac
function function_160237df( var_82be662a )
{
    level endon( #"hash_593a6814c28d14e7", #"game_over" );
    
    if ( isdefined( var_82be662a ) )
    {
        var_82be662a endon( #"death" );
        level waittill( #"ladder_up" );
        
        if ( isdefined( level.doa.var_6f3d327 ) )
        {
            level.doa.var_6f3d327.var_1406397f notify( #"trigger" );
        }
    }
}

// Namespace namespace_5a917022/namespace_5a917022
// Params 1
// Checksum 0xf9d13cc7, Offset: 0x14f0
// Size: 0xe28
function function_898ca25f( room )
{
    level endon( #"game_over" );
    level notify( #"hash_7270a59e1f502d96" );
    level.doa.var_6f3d327 = room;
    var_fbefebc = level.doa.var_ecff3871;
    oldstate = level.lighting_state;
    namespace_ec06fe4a::function_87612422( room.var_12ae4b83[ 0 ].origin, room.var_12ae4b83[ 0 ].angles, 1, 8, room.lightstate );
    
    if ( isdefined( room.dungeon ) )
    {
        idx = namespace_981c1f3c::function_61e1a1cb( isdefined( room.dungeon.targetname ) ? room.dungeon.targetname : room.name );
        
        if ( isdefined( idx ) )
        {
            level.doa.dungeons[ idx ].var_9105f204 = array( level.doa.var_65a70dc );
            level.doa.dungeons[ idx ].var_40ca2d09 = array( doa_enemy::function_d7c5adee( "spider" ) );
            level.doa.var_a7ccb320 = &function_8dd06da3;
            level namespace_981c1f3c::function_c88b8726( idx );
            var_5b55ba1f = namespace_4dae815d::function_21cd3890( 5 );
            
            foreach ( player in getplayers() )
            {
                player thread namespace_981c1f3c::function_fe17d41e();
            }
        }
    }
    
    players = namespace_7f5aeb59::function_23e1f90f();
    idx = 0;
    room.var_5250d109 = gettime();
    lastposition = players[ 0 ].origin;
    lastangles = players[ 0 ].angles;
    
    foreach ( player in players )
    {
        player.doa.var_3cf36932 = 0;
        player.doa.var_4f3aee7b = 1;
        player setorigin( room.var_12ae4b83[ idx ].origin );
        player setplayerangles( room.var_12ae4b83[ idx ].angles );
        idx++;
    }
    
    foreach ( item in room.items )
    {
        if ( isdefined( item.script_int ) )
        {
            roll = int( item.script_int );
            
            if ( randomint( 100 ) > roll )
            {
                continue;
            }
        }
        
        room.spawned_items[ room.spawned_items.size ] = function_edc2fabf( item, room.var_74606c86, room.var_7d320f40 );
    }
    
    foreach ( door in room.doors )
    {
        door.model = namespace_f63bdb08::function_2a1e5c1f( door.origin, door.angles, door.script_string, undefined, 1, 2, door.script_parameters );
    }
    
    foreach ( npc in room.npcs )
    {
        toks = strtok( npc.script_noteworthy, ";" );
        
        if ( toks.size > 1 )
        {
            mask = int( toks[ 1 ] );
            
            if ( mask & 1 && isdefined( level.doa.var_39e3fa99 ) )
            {
                continue;
            }
            
            if ( mask & 2 && isdefined( level.doa.var_a77e6349 ) )
            {
                continue;
            }
            
            if ( mask & 4 && isdefined( level.doa.var_182fb75a ) )
            {
                continue;
            }
        }
        
        def = doa_enemy::function_d7c5adee( toks[ 0 ] );
        count = 1;
        
        if ( isdefined( npc.script_int ) )
        {
            count = int( npc.script_int );
        }
        
        if ( isdefined( def ) )
        {
            doa_enemy::function_a6b807ea( def, count, npc.origin, 0, undefined );
        }
    }
    
    foreach ( generator in room.generators )
    {
        a_toks = strtok( generator.script_string, "," );
        var_44eec847 = a_toks[ 0 ];
        
        if ( a_toks.size >= 2 )
        {
            radius = int( a_toks[ 1 ] );
        }
        else
        {
            radius = 800;
        }
        
        if ( a_toks.size >= 3 )
        {
            height = int( a_toks[ 2 ] );
        }
        
        if ( a_toks.size >= 4 )
        {
            maxalive = int( a_toks[ 3 ] );
        }
        
        generator = namespace_c85a46fe::function_4c16ce2c( var_44eec847, generator.origin, generator.angles, radius, height, maxalive, 0 );
        generator.var_64a23077 = [[ generator ]]->getmodel();
    }
    
    namespace_268747c0::function_96e2f261( room.var_f9c9c0, 0 );
    players = namespace_7f5aeb59::function_23e1f90f();
    
    foreach ( player in players )
    {
        player clientfield::increment_to_player( "resetCamera" );
    }
    
    util::wait_network_frame();
    level clientfield::set( "set_bonus_room", room.id );
    util::wait_network_frame();
    namespace_8c04284b::function_a70ff03e( room.flipcamera );
    players = namespace_7f5aeb59::function_23e1f90f();
    
    foreach ( player in players )
    {
        if ( is_true( room.freecam ) )
        {
            player clientfield::increment_to_player( "resetCamera" );
        }
    }
    
    level util::set_lighting_state( room.lightstate, 0 );
    level clientfield::set( "setTOD", room.lightstate );
    level thread function_3c47fbe0( room );
    level thread namespace_7f5aeb59::function_836aeb74( 1.5 );
    namespace_9fc66ac::function_a77649db( room.name, 1 );
    level doa_banner::function_7a0e5387( function_d496f180( room.name ) );
    objective_setposition( 14, room.var_1406397f.origin );
    objective_setstate( 14, "active" );
    level notify( #"hash_52ca1213084f29fa" );
    
    if ( room.timeout === 999 || is_true( level.doa.var_206393b4 ) )
    {
        room.var_1406397f waittill( #"trigger" );
    }
    else
    {
        room.var_1406397f waittilltimeout( room.timeout, #"trigger" );
    }
    
    objective_setstate( 14, "invisible" );
    namespace_ec06fe4a::function_87612422( lastposition, lastangles, 1, 8, oldstate );
    level thread namespace_7f5aeb59::function_67f054d7( 1.5 );
    level waittill( #"hash_1b322de3d2e3e781" );
    
    if ( isdefined( var_5b55ba1f ) )
    {
        namespace_4dae815d::function_21cd3890( var_5b55ba1f );
    }
    
    foreach ( player in namespace_7f5aeb59::function_23e1f90f() )
    {
        player.doa.var_4f3aee7b = undefined;
    }
    
    level util::set_lighting_state( oldstate, 0 );
    level clientfield::set( "setTOD", oldstate );
    
    if ( isdefined( var_fbefebc ) )
    {
        namespace_8c04284b::function_a70ff03e( var_fbefebc );
    }
    
    level thread namespace_ec06fe4a::function_de70888a();
    level notify( #"hash_593a6814c28d14e7" );
}

// Namespace namespace_5a917022/namespace_5a917022
// Params 1
// Checksum 0x5d0ef4e1, Offset: 0x2320
// Size: 0x3cc
function function_3c47fbe0( room )
{
    level waittill( #"hash_593a6814c28d14e7", #"game_reset" );
    level clientfield::set( "set_bonus_room", 0 );
    namespace_9fc66ac::function_a77649db( room.name, 0 );
    
    foreach ( trap in room.var_f9c9c0 )
    {
        trap notify( #"destroy_hazard", { #var_760a0807:1 } );
    }
    
    foreach ( generator in room.generators )
    {
        if ( isdefined( generator.var_64a23077 ) )
        {
            [[ generator.var_64a23077.generator ]]->destroy();
        }
    }
    
    level thread namespace_ec06fe4a::function_de70888a();
    
    foreach ( door in room.doors )
    {
        if ( isdefined( door.model ) )
        {
            door.model delete();
        }
    }
    
    foreach ( item in room.spawned_items )
    {
        if ( !isdefined( item ) )
        {
            continue;
        }
        
        item delete();
    }
    
    room.spawned_items = [];
    namespace_491fa2b2::function_df55eb9d( 0 );
    
    if ( isdefined( room.dungeon ) && isdefined( level.doa.var_182fb75a ) )
    {
        level thread namespace_981c1f3c::function_8790b64a();
        objective_setstate( 15 + 1, "invisible" );
        level.doa.var_a7ccb320 = undefined;
    }
    
    waitframe( 1 );
    level notify( #"hash_7dd47c99b7707b1c" );
    level.doa.var_6f3d327 = undefined;
    level doa_banner::function_7a0e5387();
}

// Namespace namespace_5a917022/namespace_5a917022
// Params 3
// Checksum 0x6194538d, Offset: 0x26f8
// Size: 0x4c0
function function_edc2fabf( item, var_74606c86, var_7d320f40 )
{
    toks = strtok( item.script_noteworthy, ";" );
    
    if ( toks.size > 1 )
    {
        mask = int( toks[ 1 ] );
        
        if ( mask & 1 && isdefined( level.doa.var_39e3fa99 ) )
        {
            return undefined;
        }
        
        if ( mask & 2 && isdefined( level.doa.var_a77e6349 ) )
        {
            return undefined;
        }
        
        if ( mask & 4 && isdefined( level.doa.var_182fb75a ) )
        {
            return undefined;
        }
    }
    
    type = toks[ 0 ];
    
    if ( type === "lootitem" )
    {
        assert( isdefined( item.script_parameters ), "<dev string:x97>" );
        object = namespace_41f5b853::spawnlootitem( item.origin, item.angles, item.script_parameters );
        
        if ( isdefined( object ) )
        {
            object.target = item.target;
        }
        
        return object;
    }
    else if ( type === "pick one" )
    {
        choices = strtok( item.script_parameters, ";" );
        assert( choices.size > 1, "<dev string:xbc>" );
        choice = choices[ randomint( choices.size ) ];
        def = namespace_dfc652ee::function_6265bde4( choice );
        
        if ( isdefined( def ) )
        {
            pickup = namespace_dfc652ee::itemspawn( def, item.origin, item.angles, undefined, 1, "none", undefined, undefined, undefined, undefined, 0 );
        }
        else
        {
            object = namespace_41f5b853::spawnlootitem( item.origin, item.angles, choice );
            
            if ( isdefined( object ) )
            {
                object.target = item.target;
            }
            
            return object;
        }
    }
    else if ( type === "treasure_pile" )
    {
        radius = isdefined( item.radius ) ? item.radius : 128;
        level namespace_dfc652ee::function_68442ee7( item.origin, 20, radius, 1 );
        level namespace_dfc652ee::function_d06cbfe8( item.origin, 10, radius, 0, undefined, undefined, 0.75 );
        return undefined;
    }
    else
    {
        def = namespace_dfc652ee::function_6265bde4( type );
        assert( isdefined( def ), "<dev string:xde>" );
        pickup = namespace_dfc652ee::itemspawn( def, item.origin, item.angles, undefined, 1, "none", undefined, undefined, undefined, undefined, 0 );
    }
    
    if ( isdefined( pickup ) )
    {
        if ( [[ def ]]->gettype() != 32 )
        {
            if ( is_true( var_74606c86 ) )
            {
                pickup notify( #"stopidle" );
            }
            
            if ( is_true( var_7d320f40 ) )
            {
                pickup notify( #"hash_2a866f50cc161ca8" );
            }
            
            waitframe( 1 );
        }
        
        pickup.angles = item.angles;
        pickup.origin = item.origin;
        pickup.radius = 18;
        level thread function_92f612b2( def, pickup );
    }
    
    return pickup;
}

// Namespace namespace_5a917022/namespace_5a917022
// Params 2
// Checksum 0xc7acd2d8, Offset: 0x2bc0
// Size: 0x8a
function function_92f612b2( def, pickup )
{
    switch ( [[ def ]]->gettype() )
    {
        case 32:
            pickup namespace_3a8e4a3::function_22c4e231( 1 );
            break;
        case 6:
            break;
        default:
            break;
    }
}

// Namespace namespace_5a917022/namespace_5a917022
// Params 2
// Checksum 0xe82cba52, Offset: 0x2c58
// Size: 0x2c4
function function_23ea6695( trigger, room )
{
    self notify( "1af0ab9f1dfdd4e2" );
    self endon( "1af0ab9f1dfdd4e2" );
    assert( isdefined( room ) );
    assert( isdefined( trigger ) );
    trigger endon( #"death" );
    trigger waittill( #"trigger" );
    assert( isdefined( trigger.var_4200bfbf ) && trigger.var_4200bfbf.size >= 4, "<dev string:x10e>" );
    trigger triggerenable( 0 );
    trigger.visited = 1;
    level thread namespace_7f5aeb59::function_67f054d7( 1.5 );
    level waittill( #"hash_1b322de3d2e3e781" );
    
    if ( isdefined( trigger.var_ee2cd39c ) )
    {
        trigger.var_ee2cd39c solid();
        trigger.var_ee2cd39c show();
    }
    
    level thread function_898ca25f( room );
    level waittill( #"hash_7dd47c99b7707b1c" );
    players = namespace_7f5aeb59::function_23e1f90f();
    idx = 0;
    
    foreach ( player in players )
    {
        player setorigin( trigger.var_4200bfbf[ idx ].origin );
        player setplayerangles( trigger.var_4200bfbf[ idx ].angles );
        player clientfield::increment_to_player( "resetCamera" );
        idx++;
    }
    
    wait 1;
    level thread namespace_7f5aeb59::function_836aeb74( 1.5 );
}

// Namespace namespace_5a917022/namespace_5a917022
// Params 0
// Checksum 0x57d85234, Offset: 0x2f28
// Size: 0x3b8
function function_e5c7bce7()
{
    level endon( #"game_over" );
    room = level.doa.var_848746c8;
    var_dffc76c2 = 0;
    level.doa.var_1f2c7d5f = 1;
    
    while ( true )
    {
        level.doa.var_848746c8 = room;
        wait 3;
        level notify( #"round_over" );
        level flag::clear( "doa_round_spawning" );
        level thread namespace_ec06fe4a::function_de70888a();
        level namespace_ec06fe4a::function_b6b79fd1();
        namespace_ec06fe4a::clearallcorpses();
        wait 2;
        
        while ( true )
        {
            wait 1;
            guys = namespace_7f5aeb59::function_23e1f90f();
            var_271662e8 = [[ level.doa.var_39e3fa99 ]]->function_dfb49846();
            
            if ( var_271662e8.size )
            {
                exit = var_271662e8[ randomint( var_271662e8.size ) ];
                exit notify( #"trigger", { #activator:guys[ randomint( guys.size ) ] } );
                break;
            }
            
            if ( isdefined( level.doa.teleporter ) && randomint( 5 ) == 0 )
            {
                guys[ 0 ] setorigin( level.doa.teleporter.origin + ( 0, 0, 32 ) );
                break;
            }
        }
        
        result = level waittilltimeout( 10, #"hash_52ca1213084f29fa" );
        
        if ( result._notify == "timeout" )
        {
            continue;
        }
        
        if ( isdefined( level.doa.var_a7ccb320 ) && flag::get( "dungeon_building" ) )
        {
            level waittill( #"hash_40456743c6415fcd" );
        }
        
        while ( true )
        {
            wait 1;
            
            if ( isdefined( level.doa.var_6f3d327 ) )
            {
                level.doa.var_6f3d327.var_1406397f notify( #"trigger" );
                break;
            }
        }
        
        level waittill( #"hash_7dd47c99b7707b1c" );
        var_dffc76c2++;
        namespace_1e25ad94::function_4e3cfad( "Bonus Room Evolution: " + var_dffc76c2, undefined, undefined, undefined, 10 );
        level waittill( #"hash_58caf0ade03043bb" );
        
        if ( is_true( level.doa.var_d31bcf30 ) )
        {
            level waittill( #"dungeon_destroyed" );
        }
    }
}

