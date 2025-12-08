#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_40f967ad5d18ea74;
#using script_47851dbeea22fe66;
#using script_48e04a393ec6d855;
#using script_4d748e58ce25b60c;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_73ad7687b437e468;
#using script_746267f0669c40ae;
#using script_74a56359b7d02ab6;
#using script_dc59353021baee1;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_c004634e;

// Namespace namespace_c004634e/namespace_c004634e
// Params 0
// Checksum 0x4ea7d867, Offset: 0x578
// Size: 0xda
function init()
{
    level.var_e1a08718 = &function_1210f64b;
    level.var_21910540 = &function_1648f5a1;
    level.var_8efaa0c8 = &function_a4c07e18;
    level.var_84c76431 = &function_d5a0313a;
    level.doa.var_e4d7094b = [];
    level.doa.var_4cdaff39 = [];
    level.doa.var_830f8412 = [];
    level.doa.var_fa21a3aa = 0;
    level.doa.var_f23e2931 = 0;
    level.doa.var_f5f2b4e8 = 0;
}

// Namespace namespace_c004634e/namespace_c004634e
// Params 1
// Checksum 0x14f4ac44, Offset: 0x660
// Size: 0x5a
function function_4e886036( room )
{
    if ( isdefined( level.doa.var_e4d7094b[ room.template.rg_room ] ) )
    {
        return level.doa.var_e4d7094b[ room.template.rg_room ];
    }
}

// Namespace namespace_c004634e/namespace_c004634e
// Params 2
// Checksum 0x5a7f4de6, Offset: 0x6c8
// Size: 0x134
function function_4f9f7687( roomname, iconname )
{
    if ( !isinarray( level.doa.var_830f8412, roomname ) )
    {
        if ( !isdefined( level.doa.var_830f8412 ) )
        {
            level.doa.var_830f8412 = [];
        }
        else if ( !isarray( level.doa.var_830f8412 ) )
        {
            level.doa.var_830f8412 = array( level.doa.var_830f8412 );
        }
        
        level.doa.var_830f8412[ level.doa.var_830f8412.size ] = roomname;
        level.doa.var_4cdaff39[ roomname ] = 0;
        level.doa.var_e4d7094b[ roomname ] = iconname;
    }
    
    namespace_f27a9d0d::function_2ff463e2( roomname );
}

