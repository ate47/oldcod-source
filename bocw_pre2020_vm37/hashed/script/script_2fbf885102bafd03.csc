#using script_18910f59cc847b42;
#using script_245f38df21b701ca;
#using script_30c7fb449869910;
#using script_30efbc1e0156ebae;
#using script_3314b730521b9666;
#using script_38635d174016f682;
#using script_41540e991952b0c1;
#using script_42cbbdcd1e160063;
#using script_4adf64e112e9afec;
#using script_60a2f38d6d37fd6a;
#using script_64e5d3ad71ce8140;
#using script_67049b48b589d81;
#using script_6b71c9befed901f2;
#using script_71603a58e2da0698;
#using script_75c3996cce8959f7;
#using script_75e0a2c8a5c12652;
#using script_76abb7986de59601;
#using script_77163d5a569e2071;
#using script_771f5bff431d8d57;
#using script_7bf1bd99605135bf;
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

#namespace doa_banner;

// Namespace doa_banner/doa_banner
// Params 0
// Checksum 0xd8a787f3, Offset: 0x188
// Size: 0xea
function init()
{
    clientfield::register( "world", "banner_event", 1, 6, "int", &function_778aa85f, 0, 0 );
    level.doa.banner = doa_bannerelement::register_clientside();
    level.doa.var_5f94c071 = doa_textelement::register_clientside();
    level.doa.var_75e2ed0d = doa_textelement::register_clientside();
    level.doa.var_4f001f48 = doa_textelement::register_clientside();
    level.doa.var_51c724d6 = doa_textelement::register_clientside();
}

// Namespace doa_banner/doa_banner
// Params 1
// Checksum 0xc9f24a91, Offset: 0x280
// Size: 0x24
function function_32d5e898( localclientnum )
{
    function_56821d13( localclientnum );
}

