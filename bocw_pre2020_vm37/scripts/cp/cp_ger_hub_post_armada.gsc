#using script_19971192452f4209;
#using script_1b9f100b85b7e21d;
#using script_4052585f7ae90f3a;
#using script_5513c8efed5ff300;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\skipto;

#namespace hub_post_armada;

// Namespace hub_post_armada/cp_ger_hub_post_armada
// Params 1
// Checksum 0x8384234, Offset: 0x11b8
// Size: 0xc
function starting( *var_d3440450 )
{
    
}

// Namespace hub_post_armada/cp_ger_hub_post_armada
// Params 2
// Checksum 0xec1a029e, Offset: 0x11d0
// Size: 0x1ac
function main( var_d3440450, *var_50cc0d4f )
{
    level namespace_31c67f6d::function_6194f34a( "post_armada" );
    level thread function_f856db57();
    setlightingstate( 1 );
    level thread exploder::exploder( "exp_fx_post_takedown" );
    level thread function_35e99044();
    s_player_start = struct::get( "s_post_armada_player_start", "targetname" );
    level.player setorigin( s_player_start.origin );
    level.player setplayerangles( s_player_start.angles );
    level thread namespace_31c67f6d::function_29279de1( "post_armada" );
    level thread namespace_31c67f6d::function_b0558ba2( "2" );
    level thread scene::play( "scene_hub_env_reel_to_reel" );
    level namespace_31c67f6d::function_7fd3a4d8( undefined, undefined, 3, 1 );
    
    if ( isdefined( var_50cc0d4f ) )
    {
        skipto::function_4e3ab877( var_50cc0d4f );
    }
}

// Namespace hub_post_armada/cp_ger_hub_post_armada
// Params 0
// Checksum 0x268d799b, Offset: 0x1388
// Size: 0x64
function function_35e99044()
{
    level.adler function_e568e0d4();
    level.park function_650cdcc9();
    level.sims function_5312ebff();
    level.lazar function_ae2b7b0f();
}

