#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/damagefeedback_shared;
#using scripts/core_common/hostmigration_shared;
#using scripts/core_common/hud_message_shared;
#using scripts/core_common/hud_shared;
#using scripts/core_common/hud_util_shared;
#using scripts/core_common/influencers_shared;
#using scripts/core_common/killstreaks_shared;
#using scripts/core_common/popups_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/values_shared;
#using scripts/core_common/weapons/weaponobjects;
#using scripts/core_common/weapons/weapons;
#using scripts/core_common/weapons_shared;
#using scripts/mp_common/gametypes/battlechatter;
#using scripts/mp_common/gametypes/globallogic_audio;
#using scripts/mp_common/gametypes/globallogic_score;
#using scripts/mp_common/gametypes/globallogic_utils;
#using scripts/mp_common/gametypes/hostmigration;
#using scripts/mp_common/gametypes/hud_message;
#using scripts/mp_common/gametypes/loadout;
#using scripts/mp_common/killstreaks/ai_tank;
#using scripts/mp_common/killstreaks/airsupport;
#using scripts/mp_common/killstreaks/ammo_station;
#using scripts/mp_common/killstreaks/armor_station;
#using scripts/mp_common/killstreaks/combat_robot;
#using scripts/mp_common/killstreaks/counteruav;
#using scripts/mp_common/killstreaks/dart;
#using scripts/mp_common/killstreaks/dogs;
#using scripts/mp_common/killstreaks/drone_strike;
#using scripts/mp_common/killstreaks/emp;
#using scripts/mp_common/killstreaks/flak_drone;
#using scripts/mp_common/killstreaks/helicopter;
#using scripts/mp_common/killstreaks/helicopter_gunner;
#using scripts/mp_common/killstreaks/killstreak_bundles;
#using scripts/mp_common/killstreaks/killstreak_detect;
#using scripts/mp_common/killstreaks/killstreak_hacking;
#using scripts/mp_common/killstreaks/killstreakrules;
#using scripts/mp_common/killstreaks/killstreaks;
#using scripts/mp_common/killstreaks/microwave_turret;
#using scripts/mp_common/killstreaks/mini_turret;
#using scripts/mp_common/killstreaks/planemortar;
#using scripts/mp_common/killstreaks/qrdrone;
#using scripts/mp_common/killstreaks/raps;
#using scripts/mp_common/killstreaks/rcbomb;
#using scripts/mp_common/killstreaks/remote_weapons;
#using scripts/mp_common/killstreaks/remotemissile;
#using scripts/mp_common/killstreaks/satellite;
#using scripts/mp_common/killstreaks/sentinel;
#using scripts/mp_common/killstreaks/supplydrop;
#using scripts/mp_common/killstreaks/turret;
#using scripts/mp_common/killstreaks/uav;
#using scripts/mp_common/spawnbeacon;
#using scripts/mp_common/util;

#namespace killstreaks;

// Namespace killstreaks/killstreaks
// Params 0, eflags: 0x2
// Checksum 0x2538782a, Offset: 0x1208
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "killstreaks", &__init__, undefined, undefined );
}

// Namespace killstreaks/killstreaks
// Params 0
// Checksum 0x35d35173, Offset: 0x1248
// Size: 0x94
function __init__()
{
    level.killstreaks = [];
    level.killstreakweapons = [];
    level.droplocations = [];
    level.zoffsetcounter = 0;
    clientfield::register( "vehicle", "timeout_beep", 1, 2, "int" );
    callback::on_start_gametype( &init );
}

// Namespace killstreaks/killstreaks
// Params 0
// Checksum 0x7257109c, Offset: 0x12e8
// Size: 0x41c
function init()
{
    /#
        level.killstreak_init_start_time = getmillisecondsraw();
        thread debug_ricochet_protection();
    #/
    
    if ( getdvarstring( "scr_allow_killstreak_building" ) == "" )
    {
        setdvar( "scr_allow_killstreak_building", "0" );
    }
    
    level.menureferenceforkillstreak = [];
    level.numkillstreakreservedobjectives = 0;
    level.killstreakcounter = 0;
    level.play_killstreak_firewall_being_hacked_dialog = &play_killstreak_firewall_being_hacked_dialog;
    level.play_killstreak_firewall_hacked_dialog = &play_killstreak_firewall_hacked_dialog;
    level.play_killstreak_being_hacked_dialog = &play_killstreak_being_hacked_dialog;
    level.play_killstreak_hacked_dialog = &play_killstreak_hacked_dialog;
    
    if ( !isdefined( level.roundstartkillstreakdelay ) )
    {
        level.roundstartkillstreakdelay = 0;
    }
    
    level.iskillstreakweapon = &is_killstreak_weapon;
    level.killstreakcorebundle = struct::get_script_bundle( "killstreak", "killstreak_core" );
    remote_weapons::init();
    ai_tank::init();
    airsupport::init();
    ammo_station::init();
    armor_station::init();
    combat_robot::init();
    counteruav::init();
    dart::init();
    drone_strike::init();
    emp::init();
    flak_drone::init();
    helicopter::init();
    helicopter_gunner::init();
    killstreakrules::init();
    microwave_turret::init();
    mini_turret::init();
    planemortar::init();
    qrdrone::init();
    raps_mp::init();
    rcbomb::init();
    remotemissile::init();
    satellite::init();
    sentinel::init();
    turret::init();
    uav::init();
    spawn_beacon::init();
    supplydrop::init();
    
    /#
        level.killstreak_init_end_time = getmillisecondsraw();
        elapsed_time = level.killstreak_init_end_time - level.killstreak_init_start_time;
        println( "Total killstreaks init time: " + elapsed_time + " ms" );
    #/
    
    callback::on_spawned( &on_player_spawned );
    callback::on_joined_team( &on_joined_team );
    callback::on_connect( &on_player_connect );
    
    /#
        level thread killstreak_debug_think();
    #/
}

