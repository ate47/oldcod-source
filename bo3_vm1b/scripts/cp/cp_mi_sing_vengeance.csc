#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_vengeance_fx;
#using scripts/cp/cp_mi_sing_vengeance_sound;
#using scripts/shared/audio_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/enemy_highlight;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/stealth_client;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicles/_quadtank;

#namespace cp_mi_sing_vengeance;

// Namespace cp_mi_sing_vengeance
// Params 0
// Checksum 0xc1b44fe9, Offset: 0xbc0
// Size: 0x1c2
function main()
{
    util::set_streamer_hint_function( &force_streamer, 8 );
    clientfield::register( "toplayer", "enemy_highlight", 1, 1, "int", &function_93ef80c, 0, 0 );
    init_clientfields();
    setsaveddvar( "enable_global_wind", 1 );
    setsaveddvar( "wind_global_vector", "-150 -230 0" );
    cp_mi_sing_vengeance_fx::main();
    cp_mi_sing_vengeance_sound::main();
    callback::on_spawned( &on_player_spawned );
    load::main();
    level.var_be75cb3c = findstaticmodelindexarray( "graphic_content" );
    util::waitforclient( 0 );
    level thread function_23953002();
    level thread function_37d4d605();
    level thread function_be296801();
    level thread function_6f79b65d();
    level thread function_6c85145c();
    level thread function_d8ca2a96();
    level thread function_b2c7b02d();
    level thread function_8cc535c4();
    audio::playloopat( "amb_house_fan", ( 21660, -1394, -56 ) );
}

// Namespace cp_mi_sing_vengeance
// Params 0
// Checksum 0x89bbc32d, Offset: 0xd90
// Size: 0x32a
function init_clientfields()
{
    level flag::init( "kill_qt_alley_light" );
    clientfield::register( "toplayer", "play_client_igc", 1, 4, "int", &function_a3bc7b7b, 0, 0 );
    clientfield::register( "toplayer", "apartment_light_fire_fx", 1, 1, "int", &function_5d084d45, 0, 0 );
    clientfield::register( "toplayer", "kill_qt_alley_light", 1, 1, "int", &function_1e770357, 0, 0 );
    clientfield::register( "scriptmover", "xiulan_face_burn", 1, 1, "int", &function_1401c820, 0, 0 );
    clientfield::register( "scriptmover", "normal_hide", 1, 1, "int", &function_1c33477, 0, 0 );
    clientfield::register( "actor", "normal_hide", 1, 1, "int", &function_1c33477, 0, 0 );
    clientfield::register( "scriptmover", "mature_hide", 1, 1, "int", &function_ba9281fe, 0, 0 );
    clientfield::register( "actor", "mature_hide", 1, 1, "int", &function_ba9281fe, 0, 0 );
    clientfield::register( "world", "fxanims_intro", 1, 1, "int", &function_6b145814, 0, 0 );
    clientfield::register( "world", "fxanims_killing_streets", 1, 1, "int", &function_6b145814, 0, 0 );
    clientfield::register( "world", "fxanims_dogleg_1", 1, 1, "int", &function_6b145814, 0, 0 );
    clientfield::register( "world", "fxanims_dogleg_2", 1, 1, "int", &function_6b145814, 0, 0 );
    clientfield::register( "world", "fxanims_garage_igc", 1, 1, "int", &function_6b145814, 0, 0 );
    clientfield::register( "world", "fxanims_safehouse_explodes", 1, 1, "int", &function_6b145814, 0, 0 );
}

// Namespace cp_mi_sing_vengeance
// Params 7
// Checksum 0x5e9b71a5, Offset: 0x10c8
// Size: 0x82
function function_6b145814( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        level thread scene::play( fieldname, "targetname" );
        return;
    }
    
    if ( newval == 0 )
    {
        level thread scene::stop( fieldname, "targetname", 1 );
    }
}