// Namespace hub_post_armada/cp_ger_hub_post_armada
// Params 0
// Checksum 0x1db13649, Offset: 0x13f8
// Size: 0x5cc
function function_e568e0d4()
{
    self.var_ba1eee16 = spawnstruct();
    self.var_ba1eee16.var_c5c9acca[ 0 ] = [ "vox_cp_sh2_02175_adlr_niceworkproduci_d8", 0.4, 1.3 ];
    self.var_ba1eee16.var_c5c9acca[ 1 ] = [ "vox_cp_sh2_02175_adlr_kid_46", 0.4, 1.3 ];
    self.var_ba1eee16.var_c5c9acca[ 2 ] = [ "vox_cp_sh2_02175_adlr_whatsup_46", 0.7, 1 ];
    self.var_ba1eee16.var_c5c9acca[ 3 ] = [ "vox_cp_sh2_02175_adlr_bell_ad", 0.8, 1 ];
    self.var_ba1eee16.var_c5c9acca[ 4 ] = [ "vox_cp_sh2_02175_adlr_whatsonyourmind_f5", 0.4, 1.5 ];
    self.var_ba1eee16.var_962cbf19[ 0 ] = [ "vox_cp_sh2_02175_adlr_headonovertothe_05", 0.5 ];
    self.var_ba1eee16.var_962cbf19[ 1 ] = [ "vox_cp_sh2_02175_adlr_timetogetreadyb_20", 0.5 ];
    self.var_ba1eee16.var_962cbf19[ 2 ] = [ "vox_cp_sh2_02175_adlr_checkouttheboar_0d", 0.5 ];
    level thread function_b81255af();
    self.var_ba1eee16.var_f2190d3d = "scene_hub_" + level.var_f5552371 + "_dialog_" + self.animname;
    self.var_ba1eee16.s_tree = dialog_tree::new_tree( &namespace_31c67f6d::function_282ccb63, &namespace_31c67f6d::function_7b9b6d21, 0, 0, self.var_ba1eee16.var_f2190d3d );
    level.var_9727ef13[ 0 ] = self.var_ba1eee16.s_tree dialog_tree::add_option( #"hash_67f2099c8ca17a13", [ "vox_cp_sh2_02175_adlr_wearchiveeveryt_79", "vox_cp_sh2_02175_adlr_thetrickisknowi_81" ], undefined, "waiting_idle", 0, "adler_option3", undefined, &function_882e253f );
    level.var_9727ef13[ 1 ] = self.var_ba1eee16.s_tree dialog_tree::add_option( #"hash_67f20a9c8ca17bc6", "vox_cp_sh2_02175_adlr_didieverseehisf_78", undefined, "waiting_idle", 0, "adler_option3", undefined, &function_882e253f );
    self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87( "post_armada_busted_evesdropping", #"hash_67fc399c8caa2028", "vox_cp_sh2_02175_adlr_bellyoureaspybu_ed", undefined, "waiting_idle" );
    self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87( "post_armada_not_busted_evesdropping", #"hash_67fc399c8caa2028", "vox_cp_sh2_02175_adlr_justsomeoverdue_27", undefined, "waiting_idle" );
    self.var_ba1eee16.s_tree dialog_tree::function_7fe78745( 1, "exit_adler_convo", 1, #"hash_18589726ffc5a631", undefined, undefined, undefined, 1, "flag_dialog_nevermind", "forever" );
    self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87( "exit_adler_convo", #"hash_5ddc0f17824e186", [ "vox_cp_sh2_02175_adlr_wellleavewithin_dc", "vox_cp_sh2_02175_adlr_checkouttheboar_63" ], undefined, undefined, 1, undefined, "forever" );
    self.var_ba1eee16.s_tree dialog_tree::function_46f25b65();
    self.var_ba1eee16.var_85ed2b41 = undefined;
    self.var_ba1eee16.str_location = "map_table";
    self.var_ba1eee16.v_offset = ( 0, 0, 0 );
    self.var_ba1eee16.n_fov = undefined;
    self.var_ba1eee16.var_e1eebb0b = undefined;
    self.var_ba1eee16.var_142355f9 = undefined;
    self.var_ba1eee16.var_9b7161e6 = undefined;
    self.var_ba1eee16.var_e9797a7f = undefined;
    self.var_ba1eee16.var_cbdef43f = undefined;
    self thread namespace_31c67f6d::function_7b0516d7();
}

// Namespace hub_post_armada/cp_ger_hub_post_armada
// Params 0
// Checksum 0x1c53a3e9, Offset: 0x19d0
// Size: 0x114
function function_b81255af()
{
    level flag::wait_till( "post_armada_phone_call_happening" );
    level thread function_be5b3167();
    level flag::wait_till_any( [ "flag_post_armada_eavesdropped_timeout", "post_armada_evesdropped" ] );
    
    if ( level flag::get( "post_armada_evesdropped" ) )
    {
        level flag::set( "post_armada_busted_evesdropping" );
        level flag::clear( "post_armada_not_busted_evesdropping" );
        return;
    }
    
    level flag::clear( "post_armada_busted_evesdropping" );
    level flag::set( "post_armada_not_busted_evesdropping" );
}

// Namespace hub_post_armada/cp_ger_hub_post_armada
// Params 0
// Checksum 0xb4b67c7a, Offset: 0x1af0
// Size: 0x24
function function_be5b3167()
{
    wait 80;
    level flag::set( "flag_post_armada_eavesdropped_timeout" );
}

// Namespace hub_post_armada/cp_ger_hub_post_armada
// Params 0
// Checksum 0xbb897d16, Offset: 0x1b20
// Size: 0x68c
function function_650cdcc9()
{
    self.var_ba1eee16 = spawnstruct();
    self.var_ba1eee16.var_c5c9acca[ 0 ] = [ "vox_cp_sh2p_00500_park_thatintelyoufou_db", 0.5 ];
    self.var_ba1eee16.var_c5c9acca[ 1 ] = [ "vox_cp_sh2p_00500_park_bell_be", 0.5 ];
    self.var_ba1eee16.var_c5c9acca[ 2 ] = [ "vox_cp_sh2p_00500_park_yes_70", 0.5 ];
    self.var_ba1eee16.var_c5c9acca[ 3 ] = [ "vox_cp_sh2p_00500_park_yeswhatisit_69", 0.5 ];
    self.var_ba1eee16.var_962cbf19[ 0 ] = [ "vox_cp_sh2p_00500_park_ireallyneedtoco_6a", 0.5 ];
    self.var_ba1eee16.var_962cbf19[ 1 ] = [ "vox_cp_sh2p_00500_park_welltalkmoreano_3c", 0.5 ];
    self.var_ba1eee16.var_962cbf19[ 2 ] = [ "vox_cp_sh2p_00500_park_ineedsometimeto_e4", 0.5 ];
    self.var_ba1eee16.var_f2190d3d = "scene_hub_" + level.var_f5552371 + "_dialog_" + self.animname;
    self.var_ba1eee16.s_tree = dialog_tree::new_tree( &namespace_31c67f6d::function_282ccb63, &namespace_31c67f6d::function_7b9b6d21, 0, 0, self.var_ba1eee16.var_f2190d3d );
    self.var_ba1eee16.s_tree dialog_tree::add_option( #"hash_4ac1c40d7b52e213", undefined, "dt_1a", "waiting_idle" );
    self.var_ba1eee16.s_tree dialog_tree::function_9e36808( #"hash_5a2243e88dd63e13", undefined, [ "dt_1a_2_part1", "dt_1a_2_part2" ], "waiting_idle" );
    var_169ba887 = undefined;
    
    if ( level.player namespace_70eba6e6::function_33bf99f8( 1 ) == 2 )
    {
        var_169ba887 = self.var_ba1eee16.s_tree dialog_tree::add_option( #"hash_4ac1c50d7b52e3c6", undefined, "dt_1b_alt_fem", "waiting_idle" );
    }
    else
    {
        var_169ba887 = self.var_ba1eee16.s_tree dialog_tree::add_option( #"hash_4ac1c50d7b52e3c6", undefined, "dt_1b", "waiting_idle" );
    }
    
    self.var_ba1eee16.s_tree dialog_tree::function_ad98a815( var_169ba887, #"hash_5a25c9e88dd9579c", undefined, "dt_1b_2", "waiting_idle" );
    self.var_ba1eee16.s_tree dialog_tree::function_9e36808( #"hash_5a25cae88dd9594f", undefined, "dt_1b_3", "waiting_idle" );
    self.var_ba1eee16.s_tree dialog_tree::function_9e36808( #"hash_5a25c7e88dd95436", undefined, "dt_1b_4", "waiting_idle" );
    self.var_ba1eee16.s_tree dialog_tree::add_option( #"hash_4ac1c60d7b52e579", undefined, [ "dt_1c_part1", "dt_1c_part2" ], "waiting_idle" );
    self.var_ba1eee16.s_tree dialog_tree::function_7fe78745( 1, "park_convo_exit", 1, #"hash_18589726ffc5a631", undefined, undefined, undefined, 1, [ "flag_dialog_nevermind", "flag_adler_dialog_option2_unlocked", "adler_tkdn_dlg_nvm" ], "forever" );
    self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87( "park_convo_exit", #"hash_68ad7b6266d64986", [ "vox_cp_sh2p_00500_park_mypleasure_75", "vox_cp_sh2p_00500_park_bell_ad", "vox_cp_sh2p_00500_park_ofcourse_94" ], undefined, undefined, 1, undefined, "forever" );
    self.var_ba1eee16.s_tree dialog_tree::function_46f25b65();
    self.var_ba1eee16.str_location = "comms";
    self.var_ba1eee16.v_offset = ( 0, 0, -2 );
    self.var_ba1eee16.n_fov = undefined;
    self.var_ba1eee16.var_e1eebb0b = 3;
    self.var_ba1eee16.var_142355f9 = undefined;
    self.var_ba1eee16.var_9b7161e6 = undefined;
    self.var_ba1eee16.var_e9797a7f = undefined;
    self.var_ba1eee16.var_cbdef43f = undefined;
    self thread function_7b83d7d();
    self thread namespace_31c67f6d::function_7b0516d7();
}

// Namespace hub_post_armada/cp_ger_hub_post_armada
// Params 0
// Checksum 0xc570902a, Offset: 0x21b8
// Size: 0x146
function function_7b83d7d()
{
    thread scene::play( "scene_hub_post_armada_dialog_mixer", "playing" );
    
    while ( true )
    {
        var_c564fe97 = self waittill( #"hash_146075442c0914da", #"hash_6ea0770b71fef985", #"hash_728ce79f143aed98" );
        thread scene::stop();
        
        switch ( var_c564fe97._notify )
        {
            case #"hash_146075442c0914da":
                thread scene::play( "scene_hub_post_armada_dialog_mixer", "playing" );
                break;
            case #"hash_6ea0770b71fef985":
                thread scene::play( "scene_hub_post_armada_dialog_mixer", "rewind" );
                break;
            case #"hash_728ce79f143aed98":
                thread scene::play( "scene_hub_post_armada_dialog_mixer", "stop_playing" );
                break;
        }
    }
}

// Namespace hub_post_armada/cp_ger_hub_post_armada
// Params 0
// Checksum 0xb21516f0, Offset: 0x2308
// Size: 0xa1c
function function_5312ebff()
{
    self.var_ba1eee16 = spawnstruct();
    self.var_ba1eee16.var_c5c9acca[ 0 ] = [ "vox_cp_sh2_02200_sims_heretoentertain_a2", 0.5 ];
    self.var_ba1eee16.var_c5c9acca[ 1 ] = [ "vox_cp_sh2_02200_sims_hello_22", 0.5 ];
    self.var_ba1eee16.var_c5c9acca[ 2 ] = [ "vox_cp_sh2_02200_sims_yeahwhatsup_39", 0.5 ];
    self.var_ba1eee16.var_c5c9acca[ 3 ] = [ "vox_cp_sh2_02200_sims_bell_ad", 0.5 ];
    self.var_ba1eee16.var_962cbf19[ 0 ] = [ "vox_cp_sh2_02200_sims_mightwanttohead_1e", 0.2 ];
    self.var_ba1eee16.var_962cbf19[ 1 ] = [ "vox_cp_sh2_02200_sims_maybelater_54", 0.2 ];
    self.var_ba1eee16.var_962cbf19[ 2 ] = [ "vox_cp_sh2_02200_sims_ivegotsomeworkt_2f", 0.2 ];
    self.var_ba1eee16.var_f2190d3d = "scene_hub_" + level.var_f5552371 + "_dialog_" + self.animname;
    self.var_ba1eee16.s_tree = dialog_tree::new_tree( &function_7279a035, &namespace_31c67f6d::function_7b9b6d21, 0, 0, self.var_ba1eee16.var_f2190d3d );
    self.var_ba1eee16.s_tree dialog_tree::add_option( #"hash_41faec541b6b39bf", [ "vox_cp_sh2_02200_sims_yougotasenseofh_8d", "vox_cp_sh2_02200_sims_lookicouldsayso_bc", "vox_cp_sh2_02200_sims_nopeforgetabout_0d" ], "dialog_talking", "waiting_idle", 0, "unlock_sims_options", "unlock_sims_options" );
    self.var_ba1eee16.s_tree dialog_tree::add_option( #"hash_41faed541b6b3b72", [ "vox_cp_sh2_02200_sims_yeahbeatdubious_63", "vox_cp_sh2_02200_sims_hellidontknowwh_cf", "vox_cp_sh2_02200_sims_youwentthrought_2e" ], "dialog_talking", "waiting_idle", 0, "unlock_sims_options", "unlock_sims_options" );
    self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87( "unlock_sims_options", #"hash_42051c541b73dfd4", [ "vox_cp_sh2_02200_sims_onlywhentheytel_d8", "vox_cp_sh2_02200_sims_whateveryouguys_05", "vox_cp_sh2_02200_sims_someonesalsogot_98", "vox_cp_sh2_02200_sims_adlerneedsitica_d2" ], "dialog_talking", "waiting_idle" );
    self.var_ba1eee16.s_tree dialog_tree::function_9e36808( #"hash_228f07eaa5e5721f", [ "vox_cp_sh2_02200_sims_imnodavincibutt_a4" ], "dialog_talking", "waiting_idle" );
    self.var_ba1eee16.s_tree dialog_tree::function_9e36808( #"hash_228f08eaa5e573d2", [ "vox_cp_sh2_02200_sims_easyicanhavetha_1f" ], "dialog_talking", "waiting_idle" );
    self.var_ba1eee16.s_tree dialog_tree::function_9e36808( #"hash_228f09eaa5e57585", [ "vox_cp_sh2_02200_sims_hehcleverbutiwa_c3", "vox_cp_sh2_02200_sims_thatsahellofare_c3" ], "dialog_talking", "waiting_idle" );
    self.var_ba1eee16.s_tree dialog_tree::function_9e36808( #"hash_228f02eaa5e569a0", [ "vox_cp_sh2_02200_sims_okaynowhowareyo_ef", "vox_cp_sh2_02200_sims_lastiheardadler_c1", "vox_cp_sh2_02200_sims_unlessyouvegota_ad" ], "dialog_talking", "waiting_idle", 0, undefined, undefined, &function_3a2c335c );
    self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87( "unlock_sims_options", #"hash_42051f541b73e4ed", [ "vox_cp_sh2_02200_sims_itriedtotrackth_74", "vox_cp_sh2_02200_sims_hesslickifyouse_2d" ], "dialog_talking", "waiting_idle", 0, undefined, undefined, &function_3a2c335c );
    
    if ( level.player namespace_70eba6e6::function_b6a02677() == 1 )
    {
        level.var_9727ef13[ 2 ] = self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87( "unlock_sims_options", #"hash_42051e541b73e33a", [ "vox_cp_sh2_02200_sims_huhthinksiguess_3d", "vox_cp_sh2_02200_sims_imeanparkoverth_8e" ], "dialog_talking", "waiting_idle", 0, undefined, undefined, &function_3a2c335c );
    }
    
    if ( level.player namespace_70eba6e6::function_b6a02677() == 2 )
    {
        level.var_9727ef13[ 2 ] = self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87( "unlock_sims_options", #"hash_42051e541b73e33a", [ "vox_cp_sh2_02200_sims_huhthinksyoudth_cf", "vox_cp_sh2_02200_sims_butiguesssomeon_c5" ], "dialog_talking", "waiting_idle", 0, undefined, undefined, &function_3a2c335c );
    }
    
    if ( level.player namespace_70eba6e6::function_b6a02677() == 3 )
    {
        level.var_9727ef13[ 2 ] = self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87( "unlock_sims_options", #"hash_42051e541b73e33a", [ "vox_cp_sh2_02200_sims_huhthinksheyimn_ab", "vox_cp_sh2_02200_sims_maybesometimesy_43" ], "dialog_talking", "waiting_idle", 0, undefined, undefined, &function_3a2c335c );
    }
    
    if ( level.player namespace_70eba6e6::function_b6a02677() == 0 )
    {
        level.var_9727ef13[ 2 ] = self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87( "unlock_sims_options", #"hash_42051e541b73e33a", [ "vox_cp_sh2_02200_sims_laughshellifikn_3b", "vox_cp_sh2_02200_sims_youknowwhatdont_58" ], "dialog_talking", "waiting_idle", 0, undefined, undefined, &function_3a2c335c );
    }
    
    self.var_ba1eee16.s_tree dialog_tree::function_7fe78745( 1, "sims_convo_exit", 1, #"hash_18589726ffc5a631", undefined, undefined, undefined, 1, [ "flag_dialog_nevermind", "flag_adler_dialog_option2_unlocked", "adler_tkdn_dlg_nvm" ], "forever" );
    self.var_ba1eee16.s_tree dialog_tree::function_6bbbf87( "sims_convo_exit", #"hash_76eebb9381390c1a", [ "vox_cp_sh2_02200_sims_comeagain_d2", "vox_cp_sh2_02200_sims_yep_5c", "vox_cp_sh2_02200_sims_yougotit_d2" ], undefined, undefined, 1, undefined, "forever" );
    self.var_ba1eee16.s_tree dialog_tree::function_46f25b65();
    self.var_ba1eee16.str_location = "clerk_desk";
    self.var_ba1eee16.v_offset = ( 0, 0, 0 );
    self.var_ba1eee16.n_fov = undefined;
    self.var_ba1eee16.var_e1eebb0b = undefined;
    self.var_ba1eee16.var_142355f9 = undefined;
    self.var_ba1eee16.var_9b7161e6 = undefined;
    self.var_ba1eee16.var_e9797a7f = undefined;
    self.var_ba1eee16.var_cbdef43f = array( 240, 650 );
    self thread namespace_31c67f6d::function_7b0516d7();
}

// Namespace hub_post_armada/cp_ger_hub_post_armada
// Params 0
// Checksum 0x2ee6f7a3, Offset: 0x2d30
// Size: 0x11c
function function_7279a035()
{
    self.var_ba1eee16.var_c5c9acca[ 0 ] = [ "vox_cp_sh2_02200_sims_heretoentertain_a2", 0.5 ];
    
    if ( level flag::get( "post_armada_evesdropped" ) && !level flag::get( "talked_to_sims_after_phone" ) )
    {
        self.var_ba1eee16.var_c5c9acca[ 0 ] = [ "vox_cp_sh2_02200_sims_whatyouthinkeve_b9", 0.5 ];
        level flag::set( "talked_to_sims_after_phone" );
        self flag::clear( "flag_all_greeting_vo_delivered" );
        self.var_ba1eee16.var_f16ae1ba = 0;
    }
    
    self namespace_31c67f6d::function_282ccb63();
}

// Namespace hub_post_armada/cp_ger_hub_post_armada
// Params 0
// Checksum 0xd95cedc5, Offset: 0x2e58
// Size: 0x1fc
function function_ae2b7b0f()
{
    self.var_ba1eee16 = spawnstruct();
    self.var_ba1eee16.var_962cbf19[ 0 ] = [ "vox_cp_sh2_02250_lazr_welltalkonthedr_ec", 0.25 ];
    self.var_ba1eee16.var_962cbf19[ 1 ] = [ "vox_cp_sh2_02250_lazr_holdthatthought_a9", 0.25 ];
    self.var_ba1eee16.var_962cbf19[ 2 ] = [ "vox_cp_sh2_02250_lazr_yeahyeah_a8", 0.25 ];
    self.var_ba1eee16.s_tree = dialog_tree::new_tree( &namespace_31c67f6d::function_282ccb63, &namespace_31c67f6d::function_7b9b6d21, 0, 0, self.var_ba1eee16.var_f2190d3d );
    self.var_ba1eee16.s_tree dialog_tree::function_7fe78745( 1, "lazar_convo_exit", 1, #"hash_18589726ffc5a631", undefined, undefined, undefined, 1, [ "flag_dialog_nevermind" ], "forever" );
    self.var_ba1eee16.var_890ce7a8 = 1;
    self.var_ba1eee16.var_18674cfa = 0;
    self.var_ba1eee16.var_89db7e3d = 1;
    self flag::set( "flag_dialog_exhausted" );
    self flag::set( "flag_speak_while_fidgeting" );
    self thread namespace_31c67f6d::function_7b0516d7();
}

// Namespace hub_post_armada/cp_ger_hub_post_armada
// Params 0
// Checksum 0xa7f7447e, Offset: 0x3060
// Size: 0x4c
function function_f856db57()
{
    level thread namespace_4ed3ce47::function_4aa573e7();
    level thread namespace_4ed3ce47::function_ef676505();
    level thread namespace_4ed3ce47::function_3c39b015();
}

// Namespace hub_post_armada/cp_ger_hub_post_armada
// Params 0
// Checksum 0x11e0dae6, Offset: 0x30b8
// Size: 0xea
function function_6d77408()
{
    while ( true )
    {
        while ( !level flag::get( "flag_player_using_evidence_board" ) )
        {
            n_wait = randomintrange( 4, 8 );
            wait n_wait;
            
            if ( !level flag::get( "flag_player_using_evidence_board" ) )
            {
                level snd::function_9ae4fc6f( "tmp_walla_radio", struct::get( "temp_radio_chatter_source", "targetname" ) );
            }
            
            n_wait = randomintrange( 10, 30 );
            wait n_wait;
        }
        
        wait 1;
    }
}

// Namespace hub_post_armada/cp_ger_hub_post_armada
// Params 0
// Checksum 0xb2ac7ee0, Offset: 0x31b0
// Size: 0x64
function function_f50bc4b9()
{
    level flag::init( "flag_post_armada_complete" );
    level flag::init( "flag_post_armada_ambient_scene_started" );
    level flag::init( "flag_post_armada_eavesdropped_timeout" );
}

// Namespace hub_post_armada/cp_ger_hub_post_armada
// Params 1
// Checksum 0xa63111ec, Offset: 0x3220
// Size: 0xe4
function function_7e4e7cf4( *var_d3440450 )
{
    level namespace_31c67f6d::function_6194f34a( "post_armada" );
    level thread function_f856db57();
    setlightingstate( 1 );
    level thread exploder::exploder( "exp_fx_post_takedown" );
    level notify( #"eboard_ready" );
    level thread namespace_31c67f6d::function_29279de1( "post_armada" );
    level thread namespace_31c67f6d::function_b0558ba2( "2" );
    level thread function_14d4099c();
}

// Namespace hub_post_armada/cp_ger_hub_post_armada
// Params 2
// Checksum 0xaff2917b, Offset: 0x3310
// Size: 0x54
function function_428d9889( var_d3440450, *var_50cc0d4f )
{
    level flag::wait_till( "flag_post_armada_ambient_scene_started" );
    
    if ( isdefined( var_50cc0d4f ) )
    {
        skipto::function_4e3ab877( var_50cc0d4f );
    }
}

// Namespace hub_post_armada/cp_ger_hub_post_armada
// Params 0
// Checksum 0x8bc135c, Offset: 0x3370
// Size: 0xcc
function function_14d4099c()
{
    level thread function_35e99044();
    level namespace_31c67f6d::function_7fd3a4d8( 1 );
    level thread scene::play( "scene_hub_env_reel_to_reel" );
    level thread scene::play( "scene_hub_post_armada_dialog_adler", "zone_idle" );
    level thread scene::play( "scene_hub_post_armada_dialog_park", "zone_idle" );
    level thread scene::play( "scene_hub_post_armada_dialog_sims", "zone_idle" );
}

// Namespace hub_post_armada/cp_ger_hub_post_armada
// Params 0
// Checksum 0x4d6e7fa0, Offset: 0x3448
// Size: 0xbc
function function_a5ab8d3f()
{
    level.adler.var_ba1eee16.s_tree dialog_tree::function_6cbfa3d2( level.var_9727ef13[ 0 ], 0 );
    level.adler.var_ba1eee16.s_tree dialog_tree::function_6cbfa3d2( level.var_9727ef13[ 1 ], 0 );
    level.sims.var_ba1eee16.s_tree dialog_tree::function_6cbfa3d2( level.var_9727ef13[ 2 ], 0 );
}

// Namespace hub_post_armada/cp_ger_hub_post_armada
// Params 0
// Checksum 0x58eb1603, Offset: 0x3510
// Size: 0xc4
function function_882e253f()
{
    if ( !level flag::get( "flag_adler_telephone_scene" ) )
    {
        self.end_dialog = 1;
        level flag::set( "flag_adler_telephone_scene" );
        level flag::clear( "flag_player_in_dialog" );
        self flag::clear( "flag_in_dialog" );
        thread function_6a63db65();
        util::delay( 1, undefined, &function_a5ab8d3f );
    }
}

// Namespace hub_post_armada/cp_ger_hub_post_armada
// Params 0
// Checksum 0xd2fbc7b3, Offset: 0x35e0
// Size: 0xec
function function_3a2c335c()
{
    if ( !level flag::get( "flag_adler_telephone_scene" ) )
    {
        self.end_dialog = 1;
        level flag::set( "flag_adler_telephone_scene" );
        level.sims waittill( #"dialog_tree_vo_response_complete", #"dialog_tree_scene_response_complete" );
        level flag::clear( "flag_player_in_dialog" );
        self flag::clear( "flag_in_dialog" );
        thread function_88338e2d();
        util::delay( 1, undefined, &function_a5ab8d3f );
    }
}

// Namespace hub_post_armada/cp_ger_hub_post_armada
// Params 0
// Checksum 0x30be7720, Offset: 0x36d8
// Size: 0x292
function function_6a63db65()
{
    iprintlnbold( "RIIIING" );
    self.var_ba1eee16.var_6edf22e1 = 1;
    self flag::set( "flag_in_scene" );
    level.sims flag::set( "flag_in_scene" );
    level.sims notify( #"kill_dialog" );
    level.sims thread function_c8bbb8b0( "scene_hub_ambient_back_room_phone_call_sims", "enter_from_adler", "scene_hub_post_armada_dialog_sims" );
    waitframe( 1 );
    
    switch ( level.var_4d1402c5 )
    {
        case #"player_in_front":
            level.adler thread scene::play( "scene_hub_post_armada_dialog_adler", "Amb_enter_front" );
            break;
        case #"player_in_back":
            level.adler thread scene::play( "scene_hub_post_armada_dialog_adler", "Amb_enter_behind" );
            break;
        case #"player_to_left":
            level.adler thread scene::play( "scene_hub_post_armada_dialog_adler", "Amb_enter_left" );
            break;
        case #"player_to_right":
            level.adler thread scene::play( "scene_hub_post_armada_dialog_adler", "Amb_enter_right" );
            break;
    }
    
    waitframe( 1 );
    level.adler flag::wait_till_clear( #"scriptedanim" );
    level flag::set( "post_armada_phone_call_happening" );
    level.adler function_c8bbb8b0( "scene_hub_ambient_back_room_phone_call_adler", "main", "scene_hub_post_armada_dialog_adler" );
    level flag::clear( "post_armada_phone_call_happening" );
    self.var_ba1eee16.var_6edf22e1 = 0;
    self.end_dialog = 0;
}

// Namespace hub_post_armada/cp_ger_hub_post_armada
// Params 0
// Checksum 0xd84849cd, Offset: 0x3978
// Size: 0x1ba
function function_88338e2d()
{
    iprintlnbold( "RIIIING" );
    self.var_ba1eee16.var_6edf22e1 = 1;
    self flag::set( "flag_in_scene" );
    thread function_13b55e88();
    waitframe( 1 );
    
    switch ( level.var_4d1402c5 )
    {
        case #"player_in_front":
            level thread scene::play( "scene_hub_post_armada_dialog_sims", "Amb_enter_front" );
            break;
        case #"player_to_left":
            level thread scene::play( "scene_hub_post_armada_dialog_sims", "Amb_enter_left" );
            break;
        case #"player_to_right":
            level thread scene::play( "scene_hub_post_armada_dialog_sims", "Amb_enter_right" );
            break;
    }
    
    waitframe( 1 );
    level.sims flag::wait_till_clear( #"scriptedanim" );
    self flag::clear( "flag_in_scene" );
    level thread scene::play( "scene_hub_post_armada_dialog_sims", "zone_idle" );
    self.var_ba1eee16.var_6edf22e1 = 0;
    self.end_dialog = 0;
}

// Namespace hub_post_armada/cp_ger_hub_post_armada
// Params 0
// Checksum 0x166c0464, Offset: 0x3b40
// Size: 0xec
function function_13b55e88()
{
    level.adler flag::set( "flag_in_scene" );
    level.adler notify( #"kill_dialog" );
    level.adler notify( #"hash_7d22c6f32f3a3cdb" );
    level scene::play( "scene_hub_post_armada_dialog_adler", "Amb_enter_front" );
    level flag::set( "post_armada_phone_call_happening" );
    level.adler function_c8bbb8b0( "scene_hub_ambient_back_room_phone_call_adler", "main", "scene_hub_post_armada_dialog_adler" );
    level flag::clear( "post_armada_phone_call_happening" );
}

// Namespace hub_post_armada/cp_ger_hub_post_armada
// Params 3
// Checksum 0x9b06287, Offset: 0x3c38
// Size: 0xac
function function_c8bbb8b0( var_6b68fbe2, var_da5872f1, idle_scene )
{
    self notify( #"hash_7d22c6f32f3a3cdb" );
    self flag::set( "flag_in_scene" );
    level scene::play( var_6b68fbe2, var_da5872f1 );
    self flag::clear( "flag_in_scene" );
    level thread scene::play( idle_scene, "zone_idle" );
}

// Namespace hub_post_armada/cp_ger_hub_post_armada
// Params 1
// Checksum 0x27e9e8f0, Offset: 0x3cf0
// Size: 0xf4
function function_5ae6f952( *var_d3440450 )
{
    level namespace_31c67f6d::function_6194f34a( "post_armada" );
    level thread function_f856db57();
    setlightingstate( 1 );
    level thread exploder::exploder( "exp_post_armada_gun_table" );
    level thread exploder::exploder( "exp_fx_post_takedown" );
    level thread namespace_31c67f6d::function_29279de1( "post_armada" );
    level thread namespace_31c67f6d::function_b0558ba2( "2" );
    level thread function_9ff4321a();
}

// Namespace hub_post_armada/cp_ger_hub_post_armada
// Params 2
// Checksum 0x76332b8c, Offset: 0x3df0
// Size: 0x2c
function function_d3875afa( *var_d3440450, *var_50cc0d4f )
{
    flag::wait_till( "flag_post_armada_complete" );
}

// Namespace hub_post_armada/cp_ger_hub_post_armada
// Params 0
// Checksum 0x76a7bd38, Offset: 0x3e28
// Size: 0x84
function function_9ff4321a()
{
    level.adler thread function_e568e0d4();
    level.park thread function_650cdcc9();
    level.sims thread function_5312ebff();
    level namespace_31c67f6d::function_7fd3a4d8( 1 );
    level scene::skipto_end( "scene_hub_post_armada_dialog_lazar" );
}

