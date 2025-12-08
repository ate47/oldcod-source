#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2440f86f9cd325ac;
#using script_2a5bf5b4a00cee0d;
#using script_3faf478d5b0850fe;
#using script_40f967ad5d18ea74;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_74a56359b7d02ab6;
#using script_f38dc50f0e82277;
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

#namespace namespace_77eccc4f;

// Namespace namespace_77eccc4f/namespace_77eccc4f
// Params 2
// Checksum 0xe2f8f318, Offset: 0x2a8
// Size: 0x6c8
function function_93e7ee52( challengetype = 0, name )
{
    level.doa.var_e5ef2ab4 |= 1 << challengetype;
    level.doa.var_a598a835 = undefined;
    level.doa.var_a77e4601 = [];
    timestart = gettime();
    namespace_1e25ad94::debugmsg( "Challenge (" + name + ") starting at: " + timestart + " RoundNumber: " + level.doa.roundnumber );
    waitframe( 1 );
    var_af104f33 = function_fa798421( name );
    level doa_banner::function_7a0e5387( var_af104f33 );
    
    switch ( challengetype )
    {
        case 1:
            def = doa_enemy::function_251ee3bd( "barreler_zombie" );
            [[ def ]]->function_7edd7727( 2 );
            level.doa.var_a77e4601[ level.doa.var_a77e4601.size ] = def;
            def = doa_enemy::function_251ee3bd( "basic_zombie" );
            level.doa.var_a77e4601[ level.doa.var_a77e4601.size ] = def;
            level.doa.var_a77e4601[ level.doa.var_a77e4601.size ] = def;
            break;
        case 2:
            level thread function_d1dc367c();
            def = doa_enemy::function_251ee3bd( "riser_zombie" );
            break;
        case 3:
            level thread function_97aae609();
            def = doa_enemy::function_251ee3bd( "smoke_zombie" );
            [[ def ]]->function_7edd7727( 2 );
            break;
        case 4:
            def = doa_enemy::function_251ee3bd( "gladiator_destroyer" );
            [[ def ]]->function_7edd7727( 3 );
            level.doa.var_a77e4601[ level.doa.var_a77e4601.size ] = def;
            def = doa_enemy::function_251ee3bd( "gladiator_marauder" );
            [[ def ]]->function_7edd7727( 4 );
            level.doa.var_a77e4601[ level.doa.var_a77e4601.size ] = def;
            def = doa_enemy::function_251ee3bd( "basic_zombie" );
            
            for ( count = 6; count ; count-- )
            {
                level.doa.var_a77e4601[ level.doa.var_a77e4601.size ] = def;
            }
            
            break;
        case 5:
            def = doa_enemy::function_251ee3bd( "ghost_zombie" );
            [[ def ]]->function_7edd7727( 5 );
            level.doa.var_a77e4601[ level.doa.var_a77e4601.size ] = def;
            break;
        case 6:
            level thread function_17f47e92();
            break;
        case 7:
            level thread function_9f6da3ff();
            break;
        case 8:
            level thread function_cd4e6a10();
            break;
    }
    
    lootstructs = struct::get_array( name + "_challenge_loot", "targetname" );
    
    foreach ( loot in lootstructs )
    {
        if ( isdefined( loot.script_noteworthy ) )
        {
            items = strtok( loot.script_noteworthy, ";" );
            item = items[ randomint( items.size ) ];
            def = namespace_dfc652ee::function_6265bde4( item );
            
            if ( isdefined( def ) )
            {
                pickup = level namespace_dfc652ee::itemspawn( def, loot.origin, undefined, undefined, 1 );
                
                if ( isdefined( pickup ) )
                {
                    pickup.origin = loot.origin;
                    pickup notify( #"hash_2a866f50cc161ca8" );
                    
                    if ( pickup.glowfx !== "glow_yellow" )
                    {
                        util::wait_network_frame();
                        pickup namespace_83eb6304::turnofffx( pickup.glowfx );
                        pickup namespace_83eb6304::function_3ecfde67( "glow_yellow" );
                    }
                }
            }
        }
    }
    
    level notify( #"challenge_ready" );
}

// Namespace namespace_77eccc4f/namespace_77eccc4f
// Params 0
// Checksum 0x5773b74c, Offset: 0x978
// Size: 0x34
function init()
{
    level flag::init( "challenge_round_spawnOverride", 0 );
    main();
}

// Namespace namespace_77eccc4f/namespace_77eccc4f
// Params 0
// Checksum 0x41b878c0, Offset: 0x9b8
// Size: 0x54
function main()
{
    level.doa.var_e5ef2ab4 = 0;
    level.doa.var_a77e4601 = [];
    level.doa.var_a598a835 = undefined;
    level flag::clear( "challenge_round_spawnOverride" );
}

// Namespace namespace_77eccc4f/namespace_77eccc4f
// Params 1
// Checksum 0xcbcb15d9, Offset: 0xa18
// Size: 0xd4
function function_1a010742( name )
{
    switch ( name )
    {
        case #"jungle":
            return 4;
        case #"cartel":
            return 1;
        case #"graveyard":
            return 2;
        case #"temple":
            return 3;
        case #"watertemple":
            return 5;
        case #"icecave":
            return 6;
        case #"bloodlake":
            return 7;
        case #"witchwood":
            return 8;
    }
    
    return 0;
}

// Namespace namespace_77eccc4f/namespace_77eccc4f
// Params 1
// Checksum 0xfbfc3daa, Offset: 0xaf8
// Size: 0xd4
function function_fa798421( name )
{
    switch ( name )
    {
        case #"jungle":
            return 29;
        case #"cartel":
            return 26;
        case #"graveyard":
            return 27;
        case #"temple":
            return 28;
        case #"watertemple":
            return 30;
        case #"icecave":
            return 31;
        case #"bloodlake":
            return 32;
        case #"witchwood":
            return 33;
    }
    
    return undefined;
}

// Namespace namespace_77eccc4f/namespace_77eccc4f
// Params 1
// Checksum 0x89ea6cab, Offset: 0xbd8
// Size: 0x88, Type: bool
function function_379191c( name )
{
    level.doa.var_a77e4601 = [];
    challenge = function_1a010742( name );
    
    if ( challenge == 0 )
    {
        return false;
    }
    
    if ( function_d53627e4( challenge ) )
    {
        return false;
    }
    
    level thread function_93e7ee52( challenge, name );
    return true;
}

// Namespace namespace_77eccc4f/namespace_77eccc4f
// Params 1
// Checksum 0x17d85c39, Offset: 0xc68
// Size: 0x2a
function function_d53627e4( type )
{
    return level.doa.var_e5ef2ab4 & 1 << type;
}

// Namespace namespace_77eccc4f/namespace_77eccc4f
// Params 0
// Checksum 0x442fa08b, Offset: 0xca0
// Size: 0x2f4
function function_d1dc367c()
{
    level endon( #"arena_completed" );
    level endon( #"game_over" );
    level flag::set( "challenge_round_spawnOverride" );
    var_a1c7d06b = doa_enemy::function_251ee3bd( "riser_zombie" );
    origin = [[ level.doa.var_39e3fa99 ]]->function_ffcf1d1();
    level.doa.var_ccbf8c33 = [[ level.doa.var_39e3fa99 ]]->function_3476ff6d();
    level.doa.var_2020337e = 0;
    level.doa.var_a598a835 = &function_6876f78c;
    wait 5;
    waves = 4;
    var_87b290c9 = level.doa.var_ccbf8c33.size;
    level.doa.var_13e8f9c9 = "walk";
    players = namespace_7f5aeb59::function_23e1f90f();
    
    while ( waves )
    {
        for ( numai = var_87b290c9; numai ; numai-- )
        {
            doa_enemy::function_a6b807ea( var_a1c7d06b, 1, origin, 0, undefined, players[ 0 ], undefined, level.doa.var_39e3fa99 );
        }
        
        [[ level.doa.var_39e3fa99 ]]->setpaused( 0 );
        wait 8;
        [[ level.doa.var_39e3fa99 ]]->setpaused( 1 );
        
        while ( namespace_ec06fe4a::function_9788bacc() > 5 )
        {
            wait 1;
        }
        
        waves--;
        var_87b290c9 -= 5;
        level.doa.var_13e8f9c9 = namespace_250e9486::function_bb0817aa( level.doa.var_13e8f9c9 );
    }
    
    [[ level.doa.var_39e3fa99 ]]->setpaused( 0 );
    level.doa.var_ccbf8c33 = undefined;
    level.doa.var_2020337e = undefined;
    level.doa.var_a598a835 = undefined;
    level.doa.var_13e8f9c9 = undefined;
    level flag::clear( "challenge_round_spawnOverride" );
}

// Namespace namespace_77eccc4f/namespace_77eccc4f
// Params 0
// Checksum 0xd93a05dc, Offset: 0xfa0
// Size: 0x21c
function function_97aae609()
{
    level endon( #"arena_completed" );
    level endon( #"game_over" );
    level flag::set( "challenge_round_spawnOverride" );
    var_94f3b914 = doa_enemy::function_251ee3bd( "smoke_zombie" );
    [[ var_94f3b914 ]]->function_7edd7727( 5 );
    origin = [[ level.doa.var_39e3fa99 ]]->getcenter();
    struct = struct::get( [[ level.doa.var_39e3fa99 ]]->getname() + "_challenge", "targetname" );
    level.doa.var_6d072a34 = isdefined( struct ) ? struct : origin;
    level.doa.var_a598a835 = &function_29ff6b1;
    wait 5;
    
    for ( waves = 3; waves ; waves-- )
    {
        function_d1603826( var_94f3b914 );
        [[ level.doa.var_39e3fa99 ]]->setpaused( 0 );
        wait 20;
        [[ level.doa.var_39e3fa99 ]]->setpaused( 1 );
        
        while ( namespace_ec06fe4a::function_9788bacc() > 5 )
        {
            wait 1;
        }
    }
    
    [[ level.doa.var_39e3fa99 ]]->setpaused( 0 );
    level flag::clear( "challenge_round_spawnOverride" );
}

// Namespace namespace_77eccc4f/namespace_77eccc4f
// Params 2
// Checksum 0x1bbfe57e, Offset: 0x11c8
// Size: 0x6c
function function_d1603826( var_94f3b914, var_9e20508c = 15 )
{
    doa_enemy::function_a6b807ea( var_94f3b914, var_9e20508c, level.doa.var_6d072a34.origin, 0, undefined, undefined, undefined, level.doa.var_39e3fa99 );
}

// Namespace namespace_77eccc4f/namespace_77eccc4f
// Params 0
// Checksum 0x317dd1fd, Offset: 0x1240
// Size: 0x84
function function_6876f78c()
{
    spot = level.doa.var_2020337e;
    level.doa.var_2020337e++;
    
    if ( level.doa.var_2020337e > level.doa.var_ccbf8c33.size )
    {
        level.doa.var_2020337e = 0;
    }
    
    return level.doa.var_ccbf8c33[ spot ];
}

// Namespace namespace_77eccc4f/namespace_77eccc4f
// Params 0
// Checksum 0xc4ed9619, Offset: 0x12d0
// Size: 0x16
function function_29ff6b1()
{
    return level.doa.var_6d072a34;
}

// Namespace namespace_77eccc4f/namespace_77eccc4f
// Params 0
// Checksum 0x3ba79303, Offset: 0x12f0
// Size: 0x204
function function_17f47e92()
{
    level flag::set( "challenge_round_spawnOverride" );
    
    if ( namespace_7f5aeb59::function_f08b75c1() > 1 )
    {
        def = doa_enemy::function_251ee3bd( "basic_zombie" );
        level.doa.var_a77e4601[ level.doa.var_a77e4601.size ] = def;
    }
    
    def = doa_enemy::function_251ee3bd( "crawler_zombie" );
    [[ def ]]->function_7edd7727( 4 );
    level.doa.var_6d072a34 = struct::get( [[ level.doa.var_39e3fa99 ]]->getname() + "_challenge", "targetname" );
    
    if ( !isdefined( level.doa.var_d15a522 ) )
    {
        level.doa.var_d15a522 = doa_enemy::function_d7c5adee( "blight_father" );
    }
    
    var_f8ff628e = doa_enemy::function_db55a448( level.doa.var_d15a522, level.doa.var_6d072a34.origin );
    
    /#
        if ( is_true( level.var_a095060b ) )
        {
            var_f8ff628e thread namespace_ec06fe4a::function_3b3bb5c( 0.1, 500 );
        }
    #/
    
    var_f8ff628e waittill( #"death" );
    level flag::clear( "challenge_round_spawnOverride" );
}

// Namespace namespace_77eccc4f/namespace_77eccc4f
// Params 0
// Checksum 0x295d3013, Offset: 0x1500
// Size: 0x8a
function function_201a7d58()
{
    spawnloc = spawnstruct();
    spawnloc.origin = [[ level.doa.var_39e3fa99 ]]->function_70fb5745().origin + ( 0, 0, 1600 );
    spawnloc.angles = [[ level.doa.var_39e3fa99 ]]->function_70fb5745().angles;
    return spawnloc;
}

// Namespace namespace_77eccc4f/namespace_77eccc4f
// Params 0
// Checksum 0x691a3175, Offset: 0x1598
// Size: 0x15e
function function_9f6da3ff()
{
    level endon( #"arena_completed" );
    level endon( #"game_over" );
    level flag::set( "challenge_round_spawnOverride" );
    var_94f3b914 = doa_enemy::function_251ee3bd( "meatball_large" );
    [[ var_94f3b914 ]]->function_7edd7727( 5 );
    wait 5;
    origin = [[ level.doa.var_39e3fa99 ]]->function_ffcf1d1();
    waves = 4;
    level.doa.var_a598a835 = &function_201a7d58;
    
    while ( waves )
    {
        doa_enemy::function_a6b807ea( var_94f3b914, 8, origin, 0, undefined, undefined, undefined, level.doa.var_39e3fa99 );
        wait 30;
        waves--;
    }
    
    level flag::clear( "challenge_round_spawnOverride" );
    level.doa.var_a598a835 = undefined;
}

// Namespace namespace_77eccc4f/namespace_77eccc4f
// Params 0
// Checksum 0x7a2ddf70, Offset: 0x1700
// Size: 0x474
function function_cd4e6a10()
{
    level endon( #"arena_completed" );
    level endon( #"game_over" );
    [[ level.doa.var_39e3fa99 ]]->function_6d5262dc( 18 );
    var_94f3b914 = doa_enemy::function_251ee3bd( "wolf_ghosthound" );
    [[ var_94f3b914 ]]->function_7edd7727( 5 );
    
    if ( !isdefined( level.doa.var_a77e4601 ) )
    {
        level.doa.var_a77e4601 = [];
    }
    else if ( !isarray( level.doa.var_a77e4601 ) )
    {
        level.doa.var_a77e4601 = array( level.doa.var_a77e4601 );
    }
    
    level.doa.var_a77e4601[ level.doa.var_a77e4601.size ] = var_94f3b914;
    
    if ( !isdefined( level.doa.var_a77e4601 ) )
    {
        level.doa.var_a77e4601 = [];
    }
    else if ( !isarray( level.doa.var_a77e4601 ) )
    {
        level.doa.var_a77e4601 = array( level.doa.var_a77e4601 );
    }
    
    level.doa.var_a77e4601[ level.doa.var_a77e4601.size ] = var_94f3b914;
    var_94f3b914 = doa_enemy::function_251ee3bd( "riser_zombie" );
    
    if ( !isdefined( level.doa.var_a77e4601 ) )
    {
        level.doa.var_a77e4601 = [];
    }
    else if ( !isarray( level.doa.var_a77e4601 ) )
    {
        level.doa.var_a77e4601 = array( level.doa.var_a77e4601 );
    }
    
    level.doa.var_a77e4601[ level.doa.var_a77e4601.size ] = var_94f3b914;
    
    if ( !isdefined( level.doa.var_a77e4601 ) )
    {
        level.doa.var_a77e4601 = [];
    }
    else if ( !isarray( level.doa.var_a77e4601 ) )
    {
        level.doa.var_a77e4601 = array( level.doa.var_a77e4601 );
    }
    
    level.doa.var_a77e4601[ level.doa.var_a77e4601.size ] = var_94f3b914;
    level waittill( #"hash_7ebdbe412d2fed17" );
    origin = [[ level.doa.var_39e3fa99 ]]->function_ffcf1d1();
    
    if ( !isdefined( level.doa.var_ce4f409c ) )
    {
        level.doa.var_ce4f409c = doa_enemy::function_d7c5adee( "werewolf" );
    }
    
    var_f8ff628e = doa_enemy::function_db55a448( level.doa.var_ce4f409c, origin );
    
    if ( isdefined( var_f8ff628e ) )
    {
        level doa_banner::function_7a0e5387( 34 );
        
        /#
            if ( is_true( level.var_a095060b ) )
            {
                var_f8ff628e thread namespace_ec06fe4a::function_3b3bb5c( 0.1, 500 );
            }
        #/
    }
}

