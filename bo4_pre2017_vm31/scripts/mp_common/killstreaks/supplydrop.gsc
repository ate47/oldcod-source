#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/entityheadicons_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/gameobjects_shared;
#using scripts/core_common/hostmigration_shared;
#using scripts/core_common/hud_util_shared;
#using scripts/core_common/killstreaks_shared;
#using scripts/core_common/popups_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/sound_shared;
#using scripts/core_common/struct;
#using scripts/core_common/util_shared;
#using scripts/core_common/vehicleriders_shared;
#using scripts/core_common/weapons/hacker_tool;
#using scripts/core_common/weapons/heatseekingmissile;
#using scripts/core_common/weapons/smokegrenade;
#using scripts/core_common/weapons/tacticalinsertion;
#using scripts/core_common/weapons/weaponobjects;
#using scripts/core_common/weapons/weapons;
#using scripts/mp_common/challenges;
#using scripts/mp_common/gametypes/battlechatter;
#using scripts/mp_common/gametypes/hostmigration;
#using scripts/mp_common/killstreaks/ai_tank;
#using scripts/mp_common/killstreaks/airsupport;
#using scripts/mp_common/killstreaks/combat_robot;
#using scripts/mp_common/killstreaks/emp;
#using scripts/mp_common/killstreaks/helicopter;
#using scripts/mp_common/killstreaks/killstreak_bundles;
#using scripts/mp_common/killstreaks/killstreak_detect;
#using scripts/mp_common/killstreaks/killstreak_hacking;
#using scripts/mp_common/killstreaks/killstreak_weapons;
#using scripts/mp_common/killstreaks/killstreakrules;
#using scripts/mp_common/killstreaks/killstreaks;
#using scripts/mp_common/killstreaks/supplydrop;
#using scripts/mp_common/util;

#namespace supplydrop;

#using_animtree( "mp_vehicles" );

// Namespace supplydrop/supplydrop
// Params 0
// Checksum 0xdf6e3961, Offset: 0x1768
// Size: 0x132c
function init()
{
    level.cratemodelfriendly = "wpn_t7_care_package_world";
    level.cratemodelenemy = "wpn_t7_care_package_world";
    level.cratemodeltank = "wpn_t7_drop_box";
    level.cratemodelboobytrapped = "wpn_t7_care_package_world";
    level.vtoldrophelicoptervehicleinfo = "vtol_supplydrop_mp";
    level.crateownerusetime = 500;
    level.cratenonownerusetime = getgametypesetting( "crateCaptureTime" ) * 1000;
    level.crate_headicon_offset = ( 0, 0, 15 );
    level.supplydropdisarmcrate = &"KILLSTREAK_SUPPLY_DROP_DISARM_HINT";
    level.disarmingcrate = &"KILLSTREAK_SUPPLY_DROP_DISARMING_CRATE";
    level.supplydropcarepackageidleanim = %o_drone_supply_care_idle;
    level.supplydropcarepackagedropanim = %o_drone_supply_care_drop;
    level.supplydropaitankidleanim = %o_drone_supply_agr_idle;
    level.supplydropaitankdropanim = %o_drone_supply_agr_drop;
    clientfield::register( "helicopter", "supplydrop_care_package_state", 1, 1, "int" );
    clientfield::register( "helicopter", "supplydrop_ai_tank_state", 1, 1, "int" );
    clientfield::register( "vehicle", "supplydrop_care_package_state", 1, 1, "int" );
    clientfield::register( "vehicle", "supplydrop_ai_tank_state", 1, 1, "int" );
    clientfield::register( "scriptmover", "supplydrop_thrusters_state", 1, 1, "int" );
    clientfield::register( "scriptmover", "aitank_thrusters_state", 1, 1, "int" );
    clientfield::register( "toplayer", "marker_state", 1, 2, "int" );
    level._supply_drop_smoke_fx = "killstreaks/fx_supply_drop_smoke";
    level._supply_drop_explosion_fx = "explosions/fx_exp_grenade_default";
    killstreaks::register( "supply_drop", "supplydrop_marker", "killstreak_supply_drop", "supply_drop_used", &usekillstreaksupplydrop, undefined, 1 );
    killstreaks::register_strings( "supply_drop", &"KILLSTREAK_EARNED_SUPPLY_DROP", &"KILLSTREAK_AIRSPACE_FULL", &"KILLSTREAK_SUPPLY_DROP_INBOUND", undefined, &"KILLSTREAK_SUPPLY_DROP_HACKED" );
    killstreaks::register_dialog( "supply_drop", "mpl_killstreak_supply", "supplyDropDialogBundle", "supplyDropPilotDialogBundle", "friendlySupplyDrop", "enemySupplyDrop", "enemySupplyDropMultiple", "friendlySupplyDropHacked", "enemySupplyDropHacked", "requestSupplyDrop", "threatSupplyDrop" );
    killstreaks::register_alt_weapon( "supply_drop", "mp40_blinged" );
    killstreaks::register_alt_weapon( "supply_drop", "supplydrop" );
    killstreaks::allow_assists( "supply_drop", 1 );
    killstreaks::devgui_scorestreak_command( "supply_drop", "Random", "set scr_supply_drop_gui random; set scr_supply_drop_give 1" );
    killstreaks::devgui_scorestreak_command( "supply_drop", "Random Ally Crate", "set scr_supply_drop_gui random; set scr_givetestsupplydrop 1" );
    killstreaks::devgui_scorestreak_command( "supply_drop", "Random Enemy Crate", "set scr_supply_drop_gui random; set scr_givetestsupplydrop 2" );
    killstreak_bundles::register_killstreak_bundle( "supply_drop_ai_tank" );
    killstreak_bundles::register_killstreak_bundle( "supply_drop_combat_robot" );
    level.cratetypes = [];
    level.categorytypeweight = [];
    registercratetype( "supplydrop", "killstreak", "uav", 125, &"KILLSTREAK_RADAR_CRATE", &"PLATFORM_RADAR_GAMBLER", &givecratekillstreak );
    registercratetype( "supplydrop", "killstreak", "rcbomb", 105, &"KILLSTREAK_RCBOMB_CRATE", &"PLATFORM_RCBOMB_GAMBLER", &givecratekillstreak );
    registercratetype( "supplydrop", "killstreak", "counteruav", 115, &"KILLSTREAK_COUNTERU2_CRATE", &"PLATFORM_COUNTERU2_GAMBLER", &givecratekillstreak );
    registercratetype( "supplydrop", "killstreak", "remote_missile", 90, &"KILLSTREAK_REMOTE_MISSILE_CRATE", &"PLATFORM_REMOTE_MISSILE_GAMBLER", &givecratekillstreak );
    registercratetype( "supplydrop", "killstreak", "planemortar", 80, &"KILLSTREAK_PLANE_MORTAR_CRATE", &"PLATFORM_PLANE_MORTAR_GAMBLER", &givecratekillstreak );
    registercratetype( "supplydrop", "killstreak", "autoturret", 90, &"KILLSTREAK_AUTO_TURRET_CRATE", &"PLATFORM_AUTO_TURRET_GAMBLER", &givecratekillstreak );
    registercratetype( "supplydrop", "killstreak", "microwave_turret", 120, &"KILLSTREAK_MICROWAVE_TURRET_CRATE", &"PLATFORM_MICROWAVE_TURRET_GAMBLER", &givecratekillstreak );
    registercratetype( "supplydrop", "killstreak", "satellite", 20, &"KILLSTREAK_SATELLITE_CRATE", &"PLATFORM_SATELLITE_GAMBLER", &givecratekillstreak );
    registercratetype( "supplydrop", "killstreak", "drone_strike", 75, &"KILLSTREAK_DRONE_STRIKE_CRATE", &"PLATFORM_DRONE_STRIKE_GAMBLER", &givecratekillstreak );
    registercratetype( "supplydrop", "killstreak", "helicopter_comlink", 30, &"KILLSTREAK_HELICOPTER_CRATE", &"PLATFORM_HELICOPTER_GAMBLER", &givecratekillstreak );
    registercratetype( "supplydrop", "killstreak", "emp", 5, &"KILLSTREAK_EMP_CRATE", &"PLATFORM_EMP_GAMBLER", &givecratekillstreak );
    registercratetype( "supplydrop", "killstreak", "raps", 20, &"KILLSTREAK_RAPS_CRATE", &"PLATFORM_RAPS_GAMBLER", &givecratekillstreak );
    registercratetype( "supplydrop", "killstreak", "dart", 75, &"KILLSTREAK_DART_CRATE", &"PLATFORM_DART_GAMBLER", &givecratekillstreak );
    registercratetype( "supplydrop", "killstreak", "sentinel", 20, &"KILLSTREAK_SENTINEL_CRATE", &"PLATFORM_SENTINEL_GAMBLER", &givecratekillstreak );
    registercratetype( "supplydrop", "killstreak", "combat_robot", 5, &"KILLSTREAK_COMBAT_ROBOT_CRATE", &"PLATFORM_COMBAT_ROBOT_GAMBLER", &givecratekillstreak );
    registercratetype( "supplydrop", "killstreak", "ai_tank_drop", 25, &"KILLSTREAK_AI_TANK_CRATE", &"PLATFORM_AI_TANK_CRATE_GAMBLER", &givecratekillstreak );
    registercratetype( "inventory_supplydrop", "killstreak", "uav", 125, &"KILLSTREAK_RADAR_CRATE", &"PLATFORM_RADAR_GAMBLER", &givecratekillstreak );
    registercratetype( "inventory_supplydrop", "killstreak", "counteruav", 115, &"KILLSTREAK_COUNTERU2_CRATE", &"PLATFORM_COUNTERU2_GAMBLER", &givecratekillstreak );
    registercratetype( "inventory_supplydrop", "killstreak", "rcbomb", 105, &"KILLSTREAK_RCBOMB_CRATE", &"PLATFORM_RCBOMB_GAMBLER", &givecratekillstreak );
    registercratetype( "inventory_supplydrop", "killstreak", "remote_missile", 90, &"KILLSTREAK_REMOTE_MISSILE_CRATE", &"PLATFORM_REMOTE_MISSILE_GAMBLER", &givecratekillstreak );
    registercratetype( "inventory_supplydrop", "killstreak", "planemortar", 80, &"KILLSTREAK_PLANE_MORTAR_CRATE", &"PLATFORM_PLANE_MORTAR_GAMBLER", &givecratekillstreak );
    registercratetype( "inventory_supplydrop", "killstreak", "autoturret", 90, &"KILLSTREAK_AUTO_TURRET_CRATE", &"PLATFORM_AUTO_TURRET_GAMBLER", &givecratekillstreak );
    registercratetype( "inventory_supplydrop", "killstreak", "microwave_turret", 120, &"KILLSTREAK_MICROWAVE_TURRET_CRATE", &"PLATFORM_MICROWAVE_TURRET_GAMBLER", &givecratekillstreak );
    registercratetype( "inventory_supplydrop", "killstreak", "satellite", 20, &"KILLSTREAK_SATELLITE_CRATE", &"PLATFORM_SATELLITE_GAMBLER", &givecratekillstreak );
    registercratetype( "inventory_supplydrop", "killstreak", "helicopter_comlink", 30, &"KILLSTREAK_HELICOPTER_CRATE", &"PLATFORM_HELICOPTER_GAMBLER", &givecratekillstreak );
    registercratetype( "inventory_supplydrop", "killstreak", "emp", 5, &"KILLSTREAK_EMP_CRATE", &"PLATFORM_EMP_GAMBLER", &givecratekillstreak );
    registercratetype( "inventory_supplydrop", "killstreak", "raps", 20, &"KILLSTREAK_RAPS_CRATE", &"PLATFORM_RAPS_GAMBLER", &givecratekillstreak );
    registercratetype( "inventory_supplydrop", "killstreak", "dart", 75, &"KILLSTREAK_DART_CRATE", &"PLATFORM_DART_GAMBLER", &givecratekillstreak );
    registercratetype( "inventory_supplydrop", "killstreak", "sentinel", 20, &"KILLSTREAK_SENTINEL_CRATE", &"PLATFORM_SENTINEL_GAMBLER", &givecratekillstreak );
    registercratetype( "inventory_supplydrop", "killstreak", "combat_robot", 5, &"KILLSTREAK_COMBAT_ROBOT_CRATE", &"PLATFORM_COMBAT_ROBOT_GAMBLER", &givecratekillstreak );
    registercratetype( "inventory_supplydrop", "killstreak", "ai_tank_drop", 25, &"KILLSTREAK_AI_TANK_CRATE", &"PLATFORM_AI_TANK_CRATE_GAMBLER", &givecratekillstreak );
    registercratetype( "inventory_supplydrop", "killstreak", "drone_strike", 75, &"KILLSTREAK_DRONE_STRIKE_CRATE", &"PLATFORM_DRONE_STRIKE_GAMBLER", &givecratekillstreak );
    registercratetype( "inventory_ai_tank_drop", "killstreak", "ai_tank_drop", 75, &"KILLSTREAK_AI_TANK_CRATE", undefined, undefined, &ai_tank::crateland );
    registercratetype( "ai_tank_drop", "killstreak", "ai_tank_drop", 75, &"KILLSTREAK_AI_TANK_CRATE", undefined, undefined, &ai_tank::crateland );
    registercratetype( "gambler", "killstreak", "uav", 95, &"KILLSTREAK_RADAR_CRATE", undefined, &givecratekillstreak );
    registercratetype( "gambler", "killstreak", "counteruav", 85, &"KILLSTREAK_COUNTERU2_CRATE", undefined, &givecratekillstreak );
    registercratetype( "gambler", "killstreak", "rcbomb", 75, &"KILLSTREAK_RCBOMB_CRATE", undefined, &givecratekillstreak );
    registercratetype( "gambler", "killstreak", "microwave_turret", 110, &"KILLSTREAK_MICROWAVE_TURRET_CRATE", undefined, &givecratekillstreak );
    registercratetype( "gambler", "killstreak", "remote_missile", 100, &"KILLSTREAK_REMOTE_MISSILE_CRATE", undefined, &givecratekillstreak );
    registercratetype( "gambler", "killstreak", "planemortar", 80, &"KILLSTREAK_PLANE_MORTAR_CRATE", undefined, &givecratekillstreak );
    registercratetype( "gambler", "killstreak", "autoturret", 100, &"KILLSTREAK_AUTO_TURRET_CRATE", undefined, &givecratekillstreak );
    registercratetype( "gambler", "killstreak", "satellite", 30, &"KILLSTREAK_SATELLITE_CRATE", undefined, &givecratekillstreak );
    registercratetype( "gambler", "killstreak", "ai_tank_drop", 40, &"KILLSTREAK_AI_TANK_CRATE", undefined, &givecratekillstreak );
    registercratetype( "gambler", "killstreak", "helicopter_comlink", 45, &"KILLSTREAK_HELICOPTER_CRATE", undefined, &givecratekillstreak );
    registercratetype( "gambler", "killstreak", "emp", 10, &"KILLSTREAK_EMP_CRATE", undefined, &givecratekillstreak );
    registercratetype( "gambler", "killstreak", "raps", 35, &"KILLSTREAK_RAPS_CRATE", undefined, &givecratekillstreak );
    registercratetype( "gambler", "killstreak", "dart", 75, &"KILLSTREAK_DART_CRATE", undefined, &givecratekillstreak );
    registercratetype( "gambler", "killstreak", "sentinel", 35, &"KILLSTREAK_SENTINEL_CRATE", undefined, &givecratekillstreak );
    registercratetype( "gambler", "killstreak", "combat_robot", 10, &"KILLSTREAK_COMBAT_ROBOT_CRATE", undefined, &givecratekillstreak );
    registercratetype( "gambler", "killstreak", "drone_strike", 75, &"KILLSTREAK_DRONE_STRIKE_CRATE", undefined, &givecratekillstreak );
    level.cratecategoryweights = [];
    level.cratecategorytypeweights = [];
    
    foreach ( categorykey, category in level.cratetypes )
    {
        finalizecratecategory( categorykey );
    }
    
    /#
        level thread supply_drop_dev_gui();
    #/
}

