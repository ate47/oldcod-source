#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/cp_mi_cairo_infection_hideout_outro;
#using scripts/shared/clientfield_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace infection_zombies;

// Namespace infection_zombies
// Params 0
// Checksum 0x2e892ca6, Offset: 0x568
// Size: 0x2a
function main()
{
    level.zombie_game_time = -106;
    init_clientfields();
    init_fx();
}

// Namespace infection_zombies
// Params 0
// Checksum 0xed9fa6d5, Offset: 0x5a0
// Size: 0xc3
function init_fx()
{
    level._effect[ "eye_glow" ] = "zombie/fx_glow_eye_orange";
    level._effect[ "rise_burst" ] = "zombie/fx_spawn_dirt_hand_burst_zmb";
    level._effect[ "rise_billow" ] = "zombie/fx_spawn_dirt_body_billowing_zmb";
    level._effect[ "rise_dust" ] = "zombie/fx_spawn_dirt_body_dustfalling_zmb";
    level._effect[ "zombie_firewall_fx" ] = "fire/fx_fire_wall_moving_infection_city";
    level._effect[ "zombie_guts_explosion" ] = "zombie/fx_blood_torso_explo_zmb";
    level._effect[ "zombie_backdraft_md" ] = "fire/fx_fire_backdraft_md";
    level._effect[ "zombie_backdraft_sm" ] = "fire/fx_fire_backdraft_sm";
}

// Namespace infection_zombies
// Params 0
// Checksum 0xcccf1701, Offset: 0x670
// Size: 0x22a
function init_clientfields()
{
    println( "<dev string:x28>" );
    
    if ( !sessionmodeiscampaignzombiesgame() )
    {
        clientfield::register( "actor", "zombie_riser_fx", 1, 1, "int", &handle_zombie_risers, 1, 1 );
        clientfield::register( "actor", "zombie_has_eyes", 1, 1, "int", &zombie_eyes_clientfield_cb, 0, 1 );
        clientfield::register( "actor", "zombie_gut_explosion", 1, 1, "int", &zombie_gut_explosion_cb, 0, 1 );
        clientfield::register( "actor", "zombie_tac_mode_disable", 1, 1, "int", &zombie_tac_mode_disable, 0, 0 );
    }
    
    clientfield::register( "scriptmover", "zombie_fire_wall_fx", 1, 1, "int", &handle_fire_wall_fx, 1, 0 );
    clientfield::register( "scriptmover", "zombie_fire_backdraft_fx", 1, 1, "int", &zombie_fire_backdraft_init, 1, 0 );
    clientfield::register( "toplayer", "zombie_fire_overlay_init", 1, 1, "int", &callback_set_fire_fx, 1, 1 );
    clientfield::register( "toplayer", "zombie_fire_overlay", 1, 7, "float", &callback_activate_fire_fx, 1, 1 );
    clientfield::register( "world", "zombie_root_grow", 1, 1, "int", &handle_roots_growth, 0, 0 );
}

