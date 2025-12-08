#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2474a362752098d2;
#using script_2a5bf5b4a00cee0d;
#using script_350cffecd05ef6cf;
#using script_40f967ad5d18ea74;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_74a56359b7d02ab6;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_41f5b853;

// Namespace namespace_41f5b853/namespace_41f5b853
// Params 0
// Checksum 0x8d33f6b2, Offset: 0x588
// Size: 0x42c
function init()
{
    clientfield::register( "scriptmover", "world_loot_type", 1, 8, "int" );
    level.doa.var_f69d6693 = [];
    level.doa.var_2f6aa12d = [];
    function_5fd93de5( "treasure chest", 1, "zombietron_treasure_chest_01", undefined, &function_650efe1c, 0 );
    function_5fd93de5( "golden treasure chest", 2, "zombietron_treasure_chest_02", undefined, &function_650efe1c, 0 );
    function_5fd93de5( "stone chest", 3, "zombietron_treasure_chest_03", undefined, &function_650efe1c, 0 );
    function_5fd93de5( "bronze weapon chest", 4, "zombietron_treasure_chest_small_01", undefined, &function_650efe1c, 0 );
    function_5fd93de5( "golden treasure chest XL", 5, "zombietron_treasure_chest_02_xl", undefined, &function_650efe1c, 1 );
    function_5fd93de5( "loot_basket", 6, "zombietron_loot_basket", &function_92a92219, &function_650efe1c, 0 );
    function_5fd93de5( "pirate chest", 5, "zombietron_pirate_chest", undefined, &function_650efe1c, 1, 0 );
    function_5fd93de5( "surprisebox1", 8, "zombietron_gift_box_stripe", undefined, &function_650efe1c, 1, 0, 5 );
    function_5fd93de5( "roforb", 9, "p7_zm_gen_apoth_corpt_engine_light_ball", undefined, &function_650efe1c, 1, 0, 6, -1 );
    function_5fd93de5( "trinket_box", 10, "zombietron_trinket_box", undefined, &function_650efe1c, 0, 0, 7 );
    level.doa.var_b1f49ea1 = [];
    function_f9bfcf6f( 13, 15 );
    function_f9bfcf6f( 6, 15 );
    function_f9bfcf6f( 15, 15 );
    function_f9bfcf6f( 24, 15 );
    function_f9bfcf6f( 17, 10 );
    function_f9bfcf6f( 18, 10 );
    function_f9bfcf6f( 19, 10 );
    function_f9bfcf6f( 10, 10 );
    function_f9bfcf6f( 42, 10 );
    function_f9bfcf6f( 20, 5 );
    function_f9bfcf6f( 22, 5 );
    function_f9bfcf6f( 28, 5 );
    function_f9bfcf6f( 29, 5 );
    function_f9bfcf6f( 8, 3 );
    function_f9bfcf6f( 9, 3 );
    function_f9bfcf6f( 14, 1 );
    function_f9bfcf6f( 16, 1 );
}

// Namespace namespace_41f5b853/namespace_41f5b853
// Params 2
// Checksum 0x6d1c7c2d, Offset: 0x9c0
// Size: 0x50
function function_f9bfcf6f( type, count )
{
    while ( count )
    {
        level.doa.var_b1f49ea1[ level.doa.var_b1f49ea1.size ] = type;
        count--;
    }
}