// Namespace doa_banner/doa_banner
// Params 7
// Checksum 0xece5c4e1, Offset: 0x2b0
// Size: 0x11ec
function function_778aa85f( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( !isdefined( level.doa.banner ) )
    {
        return;
    }
    
    if ( fieldname != 0 )
    {
        return;
    }
    
    var_d6bac235 = undefined;
    var_8d552f67 = undefined;
    var_c4241d08 = undefined;
    var_e8f666ac = undefined;
    var_936d31f7 = undefined;
    
    switch ( bwastimejump )
    {
        case 0:
            function_56821d13( fieldname );
            break;
        case 63:
            function_56821d13( fieldname );
            break;
        case 6:
            var_936d31f7 = spawnstruct();
            var_936d31f7.text = #"doa/wild";
            var_936d31f7.timeout = 4;
            var_936d31f7.color = ( 0.3, 0.84, 0.2 );
            break;
        case 7:
            var_d6bac235 = spawnstruct();
            var_d6bac235.text = #"hash_3a07bfbf9fc8fe5e";
            var_d6bac235.y = 200;
            var_d6bac235.timeout = 3;
            var_d6bac235.color = ( 1, 0.84, 0 );
            break;
        case 5:
            var_d6bac235 = spawnstruct();
            var_d6bac235.text = #"hash_6a342a929b6bfca2";
            var_d6bac235.y = 200;
            var_d6bac235.payload = level.doa.roundnumber - 1;
            var_d6bac235.timeout = 9999;
            var_d6bac235.color = ( 1, 0.84, 0 );
            var_8d552f67 = spawnstruct();
            var_8d552f67.text = #"hash_2bca86061b6767e4";
            var_8d552f67.y = 280;
            var_8d552f67.timeout = 9999;
            var_8d552f67.color = ( 1, 0.7, 0 );
            var_8d552f67.delay = 2;
            var_8d552f67.scale = 0.6;
            break;
        case 4:
            var_d6bac235 = spawnstruct();
            var_d6bac235.text = #"hash_6a342a929b6bfca2";
            var_d6bac235.y = 200;
            var_d6bac235.payload = level.doa.roundnumber - 1;
            var_d6bac235.timeout = 9999;
            var_d6bac235.color = ( 1, 0.84, 0 );
            var_8d552f67 = spawnstruct();
            var_8d552f67.text = #"hash_f123d93fac4c288";
            var_8d552f67.y = 280;
            var_8d552f67.timeout = 25;
            var_8d552f67.color = ( 1, 0.7, 0 );
            var_8d552f67.delay = 2;
            var_8d552f67.scale = 0.6;
            var_c4241d08 = spawnstruct();
            var_c4241d08.text = #"doa/or";
            var_c4241d08.y = 330;
            var_c4241d08.timeout = 2;
            var_c4241d08.color = ( 1, 0.5, 0 );
            var_c4241d08.delay = 4;
            var_c4241d08.scale = 0.6;
            var_c4241d08.text2 = #"hash_2bca86061b6767e4";
            var_c4241d08.var_b6501bb5 = 9999;
            break;
        case 8:
            var_936d31f7 = spawnstruct();
            var_936d31f7.text = #"hash_53e517a90b3cd2e2";
            var_936d31f7.timeout = 6;
            var_936d31f7.color = ( 0.36, 0.36, 0.85 );
            var_c4241d08 = spawnstruct();
            var_c4241d08.text = function_5a3210ac();
            var_c4241d08.y = 300;
            var_c4241d08.timeout = 4;
            var_c4241d08.color = ( 0.5, 0.5, 0.89 );
            var_c4241d08.delay = 2;
            break;
        case 2:
        case 3:
            var_d6bac235 = spawnstruct();
            var_d6bac235.text = #"hash_6a342a929b6bfca2";
            var_d6bac235.y = 200;
            var_d6bac235.payload = bwastimejump == 3 ? level.doa.roundnumber - 1 : level.doa.roundnumber;
            var_d6bac235.timeout = 9999;
            var_d6bac235.color = ( 1, 0.84, 0 );
            var_8d552f67 = spawnstruct();
            var_8d552f67.text = bwastimejump == 3 ? #"hash_f123d93fac4c288" : #"hash_c3e858cfc3c3171";
            var_8d552f67.y = 280;
            var_8d552f67.timeout = 9999;
            var_8d552f67.color = ( 1, 0.7, 0 );
            var_8d552f67.delay = 2;
            var_8d552f67.scale = 0.6;
            break;
        case 1:
            var_936d31f7 = spawnstruct();
            var_936d31f7.text = #"hash_7841b2473599470";
            var_936d31f7.var_6dcbe6ee = 1.5;
            var_936d31f7.timeout = 15;
            var_d6bac235 = spawnstruct();
            var_d6bac235.text = #"hash_2294c09e27c1dd1a";
            var_d6bac235.y = 320;
            var_d6bac235.payload = level.doa.roundnumber;
            var_d6bac235.timeout = 15;
            var_d6bac235.color = ( 1, 0.2, 0.2 );
            break;
        case 19:
        case 20:
        case 18:
            var_936d31f7 = spawnstruct();
            var_936d31f7.text = #"hash_30cfa520b05f1c31";
            var_936d31f7.timeout = 6;
            var_936d31f7.color = ( 1, 0.84, 0 );
            var_d6bac235 = spawnstruct();
            var_d6bac235.text = function_4d2e3eaa( bwastimejump );
            var_d6bac235.y = 300;
            var_d6bac235.timeout = 6;
            var_d6bac235.color = ( 1, 0.64, 0 );
            var_d6bac235.delay = 1;
            break;
        case 13:
        case 14:
        case 15:
        case 16:
        case 17:
            var_936d31f7 = spawnstruct();
            var_936d31f7.text = #"hash_7baa5fa3bb1a720b";
            var_936d31f7.timeout = 6;
            var_936d31f7.color = ( 1, 0.84, 0 );
            var_d6bac235 = spawnstruct();
            var_d6bac235.text = function_4d2e3eaa( bwastimejump );
            var_d6bac235.y = 300;
            var_d6bac235.timeout = 6;
            var_d6bac235.color = ( 1, 0.64, 0 );
            var_d6bac235.delay = 1;
            break;
        case 26:
        case 27:
        case 28:
        case 29:
        case 30:
        case 32:
        case 33:
            var_d6bac235 = spawnstruct();
            var_d6bac235.text = #"hash_5cf341d25f5b6392";
            var_d6bac235.y = 200;
            var_d6bac235.timeout = 6;
            var_d6bac235.color = ( 1, 0, 0 );
            var_8d552f67 = spawnstruct();
            var_8d552f67.text = function_b6e2bc81( bwastimejump );
            var_8d552f67.y = 300;
            var_8d552f67.timeout = 6;
            var_8d552f67.color = ( 1, 0.2, 0 );
            var_8d552f67.delay = 1;
            var_8d552f67.scale = 0.8;
            break;
        case 31:
        case 34:
            var_d6bac235 = spawnstruct();
            var_d6bac235.text = #"hash_4efeacff23c592b7";
            var_d6bac235.y = 200;
            var_d6bac235.timeout = 6;
            var_d6bac235.color = ( 1, 0, 0 );
            var_8d552f67 = spawnstruct();
            var_8d552f67.text = function_b6e2bc81( bwastimejump );
            var_8d552f67.y = 300;
            var_8d552f67.timeout = 6;
            var_8d552f67.color = ( 1, 0.2, 0 );
            var_8d552f67.delay = 1;
            var_8d552f67.scale = 0.8;
            break;
        case 41:
            var_936d31f7 = spawnstruct();
            var_936d31f7.text = #"hash_3415698ef62cc127";
            var_936d31f7.timeout = 6;
            var_936d31f7.color = ( 0.36, 0.36, 0.85 );
            var_c4241d08 = spawnstruct();
            var_c4241d08.text = #"hash_220c6afbbdd6e391";
            var_c4241d08.y = 300;
            var_c4241d08.timeout = 4;
            var_c4241d08.color = ( 0.5, 0.5, 0.89 );
            var_c4241d08.delay = 2;
            var_c4241d08.scale = 0.6;
            break;
        case 40:
            var_936d31f7 = spawnstruct();
            var_936d31f7.text = #"doa/wild";
            var_936d31f7.timeout = 4;
            var_936d31f7.color = ( 0.3, 0.84, 0.2 );
            var_c4241d08 = spawnstruct();
            var_c4241d08.text = #"hash_241673ce039e1331";
            var_c4241d08.y = 300;
            var_c4241d08.timeout = 4;
            var_c4241d08.color = ( 0.3, 0.64, 0.2 );
            var_c4241d08.delay = 2;
            var_c4241d08.scale = 0.6;
            break;
        case 42:
            var_c4241d08 = spawnstruct();
            var_c4241d08.text = #"hash_49bc9775ce122be2";
            var_c4241d08.y = 300;
            var_c4241d08.timeout = 5;
            var_c4241d08.color = ( 0.5, 0.5, 0.89 );
            var_c4241d08.scale = 0.6;
            break;
        case 43:
            var_d6bac235 = spawnstruct();
            var_d6bac235.text = #"hash_155e552e57ff5998";
            var_d6bac235.y = 200;
            var_d6bac235.timeout = 5;
            var_d6bac235.color = ( 0.5, 0.5, 0.89 );
            var_d6bac235.scale = 0.6;
            break;
        case 9:
            var_d6bac235 = spawnstruct();
            var_d6bac235.text = #"hash_29f2d2688d79b468";
            var_d6bac235.y = 200;
            var_d6bac235.timeout = 5;
            var_d6bac235.color = ( 0.5, 0.5, 0.89 );
            var_d6bac235.scale = 0.6;
            break;
        case 10:
            var_8d552f67 = spawnstruct();
            var_8d552f67.text = #"hash_33ee5da9fc46b6a5";
            var_8d552f67.y = 220;
            var_8d552f67.timeout = 5;
            var_8d552f67.color = ( 0.5, 0.5, 0.89 );
            var_8d552f67.scale = 0.6;
            break;
        case 11:
            var_c4241d08 = spawnstruct();
            var_c4241d08.text = #"hash_5bffd8a0e4b9f938";
            var_c4241d08.y = 240;
            var_c4241d08.timeout = 5;
            var_c4241d08.color = ( 0.5, 0.5, 0.89 );
            var_c4241d08.scale = 0.6;
            break;
        case 12:
            var_e8f666ac = spawnstruct();
            var_e8f666ac.text = #"hash_4f7305231f2f2bb7";
            var_e8f666ac.y = 260;
            var_e8f666ac.timeout = 5;
            var_e8f666ac.color = ( 0.5, 0.5, 0.89 );
            var_e8f666ac.scale = 0.6;
            break;
        default:
            break;
    }
    
    if ( isdefined( var_936d31f7 ) )
    {
        level.doa.banner thread function_9a92c603( fieldname, var_936d31f7 );
    }
    
    if ( isdefined( var_d6bac235 ) )
    {
        level.doa.var_5f94c071 thread function_9a92c603( fieldname, var_d6bac235 );
    }
    
    if ( isdefined( var_8d552f67 ) )
    {
        level.doa.var_75e2ed0d thread function_9a92c603( fieldname, var_8d552f67 );
    }
    
    if ( isdefined( var_c4241d08 ) )
    {
        level.doa.var_4f001f48 thread function_9a92c603( fieldname, var_c4241d08 );
    }
    
    if ( isdefined( var_e8f666ac ) )
    {
        level.doa.var_51c724d6 thread function_9a92c603( fieldname, var_e8f666ac );
    }
}

