#using scripts\core_common\activecamo_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;

#namespace customclass;

// Namespace customclass/custom_class
// Params 1
// Checksum 0xd2beeaae, Offset: 0x3b8
// Size: 0x24
function localclientconnect( localclientnum )
{
    level thread custom_class_init( localclientnum );
}

// Namespace customclass/custom_class
// Params 0
// Checksum 0xb0a70c8c, Offset: 0x3e8
// Size: 0x2cc
function init()
{
    level.weapon_script_model = [];
    level.preload_weapon_model = [];
    level.last_weapon_name = [];
    level.var_8ad413c = [];
    level.current_weapon = [];
    level.attachment_names = [];
    level.paintshophiddenposition = [];
    level.camo_index = [];
    level.reticle_index = [];
    level.var_dd70be5b = [];
    level.var_aa10d0b4 = [];
    level.weapon_clientscript_cac_model = [];
    level.weaponnone = getweapon( #"none" );
    level.weapon_position[ #"primary" ] = struct::get( "cac_weapon_position_primary" );
    level.weapon_position[ #"secondary" ] = struct::get( "cac_weapon_position_secondary" );
    level.weapon_position[ #"secondary_oversized" ] = struct::get( "cac_weapon_position_secondary_oversized" );
    level.weapon_position[ #"tactical_grenade" ] = struct::get( "cac_weapon_position_tactical_grenade" );
    level.weapon_position[ #"lethal_grenade" ] = struct::get( "cac_weapon_position_lethal_grenade" );
    level.weapon_position[ #"field_upgrade" ] = struct::get( "cac_weapon_position_field_upgrade" );
    level.weapon_position[ #"perk_1" ] = struct::get( "cac_weapon_position_perk_1" );
    level.weapon_position[ #"perk_2" ] = struct::get( "cac_weapon_position_perk_2" );
    level.weapon_position[ #"perk_3" ] = struct::get( "cac_weapon_position_perk_3" );
    level.weapon_position[ #"wildcard" ] = struct::get( "cac_weapon_position_wildcard" );
    level.weapon_position[ #"gunsmith" ] = struct::get( "gunsmith_weapon_position" );
}

// Namespace customclass/custom_class
// Params 3
// Checksum 0x3b7b8bd4, Offset: 0x6c0
// Size: 0x37c
function function_1cd1374d( var_1d35315f, var_d4c489c0 = #"primary", var_e81ceea = "" )
{
    if ( isdefined( var_1d35315f ) && ( isstring( var_1d35315f ) || ishash( var_1d35315f ) ) )
    {
        var_1d35315f = getweapon( var_1d35315f );
    }
    
    if ( var_d4c489c0 == #"gunsmith" )
    {
        s_info = function_5f70d1c8( var_1d35315f, var_e81ceea );
    }
    else
    {
        s_info = function_3bff05ba( var_1d35315f );
    }
    
    var_d3c21d73 = s_info.origin;
    v_ang_offset = s_info.angles;
    
    switch ( var_d4c489c0 )
    {
        case #"primary":
        default:
            s_location = level.weapon_position[ #"primary" ];
            break;
        case #"secondary":
            if ( is_true( var_1d35315f.islauncher ) )
            {
                s_location = level.weapon_position[ #"secondary_oversized" ];
            }
            else
            {
                s_location = level.weapon_position[ #"secondary" ];
            }
            
            break;
        case #"primarygrenade":
            s_location = level.weapon_position[ #"lethal_grenade" ];
            break;
        case #"secondarygrenade":
            s_location = level.weapon_position[ #"tactical_grenade" ];
            break;
        case #"specialgrenade":
            s_location = level.weapon_position[ #"field_upgrade" ];
            break;
        case #"talent3":
        case #"talent2":
        case #"talent1":
        case #"talents":
            s_location = level.weapon_position[ #"perk_1" ];
            break;
        case #"bonuscard":
            s_location = level.weapon_position[ #"wildcard" ];
            break;
        case #"gunsmith":
            s_location = level.weapon_position[ #"gunsmith" ];
            break;
    }
    
    var_cb7a50a5 = { #origin:s_location.origin + var_d3c21d73, #angles:s_location.angles + v_ang_offset };
    return var_cb7a50a5;
}

// Namespace customclass/custom_class
// Params 1
// Checksum 0x4826da30, Offset: 0xa48
// Size: 0x5c
function custom_class_init( localclientnum )
{
    level.last_weapon_name[ localclientnum ] = "";
    level.var_8ad413c[ localclientnum ] = "";
    level.current_weapon[ localclientnum ] = undefined;
    level thread custom_class_start_threads( localclientnum );
}

// Namespace customclass/custom_class
// Params 1
// Checksum 0x20a0ed4c, Offset: 0xab0
// Size: 0xf4
function custom_class_start_threads( localclientnum )
{
    level endon( #"disconnect" );
    level thread function_13c748a( localclientnum );
    
    while ( true )
    {
        level thread custom_class_update( localclientnum );
        level thread custom_class_attachment_select_focus( localclientnum );
        level thread custom_class_remove( localclientnum );
        level thread custom_class_closed( localclientnum );
        s_waitresult = level waittill( "CustomClass_update" + localclientnum, "CustomClass_focus" + localclientnum, "CustomClass_remove" + localclientnum, "CustomClass_closed" + localclientnum );
    }
}

// Namespace customclass/custom_class
// Params 1
// Checksum 0xcddde500, Offset: 0xbb0
// Size: 0xce
function function_b4e01020( weapon )
{
    result = undefined;
    
    foreach ( attachment in weapon.attachments )
    {
        if ( isdefined( result ) )
        {
            result += "+" + attachment;
            continue;
        }
        
        result = attachment;
    }
    
    return isdefined( result ) ? result : "";
}

// Namespace customclass/custom_class
// Params 1
// Checksum 0x482056a2, Offset: 0xc88
// Size: 0x70
function function_13c748a( localclientnum )
{
    level endon( #"disconnect" );
    
    while ( true )
    {
        wait_result = level waittill( #"hash_6e24a55f8db9dad9" );
        function_bfa844a3( localclientnum, wait_result.classindex );
    }
}

// Namespace customclass/custom_class
// Params 2
// Checksum 0x88c0cbef, Offset: 0xd00
// Size: 0x312
function function_bfa844a3( localclientnum, var_73cd9b6e )
{
    var_674329bc = array( #"primary", #"secondary", #"primarygrenade", #"secondarygrenade", #"fieldupgrade", #"perk1", #"perk2", #"perk3", #"wildcard" );
    
    foreach ( var_8a4ba442 in var_674329bc )
    {
        if ( isdefined( level.weapon_script_model[ localclientnum ][ var_8a4ba442 ] ) )
        {
            level.weapon_script_model[ localclientnum ][ var_8a4ba442 ] delete();
        }
        
        if ( isdefined( level.preload_weapon_model[ localclientnum ][ var_8a4ba442 ] ) )
        {
            level.preload_weapon_model[ localclientnum ][ var_8a4ba442 ] delete();
        }
        
        weapon = getloadoutweapon( localclientnum, var_73cd9b6e, var_8a4ba442 );
        s_position = function_1cd1374d( weapon, var_8a4ba442 );
        level.weapon_script_model[ localclientnum ][ var_8a4ba442 ] = spawn_weapon_model( localclientnum, s_position.origin, s_position.angles );
        level.preload_weapon_model[ localclientnum ][ var_8a4ba442 ] = spawn_weapon_model( localclientnum, s_position.origin, s_position.angles );
        level.preload_weapon_model[ localclientnum ][ var_8a4ba442 ] hide();
        toggle_locked_weapon_shader( localclientnum, 1, var_8a4ba442 );
        update_weapon_script_model( localclientnum, weapon.name, function_b4e01020( weapon ), undefined, 1, undefined, undefined, var_8a4ba442 );
        level.weapon_script_model[ localclientnum ][ var_8a4ba442 ].origin = s_position.origin;
        level.weapon_script_model[ localclientnum ][ var_8a4ba442 ].angles = s_position.angles;
    }
}

// Namespace customclass/custom_class
// Params 1
// Checksum 0x29577e19, Offset: 0x1020
// Size: 0x44c
function custom_class_update( localclientnum )
{
    level endon( #"disconnect", "CustomClass_focus" + localclientnum, "CustomClass_remove" + localclientnum, "CustomClass_closed" + localclientnum );
    waitresult = level waittill( "CustomClass_update" + localclientnum );
    base_weapon_slot = waitresult.base_weapon_slot;
    var_f0bf9259 = waitresult.weapon;
    attachments = waitresult.attachments;
    weapon_options_param = waitresult.options;
    is_item_unlocked = waitresult.is_item_unlocked;
    xmodel_name = waitresult.xmodel_name;
    xmodel_scale = waitresult.xmodel_scale;
    var_cc6c0ec0 = waitresult.var_8d4568cf;
    var_f2af4049 = waitresult.var_820bb448;
    
    if ( base_weapon_slot === #"gunsmith" )
    {
        var_e81ceea = waitresult.attachment_group;
    }
    
    if ( !isdefined( is_item_unlocked ) )
    {
        is_item_unlocked = 1;
    }
    
    if ( !isdefined( xmodel_scale ) )
    {
        xmodel_scale = 1;
    }
    
    if ( !isdefined( xmodel_name ) )
    {
        xmodel_name = #"";
    }
    
    if ( base_weapon_slot !== #"gunsmith" && isdefined( level.weapon_script_model[ localclientnum ][ #"gunsmith" ] ) )
    {
        level.weapon_script_model[ localclientnum ][ #"gunsmith" ] forcedelete();
        arrayremovevalue( level.weapon_script_model[ localclientnum ], undefined, 1 );
    }
    
    if ( isdefined( var_f0bf9259 ) )
    {
        if ( isdefined( weapon_options_param ) && weapon_options_param != "none" )
        {
            function_998e2be7( localclientnum, weapon_options_param );
        }
        
        postfx::setfrontendstreamingoverlay( localclientnum, "cac", 1 );
        s_position = function_1cd1374d( var_f0bf9259, base_weapon_slot, var_e81ceea );
        
        if ( !isdefined( level.weapon_script_model[ localclientnum ][ base_weapon_slot ] ) )
        {
            level.weapon_script_model[ localclientnum ][ base_weapon_slot ] = spawn_weapon_model( localclientnum, s_position.origin, s_position.angles );
            level.preload_weapon_model[ localclientnum ][ base_weapon_slot ] = spawn_weapon_model( localclientnum, s_position.origin, s_position.angles );
            level.preload_weapon_model[ localclientnum ][ base_weapon_slot ] hide();
        }
        
        toggle_locked_weapon_shader( localclientnum, is_item_unlocked, base_weapon_slot );
        update_weapon_script_model( localclientnum, var_f0bf9259, attachments, undefined, is_item_unlocked, xmodel_scale, xmodel_name, base_weapon_slot, var_e81ceea );
        level.weapon_script_model[ localclientnum ][ base_weapon_slot ].origin = s_position.origin;
        level.weapon_script_model[ localclientnum ][ base_weapon_slot ].angles = s_position.angles;
        
        if ( base_weapon_slot === #"gunsmith" )
        {
            function_f87ec9a8( var_e81ceea, var_f0bf9259, var_f2af4049 );
        }
        else
        {
            function_d39cd2b5( base_weapon_slot, var_f0bf9259, var_cc6c0ec0, var_f2af4049 );
        }
        
        setallowxcamrightstickrotation( localclientnum, !lui::is_current_menu( localclientnum, "Paintshop" ) );
    }
}

// Namespace customclass/custom_class
// Params 4
// Checksum 0x20935182, Offset: 0x1478
// Size: 0x33c
function function_d39cd2b5( var_8a4ba442 = "", str_weapon, var_cc6c0ec0 = 0, var_f2af4049 = 0 )
{
    if ( isdefined( level.var_c6abe208 ) )
    {
        level scene::stop( level.var_c6abe208 );
    }
    
    if ( var_cc6c0ec0 )
    {
        level.var_c6abe208 = #"scene_frontend_t9_cac_select";
    }
    else
    {
        level.var_c6abe208 = #"scene_frontend_t9_cac_overview";
    }
    
    if ( var_f2af4049 && scene::function_9730988a( level.var_c6abe208, "overview" ) )
    {
        var_23f6420e = "overview";
    }
    else
    {
        if ( isdefined( str_weapon ) )
        {
            weapon = getweapon( str_weapon );
        }
        
        switch ( var_8a4ba442 )
        {
            case #"primary":
                var_23f6420e = "primary";
                break;
            case #"secondary":
                if ( is_true( weapon.islauncher ) )
                {
                    var_23f6420e = "secondary_alt";
                }
                else
                {
                    var_23f6420e = "secondary";
                }
                
                break;
            case #"primarygrenade":
                var_23f6420e = "lethal";
                break;
            case #"secondarygrenade":
                var_23f6420e = "tactical";
                break;
            case #"tacticalgear":
                var_23f6420e = "tactical";
                break;
            case #"specialgrenade":
                var_23f6420e = "fieldupgrade";
                break;
            case #"talents":
                var_23f6420e = "perks";
                break;
            case #"talent1":
                var_23f6420e = "perk1";
                break;
            case #"talent2":
                var_23f6420e = "perk2";
                break;
            case #"talent3":
                var_23f6420e = "perk3";
                break;
            case #"bonuscard":
                var_23f6420e = "wildcard";
                break;
            default:
                assertmsg( "<dev string:x38>" + function_9e72a96( level.var_c6abe208 ) + "<dev string:x52>" + var_8a4ba442 );
                break;
        }
    }
    
    level thread scene::play( level.var_c6abe208, var_23f6420e );
}

// Namespace customclass/custom_class
// Params 3
// Checksum 0x82776a17, Offset: 0x17c0
// Size: 0x244
function function_f87ec9a8( var_e81ceea = "", str_weapon, var_f2af4049 = 0 )
{
    if ( !isdefined( level.var_f0a17a7b ) )
    {
        level.var_f0a17a7b = #"scene_frontend_t9_gunsmith";
    }
    
    level scene::stop( level.var_f0a17a7b );
    
    if ( var_f2af4049 && scene::function_9730988a( level.var_f0a17a7b, "overview" ) )
    {
        var_7dae7df8 = "overview";
    }
    else
    {
        if ( isdefined( str_weapon ) )
        {
            weapon = getweapon( str_weapon );
        }
        
        switch ( var_e81ceea )
        {
            case #"optic":
                var_7dae7df8 = "optic";
                break;
            case #"muzzle":
                var_7dae7df8 = "muzzle";
                break;
            case #"barrel":
                var_7dae7df8 = "barrel";
                break;
            case #"underbarrel":
                var_7dae7df8 = "underbarrel";
                break;
            case #"body":
                var_7dae7df8 = "body";
                break;
            case #"stock":
                var_7dae7df8 = "stock";
                break;
            case #"magazine":
                var_7dae7df8 = "magazine";
                break;
            case #"handle":
                var_7dae7df8 = "handle";
                break;
            default:
                var_7dae7df8 = "overview";
                break;
        }
    }
    
    level thread scene::play( level.var_f0a17a7b, var_7dae7df8 );
}

// Namespace customclass/custom_class
// Params 3
// Checksum 0xba791e0f, Offset: 0x1a10
// Size: 0xa4
function toggle_locked_weapon_shader( localclientnum, is_item_unlocked = 1, var_8a4ba442 = #"primary" )
{
    if ( !isdefined( level.weapon_script_model[ localclientnum ][ var_8a4ba442 ] ) )
    {
        return;
    }
    
    if ( is_item_unlocked != 1 )
    {
        enablefrontendlockedweaponoverlay( localclientnum, 1 );
        return;
    }
    
    enablefrontendlockedweaponoverlay( localclientnum, 0 );
}

// Namespace customclass/custom_class
// Params 1
// Checksum 0x3d2e49a6, Offset: 0x1ac0
// Size: 0x1ec
function custom_class_attachment_select_focus( localclientnum )
{
    level endon( #"disconnect" );
    level endon( "CustomClass_update" + localclientnum );
    level endon( "CustomClass_remove" + localclientnum );
    level endon( "CustomClass_closed" + localclientnum );
    waitresult = level waittill( "CustomClass_focus" + localclientnum );
    level endon( "CustomClass_focus" + localclientnum );
    base_weapon_slot = waitresult.base_weapon_slot;
    weapon_name = waitresult.weapon;
    attachments = waitresult.attachments;
    attachment = waitresult.attachment;
    weapon_options_param = waitresult.options;
    weaponattachmentintersection = get_attachments_intersection( level.last_weapon_name[ localclientnum ], level.var_8ad413c[ localclientnum ], attachments );
    
    if ( isdefined( weapon_options_param ) && weapon_options_param != "none" )
    {
        function_998e2be7( localclientnum, weapon_options_param );
    }
    
    preload_weapon_model( localclientnum, weapon_name, weaponattachmentintersection, base_weapon_slot );
    update_weapon_script_model( localclientnum, weapon_name, weaponattachmentintersection, 0, undefined, undefined, undefined, base_weapon_slot );
    
    if ( weapon_name == weaponattachmentintersection )
    {
        weapon_name = undefined;
    }
    
    level thread change_weapon( localclientnum, base_weapon_slot, attachment, weapon_name, weaponattachmentintersection );
}

// Namespace customclass/custom_class
// Params 1
// Checksum 0x1439e4b3, Offset: 0x1cb8
// Size: 0x1ac
function custom_class_remove( localclientnum )
{
    level endon( #"disconnect", "CustomClass_update" + localclientnum, "CustomClass_focus" + localclientnum, "CustomClass_closed" + localclientnum );
    level waittill( "CustomClass_remove" + localclientnum );
    postfx::setfrontendstreamingoverlay( localclientnum, "cac", 0 );
    enablefrontendlockedweaponoverlay( localclientnum, 0 );
    enablefrontendtokenlockedweaponoverlay( localclientnum, 0 );
    
    if ( isarray( level.weapon_script_model[ localclientnum ] ) )
    {
        foreach ( mdl_weapon in level.weapon_script_model[ localclientnum ] )
        {
            mdl_weapon forcedelete();
        }
        
        arrayremovevalue( level.weapon_script_model[ localclientnum ], undefined, 1 );
    }
    
    level.last_weapon_name[ localclientnum ] = "";
    level.var_8ad413c[ localclientnum ] = "";
}

// Namespace customclass/custom_class
// Params 1
// Checksum 0xe19804b7, Offset: 0x1e70
// Size: 0xec
function custom_class_closed( localclientnum )
{
    level endon( #"disconnect", "CustomClass_update" + localclientnum, "CustomClass_focus" + localclientnum, "CustomClass_remove" + localclientnum );
    params = level waittill( #"customclass_closed" );
    
    if ( params.param1 == localclientnum )
    {
        postfx::setfrontendstreamingoverlay( localclientnum, "cac", 0 );
        enablefrontendlockedweaponoverlay( localclientnum, 0 );
        enablefrontendtokenlockedweaponoverlay( localclientnum, 0 );
        level.last_weapon_name[ localclientnum ] = "";
        level.var_8ad413c[ localclientnum ] = "";
    }
}

// Namespace customclass/custom_class
// Params 3
// Checksum 0xfb612ac, Offset: 0x1f68
// Size: 0x7e
function spawn_weapon_model( localclientnum, origin, angles )
{
    weapon_model = spawn( localclientnum, origin, "script_model" );
    weapon_model sethighdetail( 1, 1 );
    
    if ( isdefined( angles ) )
    {
        weapon_model.angles = angles;
    }
    
    return weapon_model;
}

// Namespace customclass/custom_class
// Params 1
// Checksum 0x8d9783a2, Offset: 0x1ff0
// Size: 0x44
function get_camo_index( localclientnum )
{
    if ( !isdefined( level.camo_index[ localclientnum ] ) )
    {
        level.camo_index[ localclientnum ] = 0;
    }
    
    return level.camo_index[ localclientnum ];
}

// Namespace customclass/custom_class
// Params 1
// Checksum 0x67f5958, Offset: 0x2040
// Size: 0x44
function get_reticle_index( localclientnum )
{
    if ( !isdefined( level.reticle_index[ localclientnum ] ) )
    {
        level.reticle_index[ localclientnum ] = 0;
    }
    
    return level.reticle_index[ localclientnum ];
}

// Namespace customclass/custom_class
// Params 1
// Checksum 0xabb54fd3, Offset: 0x2090
// Size: 0x60
function function_b843e11a( localclientnum )
{
    if ( !isdefined( level.var_eb2e3f90 ) )
    {
        level.var_eb2e3f90 = [];
    }
    
    if ( !isdefined( level.var_eb2e3f90[ localclientnum ] ) )
    {
        level.var_eb2e3f90[ localclientnum ] = 0;
    }
    
    return level.var_eb2e3f90[ localclientnum ];
}

// Namespace customclass/custom_class
// Params 1
// Checksum 0xd90b3373, Offset: 0x20f8
// Size: 0x44
function get_show_paintshop( localclientnum )
{
    if ( !isdefined( level.show_paintshop[ localclientnum ] ) )
    {
        level.show_paintshop[ localclientnum ] = 0;
    }
    
    return level.show_paintshop[ localclientnum ];
}

// Namespace customclass/custom_class
// Params 2
// Checksum 0x225c9d52, Offset: 0x2148
// Size: 0x68
function function_162e1121( localclientnum, var_571f2574 )
{
    if ( !isdefined( level.var_571f2574 ) )
    {
        level.var_571f2574 = [];
    }
    
    if ( !isdefined( level.var_571f2574[ localclientnum ] ) )
    {
        level.var_571f2574[ localclientnum ] = 0;
    }
    
    level.var_571f2574[ localclientnum ] = var_571f2574;
}

// Namespace customclass/custom_class
// Params 1
// Checksum 0x6bbd6bc0, Offset: 0x21b8
// Size: 0x60
function function_52145a0d( localclientnum )
{
    if ( !isdefined( level.var_571f2574 ) )
    {
        level.var_571f2574 = [];
    }
    
    if ( !isdefined( level.var_571f2574[ localclientnum ] ) )
    {
        level.var_571f2574[ localclientnum ] = 0;
    }
    
    return level.var_571f2574[ localclientnum ];
}

// Namespace customclass/custom_class
// Params 2
// Checksum 0x721f7af9, Offset: 0x2220
// Size: 0x194
function function_998e2be7( localclientnum, weapon_options_param )
{
    weapon_options = strtok( weapon_options_param, "," );
    level.camo_index[ localclientnum ] = int( weapon_options[ 0 ] );
    level.reticle_index[ localclientnum ] = int( weapon_options[ 1 ] );
    level.show_paintshop[ localclientnum ] = int( weapon_options[ 2 ] );
    
    if ( isdefined( weapon_options[ 3 ] ) )
    {
        level.var_eb2e3f90[ localclientnum ] = int( weapon_options[ 3 ] );
    }
    
    if ( isdefined( weapon_options[ 4 ] ) )
    {
        level.var_dd70be5b[ localclientnum ] = int( weapon_options[ 4 ] );
    }
    else
    {
        level.var_dd70be5b[ localclientnum ] = -1;
    }
    
    if ( isdefined( weapon_options[ 5 ] ) )
    {
        function_162e1121( localclientnum, int( weapon_options[ 5 ] ) );
        return;
    }
    
    function_162e1121( localclientnum, 0 );
}

// Namespace customclass/custom_class
// Params 1
// Checksum 0x952cd8ac, Offset: 0x23c0
// Size: 0x62
function get_weapon_options( localclientnum )
{
    return function_6eff28b5( localclientnum, get_camo_index( localclientnum ), get_reticle_index( localclientnum ), function_b843e11a( localclientnum ), get_show_paintshop( localclientnum ) );
}

// Namespace customclass/custom_class
// Params 4
// Checksum 0x39cce61c, Offset: 0x2430
// Size: 0x124
function preload_weapon_model( localclientnum, newweaponstring, var_f020955, var_8a4ba442 = #"primary" )
{
    level notify( "preload_weapon_changing_" + localclientnum );
    current_weapon = getweapon( newweaponstring, strtok( var_f020955, "+" ) );
    
    if ( current_weapon == level.weaponnone )
    {
        return;
    }
    
    level.preload_weapon_model[ localclientnum ][ var_8a4ba442 ] useweaponmodel( current_weapon, undefined, get_weapon_options( localclientnum ) );
    
    while ( true )
    {
        if ( level.preload_weapon_model[ localclientnum ][ var_8a4ba442 ] isstreamed() )
        {
            return;
        }
        
        wait 0.1;
    }
}

// Namespace customclass/custom_class
// Params 1
// Checksum 0xdc541904, Offset: 0x2560
// Size: 0x84
function function_8bf05e82( localclientnum )
{
    var_cc22b19 = createuimodel( function_1df4c3b0( localclientnum, #"hash_4979ef8c6b71470b" ), "entNum" );
    var_b65f6ce3 = self getentitynumber();
    setuimodelvalue( var_cc22b19, var_b65f6ce3 );
}

// Namespace customclass/custom_class
// Params 2, eflags: 0x4
// Checksum 0xc37e72f7, Offset: 0x25f0
// Size: 0xca, Type: bool
function private function_3e2b5b60( localclientnum, weaponmodel )
{
    if ( !isdefined( level.var_dd70be5b[ localclientnum ] ) || level.var_dd70be5b[ localclientnum ] <= -1 )
    {
        return false;
    }
    
    activecamoinfo = activecamo::function_ae141bf2( level.camo_index[ localclientnum ] );
    
    if ( !isdefined( activecamoinfo ) )
    {
        return false;
    }
    
    var_3594168e = activecamoinfo.stages[ level.var_dd70be5b[ localclientnum ] ];
    return activecamo::function_374e37a0( localclientnum, weaponmodel, var_3594168e, level.var_aa10d0b4 );
}

// Namespace customclass/custom_class
// Params 9
// Checksum 0x2b5dd533, Offset: 0x26c8
// Size: 0x694
function update_weapon_script_model( localclientnum, newweaponstring, var_f020955, *should_update_weapon_options, is_item_unlocked = 1, xmodel_scale = 1, xmodel_name = #"", var_8a4ba442 = #"primary", var_e81ceea )
{
    /#
        assert( isdefined( var_f020955 ), "<dev string:x6d>" );
        assert( isdefined( should_update_weapon_options ), "<dev string:xba>" );
    #/
    
    level.last_weapon_name[ newweaponstring ] = isdefined( var_f020955 ) ? var_f020955 : #"ar_accurate_t9";
    level.var_8ad413c[ newweaponstring ] = isdefined( should_update_weapon_options ) ? should_update_weapon_options : "";
    var_571f2574 = function_52145a0d( newweaponstring );
    
    if ( var_571f2574 > 0 )
    {
        if ( !issubstr( level.var_8ad413c[ newweaponstring ], "custom2" ) )
        {
            attachments = strtok( level.var_8ad413c[ newweaponstring ], "+" );
            
            if ( attachments.size < 7 )
            {
                if ( !isdefined( attachments ) )
                {
                    attachments = [];
                }
                else if ( !isarray( attachments ) )
                {
                    attachments = array( attachments );
                }
                
                attachments[ attachments.size ] = "custom2";
                should_update_weapon_options = "";
                
                for ( i = 0; i < attachments.size ; i++ )
                {
                    if ( i > 0 )
                    {
                        should_update_weapon_options += "+";
                    }
                    
                    should_update_weapon_options += attachments[ i ];
                }
                
                level.var_8ad413c[ newweaponstring ] = should_update_weapon_options;
            }
        }
    }
    
    level.current_weapon[ newweaponstring ] = getweapon( level.last_weapon_name[ newweaponstring ], strtok( level.var_8ad413c[ newweaponstring ], "+" ) );
    
    if ( level.current_weapon[ newweaponstring ] == level.weaponnone || xmodel_name !== #"" )
    {
        level.weapon_script_model[ newweaponstring ][ var_8a4ba442 ] delete();
        s_position = function_1cd1374d( level.last_weapon_name[ newweaponstring ], var_8a4ba442, var_e81ceea );
        level.weapon_script_model[ newweaponstring ][ var_8a4ba442 ] = spawn_weapon_model( newweaponstring, s_position.origin, s_position.angles );
        toggle_locked_weapon_shader( newweaponstring, is_item_unlocked, var_8a4ba442 );
        
        if ( xmodel_name !== #"" )
        {
            level.weapon_script_model[ newweaponstring ][ var_8a4ba442 ] setmodel( xmodel_name );
        }
        else if ( level.last_weapon_name[ newweaponstring ] === #"none" )
        {
            level.weapon_script_model[ newweaponstring ][ var_8a4ba442 ] setmodel( #"tag_origin" );
        }
        else
        {
            level.weapon_script_model[ newweaponstring ][ var_8a4ba442 ] setmodel( level.last_weapon_name[ newweaponstring ] );
        }
        
        level.weapon_script_model[ newweaponstring ][ var_8a4ba442 ] setscale( xmodel_scale );
        level.weapon_script_model[ newweaponstring ][ var_8a4ba442 ] setdedicatedshadow( 1 );
        return;
    }
    
    function_975f521b( var_571f2574 );
    level.weapon_script_model[ newweaponstring ][ var_8a4ba442 ] useweaponmodel( level.current_weapon[ newweaponstring ], undefined, get_weapon_options( newweaponstring ) );
    weaponmodel = level.weapon_script_model[ newweaponstring ][ var_8a4ba442 ];
    
    if ( !function_3e2b5b60( newweaponstring, weaponmodel ) )
    {
        if ( isdefined( level.var_aa10d0b4[ newweaponstring ] ) )
        {
            weaponmodel stoprenderoverridebundle( level.var_aa10d0b4[ newweaponstring ] );
            level.var_aa10d0b4[ newweaponstring ] = undefined;
        }
    }
    
    if ( var_8a4ba442 == #"gunsmith" )
    {
        s_info = function_5f70d1c8( level.current_weapon[ newweaponstring ], var_e81ceea );
    }
    else
    {
        s_info = function_3bff05ba( level.current_weapon[ newweaponstring ] );
    }
    
    level.weapon_script_model[ newweaponstring ][ var_8a4ba442 ] setscale( s_info.scale );
    level.weapon_script_model[ newweaponstring ][ var_8a4ba442 ] setdedicatedshadow( 1 );
    level.weapon_script_model[ newweaponstring ][ var_8a4ba442 ] function_8bf05e82( newweaponstring );
}

// Namespace customclass/custom_class
// Params 1
// Checksum 0xff122129, Offset: 0x2d68
// Size: 0x3e
function function_ccfcedeb( localclientnum )
{
    if ( isdefined( self.var_a8f1ca4e ) )
    {
        stopfx( localclientnum, self.var_a8f1ca4e );
        self.var_a8f1ca4e = undefined;
    }
}

// Namespace customclass/custom_class
// Params 5
// Checksum 0xda39922c, Offset: 0x2db0
// Size: 0xbc
function change_weapon( localclientnum, var_8a4ba442, newweaponstring, var_f020955, should_update_weapon_options = 0 )
{
    self notify( "485c5408809aa5f6" );
    self endon( "485c5408809aa5f6" );
    self endon( #"death" );
    level endon( #"cam_customization_closed" );
    
    if ( isdefined( newweaponstring ) )
    {
        preload_weapon_model( localclientnum, newweaponstring, var_f020955, var_8a4ba442 );
        update_weapon_script_model( localclientnum, newweaponstring, var_f020955, should_update_weapon_options, undefined, undefined, undefined, var_8a4ba442 );
    }
}

// Namespace customclass/custom_class
// Params 3
// Checksum 0xe177ff5f, Offset: 0x2e78
// Size: 0x10c
function get_attachments_intersection( oldweapon, oldattachments, newattachments )
{
    if ( !isdefined( oldweapon ) )
    {
        return newattachments;
    }
    
    var_3f8fbddf = strtok( oldattachments, "+" );
    var_95e90a5e = strtok( newattachments, "+" );
    
    if ( !isdefined( var_3f8fbddf[ 0 ] ) || var_3f8fbddf[ 0 ] != var_95e90a5e[ 0 ] )
    {
        return newattachments;
    }
    
    var_a014270e = var_95e90a5e[ 0 ];
    
    for ( i = 1; i < var_95e90a5e.size ; i++ )
    {
        if ( isinarray( var_3f8fbddf, var_95e90a5e[ i ] ) )
        {
            var_a014270e += "+" + var_95e90a5e[ i ];
        }
    }
    
    return var_a014270e;
}

// Namespace customclass/custom_class
// Params 1
// Checksum 0x9eaa2014, Offset: 0x2f90
// Size: 0x6c
function function_34668e22( weapon )
{
    if ( isdefined( weapon ) )
    {
        var_fda44b34 = function_5f7c1515( weapon );
        
        if ( isdefined( var_fda44b34.var_640479c3 ) )
        {
            settings = getscriptbundle( var_fda44b34.var_640479c3 );
            return settings;
        }
    }
}

// Namespace customclass/custom_class
// Params 2
// Checksum 0x45bf3c8d, Offset: 0x3008
// Size: 0xb16
function function_5f70d1c8( weapon, var_e81ceea = "" )
{
    settings = function_34668e22( weapon );
    var_639f35c4 = ( 0, 0, 0 );
    var_31d7e562 = ( 0, 0, 0 );
    
    switch ( var_e81ceea )
    {
        case #"optic":
            var_639f35c4 = ( isdefined( settings.var_679ca3b5 ) ? settings.var_679ca3b5 : 0, isdefined( settings.var_bc194cb1 ) ? settings.var_bc194cb1 : 0, isdefined( settings.var_67a5a3cb ) ? settings.var_67a5a3cb : 0 );
            var_31d7e562 = ( isdefined( settings.var_80cb53e7 ) ? settings.var_80cb53e7 : 0, isdefined( settings.var_9294f77a ) ? settings.var_9294f77a : 0, isdefined( settings.var_5d408cd2 ) ? settings.var_5d408cd2 : 0 );
            var_3245d5de = isdefined( settings.var_2685ca21 ) ? settings.var_2685ca21 : 1;
            break;
        case #"muzzle":
            var_639f35c4 = ( isdefined( settings.var_89849ace ) ? settings.var_89849ace : 0, isdefined( settings.var_f73a7638 ) ? settings.var_f73a7638 : 0, isdefined( settings.var_77edf7a1 ) ? settings.var_77edf7a1 : 0 );
            var_31d7e562 = ( isdefined( settings.var_390d2d1 ) ? settings.var_390d2d1 : 0, isdefined( settings.var_19bdff2b ) ? settings.var_19bdff2b : 0, isdefined( settings.var_e7ef1b8e ) ? settings.var_e7ef1b8e : 0 );
            var_3245d5de = isdefined( settings.var_b3516d45 ) ? settings.var_b3516d45 : 1;
            break;
        case #"barrel":
            var_639f35c4 = ( isdefined( settings.var_7c3d339b ) ? settings.var_7c3d339b : 0, isdefined( settings.var_6e029726 ) ? settings.var_6e029726 : 0, isdefined( settings.var_a0bffca0 ) ? settings.var_a0bffca0 : 0 );
            var_31d7e562 = ( isdefined( settings.var_8ca3e332 ) ? settings.var_8ca3e332 : 0, isdefined( settings.var_7ee247af ) ? settings.var_7ee247af : 0, isdefined( settings.var_47f3d9d3 ) ? settings.var_47f3d9d3 : 0 );
            var_3245d5de = isdefined( settings.var_ad8114a5 ) ? settings.var_ad8114a5 : 1;
            break;
        case #"underbarrel":
            var_639f35c4 = ( isdefined( settings.var_98adab76 ) ? settings.var_98adab76 : 0, isdefined( settings.var_74056226 ) ? settings.var_74056226 : 0, isdefined( settings.var_66bec799 ) ? settings.var_66bec799 : 0 );
            var_31d7e562 = ( isdefined( settings.var_d03599ea ) ? settings.var_d03599ea : 0, isdefined( settings.var_9258bc1 ) ? settings.var_9258bc1 : 0, isdefined( settings.var_2e65d641 ) ? settings.var_2e65d641 : 0 );
            var_3245d5de = isdefined( settings.var_c8287774 ) ? settings.var_c8287774 : 1;
            break;
        case #"body":
            var_639f35c4 = ( isdefined( settings.var_d0af4d25 ) ? settings.var_d0af4d25 : 0, isdefined( settings.var_e2ea719b ) ? settings.var_e2ea719b : 0, isdefined( settings.var_b75b1a7d ) ? settings.var_b75b1a7d : 0 );
            var_31d7e562 = ( isdefined( settings.var_807fd135 ) ? settings.var_807fd135 : 0, isdefined( settings.var_66581c7a ) ? settings.var_66581c7a : 0, isdefined( settings.var_5beb080c ) ? settings.var_5beb080c : 0 );
            var_3245d5de = isdefined( settings.var_ca6cd5d0 ) ? settings.var_ca6cd5d0 : 1;
            break;
        case #"stock":
            var_639f35c4 = ( isdefined( settings.var_933f2ee0 ) ? settings.var_933f2ee0 : 0, isdefined( settings.var_7d95038c ) ? settings.var_7d95038c : 0, isdefined( settings.var_210b4a7a ) ? settings.var_210b4a7a : 0 );
            var_31d7e562 = ( isdefined( settings.var_14141efc ) ? settings.var_14141efc : 0, isdefined( settings.var_3a32eb39 ) ? settings.var_3a32eb39 : 0, isdefined( settings.var_2858c785 ) ? settings.var_2858c785 : 0 );
            var_3245d5de = isdefined( settings.var_72fa56e9 ) ? settings.var_72fa56e9 : 1;
            break;
        case #"magazine":
            var_639f35c4 = ( isdefined( settings.var_c1b38db7 ) ? settings.var_c1b38db7 : 0, isdefined( settings.var_f5f1f633 ) ? settings.var_f5f1f633 : 0, isdefined( settings.var_e42f52ae ) ? settings.var_e42f52ae : 0 );
            var_31d7e562 = ( isdefined( settings.var_91fc7515 ) ? settings.var_91fc7515 : 0, isdefined( settings.var_80a5d268 ) ? settings.var_80a5d268 : 0, isdefined( settings.var_5ed38ec4 ) ? settings.var_5ed38ec4 : 0 );
            var_3245d5de = isdefined( settings.var_b41f3012 ) ? settings.var_b41f3012 : 1;
            break;
        case #"handle":
            var_639f35c4 = ( isdefined( settings.var_41ebb7d ) ? settings.var_41ebb7d : 0, isdefined( settings.var_ab648ac ) ? settings.var_ab648ac : 0, isdefined( settings.var_18806440 ) ? settings.var_18806440 : 0 );
            var_31d7e562 = ( isdefined( settings.var_59c4fda9 ) ? settings.var_59c4fda9 : 0, isdefined( settings.var_ebd421b9 ) ? settings.var_ebd421b9 : 0, isdefined( settings.var_5983fd1b ) ? settings.var_5983fd1b : 0 );
            var_3245d5de = isdefined( settings.var_52846704 ) ? settings.var_52846704 : 1;
            break;
    }
    
    var_5ac895fb = struct::spawn( ( isdefined( settings.var_2a929786 ) ? settings.var_2a929786 : 0, isdefined( settings.var_57d6720d ) ? settings.var_57d6720d : 0, isdefined( settings.var_4e105e81 ) ? settings.var_4e105e81 : 0 ), ( isdefined( settings.var_107b50df ) ? settings.var_107b50df : 0, isdefined( settings.var_d9546292 ) ? settings.var_d9546292 : 0, isdefined( settings.var_eb1f0627 ) ? settings.var_eb1f0627 : 0 ) );
    var_5ac895fb.origin += var_639f35c4;
    var_5ac895fb.angles += var_31d7e562;
    
    if ( isdefined( var_3245d5de ) )
    {
        var_5ac895fb.scale = var_3245d5de;
    }
    else
    {
        var_5ac895fb.scale = isdefined( settings.var_9c241dd8 ) ? settings.var_9c241dd8 : 1;
    }
    
    return var_5ac895fb;
}

// Namespace customclass/custom_class
// Params 1
// Checksum 0x3bf2b907, Offset: 0x3b28
// Size: 0x5ce
function function_3bff05ba( weapon )
{
    settings = function_34668e22( weapon );
    var_639f35c4 = ( 0, 0, 0 );
    var_31d7e562 = ( 0, 0, 0 );
    
    if ( function_cd84dead( weapon, "stock" ) && ( function_cd84dead( weapon, "barrel" ) || function_cd84dead( weapon, "muzzle" ) ) )
    {
        var_639f35c4 = ( isdefined( settings.var_c7679869 ) ? settings.var_c7679869 : 0, isdefined( settings.var_d99d3cd4 ) ? settings.var_d99d3cd4 : 0, isdefined( settings.var_12742e81 ) ? settings.var_12742e81 : 0 );
        var_31d7e562 = ( isdefined( settings.var_8125b034 ) ? settings.var_8125b034 : 0, isdefined( settings.var_76df9ba8 ) ? settings.var_76df9ba8 : 0, isdefined( settings.var_851ab7ca ) ? settings.var_851ab7ca : 0 );
        var_3245d5de = isdefined( settings.var_c36afd6e ) ? settings.var_c36afd6e : 1;
    }
    else if ( function_cd84dead( weapon, "barrel" ) || function_cd84dead( weapon, "muzzle" ) )
    {
        var_639f35c4 = ( isdefined( settings.var_d58892 ) ? settings.var_d58892 : 0, isdefined( settings.var_80c00869 ) ? settings.var_80c00869 : 0, isdefined( settings.var_ee9ae41d ) ? settings.var_ee9ae41d : 0 );
        var_31d7e562 = ( isdefined( settings.var_acdc6bf0 ) ? settings.var_acdc6bf0 : 0, isdefined( settings.var_9e8acf4d ) ? settings.var_9e8acf4d : 0, isdefined( settings.var_fa188663 ) ? settings.var_fa188663 : 0 );
        var_3245d5de = isdefined( settings.var_7bba1c55 ) ? settings.var_7bba1c55 : 1;
    }
    else if ( function_cd84dead( weapon, "stock" ) )
    {
        var_639f35c4 = ( isdefined( settings.var_ec765089 ) ? settings.var_ec765089 : 0, isdefined( settings.var_3ba0eee1 ) ? settings.var_3ba0eee1 : 0, isdefined( settings.var_ca0b8bb4 ) ? settings.var_ca0b8bb4 : 0 );
        var_31d7e562 = ( isdefined( settings.var_8290a87e ) ? settings.var_8290a87e : 0, isdefined( settings.var_a8c7f4ec ) ? settings.var_a8c7f4ec : 0, isdefined( settings.var_5fa9e2b1 ) ? settings.var_5fa9e2b1 : 0 );
        var_3245d5de = isdefined( settings.var_f5a9d911 ) ? settings.var_f5a9d911 : 1;
    }
    
    var_2cbf4808 = struct::spawn( ( isdefined( settings.var_6ee0b1d8 ) ? settings.var_6ee0b1d8 : 0, isdefined( settings.var_5cae8d74 ) ? settings.var_5cae8d74 : 0, isdefined( settings.var_8934e680 ) ? settings.var_8934e680 : 0 ), ( isdefined( settings.var_cf03cb96 ) ? settings.var_cf03cb96 : 0, isdefined( settings.var_4f264bd9 ) ? settings.var_4f264bd9 : 0, isdefined( settings.var_84f7b77f ) ? settings.var_84f7b77f : 0 ) );
    var_2cbf4808.origin += var_639f35c4;
    var_2cbf4808.angles += var_31d7e562;
    
    if ( isdefined( var_3245d5de ) )
    {
        var_2cbf4808.scale = var_3245d5de;
    }
    else
    {
        var_2cbf4808.scale = isdefined( settings.var_a31af46c ) ? settings.var_a31af46c : 1;
    }
    
    return var_2cbf4808;
}

