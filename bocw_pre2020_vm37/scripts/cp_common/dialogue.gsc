#using scripts\core_common\ai\systems\face;
#using scripts\core_common\ai_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\sound_shared;
#using scripts\core_common\util_shared;

#namespace dialogue;

// Namespace dialogue/dialogue
// Params 3
// Checksum 0x86dd255a, Offset: 0xc0
// Size: 0xac
function queue( alias, timeout, var_bcc3bb15 )
{
    if ( isdefined( self ) )
    {
        if ( is_true( var_bcc3bb15 ) )
        {
            self function_47b06180();
        }
        
        if ( !isdefined( timeout ) )
        {
            self util::function_stack( &function_8026ba41, alias );
            return;
        }
        
        self util::function_stack_timeout( timeout, &function_8026ba41, alias );
    }
}

// Namespace dialogue/dialogue
// Params 0
// Checksum 0xfc0ab202, Offset: 0x178
// Size: 0x56
function function_47b06180()
{
    if ( isscriptfunctionptr( level.var_4ceaaaf5 ) )
    {
        self thread [[ level.var_4ceaaaf5 ]]();
        return;
    }
    
    self util::function_stack_clear();
    self notify( #"cancel speaking" );
}

// Namespace dialogue/dialogue
// Params 4
// Checksum 0x4b85df27, Offset: 0x1d8
// Size: 0x16c
function radio( alias, timeout, var_1ccdc84c, var_bcc3bb15 )
{
    if ( is_true( var_bcc3bb15 ) )
    {
        self function_9e580f95();
        waitframe( 1 );
    }
    
    notifystring = "dialogue::radio " + alias;
    
    if ( isscriptfunctionptr( level.var_94934cfc ) )
    {
        self [[ level.var_94934cfc ]]( alias, notifystring );
        return;
    }
    
    player_radio_emitter = self function_dc8dd8fa();
    
    if ( !isdefined( player_radio_emitter ) )
    {
        return;
    }
    
    if ( is_true( var_1ccdc84c ) )
    {
        player_radio_emitter sound::play_on_tag( alias, undefined, 1, notifystring );
        return;
    }
    
    if ( !isdefined( timeout ) )
    {
        player_radio_emitter util::function_stack( &sound::play_on_tag, alias, undefined, 1, notifystring );
        return;
    }
    
    player_radio_emitter util::function_stack_timeout( timeout, &sound::play_on_tag, alias, undefined, 1, notifystring );
}

// Namespace dialogue/dialogue
// Params 0
// Checksum 0x79b5474d, Offset: 0x350
// Size: 0x114
function function_9e580f95()
{
    if ( isscriptfunctionptr( level.var_4ceaaaf5 ) )
    {
        self thread [[ level.var_4ceaaaf5 ]]();
        return;
    }
    
    player_radio_emitter = self function_dc8dd8fa();
    
    if ( !isdefined( player_radio_emitter ) )
    {
        return;
    }
    
    var_90c2cde7 = player_radio_emitter getlinkedchildren( 1 );
    
    foreach ( ent in var_90c2cde7 )
    {
        ent thread function_d708473a();
    }
    
    player_radio_emitter thread function_d708473a();
}

// Namespace dialogue/dialogue
// Params 0, eflags: 0x4
// Checksum 0x66c4f6ec, Offset: 0x470
// Size: 0x44
function private function_d708473a()
{
    self endon( #"death" );
    self stopsounds();
    waitframe( 1 );
    self delete();
}

// Namespace dialogue/dialogue
// Params 0
// Checksum 0x14caa95b, Offset: 0x4c0
// Size: 0x44
function function_dcdd0cb6()
{
    player_radio_emitter = self function_dc8dd8fa();
    
    if ( !isdefined( player_radio_emitter ) )
    {
        return;
    }
    
    player_radio_emitter util::function_stack_clear();
}

// Namespace dialogue/dialogue
// Params 1
// Checksum 0x89cabff7, Offset: 0x510
// Size: 0x52
function radio_safe( alias )
{
    return radio( alias, float( function_60d95f53() ) / 1000 );
}

// Namespace dialogue/dialogue
// Params 3
// Checksum 0xb8a18801, Offset: 0x570
// Size: 0x44
function function_96171f6d( alias, timeout, var_bcc3bb15 )
{
    player_gesture( alias, 0, undefined, undefined, undefined, timeout, var_bcc3bb15 );
}

// Namespace dialogue/dialogue
// Params 7
// Checksum 0xa917f70, Offset: 0x5c0
// Size: 0xfc
function player_gesture( alias, sounddelay, gestures, gesturedelays, targetents, timeout, var_bcc3bb15 )
{
    if ( is_true( var_bcc3bb15 ) )
    {
        self function_3db52a33();
    }
    
    player_dialogue_emitter = self function_7ddb5aa3();
    
    if ( !isdefined( player_dialogue_emitter ) )
    {
        return;
    }
    
    if ( !isdefined( timeout ) )
    {
        player_dialogue_emitter util::function_stack( &_play_player_dialogue, alias, sounddelay, gestures, gesturedelays, targetents );
        return;
    }
    
    player_dialogue_emitter util::function_stack_timeout( timeout, &_play_player_dialogue, alias, sounddelay, gestures, gesturedelays, targetents );
}

// Namespace dialogue/dialogue
// Params 0
// Checksum 0x9833f743, Offset: 0x6c8
// Size: 0xec
function function_3db52a33()
{
    player_dialogue_emitter = self function_7ddb5aa3();
    
    if ( !isdefined( player_dialogue_emitter ) )
    {
        return;
    }
    
    var_6ceb99a = player_dialogue_emitter getlinkedchildren( 1 );
    
    foreach ( ent in var_6ceb99a )
    {
        ent thread function_d708473a();
    }
    
    player_dialogue_emitter thread function_d708473a();
}

// Namespace dialogue/dialogue
// Params 0
// Checksum 0x40ceeaa8, Offset: 0x7c0
// Size: 0x44
function function_d37e4893()
{
    player_dialogue_emitter = self function_7ddb5aa3();
    
    if ( !isdefined( player_dialogue_emitter ) )
    {
        return;
    }
    
    player_dialogue_emitter util::function_stack_clear();
}

// Namespace dialogue/dialogue
// Params 5, eflags: 0x4
// Checksum 0x475e0b4d, Offset: 0x810
// Size: 0x364
function private _play_player_dialogue( alias, sounddelay, gestures, gesturedelays, gesturetargets )
{
    if ( ai::is_dead_sentient() )
    {
        return;
    }
    
    org = spawn( "script_origin", ( 0, 0, 0 ) );
    org endon( #"death" );
    org.origin = self.origin;
    org.angles = self.angles;
    org linkto( self );
    player = self function_bbd6c05b();
    player_dialogue_emitter = self function_7ddb5aa3();
    
    /#
        if ( isdefined( player_dialogue_emitter ) && self == player_dialogue_emitter )
        {
            println( "<dev string:x38>" + alias );
        }
    #/
    
    if ( sounddelay > 0 )
    {
        org util::delay( sounddelay, undefined, &playsoundwithnotify, alias, "sounddone" );
    }
    else
    {
        org playsoundwithnotify( alias, "sounddone" );
    }
    
    if ( isdefined( gestures ) )
    {
        assert( isdefined( gesturedelays ), "<dev string:x5b>" );
        
        if ( isarray( gestures ) )
        {
            assert( gestures.size == gesturedelays.size, "<dev string:xae>" );
            
            for ( i = 0; i < gestures.size ; i++ )
            {
                if ( isdefined( gesturetargets ) && isdefined( gesturetargets[ i ] ) )
                {
                    player util::delay( gesturedelays[ i ], undefined, &function_ef63262c, gestures[ i ], gesturetargets[ i ] );
                    continue;
                }
                
                player util::delay( gesturedelays[ i ], undefined, &function_ef63262c, gestures[ i ] );
            }
        }
        else if ( isdefined( gesturetargets ) )
        {
            player util::delay( gesturedelays, undefined, &function_ef63262c, gestures, gesturetargets );
        }
        else
        {
            player util::delay( gesturedelays, undefined, &function_ef63262c, gestures );
        }
    }
    
    if ( sounddelay > 0 )
    {
        wait sounddelay;
    }
    
    if ( !isdefined( sound::wait_for_sounddone_or_death( org, player ) ) )
    {
        org stopsounds();
    }
    
    wait 0.05;
    org delete();
}

// Namespace dialogue/dialogue
// Params 2
// Checksum 0x54adca95, Offset: 0xb80
// Size: 0xf2
function function_ef63262c( gesturename, lookatent )
{
    assert( self == level.player, "<dev string:x10e>" );
    self endon( #"death" );
    gestureplayed = 0;
    blendtime = undefined;
    canceltransition = 0;
    
    if ( isdefined( lookatent ) && isentity( lookatent ) )
    {
        gestureplayed = self playgestureviewmodel( gesturename, lookatent, 1, blendtime );
    }
    else
    {
        gestureplayed = self playgestureviewmodel( gesturename, undefined, 1, blendtime );
    }
    
    if ( gestureplayed )
    {
    }
    
    return gestureplayed;
}

// Namespace dialogue/dialogue
// Params 1, eflags: 0x4
// Checksum 0x1db4e8fe, Offset: 0xc80
// Size: 0x7c
function private function_8026ba41( alias )
{
    if ( isdefined( getscriptbundle( alias ) ) )
    {
        self thread scene::play( alias, self );
    }
    
    if ( soundexists( alias ) )
    {
        self face::playfacethread( undefined, alias, 1 );
    }
}

// Namespace dialogue/dialogue
// Params 0, eflags: 0x4
// Checksum 0xf20d3a8a, Offset: 0xd08
// Size: 0x54
function private function_bbd6c05b()
{
    if ( isplayer( self ) )
    {
        return self;
    }
    
    players = getplayers();
    
    if ( players.size > 0 )
    {
        return players[ 0 ];
    }
    
    return undefined;
}

// Namespace dialogue/dialogue
// Params 0, eflags: 0x4
// Checksum 0x6e09aeda, Offset: 0xd68
// Size: 0xa6
function private function_7ddb5aa3()
{
    player = self function_bbd6c05b();
    
    if ( isdefined( player ) )
    {
        if ( !isdefined( player.player_dialogue_emitter ) )
        {
            ent = spawn( "script_origin", player.origin );
            ent linkto( player, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
            player.player_dialogue_emitter = ent;
        }
        
        return player.player_dialogue_emitter;
    }
    
    return undefined;
}

// Namespace dialogue/dialogue
// Params 0, eflags: 0x4
// Checksum 0xd1284e9d, Offset: 0xe18
// Size: 0xb6
function private function_dc8dd8fa()
{
    player = self function_bbd6c05b();
    
    if ( isdefined( player ) )
    {
        if ( !isdefined( player.player_radio_emitter ) )
        {
            ent = spawn( "script_origin", player getplayercamerapos() );
            ent linkto( player, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
            player.player_radio_emitter = ent;
        }
        
        return player.player_radio_emitter;
    }
    
    return undefined;
}

