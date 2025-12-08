#using script_2467fe25132955b8;
#using script_27610ca25737f68d;
#using script_340a2e805e35f7a2;
#using script_3751b21462a54a7d;
#using script_421ca110b4204518;
#using script_44c2a1259e14bef1;
#using script_58860a35d0555f74;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\item_drop;
#using scripts\core_common\item_inventory;
#using scripts\core_common\item_inventory_util;
#using scripts\core_common\item_world;
#using scripts\core_common\item_world_util;
#using scripts\core_common\rank_shared;
#using scripts\core_common\system_shared;

#namespace namespace_1b527536;

// Namespace namespace_1b527536/namespace_1b527536
// Params 0, eflags: 0x6
// Checksum 0x3c3d0188, Offset: 0x420
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"hash_13a43d760497b54d", &preinit, undefined, undefined, undefined );
}

// Namespace namespace_1b527536/namespace_1b527536
// Params 0, eflags: 0x4
// Checksum 0xea36fc4e, Offset: 0x468
// Size: 0x344
function private preinit()
{
    level.var_9bff3a72 = getgametypesetting( #"hash_7dedd27bf994a9a9" );
    
    if ( !is_true( level.var_9bff3a72 ) )
    {
        return;
    }
    
    level.var_dbd3b871 = [];
    level.var_bfc892f2 = [];
    level.var_fee98522 = [];
    level.var_5b46d961 = [];
    level.var_197c8eb1 = 0;
    level.var_1b527536 = array( #"frost_blast", #"frost_blast_1", #"frost_blast_2", #"frost_blast_3", #"frost_blast_4", #"frost_blast_5", #"heal_aoe", #"heal_aoe_1", #"heal_aoe_2", #"heal_aoe_3", #"heal_aoe_4", #"heal_aoe_5", #"energy_mine", #"energy_mine_1", #"energy_mine_2", #"energy_mine_3", #"energy_mine_4", #"energy_mine_5", #"aether_shroud", #"aether_shroud_1", #"aether_shroud_2", #"aether_shroud_3", #"aether_shroud_4", #"aether_shroud_5", #"ring_of_fire", #"ring_of_fire_1", #"ring_of_fire_2", #"ring_of_fire_3", #"ring_of_fire_4", #"ring_of_fire_5" );
    clientfield::register_clientuimodel( "hud_items.ammoCooldowns.fieldUpgrade", 1, 5, "float" );
    clientfield::register( "toplayer", "field_upgrade_selected", 1, 5, "int" );
    callback::on_spawned( &function_1505f5d4 );
    callback::on_ai_killed( &function_f832427c );
    level thread function_a7ad7cd5();
    
    /#
        level.var_f793af68 = &function_f793af68;
    #/
}

// Namespace namespace_1b527536/namespace_1b527536
// Params 2
// Checksum 0x29ba85ef, Offset: 0x7b8
// Size: 0x24
function function_dbd391bf( weaponname, func )
{
    level.var_dbd3b871[ weaponname ] = func;
}

// Namespace namespace_1b527536/namespace_1b527536
// Params 4
// Checksum 0x37a783b2, Offset: 0x7e8
// Size: 0x54
function function_36e0540e( weaponname, maxammo, killcount, itemname )
{
    level.var_bfc892f2[ weaponname ] = maxammo;
    level.var_fee98522[ weaponname ] = killcount;
    level.var_5b46d961[ weaponname ] = itemname;
}

// Namespace namespace_1b527536/namespace_1b527536
// Params 0
// Checksum 0xff8b02c4, Offset: 0x848
// Size: 0x2c
function function_460882e2()
{
    self.var_8da24ed0 = 0;
    self clientfield::set_player_uimodel( "hud_items.ammoCooldowns.fieldUpgrade", 0 );
}

// Namespace namespace_1b527536/namespace_1b527536
// Params 2
// Checksum 0x8efe214f, Offset: 0x880
// Size: 0x422
function function_13ca014f( var_d07d57b2, tier )
{
    frost_blast = [ #"field_upgrade_frost_blast_item_sr", #"field_upgrade_frost_blast_1_item_sr", #"field_upgrade_frost_blast_2_item_sr", #"field_upgrade_frost_blast_3_item_sr", #"field_upgrade_frost_blast_4_item_sr", #"field_upgrade_frost_blast_5_item_sr" ];
    heal_aoe = [ #"field_upgrade_heal_aoe_item_sr", #"field_upgrade_heal_aoe_1_item_sr", #"field_upgrade_heal_aoe_2_item_sr", #"field_upgrade_heal_aoe_3_item_sr", #"field_upgrade_heal_aoe_4_item_sr", #"field_upgrade_heal_aoe_5_item_sr" ];
    var_23662c1b = [ "field_upgrade_ring_of_fire_item_sr", "field_upgrade_ring_of_fire_1_item_sr", "field_upgrade_ring_of_fire_2_item_sr", "field_upgrade_ring_of_fire_3_item_sr", "field_upgrade_ring_of_fire_4_item_sr", "field_upgrade_ring_of_fire_5_item_sr" ];
    energy_mine = [ "field_upgrade_energy_mine_item_sr", "field_upgrade_energy_mine_1_item_sr", "field_upgrade_energy_mine_2_item_sr", "field_upgrade_energy_mine_3_item_sr", "field_upgrade_energy_mine_4_item_sr", "field_upgrade_energy_mine_5_item_sr" ];
    var_6c90b7f6 = [ "field_upgrade_aether_shroud_item_sr", "field_upgrade_aether_shroud_1_item_sr", "field_upgrade_aether_shroud_2_item_sr", "field_upgrade_aether_shroud_3_item_sr", "field_upgrade_aether_shroud_4_item_sr", "field_upgrade_aether_shroud_5_item_sr" ];
    
    switch ( var_d07d57b2 )
    {
        case #"frost_blast":
        case #"frost_blast_1":
        case #"frost_blast_3":
        case #"frost_blast_2":
        case #"frost_blast_5":
        case #"frost_blast_4":
            return frost_blast[ tier ];
        case #"heal_aoe_1":
        case #"heal_aoe_2":
        case #"heal_aoe_3":
        case #"heal_aoe_4":
        case #"heal_aoe_5":
        case #"heal_aoe":
            return heal_aoe[ tier ];
        case #"ring_of_fire_5":
        case #"ring_of_fire_4":
        case #"ring_of_fire_3":
        case #"ring_of_fire_2":
        case #"ring_of_fire_1":
        case #"ring_of_fire":
            return var_23662c1b[ tier ];
        case #"energy_mine":
        case #"energy_mine_4":
        case #"energy_mine_5":
        case #"energy_mine_2":
        case #"energy_mine_3":
        case #"energy_mine_1":
            return energy_mine[ tier ];
        case #"aether_shroud_1":
        case #"aether_shroud_3":
        case #"aether_shroud_2":
        case #"aether_shroud_5":
        case #"aether_shroud_4":
        case #"aether_shroud":
            return var_6c90b7f6[ tier ];
    }
}

// Namespace namespace_1b527536/namespace_1b527536
// Params 0, eflags: 0x4
// Checksum 0xb9163582, Offset: 0xcb0
// Size: 0x1b0
function private function_3ef3cec3()
{
    var_d07d57b2 = self function_b958b70d( self.class_num, "specialgrenade" );
    
    if ( var_d07d57b2 == #"" || var_d07d57b2 == #"weapon_null" )
    {
        var_d07d57b2 = level.var_1b527536[ 0 ];
    }
    
    self.var_c9448182 = level.var_bfc892f2[ var_d07d57b2 ];
    self.var_fc8023b4 = level.var_fee98522[ var_d07d57b2 ];
    self.var_87f72f8 = level.var_5b46d961[ var_d07d57b2 ];
    var_8c590502 = isdefined( getgametypesetting( #"hash_3c2c78e639bfd3c6" ) ) ? getgametypesetting( #"hash_3c2c78e639bfd3c6" ) : 0;
    
    if ( var_8c590502 > 0 )
    {
        self.var_87f72f8 = function_13ca014f( var_d07d57b2, var_8c590502 );
    }
    
    for ( i = 0; i < level.var_1b527536.size ; i++ )
    {
        if ( level.var_1b527536[ i ] == var_d07d57b2 )
        {
            self clientfield::set_to_player( "field_upgrade_selected", i + 1 );
            break;
        }
    }
}

// Namespace namespace_1b527536/namespace_1b527536
// Params 1, eflags: 0x4
// Checksum 0xc33994ed, Offset: 0xe68
// Size: 0x3a
function private function_7fb7c83c( weaponname )
{
    inarray = isinarray( level.var_1b527536, weaponname );
    return inarray;
}

// Namespace namespace_1b527536/namespace_1b527536
// Params 0, eflags: 0x4
// Checksum 0xbe2d40dc, Offset: 0xeb0
// Size: 0x24
function private function_1505f5d4()
{
    self.var_8da24ed0 = 0;
    self function_3ef3cec3();
}

// Namespace namespace_1b527536/grenade_fire
// Params 1, eflags: 0x44
// Checksum 0xb1199ce3, Offset: 0xee0
// Size: 0xae
function private event_handler[grenade_fire] function_4776caf4( eventstruct )
{
    if ( !is_true( level.var_9bff3a72 ) )
    {
        return;
    }
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( function_7fb7c83c( eventstruct.weapon.name ) && isdefined( level.var_dbd3b871[ eventstruct.weapon.name ] ) )
    {
        self thread [[ level.var_dbd3b871[ eventstruct.weapon.name ] ]]( eventstruct );
    }
}

// Namespace namespace_1b527536/player_loadoutchanged
// Params 1, eflags: 0x44
// Checksum 0xd6cce58e, Offset: 0xf98
// Size: 0x3c
function private event_handler[player_loadoutchanged] function_688d2014( *eventstruct )
{
    if ( !is_true( level.var_9bff3a72 ) )
    {
        return;
    }
    
    self function_3ef3cec3();
}

// Namespace namespace_1b527536/namespace_1b527536
// Params 1, eflags: 0x4
// Checksum 0xe4bbf09b, Offset: 0xfe0
// Size: 0x8c
function private function_f832427c( s_params )
{
    e_player = s_params.eattacker;
    
    if ( !isplayer( e_player ) )
    {
        return;
    }
    
    e_player.var_8da24ed0 += 1;
    progress = e_player.var_8da24ed0 / e_player.var_fc8023b4;
    e_player clientfield::set_player_uimodel( "hud_items.ammoCooldowns.fieldUpgrade", progress );
}

// Namespace namespace_1b527536/namespace_1b527536
// Params 1
// Checksum 0x8e6d7bc7, Offset: 0x1078
// Size: 0xd4
function function_6457e4cd( item_name )
{
    if ( !isdefined( item_name ) || item_name == #"" )
    {
        return;
    }
    
    item = function_4ba8fde( item_name );
    var_fa3df96 = self item_inventory::function_e66dcff5( item );
    
    if ( isdefined( var_fa3df96 ) )
    {
        if ( !item_world_util::function_db35e94f( item.networkid ) )
        {
            item.networkid = item_world_util::function_970b8d86( var_fa3df96 );
        }
        
        self item_world::function_de2018e3( item, self, var_fa3df96 );
    }
}

// Namespace namespace_1b527536/namespace_1b527536
// Params 0, eflags: 0x4
// Checksum 0x7585222f, Offset: 0x1158
// Size: 0x242
function private function_a7ad7cd5()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        foreach ( player in getplayers() )
        {
            if ( isalive( player ) && isdefined( player.var_8da24ed0 ) && isdefined( player.inventory ) && isdefined( player.var_fc8023b4 ) )
            {
                var_7df0eb27 = player.var_fc8023b4;
                
                if ( player namespace_791d0451::function_56cedda7( #"hash_520b5cb0216b75d7" ) || player namespace_791d0451::function_56cedda7( #"hash_520b5bb0216b7424" ) || player namespace_791d0451::function_56cedda7( #"hash_520b5ab0216b7271" ) || player namespace_791d0451::function_56cedda7( #"hash_520b59b0216b70be" ) )
                {
                    var_7df0eb27 = int( var_7df0eb27 * 0.2 );
                }
                
                if ( player.var_8da24ed0 >= var_7df0eb27 && player.inventory.items[ 12 ].networkid == 32767 )
                {
                    for ( numitems = 0; numitems < player.var_c9448182 ; numitems++ )
                    {
                        player function_6457e4cd( player.var_87f72f8 );
                    }
                    
                    level.var_197c8eb1 = 1;
                }
            }
        }
        
        waitframe( 1 );
    }
}

/#

    // Namespace namespace_1b527536/namespace_1b527536
    // Params 0
    // Checksum 0xde11a46a, Offset: 0x13a8
    // Size: 0x764, Type: dev
    function function_f793af68()
    {
        level endon( #"game_ended" );
        setdvar( #"hash_6ace867d48136ede", "<dev string:x38>" );
        adddebugcommand( "<dev string:x3c>" + function_9e72a96( #"field_upgrade_frost_blast_item_sr" ) + "<dev string:x9d>" );
        adddebugcommand( "<dev string:xa2>" + function_9e72a96( #"field_upgrade_frost_blast_1_item_sr" ) + "<dev string:x9d>" );
        adddebugcommand( "<dev string:x103>" + function_9e72a96( #"field_upgrade_frost_blast_2_item_sr" ) + "<dev string:x9d>" );
        adddebugcommand( "<dev string:x160>" + function_9e72a96( #"field_upgrade_frost_blast_3_item_sr" ) + "<dev string:x9d>" );
        adddebugcommand( "<dev string:x1bd>" + function_9e72a96( #"field_upgrade_frost_blast_4_item_sr" ) + "<dev string:x9d>" );
        adddebugcommand( "<dev string:x21a>" + function_9e72a96( #"field_upgrade_frost_blast_5_item_sr" ) + "<dev string:x9d>" );
        adddebugcommand( "<dev string:x277>" + function_9e72a96( #"field_upgrade_heal_aoe_item_sr" ) + "<dev string:x9d>" );
        adddebugcommand( "<dev string:x2d9>" + function_9e72a96( #"field_upgrade_heal_aoe_1_item_sr" ) + "<dev string:x9d>" );
        adddebugcommand( "<dev string:x33b>" + function_9e72a96( #"field_upgrade_heal_aoe_2_item_sr" ) + "<dev string:x9d>" );
        adddebugcommand( "<dev string:x399>" + function_9e72a96( #"field_upgrade_heal_aoe_3_item_sr" ) + "<dev string:x9d>" );
        adddebugcommand( "<dev string:x3f7>" + function_9e72a96( #"field_upgrade_heal_aoe_4_item_sr" ) + "<dev string:x9d>" );
        adddebugcommand( "<dev string:x455>" + function_9e72a96( #"field_upgrade_heal_aoe_5_item_sr" ) + "<dev string:x9d>" );
        adddebugcommand( "<dev string:x4b3>" + function_9e72a96( "<dev string:x514>" ) + "<dev string:x9d>" );
        adddebugcommand( "<dev string:x539>" + function_9e72a96( "<dev string:x59a>" ) + "<dev string:x9d>" );
        adddebugcommand( "<dev string:x5c1>" + function_9e72a96( "<dev string:x61e>" ) + "<dev string:x9d>" );
        adddebugcommand( "<dev string:x645>" + function_9e72a96( "<dev string:x6a2>" ) + "<dev string:x9d>" );
        adddebugcommand( "<dev string:x6c9>" + function_9e72a96( "<dev string:x726>" ) + "<dev string:x9d>" );
        adddebugcommand( "<dev string:x74d>" + function_9e72a96( "<dev string:x7aa>" ) + "<dev string:x9d>" );
        adddebugcommand( "<dev string:x7d1>" + function_9e72a96( "<dev string:x834>" ) + "<dev string:x9d>" );
        adddebugcommand( "<dev string:x85b>" + function_9e72a96( "<dev string:x8be>" ) + "<dev string:x9d>" );
        adddebugcommand( "<dev string:x8e7>" + function_9e72a96( "<dev string:x946>" ) + "<dev string:x9d>" );
        adddebugcommand( "<dev string:x96f>" + function_9e72a96( "<dev string:x9ce>" ) + "<dev string:x9d>" );
        adddebugcommand( "<dev string:x9f7>" + function_9e72a96( "<dev string:xa56>" ) + "<dev string:x9d>" );
        adddebugcommand( "<dev string:xa7f>" + function_9e72a96( "<dev string:xade>" ) + "<dev string:x9d>" );
        adddebugcommand( "<dev string:xb07>" + function_9e72a96( "<dev string:xb69>" ) + "<dev string:x9d>" );
        adddebugcommand( "<dev string:xb8f>" + function_9e72a96( "<dev string:xbf1>" ) + "<dev string:x9d>" );
        adddebugcommand( "<dev string:xc19>" + function_9e72a96( "<dev string:xc77>" ) + "<dev string:x9d>" );
        adddebugcommand( "<dev string:xc9f>" + function_9e72a96( "<dev string:xcfd>" ) + "<dev string:x9d>" );
        adddebugcommand( "<dev string:xd25>" + function_9e72a96( "<dev string:xd83>" ) + "<dev string:x9d>" );
        adddebugcommand( "<dev string:xdab>" + function_9e72a96( "<dev string:xe09>" ) + "<dev string:x9d>" );
        function_cd140ee9( #"hash_6ace867d48136ede", &function_35216077 );
    }

    // Namespace namespace_1b527536/namespace_1b527536
    // Params 1
    // Checksum 0x53e3208a, Offset: 0x1b18
    // Size: 0x11c, Type: dev
    function function_35216077( params )
    {
        self notify( "<dev string:xe31>" );
        self endon( "<dev string:xe31>" );
        waitframe( 1 );
        
        foreach ( player in getplayers() )
        {
            if ( params.name === #"hash_6ace867d48136ede" )
            {
                player function_6457e4cd( hash( params.value ) );
            }
        }
        
        setdvar( #"hash_6ace867d48136ede", "<dev string:x38>" );
    }

#/
