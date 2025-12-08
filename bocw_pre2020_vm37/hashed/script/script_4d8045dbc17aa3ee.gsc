#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_350cffecd05ef6cf;
#using script_40f967ad5d18ea74;
#using script_4611af4073d18808;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_50fca1a24ae351;
#using script_5549681e1669c11a;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_68cdf0ca5df5e;
#using script_74a56359b7d02ab6;
#using script_774302f762d76254;
#using script_f38dc50f0e82277;
#using scripts\core_common\array_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_e857b038;

// Namespace namespace_e857b038/namespace_e857b038
// Params 0
// Checksum 0xcb5c6493, Offset: 0x798
// Size: 0x3c
function init()
{
    callback::on_spawned( &on_bot_spawned );
    level thread setupdevgui();
}

// Namespace namespace_e857b038/namespace_e857b038
// Params 0
// Checksum 0x55b73027, Offset: 0x7e0
// Size: 0xa4
function on_bot_spawned()
{
    player = getplayers()[ 0 ];
    
    if ( self istestclient() )
    {
        origin = player.origin + ( randomintrange( -100, 100 ), randomintrange( -100, 100 ), 30 );
        self setorigin( origin );
    }
}

// Namespace namespace_e857b038/namespace_e857b038
// Params 0
// Checksum 0x2b9f17ef, Offset: 0x890
// Size: 0x174
function setupdevgui()
{
    /#
        level waittill( #"doa_game_initialized" );
        execdevgui( "<dev string:x38>" );
        function_61b604bf();
        level thread function_d379ba37();
        level.var_861a7982 = 0;
        level.var_4bee9366 = 0;
        level.doa.var_2e491399 = 0;
    #/
    
    if ( getdvarint( #"hash_63b27cb45671e35c", 0 ) )
    {
        setdvar( #"hash_63b27cb45671e35c", 0 );
        setdvar( #"hash_d874e4e73e9f18", 1 );
        level thread function_8cac3f8c();
    }
    
    if ( getdvarint( #"hash_d874e4e73e9f18", 0 ) && !is_true( level.var_a095060b ) )
    {
        level thread function_1552e594();
    }
}

// Namespace namespace_e857b038/namespace_e857b038
// Params 0
// Checksum 0xe0afd64, Offset: 0xa10
// Size: 0x1ff8
function function_d379ba37()
{
    setdvar( #"zombie_devgui", "" );
    setdvar( #"hash_116f154050454a80", "" );
    setdvar( #"hash_1c923c83363c543b", "" );
    setdvar( #"hash_6a3de42f6f3e6fd7", "" );
    setdvar( #"hash_4cd093f275a4cf7d", "" );
    setdvar( #"hash_2bdf0b4b3b54f5f9", "" );
    setdvar( #"hash_442e0c29ec279820", "" );
    setdvar( #"hash_5668d121a9e929c8", "" );
    setdvar( #"hash_2d6ac7bedd2e2d8", "" );
    
    while ( true )
    {
        if ( getdvarint( #"hash_d874e4e73e9f18", 0 ) )
        {
            if ( !is_true( level.var_a095060b ) )
            {
                level thread function_1552e594();
            }
        }
        else if ( is_true( level.var_a095060b ) )
        {
            level notify( #"hash_12d79bc0fed4ee5a" );
        }
        
        cmd = getdvarstring( #"zombie_devgui" );
        
        if ( cmd == "" )
        {
            wait 0.5;
            continue;
        }
        
        origin = namespace_7f5aeb59::function_23e1f90f()[ 0 ].origin;
        namespace_1e25ad94::debugmsg( "Devgui Cmd-->" + cmd );
        
        switch ( cmd )
        {
            case #"hash_e172fdc803f50b":
                if ( is_true( level.doa.var_c93506fb ) )
                {
                    level.doa.var_c93506fb = undefined;
                    level notify( #"hash_39ebcccef3aa05c6" );
                    break;
                }
                
                level.doa.var_c93506fb = 1;
                level thread function_c93506fb();
            case #"dungeon":
                if ( [[ level.doa.var_39e3fa99 ]]->getname() != "island" )
                {
                    namespace_1e25ad94::debugmsg( "ROF cmd only works from island level" );
                    break;
                }
                
                level.doa.var_e15152e6 = "jungle_1";
                level.doa.var_baeb966b = 0;
                level notify( #"round_over" );
                level flag::set( "arena_zero_rounds" );
                level flag::clear( "doa_round_spawning" );
                level thread function_de70888a();
                level namespace_ec06fe4a::function_b6b79fd1();
                namespace_ec06fe4a::clearallcorpses();
                level waittill( #"waiting_on_player_exit_decidechoice" );
                wait 0.2;
                level notify( #"hash_45f77908e3043522", { #note:"enter_the_wild" } );
                level waittilltimeout( 3, #"hash_58caf0ade03043bb" );
                wait 2;
                level doa_banner::function_7a0e5387();
                wait 1;
                idx = namespace_981c1f3c::function_61e1a1cb( getdvarstring( #"hash_2d6ac7bedd2e2d8" ) );
                dungeons = getentarray( "dungeon_generator", "targetname" );
                
                if ( !isdefined( idx ) || idx == 0 )
                {
                    level.doa.var_8823e378 = dungeons[ randomint( dungeons.size ) ].origin;
                }
                else
                {
                    foreach ( dungeon in dungeons )
                    {
                        if ( dungeon.target === getdvarstring( #"hash_2d6ac7bedd2e2d8" ) )
                        {
                            level.doa.var_8823e378 = dungeon.origin;
                            break;
                        }
                    }
                    
                    if ( !isdefined( level.doa.var_8823e378 ) )
                    {
                        level.doa.var_8823e378 = dungeons[ randomint( dungeons.size ) ].origin;
                    }
                }
                
                foreach ( player in getplayers() )
                {
                    player setorigin( level.doa.var_8823e378 );
                }
                
                break;
            case #"hash_306d6ab73bae955d":
                if ( !isdefined( level.doa.var_7ada373e ) )
                {
                    level.doa.var_7ada373e = 0;
                }
                
                level.doa.var_7ada373e = !level.doa.var_7ada373e;
                namespace_1e25ad94::function_4e3cfad( "Wave Interleaving is turned " + ( level.doa.var_7ada373e ? "ON" : "OFF" ), undefined, undefined, undefined, 10 );
                break;
            case #"hash_596169604e05dd60":
                if ( [[ level.doa.var_39e3fa99 ]]->getname() != "island" )
                {
                    namespace_1e25ad94::debugmsg( "ROF cmd only works from island level" );
                    return;
                }
                
                level.doa.var_e15152e6 = "jungle_1";
                level.doa.var_baeb966b = 0;
                level notify( #"round_over" );
                level flag::set( "arena_zero_rounds" );
                level flag::clear( "doa_round_spawning" );
                level thread function_de70888a();
                level namespace_ec06fe4a::function_b6b79fd1();
                namespace_ec06fe4a::clearallcorpses();
                level waittill( #"waiting_on_player_exit_decidechoice" );
                wait 0.2;
                level notify( #"hash_45f77908e3043522", { #note:"enter_the_wild" } );
                level waittilltimeout( 3, #"hash_58caf0ade03043bb" );
                level doa_banner::function_7a0e5387();
                var_6fdeb679 = getent( "room_of_fate_shaft_trigger", "targetname" ).origin;
                level.doa.var_a5d58dd1 = 300;
                
                foreach ( player in getplayers() )
                {
                    player setorigin( var_6fdeb679 );
                }
                
                break;
            case #"fate":
                player = namespace_7f5aeb59::function_23e1f90f()[ 0 ];
                var_c8386627 = int( getdvarstring( #"hash_116f154050454a80" ) );
                player thread namespace_1c2a96f9::function_15a789ab( var_c8386627 );
                break;
            case #"hash_6f957c9ffba3bfe1":
                level.doa.var_f4cf4e3 += 20;
                level.doa.zombie_health += 1000;
                namespace_4dae815d::function_e22d3978( level.doa.roundnumber + 10 );
                namespace_1e25ad94::debugmsg( "Round set to: " + level.doa.roundnumber );
                break;
            case #"bonusroom":
                level notify( #"round_over" );
                level flag::clear( "doa_round_spawning" );
                level thread function_de70888a();
                level namespace_ec06fe4a::function_b6b79fd1();
                namespace_ec06fe4a::clearallcorpses();
                level.doa.var_848746c8 = getdvarstring( #"hash_2bdf0b4b3b54f5f9" );
                namespace_1e25ad94::debugmsg( "Bonus room being forced to: " + level.doa.var_848746c8 );
                break;
            case #"bonusroomsoak":
                level.doa.var_848746c8 = getdvarstring( #"hash_2bdf0b4b3b54f5f9" );
                namespace_1e25ad94::debugmsg( "Bonus room soak being forced to: " + level.doa.var_848746c8 );
                level thread namespace_5a917022::function_e5c7bce7();
                break;
            case #"enemy":
                spot = [[ level.doa.var_39e3fa99 ]]->function_70fb5745().origin;
                doa_enemy::function_a6b807ea( doa_enemy::function_d7c5adee( getdvarstring( #"hash_442e0c29ec279820" ) ), 1, spot );
                break;
            case #"corner":
                level thread function_43548cd2();
                break;
            case #"fly":
                /#
                    player = namespace_7f5aeb59::function_23e1f90f()[ 0 ];
                    
                    if ( !is_true( player.doa.infps ) )
                    {
                        player thread namespace_a4bedd45::function_1f704cee( 1 );
                        adddebugcommand( "<dev string:x54>" );
                        setsaveddvar( #"hash_7aa67f68d1a1b28d", 10 );
                    }
                    else
                    {
                        player notify( #"hash_7893364bd228d63e", { #var_cff8d1e:1 } );
                        adddebugcommand( "<dev string:x54>" );
                    }
                #/
                
                break;
            case #"arena_safety":
                foreach ( player in namespace_7f5aeb59::function_23e1f90f() )
                {
                    player.doa.var_3cf36932 = !player.doa.var_3cf36932;
                    namespace_1e25ad94::debugmsg( "Arena Saftey for player (" + player.doa.color + ") is set to:" + ( player.doa.var_3cf36932 ? "ON" : "OFF" ) );
                }
                
                break;
            case #"arena":
                level notify( #"round_over" );
                level thread function_de70888a();
                level namespace_ec06fe4a::function_b6b79fd1();
                namespace_ec06fe4a::clearallcorpses();
                level thread namespace_7f5aeb59::function_67f054d7( 1.5 );
                level waittill( #"hash_1b322de3d2e3e781" );
                [[ level.doa.var_39e3fa99 ]]->function_9f494a87();
                [[ level.doa.var_39e3fa99 ]]->function_7ce9bb97();
                level notify( #"arena_completed" );
                level clientfield::set( "flipCamera", 0 );
                level.doa.var_23fd3659 = namespace_8c04284b::function_a7c5291d( getdvarstring( #"hash_4cd093f275a4cf7d" ) );
                level thread namespace_8c04284b::function_6d6bfe1f( level.doa.var_23fd3659 );
                break;
            case #"wild":
                if ( isdefined( level.doa.var_a77e6349 ) )
                {
                    exit = [[ level.doa.var_a77e6349 ]]->function_5acbc98e();
                    exit.trigger notify( #"trigger" );
                    level waittill( #"hash_325440d5433be263" );
                    level waittill( #"round_begin" );
                    wait 1;
                }
                
                cmd = getdvarstring( #"hash_5668d121a9e929c8" );
                args = strtok( cmd, "@" );
                level.doa.var_e15152e6 = args[ 0 ];
                level.doa.var_baeb966b = int( args[ 1 ] );
                level notify( #"round_over" );
                level flag::set( "arena_zero_rounds" );
                level flag::clear( "doa_round_spawning" );
                level thread function_de70888a();
                level namespace_ec06fe4a::function_b6b79fd1();
                namespace_ec06fe4a::clearallcorpses();
                break;
            case #"flip":
                namespace_8c04284b::function_a70ff03e( !level.doa.var_ecff3871 );
                break;
            case #"hash_4ce30f9f2b25ddae":
                namespace_1e25ad94::function_8225da57();
                break;
            case #"hash_2a09add45a0410e7":
                namespace_1e25ad94::function_d88064ec();
                break;
            case #"weaponcharger":
                level.doa.var_11623c49 = 0;
                level.doa.var_a6cd0cb7 = 1;
                break;
            case #"pickup":
                namespace_1e25ad94::debugmsg( "spawning pickup " + getdvarstring( #"hash_116f154050454a80" ) );
                item = namespace_dfc652ee::function_6265bde4( getdvarstring( #"hash_116f154050454a80" ) );
                
                if ( isdefined( item ) )
                {
                    if ( [[ item ]]->gettype() == 13 )
                    {
                        level namespace_dfc652ee::function_d06cbfe8( origin, 1, 256, undefined, item, 1 );
                    }
                    else
                    {
                        level namespace_dfc652ee::function_83aea294( origin, 5, 256, item, undefined, 1 );
                    }
                }
                
                break;
            case #"pickup_pile":
                namespace_1e25ad94::debugmsg( "Here is a bunch of stuff for you!" );
                level namespace_dfc652ee::function_ad7ac41b( origin, 20, 256, 0, 1 );
                break;
            case #"weapon_pile":
                namespace_1e25ad94::debugmsg( "Weapon aresenal incomming!!" );
                level namespace_dfc652ee::function_ad7ac41b( origin, 20, 256, 6, 1 );
                break;
            case #"money":
                namespace_1e25ad94::debugmsg( "big money, BIG PRIZES!" );
                level namespace_dfc652ee::function_68442ee7( origin, 20, 256 );
                level namespace_dfc652ee::function_68442ee7( origin, 20, 128, 1 );
                break;
            case #"hash_340cf8f497c2fa9":
                namespace_1e25ad94::debugmsg( "Max Score Multiplier!" );
                
                foreach ( player in namespace_7f5aeb59::function_23e1f90f() )
                {
                    player.doa.score.var_a928c52e = level.doa.var_88be0b68;
                }
                
                break;
            case #"gem":
                namespace_1e25ad94::debugmsg( "Gems!" );
                namespace_dfc652ee::function_d06cbfe8( origin, 20, 256 );
                break;
            case #"gempop":
                namespace_1e25ad94::debugmsg( "Gems Launching!" );
                namespace_dfc652ee::function_d06cbfe8( origin, 1, 128, 1 );
                break;
            case #"king":
                namespace_1e25ad94::debugmsg( "Hail to the King baby!" );
                
                foreach ( player in namespace_7f5aeb59::function_23e1f90f() )
                {
                    player thread function_ddde8af6();
                }
                
                break;
            case #"hash_32f10e7eebda6ed5":
                level notify( #"hash_6b0c389ef8ac36b4" );
                break;
            case #"kill":
                namespace_1e25ad94::debugmsg( "death has been notified ..." );
                players = namespace_7f5aeb59::function_23e1f90f();
                
                if ( players.size == 1 )
                {
                    player = players[ 0 ];
                }
                else
                {
                    player = players[ randomint( players.size ) ];
                }
                
                player dodamage( player.health + 100, player.origin );
                break;
            case #"kill_all":
                namespace_1e25ad94::debugmsg( "death to all..." );
                players = namespace_7f5aeb59::function_23e1f90f();
                
                foreach ( player in players )
                {
                    player dodamage( player.health + 100, player.origin );
                }
                
                break;
            case #"hash_ca0bb68723c267c":
                namespace_1e25ad94::debugmsg( "death to all bots..." );
                players = namespace_7f5aeb59::function_23e1f90f();
                bots = [];
                var_c8dd979c = ( 0, 0, 0 );
                targetplayer = players[ randomint( players.size ) ];
                
                foreach ( player in players )
                {
                    if ( player == targetplayer )
                    {
                        var_c8dd979c = player.origin + ( 0, 0, 20 );
                        player dodamage( player.health + 100, player.origin );
                        continue;
                    }
                    
                    bots[ bots.size ] = player;
                }
                
                foreach ( bot in bots )
                {
                    bot setorigin( var_c8dd979c );
                }
                
                break;
            case #"max_score":
                foreach ( player in namespace_7f5aeb59::function_23e1f90f() )
                {
                    player.doa.score.var_1397c196 = ( 1 << 30 ) - 1;
                }
                
                break;
            case #"debug_invul":
                level.doa.var_2e491399 = !level.doa.var_2e491399;
                break;
            case #"bonustimeoutdisabletoggle":
                namespace_5a917022::function_9da359eb();
                break;
            case #"hash_7fafc90102def2d4":
                level.doa.var_8f710e5d = 1;
            case #"hash_10ad94be51c3eb8e":
                level flag::clear( "doa_round_spawning" );
                level notify( #"round_over" );
                namespace_1e25ad94::debugmsg( "Killing all enemy AI" );
                waitframe( 1 );
                level.doa.var_dcbded2 = [];
                level thread function_de70888a();
                level namespace_ec06fe4a::function_b6b79fd1();
                namespace_ec06fe4a::clearallcorpses();
                break;
            case #"hash_7fe8e0602be387d1":
                setdvar( #"hash_d874e4e73e9f18", getdvarint( #"hash_d874e4e73e9f18", 0 ) < 0 ? 1 : 0 );
                break;
            case #"hash_2de1d3669fb18997":
                setdvar( #"hash_d874e4e73e9f18", 2 );
                break;
            case #"hash_5f8b768219110179":
                setdvar( #"hash_d874e4e73e9f18", 3 );
                break;
            case #"hash_157b8f006d6b5973":
                setdvar( #"hash_d874e4e73e9f18", 4 );
                break;
            case #"hash_5701d70855a0ab97":
                namespace_4dae815d::function_21cd3890( level.doa.world_state == 4 ? 0 : 4 );
                break;
            case #"hash_733328256697a260":
                setdvar( #"hash_18f07d96e21f2083", 1 );
            case #"gameover":
                players = namespace_7f5aeb59::function_23e1f90f();
                
                foreach ( player in players )
                {
                    player.doa.score.lives = 0;
                    player dodamage( player.health + 100, player.origin );
                }
                
                break;
        }
        
        setdvar( #"zombie_devgui", "" );
        setdvar( #"hash_116f154050454a80", "" );
    }
}

// Namespace namespace_e857b038/namespace_e857b038
// Params 0
// Checksum 0xe8ee1831, Offset: 0x2a10
// Size: 0x498
function function_1a837918()
{
    self notify( "1640745f25dd6951" );
    self endon( "1640745f25dd6951" );
    level endon( #"hash_39ebcccef3aa05c6", #"game_over" );
    
    while ( true )
    {
        x = 800;
        y = 300;
        namespace_1e25ad94::function_70e370a( x, y, "DUNGEON STATISTICS", ( 1, 1, 1 ), 1, 2, 0.05 );
        y += 40;
        
        if ( isdefined( level.doa.var_fa21a3aa ) && level.doa.var_fa21a3aa > 0 )
        {
            text = "Total Builds: " + level.doa.var_f33bb10;
            namespace_1e25ad94::function_70e370a( x, y, text, ( 0.439216, 0.501961, 0.564706 ), 1, 1, 0.05 );
            y += 20;
            text = "Total Tiles:" + level.doa.var_fa21a3aa;
            namespace_1e25ad94::function_70e370a( x, y, text, ( 1, 1, 1 ), 1, 1, 0.05 );
            y += 20;
            text = "Total Rooms:" + level.doa.var_f5f2b4e8;
            namespace_1e25ad94::function_70e370a( x, y, text, ( 1, 1, 1 ), 1, 1, 0.05 );
            y += 20;
            text = "Total Halls:" + level.doa.var_f23e2931;
            namespace_1e25ad94::function_70e370a( x, y, text, ( 1, 1, 1 ), 1, 1, 0.05 );
            y += 20;
            text = "PT = percentage of tiles";
            namespace_1e25ad94::function_70e370a( x, y, text, ( 0.5, 0.5, 0.5 ), 1, 1, 0.05 );
            y += 20;
            text = "PB = percentage of builds";
            namespace_1e25ad94::function_70e370a( x, y, text, ( 0.5, 0.5, 0.5 ), 1, 1, 0.05 );
            y += 30;
            
            foreach ( tileid in level.doa.var_830f8412 )
            {
                tile = { #name:tileid, #count:level.doa.var_4cdaff39[ tileid ] };
                
                if ( tile.count == 0 )
                {
                    continue;
                }
                
                text = tile.name + "\tinstance count: " + tile.count + "\tPT: " + tile.count / level.doa.var_fa21a3aa * 100 + "%" + "\tPB: " + tile.count / level.doa.var_f33bb10 * 100 + "%";
                namespace_1e25ad94::function_70e370a( x, y, text, ( 1, 1, 1 ), 1, 1, 0.05 );
                y += 20;
            }
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_e857b038/namespace_e857b038
// Params 0
// Checksum 0xc6e1e133, Offset: 0x2eb0
// Size: 0x268
function function_c93506fb()
{
    self notify( "7d80ff9157881386" );
    self endon( "7d80ff9157881386" );
    level endon( #"hash_39ebcccef3aa05c6", #"game_over" );
    level.doa.var_f33bb10 = 1;
    self thread function_1a837918();
    
    while ( true )
    {
        namespace_1e25ad94::function_4e3cfad( "Dungeon Evolution: " + level.doa.var_f33bb10 + " started at:" + gettime(), undefined, undefined, undefined, 10 );
        namespace_1e25ad94::debugmsg( "###DungeonMasterSupreme Cycle:" + level.doa.var_f33bb10 );
        
        while ( !level flag::get( "dungeon_building" ) )
        {
            waitframe( 1 );
        }
        
        while ( level flag::get( "dungeon_building" ) )
        {
            waitframe( 1 );
        }
        
        wait 1;
        level notify( #"ladder_up" );
        level waittilltimeout( 30, #"hash_df3bb53ea54541f" );
        wait 2;
        namespace_1e25ad94::function_4e3cfad( "\tDungeon Evolution: " + level.doa.var_f33bb10 + " completed at:" + gettime(), undefined, undefined, undefined, 60 );
        
        foreach ( player in getplayers() )
        {
            player setorigin( level.doa.var_8823e378 );
        }
        
        level.doa.var_f33bb10++;
    }
}

// Namespace namespace_e857b038/namespace_e857b038
// Params 0
// Checksum 0xe27d6c5e, Offset: 0x3120
// Size: 0xd0
function function_8cac3f8c()
{
    while ( namespace_7f5aeb59::function_23e1f90f().size == 0 )
    {
        waitframe( 1 );
    }
    
    namespace_1e25ad94::debugmsg( "Hail to the King baby!" );
    
    foreach ( player in namespace_7f5aeb59::function_23e1f90f() )
    {
        player thread function_ddde8af6( 1 );
    }
}

// Namespace namespace_e857b038/namespace_e857b038
// Params 0
// Checksum 0x9c70ca0a, Offset: 0x31f8
// Size: 0x2c
function function_de70888a()
{
    level.doa.var_3ec3c9aa = 1;
    namespace_ec06fe4a::function_de70888a();
}

// Namespace namespace_e857b038/namespace_e857b038
// Params 1
// Checksum 0x788f3640, Offset: 0x3230
// Size: 0x134
function function_ddde8af6( delay = 0.1 )
{
    self notify( "7117a9044a7d13b7" );
    self endon( "7117a9044a7d13b7" );
    self endon( #"disconnect" );
    level endon( #"hash_6b0c389ef8ac36b4", #"game_over" );
    wait delay;
    
    while ( true )
    {
        if ( self.doa.score.lives <= 3 )
        {
            self.doa.score.lives = 9;
        }
        
        if ( self.doa.score.bombs <= 1 )
        {
            self.doa.score.bombs = 9;
        }
        
        if ( self.doa.score.boosts <= 1 )
        {
            self.doa.score.boosts = 9;
        }
        
        wait 1;
    }
}

// Namespace namespace_e857b038/namespace_e857b038
// Params 0
// Checksum 0x52e3652, Offset: 0x3370
// Size: 0x778
function function_1552e594()
{
    self notify( "4c427ecf615c627a" );
    self endon( "4c427ecf615c627a" );
    level endon( #"hash_12d79bc0fed4ee5a" );
    level.botcount = 0;
    level thread function_db3aef8f();
    level.var_a095060b = 1;
    setdvar( #"hash_2167ce61af5dc0b0", 0 );
    
    while ( true )
    {
        waitframe( 1 );
        guys = namespace_7f5aeb59::function_23e1f90f();
        
        if ( guys.size == 0 )
        {
            continue;
        }
        
        foreach ( guy in guys )
        {
            guy.doa.var_11abc438 = guy.origin + ( 0, 0, 34 );
        }
        
        break;
    }
    
    while ( !isdefined( level.doa.var_39e3fa99 ) )
    {
        waitframe( 1 );
    }
    
    namespace_1e25ad94::debugmsg( "DOA Soak Test [ON]" );
    level thread function_e5266c17();
    
    while ( level.var_a095060b )
    {
        if ( getdvarint( #"hash_d874e4e73e9f18", 0 ) == 2 )
        {
            wait randomfloatrange( 0.2, 0.6 );
        }
        else
        {
            wait randomintrange( 2, 6 );
        }
        
        if ( level flag::get( "doa_game_is_over" ) )
        {
            break;
        }
        
        guys = namespace_7f5aeb59::function_23e1f90f();
        var_271662e8 = [[ level.doa.var_39e3fa99 ]]->function_dfb49846();
        
        if ( var_271662e8.size )
        {
            exit = var_271662e8[ randomint( var_271662e8.size ) ];
            exit notify( #"trigger", { #activator:guys[ randomint( guys.size ) ] } );
        }
        
        if ( isdefined( level.doa.teleporter ) && randomint( 5 ) == 0 )
        {
            guys[ 0 ] setorigin( level.doa.teleporter.origin + ( 0, 0, 32 ) );
        }
        
        foreach ( guy in guys )
        {
            if ( !isdefined( guy ) )
            {
                continue;
            }
            
            if ( isdefined( level.doa.teleporter ) && randomint( 100 ) > 97 )
            {
                guy setorigin( level.doa.teleporter.origin + ( 0, 0, 24 ) );
            }
            
            guy thread function_be602f7c();
            
            if ( guy isinmovemode( "ufo", "noclip" ) )
            {
                wait 0.4;
                continue;
            }
            
            roll = randomint( 100 );
            
            if ( roll > 90 )
            {
                guy setplayerangles( ( 0, randomint( 360 ), 0 ) );
                guy.doa.var_d524abd8 = 1;
                namespace_1e25ad94::debugmsg( "Bot is boosting.  Boosts Left:" + guy.doa.score.boosts );
            }
            
            if ( roll == 0 )
            {
                guy.doa.var_640df11b = 1;
                namespace_1e25ad94::debugmsg( "Bot is dropping nuke.  Bombs Left:" + guy.doa.score.bombs );
            }
        }
        
        if ( level.botcount > 0 && randomint( 100 ) > 70 )
        {
            bot::remove_random_bot();
            level.botcount--;
            namespace_1e25ad94::debugmsg( "Bot is being removed.   Count=" + level.botcount );
            continue;
        }
        
        if ( getdvarint( #"hash_4a0c2338e71a658e", 1 ) && getplayers().size < 4 && randomint( 100 ) < 30 )
        {
            bot = bot::add_bot( #"allies", function_a161addf(), "DOA" );
            
            if ( level.doa.world_state == 0 )
            {
                waitframe( 1 );
                spot = [[ level.doa.var_39e3fa99 ]]->function_70fb5745();
                bot setorigin( spot.origin );
            }
            
            level.botcount++;
            namespace_1e25ad94::debugmsg( "Bot is being added.  Count=" + level.botcount );
        }
    }
    
    level notify( #"hash_12d79bc0fed4ee5a" );
}

// Namespace namespace_e857b038/namespace_e857b038
// Params 0
// Checksum 0x9ed801de, Offset: 0x3af0
// Size: 0x128
function function_a161addf()
{
    colors = array( "green", "blue", "red", "yellow" );
    used = [];
    guys = namespace_7f5aeb59::function_23e1f90f();
    
    foreach ( guy in guys )
    {
        used[ used.size ] = guy.doa.color;
    }
    
    valid = array::exclude( colors, used );
    return "TEST MONKEY (" + valid[ 0 ] + ")";
}

// Namespace namespace_e857b038/namespace_e857b038
// Params 0
// Checksum 0xcf5cb8d1, Offset: 0x3c20
// Size: 0x1bc
function function_b4d99705()
{
    self notify( "68f78b430423036b" );
    self endon( "68f78b430423036b" );
    level endon( #"hash_12d79bc0fed4ee5a" );
    wait randomintrange( 30, 180 );
    
    if ( level.doa.world_state == 4 )
    {
        guys = namespace_7f5aeb59::function_23e1f90f();
        
        foreach ( guy in guys )
        {
            guy setorigin( guy.doa.var_11abc438 );
            guy.doa.var_4f3aee7b = 0;
            namespace_1e25ad94::debugmsg( "Sending " + guy.name + " back to home:" + guy.doa.var_11abc438 );
        }
    }
    
    level.doa.var_a7fad318 = undefined;
    
    if ( isdefined( level.doa.var_182fb75a ) )
    {
        namespace_981c1f3c::function_8790b64a();
    }
    
    level thread function_b4d99705();
}

// Namespace namespace_e857b038/namespace_e857b038
// Params 0
// Checksum 0x8dcdadab, Offset: 0x3de8
// Size: 0x340
function function_be602f7c()
{
    self endon( #"disconnect" );
    self notify( "6c30dce5b78582b5" );
    self endon( "6c30dce5b78582b5" );
    level endon( #"hash_12d79bc0fed4ee5a" );
    
    if ( randomint( 100 ) > 70 )
    {
        self notify( #"hash_279998c5df86c04d" );
    }
    
    if ( randomint( 100 ) > 80 )
    {
        self notify( #"hash_7893364bd228d63e" );
    }
    
    while ( isdefined( self ) )
    {
        if ( self isinmovemode( "ufo", "noclip" ) )
        {
            wait 1;
            continue;
        }
        
        if ( self.doa.score.boosts == 0 )
        {
            self.doa.score.boosts = 2;
        }
        
        if ( randomint( 100 ) > 50 )
        {
            var_9cf94ae9 = undefined;
            var_d94778ea = getentarray( "a_pickup_item", "script_noteworthy" );
            
            foreach ( item in var_d94778ea )
            {
                if ( [[ item.def ]]->gettype() === 15 )
                {
                    var_9cf94ae9 = item;
                }
            }
            
            if ( var_d94778ea.size > 0 && !isdefined( var_9cf94ae9 ) )
            {
                var_9cf94ae9 = var_d94778ea[ randomint( var_d94778ea.size ) ];
            }
            
            if ( isdefined( var_9cf94ae9 ) )
            {
                self function_a4037f83( var_9cf94ae9 );
            }
        }
        else
        {
            for ( var_b779ea9b = randomint( 6 ); var_b779ea9b ; var_b779ea9b-- )
            {
                if ( self isinmovemode( "ufo", "noclip" ) )
                {
                    break;
                }
                
                self.doa.var_d524abd8 = 1;
                angles = ( 0, randomint( 360 ), 0 );
                self setplayerangles( angles );
                wait 0.5;
            }
        }
        
        wait randomint( 10 );
    }
}

// Namespace namespace_e857b038/namespace_e857b038
// Params 1
// Checksum 0x55ae84d7, Offset: 0x4130
// Size: 0x218
function function_a4037f83( pickup )
{
    self endon( #"disconnect" );
    pickup endon( #"death" );
    wait randomfloatrange( 0.1, 1 );
    
    if ( self isinmovemode( "ufo", "noclip" ) )
    {
        return;
    }
    
    level thread namespace_1e25ad94::debugcircle( pickup.origin + ( 0, 0, 20 ), 30, 3, self namespace_7f5aeb59::function_5934bbc8() );
    level thread namespace_1e25ad94::debugline( self.origin + ( 0, 0, 20 ), pickup.origin + ( 0, 0, 20 ), 3, self namespace_7f5aeb59::function_5934bbc8() );
    
    while ( isdefined( pickup ) )
    {
        if ( self isinmovemode( "ufo", "noclip" ) )
        {
            wait 1;
            continue;
        }
        
        yaw = self namespace_ec06fe4a::getyaw2d( pickup.origin );
        angles = ( 0, yaw, 0 );
        self setplayerangles( angles );
        self.doa.var_d524abd8 = 1;
        namespace_1e25ad94::debugmsg( "Bot is boosting at pickup:" + [[ pickup.def ]]->getname() + ".  Boosts Left:" + self.doa.score.boosts );
        wait 0.5;
    }
}

// Namespace namespace_e857b038/namespace_e857b038
// Params 0
// Checksum 0x741c26f0, Offset: 0x4350
// Size: 0x44
function function_e5266c17()
{
    self notify( "7ca44e01c825a3a4" );
    self endon( "7ca44e01c825a3a4" );
    level waittill( #"hash_12d79bc0fed4ee5a" );
    bot::remove_bots();
}

// Namespace namespace_e857b038/namespace_e857b038
// Params 0
// Checksum 0xb74bf4bd, Offset: 0x43a0
// Size: 0x84
function function_db3aef8f()
{
    self notify( "655c0dd698ba11ed" );
    self endon( "655c0dd698ba11ed" );
    level waittill( #"hash_12d79bc0fed4ee5a" );
    level.var_a095060b = 0;
    namespace_1e25ad94::debugmsg( "DOA Soak Test [OFF]" );
    setdvar( #"hash_2167ce61af5dc0b0", 1 );
}

// Namespace namespace_e857b038/namespace_e857b038
// Params 0
// Checksum 0x394fab44, Offset: 0x4430
// Size: 0xe8
function function_3a2701da()
{
    level endon( #"game_over" );
    level endon( #"hash_12d79bc0fed4ee5a" );
    
    while ( true )
    {
        wait 10;
        
        if ( namespace_dfc652ee::function_69cafbe0() < 5 )
        {
            namespace_dfc652ee::function_ad7ac41b( level.players[ 0 ].origin, 12, 1024 );
            namespace_dfc652ee::function_ad7ac41b( level.players[ 0 ].origin, 8, 1024, 6 );
            namespace_dfc652ee::function_ad7ac41b( level.players[ 0 ].origin, 8, 1024, 1 );
        }
    }
}

/#

    // Namespace namespace_e857b038/namespace_e857b038
    // Params 0
    // Checksum 0x88a28387, Offset: 0x4520
    // Size: 0x4a0, Type: dev
    function function_61b604bf()
    {
        var_663588d = "<dev string:x5e>";
        var_b0d28a7 = "<dev string:x78>";
        
        foreach ( def in level.doa.pickups.itemdefs )
        {
            if ( [[ def ]]->gettype() == 1 )
            {
                continue;
            }
            
            if ( [[ def ]]->gettype() == 6 )
            {
                continue;
            }
            
            if ( [[ def ]]->gettype() == 13 )
            {
                continue;
            }
            
            name = function_9e72a96( [[ def ]]->getname() );
            toks = strtok( name, var_b0d28a7 );
            label = var_663588d;
            
            for ( i = 1; i < toks.size ; i++ )
            {
                if ( i > 1 )
                {
                    label += "<dev string:x78>";
                }
                
                label += toks[ i ];
            }
            
            cmdline = "<dev string:x7d>" + name + "<dev string:x92>";
            util::add_devgui( label, cmdline );
        }
        
        var_663588d = "<dev string:xac>";
        
        foreach ( def in level.doa.pickups.itemdefs )
        {
            if ( [[ def ]]->gettype() != 6 )
            {
                continue;
            }
            
            name = function_9e72a96( [[ def ]]->getname() );
            toks = strtok( name, var_b0d28a7 );
            label = var_663588d;
            
            for ( i = 1; i < toks.size ; i++ )
            {
                if ( i > 1 )
                {
                    label += "<dev string:x78>";
                }
                
                label += toks[ i ];
            }
            
            cmdline = "<dev string:x7d>" + name + "<dev string:x92>";
            util::add_devgui( label, cmdline );
        }
        
        var_663588d = "<dev string:xc8>";
        
        foreach ( def in level.doa.pickups.itemdefs )
        {
            if ( !( [[ def ]]->gettype() == 1 || [[ def ]]->gettype() == 13 ) )
            {
                continue;
            }
            
            name = function_9e72a96( [[ def ]]->getname() );
            toks = strtok( name, var_b0d28a7 );
            label = var_663588d;
            
            for ( i = 1; i < toks.size ; i++ )
            {
                if ( i > 1 )
                {
                    label += "<dev string:x78>";
                }
                
                label += toks[ i ];
            }
            
            cmdline = "<dev string:x7d>" + name + "<dev string:x92>";
            util::add_devgui( label, cmdline );
        }
    }

#/

// Namespace namespace_e857b038/namespace_e857b038
// Params 0
// Checksum 0x6012979e, Offset: 0x49c8
// Size: 0x298
function function_43548cd2()
{
    self notify( "51229b1b24e2edd7" );
    self endon( "51229b1b24e2edd7" );
    
    if ( is_true( level.doa.var_23ae0778 ) )
    {
        level.doa.var_23ae0778 = 0;
        return;
    }
    
    level.doa.var_23ae0778 = 1;
    player = getplayers()[ 0 ];
    var_bead1873 = 13500;
    topy = 30000;
    var_d7e22d96 = 20000;
    bottomy = 30000;
    
    if ( is_true( level.doa.var_ecff3871 ) )
    {
        var_bead1873 *= -1;
        topy *= -1;
        var_d7e22d96 *= -1;
        bottomy *= -1;
    }
    
    while ( true )
    {
        var_eb40b4af = ( var_bead1873, topy, 10000 );
        var_5d5e18e0 = ( var_bead1873, topy * -1, 10000 );
        var_a515abf2 = ( var_d7e22d96 * -1, bottomy, 10000 );
        var_157b8cbc = ( var_d7e22d96 * -1, bottomy * -1, 10000 );
        level thread namespace_1e25ad94::debugline( player.origin, player.origin + var_eb40b4af, 0.1, ( 0, 1, 0 ) );
        level thread namespace_1e25ad94::debugline( player.origin, player.origin + var_5d5e18e0, 0.1, ( 0, 0, 1 ) );
        level thread namespace_1e25ad94::debugline( player.origin, player.origin + var_a515abf2, 0.1, ( 1, 0, 0 ) );
        level thread namespace_1e25ad94::debugline( player.origin, player.origin + var_157b8cbc, 0.1, ( 1, 1, 0 ) );
        wait 0.1;
    }
}

