#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/abilities/gadgets/gadget_roulette;
#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/dev_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/killstreaks_shared;
#using scripts/core_common/loadout_shared;
#using scripts/core_common/player_role;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/tweakables_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/weapon_utils;
#using scripts/mp_common/armor;
#using scripts/mp_common/challenges;
#using scripts/mp_common/draft;
#using scripts/mp_common/gametypes/dev;
#using scripts/mp_common/gametypes/globallogic_player;
#using scripts/mp_common/gametypes/globallogic_score;
#using scripts/mp_common/gametypes/globallogic_spawn;
#using scripts/mp_common/gametypes/globallogic_utils;
#using scripts/mp_common/gametypes/healthoverlay;
#using scripts/mp_common/gametypes/weapons;
#using scripts/mp_common/killstreaks/killstreak_weapons;
#using scripts/mp_common/killstreaks/killstreaks;
#using scripts/mp_common/teams/teams;
#using scripts/mp_common/util;

#namespace loadout;

// Namespace loadout/loadout
// Params 0, eflags: 0x2
// Checksum 0x2056e51c, Offset: 0xef8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "loadout", &__init__, undefined, undefined );
}

// Namespace loadout/loadout
// Params 0
// Checksum 0xe2d84aa, Offset: 0xf38
// Size: 0x44
function __init__()
{
    callback::on_start_gametype( &init );
    callback::on_connect( &on_connect );
}

// Namespace loadout/loadout
// Params 0
// Checksum 0x80f724d1, Offset: 0xf88
// Size: 0x4
function on_connect()
{
    
}

// Namespace loadout/loadout
// Params 0
// Checksum 0x32555051, Offset: 0xf98
// Size: 0x12b4
function init()
{
    level.classmap[ "class_smg" ] = "CLASS_SMG";
    level.classmap[ "class_cqb" ] = "CLASS_CQB";
    level.classmap[ "class_assault" ] = "CLASS_ASSAULT";
    level.classmap[ "class_lmg" ] = "CLASS_LMG";
    level.classmap[ "class_sniper" ] = "CLASS_SNIPER";
    level.classmap[ "custom0" ] = "CLASS_CUSTOM1";
    level.classmap[ "custom1" ] = "CLASS_CUSTOM2";
    level.classmap[ "custom2" ] = "CLASS_CUSTOM3";
    level.classmap[ "custom3" ] = "CLASS_CUSTOM4";
    level.classmap[ "custom4" ] = "CLASS_CUSTOM5";
    level.classmap[ "custom5" ] = "CLASS_CUSTOM6";
    level.classmap[ "custom6" ] = "CLASS_CUSTOM7";
    level.classmap[ "custom7" ] = "CLASS_CUSTOM8";
    level.classmap[ "custom8" ] = "CLASS_CUSTOM9";
    level.classmap[ "custom9" ] = "CLASS_CUSTOM10";
    level.maxkillstreaks = 4;
    level.maxspecialties = 6;
    level.var_ab2ebd2b = 3;
    level.maxallocation = getgametypesetting( "maxAllocation" );
    level.loadoutkillstreaksenabled = getgametypesetting( "loadoutKillstreaksEnabled" );
    level.weaponbasemeleeheld = getweapon( "bare_hands" );
    level.weaponknifeloadout = getweapon( "knife_loadout" );
    level.var_dbfc7979 = getweapon( "melee_knuckles" );
    level.var_4b668568 = getweapon( "melee_butterfly" );
    level.var_ed508918 = getweapon( "melee_wrench" );
    level.var_9d6d34a6 = getweapon( "melee_sword" );
    level.var_2506cce1 = getweapon( "melee_crowbar" );
    level.weaponspecialcrossbow = getweapon( "special_crossbow" );
    level.var_a37fcb5 = getweapon( "melee_dagger" );
    level.var_87abc71c = getweapon( "melee_bat" );
    level.var_50ef580f = getweapon( "melee_bowie" );
    level.var_fcab6539 = getweapon( "melee_mace" );
    level.var_680e11a1 = getweapon( "melee_fireaxe" );
    level.var_d81e42fb = getweapon( "melee_boneglass" );
    level.var_b6eabba5 = getweapon( "melee_improvise" );
    level.weaponshotgunenergy = getweapon( "shotgun_energy" );
    level.weaponpistolenergy = getweapon( "pistol_energy" );
    level.meleeweapons = [];
    
    if ( !isdefined( level.meleeweapons ) )
    {
        level.meleeweapons = [];
    }
    else if ( !isarray( level.meleeweapons ) )
    {
        level.meleeweapons = array( level.meleeweapons );
    }
    
    level.meleeweapons[ level.meleeweapons.size ] = level.weaponknifeloadout;
    
    if ( !isdefined( level.meleeweapons ) )
    {
        level.meleeweapons = [];
    }
    else if ( !isarray( level.meleeweapons ) )
    {
        level.meleeweapons = array( level.meleeweapons );
    }
    
    level.meleeweapons[ level.meleeweapons.size ] = level.var_dbfc7979;
    
    if ( !isdefined( level.meleeweapons ) )
    {
        level.meleeweapons = [];
    }
    else if ( !isarray( level.meleeweapons ) )
    {
        level.meleeweapons = array( level.meleeweapons );
    }
    
    level.meleeweapons[ level.meleeweapons.size ] = level.var_4b668568;
    
    if ( !isdefined( level.meleeweapons ) )
    {
        level.meleeweapons = [];
    }
    else if ( !isarray( level.meleeweapons ) )
    {
        level.meleeweapons = array( level.meleeweapons );
    }
    
    level.meleeweapons[ level.meleeweapons.size ] = level.var_ed508918;
    
    if ( !isdefined( level.meleeweapons ) )
    {
        level.meleeweapons = [];
    }
    else if ( !isarray( level.meleeweapons ) )
    {
        level.meleeweapons = array( level.meleeweapons );
    }
    
    level.meleeweapons[ level.meleeweapons.size ] = level.var_9d6d34a6;
    
    if ( !isdefined( level.meleeweapons ) )
    {
        level.meleeweapons = [];
    }
    else if ( !isarray( level.meleeweapons ) )
    {
        level.meleeweapons = array( level.meleeweapons );
    }
    
    level.meleeweapons[ level.meleeweapons.size ] = level.var_2506cce1;
    
    if ( !isdefined( level.meleeweapons ) )
    {
        level.meleeweapons = [];
    }
    else if ( !isarray( level.meleeweapons ) )
    {
        level.meleeweapons = array( level.meleeweapons );
    }
    
    level.meleeweapons[ level.meleeweapons.size ] = level.var_a37fcb5;
    
    if ( !isdefined( level.meleeweapons ) )
    {
        level.meleeweapons = [];
    }
    else if ( !isarray( level.meleeweapons ) )
    {
        level.meleeweapons = array( level.meleeweapons );
    }
    
    level.meleeweapons[ level.meleeweapons.size ] = level.var_87abc71c;
    
    if ( !isdefined( level.meleeweapons ) )
    {
        level.meleeweapons = [];
    }
    else if ( !isarray( level.meleeweapons ) )
    {
        level.meleeweapons = array( level.meleeweapons );
    }
    
    level.meleeweapons[ level.meleeweapons.size ] = level.var_50ef580f;
    
    if ( !isdefined( level.meleeweapons ) )
    {
        level.meleeweapons = [];
    }
    else if ( !isarray( level.meleeweapons ) )
    {
        level.meleeweapons = array( level.meleeweapons );
    }
    
    level.meleeweapons[ level.meleeweapons.size ] = level.var_fcab6539;
    
    if ( !isdefined( level.meleeweapons ) )
    {
        level.meleeweapons = [];
    }
    else if ( !isarray( level.meleeweapons ) )
    {
        level.meleeweapons = array( level.meleeweapons );
    }
    
    level.meleeweapons[ level.meleeweapons.size ] = level.var_680e11a1;
    
    if ( !isdefined( level.meleeweapons ) )
    {
        level.meleeweapons = [];
    }
    else if ( !isarray( level.meleeweapons ) )
    {
        level.meleeweapons = array( level.meleeweapons );
    }
    
    level.meleeweapons[ level.meleeweapons.size ] = level.var_d81e42fb;
    
    if ( !isdefined( level.meleeweapons ) )
    {
        level.meleeweapons = [];
    }
    else if ( !isarray( level.meleeweapons ) )
    {
        level.meleeweapons = array( level.meleeweapons );
    }
    
    level.meleeweapons[ level.meleeweapons.size ] = level.var_b6eabba5;
    level.prestigenumber = 5;
    level.defaultclass = "CLASS_CUSTOM0";
    
    if ( tweakables::gettweakablevalue( "weapon", "allowfrag" ) )
    {
        level.weapons[ "frag" ] = getweapon( "frag_grenade" );
    }
    else
    {
        level.weapons[ "frag" ] = "";
    }
    
    if ( tweakables::gettweakablevalue( "weapon", "allowsmoke" ) )
    {
        level.weapons[ "smoke" ] = getweapon( "smoke_grenade" );
    }
    else
    {
        level.weapons[ "smoke" ] = "";
    }
    
    if ( tweakables::gettweakablevalue( "weapon", "allowflash" ) )
    {
        level.weapons[ "flash" ] = getweapon( "flash_grenade" );
    }
    else
    {
        level.weapons[ "flash" ] = "";
    }
    
    level.weapons[ "concussion" ] = getweapon( "concussion_grenade" );
    
    if ( tweakables::gettweakablevalue( "weapon", "allowsatchel" ) )
    {
        level.weapons[ "satchel_charge" ] = getweapon( "satchel_charge" );
    }
    else
    {
        level.weapons[ "satchel_charge" ] = "";
    }
    
    if ( tweakables::gettweakablevalue( "weapon", "allowbetty" ) )
    {
        level.weapons[ "betty" ] = getweapon( "mine_bouncing_betty" );
    }
    else
    {
        level.weapons[ "betty" ] = "";
    }
    
    if ( tweakables::gettweakablevalue( "weapon", "allowrpgs" ) )
    {
        level.weapons[ "rpg" ] = getweapon( "rpg" );
    }
    else
    {
        level.weapons[ "rpg" ] = "";
    }
    
    create_class_exclusion_list();
    function_cd945d1d();
    load_default_loadout( "CLASS_SMG", 10 );
    load_default_loadout( "CLASS_CQB", 11 );
    load_default_loadout( "CLASS_ASSAULT", 12 );
    load_default_loadout( "CLASS_LMG", 13 );
    load_default_loadout( "CLASS_SNIPER", 14 );
    level.primary_weapon_array = [];
    level.side_arm_array = [];
    level.grenade_array = [];
    level.inventory_array = [];
    var_47c38c35 = 99;
    
    for ( i = 0; i < var_47c38c35 ; i++ )
    {
        if ( !isdefined( level.tbl_weaponids[ i ] ) || level.tbl_weaponids[ i ][ "group" ] == "" )
        {
            continue;
        }
        
        if ( !isdefined( level.tbl_weaponids[ i ] ) || level.tbl_weaponids[ i ][ "reference" ] == "" )
        {
            continue;
        }
        
        weapon_type = level.tbl_weaponids[ i ][ "group" ];
        weapon = level.tbl_weaponids[ i ][ "reference" ];
        attachment = level.tbl_weaponids[ i ][ "attachment" ];
        weapon_class_register( weapon, weapon_type );
        
        if ( isdefined( attachment ) && attachment.size < 0 )
        {
            for ( k = 0; k < attachment.size ; k++ )
            {
                weapon_class_register( weapon + "_" + attachment[ k ], weapon_type );
            }
        }
    }
    
    callback::on_connecting( &on_player_connecting );
}

