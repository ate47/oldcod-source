#using script_18910f59cc847b42;
#using script_30c7fb449869910;
#using script_3314b730521b9666;
#using script_38635d174016f682;
#using script_3b893ec1252cdffd;
#using script_42cbbdcd1e160063;
#using script_64e5d3ad71ce8140;
#using script_67049b48b589d81;
#using script_6b71c9befed901f2;
#using script_71603a58e2da0698;
#using script_75c3996cce8959f7;
#using script_76abb7986de59601;
#using script_77163d5a569e2071;
#using script_771f5bff431d8d57;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\hud_message_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace doa_player;

// Namespace doa_player/doa_player
// Params 0
// Checksum 0xf7b8f2fa, Offset: 0x328
// Size: 0x37c
function init()
{
    level.var_46a66896 = doa_overworld::register_clientside();
    clientfield::register( "allplayers", "bombDrop", 1, 1, "int", &function_c75159ad, 0, 0 );
    clientfield::register( "toplayer", "cutscene", 1, 2, "int", &function_769d489, 0, 0 );
    clientfield::register( "toplayer", "controlBinding", 1, 4, "counter", &function_e7a44fda, 0, 0 );
    clientfield::register( "toplayer", "goFPS", 1, 1, "counter", &function_f32984d0, 0, 0 );
    clientfield::register( "toplayer", "exitFPS", 1, 1, "counter", &function_43ae94e0, 0, 0 );
    clientfield::register( "toplayer", "changeCamera", 1, 1, "counter", &changecamera, 0, 0 );
    clientfield::register( "toplayer", "resetCamera", 1, 1, "counter", &resetcamera, 0, 0 );
    clientfield::register( "toplayer", "lastStand", 1, 1, "int", &laststand, 0, 0 );
    clientfield::register( "toplayer", "setCameraDown", 1, 5, "int", &setcameradown, 0, 0 );
    clientfield::register( "toplayer", "showMap", 1, 1, "int", &showmap, 0, 0 );
    clientfield::register( "toplayer", "toggleflashlight", 1, 1, "int", &function_4fd00e1f, 0, 0 );
    callback::on_spawned( &on_player_spawned );
    function_32d5e898();
    level thread function_c7ab4997();
}

