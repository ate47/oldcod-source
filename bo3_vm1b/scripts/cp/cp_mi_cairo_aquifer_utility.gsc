#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_hacking;
#using scripts/cp/_oed;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_aquifer_accolades;
#using scripts/cp/cp_mi_cairo_aquifer_ambience;
#using scripts/cp/cp_mi_cairo_aquifer_fx;
#using scripts/cp/cp_mi_cairo_aquifer_objectives;
#using scripts/cp/cp_mi_cairo_aquifer_sound;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/gametypes/_save;
#using scripts/cp/gametypes/_spawnlogic;
#using scripts/shared/_oob;
#using scripts/shared/ai_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/hud_message_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/player_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_death_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicles/_hunter;
#using scripts/shared/vehicles/_quadtank;

#namespace aquifer_util;

// Namespace aquifer_util
// Params 0, eflags: 0x2
// Checksum 0x981a3b35, Offset: 0x2140
// Size: 0x2a
function autoexec __init__sytem__()
{
    system::register( "aquifer_util", &__init__, undefined, undefined );
}

// Namespace aquifer_util
// Params 0
// Checksum 0x4be69dbb, Offset: 0x2178
// Size: 0x70
function __init__()
{
    init_clientfields();
    anims = [];
    anims[ anims.size ] = %generic::v_aqu_vtol_cockpit_close;
    anims[ anims.size ] = %generic::v_aqu_vtol_cockpit_open;
    anims[ anims.size ] = %generic::v_aqu_vtol_engine_hover;
    anims[ anims.size ] = %generic::v_aqu_vtol_engine_fly;
    anims[ anims.size ] = %generic::v_aqu_vtol_engine_idle;
}

// Namespace aquifer_util
// Params 0
// Checksum 0xc614701e, Offset: 0x21f0
// Size: 0x43a
function init_clientfields()
{
    clientfield::register( "toplayer", "play_body_loop", 1, 1, "int" );
    clientfield::register( "toplayer", "water_motes", 1, 1, "int" );
    clientfield::register( "toplayer", "player_dust_fx", 1, 1, "int" );
    clientfield::register( "toplayer", "player_bubbles_fx", 1, 1, "int" );
    clientfield::register( "toplayer", "player_snow_fx", 1, 1, "int" );
    clientfield::register( "toplayer", "frost_post_fx", 1, 1, "int" );
    clientfield::register( "toplayer", "splash_post_fx", 1, 1, "int" );
    clientfield::register( "toplayer", "highlight_ai", 1, 1, "int" );
    clientfield::register( "actor", "robot_bubbles_fx", 1, 1, "int" );
    clientfield::register( "actor", "kane_bubbles_fx", 1, 1, "int" );
    clientfield::register( "vehicle", "vtol_dogfighting", 1, 1, "int" );
    clientfield::register( "vehicle", "vtol_show_damage_stages", 1, 1, "int" );
    clientfield::register( "vehicle", "vtol_canopy_state", 1, 1, "int" );
    clientfield::register( "vehicle", "vtol_engines_state", 1, 1, "int" );
    clientfield::register( "vehicle", "vtol_enable_wash_fx", 1, 1, "int" );
    clientfield::register( "vehicle", "vtol_damage_state", 1, 2, "int" );
    clientfield::register( "vehicle", "vtol_set_active_landing_zone_num", 1, 4, "int" );
    clientfield::register( "vehicle", "vtol_set_missile_lock_percent", 1, 8, "float" );
    clientfield::register( "vehicle", "vtol_show_missile_lock", 1, 1, "int" );
    clientfield::register( "vehicle", "vtol_screen_shake", 1, 1, "int" );
    clientfield::register( "world", "toggle_fog_banks", 1, 1, "int" );
    clientfield::register( "world", "toggle_pbg_banks", 1, 1, "int" );
    clientfield::register( "clientuimodel", "vehicle.weaponIndex", 1, 2, "int" );
    clientfield::register( "clientuimodel", "vehicle.lockOn", 1, 8, "float" );
    clientfield::register( "clientuimodel", "vehicle.showLandHint", 1, 1, "int" );
    clientfield::register( "clientuimodel", "vehicle.showAimHint", 1, 1, "int" );
    clientfield::register( "clientuimodel", "hackUpload.percent", 1, 8, "float" );
}

// Namespace aquifer_util
// Params 0
// Checksum 0x72c48e58, Offset: 0x2638
// Size: 0x63
function loadeffects()
{
    level._effect[ "boss_explosion" ] = "explosions/fx_exp_generic_lg";
    level._effect[ "boss_disabled" ] = "fire/fx_fire_gas_pipe_china";
    level._effect[ "boss_fire" ] = "fire/fx_fire_floor_lrg";
    level._effect[ "bubbles" ] = "player/fx_plyr_swim_bubbles_body";
}

