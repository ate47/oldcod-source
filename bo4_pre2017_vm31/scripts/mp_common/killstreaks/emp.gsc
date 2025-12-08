#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/hostmigration_shared;
#using scripts/core_common/killstreaks_shared;
#using scripts/core_common/popups_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/struct;
#using scripts/core_common/turret_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/vehicle_shared;
#using scripts/core_common/weapons/weaponobjects;
#using scripts/mp_common/gametypes/hostmigration;
#using scripts/mp_common/killstreaks/airsupport;
#using scripts/mp_common/killstreaks/emp;
#using scripts/mp_common/killstreaks/killstreak_bundles;
#using scripts/mp_common/killstreaks/killstreak_hacking;
#using scripts/mp_common/killstreaks/killstreakrules;
#using scripts/mp_common/killstreaks/killstreaks;
#using scripts/mp_common/killstreaks/placeables;
#using scripts/mp_common/teams/teams;
#using scripts/mp_common/util;

#namespace emp;

#using_animtree( "mp_emp_power_core" );

// Namespace emp/emp
// Params 0
// Checksum 0x5d5a1b59, Offset: 0x758
// Size: 0x2ec
function init()
{
    bundle = struct::get_script_bundle( "killstreak", "killstreak_emp" );
    level.empkillstreakbundle = bundle;
    level.activeplayeremps = [];
    level.activeemps = [];
    
    foreach ( team in level.teams )
    {
        level.activeemps[ team ] = 0;
    }
    
    level.enemyempactivefunc = &enemyempactive;
    level thread emptracker();
    killstreaks::register( "emp", "emp", "killstreak_emp", "emp_used", &activateemp );
    killstreaks::register_strings( "emp", &"KILLSTREAK_EARNED_EMP", &"KILLSTREAK_EMP_NOT_AVAILABLE", &"KILLSTREAK_EMP_INBOUND", undefined, &"KILLSTREAK_EMP_HACKED", 0 );
    killstreaks::register_dialog( "emp", "mpl_killstreak_emp_activate", "empDialogBundle", undefined, "friendlyEmp", "enemyEmp", "enemyEmpMultiple", "friendlyEmpHacked", "enemyEmpHacked", "requestEmp", "threatEmp" );
    clientfield::register( "scriptmover", "emp_turret_init", 1, 1, "int" );
    clientfield::register( "vehicle", "emp_turret_deploy", 1, 1, "int" );
    spinanim = %o_turret_emp_core_spin;
    deployanim = %o_turret_emp_core_deploy;
    callback::on_spawned( &onplayerspawned );
    callback::on_connect( &onplayerconnect );
    vehicle::add_main_callback( "emp_turret", &initturretvehicle );
}

// Namespace emp/emp
// Params 0
// Checksum 0x9bad4136, Offset: 0xa50
// Size: 0xec
function initturretvehicle()
{
    turretvehicle = self;
    turretvehicle killstreaks::setup_health( "emp" );
    turretvehicle.damagetaken = 0;
    turretvehicle.health = turretvehicle.maxhealth;
    turretvehicle clientfield::set( "enemyvehicle", 1 );
    turretvehicle.soundmod = "drone_land";
    turretvehicle.overridevehicledamage = &onturretdamage;
    turretvehicle.overridevehiclekilled = &onturretdeath;
    target_set( turretvehicle, ( 0, 0, 36 ) );
}