// Namespace cp_mi_sing_vengeance
// Params 5
// Checksum 0x6e31738f, Offset: 0x1158
// Size: 0x73, Type: bool
function function_b69b9863( localclientnum, oldval, newval, bnewent, binitialsnap )
{
    if ( !self islocalplayer() )
    {
        return false;
    }
    
    if ( !isdefined( self getlocalclientnumber() ) )
    {
        return false;
    }
    
    if ( self getlocalclientnumber() != localclientnum )
    {
        return false;
    }
    
    return true;
}

// Namespace cp_mi_sing_vengeance
// Params 7
// Checksum 0xcd216239, Offset: 0x11d8
// Size: 0xed
function function_a3bc7b7b( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( !function_b69b9863( localclientnum, oldval, newval, bnewent, binitialsnap ) )
    {
        return;
    }
    
    switch ( newval )
    {
        case 1:
            function_22f8ce71( localclientnum );
            break;
        case 2:
            function_3ef59fde( localclientnum );
            break;
        case 3:
            break;
        case 4:
            break;
        case 5:
            break;
        case 6:
            break;
        case 7:
            break;
        case 8:
            break;
    }
}

// Namespace cp_mi_sing_vengeance
// Params 1
// Checksum 0xaa72ae8e, Offset: 0x12d0
// Size: 0xeb
function function_22f8ce71( localclientnum )
{
    var_3209e83e = struct::get_array( "killing_streets_vign", "targetname" );
    var_6a07eb6c = [];
    var_6a07eb6c[ 0 ] = "civilian_death_pose";
    
    foreach ( struct in var_3209e83e )
    {
        if ( isdefined( struct.script_noteworthy ) )
        {
            scene::add_scene_func( struct.script_noteworthy, &function_65a61b78, "play", var_6a07eb6c );
            struct thread scene::play( struct.script_noteworthy );
        }
    }
}

// Namespace cp_mi_sing_vengeance
// Params 1
// Checksum 0x89c71d7f, Offset: 0x13c8
// Size: 0xc3
function function_3ef59fde( localclientnum )
{
    var_3209e83e = struct::get_array( "killing_streets_vign", "targetname" );
    
    foreach ( struct in var_3209e83e )
    {
        if ( isdefined( struct.script_noteworthy ) )
        {
            struct thread scene::stop( struct.script_noteworthy, 1 );
            level struct::delete_script_bundle( "scene", struct.script_noteworthy );
        }
    }
}

// Namespace cp_mi_sing_vengeance
// Params 2
// Checksum 0x24a34ea2, Offset: 0x1498
// Size: 0x8b
function function_65a61b78( a_ents, var_6a07eb6c )
{
    if ( !ismaturecontentenabled() )
    {
        foreach ( object_name in var_6a07eb6c )
        {
            if ( isdefined( a_ents[ object_name ] ) )
            {
                a_ents[ object_name ] hide();
            }
        }
    }
}

// Namespace cp_mi_sing_vengeance
// Params 1
// Checksum 0xc9805cd5, Offset: 0x1530
// Size: 0x4a
function function_8cfdae7( localclientnum )
{
    struct = struct::get( "dogleg_1_intro_org", "targetname" );
    struct scene::play( "cin_ven_04_10_cafedoor_1st_sh010" );
}

// Namespace cp_mi_sing_vengeance
// Params 7
// Checksum 0xf9c5e4c4, Offset: 0x1588
// Size: 0x62
function function_1c33477( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        self hide();
        return;
    }
    
    self show();
}

// Namespace cp_mi_sing_vengeance
// Params 7
// Checksum 0x7d6504eb, Offset: 0x15f8
// Size: 0x72
function function_ba9281fe( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval && !util::is_mature() )
    {
        self hide();
        return;
    }
    
    self show();
}

// Namespace cp_mi_sing_vengeance
// Params 7
// Checksum 0x8b137e99, Offset: 0x1678
// Size: 0x102
function function_93ef80c( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( !self islocalplayer() )
    {
        return;
    }
    
    if ( !isdefined( self getlocalclientnumber() ) )
    {
        return;
    }
    
    if ( self getlocalclientnumber() != localclientnum )
    {
        return;
    }
    
    if ( newval )
    {
        if ( !( isdefined( self.enemy_highlight_display ) && self.enemy_highlight_display ) )
        {
            self thread enemy_highlight::enemy_highlight_display( localclientnum, "compassping_enemysatellite_diamond", 64, 0.25, 1, 1, "compassping_friendly" );
        }
        
        return;
    }
    
    if ( isdefined( self.enemy_highlight_display ) && self.enemy_highlight_display )
    {
        self thread enemy_highlight::enemy_highlight_display_stop( localclientnum );
    }
}

