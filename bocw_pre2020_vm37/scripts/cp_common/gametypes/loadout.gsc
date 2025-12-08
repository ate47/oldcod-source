#using scripts\abilities\ability_util;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\dev_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\healthoverlay;
#using scripts\core_common\loadout_shared;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\tweakables_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\gametypes\dev;
#using scripts\cp_common\gametypes\save;
#using scripts\weapons\weapon_utils;

#namespace loadout;

// Namespace loadout/loadout
// Params 0, eflags: 0x6
// Checksum 0x340a8feb, Offset: 0x5b8
// Size: 0x44
function private autoexec __init__system__()
{
    system::register( #"loadout", &preinit, undefined, undefined, #"load" );
}

// Namespace loadout/loadout
// Params 0, eflags: 0x4
// Checksum 0x3baff0d0, Offset: 0x608
// Size: 0x8c
function private preinit()
{
    level.var_4932c685 = "c_usa_cia_masonjr_viewbody";
    callback::on_start_gametype( &function_6fddd9e2 );
    callback::on_connect( &on_connect );
    callback::on_disconnect( &function_5890c14e );
    
    /#
        level thread function_df570a20();
    #/
}

// Namespace loadout/loadout
// Params 0
// Checksum 0xf13cb989, Offset: 0x6a0
// Size: 0x44
function on_connect()
{
    self.pers[ #"loadout" ] = spawnstruct();
    self function_c67222df();
}

// Namespace loadout/loadout
// Params 0, eflags: 0x4
// Checksum 0x5ccd9085, Offset: 0x6f0
// Size: 0x1e
function private function_6fddd9e2()
{
    profilestart();
    init();
    profilestop();
}

// Namespace loadout/loadout
// Params 0, eflags: 0x4
// Checksum 0xe1e7ac8f, Offset: 0x718
// Size: 0x8b4
function private init()
{
    level.classmap[ #"class_smg" ] = "CLASS_SMG";
    level.classmap[ #"class_cqb" ] = "CLASS_CQB";
    level.classmap[ #"class_assault" ] = "CLASS_ASSAULT";
    level.classmap[ #"class_lmg" ] = "CLASS_LMG";
    level.classmap[ #"class_sniper" ] = "CLASS_SNIPER";
    level.classmap[ #"custom0" ] = "CLASS_CUSTOM1";
    level.classmap[ #"custom1" ] = "CLASS_CUSTOM2";
    level.classmap[ #"custom2" ] = "CLASS_CUSTOM3";
    level.classmap[ #"custom3" ] = "CLASS_CUSTOM4";
    level.classmap[ #"custom4" ] = "CLASS_CUSTOM5";
    level.classmap[ #"custom5" ] = "CLASS_CUSTOM6";
    level.classmap[ #"custom6" ] = "CLASS_CUSTOM7";
    level.classmap[ #"custom7" ] = "CLASS_CUSTOM8";
    level.classmap[ #"custom8" ] = "CLASS_CUSTOM9";
    level.classmap[ #"custom9" ] = "CLASS_CUSTOM10";
    level.maxkillstreaks = 4;
    level.maxspecialties = 6;
    level.maxallocation = getgametypesetting( #"maxallocation" );
    level.loadoutkillstreaksenabled = getgametypesetting( #"loadoutkillstreaksenabled" );
    level.prestigenumber = 5;
    level.defaultclass = "CLASS_CUSTOM1";
    
    if ( tweakables::gettweakablevalue( "weapon", "allowfrag" ) )
    {
        level.weapons[ #"frag" ] = getweapon( #"frag_grenade" );
    }
    else
    {
        level.weapons[ #"frag" ] = "";
    }
    
    if ( tweakables::gettweakablevalue( "weapon", "allowsmoke" ) )
    {
        level.weapons[ #"smoke" ] = getweapon( #"smoke_grenade" );
    }
    else
    {
        level.weapons[ #"smoke" ] = "";
    }
    
    if ( tweakables::gettweakablevalue( "weapon", "allowflash" ) )
    {
        level.weapons[ #"flash" ] = getweapon( #"flash_grenade" );
    }
    else
    {
        level.weapons[ #"flash" ] = "";
    }
    
    level.weapons[ #"concussion" ] = getweapon( #"concussion_grenade" );
    
    if ( tweakables::gettweakablevalue( "weapon", "allowsatchel" ) )
    {
        level.weapons[ #"satchel_charge" ] = getweapon( #"satchel_charge" );
    }
    else
    {
        level.weapons[ #"satchel_charge" ] = "";
    }
    
    if ( tweakables::gettweakablevalue( "weapon", "allowbetty" ) )
    {
        level.weapons[ #"betty" ] = getweapon( #"hash_590b6be01dcbe46f" );
    }
    else
    {
        level.weapons[ #"betty" ] = "";
    }
    
    if ( tweakables::gettweakablevalue( "weapon", "allowrpgs" ) )
    {
        level.weapons[ #"rpg" ] = getweapon( #"rpg" );
    }
    else
    {
        level.weapons[ #"rpg" ] = "";
    }
    
    level.weapons[ #"health" ] = getweapon( #"gadget_health_regen" );
    level.weapons[ #"hash_f507cc3a8ec96dd" ] = getweapon( #"hash_58e23c4323f30790" );
    create_class_exclusion_list();
    function_bce8a927();
    level thread function_9f1a5350();
    load_default_loadout( "CLASS_SMG", 10 );
    load_default_loadout( "CLASS_CQB", 11 );
    load_default_loadout( "CLASS_ASSAULT", 12 );
    load_default_loadout( "CLASS_LMG", 13 );
    load_default_loadout( "CLASS_SNIPER", 14 );
    level.primary_weapon_array = [];
    level.side_arm_array = [];
    level.grenade_array = [];
    level.inventory_array = [];
    var_1182dcbc = 99;
    
    for ( i = 0; i < var_1182dcbc ; i++ )
    {
        if ( !isdefined( level.tbl_weaponids[ i ] ) || level.tbl_weaponids[ i ][ #"group" ] == "" )
        {
            continue;
        }
        
        if ( !isdefined( level.tbl_weaponids[ i ] ) || level.tbl_weaponids[ i ][ #"reference" ] == "" )
        {
            continue;
        }
        
        weapon_type = level.tbl_weaponids[ i ][ #"group" ];
        weapon = level.tbl_weaponids[ i ][ #"reference" ];
        attachment = level.tbl_weaponids[ i ][ #"attachment" ];
        weapon_class_register( weapon, weapon_type );
        
        if ( isdefined( attachment ) && attachment.size < 0 )
        {
            for ( k = 0; k < attachment.size ; k++ )
            {
                weapon_class_register( weapon + "_" + attachment[ k ], weapon_type );
            }
        }
    }
    
    level thread onplayerconnecting();
}

// Namespace loadout/loadout
// Params 0
// Checksum 0xaef44607, Offset: 0xfd8
// Size: 0x144
function function_5890c14e()
{
    self savegame::set_player_data( "playerClass", undefined );
    self savegame::set_player_data( "altPlayerID", undefined );
    self savegame::set_player_data( "saved_weapon", undefined );
    self savegame::set_player_data( "saved_weapon_attachments", undefined );
    self savegame::set_player_data( "saved_weapondata", undefined );
    self savegame::set_player_data( "lives", undefined );
    self savegame::set_player_data( "saved_rig1", undefined );
    self savegame::set_player_data( "saved_rig1_upgraded", undefined );
    self savegame::set_player_data( "saved_rig2", undefined );
    self savegame::set_player_data( "saved_rig2_upgraded", undefined );
}

// Namespace loadout/loadout
// Params 0
// Checksum 0xb8ab4ced, Offset: 0x1128
// Size: 0xf8
function create_class_exclusion_list()
{
    currentdvar = 0;
    level.itemexclusions = [];
    
    while ( getdvarint( "item_exclusion_" + currentdvar, 0 ) )
    {
        level.itemexclusions[ currentdvar ] = getdvarint( "item_exclusion_" + currentdvar, 0 );
        currentdvar++;
    }
    
    level.attachmentexclusions = [];
    
    for ( currentdvar = 0; getdvarstring( "attachment_exclusion_" + currentdvar ) != "" ; currentdvar++ )
    {
        level.attachmentexclusions[ currentdvar ] = getdvarstring( "attachment_exclusion_" + currentdvar );
    }
}

// Namespace loadout/loadout
// Params 1
// Checksum 0xaef1141a, Offset: 0x1228
// Size: 0x5e, Type: bool
function is_attachment_excluded( attachment )
{
    numexclusions = level.attachmentexclusions.size;
    
    for ( exclusionindex = 0; exclusionindex < numexclusions ; exclusionindex++ )
    {
        if ( attachment == level.attachmentexclusions[ exclusionindex ] )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace loadout/loadout
// Params 1
// Checksum 0x52673eb, Offset: 0x1290
// Size: 0x20
function function_1a892447( *var_5cd13e42 )
{
    itemcount = 1;
    return itemcount;
}

// Namespace loadout/loadout
// Params 2
// Checksum 0xf2fb7efd, Offset: 0x12b8
// Size: 0x24
function load_default_loadout( weaponclass, classnum )
{
    level.classtoclassnum[ weaponclass ] = classnum;
}

// Namespace loadout/loadout
// Params 2
// Checksum 0x84a23a5, Offset: 0x12e8
// Size: 0x174
function weapon_class_register( weaponname, weapon_type )
{
    if ( issubstr( "weapon_smg weapon_cqb weapon_assault weapon_tactical weapon_lmg weapon_sniper weapon_shotgun weapon_launcher weapon_special", weapon_type ) )
    {
        level.primary_weapon_array[ getweapon( weaponname ) ] = 1;
        return;
    }
    
    if ( issubstr( "weapon_pistol", weapon_type ) )
    {
        level.side_arm_array[ getweapon( weaponname ) ] = 1;
        return;
    }
    
    if ( issubstr( "weapon_grenade hero", weapon_type ) )
    {
        level.grenade_array[ getweapon( weaponname ) ] = 1;
        return;
    }
    
    if ( weapon_type == "weapon_explosive" )
    {
        level.inventory_array[ getweapon( weaponname ) ] = 1;
        return;
    }
    
    if ( weapon_type == "weapon_rifle" )
    {
        level.inventory_array[ getweapon( weaponname ) ] = 1;
        return;
    }
    
    assert( 0, "<dev string:x38>" + weapon_type + "<dev string:x7c>" + weaponname );
}

// Namespace loadout/loadout
// Params 0
// Checksum 0xc015b624, Offset: 0x1468
// Size: 0x244
function function_bce8a927()
{
    level.tbl_weaponids = [];
    level.perknames = [];
    level.var_646ae0e3 = [];
    level.killstreakicons = [];
    level.killstreakindices = [];
    
    for ( i = 0; i < 1024 ; i++ )
    {
        iteminfo = getunlockableiteminfofromindex( i, 0 );
        
        if ( isdefined( iteminfo ) )
        {
            group_s = iteminfo.itemgroupname;
            reference_s = iteminfo.name;
            var_da0b29d2 = iteminfo.namehash;
            var_cc58896a = iteminfo.image;
            display_name_s = iteminfo.displayname;
            
            if ( reference_s != "" )
            {
                if ( issubstr( group_s, "weapon_" ) || group_s == "hero" )
                {
                    level.tbl_weaponids[ i ][ #"reference" ] = var_da0b29d2;
                    level.tbl_weaponids[ i ][ #"group" ] = group_s;
                    level.tbl_weaponids[ i ][ #"count" ] = iteminfo.count;
                    level.tbl_weaponids[ i ][ #"attachment" ] = iteminfo.attachments;
                    continue;
                }
                
                if ( group_s == "specialty" )
                {
                    level.perknames[ var_cc58896a ] = display_name_s;
                    continue;
                }
                
                if ( group_s == "killstreak" )
                {
                    level.tbl_killstreakdata[ i ] = var_da0b29d2;
                    level.killstreakindices[ var_da0b29d2 ] = i;
                    level.var_646ae0e3[ var_da0b29d2 ] = display_name_s;
                    level.killstreakindices[ var_da0b29d2 ] = i;
                }
            }
        }
    }
}

// Namespace loadout/loadout
// Params 0
// Checksum 0xec098db1, Offset: 0x16b8
// Size: 0x13c
function function_9f1a5350()
{
    /#
        wait 0.5;
        
        for ( i = 0; i < 1024 ; i++ )
        {
            iteminfo = getunlockableiteminfofromindex( i, 0 );
            
            if ( !isdefined( iteminfo ) )
            {
                continue;
            }
            
            reference_s = iteminfo.name;
            
            if ( reference_s == "<dev string:x8d>" )
            {
                continue;
            }
            
            group_s = iteminfo.itemgroupname;
            var_cc58896a = iteminfo.image;
            display_name_s = iteminfo.displayname;
            
            if ( group_s == "<dev string:x91>" )
            {
                if ( strstartswith( iteminfo.name, "<dev string:x9b>" ) )
                {
                    dev::function_8263c0d5( reference_s, "<dev string:xa6>" );
                    continue;
                }
                
                dev::function_373068ca( reference_s, "<dev string:xa6>" );
            }
        }
    #/
}

// Namespace loadout/loadout
// Params 1
// Checksum 0x7d6302a0, Offset: 0x1800
// Size: 0x44
function getclasschoice( response )
{
    assert( isdefined( level.classmap[ response ] ) );
    return level.classmap[ response ];
}

// Namespace loadout/loadout
// Params 2
// Checksum 0xe3a3d52c, Offset: 0x1850
// Size: 0x86
function function_ae827648( var_8a0fa297, var_ebbc74c8 )
{
    attachmentstring = getitemattachment( var_8a0fa297, var_ebbc74c8 );
    
    if ( attachmentstring != "none" && !is_attachment_excluded( attachmentstring ) )
    {
        attachmentstring += "_";
    }
    else
    {
        attachmentstring = "";
    }
    
    return attachmentstring;
}

// Namespace loadout/loadout
// Params 0
// Checksum 0x310b3b87, Offset: 0x18e0
// Size: 0x22
function function_2d92f42b()
{
    if ( !isdefined( level.var_37e12aae ) )
    {
        return 0;
    }
    
    return level.var_37e12aae;
}

// Namespace loadout/loadout
// Params 2
// Checksum 0x946d0aa0, Offset: 0x1910
// Size: 0x9c
function getkillstreakindex( weaponclass, killstreaknum )
{
    killstreaknum++;
    killstreakstring = "killstreak" + killstreaknum;
    
    if ( getdvarint( #"custom_killstreak_mode", 0 ) == 2 )
    {
        return getdvarint( "custom_" + killstreakstring, 0 );
    }
    
    return self getloadoutitem( weaponclass, killstreakstring );
}

// Namespace loadout/loadout
// Params 1
// Checksum 0x8b3eb845, Offset: 0x19b8
// Size: 0x2c, Type: bool
function function_f180f8b9( perkname )
{
    return isdefined( perkname ) && isstring( perkname );
}

// Namespace loadout/loadout
// Params 1
// Checksum 0x2758edd4, Offset: 0x19f0
// Size: 0x16
function reset_specialty_slots( *class_num )
{
    self.specialty = [];
}

// Namespace loadout/loadout
// Params 0
// Checksum 0xc82e2faf, Offset: 0x1a10
// Size: 0xe
function function_9990945d()
{
    self.staticweaponsstarttime = gettime();
}

// Namespace loadout/loadout
// Params 1
// Checksum 0xfb01bcb9, Offset: 0x1a28
// Size: 0x50, Type: bool
function function_bac6b417( equipment_name )
{
    if ( isdefined( level.weapontacticalinsertion ) && equipment_name == level.weapontacticalinsertion.name && level.disabletacinsert )
    {
        return false;
    }
    
    return true;
}

// Namespace loadout/loadout
// Params 1
// Checksum 0x76ab1218, Offset: 0x1a80
// Size: 0x2e
function function_581addee( item )
{
    if ( level.leaguematch )
    {
        return isitemrestricted( item );
    }
    
    return 0;
}

// Namespace loadout/loadout
// Params 0, eflags: 0x4
// Checksum 0x1f79653f, Offset: 0x1ab8
// Size: 0x174
function private give_perks()
{
    pixbeginevent( #"give_perks" );
    self.specialty = self getloadoutperks( self.class_num );
    self setplayerstateloadoutweapons( self.class_num );
    
    if ( level.leaguematch )
    {
        for ( i = 0; i < self.specialty.size ; i++ )
        {
            if ( function_581addee( self.specialty[ i ] ) )
            {
                arrayremoveindex( self.specialty, i );
                i--;
            }
        }
    }
    
    self register_perks();
    
    if ( is_true( level.var_f0c898ec ) )
    {
        self setperk( "specialty_wallrun" );
        self setperk( "specialty_doublejump" );
        self setperk( "specialty_unlimitedsprint" );
    }
    
    pixendevent();
}

// Namespace loadout/loadout
// Params 0, eflags: 0x4
// Checksum 0xb9f02ce6, Offset: 0x1c38
// Size: 0x14c
function private function_5536bd9e()
{
    has_specialty_armor = self hasperk( #"specialty_armor" );
    healthtoassign = self.spawnhealth;
    
    if ( isdefined( level.maxspawnhealthboostprct ) )
    {
        self.bonusspawnhealth = int( level.maxspawnhealthboostprct * self.spawnhealth );
        healthtoassign += self.bonusspawnhealth;
    }
    
    self player::function_9080887a( healthtoassign );
    self.maxhealth = healthtoassign;
    new_health = self.var_66cb03ad < 0 ? healthtoassign : self.var_66cb03ad;
    self.health = new_health;
    self.maxarmor = has_specialty_armor ? self.spawnarmor : 0;
    self.armor = has_specialty_armor ? self.spawnarmor : 0;
    self.var_ed2f8b3a = self.spawnhealth;
    self healthoverlay::restart_player_health_regen();
}

// Namespace loadout/loadout
// Params 2
// Checksum 0x55ba3c3e, Offset: 0x1d90
// Size: 0x6c
function giveloadoutlevelspecific( *team, *weaponclass )
{
    pixbeginevent( #"giveloadoutlevelspecific" );
    
    if ( isdefined( level.givecustomloadout ) )
    {
        self [[ level.givecustomloadout ]]();
    }
    
    pixendevent();
}

// Namespace loadout/loadout
// Params 3
// Checksum 0xa4668881, Offset: 0x1e08
// Size: 0x18f4
function giveloadout( *team, weaponclass, var_d4a479a1 )
{
    pixbeginevent( #"giveloadout" );
    self takeallweapons();
    self.specialty = [];
    self.killstreak = [];
    self notify( #"give_map" );
    class_num_for_global_weapons = 0;
    primaryweaponoptions = 0;
    secondaryweaponoptions = 0;
    var_5cb470fc = 0;
    
    if ( issubstr( weaponclass, "CLASS_CUSTOM" ) )
    {
        pixbeginevent( #"custom class" );
        class_num = int( weaponclass[ weaponclass.size - 1 ] ) - 1;
        
        if ( -1 == class_num )
        {
            class_num = 9;
        }
        
        self.class_num = class_num;
        self setloadoutindex( class_num );
        
        if ( isdefined( var_d4a479a1 ) )
        {
            self.var_7c6c4302 = 1;
        }
        else
        {
            self.var_7c6c4302 = undefined;
        }
        
        self reset_specialty_slots( class_num );
        class_num_for_global_weapons = class_num;
        var_5cb470fc = 1;
        pixendevent();
    }
    else
    {
        pixbeginevent( #"default class" );
        assert( isdefined( self.pers[ #"class" ] ), "<dev string:xad>" );
        class_num = level.classtoclassnum[ weaponclass ];
        
        if ( !isdefined( class_num ) )
        {
            if ( isbot( self ) )
            {
                class_num = array::random( level.classtoclassnum );
            }
            else
            {
                assert( 0, "<dev string:xde>" + weaponclass + "<dev string:x116>" );
            }
        }
        
        self.class_num = class_num;
        pixendevent();
    }
    
    println( "<dev string:x11b>" + self.name + "<dev string:x129>" + function_9e72a96( level.weaponbasemelee.name ) + "<dev string:x13a>" );
    self giveweapon( level.weaponbasemelee );
    give_perks();
    function_5536bd9e();
    
    if ( !getdvarint( #"player_dpad_gadget_scheme", 0 ) )
    {
        self setactionslot( 3, "altMode" );
        self setactionslot( 4, "" );
    }
    
    spawnweapon = "";
    var_db44dae4 = 0;
    
    if ( isdefined( self.pers[ #"weapon" ] ) && self.pers[ #"weapon" ] != level.weaponnone && !self.pers[ #"weapon" ].iscarriedkillstreak )
    {
        primaryweapon = self.pers[ #"weapon" ];
    }
    else
    {
        primaryweapon = self getloadoutweapon( class_num, "primary" );
        
        if ( isdefined( var_d4a479a1 ) )
        {
            primaryweapon = var_d4a479a1 getloadoutweapon( class_num, "primary" );
        }
    }
    
    if ( primaryweapon.iscarriedkillstreak )
    {
        primaryweapon = level.weaponnull;
    }
    
    sidearm = self getloadoutweapon( class_num, "secondary" );
    
    if ( isdefined( var_d4a479a1 ) )
    {
        sidearm = var_d4a479a1 getloadoutweapon( class_num, "secondary" );
    }
    
    if ( sidearm.iscarriedkillstreak )
    {
        sidearm = level.weaponnull;
    }
    
    self.var_699ca781 = 0;
    self.var_b204c655 = 0;
    
    if ( sidearm != level.weaponnull )
    {
        secondaryweaponoptions = self function_6eff28b5( class_num, 1 );
        
        if ( isdefined( var_d4a479a1 ) )
        {
            secondaryweaponoptions = var_d4a479a1 function_6eff28b5( class_num, 1 );
        }
        
        println( "<dev string:x11b>" + self.name + "<dev string:x129>" + function_9e72a96( sidearm.name ) + "<dev string:x15b>" );
        self giveweapon( sidearm, secondaryweaponoptions );
        self.secondaryloadoutweapon = sidearm;
        self.var_241493f5 = sidearm.altweapon;
        self.secondaryloadoutgunsmithvariantindex = self getloadoutgunsmithvariantindex( self.class_num, 1 );
        
        if ( isdefined( var_d4a479a1 ) )
        {
            self.secondaryloadoutgunsmithvariantindex = var_d4a479a1 getloadoutgunsmithvariantindex( self.class_num, 1 );
        }
        
        self givemaxammo( sidearm );
        spawnweapon = sidearm;
        var_db44dae4++;
    }
    
    self.pers[ #"primaryweapon" ] = primaryweapon;
    self function_442539( "primary", primaryweapon );
    self function_442539( "secondary", sidearm );
    
    if ( primaryweapon != level.weaponnull )
    {
        primaryweaponoptions = self function_6eff28b5( class_num, 0 );
        
        if ( isdefined( var_d4a479a1 ) )
        {
            primaryweaponoptions = var_d4a479a1 function_6eff28b5( class_num, 0 );
        }
        
        println( "<dev string:x11b>" + self.name + "<dev string:x129>" + function_9e72a96( primaryweapon.name ) + "<dev string:x16c>" );
        self giveweapon( primaryweapon, primaryweaponoptions );
        self.primaryloadoutweapon = primaryweapon;
        self.var_cb301d8f = primaryweapon.altweapon;
        self.primaryloadoutgunsmithvariantindex = self getloadoutgunsmithvariantindex( self.class_num, 0 );
        
        if ( isdefined( var_d4a479a1 ) )
        {
            self.primaryloadoutgunsmithvariantindex = var_d4a479a1 getloadoutgunsmithvariantindex( self.class_num, 0 );
        }
        
        self givemaxammo( primaryweapon );
        spawnweapon = primaryweapon;
        var_db44dae4++;
    }
    
    if ( !self hasmaxprimaryweapons() )
    {
        if ( !isusingt7melee() )
        {
            println( "<dev string:x11b>" + self.name + "<dev string:x129>" + function_9e72a96( level.weaponbasemeleeheld.name ) + "<dev string:x17d>" );
            self giveweapon( level.weaponbasemeleeheld );
        }
        
        if ( var_db44dae4 == 0 )
        {
            spawnweapon = level.weaponbasemeleeheld;
        }
    }
    
    if ( !isdefined( self.spawnweapon ) && isdefined( self.pers[ #"spawnweapon" ] ) )
    {
        self.spawnweapon = self.pers[ #"spawnweapon" ];
    }
    
    if ( isdefined( self.spawnweapon ) && doesweaponreplacespawnweapon( self.spawnweapon, spawnweapon ) && !self.pers[ #"changed_class" ] )
    {
        spawnweapon = self.spawnweapon;
    }
    
    changedclass = self.pers[ #"changed_class" ];
    changedspecialist = 0;
    changedspecialist = self.pers[ #"changed_specialist" ];
    roundbased = !util::isoneround();
    firstround = util::isfirstround();
    self.pers[ #"changed_class" ] = 0;
    self.pers[ #"changed_specialist" ] = 0;
    self.spawnweapon = spawnweapon;
    self.pers[ #"spawnweapon" ] = self.spawnweapon;
    self setspawnweapon( spawnweapon );
    self.grenadetypeprimary = level.weaponnone;
    self.grenadetypeprimarycount = 0;
    self.grenadetypesecondary = level.weaponnone;
    self.grenadetypesecondarycount = 0;
    primaryoffhand = level.weaponnone;
    primaryoffhandcount = 0;
    secondaryoffhand = level.weaponnone;
    secondaryoffhandcount = 0;
    specialoffhand = level.weaponnone;
    specialoffhandcount = 0;
    primaryoffhandname = self.playerrole.primaryequipment;
    
    if ( isdefined( var_d4a479a1 ) )
    {
        primaryoffhandname = var_d4a479a1.playerrole.primaryequipment;
    }
    
    if ( !isdefined( primaryoffhandname ) )
    {
        var_6c4f8a69 = self function_b958b70d( class_num, "primarygrenade" );
        
        if ( isdefined( var_6c4f8a69 ) )
        {
            primaryoffhandname = var_6c4f8a69;
        }
    }
    
    if ( isdefined( primaryoffhandname ) && primaryoffhandname != #"" && primaryoffhandname != #"weapon_null" )
    {
        primaryoffhand = getweapon( primaryoffhandname );
        primaryoffhandcount = primaryoffhand.startammo;
    }
    
    if ( function_581addee( primaryoffhand.name ) || !function_bac6b417( primaryoffhand.name ) )
    {
        primaryoffhand = level.weaponnone;
        primaryoffhandcount = 0;
    }
    
    if ( primaryoffhand == level.weaponnone )
    {
    }
    
    if ( primaryoffhand != level.weaponnull )
    {
        println( "<dev string:x11b>" + self.name + "<dev string:x129>" + function_9e72a96( primaryoffhand.name ) + "<dev string:x1a2>" );
        self giveweapon( primaryoffhand );
        self setweaponammoclip( primaryoffhand, primaryoffhandcount );
        self switchtooffhand( primaryoffhand );
        self.grenadetypeprimary = primaryoffhand;
        self.grenadetypeprimarycount = primaryoffhandcount;
        self ability_util::gadget_reset( primaryoffhand, changedclass, roundbased, firstround, changedspecialist );
        self ability_util::gadget_power_full( primaryoffhand );
    }
    
    self function_442539( "primarygrenade", primaryoffhand );
    secondaryoffhandname = self function_b958b70d( class_num, "specialgrenade" );
    
    if ( isdefined( var_d4a479a1 ) )
    {
        secondaryoffhandname = var_d4a479a1 function_b958b70d( class_num, "specialgrenade" );
    }
    
    if ( secondaryoffhandname != "" && secondaryoffhandname != "weapon_null" && secondaryoffhandname != "weapon_null_cp" )
    {
        secondaryoffhand = getweapon( secondaryoffhandname );
        secondaryoffhandcount = self getloadoutitem( class_num, "specialgrenadecount" );
        
        if ( isdefined( var_d4a479a1 ) )
        {
            secondaryoffhandcount = var_d4a479a1 getloadoutitem( class_num, "specialgrenadecount" );
        }
    }
    
    if ( function_581addee( secondaryoffhand.name ) || !function_bac6b417( secondaryoffhand.name ) )
    {
        secondaryoffhand = level.weaponnone;
        secondaryoffhandcount = 0;
    }
    
    if ( is_true( level.var_6454ed48 ) )
    {
        if ( !isbot( self ) )
        {
            secondaryoffhand = level.weapons[ #"health" ];
        }
        else
        {
            secondaryoffhand = level.weapons[ #"hash_f507cc3a8ec96dd" ];
        }
        
        secondaryoffhandcount = 0;
    }
    
    if ( secondaryoffhand != level.weaponnull )
    {
        weapons::function_a9a8aed8( primaryoffhand );
        println( "<dev string:x11b>" + self.name + "<dev string:x129>" + function_9e72a96( secondaryoffhand.name ) + "<dev string:x1ba>" );
        self giveweapon( secondaryoffhand );
        self setweaponammoclip( secondaryoffhand, secondaryoffhandcount );
        self switchtooffhand( secondaryoffhand );
        self.grenadetypesecondary = secondaryoffhand;
        self.grenadetypesecondarycount = secondaryoffhandcount;
        self ability_util::gadget_reset( secondaryoffhand, changedclass, roundbased, firstround, changedspecialist );
        self ability_util::gadget_power_full( secondaryoffhand );
    }
    
    self function_442539( "secondarygrenade", secondaryoffhand );
    specialoffhand = isdefined( self.playerrole.var_c21d61e9 ) ? getweapon( self.playerrole.var_c21d61e9 ) : level.weaponnone;
    
    if ( isdefined( var_d4a479a1 ) && isdefined( var_d4a479a1.playerrole.var_c21d61e9 ) )
    {
        specialoffhand = getweapon( var_d4a479a1.playerrole.var_c21d61e9 );
    }
    
    if ( specialoffhand == level.weaponnone )
    {
        herogadget = self getloadoutweapon( class_num, "herogadget" );
        
        if ( isdefined( herogadget ) )
        {
            specialoffhand = herogadget;
        }
    }
    
    specialoffhandcount = specialoffhand.startammo;
    
    if ( function_581addee( specialoffhand.name ) || !function_bac6b417( specialoffhand.name ) )
    {
        specialoffhand = level.weaponnone;
        specialoffhandcount = 0;
    }
    
    if ( specialoffhand == level.weaponnone )
    {
        specialoffhand = level.weaponnull;
        specialoffhandcount = 0;
    }
    
    if ( specialoffhand != level.weaponnull )
    {
        println( "<dev string:x11b>" + self.name + "<dev string:x129>" + function_9e72a96( specialoffhand.name ) + "<dev string:x1d4>" );
        self giveweapon( specialoffhand );
        self setweaponammoclip( specialoffhand, specialoffhandcount );
        self switchtooffhand( specialoffhand );
        self.var_23e46e0e = specialoffhand;
        self.var_854499d7 = specialoffhandcount;
        self ability_util::gadget_reset( specialoffhand, changedclass, roundbased, firstround, changedspecialist );
    }
    
    self function_442539( "herogadget", specialoffhand );
    ultimateweapon = isdefined( self.playerrole.ultimateweapon ) ? getweapon( self.playerrole.ultimateweapon ) : level.weaponnone;
    
    if ( isdefined( var_d4a479a1 ) && isdefined( var_d4a479a1.playerrole.ultimateweapon ) )
    {
        ultimateweapon = getweapon( var_d4a479a1.playerrole.ultimateweapon );
    }
    
    if ( ultimateweapon == level.weaponnone )
    {
        herogadget = self getloadoutweapon( class_num, "ultimate" );
        
        if ( isdefined( herogadget ) )
        {
            ultimateweapon = herogadget;
        }
    }
    
    var_f4b2719 = ultimateweapon.startammo;
    
    if ( function_581addee( ultimateweapon.name ) || !function_bac6b417( ultimateweapon.name ) )
    {
        ultimateweapon = level.weaponnone;
        var_f4b2719 = 0;
    }
    
    if ( ultimateweapon == level.weaponnone )
    {
        ultimateweapon = level.weaponnull;
        var_f4b2719 = 0;
    }
    
    if ( ultimateweapon != level.weaponnull )
    {
        println( "<dev string:x11b>" + self.name + "<dev string:x129>" + function_9e72a96( ultimateweapon.name ) + "<dev string:x1ec>" );
        self giveweapon( ultimateweapon );
        self setweaponammoclip( ultimateweapon, var_f4b2719 );
        loadout = self get_loadout_slot( "ultimate" );
        loadout.weapon = ultimateweapon;
        loadout.count = var_f4b2719;
        self ability_util::gadget_reset( ultimateweapon, changedclass, roundbased, firstround, changedspecialist );
    }
    
    self function_442539( "ultimate", ultimateweapon );
    self bbclasschoice( class_num, primaryweapon, sidearm );
    
    for ( i = 0; i < 3 ; i++ )
    {
        if ( level.loadoutkillstreaksenabled && isdefined( self.killstreak[ i ] ) && isdefined( level.killstreakindices[ self.killstreak[ i ] ] ) )
        {
            killstreaks[ i ] = level.killstreakindices[ self.killstreak[ i ] ];
            continue;
        }
        
        killstreaks[ i ] = 0;
    }
    
    self recordloadoutperksandkillstreaks( primaryweapon, sidearm, self.grenadetypeprimary, self.grenadetypesecondary, killstreaks[ 0 ], killstreaks[ 1 ], killstreaks[ 2 ] );
    self function_9990945d();
    self thread initweaponattachments( spawnweapon );
    
    if ( isdefined( self.movementspeedmodifier ) )
    {
        self setmovespeedscale( self.movementspeedmodifier * self getmovespeedscale() );
    }
    
    if ( isdefined( level.givecustomloadout ) )
    {
        spawnweapon = self [[ level.givecustomloadout ]]();
        
        if ( isdefined( spawnweapon ) )
        {
            self thread initweaponattachments( spawnweapon );
        }
    }
    
    self cac_selector();
    
    if ( isdefined( self.firstspawn ) ? self.firstspawn : 1 )
    {
        if ( isdefined( spawnweapon ) )
        {
            self initialweaponraise( spawnweapon );
        }
        else
        {
            self initialweaponraise( primaryweapon );
        }
    }
    else
    {
        self seteverhadweaponall( 1 );
    }
    
    var_b4f40fcb = self savegame::function_2ee66e93( "saved_weapon", undefined );
    
    if ( isdefined( var_b4f40fcb ) )
    {
        self player::take_weapons();
        self._current_weapon = util::get_weapon_by_name( var_b4f40fcb, self savegame::function_2ee66e93( "saved_weapon_attachments", undefined ) );
        self._weapons = self savegame::function_2ee66e93( "saved_weapondata", undefined );
        self.lives = self savegame::function_2ee66e93( "lives", 0 );
        self player::give_back_weapons( 0 );
    }
    
    self.switchedteamsresetgadgets = 0;
    self.initialloadoutgiven = 1;
    self flag::set( #"loadout_given" );
    callback::callback( #"on_loadout" );
    pixendevent();
}

// Namespace loadout/loadout
// Params 0
// Checksum 0x45d97b8f, Offset: 0x3708
// Size: 0x102
function onplayerconnecting()
{
    for ( ;; )
    {
        waitresult = level waittill( #"connecting" );
        player = waitresult.player;
        
        if ( !level.oldschool )
        {
            if ( !isdefined( player.pers[ #"class" ] ) )
            {
                player.pers[ #"class" ] = "";
            }
            
            player.curclass = player.pers[ #"class" ];
            player.lastclass = "";
        }
        
        player.detectexplosives = 0;
        
        /#
            player.var_68e681e6 = [];
        #/
        
        player.var_8e38672c = [];
        player.var_ea17b208 = [];
        player.var_d0af3456 = [];
    }
}

// Namespace loadout/loadout
// Params 1
// Checksum 0xf6e2a6aa, Offset: 0x3818
// Size: 0x1a
function setclass( newclass )
{
    self.curclass = newclass;
}

// Namespace loadout/player_loadoutchanged
// Params 1, eflags: 0x40
// Checksum 0x91d546f8, Offset: 0x3840
// Size: 0x2c
function event_handler[player_loadoutchanged] loadout_changed( eventstruct )
{
    self callback::callback( #"hash_39bf72fd97e248a0", eventstruct );
}

// Namespace loadout/loadout
// Params 0
// Checksum 0x61323d1c, Offset: 0x3878
// Size: 0x12c
function initperkdvars()
{
    level.cac_armorpiercing_data = getdvarint( #"perk_armorpiercing", 40 ) / 100;
    level.cac_bulletdamage_data = getdvarint( #"perk_bulletdamage", 35 );
    level.cac_fireproof_data = getdvarint( #"perk_fireproof", 95 );
    level.cac_armorvest_data = getdvarint( #"perk_armorvest", 80 );
    level.cac_flakjacket_data = getdvarint( #"perk_flakjacket", 35 );
    level.cac_flakjacket_hardcore_data = getdvarint( #"perk_flakjacket_hardcore", 9 );
}

// Namespace loadout/loadout
// Params 0
// Checksum 0x419e955b, Offset: 0x39b0
// Size: 0x72
function cac_selector()
{
    perks = self.specialty;
    self.detectexplosives = 0;
    
    for ( i = 0; i < perks.size ; i++ )
    {
        perk = perks[ i ];
        
        if ( perk == "specialty_detectexplosive" )
        {
            self.detectexplosives = 1;
        }
    }
}

// Namespace loadout/loadout
// Params 0
// Checksum 0xb58db2db, Offset: 0x3a30
// Size: 0x114
function register_perks()
{
    perks = self.specialty;
    self clearperks();
    
    for ( i = 0; i < perks.size ; i++ )
    {
        perk = perks[ i ];
        
        if ( perk == #"specialty_null" || perk == #"weapon_null" )
        {
            continue;
        }
        
        if ( !level.perksenabled )
        {
            continue;
        }
        
        println( "<dev string:x11b>" + self.name + "<dev string:x204>" + perk + "<dev string:x212>" );
        self setperk( perk );
    }
    
    /#
        dev::giveextraperks();
    #/
}

// Namespace loadout/loadout
// Params 7
// Checksum 0x3b7c2e52, Offset: 0x3b50
// Size: 0x62e
function cac_modified_damage( victim, attacker, damage, mod, weapon, inflictor, hitloc )
{
    assert( isdefined( victim ) );
    assert( isdefined( attacker ) );
    assert( isplayer( victim ) );
    
    if ( damage <= 0 )
    {
        return damage;
    }
    
    /#
        debug = 0;
        
        if ( getdvarint( #"scr_perkdebug", 0 ) )
        {
            debug = 1;
        }
    #/
    
    final_damage = damage;
    
    if ( isplayer( attacker ) && attacker hasperk( #"specialty_bulletdamage" ) && isprimarydamage( mod ) )
    {
        if ( victim hasperk( #"specialty_armorvest" ) && !function_a5c17a08( hitloc ) )
        {
            /#
                if ( debug )
                {
                    println( "<dev string:x220>" + victim.name + "<dev string:x22b>" + attacker.name + "<dev string:x242>" );
                }
            #/
        }
        else
        {
            final_damage = damage * ( 100 + level.cac_bulletdamage_data ) / 100;
            
            /#
                if ( debug )
                {
                    println( "<dev string:x220>" + attacker.name + "<dev string:x260>" + victim.name );
                }
            #/
        }
    }
    else if ( victim hasperk( #"specialty_armorvest" ) && isprimarydamage( mod ) && !function_a5c17a08( hitloc ) )
    {
        final_damage = damage * level.cac_armorvest_data * 0.01;
        
        /#
            if ( debug )
            {
                println( "<dev string:x220>" + attacker.name + "<dev string:x289>" + victim.name );
            }
        #/
    }
    else if ( victim hasperk( #"specialty_fireproof" ) && isfiredamage( weapon, mod ) )
    {
        final_damage = damage * ( 100 - level.cac_fireproof_data ) / 100;
        
        /#
            if ( debug )
            {
                println( "<dev string:x220>" + attacker.name + "<dev string:x2b1>" + victim.name );
            }
        #/
    }
    else if ( victim hasperk( #"specialty_flakjacket" ) && weapons::isexplosivedamage( mod ) && !weapon.ignoresflakjacket && !victim grenadestuck( inflictor ) )
    {
        cac_data = level.hardcoremode ? level.cac_flakjacket_hardcore_data : level.cac_flakjacket_data;
        
        if ( level.teambased && attacker.team != victim.team )
        {
            victim thread challenges::flakjacketprotected( weapon, attacker );
        }
        else if ( attacker != victim )
        {
            victim thread challenges::flakjacketprotected( weapon, attacker );
        }
        
        final_damage = int( damage * cac_data / 100 );
        
        /#
            if ( debug )
            {
                println( "<dev string:x220>" + victim.name + "<dev string:x2d2>" + attacker.name + "<dev string:x2ef>" );
            }
        #/
    }
    
    /#
        victim.cac_debug_damage_type = tolower( mod );
        victim.cac_debug_original_damage = damage;
        victim.cac_debug_final_damage = final_damage;
        victim.cac_debug_location = tolower( hitloc );
        victim.cac_debug_weapon = weapon.name;
        victim.cac_debug_range = int( distance( attacker.origin, victim.origin ) );
        
        if ( debug )
        {
            println( "<dev string:x304>" + final_damage / damage + "<dev string:x31e>" + damage + "<dev string:x331>" + final_damage );
        }
    #/
    
    final_damage = int( final_damage );
    
    if ( final_damage < 1 )
    {
        final_damage = 1;
    }
    
    return final_damage;
}

// Namespace loadout/loadout
// Params 1
// Checksum 0xa2ca909, Offset: 0x4188
// Size: 0x64, Type: bool
function isexplosivedamage( meansofdeath )
{
    switch ( meansofdeath )
    {
        case #"mod_explosive":
        case #"mod_grenade":
        case #"mod_grenade_splash":
        case #"mod_projectile_splash":
            return true;
    }
    
    return false;
}

// Namespace loadout/loadout
// Params 1
// Checksum 0x48dca36c, Offset: 0x41f8
// Size: 0x74, Type: bool
function function_88c673cf( player )
{
    return player hasperk( #"specialty_stunprotection" ) || player hasperk( #"specialty_flashprotection" ) || player hasperk( #"specialty_proximityprotection" );
}

// Namespace loadout/loadout
// Params 2
// Checksum 0x3ee8ee70, Offset: 0x4278
// Size: 0x64, Type: bool
function isfiredamage( weapon, meansofdeath )
{
    if ( weapon.doesfiredamage && ( meansofdeath == "MOD_BURNED" || meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_GRENADE_SPLASH" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace loadout/loadout
// Params 1
// Checksum 0x232520d4, Offset: 0x42e8
// Size: 0x3e, Type: bool
function function_a5c17a08( hitloc )
{
    return hitloc == "helmet" || hitloc == "head" || hitloc == "neck";
}

// Namespace loadout/loadout
// Params 1
// Checksum 0xcec3ec34, Offset: 0x4330
// Size: 0x34, Type: bool
function grenadestuck( inflictor )
{
    return isdefined( inflictor ) && isdefined( inflictor.stucktoplayer ) && inflictor.stucktoplayer == self;
}

/#

    // Namespace loadout/loadout
    // Params 0
    // Checksum 0x6b950e5f, Offset: 0x4370
    // Size: 0x74, Type: dev
    function function_df570a20()
    {
        setdvar( #"hash_18f4fae1a9be4957", 0 );
        adddebugcommand( "<dev string:x345>" );
        adddebugcommand( "<dev string:x38f>" );
        level thread function_fee2f3bc();
    }

    // Namespace loadout/loadout
    // Params 0
    // Checksum 0x7e9a9579, Offset: 0x43f0
    // Size: 0x2d8, Type: dev
    function function_fee2f3bc()
    {
        level notify( #"hash_5ffcf7ef265d671a" );
        level endon( #"hash_5ffcf7ef265d671a" );
        
        while ( true )
        {
            cmd = getdvarint( #"hash_18f4fae1a9be4957", 0 );
            
            switch ( cmd )
            {
                case 1:
                    if ( !is_true( level.var_f0c898ec ) )
                    {
                        level.var_f0c898ec = 1;
                        a_players = getplayers();
                        
                        foreach ( e_player in a_players )
                        {
                            e_player setperk( "<dev string:x3da>" );
                            e_player setperk( "<dev string:x3ef>" );
                            e_player setperk( "<dev string:x407>" );
                        }
                    }
                    
                    break;
                case 2:
                    if ( is_true( level.var_f0c898ec ) )
                    {
                        level.var_f0c898ec = undefined;
                        a_players = getplayers();
                        
                        foreach ( e_player in a_players )
                        {
                            e_player unsetperk( "<dev string:x3da>" );
                            e_player unsetperk( "<dev string:x3ef>" );
                            e_player unsetperk( "<dev string:x407>" );
                        }
                    }
                    
                    break;
            }
            
            setdvar( #"hash_18f4fae1a9be4957", 0 );
            wait 0.5;
        }
    }

#/