// Namespace loadout/loadout
// Params 0
// Checksum 0x99a63859, Offset: 0x2258
// Size: 0x108
function create_class_exclusion_list()
{
    currentdvar = 0;
    level.itemexclusions = [];
    
    while ( getdvarint( "item_exclusion_" + currentdvar ) )
    {
        level.itemexclusions[ currentdvar ] = getdvarint( "item_exclusion_" + currentdvar );
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
// Checksum 0xebafca41, Offset: 0x2368
// Size: 0x70, Type: bool
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
// Checksum 0x4249bd4d, Offset: 0x23e0
// Size: 0x22
function function_5cd00b1b( var_cf9f6a1f )
{
    itemcount = 1;
    return itemcount;
}

// Namespace loadout/loadout
// Params 2
// Checksum 0x468a2985, Offset: 0x2410
// Size: 0x80
function function_8428dec1( classname, slotname )
{
    var_cf9f6a1f = getdefaultclassslot( classname, slotname );
    itemindex = getitemindexfromref( var_cf9f6a1f );
    
    if ( is_item_excluded( itemindex ) )
    {
        var_cf9f6a1f = "weapon_null";
    }
    
    return var_cf9f6a1f;
}

// Namespace loadout/loadout
// Params 2
// Checksum 0xacd3f1a4, Offset: 0x2498
// Size: 0x2a
function load_default_loadout( weaponclass, classnum )
{
    level.classtoclassnum[ weaponclass ] = classnum;
}

// Namespace loadout/loadout
// Params 2
// Checksum 0x338a3803, Offset: 0x24d0
// Size: 0x19c
function weapon_class_register( weaponname, weapon_type )
{
    if ( issubstr( "weapon_smg weapon_cqb weapon_assault weapon_lmg weapon_sniper weapon_shotgun weapon_launcher weapon_knife weapon_special", weapon_type ) )
    {
        level.primary_weapon_array[ getweapon( weaponname ) ] = 1;
        return;
    }
    
    if ( issubstr( "weapon_pistol", weapon_type ) )
    {
        level.side_arm_array[ getweapon( weaponname ) ] = 1;
        return;
    }
    
    if ( weapon_type == "weapon_grenade" )
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
    
    assert( 0, "<dev string:x28>" + weapon_type );
}

// Namespace loadout/loadout
// Params 1
// Checksum 0xc53e722c, Offset: 0x2678
// Size: 0x4a
function heavy_weapon_register_dialog( weapon )
{
    readyvo = weapon.name + "_ready";
    game.dialog[ readyvo ] = readyvo;
}

// Namespace loadout/loadout
// Params 0
// Checksum 0xf8ce006, Offset: 0x26d0
// Size: 0x390
function function_cd945d1d()
{
    level.tbl_weaponids = [];
    level.var_aa875d4f = [];
    level.perknames = [];
    level.perkicons = [];
    level.perkspecialties = [];
    level.var_41e73a09 = [];
    level.killstreakicons = [];
    level.killstreakindices = [];
    
    for ( i = 0; i < 1024 ; i++ )
    {
        iteminfo = getunlockableiteminfofromindex( i );
        
        if ( isdefined( iteminfo ) )
        {
            group_s = iteminfo.itemgroupname;
            reference_s = iteminfo.name;
            var_87bdace0 = iteminfo.image;
            display_name_s = iteminfo.displayname;
            
            if ( issubstr( group_s, "weapon_" ) || group_s == "hero" )
            {
                weapon = getweapon( reference_s );
                
                if ( weapon.isheavyweapon )
                {
                    level.var_aa875d4f[ reference_s ] = [];
                    level.var_aa875d4f[ reference_s ][ "index" ] = i;
                    heavy_weapon_register_dialog( weapon );
                }
                
                level.tbl_weaponids[ i ][ "reference" ] = reference_s;
                level.tbl_weaponids[ i ][ "group" ] = group_s;
                level.tbl_weaponids[ i ][ "count" ] = iteminfo.count;
                level.tbl_weaponids[ i ][ "attachment" ] = iteminfo.attachments;
                continue;
            }
            
            if ( group_s == "specialty" )
            {
                level.perknames[ var_87bdace0 ] = display_name_s;
                level.perkicons[ display_name_s ] = var_87bdace0;
                level.perkspecialties[ display_name_s ] = reference_s;
                
                /#
                    dev::add_perk_devgui( display_name_s, reference_s );
                #/
                
                continue;
            }
            
            if ( group_s == "killstreak" )
            {
                level.tbl_killstreakdata[ i ] = reference_s;
                level.killstreakindices[ reference_s ] = i;
                level.var_41e73a09[ reference_s ] = display_name_s;
                level.killstreakicons[ reference_s ] = var_87bdace0;
                level.killstreakindices[ reference_s ] = i;
            }
        }
    }
}

// Namespace loadout/loadout
// Params 1
// Checksum 0x7009f050, Offset: 0x2a68
// Size: 0x44
function getclasschoice( response )
{
    assert( isdefined( level.classmap[ response ] ) );
    return level.classmap[ response ];
}

// Namespace loadout/loadout
// Params 2
// Checksum 0x7d09c33a, Offset: 0x2ab8
// Size: 0x88
function function_bb59b4b7( var_7d65157, var_26e2fb26 )
{
    attachmentstring = getitemattachment( var_7d65157, var_26e2fb26 );
    
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
// Checksum 0x4deb0ada, Offset: 0x2b48
// Size: 0x22
function function_5933877()
{
    if ( !isdefined( level.var_b65167f1 ) )
    {
        return 0;
    }
    
    return level.var_b65167f1;
}

// Namespace loadout/loadout
// Params 2
// Checksum 0x7fba3bb1, Offset: 0x2b78
// Size: 0x94
function getkillstreakindex( weaponclass, killstreaknum )
{
    killstreaknum++;
    killstreakstring = "killstreak" + killstreaknum;
    
    if ( getdvarint( "custom_killstreak_mode" ) == 2 )
    {
        return getdvarint( "custom_" + killstreakstring );
    }
    
    return self getloadoutitem( weaponclass, killstreakstring );
}

// Namespace loadout/loadout
// Params 0
// Checksum 0x589ba333, Offset: 0x2c18
// Size: 0x586
function function_66234473()
{
    self.killstreak = [];
    
    if ( !level.loadoutkillstreaksenabled )
    {
        return;
    }
    
    classnum = self.class_num_for_global_weapons;
    sortedkillstreaks = [];
    currentkillstreak = 0;
    
    for ( killstreaknum = 0; killstreaknum < level.maxkillstreaks ; killstreaknum++ )
    {
        killstreakindex = getkillstreakindex( classnum, killstreaknum );
        
        if ( isdefined( killstreakindex ) && killstreakindex > 0 )
        {
            assert( isdefined( level.tbl_killstreakdata[ killstreakindex ] ), "<dev string:x61>" + killstreakindex + "<dev string:x6f>" );
            
            if ( isdefined( level.tbl_killstreakdata[ killstreakindex ] ) )
            {
                self.killstreak[ currentkillstreak ] = level.tbl_killstreakdata[ killstreakindex ];
                
                if ( isdefined( level.usingmomentum ) && level.usingmomentum )
                {
                    killstreaktype = killstreaks::get_by_menu_name( self.killstreak[ currentkillstreak ] );
                    
                    if ( isdefined( killstreaktype ) )
                    {
                        weapon = killstreaks::get_killstreak_weapon( killstreaktype );
                        self giveweapon( weapon );
                        
                        if ( isdefined( level.usingscorestreaks ) && level.usingscorestreaks )
                        {
                            if ( weapon.iscarriedkillstreak )
                            {
                                if ( !isdefined( self.pers[ "held_killstreak_ammo_count" ][ weapon ] ) )
                                {
                                    self.pers[ "held_killstreak_ammo_count" ][ weapon ] = 0;
                                }
                                
                                if ( !isdefined( self.pers[ "held_killstreak_clip_count" ][ weapon ] ) )
                                {
                                    self.pers[ "held_killstreak_clip_count" ][ weapon ] = 0;
                                }
                                
                                if ( self.pers[ "held_killstreak_ammo_count" ][ weapon ] > 0 )
                                {
                                    self setweaponammoclip( weapon, self.pers[ "held_killstreak_clip_count" ][ weapon ] );
                                    self setweaponammostock( weapon, self.pers[ "held_killstreak_ammo_count" ][ weapon ] - self.pers[ "held_killstreak_clip_count" ][ weapon ] );
                                }
                                else
                                {
                                    self setweaponammooverall( weapon, 0 );
                                }
                            }
                            else
                            {
                                quantity = self.pers[ "killstreak_quantity" ][ weapon ];
                                
                                if ( !isdefined( quantity ) )
                                {
                                    quantity = 0;
                                }
                                
                                self setweaponammoclip( weapon, quantity );
                            }
                        }
                        
                        sortdata = spawnstruct();
                        sortdata.cost = level.killstreaks[ killstreaktype ].momentumcost;
                        sortdata.weapon = weapon;
                        sortindex = 0;
                        
                        for ( sortindex = 0; sortindex < sortedkillstreaks.size ; sortindex++ )
                        {
                            if ( sortedkillstreaks[ sortindex ].cost > sortdata.cost )
                            {
                                break;
                            }
                        }
                        
                        for ( i = sortedkillstreaks.size; i > sortindex ; i-- )
                        {
                            sortedkillstreaks[ i ] = sortedkillstreaks[ i - 1 ];
                        }
                        
                        sortedkillstreaks[ sortindex ] = sortdata;
                    }
                }
                
                currentkillstreak++;
            }
        }
    }
    
    var_511313e9 = [];
    var_511313e9[ 0 ] = 4;
    var_511313e9[ 1 ] = 2;
    var_511313e9[ 2 ] = 1;
    
    if ( isdefined( level.usingmomentum ) && level.usingmomentum )
    {
        for ( sortindex = 0; sortindex < sortedkillstreaks.size && sortindex < var_511313e9.size ; sortindex++ )
        {
            if ( sortedkillstreaks[ sortindex ].weapon != level.weaponnone )
            {
                self setactionslot( var_511313e9[ sortindex ], "weapon", sortedkillstreaks[ sortindex ].weapon );
            }
        }
    }
}

// Namespace loadout/loadout
// Params 1
// Checksum 0x2e045a11, Offset: 0x31a8
// Size: 0x2a, Type: bool
function function_fc32096( perkname )
{
    return isdefined( perkname ) && isstring( perkname );
}

// Namespace loadout/loadout
// Params 1
// Checksum 0xb267993c, Offset: 0x31e0
// Size: 0x18
function reset_specialty_slots( class_num )
{
    self.specialty = [];
}

// Namespace loadout/loadout
// Params 0
// Checksum 0x28536f7b, Offset: 0x3200
// Size: 0x10
function function_1088c9f()
{
    self.staticweaponsstarttime = gettime();
}

// Namespace loadout/loadout
// Params 1
// Checksum 0x97f34009, Offset: 0x3218
// Size: 0x3e, Type: bool
function function_1c374fc1( equipment_name )
{
    if ( equipment_name == level.weapontacticalinsertion.name && level.disabletacinsert )
    {
        return false;
    }
    
    return true;
}

// Namespace loadout/loadout
// Params 1
// Checksum 0x13d72008, Offset: 0x3260
// Size: 0x36
function function_9afb7ce8( item )
{
    if ( level.leaguematch )
    {
        return isitemrestricted( item );
    }
    
    return 0;
}

// Namespace loadout/loadout
// Params 2
// Checksum 0xafc60a9c, Offset: 0x32a0
// Size: 0x84
function giveloadoutlevelspecific( team, weaponclass )
{
    pixbeginevent( "giveLoadoutLevelSpecific" );
    
    if ( isdefined( level.givecustomcharacters ) )
    {
        self [[ level.givecustomcharacters ]]();
    }
    
    if ( isdefined( level.givecustomloadout ) )
    {
        self [[ level.givecustomloadout ]]();
    }
    
    pixendevent();
}

// Namespace loadout/loadout
// Params 1
// Checksum 0xd6b65c0e, Offset: 0x3330
// Size: 0xaa
function function_79d05183( takeallweapons )
{
    if ( takeallweapons )
    {
        self takeallweapons();
    }
    
    self.specialty = [];
    self.killstreak = [];
    self.var_bf3e36ed = 0;
    self.var_779cc3c1 = 0;
    self.grenadetypeprimary = level.weaponnone;
    self.grenadetypeprimarycount = 0;
    self.grenadetypesecondary = level.weaponnone;
    self.grenadetypesecondarycount = 0;
    self notify( #"give_map" );
}

// Namespace loadout/loadout
// Params 0
// Checksum 0x2502fdfc, Offset: 0x33e8
// Size: 0x28c
function giveperks()
{
    pixbeginevent( "givePerks" );
    self.specialty = self getloadoutperks( self.class_num );
    self setplayerstateloadoutbonuscards( self.class_num );
    self setplayerstateloadoutweapons( self.class_num );
    
    if ( level.leaguematch )
    {
        for ( i = 0; i < self.specialty.size ; i++ )
        {
            if ( function_9afb7ce8( self.specialty[ i ] ) )
            {
                arrayremoveindex( self.specialty, i );
                i--;
            }
        }
    }
    
    if ( level.escalationenabled )
    {
        self.specialty = arraycombine( self.pers[ "lpSystem" ].perks, self.specialty, 0, 0 );
    }
    
    self register_perks();
    anteup_bonus = getdvarint( "perk_killstreakAnteUpResetValue" );
    momentum_at_spawn_or_game_end = isdefined( self.pers[ "momentum_at_spawn_or_game_end" ] ) ? self.pers[ "momentum_at_spawn_or_game_end" ] : 0;
    var_c95a3982 = !( self.hasdonecombat === 1 );
    
    if ( level.ingraceperiod && ( level.inprematchperiod || var_c95a3982 ) && momentum_at_spawn_or_game_end < anteup_bonus )
    {
        new_momentum = self hasperk( "specialty_anteup" ) ? anteup_bonus : momentum_at_spawn_or_game_end;
        globallogic_score::_setplayermomentum( self, new_momentum, 0 );
    }
    
    pixendevent();
}

// Namespace loadout/loadout
// Params 1
// Checksum 0x5eb54ac7, Offset: 0x3680
// Size: 0x1ec
function function_1d84af77( weaponclass )
{
    if ( issubstr( weaponclass, "CLASS_CUSTOM" ) )
    {
        pixbeginevent( "custom class" );
        self.class_num = int( weaponclass[ weaponclass.size - 1 ] ) - 1;
        
        if ( -1 == self.class_num )
        {
            self.class_num = 9;
        }
        
        self.class_num_for_global_weapons = self.class_num;
        self reset_specialty_slots( self.class_num );
        playerrenderoptions = self calcplayeroptions( self.class_num );
        self setplayerrenderoptions( playerrenderoptions );
        pixendevent();
    }
    else
    {
        pixbeginevent( "default class" );
        assert( isdefined( self.pers[ "<dev string:x84>" ] ), "<dev string:x8a>" );
        self.class_num = level.classtoclassnum[ weaponclass ];
        self.class_num_for_global_weapons = 0;
        self setplayerrenderoptions( 0 );
        pixendevent();
    }
    
    self recordloadoutindex( self.class_num );
}

// Namespace loadout/loadout
// Params 0
// Checksum 0xe5fe05b8, Offset: 0x3878
// Size: 0xa4
function function_a6ea9349()
{
    self.spawnweapon = level.weaponbasemeleeheld;
    self giveweapon( level.weaponbasemeleeheld );
    self.pers[ "spawnWeapon" ] = self.spawnweapon;
    switchimmediate = isdefined( self.alreadysetspawnweapononce );
    self setspawnweapon( self.spawnweapon, switchimmediate );
    self.alreadysetspawnweapononce = 1;
}

// Namespace loadout/loadout
// Params 1
// Checksum 0x7ca56f8b, Offset: 0x3928
// Size: 0x6ec
function giveWeapons( var_2da6ff95 )
{
    pixbeginevent( "giveWeapons" );
    spawnweapon = level.weaponnull;
    var_1ddab10 = 0;
    
    if ( isdefined( self.pers[ "weapon" ] ) && self.pers[ "weapon" ] != level.weaponnone && !self.pers[ "weapon" ].iscarriedkillstreak )
    {
        primaryweapon = self.pers[ "weapon" ];
    }
    else
    {
        primaryweapon = self getloadoutweapon( self.class_num, "primary" );
    }
    
    if ( primaryweapon.iscarriedkillstreak )
    {
        primaryweapon = level.weaponnull;
    }
    
    if ( level.escalationenabled )
    {
        var_774e6825 = self getplayerroleitemindexforweapon( "primary", primaryweapon );
        
        if ( var_774e6825 >= 0 )
        {
            primaryweapon = self getescalationweaponforindex( "primary", var_774e6825 );
        }
    }
    
    self.pers[ "primaryWeapon" ] = primaryweapon;
    
    if ( primaryweapon != level.weaponnull )
    {
        primaryweaponoptions = self calcweaponoptions( self.class_num, 0 );
        acvi = self getattachmentcosmeticvariantforweapon( self.class_num, "primary" );
        self giveweapon( primaryweapon, primaryweaponoptions, acvi );
        self weapons::bestweapon_spawn( primaryweapon, primaryweaponoptions, acvi );
        self.primaryloadoutweapon = primaryweapon;
        self.var_367ea154 = primaryweapon.altweapon;
        self.primaryloadoutgunsmithvariantindex = self getloadoutgunsmithvariantindex( self.class_num, 0 );
        
        if ( self hasperk( "specialty_extraammo" ) )
        {
            self givemaxammo( primaryweapon );
        }
        
        spawnweapon = primaryweapon;
        var_1ddab10++;
    }
    
    sidearm = self getloadoutweapon( self.class_num, "secondary" );
    
    if ( level.escalationenabled )
    {
        var_774e6825 = self getplayerroleitemindexforweapon( "secondary", sidearm );
        
        if ( var_774e6825 >= 0 )
        {
            sidearm = self getescalationweaponforindex( "secondary", var_774e6825 );
        }
    }
    
    if ( sidearm.iscarriedkillstreak )
    {
        sidearm = level.weaponnull;
    }
    
    if ( sidearm != level.weaponnull )
    {
        secondaryweaponoptions = self calcweaponoptions( self.class_num, 1 );
        acvi = self getattachmentcosmeticvariantforweapon( self.class_num, "secondary" );
        self giveweapon( sidearm, secondaryweaponoptions, acvi );
        self.secondaryloadoutweapon = sidearm;
        self.var_f8a642e8 = sidearm.altweapon;
        self.secondaryloadoutgunsmithvariantindex = self getloadoutgunsmithvariantindex( self.class_num, 1 );
        
        if ( self hasperk( "specialty_extraammo" ) )
        {
            self givemaxammo( sidearm );
        }
        
        if ( spawnweapon == level.weaponnull )
        {
            spawnweapon = sidearm;
        }
        
        var_1ddab10++;
    }
    
    if ( !self hasmaxprimaryweapons() )
    {
        if ( !isusingt7melee() )
        {
            self giveweapon( level.weaponbasemeleeheld );
        }
        
        if ( var_1ddab10 == 0 )
        {
            spawnweapon = level.weaponbasemeleeheld;
        }
    }
    
    if ( !isdefined( self.spawnweapon ) && isdefined( self.pers[ "spawnWeapon" ] ) )
    {
        self.spawnweapon = self.pers[ "spawnWeapon" ];
    }
    
    if ( isdefined( self.spawnweapon ) && doesweaponreplacespawnweapon( self.spawnweapon, spawnweapon ) && !self.pers[ "changed_class" ] )
    {
        spawnweapon = self.spawnweapon;
    }
    
    self thread initweaponattachments( spawnweapon );
    self.pers[ "changed_class" ] = 0;
    self.spawnweapon = spawnweapon;
    self.pers[ "spawnWeapon" ] = self.spawnweapon;
    switchimmediate = isdefined( self.alreadysetspawnweapononce );
    
    if ( level.escalationenabled && var_2da6ff95 )
    {
        switchimmediate = 1;
    }
    
    self setspawnweapon( spawnweapon, switchimmediate );
    self.alreadysetspawnweapononce = 1;
    self function_1088c9f();
    self bbclasschoice( self.class_num, primaryweapon, sidearm );
    pixendevent();
}

// Namespace loadout/loadout
// Params 0
// Checksum 0x43299e1, Offset: 0x4020
// Size: 0x11c
function function_73fcf154()
{
    has_specialty_armor = self hasperk( "specialty_armor" );
    healthtoassign = self.spawnhealth;
    
    if ( isdefined( level.maxspawnhealthboostprct ) )
    {
        self.bonusspawnhealth = int( level.maxspawnhealthboostprct * self.spawnhealth );
        healthtoassign += self.bonusspawnhealth;
    }
    
    self.maxhealth = healthtoassign;
    self.health = healthtoassign;
    self.maxarmor = has_specialty_armor ? self.spawnarmor : 0;
    self.armor = has_specialty_armor ? self.spawnarmor : 0;
    self healthoverlay::restart_player_health_regen();
}

// Namespace loadout/loadout
// Params 1
// Checksum 0x33dea84e, Offset: 0x4148
// Size: 0x42c
function givePrimaryOffhand( var_991f3e67 )
{
    pixbeginevent( "givePrimaryOffhand" );
    changedclass = self.pers[ "changed_class" ];
    roundbased = !util::isoneround();
    firstround = util::isfirstround();
    primaryoffhand = level.weaponnone;
    primaryoffhandcount = 0;
    
    if ( var_991f3e67 )
    {
        if ( isdefined( self.grenadetypeprimary ) && self.grenadetypeprimary != level.weaponnone )
        {
            self takeweapon( self.grenadetypeprimary );
            self.grenadetypeprimary = level.weaponnone;
            self.grenadetypeprimarycount = 0;
        }
    }
    
    if ( getdvarint( "gadgetEnabled" ) == 1 && getdvarint( "equipmentAsGadgets" ) == 1 )
    {
        primaryoffhand = self getloadoutweapon( self.class_num, "primaryGadget" );
        primaryoffhandcount = primaryoffhand.startammo;
    }
    else
    {
        primaryoffhandname = self getloadoutitemref( self.class_num, "primarygrenade" );
        
        if ( primaryoffhandname != "" && primaryoffhandname != "weapon_null" )
        {
            primaryoffhand = getweapon( primaryoffhandname );
            primaryoffhandcount = self getloadoutitem( self.class_num, "primarygrenadecount" );
        }
        
        if ( level.escalationenabled )
        {
            var_774e6825 = self getplayerroleitemindexforweapon( "primarygrenade", primaryoffhand );
            
            if ( var_774e6825 >= 0 )
            {
                primaryoffhand = self getescalationweaponforindex( "primarygrenade", var_774e6825 );
                primaryoffhandcount = self getescalationweaponcountforindex( "primarygrenade", var_774e6825 );
            }
        }
    }
    
    if ( function_9afb7ce8( primaryoffhand.name ) || !function_1c374fc1( primaryoffhand.name ) )
    {
        primaryoffhand = level.weaponnone;
        primaryoffhandcount = 0;
    }
    
    if ( primaryoffhand == level.weaponnone )
    {
        primaryoffhand = getweapon( "null_offhand_primary" );
        primaryoffhandcount = 0;
    }
    
    if ( primaryoffhand != level.weaponnull )
    {
        self giveweapon( primaryoffhand );
        self setweaponammoclip( primaryoffhand, primaryoffhandcount );
        self switchtooffhand( primaryoffhand );
        self.grenadetypeprimary = primaryoffhand;
        self.grenadetypeprimarycount = primaryoffhandcount;
        
        if ( var_991f3e67 )
        {
            self ability_util::gadget_power_full( primaryoffhand );
        }
        else
        {
            self ability_util::gadget_reset( primaryoffhand, changedclass, roundbased, firstround );
        }
    }
    
    pixendevent();
}

// Namespace loadout/loadout
// Params 2
// Checksum 0xd2a4da64, Offset: 0x4580
// Size: 0x554
function giveSecondaryOffhand( var_991f3e67, force_give_gadget_health_regen )
{
    if ( !isdefined( force_give_gadget_health_regen ) )
    {
        force_give_gadget_health_regen = 1;
    }
    
    pixbeginevent( "giveSecondaryOffhand" );
    changedclass = self.pers[ "changed_class" ];
    roundbased = !util::isoneround();
    firstround = util::isfirstround();
    secondaryoffhand = level.weaponnone;
    secondaryoffhandcount = 0;
    
    if ( var_991f3e67 )
    {
        if ( isdefined( self.grenadetypesecondary ) && self.grenadetypesecondary != level.weaponnone )
        {
            self takeweapon( self.grenadetypesecondary );
            self.grenadetypesecondary = level.weaponnone;
            self.grenadetypesecondarycount = 0;
        }
    }
    
    if ( getdvarint( "gadgetEnabled" ) == 1 && getdvarint( "equipmentAsGadgets" ) == 1 )
    {
        secondaryoffhand = self getloadoutweapon( self.class_num, "secondaryGadget" );
        secondaryoffhandcount = secondaryoffhand.startammo;
    }
    else
    {
        secondaryoffhandname = self getloadoutitemref( self.class_num, "specialgrenade" );
        
        if ( secondaryoffhandname != "" && secondaryoffhandname != "weapon_null" )
        {
            secondaryoffhand = getweapon( secondaryoffhandname );
            secondaryoffhandcount = self getloadoutitem( self.class_num, "specialgrenadecount" );
        }
        
        if ( level.escalationenabled )
        {
            var_774e6825 = self getplayerroleitemindexforweapon( "specialgrenade", secondaryoffhand );
            
            if ( var_774e6825 >= 0 )
            {
                secondaryoffhand = self getescalationweaponforindex( "specialgrenade", var_774e6825 );
                secondaryoffhandcount = self getescalationweaponcountforindex( "specialgrenade", var_774e6825 );
            }
        }
    }
    
    if ( level.escalationenabled && secondaryoffhand == level.weaponnone )
    {
        if ( self.pers[ "lpSystem" ].var_b1a84bfe[ "specialgrenade" ].weapon == level.weaponnone )
        {
            secondaryoffhand = level.weaponnone;
            secondaryoffhandcount = 0;
        }
        else
        {
            secondaryoffhand = self.pers[ "lpSystem" ].var_b1a84bfe[ "specialgrenade" ].weapon;
            secondaryoffhandcount = secondaryoffhand.startammo;
        }
    }
    
    if ( function_9afb7ce8( secondaryoffhand.name ) || !function_1c374fc1( secondaryoffhand.name ) )
    {
        secondaryoffhand = level.weaponnone;
        secondaryoffhandcount = 0;
    }
    
    if ( secondaryoffhand == level.weaponnone )
    {
        secondaryoffhand = getweapon( "null_offhand_secondary" );
        secondaryoffhandcount = 0;
    }
    
    if ( force_give_gadget_health_regen === 1 && level.new_health_model )
    {
        secondaryoffhand = getweapon( "gadget_health_regen" );
        secondaryoffhandcount = 0;
    }
    
    if ( secondaryoffhand != level.weaponnull )
    {
        self giveweapon( secondaryoffhand );
        self setweaponammoclip( secondaryoffhand, secondaryoffhandcount );
        self switchtooffhand( secondaryoffhand );
        self.grenadetypesecondary = secondaryoffhand;
        self.grenadetypesecondarycount = secondaryoffhandcount;
        
        if ( var_991f3e67 )
        {
            self ability_util::gadget_power_full( secondaryoffhand );
        }
        else
        {
            self ability_util::gadget_reset( secondaryoffhand, changedclass, roundbased, firstround );
        }
    }
    
    pixendevent();
}

// Namespace loadout/loadout
// Params 0
// Checksum 0x7308ee7e, Offset: 0x4ae0
// Size: 0x444
function giveSpecialOffhand()
{
    pixbeginevent( "giveSpecialOffhand" );
    changedclass = self.pers[ "changed_class" ];
    roundbased = !util::isoneround();
    firstround = util::isfirstround();
    classnum = self.class_num_for_global_weapons;
    specialoffhand = level.weaponnone;
    specialoffhandcount = 0;
    specialoffhand = self getloadoutweapon( classnum, "herogadget" );
    specialoffhandcount = specialoffhand.startammo;
    
    /#
        if ( getdvarstring( "<dev string:xb8>" ) != "<dev string:xd1>" )
        {
            var_c4697642 = getdvarstring( "<dev string:xb8>" );
            specialoffhand = level.weaponnone;
            
            if ( var_c4697642 != "<dev string:xd2>" )
            {
                specialoffhand = getweapon( var_c4697642 );
            }
        }
    #/
    
    if ( isdefined( self.pers[ #"hash_65987563" ] ) )
    {
        assert( specialoffhand.name == "<dev string:xde>" );
        specialoffhand = self.pers[ #"hash_65987563" ];
        roulette::gadget_roulette_give_earned_specialist( specialoffhand, 0 );
    }
    
    if ( level.escalationenabled )
    {
        if ( self.pers[ "lpSystem" ].var_b1a84bfe[ "herogadget" ].weapon == level.weaponnone )
        {
            specialoffhand = level.weaponnone;
            specialoffhandcount = 0;
        }
        else
        {
            specialoffhand = self.pers[ "lpSystem" ].var_b1a84bfe[ "herogadget" ].weapon;
            specialoffhandcount = specialoffhand.startammo;
        }
    }
    
    if ( function_9afb7ce8( specialoffhand.name ) || !function_1c374fc1( specialoffhand.name ) )
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
        self giveweapon( specialoffhand );
        self setweaponammoclip( specialoffhand, specialoffhandcount );
        self switchtooffhand( specialoffhand );
        self.var_66cb8722 = specialoffhand;
        self.var_877b90bf = specialoffhandcount;
        self ability_util::gadget_reset( specialoffhand, changedclass, roundbased, firstround );
        
        if ( self.fillabilitypoweronspawn === 1 )
        {
            self gadgetpowerset( self gadgetgetslot( specialoffhand ), 100 );
            self.fillabilitypoweronspawn = 0;
        }
    }
    
    pixendevent();
}

// Namespace loadout/loadout
// Params 0
// Checksum 0x1425bbb7, Offset: 0x4f30
// Size: 0x2cc
function giveHeavyWeapon()
{
    pixbeginevent( "giveHeavyWeapon" );
    changedclass = self.pers[ "changed_class" ];
    roundbased = !util::isoneround();
    firstround = util::isfirstround();
    classnum = self.class_num_for_global_weapons;
    heavyweapon = level.weaponnone;
    var_6731f5db = self getloadoutitemref( classnum, "heroweapon" );
    
    /#
        if ( getdvarstring( "<dev string:xee>" ) != "<dev string:xd1>" )
        {
            var_6731f5db = getdvarstring( "<dev string:xee>" );
        }
    #/
    
    if ( var_6731f5db != "" && var_6731f5db != "weapon_null" )
    {
        if ( var_6731f5db == "hero_minigun" )
        {
            model = self getcharacterbodymodel();
            
            if ( isdefined( model ) && issubstr( model, "body3" ) )
            {
                var_6731f5db = "hero_minigun_body3";
            }
        }
        
        heavyweapon = getweapon( var_6731f5db );
    }
    
    if ( level.escalationenabled )
    {
        if ( self.pers[ "lpSystem" ].var_b1a84bfe[ "heroweapon" ].weapon == level.weaponnone )
        {
            heavyweapon = level.weaponnone;
        }
        else
        {
            heavyweapon = self.pers[ "lpSystem" ].var_b1a84bfe[ "heroweapon" ].weapon;
        }
    }
    
    if ( heavyweapon != level.weaponnone )
    {
        self.heavyweapon = heavyweapon;
        self giveweapon( heavyweapon );
        self ability_util::gadget_reset( heavyweapon, changedclass, roundbased, firstround );
    }
    
    pixendevent();
}

// Namespace loadout/loadout
// Params 3
// Checksum 0x149591fd, Offset: 0x5208
// Size: 0x37c
function giveloadout( team, weaponclass, var_991f3e67 )
{
    pixbeginevent( "giveLoadout" );
    pixbeginevent( "giveLoadout 1" );
    
    if ( isdefined( level.inprematchperiod ) && getdvarint( "mp_prototype" ) == 1 && level.inprematchperiod && draft::is_draft_this_round() )
    {
        return;
    }
    
    if ( isdefined( level.givecustomloadout ) )
    {
        spawnweapon = self [[ level.givecustomloadout ]]();
        
        if ( isdefined( spawnweapon ) )
        {
            self thread initweaponattachments( spawnweapon );
        }
        
        self.spawnweapon = spawnweapon;
    }
    else
    {
        self function_79d05183( 1 );
        function_1d84af77( weaponclass );
        self function_672555de();
        self setactionslot( 3, "altMode" );
        self setactionslot( 4, "" );
        allocationspent = self getloadoutallocation( self.class_num );
        overallocation = allocationspent > level.maxallocation;
        
        if ( !overallocation || getdvarint( "mp_prototype" ) == 1 )
        {
            giveperks();
            giveWeapons( var_991f3e67 );
            givePrimaryOffhand( var_991f3e67 );
            function_73fcf154();
        }
        else
        {
            function_a6ea9349();
        }
        
        giveSecondaryOffhand( var_991f3e67 );
        
        if ( getdvarint( "tu11_enableClassicMode" ) == 0 )
        {
            giveSpecialOffhand();
            giveHeavyWeapon();
        }
    }
    
    self teams::set_player_model( undefined, undefined );
    
    if ( isdefined( self.movementspeedmodifier ) )
    {
        self setmovespeedscale( self.movementspeedmodifier * self getmovespeedscale() );
    }
    
    self cac_selector();
    self function_68857c5f( self.spawnweapon, self.pers[ "primaryWeapon" ] );
    pixendevent();
}

// Namespace loadout/loadout
// Params 2
// Checksum 0x4707518e, Offset: 0x5590
// Size: 0xbc
function function_68857c5f( spawnweapon, primaryweapon )
{
    if ( !isdefined( self.firstspawn ) )
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
    
    self.firstspawn = 0;
    self.switchedteamsresetgadgets = 0;
    self flagsys::set( "loadout_given" );
}

// Namespace loadout/loadout
// Params 0
// Checksum 0xd2f8045f, Offset: 0x5658
// Size: 0x2f6
function function_672555de()
{
    if ( !isdefined( self.class_num ) )
    {
        return;
    }
    
    keys = getarraykeys( self.pers[ "lpSystem" ].slots );
    
    for ( i = 0; i < keys.size ; i++ )
    {
        characterindex = self player_role::get();
        var_b19e1153 = self getescalationloadout( self.class_num, characterindex, self.pers[ "lpSystem" ].var_44f5b513[ 5 - i ] );
        
        if ( isdefined( var_b19e1153 ) )
        {
            if ( var_b19e1153.cost == 0 )
            {
                unlockitem = getunlockableiteminfofromindex( var_b19e1153.itemindex );
                
                if ( unlockitem.loadoutslotname == "secondary" )
                {
                    self.pers[ "lpSystem" ].var_b1a84bfe[ "secondary" ].weapon = getweapon( var_b19e1153.ref );
                    self.pers[ "lpSystem" ].var_b1a84bfe[ "secondary" ].slotname = keys[ i ];
                    continue;
                }
                
                if ( unlockitem.loadoutslotname == "specialgrenade" )
                {
                    self.pers[ "lpSystem" ].var_b1a84bfe[ "specialgrenade" ].weapon = getweapon( var_b19e1153.ref );
                    self.pers[ "lpSystem" ].var_b1a84bfe[ "specialgrenade" ].slotname = keys[ i ];
                    self.pers[ "lpSystem" ].slots[ keys[ i ] ].var_8f2ea589 = 2;
                    self clientfield::set_player_uimodel( "hudItems.lplevel." + keys[ i ] + ".level", 2 );
                }
            }
        }
    }
}

// Namespace loadout/loadout
// Params 2
// Checksum 0x2b010518, Offset: 0x5958
// Size: 0xd4
function setweaponammooverall( weapon, amount )
{
    if ( weapon.iscliponly )
    {
        self setweaponammoclip( weapon, amount );
        return;
    }
    
    self setweaponammoclip( weapon, amount );
    diff = amount - self getweaponammoclip( weapon );
    assert( diff >= 0 );
    self setweaponammostock( weapon, diff );
}

// Namespace loadout/loadout
// Params 0
// Checksum 0x93acc310, Offset: 0x5a38
// Size: 0xa0
function on_player_connecting()
{
    if ( !isdefined( self.pers[ "class" ] ) )
    {
        self.pers[ "class" ] = "";
    }
    
    self.curclass = self.pers[ "class" ];
    self.lastclass = "";
    self.detectexplosives = 0;
    self.var_d1c344c9 = [];
    self.var_7d22ed55 = [];
    self.var_6964b90 = [];
    self.var_9f7edcf8 = [];
}

// Namespace loadout/loadout
// Params 2
// Checksum 0xd458e0d, Offset: 0x5ae0
// Size: 0x40
function fadeaway( waitdelay, fadedelay )
{
    wait waitdelay;
    self fadeovertime( fadedelay );
    self.alpha = 0;
}

// Namespace loadout/loadout
// Params 1
// Checksum 0xb06e2628, Offset: 0x5b28
// Size: 0x1c
function setclass( newclass )
{
    self.curclass = newclass;
}

// Namespace loadout/loadout
// Params 0
// Checksum 0x131f788a, Offset: 0x5b50
// Size: 0x100
function initperkdvars()
{
    level.cac_armorpiercing_data = getdvarint( "perk_armorpiercing", 40 ) / 100;
    level.cac_bulletdamage_data = getdvarint( "perk_bulletDamage", 35 );
    level.cac_fireproof_data = getdvarint( "perk_fireproof", 20 );
    level.cac_armorvest_data = getdvarint( "perk_armorVest", 80 );
    level.cac_flakjacket_data = getdvarint( "perk_flakJacket", 35 );
    level.cac_flakjacket_hardcore_data = getdvarint( "perk_flakJacket_hardcore", 9 );
}

// Namespace loadout/loadout
// Params 0
// Checksum 0x45e44bb, Offset: 0x5c58
// Size: 0x9a
function cac_selector()
{
    self.detectexplosives = 0;
    
    if ( isdefined( self.specialty ) )
    {
        perks = self.specialty;
        
        for ( i = 0; i < perks.size ; i++ )
        {
            perk = perks[ i ];
            
            if ( perk == "specialty_detectexplosive" )
            {
                self.detectexplosives = 1;
            }
        }
    }
}

// Namespace loadout/loadout
// Params 0
// Checksum 0xe5745d2e, Offset: 0x5d00
// Size: 0xfc
function register_perks()
{
    perks = self.specialty;
    self clearperks();
    
    for ( i = 0; i < perks.size ; i++ )
    {
        perk = perks[ i ];
        
        if ( perk == "specialty_null" || issubstr( perk, "specialty_weapon_" ) || perk == "weapon_null" )
        {
            continue;
        }
        
        if ( !level.perksenabled )
        {
            continue;
        }
        
        self setperk( perk );
    }
    
    /#
        dev::giveextraperks();
    #/
}

// Namespace loadout/loadout
// Params 7
// Checksum 0x3b94761a, Offset: 0x5e08
// Size: 0x71c
function cac_modified_damage( victim, attacker, damage, mod, weapon, inflictor, hitloc )
{
    assert( isdefined( victim ) );
    assert( isdefined( attacker ) );
    assert( isplayer( victim ) );
    attacker_is_player = isplayer( attacker );
    
    if ( damage <= 0 )
    {
        return damage;
    }
    
    /#
        debug = 0;
        
        if ( getdvarint( "<dev string:x108>" ) )
        {
            debug = 1;
            
            if ( !isdefined( attacker.name ) )
            {
                attacker.name = "<dev string:x116>";
            }
        }
    #/
    
    final_damage = damage;
    
    if ( victim != attacker )
    {
        if ( attacker_is_player && attacker hasperk( "specialty_bulletdamage" ) && isprimarydamage( mod ) )
        {
            if ( victim hasperk( "specialty_armorvest" ) && !function_1b2a8c( hitloc ) )
            {
                /#
                    if ( debug )
                    {
                        println( "<dev string:x11e>" + victim.name + "<dev string:x126>" + attacker.name + "<dev string:x13a>" );
                    }
                #/
            }
            else
            {
                final_damage = damage * ( 100 + level.cac_bulletdamage_data ) / 100;
                
                /#
                    if ( debug )
                    {
                        println( "<dev string:x11e>" + attacker.name + "<dev string:x155>" + victim.name );
                    }
                #/
            }
        }
        else if ( victim hasperk( "specialty_armorvest" ) && isprimarydamage( mod ) && !function_1b2a8c( hitloc ) )
        {
            final_damage = damage * level.cac_armorvest_data * 0.01;
            
            /#
                if ( debug )
                {
                    println( "<dev string:x11e>" + attacker.name + "<dev string:x17b>" + victim.name );
                }
            #/
        }
        else if ( victim hasperk( "specialty_fireproof" ) && isfiredamage( weapon, mod ) )
        {
            final_damage = damage * level.cac_fireproof_data * 0.01;
            
            /#
                if ( debug )
                {
                    println( "<dev string:x11e>" + attacker.name + "<dev string:x1a0>" + victim.name );
                }
            #/
        }
        else if ( victim hasperk( "specialty_flakjacket" ) && weapon_utils::isexplosivedamage( mod ) && !weapon.ignoresflakjacket && !victim grenadestuck( inflictor ) )
        {
            cac_data = level.hardcoremode ? level.cac_flakjacket_hardcore_data : level.cac_flakjacket_data;
            
            if ( victim util::has_flak_jacket_perk_purchased_and_equipped() )
            {
                if ( level.teambased && attacker.team != victim.team )
                {
                    victim thread challenges::flakjacketprotectedmp( weapon, attacker );
                }
                else if ( attacker != victim )
                {
                    victim thread challenges::flakjacketprotectedmp( weapon, attacker );
                }
            }
            
            final_damage = int( damage * cac_data / 100 );
            
            /#
                if ( debug )
                {
                    println( "<dev string:x11e>" + victim.name + "<dev string:x1be>" + attacker.name + "<dev string:x1d8>" );
                }
            #/
        }
    }
    
    /#
        victim.cac_debug_damage_type = tolower( mod );
        victim.cac_debug_original_damage = damage;
        victim.cac_debug_final_damage = final_damage;
        victim.cac_debug_location = tolower( hitloc );
        victim.cac_debug_weapon = tolower( weapon.name );
        victim.cac_debug_range = int( distance( attacker.origin, victim.origin ) );
        
        if ( debug )
        {
            println( "<dev string:x1ea>" + final_damage / damage + "<dev string:x201>" + damage + "<dev string:x211>" + final_damage );
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
// Checksum 0x5c29ea14, Offset: 0x6530
// Size: 0x6a, Type: bool
function function_bb61b344( player )
{
    return player hasperk( "specialty_stunprotection" ) || player hasperk( "specialty_flashprotection" ) || player hasperk( "specialty_proximityprotection" );
}

// Namespace loadout/loadout
// Params 1
// Checksum 0x20b15105, Offset: 0x65a8
// Size: 0x38, Type: bool
function isbulletdamage( meansofdeath )
{
    return meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_HEAD_SHOT";
}

// Namespace loadout/loadout
// Params 3
// Checksum 0xb4fa4d7d, Offset: 0x65e8
// Size: 0x7a, Type: bool
function isfmjdamage( sweapon, smeansofdeath, attacker )
{
    return isdefined( attacker ) && isplayer( attacker ) && attacker hasperk( "specialty_armorpiercing" ) && isdefined( smeansofdeath ) && isbulletdamage( smeansofdeath );
}

// Namespace loadout/loadout
// Params 2
// Checksum 0x3fb718ff, Offset: 0x6670
// Size: 0x60, Type: bool
function isfiredamage( weapon, meansofdeath )
{
    if ( meansofdeath == "MOD_BURNED" || meansofdeath == "MOD_GRENADE" || weapon.doesfiredamage && meansofdeath == "MOD_GRENADE_SPLASH" )
    {
        return true;
    }
    
    return false;
}

// Namespace loadout/loadout
// Params 1
// Checksum 0xe945b85e, Offset: 0x66d8
// Size: 0x38, Type: bool
function function_1b2a8c( hitloc )
{
    return hitloc == "helmet" || hitloc == "head" || hitloc == "neck";
}

// Namespace loadout/loadout
// Params 1
// Checksum 0x5f26030f, Offset: 0x6718
// Size: 0x3a, Type: bool
function grenadestuck( inflictor )
{
    return isdefined( inflictor ) && isdefined( inflictor.stucktoplayer ) && inflictor.stucktoplayer == self;
}

