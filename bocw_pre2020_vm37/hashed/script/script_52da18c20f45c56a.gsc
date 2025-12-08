#using script_3626f1b2cf51a99c;
#using script_37f9ff47f340fbe8;
#using scripts\core_common\animation_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\easing;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\ui\prompts;
#using scripts\weapons\weapon_utils;

#namespace action_utility;

// Namespace action_utility/action_utility
// Params 0, eflags: 0x6
// Checksum 0xf50e369, Offset: 0x460
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"action_utility", &preinit, undefined, undefined, undefined );
}

// Namespace action_utility/action_utility
// Params 0, eflags: 0x4
// Checksum 0x2a6aa447, Offset: 0x4a8
// Size: 0x94
function private preinit()
{
    clientfield::register( "scriptmover", "link_to_camera", 1, 1, "int" );
    clientfield::register( "actor", "link_to_camera", 1, 1, "int" );
    clientfield::register( "toplayer", "fake_ads", 1, 1, "int" );
}

// Namespace action_utility/action_utility
// Params 1
// Checksum 0x78b9e9ac, Offset: 0x548
// Size: 0x82
function function_30b535ff( inuse )
{
    if ( !isdefined( self.var_30b535ff ) )
    {
        self.var_30b535ff = 0;
    }
    
    if ( inuse )
    {
        self.var_30b535ff = max( 1, self.var_30b535ff + 1 );
    }
    else
    {
        self.var_30b535ff = max( 0, self.var_30b535ff - 1 );
    }
    
    return self.var_30b535ff;
}

// Namespace action_utility/action_utility
// Params 2
// Checksum 0x9e17175b, Offset: 0x5d8
// Size: 0xb4
function function_77af90aa( var_cf230c0, attach_tag )
{
    self detachall();
    
    if ( isdefined( var_cf230c0 ) )
    {
        assert( isdefined( attach_tag ) );
        assert( var_cf230c0.size == attach_tag.size );
        
        for ( i = 0; i < var_cf230c0.size ; i++ )
        {
            self attach( var_cf230c0[ i ], attach_tag[ i ], 1 );
        }
    }
}

// Namespace action_utility/action_utility
// Params 2
// Checksum 0x3ecd3dc, Offset: 0x698
// Size: 0x2b4
function level_pitch( link_ents, var_e4df1bec )
{
    assert( isplayer( self ) );
    pitch = abs( angleclamp180( self getplayerangles()[ 0 ] ) );
    
    if ( pitch > 0 )
    {
        prep = util::spawn_model( "tag_origin", self.origin, self.angles );
        duration = pitch / 180;
        self playerlinktoblend( prep, "tag_player", duration, duration * 0.5, duration * 0.5 );
        
        if ( isdefined( link_ents ) )
        {
            foreach ( ent_to_link in link_ents )
            {
                ent_to_link function_b82cae8f( 1 );
            }
        }
        
        if ( is_true( var_e4df1bec ) )
        {
            self thread function_e4df1bec( duration );
        }
        
        wait duration + float( function_60d95f53() ) / 1000;
        
        if ( isdefined( link_ents ) )
        {
            foreach ( ent_to_link in link_ents )
            {
                ent_to_link function_b82cae8f( 0 );
            }
        }
        
        self unlink();
        prep delete();
    }
}

// Namespace action_utility/action_utility
// Params 1
// Checksum 0xf4080b1, Offset: 0x958
// Size: 0xb4
function function_e4df1bec( duration )
{
    self thread easing::ease_dvar( "bg_viewBobAmplitudeStanding", self.var_74c52b3d.var_c9e720e2, duration, "linear" );
    self thread easing::ease_dvar( "bg_bobMax", self.var_74c52b3d.viewbobmax, duration, "linear" );
    self thread easing::ease_dvar( "bg_bobTransTime", self.var_74c52b3d.var_945795a5, duration, "linear" );
}

// Namespace action_utility/action_utility
// Params 0
// Checksum 0x29d43165, Offset: 0xa18
// Size: 0x126
function become_corpse()
{
    if ( self clientfield::get( "link_to_camera" ) )
    {
        self function_b82cae8f( 0 );
    }
    
    if ( !iscorpse( self ) && !is_true( getplayers()[ 0 ].var_9ebbaa46.var_7e5a6cf9 ) )
    {
        aitype = self.ai_type;
        
        if ( !isdefined( aitype ) )
        {
            aitype = self.aitype;
        }
        
        self solid();
        
        if ( !isactor( self ) )
        {
            corpse = self function_f5408e2c( aitype, getplayers()[ 0 ].velocity );
        }
    }
}

// Namespace action_utility/action_utility
// Params 1
// Checksum 0x61fc0df0, Offset: 0xb48
// Size: 0x52
function function_2e55c59e( var_f68ce314 )
{
    assert( isdefined( var_f68ce314 ) && isfloat( var_f68ce314 ) );
    level.player_actions.var_671420ae = var_f68ce314;
}

// Namespace action_utility/action_utility
// Params 0
// Checksum 0xf82f0bfe, Offset: 0xba8
// Size: 0x1a
function function_e3b9f13()
{
    level.player_actions.var_671420ae = 0.5;
}

// Namespace action_utility/action_utility
// Params 0
// Checksum 0xf5282c9c, Offset: 0xbd0
// Size: 0x42
function function_e46cbbf7()
{
    if ( !isdefined( level.player_actions.var_671420ae ) )
    {
        level.player_actions.var_671420ae = 0.5;
    }
    
    return level.player_actions.var_671420ae;
}

