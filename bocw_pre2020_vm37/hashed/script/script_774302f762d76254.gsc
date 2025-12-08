#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ce46999727f2f2b;
#using script_1ee011cd0961afd7;
#using script_2474a362752098d2;
#using script_2a5bf5b4a00cee0d;
#using script_350cffecd05ef6cf;
#using script_36fc02e86719d0f5;
#using script_3faf478d5b0850fe;
#using script_40f967ad5d18ea74;
#using script_413ab8fe25a61c50;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_4d8045dbc17aa3ee;
#using script_50fca1a24ae351;
#using script_5549681e1669c11a;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_634ae70c663d1cc9;
#using script_68cdf0ca5df5e;
#using script_6991584fc21f5ae8;
#using script_6b6510e124bad778;
#using script_74a56359b7d02ab6;
#using script_f25df01962c79c6;
#using script_f38dc50f0e82277;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\gametypes\globallogic;

#namespace namespace_4dae815d;

// Namespace namespace_4dae815d/namespace_4dae815d
// Params 0
// Checksum 0x1bf4d960, Offset: 0x390
// Size: 0x35c
function init()
{
    level.var_43cd3fe5 = doa_keytrade::register();
    level.doa = spawnstruct();
    level.doa.var_cf250523 = &doa_player::callback_playerkilled;
    level.doa.var_abe40be4 = &doa_player::callback_playerdamage;
    level.doa.var_cd10d20a = &doa_player::function_c0e6e008;
    level.doa.var_16a35e94 = &namespace_7f5aeb59::function_ebcb2cca;
    level.doa.var_abd5eb1e = &function_d41688e3;
    level.doa.var_99ee4341 = &function_ce7e12de;
    level.doa.var_3bc55386 = &namespace_6e90e490::function_3332c6a1;
    level.doa.var_d0b39b1a = &namespace_eccff4fb::initplayer;
    clientfield::register( "world", "world_state", 1, 3, "int" );
    clientfield::register( "world", "doafps", 1, 1, "int" );
    clientfield::register( "world", "roundNumber", 1, 10, "int" );
    clientfield::function_5b7d846d( "DOA_GLOBALUIMODEL_WORLDSTATE", 1, 3, "int" );
    clientfield::function_5b7d846d( "DOA_GLOBALUIMODEL_COUNTDOWN", 1, 5, "int" );
    clientfield::function_5b7d846d( "DOA_GLOBALUIMODEL_ARENANUMBER", 1, 4, "int" );
    mapcenter = struct::get( "map_center", "targetname" );
    
    if ( isdefined( mapcenter ) )
    {
        level.mapcenter = mapcenter.origin;
    }
    else
    {
        level.mapcenter = ( 0, 0, 0 );
    }
    
    setmapcenter( level.mapcenter );
    
    if ( !isdefined( level.doa ) )
    {
        level.doa = spawnstruct();
    }
    
    level.doa.doa_bundle = getscriptbundle( "doa_bundle" );
    level thread function_32d5e898();
    level thread function_170b90e5();
    callback::add_callback( #"menu_response", &on_menu_response );
}

// Namespace namespace_4dae815d/namespace_4dae815d
// Params 1, eflags: 0x4
// Checksum 0x169559f1, Offset: 0x6f8
// Size: 0x212
function private on_menu_response( eventstruct )
{
    if ( eventstruct.response == "endround" )
    {
        if ( !is_true( level.gameended ) )
        {
            self globallogic::gamehistoryplayerquit();
            self closeingamemenu();
            level.host_ended_game = 1;
        }
        else
        {
            self closeingamemenu();
        }
        
        level notify( #"end_game" );
        level flag::set( "doa_game_is_over" );
        level notify( #"game_over" );
        namespace_ec06fe4a::function_445bad70();
        level thread namespace_ec06fe4a::function_de70888a();
        level notify( #"hash_7893364bd228d63e" );
        function_21cd3890( 1 );
        level doa_banner::function_7a0e5387( 1 );
        wait 10;
        level namespace_7f5aeb59::function_67f054d7( 1 );
        wait 1.5;
        exitlevel( 0 );
        wait 666;
    }
    
    players = getplayers();
    
    foreach ( player in players )
    {
    }
}

// Namespace namespace_4dae815d/namespace_4dae815d
// Params 0
// Checksum 0xff7bbfcb, Offset: 0x918
// Size: 0x168
function function_32d5e898()
{
    level.doa.world_state = 0;
    level.doa.roundnumber = 1;
    level.doa.var_6c58d51 = 0;
    level.doa.game_duration = 0;
    level.doa.var_8be900a6 = undefined;
    level.doa.var_848746c8 = undefined;
    level.doa.var_a77e6349 = undefined;
    level.doa.var_1f2c7d5f = undefined;
    level.var_9fa19717 = undefined;
    level.doa.var_a3e53b88 = undefined;
    level.doa.var_8f710e5d = undefined;
    level flag::clear( "doa_game_is_over" );
    level flag::clear( "doa_round_paused" );
    level flag::clear( "doa_round_spawning" );
    level flag::clear( "doa_players_all_dead" );
    level flag::clear( "doa_rof_visited" );
    level.var_68de7e10 = 0;
}

// Namespace namespace_4dae815d/namespace_4dae815d
// Params 0
// Checksum 0xd1ee28a8, Offset: 0xa88
// Size: 0x324
function function_170b90e5()
{
    if ( !isdefined( level.flag ) || !is_true( level.flag[ #"load_main_complete" ] ) )
    {
        level waittill( #"load_main_complete" );
    }
    
    settopdowncamerayaw( 0 );
    setdvar( #"compassmaxrange", 2100 );
    level flag::init( "doa_game_initialized", 0 );
    level flag::init( "doa_game_is_over", 0 );
    level flag::init( "doa_players_all_dead", 0 );
    level flag::init( "doa_round_paused", 0 );
    level flag::init( "doa_round_spawning", 0 );
    level flag::init( "doa_rof_visited", 0 );
    namespace_8c04284b::init();
    namespace_77eccc4f::init();
    doa_banner::init();
    namespace_5a917022::init();
    namespace_1e25ad94::init();
    namespace_41cb996::init();
    doa_enemy::init();
    namespace_1c2a96f9::init();
    namespace_83eb6304::init();
    namespace_ed80aead::init();
    namespace_268747c0::init();
    namespace_6e90e490::init();
    namespace_b7d49cfd::init();
    namespace_dfc652ee::init();
    doa_player::init();
    namespace_eccff4fb::init();
    namespace_e32bb68::init();
    namespace_9fc66ac::init();
    namespace_c85a46fe::init();
    doa_wild::init();
    namespace_491fa2b2::init();
    level thread namespace_981c1f3c::init();
    level thread namespace_e857b038::init();
    level flag::set( "doa_game_initialized" );
    level.doa.var_be74bf2c = 0;
    waitframe( 1 );
    game_reset();
}

// Namespace namespace_4dae815d/namespace_4dae815d
// Params 1
// Checksum 0x4293d9f5, Offset: 0xdb8
// Size: 0x7c
function function_e22d3978( number = level.doa.roundnumber )
{
    level.doa.roundnumber = number;
    level clientfield::set( "roundNumber", level.doa.roundnumber );
    namespace_9fc66ac::function_2fc07d61();
}

// Namespace namespace_4dae815d/namespace_4dae815d
// Params 0
// Checksum 0x4dcb43b0, Offset: 0xe40
// Size: 0x16
function function_59a9cf1d()
{
    return level.doa.world_state;
}

// Namespace namespace_4dae815d/namespace_4dae815d
// Params 1
// Checksum 0xc761c7a0, Offset: 0xe60
// Size: 0x104
function function_21cd3890( state )
{
    laststate = level.doa.world_state;
    level.doa.world_state = state;
    level clientfield::set( "world_state", level.doa.world_state );
    level clientfield::set_world_uimodel( "DOA_GLOBALUIMODEL_WORLDSTATE", level.doa.world_state );
    setsaveddvar( #"hash_2d5b0d6d4ce995d7", state == 4 );
    namespace_9fc66ac::function_65fcd877();
    level notify( #"hash_460213205489abb4", { #state:state } );
    return laststate;
}

// Namespace namespace_4dae815d/namespace_4dae815d
// Params 0
// Checksum 0xb6c3fa3c, Offset: 0xf70
// Size: 0x254
function game_reset()
{
    if ( level.doa.var_be74bf2c > 0 )
    {
        namespace_1e25ad94::debugmsg( "DOA Game Reset:" + level.doa.var_be74bf2c );
    }
    
    level notify( #"game_reset" );
    level.doa.var_c420eee9 = 1;
    level.doa.var_be74bf2c++;
    function_32d5e898();
    level thread function_8682e93e();
    namespace_dfc652ee::function_18372b20();
    namespace_491fa2b2::main();
    namespace_ec06fe4a::function_de70888a();
    namespace_ec06fe4a::clearallcorpses();
    function_21cd3890( 0 );
    function_e22d3978();
    doa_banner::function_7a0e5387();
    level clientfield::set( "flipCamera", 0 );
    level namespace_77eccc4f::main();
    level thread namespace_981c1f3c::main();
    level thread namespace_6e90e490::function_db945ce9();
    level thread doa_player::main();
    level thread namespace_8c04284b::main();
    level thread doa_enemy::main();
    level thread namespace_1c2a96f9::main();
    level thread doa_wild::main();
    level thread namespace_268747c0::main();
    level thread namespace_5a917022::main();
    level thread main();
}

// Namespace namespace_4dae815d/namespace_4dae815d
// Params 0
// Checksum 0x38cbc93b, Offset: 0x11d0
// Size: 0x36c
function main()
{
    self notify( "4652d67484e0c1b7" );
    self endon( "4652d67484e0c1b7" );
    level flag::wait_till( "all_players_connected" );
    level thread namespace_7f5aeb59::function_67f054d7( 0.1 );
    level waittill( #"hash_1b322de3d2e3e781" );
    
    while ( level flag::get( "gameplay_started" ) == 0 )
    {
        waitframe( 1 );
    }
    
    level notify( #"hash_671684f03a58b3a3" );
    var_8d747a1 = 1;
    level.doa.var_c420eee9 = 0;
    
    while ( var_8d747a1 )
    {
        waitframe( 1 );
        level notify( #"hash_76eb5274e6de5301" );
        var_8d747a1 = !level flag::get( "doa_players_all_dead" );
        
        if ( !var_8d747a1 )
        {
            result = undefined;
            
            if ( !is_true( level.doa.var_8be900a6 ) )
            {
                result = function_a511c7c4();
            }
            
            if ( isdefined( result ) )
            {
                var_8d747a1 = result;
                
                if ( result )
                {
                    level flag::clear( "doa_players_all_dead" );
                }
            }
        }
    }
    
    player = getplayers()[ 0 ];
    
    if ( isdefined( player ) && level.var_43cd3fe5 doa_keytrade::is_open( player ) )
    {
        level.var_43cd3fe5 doa_keytrade::close();
    }
    
    level flag::set( "doa_game_is_over" );
    level notify( #"game_over" );
    function_21cd3890( 1 );
    
    foreach ( player in getplayers() )
    {
        player.doa.respawning = 0;
        player namespace_6e90e490::updatehud();
    }
    
    level namespace_eccff4fb::function_47498d07();
    
    if ( isdefined( level.doa.var_99ee4341 ) )
    {
        level thread [[ level.doa.var_99ee4341 ]]();
        level waittill( #"hash_659967997e5f426e" );
    }
    else
    {
        wait 15;
    }
    
    level thread game_reset();
}

// Namespace namespace_4dae815d/namespace_4dae815d
// Params 0
// Checksum 0xe72a4ff1, Offset: 0x1548
// Size: 0x24
function function_d41688e3()
{
    level flag::set( "doa_players_all_dead" );
}

// Namespace namespace_4dae815d/namespace_4dae815d
// Params 0
// Checksum 0x4076b07e, Offset: 0x1578
// Size: 0xd8
function function_ce7e12de()
{
    namespace_ec06fe4a::function_445bad70();
    level thread namespace_ec06fe4a::function_de70888a();
    level notify( #"hash_7893364bd228d63e" );
    
    if ( isdefined( level.doa.var_cb342cbc ) )
    {
        level [[ level.doa.var_cb342cbc ]]();
    }
    
    function_21cd3890( 1 );
    level doa_banner::function_7a0e5387( 1 );
    wait 10;
    level namespace_7f5aeb59::function_67f054d7( 1 );
    level notify( #"hash_659967997e5f426e" );
}

// Namespace namespace_4dae815d/namespace_4dae815d
// Params 0
// Checksum 0x4c2b815c, Offset: 0x1658
// Size: 0x398, Type: bool
function function_a511c7c4()
{
    players = namespace_7f5aeb59::function_23e1f90f();
    
    if ( players.size > 1 )
    {
        return false;
    }
    
    player = players[ 0 ];
    
    if ( !isdefined( player ) || !isdefined( player.doa ) || player.doa.score.keys <= 0 )
    {
        return false;
    }
    
    if ( function_59a9cf1d() != 0 )
    {
        return false;
    }
    
    player endon( #"disconnect" );
    player.doa.respawning = 0;
    player namespace_6e90e490::updatehud();
    var_4b98f072 = spawnstruct();
    var_4b98f072.var_917afa01 = 0;
    var_4b98f072.result = 0;
    var_4b98f072.timeleft = 15;
    var_4b98f072.var_5b55ba1f = function_21cd3890( 2 );
    level flag::set( "doa_round_paused" );
    namespace_ec06fe4a::function_de70888a();
    namespace_ec06fe4a::function_b6b79fd1();
    
    if ( !level.var_43cd3fe5 doa_keytrade::is_open( player ) )
    {
        while ( isdefined( player.doa.infps ) )
        {
            waitframe( 1 );
        }
        
        util::wait_network_frame( 3 );
        level.var_43cd3fe5 doa_keytrade::open( player, 1 );
    }
    
    player thread function_295c3381( var_4b98f072 );
    
    while ( var_4b98f072.timeleft > 0 )
    {
        level clientfield::set_world_uimodel( "DOA_GLOBALUIMODEL_COUNTDOWN", var_4b98f072.timeleft );
        wait 1;
        var_4b98f072.timeleft -= 1;
    }
    
    level.var_43cd3fe5 doa_keytrade::close( player );
    level notify( #"hash_47730e778d03543b" );
    
    if ( var_4b98f072.result )
    {
        player stats::inc_stat( #"doastats", #"keys", var_4b98f072.var_917afa01 * -1 );
        uploadstats( player );
        level.doa.var_8be900a6 = 1;
        function_21cd3890( var_4b98f072.var_5b55ba1f );
    }
    
    player clientfield::increment_to_player( "controlBinding" );
    level flag::clear( "doa_round_paused" );
    return var_4b98f072.result && player.doa.score.lives > 0;
}

// Namespace namespace_4dae815d/namespace_4dae815d
// Params 1
// Checksum 0x257ec54d, Offset: 0x19f8
// Size: 0x40c
function function_295c3381( var_4b98f072 )
{
    level endon( #"hash_47730e778d03543b" );
    self endon( #"disconnect" );
    var_7ce1e87 = 0;
    var_44294245 = 0;
    var_4b98f072.result = 0;
    
    while ( true )
    {
        if ( self.doa.score.lives > 0 && self.doa.score.keys > 0 )
        {
            level.var_43cd3fe5 doa_keytrade::function_8a6595db( self, hash( #"hash_66f6e25631ff2352" ) );
        }
        else if ( self.doa.score.keys > 0 )
        {
            level.var_43cd3fe5 doa_keytrade::function_8a6595db( self, hash( #"hash_1c0a5279bafa7779" ) );
        }
        else
        {
            level.var_43cd3fe5 doa_keytrade::function_8a6595db( self, hash( #"hash_305f779ad154229" ) );
        }
        
        if ( self.doa.score.lives > 0 )
        {
            level.var_43cd3fe5 doa_keytrade::function_3ae8b40f( self, hash( #"hash_344d11efdbb3a755" ) );
        }
        else
        {
            level.var_43cd3fe5 doa_keytrade::function_3ae8b40f( self, hash( "" ) );
        }
        
        if ( self stancebuttonpressed() )
        {
            var_4b98f072.result = 0;
            var_4b98f072.timeleft = 0;
            return;
        }
        
        if ( self usebuttonpressed() && self.doa.score.lives > 0 )
        {
            var_4b98f072.result = 1;
            var_4b98f072.timeleft = 0;
            return;
        }
        
        if ( self secondaryoffhandbuttonpressed() )
        {
            var_7ce1e87 = 1;
        }
        else
        {
            if ( var_7ce1e87 )
            {
                if ( self.doa.score.lives > 0 )
                {
                    self.doa.score.lives--;
                    var_4b98f072.var_917afa01--;
                    self.doa.score.keys++;
                    self namespace_6e90e490::updatehud();
                }
            }
            
            var_7ce1e87 = 0;
        }
        
        if ( self fragbuttonpressed() )
        {
            var_44294245 = 1;
        }
        else
        {
            if ( var_44294245 )
            {
                if ( self.doa.score.keys > 0 && self.doa.score.lives < 3 )
                {
                    self.doa.score.lives++;
                    var_4b98f072.var_917afa01++;
                    self.doa.score.keys--;
                    self namespace_6e90e490::updatehud();
                }
            }
            
            var_44294245 = 0;
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_4dae815d/namespace_4dae815d
// Params 0
// Checksum 0x9b7b867e, Offset: 0x1e10
// Size: 0xec
function function_8682e93e()
{
    self notify( "5223886c201f2d5c" );
    self endon( "5223886c201f2d5c" );
    
    if ( level flag::get( "doa_rof_visited" ) )
    {
        return;
    }
    
    result = level waittill( #"hash_77a8f97f2648672" );
    
    if ( result.name != "jungle_1" )
    {
        level thread function_8682e93e();
    }
    
    level thread namespace_1c2a96f9::function_11463552();
    level waittill( #"hash_325440d5433be263", #"game_over" );
    level thread function_8682e93e();
}

