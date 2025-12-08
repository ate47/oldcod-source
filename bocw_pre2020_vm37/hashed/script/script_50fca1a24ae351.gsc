#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ce46999727f2f2b;
#using script_1ee011cd0961afd7;
#using script_2474a362752098d2;
#using script_2a5bf5b4a00cee0d;
#using script_2e9202713de2b353;
#using script_40f967ad5d18ea74;
#using script_41fbdfb1149a433e;
#using script_47851dbeea22fe66;
#using script_48e04a393ec6d855;
#using script_4d748e58ce25b60c;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_6ad6653eed415ffc;
#using script_6b6510e124bad778;
#using script_73ad7687b437e468;
#using script_746267f0669c40ae;
#using script_74a56359b7d02ab6;
#using script_774302f762d76254;
#using script_dc59353021baee1;
#using script_f38dc50f0e82277;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_981c1f3c;

// Namespace namespace_981c1f3c/namespace_981c1f3c
// Params 0
// Checksum 0xb37c7f4a, Offset: 0x468
// Size: 0x17c
function init()
{
    level.doa.var_43cb2d40 = [];
    level.doa.teleporter_locs = [];
    level.doa.var_a8a563fc = [];
    level.doa.var_783e7439 = [];
    level flag::init( "dungeon_building", 0 );
    clientfield::register( "world", "world_dungeon_set", 1, 8, "int" );
    clientfield::register( "world", "world_dungeon_build", 1, 1, "counter" );
    clientfield::register( "world", "world_dungeon_destroy", 1, 1, "counter" );
    level.var_3dd67d2d = &function_c153f40;
    namespace_c9c45ed8::init();
    namespace_5849a337::init();
    namespace_22574328::init();
    namespace_40bb01c9::init();
    namespace_1dc364c0::init();
    main();
}

// Namespace namespace_981c1f3c/namespace_981c1f3c
// Params 0
// Checksum 0xcfe33682, Offset: 0x5f0
// Size: 0x420
function main()
{
    if ( isdefined( level.doa.var_182fb75a ) )
    {
        level thread function_8790b64a();
    }
    
    foreach ( topper in level.doa.var_43cb2d40 )
    {
        topper delete();
    }
    
    level.doa.var_43cb2d40 = [];
    level.doa.var_c93506fb = undefined;
    level.doa.var_eeff50c8 = getentarray( "dungeon_generator", "targetname" );
    
    foreach ( trigger in level.doa.var_eeff50c8 )
    {
        idx = function_61e1a1cb( trigger.target );
        level.doa.dungeons[ idx ].var_9105f204 = array( level.doa.var_65a70dc );
        
        if ( isdefined( trigger.script_parameters ) )
        {
            fodder = strtok( trigger.script_parameters, ";" );
            
            foreach ( ai in fodder )
            {
                if ( !isdefined( level.doa.dungeons[ idx ].var_9105f204 ) )
                {
                    level.doa.dungeons[ idx ].var_9105f204 = [];
                }
                else if ( !isarray( level.doa.dungeons[ idx ].var_9105f204 ) )
                {
                    level.doa.dungeons[ idx ].var_9105f204 = array( level.doa.dungeons[ idx ].var_9105f204 );
                }
                
                level.doa.dungeons[ idx ].var_9105f204[ level.doa.dungeons[ idx ].var_9105f204.size ] = doa_enemy::function_d7c5adee( ai );
            }
        }
        
        level.doa.dungeons[ idx ].var_40ca2d09 = array( doa_enemy::function_d7c5adee( "meatball_large" ) );
        trigger thread function_ec0b503f( trigger.target );
    }
}

// Namespace namespace_981c1f3c/namespace_981c1f3c
// Params 2
// Checksum 0x28855e5a, Offset: 0xa18
// Size: 0x108
function function_470f56e6( origin, ignore )
{
    foreach ( player in namespace_7f5aeb59::function_23e1f90f() )
    {
        if ( player === ignore )
        {
            continue;
        }
        
        if ( !isalive( player ) || is_true( player.doa.respawning ) )
        {
            player namespace_7f5aeb59::function_513831e1();
        }
        
        player setorigin( origin );
    }
}