// Namespace supplydrop/supplydrop
// Params 1
// Checksum 0x9031cdba, Offset: 0x2aa0
// Size: 0x136
function finalizecratecategory( category )
{
    level.cratecategoryweights[ category ] = 0;
    cratetypekeys = getarraykeys( level.cratetypes[ category ] );
    
    for ( cratetype = 0; cratetype < cratetypekeys.size ; cratetype++ )
    {
        typekey = cratetypekeys[ cratetype ];
        level.cratetypes[ category ][ typekey ].previousweight = level.cratecategoryweights[ category ];
        level.cratecategoryweights[ category ] += level.cratetypes[ category ][ typekey ].weight;
        level.cratetypes[ category ][ typekey ].weight = level.cratecategoryweights[ category ];
    }
}

// Namespace supplydrop/supplydrop
// Params 1
// Checksum 0xe2ec03e3, Offset: 0x2be0
// Size: 0x11c
function advancedfinalizecratecategory( category )
{
    level.cratecategorytypeweights[ category ] = 0;
    cratetypekeys = getarraykeys( level.categorytypeweight[ category ] );
    
    for ( cratetype = 0; cratetype < cratetypekeys.size ; cratetype++ )
    {
        typekey = cratetypekeys[ cratetype ];
        level.cratecategorytypeweights[ category ] += level.categorytypeweight[ category ][ typekey ].weight;
        level.categorytypeweight[ category ][ typekey ].weight = level.cratecategorytypeweights[ category ];
    }
    
    finalizecratecategory( category );
}

// Namespace supplydrop/supplydrop
// Params 3
// Checksum 0x8ee834c6, Offset: 0x2d08
// Size: 0x2a4
function setcategorytypeweight( category, type, weight )
{
    if ( !isdefined( level.categorytypeweight[ category ] ) )
    {
        level.categorytypeweight[ category ] = [];
    }
    
    level.categorytypeweight[ category ][ type ] = spawnstruct();
    level.categorytypeweight[ category ][ type ].weight = weight;
    count = 0;
    totalweight = 0;
    startindex = undefined;
    finalindex = undefined;
    cratenamekeys = getarraykeys( level.cratetypes[ category ] );
    
    for ( cratename = 0; cratename < cratenamekeys.size ; cratename++ )
    {
        namekey = cratenamekeys[ cratename ];
        
        if ( level.cratetypes[ category ][ namekey ].type == type )
        {
            count++;
            totalweight += level.cratetypes[ category ][ namekey ].weight;
            
            if ( !isdefined( startindex ) )
            {
                startindex = cratename;
            }
            
            if ( isdefined( finalindex ) && finalindex + 1 != cratename )
            {
                /#
                    util::error( "Crate type declaration must be contiguous" );
                #/
                
                callback::abort_level();
                return;
            }
            
            finalindex = cratename;
        }
    }
    
    level.categorytypeweight[ category ][ type ].totalcrateweight = totalweight;
    level.categorytypeweight[ category ][ type ].cratecount = count;
    level.categorytypeweight[ category ][ type ].startindex = startindex;
    level.categorytypeweight[ category ][ type ].finalindex = finalindex;
}

// Namespace supplydrop/supplydrop
// Params 8
// Checksum 0xc376f932, Offset: 0x2fb8
// Size: 0x214
function registercratetype( category, type, name, weight, hint, hint_gambler, givefunction, landfunctionoverride )
{
    /#
    #/
    
    itemname = level.killstreaks[ name ].menuname;
    
    if ( isitemrestricted( itemname ) )
    {
        return;
    }
    
    if ( !isdefined( level.cratetypes[ category ] ) )
    {
        level.cratetypes[ category ] = [];
    }
    
    cratetype = spawnstruct();
    cratetype.type = type;
    cratetype.name = name;
    cratetype.weight = weight;
    cratetype.hint = hint;
    cratetype.hint_gambler = hint_gambler;
    cratetype.givefunction = givefunction;
    crateweapon = killstreaks::get_killstreak_weapon( name );
    
    if ( isdefined( crateweapon ) )
    {
        cratetype.objective = getcrateheadobjective( crateweapon );
    }
    
    if ( isdefined( landfunctionoverride ) )
    {
        cratetype.landfunctionoverride = landfunctionoverride;
    }
    
    level.cratetypes[ category ][ name ] = cratetype;
    game.strings[ name + "_hint" ] = hint;
    
    /#
        level thread add_devgui_command( category, name );
    #/
}

