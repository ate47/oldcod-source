#using script_2d443451ce681a;
#using script_3626f1b2cf51a99c;
#using script_52da18c20f45c56a;
#using script_5431e074c1428743;
#using script_9bfd3d8a6a89e5e;
#using scripts\core_common\animation_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\bb;
#using scripts\cp_common\ui\prompts;

#namespace namespace_5f6e61d9;

// Namespace namespace_5f6e61d9/namespace_5f6e61d9
// Params 0, eflags: 0x6
// Checksum 0x156c33e7, Offset: 0x270
// Size: 0x44
function private autoexec __init__system__()
{
    system::register( #"hash_32009cf32baa31d1", &preinit, undefined, undefined, #"hash_7e93e9089f28804f" );
}

// Namespace namespace_5f6e61d9/namespace_5f6e61d9
// Params 0, eflags: 0x4
// Checksum 0xc65113fd, Offset: 0x2c0
// Size: 0x15c
function private preinit()
{
    animation::add_global_notetrack_handler( "pickup", &function_ebce8b6, 0 );
    animation::add_global_notetrack_handler( "bodycarry_drop", &function_ff5c9214, 0 );
    animation::add_global_notetrack_handler( "start_bodyshield_gesture", &start_bodyshield_gesture, 0 );
    setsaveddvar( #"ai_corpsesynch", 1 );
    actions::action_register( "body_carry", &function_c3475251, "takedown" );
    actions::action_register( "body_pickup", &function_b9c74598, undefined, "_never_" );
    actions::function_b1543a9d( "body_carry", "td_anims_body_carry" );
    level callback::function_30c3f95d( &function_30c3f95d );
    level.var_3ba48663 = &ai::set_corpse_entity;
}

// Namespace namespace_5f6e61d9/namespace_5f6e61d9
// Params 1, eflags: 0x4
// Checksum 0x1eddd042, Offset: 0x428
// Size: 0x5c
function private function_30c3f95d( parm )
{
    corpse = self;
    
    if ( isdefined( parm.original.var_b9c0ade5 ) )
    {
        corpse.var_b9c0ade5 = parm.original.var_b9c0ade5;
    }
    
    corpse thread function_c74e98cb();
}

// Namespace namespace_5f6e61d9/namespace_5f6e61d9
// Params 0
// Checksum 0x14bb70d2, Offset: 0x490
// Size: 0x82
function player_init()
{
    assert( isplayer( self ) );
    
    if ( !isdefined( self.var_9ebbaa46 ) )
    {
        self.var_9ebbaa46 = spawnstruct();
        self.var_9ebbaa46.victim = undefined;
        self.var_9ebbaa46.active = undefined;
        self.var_9ebbaa46.var_87788f85 = undefined;
    }
}

// Namespace namespace_5f6e61d9/namespace_5f6e61d9
// Params 1
// Checksum 0xe1915805, Offset: 0x520
// Size: 0xc4, Type: bool
function function_c3475251( action )
{
    assert( isplayer( self ) );
    self endon( action.ender );
    self player_init();
    
    if ( is_true( self actions::function_83bde308( action, "use", #"carry_body" ) ) )
    {
        self thread function_b8268bd6( action, self.var_edbc8698 );
        return true;
    }
    
    return false;
}

// Namespace namespace_5f6e61d9/namespace_5f6e61d9
// Params 1
// Checksum 0x3acab3f1, Offset: 0x5f0
// Size: 0x76, Type: bool
function function_b9c74598( action )
{
    assert( isplayer( self ) );
    self endon( action.ender );
    self player_init();
    self waittill( #"body_pickup" );
    return true;
}

// Namespace namespace_5f6e61d9/namespace_5f6e61d9
// Params 2
// Checksum 0x2e2d9703, Offset: 0x670
// Size: 0x234
function function_c74e98cb( var_4aed6923 = 0, tag )
{
    self endon( #"death", #"entitydeleted" );
    util::wait_network_frame();
    
    if ( !isdefined( tag ) && is_true( var_4aed6923 ) )
    {
        tag = "j_spinelower";
    }
    
    button = #"use";
    var_70ddc449 = 18;
    
    if ( is_true( self.var_b9c0ade5 ) )
    {
        var_70ddc449 = 100;
    }
    
    self prompts::create( button, undefined, undefined, undefined, undefined, undefined, tag );
    self prompts::function_263320e2( button, #"hash_2112f5e24ce2de54" );
    self prompts::function_5fe46a16( button, 50 + var_70ddc449 );
    self prompts::function_68782902( button, 68 );
    self prompts::function_b95d71cd( button, 20 );
    self prompts::function_2bd2431a( button, 0 );
    self prompts::function_a4a9acfc( button, &function_ffb1d92f );
    self prompts::function_75d5e526( button, &function_9ccb0bfc );
    self prompts::function_44d7831a( button, 0 );
    self prompts::function_92127496( 1, !is_true( self.var_b9c0ade5 ) );
}

// Namespace namespace_5f6e61d9/namespace_5f6e61d9
// Params 0
// Checksum 0xc7eda2a3, Offset: 0x8b0
// Size: 0x138, Type: bool
function function_c4fe1ef2()
{
    player = self;
    
    if ( !isplayer( player ) )
    {
        player = getplayers()[ 0 ];
    }
    
    player.var_ca6b6423 = undefined;
    setdvar( #"scr_door_player_gestures", 1 );
    
    if ( !is_true( player flag::get( "body_carry" ) ) )
    {
        return false;
    }
    
    if ( is_true( player.player_actions.var_36a4a92c ) )
    {
        return false;
    }
    
    if ( !isdefined( player ) )
    {
        return false;
    }
    
    if ( is_true( player.var_9ebbaa46.var_87788f85 ) )
    {
        return false;
    }
    
    player.var_ca6b6423 = 1;
    setdvar( #"scr_door_player_gestures", 0 );
    return true;
}

// Namespace namespace_5f6e61d9/namespace_5f6e61d9
// Params 0
// Checksum 0xd9eed137, Offset: 0x9f0
// Size: 0x150, Type: bool
function function_ffb1d92f()
{
    player = getplayers()[ 0 ];
    
    if ( !isdefined( player ) )
    {
        return false;
    }
    
    if ( is_true( level.var_9c4a751d ) || isdefined( player getlinkedent() ) )
    {
        return false;
    }
    
    if ( player action_utility::function_a06867b0( player getcurrentweapon() ) )
    {
        return false;
    }
    
    if ( is_true( player flag::get( "body_carry" ) ) )
    {
        return false;
    }
    
    if ( is_true( player flag::get( "body_pickup" ) ) )
    {
        return false;
    }
    
    if ( !level flag::get( "stealth_enabled" ) || level flag::get( "stealth_spotted" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_5f6e61d9/namespace_5f6e61d9
// Params 1
// Checksum 0xb6e814f6, Offset: 0xb48
// Size: 0x34
function function_9ccb0bfc( prompt_struct )
{
    prompt_struct.player thread function_b8268bd6( "body_pickup", self, undefined, 1 );
}

// Namespace namespace_5f6e61d9/namespace_5f6e61d9
// Params 4
// Checksum 0xea48eaff, Offset: 0xb88
// Size: 0x584
function function_b8268bd6( action, victim, override_scene, fromground )
{
    self notify( "528b4d4ca51f192b" );
    self endon( "528b4d4ca51f192b" );
    self endoncallback( &function_39f2df3d, action.ender, #"hash_750a24acc68f40a1" );
    bb::function_cd497743( "body_pickup", self );
    self flag::set( "body_pickup" );
    self.var_9ebbaa46.active = 1;
    self.var_9ebbaa46.victim = victim;
    body_origin = self.var_9ebbaa46.victim.origin;
    
    if ( !isai( self.var_9ebbaa46.victim ) )
    {
        body_origin = self.var_9ebbaa46.victim getcorpsephysicsorigin();
    }
    
    scene_root = spawnstruct();
    
    if ( is_true( fromground ) )
    {
        bodymodel = function_32d8a3e0( self.var_9ebbaa46.victim );
        self.takedown.body = bodymodel;
        scene = "bodycarry_pickup";
        
        if ( isdefined( self.var_9ebbaa46.victim.var_3e95b88f.prompts[ #"use" ] ) && isdefined( self.var_9ebbaa46.victim.var_3e95b88f.prompts[ #"use" ].tag ) )
        {
            body_origin = self.var_9ebbaa46.victim gettagorigin( self.var_9ebbaa46.victim.var_3e95b88f.prompts[ #"use" ].tag );
        }
        
        scene_root.origin = vectorlerp( self.origin, body_origin, 0.5 );
        scene_root.origin = ( scene_root.origin[ 0 ], scene_root.origin[ 1 ], self.origin[ 2 ] );
        scene_root.angles = ( 0, vectortoyaw( scene_root.origin - self.origin ), 0 );
        
        if ( isdefined( self.var_9ebbaa46.var_e0a97ac8 ) )
        {
            scene_root = self.var_9ebbaa46.var_e0a97ac8;
        }
        
        if ( isdefined( self.var_9ebbaa46.var_2e2edc53 ) )
        {
            scene = self.var_9ebbaa46.var_2e2edc53;
            self.takedown.body.var_41c4e6d6 = 1;
            self.var_9ebbaa46.victim hide();
        }
        else
        {
            self.takedown.body hide();
        }
        
        if ( isdefined( override_scene ) )
        {
            scene = override_scene;
        }
        
        override = self actions::function_abaa32c( action );
        self action_utility::gesture_play( "ges_body_carry_pickup_finish", undefined, 1, 0 );
        scene_root action_utility::scene_play( isdefined( override.scene ) ? override.scene : scene, self, self.takedown.body );
        return;
    }
    
    self action_utility::function_464d0412();
    self.takedown.body = self.var_9ebbaa46.victim;
    self.takedown.body function_d374e33d();
    
    if ( isdefined( self.takedown.body ) )
    {
        self.takedown.body thread action_utility::function_3f4de57b( "body_carry" + "_enter" );
    }
    
    if ( isdefined( self.var_6639d45b ) )
    {
        self.var_6639d45b action_utility::function_3f4de57b( "body_carry" + "_enter" );
    }
    
    self thread function_ebce8b6( [ #"player":self, #"victim":self.takedown.body ] );
}

// Namespace namespace_5f6e61d9/namespace_5f6e61d9
// Params 1
// Checksum 0x1391049e, Offset: 0x1118
// Size: 0x29e
function function_ebce8b6( *a_ents )
{
    player = getplayers()[ 0 ];
    override = player actions::function_abaa32c( "body_carry" );
    anim_name = isdefined( override.anim_name ) ? override.anim_name : "body_carry";
    
    if ( player.var_9ebbaa46.victim !== player.takedown.body )
    {
        player.var_9ebbaa46.victim delete();
    }
    
    player.takedown.body show();
    player.takedown.body action_utility::function_b82cae8f( 1 );
    player action_utility::function_464d0412();
    player action_utility::function_2795d678( 1, 1, 0, 0, [ "cinematicmotion_body_carry", "cinematicmotion_body_carry_ads" ] );
    player thread function_9abb3f03( player.takedown.body );
    
    if ( !is_true( player.takedown.body.var_41c4e6d6 ) )
    {
        if ( isdefined( player.takedown.body ) )
        {
            player.takedown.body thread action_utility::function_3f4de57b( anim_name + "_pickup_finish" );
        }
        
        if ( isdefined( player.var_6639d45b ) )
        {
            player.var_6639d45b action_utility::function_3f4de57b( anim_name + "_pickup_finish" );
        }
    }
    
    player flag::set( "body_carry" );
    player flag::clear( "body_pickup" );
    player.takedown.body.var_41c4e6d6 = undefined;
}

// Namespace namespace_5f6e61d9/namespace_5f6e61d9
// Params 1
// Checksum 0xc02d18f5, Offset: 0x13c0
// Size: 0x190
function function_32d8a3e0( victim )
{
    bodymodel = util::spawn_model( victim.aitype, victim.origin, victim.angles );
    bodymodel setmodel( victim.model );
    bodymodel.modelname = victim.model;
    bodymodel.ai_type = victim.aitype;
    bodymodel.animname = "generic";
    bodymodel.var_5b22d53 = 0;
    bodymodel detachall();
    
    for ( i = 0; i < victim getattachsize() ; i++ )
    {
        bodymodel.var_cf230c0[ i ] = victim getattachmodelname( i );
        bodymodel.attach_tag[ i ] = victim getattachtagname( i );
        bodymodel attach( bodymodel.var_cf230c0[ i ], bodymodel.attach_tag[ i ] );
    }
    
    bodymodel function_d374e33d();
    bodymodel notsolid();
    return bodymodel;
}

// Namespace namespace_5f6e61d9/namespace_5f6e61d9
// Params 1
// Checksum 0x7c06bc44, Offset: 0x1558
// Size: 0x19c
function function_9abb3f03( victim )
{
    button = #"stance";
    self prompts::create( button );
    self prompts::function_263320e2( button, #"hash_137214393a59c3a" );
    self prompts::function_cd2391cb( button, "body_drop" );
    self prompts::function_a4a9acfc( button, &function_c4fe1ef2 );
    self prompts::function_8f5eb0a6( button, 0 );
    self prompts::function_d03d79d6( button, 0 );
    self prompts::function_3171730f( button, #"actions" );
    
    while ( true )
    {
        waitresult = self waittill( #"body_drop", #"hash_4dff86580406a1af" );
        
        if ( !self function_c4fe1ef2() && waitresult._notify === "body_drop" )
        {
            continue;
        }
        
        break;
    }
    
    self body_drop( victim );
}

// Namespace namespace_5f6e61d9/namespace_5f6e61d9
// Params 1
// Checksum 0xd5830c91, Offset: 0x1700
// Size: 0x2ac
function body_drop( victim )
{
    self notify( #"hash_7c3b085512be9978" );
    self prompts::remove( #"stance" );
    self notify( #"player_body_shield_view_anims_end" );
    bb::function_cd497743( "body_drop", self );
    self action_utility::gesture_play( "ges_body_carry_exit" );
    override = self actions::function_abaa32c( "body_carry" );
    anim_name = isdefined( override.anim_name ) ? override.anim_name : "body_carry";
    
    if ( isdefined( self.var_9ebbaa46.var_ea195798 ) )
    {
        var_6407b282 = util::spawn_model( victim.model, victim.origin, victim.angles );
        
        for ( i = 0; i < victim getattachsize() ; i++ )
        {
            var_6407b282 attach( victim getattachmodelname( i ), victim getattachtagname( i ), 1 );
        }
        
        victim delete();
        victim = var_6407b282;
        self.var_9ebbaa46.var_d4f8dcdf action_utility::scene_play( self.var_9ebbaa46.var_ea195798, self, victim );
    }
    else
    {
        if ( isdefined( victim ) )
        {
            victim thread action_utility::function_3f4de57b( anim_name + "_drop" );
        }
        
        if ( isdefined( self.var_6639d45b ) )
        {
            self.var_6639d45b show();
            self.var_6639d45b action_utility::function_3f4de57b( anim_name + "_drop" );
        }
    }
    
    self thread function_ff5c9214( [ #"player":self, #"victim":victim ] );
}

// Namespace namespace_5f6e61d9/namespace_5f6e61d9
// Params 1
// Checksum 0x9f830da6, Offset: 0x19b8
// Size: 0x124
function function_ff5c9214( a_ents )
{
    self actions::function_942d9213();
    player = getplayers()[ 0 ];
    victim = a_ents[ #"victim" ];
    player action_utility::function_2795d678( 0 );
    
    if ( isdefined( victim ) && !iscorpse( victim ) )
    {
        victim action_utility::become_corpse();
    }
    
    player.var_9ebbaa46.active = undefined;
    player notify( #"hash_51c6ae96a7e40432" );
    player flag::clear( "body_carry" );
    player flag::clear( "body_pickup" );
    prompts::function_398ab9eb();
}

// Namespace namespace_5f6e61d9/namespace_5f6e61d9
// Params 1
// Checksum 0xc749735b, Offset: 0x1ae8
// Size: 0x64
function start_bodyshield_gesture( *a_ents )
{
    getplayers()[ 0 ] thread namespace_6cecf2d8::function_756e29bb( level.player_actions.actions[ #"body_carry" ], "body_carry", undefined, undefined, undefined, 0 );
}

// Namespace namespace_5f6e61d9/namespace_5f6e61d9
// Params 1
// Checksum 0x783e8a36, Offset: 0x1b58
// Size: 0x44
function function_39f2df3d( *notifyhash )
{
    self action_utility::function_2795d678( 0 );
    self.var_9ebbaa46.active = undefined;
    self actions::function_942d9213();
}

// Namespace namespace_5f6e61d9/namespace_5f6e61d9
// Params 1
// Checksum 0x840205f2, Offset: 0x1ba8
// Size: 0x3e
function function_145a8b5a( b_disable = 1 )
{
    self.var_9ebbaa46.var_87788f85 = b_disable ? 1 : undefined;
}

// Namespace namespace_5f6e61d9/namespace_5f6e61d9
// Params 0
// Checksum 0x3b6289c, Offset: 0x1bf0
// Size: 0x2e, Type: bool
function function_cad84e26()
{
    if ( is_true( self.var_9ebbaa46.active ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_5f6e61d9/namespace_5f6e61d9
// Params 2
// Checksum 0x3fb4b3a1, Offset: 0x1c28
// Size: 0x7c
function function_694887dc( var_2e2edc53, var_e0a97ac8 = level )
{
    if ( isdefined( var_2e2edc53 ) )
    {
        self.var_9ebbaa46.var_2e2edc53 = var_2e2edc53;
        self.var_9ebbaa46.var_e0a97ac8 = var_e0a97ac8;
        scene::add_scene_func( var_2e2edc53, &function_ebce8b6, "done" );
    }
}

// Namespace namespace_5f6e61d9/namespace_5f6e61d9
// Params 0
// Checksum 0x8b25650f, Offset: 0x1cb0
// Size: 0x36
function function_461dbe2a()
{
    if ( isdefined( self.var_9ebbaa46.var_2e2edc53 ) )
    {
        self.var_9ebbaa46.var_2e2edc53 = undefined;
        self.var_9ebbaa46.var_e0a97ac8 = undefined;
    }
}

// Namespace namespace_5f6e61d9/namespace_5f6e61d9
// Params 2
// Checksum 0x1cbfd15e, Offset: 0x1cf0
// Size: 0x52
function function_d0cb2574( var_ea195798, var_d4f8dcdf = level )
{
    if ( isdefined( var_ea195798 ) )
    {
        self.var_9ebbaa46.var_ea195798 = var_ea195798;
        self.var_9ebbaa46.var_d4f8dcdf = var_d4f8dcdf;
    }
}

// Namespace namespace_5f6e61d9/namespace_5f6e61d9
// Params 0
// Checksum 0x294075d7, Offset: 0x1d50
// Size: 0x36
function function_b5b485f1()
{
    if ( isdefined( self.var_9ebbaa46.var_ea195798 ) )
    {
        self.var_9ebbaa46.var_ea195798 = undefined;
        self.var_9ebbaa46.var_d4f8dcdf = undefined;
    }
}

