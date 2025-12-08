#using script_101d8280497ff416;
#using script_1e30f5109f6bf48c;
#using script_37560a24283a601;
#using script_68ae4d25b2c90f7d;
#using script_7b5224fe73522c;
#using script_7c727635e50af640;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\item_drop;
#using scripts\core_common\item_inventory;
#using scripts\core_common\item_inventory_util;
#using scripts\core_common\item_world;
#using scripts\core_common\item_world_util;
#using scripts\core_common\system_shared;

#namespace namespace_1b527536;

// Namespace namespace_1b527536/namespace_1b527536
// Params 0, eflags: 0x6
// Checksum 0x4c2d3dee, Offset: 0x140
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"hash_13a43d760497b54d", &preinit, undefined, undefined, undefined );
}

// Namespace namespace_1b527536/namespace_1b527536
// Params 0, eflags: 0x4
// Checksum 0x1d8bb0f4, Offset: 0x188
// Size: 0x2fc
function private preinit()
{
    level.var_9bff3a72 = getgametypesetting( #"hash_7dedd27bf994a9a9" );
    
    if ( !is_true( level.var_9bff3a72 ) )
    {
        return;
    }
    
    level.var_1b527536 = array( #"frost_blast", #"frost_blast_1", #"frost_blast_2", #"frost_blast_3", #"frost_blast_4", #"frost_blast_5", #"heal_aoe", #"heal_aoe_1", #"heal_aoe_2", #"heal_aoe_3", #"heal_aoe_4", #"heal_aoe_5", #"energy_mine", #"energy_mine_1", #"energy_mine_2", #"energy_mine_3", #"energy_mine_4", #"energy_mine_5", #"aether_shroud", #"aether_shroud_1", #"aether_shroud_2", #"aether_shroud_3", #"aether_shroud_4", #"aether_shroud_5", #"ring_of_fire", #"ring_of_fire_1", #"ring_of_fire_2", #"ring_of_fire_3", #"ring_of_fire_4", #"ring_of_fire_5" );
    clientfield::register_clientuimodel( "hud_items.ammoCooldowns.fieldUpgrade", #"hud_items", [ #"hash_2f126bd99a74de8b", #"fieldupgrade" ], 1, 5, "float", undefined, 0, 0 );
    clientfield::register( "toplayer", "field_upgrade_selected", 1, 5, "int", &function_473fedfd, 0, 0 );
}

// Namespace namespace_1b527536/namespace_1b527536
// Params 7
// Checksum 0x97770f81, Offset: 0x490
// Size: 0x10c
function function_473fedfd( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    var_64774ae3 = undefined;
    
    if ( bwastimejump > 0 )
    {
        var_64774ae3 = level.var_1b527536[ bwastimejump - 1 ];
    }
    
    if ( !isdefined( var_64774ae3 ) )
    {
        var_64774ae3 = #"";
    }
    
    model = function_1df4c3b0( fieldname, #"zm_field_upgrade_loadout" );
    setuimodelvalue( getuimodel( model, "count" ), 0 );
    setuimodelvalue( getuimodel( model, "id" ), var_64774ae3 );
}

