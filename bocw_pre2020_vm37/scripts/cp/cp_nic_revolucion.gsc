#using script_169397edb865e2fe;
#using script_1a8e3ed87416246f;
#using script_1e11da73f221dacf;
#using script_237e957844a8197c;
#using script_2dc23e8cdc04641;
#using script_449db013f96e63ee;
#using script_4a1a0f734d8d0e04;
#using script_4e3db13f6a3f0e22;
#using script_5991d6501121591f;
#using script_5ab2e91e565f1fae;
#using script_6b2490222adab2af;
#using script_6b6aa5011b898d9a;
#using script_72e5a112d0707eeb;
#using script_7c5d86c25e7584a4;
#using script_7e534d425ebbc173;
#using script_e4d4b4e82f6b90e;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp\cp_nic_revolucion_fx;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;
#using scripts\killstreaks\remotemissile_shared;

#namespace cp_nic_revolucion;

// Namespace cp_nic_revolucion/level_init
// Params 1, eflags: 0x40
// Checksum 0xbeb9947c, Offset: 0x368
// Size: 0x184
function event_handler[level_init] main( *eventstruct )
{
    function_bf4b4b7e();
    cp_nic_revolucion_fx::preload();
    load::main();
    init_fx();
    hms_util::function_2f3616f8();
    level.disablestattracking = 1;
    
    while ( !isdefined( level.player ) )
    {
        if ( getplayers().size > 0 )
        {
            level.player = getplayers()[ 0 ];
        }
        
        waitframe( 1 );
    }
    
    setdvar( #"compassmaxrange", "2100" );
    level.var_9c4a751d = 1;
    level.var_3ff1b984[ getweapon( #"ac130" ) ] = 1;
    callback::on_spawned( &function_47b8b88 );
    function_303d4f();
    
    /#
        level thread hms_util::function_32397759();
        level thread hms_util::function_5056f90d();
    #/
}

// Namespace cp_nic_revolucion/cp_nic_revolucion
// Params 0
// Checksum 0xe6c1ca09, Offset: 0x4f8
// Size: 0x144
function init_fx()
{
    level._effect[ #"hash_b63f0232a3d5f82" ] = #"hash_3b2dcab0e76aeb7c";
    level._effect[ #"hash_6137c6e5c6df6502" ] = #"hash_65be3ccb65aba68f";
    level._effect[ #"hash_70902b0842168222" ] = #"hash_72c752412f511f36";
    level._effect[ #"hash_5b324a25a646d3be" ] = #"hash_48ba62945045cb4e";
    level._effect[ #"hash_5334c84fbd555272" ] = #"hash_7e60569db9c36606";
    level._effect[ #"hash_2da85b06a03a2ba" ] = #"hash_26689c1b99e901a";
    level._effect[ #"hash_7527861319d5e820" ] = #"hash_48ce1b00618cebdd";
    level._effect[ #"hash_711a6d544750ccfb" ] = #"hash_735d87613c054cac";
}

// Namespace cp_nic_revolucion/cp_nic_revolucion
// Params 0
// Checksum 0x53b078b3, Offset: 0x648
// Size: 0x17a
function function_47b8b88()
{
    self setactionslot( 4, "" );
    self util::function_a5318821();
    
    switch ( level.var_b28c2c3a )
    {
        case #"ride":
        case #"church":
        case #"no_game":
        case #"plaza":
            self hms_util::function_2e7c81f6( #"sniper_standard_t9", #"pistol_semiauto_t9", #"frag_grenade", #"eq_flash_grenade" );
            break;
        default:
            var_f0935a68 = getweapon( #"ar_damage_t9", "reddot" );
            self hms_util::function_2e7c81f6( var_f0935a68, #"pistol_semiauto_t9", #"frag_grenade", #"eq_flash_grenade" );
            break;
    }
}

// Namespace cp_nic_revolucion/cp_nic_revolucion
// Params 0
// Checksum 0xace62536, Offset: 0x7d0
// Size: 0x374
function function_bf4b4b7e()
{
    skipto::function_eb91535d( "ride", &namespace_7617b2b9::main, &namespace_7617b2b9::start, "Ride", &namespace_7617b2b9::cleanup );
    skipto::function_eb91535d( "church", &namespace_69b8cbbe::main, &namespace_69b8cbbe::start, "Church", &namespace_69b8cbbe::cleanup );
    skipto::function_eb91535d( "plaza", &namespace_f7efe8a3::main, &namespace_f7efe8a3::start, "Plaza", &namespace_f7efe8a3::cleanup );
    skipto::function_eb91535d( "1st_floor", &namespace_63e55f9b::main, &namespace_63e55f9b::start, "1st Floor", &namespace_63e55f9b::cleanup );
    skipto::function_eb91535d( "1st_floor_cctv", &namespace_b16b5bf9::main, &namespace_b16b5bf9::start, "1st Floor CCTV", &namespace_b16b5bf9::cleanup );
    skipto::function_eb91535d( "2nd_floor", &namespace_9162cd57::main, &namespace_9162cd57::start, "2nd Floor", &namespace_9162cd57::cleanup );
    skipto::function_eb91535d( "vip_room", &namespace_dca66e72::main, &namespace_dca66e72::start, "VIP Room", &namespace_dca66e72::cleanup );
    skipto::function_eb91535d( "escape", &namespace_9c5e6b7c::main, &namespace_9c5e6b7c::start, "Escape", &namespace_9c5e6b7c::cleanup );
    skipto::function_eb91535d( "rooftop", &namespace_69a17177::main, &namespace_69a17177::start, "Rooftop", &namespace_69a17177::cleanup );
    skipto::function_eb91535d( "rooftop_defend_1", &namespace_302d34db::main, &namespace_302d34db::start, "Rooftop Defend 1", &namespace_302d34db::cleanup );
    skipto::function_eb91535d( "exfil", &namespace_379d0dc2::main, &namespace_379d0dc2::start, "Exfil", &namespace_379d0dc2::cleanup );
}

// Namespace cp_nic_revolucion/cp_nic_revolucion
// Params 0
// Checksum 0x4b7f3d51, Offset: 0xb50
// Size: 0x66
function function_6c342249()
{
    while ( true )
    {
        if ( self actionslotfourbuttonpressed() )
        {
            /#
                hms_util::print( "<dev string:x38>" );
            #/
            
            self remotemissile::tryusepredatormissile();
        }
        
        waitframe( 1 );
    }
}

// Namespace cp_nic_revolucion/cp_nic_revolucion
// Params 0
// Checksum 0xa3405c57, Offset: 0xbc0
// Size: 0x24e
function function_3817f59e()
{
    while ( true )
    {
        if ( self actionslotfourbuttonpressed() )
        {
            /#
                hms_util::print( "<dev string:x4a>" );
            #/
            
            offset = 5000;
            player_angles = self getplayerangles();
            player_angles = vectornormalize( anglestoforward( player_angles ) );
            end = self getplayercamerapos() + player_angles * offset;
            trace = physicstrace( self getplayercamerapos(), end, ( 0, 0, 0 ), ( 0, 0, 0 ), self );
            
            if ( isdefined( trace[ #"position" ] ) )
            {
                /#
                    sphere( trace[ #"position" ], 10, ( 1, 0, 0 ), 0.5, 0, 20, 60 );
                #/
                
                for ( i = 0; i < 3 ; i++ )
                {
                    missile = magicbullet( getweapon( #"launcher_standard_t9" ), level.player.origin + ( 0, 0, 5000 ), trace[ #"position" ] + math::random_vector( 25 ) );
                    missile thread function_4d15227c( trace[ #"position" ] );
                    wait randomfloatrange( 0.65, 0.85 );
                }
            }
        }
        
        waitframe( 1 );
    }
}

// Namespace cp_nic_revolucion/cp_nic_revolucion
// Params 1
// Checksum 0x3b9877a6, Offset: 0xe18
// Size: 0xcc
function function_4d15227c( end_origin )
{
    self endon( #"death" );
    var_22be1364 = randomfloatrange( 500, 600 );
    
    while ( self.origin[ 2 ] > end_origin[ 2 ] + var_22be1364 )
    {
        waitframe( 1 );
    }
    
    earthquake( 0.25, 1, self.origin, 2500 );
    self detonate();
    level thread function_b4d19680( self );
}

// Namespace cp_nic_revolucion/cp_nic_revolucion
// Params 1
// Checksum 0xee4f9338, Offset: 0xef0
// Size: 0x1c2
function function_b4d19680( e_grenade )
{
    level endon( #"end_game" );
    var_b84a170a = getweapon( #"hash_7e94745566021fff" );
    var_740add51 = 72;
    var_2b9a525f = randomfloatrange( 0, var_740add51 );
    v_start = e_grenade.origin;
    
    for ( i = 0; i < 5 ; i++ )
    {
        n_angle = var_2b9a525f + var_740add51 * i + randomfloatrange( -10, 10 );
        v_dir = anglestoforward( ( 0, n_angle, 0 ) );
        v_spawn = v_start + 5 * v_dir;
        var_497d8162 = randomintrangeinclusive( 100, 250 );
        var_36bc8509 = randomintrangeinclusive( 200, 1000 );
        v_launch = var_497d8162 * v_dir - ( 0, 0, var_36bc8509 );
        level.player magicgrenadeplayer( var_b84a170a, v_spawn, v_launch );
        waitframe( 1 );
    }
}

// Namespace cp_nic_revolucion/cp_nic_revolucion
// Params 0
// Checksum 0x6cbd3afe, Offset: 0x10c0
// Size: 0x94
function function_303d4f()
{
    level.var_c50254e8 = 0;
    var_1dbaa44b = getentarray( "intel_pickup", "targetname" );
    level.var_91240eb2 = var_1dbaa44b.size;
    array::thread_all( var_1dbaa44b, &hms_util::function_40e4ae8e, #"hash_a212d3829fdfd6f", &intel_collected );
}

// Namespace cp_nic_revolucion/cp_nic_revolucion
// Params 0
// Checksum 0x7e020ed3, Offset: 0x1160
// Size: 0x284
function intel_collected()
{
    objectives::function_45951a55( "obj_intel" );
    level.player playgestureviewmodel( #"ges_drophand" );
    level.player objectives_ui::show_objectives();
    level.var_c50254e8++;
    
    if ( level.var_c50254e8 >= level.var_91240eb2 )
    {
        /#
            hms_util::print( "<dev string:x54>" );
        #/
        
        objectives::complete( "obj_intel" );
    }
    else if ( level.var_c50254e8 == 1 )
    {
        if ( !level flag::get( "play_nuke_room" ) )
        {
            var_16bf64d2 = randomintrangeinclusive( 0, 2 );
            
            switch ( var_16bf64d2 )
            {
                case 0:
                    level.park thread hms_util::dialogue( "vox_cp_cbcr_02400_park_anencodeddiskth_25", undefined, "allies", "Park" );
                    break;
                case 1:
                    level.park thread hms_util::dialogue( "vox_cp_cbcr_02400_park_thosemightprove_41", undefined, "allies", "Park" );
                    break;
                case 2:
                    level.park thread hms_util::dialogue( "vox_cp_cbcr_02400_park_goodeyebellsnat_1b", undefined, "allies", "Park" );
                    break;
            }
        }
        
        objectives::scripted( "obj_intel", undefined, #"hash_34e396164dc2e45d", undefined, 1 );
        objectives::function_572778b9( "obj_intel" );
    }
    
    objectives::function_1de88d60( "obj_intel", undefined, level.var_c50254e8, level.var_91240eb2 );
    level.player objectives_ui::show_objectives();
}