// Namespace namespace_c004634e/namespace_c004634e
// Params 1
// Checksum 0xb0dd4a57, Offset: 0x808
// Size: 0x494
function function_1648f5a1( name = "" )
{
    switch ( name )
    {
        case #"jungle_1_dungeon4":
            function_4f9f7687( "hall_dirt_2iflogger_exit_1024x1024", "doa_hud_icon_dungeon_hall_straight" );
            function_4f9f7687( "room_2b_exit_1024x1024", "doa_hud_icon_dungeon_room_octagon" );
            function_4f9f7687( "room_5_exit_1024x1024", "doa_hud_icon_dungeon_room_octagon" );
        case #"cellar":
            function_4f9f7687( "room_1_exit_1024x1024", "doa_hud_icon_dungeon_room_square" );
            function_4f9f7687( "room_2i_exit_1024x1024", "doa_hud_icon_dungeon_room_square" );
            function_4f9f7687( "room_3_exit_1024x1024", "doa_hud_icon_dungeon_room_square" );
            function_4f9f7687( "room_4_exit_1024x1024", "doa_hud_icon_dungeon_room_square" );
            function_4f9f7687( "hall_dirt_2_exit_ver1_1024x1024", "doa_hud_icon_dungeon_hall_straight" );
            function_4f9f7687( "hall_dirt_2_exit_ver2_1024x1024", "doa_hud_icon_dungeon_hall_straight" );
            function_4f9f7687( "hall_dirt_2l_exit_ver1_1024x1024", "doa_hud_icon_dungeon_hall_right_angle" );
            function_4f9f7687( "hall_dirt_2l_exit_ver2_1024x1024", "doa_hud_icon_dungeon_hall_right_angle" );
            function_4f9f7687( "hall_dirt_3_exit_ver1_1024x1024", "doa_hud_icon_dungeon_hall_inverse_t" );
            function_4f9f7687( "hall_dirt_4_exit_ver1_1024x1024", "doa_hud_icon_dungeon_hall_plus" );
            break;
        default:
            function_4f9f7687( "room_1_exit_1024x1024", "doa_hud_icon_dungeon_room_square" );
            function_4f9f7687( "room_1b_exit_1024x1024", "doa_hud_icon_dungeon_room_1b" );
            function_4f9f7687( "room_2b_exit_1024x1024", "doa_hud_icon_dungeon_room_octagon" );
            function_4f9f7687( "room_2i_exit_1024x1024", "doa_hud_icon_dungeon_room_square" );
            function_4f9f7687( "room_2l_exit_1024x1024", "doa_hud_icon_dungeon_room_square" );
            function_4f9f7687( "room_3_exit_1024x1024", "doa_hud_icon_dungeon_room_square" );
            function_4f9f7687( "room_3b_exit_1024x1024", "doa_hud_icon_dungeon_room_square" );
            function_4f9f7687( "room_4_exit_1024x1024", "doa_hud_icon_dungeon_room_square" );
            function_4f9f7687( "room_5_exit_1024x1024", "doa_hud_icon_dungeon_room_octagon" );
            function_4f9f7687( "hall_2i_exit_1024x1024", "doa_hud_icon_dungeon_hall_straight" );
            function_4f9f7687( "hall_2ii_exit_1024x1024", "doa_hud_icon_dungeon_hall_2ii" );
            function_4f9f7687( "hall_2ilava_exit_1024x1024", "doa_hud_icon_dungeon_hall_straight" );
            function_4f9f7687( "hall_2iflogger_exit_1024x1024", "doa_hud_icon_dungeon_hall_straight" );
            function_4f9f7687( "hall_2l_exit_1024x1024", "doa_hud_icon_dungeon_hall_right_angle" );
            function_4f9f7687( "hall_3_exit_1024x1024", "doa_hud_icon_dungeon_hall_inverse_t" );
            function_4f9f7687( "hall_3b_exit_1024x1024", "doa_hud_icon_dungeon_room_square" );
            function_4f9f7687( "hall_4_exit_1024x1024", "doa_hud_icon_dungeon_hall_plus" );
            function_4f9f7687( "hall_4l_exit_1024x1024", "doa_hud_icon_dungeon_hall_diamond" );
            break;
    }
    
    function_ed9ae881( name );
    function_5a3d60af( name );
    function_18276de3( name );
}

