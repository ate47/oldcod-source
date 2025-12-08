#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/gameobjects_shared;
#using scripts/core_common/killstreaks_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/weapons;
#using scripts/core_common/weapons_shared;
#using scripts/mp_common/challenges;
#using scripts/mp_common/gametypes/globallogic_utils;
#using scripts/mp_common/gametypes/loadout;
#using scripts/mp_common/gametypes/shellshock;
#using scripts/mp_common/gametypes/weapon_utils;
#using scripts/mp_common/gametypes/weaponobjects;
#using scripts/mp_common/killstreaks/dogs;
#using scripts/mp_common/killstreaks/killstreak_weapons;
#using scripts/mp_common/killstreaks/killstreaks;
#using scripts/mp_common/killstreaks/supplydrop;
#using scripts/mp_common/scoreevents;
#using scripts/mp_common/util;

#namespace weapons;

// Namespace weapons/weapons
// Params 0, eflags: 0x2
// Checksum 0x1f7487cb, Offset: 0x418
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "weapons", &__init__, undefined, undefined );
}

// Namespace weapons/weapons
// Params 0
// Checksum 0xa2cbcfdc, Offset: 0x458
// Size: 0x14
function __init__()
{
    init_shared();
}

// Namespace weapons/weapons
// Params 1
// Checksum 0x9862bfb9, Offset: 0x478
// Size: 0xc
function bestweapon_kill( weapon )
{
    
}

// Namespace weapons/weapons
// Params 3
// Checksum 0xb19f0a4c, Offset: 0x490
// Size: 0x1c
function bestweapon_spawn( weapon, options, acvi )
{
    
}

// Namespace weapons/weapons
// Params 3
// Checksum 0xac68de9a, Offset: 0x4b8
// Size: 0xe6
function bestweapon_init( weapon, options, acvi )
{
    weapon_data = [];
    weapon_data[ "weapon" ] = weapon;
    weapon_data[ "options" ] = options;
    weapon_data[ "acvi" ] = acvi;
    weapon_data[ "kill_count" ] = 0;
    weapon_data[ "spawned_with" ] = 0;
    key = self.pers[ "bestWeapon" ][ weapon.name ].size;
    self.pers[ "bestWeapon" ][ weapon.name ][ key ] = weapon_data;
    return key;
}

// Namespace weapons/weapons
// Params 3
// Checksum 0x9864c5a9, Offset: 0x5a8
// Size: 0x192
function bestweapon_find( weapon, options, acvi )
{
    if ( !isdefined( self.pers[ "bestWeapon" ] ) )
    {
        self.pers[ "bestWeapon" ] = [];
    }
    
    if ( !isdefined( self.pers[ "bestWeapon" ][ weapon.name ] ) )
    {
        self.pers[ "bestWeapon" ][ weapon.name ] = [];
    }
    
    name = weapon.name;
    size = self.pers[ "bestWeapon" ][ name ].size;
    
    for ( index = 0; index < size ; index++ )
    {
        if ( self.pers[ "bestWeapon" ][ name ][ index ][ "weapon" ] == weapon && self.pers[ "bestWeapon" ][ name ][ index ][ "options" ] == options && self.pers[ "bestWeapon" ][ name ][ index ][ "acvi" ] == acvi )
        {
            return index;
        }
    }
    
    return undefined;
}

// Namespace weapons/weapons
// Params 0
// Checksum 0x3285fc32, Offset: 0x748
// Size: 0x224
function bestweapon_get()
{
    most_kills = 0;
    most_spawns = 0;
    
    if ( !isdefined( self.pers[ "bestWeapon" ] ) )
    {
        return;
    }
    
    best_key = 0;
    best_index = 0;
    weapon_keys = getarraykeys( self.pers[ "bestWeapon" ] );
    
    for ( key_index = 0; key_index < weapon_keys.size ; key_index++ )
    {
        key = weapon_keys[ key_index ];
        size = self.pers[ "bestWeapon" ][ key ].size;
        
        for ( index = 0; index < size ; index++ )
        {
            kill_count = self.pers[ "bestWeapon" ][ key ][ index ][ "kill_count" ];
            spawned_with = self.pers[ "bestWeapon" ][ key ][ index ][ "spawned_with" ];
            
            if ( kill_count > most_kills )
            {
                best_index = index;
                best_key = key;
                most_kills = kill_count;
                most_spawns = spawned_with;
                continue;
            }
            
            if ( kill_count == most_kills && spawned_with > most_spawns )
            {
                best_index = index;
                best_key = key;
                most_kills = kill_count;
                most_spawns = spawned_with;
            }
        }
    }
    
    return self.pers[ "bestWeapon" ][ best_key ][ best_index ];
}

// Namespace weapons/weapons
// Params 0
// Checksum 0xf5256d76, Offset: 0x978
// Size: 0x38e
function showcaseweapon_get()
{
    showcaseweapondata = self getplayershowcaseweapon();
    
    if ( !isdefined( showcaseweapondata ) )
    {
        return undefined;
    }
    
    showcase_weapon = [];
    showcase_weapon[ "weapon" ] = showcaseweapondata.weapon;
    attachmentnames = [];
    attachmentindices = [];
    tokenizedattachmentinfo = strtok( showcaseweapondata.attachmentinfo, "," );
    index = 0;
    
    while ( index + 1 < tokenizedattachmentinfo.size )
    {
        attachmentnames[ attachmentnames.size ] = tokenizedattachmentinfo[ index ];
        attachmentindices[ attachmentindices.size ] = int( tokenizedattachmentinfo[ index + 1 ] );
        index += 2;
    }
    
    index = tokenizedattachmentinfo.size;
    
    while ( index + 1 < 16 )
    {
        attachmentnames[ attachmentnames.size ] = "none";
        attachmentindices[ attachmentindices.size ] = 0;
        index += 2;
    }
    
    showcase_weapon[ "acvi" ] = getattachmentcosmeticvariantindexes( showcaseweapondata.weapon, attachmentnames[ 0 ], attachmentindices[ 0 ], attachmentnames[ 1 ], attachmentindices[ 1 ], attachmentnames[ 2 ], attachmentindices[ 2 ], attachmentnames[ 3 ], attachmentindices[ 3 ], attachmentnames[ 4 ], attachmentindices[ 4 ], attachmentnames[ 5 ], attachmentindices[ 5 ], attachmentnames[ 6 ], attachmentindices[ 6 ], attachmentnames[ 7 ], attachmentindices[ 7 ] );
    camoindex = 0;
    paintjobslot = 15;
    paintjobindex = 15;
    showpaintshop = 0;
    tokenizedweaponrenderoptions = strtok( showcaseweapondata.weaponrenderoptions, "," );
    
    if ( tokenizedweaponrenderoptions.size > 2 )
    {
        camoindex = int( tokenizedweaponrenderoptions[ 0 ] );
        paintjobslot = int( tokenizedweaponrenderoptions[ 1 ] );
        paintjobindex = int( tokenizedweaponrenderoptions[ 2 ] );
        showpaintshop = paintjobslot != 15 && paintjobindex != 15;
    }
    
    showcase_weapon[ "options" ] = self calcweaponoptions( camoindex, 0, 0, 0, 0, showpaintshop, 1 );
    return showcase_weapon;
}

