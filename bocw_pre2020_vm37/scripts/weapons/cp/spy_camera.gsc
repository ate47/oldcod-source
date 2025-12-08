#using script_13114d8a31c6152a;
#using script_35ae72be7b4fec10;
#using script_37f9ff47f340fbe8;
#using script_4937c6974f43bb71;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\serverfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\util;

#namespace spy_camera;

// Namespace spy_camera/spy_camera
// Params 0, eflags: 0x6
// Checksum 0xf5759768, Offset: 0x290
// Size: 0x34
function private autoexec __init__system__()
{
    system::register( "spy_camera", &preinit, undefined, undefined, undefined );
}

// Namespace spy_camera/spy_camera
// Params 0, eflags: 0x4
// Checksum 0xd0b15c5b, Offset: 0x2d0
// Size: 0x1dc
function private preinit()
{
    callback::on_weapon_change( &on_weapon_change );
    callback::on_spawned( &function_ab7ec803 );
    clientfield::register( "toplayer", "spy_camera_state", 1, 2, "int" );
    clientfield::register( "toplayer", "binoculars_overlay", 1, 1, "int" );
    clientfield::register( "toplayer", "spy_camera_tagging", 1, 1, "int" );
    var_1e935eba = array( "actor", "scriptmover" );
    
    foreach ( str_type in var_1e935eba )
    {
        clientfield::register( str_type, "spy_camera_object_of_interest", 1, 2, "int" );
    }
    
    level.var_e3f5eafc = getweapon( "eq_spy_camera" );
    level.var_42db149f = getweapon( "eq_binoculars" );
}

// Namespace spy_camera/spy_camera
// Params 3
// Checksum 0xa3df8b13, Offset: 0x4b8
// Size: 0x150
function function_f785d9e9( objects, var_7eb1c6be = 0, var_354b19f1 )
{
    if ( !isdefined( objects ) )
    {
        objects = [];
    }
    else if ( !isarray( objects ) )
    {
        objects = array( objects );
    }
    
    val = 1;
    
    if ( var_7eb1c6be )
    {
        val = 2;
    }
    
    foreach ( object in objects )
    {
        object clientfield::set( "spy_camera_object_of_interest", val );
        object thread function_654fa552( var_354b19f1 );
        
        if ( var_7eb1c6be )
        {
            object thread function_a6928964( var_354b19f1 );
        }
    }
}