// Namespace namespace_c004634e/namespace_c004634e
// Params 1
// Checksum 0xd4c3eb81, Offset: 0xca8
// Size: 0xca8
function function_1a3f9fe1( expanded )
{
    level.var_e1daf6fe[ 0 ] = [];
    level.var_e1daf6fe[ 1 ] = array( { #var_fef51edb:"room_1_exit_1024x1024", #orientation:3 } );
    level.var_e1daf6fe[ 2 ] = array( { #var_fef51edb:"room_1_exit_1024x1024", #orientation:2 } );
    level.var_e1daf6fe[ 4 ] = array( { #var_fef51edb:"room_1_exit_1024x1024", #orientation:1 } );
    level.var_e1daf6fe[ 8 ] = array( { #var_fef51edb:"room_1_exit_1024x1024", #orientation:0 } );
    
    if ( is_true( expanded ) )
    {
        level.var_e1daf6fe[ 10 ] = array( { #var_fef51edb:"room_2i_exit_1024x1024", #orientation:0 }, { #var_fef51edb:"room_2b_exit_1024x1024", #orientation:0 } );
        level.var_e1daf6fe[ 5 ] = array( { #var_fef51edb:"room_2i_exit_1024x1024", #orientation:1 }, { #var_fef51edb:"room_2b_exit_1024x1024", #orientation:1 } );
    }
    else
    {
        level.var_e1daf6fe[ 10 ] = array( { #var_fef51edb:"room_2i_exit_1024x1024", #orientation:0 } );
        level.var_e1daf6fe[ 5 ] = array( { #var_fef51edb:"room_2i_exit_1024x1024", #orientation:1 } );
    }
    
    level.var_e1daf6fe[ 9 ] = array( { #var_fef51edb:"hall_dirt_2l_exit_ver1_1024x1024", #orientation:3 } );
    level.var_e1daf6fe[ 3 ] = array( { #var_fef51edb:"hall_dirt_2l_exit_ver1_1024x1024", #orientation:2 } );
    level.var_e1daf6fe[ 6 ] = array( { #var_fef51edb:"hall_dirt_2l_exit_ver2_1024x1024", #orientation:1 } );
    level.var_e1daf6fe[ 12 ] = array( { #var_fef51edb:"hall_dirt_2l_exit_ver2_1024x1024", #orientation:0 } );
    level.var_e1daf6fe[ 11 ] = array( { #var_fef51edb:"room_3_exit_1024x1024", #orientation:3 } );
    level.var_e1daf6fe[ 7 ] = array( { #var_fef51edb:"room_3_exit_1024x1024", #orientation:2 } );
    level.var_e1daf6fe[ 14 ] = array( { #var_fef51edb:"room_3_exit_1024x1024", #orientation:1 } );
    level.var_e1daf6fe[ 13 ] = array( { #var_fef51edb:"room_3_exit_1024x1024", #orientation:0 } );
    
    if ( is_true( expanded ) )
    {
        level.var_e1daf6fe[ 15 ] = array( { #var_fef51edb:"room_4_exit_1024x1024", #orientation:0 }, { #var_fef51edb:"room_5_exit_1024x1024", #orientation:0 } );
    }
    else
    {
        level.var_e1daf6fe[ 15 ] = array( { #var_fef51edb:"room_4_exit_1024x1024", #orientation:0 } );
    }
    
    level.var_86fb599e[ 0 ] = [];
    level.var_86fb599e[ 1 ] = array( { #var_fef51edb:"hall_1_exit_1024x1024", #orientation:3 } );
    level.var_86fb599e[ 2 ] = array( { #var_fef51edb:"hall_1_exit_1024x1024", #orientation:2 } );
    level.var_86fb599e[ 4 ] = array( { #var_fef51edb:"hall_1_exit_1024x1024", #orientation:1 } );
    level.var_86fb599e[ 8 ] = array( { #var_fef51edb:"hall_1_exit_1024x1024", #orientation:0 } );
    
    if ( is_true( expanded ) )
    {
        level.var_86fb599e[ 10 ] = array( { #var_fef51edb:"hall_dirt_2_exit_ver1_1024x1024", #orientation:0 }, { #var_fef51edb:"hall_dirt_2_exit_ver2_1024x1024", #orientation:0 }, { #var_fef51edb:"hall_dirt_2iflogger_exit_1024x1024", #orientation:0 } );
        level.var_86fb599e[ 5 ] = array( { #var_fef51edb:"hall_dirt_2_exit_ver1_1024x1024", #orientation:1 }, { #var_fef51edb:"hall_dirt_2_exit_ver2_1024x1024", #orientation:1 }, { #var_fef51edb:"hall_dirt_2iflogger_exit_1024x1024", #orientation:1 } );
    }
    else
    {
        level.var_86fb599e[ 10 ] = array( { #var_fef51edb:"hall_dirt_2_exit_ver1_1024x1024", #orientation:0 }, { #var_fef51edb:"hall_dirt_2_exit_ver2_1024x1024", #orientation:0 } );
        level.var_86fb599e[ 5 ] = array( { #var_fef51edb:"hall_dirt_2_exit_ver1_1024x1024", #orientation:1 }, { #var_fef51edb:"hall_dirt_2_exit_ver2_1024x1024", #orientation:1 } );
    }
    
    level.var_86fb599e[ 9 ] = array( { #var_fef51edb:"hall_dirt_2l_exit_ver1_1024x1024", #orientation:3 }, { #var_fef51edb:"hall_dirt_2l_exit_ver2_1024x1024", #orientation:3 } );
    level.var_86fb599e[ 3 ] = array( { #var_fef51edb:"hall_dirt_2l_exit_ver1_1024x1024", #orientation:2 }, { #var_fef51edb:"hall_dirt_2l_exit_ver2_1024x1024", #orientation:2 } );
    level.var_86fb599e[ 6 ] = array( { #var_fef51edb:"hall_dirt_2l_exit_ver1_1024x1024", #orientation:1 }, { #var_fef51edb:"hall_dirt_2l_exit_ver2_1024x1024", #orientation:1 } );
    level.var_86fb599e[ 12 ] = array( { #var_fef51edb:"hall_dirt_2l_exit_ver1_1024x1024", #orientation:0 }, { #var_fef51edb:"hall_dirt_2l_exit_ver2_1024x1024", #orientation:0 } );
    level.var_86fb599e[ 11 ] = array( { #var_fef51edb:"hall_dirt_3_exit_ver1_1024x1024", #orientation:3 } );
    level.var_86fb599e[ 7 ] = array( { #var_fef51edb:"hall_dirt_3_exit_ver1_1024x1024", #orientation:2 } );
    level.var_86fb599e[ 14 ] = array( { #var_fef51edb:"hall_dirt_3_exit_ver1_1024x1024", #orientation:1 } );
    level.var_86fb599e[ 13 ] = array( { #var_fef51edb:"hall_dirt_3_exit_ver1_1024x1024", #orientation:0 } );
    level.var_86fb599e[ 15 ] = array( { #var_fef51edb:"hall_dirt_4_exit_ver1_1024x1024", #orientation:0 } );
}

// Namespace namespace_c004634e/namespace_c004634e
// Params 0
// Checksum 0xed1e947b, Offset: 0x1958
// Size: 0xbb8
function function_9df20e11()
{
    level.var_e1daf6fe[ 0 ] = [];
    level.var_e1daf6fe[ 1 ] = array( { #var_fef51edb:"room_1_exit_1024x1024", #orientation:3 }, { #var_fef51edb:"room_1b_exit_1024x1024", #orientation:3 } );
    level.var_e1daf6fe[ 2 ] = array( { #var_fef51edb:"room_1_exit_1024x1024", #orientation:2 }, { #var_fef51edb:"room_1b_exit_1024x1024", #orientation:2 } );
    level.var_e1daf6fe[ 4 ] = array( { #var_fef51edb:"room_1_exit_1024x1024", #orientation:1 }, { #var_fef51edb:"room_1b_exit_1024x1024", #orientation:1 } );
    level.var_e1daf6fe[ 8 ] = array( { #var_fef51edb:"room_1_exit_1024x1024", #orientation:0 }, { #var_fef51edb:"room_1b_exit_1024x1024", #orientation:0 } );
    level.var_e1daf6fe[ 10 ] = array( { #var_fef51edb:"room_2i_exit_1024x1024", #orientation:0 }, { #var_fef51edb:"room_2b_exit_1024x1024", #orientation:0 } );
    level.var_e1daf6fe[ 5 ] = array( { #var_fef51edb:"room_2i_exit_1024x1024", #orientation:1 }, { #var_fef51edb:"room_2b_exit_1024x1024", #orientation:1 } );
    level.var_e1daf6fe[ 9 ] = array( { #var_fef51edb:"room_2l_exit_1024x1024", #orientation:3 } );
    level.var_e1daf6fe[ 3 ] = array( { #var_fef51edb:"room_2l_exit_1024x1024", #orientation:2 } );
    level.var_e1daf6fe[ 6 ] = array( { #var_fef51edb:"room_2l_exit_1024x1024", #orientation:1 } );
    level.var_e1daf6fe[ 12 ] = array( { #var_fef51edb:"room_2l_exit_1024x1024", #orientation:0 } );
    level.var_e1daf6fe[ 11 ] = array( { #var_fef51edb:"room_3_exit_1024x1024", #orientation:3 }, { #var_fef51edb:"room_3b_exit_1024x1024", #orientation:3 } );
    level.var_e1daf6fe[ 7 ] = array( { #var_fef51edb:"room_3_exit_1024x1024", #orientation:2 }, { #var_fef51edb:"room_3b_exit_1024x1024", #orientation:2 } );
    level.var_e1daf6fe[ 14 ] = array( { #var_fef51edb:"room_3_exit_1024x1024", #orientation:1 } );
    level.var_e1daf6fe[ 13 ] = array( { #var_fef51edb:"room_3_exit_1024x1024", #orientation:0 } );
    level.var_e1daf6fe[ 15 ] = array( { #var_fef51edb:"room_4_exit_1024x1024", #orientation:0 }, { #var_fef51edb:"room_5_exit_1024x1024", #orientation:0 } );
    level.var_86fb599e[ 0 ] = [];
    level.var_86fb599e[ 1 ] = array( { #var_fef51edb:"hall_1_exit_1024x1024", #orientation:3 } );
    level.var_86fb599e[ 2 ] = array( { #var_fef51edb:"hall_1_exit_1024x1024", #orientation:2 } );
    level.var_86fb599e[ 4 ] = array( { #var_fef51edb:"hall_1_exit_1024x1024", #orientation:1 } );
    level.var_86fb599e[ 8 ] = array( { #var_fef51edb:"hall_1_exit_1024x1024", #orientation:0 } );
    level.var_86fb599e[ 10 ] = array( { #var_fef51edb:"hall_2i_exit_1024x1024", #orientation:0 }, { #var_fef51edb:"hall_2ii_exit_1024x1024", #orientation:0 }, { #var_fef51edb:"hall_2ilava_exit_1024x1024", #orientation:0 }, { #var_fef51edb:"hall_2iflogger_exit_1024x1024", #orientation:0 } );
    level.var_86fb599e[ 5 ] = array( { #var_fef51edb:"hall_2i_exit_1024x1024", #orientation:1 }, { #var_fef51edb:"hall_2ii_exit_1024x1024", #orientation:1 }, { #var_fef51edb:"hall_2ilava_exit_1024x1024", #orientation:1 }, { #var_fef51edb:"hall_2iflogger_exit_1024x1024", #orientation:1 } );
    level.var_86fb599e[ 9 ] = array( { #var_fef51edb:"hall_2l_exit_1024x1024", #orientation:3 } );
    level.var_86fb599e[ 3 ] = array( { #var_fef51edb:"hall_2l_exit_1024x1024", #orientation:2 } );
    level.var_86fb599e[ 6 ] = array( { #var_fef51edb:"hall_2l_exit_1024x1024", #orientation:1 } );
    level.var_86fb599e[ 12 ] = array( { #var_fef51edb:"hall_2l_exit_1024x1024", #orientation:0 } );
    level.var_86fb599e[ 11 ] = array( { #var_fef51edb:"hall_3_exit_1024x1024", #orientation:3 } );
    level.var_86fb599e[ 7 ] = array( { #var_fef51edb:"hall_3_exit_1024x1024", #orientation:2 }, { #var_fef51edb:"hall_3b_exit_1024x1024", #orientation:2 } );
    level.var_86fb599e[ 14 ] = array( { #var_fef51edb:"hall_3_exit_1024x1024", #orientation:1 } );
    level.var_86fb599e[ 13 ] = array( { #var_fef51edb:"hall_3_exit_1024x1024", #orientation:0 }, { #var_fef51edb:"hall_3b_exit_1024x1024", #orientation:0 } );
    level.var_86fb599e[ 15 ] = array( { #var_fef51edb:"hall_4_exit_1024x1024", #orientation:0 }, { #var_fef51edb:"hall_4l_exit_1024x1024", #orientation:0 } );
}

// Namespace namespace_c004634e/namespace_c004634e
// Params 1
// Checksum 0xf88c3aa3, Offset: 0x2518
// Size: 0x1f2
function function_a4c07e18( name )
{
    switch ( name )
    {
        case #"jungle_1_dungeon4":
            setdvar( #"hash_bbbed34faf16cf1", 9 );
            setdvar( #"hash_4c2ff1f11662c879", 9 );
            setdvar( #"hash_788fb3bfb03132f", 5 );
            function_1a3f9fe1( 1 );
            break;
        case #"cellar":
            setdvar( #"hash_bbbed34faf16cf1", 7 );
            setdvar( #"hash_4c2ff1f11662c879", 8 );
            setdvar( #"hash_788fb3bfb03132f", 4 );
            function_1a3f9fe1();
            break;
        default:
            setdvar( #"hash_bbbed34faf16cf1", 12 );
            setdvar( #"hash_4c2ff1f11662c879", 12 );
            setdvar( #"hash_788fb3bfb03132f", 6 );
            function_9df20e11();
            break;
    }
}

// Namespace namespace_c004634e/namespace_c004634e
// Params 3
// Checksum 0xc37f468b, Offset: 0x2718
// Size: 0x1e
function function_1210f64b( *unused1, *unused2, *var_26f1324c )
{
    return undefined;
}

// Namespace namespace_c004634e/namespace_c004634e
// Params 1
// Checksum 0xf7146bb6, Offset: 0x2740
// Size: 0xa2a
function function_18276de3( name = "" )
{
    level.doa.var_3d1f118d = [];
    level.doa.var_3d1f118d[ #"wall" ] = [];
    level.doa.var_3d1f118d[ #"floor" ] = [];
    
    switch ( name )
    {
        default:
            level.doa.var_3d1f118d[ #"wall" ][ #"torch" ][ 0 ] = { #model:#"zombietron_torch_wall_no_shadow", #yaw_offset:0, #scale:1, #weight:1, #fx:"fx_fire_torch_wall_lit_castle" };
            level.doa.var_3d1f118d[ #"wall" ][ #"sconce" ][ 0 ] = { #model:#"zombietron_gargoyle_sconce_1", #yaw_offset:-90, #scale:1, #weight:1 };
            level.doa.var_3d1f118d[ #"wall" ][ #"sconce" ][ 1 ] = { #model:#"zombietron_gargoyle_sconce_2", #yaw_offset:180, #scale:1, #weight:1 };
            level.doa.var_3d1f118d[ #"wall" ][ #"sconce" ][ 2 ] = { #model:#"zombietron_gargoyle_sconce_3", #yaw_offset:0, #scale:1, #weight:1 };
            level.doa.var_3d1f118d[ #"wall" ][ #"sconce" ][ 3 ] = { #model:#"zombietron_gargoyle_sconce_4", #yaw_offset:180, #scale:1, #weight:1 };
            level.doa.var_3d1f118d[ #"wall" ][ #"sconce" ][ 4 ] = { #model:#"zombietron_treasure_mask_gold", #yaw_offset:0, #scale:3, #weight:1 };
            level.doa.var_3d1f118d[ #"floor" ][ #"statue" ][ 0 ] = { #model:#"zombietron_statue_apothicon", #yaw_offset:0, #scale:1, #weight:1 };
            level.doa.var_3d1f118d[ #"floor" ][ #"statue" ][ 1 ] = { #model:#"zombietron_templar_statue_01", #yaw_offset:0, #scale:1, #weight:1 };
            level.doa.var_3d1f118d[ #"floor" ][ #"statue" ][ 2 ] = { #model:#"zombietron_templar_statue_02", #yaw_offset:0, #scale:1, #weight:1 };
            level.doa.var_3d1f118d[ #"floor" ][ #"statue" ][ 3 ] = { #model:#"zombietron_templar_statue_03", #yaw_offset:0, #scale:1, #weight:1 };
            level.doa.var_3d1f118d[ #"floor" ][ #"statue" ][ 4 ] = { #model:#"zombietron_templar_statue_04", #yaw_offset:0, #scale:1, #weight:1 };
            level.doa.var_3d1f118d[ #"floor" ][ #"statue" ][ 5 ] = { #model:#"zombietron_arena_statue_man_wings", #yaw_offset:0, #scale:1, #weight:1 };
            level.doa.var_3d1f118d[ #"floor" ][ #"statue" ][ 6 ] = { #model:#"zombietron_altar_roman_statue_lt", #yaw_offset:0, #scale:1, #weight:1 };
            level.doa.var_3d1f118d[ #"floor" ][ #"statue" ][ 7 ] = { #model:#"zombietron_altar_roman_statue_rt", #yaw_offset:0, #scale:1, #weight:1 };
            level.doa.var_3d1f118d[ #"floor" ][ #"statue" ][ 8 ] = { #model:#"zombietron_sha_statue_finial", #yaw_offset:0, #scale:1, #weight:1 };
            level.doa.var_3d1f118d[ #"floor" ][ #"statue" ][ 9 ] = { #model:#"zombietron_statue_keeper_undercroft", #yaw_offset:90, #scale:0.6, #weight:1 };
            break;
    }
}

// Namespace namespace_c004634e/namespace_c004634e
// Params 1
// Checksum 0xc7b39285, Offset: 0x3178
// Size: 0x92
function function_5a3d60af( name )
{
    switch ( name )
    {
        case #"jungle_1_dungeon4":
            level.var_5b193175 = &function_83db98d1;
            break;
        case #"cellar":
            level.var_5b193175 = &function_cfe1177f;
            break;
        default:
            level.var_5b193175 = undefined;
            break;
    }
}

// Namespace namespace_c004634e/namespace_c004634e
// Params 1
// Checksum 0x21a6754d, Offset: 0x3218
// Size: 0x1c, Type: bool
function function_83db98d1( var_ac850bbc )
{
    return var_ac850bbc.var_8363ebc0 >= 12;
}

// Namespace namespace_c004634e/namespace_c004634e
// Params 1
// Checksum 0xf2099f4d, Offset: 0x3240
// Size: 0x1c, Type: bool
function function_cfe1177f( var_ac850bbc )
{
    return var_ac850bbc.var_8363ebc0 >= 8;
}

// Namespace namespace_c004634e/namespace_c004634e
// Params 1
// Checksum 0xec07db1d, Offset: 0x3268
// Size: 0x82
function function_ed9ae881( name )
{
    switch ( name )
    {
        case #"jungle_1_dungeon4":
        case #"cellar":
            level.var_84c76431 = &function_9a834e27;
            break;
        default:
            level.var_84c76431 = &function_d5a0313a;
            break;
    }
}

// Namespace namespace_c004634e/namespace_c004634e
// Params 0
// Checksum 0xa52cc31d, Offset: 0x32f8
// Size: 0x22
function function_9a834e27()
{
    var_1b8ba6f5 = function_d5a0313a();
    return var_1b8ba6f5;
}

// Namespace namespace_c004634e/namespace_c004634e
// Params 0
// Checksum 0xb847537, Offset: 0x3328
// Size: 0x110
function function_d5a0313a()
{
    var_1b8ba6f5 = [];
    var_1b8ba6f5[ 0 ] = 1e-05;
    var_1b8ba6f5[ 1 ] = 0.001;
    var_1b8ba6f5[ 2 ] = 0.001;
    var_1b8ba6f5[ 3 ] = 1;
    var_1b8ba6f5[ 4 ] = 0.001;
    var_1b8ba6f5[ 5 ] = 1;
    var_1b8ba6f5[ 6 ] = 1;
    var_1b8ba6f5[ 7 ] = 0.5;
    var_1b8ba6f5[ 8 ] = 0.001;
    var_1b8ba6f5[ 9 ] = 1;
    var_1b8ba6f5[ 10 ] = 1;
    var_1b8ba6f5[ 11 ] = 0.5;
    var_1b8ba6f5[ 12 ] = 1;
    var_1b8ba6f5[ 13 ] = 0.5;
    var_1b8ba6f5[ 14 ] = 0.5;
    var_1b8ba6f5[ 15 ] = 1.75;
    return var_1b8ba6f5;
}

// Namespace namespace_c004634e/namespace_c004634e
// Params 2
// Checksum 0x585ca790, Offset: 0x3440
// Size: 0xf6
function function_1f81f464( type, subtype )
{
    if ( isdefined( level.doa.var_3d1f118d[ type ] ) )
    {
        if ( !isdefined( subtype ) )
        {
            subtype = function_d59c2d03( level.doa.var_3d1f118d[ type ].size );
        }
        else
        {
            subtype = hash( subtype );
        }
        
        if ( isdefined( level.doa.var_3d1f118d[ type ][ subtype ] ) )
        {
            var_71b4f6c7 = function_d59c2d03( level.doa.var_3d1f118d[ type ][ subtype ].size );
            return level.doa.var_3d1f118d[ type ][ subtype ][ var_71b4f6c7 ];
        }
    }
}

// Namespace namespace_c004634e/namespace_c004634e
// Params 2
// Checksum 0x98193dd0, Offset: 0x3540
// Size: 0xe8
function function_6a09928b( location, type )
{
    if ( isdefined( location.script_parameters ) )
    {
        modelname = location.script_parameters;
    }
    else
    {
        modelinfo = function_1f81f464( type, location.script_noteworthy );
        modelname = modelinfo.model;
    }
    
    model = undefined;
    
    if ( isdefined( modelname ) )
    {
        /#
            namespace_1e25ad94::debugmsg( "<dev string:x38>" + function_9e72a96( type ) + "<dev string:x44>" + modelname + "<dev string:x4f>" + location.origin );
        #/
    }
    
    return model;
}

