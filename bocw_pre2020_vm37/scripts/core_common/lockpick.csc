#using script_1cd690a97dfca36e;
#using script_1d4ca739cb476f50;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\serverfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\snd;

#namespace lockpick;

// Namespace lockpick/lockpick
// Params 0, eflags: 0x6
// Checksum 0x99084e40, Offset: 0x330
// Size: 0x34
function private autoexec __init__system__()
{
    system::register( "lockpick", &preinit, undefined, undefined, undefined );
}

// Namespace lockpick/lockpick
// Params 0, eflags: 0x4
// Checksum 0x367f4da7, Offset: 0x370
// Size: 0x104
function private preinit()
{
    clientfield::register( "toplayer", "lockpick_state", 1, 1, "int", &function_ef87790b, 0, 0 );
    clientfield::register( "toplayer", "lockpick_num_pins", 1, 3, "int", &function_a24ecc14, 0, 0 );
    clientfield::register( "toplayer", "lockpick_lock_index", 1, 1, "int", &function_72047528, 0, 0 );
    serverfield::register( "lockpick_state", 1, 2, "int" );
}

// Namespace lockpick/lockpick
// Params 7, eflags: 0x4
// Checksum 0x79f291ff, Offset: 0x480
// Size: 0xe4
function private function_ef87790b( localclientnum, oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( !self util::function_50ed1561( binitialsnap ) )
    {
        return;
    }
    
    if ( isdemoplaying() )
    {
        return;
    }
    
    if ( fieldname == bwastimejump )
    {
        return;
    }
    
    self function_d65cbeab();
    start = bwastimejump & 1;
    
    if ( start )
    {
        self minigame_start( binitialsnap );
        return;
    }
    
    self function_9b9eaf7e();
}

// Namespace lockpick/lockpick
// Params 7, eflags: 0x4
// Checksum 0x68d50787, Offset: 0x570
// Size: 0x9e
function private function_a24ecc14( localclientnum, oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( isdemoplaying() )
    {
        return;
    }
    
    if ( !self util::function_50ed1561( binitialsnap ) )
    {
        return;
    }
    
    if ( fieldname == bwastimejump )
    {
        return;
    }
    
    self function_d65cbeab();
    self.minigame.difficulty = bwastimejump;
}

// Namespace lockpick/lockpick
// Params 7, eflags: 0x4
// Checksum 0x64c92d7b, Offset: 0x618
// Size: 0x9e
function private function_72047528( localclientnum, oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( isdemoplaying() )
    {
        return;
    }
    
    if ( !self util::function_50ed1561( binitialsnap ) )
    {
        return;
    }
    
    if ( fieldname == bwastimejump )
    {
        return;
    }
    
    self function_d65cbeab();
    self.minigame.var_843d0b2b = bwastimejump;
}

// Namespace lockpick/lockpick
// Params 0, eflags: 0x4
// Checksum 0xda57122f, Offset: 0x6c0
// Size: 0x5e
function private function_d65cbeab()
{
    if ( !isdefined( self.minigame ) )
    {
        self.minigame = spawnstruct();
        self.minigame.enabled = 0;
        self.minigame.difficulty = 1;
        self.minigame.var_843d0b2b = 0;
    }
}

// Namespace lockpick/lockpick
// Params 1, eflags: 0x4
// Checksum 0x66767974, Offset: 0x728
// Size: 0x84
function private minigame_start( localclientnum )
{
    self function_d65cbeab();
    
    if ( self.minigame.enabled )
    {
        return;
    }
    
    self function_64609828();
    
    while ( function_18308bc1( localclientnum ) )
    {
        waitframe( 1 );
    }
    
    self thread function_bef7a7e6( localclientnum );
}

