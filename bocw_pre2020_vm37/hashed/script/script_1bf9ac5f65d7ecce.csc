#using script_1cd690a97dfca36e;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_draw;
#using scripts\cp_common\snd_utility;

#namespace namespace_4ed3ce47;

// Namespace namespace_4ed3ce47/level_preinit
// Params 1, eflags: 0x40
// Checksum 0xce59c637, Offset: 0x2d8
// Size: 0x8c
function event_handler[level_preinit] function_b489bb7b( *eventstruct )
{
    snd::function_d4ec748e( &function_f2a2832d );
    snd::function_ce78b33b( &function_32ab045 );
    snd::trigger_init( &_trigger );
    snd::function_5e69f468( &_objective );
}

// Namespace namespace_4ed3ce47/event_cc819519
// Params 1, eflags: 0x40
// Checksum 0x94e87b8b, Offset: 0x370
// Size: 0x80
function event_handler[event_cc819519] function_686b88aa( *eventstruct )
{
    level.var_936dc3f3 = 0;
    snd::wait_init();
    snd::waitforplayers();
    function_5ea2c6e3( "cp_ger_hub_plrfly_down", 0, 1 );
    level.player = snd::getplayerssafe()[ 0 ];
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 2, eflags: 0x4
// Checksum 0xb9c16875, Offset: 0x3f8
// Size: 0x27a
function private function_32ab045( ent, name )
{
    switch ( name )
    {
        case #"adler":
            level.adler = ent;
            level.adler waittill( #"death" );
            level.adler = undefined;
            break;
        case #"lazar":
            level.lazar = ent;
            level.lazar waittill( #"death" );
            level.lazar = undefined;
            break;
        case #"park":
            level.park = ent;
            level.park waittill( #"death" );
            level.park = undefined;
            break;
        case #"sims":
            level.sims = ent;
            level.sims waittill( #"death" );
            level.sims = undefined;
            break;
        case #"hudson":
            level.hudson = ent;
            level.hudson waittill( #"death" );
            level.hudson = undefined;
            break;
        case #"woods":
            level.woods = ent;
            level.woods waittill( #"death" );
            level.woods = undefined;
            break;
        case #"mason":
            level.mason = ent;
            level.mason waittill( #"death" );
            level.mason = undefined;
            break;
        default:
            /#
                snd::function_81fac19d( snd::function_d78e3644(), "<dev string:x38>" + snd::function_783b69( name, "<dev string:x5d>" ) );
            #/
            
            break;
    }
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 3, eflags: 0x4
// Checksum 0x9618cfba, Offset: 0x680
// Size: 0xda
function private _trigger( player, trigger, *var_ec80d14b )
{
    trigger_name = snd::function_ea2f17d1( var_ec80d14b.script_ambientroom, "$default" );
    
    switch ( trigger_name )
    {
        case #"$default":
            snd::set_element( trigger, trigger_name );
            break;
        default:
            /#
                snd::function_81fac19d( snd::function_d78e3644(), "<dev string:x62>" + trigger_name + "<dev string:x5d>" );
            #/
            
            break;
    }
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 2, eflags: 0x4
// Checksum 0x47c0a55a, Offset: 0x768
// Size: 0x42a
function private function_f2a2832d( *player, msg )
{
    switch ( msg )
    {
        case #"post_armada":
            setsoundcontext( "visit", "post_armada" );
            break;
        case #"post_kgb":
            setsoundcontext( "visit", "post_kgb" );
            break;
        case #"post_cuba":
            setsoundcontext( "visit", "post_cuba" );
            break;
        case #"post_prisoner":
            setsoundcontext( "visit", "post_prisoner" );
            break;
        case #"post_takedown":
            setsoundcontext( "visit", "post_takedown" );
            break;
        case #"post_yamantau":
            setsoundcontext( "visit", "post_yamantau" );
            break;
        case #"hash_774f81b7fe6ee1f6":
            audio::snd_set_snapshot( "cp_ger_hub_evidenceboard_enter" );
            break;
        case #"hash_3f89f51c820e2ec0":
            audio::snd_set_snapshot( "" );
            break;
        case #"hash_1fb87cdadef85636":
            audio::snd_set_snapshot( "cp_ger_hub_tv_abstract_flashback" );
            break;
        case #"hash_5eed67e8e0115678":
            audio::snd_set_snapshot( "" );
            break;
        case #"snd_overlook_scene":
            thread function_34050dad();
            break;
        case #"hash_1e58e46360c0a83b":
            level notify( #"hash_1e58e46360c0a83b" );
            break;
        case #"plane_startup":
            thread function_955f4842();
            break;
        case #"plane_idle":
            thread function_2d8bbe54( 0.5 );
            break;
        case #"start_plane_rev":
            thread function_e9cf99c1();
            break;
        case #"ambient_ext_override":
            thread function_26282537();
            break;
        case #"hash_6e37b7c047667b8e":
            thread function_eeb6e2e1();
            break;
        case #"ambient_override_return_to_normal":
            thread ambient_override_return_to_normal();
            break;
        case #"hash_72dc7d49e5a3096a":
            thread dia_focus_on();
            break;
        case #"hash_4f97009133f1b2dc":
            thread dia_focus_off();
            break;
        default:
            /#
                snd::function_81fac19d( snd::function_d78e3644(), "<dev string:x86>" + snd::function_783b69( msg, "<dev string:x5d>" ) );
            #/
            
            break;
    }
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 1, eflags: 0x4
// Checksum 0x84e73de0, Offset: 0xba0
// Size: 0x172
function private _objective( objective )
{
    switch ( objective )
    {
        case #"chapter_selection":
            break;
        case #"post_takedown":
        case #"post_takedown_skip_briefing":
            break;
        case #"post_armada":
        case #"post_armada_skip_briefing":
            break;
        case #"post_yamantau":
        case #"post_yamantau_skip_briefing":
            break;
        case #"post_kgb":
        case #"post_kgb_skip_briefing":
            break;
        case #"post_cuba":
        case #"hash_6245569317a5039e":
            break;
        case #"post_prisoner":
        case #"hash_65bc9e5b3b128daf":
            break;
        case #"no_game":
            break;
        default:
            /#
                snd::function_81fac19d( snd::function_d78e3644(), "<dev string:xa4>" + objective + "<dev string:x5d>" );
            #/
            
            break;
    }
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0xd64fc1b6, Offset: 0xd20
// Size: 0x54
function function_34050dad()
{
    wait 5;
    audio::snd_set_snapshot( "cp_tkdn_hit3_overlook_duk" );
    level waittill( #"start_sniping" );
    audio::snd_set_snapshot( "" );
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0x85c9a32b, Offset: 0xd80
// Size: 0x1c
function function_26282537()
{
    forceambientroom( "ext" );
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0xfdca2e2f, Offset: 0xda8
// Size: 0x1c
function function_eeb6e2e1()
{
    forceambientroom( "main_int" );
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0x6c2c4f66, Offset: 0xdd0
// Size: 0x1c
function ambient_override_return_to_normal()
{
    forceambientroom( "" );
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0xd09a1dac, Offset: 0xdf8
// Size: 0x114
function dia_focus_on()
{
    while ( !isdefined( level.sims ) )
    {
        waitframe( 1 );
    }
    
    audio::snd_set_snapshot( "cp_ger_hub_dia_focus" );
    
    if ( isalive( level.adler ) )
    {
        level.adler function_9974c822( "cp_ger_hub_dia_focus" );
    }
    
    if ( isalive( level.park ) )
    {
        level.park function_9974c822( "cp_ger_hub_dia_focus" );
    }
    
    if ( isalive( level.lazar ) )
    {
        level.lazar function_9974c822( "cp_ger_hub_dia_focus" );
    }
    
    if ( isalive( level.sims ) )
    {
        level.sims function_9974c822( "cp_ger_hub_dia_focus" );
    }
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0xb7ec7e4c, Offset: 0xf18
// Size: 0x114
function dia_focus_off()
{
    while ( !isdefined( level.sims ) )
    {
        waitframe( 1 );
    }
    
    audio::snd_set_snapshot( "" );
    
    if ( isalive( level.adler ) )
    {
        level.adler function_5dcc74d1( "cp_ger_hub_dia_focus" );
    }
    
    if ( isalive( level.park ) )
    {
        level.park function_5dcc74d1( "cp_ger_hub_dia_focus" );
    }
    
    if ( isalive( level.lazar ) )
    {
        level.lazar function_5dcc74d1( "cp_ger_hub_dia_focus" );
    }
    
    if ( isalive( level.sims ) )
    {
        level.sims function_5dcc74d1( "cp_ger_hub_dia_focus" );
    }
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0x5662163f, Offset: 0x1038
// Size: 0x5c
function function_cb00a128()
{
    var_18dbd2db = snd::play( "quad_tkd_af_dist_plane_wash_front_lp", 2 );
    level waittill( #"hash_1e58e46360c0a83b" );
    snd::stop( var_18dbd2db, 2 );
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0x338a2693, Offset: 0x10a0
// Size: 0xdc
function function_755bfc95()
{
    walla = snd::play( "emt_tkd_walla_plane_workers_temp", [ level.var_a7c3bf6d, "tag_origin" ] );
    loaders = snd::play( "emt_tkd_cargo_loading_vehicles_lp", [ level.var_a7c3bf6d, "tag_origin" ] );
    level waittill( #"hash_1e58e46360c0a83b" );
    snd::stop( walla, 2 );
    snd::stop( loaders, 2 );
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0x1454c9dd, Offset: 0x1188
// Size: 0x3e
function function_913d2991()
{
    wait 1.5;
    var_913d2991 = snd::play( "emt_tkd_walla_runway_panic_temp", ( -49618, -55463, -25053 ) );
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0x2f35ba28, Offset: 0x11d0
// Size: 0x6c
function function_955f4842()
{
    wait 5;
    start = snd::play( "veh_tkd_af_cargo_plane_start", [ level.var_a7c3bf6d, "tag_origin" ] );
    thread function_2d8bbe54( 2 );
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 1
// Checksum 0x1a0414d2, Offset: 0x1248
// Size: 0x134
function function_2d8bbe54( wait_time )
{
    wait_time = snd::function_ea2f17d1( wait_time, 0.5 );
    level.var_abe3f688 = snd::play( "veh_tkd_af_cargo_plane_idle_lp", [ level.var_a7c3bf6d, "tag_origin" ] );
    snd::set_volume( level.var_abe3f688, 0 );
    snd::set_pitch( level.var_abe3f688, 1 );
    thread function_755bfc95();
    thread function_cb00a128();
    wait wait_time;
    snd::set_volume( level.var_abe3f688, 1, 0.5 );
    level waittill( #"hash_1c43601f4e93efcd" );
    snd::stop( level.var_abe3f688, 5 );
}

// Namespace namespace_4ed3ce47/namespace_9d055984
// Params 0
// Checksum 0xbb7b4c2d, Offset: 0x1388
// Size: 0x7c
function function_e9cf99c1()
{
    snd::set_pitch( level.var_abe3f688, snd::function_d8b24901( 8 ), 1 );
    snd::play( "veh_tkd_af_cargo_plane_accelerate", [ level.var_a7c3bf6d, "tag_origin" ] );
}

