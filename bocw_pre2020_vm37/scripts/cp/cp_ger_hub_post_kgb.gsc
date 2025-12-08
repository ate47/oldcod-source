#using script_19971192452f4209;
#using script_4052585f7ae90f3a;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\cp_common\skipto;

#namespace hub_post_kgb;

// Namespace hub_post_kgb/cp_ger_hub_post_kgb
// Params 1
// Checksum 0x6a973d3c, Offset: 0x240
// Size: 0xc
function starting( *var_d3440450 )
{
    
}

// Namespace hub_post_kgb/cp_ger_hub_post_kgb
// Params 2
// Checksum 0x8072ad54, Offset: 0x258
// Size: 0x1b4
function main( *var_d3440450, *var_50cc0d4f )
{
    level namespace_31c67f6d::function_6194f34a( "post_kgb", 1 );
    level thread function_53ea6532();
    setlightingstate( 3 );
    level thread function_9a76d250();
    level thread namespace_31c67f6d::function_15231086( "eboard_ready" );
    var_a2279767 = getent( "map_table", "targetname" );
    var_a2279767 hide();
    var_475021af = getent( "hub_mdl_car_01_clip", "targetname" );
    var_475021af hide();
    level thread namespace_31c67f6d::function_29279de1( "post_kgb" );
    level thread namespace_31c67f6d::function_b0558ba2( "6" );
    level thread scene::play( "fan_01" );
    level namespace_31c67f6d::function_7fd3a4d8( undefined, undefined, 3, 1 );
    flag::wait_till( "flag_post_kgb_complete" );
}

// Namespace hub_post_kgb/cp_ger_hub_post_kgb
// Params 0
// Checksum 0xc35c8f99, Offset: 0x418
// Size: 0x34
function function_9a76d250()
{
    level.adler thread function_3c654b25();
    level.hudson thread function_c350b5c7();
}

