#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1ee011cd0961afd7;
#using script_2474a362752098d2;
#using script_26187f7b449f7b92;
#using script_2a5bf5b4a00cee0d;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_5f20d3b434d24884;
#using script_6b6510e124bad778;
#using script_f38dc50f0e82277;
#using scripts\core_common\animation_shared;
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

#namespace namespace_1c2a96f9;

// Namespace namespace_1c2a96f9/namespace_1c2a96f9
// Params 0
// Checksum 0x51f1104f, Offset: 0x2f8
// Size: 0x2ca
function init()
{
    level.doa.var_fe92efd8 = array( { #model:#"zombietron_fate_rock_fury", #var_3831681e:#"zombietron_fate_fury", #var_c8386627:1, #fx:"wild_portal_radial_burst", #sfx:"zmb_hellhound_bolt", #var_af104f33:9, #var_d75b5b21:( 0, 0, 0 ) }, { #model:#"zombietron_fate_rock_fortune", #var_3831681e:#"zombietron_fate_ruby", #var_c8386627:2, #fx:"wild_portal_radial_burst", #sfx:"zmb_hellhound_bolt", #var_af104f33:11, #var_d75b5b21:( 0, 0, 0 ) }, { #model:#"zombietron_fate_rock_friend", #var_3831681e:#"zombietron_fate_friendship", #var_c8386627:4, #fx:"wild_portal_radial_burst", #sfx:"zmb_hellhound_bolt", #var_af104f33:10, #var_d75b5b21:( -70, 80, 0 ) }, { #model:#"zombietron_fate_rock_feet", #var_3831681e:#"zombietron_fate_boots", #var_c8386627:8, #fx:"wild_portal_radial_burst", #sfx:"zmb_hellhound_bolt", #var_af104f33:12, #var_d75b5b21:( 0, 0, 0 ) } );
}

// Namespace namespace_1c2a96f9/namespace_1c2a96f9
// Params 0
// Checksum 0x6d9bdb1c, Offset: 0x5d0
// Size: 0x42
function main()
{
    level.doa.var_fa624022 = array( 1, 2, 4, 8 );
    level.doa.var_36d8eb11 = undefined;
}

// Namespace namespace_1c2a96f9/namespace_1c2a96f9
// Params 0
// Checksum 0xb001178e, Offset: 0x620
// Size: 0xe4
function function_1324dc3b()
{
    if ( isdefined( level.doa.var_36d8eb11 ) )
    {
        fate = level.doa.var_36d8eb11;
    }
    else if ( level.doa.var_fa624022.size )
    {
        fate = level.doa.var_fa624022[ randomint( level.doa.var_fa624022.size ) ];
        arrayremovevalue( level.doa.var_fa624022, fate );
    }
    
    if ( isdefined( fate ) )
    {
        level.doa.var_36d8eb11 = fate;
        return function_e8822b3b( fate );
    }
}

// Namespace namespace_1c2a96f9/namespace_1c2a96f9
// Params 1
// Checksum 0x9d65e37b, Offset: 0x710
// Size: 0x38
function function_85da1646( var_c8386627 )
{
    level.doa.var_fa624022[ level.doa.var_fa624022.size ] = var_c8386627;
}

// Namespace namespace_1c2a96f9/namespace_1c2a96f9
// Params 1
// Checksum 0x2992adc9, Offset: 0x750
// Size: 0x9e
function function_e8822b3b( var_c8386627 )
{
    foreach ( fate in level.doa.var_fe92efd8 )
    {
        if ( fate.var_c8386627 == var_c8386627 )
        {
            return fate;
        }
    }
}

// Namespace namespace_1c2a96f9/namespace_1c2a96f9
// Params 1
// Checksum 0xd5cf8540, Offset: 0x7f8
// Size: 0x48
function function_afe89b8c( var_c8386627 )
{
    assert( isdefined( self.doa.var_484cc88b ) );
    return self.doa.var_484cc88b & var_c8386627;
}

// Namespace namespace_1c2a96f9/namespace_1c2a96f9
// Params 1
// Checksum 0x451d539e, Offset: 0x848
// Size: 0x23c
function function_15a789ab( var_c8386627 )
{
    assert( isdefined( self.doa.var_484cc88b ) );
    
    if ( var_c8386627 == 0 )
    {
        if ( self function_9e59136f() )
        {
            self.doa.var_ed8fde10 = "zombietron_lmg";
            self namespace_41cb996::function_8b7acf56();
        }
        
        if ( self function_d17f9bcb() )
        {
            self.doa.var_e5805edb = 1;
            self setmovespeedscale( self.doa.var_e5805edb );
            self namespace_83eb6304::turnofffx( "fast_feet" );
        }
        
        if ( self function_d5b51f1e() && isdefined( self.var_20a27350 ) )
        {
            self.var_20a27350 namespace_4ff32993::function_a7be9625();
            self.var_20a27350 = undefined;
        }
        
        if ( self function_d438e371() )
        {
        }
        
        self.doa.var_484cc88b = 0;
        namespace_1e25ad94::debugmsg( "Player's fates have been striped" );
        self thread namespace_6e90e490::function_47e11416( 1 );
        return;
    }
    
    if ( !function_afe89b8c( var_c8386627 ) )
    {
        self thread namespace_6e90e490::function_47e11416( 4 );
        level thread function_86515c3b( self, function_e8822b3b( var_c8386627 ) );
        namespace_1e25ad94::debugmsg( "Player awarded fate:" + var_c8386627 );
        return;
    }
    
    namespace_1e25ad94::debugmsg( "Player already fated with this fate:" + var_c8386627 );
}

// Namespace namespace_1c2a96f9/namespace_1c2a96f9
// Params 2
// Checksum 0x47317022, Offset: 0xa90
// Size: 0x9c
function function_42b0778( var_4198fa33, player )
{
    fate = var_4198fa33.data;
    var_4198fa33 notsolid();
    var_4198fa33 ghost();
    
    if ( var_4198fa33.context === 2 )
    {
        namespace_491fa2b2::function_df55eb9d( 2, 7, var_4198fa33 );
    }
    
    function_86515c3b( player, fate );
}

// Namespace namespace_1c2a96f9/namespace_1c2a96f9
// Params 2
// Checksum 0xaeba6563, Offset: 0xb38
// Size: 0x2ea
function function_86515c3b( player, var_191ca105 )
{
    player namespace_83eb6304::function_3ecfde67( "lightningStrike" );
    player namespace_e32bb68::function_3a59ec34( "zmb_hellhound_bolt" );
    doa_banner::function_7a0e5387( var_191ca105.var_af104f33 );
    var_f1bda869 = namespace_ec06fe4a::spawnmodel( player.origin + ( 0, 0, 1500 ), var_191ca105.var_3831681e );
    
    if ( isdefined( var_f1bda869 ) )
    {
        var_f1bda869.angles = var_191ca105.var_d75b5b21;
        var_f1bda869 namespace_dfc652ee::function_7e4e4b8a( player, 0 );
        player namespace_83eb6304::function_3ecfde67( var_191ca105.fx );
        player namespace_e32bb68::function_3a59ec34( var_191ca105.sfx );
        var_f1bda869 delete();
    }
    
    player.doa.var_484cc88b |= var_191ca105.var_c8386627;
    
    switch ( var_191ca105.var_c8386627 )
    {
        case 1:
            player.doa.var_ed8fde10 = "zombietron_deathmachine";
            player namespace_41cb996::function_8b7acf56();
            break;
        case 2:
            if ( player.doa.score.var_194c59ae < 2 )
            {
                player.doa.score.var_194c59ae = 2;
            }
            
            break;
        case 4:
            player.var_20a27350 = player namespace_4ff32993::function_f69400ca( "zombietron_fated_chicken", 1, 1.2 );
            break;
        case 8:
            player.doa.var_e5805edb = 1.5;
            player setmovespeedscale( player.doa.var_e5805edb );
            player namespace_83eb6304::function_3ecfde67( "fast_feet" );
            break;
        default:
            assert( 0, "<dev string:x38>" );
            break;
    }
}

// Namespace namespace_1c2a96f9/namespace_1c2a96f9
// Params 0
// Checksum 0x8c7fcb20, Offset: 0xe30
// Size: 0x68
function function_9e59136f()
{
    if ( !isplayer( self ) )
    {
        return 0;
    }
    
    assert( isdefined( self.doa.var_484cc88b ), "<dev string:x4e>" );
    return self.doa.var_484cc88b & 1;
}

// Namespace namespace_1c2a96f9/namespace_1c2a96f9
// Params 0
// Checksum 0xe9a5ba9c, Offset: 0xea0
// Size: 0x68
function function_d17f9bcb()
{
    if ( !isplayer( self ) )
    {
        return 0;
    }
    
    assert( isdefined( self.doa.var_484cc88b ), "<dev string:x4e>" );
    return self.doa.var_484cc88b & 8;
}

// Namespace namespace_1c2a96f9/namespace_1c2a96f9
// Params 0
// Checksum 0x59690441, Offset: 0xf10
// Size: 0x68
function function_d5b51f1e()
{
    if ( !isplayer( self ) )
    {
        return 0;
    }
    
    assert( isdefined( self.doa.var_484cc88b ), "<dev string:x4e>" );
    return self.doa.var_484cc88b & 4;
}

// Namespace namespace_1c2a96f9/namespace_1c2a96f9
// Params 0
// Checksum 0xea9f231a, Offset: 0xf80
// Size: 0x68
function function_d438e371()
{
    if ( !isplayer( self ) )
    {
        return 0;
    }
    
    assert( isdefined( self.doa.var_484cc88b ), "<dev string:x4e>" );
    return self.doa.var_484cc88b & 2;
}

// Namespace namespace_1c2a96f9/namespace_1c2a96f9
// Params 1
// Checksum 0xbd71ca69, Offset: 0xff0
// Size: 0x38
function function_4808b985( time )
{
    if ( !self function_d438e371() )
    {
        return time;
    }
    
    return time * 1.3;
}

// Namespace namespace_1c2a96f9/namespace_1c2a96f9
// Params 0
// Checksum 0xddff33cc, Offset: 0x1030
// Size: 0x6f8
function function_11463552()
{
    var_637c4df = getent( "room_of_fate_shaft_trigger", "targetname" );
    result = var_637c4df waittill( #"trigger" );
    
    foreach ( player in getplayers() )
    {
        player thread namespace_7f5aeb59::turnplayershieldon( 0 );
        
        if ( player === result.activator )
        {
            continue;
        }
        
        player setorigin( var_637c4df.origin );
        
        if ( !isalive( player ) || is_true( player.doa.respawning ) )
        {
            player namespace_7f5aeb59::function_513831e1();
        }
    }
    
    level util::set_lighting_state( 3, 0 );
    var_b01b0395 = getent( "room_of_fate_trigger", "targetname" );
    result = var_b01b0395 waittill( #"trigger" );
    level flag::set( "doa_rof_visited" );
    var_7f432780 = array::randomize( struct::get_array( "room_of_fate_origin", "targetname" ) );
    wait 5;
    level doa_banner::function_7a0e5387( 41 );
    wait 3;
    
    for ( i = 0; i < var_7f432780.size ; i++ )
    {
        assert( i < level.doa.var_fe92efd8.size );
        fate = level.doa.var_fe92efd8[ i ];
        model = "zombietron_fate_rock_friend";
        
        if ( is_true( level.doa.var_2e2d85d4 ) )
        {
            model = fate.model;
        }
        
        model = namespace_ec06fe4a::spawnmodel( var_7f432780[ i ].origin + ( 0, 0, 1500 ), model );
        
        if ( isdefined( model ) )
        {
            model solid();
            model.data = fate;
            model.context = 1;
            model.dest = var_7f432780[ i ].origin;
            model.angles = ( 0, randomint( 180 ), 0 );
            model thread function_e4867f1d( fate );
            var_7f432780[ i ].model = model;
            objective_onentity( 10 + i, model );
            objective_setstate( 10 + i, "active" );
        }
    }
    
    if ( isdefined( level.doa.var_a5d58dd1 ) )
    {
        timeout = level.doa.var_a5d58dd1 * 1000 + gettime();
    }
    else
    {
        timeout = 45000 + gettime();
    }
    
    warning = timeout - 15000;
    lasttime = gettime();
    alldone = 0;
    
    while ( !alldone )
    {
        time = gettime();
        
        if ( time > timeout )
        {
            break;
        }
        
        if ( lasttime <= warning && time > warning )
        {
            level doa_banner::function_7a0e5387( 42 );
        }
        
        lasttime = time;
        wait 1;
        alldone = 1;
        
        foreach ( player in namespace_7f5aeb59::function_23e1f90f() )
        {
            if ( !isdefined( player.doa.rof ) )
            {
                alldone = 0;
                break;
            }
        }
    }
    
    level notify( #"hash_60341577c9ac6277" );
    
    for ( i = 0; i < var_7f432780.size ; i++ )
    {
        objective_setstate( 10 + i, "invisible" );
        
        if ( isdefined( var_7f432780[ i ].model.trigger ) )
        {
            var_7f432780[ i ].model.trigger delete();
        }
        
        if ( isdefined( var_7f432780[ i ].model ) )
        {
            var_7f432780[ i ].model moveto( var_7f432780[ i ].model.origin + ( 0, 0, 1500 ), 1 );
            var_7f432780[ i ].model waittill( #"movedone" );
            
            if ( isdefined( var_7f432780[ i ].model ) )
            {
                var_7f432780[ i ].model delete();
            }
        }
    }
    
    level notify( #"hash_7626a6770055d63c", { #banner:43 } );
}

// Namespace namespace_1c2a96f9/namespace_1c2a96f9
// Params 1
// Checksum 0x341d4266, Offset: 0x1730
// Size: 0x2ac
function function_e4867f1d( fate )
{
    self endon( #"death" );
    level endon( #"hash_60341577c9ac6277" );
    self moveto( self.dest, 1 );
    self thread namespace_ec06fe4a::function_d55f042c( level, "game_over" );
    wait 0.9;
    self namespace_83eb6304::function_3ecfde67( "fate_landing" );
    self namespace_e32bb68::function_3a59ec34( "zmb_hellhound_bolt" );
    wait 1;
    trigger = namespace_ec06fe4a::spawntrigger( "trigger_radius", self.dest, 0, 128, 256 );
    
    if ( isdefined( trigger ) )
    {
        self.trigger = trigger;
        trigger thread namespace_ec06fe4a::function_d55f042c( level, "game_over" );
        
        while ( true )
        {
            result = trigger waittill( #"trigger" );
            player = result.activator;
            
            if ( isdefined( player.doa.rof ) )
            {
                continue;
            }
            
            if ( isdefined( player.doa.var_e448d81 ) )
            {
                continue;
            }
            
            if ( !player function_afe89b8c( fate.var_c8386627 ) )
            {
                self namespace_83eb6304::function_3ecfde67( "lightningStrike" );
                self namespace_e32bb68::function_3a59ec34( "zmb_hellhound_bolt" );
                break;
            }
        }
        
        player.doa.var_e448d81 = 1;
        self namespace_83eb6304::function_3ecfde67( "fate_explo" );
        level function_42b0778( self, player );
        
        if ( isdefined( player ) )
        {
            player.doa.rof = fate.var_c8386627;
            player.doa.var_e448d81 = undefined;
        }
        
        return;
    }
    
    assert( 0, "<dev string:x66>" );
}

