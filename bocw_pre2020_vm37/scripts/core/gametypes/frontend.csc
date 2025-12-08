#using script_7ca3324ffa5389e4;
#using scripts\core_common\activecamo_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\character_customization;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\custom_class;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\weapon_customization_icon;
#using scripts\mp_common\devgui;

#namespace frontend;

// Namespace frontend/frontend
// Params 2
// Checksum 0xc157a8e5, Offset: 0x9d8
// Size: 0x90
function function_9bfe9255( var_f75a02ea, mode )
{
    var_a2865de6 = getplayerroletemplatecount( mode );
    
    for ( i = 0; i < var_a2865de6 ; i++ )
    {
        var_eb49090f = function_b14806c6( i, mode );
        
        if ( isdefined( var_eb49090f ) && var_eb49090f == var_f75a02ea )
        {
            return i;
        }
    }
}

// Namespace frontend/frontend
// Params 3
// Checksum 0xfb68f9e, Offset: 0xa70
// Size: 0x7e, Type: bool
function function_b9f8bbd9( character_index, session_mode, *var_3f0e790b )
{
    if ( var_3f0e790b == 4 )
    {
        return false;
    }
    
    if ( !function_f4bf7e3f( session_mode, var_3f0e790b ) )
    {
        return false;
    }
    
    fields = getcharacterfields( session_mode, var_3f0e790b );
    
    if ( !isdefined( fields ) )
    {
        return false;
    }
    
    return true;
}

// Namespace frontend/frontend
// Params 3
// Checksum 0xa581ac74, Offset: 0xaf8
// Size: 0xea
function function_8d1cae0b( character_index, session_mode, var_3f0e790b )
{
    if ( !function_b9f8bbd9( character_index, session_mode, var_3f0e790b ) )
    {
        return 0;
    }
    
    if ( session_mode == 3 )
    {
        fields = getplayerrolefields( character_index, session_mode );
        return is_true( fields.isdefaultcharacter );
    }
    
    characterfields = getcharacterfields( character_index, session_mode );
    
    if ( isdefined( characterfields.requireddvar ) && !getdvarint( characterfields.requireddvar, 0 ) )
    {
        return 0;
    }
    
    return 1;
}

// Namespace frontend/frontend
// Params 5
// Checksum 0xcc60cdb5, Offset: 0xbf0
// Size: 0x206
function function_e3efec59( localclientnum, xuid, session_mode, var_3f0e790b, var_6ddefc3d = 0 )
{
    if ( !isdefined( level.var_dd1c817 ) )
    {
        level.var_dd1c817 = [];
    }
    
    if ( !isdefined( level.var_dd1c817[ session_mode ] ) )
    {
        level.var_dd1c817[ session_mode ] = [];
    }
    
    character_index = undefined;
    
    if ( var_6ddefc3d > 0 )
    {
        character_index = var_6ddefc3d;
    }
    else
    {
        character_index = getequippedheroindex( localclientnum, session_mode );
        
        if ( !function_8d1cae0b( character_index, session_mode, var_3f0e790b ) )
        {
            if ( isdefined( level.var_dd1c817[ session_mode ][ xuid ] ) )
            {
                return level.var_dd1c817[ session_mode ][ xuid ];
            }
            else
            {
                var_a2865de6 = getplayerroletemplatecount( session_mode );
                attempts = 0;
                
                while ( 1 && var_a2865de6 > 0 )
                {
                    character_index = randomint( var_a2865de6 );
                    
                    if ( function_8d1cae0b( character_index, session_mode, var_3f0e790b ) )
                    {
                        break;
                    }
                    
                    attempts++;
                    
                    if ( attempts > 3 )
                    {
                        character_index = undefined;
                        
                        for ( ci = 0; ci < var_a2865de6 ; ci++ )
                        {
                            if ( function_8d1cae0b( ci, session_mode, var_3f0e790b ) )
                            {
                                character_index = ci;
                                break;
                            }
                        }
                        
                        break;
                    }
                }
            }
        }
    }
    
    level.var_dd1c817[ session_mode ][ xuid ] = character_index;
    return level.var_dd1c817[ session_mode ][ xuid ];
}