// Namespace infection_zombies
// Params 7
// Checksum 0xac90c689, Offset: 0x8a8
// Size: 0x169
function handle_zombie_risers( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    level endon( #"demo_jump" );
    self endon( #"entityshutdown" );
    
    if ( !oldval && newval )
    {
        localplayers = level.localplayers;
        sound = "zmb_zombie_spawn";
        burst_fx = level._effect[ "rise_burst" ];
        billow_fx = level._effect[ "rise_billow" ];
        type = "dirt";
        
        if ( isdefined( level.riser_type ) && level.riser_type == "snow" )
        {
            sound = "zmb_zombie_spawn_snow";
            burst_fx = level._effect[ "rise_burst_snow" ];
            billow_fx = level._effect[ "rise_billow_snow" ];
            type = "snow";
        }
        
        playsound( 0, sound, self.origin );
        
        for ( i = 0; i < localplayers.size ; i++ )
        {
            self thread rise_dust_fx( i, type, billow_fx, burst_fx );
        }
    }
}

// Namespace infection_zombies
// Params 4
// Checksum 0xcb132eb9, Offset: 0xa20
// Size: 0x191
function rise_dust_fx( clientnum, type, billow_fx, burst_fx )
{
    dust_tag = "J_SpineUpper";
    self endon( #"entityshutdown" );
    level endon( #"demo_jump" );
    
    if ( isdefined( burst_fx ) )
    {
        playfx( clientnum, burst_fx, self.origin + ( 0, 0, randomintrange( 5, 10 ) ) );
    }
    
    wait 0.25;
    
    if ( isdefined( billow_fx ) )
    {
        playfx( clientnum, billow_fx, self.origin + ( randomintrange( -10, 10 ), randomintrange( -10, 10 ), randomintrange( 5, 10 ) ) );
    }
    
    wait 2;
    dust_time = 5.5;
    dust_interval = 0.3;
    player = level.localplayers[ clientnum ];
    effect = level._effect[ "rise_dust" ];
    
    if ( type == "snow" )
    {
        effect = level._effect[ "rise_dust_snow" ];
    }
    else if ( type == "none" )
    {
        return;
    }
    
    t = 0;
    
    while ( t < dust_time )
    {
        playfxontag( clientnum, effect, self, dust_tag );
        wait dust_interval;
        t += dust_interval;
    }
}

// Namespace infection_zombies
// Params 7
// Checksum 0x3db7a535, Offset: 0xbc0
// Size: 0x1f2
function handle_roots_growth( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        scene::add_scene_func( "p7_fxanim_cp_infection_house_roots_left_bundle", &callback_tree_roots_shader, "init" );
        scene::add_scene_func( "p7_fxanim_cp_infection_house_roots_middle_bundle", &callback_tree_roots_shader, "init" );
        scene::add_scene_func( "p7_fxanim_cp_infection_house_roots_right_bundle", &callback_tree_roots_shader, "init" );
        level thread scene::init( "p7_fxanim_cp_infection_house_roots_left_bundle" );
        level thread scene::init( "p7_fxanim_cp_infection_house_roots_middle_bundle" );
        level thread scene::init( "p7_fxanim_cp_infection_house_roots_right_bundle" );
        return;
    }
    
    scene::add_scene_func( "p7_fxanim_cp_infection_house_roots_left_bundle", &callback_tree_roots_shader, "play" );
    scene::add_scene_func( "p7_fxanim_cp_infection_house_roots_middle_bundle", &callback_tree_roots_shader, "play" );
    scene::add_scene_func( "p7_fxanim_cp_infection_house_roots_right_bundle", &callback_tree_roots_shader, "play" );
    level thread scene::play( "p7_fxanim_cp_infection_house_roots_left_bundle" );
    level thread scene::play( "p7_fxanim_cp_infection_house_roots_middle_bundle" );
    level thread scene::play( "p7_fxanim_cp_infection_house_roots_right_bundle" );
}

// Namespace infection_zombies
// Params 1
// Checksum 0x6780ca6f, Offset: 0xdc0
// Size: 0x63
function callback_tree_roots_shader( a_ents )
{
    foreach ( e_root in a_ents )
    {
        e_root thread hideout_outro::city_tree_shader();
    }
}

// Namespace infection_zombies
// Params 7
// Checksum 0x5e783861, Offset: 0xe30
// Size: 0x108
function zombie_eyes_clientfield_cb( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( !isdefined( newval ) )
    {
        return;
    }
    
    if ( newval )
    {
        self createzombieeyesinternal( localclientnum );
        self mapshaderconstant( localclientnum, 0, "scriptVector2", 0, get_eyeball_on_luminance(), self get_eyeball_color() );
    }
    else
    {
        self deletezombieeyes( localclientnum );
        self mapshaderconstant( localclientnum, 0, "scriptVector2", 0, get_eyeball_off_luminance(), self get_eyeball_color() );
    }
    
    if ( isdefined( level.zombie_eyes_clientfield_cb_additional ) )
    {
        self [[ level.zombie_eyes_clientfield_cb_additional ]]( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump );
    }
}

// Namespace infection_zombies
// Params 1
// Checksum 0xdbcfe865, Offset: 0xf40
// Size: 0xcb
function createzombieeyesinternal( localclientnum )
{
    self endon( #"entityshutdown" );
    self util::waittill_dobj( localclientnum );
    
    if ( !isdefined( self._eyearray ) )
    {
        self._eyearray = [];
    }
    
    if ( !isdefined( self._eyearray[ localclientnum ] ) )
    {
        linktag = "j_eyeball_le";
        effect = level._effect[ "eye_glow" ];
        
        if ( isdefined( level._override_eye_fx ) )
        {
            effect = level._override_eye_fx;
        }
        
        if ( isdefined( self._eyeglow_fx_override ) )
        {
            effect = self._eyeglow_fx_override;
        }
        
        if ( isdefined( self._eyeglow_tag_override ) )
        {
            linktag = self._eyeglow_tag_override;
        }
        
        self._eyearray[ localclientnum ] = playfxontag( localclientnum, effect, self, linktag );
    }
}

// Namespace infection_zombies
// Params 0
// Checksum 0x362ec6bf, Offset: 0x1018
// Size: 0x18
function get_eyeball_on_luminance()
{
    if ( isdefined( level.eyeball_on_luminance_override ) )
    {
        return level.eyeball_on_luminance_override;
    }
    
    return 1;
}

// Namespace infection_zombies
// Params 0
// Checksum 0xcadf05ec, Offset: 0x1038
// Size: 0x17
function get_eyeball_off_luminance()
{
    if ( isdefined( level.eyeball_off_luminance_override ) )
    {
        return level.eyeball_off_luminance_override;
    }
    
    return 0;
}

// Namespace infection_zombies
// Params 0
// Checksum 0xf96f3365, Offset: 0x1058
// Size: 0x3a
function get_eyeball_color()
{
    val = 0;
    
    if ( isdefined( level.zombie_eyeball_color_override ) )
    {
        val = level.zombie_eyeball_color_override;
    }
    
    if ( isdefined( self.zombie_eyeball_color_override ) )
    {
        val = self.zombie_eyeball_color_override;
    }
    
    return val;
}

// Namespace infection_zombies
// Params 1
// Checksum 0x9f96d8fb, Offset: 0x10a0
// Size: 0x4a
function deletezombieeyes( localclientnum )
{
    if ( isdefined( self._eyearray ) )
    {
        if ( isdefined( self._eyearray[ localclientnum ] ) )
        {
            deletefx( localclientnum, self._eyearray[ localclientnum ], 1 );
            self._eyearray[ localclientnum ] = undefined;
        }
    }
}

// Namespace infection_zombies
// Params 7
// Checksum 0x93f0b3a9, Offset: 0x10f8
// Size: 0xa2
function zombie_gut_explosion_cb( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        if ( isdefined( level._effect[ "zombie_guts_explosion" ] ) )
        {
            org = self gettagorigin( "J_SpineLower" );
            
            if ( isdefined( org ) )
            {
                playfx( localclientnum, level._effect[ "zombie_guts_explosion" ], org );
            }
        }
    }
}

// Namespace infection_zombies
// Params 7
// Checksum 0x24d08bb3, Offset: 0x11a8
// Size: 0x6a
function zombie_tac_mode_disable( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        self tmodesetflag( 9 );
        return;
    }
    
    self tmodeclearflag( 9 );
}

// Namespace infection_zombies
// Params 7
// Checksum 0x5120b089, Offset: 0x1220
// Size: 0x91
function handle_fire_wall_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        self.fire_id = playfxontag( localclientnum, level._effect[ "zombie_firewall_fx" ], self, "tag_origin" );
        return;
    }
    
    deletefx( localclientnum, self.fire_id, 0 );
    self.fire_id = undefined;
}

