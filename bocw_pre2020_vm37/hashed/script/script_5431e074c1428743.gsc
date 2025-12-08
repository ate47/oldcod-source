#using script_3626f1b2cf51a99c;
#using script_52da18c20f45c56a;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\bb;
#using scripts\cp_common\ui\prompts;
#using scripts\cp_common\util;

#namespace namespace_9c83b58d;

// Namespace namespace_9c83b58d/namespace_9c83b58d
// Params 0, eflags: 0x6
// Checksum 0x1a8e93fa, Offset: 0x2c0
// Size: 0x44
function private autoexec __init__system__()
{
    system::register( #"hash_7e93e9089f28804f", &preinit, undefined, undefined, #"actions" );
}

// Namespace namespace_9c83b58d/namespace_9c83b58d
// Params 0, eflags: 0x4
// Checksum 0xb5d6c8c0, Offset: 0x310
// Size: 0x22c
function private preinit()
{
    if ( !isdefined( level.takedowns ) )
    {
        /#
            function_5ac4dc99( "<dev string:x38>", "<dev string:x4a>" );
        #/
        
        /#
            function_5ac4dc99( "<dev string:x4e>", 0 );
        #/
        
        level.takedowns = spawnstruct();
        level.takedowns.takedowns = [];
        level.takedowns.callbackoverride = [];
        function_4cb18218();
        animation::add_global_notetrack_handler( "death", &takedown_death, 0 );
        animation::add_global_notetrack_handler( "ragdoll", &takedown_ragdoll, 0 );
        animation::add_global_notetrack_handler( "start_ragdoll", &takedown_ragdoll, 0 );
        actions::action_register( "takedown", &function_69bc40d4 );
        function_cd140ee9( "player_useRadius", &function_c30fad9a );
        function_cd140ee9( "ai_corpseSynch", &function_c30fad9a );
        
        /#
            function_cd140ee9( "<dev string:x62>", &function_c30fad9a );
        #/
        
        /#
            function_cd140ee9( "<dev string:x38>", &function_c30fad9a );
        #/
        
        /#
            function_cd140ee9( "<dev string:x4e>", &function_c30fad9a );
        #/
    }
}

// Namespace namespace_9c83b58d/namespace_9c83b58d
// Params 0, eflags: 0x4
// Checksum 0x6ebce916, Offset: 0x548
// Size: 0x296
function private function_c30fad9a()
{
    foreach ( player in getplayers() )
    {
        if ( !isdefined( player.takedown ) )
        {
            player.takedown = spawnstruct();
        }
        
        if ( !isdefined( player.takedown.victim ) )
        {
            player.takedown.victim = [];
        }
        
        /#
            if ( !isdefined( player.takedown.debug ) )
            {
                player.takedown.debug = spawnstruct();
            }
        #/
        
        /#
            player.takedown.debug.debug_actions = getdvarint( #"debug_actions", 0 ) ? 1 : undefined;
            player.takedown.debug.takedown_scene = getdvarstring( #"takedown_scene", "<dev string:x4a>" );
            player.takedown.debug.takedown_disable = getdvarint( #"takedown_disable", 0 ) ? 1 : undefined;
            
            if ( is_true( player.takedown.debug.debug_actions ) )
            {
                player thread actions::function_d661f822();
            }
            else
            {
                player notify( #"hash_2eaf8be0116c39a9" );
            }
        #/
        
        player.takedown.use_radius = getdvarfloat( #"player_useradius" );
        player.takedown.ai_corpsesynch = getdvarint( #"ai_corpsesynch", 0 );
    }
}

// Namespace namespace_9c83b58d/namespace_9c83b58d
// Params 0, eflags: 0x4
// Checksum 0xaaf28c94, Offset: 0x7e8
// Size: 0xa8
function private function_4cb18218()
{
    var_223ffdd1 = getscriptbundlenames( "takedown" );
    
    foreach ( bundle_name in var_223ffdd1 )
    {
        level function_8528a766( bundle_name );
    }
}

// Namespace namespace_9c83b58d/namespace_9c83b58d
// Params 1, eflags: 0x4
// Checksum 0x21a34c44, Offset: 0x898
// Size: 0x6dc
function private function_8528a766( bundle_name )
{
    takedown = getscriptbundle( bundle_name );
    
    if ( !isdefined( takedown ) )
    {
        return;
    }
    
    assert( takedown.type == "<dev string:x73>" );
    assert( isdefined( level.takedowns ) );
    takedownstored = spawnstruct();
    takedownstored.scenes = [];
    
    if ( isdefined( takedown.scenes ) )
    {
        foreach ( scene in takedown.scenes )
        {
            if ( isdefined( scene.scene ) && scene.scene != "" )
            {
                takedownstored.scenes[ takedownstored.scenes.size ] = scene.scene;
            }
        }
    }
    
    if ( takedownstored.scenes.size > 0 )
    {
        takedownstored.name = takedown.name;
        takedownstored.prompt = isdefined( takedown.prompt ) ? takedown.prompt : undefined;
        takedownstored.combat = is_true( takedown.combat ) ? 1 : undefined;
        takedownstored.var_72a597df = is_true( takedown.var_72a597df ) ? 1 : undefined;
        takedownstored.sprint = is_true( takedown.sprint ) ? 1 : undefined;
        takedownstored.notsprint = is_true( takedown.notsprint ) ? 1 : undefined;
        takedownstored.slide = is_true( takedown.slide ) ? 1 : undefined;
        takedownstored.notslide = is_true( takedown.notslide ) ? 1 : undefined;
        
        if ( isdefined( takedown.action ) )
        {
            actions = strtok( takedown.action, " ," );
            
            foreach ( actionname in actions )
            {
                takedownstored.actions[ actionname ] = 1;
            }
        }
        
        takedownstored.var_ad61bf60 = isdefined( takedown.yawrange ) && takedown.yawrange < 180 ? anglestoforward( ( 0, isdefined( takedown.yaw ) ? takedown.yaw : 0, 0 ) ) : undefined;
        takedownstored.yawrangecos = isdefined( takedown.yawrange ) && takedown.yawrange < 180 ? cos( takedown.yawrange ) : undefined;
        takedownstored.var_4c067ed7 = isdefined( takedown.minrange ) && takedown.minrange > 0 ? sqr( takedown.minrange ) : undefined;
        takedownstored.var_6465622a = isdefined( takedown.maxrange ) ? sqr( takedown.maxrange ) : undefined;
        takedownstored.minheight = isdefined( takedown.minheight ) ? takedown.minheight : undefined;
        takedownstored.maxheight = isdefined( takedown.maxheight ) ? takedown.maxheight : undefined;
        takedownstored.trace = is_true( takedown.trace ) ? 1 : undefined;
        takedownstored.traceheight = is_true( takedown.trace ) ? takedown.traceheight : undefined;
        takedownstored.stancestand = is_true( takedown.stancestand ) ? 1 : undefined;
        takedownstored.stancecrouch = is_true( takedown.stancecrouch ) ? 1 : undefined;
        takedownstored.stanceprone = is_true( takedown.stanceprone ) ? 1 : undefined;
        level.takedowns.takedowns[ takedown.name ] = takedownstored;
        level.takedowns.maxrange = max( isdefined( level.takedowns.maxrange ) ? level.takedowns.maxrange : 0, isdefined( takedown.maxrange ) ? takedown.maxrange : 0 );
        return;
    }
    
    assertmsg( "<dev string:x7f>" + takedown.name + "<dev string:x8e>" );
}

// Namespace namespace_9c83b58d/namespace_9c83b58d
// Params 0, eflags: 0x4
// Checksum 0xa95f51bb, Offset: 0xf80
// Size: 0xd4
function private player_init()
{
    assert( isplayer( self ) );
    
    if ( !isdefined( self.takedown ) )
    {
        if ( !isdefined( self.takedown ) )
        {
            self.takedown = spawnstruct();
        }
        
        /#
            if ( !isdefined( self.takedown.debug ) )
            {
                self.takedown.debug = spawnstruct();
            }
        #/
        
        self.takedown.disabled = undefined;
        self.takedown.disable_drop = undefined;
        self.takedown.victim = [];
        function_c30fad9a();
    }
}

// Namespace namespace_9c83b58d/namespace_9c83b58d
// Params 1, eflags: 0x4
// Checksum 0xc2dd01df, Offset: 0x1060
// Size: 0xa6
function private function_69bc40d4( action )
{
    self endon( action.ender );
    self player_init();
    self thread function_e3bc3dc9( action );
    var_3f34aa83 = self actions::function_83bde308( action, "melee" );
    
    if ( is_true( var_3f34aa83 ) )
    {
        return self function_3bab44ea( action );
    }
    
    return 0;
}

// Namespace namespace_9c83b58d/namespace_9c83b58d
// Params 3
// Checksum 0x2ad35f02, Offset: 0x1110
// Size: 0x18c, Type: bool
function function_3bab44ea( action, fullbody, *var_a2ca14bc )
{
    self endon( fullbody.ender );
    
    if ( is_true( self.takedown.disabled ) )
    {
        return false;
    }
    
    if ( function_f8af9078( fullbody.name ) )
    {
        return false;
    }
    
    if ( isalive( self.takedown.victim[ fullbody.name ] ) )
    {
        victim = self.takedown.victim[ fullbody.name ];
        scene = self.takedown.scene[ fullbody.name ];
        
        if ( isdefined( victim ) && isdefined( scene ) )
        {
            self notify( "takedown_monitor_generic_" + fullbody.name );
            
            if ( isdefined( level.takedowns.callbackoverride[ fullbody.name ] ) )
            {
                self thread [[ level.takedowns.callbackoverride[ fullbody.name ] ]]();
            }
            else
            {
                self thread function_7395fe24( fullbody, var_a2ca14bc, victim, scene );
            }
            
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_9c83b58d/namespace_9c83b58d
// Params 4
// Checksum 0xba79fe31, Offset: 0x12a8
// Size: 0x37c
function function_7395fe24( action, fullbody, victim, scene )
{
    self endon( action.ender );
    self.takedown.weapon = self getcurrentweapon();
    self.takedown.var_e62b225a = self action_utility::function_1a2a3654();
    self.takedown.start_origin = self.origin;
    self.in_melee_death = 1;
    self val::set( #"action", "takedamage", 0 );
    
    if ( !isalive( victim ) )
    {
        self actions::function_942d9213();
        return;
    }
    
    if ( isdefined( victim ) )
    {
        victim notify( #"takedown_begin" );
        victim action_utility::function_71180c30( 1 );
        victim prompts::remove( #"melee" );
        victim util::remove_cursor_hint();
        victim.in_melee_death = 1;
        
        if ( isdefined( level.var_ab828d57 ) )
        {
            victim util::delay( 0.1, undefined, level.var_ab828d57 );
        }
        
        if ( victim scene::function_c935c42() )
        {
            [[ victim._scene_object._o_scene ]]->stop();
        }
        
        victim stopanimscripted();
        victim flag::set( "scripted_lookat_disable" );
        victim ai::look_at( undefined, 0 );
        
        if ( !isalive( victim ) )
        {
            self actions::function_942d9213();
            return;
        }
        
        victim util::delay( 0.5, "takedown_executed", &action_utility::function_71180c30, 0 );
        victim.animname = "generic";
    }
    
    self action_utility::function_b0190b65( action );
    self action_utility::function_c0f7b46e( fullbody, 1 );
    
    if ( actions::function_1028d928( action.name, "grab" ) )
    {
        self.takedown.var_67582ca5 = victim;
        self function_6940d001( action, scene, 0.25, "grab" );
    }
    
    self thread function_7ef965ed( action );
    victim thread function_970b3d76( action, scene, self );
}

// Namespace namespace_9c83b58d/namespace_9c83b58d
// Params 4
// Checksum 0x69da4879, Offset: 0x1630
// Size: 0x184
function function_6940d001( action, scene, time, var_9386e7ce )
{
    victim = self.takedown.victim[ action.name ];
    assert( isalive( victim ) );
    self action_utility::allow_weapon( 0 );
    scene_root = victim function_4c0949f2( self, scene );
    var_86b37828 = self.takedown.takedown[ action.name ].name;
    
    if ( time > 0 )
    {
        wait time;
    }
    
    self util::delay( 0.2, undefined, &function_1c85708e );
    
    if ( self actions::function_ae44e21b( action, "melee" ) )
    {
        if ( isweapon( self.takedown.var_e62b225a ) )
        {
            self action_utility::function_b56ad054();
            self actions::function_3af7d065( 1, var_9386e7ce );
        }
    }
}

// Namespace namespace_9c83b58d/namespace_9c83b58d
// Params 0
// Checksum 0xef4fdd7d, Offset: 0x17c0
// Size: 0x1c
function function_1c85708e()
{
    self.var_6639d45b action_utility::function_30b535ff( 0 );
}

// Namespace namespace_9c83b58d/namespace_9c83b58d
// Params 1
// Checksum 0xdc60f114, Offset: 0x17e8
// Size: 0x2d2
function function_41abe76e( *action )
{
    assert( isplayer( self ) );
    now = gettime();
    
    if ( ( isdefined( self.takedown.var_e38a7cb3 ) ? self.takedown.var_e38a7cb3 : -1 ) == now )
    {
        return self.takedown.var_41abe76e;
    }
    
    self.takedown.var_41abe76e = 1;
    stance = self getstance();
    
    if ( !isalive( self ) )
    {
        self.takedown.var_41abe76e = 0;
    }
    else if ( isdefined( self getlinkedent() ) )
    {
        self.takedown.var_41abe76e = 0;
    }
    else if ( is_true( self.takedown.disabled ) )
    {
        self.takedown.var_41abe76e = 0;
    }
    else if ( stance == "prone" )
    {
        self.takedown.var_41abe76e = 0;
    }
    else if ( self isthrowinggrenade() )
    {
        self.takedown.var_41abe76e = 0;
    }
    else if ( self getcurrentweapon().name == "none" )
    {
        self.takedown.var_41abe76e = 0;
    }
    else if ( stance !== "stand" )
    {
        if ( !self isstanceallowed( "stand" ) )
        {
            self.takedown.var_41abe76e = 0;
        }
        else
        {
            startz = 0.1;
            endz = 0.2;
            traceresult = playerphysicstrace( self.origin + ( 0, 0, startz ), self.origin + ( 0, 0, endz ) );
            
            if ( traceresult[ 2 ] < self.origin[ 2 ] + endz )
            {
                self.takedown.var_41abe76e = 0;
            }
        }
    }
    
    self.takedown.var_e38a7cb3 = now;
    return self.takedown.var_41abe76e;
}

// Namespace namespace_9c83b58d/namespace_9c83b58d
// Params 1
// Checksum 0x9252adc8, Offset: 0x1ac8
// Size: 0x924
function function_e3bc3dc9( action )
{
    self notify( "takedown_monitor_generic_" + action.name );
    self endoncallback( &function_7d4b1333, action.ender, #"death", #"disconnect", "takedown_monitor_generic_" + action.name );
    self.takedown.var_bf0ca7db[ action.name ] = 0;
    var_ac859813 = "take_down";
    
    if ( isdefined( level.takedowns.var_ac859813 ) && isdefined( level.takedowns.var_ac859813[ action.name ] ) )
    {
        var_ac859813 = level.takedowns.var_ac859813[ action.name ];
    }
    
    while ( true )
    {
        waitframe( 1 );
        
        if ( isdefined( self.takedown.victim[ action.name ] ) && self.takedown.allow_melee )
        {
            self function_db07e398( action.name, undefined );
        }
        
        if ( level flag::get( "hold_context_melee" ) )
        {
            self function_7a061b23( 1, action.name );
            level flag::wait_till_clear( "hold_context_melee" );
        }
        
        if ( !self function_41abe76e( action ) )
        {
            self function_7a061b23( 1, action.name );
            continue;
        }
        
        var_ebd06be2 = self function_5ca78f5a( action );
        
        if ( isdefined( var_ebd06be2 ) )
        {
            self function_db07e398( action.name, var_ebd06be2[ 0 ] );
            self.takedown.scene[ action.name ] = var_ebd06be2[ 1 ];
            self.takedown.takedown[ action.name ] = var_ebd06be2[ 2 ];
            
            if ( !self.takedown.var_bf0ca7db[ action.name ] && self.var_2cb06cc6.name == "root" )
            {
                var_22a9143 = actions::function_1028d928( action.name, "grab" );
                var_86b37828 = self.takedown.takedown[ action.name ].name;
                prompttext = self.takedown.takedown[ action.name ].prompt;
                self.takedown.victim[ action.name ] prompts::create( #"melee", prompttext );
                self.takedown.victim[ action.name ] prompts::function_a4cf2cde( { #tag:"j_spine4" } );
                self.takedown.victim[ action.name ] prompts::function_92127496( 1 );
                self.takedown.victim[ action.name ] prompts::function_44d7831a( #"melee", 0 );
                self.takedown.victim[ action.name ] prompts::function_8f5eb0a6( #"melee", 0 );
                self.takedown.victim[ action.name ] prompts::function_d03d79d6( #"melee", 0 );
                self.takedown.victim[ action.name ] prompts::function_68782902( #"melee", 1000 );
                self.takedown.victim[ action.name ] prompts::function_b95d71cd( #"melee", 180 );
                self.takedown.victim[ action.name ] prompts::create( #"melee_hold", #"hash_4759bc1b8324047c" );
                self.takedown.victim[ action.name ] prompts::function_46df0bc7( #"melee", 5 );
                self.takedown.victim[ action.name ] prompts::function_44d7831a( #"melee_hold", 0 );
                self.takedown.victim[ action.name ] prompts::function_8f5eb0a6( #"melee_hold", 0.1 );
                self.takedown.victim[ action.name ] prompts::function_d03d79d6( #"melee_hold", 0.15 );
                self.takedown.victim[ action.name ] prompts::function_a4a9acfc( #"melee_hold", &function_3cadc363 );
                self.takedown.victim[ action.name ] prompts::function_68782902( #"melee_hold", 1000 );
                self.takedown.victim[ action.name ] prompts::function_b95d71cd( #"melee_hold", 180 );
                self thread takedown_prompt_monitor( action, var_86b37828 );
                self.takedown.var_bf0ca7db[ action.name ] = 1;
            }
            
            self function_7a061b23( 0, action.name );
            
            /#
                if ( is_true( self.takedown.debug.debug_actions ) && isentity( var_ebd06be2[ 0 ] ) && isdefined( var_ebd06be2[ 1 ] ) )
                {
                    debugstar( var_ebd06be2[ 0 ].origin + ( 0, 0, 30 ), 1, ( 1, 0, 0 ), var_ebd06be2[ 1 ], 0.1 );
                }
            #/
        }
        else
        {
            self function_db07e398( action.name, undefined );
            self function_7a061b23( 1, action.name );
        }
        
        foreach ( key, value in self.takedown.victim )
        {
            if ( !isdefined( value ) )
            {
                self function_db07e398( key, undefined );
            }
        }
    }
}

// Namespace namespace_9c83b58d/namespace_9c83b58d
// Params 1, eflags: 0x4
// Checksum 0x6664b802, Offset: 0x23f8
// Size: 0x6a
function private function_3cadc363( prompt_struct )
{
    assert( isplayer( prompt_struct.player ) );
    return isweapon( prompt_struct.player action_utility::function_1a2a3654() );
}

// Namespace namespace_9c83b58d/namespace_9c83b58d
// Params 1, eflags: 0x4
// Checksum 0xa41481f6, Offset: 0x2470
// Size: 0x24
function private function_7d4b1333( *params )
{
    self function_7a061b23( 1, undefined );
}

// Namespace namespace_9c83b58d/namespace_9c83b58d
// Params 3
// Checksum 0x714a728, Offset: 0x24a0
// Size: 0x158
function takedown_prompt_monitor( action, var_d426470, var_72612ea0 )
{
    assert( isplayer( self ) );
    self notify( "takedown_prompt_monitor" + ( isdefined( var_d426470 ) ? var_d426470 : "_" ) + ( isdefined( var_72612ea0 ) ? var_72612ea0 : "_" ) );
    self endon( "takedown_prompt_monitor" + ( isdefined( var_d426470 ) ? var_d426470 : "_" ) + ( isdefined( var_72612ea0 ) ? var_72612ea0 : "_" ) );
    self endon( action.ender );
    
    while ( true )
    {
        if ( !isdefined( self.takedown.victim ) || self.takedown.victim.size == 0 || is_true( self.in_melee_death ) )
        {
            self function_db07e398( action.name, undefined );
            return;
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_9c83b58d/namespace_9c83b58d
// Params 1
// Checksum 0xf9541b9b, Offset: 0x2600
// Size: 0x6a
function function_146a3d56( enemy )
{
    assert( isplayer( self ) );
    return vectornormalize( enemy.var_97e2c0da.check_origin - self getplayercamerapos() );
}

// Namespace namespace_9c83b58d/namespace_9c83b58d
// Params 1
// Checksum 0xd6541143, Offset: 0x2678
// Size: 0x3d4
function function_5ca78f5a( action )
{
    assert( isplayer( self ) );
    now = gettime();
    result = undefined;
    
    if ( ( isdefined( self.takedown.var_8630163b ) ? self.takedown.var_8630163b : -1 ) != now )
    {
        self.takedown.potential_victims = function_e45cbe76( self.origin, level.takedowns.maxrange, "axis" );
        self.takedown.var_8630163b = now;
    }
    
    if ( self.takedown.potential_victims.size > 0 )
    {
        fwd = anglestoforward( self getplayerangles() );
        var_e3cd155d = vectornormalize( ( fwd[ 0 ], fwd[ 1 ], 0 ) );
        playereye = self getplayercamerapos();
        best_dot = -1;
        
        foreach ( enemy in self.takedown.potential_victims )
        {
            if ( !isalive( enemy ) )
            {
                continue;
            }
            
            if ( is_true( enemy.var_c681e4c1 ) )
            {
                continue;
            }
            
            if ( enemy.takedamage === 0 )
            {
                continue;
            }
            
            if ( enemy.species !== #"human" )
            {
                continue;
            }
            
            victim_scene = function_3c43bd2a( action, enemy, self );
            
            if ( isdefined( victim_scene.scene ) )
            {
                dir = self function_146a3d56( enemy );
                dot = vectordot( fwd, dir );
                
                if ( dot > best_dot )
                {
                    best_dot = dot;
                    
                    if ( isdefined( enemy.takedown_scene ) )
                    {
                        victim_scene.scene = enemy.takedown_scene;
                    }
                    
                    /#
                        if ( isdefined( self.takedown.debug.takedown_scene ) && self.takedown.debug.takedown_scene != "<dev string:x4a>" && isdefined( getscriptbundle( self.takedown.debug.takedown_scene ) ) )
                        {
                            victim_scene.scene = self.takedown.debug.takedown_scene;
                        }
                    #/
                    
                    result = [ enemy, victim_scene.scene, victim_scene.takedown ];
                }
            }
        }
    }
    
    return result;
}

// Namespace namespace_9c83b58d/namespace_9c83b58d
// Params 3
// Checksum 0xaab10187, Offset: 0x2a58
// Size: 0x1c4
function function_3c43bd2a( action, victim, player )
{
    assert( isplayer( player ) );
    assert( isai( victim ) );
    resultscene = undefined;
    resulttakedown = undefined;
    victim function_8c04a084( player );
    
    foreach ( takedown in level.takedowns.takedowns )
    {
        validplayer = player function_be279d34( action, takedown, victim );
        
        if ( validplayer )
        {
            validvictim = victim function_c943b729( action, takedown, player );
            
            if ( validvictim )
            {
                resultscene = self function_945b4efe( takedown );
                resulttakedown = takedown;
                break;
            }
        }
    }
    
    return { #scene:resultscene, #takedown:resulttakedown };
}

// Namespace namespace_9c83b58d/namespace_9c83b58d
// Params 3
// Checksum 0x81d23ea9, Offset: 0x2c28
// Size: 0x27a, Type: bool
function function_be279d34( action, takedown, enemy )
{
    assert( isplayer( self ) );
    assert( isdefined( takedown ) );
    
    if ( isdefined( takedown.actions ) && !is_true( takedown.actions[ action.name ] ) )
    {
        return false;
    }
    
    if ( ( isdefined( self.health ) ? self.health : 0 ) <= 0 )
    {
        return false;
    }
    
    /#
        if ( is_true( self.takedown.debug.takedown_disable ) )
        {
            return false;
        }
    #/
    
    dir = self function_146a3d56( enemy );
    dir_2d = vectornormalize( ( dir[ 0 ], dir[ 1 ], 0 ) );
    
    if ( vectordot( dir_2d, anglestoforward( self.angles ) ) < 0.7 )
    {
        return false;
    }
    
    if ( !is_true( takedown.sprint ) && self issprinting() )
    {
        return false;
    }
    
    if ( !is_true( takedown.notsprint ) && !self issprinting() )
    {
        return false;
    }
    
    if ( !is_true( takedown.slide ) && self issliding() )
    {
        return false;
    }
    
    if ( !is_true( takedown.notslide ) && !self issliding() )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_9c83b58d/namespace_9c83b58d
// Params 3
// Checksum 0x99acbf94, Offset: 0x2eb0
// Size: 0x454, Type: bool
function function_c943b729( *action, takedown, player )
{
    assert( isactor( self ) );
    
    if ( !( isdefined( takedown ) && isdefined( player ) ) )
    {
        return false;
    }
    
    distsqr = distancesquared( player.origin, self.origin );
    combat = self function_2ae12730( player );
    
    if ( !is_true( takedown.combat ) && combat )
    {
        return false;
    }
    
    if ( !is_true( takedown.var_72a597df ) && !combat )
    {
        return false;
    }
    
    if ( isdefined( takedown.var_4c067ed7 ) && distsqr < takedown.var_4c067ed7 )
    {
        return false;
    }
    
    if ( isdefined( takedown.var_6465622a ) && distsqr > takedown.var_6465622a )
    {
        return false;
    }
    
    switch ( blackboard::getstructblackboardattribute( self, "_stance" ) )
    {
        case #"stand":
            if ( !is_true( takedown.stancestand ) )
            {
                return false;
            }
            
            break;
        case #"crouch":
            if ( !is_true( takedown.stancecrouch ) )
            {
                return false;
            }
            
            break;
        case #"prone":
            if ( !is_true( takedown.stanceprone ) )
            {
                return false;
            }
            
            break;
        default:
            return false;
    }
    
    if ( isdefined( takedown.var_ad61bf60 ) && isdefined( takedown.yawrangecos ) )
    {
        worlddir = rotatepoint( takedown.var_ad61bf60, ( 0, self.angles[ 1 ], 0 ) );
        
        if ( vectordot( worlddir, self.var_97e2c0da.var_fe50a481 ) < takedown.yawrangecos )
        {
            return false;
        }
    }
    
    deltaz = self.origin[ 2 ] - player.origin[ 2 ];
    
    if ( isdefined( takedown.minheight ) && deltaz < takedown.minheight )
    {
        return false;
    }
    
    if ( isdefined( takedown.maxheight ) && deltaz > takedown.maxheight )
    {
        return false;
    }
    
    if ( is_true( takedown.trace ) )
    {
        zoffset = ( 0, 0, 24 );
        
        if ( isdefined( takedown.traceheight ) )
        {
            zoffset = ( 0, 0, takedown.traceheight );
        }
        
        start = player.origin + zoffset;
        end = self.var_97e2c0da.check_origin + zoffset;
        
        if ( !sighttracepassed( start, end, 0, self.var_a08ba405 ) )
        {
            /#
                if ( is_true( player.takedown.debug.debug_actions ) )
                {
                    line( start, end, ( 0.5, 0.5, 0.5 ), 1, 1, 1 );
                }
            #/
            
            return false;
        }
    }
    
    return true;
}

// Namespace namespace_9c83b58d/namespace_9c83b58d
// Params 2
// Checksum 0xa19d51a3, Offset: 0x3310
// Size: 0x1b2
function function_a4e4cef5( *action_name, player )
{
    assert( isplayer( player ) );
    
    if ( !isdefined( self.var_234d269 ) || self.var_234d269 != gettime() )
    {
        self.var_b87cdd12 = 1;
        playerfwd = anglestoforward( player getplayerangles() );
        playereye = player getplayercamerapos();
        delta = self geteye() - playereye;
        distclamp = math::clamp( distance( self geteye(), playereye ) - 30, 0, 120 );
        dotcheck = 0.5 + 0.44 * ( distclamp / 150 - 30 );
        
        if ( vectordot( vectornormalize( delta ), playerfwd ) < dotcheck )
        {
            self.var_b87cdd12 = 0;
        }
        
        self.var_234d269 = gettime();
    }
    
    return self.var_b87cdd12;
}

// Namespace namespace_9c83b58d/namespace_9c83b58d
// Params 0
// Checksum 0x31d26dc3, Offset: 0x34d0
// Size: 0x92
function function_5169db86()
{
    assert( isplayer( self ) );
    
    if ( isdefined( self.takedown.scene_root ) )
    {
        return self.takedown.scene_root;
    }
    
    scene_root = spawnstruct();
    scene_root.origin = self.origin;
    scene_root.angles = self.angles;
    return scene_root;
}

// Namespace namespace_9c83b58d/namespace_9c83b58d
// Params 7
// Checksum 0x443042d3, Offset: 0x3570
// Size: 0x38e
function function_dce515a6( guy, modelname, var_cf230c0, attach_tag, var_5f373dfe, var_a18e300c, aitype )
{
    assert( isplayer( self ) );
    assert( isdefined( attach_tag ) == isdefined( var_cf230c0 ) );
    
    if ( isdefined( attach_tag ) )
    {
        assert( attach_tag.size == var_cf230c0.size );
    }
    
    if ( !isdefined( aitype ) )
    {
        aitype = guy.aitype;
    }
    
    if ( !is_true( var_a18e300c ) )
    {
        if ( isalive( guy ) && guy !== self.takedown.body )
        {
            if ( isdefined( self.takedown.body ) && !self.takedown.body action_utility::function_30b535ff( 0 ) )
            {
                if ( isdefined( self.takedown.body.magic_bullet_shield ) )
                {
                    self.takedown.body util::stop_magic_bullet_shield();
                }
                
                self.takedown.body delete();
                self.takedown.body = undefined;
            }
            
            self.takedown.body = guy;
        }
        else if ( isdefined( self.takedown.body ) && isdefined( modelname ) && self.takedown.body.modelname !== modelname )
        {
            self.takedown.body setmodel( modelname );
            self.takedown.body.modelname = modelname;
        }
    }
    
    if ( !isdefined( self.takedown.body ) || is_true( var_a18e300c ) )
    {
        bodymodel = spawn( "script_model", self.origin );
        bodymodel.angles = self.angles;
        bodymodel.team = "axis";
        bodymodel.animname = "generic";
        bodymodel setmodel( modelname );
        bodymodel.modelname = modelname;
        bodymodel.ai_type = aitype;
        bodymodel action_utility::function_77af90aa( var_cf230c0, attach_tag );
        bodymodel useanimtree( "generic" );
        bodymodel action_utility::function_30b535ff( 1 );
        self.takedown.body = bodymodel;
    }
    
    if ( isdefined( var_5f373dfe ) )
    {
    }
    
    return self.takedown.body;
}

// Namespace namespace_9c83b58d/namespace_9c83b58d
// Params 2
// Checksum 0x821d29e, Offset: 0x3908
// Size: 0x1b6
function function_4c0949f2( player, scene )
{
    assert( isplayer( player ) );
    entid = self getentitynumber();
    
    if ( !isdefined( player.takedown.scene_root ) )
    {
        player.takedown.scene_root = spawnstruct();
    }
    
    scene_root = player.takedown.scene_root;
    
    if ( isdefined( self.takedown_origin ) )
    {
        scene_root.origin = self.takedown_origin;
    }
    else if ( isdefined( player.takedown.edge_origin[ entid ] ) )
    {
        scene_root.origin = player.takedown.edge_origin[ entid ];
    }
    else
    {
        scene_root.origin = self.origin;
    }
    
    if ( isdefined( self.takedown_angles ) )
    {
        scene_root.angles = self.takedown_angles;
    }
    else if ( isdefined( player.takedown.edge_angles[ entid ] ) )
    {
        scene_root.angles = player.takedown.edge_angles[ entid ];
    }
    else
    {
        scene_root.angles = player.angles;
    }
    
    scene_root.scriptbundlename = scene;
    scene_root.script_play_multiple = 1;
    scene_root.script_ignore_active_scene_check = 1;
    return scene_root;
}

// Namespace namespace_9c83b58d/namespace_9c83b58d
// Params 3
// Checksum 0xd0ea3f91, Offset: 0x3ac8
// Size: 0x3a4
function function_970b3d76( action, scene, player )
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    bb::function_cd497743( "takedown", player );
    player endon( action.ender );
    self notify( #"start_context_melee" );
    player flag::set( "takedown_active" );
    player notify( #"takedown_cleanup" );
    self prompts::remove( #"melee_hold" );
    self prompts::function_86eedc();
    waittillframeend();
    player thread actions::function_c004e236( "carry_body" );
    groundpos = util::ground_position( player.origin, 16, 64, player );
    player thread takedown_cleanup( action, [ action.ender, "takedown_cleanup" ], groundpos, player.takedown.stance[ action.name ] );
    scene_root = self function_4c0949f2( player, scene );
    player.var_edbc8698 = self;
    self.og_maxsightdistsqrd = self.maxsightdistsqrd;
    self.og_newenemyreactiondistsq = self.newenemyreactiondistsq;
    self.og_battlechatter = self.battlechatter;
    self.og_allowdeath = self.allowdeath;
    self.allowantigrav = 0;
    self.dontmelee = 1;
    self.maxsightdistsqrd = 1;
    self.fixednode = 0;
    self.ignoreme = 1;
    self.ignoreall = 1;
    self.newenemyreactiondistsq = 0;
    self.allowdeath = 0;
    self.a.disablepain = 1;
    self.allowpain = 0;
    self.battlechatterallowed = 0;
    self.takedown_anim = scene;
    self.remove_from_animloop = 1;
    self notify( #"takedown_executed" );
    
    if ( isdefined( self ) || isalive( self ) )
    {
        self util::delay( 5, "takedown_cleanup", &function_9e3a2c7f, self );
        scene_root action_utility::scene_play( scene, player, self );
        player thread function_c827d754( action );
        takedown_death( self );
    }
    
    player notify( #"takedown_cleanup" );
    player notify( #"takedown_end" );
    waitframe( 1 );
    player actions::function_942d9213();
}

// Namespace namespace_9c83b58d/namespace_9c83b58d
// Params 1
// Checksum 0xa362b3da, Offset: 0x3e78
// Size: 0x264
function function_c827d754( *action )
{
    assert( isplayer( self ) );
    step = 10;
    trace_pos = playerphysicstrace( self.origin + ( 0, 0, 1 ), self.origin );
    
    if ( trace_pos != self.origin )
    {
        trace_pos = playerphysicstrace( self.takedown.start_origin + ( 0, 0, step ), self.origin + ( 0, 0, step ) );
        
        if ( trace_pos[ 0 ] != self.origin[ 0 ] || trace_pos[ 1 ] != self.origin[ 1 ] )
        {
            trace_pos += vectornormalize( self.takedown.start_origin - self.origin );
        }
        
        trace_pos = playerphysicstrace( trace_pos, trace_pos - ( 0, 0, step ) );
        var_f5aab51b = playerphysicstrace( trace_pos + ( 0, 0, 1 ), trace_pos );
        
        if ( trace_pos != var_f5aab51b )
        {
            /#
                msg = "<dev string:xa7>" + self.takedown.start_origin[ 0 ] + "<dev string:xed>" + self.takedown.start_origin[ 1 ] + "<dev string:xed>" + self.takedown.start_origin[ 2 ] + "<dev string:xf3>";
                iprintlnbold( msg );
                println( msg + "<dev string:xf9>" );
            #/
            
            trace_pos = self.takedown.start_origin;
        }
        
        self setorigin( trace_pos );
    }
}

// Namespace namespace_9c83b58d/namespace_9c83b58d
// Params 2
// Checksum 0x41b7feff, Offset: 0x40e8
// Size: 0x2b6
function function_7a061b23( enabled, action_name )
{
    if ( !isdefined( self.takedown.var_9871533 ) )
    {
        self.takedown.var_9871533 = [];
        self.takedown.var_d4da26de = 0;
        self.takedown.allow_melee = 1;
    }
    
    if ( isdefined( action_name ) && !isdefined( self.takedown.var_9871533[ action_name ] ) )
    {
        assert( self.takedown.var_9871533.size <= 31 );
        self.takedown.var_9871533[ action_name ] = self.takedown.var_9871533.size;
    }
    
    bitmask = 0;
    
    if ( isdefined( action_name ) )
    {
        bitmask = 1 << self.takedown.var_9871533[ action_name ];
    }
    else
    {
        foreach ( bitindex in self.takedown.var_9871533 )
        {
            bitmask |= 1 << bitindex;
        }
    }
    
    if ( enabled )
    {
        self.takedown.var_d4da26de &= ~bitmask;
    }
    else
    {
        self.takedown.var_d4da26de |= bitmask;
    }
    
    var_b381ae79 = !self.takedown.var_d4da26de;
    
    if ( self.takedown.allow_melee == var_b381ae79 )
    {
        return;
    }
    
    if ( !is_true( var_b381ae79 ) )
    {
        self val::set( #"takedown_allow_melee", "allow_melee", 0 );
    }
    else
    {
        self val::reset( #"takedown_allow_melee", "allow_melee" );
    }
    
    self.takedown.allow_melee = var_b381ae79;
}

// Namespace namespace_9c83b58d/namespace_9c83b58d
// Params 1
// Checksum 0x21eb5aec, Offset: 0x43a8
// Size: 0xa6, Type: bool
function function_f8af9078( action_name )
{
    if ( isdefined( action_name ) )
    {
        if ( !isdefined( self.takedown.var_9871533 ) || !isdefined( self.takedown.var_9871533[ action_name ] ) )
        {
            return true;
        }
        
        bitmask = 1 << self.takedown.var_9871533[ action_name ];
        return ( ( self.takedown.var_d4da26de & bitmask ) == 0 );
    }
    
    return self.takedown.var_d4da26de == 0;
}

// Namespace namespace_9c83b58d/namespace_9c83b58d
// Params 1
// Checksum 0xafd1b3cb, Offset: 0x4458
// Size: 0x176
function takedown_death( guy )
{
    if ( !isdefined( guy ) )
    {
        return;
    }
    
    player = getplayers()[ 0 ];
    guy.skipdeathanim = 1;
    guy.noragdoll = 1;
    guy pushplayer( 0 );
    guy thread action_utility::function_91639a4c( 0 );
    
    if ( isdefined( level.var_ab828d57 ) )
    {
        guy util::delay( 0.1, undefined, level.var_ab828d57 );
    }
    
    guy.allowdeath = 1;
    guy.diequietly = 1;
    guy util::stop_magic_bullet_shield();
    
    if ( isdefined( guy.stealth ) )
    {
        guy.stealth.override_damage_auto_range = 60;
    }
    
    if ( isalive( guy ) )
    {
        guy kill( ( 0, 0, 0 ), player, player );
    }
    
    if ( !is_true( guy.takedown_ragdoll ) )
    {
        player.takedown.kill_origin = guy.origin;
    }
}

// Namespace namespace_9c83b58d/namespace_9c83b58d
// Params 1
// Checksum 0xedcefecf, Offset: 0x45d8
// Size: 0x24a
function takedown_ragdoll( guy )
{
    player = getplayers()[ 0 ];
    
    if ( !isdefined( guy ) && isdefined( player.takedown.kill_origin ) )
    {
        foreach ( corpse in getcorpsearray( player.origin, 500 ) )
        {
            if ( is_true( corpse.takedown_ragdoll ) )
            {
                continue;
            }
            
            if ( corpse isragdoll() )
            {
                continue;
            }
            
            corpseorigin = corpse.origin;
            
            if ( is_true( player.takedown.ai_corpsesynch ) )
            {
                corpseorigin = corpse getcorpsephysicsorigin();
            }
            
            if ( isdefined( corpseorigin ) && distancesquared( corpseorigin, player.takedown.kill_origin ) < sqr( 60 ) )
            {
                corpse startragdoll();
                corpse.takedown_ragdoll = 1;
            }
        }
    }
    else if ( isdefined( guy ) && !is_true( guy.takedown_ragdoll ) )
    {
        if ( isai( guy ) )
        {
        }
        
        guy startragdoll();
        guy.takedown_ragdoll = 1;
    }
    
    player.takedown.kill_origin = undefined;
}

// Namespace namespace_9c83b58d/namespace_9c83b58d
// Params 1
// Checksum 0x42c50220, Offset: 0x4830
// Size: 0x38e
function function_8c04a084( player )
{
    now = gettime();
    
    if ( ( isdefined( self.var_9959f16e ) ? self.var_9959f16e : -1 ) != now )
    {
        if ( !isdefined( self.var_97e2c0da ) )
        {
            self.var_97e2c0da = {};
        }
        
        tag = "tag_origin";
        tagangles = self gettagangles( tag );
        tagpos = self gettagorigin( tag );
        tagright = anglestoright( tagangles );
        tagfwd = anglestoforward( tagangles );
        var_b6db82af = player.origin - tagpos;
        var_b6db82af = ( var_b6db82af[ 0 ], var_b6db82af[ 1 ], 0 );
        var_b6db82af = vectornormalize( var_b6db82af );
        dotup = abs( vectordot( tagfwd, ( 0, 0, 1 ) ) );
        
        if ( dotup > 0.7 )
        {
            tagfwd = vectornormalize( ( tagright[ 0 ], tagright[ 1 ], 0 ) );
        }
        else
        {
            tagfwd = vectornormalize( ( tagfwd[ 0 ], tagfwd[ 1 ], 0 ) );
        }
        
        entfwd = anglestoforward( self.angles );
        
        if ( vectordot( var_b6db82af, entfwd ) > vectordot( tagfwd, entfwd ) )
        {
            tagfwd = entfwd;
        }
        
        tagright = vectorcross( tagfwd, ( 0, 0, 1 ) );
        self.var_97e2c0da.var_fe50a481 = var_b6db82af;
        self.var_97e2c0da.dot_forward = vectordot( tagfwd, var_b6db82af );
        self.var_97e2c0da.dot_right = vectordot( tagright, var_b6db82af );
        self.var_97e2c0da.height = self.origin[ 2 ] - player.origin[ 2 ];
        self.var_97e2c0da.height_abs = abs( self.var_97e2c0da.height );
        self.var_97e2c0da.check_origin = self gettagorigin( tag );
        self.var_97e2c0da.distsq = distancesquared( self.var_97e2c0da.check_origin, player getplayercamerapos() );
        self.var_9959f16e = now;
    }
    
    return self.var_97e2c0da;
}

// Namespace namespace_9c83b58d/namespace_9c83b58d
// Params 2
// Checksum 0x59a87ba5, Offset: 0x4bc8
// Size: 0x13c
function function_945b4efe( takedown, advance )
{
    assert( isplayer( self ) );
    
    if ( !isdefined( self.takedown.scene_deck[ takedown.name ] ) || self.takedown.scene_deck[ takedown.name ].size == 0 )
    {
        self.takedown.scene_deck[ takedown.name ] = array::randomize( arraycopy( takedown.scenes ) );
    }
    
    deck = self.takedown.scene_deck[ takedown.name ];
    result = deck[ deck.size - 1 ];
    
    if ( is_true( advance ) )
    {
        deck[ deck.size - 1 ] = undefined;
    }
    
    return result;
}

// Namespace namespace_9c83b58d/namespace_9c83b58d
// Params 4
// Checksum 0xa2f889da, Offset: 0x4d10
// Size: 0x1d4
function takedown_cleanup( action, var_949a9f8b, *originalorigin, var_d8ba335a )
{
    self notify( #"hash_7ef80ca5708348b8" );
    self endon( #"hash_7ef80ca5708348b8" );
    assert( isplayer( self ) );
    
    if ( isdefined( originalorigin ) )
    {
        if ( !isarray( originalorigin ) )
        {
            originalorigin = [ originalorigin ];
        }
        
        self waittill( originalorigin );
    }
    
    self action_utility::function_44a46209( var_d8ba335a );
    self val::reset_all( #"action" );
    
    if ( isalive( self.var_edbc8698 ) && !is_true( self.var_edbc8698.takedown_live ) )
    {
        self.var_edbc8698 stopanimscripted();
        self.var_edbc8698 kill( self.origin, self, self );
        self.var_edbc8698 = undefined;
    }
    
    self function_945b4efe( self.takedown.takedown[ var_949a9f8b.name ], 1 );
    self.in_melee_death = undefined;
    self flag::clear( "takedown_active" );
}

// Namespace namespace_9c83b58d/namespace_9c83b58d
// Params 1
// Checksum 0x9c2fe429, Offset: 0x4ef0
// Size: 0x74
function function_9e3a2c7f( guy )
{
    if ( isdefined( guy ) )
    {
        if ( isalive( guy ) )
        {
            if ( isdefined( guy.magic_bullet_shield ) )
            {
                guy util::stop_magic_bullet_shield();
            }
            
            println( "<dev string:xfe>" );
        }
    }
}

// Namespace namespace_9c83b58d/namespace_9c83b58d
// Params 1
// Checksum 0xfd030013, Offset: 0x4f70
// Size: 0x64
function function_7ef965ed( action )
{
    self waittill( action.ender );
    self function_7a061b23( 1, action.name );
    self function_db07e398( action.name, undefined );
}

// Namespace namespace_9c83b58d/namespace_9c83b58d
// Params 2
// Checksum 0x300fa8ea, Offset: 0x4fe0
// Size: 0xf0
function function_db07e398( action_name, new_victim )
{
    if ( isdefined( self.takedown.victim[ action_name ] ) && self.takedown.victim[ action_name ] !== new_victim )
    {
        self.takedown.victim[ action_name ] prompts::remove( #"melee" );
        self.takedown.victim[ action_name ] prompts::remove( #"melee_hold" );
        self.takedown.var_bf0ca7db[ action_name ] = 0;
    }
    
    self.takedown.victim[ action_name ] = new_victim;
}

// Namespace namespace_9c83b58d/namespace_9c83b58d
// Params 1
// Checksum 0x56d94652, Offset: 0x50d8
// Size: 0x174
function function_2ae12730( player )
{
    assert( isplayer( player ) );
    assert( isactor( self ) );
    combat = !player flag::get( "stealth_enabled" ) || player flag::get( "stealth_spotted" );
    combat |= !self flag::get( "stealth_enabled" ) || self flag::get( "stealth_spotted" );
    
    if ( !combat && isdefined( self.stealth ) && isdefined( self.fnisinstealthcombat ) && self [[ self.fnisinstealthcombat ]]() )
    {
        combat = 1;
    }
    
    if ( isdefined( self.stealth.var_9b6cd53f ) && gettime() - self.stealth.var_9b6cd53f < 2000 )
    {
        return 0;
    }
    
    return combat;
}

