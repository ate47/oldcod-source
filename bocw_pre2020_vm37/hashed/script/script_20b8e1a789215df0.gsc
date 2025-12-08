#using script_2d443451ce681a;
#using script_3919f386abede84;
#using script_3c70d86dfe255354;
#using script_3dc93ca9902a9cda;
#using script_4ab78e327b76395f;
#using script_4b6505921addc7bc;
#using script_549b1f81e7dfe241;
#using script_708fc8496e63a128;
#using script_758226507b1afa11;
#using script_86ebb5dd573a003;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\collectibles;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\ui\prompts;
#using scripts\cp_common\util;

#namespace namespace_e6b6aea1;

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0x2cb1ed8d, Offset: 0x1820
// Size: 0x54
function function_22b7fffd()
{
    animation::add_notetrack_func( "cp_ger_stakeout_apt::vo_edda_reaction", &function_63dd294e );
    animation::add_notetrack_func( "cp_ger_stakeout_apt::vo_kraus_reaction", &function_27cda4ce );
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 1
// Checksum 0xa5aadce2, Offset: 0x1880
// Size: 0x12c
function function_9de162de( *str_objective )
{
    level function_3141d875();
    level thread function_fb12384e();
    exploder::exploder( "lgt_exp_target_building_01" );
    level flag::set( "flag_apt_near_front_door" );
    level thread function_1610ce5e();
    player = getplayers()[ 0 ];
    player setmovespeedscale( 0.5 );
    player val::set( "apartment", "allow_sprint", 0 );
    windows::lock( "apt_bedroom_window", "script_noteworthy" );
    level thread namespace_fba81a7f::function_47620ece();
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 2
// Checksum 0xd223ae94, Offset: 0x19b8
// Size: 0x37c
function function_b3837ddc( str_objective, var_50cc0d4f )
{
    a_ai = getaiarchetypearray( #"human", "all" );
    
    foreach ( ai in a_ai )
    {
        if ( isdefined( ai.script_noteworthy ) && ai.script_noteworthy != "kraus" && ai.script_noteworthy != "wife" )
        {
            ai val::set( "apartment", "ignoreall", 1 );
            ai val::set( "apartment", "ignoreme", 1 );
        }
    }
    
    level thread function_7fc4cb95();
    level thread namespace_11998b8f::function_25120710();
    player = getplayers()[ 0 ];
    
    if ( var_50cc0d4f )
    {
        level thread namespace_afd0968c::function_36a9bec7( var_50cc0d4f );
        level thread namespace_fba81a7f::function_3dfe810();
    }
    
    level thread music::setmusicstate( "13.0_apartment" );
    level flag::set( "start_apartment_entry_lighting" );
    exploder::exploder( "lgt_exp_target_building_02" );
    level thread function_af031d54();
    level thread function_963791c5();
    
    if ( isdefined( level.stealth.disguised ) )
    {
        player namespace_979752dc::set_disguised( 0 );
    }
    
    level thread function_328da7d3();
    level thread function_33e6dffe();
    level thread function_9cddf76d();
    level flag::wait_till( "apartment_1_done" );
    level thread music::setmusicstate( "14.0_find_briefcase" );
    
    if ( isdefined( level.var_5242ca24 ) )
    {
        array::delete_all( level.var_5242ca24 );
    }
    
    if ( isdefined( level.apt_street_police ) )
    {
        array::delete_all( level.apt_street_police );
    }
    
    skipto::function_4e3ab877( str_objective );
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0x42afec91, Offset: 0x1d40
// Size: 0x144
function function_9cddf76d()
{
    thread namespace_3e1df757::function_b524c30d();
    level.var_3559e9e thread function_15c263da( "front_door" );
    level.var_49a292bb thread function_b66c66e( "front_door" );
    level thread namespace_c80e7f5f::function_84378e8a();
    level thread namespace_c80e7f5f::function_e1af55d1();
    level thread namespace_c80e7f5f::function_c60ce98d();
    level thread namespace_c80e7f5f::function_ba5c6b95();
    level thread namespace_c80e7f5f::function_6589b125();
    level thread function_3862e30();
    
    while ( !isdefined( level.var_6c4b8850 ) )
    {
        waitframe( 1 );
    }
    
    level flag::wait_till( "flag_close_front_door" );
    doors::lock( "tgt_apt_front_door", "targetname", 1 );
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0xe3e72905, Offset: 0x1e90
// Size: 0x4c
function function_3141d875()
{
    spawner::add_spawn_function_group( "apartment_ai", "targetname", &function_9bd924c1 );
    spawner::simple_spawn( "apartment_ai" );
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0xba0282cb, Offset: 0x1ee8
// Size: 0x1ca
function function_9bd924c1()
{
    level.var_54b83d35 = struct::get( "tag_align_target_apt_first_floor", "targetname" );
    level.var_bd5c9b86 = struct::get( "tag_align_target_apt_second_floor", "targetname" );
    self ai::set_behavior_attribute( "patrol", 1 );
    self.var_c681e4c1 = 1;
    self.goalradius = 16;
    self.team = "axis";
    self.diequietly = 1;
    self val::set( "apartment", "allowdeath", 1 );
    self setcandamage( 1 );
    self.health = 15;
    self.stealth.threatsightratescale = 1.75;
    
    switch ( self.script_noteworthy )
    {
        case #"kraus":
            level.var_49a292bb = self;
            self.animname = "kraus";
            self.var_c5553760 = 1;
            break;
        case #"wife":
            level.var_3559e9e = self;
            self.animname = "wife";
            self.var_c5553760 = 1;
            self thread function_8be5093c();
            break;
        default:
            break;
    }
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0xa89ad770, Offset: 0x20c0
// Size: 0xf4
function function_1610ce5e()
{
    while ( !isdefined( level.var_3559e9e ) )
    {
        waitframe( 1 );
    }
    
    level thread scene::play( "aib_vign_stakeout_safehouse_surveillance_wife", "z_stk_apt_1st_floor_wash_dishes_wife_loop", level.var_3559e9e );
    kitchen_window_right_closed = getent( "kitchen_window_right_closed", "targetname" );
    kitchen_window_right_closed hide();
    kitchen_window_left_closed = getent( "kitchen_window_left_closed", "targetname" );
    kitchen_window_left_closed hide();
    level.var_49a292bb animation::last_frame( "z_stk_surveillance_desk_kraus_exit", level.var_bd5c9b86 );
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 1
// Checksum 0x17db8ae2, Offset: 0x21c0
// Size: 0xc
function function_8770f3e7( *a_ents )
{
    
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 1
// Checksum 0xf1f927ed, Offset: 0x21d8
// Size: 0xac
function function_a6a7797f( a_ents )
{
    level.var_7d6bf2d4 = a_ents[ #"hash_475ee55621b83ca0" ];
    level.var_6a64a507 = util::spawn_model( "weapon_wm_m1911_composite" );
    level.var_6a64a507 hidepart( "j_mag2", "weapon_wm_m1911_composite" );
    level.var_6a64a507 linkto( level.var_7d6bf2d4, "j_prop_1", ( 0, 0, 0 ), ( 0, 0, 270 ) );
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0xc925f8d, Offset: 0x2290
// Size: 0x5bc
function function_fb12384e()
{
    level.var_54b83d35 = struct::get( "tag_align_target_apt_first_floor", "targetname" );
    level.var_bd5c9b86 = struct::get( "tag_align_target_apt_second_floor", "targetname" );
    level.apt_couch_pillow = getent( "apt_couch_pillow", "targetname" );
    level.apt_couch_pillow.animname = "apt_pillow";
    level.apt_phone = getent( "apt_phone", "targetname" );
    level.apt_phone.animname = "apt_phone";
    level.apt_nightstand = getent( "apt_nightstand", "targetname" );
    level.apt_nightstand.animname = "apt_nightstand";
    level.apt_kettle = getent( "apt_kettle", "targetname" );
    level.apt_kettle.animname = "apt_kettle";
    level.apt_umbrella = getent( "apt_umbrella", "targetname" );
    level.apt_umbrella.animname = "apt_umbrella";
    scene::add_scene_func( "aib_vign_stakeout_apt_kraus", &function_a6a7797f, "init" );
    scene::add_scene_func( "cin_stakeout_apt_bodycarry_pickup_apt_gl_exit", &function_7adcc91a, "done" );
    level scene::init( "aib_vign_stakeout_apt_wife" );
    level scene::init( "aib_vign_stakeout_apt_kraus" );
    level scene::init( "aib_vign_stakeout_apt_child" );
    level scene::init( "cin_stakeout_apt_bodycarry_pickup_apt_gl_exit" );
    level.var_6c4b8850 = doors::function_73f09315( "tgt_apt_front_door" );
    level.var_89f4e16c = doors::function_73f09315( "tgt_apt_master_bedroom_door" );
    level.var_3cb475ae = doors::function_73f09315( "tgt_apt_child_bedroom_door" );
    level.var_78cfbe5a = doors::function_73f09315( "apt_door_lower_bedroom" );
    level.var_bb05e8f5 = getent( "darkroom_hidden_door", "targetname" );
    var_598a701b = struct::get( "secret_door_pos", "targetname" );
    level.var_bb05e8f5 moveto( var_598a701b.origin, 0.05, 0, 0 );
    var_617f3755 = getent( "secret_wall_panel", "targetname" );
    var_ee7f9f95 = struct::get( "secret_wall_panel_pos_01", "targetname" );
    var_617f3755 moveto( var_ee7f9f95.origin, 0.05, 0, 0 );
    level flag::wait_till( "apartment_2_done" );
    waitframe( 1 );
    
    if ( isdefined( level.apt_couch_pillow ) )
    {
        level.apt_couch_pillow delete();
    }
    
    if ( isdefined( level.apt_phone ) )
    {
        level.apt_phone delete();
    }
    
    if ( isdefined( level.var_a7549ee ) )
    {
        level.var_a7549ee delete();
    }
    
    waitframe( 1 );
    
    if ( isdefined( level.apt_umbrella ) )
    {
        level.apt_umbrella delete();
    }
    
    if ( isdefined( level.var_c986705b ) )
    {
        level.var_c986705b delete();
    }
    
    if ( isdefined( level.apt_kettle ) )
    {
        level.apt_kettle delete();
    }
    
    waitframe( 1 );
    
    if ( isdefined( level.apt_nightstand ) )
    {
        level.apt_nightstand delete();
    }
    
    if ( isdefined( level.var_7d6bf2d4 ) )
    {
        level.var_7d6bf2d4 delete();
    }
    
    if ( isdefined( level.var_6a64a507 ) )
    {
        level.var_6a64a507 delete();
    }
    
    waitframe( 1 );
    
    if ( isdefined( level.var_f844521d ) )
    {
        level.var_f844521d delete();
    }
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0xe2b8beb, Offset: 0x2858
// Size: 0x104
function function_7fc4cb95()
{
    kitchen_window_right_closed = getent( "kitchen_window_right_closed", "targetname" );
    kitchen_window_right_closed show();
    kitchen_window_left_closed = getent( "kitchen_window_left_closed", "targetname" );
    kitchen_window_left_closed show();
    kitchen_window_right_open = getent( "kitchen_window_right_open", "targetname" );
    kitchen_window_right_open delete();
    kitchen_window_left_open = getent( "kitchen_window_left_open", "targetname" );
    kitchen_window_left_open delete();
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 1
// Checksum 0xc7b8dbbb, Offset: 0x2968
// Size: 0x7c
function function_7adcc91a( a_ents )
{
    victim = a_ents[ #"victim" ];
    victim endon( #"death" );
    level flag::wait_till( "apartment_2_done" );
    
    if ( isdefined( victim ) )
    {
        victim delete();
    }
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0x4dc1b4fc, Offset: 0x29f0
// Size: 0x11c
function function_328da7d3()
{
    videoprime( "1981_Dutch_soccer_game_1" );
    level flag::wait_till( "flag_start_apt_tv" );
    var_d412235d = snd::play( "sp_stakeout_apt_tv", ( 1714, 4968, 212 ) );
    videostart( "1981_Dutch_soccer_game_1" );
    level flag::wait_till( "flag_briefcase_found" );
    
    if ( isdefined( var_d412235d ) )
    {
        var_d412235d snd::stop( "sp_stakeout_apt_tv" );
        waitframe( 1 );
        
        if ( isdefined( var_d412235d ) )
        {
            var_d412235d delete();
        }
        
        wait 3;
    }
    
    videostop( "1981_Dutch_soccer_game_1" );
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0xaf57818d, Offset: 0x2b18
// Size: 0x74
function function_3862e30()
{
    level flag::wait_till_any( array( "flag_see_kraus_shadow_failsafe", "flag_see_kraus_shadow" ) );
    level.var_49a292bb thread function_4b86eb01();
    
    if ( isdefined( level.var_3559e9e ) )
    {
        level.var_3559e9e thread function_4fa71d38();
    }
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 1
// Checksum 0xe6525125, Offset: 0x2b98
// Size: 0x13a
function function_15c263da( var_763776e6 )
{
    level.var_3559e9e.var_66f1a336 = &function_a8ad2bdb;
    level.var_3559e9e.disableeasystealthheadshot = 1;
    self.var_b9c0ade5 = 1;
    self namespace_979752dc::set_event_override( "investigate", &function_620b79a );
    self namespace_979752dc::set_event_override( "cover_blown", &function_620b79a );
    self namespace_979752dc::set_event_override( "combat", &function_620b79a );
    
    switch ( var_763776e6 )
    {
        case #"front_door":
            self thread function_13d3b6eb();
            break;
        case #"office_skip":
            self thread function_1709dcd();
            break;
        default:
            break;
    }
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 1
// Checksum 0x17d521c5, Offset: 0x2ce0
// Size: 0x40, Type: bool
function function_620b79a( *event )
{
    if ( isdefined( self.spotted ) )
    {
        return false;
    }
    
    self.spotted = 1;
    self thread function_3cbcb275();
    return true;
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0x2aa2fcf1, Offset: 0x2d28
// Size: 0x4fc
function function_3cbcb275()
{
    self endon( #"damage", #"death" );
    level notify( #"hash_205bf17f449d4088" );
    level notify( #"phone_picked_up" );
    self val::set( "apartment", "ignoreall", 1 );
    self val::set( "apartment", "ignoreme", 1 );
    player = getplayers()[ 0 ];
    dirtoenemy = vectornormalize( player.origin - self.origin );
    forward = anglestoforward( self.angles );
    dot_fwd = vectordot( dirtoenemy, forward );
    right = anglestoright( self.angles );
    dot_right = vectordot( dirtoenemy, right );
    reaction = undefined;
    
    if ( level flag::get( "flag_wife_watching_tv" ) )
    {
        level.var_54b83d35 thread scene::play( "aib_vign_stakeout_apt_wife", "z_stk_apt_spot_player_on_couch_wife", self );
    }
    else
    {
        if ( dot_fwd >= 0.7 )
        {
            if ( isdefined( self.a.movement ) && ( self.a.movement == "walk" || self.a.movement == "run" ) )
            {
                reaction = "walking_front";
            }
            else
            {
                reaction = "standing_front";
            }
        }
        else if ( dot_fwd <= -0.7 )
        {
            if ( isdefined( self.a.movement ) && ( self.a.movement == "walk" || self.a.movement == "run" ) )
            {
                reaction = "walking_behind";
            }
            else
            {
                reaction = "standing_behind";
            }
        }
        else if ( dot_right <= -0.7 )
        {
            if ( isdefined( self.a.movement ) && ( self.a.movement == "walk" || self.a.movement == "run" ) )
            {
                reaction = "walking_left";
            }
            else
            {
                reaction = "standing_left";
            }
        }
        else if ( isdefined( self.a.movement ) && ( self.a.movement == "walk" || self.a.movement == "run" ) )
        {
            reaction = "walking_right";
        }
        else
        {
            reaction = "standing_right";
        }
        
        if ( isdefined( reaction ) )
        {
            align_tag = spawn( "script_model", self.origin );
            align_tag.angles = self.angles;
            align_tag setmodel( "script_origin" );
            align_tag thread scene::play( "aib_vign_stakeout_apt_wife_reacts", "z_stk_apt_spot_player_" + reaction + "_wife", self );
        }
        else
        {
            assertmsg( "<dev string:x38>" );
        }
        
        /#
            print3d( self.origin + ( 0, 0, 60 ), "<dev string:x76>" + reaction, ( 1, 0, 0 ), 1, 0.75, 20 );
        #/
    }
    
    self waittill( #"react_vo" );
    level thread function_1de222fe();
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 1
// Checksum 0x3ae5238a, Offset: 0x3230
// Size: 0xf4
function function_63dd294e( *params )
{
    level.var_3559e9e endon( #"hash_2a34667d783e7701" );
    level.var_3559e9e thread vo_stop();
    level.var_3559e9e dialogue::queue( "vox_cp_stkt_11400_edda_scream_5b" );
    level.var_3559e9e waittill( #"react_vo" );
    vo_array = array( "vox_cp_stkt_11400_edda_franzhelp_17", "vox_cp_stkt_11400_edda_franz_22", "vox_cp_stkt_11400_edda_help_4a" );
    vo = array::random( vo_array );
    level.var_3559e9e dialogue::queue( vo );
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0x32552c4, Offset: 0x3330
// Size: 0x54
function vo_stop()
{
    self waittill( #"damage", #"death" );
    self notify( #"hash_2a34667d783e7701" );
    self dialogue::function_47b06180();
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0xc4ce867e, Offset: 0x3390
// Size: 0x54
function function_1de222fe()
{
    if ( !level flag::get( "flag_wife_is_darted" ) )
    {
        util::missionfailedwrapper( #"hash_4c5af5a1cd80371", #"hash_253c3de152942bc4" );
    }
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0x8eb925fe, Offset: 0x33f0
// Size: 0xcc
function function_13d3b6eb()
{
    self endon( #"damage", #"death", #"dart_gunned" );
    level flag::wait_till( "flag_1st_entry_front_door" );
    level.var_54b83d35 thread scene::play( "aib_vign_stakeout_apt_wife", "wife_phone_front_door_answer", self );
    self thread namespace_c80e7f5f::function_74581093();
    self flag::wait_till_clear( #"scriptedanim" );
    self thread function_a769d1d();
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0x5d3851da, Offset: 0x34c8
// Size: 0x1ec
function function_a769d1d()
{
    self notify( "4192defae760b869" );
    self endon( "4192defae760b869" );
    self endon( #"damage", #"death", #"dart_gunned" );
    self.skipdeathanim = 1;
    flag_return = level flag::wait_till_any( array( "flag_wife_phone_fidget", "flag_apt_wife_phone_call_done", "flag_edda_umbrella" ) );
    
    if ( flag_return._notify == "flag_wife_phone_fidget" )
    {
        if ( isalive( self ) && !level flag::get( "flag_edda_umbrella" ) )
        {
            level.var_54b83d35 thread scene::play( "aib_vign_stakeout_apt_wife", "wife_phone_fidget", self );
        }
        
        level flag::wait_till_any( array( "flag_apt_wife_phone_call_done", "flag_edda_umbrella" ) );
    }
    
    if ( isalive( self ) )
    {
        level.var_54b83d35 scene::play( "aib_vign_stakeout_apt_wife", "wife_phone_exit", self );
    }
    
    self.skipdeathanim = 0;
    level notify( #"hash_21e8502431806421" );
    
    if ( !level flag::get( "flag_edda_umbrella" ) )
    {
        self thread function_d6da2ce5();
    }
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0xbbf50903, Offset: 0x36c0
// Size: 0x1fc
function function_d6da2ce5()
{
    self notify( "569df4385345dbef" );
    self endon( "569df4385345dbef" );
    self endon( #"damage", #"death", #"dart_gunned" );
    level endon( #"flag_edda_umbrella" );
    level.var_54b83d35 scene::play( "aib_vign_stakeout_apt_wife", "fix_tea_start", self );
    level thread dialogue::radio( "vox_cp_stkt_11250_park_watchoutthewife_5e" );
    level thread scene::play( "aib_vign_stakeout_safehouse_surveillance_wife", "z_stk_apt_1st_floor_watch_tv_wife_enter", self );
    level flag::wait_till( "flag_wife_watching_tv" );
    level thread flag::delay_set( 5, "flag_kettle_can_whistle" );
    level flag::wait_till( "flag_kitchen_kettle" );
    
    if ( isdefined( level.apt_kettle ) )
    {
        level thread function_bdce9e8f();
    }
    
    wait 3;
    level scene::play( "aib_vign_stakeout_safehouse_surveillance_wife", "z_stk_apt_1st_floor_watch_tv_wife_exit", self );
    level thread dialogue::radio( "vox_cp_stkt_11250_park_thewifeiscoming_13" );
    level.var_54b83d35 scene::play( "aib_vign_stakeout_apt_wife", "fix_tea_finish", self );
    level thread scene::play( "aib_vign_stakeout_safehouse_surveillance_wife", "z_stk_apt_1st_floor_watch_tv_wife_enter", self );
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0xff36471e, Offset: 0x38c8
// Size: 0x34
function function_1709dcd()
{
    level.var_54b83d35 thread scene::play( "aib_vign_stakeout_safehouse_surveillance_wife", "z_stk_apt_1st_floor_watch_tv_wife_loop", level.var_3559e9e );
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0xa0f7b7ba, Offset: 0x3908
// Size: 0x2c
function function_bdce9e8f()
{
    level waittill( #"hash_5450898ce50a75ea" );
    
    if ( isdefined( level.apt_kettle ) )
    {
    }
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0x70d927ab, Offset: 0x3940
// Size: 0x9c
function function_8be5093c()
{
    level endon( #"apartment_2_done" );
    self waittill( #"death" );
    wait 0.25;
    
    if ( level flag::get( "flag_wife_is_darted" ) )
    {
        return;
    }
    
    wait 2;
    util::missionfailedwrapper( #"hash_4c5af5a1cd80371", #"hash_1dd066257b842378" );
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0x8d91dcfa, Offset: 0x39e8
// Size: 0x38c
function function_a8ad2bdb()
{
    if ( level flag::get( "flag_wife_is_darted" ) )
    {
        return;
    }
    
    if ( isdefined( level.var_3559e9e ) )
    {
        level.var_3559e9e dialogue::function_47b06180();
    }
    
    level flag::set( "flag_wife_is_darted" );
    level thread music::function_edda155f( "13.0_apartment_stinger" );
    player = getplayers()[ 0 ];
    player notify( #"hash_255ac7580395ed51" );
    self thread function_bd346448();
    self thread function_c0bfecc7();
    level notify( #"hash_205bf17f449d4088" );
    level notify( #"phone_picked_up" );
    self notify( #"darted" );
    self notify( #"single dialogue" );
    self val::set( "apartment", "ignoreall", 1 );
    self val::set( "apartment", "ignoreme", 1 );
    level thread function_d131ba5d();
    level.var_54b83d35 scene::stop( "aib_vign_stakeout_apt_wife" );
    
    if ( level flag::get( "flag_wife_on_phone" ) )
    {
        var_3dd2d06b = getent( "apt_phone", "targetname" );
        self.a.nodeath = 1;
        getplayers()[ 0 ] namespace_5f6e61d9::function_694887dc( "cin_stakeout_apt_bodycarry_pickup_apt_gl_start" );
        self thread scene::play( "aib_vign_stakeout_apt_wife", "wife_phone_tranq", self );
        self waittill( #"death" );
        self ai::set_corpse_entity( undefined );
    }
    else if ( level flag::get( "flag_wife_watching_tv" ) )
    {
        self.a.nodeath = 1;
        self thread scene::play( "aib_vign_stakeout_apt_wife", "wife_couch_tranq", self );
        self waittill( #"death" );
        self ai::set_corpse_entity( undefined );
    }
    else
    {
        self startragdoll();
        self kill();
    }
    
    level thread function_811c81e6();
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0xdab9a6e7, Offset: 0x3d80
// Size: 0x1f0
function function_811c81e6()
{
    level endon( #"apartment_2_done" );
    
    while ( !getplayers()[ 0 ] namespace_5f6e61d9::function_cad84e26() )
    {
        waitframe( 1 );
    }
    
    getplayers()[ 0 ] namespace_5f6e61d9::function_461dbe2a();
    level thread function_556e2045();
    
    while ( !level flag::get( "flag_wife_placed_on_couch" ) )
    {
        var_a37c27f3 = struct::get( "wife_body_drop_pos", "targetname" );
        var_a37c27f3 util::remove_cursor_hint();
        var_a37c27f3 util::create_cursor_hint( undefined, undefined, #"hash_6e3be33918521155", 56 );
        var_a37c27f3 prompts::function_3171730f( #"use", #"body_carry" );
        var_a37c27f3 thread function_c4139f80();
        var_a37c27f3 thread function_97be6108();
        level flag::wait_till( "flag_wife_dropped_on_floor" );
        
        while ( !getplayers()[ 0 ] namespace_5f6e61d9::function_cad84e26() )
        {
            waitframe( 1 );
        }
        
        level flag::clear( "flag_wife_dropped_on_floor" );
    }
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0x5da7c38f, Offset: 0x3f78
// Size: 0xc
function function_556e2045()
{
    wait 1.5;
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0x2877f686, Offset: 0x3f90
// Size: 0x254
function function_c4139f80()
{
    self notify( "3a9478aed345ef80" );
    self endon( "3a9478aed345ef80" );
    self waittill( #"trigger" );
    var_aa8b96f8 = struct::get( "tag_align_wife_body_drop", "targetname" );
    getplayers()[ 0 ] namespace_5f6e61d9::function_d0cb2574( "cin_stakeout_apt_bodycarry_pickup_apt_gl_exit" );
    getplayers()[ 0 ] namespace_5f6e61d9::function_145a8b5a( 0 );
    getplayers()[ 0 ] notify( #"hash_4dff86580406a1af" );
    var_b16b4f00 = struct::get_array( "wife_body_drop_pos", "targetname" );
    
    foreach ( item in var_b16b4f00 )
    {
        item util::remove_cursor_hint();
    }
    
    level flag::set( "flag_wife_placed_on_couch" );
    
    /#
        iprintlnbold( "<dev string:x83>" );
    #/
    
    getplayers()[ 0 ].var_9ebbaa46.var_7e5a6cf9 = 1;
    getplayers()[ 0 ] waittill( #"hash_51c6ae96a7e40432" );
    getplayers()[ 0 ].var_9ebbaa46.var_7e5a6cf9 = undefined;
    getplayers()[ 0 ] namespace_5f6e61d9::function_b5b485f1();
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0xa8adf2b8, Offset: 0x41f0
// Size: 0x168
function function_97be6108()
{
    player = getplayers()[ 0 ];
    level endon( #"flag_wife_placed_on_couch", #"apartment_2_done" );
    player endon( #"death" );
    
    while ( player namespace_5f6e61d9::function_cad84e26() )
    {
        waitframe( 1 );
    }
    
    level flag::set( "flag_wife_dropped_on_floor" );
    
    /#
        iprintlnbold( "<dev string:x9b>" );
    #/
    
    var_b16b4f00 = struct::get_array( "wife_body_drop_pos", "targetname" );
    
    foreach ( item in var_b16b4f00 )
    {
        item util::remove_cursor_hint();
    }
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0x7a43fcbc, Offset: 0x4360
// Size: 0x110
function function_d131ba5d()
{
    level endon( #"flag_wife_placed_on_couch" );
    vol = getent( "couch_vol", "targetname" );
    
    while ( true )
    {
        while ( !getplayers()[ 0 ] istouching( vol ) )
        {
            waitframe( 1 );
        }
        
        getplayers()[ 0 ] namespace_5f6e61d9::function_145a8b5a( 1 );
        
        while ( getplayers()[ 0 ] istouching( vol ) )
        {
            waitframe( 1 );
        }
        
        getplayers()[ 0 ] namespace_5f6e61d9::function_145a8b5a( 0 );
    }
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0x795e47d2, Offset: 0x4478
// Size: 0xa4
function function_c0bfecc7()
{
    kitchen_vol = getent( "apt_kitchen_vol", "targetname" );
    var_8190476e = getent( "apt_living_room_vol", "targetname" );
    
    while ( !getplayers()[ 0 ] namespace_5f6e61d9::function_cad84e26() )
    {
        waitframe( 1 );
    }
    
    level flag::set( "flag_activate_kraus_shadow_trigger" );
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0xe6668351, Offset: 0x4528
// Size: 0x27c
function function_4fa71d38()
{
    self endon( #"damage", #"death" );
    level endon( #"flag_wife_is_darted" );
    
    if ( level flag::get( "flag_wife_is_darted" ) )
    {
        return;
    }
    
    self.goalradius = 16;
    level flag::set( "flag_edda_umbrella" );
    
    if ( level flag::get( "flag_wife_watching_tv" ) )
    {
        wait 0.7;
        self util::delay( 2.3, "flag_wife_is_darted", &namespace_c80e7f5f::function_b2659110 );
        level.var_54b83d35 scene::play( "aib_vign_stakeout_safehouse_surveillance_wife", "z_stk_apt_1st_floor_watch_tv_wife_exit", self );
    }
    else
    {
        wait 1;
        self dialogue::function_47b06180();
        wait 2;
        self thread namespace_c80e7f5f::function_b2659110();
        
        if ( level flag::get( "flag_wife_on_phone" ) )
        {
            level waittill( #"hash_21e8502431806421" );
        }
    }
    
    level thread function_bdcd69b8();
    level.var_54b83d35 scene::play( "aib_vign_stakeout_apt_wife", "1st_floor_deliver_umbrella", self );
    
    if ( level flag::get( "flag_kraus_in_lower_hall" ) )
    {
        goal = spawn( "script_origin", self.origin );
        self setgoal( goal.origin, 1 );
        level flag::wait_till_clear( "flag_kraus_in_lower_hall" );
    }
    
    level.var_54b83d35 thread scene::play( "aib_vign_stakeout_safehouse_surveillance_wife", "z_stk_apt_1st_floor_watch_tv_wife_enter", self );
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0xc05bef24, Offset: 0x47b0
// Size: 0x4c
function function_bdcd69b8()
{
    level endon( #"flag_edda_holding_umbrella" );
    level flag::wait_till( "flag_wife_is_darted" );
    level.var_a7549ee animation::stop();
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0xf93fac78, Offset: 0x4808
// Size: 0xac
function function_bd346448()
{
    if ( level flag::get( "flag_edda_holding_umbrella" ) )
    {
        level.var_a7549ee animation::stop();
        level.apt_umbrella unlink();
        waitframe( 1 );
        level.apt_umbrella physicslaunch( level.var_a7549ee.origin + ( 0, 0, 4 ), ( 0, 0, -100 ) );
    }
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 1
// Checksum 0x7a843a31, Offset: 0x48c0
// Size: 0x15a
function function_b66c66e( var_763776e6 )
{
    while ( !isdefined( self ) )
    {
        waitframe( 1 );
    }
    
    self.var_d48fb0bb = &function_8a91f60c;
    self namespace_979752dc::set_event_override( "investigate", &function_19acc1c0 );
    self namespace_979752dc::set_event_override( "cover_blown", &function_19acc1c0 );
    self namespace_979752dc::set_event_override( "combat", &function_19acc1c0 );
    self removesentienteventlistener( "silenced_shot" );
    self thread function_73f8fadd();
    self thread function_3b4254ca();
    
    switch ( var_763776e6 )
    {
        case #"front_door":
            break;
        case #"office_skip":
            self thread function_6bae0a9();
            break;
        default:
            break;
    }
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0x58b2f98a, Offset: 0x4a28
// Size: 0x5bc
function function_4b86eb01()
{
    self endon( #"death", #"kraus_spotted_player" );
    level thread function_aa936112();
    level thread function_b9c20732();
    returned = level flag::wait_till_any( array( "flag_see_kraus_shadow", "flag_see_kraus_shadow_failsafe" ) );
    
    if ( returned._notify == "flag_see_kraus_shadow" )
    {
        level scene::play_from_time( "aib_vign_stakeout_apt_kraus", "z_stk_apt_2nd_floor_call_down_to_wife_target", self, 5, 0, 1 );
    }
    else
    {
        level scene::play_from_time( "aib_vign_stakeout_apt_kraus", "z_stk_apt_2nd_floor_call_down_to_wife_target", self, 5.5, 0, 1 );
    }
    
    level thread scene::play( "aib_vign_stakeout_apt_kraus", "z_stk_apt_2nd_floor_office_target_enter", self );
    level flag::wait_till( "flag_apt_upstairs" );
    level thread namespace_c80e7f5f::function_d2ae6f8d();
    level scene::play( "aib_vign_stakeout_apt_kraus", "z_stk_apt_2nd_floor_call_down_to_wife_target_alt", self );
    waitframe( 1 );
    level scene::play( "aib_vign_stakeout_apt_kraus", "z_stk_apt_walk_down_stairs_target", self );
    level notify( #"hash_341edafabf8168e4" );
    
    if ( level flag::get( "flag_wife_is_darted" ) && level flag::get( "flag_wife_placed_on_couch" ) )
    {
        self thread namespace_c80e7f5f::function_952d90b5();
        waitframe( 1 );
        level scene::play( "aib_vign_stakeout_apt_kraus", "z_stk_apt_check_on_wife_target", self );
    }
    else if ( level flag::get( "flag_wife_is_darted" ) )
    {
        level flag::set( "flag_kraus_checking_living_room" );
        self thread namespace_c80e7f5f::function_ed37b989();
        waitframe( 1 );
        level scene::play( "aib_vign_stakeout_apt_kraus", "z_stk_apt_check_on_wife_target", self );
        level flag::clear( "flag_kraus_checking_living_room" );
    }
    else if ( level flag::get( "flag_edda_in_hall" ) )
    {
        waitframe( 1 );
        self scene::play( "aib_vign_stakeout_apt_kraus", "z_stk_apt_walking_stall_target", self );
        self util::delay( 4, "death", &dialogue::queue, "vox_cp_stkt_11225_krus_thankyoudear_89" );
    }
    
    level flag::set( "flag_kraus_in_lower_hall" );
    self.goalradius = 16;
    self thread function_1f314257();
    
    if ( !level.var_78cfbe5a doors::is_open() )
    {
        level.var_78cfbe5a.animname = "door";
        waitframe( 1 );
        var_6deddb80 = struct::get( "lower_bedroom_door", "targetname" );
        var_6deddb80 scene::play( array( level.var_49a292bb, level.var_78cfbe5a ) );
    }
    
    waitframe( 1 );
    level thread scene::play( "aib_vign_stakeout_apt_kraus", "guest_room_enter", self );
    self waittill( #"hash_3fb228a70ee2ba7e" );
    trigger = getent( "guest_room_failsafe_trigger", "targetname" );
    self thread function_41ff2f97( trigger, "lower" );
    level flag::set( "flag_kraus_umbrella_done" );
    vol = getent( "apt_downstairs_bedroom_vol", "targetname" );
    
    if ( getplayers()[ 0 ] istouching( vol ) )
    {
        trig = getent( "near_lower_bedroom_trigger", "targetname" );
        trig delete();
    }
    
    level thread function_edf2504c();
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0x5f23bf8, Offset: 0x4ff0
// Size: 0x11c
function function_edf2504c()
{
    level.var_49a292bb endon( #"death", #"kraus_spotted_player", #"hash_774b3e0c443d80dd" );
    time = 0;
    max_time = 7;
    vol = getent( "apt_downstairs_bedroom_vol", "targetname" );
    
    while ( time < max_time )
    {
        if ( getplayers()[ 0 ] istouching( vol ) )
        {
            time += float( function_60d95f53() ) / 1000;
        }
        
        waitframe( 1 );
    }
    
    level flag::set( "flag_kraus_exit_bedroom" );
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0xc5e25d40, Offset: 0x5118
// Size: 0x22c
function function_1f314257()
{
    self endon( #"death", #"kraus_spotted_player", #"hash_774b3e0c443d80dd" );
    level flag::wait_till( "flag_kraus_exit_bedroom" );
    level scene::play( "aib_vign_stakeout_apt_kraus", "guest_room_exit", self );
    self.goalradius = 16;
    goal = struct::get( "kraus_return_upstairs", "targetname" );
    self setgoal( goal, 1 );
    level flag::wait_till( "flag_apt_kraus_back_upstairs" );
    
    if ( !level.var_89f4e16c doors::is_open() )
    {
        level.var_89f4e16c.animname = "door";
        waitframe( 1 );
        var_6deddb80 = struct::get( "upper_bedroom_door", "targetname" );
        var_6deddb80 scene::play( array( level.var_49a292bb, level.var_89f4e16c ) );
    }
    
    level thread scene::play( "aib_vign_stakeout_apt_kraus", "master_bedroom_enter", self );
    self waittill( #"hash_5b9dfc1ea7e895c7" );
    level flag::set( "flag_kraus_on_bed" );
    trigger = getent( "master_bedroom_failsafe_trigger", "targetname" );
    self thread function_41ff2f97( trigger, "upper" );
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 1
// Checksum 0x428891f0, Offset: 0x5350
// Size: 0x38
function function_3d01b9fd( *guy )
{
    level.var_6a64a507 hide();
    level notify( #"hash_5c3d7a6dbf4a8ddf" );
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 1
// Checksum 0xe98ad796, Offset: 0x5390
// Size: 0x54
function function_dc22625e( *guy )
{
    level endon( #"hash_5c3d7a6dbf4a8ddf" );
    level flag::wait_till( "flag_kraus_spotted_player" );
    level.var_6a64a507 hide();
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0xb75081d8, Offset: 0x53f0
// Size: 0x6c
function function_6bae0a9()
{
    level thread scene::play( "aib_vign_stakeout_apt_kraus", "guest_room_enter", self );
    self thread function_1f314257();
    self val::reset( "apartment", "ignoreall" );
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0x208a743f, Offset: 0x5468
// Size: 0xac
function function_73f8fadd()
{
    self endon( #"death", #"kraus_spotted_player" );
    level endon( #"hash_7538d0f49c08fc76" );
    
    while ( !isdefined( self.stealth.corpse.ent ) )
    {
        wait 0.25;
    }
    
    self notify( #"kraus_found_corpse" );
    self thread function_aa4ca19c( 1 );
    level flag::set( "flag_kraus_spotted_player" );
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0x65fb1a4c, Offset: 0x5520
// Size: 0x144
function function_8a91f60c()
{
    self notify( #"darted" );
    self notify( #"single dialogue" );
    self dialogue::queue( "vox_cp_stkt_11425_krus_what_bc" );
    level flag::set( "flag_kraus_spotted_player" );
    
    if ( level flag::get( "flag_kraus_is_darted" ) )
    {
        return;
    }
    
    level flag::set( "flag_kraus_is_darted" );
    self val::set( "apartment", "ignoreall", 1 );
    self val::set( "apartment", "ignoreme", 1 );
    self startragdoll();
    wait 1.5;
    self kill();
    dialogue::radio( "vox_cp_stkt_11425_park_dammitweneededk_5d" );
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 2
// Checksum 0x24364a64, Offset: 0x5670
// Size: 0xbc
function function_41ff2f97( trigger, position )
{
    self notify( #"darted" );
    level endon( #"hash_7538d0f49c08fc76", #"hash_4fd2220067d87773" );
    self thread function_f24e0f31( trigger, position );
    level flag::wait_till( "flag_behind_kraus" );
    self thread function_aa4ca19c();
    level flag::set( "flag_kraus_spotted_player" );
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 2
// Checksum 0xf3573dcd, Offset: 0x5738
// Size: 0xac
function function_f24e0f31( trigger, position )
{
    if ( position == "lower" )
    {
        level flag::wait_till_clear( "flag_kraus_kneeling" );
    }
    else if ( position == "upper" )
    {
        level flag::wait_till( "apartment_explosive_placed" );
    }
    else
    {
        return;
    }
    
    level notify( #"hash_4fd2220067d87773" );
    
    if ( isdefined( trigger ) )
    {
        trigger delete();
    }
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 1
// Checksum 0xfc03ccb8, Offset: 0x57f0
// Size: 0x60, Type: bool
function function_19acc1c0( *event )
{
    if ( isdefined( self.spotted ) )
    {
        return false;
    }
    
    self.spotted = 1;
    self thread function_aa4ca19c();
    level flag::set( "flag_kraus_spotted_player" );
    return true;
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 1
// Checksum 0x743397ca, Offset: 0x5858
// Size: 0x4d6
function function_aa4ca19c( corpse_found )
{
    self endon( #"damage", #"death" );
    self endon( #"death" );
    self val::set( "apartment", "ignoreall", 1 );
    self val::set( "apartment", "ignoreme", 1 );
    self notify( #"kraus_spotted_player" );
    
    if ( isdefined( corpse_found ) )
    {
        dirtoenemy = vectornormalize( self.stealth.corpse.ent.origin - self.origin );
    }
    else
    {
        dirtoenemy = vectornormalize( getplayers()[ 0 ].origin - self.origin );
    }
    
    forward = anglestoforward( self.angles );
    dot_fwd = vectordot( dirtoenemy, forward );
    right = anglestoright( self.angles );
    dot_right = vectordot( dirtoenemy, right );
    reaction = undefined;
    
    if ( isdefined( corpse_found ) )
    {
        align_tag = spawn( "script_model", self.origin );
        align_tag.angles = self.angles;
        align_tag setmodel( "script_origin" );
        align_tag thread scene::play( "aib_vign_stakeout_apt_kraus_react", "z_stk_apt_spot_wife_target", self );
        wait 6;
        self notify( #"fail_mission" );
        return;
    }
    
    if ( level flag::get( "flag_kraus_on_bed" ) )
    {
        level thread scene::play( "aib_vign_stakeout_apt_kraus_react", "master_bedroom_spot_player", self );
        wait 3.7;
        self notify( #"fail_mission" );
        return;
    }
    
    if ( level flag::get( "flag_kraus_kneeling" ) )
    {
        level thread scene::play( "aib_vign_stakeout_apt_kraus_react", "guest_room_spot_player", array( self, level.apt_nightstand, level.var_7d6bf2d4 ) );
        wait 6.5;
        self notify( #"fail_mission" );
        return;
    }
    
    if ( level flag::get( "flag_kraus_office_chair" ) )
    {
        level thread scene::play( "aib_vign_stakeout_apt_kraus_react", "office_spot_player", self );
        wait 2.5;
        self notify( #"fail_mission" );
        return;
    }
    
    if ( dot_fwd >= 0.7 )
    {
        reaction = "front_target";
    }
    else if ( dot_fwd <= -0.7 )
    {
        reaction = "behind_target";
    }
    else if ( dot_right <= -0.7 )
    {
        reaction = "right_target";
    }
    else
    {
        reaction = "left_target";
    }
    
    if ( isdefined( reaction ) )
    {
        self thread scene::play( "aib_vign_stakeout_apt_kraus_react", "z_stk_apt_spot_player_" + reaction, self );
    }
    else
    {
        assertmsg( "<dev string:xb4>" );
    }
    
    /#
        print3d( self.origin + ( 0, 0, 60 ), "<dev string:x76>" + reaction, ( 1, 0, 0 ), 1, 0.75, 20 );
    #/
    
    wait 5;
    self notify( #"fail_mission" );
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 1
// Checksum 0x79c6dadb, Offset: 0x5d38
// Size: 0xec
function function_27cda4ce( *params )
{
    level.var_49a292bb endon( #"hash_2a34667d783e7701" );
    level.var_49a292bb thread vo_stop();
    level.var_49a292bb dialogue::queue( "vox_cp_stkt_11425_krus_what_bc" );
    level.var_49a292bb waittill( #"react_vo" );
    vo_array = array( "vox_cp_stkt_11450_krus_whoareyou_42", "vox_cp_stkt_11450_krus_howdidyougetinh_56" );
    vo = array::random( vo_array );
    level.var_49a292bb dialogue::queue( vo );
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0x164377f7, Offset: 0x5e30
// Size: 0xe4
function function_3b4254ca()
{
    level endon( #"hash_7538d0f49c08fc76" );
    s_result = self waittill( #"fail_mission", #"damage", #"death" );
    wait 1;
    
    if ( s_result._notify == "fail_mission" )
    {
        util::missionfailedwrapper( #"hash_4c5af5a1cd80371", #"hash_4039ceec8d9c7c5e" );
        return;
    }
    
    util::missionfailedwrapper( #"hash_4c5af5a1cd80371", #"hash_46ac7b0e0f9d53a" );
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 1
// Checksum 0x58fc405b, Offset: 0x5f20
// Size: 0x224
function function_aa936112( skipto )
{
    returned = level flag::wait_till_any( array( "flag_see_kraus_shadow", "flag_see_kraus_shadow_failsafe" ) );
    level.child = spawner::simple_spawn_single( "child" );
    level.child val::set( "apartment", "ignoreall", 1 );
    level.child val::set( "apartment", "ignoreme", 1 );
    level.child.animname = "child";
    level.child.allowpain = 0;
    level.child val::set( "apartment", "allowdeath", 0 );
    level.child ai::gun_remove();
    
    if ( !is_true( skipto ) )
    {
        level thread namespace_c80e7f5f::function_74866b7c();
    }
    
    if ( returned._notify == "flag_see_kraus_shadow" )
    {
        level scene::play_from_time( "aib_vign_stakeout_apt_child", "run_into_bathroom", level.child, 2.6, 0, 1 );
    }
    else
    {
        level scene::play_from_time( "aib_vign_stakeout_apt_child", "run_into_bathroom", level.child, 8.1, 0, 1 );
    }
    
    level thread scene::play( "aib_vign_stakeout_apt_child", "z_stk_apt_gl_in_bathroom_kid", level.child );
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0xa69ea26d, Offset: 0x6150
// Size: 0x11c
function function_b9c20732()
{
    level flag::wait_till( "flag_apt_halfway_stairs" );
    level.child thread dialogue::queue( "vox_cp_stkt_11300_will_dadareyoucoming_e6" );
    level flag::wait_till( "flag_approaching_office" );
    util::delay( 2, undefined, &snd::play, "evt_stk_apt_toilet_flush", ( 1686, 4666, 396 ) );
    level.child util::delay( 3, undefined, &dialogue::queue, "vox_cp_stkt_11300_will_dadimalldone_46" );
    util::delay( 9, undefined, &snd::play, "evt_stk_apt_bathroom_water", ( 1686, 4666, 396 ) );
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0xbaa6fa4, Offset: 0x6278
// Size: 0x8c
function function_33e6dffe()
{
    level endon( #"apartment_2_done" );
    trigger::wait_till( "apt_bathroom_door_trigger" );
    level.child dialogue::queue( "vox_cp_stkt_11475_will_scream_5b" );
    wait 1;
    util::missionfailedwrapper( #"hash_4c5af5a1cd80371", #"hash_b4302157d22e1af" );
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0x5b5142bb, Offset: 0x6310
// Size: 0x15c
function function_af031d54()
{
    objectives::scripted( "obj_locate_briefcase", undefined, #"hash_1133bb730a6dcbf0" );
    level flag::wait_till( "flag_briefcase_found" );
    objectives::complete( "obj_locate_briefcase" );
    var_2474602c = struct::get( "obj_apt_briefcase", "targetname" );
    objectives::scripted( "obj_plant_device", undefined, #"hash_277d3d1d1ea0a57b" );
    objectives::goto( "obj_plant_device", var_2474602c.origin, undefined, 0 );
    level thread function_91bf4e4b();
    level flag::wait_till( "apartment_explosive_placed" );
    
    if ( !isdefined( objectives::function_285e460( "obj_apt_exit" ) ) )
    {
        objectives::scripted( "obj_exit_apt", undefined, #"hash_12b7bf71c03d97a9" );
    }
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0x111fffad, Offset: 0x6478
// Size: 0xbc
function function_963791c5()
{
    if ( collectibles::function_ab921f3d( 1 ) )
    {
        var_4ad0d08d = getentarray( "ledger", "targetname" );
        array::delete_all( var_4ad0d08d );
        return;
    }
    
    var_a697899e = struct::get_array( "potential_ledger_pos", "targetname" );
    array::thread_all( var_a697899e, &function_d07f9e90 );
    level thread function_2f24a62a();
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0x5553c038, Offset: 0x6540
// Size: 0x3c
function function_2f24a62a()
{
    level flag::wait_till( "flag_apt_ledger_found" );
    collectibles::function_6cd091d2( 1 );
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0x906f4c2d, Offset: 0x6588
// Size: 0x3c
function function_91bf4e4b()
{
    level flag::wait_till( "apartment_explosive_placed" );
    objectives::complete( "obj_plant_device" );
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0x52240af4, Offset: 0x65d0
// Size: 0x5c
function function_2d9c96af()
{
    level flag::wait_till( "flag_exiting_apt" );
    objectives::complete( "obj_exit_apt" );
    level flag::set( "apartment_2_done" );
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0x9dbea3e9, Offset: 0x6638
// Size: 0x1d0
function function_d07f9e90()
{
    level endon( #"hash_66dd1fb05a674d8f" );
    self util::create_cursor_hint( undefined, undefined, #"hash_2f5be718d91a4c1e", 70 );
    self waittill( #"trigger" );
    
    switch ( self.script_parameters )
    {
        case #"hash_275dda2f7b704c76":
            self thread function_db844d6d();
            break;
        case #"hash_155ebc163a242dd6":
            self thread function_a971060e();
            break;
        case #"2f_bedroom_drawer":
            self thread function_a3233bf5();
            break;
        default:
            break;
    }
    
    level waittill( #"hash_6317f16a37432c3a" );
    level flag::set( "flag_apt_ledger_found" );
    var_a697899e = struct::get_array( "potential_ledger_pos", "targetname" );
    array::thread_all( var_a697899e, &util::remove_cursor_hint );
    var_4ad0d08d = getentarray( "ledger", "targetname" );
    array::delete_all( var_4ad0d08d );
    level notify( #"hash_66dd1fb05a674d8f" );
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0x7652314, Offset: 0x6810
// Size: 0x170
function function_db844d6d()
{
    level endon( #"hash_66dd1fb05a674d8f" );
    door = getent( self.script_parameters, "targetname" );
    var_af01916d = struct::get( door.target, "targetname" );
    namespace_5ceacc03::function_c32bc34f();
    door moveto( var_af01916d.origin, 1, 0.5, 0.5 );
    wait 1.5;
    var_4ad0d08d = getentarray( "ledger", "targetname" );
    arraysortclosest( var_4ad0d08d, level.player.origin );
    var_4ad0d08d[ 0 ] util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"hash_681addf148e5303" );
    var_4ad0d08d[ 0 ] waittill( #"trigger" );
    level notify( #"hash_6317f16a37432c3a" );
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0xb3a48414, Offset: 0x6988
// Size: 0x178
function function_a971060e()
{
    level endon( #"hash_66dd1fb05a674d8f" );
    drawer = getent( "desk_office_drawer_01", "targetname" );
    fwd = anglestoforward( drawer.angles );
    namespace_5ceacc03::function_a3c35c97();
    drawer moveto( drawer.origin + fwd * 10, 1, 0.5, 0.5 );
    wait 1.5;
    var_4ad0d08d = getentarray( "ledger", "targetname" );
    arraysortclosest( var_4ad0d08d, level.player.origin );
    var_4ad0d08d[ 0 ] util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"hash_681addf148e5303" );
    var_4ad0d08d[ 0 ] waittill( #"trigger" );
    level notify( #"hash_6317f16a37432c3a" );
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0x7fb198f4, Offset: 0x6b08
// Size: 0x178
function function_a3233bf5()
{
    level endon( #"hash_66dd1fb05a674d8f" );
    drawer = getent( "2f_bedroom_drawer", "targetname" );
    fwd = anglestoright( drawer.angles );
    namespace_5ceacc03::bedroom_drawer();
    drawer moveto( drawer.origin + fwd * 10, 1, 0.5, 0.5 );
    wait 1.5;
    var_4ad0d08d = getentarray( "ledger", "targetname" );
    arraysortclosest( var_4ad0d08d, level.player.origin );
    var_4ad0d08d[ 0 ] util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"hash_681addf148e5303" );
    var_4ad0d08d[ 0 ] waittill( #"trigger" );
    level notify( #"hash_6317f16a37432c3a" );
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 4
// Checksum 0xde0df105, Offset: 0x6c88
// Size: 0x44
function function_69c02b2b( *str_objective, *var_50cc0d4f, *var_aa1a6455, *player )
{
    level flag::set( "flag_see_kraus_shadow_failsafe" );
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 1
// Checksum 0x451cc18, Offset: 0x6cd8
// Size: 0x1ec
function function_2d6c81be( *str_objective )
{
    level thread function_fb12384e();
    exploder::exploder( "lgt_exp_target_building_01" );
    exploder::exploder( "lgt_exp_target_building_02" );
    level function_3141d875();
    level.var_3559e9e thread function_15c263da( "office_skip" );
    level.var_49a292bb thread function_b66c66e( "office_skip" );
    level thread namespace_11998b8f::function_91a7f501( "apt_street_ambient_harass_loop", "apartment_exit_done" );
    level.var_54b83d35 = struct::get( "tag_align_target_apt_first_floor", "targetname" );
    level.var_bd5c9b86 = struct::get( "tag_align_target_apt_second_floor", "targetname" );
    player = getplayers()[ 0 ];
    player setmovespeedscale( 0.5 );
    player val::set( "apartment", "allow_sprint", 0 );
    level thread namespace_11998b8f::function_25120710();
    level thread function_963791c5();
    level thread function_aa936112( 1 );
    level thread function_33e6dffe();
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 2
// Checksum 0x11c52376, Offset: 0x6ed0
// Size: 0x4dc
function function_34ee80b8( str_objective, var_50cc0d4f )
{
    if ( var_50cc0d4f )
    {
        level thread namespace_afd0968c::function_36a9bec7( var_50cc0d4f );
        level thread namespace_fba81a7f::function_3dfe810();
    }
    
    level flag::set( "start_plant_tracking_device_lighting" );
    level thread namespace_c80e7f5f::function_96de90a7();
    level thread namespace_c80e7f5f::function_4b72e85();
    level util::delay( 0.5, undefined, &darkroom_light_interact );
    level thread function_c8ac96b3();
    
    if ( var_50cc0d4f )
    {
        level thread function_af031d54();
    }
    
    scene::add_scene_func( "scene_z_stk_darkroom_knockout", &function_d92bcbb5, "init" );
    level thread scene::init( "scene_z_stk_darkroom_knockout" );
    level flag::wait_till( "flag_give_blacklight" );
    player = getplayers()[ 0 ];
    player thread namespace_11998b8f::function_e8e2095b();
    level thread function_1a702184();
    level flag::wait_till( "flag_briefcase_found" );
    player thread namespace_11998b8f::function_e58f7713();
    level flag::wait_till( "apartment_explosive_placed" );
    level thread function_66b3680f();
    level.var_dca3174b dialogue::queue( "vox_cp_stkt_11500_gret_help_aa" );
    s_interact = struct::get( "apt_darkroom_closet_interact", "targetname" );
    s_interact util::create_cursor_hint( undefined, ( 0, 0, 0 ), #"hash_24b92cc9c8f3144e" );
    s_interact waittill( #"trigger" );
    level thread scene::play( "scene_z_stk_darkroom_knockout", "start" );
    level waittill( #"start_fade" );
    level thread util::screen_fade_out( 2 );
    level.var_dca3174b flag::wait_till_clear( #"scriptedanim" );
    player = getplayers()[ 0 ];
    player val::set( "apartment_to_warehouse", "freezecontrols", 1 );
    level flag::set( "apartment_2_done" );
    objectives::remove( "obj_exit_apt" );
    player util::blend_movespeedscale( 1, 0.5 );
    player val::reset( "apartment", "allow_sprint" );
    level.var_375ea1c1 = spawner::simple_spawn_single( "warehouse_volkov" );
    wait 0.5;
    s_teleport = struct::get( "warehouse_intro_player_start", "targetname" );
    player setorigin( s_teleport.origin );
    player setplayerangles( s_teleport.angles );
    level.player val::set( "knock_out", "show_crosshair", 0 );
    wait 5;
    skipto::function_4e3ab877( str_objective );
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0xad671878, Offset: 0x73b8
// Size: 0x134
function function_1a702184()
{
    var_58cd8ee0 = struct::get( "darkroom_door_interact_button", "targetname" );
    var_897ff072 = struct::get( "darkroom_door_interact_picture", "targetname" );
    var_58cd8ee0 thread function_85fbc73e( "found_secret_button", "button_interact_pressed" );
    var_897ff072 thread function_85fbc73e( "found_secret_picture", "picture_interact_pressed" );
    level flag::wait_till_all( array( "button_interact_pressed", "picture_interact_pressed" ) );
    level flag::set( "darkroom_door_open" );
    wait 0.5;
    level.var_bb05e8f5 rotateyaw( -79, 2.5, 0.75, 0.75 );
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 2
// Checksum 0xd718402d, Offset: 0x74f8
// Size: 0x1e0
function function_85fbc73e( wait_notify, flagname )
{
    level waittill( wait_notify );
    timer = 6;
    var_617f3755 = getent( "secret_wall_panel", "targetname" );
    var_b227bb98 = getent( "secret_picture", "targetname" );
    
    while ( !level flag::get( "darkroom_door_open" ) )
    {
        self util::create_cursor_hint( undefined, undefined, #"hash_6c7bb285599937ba" );
        self waittill( #"trigger" );
        thread namespace_5ceacc03::function_4cab7b22( self, timer );
        
        if ( !level flag::get( "gear_sound" ) )
        {
            level flag::set( "gear_sound" );
            level thread function_7e5c2da( timer );
        }
        
        level flag::set( flagname );
        
        if ( flagname == "button_interact_pressed" )
        {
            var_617f3755 thread function_c9d1be0e( timer );
        }
        
        if ( flagname == "picture_interact_pressed" )
        {
            var_b227bb98 thread function_3ce22f0b( timer );
        }
        
        wait timer;
        level flag::clear( flagname );
    }
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 1
// Checksum 0xe7d7cd83, Offset: 0x76e0
// Size: 0xdc
function function_c9d1be0e( timer )
{
    var_ee7f9f95 = struct::get( "secret_wall_panel_pos_01", "targetname" );
    var_cfa661e3 = struct::get( "secret_wall_panel_pos_02", "targetname" );
    self moveto( var_cfa661e3.origin, 0.5, 0.1, 0.1 );
    wait 0.5;
    self moveto( var_ee7f9f95.origin, timer - 0.5, 0.1, 0.1 );
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 1
// Checksum 0x600e99e4, Offset: 0x77c8
// Size: 0xbc
function function_3ce22f0b( timer )
{
    self rotateroll( -12, 0.5, 0.1, 0.1 );
    wait 0.5;
    var_13ad4669 = ( timer - 0.5 ) / 6;
    
    for ( i = 0; i < 6 ; i++ )
    {
        wait var_13ad4669;
        self rotateroll( 2, 0.1, 0.05, 0.05 );
    }
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 1
// Checksum 0xed7f0259, Offset: 0x7890
// Size: 0x7c
function function_7e5c2da( timer )
{
    level endon( #"darkroom_door_open" );
    
    /#
        for ( i = 0; i < timer ; i++ )
        {
            iprintlnbold( "<dev string:xf4>" );
            wait 1;
        }
        
        level flag::clear( "<dev string:xfd>" );
    #/
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0xaf861696, Offset: 0x7918
// Size: 0xec
function darkroom_light_interact()
{
    level thread scene::init( "cin_stakeout_apt_darkroom_light" );
    
    if ( !isdefined( level.var_7a8f8e9 ) )
    {
        level.var_7a8f8e9 = getent( "darkroom_light", "targetname" );
        level.var_7a8f8e9.animname = "darkroom_light";
    }
    
    while ( !level flag::get( "flag_close_briefcase" ) )
    {
        level function_2fd06e9c( "on" );
        level function_2fd06e9c( "off" );
    }
    
    level.var_2bf3ee79 util::remove_cursor_hint();
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0x5b574c6f, Offset: 0x7a10
// Size: 0x54
function function_66b3680f()
{
    level waittill( #"hash_20f0c5a3e813044" );
    
    if ( !level flag::get( "flag_darkroom_light_on" ) )
    {
        level thread function_186a0635();
    }
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 1
// Checksum 0xb1440a12, Offset: 0x7a70
// Size: 0x304
function function_2fd06e9c( state )
{
    level endon( #"flag_close_briefcase" );
    
    if ( level flag::get( "flag_close_briefcase" ) )
    {
        return;
    }
    
    level.var_2bf3ee79 = struct::get( "darkroom_light_interact", "targetname" );
    level.var_2bf3ee79 util::create_cursor_hint( undefined, undefined, #"hash_4c7c3b0a076e33d2", 96 );
    s_waitresult = level.var_2bf3ee79 waittill( #"trigger", #"hash_7f21624bd71e55db" );
    player = getplayers()[ 0 ];
    var_51a34a03 = player.origin - level.var_2bf3ee79.origin;
    var_51a34a03 = ( var_51a34a03[ 0 ], var_51a34a03[ 1 ], 0 );
    var_51a34a03 = vectornormalize( var_51a34a03 );
    forward = anglestoforward( level.var_2bf3ee79.angles );
    dot_fwd = vectordot( var_51a34a03, forward );
    right = anglestoright( level.var_2bf3ee79.angles );
    dot_right = vectordot( var_51a34a03, right );
    direction = undefined;
    
    if ( dot_fwd >= 0.7 )
    {
        direction = "fr";
    }
    else if ( dot_fwd <= -0.7 )
    {
        direction = "ba";
    }
    else if ( dot_right <= -0.7 )
    {
        direction = "rt";
    }
    else
    {
        direction = "lf";
    }
    
    if ( s_waitresult._notify === "trigger" )
    {
        level thread scene::play( "cin_stakeout_apt_darkroom_light", "apt_darkroom_light_" + direction );
        player waittill( #"hash_5626dd1a7ff2dfaf" );
    }
    
    if ( state == "on" )
    {
        level thread function_186a0635();
    }
    else
    {
        level thread function_8fd5f0ca();
    }
    
    wait 0.1;
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0xccba5d4c, Offset: 0x7d80
// Size: 0x6c
function function_186a0635()
{
    if ( level flag::get( "flag_darkroom_light_on" ) )
    {
        return;
    }
    
    level.var_7a8f8e9 clientfield::set( "darkroom_light", 1 );
    level flag::set( "flag_darkroom_light_on" );
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0x627ff218, Offset: 0x7df8
// Size: 0x6c
function function_8fd5f0ca()
{
    if ( !level flag::get( "flag_darkroom_light_on" ) )
    {
        return;
    }
    
    level.var_7a8f8e9 clientfield::set( "darkroom_light", 0 );
    level flag::clear( "flag_darkroom_light_on" );
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 1
// Checksum 0x39c41fbc, Offset: 0x7e70
// Size: 0x28
function function_d92bcbb5( a_ents )
{
    level.var_dca3174b = a_ents[ #"greta" ];
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 1
// Checksum 0x7e715c03, Offset: 0x7ea0
// Size: 0xc
function function_c0a03fad( *a_ents )
{
    
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0x5b81d8f8, Offset: 0x7eb8
// Size: 0x334
function function_c8ac96b3()
{
    level.tracking_briefcase = getent( "tracking_briefcase", "targetname" );
    level.tracking_briefcase.animname = "tracking_briefcase";
    scene::add_scene_func( "scene_z_stk_apt_plant_tracker", &function_c0a03fad, "init" );
    level scene::init( "scene_z_stk_apt_plant_tracker" );
    var_cbe1de3 = level.tracking_briefcase util::get_linked_structs()[ 0 ];
    
    if ( isdefined( var_cbe1de3 ) )
    {
        var_cbe1de3 util::create_cursor_hint( undefined, undefined, #"hash_24b92cc9c8f3144e", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1 );
        var_cbe1de3 waittill( #"trigger" );
        player = getplayers()[ 0 ];
        level thread music::setmusicstate( "null" );
        level.var_bb05e8f5 rotateyaw( 79, 0.25 );
        level scene::play( "scene_z_stk_apt_plant_tracker", "start" );
        level thread scene::play( "scene_z_stk_apt_plant_tracker", "loop" );
        var_6e695d6d = #"hash_1be67a050a98eb";
        var_314be333 = #"hash_1be77a050a9a9e";
        var_87b83dca = dialog_tree::new_tree( undefined, undefined, 1, 1 );
        var_dfc957f2 = var_87b83dca dialog_tree::add_option( var_6e695d6d, undefined, undefined, undefined, 1, "flag_close_briefcase" );
        var_ed08f271 = var_87b83dca dialog_tree::add_option( var_314be333, undefined, undefined, undefined, 1, "flag_close_briefcase" );
        var_87b83dca dialog_tree::run( undefined, undefined, 7 );
        level flag::wait_till( "flag_close_briefcase" );
        level thread function_31240146();
        level scene::play( "scene_z_stk_apt_plant_tracker", "end" );
        wait 0.5;
        level flag::set( "apartment_explosive_placed" );
    }
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0xb1edc0ff, Offset: 0x81f8
// Size: 0x3c
function function_31240146()
{
    level waittill( #"hash_4cff21653b9d5547" );
    level.var_dca3174b dialogue::queue( "vox_cp_stkt_11500_gret_help_aa_2" );
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 0
// Checksum 0xb7184fa9, Offset: 0x8240
// Size: 0x54
function function_6b7988be()
{
    if ( isdefined( level.tracking_briefcase ) )
    {
        level.tracking_briefcase delete();
    }
    
    if ( isdefined( level.var_752c558a ) )
    {
        level.var_752c558a delete();
    }
}

// Namespace namespace_e6b6aea1/namespace_e6b6aea1
// Params 4
// Checksum 0xaafce289, Offset: 0x82a0
// Size: 0x5c
function function_a3c49bc0( *str_objective, *var_50cc0d4f, *var_aa1a6455, *player )
{
    level thread function_6b7988be();
    level flag::set( "apartment_2_done" );
}

