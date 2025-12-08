#using script_19971192452f4209;
#using script_4052585f7ae90f3a;
#using script_5513c8efed5ff300;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\values_shared;
#using scripts\cp_common\skipto;

#namespace hub_post_yamantau;

// Namespace hub_post_yamantau/cp_ger_hub_post_yamantau
// Params 1
// Checksum 0xdb5e30cf, Offset: 0x380
// Size: 0xc
function starting( *var_d3440450 )
{
    
}

// Namespace hub_post_yamantau/cp_ger_hub_post_yamantau
// Params 2
// Checksum 0x82961460, Offset: 0x398
// Size: 0x1a4
function main( var_d3440450, *var_50cc0d4f )
{
    level namespace_31c67f6d::function_6194f34a( "post_yamantau" );
    level thread function_81c3adaf();
    setlightingstate( 2 );
    level thread function_4a614026();
    level thread namespace_31c67f6d::function_29279de1( "post_yamantau" );
    level thread namespace_31c67f6d::function_b0558ba2( "5" );
    s_player_start = struct::get( "s_post_yamantau_player_start", "targetname" );
    level.player setorigin( s_player_start.origin );
    level.player setplayerangles( s_player_start.angles );
    level thread scene::play( "fan_01" );
    level thread function_ae2b72b9();
    level namespace_31c67f6d::function_7fd3a4d8( undefined, undefined, 3, 1 );
    
    if ( isdefined( var_50cc0d4f ) )
    {
        skipto::function_4e3ab877( var_50cc0d4f );
    }
}