/#

    // Namespace supplydrop/supplydrop
    // Params 2
    // Checksum 0x201d46c8, Offset: 0x31d8
    // Size: 0xac, Type: dev
    function add_devgui_command( category, name )
    {
        level endon( #"game_ended" );
        wait 0.1;
        wait randomintrange( 2, 10 ) * 0.05;
        
        if ( category == "inventory_supplydrop" && killstreaks::is_registered( name ) )
        {
            killstreaks::devgui_scorestreak_command( name, "Care Package", "set scr_supply_drop_gui " + name + "; set scr_supply_drop_give 1" );
        }
    }

#/

// Namespace supplydrop/supplydrop
// Params 2
// Checksum 0x4e33d7ad, Offset: 0x3290
// Size: 0x41e
function getrandomcratetype( category, gambler_crate_name )
{
    if ( !isdefined( level.cratetypes ) || !isdefined( level.cratetypes[ category ] ) )
    {
        return;
    }
    
    assert( isdefined( level.cratetypes ) );
    assert( isdefined( level.cratetypes[ category ] ) );
    assert( isdefined( level.cratecategoryweights[ category ] ) );
    typekey = undefined;
    cratetypestart = 0;
    randomweightend = randomintrange( 1, level.cratecategoryweights[ category ] + 1 );
    find_another = 0;
    cratenamekeys = getarraykeys( level.cratetypes[ category ] );
    
    if ( isdefined( level.categorytypeweight[ category ] ) )
    {
        randomweightend = randomint( level.cratecategorytypeweights[ category ] ) + 1;
        cratetypekeys = getarraykeys( level.categorytypeweight[ category ] );
        
        for ( cratetype = 0; cratetype < cratetypekeys.size ; cratetype++ )
        {
            typekey = cratetypekeys[ cratetype ];
            
            if ( level.categorytypeweight[ category ][ typekey ].weight < randomweightend )
            {
                continue;
            }
            
            cratetypestart = level.categorytypeweight[ category ][ typekey ].startindex;
            randomweightend = randomint( level.categorytypeweight[ category ][ typekey ].totalcrateweight ) + 1;
            randomweightend += level.cratetypes[ category ][ cratenamekeys[ cratetypestart ] ].previousweight;
            break;
        }
    }
    
    for ( cratetype = cratetypestart; cratetype < cratenamekeys.size ; cratetype++ )
    {
        typekey = cratenamekeys[ cratetype ];
        
        if ( level.cratetypes[ category ][ typekey ].weight < randomweightend )
        {
            continue;
        }
        
        if ( isdefined( gambler_crate_name ) && level.cratetypes[ category ][ typekey ].name == gambler_crate_name )
        {
            find_another = 1;
        }
        
        if ( find_another )
        {
            if ( cratetype < cratenamekeys.size - 1 )
            {
                cratetype++;
            }
            else if ( cratetype > 0 )
            {
                cratetype--;
            }
            
            typekey = cratenamekeys[ cratetype ];
        }
        
        break;
    }
    
    /#
        if ( isdefined( level.dev_gui_supply_drop ) && level.dev_gui_supply_drop != "random" && level.dev_gui_supply_drop != "" )
        {
            typekey = level.dev_gui_supply_drop;
        }
    #/
    
    return level.cratetypes[ category ][ typekey ];
}

// Namespace supplydrop/supplydrop
// Params 1
// Checksum 0xc90646a6, Offset: 0x36b8
// Size: 0xc6
function givecrateitem( crate )
{
    if ( !isalive( self ) || !isdefined( crate.cratetype ) )
    {
        return;
    }
    
    assert( isdefined( crate.cratetype.givefunction ), "no give function defined for " + crate.cratetype.name );
    return [[ crate.cratetype.givefunction ]]( "inventory_" + crate.cratetype.name );
}

// Namespace supplydrop/supplydrop
// Params 3
// Checksum 0x343c546, Offset: 0x3788
// Size: 0x62
function givecratekillstreakwaiter( event, removecrate, extraendon )
{
    self endon( #"give_crate_killstreak_done" );
    
    if ( isdefined( extraendon ) )
    {
        self endon( extraendon );
    }
    
    self waittill( event );
    self notify( #"give_crate_killstreak_done", { #is_remove:removecrate } );
}

// Namespace supplydrop/supplydrop
// Params 1
// Checksum 0xca9591fb, Offset: 0x37f8
// Size: 0x24
function givecratekillstreak( killstreak )
{
    self killstreaks::give( killstreak );
}

// Namespace supplydrop/supplydrop
// Params 1
// Checksum 0x6e503784, Offset: 0x3828
// Size: 0x1a2
function givespecializedcrateweapon( weapon )
{
    switch ( weapon.name )
    {
        case #"minigun":
            level thread popups::displayteammessagetoall( &"KILLSTREAK_MINIGUN_INBOUND", self );
            level weapons::add_limited_weapon( weapon, self, 3 );
            break;
        case #"m32":
            level thread popups::displayteammessagetoall( &"KILLSTREAK_M32_INBOUND", self );
            level weapons::add_limited_weapon( weapon, self, 3 );
            break;
        case #"m202_flash":
            level thread popups::displayteammessagetoall( &"KILLSTREAK_M202_FLASH_INBOUND", self );
            level weapons::add_limited_weapon( weapon, self, 3 );
            break;
        case #"m220_tow":
            level thread popups::displayteammessagetoall( &"KILLSTREAK_M220_TOW_INBOUND", self );
            level weapons::add_limited_weapon( weapon, self, 3 );
            break;
        case #"mp40_blinged":
            level thread popups::displayteammessagetoall( &"KILLSTREAK_MP40_INBOUND", self );
            level weapons::add_limited_weapon( weapon, self, 3 );
            break;
        default:
            break;
    }
}

// Namespace supplydrop/supplydrop
// Params 1
// Checksum 0x74104fd0, Offset: 0x39d8
// Size: 0x1d8
function givecrateweapon( weapon_name )
{
    weapon = getweapon( weapon_name );
    
    if ( weapon == level.weaponnone )
    {
        return;
    }
    
    currentweapon = self getcurrentweapon();
    
    if ( currentweapon == weapon || self hasweapon( weapon ) )
    {
        self givemaxammo( weapon );
        return 1;
    }
    
    if ( currentweapon.issupplydropweapon || isdefined( level.grenade_array[ currentweapon ] ) || isdefined( level.inventory_array[ currentweapon ] ) )
    {
        self takeweapon( self.lastdroppableweapon );
        self giveweapon( weapon );
        self switchtoweapon( weapon );
        return 1;
    }
    
    self addweaponstat( weapon, "used", 1 );
    givespecializedcrateweapon( weapon );
    self giveweapon( weapon );
    self switchtoweapon( weapon );
    self waittill( "weapon_change" );
    self killstreak_weapons::usekillstreakweaponfromcrate( weapon );
    return 1;
}

// Namespace supplydrop/supplydrop
// Params 2
// Checksum 0xab56f12e, Offset: 0x3bb8
// Size: 0x2ac, Type: bool
function usesupplydropmarker( package_contents_id, context )
{
    player = self;
    self endon( #"disconnect" );
    self endon( #"spawned_player" );
    supplydropweapon = level.weaponnone;
    currentweapon = self getcurrentweapon();
    prevweapon = currentweapon;
    
    if ( currentweapon.issupplydropweapon )
    {
        supplydropweapon = currentweapon;
    }
    
    if ( supplydropweapon.isgrenadeweapon )
    {
        trigger_event = "grenade_fire";
    }
    else
    {
        trigger_event = "weapon_fired";
    }
    
    self thread supplydropwatcher( package_contents_id, trigger_event, supplydropweapon, context );
    self.supplygrenadedeathdrop = 0;
    
    while ( true )
    {
        player allowmelee( 0 );
        notifystring = self waittill( "weapon_change", trigger_event, "disconnect", "spawned_player" );
        player allowmelee( 1 );
        
        if ( notifystring._notify != trigger_event )
        {
            cleanup( context, player );
            return false;
        }
        
        if ( isdefined( player.markerposition ) )
        {
            break;
        }
    }
    
    self notify( #"trigger_weapon_shutdown" );
    
    if ( supplydropweapon == level.weaponnone )
    {
        cleanup( context, player );
        return false;
    }
    
    if ( isdefined( self ) )
    {
        self waittill( "weapon_change", "death", "disconnect", "spawned_player" );
        self takeweapon( supplydropweapon );
        
        if ( self hasweapon( supplydropweapon ) || self getammocount( supplydropweapon ) )
        {
            cleanup( context, player );
            return false;
        }
    }
    
    return true;
}

// Namespace supplydrop/supplydrop
// Params 1
// Checksum 0x322cadd8, Offset: 0x3e70
// Size: 0x4c, Type: bool
function issupplydropgrenadeallowed( killstreak )
{
    if ( !self killstreakrules::iskillstreakallowed( killstreak, self.team ) )
    {
        self killstreaks::switch_to_last_non_killstreak_weapon();
        return false;
    }
    
    return true;
}

// Namespace supplydrop/supplydrop
// Params 2
// Checksum 0xcf95dfef, Offset: 0x3ec8
// Size: 0x2a
function adddroplocation( killstreak_id, location )
{
    level.droplocations[ killstreak_id ] = location;
}

// Namespace supplydrop/supplydrop
// Params 1
// Checksum 0xfb51a461, Offset: 0x3f00
// Size: 0x1c
function deldroplocation( killstreak_id )
{
    level.droplocations[ killstreak_id ] = undefined;
}

// Namespace supplydrop/supplydrop
// Params 2
// Checksum 0xa2bcd5be, Offset: 0x3f28
// Size: 0x3f0
function islocationgood( location, context )
{
    foreach ( droplocation in level.droplocations )
    {
        if ( distance2dsquared( droplocation, location ) < 3600 )
        {
            return 0;
        }
    }
    
    if ( context.perform_physics_trace === 1 )
    {
        mask = 1;
        
        if ( isdefined( context.tracemask ) )
        {
            mask = context.tracemask;
        }
        
        radius = context.radius;
        trace = physicstrace( location + ( 0, 0, 5000 ), location + ( 0, 0, 10 ), ( radius * -1, radius * -1, 0 ), ( radius, radius, 2 * radius ), undefined, mask );
        
        if ( trace[ "fraction" ] < 1 )
        {
            return 0;
        }
    }
    
    closestpoint = getclosestpointonnavmesh( location, max( context.max_dist_from_location, 24 ), context.dist_from_boundary );
    isvalidpoint = isdefined( closestpoint );
    
    if ( isvalidpoint && context.check_same_floor === 1 && abs( location[ 2 ] - closestpoint[ 2 ] ) > 96 )
    {
        isvalidpoint = 0;
    }
    
    if ( isvalidpoint && distance2dsquared( location, closestpoint ) > context.max_dist_from_location * context.max_dist_from_location )
    {
        isvalidpoint = 0;
    }
    
    /#
        if ( getdvarint( "scr_supply_drop_valid_location_debug", 0 ) )
        {
            if ( !isvalidpoint )
            {
                otherclosestpoint = getclosestpointonnavmesh( location, getdvarfloat( "scr_supply_drop_valid_location_radius_debug", 96 ), context.dist_from_boundary );
                
                if ( isdefined( otherclosestpoint ) )
                {
                    sphere( otherclosestpoint, context.max_dist_from_location, ( 1, 0, 0 ), 0.8, 0, 20, 1 );
                }
            }
            else
            {
                sphere( closestpoint, context.max_dist_from_location, ( 0, 1, 0 ), 0.8, 0, 20, 1 );
                util::drawcylinder( closestpoint, context.radius, 8000, 0.0166667, undefined, ( 0, 0.9, 0 ), 0.7 );
            }
        }
    #/
    
    return isvalidpoint;
}

// Namespace supplydrop/supplydrop
// Params 1
// Checksum 0x5322bbe6, Offset: 0x4320
// Size: 0x1b6
function usekillstreaksupplydrop( killstreak )
{
    player = self;
    
    if ( !player issupplydropgrenadeallowed( killstreak ) )
    {
        return 0;
    }
    
    context = spawnstruct();
    context.radius = level.killstreakcorebundle.ksairdropsupplydropradius;
    context.dist_from_boundary = 12;
    context.max_dist_from_location = 4;
    context.perform_physics_trace = 1;
    context.islocationgood = &islocationgood;
    context.objective = &"airdrop_supplydrop";
    context.validlocationsound = level.killstreakcorebundle.ksvalidcarepackagelocationsound;
    context.tracemask = 1 | 4;
    context.droptag = "tag_attach";
    context.droptagoffset = ( -32, 0, 23 );
    context.killstreaktype = killstreak;
    result = player usesupplydropmarker( undefined, context );
    player notify( #"supply_drop_marker_done" );
    
    if ( !isdefined( result ) || !result )
    {
        return 0;
    }
    
    return result;
}

// Namespace supplydrop/supplydrop
// Params 1
// Checksum 0xb6f97bf4, Offset: 0x44e0
// Size: 0x1e0, Type: bool
function use_killstreak_death_machine( killstreak )
{
    if ( !self killstreakrules::iskillstreakallowed( killstreak, self.team ) )
    {
        return false;
    }
    
    weapon = getweapon( "minigun" );
    currentweapon = self getcurrentweapon();
    
    if ( currentweapon.issupplydropweapon || isdefined( level.grenade_array[ currentweapon ] ) || isdefined( level.inventory_array[ currentweapon ] ) )
    {
        self takeweapon( self.lastdroppableweapon );
        self giveweapon( weapon );
        self switchtoweapon( weapon );
        self setblockweaponpickup( weapon, 1 );
        return true;
    }
    
    level thread popups::displayteammessagetoall( &"KILLSTREAK_MINIGUN_INBOUND", self );
    level weapons::add_limited_weapon( weapon, self, 3 );
    self takeweapon( currentweapon );
    self giveweapon( weapon );
    self switchtoweapon( weapon );
    self setblockweaponpickup( weapon, 1 );
    return true;
}

// Namespace supplydrop/supplydrop
// Params 1
// Checksum 0xd1d19321, Offset: 0x46c8
// Size: 0x1e0, Type: bool
function use_killstreak_grim_reaper( killstreak )
{
    if ( !self killstreakrules::iskillstreakallowed( killstreak, self.team ) )
    {
        return false;
    }
    
    weapon = getweapon( "m202_flash" );
    currentweapon = self getcurrentweapon();
    
    if ( currentweapon.issupplydropweapon || isdefined( level.grenade_array[ currentweapon ] ) || isdefined( level.inventory_array[ currentweapon ] ) )
    {
        self takeweapon( self.lastdroppableweapon );
        self giveweapon( weapon );
        self switchtoweapon( weapon );
        self setblockweaponpickup( weapon, 1 );
        return true;
    }
    
    level thread popups::displayteammessagetoall( &"KILLSTREAK_M202_FLASH_INBOUND", self );
    level weapons::add_limited_weapon( weapon, self, 3 );
    self takeweapon( currentweapon );
    self giveweapon( weapon );
    self switchtoweapon( weapon );
    self setblockweaponpickup( weapon, 1 );
    return true;
}

// Namespace supplydrop/supplydrop
// Params 1
// Checksum 0xe73a7acb, Offset: 0x48b0
// Size: 0x210, Type: bool
function use_killstreak_tv_guided_missile( killstreak )
{
    if ( !killstreakrules::iskillstreakallowed( killstreak, self.team ) )
    {
        self iprintlnbold( level.killstreaks[ killstreak ].notavailabletext );
        return false;
    }
    
    weapon = getweapon( "m220_tow" );
    currentweapon = self getcurrentweapon();
    
    if ( currentweapon.issupplydropweapon || isdefined( level.grenade_array[ currentweapon ] ) || isdefined( level.inventory_array[ currentweapon ] ) )
    {
        self takeweapon( self.lastdroppableweapon );
        self giveweapon( weapon );
        self switchtoweapon( weapon );
        self setblockweaponpickup( weapon, 1 );
        return true;
    }
    
    level thread popups::displayteammessagetoall( &"KILLSTREAK_M220_TOW_INBOUND", self );
    level weapons::add_limited_weapon( weapon, self, 3 );
    self takeweapon( currentweapon );
    self giveweapon( weapon );
    self switchtoweapon( weapon );
    self setblockweaponpickup( weapon, 1 );
    return true;
}

// Namespace supplydrop/supplydrop
// Params 1
// Checksum 0xf6716c6a, Offset: 0x4ac8
// Size: 0x210, Type: bool
function use_killstreak_mp40( killstreak )
{
    if ( !killstreakrules::iskillstreakallowed( killstreak, self.team ) )
    {
        self iprintlnbold( level.killstreaks[ killstreak ].notavailabletext );
        return false;
    }
    
    weapon = getweapon( "mp40_blinged" );
    currentweapon = self getcurrentweapon();
    
    if ( currentweapon.issupplydropweapon || isdefined( level.grenade_array[ currentweapon ] ) || isdefined( level.inventory_array[ currentweapon ] ) )
    {
        self takeweapon( self.lastdroppableweapon );
        self giveweapon( weapon );
        self switchtoweapon( weapon );
        self setblockweaponpickup( weapon, 1 );
        return true;
    }
    
    level thread popups::displayteammessagetoall( &"KILLSTREAK_MP40_INBOUND", self );
    level weapons::add_limited_weapon( weapon, self, 3 );
    self takeweapon( currentweapon );
    self giveweapon( weapon );
    self switchtoweapon( weapon );
    self setblockweaponpickup( weapon, 1 );
    return true;
}

// Namespace supplydrop/supplydrop
// Params 2
// Checksum 0xeb6dc62e, Offset: 0x4ce0
// Size: 0x9a
function cleanupwatcherondeath( team, killstreak_id )
{
    player = self;
    self endon( #"disconnect", #"supplydropwatcher", #"trigger_weapon_shutdown", #"spawned_player", #"weapon_change" );
    self waittill( "death", "joined_team", "joined_spectators" );
    killstreakrules::killstreakstop( "supply_drop", team, killstreak_id );
    self notify( #"cleanup_marker" );
}

// Namespace supplydrop/supplydrop
// Params 2
// Checksum 0xa18cffe, Offset: 0x4d88
// Size: 0xe4
function cleanup( context, player )
{
    if ( isdefined( context ) && isdefined( context.marker ) )
    {
        context.marker delete();
        context.marker = undefined;
        
        if ( isdefined( context.markerfxhandle ) )
        {
            context.markerfxhandle delete();
            context.markerfxhandle = undefined;
        }
        
        if ( isdefined( player ) )
        {
            player clientfield::set_to_player( "marker_state", 0 );
        }
        
        deldroplocation( context.killstreak_id );
    }
}

// Namespace supplydrop/supplydrop
// Params 1
// Checksum 0xdc6b1f9f, Offset: 0x4e78
// Size: 0x36e
function markerupdatethread( context )
{
    player = self;
    player endon( #"supplydropwatcher" );
    player endon( #"weapon_change" );
    player endon( #"spawned_player" );
    player endon( #"disconnect" );
    player endon( #"death" );
    markermodel = spawn( "script_model", ( 0, 0, 0 ) );
    context.marker = markermodel;
    player thread markercleanupthread( context );
    
    while ( true )
    {
        if ( player flagsys::get( "marking_done" ) )
        {
            break;
        }
        
        minrange = level.killstreakcorebundle.ksminairdroptargetrange;
        maxrange = level.killstreakcorebundle.ksmaxairdroptargetrange;
        forwardvector = vectorscale( anglestoforward( player getplayerangles() ), maxrange );
        mask = 1;
        
        if ( isdefined( context.tracemask ) )
        {
            mask = context.tracemask;
        }
        
        radius = 2;
        results = physicstrace( player geteye(), player geteye() + forwardvector, ( radius * -1, radius * -1, 0 ), ( radius, radius, 2 * radius ), player, mask );
        markermodel.origin = results[ "position" ];
        tooclose = distancesquared( markermodel.origin, player.origin ) < minrange * minrange;
        
        if ( results[ "normal" ][ 2 ] > 0.7 && !tooclose && isdefined( context.islocationgood ) && [[ context.islocationgood ]]( markermodel.origin, context ) )
        {
            player.markerposition = markermodel.origin;
            player clientfield::set_to_player( "marker_state", 1 );
        }
        else
        {
            player.markerposition = undefined;
            player clientfield::set_to_player( "marker_state", 2 );
        }
        
        waitframe( 1 );
    }
}

// Namespace supplydrop/supplydrop
// Params 4
// Checksum 0xf9858bfd, Offset: 0x51f0
// Size: 0x45c
function supplydropwatcher( package_contents_id, trigger_event, supplydropweapon, context )
{
    player = self;
    self notify( #"supplydropwatcher" );
    self endon( #"supplydropwatcher", #"spawned_player", #"disconnect", #"weapon_change" );
    team = self.team;
    killstreak_id = killstreakrules::killstreakstart( "supply_drop", team, 0, 0 );
    
    if ( killstreak_id == -1 )
    {
        return;
    }
    
    context.killstreak_id = killstreak_id;
    player flagsys::clear( "marking_done" );
    
    if ( !supplydropweapon.isgrenadeweapon )
    {
        self thread markerupdatethread( context );
    }
    
    self thread checkforemp();
    self thread checkweaponchange( team, killstreak_id );
    self thread cleanupwatcherondeath( team, killstreak_id );
    
    while ( true )
    {
        waitresult = self waittill( trigger_event );
        weapon = waitresult.weapon;
        weapon_instance = waitresult.projectile;
        issupplydropweapon = 1;
        
        if ( trigger_event == "grenade_fire" )
        {
            issupplydropweapon = weapon.issupplydropweapon;
        }
        
        if ( isdefined( self ) && issupplydropweapon )
        {
            if ( isdefined( context ) )
            {
                if ( !isdefined( player.markerposition ) || !islocationgood( player.markerposition, context ) )
                {
                    if ( isdefined( level.killstreakcorebundle.ksinvalidlocationsound ) )
                    {
                        player playsoundtoplayer( level.killstreakcorebundle.ksinvalidlocationsound, player );
                    }
                    
                    if ( isdefined( level.killstreakcorebundle.ksinvalidlocationstring ) )
                    {
                        player iprintlnbold( istring( level.killstreakcorebundle.ksinvalidlocationstring ) );
                    }
                    
                    continue;
                }
                
                if ( isdefined( context.validlocationsound ) )
                {
                    player playsoundtoplayer( context.validlocationsound, player );
                }
                
                self thread helidelivercrate( player.markerposition, weapon, self, team, killstreak_id, package_contents_id, context );
            }
            else
            {
                self thread dosupplydrop( weapon_instance, weapon, self, killstreak_id, package_contents_id );
                weapon_instance thread do_supply_drop_detonation( weapon, self );
                weapon_instance thread supplydropgrenadetimeout( team, killstreak_id, weapon );
            }
            
            self killstreaks::switch_to_last_non_killstreak_weapon();
        }
        else
        {
            killstreakrules::killstreakstop( "supply_drop", team, killstreak_id );
            self notify( #"cleanup_marker" );
        }
        
        break;
    }
    
    player flagsys::set( "marking_done" );
    player clientfield::set_to_player( "marker_state", 0 );
}

// Namespace supplydrop/supplydrop
// Params 0
// Checksum 0x2d5ac04e, Offset: 0x5658
// Size: 0x6c
function checkforemp()
{
    self endon( #"supplydropwatcher" );
    self endon( #"spawned_player" );
    self endon( #"disconnect" );
    self endon( #"weapon_change" );
    self endon( #"death" );
    self endon( #"trigger_weapon_shutdown" );
    self waittill( "emp_jammed" );
    self killstreaks::switch_to_last_non_killstreak_weapon();
}

// Namespace supplydrop/supplydrop
// Params 3
// Checksum 0x9f5a4302, Offset: 0x56d0
// Size: 0x1d4
function supplydropgrenadetimeout( team, killstreak_id, weapon )
{
    self endon( #"death" );
    self endon( #"stationary" );
    grenade_lifetime = 10;
    wait grenade_lifetime;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self notify( #"grenade_timeout" );
    killstreakrules::killstreakstop( "supply_drop", team, killstreak_id );
    
    if ( weapon.name == "ai_tank_drop" )
    {
        killstreakrules::killstreakstop( "ai_tank_drop", team, killstreak_id );
        self notify( #"cleanup_marker" );
    }
    else if ( weapon.name == "inventory_ai_tank_drop" )
    {
        killstreakrules::killstreakstop( "inventory_ai_tank_drop", team, killstreak_id );
        self notify( #"cleanup_marker" );
    }
    else if ( weapon.name == "combat_robot_drop" )
    {
        killstreakrules::killstreakstop( "combat_robot_drop", team, killstreak_id );
        self notify( #"cleanup_marker" );
    }
    else if ( weapon.name == "inventory_combat_robot_drop" )
    {
        killstreakrules::killstreakstop( "inventory_combat_robot_drop", team, killstreak_id );
        self notify( #"cleanup_marker" );
    }
    
    self delete();
}

// Namespace supplydrop/supplydrop
// Params 2
// Checksum 0x6ea4bc92, Offset: 0x58b0
// Size: 0x8a
function checkweaponchange( team, killstreak_id )
{
    self endon( #"spawned_player" );
    self endon( #"supplydropwatcher" );
    self endon( #"trigger_weapon_shutdown" );
    self endon( #"disconnect" );
    self endon( #"death" );
    self waittill( "weapon_change" );
    killstreakrules::killstreakstop( "supply_drop", team, killstreak_id );
    self notify( #"cleanup_marker" );
}

// Namespace supplydrop/supplydrop
// Params 1
// Checksum 0x4c17666a, Offset: 0x5948
// Size: 0x144
function supplydropgrenadepullwatcher( killstreak_id )
{
    self endon( #"disconnect" );
    self endon( #"weapon_change" );
    waitresult = self waittill( "grenade_pullback" );
    weapon = waitresult.weapon;
    self util::_disableusability();
    self thread watchforgrenadeputdown();
    self waittill( "death" );
    killstreak = "supply_drop";
    self.supplygrenadedeathdrop = 1;
    
    if ( weapon.issupplydropweapon )
    {
        killstreak = killstreaks::get_killstreak_for_weapon( weapon );
    }
    
    if ( !( isdefined( self.usingkillstreakfrominventory ) && self.usingkillstreakfrominventory ) )
    {
        self killstreaks::change_killstreak_quantity( weapon, -1 );
        return;
    }
    
    killstreaks::remove_used_killstreak( killstreak, killstreak_id );
}

// Namespace supplydrop/supplydrop
// Params 0
// Checksum 0xe1a0deef, Offset: 0x5a98
// Size: 0x6c
function watchforgrenadeputdown()
{
    self notify( #"watchforgrenadeputdown" );
    self endon( #"watchforgrenadeputdown" );
    self endon( #"death" );
    self endon( #"disconnect" );
    self waittill( "grenade_fire", "weapon_change" );
    self notify( #"trigger_weapon_shutdown" );
    self util::_enableusability();
}

// Namespace supplydrop/supplydrop
// Params 0
// Checksum 0x9c34326, Offset: 0x5b10
// Size: 0x9a
function playerchangeweaponwaiter()
{
    self endon( #"supply_drop_marker_done" );
    self endon( #"disconnect" );
    self endon( #"spawned_player" );
    
    for ( currentweapon = self getcurrentweapon(); currentweapon.issupplydropweapon ; currentweapon = waitresult.weapon )
    {
        waitresult = self waittill( "weapon_change" );
    }
    
    waittillframeend();
    self notify( #"supply_drop_marker_done" );
}

// Namespace supplydrop/supplydrop
// Params 0
// Checksum 0x7f4e80dc, Offset: 0x5bb8
// Size: 0x1d4
function geticonforcrate()
{
    icon = undefined;
    
    switch ( self.cratetype.type )
    {
        case #"killstreak":
            if ( isdefined( self.cratetype.objective ) )
            {
                return self.cratetype.objective;
            }
            else if ( self.cratetype.name == "inventory_ai_tank_drop" )
            {
                icon = "t7_hud_ks_drone_amws";
            }
            else
            {
                killstreak = killstreaks::get_menu_name( self.cratetype.name );
                icon = level.killstreakicons[ killstreak ];
            }
            
            goto LOC_00000180;
        case #"weapon":
            switch ( self.cratetype.name )
            {
                case #"minigun":
                    icon = "hud_ks_minigun";
                    break;
                case #"m32":
                    icon = "hud_ks_m32";
                    break;
                case #"m202_flash":
                    icon = "hud_ks_m202";
                    break;
                case #"m220_tow":
                    icon = "hud_ks_tv_guided_missile";
                    break;
                case #"mp40_drop":
                    icon = "hud_mp40";
                    break;
                default:
                    icon = "waypoint_recon_artillery_strike";
                    break;
            }
            
        LOC_00000180:
            break;
        case #"ammo":
            icon = "hud_ammo_refill";
            break;
        default:
            return undefined;
    }
    
    return icon + "_drop";
}

// Namespace supplydrop/supplydrop
// Params 1
// Checksum 0x917ea6cd, Offset: 0x5d98
// Size: 0x6c4
function crateactivate( hacker )
{
    self makeusable();
    self setcursorhint( "HINT_NOICON" );
    
    if ( !isdefined( self.cratetype ) )
    {
        return;
    }
    
    self sethintstring( self.cratetype.hint );
    
    if ( isdefined( self.cratetype.hint_gambler ) )
    {
        self sethintstringforperk( "specialty_showenemyequipment", self.cratetype.hint_gambler );
    }
    
    crateobjid = gameobjects::get_next_obj_id();
    objective_add( crateobjid, "invisible", self.origin );
    objective_setcolor( crateobjid, &"FriendlyBlue" );
    objective_setstate( crateobjid, "active" );
    self.friendlyobjid = crateobjid;
    self.enemyobjid = [];
    icon = self geticonforcrate();
    
    if ( isdefined( hacker ) )
    {
        self clientfield::set( "enemyequip", 0 );
    }
    
    if ( level.teambased )
    {
        objective_setteam( crateobjid, self.team );
        
        foreach ( team in level.teams )
        {
            if ( self.team == team )
            {
                continue;
            }
            
            crateobjid = gameobjects::get_next_obj_id();
            objective_add( crateobjid, "invisible", self.origin );
            
            if ( isdefined( self.hacker ) )
            {
            }
            else
            {
                objective_setcolor( crateobjid, &"EnemyOrange" );
            }
            
            objective_setteam( crateobjid, team );
            objective_setstate( crateobjid, "active" );
            self.enemyobjid[ self.enemyobjid.size ] = crateobjid;
        }
    }
    else
    {
        if ( !self.visibletoall )
        {
            objective_setinvisibletoall( crateobjid );
            enemycrateobjid = gameobjects::get_next_obj_id();
            objective_add( enemycrateobjid, "invisible", self.origin );
            objective_setcolor( enemycrateobjid, &"EnemyOrange" );
            objective_setstate( enemycrateobjid, "active" );
            
            if ( isplayer( self.owner ) )
            {
                objective_setinvisibletoplayer( enemycrateobjid, self.owner );
            }
            
            self.enemyobjid[ self.enemyobjid.size ] = enemycrateobjid;
        }
        
        if ( isplayer( self.owner ) )
        {
            objective_setvisibletoplayer( crateobjid, self.owner );
        }
        
        if ( isdefined( self.hacker ) )
        {
            objective_setinvisibletoplayer( crateobjid, self.hacker );
            crateobjid = gameobjects::get_next_obj_id();
            objective_add( crateobjid, "invisible", self.origin );
            objective_setstate( crateobjid, "active" );
            objective_setinvisibletoall( crateobjid );
            objective_setvisibletoplayer( crateobjid, self.hacker );
            self.hackerobjid = crateobjid;
        }
    }
    
    if ( !self.visibletoall && isdefined( icon ) )
    {
        self entityheadicons::setentityheadicon( self.team, self, level.crate_headicon_offset, icon, 1 );
        
        if ( self.entityheadobjectives.size > 0 )
        {
            objectiveid = self.entityheadobjectives[ self.entityheadobjectives.size - 1 ];
            
            if ( isdefined( objectiveid ) )
            {
                objective_setinvisibletoall( objectiveid );
                objective_setvisibletoplayer( objectiveid, self.owner );
            }
        }
    }
    
    if ( isdefined( self.owner ) && isplayer( self.owner ) && self.owner isbot() )
    {
        self.owner notify( #"bot_crate_landed", { #crate:self } );
    }
    
    if ( isdefined( self.owner ) )
    {
        self.owner notify( #"crate_landed", { #crate:self } );
        setricochetprotectionendtime( "supply_drop", self.killstreak_id, self.owner );
    }
}

// Namespace supplydrop/supplydrop
// Params 3
// Checksum 0xb0bc174f, Offset: 0x6468
// Size: 0xb4
function setricochetprotectionendtime( killstreak, killstreak_id, owner )
{
    ksbundle = level.killstreakbundle[ killstreak ];
    
    if ( isdefined( ksbundle ) && isdefined( ksbundle.ksricochetpostlandduration ) && ksbundle.ksricochetpostlandduration > 0 )
    {
        endtime = gettime() + ksbundle.ksricochetpostlandduration * 1000;
        killstreaks::set_ricochet_protection_endtime( killstreak_id, owner, endtime );
    }
}

// Namespace supplydrop/supplydrop
// Params 0
// Checksum 0x6b4c4434, Offset: 0x6528
// Size: 0x176
function cratedeactivate()
{
    self makeunusable();
    
    if ( isdefined( self.friendlyobjid ) )
    {
        objective_delete( self.friendlyobjid );
        gameobjects::release_obj_id( self.friendlyobjid );
        self.friendlyobjid = undefined;
    }
    
    if ( isdefined( self.enemyobjid ) )
    {
        foreach ( objid in self.enemyobjid )
        {
            objective_delete( objid );
            gameobjects::release_obj_id( objid );
        }
        
        self.enemyobjid = [];
    }
    
    if ( isdefined( self.hackerobjid ) )
    {
        objective_delete( self.hackerobjid );
        gameobjects::release_obj_id( self.hackerobjid );
        self.hackerobjid = undefined;
    }
}

// Namespace supplydrop/supplydrop
// Params 0
// Checksum 0x56e23e4a, Offset: 0x66a8
// Size: 0x6e
function ownerteamchangewatcher()
{
    self notify( #"ownerteamchangewatcher_singleton" );
    self endon( #"ownerteamchangewatcher_singleton" );
    self endon( #"death" );
    
    if ( !level.teambased || !isdefined( self.owner ) )
    {
        return;
    }
    
    self.owner waittill( "joined_team" );
    self.owner = undefined;
}

// Namespace supplydrop/supplydrop
// Params 3
// Checksum 0xa978444c, Offset: 0x6720
// Size: 0x9c
function dropalltoground( origin, radius, stickyobjectradius )
{
    physicsexplosionsphere( origin, radius, radius, 0 );
    waitframe( 1 );
    weapons::drop_all_to_ground( origin, radius );
    dropcratestoground( origin, radius );
    level notify( #"drop_objects_to_ground", { #position:origin, #radius:stickyobjectradius } );
}

// Namespace supplydrop/supplydrop
// Params 1
// Checksum 0x38bc2199, Offset: 0x67c8
// Size: 0x2c
function dropeverythingtouchingcrate( origin )
{
    dropalltoground( origin, 70, 70 );
}

// Namespace supplydrop/supplydrop
// Params 2
// Checksum 0xb09f38e7, Offset: 0x6800
// Size: 0x44
function dropalltogroundaftercratedelete( crate, crate_origin )
{
    crate waittill( "death" );
    wait 0.1;
    crate dropeverythingtouchingcrate( crate_origin );
}

// Namespace supplydrop/supplydrop
// Params 2
// Checksum 0xd7f49a82, Offset: 0x6850
// Size: 0xd6
function dropcratestoground( origin, radius )
{
    crate_ents = getentarray( "care_package", "script_noteworthy" );
    radius_sq = radius * radius;
    
    for ( i = 0; i < crate_ents.size ; i++ )
    {
        if ( distancesquared( origin, crate_ents[ i ].origin ) < radius_sq )
        {
            crate_ents[ i ] thread dropcratetoground();
        }
    }
}

// Namespace supplydrop/supplydrop
// Params 0
// Checksum 0x280c14d, Offset: 0x6930
// Size: 0xb6
function dropcratetoground()
{
    self endon( #"death" );
    
    if ( isdefined( self.droppingtoground ) )
    {
        return;
    }
    
    self.droppingtoground = 1;
    dropeverythingtouchingcrate( self.origin );
    self cratedeactivate();
    self thread cratedroptogroundkill();
    self crateredophysics();
    self crateactivate();
    self.droppingtoground = undefined;
}

// Namespace supplydrop/supplydrop
// Params 1
// Checksum 0x534f458b, Offset: 0x69f0
// Size: 0x34
function configureteampost( owner )
{
    crate = self;
    crate thread ownerteamchangewatcher();
}

// Namespace supplydrop/supplydrop
// Params 6
// Checksum 0xf9c2d8d1, Offset: 0x6a30
// Size: 0x346
function cratespawn( killstreak, killstreakid, owner, team, drop_origin, drop_angle )
{
    crate = spawn( "script_model", drop_origin, 1 );
    crate killstreaks::configure_team( killstreak, killstreakid, owner, undefined, undefined, &configureteampost );
    crate.angles = drop_angle;
    crate.visibletoall = 0;
    crate.script_noteworthy = "care_package";
    crate clientfield::set( "enemyequip", 1 );
    
    if ( killstreak == "ai_tank_drop" || killstreak == "inventory_ai_tank_drop" )
    {
        crate setmodel( level.cratemodeltank );
        crate setenemymodel( level.cratemodeltank );
    }
    else
    {
        crate setmodel( level.cratemodelfriendly );
        crate setenemymodel( level.cratemodelenemy );
    }
    
    crate disconnectpaths();
    
    switch ( killstreak )
    {
        case #"turret_drop":
            crate.cratetype = level.cratetypes[ killstreak ][ "autoturret" ];
            break;
        case #"tow_turret_drop":
            crate.cratetype = level.cratetypes[ killstreak ][ "auto_tow" ];
            break;
        case #"m220_tow_drop":
            crate.cratetype = level.cratetypes[ killstreak ][ "m220_tow" ];
            break;
        case #"ai_tank_drop":
        case #"inventory_ai_tank_drop":
            crate.cratetype = level.cratetypes[ killstreak ][ "ai_tank_drop" ];
            break;
        case #"inventory_minigun_drop":
        case #"minigun_drop":
            crate.cratetype = level.cratetypes[ killstreak ][ "minigun" ];
            break;
        case #"inventory_m32_drop":
        case #"m32_drop":
            crate.cratetype = level.cratetypes[ killstreak ][ "m32" ];
            break;
        default:
            crate.cratetype = getrandomcratetype( "supplydrop" );
            break;
    }
    
    return crate;
}

// Namespace supplydrop/supplydrop
// Params 1
// Checksum 0xd13dfdf4, Offset: 0x6d80
// Size: 0x21c
function cratedelete( drop_all_to_ground )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    killstreaks::remove_ricochet_protection( self.killstreak_id, self.originalowner );
    
    if ( !isdefined( drop_all_to_ground ) )
    {
        drop_all_to_ground = 1;
    }
    
    if ( isdefined( self.friendlyobjid ) )
    {
        objective_delete( self.friendlyobjid );
        gameobjects::release_obj_id( self.friendlyobjid );
        self.friendlyobjid = undefined;
    }
    
    if ( isdefined( self.enemyobjid ) )
    {
        foreach ( objid in self.enemyobjid )
        {
            objective_delete( objid );
            gameobjects::release_obj_id( objid );
        }
        
        self.enemyobjid = undefined;
    }
    
    if ( isdefined( self.hackerobjid ) )
    {
        objective_delete( self.hackerobjid );
        gameobjects::release_obj_id( self.hackerobjid );
        self.hackerobjid = undefined;
    }
    
    if ( drop_all_to_ground )
    {
        level thread dropalltogroundaftercratedelete( self, self.origin );
    }
    
    if ( isdefined( self.killcament ) )
    {
        self.killcament thread util::deleteaftertime( 5 );
    }
    
    self delete();
}

// Namespace supplydrop/supplydrop
// Params 0
// Checksum 0x8cebcee2, Offset: 0x6fa8
// Size: 0x56
function stationarycrateoverride()
{
    self endon( #"death" );
    self endon( #"stationary" );
    wait 3;
    self.angles = self.angles;
    self.origin = self.origin;
    self notify( #"stationary" );
}

// Namespace supplydrop/supplydrop
// Params 0
// Checksum 0x1b38bc11, Offset: 0x7008
// Size: 0x3c
function timeoutcratewaiter()
{
    self endon( #"death" );
    self endon( #"stationary" );
    wait 20;
    self cratedelete( 1 );
}

// Namespace supplydrop/supplydrop
// Params 0
// Checksum 0x2d33ed5f, Offset: 0x7050
// Size: 0x11a
function cratephysics()
{
    forcepoint = self.origin;
    params = level.killstreakbundle[ "supply_drop" ];
    
    if ( !isdefined( params.kslandingvelocity ) )
    {
        params.kslandingvelocity = 100;
    }
    
    initialvelocity = ( 0, 0, params.kslandingvelocity * -1 / 40 );
    self physicslaunch( forcepoint, initialvelocity );
    self thread timeoutcratewaiter();
    self thread stationarycrateoverride();
    self thread update_crate_velocity();
    self thread play_impact_sound();
    self waittill( "stationary" );
}

// Namespace supplydrop/supplydrop
// Params 1
// Checksum 0xd7d7c6a0, Offset: 0x7178
// Size: 0xea
function get_height( e_ignore )
{
    if ( !isdefined( e_ignore ) )
    {
        e_ignore = self;
    }
    
    trace = groundtrace( self.origin + ( 0, 0, 10 ), self.origin + ( 0, 0, -10000 ), 0, e_ignore, 0 );
    
    /#
        recordline( self.origin + ( 0, 0, 10 ), trace[ "position" ], ( 1, 0.5, 0 ), "Animscript", self );
    #/
    
    return distance( self.origin, trace[ "position" ] );
}

// Namespace supplydrop/supplydrop
// Params 2
// Checksum 0xab118819, Offset: 0x7270
// Size: 0x30c
function cratecontrolleddrop( killstreak, v_target_location )
{
    crate = self;
    supplydrop = 1;
    
    if ( killstreak == "ai_tank_drop" )
    {
        supplydrop = 0;
    }
    
    if ( supplydrop )
    {
        params = level.killstreakbundle[ "supply_drop" ];
    }
    else
    {
        params = level.killstreakbundle[ "ai_tank_drop" ];
    }
    
    if ( !isdefined( params.ksthrustersoffheight ) )
    {
        params.ksthrustersoffheight = 100;
    }
    
    if ( !isdefined( params.kstotaldroptime ) )
    {
        params.kstotaldroptime = 4;
    }
    
    if ( !isdefined( params.ksacceltimepercentage ) )
    {
        params.ksacceltimepercentage = 0.65;
    }
    
    acceltime = params.kstotaldroptime * params.ksacceltimepercentage;
    deceltime = params.kstotaldroptime - acceltime;
    target = ( v_target_location[ 0 ], v_target_location[ 1 ], v_target_location[ 2 ] + params.ksthrustersoffheight );
    hostmigration::waittillhostmigrationdone();
    crate moveto( target, params.kstotaldroptime, acceltime, deceltime );
    crate thread watchforcratekill( v_target_location[ 2 ] + ( isdefined( params.ksstartcratekillheightfromground ) ? params.ksstartcratekillheightfromground : 200 ) );
    wait acceltime - 0.05;
    
    if ( supplydrop )
    {
        crate clientfield::set( "supplydrop_thrusters_state", 1 );
    }
    else
    {
        crate clientfield::set( "aitank_thrusters_state", 1 );
    }
    
    crate waittill( "movedone" );
    hostmigration::waittillhostmigrationdone();
    
    if ( supplydrop )
    {
        crate clientfield::set( "supplydrop_thrusters_state", 0 );
    }
    else
    {
        crate clientfield::set( "aitank_thrusters_state", 0 );
    }
    
    crate cratephysics();
}

// Namespace supplydrop/supplydrop
// Params 0
// Checksum 0x445e1152, Offset: 0x7588
// Size: 0x74
function play_impact_sound()
{
    self endon( #"stationary" );
    self endon( #"death" );
    wait 0.5;
    
    while ( abs( self.velocity[ 2 ] ) > 5 )
    {
        wait 0.1;
    }
    
    self playsound( "phy_impact_supply" );
}

// Namespace supplydrop/supplydrop
// Params 0
// Checksum 0x7dcf6f2d, Offset: 0x7608
// Size: 0x86
function update_crate_velocity()
{
    self endon( #"death" );
    self endon( #"stationary" );
    self.velocity = ( 0, 0, 0 );
    self.old_origin = self.origin;
    
    while ( isdefined( self ) )
    {
        self.velocity = self.origin - self.old_origin;
        self.old_origin = self.origin;
        waitframe( 1 );
    }
}

// Namespace supplydrop/supplydrop
// Params 0
// Checksum 0xbfb2ecd5, Offset: 0x7698
// Size: 0x8a
function crateredophysics()
{
    forcepoint = self.origin;
    initialvelocity = ( 0, 0, 0 );
    self physicslaunch( forcepoint, initialvelocity );
    self thread timeoutcratewaiter();
    self thread stationarycrateoverride();
    self waittill( "stationary" );
}

// Namespace supplydrop/supplydrop
// Params 2
// Checksum 0xe475444b, Offset: 0x7730
// Size: 0x1a4
function do_supply_drop_detonation( weapon, owner )
{
    self notify( #"supplydropwatcher" );
    self endon( #"supplydropwatcher" );
    self endon( #"spawned_player" );
    self endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"grenade_timeout" );
    self util::waittillnotmoving();
    self.angles = ( 0, self.angles[ 1 ], 90 );
    fuse_time = weapon.fusetime / 1000;
    wait fuse_time;
    
    if ( !isdefined( owner ) || !owner emp::enemyempactive() )
    {
        thread smokegrenade::playsmokesound( self.origin, 6, level.sound_smoke_start, level.sound_smoke_stop, level.sound_smoke_loop );
        playfxontag( level._supply_drop_smoke_fx, self, "tag_fx" );
        proj_explosion_sound = weapon.projexplosionsound;
        sound::play_in_space( proj_explosion_sound, self.origin );
    }
    
    wait 3;
    self delete();
}

// Namespace supplydrop/supplydrop
// Params 6
// Checksum 0xbfe526d4, Offset: 0x78e0
// Size: 0xfc
function dosupplydrop( weapon_instance, weapon, owner, killstreak_id, package_contents_id, context )
{
    weapon endon( #"explode", #"grenade_timeout" );
    self endon( #"disconnect" );
    team = owner.team;
    weapon_instance thread watchexplode( weapon, owner, killstreak_id, package_contents_id );
    weapon_instance util::waittillnotmoving();
    weapon_instance notify( #"stoppedmoving" );
    self thread helidelivercrate( weapon_instance.origin, weapon, owner, team, killstreak_id, package_contents_id, context );
}

// Namespace supplydrop/supplydrop
// Params 4
// Checksum 0x3a5b834, Offset: 0x79e8
// Size: 0x9c
function watchexplode( weapon, owner, killstreak_id, package_contents_id )
{
    self endon( #"stoppedmoving" );
    team = owner.team;
    waitresult = self waittill( "explode" );
    owner thread helidelivercrate( waitresult.position, weapon, owner, team, killstreak_id, package_contents_id );
}

// Namespace supplydrop/supplydrop
// Params 0
// Checksum 0x485ef1a4, Offset: 0x7a90
// Size: 0x44
function cratetimeoutthreader()
{
    crate = self;
    cratetimeout( 90 );
    crate thread deleteonownerleave();
}

// Namespace supplydrop/supplydrop
// Params 1
// Checksum 0x3b2ac4fb, Offset: 0x7ae0
// Size: 0x54
function cratetimeout( time )
{
    crate = self;
    self thread killstreaks::waitfortimeout( "inventory_supply_drop", 90000, &cratedelete, "death" );
}

// Namespace supplydrop/supplydrop
// Params 0
// Checksum 0x8d6611ae, Offset: 0x7b40
// Size: 0x64
function deleteonownerleave()
{
    crate = self;
    crate endon( #"death" );
    crate.owner waittill( "joined_team", "joined_spectators", "disconnect" );
    crate cratedelete( 1 );
}

// Namespace supplydrop/supplydrop
// Params 1
// Checksum 0xf0a78eb1, Offset: 0x7bb0
// Size: 0x34
function waitanddelete( time )
{
    self endon( #"death" );
    wait time;
    self delete();
}

// Namespace supplydrop/supplydrop
// Params 10
// Checksum 0x4731b734, Offset: 0x7bf0
// Size: 0x434
function dropcrate( origin, angle, killstreak, owner, team, killcament, killstreak_id, package_contents_id, crate_, context )
{
    angle = ( angle[ 0 ] * 0.5, angle[ 1 ] * 0.5, angle[ 2 ] * 0.5 );
    
    if ( isdefined( crate_ ) )
    {
        origin = crate_.origin;
        angle = crate_.angles;
        crate_ thread waitanddelete( 0.1 );
    }
    
    crate = cratespawn( killstreak, killstreak_id, owner, team, origin, angle );
    killcament unlink();
    killcament linkto( crate );
    crate.killcament = killcament;
    crate.killstreak_id = killstreak_id;
    crate.package_contents_id = package_contents_id;
    killcament thread util::deleteaftertime( 15 );
    killcament thread unlinkonrotation( crate );
    crate endon( #"death" );
    crate cratetimeoutthreader();
    trace = groundtrace( crate.origin + ( 0, 0, -100 ), crate.origin + ( 0, 0, -10000 ), 0, crate, 0 );
    v_target_location = trace[ "position" ];
    
    /#
        if ( getdvarint( "scr_supply_drop_valid_location_debug", 0 ) )
        {
            util::drawcylinder( v_target_location, context.radius, 8000, 99999999, "stop_heli_drop_valid_location_dropped_cylinder", ( 0, 0, 0.9 ), 0.8 );
        }
    #/
    
    crate cratecontrolleddrop( killstreak, v_target_location );
    crate thread hacker_tool::registerwithhackertool( level.carepackagehackertoolradius, level.carepackagehackertooltimems );
    cleanup( context, owner );
    
    if ( isdefined( crate.cratetype ) && isdefined( crate.cratetype.landfunctionoverride ) )
    {
        [[ crate.cratetype.landfunctionoverride ]]( crate, killstreak, owner, team, context );
        return;
    }
    
    crate crateactivate();
    crate thread crateusethink();
    crate thread crateusethinkowner();
    
    if ( isdefined( crate.cratetype ) && isdefined( crate.cratetype.hint_gambler ) )
    {
        crate thread crategamblerthink();
    }
    
    default_land_function( crate, killstreak, owner, team );
}

// Namespace supplydrop/supplydrop
// Params 1
// Checksum 0x626f4a0a, Offset: 0x8030
// Size: 0x174
function unlinkonrotation( crate )
{
    self endon( #"delete" );
    crate endon( #"death" );
    crate endon( #"stationary" );
    waitbeforerotationcheck = getdvarfloat( "scr_supplydrop_killcam_rot_wait", 0.5 );
    wait waitbeforerotationcheck;
    mincos = getdvarfloat( "scr_supplydrop_killcam_max_rot", 0.999 );
    cosine = 1;
    currentdirection = vectornormalize( anglestoforward( crate.angles ) );
    
    while ( cosine > mincos )
    {
        olddirection = currentdirection;
        waitframe( 1 );
        currentdirection = vectornormalize( anglestoforward( crate.angles ) );
        cosine = vectordot( olddirection, currentdirection );
    }
    
    self unlink();
}

// Namespace supplydrop/supplydrop
// Params 4
// Checksum 0x18c56518, Offset: 0x81b0
// Size: 0x1fa
function default_land_function( crate, category, owner, team )
{
    while ( true )
    {
        waitresult = crate waittill( "captured" );
        player = waitresult.player;
        remote_hack = waitresult.is_remote_hack;
        player challenges::capturedcrate( owner );
        deletecrate = player givecrateitem( crate );
        
        if ( isdefined( deletecrate ) && !deletecrate )
        {
            continue;
        }
        
        playerhasengineerperk = player hasperk( "specialty_showenemyequipment" );
        
        if ( level.teambased && team != player.team || ( playerhasengineerperk || remote_hack == 1 ) && owner != player && !level.teambased )
        {
            spawn_explosive_crate( crate.origin, crate.angles, category, owner, team, player, playerhasengineerperk );
            crate makeunusable();
            util::wait_network_frame();
            crate cratedelete( 0 );
            return;
        }
        
        crate cratedelete( 1 );
        return;
    }
}

// Namespace supplydrop/supplydrop
// Params 7
// Checksum 0x8608933f, Offset: 0x83b8
// Size: 0x1f0
function spawn_explosive_crate( origin, angle, killstreak, owner, team, hacker, playerhasengineerperk )
{
    crate = cratespawn( killstreak, undefined, owner, team, origin, angle );
    crate setowner( owner );
    crate setteam( team );
    
    if ( level.teambased )
    {
        crate setenemymodel( level.cratemodelboobytrapped );
        crate makeusable( team );
    }
    else
    {
        crate setenemymodel( level.cratemodelenemy );
    }
    
    crate.hacker = hacker;
    crate.visibletoall = 0;
    crate crateactivate( hacker );
    crate sethintstringforperk( "specialty_showenemyequipment", level.supplydropdisarmcrate );
    crate thread crateusethink();
    crate thread crateusethinkowner();
    crate thread watch_explosive_crate();
    crate cratetimeoutthreader();
    crate.playerhasengineerperk = playerhasengineerperk;
}

// Namespace supplydrop/supplydrop
// Params 0
// Checksum 0x4dc34f5e, Offset: 0x85b0
// Size: 0x27c
function watch_explosive_crate()
{
    killcament = spawn( "script_model", self.origin + ( 0, 0, 60 ) );
    self.killcament = killcament;
    waitresult = self waittill( "captured" );
    remote_hack = waitresult.is_remote_hack;
    player = waitresult.player;
    
    if ( !player hasperk( "specialty_showenemyequipment" ) && !remote_hack )
    {
        self thread entityheadicons::setentityheadicon( player.team, player, level.crate_headicon_offset, "headicon_dead", 1 );
        self loop_sound( "wpn_semtex_alert", 0.15 );
        
        if ( !isdefined( self.hacker ) )
        {
            self.hacker = self;
        }
        
        self radiusdamage( self.origin, 256, 300, 75, self.hacker, "MOD_EXPLOSIVE", getweapon( "supplydrop" ) );
        playfx( level._supply_drop_explosion_fx, self.origin );
        playsoundatposition( "wpn_grenade_explode", self.origin );
    }
    else
    {
        playsoundatposition( "mpl_turret_alert", self.origin );
        scoreevents::processscoreevent( "disarm_hacked_care_package", player );
        player challenges::disarmedhackedcarepackage();
    }
    
    wait 0.1;
    self cratedelete();
    killcament thread util::deleteaftertime( 5 );
}

// Namespace supplydrop/supplydrop
// Params 2
// Checksum 0x6ffad0b0, Offset: 0x8838
// Size: 0x78
function loop_sound( alias, interval )
{
    self endon( #"death" );
    
    while ( true )
    {
        playsoundatposition( alias, self.origin );
        wait interval;
        interval /= 1.2;
        
        if ( interval < 0.08 )
        {
            break;
        }
    }
}

// Namespace supplydrop/supplydrop
// Params 1
// Checksum 0x8ead09fc, Offset: 0x88b8
// Size: 0x168
function watchforcratekill( start_kill_watch_z_threshold )
{
    crate = self;
    crate endon( #"death" );
    crate endon( #"stationary" );
    
    while ( crate.origin[ 2 ] > start_kill_watch_z_threshold )
    {
        waitframe( 1 );
    }
    
    stationarythreshold = 2;
    killthreshold = 15;
    maxframestillstationary = 20;
    numframesstationary = 0;
    
    while ( true )
    {
        vel = 0;
        
        if ( isdefined( self.velocity ) )
        {
            vel = abs( self.velocity[ 2 ] );
        }
        
        if ( vel > killthreshold )
        {
            crate is_touching_crate();
            crate is_clone_touching_crate();
        }
        
        if ( vel < stationarythreshold )
        {
            numframesstationary++;
        }
        else
        {
            numframesstationary = 0;
        }
        
        if ( numframesstationary >= maxframestillstationary )
        {
            break;
        }
        
        waitframe( 1 );
    }
}

// Namespace supplydrop/supplydrop
// Params 0
// Checksum 0xd95dc3d8, Offset: 0x8a28
// Size: 0x11c
function cratekill()
{
    self endon( #"death" );
    stationarythreshold = 2;
    killthreshold = 15;
    maxframestillstationary = 20;
    numframesstationary = 0;
    
    while ( true )
    {
        vel = 0;
        
        if ( isdefined( self.velocity ) )
        {
            vel = abs( self.velocity[ 2 ] );
        }
        
        if ( vel > killthreshold )
        {
            self is_touching_crate();
            self is_clone_touching_crate();
        }
        
        if ( vel < stationarythreshold )
        {
            numframesstationary++;
        }
        else
        {
            numframesstationary = 0;
        }
        
        if ( numframesstationary >= maxframestillstationary )
        {
            break;
        }
        
        wait 0.01;
    }
}

// Namespace supplydrop/supplydrop
// Params 0
// Checksum 0xc5b408f2, Offset: 0x8b50
// Size: 0x42c
function cratedroptogroundkill()
{
    self endon( #"death" );
    self endon( #"stationary" );
    
    for ( ;; )
    {
        players = getplayers();
        dotrace = 0;
        
        for ( i = 0; i < players.size ; i++ )
        {
            if ( players[ i ].sessionstate != "playing" )
            {
                continue;
            }
            
            if ( players[ i ].team == "spectator" )
            {
                continue;
            }
            
            self is_equipment_touching_crate( players[ i ] );
            
            if ( !isalive( players[ i ] ) )
            {
                continue;
            }
            
            flattenedselforigin = ( self.origin[ 0 ], self.origin[ 1 ], 0 );
            flattenedplayerorigin = ( players[ i ].origin[ 0 ], players[ i ].origin[ 1 ], 0 );
            
            if ( distancesquared( flattenedselforigin, flattenedplayerorigin ) > 4096 )
            {
                continue;
            }
            
            dotrace = 1;
            break;
        }
        
        if ( dotrace )
        {
            start = self.origin;
            cratedroptogroundtrace( start );
            start = self getpointinbounds( 1, 0, 0 );
            cratedroptogroundtrace( start );
            start = self getpointinbounds( -1, 0, 0 );
            cratedroptogroundtrace( start );
            start = self getpointinbounds( 0, -1, 0 );
            cratedroptogroundtrace( start );
            start = self getpointinbounds( 0, 1, 0 );
            cratedroptogroundtrace( start );
            start = self getpointinbounds( 1, 1, 0 );
            cratedroptogroundtrace( start );
            start = self getpointinbounds( -1, 1, 0 );
            cratedroptogroundtrace( start );
            start = self getpointinbounds( 1, -1, 0 );
            cratedroptogroundtrace( start );
            start = self getpointinbounds( -1, -1, 0 );
            cratedroptogroundtrace( start );
            wait 0.2;
            continue;
        }
        
        wait 0.5;
    }
}

// Namespace supplydrop/supplydrop
// Params 1
// Checksum 0x874d1501, Offset: 0x8f88
// Size: 0x1fc
function cratedroptogroundtrace( start )
{
    end = start + ( 0, 0, -8000 );
    trace = bullettrace( start, end, 1, self, 1, 1 );
    
    if ( isdefined( trace[ "entity" ] ) && isplayer( trace[ "entity" ] ) && isalive( trace[ "entity" ] ) )
    {
        player = trace[ "entity" ];
        
        if ( player.sessionstate != "playing" )
        {
            return;
        }
        
        if ( player.team == "spectator" )
        {
            return;
        }
        
        if ( distancesquared( start, trace[ "position" ] ) < 144 || self istouching( player ) )
        {
            player dodamage( player.health + 1, player.origin, self.owner, self, "none", "MOD_HIT_BY_OBJECT", 0, getweapon( "supplydrop" ) );
            player playsound( "mpl_supply_crush" );
            player playsound( "phy_impact_supply" );
        }
    }
}

// Namespace supplydrop/supplydrop
// Params 0
// Checksum 0x63cb4439, Offset: 0x9190
// Size: 0x3c2
function is_touching_crate()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    crate = self;
    extraboundary = ( 10, 10, 10 );
    players = getplayers();
    crate_bottom_point = self.origin;
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) && isalive( player ) )
        {
            stance = player getstance();
            stance_z_offset = stance == "crouch" ? 18 : stance == "stand" ? 40 : 6;
            player_test_point = player.origin + ( 0, 0, stance_z_offset );
            
            if ( player_test_point[ 2 ] < crate_bottom_point[ 2 ] && self istouching( player, extraboundary ) )
            {
                attacker = isdefined( self.owner ) ? self.owner : self;
                player dodamage( player.health + 1, player.origin, attacker, self, "none", "MOD_HIT_BY_OBJECT", 0, getweapon( "supplydrop" ) );
                player playsound( "mpl_supply_crush" );
                player playsound( "phy_impact_supply" );
            }
        }
        
        self is_equipment_touching_crate( player );
    }
    
    vehicles = getentarray( "script_vehicle", "classname" );
    
    foreach ( vehicle in vehicles )
    {
        if ( isvehicle( vehicle ) )
        {
            if ( isdefined( vehicle.archetype ) && vehicle.archetype == "wasp" )
            {
                if ( crate istouching( vehicle, ( 2, 2, 2 ) ) )
                {
                    vehicle notify( #"sentinel_shutdown" );
                }
            }
        }
    }
}

// Namespace supplydrop/supplydrop
// Params 0
// Checksum 0x736060d7, Offset: 0x9560
// Size: 0x1fe
function is_clone_touching_crate()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    extraboundary = ( 10, 10, 10 );
    actors = getactorarray();
    
    for ( i = 0; i < actors.size ; i++ )
    {
        if ( isdefined( actors[ i ] ) && isdefined( actors[ i ].isaiclone ) && isalive( actors[ i ] ) && actors[ i ].origin[ 2 ] < self.origin[ 2 ] && self istouching( actors[ i ], extraboundary ) )
        {
            attacker = isdefined( self.owner ) ? self.owner : self;
            actors[ i ] dodamage( actors[ i ].health + 1, actors[ i ].origin, attacker, self, "none", "MOD_HIT_BY_OBJECT", 0, getweapon( "supplydrop" ) );
            actors[ i ] playsound( "mpl_supply_crush" );
            actors[ i ] playsound( "phy_impact_supply" );
        }
    }
}

// Namespace supplydrop/supplydrop
// Params 1
// Checksum 0x2f9bf22, Offset: 0x9768
// Size: 0x1ec
function is_equipment_touching_crate( player )
{
    extraboundary = ( 10, 10, 10 );
    
    if ( isdefined( player ) && isdefined( player.weaponobjectwatcherarray ) )
    {
        for ( watcher = 0; watcher < player.weaponobjectwatcherarray.size ; watcher++ )
        {
            objectwatcher = player.weaponobjectwatcherarray[ watcher ];
            objectarray = objectwatcher.objectarray;
            
            if ( isdefined( objectarray ) )
            {
                for ( weaponobject = 0; weaponobject < objectarray.size ; weaponobject++ )
                {
                    if ( isdefined( objectarray[ weaponobject ] ) && self istouching( objectarray[ weaponobject ], extraboundary ) )
                    {
                        if ( isdefined( objectwatcher.ondetonatecallback ) )
                        {
                            objectwatcher thread weaponobjects::waitanddetonate( objectarray[ weaponobject ], 0 );
                            continue;
                        }
                        
                        weaponobjects::removeweaponobject( objectwatcher, objectarray[ weaponobject ] );
                    }
                }
            }
        }
    }
    
    extraboundary = ( 15, 15, 15 );
    
    if ( isdefined( player ) && isdefined( player.tacticalinsertion ) && self istouching( player.tacticalinsertion, extraboundary ) )
    {
        player.tacticalinsertion thread tacticalinsertion::fizzle();
    }
}

// Namespace supplydrop/supplydrop
// Params 0
// Checksum 0xb33ae981, Offset: 0x9960
// Size: 0xa0
function spawnuseent()
{
    useent = spawn( "script_origin", self.origin );
    useent.curprogress = 0;
    useent.inuse = 0;
    useent.userate = 0;
    useent.usetime = 0;
    useent.owner = self;
    useent thread useentownerdeathwaiter( self );
    return useent;
}

// Namespace supplydrop/supplydrop
// Params 1
// Checksum 0x31fcd30f, Offset: 0x9a08
// Size: 0x3c
function useentownerdeathwaiter( owner )
{
    self endon( #"death" );
    owner waittill( "death" );
    self delete();
}

// Namespace supplydrop/supplydrop
// Params 0
// Checksum 0x4167d7b7, Offset: 0x9a50
// Size: 0x19e
function crateusethink()
{
    while ( isdefined( self ) )
    {
        waitresult = self waittill( "trigger" );
        player = waitresult.activator;
        
        if ( !isalive( player ) )
        {
            continue;
        }
        
        if ( !player isonground() )
        {
            continue;
        }
        
        if ( isdefined( self.owner ) && self.owner == player )
        {
            continue;
        }
        
        useent = self spawnuseent();
        result = 0;
        
        if ( isdefined( self.hacker ) )
        {
            useent.hacker = self.hacker;
        }
        
        self.useent = useent;
        result = useent useholdthink( player, level.cratenonownerusetime );
        
        if ( isdefined( useent ) )
        {
            useent delete();
        }
        
        if ( result )
        {
            scoreevents::givecratecapturemedal( self, player );
            self notify( #"captured", { #player:player, #is_remote_hack:0 } );
        }
    }
}

// Namespace supplydrop/supplydrop
// Params 0
// Checksum 0x25868a6e, Offset: 0x9bf8
// Size: 0xfa
function crateusethinkowner()
{
    self endon( #"joined_team" );
    
    while ( isdefined( self ) )
    {
        waitresult = self waittill( "trigger" );
        player = waitresult.activator;
        
        if ( !isalive( player ) )
        {
            continue;
        }
        
        if ( !isdefined( self.owner ) )
        {
            continue;
        }
        
        if ( self.owner != player )
        {
            continue;
        }
        
        result = self useholdthink( player, level.crateownerusetime );
        
        if ( result )
        {
            self notify( #"captured", { #player:player, #is_remote_hack:0 } );
        }
    }
}

// Namespace supplydrop/supplydrop
// Params 2
// Checksum 0xa85efaae, Offset: 0x9d00
// Size: 0x162, Type: bool
function useholdthink( player, usetime )
{
    player notify( #"use_hold" );
    player util::freeze_player_controls( 1 );
    player util::_disableweapon();
    self.curprogress = 0;
    self.inuse = 1;
    self.userate = 0;
    self.usetime = usetime;
    player thread personalusebar( self );
    result = useholdthinkloop( player );
    
    if ( isdefined( player ) )
    {
        player notify( #"done_using" );
    }
    
    if ( isdefined( player ) )
    {
        if ( isalive( player ) )
        {
            player util::_enableweapon();
            player util::freeze_player_controls( 0 );
        }
    }
    
    if ( isdefined( self ) )
    {
        self.inuse = 0;
    }
    
    if ( isdefined( result ) && result )
    {
        return true;
    }
    
    return false;
}

// Namespace supplydrop/supplydrop
// Params 1
// Checksum 0xdfdeee95, Offset: 0x9e70
// Size: 0x106, Type: bool
function continueholdthinkloop( player )
{
    if ( !isdefined( self ) )
    {
        return false;
    }
    
    if ( self.curprogress >= self.usetime )
    {
        return false;
    }
    
    if ( !isalive( player ) )
    {
        return false;
    }
    
    if ( player.throwinggrenade )
    {
        return false;
    }
    
    if ( !player usebuttonpressed() )
    {
        return false;
    }
    
    if ( player meleebuttonpressed() )
    {
        return false;
    }
    
    if ( player isinvehicle() )
    {
        return false;
    }
    
    if ( player isweaponviewonlylinked() )
    {
        return false;
    }
    
    if ( player isremotecontrolling() )
    {
        return false;
    }
    
    return true;
}

// Namespace supplydrop/supplydrop
// Params 1
// Checksum 0x18889436, Offset: 0x9f80
// Size: 0x10a
function useholdthinkloop( player )
{
    level endon( #"game_ended" );
    self endon( #"disabled" );
    self.owner endon( #"crate_use_interrupt" );
    timedout = 0;
    
    while ( self continueholdthinkloop( player ) )
    {
        timedout += 0.05;
        self.curprogress += 50 * self.userate;
        self.userate = 1;
        
        if ( self.curprogress >= self.usetime )
        {
            self.inuse = 0;
            waitframe( 1 );
            return isalive( player );
        }
        
        waitframe( 1 );
        hostmigration::waittillhostmigrationdone();
    }
    
    return 0;
}

// Namespace supplydrop/supplydrop
// Params 0
// Checksum 0x2b522a93, Offset: 0xa098
// Size: 0x17a
function crategamblerthink()
{
    self endon( #"death" );
    
    for ( ;; )
    {
        waitresult = self waittill( "trigger_use_doubletap" );
        player = waitresult.player;
        
        if ( !player hasperk( "specialty_showenemyequipment" ) )
        {
            continue;
        }
        
        if ( isdefined( self.useent ) && self.useent.inuse )
        {
            if ( isdefined( self.owner ) && self.owner != player )
            {
                continue;
            }
        }
        
        player playlocalsound( "uin_gamble_perk" );
        self.cratetype = getrandomcratetype( "gambler", self.cratetype.name );
        self cratereactivate();
        self sethintstringforperk( "specialty_showenemyequipment", self.cratetype.hint );
        self notify( #"crate_use_interrupt" );
        level notify( #"use_interrupt", { #target:self } );
        return;
    }
}

// Namespace supplydrop/supplydrop
// Params 0
// Checksum 0x38dc0b49, Offset: 0xa220
// Size: 0x84
function cratereactivate()
{
    self sethintstring( self.cratetype.hint );
    icon = self geticonforcrate();
    self thread entityheadicons::setentityheadicon( self.team, self, level.crate_headicon_offset, icon, 1 );
}

// Namespace supplydrop/supplydrop
// Params 1
// Checksum 0x6de88b0, Offset: 0xa2b0
// Size: 0x404
function personalusebar( object )
{
    self endon( #"disconnect" );
    capturecratestate = 0;
    
    if ( level.teambased && object.owner.team != self.team || self hasperk( "specialty_showenemyequipment" ) && object.owner != self && !isdefined( object.hacker ) && !level.teambased )
    {
        capturecratestate = 2;
        self playlocalsound( "evt_hacker_hacking" );
    }
    else if ( level.teambased && ( object.owner == self || self hasperk( "specialty_showenemyequipment" ) && isdefined( object.hacker ) && object.owner.team == self.team ) )
    {
        capturecratestate = 3;
        self playlocalsound( "evt_hacker_hacking" );
    }
    else
    {
        capturecratestate = 1;
        self.is_capturing_own_supply_drop = !isdefined( object.originalowner ) || object.owner === self && object.originalowner == self;
    }
    
    lastrate = -1;
    
    while ( isalive( self ) && isdefined( object ) && object.inuse && !level.gameended )
    {
        if ( lastrate != object.userate )
        {
            if ( object.curprogress > object.usetime )
            {
                object.curprogress = object.usetime;
            }
            
            if ( !object.userate )
            {
                self clientfield::set_player_uimodel( "hudItems.captureCrateTotalTime", 0 );
                self clientfield::set_player_uimodel( "hudItems.captureCrateState", 0 );
            }
            else
            {
                barfrac = object.curprogress / object.usetime;
                rateofchange = object.userate / object.usetime;
                capturecratetotaltime = 0;
                
                if ( rateofchange > 0 )
                {
                    capturecratetotaltime = ( 1 - barfrac ) / rateofchange;
                }
                
                self clientfield::set_player_uimodel( "hudItems.captureCrateTotalTime", int( capturecratetotaltime ) );
                self clientfield::set_player_uimodel( "hudItems.captureCrateState", capturecratestate );
            }
        }
        
        lastrate = object.userate;
        waitframe( 1 );
    }
    
    self.is_capturing_own_supply_drop = 0;
    self clientfield::set_player_uimodel( "hudItems.captureCrateTotalTime", 0 );
    self clientfield::set_player_uimodel( "hudItems.captureCrateState", 0 );
}

// Namespace supplydrop/supplydrop
// Params 8
// Checksum 0x23995a62, Offset: 0xa6c0
// Size: 0x3e0
function spawn_helicopter( owner, team, origin, angles, model, targetname, killstreak_id, context )
{
    chopper = spawnhelicopter( owner, origin, angles, model, targetname );
    
    if ( !isdefined( chopper ) )
    {
        if ( isplayer( owner ) )
        {
            killstreakrules::killstreakstop( "supply_drop", team, killstreak_id );
            self notify( #"cleanup_marker" );
        }
        
        return undefined;
    }
    
    chopper killstreaks::configure_team( "supply_drop", killstreak_id, owner );
    chopper.maxhealth = level.heli_maxhealth;
    chopper.rocketdamageoneshot = chopper.maxhealth + 1;
    chopper.damagetaken = 0;
    hardpointtypefordamage = "supply_drop";
    
    if ( context.killstreakref === "inventory_ai_tank_drop" || context.killstreakref === "ai_tank_drop" )
    {
        hardpointtypefordamage = "supply_drop_ai_tank";
    }
    else if ( context.killstreakref === "inventory_combat_robot" || context.killstreakref === "combat_robot" )
    {
        hardpointtypefordamage = "supply_drop_combat_robot";
    }
    
    chopper thread helicopter::heli_damage_monitor( hardpointtypefordamage );
    chopper thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile( "crashing", "death" );
    chopper.spawntime = gettime();
    chopper clientfield::set( "enemyvehicle", 1 );
    supplydropspeed = getdvarint( "scr_supplydropSpeedStarting", 250 );
    supplydropaccel = getdvarint( "scr_supplydropAccelStarting", 100 );
    chopper setspeed( supplydropspeed, supplydropaccel );
    
    /#
        chopper util::debug_slow_heli_speed();
    #/
    
    maxpitch = getdvarint( "scr_supplydropMaxPitch", 25 );
    maxroll = getdvarint( "scr_supplydropMaxRoll", 45 );
    chopper setmaxpitchroll( 0, maxroll );
    chopper setdrawinfrared( 1 );
    target_set( chopper, ( 0, 0, -25 ) );
    
    if ( isplayer( owner ) )
    {
        chopper thread refcountdecchopper( team, killstreak_id );
    }
    
    chopper thread helidestroyed();
    return chopper;
}

// Namespace supplydrop/supplydrop
// Params 1
// Checksum 0xb425626b, Offset: 0xaaa8
// Size: 0x1a
function getdropheight( origin )
{
    return airsupport::getminimumflyheight();
}

// Namespace supplydrop/supplydrop
// Params 0
// Checksum 0xa3b24727, Offset: 0xaad0
// Size: 0x1e
function getdropdirection()
{
    return ( 0, randomint( 360 ), 0 );
}

// Namespace supplydrop/supplydrop
// Params 2
// Checksum 0x836bd442, Offset: 0xaaf8
// Size: 0x64
function getnextdropdirection( drop_direction, degrees )
{
    drop_direction = ( 0, drop_direction[ 1 ] + degrees, 0 );
    
    if ( drop_direction[ 1 ] >= 360 )
    {
        drop_direction = ( 0, drop_direction[ 1 ] - 360, 0 );
    }
    
    return drop_direction;
}

// Namespace supplydrop/supplydrop
// Params 2
// Checksum 0x92c12760, Offset: 0xab68
// Size: 0x21a
function gethelistart( drop_origin, drop_direction )
{
    dist = -1 * getdvarint( "scr_supplydropIncomingDistance", 15000 );
    pathrandomness = 100;
    direction = drop_direction + ( 0, randomintrange( -2, 3 ), 0 );
    start_origin = drop_origin + anglestoforward( direction ) * dist;
    start_origin += ( ( randomfloat( 2 ) - 1 ) * pathrandomness, ( randomfloat( 2 ) - 1 ) * pathrandomness, 0 );
    
    /#
        if ( getdvarint( "scr_noflyzones_debug", 0 ) )
        {
            if ( level.noflyzones.size )
            {
                index = randomintrange( 0, level.noflyzones.size );
                delta = drop_origin - level.noflyzones[ index ].origin;
                delta = ( delta[ 0 ] + randomint( 10 ), delta[ 1 ] + randomint( 10 ), 0 );
                delta = vectornormalize( delta );
                start_origin = drop_origin + delta * dist;
            }
        }
    #/
    
    return start_origin;
}

// Namespace supplydrop/supplydrop
// Params 2
// Checksum 0x617db1fd, Offset: 0xad90
// Size: 0x164
function getheliend( drop_origin, drop_direction )
{
    pathrandomness = 150;
    dist = -1 * getdvarint( "scr_supplydropOutgoingDistance", 15000 );
    
    if ( randomintrange( 0, 2 ) == 0 )
    {
        turn = randomintrange( 60, 121 );
    }
    else
    {
        turn = -1 * randomintrange( 60, 121 );
    }
    
    direction = drop_direction + ( 0, turn, 0 );
    end_origin = drop_origin + anglestoforward( direction ) * dist;
    end_origin += ( ( randomfloat( 2 ) - 1 ) * pathrandomness, ( randomfloat( 2 ) - 1 ) * pathrandomness, 0 );
    return end_origin;
}

// Namespace supplydrop/supplydrop
// Params 3
// Checksum 0x3819bc1c, Offset: 0xaf00
// Size: 0x82
function addoffsetontopoint( point, direction, offset )
{
    angles = vectortoangles( ( direction[ 0 ], direction[ 1 ], 0 ) );
    offset_world = rotatepoint( offset, angles );
    return point + offset_world;
}

// Namespace supplydrop/supplydrop
// Params 2
// Checksum 0x3e78daa, Offset: 0xaf90
// Size: 0x5c
function supplydrophelistartpath_v2_setup( goal, goal_offset )
{
    goalpath = spawnstruct();
    goalpath.start = helicopter::getvalidrandomstartnode( goal ).origin;
    return goalpath;
}

// Namespace supplydrop/supplydrop
// Params 3
// Checksum 0x472dd817, Offset: 0xaff8
// Size: 0x7e
function supplydrophelistartpath_v2_part2_local( goal, goalpath, goal_local_offset )
{
    direction = goal - goalpath.start;
    goalpath.path = [];
    goalpath.path[ 0 ] = addoffsetontopoint( goal, direction, goal_local_offset );
}

// Namespace supplydrop/supplydrop
// Params 3
// Checksum 0xa674cd46, Offset: 0xb080
// Size: 0x4a
function supplydrophelistartpath_v2_part2( goal, goalpath, goal_world_offset )
{
    goalpath.path = [];
    goalpath.path[ 0 ] = goal + goal_world_offset;
}

// Namespace supplydrop/supplydrop
// Params 2
// Checksum 0x2b0b43b2, Offset: 0xb0d8
// Size: 0x362
function supplydrophelistartpath( goal, goal_offset )
{
    total_tries = 12;
    tries = 0;
    goalpath = spawnstruct();
    drop_direction = getdropdirection();
    
    while ( tries < total_tries )
    {
        goalpath.start = gethelistart( goal, drop_direction );
        goalpath.path = airsupport::gethelipath( goalpath.start, goal );
        startnoflyzones = airsupport::insidenoflyzones( goalpath.start, 0 );
        
        if ( isdefined( goalpath.path ) && startnoflyzones.size == 0 )
        {
            if ( goalpath.path.size > 1 )
            {
                direction = goalpath.path[ goalpath.path.size - 1 ] - goalpath.path[ goalpath.path.size - 2 ];
            }
            else
            {
                direction = goalpath.path[ goalpath.path.size - 1 ] - goalpath.start;
            }
            
            goalpath.path[ goalpath.path.size - 1 ] = addoffsetontopoint( goalpath.path[ goalpath.path.size - 1 ], direction, goal_offset );
            
            /#
                sphere( goalpath.path[ goalpath.path.size - 1 ], 10, ( 0, 0, 1 ), 1, 1, 10, 1000 );
            #/
            
            return goalpath;
        }
        
        drop_direction = getnextdropdirection( drop_direction, 30 );
        tries++;
    }
    
    drop_direction = getdropdirection();
    goalpath.start = gethelistart( goal, drop_direction );
    direction = goal - goalpath.start;
    goalpath.path = [];
    goalpath.path[ 0 ] = addoffsetontopoint( goal, direction, goal_offset );
    return goalpath;
}

// Namespace supplydrop/supplydrop
// Params 1
// Checksum 0xd5d7673a, Offset: 0xb448
// Size: 0x92
function supplydropheliendpath_v2( start )
{
    goalpath = spawnstruct();
    goalpath.start = start;
    goal = helicopter::getvalidrandomleavenode( start ).origin;
    goalpath.path = [];
    goalpath.path[ 0 ] = goal;
    return goalpath;
}

// Namespace supplydrop/supplydrop
// Params 2
// Checksum 0xba4c50e, Offset: 0xb4e8
// Size: 0x202
function supplydropheliendpath( origin, drop_direction )
{
    total_tries = 5;
    tries = 0;
    goalpath = spawnstruct();
    
    while ( tries < total_tries )
    {
        goal = getheliend( origin, drop_direction );
        goalpath.path = airsupport::gethelipath( origin, goal );
        
        if ( isdefined( goalpath.path ) )
        {
            return goalpath;
        }
        
        tries++;
    }
    
    leave_nodes = getentarray( "heli_leave", "targetname" );
    
    foreach ( node in leave_nodes )
    {
        goalpath.path = airsupport::gethelipath( origin, node.origin );
        
        if ( isdefined( goalpath.path ) )
        {
            return goalpath;
        }
    }
    
    goalpath.path = [];
    goalpath.path[ 0 ] = getheliend( origin, drop_direction );
    return goalpath;
}

// Namespace supplydrop/supplydrop
// Params 2
// Checksum 0xd286b8a, Offset: 0xb6f8
// Size: 0x2ce
function inccratekillstreakusagestat( weapon, killstreak_id )
{
    if ( weapon == level.weaponnone )
    {
        return;
    }
    
    switch ( weapon.name )
    {
        case #"turret_drop":
            self killstreaks::play_killstreak_start_dialog( "turret_drop", self.pers[ "team" ], killstreak_id );
            break;
        case #"tow_turret_drop":
            self killstreaks::play_killstreak_start_dialog( "tow_turret_drop", self.pers[ "team" ], killstreak_id );
            break;
        case #"inventory_supplydrop_marker":
        case #"supplydrop_marker":
            self killstreaks::play_killstreak_start_dialog( "supply_drop", self.pers[ "team" ], killstreak_id );
            level thread popups::displaykillstreakteammessagetoall( "supply_drop", self );
            self challenges::calledincarepackage();
            self addweaponstat( getweapon( "supplydrop" ), "used", 1 );
            break;
        case #"ai_tank_drop":
        case #"inventory_ai_tank_drop":
            self killstreaks::play_killstreak_start_dialog( "ai_tank_drop", self.pers[ "team" ], killstreak_id );
            level thread popups::displaykillstreakteammessagetoall( "ai_tank_drop", self );
            self addweaponstat( getweapon( "ai_tank_drop" ), "used", 1 );
            break;
        case #"inventory_minigun_drop":
        case #"minigun_drop":
            self killstreaks::play_killstreak_start_dialog( "minigun", self.pers[ "team" ], killstreak_id );
            break;
        case #"inventory_m32_drop":
        case #"m32_drop":
            self killstreaks::play_killstreak_start_dialog( "m32", self.pers[ "team" ], killstreak_id );
            break;
        case #"combat_robot_drop":
            level thread popups::displaykillstreakteammessagetoall( "combat_robot", self );
            break;
    }
}

// Namespace supplydrop/supplydrop
// Params 1
// Checksum 0x10356d14, Offset: 0xb9d0
// Size: 0x64
function markercleanupthread( context )
{
    player = self;
    player waittill( "death", "disconnect", "joined_team", "joined_spectators", "cleanup_marker" );
    cleanup( context, player );
}

// Namespace supplydrop/supplydrop
// Params 1
// Checksum 0xd67d145b, Offset: 0xba40
// Size: 0xae
function getchopperdroppoint( context )
{
    chopper = self;
    return isdefined( context.droptag ) ? chopper gettagorigin( context.droptag ) + rotatepoint( isdefined( context.droptagoffset ) ? context.droptagoffset : ( 0, 0, 0 ), chopper.angles ) : chopper.origin;
}

// Namespace supplydrop/supplydrop
// Params 7
// Checksum 0x955d0e40, Offset: 0xbaf8
// Size: 0xfe4
function helidelivercrate( origin, weapon, owner, team, killstreak_id, package_contents_id, context )
{
    if ( owner emp::enemyempactive() && !owner hasperk( "specialty_immuneemp" ) )
    {
        killstreakrules::killstreakstop( "supply_drop", team, killstreak_id );
        self notify( #"cleanup_marker" );
        return;
    }
    
    /#
        if ( getdvarint( "scr_supply_drop_valid_location_debug", 0 ) )
        {
            level notify( #"stop_heli_drop_valid_location_marked_cylinder" );
            level notify( #"stop_heli_drop_valid_location_arrived_at_goal_cylinder" );
            level notify( #"stop_heli_drop_valid_location_dropped_cylinder" );
            util::drawcylinder( origin, context.radius, 8000, 99999999, "stop_heli_drop_valid_location_marked_cylinder", ( 0.4, 0, 0.4 ), 0.8 );
        }
    #/
    
    context.markerfxhandle = spawnfx( level.killstreakcorebundle.fxmarkedlocation, context.marker.origin + ( 0, 0, 5 ), ( 0, 0, 1 ), ( 1, 0, 0 ) );
    context.markerfxhandle.team = owner.team;
    triggerfx( context.markerfxhandle );
    adddroplocation( killstreak_id, context.marker.origin );
    killstreakbundle = isdefined( context.killstreaktype ) ? level.killstreakbundle[ context.killstreaktype ] : undefined;
    ricochetdistance = isdefined( killstreakbundle ) ? killstreakbundle.ksricochetdistance : undefined;
    killstreaks::add_ricochet_protection( killstreak_id, owner, context.marker.origin, ricochetdistance );
    context.marker.team = owner.team;
    context.marker entityheadicons::destroyentityheadicons();
    context.marker entityheadicons::setentityheadicon( owner.pers[ "team" ], owner, undefined, context.objective );
    
    if ( isdefined( weapon ) )
    {
        inccratekillstreakusagestat( weapon, killstreak_id );
    }
    
    rear_hatch_offset_local = getdvarint( "scr_supplydropOffset", 0 );
    drop_origin = origin;
    drop_height = getdropheight( drop_origin );
    drop_height += level.zoffsetcounter * 350;
    level.zoffsetcounter++;
    
    if ( level.zoffsetcounter >= 5 )
    {
        level.zoffsetcounter = 0;
    }
    
    heli_drop_goal = ( drop_origin[ 0 ], drop_origin[ 1 ], drop_height );
    
    /#
        sphere( heli_drop_goal, 10, ( 0, 1, 0 ), 1, 1, 10, 1000 );
    #/
    
    goalpath = undefined;
    
    if ( isdefined( context.dropoffset ) )
    {
        goalpath = supplydrophelistartpath_v2_setup( heli_drop_goal, context.dropoffset );
        supplydrophelistartpath_v2_part2_local( heli_drop_goal, goalpath, context.dropoffset );
    }
    else
    {
        goalpath = supplydrophelistartpath_v2_setup( heli_drop_goal, ( rear_hatch_offset_local, 0, 0 ) );
        goal_path_setup_needs_finishing = 1;
    }
    
    drop_direction = vectortoangles( ( heli_drop_goal[ 0 ], heli_drop_goal[ 1 ], 0 ) - ( goalpath.start[ 0 ], goalpath.start[ 1 ], 0 ) );
    
    if ( isdefined( context.vehiclename ) )
    {
        helicoptervehicleinfo = context.vehiclename;
    }
    else
    {
        helicoptervehicleinfo = level.vtoldrophelicoptervehicleinfo;
    }
    
    chopper = spawn_helicopter( owner, team, goalpath.start, drop_direction, helicoptervehicleinfo, "", killstreak_id, context );
    
    if ( goal_path_setup_needs_finishing === 1 )
    {
        goal_world_offset = chopper.origin - chopper getchopperdroppoint( context );
        supplydrophelistartpath_v2_part2( heli_drop_goal, goalpath, goal_world_offset );
        goal_path_setup_needs_finishing = 0;
    }
    
    waitforonlyonedroplocation = 0;
    
    while ( level.droplocations.size > 1 && waitforonlyonedroplocation )
    {
        arrayremovevalue( level.droplocations, undefined );
        wait_for_drop = 0;
        
        foreach ( id, droplocation in level.droplocations )
        {
            if ( id < killstreak_id )
            {
                wait_for_drop = 1;
                break;
            }
        }
        
        if ( wait_for_drop )
        {
            wait 0.5;
            continue;
        }
        
        break;
    }
    
    chopper.killstreakweaponname = weapon.name;
    
    if ( isdefined( context ) && isdefined( context.hasflares ) )
    {
        chopper.numflares = 3;
        chopper.flareoffset = ( 0, 0, 0 );
        chopper thread helicopter::create_flare_ent( ( 0, 0, -50 ) );
    }
    else
    {
        chopper.numflares = 0;
    }
    
    killcament = spawn( "script_model", chopper.origin + ( 0, 0, 800 ) );
    killcament.angles = ( 100, chopper.angles[ 1 ], chopper.angles[ 2 ] );
    killcament.starttime = gettime();
    killcament linkto( chopper );
    
    if ( !isdefined( chopper ) )
    {
        return;
    }
    
    if ( isdefined( context ) && isdefined( context.prolog ) )
    {
        chopper [[ context.prolog ]]( context );
    }
    else
    {
        chopper thread helidropcrate( level.killstreakweapons[ weapon ], owner, rear_hatch_offset_local, killcament, killstreak_id, package_contents_id, context );
    }
    
    chopper endon( #"death" );
    chopper thread airsupport::followpath( goalpath.path, "drop_goal", 1 );
    chopper thread speedregulator( heli_drop_goal );
    chopper waittill( "drop_goal" );
    
    if ( isdefined( context ) && isdefined( context.epilog ) )
    {
        chopper [[ context.epilog ]]( context );
    }
    
    println( "Chopper Incoming Time: " + gettime() - chopper.spawntime );
    
    /#
        if ( getdvarint( "scr_supply_drop_valid_location_debug", 0 ) )
        {
            if ( isdefined( context.dropoffset ) )
            {
                chopper_drop_point = chopper.origin - rotatepoint( context.dropoffset, chopper.angles );
            }
            else
            {
                chopper_drop_point = chopper getchopperdroppoint( context );
            }
            
            trace = groundtrace( chopper_drop_point + ( 0, 0, -100 ), chopper_drop_point + ( 0, 0, -10000 ), 0, undefined, 0 );
            debug_drop_location = trace[ "position" ];
            util::drawcylinder( debug_drop_location, context.radius, 8000, 99999999, "stop_heli_drop_valid_location_arrived_at_goal_cylinder", ( 1, 0.6, 0 ), 0.9 );
            iprintln( "Goal notified at 2D distance: " + distance2d( chopper_drop_point, heli_drop_goal ) );
        }
    #/
    
    on_target = 0;
    last_distance_from_goal_squared = 1e+07 * 1e+07;
    continue_waiting = 1;
    
    for ( remaining_tries = 30; continue_waiting && remaining_tries > 0 ; remaining_tries-- )
    {
        if ( isdefined( context.dropoffset ) )
        {
            chopper_drop_point = chopper.origin - rotatepoint( context.dropoffset, chopper.angles );
        }
        else
        {
            chopper_drop_point = chopper getchopperdroppoint( context );
        }
        
        current_distance_from_goal_squared = distance2dsquared( chopper_drop_point, heli_drop_goal );
        continue_waiting = current_distance_from_goal_squared < last_distance_from_goal_squared && current_distance_from_goal_squared > 3.7 * 3.7;
        last_distance_from_goal_squared = current_distance_from_goal_squared;
        
        /#
            if ( getdvarint( "scr_supply_drop_valid_location_debug", 0 ) )
            {
                sphere( chopper_drop_point, 8, ( 1, 0, 0 ), 0.9, 0, 20, 1 );
            }
        #/
        
        if ( continue_waiting )
        {
            /#
                if ( getdvarint( "scr_supply_drop_valid_location_debug", 0 ) )
                {
                    iprintln( "--- 2D distance: " + distance2d( chopper_drop_point, heli_drop_goal ) );
                }
            #/
            
            waitframe( 1 );
        }
    }
    
    /#
        if ( getdvarint( "scr_supply_drop_valid_location_debug", 0 ) )
        {
            iprintln( "Crate Dropped at 2D distance: " + distance2d( chopper_drop_point, heli_drop_goal ) );
        }
    #/
    
    chopper notify( #"drop_crate", { #position:chopper.origin, #direction:chopper.angles, #owner:chopper.owner } );
    chopper.droptime = gettime();
    chopper playsound( "veh_supply_drop" );
    wait 0.7;
    
    if ( isdefined( level.killstreakweapons[ weapon ] ) )
    {
        chopper killstreaks::play_pilot_dialog_on_owner( "waveStartFinal", level.killstreakweapons[ weapon ], chopper.killstreak_id );
    }
    
    supplydropspeed = getdvarint( "scr_supplydropSpeedLeaving", 250 );
    supplydropaccel = getdvarint( "scr_supplydropAccelLeaving", 60 );
    chopper setspeed( supplydropspeed, supplydropaccel );
    
    /#
        chopper util::debug_slow_heli_speed();
    #/
    
    goalpath = supplydropheliendpath_v2( chopper.origin );
    chopper airsupport::followpath( goalpath.path, undefined, 0 );
    println( "Chopper Outgoing Time: " + gettime() - chopper.droptime );
    chopper notify( #"leaving" );
    chopper delete();
}

// Namespace supplydrop/supplydrop
// Params 1
// Checksum 0xd96f375a, Offset: 0xcae8
// Size: 0x144
function speedregulator( goal )
{
    self endon( #"drop_goal" );
    self endon( #"death" );
    wait 3;
    supplydropspeed = getdvarint( "scr_supplydropSpeed", 400 );
    supplydropaccel = getdvarint( "scr_supplydropAccel", 60 );
    self setyawspeed( 100, 60, 60 );
    self setspeed( supplydropspeed, supplydropaccel );
    
    /#
        self util::debug_slow_heli_speed();
    #/
    
    wait 1;
    maxpitch = getdvarint( "scr_supplydropMaxPitch", 25 );
    maxroll = getdvarint( "scr_supplydropMaxRoll", 35 );
    self setmaxpitchroll( maxpitch, maxroll );
}

// Namespace supplydrop/supplydrop
// Params 7
// Checksum 0x194f73bb, Offset: 0xcc38
// Size: 0x51c
function helidropcrate( killstreak, originalowner, offset, killcament, killstreak_id, package_contents_id, context )
{
    helicopter = self;
    originalowner endon( #"disconnect" );
    crate = cratespawn( killstreak, killstreak_id, originalowner, self.team, self.origin, self.angles );
    
    if ( killstreak == "inventory_supply_drop" || killstreak == "supply_drop" )
    {
        crate linkto( helicopter, isdefined( context.droptag ) ? context.droptag : "tag_origin", isdefined( context.droptagoffset ) ? context.droptagoffset : ( 0, 0, 0 ) );
        helicopter clientfield::set( "supplydrop_care_package_state", 1 );
    }
    else if ( killstreak == "inventory_ai_tank_drop" || killstreak == "ai_tank_drop" || killstreak == "ai_tank_marker" )
    {
        crate linkto( helicopter, isdefined( context.droptag ) ? context.droptag : "tag_origin", isdefined( context.droptagoffset ) ? context.droptagoffset : ( 0, 0, 0 ) );
        helicopter clientfield::set( "supplydrop_ai_tank_state", 1 );
    }
    
    team = self.team;
    waitresult = helicopter waittill( "drop_crate" );
    chopperowner = waitresult.owner;
    origin = waitresult.position;
    angles = waitresult.direction;
    
    if ( isdefined( chopperowner ) )
    {
        owner = chopperowner;
        
        if ( owner != originalowner )
        {
            crate killstreaks::configure_team( killstreak, owner );
            killstreaks::remove_ricochet_protection( killstreak_id, owner );
        }
    }
    else
    {
        owner = originalowner;
    }
    
    if ( isdefined( self ) )
    {
        team = self.team;
        
        if ( killstreak == "inventory_supply_drop" || killstreak == "supply_drop" )
        {
            helicopter clientfield::set( "supplydrop_care_package_state", 0 );
        }
        else if ( killstreak == "inventory_ai_tank_drop" || killstreak == "ai_tank_drop" )
        {
            helicopter clientfield::set( "supplydrop_ai_tank_state", 0 );
        }
        
        enemy = helicopter.owner battlechatter::get_closest_player_enemy( helicopter.origin, 1 );
        enemyradius = battlechatter::mpdialog_value( "supplyDropRadius", 0 );
        
        if ( isdefined( enemy ) && distance2dsquared( origin, enemy.origin ) < enemyradius * enemyradius )
        {
            enemy battlechatter::play_killstreak_threat( killstreak );
        }
    }
    
    if ( team == owner.team )
    {
        rear_hatch_offset_height = getdvarint( "scr_supplydropOffsetHeight", 200 );
        rear_hatch_offset_world = rotatepoint( ( offset, 0, 0 ), angles );
        drop_origin = origin - ( 0, 0, rear_hatch_offset_height ) - rear_hatch_offset_world;
        thread dropcrate( drop_origin, angles, killstreak, owner, team, killcament, killstreak_id, package_contents_id, crate, context );
    }
}

// Namespace supplydrop/supplydrop
// Params 0
// Checksum 0xef10af7d, Offset: 0xd160
// Size: 0x12c
function helidestroyed()
{
    self endon( #"leaving" );
    self endon( #"helicopter_gone" );
    self endon( #"death" );
    
    while ( true )
    {
        if ( self.damagetaken > self.maxhealth )
        {
            break;
        }
        
        waitframe( 1 );
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self setspeed( 25, 5 );
    self thread lbspin( randomintrange( 180, 220 ) );
    wait randomfloatrange( 0.5, 1.5 );
    self notify( #"drop_crate", { #position:self.origin, #direction:self.angles, #owner:self.owner } );
    lbexplode();
}

// Namespace supplydrop/supplydrop
// Params 0
// Checksum 0xc4efabfe, Offset: 0xd298
// Size: 0xfc
function lbexplode()
{
    forward = self.origin + ( 0, 0, 1 ) - self.origin;
    playfx( level.chopper_fx[ "explode" ][ "death" ], self.origin, forward );
    self playsound( level.heli_sound[ "crash" ] );
    self notify( #"explode" );
    
    if ( isdefined( self.delete_after_destruction_wait_time ) )
    {
        self hide();
        self waitanddelete( self.delete_after_destruction_wait_time );
        return;
    }
    
    self delete();
}

// Namespace supplydrop/supplydrop
// Params 1
// Checksum 0x76580faf, Offset: 0xd3a0
// Size: 0xfe
function lbspin( speed )
{
    self endon( #"explode" );
    playfxontag( level.chopper_fx[ "explode" ][ "large" ], self, "tail_rotor_jnt" );
    playfxontag( level.chopper_fx[ "fire" ][ "trail" ][ "large" ], self, "tail_rotor_jnt" );
    self setyawspeed( speed, speed, speed );
    
    while ( isdefined( self ) )
    {
        self settargetyaw( self.angles[ 1 ] + speed * 0.9 );
        wait 1;
    }
}

// Namespace supplydrop/supplydrop
// Params 2
// Checksum 0x19151e0a, Offset: 0xd4a8
// Size: 0x52
function refcountdecchopper( team, killstreak_id )
{
    self waittill( "death" );
    killstreakrules::killstreakstop( "supply_drop", team, killstreak_id );
    self notify( #"cleanup_marker" );
}

/#

    // Namespace supplydrop/supplydrop
    // Params 0
    // Checksum 0xaef57c76, Offset: 0xd508
    // Size: 0x74, Type: dev
    function supply_drop_dev_gui()
    {
        setdvar( "scr_supply_drop_gui", "" );
        
        while ( true )
        {
            wait 0.5;
            devgui_string = getdvarstring( "scr_supply_drop_gui" );
            level.dev_gui_supply_drop = devgui_string;
        }
    }

#/