// Namespace cp_mi_sing_vengeance
// Params 1
// Checksum 0x4bc4c5d5, Offset: 0x1788
// Size: 0x519
function force_streamer( n_zone )
{
    stopforcingstreamer();
    
    switch ( n_zone )
    {
        case 0:
            break;
        case 1:
            forcestreamxmodel( "c_hro_hendricks_sing_body" );
            forcestreamxmodel( "c_hro_hendricks_sing_head" );
            forcestreamxmodel( "c_civ_zur_sing_male_5_face_fb_bloody" );
            break;
        case 2:
            forcestreamxmodel( "c_hro_hendricks_sing_body" );
            forcestreamxmodel( "c_hro_hendricks_sing_head" );
            break;
        case 3:
            forcestreamxmodel( "c_54i_assault_body" );
            forcestreamxmodel( "c_54i_assault_head1" );
            forcestreamxmodel( "c_54i_assault_head2" );
            forcestreamxmodel( "c_54i_assault_head3" );
            forcestreamxmodel( "c_hro_hendricks_sing_body" );
            forcestreamxmodel( "c_hro_hendricks_sing_head" );
            forcestreamxmodel( "wpn_t7_ar_shva_prop_animate" );
            forcestreamxmodel( "c_civ_zur_male_body1_1" );
            forcestreamxmodel( "c_civ_zur_male_body1_2" );
            forcestreamxmodel( "c_civ_zur_male_body1_3" );
            forcestreamxmodel( "c_civ_zur_male_body1_4" );
            forcestreamxmodel( "c_civ_zur_male_body2_1" );
            forcestreamxmodel( "c_civ_zur_male_body2_2" );
            forcestreamxmodel( "c_civ_zur_male_body2_3" );
            forcestreamxmodel( "c_civ_zur_male_body2_4" );
            forcestreamxmodel( "c_civ_zur_male_body4_1" );
            forcestreamxmodel( "c_civ_zur_male_body4_2" );
            forcestreamxmodel( "c_civ_zur_male_body4_3" );
            forcestreamxmodel( "c_civ_zur_male_body4_4" );
            forcestreamxmodel( "c_civ_zur_male_body5_1" );
            forcestreamxmodel( "c_civ_zur_male_body5_2" );
            forcestreamxmodel( "c_civ_zur_male_body5_3" );
            forcestreamxmodel( "c_civ_zur_male_body5_4" );
            forcestreamxmodel( "c_civ_egypt_male_body3_1" );
            forcestreamxmodel( "c_civ_egypt_male_body3_2" );
            forcestreamxmodel( "c_civ_egypt_male_body3_3" );
            forcestreamxmodel( "c_civ_sing_male_head1" );
            forcestreamxmodel( "c_civ_sing_male_head2" );
            break;
        case 4:
            forcestreamxmodel( "c_civ_egypt_female_body1_4_bloody" );
            forcestreamxmodel( "c_civ_zur_female_body1_2_bloody" );
            forcestreamxmodel( "c_civ_zur_female_body3_3_bloody" );
            forcestreamxmodel( "c_civ_zur_female_body4_2_bloody" );
            forcestreamxmodel( "c_civ_sing_female_head1_bloody" );
            forcestreamxmodel( "c_civ_sing_female_head2_bloody" );
            break;
        case 7:
            forcestreamxmodel( "p7_ven_ctc_windows_01" );
            break;
        case 5:
            break;
        case 6:
            forcestreamxmodel( "c_hro_hendricks_sing_body" );
            forcestreamxmodel( "c_hro_hendricks_sing_head" );
            forcestreamxmodel( "c_hro_rachel_sing_fb" );
            forcestreamxmodel( "c_hro_goh_xiulan_base_cyberarm_burn_fb" );
            forcestreambundle( "cin_ven_12_01_1st_kane_rescue" );
            forcestreambundle( "cin_ven_12_kane_3rd_sh010" );
            forcestreambundle( "cin_ven_12_kane_3rd_sh020" );
            forcestreambundle( "cin_ven_12_kane_3rd_sh030" );
            forcestreambundle( "cin_ven_12_kane_3rd_sh040" );
            break;
        default:
            break;
    }
}

