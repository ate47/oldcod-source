#using script_35ae72be7b4fec10;
#using script_3dc93ca9902a9cda;
#using script_4937c6974f43bb71;
#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\bb;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\ui\prompts;
#using scripts\cp_common\util;

#namespace dialog_tree;

// Namespace dialog_tree/dialog_tree
// Params 0, eflags: 0x6
// Checksum 0xbe984b0e, Offset: 0x3d0
// Size: 0x34
function private autoexec __init__system__()
{
    system::register( "dialog_tree", &preinit, undefined, undefined, undefined );
}

// Namespace dialog_tree/dialog_tree
// Params 0, eflags: 0x4
// Checksum 0xd4269db, Offset: 0x410
// Size: 0x164
function private preinit()
{
    clientfield::register( "toplayer", "dt_set_fov", 1, 3, "int" );
    clientfield::register( "toplayer", "dt_set_dof", 1, 3, "int" );
    clientfield::register( "toplayer", "dt_set_hide_reticle_dot", 1, 1, "int" );
    level.var_fb0a6829 = [];
    level.var_fb0a6829[ #"default" ] = 1;
    level.var_fb0a6829[ #"slight_zoom" ] = 2;
    level.var_fb0a6829[ #"zoom" ] = 3;
    level.var_fb0a6829[ #"more_zoom" ] = 4;
    level.var_fb0a6829[ #"extreme_zoom" ] = 5;
    level.var_22817c8a[ #"none" ] = 1;
    level.var_22817c8a[ #"close" ] = 2;
    level.var_22817c8a[ #"medium" ] = 3;
}

// Namespace dialog_tree/dialog_tree
// Params 7
// Checksum 0x2c764de2, Offset: 0x580
// Size: 0x1c8
function new_tree( enter_func = undefined, exit_func = undefined, allow_movement = 0, allow_weapon = 0, script_bundle, var_4d84ed71 = 1, timeout = 0 )
{
    if ( !isdefined( level.var_d5314f55 ) )
    {
        level.var_d5314f55 = [];
    }
    
    new_dialog = spawnstruct();
    new_dialog.selected_options = 0;
    new_dialog.player_pos = [];
    new_dialog.enter_func = enter_func;
    new_dialog.exit_func = exit_func;
    new_dialog.allow_movement = allow_movement;
    new_dialog.allow_weapon = allow_weapon;
    new_dialog.var_4d84ed71 = var_4d84ed71;
    new_dialog.timeout = timeout;
    new_dialog.options = [];
    new_dialog.position = array( 1224, 650 );
    new_dialog.state_index = 0;
    new_dialog.temp_disabled = 0;
    new_dialog.var_6c2428f4 = #"hash_23c2f3c5f7013d69";
    new_dialog set_scriptbundle( script_bundle );
    var_ed170ba3 = level.var_d5314f55.size;
    level.var_d5314f55[ var_ed170ba3 ] = new_dialog;
    return new_dialog;
}

// Namespace dialog_tree/dialog_tree
// Params 1
// Checksum 0xb7ecc7a4, Offset: 0x750
// Size: 0x1a
function set_scriptbundle( bundle )
{
    self.scriptbundle = bundle;
}

// Namespace dialog_tree/dialog_tree
// Params 10
// Checksum 0xe0588137, Offset: 0x778
// Size: 0x112
function add_option( option_text, ai_vo = undefined, ai_anim = undefined, var_a0ee58ce = undefined, end_dialog = 0, set_flag = undefined, var_a16c9b3f = undefined, selected_func = undefined, func_parameter, skip_func = undefined )
{
    option = function_98927b7b( undefined, option_text, ai_vo, ai_anim, var_a0ee58ce, end_dialog, set_flag, var_a16c9b3f, undefined, selected_func, func_parameter, skip_func );
    return self function_d602cdd7( option );
}

// Namespace dialog_tree/dialog_tree
// Params 11
// Checksum 0x800332cf, Offset: 0x898
// Size: 0xb2
function function_6bbbf87( var_9ddc06f5, option_text, ai_vo, ai_anim, var_a0ee58ce, end_dialog, set_flag, var_a16c9b3f, selected_func, func_parameter, skip_func = undefined )
{
    option = function_98927b7b( undefined, option_text, ai_vo, ai_anim, var_a0ee58ce, end_dialog, set_flag, var_a16c9b3f, var_9ddc06f5, selected_func, func_parameter, skip_func );
    return self function_d602cdd7( option );
}

// Namespace dialog_tree/dialog_tree
// Params 13
// Checksum 0x62fe1c41, Offset: 0x958
// Size: 0xe2
function function_7fe78745( expire_count, expire_flag, reset = 1, option_text, ai_vo, ai_anim, var_a0ee58ce, end_dialog, set_flag, var_a16c9b3f, selected_func, func_parameter, skip_func = undefined )
{
    option = function_98927b7b( undefined, option_text, ai_vo, ai_anim, var_a0ee58ce, end_dialog, set_flag, var_a16c9b3f, undefined, selected_func, func_parameter, skip_func, 0, expire_count, expire_flag, reset );
    return self function_d602cdd7( option );
}

// Namespace dialog_tree/dialog_tree
// Params 10
// Checksum 0x596759ea, Offset: 0xa48
// Size: 0xda
function function_9e36808( option_text, ai_vo, ai_anim, var_a0ee58ce, end_dialog, set_flag, var_a16c9b3f, selected_func, func_parameter, skip_func = undefined )
{
    var_1307f204 = self.options.size - 1;
    option = function_98927b7b( var_1307f204, option_text, ai_vo, ai_anim, var_a0ee58ce, end_dialog, set_flag, var_a16c9b3f, undefined, selected_func, func_parameter, skip_func );
    option.active = 0;
    return self function_d602cdd7( option );
}

// Namespace dialog_tree/dialog_tree
// Params 11
// Checksum 0xd6bb3f94, Offset: 0xb30
// Size: 0xc2
function function_ad98a815( var_1307f204, option_text, ai_vo, ai_anim, var_a0ee58ce, end_dialog, set_flag, var_a16c9b3f, selected_func, func_parameter, skip_func = undefined )
{
    option = function_98927b7b( var_1307f204, option_text, ai_vo, ai_anim, var_a0ee58ce, end_dialog, set_flag, var_a16c9b3f, undefined, selected_func, func_parameter, skip_func );
    option.active = 0;
    return self function_d602cdd7( option );
}

// Namespace dialog_tree/dialog_tree
// Params 11
// Checksum 0x15856b30, Offset: 0xc00
// Size: 0xe2
function function_f5d1891( var_9ddc06f5, option_text, ai_vo, ai_anim, var_a0ee58ce, end_dialog, set_flag, var_a16c9b3f, selected_func, func_parameter, skip_func = undefined )
{
    var_1307f204 = self.options.size - 1;
    option = function_98927b7b( var_1307f204, option_text, ai_vo, ai_anim, var_a0ee58ce, end_dialog, set_flag, var_a16c9b3f, var_9ddc06f5, selected_func, func_parameter, skip_func );
    option.active = 0;
    return self function_d602cdd7( option );
}

// Namespace dialog_tree/dialog_tree
// Params 12
// Checksum 0x30b0a400, Offset: 0xcf0
// Size: 0xca
function function_da884b08( var_1307f204, var_9ddc06f5, option_text, ai_vo, ai_anim, var_a0ee58ce, end_dialog, set_flag, var_a16c9b3f, selected_func, func_parameter, skip_func = undefined )
{
    option = function_98927b7b( var_1307f204, option_text, ai_vo, ai_anim, var_a0ee58ce, end_dialog, set_flag, var_a16c9b3f, var_9ddc06f5, selected_func, func_parameter, skip_func );
    option.active = 0;
    return self function_d602cdd7( option );
}

// Namespace dialog_tree/dialog_tree
// Params 2
// Checksum 0x1cf4382e, Offset: 0xdc8
// Size: 0x56
function function_6cbfa3d2( option_id = self.options.size - 1, end_dialog = 1 )
{
    self.options[ option_id ].end_dialog = end_dialog;
}

// Namespace dialog_tree/dialog_tree
// Params 1
// Checksum 0xa34b3be2, Offset: 0xe28
// Size: 0x42
function function_6ebd37a4( option_id = self.options.size - 1 )
{
    self.options[ option_id ].important = 1;
}

// Namespace dialog_tree/dialog_tree
// Params 1
// Checksum 0x78b3b09a, Offset: 0xe78
// Size: 0x42
function function_bc7c03bf( option_id = self.options.size - 1 )
{
    self.options[ option_id ].show_locked = 1;
}

// Namespace dialog_tree/dialog_tree
// Params 5
// Checksum 0x69ef3aaa, Offset: 0xec8
// Size: 0x25e
function function_46f25b65( option_id = self.options.size - 1, var_a5bdf9c0 = 0, cycle_style = "loop", vo_lines = 1, anims = 1 )
{
    self.options[ option_id ].cycle_style = cycle_style;
    
    if ( vo_lines )
    {
        if ( isdefined( self.options[ option_id ].vo_npc ) )
        {
            if ( !isarray( self.options[ option_id ].vo_npc ) )
            {
                self.options[ option_id ].vo_npc = [ self.options[ option_id ].vo_npc ];
            }
            
            if ( var_a5bdf9c0 )
            {
                self.options[ option_id ].cur_vo = randomint( self.options[ option_id ].vo_npc.size );
            }
            else
            {
                self.options[ option_id ].cur_vo = 0;
            }
        }
    }
    
    if ( anims )
    {
        if ( isdefined( self.options[ option_id ].anim_npc ) )
        {
            if ( !isarray( self.options[ option_id ].anim_npc ) )
            {
                self.options[ option_id ].anim_npc = [ self.options[ option_id ].anim_npc ];
            }
            
            if ( var_a5bdf9c0 )
            {
                self.options[ option_id ].cur_anim = randomint( self.options[ option_id ].anim_npc.size );
                return;
            }
            
            self.options[ option_id ].cur_anim = 0;
        }
    }
}

// Namespace dialog_tree/dialog_tree
// Params 2
// Checksum 0x62f90a35, Offset: 0x1130
// Size: 0x5e
function function_a3a3ea7d( message, var_b5df2c8b )
{
    self.temp_disabled = 1;
    
    if ( isdefined( message ) )
    {
        self.var_6c2428f4 = message;
    }
    
    if ( isdefined( var_b5df2c8b ) )
    {
        level flag::wait_till( var_b5df2c8b );
        self.temp_disabled = 0;
    }
}

// Namespace dialog_tree/dialog_tree
// Params 0
// Checksum 0x72b7f96f, Offset: 0x1198
// Size: 0xe
function function_b32b7f64()
{
    self.temp_disabled = 0;
}

// Namespace dialog_tree/dialog_tree
// Params 2
// Checksum 0x599f2b54, Offset: 0x11b0
// Size: 0x9a
function function_21780fc5( dialog_tree, var_a9b0cfdc )
{
    assert( isdefined( dialog_tree ) && isarray( var_a9b0cfdc ) && isint( var_a9b0cfdc[ 0 ] ) && isint( var_a9b0cfdc[ 1 ] ), "<dev string:x38>" );
    dialog_tree.position = var_a9b0cfdc;
}

// Namespace dialog_tree/dialog_tree
// Params 1
// Checksum 0xbe3c8b2e, Offset: 0x1258
// Size: 0x1a
function function_6bb91351( state_index )
{
    self.state_index = state_index;
}

// Namespace dialog_tree/dialog_tree
// Params 10
// Checksum 0xee4b5d5d, Offset: 0x1280
// Size: 0x160
function function_b82713b8( player_loc, var_f2aae3f7, var_dfe2a95d, var_60a7aecc, stance = "stand", fov = "zoom", dof = "medium", lerptime = 2, var_6549d3f9, override_struct )
{
    new_pos = spawnstruct();
    new_pos.player_loc = player_loc;
    new_pos.var_f2aae3f7 = var_f2aae3f7;
    new_pos.var_9d5a3b8f = var_dfe2a95d;
    new_pos.var_60a7aecc = var_60a7aecc;
    new_pos.stance = stance;
    new_pos.origin = player_loc.origin;
    new_pos.fov = fov;
    new_pos.dof = dof;
    new_pos.lerptime = lerptime;
    new_pos.var_6549d3f9 = var_6549d3f9;
    new_pos.override_struct = override_struct;
    self.player_pos[ self.player_pos.size ] = new_pos;
}

// Namespace dialog_tree/dialog_tree
// Params 3, eflags: 0x4
// Checksum 0x7f2e9aec, Offset: 0x13e8
// Size: 0x17a
function private function_decf2123( cur_idx, num_choices, cycle_option )
{
    last_idx = cur_idx;
    cur_idx++;
    
    if ( cur_idx >= num_choices )
    {
        cur_idx = 0;
        
        switch ( cycle_option )
        {
            case #"loop_skip_first":
                cur_idx = 1;
                break;
            case #"repeat_last":
                cur_idx = last_idx;
                break;
            case #"randomize":
                cur_idx = randomint( num_choices );
                break;
            case #"randomize_skip_first":
                cur_idx = randomint( num_choices - 1 ) + 1;
                break;
        }
        
        if ( cycle_option == "randomize" || cycle_option == "randomize_skip_first" )
        {
            first_option = 0;
            
            if ( cycle_option == "randomize_skip_first" )
            {
                first_option = 1;
            }
            
            if ( cur_idx == last_idx )
            {
                cur_idx++;
                
                if ( cur_idx >= num_choices )
                {
                    cur_idx = first_option;
                }
            }
        }
        
        cur_idx = math::clamp( cur_idx, 0, num_choices - 1 );
    }
    
    return cur_idx;
}

// Namespace dialog_tree/dialog_tree
// Params 2, eflags: 0x4
// Checksum 0xc89612f4, Offset: 0x1570
// Size: 0x60c
function private function_a92530c0( ai_actor, anim_struct )
{
    player = self.activator;
    
    if ( isdefined( self.player_pos ) && self.player_pos.size > 0 )
    {
        foreach ( pos in self.player_pos )
        {
            /#
            #/
            
            if ( !isdefined( pos.player_loc ) )
            {
                ai_pos = struct::spawn();
                ai_pos.origin = ai_actor.origin;
                ai_pos.angles = ai_actor.angles;
                
                if ( isdefined( pos.var_f2aae3f7 ) )
                {
                    future_pos = function_b8031554( ai_actor, anim_struct, self.scriptbundle, pos.var_f2aae3f7 );
                    
                    if ( isdefined( future_pos ) )
                    {
                        ai_pos = future_pos;
                    }
                }
                
                pos.player_loc = struct::spawn( ai_pos.origin + anglestoforward( ai_pos.angles ) * 56 + anglestoright( ai_pos.angles ) * -10, ai_pos.angles + ( 0, 180, 0 ) );
                pos.origin = pos.player_loc.origin;
            }
        }
        
        closest_pos = arraygetclosest( player.origin, self.player_pos );
        self.var_c7af782 = closest_pos;
        
        /#
        #/
        
        if ( isdefined( closest_pos.stance ) )
        {
            switch ( closest_pos.stance )
            {
                case #"stand":
                    self.activator val::set( #"dialog_tree", "allow_crouch", 0 );
                    self.activator val::set( #"dialog_tree", "allow_prone", 0 );
                    self.activator val::set( #"dialog_tree", "allow_stand", 1 );
                    break;
                case #"crouch":
                    self.activator val::set( #"dialog_tree", "allow_crouch", 1 );
                    self.activator val::set( #"dialog_tree", "allow_prone", 0 );
                    self.activator val::set( #"dialog_tree", "allow_stand", 0 );
                    break;
                case #"prone":
                    self.activator val::set( #"dialog_tree", "allow_crouch", 0 );
                    self.activator val::set( #"dialog_tree", "allow_prone", 1 );
                    self.activator val::set( #"dialog_tree", "allow_stand", 0 );
                    break;
            }
            
            player setstance( closest_pos.stance );
        }
        
        self.player_linkto = player util::spawn_model( "tag_origin", closest_pos.player_loc.origin, closest_pos.player_loc.angles );
        self.player_linkto dontinterpolate();
        
        if ( isdefined( closest_pos.fov ) && isdefined( level.var_fb0a6829[ closest_pos.fov ] ) )
        {
            player thread clientfield::set_to_player( "dt_set_fov", level.var_fb0a6829[ closest_pos.fov ] );
        }
        
        if ( isdefined( closest_pos.dof ) && isdefined( level.var_22817c8a[ closest_pos.dof ] ) )
        {
            player thread clientfield::set_to_player( "dt_set_dof", level.var_22817c8a[ closest_pos.dof ] );
        }
        
        ai_actor thread ai::look_at( player );
        player playerlinktoblend( self.player_linkto, "tag_origin", 2, 0.4, 0.4 );
        self thread function_edd56700( player );
        self function_2ae0f2f5( ai_actor, anim_struct, closest_pos );
    }
}

// Namespace dialog_tree/dialog_tree
// Params 1, eflags: 0x4
// Checksum 0x8baa257a, Offset: 0x1b88
// Size: 0x7e
function private function_edd56700( player )
{
    wait 2;
    
    if ( !self.allow_movement )
    {
        player playerlinktodelta( self.player_linkto, "tag_origin", 1, 10, 10, 5, 5, 1, 1 );
        return;
    }
    
    player unlink();
    self.player_linkto = undefined;
}

// Namespace dialog_tree/dialog_tree
// Params 4
// Checksum 0x7954324c, Offset: 0x1c10
// Size: 0x1aa
function function_b8031554( ai_actor, *struct, scene, shot )
{
    if ( isdefined( struct ) && isdefined( scene ) && isdefined( shot ) )
    {
        fakeai = util::spawn_anim_model( struct.model, struct.origin, struct.angles );
        fakeai.animname = struct.animname;
        fakeai.targetname = struct.targetname;
        fakeai makefakeai();
        fakeai hide();
        fakeai scene::play_from_time( scene, shot, [ fakeai ], 1, 1, 1 );
        fakeai dontinterpolate();
        wait 0.05;
        pos_info = struct::spawn();
        pos_info.origin = fakeai.origin;
        pos_info.angles = fakeai gettagangles( "tag_origin" );
        pos_info.var_38d4ed7 = fakeai gettagorigin( "j_head" );
        fakeai delete();
        return pos_info;
    }
    
    return undefined;
}

// Namespace dialog_tree/dialog_tree
// Params 3, eflags: 0x4
// Checksum 0x5466489c, Offset: 0x1dc8
// Size: 0xec
function private function_2ae0f2f5( ai_actor, struct, player_pos )
{
    bundle = self.scriptbundle;
    
    if ( isdefined( player_pos.override_scene ) )
    {
        bundle = player_pos.override_scene;
    }
    
    if ( isdefined( player_pos.override_struct ) )
    {
        struct = player_pos.override_struct;
    }
    
    if ( isdefined( bundle ) )
    {
        if ( isdefined( player_pos.var_f2aae3f7 ) )
        {
            struct scene::play( bundle, player_pos.var_f2aae3f7, [ ai_actor ] );
        }
        
        if ( isdefined( player_pos.var_9d5a3b8f ) )
        {
            struct thread scene::play( bundle, player_pos.var_9d5a3b8f, [ ai_actor ] );
        }
    }
}

// Namespace dialog_tree/dialog_tree
// Params 3, eflags: 0x4
// Checksum 0xe46758ba, Offset: 0x1ec0
// Size: 0x154
function private function_86a1bed2( ai_actor, struct, player_pos )
{
    if ( isdefined( player_pos ) )
    {
        bundle = self.scriptbundle;
        ai_actor thread ai::look_at( undefined );
        ai_actor lookatentity();
        
        if ( isdefined( player_pos.fov ) )
        {
            self.activator thread clientfield::set_to_player( "dt_set_fov", 1 );
        }
        
        if ( isdefined( player_pos.dof ) )
        {
            self.activator thread clientfield::set_to_player( "dt_set_dof", 1 );
        }
        
        if ( isdefined( player_pos.override_scene ) )
        {
            bundle = player_pos.override_scene;
        }
        
        if ( isdefined( player_pos.override_struct ) )
        {
            struct = player_pos.override_struct;
        }
        
        if ( isdefined( bundle ) )
        {
            if ( isdefined( player_pos.var_60a7aecc ) )
            {
                struct scene::play( bundle, player_pos.var_60a7aecc, [ ai_actor ] );
            }
        }
    }
}

// Namespace dialog_tree/dialog_tree
// Params 9
// Checksum 0xdb3c1217, Offset: 0x2020
// Size: 0x28e
function function_cfa96cee( dialog_tree, anim_struct, timer, kill_notify, use_dist, *display_dist = "dialog_wait_cancel", *use_angles = 80, use_offset = ( 6, 0, 0 ), var_5bab29d8 = 0 )
{
    if ( isdefined( self ) && isai( self ) && !isalive( self ) )
    {
        println( "<dev string:x69>" + self.name + "<dev string:xaa>" );
        return;
    }
    
    self.radius = 2.5;
    
    if ( self haspart( "j_spine4" ) )
    {
        tagname = "j_spine4";
    }
    else
    {
        tagname = undefined;
    }
    
    interactstring = #"OBJECTIVES/TALK_TO";
    self util::create_cursor_hint( tagname, use_offset, interactstring, use_angles, undefined, undefined, undefined, undefined, 0 );
    self prompts::function_92127496( 1 );
    self prompts::function_1a5e1da6( #"use", 1 );
    msg = self waittill( #"trigger", #"death", #"start_context_melee", #"deleted", display_dist );
    
    if ( msg._notify == "trigger" )
    {
        return timer run( self, kill_notify, use_dist, msg.activator, var_5bab29d8 );
    }
    
    self util::remove_cursor_hint();
    return;
}

// Namespace dialog_tree/dialog_tree
// Params 5
// Checksum 0x8e9ebcf9, Offset: 0x22b8
// Size: 0x10f0
function run( ai_actor, anim_struct, timer, activator, var_5bab29d8 = 0 )
{
    assert( isarray( self.options ) );
    
    if ( !isdefined( ai_actor ) )
    {
        ai_actor = level;
    }
    
    self.ai_actor = ai_actor;
    
    if ( isdefined( activator ) && isplayer( activator ) )
    {
        self.activator = activator;
    }
    else
    {
        self.activator = getplayers()[ 0 ];
    }
    
    if ( ( self.temp_disabled || !savegame::function_51c242e9( 1 ) ) && !var_5bab29d8 )
    {
        self.activator util::show_hint_text( self.var_6c2428f4 );
        wait 3;
        return -1;
    }
    
    ai_actor notify( #"dialog_active" );
    
    if ( !isdefined( ai_actor.var_b905c47b ) )
    {
        ai_actor.var_b905c47b = 0;
    }
    
    ai_actor.var_b905c47b++;
    
    if ( !isdefined( anim_struct ) )
    {
        anim_struct = ai_actor;
    }
    
    self thread function_27059a7f( ai_actor, anim_struct );
    
    if ( ai_actor.var_b905c47b <= 1 )
    {
        level flag::set( "dialog_tree_active" );
        level flag::set( "prompts_disabled" );
        scripted_widgets::function_28027c42( #"dialog_tree", [ #"dialog_tree", #"hint_tutorial" ] );
        objectives::function_9dfb43fc();
        self.var_bc62b3ce = getdvarfloat( #"hash_6b57212fd4fcdd3a" );
        setdvar( #"hash_6b57212fd4fcdd3a", 0 );
        self.activator val::set( #"dialog_tree", "ignoreme", 1 );
        self.activator val::set( #"dialog_tree", "takedamage", 0 );
        
        if ( isai( ai_actor ) )
        {
            if ( !isdefined( ai_actor.animname ) )
            {
                ai_actor.animname = "generic";
            }
            
            ai_actor val::set( #"dialog_tree", "ignoreme", 1 );
            ai_actor val::set( #"dialog_tree", "takedamage", 0 );
        }
        
        self function_a92530c0( ai_actor, anim_struct );
        
        if ( !isdefined( self.player_linkto ) && !self.allow_movement )
        {
            self.player_linkto = util::spawn_model( "tag_origin", self.activator.origin, self.activator.angles );
            self.activator playerlinktodelta( self.player_linkto, "tag_origin", 0, 20, 20, 10, 10, 1 );
            self.activator setstance( "stand" );
            self.activator val::set( #"dialog_tree", "allow_crouch", 0 );
            self.activator val::set( #"dialog_tree", "allow_prone", 0 );
        }
        
        if ( !self.allow_weapon )
        {
            self.activator val::set( #"dialog_tree", "disable_weapons", 1 );
            self.activator val::set( #"dialog_tree", "disable_offhand_weapons", 1 );
        }
    }
    
    ai_actor function_a5440f84( "_dialog_vo_playing" );
    ai_actor function_a5440f84( "_dialog_anim_playing" );
    ai_actor function_a5440f84( "_dialog_func_running" );
    ai_actor function_a5440f84( "_dialog_ui_animating" );
    
    if ( isdefined( self.enter_func ) )
    {
        ai_actor [[ self.enter_func ]]();
    }
    
    ai_actor flag::wait_till_clear( "_dialog_ui_animating" );
    
    while ( ai_actor.var_b905c47b > 1 )
    {
        wait 0.1;
    }
    
    wait 0.5;
    end_dialog = 0;
    last_choice = -1;
    self.selected_options = 0;
    
    if ( self.var_4d84ed71 )
    {
        namespace_82bfe441::fade( 1, "FadeFast" );
    }
    
    function_43bca3cb( self.position, self.state_index );
    globallogic_ui::function_9ed5232e( "hudItems.subtitles.noAutoHide", 1 );
    
    if ( isdefined( timer ) && timer > 0 )
    {
        self.timeout = timer;
    }
    
    while ( !end_dialog )
    {
        cur_choices = self function_4a2c9dcb( 4 );
        
        if ( cur_choices.size < 1 )
        {
            end_dialog = 1;
            continue;
        }
        
        ai_actor flag::set( "_dialog_ui_animating" );
        chosen_id = function_8b61aa4c( cur_choices, ai_actor );
        
        if ( chosen_id == -1 )
        {
            break;
        }
        
        self.selected_options++;
        globallogic_ui::function_9ed5232e( "hudItems.subtitles.noAutoHide", 0 );
        waitframe( 1 );
        globallogic_ui::function_9ed5232e( "hudItems.subtitles.noAutoHide", 1 );
        ai_actor notify( #"dialog_tree_choice_made" );
        chosen_option = self.options[ chosen_id ];
        bb::function_7977c093( self.scriptbundle, self.options[ chosen_id ].hudstring, getplayers()[ 0 ] );
        
        if ( isai( ai_actor ) )
        {
            ai_actor stopsounds();
        }
        
        if ( isdefined( chosen_option.set_flag ) )
        {
            foreach ( flag in chosen_option.set_flag )
            {
                level flag::set( flag );
            }
        }
        
        if ( isdefined( chosen_option.selected_func ) )
        {
            ai_actor flag::set( "_dialog_func_running" );
            ai_actor thread function_a7575efe( chosen_option.selected_func, chosen_option.func_parameter, chosen_option.skip_func );
        }
        
        if ( isdefined( chosen_option.vo_npc ) )
        {
            ai_actor flag::set( "_dialog_vo_playing" );
            
            if ( chosen_option.cur_vo < 0 )
            {
                self thread function_62d48ab( ai_actor, chosen_option.vo_npc );
            }
            else
            {
                self thread function_62d48ab( ai_actor, chosen_option.vo_npc[ chosen_option.cur_vo ] );
                chosen_option.cur_vo = function_decf2123( chosen_option.cur_vo, chosen_option.vo_npc.size, chosen_option.cycle_style );
            }
        }
        
        anim_struct notify( #"end_dialog_loop_anim" );
        
        if ( isdefined( chosen_option.anim_npc ) )
        {
            ai_actor flag::set( "_dialog_anim_playing" );
            
            if ( chosen_option.cur_anim < 0 )
            {
                self thread function_c331410b( ai_actor, chosen_option.anim_npc, chosen_option.var_59ae859c, anim_struct, self.scriptbundle );
            }
            else
            {
                self thread function_c331410b( ai_actor, chosen_option.anim_npc[ chosen_option.cur_anim ], chosen_option.var_59ae859c, anim_struct, self.scriptbundle );
                chosen_option.cur_anim = function_decf2123( chosen_option.cur_anim, chosen_option.anim_npc.size, chosen_option.cycle_style );
            }
        }
        
        if ( is_true( chosen_option.end_dialog ) || self.timeout > 0 )
        {
            end_dialog = 1;
            last_choice = chosen_id;
        }
        
        ai_actor flag::wait_till_clear_all( [ "_dialog_func_running", "_dialog_vo_playing", "_dialog_anim_playing" ] );
        
        if ( !end_dialog )
        {
            ai_actor flag::wait_till_clear( "_dialog_ui_animating" );
        }
        
        ai_actor notify( #"dialog_tree_response_complete" );
        
        if ( !isdefined( chosen_option.var_a16c9b3f ) || chosen_option.var_a16c9b3f != "forever" && level flag::get( chosen_option.var_a16c9b3f ) )
        {
            if ( isdefined( self.options[ chosen_id ] ) )
            {
                self.options[ chosen_id ].active = 0;
            }
        }
        
        self function_59d38639( chosen_id );
        waitframe( 1 );
        
        if ( is_true( ai_actor.end_dialog ) )
        {
            break;
        }
    }
    
    if ( ai_actor.var_b905c47b <= 1 )
    {
        if ( self.var_4d84ed71 )
        {
            namespace_82bfe441::fade( 0, "FadeFast" );
        }
        
        scripted_widgets::set_focus( #"dialog_tree", 0 );
        scripted_widgets::remove( #"dialog_tree" );
        scripted_widgets::function_4279fd02( #"dialog_tree" );
        objectives::function_4279fd02();
        self.activator clientfield::set_to_player( "dt_set_hide_reticle_dot", 0 );
        
        if ( isdefined( self.var_c7af782 ) )
        {
            self thread function_86a1bed2( ai_actor, anim_struct, self.var_c7af782 );
            self.var_c7af782 = undefined;
        }
    }
    
    if ( isdefined( self.exit_func ) )
    {
        ai_actor thread [[ self.exit_func ]]();
    }
    
    if ( ai_actor.var_b905c47b <= 1 )
    {
        if ( isdefined( self.var_bc62b3ce ) )
        {
            setdvar( #"hash_6b57212fd4fcdd3a", self.var_bc62b3ce );
        }
        
        if ( !self.allow_movement )
        {
            self.activator unlink();
            
            if ( isdefined( self.player_linkto ) )
            {
                self.player_linkto delete();
                self.player_linkto = undefined;
            }
            
            self.activator val::reset( #"dialog_tree", "allow_crouch" );
            self.activator val::reset( #"dialog_tree", "allow_prone" );
            self.activator val::reset( #"dialog_tree", "allow_stand" );
        }
        
        if ( !self.allow_weapon )
        {
            self.activator val::reset( #"dialog_tree", "disable_weapons" );
            self.activator val::reset( #"dialog_tree", "disable_offhand_weapons" );
        }
        
        ai_actor flag::clear( "_dialog_vo_playing" );
        ai_actor flag::clear( "_dialog_anim_playing" );
        ai_actor flag::clear( "_dialog_func_running" );
        self.activator val::reset( #"dialog_tree", "ignoreme" );
        self.activator val::reset( #"dialog_tree", "takedamage" );
        waitframe( 1 );
        
        if ( isai( ai_actor ) )
        {
            ai_actor val::reset( #"dialog_tree", "ignoreme" );
            ai_actor val::reset( #"dialog_tree", "takedamage" );
        }
        
        self notify( #"dialog_tree_end" );
        ai_actor notify( #"dialog_tree_end" );
        globallogic_ui::function_9ed5232e( "hudItems.subtitles.noAutoHide", 0 );
        level flag::clear( "dialog_tree_active" );
        level flag::clear( "prompts_disabled" );
    }
    
    ai_actor.var_b905c47b--;
    
    while ( ai_actor.var_b905c47b > 0 )
    {
        wait 0.1;
    }
    
    return last_choice;
}

// Namespace dialog_tree/dialog_tree
// Params 0
// Checksum 0x577435e7, Offset: 0x33b0
// Size: 0x2c
function function_6a2674b8()
{
    choices = self function_4a2c9dcb();
    return choices.size;
}

// Namespace dialog_tree/dialog_tree
// Params 0
// Checksum 0xeadf3050, Offset: 0x33e8
// Size: 0x58
function function_a6a75a20()
{
    self.ai_actor flag::wait_till( "waiting_on_player_choice" );
    waitframe( 1 );
    level notify( #"dialog_tree_option_selected", { #optindex:-1 } );
}

// Namespace dialog_tree/dialog_tree
// Params 2, eflags: 0x4
// Checksum 0xbd0f0bae, Offset: 0x3448
// Size: 0x20c
function private function_27059a7f( ai_actor, anim_struct )
{
    self endon( #"dialog_tree_end" );
    level notify( #"watch_dt_skips" );
    level endon( #"watch_dt_skips" );
    
    while ( true )
    {
        self.activator waittill( #"ui_cancel" );
        bb::function_7977c093( self.scriptbundle, #"ui_cancel", getplayers()[ 0 ] );
        
        if ( ai_actor flag::get( "_dialog_vo_playing" ) )
        {
            if ( isdefined( ai_actor.var_e744d1aa ) )
            {
                snd::stop( ai_actor.var_e744d1aa );
                ai_actor notify( #"cancel speaking" );
            }
        }
        
        if ( ai_actor flag::get( "_dialog_anim_playing" ) )
        {
            var_45c1f22c = self function_58881e72( self.scriptbundle, ai_actor._scene_object._str_shot, anim_struct );
            
            if ( var_45c1f22c )
            {
                ai_actor notify( #"dialog_tree_cancel_response" );
                anim_struct thread scene::play_from_time( self.scriptbundle, ai_actor._scene_object._str_shot, undefined, getanimlength( ai_actor._scene_object._str_current_anim ) - 0.25, 0, 1 );
            }
        }
        else
        {
            ai_actor notify( #"dialog_tree_cancel_response" );
        }
        
        wait 0.2;
    }
}

// Namespace dialog_tree/dialog_tree
// Params 3, eflags: 0x4
// Checksum 0x9b46fdff, Offset: 0x3660
// Size: 0x51c, Type: bool
function private function_58881e72( sb, str_shot, anim_struct )
{
    if ( !isarray( anim_struct.scene_ents ) )
    {
        return false;
    }
    
    scene_ents = anim_struct.scene_ents;
    db = { #vox:"none", #scn:sb, #skipt:9999, #ent:undefined, #var_4fc15872:2.4, #var_30468601:1, #var_bd15dadd:-1 };
    
    foreach ( ent in scene_ents )
    {
        if ( !isdefined( ent ) )
        {
            continue;
        }
        
        if ( isdefined( ent._scene_object._str_current_anim ) )
        {
            if ( isanimlooping( ent._scene_object._str_current_anim ) )
            {
                continue;
            }
            
            if ( db.var_bd15dadd < 0 )
            {
                db.var_bd15dadd = ent getanimtime( ent._scene_object._str_current_anim );
            }
            
            anim_len = getanimlength( ent._scene_object._str_current_anim );
            curr_time = ent getanimtime( ent._scene_object._str_current_anim );
            
            if ( abs( curr_time - db.var_bd15dadd ) > 0.025 )
            {
                /#
                    iprintln( "<dev string:xba>" + abs( curr_time - db.var_bd15dadd ) );
                #/
                
                continue;
            }
            
            notetracks = getnotetracksindelta( ent._scene_object._str_current_anim, 0, 999 );
            
            if ( notetracks.size )
            {
                foreach ( notetrack in notetracks )
                {
                    if ( notetrack[ 5 ] == #"vox" )
                    {
                        ent.stop_sound = 1;
                        
                        if ( notetrack[ 3 ] > curr_time && notetrack[ 3 ] * anim_len < db.skipt )
                        {
                            check_time = notetrack[ 3 ] * anim_len - 0.1;
                            
                            if ( check_time < curr_time * anim_len )
                            {
                                continue;
                            }
                            
                            db.ent = ent;
                            db.skipt = check_time;
                            db.var_30468601 = check_time / anim_len;
                            db.var_4fc15872 = notetrack[ 3 ] * anim_len;
                            
                            /#
                                db.vox = function_9e72a96( notetrack[ 6 ] );
                            #/
                        }
                    }
                }
            }
        }
    }
    
    foreach ( ent in scene_ents )
    {
        if ( is_true( ent.stop_sound ) )
        {
            ent stopsounds();
            ent.stop_sound = undefined;
        }
    }
    
    if ( isdefined( db.ent ) )
    {
        anim_struct thread scene::play_from_time( sb, str_shot, undefined, db.var_30468601, 1, 1 );
        return false;
    }
    
    return true;
}

// Namespace dialog_tree/dialog_tree
// Params 2, eflags: 0x4
// Checksum 0x326a00ce, Offset: 0x3b88
// Size: 0x17c
function private function_62d48ab( ai_actor, vo_lines )
{
    ai_actor endon( #"death" );
    ai_actor endon( #"dialog_tree_end" );
    
    if ( !isarray( vo_lines ) )
    {
        vo_lines = [ vo_lines ];
    }
    
    for ( i = 0; i < vo_lines.size ; i++ )
    {
        vo_line = vo_lines[ i ];
        
        if ( soundexists( vo_line ) )
        {
            ai_actor.var_e744d1aa = snd::play( vo_line, [ ai_actor, "j_head" ] );
            snd::function_2fdc4fb( ai_actor.var_e744d1aa );
            continue;
        }
        
        iprintlnbold( vo_line );
        self.activator waittilltimeout( 1.5, #"dialog_tree_cancel_response" );
    }
    
    ai_actor notify( #"dialog_tree_vo_response_complete" );
    ai_actor.var_e744d1aa = undefined;
    ai_actor flag::clear( "_dialog_vo_playing" );
}

// Namespace dialog_tree/dialog_tree
// Params 1, eflags: 0x4
// Checksum 0xa9eb907b, Offset: 0x3d10
// Size: 0x64
function private function_d602cdd7( new_option )
{
    assert( isarray( self.options ) );
    option_id = self.options.size;
    self.options[ option_id ] = new_option;
    return option_id;
}

// Namespace dialog_tree/dialog_tree
// Params 16, eflags: 0x4
// Checksum 0x362af5b6, Offset: 0x3d80
// Size: 0x1f6
function private function_98927b7b( parent_id, option_text, ai_vo, ai_anim, var_a0ee58ce, end_dialog = 0, set_flag, var_a16c9b3f, var_9ddc06f5, selected_func, func_parameter, skip_func, important = 0, expire_count, expire_flag, expire_reset = 1 )
{
    option = spawnstruct();
    option.active = 1;
    option.parent_id = parent_id;
    option.hudstring = option_text;
    option.vo_npc = ai_vo;
    option.anim_npc = ai_anim;
    option.var_59ae859c = var_a0ee58ce;
    option.end_dialog = end_dialog;
    
    if ( isdefined( set_flag ) && !isarray( set_flag ) )
    {
        set_flag = [ set_flag ];
    }
    
    option.set_flag = set_flag;
    option.var_a16c9b3f = var_a16c9b3f;
    option.var_9ddc06f5 = var_9ddc06f5;
    option.selected_func = selected_func;
    option.func_parameter = func_parameter;
    option.skip_func = skip_func;
    option.important = important;
    option.show_locked = 0;
    option.cur_vo = -1;
    option.cur_anim = -1;
    option.expire_count = expire_count;
    option.expire_flag = expire_flag;
    option.expire_reset = expire_reset;
    return option;
}

// Namespace dialog_tree/dialog_tree
// Params 1, eflags: 0x4
// Checksum 0x112d9761, Offset: 0x3f80
// Size: 0x142
function private function_b85d5a3a( cur_choices )
{
    hudstrings = [];
    
    for ( i = 0; i < 4 ; i++ )
    {
        if ( isdefined( cur_choices[ i ] ) )
        {
            option = self.options[ cur_choices[ i ] ];
            var_2ebd3f57 = isdefined( option.var_9ddc06f5 ) && option.show_locked && !level flag::get( option.var_9ddc06f5 );
            hudstrings[ i ] = { #important:option.important, #string:option.hudstring, #locked:var_2ebd3f57 };
            continue;
        }
        
        hudstrings[ i ] = { #important:0, #string:undefined, #locked:0 };
    }
    
    return hudstrings;
}

// Namespace dialog_tree/dialog_tree
// Params 3, eflags: 0x4
// Checksum 0x659ca8ef, Offset: 0x40d0
// Size: 0xa4
function private function_a7575efe( func, param, skip_func )
{
    self endon( #"dialog_tree_end" );
    
    if ( isdefined( skip_func ) )
    {
        self thread function_49048365( skip_func );
    }
    
    if ( !isdefined( param ) )
    {
        self [[ func ]]();
    }
    else
    {
        self [[ func ]]( param );
    }
    
    self notify( #"dtree_cancel_skip_func" );
    self flag::clear( "_dialog_func_running" );
}

// Namespace dialog_tree/dialog_tree
// Params 1, eflags: 0x4
// Checksum 0x5274c1c4, Offset: 0x4180
// Size: 0x50
function private function_49048365( skip_func )
{
    self endon( #"dialog_tree_end" );
    self endon( #"dtree_cancel_skip_func" );
    self waittill( #"dialog_tree_cancel_response" );
    self thread [[ skip_func ]]();
}

// Namespace dialog_tree/dialog_tree
// Params 5, eflags: 0x4
// Checksum 0x6983bf93, Offset: 0x41d8
// Size: 0x174
function private function_c331410b( ai_actor, anims, anim_loop, struct, scriptbundle )
{
    self endon( #"dialog_tree_end" );
    ai_actor endon( #"dialog_tree_choice_made" );
    
    if ( isdefined( scriptbundle ) )
    {
        if ( !isarray( anims ) )
        {
            anims = [ anims ];
        }
        
        self thread function_a5ba53f8( ai_actor );
        
        for ( i = 0; i < anims.size ; i++ )
        {
            self thread function_c4ae7ee0( ai_actor, anims[ i ], struct, scriptbundle );
            self waittill( #"dialog_tree_anim_done", #"dialog_tree_anim_continue" );
        }
    }
    
    ai_actor notify( #"dialog_tree_scene_response_complete" );
    self.var_ebacf97b = undefined;
    ai_actor flag::clear( "_dialog_anim_playing" );
    
    if ( isdefined( scriptbundle ) && isdefined( anim_loop ) )
    {
        struct thread scene::play( scriptbundle, anim_loop, [ ai_actor ] );
    }
}

// Namespace dialog_tree/dialog_tree
// Params 4, eflags: 0x4
// Checksum 0x4392ad5e, Offset: 0x4358
// Size: 0x86
function private function_c4ae7ee0( ai_actor, shot_name, struct, scriptbundle )
{
    self endon( #"dialog_tree_end" );
    self.var_ebacf97b = shot_name;
    struct scene::play( scriptbundle, shot_name, [ ai_actor ] );
    self notify( #"dialog_tree_anim_done" );
}

// Namespace dialog_tree/dialog_tree
// Params 1, eflags: 0x4
// Checksum 0x7ae28ac4, Offset: 0x43e8
// Size: 0x70
function private function_a5ba53f8( ai_actor )
{
    ai_actor endon( #"dialog_tree_scene_response_complete" );
    level waittill( #"dialog_tree_show_choices" );
    ai_actor flag::clear( "_dialog_anim_playing" );
    ai_actor notify( #"dialog_tree_scene_response_complete" );
}

// Namespace dialog_tree/dialog_tree
// Params 1, eflags: 0x4
// Checksum 0xc68e6fa6, Offset: 0x4460
// Size: 0x6c
function private function_a5440f84( flagname )
{
    if ( !self flag::exists( flagname ) )
    {
        self flag::init( flagname );
        self flag::clear( flagname );
        return;
    }
    
    self flag::wait_till_clear( flagname );
}

// Namespace dialog_tree/dialog_tree
// Params 1, eflags: 0x4
// Checksum 0xaa22805e, Offset: 0x44d8
// Size: 0x244
function private function_4a2c9dcb( max_options )
{
    cur_choices = [];
    
    for ( choice_id = 0; choice_id < self.options.size && ( !isdefined( max_options ) || cur_choices.size < max_options ) ; choice_id++ )
    {
        option = self.options[ choice_id ];
        
        if ( isdefined( option.expire_count ) && option.expire_count > 0 )
        {
            if ( self.selected_options == 0 && is_true( option.expire_reset ) )
            {
                self.options[ choice_id ].active = 1;
                
                if ( isdefined( option.expire_flag ) )
                {
                    level flag::clear( option.expire_flag );
                }
            }
            
            if ( self.selected_options >= option.expire_count && option.active )
            {
                self.options[ choice_id ].active = 0;
                
                if ( isdefined( option.expire_flag ) )
                {
                    level flag::set( option.expire_flag );
                }
            }
        }
        
        if ( isdefined( option.var_a16c9b3f ) )
        {
            if ( option.var_a16c9b3f != "forever" && level flag::get( option.var_a16c9b3f ) )
            {
                self.options[ choice_id ].active = 0;
            }
        }
        
        if ( !option.active || isdefined( option.var_9ddc06f5 ) && !level flag::get( option.var_9ddc06f5 ) && !option.show_locked )
        {
            choice_id++;
            continue;
        }
        
        cur_choices[ cur_choices.size ] = choice_id;
    }
    
    return cur_choices;
}

// Namespace dialog_tree/dialog_tree
// Params 1, eflags: 0x4
// Checksum 0xc46c66c9, Offset: 0x4728
// Size: 0xaa
function private function_59d38639( parent_id )
{
    foreach ( option in self.options )
    {
        if ( isdefined( option.parent_id ) && option.parent_id == parent_id )
        {
            option.active = 1;
        }
    }
}

// Namespace dialog_tree/dialog_tree
// Params 2, eflags: 0x4
// Checksum 0x95f7978b, Offset: 0x47e0
// Size: 0x374
function private function_8b61aa4c( cur_choices, ai_actor )
{
    dialog_strings = function_b85d5a3a( cur_choices );
    index = 0;
    choices = [];
    
    foreach ( choice in dialog_strings )
    {
        if ( isdefined( choice.string ) )
        {
            scripted_widgets::function_f2a9266( #"dialog_tree", index, "dialogString", choice.string );
            scripted_widgets::function_f2a9266( #"dialog_tree", index, "important", choice.important );
            scripted_widgets::function_f2a9266( #"dialog_tree", index, "unImportant", choice.locked );
            choices[ index ] = choice;
            index++;
        }
    }
    
    scripted_widgets::function_9ade1d9b( #"dialog_tree", "optionSelected", 0, 1, undefined, undefined, 1 );
    
    if ( isdefined( self.timeout ) && self.timeout > 0 )
    {
        scripted_widgets::function_9ade1d9b( #"dialog_tree", "timeOut", self.timeout );
    }
    
    player = self.activator;
    assert( isplayer( player ) );
    player thread scripted_widgets::function_e13a1a9c( [ choices.size, 1 ], &function_cde38026, undefined, undefined, choices, "dialog_tree_option_selected", "death" );
    ai_actor flag::set( "waiting_on_player_choice" );
    selected = level waittill( #"dialog_tree_option_selected" );
    ai_actor flag::clear( "waiting_on_player_choice" );
    
    if ( selected.optindex < 0 )
    {
        level thread function_310d2602( choices, ai_actor, 1 );
        return selected.optindex;
    }
    
    level thread function_310d2602( choices, ai_actor );
    return cur_choices[ selected.optindex ];
}

// Namespace dialog_tree/dialog_tree
// Params 3, eflags: 0x4
// Checksum 0x12dca597, Offset: 0x4b60
// Size: 0x104
function private function_cde38026( old_indices, new_indices, choices )
{
    var_c8994f32 = old_indices[ 0 ];
    var_d9161f36 = new_indices[ 0 ];
    var_1e50dc81 = var_d9161f36;
    
    while ( is_true( choices[ var_1e50dc81 ].locked ) )
    {
        if ( var_d9161f36 < var_c8994f32 )
        {
            var_1e50dc81--;
        }
        else
        {
            var_1e50dc81++;
        }
        
        if ( var_1e50dc81 < 0 || var_1e50dc81 >= choices.size )
        {
            var_1e50dc81 = var_c8994f32;
            break;
        }
    }
    
    if ( var_1e50dc81 != var_c8994f32 )
    {
        scripted_widgets::function_9ade1d9b( #"dialog_tree", "index", var_1e50dc81, 1, undefined, undefined, 1 );
    }
    
    return [ var_1e50dc81, 0 ];
}

// Namespace dialog_tree/dialog_tree
// Params 3, eflags: 0x4
// Checksum 0xd8f6805e, Offset: 0x4c70
// Size: 0xfc
function private function_310d2602( choices, ai_actor, quick_clear = 0 )
{
    if ( !quick_clear )
    {
        scripted_widgets::function_9ade1d9b( #"dialog_tree", "optionSelected", 1, 1 );
        wait 1.5;
    }
    
    if ( scripted_widgets::exists( #"dialog_tree" ) )
    {
        for ( i = choices.size - 1; i >= 0 ; i-- )
        {
            scripted_widgets::function_7239e030( #"dialog_tree", i );
        }
    }
    
    ai_actor flag::clear( "_dialog_ui_animating" );
}

// Namespace dialog_tree/dialog_tree
// Params 2, eflags: 0x4
// Checksum 0xb33e39af, Offset: 0x4d78
// Size: 0x1a4
function private function_43bca3cb( position, state_index )
{
    scripted_widgets::create( #"dialog_tree", #"hash_5ee7619b9b614d34" );
    scripted_widgets::set_x( #"dialog_tree", position[ 0 ] );
    scripted_widgets::set_y( #"dialog_tree", position[ 1 ] );
    scripted_widgets::function_330981ed( #"dialog_tree" );
    scripted_widgets::function_9ade1d9b( #"dialog_tree", "index", 0 );
    scripted_widgets::function_9ade1d9b( #"dialog_tree", "timeOut", 0 );
    scripted_widgets::function_9ade1d9b( #"dialog_tree", "optionSelected", 0 );
    scripted_widgets::function_9ade1d9b( #"dialog_tree", "stateIndex", state_index );
    scripted_widgets::set_focus( #"dialog_tree", 1 );
    self.activator clientfield::set_to_player( "dt_set_hide_reticle_dot", 1 );
}