// Namespace hub_post_kgb/cp_ger_hub_post_kgb
// Params 0
// Checksum 0xafc3e4db, Offset: 0x458
// Size: 0x294
function function_3c654b25()
{
    self.var_ba1eee16 = spawnstruct();
    self.var_ba1eee16.var_cc88ab09[ 0 ][ 0 ][ 0 ] = [ #"hash_9246a3916a0fde6", undefined, "shot_option1" ];
    self.var_ba1eee16.var_cc88ab09[ 0 ][ 0 ][ 1 ] = [ #"hash_29de5301738f4f3c", undefined, "shot_option1_suboption1" ];
    self.var_ba1eee16.var_cc88ab09[ 0 ][ 1 ][ 0 ] = [ #"hash_924693916a0fc33", undefined, "shot_option2" ];
    self.var_ba1eee16.var_cc88ab09[ 0 ][ 1 ][ 1 ] = [ #"hash_29dacd01738c35b3", undefined, "shot_option2_suboption1" ];
    self.var_ba1eee16.var_cc88ab09[ 0 ][ 2 ][ 0 ] = [ #"hash_924683916a0fa80", undefined, "shot_option3" ];
    self.var_ba1eee16.str_location = "water_cooler";
    self.var_ba1eee16.n_fov = undefined;
    self.var_ba1eee16.var_e1eebb0b = undefined;
    self.var_ba1eee16.var_142355f9 = undefined;
    self.var_ba1eee16.var_9b7161e6 = undefined;
    self.var_ba1eee16.var_e9797a7f = undefined;
    self.var_ba1eee16.var_cbdef43f = undefined;
    self.var_ba1eee16.var_a6bf452 = #"hash_18589726ffc5a631";
    self.var_ba1eee16.var_5956b0f3 = #"hash_3aae778cd4536ba0";
    self.var_ba1eee16.var_6b005446 = #"hash_3aae7a8cd45370b9";
    self thread namespace_31c67f6d::function_95e9dca3();
}

// Namespace hub_post_kgb/cp_ger_hub_post_kgb
// Params 0
// Checksum 0xb1128409, Offset: 0x6f8
// Size: 0x30c
function function_c350b5c7()
{
    self.var_ba1eee16 = spawnstruct();
    self.var_ba1eee16.var_cc88ab09[ 0 ][ 0 ][ 0 ] = [ #"hash_20f85c1191383760", undefined, "dt_1a" ];
    self.var_ba1eee16.var_cc88ab09[ 0 ][ 0 ][ 1 ] = [ #"hash_3e3bc3d9c2860056", undefined, "dt_1a2" ];
    self.var_ba1eee16.var_cc88ab09[ 0 ][ 1 ][ 0 ] = [ #"hash_20f85f1191383c79", undefined, "dt_1b" ];
    self.var_ba1eee16.var_cc88ab09[ 0 ][ 2 ][ 0 ] = [ #"hash_20f85e1191383ac6", undefined, "dt_1c" ];
    self.var_ba1eee16.var_cc88ab09[ 0 ][ 2 ][ 1 ] = [ #"hash_3e42cbd9c28c2c9c", undefined, "dt_1c2" ];
    self.var_ba1eee16.var_cc88ab09[ 1 ][ 0 ][ 0 ] = [ #"hash_52d822a2a38b7e4d", undefined, "dt_first_exit" ];
    self.var_ba1eee16.var_14ee760c = 1;
    self flag::set( "flag_hudson_dialog_option1_unlocked" );
    self.var_ba1eee16.str_location = "tv_table";
    self.var_ba1eee16.n_fov = undefined;
    self.var_ba1eee16.var_e1eebb0b = undefined;
    self.var_ba1eee16.var_142355f9 = undefined;
    self.var_ba1eee16.var_9b7161e6 = undefined;
    self.var_ba1eee16.var_e9797a7f = undefined;
    self.var_ba1eee16.var_cbdef43f = undefined;
    self.var_ba1eee16.var_a6bf452 = #"hash_18589726ffc5a631";
    self.var_ba1eee16.var_5956b0f3 = #"hash_52d822a2a38b7e4d";
    self.var_ba1eee16.var_274d9415 = "dt_first_exit";
    self thread namespace_31c67f6d::function_95e9dca3();
}

// Namespace hub_post_kgb/cp_ger_hub_post_kgb
// Params 0
// Checksum 0x604a09f4, Offset: 0xa10
// Size: 0x34
function function_53ea6532()
{
    level thread namespace_4ed3ce47::function_46f173b2();
    level thread namespace_4ed3ce47::function_2d62fc6f();
}

// Namespace hub_post_kgb/cp_ger_hub_post_kgb
// Params 0
// Checksum 0x55428275, Offset: 0xa50
// Size: 0x1c
function function_f50bc4b9()
{
    flag::init( "flag_post_kgb_complete" );
}

// Namespace hub_post_kgb/cp_ger_hub_post_kgb
// Params 1
// Checksum 0xddf397b6, Offset: 0xa78
// Size: 0x144
function function_b58272a1( *var_d3440450 )
{
    level namespace_31c67f6d::function_6194f34a( "post_kgb" );
    level thread function_53ea6532();
    setlightingstate( 3 );
    var_a2279767 = getent( "map_table", "targetname" );
    var_a2279767 hide();
    var_475021af = getent( "hub_mdl_car_01_clip", "targetname" );
    var_475021af hide();
    level notify( #"eboard_ready" );
    level thread namespace_31c67f6d::function_29279de1( "post_kgb" );
    level thread namespace_31c67f6d::function_b0558ba2( "6" );
    level thread function_d51cce5a();
}

// Namespace hub_post_kgb/cp_ger_hub_post_kgb
// Params 2
// Checksum 0x281c5416, Offset: 0xbc8
// Size: 0x94
function function_223f05aa( var_d3440450, *var_50cc0d4f )
{
    flag::wait_till( "flag_post_kgb_complete" );
    
    if ( isdefined( var_50cc0d4f ) )
    {
        skipto::function_4e3ab877( var_50cc0d4f );
    }
    
    if ( isdefined( level.var_d7d201ba ) && isdefined( level.var_28c22d88 ) )
    {
        level.player flag::set( level.var_d7d201ba );
    }
}

// Namespace hub_post_kgb/cp_ger_hub_post_kgb
// Params 0
// Checksum 0x1bccac29, Offset: 0xc68
// Size: 0xa4
function function_d51cce5a()
{
    level thread function_9a76d250();
    level namespace_31c67f6d::function_7fd3a4d8( 1 );
    level thread scene::play( "fan_01" );
    level thread scene::play( "scene_hub_post_kgb_dialog_adler", "zone_idle" );
    level thread scene::play( "scene_hub_post_kgb_dialog_hudson", "zone_idle" );
}

