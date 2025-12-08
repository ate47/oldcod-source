#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_350cffecd05ef6cf;
#using script_40f967ad5d18ea74;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_6b6510e124bad778;
#using script_74a56359b7d02ab6;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_a4bedd45;

// Namespace namespace_a4bedd45/namespace_1dde4e70
// Params 1
// Checksum 0xcf23eeaf, Offset: 0x1e8
// Size: 0x76
function function_49f419a1( time = 1 )
{
    self endon( #"disconnect" );
    old = self.doa.var_4f3aee7b;
    self.doa.var_4f3aee7b = 1;
    wait time;
    self.doa.var_4f3aee7b = old;
}

// Namespace namespace_a4bedd45/namespace_1dde4e70
// Params 0
// Checksum 0x47ced15f, Offset: 0x268
// Size: 0x96
function function_17c3e29f()
{
    self notify( "6769e45d3b4c8709" );
    self endon( "6769e45d3b4c8709" );
    self endon( #"disconnect" );
    self endon( #"hash_7893364bd228d63e" );
    level waittill( #"doa_exit_taken", #"teleporter_taken", #"enter_the_wild", #"hash_7893364bd228d63e" );
    self notify( #"hash_7893364bd228d63e" );
}

// Namespace namespace_a4bedd45/namespace_1dde4e70
// Params 1
// Checksum 0x2bbc922a, Offset: 0x308
// Size: 0x5c4
function function_1735c657( forced )
{
    self notify( "22fa016876f3198f" );
    self endon( "22fa016876f3198f" );
    self endon( #"disconnect" );
    
    if ( !is_true( self.doa.var_1b452923 ) )
    {
        self namespace_83eb6304::function_3ecfde67( "firstPersonMarker" );
    }
    
    self thread function_17c3e29f();
    timeout = self namespace_1c2a96f9::function_4808b985( 60 );
    result = self waittilltimeout( timeout, #"camera_changed", #"hash_7893364bd228d63e" );
    
    if ( forced )
    {
        if ( !is_true( result.var_cff8d1e ) )
        {
            self thread function_1735c657( forced );
        }
    }
    
    angles = vectortoangles( anglestoforward( self.angles ) );
    angles = ( 0, angles[ 1 ], 0 );
    faceangles = isdefined( result.faceangles ) ? result.faceangles : angles;
    self notify( #"hash_7893364bd228d63e" );
    self freezecontrols( 1 );
    
    if ( is_true( self.doa.var_f583234e ) )
    {
        self clientfield::set_to_player( "toggleflashlight", 0 );
    }
    
    self thread namespace_7f5aeb59::turnplayershieldon();
    self.topdowncamera = 1;
    self setclientthirdperson( 0 );
    
    if ( isalive( self ) && !is_true( self.doa.respawning ) )
    {
        self.health = self.maxhealth;
    }
    
    if ( !isdefined( self.vehicle ) )
    {
        self namespace_83eb6304::function_3ecfde67( "player_trail_" + self.doa.color );
    }
    
    self clientfield::increment_to_player( "exitFPS" );
    self.doa.var_21eab413 = gettime() + 2500;
    
    /#
        namespace_1e25ad94::debugmsg( "<dev string:x38>" + self.name + "<dev string:x44>" + gettime() );
    #/
    
    self namespace_7f5aeb59::function_fae39d88();
    wait 0.25;
    org = undefined;
    
    if ( isdefined( faceangles ) )
    {
        org = namespace_ec06fe4a::spawnmodel( self.origin, "tag_origin" );
        
        if ( isdefined( org ) )
        {
            org thread namespace_ec06fe4a::function_ae010bb4( self );
            org.angles = self.angles;
            self linkto( org );
            org rotateto( faceangles, 0.25 );
            wait 0.25;
        }
    }
    
    if ( isdefined( org ) )
    {
        self unlink();
        org delete();
    }
    
    wait 0.2;
    self.doa.infps = undefined;
    self freezecontrols( 0 );
    self namespace_83eb6304::turnofffx( "firstPersonMarker" );
    
    if ( is_true( self.doa.var_f583234e ) )
    {
        self clientfield::set_to_player( "toggleflashlight", 1 );
    }
    
    self clientfield::increment_to_player( "controlBinding" );
    var_4cfad8a1 = 0;
    
    foreach ( player in getplayers() )
    {
        if ( is_true( player.doa.infps ) )
        {
            var_4cfad8a1++;
        }
    }
    
    if ( var_4cfad8a1 == 0 )
    {
        level clientfield::set( "doafps", 0 );
    }
}

// Namespace namespace_a4bedd45/namespace_1dde4e70
// Params 2
// Checksum 0x71c6b2da, Offset: 0x8d8
// Size: 0x474
function function_1f704cee( force = 0, faceangles = 1 )
{
    self notify( "536bc0ce0456b2b9" );
    self endon( "536bc0ce0456b2b9" );
    self endon( #"disconnect" );
    
    if ( is_true( self.doa.infps ) )
    {
        self thread function_1735c657( force );
        return;
    }
    
    /#
        namespace_1e25ad94::debugmsg( "<dev string:x38>" + self.name + "<dev string:x5e>" + gettime() );
    #/
    
    self.doa.infps = 1;
    self.doa.var_37fe6ba1 = force;
    self.doa.var_4f3aee7b = force;
    self.doa.var_9f8bc3f9 = 0;
    self thread namespace_7f5aeb59::turnplayershieldon( 0 );
    self thread function_49f419a1();
    self namespace_83eb6304::turnofffx( "player_trail_" + self.doa.color );
    angles = vectortoangles( anglestoforward( self.angles ) );
    angles = ( 0, angles[ 1 ], 0 );
    
    if ( is_true( self.doa.var_f583234e ) )
    {
        self clientfield::set_to_player( "toggleflashlight", 0 );
    }
    
    self freezecontrols( 1 );
    self clientfield::increment_to_player( "goFPS" );
    level clientfield::set( "doafps", 1 );
    wait 0.35;
    self freezecontrols( 0 );
    self.topdowncamera = 0;
    self setclientthirdperson( 0 );
    
    if ( is_true( self.doa.var_f583234e ) )
    {
        self clientfield::set_to_player( "toggleflashlight", 1 );
    }
    
    if ( is_true( faceangles ) )
    {
        if ( isdefined( self.doa.var_5d4bd96f ) )
        {
            self.doa.var_5d4bd96f delete();
        }
        
        self.doa.var_5d4bd96f = namespace_ec06fe4a::spawnmodel( self.origin, "tag_origin" );
        
        if ( isdefined( self.doa.var_5d4bd96f ) )
        {
            self.doa.var_5d4bd96f thread namespace_ec06fe4a::function_ae010bb4( self );
            self.doa.var_5d4bd96f.angles = self.angles;
            self linkto( self.doa.var_5d4bd96f );
            self.doa.var_5d4bd96f rotateto( angles, 0.25 );
            wait 0.25;
            self unlink();
            self.doa.var_5d4bd96f delete();
        }
    }
    
    self namespace_7f5aeb59::function_fae39d88();
    self thread function_1735c657( force );
}

