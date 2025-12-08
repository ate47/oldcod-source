#using script_1cd690a97dfca36e;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_draw;
#using scripts\cp_common\snd_utility;

#namespace namespace_5ceacc03;

// Namespace namespace_5ceacc03/level_preinit
// Params 1, eflags: 0x40
// Checksum 0x16e21c87, Offset: 0x688
// Size: 0x8c
function event_handler[level_preinit] function_b489bb7b( *eventstruct )
{
    snd::function_d4ec748e( &function_f2a2832d );
    snd::function_ce78b33b( &function_32ab045 );
    snd::trigger_init( &_trigger );
    snd::function_5e69f468( &_objective );
}

// Namespace namespace_5ceacc03/event_cc819519
// Params 1, eflags: 0x40
// Checksum 0xd1c27196, Offset: 0x720
// Size: 0x44
function event_handler[event_cc819519] function_686b88aa( *eventstruct )
{
    snd::wait_init();
    snd::waitforplayers();
    level thread function_1591cb13();
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 1, eflags: 0x4
// Checksum 0x6eb5745d, Offset: 0x770
// Size: 0x24a
function private _objective( objective )
{
    switch ( objective )
    {
        case #"train":
            break;
        case #"hash_b4bf1467425eafa":
            break;
        case #"ghost_station":
            break;
        case #"ghost_station_exit":
            thread function_1d10f78a();
            break;
        case #"wall":
            break;
        case #"rooftop":
            break;
        case #"street":
            break;
        case #"bar":
            break;
        case #"hash_7c9606c7fc0bc2c6":
            break;
        case #"hash_7c9605c7fc0bc113":
            break;
        case #"alley_3":
            break;
        case #"meetup":
            break;
        case #"apt_street":
            break;
        case #"hash_5316a2a443ccd594":
            break;
        case #"hash_5316a5a443ccdaad":
            break;
        case #"hash_6af30f974bc8ee0d":
            break;
        case #"warehouse_intro":
            break;
        case #"warehouse":
            function_a4a301cb();
            break;
        case #"hash_48642c08eff0a94c":
            break;
        case #"hash_1596768e81a01481":
            break;
        case #"hash_787e1dfef8598bc8":
            break;
        case #"no_game":
            break;
        default:
            /#
                snd::function_81fac19d( snd::function_d78e3644(), "<dev string:x38>" + objective + "<dev string:x5b>" );
            #/
            
            break;
    }
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 2, eflags: 0x4
// Checksum 0x2ec50413, Offset: 0x9c8
// Size: 0x10a
function private function_32ab045( ent, name )
{
    switch ( name )
    {
        case #"adler":
            level.adler = ent;
            ent waittill( #"death" );
            level.adler = undefined;
            break;
        case #"park":
            level.park = ent;
            ent waittill( #"death" );
            level.park = undefined;
            break;
        default:
            /#
                snd::function_81fac19d( snd::function_d78e3644(), "<dev string:x60>" + snd::function_783b69( name, "<dev string:x5b>" ) );
            #/
            
            break;
    }
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 3, eflags: 0x4
// Checksum 0x8d59f06f, Offset: 0xae0
// Size: 0x1ea
function private _trigger( player, trigger, *var_ec80d14b )
{
    wait 1;
    trigger_name = snd::function_ea2f17d1( var_ec80d14b.script_ambientroom, "$default" );
    
    switch ( trigger_name )
    {
        case #"$default":
            break;
        case #"hash_49a0ef561b09b7f9":
            function_1fb9d5d6();
            break;
        case #"hash_6c4907a1cdd20f4e":
            level notify( #"hash_2712b72478766d1c" );
            break;
        case #"hash_3dd3f5f36d38c9c5":
            function_2794abbe();
            break;
        case #"hash_53d96923d8b6fe97":
            level notify( #"hash_2712b72478766d1c" );
            level notify( #"hash_159fac3d0e4dbdc" );
            break;
        case #"interior":
            level notify( #"snd_emitter_stop" );
        case #"warehouse_interior":
            if ( isalive( trigger ) )
            {
                snd::set_element( trigger, trigger_name );
            }
            
            break;
        default:
            /#
                snd::function_81fac19d( snd::function_d78e3644(), "<dev string:x85>" + trigger_name + "<dev string:x5b>" );
            #/
            
            break;
    }
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 2, eflags: 0x4
// Checksum 0x6d6a69c2, Offset: 0xcd8
// Size: 0x3f2
function private function_f2a2832d( *player, msg )
{
    switch ( msg )
    {
        case #"hash_75509e6e5815431c":
            thread function_d516219();
            break;
        case #"hash_3f35a4573ca691d":
            thread train_fade_up_from_black();
            break;
        case #"hash_56ddda8ab2517d7":
            thread function_a6b9fbbd();
            break;
        case #"hash_2b77f5a80ef76375":
            level notify( #"hash_2b77f5a80ef76375" );
            break;
        case #"hash_56ddea8ab25198a":
            level notify( #"hash_56ddea8ab25198a" );
            break;
        case #"hash_1fe344e4d4f0967c":
            level notify( #"hash_1fe344e4d4f0967c" );
            break;
        case #"hash_53ee3cc3820fa2a2":
            thread function_bd19eb7f();
            break;
        case #"hash_dd68c60c003c4d9":
            level notify( #"hash_dd68c60c003c4d9" );
            break;
        case #"hash_2b77f2a80ef75e5c":
            level notify( #"hash_2b77f2a80ef75e5c" );
            break;
        case #"hash_790fd3997d6d47b3":
            level notify( #"hash_790fd3997d6d47b3" );
            break;
        case #"hash_5a65194efa8dcb0f":
            thread function_1d10f78a();
            break;
        case #"hash_63b7485b7ad71c1":
            level notify( #"hash_22c61e589a1f98c0" );
            break;
        case #"hash_6ba35d4654d272bb":
            thread guard_room_train_occlusion();
            break;
        case #"duck_ghost_station":
            thread duck_ghost_station();
            break;
        case #"hash_6c4907a1cdd20f4e":
            function_5ea2c6e3( "cp_ger_stakeout_filter_aux_5", 1, 1 );
            break;
        case #"rooftop_start":
            function_ed62c9c2( "cp_ger_stakeout_filter_aux_5", 1 );
            break;
        case #"hash_dc63434f653d0f2":
            thread function_7c0ea595();
            break;
        case #"hash_208adbd58bcd8ca5":
            thread function_dceebb0a();
            break;
        case #"street":
            thread function_7d3ac608();
            break;
        case #"hash_7ed1851bd0d35b68":
            thread function_6bd221d6();
            break;
        case #"warehouse_intro":
            forceambientroom( "warehouse_interior" );
            function_5ea2c6e3( "cp_ger_stakeout_warehouse_intro" );
            thread function_a4a301cb();
            break;
        case #"warehouse":
            function_552fe77();
            break;
        default:
            break;
    }
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0x80f724d1, Offset: 0x10d8
// Size: 0x4
function function_73ed916e()
{
    
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 6
// Checksum 0x460307e5, Offset: 0x10e8
// Size: 0x54
function function_f62c29d2( alias, locs, time_min, time_max, var_628a89ce, var_b441b64b )
{
    thread function_53eb8f80( alias, locs, time_min, time_max, var_628a89ce, var_b441b64b );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 6
// Checksum 0x99e846ab, Offset: 0x1148
// Size: 0x108
function function_53eb8f80( alias, locs, time_min, time_max, var_628a89ce, var_b441b64b )
{
    level notify( #"hash_2712b72478766d1c" );
    level endon( #"hash_2712b72478766d1c" );
    
    if ( !isarray( locs ) )
    {
        locs = array( locs );
    }
    
    if ( isdefined( var_628a89ce ) && isdefined( var_b441b64b ) )
    {
        wait randomfloatrange( var_628a89ce, var_b441b64b );
    }
    
    while ( true )
    {
        snd::play( alias, locs[ randomint( locs.size ) ] );
        wait randomfloatrange( time_min, time_max );
    }
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 2
// Checksum 0x27bf7b9b, Offset: 0x1258
// Size: 0x2c
function function_5d1af70e( alias, loc )
{
    thread function_9f75b544( alias, loc );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 2
// Checksum 0x1d2e113d, Offset: 0x1290
// Size: 0x6c
function function_9f75b544( alias, loc )
{
    ent = snd::play( alias, loc );
    level waittill( #"hash_2712b72478766d1c" );
    snd::stop( ent, 0.25 );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 4
// Checksum 0x72512168, Offset: 0x1308
// Size: 0x44
function function_30054301( soundobject, player, org_start, org_end )
{
    soundobject thread function_2fc1b3a7( soundobject, player, org_start, org_end );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 4, eflags: 0x4
// Checksum 0xe94e8b9b, Offset: 0x1358
// Size: 0x104
function private function_2fc1b3a7( soundobject, player, org_start, org_end )
{
    soundobject notify( #"snd_line_detach" );
    soundobject endon( #"snd_line_detach" );
    players = snd::function_da785aa8();
    player = players[ 0 ];
    player endon( #"death" );
    
    while ( isplayer( player ) && snd::function_a6779cbd( soundobject ) )
    {
        org_player = player snd::getplayervieworigin();
        org = pointonsegmentnearesttopoint( org_start, org_end, org_player );
        soundobject.origin = org;
        waitframe( 1 );
    }
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 1
// Checksum 0x8bc05fac, Offset: 0x1468
// Size: 0x48
function function_ff8cbed3( soundobject )
{
    if ( !isdefined( soundobject ) || function_3132f113( soundobject ) )
    {
        return;
    }
    
    soundobject notify( #"snd_line_detach" );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0xb33075dd, Offset: 0x14b8
// Size: 0x64
function function_d516219()
{
    function_5ea2c6e3( "cp_ger_stakeout_fadein", 0, 1 );
    function_5ea2c6e3( "cp_ger_stakeout_intro_black", 0, 1 );
    waitframe( 1 );
    function_ed62c9c2( "cp_ger_stakeout_fadein", 1 );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0x96c921bf, Offset: 0x1528
// Size: 0x5c
function train_fade_up_from_black()
{
    function_ed62c9c2( "cp_ger_stakeout_intro_black", 2 );
    level thread function_c56d39dc();
    level thread function_7aad0c65( 1.25 );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0, eflags: 0x4
// Checksum 0x459d8b4b, Offset: 0x1590
// Size: 0x8c
function private function_c56d39dc()
{
    var_1feac42a = snd::play( [ 3, "amb_train_intro_passenger_foley_lp" ], ( -9469, 8605, -129 ) );
    level flag::wait_till( "flag_prep_teleport_train_player" );
    snd::stop( var_1feac42a );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 1, eflags: 0x4
// Checksum 0x9a597520, Offset: 0x1628
// Size: 0x25c
function private function_7aad0c65( initialwait )
{
    level endon( #"hash_1fe344e4d4f0967c" );
    players = snd::function_da785aa8();
    player = players[ 0 ];
    initialwait = snd::function_ea2f17d1( initialwait, 0 );
    var_a89400b9 = ( -9734, 8608, -82 );
    var_9a4e642e = ( -8958, 8608, -82 );
    var_11b585be = [ var_a89400b9, var_9a4e642e ];
    var_9634044d = [];
    var_9634044d[ #"vox_cp_stkt_02005_gmc1_pleasekeepallba_11" ] = "vox_cp_stkt_02005_gmc1_pleasekeepallba_11";
    var_9634044d[ #"vox_cp_stkt_02005_gmc1_drinkingalcohol_5d" ] = "vox_cp_stkt_02005_gmc1_drinkingalcohol_5d";
    var_9634044d[ #"vox_cp_stkt_02005_gmc1_haveyourpapersr_f9" ] = "vox_cp_stkt_02005_gmc1_haveyourpapersr_f9";
    wait initialwait;
    
    while ( true )
    {
        var_d5e2a244 = array::randomize( var_9634044d );
        var_d69bee61 = undefined;
        
        if ( isdefined( var_d69bee61 ) && isdefined( var_d5e2a244[ var_d69bee61 ] ) )
        {
            var_d5e2a244[ var_d69bee61 ] = undefined;
        }
        
        foreach ( var_83eb1f22 in var_d5e2a244 )
        {
            waittime = 0.05;
            var_d69bee61 = var_83eb1f22;
            snd = snd::play( var_83eb1f22 );
            snd::function_2fdc4fb( snd );
            wait randomfloatrange( 15, 30 );
        }
    }
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0x72f63e7a, Offset: 0x1890
// Size: 0x1a0
function function_a6b9fbbd()
{
    level.var_f875cead = snd::play( [ "stk_train_intro_between_cars_lp_1", 1.2 ], ( -9007, 8608, -180 ) );
    level.var_38ad6843 = 1;
    level waittill( #"hash_2b77f5a80ef76375" );
    snd::stop( level.var_f875cead, 0.5 );
    level.var_38ad6843 = 0;
    level waittill( #"hash_56ddea8ab25198a" );
    level.var_bf81dcc6 = snd::play( [ "stk_train_intro_between_cars_lp_2", 1.2 ], ( -9007, 8608, -180 ) );
    level.var_38ad6843 = 1;
    level waittill( #"hash_dd68c60c003c4d9" );
    snd::set_volume( level.var_bf81dcc6, 0.3, 0.5 );
    level waittill( #"hash_2b77f2a80ef75e5c" );
    snd::stop( level.var_bf81dcc6, 0.5 );
    level.var_38ad6843 = 0;
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0x3e8c329, Offset: 0x1a38
// Size: 0x54
function function_bd19eb7f()
{
    thread function_876b47e1( "emt_train_ext_whoosh_lp", 0.2, 3 );
    thread function_876b47e1( "emt_train_between_cars_screech_lp", 0.2, 3 );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 3
// Checksum 0x444fe912, Offset: 0x1a98
// Size: 0x170
function function_876b47e1( alias, time_min, time_max )
{
    level endon( #"hash_790fd3997d6d47b3" );
    
    while ( true )
    {
        players = snd::function_da785aa8();
        player = players[ 0 ];
        offset_x = randomintrange( 1000, 2000 ) * -1;
        offset_y = randomintrange( 0, 550 ) - 275 + 30;
        start_point = player.origin + ( offset_x, offset_y, 0 );
        end_point = start_point + ( 3000, 0, 0 );
        snd = snd::play( alias, start_point );
        snd::doppler( snd, player, 48, 0.94 );
        snd thread function_39b2a7f0( end_point );
        wait randomfloatrange( time_min, time_max );
    }
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 1
// Checksum 0xbe9d519d, Offset: 0x1c10
// Size: 0x4c
function function_39b2a7f0( end_point )
{
    speed = 5;
    self moveto( end_point, speed );
    wait speed;
    snd::stop( self );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0x893a8555, Offset: 0x1c68
// Size: 0x164
function guard_room_train_occlusion()
{
    self thread function_3c2a62a3();
    players = snd::function_da785aa8();
    player = players[ 0 ];
    player endon( #"death" );
    self.var_cbb87055 = 1;
    var_3598c02f = ( -5206, 11111, -177 );
    function_5ea2c6e3( "cp_ger_stakeout_guard_room_train_occl", 0, 0 );
    
    while ( self.var_cbb87055 == 1 )
    {
        players = snd::function_da785aa8();
        player = players[ 0 ];
        dist = distance( player.origin, var_3598c02f );
        scale = snd::scalerp( dist, 0, 1000, 1, 0 );
        function_672403ca( "cp_ger_stakeout_guard_room_train_occl", 0, scale );
        waitframe( 1 );
    }
    
    function_ed62c9c2( "cp_ger_stakeout_guard_room_train_occl", 5 );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0x4ca293c0, Offset: 0x1dd8
// Size: 0x26
function function_3c2a62a3()
{
    level waittill( #"ghost_station_done" );
    self.var_cbb87055 = 0;
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0x1a387863, Offset: 0x1e08
// Size: 0x214
function function_1fb9d5d6()
{
    var_83b0306c = ( 1189, 10490, 254 );
    var_73e92e1e = ( -2592, 8310, 619 );
    var_fed91287 = ( -1689, 15907, 596 );
    var_a1fc9acd = ( -2667, 16169, 252 );
    function_f62c29d2( "emt_euro_siren_dist", [ var_83b0306c, var_fed91287, var_a1fc9acd ], 12, 20, 8, 10 );
    function_f62c29d2( "amb_thunder_rumble", [ var_83b0306c, var_73e92e1e ], 38, 74, 6, 11 );
    function_f62c29d2( "amb_thunder_rumble", [ var_fed91287 ], 20, 74, 20, 74 );
    function_f62c29d2( "amb_traffic", [ var_83b0306c, var_fed91287, var_a1fc9acd ], 15, 20, 4, 6 );
    function_f62c29d2( "emt_dist_traffic", [ var_83b0306c, var_fed91287, var_a1fc9acd ], 25, 35, 10, 13 );
    function_f62c29d2( "emt_dist_dog_bark", [ var_83b0306c, var_73e92e1e ], 15, 25, 3, 5 );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0xe711649a, Offset: 0x2028
// Size: 0x10c
function function_7c0ea595()
{
    players = snd::function_da785aa8();
    player = players[ 0 ];
    var_860e8962 = snd::play( "amb_rooftop_door_amb_lp", ( -4162, 11504, 323 ) );
    function_30054301( var_860e8962, player, ( -4162, 11504, 323 ), ( -3565, 11802, 388 ) );
    snd::set_volume( var_860e8962, 0 );
    waitframe( 1 );
    snd::set_volume( var_860e8962, 1, 1.5 );
    wait 8;
    snd::stop( var_860e8962, 20 );
    wait 20;
    function_ff8cbed3( var_860e8962 );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0xdad67c08, Offset: 0x2140
// Size: 0x104
function function_dceebb0a()
{
    wait 1;
    players = snd::function_da785aa8();
    player = players[ 0 ];
    var_b874b639 = snd::play( [ 0, "amb_street_start_door_lp", 1.5 ], ( -3027, 10788, 60 ) );
    function_30054301( var_b874b639, player, ( -3027, 10788, 31 ), ( -2313, 10859, 60 ) );
    wait 8;
    snd::stop( var_b874b639, 20 );
    wait 20;
    function_ff8cbed3( var_b874b639 );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0x52ebe3b9, Offset: 0x2250
// Size: 0xbc
function function_7d3ac608()
{
    car1 = snd::play( "veh_street_searched_lp_01", ( -2493, 9458, 58 ) );
    car2 = snd::play( "veh_street_searched_lp_02", ( -1967, 11722, 75 ) );
    level waittill( #"hash_159fac3d0e4dbdc" );
    snd::stop( car1, 0.5 );
    snd::stop( car2, 0.5 );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0x7b688bfb, Offset: 0x2318
// Size: 0x244
function function_2794abbe()
{
    var_83b0306c = ( 1189, 10490, 254 );
    var_73e92e1e = ( -2592, 8310, 619 );
    var_fed91287 = ( -1689, 15907, 596 );
    var_a1fc9acd = ( -2667, 16169, 252 );
    function_f62c29d2( "emt_euro_siren_dist", [ var_83b0306c, var_fed91287, var_a1fc9acd ], 12, 20, 8, 10 );
    function_f62c29d2( "amb_thunder_rumble", [ var_83b0306c, var_73e92e1e ], 38, 74, 6, 11 );
    function_f62c29d2( "amb_thunder_rumble", [ var_fed91287 ], 20, 74, 20, 74 );
    function_f62c29d2( "amb_traffic", [ var_83b0306c, var_fed91287, var_a1fc9acd ], 15, 20, 4, 6 );
    function_f62c29d2( "emt_dist_traffic", [ var_83b0306c, var_fed91287, var_a1fc9acd ], 25, 35, 10, 13 );
    function_f62c29d2( "emt_dist_dog_bark", [ var_83b0306c, var_73e92e1e ], 15, 25, 3, 5 );
    function_5d1af70e( "amb_traffic_dist_occluded_lp", var_83b0306c );
    function_5d1af70e( "amb_traffic_multi_car", var_fed91287 );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0xfa8d6069, Offset: 0x2568
// Size: 0x74
function function_1591cb13()
{
    wait 1;
    music = snd::play( "mus_bar", ( -1559, 9838, 123 ) );
    level waittill( #"hash_36b53404652665ab" );
    snd::stop( music, 0 );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0x51dc4b16, Offset: 0x25e8
// Size: 0x27c
function function_6bd221d6()
{
    players = snd::function_da785aa8();
    player = players[ 0 ];
    
    if ( snd::function_81fac19d( !isplayer( player ), "alley_dynamic_emitters no player!!" ) )
    {
        /#
            if ( snd::function_d78e3644() )
            {
                debugbreak();
            }
        #/
    }
    else
    {
        snd::emitter( "emt_euro_siren_dist2", player, [ 35, 50 ], [ 1000, 4000 ] );
        snd::emitter( "emt_dist_dog_bark", player, [ 15, 25 ], [ 3000, 5000 ] );
        snd::emitter( "amb_thunder_rumble", player, [ 20, 74 ], [ 3000, 5000 ] );
        snd::emitter( "amb_thunder_rumble", player, [ 38, 74 ], [ 3000, 5000 ] );
        snd::emitter( "amb_alley_glass_break", player, [ 25, 40, 8, 15 ], [ 3000, 5000 ] );
    }
    
    snd::emitter( "amb_alley_traffic", ( -2568, 7930, 118 ), [ 12, 22 ] );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0x30d0a382, Offset: 0x2870
// Size: 0x1a4
function function_1d10f78a()
{
    var_ca1e0a0b = snd::play( "amb_scr_rain_on_manhole_closed", ( -5239, 11115, -78 ) );
    var_4b169aaf = snd::play( "env_scr_drips_manhole_close_lp_01", ( -5225, 11114, -40 ) );
    var_283c9ebc = snd::play( "amb_scr_heavy_on_plr_splat_lp", ( -5226, 11110, -93 ) );
    level waittill( #"hash_22c61e589a1f98c0" );
    snd::stop( var_ca1e0a0b, 2 );
    snd::stop( var_4b169aaf, 2 );
    snd::stop( var_283c9ebc, 2 );
    snd::play( "amb_scr_manhole_open_2d_wide", ( -5229, 11106, 128 ) );
    var_f6084355 = snd::play( "amb_scr_rain_on_manhole_open", ( -5239, 11115, -78 ) );
    wait 4;
    snd::play( [ 0, "amb_stk_subway_manhole_exterior_lp", 2 ], ( -5230, 11113, -27 ) );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0xedbd9790, Offset: 0x2a20
// Size: 0x1c
function function_552fe77()
{
    function_ed62c9c2( "cp_ger_stakeout_warehouse_intro" );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0xfc9fc751, Offset: 0x2a48
// Size: 0x1064
function function_a4a301cb()
{
    snd::emitter( "amb_hanging_chains_rattle", ( 11938, -13705, 177 ), [ 4, 10 ] );
    snd::emitter( "amb_hanging_chains_rattle", ( 12215, -13500, 167 ), [ 4, 10 ] );
    snd::emitter( "amb_hanging_chains_rattle", ( 11201, -13832, 176 ), [ 4, 10 ] );
    snd::emitter( "amb_hanging_chains_rattle", ( 9801, -12999, 114 ), [ 4, 10 ] );
    snd::emitter( "amb_hanging_chains_rattle", ( 9563, -13021, 185 ), [ 4, 10 ] );
    snd::emitter( "amb_hanging_chains_rattle", ( 10085, -13556, 187 ), [ 4, 10 ] );
    snd::emitter( "amb_hanging_chains_rattle", ( 9555, -13828, 181 ), [ 4, 10 ] );
    snd::emitter( "amb_hanging_chains_rattle", ( 9548, -13391, 188 ), [ 4, 10 ] );
    snd::emitter( "amb_metal_stress_small", ( 11824, -13379, 80 ), [ 3, 7 ] );
    snd::emitter( "amb_metal_stress_small", ( 11716, -13530, 100 ), [ 4, 8 ] );
    snd::emitter( "amb_metal_stress_small", ( 11389, -13856, 95 ), [ 3, 7 ] );
    snd::emitter( "amb_metal_stress_small", ( 11323, -13663, 100 ), [ 3, 7 ] );
    snd::emitter( "amb_metal_stress_small", ( 11085, -13486, 104 ), [ 4, 7 ] );
    snd::emitter( "amb_metal_stress_small", ( 11285, -13293, 100 ), [ 3, 7 ] );
    snd::emitter( "amb_metal_stress_small", ( 11511, -13032, 100 ), [ 3, 7 ] );
    snd::emitter( "amb_metal_stress_small", ( 10323, -12970, 100 ), [ 4, 8 ] );
    snd::emitter( "amb_metal_stress_small", ( 10287, -13221, 100 ), [ 3, 7 ] );
    snd::emitter( "amb_metal_stress_small", ( 10942, -13220, 100 ), [ 3, 7 ] );
    snd::emitter( "amb_metal_stress_small", ( 10750, -13329, 100 ), [ 4, 7 ] );
    snd::emitter( "amb_metal_stress_small", ( 10751, -13626, 100 ), [ 3, 7 ] );
    snd::emitter( "amb_metal_stress_small", ( 10323, -13870, 100 ), [ 3, 7 ] );
    snd::emitter( "amb_metal_stress_small", ( 10292, -13661, 100 ), [ 3, 8 ] );
    snd::emitter( "amb_metal_stress_small", ( 9874, -13167, 100 ), [ 3, 7 ] );
    snd::emitter( "amb_metal_stress_small", ( 9651, -13613, 100 ), [ 4, 9 ] );
    snd::emitter( "amb_metal_stress_small", ( 9485, -13133, 100 ), [ 3, 7 ] );
    snd::emitter( "amb_metal_stress_small", ( 9314, -13440, 100 ), [ 3, 7 ] );
    snd::emitter( "amb_metal_stress_small", ( 9265, -13603, 100 ), [ 3, 7 ] );
    snd::emitter( "amb_metal_stress_small", ( 9536, -13772, 100 ), [ 4, 10 ] );
    snd::emitter( "amb_metal_stress_med_small", ( 10929, -13436, 111 ), [ 3, 7 ] );
    snd::emitter( "amb_metal_stress_med_small", ( 10703, -13842, 111 ), [ 3, 7 ] );
    snd::emitter( "amb_metal_stress_med_small", ( 10146, -13046, 111 ), [ 3, 7 ] );
    snd::emitter( "amb_metal_stress_med_small", ( 9805, -13876, 170 ), [ 3, 7 ] );
    snd::emitter( "amb_metal_stress_med_small", ( 9308, -13144, 142 ), [ 3, 7 ] );
    snd::emitter( "amb_metal_stress_med", ( 11001, -13880, 101 ), [ 4, 8 ] );
    snd::emitter( "amb_metal_stress_med", ( 11308, -12965, 101 ), [ 4, 8 ] );
    snd::emitter( "amb_metal_stress_med", ( 10995, -13130, 114 ), [ 4, 8 ] );
    snd::emitter( "amb_metal_stress_med", ( 9942, -13496, 100 ), [ 4, 8 ] );
    snd::emitter( "amb_metal_stress_med", ( 9658, -13359, 109 ), [ 4, 8 ] );
    snd::emitter( "amb_metal_stress_med", ( 9462, -13258, 105 ), [ 4, 8 ] );
    snd::emitter( "amb_metal_stress_large", ( 11652, -13249, 140 ), [ 7, 15 ] );
    snd::emitter( "amb_metal_stress_large", ( 11407, -13258, 140 ), [ 7, 15 ] );
    snd::emitter( "amb_metal_stress_large", ( 11589, -13569, 140 ), [ 7, 15 ] );
    snd::emitter( "amb_metal_stress_large", ( 11343, -13573, 140 ), [ 7, 15 ] );
    snd::emitter( "amb_metal_stress_large", ( 11312, -13867, 140 ), [ 7, 15 ] );
    snd::emitter( "amb_metal_stress_large", ( 10218, -13890, 140 ), [ 7, 15 ] );
    snd::emitter( "amb_metal_stress_large", ( 10524, -13890, 140 ), [ 7, 15 ] );
    snd::emitter( "amb_metal_stress_large", ( 10492, -13617, 140 ), [ 7, 15 ] );
    snd::emitter( "amb_metal_stress_large", ( 10256, -13605, 140 ), [ 7, 15 ] );
    snd::emitter( "amb_metal_stress_large", ( 10246, -13258, 140 ), [ 7, 15 ] );
    snd::emitter( "amb_metal_stress_large", ( 10524, -13253, 140 ), [ 7, 15 ] );
    snd::emitter( "amb_metal_stress_large", ( 10498, -12964, 140 ), [ 7, 15 ] );
    snd::emitter( "amb_metal_stress_large", ( 10248, -12962, 140 ), [ 7, 15 ] );
    snd::emitter( "amb_metal_stress_large", ( 10867, -13247, 140 ), [ 7, 15 ] );
    snd::emitter( "amb_metal_stress_large", ( 9288, -13591, 140 ), [ 7, 15 ] );
    snd::emitter( "amb_metal_stress_large", ( 9583, -13380, 119 ), [ 7, 15 ] );
    snd::emitter( "amb_metal_stress_low", ( 11436, -13581, 137 ), [ 7, 15 ] );
    snd::emitter( "amb_metal_stress_low", ( 10918, -13301, 137 ), [ 7, 15 ] );
    snd::emitter( "amb_metal_stress_low", ( 10422, -12966, 137 ), [ 7, 15 ] );
    snd::emitter( "amb_metal_stress_low", ( 10370, -13629, 137 ), [ 7, 15 ] );
    snd::emitter( "amb_metal_stress_low", ( 9311, -13579, 137 ), [ 7, 15 ] );
    snd::emitter( "amb_fence_chainlink_rattle", ( 9758, -13783, 109 ), [ 7, 15 ] );
    snd::emitter( "amb_fence_chainlink_rattle", ( 9648, -13432, 115 ), [ 7, 15 ] );
    snd::emitter( "amb_fence_chainlink_rattle", ( 9410, -13183, 115 ), [ 7, 15 ] );
    snd::play( "env_refridgerator_lp", ( 9967, -13962, 102 ) );
    snd::play( "env_vending_machine_lp", ( 9037, -13662, 95 ) );
    snd::play( "amb_toilet_loop", ( 9035, -13861, 71 ) );
    snd::play( "amb_sink_drip", ( 9019, -13784, 83 ) );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0x1ca57718, Offset: 0x3ab8
// Size: 0x100
function duck_ghost_station()
{
    players = snd::function_da785aa8();
    player = players[ 0 ];
    var_16f8cca9 = player getlocalclientnumber();
    var_2534b9f9 = getentarray( var_16f8cca9, "duck_ghost_station", "targetname" );
    
    foreach ( var_9a11ae59 in var_2534b9f9 )
    {
        var_9a11ae59 thread function_5def1caf();
    }
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0xe7e29531, Offset: 0x3bc0
// Size: 0x114
function function_5def1caf()
{
    players = snd::function_da785aa8();
    player = players[ 0 ];
    player endon( #"death" );
    var_eee381c9 = 0;
    
    while ( true )
    {
        players = snd::function_da785aa8();
        player = players[ 0 ];
        
        if ( isdefined( self ) && player istouching( self ) )
        {
            if ( var_eee381c9 == 0 )
            {
                function_5ea2c6e3( "cp_ger_stakeout_duck_ghost_station", 1, 1 );
                var_eee381c9 = 1;
            }
        }
        else if ( var_eee381c9 == 1 )
        {
            function_ed62c9c2( "cp_ger_stakeout_duck_ghost_station", 0.5 );
            var_eee381c9 = 0;
        }
        
        waitframe( 1 );
    }
}

