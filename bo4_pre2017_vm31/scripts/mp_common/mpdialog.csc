#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/dialog_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace mpdialog;

// Namespace mpdialog/mpdialog
// Params 0, eflags: 0x2
// Checksum 0xdfda5af7, Offset: 0x308
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "mpdialog", &__init__, undefined, undefined );
}

// Namespace mpdialog/mpdialog
// Params 0
// Checksum 0xc206139f, Offset: 0x348
// Size: 0x170
function __init__()
{
    level.mpboostresponse = [];
    level.mpboostresponse[ "assassin" ] = "Spectre";
    level.mpboostresponse[ "grenadier" ] = "Grenadier";
    level.mpboostresponse[ "outrider" ] = "Outrider";
    level.mpboostresponse[ "prophet" ] = "Technomancer";
    level.mpboostresponse[ "pyro" ] = "Firebreak";
    level.mpboostresponse[ "reaper" ] = "Reaper";
    level.mpboostresponse[ "ruin" ] = "Mercenary";
    level.mpboostresponse[ "seraph" ] = "Enforcer";
    level.mpboostresponse[ "trapper" ] = "Trapper";
    level.mpboostresponse[ "blackjack" ] = "Blackjack";
    level.clientvoicesetup = &client_voice_setup;
}

// Namespace mpdialog/mpdialog
// Params 1
// Checksum 0x41f9f06, Offset: 0x4c0
// Size: 0x84
function client_voice_setup( localclientnum )
{
    self thread snipervonotify( localclientnum, "playerbreathinsound", "exertSniperHold" );
    self thread snipervonotify( localclientnum, "playerbreathoutsound", "exertSniperExhale" );
    self thread snipervonotify( localclientnum, "playerbreathgaspsound", "exertSniperGasp" );
}