// Namespace namespace_981c1f3c/namespace_981c1f3c
// Params 0
// Checksum 0x9e7ff9b2, Offset: 0xb28
// Size: 0x174
function function_ece96728()
{
    self endon( #"death" );
    level endon( #"game_over" );
    self notify( "5bd10086419eff4d" );
    self endon( "5bd10086419eff4d" );
    idx = function_61e1a1cb( self.target );
    
    while ( true )
    {
        result = self waittill( #"trigger" );
        
        if ( level.doa.var_182fb75a !== idx )
        {
            continue;
        }
        
        level thread function_470f56e6( self.origin, result.activator );
        result.activator notify( #"hash_279998c5df86c04d" );
        result.activator thread namespace_7f5aeb59::turnplayershieldon();
        
        if ( level.doa.dungeons[ idx ].policy == 0 )
        {
            result.activator notify( #"hash_7893364bd228d63e" );
        }
        
        result.activator clientfield::increment_to_player( "controlBinding" );
        break;
    }
}

// Namespace namespace_981c1f3c/namespace_981c1f3c
// Params 1
// Checksum 0xdbc4425b, Offset: 0xca8
// Size: 0x568
function function_ec0b503f( var_499e2f80 )
{
    self endon( #"death" );
    level endon( #"game_over" );
    self notify( "128948e830fff145" );
    self endon( "128948e830fff145" );
    self thread function_ece96728();
    idx = function_61e1a1cb( var_499e2f80 );
    assert( isdefined( idx ), "<dev string:x38>" );
    topper = struct::get( var_499e2f80 + "_topper", "targetname" );
    var_8f13e4c5 = getent( var_499e2f80 + "_WaitVolume", "targetname" );
    startnode = struct::get( var_499e2f80, "targetname" );
    assert( isdefined( startnode ), "<dev string:x8a>" );
    assert( isdefined( startnode.target ), "<dev string:xac>" );
    var_3a27fe75 = struct::get( startnode.target, "targetname" );
    result = self waittill( #"trigger" );
    
    if ( isdefined( level.doa.var_182fb75a ) )
    {
        self thread function_ec0b503f( var_499e2f80 );
        return;
    }
    
    objective_setstate( 15, "invisible" );
    level.doa.var_70bd361d = level.doa.dungeons[ idx ].policy;
    level thread namespace_ec06fe4a::function_de70888a();
    level.doa.var_e84586f1 = var_3a27fe75;
    level.doa.var_783e7439 = struct::get_array( self.target + "_pickup", "targetname" );
    level thread function_600ea4f();
    level.doa.var_36d8eb11 = undefined;
    level.doa.var_d94cfb75 = gettime();
    level.doa.var_a7ccb320 = undefined;
    level function_c88b8726( idx );
    level doa_banner::function_7a0e5387( 8 );
    level.doa.var_5b55ba1f = namespace_4dae815d::function_21cd3890( 5 );
    
    if ( isdefined( var_8f13e4c5 ) )
    {
        level function_462d812e( var_8f13e4c5, 5 );
    }
    
    if ( is_true( level.doa.var_c93506fb ) )
    {
        self thread function_ec0b503f( var_499e2f80 );
    }
    
    if ( !is_true( level.doa.var_c93506fb ) && isdefined( topper ) )
    {
        if ( isdefined( topper.script_noteworthy ) )
        {
            var_2436e1b = namespace_ec06fe4a::spawnmodel( topper.origin, topper.script_noteworthy );
            
            if ( isdefined( var_2436e1b ) )
            {
                var_2436e1b.angles = topper.angles;
                var_2436e1b solid();
                level.doa.var_43cb2d40[ level.doa.var_43cb2d40.size ] = var_2436e1b;
                self.topper = var_2436e1b;
                var_2436e1b namespace_83eb6304::function_3ecfde67( "explode_lg" );
            }
        }
    }
    
    foreach ( player in getplayers() )
    {
        player thread function_fe17d41e();
        
        if ( !isdefined( level.doa.var_6f3d327 ) )
        {
            player namespace_6e90e490::showhint( 7 );
        }
    }
}

// Namespace namespace_981c1f3c/namespace_981c1f3c
// Params 0
// Checksum 0xb08d2c4e, Offset: 0x1218
// Size: 0x1e0
function function_fe17d41e()
{
    level endon( #"dungeon_cleanup", #"dungeon_destroyed" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        groundent = self getgroundent();
        
        if ( isdefined( groundent ) && groundent ismovingplatform() && groundent function_2ad80b99() )
        {
            self.doa.var_2fb8ffeb = groundent;
            
            if ( is_true( groundent.tweakcam ) )
            {
                if ( !is_true( self.doa.var_af150b2c ) )
                {
                    self.doa.var_af150b2c = 1;
                    self clientfield::set_to_player( "setCameraDown", groundent.var_95773ba5 );
                }
            }
            else if ( is_true( self.doa.var_af150b2c ) )
            {
                self.doa.var_af150b2c = 0;
                self clientfield::set_to_player( "setCameraDown", 0 );
            }
            
            if ( groundent.var_ae9c1083 !== 1 )
            {
                if ( isdefined( groundent ) )
                {
                    groundent clientfield::set( "dungeon_set_explore_state", 1 );
                }
                
                groundent.var_ae9c1083 = 1;
            }
        }
        
        wait 0.25;
    }
}

// Namespace namespace_981c1f3c/namespace_981c1f3c
// Params 2
// Checksum 0x94dbeb8c, Offset: 0x1400
// Size: 0x7c
function function_462d812e( var_8f13e4c5, timeout )
{
    note = "allIn" + var_8f13e4c5.targetname;
    level thread function_63bf74b8( var_8f13e4c5, timeout, note );
    level waittill( note );
    namespace_1e25ad94::debugmsg( "check_allplayers_inside_or_teleport received notification: " + note );
}

// Namespace namespace_981c1f3c/namespace_981c1f3c
// Params 3
// Checksum 0x9d4b437b, Offset: 0x1488
// Size: 0xfe
function function_63bf74b8( var_8f13e4c5, timeout, note )
{
    var_8f13e4c5 notify( note );
    var_8f13e4c5 endon( note );
    expiretime = gettime() + timeout * 1000;
    
    while ( gettime() < expiretime )
    {
        if ( namespace_7f5aeb59::function_2e8dc9d3( var_8f13e4c5 ) )
        {
            level notify( note );
            return;
        }
        
        wait 1;
    }
    
    target = var_8f13e4c5;
    
    if ( isdefined( var_8f13e4c5.target ) )
    {
        target = getent( var_8f13e4c5.target, "targetname" );
        
        if ( !isdefined( target ) )
        {
            target = var_8f13e4c5;
        }
    }
    
    namespace_7f5aeb59::function_a8b57c52( target.origin, target.angles );
    level notify( note );
}

// Namespace namespace_981c1f3c/namespace_981c1f3c
// Params 1
// Checksum 0xea10e9de, Offset: 0x1590
// Size: 0x6a
function function_61e1a1cb( name )
{
    for ( i = 0; i < level.doa.dungeons.size ; i++ )
    {
        if ( level.doa.dungeons[ i ].name === name )
        {
            return i;
        }
    }
}

// Namespace namespace_981c1f3c/namespace_981c1f3c
// Params 1
// Checksum 0x53b84e3c, Offset: 0x1608
// Size: 0x6a
function function_56bd9d70( idx )
{
    assert( idx > -1 && idx < level.doa.dungeons.size );
    return level.doa.dungeons[ idx ].name;
}

// Namespace namespace_981c1f3c/namespace_981c1f3c
// Params 0
// Checksum 0xb347862c, Offset: 0x1680
// Size: 0x32a
function function_8790b64a()
{
    level.doa.var_d31bcf30 = 1;
    level clientfield::increment( "world_dungeon_destroy", 1 );
    util::wait_network_frame();
    level namespace_c85a46fe::function_edfcfa44( 2 );
    namespace_ec06fe4a::function_de70888a();
    namespace_ec06fe4a::function_b6b79fd1();
    util::wait_network_frame();
    level thread namespace_95fdc800::function_b1989480();
    level waittill( #"hash_29a1cf6b91759f63" );
    namespace_5849a337::function_2d3e0ee4();
    namespace_491fa2b2::function_df55eb9d( 2 );
    waitframe( 1 );
    namespace_40bb01c9::function_ddb3fb8f();
    waitframe( 1 );
    
    foreach ( item in level.doa.var_783e7439 )
    {
        if ( isdefined( item.pickup ) )
        {
            item.pickup delete();
            item.pickup = undefined;
        }
    }
    
    level.doa.var_783e7439 = [];
    level.doa.var_d1501142 = [];
    level.doa.var_51400a66 = [];
    level.doa.var_f5a14209 = [];
    level.doa.var_182fb75a = undefined;
    level.doa.var_187ed224 = undefined;
    
    if ( isdefined( level.doa.var_9f48249a ) )
    {
        level.doa.var_9f48249a namespace_83eb6304::turnofffx( "teleporter_dungeon_light" );
        util::wait_network_frame();
        
        if ( isdefined( level.doa.var_9f48249a.trigger ) )
        {
            level.doa.var_9f48249a.trigger delete();
        }
        
        if ( isdefined( level.doa.var_9f48249a ) )
        {
            level.doa.var_9f48249a delete();
        }
        
        level.doa.var_9f48249a = undefined;
    }
    
    level notify( #"dungeon_destroyed" );
    level.doa.var_d31bcf30 = undefined;
}

// Namespace namespace_981c1f3c/namespace_981c1f3c
// Params 2
// Checksum 0x69fa6a2d, Offset: 0x19b8
// Size: 0x25e
function function_4be92bcc( idx, seconds )
{
    var_80d530a9 = {};
    var_80d530a9.name = function_56bd9d70( idx );
    var_80d530a9.buildtime = seconds;
    var_80d530a9.tiles = level.var_c97eeeb4.size;
    var_80d530a9.rooms = level.var_d5561d56;
    var_80d530a9.halls = level.var_5d40e975;
    var_80d530a9.players = namespace_7f5aeb59::function_f08b75c1();
    var_80d530a9.var_a98f4fd2 = [];
    
    foreach ( tileid in level.doa.var_830f8412 )
    {
        tile = { #name:tileid, #count:level.doa.var_4cdaff39[ tileid ] };
        
        if ( !isdefined( var_80d530a9.var_a98f4fd2 ) )
        {
            var_80d530a9.var_a98f4fd2 = [];
        }
        else if ( !isarray( var_80d530a9.var_a98f4fd2 ) )
        {
            var_80d530a9.var_a98f4fd2 = array( var_80d530a9.var_a98f4fd2 );
        }
        
        var_80d530a9.var_a98f4fd2[ var_80d530a9.var_a98f4fd2.size ] = tile;
    }
    
    level.doa.var_fa21a3aa += var_80d530a9.tiles;
    level.doa.var_f23e2931 += var_80d530a9.halls;
    level.doa.var_f5f2b4e8 += var_80d530a9.rooms;
}

// Namespace namespace_981c1f3c/namespace_981c1f3c
// Params 1
// Checksum 0x3df8cd4a, Offset: 0x1c20
// Size: 0x1f2
function function_c88b8726( index )
{
    assert( !isdefined( level.doa.var_187ed224 ), "<dev string:xd3>" );
    
    if ( !isdefined( level.doa.var_a354a42f ) )
    {
        level.doa.var_a354a42f = 1;
    }
    
    level flag::set( "dungeon_building" );
    level.var_d5561d56 = 0;
    level.var_5d40e975 = 0;
    level.doa.var_5db3d0bc = [];
    level.doa.var_f5a14209 = [];
    level.doa.var_d1501142 = [];
    level.var_f9c83ade = 0;
    level.doa.var_182fb75a = index;
    namespace_1e25ad94::debugmsg( "Creating a new Dungeon! Instance# " + level.doa.var_a354a42f );
    level.doa.var_a354a42f++;
    level clientfield::set( "world_dungeon_set", index );
    level util::set_lighting_state( 3, 0 );
    util::wait_network_frame();
    level clientfield::increment( "world_dungeon_build", 1 );
    namespace_95fdc800::function_d6e32b1b();
    level.doa.var_187ed224 = namespace_95fdc800::function_1bce4bde( level.doa.dungeons[ index ].name );
}

// Namespace namespace_981c1f3c/namespace_981c1f3c
// Params 0
// Checksum 0x6c11a393, Offset: 0x1e20
// Size: 0xac
function function_30697e3b()
{
    assert( level.doa.dungeons[ level.doa.var_182fb75a ].var_9105f204.size );
    return level.doa.dungeons[ level.doa.var_182fb75a ].var_9105f204[ randomint( level.doa.dungeons[ level.doa.var_182fb75a ].var_9105f204.size ) ];
}

// Namespace namespace_981c1f3c/namespace_981c1f3c
// Params 0
// Checksum 0xd60c7392, Offset: 0x1ed8
// Size: 0xac
function function_1a775179()
{
    assert( level.doa.dungeons[ level.doa.var_182fb75a ].var_40ca2d09.size );
    return level.doa.dungeons[ level.doa.var_182fb75a ].var_40ca2d09[ randomint( level.doa.dungeons[ level.doa.var_182fb75a ].var_40ca2d09.size ) ];
}

// Namespace namespace_981c1f3c/namespace_981c1f3c
// Params 0
// Checksum 0x33e5d3f2, Offset: 0x1f90
// Size: 0xfc
function function_fd83ca7f()
{
    self endon( #"death" );
    
    while ( true )
    {
        result = self waittill( #"hash_4c72e79bdad8315e" );
        
        if ( !isdefined( level.doa.var_35c4260d ) )
        {
            level.doa.var_35c4260d = [];
        }
        else if ( !isarray( level.doa.var_35c4260d ) )
        {
            level.doa.var_35c4260d = array( level.doa.var_35c4260d );
        }
        
        level.doa.var_35c4260d[ level.doa.var_35c4260d.size ] = result.ai;
    }
}

// Namespace namespace_981c1f3c/namespace_981c1f3c
// Params 0
// Checksum 0x4d57ccaf, Offset: 0x2098
// Size: 0x350
function doaenemyfillerfodder()
{
    level endon( #"dungeon_cleanup", #"dungeon_destroyed" );
    self notify( "918c19f9c4cb2ea" );
    self endon( "918c19f9c4cb2ea" );
    wait 15;
    level.doa.var_35c4260d = [];
    var_764338c3 = namespace_ec06fe4a::spawnorigin( ( 0, 0, 0 ) );
    
    if ( isdefined( var_764338c3 ) )
    {
        var_764338c3.targetname = "doaEnemyFillerFodder";
        var_764338c3 thread function_fd83ca7f();
        var_764338c3 thread namespace_ec06fe4a::function_d55f042c( level, "dungeon_cleanup" );
        var_764338c3 thread namespace_ec06fe4a::function_d55f042c( level, "dungeon_destroyed" );
    }
    
    while ( true )
    {
        if ( namespace_ec06fe4a::function_9788bacc() < 4 )
        {
            players = function_a1ef346b();
            
            if ( players.size > 1 )
            {
                player = players[ randomint( players.size ) ];
            }
            else
            {
                player = players[ 0 ];
            }
            
            var_43f8c3d2 = [];
            
            if ( isdefined( player ) )
            {
                var_43f8c3d2 = arraysortclosest( level.doa.var_d1501142, player.origin, 4, 1200, 2048 );
            }
            
            if ( var_43f8c3d2.size )
            {
                spawnorigin = var_43f8c3d2[ randomint( var_43f8c3d2.size ) ];
                count = randomint( 8 );
                doa_enemy::function_a6b807ea( function_30697e3b(), count, spawnorigin, 36, undefined, player );
            }
        }
        
        if ( randomint( 100 ) == 0 )
        {
            arrayremovevalue( level.doa.var_35c4260d, undefined );
            
            if ( level.doa.var_35c4260d.size < 3 )
            {
                var_43f8c3d2 = [];
                
                if ( isdefined( player ) )
                {
                    var_43f8c3d2 = arraysortclosest( level.doa.var_d1501142, player.origin, 4, 1200, 2048 );
                }
                
                if ( var_43f8c3d2.size )
                {
                    spawnorigin = var_43f8c3d2[ randomint( var_43f8c3d2.size ) ];
                    doa_enemy::function_a6b807ea( function_1a775179(), 1, spawnorigin, 0, undefined, player, var_764338c3 );
                }
            }
        }
        
        wait randomintrange( 2, 4 );
    }
}

// Namespace namespace_981c1f3c/namespace_981c1f3c
// Params 0
// Checksum 0xad707814, Offset: 0x23f0
// Size: 0x3d4
function function_600ea4f()
{
    retval = level waittilltimeout( 30, #"hash_db5742cf48f5e5" );
    
    if ( retval._notify == #"timeout" )
    {
        namespace_1e25ad94::function_4e3cfad( "\tDungeon creation timeout!", ( 1, 0, 0 ), undefined, 1.5, 1000 );
        namespace_1e25ad94::debugmsg( "Dungeon creation timeout!", 1 );
    }
    
    if ( level.doa.teleporter_locs.size > 0 )
    {
        level.doa.teleporter_locs = arraysortclosest( level.doa.teleporter_locs, level.doa.var_187ed224.origin );
        furthest = level.doa.teleporter_locs[ level.doa.teleporter_locs.size - 1 ];
        level.doa.teleporter_locs = [];
        level.doa.var_9f48249a = namespace_dfc652ee::itemspawn( namespace_dfc652ee::function_2c9923d7( 39 ), furthest.origin, undefined, undefined, 1 );
        level.doa.var_9f48249a namespace_83eb6304::function_3ecfde67( "teleporter_dungeon_light" );
        level.doa.var_9f48249a clientfield::set( "set_icon", 9 );
        level.doa.var_9f48249a notify( #"hash_2a866f50cc161ca8" );
        objective_onentity( 15 + 1, level.doa.var_9f48249a );
        objective_setstate( 15 + 1, "active" );
        objective_setstate( 15, "invisible" );
    }
    
    foreach ( pickup in level.doa.var_783e7439 )
    {
        if ( !isdefined( pickup.script_noteworthy ) )
        {
            continue;
        }
        
        item = namespace_dfc652ee::itemspawn( namespace_dfc652ee::function_6265bde4( pickup.script_noteworthy ), pickup.origin, undefined, undefined, 1 );
        
        if ( isdefined( pickup.modelscale ) )
        {
            item setscale( pickup.modelscale );
            item notify( #"hash_2a866f50cc161ca8" );
        }
        
        pickup.pickup = item;
    }
    
    level thread function_73730269( level.doa.var_9f48249a );
}

// Namespace namespace_981c1f3c/namespace_981c1f3c
// Params 0
// Checksum 0xa512cb6a, Offset: 0x27d0
// Size: 0x2bc
function function_c153f40()
{
    level notify( #"hash_db5742cf48f5e5" );
    
    if ( isdefined( level.doa.var_d94cfb75 ) )
    {
        level.doa.var_b5f24666 = gettime();
        seconds = ( level.doa.var_b5f24666 - level.doa.var_d94cfb75 ) / 1000;
        function_4be92bcc( level.doa.var_182fb75a, seconds );
        namespace_1e25ad94::function_4e3cfad( "\tDungeon built in : " + seconds + " seconds.  Tiles: " + level.var_c97eeeb4.size + " Rooms: " + level.var_d5561d56 + " Halls: " + level.var_5d40e975, undefined, undefined, undefined, 10 );
    }
    
    level thread namespace_5849a337::function_fabbde0d();
    level thread namespace_22574328::function_b9c8a739();
    level thread namespace_40bb01c9::function_f69dda63();
    
    if ( isdefined( level.doa.var_a77e6349 ) )
    {
        [[ level.doa.var_a77e6349 ]]->function_1137c8bb();
        [[ level.doa.var_a77e6349 ]]->function_464d882c();
    }
    
    foreach ( generator in level.doa.var_8acd67ef )
    {
        if ( [[ generator ]]->function_30a0163e() == 0 )
        {
            [[ generator ]]->getmodel() namespace_c85a46fe::function_47c860ff( 0 );
        }
    }
    
    level thread doaenemyfillerfodder();
    level notify( #"hash_4d5f7cfb3c3f1c9e" );
    level flag::clear( "dungeon_building" );
    
    if ( isdefined( level.doa.var_a7ccb320 ) )
    {
        [[ level.doa.var_a7ccb320 ]]();
    }
}

// Namespace namespace_981c1f3c/namespace_981c1f3c
// Params 1
// Checksum 0x3cc4950d, Offset: 0x2a98
// Size: 0x520
function function_73730269( var_f3c8eb3 )
{
    self notify( "6f439abc7180ff71" );
    self endon( "6f439abc7180ff71" );
    level endon( #"game_over" );
    result = level waittill( #"ladder_up", #"game_over" );
    level notify( #"dungeon_cleanup" );
    level notify( #"rg_abort" );
    
    if ( isdefined( var_f3c8eb3 ) )
    {
        var_f3c8eb3 namespace_83eb6304::turnofffx( "teleporter_dungeon_light" );
    }
    
    namespace_ec06fe4a::function_87612422( level.doa.var_e84586f1.origin, level.doa.var_e84586f1.angles, 1, 8, level.var_564dda4 );
    objective_setstate( 15 + 1, "invisible" );
    level namespace_c85a46fe::function_edfcfa44( 2 );
    namespace_ec06fe4a::function_de70888a();
    namespace_ec06fe4a::function_b6b79fd1();
    level thread namespace_7f5aeb59::function_67f054d7( 1.5 );
    level waittill( #"hash_1b322de3d2e3e781" );
    level function_8790b64a();
    namespace_1e25ad94::function_4e3cfad( "\tDungeon destroyed", undefined, undefined, undefined, 10 );
    
    foreach ( player in getplayers() )
    {
    }
    
    if ( result._notify === "game_over" )
    {
        return;
    }
    
    foreach ( player in namespace_7f5aeb59::function_23e1f90f() )
    {
        player namespace_eccff4fb::function_cb7b5503();
    }
    
    namespace_7f5aeb59::function_a8b57c52( level.doa.var_e84586f1.origin, level.doa.var_e84586f1.angles );
    level notify( #"hash_7893364bd228d63e" );
    level.doa.var_e84586f1 = undefined;
    level.doa.var_70bd361d = undefined;
    namespace_4dae815d::function_21cd3890( level.doa.var_5b55ba1f );
    level thread namespace_7f5aeb59::function_836aeb74( 1.5 );
    objective_setstate( 15, "active" );
    oldstate = level.var_564dda4;
    level util::set_lighting_state( oldstate, 0 );
    level clientfield::set( "setTOD", oldstate );
    
    if ( isdefined( level.doa.var_a77e6349 ) )
    {
        [[ level.doa.var_a77e6349 ]]->function_90de0b96();
        [[ level.doa.var_a77e6349 ]]->function_ce6bb21b();
    }
    
    foreach ( generator in level.doa.var_8acd67ef )
    {
        [[ generator ]]->getmodel() namespace_c85a46fe::function_47c860ff( 1 );
    }
    
    level notify( #"hash_df3bb53ea54541f" );
}