// Namespace doa_player/doa_player
// Params 1, eflags: 0x4
// Checksum 0x5b33fa4d, Offset: 0x6b0
// Size: 0xf0
function private function_c7ab4997( *localclientnum )
{
    self notify( "18a82e0614f867e8" );
    self endon( "18a82e0614f867e8" );
    
    while ( true )
    {
        result = level waittill( #"updategamerprofile", #"hash_ce3d6cba382b09e", #"hash_5f3b1ae5d64be652" );
        namespace_1e25ad94::debugmsg( "profileWatch just intercepted notify-->" + result._notify );
        local_player = function_5c10bd79( result.localclientnum );
        
        if ( isdefined( local_player ) )
        {
            local_player namespace_7f5aeb59::function_4d692cc4( result.localclientnum, local_player.var_88a2ff29 );
        }
    }
}

// Namespace doa_player/doa_player
// Params 1
// Checksum 0xce37826d, Offset: 0x7a8
// Size: 0x108
function function_32d5e898( *localclientnum )
{
    if ( !isdefined( level.doa.var_b73cc08 ) )
    {
        level.doa.var_b73cc08 = spawn( 0, ( 0, 0, 0 ), "script_model" );
        level.doa.var_b73cc08 setmodel( "tag_origin" );
    }
    
    foreach ( player in getlocalplayers() )
    {
        player namespace_7f5aeb59::function_fcc90081();
    }
}

// Namespace doa_player/doa_player
// Params 7
// Checksum 0x55ab59e2, Offset: 0x8b8
// Size: 0x74
function function_e7a44fda( localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    allowactionslotinput( bwastimejump );
    self thread namespace_7f5aeb59::function_4d692cc4( bwastimejump, self.var_88a2ff29 );
}

// Namespace doa_player/doa_player
// Params 1
// Checksum 0x3284c2dd, Offset: 0x938
// Size: 0x24
function on_player_spawned( localclientnum )
{
    self thread namespace_7f5aeb59::function_f3143608( localclientnum );
}

// Namespace doa_player/doa_player
// Params 7
// Checksum 0x4a249be2, Offset: 0x968
// Size: 0x2a4
function function_c75159ad( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump == 0 )
    {
        return;
    }
    
    var_b2b025b1 = getlocalplayers()[ 0 ];
    
    if ( var_b2b025b1.doa.cameramode == 4 )
    {
        forward = anglestoforward( self.angles );
        var_7def0a05 = self.origin + forward * 100;
    }
    else
    {
        var_7def0a05 = self.origin;
    }
    
    origin = var_7def0a05 + ( 20, 0, 2000 );
    bomb = spawn( fieldname, origin, "script_model" );
    bomb setmodel( "zombietron_nuke" );
    bomb.angles = ( 90, 0, 0 );
    bomb moveto( var_7def0a05, 0.3, 0, 0 );
    playsound( 0, "evt_doa_powerup_nuke_activate", self.origin );
    bomb waittill( #"movedone" );
    playsound( fieldname, "evt_doa_powerup_nuke_impact", var_7def0a05 );
    playfx( fieldname, level._effect[ #"bomb" ], var_7def0a05 );
    earthquake( fieldname, 1, 0.8, var_7def0a05, 1000 );
    physicsexplosionsphere( fieldname, var_7def0a05, 1024, 0, 100 );
    bomb delete();
    wait 0.2;
    playfx( fieldname, level._effect[ #"nuke_dust" ], var_7def0a05 );
}

// Namespace doa_player/doa_player
// Params 7
// Checksum 0xe75c8b6b, Offset: 0xc18
// Size: 0x274
function function_43ae94e0( localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    self.var_88a2ff29 = level.default_mapping;
    playsound( bwastimejump, #"hash_51a1d69295a5b7fe", ( 0, 0, 0 ) );
    self.doa.cameramode = 5;
    level.doa.var_b73cc08.origin = self.origin + ( 0, 0, 72 );
    waitframe( 1 );
    level.doa.var_b73cc08.angles = level.var_ca14ee83;
    spot = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + namespace_ac2a80f5::function_ccf8a968( level.doa.var_408cded9 ) );
    level.doa.var_b73cc08 moveto( spot, 0.15 );
    level.doa.var_b73cc08 waittilltimeout( 0.16, #"movedone" );
    self cameraforcedisablescriptcam( 0 );
    
    if ( isdefined( self.doa.var_903d75b1 ) )
    {
        self.doa.cameramode = self.doa.var_903d75b1;
        assert( self.doa.cameramode != 4 );
    }
    else
    {
        self.doa.cameramode = 1;
    }
    
    self.topdowncamera = 1;
    
    if ( isdefined( self.var_1489535e ) )
    {
        killfx( bwastimejump, self.var_1489535e );
        self.var_1489535e = undefined;
    }
    
    self thread namespace_7f5aeb59::function_4d692cc4( bwastimejump, self.var_88a2ff29 );
}

// Namespace doa_player/doa_player
// Params 7
// Checksum 0x7b682a96, Offset: 0xe98
// Size: 0x22c
function function_f32984d0( localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    self.var_88a2ff29 = "zombietron_fps";
    
    if ( self.doa.cameramode == 4 )
    {
        self thread namespace_7f5aeb59::function_4d692cc4( bwastimejump, self.var_88a2ff29 );
        return;
    }
    
    playsound( bwastimejump, #"hash_4716558fb561cab2", ( 0, 0, 0 ) );
    origin = self.origin;
    self.doa.cameramode = 5;
    level.doa.var_b73cc08.origin = level.var_45c6f27d;
    level.doa.var_b73cc08.angles = level.var_ca14ee83;
    level.doa.var_b73cc08 moveto( origin + ( 0, 0, 72 ), 0.3 );
    wait 0.2;
    playfx( bwastimejump, level._effect[ #"explode_lg" ], origin );
    earthquake( bwastimejump, 1, 0.8, origin, 1000 );
    playrumbleonposition( bwastimejump, "damage_heavy", self.origin );
    wait 0.1;
    self.doa.cameramode = 4;
    self.topdowncamera = 0;
    
    if ( isdefined( self ) )
    {
        self thread namespace_7f5aeb59::function_4d692cc4( bwastimejump, self.var_88a2ff29 );
    }
}

// Namespace doa_player/doa_player
// Params 7
// Checksum 0x22309ad2, Offset: 0x10d0
// Size: 0x204
function changecamera( localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump != 0 )
    {
        return;
    }
    
    if ( self.doa.cameramode == 4 )
    {
        return;
    }
    
    self.doa.cameramode = namespace_ac2a80f5::function_1d5dc8d2( bwastimejump, self.doa.cameramode );
    self namespace_ac2a80f5::changecamera( bwastimejump, self.doa.cameramode );
    
    if ( self.doa.cameramode >= 0 && self.doa.cameramode <= 3 )
    {
        self.doa.var_903d75b1 = self.doa.cameramode;
    }
    
    switch ( self.doa.cameramode )
    {
        case 1:
            msg = #"hash_447dc787430ef129";
            break;
        case 0:
            msg = #"hash_7d810006d120ca86";
            break;
        case 2:
            msg = #"hash_61823fb81c973c88";
            break;
        case 3:
            msg = #"hash_6fca4e61bae022cd";
            break;
    }
    
    if ( isdefined( msg ) )
    {
        self thread message( bwastimejump, msg, 2, 0 );
    }
}

// Namespace doa_player/doa_player
// Params 3, eflags: 0x4
// Checksum 0x5fc9290e, Offset: 0x12e0
// Size: 0xa6
function private function_5abfd945( localclientnum, text, var_d9d263a1 = 5 )
{
    self.doa.var_5f165a77 = 1;
    self hud_message::clearlowermessage( localclientnum );
    self hud_message::setlowermessage( localclientnum, text );
    wait var_d9d263a1;
    
    if ( isdefined( self ) )
    {
        self hud_message::clearlowermessage( localclientnum );
        self.doa.var_5f165a77 = 0;
    }
}

// Namespace doa_player/doa_player
// Params 4
// Checksum 0x1d85d8c5, Offset: 0x1390
// Size: 0xc4
function message( localclientnum, text, var_d9d263a1 = 5, hold = 1 )
{
    var_e0e4a2bb = 0;
    
    while ( hold && is_true( self.doa.var_5f165a77 ) )
    {
        var_e0e4a2bb = 1;
        wait 1;
    }
    
    if ( var_e0e4a2bb )
    {
        wait 1;
    }
    
    if ( isdefined( self ) )
    {
        self thread function_5abfd945( localclientnum, text, var_d9d263a1 );
    }
}

// Namespace doa_player/doa_player
// Params 7
// Checksum 0xa69af0a6, Offset: 0x1460
// Size: 0xfc
function resetcamera( localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump != 0 || !isdefined( self.doa ) )
    {
        return;
    }
    
    level.doa.var_72b899ad.var_67c3a8db = undefined;
    level.var_2d592f5b = undefined;
    level.var_45c6f27d = undefined;
    
    if ( isdefined( self.doa.var_903d75b1 ) )
    {
        self.doa.cameramode = self.doa.var_903d75b1;
    }
    else
    {
        self.doa.cameramode = 1;
    }
    
    self namespace_ac2a80f5::changecamera( bwastimejump, self.doa.cameramode );
}

// Namespace doa_player/doa_player
// Params 7
// Checksum 0x199c38f8, Offset: 0x1568
// Size: 0x214
function setcameradown( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( fieldname != 0 )
    {
        return;
    }
    
    if ( bwastimejump )
    {
        maxval = 32 - 1;
        curval = bwastimejump / maxval;
        
        if ( level.doa.flipped )
        {
            curangle = level.doa.var_72b899ad.var_46f3a17d;
        }
        else
        {
            curangle = level.doa.var_72b899ad.var_13ea8aea;
        }
        
        var_2797b11f = curangle[ 0 ];
        maxpitch = 95;
        var_cc5b2628 = lerpfloat( var_2797b11f, maxpitch, curval );
        angle = ( var_cc5b2628, curangle[ 1 ], curangle[ 2 ] );
        level.doa.var_72b899ad.var_67c3a8db = angle;
        namespace_ac2a80f5::function_278f20a3( angle, level.var_d63c863c );
        return;
    }
    
    level.doa.var_72b899ad.var_67c3a8db = undefined;
    
    if ( level.doa.flipped )
    {
        namespace_ac2a80f5::function_278f20a3( level.doa.var_72b899ad.var_46f3a17d, level.var_d63c863c );
        return;
    }
    
    namespace_ac2a80f5::function_278f20a3( level.doa.var_72b899ad.var_13ea8aea, level.var_d63c863c );
}

// Namespace doa_player/doa_player
// Params 7
// Checksum 0x42289dde, Offset: 0x1788
// Size: 0xf4
function laststand( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( fieldname != 0 )
    {
        return;
    }
    
    if ( self.doa.cameramode != 5 )
    {
        if ( bwastimejump )
        {
            self.doa.cameramode = 0;
        }
        else if ( isdefined( self.doa.var_903d75b1 ) )
        {
            self.doa.cameramode = self.doa.var_903d75b1;
        }
        else
        {
            self.doa.cameramode = 1;
        }
        
        self namespace_ac2a80f5::changecamera( fieldname, self.doa.cameramode );
    }
}

// Namespace doa_player/doa_player
// Params 7
// Checksum 0xc71cae4f, Offset: 0x1888
// Size: 0xcc
function showmap( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( fieldname != 0 )
    {
        return;
    }
    
    if ( bwastimejump )
    {
        if ( !level.var_46a66896 doa_overworld::is_open( fieldname ) )
        {
            level.var_46a66896 doa_overworld::open( fieldname );
        }
        
        return;
    }
    
    if ( level.var_46a66896 doa_overworld::is_open( fieldname ) )
    {
        level.var_46a66896 doa_overworld::close( fieldname );
    }
}

// Namespace doa_player/doa_player
// Params 7
// Checksum 0xa3a810c7, Offset: 0x1960
// Size: 0x1ee
function function_4fd00e1f( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump == 1 )
    {
        self playsound( fieldname, #"hash_79a78504d4dbaf3f" );
        
        if ( self.doa.cameramode == 4 )
        {
            if ( viewmodelhastag( fieldname, "tag_flashlight" ) && !isdefined( self.flashlight_fx ) )
            {
                self.flashlight_fx = playviewmodelfx( fieldname, #"hash_679d39e5fd4eae19", "tag_flashlight" );
            }
            else if ( viewmodelhastag( fieldname, "tag_camera" ) && !isdefined( self.flashlight_fx ) )
            {
                self.flashlight_fx = playviewmodelfx( fieldname, #"hash_679d39e5fd4eae19", "tag_camera" );
            }
        }
        else
        {
            self.flashlight_fx = util::playfxontag( fieldname, #"hash_679d39e5fd4eae19", self, "tag_eye" );
        }
        
        return;
    }
    
    if ( isdefined( self.flashlight_fx ) )
    {
        self playsound( fieldname, #"hash_13715035b161a0c3" );
        stopfx( fieldname, self.flashlight_fx );
        self.flashlight_fx = undefined;
    }
}

// Namespace doa_player/doa_player
// Params 7
// Checksum 0xea28b2fb, Offset: 0x1b58
// Size: 0x202
function function_769d489( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    var_b2b025b1 = getlocalplayers()[ 0 ];
    level.doa.cutscene = bwastimejump;
    
    if ( bwastimejump == 0 )
    {
        if ( isdefined( var_b2b025b1.doa.var_903d75b1 ) )
        {
            var_b2b025b1.doa.cameramode = var_b2b025b1.doa.var_903d75b1;
        }
        else
        {
            var_b2b025b1.doa.cameramode = 1;
        }
        
        return;
    }
    
    switch ( bwastimejump )
    {
        case 1:
            var_b2b025b1.doa.cameramode = 5;
            loc = struct::get( "island_cutscene_camloc", "targetname" );
            level.doa.var_b73cc08.origin = loc.origin;
            level.doa.var_b73cc08.angles = loc.angles;
            break;
        case 2:
            var_b2b025b1.doa.cameramode = 5;
            loc = struct::get( "podium_camera", "targetname" );
            level.doa.var_b73cc08.origin = loc.origin;
            level.doa.var_b73cc08.angles = loc.angles;
            break;
    }
}