// Namespace infection_zombies
// Params 7
// Checksum 0xe3d9be5b, Offset: 0x12c0
// Size: 0xc3
function zombie_fire_backdraft_init( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        s_backdraft_pos = struct::get_array( "backdraft_fire", "targetname" );
        
        foreach ( struct in s_backdraft_pos )
        {
            struct thread zombie_fire_backdraft( localclientnum, self );
        }
    }
}

// Namespace infection_zombies
// Params 2
// Checksum 0xeafe168a, Offset: 0x1390
// Size: 0x12a
function zombie_fire_backdraft( localclientnum, e_fire_wall )
{
    e_fire_wall endon( #"entityshutdown" );
    
    for ( n_wall_pos = e_fire_wall.origin; self.origin[ 0 ] < n_wall_pos[ 0 ] ; n_wall_pos = e_fire_wall.origin )
    {
        wait 0.1;
    }
    
    forward = anglestoforward( self.angles );
    
    if ( randomint( 100 ) > 50 )
    {
        playfx( localclientnum, level._effect[ "zombie_backdraft_md" ], self.origin, forward );
        playsound( 0, "pfx_backdraft", self.origin );
        return;
    }
    
    playfx( localclientnum, level._effect[ "zombie_backdraft_sm" ], self.origin, forward );
    playsound( 0, "pfx_backdraft", self.origin );
}

// Namespace infection_zombies
// Params 7
// Checksum 0x6366b2cf, Offset: 0x14c8
// Size: 0x72
function callback_set_fire_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    setdvar( "r_radioactiveFX_enable", newval );
    
    if ( newval != oldval )
    {
        setdvar( "r_radioactiveIntensity", 0 );
    }
}

// Namespace infection_zombies
// Params 7
// Checksum 0x46ce8211, Offset: 0x1548
// Size: 0x8a
function callback_activate_fire_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    n_intensity_amount = math::linear_map( newval, 0, 1, 0, 4 );
    setdvar( "r_radioactiveIntensity", n_intensity_amount );
}