// Namespace action_utility/action_utility
// Params 2
// Checksum 0x35aaafc4, Offset: 0xc20
// Size: 0x324
function function_31df4786( var_165b239b = 1, allow_ads = 1 )
{
    assert( !isdefined( self.var_31df4786 ) );
    self.var_31df4786 = 1;
    self val::set( #"hash_681a4eb9df49482f", "disable_weapon_cycling", 1 );
    self val::set( #"hash_681a4eb9df49482f", "disable_weapon_reload", 1 );
    self val::set( #"hash_681a4eb9df49482f", "disable_weapon_pickup", 1 );
    self val::set( #"hash_681a4eb9df49482f", "disable_offhand_weapons", 1 );
    self val::set( #"hash_681a4eb9df49482f", "disable_offhand_special", 1 );
    self val::set( #"hash_681a4eb9df49482f", "allow_crouch", 0 );
    self val::set( #"hash_681a4eb9df49482f", "allow_prone", 0 );
    self val::set( #"hash_681a4eb9df49482f", "allow_sprint", 0 );
    self val::set( #"hash_681a4eb9df49482f", "allow_jump", 0 );
    self val::set( #"hash_681a4eb9df49482f", "allow_climb", 0 );
    self val::set( #"hash_681a4eb9df49482f", "allow_mantle", 0 );
    self val::set( #"hash_681a4eb9df49482f", "allow_melee_victim", 0 );
    
    if ( !var_165b239b )
    {
        self val::set( #"hash_681a4eb9df49482f", "disable_weapons", 1 );
    }
    
    if ( !allow_ads )
    {
        self val::set( #"hash_681a4eb9df49482f", "allow_ads", 0 );
    }
    
    if ( !function_1fac6486( self getcurrentweapon() ) )
    {
        self val::set( #"hash_681a4eb9df49482f", "allow_melee", 0 );
    }
}

// Namespace action_utility/action_utility
// Params 0
// Checksum 0xc0d4318d, Offset: 0xf50
// Size: 0x2e
function function_9123bbf0()
{
    self val::reset_all( #"hash_681a4eb9df49482f" );
    self.var_31df4786 = undefined;
}

// Namespace action_utility/action_utility
// Params 5
// Checksum 0x24cb3dc5, Offset: 0xf88
// Size: 0x616
function function_2795d678( encumbered, var_165b239b, var_37e68004, allow_ads, var_6a87e928 )
{
    player = self;
    assert( isplayer( player ) );
    pistol = undefined;
    
    if ( !isdefined( var_165b239b ) )
    {
        var_165b239b = 1;
    }
    
    if ( !isdefined( var_37e68004 ) )
    {
        var_37e68004 = 0;
    }
    
    if ( !isdefined( allow_ads ) )
    {
        allow_ads = 1;
    }
    
    if ( encumbered )
    {
        if ( !isdefined( player.var_74c52b3d ) )
        {
            self.var_74c52b3d = spawnstruct();
            self function_31df4786( var_165b239b, allow_ads );
            player.var_74c52b3d.movespeedscale = player getmovespeedscale();
            player.var_74c52b3d.var_c9e720e2 = getdvar( #"bg_viewbobamplitudestanding" );
            player.var_74c52b3d.var_c9e720e2 = string( player.var_74c52b3d.var_c9e720e2[ 0 ] ) + " " + string( player.var_74c52b3d.var_c9e720e2[ 1 ] );
            player.var_74c52b3d.viewbobmax = getdvarfloat( #"bg_bobmax" );
            player.var_74c52b3d.var_945795a5 = getdvarint( #"bg_bobtranstime" );
            var_b56db8c = function_e46cbbf7();
            player setmovespeedscale( var_b56db8c );
            player thread function_854fc491( var_6a87e928 );
            
            if ( var_165b239b )
            {
                if ( var_37e68004 )
                {
                    pistol = player function_d338e637();
                    
                    if ( isdefined( pistol ) )
                    {
                        player.var_74c52b3d.weapon_list = player getweaponslist();
                        player.var_74c52b3d.weapon_last = player getcurrentweapon();
                        
                        if ( !isdefined( player.var_74c52b3d.weapon_last ) || player.var_74c52b3d.weapon_last.basename == "none" )
                        {
                            player.var_74c52b3d.weapon_last = level.player.last_weapon;
                        }
                        
                        player switchtoweapon( pistol );
                    }
                }
                
                if ( isdefined( player.var_74c52b3d.weapon_list ) )
                {
                    foreach ( weap in player.var_74c52b3d.weapon_list )
                    {
                        if ( isdefined( pistol ) && weap != pistol )
                        {
                            player takeweapon( weap );
                        }
                    }
                }
            }
            
            self prompts::function_e79f51ec( [ #"actions", #"doors", #"body_carry" ] );
            self flag::set( "encumbered" );
        }
        
        return;
    }
    
    if ( isdefined( player.var_74c52b3d ) )
    {
        self function_9123bbf0();
        player setmovespeedscale( player.var_74c52b3d.movespeedscale );
        player thread function_854fc491();
        
        if ( isdefined( player.var_74c52b3d.weapon_list ) )
        {
            foreach ( weap in player.var_74c52b3d.weapon_list )
            {
                if ( isdefined( pistol ) && weap != pistol )
                {
                    player giveweapon( weap );
                }
            }
        }
        
        if ( isdefined( player.var_74c52b3d.weapon_last ) )
        {
            player switchtoweapon( player.var_74c52b3d.weapon_last );
        }
        
        self prompts::function_398ab9eb();
        self flag::clear( "encumbered" );
    }
    
    player.var_74c52b3d = undefined;
}

// Namespace action_utility/action_utility
// Params 1
// Checksum 0xdf772e97, Offset: 0x15a8
// Size: 0x266
function function_854fc491( var_6a87e928 )
{
    player = self;
    assert( isplayer( player ) );
    player endon( #"death" );
    self notify( "55fe68846f2b2747" );
    self endon( "55fe68846f2b2747" );
    
    if ( isdefined( var_6a87e928 ) )
    {
        if ( !isdefined( var_6a87e928 ) )
        {
            var_6a87e928 = [];
        }
        else if ( !isarray( var_6a87e928 ) )
        {
            var_6a87e928 = array( var_6a87e928 );
        }
    }
    
    if ( isdefined( var_6a87e928 ) )
    {
        lastmode = -1;
        
        while ( true )
        {
            newmode = lastmode;
            
            if ( player adsbuttonpressed() && var_6a87e928.size > 1 )
            {
                newmode = 1;
            }
            else
            {
                newmode = 0;
            }
            
            if ( lastmode != newmode )
            {
                if ( isdefined( player.player_actions ) && !isdefined( player.player_actions.var_e3fb763e ) )
                {
                    player.player_actions.var_e3fb763e = player function_43ee4470();
                }
                
                player setcinematicmotionoverride( var_6a87e928[ newmode ] );
                player.player_actions.var_db0bbc1f = var_6a87e928[ newmode ];
            }
            
            lastmode = newmode;
            waitframe( 1 );
        }
        
        return;
    }
    
    if ( isdefined( player.player_actions.var_e3fb763e ) )
    {
        if ( player.player_actions.var_db0bbc1f == player function_43ee4470() )
        {
            player setcinematicmotionoverride( player.action.var_e3fb763e );
        }
        
        player.player_actions.var_e3fb763e = undefined;
    }
    else
    {
        player clearcinematicmotionoverride();
    }
    
    player.player_actions.var_db0bbc1f = undefined;
}

// Namespace action_utility/action_utility
// Params 0
// Checksum 0x8a8aa30f, Offset: 0x1818
// Size: 0xa2
function function_d338e637()
{
    foreach ( weap in self getweaponslist() )
    {
        if ( weapons::ispistol( weap ) )
        {
            return weap;
        }
    }
    
    return undefined;
}

// Namespace action_utility/action_utility
// Params 0
// Checksum 0x536209d4, Offset: 0x18c8
// Size: 0xa
function function_c4e06b5a()
{
    return "j_spinelower";
}

// Namespace action_utility/action_utility
// Params 1
// Checksum 0xd3aa4ead, Offset: 0x18e0
// Size: 0x184
function function_eef2dca9( guys )
{
    assert( isplayer( self ) );
    scene_root = spawnstruct();
    scene_root.angles = self.angles;
    scene_root.origin = self.origin + self getvelocity() * float( function_60d95f53() ) / 1000;
    
    if ( !isdefined( guys ) )
    {
        guys = [];
    }
    else if ( !isarray( guys ) )
    {
        guys = array( guys );
    }
    
    foreach ( guy in guys )
    {
        if ( isdefined( guy ) )
        {
            guy dontinterpolate();
        }
    }
    
    return scene_root;
}

// Namespace action_utility/action_utility
// Params 2
// Checksum 0xfe92ec5c, Offset: 0x1a70
// Size: 0x25e
function function_b82cae8f( linked, var_5596253c = 1 )
{
    if ( is_true( linked ) && !is_true( self.var_47f0a724 ) )
    {
        self clientfield::set( "link_to_camera", 1 );
        self.var_47f0a724 = 1;
        return;
    }
    
    if ( !is_true( linked ) && is_true( self.var_47f0a724 ) )
    {
        self clientfield::set( "link_to_camera", 0 );
        
        if ( is_true( var_5596253c ) )
        {
            player = getplayers()[ 0 ];
            origin = player getplayercamerapos();
            angles = player getplayerangles();
            axis = anglestoaxis( angles );
            origin += ( 0, 0, -60 )[ 0 ] * axis.forward;
            origin += ( 0, 0, -60 )[ 1 ] * axis.right;
            origin += ( 0, 0, -60 )[ 2 ] * axis.up;
            
            if ( isactor( self ) )
            {
                self teleport( origin, angles );
            }
            else
            {
                self.origin = origin;
                self.angles = angles;
                self dontinterpolate();
            }
        }
        
        self.var_47f0a724 = undefined;
    }
}

// Namespace action_utility/action_utility
// Params 0
// Checksum 0x1e6b604f, Offset: 0x1cd8
// Size: 0x68, Type: bool
function function_bda1ed48()
{
    var_9d19b745 = 400;
    assert( isplayer( self ) );
    return lengthsquared( self getvelocity() ) > var_9d19b745;
}

// Namespace action_utility/action_utility
// Params 1
// Checksum 0x298833b9, Offset: 0x1d48
// Size: 0x6c
function function_3fbe0931( *action )
{
    self notify( #"hash_4dff86580406a1af" );
    self function_2795d678( 0 );
    self allow_weapon( 1 );
    self val::reset_all( #"action" );
}

// Namespace action_utility/action_utility
// Params 4
// Checksum 0x7c4a19f1, Offset: 0x1dc0
// Size: 0x316
function allow_weapon( allowed, forced, gesture, var_dfce6e2d )
{
    if ( !allowed )
    {
        if ( !isdefined( gesture ) )
        {
            gesture = "ges_body_shield_gundown_quick";
        }
        
        self.var_15c4009c = ( isdefined( self.var_15c4009c ) ? self.var_15c4009c : 0 ) + 1;
        
        if ( self.var_15c4009c === 1 )
        {
            self val::set( #"hash_1759513a118d68fd", "disable_weapon_fire", 1 );
            self val::set( #"hash_1759513a118d68fd", "disable_weapon_reload", 1 );
            self val::set( #"hash_1759513a118d68fd", "disable_weapon_pickup", 1 );
            self val::set( #"hash_1759513a118d68fd", "disable_weapon_cycling", 1 );
            self val::set( #"hash_1759513a118d68fd", "disable_offhand_weapons", 1 );
            self val::set( #"hash_1759513a118d68fd", "disable_offhand_special", 1 );
            self.var_621f8539 = gesture;
            
            if ( !is_true( var_dfce6e2d ) && !function_1c2cb657( self getcurrentweapon() ) )
            {
                self thread gesture_play( self.var_621f8539 );
            }
        }
        
        return;
    }
    
    if ( isdefined( self.var_15c4009c ) )
    {
        self.var_15c4009c -= 1;
        
        if ( is_true( forced ) || self.var_15c4009c <= 0 )
        {
            self val::reset_all( #"hash_1759513a118d68fd" );
            self val::reset_all( #"hash_58b9fd1cfcf4a27d" );
            
            if ( !function_1c2cb657( self getcurrentweapon() ) )
            {
                if ( isdefined( gesture ) )
                {
                    self thread gesture_play( gesture );
                }
                else if ( isdefined( self.var_621f8539 ) )
                {
                    self thread gesture_stop( self.var_621f8539 );
                }
            }
            
            self.var_15c4009c = undefined;
            self.var_621f8539 = undefined;
        }
    }
}

// Namespace action_utility/action_utility
// Params 1
// Checksum 0x600b9612, Offset: 0x20e0
// Size: 0xf2
function function_1e9599a7( other )
{
    self.weapon = other.weapon;
    self.primaryweapon = other.primaryweapon;
    self.secondaryweapon = other.secondaryweapon;
    self.sidearm = other.sidearm;
    self.grenadeweapon = other.grenadeweapon;
    self.weaponinfo = other.weaponinfo;
    
    if ( !isdefined( self.a ) )
    {
        self.a = spawnstruct();
        self.a.weaponpos = [];
        self.a.weaponposdropping = [];
    }
    
    if ( isdefined( other.a ) )
    {
        self.a.weaponpos = other.a.weaponpos;
    }
    
    self.var_9d46265b = other.var_9d46265b;
}

// Namespace action_utility/action_utility
// Params 6
// Checksum 0x5186c7c8, Offset: 0x21e0
// Size: 0x2c2
function function_b5d8286c( action, scene_root, anim_ents, anim_name, victim, phase )
{
    var_fc8116b2 = self function_462c34d0( action, scene_root, anim_name, victim, phase );
    
    if ( isdefined( var_fc8116b2.scene_root ) && isdefined( var_fc8116b2.scene_root.target ) )
    {
        anim_ents = arraycombine( anim_ents, getentarray( var_fc8116b2.scene_root.target, "targetname" ) );
    }
    
    if ( isdefined( var_fc8116b2.scene_root ) && isdefined( var_fc8116b2.scene_root.script_linkto ) )
    {
        anim_ents = arraycombine( anim_ents, getentarray( var_fc8116b2.scene_root.script_linkto, "script_linkname" ) );
    }
    
    var_3c131b96 = undefined;
    
    foreach ( ent in anim_ents )
    {
        if ( ent === self || !isdefined( var_3c131b96 ) )
        {
            var_3c131b96 = ent;
        }
        
        ent.var_3f4de57b = level.player_actions.anims[ ent.animname ][ var_fc8116b2.anim_name ];
        ent notify( #"new_scripted_anim" );
        ent thread function_3f4de57b( var_fc8116b2.anim_name );
    }
    
    if ( isdefined( var_3c131b96 ) )
    {
        wait getanimlength( var_3c131b96.var_3f4de57b );
    }
    
    foreach ( ent in anim_ents )
    {
        ent.var_3f4de57b = undefined;
    }
    
    return var_fc8116b2.overridden;
}

// Namespace action_utility/action_utility
// Params 1
// Checksum 0x14e864f7, Offset: 0x24b0
// Size: 0x174
function function_aee5f6a6( var_b56433f8 )
{
    self notify( "55dd956a145bde6" );
    self endon( "55dd956a145bde6" );
    index = randomintrange( 1, 4 );
    pain_anim = var_b56433f8 + "_pain_" + index;
    
    if ( is_true( self.var_de5476af ) )
    {
        pain_anim = var_b56433f8 + "_ads_pain_" + index;
    }
    
    if ( isdefined( level.player_actions.anims[ #"generic" ][ pain_anim ] ) )
    {
        self.takedown.body thread function_3f4de57b( pain_anim, 0 );
        self.var_6639d45b function_3f4de57b( pain_anim, 0 );
        loop_anim = self function_47ffa6b8( var_b56433f8 );
        self.takedown.body thread function_d621e6d6( loop_anim );
        self.var_6639d45b thread function_d621e6d6( loop_anim );
    }
}

// Namespace action_utility/action_utility
// Params 2
// Checksum 0xde1c4ed2, Offset: 0x2630
// Size: 0xd6
function function_1e132b9f( blendtime, clearanims )
{
    self notify( #"player_action_anim" );
    self notify( #"new_scripted_anim" );
    
    if ( !isdefined( blendtime ) )
    {
        blendtime = 0.2;
    }
    
    if ( !isdefined( clearanims ) )
    {
        clearanims = 1;
    }
    
    if ( isdefined( self.var_d621e6d6 ) )
    {
        if ( clearanims )
        {
            self clearanim( self.var_d621e6d6, blendtime );
        }
        
        self.var_d621e6d6 = undefined;
    }
    
    if ( isdefined( self.var_3f4de57b ) )
    {
        if ( clearanims )
        {
            self clearanim( self.var_3f4de57b, blendtime );
        }
        
        self.var_3f4de57b = undefined;
    }
}

// Namespace action_utility/action_utility
// Params 3
// Checksum 0x1a413a2e, Offset: 0x2710
// Size: 0x1a4
function function_3f4de57b( animnameplay, blendtime = isdefined( level.player_actions.blend[ self.animname ][ animnameplay ] ) ? level.player_actions.blend[ self.animname ][ animnameplay ] : 0.2, clearanims = 1 )
{
    self function_1e132b9f( blendtime, clearanims );
    self endon( #"death", #"entitydeleted", #"player_action_anim" );
    animplay = level.player_actions.anims[ self.animname ][ animnameplay ];
    assert( isdefined( animplay ) );
    self thread animation::play( animplay, self.origin, self.angles, 1, blendtime, blendtime );
    self.var_3f4de57b = animplay;
    wait getanimlength( animplay );
    self.var_3f4de57b = undefined;
    
    if ( clearanims )
    {
        self clearanim( animplay, blendtime );
    }
}

// Namespace action_utility/action_utility
// Params 2
// Checksum 0xf7724914, Offset: 0x28c0
// Size: 0x1b8
function function_d621e6d6( animloopname, blendtime )
{
    if ( isdefined( self.var_d621e6d6 ) && self.var_d621e6d6 == level.player_actions.anims[ self.animname ][ animloopname ] )
    {
        return;
    }
    
    if ( !isdefined( blendtime ) )
    {
        blendtime = isdefined( level.player_actions.blend[ self.animname ][ animloopname ] ) ? level.player_actions.blend[ self.animname ][ animloopname ] : 0.2;
    }
    
    self function_1e132b9f( blendtime );
    self endon( #"death" );
    self endon( #"entitydeleted" );
    self endon( #"player_action_anim" );
    animloop = level.player_actions.anims[ self.animname ][ animloopname ];
    self thread animation::play( animloop, self.origin, self.angles, 1, blendtime, blendtime );
    self.var_d621e6d6 = animloop;
    
    while ( isdefined( animloop ) )
    {
        self setanimtime( animloop, 0 );
        animlength = getanimlength( animloop );
        wait animlength;
    }
}

// Namespace action_utility/action_utility
// Params 1
// Checksum 0x418f14a4, Offset: 0x2a80
// Size: 0x86
function function_47ffa6b8( var_b56433f8 )
{
    suffix = "";
    
    if ( is_true( self.var_de5476af ) )
    {
        suffix += "_ads";
    }
    
    suffix += "_loop";
    
    if ( self function_bda1ed48() )
    {
        suffix += "_walk";
    }
    
    return var_b56433f8 + suffix;
}

// Namespace action_utility/action_utility
// Params 5
// Checksum 0xfb1dc035, Offset: 0x2b10
// Size: 0x27a
function function_462c34d0( action, scene_root, anim_name, victim, phase )
{
    assert( isplayer( self ) );
    key = actions::function_4e61a046( action.name, phase );
    var_b3d30f5f = undefined;
    
    if ( isdefined( victim ) && isdefined( victim.var_9d46265b ) && isdefined( victim.var_9d46265b[ key ] ) )
    {
        var_b3d30f5f = victim.var_9d46265b[ key ];
    }
    else if ( isdefined( self.var_9d46265b ) && isdefined( self.var_9d46265b[ key ] ) )
    {
        var_b3d30f5f = self.var_9d46265b[ key ];
    }
    else if ( isdefined( level.var_9d46265b ) && isdefined( level.var_9d46265b[ key ] ) )
    {
        var_b3d30f5f = level.var_9d46265b[ key ];
    }
    
    result = spawnstruct();
    result.anim_name = anim_name;
    result.scene_root = scene_root;
    result.overridden = 0;
    result.blend_time = 0.2;
    
    if ( isdefined( var_b3d30f5f ) )
    {
        result.anim_name = var_b3d30f5f[ 0 ];
        
        if ( isdefined( var_b3d30f5f[ 1 ] ) )
        {
            result.scene_root = var_b3d30f5f[ 1 ];
            result.var_5e5653b2 = 1;
        }
        
        result.overridden = 1;
    }
    
    var_386b7517 = self.var_6639d45b.animname;
    
    if ( isdefined( level.player_actions.blend[ var_386b7517 ] ) && isdefined( level.player_actions.blend[ var_386b7517 ][ result.anim_name ] ) )
    {
        result.blend_time = level.player_actions.blend[ var_386b7517 ][ result.anim_name ];
        result.var_7d26075f = 1;
    }
    
    return result;
}

// Namespace action_utility/action_utility
// Params 2
// Checksum 0x65f0cbae, Offset: 0x2d98
// Size: 0x1f4
function function_4cbb6ca7( anim_name, var_f09f326c )
{
    assert( isplayer( self ) );
    assert( isdefined( self.var_6639d45b ) );
    player_arms = self.var_6639d45b;
    
    if ( !isarray( var_f09f326c ) )
    {
        var_d89d1589 = [];
        
        if ( isdefined( level.player_actions.blend[ #"generic" ] ) )
        {
            var_d89d1589[ #"generic" ] = level.player_actions.blend[ #"generic" ][ anim_name ];
        }
        
        if ( isdefined( level.player_actions.blend[ player_arms.animname ] ) )
        {
            var_d89d1589[ player_arms.animname ] = level.player_actions.blend[ player_arms.animname ][ anim_name ];
        }
        
        level.player_actions.blend[ #"generic" ][ anim_name ] = var_f09f326c;
        level.player_actions.blend[ player_arms.animname ][ anim_name ] = var_f09f326c;
        return var_d89d1589;
    }
    else
    {
        level.player_actions.blend[ #"generic" ][ anim_name ] = var_f09f326c[ #"generic" ];
        level.player_actions.blend[ player_arms.animname ][ anim_name ] = var_f09f326c[ player_arms.animname ];
    }
    
    return undefined;
}

// Namespace action_utility/action_utility
// Params 1
// Checksum 0x81a20e62, Offset: 0x2f98
// Size: 0x194
function function_1c2992ed( enabled )
{
    var_49b6c927 = is_true( self clientfield::get_to_player( "fake_ads" ) );
    var_4f735d6e = is_true( enabled );
    
    if ( var_4f735d6e && !var_49b6c927 )
    {
        self clientfield::set_to_player( "fake_ads", 1 );
        self easing::ease_dvar( "bg_aimSpreadScale", 1, 0.2, 0.2, #"sine" );
        self capturnrate( 45, 90 );
        return;
    }
    
    if ( !var_4f735d6e && var_49b6c927 )
    {
        self clientfield::set_to_player( "fake_ads", 0 );
        self easing::ease_dvar( "bg_aimSpreadScale", 1, 1, 0.2, #"sine" );
        self capturnrate( 90, 260 );
    }
}

// Namespace action_utility/action_utility
// Params 1
// Checksum 0x3b7446ce, Offset: 0x3138
// Size: 0x5c
function function_6e8e5902( ender )
{
    self notify( #"hash_420f563c810c5f2c" );
    self endon( #"hash_420f563c810c5f2c" );
    self waittill( ender, #"hash_4a7c2a6c1d3c2382" );
    self thread function_1c2992ed( 0 );
}

// Namespace action_utility/action_utility
// Params 1
// Checksum 0xe157d30b, Offset: 0x31a0
// Size: 0x9a
function function_7920d338( notifyevent )
{
    self endon( notifyevent, #"disconnect" );
    waitframe( 1 );
    
    while ( self getcurrentweapon().basename == "none" )
    {
        waitframe( 1 );
    }
    
    while ( self getweaponammoclip( self getcurrentweapon() ) > 0 )
    {
        waitframe( 1 );
    }
    
    self notify( notifyevent );
}

// Namespace action_utility/action_utility
// Params 2
// Checksum 0x7803f95a, Offset: 0x3248
// Size: 0x86
function function_98f117ad( var_36a368e3, type = "" )
{
    if ( type.size > 0 )
    {
        type = "_" + type;
    }
    
    weap = self getcurrentweapon();
    suffix = "_rifle";
    return var_36a368e3 + suffix + type;
}

// Namespace action_utility/action_utility
// Params 1
// Checksum 0xdbe1c9ba, Offset: 0x32d8
// Size: 0x1e4
function function_35d0bd11( in_bodyshield )
{
    assert( isai( self ) );
    self flag::clear( "stealth_enabled" );
    
    if ( is_true( in_bodyshield ) )
    {
        self.ignoreall = 1;
        self.ignoreme = 1;
        self.battlechatterallowed = 0;
        self notsolid();
        self clearenemy();
        self setgoal( self.origin );
        self thread function_91639a4c( 1 );
        self animcustom( &function_e9aef609 );
        return;
    }
    
    self.ignoreall = 0;
    self.ignoreme = 0;
    self.battlechatterallowed = 1;
    self util::delay( float( function_60d95f53() ) / 1000, undefined, &solid );
    self setgoal( self.origin );
    self thread function_91639a4c( 0 );
    
    if ( isdefined( self.magic_bullet_shield ) )
    {
        self util::stop_magic_bullet_shield();
    }
}

// Namespace action_utility/action_utility
// Params 0
// Checksum 0x539431c6, Offset: 0x34c8
// Size: 0x4a
function function_e9aef609()
{
    self endon( #"killanimscript" );
    self animmode( "nogravity" );
    self waittill( #"never" );
}

// Namespace action_utility/action_utility
// Params 2
// Checksum 0x3f464f7d, Offset: 0x3520
// Size: 0x2aa
function function_c0f7b46e( fullbody, *clearanims )
{
    assert( isplayer( self ) );
    
    if ( !isdefined( self.var_6639d45b ) )
    {
        self.var_6639d45b = spawn( "script_model", self.origin );
        
        if ( isdefined( self.var_6639d45b ) )
        {
            self.var_6639d45b.angles = self.angles;
            self.var_6639d45b useanimtree( "generic" );
            self.var_6639d45b.animname = "player";
            self.var_6639d45b notsolid();
            self.var_6639d45b hide();
            self.var_6639d45b.health = 100;
            self.var_6639d45b setowner( self );
            self.var_6639d45b.team = self.team;
            self.var_6639d45b function_b82cae8f( 1 );
        }
    }
    
    var_41206ae3 = self function_5d23af5b();
    
    if ( isdefined( var_41206ae3 ) )
    {
        self.var_6639d45b setmodel( var_41206ae3 );
    }
    
    var_b4d88433 = self function_cde23658();
    
    if ( isdefined( self.var_6639d45b.var_b4d88433 ) )
    {
        self.var_6639d45b detach( self.var_6639d45b.var_b4d88433 );
        self.var_6639d45b.var_b4d88433 = undefined;
    }
    
    if ( is_true( clearanims ) && isdefined( var_b4d88433 ) )
    {
        self.var_6639d45b attach( var_b4d88433 );
        self.var_6639d45b.var_b4d88433 = var_b4d88433;
    }
    
    self.var_6639d45b function_1fac41e4( self function_19124308() );
    self.var_6639d45b hide();
    return self.var_6639d45b;
}

// Namespace action_utility/action_utility
// Params 3
// Checksum 0x3ceca4bf, Offset: 0x37d8
// Size: 0x8c
function function_464d0412( fullbody, player_arms, clearanims )
{
    assert( isplayer( self ) );
    self function_c0f7b46e( fullbody, clearanims );
    
    if ( !isdefined( player_arms ) )
    {
        player_arms = self.var_6639d45b;
    }
    
    if ( isdefined( player_arms ) )
    {
        player_arms show();
    }
}

// Namespace action_utility/action_utility
// Params 1
// Checksum 0x76f18209, Offset: 0x3870
// Size: 0x7c
function function_76e2ec80( player_arms )
{
    assert( isplayer( self ) );
    
    if ( !isdefined( player_arms ) )
    {
        player_arms = self.var_6639d45b;
    }
    
    if ( isdefined( player_arms ) )
    {
        player_arms hide();
        player_arms function_1e132b9f();
    }
}

// Namespace action_utility/action_utility
// Params 1
// Checksum 0xa75dca7c, Offset: 0x38f8
// Size: 0x174
function function_b0190b65( action )
{
    assert( isplayer( self ) );
    self.takedown.var_84ade654 = 1;
    curweap = self getcurrentweapon();
    
    if ( isdefined( curweap ) && curweap.name !== #"none" )
    {
        self.last_weapon = curweap;
    }
    
    self.takedown.stance[ action.name ] = self getstance();
    self setstance( "stand" );
    self val::set( #"hash_16b14161e87e9ac4", "allow_crouch", 0 );
    self val::set( #"hash_16b14161e87e9ac4", "allow_prone", 0 );
    self gesture_play( "ges_body_shield_gundown_quick" );
    self function_9d7828b0( 0.5 );
}

// Namespace action_utility/action_utility
// Params 1
// Checksum 0x479a0f47, Offset: 0x3a78
// Size: 0x3c
function function_9d7828b0( delay )
{
    self util::delay( delay, "stop_disable_weapons_offscreen", &function_5faaaecd );
}

// Namespace action_utility/action_utility
// Params 0
// Checksum 0xda3a7c19, Offset: 0x3ac0
// Size: 0x8c
function function_5faaaecd()
{
    self function_6179ffe7( self getcurrentweapon() );
    self val::set( #"hash_58b9fd1cfcf4a27d", "disable_weapons", 2 );
    wait 0.5;
    
    if ( isdefined( self.var_621f8539 ) )
    {
        self thread gesture_stop( self.var_621f8539 );
    }
}

// Namespace action_utility/action_utility
// Params 1
// Checksum 0x28e57bd8, Offset: 0x3b58
// Size: 0xfc
function function_44a46209( var_d8ba335a )
{
    assert( isplayer( self ) );
    self val::reset_all( #"hash_16b14161e87e9ac4" );
    
    if ( !is_true( self.takedown.var_84ade654 ) )
    {
        return;
    }
    
    if ( !self.var_6639d45b function_30b535ff( 0 ) )
    {
        self function_76e2ec80();
    }
    
    if ( isdefined( var_d8ba335a ) )
    {
        self setstance( var_d8ba335a );
    }
    
    self.takedown.var_84ade654 = undefined;
    self val::reset_all( #"hash_58b9fd1cfcf4a27d" );
}

// Namespace action_utility/action_utility
// Params 7
// Checksum 0x2dec63da, Offset: 0x3c60
// Size: 0xbc
function gesture_play( gesture = "", target, ignore_state, blendtime, starttime, canceltrans, stopall )
{
    if ( isgesture( gesture ) )
    {
        self thread function_6f3e9127( gesture, target, ignore_state, blendtime, starttime, canceltrans, stopall );
        return;
    }
    
    /#
        iprintln( "<dev string:x38>" + gesture + "<dev string:x51>" );
    #/
}

// Namespace action_utility/action_utility
// Params 0
// Checksum 0x5e4384ac, Offset: 0x3d28
// Size: 0x16
function function_b56ad054()
{
    self.takedown.var_adad6efa = 1;
}

// Namespace action_utility/action_utility
// Params 7, eflags: 0x4
// Checksum 0xf726a530, Offset: 0x3d48
// Size: 0x15c
function private function_6f3e9127( gesture, target, ignore_state, *blendtime, starttime, canceltrans, stopall )
{
    self notify( "1187e7e9f711fe0" );
    self endon( "1187e7e9f711fe0" );
    assert( isgesture( target ) );
    self endon( target + "_stop" );
    var_66f0ae81 = undefined;
    
    if ( is_true( self.takedown.var_adad6efa ) )
    {
        self.takedown.var_adad6efa = undefined;
        self function_44a46209();
    }
    
    while ( self function_b2ec14ab() )
    {
        waitframe( 1 );
        var_66f0ae81 = 1;
    }
    
    if ( is_true( var_66f0ae81 ) )
    {
        waitframe( 1 );
    }
    
    self playgestureviewmodel( target, ignore_state, blendtime, 0, starttime, canceltrans, stopall );
}

// Namespace action_utility/action_utility
// Params 3
// Checksum 0xc59e41ca, Offset: 0x3eb0
// Size: 0xac
function gesture_stop( gesture, *outtime, canceltrans )
{
    if ( !isdefined( outtime ) )
    {
        return;
    }
    
    if ( isdefined( outtime ) && isgesture( outtime ) )
    {
        self notify( outtime + "_stop" );
        self stopgestureviewmodel( outtime, 0, canceltrans );
        return;
    }
    
    if ( isdefined( outtime ) )
    {
        /#
            iprintln( "<dev string:x38>" + outtime + "<dev string:x51>" );
        #/
    }
}

// Namespace action_utility/action_utility
// Params 3
// Checksum 0x59db8923, Offset: 0x3f68
// Size: 0xac
function scene_play( scene, player, victim )
{
    a_ents = [];
    a_ents[ #"player" ] = player;
    a_ents[ #"victim" ] = victim;
    
    if ( isdefined( level.takedowns ) )
    {
        level.takedowns.scene = scene;
        level.takedowns.scene_root = self;
    }
    
    self scene::play( scene, a_ents );
}

// Namespace action_utility/action_utility
// Params 0
// Checksum 0xcae5e35d, Offset: 0x4020
// Size: 0x64
function scene_stop()
{
    if ( isdefined( level.takedowns.scene ) && isdefined( level.takedowns.scene_root ) )
    {
        level.takedowns.scene_root scene::stop( level.takedowns.scene );
    }
}

// Namespace action_utility/action_utility
// Params 1
// Checksum 0xeda51a1b, Offset: 0x4090
// Size: 0x92
function function_91639a4c( var_ee1fe147 )
{
    self notify( "1851cbbf6d57d60b" );
    self endon( "1851cbbf6d57d60b" );
    self function_a17b179f( var_ee1fe147 );
    
    if ( is_true( var_ee1fe147 ) )
    {
        self endon( #"death" );
        self waittill( #"hash_7884feb21ff33557" );
        self.var_d5bd339b = 1;
        return;
    }
    
    self.var_d5bd339b = undefined;
}

// Namespace action_utility/action_utility
// Params 1
// Checksum 0xe7694eea, Offset: 0x4130
// Size: 0x2f6
function function_71180c30( isolated )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    assert( isactor( self ) );
    victim = self;
    
    if ( is_true( isolated ) )
    {
        victim.var_419b4b2 = spawnstruct();
        victim.var_419b4b2.ignoreall = victim.ignoreall;
        victim.var_419b4b2.ignoreme = victim.ignoreme;
        victim.var_419b4b2.var_6eed8aea = victim.var_6eed8aea;
        victim.var_419b4b2.magic_bullet_shield = victim.magic_bullet_shield;
        victim thread function_91639a4c( 1 );
        victim.ignoreall = 1;
        victim.ignoreme = 1;
        victim.syncedmeleetarget = undefined;
        victim.var_6eed8aea = 0;
        
        if ( isdefined( victim.fnsetstealthstate ) )
        {
            victim [[ victim.fnsetstealthstate ]]( "idle" );
        }
        
        victim spawner::function_461ce3e9();
        victim notify( #"killanimscript" );
        
        if ( !is_true( victim.delayeddeath ) )
        {
            victim thread util::magic_bullet_shield();
        }
        
        victim lookatpos( undefined );
        victim setforcenocull();
        victim.var_e9c62827 = 1;
        return;
    }
    
    if ( isdefined( victim.var_419b4b2 ) )
    {
        victim thread function_91639a4c( 0 );
        victim.ignoreall = victim.var_419b4b2.ignoreall;
        victim.ignoreme = victim.var_419b4b2.ignoreme;
        victim.var_6eed8aea = victim.var_419b4b2.var_6eed8aea;
        victim.in_melee_death = undefined;
        victim removeforcenocull();
        victim.var_e9c62827 = 0;
        
        if ( !is_true( victim.magic_bullet_shield ) )
        {
            victim thread util::stop_magic_bullet_shield();
        }
        
        getplayers()[ 0 ] actions::function_942d9213();
        victim.var_419b4b2 = undefined;
    }
}

// Namespace action_utility/action_utility
// Params 0
// Checksum 0xb048b37c, Offset: 0x4430
// Size: 0x174
function function_1a2a3654()
{
    assert( isplayer( self ) );
    currentweapon = self getcurrentweapon();
    
    if ( !function_a06867b0( currentweapon ) )
    {
        return currentweapon;
    }
    
    result = undefined;
    resultammo = -1;
    
    foreach ( weapon in self getweaponslist() )
    {
        if ( weapon !== currentweapon && !function_a06867b0( weapon ) )
        {
            weaponammo = self getweaponammoclip( weapon );
            
            if ( !isdefined( result ) || weaponammo > resultammo )
            {
                result = weapon;
                resultammo = weaponammo;
            }
        }
    }
    
    return result;
}

// Namespace action_utility/action_utility
// Params 1
// Checksum 0xae788993, Offset: 0x45b0
// Size: 0x6e, Type: bool
function function_a06867b0( weapon )
{
    if ( !isweapon( weapon ) )
    {
        return false;
    }
    
    if ( is_true( weapon.isboltaction ) )
    {
        return true;
    }
    
    if ( is_true( weapon.isgrenadeweapon ) )
    {
        return true;
    }
    
    return false;
}

// Namespace action_utility/action_utility
// Params 1
// Checksum 0xd9489672, Offset: 0x4628
// Size: 0x92, Type: bool
function function_1c2cb657( weapon )
{
    if ( !isweapon( weapon ) )
    {
        return false;
    }
    
    if ( !is_true( weapon.ismeleeweapon ) && ( !is_true( weapon.isbulletweapon ) || is_true( weapon.issniperweapon ) ) )
    {
        return true;
    }
    
    return false;
}

// Namespace action_utility/action_utility
// Params 1
// Checksum 0x9b804621, Offset: 0x46c8
// Size: 0x72, Type: bool
function function_1fac6486( weapon )
{
    if ( !isweapon( weapon ) )
    {
        return false;
    }
    
    if ( is_true( weapon.ismeleeweapon ) && !is_true( weapon.isbulletweapon ) )
    {
        return true;
    }
    
    return false;
}

// Namespace action_utility/action_utility
// Params 0
// Checksum 0xaf94d6f2, Offset: 0x4748
// Size: 0xc4
function function_1e8adf77()
{
    e_player = level.player;
    
    if ( e_player flag::get( "body_shield_active" ) )
    {
        assert( isdefined( e_player.takedown.body_shield.actor ) && isai( e_player.takedown.body_shield.actor ), "<dev string:x57>" );
        e_player.takedown.body_shield.actor delete();
    }
}