// Namespace cp_mi_sing_vengeance
// Params 7
// Checksum 0x70d91bda, Offset: 0x1cb0
// Size: 0x72
function function_5d084d45( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        exploder::exploder( "apartment_light_fire" );
        return;
    }
    
    exploder::stop_exploder( "apartment_light_fire" );
}

// Namespace cp_mi_sing_vengeance
// Params 0
// Checksum 0x41c92c1b, Offset: 0x1d30
// Size: 0x95
function function_23953002()
{
    level endon( #"hash_524d1cbf" );
    level waittill( #"qt_fire_missile" );
    s_explosion = struct::get( "quadteaser_org", "targetname" );
    ropepulse( s_explosion.origin, 550, 500, 40, 35 );
    
    while ( true )
    {
        level waittill( #"hash_71984294" );
        ropepulse( s_explosion.origin, 550, 500, 30, 25 );
    }
}

// Namespace cp_mi_sing_vengeance
// Params 7
// Checksum 0xd3d0f7d4, Offset: 0x1dd0
// Size: 0x72
function function_1e770357( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        exploder::exploder( "quad_tank_alley_volumetric" );
        return;
    }
    
    exploder::stop_exploder( "quad_tank_alley_volumetric" );
}

// Namespace cp_mi_sing_vengeance
// Params 0
// Checksum 0x90ed21d3, Offset: 0x1e50
// Size: 0xb3
function function_37d4d605()
{
    level waittill( #"hash_132639c7" );
    var_c13b7e2a = struct::get_array( "dogleg_2_glass_break", "targetname" );
    
    foreach ( var_d64f5bac in var_c13b7e2a )
    {
        physicsexplosionsphere( 0, var_d64f5bac.origin + ( -6, 0, 0 ), 60, 30, 0.5, 60, 60, 0, 1 );
    }
}

// Namespace cp_mi_sing_vengeance
// Params 0
// Checksum 0x68d4283b, Offset: 0x1f10
// Size: 0x28a
function function_be296801()
{
    var_d9bfcc72 = findvolumedecalindexarray( "garage_wall_hit_01_decal" );
    var_b3bd5209 = findvolumedecalindexarray( "garage_wall_hit_02_decal" );
    var_8dbad7a0 = findvolumedecalindexarray( "garage_wall_hit_03_decal" );
    var_97cc307f = findvolumedecalindexarray( "garage_wall_hit_04_decal" );
    var_71c9b616 = findvolumedecalindexarray( "garage_wall_hit_05_decal" );
    var_4bc73bad = findvolumedecalindexarray( "garage_wall_hit_06_decal" );
    var_25c4c144 = findvolumedecalindexarray( "garage_wall_hit_07_decal" );
    var_2fd61a23 = findvolumedecalindexarray( "garage_wall_hit_08_decal" );
    var_9d39fba = findvolumedecalindexarray( "garage_wall_hit_09_decal" );
    var_d9bfcc72 thread function_cc435ce1();
    var_b3bd5209 thread function_cc435ce1();
    var_8dbad7a0 thread function_cc435ce1();
    var_97cc307f thread function_cc435ce1();
    var_71c9b616 thread function_cc435ce1();
    var_4bc73bad thread function_cc435ce1();
    var_25c4c144 thread function_cc435ce1();
    var_2fd61a23 thread function_cc435ce1();
    var_9d39fba thread function_cc435ce1();
    var_d9bfcc72 thread function_5bd50680( "garage_wall_hit_01" );
    var_b3bd5209 thread function_5bd50680( "garage_wall_hit_02" );
    var_8dbad7a0 thread function_5bd50680( "garage_wall_hit_03" );
    var_97cc307f thread function_5bd50680( "garage_wall_hit_04" );
    var_71c9b616 thread function_5bd50680( "garage_wall_hit_05" );
    var_4bc73bad thread function_5bd50680( "garage_wall_hit_06" );
    var_25c4c144 thread function_5bd50680( "garage_wall_hit_07" );
    var_2fd61a23 thread function_5bd50680( "garage_wall_hit_08" );
    var_9d39fba thread function_5bd50680( "garage_wall_hit_09" );
}

// Namespace cp_mi_sing_vengeance
// Params 0
// Checksum 0x3b6c2d2a, Offset: 0x21a8
// Size: 0x5b
function function_cc435ce1()
{
    foreach ( var_b2afdf94 in self )
    {
        hidevolumedecal( var_b2afdf94 );
    }
}

// Namespace cp_mi_sing_vengeance
// Params 1
// Checksum 0xbfa6909, Offset: 0x2210
// Size: 0x6b
function function_5bd50680( wait_notify )
{
    level waittill( wait_notify );
    
    foreach ( var_b2afdf94 in self )
    {
        unhidevolumedecal( var_b2afdf94 );
    }
}

// Namespace cp_mi_sing_vengeance
// Params 0
// Checksum 0xc3797d26, Offset: 0x2288
// Size: 0x16a
function function_6f79b65d()
{
    level waittill( #"hash_82cbfe2b" );
    var_ac0ac802 = struct::get_array( "qt_trex_stomp", "targetname" );
    
    for ( i = 0; i < 3 ; i++ )
    {
        foreach ( s_explosion in var_ac0ac802 )
        {
            ropepulse( s_explosion.origin, -6, 350, 20, 10 );
        }
        
        soundrattle( var_ac0ac802[ 0 ].origin, 500, 1500 );
        wait 1;
    }
    
    level waittill( #"hash_d801dbda" );
    
    foreach ( s_explosion in var_ac0ac802 )
    {
        ropepulse( s_explosion.origin, -6, 350, 50, 40 );
    }
    
    soundrattle( var_ac0ac802[ 0 ].origin, 500, 1500 );
}

// Namespace cp_mi_sing_vengeance
// Params 0
// Checksum 0x1a4faceb, Offset: 0x2400
// Size: 0xfa
function function_d8ca2a96()
{
    smodelanimcmd( "backdraft_1a_blinds", "pause", "unloop", "goto_start" );
    smodelanimcmd( "backdraft_1b_blinds", "pause", "unloop", "goto_start" );
    smodelanimcmd( "backdraft_1c_blinds", "pause", "unloop", "goto_start" );
    level waittill( #"hash_704aebad" );
    smodelanimcmd( "backdraft_1a_blinds", "unpause" );
    smodelanimcmd( "backdraft_1b_blinds", "unpause" );
    smodelanimcmd( "backdraft_1c_blinds", "unpause" );
}

// Namespace cp_mi_sing_vengeance
// Params 0
// Checksum 0x7d6f4b14, Offset: 0x2508
// Size: 0x5a
function function_b2c7b02d()
{
    smodelanimcmd( "backdraft_2_blinds", "pause", "unloop", "goto_start" );
    level waittill( #"hash_2a99eaf6" );
    smodelanimcmd( "backdraft_2_blinds", "unpause" );
}

// Namespace cp_mi_sing_vengeance
// Params 0
// Checksum 0xaa2523db, Offset: 0x2570
// Size: 0xaa
function function_8cc535c4()
{
    smodelanimcmd( "backdraft_3a_blinds", "pause", "unloop", "goto_start" );
    smodelanimcmd( "backdraft_3b_blinds", "pause", "unloop", "goto_start" );
    level waittill( #"hash_9013621b" );
    smodelanimcmd( "backdraft_3a_blinds", "unpause" );
    smodelanimcmd( "backdraft_3b_blinds", "unpause" );
}

// Namespace cp_mi_sing_vengeance
// Params 0
// Checksum 0xe971c203, Offset: 0x2628
// Size: 0xaa
function function_6c85145c()
{
    smodelanimcmd( "safehouse_falling_debris", "pause", "unloop", "goto_start" );
    smodelanimcmd( "safehouse_falling_debris_rail", "pause", "unloop", "goto_start" );
    level waittill( #"hash_d41345fd" );
    smodelanimcmd( "safehouse_falling_debris", "unpause" );
    smodelanimcmd( "safehouse_falling_debris_rail", "unpause" );
}

// Namespace cp_mi_sing_vengeance
// Params 7
// Checksum 0x7f1a6cde, Offset: 0x26e0
// Size: 0x25d
function function_1401c820( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        var_8f5b0626 = 0;
        var_b4a26be3 = 0;
        n_increment = 0.1;
        var_83bdc800 = 0.4;
        var_f5c5373b = 0.35;
        var_cfc2bcd2 = 0.25;
        var_cc07c7f3 = 0.1;
        var_5a0058b8 = 0.1;
        var_8002d321 = 0.55;
        var_3e0f372e = 0.25;
        
        while ( var_8f5b0626 < var_83bdc800 )
        {
            var_8f5b0626 += n_increment * var_83bdc800;
            
            if ( isdefined( self ) )
            {
                self mapshaderconstant( 0, 0, "scriptVector0", 0, var_8f5b0626, 0, 0 );
            }
            else
            {
                return;
            }
            
            wait n_increment;
        }
        
        while ( var_8f5b0626 < var_f5c5373b )
        {
            var_8f5b0626 += n_increment * var_f5c5373b;
            
            if ( isdefined( self ) )
            {
                self mapshaderconstant( 0, 0, "scriptVector0", 0, var_8f5b0626, 0, 0 );
            }
            else
            {
                return;
            }
            
            wait n_increment;
        }
        
        while ( var_8f5b0626 < var_f5c5373b )
        {
            var_8f5b0626 += n_increment * var_f5c5373b;
            
            if ( isdefined( self ) )
            {
                self mapshaderconstant( 0, 0, "scriptVector0", 0, var_8f5b0626, 0, 0 );
            }
            else
            {
                return;
            }
            
            wait n_increment;
        }
        
        while ( var_8f5b0626 < var_5a0058b8 )
        {
            var_b4a26be3 += n_increment * var_5a0058b8;
            
            if ( isdefined( self ) )
            {
                self mapshaderconstant( 0, 0, "scriptVector0", var_b4a26be3, var_8f5b0626, 0, 0 );
            }
            else
            {
                return;
            }
            
            wait n_increment;
        }
        
        while ( var_8f5b0626 < var_8002d321 )
        {
            var_b4a26be3 += n_increment * var_8002d321;
            
            if ( isdefined( self ) )
            {
                self mapshaderconstant( 0, 0, "scriptVector0", var_b4a26be3, var_8f5b0626, 0, 0 );
            }
            else
            {
                return;
            }
            
            wait n_increment;
        }
        
        while ( var_8f5b0626 < var_3e0f372e )
        {
            var_b4a26be3 += n_increment * var_3e0f372e;
            
            if ( isdefined( self ) )
            {
                self mapshaderconstant( 0, 0, "scriptVector0", var_b4a26be3, var_8f5b0626, 0, 0 );
            }
            else
            {
                return;
            }
            
            wait n_increment;
        }
    }
}

// Namespace cp_mi_sing_vengeance
// Params 1
// Checksum 0x49f33b21, Offset: 0x2948
// Size: 0x10b
function on_player_spawned( localclientnum )
{
    if ( !isdefined( level.var_be75cb3c ) )
    {
        return;
    }
    
    if ( !ismaturecontentenabled() )
    {
        foreach ( i, model in level.var_be75cb3c )
        {
            if ( isdefined( model ) )
            {
                hidestaticmodel( model );
            }
            
            if ( i % 25 == 0 )
            {
                wait 0.016;
            }
        }
        
        return;
    }
    
    foreach ( model in level.var_be75cb3c )
    {
        if ( isdefined( model ) )
        {
            unhidestaticmodel( model );
        }
    }
}