// Namespace aquifer_util
// Params 0
// Checksum 0x97056e9f, Offset: 0x26a8
// Size: 0x5a
function function_68714b99()
{
    pin = spawn( "script_origin", self.origin );
    self linkto( pin );
    self waittill( #"free_vehicle" );
    pin delete();
}

// Namespace aquifer_util
// Params 0
// Checksum 0xc155003a, Offset: 0x2710
// Size: 0x16a
function function_c2768198()
{
    wait 1;
    exploder::exploder( "lighting_server_perf_lights" );
    exploder::exploder( "lighting_hangar_hallways_perf_lights" );
    exploder::stop_exploder( "lighting_hangar_a" );
    exploder::stop_exploder( "lighting_hangar_b" );
    
    if ( level flag::get( "inside_aquifer" ) )
    {
        exploder::stop_exploder( "lighting_hangar_hallways_perf_lights" );
    }
    
    if ( level flag::exists( "water_room_exit" ) && level flag::get( "water_room_exit" ) )
    {
        exploder::stop_exploder( "lighting_server_perf_lights" );
    }
    
    if ( level flag::exists( "post_breach" ) && level flag::get( "post_breach" ) )
    {
        exploder::exploder( "lighting_hangar_a" );
    }
    
    if ( level flag::exists( "hideout_completed" ) && level flag::get( "hideout_completed" ) )
    {
        exploder::exploder( "lighting_hangar_b" );
    }
}

// Namespace aquifer_util
// Params 0
// Checksum 0x9c03fbc4, Offset: 0x2888
// Size: 0x1a
function function_4dc4bd2c()
{
    self.get_stinger_target_override = &function_a3fd472e;
}

// Namespace aquifer_util
// Params 0
// Checksum 0xa825cf69, Offset: 0x28b0
// Size: 0xed
function function_a3fd472e()
{
    var_4fb2233 = [];
    var_4fb2233[ var_4fb2233.size ] = "res_vtol1_vh";
    var_4fb2233[ var_4fb2233.size ] = "res_vtol2_vh";
    var_4fb2233[ var_4fb2233.size ] = "port_vtol1_vh";
    var_4fb2233[ var_4fb2233.size ] = "port_vtol2_vh";
    target_array = target_getarray();
    
    foreach ( name in var_4fb2233 )
    {
        vtol = getent( name, "targetname" );
        
        if ( isdefined( vtol ) )
        {
            vtol.allowcontinuedlockonafterinvis = 1;
            array::add( target_array, vtol );
        }
    }
    
    return target_array;
}

// Namespace aquifer_util
// Params 1
// Checksum 0xda0147bd, Offset: 0x29a8
// Size: 0xa
function function_716b5d66( activate )
{
    
}

// Namespace aquifer_util
// Params 0
// Checksum 0x7f0a9fcb, Offset: 0x29c0
// Size: 0x55
function function_44287aa3()
{
    while ( true )
    {
        t = trigger::wait_till( "pipe_splash_trig" );
        
        if ( !isdefined( t.who.var_ddcbc2bb ) )
        {
            t.who splash_fx();
        }
    }
}

// Namespace aquifer_util
// Params 0
// Checksum 0xb6761bd0, Offset: 0x2a20
// Size: 0x21
function splash_fx()
{
    if ( !isdefined( self.var_ddcbc2bb ) )
    {
        self.var_ddcbc2bb = 1;
        wait 2;
        self.var_ddcbc2bb = undefined;
    }
}

// Namespace aquifer_util
// Params 3
// Checksum 0x24a0a887, Offset: 0x2a50
// Size: 0xf2
function function_b86ff37e( n_hacking_time, objective, var_d66abd8d )
{
    trig = getent( var_d66abd8d, "targetname" );
    trig.var_611ccff1 = util::init_interactive_gameobject( trig, istring( objective ), &"CP_MI_CAIRO_AQUIFER_OPEN", &function_ee5d34cb );
    trig.var_611ccff1 gameobjects::set_use_time( n_hacking_time );
    trig.var_611ccff1.onbeginuse = &function_eae79770;
    trig.var_611ccff1.onenduse = &function_35e9f08;
    level waittill( #"hash_26700a52" );
    trig.var_611ccff1 gameobjects::disable_object();
}

// Namespace aquifer_util
// Params 1
// Checksum 0xfd463442, Offset: 0x2b50
// Size: 0x1b
function function_ee5d34cb( gameobj )
{
    self notify( #"hacking_complete" );
    level notify( #"hash_26700a52" );
}

// Namespace aquifer_util
// Params 1
// Checksum 0x7a234340, Offset: 0x2b78
// Size: 0x11
function function_eae79770( player )
{
    if ( isdefined( player ) )
    {
    }
}

// Namespace aquifer_util
// Params 3
// Checksum 0x533b9c9, Offset: 0x2b98
// Size: 0x4b
function function_35e9f08( team, player, result )
{
    if ( isdefined( player ) )
    {
        if ( isdefined( result ) && result )
        {
            self.trigger notify( #"hash_ece70538", player );
            level notify( #"hacking_complete", result, player );
        }
    }
}

// Namespace aquifer_util
// Params 0
// Checksum 0x4c3ff70d, Offset: 0x2bf0
// Size: 0x222
function setup_reusable_destructible()
{
    if ( isdefined( level.reusable_destructible ) )
    {
        return;
    }
    
    level.reusable_destructible = 1;
    level flag::wait_till( "player_active_in_level" );
    
    /#
    #/
    
    level._effect[ "fx_server_explosion_destructible" ] = "electric/fx_elec_sparks_burst_blue_fall_amb";
    level._effect[ "fx_lg_explosion_destructible" ] = "explosions/fx_exp_generic_lg";
    level._effect[ "fx_lg_explosion_pillar_destructible" ] = "explosions/fx_exp_generic_lg";
    level._effect[ "fx_med_explosion_room_destructible" ] = "explosions/fx_exp_quadtank_death_sm";
    level._effect[ "fx_glass_destructible" ] = "destruct/fx_dest_ramses_plaza_glass_bldg";
    level._effect[ "fx_glass_explode_destructible" ] = "explosions/fx_exp_phosphorus_prologue";
    level._effect[ "fx_electrical_destructible" ] = "explosions/fx_exp_phosphorus_prologue";
    level._effect[ "fx_electrical_med_destructible" ] = "electric/fx_elec_burst_med_monitor_lotus";
    level._effect[ "fx_lg_steam_destructible" ] = "steam/fx_steam_hpressure_hose_burst_sgen";
    level._effect[ "fx_med_steam_destructible" ] = "steam/fx_steam_hpressure_hose_burst_sgen";
    level._effect[ "fx_lg_water_destructible" ] = "water/fx_water_burst_xxxlrg_far";
    level._effect[ "fx_exlg_water_destructible" ] = "water/fx_water_fall_os_burst_sgen";
    trigs = getentarray( "reusable_destructible", "targetname" );
    var_c08b6e63 = getentarray( "reusable_destructible_players", "targetname" );
    array::thread_all( trigs, &handle_reusable_destructible );
    array::thread_all( var_c08b6e63, &function_dd7031ad );
    var_afe76451 = getentarray( "environment_destructible", "targetname" );
    array::thread_all( var_afe76451, &function_eee6cbf2 );
}

// Namespace aquifer_util
// Params 0
// Checksum 0x430b8dcb, Offset: 0x2e20
// Size: 0x3d
function handle_reusable_destructible()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        self function_cc4d91b( ent );
    }
}

// Namespace aquifer_util
// Params 1
// Checksum 0x6c73ceca, Offset: 0x2e68
// Size: 0x128
function function_cc4d91b( ent )
{
    st = struct::get( self.target, "targetname" );
    fwd = anglestoforward( st.angles );
    up = anglestoup( st.angles );
    
    if ( isdefined( ent.pvtol ) && ent islinkedto( ent.pvtol ) || isdefined( ent ) && isvehicle( ent ) )
    {
        playfx( level._effect[ self.script_noteworthy ], st.origin, fwd, up );
        
        if ( isdefined( self.script_parameters ) && strisint( self.script_parameters ) )
        {
            wait int( self.script_parameters );
            return;
        }
        
        wait 10;
    }
}

// Namespace aquifer_util
// Params 0
// Checksum 0x8862a68e, Offset: 0x2f98
// Size: 0x32
function function_eee6cbf2()
{
    self endon( #"death" );
    self waittill( #"trigger", ent );
    self function_9c6e51f( ent );
}

// Namespace aquifer_util
// Params 1
// Checksum 0x2118636, Offset: 0x2fd8
// Size: 0xd2
function function_9c6e51f( ent )
{
    model = getent( self.target, "targetname" );
    
    if ( isdefined( ent.pvtol ) && ent islinkedto( ent.pvtol ) || isdefined( ent ) && isvehicle( ent ) )
    {
        anims = [];
        anims[ anims.size ] = "p7_fxanim_cp_aqu_radar_array_01";
        anims[ anims.size ] = "p7_fxanim_cp_aqu_radar_array_02";
        rand_anim = array::random( anims );
        model thread scene::play( rand_anim, model );
    }
}

// Namespace aquifer_util
// Params 0
// Checksum 0xa0a13872, Offset: 0x30b8
// Size: 0x6a
function intro_screen()
{
    util::do_chyron_text( &"CP_MI_CAIRO_AQUIFER_INTRO_LINE_2_FULL", "", &"CP_MI_CAIRO_AQUIFER_INTRO_LINE_3_FULL", &"CP_MI_CAIRO_AQUIFER_INTRO_LINE_3_SHORT", &"CP_MI_CAIRO_AQUIFER_INTRO_LINE_4_FULL", &"CP_MI_CAIRO_AQUIFER_INTRO_LINE_4_SHORT", &"CP_MI_CAIRO_AQUIFER_INTRO_LINE_5_FULL", &"CP_MI_CAIRO_AQUIFER_INTRO_LINE_5_SHORT" );
    level flag::set( "intro_chryon_done" );
}

// Namespace aquifer_util
// Params 0
// Checksum 0x7840c64a, Offset: 0x3130
// Size: 0xa2
function player_underwater()
{
    self endon( #"disconnect" );
    self endon( #"death" );
    
    while ( !level flag::get( "flag_khalil_water_exit" ) )
    {
        if ( self isplayerunderwater() && !( isdefined( self.is_underwater ) && self.is_underwater ) )
        {
            self clientfield::set_to_player( "water_motes", 1 );
        }
        else
        {
            self clientfield::set_to_player( "water_motes", 0 );
        }
        
        wait 0.5;
    }
    
    self clientfield::set_to_player( "water_motes", 0 );
}

// Namespace aquifer_util
// Params 0
// Checksum 0x44d32ed9, Offset: 0x31e0
// Size: 0x10a
function function_a05f9e55()
{
    self endon( #"disconnect" );
    self endon( #"death" );
    self.var_a66e492f = 0;
    
    while ( !level flag::get( "inside_aquifer" ) )
    {
        if ( self isinvehicle() || self isplayerunderwater() || level flag::get( "inside_data_center" ) || level flag::get( "flag_force_off_dust" ) )
        {
            if ( self.var_a66e492f )
            {
                self clientfield::set_to_player( "player_dust_fx", 0 );
                self.var_a66e492f = 0;
            }
        }
        else if ( !self.var_a66e492f )
        {
            self clientfield::set_to_player( "player_dust_fx", 1 );
            self.var_a66e492f = 1;
        }
        
        wait 0.5;
    }
    
    self clientfield::set_to_player( "player_dust_fx", 0 );
    self.var_a66e492f = 0;
}

// Namespace aquifer_util
// Params 0
// Checksum 0xa169ac5, Offset: 0x32f8
// Size: 0xca
function function_3de8b7b4()
{
    self endon( #"disconnect" );
    self endon( #"death" );
    level flag::wait_till( "flag_snow_room" );
    self clientfield::set_to_player( "player_snow_fx", 1 );
    self playsound( "evt_dni_glitch" );
    self playloopsound( "evt_snowverlay" );
    wait 5;
    level flag::wait_till_clear( "flag_snow_room" );
    self clientfield::set_to_player( "player_snow_fx", 0 );
    self stoploopsound( 1 );
    self playsound( "evt_dni_delusion_outro" );
}

// Namespace aquifer_util
// Params 0
// Checksum 0xa65fd0a0, Offset: 0x33d0
// Size: 0xf3
function function_dd7031ad()
{
    self endon( #"death" );
    st = struct::get( self.target, "targetname" );
    fwd = anglestoforward( st.angles );
    up = anglestoup( st.angles );
    
    while ( true )
    {
        self waittill( #"trigger" );
        playfx( level._effect[ self.script_noteworthy ], st.origin, fwd, up );
        
        if ( isdefined( self.script_parameters ) && strisint( self.script_parameters ) )
        {
            wait int( self.script_parameters );
            continue;
        }
        
        wait 5;
    }
}

// Namespace aquifer_util
// Params 2
// Checksum 0x9485c20b, Offset: 0x34d0
// Size: 0x72
function function_db077321( section, rate )
{
    if ( !isdefined( level.var_ef297e7c ) )
    {
        level.var_ef297e7c = [];
    }
    
    if ( !isdefined( level.var_ef297e7c[ section ] ) )
    {
        level.var_ef297e7c[ section ] = spawnstruct();
        level.var_ef297e7c[ section ].play_rate = rate;
        level.var_ef297e7c[ section ].branches = [];
    }
}

// Namespace aquifer_util
// Params 3
// Checksum 0xcdd7eb6f, Offset: 0x3550
// Size: 0x4a
function function_8b84bb6c( section, var_26e12fb, rate )
{
    function_db077321( section, rate );
    array::add( level.var_ef297e7c[ section ].branches, var_26e12fb, 0 );
}

// Namespace aquifer_util
// Params 0
// Checksum 0x85172eb8, Offset: 0x35a8
// Size: 0x21d
function function_11a9191()
{
    rowcount = tablelookuprowcount( "gamedata/tables/cp/cp_dogfightPaths.csv" );
    
    for ( row = 1; row < rowcount ; row++ )
    {
        section = tolower( tablelookupcolumnforrow( "gamedata/tables/cp/cp_dogfightPaths.csv", row, 1 ) );
        rate = float( tablelookupcolumnforrow( "gamedata/tables/cp/cp_dogfightPaths.csv", row, 2 ) );
        
        if ( !isdefined( section ) && section != "" )
        {
            continue;
        }
        
        var_cff394b4 = 3;
        branch = tolower( tablelookupcolumnforrow( "gamedata/tables/cp/cp_dogfightPaths.csv", row, var_cff394b4 ) );
        
        for ( var_ddc5eafb = float( tablelookupcolumnforrow( "gamedata/tables/cp/cp_dogfightPaths.csv", row, var_cff394b4 + 1 ) ); isdefined( branch ) && branch != "" ; var_ddc5eafb = float( tablelookupcolumnforrow( "gamedata/tables/cp/cp_dogfightPaths.csv", row, var_cff394b4 + 1 ) ) )
        {
            if ( !isdefined( var_ddc5eafb ) )
            {
                var_ddc5eafb = 0;
            }
            
            var_26e12fb = spawnstruct();
            var_26e12fb.branch = branch;
            var_26e12fb.var_ddc5eafb = var_ddc5eafb / getanimlength( branch );
            function_8b84bb6c( section, var_26e12fb, rate );
            var_cff394b4 += 2;
            branch = tolower( tablelookupcolumnforrow( "gamedata/tables/cp/cp_dogfightPaths.csv", row, var_cff394b4 ) );
        }
    }
}

// Namespace aquifer_util
// Params 0
// Checksum 0x2be1f04e, Offset: 0x37d0
// Size: 0x23a
function function_c7676d36()
{
    self endon( #"death" );
    self endon( #"bug_out" );
    self ghost();
    self notsolid();
    self setcontents( 0 );
    self clientfield::set( "vtol_dogfighting", 0 );
    self.dying = 1;
    self notify( #"dying" );
    self.dogfighter weaponlockfree();
    wait 0.5;
    self notify( #"slow_dogfight" );
    self.dogfighter.pvtol setvehicletype( "veh_bo3_mil_vtol_fighter_player_dogfight_slow" );
    wait 3.5;
    self.chain_dogfight = 1;
    self notify( #"chain_dogfight" );
    self.dogfighter.pvtol setvehicletype( "veh_bo3_mil_vtol_fighter_player_dogfight" );
    
    if ( !isdefined( self.var_3ae26974 ) )
    {
        self waittill( #"hash_3ae26974" );
    }
    
    self.dogfighter weaponlockstart( self.var_3ae26974 );
    wait 0.05;
    
    while ( self.var_c63462fd != self.var_3ae26974.var_c63462fd || !( isdefined( self.var_3c6a99b9 ) && self.var_3c6a99b9 ) && distancesquared( self.origin, self.var_3ae26974.origin ) > 14400 && self getanimtime( self.var_c63462fd ) < self.var_3ae26974 getanimtime( self.var_3ae26974.var_c63462fd ) )
    {
        wait 0.05;
    }
    
    self notify( #"switch_targets" );
    wait 0.05;
    self.do_scripted_crash = 0;
    self kill( self.origin, self.dogfighter );
    wait 0.1;
    self delete();
}

// Namespace aquifer_util
// Params 0
// Checksum 0xbe9e2312, Offset: 0x3a18
// Size: 0x82
function function_cb795cc3()
{
    self endon( #"death" );
    self endon( #"bug_out" );
    self endon( #"dying" );
    wait 12;
    
    if ( isdefined( self.dogfighter ) )
    {
        if ( self.var_d4f48128 <= 1 )
        {
            self.dogfighter function_fe19b920( "props" );
            return;
        }
        
        wait 8;
        
        if ( isdefined( self.dogfighter ) )
        {
            self.dogfighter function_fe19b920( "props" );
        }
    }
}

// Namespace aquifer_util
// Params 0
// Checksum 0xf6b84aa7, Offset: 0x3aa8
// Size: 0x495
function function_78e66c54()
{
    self endon( #"death" );
    self endon( #"bug_out" );
    self.health = 100000;
    self.maxhealth = self.health;
    self.var_d4f48128 = 0;
    var_b1e0b5bc = self.var_d4f48128;
    var_cdfde28c = 3;
    var_3c794781 = 1;
    var_c357667 = [];
    var_c357667[ 0 ] = 10;
    var_c357667[ 1 ] = 20;
    var_c357667[ 2 ] = 10;
    
    switch ( getlocalprofileint( "g_gameskill" ) )
    {
        case 0:
            var_3c794781 = 0.333;
            var_c357667[ 0 ] = 5;
            var_c357667[ 1 ] = 10;
            var_c357667[ 2 ] = 5;
            break;
        case 2:
            var_c357667[ 0 ] = 15;
            var_c357667[ 1 ] = 25;
            var_c357667[ 2 ] = 10;
            break;
        case 3:
            var_c357667[ 0 ] = 20;
            var_c357667[ 1 ] = 30;
            var_c357667[ 2 ] = 10;
            break;
        case 4:
            var_c357667[ 0 ] = 25;
            var_c357667[ 1 ] = 35;
            var_c357667[ 2 ] = 10;
            break;
    }
    
    var_fa51bc25 = 0;
    var_29fc3405 = 0;
    self clientfield::set( "vtol_show_damage_stages", 1 );
    
    while ( isdefined( self ) && isalive( self ) )
    {
        self waittill( #"damage", damage, attacker, dir, loc, type, model, tag, part, weapon, flags );
        
        if ( isdefined( self.dogfighter ) && attacker == self.dogfighter )
        {
            var_94bdacf3 = 0;
            
            if ( issubstr( type, "BULLET" ) )
            {
                var_fa51bc25++;
                
                if ( var_fa51bc25 >= var_c357667[ self.var_d4f48128 ] )
                {
                    self.var_d4f48128++;
                    var_fa51bc25 = 0;
                }
            }
            else if ( issubstr( type, "PROJECTILE" ) )
            {
                self.var_c12a181e = 1;
                var_29fc3405++;
                
                if ( var_29fc3405 >= var_3c794781 )
                {
                    self.var_d4f48128 = self.var_d4f48128 + int( var_29fc3405 / var_3c794781 );
                    var_fa51bc25 = 0;
                    var_29fc3405 = 0;
                }
            }
            
            if ( self.var_d4f48128 != var_b1e0b5bc )
            {
                self.var_d4f48128 = math::clamp( self.var_d4f48128, 0, var_cdfde28c );
                self setdamagestage( self.var_d4f48128 );
                self util::clientnotify( "damage_stage_changed" );
                var_b1e0b5bc = self.var_d4f48128;
            }
            
            if ( self.var_d4f48128 >= var_cdfde28c )
            {
                if ( !isdefined( self.dogfighter.var_3dca6783 ) )
                {
                    self.dogfighter.var_3dca6783 = 0;
                }
                
                self.dogfighter.var_3dca6783++;
                self.dogfighter function_78d2c721( "fire" );
                self.dogfighter function_78d2c721( "nolock" );
                self.dogfighter function_78d2c721( "lock" );
                self.dogfighter function_78d2c721( "props" );
                self.dogfighter function_fe19b920( "killed" );
                playsoundatposition( "evt_vehicle_explosion_lyr", self.origin );
                self thread function_c7676d36();
                
                if ( !isdefined( self.var_c12a181e ) )
                {
                    self.dogfighter aquifer_accolades::function_c27610f9( "aq_dogfight_kill_only_guns" );
                }
                
                return;
            }
            else if ( self.var_d4f48128 > 1 )
            {
                self.dogfighter function_78d2c721( "props" );
            }
        }
        
        self.health = self.maxhealth;
    }
}

// Namespace aquifer_util
// Params 6
// Checksum 0x7d3a943f, Offset: 0x3f48
// Size: 0x5d5
function function_14f37b59( section, start_time, dogfighter, var_eb969a93, spawner, root )
{
    if ( !isdefined( spawner ) )
    {
        if ( isdefined( dogfighter ) && isdefined( dogfighter.player_num ) )
        {
            spawner = "flight_path_spawner" + dogfighter.player_num;
        }
        else
        {
            spawner = "flight_path_spawner1";
        }
    }
    
    veh = vehicle::simple_spawn_single( spawner );
    veh useanimtree( $generic );
    veh.animtree = "generic";
    veh.crashtype = "explode";
    veh thread function_78e66c54();
    veh clientfield::set( "vtol_dogfighting", 1 );
    
    if ( !isdefined( level.dogfight_targets ) )
    {
        level.dogfight_targets = [];
    }
    
    level.dogfight_targets[ level.dogfight_targets.size ] = veh;
    
    if ( !isdefined( section ) )
    {
        section = array::random( getarraykeys( level.var_ef297e7c ) );
    }
    
    lerp_time = 0.2;
    
    if ( !isdefined( root ) )
    {
        root = getent( "dogfighting_scene", "targetname" );
    }
    
    if ( !isdefined( start_time ) )
    {
        start_time = 0;
    }
    
    veh animation::teleport( section, root, undefined, start_time );
    
    if ( isdefined( dogfighter ) )
    {
        dogfighter.var_1d195e2c = veh;
    }
    
    if ( !isdefined( var_eb969a93 ) )
    {
        var_eb969a93 = 1;
    }
    
    play_rate = level.var_ef297e7c[ section ].play_rate * var_eb969a93;
    
    while ( true )
    {
        veh.var_c63462fd = section;
        veh thread animation::play( section, root, undefined, play_rate, 0, 0, lerp_time, start_time );
        time = max( 0.05, floor( getanimlength( section ) * ( 1 - start_time ) / 0.05 ) * 0.05 - lerp_time ) / play_rate;
        start_time = 0;
        ret = veh util::waittill_any_timeout( time, "death", "bug_out", "slow_dogfight", "chain_dogfight", "beginning_dogfight" );
        
        if ( ret == "slow_dogfight" )
        {
            var_eb969a93 = 0.7;
            play_rate *= var_eb969a93;
            lerp_time = 0;
            start_time = veh getanimtime( section );
            continue;
        }
        else if ( ret == "chain_dogfight" )
        {
            var_eb969a93 = 1.1;
            play_rate = level.var_ef297e7c[ section ].play_rate * var_eb969a93;
            lerp_time = 0;
            start_time = veh getanimtime( section );
            continue;
        }
        else if ( ret == "beginning_dogfight" )
        {
            var_eb969a93 = 1;
            play_rate = level.var_ef297e7c[ section ].play_rate;
            lerp_time = 0;
            start_time = veh getanimtime( section );
            continue;
        }
        else if ( ret != "timeout" )
        {
            arrayremovevalue( level.dogfight_targets, veh );
            return;
        }
        
        var_7ba7c005 = section;
        
        if ( isdefined( veh.var_3ae26974 ) && isdefined( veh.var_3ae26974.var_c63462fd ) )
        {
            section = veh.var_3ae26974.var_c63462fd;
            
            if ( section == var_7ba7c005 )
            {
                veh.var_3c6a99b9 = 1;
                arrayremovevalue( level.dogfight_targets, veh );
                return;
            }
            else
            {
                foreach ( branch in level.var_ef297e7c[ var_7ba7c005 ].branches )
                {
                    if ( branch.branch == section )
                    {
                        start_time = branch.var_ddc5eafb;
                        break;
                    }
                }
            }
        }
        else
        {
            var_26e12fb = array::random( level.var_ef297e7c[ section ].branches );
            section = var_26e12fb.branch;
            start_time = var_26e12fb.var_ddc5eafb;
        }
        
        play_rate = level.var_ef297e7c[ section ].play_rate * var_eb969a93;
        lerp_time = 0.2 * var_eb969a93;
        
        /#
            if ( getdvarint( "<dev string:x28>" ) > 0 )
            {
                start_pos = getstartorigin( root.origin, root.angles, section, start_time );
                
                if ( distancesquared( veh.origin, start_pos ) > 1000000 )
                {
                    assertmsg( "<dev string:x3c>" + var_7ba7c005 + "<dev string:x6a>" + section + "<dev string:x6f>" );
                }
            }
        #/
    }
}

// Namespace aquifer_util
// Params 0
// Checksum 0xd7271c50, Offset: 0x4528
// Size: 0x22a
function function_3ed8bf0e()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self waittill( #"hash_b4a5f622" );
    self.var_b55ae1ed = 0;
    
    if ( isdefined( self.var_1d195e2c ) )
    {
        self.var_1d195e2c notify( #"bug_out" );
        self.var_1d195e2c.var_8a707c29 = 1;
        
        if ( !( isdefined( self.var_1d195e2c.dying ) && self.var_1d195e2c.dying ) && isalive( self.var_1d195e2c ) )
        {
            self.var_1d195e2c setdamagestage( 3 );
            self.var_1d195e2c util::clientnotify( "damage_stage_changed" );
        }
        
        wait 0.1;
        
        if ( isdefined( self.var_1d195e2c ) && isalive( self.var_1d195e2c ) )
        {
            self.var_1d195e2c delete();
        }
        
        self.var_1d195e2c = undefined;
    }
    
    wait 1.5;
    target = undefined;
    
    if ( isdefined( self function_a9d982da() ) )
    {
        target = self function_a9d982da();
        target notify( #"bug_out" );
        target.var_8a707c29 = 1;
        
        if ( !( isdefined( target.dying ) && target.dying ) && isalive( target ) )
        {
            target setdamagestage( 3 );
            target util::clientnotify( "damage_stage_changed" );
        }
    }
    
    self.pvtol clientfield::set( "vtol_dogfighting", 0 );
    self thread function_cc401f5c();
    wait 0.1;
    
    if ( isdefined( target ) && isalive( target ) )
    {
        target delete();
    }
}

// Namespace aquifer_util
// Params 1
// Checksum 0x1662f545, Offset: 0x4760
// Size: 0x33f
function function_c5a27940( var_84fe82cd )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"hash_b4a5f622" );
    var_852345b1 = 2;
    self thread function_3ed8bf0e();
    self.var_b55ae1ed = 1;
    
    while ( !isdefined( self function_a9d982da() ) )
    {
        wait 0.05;
    }
    
    self.var_1d195e2c = undefined;
    
    while ( isdefined( self function_a9d982da() ) )
    {
        target = self function_a9d982da();
        target thread function_cb795cc3();
        ret = target util::waittill_any_return( "chain_dogfight", "death" );
        section = target.var_c63462fd;
        var_7a591ed2 = 0;
        timeleft = var_852345b1;
        animtime = target getanimtime( section );
        animlength = getanimlength( section );
        var_7a591ed2 = animlength * ( 1 - animtime );
        start_time = animtime;
        
        while ( var_7a591ed2 < timeleft )
        {
            timeleft -= var_7a591ed2;
            var_26e12fb = array::random( level.var_ef297e7c[ section ].branches );
            section = var_26e12fb.branch;
            start_time = var_26e12fb.var_ddc5eafb;
            animlength = getanimlength( section );
            var_7a591ed2 = animlength;
        }
        
        start_time += timeleft / animlength;
        self.var_1d195e2c = undefined;
        
        if ( level flagsys::get( "dogfight_ending" ) || level flag::get( var_84fe82cd ) )
        {
            level notify( #"dogfight_finished" );
            self notify( #"hash_b4a5f622" );
        }
        
        thread function_14f37b59( section, start_time, self, 0.7 );
        
        while ( !isdefined( self.var_1d195e2c ) )
        {
            wait 0.05;
        }
        
        target.var_3ae26974 = self.var_1d195e2c;
        target notify( #"hash_3ae26974" );
        
        if ( ret != "death" )
        {
            target util::waittill_any( "death", "switch_targets" );
        }
        
        self setvehiclefocusentity( self.var_1d195e2c );
        self.var_1d195e2c.dogfighter = self;
        self.var_1d195e2c notify( #"beginning_dogfight" );
        self.var_1d195e2c = undefined;
        
        while ( self function_a9d982da() == target )
        {
            wait 0.05;
        }
    }
    
    if ( level flagsys::get( "dogfight_ending" ) || level flag::get( var_84fe82cd ) )
    {
        level notify( #"dogfight_finished" );
        self notify( #"hash_b4a5f622" );
    }
}

/#

    // Namespace aquifer_util
    // Params 1
    // Checksum 0x9484ac8f, Offset: 0x4aa8
    // Size: 0x25, Type: dev
    function function_a99964bc( section )
    {
        while ( true )
        {
            function_14f37b59( section );
        }
    }

    // Namespace aquifer_util
    // Params 0
    // Checksum 0x74fa2262, Offset: 0x4ad8
    // Size: 0xa3, Type: dev
    function function_dbe3d86f()
    {
        sections = [];
        sections[ sections.size ] = "<dev string:xa2>";
        sections[ sections.size ] = "<dev string:xb5>";
        sections[ sections.size ] = "<dev string:xc8>";
        sections[ sections.size ] = "<dev string:xdb>";
        
        foreach ( section in sections )
        {
            thread function_a99964bc( section );
        }
    }

#/

// Namespace aquifer_util
// Params 0
// Checksum 0x3d095e49, Offset: 0x4b88
// Size: 0x802
function function_e9a25955()
{
    self endon( #"disconnect" );
    self endon( #"death" );
    var_522698b3 = getent( "dogfighting_scene", "targetname" );
    radius = 10000;
    var_dda84f1a = getentarray( "landing_zone_1", "script_noteworthy" );
    self thread fixup_heightmap_on_use( 1 );
    height = self.pvtol getheliheightlockheight( ( var_522698b3.origin[ 0 ], var_522698b3.origin[ 1 ], var_dda84f1a[ 0 ].origin[ 2 ] ) );
    self.pvtol clientfield::set( "vtol_dogfighting", 0 );
    self clientfield::set_player_uimodel( "vehicle.lockOn", 0 );
    self.pvtol clientfield::set( "vtol_set_missile_lock_percent", 0 );
    self flagsys::clear( "dogfighting" );
    
    if ( abs( height - self.pvtol.origin[ 2 ] ) > 2500 || distance2dsquared( var_522698b3.origin, self.pvtol.origin ) > radius * radius || velocity_to_mph( self.pvtol getvelocity() ) > 50 )
    {
        self.pvtol setvehicletype( "veh_bo3_mil_vtol_fighter_player_dogfight_slow" );
        var_c30a0e54 = ( var_522698b3.origin[ 0 ], var_522698b3.origin[ 1 ], height );
        veh = vehicle::simple_spawn_single( "flight_path_spawner" + self.player_num );
        veh ghost();
        veh notsolid();
        veh setcontents( 0 );
        veh dontinterpolate();
        
        if ( self flagsys::get( "dogfighting" ) )
        {
            veh.origin = self function_a9d982da().origin;
            veh.angles = self function_a9d982da().angles;
        }
        else
        {
            to_player = vectornormalize( self.origin - var_c30a0e54 );
            var_d768f7b8 = anglestoforward( self.pvtol.angles );
            
            if ( vectordot( to_player, var_d768f7b8 ) < 0 )
            {
                veh.origin = self.pvtol.origin + var_d768f7b8 * 7500;
                veh.angles = self.pvtol.angles;
            }
            else
            {
                var_51aed079 = vectortoangles( to_player );
                side_dir = anglestoright( var_51aed079 );
                
                if ( vectordot( side_dir, var_d768f7b8 ) < 0 )
                {
                    side_dir *= -1;
                }
                
                veh.origin = self.pvtol.origin + side_dir * 7500;
                veh.angles = vectortoangles( side_dir );
            }
        }
        
        self setvehiclefocusentity( veh );
        self.pvtol sethelidogfighting( 1 );
        var_c6f525f9 = 0;
        
        while ( distancesquared( var_c30a0e54, veh.origin ) > radius * radius || isdefined( self ) && isdefined( self.pvtol ) && velocity_to_mph( self.pvtol getvelocity() ) > 50 )
        {
            height = self.pvtol getheliheightlockheight( ( veh.origin[ 0 ], veh.origin[ 1 ], var_dda84f1a[ 0 ].origin[ 2 ] ) );
            var_c30a0e54 = ( var_522698b3.origin[ 0 ], var_522698b3.origin[ 1 ], height );
            desired_origin = var_c30a0e54 + vectornormalize( ( veh.origin[ 0 ], veh.origin[ 1 ], height ) - var_c30a0e54 ) * radius * 0.9;
            speed_scale = pow( math::clamp( distance( veh.origin, desired_origin ) / 2400, 0, 1 ), 2 );
            desired_angles = vectortoangles( desired_origin - veh.origin );
            desired_yaw = angleclamp180( desired_angles[ 1 ] );
            var_e8e62a06 = angleclamp180( desired_angles[ 0 ] );
            yaw_diff = angleclamp180( desired_yaw - veh.angles[ 1 ] );
            var_cd190041 = angleclamp180( var_e8e62a06 - veh.angles[ 0 ] );
            veh.angles = ( angleclamp180( veh.angles[ 0 ] ) + math::clamp( var_cd190041, -2.25, 2.25 ), angleclamp180( veh.angles[ 1 ] ) + math::clamp( yaw_diff, -2.25, 2.25 ), veh.angles[ 2 ] * 0.9 );
            veh.origin += anglestoforward( veh.angles ) * 300 * 17.6 * speed_scale * 0.05;
            
            if ( speed_scale < 0.5 && !var_c6f525f9 )
            {
                self.pvtol clientfield::set( "vtol_engines_state", 0 );
                var_c6f525f9 = 1;
                self playsoundtoplayer( "veh_vtol_engage_lr", self );
            }
            
            wait 0.05;
        }
        
        if ( isdefined( self ) )
        {
            self setvehiclefocusentity( undefined );
        }
        
        veh delete();
    }
    else
    {
        self setvehiclefocusentity( undefined );
    }
    
    self allowads( 1 );
}

// Namespace aquifer_util
// Params 0
// Checksum 0x7fb0b78e, Offset: 0x5398
// Size: 0x15a
function function_cc401f5c()
{
    self endon( #"disconnect" );
    self endon( #"death" );
    
    if ( !( isdefined( self.var_9749d396 ) && self.var_9749d396 ) )
    {
        self.var_9749d396 = 1;
        self function_e9a25955();
        self.pvtol sethelidogfighting( 0 );
        self oob::disableplayeroob( 0 );
        self.pvtol vehicle::god_off();
        self.pvtol setvehicletype( "veh_bo3_mil_vtol_fighter_player_agile" );
        self clientfield::set_player_uimodel( "vehicle.weaponIndex", 1 );
        self thread fixup_heightmap_on_use( 1 );
        self flagsys::clear( "dogfighting" );
        self.pvtol clientfield::set( "vtol_dogfighting", 0 );
        self.pvtol clientfield::set( "vtol_engines_state", 0 );
        self.pvtol vehdriveraimatcrosshairs( 1 );
        self.pvtol cleartargetentity();
        self.var_9749d396 = 0;
    }
}

// Namespace aquifer_util
// Params 0
// Checksum 0x7f72f9a4, Offset: 0x5500
// Size: 0x4d
function function_c375b495()
{
    self endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"vtol_exit" );
    
    while ( self function_5c971cb7() )
    {
        self waittill( #"oob_enter" );
        self function_cc401f5c();
    }
}

// Namespace aquifer_util
// Params 0
// Checksum 0x1b64c816, Offset: 0x5558
// Size: 0x3c5
function function_73d90572()
{
    self endon( #"disconnect" );
    self endon( #"death" );
    self.missile_target = undefined;
    var_3e14ed79 = 5;
    
    while ( self function_5c971cb7() )
    {
        veh_weapon = self.pvtol seatgetweapon( 1 );
        
        if ( !self flagsys::get( "dogfighting" ) && !( isdefined( self.var_9749d396 ) && self.var_9749d396 ) && isdefined( veh_weapon ) && !self.pvtol flagsys::get( "scriptedanim" ) )
        {
            best_target = undefined;
            enemies = getaiteamarray( "axis" );
            enemies = arraycombine( enemies, getvehicleteamarray( "axis" ), 0, 0 );
            fov = 63;
            
            if ( self util::is_ads() )
            {
                fov = 24;
            }
            
            best_target_angle = fov;
            var_350b74ea = veh_weapon.lockonmaxrange * veh_weapon.lockonmaxrange;
            
            foreach ( enemy in enemies )
            {
                if ( isvehicle( enemy ) && isalive( enemy ) )
                {
                    enemy_pos = enemy gettagorigin( "tag_body" );
                    angle_diff = vectortoangles( enemy_pos - self getplayercamerapos() ) - self getplayerangles();
                    angle_diff = ( absangleclamp180( angle_diff[ 0 ] ), absangleclamp180( angle_diff[ 1 ] ), 0 );
                    angle_diff_avg = ( angle_diff[ 0 ] + angle_diff[ 1 ] ) / 2;
                    dist = distancesquared( self geteye(), enemy_pos );
                    
                    if ( ( isdefined( self.missile_target ) && enemy == self.missile_target || angle_diff_avg <= best_target_angle ) && angle_diff[ 0 ] <= fov && angle_diff[ 1 ] <= fov && dist <= var_350b74ea && target_isincircle( enemy, self, fov, veh_weapon.lockonradius ) && bullettracepassed( self getplayercamerapos(), enemy_pos, 0, self.pvtol, enemy, 1 ) )
                    {
                        best_target = enemy;
                        best_target_angle = angle_diff_avg;
                        
                        if ( isdefined( self.missile_target ) && enemy == self.missile_target )
                        {
                            best_target_angle -= var_3e14ed79;
                            
                            if ( best_target_angle <= 0 )
                            {
                                break;
                            }
                        }
                    }
                }
            }
            
            if ( isdefined( best_target ) )
            {
                if ( !isdefined( self.missile_target ) || self.missile_target != best_target )
                {
                    self.missile_target = best_target;
                    self weaponlockstart( best_target );
                }
            }
            else
            {
                self.missile_target = undefined;
                self weaponlockfree();
            }
        }
        
        wait 0.05;
    }
}

// Namespace aquifer_util
// Params 0
// Checksum 0x48e516fb, Offset: 0x5928
// Size: 0x62
function vtol_hud()
{
    self endon( #"disconnect" );
    self clientfield::set_to_player( "highlight_ai", 1 );
    self util::waittill_any( "vtol_starting_landing", "vtol_exit", "death" );
    self clientfield::set_to_player( "highlight_ai", 0 );
}

// Namespace aquifer_util
// Params 0
// Checksum 0x36203c14, Offset: 0x5998
// Size: 0x167
function function_d2db9d30()
{
    self endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"vtol_exit" );
    var_5f6c4b = 2500;
    var_f29ae186 = 4;
    var_6b1c0c6 = 0;
    
    if ( !isdefined( self.var_cf011976 ) )
    {
        self.var_cf011976 = [];
        
        for ( i = 0; i < var_f29ae186 ; i++ )
        {
            self.var_cf011976[ i ] = 0;
        }
    }
    
    while ( true )
    {
        var_b5ef1165 = 0;
        
        for ( i = 0; i < var_f29ae186 ; i++ )
        {
            if ( self.var_cf011976[ i ] < self.var_cf011976[ var_b5ef1165 ] )
            {
                var_b5ef1165 = i;
            }
        }
        
        if ( self.var_cf011976[ var_b5ef1165 ] > gettime() )
        {
            self.pvtol disablegunnerfiring( var_6b1c0c6, 1 );
            wait ( self.var_cf011976[ var_b5ef1165 ] - gettime() ) / 1000;
            self.pvtol disablegunnerfiring( var_6b1c0c6, 0 );
        }
        
        gunner_index = -1;
        
        while ( gunner_index != var_6b1c0c6 )
        {
            self.pvtol waittill( #"gunner_weapon_fired", gunner_index, missile );
            self thread function_6174aaa2( missile );
        }
        
        self.var_cf011976[ var_b5ef1165 ] = gettime() + var_5f6c4b;
    }
}

// Namespace aquifer_util
// Params 1
// Checksum 0xa4163295, Offset: 0x5b08
// Size: 0x252
function function_6174aaa2( missile )
{
    if ( self flagsys::get( "dogfighting" ) && ( !isdefined( missile ) || isdefined( missile missile_gettarget() ) ) )
    {
        return;
    }
    
    target = self function_a9d982da();
    offset = ( 0, 0, 0 );
    var_3c972657 = undefined;
    
    if ( self flagsys::get( "dogfighting" ) || isdefined( target ) && isdefined( missile missile_gettarget() ) )
    {
        if ( self flagsys::get( "dogfighting" ) )
        {
            missile setweapon( getweapon( "vtol_fighter_player_dogfight_unlocked_missile_turret" ) );
            var_3c972657 = 0.75;
        }
        
        if ( !isalive( target ) )
        {
            return;
        }
        
        if ( isvehicle( target ) )
        {
            offset = target gettagorigin( "tag_body" ) - target.origin;
        }
        
        missile missile_settarget( target, offset );
    }
    else
    {
        var_3c972657 = 0.5;
        trace = bullettrace( self getplayercamerapos(), self getplayercamerapos() + anglestoforward( self getplayerangles() ) * 10000, 1, self, 0, 0, self.pvtol );
        target_origin = spawn( "script_origin", trace[ "position" ] );
        missile missile_settarget( target_origin );
    }
    
    if ( isdefined( var_3c972657 ) )
    {
        wait var_3c972657;
        
        if ( isdefined( missile ) )
        {
            missile missile_settarget( undefined );
        }
        
        if ( isdefined( target_origin ) )
        {
            target_origin delete();
        }
    }
}

// Namespace aquifer_util
// Params 1
// Checksum 0x3ca76565, Offset: 0x5d68
// Size: 0x6a
function function_fe19b920( type )
{
    if ( array::contains( getarraykeys( self.var_d60b48f3 ), type ) )
    {
        self.var_861efedd[ type ] = gettime();
        self notify( #"dogfight_vo_added" );
        return;
    }
    
    assertmsg( type + "<dev string:xee>" );
}

// Namespace aquifer_util
// Params 1
// Checksum 0x1edcf57e, Offset: 0x5de0
// Size: 0x2a
function function_78d2c721( type )
{
    self.var_861efedd = array::remove_index( self.var_861efedd, type, 1 );
}

// Namespace aquifer_util
// Params 0
// Checksum 0x8c225bfb, Offset: 0x5e18
// Size: 0x59b
function function_f3ec4eac()
{
    self.var_d60b48f3 = [];
    self.var_d60b48f3[ "nolock" ] = [];
    self.var_d60b48f3[ "lock" ] = [];
    self.var_d60b48f3[ "fire" ] = [];
    self.var_d60b48f3[ "killed" ] = [];
    self.var_d60b48f3[ "incoming" ] = [];
    self.var_d60b48f3[ "warning" ] = [];
    self.var_d60b48f3[ "banter" ] = [];
    self.var_d60b48f3[ "props" ] = [];
    self.var_d60b48f3[ "nolock" ][ self.var_d60b48f3[ "nolock" ].size ] = "kane_they_re_too_fast_yo_0";
    self.var_d60b48f3[ "nolock" ][ self.var_d60b48f3[ "nolock" ].size ] = "kane_you_need_a_lock_on_0";
    self.var_d60b48f3[ "lock" ][ self.var_d60b48f3[ "lock" ].size ] = "plyr_i_ve_got_him_painted_0";
    self.var_d60b48f3[ "lock" ][ self.var_d60b48f3[ "lock" ].size ] = "plyr_i_ve_got_good_tone_0";
    self.var_d60b48f3[ "lock" ][ self.var_d60b48f3[ "lock" ].size ] = "plyr_sights_locked_0";
    self.var_d60b48f3[ "lock" ][ self.var_d60b48f3[ "lock" ].size ] = "plyr_target_painted_0";
    self.var_d60b48f3[ "fire" ][ self.var_d60b48f3[ "fire" ].size ] = "plyr_missile_away_0";
    self.var_d60b48f3[ "fire" ][ self.var_d60b48f3[ "fire" ].size ] = "plyr_firing_0";
    self.var_d60b48f3[ "killed" ][ self.var_d60b48f3[ "killed" ].size ] = "plyr_target_down_0";
    self.var_d60b48f3[ "killed" ][ self.var_d60b48f3[ "killed" ].size ] = "plyr_bogey_neutralized_0";
    self.var_d60b48f3[ "killed" ][ self.var_d60b48f3[ "killed" ].size ] = "plyr_bandit_destroyed_0";
    self.var_d60b48f3[ "killed" ][ self.var_d60b48f3[ "killed" ].size ] = "plyr_target_splashed_0";
    self.var_d60b48f3[ "killed" ][ self.var_d60b48f3[ "killed" ].size ] = "plyr_good_night_0";
    self.var_d60b48f3[ "incoming" ][ self.var_d60b48f3[ "incoming" ].size ] = "kane_we_ve_got_more_bandi_0";
    self.var_d60b48f3[ "incoming" ][ self.var_d60b48f3[ "incoming" ].size ] = "kane_you_ve_got_two_more_0";
    self.var_d60b48f3[ "incoming" ][ self.var_d60b48f3[ "incoming" ].size ] = "kane_i_ve_got_visuals_on_0";
    self.var_d60b48f3[ "incoming" ][ self.var_d60b48f3[ "incoming" ].size ] = "kane_radar_s_picking_up_m_0";
    self.var_d60b48f3[ "warning" ][ self.var_d60b48f3[ "warning" ].size ] = "kane_watch_that_ground_fi_0";
    self.var_d60b48f3[ "warning" ][ self.var_d60b48f3[ "warning" ].size ] = "kane_that_was_close_watc_0";
    self.var_d60b48f3[ "warning" ][ self.var_d60b48f3[ "warning" ].size ] = "kane_keep_em_off_the_egy_0";
    self.var_d60b48f3[ "warning" ][ self.var_d60b48f3[ "warning" ].size ] = "plyr_watch_the_fire_from_0";
    self.var_d60b48f3[ "banter" ][ self.var_d60b48f3[ "banter" ].size ] = "kane_having_trouble_shaki_0";
    self.var_d60b48f3[ "banter" ][ self.var_d60b48f3[ "banter" ].size ] = "kane_pulling_hard_right_0";
    self.var_d60b48f3[ "banter" ][ self.var_d60b48f3[ "banter" ].size ] = "plyr_i_m_coming_around_t_0";
    self.var_d60b48f3[ "banter" ][ self.var_d60b48f3[ "banter" ].size ] = "kane_i_m_in_the_weeds_pu_0";
    self.var_d60b48f3[ "banter" ][ self.var_d60b48f3[ "banter" ].size ] = "plyr_we_can_out_maneuver_0";
    self.var_d60b48f3[ "banter" ][ self.var_d60b48f3[ "banter" ].size ] = "kane_i_m_going_to_swing_a_0";
    self.var_d60b48f3[ "props" ][ self.var_d60b48f3[ "props" ].size ] = "plyr_these_guys_know_how_0";
    self.var_d60b48f3[ "props" ][ self.var_d60b48f3[ "props" ].size ] = "plyr_this_guy_s_good_0";
    keys = getarraykeys( self.var_d60b48f3 );
    
    foreach ( key in keys )
    {
        self.var_d60b48f3[ key ] = array::randomize( self.var_d60b48f3[ key ] );
    }
}

// Namespace aquifer_util
// Params 0
// Checksum 0x9386f47b, Offset: 0x63c0
// Size: 0x1cb
function function_35142384()
{
    if ( !isdefined( self.var_740cbab7 ) )
    {
        self.var_740cbab7 = [];
        self.var_e9c4f888 = [];
        keys = getarraykeys( self.var_d60b48f3 );
        
        foreach ( key in keys )
        {
            self.var_740cbab7[ key ] = spawnstruct();
            self.var_740cbab7[ key ].var_61e9af10 = 0;
            self.var_740cbab7[ key ].last_time = 0;
            var_41f3bc5c = 15;
            timeout_time = 3;
            var_aa9634bb = 1;
            
            switch ( key )
            {
                case "fire":
                case "lock":
                    var_41f3bc5c = 15;
                    timeout_time = 1;
                    var_aa9634bb = 0;
                    break;
                case "nolock":
                    var_41f3bc5c = 5;
                    timeout_time = 2.5;
                    var_aa9634bb = 0;
                    break;
                case "killed":
                    var_41f3bc5c = 5;
                    timeout_time = 1;
                    var_aa9634bb = 0;
                    break;
                default:
                    var_41f3bc5c = 30;
                    timeout_time = 10;
                    var_aa9634bb = 0;
                    break;
            }
            
            self.var_740cbab7[ key ].var_41f3bc5c = var_41f3bc5c;
            self.var_740cbab7[ key ].timeout_time = timeout_time;
            
            if ( var_aa9634bb )
            {
                self.var_e9c4f888[ self.var_e9c4f888.size ] = key;
            }
        }
    }
}

// Namespace aquifer_util
// Params 0
// Checksum 0x40ba03ce, Offset: 0x6598
// Size: 0xb3
function function_4b6c1d1b()
{
    types = getarraykeys( self.var_861efedd );
    
    foreach ( type in types )
    {
        if ( ( gettime() - self.var_861efedd[ type ] ) / 1000 > self.var_740cbab7[ type ].timeout_time )
        {
            self.var_861efedd = array::remove_index( self.var_861efedd, type, 1 );
        }
    }
}

// Namespace aquifer_util
// Params 1
// Checksum 0xc9a64713, Offset: 0x6658
// Size: 0x302
function function_a7d6fd77( var_27114ecf )
{
    var_4031190e = undefined;
    self function_4b6c1d1b();
    types = getarraykeys( self.var_861efedd );
    
    foreach ( type in types )
    {
        if ( self.var_740cbab7[ type ].last_time <= 0 || ( gettime() - self.var_740cbab7[ type ].last_time ) / 1000 > self.var_740cbab7[ type ].var_41f3bc5c )
        {
            var_4031190e = type;
            self.var_861efedd = array::remove_index( self.var_861efedd, type, 1 );
            break;
        }
    }
    
    if ( !isdefined( var_4031190e ) && !( isdefined( var_27114ecf ) && var_27114ecf ) )
    {
        var_5f2cda7b = [];
        
        foreach ( type in self.var_e9c4f888 )
        {
            if ( self.var_740cbab7[ type ].last_time <= 0 || ( gettime() - self.var_740cbab7[ type ].last_time ) / 1000 > self.var_740cbab7[ type ].var_41f3bc5c )
            {
                var_5f2cda7b[ var_5f2cda7b.size ] = type;
            }
        }
        
        var_4031190e = array::random( var_5f2cda7b );
    }
    
    if ( isdefined( var_4031190e ) )
    {
        vo = self.var_d60b48f3[ var_4031190e ][ self.var_740cbab7[ var_4031190e ].var_61e9af10 ];
        
        if ( strstartswith( vo, "plyr" ) )
        {
            self dialog::player_say( vo, 0 );
        }
        else
        {
            level dialog::remote( vo, 0, "dni", self );
        }
        
        self.var_740cbab7[ var_4031190e ].last_time = gettime();
        self.var_740cbab7[ var_4031190e ].var_61e9af10++;
        self.var_740cbab7[ var_4031190e ].var_41f3bc5c *= 1.1;
        
        if ( self.var_740cbab7[ var_4031190e ].var_61e9af10 >= self.var_d60b48f3[ var_4031190e ].size )
        {
            self.var_740cbab7[ var_4031190e ].var_61e9af10 = 0;
            self.var_740cbab7[ var_4031190e ].var_41f3bc5c *= 2;
        }
        
        return;
    }
    
    wait 0.05;
}

// Namespace aquifer_util
// Params 0
// Checksum 0x3787cfa, Offset: 0x6968
// Size: 0x183
function function_a1c2d8ac()
{
    self endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"hash_b4a5f622" );
    level endon( #"hash_982117a3" );
    self function_f3ec4eac();
    self function_35142384();
    self.var_861efedd = [];
    var_f5789fb5 = 2.5;
    var_33533e17 = 5;
    
    while ( self function_5c971cb7() )
    {
        self waittill( #"dogfighting" );
        level flagsys::wait_till_clear( "dogfight_intro_dialog" );
        last_time = gettime();
        
        for ( wait_time = randomfloatrange( var_f5789fb5, var_33533e17 ); self flagsys::get( "dogfighting" ) ; wait_time = randomfloatrange( var_f5789fb5, var_33533e17 ) )
        {
            ret = util::waittill_any_timeout( max( 0.05, wait_time - ( gettime() - last_time ) / 1000 ), "dogfight_vo_added" );
            
            if ( !self flagsys::get( "dogfighting" ) )
            {
                continue;
            }
            
            self function_a7d6fd77( ret != "timeout" );
            last_time = gettime();
        }
    }
}

// Namespace aquifer_util
// Params 0
// Checksum 0xbad7ade0, Offset: 0x6af8
// Size: 0x72
function function_a9d982da()
{
    target = self getvehiclefocusentity();
    
    if ( isdefined( target.dying ) && isdefined( target ) && target.dying )
    {
        target = target.var_3ae26974;
    }
    else if ( !self flagsys::get( "dogfighting" ) )
    {
        target = self.missile_target;
    }
    
    return target;
}

// Namespace aquifer_util
// Params 0
// Checksum 0x53b46f88, Offset: 0x6b78
// Size: 0x30a
function function_3e5c7ab3()
{
    self endon( #"disconnect" );
    self endon( #"death" );
    last_target = undefined;
    lock_time = 0;
    
    while ( self function_5c971cb7() )
    {
        focus_ent = self function_a9d982da();
        veh_weapon = self.pvtol seatgetweapon( 0 );
        lockonspeed = veh_weapon.lockonspeed / 1000;
        
        if ( isdefined( focus_ent.vehicleclass ) && ( isdefined( focus_ent.vehicleclass ) && focus_ent.vehicleclass == "plane" || isdefined( focus_ent ) && focus_ent.vehicleclass == "helicopter" ) && focus_ent flagsys::get( "scriptedanim" ) && !focus_ent ishidden() )
        {
            if ( !isdefined( last_target ) || focus_ent != last_target )
            {
                last_target = focus_ent;
                lock_time = 0;
                self.pvtol vehdriveraimatcrosshairs( 1 );
                self.pvtol cleartargetentity();
            }
            else if ( target_isincircle( last_target, self, 30, veh_weapon.lockonradius ) && distancesquared( last_target gettagorigin( "tag_body" ), self.pvtol.origin ) < veh_weapon.lockonmaxrange * veh_weapon.lockonmaxrange )
            {
                lock_time += 0.05;
            }
            else
            {
                lock_time -= 0.05;
            }
        }
        else if ( isdefined( last_target ) )
        {
            last_target = undefined;
            lock_time = 0;
            self.pvtol vehdriveraimatcrosshairs( 1 );
            self.pvtol cleartargetentity();
        }
        
        lock_time = math::clamp( lock_time, 0, lockonspeed );
        
        if ( isdefined( last_target ) )
        {
            if ( lock_time >= lockonspeed )
            {
                self.pvtol vehdriveraimatcrosshairs( 0 );
                self.pvtol settargetentity( last_target );
            }
            else
            {
                self.pvtol vehdriveraimatcrosshairs( 1 );
                self.pvtol cleartargetentity();
            }
        }
        
        wait 0.05;
    }
    
    if ( isdefined( self.pvtol ) )
    {
        self.pvtol vehdriveraimatcrosshairs( 1 );
        self.pvtol cleartargetentity();
    }
}

// Namespace aquifer_util
// Params 0
// Checksum 0xdd718e26, Offset: 0x6e90
// Size: 0x56d
function vtol_monitor_missile_lock()
{
    self endon( #"disconnect" );
    self endon( #"death" );
    last_target = undefined;
    lock_time = 0;
    var_a9e2f7e7 = 0;
    button_held = 0;
    self clientfield::set_player_uimodel( "vehicle.lockOn", 0 );
    self.pvtol clientfield::set( "vtol_set_missile_lock_percent", 0 );
    self thread function_d2db9d30();
    
    while ( self function_5c971cb7() )
    {
        if ( self.pvtol flagsys::get( "scriptedanim" ) )
        {
            wait 0.05;
            continue;
        }
        
        veh_weapon = self.pvtol seatgetweapon( 1 );
        lockonspeed = veh_weapon.lockonspeed / 1000;
        target = self function_a9d982da();
        skill = getlocalprofileint( "g_gameskill" );
        lockonspeed += skill - 1;
        
        if ( lockonspeed <= 0 )
        {
            lockonspeed = 0.5;
        }
        
        fov = 63;
        
        if ( self flagsys::get( "dogfighting" ) )
        {
            fov = 30;
        }
        else if ( self util::is_ads() )
        {
            fov = 24;
        }
        
        if ( isdefined( target ) && isvehicle( target ) && !target ishidden() )
        {
            if ( !isdefined( last_target ) || target != last_target )
            {
                last_target = target;
                self weaponlockstart( target );
                lock_time = 0;
                var_a9e2f7e7 = 0;
            }
            else if ( target_isincircle( last_target, self, fov, veh_weapon.lockonradius ) && distancesquared( last_target gettagorigin( "tag_body" ), self.pvtol.origin ) < veh_weapon.lockonmaxrange * veh_weapon.lockonmaxrange )
            {
                lock_time += 0.05;
            }
            else
            {
                lock_time -= 0.05;
            }
        }
        else if ( isdefined( last_target ) || lock_time > 0 )
        {
            self weaponlockfree();
            last_target = undefined;
            lock_time = 0;
            var_a9e2f7e7 = 0;
        }
        
        if ( isdefined( last_target ) )
        {
            if ( !var_a9e2f7e7 && !button_held && self flagsys::get( "dogfighting" ) && self.pvtol isgunnerfiring( 0 ) )
            {
                function_fe19b920( "nolock" );
            }
            else if ( var_a9e2f7e7 && !button_held && self.pvtol isgunnerfiring( 0 ) && self flagsys::get( "dogfighting" ) )
            {
                self weaponlockfree();
                self weaponlockstart( last_target );
                lock_time *= 0.75;
                var_a9e2f7e7 = 0;
                button_held = 1;
                self function_78d2c721( "lock" );
                self function_fe19b920( "fire" );
            }
            else if ( bullettracepassed( self getplayercamerapos(), last_target gettagorigin( "tag_body" ), 0, self.pvtol, last_target, 1 ) )
            {
                if ( lock_time >= lockonspeed )
                {
                    self weaponlockfinalize( target );
                    var_a9e2f7e7 = 1;
                    self function_fe19b920( "lock" );
                }
            }
            else if ( self flagsys::get( "dogfighting" ) )
            {
                lock_time -= 0.05;
            }
            
            if ( button_held && !self.pvtol isgunnerfiring( 0 ) )
            {
                button_held = 0;
            }
        }
        
        if ( var_a9e2f7e7 )
        {
            lock_time = lockonspeed;
            var_943fec4e = 1;
        }
        else
        {
            lock_time = math::clamp( lock_time, 0, lockonspeed );
            var_943fec4e = lock_time / lockonspeed;
        }
        
        if ( isdefined( self.doingnotify ) && self.doingnotify )
        {
            self clientfield::set_player_uimodel( "vehicle.lockOn", 0 );
        }
        else
        {
            self clientfield::set_player_uimodel( "vehicle.lockOn", var_943fec4e );
        }
        
        self.pvtol clientfield::set( "vtol_set_missile_lock_percent", var_943fec4e );
        wait 0.05;
    }
}

// Namespace aquifer_util
// Params 1
// Checksum 0xf53521a8, Offset: 0x7408
// Size: 0x351
function function_3034fbb( new_state )
{
    if ( isdefined( self.pvtol.state ) )
    {
        switch ( self.pvtol.state )
        {
            case "autopilot":
                self.pvtol show();
                self.pvtol solid();
                self.pvtol stopanimscripted( 0 );
                self.pvtol clientfield::set( "vtol_enable_wash_fx", 0 );
                self.pvtol notify( #"reset_damage_state" );
                break;
            case "landing_mode":
                self.pvtol clientfield::set( "vtol_set_active_landing_zone_num", 0 );
                self clientfield::set_player_uimodel( "vehicle.showLandHint", 0 );
                break;
            case "call":
                if ( isdefined( new_state ) && new_state != "enter" )
                {
                    self.pvtol clientfield::set( "vtol_canopy_state", 0 );
                    self.pvtol clientfield::set( "vtol_enable_wash_fx", 0 );
                }
                
                self.pvtol cleartargetyaw();
                self.pvtol clearvehgoalpos();
                self.pvtol stopanimscripted( 0 );
                break;
            case "enter":
                self.pvtol clientfield::set( "vtol_canopy_state", 0 );
                self.pvtol clientfield::set( "vtol_enable_wash_fx", 0 );
                
                if ( self flagsys::get( "scriptedanim" ) && !isdefined( self.current_scene ) && !isdefined( self.current_player_scene ) )
                {
                    self thread animation::stop();
                }
                
                break;
            case "exit":
                if ( isdefined( self.var_6f5c6fa1 ) && self.var_6f5c6fa1 && self flagsys::get( "scriptedanim" ) && !isdefined( self.current_scene ) && !isdefined( self.current_player_scene ) )
                {
                    self thread animation::stop();
                }
                
                break;
            case "piloted":
                if ( new_state != "landing_mode" )
                {
                    self clientfield::set_player_uimodel( "vehicle.lockOn", 0 );
                    self.pvtol clientfield::set( "vtol_set_missile_lock_percent", 0 );
                    self.pvtol clientfield::set( "vtol_show_missile_lock", 0 );
                    self weaponlockfree();
                }
                
                self.ignoreme = 0;
                break;
            default:
                break;
        }
    }
}

// Namespace aquifer_util
// Params 4
// Checksum 0xd3b134e9, Offset: 0x7768
// Size: 0x242
function function_22a0413d( new_state, var_b3dc65a3, var_41d4f668, var_67d770d1 )
{
    self function_d683f26a();
    
    if ( isdefined( new_state ) )
    {
        if ( isdefined( self.pvtol.state ) && new_state == self.pvtol.state && new_state != "exit" && new_state != "landing_mode" )
        {
            return;
        }
        
        if ( new_state == "autopilot" || new_state == "enter" || function_5c971cb7() && new_state == "call" )
        {
            return;
        }
        
        if ( !function_5c971cb7() && new_state == "landing_mode" )
        {
            return;
        }
        
        self.pvtol notify( #"hash_c38e4003" );
        self function_3034fbb( new_state );
        
        switch ( new_state )
        {
            case "autopilot":
                self thread function_2b89d912( var_b3dc65a3 );
                break;
            case "landing_mode":
                self thread function_fc017a35();
                break;
            case "call":
                self thread function_e34692a9( var_b3dc65a3, var_41d4f668, var_67d770d1 );
                break;
            case "enter":
                self thread function_e1fcf95( var_b3dc65a3, var_41d4f668 );
                break;
            case "exit":
                self thread vtol_exit( var_b3dc65a3, var_41d4f668, var_67d770d1 );
                break;
            case "piloted":
                self thread function_8bb76a9( var_b3dc65a3, 0 );
                break;
            default:
                self thread function_8bb76a9( var_b3dc65a3, 1 );
                break;
            case "idle":
                self.pvtol.state = "idle";
                break;
        }
        
        return;
    }
    
    self.pvtol notify( #"hash_c38e4003" );
    self function_3034fbb();
    
    if ( !self function_5c971cb7() )
    {
        self thread function_8bb76a9( undefined, 0 );
    }
}

// Namespace aquifer_util
// Params 4
// Checksum 0x739c2107, Offset: 0x79b8
// Size: 0x93
function function_191fff49( state, var_b3dc65a3, var_41d4f668, var_67d770d1 )
{
    level.var_4063f562 = state;
    
    foreach ( player in level.activeplayers )
    {
        player thread function_22a0413d( state, var_b3dc65a3, var_41d4f668, var_67d770d1 );
    }
}

// Namespace aquifer_util
// Params 0
// Checksum 0x2c4c70d9, Offset: 0x7a58
// Size: 0x101
function function_e3fab6a1()
{
    var_dda84f1a = getentarray( "landing_zone_player_" + self.player_num, "targetname" );
    var_72ae61b3 = undefined;
    
    foreach ( landing_zone in var_dda84f1a )
    {
        if ( !isdefined( var_72ae61b3 ) )
        {
            var_72ae61b3 = landing_zone;
            var_a0d5844a = distancesquared( self.origin, var_72ae61b3.origin );
            continue;
        }
        
        dist = distancesquared( self.origin, landing_zone.origin );
        
        if ( dist < var_a0d5844a )
        {
            var_72ae61b3 = landing_zone;
            var_a0d5844a = dist;
        }
    }
    
    return var_72ae61b3;
}

// Namespace aquifer_util
// Params 1
// Checksum 0xcc44c55f, Offset: 0x7b68
// Size: 0x3a
function function_1215f9e4( index )
{
    if ( !isdefined( level.var_b91023ce ) )
    {
        level.var_b91023ce = [];
    }
    
    array::add( level.var_b91023ce, index, 0 );
}

// Namespace aquifer_util
// Params 1
// Checksum 0xf4597214, Offset: 0x7bb0
// Size: 0x2a
function function_e1e437cb( index )
{
    if ( isdefined( level.var_b91023ce ) )
    {
        arrayremovevalue( level.var_b91023ce, index );
    }
}

// Namespace aquifer_util
// Params 0
// Checksum 0xf982958b, Offset: 0x7be8
// Size: 0xa
function function_fc653485()
{
    level.var_b91023ce = [];
}

// Namespace aquifer_util
// Params 2
// Checksum 0xae8b3ca, Offset: 0x7c00
// Size: 0xc2
function function_5739554b( var_e8e62a06, time )
{
    self endon( #"death" );
    self notify( #"hash_5739554b" );
    self endon( #"hash_5739554b" );
    start_time = time;
    start_pitch = self.angles[ 0 ];
    
    do
    {
        time -= 0.05;
        self.angles = ( start_pitch + ( var_e8e62a06 - start_pitch ) * ( start_time - time ) / start_time, self.angles[ 1 ], self.angles[ 2 ] );
        wait 0.05;
    }
    while ( isdefined( self ) && time > 0 );
    
    if ( isdefined( self ) )
    {
        self.angles = ( var_e8e62a06, self.angles[ 1 ], self.angles[ 2 ] );
    }
}

// Namespace aquifer_util
// Params 3
// Checksum 0x843fee32, Offset: 0x7cd0
// Size: 0x4da
function function_e34692a9( zone, teleport, var_acaabf08 )
{
    if ( !isdefined( var_acaabf08 ) )
    {
        var_acaabf08 = 1;
    }
    
    self endon( #"disconnect" );
    self.pvtol endon( #"hash_c38e4003" );
    var_74df67ae = -1;
    goal_height = 120;
    
    if ( isdefined( zone ) )
    {
        var_74df67ae = zone;
        var_dda84f1a = getentarray( "landing_zone_" + zone, "script_noteworthy" );
        
        foreach ( landing_zone in var_dda84f1a )
        {
            if ( landing_zone.targetname === "landing_zone_player_" + self.player_num )
            {
                var_72ae61b3 = landing_zone;
                break;
            }
        }
    }
    else
    {
        var_72ae61b3 = self function_e3fab6a1();
    }
    
    if ( isdefined( var_72ae61b3 ) )
    {
        if ( isdefined( teleport ) && teleport )
        {
            self.pvtol.origin = var_72ae61b3.origin + ( 0, 0, goal_height );
            self.pvtol.angles = var_72ae61b3.angles;
            self.pvtol dontinterpolate();
            wait 0.05;
        }
        else
        {
            if ( isdefined( self.var_719c336f ) && self.var_719c336f > 0.05 )
            {
                self.pvtol ghost();
                wait self.var_719c336f;
                self.var_719c336f = undefined;
                self.pvtol show();
            }
            
            anim_rate = 1;
            
            if ( isdefined( self.var_23a61090 ) )
            {
                anim_rate = self.var_23a61090;
            }
            
            self.pvtol clientfield::set( "vtol_engines_state", 1 );
            self.pvtol thread animation::play( "v_aqu_vtol_land_enter", var_72ae61b3.origin, var_72ae61b3.angles, anim_rate, 0, 0.01, 0 );
            self.pvtol waittillmatch( #"v_aqu_vtol_land_enter", "wash_fx" );
            self.pvtol clientfield::set( "vtol_enable_wash_fx", 1 );
            self.pvtol waittillmatch( #"v_aqu_vtol_land_enter", "open_canopy" );
            self.pvtol clientfield::set( "vtol_canopy_state", 1 );
            self.pvtol waittillmatch( #"v_aqu_vtol_land_enter", "end" );
            self.pvtol stopanimscripted( 0 );
            self.pvtol clientfield::set( "vtol_engines_state", 0 );
            self.pvtol setvehgoalpos( var_72ae61b3.origin + ( 0, 0, 120 ), 1 );
            self.pvtol settargetyaw( var_72ae61b3.angles[ 1 ] );
            self.pvtol setspeed( 25, 25, 25 );
            self.pvtol setyawspeed( 59, 360, 360 );
            self.pvtol sethoverparams( 28, 24, 24 );
        }
    }
    
    if ( !var_acaabf08 && self isplayinganimscripted() )
    {
        while ( self isplayinganimscripted() )
        {
            wait 0.05;
        }
    }
    else
    {
        self thread function_e267ae99();
        
        while ( !isalive( self ) || !self isonground() || self laststand::player_is_in_laststand() || distance2dsquared( self.origin, self.pvtol gettagorigin( "tag_driver_camera" ) ) > 62500 )
        {
            wait 0.05;
        }
    }
    
    self thread function_22a0413d( "enter", var_acaabf08, var_74df67ae );
}

// Namespace aquifer_util
// Params 2
// Checksum 0x16d031bb, Offset: 0x81b8
// Size: 0x552
function function_e1fcf95( play_anim, var_74df67ae )
{
    self endon( #"disconnect" );
    self endon( #"death" );
    self.pvtol endon( #"hash_c38e4003" );
    
    if ( self function_5c971cb7() )
    {
        return;
    }
    
    self.pvtol.state = "enter";
    self.pvtol clientfield::set( "vtol_set_active_landing_zone_num", 0 );
    self enableinvulnerability();
    self.pvtol endon( #"death" );
    
    if ( isdefined( play_anim ) && play_anim )
    {
        self.pvtol vehicle::god_on();
        self.pvtol sethoverparams( 0 );
        self.pvtol setspeedimmediate( 0.01 );
        self.pvtol setspeed( 0.01, 100, 100 );
        self.pvtol setyawspeed( 0.01, 100, 100 );
        self.pvtol clearvehgoalpos();
        self.pvtol cleartargetyaw();
        angle_diff = angleclamp180( self.pvtol.angles[ 1 ] - vectortoangles( self.origin - self.pvtol gettagorigin( "tag_driver_camera" ) )[ 1 ] );
        side = "r";
        
        if ( angle_diff < 0 )
        {
            side = "l";
            angle_diff *= -1;
        }
        
        angle = 90;
        
        if ( angle_diff < 5 )
        {
            angle = 0;
        }
        else if ( angle_diff < 15 )
        {
            angle = 15;
        }
        else if ( angle_diff < 45 )
        {
            angle = 45;
        }
        
        var_c94a0984 = "r";
        
        if ( angle >= 45 && side == "l" )
        {
            var_c94a0984 = "l";
        }
        
        anim_name = "pb_aqu_vtol_enter_jump_start_" + side;
        self thread animation::play( anim_name, self.origin, self.angles, 1, 0.2, 0, 0.2 );
        self waittillmatch( anim_name, "end" );
        mover_ent = spawn( "script_model", self.origin );
        mover_ent setmodel( "tag_origin" );
        mover_ent.angles = self.angles;
        mover_ent dontinterpolate();
        var_8f8a1689 = "pb_aqu_vtol_enter_" + angle + "_" + var_c94a0984;
        
        if ( angle == 0 )
        {
            var_8f8a1689 = "pb_aqu_vtol_enter";
        }
        
        target_origin = getstartorigin( self.pvtol.origin, self.pvtol.angles, var_8f8a1689 );
        target_angles = getstartangles( self.pvtol.origin, self.pvtol.angles, var_8f8a1689 );
        anim_name = "pb_aqu_vtol_enter_jump_loop_" + var_c94a0984;
        lerp_time = 0.5;
        anim_time = getanimlength( anim_name );
        anim_rate = anim_time / lerp_time;
        self thread animation::play( anim_name, mover_ent, "tag_origin", anim_rate, 0.2, 0, 0 );
        mover_ent moveto( target_origin, lerp_time, 0, 0 );
        mover_ent rotateto( target_angles, lerp_time, 0, 0 );
        wait lerp_time - 0.05;
        self thread animation::play( var_8f8a1689, self.pvtol, "tag_origin", 1, 0.2, 0.1, 0, 0, 0, 0 );
        self waittillmatch( var_8f8a1689, "end" );
        self playsoundtoplayer( "veh_vtol_close", self );
        mover_ent delete();
        self.pvtol vehicle::god_off();
    }
    
    self thread function_22a0413d( "piloted", var_74df67ae );
}

// Namespace aquifer_util
// Params 0
// Checksum 0x84b71498, Offset: 0x8718
// Size: 0x145
function function_e267ae99()
{
    self endon( #"death" );
    self endon( #"hash_8923fa32" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( player != self )
            {
                if ( player istouching( self.pvtol ) )
                {
                    a_spawn_points = spawnlogic::get_all_spawn_points( 1 );
                    var_39f734b7 = arraygetclosest( player.origin, a_spawn_points );
                    var_b2577cba = var_39f734b7.origin;
                    var_b2577cba = player player::get_snapped_spot_origin( var_b2577cba );
                    player setorigin( var_b2577cba );
                    
                    if ( isdefined( var_39f734b7.angles ) )
                    {
                        player setplayerangles( var_39f734b7.angles );
                    }
                }
            }
        }
        
        wait 0.05;
    }
}

// Namespace aquifer_util
// Params 1
// Checksum 0xad118c1, Offset: 0x8868
// Size: 0x32
function function_f924d730( time )
{
    self endon( #"disconnect" );
    self endon( #"death" );
    self.ignoreme = 1;
    wait time;
    self.ignoreme = 0;
}

// Namespace aquifer_util
// Params 2
// Checksum 0xdf455b6, Offset: 0x88a8
// Size: 0x2a2
function function_8bb76a9( var_74df67ae, scripted )
{
    self endon( #"disconnect" );
    self endon( #"death" );
    self.pvtol endon( #"hash_c38e4003" );
    self function_a65d16ff();
    self enableinvulnerability();
    
    if ( !( isdefined( scripted ) && scripted ) )
    {
        self.pvtol.state = "piloted";
        self.pvtol clientfield::set( "vtol_show_missile_lock", 1 );
        
        if ( !( isdefined( self.var_1b9475b4 ) && self.var_1b9475b4 ) )
        {
            self thread function_a1c2d8ac();
            self thread function_73d90572();
            self thread function_3e5c7ab3();
            self thread vtol_monitor_missile_lock();
            self thread vtol_hud();
            self thread function_c10544f();
            self thread function_c375b495();
            self.var_1b9475b4 = 1;
        }
        
        self.pvtol returnplayercontrol();
        self.pvtol disabledriverfiring( 0 );
        self.pvtol disablegunnerfiring( 0, 0 );
        self allowads( 1 );
        self.my_heightmap = "none";
        self.pvtol setheliheightlock( 1 );
        self thread fixup_heightmap_on_use( 1 );
        
        if ( isdefined( var_74df67ae ) )
        {
            level notify( #"vtol_takeoff", self, var_74df67ae );
        }
        
        self notify( #"vtol_takeoff" );
        self thread function_e351b3d6();
        self thread function_f924d730( 3 );
    }
    else
    {
        self.pvtol.state = "scripted";
        self.pvtol takeplayercontrol();
        self.pvtol disabledriverfiring( 1 );
        self.pvtol disablegunnerfiring( 0, 1 );
        self allowads( 0 );
    }
    
    if ( isdefined( level.var_4063f562 ) && level.var_4063f562 == "landing_mode" )
    {
        self thread function_22a0413d( "landing_mode" );
    }
}

// Namespace aquifer_util
// Params 0
// Checksum 0x50eda5af, Offset: 0x8b58
// Size: 0x17
function function_e351b3d6()
{
    self endon( #"death" );
    wait 3;
    self notify( #"hash_8923fa32" );
}

// Namespace aquifer_util
// Params 0
// Checksum 0xf573be26, Offset: 0x8b78
// Size: 0x1ca
function function_a65d16ff()
{
    self function_d683f26a();
    
    if ( !self function_5c971cb7() )
    {
        self.pvtol makevehicleusable();
        org = self.pvtol gettagorigin( "tag_driver_camera" );
        ang = self.pvtol gettagangles( "tag_driver_camera" );
        self setorigin( org );
        self setplayerangles( ( 0, ang[ 1 ], 0 ) );
        self.pvtol usevehicle( self, 0 );
        self.pvtol makevehicleunusable();
        self.pvtol thread audio::sndupdatevehiclecontext( 1 );
        self.var_32218fc7 = 1;
        level notify( #"disable_cybercom", self, 1 );
        self.b_tactical_mode_enabled = 0;
        self.b_enhanced_vision_enabled = 0;
        self oed::tmode_activate_on_player( 0 );
        self oed::ev_activate_on_player( 0 );
    }
    
    self.pvtol show();
    self clientfield::set_player_uimodel( "vehicle.weaponIndex", 1 );
    self clientfield::set_player_uimodel( "vehicle.lockOn", 0 );
    setsaveddvar( "bulletrange", 15000 );
    self setthreatbiasgroup( "players_vtol" );
}

// Namespace aquifer_util
// Params 1
// Checksum 0x58d13e9e, Offset: 0x8d50
// Size: 0x142
function function_c0fa671d( var_dda84f1a )
{
    self endon( #"disconnect" );
    self endon( #"death" );
    self.pvtol endon( #"hash_c38e4003" );
    self endon( #"vtol_starting_landing" );
    show_hint = 0;
    var_42d92efd = 0;
    
    while ( self function_5c971cb7() && !self flagsys::get( "vtol_force_land" ) )
    {
        show_hint = 0;
        
        foreach ( landing_zone in var_dda84f1a )
        {
            if ( distance2dsquared( self.pvtol.origin, landing_zone.origin ) < 1000000 )
            {
                show_hint = 1;
                break;
            }
        }
        
        if ( var_42d92efd != show_hint )
        {
            self clientfield::set_player_uimodel( "vehicle.showLandHint", show_hint );
            var_42d92efd = show_hint;
        }
        
        wait 0.05;
    }
    
    self clientfield::set_player_uimodel( "vehicle.showLandHint", 0 );
}

// Namespace aquifer_util
// Params 0
// Checksum 0xf027a98, Offset: 0x8ea0
// Size: 0x59
function function_f513fb82()
{
    self endon( #"disconnect" );
    self endon( #"death" );
    self.pvtol endon( #"hash_c38e4003" );
    
    while ( !self util::use_button_held() && !self flagsys::get( "vtol_force_land" ) )
    {
        wait 0.05;
    }
}

// Namespace aquifer_util
// Params 0
// Checksum 0xabff617f, Offset: 0x8f08
// Size: 0x66d
function function_fc017a35()
{
    self endon( #"disconnect" );
    self endon( #"death" );
    self.pvtol endon( #"hash_c38e4003" );
    self.pvtol.state = "landing_mode";
    var_2aff5bd5 = [];
    var_77637fea = getentarray( "landing_zone", "targetname" );
    var_3403f039 = 0;
    
    foreach ( landing_zone in var_77637fea )
    {
        if ( isdefined( landing_zone.script_noteworthy ) )
        {
            index = int( landing_zone.script_noteworthy );
            
            if ( array::contains( level.var_b91023ce, index ) )
            {
                var_2aff5bd5[ var_2aff5bd5.size ] = landing_zone;
                var_3403f039 += pow( 2, index - 1 );
            }
        }
    }
    
    self thread function_c0fa671d( var_2aff5bd5 );
    self.pvtol clientfield::set( "vtol_set_active_landing_zone_num", int( var_3403f039 ) );
    
    while ( self function_5c971cb7() )
    {
        self function_f513fb82();
        
        foreach ( landing_zone in var_2aff5bd5 )
        {
            if ( distance2dsquared( self.pvtol.origin, landing_zone.origin ) < 1000000 )
            {
                savegame::checkpoint_save();
                var_cd4db992 = -1;
                self.pvtol clientfield::set( "vtol_enable_wash_fx", 1 );
                
                if ( isdefined( landing_zone.script_noteworthy ) )
                {
                    var_cd4db992 = int( landing_zone.script_noteworthy );
                }
                
                self notify( #"vtol_starting_landing", var_cd4db992 );
                var_426e4bae = landing_zone;
                
                foreach ( zone in self.var_dda84f1a )
                {
                    if ( "landing_zone_" + landing_zone.script_noteworthy == zone.script_noteworthy )
                    {
                        var_426e4bae = zone;
                        break;
                    }
                }
                
                self clientfield::set_player_uimodel( "vehicle.showLandHint", 0 );
                thread cp_mi_cairo_aquifer_sound::function_976c341d( self, var_426e4bae );
                self.pvtol takeplayercontrol();
                self.pvtol setheliheightlock( 0 );
                driver_offset = self.pvtol gettagorigin( "tag_driver" ) - self.pvtol.origin;
                driver_offset = ( driver_offset[ 0 ], driver_offset[ 1 ], 0 );
                dock_pos = var_426e4bae.origin + rotatepoint( driver_offset, var_426e4bae.angles ) + ( 0, 0, 120 );
                self.pvtol setspeed( 50, 100, 100 );
                self.pvtol setyawspeed( 59, 360, 360 );
                self.pvtol setvehgoalpos( dock_pos, 1 );
                self.pvtol settargetyaw( var_426e4bae.angles[ 1 ] );
                self.pvtol setneargoalnotifydist( 12 );
                self.pvtol sethoverparams( 0 );
                self.pvtol thread function_da487b0c();
                self.pvtol notsolid();
                self.pvtol clientfield::set( "vtol_canopy_state", 1 );
                goal = self.pvtol util::waittill_any_timeout( 5, "goal", "near_goal", "goal_yaw" );
                
                if ( goal == "goal_yaw" )
                {
                    self.pvtol util::waittill_any_timeout( 5, "near_goal", "goal" );
                }
                else if ( absangleclamp180( var_426e4bae.angles[ 1 ] - self.pvtol.angles[ 1 ] ) > 1 )
                {
                    self.pvtol util::waittill_any_timeout( 5, "goal_yaw" );
                }
                
                self.pvtol setyawspeed( 0.01, 99999, 99999 );
                self.pvtol cleartargetyaw();
                self.pvtol.angles = ( 0, var_426e4bae.angles[ 1 ], 0 );
                self.pvtol dontinterpolate();
                wait 0.05;
                self.pvtol clientfield::set( "vtol_set_active_landing_zone_num", 0 );
                thread cp_mi_cairo_aquifer_sound::function_77b5283a( self );
                self thread function_22a0413d( "exit", var_426e4bae );
                return;
            }
        }
        
        wait 0.05;
    }
}

// Namespace aquifer_util
// Params 0
// Checksum 0x9ce9aa21, Offset: 0x9580
// Size: 0x179
function function_da487b0c()
{
    self endon( #"death" );
    var_6f554d84 = 1.5;
    start_pitch = angleclamp180( self.angles[ 0 ] );
    start_roll = angleclamp180( self.angles[ 2 ] );
    
    while ( isdefined( self ) && self.angles[ 0 ] != 0 && self.angles[ 2 ] != 0 )
    {
        pitch = angleclamp180( self.angles[ 0 ] ) - var_6f554d84 * math::sign( start_pitch );
        
        if ( math::sign( pitch ) != math::sign( start_pitch ) )
        {
            pitch = 0;
        }
        
        roll = angleclamp180( self.angles[ 2 ] ) - var_6f554d84 * math::sign( start_roll );
        
        if ( math::sign( roll ) != math::sign( start_roll ) )
        {
            roll = 0;
        }
        
        self.angles = ( pitch, self.angles[ 1 ], roll );
        wait 0.05;
    }
}

// Namespace aquifer_util
// Params 3
// Checksum 0x1b937147, Offset: 0x9708
// Size: 0x4fa
function vtol_exit( landing_zone, play_anims, var_fe173168 )
{
    if ( !isdefined( play_anims ) )
    {
        play_anims = 1;
    }
    
    if ( !isdefined( var_fe173168 ) )
    {
        var_fe173168 = 0;
    }
    
    self endon( #"disconnect" );
    self endon( #"death" );
    
    if ( !self function_5c971cb7() )
    {
        self notify( #"pb_aqu_vtol_exit", "end" );
        
        if ( isdefined( self.var_6f5c6fa1 ) && self.var_6f5c6fa1 && self flagsys::get( "scriptedanim" ) && !isdefined( self.current_scene ) && !isdefined( self.current_player_scene ) )
        {
            self thread animation::stop();
        }
        
        return;
    }
    
    self.pvtol clientfield::set( "vtol_set_active_landing_zone_num", 0 );
    self.pvtol.state = "exit";
    self notify( #"vtol_exit" );
    self enableinvulnerability();
    self.pvtol vehicle::god_on();
    self.pvtol cleartargetyaw();
    self.pvtol clearvehgoalpos();
    self.pvtol makevehicleusable();
    self.pvtol usevehicle( self, self.pvtol getoccupantseat( self ) );
    self.pvtol makevehicleunusable();
    self.var_1b9475b4 = 0;
    self.pvtol thread audio::sndupdatevehiclecontext( 0 );
    self.pvtol.landing_mode = 0;
    self clientfield::set_to_player( "hijack_static_effect", 0 );
    
    if ( play_anims )
    {
        self thread animation::play( "pb_aqu_vtol_exit", self.pvtol, "tag_origin", 1, 0.2, 0.05 );
        self.var_6f5c6fa1 = 1;
        self waittillmatch( #"pb_aqu_vtol_exit", "end" );
    }
    
    self.var_6f5c6fa1 = 0;
    var_cd4db992 = -1;
    
    if ( isdefined( landing_zone ) && isdefined( landing_zone.script_noteworthy ) )
    {
        var_cd4db992 = int( strtok( landing_zone.script_noteworthy, "landing_zone_" )[ 0 ] );
    }
    
    level notify( #"vtol_landed", self, var_cd4db992 );
    self.pvtol cleartargetyaw();
    self.pvtol clearvehgoalpos();
    self enableweaponcycling();
    self disableinvulnerability();
    self.pvtol vehicle::god_off();
    self.b_tactical_mode_enabled = 1;
    self.var_32218fc7 = 0;
    level notify( #"enable_cybercom", self );
    self gadgetpowerset( 0, 100 );
    self gadgetpowerset( 1, 100 );
    self gadgetpowerset( 2, 100 );
    self.b_enhanced_vision_enabled = 1;
    self.pvtol sethoverparams( 24, 24, 24 );
    var_15f4ba8b = 1;
    
    foreach ( player in level.players )
    {
        if ( isdefined( player.pvtol ) && player islinkedto( player.pvtol ) )
        {
            var_15f4ba8b = 0;
            break;
        }
    }
    
    if ( var_15f4ba8b )
    {
        setsaveddvar( "bulletrange", 8192 );
    }
    
    self.pvtol clientfield::set( "vtol_canopy_state", 0 );
    wait 2;
    self setthreatbiasgroup( "players_ground" );
    
    if ( !var_fe173168 )
    {
        self thread function_22a0413d( "autopilot", landing_zone );
        return;
    }
    
    self thread function_22a0413d( "idle" );
    self.pvtol setvehvelocity( ( 0, 0, 0 ) );
    self.pvtol setangularvelocity( ( 0, 0, 0 ) );
}

// Namespace aquifer_util
// Params 1
// Checksum 0xf9227c7a, Offset: 0x9c10
// Size: 0xba
function function_ae0b01fe( var_fe173168 )
{
    foreach ( player in level.activeplayers )
    {
        if ( isdefined( player.pvtol ) && player islinkedto( player.pvtol ) )
        {
            player aquifer_obj::function_a5b8f98();
            player thread function_8f99207( var_fe173168 );
        }
    }
    
    level thread aquifer_obj::function_31e37f85();
}

// Namespace aquifer_util
// Params 1
// Checksum 0x24c0342a, Offset: 0x9cd8
// Size: 0x22
function function_8f99207( var_fe173168 )
{
    self thread function_22a0413d( "exit", undefined, 0, var_fe173168 );
}

// Namespace aquifer_util
// Params 0
// Checksum 0x18387be0, Offset: 0x9d08
// Size: 0x87, Type: bool
function function_5c971cb7()
{
    if ( !isdefined( self ) || !isdefined( self.pvtol ) )
    {
        return false;
    }
    
    if ( !isdefined( self getvehicleoccupied() ) || self getvehicleoccupied() != self.pvtol )
    {
        return false;
    }
    
    seat = self.pvtol getoccupantseat( self );
    
    if ( isdefined( seat ) && seat == 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace aquifer_util
// Params 1
// Checksum 0xc54d9ff3, Offset: 0x9d98
// Size: 0x1aa
function function_2b89d912( landing_zone )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self.pvtol endon( #"hash_c38e4003" );
    self.pvtol.state = "autopilot";
    self.pvtol sethoverparams( 0 );
    self.pvtol clearvehgoalpos();
    self.pvtol cleartargetyaw();
    self.pvtol notsolid();
    self.pvtol thread animation::play( "v_aqu_vtol_land_exit", self.pvtol.origin, self.pvtol.angles, 1, 0.5, 0.5, 0.5 );
    wait 1;
    self.pvtol clientfield::set( "vtol_enable_wash_fx", 0 );
    self.pvtol waittillmatch( #"v_aqu_vtol_land_exit", "end" );
    self.pvtol stopanimscripted( 0 );
    self.pvtol setvehgoalpos( self.pvtol.origin, 1 );
    self.pvtol ghost();
    self.pvtol notify( #"reset_damage_state" );
}

/#

    // Namespace aquifer_util
    // Params 0
    // Checksum 0xbb276136, Offset: 0x9f50
    // Size: 0xa9, Type: dev
    function function_edfe2d40()
    {
        wait 2;
        
        while ( true )
        {
            if ( !isdefined( level.skipto_current_objective ) || !isdefined( level.skipto_settings[ level.skipto_current_objective[ 0 ] ] ) )
            {
                iprintln( "<dev string:x10e>" );
            }
            
            ret = function_c43fe5d3();
            
            if ( ret )
            {
                iprintln( "<dev string:x122>" + level.skipto_current_objective[ 0 ] );
            }
            else
            {
                iprintln( "<dev string:x130>" + level.skipto_current_objective[ 0 ] );
            }
            
            wait 1;
        }
    }

#/

// Namespace aquifer_util
// Params 0
// Checksum 0x598bef82, Offset: 0xa008
// Size: 0x1b6
function function_c43fe5d3()
{
    if ( !isdefined( level.skipto_current_objective ) || !isdefined( level.skipto_settings[ level.skipto_current_objective[ 0 ] ] ) )
    {
        return 1;
    }
    
    desc = level.skipto_settings[ level.skipto_current_objective[ 0 ] ].str_name;
    
    if ( !isdefined( desc ) )
    {
        desc = level.skipto_settings[ level.skipto_current_objective[ 0 ] ].skipto_loc_string;
    }
    
    return_val = undefined;
    
    if ( strendswith( desc, "spawnvtol" ) )
    {
        return 1;
    }
    else if ( strendswith( desc, "checkkayneexist" ) )
    {
        if ( level flag::get( "exterior_hack_trig_right_1_started" ) && ( level flag::get( "exterior_hack_trig_left_1_started" ) && level flag::get( "exterior_hack_trig_left_1_finished" ) || level flag::get( "exterior_hack_trig_right_1_finished" ) ) )
        {
            level notify( #"hotjoin_hack" );
            return 1;
        }
        
        return_val = !isdefined( level.kayne );
    }
    else if ( strendswith( desc, "checkenteredwater" ) )
    {
        return_val = !level flag::get( "flag_enter_water_moment" );
    }
    else if ( strendswith( desc, "checkplayerlanded" ) )
    {
        return_val = !level flag::get( "lcombat_respawn_ground" );
    }
    
    if ( isdefined( return_val ) )
    {
        if ( !return_val )
        {
            self aquifer_obj::function_a5b8f98();
        }
        
        return return_val;
    }
    
    return 0;
}

// Namespace aquifer_util
// Params 1
// Checksum 0x89e344c4, Offset: 0xa1c8
// Size: 0x11a
function fixup_heightmap_on_use( force )
{
    self notify( #"fixing_heightmap_on_use" );
    self notify( #"changing_player_heighmaps" );
    self endon( #"fixing_heightmap_on_use" );
    wait 0.05;
    
    if ( level flag::exists( "hack_terminal_right" ) && !level flag::get( "hack_terminal_right_completed" ) )
    {
        self player_init_heightmap_intro_state( force );
        return;
    }
    
    if ( level flag::exists( "hack_terminals2" ) && !level flag::get( "hack_terminals2_completed" ) )
    {
        self player_init_heightmap_obj3_state( force );
        return;
    }
    
    if ( level flag::exists( "water_room" ) && !level flag::get( "water_room_completed" ) )
    {
        self function_a0567298( force );
        return;
    }
    
    self player_init_heightmap_breach_state( force );
}

// Namespace aquifer_util
// Params 3
// Checksum 0xc27c9cb3, Offset: 0xa2f0
// Size: 0xe9
function wait_until_height_change_safe( player, volname, blocking )
{
    player endon( #"death" );
    player endon( #"disconnect" );
    
    if ( !isdefined( player.pvtol ) )
    {
        return 1;
    }
    
    if ( !isdefined( blocking ) )
    {
        blocking = 1;
    }
    
    if ( !isdefined( volname ) )
    {
        volname = "contains_whole_aquifer";
    }
    
    vol = getent( volname, "targetname" );
    
    if ( !isdefined( vol ) )
    {
        return 1;
    }
    
    if ( !blocking )
    {
        return !player istouching( vol );
    }
    
    while ( true )
    {
        if ( player islinkedto( player.pvtol ) )
        {
            if ( !player istouching( vol ) )
            {
                return 1;
            }
        }
        
        wait 0.05;
    }
}

// Namespace aquifer_util
// Params 1
// Checksum 0x31a28583, Offset: 0xa3e8
// Size: 0x93
function init_heightmap_intro_state( force )
{
    if ( !isdefined( force ) )
    {
        force = 0;
    }
    
    foreach ( player in level.activeplayers )
    {
        if ( !isdefined( player.my_heightmap ) )
        {
            player.my_heightmap = "none";
        }
        
        player thread player_init_heightmap_intro_state( force );
    }
}

// Namespace aquifer_util
// Params 1
// Checksum 0x48933762, Offset: 0xa488
// Size: 0xda
function player_init_heightmap_intro_state( force )
{
    self notify( #"changing_player_heighmaps" );
    self endon( #"changing_player_heighmaps" );
    self endon( #"disconnect" );
    self endon( #"death" );
    
    if ( !isdefined( force ) )
    {
        force = 0;
    }
    
    this_heightmap = "intro";
    
    if ( force || self.my_heightmap != this_heightmap )
    {
        if ( !force )
        {
            wait_until_height_change_safe( self );
        }
        
        self.my_heightmap = this_heightmap;
        setheliheightpatchenabled( "heightmap_objective1", 1, self );
        setheliheightpatchenabled( "heightmap_objective3", 0, self );
        setheliheightpatchenabled( "heightmap_water_room", 0, self );
        setheliheightpatchenabled( "heightmap_wasp_defend", 0, self );
    }
}

// Namespace aquifer_util
// Params 1
// Checksum 0x30ff7097, Offset: 0xa570
// Size: 0x8b
function function_5497473c( force )
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player.my_heightmap ) )
        {
            player.my_heightmap = "none";
        }
        
        player thread function_a0567298();
    }
}

// Namespace aquifer_util
// Params 1
// Checksum 0x1c7598f3, Offset: 0xa608
// Size: 0xd2
function function_a0567298( force )
{
    self notify( #"changing_player_heighmaps" );
    self endon( #"changing_player_heighmaps" );
    self endon( #"disconnect" );
    self endon( #"death" );
    
    if ( !isdefined( force ) )
    {
        force = 0;
    }
    
    this_heightmap = "waterroom";
    
    if ( self.my_heightmap != this_heightmap )
    {
        if ( !force )
        {
            wait_until_height_change_safe( self );
        }
        
        self.my_heightmap = this_heightmap;
        setheliheightpatchenabled( "heightmap_objective3", 0, self );
        setheliheightpatchenabled( "heightmap_objective1", 0, self );
        setheliheightpatchenabled( "heightmap_water_room", 1, self );
        setheliheightpatchenabled( "heightmap_wasp_defend", 0, self );
    }
}

// Namespace aquifer_util
// Params 1
// Checksum 0x1f0cd493, Offset: 0xa6e8
// Size: 0x8b
function init_heightmap_breach_state( force )
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player.my_heightmap ) )
        {
            player.my_heightmap = "none";
        }
        
        player thread player_init_heightmap_breach_state();
    }
}

// Namespace aquifer_util
// Params 1
// Checksum 0x511a1f5b, Offset: 0xa780
// Size: 0xd2
function player_init_heightmap_breach_state( force )
{
    self notify( #"changing_player_heighmaps" );
    self endon( #"changing_player_heighmaps" );
    self endon( #"disconnect" );
    self endon( #"death" );
    
    if ( !isdefined( force ) )
    {
        force = 0;
    }
    
    this_heightmap = "breach";
    
    if ( self.my_heightmap != this_heightmap )
    {
        if ( !force )
        {
            wait_until_height_change_safe( self );
        }
        
        self.my_heightmap = this_heightmap;
        setheliheightpatchenabled( "heightmap_objective3", 1, self );
        setheliheightpatchenabled( "heightmap_objective1", 0, self );
        setheliheightpatchenabled( "heightmap_water_room", 0, self );
        setheliheightpatchenabled( "heightmap_wasp_defend", 0, self );
    }
}

// Namespace aquifer_util
// Params 0
// Checksum 0x5bc53e11, Offset: 0xa860
// Size: 0x83
function init_heightmap_obj3_state()
{
    foreach ( player in level.activeplayers )
    {
        if ( !isdefined( player.my_heightmap ) )
        {
            player.my_heightmap = "none";
        }
        
        player thread player_init_heightmap_obj3_state();
    }
}

// Namespace aquifer_util
// Params 1
// Checksum 0x9ef5efe8, Offset: 0xa8f0
// Size: 0xd2
function player_init_heightmap_obj3_state( force )
{
    self notify( #"changing_player_heighmaps" );
    self endon( #"changing_player_heighmaps" );
    self endon( #"disconnect" );
    self endon( #"death" );
    
    if ( !isdefined( force ) )
    {
        force = 0;
    }
    
    this_heightmap = "obj3";
    
    if ( self.my_heightmap != this_heightmap )
    {
        if ( !force )
        {
            wait_until_height_change_safe( self );
        }
        
        self.my_heightmap = this_heightmap;
        setheliheightpatchenabled( "heightmap_objective3", 1, self );
        setheliheightpatchenabled( "heightmap_water_room", 0, self );
        setheliheightpatchenabled( "heightmap_objective1", 0, self );
        setheliheightpatchenabled( "heightmap_wasp_defend", 0, self );
    }
}

// Namespace aquifer_util
// Params 0
// Checksum 0xb1e2c929, Offset: 0xa9d0
// Size: 0xc5
function vtol_track_owner()
{
    self endon( #"disconnect" );
    self endon( #"death" );
    vtol = self.pvtol;
    self.in_vtol = self islinkedto( vtol );
    
    while ( true )
    {
        if ( !self islinkedto( vtol ) )
        {
            vtol clearvehgoalpos();
            vtol setvehvelocity( ( 0, 0, 0 ) );
            vtol setangularvelocity( ( 0, 0, 0 ) );
            wait 0.2;
        }
        else
        {
            self.in_vtol = 1;
            level flag::set( "start_aquifer_objectives" );
        }
        
        wait 0.05;
    }
}

// Namespace aquifer_util
// Params 0
// Checksum 0x45bbe45e, Offset: 0xaaa0
// Size: 0xe7
function exterior_ambiance()
{
    if ( isdefined( level.exterior_ambiance_executed ) )
    {
        return;
    }
    
    level.exterior_ambiance_executed = 1;
    wait 15;
    level.lockon_enemies = [];
    level.lockon_enemies = vehicle::simple_spawn( "ambient_enemy" );
    
    for ( i = 0; i < level.lockon_enemies.size ; i++ )
    {
        node = getvehiclenode( level.lockon_enemies[ i ].target, "targetname" );
        level.lockon_enemies[ i ] attachpath( node );
        level.lockon_enemies[ i ] startpath();
        level.lockon_enemies[ i ] thread watch_vehicle_notifies();
        
        /#
        #/
        
        wait 4;
    }
}

// Namespace aquifer_util
// Params 0
// Checksum 0x3d359f1c, Offset: 0xab90
// Size: 0x3e5
function watch_vehicle_notifies()
{
    self endon( #"death" );
    start_node = self.target;
    self.last_started_path = getvehiclenode( start_node, "targetname" );
    self.disconnectpathonstop = 0;
    start_node_group = getvehiclenodearray( "restart_node_rear", "script_noteworthy" );
    my_node_group = getvehiclenodearray( "restart_node_rear", "script_noteworthy" );
    self.mylookat_ent = spawn( "script_origin", self.origin );
    
    while ( true )
    {
        node_name = start_node;
        ret_val = self util::waittill_any_return( "path_restart", "delete_me", "path_jump_node" );
        
        if ( ret_val == "delete_me" || !isdefined( node_name ) )
        {
            self delete();
            return;
        }
        
        self vehicle::get_off_path();
        curr_time = gettime();
        my_node_group = [];
        search_group = [];
        
        if ( isdefined( self.currentnode.script_parameters ) )
        {
            search_group = getvehiclenodearray( self.currentnode.script_parameters, "script_noteworthy" );
        }
        else
        {
            iprintlnbold( "ERROR: no script parameter of next nodes to go to." );
            search_group = start_node_group;
        }
        
        foreach ( node in search_group )
        {
            if ( !isdefined( node.reuse_time ) || curr_time > node.reuse_time )
            {
                my_node_group[ my_node_group.size ] = node;
            }
        }
        
        next_node = array::random( my_node_group );
        
        if ( !isdefined( next_node ) )
        {
            self kill();
            return;
        }
        
        next_node.reuse_time = curr_time + 3000;
        dist = distance( self.origin, next_node.origin );
        
        if ( dist > -128 )
        {
            self setspeed( 120, 50, 125 );
            self setvehgoalpos( next_node.origin, 0, 1 );
            next = getvehiclenode( next_node.target, "targetname" );
            self.mylookat_ent.origin = next.origin;
            self setlookatent( self.mylookat_ent );
            
            while ( dist > -106 )
            {
                wait 0.05;
                dist = distance( self.origin, next_node.origin );
            }
            
            self clearlookatent();
            self cancelaimove();
            self clearvehgoalpos();
        }
        else
        {
            self cancelaimove();
            self clearvehgoalpos();
        }
        
        wait 0.05;
        self attachpath( next_node );
        self.last_started_path = next_node;
        self startpath();
        wait 0.05;
    }
}

// Namespace aquifer_util
// Params 0
// Checksum 0x977a0576, Offset: 0xaf80
// Size: 0x29
function get_potential_lockon_targets()
{
    level.lockon_enemies = array::remove_dead( level.lockon_enemies );
    return level.lockon_enemies;
}

// Namespace aquifer_util
// Params 0
// Checksum 0x884c095d, Offset: 0xafb8
// Size: 0x2fd
function watch_player_lockon()
{
    self endon( #"disconnect" );
    self endon( #"death" );
    wait 1;
    min_dot = 0.9;
    max_lockon_dist = 1024;
    lockon_ms = 500;
    heading_min_dot = 0.707;
    
    /#
        min_dot = 0.7;
        max_lockon_dist = 6024;
        lockon_ms = 100;
    #/
    
    last_best = undefined;
    best_enemy = undefined;
    
    while ( true )
    {
        if ( !self.in_vtol )
        {
            wait 0.1;
            continue;
        }
        
        last_best = best_enemy;
        best_enemy = undefined;
        best_dot = -1;
        targets = level get_potential_lockon_targets();
        
        foreach ( enemy in level.lockon_enemies )
        {
            to_enemy = enemy.origin - self.origin;
            dist_to_enemy = length( to_enemy );
            
            if ( dist_to_enemy > max_lockon_dist )
            {
                continue;
            }
            
            forward = anglestoforward( self getplayerangles() );
            enemy_forward = anglestoforward( enemy.angles );
            heading_dot = vectordot( forward, enemy_forward );
            
            if ( heading_dot >= heading_min_dot )
            {
                normal = vectornormalize( to_enemy );
                dot = vectordot( forward, normal );
                
                if ( dot > min_dot && dot > best_dot )
                {
                    best_dot = dot;
                    best_enemy = enemy;
                }
            }
            
            if ( isdefined( best_enemy ) )
            {
                if ( !isdefined( last_best ) || last_best != best_enemy )
                {
                    if ( isalive( last_best ) )
                    {
                        last_best.lockon_time = -1;
                    }
                    
                    best_enemy.lockon_time = gettime() + lockon_ms;
                }
                
                if ( gettime() > best_enemy.lockon_time )
                {
                    if ( self adsbuttonpressed() )
                    {
                        self handle_player_lockon( best_enemy );
                        continue;
                    }
                    
                    /#
                        print3d( best_enemy.origin + ( 0, 0, 100 ), "<dev string:x140>", ( 0, 0, 1 ), 1, 2, 1 );
                    #/
                }
            }
        }
        
        wait 0.05;
    }
}

// Namespace aquifer_util
// Params 1
// Checksum 0x6eeec26c, Offset: 0xb2c0
// Size: 0x22
function velocity_to_mph( vel )
{
    return length( vel ) * 0.0568182;
}

// Namespace aquifer_util
// Params 1
// Checksum 0x68afe5e5, Offset: 0xb2f0
// Size: 0x152
function handle_player_lockon( enemy )
{
    self.pvtol takeplayercontrol();
    lerptime = 0.5;
    self.pvtol setpathtransitiontime( lerptime );
    self.pvtol attachpath( enemy.currentnode );
    wait lerptime;
    self.pvtol startpath();
    
    while ( self adsbuttonpressed() && isalive( enemy ) )
    {
        wait 0.05;
    }
    
    self.pvtol clearlookatent();
    self.pvtol cancelaimove();
    self.pvtol clearvehgoalpos();
    wait 0.05;
    self.pvtol usevehicle( self, 0 );
    self.pvtol usevehicle( self, 0 );
    self.pvtol returnplayercontrol();
}

// Namespace aquifer_util
// Params 0
// Checksum 0xc6000c8b, Offset: 0xb450
// Size: 0x59
function handle_nrc_aa()
{
    self endon( #"death" );
    wait 1;
    self setteam( "axis" );
    
    if ( !self turret::is_turret_enabled( 1 ) )
    {
        self turret::enable( 1 );
    }
    
    while ( true )
    {
        wait 0.05;
    }
}

// Namespace aquifer_util
// Params 0
// Checksum 0x171bbb68, Offset: 0xb4b8
// Size: 0x12
function delete_me()
{
    self delete();
}

// Namespace aquifer_util
// Params 1
// Checksum 0x40614d2c, Offset: 0xb4d8
// Size: 0x72
function function_3fce552c( on )
{
    if ( false )
    {
        ent = getent( "boss_tree", "targetname" );
        ent notsolid();
        
        if ( on )
        {
            ent show();
            return;
        }
        
        ent hide();
    }
}

// Namespace aquifer_util
// Params 1
// Checksum 0x2c0e597e, Offset: 0xb558
// Size: 0x172
function toggle_interior_doors( going_in )
{
    open = going_in;
    toggle_door( "boss_door", open );
    toggle_door( "backwash_door", open );
    toggle_door( "fallen_pile_big", open );
    toggle_door( "fallen_pile_small", open );
    toggle_door( "runout_crusher", open );
    open = !going_in;
    toggle_door( "stair_door", open );
    toggle_door( "double_closed", open );
    toggle_door( "intact_small", open );
    toggle_door( "roller_door", open );
    toggle_door( "hangar_door", open );
    toggle_door( "stairwell_door", open );
    toggle_door( "hideout_door2", open );
    toggle_door( "hideout_doors_closed", open );
    toggle_door( "Hangar_Door_Intact", 1 );
}

// Namespace aquifer_util
// Params 2
// Checksum 0x7e211695, Offset: 0xb6d8
// Size: 0xf3
function toggle_door( name, open )
{
    doors = getentarray( name, "targetname" );
    
    foreach ( door in doors )
    {
        if ( isdefined( door ) )
        {
            if ( open )
            {
                door hide();
                door notsolid();
                door connectpaths();
                continue;
            }
            
            door show();
            door solid();
            door disconnectpaths();
        }
    }
}

// Namespace aquifer_util
// Params 1
// Checksum 0x7dfd96d9, Offset: 0xb7d8
// Size: 0x42
function safe_use_trigger( name )
{
    trig = getent( name, "targetname" );
    
    if ( isdefined( trig ) )
    {
        trig trigger::use();
    }
}

// Namespace aquifer_util
// Params 0
// Checksum 0x42adae5b, Offset: 0xb828
// Size: 0xb1
function function_9baa6cb5()
{
    self notify( #"hash_9baa6cb5" );
    self endon( #"hash_9baa6cb5" );
    self endon( #"death" );
    self endon( #"disconnect" );
    
    if ( !isdefined( self.ev_state ) )
    {
        self.ev_state = 0;
    }
    
    while ( true )
    {
        if ( self actionslotfourbuttonpressed() )
        {
            self.ev_state = !( isdefined( self.ev_state ) && self.ev_state );
            self oed::ev_activate_on_player( self.ev_state );
            
            while ( self actionslotfourbuttonpressed() )
            {
                wait 0.05;
            }
            
            continue;
        }
        
        wait 0.05;
    }
}

// Namespace aquifer_util
// Params 0
// Checksum 0x8fa837e1, Offset: 0xb8e8
// Size: 0x115
function function_c10544f()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    
    if ( !isdefined( self.var_4324603c ) )
    {
        self.var_4324603c = spawnstruct();
    }
    
    while ( self function_5c971cb7() && isalive( self ) )
    {
        self.pvtol waittill( #"damage", damage, attacker, dir, loc, type, model, tag, part, weapon, flags );
        self.var_4324603c.attacker = attacker;
        self.var_4324603c.loc = loc;
        self.var_4324603c.weapon = weapon;
        self addtodamageindicator( damage, dir );
    }
}

// Namespace aquifer_util
// Params 1
// Checksum 0xf9d5d2cb, Offset: 0xba08
// Size: 0x5b9
function function_2d64c4b0( player )
{
    player endon( #"disconnect" );
    skill = getlocalprofileint( "g_gameskill" );
    regen_delay = 1000 * ( skill + 1 );
    regen_rate = 100 / ( skill + 1 );
    var_fb7e6cf1 = 4 - skill;
    var_fa963e85 = var_fb7e6cf1 > 0;
    last_damage_time = 0;
    self.maxhealth = int( 100000 / ( skill + 1 ) );
    self.health = self.maxhealth;
    last_health = self.health;
    var_e4fefce2 = int( self.maxhealth * 0.033 );
    var_7b71e577 = int( self.maxhealth * 0.066 );
    var_ecd3ee40 = int( self.maxhealth * 0.085 );
    var_f53b8d29 = 0;
    last_damage_state = 0;
    
    while ( isdefined( self ) )
    {
        driver = self getseatoccupant( 0 );
        
        if ( isdefined( driver ) )
        {
            if ( self.health >= last_health && self.health < self.maxhealth )
            {
                if ( last_damage_time + regen_delay < gettime() )
                {
                    self.health = int( min( self.health + regen_rate, self.maxhealth ) );
                    
                    if ( self.health >= self.maxhealth )
                    {
                        var_fa963e85 = 1;
                    }
                }
            }
            else if ( self.health < last_health )
            {
                driver notify( #"player_took_accolade_damage" );
                
                if ( self.maxhealth - self.health >= var_ecd3ee40 )
                {
                    if ( var_fa963e85 && skill < 4 )
                    {
                        self.health = self.maxhealth - var_ecd3ee40;
                        self vehicle::god_on();
                        wait var_fb7e6cf1;
                        self vehicle::god_off();
                        var_fa963e85 = 0;
                    }
                    else
                    {
                        self vehicle::god_on();
                        self takeplayercontrol();
                        driver notify( #"vtol_death" );
                        driver.pvtol clientfield::set( "vtol_dogfighting", 0 );
                        driver clientfield::set_player_uimodel( "vehicle.lockOn", 0 );
                        self clientfield::set( "vtol_set_missile_lock_percent", 0 );
                        self clientfield::set( "vtol_show_missile_lock", 0 );
                        driver weaponlockfree();
                        time = 3;
                        driver thread function_59b80342( time );
                        self thread vehicle_death::helicopter_crash();
                        ret = self util::waittill_any_timeout( time, "crash_move_done" );
                        
                        if ( isdefined( driver ) )
                        {
                            driver disableinvulnerability();
                            driver.health = 1;
                            driver.diedonvehicle = 1;
                            driver setplayergravity( 0 );
                            driver kill( driver.var_4324603c.loc, driver.var_4324603c.attacker, undefined, driver.var_4324603c.weapon );
                        }
                        
                        if ( ret == "timeout" && isdefined( self ) )
                        {
                            self notify( #"crash_done" );
                            self vehicle::god_off();
                            self thread vehicle_death::helicopter_explode( 0 );
                            util::wait_network_frame();
                            
                            if ( isdefined( self ) )
                            {
                                self delete();
                            }
                        }
                        
                        wait 1;
                        
                        if ( isdefined( driver ) && !isalive( driver ) && !driver isplayinganimscripted() )
                        {
                            driver thread lui::screen_fade_out( 0.5 );
                        }
                        
                        return;
                    }
                }
                
                if ( self.maxhealth - self.health >= var_7b71e577 )
                {
                    var_f53b8d29 = max( var_f53b8d29, 2 );
                }
                else if ( self.maxhealth - self.health >= var_e4fefce2 )
                {
                    var_f53b8d29 = max( var_f53b8d29, 1 );
                }
                
                last_damage_time = gettime();
            }
            
            last_health = self.health;
        }
        else
        {
            self util::waittill_any( "reset_damage_state", "enter_vehicle" );
            self.health = self.maxhealth;
            var_f53b8d29 = 0;
        }
        
        if ( var_f53b8d29 != last_damage_state )
        {
            self clientfield::set( "vtol_damage_state", int( var_f53b8d29 ) );
            last_damage_state = var_f53b8d29;
            self vehicle::god_on();
            wait var_fb7e6cf1 / 2;
            self vehicle::god_off();
            last_damage_time = gettime();
        }
        
        wait 0.05;
    }
}

// Namespace aquifer_util
// Params 1
// Checksum 0x587e43a0, Offset: 0xbfd0
// Size: 0x82
function function_59b80342( time )
{
    start_time = time;
    
    while ( isdefined( self ) && time > 0 )
    {
        self clientfield::set_to_player( "hijack_static_effect", 1 - time / start_time );
        wait 0.05;
        time -= 0.05;
    }
    
    if ( isdefined( self ) )
    {
        self clientfield::set_to_player( "hijack_static_effect", 1 );
    }
}

// Namespace aquifer_util
// Params 1
// Checksum 0x9f8f1d1d, Offset: 0xc060
// Size: 0x1f2
function function_d683f26a( teleport )
{
    if ( !isdefined( self.pvtol ) && isdefined( self.player_num ) && !self flagsys::get( "vtol_spawning" ) )
    {
        self clientfield::set_player_uimodel( "vehicle.weaponIndex", 1 );
        self clientfield::set_player_uimodel( "vehicle.lockOn", 0 );
        self flagsys::set( "vtol_spawning" );
        self.pvtol = vehicle::simple_spawn_single( "player" + self.player_num + "_vtol_spawner" );
        self.pvtol setvehicletype( "veh_bo3_mil_vtol_fighter_player_agile" );
        self.pvtol thread function_2d64c4b0( self );
        self flagsys::clear( "vtol_spawning" );
        
        if ( !isdefined( teleport ) )
        {
            teleport = 1;
        }
        
        if ( teleport )
        {
            start_loc = struct::get( "player" + self.player_num + "_vtol_start_loc" );
            
            if ( isdefined( start_loc ) )
            {
                self.pvtol.origin = start_loc.origin;
                self.pvtol.angles = start_loc.angles;
                self.pvtol dontinterpolate();
            }
        }
        
        if ( isdefined( self.player_num ) )
        {
            self.var_dda84f1a = getentarray( "landing_zone_player_" + self.player_num, "targetname" );
        }
        
        return;
    }
    
    self flagsys::wait_till_clear( "vtol_spawning" );
}

// Namespace aquifer_util
// Params 1
// Checksum 0xe39100f2, Offset: 0xc260
// Size: 0x14a
function function_b7cf4d2d( player )
{
    if ( !isdefined( player ) )
    {
        player = undefined;
    }
    
    min_time = 0.1;
    max_time = 0.2;
    var_ea34fead = level;
    
    if ( isdefined( player ) )
    {
        player endon( #"disconnect" );
        var_ea34fead = player;
    }
    
    level flagsys::set( "dogfight_intro_dialog" );
    level dialog::remote( "kane_watch_out_multiple_b_0", 0, "dni", player );
    var_ea34fead dialog::player_say( "plyr_break_formation_and_0", randomfloatrange( min_time, max_time ) );
    var_ea34fead dialog::player_say( "plyr_hendricks_proceed_to_0", randomfloatrange( min_time, max_time ) );
    level dialog::remote( "hend_copy_all_drop_em_0", randomfloatrange( min_time, max_time ), "dni", player );
    level flagsys::clear( "dogfight_intro_dialog" );
}

// Namespace aquifer_util
// Params 0
// Checksum 0xa99dd5dc, Offset: 0xc3b8
// Size: 0xc2
function function_61b71c43()
{
    scene::add_scene_func( "cin_aqu_01_10_intro_1st_flyin_main", &function_f005cfe, "done" );
    scene::init( "cin_aqu_01_10_intro_1st_flyin_main" );
    level.hendricks_vtol = vehicle::simple_spawn_single( "hendricks_vtol" );
    level.kane = getent( "kane_intro", "targetname" ) spawner::spawn( 1 );
    level.kane_vtol = vehicle::simple_spawn_single( "kane_vtol" );
}

// Namespace aquifer_util
// Params 1
// Checksum 0xf380758f, Offset: 0xc488
// Size: 0x41a
function play_intro( hendricks )
{
    var_f13bfa4a = [];
    var_20ba1d57 = [];
    
    if ( !isdefined( var_f13bfa4a ) )
    {
        var_f13bfa4a = [];
    }
    else if ( !isarray( var_f13bfa4a ) )
    {
        var_f13bfa4a = array( var_f13bfa4a );
    }
    
    var_f13bfa4a[ var_f13bfa4a.size ] = hendricks;
    
    if ( !isdefined( var_f13bfa4a ) )
    {
        var_f13bfa4a = [];
    }
    else if ( !isarray( var_f13bfa4a ) )
    {
        var_f13bfa4a = array( var_f13bfa4a );
    }
    
    var_f13bfa4a[ var_f13bfa4a.size ] = level.hendricks_vtol;
    
    if ( !isdefined( var_f13bfa4a ) )
    {
        var_f13bfa4a = [];
    }
    else if ( !isarray( var_f13bfa4a ) )
    {
        var_f13bfa4a = array( var_f13bfa4a );
    }
    
    var_f13bfa4a[ var_f13bfa4a.size ] = level.kane;
    
    if ( !isdefined( var_f13bfa4a ) )
    {
        var_f13bfa4a = [];
    }
    else if ( !isarray( var_f13bfa4a ) )
    {
        var_f13bfa4a = array( var_f13bfa4a );
    }
    
    var_f13bfa4a[ var_f13bfa4a.size ] = level.kane_vtol;
    level flag::wait_till( "intro_chryon_done" );
    level.hendricks_vtol clientfield::set( "vtol_engines_state", 1 );
    level.kane_vtol clientfield::set( "vtol_engines_state", 1 );
    
    foreach ( player in level.players )
    {
        player function_d683f26a();
        var_f13bfa4a[ var_f13bfa4a.size ] = player.pvtol;
    }
    
    level thread scene::play( "p7_fxanim_cp_aqu_war_airassault_bundle" );
    level thread scene::play( "cin_aqu_01_10_intro_1st_flyin_main", var_f13bfa4a );
    
    for ( index = 0; index < level.players.size ; index++ )
    {
        level.players[ index ] thread function_22a0413d( "scripted" );
        level.players[ index ] clientfield::set_player_uimodel( "vehicle.weaponIndex", 0 );
        level.players[ index ].pvtol takeplayercontrol();
        level.players[ index ].pvtol disabledriverfiring( 1 );
        level.players[ index ].pvtol disablegunnerfiring( 0, 1 );
        level.players[ index ] allowads( 0 );
        level.players[ index ] thread function_af376a0e( "v_aqu_01_10_intro_1st_flyin_player" + index + 1, index, "v_aqu_dogfight_intro_enemy" + index + 1, "intro_dogfight_global_active" );
        level.players[ index ].pvtol clientfield::set( "vtol_screen_shake", 1 );
    }
    
    level thread cp_mi_cairo_aquifer_sound::function_c800052a();
    level flag::wait_till( "intro_dialog_finished" );
    
    for ( index = 0; index < level.players.size ; index++ )
    {
        level.players[ index ].pvtol clientfield::set( "vtol_screen_shake", 0 );
    }
    
    level thread function_b7cf4d2d();
    level flag::wait_till( "flying_main_scene_done" );
    level flag::set( "intro_finished" );
}

// Namespace aquifer_util
// Params 1
// Checksum 0x58bae963, Offset: 0xc8b0
// Size: 0x22
function function_f005cfe( a_ents )
{
    level flag::set( "flying_main_scene_done" );
}

// Namespace aquifer_util
// Params 4
// Checksum 0x1132db3f, Offset: 0xc8e0
// Size: 0x2fa
function function_af376a0e( animname, index, section, var_84fe82cd )
{
    self endon( #"disconnect" );
    self thread function_22a0413d( "scripted" );
    self.pvtol clientfield::set( "vtol_show_missile_lock", 0 );
    self.pvtol waittillmatch( animname, "spawn_dogfight" );
    self.pvtol clientfield::set( "vtol_engines_state", 1 );
    thread function_14f37b59( section, 0, self, undefined, "flight_path_spawner" + index + 1 );
    
    while ( !isdefined( self.var_1d195e2c ) )
    {
        wait 0.05;
    }
    
    self weaponlockstart( self.var_1d195e2c );
    self thread function_9d40b42c();
    self.pvtol waittillmatch( animname, "attach_dogfight" );
    self.pvtol sethelidogfighting( 1 );
    level flag::set( "dogfighting" );
    self setvehiclefocusentity( self.var_1d195e2c );
    self.var_1d195e2c.dogfighter = self;
    self function_d683f26a();
    self thread function_22a0413d( "piloted" );
    self enableinvulnerability();
    self.pvtol vehicle::god_on();
    self.pvtol stopanimscripted( 0 );
    self.pvtol disabledriverfiring( 0 );
    self.pvtol disablegunnerfiring( 0, 0 );
    self.pvtol returnplayercontrol();
    self allowads( 0 );
    self flagsys::set( "dogfighting" );
    self.pvtol clientfield::set( "vtol_dogfighting", 1 );
    self.pvtol vehicle::toggle_exhaust_fx( 0 );
    self clientfield::set_player_uimodel( "vehicle.weaponIndex", 2 );
    self.pvtol setvehicletype( "veh_bo3_mil_vtol_fighter_player_dogfight" );
    self oob::disableplayeroob( 1 );
    self thread function_c5a27940( var_84fe82cd );
    util::wait_network_frame();
    self.pvtol vehicle::toggle_exhaust_fx( 1 );
}

// Namespace aquifer_util
// Params 0
// Checksum 0x32bc42ad, Offset: 0xcbe8
// Size: 0x1b2
function function_9d40b42c()
{
    self endon( #"disconnect" );
    level util::waittill_any_timeout( 7, "dogfighting" );
    self clientfield::set_player_uimodel( "vehicle.showAimHint", 1 );
    wait 3;
    self clientfield::set_player_uimodel( "vehicle.showAimHint", 0 );
    notifydata = spawnstruct();
    notifydata.notifytext2 = &"CP_MI_CAIRO_AQUIFER_VTOL_MISSILE_HINT";
    notifydata.duration = 5;
    self hud_message::notifymessage( notifydata );
    wait notifydata.duration;
    notifydata.notifytext2 = &"CP_MI_CAIRO_AQUIFER_VTOL_MG_HINT";
    self hud_message::notifymessage( notifydata );
    wait notifydata.duration;
    self hud_message::resetnotify();
    var_f6a2729b = 5;
    
    while ( var_f6a2729b > 0 && lengthsquared( self getnormalizedcameramovement() ) == 0 )
    {
        var_f6a2729b -= 0.05;
        wait 0.05;
    }
    
    if ( var_f6a2729b <= 0 )
    {
        notifydata.notifytext2 = &"CP_MI_CAIRO_AQUIFER_VTOL_AIM_HINT";
        notifydata.duration = 5;
        self hud_message::notifymessage( notifydata );
        wait notifydata.duration;
        self hud_message::resetnotify();
    }
}

// Namespace aquifer_util
// Params 2
// Checksum 0x7333acac, Offset: 0xcda8
// Size: 0x32
function function_a97555a0( ai_group, vol )
{
    spawner::add_spawn_function_ai_group( ai_group, &function_c11cfb53, vol );
}

// Namespace aquifer_util
// Params 1
// Checksum 0x4feba8f8, Offset: 0xcde8
// Size: 0x82
function function_c11cfb53( goalvol )
{
    self endon( #"death" );
    self util::magic_bullet_shield();
    
    while ( !isdefined( self.vehicle ) )
    {
        wait 0.1;
    }
    
    var_3770a3b5 = getent( goalvol, "targetname" );
    wait 1;
    self util::stop_magic_bullet_shield();
    self function_ab5de970( var_3770a3b5 );
}

// Namespace aquifer_util
// Params 3
// Checksum 0xc50cf9fb, Offset: 0xce78
// Size: 0x166, Type: bool
function explosion_launcher( from, radius, tname )
{
    assert( isvec( from ) );
    
    if ( !isdefined( radius ) )
    {
        radius = 512;
    }
    
    if ( !isdefined( tname ) )
    {
        tname = "aqu_explosion_launcher";
    }
    
    ss = getentarray( tname, "targetname" );
    ss = arraysortclosest( ss, from, 2, 0, radius );
    
    if ( isdefined( ss[ 0 ] ) )
    {
        s = ss[ 0 ];
        org = ( s.origin - from ) / 2;
        var_c3d535db = length( org ) + -56;
        org = s.origin - org - ( 0, 0, 72 );
        force = 2;
        physicsexplosionsphere( org, int( var_c3d535db ), int( var_c3d535db * 0.75 ), force );
        s delete();
        return true;
    }
    
    return false;
}

// Namespace aquifer_util
// Params 1
// Checksum 0xc64d9512, Offset: 0xcfe8
// Size: 0x5a
function function_ab5de970( vol )
{
    self endon( #"death" );
    self clearentitytarget();
    self cleargoalvolume();
    self clearforcedgoal();
    wait 0.05;
    self setgoalvolume( vol );
}

// Namespace aquifer_util
// Params 2
// Checksum 0x659c0666, Offset: 0xd050
// Size: 0x93
function function_c1bd6415( name, state )
{
    triggers = getentarray( name, "targetname" );
    
    foreach ( trigger in triggers )
    {
        trigger triggerenable( state );
    }
}

// Namespace aquifer_util
// Params 2
// Checksum 0xa7e7dde3, Offset: 0xd0f0
// Size: 0x93
function player_kill_triggers( targetname, state )
{
    triggers = getentarray( targetname, "targetname" );
    
    foreach ( trigger in triggers )
    {
        trigger triggerenable( state );
    }
}

// Namespace aquifer_util
// Params 1
// Checksum 0x65b32e43, Offset: 0xd190
// Size: 0x6a
function function_77fde091( state )
{
    clip = getent( "vtol_water_room_clip", "targetname" );
    
    if ( state == 1 )
    {
        clip solid();
        return;
    }
    
    clip notsolid();
}

// Namespace aquifer_util
// Params 0
// Checksum 0x78a2fbc5, Offset: 0xd208
// Size: 0xc3
function function_5a160fe7()
{
    wait 3;
    guys3 = spawn_manager::get_ai( "spawn_manager_hack_zone02_6" );
    wait 0.1;
    
    foreach ( guy in guys3 )
    {
        if ( isdefined( guy ) || isalive( guy ) )
        {
            guy kill();
            wait randomfloatrange( 0.8, 2.5 );
        }
    }
}

// Namespace aquifer_util
// Params 2
// Checksum 0x4c02d188, Offset: 0xd2d8
// Size: 0x123
function function_7d76ae16( current_vol, retreat_vol )
{
    var_8173bf49 = getent( current_vol, "targetname" );
    vol2 = getent( retreat_vol, "targetname" );
    guys = getaiteamarray( "axis" );
    
    foreach ( guy in guys )
    {
        if ( isdefined( guy ) || isalive( guy ) )
        {
            if ( guy istouching( var_8173bf49 ) )
            {
                guy thread function_ef807253( vol2 );
                wait randomfloatrange( 0.2, 0.8 );
            }
        }
    }
}

// Namespace aquifer_util
// Params 1
// Checksum 0x8dbafb7e, Offset: 0xd408
// Size: 0x8a
function function_ef807253( vol )
{
    self endon( #"death" );
    self clearentitytarget();
    self cleargoalvolume();
    self clearforcedgoal();
    self ai::set_ignoreall( 1 );
    wait randomfloatrange( 0.2, 1 );
    self setgoalvolume( vol );
    self ai::set_ignoreall( 0 );
}

// Namespace aquifer_util
// Params 0
// Checksum 0x2e41b4bc, Offset: 0xd4a0
// Size: 0x92
function function_367616d8()
{
    trigger::wait_till( "lcombat_ambient_flyby", "targetname" );
    jet = vehicle::simple_spawn_single_and_drive( "flyby_lcombat_ambient1" );
    level thread cp_mi_cairo_aquifer_sound::function_5dcd1d9();
    level flag::wait_till( "lcombat_flyby_shake" );
    earthquake( 0.5, 3, jet.origin, 4000 );
}

// Namespace aquifer_util
// Params 0
// Checksum 0xd54eaa1e, Offset: 0xd540
// Size: 0x42
function lcombat_crash_event()
{
    level thread scene::play( "lcombat_hunter_event_anim", "targetname" );
    wait 3;
    level scene::play( "lcombat_hunter_crash_trans", "targetname" );
}

// Namespace aquifer_util
// Params 0
// Checksum 0x572af24b, Offset: 0xd590
// Size: 0xba
function function_dfc31fd4()
{
    trigger::use( "redshirt_explode_event", "targetname" );
    level flag::wait_till( "player_really_landed" );
    level thread cp_mi_cairo_aquifer_sound::function_c3d203d6();
    var_cba21689 = struct::get( "redshirt_explosion", "targetname" );
    fx::play( "boss_explosion", var_cba21689.origin );
    radiusdamage( var_cba21689.origin, 120, 1000, 1000, undefined, undefined );
}

// Namespace aquifer_util
// Params 0
// Checksum 0x1f8ed31, Offset: 0xd658
// Size: 0x153
function function_8c7dc4c3()
{
    var_36e5f35c = vehicle::simple_spawn_single_and_drive( "lcombat_amb_hunter" );
    spawn_manager::enable( "spawn_manager_amb_hack_zone02_6" );
    level flag::wait_till( "inside_aquifer" );
    spawn_manager::disable( "spawn_manager_amb_hack_zone02_6" );
    
    if ( isdefined( var_36e5f35c ) && isalive( var_36e5f35c ) )
    {
        var_36e5f35c vehicle::kill_vehicle();
    }
    
    var_4e7924f6 = spawn_manager::get_ai( "spawn_manager_amb_hack_zone02_6" );
    
    foreach ( guy in var_4e7924f6 )
    {
        if ( isdefined( guy ) && isalive( guy ) )
        {
            guy kill();
            wait randomfloatrange( 0.2, 0.8 );
        }
    }
}

// Namespace aquifer_util
// Params 0
// Checksum 0xfd0b526, Offset: 0xd7b8
// Size: 0x103
function function_9cf1804b()
{
    level flag::wait_till( "lcombat_vtol_flyin" );
    level.var_bd9300b5 = vehicle::simple_spawn_single_and_drive( "lcombat_dropoff_vtol" );
    level.var_bd9300b5 waittill( #"reached_end_node" );
    
    if ( isdefined( level.var_bd9300b5 ) )
    {
        level.var_bd9300b5 delete();
    }
    
    var_5f515cec = spawner::get_ai_group_ai( "lcombat_enemy_vtol_riders" );
    
    foreach ( vtol_pilot in var_5f515cec )
    {
        if ( isdefined( vtol_pilot ) || isalive( vtol_pilot ) )
        {
            vtol_pilot delete();
        }
    }
}

// Namespace aquifer_util
// Params 0
// Checksum 0x43cd1c03, Offset: 0xd8c8
// Size: 0xa2
function function_3ba6e66c()
{
    wait 6;
    guys = spawner::get_ai_group_ai( "rpg_guys_lcombat" );
    
    foreach ( guy in guys )
    {
        guy setthreatbiasgroup( "lcombat_air_attack" );
    }
    
    setthreatbias( "players_vtol", "lcombat_air_attack", 10000 );
}

// Namespace aquifer_util
// Params 1
// Checksum 0x597046b0, Offset: 0xd978
// Size: 0x73
function function_255e711( guys )
{
    wait 1;
    
    if ( isdefined( guys ) )
    {
        foreach ( guy in guys )
        {
            if ( isdefined( guy ) )
            {
                guy kill();
            }
        }
    }
}

// Namespace aquifer_util
// Params 0
// Checksum 0x8b5cd6af, Offset: 0xd9f8
// Size: 0x26b
function function_f8243869()
{
    thread function_f0905754();
    level flag::wait_till( "inside_aquifer" );
    guys1 = spawn_manager::get_ai( "spawn_manager_lcombat_trans_wave1" );
    thread function_255e711( guys1 );
    guys2 = spawn_manager::get_ai( "spawn_manager_hack_zone02_4" );
    thread function_255e711( guys2 );
    guys3 = spawn_manager::get_ai( "spawn_manager_hack_zone02_5" );
    thread function_255e711( guys3 );
    shotgunners = spawner::get_ai_group_ai( "lcombat_shotgun_guys" );
    
    foreach ( shotgunner in shotgunners )
    {
        if ( isdefined( shotgunner ) || isalive( shotgunner ) )
        {
            shotgunner delete();
        }
    }
    
    foreach ( guy in level.var_6657ee03 )
    {
        if ( isdefined( guy ) || isalive( guy ) )
        {
            guy delete();
        }
    }
    
    var_1753830a = spawner::get_ai_group_ai( "lcombat_ally_secondwave" );
    
    foreach ( backup in var_1753830a )
    {
        if ( isdefined( backup ) || isalive( backup ) )
        {
            backup delete();
        }
    }
}

// Namespace aquifer_util
// Params 0
// Checksum 0xd4303e0, Offset: 0xdc70
// Size: 0x9b
function function_f0905754()
{
    wasps = spawner::get_ai_group_ai( "lcombat_wasp_wave" );
    
    foreach ( wasp in wasps )
    {
        if ( isdefined( wasp ) || isalive( wasp ) )
        {
            wasp kill();
        }
    }
}

// Namespace aquifer_util
// Params 1
// Checksum 0x4e71e96e, Offset: 0xdd18
// Size: 0x12a
function function_287ca2ad( state )
{
    top = getent( "hangar_umbra_top_door", "targetname" );
    top ghost();
    top notsolid();
    side1 = getent( "hangar_umbra_sidedoor_1", "targetname" );
    side1 ghost();
    side1 notsolid();
    side2 = getent( "hangar_umbra_sidedoor_2", "targetname" );
    side2 ghost();
    side2 notsolid();
    umbragate_set( "hangar_top_door", state );
    umbragate_set( "hangar_sidedoor1", state );
    umbragate_set( "hangar_sidedoor2", state );
}

// Namespace aquifer_util
// Params 1
// Checksum 0xf8093090, Offset: 0xde50
// Size: 0x14a
function function_c6b73822( var_6c968618 )
{
    level notify( #"hash_96450f49" );
    level.var_c37cadc1 setneargoalnotifydist( 120 );
    level.var_c37cadc1 setspeed( 75, 30, 30 );
    level.var_c37cadc1 setyawspeed( 59, -76, -76 );
    level.var_c37cadc1 sethoverparams( -128, 35, 35 );
    level.var_c37cadc1 clearlookatent();
    st = struct::get( var_6c968618 );
    level.var_c37cadc1.riders[ 0 ] clearenemy();
    level.var_c37cadc1 setvehgoalpos( st.origin, 1, 1 );
    level waittill( #"hash_7e64f485" );
    wait 1;
    level.var_c37cadc1.riders[ 0 ] delete();
    level.var_c37cadc1 delete();
}

// Namespace aquifer_util
// Params 1
// Checksum 0x9de3b6db, Offset: 0xdfa8
// Size: 0x93
function function_f3326322( tname )
{
    level waittill( #"hack_terminal_right_completed" );
    wait 8;
    active = getentarray( tname, "targetname" );
    
    foreach ( veh in active )
    {
        veh delete();
    }
}

// Namespace aquifer_util
// Params 0
// Checksum 0xa78dd14a, Offset: 0xe048
// Size: 0x171
function function_99b61785()
{
    self endon( #"death" );
    self endon( #"hack_terminal_right_completed" );
    self.favoriteenemy = level.var_c37cadc1.riders[ 0 ];
    level.var_c37cadc1.riders[ 0 ].favorite_enemy = self;
    self setneargoalnotifydist( 512 );
    self.favoriteenemy = level.var_c37cadc1.riders[ 0 ];
    self setvehgoalpos( level.var_c37cadc1.riders[ 0 ].origin, 1, 1 );
    self util::waittill_any_timeout( 20, "near_goal", "goal" );
    self clearvehgoalpos();
    
    while ( true )
    {
        if ( !isdefined( self.enemy ) )
        {
            self.favoriteenemy = level.var_c37cadc1.riders[ 0 ];
            self setvehgoalpos( level.var_c37cadc1.riders[ 0 ].origin, 1, 1 );
            self util::waittill_any_timeout( 20, "near_goal", "goal" );
            self clearvehgoalpos();
            self.favoriteenemy = level.var_c37cadc1.riders[ 0 ];
            wait 5;
        }
        
        wait 0.5;
    }
}

// Namespace aquifer_util
// Params 0
// Checksum 0x6ca7ba0b, Offset: 0xe1c8
// Size: 0x7a
function function_c386420b()
{
    self setthreatbiasgroup( "defend_hunters" );
    setignoremegroup( "players_ground", "defend_hunters" );
    self.var_d3f57f67 = 1;
    self getperfectinfo( level.var_c37cadc1.riders[ 0 ], 1 );
    self.favoriteenemy = level.var_c37cadc1.riders[ 0 ];
}

// Namespace aquifer_util
// Params 0
// Checksum 0x407d4e90, Offset: 0xe250
// Size: 0x123
function exterior_aerial_threats()
{
    if ( isdefined( level.var_3bfa4edb ) )
    {
        return;
    }
    
    level.var_3bfa4edb = 1;
    level endon( #"hack_terminal_right_completed" );
    tname = "hunter_exterior_auto1";
    vehicle::add_spawn_function( tname, &function_c386420b );
    thread function_f3326322( tname + "_vh" );
    aerial_enemy_spawners = getentarray( tname, "targetname" );
    wait 3;
    
    while ( true )
    {
        if ( isdefined( level.skipto_current_objective ) && isdefined( level.skipto_current_objective[ 0 ] ) )
        {
            if ( level.skipto_current_objective[ 0 ] == "destroy_defenses_mid" )
            {
                wait 5;
                continue;
            }
        }
        
        veh = vehicle::_vehicle_spawn( array::random( aerial_enemy_spawners ) );
        veh.crashtype = "explode";
        veh thread function_99b61785();
        veh waittill( #"death" );
        wait 1;
    }
}

// Namespace aquifer_util
// Params 2
// Checksum 0xb9150f5a, Offset: 0xe380
// Size: 0x3e3
function function_96450f49( var_6c968618, var_a3a78823 )
{
    level notify( #"hash_96450f49" );
    level endon( #"hash_96450f49" );
    
    /#
    #/
    
    if ( !isdefined( level.var_c37cadc1 ) )
    {
        wait 1;
        level.var_c37cadc1 = vehicle::simple_spawn_single( "vtol_hendricks_flysit" );
        wait 1;
    }
    
    if ( !isdefined( level.var_c37cadc1 ) )
    {
        return;
    }
    
    level thread exterior_aerial_threats();
    base = [];
    
    for ( st = struct::get( var_6c968618 + base.size + 1 ); isdefined( st ) ; st = struct::get( var_6c968618 + base.size + 1 ) )
    {
        base[ base.size ] = st;
    }
    
    focus = getent( var_6c968618 + "focus", "targetname" );
    isrockettype = 1;
    
    if ( isrockettype )
    {
        level.var_c37cadc1 setvehweapon( getweapon( "vtol_fighter_player_missile_turret" ) );
        level.var_c37cadc1 turret::enable( 1, 0 );
        level.var_c37cadc1 turret::disable( 0 );
    }
    else
    {
        level.var_c37cadc1 setvehweapon( getweapon( "vtol_fighter_player_turret" ) );
        level.var_c37cadc1 turret::enable( 0, 0 );
        level.var_c37cadc1 turret::disable( 1 );
    }
    
    level.var_c37cadc1 vehicle::god_on();
    level.var_c37cadc1.riders[ 0 ] util::magic_bullet_shield();
    level.var_c37cadc1 thread function_5b6daa1a( focus, isrockettype, var_a3a78823 );
    var_e0ad81ed = 1;
    add = -1;
    level.var_c37cadc1 setneargoalnotifydist( 120 );
    level.var_c37cadc1 setspeed( 75, 30, 30 );
    level.var_c37cadc1 setyawspeed( 59, -76, -76 );
    level.var_c37cadc1 sethoverparams( -128, 35, 35 );
    goalpos = base[ var_e0ad81ed ].origin;
    goalyaw = base[ var_e0ad81ed ].angles[ 1 ];
    hendricks = level.var_c37cadc1.riders[ 0 ];
    hendricks ai::gun_remove();
    vtol = level.var_c37cadc1;
    vtol setlookatent( focus );
    
    while ( isdefined( level.var_c37cadc1 ) )
    {
        hendricks clearenemy();
        vtol setvehgoalpos( goalpos, 1, 1 );
        vtol util::waittill_any_timeout( 15, "near_goal", "goal" );
        var_e0ad81ed += add;
        
        if ( var_e0ad81ed < 0 || var_e0ad81ed >= base.size )
        {
            add *= -1;
            var_e0ad81ed += add * 2;
        }
        
        goalpos = base[ var_e0ad81ed ].origin;
        goalyaw = base[ var_e0ad81ed ].angles[ 1 ];
        wait 8;
    }
}

// Namespace aquifer_util
// Params 0
// Checksum 0xe1ba06b3, Offset: 0xe770
// Size: 0x135
function function_9476c2d5()
{
    self endon( #"death" );
    level endon( #"hash_96450f49" );
    self.var_36c3df0c = 0.5;
    
    if ( !isdefined( self.var_51cc2ae ) )
    {
        self.var_51cc2ae = 0;
    }
    
    while ( true )
    {
        var_6d4fe22b = 0;
        
        if ( isdefined( self.var_bded8100 ) )
        {
            var_6d4fe22b = angleclamp180( vectortoangles( self.var_bded8100.origin - self.origin )[ 0 ] );
            var_6d4fe22b = math::clamp( var_6d4fe22b, -30, 30 );
        }
        
        if ( abs( var_6d4fe22b - self.var_51cc2ae ) <= self.var_36c3df0c )
        {
            self.var_51cc2ae = var_6d4fe22b;
        }
        else if ( var_6d4fe22b < self.var_51cc2ae )
        {
            self.var_51cc2ae = self.var_51cc2ae - self.var_36c3df0c;
        }
        else
        {
            self.var_51cc2ae = self.var_51cc2ae + self.var_36c3df0c;
        }
        
        self setdefaultpitch( self.var_51cc2ae );
        wait 0.05;
    }
}

// Namespace aquifer_util
// Params 3
// Checksum 0xd2d2885d, Offset: 0xe8b0
// Size: 0x3d5
function function_5b6daa1a( focus, isrockettype, var_a3a78823 )
{
    self endon( #"death" );
    level endon( #"hash_96450f49" );
    self.var_bded8100 = undefined;
    self thread function_9476c2d5();
    
    while ( true )
    {
        enemy = focus;
        
        if ( isdefined( self.enemy ) )
        {
            enemy = self.enemy;
        }
        else if ( isdefined( self.riders[ 0 ] ) && isdefined( self.riders[ 0 ].enemy ) )
        {
            enemy = self.riders[ 0 ].enemy;
        }
        else if ( isdefined( self.riders[ 0 ].favoriteenemy ) )
        {
            enemy = self.riders[ 0 ].favoriteenemy;
        }
        else
        {
            ai_array = getaiteamarray( "axis" );
            ai_array = arraysortclosest( ai_array, self.origin, 15, 512, 10000 );
            
            foreach ( ai in ai_array )
            {
                if ( !isdefined( ai ) )
                {
                    continue;
                }
                
                if ( var_a3a78823 && !isvehicle( ai ) )
                {
                    continue;
                }
                
                if ( self function_8b6935f4( ai ) )
                {
                    enemy = ai;
                    self.riders[ 0 ].favoriteenemy = enemy;
                    break;
                }
                
                wait 0.05;
            }
        }
        
        if ( enemy == focus )
        {
            self.var_bded8100 = undefined;
            wait 0.5;
            continue;
        }
        
        self.var_bded8100 = enemy;
        self setlookatent( enemy );
        
        if ( isrockettype )
        {
            self setturrettargetent( enemy, enemy.origin + ( 0, 0, 60 ) );
        }
        else
        {
            self setturrettargetent( enemy, enemy.origin + ( 0, 0, 60 ) );
        }
        
        wait 0.4;
        
        if ( isdefined( enemy ) )
        {
            if ( isrockettype )
            {
                for ( i = 0; i < 2 && isdefined( enemy ) ; i++ )
                {
                    thread aquifer_obj::function_6a7fa9c7( getweapon( "vtol_fighter_player_missile_turret" ) );
                    self fireweapon( 0, enemy );
                    fired = 1;
                    wait 0.25;
                }
            }
            else
            {
                self vehicle_ai::fire_for_time( randomfloatrange( 0.3, 0.6 ) );
            }
        }
        
        if ( isrockettype )
        {
            if ( isdefined( enemy ) && isai( enemy ) )
            {
                wait randomfloatrange( 1, 2 );
            }
            else
            {
                wait randomfloatrange( 3, 5 );
            }
        }
        else if ( isdefined( enemy ) && isai( enemy ) )
        {
            wait randomfloatrange( 2, 2.5 );
        }
        else
        {
            wait randomfloatrange( 0.5, 1.5 );
        }
        
        wait 0.4;
        
        if ( !self function_8b6935f4( enemy ) )
        {
            self.riders[ 0 ] clearenemy();
        }
    }
}

// Namespace aquifer_util
// Params 1
// Checksum 0xdd423385, Offset: 0xec90
// Size: 0x99, Type: bool
function function_8b6935f4( ai )
{
    if ( !isdefined( ai ) )
    {
        return false;
    }
    
    dot = get_dot( self.origin, self.angles, ai.origin );
    
    if ( dot >= 0.7 )
    {
        if ( sighttracepassed( self.riders[ 0 ].origin + ( 0, 0, 150 ), ai.origin + ( 0, 0, 72 ), 0, ai ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace aquifer_util
// Params 1
// Checksum 0xb356332c, Offset: 0xed38
// Size: 0x3a
function function_11b961b7( params )
{
    self endon( #"death" );
    self endon( #"change_state" );
    self setbrake( 1 );
    function_197eec5b( self );
}

// Namespace aquifer_util
// Params 1
// Checksum 0xfe8d7838, Offset: 0xed80
// Size: 0x2f
function function_197eec5b( tank )
{
    if ( !isdefined( level.var_be665c ) )
    {
        level.var_be665c = [];
    }
    
    level.var_be665c[ level.var_be665c.size ] = tank;
}

// Namespace aquifer_util
// Params 0
// Checksum 0x4e02ed96, Offset: 0xedb8
// Size: 0x12
function function_25207b76()
{
    level notify( #"hash_194eb1ad" );
    level.var_be665c = [];
}

// Namespace aquifer_util
// Params 1
// Checksum 0x397dbe6d, Offset: 0xedd8
// Size: 0x2e
function function_16288b69( count )
{
    level.var_c43e24b3 += count;
    wait 5;
    level.var_c43e24b3 -= count;
}

// Namespace aquifer_util
// Params 0
// Checksum 0xa13a6300, Offset: 0xee10
// Size: 0x196
function function_6e0553f9()
{
    level.var_c43e24b3 = 0;
    
    while ( level.var_be665c.size > 0 )
    {
        level.var_c9b8441d = 16;
        var_ce455ef1 = max( 1, level.players.size / 2 );
        level.var_c9b8441d = int( level.var_c9b8441d / var_ce455ef1 );
        level.var_be665c = array::remove_dead( level.var_be665c );
        
        foreach ( tank in level.var_be665c )
        {
            if ( isalive( tank ) && level.var_c43e24b3 < level.var_c9b8441d )
            {
                var_70792a26 = level.var_c9b8441d - level.var_c43e24b3;
                shots_fired = tank function_9ab6fc55( min( 3, var_70792a26 ), min( 6, var_70792a26 ) );
                
                if ( shots_fired > 0 )
                {
                    thread function_16288b69( shots_fired );
                }
            }
            
            wait 0.25;
        }
        
        wait 5;
    }
    
    done = 1;
}

// Namespace aquifer_util
// Params 0
// Checksum 0xee072e02, Offset: 0xefb0
// Size: 0x12d
function function_a330eeec()
{
    self endon( #"death" );
    self endon( #"end_attack_thread" );
    self endon( #"change_state" );
    self notify( #"hash_97c91db2" );
    self endon( #"hash_97c91db2" );
    missile_speed = 2900;
    
    while ( true )
    {
        if ( !isdefined( self.enemy ) )
        {
            wait 0.3;
            continue;
        }
        
        target = self.enemy;
        
        if ( isdefined( self.enemy.pvtol ) )
        {
            target = self.enemy.pvtol;
        }
        
        to = target.origin - self.origin + ( 0, 0, 72 );
        dist = length( to );
        travel_time = dist / missile_speed;
        vel = target getvelocity();
        aim_org = target.origin + vel * travel_time;
        
        /#
        #/
        
        self setturrettargetvec( aim_org );
        wait 0.05;
    }
}

// Namespace aquifer_util
// Params 2
// Checksum 0x6915bd2, Offset: 0xf0e8
// Size: 0x3db
function function_9ab6fc55( var_5fe70955, max_missiles )
{
    self endon( #"death" );
    self endon( #"end_attack_thread" );
    self vehicle::toggle_ambient_anim_group( 2, 0 );
    self thread function_a330eeec();
    fired = 0;
    var_85596fc1 = 0;
    usejavelin = 0;
    
    if ( isdefined( self.enemy ) && vehicle_ai::iscooldownready( "rocket_launcher", 0.1 ) )
    {
        var_30e3f243 = distance2dsquared( self.origin, self.enemy.origin );
        
        if ( var_30e3f243 > 64000000 )
        {
            return 0;
        }
        
        self vehicle::toggle_ambient_anim_group( 2, 1 );
        
        if ( max_missiles > var_5fe70955 )
        {
            var_85596fc1 = randomintrange( int( var_5fe70955 ), int( max_missiles ) );
        }
        else
        {
            var_85596fc1 = max_missiles;
        }
        
        if ( !usejavelin )
        {
            self setvehweapon( getweapon( "quadtank_main_turret_rocketpods_straight_homing" ) );
        }
        else
        {
            var_85596fc1 = 2;
            self playsound( "veh_quadtank_mlrs_plant_start" );
            self setvehweapon( getweapon( "quadtank_main_turret_rocketpods_javelin" ) );
        }
        
        if ( isdefined( self.enemy ) && !isplayer( self.enemy ) )
        {
            var_85596fc1 = 1;
        }
        
        if ( isdefined( self.enemy ) && var_30e3f243 > 350 * 350 )
        {
            fired = 0;
            
            for ( i = 0; i < var_85596fc1 && isdefined( self.enemy ) ; i++ )
            {
                if ( usejavelin )
                {
                    offset = ( 0, 0, 0 );
                    self thread vehicle_ai::javelin_losetargetatrighttime( self.enemy );
                    self thread quadtank::javeline_incoming( getweapon( "quadtank_main_turret_rocketpods_javelin" ) );
                    
                    if ( isvehicle( self.enemy ) )
                    {
                        offset = self.enemy gettagorigin( "tag_body" ) - self.enemy.origin;
                    }
                    
                    self fireweapon( 0, self.enemy, offset );
                }
                else
                {
                    self thread function_b7aaca29( getweapon( "quadtank_main_turret_rocketpods_straight_homing" ) );
                    self fireweapon( 0 );
                }
                
                fired = 1;
            }
            
            if ( fired )
            {
                cooldown = 12;
                
                if ( isdefined( self.enemy ) )
                {
                    dot = get_dot( self.enemy.origin, self.enemy.angles, self.origin );
                    
                    if ( dot > 0.9 )
                    {
                        cooldown = 4;
                    }
                    else if ( dot > 0.5 )
                    {
                        cooldown = 6;
                    }
                }
                
                vehicle_ai::cooldown( "rocket_launcher", cooldown );
                
                if ( usejavelin )
                {
                    vehicle_ai::cooldown( "javelin_rocket_launcher", 20 );
                }
            }
        }
        
        self vehicle::toggle_ambient_anim_group( 2, 0 );
    }
    
    if ( fired )
    {
        return var_85596fc1;
    }
    
    return 0;
}

// Namespace aquifer_util
// Params 1
// Checksum 0xa0c8bae9, Offset: 0xf4d0
// Size: 0xba
function function_b7aaca29( projectile )
{
    self endon( #"entityshutdown" );
    self endon( #"death" );
    self waittill( #"weapon_fired", projectile );
    wait 0.75;
    
    if ( isdefined( projectile ) )
    {
        offset = ( 0, 0, 0 );
        
        if ( isvehicle( self.enemy ) )
        {
            offset = self.enemy gettagorigin( "tag_body" ) - self.enemy.origin;
        }
        
        projectile missile_settarget( self.enemy, offset );
    }
    
    wait 4;
    
    if ( isdefined( projectile ) )
    {
        projectile delete();
    }
}

// Namespace aquifer_util
// Params 1
// Checksum 0x7231d791, Offset: 0xf598
// Size: 0x1a9
function function_c897523d( active )
{
    respawners = [];
    respawners[ respawners.size ] = "respawn_ext_water_room";
    respawners[ respawners.size ] = "respawn_in_water_room";
    respawners[ respawners.size ] = "respawn_in_data_center";
    respawners[ respawners.size ] = "respawn_water_room";
    respawners[ respawners.size ] = "respawn_lcombat";
    respawners[ respawners.size ] = "respawn_right_hack";
    respawners[ respawners.size ] = "respawn_left_hack";
    
    if ( !isdefined( active ) )
    {
        active = "none";
    }
    
    for ( i = 0; i < respawners.size ; i++ )
    {
        spawners = getentarray( respawners[ i ], "script_noteworthy", 1 );
        spawners = struct::get_array( respawners[ i ], "script_noteworthy" );
        
        if ( spawners.size == 0 )
        {
            continue;
        }
        
        if ( respawners[ i ] == active )
        {
            foreach ( spawner in spawners )
            {
                spawner spawnlogic::function_82c857e9( 0 );
            }
            
            continue;
        }
        
        foreach ( spawner in spawners )
        {
            spawner spawnlogic::function_82c857e9( 1 );
        }
    }
}

// Namespace aquifer_util
// Params 3
// Checksum 0xa7a7ee85, Offset: 0xf750
// Size: 0x76
function get_dot( start_origin, start_angles, end_origin )
{
    normal = vectornormalize( end_origin - start_origin );
    forward = anglestoforward( start_angles );
    dot = vectordot( forward, normal );
    return dot;
}

// Namespace aquifer_util
// Params 1
// Checksum 0x9a8cb27d, Offset: 0xf7d0
// Size: 0xb3
function function_8bf8a765( hide )
{
    if ( !isdefined( hide ) )
    {
        hide = 1;
    }
    
    foreach ( player in level.activeplayers )
    {
        if ( isdefined( player.pvtol ) )
        {
            if ( hide )
            {
                player.pvtol ghost();
                continue;
            }
            
            player.pvtol show();
        }
    }
}

// Namespace aquifer_util
// Params 1
// Checksum 0xd3c517f8, Offset: 0xf890
// Size: 0x42
function function_89eaa1b3( time )
{
    self endon( #"disconnect" );
    self clientfield::set_to_player( "hijack_static_effect", 1 );
    wait time;
    self clientfield::set_to_player( "hijack_static_effect", 0 );
}

/#

    // Namespace aquifer_util
    // Params 0
    // Checksum 0x297bd5e3, Offset: 0xf8e0
    // Size: 0x105, Type: dev
    function debug_ambient_vehicle()
    {
        self endon( #"death" );
        des_speed = 120;
        
        while ( true )
        {
            des_speed = self getspeedmph();
            color = ( 1, 1, 1 );
            size = 12;
            speed = velocity_to_mph( self getvelocity() );
            
            if ( speed < des_speed - 10 )
            {
                color = ( 0, 0, 1 );
            }
            else if ( speed > des_speed + 10 )
            {
                color = ( 1, 0, 0 );
            }
            else
            {
                size = 6;
            }
            
            print3d( self.origin + ( 0, 0, 400 ), des_speed, ( 1, 1, 1 ), 1, 6 );
            print3d( self.origin + ( 0, 0, 120 ), speed, color, 1, size );
            wait 0.05;
        }
    }

#/