// Namespace doa_banner/doa_banner
// Params 0
// Checksum 0xbcd0f09f, Offset: 0x14a8
// Size: 0x2e
function function_5a3210ac()
{
    return level.doa.dungeons[ level.doa.var_5d21548e ].locstring;
}

// Namespace doa_banner/doa_banner
// Params 1
// Checksum 0xd9eba528, Offset: 0x14e0
// Size: 0x11a
function function_4d2e3eaa( roomtype )
{
    switch ( roomtype )
    {
        case 13:
            return #"hash_4c5468285fb9d826";
        case 14:
            return #"hash_5e61aab055d1b3c1";
        case 15:
            return #"hash_ced2d169408f6d5";
        case 16:
            return #"hash_388c4f923d12c58";
        case 17:
            return #"hash_53308d4150e5d0ac";
        case 18:
            return #"hash_737ec4a9c7991bc5";
        case 19:
            return #"hash_48de9f961f66cd70";
        case 20:
            return #"hash_4b89013f738a43";
    }
}

// Namespace doa_banner/doa_banner
// Params 1
// Checksum 0xc42b1fd7, Offset: 0x1608
// Size: 0x13a
function function_b6e2bc81( roomtype )
{
    switch ( roomtype )
    {
        case 29:
            return #"hash_365152316e8cfc0";
        case 26:
            return #"hash_542d0557fc360dd2";
        case 27:
            return #"hash_3fbcd19e60d8cb42";
        case 28:
            return #"hash_16de0c0160ea3d28";
        case 30:
            return #"hash_170e061a597a50cd";
        case 31:
            return #"hash_19f4fc7186e4d11";
        case 32:
            return #"hash_2330795898a1425c";
        case 33:
            return #"hash_25bc2216bde1b571";
        case 34:
            return #"hash_370a31e0d0d75fdb";
    }
}