// Namespace killstreaks/killstreaks
// Params 10
// Checksum 0xc5d5a9d4, Offset: 0x1710
// Size: 0x5bc
function register( killstreaktype, killstreakweaponname, killstreakmenuname, killstreakusagekey, killstreakusefunction, killstreakdelaystreak, weaponholdallowed, killstreakstatsname, registerdvars, registerinventory )
{
    if ( !isdefined( weaponholdallowed ) )
    {
        weaponholdallowed = 0;
    }
    
    if ( !isdefined( killstreakstatsname ) )
    {
        killstreakstatsname = undefined;
    }
    
    if ( !isdefined( registerdvars ) )
    {
        registerdvars = 1;
    }
    
    if ( !isdefined( registerinventory ) )
    {
        registerinventory = 1;
    }
    
    assert( isdefined( killstreaktype ), "Can not register a killstreak without a valid type name." );
    assert( !isdefined( level.killstreaks[ killstreaktype ] ), "Killstreak " + killstreaktype + " already registered" );
    assert( isdefined( killstreakusefunction ), "No use function defined for killstreak " + killstreaktype );
    level.killstreaks[ killstreaktype ] = spawnstruct();
    killstreakindex = getitemindexfromref( killstreakmenuname );
    killstreakinfo = getunlockableiteminfofromindex( killstreakindex );
    killstreakcost = 0;
    killstreakimage = "blacktransparent";
    
    if ( isdefined( killstreakinfo ) )
    {
        killstreakcost = killstreakinfo.momentum;
        killstreakimage = killstreakinfo.image;
    }
    
    level.killstreaks[ killstreaktype ].killstreaklevel = 0;
    level.killstreaks[ killstreaktype ].momentumcost = killstreakcost;
    level.killstreaks[ killstreaktype ].iconmaterial = killstreakimage;
    level.killstreaks[ killstreaktype ].quantity = 0;
    level.killstreaks[ killstreaktype ].usagekey = killstreakusagekey;
    level.killstreaks[ killstreaktype ].usefunction = killstreakusefunction;
    level.killstreaks[ killstreaktype ].menuname = killstreakmenuname;
    level.killstreaks[ killstreaktype ].delaystreak = killstreakdelaystreak;
    level.killstreaks[ killstreaktype ].allowassists = 0;
    level.killstreaks[ killstreaktype ].overrideentitycameraindemo = 0;
    level.killstreaks[ killstreaktype ].teamkillpenaltyscale = 1;
    level.killstreaks[ killstreaktype ].uiname = "";
    
    /#
        if ( isdefined( killstreakinfo ) )
        {
            level.killstreaks[ killstreaktype ].uiname = killstreakinfo.displayname;
        }
        
        if ( level.killstreaks[ killstreaktype ].uiname == "" )
        {
            level.killstreaks[ killstreaktype ].uiname = killstreakmenuname;
        }
    #/
    
    if ( isdefined( killstreakweaponname ) )
    {
        killstreakweapon = getweapon( killstreakweaponname );
        assert( killstreakweapon != level.weaponnone );
        assert( !isdefined( level.killstreakweapons[ killstreakweapon ] ), "Can not have a weapon associated with multiple killstreaks." );
        level.killstreaks[ killstreaktype ].weapon = killstreakweapon;
        level.killstreakweapons[ killstreakweapon ] = killstreaktype;
    }
    
    if ( isdefined( killstreakstatsname ) )
    {
        level.killstreaks[ killstreaktype ].killstreakstatsname = killstreakstatsname;
    }
    
    level.killstreaks[ killstreaktype ].weaponholdallowed = weaponholdallowed;
    
    if ( isdefined( registerinventory ) && registerinventory )
    {
        level.menureferenceforkillstreak[ killstreakmenuname ] = killstreaktype;
        killstreak_bundles::register_killstreak_bundle( killstreaktype );
    }
    
    if ( isdefined( registerinventory ) && registerinventory )
    {
        if ( isdefined( registerdvars ) && registerdvars )
        {
            register_dev_dvars( killstreaktype );
        }
        
        register( "inventory_" + killstreaktype, "inventory_" + killstreakweaponname, killstreakmenuname, killstreakusagekey, killstreakusefunction, killstreakdelaystreak, weaponholdallowed, killstreakstatsname, registerdvars, 0 );
    }
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0x875b26cc, Offset: 0x1cd8
// Size: 0x1e, Type: bool
function is_registered( killstreaktype )
{
    return isdefined( level.killstreaks[ killstreaktype ] );
}

// Namespace killstreaks/killstreaks
// Params 8
// Checksum 0xe688700c, Offset: 0x1d00
// Size: 0x1cc
function register_strings( killstreaktype, receivedtext, notusabletext, inboundtext, inboundnearplayertext, hackedtext, utilizesairspace, isinventory )
{
    if ( !isdefined( utilizesairspace ) )
    {
        utilizesairspace = 1;
    }
    
    if ( !isdefined( isinventory ) )
    {
        isinventory = 0;
    }
    
    assert( isdefined( killstreaktype ), "Can not register a killstreak without a valid type name." );
    assert( isdefined( level.killstreaks[ killstreaktype ] ), "Killstreak needs to be registered before calling register_strings." );
    level.killstreaks[ killstreaktype ].receivedtext = receivedtext;
    level.killstreaks[ killstreaktype ].notavailabletext = notusabletext;
    level.killstreaks[ killstreaktype ].inboundtext = inboundtext;
    level.killstreaks[ killstreaktype ].inboundnearplayertext = inboundnearplayertext;
    level.killstreaks[ killstreaktype ].hackedtext = hackedtext;
    level.killstreaks[ killstreaktype ].utilizesairspace = utilizesairspace;
    
    if ( !( isdefined( isinventory ) && isinventory ) )
    {
        register_strings( "inventory_" + killstreaktype, receivedtext, notusabletext, inboundtext, inboundnearplayertext, hackedtext, utilizesairspace, 1 );
    }
}

// Namespace killstreaks/killstreaks
// Params 12
// Checksum 0x48e75ac5, Offset: 0x1ed8
// Size: 0x3bc
function register_dialog( killstreaktype, informdialog, taacomdialogbundlekey, pilotdialogarraykey, startdialogkey, enemystartdialogkey, enemystartmultipledialogkey, hackeddialogkey, hackedstartdialogkey, requestdialogkey, threatdialogkey, isinventory )
{
    assert( isdefined( killstreaktype ), "Can not register a killstreak without a valid type name." );
    assert( isdefined( level.killstreaks[ killstreaktype ] ), "Killstreak needs to be registered before calling register_dialog." );
    level.killstreaks[ killstreaktype ].informdialog = informdialog;
    level.killstreaks[ killstreaktype ].taacomdialogbundlekey = taacomdialogbundlekey;
    level.killstreaks[ killstreaktype ].startdialogkey = startdialogkey;
    level.killstreaks[ killstreaktype ].enemystartdialogkey = enemystartdialogkey;
    level.killstreaks[ killstreaktype ].enemystartmultipledialogkey = enemystartmultipledialogkey;
    level.killstreaks[ killstreaktype ].hackeddialogkey = hackeddialogkey;
    level.killstreaks[ killstreaktype ].hackedstartdialogkey = hackedstartdialogkey;
    level.killstreaks[ killstreaktype ].requestdialogkey = requestdialogkey;
    level.killstreaks[ killstreaktype ].threatdialogkey = threatdialogkey;
    
    if ( isdefined( pilotdialogarraykey ) )
    {
        taacombundles = struct::get_script_bundles( "mpdialog_taacom" );
        
        foreach ( bundle in taacombundles )
        {
            if ( !isdefined( bundle.pilotbundles ) )
            {
                bundle.pilotbundles = [];
            }
            
            bundle.pilotbundles[ killstreaktype ] = [];
            i = 0;
            field = pilotdialogarraykey + i;
            
            for ( fieldvalue = bundle.( field ); isdefined( fieldvalue ) ; fieldvalue = bundle.( field ) )
            {
                bundle.pilotbundles[ killstreaktype ][ i ] = fieldvalue;
                i++;
                field = pilotdialogarraykey + i;
            }
        }
        
        level.tacombundles = taacombundles;
    }
    
    if ( !( isdefined( isinventory ) && isinventory ) )
    {
        register_dialog( "inventory_" + killstreaktype, informdialog, taacomdialogbundlekey, pilotdialogarraykey, startdialogkey, enemystartdialogkey, enemystartmultipledialogkey, hackeddialogkey, hackedstartdialogkey, requestdialogkey, threatdialogkey, 1 );
    }
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0xac53f51c, Offset: 0x22a0
// Size: 0x1c
function get_mpdialog_tacom_bundle( name )
{
    return level.tacombundles[ name ];
}

// Namespace killstreaks/killstreaks
// Params 3
// Checksum 0x4aef3a12, Offset: 0x22c8
// Size: 0x1c4
function register_alt_weapon( killstreaktype, weaponname, isinventory )
{
    assert( isdefined( killstreaktype ), "Can not register a killstreak without a valid type name." );
    assert( isdefined( level.killstreaks[ killstreaktype ] ), "Killstreak needs to be registered before calling register_alt_weapon." );
    weapon = getweapon( weaponname );
    
    if ( weapon == level.weaponnone )
    {
        return;
    }
    
    if ( level.killstreaks[ killstreaktype ].weapon == weapon )
    {
        return;
    }
    
    if ( !isdefined( level.killstreaks[ killstreaktype ].altweapons ) )
    {
        level.killstreaks[ killstreaktype ].altweapons = [];
    }
    
    if ( !isdefined( level.killstreakweapons[ weapon ] ) )
    {
        level.killstreakweapons[ weapon ] = killstreaktype;
    }
    
    level.killstreaks[ killstreaktype ].altweapons[ level.killstreaks[ killstreaktype ].altweapons.size ] = weapon;
    
    if ( !( isdefined( isinventory ) && isinventory ) )
    {
        register_alt_weapon( "inventory_" + killstreaktype, weaponname, 1 );
    }
}

// Namespace killstreaks/killstreaks
// Params 3
// Checksum 0xd22d12ed, Offset: 0x2498
// Size: 0x1ac
function register_remote_override_weapon( killstreaktype, weaponname, isinventory )
{
    assert( isdefined( killstreaktype ), "Can not register a killstreak without a valid type name." );
    assert( isdefined( level.killstreaks[ killstreaktype ] ), "Killstreak needs to be registered before calling register_remote_override_weapon." );
    weapon = getweapon( weaponname );
    
    if ( level.killstreaks[ killstreaktype ].weapon == weapon )
    {
        return;
    }
    
    if ( !isdefined( level.killstreaks[ killstreaktype ].remoteoverrideweapons ) )
    {
        level.killstreaks[ killstreaktype ].remoteoverrideweapons = [];
    }
    
    if ( !isdefined( level.killstreakweapons[ weapon ] ) )
    {
        level.killstreakweapons[ weapon ] = killstreaktype;
    }
    
    level.killstreaks[ killstreaktype ].remoteoverrideweapons[ level.killstreaks[ killstreaktype ].remoteoverrideweapons.size ] = weapon;
    
    if ( !( isdefined( isinventory ) && isinventory ) )
    {
        register_remote_override_weapon( "inventory_" + killstreaktype, weaponname, 1 );
    }
}

// Namespace killstreaks/killstreaks
// Params 2
// Checksum 0xca81e99d, Offset: 0x2650
// Size: 0xa8, Type: bool
function is_remote_override_weapon( killstreaktype, weapon )
{
    if ( isdefined( level.killstreaks[ killstreaktype ].remoteoverrideweapons ) )
    {
        for ( i = 0; i < level.killstreaks[ killstreaktype ].remoteoverrideweapons.size ; i++ )
        {
            if ( level.killstreaks[ killstreaktype ].remoteoverrideweapons[ i ] == weapon )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0x3fb5f975, Offset: 0x2700
// Size: 0x13c
function register_dev_dvars( killstreaktype )
{
    /#
        assert( isdefined( killstreaktype ), "Can not register a killstreak without a valid type name." );
        assert( isdefined( level.killstreaks[ killstreaktype ] ), "Killstreak needs to be registered before calling register_dev_dvar." );
        level.killstreaks[ killstreaktype ].devdvar = "scr_" + killstreaktype + "_give";
        level.killstreaks[ killstreaktype ].devenemydvar = "scr_" + killstreaktype + "_giveenemy";
        level.killstreaks[ killstreaktype ].devtimeoutdvar = "scr_" + killstreaktype + "_notimeout";
        setdvar( level.killstreaks[ killstreaktype ].devtimeoutdvar, 0 );
        level thread register_devgui( killstreaktype );
    #/
}

/#

    // Namespace killstreaks/killstreaks
    // Params 1
    // Checksum 0xe216dc69, Offset: 0x2848
    // Size: 0xc4, Type: dev
    function register_dev_debug_dvar( killstreaktype )
    {
        assert( isdefined( killstreaktype ), "Can not register a killstreak without a valid type name." );
        assert( isdefined( level.killstreaks[ killstreaktype ] ), "Killstreak needs to be registered before calling register_dev_dvar." );
        level.killstreaks[ killstreaktype ].devdebugdvar = "scr_" + killstreaktype + "_debug";
        devgui_scorestreak_command_debugdvar( killstreaktype, level.killstreaks[ killstreaktype ].devdebugdvar );
    }

    // Namespace killstreaks/killstreaks
    // Params 1
    // Checksum 0xd05d8b86, Offset: 0x2918
    // Size: 0x16c, Type: dev
    function register_devgui( killstreaktype )
    {
        level endon( #"game_ended" );
        wait randomintrange( 2, 20 ) * 0.05;
        give_type_all = "Give";
        give_type_enemy = "Give Enemy";
        
        if ( isdefined( level.killstreaks[ killstreaktype ].devdvar ) )
        {
            devgui_scorestreak_command_givedvar( killstreaktype, give_type_all, level.killstreaks[ killstreaktype ].devdvar );
        }
        
        if ( isdefined( level.killstreaks[ killstreaktype ].devenemydvar ) )
        {
            devgui_scorestreak_command_givedvar( killstreaktype, give_type_enemy, level.killstreaks[ killstreaktype ].devenemydvar );
        }
        
        if ( isdefined( level.killstreaks[ killstreaktype ].devtimeoutdvar ) )
        {
            devgui_scorestreak_command_timeoutdvar( killstreaktype, level.killstreaks[ killstreaktype ].devtimeoutdvar );
        }
    }

    // Namespace killstreaks/killstreaks
    // Params 3
    // Checksum 0x64ef524e, Offset: 0x2a90
    // Size: 0x54, Type: dev
    function devgui_scorestreak_command_givedvar( killstreaktype, give_type, dvar )
    {
        devgui_scorestreak_command( killstreaktype, give_type, "set " + dvar + " 1" );
    }

    // Namespace killstreaks/killstreaks
    // Params 2
    // Checksum 0xbf2fcf40, Offset: 0x2af0
    // Size: 0x3c, Type: dev
    function devgui_scorestreak_command_timeoutdvar( killstreaktype, dvar )
    {
        devgui_scorestreak_dvar_toggle( killstreaktype, "Time Out", dvar );
    }

    // Namespace killstreaks/killstreaks
    // Params 2
    // Checksum 0xb292240c, Offset: 0x2b38
    // Size: 0x3c, Type: dev
    function devgui_scorestreak_command_debugdvar( killstreaktype, dvar )
    {
        devgui_scorestreak_dvar_toggle( killstreaktype, "Debug", dvar );
    }

#/

// Namespace killstreaks/killstreaks
// Params 3
// Checksum 0xf10f0fa5, Offset: 0x2b80
// Size: 0x6c
function devgui_scorestreak_dvar_toggle( killstreaktype, title, dvar )
{
    setdvar( dvar, 0 );
    devgui_scorestreak_command( killstreaktype, "Toggle " + title, "toggle " + dvar + " 1 0" );
}

// Namespace killstreaks/killstreaks
// Params 3
// Checksum 0xf956da48, Offset: 0x2bf8
// Size: 0x114
function devgui_scorestreak_command( killstreaktype, title, command )
{
    /#
        assert( isdefined( killstreaktype ), "Can not register a killstreak without a valid type name." );
        assert( isdefined( level.killstreaks[ killstreaktype ] ), "Killstreak needs to be registered before calling register_dev_dvar." );
        root = "devgui_cmd \"MP/Scorestreaks/";
        user_name = makelocalizedstring( level.killstreaks[ killstreaktype ].uiname );
        adddebugcommand( root + user_name + " (" + killstreaktype + ")/" + title + "\" \"" + command + "\" \n" );
    #/
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0x23ee8ab, Offset: 0x2d18
// Size: 0x9e
function should_draw_debug( killstreak )
{
    /#
        assert( isdefined( killstreak ), "Can not register a killstreak without a valid type name." );
        
        if ( isdefined( level.killstreaks[ killstreak ] ) && isdefined( level.killstreaks[ killstreak ].devdebugdvar ) )
        {
            return getdvarint( level.killstreaks[ killstreak ].devdebugdvar );
        }
    #/
    
    return 0;
}

// Namespace killstreaks/killstreaks
// Params 2
// Checksum 0xd106dfb2, Offset: 0x2dc0
// Size: 0x34
function allow_assists( killstreaktype, allow )
{
    level.killstreaks[ killstreaktype ].allowassists = allow;
}

// Namespace killstreaks/killstreaks
// Params 3
// Checksum 0xe5251c02, Offset: 0x2e00
// Size: 0x74
function set_team_kill_penalty_scale( killstreaktype, scale, isinventory )
{
    level.killstreaks[ killstreaktype ].teamkillpenaltyscale = scale;
    
    if ( !( isdefined( isinventory ) && isinventory ) )
    {
        set_team_kill_penalty_scale( "inventory_" + killstreaktype, scale, 1 );
    }
}

// Namespace killstreaks/killstreaks
// Params 3
// Checksum 0x2fda8fe5, Offset: 0x2e80
// Size: 0x74
function override_entity_camera_in_demo( killstreaktype, value, isinventory )
{
    level.killstreaks[ killstreaktype ].overrideentitycameraindemo = value;
    
    if ( !( isdefined( isinventory ) && isinventory ) )
    {
        override_entity_camera_in_demo( "inventory_" + killstreaktype, value, 1 );
    }
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0x73ebc759, Offset: 0x2f00
// Size: 0x30
function is_available( killstreak )
{
    if ( isdefined( level.menureferenceforkillstreak[ killstreak ] ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0x74e08299, Offset: 0x2f38
// Size: 0x1c
function get_by_menu_name( killstreak )
{
    return level.menureferenceforkillstreak[ killstreak ];
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0x5e03ff6b, Offset: 0x2f60
// Size: 0x4e
function get_menu_name( killstreaktype )
{
    assert( isdefined( level.killstreaks[ killstreaktype ] ) );
    return level.killstreaks[ killstreaktype ].menuname;
}

// Namespace killstreaks/killstreaks
// Params 2
// Checksum 0x50937da7, Offset: 0x2fb8
// Size: 0x124
function get_level( index, killstreak )
{
    killstreaklevel = level.killstreaks[ get_by_menu_name( killstreak ) ].killstreaklevel;
    
    if ( getdvarint( "custom_killstreak_mode" ) == 2 )
    {
        if ( isdefined( self.killstreak[ index ] ) && killstreak == self.killstreak[ index ] )
        {
            killsrequired = getdvarint( "custom_killstreak_" + index + 1 + "_kills" );
            
            if ( killsrequired )
            {
                killstreaklevel = getdvarint( "custom_killstreak_" + index + 1 + "_kills" );
            }
        }
    }
    
    return killstreaklevel;
}

// Namespace killstreaks/killstreaks
// Params 3
// Checksum 0xda83c8e9, Offset: 0x30e8
// Size: 0x24e, Type: bool
function give_if_streak_count_matches( index, killstreak, streakcount )
{
    pixbeginevent( "giveKillstreakIfStreakCountMatches" );
    
    /#
        if ( !isdefined( killstreak ) )
        {
            println( "Killstreak Undefined.\n" );
        }
        
        if ( isdefined( killstreak ) )
        {
            println( "Killstreak listed as." + killstreak + "\n" );
        }
        
        if ( !is_available( killstreak ) )
        {
            println( "Killstreak Not Available.\n" );
        }
    #/
    
    if ( self.pers[ "killstreaksEarnedThisKillstreak" ] > index && util::isroundbased() )
    {
        hasalreadyearnedkillstreak = 1;
    }
    else
    {
        hasalreadyearnedkillstreak = 0;
    }
    
    if ( isdefined( killstreak ) && is_available( killstreak ) && !hasalreadyearnedkillstreak )
    {
        killstreaklevel = get_level( index, killstreak );
        
        if ( self hasperk( "specialty_killstreak" ) )
        {
            reduction = getdvarint( "perk_killstreakReduction" );
            killstreaklevel -= reduction;
            
            if ( killstreaklevel <= 0 )
            {
                killstreaklevel = 1;
            }
        }
        
        if ( killstreaklevel == streakcount )
        {
            self give( get_by_menu_name( killstreak ), streakcount );
            self.pers[ "killstreaksEarnedThisKillstreak" ] = index + 1;
            pixendevent();
            return true;
        }
    }
    
    pixendevent();
    return false;
}

// Namespace killstreaks/killstreaks
// Params 0
// Checksum 0x8a9a7d17, Offset: 0x3340
// Size: 0xc4
function give_for_streak()
{
    if ( !util::iskillstreaksenabled() )
    {
        return;
    }
    
    if ( !isdefined( self.pers[ "totalKillstreakCount" ] ) )
    {
        self.pers[ "totalKillstreakCount" ] = 0;
    }
    
    given = 0;
    
    for ( i = 0; i < self.killstreak.size ; i++ )
    {
        given |= give_if_streak_count_matches( i, self.killstreak[ i ], self.pers[ "cur_kill_streak" ] );
    }
}

// Namespace killstreaks/killstreaks
// Params 0
// Checksum 0x46a39d39, Offset: 0x3410
// Size: 0x8c
function is_an_a_killstreak()
{
    onkillstreak = 0;
    
    if ( !isdefined( self.pers[ "kill_streak_before_death" ] ) )
    {
        self.pers[ "kill_streak_before_death" ] = 0;
    }
    
    streakplusone = self.pers[ "kill_streak_before_death" ] + 1;
    
    if ( self.pers[ "kill_streak_before_death" ] >= 5 )
    {
        onkillstreak = 1;
    }
    
    return onkillstreak;
}

// Namespace killstreaks/killstreaks
// Params 5
// Checksum 0x3ca1bd8c, Offset: 0x34a8
// Size: 0x19c
function give( killstreaktype, streak, suppressnotification, noxp, tobottom )
{
    pixbeginevent( "giveKillstreak" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    had_to_delay = 0;
    killstreakgiven = 0;
    
    if ( isdefined( noxp ) )
    {
        if ( self give_internal( killstreaktype, undefined, noxp, tobottom ) )
        {
            killstreakgiven = 1;
            
            if ( self.just_given_new_inventory_killstreak === 1 )
            {
                self add_to_notification_queue( level.killstreaks[ killstreaktype ].menuname, streak, killstreaktype, noxp );
            }
        }
    }
    else if ( self give_internal( killstreaktype, noxp ) )
    {
        killstreakgiven = 1;
        
        if ( self.just_given_new_inventory_killstreak === 1 )
        {
            self add_to_notification_queue( level.killstreaks[ killstreaktype ].menuname, streak, killstreaktype, noxp );
        }
    }
    
    pixendevent();
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0x6dc81ab0, Offset: 0x3650
// Size: 0xf4
function take( killstreak )
{
    self endon( #"disconnect" );
    killstreak_weapon = get_killstreak_weapon( killstreak );
    remove_used_killstreak( killstreak );
    
    if ( self getinventoryweapon() == killstreak_weapon )
    {
        self setinventoryweapon( level.weaponnone );
    }
    
    waittillframeend();
    currentweapon = self getcurrentweapon();
    
    if ( currentweapon != killstreak_weapon || killstreak_weapon.iscarriedkillstreak )
    {
        return;
    }
    
    switch_to_last_non_killstreak_weapon();
    activate_next();
}

// Namespace killstreaks/killstreaks
// Params 0
// Checksum 0xf4d411ad, Offset: 0x3750
// Size: 0x14c
function remove_oldest()
{
    if ( isdefined( self.pers[ "killstreaks" ][ 0 ] ) )
    {
        currentweapon = self getcurrentweapon();
        
        if ( currentweapon == get_killstreak_weapon( self.pers[ "killstreaks" ][ 0 ] ) )
        {
            primaries = self getweaponslistprimaries();
            
            if ( primaries.size > 0 )
            {
                self switchtoweapon( primaries[ 0 ] );
            }
        }
        
        self notify( #"oldest_killstreak_removed", { #type:self.pers[ "killstreaks" ][ 0 ], #id:self.pers[ "killstreak_unique_id" ][ 0 ] } );
        self remove_used_killstreak( self.pers[ "killstreaks" ][ 0 ], self.pers[ "killstreak_unique_id" ][ 0 ], 0 );
    }
}

// Namespace killstreaks/killstreaks
// Params 4
// Checksum 0xc4e7e613, Offset: 0x38a8
// Size: 0x554, Type: bool
function give_internal( killstreaktype, do_not_update_death_count, noxp, tobottom )
{
    self.just_given_new_inventory_killstreak = undefined;
    
    if ( level.gameended )
    {
        return false;
    }
    
    if ( !util::iskillstreaksenabled() )
    {
        return false;
    }
    
    if ( !isdefined( level.killstreaks[ killstreaktype ] ) )
    {
        return false;
    }
    
    if ( !isdefined( self.pers[ "killstreaks" ] ) )
    {
        self.pers[ "killstreaks" ] = [];
    }
    
    if ( !isdefined( self.pers[ "killstreak_has_been_used" ] ) )
    {
        self.pers[ "killstreak_has_been_used" ] = [];
    }
    
    if ( !isdefined( self.pers[ "killstreak_unique_id" ] ) )
    {
        self.pers[ "killstreak_unique_id" ] = [];
    }
    
    if ( !isdefined( self.pers[ "killstreak_ammo_count" ] ) )
    {
        self.pers[ "killstreak_ammo_count" ] = [];
    }
    
    just_max_stack_removed_inventory_killstreak = undefined;
    
    if ( isdefined( tobottom ) && tobottom )
    {
        size = self.pers[ "killstreaks" ].size;
        
        if ( self.pers[ "killstreaks" ].size >= level.maxinventoryscorestreaks )
        {
            self remove_oldest();
            just_max_stack_removed_inventory_killstreak = self.just_removed_used_killstreak;
        }
        
        for ( i = size; i > 0 ; i-- )
        {
            self.pers[ "killstreaks" ][ i ] = self.pers[ "killstreaks" ][ i - 1 ];
            self.pers[ "killstreak_has_been_used" ][ i ] = self.pers[ "killstreak_has_been_used" ][ i - 1 ];
            self.pers[ "killstreak_unique_id" ][ i ] = self.pers[ "killstreak_unique_id" ][ i - 1 ];
            self.pers[ "killstreak_ammo_count" ][ i ] = self.pers[ "killstreak_ammo_count" ][ i - 1 ];
        }
        
        self.pers[ "killstreaks" ][ 0 ] = killstreaktype;
        self.pers[ "killstreak_unique_id" ][ 0 ] = level.killstreakcounter;
        level.killstreakcounter++;
        
        if ( isdefined( noxp ) )
        {
            self.pers[ "killstreak_has_been_used" ][ 0 ] = noxp;
        }
        else
        {
            self.pers[ "killstreak_has_been_used" ][ 0 ] = 0;
        }
        
        if ( size == 0 )
        {
            weapon = get_killstreak_weapon( killstreaktype );
            ammocount = give_weapon( weapon, 1 );
        }
        
        self.pers[ "killstreak_ammo_count" ][ 0 ] = 0;
    }
    else
    {
        self.pers[ "killstreaks" ][ self.pers[ "killstreaks" ].size ] = killstreaktype;
        self.pers[ "killstreak_unique_id" ][ self.pers[ "killstreak_unique_id" ].size ] = level.killstreakcounter;
        level.killstreakcounter++;
        
        if ( self.pers[ "killstreaks" ].size > level.maxinventoryscorestreaks )
        {
            self remove_oldest();
            just_max_stack_removed_inventory_killstreak = self.just_removed_used_killstreak;
        }
        
        if ( isdefined( noxp ) )
        {
            self.pers[ "killstreak_has_been_used" ][ self.pers[ "killstreak_has_been_used" ].size ] = noxp;
        }
        else
        {
            self.pers[ "killstreak_has_been_used" ][ self.pers[ "killstreak_has_been_used" ].size ] = 0;
        }
        
        weapon = get_killstreak_weapon( killstreaktype );
        ammocount = give_weapon( weapon, 1 );
        self.pers[ "killstreak_ammo_count" ][ self.pers[ "killstreak_ammo_count" ].size ] = ammocount;
    }
    
    self.just_given_new_inventory_killstreak = killstreaktype !== just_max_stack_removed_inventory_killstreak;
    return true;
}

// Namespace killstreaks/killstreaks
// Params 4
// Checksum 0x2c791542, Offset: 0x3e08
// Size: 0x134
function add_to_notification_queue( menuname, streakcount, hardpointtype, nonotify )
{
    killstreaktablenumber = level.killstreakindices[ menuname ];
    
    if ( !isdefined( killstreaktablenumber ) )
    {
        return;
    }
    
    if ( isdefined( nonotify ) && nonotify )
    {
        return;
    }
    
    informdialog = get_killstreak_inform_dialog( hardpointtype );
    self thread play_killstreak_ready_dialog( hardpointtype, 2.4 );
    self thread play_killstreak_ready_sfx( hardpointtype );
    self luinotifyevent( &"killstreak_received", 2, killstreaktablenumber, istring( informdialog ) );
    self luinotifyeventtospectators( &"killstreak_received", 2, killstreaktablenumber, istring( informdialog ) );
}

// Namespace killstreaks/killstreaks
// Params 0
// Checksum 0xc53a5322, Offset: 0x3f48
// Size: 0xae, Type: bool
function has_equipped()
{
    currentweapon = self getcurrentweapon();
    keys = getarraykeys( level.killstreaks );
    
    for ( i = 0; i < keys.size ; i++ )
    {
        if ( level.killstreaks[ keys[ i ] ].weapon == currentweapon )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0x5cec39c4, Offset: 0x4000
// Size: 0x220
function _get_from_weapon( weapon )
{
    keys = getarraykeys( level.killstreaks );
    
    foreach ( key in keys )
    {
        killstreak = level.killstreaks[ key ];
        
        if ( killstreak.weapon == weapon )
        {
            return key;
        }
        
        if ( isdefined( killstreak.altweapons ) )
        {
            foreach ( altweapon in killstreak.altweapons )
            {
                if ( altweapon == weapon )
                {
                    return key;
                }
            }
        }
        
        if ( isdefined( killstreak.remoteoverrideweapons ) )
        {
            foreach ( remoteoverrideweapon in killstreak.remoteoverrideweapons )
            {
                if ( remoteoverrideweapon == weapon )
                {
                    return key;
                }
            }
        }
    }
    
    return undefined;
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0xec749eea, Offset: 0x4228
// Size: 0x7e
function get_from_weapon( weapon )
{
    if ( weapon == level.weaponnone )
    {
        return undefined;
    }
    
    res = _get_from_weapon( weapon );
    
    if ( !isdefined( res ) )
    {
        return _get_from_weapon( weapon.rootweapon );
    }
    
    return res;
}

// Namespace killstreaks/killstreaks
// Params 3
// Checksum 0x32e49687, Offset: 0x42b0
// Size: 0x5fa
function give_weapon( weapon, isinventory, usestoredammo )
{
    currentweapon = self getcurrentweapon();
    
    if ( currentweapon != level.weaponnone && !( isdefined( level.usingmomentum ) && level.usingmomentum ) )
    {
        weaponslist = self getweaponslist();
        
        for ( idx = 0; idx < weaponslist.size ; idx++ )
        {
            carriedweapon = weaponslist[ idx ];
            
            if ( currentweapon == carriedweapon )
            {
                continue;
            }
            
            switch ( carriedweapon.name )
            {
                case #"m32":
                case #"minigun":
                    continue;
            }
            
            if ( is_killstreak_weapon( carriedweapon ) )
            {
                self takeweapon( carriedweapon );
            }
        }
    }
    
    if ( currentweapon != weapon && self hasweapon( weapon ) == 0 )
    {
        self takeweapon( weapon );
        self giveweapon( weapon );
    }
    
    if ( isdefined( level.usingmomentum ) && level.usingmomentum )
    {
        self setinventoryweapon( weapon );
        
        if ( weapon.iscarriedkillstreak )
        {
            if ( !isdefined( self.pers[ "held_killstreak_ammo_count" ][ weapon ] ) )
            {
                self.pers[ "held_killstreak_ammo_count" ][ weapon ] = 0;
            }
            
            if ( !isdefined( self.pers[ "held_killstreak_clip_count" ][ weapon ] ) )
            {
                self.pers[ "held_killstreak_clip_count" ][ weapon ] = weapon.clipsize;
            }
            
            if ( !isdefined( self.pers[ "killstreak_quantity" ][ weapon ] ) )
            {
                self.pers[ "killstreak_quantity" ][ weapon ] = 0;
            }
            
            if ( currentweapon == weapon && !isheldinventorykillstreakweapon( weapon ) )
            {
                return weapon.maxammo;
            }
            else if ( isdefined( usestoredammo ) && usestoredammo && self.pers[ "killstreak_ammo_count" ][ self.pers[ "killstreak_ammo_count" ].size - 1 ] > 0 )
            {
                switch ( weapon.name )
                {
                    case #"inventory_minigun":
                        if ( isdefined( self.minigunactive ) && self.minigunactive )
                        {
                            return self.pers[ "held_killstreak_ammo_count" ][ weapon ];
                        }
                        
                        break;
                    case #"inventory_m32":
                        if ( isdefined( self.m32active ) && self.m32active )
                        {
                            return self.pers[ "held_killstreak_ammo_count" ][ weapon ];
                        }
                        
                        break;
                    default:
                        break;
                }
                
                self.pers[ "held_killstreak_ammo_count" ][ weapon ] = self.pers[ "killstreak_ammo_count" ][ self.pers[ "killstreak_ammo_count" ].size - 1 ];
                self loadout::setweaponammooverall( weapon, self.pers[ "killstreak_ammo_count" ][ self.pers[ "killstreak_ammo_count" ].size - 1 ] );
            }
            else
            {
                self.pers[ "held_killstreak_ammo_count" ][ weapon ] = weapon.maxammo;
                self.pers[ "held_killstreak_clip_count" ][ weapon ] = weapon.clipsize;
                self loadout::setweaponammooverall( weapon, self.pers[ "held_killstreak_ammo_count" ][ weapon ] );
            }
            
            return self.pers[ "held_killstreak_ammo_count" ][ weapon ];
        }
        else
        {
            switch ( weapon.name )
            {
                case #"ai_tank_marker":
                case #"combat_robot_marker":
                case #"dart":
                case #"inventory_ai_tank_marker":
                case #"inventory_combat_robot_marker":
                case #"inventory_dart":
                case #"inventory_m32_drop":
                case #"inventory_minigun_drop":
                case #"hash_eb9df355":
                case #"inventory_supplydrop_marker":
                case #"supplydrop_marker":
                    delta = 1;
                    break;
                default:
                    delta = 0;
                    break;
            }
            
            return change_killstreak_quantity( weapon, delta );
        }
        
        return;
    }
    
    self setactionslot( 4, "weapon", weapon );
    return 1;
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0x45b6d765, Offset: 0x48b8
// Size: 0x226, Type: bool
function activate_next( do_not_update_death_count )
{
    if ( level.gameended )
    {
        return false;
    }
    
    if ( isdefined( level.usingmomentum ) && level.usingmomentum )
    {
        self setinventoryweapon( level.weaponnone );
    }
    else
    {
        self setactionslot( 4, "" );
    }
    
    if ( !isdefined( self.pers[ "killstreaks" ] ) || self.pers[ "killstreaks" ].size == 0 )
    {
        return false;
    }
    
    killstreaktype = self.pers[ "killstreaks" ][ self.pers[ "killstreaks" ].size - 1 ];
    
    if ( !isdefined( level.killstreaks[ killstreaktype ] ) )
    {
        return false;
    }
    
    weapon = level.killstreaks[ killstreaktype ].weapon;
    waitframe( 1 );
    ammocount = give_weapon( weapon, 0, 1 );
    
    if ( weapon.iscarriedkillstreak )
    {
        self setweaponammoclip( weapon, self.pers[ "held_killstreak_clip_count" ][ weapon ] );
        self setweaponammostock( weapon, ammocount - self.pers[ "held_killstreak_clip_count" ][ weapon ] );
    }
    
    if ( !isdefined( do_not_update_death_count ) || do_not_update_death_count != 0 )
    {
        self.pers[ "killstreakItemDeathCount" + killstreaktype ] = self.deathcount;
    }
    
    return true;
}

// Namespace killstreaks/killstreaks
// Params 0
// Checksum 0xed3e4706, Offset: 0x4ae8
// Size: 0x4c
function give_owned()
{
    if ( isdefined( self.pers[ "killstreaks" ] ) && self.pers[ "killstreaks" ].size > 0 )
    {
        self activate_next( 0 );
    }
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0xb9099350, Offset: 0x4b40
// Size: 0x44
function get_killstreak_quantity( killstreakweapon )
{
    return isdefined( self.pers[ "killstreak_quantity" ][ killstreakweapon ] ) ? self.pers[ "killstreak_quantity" ][ killstreakweapon ] : 0;
}

// Namespace killstreaks/killstreaks
// Params 2
// Checksum 0x7944d13f, Offset: 0x4b90
// Size: 0x128
function change_killstreak_quantity( killstreakweapon, delta )
{
    quantity = get_killstreak_quantity( killstreakweapon );
    previousquantity = quantity;
    quantity += delta;
    
    if ( quantity > level.scorestreaksmaxstacking )
    {
        quantity = level.scorestreaksmaxstacking;
    }
    
    if ( self hasweapon( killstreakweapon ) == 0 )
    {
        self takeweapon( killstreakweapon );
        self giveweapon( killstreakweapon );
        self seteverhadweaponall( 1 );
    }
    
    self.pers[ "killstreak_quantity" ][ killstreakweapon ] = quantity;
    self setweaponammoclip( killstreakweapon, quantity );
    return quantity;
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0x5ce9de6b, Offset: 0x4cc0
// Size: 0x96, Type: bool
function has_killstreak_in_class( killstreakmenuname )
{
    foreach ( equippedkillstreak in self.killstreak )
    {
        if ( equippedkillstreak == killstreakmenuname )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0x387fa6f7, Offset: 0x4d60
// Size: 0xaa, Type: bool
function has_killstreak( killstreak )
{
    player = self;
    
    if ( !isdefined( killstreak ) || !isdefined( player.pers[ "killstreaks" ] ) )
    {
        return false;
    }
    
    for ( i = 0; i < self.pers[ "killstreaks" ].size ; i++ )
    {
        if ( player.pers[ "killstreaks" ][ i ] == killstreak )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0x37762a2f, Offset: 0x4e18
// Size: 0x142
function recordkillstreakbegindirect( recordstreakindex )
{
    player = self;
    
    if ( !isplayer( player ) || !isdefined( recordstreakindex ) )
    {
        return;
    }
    
    if ( !isdefined( self.killstreakevents ) )
    {
        player.killstreakevents = associativearray();
    }
    
    if ( isdefined( self.killstreakevents[ recordstreakindex ] ) )
    {
        kills = player.killstreakevents[ recordstreakindex ];
        eventindex = player recordkillstreakevent( recordstreakindex );
        player killstreakrules::recordkillstreakenddirect( eventindex, recordstreakindex, kills );
        player.killstreakevents[ recordstreakindex ] = undefined;
        return;
    }
    
    eventindex = player recordkillstreakevent( recordstreakindex );
    player.killstreakevents[ recordstreakindex ] = eventindex;
}

// Namespace killstreaks/killstreaks
// Params 3
// Checksum 0x6d234fc5, Offset: 0x4f68
// Size: 0x62c
function remove_when_done( killstreak, haskillstreakbeenused, isfrominventory )
{
    self endon( #"disconnect" );
    waitresult = self waittill( "killstreak_done" );
    killstreaktype = waitresult.type;
    
    if ( waitresult.is_successful )
    {
        /#
            print( "killstreak: " + get_menu_name( killstreak ) );
        #/
        
        killstreak_weapon = get_killstreak_weapon( killstreak );
        recordstreakindex = undefined;
        
        if ( isdefined( level.killstreaks[ killstreak ].menuname ) )
        {
            recordstreakindex = level.killstreakindices[ level.killstreaks[ killstreak ].menuname ];
            self recordkillstreakbegindirect( recordstreakindex );
        }
        
        if ( isdefined( level.usingscorestreaks ) && level.usingscorestreaks )
        {
            if ( isdefined( isfrominventory ) && isfrominventory )
            {
                remove_used_killstreak( killstreak );
                
                if ( self getinventoryweapon() == killstreak_weapon )
                {
                    self setinventoryweapon( level.weaponnone );
                }
            }
            else
            {
                self change_killstreak_quantity( killstreak_weapon, -1 );
            }
        }
        else if ( isdefined( level.usingmomentum ) && level.usingmomentum )
        {
            if ( isdefined( isfrominventory ) && isfrominventory && self getinventoryweapon() == killstreak_weapon )
            {
                remove_used_killstreak( killstreak );
                self setinventoryweapon( level.weaponnone );
            }
            else
            {
                globallogic_score::_setplayermomentum( self, self.momentum - level.killstreaks[ killstreaktype ].momentumcost );
            }
        }
        else
        {
            remove_used_killstreak( killstreak );
        }
        
        if ( !( isdefined( level.usingmomentum ) && level.usingmomentum ) )
        {
            self setactionslot( 4, "" );
        }
        
        if ( getdvarint( "mp_prototype", 0 ) > 0 )
        {
            killstreak_weapon = get_killstreak_weapon( killstreak );
            should_reset_power = killstreak_weapon.inventorytype == "heavy" || killstreak_weapon.inventorytype == "ability";
            
            if ( should_reset_power )
            {
                slot = self gadgetgetslot( killstreak_weapon );
                self gadgetpowerreset( slot );
                self gadgetcharging( slot, 1 );
            }
        }
        
        success = 1;
    }
    
    waittillframeend();
    self.pers[ "lpSystem" ].blockui = 0;
    self unhide_compass();
    currentweapon = self getcurrentweapon();
    killstreak_weapon = get_killstreak_weapon( killstreaktype );
    
    if ( currentweapon == killstreak_weapon && killstreak_weapon.iscarriedkillstreak )
    {
        return;
    }
    
    if ( isdefined( isfrominventory ) && ( !self has_killstreak_in_class( get_menu_name( killstreak ) ) || waitresult.is_successful && isfrominventory ) )
    {
        switch_to_last_non_killstreak_weapon();
    }
    else
    {
        killstreakforcurrentweapon = get_from_weapon( currentweapon );
        
        if ( currentweapon.isgameplayweapon )
        {
            if ( isdefined( self.isdefusing ) && ( isdefined( self.isplanting ) && self.isplanting || self.isdefusing ) )
            {
                return;
            }
        }
        
        if ( !isdefined( killstreakforcurrentweapon ) && currentweapon.isheavyweapon )
        {
            return;
        }
        
        if ( waitresult.is_successful || !isdefined( killstreakforcurrentweapon ) || killstreakforcurrentweapon == killstreak )
        {
            self.fillabilitypoweronspawn = 1;
            switch_to_last_non_killstreak_weapon();
        }
    }
    
    if ( isdefined( isfrominventory ) && ( !( isdefined( level.usingmomentum ) && level.usingmomentum ) || isfrominventory ) )
    {
        if ( waitresult.is_successful )
        {
            activate_next();
        }
    }
}

// Namespace killstreaks/killstreaks
// Params 2
// Checksum 0x5dabe0fb, Offset: 0x55a0
// Size: 0x84
function usekillstreak( killstreak, isfrominventory )
{
    haskillstreakbeenused = get_if_top_killstreak_has_been_used();
    
    if ( isdefined( self.selectinglocation ) )
    {
        return;
    }
    
    self thread remove_when_done( killstreak, haskillstreakbeenused, isfrominventory );
    self thread trigger_killstreak( killstreak, isfrominventory );
}

// Namespace killstreaks/killstreaks
// Params 3
// Checksum 0xd7156e16, Offset: 0x5630
// Size: 0x316
function remove_used_killstreak( killstreak, killstreakid, take_weapon_after_use )
{
    if ( !isdefined( take_weapon_after_use ) )
    {
        take_weapon_after_use = 1;
    }
    
    self.just_removed_used_killstreak = undefined;
    
    if ( !isdefined( self.pers[ "killstreaks" ] ) )
    {
        return;
    }
    
    killstreakindex = undefined;
    
    for ( i = self.pers[ "killstreaks" ].size - 1; i >= 0 ; i-- )
    {
        if ( self.pers[ "killstreaks" ][ i ] == killstreak )
        {
            if ( isdefined( killstreakid ) && self.pers[ "killstreak_unique_id" ][ i ] != killstreakid )
            {
                continue;
            }
            
            killstreakindex = i;
            break;
        }
    }
    
    if ( !isdefined( killstreakindex ) )
    {
        return 0;
    }
    
    self.just_removed_used_killstreak = killstreak;
    
    if ( take_weapon_after_use && !self has_killstreak_in_class( get_menu_name( killstreak ) ) )
    {
        self thread take_weapon_after_use( get_killstreak_weapon( killstreak ) );
    }
    
    arraysize = self.pers[ "killstreaks" ].size;
    
    for ( i = killstreakindex; i < arraysize - 1 ; i++ )
    {
        self.pers[ "killstreaks" ][ i ] = self.pers[ "killstreaks" ][ i + 1 ];
        self.pers[ "killstreak_has_been_used" ][ i ] = self.pers[ "killstreak_has_been_used" ][ i + 1 ];
        self.pers[ "killstreak_unique_id" ][ i ] = self.pers[ "killstreak_unique_id" ][ i + 1 ];
        self.pers[ "killstreak_ammo_count" ][ i ] = self.pers[ "killstreak_ammo_count" ][ i + 1 ];
    }
    
    self.pers[ "killstreaks" ][ arraysize - 1 ] = undefined;
    self.pers[ "killstreak_has_been_used" ][ arraysize - 1 ] = undefined;
    self.pers[ "killstreak_unique_id" ][ arraysize - 1 ] = undefined;
    self.pers[ "killstreak_ammo_count" ][ arraysize - 1 ] = undefined;
    return 1;
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0xa57263f6, Offset: 0x5950
// Size: 0xa8
function take_weapon_after_use( killstreakweapon )
{
    self endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"joined_team" );
    self endon( #"joined_spectators" );
    self waittill( "weapon_change" );
    inventoryweapon = self getinventoryweapon();
    
    if ( inventoryweapon != killstreakweapon )
    {
        self takeweapon( killstreakweapon );
    }
    
    player.killstreakactivated = 1;
}

// Namespace killstreaks/killstreaks
// Params 0
// Checksum 0x77671aa5, Offset: 0x5a00
// Size: 0x4e
function get_top_killstreak()
{
    if ( self.pers[ "killstreaks" ].size == 0 )
    {
        return undefined;
    }
    
    return self.pers[ "killstreaks" ][ self.pers[ "killstreaks" ].size - 1 ];
}

// Namespace killstreaks/killstreaks
// Params 0
// Checksum 0xd7b0c934, Offset: 0x5a58
// Size: 0x70
function get_if_top_killstreak_has_been_used()
{
    if ( !( isdefined( level.usingmomentum ) && level.usingmomentum ) )
    {
        if ( self.pers[ "killstreak_has_been_used" ].size == 0 )
        {
            return undefined;
        }
        
        return self.pers[ "killstreak_has_been_used" ][ self.pers[ "killstreak_has_been_used" ].size - 1 ];
    }
}

// Namespace killstreaks/killstreaks
// Params 0
// Checksum 0x192dc5f7, Offset: 0x5ad0
// Size: 0x4e
function get_top_killstreak_unique_id()
{
    if ( self.pers[ "killstreak_unique_id" ].size == 0 )
    {
        return undefined;
    }
    
    return self.pers[ "killstreak_unique_id" ][ self.pers[ "killstreak_unique_id" ].size - 1 ];
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0xf2aa4938, Offset: 0x5b28
// Size: 0x72
function get_killstreak_index_by_id( killstreakid )
{
    for ( index = self.pers[ "killstreak_unique_id" ].size - 1; index >= 0 ; index-- )
    {
        if ( self.pers[ "killstreak_unique_id" ][ index ] == killstreakid )
        {
            return index;
        }
    }
    
    return undefined;
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0x50fcbba2, Offset: 0x5ba8
// Size: 0x7e
function get_killstreak_momentum_cost( killstreak )
{
    if ( !( isdefined( level.usingmomentum ) && level.usingmomentum ) )
    {
        return 0;
    }
    
    if ( !isdefined( killstreak ) )
    {
        return 0;
    }
    
    assert( isdefined( level.killstreaks[ killstreak ] ) );
    return level.killstreaks[ killstreak ].momentumcost;
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0xfbee5680, Offset: 0x5c30
// Size: 0x8c
function get_killstreak_for_weapon_for_stats( weapon )
{
    prefix = "inventory_";
    killstreak = get_killstreak_for_weapon( weapon );
    
    if ( isdefined( killstreak ) )
    {
        if ( strstartswith( killstreak, prefix ) )
        {
            killstreak = getsubstr( killstreak, prefix.size );
        }
    }
    
    return killstreak;
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0x78c0b53b, Offset: 0x5cc8
// Size: 0x5e
function get_killstreak_team_kill_penalty_scale( weapon )
{
    killstreak = get_killstreak_for_weapon( weapon );
    
    if ( !isdefined( killstreak ) )
    {
        return 1;
    }
    
    return level.killstreaks[ killstreak ].teamkillpenaltyscale;
}

// Namespace killstreaks/killstreaks
// Params 2
// Checksum 0x8d14cc85, Offset: 0x5d30
// Size: 0xbe, Type: bool
function should_override_entity_camera_in_demo( player, weapon )
{
    killstreak = get_killstreak_for_weapon( weapon );
    
    if ( !isdefined( killstreak ) )
    {
        return false;
    }
    
    if ( level.killstreaks[ killstreak ].overrideentitycameraindemo )
    {
        return true;
    }
    
    if ( isdefined( player.remoteweapon.controlled ) && isdefined( player.remoteweapon ) && player.remoteweapon.controlled )
    {
        return true;
    }
    
    return false;
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0x21c29470, Offset: 0x5df8
// Size: 0x90
function wait_till_heavy_weapon_is_fully_on( weapon )
{
    self endon( #"death", #"disconnect", #"weapon_change" );
    slot = self gadgetgetslot( weapon );
    
    while ( true )
    {
        if ( self ability_player::gadget_is_in_use( slot ) )
        {
            self.lastnonkillstreakweapon = weapon;
            return;
        }
        
        waitframe( 1 );
    }
}

// Namespace killstreaks/killstreaks
// Params 0
// Checksum 0xf0ce7f68, Offset: 0x5e90
// Size: 0x314
function track_weapon_usage()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self.lastnonkillstreakweapon = self getcurrentweapon();
    lastvalidpimary = self getcurrentweapon();
    
    if ( self.lastnonkillstreakweapon == level.weaponnone )
    {
        weapons = self getweaponslistprimaries();
        
        if ( weapons.size > 0 )
        {
            self.lastnonkillstreakweapon = weapons[ 0 ];
        }
        else
        {
            self.lastnonkillstreakweapon = level.weaponbasemelee;
        }
    }
    
    assert( self.lastnonkillstreakweapon != level.weaponnone );
    
    for ( ;; )
    {
        currentweapon = self getcurrentweapon();
        waitresult = self waittill( "weapon_change" );
        weapon = waitresult.weapon;
        
        if ( weapons::is_primary_weapon( weapon ) )
        {
            lastvalidpimary = weapon;
        }
        
        if ( weapon == self.lastnonkillstreakweapon || weapon == level.weaponnone || weapon == level.weaponbasemelee )
        {
            continue;
        }
        
        if ( weapon.isgameplayweapon )
        {
            continue;
        }
        
        if ( isdefined( self.resurrect_weapon ) && weapon == self.resurrect_weapon )
        {
            continue;
        }
        
        name = get_killstreak_for_weapon( weapon );
        
        if ( isdefined( name ) && !weapon.iscarriedkillstreak )
        {
            killstreak = level.killstreaks[ name ];
            continue;
        }
        
        if ( currentweapon.isequipment )
        {
            if ( self.lastnonkillstreakweapon.iscarriedkillstreak )
            {
                self.lastnonkillstreakweapon = lastvalidpimary;
            }
            
            continue;
        }
        
        if ( weapon.isheavyweapon )
        {
            if ( weapon.gadget_heroversion_2_0 )
            {
                if ( weapon.isgadget && self getammocount( weapon ) > 0 )
                {
                    self thread wait_till_heavy_weapon_is_fully_on( weapon );
                    continue;
                }
            }
        }
        
        self.lastnonkillstreakweapon = weapon;
    }
}

// Namespace killstreaks/killstreaks
// Params 0
// Checksum 0xa4733064, Offset: 0x61b0
// Size: 0x350
function killstreak_waiter()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self thread track_weapon_usage();
    self give_owned();
    
    for ( ;; )
    {
        waitresult = self waittill( "weapon_change" );
        weapon = waitresult.weapon;
        
        if ( !is_killstreak_weapon( weapon ) )
        {
            continue;
        }
        
        killstreak = get_killstreak_for_weapon( weapon );
        
        if ( !( isdefined( level.usingmomentum ) && level.usingmomentum ) )
        {
            killstreak = get_top_killstreak();
            
            if ( weapon != get_killstreak_weapon( killstreak ) )
            {
                continue;
            }
        }
        
        if ( is_remote_override_weapon( killstreak, weapon ) )
        {
            continue;
        }
        
        inventorybuttonpressed = self inventorybuttonpressed() || self isbot();
        waittillframeend();
        
        if ( isdefined( self.usingkillstreakheldweapon ) && self.usingkillstreakheldweapon && weapon.iscarriedkillstreak )
        {
            continue;
        }
        
        isfrominventory = undefined;
        
        if ( isdefined( level.usingscorestreaks ) && level.usingscorestreaks )
        {
            if ( weapon == self getinventoryweapon() )
            {
                isfrominventory = 1;
            }
            else if ( self getammocount( weapon ) <= 0 && weapon.name != "killstreak_ai_tank" )
            {
                self switch_to_last_non_killstreak_weapon();
                continue;
            }
        }
        else if ( isdefined( level.usingmomentum ) && level.usingmomentum )
        {
            if ( weapon == self getinventoryweapon() && inventorybuttonpressed )
            {
                isfrominventory = 1;
            }
            else if ( self.momentum < level.killstreaks[ killstreak ].momentumcost )
            {
                self switch_to_last_non_killstreak_weapon();
                continue;
            }
        }
        
        if ( !isdefined( level.starttime ) && level.roundstartkillstreakdelay > 0 )
        {
            display_unavailable_time();
            continue;
        }
        
        thread usekillstreak( killstreak, isfrominventory );
    }
}

// Namespace killstreaks/killstreaks
// Params 0
// Checksum 0xd10293b1, Offset: 0x6508
// Size: 0xf0
function killstreak_waiter_new()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    remote_weapon = getweapon( "killstreak_remote" );
    
    for ( ;; )
    {
        waitresult = self waittill( "weapon_change" );
        weapon = waitresult.weapon;
        
        if ( weapon == remote_weapon )
        {
            continue;
        }
        
        if ( is_killstreak_weapon( weapon ) )
        {
            killstreak = get_killstreak_for_weapon( weapon );
            thread usekillstreak( killstreak, 0 );
        }
    }
}

// Namespace killstreaks/killstreaks
// Params 0
// Checksum 0xb408500f, Offset: 0x6600
// Size: 0x128
function killstreak_waiter_grenade()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    remote_weapon = getweapon( "killstreak_remote" );
    
    for ( ;; )
    {
        waitresult = self waittill( "grenade_fire" );
        grenade = waitresult.projectile;
        grenadeweaponid = waitresult.weapon;
        
        if ( grenadeweaponid == remote_weapon )
        {
            continue;
        }
        
        if ( grenadeweaponid.inventorytype === "offhand" )
        {
            if ( is_killstreak_weapon( grenadeweaponid ) )
            {
                killstreak = get_killstreak_for_weapon( grenadeweaponid );
                thread usekillstreak( killstreak, 0 );
            }
        }
    }
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0x127bcea7, Offset: 0x6730
// Size: 0xe6, Type: bool
function should_delay_killstreak( killstreaktype )
{
    if ( !isdefined( level.starttime ) )
    {
        return false;
    }
    
    if ( level.roundstartkillstreakdelay < ( gettime() - level.starttime - level.discardtime ) / 1000 )
    {
        return false;
    }
    
    if ( !is_delayable_killstreak( killstreaktype ) )
    {
        return false;
    }
    
    killstreakweapon = get_killstreak_weapon( killstreaktype );
    
    if ( killstreakweapon.iscarriedkillstreak )
    {
        return false;
    }
    
    if ( util::isfirstround() || util::isoneround() )
    {
        return false;
    }
    
    return true;
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0xa2d08bce, Offset: 0x6820
// Size: 0x6a, Type: bool
function is_delayable_killstreak( killstreaktype )
{
    if ( isdefined( level.killstreaks[ killstreaktype ].delaystreak ) && isdefined( level.killstreaks[ killstreaktype ] ) && level.killstreaks[ killstreaktype ].delaystreak )
    {
        return true;
    }
    
    return false;
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0xbf3531ad, Offset: 0x6898
// Size: 0x122
function get_xp_amount_for_killstreak( killstreaktype )
{
    xpamount = 0;
    
    switch ( level.killstreaks[ killstreaktype ].killstreaklevel )
    {
        case 1:
        case 2:
        case 3:
        case 4:
            xpamount = 100;
            break;
        case 5:
            xpamount = 150;
            break;
        case 6:
        case 7:
            xpamount = 200;
            break;
        case 8:
            xpamount = 250;
            break;
        case 9:
            xpamount = 300;
            break;
        case 10:
        case 11:
            xpamount = 350;
            break;
        case 12:
        case 13:
        case 14:
        case 15:
            xpamount = 500;
            break;
    }
    
    return xpamount;
}

// Namespace killstreaks/killstreaks
// Params 0
// Checksum 0xf33280fb, Offset: 0x69c8
// Size: 0x94
function display_unavailable_time()
{
    timeleft = int( level.roundstartkillstreakdelay - globallogic_utils::gettimepassed() / 1000 );
    
    if ( timeleft <= 0 )
    {
        timeleft = 1;
    }
    
    self iprintlnbold( &"MP_UNAVAILABLE_FOR_N", " " + timeleft + " ", &"EXE_SECONDS" );
}

// Namespace killstreaks/killstreaks
// Params 2
// Checksum 0x87a20d4, Offset: 0x6a68
// Size: 0x1d8, Type: bool
function trigger_killstreak( killstreaktype, isfrominventory )
{
    assert( isdefined( level.killstreaks[ killstreaktype ].usefunction ), "No use function defined for killstreak " + killstreaktype );
    self.usingkillstreakfrominventory = isfrominventory;
    
    if ( level.infinalkillcam )
    {
        return false;
    }
    
    if ( should_delay_killstreak( killstreaktype ) )
    {
        display_unavailable_time();
    }
    else if ( [[ level.killstreaks[ killstreaktype ].usefunction ]]( killstreaktype ) )
    {
        if ( isdefined( self ) )
        {
            if ( !isdefined( self.pers[ level.killstreaks[ killstreaktype ].usagekey ] ) )
            {
                self.pers[ level.killstreaks[ killstreaktype ].usagekey ] = 0;
            }
            
            self.pers[ level.killstreaks[ killstreaktype ].usagekey ]++;
            self notify( #"killstreak_used", killstreaktype );
            self notify( #"killstreak_done", { #is_successful:1, #type:killstreaktype } );
        }
        
        self.usingkillstreakfrominventory = undefined;
        return true;
    }
    
    self.usingkillstreakfrominventory = undefined;
    
    if ( isdefined( self ) )
    {
        self notify( #"killstreak_done", { #is_successful:0, #type:killstreaktype } );
    }
    
    return false;
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0xd77efbe2, Offset: 0x6c48
// Size: 0x4a
function add_to_killstreak_count( weapon )
{
    if ( !isdefined( self.pers[ "totalKillstreakCount" ] ) )
    {
        self.pers[ "totalKillstreakCount" ] = 0;
    }
    
    self.pers[ "totalKillstreakCount" ]++;
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0xb88dcc6b, Offset: 0x6ca0
// Size: 0xf2
function get_first_valid_killstreak_alt_weapon( killstreaktype )
{
    assert( isdefined( level.killstreaks[ killstreaktype ] ), "Killstreak not registered." );
    
    if ( isdefined( level.killstreaks[ killstreaktype ].altweapons ) )
    {
        for ( i = 0; i < level.killstreaks[ killstreaktype ].altweapons.size ; i++ )
        {
            if ( isdefined( level.killstreaks[ killstreaktype ].altweapons[ i ] ) )
            {
                return level.killstreaks[ killstreaktype ].altweapons[ i ];
            }
        }
    }
    
    return level.weaponnone;
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0xa07f0e57, Offset: 0x6da0
// Size: 0x5e, Type: bool
function should_give_killstreak( weapon )
{
    killstreakbuilding = getdvarint( "scr_allow_killstreak_building" );
    
    if ( killstreakbuilding == 0 )
    {
        if ( is_weapon_associated_with_killstreak( weapon ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace killstreaks/killstreaks
// Params 3
// Checksum 0x69383b8d, Offset: 0x6e08
// Size: 0x42, Type: bool
function point_is_in_danger_area( point, targetpos, radius )
{
    return distance2d( point, targetpos ) <= radius * 1.25;
}

// Namespace killstreaks/killstreaks
// Params 5
// Checksum 0xd55a0aad, Offset: 0x6e58
// Size: 0x2f4
function print_killstreak_start_text( killstreaktype, owner, team, targetpos, dangerradius )
{
    if ( !isdefined( level.killstreaks[ killstreaktype ] ) )
    {
        return;
    }
    
    if ( level.teambased )
    {
        players = level.players;
        
        if ( !level.hardcoremode && isdefined( level.killstreaks[ killstreaktype ].inboundnearplayertext ) )
        {
            for ( i = 0; i < players.size ; i++ )
            {
                if ( isalive( players[ i ] ) && isdefined( players[ i ].pers[ "team" ] ) && players[ i ].pers[ "team" ] == team )
                {
                    if ( point_is_in_danger_area( players[ i ].origin, targetpos, dangerradius ) )
                    {
                        players[ i ] iprintlnbold( level.killstreaks[ killstreaktype ].inboundnearplayertext );
                    }
                }
            }
        }
        
        if ( isdefined( level.killstreaks[ killstreaktype ] ) )
        {
            for ( i = 0; i < level.players.size ; i++ )
            {
                player = level.players[ i ];
                playerteam = player.pers[ "team" ];
                
                if ( isdefined( playerteam ) )
                {
                    if ( playerteam == team )
                    {
                        player iprintln( level.killstreaks[ killstreaktype ].inboundtext, owner );
                    }
                }
            }
        }
        
        return;
    }
    
    if ( !level.hardcoremode && isdefined( level.killstreaks[ killstreaktype ].inboundnearplayertext ) )
    {
        if ( point_is_in_danger_area( owner.origin, targetpos, dangerradius ) )
        {
            owner iprintlnbold( level.killstreaks[ killstreaktype ].inboundnearplayertext );
        }
    }
}

// Namespace killstreaks/killstreaks
// Params 2
// Checksum 0x7f877b01, Offset: 0x7158
// Size: 0x64
function play_killstreak_firewall_being_hacked_dialog( killstreaktype, killstreakid )
{
    if ( self globallogic_audio::killstreak_dialog_queued( "firewallBeingHacked", killstreaktype, killstreakid ) )
    {
        return;
    }
    
    self globallogic_audio::play_taacom_dialog( "firewallBeingHacked", killstreaktype, killstreakid );
}

// Namespace killstreaks/killstreaks
// Params 2
// Checksum 0x70bc4ba3, Offset: 0x71c8
// Size: 0x64
function play_killstreak_firewall_hacked_dialog( killstreaktype, killstreakid )
{
    if ( self globallogic_audio::killstreak_dialog_queued( "firewallHacked", killstreaktype, killstreakid ) )
    {
        return;
    }
    
    self globallogic_audio::play_taacom_dialog( "firewallHacked", killstreaktype, killstreakid );
}

// Namespace killstreaks/killstreaks
// Params 2
// Checksum 0xaaa8ecaa, Offset: 0x7238
// Size: 0x64
function play_killstreak_being_hacked_dialog( killstreaktype, killstreakid )
{
    if ( self globallogic_audio::killstreak_dialog_queued( "beingHacked", killstreaktype, killstreakid ) )
    {
        return;
    }
    
    self globallogic_audio::play_taacom_dialog( "beingHacked", killstreaktype, killstreakid );
}

// Namespace killstreaks/killstreaks
// Params 3
// Checksum 0x219a6f70, Offset: 0x72a8
// Size: 0x164
function play_killstreak_hacked_dialog( killstreaktype, killstreakid, hacker )
{
    self globallogic_audio::flush_killstreak_dialog_on_player( killstreakid );
    self globallogic_audio::play_taacom_dialog( "hacked", killstreaktype );
    excludeself = [];
    excludeself[ 0 ] = self;
    
    if ( level.teambased )
    {
        globallogic_audio::leader_dialog( level.killstreaks[ killstreaktype ].hackeddialogkey, self.team, excludeself );
        globallogic_audio::leader_dialog_for_other_teams( level.killstreaks[ killstreaktype ].hackedstartdialogkey, self.team, undefined, killstreakid );
        return;
    }
    
    self globallogic_audio::leader_dialog_on_player( level.killstreaks[ killstreaktype ].hackeddialogkey );
    hacker globallogic_audio::leader_dialog_on_player( level.killstreaks[ killstreaktype ].hackedstartdialogkey );
}

// Namespace killstreaks/killstreaks
// Params 3
// Checksum 0xc9f613a8, Offset: 0x7418
// Size: 0x1a4
function play_killstreak_start_dialog( killstreaktype, team, killstreakid )
{
    if ( !isdefined( killstreaktype ) || !isdefined( killstreakid ) )
    {
        return;
    }
    
    self notify( "killstreak_start_" + killstreaktype );
    self notify( "killstreak_start_inventory_" + killstreaktype );
    dialogkey = level.killstreaks[ killstreaktype ].requestdialogkey;
    
    if ( !isdefined( self.currentkillstreakdialog ) && isdefined( dialogkey ) && isdefined( level.heroplaydialog ) )
    {
        self thread [[ level.heroplaydialog ]]( dialogkey );
    }
    
    excludeself = [];
    excludeself[ 0 ] = self;
    
    if ( level.teambased )
    {
        globallogic_audio::leader_dialog( level.killstreaks[ killstreaktype ].startdialogkey, team, excludeself, undefined, killstreakid );
        globallogic_audio::leader_dialog_for_other_teams( level.killstreaks[ killstreaktype ].enemystartdialogkey, team, undefined, killstreakid );
        return;
    }
    
    globallogic_audio::leader_dialog( level.killstreaks[ killstreaktype ].enemystartdialogkey, undefined, excludeself, undefined, killstreakid );
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0x6bab5855, Offset: 0x75c8
// Size: 0x6c
function play_killstreak_ready_sfx( killstreaktype )
{
    if ( !isdefined( level.gameended ) || !level.gameended )
    {
        ready_sfx_alias = "mpl_killstreak_" + killstreaktype;
        
        if ( isdefined( ready_sfx_alias ) )
        {
            self playsoundtoplayer( ready_sfx_alias, self );
        }
    }
}

// Namespace killstreaks/killstreaks
// Params 2
// Checksum 0x33be5047, Offset: 0x7640
// Size: 0xe4
function play_killstreak_ready_dialog( killstreaktype, taacomwaittime )
{
    self notify( "killstreak_ready_" + killstreaktype );
    self endon( #"death" );
    self endon( "killstreak_start_" + killstreaktype );
    self endon( "killstreak_ready_" + killstreaktype );
    level endon( #"game_ended" );
    
    if ( isdefined( level.gameended ) && level.gameended )
    {
        return;
    }
    
    if ( globallogic_audio::killstreak_dialog_queued( "ready", killstreaktype ) )
    {
        return;
    }
    
    if ( isdefined( taacomwaittime ) )
    {
        wait taacomwaittime;
    }
    
    self globallogic_audio::play_taacom_dialog( "ready", killstreaktype );
}

// Namespace killstreaks/killstreaks
// Params 2
// Checksum 0x998e08b0, Offset: 0x7730
// Size: 0x9c
function play_destroyed_dialog_on_owner( killstreaktype, killstreakid )
{
    if ( !isdefined( self.owner ) || !isdefined( self.team ) || self.team != self.owner.team )
    {
        return;
    }
    
    self.owner globallogic_audio::flush_killstreak_dialog_on_player( killstreakid );
    self.owner globallogic_audio::play_taacom_dialog( "destroyed", killstreaktype );
}

// Namespace killstreaks/killstreaks
// Params 3
// Checksum 0x6a28de06, Offset: 0x77d8
// Size: 0x84
function play_taacom_dialog_on_owner( dialogkey, killstreaktype, killstreakid )
{
    if ( !isdefined( self.owner ) || !isdefined( self.team ) || self.team != self.owner.team )
    {
        return;
    }
    
    self.owner globallogic_audio::play_taacom_dialog( dialogkey, killstreaktype, killstreakid );
}

// Namespace killstreaks/killstreaks
// Params 3
// Checksum 0x81868f12, Offset: 0x7868
// Size: 0xa4
function play_pilot_dialog_on_owner( dialogkey, killstreaktype, killstreakid )
{
    if ( !isdefined( self.owner ) || !isdefined( self.owner.team ) || !isdefined( self.team ) || self.team != self.owner.team )
    {
        return;
    }
    
    self.owner play_pilot_dialog( dialogkey, killstreaktype, killstreakid, self.pilotindex );
}

// Namespace killstreaks/killstreaks
// Params 4
// Checksum 0xcefc021d, Offset: 0x7918
// Size: 0x64
function play_pilot_dialog( dialogkey, killstreaktype, killstreakid, pilotindex )
{
    if ( !isdefined( killstreaktype ) || !isdefined( pilotindex ) )
    {
        return;
    }
    
    self globallogic_audio::killstreak_dialog_on_player( dialogkey, killstreaktype, killstreakid, pilotindex );
}

// Namespace killstreaks/killstreaks
// Params 3
// Checksum 0x58ed0e8a, Offset: 0x7988
// Size: 0xcc
function play_taacom_dialog_response_on_owner( dialogkey, killstreaktype, killstreakid )
{
    assert( isdefined( dialogkey ) );
    assert( isdefined( killstreaktype ) );
    
    if ( !isdefined( self.owner ) || !isdefined( self.team ) || self.team != self.owner.team )
    {
        return;
    }
    
    self.owner play_taacom_dialog_response( dialogkey, killstreaktype, killstreakid, self.pilotindex );
}

// Namespace killstreaks/killstreaks
// Params 4
// Checksum 0x6780cf71, Offset: 0x7a60
// Size: 0x94
function play_taacom_dialog_response( dialogkey, killstreaktype, killstreakid, pilotindex )
{
    assert( isdefined( dialogkey ) );
    assert( isdefined( killstreaktype ) );
    
    if ( !isdefined( pilotindex ) )
    {
        return;
    }
    
    self globallogic_audio::play_taacom_dialog( dialogkey + pilotindex, killstreaktype, killstreakid );
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0x5a53c3a7, Offset: 0x7b00
// Size: 0xaa
function get_random_pilot_index( killstreaktype )
{
    if ( !isdefined( killstreaktype ) )
    {
        return undefined;
    }
    
    taacombundle = get_mpdialog_tacom_bundle( self.pers[ "mptaacom" ] );
    
    if ( !isdefined( taacombundle.pilotbundles[ killstreaktype ] ) )
    {
        return undefined;
    }
    
    numpilots = taacombundle.pilotbundles[ killstreaktype ].size;
    
    if ( numpilots <= 0 )
    {
        return undefined;
    }
    
    return randomint( numpilots );
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0x480ad899, Offset: 0x7bb8
// Size: 0x318
function player_killstreak_threat_tracking( killstreaktype )
{
    assert( isdefined( killstreaktype ) );
    self endon( #"death" );
    self endon( #"delete" );
    self endon( #"leaving" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( !isdefined( self.owner ) )
        {
            return;
        }
        
        players = self.owner battlechatter::get_enemy_players();
        players = array::randomize( players );
        
        foreach ( player in players )
        {
            if ( !player battlechatter::can_play_dialog( 1 ) )
            {
                continue;
            }
            
            lookangles = player getplayerangles();
            
            if ( lookangles[ 0 ] < 270 || lookangles[ 0 ] > 330 )
            {
                continue;
            }
            
            lookdir = anglestoforward( lookangles );
            eyepoint = player geteye();
            streakdir = vectornormalize( self.origin - eyepoint );
            dot = vectordot( streakdir, lookdir );
            
            if ( dot < 0.94 )
            {
                continue;
            }
            
            traceresult = bullettrace( eyepoint, self.origin, 1, player );
            
            if ( traceresult[ "fraction" ] >= 1 || traceresult[ "entity" ] === self )
            {
                if ( battlechatter::dialog_chance( "killstreakSpotChance" ) )
                {
                    player battlechatter::play_killstreak_threat( killstreaktype );
                }
                
                wait battlechatter::mpdialog_value( "killstreakSpotDelay", 0 );
                break;
            }
        }
        
        wait battlechatter::mpdialog_value( "killstreakSpotInterval", 0.05 );
    }
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0x8fd65446, Offset: 0x7ed8
// Size: 0x4e
function get_killstreak_inform_dialog( killstreaktype )
{
    if ( isdefined( level.killstreaks[ killstreaktype ].informdialog ) )
    {
        return level.killstreaks[ killstreaktype ].informdialog;
    }
    
    return "";
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0xeff0f820, Offset: 0x7f30
// Size: 0x6a
function get_killstreak_usage_by_killstreak( killstreaktype )
{
    assert( isdefined( level.killstreaks[ killstreaktype ] ), "Killstreak needs to be registered before calling get_killstreak_usage." );
    return get_killstreak_usage( level.killstreaks[ killstreaktype ].usagekey );
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0x817b464c, Offset: 0x7fa8
// Size: 0x34
function get_killstreak_usage( usagekey )
{
    if ( !isdefined( self.pers[ usagekey ] ) )
    {
        return 0;
    }
    
    return self.pers[ usagekey ];
}

// Namespace killstreaks/killstreaks
// Params 0
// Checksum 0x9baa79cf, Offset: 0x7fe8
// Size: 0x16c
function on_player_spawned()
{
    self endon( #"disconnect" );
    pixbeginevent( "_killstreaks.gsc/onPlayerSpawned" );
    give_owned();
    
    if ( !isdefined( self.pers[ "killstreaks" ] ) )
    {
        self.pers[ "killstreaks" ] = [];
    }
    
    if ( !isdefined( self.pers[ "killstreak_has_been_used" ] ) )
    {
        self.pers[ "killstreak_has_been_used" ] = [];
    }
    
    if ( !isdefined( self.pers[ "killstreak_unique_id" ] ) )
    {
        self.pers[ "killstreak_unique_id" ] = [];
    }
    
    if ( !isdefined( self.pers[ "killstreak_ammo_count" ] ) )
    {
        self.pers[ "killstreak_ammo_count" ] = [];
    }
    
    size = self.pers[ "killstreaks" ].size;
    
    if ( size > 0 )
    {
        self thread play_killstreak_ready_dialog( self.pers[ "killstreaks" ][ size - 1 ] );
    }
    
    self.killcamkilledbyent = undefined;
    pixendevent();
}

// Namespace killstreaks/killstreaks
// Params 0
// Checksum 0xf0a42bce, Offset: 0x8160
// Size: 0x136
function on_joined_team()
{
    self endon( #"disconnect" );
    self setinventoryweapon( level.weaponnone );
    self.pers[ "cur_kill_streak" ] = 0;
    self.pers[ "cur_total_kill_streak" ] = 0;
    self setplayercurrentstreak( 0 );
    self.pers[ "totalKillstreakCount" ] = 0;
    self.pers[ "killstreaks" ] = [];
    self.pers[ "killstreak_has_been_used" ] = [];
    self.pers[ "killstreak_unique_id" ] = [];
    self.pers[ "killstreak_ammo_count" ] = [];
    
    if ( isdefined( level.usingscorestreaks ) && level.usingscorestreaks )
    {
        self.pers[ "killstreak_quantity" ] = [];
        self.pers[ "held_killstreak_ammo_count" ] = [];
        self.pers[ "held_killstreak_clip_count" ] = [];
    }
}

// Namespace killstreaks/killstreaks
// Params 0
// Checksum 0xf2778a82, Offset: 0x82a0
// Size: 0x34
function on_player_connect()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self thread killstreakspawnprotection();
}

// Namespace killstreaks/killstreaks
// Params 0
// Checksum 0xc9d27b87, Offset: 0x82e0
// Size: 0x48
function killstreakspawnprotection()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    for ( ;; )
    {
        self waittill( "spawned_player" );
        self thread initialspawnprotection();
    }
}

// Namespace killstreaks/killstreaks
// Params 0, eflags: 0x4
// Checksum 0x89c5f42f, Offset: 0x8330
// Size: 0x114
function private initialspawnprotection()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self thread airsupport::monitorspeed( level.spawnprotectiontime );
    
    if ( !isdefined( level.spawnprotectiontime ) || level.spawnprotectiontime == 0 )
    {
        return;
    }
    
    self.specialty_nottargetedbyairsupport = 1;
    self clientfield::set( "killstreak_spawn_protection", 1 );
    self val::set( "killstreak_spawn_protection", "ignoreme", 1 );
    wait level.spawnprotectiontime;
    self clientfield::set( "killstreak_spawn_protection", 0 );
    self.specialty_nottargetedbyairsupport = undefined;
    self val::reset( "killstreak_spawn_protection", "ignoreme" );
}

// Namespace killstreaks/killstreaks
// Params 2
// Checksum 0x3b8ecdc3, Offset: 0x8450
// Size: 0x88
function init_ride_killstreak( streak, always_allow )
{
    if ( !isdefined( always_allow ) )
    {
        always_allow = 0;
    }
    
    self disableusability();
    result = self init_ride_killstreak_internal( streak, always_allow );
    
    if ( isdefined( self ) )
    {
        self enableusability();
    }
    
    return result;
}

// Namespace killstreaks/killstreaks
// Params 0
// Checksum 0x521ca854, Offset: 0x84e0
// Size: 0x50
function watch_for_remove_remote_weapon()
{
    self endon( #"endwatchforremoveremoteweapon" );
    
    for ( ;; )
    {
        self waittill( "remove_remote_weapon" );
        self switch_to_last_non_killstreak_weapon();
        self enableusability();
    }
}

// Namespace killstreaks/killstreaks
// Params 2
// Checksum 0xf2453014, Offset: 0x8538
// Size: 0x408
function init_ride_killstreak_internal( streak, always_allow )
{
    if ( streak == "qrdrone" || streak == "dart" || streak == "killstreak_remote_turret" || streak == "killstreak_ai_tank" || streak == "qrdrone" || isdefined( streak ) && streak == "sentinel" )
    {
        laptopwait = "timeout";
    }
    else
    {
        laptopwait = self waittilltimeout( 0.6, "disconnect", "death", "weapon_switch_started" );
        laptopwait = laptopwait._notify;
    }
    
    hostmigration::waittillhostmigrationdone();
    
    if ( laptopwait == "weapon_switch_started" )
    {
        return "fail";
    }
    
    if ( !isalive( self ) && !always_allow )
    {
        return "fail";
    }
    
    if ( laptopwait == "disconnect" || laptopwait == "death" )
    {
        if ( laptopwait == "disconnect" )
        {
            return "disconnect";
        }
        
        if ( self.team == "spectator" )
        {
            return "fail";
        }
        
        return "success";
    }
    
    if ( self isempjammed() && !( isdefined( self.ignoreempjammed ) && self.ignoreempjammed ) )
    {
        return "fail";
    }
    
    if ( self is_interacting_with_object() )
    {
        return "fail";
    }
    
    self thread hud::fade_to_black_for_x_sec( 0, 0.2, 0.4, 0.25 );
    self thread watch_for_remove_remote_weapon();
    blackoutwait = self waittilltimeout( 0.6, "disconnect", "death" );
    self notify( #"endwatchforremoveremoteweapon" );
    hostmigration::waittillhostmigrationdone();
    
    if ( blackoutwait._notify != "disconnect" )
    {
        self thread clear_ride_intro( 1 );
        
        if ( self.team == "spectator" )
        {
            return "fail";
        }
    }
    
    if ( always_allow )
    {
        if ( blackoutwait._notify == "disconnect" )
        {
            return "disconnect";
        }
        else
        {
            return "success";
        }
    }
    
    if ( self isonladder() )
    {
        return "fail";
    }
    
    if ( !isalive( self ) )
    {
        return "fail";
    }
    
    if ( self isempjammed() && !( isdefined( self.ignoreempjammed ) && self.ignoreempjammed ) )
    {
        return "fail";
    }
    
    if ( isdefined( self.laststand ) && self.laststand )
    {
        return "fail";
    }
    
    if ( self is_interacting_with_object() )
    {
        return "fail";
    }
    
    if ( blackoutwait._notify == "disconnect" )
    {
        return "disconnect";
    }
    
    return "success";
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0x2ceaffbe, Offset: 0x8948
// Size: 0x3c
function clear_ride_intro( delay )
{
    self endon( #"disconnect" );
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    self thread hud::screen_fade_in( 0 );
}

/#

    // Namespace killstreaks/killstreaks
    // Params 0
    // Checksum 0xfba0dd63, Offset: 0x8990
    // Size: 0xc0, Type: dev
    function killstreak_debug_think()
    {
        setdvar( "debug_killstreak", "" );
        
        for ( ;; )
        {
            cmd = getdvarstring( "debug_killstreak" );
            
            switch ( cmd )
            {
                case #"data_dump":
                    killstreak_data_dump();
                    break;
            }
            
            if ( cmd != "" )
            {
                setdvar( "debug_killstreak", "" );
            }
            
            wait 0.5;
        }
    }

    // Namespace killstreaks/killstreaks
    // Params 0
    // Checksum 0x316b59c, Offset: 0x8a58
    // Size: 0x37c, Type: dev
    function killstreak_data_dump()
    {
        iprintln( "Killstreak Data Sent to Console" );
        println( "##### Killstreak Data #####" );
        println( "killstreak,killstreaklevel,weapon,altweapon1,altweapon2,altweapon3,altweapon4,type1,type2,type3,type4" );
        keys = getarraykeys( level.killstreaks );
        
        for ( i = 0; i < keys.size ; i++ )
        {
            data = level.killstreaks[ keys[ i ] ];
            type_data = level.killstreaktype[ keys[ i ] ];
            print( keys[ i ] + "," );
            print( data.killstreaklevel + "," );
            print( data.weapon.name + "," );
            alt = 0;
            
            if ( isdefined( data.altweapons ) )
            {
                assert( data.altweapons.size <= 4 );
                
                for ( alt = 0; alt < data.altweapons.size ; alt++ )
                {
                    print( data.altweapons[ alt ].name + "," );
                }
            }
            
            while ( alt < 4 )
            {
                print( "," );
                alt++;
            }
            
            type = 0;
            
            if ( isdefined( type_data ) )
            {
                assert( type_data.size < 4 );
                type_keys = getarraykeys( type_data );
                
                while ( type < type_keys.size )
                {
                    if ( type_data[ type_keys[ type ] ] == 1 )
                    {
                        print( type_keys[ type ] + "," );
                    }
                    
                    type++;
                }
            }
            
            while ( type < 4 )
            {
                print( "," );
                type++;
            }
            
            println( "" );
        }
        
        println( "##### End Killstreak Data #####" );
    }

#/

// Namespace killstreaks/killstreaks
// Params 0
// Checksum 0xc0c0c132, Offset: 0x8de0
// Size: 0x6e, Type: bool
function is_interacting_with_object()
{
    if ( self iscarryingturret() )
    {
        return true;
    }
    
    if ( isdefined( self.isplanting ) && self.isplanting )
    {
        return true;
    }
    
    if ( isdefined( self.isdefusing ) && self.isdefusing )
    {
        return true;
    }
    
    return false;
}

// Namespace killstreaks/killstreaks
// Params 2
// Checksum 0xd9d6de7a, Offset: 0x8e58
// Size: 0x174
function clear_using_remote( immediate, skipnotify )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.dofutz = 0;
    self.no_fade2black = 0;
    self clientfield::set_to_player( "static_postfx", 0 );
    
    if ( isdefined( self.carryicon ) )
    {
        self.carryicon.alpha = 1;
    }
    
    self.usingremote = undefined;
    self reset_killstreak_delay_killcam();
    self enableoffhandweapons();
    self enableweaponcycling();
    curweapon = self getcurrentweapon();
    
    if ( isalive( self ) )
    {
        self switch_to_last_non_killstreak_weapon( immediate );
    }
    
    if ( !level.gameended )
    {
        self util::freeze_player_controls( 0 );
    }
    
    if ( !( isdefined( skipnotify ) && skipnotify ) )
    {
        self notify( #"stopped_using_remote" );
    }
    
    thread hide_tablet();
}

// Namespace killstreaks/killstreaks
// Params 0
// Checksum 0x2574169f, Offset: 0x8fd8
// Size: 0x34
function hide_tablet()
{
    self endon( #"disconnect" );
    wait 0.2;
    self clientfield::set_player_uimodel( "hudItems.remoteKillstreakActivated", 0 );
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0x8bcd1258, Offset: 0x9018
// Size: 0x1c
function set_killstreak_delay_killcam( killstreak_name )
{
    self.killstreak_delay_killcam = killstreak_name;
}

// Namespace killstreaks/killstreaks
// Params 0
// Checksum 0x102e5d3c, Offset: 0x9040
// Size: 0xe
function reset_killstreak_delay_killcam()
{
    self.killstreak_delay_killcam = undefined;
}

// Namespace killstreaks/killstreaks
// Params 0
// Checksum 0xec5db87c, Offset: 0x9058
// Size: 0x24
function hide_compass()
{
    self clientfield::set( "killstreak_hides_compass", 1 );
}

// Namespace killstreaks/killstreaks
// Params 0
// Checksum 0xa39873ba, Offset: 0x9088
// Size: 0x24
function unhide_compass()
{
    self clientfield::set( "killstreak_hides_compass", 0 );
}

// Namespace killstreaks/killstreaks
// Params 3
// Checksum 0x9ff58fbc, Offset: 0x90b8
// Size: 0x118
function setup_health( killstreak_ref, max_health, low_health )
{
    self.maxhealth = max_health;
    self.lowhealth = low_health;
    self.hackedhealthupdatecallback = &defaulthackedhealthupdatecallback;
    tablemaxhealth = killstreak_bundles::get_max_health( killstreak_ref );
    
    if ( isdefined( tablemaxhealth ) )
    {
        self.maxhealth = tablemaxhealth;
    }
    
    tablelowhealth = killstreak_bundles::get_low_health( killstreak_ref );
    
    if ( isdefined( tablelowhealth ) )
    {
        self.lowhealth = tablelowhealth;
    }
    
    tablehackedhealth = killstreak_bundles::get_hacked_health( killstreak_ref );
    
    if ( isdefined( tablehackedhealth ) )
    {
        self.hackedhealth = tablehackedhealth;
        return;
    }
    
    self.hackedhealth = self.maxhealth;
}

// Namespace killstreaks/killstreaks
// Params 8
// Checksum 0xb18f10cb, Offset: 0x91d8
// Size: 0x7c4
function monitordamage( killstreak_ref, max_health, destroyed_callback, low_health, low_health_callback, emp_damage, emp_callback, allow_bullet_damage )
{
    self endon( #"death" );
    self endon( #"delete" );
    self.health = 9999999;
    self.damagetaken = 0;
    self setup_health( killstreak_ref, max_health, low_health );
    assert( !isvehicle( self ) || !issentient( self ), "MonitorDamage should not be called on a sentient vehicle. For sentient vehicles, use overrideVehicleDamage instead." );
    
    while ( true )
    {
        weapon_damage = undefined;
        waitresult = self waittill( "damage" );
        attacker = waitresult.attacker;
        damage = waitresult.amount;
        direction = waitresult.direction;
        point = waitresult.position;
        type = waitresult.mod;
        tagname = waitresult.tag_name;
        modelname = waitresult.model_name;
        partname = waitresult.part_name;
        weapon = waitresult.weapon;
        flags = waitresult.flags;
        inflictor = waitresult.inflictor;
        chargelevel = waitresult.charge_level;
        
        if ( isdefined( self.invulnerable ) && self.invulnerable )
        {
            continue;
        }
        
        if ( !isdefined( attacker ) || !isplayer( attacker ) )
        {
            continue;
        }
        
        friendlyfire = weaponobjects::friendlyfirecheck( self.owner, attacker );
        
        if ( !friendlyfire )
        {
            continue;
        }
        
        if ( isdefined( self.owner ) && attacker == self.owner )
        {
            continue;
        }
        
        isvalidattacker = 1;
        
        if ( level.teambased )
        {
            isvalidattacker = isdefined( attacker.team ) && attacker.team != self.team;
        }
        
        if ( !isvalidattacker )
        {
            continue;
        }
        
        if ( isdefined( self.killstreakdamagemodifier ) )
        {
            damage = [[ self.killstreakdamagemodifier ]]( damage, attacker, direction, point, type, tagname, modelname, partname, weapon, flags, inflictor, chargelevel );
            
            if ( damage <= 0 )
            {
                continue;
            }
        }
        
        if ( weapon.isemp && type == "MOD_GRENADE_SPLASH" )
        {
            emp_damage_to_apply = killstreak_bundles::get_emp_grenade_damage( killstreak_ref, self.maxhealth );
            
            if ( !isdefined( emp_damage_to_apply ) )
            {
                emp_damage_to_apply = isdefined( emp_damage ) ? emp_damage : 1;
            }
            
            if ( isdefined( emp_callback ) && emp_damage_to_apply > 0 )
            {
                self [[ emp_callback ]]( attacker );
            }
            
            weapon_damage = emp_damage_to_apply;
        }
        
        if ( isdefined( self.selfdestruct ) && self.selfdestruct )
        {
            weapon_damage = self.maxhealth + 1;
        }
        
        if ( !isdefined( weapon_damage ) )
        {
            weapon_damage = killstreak_bundles::get_weapon_damage( killstreak_ref, self.maxhealth, attacker, weapon, type, damage, flags, chargelevel );
            
            if ( !isdefined( weapon_damage ) )
            {
                weapon_damage = get_old_damage( attacker, weapon, type, damage, allow_bullet_damage );
            }
        }
        
        if ( weapon_damage > 0 )
        {
            if ( damagefeedback::dodamagefeedback( weapon, attacker ) )
            {
                attacker thread damagefeedback::update( type );
            }
            
            self challenges::trackassists( attacker, weapon_damage, 0 );
        }
        
        self.damagetaken += weapon_damage;
        
        if ( !issentient( self ) && weapon_damage > 0 )
        {
            self.attacker = attacker;
        }
        
        if ( self.damagetaken > self.maxhealth )
        {
            weaponstatname = "destroyed";
            
            switch ( weapon.name )
            {
                case #"auto_tow":
                case #"tow_turret":
                case #"tow_turret_drop":
                    weaponstatname = "kills";
                    break;
            }
            
            level.globalkillstreaksdestroyed++;
            attacker addweaponstat( getweapon( killstreak_ref ), "destroyed", 1 );
            
            if ( isdefined( destroyed_callback ) )
            {
                self thread [[ destroyed_callback ]]( attacker, weapon );
            }
            
            return;
        }
        
        remaining_health = max_health - self.damagetaken;
        
        if ( remaining_health < low_health && weapon_damage > 0 )
        {
            if ( !isdefined( self.currentstate ) || isdefined( low_health_callback ) && self.currentstate != "damaged" )
            {
                self [[ low_health_callback ]]( attacker, weapon );
            }
            
            self.currentstate = "damaged";
        }
        
        if ( isdefined( self.extra_low_health ) && remaining_health < self.extra_low_health && weapon_damage > 0 )
        {
            if ( isdefined( self.extra_low_health_callback ) && !isdefined( self.extra_low_damage_notified ) )
            {
                self [[ self.extra_low_health_callback ]]( attacker, weapon );
                self.extra_low_damage_notified = 1;
            }
        }
    }
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0xe85d1d97, Offset: 0x99a8
// Size: 0xc0
function defaulthackedhealthupdatecallback( hacker )
{
    killstreak = self;
    assert( isdefined( self.maxhealth ) );
    assert( isdefined( self.hackedhealth ) );
    assert( isdefined( self.damagetaken ) );
    damageafterhacking = self.maxhealth - self.hackedhealth;
    
    if ( self.damagetaken < damageafterhacking )
    {
        self.damagetaken = damageafterhacking;
    }
}

// Namespace killstreaks/killstreaks
// Params 14
// Checksum 0xd3dfc6dc, Offset: 0x9a70
// Size: 0x388
function ondamageperweapon( killstreak_ref, attacker, damage, flags, type, weapon, max_health, destroyed_callback, low_health, low_health_callback, emp_damage, emp_callback, allow_bullet_damage, chargelevel )
{
    self.maxhealth = max_health;
    self.lowhealth = low_health;
    tablehealth = killstreak_bundles::get_max_health( killstreak_ref );
    
    if ( isdefined( tablehealth ) )
    {
        self.maxhealth = tablehealth;
    }
    
    tablehealth = killstreak_bundles::get_low_health( killstreak_ref );
    
    if ( isdefined( tablehealth ) )
    {
        self.lowhealth = tablehealth;
    }
    
    if ( isdefined( self.invulnerable ) && self.invulnerable )
    {
        return 0;
    }
    
    if ( !isdefined( attacker ) || !isplayer( attacker ) )
    {
        return get_old_damage( attacker, weapon, type, damage, allow_bullet_damage );
    }
    
    friendlyfire = weaponobjects::friendlyfirecheck( self.owner, attacker );
    
    if ( !friendlyfire )
    {
        return 0;
    }
    
    isvalidattacker = 1;
    
    if ( level.teambased )
    {
        isvalidattacker = isdefined( attacker.team ) && attacker.team != self.team;
    }
    
    if ( !isvalidattacker )
    {
        return 0;
    }
    
    if ( weapon.isemp && type == "MOD_GRENADE_SPLASH" )
    {
        emp_damage_to_apply = killstreak_bundles::get_emp_grenade_damage( killstreak_ref, self.maxhealth );
        
        if ( !isdefined( emp_damage_to_apply ) )
        {
            emp_damage_to_apply = isdefined( emp_damage ) ? emp_damage : 1;
        }
        
        if ( isdefined( emp_callback ) && emp_damage_to_apply > 0 )
        {
            self [[ emp_callback ]]( attacker, weapon );
        }
        
        return emp_damage_to_apply;
    }
    
    weapon_damage = killstreak_bundles::get_weapon_damage( killstreak_ref, self.maxhealth, attacker, weapon, type, damage, flags, chargelevel );
    
    if ( !isdefined( weapon_damage ) )
    {
        weapon_damage = get_old_damage( attacker, weapon, type, damage, allow_bullet_damage );
    }
    
    if ( weapon_damage <= 0 )
    {
        return 0;
    }
    
    idamage = int( weapon_damage );
    
    if ( idamage > self.health )
    {
        if ( isdefined( destroyed_callback ) )
        {
            self thread [[ destroyed_callback ]]( attacker, weapon );
        }
    }
    
    return idamage;
}

// Namespace killstreaks/killstreaks
// Params 5
// Checksum 0xcb58df9, Offset: 0x9e00
// Size: 0x1fa
function get_old_damage( attacker, weapon, type, damage, allow_bullet_damage )
{
    switch ( type )
    {
        case #"mod_pistol_bullet":
        case #"mod_rifle_bullet":
            if ( !allow_bullet_damage )
            {
                damage = 0;
                break;
            }
            
            if ( isdefined( attacker ) && isplayer( attacker ) )
            {
                hasfmj = attacker hasperk( "specialty_armorpiercing" );
            }
            
            if ( isdefined( hasfmj ) && hasfmj )
            {
                damage = int( damage * level.cac_armorpiercing_data );
            }
            
            break;
        case #"mod_explosive":
        case #"mod_projectile":
        case #"mod_projectile_splash":
            if ( weapon.statindex == level.weaponpistolenergy.statindex || weapon.statindex != level.weaponshotgunenergy.statindex || weapon.statindex == level.weaponspecialcrossbow.statindex )
            {
                break;
            }
            
            if ( isdefined( self.remotemissiledamage ) && isdefined( weapon ) && weapon.name == "remote_missile_missile" )
            {
                damage = self.remotemissiledamage;
            }
            else if ( isdefined( self.rocketdamage ) )
            {
                damage = self.rocketdamage;
            }
            
            break;
        default:
            break;
    }
    
    return damage;
}

// Namespace killstreaks/killstreaks
// Params 7
// Checksum 0x2605ac36, Offset: 0xa008
// Size: 0xdc
function configure_team( killstreaktype, killstreakid, owner, influencertype, configureteamprefunction, configureteampostfunction, ishacked )
{
    if ( !isdefined( ishacked ) )
    {
        ishacked = 0;
    }
    
    killstreak = self;
    killstreak.killstreaktype = killstreaktype;
    killstreak.killstreakid = killstreakid;
    killstreak _setup_configure_team_callbacks( influencertype, configureteamprefunction, configureteampostfunction );
    killstreak configure_team_internal( owner, ishacked );
    owner thread trackactivekillstreak( killstreak );
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0x65a26cdf, Offset: 0xa0f0
// Size: 0x8a
function trackactivekillstreak( killstreak )
{
    self endon( #"disconnect" );
    killstreakindex = killstreak.killstreakid;
    
    if ( isdefined( killstreakindex ) )
    {
        self.pers[ "activeKillstreaks" ][ killstreakindex ] = killstreak;
        killstreak waittill( "killstreak_hacked", "death" );
        self.pers[ "activeKillstreaks" ][ killstreakindex ] = undefined;
    }
}

// Namespace killstreaks/killstreaks
// Params 0
// Checksum 0xf1379e74, Offset: 0xa188
// Size: 0x14
function getactivekillstreaks()
{
    return self.pers[ "activeKillstreaks" ];
}

// Namespace killstreaks/killstreaks
// Params 2
// Checksum 0x6910e178, Offset: 0xa1a8
// Size: 0x258
function configure_team_internal( owner, ishacked )
{
    killstreak = self;
    
    if ( ishacked == 0 )
    {
        killstreak.originalowner = owner;
        killstreak.originalteam = owner.team;
        
        /#
            killstreak thread killstreak_hacking::killstreak_switch_team( owner );
        #/
    }
    else
    {
        assert( killstreak.killstreakteamconfigured, "configure_team must be called before a killstreak can be hacked" );
    }
    
    if ( isdefined( killstreak.killstreakconfigureteamprefunction ) )
    {
        killstreak thread [[ killstreak.killstreakconfigureteamprefunction ]]( owner, ishacked );
    }
    
    if ( isdefined( killstreak.killstreakinfluencertype ) )
    {
        killstreak influencers::remove_influencers();
    }
    
    killstreak setteam( owner.team );
    killstreak.team = owner.team;
    
    if ( !isai( killstreak ) )
    {
        killstreak setowner( owner );
    }
    
    killstreak.owner = owner;
    killstreak.ownerentnum = owner.entnum;
    killstreak.pilotindex = killstreak.owner get_random_pilot_index( killstreak.killstreaktype );
    
    if ( isdefined( killstreak.killstreakinfluencertype ) )
    {
        killstreak influencers::create_entity_enemy_influencer( killstreak.killstreakinfluencertype, owner.team );
    }
    
    if ( isdefined( killstreak.killstreakconfigureteampostfunction ) )
    {
        killstreak thread [[ killstreak.killstreakconfigureteampostfunction ]]( owner, ishacked );
    }
}

// Namespace killstreaks/killstreaks
// Params 3, eflags: 0x4
// Checksum 0x287f9436, Offset: 0xa408
// Size: 0x7c
function private _setup_configure_team_callbacks( influencertype, configureteamprefunction, configureteampostfunction )
{
    killstreak = self;
    killstreak.killstreakteamconfigured = 1;
    killstreak.killstreakinfluencertype = influencertype;
    killstreak.killstreakconfigureteamprefunction = configureteamprefunction;
    killstreak.killstreakconfigureteampostfunction = configureteampostfunction;
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0xe1321551, Offset: 0xa490
// Size: 0x9c
function watchteamchange( teamchangenotify )
{
    self notify( teamchangenotify + "_Singleton" );
    self endon( teamchangenotify + "_Singleton" );
    killstreak = self;
    killstreak endon( #"death" );
    killstreak endon( teamchangenotify );
    killstreak.owner waittill( "joined_team", "disconnect", "joined_spectators", "emp_jammed" );
    killstreak notify( teamchangenotify );
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0xec706219, Offset: 0xa538
// Size: 0xb6
function should_not_timeout( killstreak )
{
    /#
        assert( isdefined( killstreak ), "Can not register a killstreak without a valid type name." );
        assert( isdefined( level.killstreaks[ killstreak ] ), "Killstreak needs to be registered before calling register_dev_dvar." );
        
        if ( isdefined( level.killstreaks[ killstreak ].devtimeoutdvar ) )
        {
            return getdvarint( level.killstreaks[ killstreak ].devtimeoutdvar );
        }
    #/
    
    return 0;
}

// Namespace killstreaks/killstreaks
// Params 6
// Checksum 0xfd8c9be6, Offset: 0xa5f8
// Size: 0x190
function waitfortimeout( killstreak, duration, callback, endcondition1, endcondition2, endcondition3 )
{
    /#
        if ( should_not_timeout( killstreak ) )
        {
            return;
        }
    #/
    
    self endon( #"killstreak_hacked" );
    
    if ( isdefined( endcondition1 ) )
    {
        self endon( endcondition1 );
    }
    
    if ( isdefined( endcondition2 ) )
    {
        self endon( endcondition2 );
    }
    
    if ( isdefined( endcondition3 ) )
    {
        self endon( endcondition3 );
    }
    
    self thread waitfortimeouthacked( killstreak, callback, endcondition1, endcondition2, endcondition3 );
    killstreakbundle = level.killstreakbundle[ self.killstreaktype ];
    self.killstreakendtime = gettime() + duration;
    
    if ( isdefined( killstreakbundle ) && isdefined( killstreakbundle.kstimeoutbeepduration ) )
    {
        self waitfortimeoutbeep( killstreakbundle, duration );
    }
    else
    {
        hostmigration::migrationawarewait( duration );
    }
    
    self notify( #"kill_waitfortimeouthacked_thread" );
    self.killstreaktimedout = 1;
    self.killstreakendtime = 0;
    self notify( #"timed_out" );
    self [[ callback ]]();
}

// Namespace killstreaks/killstreaks
// Params 2
// Checksum 0x6f50d579, Offset: 0xa790
// Size: 0x19c
function waitfortimeoutbeep( killstreakbundle, duration )
{
    self endon( #"death" );
    beepduration = killstreakbundle.kstimeoutbeepduration * 1000;
    hostmigration::migrationawarewait( max( duration - beepduration, 0 ) );
    
    if ( isvehicle( self ) )
    {
        self clientfield::set( "timeout_beep", 1 );
    }
    
    if ( isdefined( killstreakbundle.kstimeoutfastbeepduration ) )
    {
        fastbeepduration = killstreakbundle.kstimeoutfastbeepduration * 1000;
        hostmigration::migrationawarewait( max( beepduration - fastbeepduration, 0 ) );
        
        if ( isvehicle( self ) )
        {
            self clientfield::set( "timeout_beep", 2 );
        }
        
        hostmigration::migrationawarewait( fastbeepduration );
    }
    
    if ( isvehicle( self ) )
    {
        self clientfield::set( "timeout_beep", 0 );
    }
}

// Namespace killstreaks/killstreaks
// Params 5
// Checksum 0x44acd029, Offset: 0xa938
// Size: 0xf4
function waitfortimeouthacked( killstreak, callback, endcondition1, endcondition2, endcondition3 )
{
    self endon( #"kill_waitfortimeouthacked_thread" );
    
    if ( isdefined( endcondition1 ) )
    {
        self endon( endcondition1 );
    }
    
    if ( isdefined( endcondition2 ) )
    {
        self endon( endcondition2 );
    }
    
    if ( isdefined( endcondition3 ) )
    {
        self endon( endcondition3 );
    }
    
    self waittill( "killstreak_hacked" );
    hackedduration = self killstreak_hacking::get_hacked_timeout_duration_ms();
    self.killstreakendtime = gettime() + hackedduration;
    hostmigration::migrationawarewait( hackedduration );
    self.killstreakendtime = 0;
    self notify( #"timed_out" );
    self [[ callback ]]();
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0xda55e67b, Offset: 0xaa38
// Size: 0x2c8
function update_player_threat( player )
{
    heli = self;
    player.threatlevel = 0;
    dist = distance( player.origin, heli.origin );
    player.threatlevel += ( level.heli_visual_range - dist ) / level.heli_visual_range * 100;
    
    if ( isdefined( heli.attacker ) && player == heli.attacker )
    {
        player.threatlevel += 100;
    }
    
    if ( isdefined( player.carryobject ) )
    {
        player.threatlevel += 200;
    }
    
    if ( isdefined( player.score ) )
    {
        player.threatlevel += player.score * 2;
    }
    
    if ( player weapons::has_launcher() )
    {
        if ( player weapons::has_lockon( heli ) )
        {
            player.threatlevel += 1000;
        }
        else
        {
            player.threatlevel += 500;
        }
    }
    
    if ( player weapons::has_heavy_weapon() )
    {
        player.threatlevel += 300;
    }
    
    if ( player weapons::has_lmg() )
    {
        player.threatlevel += 200;
    }
    
    if ( isdefined( player.antithreat ) )
    {
        player.threatlevel -= player.antithreat;
    }
    
    if ( player.threatlevel <= 0 )
    {
        player.threatlevel = 1;
    }
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0xb987afbd, Offset: 0xad08
// Size: 0xcc
function update_non_player_threat( non_player )
{
    heli = self;
    non_player.threatlevel = 0;
    dist = distance( non_player.origin, heli.origin );
    non_player.threatlevel += ( level.heli_visual_range - dist ) / level.heli_visual_range * 100;
    
    if ( non_player.threatlevel <= 0 )
    {
        non_player.threatlevel = 1;
    }
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0x2aba115a, Offset: 0xade0
// Size: 0x21c
function update_actor_threat( actor )
{
    heli = self;
    actor.threatlevel = 0;
    dist = distance( actor.origin, heli.origin );
    actor.threatlevel += ( level.heli_visual_range - dist ) / level.heli_visual_range * 100;
    
    if ( isdefined( actor.owner ) )
    {
        if ( isdefined( heli.attacker ) && actor.owner == heli.attacker )
        {
            actor.threatlevel += 100;
        }
        
        if ( isdefined( actor.owner.carryobject ) )
        {
            actor.threatlevel += 200;
        }
        
        if ( isdefined( actor.owner.score ) )
        {
            actor.threatlevel += actor.owner.score * 4;
        }
        
        if ( isdefined( actor.owner.antithreat ) )
        {
            actor.threatlevel -= actor.owner.antithreat;
        }
    }
    
    if ( actor.threatlevel <= 0 )
    {
        actor.threatlevel = 1;
    }
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0x4694348a, Offset: 0xb008
// Size: 0xa4
function update_dog_threat( dog )
{
    heli = self;
    dog.threatlevel = 0;
    dist = distance( dog.origin, heli.origin );
    dog.threatlevel += ( level.heli_visual_range - dist ) / level.heli_visual_range * 100;
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0x284ada65, Offset: 0xb0b8
// Size: 0xcc, Type: bool
function missile_valid_target_check( missiletarget )
{
    heli2target_normal = vectornormalize( missiletarget.origin - self.origin );
    heli2forward = anglestoforward( self.angles );
    heli2forward_normal = vectornormalize( heli2forward );
    heli_dot_target = vectordot( heli2target_normal, heli2forward_normal );
    
    if ( heli_dot_target >= level.heli_valid_target_cone )
    {
        return true;
    }
    
    return false;
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0x1517d276, Offset: 0xb190
// Size: 0x1a4
function update_missile_player_threat( player )
{
    player.missilethreatlevel = 0;
    dist = distance( player.origin, self.origin );
    player.missilethreatlevel += ( level.heli_missile_range - dist ) / level.heli_missile_range * 100;
    
    if ( self missile_valid_target_check( player ) == 0 )
    {
        player.missilethreatlevel = 1;
        return;
    }
    
    if ( isdefined( self.attacker ) && player == self.attacker )
    {
        player.missilethreatlevel += 100;
    }
    
    player.missilethreatlevel += player.score * 4;
    
    if ( isdefined( player.antithreat ) )
    {
        player.missilethreatlevel -= player.antithreat;
    }
    
    if ( player.missilethreatlevel <= 0 )
    {
        player.missilethreatlevel = 1;
    }
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0x9487264, Offset: 0xb340
// Size: 0x20
function update_missile_dog_threat( dog )
{
    dog.missilethreatlevel = 1;
}

// Namespace killstreaks/killstreaks
// Params 3
// Checksum 0xa55a635, Offset: 0xb368
// Size: 0x3c
function killstreak_assist( victim, assister, killstreak )
{
    victim recordkillstreakassist( victim, assister, killstreak );
}

// Namespace killstreaks/killstreaks
// Params 4
// Checksum 0xd3ff6906, Offset: 0xb3b0
// Size: 0x128
function add_ricochet_protection( killstreak_id, owner, origin, ricochet_distance )
{
    testing = 0;
    
    /#
        testing = getdvarint( "scr_ricochet_protection_debug", 0 ) == 2;
    #/
    
    if ( !level.hardcoremode && !testing )
    {
        return;
    }
    
    if ( !isdefined( ricochet_distance ) || ricochet_distance == 0 )
    {
        return;
    }
    
    if ( !isdefined( owner.ricochet_protection ) )
    {
        owner.ricochet_protection = [];
    }
    
    owner.ricochet_protection[ killstreak_id ] = spawnstruct();
    owner.ricochet_protection[ killstreak_id ].origin = origin;
    owner.ricochet_protection[ killstreak_id ].distancesq = ricochet_distance * ricochet_distance;
}

// Namespace killstreaks/killstreaks
// Params 3
// Checksum 0xef70bb7e, Offset: 0xb4e0
// Size: 0x8c
function set_ricochet_protection_endtime( killstreak_id, owner, endtime )
{
    if ( !isdefined( owner ) || !isdefined( owner.ricochet_protection ) || !isdefined( killstreak_id ) )
    {
        return;
    }
    
    if ( !isdefined( owner.ricochet_protection[ killstreak_id ] ) )
    {
        return;
    }
    
    owner.ricochet_protection[ killstreak_id ].endtime = endtime;
}

// Namespace killstreaks/killstreaks
// Params 2
// Checksum 0xc88b61c3, Offset: 0xb578
// Size: 0x58
function remove_ricochet_protection( killstreak_id, owner )
{
    if ( !isdefined( owner ) || !isdefined( owner.ricochet_protection ) || !isdefined( killstreak_id ) )
    {
        return;
    }
    
    owner.ricochet_protection[ killstreak_id ] = undefined;
}

// Namespace killstreaks/killstreaks
// Params 1
// Checksum 0x17395a50, Offset: 0xb5d8
// Size: 0x12a, Type: bool
function is_ricochet_protected( player )
{
    if ( !isdefined( player ) || !isdefined( player.ricochet_protection ) )
    {
        return false;
    }
    
    foreach ( protection in player.ricochet_protection )
    {
        if ( !isdefined( protection ) )
        {
            continue;
        }
        
        if ( isdefined( protection.endtime ) && protection.endtime < gettime() )
        {
            continue;
        }
        
        if ( distancesquared( protection.origin, player.origin ) < protection.distancesq )
        {
            return true;
        }
    }
    
    return false;
}

/#

    // Namespace killstreaks/killstreaks
    // Params 0
    // Checksum 0x1d0022c4, Offset: 0xb710
    // Size: 0x2d4, Type: dev
    function debug_ricochet_protection()
    {
        debug_wait = 0.5;
        debug_frames = int( debug_wait / 0.05 ) + 1;
        
        while ( true )
        {
            if ( getdvarint( "scr_ricochet_protection_debug", 0 ) == 0 )
            {
                wait 2;
                continue;
            }
            
            wait debug_wait;
            
            foreach ( player in level.players )
            {
                if ( !isdefined( player ) )
                {
                    continue;
                }
                
                if ( !isdefined( player.ricochet_protection ) )
                {
                    continue;
                }
                
                foreach ( protection in player.ricochet_protection )
                {
                    if ( !isdefined( protection ) )
                    {
                        continue;
                    }
                    
                    if ( isdefined( protection.endtime ) && protection.endtime < gettime() )
                    {
                        continue;
                    }
                    
                    radius = sqrt( protection.distancesq );
                    sphere( protection.origin, radius, ( 1, 1, 0 ), 0.25, 0, 36, debug_frames );
                    circle( protection.origin, radius, ( 1, 0.5, 0 ), 0, 1, debug_frames );
                    circle( protection.origin + ( 0, 0, 2 ), radius, ( 1, 0.5, 0 ), 0, 1, debug_frames );
                }
            }
        }
    }

#/