// Namespace mpdialog/mpdialog
// Params 3
// Checksum 0xb6a58f6c, Offset: 0x550
// Size: 0xa0
function snipervonotify( localclientnum, notifystring, dialogkey )
{
    self endon( #"death" );
    
    for ( ;; )
    {
        self waittill( notifystring );
        
        if ( isunderwater( localclientnum ) )
        {
            return;
        }
        
        dialogalias = self get_player_dialog_alias( dialogkey );
        
        if ( isdefined( dialogalias ) )
        {
            self playsound( 0, dialogalias );
        }
    }
}

// Namespace mpdialog/mpdialog
// Params 7
// Checksum 0xba245545, Offset: 0x5f8
// Size: 0x4c
function set_boost_number( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    level.boostnumber = newval;
}

// Namespace mpdialog/mpdialog
// Params 7
// Checksum 0x892c4b5d, Offset: 0x650
// Size: 0x15c
function play_boost_vox( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    localplayerteam = getlocalplayerteam( localclientnum );
    entitynumber = self getentitynumber();
    
    if ( newval == 0 || self.team != localplayerteam || level._sndnextsnapshot != "mpl_prematch" || level.booststartentnum === entitynumber || level.boostresponseentnum === entitynumber )
    {
        return;
    }
    
    if ( newval == 1 )
    {
        level.booststartentnum = entitynumber;
        self thread play_boost_start_vox( localclientnum );
        return;
    }
    
    if ( newval == 2 )
    {
        level.boostresponseentnum = entitynumber;
        self thread play_boost_start_response_vox( localclientnum );
    }
}

// Namespace mpdialog/mpdialog
// Params 1
// Checksum 0x3afb2c11, Offset: 0x7b8
// Size: 0x13c
function play_boost_start_vox( localclientnum )
{
    self endon( #"death" );
    wait 2;
    playbackid = self play_dialog( "boostStart" + level.boostnumber, localclientnum );
    
    if ( isdefined( playbackid ) && playbackid >= 0 )
    {
        while ( soundplaying( playbackid ) )
        {
            waitframe( 1 );
        }
    }
    
    wait 0.5;
    level.booststartresponse = "boostStartResp" + level.mpboostresponse[ self getmpdialogname() ] + level.boostnumber;
    
    if ( isdefined( level.boostresponseentnum ) )
    {
        responder = getentbynum( localclientnum, level.boostresponseentnum );
        
        if ( isdefined( responder ) )
        {
            responder thread play_boost_start_response_vox( localclientnum );
        }
    }
}

// Namespace mpdialog/mpdialog
// Params 1
// Checksum 0x97cccd98, Offset: 0x900
// Size: 0x74
function play_boost_start_response_vox( localclientnum )
{
    self endon( #"death" );
    
    if ( !isdefined( level.booststartresponse ) || self.team != getlocalplayerteam( localclientnum ) )
    {
        return;
    }
    
    self play_dialog( level.booststartresponse, localclientnum );
}

// Namespace mpdialog/mpdialog
// Params 2
// Checksum 0x6a523960, Offset: 0x980
// Size: 0x62
function get_commander_dialog_alias( commandername, dialogkey )
{
    if ( !isdefined( commandername ) )
    {
        return;
    }
    
    commanderbundle = struct::get_script_bundle( "mpdialog_commander", commandername );
    return get_dialog_bundle_alias( commanderbundle, dialogkey );
}

// Namespace mpdialog/mpdialog
// Params 1
// Checksum 0x91b652b9, Offset: 0x9f0
// Size: 0x82
function get_player_dialog_alias( dialogkey )
{
    bundlename = self getmpdialogname();
    
    if ( !isdefined( bundlename ) )
    {
        return undefined;
    }
    
    playerbundle = struct::get_script_bundle( "mpdialog_player", bundlename );
    return get_dialog_bundle_alias( playerbundle, dialogkey );
}

// Namespace mpdialog/mpdialog
// Params 2
// Checksum 0xf4eb7e82, Offset: 0xa80
// Size: 0x96
function get_dialog_bundle_alias( dialogbundle, dialogkey )
{
    if ( !isdefined( dialogbundle ) || !isdefined( dialogkey ) )
    {
        return undefined;
    }
    
    dialogalias = dialogbundle.( dialogkey );
    
    if ( !isdefined( dialogalias ) )
    {
        return;
    }
    
    voiceprefix = dialogbundle.( "voiceprefix" );
    
    if ( isdefined( voiceprefix ) )
    {
        dialogalias = voiceprefix + dialogalias;
    }
    
    return dialogalias;
}

// Namespace mpdialog/mpdialog
// Params 2
// Checksum 0x13d7c14a, Offset: 0xb20
// Size: 0x162
function play_dialog( dialogkey, localclientnum )
{
    if ( !isdefined( dialogkey ) || !isdefined( localclientnum ) )
    {
        return -1;
    }
    
    dialogalias = self get_player_dialog_alias( dialogkey );
    
    if ( !isdefined( dialogalias ) )
    {
        return -1;
    }
    
    soundpos = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + 60 );
    
    if ( !isspectating( localclientnum ) )
    {
        return self playsound( undefined, dialogalias, soundpos );
    }
    
    voicebox = spawn( localclientnum, self.origin, "script_model" );
    self thread update_voice_origin( voicebox );
    voicebox thread delete_after( 10 );
    return voicebox playsound( undefined, dialogalias, soundpos );
}

// Namespace mpdialog/mpdialog
// Params 1
// Checksum 0xb31b6ce9, Offset: 0xc90
// Size: 0x50
function update_voice_origin( voicebox )
{
    while ( true )
    {
        wait 0.1;
        
        if ( !isdefined( self ) || !isdefined( voicebox ) )
        {
            return;
        }
        
        voicebox.origin = self.origin;
    }
}

// Namespace mpdialog/mpdialog
// Params 1
// Checksum 0x3b260ca1, Offset: 0xce8
// Size: 0x24
function delete_after( waittime )
{
    wait waittime;
    self delete();
}