// Namespace frontend/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x95ee6df3, Offset: 0xe00
// Size: 0x164
function event_handler[gametype_init] main( *eventstruct )
{
    level.callbackentityspawned = &entityspawned;
    level.callbacklocalclientconnect = &localclientconnect;
    level.callbackplayerspawned = &playerspawned;
    level.orbis = getdvarstring( #"orbisgame" ) == "true";
    level.durango = getdvarstring( #"durangogame" ) == "true";
    level.var_762a4ab = &function_79ac87ac;
    level.var_696537bb = &function_8567daf2;
    level.var_633071d0 = 1;
    customclass::init();
    level thread blackscreen_watcher();
    setstreamerrequest( 1, "core_frontend" );
    util::function_21aef83c();
    util::function_5ff170ee();
}

// Namespace frontend/frontend
// Params 1
// Checksum 0x4138f685, Offset: 0xf70
// Size: 0xc
function playerspawned( *localclientnum )
{
    
}

// Namespace frontend/frontend
// Params 2
// Checksum 0xaa374d19, Offset: 0xf88
// Size: 0x7c
function function_e843475e( localclientnum, menuname )
{
    lui::function_f603fc4d( menuname, localclientnum, #"tag_align_frontend_background", #"ui_scene_cam_background" );
    lui::function_460e6001( menuname, localclientnum, 3, #"tag_align_frontend_background", #"ui_scene_cam_background" );
}

// Namespace frontend/frontend
// Params 1
// Checksum 0x30e6e7a6, Offset: 0x1010
// Size: 0xf3c
function setupclientmenus( localclientnum )
{
    lui::function_2888ee3c( localclientnum );
    lui::function_6425472c( "PressStart", localclientnum, #"scene_frontend_t9_lobby_player1", "intro", "idle" );
    lui::function_17384292( "PressStart", localclientnum, &lobby_main );
    lui::function_866692f8( "PressStart", localclientnum, #"loadout_room", #"scene_frontend_t9_cac_overview", undefined, "overview" );
    lui::function_866692f8( "PressStart", localclientnum, #"scorestreaks", #"scene_frontend_t9_scorestreak", "intro", "idle" );
    lui::function_866692f8( "PressStart", localclientnum, #"armory", #"scene_frontend_t9_cac_overview", undefined, "overview" );
    lui::function_866692f8( "PressStart", localclientnum, #"character_room", #"scene_frontend_t9_character", "select_intro", "select_idle", "select_outro" );
    lui::function_866692f8( "PressStart", localclientnum, #"room1", #"scene_frontend_start", undefined, "start", undefined );
    lui::function_866692f8( "PressStart", localclientnum, #"room2", #"scene_frontend_start", undefined, "start", undefined );
    lui::function_866692f8( "PressStart", localclientnum, #"mode_select", #"scene_frontend_start", undefined, "main", undefined );
    lui::function_866692f8( "PressStart", localclientnum, #"hash_741f58bb639e94ff", #"scene_frontend_t9_cp_mission_select", "intro", "idle" );
    lui::function_8950260c( "PressStart", localclientnum, #"character_room", #"lobby_pose", "idle" );
    lui::function_8950260c( "PressStart", localclientnum, #"loadout_room", #"lobby_pose", "idle" );
    lui::function_8950260c( "PressStart", localclientnum, #"character_room", #"lobby_pose", "idle" );
    lui::function_8950260c( "PressStart", localclientnum, #"loadout_room", #"lobby_pose", "idle" );
    lui::function_8950260c( "PressStart", localclientnum, #"character_room", #"lobby_pose", "idle" );
    lui::function_8950260c( "PressStart", localclientnum, #"loadout_room", #"lobby_pose", "idle" );
    lui::function_8950260c( "PressStart", localclientnum, #"armory", #"lobby_pose", "idle" );
    lui::function_8950260c( "PressStart", localclientnum, #"scorestreaks", #"lobby_pose", "idle" );
    lui::function_8950260c( "PressStart", localclientnum, #"character_room", #"private_lobby_pose", "idle" );
    lui::function_8950260c( "PressStart", localclientnum, #"loadout_room", #"private_lobby_pose", "idle" );
    lui::function_8950260c( "PressStart", localclientnum, #"character_room", #"private_lobby_pose", "idle" );
    lui::function_8950260c( "PressStart", localclientnum, #"loadout_room", #"private_lobby_pose", "idle" );
    lui::function_8950260c( "PressStart", localclientnum, #"character_room", #"private_lobby_pose", "idle" );
    lui::function_8950260c( "PressStart", localclientnum, #"loadout_room", #"private_lobby_pose", "idle" );
    lui::function_8950260c( "PressStart", localclientnum, #"armory", #"private_lobby_pose", "idle" );
    lui::function_8950260c( "PressStart", localclientnum, #"scorestreaks", #"private_lobby_pose", "idle" );
    lui::function_6425472c( "Armory", localclientnum, #"scene_frontend_t9_cac_overview", undefined, "overview" );
    lui::function_866692f8( "Armory", localclientnum, #"gunsmith", #"scene_frontend_t9_gunsmith", undefined, "overview" );
    lui::function_969a2881( "LobbyInspection", localclientnum, &handle_inspect_player, 0, &start_character_rotating_any, &end_character_rotating_any );
    lui::function_1337c436( "LobbyInspection", localclientnum, "inspection_character", 0 );
    lui::function_969a2881( "SinglePlayerInspection", localclientnum, &handle_inspect_player, 0, &start_character_rotating_any, &end_character_rotating_any );
    lui::function_1337c436( "SinglePlayerInspection", localclientnum, "inspection_character", 0 );
    lui::function_969a2881( "Paintshop", localclientnum, undefined, 0, undefined, undefined );
    lui::function_969a2881( "PaintjobWeaponSelect", localclientnum, undefined, 0, undefined, undefined );
    lui::function_6425472c( "Gunsmith", localclientnum, #"scene_frontend_t9_gunsmith", undefined, "overview" );
    lui::function_6425472c( "GunsmithAttachmentSelect", localclientnum, #"scene_frontend_t9_gunsmith", undefined, "overview" );
    lui::function_6425472c( "SupportSelection", localclientnum, #"scene_frontend_t9_scorestreak", "intro", "idle" );
    lui::function_969a2881( "BubblegumBuffSelect", localclientnum, undefined, undefined, undefined, undefined );
    lui::function_969a2881( "Pregame_Main", localclientnum, &lobby_main, 1 );
    lui::function_969a2881( "MPCustomizeClassMenu", localclientnum, undefined, 0, undefined, undefined );
    lui::function_969a2881( "ZMCustomizeClassMenu", localclientnum, undefined, 0, undefined, undefined );
    lui::function_6425472c( "WeaponSelectFlyout", localclientnum, #"scene_frontend_t9_cac_overview", undefined, "overview" );
    lui::function_969a2881( "AAR_T8_MP", localclientnum, &function_73b8462a, 1, undefined, &function_48fb04a7 );
    lui::function_1337c436( "AAR_T8_MP", localclientnum, "aar_character" );
    lui::function_969a2881( "AAR_T8_ZM", localclientnum, &function_73b8462a, 1, undefined, &function_48fb04a7 );
    lui::function_1337c436( "AAR_T8_ZM", localclientnum, "aar_character" );
    lui::function_969a2881( "AAR_T8_WZ", localclientnum, &function_73b8462a, 1, undefined, &function_48fb04a7 );
    lui::function_1337c436( "AAR_T8_WZ", localclientnum, "aar_character" );
    lui::function_969a2881( "AAR_T8_ARENA", localclientnum, &function_73b8462a, 1, undefined, &function_48fb04a7 );
    lui::function_1337c436( "AAR_T8_ARENA", localclientnum, "aar_character" );
    lui::function_969a2881( "AARMissionRewardOverlay", localclientnum, &function_f8cec907, 1, undefined, &end_character_rotating );
    lui::function_1337c436( "AARMissionRewardOverlay", localclientnum, "specialist_customization" );
    function_e843475e( localclientnum, "Social_Main" );
    function_e843475e( localclientnum, "EmblemSelect" );
    function_e843475e( localclientnum, "EmblemChooseIcon" );
    function_e843475e( localclientnum, "EmblemEditor" );
    function_e843475e( localclientnum, "Store" );
    function_e843475e( localclientnum, "Store_DLC" );
    function_e843475e( localclientnum, "DirectorFindGame" );
    function_e843475e( localclientnum, "ZMPersonalizeCharacterMain" );
    function_e843475e( localclientnum, "WZPersonalizeCharacterMain" );
    lui::function_6425472c( "PersonalizeCharacter", localclientnum, #"scene_frontend_t9_character", "change_skin_intro", "change_skin_idle", "change_skin_outro" );
    lui::function_1337c436( "PersonalizeCharacter", localclientnum, "specialist_customization" );
    lui::function_969a2881( "MPSpecialistHUBGestures", localclientnum, &function_9602c423, 1, &start_character_rotating, &end_character_rotating );
    lui::function_1337c436( "MPSpecialistHUBGestures", localclientnum, "specialist_customization" );
    function_e843475e( localclientnum, "MPSpecialistHUBTags" );
    lui::function_969a2881( "ItemShopDetails", localclientnum, &function_837446a8, 1, array( &function_98088878 ), array( &end_character_rotating, &function_7142469f ) );
    lui::function_1337c436( "ItemShopDetails", localclientnum, "specialist_customization" );
    lui::function_969a2881( "WeaponDeathFxSelect", localclientnum, &function_ac9a8cf, 0, &start_character_rotating, array( &function_5e7dcbed, &end_character_rotating ) );
    lui::function_1337c436( "WeaponDeathFxSelect", localclientnum, "specialist_customization" );
    var_5ef5aa96 = "scene_frontend_arena_team";
    scene::add_scene_func( var_5ef5aa96, &function_fad4ce33, "init" );
    scene::add_scene_func( var_5ef5aa96, &function_c5cbf7d6, "stop" );
}

// Namespace frontend/frontend
// Params 0
// Checksum 0x6ecb74c5, Offset: 0x1f58
// Size: 0x168
function blackscreen_watcher()
{
    blackscreenuimodel = getuimodel( function_5f72e972( #"director_global" ), "hideWorldForStreamer" );
    setuimodelvalue( blackscreenuimodel, 1 );
    
    while ( true )
    {
        waitresult = level waittill( #"streamer_change" );
        var_d0b01271 = waitresult.var_d0b01271;
        setuimodelvalue( blackscreenuimodel, 1 );
        wait 0.1;
        
        while ( true )
        {
            charready = 1;
            
            if ( isdefined( var_d0b01271 ) )
            {
                charready = [[ var_d0b01271 ]]->is_streamed();
            }
            
            sceneready = getstreamerrequestprogress( 0 ) >= 100;
            
            if ( charready && sceneready )
            {
                break;
            }
            
            wait 0.1;
        }
        
        setuimodelvalue( blackscreenuimodel, 0 );
    }
}

// Namespace frontend/frontend
// Params 2
// Checksum 0x96b0754b, Offset: 0x20c8
// Size: 0x78
function streamer_change( hint, var_d0b01271 )
{
    if ( isdefined( hint ) )
    {
        setstreamerrequest( 0, hint );
    }
    else
    {
        clearstreamerrequest( 0 );
    }
    
    level notify( #"streamer_change", { #var_d0b01271:var_d0b01271 } );
}

// Namespace frontend/frontend
// Params 2
// Checksum 0xc0df850a, Offset: 0x2148
// Size: 0x128
function handle_inspect_player( localclientnum, menu_name )
{
    level endon( #"disconnect" );
    level endon( menu_name + "_closed" );
    level thread scene::play( "scene_frontend_inspection_camera", "inspection_full" );
    level thread function_b885d47c( menu_name, localclientnum );
    level thread function_37304ace( localclientnum, menu_name );
    
    while ( true )
    {
        waitresult = level waittill( #"inspect_player" );
        assert( isdefined( waitresult.xuid ) );
        level childthread update_inspection_character( localclientnum, waitresult.xuid, menu_name );
    }
}

// Namespace frontend/frontend
// Params 2
// Checksum 0x9f3c9562, Offset: 0x2278
// Size: 0x5c
function function_b885d47c( menu_name, *localclientnum )
{
    level waittill( localclientnum + "_closed" );
    level thread scene::stop( "scene_frontend_inspection_camera" );
    level.var_44011752 hide();
}

// Namespace frontend/frontend
// Params 4
// Checksum 0x582d10dc, Offset: 0x22e0
// Size: 0x4e0
function update_inspection_character( localclientnum, xuid, menu_name, var_6ddefc3d = 0 )
{
    self notify( "239b8f6b4c16f3ff" );
    self endon( "239b8f6b4c16f3ff" );
    var_d0b01271 = lui::function_daadc836( menu_name, localclientnum );
    var_a708693a = isdefined( level.draftcharacters ) && level.draftcharacters.size > 0;
    
    if ( var_a708693a )
    {
        foreach ( character in level.draftcharacters )
        {
            info = [[ character ]]->function_82e05d64();
            
            if ( isdefined( info ) && util::function_48e57e36( xuid ) == info.xuid )
            {
                var_23904c1d = [[ character ]]->function_e599283f();
            }
        }
    }
    
    if ( !isdefined( var_23904c1d ) )
    {
        var_23904c1d = getcharactercustomizationforxuid( localclientnum, util::function_48e57e36( xuid ) );
    }
    
    if ( !isdefined( var_23904c1d ) )
    {
        [[ var_d0b01271 ]]->function_1ec9448d( 1 );
        [[ var_d0b01271 ]]->function_27945cb8( 1 );
        params = { #anim_name:[[ var_d0b01271 ]]->function_8144231c() };
        [[ var_d0b01271 ]]->update( params );
        
        for ( iterations = 0; !isdefined( var_23904c1d ) && iterations < 15 ; iterations++ )
        {
            wait 1;
            var_23904c1d = getcharactercustomizationforxuid( localclientnum, xuid );
        }
        
        [[ var_d0b01271 ]]->function_1ec9448d( 0 );
        [[ var_d0b01271 ]]->function_27945cb8( 0 );
    }
    
    session_mode = currentsessionmode();
    
    if ( !isdefined( var_23904c1d ) || !var_a708693a && !function_8d1cae0b( var_23904c1d.charactertype, var_23904c1d.charactermode, 4 ) || session_mode != 4 && var_23904c1d.charactermode != session_mode )
    {
        if ( session_mode == 4 || session_mode == 2 )
        {
            session_mode = 1;
            
            if ( getplayerroletemplatecount( session_mode ) == 0 )
            {
                session_mode = 3;
            }
            
            if ( getplayerroletemplatecount( session_mode ) == 0 )
            {
                session_mode = 0;
            }
        }
        
        character_index = function_e3efec59( localclientnum, xuid, session_mode, 4, var_6ddefc3d );
        
        if ( isdefined( character_index ) )
        {
            level.var_dd1c817[ xuid ] = character_index;
            var_23904c1d = character_customization::function_3f5625f1( session_mode, character_index );
            fields = getcharacterfields( character_index, session_mode );
        }
    }
    else
    {
        fields = getcharacterfields( var_23904c1d.charactertype, var_23904c1d.charactermode );
    }
    
    var_8e0277a = undefined;
    
    if ( isdefined( fields ) )
    {
        var_8e0277a = fields.var_2081b2ed;
    }
    
    if ( isdefined( var_8e0277a ) && character_customization::function_aa5382ed( [[ var_d0b01271 ]]->function_e599283f(), var_23904c1d ) )
    {
        [[ var_d0b01271 ]]->function_1ec9448d( 0 );
        params = { #var_401d9a1:1, #var_c76f3e47:1, #scene:var_8e0277a };
        [[ var_d0b01271 ]]->function_15a8906a( var_23904c1d );
        [[ var_d0b01271 ]]->update( params );
    }
}

// Namespace frontend/frontend
// Params 2
// Checksum 0x8b6909b4, Offset: 0x27c8
// Size: 0x198
function function_37304ace( localclientnum, menu_name )
{
    level endon( #"disconnect" );
    level endon( menu_name + "_closed" );
    
    while ( true )
    {
        waitresult = level waittill( #"hash_6d381d5ecca233c6" );
        
        if ( is_true( waitresult.clear_weapon ) )
        {
            level.var_44011752 hide();
            level thread scene::stop( #"scene_frontend_inspection_weapon" );
            continue;
        }
        
        assert( isdefined( waitresult.weapon ) );
        assert( isdefined( waitresult.attachments ) );
        assert( isdefined( waitresult.camoindex ) );
        assert( isdefined( waitresult.paintjobslot ) );
        assert( isdefined( waitresult.weaponmodelslot ) );
        level childthread function_daa3f7d0( localclientnum, waitresult, 1 );
    }
}

// Namespace frontend/frontend
// Params 3
// Checksum 0xd698bdfb, Offset: 0x2968
// Size: 0x2a4
function function_daa3f7d0( *localclientnum, weaponinfo, *should_update_weapon_options )
{
    newweaponstring = should_update_weapon_options.weapon;
    var_f020955 = should_update_weapon_options.attachments;
    current_weapon = getweapon( newweaponstring, strtok( var_f020955, "+" ) );
    
    if ( isdefined( current_weapon ) && isdefined( level.var_44011752 ) )
    {
        if ( level scene::is_playing( #"scene_frontend_inspection_weapon" ) )
        {
            level.var_44011752 show();
            level thread scene::stop( #"scene_frontend_inspection_weapon" );
        }
        
        wait 0.1;
        s_info = customclass::function_5f70d1c8( current_weapon );
        render_options = function_6eff28b5( should_update_weapon_options.camoindex, 0, should_update_weapon_options.weaponmodelslot, 0 );
        level.var_44011752 useweaponmodel( current_weapon, undefined, render_options );
        level.var_44011752 setscale( s_info.scale );
        level.var_44011752.targetname = "customized_inspection_weapon";
        level.var_44011752 useanimtree( "generic" );
        position = struct::get( #"tag_align_inspection_weapon1" );
        origin = position.origin + s_info.offset;
        angles = position.angles + s_info.angles;
        level.var_44011752 thread animation::play( #"hash_3689442490c2e5dd", origin, angles );
        level thread scene::play( #"scene_frontend_inspection_weapon", "inspection_weapon_full" );
        level.var_44011752 show();
    }
}

// Namespace frontend/frontend
// Params 1
// Checksum 0xbe847136, Offset: 0x2c18
// Size: 0xc
function entityspawned( *localclientnum )
{
    
}

/#

    // Namespace frontend/frontend
    // Params 1
    // Checksum 0xafaa651d, Offset: 0x2c30
    // Size: 0x208, Type: dev
    function function_90646a7f( localclientnum )
    {
        while ( true )
        {
            ct_cmd = getdvarint( #"hash_52d9845c30e27ace", 0 );
            
            if ( ct_cmd == 0 )
            {
                wait 0.25;
                continue;
            }
            
            roommodel = getuimodel( function_5f72e972( #"lobby_root" ), "<dev string:x38>" );
            room = getuimodelvalue( roommodel );
            origin = getcamposbylocalclientnum( localclientnum );
            angles = getcamanglesbylocalclientnum( localclientnum );
            sendmenuresponse( localclientnum, #"spawn_noclip", int( origin[ 0 ] ) + "<dev string:x40>" + int( origin[ 1 ] ) + "<dev string:x40>" + int( origin[ 2 ] ) + "<dev string:x40>" + int( angles[ 0 ] ) + "<dev string:x40>" + int( angles[ 1 ] ) + "<dev string:x40>" + int( angles[ 2 ] ), 1 );
            setdvar( #"hash_52d9845c30e27ace", 0 );
        }
    }

    // Namespace frontend/frontend
    // Params 2
    // Checksum 0x6648d87c, Offset: 0x2e40
    // Size: 0x182, Type: dev
    function function_da10fc8f( localclientnum, imagepath )
    {
        var_38b900c2 = getent( localclientnum, "<dev string:x45>", "<dev string:x5d>" );
        var_51a0f339 = getent( localclientnum, "<dev string:x6b>", "<dev string:x5d>" );
        var_38b900c2 show();
        var_51a0f339 hide();
        function_45180840( localclientnum );
        
        do
        {
            waitframe( 1 );
        }
        while ( function_6911e8d( localclientnum ) );
        
        var_38b900c2 hide();
        var_51a0f339 show();
        waitframe( 1 );
        function_c6df7fed( localclientnum );
        
        do
        {
            waitframe( 1 );
        }
        while ( function_6911e8d( localclientnum ) );
        
        function_84469b54( imagepath );
        var_38b900c2 show();
        var_51a0f339 hide();
        waitframe( 1 );
    }

    // Namespace frontend/frontend
    // Params 4
    // Checksum 0x4af88bcf, Offset: 0x2fd0
    // Size: 0x22e, Type: dev
    function function_93ccf33d( var_62d90151, entrytype, &var_37451b86, &var_7f0244ba )
    {
        foreach ( i, item in var_62d90151 )
        {
            entry = { #index:i, #type:entrytype, #item:item };
            
            if ( isdefined( var_37451b86[ item.name ] ) )
            {
                if ( !isdefined( var_37451b86[ item.name ].options[ entrytype ] ) )
                {
                    var_37451b86[ item.name ].options[ entrytype ] = [];
                }
                else if ( !isarray( var_37451b86[ item.name ].options[ entrytype ] ) )
                {
                    var_37451b86[ item.name ].options[ entrytype ] = array( var_37451b86[ item.name ].options[ entrytype ] );
                }
                
                var_37451b86[ item.name ].options[ entrytype ][ var_37451b86[ item.name ].options[ entrytype ].size ] = entry;
                continue;
            }
            
            if ( i != 0 )
            {
                if ( !isdefined( var_7f0244ba ) )
                {
                    var_7f0244ba = [];
                }
                else if ( !isarray( var_7f0244ba ) )
                {
                    var_7f0244ba = array( var_7f0244ba );
                }
                
                var_7f0244ba[ var_7f0244ba.size ] = entry;
            }
        }
    }

    // Namespace frontend/frontend
    // Params 7
    // Checksum 0x8d856c88, Offset: 0x3208
    // Size: 0x31c, Type: dev
    function function_23bc6f08( localclientnum, var_d0b01271, itemtype, item_data, mode, character_index, var_b34f01f0 )
    {
        if ( item_data.lootid == #"" )
        {
            return;
        }
        
        switch ( itemtype )
        {
            case 1:
                return;
            case 2:
                shot_name = "<dev string:x83>";
                break;
            case 3:
                shot_name = "<dev string:x8b>";
                break;
            case 7:
                shot_name = "<dev string:x97>";
                break;
            case 6:
                shot_name = "<dev string:xa3>";
                break;
            case 0:
                shot_name = "<dev string:xac>";
                break;
            case 4:
                shot_name = "<dev string:xb4>";
                break;
            default:
                shot_name = "<dev string:xbc>";
                break;
        }
        
        scene_name = #"scene_frontend_character_male_render";
        
        if ( #"female" == getherogender( character_index, mode ) )
        {
            scene_name = #"scene_frontend_character_female_render";
        }
        
        [[ var_d0b01271 ]]->update( { #var_c76f3e47:1, #var_5bd51249:8, #var_13fb1841:4, #scene:scene_name, #scene_shot:shot_name } );
        
        do
        {
            wait 0.5;
        }
        while ( ![[ var_d0b01271 ]]->function_ea4ac9f8() );
        
        var_f75a02ea = function_9e72a96( function_b14806c6( character_index, mode ) );
        
        if ( var_b34f01f0 )
        {
            shot_name = "<dev string:xc8>" + var_f75a02ea + "<dev string:xdb>" + function_9e72a96( item_data.lootid ) + "<dev string:xe0>";
        }
        else
        {
            shot_name = "<dev string:xc8>" + var_f75a02ea + "<dev string:xdb>" + function_9e72a96( item_data.lootid ) + "<dev string:xfb>";
        }
        
        function_da10fc8f( localclientnum, shot_name );
    }

    // Namespace frontend/frontend
    // Params 2
    // Checksum 0x4a7d281b, Offset: 0x3530
    // Size: 0xb0, Type: dev
    function function_2351cba1( itemtype, mode )
    {
        switch ( itemtype )
        {
            case 1:
                return 0;
            case 0:
            case 2:
            case 3:
            case 4:
            case 5:
            case 6:
                return ( mode != 1 );
        }
        
        return 1;
    }

    // Namespace frontend/frontend
    // Params 3
    // Checksum 0x981e595d, Offset: 0x35e8
    // Size: 0x89c, Type: dev
    function function_4920c25a( localclientnum, menu_name, state )
    {
        self notify( "<dev string:x108>" );
        self endon( "<dev string:x108>" );
        function_25485718();
        var_38b900c2 = getent( localclientnum, "<dev string:x45>", "<dev string:x5d>" );
        var_51a0f339 = getent( localclientnum, "<dev string:x6b>", "<dev string:x5d>" );
        var_38b900c2 show();
        var_51a0f339 hide();
        args = strtok( state, "<dev string:x11c>" );
        mode = int( args[ 0 ] );
        character_index = int( args[ 1 ] );
        outfit_index = int( args[ 2 ] );
        var_7823b8b1 = int( args[ 3 ] );
        var_d0b01271 = lui::function_daadc836( menu_name, localclientnum );
        [[ var_d0b01271 ]]->set_character_mode( mode );
        [[ var_d0b01271 ]]->set_character_index( character_index );
        [[ var_d0b01271 ]]->function_22039feb();
        outfitcount = function_d299ef16( character_index, mode );
        var_f750af1d = outfit_index == -1 ? 0 : outfit_index;
        var_f58d84ac = outfit_index == -1 ? outfitcount - 1 : outfit_index;
        
        for ( outfitindex = var_f750af1d; outfitindex <= var_f58d84ac ; outfitindex++ )
        {
            var_9cf37283 = function_d7c3cf6c( character_index, outfitindex, mode );
            [[ var_d0b01271 ]]->set_character_outfit( outfitindex );
            [[ var_d0b01271 ]]->function_158505aa( outfitindex );
            
            if ( mode == 1 && ( var_7823b8b1 == -1 || var_7823b8b1 == 8 ) )
            {
                foreach ( preset in var_9cf37283.presets )
                {
                    if ( preset.isvalid && preset.lootid != #"" )
                    {
                        [[ var_d0b01271 ]]->function_95779b72();
                        
                        foreach ( type, option in preset.parts )
                        {
                            [[ var_d0b01271 ]]->set_character_outfit_item( option, type );
                        }
                        
                        function_23bc6f08( localclientnum, var_d0b01271, 8, preset, mode, character_index, 0 );
                        
                        foreach ( option, war_paint in var_9cf37283.options[ 7 ] )
                        {
                            if ( war_paint.name == preset.name )
                            {
                                [[ var_d0b01271 ]]->set_character_outfit_item( option, 7 );
                                break;
                            }
                        }
                        
                        foreach ( option, war_paint in var_9cf37283.options[ 1 ] )
                        {
                            if ( war_paint.name == preset.name )
                            {
                                [[ var_d0b01271 ]]->set_character_outfit_item( option, 7 );
                                break;
                            }
                        }
                        
                        function_23bc6f08( localclientnum, var_d0b01271, 8, preset, mode, character_index, 1 );
                    }
                }
            }
            
            foreach ( type, options in var_9cf37283.options )
            {
                if ( function_2351cba1( type, mode ) && ( var_7823b8b1 == -1 || var_7823b8b1 == type ) )
                {
                    [[ var_d0b01271 ]]->set_character_outfit( outfitindex );
                    [[ var_d0b01271 ]]->function_158505aa( outfitindex );
                    
                    foreach ( i, option in options )
                    {
                        [[ var_d0b01271 ]]->function_95779b72();
                        [[ var_d0b01271 ]]->set_character_outfit_item( i, type );
                        
                        if ( type == 7 && mode == 1 )
                        {
                            var_47e7e198 = undefined;
                            
                            foreach ( j, palette in var_9cf37283.options[ 5 ] )
                            {
                                if ( palette.name == option.name )
                                {
                                    var_47e7e198 = j;
                                    break;
                                }
                            }
                            
                            if ( isdefined( var_47e7e198 ) )
                            {
                                [[ var_d0b01271 ]]->set_character_outfit( outfitindex );
                                [[ var_d0b01271 ]]->set_character_outfit_item( var_47e7e198, 5 );
                            }
                            else
                            {
                                [[ var_d0b01271 ]]->set_character_outfit( 0 );
                            }
                        }
                        
                        function_23bc6f08( localclientnum, var_d0b01271, type, option, mode, character_index, 0 );
                    }
                }
            }
        }
        
        [[ var_d0b01271 ]]->function_39a68bf2();
        level notify( "<dev string:x121>" + localclientnum, { #menu:"<dev string:x130>", #status:"<dev string:x146>" } );
        setdvar( #"char_render", "<dev string:x150>" );
        function_59013397();
    }

    // Namespace frontend/frontend
    // Params 1
    // Checksum 0x22d63494, Offset: 0x3e90
    // Size: 0x9c, Type: dev
    function function_92087f1b( localclientnum )
    {
        if ( getdvarint( #"hash_af3e02adb15e8ec", 0 ) > 0 )
        {
            level thread function_fb399a61( localclientnum );
            return;
        }
        
        util::add_devgui( localclientnum, "<dev string:x154>" + "<dev string:x16c>", "<dev string:x17f>" );
        level thread function_622b5dc0( localclientnum );
    }

    // Namespace frontend/frontend
    // Params 1
    // Checksum 0x82228be6, Offset: 0x3f38
    // Size: 0xa4, Type: dev
    function function_622b5dc0( localclientnum )
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( #"hash_af3e02adb15e8ec", 0 ) > 0 )
            {
                util::remove_devgui( localclientnum, "<dev string:x154>" + "<dev string:x16c>" );
                level thread function_fb399a61( localclientnum );
                return;
            }
            
            wait 1;
        }
    }

    // Namespace frontend/frontend
    // Params 1
    // Checksum 0xf1cf20f2, Offset: 0x3fe8
    // Size: 0x6fa, Type: dev
    function function_fb399a61( localclientnum )
    {
        lui::function_969a2881( "<dev string:x130>", localclientnum, &function_4920c25a, 1, undefined, undefined, 0 );
        lui::function_1337c436( "<dev string:x130>", localclientnum, "<dev string:x1a9>" );
        target = struct::get( #"character_staging_extracam1" );
        assert( isdefined( target ) );
        var_663588d = "<dev string:x154>";
        var_f4b452be = [ 1:"<dev string:x1cc>", 3:"<dev string:x1d2>", 0:"<dev string:x1d8>" ];
        var_8d6e963c = [ "<dev string:xac>", 2:"<dev string:x1de>", 3:"<dev string:x1e7>", 4:"<dev string:xb4>", 5:"<dev string:x1f5>", 6:"<dev string:x201>", 7:"<dev string:x20b>" ];
        
        foreach ( mode, display_name in var_f4b452be )
        {
            var_82414930 = var_663588d + display_name + "<dev string:xdb>";
            
            for ( index = 0; index < getplayerroletemplatecount( mode ) ; index++ )
            {
                var_f75a02ea = function_9e72a96( function_b14806c6( index, mode ) );
                var_11f96a92 = var_82414930 + var_f75a02ea + "<dev string:xdb>";
                adddebugcommand( localclientnum, "<dev string:x219>" + var_11f96a92 + "<dev string:x229>" + "<dev string:x230>" + "<dev string:x236>" + "<dev string:x23f>" + "<dev string:x11c>" + mode + "<dev string:x11c>" + index + "<dev string:x11c>" + -1 + "<dev string:x11c>" + -1 + "<dev string:x24e>" + "<dev string:x253>" );
                outfitcount = function_d299ef16( index, mode );
                
                for ( outfitindex = 0; outfitindex < outfitcount ; outfitindex++ )
                {
                    var_9cf37283 = function_d7c3cf6c( index, outfitindex, mode );
                    
                    if ( var_9cf37283.valid )
                    {
                        var_b614b3ba = var_11f96a92 + function_9e72a96( var_9cf37283.namehash ) + "<dev string:xdb>";
                        adddebugcommand( localclientnum, "<dev string:x219>" + var_b614b3ba + "<dev string:x229>" + "<dev string:x230>" + "<dev string:x236>" + "<dev string:x23f>" + "<dev string:x11c>" + mode + "<dev string:x11c>" + index + "<dev string:x11c>" + outfitindex + "<dev string:x11c>" + -1 + "<dev string:x24e>" + "<dev string:x253>" );
                        
                        if ( mode == 1 )
                        {
                            adddebugcommand( localclientnum, "<dev string:x219>" + var_b614b3ba + "<dev string:x258>" + "<dev string:x230>" + "<dev string:x236>" + "<dev string:x23f>" + "<dev string:x11c>" + mode + "<dev string:x11c>" + index + "<dev string:x11c>" + outfitindex + "<dev string:x11c>" + 8 + "<dev string:x24e>" + "<dev string:x253>" );
                        }
                        
                        foreach ( type, name in var_8d6e963c )
                        {
                            if ( function_2351cba1( type, mode ) )
                            {
                                adddebugcommand( localclientnum, "<dev string:x219>" + var_b614b3ba + name + "<dev string:x230>" + "<dev string:x236>" + "<dev string:x23f>" + "<dev string:x11c>" + mode + "<dev string:x11c>" + index + "<dev string:x11c>" + outfitindex + "<dev string:x11c>" + type + "<dev string:x24e>" + "<dev string:x253>" );
                            }
                        }
                        
                        waitframe( 1 );
                    }
                }
            }
        }
        
        setdvar( #"char_render", "<dev string:x150>" );
        var_f7a528f2 = "<dev string:x150>";
        
        while ( true )
        {
            wait 0.1;
            
            if ( getdvarstring( #"char_render", var_f7a528f2 ) != var_f7a528f2 )
            {
                var_f7a528f2 = getdvarstring( #"char_render" );
                
                if ( var_f7a528f2 != "<dev string:x150>" )
                {
                    level notify( "<dev string:x121>" + localclientnum, { #menu:"<dev string:x130>", #status:"<dev string:x263>", #state:var_f7a528f2 } );
                }
            }
        }
    }

    // Namespace frontend/frontend
    // Params 6
    // Checksum 0x6d543f8e, Offset: 0x46f0
    // Size: 0x2cc, Type: dev
    function function_5d6480a0( localclientnum, weapon, weapon_model, weapon_name, var_2d8a24a3, var_e30bf49f )
    {
        if ( !isdefined( var_e30bf49f ) )
        {
            var_e30bf49f = 0;
        }
        
        camo_index = var_2d8a24a3.item_index == 0 ? 0 : function_8b51d9d1( hash( var_2d8a24a3.name ) );
        var_9ce34e01 = var_2d8a24a3.name;
        
        if ( isdefined( camo_index ) )
        {
            activecamoinfo = activecamo::function_ae141bf2( camo_index );
            
            if ( isdefined( activecamoinfo ) && activecamoinfo.stages.size > 1 )
            {
                var_3594168e = activecamoinfo.stages[ 2 ];
                
                if ( !is_true( var_3594168e.disabled ) )
                {
                    camo_index = function_8b51d9d1( var_3594168e.camooption );
                    var_9ce34e01 = function_9e72a96( var_3594168e.camooption );
                }
                else
                {
                    var_3594168e = undefined;
                }
            }
            
            if ( isdefined( level.var_43aac701[ localclientnum ] ) )
            {
                weapon_model stoprenderoverridebundle( level.var_43aac701[ localclientnum ] );
                level.var_43aac701[ localclientnum ] = undefined;
            }
            
            render_options = function_6eff28b5( camo_index, 0, var_e30bf49f, 0 );
            weapon_model useweaponmodel( weapon, undefined, render_options );
            
            if ( isdefined( var_3594168e ) )
            {
                activecamo::function_374e37a0( localclientnum, weapon_model, var_3594168e, level.var_43aac701 );
            }
            
            iteration = 0;
            
            do
            {
                wait 0.5;
                iteration++;
            }
            while ( !weapon_model isstreamed( 8, 4 ) && iteration < 1 );
            
            wait 2;
            function_da10fc8f( localclientnum, "<dev string:x26d>" + weapon_name + "<dev string:xdb>" + weapon_name + "<dev string:x280>" + var_9ce34e01 + "<dev string:xfb>" );
        }
    }

    // Namespace frontend/frontend
    // Params 3
    // Checksum 0x7a972711, Offset: 0x49c8
    // Size: 0x55c, Type: dev
    function function_f2c538de( localclientnum, *menu_name, state )
    {
        self notify( "<dev string:x285>" );
        self endon( "<dev string:x285>" );
        args = strtok( state, "<dev string:x11c>" );
        weapon_name = args[ 0 ];
        camo = int( args[ 1 ] );
        var_c58c03de = int( args[ 2 ] );
        filter = args[ 3 ];
        function_25485718();
        var_38b900c2 = getent( menu_name, "<dev string:x45>", "<dev string:x5d>" );
        var_51a0f339 = getent( menu_name, "<dev string:x6b>", "<dev string:x5d>" );
        var_38b900c2 show();
        var_51a0f339 hide();
        weapon = getweapon( weapon_name );
        target = struct::get( #"weapon_icon_staging" );
        weapon_model = spawn( menu_name, target.origin, "<dev string:x299>" );
        weapon_model.targetname = "<dev string:x2a9>";
        weapon_model.angles = target.angles;
        weapon_model sethighdetail();
        weapon_model useweaponmodel( weapon );
        s_info = customclass::function_3bff05ba( weapon );
        weapon_model setscale( s_info.scale );
        level thread scene::play( #"scene_frontend_weapon_camo_render" );
        
        if ( camo != -2 )
        {
            options = function_ea647602( "<dev string:x2c0>" );
            
            if ( camo == -1 )
            {
                start_index = 0;
                end_index = options.size - 1;
            }
            else
            {
                start_index = camo;
                end_index = camo;
            }
            
            for ( i = start_index; i <= end_index ; i++ )
            {
                var_2d8a24a3 = options[ i ];
                
                if ( filter != "<dev string:x2c8>" )
                {
                    category = function_57411076( var_2d8a24a3.name );
                    
                    if ( filter == "<dev string:x2d0>" )
                    {
                        if ( category != "<dev string:x2df>" && category != "<dev string:x2e7>" && category != "<dev string:x2ef>" )
                        {
                            continue;
                        }
                    }
                    else if ( category != filter )
                    {
                        continue;
                    }
                }
                
                function_5d6480a0( menu_name, weapon, weapon_model, weapon_name, var_2d8a24a3, 0 );
            }
        }
        
        if ( var_c58c03de != 0 )
        {
            if ( var_c58c03de == -1 )
            {
                start_index = 1;
                end_index = weapon.var_5b73038c;
            }
            else
            {
                start_index = var_c58c03de;
                end_index = var_c58c03de;
            }
            
            for ( i = start_index; i <= end_index ; i++ )
            {
                function_5d6480a0( menu_name, weapon, weapon_model, weapon_name, { #item_index:0, #name:"<dev string:x2f7>" + i }, i );
            }
        }
        
        level thread scene::stop( #"scene_frontend_weapon_camo_render" );
        level notify( "<dev string:x121>" + menu_name, { #menu:"<dev string:x305>", #status:"<dev string:x146>" } );
        weapon_model delete();
        setdvar( #"weap_render", "<dev string:x150>" );
        function_59013397();
    }

    // Namespace frontend/frontend
    // Params 1
    // Checksum 0x91cfb98c, Offset: 0x4f30
    // Size: 0x26, Type: dev
    function function_d583ca36( weapon )
    {
        return weapon.inventorytype == "<dev string:x318>";
    }

    // Namespace frontend/frontend
    // Params 1
    // Checksum 0xe847c7e7, Offset: 0x4f60
    // Size: 0x7ca, Type: dev
    function function_db3c4c69( localclientnum )
    {
        lui::function_969a2881( "<dev string:x305>", localclientnum, &function_f2c538de, 1, undefined, undefined, 0 );
        target = struct::get( #"weapon_icon_staging" );
        assert( isdefined( target ) );
        level.var_43aac701 = [];
        var_663588d = "<dev string:x323>";
        root_weapon = var_663588d + "<dev string:x33e>";
        a_weapons = enumerateweapons( "<dev string:x352>" );
        
        if ( !isdefined( a_weapons ) )
        {
            a_weapons = [];
        }
        
        a_weapons = array::filter( a_weapons, 1, &function_d583ca36 );
        
        foreach ( weapon in a_weapons )
        {
            name = getweaponname( weapon );
            var_ee63b362 = root_weapon + "<dev string:xdb>" + name;
            adddebugcommand( localclientnum, "<dev string:x219>" + var_ee63b362 + "<dev string:x35c>" + "<dev string:x367>" + "<dev string:x11c>" + name + "<dev string:x37b>" );
        }
        
        setdvar( #"hash_1311d7636a782655", "<dev string:x150>" );
        setdvar( #"weap_render", "<dev string:x150>" );
        var_c11ba901 = array( "<dev string:x2d0>", "<dev string:x2df>", "<dev string:x2e7>", "<dev string:x2ef>", "<dev string:x381>", "<dev string:x38b>", "<dev string:x397>" );
        weapon_name = "<dev string:x150>";
        var_f7a528f2 = "<dev string:x150>";
        
        while ( true )
        {
            wait 0.1;
            
            if ( getdvarstring( #"hash_1311d7636a782655", weapon_name ) != weapon_name )
            {
                weapon_name = getdvarstring( #"hash_1311d7636a782655" );
                
                if ( weapon_name != "<dev string:x150>" )
                {
                    foreach ( weapon in a_weapons )
                    {
                        name = getweaponname( weapon );
                        
                        if ( name != weapon_name )
                        {
                            continue;
                        }
                        
                        var_c001baa1 = var_663588d + "<dev string:xdb>" + name;
                        adddebugcommand( localclientnum, "<dev string:x219>" + var_c001baa1 + "<dev string:x3a0>" + "<dev string:x35c>" + "<dev string:x3aa>" + "<dev string:x11c>" + name + "<dev string:x11c>" + -1 + "<dev string:x11c>" + -1 + "<dev string:x11c>" + "<dev string:x2c8>" + "<dev string:x37b>" );
                        
                        for ( i = 0; i < var_c11ba901.size ; i++ )
                        {
                            type = var_c11ba901[ i ];
                            adddebugcommand( localclientnum, "<dev string:x219>" + var_c001baa1 + "<dev string:xdb>" + type + "<dev string:x3b9>" + 2 + i + "<dev string:x35c>" + "<dev string:x3aa>" + "<dev string:x11c>" + name + "<dev string:x11c>" + -1 + "<dev string:x11c>" + -1 + "<dev string:x11c>" + type + "<dev string:x37b>" );
                        }
                        
                        options = function_ea647602( "<dev string:x2c0>" );
                        
                        foreach ( i, option in options )
                        {
                            adddebugcommand( localclientnum, "<dev string:x219>" + var_c001baa1 + "<dev string:xdb>" + option.name + "<dev string:x35c>" + "<dev string:x3aa>" + "<dev string:x11c>" + name + "<dev string:x11c>" + i + "<dev string:x11c>" + 0 + "<dev string:x11c>" + "<dev string:x2c8>" + "<dev string:x37b>" );
                        }
                        
                        for ( i = 1; i < weapon.var_5b73038c ; i++ )
                        {
                            adddebugcommand( localclientnum, "<dev string:x219>" + var_c001baa1 + "<dev string:x3be>" + i + "<dev string:x35c>" + "<dev string:x3aa>" + "<dev string:x11c>" + name + "<dev string:x11c>" + -2 + "<dev string:x11c>" + i + "<dev string:x11c>" + "<dev string:x2c8>" + "<dev string:x37b>" );
                        }
                    }
                }
            }
            
            if ( getdvarstring( #"weap_render", var_f7a528f2 ) != var_f7a528f2 )
            {
                var_f7a528f2 = getdvarstring( #"weap_render" );
                
                if ( var_f7a528f2 != "<dev string:x150>" )
                {
                    level notify( "<dev string:x121>" + localclientnum, { #menu:"<dev string:x305>", #status:"<dev string:x263>", #state:var_f7a528f2 } );
                }
            }
        }
    }

    // Namespace frontend/frontend
    // Params 1
    // Checksum 0x72137d81, Offset: 0x5738
    // Size: 0xbc, Type: dev
    function function_3d29f330( localclientnum )
    {
        util::add_devgui( localclientnum, "<dev string:x3cd>" + "<dev string:x16c>", "<dev string:x3e2>" );
        
        while ( getdvarint( #"hash_2a806885aa30e65b", 0 ) == 0 )
        {
            wait 1;
        }
        
        util::remove_devgui( localclientnum, "<dev string:x3cd>" + "<dev string:x16c>" );
        function_ea9a5e69( localclientnum );
    }

    // Namespace frontend/frontend
    // Params 0
    // Checksum 0xb887fef1, Offset: 0x5800
    // Size: 0x1a, Type: dev
    function function_671eb8fa()
    {
        return [ 1:"<dev string:x40a>" ];
    }

    // Namespace frontend/frontend
    // Params 1
    // Checksum 0x348a406e, Offset: 0x5828
    // Size: 0x522, Type: dev
    function function_ea9a5e69( localclientnum )
    {
        lui::function_969a2881( "<dev string:x413>", localclientnum, &t10_lasers_mixlaser2_sn_droger, 1, undefined, undefined, 0 );
        var_2067e07 = function_671eb8fa();
        adddebugcommand( localclientnum, "<dev string:x219>" + "<dev string:x3cd>" + "<dev string:x427>" + "<dev string:x435>" + "<dev string:x11c>" + -1 + "<dev string:x11c>" + -1 + "<dev string:x37b>" );
        
        foreach ( type, name in var_2067e07 )
        {
            adddebugcommand( localclientnum, "<dev string:x219>" + "<dev string:x3cd>" + name + "<dev string:x35c>" + "<dev string:x435>" + "<dev string:x11c>" + -1 + "<dev string:x11c>" + type + "<dev string:x37b>" );
        }
        
        assert( isdefined( getent( localclientnum, "<dev string:x447>", "<dev string:x5d>" ) ) );
        assert( isdefined( struct::get( #"fx_trail_start" ) ) );
        assert( isdefined( struct::get( #"fx_trail_end" ) ) );
        jumpkits = namespace_eb06e24d::get_jumpkits();
        
        foreach ( i, jumpkit in jumpkits )
        {
            name = function_9e72a96( jumpkit );
            markswarzone = "<dev string:x3cd>" + name + "<dev string:xdb>";
            adddebugcommand( localclientnum, "<dev string:x219>" + markswarzone + "<dev string:x229>" + "<dev string:x35c>" + "<dev string:x435>" + "<dev string:x11c>" + i + "<dev string:x11c>" + -1 + "<dev string:x37b>" );
            
            foreach ( type, name in var_2067e07 )
            {
                adddebugcommand( localclientnum, "<dev string:x219>" + markswarzone + name + "<dev string:x35c>" + "<dev string:x435>" + "<dev string:x11c>" + i + "<dev string:x11c>" + type + "<dev string:x37b>" );
            }
            
            waitframe( 1 );
        }
        
        setdvar( #"hash_4243dd01393aa940", "<dev string:x150>" );
        var_f7a528f2 = "<dev string:x150>";
        
        while ( true )
        {
            wait 0.1;
            
            if ( getdvarstring( #"hash_4243dd01393aa940", var_f7a528f2 ) != var_f7a528f2 )
            {
                var_f7a528f2 = getdvarstring( #"hash_4243dd01393aa940" );
                
                if ( var_f7a528f2 != "<dev string:x150>" )
                {
                    level notify( "<dev string:x121>" + localclientnum, { #menu:"<dev string:x413>", #status:"<dev string:x263>", #state:var_f7a528f2 } );
                }
            }
        }
    }

    // Namespace frontend/frontend
    // Params 3
    // Checksum 0x7e9e3772, Offset: 0x5d58
    // Size: 0x64c, Type: dev
    function t10_lasers_mixlaser2_sn_droger( localclientnum, *menu_name, state )
    {
        self notify( "<dev string:x458>" );
        self endon( "<dev string:x458>" );
        args = strtok( state, "<dev string:x11c>" );
        jumpkit = int( args[ 0 ] );
        type = int( args[ 1 ] );
        function_25485718();
        var_38b900c2 = getent( menu_name, "<dev string:x45>", "<dev string:x5d>" );
        var_51a0f339 = getent( menu_name, "<dev string:x6b>", "<dev string:x5d>" );
        var_38b900c2 show();
        var_51a0f339 hide();
        
        if ( jumpkit == -1 )
        {
            var_d4e4e3a8 = 0;
            var_dcb0ef67 = namespace_eb06e24d::function_3045dd71() - 1;
        }
        else
        {
            var_d4e4e3a8 = jumpkit;
            var_dcb0ef67 = jumpkit;
        }
        
        types = function_671eb8fa();
        
        if ( type != -1 )
        {
            type_data = types[ type ];
            types = [];
            types[ type ] = type_data;
        }
        
        var_351da865 = getent( menu_name, "<dev string:x447>", "<dev string:x5d>" );
        fx_start = struct::get( #"fx_trail_start" );
        fx_end = struct::get( #"fx_trail_end" );
        
        foreach ( type, type_name in types )
        {
            switch ( type )
            {
                case 1:
                    level thread scene::play( #"scene_frontend_fxtrail_render" );
                    break;
                default:
                    continue;
            }
            
            for ( i = var_d4e4e3a8; i <= var_dcb0ef67 ; i++ )
            {
                kit_name = namespace_eb06e24d::get_jumpkits()[ i ];
                
                switch ( type )
                {
                    case 1:
                        trail = namespace_eb06e24d::function_6452f9c5( i );
                        
                        if ( !isdefined( trail ) || !isdefined( trail.body_trail ) )
                        {
                            continue;
                        }
                        
                        var_351da865.origin = fx_start.origin;
                        handle = util::playfxontag( menu_name, trail.body_trail, var_351da865, "<dev string:x46c>" );
                        
                        if ( !isdefined( handle ) )
                        {
                            continue;
                        }
                        
                        direction = fx_end.origin - fx_start.origin;
                        step_size = direction / getdvarint( #"hash_522e5987825dd16e", 100 );
                        
                        for ( var_d7f46807 = 0; var_d7f46807 <= getdvarint( #"hash_522e5987825dd16e", 100 ) ; var_d7f46807++ )
                        {
                            waitframe( 1 );
                            var_351da865.origin += step_size;
                        }
                        
                        function_da10fc8f( menu_name, "<dev string:x47a>" + function_9e72a96( kit_name ) + "<dev string:xdb>" + function_9e72a96( trail.name ) + "<dev string:x48e>" );
                        killfx( menu_name, handle );
                        break;
                    default:
                        continue;
                }
                
                waitframe( 1 );
            }
            
            switch ( type )
            {
                case 1:
                    level thread scene::stop( #"scene_frontend_fxtrail_render" );
                default:
                    break;
            }
        }
        
        level notify( "<dev string:x121>" + menu_name, { #menu:"<dev string:x413>", #status:"<dev string:x146>" } );
        setdvar( #"hash_4243dd01393aa940", "<dev string:x150>" );
        function_59013397();
    }

#/

// Namespace frontend/frontend
// Params 1
// Checksum 0xc78b9e3a, Offset: 0x63b0
// Size: 0xdc
function function_8567daf2( localclientnum )
{
    /#
        var_cd31cd6a = getdvarstring( #"hash_575aeb603638c901", "<dev string:x150>" );
        
        if ( var_cd31cd6a != "<dev string:x150>" )
        {
            return getweapon( var_cd31cd6a );
        }
    #/
    
    var_bba3d6af = function_a699aed5( localclientnum );
    
    if ( isdefined( var_bba3d6af ) && var_bba3d6af.weapon !== level.weaponnone )
    {
        return var_bba3d6af.weapon;
    }
    
    return getweapon( #"ar_accurate_t9" );
}

// Namespace frontend/frontend
// Params 1
// Checksum 0x35a4f7e9, Offset: 0x6498
// Size: 0x86
function function_1fa47915( localclientnum )
{
    /#
        var_cd31cd6a = getdvarstring( #"hash_575aeb603638c901", "<dev string:x150>" );
        
        if ( var_cd31cd6a != "<dev string:x150>" )
        {
            return undefined;
        }
    #/
    
    var_bba3d6af = function_a699aed5( localclientnum );
    return var_bba3d6af.render_options;
}

// Namespace frontend/frontend
// Params 1
// Checksum 0x53499586, Offset: 0x6528
// Size: 0xcc
function function_65d7f2a7( localclientnum )
{
    target_name = "player_start";
    var_50896672 = getent( localclientnum, target_name, "targetname" );
    
    if ( !isdefined( var_50896672 ) )
    {
        var_50896672 = util::spawn_model( localclientnum, "tag_origin" );
        var_50896672.targetname = target_name;
    }
    
    var_50896672 useanimtree( "all_player" );
    level.var_1c43dd3e = character_customization::function_dd295310( var_50896672, localclientnum, 0 );
    function_aba0885b( localclientnum );
}

// Namespace frontend/frontend
// Params 1
// Checksum 0x330a71d, Offset: 0x6600
// Size: 0x6c
function function_becded4f( localclientnum )
{
    level.var_44011752 = util::spawn_model( localclientnum, #"wpn_t8_ar_accurate_prop_animate", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    level.var_44011752.targetname = "customized_inspection_weapon";
    level.var_44011752 hide();
}

// Namespace frontend/frontend
// Params 1
// Checksum 0x8d764bae, Offset: 0x6678
// Size: 0x90
function function_a588eb2e( localclientnum )
{
    var_e6977977 = util::spawn_model( localclientnum, #"wpn_t8_ar_accurate_prop_animate", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_e6977977.targetname = "quartermaster_weapon";
    var_e6977977 hide();
    var_e6977977 sethighdetail( 1, 1 );
    level.var_324c3190 = [];
}

// Namespace frontend/frontend
// Params 1
// Checksum 0xd30ca535, Offset: 0x6710
// Size: 0x36c
function localclientconnect( localclientnum )
{
    println( "<dev string:x496>" + localclientnum );
    var_acd4d941 = util::spawn_model( localclientnum, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_acd4d941.targetname = "__masked_char";
    var_22f20461 = character_customization::function_dd295310( var_acd4d941, localclientnum, 0 );
    [[ var_22f20461 ]]->function_1ec9448d( 1 );
    [[ var_22f20461 ]]->update();
    level.specialist_customization = function_f2e7abdc( localclientnum, "updateSpecialistCustomization" );
    level thread scene::play( #"scene_frontend_inspection_weapon", "inspection_weapon_full" );
    function_becded4f( localclientnum );
    function_a588eb2e( localclientnum );
    setupclientmenus( localclientnum );
    function_65d7f2a7( localclientnum );
    level thread function_f00ff0c7( localclientnum );
    level thread function_45827126();
    
    if ( isdefined( level.charactercustomizationsetup ) )
    {
        [[ level.charactercustomizationsetup ]]( localclientnum );
    }
    
    if ( isdefined( level.weaponcustomizationiconsetup ) )
    {
        [[ level.weaponcustomizationiconsetup ]]( localclientnum );
    }
    
    callback::callback( #"on_localclient_connect", localclientnum );
    customclass::localclientconnect( localclientnum );
    roommodel = getuimodel( function_5f72e972( #"lobby_root" ), "room" );
    room = getuimodelvalue( roommodel );
    postfx::setfrontendstreamingoverlay( localclientnum, "frontend", 1 );
    level.frontendclientconnected = 1;
    level notify( "menu_change" + localclientnum, { #menu:"PressStart", #status:"opened", #state:room } );
    
    /#
        level function_92087f1b( localclientnum );
        level thread function_db3c4c69( localclientnum );
        level thread function_3d29f330( localclientnum );
        level thread function_90646a7f( localclientnum );
    #/
}

// Namespace frontend/frontend
// Params 0
// Checksum 0x80f724d1, Offset: 0x6a88
// Size: 0x4
function onprecachegametype()
{
    
}

// Namespace frontend/frontend
// Params 0
// Checksum 0x80f724d1, Offset: 0x6a98
// Size: 0x4
function onstartgametype()
{
    
}

// Namespace frontend/frontend
// Params 2
// Checksum 0xc35f798d, Offset: 0x6aa8
// Size: 0x44
function open_choose_class( localclientnum, menu_data )
{
    level thread character_customization::rotation_thread_spawner( localclientnum, menu_data.custom_character, "choose_class_closed" + localclientnum );
}

// Namespace frontend/frontend
// Params 2
// Checksum 0x4c6e50db, Offset: 0x6af8
// Size: 0x5a
function close_choose_class( localclientnum, *menu_data )
{
    enablefrontendlockedweaponoverlay( menu_data, 0 );
    enablefrontendtokenlockedweaponoverlay( menu_data, 0 );
    level notify( "choose_class_closed" + menu_data );
}

// Namespace frontend/frontend
// Params 4
// Checksum 0xc4cbbf64, Offset: 0x6b60
// Size: 0x40a
function function_d3cd6cf7( localclientnum, var_d0b01271, waitresult, params )
{
    fields = [[ var_d0b01271 ]]->function_e8b0acef();
    
    if ( isdefined( fields ) )
    {
        params.scene = fields.hubscene;
        params.var_401d9a1 = 1;
        params.var_c76f3e47 = 1;
        params.var_d8cb38a9 = 1;
        
        if ( lui::is_current_menu( localclientnum, "ItemShopDetails" ) || lui::is_current_menu( localclientnum, "ContractDetails" ) || lui::is_current_menu( localclientnum, "BlackMarketBountyDetails" ) )
        {
            params.scene_target = struct::get( #"tag_align_quartermaster" );
            params.anim_name = [[ var_d0b01271 ]]->function_8144231c();
            params.align_struct = struct::get( #"tag_align_quartermaster_character" );
            params.scene = undefined;
            return;
        }
        
        if ( lui::is_current_menu( localclientnum, "PersonalizeDefaultWZCharacter" ) || lui::is_current_menu( localclientnum, "WZPersonalizeCharacter" ) )
        {
            params.scene = fields.var_bb70c379;
            params.scene_target = struct::get( #"cac_specialist" );
            return;
        }
        
        if ( lui::is_current_menu( localclientnum, "PersonalizeCharacter" ) || lui::is_current_menu( localclientnum, "WZPersonalizeCharacterInspect" ) )
        {
            params.scene_target = struct::get( #"cac_specialist" );
            params.scene = fields.var_bb70c379;
            params.var_f5332569 = [[ var_d0b01271 ]]->function_98d70bef();
            return;
        }
        
        if ( lui::is_current_menu( localclientnum, "ZMPersonalizeCharacter" ) )
        {
            params.scene_target = struct::get( #"cac_specialist" );
            params.scene = fields.var_bb70c379;
            return;
        }
        
        if ( lui::is_current_menu( localclientnum, "AARMissionRewardOverlay", waitresult.character_index ) )
        {
            params.scene = fields.var_be6ea125;
            params.scene_target = struct::get( #"hash_dd8a67627ed7326" );
            return;
        }
        
        if ( lui::is_current_menu( localclientnum, "MPSpecialistHUBGestures" ) )
        {
            params.anim_name = [[ var_d0b01271 ]]->function_8144231c();
            params.align_struct = struct::get( #"cac_specialist" );
            params.scene = undefined;
            return;
        }
        
        if ( lui::is_current_menu( localclientnum, "WeaponDeathFxSelect" ) )
        {
            params.anim_name = [[ var_d0b01271 ]]->function_8144231c();
            params.align_struct = struct::get( #"cac_specialist" );
            params.scene = undefined;
            return;
        }
        
        params.scene_target = struct::get( #"cac_specialist" );
    }
}

// Namespace frontend/frontend
// Params 2
// Checksum 0x62b5e72a, Offset: 0x6f78
// Size: 0xf4
function function_f2e7abdc( localclientnum, notifyname )
{
    var_20e9ec07 = struct::get( #"cac_specialist" );
    
    if ( isdefined( var_20e9ec07 ) )
    {
        specialistmodel = util::spawn_model( localclientnum, "tag_origin", var_20e9ec07.origin, var_20e9ec07.angles );
        specialistmodel.targetname = "specialist_customization";
        var_f3b86f32 = character_customization::function_dd295310( specialistmodel, localclientnum, 0 );
        [[ var_f3b86f32 ]]->set_character_mode( 1 );
        level thread character_customization::updateeventthread( localclientnum, var_f3b86f32, notifyname, &function_d3cd6cf7 );
        return var_f3b86f32;
    }
    
    return undefined;
}

// Namespace frontend/frontend
// Params 2
// Checksum 0x75ca23c8, Offset: 0x7078
// Size: 0x64
function open_character_menu( localclientnum, menu_data )
{
    character_ent = getent( localclientnum, menu_data.target_name, "targetname" );
    
    if ( isdefined( character_ent ) )
    {
        character_ent show();
    }
}

// Namespace frontend/frontend
// Params 2
// Checksum 0x3b576eac, Offset: 0x70e8
// Size: 0x64
function close_character_menu( localclientnum, menu_data )
{
    character_ent = getent( localclientnum, menu_data.target_name, "targetname" );
    
    if ( isdefined( character_ent ) )
    {
        character_ent hide();
    }
}

// Namespace frontend/frontend
// Params 2
// Checksum 0xe1d17220, Offset: 0x7158
// Size: 0x54
function start_character_rotating_any( localclientnum, menu_data )
{
    maxlocalclient = getmaxlocalclients();
    
    while ( localclientnum < maxlocalclient )
    {
        start_character_rotating( localclientnum, menu_data );
        localclientnum++;
    }
}

// Namespace frontend/frontend
// Params 2
// Checksum 0x2f44b85a, Offset: 0x71b8
// Size: 0x54
function end_character_rotating_any( localclientnum, menu_data )
{
    maxlocalclient = getmaxlocalclients();
    
    while ( localclientnum < maxlocalclient )
    {
        end_character_rotating( localclientnum, menu_data );
        localclientnum++;
    }
}

// Namespace frontend/frontend
// Params 2
// Checksum 0x20a3610, Offset: 0x7218
// Size: 0x44
function start_character_rotating( localclientnum, menu_data )
{
    level thread character_customization::rotation_thread_spawner( localclientnum, menu_data.custom_character, "end_character_rotating" + localclientnum );
}

// Namespace frontend/frontend
// Params 2
// Checksum 0x7a210337, Offset: 0x7268
// Size: 0x2a
function end_character_rotating( localclientnum, *menu_data )
{
    level notify( "end_character_rotating" + menu_data );
}

// Namespace frontend/frontend
// Params 2
// Checksum 0x6cfbe08d, Offset: 0x72a0
// Size: 0x1f8
function personalize_characters_watch( localclientnum, menu_name )
{
    level endon( #"disconnect" );
    level endon( menu_name + "_closed" );
    s_cam = struct::get( #"personalizehero_camera", "targetname" );
    assert( isdefined( s_cam ) );
    
    for ( animtime = 0; true ; animtime = 300 )
    {
        waitresult = level waittill( "camera_change" + localclientnum );
        pose = waitresult.pose;
        
        if ( pose === "exploring" )
        {
            playmaincamxcam( localclientnum, #"ui_cam_character_customization", animtime, "cam_preview", "", s_cam.origin, s_cam.angles );
            continue;
        }
        
        if ( pose === "inspecting_helmet" )
        {
            playmaincamxcam( localclientnum, #"ui_cam_character_customization", animtime, "cam_helmet", "", s_cam.origin, s_cam.angles );
            continue;
        }
        
        if ( pose === "inspecting_body" )
        {
            playmaincamxcam( localclientnum, #"ui_cam_character_customization", animtime, "cam_select", "", s_cam.origin, s_cam.angles );
        }
    }
}

// Namespace frontend/frontend
// Params 2
// Checksum 0xc65ecd78, Offset: 0x74a0
// Size: 0x2d8
function function_d9a44ae1( localclientnum, menu_name )
{
    level endon( #"disconnect" );
    level endon( menu_name + "_closed" );
    s_cam = struct::get( #"spawn_char_custom", "targetname" );
    assert( isdefined( s_cam ) );
    playmaincamxcam( localclientnum, #"ui_cam_character_customization", 0, "cam_helmet", "", s_cam.origin, s_cam.angles );
    
    while ( true )
    {
        waitresult = level waittill( "choose_face_camera_change" + localclientnum );
        region = waitresult.param1;
        
        if ( region === "face" )
        {
            playmaincamxcam( localclientnum, #"ui_cam_character_customization", 300, "cam_helmet", "", s_cam.origin, s_cam.angles );
            continue;
        }
        
        if ( region === "eyes" )
        {
            playmaincamxcam( localclientnum, #"ui_cam_character_customization", 300, "cam_eyes", "", s_cam.origin, s_cam.angles );
            continue;
        }
        
        if ( region === "ears" )
        {
            playmaincamxcam( localclientnum, #"ui_cam_character_customization", 300, "cam_ears", "", s_cam.origin, s_cam.angles );
            continue;
        }
        
        if ( region === "nose" )
        {
            playmaincamxcam( localclientnum, #"ui_cam_character_customization", 300, "cam_nose", "", s_cam.origin, s_cam.angles );
            continue;
        }
        
        if ( region === "mouth" )
        {
            playmaincamxcam( localclientnum, #"ui_cam_character_customization", 300, "cam_mouth", "", s_cam.origin, s_cam.angles );
        }
    }
}

// Namespace frontend/frontend
// Params 2
// Checksum 0x8efa4bec, Offset: 0x7780
// Size: 0x1a4
function choose_taunts_camera_watch( localclientnum, menu_name )
{
    s_cam = struct::get( #"personalizehero_camera", "targetname" );
    assert( isdefined( s_cam ) );
    playmaincamxcam( localclientnum, #"ui_cam_character_customization", 300, "cam_topscorers", "", s_cam.origin, s_cam.angles );
    var_d0b01271 = lui::function_daadc836( menu_name, localclientnum );
    [[ var_d0b01271 ]]->function_4240a39a( 1, ( 0, 112, 0 ) );
    level waittill( menu_name + "_closed" );
    params = { #anim_name:[[ var_d0b01271 ]]->function_8144231c() };
    [[ var_d0b01271 ]]->update( params );
    [[ var_d0b01271 ]]->function_4240a39a( 0, undefined );
    playmaincamxcam( localclientnum, #"ui_cam_character_customization", 300, "cam_preview", "", s_cam.origin, s_cam.angles );
    wait 3;
}

// Namespace frontend/frontend
// Params 2
// Checksum 0x1cab5aca, Offset: 0x7930
// Size: 0x118
function function_b0442428( var_ce754e62, var_3f0e790b )
{
    if ( isdefined( var_ce754e62 ) && isdefined( var_ce754e62[ var_3f0e790b ] ) )
    {
        foreach ( object in var_ce754e62[ var_3f0e790b ] )
        {
            var_2d0192e5 = [[ object.character ]]->function_82e05d64();
            
            if ( isdefined( var_2d0192e5 ) && isdefined( var_2d0192e5.entnummodel ) && isdefined( [[ object.character ]]->function_217b10ed() ) )
            {
                setuimodelvalue( var_2d0192e5.entnummodel, [[ object.character ]]->function_47cb6b19() );
            }
        }
    }
}

// Namespace frontend/frontend
// Params 2
// Checksum 0xdbeb754e, Offset: 0x7a50
// Size: 0xf0
function function_f5eca51d( var_ce754e62, var_3f0e790b )
{
    if ( isdefined( var_ce754e62 ) && isdefined( var_ce754e62[ var_3f0e790b ] ) )
    {
        foreach ( object in var_ce754e62[ var_3f0e790b ] )
        {
            var_2d0192e5 = [[ object.character ]]->function_82e05d64();
            
            if ( isdefined( var_2d0192e5 ) && isdefined( var_2d0192e5.entnummodel ) )
            {
                setuimodelvalue( var_2d0192e5.entnummodel, -1 );
            }
        }
    }
}

// Namespace frontend/frontend
// Params 3
// Checksum 0xd20c8360, Offset: 0x7b48
// Size: 0x254
function function_e1f85a64( ccobject, index, var_3f0e790b )
{
    lobbyclientmodel = function_5f72e972( #"lobby_clients" );
    var_c4caf9dd = getuimodel( lobbyclientmodel, string( index + 1 ) );
    
    if ( !isdefined( var_c4caf9dd ) )
    {
        return;
    }
    
    [[ ccobject ]]->function_82e05d64().entnummodel = createuimodel( var_c4caf9dd, "entNum" );
    [[ ccobject ]]->function_82e05d64().var_3f0e790b = var_3f0e790b;
    [[ ccobject ]]->function_184a4d2e( &function_8be87802 );
    entnum = getuimodelvalue( [[ ccobject ]]->function_82e05d64().entnummodel );
    
    if ( !isdefined( entnum ) )
    {
        setuimodelvalue( [[ ccobject ]]->function_82e05d64().entnummodel, [[ ccobject ]]->function_47cb6b19() );
    }
    
    [[ ccobject ]]->function_82e05d64().visible_model = getuimodel( var_c4caf9dd, "visible" );
    setuimodelvalue( [[ ccobject ]]->function_82e05d64().visible_model, [[ ccobject ]]->function_ea4ac9f8() && [[ ccobject ]]->is_visible() );
    var_2097336a = createuimodel( var_c4caf9dd, "sprayGestureIndex" );
    [[ ccobject ]]->function_82e05d64().var_5da50127 = var_2097336a;
    setuimodelvalue( var_2097336a, isdefined( getuimodelvalue( var_2097336a ) ) ? getuimodelvalue( var_2097336a ) : -1 );
}

// Namespace frontend/frontend
// Params 6
// Checksum 0x2a6f3179, Offset: 0x7da8
// Size: 0x29c
function function_f00765ad( localclientnum, xuid, ccobject, index, var_3f0e790b, var_2451e8ac )
{
    self notify( "6fb391dd5fda3f92" );
    self endon( "6fb391dd5fda3f92" );
    level endon( #"lobby_change", #"disconnect" );
    iterations = 0;
    var_a65df30 = [[ ccobject ]]->function_e599283f();
    current_index = [[ ccobject ]]->get_character_index();
    [[ ccobject ]]->show_model();
    [[ ccobject ]]->set_xuid( xuid );
    [[ ccobject ]]->set_character_mode( 1 );
    var_23904c1d = getcharactercustomizationforxuid( localclientnum, xuid );
    
    while ( !isdefined( var_23904c1d ) && iterations < 15 )
    {
        wait 1;
        var_23904c1d = getcharactercustomizationforxuid( localclientnum, xuid );
        iterations++;
    }
    
    if ( !isdefined( var_23904c1d ) || var_23904c1d.charactermode != currentsessionmode() || !function_b9f8bbd9( var_23904c1d.charactertype, var_23904c1d.charactermode ) )
    {
        var_23904c1d = undefined;
        character_index = function_e3efec59( localclientnum, xuid, 1, var_3f0e790b, undefined );
        
        if ( isdefined( character_index ) )
        {
            [[ ccobject ]]->set_character_index( character_index );
        }
    }
    
    if ( isdefined( var_23904c1d ) )
    {
        if ( character_customization::function_aa5382ed( var_23904c1d, var_a65df30, 0 ) )
        {
            function_c033e4cc( localclientnum, var_2451e8ac, ccobject, index, var_23904c1d );
        }
    }
    else
    {
        [[ ccobject ]]->set_character_index( character_index );
        [[ ccobject ]]->function_22039feb();
        function_c033e4cc( localclientnum, var_2451e8ac, ccobject, index );
    }
    
    function_e1f85a64( ccobject, index, var_3f0e790b );
}

// Namespace frontend/frontend
// Params 5
// Checksum 0x25841b48, Offset: 0x8050
// Size: 0x174
function function_c033e4cc( localclientnum, var_2451e8ac, ccobject, index, var_7f395102 )
{
    if ( isdefined( var_2451e8ac ) )
    {
        switch ( var_2451e8ac )
        {
            case #"character_change":
                level thread function_90cad834( localclientnum, 0, var_7f395102 );
                break;
            case #"lobby_intro":
                if ( isdefined( var_7f395102 ) )
                {
                    [[ ccobject ]]->function_15a8906a( var_7f395102 );
                }
                
                level thread function_c47e078a( 1, index, ccobject, localclientnum );
                break;
            case #"lobby_idle":
            default:
                if ( isdefined( var_7f395102 ) )
                {
                    [[ ccobject ]]->function_15a8906a( var_7f395102 );
                }
                
                level thread function_c47e078a( 0, index, ccobject, localclientnum );
                break;
        }
        
        return;
    }
    
    params = { #var_c76f3e47:1, #var_401d9a1:1 };
    [[ ccobject ]]->update( params );
}

// Namespace frontend/frontend
// Params 3
// Checksum 0xf7fc6733, Offset: 0x81d0
// Size: 0x1ce
function function_7c77108d( localclientnum, &var_13ef9467, var_63aea26e )
{
    for ( i = 0; true ; i++ )
    {
        target = struct::get( var_63aea26e + i );
        
        if ( !isdefined( target ) )
        {
            break;
        }
        
        charactermodel = util::spawn_model( localclientnum, "tag_origin", target.origin, target.angles );
        charactermodel.targetname = var_63aea26e + "character_" + i;
        
        if ( is_true( level.var_633071d0 ) && i == 0 && isclass( level.var_1c43dd3e ) )
        {
            var_a4fe2697 = level.var_1c43dd3e;
        }
        else
        {
            var_a4fe2697 = character_customization::function_dd295310( charactermodel, localclientnum, 0 );
        }
        
        var_ac2e02ac = { #target:target, #character:var_a4fe2697, #scene_name:undefined };
        
        if ( !isdefined( var_13ef9467 ) )
        {
            var_13ef9467 = [];
        }
        else if ( !isarray( var_13ef9467 ) )
        {
            var_13ef9467 = array( var_13ef9467 );
        }
        
        var_13ef9467[ var_13ef9467.size ] = var_ac2e02ac;
    }
    
    return i;
}

// Namespace frontend/frontend
// Params 2
// Checksum 0x5c498a25, Offset: 0x83a8
// Size: 0x114
function function_8be87802( *localclientnum, character )
{
    var_2d0192e5 = [[ character ]]->function_82e05d64();
    
    if ( !( isdefined( var_2d0192e5 ) && isdefined( var_2d0192e5.entnummodel ) ) )
    {
        return;
    }
    
    var_c2ab6c5b = function_f701ad2a();
    
    if ( var_2d0192e5.var_3f0e790b === var_c2ab6c5b )
    {
        setuimodelvalue( var_2d0192e5.entnummodel, [[ character ]]->function_47cb6b19() );
    }
    
    if ( isdefined( var_2d0192e5.var_3f0e790b ) && isdefined( var_c2ab6c5b ) && var_2d0192e5.var_3f0e790b != var_c2ab6c5b )
    {
        character_customization::function_bee62aa1( character );
    }
    
    setuimodelvalue( var_2d0192e5.visible_model, [[ character ]]->function_ea4ac9f8() && [[ character ]]->is_visible() );
}

// Namespace frontend/frontend
// Params 0
// Checksum 0x25f337ed, Offset: 0x84c8
// Size: 0x70
function function_45827126()
{
    level endon( #"disconnect" );
    
    while ( true )
    {
        waitresult = level waittill( #"hash_6f2435126950e914" );
        battlechatter::function_ad01601e( waitresult.localclientnum, waitresult.characterindex );
    }
}

// Namespace frontend/frontend
// Params 1
// Checksum 0xea3f78b5, Offset: 0x8540
// Size: 0x708
function function_f00ff0c7( localclientnum )
{
    level endon( #"disconnect" );
    var_11302f48 = function_5f72e972( #"hash_5573c0775fbf1bb1" );
    level.var_6f1da91a = [ [], [], [], [] ];
    var_6aeec2ad = getdvarstring( #"hash_52abdac1a234fa29", "" );
    var_c7581878 = function_7c77108d( localclientnum, level.var_6f1da91a[ 0 ], "lobby_player" + var_6aeec2ad + "_" );
    var_c7581878 = max( function_7c77108d( localclientnum, level.var_6f1da91a[ 1 ], "lobby_player" + var_6aeec2ad + "_" ), var_c7581878 );
    var_c7581878 = max( function_7c77108d( localclientnum, level.var_6f1da91a[ 2 ], "lobby_player" + var_6aeec2ad + "_" ), var_c7581878 );
    var_c7581878 = max( function_7c77108d( localclientnum, level.var_6f1da91a[ 3 ], "lobby_player" + var_6aeec2ad + "_" ), var_c7581878 );
    level.var_90fa1c3e = var_c7581878;
    var_68a9a63c = [];
    
    while ( true )
    {
        var_6b002e4d = var_68a9a63c.size;
        waitresult = level waittill( #"lobby_change" );
        
        if ( level.lastlobbystate === #"matchmaking" || level.lastlobbystate === #"zm_online" || level.lastlobbystate === #"lobby_pose" )
        {
            var_68a9a63c = function_664bca26( localclientnum, 1, 0 );
        }
        else
        {
            var_68a9a63c = function_77ccb73( 1 );
        }
        
        var_3d095a85 = var_68a9a63c.size;
        
        if ( is_true( waitresult.var_a3325423 ) || is_true( waitresult.var_2c5ad26b ) )
        {
            for ( i = 0; i < var_c7581878 ; i++ )
            {
                if ( i < var_68a9a63c.size )
                {
                    setuimodelvalue( getuimodel( var_11302f48, string( i ) ), var_68a9a63c[ i ] );
                    
                    foreach ( var_3f0e790b, character_array in level.var_6f1da91a )
                    {
                        var_7d4d74d3 = i > character_array.size ? undefined : character_array[ i ];
                        
                        if ( isdefined( var_7d4d74d3 ) )
                        {
                            if ( level.lastlobbystate === #"room1" || level.lastlobbystate === #"room2" )
                            {
                                continue;
                            }
                            
                            if ( level.lastlobbystate === #"character_room" && i == 0 )
                            {
                                var_2451e8ac = #"character_change";
                            }
                            else if ( function_50806385( i ) && sessionmodeisonlinegame() && is_true( waitresult.var_a3325423 ) && var_3d095a85 > var_6b002e4d && i >= var_6b002e4d )
                            {
                                var_2451e8ac = #"lobby_intro";
                            }
                            else if ( function_50806385( i ) )
                            {
                                var_2451e8ac = #"lobby_idle";
                            }
                            
                            var_7d4d74d3.target thread function_f00765ad( localclientnum, var_68a9a63c[ i ], var_7d4d74d3.character, i, var_3f0e790b, var_2451e8ac );
                        }
                    }
                    
                    continue;
                }
                
                foreach ( var_3f0e790b, character_array in level.var_6f1da91a )
                {
                    var_7d4d74d3 = i > character_array.size ? undefined : character_array[ i ];
                    
                    if ( isclass( var_7d4d74d3.character ) && isdefined( [[ var_7d4d74d3.character ]]->function_217b10ed() ) )
                    {
                        [[ var_7d4d74d3.character ]]->hide_model();
                    }
                }
            }
            
            forcenotifyuimodel( var_11302f48 );
        }
        
        character_array = level.var_6f1da91a[ function_f701ad2a() ];
        
        if ( isdefined( character_array ) )
        {
            for ( i = 0; i < var_c7581878 ; i++ )
            {
                if ( i < var_68a9a63c.size )
                {
                    var_7d4d74d3 = i > character_array.size ? undefined : character_array[ i ];
                    
                    if ( isdefined( var_7d4d74d3 ) && ( function_34fbc01b() || function_4fd0d58e() ) )
                    {
                        function_8be87802( localclientnum, var_7d4d74d3.character );
                    }
                }
            }
        }
    }
}

// Namespace frontend/frontend
// Params 1
// Checksum 0x4c178928, Offset: 0x8c50
// Size: 0xe4, Type: bool
function function_50806385( n_index )
{
    if ( ( level.lastlobbystate === #"loadout_room" || level.lastlobbystate === #"character_room" || level.lastlobbystate === #"armory" ) && n_index != 0 || level.lastlobbystate === #"lobby_pose" || level.lastlobbystate === #"arena_pose" || level.lastlobbystate === #"private_lobby_pose" )
    {
        return true;
    }
    
    return false;
}

// Namespace frontend/frontend
// Params 0
// Checksum 0x12eb4968, Offset: 0x8d40
// Size: 0xaa, Type: bool
function function_34fbc01b()
{
    if ( level.lastlobbystate === #"lobby_pose" || level.lastlobbystate === #"private_lobby_pose" || level.lastlobbystate === #"character_room" || level.lastlobbystate === #"armory" || level.lastlobbystate === #"loadout_room" )
    {
        return true;
    }
    
    return false;
}

// Namespace frontend/frontend
// Params 0
// Checksum 0xd141b996, Offset: 0x8df8
// Size: 0x8a, Type: bool
function function_4fd0d58e()
{
    if ( level.lastlobbystate === #"arena_pose" || level.lastlobbystate === #"character_room" || level.lastlobbystate === #"armory" || level.lastlobbystate === #"loadout_room" )
    {
        return true;
    }
    
    return false;
}

// Namespace frontend/frontend
// Params 2
// Checksum 0x171fc86b, Offset: 0x8e90
// Size: 0x124
function function_b1b8f767( localclientnum, play )
{
    if ( play )
    {
        function_b0442428( level.var_6f1da91a, 0 );
        var_bf321a0c = !isdefined( level.lastlobbystate ) || level.lastlobbystate == "room2" || level.lastlobbystate == "mode_select";
        var_f647c5b2 = var_bf321a0c ? "intro" : undefined;
        function_aba0885b( localclientnum );
        function_c47e078a( var_bf321a0c, 0, undefined, localclientnum );
        return;
    }
    
    if ( !play )
    {
        function_f5eca51d( level.var_6f1da91a, 0 );
        level.var_bf1b1528 = undefined;
        [[ level.var_1c43dd3e ]]->show_model();
    }
}

// Namespace frontend/frontend
// Params 4
// Checksum 0xbd4ad294, Offset: 0x8fc0
// Size: 0x504
function function_c47e078a( var_bf321a0c = 1, var_302876c9 = 0, character, localclientnum )
{
    level notify( #"hash_250179ae4bc30aef" + var_302876c9 );
    level endon( #"hash_250179ae4bc30aef" + var_302876c9, #"hash_9a862f4c6d59905" );
    level scene::cancel( #"scene_frontend_start" );
    
    if ( !isdefined( character ) )
    {
        if ( var_302876c9 == 0 )
        {
            character = level.var_1c43dd3e;
        }
        else
        {
            character = level.var_6f1da91a[ function_f701ad2a() ][ var_302876c9 ].character;
        }
    }
    
    str_scene = function_cfb00e7d( var_302876c9 );
    a_str_shots = scene::get_all_shot_names( str_scene );
    var_78651d54 = [];
    var_fc395698 = [];
    
    foreach ( str_shot in a_str_shots )
    {
        if ( strstartswith( tolower( str_shot ), "intro" ) )
        {
            if ( !isdefined( var_78651d54 ) )
            {
                var_78651d54 = [];
            }
            else if ( !isarray( var_78651d54 ) )
            {
                var_78651d54 = array( var_78651d54 );
            }
            
            var_78651d54[ var_78651d54.size ] = str_shot;
        }
        
        if ( strstartswith( tolower( str_shot ), "idle" ) )
        {
            if ( !isdefined( var_fc395698 ) )
            {
                var_fc395698 = [];
            }
            else if ( !isarray( var_fc395698 ) )
            {
                var_fc395698 = array( var_fc395698 );
            }
            
            var_fc395698[ var_fc395698.size ] = str_shot;
        }
    }
    
    if ( var_bf321a0c )
    {
        var_f647c5b2 = array::random( var_78651d54 );
        var_559c5c3e = strreplace( var_f647c5b2, "intro", "idle" );
        assert( isinarray( var_fc395698, var_559c5c3e ), "<dev string:x4c6>" + var_559c5c3e + "<dev string:x4ee>" + function_9e72a96( str_scene ) + "<dev string:x4f6>" + var_f647c5b2 );
        
        if ( !isinarray( var_fc395698, var_559c5c3e ) )
        {
            var_559c5c3e = array::random( var_fc395698 );
        }
    }
    else
    {
        var_559c5c3e = array::random( var_fc395698 );
    }
    
    if ( !var_bf321a0c && [[ character ]]->function_1f70adfe() === var_559c5c3e )
    {
        var_b8f75d74 = [[ character ]]->function_98d70bef();
    }
    
    if ( var_302876c9 == 0 )
    {
        weapon = function_8567daf2( localclientnum );
        var_5b38793b = function_1fa47915( localclientnum );
    }
    
    params = { #var_c76f3e47:1, #var_401d9a1:1, #scene:str_scene, #var_74741b75:var_f647c5b2, #var_a68ab9c2:var_559c5c3e, #var_a34c858c:1, #var_f5332569:var_b8f75d74, #activeweapon:weapon, #var_b8f20727:var_5b38793b };
    [[ character ]]->update( params );
}

// Namespace frontend/frontend
// Params 1
// Checksum 0x8b22c018, Offset: 0x94d0
// Size: 0x166
function function_cfb00e7d( n_index )
{
    assert( isdefined( n_index ), "<dev string:x50b>" );
    
    switch ( n_index )
    {
        case 0:
            str_scene = #"scene_frontend_t9_lobby_player1";
            break;
        case 1:
            str_scene = #"scene_frontend_t9_lobby_player2";
            break;
        case 2:
            str_scene = #"scene_frontend_t9_lobby_player3";
            break;
        case 3:
            str_scene = #"scene_frontend_t9_lobby_player4";
            break;
        case 4:
            str_scene = #"scene_frontend_t9_lobby_player5";
            break;
        case 5:
            str_scene = #"scene_frontend_t9_lobby_player6";
            break;
        default:
            assertmsg( "<dev string:x529>" + n_index );
            break;
    }
    
    return str_scene;
}

// Namespace frontend/frontend
// Params 2
// Checksum 0x70d8838c, Offset: 0x9640
// Size: 0x114
function function_db9d479f( *localclientnum, play )
{
    var_bfe5e572 = struct::get( #"arena_align_tag" );
    
    if ( isdefined( var_bfe5e572 ) )
    {
        if ( play )
        {
            var_bfe5e572.var_e8b5aff5 = 1;
            function_b0442428( level.var_6f1da91a, 1 );
            var_bfe5e572 thread scene::play( "scene_frontend_arena_team" );
            return;
        }
        
        if ( !play && is_true( var_bfe5e572.var_e8b5aff5 ) )
        {
            var_bfe5e572.var_e8b5aff5 = 0;
            function_f5eca51d( level.var_6f1da91a, 1 );
            var_bfe5e572 thread scene::stop( "scene_frontend_arena_team", 1 );
        }
    }
}

// Namespace frontend/frontend
// Params 3
// Checksum 0xb7224756, Offset: 0x9760
// Size: 0xc4
function toggle_postfx( localclientnum, on_off, postfx )
{
    player = function_5c10bd79( localclientnum );
    
    if ( on_off && !player postfx::function_556665f2( postfx ) )
    {
        player codeplaypostfxbundle( postfx );
        return;
    }
    
    if ( !on_off && player postfx::function_556665f2( postfx ) )
    {
        player codestoppostfxbundle( postfx );
    }
}

// Namespace frontend/frontend
// Params 3
// Checksum 0x940aa8e6, Offset: 0x9830
// Size: 0x388
function lobby_main( localclientnum, menu_name, state )
{
    level endon( menu_name + "_closed" );
    
    if ( state == #"room1" || state == #"room2" )
    {
        level function_4431001a( localclientnum, "start", menu_name );
    }
    else if ( state == #"mode_select" )
    {
        level function_4431001a( localclientnum, "main", menu_name );
    }
    else
    {
        level function_4431001a( localclientnum );
    }
    
    if ( state == #"matchmaking" && level.lastlobbystate !== #"matchmaking" )
    {
        level notify( #"lobby_change", { #var_a3325423:1 } );
    }
    else if ( state == #"lobby_pose" || state == #"private_lobby_pose" || state == #"arena_pose" )
    {
        level notify( #"lobby_change", { #var_a3325423:1 } );
        function_b1b8f767( localclientnum, 1 );
    }
    else if ( state == #"inspect_specialist" && level.lastlobbystate !== #"inspect_specialist" )
    {
        waitframe( 1 );
        var_aa16ae79 = getuimodel( function_1df4c3b0( localclientnum, #"hash_3e045efc97005502" ), "ChosenSpecialistID" );
        
        for ( character_index = getuimodelvalue( var_aa16ae79 ); !isdefined( character_index ) || character_index == 0 ; character_index = getuimodelvalue( var_aa16ae79 ) )
        {
            wait 0.1;
        }
        
        level notify( "menu_change" + localclientnum, { #menu:"directorTraining", #status:"opened", #state:character_index, #mode:1 } );
    }
    
    if ( !isdefined( state ) || state != #"room1" )
    {
        setallcontrollerslightbarcolor();
        level notify( #"end_controller_pulse" );
    }
    
    level.lastlobbystate = state;
}

// Namespace frontend/frontend
// Params 0
// Checksum 0xf575403d, Offset: 0x9bc0
// Size: 0x70
function function_f701ad2a()
{
    if ( sessionmodeiswarzonegame() )
    {
        return 3;
    }
    
    if ( sessionmodeiszombiesgame() )
    {
        return 2;
    }
    
    if ( function_34fbc01b() )
    {
        return 0;
    }
    else if ( function_4fd0d58e() )
    {
        return 1;
    }
    
    return -1;
}

// Namespace frontend/frontend
// Params 1
// Checksum 0xc6ef875e, Offset: 0x9c38
// Size: 0x18e
function function_79ac87ac( clientnum )
{
    var_f33f3800 = self function_a5248552();
    
    if ( isarray( level.var_6f1da91a ) && var_f33f3800.size > 0 )
    {
        var_91389554 = function_f701ad2a();
        
        if ( !isdefined( var_91389554 ) || var_91389554 < 0 )
        {
            var_91389554 = 0;
        }
        
        var_b2694f96 = level.var_6f1da91a[ var_91389554 ];
        
        foreach ( var_c1468bbf, s_obj in var_f33f3800 )
        {
            var_bf735535 = var_b2694f96[ var_c1468bbf ];
            
            if ( !isdefined( var_bf735535 ) )
            {
                continue;
            }
            
            if ( self == s_obj )
            {
                self._e_array[ clientnum ] = [[ var_bf735535.character ]]->function_217b10ed();
                
                if ( var_c1468bbf != 0 )
                {
                    self.var_8bba7189 = 1;
                }
                
                break;
            }
        }
    }
}

// Namespace frontend/frontend
// Params 0
// Checksum 0xf756f3b1, Offset: 0x9dd0
// Size: 0xfa
function function_a5248552()
{
    var_f33f3800 = [];
    
    foreach ( s_obj in self._o_scene._a_objects )
    {
        if ( s_obj._s.type === #"player" )
        {
            if ( !isdefined( var_f33f3800 ) )
            {
                var_f33f3800 = [];
            }
            else if ( !isarray( var_f33f3800 ) )
            {
                var_f33f3800 = array( var_f33f3800 );
            }
            
            var_f33f3800[ var_f33f3800.size ] = s_obj;
        }
    }
    
    return var_f33f3800;
}

/#

    // Namespace frontend/frontend
    // Params 1
    // Checksum 0x20101756, Offset: 0x9ed8
    // Size: 0x2c, Type: dev
    function update_room2_devgui( localclientnum )
    {
        level thread mp_devgui::remove_mp_contracts_devgui( localclientnum );
    }

    // Namespace frontend/frontend
    // Params 2
    // Checksum 0xd164969b, Offset: 0x9f10
    // Size: 0x74, Type: dev
    function update_mp_lobby_room_devgui( localclientnum, state )
    {
        if ( state == "<dev string:x554>" || state == "<dev string:x561>" )
        {
            level thread mp_devgui::create_mp_contracts_devgui( localclientnum );
            return;
        }
        
        level mp_devgui::remove_mp_contracts_devgui( localclientnum );
    }

#/

// Namespace frontend/frontend
// Params 0
// Checksum 0xe99a0729, Offset: 0x9f90
// Size: 0xc6
function pulse_controller_color()
{
    level endon( #"end_controller_pulse" );
    delta_t = -0.01;
    t = 1;
    
    while ( true )
    {
        setallcontrollerslightbarcolor( ( 1 * t, 0.2 * t, 0 ) );
        t += delta_t;
        
        if ( t < 0.2 || t > 0.99 )
        {
            delta_t *= -1;
        }
        
        waitframe( 1 );
    }
}

// Namespace frontend/frontend
// Params 1
// Checksum 0x26c2502a, Offset: 0xa060
// Size: 0x7a
function function_74e1ca20( str_notify )
{
    if ( level.lastlobbystate === #"character_room" && str_notify === #"hash_248ca22abc6b78ed" && isdefined( level.var_debe8147 ) )
    {
        [[ level.var_1c43dd3e ]]->function_15a8906a( level.var_debe8147 );
        level.var_debe8147 = undefined;
    }
}

// Namespace frontend/frontend
// Params 3
// Checksum 0xc27de607, Offset: 0xa0e8
// Size: 0x350
function function_90cad834( localclientnum, var_3449052c = 0, var_7f395102 )
{
    level notify( #"hash_53d7a69385304e8" );
    level endoncallback( &function_74e1ca20, #"hash_53d7a69385304e8", #"hash_248ca22abc6b78ed", #"disconnect" );
    waittillframeend();
    level scene::cancel( #"scene_frontend_t9_character" );
    weapon = function_8567daf2( localclientnum );
    var_5b38793b = function_1fa47915( localclientnum );
    
    if ( var_3449052c )
    {
        if ( isdefined( level.var_debe8147 ) )
        {
            var_b8f75d74 = [[ level.var_1c43dd3e ]]->function_98d70bef();
        }
        
        level.var_debe8147 = var_7f395102;
        params = { #var_a34c858c:1, #scene:#"scene_frontend_t9_character", #var_74741b75:"select_outro", #var_99a89f83:1, #var_f5332569:var_b8f75d74, #activeweapon:weapon, #var_b8f20727:var_5b38793b };
        [[ level.var_1c43dd3e ]]->update( params );
        var_c74251a4 = scene::function_8582657c( #"scene_frontend_t9_character", "select_outro" );
        
        if ( isdefined( var_b8f75d74 ) )
        {
            n_wait_time = var_c74251a4 - var_b8f75d74 * var_c74251a4;
            wait n_wait_time;
        }
        else
        {
            wait var_c74251a4;
        }
        
        if ( isdefined( var_7f395102 ) )
        {
            [[ level.var_1c43dd3e ]]->function_15a8906a( var_7f395102 );
        }
        
        var_f647c5b2 = "select_intro";
    }
    else if ( isdefined( var_7f395102 ) )
    {
        var_f647c5b2 = "select_intro";
        [[ level.var_1c43dd3e ]]->function_15a8906a( var_7f395102 );
    }
    
    level.var_debe8147 = undefined;
    params = { #var_a34c858c:1, #scene:#"scene_frontend_t9_character", #var_74741b75:var_f647c5b2, #var_a68ab9c2:"select_idle", #var_99a89f83:1, #activeweapon:weapon, #var_b8f20727:var_5b38793b };
    [[ level.var_1c43dd3e ]]->update( params );
}

// Namespace frontend/frontend
// Params 7
// Checksum 0xa29263ca, Offset: 0xa440
// Size: 0x29c
function function_67dbdad( localclientnum, menu_name, str_scene, var_f647c5b2, var_559c5c3e, var_77e970fa = 1, var_dd5c339d = 1 )
{
    level notify( #"hash_779b1d50d2895b97" );
    level endon( #"hash_779b1d50d2895b97", #"disconnect" );
    
    if ( isdefined( menu_name ) )
    {
        level endon( menu_name + "_closed" );
    }
    
    var_61fe779c = getuimodel( function_5f72e972( #"director_global" ), "globalSelectedCharacterIndex" );
    var_1dfa126c = 1;
    
    while ( true )
    {
        var_c0a8925e = getuimodelvalue( var_61fe779c );
        
        if ( !isdefined( var_c0a8925e ) )
        {
            var_c0a8925e = 2;
        }
        
        if ( var_c0a8925e == 0 )
        {
            var_c0a8925e = 2;
        }
        
        if ( isdefined( var_c0a8925e ) && ( var_c0a8925e !== level.var_f7aea3ff || var_1dfa126c ) )
        {
            var_1dfa126c = 0;
            localxuid = function_9bed6a71( localclientnum, 1 );
            player_data = function_25f808c9( localclientnum, 1, var_c0a8925e );
            
            if ( !isdefined( player_data ) )
            {
                player_data = character_customization::function_3f5625f1( 1, var_c0a8925e );
            }
            
            [[ level.var_1c43dd3e ]]->function_15a8906a( player_data );
            params = { #var_401d9a1:var_77e970fa, #var_c76f3e47:var_dd5c339d, #scene:str_scene, #var_74741b75:var_f647c5b2, #var_a68ab9c2:var_559c5c3e };
            [[ level.var_1c43dd3e ]]->update( params );
            level.var_f7aea3ff = var_c0a8925e;
        }
        
        wait 0.1;
    }
}

// Namespace frontend/frontend
// Params 1
// Checksum 0xd5cfab30, Offset: 0xa6e8
// Size: 0x114
function function_aba0885b( localclientnum )
{
    var_61fe779c = getuimodel( function_5f72e972( #"director_global" ), "globalSelectedCharacterIndex" );
    var_c0a8925e = getuimodelvalue( var_61fe779c );
    
    if ( !isdefined( var_c0a8925e ) )
    {
        var_c0a8925e = 2;
    }
    
    if ( var_c0a8925e == 0 )
    {
        var_c0a8925e = 2;
    }
    
    if ( var_c0a8925e !== level.var_f7aea3ff )
    {
        player_data = function_25f808c9( localclientnum, 1, var_c0a8925e );
        
        if ( !isdefined( player_data ) )
        {
            player_data = character_customization::function_3f5625f1( 1, var_c0a8925e );
        }
        
        [[ level.var_1c43dd3e ]]->function_15a8906a( player_data );
        level.var_f7aea3ff = var_c0a8925e;
    }
}

// Namespace frontend/frontend
// Params 3
// Checksum 0x4c801860, Offset: 0xa808
// Size: 0x70
function function_4431001a( localclientnum, scene_shot, menu_name )
{
    if ( isdefined( scene_shot ) )
    {
        level childthread function_67dbdad( localclientnum, menu_name, #"scene_frontend_start", undefined, scene_shot );
        return;
    }
    
    level notify( #"hash_779b1d50d2895b97" );
}

// Namespace frontend/frontend
// Params 3
// Checksum 0x25f7253e, Offset: 0xa880
// Size: 0x136
function function_9602c423( localclientnum, menu_name, state )
{
    var_d0b01271 = lui::function_daadc836( menu_name, localclientnum );
    [[ var_d0b01271 ]]->show_model();
    camera_ent = struct::get( #"cac_specialist_angle" );
    playmaincamxcam( localclientnum, #"ui_cam_character_gesture", 0, "", "", camera_ent.origin, camera_ent.angles );
    
    if ( isdefined( state ) )
    {
        [[ var_d0b01271 ]]->set_character_index( state );
        level notify( "updateSpecialistCustomization" + localclientnum, { #event_name:"changeHero", #character_index:state, #mode:currentsessionmode() } );
    }
}

// Namespace frontend/frontend
// Params 3
// Checksum 0xee98b056, Offset: 0xa9c0
// Size: 0x126
function function_25b060af( localclientnum, menu_name, state )
{
    var_d0b01271 = lui::function_daadc836( menu_name, localclientnum );
    [[ var_d0b01271 ]]->show_model();
    camera_ent = struct::get( #"cac_specialist_angle" );
    playmaincamxcam( localclientnum, #"ui_cam_loadout_character", 0, "", "", camera_ent.origin, camera_ent.angles );
    
    if ( isdefined( state ) )
    {
        [[ var_d0b01271 ]]->set_character_index( state );
        level notify( "updateSpecialistCustomization" + localclientnum, { #event_name:"changeHero", #character_index:state, #mode:1 } );
    }
}

// Namespace frontend/frontend
// Params 3
// Checksum 0xfff5067, Offset: 0xaaf0
// Size: 0x1c6
function function_f8cec907( localclientnum, menu_name, state )
{
    var_d0b01271 = lui::function_daadc836( menu_name, localclientnum );
    [[ var_d0b01271 ]]->show_model();
    camera_ent = struct::get( #"hash_dd8a67627ed7326" );
    playmaincamxcam( localclientnum, #"ui_scene_cam_wz_unlock", 0, "", "", camera_ent.origin, camera_ent.angles );
    
    if ( isdefined( state ) )
    {
        args = strtok( state, ";" );
        char_index = int( isdefined( args[ 0 ] ) ? args[ 0 ] : 0 );
        outfit_index = int( isdefined( args[ 1 ] ) ? args[ 1 ] : 0 );
        [[ var_d0b01271 ]]->set_character_mode( 3 );
        [[ var_d0b01271 ]]->set_character_index( char_index );
        level notify( "updateSpecialistCustomization" + localclientnum, { #event_name:"changeOutfit", #outfit_index:outfit_index } );
    }
}

// Namespace frontend/frontend
// Params 2
// Checksum 0x76ddeb34, Offset: 0xacc0
// Size: 0xb4
function function_a8095769( localclientnum, menu_name )
{
    var_d0b01271 = lui::function_daadc836( menu_name, localclientnum );
    [[ var_d0b01271 ]]->show_model();
    camera_ent = struct::get( #"tag_align_quartermaster" );
    playmaincamxcam( localclientnum, #"ui_cam_store_camera", 0, "", "", camera_ent.origin, camera_ent.angles );
}

// Namespace frontend/frontend
// Params 2
// Checksum 0xb9de9365, Offset: 0xad80
// Size: 0xdc
function function_7142469f( localclientnum, *menu_data )
{
    level notify( #"blackmarket_closed" );
    level thread scene::stop( level.var_d29ac799, 1 );
    level.var_d29ac799 = undefined;
    
    if ( isdefined( level.var_c7cd91f5 ) )
    {
        stopradiantexploder( menu_data, level.var_c7cd91f5 );
        level.var_c7cd91f5 = undefined;
    }
    
    season = getdvarstring( #"mtx_seasonal_exploder" );
    stopradiantexploder( menu_data, "fxexp_mtx_ambient" + season );
}

// Namespace frontend/frontend
// Params 3
// Checksum 0x2837ad15, Offset: 0xae68
// Size: 0x27a
function function_3e7aaaea( localclientnum, weapon_model, waitresult )
{
    self notify( "6acb5d09ccacc723" );
    self endon( "6acb5d09ccacc723" );
    level endon( #"qmweaponupdate" );
    var_9d7ee952 = getdvarint( #"hash_41ef264ae8370dc7", 5 );
    activecamoinfo = activecamo::function_ae141bf2( waitresult.activecamoindex );
    
    if ( isdefined( activecamoinfo ) && activecamoinfo.stages.size > 1 )
    {
        for ( stage = 0; true ; stage = ( stage + 1 ) % activecamoinfo.stages.size )
        {
            if ( isdefined( level.var_324c3190[ localclientnum ] ) )
            {
                weapon_model stoprenderoverridebundle( level.var_324c3190[ localclientnum ] );
                level.var_324c3190[ localclientnum ] = undefined;
            }
            
            var_3594168e = activecamoinfo.stages[ stage ];
            
            if ( !isdefined( var_3594168e.disabled ) || var_3594168e.disabled == 0 )
            {
                stagecamoindex = function_8b51d9d1( var_3594168e.camooption );
                render_options = function_6eff28b5( stagecamoindex, 0, waitresult.model_idx, 0 );
                weapon = getweapon( waitresult.weapon_ref );
                var_2d45743e = customclass::function_5f70d1c8( weapon );
                weapon_model useweaponmodel( weapon, undefined, render_options );
                weapon_model setscale( var_2d45743e.scale );
                activecamo::function_374e37a0( localclientnum, weapon_model, var_3594168e, level.var_324c3190 );
                wait var_9d7ee952;
            }
        }
    }
}

// Namespace frontend/frontend
// Params 2
// Checksum 0xf6f8a1dd, Offset: 0xb0f0
// Size: 0x288
function function_98088878( localclientnum, menu_data )
{
    level endon( menu_data.menu_name + "_closed" );
    season = getdvarstring( #"mtx_seasonal_exploder" );
    playradiantexploder( localclientnum, "fxexp_mtx_ambient" + season );
    weapon_model = getent( localclientnum, "quartermaster_weapon", "targetname" );
    var_7ef44086 = struct::get( "tag_align_quartermaster_weapon" );
    
    while ( true )
    {
        waitresult = level waittill( #"qmweaponupdate" );
        
        if ( isdefined( level.var_324c3190[ localclientnum ] ) )
        {
            weapon_model stoprenderoverridebundle( level.var_324c3190[ localclientnum ] );
            level.var_324c3190[ localclientnum ] = undefined;
        }
        
        camoindex = 0;
        
        if ( isdefined( waitresult.camoindex ) )
        {
            camoindex = waitresult.camoindex;
        }
        
        render_options = function_6eff28b5( camoindex, 0, waitresult.model_idx, 0 );
        weapon = getweapon( waitresult.weapon_ref );
        var_2d45743e = customclass::function_5f70d1c8( weapon );
        weapon_model useweaponmodel( weapon, undefined, render_options );
        weapon_model setscale( var_2d45743e.scale );
        weapon_model.origin = var_7ef44086.origin + var_2d45743e.offset;
        weapon_model.angles = var_7ef44086.angles;
        
        if ( isdefined( waitresult.activecamoindex ) )
        {
            childthread function_3e7aaaea( localclientnum, weapon_model, waitresult );
        }
    }
}

// Namespace frontend/frontend
// Params 3
// Checksum 0x6c836e2, Offset: 0xb380
// Size: 0x4b4
function function_837446a8( localclientnum, menu_name, state )
{
    var_d0b01271 = lui::function_daadc836( menu_name, localclientnum );
    weapon_model = getent( localclientnum, "quartermaster_weapon", "targetname" );
    level notify( "end_character_rotating" + localclientnum );
    
    switch ( state )
    {
        case #"character":
        case #"gesture":
            [[ var_d0b01271 ]]->function_4240a39a( 1, ( 0, 90, 0 ) );
            level thread character_customization::rotation_thread_spawner( localclientnum, var_d0b01271, "end_character_rotating" + localclientnum );
            [[ var_d0b01271 ]]->function_4240a39a( 0 );
            [[ var_d0b01271 ]]->show_model();
            weapon_model hide();
            scene = #"scene_frontend_quartermaster_character";
            break;
        case #"character_full":
            [[ var_d0b01271 ]]->function_4240a39a( 1, ( 0, 90, 0 ) );
            level thread character_customization::rotation_thread_spawner( localclientnum, var_d0b01271, "end_character_rotating" + localclientnum );
            [[ var_d0b01271 ]]->function_4240a39a( 0 );
            [[ var_d0b01271 ]]->show_model();
            weapon_model hide();
            scene = #"scene_frontend_quartermaster_character_full";
            break;
        case #"character_face":
            [[ var_d0b01271 ]]->function_4240a39a( 1, ( 0, 90, 0 ) );
            level thread character_customization::rotation_thread_spawner( localclientnum, var_d0b01271, "end_character_rotating" + localclientnum );
            [[ var_d0b01271 ]]->function_4240a39a( 0 );
            [[ var_d0b01271 ]]->show_model();
            weapon_model hide();
            scene = #"scene_frontend_quartermaster_character_face";
            break;
        case #"weapon":
            [[ var_d0b01271 ]]->hide_model();
            weapon_model show();
            scene = #"scene_frontend_quartermaster_weapon";
            break;
        case #"crate":
            [[ var_d0b01271 ]]->hide_model();
            weapon_model hide();
            season = getdvarstring( #"mtx_seasonal_exploder" );
            scene = #"scene_frontend_quartermaster_crate" + season;
            exploder = "fxexp_mtx_crate" + season;
            break;
        default:
            [[ var_d0b01271 ]]->hide_model();
            weapon_model hide();
            scene = #"scene_frontend_quartermaster";
            break;
    }
    
    if ( level.var_c7cd91f5 !== exploder )
    {
        if ( isdefined( level.var_c7cd91f5 ) )
        {
            stopradiantexploder( localclientnum, level.var_c7cd91f5 );
        }
        
        if ( isdefined( exploder ) )
        {
            playradiantexploder( localclientnum, exploder );
        }
        
        level.var_c7cd91f5 = exploder;
    }
    
    if ( level.var_d29ac799 !== scene )
    {
        if ( isdefined( level.var_d29ac799 ) )
        {
            level scene::stop( level.var_d29ac799, 1 );
        }
        
        level.var_d29ac799 = scene;
        level thread scene::play( level.var_d29ac799 );
    }
}

// Namespace frontend/frontend
// Params 3
// Checksum 0x7a83a98a, Offset: 0xb840
// Size: 0xdc
function function_36962bc4( localclientnum, menu_name, *state )
{
    self notify( "8a71fe307b68bb1" );
    self endon( "8a71fe307b68bb1" );
    var_d0b01271 = lui::function_daadc836( state, menu_name );
    [[ var_d0b01271 ]]->show_model();
    camera_ent = struct::get( #"cac_specialist_angle" );
    playmaincamxcam( menu_name, #"ui_cam_character_customization_3d", 0, "", "", camera_ent.origin, camera_ent.angles );
}

// Namespace frontend/frontend
// Params 3
// Checksum 0x1fc54c6a, Offset: 0xb928
// Size: 0x144
function function_8ad37038( localclientnum, menu_name, state )
{
    self notify( "77ec3385e86c5eae" );
    self endon( "77ec3385e86c5eae" );
    var_d0b01271 = lui::function_daadc836( menu_name, localclientnum );
    
    if ( isdefined( state ) )
    {
        [[ var_d0b01271 ]]->set_character_index( state );
        level notify( "updateSpecialistCustomization" + localclientnum, { #event_name:"changeHero", #character_index:state, #mode:3 } );
    }
    
    [[ var_d0b01271 ]]->show_model();
    camera_ent = struct::get( #"cac_specialist_angle" );
    playmaincamxcam( localclientnum, #"ui_cam_loadout_character", 0, "", "", camera_ent.origin, camera_ent.angles );
}

// Namespace frontend/frontend
// Params 3
// Checksum 0x7bdcaec4, Offset: 0xba78
// Size: 0x8c
function function_bc98f036( localclientnum, *menu_name, *state )
{
    camera_ent = struct::get( #"cac_specialist_angle" );
    playmaincamxcam( state, #"ui_cam_character_customization_3d", 0, "", "", camera_ent.origin, camera_ent.angles );
}

// Namespace frontend/frontend
// Params 2
// Checksum 0x525dbf78, Offset: 0xbb10
// Size: 0x2c
function function_5e7dcbed( *localclientnum, menu_data )
{
    [[ menu_data.custom_character ]]->function_1ec9448d( 0 );
}

// Namespace frontend/frontend
// Params 3
// Checksum 0xb6b26206, Offset: 0xbb48
// Size: 0xcc
function function_ac9a8cf( localclientnum, menu_name, *state )
{
    camera_ent = struct::get( #"cac_specialist_angle" );
    playmaincamxcam( menu_name, #"ui_cam_character_customization_3d", 0, "", "", camera_ent.origin, camera_ent.angles );
    var_d0b01271 = lui::function_daadc836( state, menu_name );
    level thread function_914198cd( menu_name, var_d0b01271, state );
}

// Namespace frontend/frontend
// Params 3
// Checksum 0xc777f2c5, Offset: 0xbc20
// Size: 0x14e
function function_914198cd( localclientnum, var_d0b01271, menu_name )
{
    level endon( #"disconnect" );
    level endon( menu_name + "_closed" );
    
    while ( true )
    {
        waitresult = level waittill( "deathfx_update_" + localclientnum );
        
        switch ( waitresult.event_name )
        {
            case #"updatecharacter":
                var_d0b01271 function_79c881da( localclientnum, waitresult.mode );
                break;
            case #"previewdeathfx":
                var_d0b01271 notify( #"cancel_deathfx" );
                var_d0b01271 thread function_317ab257( localclientnum, menu_name, waitresult.deathfxindex );
                break;
            case #"stopdeathfx":
                var_d0b01271 function_ca43d336( localclientnum );
                break;
        }
    }
}

// Namespace frontend/frontend
// Params 2
// Checksum 0xe73e41eb, Offset: 0xbd78
// Size: 0xac
function function_79c881da( localclientnum, mode )
{
    [[ self ]]->set_character_index( 1 );
    [[ self ]]->function_22039feb();
    [[ self ]]->function_1ec9448d( 1 );
    
    if ( isdefined( mode ) )
    {
        [[ self ]]->set_character_mode( mode );
    }
    
    [[ self ]]->show_model();
    params = {};
    function_d3cd6cf7( localclientnum, self, {}, params );
    [[ self ]]->update( params );
}

// Namespace frontend/frontend
// Params 3
// Checksum 0xdb6f6ca3, Offset: 0xbe30
// Size: 0x4be
function function_317ab257( localclientnum, menu_name, var_83a11058 )
{
    self notify( "2d6d7780e95cc7d5" );
    self endon( "2d6d7780e95cc7d5" );
    level endon( #"disconnect" );
    level endon( menu_name + "_closed" );
    self endon( #"cancel_deathfx" );
    var_cc8a3490 = #"hash_521de69029125f63";
    var_7d89d45 = #"hash_33ffd8c85b4da392";
    var_e04a6c21 = #"hash_4c04b62047703a60";
    
    if ( ![[ self ]]->function_ea4ac9f8() )
    {
        return;
    }
    
    var_2ae2bfde = function_b52a94ae( var_83a11058 );
    
    if ( isdefined( var_2ae2bfde ) )
    {
        var_cc8a3490 = isdefined( var_2ae2bfde.var_cc8a3490 ) ? var_2ae2bfde.var_cc8a3490 : #"hash_521de69029125f63";
        var_7d89d45 = isdefined( var_2ae2bfde.var_7d89d45 ) ? var_2ae2bfde.var_7d89d45 : #"hash_521de69029125f63";
        var_e04a6c21 = isdefined( var_2ae2bfde.var_e04a6c21 ) ? var_2ae2bfde.var_e04a6c21 : #"hash_4c04b62047703a60";
    }
    
    self function_ca43d336( localclientnum );
    v_default = ( 0, 0, 0 );
    v_forward = ( 90, 0, 0 );
    character_model = [[ self ]]->function_217b10ed();
    
    if ( isdefined( character_model ) )
    {
        var_5f26f63 = character_model gettagangles( "j_spine4" );
        body_origin = character_model gettagorigin( "j_spine4" );
        
        if ( isdefined( var_5f26f63 ) && isdefined( body_origin ) )
        {
            var_5f26f63 += v_forward;
            body_origin += anglestoforward( ( 0, var_5f26f63[ 1 ], 0 ) );
            [[ self ]]->function_82e05d64().var_d35ebd8e = playfx( localclientnum, var_cc8a3490, body_origin, anglestoforward( var_5f26f63 ), anglestoup( var_5f26f63 ) );
            wait 0.3;
        }
    }
    
    character_model = [[ self ]]->function_217b10ed();
    
    if ( isdefined( character_model ) )
    {
        var_bee5328d = character_model gettagangles( "j_neck" );
        var_78a78382 = character_model gettagorigin( "j_neck" );
        
        if ( isdefined( var_bee5328d ) && isdefined( var_78a78382 ) )
        {
            var_bee5328d += v_forward;
            var_78a78382 += anglestoforward( ( 0, var_bee5328d[ 1 ], 0 ) );
            [[ self ]]->function_82e05d64().var_bef648d0 = playfx( localclientnum, var_7d89d45, var_78a78382, anglestoforward( var_bee5328d ), anglestoup( var_bee5328d ) );
            wait 0.5;
        }
    }
    
    character_model = [[ self ]]->function_217b10ed();
    
    if ( isdefined( character_model ) )
    {
        var_7110530b = character_model gettagangles( "j_head" );
        var_ad65ea66 = character_model gettagorigin( "j_head" );
        
        if ( isdefined( var_7110530b ) && isdefined( var_ad65ea66 ) )
        {
            var_7110530b += v_forward;
            var_ad65ea66 += anglestoforward( ( 0, var_7110530b[ 1 ], 0 ) );
            [[ self ]]->function_82e05d64().var_21cb8ea6 = playfx( localclientnum, var_e04a6c21, var_ad65ea66, anglestoforward( var_7110530b ), anglestoup( var_7110530b ) );
        }
    }
}

// Namespace frontend/frontend
// Params 1
// Checksum 0x14e4c037, Offset: 0xc2f8
// Size: 0x11a
function function_ca43d336( localclientnum )
{
    if ( isdefined( [[ self ]]->function_82e05d64().var_d35ebd8e ) )
    {
        killfx( localclientnum, [[ self ]]->function_82e05d64().var_d35ebd8e );
        [[ self ]]->function_82e05d64().var_d35ebd8e = undefined;
    }
    
    if ( isdefined( [[ self ]]->function_82e05d64().var_bef648d0 ) )
    {
        killfx( localclientnum, [[ self ]]->function_82e05d64().var_bef648d0 );
        [[ self ]]->function_82e05d64().var_bef648d0 = undefined;
    }
    
    if ( isdefined( [[ self ]]->function_82e05d64().var_21cb8ea6 ) )
    {
        killfx( localclientnum, [[ self ]]->function_82e05d64().var_21cb8ea6 );
        [[ self ]]->function_82e05d64().var_21cb8ea6 = undefined;
    }
}

// Namespace frontend/frontend
// Params 3
// Checksum 0xa6b3c93f, Offset: 0xc420
// Size: 0x234
function function_73b8462a( localclientnum, menu_name, state )
{
    var_d0b01271 = lui::function_daadc836( menu_name, localclientnum );
    
    if ( state === "character" )
    {
        [[ var_d0b01271 ]]->show_model();
    }
    else
    {
        [[ var_d0b01271 ]]->hide_model();
    }
    
    session_mode = currentsessionmode();
    
    if ( session_mode == 4 )
    {
        return;
    }
    
    character_index = getequippedheroindex( localclientnum, session_mode );
    
    if ( isdefined( character_index ) )
    {
        fields = getcharacterfields( character_index, session_mode );
    }
    
    if ( isdefined( fields ) && isdefined( fields.aarscene ) )
    {
        level.var_c8fac6ea = fields.aarscene;
    }
    else if ( currentsessionmode() == 0 )
    {
        level.var_c8fac6ea = "scene_frontend_aar";
    }
    else if ( currentsessionmode() == 3 )
    {
        level.var_c8fac6ea = "scene_frontend_aar";
    }
    else if ( util::is_arena_lobby() )
    {
        level.var_c8fac6ea = "scene_frontend_aar";
    }
    else
    {
        level.var_c8fac6ea = "scene_frontend_aar";
    }
    
    if ( !level scene::is_playing( level.var_c8fac6ea ) )
    {
        [[ var_d0b01271 ]]->set_character_mode( session_mode );
        [[ var_d0b01271 ]]->set_character_index( character_index );
        [[ var_d0b01271 ]]->function_77e3be08();
        [[ var_d0b01271 ]]->update( undefined );
        level thread scene::play( level.var_c8fac6ea );
    }
}

// Namespace frontend/frontend
// Params 2
// Checksum 0x5b12f4f5, Offset: 0xc660
// Size: 0x4e
function function_48fb04a7( *localclientnum, *menu_name )
{
    if ( isdefined( level.var_c8fac6ea ) )
    {
        level thread scene::stop( level.var_c8fac6ea );
        level.var_c8fac6ea = undefined;
    }
}

// Namespace frontend/frontend
// Params 2
// Checksum 0x1b385145, Offset: 0xc6b8
// Size: 0x36
function function_3dde055b( localclientnum, *new_menu )
{
    var_d0b01271 = lui::function_daadc836( "MPSpecialistHUBPreviewMoment", new_menu );
}

// Namespace frontend/frontend
// Params 2
// Checksum 0x5ff32059, Offset: 0xc6f8
// Size: 0x14
function function_c4db2740( *localclientnum, *prev_menu )
{
    
}

// Namespace frontend/frontend
// Params 2
// Checksum 0x19685964, Offset: 0xc718
// Size: 0x14
function function_fad4ce33( *localclientnum, *entities )
{
    
}

// Namespace frontend/frontend
// Params 2
// Checksum 0xd8ec680, Offset: 0xc738
// Size: 0x14
function function_c5cbf7d6( *localclientnum, *entities )
{
    
}

