#using script_3dc93ca9902a9cda;
#using script_4ab78e327b76395f;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\animation_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\zipline;
#using scripts\cp_common\hint_tutorial;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;

#namespace namespace_8af9269b;

// Namespace namespace_8af9269b/namespace_8af9269b
// Params 0, eflags: 0x6
// Checksum 0xbab13a97, Offset: 0x4e0
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"hash_2261850aec98f6f8", &preload, undefined, undefined, undefined );
}

// Namespace namespace_8af9269b/namespace_8af9269b
// Params 0
// Checksum 0x19d28cf5, Offset: 0x528
// Size: 0x1f4
function preload()
{
    clientfield::register( "toplayer", "zipline_postfx", 1, 1, "int" );
    clientfield::register( "toplayer", "zipline_gesture_strap_visibility", 1, 1, "int" );
    clientfield::register( "toplayer", "zipline_player_landing_fx", 1, 2, "counter" );
    clientfield::register( "actor", "zipline_ai_landing_fx", 1, 2, "counter" );
    clientfield::register( "scriptmover", "zipline_strap_visibility", 1, 1, "int" );
    animationstatenetwork::registernotetrackhandlerfunction( "zipline_spawn_prop", &function_38cb6163 );
    setdvar( #"hash_62b74e3b3b1fc836", 1 );
    setdvar( #"hash_3ec5964e8c4f81da", 0 );
    level.var_ab0a4e81 = &function_7a073e82;
    level.var_7428aa92 = &function_a8f3484;
    level.var_42da2b06 = &function_e9f7f0d4;
    level.var_ebc8a996 = &function_f33d0f47;
    level.var_ad1d5b82 = &function_c9a7989e;
    level.var_4b3860d7 = &function_b8e9daa0;
}

// Namespace namespace_8af9269b/namespace_8af9269b
// Params 9
// Checksum 0x923bbef, Offset: 0x728
// Size: 0x35c
function function_1acebbc0( str_targetname, var_a375f19a = 1, var_dc6e66ea = 1, z_offset = 80, var_c9f2a2 = 0, var_23f866eb = 0, var_1b1aded2 = 0, var_fc006495 = undefined, var_1e72ce9a = 0 )
{
    var_cf56bb8f = getent( str_targetname, "targetname" );
    assert( isdefined( var_cf56bb8f ), "<dev string:x38>" + str_targetname );
    var_cf56bb8f.var_a375f19a = var_a375f19a;
    var_cf56bb8f.var_dc6e66ea = var_dc6e66ea;
    var_cf56bb8f.z_offset = z_offset;
    var_cf56bb8f.var_c9f2a2 = var_c9f2a2;
    var_cf56bb8f.var_23f866eb = var_23f866eb;
    var_cf56bb8f.var_1b1aded2 = var_1b1aded2;
    var_cf56bb8f.var_fc006495 = var_fc006495;
    assert( isdefined( var_cf56bb8f.target2 ), var_cf56bb8f.targetname + "<dev string:x82>" );
    var_9f483599 = struct::get( var_cf56bb8f.target2, "targetname" );
    var_9f483599.var_cf56bb8f = var_cf56bb8f;
    var_cf56bb8f.var_9f483599 = var_9f483599;
    var_cf56bb8f function_33c566c();
    var_cf56bb8f function_84ca6381();
    
    if ( var_1e72ce9a )
    {
        var_cf56bb8f thread zipline::function_a8c07396( var_cf56bb8f.v_start_pos, var_cf56bb8f.v_end_pos, var_cf56bb8f.origin );
    }
    
    level flag::wait_till( "game_start" );
    
    if ( is_true( var_cf56bb8f.var_c9f2a2 ) )
    {
        var_cf56bb8f.var_9f483599 util::create_cursor_hint( undefined, undefined, #"hash_65784960e7f05b72", 1500, 0, undefined, undefined, 1000, 180, 0, 1, 0, &function_e1a2819 );
    }
    else
    {
        var_cf56bb8f.var_9f483599 util::create_cursor_hint( undefined, undefined, #"hash_65784960e7f05b72", 1500, 0, undefined, undefined, 1000, 180, 0, 1, 0, &function_819ed9b3 );
    }
    
    var_cf56bb8f thread function_7b4b64fb();
    var_cf56bb8f thread function_d41f7e0e();
}

// Namespace namespace_8af9269b/namespace_8af9269b
// Params 0, eflags: 0x4
// Checksum 0x43e4a45, Offset: 0xa90
// Size: 0x18e
function private function_84ca6381()
{
    n_distance = distance( self.v_start_pos, self.v_end_pos );
    var_fce4ba4e = self.v_start_pos[ 2 ] - self.v_end_pos[ 2 ];
    var_dcd5b4c5 = asin( var_fce4ba4e / n_distance );
    assert( var_dcd5b4c5 >= 2, "<dev string:xbf>" + var_dcd5b4c5 + "<dev string:xdf>" );
    assert( var_dcd5b4c5 <= 25, "<dev string:xbf>" + var_dcd5b4c5 + "<dev string:x123>" );
    var_aff2bad6 = 6.5;
    
    if ( var_dcd5b4c5 > 6 )
    {
        var_597b2be3 = var_dcd5b4c5 - 6;
        var_1161bec3 = var_597b2be3 / 19;
        var_aff2bad6 += lerpfloat( 0, 15, var_1161bec3 );
    }
    
    self.n_distance = n_distance;
    self.var_dcd5b4c5 = var_dcd5b4c5;
    self.var_aff2bad6 = var_aff2bad6;
    self.var_333fa1fd = 0;
}

// Namespace namespace_8af9269b/namespace_8af9269b
// Params 0
// Checksum 0xce874553, Offset: 0xc28
// Size: 0x196
function function_33c566c()
{
    var_cf04fc05 = getvehiclenode( self.target, "targetname" );
    self.var_ad1b31ea = var_cf04fc05;
    self.v_start_pos = var_cf04fc05.origin;
    self.var_d9c9a508 = [];
    
    if ( !isdefined( self.var_d9c9a508 ) )
    {
        self.var_d9c9a508 = [];
    }
    else if ( !isarray( self.var_d9c9a508 ) )
    {
        self.var_d9c9a508 = array( self.var_d9c9a508 );
    }
    
    self.var_d9c9a508[ self.var_d9c9a508.size ] = var_cf04fc05;
    
    while ( isdefined( var_cf04fc05.target ) )
    {
        var_cf04fc05 = getvehiclenode( var_cf04fc05.target, "targetname" );
        
        if ( !isdefined( self.var_d9c9a508 ) )
        {
            self.var_d9c9a508 = [];
        }
        else if ( !isarray( self.var_d9c9a508 ) )
        {
            self.var_d9c9a508 = array( self.var_d9c9a508 );
        }
        
        self.var_d9c9a508[ self.var_d9c9a508.size ] = var_cf04fc05;
    }
    
    self.var_afbab71e = var_cf04fc05;
    self.v_end_pos = var_cf04fc05.origin;
    self.var_ad1b31ea.var_cf56bb8f = self;
}

// Namespace namespace_8af9269b/namespace_8af9269b
// Params 1
// Checksum 0xcf16f406, Offset: 0xdc8
// Size: 0xd6, Type: bool
function function_e1a2819( *s_info )
{
    return level.player isonground() && level.player istouching( self.var_cf56bb8f ) && !is_true( level.player.is_ziplining ) && !level.player flag::get( "body_shield_active" ) && !level.player namespace_5f6e61d9::function_cad84e26() && !level.player scene::function_c935c42();
}

// Namespace namespace_8af9269b/namespace_8af9269b
// Params 1
// Checksum 0x8bf631c4, Offset: 0xea8
// Size: 0xbe, Type: bool
function function_819ed9b3( *s_info )
{
    return level.player istouching( self.var_cf56bb8f ) && !is_true( level.player.is_ziplining ) && !level.player flag::get( "body_shield_active" ) && !level.player namespace_5f6e61d9::function_cad84e26() && !level.player scene::function_c935c42();
}

// Namespace namespace_8af9269b/namespace_8af9269b
// Params 0, eflags: 0x4
// Checksum 0x9e692817, Offset: 0xf70
// Size: 0x22e
function private function_7b4b64fb()
{
    level endon( #"game_ended" );
    a_e_players = getplayers();
    e_player = a_e_players[ 0 ];
    e_player endon( #"death" );
    
    if ( self.var_c9f2a2 )
    {
        while ( true )
        {
            if ( !is_true( e_player.is_ziplining ) && e_player isonground() && e_player istouching( self ) && e_player usebuttonpressed() && !e_player flag::get( "body_shield_active" ) && !e_player namespace_5f6e61d9::function_cad84e26() && !e_player scene::function_c935c42() )
            {
                self.var_9f483599 notify( #"trigger" );
            }
            
            waitframe( 1 );
        }
        
        return;
    }
    
    while ( true )
    {
        if ( !is_true( e_player.is_ziplining ) && e_player istouching( self ) && e_player usebuttonpressed() && !e_player flag::get( "body_shield_active" ) && !e_player namespace_5f6e61d9::function_cad84e26() && !e_player scene::function_c935c42() )
        {
            self.var_9f483599 notify( #"trigger" );
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_8af9269b/namespace_8af9269b
// Params 0, eflags: 0x4
// Checksum 0xeb6b49f1, Offset: 0x11a8
// Size: 0xde2
function private function_d41f7e0e()
{
    level endon( #"game_ended" );
    a_e_players = getplayers();
    e_player = a_e_players[ 0 ];
    e_player endoncallback( &function_3dbd3643, #"death" );
    
    while ( true )
    {
        self.var_9f483599 waittill( #"trigger" );
        
        if ( !is_true( e_player.is_ziplining ) && !e_player isreloading() && !e_player util::is_ads() )
        {
            var_1a43c7ac = self.n_distance;
            var_56a048f8 = self.var_dcd5b4c5;
            var_900ff2c3 = self.var_aff2bad6 * self.var_a375f19a;
            
            if ( var_900ff2c3 < 1 )
            {
                var_900ff2c3 = 1;
            }
            else if ( var_900ff2c3 > 35 )
            {
                var_900ff2c3 = 35;
            }
            
            var_6aa64d21 = self.var_333fa1fd;
            e_player.is_ziplining = 1;
            e_player.var_d7d83470 = self.targetname;
            e_player notify( #"player_zipline_start", { #var_14af458a:self.targetname } );
            var_d571c86 = e_player getplayerspeed();
            
            if ( is_true( self.var_1b1aded2 ) && isdefined( self.var_d9c9a508 ) && self.var_d9c9a508.size > 2 )
            {
                self zipline::function_63d01c33();
            }
            
            e_player function_f5ce83f7();
            var_b20b0960 = spawner::simple_spawn_single( getent( "veh_zipline", "targetname" ) );
            
            while ( !isdefined( var_b20b0960 ) )
            {
                waitframe( 1 );
            }
            
            var_b20b0960 setmovingplatformenabled( 1 );
            w_current = e_player getcurrentweapon();
            
            if ( is_true( self.var_c9f2a2 ) )
            {
                self function_76a94f6f( e_player );
                waitframe( 1 );
                e_player setplayerangles( self.var_ad1b31ea.angles );
                waitframe( 1 );
            }
            else
            {
                var_e87fe6aa = zipline::function_61418721( e_player.origin, self.v_start_pos, self.v_end_pos );
                
                if ( e_player isonground() )
                {
                    if ( w_current hms_util::function_17fe30b7() )
                    {
                        e_player setlowready( 1 );
                    }
                    
                    waitframe( 1 );
                    e_player playgestureviewmodel( "ges_t9_cp_zipline_start" );
                    var_5385c2b6 = util::spawn_model( #"tag_origin", e_player.origin, e_player.angles );
                    
                    while ( !isdefined( var_5385c2b6 ) )
                    {
                        waitframe( 1 );
                    }
                    
                    e_player playerlinktodelta( var_5385c2b6, "tag_origin", 1, 95, 95, 45, 45 );
                    var_5385c2b6 rotateto( self.var_ad1b31ea.angles, 0.5 );
                    var_ab2bf9d7 = getclosestpointonnavmesh( var_e87fe6aa, 200 );
                    
                    if ( isdefined( var_ab2bf9d7 ) )
                    {
                        var_5385c2b6 moveto( var_ab2bf9d7, 0.4 );
                        wait 0.3;
                        var_5385c2b6 moveto( var_e87fe6aa - ( 0, 0, 80 ), 0.075 );
                        wait 0.2;
                    }
                    else
                    {
                        var_5385c2b6 moveto( var_e87fe6aa - ( 0, 0, 80 ), 0.375 );
                        wait 0.5;
                    }
                    
                    var_5385c2b6 unlink();
                    var_5385c2b6 delete();
                    e_player setlowready( 0 );
                }
                else
                {
                    if ( !w_current hms_util::function_17fe30b7() )
                    {
                        e_player playgestureviewmodel( "ges_t9_cp_zipline_start" );
                    }
                    
                    e_player function_4522ae79( var_e87fe6aa );
                }
            }
            
            var_e87fe6aa = zipline::function_61418721( e_player.origin, self.v_start_pos, self.v_end_pos );
            self.var_ad1b31ea.origin = var_e87fe6aa;
            var_b20b0960.origin = var_e87fe6aa;
            var_b20b0960.angles = e_player.angles;
            e_player.var_b20b0960 = var_b20b0960;
            var_5385c2b6 = util::spawn_model( #"tag_origin", e_player.origin, e_player.angles );
            var_5385c2b6 setmovingplatformenabled( 1 );
            e_player.var_5385c2b6 = var_5385c2b6;
            
            if ( is_true( self.var_23f866eb ) )
            {
                var_22dd3701 = 38;
                var_3e1e5ecd = 22.5;
            }
            else
            {
                var_22dd3701 = 95;
                var_3e1e5ecd = 45;
            }
            
            var_5385c2b6 linkto( var_b20b0960, undefined, ( 0, 0, 80 * -1 ) );
            e_player playerlinktodelta( var_5385c2b6, undefined, 1, var_22dd3701, var_22dd3701, var_3e1e5ecd, var_3e1e5ecd );
            waitframe( 1 );
            
            if ( is_true( self.var_c9f2a2 ) )
            {
                var_b20b0960 setspeed( 1 );
            }
            else
            {
                var_d571c86 /= 17.6;
                var_b20b0960 setspeed( var_d571c86 );
            }
            
            e_player playrumbleonentity( #"jump_rumble_start" );
            e_player ghost();
            var_b20b0960 thread vehicle::get_on_and_go_path( self.var_ad1b31ea );
            waitframe( 1 );
            var_b20b0960 setspeed( 35, self.var_aff2bad6 );
            e_player playrumblelooponentity( #"buzz_high" );
            
            if ( is_true( self.var_23f866eb ) )
            {
                e_player thread function_b6764a75( self );
            }
            else
            {
                e_player thread function_4a7a6dd7();
            }
            
            var_b20b0960 thread function_25f7c630();
            snd::play( "evt_zipline_start_lr", e_player );
            snd::play( "evt_zipline_lp_lr", var_b20b0960 );
            snd::play( "evt_zipline_wind_lp_lr", var_b20b0960 );
            e_player clientfield::set_to_player( "zipline_postfx", 1 );
            var_2eb0d943 = var_b20b0960 waittill( #"reached_end_node", #"zipline_start_disconnect" );
            
            if ( !is_true( self.var_23f866eb ) )
            {
                w_current = e_player getcurrentweapon();
                
                if ( !w_current hms_util::function_17fe30b7() )
                {
                    e_player val::set( #"zipline", "freezecontrols_allowlook", 1 );
                    e_player val::set( #"zipline", "disable_weapon_fire", 1 );
                    waitframe( 1 );
                    e_player playgestureviewmodel( "ges_t9_cp_zipline_end" );
                }
                
                if ( var_2eb0d943._notify == "zipline_start_disconnect" )
                {
                    s_results = var_b20b0960 waittilltimeout( 0.35, #"reached_end_node" );
                }
            }
            
            e_player show();
            e_player thread clientfield::set_to_player( "zipline_postfx", 0 );
            e_player stoprumble( #"buzz_high" );
            e_player function_2e1a479c();
            snd::play( "evt_zipline_end_lr", self );
            snd::stop_alias( "evt_zipline_lp_lr", var_b20b0960, 0.5 );
            snd::stop_alias( "evt_zipline_wind_lp_lr", var_b20b0960, 0.5 );
            var_ae64746f = var_b20b0960.var_ae64746f;
            waitframe( 1 );
            
            if ( isdefined( var_b20b0960 ) )
            {
                var_b20b0960 unlink();
                var_b20b0960 delete();
                self.var_b20b0960 = undefined;
            }
            
            if ( isdefined( var_5385c2b6 ) )
            {
                var_5385c2b6 unlink();
                var_5385c2b6 delete();
                self.var_5385c2b6 = undefined;
            }
            
            waitframe( 1 );
            
            if ( isdefined( e_player ) )
            {
                e_player.is_ziplining = 0;
                e_player notify( #"hash_3726f5b254bceb00" );
                
                if ( is_true( self.var_23f866eb ) )
                {
                    level notify( #"hash_3ede0d97e45af550" );
                    level hint_tutorial::function_9f427d88( 0 );
                }
                else
                {
                    e_player function_8dd002b4( var_ae64746f, self );
                    
                    while ( !e_player isonground() && isalive( e_player ) )
                    {
                        waitframe( 1 );
                    }
                    
                    if ( isdefined( e_player ) )
                    {
                        e_player playrumbleonentity( "jump_rumble_end" );
                        earthquake( 0.5, 0.25, e_player.origin, 100 );
                        
                        if ( isdefined( self.var_fc006495 ) )
                        {
                            switch ( self.var_fc006495 )
                            {
                                case #"snow":
                                    e_player clientfield::increment_to_player( "zipline_player_landing_fx", 1 );
                                    snd::play( "evt_zip_player_land_snow" );
                                    break;
                                case #"dirt":
                                    e_player clientfield::increment_to_player( "zipline_player_landing_fx", 2 );
                                    snd::play( "evt_zip_player_land_dirt" );
                                    break;
                                default:
                                    break;
                            }
                        }
                    }
                }
                
                if ( isdefined( e_player ) )
                {
                    e_player.var_d7d83470 = undefined;
                }
            }
        }
    }
}

// Namespace namespace_8af9269b/namespace_8af9269b
// Params 0
// Checksum 0x7fe55f5d, Offset: 0x1f98
// Size: 0x98
function function_4a7a6dd7()
{
    self endon( #"hash_3726f5b254bceb00", #"death" );
    wait 0.25;
    
    while ( true )
    {
        n_magnitude = randomfloatrange( 0.05, 0.2 );
        earthquake( n_magnitude, 0.35, self.origin, 100 );
        wait 0.35;
    }
}

// Namespace namespace_8af9269b/namespace_8af9269b
// Params 1
// Checksum 0x58e07421, Offset: 0x2038
// Size: 0x148
function function_b6764a75( var_88dc621c )
{
    self endon( #"hash_3726f5b254bceb00", #"death" );
    var_f5558cea = var_88dc621c.n_distance * var_88dc621c.n_distance;
    n_time = 0;
    wait 0.25;
    
    while ( true )
    {
        var_5b7a38e7 = var_f5558cea - distancesquared( self.origin, var_88dc621c.v_end_pos );
        
        if ( var_5b7a38e7 < 0 )
        {
            var_5b7a38e7 = 0;
        }
        else if ( var_5b7a38e7 > var_f5558cea )
        {
            var_5b7a38e7 = var_f5558cea;
        }
        
        var_7ddd94c0 = var_5b7a38e7 / var_f5558cea;
        n_magnitude = lerpfloat( 0.05, 0.3, var_7ddd94c0 );
        earthquake( n_magnitude, 0.1, self.origin, 100 );
        wait 0.1;
        n_time += 0.1;
    }
}

// Namespace namespace_8af9269b/namespace_8af9269b
// Params 1
// Checksum 0x8840b56c, Offset: 0x2188
// Size: 0x6a
function function_4522ae79( var_e87fe6aa )
{
    self endon( #"death" );
    
    while ( !self isonground() && self.origin[ 2 ] + 80 >= var_e87fe6aa[ 2 ] + 5 )
    {
        waitframe( 1 );
    }
}

// Namespace namespace_8af9269b/namespace_8af9269b
// Params 0, eflags: 0x4
// Checksum 0x24dc13bc, Offset: 0x2200
// Size: 0x66
function private function_25f7c630()
{
    self endon( #"death", #"reached_end_node", #"zipline_start_disconnect" );
    
    while ( true )
    {
        waitframe( 1 );
        self.var_ae64746f = self getspeedmph();
    }
}

// Namespace namespace_8af9269b/namespace_8af9269b
// Params 0, eflags: 0x4
// Checksum 0x728b7e5b, Offset: 0x2270
// Size: 0x14c
function private function_f5ce83f7()
{
    str_stance = self getstance();
    
    switch ( str_stance )
    {
        case #"crouch":
            self setstance( "stand" );
            wait 0.2;
            break;
        case #"prone":
            self setstance( "stand" );
            wait 1;
            break;
    }
    
    self val::set( #"zipline", "allow_crouch", 0 );
    self val::set( #"zipline", "allow_prone", 0 );
    self val::set( #"zipline", "allow_jump", 0 );
    self val::set( #"zipline", "allow_melee", 0 );
}

// Namespace namespace_8af9269b/namespace_8af9269b
// Params 0, eflags: 0x4
// Checksum 0x28348dba, Offset: 0x23c8
// Size: 0x24
function private function_2e1a479c()
{
    self val::reset_all( #"zipline" );
}

// Namespace namespace_8af9269b/namespace_8af9269b
// Params 2, eflags: 0x4
// Checksum 0x20b2aad0, Offset: 0x23f8
// Size: 0x9c
function private function_8dd002b4( var_ae64746f, var_cf56bb8f )
{
    var_3b2572fe = var_ae64746f / 35;
    var_a236526d = int( lerpfloat( 0, 100, var_3b2572fe ) );
    self applyknockback( var_a236526d, anglestoforward( var_cf56bb8f.var_afbab71e.angles ) );
}

// Namespace namespace_8af9269b/namespace_8af9269b
// Params 1
// Checksum 0x8e79275c, Offset: 0x24a0
// Size: 0xfe
function function_3dbd3643( *str_notify )
{
    self thread clientfield::set_to_player( "zipline_postfx", 0 );
    self stoprumble( #"buzz_high" );
    self val::reset_all( #"zipline" );
    
    if ( isdefined( self.var_b20b0960 ) )
    {
        self.var_b20b0960 unlink();
        self.var_b20b0960 delete();
        self.var_b20b0960 = undefined;
    }
    
    if ( isdefined( self.var_5385c2b6 ) )
    {
        self.var_5385c2b6 unlink();
        self.var_5385c2b6 delete();
        self.var_5385c2b6 = undefined;
    }
}

// Namespace namespace_8af9269b/namespace_8af9269b
// Params 1
// Checksum 0x9b54b7f1, Offset: 0x25a8
// Size: 0x11c
function function_76a94f6f( e_player )
{
    e_player endon( #"death" );
    scene::add_scene_func( "scene_yam_2010_zip_player", &function_4ed637bf, "zip_intro_start" );
    level.player val::set( #"hash_7ed7bcbce040b788", "disable_weapons", 1 );
    level.player val::set( #"hash_7ed7bcbce040b788", "freezecontrols_allowlook", 1 );
    wait 0.4;
    level scene::play( "scene_yam_2010_zip_player", "zip_intro_start" );
    level.player val::reset_all( #"hash_7ed7bcbce040b788" );
}

// Namespace namespace_8af9269b/namespace_8af9269b
// Params 1
// Checksum 0x3408f211, Offset: 0x26d0
// Size: 0xa4
function function_4ed637bf( ents )
{
    snd::play( "evt_yam_zipline_attach", level.player );
    strap = ents[ #"strap" ];
    strap clientfield::set( "zipline_strap_visibility", 0 );
    strap waittill( #"hash_6452723c1568c7bd" );
    strap clientfield::set( "zipline_strap_visibility", 1 );
}

// Namespace namespace_8af9269b/namespace_8af9269b
// Params 12
// Checksum 0xb9495ae, Offset: 0x2780
// Size: 0x140
function function_a8b4a98e( *einflictor, eattacker, idamage, *idflags, smeansofdeath, weapon, *vpoint, *vdir, *shitloc, *psoffsettime, *boneindex, *modelindex )
{
    n_damage = psoffsettime;
    
    if ( !isplayer( self ) && is_true( self.is_ziplining ) )
    {
        n_damage *= 10;
    }
    else if ( isplayer( shitloc ) && is_true( shitloc.is_ziplining ) && !( is_true( modelindex.isgrenadeweapon ) && boneindex == "MOD_IMPACT" ) )
    {
        n_damage *= 10;
    }
    
    return n_damage;
}

// Namespace namespace_8af9269b/namespace_8af9269b
// Params 1, eflags: 0x4
// Checksum 0xcfba02a9, Offset: 0x28c8
// Size: 0x14c
function private function_38cb6163( *entity )
{
    if ( !isdefined( self.var_c6b02ec0 ) )
    {
        var_d0b8fd1f = self gettagangles( "tag_origin" );
        var_3c7fa0d6 = self gettagorigin( "tag_origin" );
        self.var_c6b02ec0 = util::spawn_model( "p9_fxanim_cp_yam_zipline_rappel_strap", var_3c7fa0d6, var_d0b8fd1f );
        self.var_c6b02ec0 useanimtree( "generic" );
        self.var_c6b02ec0 notsolid();
        self.var_c6b02ec0 linkto( self, "tag_origin" );
        
        if ( isassetloaded( "xanim", "t9_yam_0000_ambient_zipline_strap_enter" ) )
        {
            self.var_c6b02ec0 animscripted( "t9_yam_0000_ambient_zipline_strap_enter", var_3c7fa0d6, var_d0b8fd1f, "t9_yam_0000_ambient_zipline_strap_enter", "normal", "root", 1, 0 );
        }
    }
}

// Namespace namespace_8af9269b/namespace_8af9269b
// Params 0, eflags: 0x4
// Checksum 0x80f724d1, Offset: 0x2a20
// Size: 0x4
function private function_7a073e82()
{
    
}

// Namespace namespace_8af9269b/namespace_8af9269b
// Params 0, eflags: 0x4
// Checksum 0x20bfc6f9, Offset: 0x2a30
// Size: 0x10c
function private function_a8f3484()
{
    snd::play( "evt_zipline_npc_start", self.var_b20b0960 );
    snd::play( "evt_zipline_npc_lp", self.var_b20b0960 );
    
    if ( isdefined( self.var_c6b02ec0 ) && isassetloaded( "xanim", "t9_yam_0000_ambient_zipline_strap_loop" ) )
    {
        var_d0b8fd1f = self gettagangles( "tag_origin" );
        var_3c7fa0d6 = self gettagorigin( "tag_origin" );
        self.var_c6b02ec0 animscripted( "t9_yam_0000_ambient_zipline_strap_loop", var_3c7fa0d6, var_d0b8fd1f, "t9_yam_0000_ambient_zipline_strap_loop", "normal", "root", 1, 0 );
    }
}

// Namespace namespace_8af9269b/namespace_8af9269b
// Params 0, eflags: 0x4
// Checksum 0xd45623d7, Offset: 0x2b48
// Size: 0x54
function private function_e9f7f0d4()
{
    snd::stop_alias( "evt_zipline_npc_lp", self.var_b20b0960, 0 );
    
    if ( isdefined( self.var_c6b02ec0 ) )
    {
        self.var_c6b02ec0 delete();
    }
}

// Namespace namespace_8af9269b/namespace_8af9269b
// Params 0, eflags: 0x4
// Checksum 0x8f196bd2, Offset: 0x2ba8
// Size: 0x24
function private function_f33d0f47()
{
    snd::stop_alias( "evt_zipline_npc_lp", self.var_b20b0960 );
}

// Namespace namespace_8af9269b/namespace_8af9269b
// Params 0, eflags: 0x4
// Checksum 0x80f724d1, Offset: 0x2bd8
// Size: 0x4
function private function_c9a7989e()
{
    
}

// Namespace namespace_8af9269b/namespace_8af9269b
// Params 0, eflags: 0x4
// Checksum 0xbe4860e9, Offset: 0x2be8
// Size: 0xc2
function private function_b8e9daa0()
{
    var_cf56bb8f = self.zipline_start.var_cf56bb8f;
    
    if ( isdefined( var_cf56bb8f.var_fc006495 ) )
    {
        switch ( var_cf56bb8f.var_fc006495 )
        {
            case #"snow":
                self clientfield::increment( "zipline_ai_landing_fx", 1 );
                break;
            case #"dirt":
                self clientfield::increment( "zipline_ai_landing_fx", 2 );
                break;
            default:
                break;
        }
    }
}

