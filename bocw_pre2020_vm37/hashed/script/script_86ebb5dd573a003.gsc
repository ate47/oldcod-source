#using script_2d443451ce681a;
#using script_3dc93ca9902a9cda;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flashlight;
#using scripts\core_common\gestures;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\debug;
#using scripts\core_common\stealth\enemy;
#using scripts\core_common\stealth\friendly;
#using scripts\core_common\stealth\neutral;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\util;

#namespace namespace_11998b8f;

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 1
// Checksum 0xd3ba1240, Offset: 0x1298
// Size: 0x25c
function function_cdb7cc7e( starting = 1 )
{
    player = getplayers()[ 0 ];
    player endon( #"disconnect" );
    player takeallweapons();
    
    if ( level flag::get( "warehouse_give_player_weapon" ) )
    {
        w_player = getweapon( #"smg_heavy_t9", "extclip" );
    }
    else if ( level flag::get( "flag_dart_gun_ready" ) && !level flag::get( "apartment_2_done" ) )
    {
        if ( !isdefined( level.var_fb71a7c4 ) )
        {
            while ( !isdefined( level.var_fb71a7c4 ) )
            {
                waitframe( 1 );
            }
        }
        
        w_player = level.var_fb71a7c4;
    }
    else
    {
        w_player = getweapon( #"pistol_semiauto_t9", "suppressed" );
    }
    
    level flag::wait_till( "level_is_go" );
    
    if ( !player hasweapon( w_player ) )
    {
        player giveweapon( w_player );
    }
    
    waitframe( 1 );
    player setweaponammoclip( w_player, w_player.clipsize );
    player setweaponammostock( w_player, w_player.maxammo );
    
    if ( is_true( starting ) )
    {
        player switchtoweaponimmediate( w_player );
        return;
    }
    
    player seteverhadweaponall( 0 );
    player switchtoweapon( w_player );
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 0
// Checksum 0xfe458b57, Offset: 0x1500
// Size: 0x1ac
function function_d30792f2()
{
    assert( isplayer( self ) );
    self endon( #"death" );
    self notify( "7e07bbe1ae909dc" );
    self endon( "7e07bbe1ae909dc" );
    self util::show_hint_text( #"hash_212782b8926819c8", undefined, "hide_dart_gun_hint", 8 );
    self notifyonplayercommand( "dart_gun_equipped", "+actionslot 4" );
    self waittill( #"dart_gun_equipped" );
    self notify( #"hide_dart_gun_hint" );
    level notify( #"dart_gun_enabled" );
    self takeallweapons();
    
    if ( !self hasweapon( level.var_fb71a7c4 ) )
    {
        self giveweapon( level.var_fb71a7c4 );
        self seteverhadweaponall( 0 );
        self switchtoweapon( level.var_fb71a7c4 );
    }
    
    if ( isdefined( level.stealth.disguised ) )
    {
        self namespace_979752dc::set_disguised( 0 );
    }
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 0
// Checksum 0xb521aa72, Offset: 0x16b8
// Size: 0x34
function function_2f0f0a84()
{
    self val::set( #"cp_ger_stakeout", "push_player", 1 );
}

/#

    // Namespace namespace_11998b8f/namespace_11998b8f
    // Params 2
    // Checksum 0x10d60962, Offset: 0x16f8
    // Size: 0x228, Type: dev
    function function_85682927( a_ents, str_endon )
    {
        self notify( "<dev string:x38>" );
        self endon( "<dev string:x38>" );
        
        if ( isdefined( str_endon ) )
        {
            level endon( str_endon );
        }
        
        while ( true )
        {
            arrayremovevalue( a_ents, undefined );
            ypos = 30;
            
            foreach ( ent in a_ents )
            {
                if ( isdefined( ent gettagorigin( "<dev string:x4b>" ) ) )
                {
                    str_origin = ent gettagorigin( "<dev string:x4b>" );
                }
                else
                {
                    str_origin = "<dev string:x59>";
                }
                
                if ( level flag::get( "<dev string:x66>" ) )
                {
                    str_name = isdefined( ent.animname ) ? ent.animname : ent.targetname;
                    
                    if ( !isdefined( str_name ) )
                    {
                        str_name = "<dev string:x74>";
                    }
                    
                    debug2dtext( ( 50, ypos, 0 ), str_name + "<dev string:x7f>" + function_9e72a96( ent.model ) + "<dev string:x8b>" + str_origin + "<dev string:xa1>" + ent.origin );
                }
                
                ypos += 20;
            }
            
            waitframe( 1 );
        }
    }

#/

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 0
// Checksum 0xf73848fa, Offset: 0x1928
// Size: 0x3c
function stakeout_stow_weapon()
{
    getplayers()[ 0 ] val::set( "stakeout_stow_weapon", "disable_weapons", 1 );
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 0
// Checksum 0x466fb769, Offset: 0x1970
// Size: 0x3c
function function_a73e6a64()
{
    getplayers()[ 0 ] val::reset( "stakeout_stow_weapon", "disable_weapons" );
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 3
// Checksum 0xbc66d410, Offset: 0x19b8
// Size: 0xdc
function function_b9a028e4( endon_flag, var_335a8dcc, var_721023c5 = 0 )
{
    level endon( endon_flag );
    
    while ( true )
    {
        self doors::waittill_door_opened();
        
        if ( var_721023c5 && isplayer( self.c_door.var_9b9642be ) || !var_721023c5 && isai( self.c_door.var_9b9642be ) )
        {
            break;
        }
        
        waitframe( 1 );
    }
    
    level flag::set( var_335a8dcc );
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 0
// Checksum 0xb1f05cfb, Offset: 0x1aa0
// Size: 0xcc
function function_2cba9c65()
{
    hidden = [];
    hidden[ #"prone" ] = 100;
    hidden[ #"crouch" ] = 300;
    hidden[ #"stand" ] = 500;
    spotted = [];
    spotted[ #"prone" ] = 4096;
    spotted[ #"crouch" ] = 4096;
    spotted[ #"stand" ] = 4096;
    namespace_979752dc::set_detect_ranges( hidden, spotted );
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 0
// Checksum 0xbc116078, Offset: 0x1b78
// Size: 0xcc
function function_de88eefd()
{
    hidden = [];
    hidden[ #"prone" ] = 100;
    hidden[ #"crouch" ] = 300;
    hidden[ #"stand" ] = 500;
    spotted = [];
    spotted[ #"prone" ] = 2048;
    spotted[ #"crouch" ] = 2048;
    spotted[ #"stand" ] = 2048;
    namespace_979752dc::set_detect_ranges( hidden, spotted );
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 0
// Checksum 0x855c7ca0, Offset: 0x1c50
// Size: 0xcc
function function_489032c9()
{
    hidden = [];
    hidden[ #"prone" ] = 250;
    hidden[ #"crouch" ] = 650;
    hidden[ #"stand" ] = 900;
    spotted = [];
    spotted[ #"prone" ] = 800;
    spotted[ #"crouch" ] = 1600;
    spotted[ #"stand" ] = 4096;
    namespace_979752dc::set_detect_ranges( hidden, spotted );
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 0
// Checksum 0xc9bb8a29, Offset: 0x1d28
// Size: 0xcc
function function_25120710()
{
    hidden = [];
    hidden[ #"prone" ] = 500;
    hidden[ #"crouch" ] = 900;
    hidden[ #"stand" ] = 1600;
    spotted = [];
    spotted[ #"prone" ] = 2048;
    spotted[ #"crouch" ] = 2048;
    spotted[ #"stand" ] = 2048;
    namespace_979752dc::set_detect_ranges( hidden, spotted );
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 0
// Checksum 0xd64849a7, Offset: 0x1e00
// Size: 0x124
function function_54158bc()
{
    scene::add_scene_func( "scene_z_stk_door_harass_stasi", &function_9d5ae353, "init" );
    scene::add_scene_func( "scene_z_stk_door_harass_civ", &function_9d5ae353, "init" );
    scene::add_scene_func( "scene_z_stk_door_harass_stasi_v2", &function_9d5ae353, "init" );
    scene::add_scene_func( "scene_z_stk_door_harass_stasi", &function_86e07b36, "init" );
    scene::add_scene_func( "scene_z_stk_door_harass_civ", &function_86e07b36, "init" );
    scene::add_scene_func( "scene_z_stk_door_harass_stasi_v2", &function_86e07b36, "init" );
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 2
// Checksum 0x92fa4acd, Offset: 0x1f30
// Size: 0xb4
function function_a34d0dd3( tname, var_8964d1a4 )
{
    var_5d39bca3 = struct::get_array( tname, "targetname" );
    assert( isdefined( var_5d39bca3 ) && var_5d39bca3.size >= 1, "<dev string:xba>" );
    assert( isdefined( var_8964d1a4 ), "<dev string:x111>" );
    array::thread_all( var_5d39bca3, &function_e9e94ff2, var_8964d1a4 );
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 1
// Checksum 0xa837cd5f, Offset: 0x1ff0
// Size: 0x1b4
function function_e9e94ff2( var_8964d1a4 )
{
    if ( isdefined( self.target ) )
    {
        if ( isdefined( self.script_noteworthy ) )
        {
            var_435b4812 = self.script_noteworthy;
        }
        
        assert( isdefined( var_435b4812 ), "<dev string:x156>" );
        scene = struct::get( self.target, "targetname" );
        scene.var_61d3da92 = self;
        scene.var_8964d1a4 = var_8964d1a4;
        scene thread scene::init();
        level flag::wait_till_any( array( var_435b4812, var_8964d1a4, "stealth_spotted" ) );
        
        if ( !level flag::get( "stealth_spotted" ) )
        {
            if ( isdefined( self.script_parameters ) )
            {
                scene_start_time = float( self.script_parameters );
                scene scene::play_from_time( "Shot 1", undefined, undefined, scene_start_time, 0 );
            }
            else
            {
                scene scene::play( "Shot 1" );
            }
            
            if ( !level flag::get( "stealth_spotted" ) )
            {
                scene flag::set( "one_off_scene_cleanup" );
            }
        }
    }
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 1
// Checksum 0x1166f892, Offset: 0x21b0
// Size: 0x192
function function_86e07b36( a_ents )
{
    self.s_door = undefined;
    self.anim_door = undefined;
    
    if ( isdefined( self.var_61d3da92.linkto ) )
    {
        a_doors = doors::get_doors( self.var_61d3da92.linkto, "linkname" );
        var_af3404cd = array::get_all_closest( self.var_61d3da92.origin, a_doors );
        self.s_door = var_af3404cd[ 0 ];
        
        if ( isdefined( self.s_door ) )
        {
            self.anim_door = self.s_door doors::function_73f09315();
            
            if ( isdefined( self.anim_door ) )
            {
                self.anim_door doors::function_f35467ac();
                self.anim_door linkto( a_ents[ #"door" ], "j_prop_1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
                self thread function_e4fcb32e();
            }
            
            if ( isdefined( self.s_door.target ) )
            {
                self.var_17014c84 = getent( self.s_door.target, "targetname" );
            }
        }
    }
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 0
// Checksum 0xe5941970, Offset: 0x2350
// Size: 0x1e8
function function_e4fcb32e()
{
    self waittill( #"close_door" );
    
    if ( isdefined( self.anim_door ) )
    {
        wait 0.25;
        self.s_door doors::open();
        self.s_door doors::lock();
    }
    
    if ( isdefined( self.var_17014c84 ) )
    {
        a_ai = getaispeciesarray();
        
        foreach ( guy in a_ai )
        {
            if ( guy istouchingvolume( self.var_17014c84.origin, self.var_17014c84 getmins(), self.var_17014c84 getmaxs() ) )
            {
                guy val::set( "alley_door", "ignoreall", 1 );
                
                if ( guy flag::get( "break_stealth" ) )
                {
                    util::delay( 0.5, "alley_2_done", &function_4ae9de96, self.s_door );
                }
                
                guy delete();
            }
        }
    }
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 1
// Checksum 0xdb5d3940, Offset: 0x2540
// Size: 0x94
function function_4ae9de96( door )
{
    playsoundatposition( "vox_ger3_stealth_ally_killed", door.origin + ( 0, 0, 48 ) );
    wait 1.75;
    function_aebf36c( "attack", getplayers()[ 0 ], getplayers()[ 0 ].origin, 1000, "axis" );
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 1
// Checksum 0x467b8df2, Offset: 0x25e0
// Size: 0x330
function function_9d5ae353( a_ents )
{
    foreach ( guy in a_ents )
    {
        if ( isdefined( guy.animname ) )
        {
            if ( issubstr( guy.animname, "guard1" ) )
            {
                vo_guard = guy;
            }
            else if ( issubstr( guy.animname, "civ1" ) )
            {
                var_2020cd93 = guy;
            }
        }
        
        if ( isai( guy ) )
        {
            guy.scene_struct = self;
            guy.var_3ed97f8 = arraycopy( a_ents );
            arrayremovevalue( guy.var_3ed97f8, guy );
            
            if ( guy.team == "axis" )
            {
                if ( !isdefined( guy.script_type ) )
                {
                    guy stealth_enemy::set_blind( 1 );
                }
                
                guy thread function_958168b9();
                continue;
            }
            
            guy.var_ac4fe74b = 1;
            guy thread function_958168b9( 1 );
        }
    }
    
    var_f430b579 = undefined;
    var_f430b579 = self function_77fe8bb5( vo_guard, var_2020cd93 );
    
    if ( isdefined( var_f430b579 ) )
    {
        level thread function_a809c979( vo_guard, var_2020cd93, var_f430b579 );
    }
    
    util::waittill_any_ents_two( level, self.var_8964d1a4, self, "one_off_scene_cleanup" );
    
    if ( !self flag::get( "keep_scene_ai" ) )
    {
        foreach ( guy in a_ents )
        {
            if ( isai( guy ) && isalive( guy ) )
            {
                guy notify( #"hash_339e977c12dc1f67" );
                guy delete();
            }
        }
    }
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 0
// Checksum 0xe38a5856, Offset: 0x2918
// Size: 0x154
function function_dd4726f3()
{
    scene::add_scene_func( "aib_vign_stakeout_harass_check_car", &function_45d01f40, "play" );
    scene::add_scene_func( "aib_vign_stakeout_harass_check_papers", &function_45d01f40, "play" );
    scene::add_scene_func( "aib_vign_stakeout_harass_check_papers", &function_f5598d8d, "play" );
    scene::add_scene_func( "aib_vign_stakeout_harass_ask_questions", &function_45d01f40, "play" );
    scene::add_scene_func( "aib_vign_stakeout_harass_pat_down", &function_45d01f40, "play" );
    scene::add_scene_func( "aib_vign_stakeout_harass_wall_frisk", &function_45d01f40, "play" );
    scene::add_scene_func( "aib_vign_stakeout_harass_question_woman", &function_45d01f40, "play" );
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 2
// Checksum 0xb7811ad2, Offset: 0x2a78
// Size: 0xb4
function function_91a7f501( tname, var_8964d1a4 )
{
    var_5d39bca3 = struct::get_array( tname, "targetname" );
    assert( isdefined( var_5d39bca3 ) && var_5d39bca3.size >= 1, "<dev string:x1e1>" );
    assert( isdefined( var_8964d1a4 ), "<dev string:x235>" );
    array::thread_all( var_5d39bca3, &function_e0548884, var_8964d1a4 );
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 1
// Checksum 0x7ea4dc20, Offset: 0x2b38
// Size: 0x74
function function_e0548884( var_8964d1a4 )
{
    if ( isdefined( self.target ) )
    {
        scene = struct::get( self.target, "targetname" );
        scene.var_61d3da92 = self;
        scene.var_8964d1a4 = var_8964d1a4;
        scene scene::play();
    }
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 1
// Checksum 0x44741a92, Offset: 0x2bb8
// Size: 0x2c
function function_f5598d8d( a_ents )
{
    a_ents[ #"hash_18e9070f6eabd46d" ] thread function_ca7fdd25();
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 1
// Checksum 0xcebf63ce, Offset: 0x2bf0
// Size: 0x424
function function_45d01f40( a_ents )
{
    foreach ( guy in a_ents )
    {
        if ( isdefined( guy.animname ) )
        {
            if ( issubstr( guy.animname, "guard1" ) )
            {
                vo_guard = guy;
            }
            else if ( issubstr( guy.animname, "_man" ) )
            {
                var_2020cd93 = guy;
            }
            else if ( issubstr( guy.animname, "_woman" ) )
            {
                var_467706bc = guy;
            }
        }
        
        if ( guy.script_string === "flashlight" )
        {
            guy.flashlightoverride = 1;
            
            if ( isai( guy ) )
            {
                guy flashlight::function_65e5c8c8( 1 );
            }
        }
        
        if ( isai( guy ) )
        {
            guy.var_3ed97f8 = arraycopy( a_ents );
            arrayremovevalue( guy.var_3ed97f8, guy );
            
            if ( guy.team == "axis" )
            {
                if ( !isdefined( guy.stealth ) )
                {
                    guy namespace_979752dc::do_stealth();
                }
                
                if ( !isdefined( guy.script_type ) )
                {
                    guy stealth_enemy::set_blind( 1 );
                }
                
                guy thread function_958168b9();
                continue;
            }
            
            guy.var_ac4fe74b = 1;
            guy thread function_958168b9( 1 );
        }
    }
    
    var_f430b579 = undefined;
    
    if ( !isdefined( var_2020cd93 ) )
    {
        var_f430b579 = self function_77fe8bb5( vo_guard, var_467706bc );
        
        if ( isdefined( var_f430b579 ) )
        {
            level thread function_a809c979( vo_guard, var_467706bc, var_f430b579 );
        }
    }
    else
    {
        var_f430b579 = self function_77fe8bb5( vo_guard, var_2020cd93 );
        
        if ( isdefined( var_f430b579 ) )
        {
            level thread function_a809c979( vo_guard, var_2020cd93, var_f430b579 );
        }
    }
    
    level flag::wait_till( self.var_8964d1a4 );
    self scene::stop();
    
    foreach ( guy in a_ents )
    {
        if ( isai( guy ) && isalive( guy ) )
        {
            guy notify( #"hash_339e977c12dc1f67" );
        }
    }
    
    array::delete_all( a_ents );
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 1
// Checksum 0x65e685c1, Offset: 0x3020
// Size: 0x2e4
function function_e24505b7( a_ents )
{
    foreach ( guy in a_ents )
    {
        if ( isai( guy ) )
        {
            if ( issubstr( guy.animname, "guard1" ) )
            {
                vo_guard = guy;
            }
            else if ( issubstr( guy.animname, "civ1" ) )
            {
                var_2020cd93 = guy;
            }
            
            guy.var_3ed97f8 = arraycopy( a_ents );
            arrayremovevalue( guy.var_3ed97f8, guy );
            
            if ( guy.team == "axis" )
            {
                guy thread function_958168b9();
                continue;
            }
            
            guy.var_ac4fe74b = 1;
            guy thread function_958168b9( 1 );
        }
    }
    
    var_f430b579 = undefined;
    var_f430b579 = self function_77fe8bb5( vo_guard, var_2020cd93 );
    
    if ( isdefined( var_f430b579 ) )
    {
        level thread function_a809c979( vo_guard, var_2020cd93, var_f430b579 );
    }
    
    level flag::wait_till( "alley_2_done" );
    
    foreach ( guy in a_ents )
    {
        if ( isai( guy ) && isalive( guy ) )
        {
            guy notify( #"hash_339e977c12dc1f67" );
        }
    }
    
    self scene::stop();
    array::delete_all( a_ents );
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 1
// Checksum 0x57bbb4b7, Offset: 0x3310
// Size: 0x3f0
function function_c1bc96cf( a_ents )
{
    anim_ents = [];
    
    foreach ( guy in a_ents )
    {
        if ( isai( guy ) )
        {
            if ( isdefined( guy.animname ) && ( guy.animname == "enemy3" || guy.animname == "enemy4" || guy.animname == "civ1" || guy.animname == "civ2" ) )
            {
                if ( issubstr( guy.animname, "enemy3" ) )
                {
                    vo_guard = guy;
                }
                else if ( issubstr( guy.animname, "civ1" ) )
                {
                    var_2020cd93 = guy;
                }
                
                guy.var_3ed97f8 = arraycopy( a_ents );
                arrayremovevalue( guy.var_3ed97f8, guy );
                
                if ( guy.team == "axis" )
                {
                    guy thread function_958168b9();
                    continue;
                }
                
                guy.var_ac4fe74b = 1;
                guy thread function_958168b9( 1 );
            }
        }
    }
    
    var_f430b579 = undefined;
    var_f430b579 = self function_77fe8bb5( vo_guard, var_2020cd93 );
    
    if ( isdefined( var_f430b579 ) )
    {
        level thread function_a809c979( vo_guard, var_2020cd93, var_f430b579 );
    }
    
    level flag::wait_till( "alley_2_done" );
    
    foreach ( guy in a_ents )
    {
        if ( isai( guy ) && isalive( guy ) )
        {
            guy notify( #"hash_339e977c12dc1f67" );
        }
    }
    
    self scene::stop();
    
    foreach ( anim_ent in anim_ents )
    {
        if ( isdefined( anim_ent ) && isai( anim_ent ) )
        {
            anim_ent delete();
        }
    }
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 1
// Checksum 0x9d9943e7, Offset: 0x3708
// Size: 0x42c
function function_958168b9( is_civ )
{
    self endon( #"hash_339e977c12dc1f67" );
    
    if ( is_true( is_civ ) )
    {
        waitresult = self waittill( #"stop_vignette_scene", #"damage", #"death" );
    }
    else
    {
        waitresult = self waittill( #"stop_vignette_scene", #"takedown_begin", #"stealth_combat", #"stealth_investigate", #"damage", #"death", #"set_alert_level" );
    }
    
    if ( isdefined( self.var_3ed97f8 ) )
    {
        foreach ( ent in self.var_3ed97f8 )
        {
            if ( isai( ent ) )
            {
                ent notify( #"stop_vignette_scene" );
                
                if ( ( waitresult._notify == "stop_vignette_scene" || waitresult._notify == "stealth_combat" || waitresult._notify == "set_alert_level" ) && self.archetype != #"civilian" )
                {
                    ent flag::set( "break_stealth" );
                }
            }
        }
    }
    
    if ( isdefined( self.scene_struct ) )
    {
        self.scene_struct notify( #"close_door" );
        self.scene_struct flag::set( "keep_scene_ai" );
    }
    
    if ( waitresult._notify == "death" )
    {
        return;
    }
    
    self endon( #"death" );
    
    if ( isdefined( self.var_a0639f34 ) )
    {
        return;
    }
    
    if ( isdefined( self.current_scene ) )
    {
        level scene::stop( self.current_scene );
    }
    
    if ( !isalive( self ) || is_true( self.var_f953d31a ) )
    {
        return;
    }
    
    self notify( #"hash_81580761b9ce6a5" );
    self dialogue::function_47b06180();
    self.var_f953d31a = 1;
    
    if ( is_true( is_civ ) )
    {
        if ( self.archetype == #"civilian" )
        {
            self ai::set_behavior_attribute( #"_civ_mode", "panic" );
        }
        
        return;
    }
    
    self stealth_enemy::set_blind( 0 );
    
    if ( is_true( level.var_4e5a623b ) )
    {
        self.holdfire = 1;
        return;
    }
    
    player = getplayers()[ 0 ];
    self function_a3fcf9e0( "attack", player, player.origin );
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 2
// Checksum 0xe8756453, Offset: 0x3b40
// Size: 0x15fe
function function_77fe8bb5( vo_guard, var_2020cd93 )
{
    if ( !isdefined( self.var_61d3da92.script_animation ) )
    {
        return;
    }
    
    switch ( self.var_61d3da92.script_animation )
    {
        case #"harass_check_papers":
            if ( math::cointoss() )
            {
                var_f430b579 = [];
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06160_gms1_whendidyoulasts_70";
                voline.ent = vo_guard;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06160_gmc1_twonightsagohes_46";
                voline.ent = var_2020cd93;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06160_gms1_anddidyouknowhe_d3";
                voline.ent = vo_guard;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06160_gmc1_nothatsimpossib_ab";
                voline.ent = var_2020cd93;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06160_gms1_imafraidhespart_c1";
                voline.ent = vo_guard;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06160_gmc1_dontberidiculou_65";
                voline.ent = var_2020cd93;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
            }
            else
            {
                var_f430b579 = [];
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06170_gmc2_hewasheavysetan_ed";
                voline.ent = var_2020cd93;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06170_gms3_andyousayyouhew_ef";
                voline.ent = vo_guard;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06170_gmc2_yeshewasdriving_82";
                voline.ent = var_2020cd93;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06170_gms3_haveyoueverseen_2d";
                voline.ent = vo_guard;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06170_gmc2_noihavent_21";
                voline.ent = var_2020cd93;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06170_gms3_okaycouldyoudes_72";
                voline.ent = vo_guard;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
            }
            
            break;
        case #"harass_check_car":
            if ( math::cointoss() )
            {
                var_f430b579 = [];
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06120_gms3_isthereanything_61";
                voline.ent = vo_guard;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06120_gmc3_onlyasparetirea_4e";
                voline.ent = var_2020cd93;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06120_gms3_whatsinthebacks_f7";
                voline.ent = vo_guard;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06120_gmc3_theresjustlefto_fc";
                voline.ent = var_2020cd93;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06120_gms3_wheresyourfrien_2f";
                voline.ent = vo_guard;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06120_gmc3_wedroveseparate_3c";
                voline.ent = var_2020cd93;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06120_gms3_thisisbigcaritw_66";
                voline.ent = vo_guard;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
            }
            else
            {
                var_f430b579 = [];
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06130_gms1_thiscarfitsthed_ca";
                voline.ent = vo_guard;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06130_gmc1_thatsimpossible_7b";
                voline.ent = var_2020cd93;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06130_gms1_doyouknowanyone_9e";
                voline.ent = vo_guard;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06130_gmc1_yesmywifeand2so_6d";
                voline.ent = var_2020cd93;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06130_gms1_didyoutakeyourc_d7";
                voline.ent = vo_guard;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06130_gmc1_nowetookatraint_bd";
                voline.ent = var_2020cd93;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06130_gms1_thenineedtoknow_2e";
                voline.ent = vo_guard;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06130_gmc1_whymybrotherwou_ee";
                voline.ent = vo_guard;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
            }
            
            break;
        case #"harass_pat_down":
            if ( math::cointoss() )
            {
                var_f430b579 = [];
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06140_gms3_yesyourpapersar_33";
                voline.ent = vo_guard;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06140_gmc3_nosiriveneverbe_c4";
                voline.ent = var_2020cd93;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06140_gms3_soifiweretotake_67";
                voline.ent = vo_guard;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06140_gmc3_youdontneedtodo_73";
                voline.ent = var_2020cd93;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06140_gms3_woulditnowyouse_28";
                voline.ent = vo_guard;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06140_gmc3_thatsbecauseive_63";
                voline.ent = var_2020cd93;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
            }
            else
            {
                var_f430b579 = [];
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06150_gms2_thatmaybemrfisc_14";
                voline.ent = vo_guard;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06150_gmc2_reallywhatfor_0b";
                voline.ent = var_2020cd93;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06150_gms2_areyouafriendof_62";
                voline.ent = vo_guard;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06150_gmc2_iknowhimfromwor_00";
                voline.ent = var_2020cd93;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06150_gms2_hegaveusyournam_15";
                voline.ent = vo_guard;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06150_gmc2_thatsimpossible_51";
                voline.ent = var_2020cd93;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
            }
            
            break;
        case #"harass_wall_frisk":
            if ( math::cointoss() )
            {
                var_f430b579 = [];
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06100_gms1_wherewereyougoi_63";
                voline.ent = vo_guard;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06100_gmc3_imonmywaytowork_1f";
                voline.ent = var_2020cd93;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06100_gms1_nowyouregoingto_d5";
                voline.ent = vo_guard;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06100_gmc3_pleasemybossisg_b7";
                voline.ent = var_2020cd93;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06100_gms1_noimafraidnot_e0";
                voline.ent = vo_guard;
                voline.postdelay = 0.5;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06100_gms1_itsmyjobtoquest_e1";
                voline.ent = vo_guard;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
            }
            else
            {
                var_f430b579 = [];
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06110_gmc2_ialreadytoldyou_a9";
                voline.ent = var_2020cd93;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06110_gms2_doyouknowwhosco_ea";
                voline.ent = vo_guard;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06110_gmc2_nothebarwascrow_53";
                voline.ent = var_2020cd93;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06110_gms2_whywouldsomeone_aa";
                voline.ent = vo_guard;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06110_gmc2_idontknow_26";
                voline.ent = var_2020cd93;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
                voline = spawnstruct();
                voline.alias = "vox_cp_stkt_06110_gms2_whichiswhyiwill_5c";
                voline.ent = vo_guard;
                voline.postdelay = 1;
                var_f430b579[ var_f430b579.size ] = voline;
            }
            
            break;
        case #"hash_77b63742dcc86dd1":
            var_f430b579 = [];
            voline = spawnstruct();
            voline.alias = "vox_cp_stkt_09350_gmc1_whyareyoudoingt_dd";
            voline.ent = var_2020cd93;
            voline.postdelay = 1;
            var_f430b579[ var_f430b579.size ] = voline;
            voline = spawnstruct();
            voline.alias = "vox_cp_stkt_09350_gms3_theyreoutofdate_c5";
            voline.ent = vo_guard;
            voline.postdelay = 1;
            var_f430b579[ var_f430b579.size ] = voline;
            voline = spawnstruct();
            voline.alias = "vox_cp_stkt_09350_gmc1_ihaventhadtimet_bc";
            voline.ent = var_2020cd93;
            voline.postdelay = 1;
            var_f430b579[ var_f430b579.size ] = voline;
            voline = spawnstruct();
            voline.alias = "vox_cp_stkt_09350_gms3_thatsnotmyconce_ac";
            voline.ent = vo_guard;
            voline.postdelay = 0.5;
            var_f430b579[ var_f430b579.size ] = voline;
            voline = spawnstruct();
            voline.alias = "vox_cp_stkt_09350_gmc1_butivedonenothi_b5";
            voline.ent = var_2020cd93;
            voline.postdelay = 1;
            var_f430b579[ var_f430b579.size ] = voline;
            voline = spawnstruct();
            voline.alias = "vox_cp_stkt_09350_gms3_havingexpiredpa_3a";
            voline.ent = vo_guard;
            voline.postdelay = 1;
            var_f430b579[ var_f430b579.size ] = voline;
            break;
        case #"harass_question_woman":
            var_f430b579 = [];
            voline = spawnstruct();
            voline.alias = "vox_cp_stkt_09300_gms2_whatareyoudoing_61";
            voline.ent = vo_guard;
            voline.postdelay = 1;
            var_f430b579[ var_f430b579.size ] = voline;
            voline = spawnstruct();
            voline.alias = "vox_cp_stkt_09300_gfc1_imonmywayhomefr_a2";
            voline.ent = var_2020cd93;
            voline.postdelay = 1;
            var_f430b579[ var_f430b579.size ] = voline;
            voline = spawnstruct();
            voline.alias = "vox_cp_stkt_09300_gms2_whydontyouhavea_83";
            voline.ent = vo_guard;
            voline.postdelay = 1;
            var_f430b579[ var_f430b579.size ] = voline;
            voline = spawnstruct();
            voline.alias = "vox_cp_stkt_09300_gfc1_normallymyhusba_73";
            voline.ent = var_2020cd93;
            voline.postdelay = 1;
            var_f430b579[ var_f430b579.size ] = voline;
            voline = spawnstruct();
            voline.alias = "vox_cp_stkt_09300_gms2_whathospitaldoy_9f";
            voline.ent = vo_guard;
            voline.postdelay = 0.5;
            var_f430b579[ var_f430b579.size ] = voline;
            voline = spawnstruct();
            voline.alias = "vox_cp_stkt_09300_gfc1_charituniversit_fc";
            voline.ent = var_2020cd93;
            voline.postdelay = 1;
            var_f430b579[ var_f430b579.size ] = voline;
            voline = spawnstruct();
            voline.alias = "vox_cp_stkt_09300_gms2_howlonghaveyouw_62";
            voline.ent = vo_guard;
            voline.postdelay = 1;
            var_f430b579[ var_f430b579.size ] = voline;
            voline = spawnstruct();
            voline.alias = "vox_cp_stkt_09300_gfc1_3yearsbeatamiin_bc";
            voline.ent = var_2020cd93;
            voline.postdelay = 1;
            var_f430b579[ var_f430b579.size ] = voline;
            voline = spawnstruct();
            voline.alias = "vox_cp_stkt_09300_gms2_noatleastnotyet_24";
            voline.ent = vo_guard;
            voline.postdelay = 0.5;
            var_f430b579[ var_f430b579.size ] = voline;
            break;
        case #"harass_ask_questions":
        default:
            var_f430b579 = [];
            voline = spawnstruct();
            voline.alias = "vox_cp_stkt_06100_gms1_wherewereyougoi_63";
            voline.ent = vo_guard;
            voline.postdelay = 1;
            var_f430b579[ var_f430b579.size ] = voline;
            voline = spawnstruct();
            voline.alias = "vox_cp_stkt_06100_gmc3_imonmywaytowork_1f";
            voline.ent = var_2020cd93;
            voline.postdelay = 1;
            var_f430b579[ var_f430b579.size ] = voline;
            voline = spawnstruct();
            voline.alias = "vox_cp_stkt_06100_gms1_nowyouregoingto_d5";
            voline.ent = vo_guard;
            voline.postdelay = 1;
            var_f430b579[ var_f430b579.size ] = voline;
            voline = spawnstruct();
            voline.alias = "vox_cp_stkt_06100_gmc3_pleasemybossisg_b7";
            voline.ent = var_2020cd93;
            voline.postdelay = 1;
            var_f430b579[ var_f430b579.size ] = voline;
            voline = spawnstruct();
            voline.alias = "vox_cp_stkt_06100_gms1_noimafraidnot_e0";
            voline.ent = vo_guard;
            voline.postdelay = 0.5;
            var_f430b579[ var_f430b579.size ] = voline;
            voline = spawnstruct();
            voline.alias = "vox_cp_stkt_06100_gms1_itsmyjobtoquest_e1";
            voline.ent = vo_guard;
            voline.postdelay = 1;
            var_f430b579[ var_f430b579.size ] = voline;
            break;
    }
    
    return var_f430b579;
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 3
// Checksum 0x631582d1, Offset: 0x5148
// Size: 0x188
function function_a809c979( guard, guy, var_f430b579 )
{
    guard endon( #"death", #"hash_81580761b9ce6a5" );
    guy endon( #"death", #"hash_81580761b9ce6a5" );
    
    while ( true )
    {
        wait randomfloatrange( 1, 10 );
        
        foreach ( var_1b73eecc in var_f430b579 )
        {
            if ( !isdefined( var_1b73eecc.ent ) )
            {
                return;
            }
            
            voline = snd::play( var_1b73eecc.alias, [ var_1b73eecc.ent, "j_head" ] );
            snd::function_2fdc4fb( voline );
            wait var_1b73eecc.postdelay;
        }
    }
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 2
// Checksum 0xfa492fa6, Offset: 0x52d8
// Size: 0x19c
function function_875978f7( var_7921c061, var_cea8c6e1 )
{
    self endon( #"death" );
    
    if ( !isdefined( var_cea8c6e1 ) )
    {
        var_cea8c6e1 = 1;
    }
    
    if ( !isdefined( var_7921c061 ) )
    {
        var_7921c061 = "right";
    }
    
    attach_tag = "tag_accessory_" + var_7921c061;
    
    if ( !isdefined( self gettagorigin( attach_tag ) ) )
    {
        attach_tag = "tag_weapon_" + var_7921c061;
    }
    
    self.prop = "umbrella_" + var_7921c061;
    
    if ( isdefined( self gettagorigin( attach_tag ) ) )
    {
        self.umbrella = util::spawn_model( "par_umbrella_open_01", self.origin );
        self.umbrella.origin = self gettagorigin( attach_tag );
        self.umbrella.angles = self gettagangles( attach_tag );
        self.umbrella linkto( self, attach_tag, ( 0, 0, 0 ), ( 0, 0, 0 ) );
        
        if ( is_true( var_cea8c6e1 ) )
        {
            self thread util::delete_on_death( self.umbrella );
        }
    }
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 1
// Checksum 0x761cecfb, Offset: 0x5480
// Size: 0x164
function function_ca7fdd25( color )
{
    if ( !isdefined( color ) )
    {
        num = randomint( 4 );
        
        if ( num == 0 )
        {
            color = "black";
        }
        else if ( num == 1 )
        {
            color = "brown";
        }
        else if ( num == 2 )
        {
            color = "green";
        }
        else
        {
            color = "maroon";
        }
    }
    
    if ( color == "brown" )
    {
        self setmodel( #"par_umbrella_open_01_brown_anim" );
        return;
    }
    
    if ( color == "green" )
    {
        self setmodel( #"par_umbrella_open_01_green_anim" );
        return;
    }
    
    if ( color == "maroon" )
    {
        self setmodel( #"hash_3953cd9757fd1247" );
        return;
    }
    
    self setmodel( #"par_umbrella_open_01_anim" );
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 3
// Checksum 0x90659903, Offset: 0x55f0
// Size: 0x1bc
function function_bfab0117( var_7921c061, var_cea8c6e1, var_e9145a5e )
{
    self endon( #"death" );
    
    if ( !isdefined( var_cea8c6e1 ) )
    {
        var_cea8c6e1 = 1;
    }
    
    if ( !isdefined( var_7921c061 ) )
    {
        var_7921c061 = "right";
    }
    
    attach_tag = "tag_accessory_" + var_7921c061;
    
    if ( !isdefined( self gettagorigin( attach_tag ) ) )
    {
        attach_tag = "tag_weapon_" + var_7921c061;
    }
    
    if ( !is_true( var_e9145a5e ) )
    {
        self.prop = "suitcase_" + var_7921c061;
    }
    
    if ( isdefined( self gettagorigin( attach_tag ) ) )
    {
        self.briefcase = util::spawn_model( "briefcase_prop", self.origin );
        self.briefcase.origin = self gettagorigin( attach_tag );
        self.briefcase.angles = self gettagangles( attach_tag );
        self.briefcase linkto( self, attach_tag, ( 0, 0, 0 ), ( 0, 0, 0 ) );
        
        if ( is_true( var_cea8c6e1 ) )
        {
            self thread util::delete_on_death( self.briefcase );
        }
    }
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 4
// Checksum 0xaa9a8d8f, Offset: 0x57b8
// Size: 0x1c4
function function_2ba7047( var_d93f6413, waittime, ontime, ender )
{
    ents = getentarray( var_d93f6413, "targetname" );
    array::run_all( ents, &hide );
    
    for ( ;; )
    {
        ents = array::randomize( ents );
        
        foreach ( window in ents )
        {
            window show();
            window util::delay( randomfloatrange( ontime * 0.75, ontime * 1.25 ), "death", &hide );
            wait randomfloatrange( 0.75 * waittime, 1.25 * waittime );
        }
    }
    
    level flag::wait_till( ender );
    array::run_all( ents, &delete );
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 1
// Checksum 0x6f99d373, Offset: 0x5988
// Size: 0x124
function function_f76805ab( endon_flag )
{
    var_33ddcdd3 = getentarray( self.script_linkname, "script_linkto" );
    
    foreach ( light in var_33ddcdd3 )
    {
        if ( isdefined( light.script_noteworthy ) && light.script_noteworthy == "nowalk_on" )
        {
            self.nowalk_on = light;
            continue;
        }
        
        if ( isdefined( light.script_noteworthy ) && light.script_noteworthy == "walk_on" )
        {
            self.walk_on = light;
        }
    }
    
    self thread function_74b6434d( endon_flag );
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 1
// Checksum 0xfdb119a5, Offset: 0x5ab8
// Size: 0x1a4
function function_74b6434d( endon_flag )
{
    while ( !level flag::get( endon_flag ) )
    {
        if ( isdefined( self.script_parameters ) && self.script_parameters == "north_south" )
        {
            self.nowalk_on hide();
            self.walk_on show();
        }
        else
        {
            self.nowalk_on show();
            self.walk_on hide();
        }
        
        wait 15;
        
        if ( isdefined( self.script_parameters ) && self.script_parameters == "north_south" )
        {
            self.nowalk_on show();
            self.walk_on hide();
        }
        else
        {
            self.nowalk_on hide();
            self.walk_on show();
        }
        
        wait 15;
        wait 0.05;
    }
    
    if ( isdefined( self.walk_on ) )
    {
        self.walk_on delete();
    }
    
    if ( isdefined( self.nowalk_on ) )
    {
        self.nowalk_on delete();
    }
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 2
// Checksum 0x9e52ae32, Offset: 0x5c68
// Size: 0x3c
function function_d3e635a9( set_flag, notification )
{
    self waittill( notification );
    level flag::set( set_flag );
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 1
// Checksum 0xd029745b, Offset: 0x5cb0
// Size: 0xd8
function function_ede3f327( waitflag )
{
    self endon( #"death", #"hash_302f2d025d4998b1" );
    
    if ( !isai( self ) )
    {
        return;
    }
    
    if ( isdefined( waitflag ) )
    {
        level flag::wait_till( waitflag );
    }
    
    while ( true )
    {
        if ( self function_4dab0d59() )
        {
            self lookatentity( getplayers()[ 0 ] );
        }
        else
        {
            self lookatentity();
        }
        
        wait 0.5;
    }
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 0
// Checksum 0xb2153ebc, Offset: 0x5d90
// Size: 0x1d4
function function_4dab0d59()
{
    self endon( #"death" );
    player = getplayers()[ 0 ];
    withindistance = undefined;
    var_aaeeba00 = undefined;
    var_6d08b2c5 = undefined;
    distsquared = distance2dsquared( self.origin, player.origin );
    
    if ( distsquared <= 62500 )
    {
        withindistance = 1;
    }
    else
    {
        return 0;
    }
    
    var_23d4571c = anglestoforward( self.angles );
    normalizedvec = vectornormalize( player.origin - self.origin );
    var_aa74cdcb = vectordot( var_23d4571c, normalizedvec );
    
    if ( var_aa74cdcb >= cos( 70 ) )
    {
        var_aaeeba00 = 1;
    }
    else
    {
        return 0;
    }
    
    var_6d08b2c5 = util::within_fov( player.origin, player getplayerangles(), self gettagorigin( "j_head" ), cos( 80 ) );
    
    if ( is_true( var_6d08b2c5 ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 0
// Checksum 0x258960f5, Offset: 0x5f70
// Size: 0x9c
function function_a09d85a9()
{
    var_3bfdd11b = spawn( "trigger_radius", self.origin, 0, 64, 72 );
    var_3bfdd11b enablelinkto();
    var_3bfdd11b linkto( self, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    self waittill( #"death" );
    var_3bfdd11b delete();
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 5
// Checksum 0x35d95fab, Offset: 0x6018
// Size: 0x1a8
function function_ec76072d( initialwait, var_38d138fb, var_25941f2e, ender, var_420c424d )
{
    if ( isdefined( var_420c424d ) )
    {
        level endon( ender, var_420c424d );
    }
    else
    {
        level endon( ender );
    }
    
    guy = undefined;
    
    if ( isai( self ) && isalive( self ) )
    {
        guy = self;
    }
    
    wait initialwait;
    nags = arraycopy( var_38d138fb );
    player = getplayers()[ 0 ];
    
    while ( true )
    {
        nag = array::random( nags );
        
        if ( isdefined( nag ) && soundexists( nag ) )
        {
            if ( isdefined( guy ) )
            {
                guy dialogue::queue( nag );
            }
            else
            {
                dialogue::radio( nag );
            }
        }
        
        arrayremovevalue( nags, nag );
        
        if ( nags.size == 0 )
        {
            nags = arraycopy( var_38d138fb );
        }
        
        wait var_25941f2e;
    }
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 1
// Checksum 0xdb6f1a21, Offset: 0x61c8
// Size: 0x3c
function function_c15079c5( animation )
{
    self setanimknobrestart( isdefined( animation ) ? animation : #"hash_680228261864fe24" );
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 1
// Checksum 0x2b84dd00, Offset: 0x6210
// Size: 0x3c
function function_a44394f7( animation )
{
    self setanimknobrestart( isdefined( animation ) ? animation : #"hash_52ac61c625d5d151" );
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 4
// Checksum 0x7b990357, Offset: 0x6258
// Size: 0x148
function function_d0551a1b( from_vol, retreat_vol, delay_min, delay_max )
{
    checkvol = getent( from_vol, "targetname" );
    retreaters = checkvol ai::function_18c4ff86( "axis", "human" );
    goalvolume = getent( retreat_vol, "targetname" );
    
    foreach ( retreater in retreaters )
    {
        retreater thread function_3817d3c4( delay_min, delay_max, goalvolume );
    }
    
    function_1eaaceab( retreaters );
    return retreaters;
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 3
// Checksum 0x4de25fe8, Offset: 0x63a8
// Size: 0x12c
function function_3817d3c4( delay_min, delay_max, goalvolume )
{
    if ( isdefined( delay_min ) && isdefined( delay_max ) )
    {
        self endon( #"death" );
        self endon( #"deleted" );
        wait randomfloatrange( delay_min, delay_max );
    }
    
    if ( isdefined( self ) && isalive( self ) )
    {
        self.forcegoal = 0;
        self.fixednode = 0;
        self set_ignoreall( "retreat", 1 );
        self cleargoalvolume();
        self setgoal( goalvolume );
        wait randomfloatrange( 2, 5 );
        self set_ignoreall( "retreat", 0 );
    }
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 4
// Checksum 0x9874126a, Offset: 0x64e0
// Size: 0x54
function function_d6fedf97( guys, killcount, sflag, timeout )
{
    ai::waittill_dead_or_dying( guys, killcount, timeout );
    flag::set( sflag );
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 2
// Checksum 0xecc0e508, Offset: 0x6540
// Size: 0x44
function set_ignoreall( str_group, b_ignore = 1 )
{
    self val::set( str_group, "ignoreall", b_ignore );
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 2
// Checksum 0xfc9e1144, Offset: 0x6590
// Size: 0x44
function set_ignoreme( str_group, b_ignore = 1 )
{
    self val::set( str_group, "ignoreme", b_ignore );
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 0
// Checksum 0x76ccab98, Offset: 0x65e0
// Size: 0x166
function function_e8e2095b()
{
    assert( isplayer( self ) );
    self endon( #"death" );
    self endon( #"hash_6ade70a9a975cc1a" );
    self notify( "28ad1fdb6067b46" );
    self endon( "28ad1fdb6067b46" );
    var_72834f62 = 0;
    self util::show_hint_text( #"hash_382181c90678477e", undefined, "hide_blacklight_hint", 8 );
    
    while ( true )
    {
        if ( self scene::function_c935c42() )
        {
            wait 0.2;
            continue;
        }
        
        self notifyonplayercommand( "blacklight_toggle", "+actionslot 3" );
        self waittill( #"blacklight_toggle" );
        
        if ( var_72834f62 == 0 )
        {
            var_72834f62 = !var_72834f62;
            self function_1f24a0cc( var_72834f62 );
        }
        else
        {
            var_72834f62 = 0;
            self function_1f24a0cc();
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 1, eflags: 0x4
// Checksum 0x3b359070, Offset: 0x6750
// Size: 0x2c8
function private function_1f24a0cc( on )
{
    if ( is_true( on ) )
    {
        self gestures::function_b6cc48ed( #"ges_drophand", undefined, 1, undefined, undefined, undefined, 1 );
        time = self getgestureanimlength( #"ges_drophand" );
        wait time - 0.15;
        self notify( #"hide_blacklight_hint" );
        clientfield::set_to_player( "player_blacklight", 1 );
        self thread function_82f7d1ba();
        a_decals = getentarray( "blacklight_decals_emissive", "targetname" );
        
        foreach ( var_fd5e9fef in a_decals )
        {
            var_fd5e9fef clientfield::set( "render_emissive_blacklight_material", 1 );
        }
        
        return;
    }
    
    self gestures::function_b6cc48ed( #"ges_drophand", undefined, 1, undefined, undefined, undefined, 1 );
    time = self getgestureanimlength( #"ges_drophand" );
    wait time - 0.15;
    clientfield::set_to_player( "player_blacklight", 0 );
    a_decals = getentarray( "blacklight_decals_emissive", "targetname" );
    
    foreach ( var_fd5e9fef in a_decals )
    {
        var_fd5e9fef clientfield::set( "render_emissive_blacklight_material", 0 );
    }
    
    level notify( #"blacklight_off" );
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 0
// Checksum 0xe1c41fbb, Offset: 0x6a20
// Size: 0x118
function function_e58f7713()
{
    self endon( #"death" );
    self notify( "2ae8752efe53b53b" );
    self endon( "2ae8752efe53b53b" );
    self notify( #"hash_6ade70a9a975cc1a" );
    waitframe( 1 );
    clientfield::set_to_player( "player_blacklight", 0 );
    a_decals = getentarray( "blacklight_decals_emissive", "targetname" );
    
    foreach ( var_fd5e9fef in a_decals )
    {
        var_fd5e9fef clientfield::set( "render_emissive_blacklight_material", 0 );
    }
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 0, eflags: 0x4
// Checksum 0xd8fef46e, Offset: 0x6b40
// Size: 0x1ae
function private function_82f7d1ba()
{
    level endon( #"blacklight_off" );
    self notify( "4b378ac8b2b5be0f" );
    self endon( "4b378ac8b2b5be0f" );
    a_decals = getentarray( "blacklight_decals_emissive", "targetname" );
    
    while ( true )
    {
        /#
        #/
        
        foreach ( var_fd5e9fef in a_decals )
        {
            if ( var_fd5e9fef sightconetrace( self geteye(), self, anglestoforward( self getplayerangles() ), 10 ) )
            {
                if ( isdefined( var_fd5e9fef.script_noteworthy ) && var_fd5e9fef.script_noteworthy == "button" )
                {
                    level notify( #"found_secret_button" );
                }
                
                if ( isdefined( var_fd5e9fef.script_noteworthy ) && var_fd5e9fef.script_noteworthy == "picture" )
                {
                    level notify( #"found_secret_picture" );
                }
            }
        }
        
        waitframe( 1 );
    }
}

/#

    // Namespace namespace_11998b8f/namespace_11998b8f
    // Params 3
    // Checksum 0xecb62f01, Offset: 0x6cf8
    // Size: 0x20c, Type: dev
    function showcone( angle, range, color )
    {
        self endon( #"death" );
        start = self geteye();
        forward = anglestoforward( self getplayerangles() );
        right = vectorcross( forward, ( 0, 0, 1 ) );
        up = vectorcross( forward, right );
        fullforward = forward * range * cos( angle );
        sideamnt = range * sin( angle );
        prevpoint = ( 0, 0, 0 );
        
        for ( i = 0; i <= 20 ; i++ )
        {
            coneangle = i / 20 * 360;
            point = start + fullforward + sideamnt * ( right * cos( coneangle ) + up * sin( coneangle ) );
            
            if ( i > 0 )
            {
                line( start, point, color, undefined, undefined, 1 );
                line( prevpoint, point, color, undefined, undefined, 1 );
            }
            
            prevpoint = point;
        }
    }

#/

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 2
// Checksum 0x563b4621, Offset: 0x6f10
// Size: 0x8e
function function_638d18a( var_8964d1a4, var_55440d21 )
{
    self endon( #"death" );
    self thread delete_on_flag( var_8964d1a4 );
    wait randomfloat( 0.3 );
    
    while ( true )
    {
        self rotateyaw( 360, var_55440d21 );
        self waittill( #"rotatedone" );
    }
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 1, eflags: 0x4
// Checksum 0xe7f3ebb8, Offset: 0x6fa8
// Size: 0x44
function private delete_on_flag( var_8964d1a4 )
{
    level flag::wait_till( var_8964d1a4 );
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 2
// Checksum 0xb6269691, Offset: 0x6ff8
// Size: 0x168
function function_973a721b( targetname, var_8964d1a4 )
{
    cars = vehicle::simple_spawn_and_drive( targetname );
    
    foreach ( car in cars )
    {
        car thread vehicle::toggle_force_driver_taillights( 1 );
    }
    
    if ( isdefined( var_8964d1a4 ) )
    {
        level flag::wait_till( var_8964d1a4 );
        
        foreach ( car in cars )
        {
            if ( isdefined( car ) )
            {
                car delete();
            }
        }
    }
}

// Namespace namespace_11998b8f/namespace_11998b8f
// Params 2
// Checksum 0x78768c20, Offset: 0x7168
// Size: 0x74
function function_d1c278ab( civilian, *params )
{
    if ( isdefined( params ) && params.targetname == "actor_informant" )
    {
        return;
    }
    
    wait 1;
    level util::missionfailedwrapper( #"hash_d0937a52204cd4e", #"hash_b4302157d22e1af" );
}