// Namespace hub_post_yamantau/cp_ger_hub_post_yamantau
// Params 0
// Checksum 0xec831153, Offset: 0x548
// Size: 0x74
function function_ae2b72b9()
{
    wait 1;
    level.player val::set( #"hash_1758bde589c2e32c", "freezecontrols_allowlook", 1 );
    wait 12;
    level.player val::set( #"hash_1758bde589c2e32c", "freezecontrols_allowlook", 0 );
}

// Namespace hub_post_yamantau/cp_ger_hub_post_yamantau
// Params 0
// Checksum 0x1f16dbc2, Offset: 0x5c8
// Size: 0x7c
function function_4a614026()
{
    level.adler thread function_d16e71e6();
    level.park thread function_f5cec8cd();
    level.lazar thread function_db46f2d7();
    level.sims thread function_eb65bc98();
    level.hudson thread function_72ecde0e();
}

// Namespace hub_post_yamantau/cp_ger_hub_post_yamantau
// Params 0
// Checksum 0xb0ec4e93, Offset: 0x650
// Size: 0x29c
function function_d16e71e6()
{
    self.var_ba1eee16 = spawnstruct();
    self.var_ba1eee16.var_cc88ab09[ 0 ][ 0 ][ 0 ] = [ #"hash_9246a3916a0fde6", undefined, "shot_option1" ];
    self.var_ba1eee16.var_cc88ab09[ 0 ][ 0 ][ 1 ] = [ #"hash_29de5301738f4f3c", undefined, "shot_option1_suboption1" ];
    self.var_ba1eee16.var_cc88ab09[ 0 ][ 1 ][ 0 ] = [ #"hash_924693916a0fc33", undefined, "shot_option2" ];
    self.var_ba1eee16.var_cc88ab09[ 0 ][ 1 ][ 1 ] = [ #"hash_29dacd01738c35b3", undefined, "shot_option2_suboption1" ];
    self.var_ba1eee16.var_cc88ab09[ 0 ][ 2 ][ 0 ] = [ #"hash_924683916a0fa80", undefined, "shot_option3" ];
    self.var_ba1eee16.str_location = "tv_table";
    self.var_ba1eee16.n_fov = undefined;
    self.var_ba1eee16.var_e1eebb0b = 3;
    self.var_ba1eee16.var_142355f9 = undefined;
    self.var_ba1eee16.var_9b7161e6 = undefined;
    self.var_ba1eee16.var_e9797a7f = undefined;
    self.var_ba1eee16.var_cbdef43f = undefined;
    self.var_ba1eee16.var_a6bf452 = #"hash_18589726ffc5a631";
    self.var_ba1eee16.var_5956b0f3 = #"hash_3aae778cd4536ba0";
    self.var_ba1eee16.var_6b005446 = #"hash_3aae7a8cd45370b9";
    self thread namespace_31c67f6d::function_95e9dca3();
}

// Namespace hub_post_yamantau/cp_ger_hub_post_yamantau
// Params 0
// Checksum 0xa71599cc, Offset: 0x8f8
// Size: 0x94
function function_f5cec8cd()
{
    self.var_ba1eee16 = spawnstruct();
    self.var_ba1eee16.var_890ce7a8 = 1;
    self.var_ba1eee16.var_18674cfa = 0;
    self flag::set( "flag_dialog_exhausted" );
    self flag::set( "flag_speak_while_fidgeting" );
    self thread namespace_31c67f6d::function_95e9dca3();
}

// Namespace hub_post_yamantau/cp_ger_hub_post_yamantau
// Params 0
// Checksum 0x4b2680e0, Offset: 0x998
// Size: 0xac
function function_eb65bc98()
{
    self.var_ba1eee16 = spawnstruct();
    self.var_ba1eee16.var_890ce7a8 = 1;
    self.var_ba1eee16.var_18674cfa = 0;
    self.var_ba1eee16.v_offset = ( 0, 0, -16 );
    self flag::set( "flag_dialog_exhausted" );
    self flag::set( "flag_speak_while_fidgeting" );
    self thread namespace_31c67f6d::function_95e9dca3();
}

// Namespace hub_post_yamantau/cp_ger_hub_post_yamantau
// Params 0
// Checksum 0x337acfc2, Offset: 0xa50
// Size: 0x324
function function_db46f2d7()
{
    self.var_ba1eee16 = spawnstruct();
    self.var_ba1eee16.var_cc88ab09[ 0 ][ 0 ][ 0 ] = [ #"hash_fae37590b46fe81", undefined, "dt_1a" ];
    
    if ( level.player namespace_70eba6e6::function_b6a02677() == 3 )
    {
        self.var_ba1eee16.var_cc88ab09[ 0 ][ 1 ][ 0 ] = [ #"hash_fae34590b46f968", undefined, [ "dt_1b", "dt_1b_if_kgb" ], undefined, "flag_lazar_dialog_option1_unlocked" ];
        self.var_ba1eee16.var_cc88ab09[ 1 ][ 0 ][ 0 ] = [ #"hash_faa0f590b42d1b2", undefined, "dt_2a", undefined, "flag_lazar_dialog_option110" ];
        self.var_ba1eee16.var_cc88ab09[ 1 ][ 1 ][ 0 ] = [ #"hash_faa0e590b42cfff", undefined, "dt_2a", undefined, "flag_lazar_dialog_option100" ];
    }
    else
    {
        self.var_ba1eee16.var_cc88ab09[ 0 ][ 1 ][ 0 ] = [ #"hash_fae34590b46f968", undefined, "dt_1b", undefined ];
    }
    
    self.var_ba1eee16.str_location = "car";
    self.var_ba1eee16.n_fov = undefined;
    self.var_ba1eee16.var_e1eebb0b = 3;
    self.var_ba1eee16.var_142355f9 = undefined;
    self.var_ba1eee16.var_9b7161e6 = undefined;
    self.var_ba1eee16.var_e9797a7f = undefined;
    self.var_ba1eee16.var_cbdef43f = undefined;
    self.var_ba1eee16.var_a6bf452 = #"hash_18589726ffc5a631";
    self.var_ba1eee16.var_5956b0f3 = #"hash_4aa1bc3224a18ea4";
    self thread namespace_31c67f6d::function_95e9dca3();
}

// Namespace hub_post_yamantau/cp_ger_hub_post_yamantau
// Params 0
// Checksum 0x1dfcda32, Offset: 0xd80
// Size: 0x29c
function function_72ecde0e()
{
    self.var_ba1eee16 = spawnstruct();
    self.var_ba1eee16.var_cc88ab09[ 0 ][ 0 ][ 0 ] = [ #"hash_9246a3916a0fde6", undefined, "dialog_talking" ];
    self.var_ba1eee16.var_cc88ab09[ 0 ][ 0 ][ 1 ] = [ #"hash_29de5301738f4f3c", undefined, "dialog_talking" ];
    self.var_ba1eee16.var_cc88ab09[ 0 ][ 1 ][ 0 ] = [ #"hash_924693916a0fc33", undefined, "dialog_talking" ];
    self.var_ba1eee16.var_cc88ab09[ 0 ][ 1 ][ 1 ] = [ #"hash_29dacd01738c35b3", undefined, "dialog_talking" ];
    self.var_ba1eee16.var_cc88ab09[ 0 ][ 2 ][ 0 ] = [ #"hash_924683916a0fa80", undefined, "dialog_talking" ];
    self.var_ba1eee16.str_location = "clerk_desk";
    self.var_ba1eee16.n_fov = undefined;
    self.var_ba1eee16.var_e1eebb0b = 3;
    self.var_ba1eee16.var_142355f9 = undefined;
    self.var_ba1eee16.var_9b7161e6 = undefined;
    self.var_ba1eee16.var_e9797a7f = undefined;
    self.var_ba1eee16.var_cbdef43f = undefined;
    self.var_ba1eee16.var_a6bf452 = #"hash_18589726ffc5a631";
    self.var_ba1eee16.var_5956b0f3 = #"hash_3aae778cd4536ba0";
    self.var_ba1eee16.var_6b005446 = #"hash_3aae7a8cd45370b9";
    self thread namespace_31c67f6d::function_95e9dca3();
}

// Namespace hub_post_yamantau/cp_ger_hub_post_yamantau
// Params 0
// Checksum 0x9f7c9d13, Offset: 0x1028
// Size: 0x1c
function function_f50bc4b9()
{
    flag::init( "flag_post_yamantau_complete" );
}

// Namespace hub_post_yamantau/cp_ger_hub_post_yamantau
// Params 1
// Checksum 0x3dca522a, Offset: 0x1050
// Size: 0xc4
function function_6b03a78e( *var_d3440450 )
{
    level namespace_31c67f6d::function_6194f34a( "post_yamantau" );
    level thread function_81c3adaf();
    setlightingstate( 2 );
    level notify( #"eboard_ready" );
    level thread namespace_31c67f6d::function_29279de1( "post_yamantau" );
    level thread namespace_31c67f6d::function_b0558ba2( "5" );
    level thread function_bbf2586d();
}

// Namespace hub_post_yamantau/cp_ger_hub_post_yamantau
// Params 0
// Checksum 0xca15837, Offset: 0x1120
// Size: 0x34
function function_81c3adaf()
{
    level thread namespace_4ed3ce47::function_d89aa829();
    level thread namespace_4ed3ce47::function_938891c9();
}

// Namespace hub_post_yamantau/cp_ger_hub_post_yamantau
// Params 2
// Checksum 0xf3cc5e52, Offset: 0x1160
// Size: 0x4c
function function_29390787( var_d3440450, *var_50cc0d4f )
{
    flag::wait_till( "flag_post_yamantau_complete" );
    
    if ( isdefined( var_50cc0d4f ) )
    {
        skipto::function_4e3ab877( var_50cc0d4f );
    }
}

// Namespace hub_post_yamantau/cp_ger_hub_post_yamantau
// Params 0
// Checksum 0x4ca92941, Offset: 0x11b8
// Size: 0x11c
function function_bbf2586d()
{
    level thread function_4a614026();
    level namespace_31c67f6d::function_7fd3a4d8( 1 );
    level thread scene::play( "scene_hub_env_reel_to_reel" );
    level thread scene::play( "scene_hub_post_yamantau_dialog_adler", "zone_idle" );
    level thread scene::play( "scene_hub_post_yamantau_dialog_lazar", "zone_idle" );
    level thread scene::play( "scene_hub_post_yamantau_dialog_park", "zone_idle" );
    level thread scene::play( "scene_hub_post_yamantau_dialog_sims", "zone_idle" );
    level thread scene::play( "scene_hub_post_yamantau_dialog_hudson", "zone_idle" );
}

