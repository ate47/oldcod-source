#using script_13114d8a31c6152a;
#using script_1b9f100b85b7e21d;
#using script_290b454abd681dd4;
#using script_2d443451ce681a;
#using script_37f9ff47f340fbe8;
#using script_3dc93ca9902a9cda;
#using script_7409560e3a0c9884;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\easing;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\manager;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicleriders_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;

#namespace namespace_4e717b5b;

// Namespace namespace_4e717b5b/namespace_4e717b5b
// Params 1
// Checksum 0xd9bb52d0, Offset: 0x970
// Size: 0xc
function function_ae18fec1( *var_d3440450 )
{
    
}

// Namespace namespace_4e717b5b/namespace_4e717b5b
// Params 2
// Checksum 0xa02924f2, Offset: 0x988
// Size: 0x234
function intro_main( *var_d3440450, *var_50cc0d4f )
{
    level thread globallogic_ui::function_7bc0e4b9( 0 );
    level thread function_58f45d60();
    callback::on_spawned( &init );
    level thread namespace_ba979a10::setup_allies();
    level thread function_38610863();
    level thread function_43554611();
    level thread function_1b25bb39();
    level thread function_6423e5e1();
    level thread function_a174d491();
    level thread function_2fb462dd();
    level thread function_536a482b();
    level thread function_78b6b123();
    level thread function_71b65ddf();
    level thread namespace_c1cfab6c::function_f5421481();
    level thread function_8e7c787a();
    exploder::exploder( "radio_tower_lights" );
    level.player setlowready( 1 );
    level flag::wait_till( "missile_strike_landed" );
    level.player setlowready( 0 );
    level flag::wait_till( "tundra_intro_done" );
    skipto::function_4e3ab877( "tundra_intro" );
}

// Namespace namespace_4e717b5b/namespace_4e717b5b
// Params 0
// Checksum 0x80f724d1, Offset: 0xbc8
// Size: 0x4
function init_flags()
{
    
}

// Namespace namespace_4e717b5b/namespace_4e717b5b
// Params 0
// Checksum 0x80f724d1, Offset: 0xbd8
// Size: 0x4
function init()
{
    
}

// Namespace namespace_4e717b5b/namespace_4e717b5b
// Params 4
// Checksum 0xe5d42452, Offset: 0xbe8
// Size: 0x24
function cleanup( *name, *starting, *direct, *player )
{
    
}

// Namespace namespace_4e717b5b/namespace_4e717b5b
// Params 0
// Checksum 0x24293dea, Offset: 0xc18
// Size: 0x20c
function function_38610863()
{
    level flag::wait_till( "level_is_go" );
    wait 4;
    iprintlnbold( "Mason: Alright. We\x92re in position." );
    wait 6;
    iprintlnbold( "Command: Roger that. There's an airmail package ready for delivery." );
    iprintlnbold( "Command:Just need an address." );
    wait 6;
    iprintlnbold( "Command: Go ahead and mark the radio tower for us." );
    wait 5;
    iprintlnbold( "Woods: Mason, the tower's up above on that far ridge." );
    level flag::set( "tundra_intro_obj_tower" );
    level flag::set( "give_player_binoculars" );
    level flag::wait_till( "launch_binoc_attack" );
    iprintlnbold( "Mason: Coordinates coming your way." );
    wait 3;
    iprintlnbold( "Command: Roger. The check is in the mail." );
    level flag::wait_till( "missile_strike_landed" );
    iprintlnbold( "Mason: That'll wake them up." );
    wait 5;
    iprintlnbold( "Overwatch: Now get down there and eliminate Rudnik before he escapes." );
    level flag::set( "tundra_intro_obj_update" );
    wait 5;
    iprintlnbold( "Woods: We don't have a lot of time to mess this guy up." );
    level flag::set( "tundra_intro_vo_done" );
}

// Namespace namespace_4e717b5b/namespace_4e717b5b
// Params 0
// Checksum 0x80f724d1, Offset: 0xe30
// Size: 0x4
function function_acbf5fe3()
{
    
}

