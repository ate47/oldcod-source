#using script_164a456ce05c3483;
#using script_16910aff9d97c520;
#using script_17dcb1172e441bf6;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_36fc02e86719d0f5;
#using script_413ab8fe25a61c50;
#using script_4780230832eb22a9;
#using script_47851dbeea22fe66;
#using script_5133d88c555e460;
#using script_5549681e1669c11a;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_634ae70c663d1cc9;
#using script_68cdf0ca5df5e;
#using script_6b6510e124bad778;
#using script_717759a5d2a40e63;
#using script_774302f762d76254;
#using script_f38dc50f0e82277;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\serverfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace wz_doa;

// Namespace wz_doa/level_init
// Params 1, eflags: 0x40
// Checksum 0x7476ca57, Offset: 0x6a0
// Size: 0x1d8
function event_handler[level_init] main( *eventstruct )
{
    assert( isdefined( level.var_f18a6bd6 ), "<dev string:x38>" );
    load::main();
    level.var_3146aa25 = 1;
    level.var_5495fbf1 = 0;
    level.friendlyfire = 0;
    level.trackweaponstats = 0;
    level.var_6e2d52c5 = 1;
    level.var_20ad5db3 = sessionmodeiszombiesgame();
    level.var_4f69a0e8 = sessionmodeiswarzonegame();
    setclearanceceiling( 120 );
    setsaveddvar( #"hash_61cbea77be1b7b36", 1 );
    setsaveddvar( #"hash_53fc4669dcc6b181", 0 );
    setsaveddvar( #"hash_1677d88b90b7fcf8", 0 );
    setsaveddvar( #"ik_enable_ai_terrain", 0 );
    setsaveddvar( #"hkai_maxpathlengthchecksenabled", 1 );
    level flag::wait_till( "doa_game_initialized" );
    function_725dd341();
    level waittill( #"hash_671684f03a58b3a3" );
    level.var_8e3a3faf = 0;
}

// Namespace wz_doa/wz_doa
// Params 0
// Checksum 0x4d8866c, Offset: 0x880
// Size: 0x260
function function_725dd341()
{
    var_26b567ef = namespace_8c04284b::function_85c7d70e( "island" );
    [[ var_26b567ef ]]->function_b6954aba( &function_863ffeba );
    [[ var_26b567ef ]]->function_774497ee( &function_ffeaed15 );
    var_a0600289 = namespace_8c04284b::function_85c7d70e( "jungle" );
    [[ var_a0600289 ]]->function_b6954aba( &function_529acb04 );
    [[ var_a0600289 ]]->function_774497ee( &function_f1ec9045 );
    var_441676e4 = namespace_8c04284b::function_85c7d70e( "graveyard" );
    [[ var_441676e4 ]]->function_b6954aba( &function_d723726a );
    var_4caed40c = namespace_8c04284b::function_85c7d70e( "temple" );
    [[ var_4caed40c ]]->function_b6954aba( &function_f7295a2d );
    [[ var_4caed40c ]]->function_774497ee( &function_6800d147 );
    var_a2f5dd8b = namespace_8c04284b::function_85c7d70e( "icecave" );
    [[ var_a2f5dd8b ]]->function_b6954aba( &function_4eaa5cb4 );
    [[ var_a2f5dd8b ]]->function_774497ee( &function_ef053c43 );
    bloodlake = namespace_8c04284b::function_85c7d70e( "bloodlake" );
    [[ bloodlake ]]->function_b6954aba( &function_db874c99 );
    frontyard = namespace_8c04284b::function_85c7d70e( "frontyard" );
    [[ frontyard ]]->function_b6954aba( &function_a80babc3 );
    [[ frontyard ]]->function_774497ee( &function_f66db708 );
}

// Namespace wz_doa/wz_doa
// Params 0
// Checksum 0x6e9da112, Offset: 0xae8
// Size: 0x338
function function_a80babc3()
{
    var_36a503f5 = struct::get_array( "frontyard_mowers" );
    
    foreach ( var_30f23074 in var_36a503f5 )
    {
        assert( !isdefined( var_30f23074.var_92595434 ), "<dev string:x62>" );
        
        if ( isdefined( var_30f23074.var_92595434 ) )
        {
            continue;
        }
        
        args = strtok( var_30f23074.script_noteworthy, ";" );
        modelname = args[ 0 ];
        scale = float( args[ 1 ] );
        speed = 4;
        
        if ( args.size > 2 )
        {
            speed = float( args[ 2 ] );
        }
        
        var_30f23074.var_92595434 = namespace_ec06fe4a::spawnmodel( var_30f23074.origin, modelname, var_30f23074.angles, "frontyard_lawnMower" );
        
        if ( isdefined( var_30f23074.var_92595434 ) )
        {
            trigger = namespace_ec06fe4a::spawntrigger( "trigger_box", ( 0, 0, 0 ), 1 | 2 | 4 | 4096 | 512, 82, 50, 60 );
            
            if ( !isdefined( trigger ) )
            {
                var_30f23074.var_92595434 delete();
                continue;
            }
            
            trigger.var_f83032a3 = "frontyard_lawnMowerTrigger";
            trigger.angles = var_30f23074.angles;
            trigger.origin = var_30f23074.origin;
            trigger.owner = var_30f23074.var_92595434;
            var_30f23074.trigger = trigger;
            var_30f23074.var_92595434.target = var_30f23074.target;
            var_30f23074.var_92595434.speed = speed;
            var_30f23074.var_92595434.trigger = trigger;
            var_30f23074.type = #"hash_1af42a1c565c45de";
            trigger thread namespace_ec06fe4a::function_73d79e7d( var_30f23074.var_92595434 );
            trigger thread function_577f978a();
            var_30f23074.var_92595434 setscale( scale );
            var_30f23074.var_92595434 thread function_2d612a87();
        }
    }
}

// Namespace wz_doa/wz_doa
// Params 0
// Checksum 0x67084eb4, Offset: 0xe28
// Size: 0x2a0
function function_577f978a()
{
    self endon( #"death" );
    
    while ( true )
    {
        result = self waittill( #"trigger" );
        guy = result.activator;
        
        if ( !isdefined( guy ) )
        {
            continue;
        }
        
        if ( is_true( guy.boss ) )
        {
            continue;
        }
        
        if ( is_true( guy.launched ) )
        {
            continue;
        }
        
        if ( is_true( guy.laststand ) )
        {
            continue;
        }
        
        if ( !isalive( guy ) )
        {
            continue;
        }
        
        if ( !isdefined( guy.var_a138f7e0 ) )
        {
            guy.var_a138f7e0 = 0;
        }
        
        time = gettime();
        
        if ( guy.var_a138f7e0 > gettime() )
        {
            continue;
        }
        
        guy.var_a138f7e0 = time + 250;
        
        if ( isplayer( guy ) )
        {
            guy dodamage( guy.health + 100, guy.origin, self.owner );
            guy playrumbleonentity( "damage_light" );
            continue;
        }
        
        if ( !is_true( guy.var_e66cd6fb ) && randomint( 100 ) < 20 )
        {
            guy.launched = 1;
            guy thread namespace_ec06fe4a::function_5678f0d( ( 0, 0, 220 ), 180, 0.3 );
            guy thread namespace_ec06fe4a::function_570729f0( 0.2, self.owner );
            guy namespace_e32bb68::function_3a59ec34( "zmb_ragdoll_launched" );
            continue;
        }
        
        guy thread namespace_ec06fe4a::function_570729f0( 0.1 );
        guy thread namespace_ed80aead::function_586ef822();
    }
}

// Namespace wz_doa/wz_doa
// Params 0
// Checksum 0xfae69733, Offset: 0x10d0
// Size: 0x188
function function_2d612a87()
{
    self endon( #"death" );
    target = struct::get( self.target );
    
    while ( true )
    {
        for ( var_afd55d27 = randomint( 6 ); var_afd55d27 ; var_afd55d27-- )
        {
            self.trigger triggerenable( 1 );
            self moveto( target.origin, self.speed, 0.5, 0.5 );
            self waittill( #"movedone" );
            self.trigger triggerenable( 0 );
            wait 1;
            self rotateto( self.angles + ( 0, 180, 0 ), 4 );
            self waittill( #"rotatedone" );
            target = struct::get( target.target );
        }
        
        wait randomintrange( 10, 20 );
    }
}

// Namespace wz_doa/wz_doa
// Params 0
// Checksum 0xa1f73ab5, Offset: 0x1260
// Size: 0xf2
function function_f66db708()
{
    var_36a503f5 = struct::get_array( "frontyard_mowers" );
    
    foreach ( var_30f23074 in var_36a503f5 )
    {
        if ( isdefined( var_30f23074.trigger ) )
        {
            var_30f23074.trigger delete();
            var_30f23074.trigger = undefined;
        }
        
        if ( isdefined( var_30f23074.var_92595434 ) )
        {
            var_30f23074.var_92595434 delete();
            var_30f23074.var_92595434 = undefined;
        }
    }
}

// Namespace wz_doa/wz_doa
// Params 0
// Checksum 0x90ec4b95, Offset: 0x1360
// Size: 0x178
function function_db874c99()
{
    var_b282ad2f = struct::get_array( "bloodlake_loot_spot", "targetname" );
    
    foreach ( item in var_b282ad2f )
    {
        item = namespace_dfc652ee::itemspawn( namespace_dfc652ee::function_6265bde4( item.script_noteworthy ), item.origin, item.angles, undefined, 1 );
        
        if ( isdefined( item ) )
        {
            item notify( #"stopidle" );
            item notify( #"hash_2a866f50cc161ca8" );
        }
    }
    
    var_94f3b914 = doa_enemy::function_251ee3bd( "blood_riser" );
    [[ var_94f3b914 ]]->function_7edd7727( 100 );
    level waittill( #"hash_de33bd076cde122" );
    [[ var_94f3b914 ]]->function_7edd7727( 0 );
}

// Namespace wz_doa/wz_doa
// Params 0
// Checksum 0x10b5f055, Offset: 0x14e0
// Size: 0xe6
function function_ef053c43()
{
    assert( isdefined( level.doa.var_4e7fa15 ) );
    setsaveddvar( #"hash_70e9b7babe37bd", level.doa.var_4e7fa15.var_68196321 );
    setsaveddvar( #"hash_49d79caf54cdbf0e", level.doa.var_4e7fa15.var_64e8274c );
    setsaveddvar( #"hash_334540b72330f0d0", level.doa.var_4e7fa15.var_751c4256 );
    level.doa.var_4e7fa15 = undefined;
}

// Namespace wz_doa/wz_doa
// Params 0
// Checksum 0xc0254d98, Offset: 0x15d0
// Size: 0x240
function function_4eaa5cb4()
{
    level endon( #"game_over", #"arena_switching", #"teleporter_taken" );
    self notify( "6b71d3c86898f7bd" );
    self endon( "6b71d3c86898f7bd" );
    var_736dd93a = getdvar( #"hash_70e9b7babe37bd" );
    var_b2f4c996 = getdvar( #"hash_49d79caf54cdbf0e" );
    var_2e3fc95e = getdvar( #"hash_334540b72330f0d0" );
    level.doa.var_4e7fa15 = { #var_68196321:var_736dd93a, #var_64e8274c:var_b2f4c996, #var_751c4256:var_2e3fc95e };
    
    while ( true )
    {
        setsaveddvar( #"hash_70e9b7babe37bd", 0.8 );
        setsaveddvar( #"hash_49d79caf54cdbf0e", 20 );
        setsaveddvar( #"hash_334540b72330f0d0", 60 );
        result = level waittill( #"hash_7270a59e1f502d96" );
        setsaveddvar( #"hash_70e9b7babe37bd", var_736dd93a );
        setsaveddvar( #"hash_49d79caf54cdbf0e", var_b2f4c996 );
        setsaveddvar( #"hash_334540b72330f0d0", var_2e3fc95e );
        level waittill( #"hash_7dd47c99b7707b1c" );
    }
}

// Namespace wz_doa/wz_doa
// Params 0
// Checksum 0xee2dcd94, Offset: 0x1818
// Size: 0x24
function function_d723726a()
{
    [[ level.doa.var_39e3fa99 ]]->function_6d5262dc( 40 );
}

// Namespace wz_doa/wz_doa
// Params 0
// Checksum 0x693fada4, Offset: 0x1848
// Size: 0xe
function function_6800d147()
{
    level.var_9fa19717 = undefined;
}

// Namespace wz_doa/wz_doa
// Params 0
// Checksum 0xd45f8f81, Offset: 0x1860
// Size: 0x49e
function function_f7295a2d()
{
    self notify( "6007882c5cbbddfd" );
    self endon( "6007882c5cbbddfd" );
    var_41e7a0cc = 1;
    level.var_9fa19717 = 1;
    level endon( #"game_over" );
    [[ level.doa.var_39e3fa99 ]]->function_6d5262dc( 28 );
    [[ level.doa.var_39e3fa99 ]]->function_68400720( 0 );
    
    if ( level flag::get( "doa_rof_visited" ) )
    {
        var_41e7a0cc = 0;
        [[ level.doa.var_39e3fa99 ]]->setwild( undefined );
        [[ level.doa.var_39e3fa99 ]]->function_68400720( 1 );
    }
    
    level.doa.var_6b57e2f = &function_9e356c78;
    level thread function_9dfe2f0b();
    result = level waittill( #"waiting_on_player_exit_teleporteronly", #"waiting_on_player_exit_decidechoice" );
    
    if ( result._notify == "waiting_on_player_exit_DecideChoice" )
    {
        wild = doa_wild::function_d5e7454f( "jungle_1" );
        starts = [[ wild ]]->function_5dfb6d67( 2 );
        level namespace_ec06fe4a::function_87612422( starts[ 0 ].origin, starts[ 0 ].angles, 1, 999999, [[ wild ]]->function_39f259cc() );
    }
    
    var_2cea1c1 = [[ level.doa.var_39e3fa99 ]]->function_242886d5( "killbox" );
    
    foreach ( killbox in var_2cea1c1 )
    {
        killbox notify( #"destroy_hazard" );
    }
    
    keycount = 0;
    
    foreach ( player in namespace_7f5aeb59::function_23e1f90f() )
    {
        player notify( #"hash_279998c5df86c04d" );
        keycount += player.doa.score.keys;
    }
    
    if ( var_41e7a0cc && keycount == 0 )
    {
        level waittill( #"hash_62332fcf2ebc16d1" );
        assert( isdefined( level.doa.var_a77e6349 ) );
        var_ce9a5656 = struct::get_array( "rof_keyspawn_loc", "targetname" );
        
        foreach ( spot in var_ce9a5656 )
        {
            [[ level.doa.var_a77e6349 ]]->function_39d2eb74( spot, "zombietron_skeleton_key", 100, 1, 0 );
        }
    }
    
    level.var_9fa19717 = undefined;
}

// Namespace wz_doa/wz_doa
// Params 1
// Checksum 0xed55b493, Offset: 0x1d08
// Size: 0x24
function function_9e356c78( *name )
{
    level doa_banner::function_7a0e5387( 40 );
}

// Namespace wz_doa/wz_doa
// Params 0
// Checksum 0x69201b49, Offset: 0x1d38
// Size: 0xc6
function function_9dfe2f0b()
{
    self notify( "1c99deabe372e234" );
    self endon( "1c99deabe372e234" );
    level endon( #"arena_switching", #"arena_completed" );
    var_94f3b914 = doa_enemy::function_251ee3bd( "smoke_zombie" );
    
    while ( true )
    {
        level waittill( #"hash_46fa6c5088941b95" );
        
        if ( [[ level.doa.var_39e3fa99 ]]->ispaused() )
        {
            continue;
        }
        
        level thread namespace_77eccc4f::function_d1603826( var_94f3b914 );
        wait 10;
    }
}

// Namespace wz_doa/wz_doa
// Params 0
// Checksum 0x6d2e4597, Offset: 0x1e08
// Size: 0xbc
function function_ffeaed15()
{
    level.var_7dcdbe16 = undefined;
    
    foreach ( player in getplayers() )
    {
        player clientfield::set_to_player( "cutscene", 0 );
    }
    
    changeadvertisedstatus( 0 );
}

// Namespace wz_doa/wz_doa
// Params 1
// Checksum 0x3511a755, Offset: 0x1ed0
// Size: 0x7a, Type: bool
function function_520814d5( player )
{
    if ( gettime() < self.doa.var_578b6ad4 )
    {
        return false;
    }
    
    if ( isdefined( player ) && distancesquared( self.origin, player.origin ) > sqr( 160 ) )
    {
        return false;
    }
    
    return true;
}

// Namespace wz_doa/wz_doa
// Params 0
// Checksum 0xac468ccc, Offset: 0x1f58
// Size: 0xa2
function function_30e6e8e9()
{
    self endon( #"death" );
    
    while ( true )
    {
        wait 1;
        player = getplayers()[ 0 ];
        
        if ( !function_520814d5( player ) )
        {
            continue;
        }
        
        self namespace_83eb6304::function_3ecfde67( "crab_bubbles" );
        self thread namespace_6e90e490::function_47e11416( 26, 4, 1 );
        return;
    }
}

// Namespace wz_doa/wz_doa
// Params 0
// Checksum 0x6a65d1b4, Offset: 0x2008
// Size: 0xca
function function_c139c0cd()
{
    self endon( #"death" );
    
    while ( true )
    {
        wait 1;
        player = getplayers()[ 0 ];
        
        if ( !function_520814d5( player ) )
        {
            continue;
        }
        
        if ( player.doa.score.var_194c59ae != 1 )
        {
            continue;
        }
        
        self namespace_83eb6304::function_3ecfde67( "crab_bubbles" );
        self thread namespace_6e90e490::function_47e11416( 22, 4, 1 );
        return;
    }
}

// Namespace wz_doa/wz_doa
// Params 0
// Checksum 0x6acfcbb7, Offset: 0x20e0
// Size: 0xe0
function function_5f282dbb()
{
    self endon( #"death" );
    
    while ( true )
    {
        wait 1;
        player = getplayers()[ 0 ];
        
        if ( !function_520814d5( player ) )
        {
            continue;
        }
        
        exits = [[ level.doa.var_39e3fa99 ]]->function_dfb49846();
        
        if ( exits.size == 0 )
        {
            continue;
        }
        
        self namespace_83eb6304::function_3ecfde67( "crab_bubbles" );
        self thread namespace_6e90e490::function_47e11416( 23, 4, 1 );
    }
}

// Namespace wz_doa/wz_doa
// Params 0
// Checksum 0x8d73f1dc, Offset: 0x21c8
// Size: 0xc0
function function_6b8cf507()
{
    self endon( #"death" );
    
    while ( true )
    {
        wait 1;
        player = getplayers()[ 0 ];
        
        if ( !function_520814d5( player ) )
        {
            continue;
        }
        
        if ( !isdefined( level.doa.teleporter ) )
        {
            continue;
        }
        
        self namespace_83eb6304::function_3ecfde67( "crab_bubbles" );
        self thread namespace_6e90e490::function_47e11416( 21, 4, 1 );
    }
}

// Namespace wz_doa/wz_doa
// Params 0
// Checksum 0xaccd7a83, Offset: 0x2290
// Size: 0xc0
function function_b5812513()
{
    self endon( #"death" );
    
    while ( true )
    {
        wait 1;
        player = getplayers()[ 0 ];
        
        if ( !function_520814d5( player ) )
        {
            continue;
        }
        
        if ( !isdefined( level.doa.var_6c225512 ) )
        {
            continue;
        }
        
        self namespace_83eb6304::function_3ecfde67( "crab_bubbles" );
        self thread namespace_6e90e490::function_47e11416( 24, 4, 1 );
    }
}

// Namespace wz_doa/wz_doa
// Params 0
// Checksum 0x924bfefe, Offset: 0x2358
// Size: 0xca
function function_3346623b()
{
    self endon( #"death" );
    
    while ( true )
    {
        wait 1;
        player = getplayers()[ 0 ];
        
        if ( !function_520814d5( player ) )
        {
            continue;
        }
        
        if ( player.doa.score.keys == 0 )
        {
            continue;
        }
        
        self namespace_83eb6304::function_3ecfde67( "crab_bubbles" );
        self thread namespace_6e90e490::function_47e11416( 25, 4, 1 );
        return;
    }
}

// Namespace wz_doa/wz_doa
// Params 0
// Checksum 0xdc51ade8, Offset: 0x2430
// Size: 0x102
function function_249cea33()
{
    self endon( #"death" );
    
    while ( true )
    {
        wait 1;
        player = getplayers()[ 0 ];
        
        if ( !function_520814d5( player ) )
        {
            continue;
        }
        
        if ( is_true( player.doa.infps ) == 0 )
        {
            continue;
        }
        
        if ( !util::within_fov( player.origin, player.angles, self.origin, 0.7 ) )
        {
            continue;
        }
        
        self namespace_83eb6304::function_3ecfde67( "crab_bubbles" );
        self thread namespace_6e90e490::function_47e11416( 27, 4, 1 );
        return;
    }
}

// Namespace wz_doa/wz_doa
// Params 0
// Checksum 0xf09c2c32, Offset: 0x2540
// Size: 0xd2
function function_6b42d44()
{
    self endon( #"death" );
    
    while ( true )
    {
        wait 1;
        player = getplayers()[ 0 ];
        
        if ( !function_520814d5( player ) )
        {
            continue;
        }
        
        if ( player.doa.var_fd5fcb75 == player.doa.var_ed8fde10 )
        {
            continue;
        }
        
        self namespace_83eb6304::function_3ecfde67( "crab_bubbles" );
        self thread namespace_6e90e490::function_47e11416( 28, 4, 1 );
        return;
    }
}

// Namespace wz_doa/wz_doa
// Params 0
// Checksum 0x866dbafe, Offset: 0x2620
// Size: 0xca
function function_22c260e()
{
    self endon( #"death" );
    
    while ( true )
    {
        wait 1;
        player = getplayers()[ 0 ];
        
        if ( !function_520814d5( player ) )
        {
            continue;
        }
        
        if ( player.doa.score.bombs == 0 )
        {
            continue;
        }
        
        self namespace_83eb6304::function_3ecfde67( "crab_bubbles" );
        self thread namespace_6e90e490::function_47e11416( 30, 4, 1 );
        return;
    }
}

// Namespace wz_doa/wz_doa
// Params 0
// Checksum 0xf3a5e78e, Offset: 0x26f8
// Size: 0xca
function function_13471cec()
{
    self endon( #"death" );
    
    while ( true )
    {
        wait 1;
        player = getplayers()[ 0 ];
        
        if ( !function_520814d5( player ) )
        {
            continue;
        }
        
        if ( player.doa.score.boosts == 0 )
        {
            continue;
        }
        
        self namespace_83eb6304::function_3ecfde67( "crab_bubbles" );
        self thread namespace_6e90e490::function_47e11416( 31, 4, 1 );
        return;
    }
}

// Namespace wz_doa/wz_doa
// Params 0
// Checksum 0xbf23f347, Offset: 0x27d0
// Size: 0xb8
function function_e8a512e2()
{
    self notify( "4069e3c16e453c83" );
    self endon( "4069e3c16e453c83" );
    self endon( #"death" );
    
    while ( true )
    {
        wait 1;
        player = getplayers()[ 0 ];
        
        if ( !function_520814d5( player ) )
        {
            continue;
        }
        
        self namespace_83eb6304::function_3ecfde67( "crab_bubbles" );
        self thread namespace_6e90e490::function_47e11416( 7, 4, 1 );
    }
}

// Namespace wz_doa/wz_doa
// Params 0
// Checksum 0x5488a8d5, Offset: 0x2890
// Size: 0x29c
function function_1b441d99()
{
    players = getplayers();
    
    if ( players.size > 1 || level.doa.var_6c58d51 > 0 )
    {
        return;
    }
    
    spot = struct::get( [[ level.doa.var_39e3fa99 ]]->getname() + "_tutorial", "targetname" );
    assert( isdefined( spot ) );
    var_9958214e = namespace_ec06fe4a::spawnmodel( spot.origin, spot.script_noteworthy, spot.angles, "island_tutorial_" + spot.script_noteworthy );
    var_9958214e.takedamage = 0;
    var_9958214e.doa = spawnstruct();
    var_9958214e.doa.hints = 0;
    var_9958214e.doa.var_578b6ad4 = 0;
    var_9958214e clientfield::set( "setTutorialEnt", 1 );
    var_9958214e thread namespace_ec06fe4a::function_d55f042c( level, "arena_switching" );
    var_9958214e thread namespace_ec06fe4a::function_d55f042c( level, "game_over" );
    var_9958214e thread function_5f282dbb();
    var_9958214e thread function_b5812513();
    var_9958214e thread function_3346623b();
    var_9958214e thread function_c139c0cd();
    var_9958214e thread function_30e6e8e9();
    var_9958214e thread function_249cea33();
    var_9958214e thread function_6b42d44();
    var_9958214e thread function_22c260e();
    var_9958214e thread function_13471cec();
    var_9958214e thread function_e8a512e2();
}

// Namespace wz_doa/wz_doa
// Params 0
// Checksum 0x43627ef3, Offset: 0x2b38
// Size: 0x7e0
function function_863ffeba()
{
    self notify( "28c1d7a966105195" );
    self endon( "28c1d7a966105195" );
    level endon( #"arena_switching", #"game_over" );
    
    while ( true )
    {
        level waittill( #"round_about_to_start" );
        
        if ( level.doa.roundnumber == 1 )
        {
            level thread function_1b441d99();
            function_599f5580();
            wait 15;
            
            foreach ( player in getplayers() )
            {
                player namespace_6e90e490::showhint( 8 );
            }
        }
        
        if ( level.doa.roundnumber == 2 )
        {
            wait 5;
            
            foreach ( player in getplayers() )
            {
                player namespace_6e90e490::showhint( 9 );
            }
            
            wait 15;
            
            foreach ( player in getplayers() )
            {
                player namespace_6e90e490::showhint( 10 );
            }
        }
        
        if ( level.doa.roundnumber == 3 )
        {
            namespace_1e25ad94::debugmsg( "Arena (" + [[ level.doa.var_39e3fa99 ]]->getname() + ") special event triggered at: " + gettime() + " RoundNumber: " + level.doa.roundnumber );
            level.doa.var_cfa10fcf = 3;
        }
        
        if ( level.doa.roundnumber == 4 )
        {
            var_65bccf6 = namespace_dfc652ee::function_57160cba( 3 );
            spot = [[ level.doa.var_39e3fa99 ]]->function_fdea25f1();
            namespace_dfc652ee::function_83aea294( spot.origin, 1, 128, var_65bccf6, undefined, 1 );
            level flag::set( "arena_hold_presentation" );
            level flag::set( "arena_hold_banner_presentation" );
            level waittill( #"hash_de33bd076cde122" );
            wild = doa_wild::function_d5e7454f( "jungle_1" );
            starts = [[ wild ]]->function_5dfb6d67( 0 );
            level namespace_ec06fe4a::function_87612422( starts[ 0 ].origin, starts[ 0 ].angles, 1, 999999, [[ wild ]]->function_39f259cc() );
            level.var_7dcdbe16 = 1;
            namespace_ec06fe4a::function_445bad70( 1 );
            
            foreach ( player in getplayers() )
            {
                player notify( #"hash_7893364bd228d63e" );
            }
            
            wait 1;
            var_a3f4cb78 = [[ level.doa.var_39e3fa99 ]]->function_51dd0a59();
            spots = [[ level.doa.var_39e3fa99 ]]->function_8054e011();
            var_dbfa4ffb = [];
            
            foreach ( spot in spots )
            {
                distsq = distancesquared( spot.origin, var_a3f4cb78.origin );
                
                if ( distsq < sqr( 160 ) )
                {
                    continue;
                }
                
                var_dbfa4ffb[ var_dbfa4ffb.size ] = spot;
            }
            
            foreach ( player in getplayers() )
            {
                distsq = distancesquared( player.origin, var_a3f4cb78.origin );
                
                if ( distsq < sqr( 160 ) )
                {
                    spot = arraysortclosest( var_dbfa4ffb, player.origin, 1, 160 )[ 0 ];
                    arrayremoveindex( var_dbfa4ffb, 0 );
                    player setorigin( spot.origin );
                }
                
                player clientfield::set_to_player( "cutscene", 1 );
            }
            
            level thread function_ae378de8();
            
            if ( !is_true( level.var_a095060b ) )
            {
                level thread function_dc41b38();
            }
        }
    }
}

// Namespace wz_doa/wz_doa
// Params 0
// Checksum 0x6546e1fc, Offset: 0x3320
// Size: 0xf0
function function_3e4c2ba0()
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( randomint( 100 ) < 4 )
        {
            self namespace_83eb6304::function_3ecfde67( "teleporter_disabled" );
        }
        
        if ( randomint( 100 ) < 2 )
        {
            self namespace_83eb6304::function_3ecfde67( "hazard_electric" );
        }
        
        if ( randomint( 100 ) > 95 )
        {
            self namespace_83eb6304::function_3ecfde67( "teleporter_dungeon_light" );
        }
        else
        {
            self namespace_83eb6304::turnofffx( "teleporter_dungeon_light" );
        }
        
        wait 0.1;
    }
}

// Namespace wz_doa/wz_doa
// Params 0
// Checksum 0x8e3424f2, Offset: 0x3418
// Size: 0x230
function function_dc41b38()
{
    result = level waittill( #"teleporter_spawned" );
    teleporter = result.teleporter;
    teleporter endon( #"death" );
    teleporter.malfunction = 1;
    level waittill( #"hash_53cf824d8cd53237" );
    teleporter setmodel( "zombietron_teleporter_damaged" );
    teleporter namespace_83eb6304::function_3ecfde67( "wild_portal_radial_burst" );
    teleporter namespace_83eb6304::function_3ecfde67( "electrical_fire" );
    teleporter thread function_3e4c2ba0();
    wait 5;
    
    foreach ( player in getplayers() )
    {
        player clientfield::set_to_player( "cutscene", 0 );
    }
    
    level.var_7dcdbe16 = undefined;
    namespace_ec06fe4a::function_445bad70( 0 );
    
    while ( true )
    {
        if ( !isdefined( teleporter.trigger ) )
        {
            waitframe( 1 );
            continue;
        }
        
        result = teleporter.trigger waittill( #"trigger" );
        
        if ( isdefined( result.activator ) )
        {
            player = result.activator;
            player thread namespace_6e90e490::function_47e11416( 10 );
        }
    }
}

// Namespace wz_doa/wz_doa
// Params 0
// Checksum 0xfaca29b9, Offset: 0x3650
// Size: 0xd94
function function_ae378de8()
{
    streamermodelhint( "c_zom_doa_simianaut_body", 20 );
    streamermodelhint( "c_zom_doa_simianaut_wig", 20 );
    streamermodelhint( "c_zom_doa_simianaut_glasses", 20 );
    streamermodelhint( "zombietron_spoon", 20 );
    wait 1;
    var_a3f4cb78 = [[ level.doa.var_39e3fa99 ]]->function_51dd0a59();
    silverback = namespace_58e19d6::function_6ae08d6c( var_a3f4cb78.origin );
    silverback.ignoreall = 1;
    silverback.takedamage = 0;
    silverback.collector = 1;
    silverback namespace_58e19d6::function_27adf2ff( 0, 0 );
    silverback thread namespace_ec06fe4a::function_d55f042c( level, "arena_switching" );
    silverback thread namespace_ec06fe4a::function_d55f042c( level, "game_over" );
    silverback namespace_ec06fe4a::function_8c808737();
    silverback pathmode( "dont move" );
    silverback orientmode( "face enemy" );
    org = spawn( "script_model", var_a3f4cb78.origin );
    org setmodel( "tag_origin" );
    org thread namespace_ec06fe4a::function_d55f042c( level, "game_over" );
    org thread namespace_ec06fe4a::function_d55f042c( level, "arena_switching" );
    playsoundatposition( #"zmb_hellhound_prespawn", var_a3f4cb78.origin );
    playsoundatposition( #"zmb_hellhound_bolt", var_a3f4cb78.origin );
    earthquake( 0.5, 0.75, var_a3f4cb78.origin, 1000 );
    playsoundatposition( #"zmb_hellhound_spawn", var_a3f4cb78.origin );
    org namespace_83eb6304::function_3ecfde67( "lightningStrike" );
    wait randomfloat( 1.2 );
    org namespace_83eb6304::function_3ecfde67( "lightningStrike" );
    wait randomfloat( 2 );
    org namespace_83eb6304::function_3ecfde67( "lightningStrike" );
    waitframe( 1 );
    org namespace_83eb6304::function_3ecfde67( "lightningStrike" );
    playsoundatposition( #"zmb_hellhound_bolt", var_a3f4cb78.origin );
    org namespace_83eb6304::function_3ecfde67( "wild_portal" );
    wait randomfloat( 1 );
    org namespace_83eb6304::function_3ecfde67( "lightningStrike" );
    playsoundatposition( #"zmb_hellhound_bolt", var_a3f4cb78.origin );
    earthquake( 0.5, 0.75, var_a3f4cb78.origin, 1000 );
    var_f8999e14 = struct::get( "island_cutscene_camloc", "targetname" );
    angle = vectortoangles( var_f8999e14.origin - silverback.origin );
    angles = ( silverback.angles[ 0 ], angle[ 1 ], silverback.angles[ 2 ] );
    silverback dontinterpolate();
    silverback forceteleport( var_a3f4cb78.origin, angles );
    org.angles = angles;
    silverback linkto( org );
    silverback namespace_ec06fe4a::function_4f72130c();
    silverback namespace_58e19d6::function_27adf2ff( 1, 0 );
    wait 0.5;
    org namespace_83eb6304::function_3ecfde67( "lightningStrike" );
    playsoundatposition( #"zmb_hellhound_bolt", var_a3f4cb78.origin );
    silverback playsound( "zmb_simianaut_roar" );
    silverback thread namespace_6e90e490::function_47e11416( 11, undefined, 1 );
    namespace_dfc652ee::function_ad7ac41b( silverback.origin, 20, 700, 1 );
    silverback.var_ba88972 = 1;
    silverback waittilltimeout( 2, #"taunt_end" );
    silverback.var_ba88972 = undefined;
    org namespace_83eb6304::function_3ecfde67( "lightningStrike" );
    playsoundatposition( #"zmb_hellhound_bolt", var_a3f4cb78.origin );
    level flag::clear( "arena_hold_presentation" );
    wait 3.1;
    silverback thread namespace_6e90e490::function_47e11416( 11, undefined, 1 );
    org namespace_83eb6304::function_3ecfde67( "lightningStrike" );
    playsoundatposition( #"zmb_hellhound_bolt", var_a3f4cb78.origin );
    silverback playsound( "zmb_simianaut_roar" );
    var_26e4879c = [[ level.doa.var_39e3fa99 ]]->function_ffcf1d1() + ( 0, 0, 20 );
    var_1b6117e6 = namespace_ec06fe4a::spawnmodel( ( 0, 0, 0 ), "tag_origin", ( 0, 0, 0 ), "zombietron_silverback_bomb_fuse" );
    bombmodel = namespace_ec06fe4a::spawnmodel( silverback gettagorigin( "j_wrist_le" ), "zombietron_silverback_bomb", ( 0, 0, 0 ), "zombietron_silverback_bomb" );
    var_1b6117e6 linkto( bombmodel, undefined, ( 0, 0, 48 ) );
    bombmodel moveto( var_26e4879c, 3 );
    wait 3.1;
    level thread namespace_7da86f3c::function_eeb092f5( silverback );
    silverback thread namespace_6e90e490::function_47e11416( 11, undefined, 1 );
    silverback.var_ba88972 = 1;
    silverback waittilltimeout( 2, #"taunt_end" );
    wait 3.1;
    silverback.var_ba88972 = undefined;
    org namespace_83eb6304::function_3ecfde67( "lightningStrike" );
    silverback thread namespace_6e90e490::function_47e11416( 11, undefined, 1 );
    wait 3.1;
    fxorg = namespace_ec06fe4a::spawnmodel( silverback gettagorigin( "tag_eye" ), "tag_origin" );
    org namespace_83eb6304::function_3ecfde67( "lightningStrike" );
    wait 0.1;
    silverback unlink();
    silverback.var_febfd0.angles = silverback.angles;
    silverback.var_febfd0.origin = silverback.origin;
    silverback linkto( silverback.var_febfd0 );
    destination = silverback.var_febfd0.origin + ( 0, 0, -400 );
    silverback.var_febfd0 thread function_dbe90b58();
    silverback.var_febfd0 moveto( destination, 5, 4 );
    
    if ( isdefined( fxorg ) )
    {
        fxorg.targetname = "tesla_trail";
        fxorg namespace_83eb6304::function_3ecfde67( "tesla_trail" );
        fxorg moveto( var_1b6117e6.origin, 0.6 );
        fxorg waittilltimeout( 0.6, #"movedone" );
        fxorg namespace_83eb6304::function_3ecfde67( "hazard_electric" );
        fxorg namespace_83eb6304::turnofffx( "teslsa_trail" );
        var_1b6117e6 namespace_83eb6304::function_3ecfde67( "bombFuse" );
        wait 2.4;
        fxorg delete();
    }
    else
    {
        var_1b6117e6 namespace_83eb6304::function_3ecfde67( "bombFuse" );
        wait 3;
    }
    
    silverback playsound( "zmb_simianaut_roar" );
    wait 1;
    org namespace_83eb6304::function_3ecfde67( "lightningStrike" );
    playsoundatposition( #"zmb_hellhound_bolt", var_a3f4cb78.origin );
    silverback.var_febfd0 waittilltimeout( 1, #"movedone" );
    org namespace_83eb6304::function_3ecfde67( "lightningStrike" );
    playsoundatposition( #"zmb_hellhound_bolt", var_a3f4cb78.origin );
    silverback playsound( "zmb_simianaut_roar" );
    waitframe( 1 );
    silverback delete();
    org namespace_83eb6304::function_3ecfde67( "wild_portal_radial_burst" );
    wait 1;
    org namespace_83eb6304::function_3ecfde67( "lightningStrike" );
    playsoundatposition( #"zmb_hellhound_bolt", var_a3f4cb78.origin );
    org delete();
    wait 1;
    level flag::clear( "arena_hold_banner_presentation" );
    level notify( #"hash_53cf824d8cd53237" );
    bombmodel namespace_83eb6304::function_3ecfde67( "monkey_detonate" );
    var_1b6117e6 delete();
    bombmodel namespace_ec06fe4a::function_8c808737();
    bombmodel thread namespace_ec06fe4a::function_52afe5df( 0.5 );
}

// Namespace wz_doa/wz_doa
// Params 0
// Checksum 0x42d832ba, Offset: 0x43f0
// Size: 0xa2
function function_dbe90b58()
{
    self endon( #"death" );
    dir = 180;
    
    for ( time = 0.4; true ; time = math::clamp( time * 0.78, 0.05, 1 ) )
    {
        self rotateto( self.angles + ( 0, dir, 0 ), time );
        wait time;
    }
}

// Namespace wz_doa/wz_doa
// Params 0
// Checksum 0xb7aa579a, Offset: 0x44a0
// Size: 0x2c
function function_f1ec9045()
{
    level.doa.var_13e8f9c9 = undefined;
    changeadvertisedstatus( 0 );
}

// Namespace wz_doa/wz_doa
// Params 0
// Checksum 0x53922326, Offset: 0x44d8
// Size: 0xa2
function function_570d7b0b()
{
    self endon( #"death" );
    
    while ( true )
    {
        wait 1;
        player = getplayers()[ 0 ];
        
        if ( !function_520814d5( player ) )
        {
            continue;
        }
        
        self namespace_83eb6304::function_3ecfde67( "crab_bubbles" );
        self thread namespace_6e90e490::function_47e11416( 29, 4, 1 );
        return;
    }
}

// Namespace wz_doa/wz_doa
// Params 0
// Checksum 0xef6e883f, Offset: 0x4588
// Size: 0x214
function function_e206e3a8()
{
    players = getplayers();
    
    if ( players.size > 1 || level.doa.var_6c58d51 > 0 )
    {
        return;
    }
    
    spot = struct::get( [[ level.doa.var_39e3fa99 ]]->getname() + "_tutorial", "targetname" );
    assert( isdefined( spot ) );
    var_9958214e = namespace_ec06fe4a::spawnmodel( spot.origin, spot.script_noteworthy, spot.angles, spot.targetname + "_" + spot.script_noteworthy );
    var_9958214e.takedamage = 0;
    var_9958214e.doa = spawnstruct();
    var_9958214e.doa.var_578b6ad4 = 0;
    var_9958214e clientfield::set( "setTutorialEnt", 1 );
    var_9958214e thread namespace_ec06fe4a::function_d55f042c( level, "arena_switching" );
    var_9958214e thread namespace_ec06fe4a::function_d55f042c( level, "game_over" );
    level waittill( #"hash_58caf0ade03043bb" );
    var_9958214e thread function_6b8cf507();
    var_9958214e thread function_5f282dbb();
    var_9958214e thread function_570d7b0b();
    var_9958214e thread function_e8a512e2();
}

// Namespace wz_doa/wz_doa
// Params 0
// Checksum 0x5e39427f, Offset: 0x47a8
// Size: 0x348
function function_529acb04()
{
    self notify( "70e876c593451197" );
    self endon( "70e876c593451197" );
    level endon( #"arena_switching", #"arena_completed", #"game_over" );
    
    if ( level.doa.var_6c58d51 == 0 )
    {
        level.doa.var_13e8f9c9 = "run";
    }
    
    var_5afe9cea = 40;
    var_73d54dd1 = 0;
    level thread function_e206e3a8();
    [[ level.doa.var_39e3fa99 ]]->function_6d5262dc( 40 );
    
    while ( true )
    {
        level waittill( #"round_about_to_start" );
        
        if ( level.doa.roundnumber == 5 )
        {
            changeadvertisedstatus( 1 );
            
            foreach ( player in getplayers() )
            {
                player namespace_6e90e490::showhint( 5 );
            }
        }
        
        if ( !isdefined( level.doa.var_8dc464fe ) && !var_73d54dd1 )
        {
            if ( randomint( 100 ) < var_5afe9cea )
            {
                var_73d54dd1 = 1;
                room = namespace_5a917022::function_3db4a0b1();
                
                if ( isdefined( room ) )
                {
                    level.doa.var_848746c8 = room.name;
                }
            }
            else
            {
                var_5afe9cea += 30;
            }
        }
        
        if ( level.doa.roundnumber == 5 )
        {
            namespace_1e25ad94::debugmsg( "Arena (" + [[ level.doa.var_39e3fa99 ]]->getname() + ") special event triggered at: " + gettime() + " RoundNumber: " + level.doa.roundnumber );
            var_65bccf6 = namespace_dfc652ee::function_57160cba( 3 );
            spot = [[ level.doa.var_39e3fa99 ]]->function_fdea25f1();
            namespace_dfc652ee::function_83aea294( spot.origin, 1, 128, var_65bccf6, undefined, 1 );
        }
    }
}

// Namespace wz_doa/wz_doa
// Params 0
// Checksum 0x96174e1d, Offset: 0x4af8
// Size: 0xbc
function function_599f5580()
{
    function_2a6cdb09();
    players = getplayers();
    
    if ( players.size == 1 && is_true( players[ 0 ].doa.var_57b93c27 ) )
    {
        origin = [[ level.doa.var_39e3fa99 ]]->function_ffcf1d1();
        level namespace_dfc652ee::function_ad7ac41b( origin, 1, 72, 14, 1 );
    }
}

// Namespace wz_doa/wz_doa
// Params 0
// Checksum 0x8addd5c, Offset: 0x4bc0
// Size: 0x1c8
function function_2a6cdb09()
{
    players = getplayers();
    
    foreach ( player in players )
    {
        player.doa.var_57b93c27 = 1;
        
        if ( sessionmodeisonlinegame() == 0 )
        {
            continue;
        }
        
        if ( player stats::function_f94325d3() == 0 )
        {
            continue;
        }
        
        player.doa.hintmask = player stats::get_stat( #"doastats", #"hintmask" );
        hasplayed = player stats::get_stat( #"doastats", #"hasplayed" );
        
        if ( !isdefined( hasplayed ) || hasplayed )
        {
            player.doa.var_57b93c27 = 0;
            continue;
        }
        
        player stats::set_stat( #"doastats", #"hasplayed", 1 );
        uploadstats( player );
    }
}

