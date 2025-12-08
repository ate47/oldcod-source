#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/damagefeedback_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/hacker_tool;
#using scripts/core_common/weapons/weaponobjects;

#namespace threat_detector;

// Namespace threat_detector/threat_detector
// Params 0, eflags: 0x2
// Checksum 0xe506acb6, Offset: 0x2b0
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "threat_detector", &__init__, undefined, undefined );
}

// Namespace threat_detector/threat_detector
// Params 0
// Checksum 0x9a46c6c7, Offset: 0x2f0
// Size: 0x54
function __init__()
{
    clientfield::register( "missile", "threat_detector", 1, 1, "int" );
    callback::add_weapon_watcher( &createthreatdetectorwatcher );
}

// Namespace threat_detector/threat_detector
// Params 0
// Checksum 0xf1224abf, Offset: 0x350
// Size: 0xcc
function createthreatdetectorwatcher()
{
    watcher = self weaponobjects::createuseweaponobjectwatcher( "threat_detector", self.team );
    watcher.headicon = 0;
    watcher.onspawn = &onspawnthreatdetector;
    watcher.ondetonatecallback = &threatdetectordestroyed;
    watcher.stun = &weaponobjects::weaponstun;
    watcher.stuntime = 0;
    watcher.ondamage = &watchthreatdetectordamage;
    watcher.enemydestroy = 1;
}

// Namespace threat_detector/threat_detector
// Params 2
// Checksum 0xb29a0dbc, Offset: 0x428
// Size: 0x114
function onspawnthreatdetector( watcher, player )
{
    self endon( #"death" );
    self thread weaponobjects::onspawnuseweaponobject( watcher, player );
    self setowner( player );
    self setteam( player.team );
    self.owner = player;
    self playloopsound( "wpn_sensor_nade_lp" );
    self hacker_tool::registerwithhackertool( level.equipmenthackertoolradius, level.equipmenthackertooltimems );
    player addweaponstat( self.weapon, "used", 1 );
    self thread watchforstationary( player );
}

// Namespace threat_detector/threat_detector
// Params 1
// Checksum 0xdaf0fc96, Offset: 0x548
// Size: 0x6c
function watchforstationary( owner )
{
    self endon( #"death", #"hacked", #"explode" );
    owner endon( #"death", #"disconnect" );
    self waittill( "stationary" );
    self clientfield::set( "threat_detector", 1 );
}

// Namespace threat_detector/threat_detector
// Params 1
// Checksum 0x2641aac9, Offset: 0x5c0
// Size: 0x84
function tracksensorgrenadevictim( victim )
{
    if ( !isdefined( self.sensorgrenadedata ) )
    {
        self.sensorgrenadedata = [];
    }
    
    if ( !isdefined( self.sensorgrenadedata[ victim.clientid ] ) )
    {
        self.sensorgrenadedata[ victim.clientid ] = gettime();
    }
    
    self clientfield::set_to_player( "threat_detected", 1 );
}

// Namespace threat_detector/threat_detector
// Params 3
// Checksum 0x3382460c, Offset: 0x650
// Size: 0x10c
function threatdetectordestroyed( attacker, weapon, target )
{
    if ( !isdefined( weapon ) || !weapon.isemp )
    {
        playfx( level._equipment_explode_fx, self.origin );
    }
    
    if ( isdefined( attacker ) )
    {
        if ( self.owner util::isenemyplayer( attacker ) )
        {
            attacker challenges::destroyedequipment( weapon );
            scoreevents::processscoreevent( "destroyed_motion_sensor", attacker, self.owner, weapon );
        }
    }
    
    playsoundatposition( "wpn_sensor_nade_explo", self.origin );
    self delete();
}

// Namespace threat_detector/threat_detector
// Params 1
// Checksum 0x74e475c0, Offset: 0x768
// Size: 0x38a
function watchthreatdetectordamage( watcher )
{
    self endon( #"death" );
    self endon( #"hacked" );
    self setcandamage( 1 );
    damagemax = 1;
    
    if ( !self util::ishacked() )
    {
        self.damagetaken = 0;
    }
    
    while ( true )
    {
        self.maxhealth = 100000;
        self.health = self.maxhealth;
        waitresult = self waittill( "damage" );
        attacker = waitresult.attacker;
        weapon = waitresult.weapon;
        type = waitresult.mod;
        damage = waitresult.amount;
        
        if ( !isdefined( attacker ) || !isplayer( attacker ) )
        {
            continue;
        }
        
        if ( level.teambased && isplayer( attacker ) )
        {
            if ( !level.hardcoremode && self.owner.team == attacker.pers[ "team" ] && self.owner != attacker )
            {
                continue;
            }
        }
        
        if ( watcher.stuntime > 0 && weapon.dostun )
        {
            self thread weaponobjects::stunstart( watcher, watcher.stuntime );
        }
        
        if ( weapon.dodamagefeedback )
        {
            if ( level.teambased && self.owner.team != attacker.team )
            {
                if ( damagefeedback::dodamagefeedback( weapon, attacker ) )
                {
                    attacker damagefeedback::update();
                }
            }
            else if ( !level.teambased && self.owner != attacker )
            {
                if ( damagefeedback::dodamagefeedback( weapon, attacker ) )
                {
                    attacker damagefeedback::update();
                }
            }
        }
        
        if ( type == "MOD_MELEE" || weapon.isemp )
        {
            self.damagetaken = damagemax;
        }
        else
        {
            self.damagetaken += damage;
        }
        
        if ( self.damagetaken >= damagemax )
        {
            watcher thread weaponobjects::waitanddetonate( self, 0, attacker, weapon );
            return;
        }
    }
}

