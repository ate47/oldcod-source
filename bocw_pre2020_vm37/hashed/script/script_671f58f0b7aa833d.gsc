#using script_35ae72be7b4fec10;
#using script_3dc93ca9902a9cda;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;

#namespace vfx_ambientwar;

// Namespace vfx_ambientwar/vfx_ambientwar
// Params 0, eflags: 0x6
// Checksum 0x5ea63948, Offset: 0xd8
// Size: 0x4c
function private autoexec __init__system__()
{
    system::register( #"vfx_ambientwar", &_preload, &function_fa076c68, undefined, undefined );
}

// Namespace vfx_ambientwar/vfx_ambientwar
// Params 0, eflags: 0x4
// Checksum 0x2d8af927, Offset: 0x130
// Size: 0x34
function private _preload()
{
    function_ad272ef4();
    function_90ceecf8();
    function_7c9b0132();
}

// Namespace vfx_ambientwar/vfx_ambientwar
// Params 0, eflags: 0x4
// Checksum 0x80f724d1, Offset: 0x170
// Size: 0x4
function private function_fa076c68()
{
    
}

// Namespace vfx_ambientwar/vfx_ambientwar
// Params 0, eflags: 0x4
// Checksum 0x2db3cef8, Offset: 0x180
// Size: 0xba
function private function_ad272ef4()
{
    if ( !isdefined( level._fx ) )
    {
        level._fx = {};
    }
    
    if ( !isdefined( level._fx.ambientwar ) )
    {
        level._fx.ambientwar = {};
    }
    
    if ( !isdefined( level._fx.ambientwar.data ) )
    {
        level._fx.ambientwar.data = [];
    }
    
    if ( !isdefined( level._fx.ambientwar.input ) )
    {
        level._fx.ambientwar.input = {};
    }
}

// Namespace vfx_ambientwar/vfx_ambientwar
// Params 0, eflags: 0x4
// Checksum 0xa9918eea, Offset: 0x248
// Size: 0xac
function private function_7c9b0132()
{
    /#
        function_5ac4dc99( #"hash_1ccb34f428b1a279", 0 );
        function_cd140ee9( #"hash_1ccb34f428b1a279", &function_93945397 );
        function_5ac4dc99( #"hash_6d342deda30a228a", 100 );
        function_5ac4dc99( #"hash_79ddea850d94a804", 0.5 );
    #/
}

// Namespace vfx_ambientwar/vfx_ambientwar
// Params 0, eflags: 0x4
// Checksum 0xe59d6b21, Offset: 0x300
// Size: 0x24
function private function_90ceecf8()
{
    callback::on_spawned( &_on_player_spawned );
}

// Namespace vfx_ambientwar/vfx_ambientwar
// Params 1, eflags: 0x4
// Checksum 0xe1bc418, Offset: 0x330
// Size: 0x52
function private _on_player_spawned( *localclientnum )
{
    if ( !isdefined( level._fx ) )
    {
        level._fx = {};
    }
    
    if ( !isdefined( level._fx.player ) )
    {
        level._fx.player = self;
    }
}

/#

    // Namespace vfx_ambientwar/vfx_ambientwar
    // Params 1, eflags: 0x4
    // Checksum 0x4b58aaec, Offset: 0x390
    // Size: 0x1dc, Type: dev
    function private function_93945397( parms )
    {
        if ( parms.value == 1 )
        {
            setdvar( #"hash_1614a5a56768d221", 0 );
            level._fx.player val::set( #"hash_36c3761ec21ee4ac", "<dev string:x38>", 0 );
            level._fx.player val::set( #"hash_36c3761ec21ee4ac", "<dev string:x44>", 1 );
            level._fx.player val::set( #"hash_36c3761ec21ee4ac", "<dev string:x57>", 1 );
            level._fx.player val::set( #"hash_36c3761ec21ee4ac", "<dev string:x72>", 1 );
            adddebugcommand( "<dev string:x84>" );
            adddebugcommand( "<dev string:x95>" );
            function_8af93a7();
            return;
        }
        
        function_263df0ea();
        adddebugcommand( "<dev string:xa6>" );
        level._fx.player val::reset_all( #"hash_36c3761ec21ee4ac" );
    }

    // Namespace vfx_ambientwar/vfx_ambientwar
    // Params 0, eflags: 0x4
    // Checksum 0x241135c2, Offset: 0x578
    // Size: 0x21c, Type: dev
    function private function_8af93a7()
    {
        scripted_widgets::create( #"hash_2f8c229e8241a3a0", #"hash_355d1782cf92b25" );
        
        if ( scripted_widgets::exists( #"hash_2f8c229e8241a3a0" ) )
        {
            if ( !isdefined( level._fx.ambientwar ) )
            {
                level._fx.ambientwar = {};
            }
            
            if ( !isdefined( level._fx.ambientwar.data ) )
            {
                level._fx.ambientwar.data = [];
            }
            
            if ( !isdefined( level._fx.ambientwar.input ) )
            {
                level._fx.ambientwar.input = {};
            }
            
            level._fx.ambientwar.var_bebc9d74 = 0;
            level thread function_56e7d0e3();
            function_d885deda( 0 );
            level thread function_2e225b16();
            buttons = [];
            buttons[ buttons.size ] = "<dev string:xbc>";
            buttons[ buttons.size ] = "<dev string:xc7>";
            buttons[ buttons.size ] = "<dev string:xd4>";
            level._fx.player thread function_5402d440( level._fx.ambientwar.input, buttons );
            level._fx.player thread function_a11a465a( level._fx.ambientwar.input );
        }
    }

    // Namespace vfx_ambientwar/vfx_ambientwar
    // Params 0, eflags: 0x4
    // Checksum 0x8edc8619, Offset: 0x7a0
    // Size: 0x418, Type: dev
    function private function_56e7d0e3()
    {
        self notify( "<dev string:xe0>" );
        self endon( "<dev string:xe0>" );
        level endon( #"hash_d28501bd896672c" );
        
        while ( true )
        {
            if ( scripted_widgets::exists( #"hash_2f8c229e8241a3a0" ) )
            {
                for ( i = 0; i < level._fx.ambientwar.var_bebc9d74 ; i++ )
                {
                    scripted_widgets::function_7239e030( #"hash_2f8c229e8241a3a0", i );
                }
                
                count = 0;
                
                foreach ( entry in level._fx.ambientwar.data )
                {
                    scripted_widgets::set_count( #"hash_2f8c229e8241a3a0", count );
                    scripted_widgets::function_f2a9266( #"hash_2f8c229e8241a3a0", count, "<dev string:xf3>", entry.var_c6bf081d );
                    scripted_widgets::function_f2a9266( #"hash_2f8c229e8241a3a0", count, "<dev string:x104>", entry.is_active );
                    scripted_widgets::function_f2a9266( #"hash_2f8c229e8241a3a0", count, "<dev string:x110>", entry.group_id );
                    scripted_widgets::function_f2a9266( #"hash_2f8c229e8241a3a0", count, "<dev string:x11b>", entry.locations.size );
                    scripted_widgets::function_f2a9266( #"hash_2f8c229e8241a3a0", count, "<dev string:x12c>", string( float( entry.distance.min ), 1 ) );
                    scripted_widgets::function_f2a9266( #"hash_2f8c229e8241a3a0", count, "<dev string:x137>", string( float( entry.distance.max ), 1 ) );
                    scripted_widgets::function_f2a9266( #"hash_2f8c229e8241a3a0", count, "<dev string:x142>", string( float( entry.delay.min ), 1 ) );
                    scripted_widgets::function_f2a9266( #"hash_2f8c229e8241a3a0", count, "<dev string:x14e>", string( float( entry.delay.max ), 1 ) );
                    count++;
                }
                
                level._fx.ambientwar.var_bebc9d74 = count;
            }
            
            level waittill( #"hash_51a762912b76bdc1" );
        }
    }

    // Namespace vfx_ambientwar/vfx_ambientwar
    // Params 0, eflags: 0x4
    // Checksum 0xde1fdf53, Offset: 0xbc0
    // Size: 0x64, Type: dev
    function private function_263df0ea()
    {
        level notify( #"hash_d28501bd896672c" );
        
        if ( scripted_widgets::exists( #"hash_2f8c229e8241a3a0" ) )
        {
            scripted_widgets::remove( #"hash_2f8c229e8241a3a0" );
        }
    }

    // Namespace vfx_ambientwar/vfx_ambientwar
    // Params 2, eflags: 0x4
    // Checksum 0x68e549bf, Offset: 0xc30
    // Size: 0x15a, Type: dev
    function private function_5402d440( input, buttons )
    {
        level endon( #"hash_d28501bd896672c" );
        
        while ( true )
        {
            foreach ( button in buttons )
            {
                input.( button + "<dev string:x15a>" ) = input.( button );
                input.( button ) = self buttonpressed( button );
                
                if ( input.( button ) && !isdefined( input.( button + "<dev string:x163>" ) ) )
                {
                    input.( button + "<dev string:x163>" ) = gettime();
                }
                
                if ( !input.( button ) )
                {
                    input.( button + "<dev string:x163>" ) = undefined;
                }
            }
            
            waitframe( 1 );
        }
    }

    // Namespace vfx_ambientwar/vfx_ambientwar
    // Params 1, eflags: 0x4
    // Checksum 0x5ee0e77b, Offset: 0xd98
    // Size: 0x224, Type: dev
    function private function_a11a465a( input )
    {
        self notify( "<dev string:x16f>" );
        self endon( "<dev string:x16f>" );
        level endon( #"hash_d28501bd896672c" );
        
        while ( true )
        {
            selection = isdefined( level._fx.ambientwar.selection ) ? level._fx.ambientwar.selection : 0;
            current_time = gettime();
            var_5b49269e = getdvarint( #"hash_6d342deda30a228a", 100 );
            
            if ( input.dpad_up && !input.var_df3d5273 || isdefined( input.var_58d265ea ) && current_time - input.var_58d265ea > var_5b49269e )
            {
                selection--;
                function_d885deda( selection );
                input.var_58d265ea = current_time + var_5b49269e;
            }
            
            if ( input.dpad_down && !input.var_8a047c03 || isdefined( input.var_3c626fd ) && current_time - input.var_3c626fd > var_5b49269e )
            {
                selection++;
                function_d885deda( selection );
                input.var_3c626fd = current_time + var_5b49269e;
            }
            
            if ( input.button_y && !input.var_d356f692 || isdefined( input.var_6a06b2b8 ) && current_time - input.var_6a06b2b8 > var_5b49269e )
            {
                toggle( function_be6420e7( selection ) );
                input.var_6a06b2b8 = current_time + var_5b49269e;
            }
            
            waitframe( 1 );
        }
    }

    // Namespace vfx_ambientwar/vfx_ambientwar
    // Params 1, eflags: 0x4
    // Checksum 0x21299aef, Offset: 0xfc8
    // Size: 0x1da, Type: dev
    function private function_d885deda( selection )
    {
        level endon( #"hash_d28501bd896672c" );
        
        if ( isdefined( level._fx.ambientwar.selection ) )
        {
            level._fx.ambientwar.data[ function_be6420e7( level._fx.ambientwar.selection ) ].var_c6bf081d = 0;
            scripted_widgets::function_f2a9266( #"hash_2f8c229e8241a3a0", level._fx.ambientwar.selection, "<dev string:xf3>", 0 );
        }
        
        if ( selection < 0 )
        {
            selection = level._fx.ambientwar.data.size - 1;
        }
        
        if ( selection >= level._fx.ambientwar.data.size )
        {
            selection = 0;
        }
        
        snd::play( "<dev string:x183>", level._fx.player );
        level._fx.ambientwar.data[ function_be6420e7( selection ) ].var_c6bf081d = 1;
        scripted_widgets::function_f2a9266( #"hash_2f8c229e8241a3a0", selection, "<dev string:xf3>", 1 );
        level._fx.ambientwar.selection = selection;
    }

    // Namespace vfx_ambientwar/vfx_ambientwar
    // Params 0, eflags: 0x4
    // Checksum 0xa1682ad8, Offset: 0x11b0
    // Size: 0x2be, Type: dev
    function private function_2e225b16()
    {
        self notify( "<dev string:x1a1>" );
        self endon( "<dev string:x1a1>" );
        level endon( #"hash_d28501bd896672c" );
        
        while ( true )
        {
            if ( isdefined( level._fx.ambientwar.selection ) )
            {
                selection = level._fx.ambientwar.selection;
                group_id = function_be6420e7( selection );
                locations = level._fx.ambientwar.data[ group_id ].locations;
                distance = level._fx.ambientwar.data[ group_id ].distance;
                
                for ( i = 0; i < locations.size ; i++ )
                {
                    box( locations[ i ].origin, ( -5, -5, -5 ), ( 5, 5, 5 ), locations[ i ].angles, ( 0, 0, 0 ), 1, 0, 1 );
                    debugaxis( locations[ i ].origin, locations[ i ].angles, 16, 1, 0, 1 );
                    
                    if ( function_1913c46( locations[ i ] ) )
                    {
                        circle( locations[ i ].origin, locations[ i ].vfx_ambientwar_check_ai_radius, ( 1, 0.65, 0 ), 0, 1, 1 );
                    }
                    
                    if ( isdefined( level._fx.player.origin ) )
                    {
                        circle( level._fx.player.origin, distance.min, ( 0, 1, 0 ), 0, 1, 1 );
                        circle( level._fx.player.origin, distance.max, ( 1, 0, 0 ), 0, 1, 1 );
                    }
                }
            }
            
            waitframe( 1 );
        }
    }

#/

// Namespace vfx_ambientwar/vfx_ambientwar
// Params 1, eflags: 0x4
// Checksum 0x948a01d9, Offset: 0x1478
// Size: 0xb6
function private function_be6420e7( selection )
{
    count = 0;
    
    foreach ( entry in level._fx.ambientwar.data )
    {
        if ( count == selection )
        {
            return entry.group_id;
        }
        
        count++;
    }
    
    return undefined;
}

// Namespace vfx_ambientwar/vfx_ambientwar
// Params 3, eflags: 0x4
// Checksum 0xe28e17b9, Offset: 0x1538
// Size: 0xc4
function private function_20e12458( location, dist_min, dist_max )
{
    if ( !isdefined( level._fx.player.origin ) )
    {
        return 0;
    }
    
    dist_sqr = distance2dsquared( level._fx.player.origin, location.origin );
    return dist_sqr >= sqr( dist_min ) && dist_sqr <= sqr( dist_max ) ? 1 : 0;
}

// Namespace vfx_ambientwar/vfx_ambientwar
// Params 2, eflags: 0x4
// Checksum 0x7e6fe997, Offset: 0x1608
// Size: 0x82, Type: bool
function private function_4c6d8fd3( location, fov )
{
    if ( !isdefined( level._fx.player.origin ) )
    {
        return false;
    }
    
    return util::within_fov( level._fx.player.origin, level._fx.player.angles, location.origin, fov );
}

// Namespace vfx_ambientwar/vfx_ambientwar
// Params 1, eflags: 0x4
// Checksum 0xbc3eff04, Offset: 0x1698
// Size: 0xa4
function private function_1913c46( location )
{
    if ( !isdefined( level._fx.player ) )
    {
        return 0;
    }
    
    enemies = [];
    
    if ( isdefined( location.vfx_ambientwar_check_ai_radius ) && location.vfx_ambientwar_check_ai_radius > 0 )
    {
        enemies = level._fx.player getenemiesinradius( location.origin, location.vfx_ambientwar_check_ai_radius );
    }
    
    return enemies.size < 0 ? 0 : 1;
}

// Namespace vfx_ambientwar/vfx_ambientwar
// Params 1, eflags: 0x4
// Checksum 0x90218209, Offset: 0x1748
// Size: 0x506
function private function_613e65ee( group_id )
{
    level endon( "stop_ambientwar_" + group_id );
    delay = level._fx.ambientwar.data[ group_id ].delay;
    distance = level._fx.ambientwar.data[ group_id ].distance;
    locations = level._fx.ambientwar.data[ group_id ].locations;
    effects = level._fx.ambientwar.data[ group_id ].effects;
    
    if ( locations.size <= 0 )
    {
        return;
    }
    
    if ( !isdefined( effects ) || effects.size <= 0 )
    {
        for ( i = 0; i < locations.size ; i++ )
        {
            if ( !isdefined( locations[ i ].vfx_ambientwar_fx_override ) )
            {
                arrayremoveindex( effects, i, 1 );
            }
        }
        
        arrayremovevalue( locations, undefined );
    }
    
    while ( locations.size > 0 )
    {
        effect = undefined;
        rand_idx = randomintrange( 0, locations.size );
        rand_loc = locations[ rand_idx ];
        on_screen = function_4c6d8fd3( rand_loc, 0.5 );
        in_range = function_20e12458( rand_loc, distance.min, distance.max );
        ai_present = function_1913c46( rand_loc );
        
        if ( is_true( on_screen ) && is_true( in_range ) && is_false( ai_present ) )
        {
            if ( isdefined( rand_loc.vfx_ambientwar_fx_override ) && rand_loc.vfx_ambientwar_fx_override != "" )
            {
                effect = rand_loc.vfx_ambientwar_fx_override;
            }
            else
            {
                effect = effects[ randomintrange( 0, effects.size ) ];
            }
            
            if ( isdefined( effect ) )
            {
                playfx( effect, rand_loc.origin, anglestoforward( rand_loc.angles ), anglestoup( rand_loc.angles ) );
                
                /#
                    if ( getdvarint( #"hash_1ccb34f428b1a279", 0 ) && function_be6420e7( level._fx.ambientwar.selection ) == group_id )
                    {
                        display_time = getdvarfloat( #"hash_79ddea850d94a804", 0.5 ) / float( function_60d95f53() ) / 1000;
                        start = rand_loc.origin + ( 0, 0, 20 );
                        end = rand_loc.origin + ( 0, 0, 100 );
                        str = isdefined( rand_loc.vfx_ambientwar_fx_override ) ? "<dev string:x1b5>" + effect : effect;
                        line( start, end, ( 1, 0.65, 0 ), 1, 0, int( display_time ) );
                        print3d( end, str, ( 1, 1, 1 ), 1, 0.5, int( display_time ), 0 );
                    }
                #/
                
                wait randomfloatrange( delay.min, delay.max );
            }
        }
        
        waitframe( 1 );
    }
}

// Namespace vfx_ambientwar/vfx_ambientwar
// Params 6
// Checksum 0xb53ed2d4, Offset: 0x1c58
// Size: 0x1c0
function create( group_id, var_6f2c5280 = undefined, min_delay = 0.5, max_delay = 1.5, min_dist = 100, max_dist = 1000 )
{
    delay = {};
    delay.min = min_delay;
    delay.max = max_delay;
    distance = {};
    distance.min = min_dist;
    distance.max = max_dist;
    struct = {};
    struct.var_c6bf081d = 0;
    struct.is_active = 0;
    struct.group_id = group_id;
    struct.locations = getentarray( group_id, "vfx_ambientwar_group_id", 1 );
    struct.effects = var_6f2c5280;
    struct.distance = distance;
    struct.delay = delay;
    
    if ( isdefined( level._fx.ambientwar.data[ group_id ] ) )
    {
        return;
    }
    
    level._fx.ambientwar.data[ group_id ] = struct;
    
    /#
        level notify( #"hash_51a762912b76bdc1" );
    #/
}

// Namespace vfx_ambientwar/vfx_ambientwar
// Params 1
// Checksum 0xf40da230, Offset: 0x1e20
// Size: 0x90
function start( group_id )
{
    if ( isdefined( level._fx.ambientwar.data[ group_id ] ) )
    {
        level._fx.ambientwar.data[ group_id ].is_active = 1;
        level thread function_613e65ee( group_id );
        
        /#
            level notify( #"hash_51a762912b76bdc1" );
        #/
    }
}

// Namespace vfx_ambientwar/vfx_ambientwar
// Params 1
// Checksum 0x8076fb8d, Offset: 0x1eb8
// Size: 0x88
function stop( group_id )
{
    if ( isdefined( level._fx.ambientwar.data[ group_id ] ) )
    {
        level notify( "stop_ambientwar_" + group_id );
        level._fx.ambientwar.data[ group_id ].is_active = 0;
        
        /#
            level notify( #"hash_51a762912b76bdc1" );
        #/
    }
}

// Namespace vfx_ambientwar/vfx_ambientwar
// Params 1
// Checksum 0x675f5dc3, Offset: 0x1f48
// Size: 0xb0
function remove( group_id )
{
    if ( isdefined( level._fx.ambientwar.data[ group_id ] ) )
    {
        stop( group_id );
        level._fx.ambientwar.data[ group_id ] = undefined;
        arrayremovevalue( level._fx.ambientwar.data, undefined );
        
        /#
            level notify( #"hash_51a762912b76bdc1" );
        #/
    }
}

// Namespace vfx_ambientwar/vfx_ambientwar
// Params 1
// Checksum 0x85f9f6fa, Offset: 0x2000
// Size: 0xb0
function toggle( group_id )
{
    if ( isdefined( level._fx.ambientwar.data[ group_id ] ) )
    {
        if ( is_true( level._fx.ambientwar.data[ group_id ].is_active ) )
        {
            stop( group_id );
        }
        else
        {
            start( group_id );
        }
        
        /#
            level notify( #"hash_51a762912b76bdc1" );
        #/
    }
}