// Namespace spy_camera/spy_camera
// Params 1, eflags: 0x4
// Checksum 0x4753cfea, Offset: 0x610
// Size: 0x90
function private function_654fa552( wz_character_richtofen_wz )
{
    self endon( #"death", #"hash_54e0f219fc10204a" );
    self waittillmatch( { #var_aad36d51:0, #fieldvalue:1 }, #"hash_72a5fe161eb7a0ce" );
    self notify( #"photo_taken" );
    
    if ( isdefined( wz_character_richtofen_wz ) )
    {
        wz_character_richtofen_wz notify( #"photo_taken" );
    }
}

// Namespace spy_camera/spy_camera
// Params 1, eflags: 0x4
// Checksum 0xe362493f, Offset: 0x6a8
// Size: 0xac
function private function_a6928964( wz_character_richtofen_wz )
{
    self endon( #"death", #"photo_taken", #"hash_54e0f219fc10204a" );
    
    while ( true )
    {
        self waittillmatch( { #var_aad36d51:0, #fieldvalue:2 }, #"hash_72a5fe161eb7a0ce" );
        self notify( #"hash_54596dc066040d8c" );
        
        if ( isdefined( wz_character_richtofen_wz ) )
        {
            wz_character_richtofen_wz notify( #"hash_54596dc066040d8c" );
        }
    }
}

// Namespace spy_camera/spy_camera
// Params 1
// Checksum 0xc8185822, Offset: 0x760
// Size: 0x40
function function_b28ab5a9( object )
{
    object clientfield::set( "spy_camera_object_of_interest", 0 );
    object notify( #"hash_54e0f219fc10204a" );
}

// Namespace spy_camera/spy_camera
// Params 0
// Checksum 0x6f35d153, Offset: 0x7a8
// Size: 0x24
function function_69190c4e()
{
    clientfield::set_to_player( "spy_camera_tagging", 1 );
}

// Namespace spy_camera/spy_camera
// Params 0
// Checksum 0x9ebea6b6, Offset: 0x7d8
// Size: 0x1c
function function_c11bdcc0()
{
    clientfield::set_to_player( "spy_camera_tagging", 0 );
}

// Namespace spy_camera/spy_camera
// Params 1
// Checksum 0xd809bd86, Offset: 0x800
// Size: 0x194
function on_weapon_change( params )
{
    var_b67a0cc6 = params.last_weapon !== level.weaponnone && ( params.last_weapon === level.var_e3f5eafc || params.last_weapon === level.var_42db149f );
    
    if ( var_b67a0cc6 || params.last_weapon === level.weaponnone && self clientfield::get_to_player( "spy_camera_state" ) != 0 )
    {
        self thread function_d704edcd( params.last_weapon === level.var_42db149f );
    }
    
    var_d14812a6 = params.weapon !== level.weaponnone && ( params.weapon === level.var_e3f5eafc || params.weapon === level.var_42db149f );
    
    if ( var_d14812a6 )
    {
        var_c5c03b2 = params.weapon === level.var_42db149f;
        ads_gesture = "ges_spy_camera_ads";
        
        if ( var_c5c03b2 )
        {
            ads_gesture = "ges_binoculars_ads";
        }
        
        self thread function_b917e313( params.weapon, ads_gesture, var_c5c03b2 );
    }
}

// Namespace spy_camera/spy_camera
// Params 0
// Checksum 0xafa0ee84, Offset: 0x9a0
// Size: 0x2c
function function_ab7ec803()
{
    level flag::delay_set( 0.1, "flg_spy_cam_player_spawned" );
}

// Namespace spy_camera/spy_camera
// Params 1
// Checksum 0x236ab963, Offset: 0x9d8
// Size: 0x9a
function function_6de171e9( slot = 4 )
{
    assert( level.var_e3f5eafc != level.weaponnone );
    self giveweapon( level.var_e3f5eafc );
    self setactionslot( slot, "weapon", level.var_e3f5eafc );
    self.var_390003ff = slot;
}

// Namespace spy_camera/spy_camera
// Params 1
// Checksum 0xea280ee0, Offset: 0xa80
// Size: 0x9a
function function_8606cd15( slot = 4 )
{
    assert( level.var_42db149f != level.weaponnone );
    self giveweapon( level.var_42db149f );
    self setactionslot( slot, "weapon", level.var_42db149f );
    self.var_5915e3c5 = slot;
}

// Namespace spy_camera/spy_camera
// Params 0
// Checksum 0xe7f6d63f, Offset: 0xb28
// Size: 0xc6
function function_b83af2a9()
{
    player = undefined;
    
    if ( isplayer( self ) )
    {
        player = self;
    }
    else
    {
        player = getplayers()[ 0 ];
    }
    
    if ( player hasweapon( level.var_e3f5eafc ) )
    {
        player takeweapon( level.var_e3f5eafc );
    }
    
    if ( isdefined( player.var_390003ff ) )
    {
        player setactionslot( player.var_390003ff, "" );
        player.var_390003ff = undefined;
    }
}

// Namespace spy_camera/spy_camera
// Params 0
// Checksum 0xad256ed1, Offset: 0xbf8
// Size: 0xc6
function function_d9015b8c()
{
    player = undefined;
    
    if ( isplayer( self ) )
    {
        player = self;
    }
    else
    {
        player = getplayers()[ 0 ];
    }
    
    if ( player hasweapon( level.var_42db149f ) )
    {
        player takeweapon( level.var_42db149f );
    }
    
    if ( isdefined( player.var_5915e3c5 ) )
    {
        player setactionslot( player.var_5915e3c5, "" );
        player.var_5915e3c5 = undefined;
    }
}

// Namespace spy_camera/spy_camera
// Params 4
// Checksum 0x3147327e, Offset: 0xcc8
// Size: 0xfc
function function_f91a82ef( b_enabled = 1, msg = #"hash_4f0d57b7fae34a99", duration = 8000, var_9763e3fa )
{
    level.var_e3f5eafc.var_f91a82ef = b_enabled;
    level.var_e3f5eafc.var_7d598677 = msg;
    level.var_e3f5eafc.var_3a0d6cd6 = duration;
    level.var_e3f5eafc.var_bfef880f = var_9763e3fa;
    
    if ( b_enabled == 0 )
    {
        level flag::wait_till( "flg_spy_cam_player_spawned" );
        getplayers()[ 0 ] thread util::hide_hint_text();
    }
}

// Namespace spy_camera/spy_camera
// Params 1
// Checksum 0xe5a8e0af, Offset: 0xdd0
// Size: 0x100
function function_de6d9b74( prompts )
{
    assert( isarray( prompts ) || ishash( prompts ) );
    level.var_af143f1d = [];
    
    if ( isarray( prompts ) )
    {
        level.var_af143f1d = prompts;
        return;
    }
    
    if ( !isdefined( level.var_af143f1d ) )
    {
        level.var_af143f1d = [];
    }
    else if ( !isarray( level.var_af143f1d ) )
    {
        level.var_af143f1d = array( level.var_af143f1d );
    }
    
    level.var_af143f1d[ level.var_af143f1d.size ] = prompts;
}

// Namespace spy_camera/spy_camera
// Params 3, eflags: 0x4
// Checksum 0x1268d54f, Offset: 0xed8
// Size: 0x898
function private function_b917e313( camera, ads_gesture, var_c5c03b2 )
{
    self endon( #"death", #"ability_deactivated_camera" );
    
    if ( !isdefined( self.spy_camera ) )
    {
        self.spy_camera = spawnstruct();
    }
    
    var_f94537f6 = 0;
    finished_ads = 0;
    var_ff17ab00 = 0;
    var_697c5b2b = int( 2 * 1000 );
    var_a05f9c5f = 0;
    var_83cf950f = self getgesturestarttime( ads_gesture, "loop" ) * 1000;
    var_4308b3d8 = 0;
    was_ads = 0;
    self disableweaponfire();
    self notify( #"ability_activated_camera" );
    
    if ( !var_c5c03b2 )
    {
        self notify( #"hide_camera_equip_hint" );
        self thread function_2d8ba5c4();
        self thread function_27f6af2c();
    }
    
    while ( true )
    {
        if ( !self isswitchingweapons() && !self isreloading() && self adsbuttonpressed() )
        {
            if ( was_ads && self isgestureplaying( ads_gesture ) && gettime() > var_4308b3d8 )
            {
                if ( !var_f94537f6 )
                {
                    var_f94537f6 = 1;
                    self val::set( "spy_camera", "freezecontrols_allowlook", 1 );
                    self val::set( "spy_camera", "disable_weapon_cycling", 1 );
                    self notify( #"enter_camera_ads" );
                }
                
                if ( var_a05f9c5f != 1 )
                {
                    var_a05f9c5f = 1;
                    self clientfield::set_to_player( "spy_camera_state", 1 );
                    namespace_82bfe441::fade( 1, "FadeFast" );
                    
                    if ( var_c5c03b2 )
                    {
                        self clientfield::set_to_player( "binoculars_overlay", 1 );
                        scripted_widgets::create( #"binoculars", #"hash_1703896731dc6998" );
                    }
                    
                    self hideviewmodel();
                    self enableweaponfire();
                    namespace_c8e236da::removelist();
                    
                    if ( !isdefined( level.var_af143f1d ) || level.var_af143f1d.size == 0 )
                    {
                        level.var_af143f1d = [];
                        
                        if ( !isdefined( level.var_af143f1d ) )
                        {
                            level.var_af143f1d = [];
                        }
                        else if ( !isarray( level.var_af143f1d ) )
                        {
                            level.var_af143f1d = array( level.var_af143f1d );
                        }
                        
                        level.var_af143f1d[ level.var_af143f1d.size ] = #"hash_4d41512a9dd19c05";
                        
                        if ( !var_c5c03b2 )
                        {
                            if ( !isdefined( level.var_af143f1d ) )
                            {
                                level.var_af143f1d = [];
                            }
                            else if ( !isarray( level.var_af143f1d ) )
                            {
                                level.var_af143f1d = array( level.var_af143f1d );
                            }
                            
                            level.var_af143f1d[ level.var_af143f1d.size ] = #"hash_38a90a5154d5fa9a";
                        }
                    }
                    
                    foreach ( item in level.var_af143f1d )
                    {
                        namespace_c8e236da::addprompt( item );
                    }
                }
                else if ( self attackbuttonpressed() && self getweaponammoclip( camera ) > 0 && gettime() > var_ff17ab00 )
                {
                    var_a05f9c5f = 2;
                    var_ff17ab00 = var_697c5b2b + gettime();
                    self clientfield::set_to_player( "spy_camera_state", 2 );
                    namespace_c8e236da::function_f7362969( hash( "spy_camera_photo_taken" ) );
                    self notify( #"take_picture" );
                    self disableweaponfire();
                    self util::delay( float( var_697c5b2b ) / 1000 - 0.5, "death", &namespace_c8e236da::function_f7362969, hash( "spy_camera_photo_taken" ), 0 );
                    wait float( var_697c5b2b ) / 1000 - 0.25;
                }
            }
            else if ( !was_ads )
            {
                was_ads = 1;
                self playgestureviewmodel( ads_gesture, undefined, 1 );
                var_4308b3d8 = var_83cf950f + gettime();
                finished_ads = 0;
                self notify( #"begin_camera_ads" );
            }
        }
        else if ( was_ads )
        {
            was_ads = 0;
            self stopgestureviewmodel( ads_gesture );
            self notify( #"end_camera_ads_begin" );
            
            if ( var_f94537f6 )
            {
                var_f94537f6 = 0;
                namespace_c8e236da::removelist();
                self val::reset( "spy_camera", "freezecontrols_allowlook" );
                self val::reset( "spy_camera", "disable_weapon_cycling" );
            }
            
            if ( var_a05f9c5f != 0 )
            {
                var_a05f9c5f = 0;
                self clientfield::set_to_player( "spy_camera_state", 0 );
                namespace_82bfe441::fade( 0, "FadeFast" );
                
                if ( var_c5c03b2 )
                {
                    self clientfield::set_to_player( "binoculars_overlay", 0 );
                    scripted_widgets::remove( #"binoculars" );
                }
                
                self showviewmodel();
                self disableweaponfire();
            }
            
            while ( self isgestureplaying( ads_gesture ) )
            {
                waitframe( 1 );
            }
            
            self notify( #"end_camera_ads" );
        }
        
        waitframe( 1 );
    }
}

// Namespace spy_camera/spy_camera
// Params 1, eflags: 0x4
// Checksum 0xf713656a, Offset: 0x1778
// Size: 0x194
function private function_d704edcd( *var_c5c03b2 )
{
    self notify( #"ability_deactivated_camera" );
    namespace_c8e236da::removelist();
    self val::reset( "spy_camera", "freezecontrols_allowlook" );
    self val::reset( "spy_camera", "disable_weapon_cycling" );
    self clientfield::set_to_player( "spy_camera_state", 0 );
    namespace_82bfe441::fade( 0, "FadeFast" );
    
    if ( scripted_widgets::exists( #"binoculars" ) )
    {
        self clientfield::set_to_player( "binoculars_overlay", 0 );
        scripted_widgets::remove( #"binoculars" );
    }
    
    self notify( #"hash_2977cbecfddfcab6" );
    self notify( #"hash_167fe97f3e95d4c2" );
    self notify( #"hide_camera_unequip_hint" );
    level.var_af143f1d = [];
    self showviewmodel();
    self enableweaponfire();
}

// Namespace spy_camera/spy_camera
// Params 0, eflags: 0x4
// Checksum 0xfe576ddc, Offset: 0x1918
// Size: 0x2c4
function private function_2d8ba5c4()
{
    self notify( #"hash_2977cbecfddfcab6" );
    self endon( #"hash_2977cbecfddfcab6" );
    var_acca0715 = gettime();
    
    if ( !isdefined( level.var_e3f5eafc.var_7d598677 ) )
    {
        level.var_e3f5eafc.var_7d598677 = #"hash_12be6ba1327c64b1";
    }
    
    if ( !isdefined( level.var_e3f5eafc.var_3a0d6cd6 ) )
    {
        level.var_e3f5eafc.var_3a0d6cd6 = 8000;
    }
    
    if ( !isdefined( level.var_e3f5eafc.var_f91a82ef ) )
    {
        level.var_e3f5eafc.var_f91a82ef = 1;
    }
    
    while ( true )
    {
        player = getplayers()[ 0 ];
        var_b3fccd4b = gettime();
        var_496bb3bc = var_b3fccd4b - var_acca0715;
        
        if ( is_true( level.var_e3f5eafc.var_f91a82ef ) && var_496bb3bc >= level.var_e3f5eafc.var_3a0d6cd6 && !player scene::function_c935c42() && !player flag::get( #"lockpicking" ) )
        {
            var_34487abc = isdefined( level.var_e3f5eafc.var_bfef880f ) ? level.var_e3f5eafc.var_bfef880f : "hide_camera_unequip_hint";
            self util::show_hint_text( level.var_e3f5eafc.var_7d598677, undefined, var_34487abc, 4000 );
            self waittill( #"begin_camera_ads" );
        }
        else if ( player scene::function_c935c42() || player flag::get( #"lockpicking" ) )
        {
            wait 1;
            var_acca0715 = gettime();
        }
        
        if ( self isgestureplaying( #"ges_spy_camera_ads" ) )
        {
            self waittill( #"end_camera_ads" );
            var_acca0715 = gettime();
        }
        
        wait 0.5;
    }
}

// Namespace spy_camera/spy_camera
// Params 0, eflags: 0x4
// Checksum 0xbb633382, Offset: 0x1be8
// Size: 0x118
function private function_27f6af2c()
{
    self notify( #"hash_167fe97f3e95d4c2" );
    self endoncallback( &function_e1dc9da9, #"hash_167fe97f3e95d4c2" );
    
    while ( true )
    {
        player = getplayers()[ 0 ];
        player flag::wait_till( #"lockpicking" );
        player notify( #"hide_camera_unequip_hint" );
        player val::set( #"spy_camera", "disable_weapons", 1 );
        player flag::wait_till_clear( #"lockpicking" );
        player val::reset( #"spy_camera", "disable_weapons" );
        wait 0.5;
    }
}

// Namespace spy_camera/spy_camera
// Params 1, eflags: 0x4
// Checksum 0x2804ee9e, Offset: 0x1d08
// Size: 0x5c
function private function_e1dc9da9( *str_notify )
{
    player = getplayers()[ 0 ];
    player val::reset( #"spy_camera", "disable_weapons" );
}

