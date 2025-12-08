#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/abilities/gadgets/gadget_resurrect;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/demo_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/hud_util_shared;
#using scripts/core_common/killcam_shared;
#using scripts/core_common/laststand_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/values_shared;
#using scripts/mp_common/gametypes/globallogic_player;
#using scripts/mp_common/gametypes/globallogic_spawn;

#namespace laststand;

// Namespace laststand/laststand
// Params 0, eflags: 0x2
// Checksum 0x4d953c55, Offset: 0x3d8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "laststand", &__init__, undefined, undefined );
}

// Namespace laststand/laststand
// Params 0
// Checksum 0xd7c6c9b1, Offset: 0x418
// Size: 0x1e
function __init__()
{
    if ( level.script == "frontend" )
    {
        return;
    }
}

// Namespace laststand/laststand
// Params 9
// Checksum 0x3305ac4d, Offset: 0x440
// Size: 0x130
function player_last_stand_stats( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration )
{
    if ( isdefined( attacker ) && isplayer( attacker ) && attacker != self )
    {
        attacker.kills++;
        
        if ( isdefined( weapon ) )
        {
            dmgweapon = weapon;
            weaponpickedup = 0;
            
            if ( isdefined( attacker.pickedupweapons ) && isdefined( attacker.pickedupweapons[ weapon ] ) )
            {
                weaponpickedup = 1;
            }
            
            attacker addweaponstat( dmgweapon, "kills", 1, attacker.class_num, weaponpickedup );
        }
    }
    
    self.downs++;
}