// Namespace lockpick/lockpick
// Params 0, eflags: 0x4
// Checksum 0xfb003932, Offset: 0x7b8
// Size: 0x4bc
function private function_64609828()
{
    self.minigame.enabled = 1;
    self.minigame.running = 1;
    self.minigame.complete = 0;
    self.minigame.rootmodel = function_80847fa6( self.localclientnum );
    self.minigame.var_c393c6bc = getscriptbundle( "minigame_lockpick" );
    assert( self.minigame.difficulty > 0 && self.minigame.difficulty <= 5 );
    self.minigame.var_b263f6a2 = getscriptbundle( self.minigame.var_c393c6bc.var_b263f6a2 );
    self.minigame.scratch = spawnstruct();
    self.minigame.var_e9d52f77 = self.minigame.var_b263f6a2.var_b263f6a2[ self.minigame.var_843d0b2b ].minigame;
    self.minigame.var_be8b922e = getscriptbundle( self.minigame.var_e9d52f77 );
    self.minigame.scratch.var_83e465eb = self.minigame.difficulty;
    self.minigame.scratch.var_b47c6dfb = 1;
    self.minigame.scratch.var_b4059b5f = 0;
    self.minigame.scratch.var_ff738e09 = 0;
    self.minigame.scratch.var_7c5c4577 = 0;
    self.minigame.scratch.var_f2412eaf = 0;
    self.minigame.scratch.var_b2a5eac8 = 0;
    self.minigame.audio = spawnstruct();
    self.minigame.audio.var_d8de23d1 = 0;
    self.minigame.audio.var_78430c0a = 0;
    self.minigame.audio.var_d1d4a588 = 0;
    self.minigame.audio.var_6a7c9466 = 0;
    self.minigame.audio.var_6dc5be9f = 0;
    self.minigame.audio.var_cf3d2929 = 0;
    self function_a0aa5f5f( 1 );
    function_90b8720( self.localclientnum, self.minigame.scratch.var_83e465eb );
    function_2c6a1130( self.localclientnum, self.minigame.var_e9d52f77 );
    function_28ef17b1( self.localclientnum, self.minigame.scratch.var_b4059b5f );
    function_192c93dd( self.localclientnum, self.minigame.scratch.var_ff738e09 );
    function_59f6b71c( self.localclientnum, self.minigame.scratch.var_7c5c4577 );
    function_efaef15b( self.localclientnum, 0 );
    function_ef54083f( self.localclientnum, 0 );
    
    for ( var_bfb4aca5 = 1; var_bfb4aca5 <= 5 ; var_bfb4aca5++ )
    {
        function_e9e03641( self.localclientnum, var_bfb4aca5, 0 );
    }
    
    function_ef02d214( self.localclientnum, 1 );
    self serverfield::set( "lockpick_state", 0 );
}

// Namespace lockpick/lockpick
// Params 0, eflags: 0x4
// Checksum 0xe11b0f30, Offset: 0xc80
// Size: 0x72
function private function_17e7b461()
{
    return lerpfloat( self.minigame.var_be8b922e.var_84bfe4cb, self.minigame.var_be8b922e.var_1c764e77, self.minigame.scratch.var_b47c6dfb / self.minigame.scratch.var_83e465eb );
}