// Namespace doa_banner/doa_banner
// Params 1
// Checksum 0x6b05795d, Offset: 0x1750
// Size: 0x278
function function_56821d13( localclientnum )
{
    if ( level.doa.banner doa_bannerelement::is_open( localclientnum ) )
    {
        level.doa.banner doa_bannerelement::set_alpha( localclientnum, 0 );
        level.doa.banner doa_bannerelement::close( localclientnum );
    }
    
    if ( level.doa.var_5f94c071 doa_bannerelement::is_open( localclientnum ) )
    {
        level.doa.var_5f94c071 doa_bannerelement::set_alpha( localclientnum, 0 );
        level.doa.var_5f94c071 doa_bannerelement::close( localclientnum );
    }
    
    if ( level.doa.var_75e2ed0d doa_bannerelement::is_open( localclientnum ) )
    {
        level.doa.var_75e2ed0d doa_bannerelement::set_alpha( localclientnum, 0 );
        level.doa.var_75e2ed0d doa_bannerelement::close( localclientnum );
    }
    
    if ( level.doa.var_4f001f48 doa_bannerelement::is_open( localclientnum ) )
    {
        level.doa.var_4f001f48 doa_bannerelement::set_alpha( localclientnum, 0 );
        level.doa.var_4f001f48 doa_bannerelement::close( localclientnum );
    }
    
    if ( level.doa.var_51c724d6 doa_bannerelement::is_open( localclientnum ) )
    {
        level.doa.var_51c724d6 doa_bannerelement::set_alpha( localclientnum, 0 );
        level.doa.var_51c724d6 doa_bannerelement::close( localclientnum );
    }
    
    level notify( #"banner_close" );
}

// Namespace doa_banner/doa_banner
// Params 2
// Checksum 0xbd366805, Offset: 0x19d0
// Size: 0x4a4
function function_9a92c603( localclientnum, var_150143d0 )
{
    self notify( "469e45ad292df332" );
    self endon( "469e45ad292df332" );
    level endon( #"banner_close" );
    text = var_150143d0.text;
    text2 = var_150143d0.text2;
    assert( isdefined( text ) );
    x = isdefined( var_150143d0.x ) ? var_150143d0.x : 0;
    y = isdefined( var_150143d0.y ) ? var_150143d0.y : 200;
    var_42f603e1 = isdefined( var_150143d0.var_42f603e1 ) ? var_150143d0.var_42f603e1 : 0.4;
    var_a5866ebf = isdefined( var_150143d0.var_a5866ebf ) ? var_150143d0.var_a5866ebf : 1;
    timeout = isdefined( var_150143d0.timeout ) ? var_150143d0.timeout : 10;
    color = isdefined( var_150143d0.color ) ? var_150143d0.color : ( 1, 0.2, 0.2 );
    var_a4283692 = isdefined( var_150143d0.var_a4283692 ) ? var_150143d0.var_a4283692 : 0;
    var_4659a519 = isdefined( var_150143d0.var_4659a519 ) ? var_150143d0.var_4659a519 : 1;
    fadetime = isdefined( var_150143d0.fadetime ) ? var_150143d0.fadetime : 2;
    scale = isdefined( var_150143d0.scale ) ? var_150143d0.scale : 1;
    payload = var_150143d0.payload;
    var_6dcbe6ee = var_150143d0.var_6dcbe6ee;
    delay = var_150143d0.delay;
    var_b6501bb5 = var_150143d0.var_b6501bb5;
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    if ( !self doa_textelement::is_open( localclientnum ) )
    {
        self doa_textelement::open( localclientnum );
        
        if ( isdefined( payload ) )
        {
            self doa_textelement::function_9e089af4( localclientnum, payload );
        }
        
        self doa_textelement::set_text( localclientnum, text );
        self doa_textelement::function_f97e9049( localclientnum, x, y );
        self doa_textelement::set_alpha( localclientnum, 0 );
        self doa_textelement::set_color( localclientnum, color[ 0 ], color[ 1 ], color[ 2 ] );
        self doa_textelement::set_scale( localclientnum, scale );
        
        if ( isdefined( var_6dcbe6ee ) )
        {
            self thread function_c11d702b( localclientnum, var_6dcbe6ee, var_42f603e1, var_a5866ebf );
        }
        else
        {
            self function_3ce17e62( localclientnum, var_a4283692, var_4659a519, fadetime );
        }
    }
    
    wait timeout;
    self function_3ce17e62( localclientnum, var_4659a519, var_a4283692, fadetime );
    
    if ( isdefined( text2 ) )
    {
        self doa_textelement::set_text( localclientnum, text2 );
        self function_3ce17e62( localclientnum, var_a4283692, var_4659a519, fadetime );
        
        if ( isdefined( var_b6501bb5 ) )
        {
            wait var_b6501bb5;
        }
    }
    
    if ( self doa_bannerelement::is_open( localclientnum ) )
    {
        self doa_bannerelement::set_alpha( localclientnum, 0 );
        self doa_bannerelement::close( localclientnum );
    }
}

// Namespace doa_banner/doa_banner
// Params 4
// Checksum 0x986446c3, Offset: 0x1e80
// Size: 0xfe
function function_3ce17e62( localclientnum, var_ab7c878c, var_393b2936, durationseconds )
{
    var_8fc81e63 = gettime();
    n_time_end = gettime() + int( durationseconds * 1000 );
    n_timer = var_8fc81e63;
    
    while ( isdefined( self ) && [[ self ]]->is_open( localclientnum ) )
    {
        n_timer = gettime();
        
        if ( n_timer >= n_time_end )
        {
            [[ self ]]->set_alpha( localclientnum, var_393b2936 );
            return;
        }
        else
        {
            var_5db054c7 = mapfloat( var_8fc81e63, n_time_end, var_ab7c878c, var_393b2936, n_timer );
            [[ self ]]->set_alpha( localclientnum, var_5db054c7 );
        }
        
        waitframe( 1 );
    }
}

// Namespace doa_banner/doa_banner
// Params 4
// Checksum 0x6c31b5d9, Offset: 0x1f88
// Size: 0x16e
function function_c11d702b( localclientnum, durationseconds, lowalpha, highalpha )
{
    var_8fc81e63 = gettime();
    n_time_end = gettime() + int( durationseconds * 1000 );
    n_timer = var_8fc81e63;
    targetalpha = lowalpha;
    startalpha = highalpha;
    
    while ( isdefined( self ) && [[ self ]]->is_open( localclientnum ) )
    {
        n_timer = gettime();
        
        if ( n_timer >= n_time_end )
        {
            [[ self ]]->set_alpha( localclientnum, targetalpha );
            var_8fc81e63 = gettime();
            n_time_end = gettime() + int( durationseconds * 1000 );
            n_timer = var_8fc81e63;
            temp = startalpha;
            startalpha = targetalpha;
            targetalpha = temp;
        }
        else
        {
            var_5db054c7 = mapfloat( var_8fc81e63, n_time_end, startalpha, targetalpha, n_timer );
            [[ self ]]->set_alpha( localclientnum, var_5db054c7 );
        }
        
        waitframe( 1 );
    }
}

