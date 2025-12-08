#using scripts\core_common\aat_shared;
#using scripts\core_common\armor;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\item_drop;
#using scripts\core_common\item_inventory;
#using scripts\core_common\item_inventory_util;
#using scripts\core_common\item_world;
#using scripts\core_common\item_world_util;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;

#namespace namespace_efff98ec;

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 0, eflags: 0x6
// Checksum 0x9196f003, Offset: 0xb0
// Size: 0x44
function private autoexec __init__system__()
{
    system::register( #"hash_fd2ea50703c7073", &preinit, undefined, undefined, #"item_world" );
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 0, eflags: 0x4
// Checksum 0x9e6a7100, Offset: 0x100
// Size: 0x2c
function private preinit()
{
    if ( item_inventory::function_7d5553ac() )
    {
        return;
    }
    
    function_116fd9a7();
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 0, eflags: 0x4
// Checksum 0x53275f68, Offset: 0x138
// Size: 0x3f4
function private function_116fd9a7()
{
    item_world::function_861f348d( #"hash_9ed0c30684ca35a", &function_d045e83b );
    item_world::function_861f348d( #"generic_armor_pickup", &function_2e5b5858 );
    item_world::function_861f348d( #"hash_3bfb97e39d67e5f9", &function_cb9b4dd7 );
    item_world::function_861f348d( #"hash_788c59214ead02af", &function_14b2eddf );
    item_world::function_861f348d( #"hash_6247ea34d3b1ddb6", &function_42ffe9b2 );
    item_world::function_861f348d( #"hash_2cbf15cbb314c93e", &function_2eebeff5 );
    item_world::function_861f348d( #"hash_51b30f6e7331e136", &function_349d4c26 );
    item_world::function_861f348d( #"hash_2b4dff2e0db72d06", &function_670cce3f );
    item_world::function_861f348d( #"generic_pickup", &function_41a52251 );
    item_world::function_861f348d( #"hash_5c844f5c1207159c", &function_2b2e9302 );
    item_world::function_861f348d( #"hash_57df81951e3bc37c", &function_7de52ecc );
    item_world::function_861f348d( #"hash_1f0d729dc6dd1202", &function_898628ef );
    item_world::function_861f348d( #"hash_31380667bf69d3a0", &function_a240798a );
    item_world::function_861f348d( #"hash_29f7ad396d214a52", &function_d46c2559 );
    item_world::function_861f348d( #"hash_50375e5de228e9fc", &function_a712496a );
    item_world::function_861f348d( #"hash_ff2bc61e2c18f43", &function_80ef3ea5 );
    item_world::function_861f348d( #"hash_4213c4725d9f115", &function_753fb11f );
    item_world::function_861f348d( #"hash_68c089ceb01f806b", &function_2650d5c6 );
    item_world::function_861f348d( #"hash_3115e37ace8310b1", &function_c3f4d281 );
    item_world::function_861f348d( #"hash_292f5be0001274a4", &function_24dc1d12 );
    item_world::function_861f348d( #"hash_1002a9af0882010e", &function_88803841 );
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 7, eflags: 0x4
// Checksum 0x919f9dbc, Offset: 0x538
// Size: 0x122
function private function_d045e83b( item, player, *networkid, itemid, *itemcount, itemamount, *slot )
{
    if ( itemid.itementry.itemtype !== #"ammo" )
    {
        assertmsg( "<dev string:x38>" + itemid.name + "<dev string:x42>" );
        return 0;
    }
    
    if ( !self item_inventory::can_pickup_ammo( itemid ) )
    {
        return ( isdefined( itemid.itementry.amount ) ? itemid.itementry.amount : isdefined( slot ) ? slot : 1 );
    }
    
    itemcount function_b00db06( 8, itemamount );
    return itemcount item_inventory::equip_ammo( itemid, slot );
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 7, eflags: 0x4
// Checksum 0xb090d2e8, Offset: 0x668
// Size: 0x3f8
function private function_2e5b5858( item, player, *networkid, *itemid, itemcount, itemamount, slotid )
{
    droppeditem = undefined;
    var_3d1f9df4 = 0;
    var_b0938bd7 = undefined;
    var_381f3b39 = 0;
    remainingitems = 0;
    
    if ( networkid.itementry.var_4a1a4613 === #"armor_swap" )
    {
        if ( itemid armor::has_armor() )
        {
            inventoryitem = itemid.inventory.items[ 6 ];
            
            if ( inventoryitem.networkid != 32767 )
            {
                droppeditem = inventoryitem.itementry;
                var_3d1f9df4 = droppeditem.amount;
            }
        }
        
        itemid item_inventory::drop_armor();
        remainingitems = itemid item_inventory::give_inventory_item( networkid, 1, itemamount, slotid );
        
        if ( remainingitems < itemcount )
        {
            if ( isdefined( networkid.networkid ) && item_world_util::function_db35e94f( networkid.networkid ) )
            {
                networkid = item_inventory::get_inventory_item( networkid.networkid );
            }
            
            if ( itemid item_inventory::function_fba4a353( networkid ) )
            {
                itemid item_inventory::equip_armor( networkid );
                var_b0938bd7 = networkid.itementry;
                var_381f3b39 = networkid.itementry.amount;
            }
        }
    }
    else if ( networkid.itementry.var_4a1a4613 === #"armor_heal" )
    {
        noarmor = 1;
        
        if ( itemid.armortier > 0 )
        {
            if ( networkid.itementry.armortier > itemid.armortier )
            {
                inventoryitem = itemid.inventory.items[ 6 ];
                var_4d7e11d8 = itemid item_inventory::drop_inventory_item( inventoryitem.networkid );
                var_4d7e11d8 delete();
                noarmor = 1;
            }
            else
            {
                noarmor = 0;
                
                if ( isdefined( itemid.armor ) && isdefined( itemid.maxarmor ) )
                {
                    inventoryitem = itemid.inventory.items[ 6 ];
                    inventoryitem.amount = itemid.maxarmor;
                    itemid.armor = itemid.maxarmor;
                }
            }
        }
        
        if ( noarmor )
        {
            itemid item_inventory::give_inventory_item( networkid, 1, itemamount, slotid );
            
            if ( isdefined( networkid.networkid ) && item_world_util::function_db35e94f( networkid.networkid ) )
            {
                networkid = item_inventory::get_inventory_item( networkid.networkid );
            }
            
            if ( itemid item_inventory::function_fba4a353( networkid ) )
            {
                itemid item_inventory::equip_armor( networkid );
                var_b0938bd7 = networkid.itementry;
                var_381f3b39 = networkid.itementry.amount;
            }
        }
    }
    
    item_world::function_1a46c8ae( itemid, droppeditem, var_3d1f9df4, var_b0938bd7, var_381f3b39 );
    return remainingitems;
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 7, eflags: 0x4
// Checksum 0x92133186, Offset: 0xa68
// Size: 0x80
function private function_cb9b4dd7( item, player, *networkid, *itemid, itemcount, *itemamount, slotid )
{
    remainingitems = itemcount item_inventory::give_inventory_item( itemid, itemamount, undefined, slotid );
    itemcount item_inventory::function_3d113bfb();
    return remainingitems;
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 7, eflags: 0x4
// Checksum 0xd72ad875, Offset: 0xaf0
// Size: 0x168
function private function_14b2eddf( item, player, *networkid, *itemid, itemcount, *itemamount, slotid )
{
    var_f0dc4e93 = itemcount item_inventory::function_ec087745();
    weaponslotid = undefined;
    
    if ( isdefined( var_f0dc4e93 ) && var_f0dc4e93 != 32767 )
    {
        weaponslotid = itemcount item_inventory::function_b246c573( var_f0dc4e93 );
    }
    
    remainingitems = itemcount item_inventory::give_inventory_item( itemid, itemamount, undefined, slotid );
    
    if ( isdefined( weaponslotid ) && isdefined( slotid ) && item_inventory_util::function_398b9770( weaponslotid, slotid ) )
    {
        if ( isdefined( itemid.networkid ) && item_world_util::function_db35e94f( itemid.networkid ) )
        {
            itemid = item_inventory::get_inventory_item( itemid.networkid );
        }
        
        itemcount item_inventory::equip_attachment( itemid, var_f0dc4e93, undefined, 0 );
    }
    
    return remainingitems;
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 7, eflags: 0x4
// Checksum 0x33a9d05c, Offset: 0xc60
// Size: 0x108
function private function_42ffe9b2( item, player, *networkid, *itemid, itemcount, *itemamount, slotid )
{
    if ( itemcount item_inventory::function_fba4a353( itemid ) )
    {
        slotid = 8;
    }
    
    remainingitems = itemcount item_inventory::give_inventory_item( itemid, itemamount, undefined, slotid );
    
    if ( remainingitems < itemamount && slotid === 8 )
    {
        if ( isdefined( itemid.networkid ) && item_world_util::function_db35e94f( itemid.networkid ) )
        {
            itemid = item_inventory::get_inventory_item( itemid.networkid );
        }
        
        itemcount item_inventory::equip_backpack( itemid );
    }
    
    return remainingitems;
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 7, eflags: 0x4
// Checksum 0xd2c95290, Offset: 0xd70
// Size: 0xe8
function private function_2eebeff5( item, player, *networkid, *itemid, itemcount, itemamount, slotid )
{
    remainingitems = itemid item_inventory::give_inventory_item( networkid, itemcount, itemamount, slotid );
    
    if ( remainingitems < itemcount )
    {
        if ( isdefined( networkid.networkid ) && item_world_util::function_db35e94f( networkid.networkid ) )
        {
            networkid = item_inventory::get_inventory_item( networkid.networkid );
        }
        
        if ( itemid item_inventory::function_fba4a353( networkid ) )
        {
            itemid thread item_inventory::equip_equipment( networkid );
        }
    }
    
    return remainingitems;
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 7, eflags: 0x4
// Checksum 0x75fb8a94, Offset: 0xe60
// Size: 0xe8
function private function_349d4c26( item, player, *networkid, *itemid, itemcount, *itemamount, slotid )
{
    remainingitems = itemcount item_inventory::give_inventory_item( itemid, itemamount, undefined, slotid );
    
    if ( remainingitems < itemamount )
    {
        if ( isdefined( itemid.networkid ) && item_world_util::function_db35e94f( itemid.networkid ) )
        {
            itemid = item_inventory::get_inventory_item( itemid.networkid );
        }
        
        if ( itemcount item_inventory::function_fba4a353( itemid ) )
        {
            itemcount thread item_inventory::equip_health( itemid );
        }
    }
    
    return remainingitems;
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 7, eflags: 0x4
// Checksum 0x844fff58, Offset: 0xf50
// Size: 0x6a
function private function_670cce3f( item, player, *networkid, *itemid, itemcount, *itemamount, slotid )
{
    remainingitems = itemcount item_inventory::give_inventory_item( itemid, itemamount, undefined, slotid );
    return remainingitems;
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 7, eflags: 0x4
// Checksum 0x4b8c83e6, Offset: 0xfc8
// Size: 0x6a
function private function_41a52251( item, player, *networkid, *itemid, itemcount, *itemamount, slotid )
{
    remainingitems = itemcount item_inventory::give_inventory_item( itemid, itemamount, undefined, slotid );
    return remainingitems;
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 7, eflags: 0x4
// Checksum 0xea4b3dae, Offset: 0x1040
// Size: 0x90
function private function_2b2e9302( item, player, *networkid, *itemid, itemcount, *itemamount, slotid )
{
    remainingitems = itemcount item_inventory::give_inventory_item( itemid, itemamount, undefined, slotid );
    itemcount callback::callback( #"hash_3b891b6daa75c782", itemid );
    return remainingitems;
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 7, eflags: 0x4
// Checksum 0x97614db3, Offset: 0x10d8
// Size: 0xe8
function private function_7de52ecc( item, player, *networkid, *itemid, itemcount, itemamount, slotid )
{
    remainingitems = itemid item_inventory::give_inventory_item( networkid, itemcount, itemamount, slotid );
    
    if ( remainingitems < itemcount )
    {
        if ( isdefined( networkid.networkid ) && item_world_util::function_db35e94f( networkid.networkid ) )
        {
            networkid = item_inventory::get_inventory_item( networkid.networkid );
        }
        
        if ( itemid item_inventory::function_fba4a353( networkid ) )
        {
            itemid thread item_inventory::function_854cf2c3( networkid );
        }
    }
    
    return remainingitems;
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 7, eflags: 0x4
// Checksum 0xc52bb94a, Offset: 0x11c8
// Size: 0x100
function private function_898628ef( item, player, *networkid, *itemid, itemcount, itemamount, slotid )
{
    remainingitems = itemid item_inventory::give_inventory_item( networkid, itemcount, itemamount, slotid );
    stockammo = networkid.stockammo;
    
    if ( remainingitems < itemcount )
    {
        if ( isdefined( networkid.networkid ) && item_world_util::function_db35e94f( networkid.networkid ) )
        {
            networkid = item_inventory::get_inventory_item( networkid.networkid );
        }
        
        if ( itemid item_inventory::function_fba4a353( networkid ) )
        {
            itemid thread item_inventory::function_1ac37022( networkid, stockammo );
        }
    }
    
    return remainingitems;
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 7, eflags: 0x4
// Checksum 0xd94e484d, Offset: 0x12d0
// Size: 0x6a
function private function_a240798a( item, player, *networkid, *itemid, itemcount, *itemamount, slotid )
{
    remainingitems = itemcount item_inventory::give_inventory_item( itemid, itemamount, undefined, slotid );
    return remainingitems;
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 7, eflags: 0x4
// Checksum 0x23183bf, Offset: 0x1348
// Size: 0x3e, Type: bool
function private function_24dc1d12( *item, *player, *networkid, *itemid, *itemcount, *itemamount, *slotid )
{
    return false;
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 7, eflags: 0x4
// Checksum 0x825fcc66, Offset: 0x1390
// Size: 0x306, Type: bool
function private function_c3f4d281( item, *player, *networkid, *itemid, *itemcount, *itemamount, *slotid )
{
    nullweapon = getweapon( #"none" );
    var_f945fa92 = getweapon( #"bare_hands" );
    primaryweapon = self item_inventory_util::function_2b83d3ff( self item_inventory::function_2e711614( 17 + 1 ) );
    
    if ( isdefined( primaryweapon ) && primaryweapon != nullweapon && primaryweapon != var_f945fa92 )
    {
        ammoamount = isdefined( slotid.itementry.amount ) ? slotid.itementry.amount : 20;
        maxammo = primaryweapon.maxammo;
        var_e6527384 = maxammo * ammoamount / 100;
        currentammostock = self getweaponammostock( primaryweapon );
        var_e6527384 = currentammostock + var_e6527384;
        
        if ( var_e6527384 < 0 )
        {
            var_e6527384 = 0;
        }
        else if ( var_e6527384 > maxammo )
        {
            var_e6527384 = maxammo;
        }
        
        self setweaponammostock( primaryweapon, int( var_e6527384 ) );
    }
    
    var_824ff7c7 = self item_inventory_util::function_2b83d3ff( self item_inventory::function_2e711614( 17 + 1 + 8 + 1 ) );
    
    if ( isdefined( var_824ff7c7 ) && var_824ff7c7 != nullweapon && var_824ff7c7 != var_f945fa92 )
    {
        ammoamount = isdefined( slotid.itementry.amount ) ? slotid.itementry.amount : 20;
        maxammo = var_824ff7c7.maxammo;
        var_e6527384 = maxammo * ammoamount / 100;
        var_22baab7c = self getweaponammostock( var_824ff7c7 );
        var_e6527384 = var_22baab7c + var_e6527384;
        
        if ( var_e6527384 < 0 )
        {
            var_e6527384 = 0;
        }
        else if ( var_e6527384 > maxammo )
        {
            var_e6527384 = maxammo;
        }
        
        self setweaponammostock( var_824ff7c7, int( var_e6527384 ) );
    }
    
    return false;
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 7, eflags: 0x4
// Checksum 0xdc04fcdc, Offset: 0x16a0
// Size: 0x3e, Type: bool
function private function_80ef3ea5( *item, *player, *networkid, *itemid, *itemcount, *itemamount, *slotid )
{
    return false;
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 7, eflags: 0x4
// Checksum 0xbf3c80bd, Offset: 0x16e8
// Size: 0x3e, Type: bool
function private function_753fb11f( *item, *player, *networkid, *itemid, *itemcount, *itemamount, *slotid )
{
    return false;
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 7, eflags: 0x4
// Checksum 0x42ad90dd, Offset: 0x1730
// Size: 0x3e, Type: bool
function private function_88803841( *item, *player, *networkid, *itemid, *itemcount, *itemamount, *slotid )
{
    return false;
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 7, eflags: 0x4
// Checksum 0xa51e89d0, Offset: 0x1778
// Size: 0x56, Type: bool
function private function_d46c2559( item, *player, *networkid, *itemid, *itemcount, *itemamount, *slotid )
{
    item_drop::function_d8342646( slotid.var_25b21f27 );
    return false;
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 7, eflags: 0x4
// Checksum 0x5ba8e2ae, Offset: 0x17d8
// Size: 0x130, Type: bool
function private function_2650d5c6( *item, player, *networkid, *itemid, *itemcount, *itemamount, *slotid )
{
    var_2cacdde7 = 50;
    inventoryitem = slotid.inventory.items[ 6 ];
    
    if ( isdefined( inventoryitem ) )
    {
        var_2cacdde7 = isdefined( inventoryitem.itementry.var_a3aa1ca2 ) ? inventoryitem.itementry.var_a3aa1ca2 : 50;
        
        if ( isdefined( level.var_8cc294a7 ) )
        {
            var_2cacdde7 = [[ level.var_8cc294a7 ]]( var_2cacdde7 );
        }
        
        if ( var_2cacdde7 == 0 )
        {
            var_2cacdde7 = 50;
        }
    }
    
    var_2cacdde7 = int( var_2cacdde7 );
    self.armor += math::clamp( var_2cacdde7, 0, self.maxarmor );
    return false;
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 7, eflags: 0x4
// Checksum 0xaa70d00d, Offset: 0x1910
// Size: 0x3a0
function private function_a712496a( item, player, *networkid, *itemid, itemcount, itemamount, slotid )
{
    assert( isplayer( self ) );
    stockammo = networkid.stockammo;
    
    if ( isdefined( networkid.weaponoverride ) )
    {
        foreach ( attachment in networkid.weaponoverride.attachments )
        {
            attachmentname = item_world_util::function_6a0ee21a( attachment );
            
            if ( !isdefined( attachmentname ) )
            {
                continue;
            }
            
            attachmentitem = item_world_util::function_49ce7663( attachmentname );
            
            if ( !isdefined( attachmentitem ) )
            {
                continue;
            }
            
            item_inventory_util::function_9e9c82a6( networkid, attachmentitem );
        }
    }
    
    if ( item_inventory::get_weapon_count() == 2 )
    {
        stashitem = item_world_util::function_83c20f83( networkid );
        stashitem &= ~( isdefined( networkid.deathstash ) ? networkid.deathstash : 0 );
        weaponitem = item_inventory::function_230ceec4( itemid.currentweapon );
        
        if ( !isdefined( weaponitem ) )
        {
            itemid takeweapon( itemid.currentweapon );
        }
        else
        {
            itemid thread item_inventory::drop_inventory_item( weaponitem.networkid, stashitem, itemid.origin, isdefined( networkid.targetnamehash ) ? networkid.targetnamehash : networkid.targetname );
        }
    }
    
    remainingitems = itemid item_inventory::give_inventory_item( networkid, itemcount, itemamount, slotid );
    
    if ( remainingitems < itemcount )
    {
        if ( isdefined( networkid.networkid ) && item_world_util::function_db35e94f( networkid.networkid ) )
        {
            networkid = item_inventory::get_inventory_item( networkid.networkid );
        }
        
        if ( isdefined( networkid.itementry.ammomodname ) )
        {
            itemid item_inventory::function_b579540e( networkid, networkid.itementry.ammomodname );
            weapon = item_inventory_util::function_2b83d3ff( networkid );
            itemid aat::acquire( weapon, networkid.itementry.ammomodname );
        }
        
        itemid item_inventory::equip_weapon( networkid, 1, 1, 0, 1, stockammo );
    }
    
    return remainingitems;
}