// Namespace emp/emp
// Params 0
// Checksum 0x948f3b5, Offset: 0xb48
// Size: 0x24
function onplayerspawned()
{
    self endon( #"disconnect" );
    self updateemp();
}

// Namespace emp/emp
// Params 0
// Checksum 0xaeb0753e, Offset: 0xb78
// Size: 0x3e
function onplayerconnect()
{
    self.entnum = self getentitynumber();
    level.activeplayeremps[ self.entnum ] = 0;
}

// Namespace emp/emp
// Params 0
// Checksum 0x4062b700, Offset: 0xbc0
// Size: 0x254, Type: bool
function activateemp()
{
    player = self;
    killstreakid = player killstreakrules::killstreakstart( "emp", player.team, 0, 0 );
    
    if ( killstreakid == -1 )
    {
        return false;
    }
    
    bundle = level.empkillstreakbundle;
    empbase = player placeables::spawnplaceable( "emp", killstreakid, &onplaceemp, &oncancelplacement, undefined, &onshutdown, undefined, undefined, "wpn_t7_turret_emp_core", "wpn_t7_turret_emp_core_yellow", "wpn_t7_turret_emp_core_red", 1, "", undefined, undefined, 0, bundle.ksplaceablehint, bundle.ksplaceableinvalidlocationhint );
    empbase thread util::ghost_wait_show_to_player( player );
    empbase.othermodel thread util::ghost_wait_show_to_others( player );
    empbase clientfield::set( "emp_turret_init", 1 );
    empbase.othermodel clientfield::set( "emp_turret_init", 1 );
    event = empbase waittill( "placed", "cancelled", "death", "disconnect" );
    
    if ( event._notify != "placed" )
    {
        self.pers[ "lpSystem" ].tokens++;
        self clientfield::set_player_uimodel( "hudItems.lplevel.unlockTokens", self.pers[ "lpSystem" ].tokens );
        return false;
    }
    
    return true;
}

// Namespace emp/emp
// Params 1
// Checksum 0x604d3a56, Offset: 0xe20
// Size: 0x34c
function onplaceemp( emp )
{
    player = self;
    assert( isplayer( player ) );
    assert( !isdefined( emp.vehicle ) );
    emp.vehicle = spawnvehicle( "emp_turret", emp.origin, emp.angles );
    emp.vehicle thread util::ghost_wait_show( 0.05 );
    emp.vehicle.killstreaktype = emp.killstreaktype;
    emp.vehicle.owner = player;
    emp.vehicle setowner( player );
    emp.vehicle.ownerentnum = player.entnum;
    emp.vehicle.parentstruct = emp;
    player.emptime = gettime();
    player killstreaks::play_killstreak_start_dialog( "emp", player.pers[ "team" ], emp.killstreakid );
    player addweaponstat( getweapon( "emp" ), "used", 1 );
    level thread popups::displaykillstreakteammessagetoall( "emp", player );
    emp.vehicle killstreaks::configure_team( "emp", emp.killstreakid, player );
    emp.vehicle killstreak_hacking::enable_hacking( "emp", &hackedcallbackpre, &hackedcallbackpost );
    emp thread killstreaks::waitfortimeout( "emp", 60000, &on_timeout, "death" );
    
    if ( issentient( emp.vehicle ) == 0 )
    {
        emp.vehicle makesentient();
    }
    
    emp.vehicle vehicle::disconnect_paths( 0, 0 );
    player thread deployempturret( emp );
}

// Namespace emp/emp
// Params 1
// Checksum 0xf1c32ab2, Offset: 0x1178
// Size: 0x1e4
function deployempturret( emp )
{
    player = self;
    player endon( #"disconnect" );
    player endon( #"joined_team" );
    player endon( #"joined_spectators" );
    emp endon( #"death" );
    emp.vehicle useanimtree( #animtree );
    emp.vehicle setanim( %o_turret_emp_core_deploy, 1 );
    length = getanimlength( %o_turret_emp_core_deploy );
    emp.vehicle clientfield::set( "emp_turret_deploy", 1 );
    wait length * 0.75;
    emp.vehicle thread playempfx();
    emp.vehicle playsound( "mpl_emp_turret_activate" );
    emp.vehicle setanim( %o_turret_emp_core_spin, 1 );
    player thread emp_jamenemies( emp, 0 );
    wait length * 0.25;
    emp.vehicle clearanim( %o_turret_emp_core_deploy, 0 );
}

// Namespace emp/emp
// Params 1
// Checksum 0x17c4325f, Offset: 0x1368
// Size: 0x84
function hackedcallbackpre( hacker )
{
    emp_vehicle = self;
    emp_vehicle clientfield::set( "enemyvehicle", 2 );
    emp_vehicle.parentstruct killstreaks::configure_team( "emp", emp_vehicle.parentstruct.killstreakid, hacker, undefined, undefined, undefined, 1 );
}

// Namespace emp/emp
// Params 1
// Checksum 0x75d843f7, Offset: 0x13f8
// Size: 0x44
function hackedcallbackpost( hacker )
{
    emp_vehicle = self;
    hacker thread emp_jamenemies( emp_vehicle.parentstruct, 1 );
}

// Namespace emp/emp
// Params 1
// Checksum 0x65636012, Offset: 0x1448
// Size: 0x4c
function doneempfx( fxtagorigin )
{
    playfx( "killstreaks/fx_emp_exp_death", fxtagorigin );
    playsoundatposition( "mpl_emp_turret_deactivate", fxtagorigin );
}

// Namespace emp/emp
// Params 0
// Checksum 0x82a577e1, Offset: 0x14a0
// Size: 0x3a
function playempfx()
{
    emp_vehicle = self;
    emp_vehicle playloopsound( "mpl_emp_turret_loop_close" );
    waitframe( 1 );
}

// Namespace emp/emp
// Params 0
// Checksum 0x72ac145c, Offset: 0x14e8
// Size: 0x84
function on_timeout()
{
    emp = self;
    
    if ( isdefined( emp.vehicle ) )
    {
        fxtagorigin = emp.vehicle gettagorigin( "tag_fx" );
        doneempfx( fxtagorigin );
    }
    
    shutdownemp( emp );
}

// Namespace emp/emp
// Params 1
// Checksum 0x31edcb3e, Offset: 0x1578
// Size: 0x4c
function oncancelplacement( emp )
{
    stopemp( emp.team, emp.ownerentnum, emp.originalteam, emp.killstreakid );
}

// Namespace emp/emp
// Params 15
// Checksum 0xb34894ce, Offset: 0x15d0
// Size: 0x168
function onturretdamage( einflictor, attacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal )
{
    empdamage = 0;
    idamage = self killstreaks::ondamageperweapon( "emp", attacker, idamage, idflags, smeansofdeath, weapon, self.maxhealth, undefined, self.maxhealth * 0.4, undefined, empdamage, undefined, 1, 1 );
    self.damagetaken += idamage;
    
    if ( self.damagetaken > self.maxhealth && !isdefined( self.will_die ) )
    {
        self.will_die = 1;
        self thread ondeathafterframeend( attacker, weapon );
    }
    
    return idamage;
}

// Namespace emp/emp
// Params 8
// Checksum 0xbc3c95d1, Offset: 0x1740
// Size: 0x64
function onturretdeath( inflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime )
{
    self ondeath( attacker, weapon );
}

// Namespace emp/emp
// Params 2
// Checksum 0x5d60819b, Offset: 0x17b0
// Size: 0x3c
function ondeathafterframeend( attacker, weapon )
{
    waittillframeend();
    
    if ( isdefined( self ) )
    {
        self ondeath( attacker, weapon );
    }
}

// Namespace emp/emp
// Params 2
// Checksum 0x4556ec1b, Offset: 0x17f8
// Size: 0x22c
function ondeath( attacker, weapon )
{
    emp_vehicle = self;
    fxtagorigin = self gettagorigin( "tag_fx" );
    doneempfx( fxtagorigin );
    
    if ( !isdefined( emp_vehicle.owner ) || isdefined( attacker ) && isplayer( attacker ) && emp_vehicle.owner util::isenemyplayer( attacker ) )
    {
        attacker challenges::destroyscorestreak( weapon, 0, 1, 0 );
        attacker challenges::destroynonairscorestreak_poststatslock( weapon );
        attacker addplayerstat( "destroy_turret", 1 );
        attacker addweaponstat( weapon, "destroy_turret", 1 );
        scoreevents::processscoreevent( "destroyed_emp", attacker, emp_vehicle.owner, weapon );
        luinotifyevent( &"player_callout", 2, &"KILLSTREAK_DESTROYED_EMP", attacker.entnum );
    }
    
    if ( isdefined( attacker ) && isdefined( emp_vehicle.owner ) && attacker != emp_vehicle.owner )
    {
        emp_vehicle killstreaks::play_destroyed_dialog_on_owner( "emp", emp_vehicle.parentstruct.killstreakid );
    }
    
    shutdownemp( emp_vehicle.parentstruct );
}

// Namespace emp/emp
// Params 1
// Checksum 0x1c06c2f7, Offset: 0x1a30
// Size: 0x24
function onshutdown( emp )
{
    shutdownemp( emp );
}

// Namespace emp/emp
// Params 1
// Checksum 0x9ff03d4b, Offset: 0x1a60
// Size: 0x134
function shutdownemp( emp )
{
    if ( !isdefined( emp ) )
    {
        return;
    }
    
    if ( isdefined( emp.already_shutdown ) )
    {
        return;
    }
    
    emp.already_shutdown = 1;
    
    if ( isdefined( emp.vehicle ) )
    {
        emp.vehicle clientfield::set( "emp_turret_deploy", 0 );
    }
    
    stopemp( emp.team, emp.ownerentnum, emp.originalteam, emp.killstreakid );
    
    if ( isdefined( emp.othermodel ) )
    {
        emp.othermodel delete();
    }
    
    if ( isdefined( emp.vehicle ) )
    {
        emp.vehicle delete();
    }
    
    emp delete();
}

// Namespace emp/emp
// Params 4
// Checksum 0xa104e9a0, Offset: 0x1ba0
// Size: 0x54
function stopemp( currentteam, currentownerentnum, originalteam, killstreakid )
{
    stopempeffect( currentteam, currentownerentnum );
    stopemprule( originalteam, killstreakid );
}

// Namespace emp/emp
// Params 2
// Checksum 0x60b1858f, Offset: 0x1c00
// Size: 0x4c
function stopempeffect( team, ownerentnum )
{
    level.activeemps[ team ] = 0;
    level.activeplayeremps[ ownerentnum ] = 0;
    level notify( #"emp_updated" );
}

// Namespace emp/emp
// Params 2
// Checksum 0xce5fd6ce, Offset: 0x1c58
// Size: 0x34
function stopemprule( killstreakoriginalteam, killstreakid )
{
    killstreakrules::killstreakstop( "emp", killstreakoriginalteam, killstreakid );
}

// Namespace emp/emp
// Params 0
// Checksum 0xa7a14d43, Offset: 0x1c98
// Size: 0x1c
function hasactiveemp()
{
    return level.activeplayeremps[ self.entnum ];
}

// Namespace emp/emp
// Params 1
// Checksum 0xd572060d, Offset: 0x1cc0
// Size: 0x20, Type: bool
function teamhasactiveemp( team )
{
    return level.activeemps[ team ] > 0;
}

// Namespace emp/emp
// Params 0
// Checksum 0x708ada44, Offset: 0x1ce8
// Size: 0x16c, Type: bool
function enemyempactive()
{
    if ( level.teambased )
    {
        foreach ( team in level.teams )
        {
            if ( team != self.team && teamhasactiveemp( team ) )
            {
                return true;
            }
        }
    }
    else
    {
        enemies = self teams::getenemyplayers();
        
        foreach ( player in enemies )
        {
            if ( player hasactiveemp() )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace emp/emp
// Params 0
// Checksum 0x9c03abf, Offset: 0x1e60
// Size: 0xb4
function enemyempowner()
{
    enemies = self teams::getenemyplayers();
    
    foreach ( player in enemies )
    {
        if ( player hasactiveemp() )
        {
            return player;
        }
    }
    
    return undefined;
}

// Namespace emp/emp
// Params 2
// Checksum 0xa76bb4f7, Offset: 0x1f20
// Size: 0x22c
function emp_jamenemies( empent, hacked )
{
    level endon( #"game_ended" );
    self endon( #"killstreak_hacked" );
    
    if ( level.teambased )
    {
        if ( hacked )
        {
            level.activeemps[ empent.originalteam ] = 0;
        }
        
        level.activeemps[ self.team ] = 1;
    }
    
    if ( hacked )
    {
        level.activeplayeremps[ empent.originalownerentnum ] = 0;
    }
    
    level.activeplayeremps[ self.entnum ] = 1;
    level notify( #"emp_updated" );
    level notify( #"emp_deployed" );
    visionsetnaked( "flash_grenade", 1.5 );
    wait 0.1;
    visionsetnaked( "flash_grenade", 0 );
    visionsetnaked( getdvarstring( "mapname" ), 5 );
    radius = isdefined( level.empkillstreakbundle.ksdamageradius ) ? level.empkillstreakbundle.ksdamageradius : 750;
    empkillstreakweapon = getweapon( "emp" );
    empkillstreakweapon.isempkillstreak = 1;
    level killstreaks::destroyotherteamsactivevehicles( self, empkillstreakweapon, radius );
    level killstreaks::destroyotherteamsequipment( self, empkillstreakweapon, radius );
    level weaponobjects::destroy_other_teams_supplemental_watcher_objects( self, empkillstreakweapon, radius );
}

// Namespace emp/emp
// Params 0
// Checksum 0xcd2de95e, Offset: 0x2158
// Size: 0xbe
function emptracker()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( "emp_updated" );
        
        foreach ( player in level.players )
        {
            player updateemp();
        }
    }
}

// Namespace emp/emp
// Params 0
// Checksum 0x7d9560bc, Offset: 0x2220
// Size: 0xb4
function updateemp()
{
    player = self;
    enemy_emp_active = player enemyempactive();
    player setempjammed( enemy_emp_active );
    emped = player isempjammed();
    player clientfield::set_to_player( "empd_monitor_distance", emped );
    
    if ( emped )
    {
        player notify( #"emp_jammed" );
    }
}

