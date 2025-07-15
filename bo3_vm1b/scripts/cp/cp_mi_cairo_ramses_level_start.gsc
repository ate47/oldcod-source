#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_ramses_fx;
#using scripts/cp/cp_mi_cairo_ramses_sound;
#using scripts/cp/cp_mi_cairo_ramses_station_walk;
#using scripts/cp/cp_mi_cairo_ramses_utility;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/compass;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;

#namespace level_start;

// Namespace level_start
// Params 0
// Checksum 0xbf396abe, Offset: 0x640
// Size: 0x8a
function main()
{
    clientfield::set( "hide_station_miscmodels", 1 );
    clientfield::set( "turn_on_rotating_fxanim_fans", 1 );
    clientfield::set( "start_fog_banks", 1 );
    exploder::exploder( "fx_exploder_sparks_off" );
    level ramses_station_intro_igc();
    level skipto::objective_completed( "level_start" );
}

// Namespace level_start
// Params 1
// Checksum 0xdbd34e28, Offset: 0x6d8
// Size: 0x5a
function init_heroes( str_objective )
{
    level.ai_hendricks = util::get_hero( "hendricks" );
    level.ai_rachel = util::get_hero( "rachel" );
    skipto::teleport_ai( str_objective );
}

// Namespace level_start
// Params 0
// Checksum 0xd6bfe568, Offset: 0x740
// Size: 0x2a
function setup_players_for_station_walk()
{
    self endon( #"death" );
    self util::set_low_ready( 1 );
    self thread tether_player_to_hendricks();
}

// Namespace level_start
// Params 0
// Checksum 0xcecda187, Offset: 0x778
// Size: 0x1a2
function tether_player_to_hendricks()
{
    self endon( #"disconnect" );
    self endon( #"death" );
    var_d30b00d2 = getent( "trig_subway_area_mid", "targetname" );
    
    while ( !isdefined( level.ai_hendricks ) || !isdefined( level.ai_rachel ) )
    {
        wait 0.15;
    }
    
    var_28be2d2a = array( level.ai_hendricks );
    self thread ramses_util::player_walk_speed_adjustment( var_28be2d2a, "kill_player_walkspeed_adjustment", -128, 256, 0.3, 0.8 );
    
    do
    {
        wait 0.25;
    }
    while ( !level.ai_hendricks istouching( var_d30b00d2 ) && !self istouching( var_d30b00d2 ) );
    
    self notify( #"kill_player_walkspeed_adjustment", 0 );
    self thread ramses_util::player_walk_speed_adjustment( var_28be2d2a, "kill_player_walkspeed_adjustment", -64, 512, 0.2, 0.6 );
    
    do
    {
        wait 0.25;
    }
    while ( !isdefined( level.ai_khalil ) || !level flag::get( "station_walk_past_stairs" ) );
    
    self notify( #"kill_player_walkspeed_adjustment", 0 );
    var_28be2d2a = array( level.ai_khalil, level.ai_hendricks, level.ai_rachel );
    self thread ramses_util::player_walk_speed_adjustment( var_28be2d2a, "kill_player_walkspeed_adjustment", -64, 512, 0.3, 0.8 );
}

// Namespace level_start
// Params 0
// Checksum 0xb52b43f5, Offset: 0x928
// Size: 0x33
function setup_players_for_station_fight()
{
    self endon( #"death" );
    self setmovespeedscale( 1 );
    self util::set_low_ready( 0 );
    self notify( #"kill_player_walkspeed_adjustment" );
}

// Namespace level_start
// Params 0
// Checksum 0x95bd9cc4, Offset: 0x968
// Size: 0x242
function ramses_station_intro_igc()
{
    level scene::init( "cin_ram_01_01_enterstation_1st_ride" );
    set_up_train();
    scene::add_scene_func( "cin_ram_01_01_enterstation_1st_ride", &station_intro_scene_init, "play" );
    scene::add_scene_func( "cin_ram_01_01_enterstation_1st_ride", &enterstation_1st_ride_done_func, "play" );
    scene::add_scene_func( "cin_ram_01_01_enterstation_1st_ride", &ramses_util::function_3bc57aa8, "done" );
    ramses_util::co_op_teleport_on_igc_end( "cin_ram_01_01_enterstation_1st_ride", "enterstation_1st_ride_teleport" );
    load::function_a2995f22();
    util::do_chyron_text( &"CP_MI_CAIRO_RAMSES_INTRO_LINE_1_FULL", "", &"CP_MI_CAIRO_RAMSES_INTRO_LINE_2_FULL", &"CP_MI_CAIRO_RAMSES_INTRO_LINE_2_SHORT", &"CP_MI_CAIRO_RAMSES_INTRO_LINE_3_FULL", &"CP_MI_CAIRO_RAMSES_INTRO_LINE_3_SHORT", &"CP_MI_CAIRO_RAMSES_INTRO_LINE_4_FULL", &"CP_MI_CAIRO_RAMSES_INTRO_LINE_4_FULL" );
    scene::add_scene_func( "cin_ram_01_01_enterstation_vign_loading", &function_ba280036, "play" );
    level thread util::delay( 2, undefined, &scene::play, "cin_ram_01_01_enterstation_vign_loading" );
    
    if ( isdefined( level.bzm_ramsesdialogue1callback ) )
    {
        level thread [[ level.bzm_ramsesdialogue1callback ]]();
    }
    
    foreach ( player in level.players )
    {
        player thread enterstation_1st_ride_arrival_rumble();
        player thread enterstation_1st_ride_stop_rumble();
    }
    
    level thread ramses_sound::function_4f8bda39();
    level scene::play( "cin_ram_01_01_enterstation_1st_ride" );
}

// Namespace level_start
// Params 0
// Checksum 0x12112e17, Offset: 0xbb8
// Size: 0x2a
function function_1f8e97be()
{
    level util::screen_fade_out( 0 );
    wait 1;
    level thread util::screen_fade_in( 1 );
}

// Namespace level_start
// Params 0
// Checksum 0xbd7458e2, Offset: 0xbf0
// Size: 0x72
function set_up_train()
{
    mdl_train_car_main = getent( "traincar_primary", "targetname" );
    mdl_train_car_main.script_objective = "interview_dr_nasser";
    mdl_train_car_main link_ents( "lgt_subway_car", "script_noteworthy" );
    mdl_train_car_main link_ents( "traincar_primary_cab" );
}

// Namespace level_start
// Params 1
// Checksum 0xb4d2896b, Offset: 0xc70
// Size: 0x33
function station_intro_scene_init( a_ents )
{
    mdl_train_car_main = a_ents[ "traincar_primary" ];
    mdl_train_car_main waittill( #"stopped" );
    level notify( #"train_done" );
}

// Namespace level_start
// Params 1
// Checksum 0x878506f2, Offset: 0xcb0
// Size: 0x4a
function enterstation_1st_ride_done_func( a_ents )
{
    level waittill( #"cin_ram_01_01_enterstation_1st_ride_done" );
    level.ai_hendricks setdedicatedshadow( 0 );
    streamerrequest( "clear", "cin_ram_01_01_enterstation_1st_ride" );
}

// Namespace level_start
// Params 1
// Checksum 0xd2049064, Offset: 0xd08
// Size: 0x22
function attach_extracam_to_traincar( e_train )
{
    e_train clientfield::set( "attach_cam_to_train", 1 );
}

// Namespace level_start
// Params 0
// Checksum 0x561f08d2, Offset: 0xd38
// Size: 0x3d
function enterstation_1st_ride_arrival_rumble()
{
    self endon( #"disconnect" );
    level endon( #"cp_cairo_ramses_subway_rumble_loop_stop" );
    
    while ( true )
    {
        self playrumbleonentity( "tank_rumble" );
        wait 1;
    }
}

// Namespace level_start
// Params 0
// Checksum 0xa55e71ee, Offset: 0xd80
// Size: 0x2a
function enterstation_1st_ride_stop_rumble()
{
    self endon( #"disconnect" );
    level waittill( #"cp_cairo_ramses_subway_stop_rumble" );
    self playrumbleonentity( "tank_fire" );
}

// Namespace level_start
// Params 1
// Checksum 0x2662d7fb, Offset: 0xdb8
// Size: 0xbb
function function_ba280036( a_ents )
{
    level waittill( #"hash_c466417" );
    var_9224b839 = getentarray( "elevator_door", "targetname" );
    
    foreach ( e_piece in var_9224b839 )
    {
        e_piece movez( -108, 1.5 );
        e_piece playsound( "evt_postint_door_open" );
    }
}

// Namespace level_start
// Params 0
// Checksum 0xe02d8e09, Offset: 0xe80
// Size: 0x6b
function turn_on_reflection_extracam()
{
    foreach ( e_player in level.players )
    {
        e_player clientfield::set_to_player( "intro_reflection_extracam", 1 );
    }
}

// Namespace level_start
// Params 0
// Checksum 0x117e40f9, Offset: 0xef8
// Size: 0x6b
function turn_off_reflection_extracam()
{
    foreach ( e_player in level.players )
    {
        e_player clientfield::set_to_player( "intro_reflection_extracam", 0 );
    }
}

// Namespace level_start
// Params 2
// Checksum 0xe3712a80, Offset: 0xf70
// Size: 0xb3
function link_ents( str_name, str_key )
{
    if ( !isdefined( str_key ) )
    {
        str_key = "targetname";
    }
    
    a_e_ents = getentarray( str_name, str_key );
    
    foreach ( e_ent in a_e_ents )
    {
        e_ent linkto( self );
        e_ent.script_objective = "interview_dr_nasser";
    }
}

// Namespace level_start
// Params 0
// Checksum 0x2a7109ea, Offset: 0x1030
// Size: 0xab
function link_players()
{
    foreach ( e_player in level.players )
    {
        e_player setorigin( self.mdl_temp_link.origin );
        e_player setplayerangles( self.angles );
        e_player playerlinkto( self.mdl_temp_link, undefined, 0, 0, 0, 0, 0 );
    }
}