// Namespace laststand/laststand
// Params 9
// Checksum 0x316a6bd, Offset: 0x578
// Size: 0x3fc
function playerlaststand( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, delayoverride )
{
    if ( self player_is_in_laststand() )
    {
        return;
    }
    
    if ( isdefined( self.resurrect_not_allowed_by ) )
    {
        return;
    }
    
    self globallogic_player::callback_playerkilled( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, 0, 1 );
    self notify( #"entering_last_stand" );
    
    if ( isdefined( level._game_module_player_laststand_callback ) )
    {
        self [[ level._game_module_player_laststand_callback ]]( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, delayoverride );
    }
    
    self.laststandparams = spawnstruct();
    self.laststandparams.einflictor = einflictor;
    self.laststandparams.attacker = attacker;
    self.laststandparams.idamage = idamage;
    self.laststandparams.smeansofdeath = smeansofdeath;
    self.laststandparams.sweapon = weapon;
    self.laststandparams.vdir = vdir;
    self.laststandparams.shitloc = shitloc;
    self.laststandparams.laststandstarttime = gettime();
    self.laststandparams.killcam_entity_info_cached = killcam::get_killcam_entity_info( attacker, einflictor, weapon );
    self thread player_last_stand_stats( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, delayoverride );
    self.health = 1;
    self.laststand = 1;
    self val::set( "laststand", "ignoreme", 1 );
    self val::set( "laststand", "takedamage", 0 );
    self.meleeattackers = undefined;
    self.no_revive_trigger = 1;
    callback::callback( #"hash_6751ab5b" );
    assert( isdefined( self.resurrect_weapon ) );
    assert( self.resurrect_weapon != level.weaponnone );
    slot = self ability_util::gadget_slot_for_type( 40 );
    self gadgetstatechange( slot, self.resurrect_weapon, 2 );
    self laststand_disable_player_weapons();
    self thread makesureswitchtoweapon();
    self thread resurrect::enter_rejack_standby();
    self thread watch_player_input();
    demo::bookmark( "player_downed", gettime(), self );
}

// Namespace laststand/laststand
// Params 0
// Checksum 0x2739bad7, Offset: 0x980
// Size: 0x9e
function makesureswitchtoweapon()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"bleed_out" );
    self endon( #"player_input_revive" );
    self endon( #"player_input_suicide" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( self getcurrentweapon() != self.resurrect_weapon )
        {
            self switchtoweapon( self.resurrect_weapon );
        }
        
        waitframe( 1 );
    }
}

// Namespace laststand/laststand
// Params 0
// Checksum 0xc43ec8d, Offset: 0xa28
// Size: 0xcc
function laststand_disable_player_weapons()
{
    weaponinventory = self getweaponslist( 1 );
    self.lastactiveweapon = self getcurrentweapon();
    
    if ( self isthrowinggrenade() )
    {
        primaryweapons = self getweaponslistprimaries();
        
        if ( isdefined( primaryweapons ) && primaryweapons.size > 0 )
        {
            self.lastactiveweapon = primaryweapons[ 0 ];
            self switchtoweaponimmediate( self.lastactiveweapon );
        }
    }
}

// Namespace laststand/laststand
// Params 1
// Checksum 0xdadb7685, Offset: 0xb00
// Size: 0x114
function laststand_enable_player_weapons( b_allow_grenades )
{
    if ( !isdefined( b_allow_grenades ) )
    {
        b_allow_grenades = 1;
    }
    
    self enableweaponcycling();
    
    if ( b_allow_grenades )
    {
        self enableoffhandweapons();
    }
    
    if ( isdefined( self.lastactiveweapon ) && self.lastactiveweapon != level.weaponnone && self hasweapon( self.lastactiveweapon ) )
    {
        self switchtoweapon( self.lastactiveweapon );
        return;
    }
    
    primaryweapons = self getweaponslistprimaries();
    
    if ( isdefined( primaryweapons ) && primaryweapons.size > 0 )
    {
        self switchtoweapon( primaryweapons[ 0 ] );
    }
}

// Namespace laststand/laststand
// Params 2
// Checksum 0x95ad6de7, Offset: 0xc20
// Size: 0xe4
function laststand_clean_up_on_interrupt( playerbeingrevived, revivergun )
{
    self endon( #"do_revive_ended_normally" );
    revivetrigger = playerbeingrevived.revivetrigger;
    playerbeingrevived waittill( "disconnect", "game_ended", "death" );
    
    if ( isdefined( revivetrigger ) )
    {
        revivetrigger delete();
    }
    
    self cleanup_suicide_hud();
    
    if ( isdefined( self.reviveprogressbar ) )
    {
        self.reviveprogressbar hud::destroyelem();
    }
    
    if ( isdefined( self.revivetexthud ) )
    {
        self.revivetexthud destroy();
    }
}

// Namespace laststand/laststand
// Params 1
// Checksum 0xbf40a64a, Offset: 0xd10
// Size: 0x60
function laststand_clean_up_reviving_any( playerbeingrevived )
{
    self endon( #"do_revive_ended_normally" );
    playerbeingrevived waittill( "disconnect", "zombified", "stop_revive_trigger" );
    self.is_reviving_any--;
    
    if ( 0 > self.is_reviving_any )
    {
        self.is_reviving_any = 0;
    }
}

// Namespace laststand/laststand
// Params 0
// Checksum 0xa1913105, Offset: 0xd78
// Size: 0xdc
function bleed_out()
{
    demo::bookmark( "player_bledout", gettime(), self, undefined, 1 );
    level notify( #"bleed_out", { #character_index:self.characterindex } );
    self undolaststand();
    self val::reset( "laststand", "ignoreme" );
    self.laststand = undefined;
    self.uselaststandparams = 1;
    
    if ( !isdefined( self.laststandparams.attacker ) )
    {
        self.laststandparams.attacker = self;
    }
    
    self suicide();
}

// Namespace laststand/laststand
// Params 0
// Checksum 0x5a2246e7, Offset: 0xe60
// Size: 0x34
function watch_player_input()
{
    self thread watch_player_input_revive();
    self thread watch_player_input_suicide();
}

// Namespace laststand/laststand
// Params 0
// Checksum 0x785ec30, Offset: 0xea0
// Size: 0x104
function watch_player_input_revive()
{
    level endon( #"game_ended" );
    self endon( #"player_input_bleed_out" );
    self endon( #"disconnect" );
    self endon( #"death" );
    self waittill( "player_input_revive" );
    demo::bookmark( "player_revived", gettime(), self, self );
    self rejack();
    self laststand_enable_player_weapons();
    self val::reset( "laststand", "ignoreme" );
    self val::reset( "laststand", "takedamage" );
    self.laststand = undefined;
    callback::callback( #"hash_56e431c2" );
}

// Namespace laststand/laststand
// Params 0
// Checksum 0xfdff5e20, Offset: 0xfb0
// Size: 0x5c
function watch_player_input_suicide()
{
    level endon( #"game_ended" );
    self endon( #"player_input_revive" );
    self endon( #"disconnect" );
    self endon( #"death" );
    self waittill( "player_input_suicide" );
    self bleed_out();
}

