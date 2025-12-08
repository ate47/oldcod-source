#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/hud_shared;
#using scripts/core_common/lui_shared;
#using scripts/core_common/struct;
#using scripts/core_common/util_shared;
#using scripts/mp_common/killstreaks/ai_tank;
#using scripts/mp_common/killstreaks/killstreakrules;
#using scripts/mp_common/killstreaks/killstreaks;
#using scripts/mp_common/killstreaks/qrdrone;
#using scripts/mp_common/killstreaks/turret;
#using scripts/mp_common/util;

#namespace remote_weapons;

// Namespace remote_weapons/remote_weapons
// Params 0
// Checksum 0xcce88518, Offset: 0x390
// Size: 0x4c
function init()
{
    level.remoteweapons = [];
    level.remoteexithint = &"MP_REMOTE_EXIT";
    callback::on_spawned( &on_player_spawned );
}

// Namespace remote_weapons/remote_weapons
// Params 0
// Checksum 0xe9dcc6f2, Offset: 0x3e8
// Size: 0x24
function on_player_spawned()
{
    self endon( #"disconnect" );
    self assignremotecontroltrigger();
}

// Namespace remote_weapons/remote_weapons
// Params 1
// Checksum 0xa3969c16, Offset: 0x418
// Size: 0x44
function removeandassignnewremotecontroltrigger( remotecontroltrigger )
{
    arrayremovevalue( self.activeremotecontroltriggers, remotecontroltrigger );
    self assignremotecontroltrigger( 1 );
}

// Namespace remote_weapons/remote_weapons
// Params 1
// Checksum 0xbd6a29f8, Offset: 0x468
// Size: 0xf4
function assignremotecontroltrigger( force_new_assignment )
{
    if ( !isdefined( force_new_assignment ) )
    {
        force_new_assignment = 0;
    }
    
    if ( !isdefined( self.activeremotecontroltriggers ) )
    {
        self.activeremotecontroltriggers = [];
    }
    
    arrayremovevalue( self.activeremotecontroltriggers, undefined );
    
    if ( ( !isdefined( self.remotecontroltrigger ) || force_new_assignment ) && self.activeremotecontroltriggers.size > 0 )
    {
        self.remotecontroltrigger = self.activeremotecontroltriggers[ self.activeremotecontroltriggers.size - 1 ];
    }
    
    if ( isdefined( self.remotecontroltrigger ) )
    {
        self.remotecontroltrigger.origin = self.origin;
        self.remotecontroltrigger linkto( self );
    }
}

// Namespace remote_weapons/remote_weapons
// Params 5
// Checksum 0xf6a4d531, Offset: 0x568
// Size: 0x108
function registerremoteweapon( weaponname, hintstring, usecallback, endusecallback, hidecompassonuse )
{
    if ( !isdefined( hidecompassonuse ) )
    {
        hidecompassonuse = 1;
    }
    
    assert( isdefined( level.remoteweapons ) );
    level.remoteweapons[ weaponname ] = spawnstruct();
    level.remoteweapons[ weaponname ].hintstring = hintstring;
    level.remoteweapons[ weaponname ].usecallback = usecallback;
    level.remoteweapons[ weaponname ].endusecallback = endusecallback;
    level.remoteweapons[ weaponname ].hidecompassonuse = hidecompassonuse;
}

// Namespace remote_weapons/remote_weapons
// Params 5
// Checksum 0x5f34955, Offset: 0x678
// Size: 0x144
function useremoteweapon( weapon, weaponname, immediate, allowmanualdeactivation, always_allow_ride )
{
    if ( !isdefined( allowmanualdeactivation ) )
    {
        allowmanualdeactivation = 1;
    }
    
    if ( !isdefined( always_allow_ride ) )
    {
        always_allow_ride = 0;
    }
    
    player = self;
    assert( isplayer( player ) );
    weapon.remoteowner = player;
    weapon.inittime = gettime();
    weapon.remotename = weaponname;
    weapon.remoteweaponallowmanualdeactivation = allowmanualdeactivation;
    weapon thread watchremoveremotecontrolledweapon();
    
    if ( !immediate )
    {
        weapon createremoteweapontrigger();
        return;
    }
    
    weapon thread watchownerdisconnect();
    weapon useremotecontrolweapon( allowmanualdeactivation, always_allow_ride );
}

// Namespace remote_weapons/remote_weapons
// Params 0
// Checksum 0x6e251b72, Offset: 0x7c8
// Size: 0xa0
function watchforhack()
{
    weapon = self;
    weapon endon( #"death" );
    waitresult = weapon waittill( "killstreak_hacked" );
    
    if ( isdefined( weapon.remoteweaponallowmanualdeactivation ) && weapon.remoteweaponallowmanualdeactivation == 1 )
    {
        weapon thread watchremotecontroldeactivate();
    }
    
    weapon.remoteowner = waitresult.hacker;
}

// Namespace remote_weapons/remote_weapons
// Params 0
// Checksum 0x86932205, Offset: 0x870
// Size: 0x68
function watchremoveremotecontrolledweapon()
{
    weapon = self;
    weapon endon( #"remote_weapon_end" );
    weapon waittill( "death", "remote_weapon_shutdown" );
    weapon endremotecontrolweaponuse( 0 );
    
    while ( isdefined( weapon ) )
    {
        waitframe( 1 );
    }
}

// Namespace remote_weapons/remote_weapons
// Params 0
// Checksum 0x3a17831c, Offset: 0x8e0
// Size: 0x294
function createremoteweapontrigger()
{
    weapon = self;
    player = weapon.remoteowner;
    
    if ( isdefined( weapon.usetrigger ) )
    {
        weapon.usetrigger delete();
    }
    
    weapon.usetrigger = spawn( "trigger_radius_use", player.origin, 0, 32, 32 );
    weapon.usetrigger enablelinkto();
    weapon.usetrigger linkto( player );
    weapon.usetrigger sethintlowpriority( 1 );
    weapon.usetrigger setcursorhint( "HINT_NOICON" );
    weapon.usetrigger sethintstring( level.remoteweapons[ weapon.remotename ].hintstring );
    weapon.usetrigger setteamfortrigger( player.team );
    weapon.usetrigger.team = player.team;
    player clientclaimtrigger( weapon.usetrigger );
    player.remotecontroltrigger = weapon.usetrigger;
    player.activeremotecontroltriggers[ player.activeremotecontroltriggers.size ] = weapon.usetrigger;
    weapon.usetrigger.claimedby = player;
    weapon thread watchweapondeath();
    weapon thread watchownerdisconnect();
    weapon thread watchremotetriggeruse();
    weapon thread watchremotetriggerdisable();
}

// Namespace remote_weapons/remote_weapons
// Params 0
// Checksum 0x2bc27fe, Offset: 0xb80
// Size: 0xa4
function watchweapondeath()
{
    weapon = self;
    weapon.usetrigger endon( #"death" );
    weapon waittill( "death", "remote_weapon_end" );
    
    if ( isdefined( weapon.remoteowner ) )
    {
        weapon.remoteowner removeandassignnewremotecontroltrigger( weapon.usetrigger );
    }
    
    weapon.usetrigger delete();
}

// Namespace remote_weapons/remote_weapons
// Params 0
// Checksum 0x358ced81, Offset: 0xc30
// Size: 0xd4
function watchownerdisconnect()
{
    weapon = self;
    weapon endon( #"remote_weapon_end" );
    weapon endon( #"remote_weapon_shutdown" );
    
    if ( isdefined( weapon.usetrigger ) )
    {
        weapon.usetrigger endon( #"death" );
    }
    
    weapon.remoteowner waittill( "joined_team", "disconnect", "joined_spectators" );
    endremotecontrolweaponuse( 0 );
    
    if ( isdefined( weapon ) && isdefined( weapon.usetrigger ) )
    {
        weapon.usetrigger delete();
    }
}

// Namespace remote_weapons/remote_weapons
// Params 0
// Checksum 0x9e00c9bb, Offset: 0xd10
// Size: 0xa0
function watchremotetriggerdisable()
{
    weapon = self;
    weapon endon( #"remote_weapon_end" );
    weapon endon( #"remote_weapon_shutdown" );
    weapon.usetrigger endon( #"death" );
    
    while ( true )
    {
        weapon.usetrigger triggerenable( !weapon.remoteowner iswallrunning() );
        wait 0.1;
    }
}

// Namespace remote_weapons/remote_weapons
// Params 0
// Checksum 0xabedf986, Offset: 0xdb8
// Size: 0xca
function allowremotestart()
{
    player = self;
    
    if ( player usebuttonpressed() && !player.throwinggrenade && !player meleebuttonpressed() && !player util::isusingremote() && !( isdefined( player.carryobject.disallowremotecontrol ) && isdefined( player.carryobject ) && player.carryobject.disallowremotecontrol ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace remote_weapons/remote_weapons
// Params 0
// Checksum 0x1fb8055c, Offset: 0xe90
// Size: 0x168
function watchremotetriggeruse()
{
    weapon = self;
    weapon endon( #"death" );
    weapon endon( #"remote_weapon_end" );
    
    if ( weapon.remoteowner isbot() )
    {
        return;
    }
    
    while ( true )
    {
        weapon.usetrigger waittill( "trigger" );
        
        if ( weapon.remoteowner isusingoffhand() || weapon.remoteowner iswallrunning() )
        {
            continue;
        }
        
        if ( isdefined( weapon.hackertrigger ) && isdefined( weapon.hackertrigger.progressbar ) )
        {
            if ( weapon.remotename == "killstreak_remote_turret" )
            {
                weapon.remoteowner iprintlnbold( &"KILLSTREAK_AUTO_TURRET_NOT_AVAILABLE" );
            }
            
            continue;
        }
        
        if ( weapon.remoteowner allowremotestart() )
        {
            useremotecontrolweapon();
        }
    }
}

// Namespace remote_weapons/remote_weapons
// Params 2
// Checksum 0xde455962, Offset: 0x1000
// Size: 0x444
function useremotecontrolweapon( allowmanualdeactivation, always_allow_ride )
{
    if ( !isdefined( allowmanualdeactivation ) )
    {
        allowmanualdeactivation = 1;
    }
    
    if ( !isdefined( always_allow_ride ) )
    {
        always_allow_ride = 0;
    }
    
    self endon( #"death" );
    weapon = self;
    assert( isdefined( weapon.remoteowner ) );
    weapon.control_initiated = 1;
    weapon.endremotecontrolweapon = 0;
    weapon.remoteowner endon( #"disconnect" );
    weapon.remoteowner endon( #"joined_team" );
    weapon.remoteowner disableoffhandweapons();
    weapon.remoteowner disableweaponcycling();
    weapon.remoteowner.dofutz = 0;
    
    if ( !isdefined( weapon.disableremoteweaponswitch ) )
    {
        remoteweapon = getweapon( "killstreak_remote" );
        weapon.remoteowner giveweapon( remoteweapon );
        weapon.remoteowner switchtoweapon( remoteweapon );
        
        if ( always_allow_ride )
        {
            weapon.remoteowner waittill( "weapon_change", "death" );
        }
        else
        {
            waitresult = weapon.remoteowner waittill( "weapon_change" );
            newweapon = waitresult.weapon;
        }
    }
    
    if ( isdefined( newweapon ) )
    {
        if ( newweapon != remoteweapon )
        {
            weapon.remoteowner killstreaks::clear_using_remote( 1, 1 );
            return;
        }
    }
    
    weapon.remoteowner thread killstreaks::watch_for_remove_remote_weapon();
    weapon.remoteowner util::setusingremote( weapon.remotename );
    weapon.remoteowner util::freeze_player_controls( 1 );
    result = weapon.remoteowner killstreaks::init_ride_killstreak( weapon.remotename, always_allow_ride );
    
    if ( result != "success" )
    {
        if ( result != "disconnect" )
        {
            weapon.remoteowner killstreaks::clear_using_remote();
            weapon thread resetcontrolinitiateduponownerrespawn();
        }
    }
    else
    {
        weapon.controlled = 1;
        weapon.killcament = self;
        weapon notify( #"remote_start" );
        
        if ( allowmanualdeactivation )
        {
            weapon thread watchremotecontroldeactivate();
        }
        
        weapon.remoteowner thread [[ level.remoteweapons[ weapon.remotename ].usecallback ]]( weapon );
        
        if ( level.remoteweapons[ weapon.remotename ].hidecompassonuse )
        {
            weapon.remoteowner killstreaks::hide_compass();
        }
    }
    
    weapon.remoteowner util::freeze_player_controls( 0 );
}

// Namespace remote_weapons/remote_weapons
// Params 0
// Checksum 0x1bb289c3, Offset: 0x1450
// Size: 0x30
function resetcontrolinitiateduponownerrespawn()
{
    self endon( #"death" );
    self.remoteowner waittill( "spawned" );
    self.control_initiated = 0;
}

// Namespace remote_weapons/remote_weapons
// Params 0
// Checksum 0xfbbad8f4, Offset: 0x1488
// Size: 0xf2
function watchremotecontroldeactivate()
{
    self notify( #"watchremotecontroldeactivate_remoteweapons" );
    self endon( #"watchremotecontroldeactivate_remoteweapons" );
    weapon = self;
    weapon endon( #"remote_weapon_end" );
    weapon endon( #"death" );
    weapon.remoteowner endon( #"disconnect" );
    
    while ( true )
    {
        timeused = 0;
        
        while ( weapon.remoteowner usebuttonpressed() )
        {
            timeused += 0.05;
            
            if ( timeused > 0.25 )
            {
                weapon thread endremotecontrolweaponuse( 1 );
                return;
            }
            
            waitframe( 1 );
        }
        
        waitframe( 1 );
    }
}

// Namespace remote_weapons/remote_weapons
// Params 1
// Checksum 0xd17752fb, Offset: 0x1588
// Size: 0x4f8
function endremotecontrolweaponuse( exitrequestedbyowner )
{
    weapon = self;
    
    if ( isdefined( weapon.endremotecontrolweapon ) && ( !isdefined( weapon ) || weapon.endremotecontrolweapon ) )
    {
        return;
    }
    
    weapon.endremotecontrolweapon = 1;
    remote_controlled = isdefined( weapon.controlled ) && ( isdefined( weapon.control_initiated ) && weapon.control_initiated || weapon.controlled );
    
    while ( isdefined( weapon ) && weapon.forcewaitremotecontrol === 1 && remote_controlled == 0 )
    {
        remote_controlled = isdefined( weapon.controlled ) && ( isdefined( weapon.control_initiated ) && weapon.control_initiated || weapon.controlled );
        waitframe( 1 );
    }
    
    if ( !isdefined( weapon ) )
    {
        return;
    }
    
    if ( isdefined( weapon.remoteowner ) && remote_controlled )
    {
        if ( isdefined( weapon.remoteweaponshutdowndelay ) )
        {
            wait weapon.remoteweaponshutdowndelay;
        }
        
        player = weapon.remoteowner;
        
        if ( player.dofutz === 1 )
        {
            player clientfield::set_to_player( "static_postfx", 1 );
            wait 1;
            
            if ( isdefined( player ) )
            {
                player clientfield::set_to_player( "static_postfx", 0 );
                player.dofutz = 0;
            }
        }
        else if ( !exitrequestedbyowner && weapon.watch_remote_weapon_death === 1 && !isalive( weapon ) )
        {
            wait isdefined( weapon.watch_remote_weapon_death_duration ) ? weapon.watch_remote_weapon_death_duration : 1;
        }
        
        if ( isdefined( player ) )
        {
            player thread fadetoblackandbackin();
            player waittill( "fade2black" );
            
            if ( remote_controlled )
            {
                player unlink();
            }
            
            player killstreaks::clear_using_remote( 1 );
            cleared_killstreak_delay = 1;
            player enableusability();
        }
    }
    
    if ( isdefined( weapon ) && isdefined( weapon.remotename ) )
    {
        self [[ level.remoteweapons[ weapon.remotename ].endusecallback ]]( weapon, exitrequestedbyowner );
    }
    
    if ( isdefined( weapon ) )
    {
        weapon.killcament = weapon;
        
        if ( isdefined( weapon.remoteowner ) )
        {
            if ( remote_controlled )
            {
                weapon.remoteowner unlink();
                
                if ( !( isdefined( cleared_killstreak_delay ) && cleared_killstreak_delay ) )
                {
                    weapon.remoteowner killstreaks::reset_killstreak_delay_killcam();
                }
                
                weapon.remoteowner util::clientnotify( "nofutz" );
            }
            
            if ( isdefined( level.gameended ) && level.gameended )
            {
                weapon.remoteowner util::freeze_player_controls( 1 );
            }
        }
    }
    
    if ( isdefined( weapon ) )
    {
        weapon.control_initiated = 0;
        weapon.controlled = 0;
        
        if ( isdefined( weapon.remoteowner ) )
        {
            weapon.remoteowner killstreaks::unhide_compass();
        }
        
        if ( isdefined( weapon.one_remote_use ) && ( !exitrequestedbyowner || weapon.one_remote_use ) )
        {
            weapon notify( #"remote_weapon_end" );
        }
    }
}

// Namespace remote_weapons/remote_weapons
// Params 0
// Checksum 0x50f90c1b, Offset: 0x1a88
// Size: 0x6c
function fadetoblackandbackin()
{
    self endon( #"disconnect" );
    lui::screen_fade_out( 0.1 );
    self qrdrone::destroyhud();
    waitframe( 1 );
    self notify( #"fade2black" );
    lui::screen_fade_in( 0.2 );
}

// Namespace remote_weapons/remote_weapons
// Params 1
// Checksum 0x16a9c50c, Offset: 0x1b00
// Size: 0xcc
function stunstaticfx( duration )
{
    self endon( #"remove_remote_weapon" );
    self.fullscreen_static.alpha = 0.65;
    wait duration - 0.5;
    time = duration - 0.5;
    
    while ( time < duration )
    {
        waitframe( 1 );
        time += 0.05;
        self.fullscreen_static.alpha -= 0.05;
    }
    
    self.fullscreen_static.alpha = 0.15;
}

// Namespace remote_weapons/remote_weapons
// Params 0
// Checksum 0x37db3f5b, Offset: 0x1bd8
// Size: 0x84
function destroyremotehud()
{
    self useservervisionset( 0 );
    self setinfraredvision( 0 );
    
    if ( isdefined( self.fullscreen_static ) )
    {
        self.fullscreen_static destroy();
    }
    
    if ( isdefined( self.hud_prompt_exit ) )
    {
        self.hud_prompt_exit destroy();
    }
}

// Namespace remote_weapons/remote_weapons
// Params 1
// Checksum 0x787145d6, Offset: 0x1c68
// Size: 0x84
function set_static( val )
{
    owner = self.owner;
    
    if ( isdefined( owner ) && owner.usingvehicle && isdefined( owner.viewlockedentity ) && owner.viewlockedentity == self )
    {
        owner clientfield::set_to_player( "static_postfx", val );
    }
}

// Namespace remote_weapons/remote_weapons
// Params 0
// Checksum 0x8363d6a7, Offset: 0x1cf8
// Size: 0x5a
function do_static_fx()
{
    self endon( #"death" );
    self set_static( 1 );
    wait 2;
    self set_static( 0 );
    self notify( #"static_fx_done" );
}