// Namespace namespace_41f5b853/namespace_41f5b853
// Params 5
// Checksum 0xfd0fa2d2, Offset: 0xa18
// Size: 0x2c0
function spawnlootitem( origin, angles, lootname, radius, context )
{
    if ( lootname === #"fate" )
    {
        if ( context != 2 )
        {
            return;
        }
        
        fate = namespace_1c2a96f9::function_1324dc3b();
        
        if ( !isdefined( fate ) )
        {
            return;
        }
        
        def = { #modelname:fate.model, #type:7, #data:fate, #locked:0, #name:#"fate", #var_d6118311:4 };
    }
    else
    {
        def = function_9acb7d7a( lootname );
    }
    
    var_a1f88ae1 = namespace_ec06fe4a::spawnmodel( origin, def.modelname );
    
    if ( !isdefined( var_a1f88ae1 ) )
    {
        return;
    }
    
    var_a1f88ae1 setmodel( def.modelname );
    var_a1f88ae1.angles = angles;
    var_a1f88ae1 solid();
    var_a1f88ae1.targetname = namespace_ec06fe4a::function_3390402b();
    var_a1f88ae1.script_noteworthy = "world_loot";
    var_a1f88ae1 disconnectpaths();
    var_a1f88ae1.var_d6118311 = def.var_d6118311;
    var_a1f88ae1.loottype = def.type;
    var_a1f88ae1.data = def.data;
    var_a1f88ae1.locked = def.locked;
    var_a1f88ae1.defname = def.name;
    var_a1f88ae1.radius = radius;
    var_a1f88ae1.context = context;
    var_a1f88ae1.var_cbff4088 = def.var_cbff4088;
    namespace_1e25ad94::debugmsg( "Spawning Loot (" + def.modelname + ") at " + origin );
    level.doa.var_b8ef1466[ level.doa.var_b8ef1466.size ] = var_a1f88ae1;
    
    if ( isdefined( def.var_e254c3ed ) )
    {
        var_a1f88ae1 [[ def.var_e254c3ed ]]( def );
    }
    
    return var_a1f88ae1;
}

// Namespace namespace_41f5b853/namespace_41f5b853
// Params 1
// Checksum 0x611b2e74, Offset: 0xce0
// Size: 0xd4
function function_9acb7d7a( name )
{
    foreach ( item in level.doa.var_f69d6693 )
    {
        if ( item.name === name )
        {
            return item;
        }
    }
    
    return level.doa.var_2f6aa12d[ randomint( level.doa.var_2f6aa12d.size ) ];
}

// Namespace namespace_41f5b853/namespace_41f5b853
// Params 1
// Checksum 0xb4278947, Offset: 0xdc0
// Size: 0xa4
function function_dcd8be88( type )
{
    foreach ( item in level.doa.var_f69d6693 )
    {
        if ( item.type == type )
        {
            return item.var_ecdc444;
        }
    }
}

// Namespace namespace_41f5b853/namespace_41f5b853
// Params 1
// Checksum 0x2c2d1b8c, Offset: 0xe70
// Size: 0xf2
function function_dca53316( name )
{
    if ( isdefined( name ) )
    {
        foreach ( item in level.doa.var_f69d6693 )
        {
            if ( item.name === name )
            {
                return item.modelname;
            }
        }
    }
    
    item = level.doa.var_f69d6693[ randomint( level.doa.var_f69d6693.size ) ];
    return item.modelname;
}

// Namespace namespace_41f5b853/namespace_41f5b853
// Params 1
// Checksum 0x5bab402d, Offset: 0xf70
// Size: 0xa4
function function_2732d95( name )
{
    foreach ( item in level.doa.var_f69d6693 )
    {
        if ( item.name === name )
        {
            return item.type;
        }
    }
}

// Namespace namespace_41f5b853/namespace_41f5b853
// Params 1
// Checksum 0xa794cc3e, Offset: 0x1020
// Size: 0xa4
function function_aeb57dc6( name )
{
    foreach ( item in level.doa.var_f69d6693 )
    {
        if ( item.modelname === name )
        {
            return item.type;
        }
    }
}

// Namespace namespace_41f5b853/namespace_41f5b853
// Params 1
// Checksum 0x7c9ad24c, Offset: 0x10d0
// Size: 0xa4
function function_dea1324e( type )
{
    foreach ( item in level.doa.var_f69d6693 )
    {
        if ( item.type === type )
        {
            return item.locked;
        }
    }
}

// Namespace namespace_41f5b853/namespace_41f5b853
// Params 9
// Checksum 0x20d87752, Offset: 0x1180
// Size: 0x164
function function_5fd93de5( name, type, modelname, var_e254c3ed, var_ecdc444, locked = 0, var_641be55e = 1, var_5653e2ee = 3, var_950bcf12 = 1 )
{
    s_loot = spawnstruct();
    s_loot.name = name;
    s_loot.type = type;
    s_loot.locked = locked;
    s_loot.modelname = modelname;
    s_loot.var_e254c3ed = var_e254c3ed;
    s_loot.var_ecdc444 = var_ecdc444;
    s_loot.var_d6118311 = var_5653e2ee;
    s_loot.var_cbff4088 = var_950bcf12;
    level.doa.var_f69d6693[ level.doa.var_f69d6693.size ] = s_loot;
    
    if ( var_641be55e )
    {
        level.doa.var_2f6aa12d[ level.doa.var_2f6aa12d.size ] = s_loot;
    }
}

// Namespace namespace_41f5b853/namespace_41f5b853
// Params 1
// Checksum 0xe46c696c, Offset: 0x12f0
// Size: 0x76
function function_4d27013d( item )
{
    namespace_1e25ad94::debugmsg( "Loot Opened" );
    var_2f0b512f = function_dcd8be88( item.loottype );
    assert( isdefined( var_2f0b512f ), "<dev string:x38>" );
    level thread [[ var_2f0b512f ]]( item );
}

// Namespace namespace_41f5b853/namespace_41f5b853
// Params 1
// Checksum 0x4da5f44f, Offset: 0x1370
// Size: 0x1f4
function function_650efe1c( item )
{
    switch ( item.loottype )
    {
        case 1:
            namespace_1e25ad94::debugmsg( "Loot Opened - Large Bronze" );
            break;
        case 2:
            namespace_1e25ad94::debugmsg( "Loot Opened - Large Golden" );
            break;
        case 3:
            namespace_1e25ad94::debugmsg( "Loot Opened - Large Stone" );
            break;
        case 4:
            namespace_1e25ad94::debugmsg( "Loot Opened - Medium Bronze" );
            break;
        case 5:
            namespace_1e25ad94::debugmsg( "Loot Opened - XL Golden" );
            break;
        case 6:
            namespace_1e25ad94::debugmsg( "Loot Opened - Basket" );
            break;
        case 8:
            namespace_1e25ad94::debugmsg( "Loot Opened - Gift Box" );
            break;
        case 9:
            namespace_1e25ad94::debugmsg( "Loot Opened - ROF ORB" );
            break;
        case 10:
            namespace_1e25ad94::debugmsg( "Loot Opened - TRINKET BOX" );
            break;
    }
    
    level thread function_389aad25( item, item.loottype );
}

// Namespace namespace_41f5b853/namespace_41f5b853
// Params 2
// Checksum 0x85ba11e, Offset: 0x1570
// Size: 0x664
function function_389aad25( item, type )
{
    item endon( #"death" );
    item namespace_e32bb68::function_3a59ec34( "item_opening" );
    original = item.origin;
    var_3e2d48b2 = "glow_white";
    reward = 1;
    rare = 0;
    var_9e20508c = 10;
    radius = isdefined( item.radius ) ? item.radius : 128;
    scenedef = #"hash_7a2190c40fdc3bbc";
    
    switch ( type )
    {
        case 1:
            reward = "treasure";
            break;
        case 2:
            var_3e2d48b2 = "glow_yellow";
            fxtrail = "player_trail_yellow";
            reward = "treasure_horde";
            scenedef = #"hash_30c46dd666dd7707";
            var_9e20508c = 16;
            break;
        case 3:
            reward = "items";
            break;
        case 4:
            reward = "weapon_cache";
            break;
        case 5:
            var_3e2d48b2 = "glow_yellow";
            fxtrail = "player_trail_yellow";
            reward = "treasure_horde_plus";
            scenedef = #"hash_78fd0527319f0425";
            var_9e20508c = 28;
            var_2468c36a = "fireworks";
            break;
        case 10:
            var_3e2d48b2 = "glow_yellow";
            fxtrail = "player_trail_yellow";
            scenedef = #"hash_7a2190c40fdc3bbc";
            roll = randomint( 100 );
            
            if ( roll > 70 )
            {
                reward = "extraLife";
            }
            else if ( roll > 30 )
            {
                reward = "nuke";
            }
            else if ( roll > 0 )
            {
                reward = "boost";
            }
            
            var_9e20508c = 2;
            break;
        case 8:
            var_3e2d48b2 = "glow_yellow";
            fxtrail = "player_trail_yellow";
            scenedef = #"hash_7a2190c40fdc3bbc";
            reward = "extraLife";
            var_9e20508c = 2;
            var_2468c36a = "fireworks";
            break;
        case 6:
            item dodamage( item.health, item.origin );
            return;
        case 9:
            var_3e2d48b2 = "glow_blue";
            fxtrail = "player_trail_blue";
            scenedef = #"hash_78fd0527319f0425";
            var_2468c36a = "lightningStrike";
            nodelete = 1;
            level.doa.var_2e2d85d4 = 1;
            reward = undefined;
            break;
    }
    
    item namespace_83eb6304::function_3ecfde67( var_3e2d48b2 );
    
    if ( isdefined( fxtrail ) )
    {
        item namespace_83eb6304::function_3ecfde67( fxtrail );
    }
    
    item scene::play( scenedef, item );
    item waittill( #"scenes_done" );
    
    if ( isdefined( var_2468c36a ) )
    {
        item namespace_83eb6304::function_3ecfde67( var_2468c36a );
    }
    
    item namespace_e32bb68::function_3a59ec34( "treasure_chest_explode" );
    
    if ( !is_true( nodelete ) )
    {
        item namespace_ec06fe4a::function_8c808737();
        item notsolid();
    }
    
    item namespace_83eb6304::turnofffx( var_3e2d48b2 );
    
    if ( isdefined( fxtrail ) )
    {
        item namespace_83eb6304::turnofffx( fxtrail );
    }
    
    if ( isdefined( reward ) )
    {
        if ( isdefined( item.target ) )
        {
            targets = struct::get_array( item.target, "targetname" );
            
            if ( targets.size > 0 )
            {
                var_9e20508c = int( var_9e20508c / targets.size );
                
                foreach ( target in targets )
                {
                    function_d2c582ec( target.origin, var_9e20508c, radius, reward );
                }
            }
        }
        else
        {
            function_d2c582ec( item.origin, var_9e20508c, radius, reward );
        }
    }
    
    item connectpaths();
    wait 1;
    
    if ( !is_true( nodelete ) )
    {
        item delete();
    }
}

// Namespace namespace_41f5b853/namespace_41f5b853
// Params 5
// Checksum 0x44fc2e1c, Offset: 0x1be0
// Size: 0x622
function function_d2c582ec( origin, var_9e20508c, radius, reward, *flag )
{
    switch ( flag )
    {
        case #"treasure_horde_plus":
            namespace_dfc652ee::function_d06cbfe8( var_9e20508c, radius >> 1, reward );
            
            if ( randomint( 100 ) < 20 )
            {
                namespace_dfc652ee::function_ad7ac41b( var_9e20508c, 1, 32, 16, 1 );
            }
            
            if ( randomint( 100 ) < 10 )
            {
                namespace_dfc652ee::function_ad7ac41b( var_9e20508c, 1, 32, 14, 1 );
            }
        case #"treasure_horde":
            namespace_dfc652ee::function_68442ee7( var_9e20508c, radius, reward, 1 );
            namespace_dfc652ee::function_d06cbfe8( var_9e20508c, radius >> 2, reward );
        case #"treasure":
            namespace_dfc652ee::function_68442ee7( var_9e20508c, radius, reward );
            break;
        case #"extralife":
            namespace_dfc652ee::function_ad7ac41b( var_9e20508c, radius, 32, 16, 1 );
            break;
        case #"boost":
            namespace_dfc652ee::function_ad7ac41b( var_9e20508c, radius, 32, 9, 1 );
            break;
        case #"nuke":
            namespace_dfc652ee::function_ad7ac41b( var_9e20508c, radius, 32, 8, 1 );
            break;
        case #"items":
            while ( radius )
            {
                radius--;
                function_e2b14b6( var_9e20508c + ( randomintrange( -60, 60 ), randomintrange( -60, 60 ), 0 ), ( 0, 0, 0 ) );
            }
            
            break;
        case #"weapon_cache":
            var_d7d0ebdd = namespace_dfc652ee::function_57160cba( 6 );
            namespace_dfc652ee::itemspawn( var_d7d0ebdd, var_9e20508c + ( randomintrange( -60, 60 ), randomintrange( -60, 60 ), 0 ), undefined, undefined, 1 );
            namespace_dfc652ee::itemspawn( var_d7d0ebdd, var_9e20508c + ( randomintrange( -60, 60 ), randomintrange( -60, 60 ), 0 ), undefined, undefined, 1 );
            namespace_dfc652ee::itemspawn( var_d7d0ebdd, var_9e20508c + ( randomintrange( -60, 60 ), randomintrange( -60, 60 ), 0 ), undefined, undefined, 1 );
            namespace_dfc652ee::itemspawn( var_d7d0ebdd, var_9e20508c + ( randomintrange( -60, 60 ), randomintrange( -60, 60 ), 0 ), undefined, undefined, 1 );
            namespace_dfc652ee::itemspawn( var_d7d0ebdd, var_9e20508c + ( randomintrange( -60, 60 ), randomintrange( -60, 60 ), 0 ), undefined, undefined, 1 );
            namespace_dfc652ee::itemspawn( var_d7d0ebdd, var_9e20508c + ( randomintrange( -60, 60 ), randomintrange( -60, 60 ), 0 ), undefined, undefined, 1 );
            namespace_dfc652ee::itemspawn( var_d7d0ebdd, var_9e20508c + ( randomintrange( -60, 60 ), randomintrange( -60, 60 ), 0 ), undefined, undefined, 1 );
            namespace_dfc652ee::itemspawn( var_d7d0ebdd, var_9e20508c + ( randomintrange( -60, 60 ), randomintrange( -60, 60 ), 0 ), undefined, undefined, 1 );
            namespace_dfc652ee::itemspawn( var_d7d0ebdd, var_9e20508c + ( randomintrange( -60, 60 ), randomintrange( -60, 60 ), 0 ), undefined, undefined, 1 );
            break;
        default:
            namespace_dfc652ee::function_ad7ac41b( var_9e20508c, radius, reward, flag, 1 );
            break;
    }
}

// Namespace namespace_41f5b853/namespace_41f5b853
// Params 1
// Checksum 0x528f5fb, Offset: 0x2210
// Size: 0x3c
function function_92a92219( *def )
{
    self.takedamage = 1;
    self.health = 575;
    self thread function_8534e7be();
}

// Namespace namespace_41f5b853/namespace_41f5b853
// Params 0
// Checksum 0x598d7e75, Offset: 0x2258
// Size: 0x9a
function function_8534e7be()
{
    self endon( #"death" );
    
    while ( self.health > 0 )
    {
        result = self waittill( #"damage" );
        
        if ( result.amount > self.health )
        {
            self.health += result.amount;
            self thread basketexplo();
            return;
        }
    }
}

// Namespace namespace_41f5b853/namespace_41f5b853
// Params 2
// Checksum 0xb53b3eb6, Offset: 0x2300
// Size: 0xe4
function function_e2b14b6( origin, angles )
{
    type = level.doa.var_b1f49ea1[ randomint( level.doa.var_b1f49ea1.size ) ];
    def = namespace_dfc652ee::function_57160cba( type );
    
    if ( type == 13 )
    {
        namespace_dfc652ee::function_b8f6a8cd( def, origin, 1, 1, randomfloatrange( 0.25, 1.25 ) );
        return;
    }
    
    namespace_dfc652ee::itemspawn( def, origin, angles, undefined, 1 );
}

// Namespace namespace_41f5b853/namespace_41f5b853
// Params 0
// Checksum 0x226fcd28, Offset: 0x23f0
// Size: 0xf4
function basketexplo()
{
    origin = self.origin;
    angles = self.angles;
    self namespace_83eb6304::function_3ecfde67( "basketExplo" );
    self namespace_e32bb68::function_3a59ec34( "basketExplo" );
    
    if ( isdefined( self.owner ) )
    {
        self.owner.activated = 1;
    }
    
    wait 0.15;
    function_e2b14b6( origin, angles );
    self namespace_ec06fe4a::function_8c808737();
    self connectpaths();
    wait 0.2;
    self delete();
}