// Namespace lockpick/lockpick
// Params 1, eflags: 0x4
// Checksum 0xeb591a84, Offset: 0xd00
// Size: 0x452
function private function_a0aa5f5f( init )
{
    if ( isdefined( init ) ? init : 0 )
    {
        self.minigame.scratch.var_5d92bcc8 = randomfloatrange( self.minigame.var_be8b922e.var_84bfe4cb * self.minigame.var_be8b922e.var_9be11610, 90 ) * math::randomsign();
        self.minigame.scratch.var_9fa74a7c = math::sign( self.minigame.scratch.var_5d92bcc8 );
        self.minigame.scratch.var_66a8f3b7 = randomfloatrange( self.minigame.var_be8b922e.var_84bfe4cb * 2, abs( -60 ) ) * math::randomsign();
        return;
    }
    
    var_4cbec6df = self function_17e7b461();
    var_17ecda5a = 0;
    var_76514cc5 = var_4cbec6df * self.minigame.var_be8b922e.var_9be11610;
    
    if ( self.minigame.var_be8b922e.var_71de0627 == "random" )
    {
        var_17ecda5a = randomfloatrange( var_76514cc5, 90 ) * math::randomsign();
        
        if ( abs( self.minigame.scratch.var_5d92bcc8 + var_17ecda5a ) > 90 )
        {
            var_17ecda5a *= -1;
        }
    }
    else if ( self.minigame.var_be8b922e.var_71de0627 == "alternating sides" )
    {
        var_17ecda5a = randomfloatrange( var_76514cc5, 90 + abs( self.minigame.scratch.var_5d92bcc8 ) ) * math::sign( self.minigame.scratch.var_5d92bcc8 ) * -1;
    }
    else if ( self.minigame.var_be8b922e.var_71de0627 == "alternating directions" )
    {
        self.minigame.scratch.var_9fa74a7c *= -1;
        var_7f321bad = var_4cbec6df * self.minigame.var_be8b922e.var_59079673;
        var_17ecda5a = randomfloatrange( var_76514cc5, var_7f321bad ) * self.minigame.scratch.var_9fa74a7c;
    }
    
    self.minigame.scratch.var_5d92bcc8 += var_17ecda5a;
    self.minigame.scratch.var_66a8f3b7 = randomfloatrange( self.minigame.var_be8b922e.var_84bfe4cb * 2, abs( -60 ) ) * math::sign( self.minigame.scratch.var_66a8f3b7 ) * -1;
}