// Namespace namespace_4e717b5b/namespace_4e717b5b
// Params 0
// Checksum 0x8cd8fc3d, Offset: 0xe40
// Size: 0xf4
function function_43554611()
{
    level endon( #"launch_binoc_attack" );
    level flag::wait_till( "tundra_intro_obj_tower" );
    nags = [];
    nags[ nags.size ] = "Woods: Use those binoculars, Mason.";
    nags[ nags.size ] = "Woods: Mason, mark that radio tower on the ridge.";
    nags[ nags.size ] = "Woods: Come on, Mason. Mark the fucking tower.";
    wait 15;
    i = 0;
    
    while ( !level flag::get( "launch_binoc_attack" ) )
    {
        iprintlnbold( "" + nags[ i ] );
        i++;
        
        if ( i + 1 > nags.size )
        {
            i = 0;
        }
        
        wait 15;
    }
}

// Namespace namespace_4e717b5b/namespace_4e717b5b
// Params 0
// Checksum 0x14aae979, Offset: 0xf40
// Size: 0x134
function function_1b25bb39()
{
    level endon( #"player_is_rappelling" );
    level endon( #"flag_player_jumped" );
    level flag::wait_till( "tundra_intro_obj_update" );
    nags = [];
    nags[ nags.size ] = "Woods: Let's take our lines down.";
    nags[ nags.size ] = "Woods: Attach your line, bro!";
    nags[ nags.size ] = "Woods: We're going down this wall, Mason! Let's do it!";
    wait 15;
    i = 0;
    
    while ( !level flag::get( "player_is_rappelling" ) || !level flag::get( "flag_player_jumped" ) )
    {
        iprintlnbold( "" + nags[ i ] );
        i++;
        
        if ( i + 1 > nags.size )
        {
            i = 0;
        }
        
        wait 15;
    }
}

// Namespace namespace_4e717b5b/namespace_4e717b5b
// Params 0
// Checksum 0x3de4837c, Offset: 0x1080
// Size: 0x17c
function function_2fb462dd()
{
    level flag::wait_till( "level_is_go" );
    level flag::wait_till( "tundra_intro_obj_tower" );
    var_fda2e7e6 = getent( "tundra_intro_tower", "targetname" );
    objectives::function_4eb5c04a( "missile_obj", var_fda2e7e6.origin + ( 0, 0, 6300 ), undefined, 1, 1 );
    level flag::wait_till( "missile_strike_landed" );
    objectives::complete( "missile_obj" );
    level flag::wait_till( "tundra_intro_obj_update" );
    objectives::scripted( "search_and_kill_obj", undefined, #"hash_22cbba913d7929f1" );
    level flag::wait_till( "tundra_intro_vo_done" );
    level thread namespace_ba979a10::function_cb6a2e9b();
    level thread namespace_ba979a10::function_ee211e0d();
}

// Namespace namespace_4e717b5b/namespace_4e717b5b
// Params 0
// Checksum 0x4f40479, Offset: 0x1208
// Size: 0x124
function function_8e7c787a()
{
    level flag::wait_till( "level_is_go" );
    wait 0.5;
    level.woods val::set( "intro", "ignoreall", 1 );
    wait 2;
    level.woods thread animation::enable_headlook_notorso( 1 );
    level.woods lookatentity( level.pilot );
    level.woods ai::set_behavior_attribute( "demeanor", "cqb" );
    level flag::wait_till( "flag_heli_end_path" );
    level.woods thread animation::enable_headlook_notorso( 0 );
    level.woods lookatentity();
}

// Namespace namespace_4e717b5b/namespace_4e717b5b
// Params 0
// Checksum 0x1628e627, Offset: 0x1338
// Size: 0x86
function function_78b6b123()
{
    level flag::wait_till( "flag_spawn_ambient_trucks" );
    var_86827bb9 = spawner::simple_spawn( "tundra_intro_patrol_enemies", &function_d158ddb4 );
    var_ff6f8c02 = spawner::simple_spawn( "tundra_intro_walk_enemies", &function_a9d32145 );
}

// Namespace namespace_4e717b5b/namespace_4e717b5b
// Params 0
// Checksum 0x44f6aac6, Offset: 0x13c8
// Size: 0x1a4
function function_71b65ddf()
{
    wait 1.5;
    var_b4a49886 = vehicle::simple_spawn_and_drive( "intro_heli_flyby" );
    
    foreach ( heli in var_b4a49886 )
    {
        heli vehicle::toggle_tread_fx( 1 );
        heli vehicle::toggle_exhaust_fx( 1 );
        heli setrotorspeed( 1 );
    }
    
    waitframe( 1 );
    level.pilot = getent( "lookat_pilot", "targetname", 1 );
    var_8b658b90 = vehicle::simple_spawn_single( "tundra_ambient_veh_1" );
    level flag::wait_till( "flag_spawn_ambient_trucks" );
    var_420fd09 = vehicle::simple_spawn_single_and_drive( "tundra_ambient_veh_2" );
    wait 1;
    var_8b658b90 thread vehicle::go_path();
}

// Namespace namespace_4e717b5b/namespace_4e717b5b
// Params 0
// Checksum 0x1f89c877, Offset: 0x1578
// Size: 0xdc
function function_977dbf55()
{
    level.ai_lookat = spawner::simple_spawn_single( "lookat_flyby_ent" );
    var_fb168203 = getent( "lookat_flyby_heli", "script_noteworthy", 1 );
    level.ai_lookat linkto( var_fb168203, "tag_origin" );
    level.ai_lookat hide();
    level flag::wait_till( "flag_heli_end_path" );
    
    if ( isdefined( level.ai_lookat ) )
    {
        level.ai_lookat deletedelay();
    }
}

// Namespace namespace_4e717b5b/namespace_4e717b5b
// Params 0
// Checksum 0x3551f22e, Offset: 0x1660
// Size: 0x194
function function_d158ddb4()
{
    self endon( #"death" );
    self.health = 1;
    self ai::set_behavior_attribute( "demeanor", "patrol" );
    self thread animation::enable_headlook_notorso( 1 );
    level flag::wait_till( "missile_strike_landed" );
    self ai::set_behavior_attribute( "demeanor", "combat" );
    self lookatpos( level.var_8ef0b331 );
    self.maxsightdistsqrd = 4000000;
    wait 2;
    
    if ( isdefined( self ) && self.script_noteworthy == "radar_reaction_enemy" )
    {
        goalvolume = getent( "radar_vol1", "targetname" );
        self setgoal( goalvolume );
        return;
    }
    
    if ( isdefined( self ) && self.script_noteworthy == "motorpool_reaction_enemy" )
    {
        goalvolume = getent( "motorpool_vol1", "targetname" );
        self setgoal( goalvolume );
    }
}

// Namespace namespace_4e717b5b/namespace_4e717b5b
// Params 0
// Checksum 0x69a916f2, Offset: 0x1800
// Size: 0x174
function function_a9d32145()
{
    self endon( #"death" );
    self.health = 1;
    self ai::set_behavior_attribute( "demeanor", "patrol" );
    self thread function_f4b577e3();
    level flag::wait_till( "missile_strike_landed" );
    wait 2;
    
    if ( isdefined( self ) && isalive( self ) )
    {
        self ai::set_behavior_attribute( "demeanor", "combat" );
        
        if ( self.script_noteworthy == "intro_walk_radar_enemy" )
        {
            goalvolume = getent( "radar_vol1", "targetname" );
            self setgoal( goalvolume );
            return;
        }
        
        if ( self.script_noteworthy == "intro_walk_motorpool_enemy" )
        {
            goalvolume = getent( "motorpool_vol2", "targetname" );
            self setgoal( goalvolume );
        }
    }
}

// Namespace namespace_4e717b5b/namespace_4e717b5b
// Params 0
// Checksum 0xf3bef84f, Offset: 0x1980
// Size: 0x8c
function function_f4b577e3()
{
    level endon( #"missile_strike_landed" );
    self flag::wait_till( "amb_guy_end_reached" );
    
    if ( isdefined( self ) && isalive( self ) && !flag::get( "missile_strike_landed" ) )
    {
        self deletedelay();
    }
}

// Namespace namespace_4e717b5b/namespace_4e717b5b
// Params 0
// Checksum 0x527f1542, Offset: 0x1a18
// Size: 0x16c
function function_6423e5e1()
{
    level flag::wait_till( "launch_binoc_attack" );
    var_fda2e7e6 = getent( "tundra_intro_tower", "targetname" );
    e_missile = getent( "tundra_intro_missile", "targetname" );
    e_missile thread function_766b93f();
    level thread function_5453503d();
    level flag::wait_till( "missile_strike_landed" );
    level thread namespace_c1cfab6c::function_e8c1c3a9();
    exploder::exploder( "fx_exp_vista_tower" );
    wait 0.5;
    exploder::exploder( "temp_smoke" );
    var_fda2e7e6 delete();
    exploder::kill_exploder( "radio_tower_lights" );
    wait 2;
    level.music = snd::function_9ae4fc6f( "mus_tmp_kgb_combat_3b_lp" );
}

// Namespace namespace_4e717b5b/namespace_4e717b5b
// Params 0
// Checksum 0xa4c94e22, Offset: 0x1b90
// Size: 0x2c
function function_5453503d()
{
    level.var_8ef0b331 = getent( "turndra_radio_tower_lookat", "targetname" );
}

// Namespace namespace_4e717b5b/namespace_4e717b5b
// Params 0
// Checksum 0xb2c4019b, Offset: 0x1bc8
// Size: 0xbc
function function_a174d491()
{
    level.player thread function_1dc9305a();
    level flag::wait_till_any( array( "player_is_rappelling", "flag_player_jumped" ) );
    var_815137db = struct::get( "sm_tundra_ally_rappel_01", "targetname" );
    var_815137db thread scene::play( "scene_pri_caves_rappel", level.woods );
    level flag::set( "tundra_intro_done" );
}

// Namespace namespace_4e717b5b/namespace_4e717b5b
// Params 0
// Checksum 0xcce8a6c4, Offset: 0x1c90
// Size: 0x1dc
function function_1dc9305a()
{
    level.player setstance( "crouch" );
    level flag::wait_till( "missile_strike_landed" );
    var_cb14744d = getent( "intro_player_rappel", "targetname" );
    var_cb14744d util::create_cursor_hint( "tag_origin", ( 0, 0, 10 ), #"hash_6c7bb285599937ba", 350, undefined, undefined, undefined, undefined, undefined, 0, 0 );
    var_cb14744d waittill( #"trigger" );
    level flag::set( "player_is_rappelling" );
    player_tag = util::spawn_model( "tag_origin", self.origin, self.angles );
    player_tag dontinterpolate();
    level.player playerlinktodelta( player_tag, "tag_origin", 1, 45, 45, 10, 45 );
    player_tag movex( -180, 1.5 );
    wait 1.5;
    player_tag movez( -630, 4 );
    wait 4;
    level.player unlink();
}

// Namespace namespace_4e717b5b/namespace_4e717b5b
// Params 0
// Checksum 0x497a7925, Offset: 0x1e78
// Size: 0x104
function function_766b93f()
{
    var_fda2e7e6 = getent( "tundra_intro_tower", "targetname" );
    missile_tag = util::spawn_model( "tag_origin", self.origin, self.angles );
    playfxontag( "maps/cp_side_tundra/fx9_missile_trail", self, "tag_origin" );
    self linkto( missile_tag );
    missile_tag moveto( var_fda2e7e6.origin, 3 );
    wait 3;
    self delete();
    missile_tag delete();
    level flag::set( "missile_strike_landed" );
}

// Namespace namespace_4e717b5b/namespace_4e717b5b
// Params 0
// Checksum 0x875f31e8, Offset: 0x1f88
// Size: 0x84
function function_536a482b()
{
    level flag::wait_till( "missile_strike_landed" );
    wait 4;
    var_8b658b90 = vehicle::simple_spawn_and_drive( "tundra_enemy_veh_1" );
    var_420fd09 = vehicle::simple_spawn_single_and_drive( "tundra_enemy_veh_2" );
    var_420fd09 thread function_e22580b2();
}

// Namespace namespace_4e717b5b/namespace_4e717b5b
// Params 0
// Checksum 0x30188a48, Offset: 0x2018
// Size: 0x120
function function_e22580b2()
{
    self endon( #"death" );
    self waittill( #"damage" );
    self setspeed( 0 );
    wait 1;
    self vehicle::unload();
    riders = getentarray( "intro_riders", "targetname", 1 );
    
    foreach ( rider in riders )
    {
        rider setgoal( level.player, 1 );
    }
}

// Namespace namespace_4e717b5b/namespace_4e717b5b
// Params 0
// Checksum 0xb6aecbfe, Offset: 0x2140
// Size: 0x144
function function_58f45d60()
{
    level flag::wait_till( "give_player_binoculars" );
    player = getplayers()[ 0 ];
    player giveweapon( level.var_42db149f );
    player switchtoweaponimmediate( level.var_42db149f );
    player disableweaponcycling();
    level flag::wait_till_clear( #"chyron_active" );
    level thread function_d280457b();
    level thread function_975f72af();
    level flag::wait_till( "launch_binoc_attack" );
    player enableweaponcycling();
    player takeweapon( level.var_42db149f );
}

// Namespace namespace_4e717b5b/namespace_4e717b5b
// Params 0
// Checksum 0xc910f816, Offset: 0x2290
// Size: 0xfc
function function_d280457b()
{
    level flag::set( "binoc_prompt_watch_on" );
    player = getplayers()[ 0 ];
    
    while ( level flag::get( "binoc_prompt_watch_on" ) )
    {
        level flag::wait_till( "binoc_attack_prompt_active" );
        player thread util::show_hint_text( #"hash_68f35624af19e182", 0, "stop_binoc_attack_prompt", 25 );
        level.var_4a9e9737 = gettime() + 500;
        level flag::wait_till_clear( "binoc_attack_prompt_active" );
        player notify( #"stop_binoc_attack_prompt" );
    }
}

// Namespace namespace_4e717b5b/namespace_4e717b5b
// Params 0
// Checksum 0xfe4935a9, Offset: 0x2398
// Size: 0x2c4
function function_975f72af()
{
    aim_ent = struct::get( "tundra_intro_binoc_loc", "targetname" );
    player = getplayers()[ 0 ];
    level.height_add = ( 0, 0, 2000 );
    level.var_4a9e9737 = 0;
    
    while ( isdefined( aim_ent ) )
    {
        ads = player adsbuttonpressed();
        var_3333dbfa = aim_ent.origin + level.height_add;
        
        if ( ads )
        {
            var_70250b99 = vectornormalize( var_3333dbfa - player getplayercamerapos() );
            var_26ea01fb = anglestoforward( player getplayerangles() );
            var_153ecee9 = vectordot( vectornormalize( ( var_70250b99[ 0 ], var_70250b99[ 1 ], 0 ) ), vectornormalize( ( var_26ea01fb[ 0 ], var_26ea01fb[ 1 ], 0 ) ) );
            dot = vectordot( var_70250b99, var_26ea01fb );
            
            if ( level.var_4a9e9737 > gettime() || var_153ecee9 >= 0.9994 && dot >= 0.997 )
            {
                level flag::set( "binoc_attack_prompt_active" );
                
                if ( player attackbuttonpressed() )
                {
                    break;
                }
            }
            else
            {
                level flag::clear( "binoc_attack_prompt_active" );
            }
        }
        else
        {
            level flag::clear( "binoc_attack_prompt_active" );
        }
        
        waitframe( 1 );
    }
    
    level flag::clear( "binoc_prompt_watch_on" );
    level flag::clear( "binoc_attack_prompt_active" );
    level flag::set( "launch_binoc_attack" );
}