// Namespace lockpick/lockpick
// Params 1, eflags: 0x4
// Checksum 0x8c87b84c, Offset: 0x1160
// Size: 0x12c
function private function_bef7a7e6( localclientnum )
{
    self endoncallback( &function_9b9eaf7e, #"death", #"disconnect", #"minigame_close" );
    self function_95eb0e7b( self.minigame.var_be8b922e.var_346d34d3, 0 );
    
    while ( self.minigame.running )
    {
        self function_969d3dfa();
        self function_8b0dc9ba( localclientnum );
        self function_7265f078( localclientnum );
        waitframe( 1 );
    }
    
    while ( self.minigame.enabled )
    {
        self function_d04f90d8( localclientnum );
        waitframe( 1 );
    }
    
    self function_35d8ea7();
}

// Namespace lockpick/lockpick
// Params 0
// Checksum 0x65eb3478, Offset: 0x1298
// Size: 0x182
function function_969d3dfa()
{
    if ( !isdefined( self.minigame.scratch.framestart ) )
    {
        self.minigame.scratch.framestart = getrealtime();
    }
    
    self.minigame.currenttime = getrealtime();
    self.minigame.scratch.frametime = self.minigame.currenttime - self.minigame.scratch.framestart;
    
    if ( self.minigame.scratch.frametime < 1 )
    {
        self.minigame.scratch.frametime = 1;
    }
    else if ( self.minigame.scratch.frametime > 100 )
    {
        self.minigame.scratch.frametime = 100;
    }
    
    self.minigame.scratch.var_e0861271 = self.minigame.scratch.frametime / 1000;
    self.minigame.scratch.framestart = self.minigame.currenttime;
}

// Namespace lockpick/lockpick
// Params 1
// Checksum 0x71f68f89, Offset: 0x1428
// Size: 0x9e
function function_d04f90d8( localclientnum )
{
    var_8a2bbd4 = gamepadusedlast( localclientnum ) && self flag::get( #"ui_cancel" );
    
    if ( !self.minigame.complete && ( var_8a2bbd4 || function_18308bc1( localclientnum ) ) )
    {
        self notify( #"minigame_close" );
    }
}

// Namespace lockpick/lockpick
// Params 1, eflags: 0x4
// Checksum 0x440da2bd, Offset: 0x14d0
// Size: 0x294
function private function_8b0dc9ba( localclientnum )
{
    self.minigame.scratch.input = util::function_ca4b4e19( localclientnum, 0 );
    self.minigame.scratch.var_8e926fa1 = gamepadusedlast( localclientnum );
    
    if ( self.minigame.scratch.var_8e926fa1 )
    {
        fakeactor_node_get_cover_list = self.minigame.var_be8b922e.var_4436bd13 == "look" && self.minigame.var_be8b922e.var_f1206d0d == "left-right" || self.minigame.var_be8b922e.var_4436bd13 != "look" && self.minigame.var_be8b922e.var_d74b78fc == "tension";
        self.minigame.scratch.input[ #"look" ] = util::function_63320ea1( self.minigame.scratch.input[ #"look" ], 0.2, fakeactor_node_get_cover_list );
        var_bef152 = self.minigame.var_be8b922e.var_4436bd13 == "move" && self.minigame.var_be8b922e.var_f1206d0d == "left-right" || self.minigame.var_be8b922e.var_4436bd13 != "move" && self.minigame.var_be8b922e.var_d74b78fc == "tension";
        self.minigame.scratch.input[ #"move" ] = util::function_63320ea1( self.minigame.scratch.input[ #"move" ], 0.2, var_bef152 );
    }
}

// Namespace lockpick/lockpick
// Params 1, eflags: 0x4
// Checksum 0x5cacde10, Offset: 0x1770
// Size: 0x2b4
function private function_395ef29b( input )
{
    var_25230564 = 1;
    
    if ( self.minigame.var_be8b922e.var_f1206d0d == "left-right" || !self.minigame.scratch.var_8e926fa1 )
    {
        self.minigame.scratch.var_b4059b5f -= input[ 0 ] * self.minigame.var_be8b922e.var_b0b43710 * self.minigame.scratch.var_e0861271;
    }
    else if ( self.minigame.var_be8b922e.var_f1206d0d == "full arc" )
    {
        if ( length( input ) > 0.5 )
        {
            yaw = angleclamp180( vectortoangles( input )[ 1 ] - 90 );
            
            if ( yaw >= -150 && yaw <= 150 )
            {
                self.minigame.scratch.var_b4059b5f = anglelerp( self.minigame.scratch.var_b4059b5f, math::clamp( yaw, -90, 90 ), 0.25 );
            }
            
            var_25230564 = 0;
        }
        else
        {
            self.minigame.scratch.var_b4059b5f = anglelerp( self.minigame.scratch.var_b4059b5f, 0, 0.25 );
        }
    }
    
    self.minigame.scratch.var_b4059b5f = math::clamp( self.minigame.scratch.var_b4059b5f, -90, 90 );
    function_28ef17b1( self.localclientnum, self.minigame.scratch.var_b4059b5f );
}

// Namespace lockpick/lockpick
// Params 1, eflags: 0x4
// Checksum 0x1b9faff6, Offset: 0x1a30
// Size: 0x304
function private function_fcaeb0c3( input )
{
    if ( self.minigame.var_be8b922e.var_d74b78fc == "tension" || !self.minigame.scratch.var_8e926fa1 )
    {
        if ( input[ 0 ] < 0 )
        {
            if ( input[ 0 ] < -0.75 )
            {
                self.minigame.scratch.var_7c5c4577 = anglelerp( self.minigame.scratch.var_7c5c4577, -60, 0.25 );
            }
            else
            {
                self.minigame.scratch.var_7c5c4577 = anglelerp( self.minigame.scratch.var_7c5c4577, input[ 0 ] * -60 * -1, 0.25 );
            }
        }
        else
        {
            self.minigame.scratch.var_7c5c4577 = anglelerp( self.minigame.scratch.var_7c5c4577, input[ 0 ] * 5, 0.25 );
        }
    }
    else if ( self.minigame.var_be8b922e.var_d74b78fc == "sweetspot" )
    {
        if ( length( input ) > 0.5 )
        {
            yaw = angleclamp180( vectortoangles( input )[ 1 ] + 90 );
            
            if ( yaw >= -150 && yaw <= 150 )
            {
                self.minigame.scratch.var_7c5c4577 = anglelerp( self.minigame.scratch.var_7c5c4577, math::clamp( yaw, -60, abs( -60 ) ), 0.25 );
            }
        }
        else
        {
            self.minigame.scratch.var_7c5c4577 = anglelerp( self.minigame.scratch.var_7c5c4577, 0, 0.25 );
        }
    }
    
    function_59f6b71c( self.localclientnum, self.minigame.scratch.var_7c5c4577 );
}

// Namespace lockpick/lockpick
// Params 1, eflags: 0x4
// Checksum 0x27ed654, Offset: 0x1d40
// Size: 0x264
function private function_7265f078( localclientnum )
{
    self function_d04f90d8( localclientnum );
    var_c7cdd0d8 = self.minigame.scratch.input[ #"look" ];
    var_9e82ccf9 = self.minigame.scratch.input[ #"move" ];
    
    if ( self.minigame.var_be8b922e.var_4436bd13 == "move" )
    {
        var_c7cdd0d8 = self.minigame.scratch.input[ #"move" ];
        var_9e82ccf9 = self.minigame.scratch.input[ #"look" ];
    }
    
    self function_395ef29b( var_c7cdd0d8 );
    self function_fcaeb0c3( var_9e82ccf9 );
    var_999c568b = 0;
    
    if ( self.minigame.var_be8b922e.var_d74b78fc == "sweetspot" && self.minigame.scratch.var_8e926fa1 )
    {
        var_999c568b = abs( self.minigame.scratch.var_7c5c4577 - self.minigame.scratch.var_66a8f3b7 ) <= self.minigame.var_be8b922e.var_84bfe4cb;
    }
    else
    {
        var_999c568b = self.minigame.scratch.var_7c5c4577 <= -59.4;
    }
    
    self function_74dbcf3e( var_999c568b );
    self function_2d0a7942( self.minigame.var_be8b922e.var_346d34d3, self.minigame.scratch.var_b2a5eac8 );
}

// Namespace lockpick/lockpick
// Params 1, eflags: 0x4
// Checksum 0xd1e4879e, Offset: 0x1fb0
// Size: 0x4ce
function private function_74dbcf3e( var_999c568b )
{
    var_4cbec6df = self function_17e7b461();
    var_60088c20 = absangleclamp180( self.minigame.scratch.var_b4059b5f - self.minigame.scratch.var_5d92bcc8 );
    
    if ( var_999c568b )
    {
        self function_efaef15b( self.localclientnum, 1 );
        function_be84563( self.localclientnum, 0 );
    }
    else
    {
        if ( self.minigame.var_be8b922e.var_d74b78fc == "tension" || !self.minigame.scratch.var_8e926fa1 )
        {
            var_60088c20 = 360;
        }
        
        self function_efaef15b( self.localclientnum, 0 );
        function_be84563( self.localclientnum, 1 );
    }
    
    /#
        if ( getdvarint( #"hash_39c760dd3b3fcc2f", 0 ) )
        {
            self.minigame.complete = 1;
            self minigame_complete();
            return;
        }
    #/
    
    var_bff04727 = var_60088c20 <= var_4cbec6df ? 0 : 1;
    
    if ( var_60088c20 <= var_4cbec6df && var_999c568b )
    {
        self.minigame.scratch.var_f2412eaf += self.minigame.scratch.var_e0861271;
        
        if ( self.minigame.scratch.var_f2412eaf >= self.minigame.var_be8b922e.var_426eb8da )
        {
            self function_e9e03641( self.localclientnum, self.minigame.scratch.var_b47c6dfb, 2 );
            self function_192c93dd( self.localclientnum, 0 );
            self.minigame.scratch.var_b47c6dfb++;
            self.minigame.scratch.var_f2412eaf = 0;
            
            if ( self.minigame.scratch.var_b47c6dfb > self.minigame.scratch.var_83e465eb )
            {
                self.minigame.complete = 1;
                self minigame_complete();
            }
            else
            {
                self function_a0aa5f5f();
            }
        }
        else
        {
            self function_192c93dd( self.localclientnum, 2 );
        }
    }
    else
    {
        self.minigame.scratch.var_f2412eaf = 0;
        
        if ( var_60088c20 <= var_4cbec6df * 2 )
        {
            self function_e9e03641( self.localclientnum, self.minigame.scratch.var_b47c6dfb, 1 );
            self function_192c93dd( self.localclientnum, 1 );
        }
        else
        {
            self function_e9e03641( self.localclientnum, self.minigame.scratch.var_b47c6dfb, 0 );
            self function_192c93dd( self.localclientnum, 0 );
        }
    }
    
    function_3e356694( self.localclientnum, var_bff04727 );
    self.minigame.scratch.var_b2a5eac8 = 1 - ( math::clamp( var_60088c20, var_4cbec6df, var_4cbec6df * 2 ) - var_4cbec6df ) / var_4cbec6df;
}

// Namespace lockpick/lockpick
// Params 2, eflags: 0x4
// Checksum 0x7e6d6e0c, Offset: 0x2488
// Size: 0x8e
function private function_95eb0e7b( rumble, fadestart )
{
    if ( !isdefined( self.minigame.var_b5d11637 ) || self.minigame.var_b5d11637 != rumble )
    {
        function_35d8ea7();
        function_fe0ad36e( self.localclientnum, rumble, fadestart );
        self.minigame.var_b5d11637 = rumble;
    }
}

// Namespace lockpick/lockpick
// Params 2, eflags: 0x4
// Checksum 0x41172435, Offset: 0x2520
// Size: 0x74
function private function_2d0a7942( rumble, fade )
{
    if ( !isdefined( self.minigame.var_b5d11637 ) )
    {
        function_95eb0e7b( rumble );
    }
    
    if ( self.minigame.var_b5d11637 == rumble )
    {
        self function_7921b8a( self.localclientnum, rumble, fade );
    }
}

// Namespace lockpick/lockpick
// Params 0, eflags: 0x4
// Checksum 0x54d854f5, Offset: 0x25a0
// Size: 0x52
function private function_35d8ea7()
{
    if ( isdefined( self.minigame.var_b5d11637 ) )
    {
        self stoprumble( self.localclientnum, self.minigame.var_b5d11637 );
        self.minigame.var_b5d11637 = undefined;
    }
}

// Namespace lockpick/lockpick
// Params 0, eflags: 0x4
// Checksum 0xa646ffae, Offset: 0x2600
// Size: 0xce
function private minigame_complete()
{
    assert( self.minigame.complete );
    self.minigame.running = 0;
    self function_35d8ea7();
    thread function_f081ea1a();
    function_36e4ebd4( self.localclientnum, self.minigame.var_be8b922e.var_c9b335a4 );
    self function_ef54083f( self.localclientnum, 1 );
    wait 2;
    self notify( #"minigame_close" );
}

// Namespace lockpick/lockpick
// Params 1, eflags: 0x4
// Checksum 0x5dc0c4e0, Offset: 0x26d8
// Size: 0xea
function private function_9b9eaf7e( *notifyhash )
{
    if ( !self.minigame.enabled )
    {
        return;
    }
    
    function_ef02d214( self.localclientnum, 0 );
    self serverfield::set( "lockpick_state", is_true( self.minigame.complete ) ? 2 : 1 );
    self function_35d8ea7();
    function_3424c790();
    self.minigame.scratch = undefined;
    self.minigame.running = 0;
    self.minigame.enabled = 0;
    self.minigame.audio = undefined;
}

// Namespace lockpick/lockpick
// Params 0
// Checksum 0xce5853f2, Offset: 0x27d0
// Size: 0x2c
function function_f081ea1a()
{
    function_3424c790();
    snd::play( "evt_lockpick_unlock", self );
}

// Namespace lockpick/lockpick
// Params 0
// Checksum 0x160c3fdf, Offset: 0x2808
// Size: 0x34
function function_3424c790()
{
    snd::stop( self.minigame.audio.var_f1ed0ff0, 0.25 );
}

// Namespace lockpick/lockpick
// Params 1, eflags: 0x4
// Checksum 0x5516583b, Offset: 0x2848
// Size: 0x2a
function private function_80847fa6( localclientnum )
{
    return function_1df4c3b0( localclientnum, #"lockpick" );
}

// Namespace lockpick/lockpick
// Params 2, eflags: 0x4
// Checksum 0x153e612e, Offset: 0x2880
// Size: 0x64
function private function_ef02d214( localclientnum, active )
{
    rootmodel = function_80847fa6( localclientnum );
    setuimodelvalue( getuimodel( rootmodel, "active" ), active );
}

// Namespace lockpick/lockpick
// Params 2, eflags: 0x4
// Checksum 0x2dd1457c, Offset: 0x28f0
// Size: 0x94
function private function_90b8720( localclientnum, var_83e465eb )
{
    assert( var_83e465eb > 0 && var_83e465eb <= 5 );
    rootmodel = function_80847fa6( localclientnum );
    setuimodelvalue( getuimodel( rootmodel, "numPins" ), var_83e465eb );
}

// Namespace lockpick/lockpick
// Params 2, eflags: 0x4
// Checksum 0x73953a0e, Offset: 0x2990
// Size: 0x64
function private function_2c6a1130( localclientnum, var_8b0a564b )
{
    rootmodel = function_80847fa6( localclientnum );
    setuimodelvalue( getuimodel( rootmodel, "lockDataAsset" ), var_8b0a564b );
}

// Namespace lockpick/lockpick
// Params 2, eflags: 0x4
// Checksum 0xfa0d85cd, Offset: 0x2a00
// Size: 0x1ae
function private function_28ef17b1( localclientnum, angle )
{
    rootmodel = function_80847fa6( localclientnum );
    setuimodelvalue( getuimodel( rootmodel, "pickAngle" ), angle );
    diff = abs( self.minigame.audio.var_6dc5be9f - angle );
    
    if ( diff > 1 )
    {
        if ( !self.minigame.audio.var_cf3d2929 )
        {
            self.minigame.audio.var_cf3d2929 = 1;
            var_ab8a5e59 = snd::play( "evt_lockpick_pick_move", self );
            
            if ( diff < 2 )
            {
                vol = mapfloat( 1, 60, 0, 1, diff );
                snd::set_volume( var_ab8a5e59, vol, 0.05 );
            }
        }
    }
    else if ( self.minigame.audio.var_cf3d2929 )
    {
        self.minigame.audio.var_cf3d2929 = 0;
    }
    
    self.minigame.audio.var_6dc5be9f = angle;
}

// Namespace lockpick/lockpick
// Params 2, eflags: 0x4
// Checksum 0xdcedca9b, Offset: 0x2bb8
// Size: 0x64
function private function_192c93dd( localclientnum, state )
{
    rootmodel = function_80847fa6( localclientnum );
    setuimodelvalue( getuimodel( rootmodel, "pickState" ), state );
}

// Namespace lockpick/lockpick
// Params 2, eflags: 0x4
// Checksum 0x301c9397, Offset: 0x2c28
// Size: 0x256
function private function_59f6b71c( localclientnum, angle )
{
    rootmodel = function_80847fa6( localclientnum );
    setuimodelvalue( getuimodel( rootmodel, "wrenchAngle" ), angle );
    
    if ( abs( self.minigame.audio.var_d1d4a588 - angle ) > 1 )
    {
        if ( !self.minigame.audio.var_6a7c9466 )
        {
            self.minigame.audio.var_6a7c9466 = 1;
            var_83a8fad2 = 0;
            
            if ( angle < self.minigame.audio.var_d1d4a588 )
            {
                diff = abs( angle - self.minigame.audio.var_d1d4a588 );
                var_83a8fad2 = snd::play( "evt_lockpick_wrench_tighten", self );
            }
            else
            {
                diff = abs( self.minigame.audio.var_d1d4a588 - angle );
                var_83a8fad2 = snd::play( "evt_lockpick_wrench_loosen", self );
            }
            
            if ( diff < 4 )
            {
                vol = mapfloat( 0, 60, 0, 1, diff );
                snd::set_volume( var_83a8fad2, vol, 0.05 );
            }
        }
    }
    else if ( self.minigame.audio.var_6a7c9466 )
    {
        self.minigame.audio.var_6a7c9466 = 0;
    }
    
    self.minigame.audio.var_d1d4a588 = angle;
}

// Namespace lockpick/lockpick
// Params 2, eflags: 0x4
// Checksum 0xfe64b0b5, Offset: 0x2e88
// Size: 0x13e
function private function_efaef15b( localclientnum, state )
{
    rootmodel = function_80847fa6( localclientnum );
    setuimodelvalue( getuimodel( rootmodel, "wrenchState" ), state );
    
    if ( state == 1 && self.minigame.audio.var_78430c0a == 0 )
    {
        self.minigame.audio.var_f1ed0ff0 = snd::play( "evt_lockpick_wrench_tension_loop", self );
    }
    else if ( state == 0 && self.minigame.audio.var_78430c0a == 1 )
    {
        snd::stop( self.minigame.audio.var_f1ed0ff0, 0.25 );
    }
    
    self.minigame.audio.var_78430c0a = state;
}

// Namespace lockpick/lockpick
// Params 2, eflags: 0x4
// Checksum 0xb9ea48d5, Offset: 0x2fd0
// Size: 0x64
function private function_3e356694( localclientnum, alpha )
{
    rootmodel = function_80847fa6( localclientnum );
    setuimodelvalue( getuimodel( rootmodel, "pickInputHintAlpha" ), alpha );
}

// Namespace lockpick/lockpick
// Params 2, eflags: 0x4
// Checksum 0x469abc78, Offset: 0x3040
// Size: 0x64
function private function_be84563( localclientnum, alpha )
{
    rootmodel = function_80847fa6( localclientnum );
    setuimodelvalue( getuimodel( rootmodel, "wrenchInputHintAlpha" ), alpha );
}

// Namespace lockpick/lockpick
// Params 2, eflags: 0x4
// Checksum 0x38fc7f4c, Offset: 0x30b0
// Size: 0x64
function private function_ef54083f( localclientnum, unlocked )
{
    rootmodel = function_80847fa6( localclientnum );
    setuimodelvalue( getuimodel( rootmodel, "unlocked" ), unlocked );
}

// Namespace lockpick/lockpick
// Params 2, eflags: 0x4
// Checksum 0x17348dd5, Offset: 0x3120
// Size: 0x9a
function private function_5a89af80( localclientnum, pin )
{
    assert( pin > 0 && pin <= 5 );
    rootmodel = function_80847fa6( localclientnum );
    var_8ec71e64 = getuimodel( rootmodel, "pin" + pin );
    return var_8ec71e64;
}

// Namespace lockpick/lockpick
// Params 3, eflags: 0x4
// Checksum 0xefda82bb, Offset: 0x31c8
// Size: 0x14e
function private function_e9e03641( localclientnum, pin, state )
{
    setuimodelvalue( getuimodel( function_5a89af80( localclientnum, pin ), "state" ), state );
    
    if ( state == 1 && self.minigame.audio.var_d8de23d1 == 0 )
    {
        snd::play( "evt_lockpick_pin_lifted", self );
    }
    else if ( state == 0 && self.minigame.audio.var_d8de23d1 == 1 )
    {
        snd::play( "evt_lockpick_pin_dropped", self );
    }
    else if ( state == 2 )
    {
        snd::play( "evt_lockpick_pin_unlock_" + pin, self );
    }
    
    self.minigame.audio.var_d8de23d1 = state;
}

