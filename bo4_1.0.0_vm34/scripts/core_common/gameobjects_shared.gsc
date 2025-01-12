#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_role;
#using scripts\core_common\potm_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\tweakables_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\weapons_shared;
#using scripts\killstreaks\killstreaks_util;

#namespace gameobjects;

// Namespace gameobjects
// Method(s) 7 Total 7
class cinteractobj {

    var e_object;
    var m_a_keyline_objects;
    var m_b_allow_companion_command;
    var m_b_allow_weapons;
    var m_b_auto_reenable;
    var m_b_gameobject_scene_alignment;
    var m_b_reusable;
    var m_b_scene_use_time_override;
    var m_n_trigger_height;
    var m_n_trigger_offset;
    var m_n_trigger_radius;
    var m_n_trigger_use_time;
    var m_s_bundle;
    var m_str_anim;
    var m_str_hint;
    var m_str_identifier;
    var m_str_obj_anim;
    var m_str_objective;
    var m_str_player_scene_anim;
    var m_str_tag;
    var m_str_team;
    var m_str_trigger_type;
    var m_str_type;
    var m_t_interact;
    var m_v_tag_origin;
    var var_6103b3ae;
    var var_67923c70;
    var var_6865e3a8;
    var var_79cbfce0;
    var var_b229ee82;
    var var_b4037f88;
    var var_dbfe6aeb;

    // Namespace cinteractobj/gameobjects_shared
    // Params 0, eflags: 0x8
    // Checksum 0x7d699023, Offset: 0xebf8
    // Size: 0x12
    constructor() {
        m_str_trigger_type = "use";
    }

    // Namespace cinteractobj/gameobjects_shared
    // Params 0, eflags: 0x10
    // Checksum 0xea492f67, Offset: 0xec18
    // Size: 0x44
    destructor() {
        /#
            if (getdvarint(#"scr_debug_gameobjects", 0)) {
                iprintlnbold("<dev string:x2fc>");
            }
        #/
    }

    // Namespace cinteractobj/gameobjects_shared
    // Params 1, eflags: 0x0
    // Checksum 0xaf19795f, Offset: 0x102f8
    // Size: 0xd6
    function function_347a8d44(e_player) {
        if (isdefined(e_object) && isdefined(e_object.mdl_gameobject) && isdefined(e_player) && isdefined(e_object.mdl_gameobject.b_enabled) && e_object.mdl_gameobject.b_enabled) {
            return (distance2dsquared(e_object.origin, e_player.origin) < 675 * 675 && e_player util::is_player_looking_at(e_object.origin));
        }
        return 0;
    }

    // Namespace cinteractobj/gameobjects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x1bf1eb4b, Offset: 0xfed0
    // Size: 0x41a
    function function_a231b3c1() {
        level endon(#"game_ended");
        e_object endon(#"death", #"gameobject_end_use");
        e_object.mdl_gameobject endon(#"death");
        level waittill(#"all_players_spawned");
        if (m_str_team == #"none") {
            return;
        }
        var_a2b42d7c = var_6865e3a8 || isdefined(e_object.var_7be6eb85) ? m_str_team : #"none";
        for (var_29494419 = util::get_players(m_str_team); var_29494419.size; var_29494419 = util::get_players(m_str_team)) {
            foreach (e_player in var_29494419) {
                if (function_347a8d44(e_player) && !isinarray(var_b229ee82, e_player.team) && !e_player isinvehicle()) {
                    voiceparams = {#team:m_str_team, #side:var_a2b42d7c, #targetname:e_object.var_7be6eb85};
                    if (isdefined(e_object.var_6c2e152f)) {
                        voiceevent("itfr_dis_obj", undefined, voiceparams);
                    } else if (isdefined(e_object.var_fe880250)) {
                        voiceevent("mini_hint_itct", undefined, voiceparams);
                    } else if (isdefined(var_dbfe6aeb)) {
                        switch (var_dbfe6aeb) {
                        case #"door":
                            voiceevent("door_hint_itct", undefined, voiceparams);
                            break;
                        case #"panel":
                            voiceevent("panl_hint_itct", undefined, voiceparams);
                            break;
                        case #"radio":
                            voiceevent("rdio_hint_itct", undefined, voiceparams);
                            break;
                        case #"console":
                            voiceevent("cnsl_hint_itct", undefined, voiceparams);
                            break;
                        case #"climb":
                            voiceevent("clmb_hint_itct", undefined, voiceparams);
                            break;
                        default:
                            voiceevent("gobj_hint_itct", undefined, voiceparams);
                            break;
                        }
                    }
                    array::add(var_b229ee82, e_player.team);
                    break;
                }
            }
            wait 1;
        }
    }

    // Namespace cinteractobj/gameobjects_shared
    // Params 1, eflags: 0x0
    // Checksum 0x2b496c7, Offset: 0xfd78
    // Size: 0x14c
    function is_valid_gameobject_trigger(t_override) {
        if (m_str_trigger_type === "proximity") {
            switch (t_override.classname) {
            case #"trigger_once_new":
            case #"trigger_box":
            case #"trigger_once":
            case #"trigger_radius":
            case #"trigger_box_new":
            case #"trigger_multiple":
            case #"trigger_radius_new":
            case #"trigger_multiple_new":
                return true;
            default:
                return false;
            }
        } else {
            switch (t_override.classname) {
            case #"trigger_use_new":
            case #"trigger_radius_use":
            case #"hash_6119f399228d396b":
            case #"trigger_use":
                return true;
            default:
                return false;
            }
        }
        return false;
    }

    // Namespace cinteractobj/gameobjects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x39e471a1, Offset: 0xf368
    // Size: 0xa06
    function create_gameobject_trigger() {
        if (!isdefined(m_t_interact)) {
            if (m_str_type === "generic" || m_str_trigger_type === "proximity") {
                m_t_interact = spawn("trigger_radius", m_v_tag_origin + m_n_trigger_offset + (0, 0, m_n_trigger_height / 2), 0, m_n_trigger_radius, m_n_trigger_height, 1);
            } else {
                m_t_interact = spawn("trigger_radius_use", m_v_tag_origin + m_n_trigger_offset + (0, 0, m_n_trigger_height / 2), 0, m_n_trigger_radius, m_n_trigger_height, 1);
                if (isdefined(e_object.angles)) {
                    m_t_interact.angles = e_object.angles;
                }
                m_t_interact usetriggerrequirelookat(isdefined(e_object.require_look_at) && e_object.require_look_at);
                m_t_interact usetriggerrequirelooktoward(isdefined(e_object.require_look_toward) && e_object.require_look_toward);
            }
        }
        m_t_interact.trigger_offset = m_n_trigger_offset;
        m_t_interact triggerignoreteam();
        m_t_interact setvisibletoall();
        m_t_interact setcursorhint("HINT_INTERACTIVE_PROMPT");
        m_t_interact.var_198df85d = isdefined(m_s_bundle.var_198df85d) ? m_s_bundle.var_198df85d : 0;
        m_t_interact.str_hint = m_str_hint;
        if (m_str_team != #"any") {
            m_t_interact setteamfortrigger(m_str_team);
        }
        if (!isdefined(m_a_keyline_objects)) {
            m_a_keyline_objects = [];
        } else if (!isarray(m_a_keyline_objects)) {
            m_a_keyline_objects = array(m_a_keyline_objects);
        }
        switch (m_str_type) {
        case #"carry":
            assert(isdefined(m_a_keyline_objects[0]), "<dev string:x3b2>");
            mdl_gameobject = gameobjects::create_carry_object(m_str_team, m_t_interact, m_a_keyline_objects, (0, 0, 0), m_str_objective, var_67923c70);
            break;
        case #"pack":
            assert(isdefined(m_a_keyline_objects[0]), "<dev string:x3b2>");
            mdl_gameobject = gameobjects::create_pack_object(m_str_team, m_t_interact, m_a_keyline_objects, (0, 0, 0), m_str_objective, var_67923c70);
            break;
        case #"generic":
            mdl_gameobject = gameobjects::create_generic_object(m_str_team, m_t_interact, m_a_keyline_objects, (0, 0, 0));
            break;
        case #"use":
        default:
            mdl_gameobject = gameobjects::create_use_object(m_str_team, m_t_interact, m_a_keyline_objects, (0, 0, 0), m_str_objective, var_67923c70, 0, e_object.script_enable_on_start);
            break;
        }
        mdl_gameobject.single_use = 0;
        if (m_str_type == "carry" || m_str_type == "pack") {
            mdl_gameobject.objectiveonself = 1;
            if (isdefined(mdl_gameobject.objectiveid)) {
                objective_setposition(mdl_gameobject.objectiveid, (0, 0, 0));
            }
            if (isdefined(m_s_bundle.carryicon)) {
                if (m_str_type == "carry") {
                    mdl_gameobject gameobjects::set_carry_icon(m_s_bundle.carryicon);
                } else {
                    mdl_gameobject gameobjects::set_pack_icon(m_s_bundle.carryicon);
                }
            }
            if (isdefined(m_s_bundle.var_efe5241)) {
                mdl_gameobject gameobjects::set_visible_carrier_model(m_s_bundle.var_efe5241);
            }
            if (isdefined(m_s_bundle.droponusebutton) && m_s_bundle.droponusebutton) {
                mdl_gameobject gameobjects::function_3d736506(m_s_bundle.droponusebutton, 1);
            }
            if (isdefined(m_s_bundle.weapon)) {
                mdl_gameobject gameobjects::function_3c6d0c02(m_s_bundle.weapon);
            }
        }
        mdl_gameobject gameobjects::set_identifier(m_str_identifier);
        mdl_gameobject.origin = m_t_interact.origin;
        mdl_gameobject.angles = m_t_interact.angles;
        mdl_gameobject gameobjects::set_owner_team(m_str_team);
        if (m_str_team == #"any") {
            mdl_gameobject gameobjects::allow_use(m_str_team);
            mdl_gameobject gameobjects::set_visible_team(m_str_team);
        } else {
            mdl_gameobject gameobjects::allow_use(#"friendly");
            mdl_gameobject gameobjects::set_visible_team(#"friendly");
        }
        mdl_gameobject gameobjects::set_use_time(m_n_trigger_use_time);
        mdl_gameobject gameobjects::function_8fcdcc17(var_79cbfce0);
        mdl_gameobject.str_player_scene_anim = m_str_player_scene_anim;
        mdl_gameobject.str_anim = m_str_anim;
        mdl_gameobject.b_reusable = m_b_reusable;
        mdl_gameobject.b_auto_reenable = m_b_auto_reenable;
        mdl_gameobject.allowweapons = m_b_allow_weapons;
        mdl_gameobject.b_scene_use_time_override = m_b_scene_use_time_override;
        mdl_gameobject.b_use_gameobject_for_alignment = m_b_gameobject_scene_alignment;
        mdl_gameobject.var_1746dca5 = var_b4037f88;
        mdl_gameobject.var_9a11b419 = m_s_bundle.var_38c7c0db;
        mdl_gameobject.b_allow_companion_command = m_b_allow_companion_command;
        if (isdefined(m_str_obj_anim)) {
            mdl_gameobject.str_obj_anim = m_str_obj_anim;
        }
        mdl_gameobject.t_interact = m_t_interact;
        mdl_gameobject.t_interact enablelinkto();
        mdl_gameobject.e_object = e_object;
        if (isentity(mdl_gameobject.e_object)) {
            if (isdefined(m_str_tag)) {
                mdl_gameobject.t_interact linkto(mdl_gameobject.e_object, m_str_tag);
            } else {
                mdl_gameobject.t_interact linkto(mdl_gameobject.e_object);
            }
        }
        if (isdefined(mdl_gameobject.str_player_scene_anim) || isdefined(mdl_gameobject.str_anim)) {
            mdl_gameobject.dontlinkplayertotrigger = 1;
        }
        if (!mdl_gameobject.e_object flag::exists("gameobject_end_use")) {
            mdl_gameobject.e_object flag::init("gameobject_end_use");
        }
        e_object.mdl_gameobject = mdl_gameobject;
    }

    // Namespace cinteractobj/gameobjects_shared
    // Params 8, eflags: 0x0
    // Checksum 0x5fae67a5, Offset: 0xec68
    // Size: 0x6f4
    function init_game_object(str_bundle, str_team_override, str_tag_override, str_identifier_override, a_keyline_objects, t_override, b_allow_companion_command = 1, str_objective_override) {
        m_s_bundle = getscriptbundle(str_bundle);
        assert(isdefined(m_s_bundle), "<dev string:x31c>" + str_bundle + "<dev string:x32f>");
        if (isdefined(str_tag_override)) {
            m_str_tag = str_tag_override;
        } else {
            m_str_tag = m_s_bundle.str_tag;
        }
        if (isentity(e_object)) {
            m_v_tag_origin = e_object gettagorigin(m_str_tag);
        }
        if (!isdefined(m_v_tag_origin)) {
            m_str_tag = undefined;
            m_v_tag_origin = e_object.origin;
            /#
                if (isentity(e_object)) {
                    println("<dev string:x351>" + m_s_bundle.str_tag + "<dev string:x364>" + e_object.model);
                }
            #/
        }
        m_n_trigger_height = m_s_bundle.n_trigger_height;
        m_n_trigger_radius = m_s_bundle.n_trigger_radius;
        m_str_team = m_s_bundle.str_team;
        var_dbfe6aeb = m_s_bundle.var_2afa3837;
        var_6865e3a8 = isdefined(m_s_bundle.b_play_vo) && m_s_bundle.b_play_vo;
        m_str_player_scene_anim = m_s_bundle.playerscenebundle;
        m_b_scene_use_time_override = m_s_bundle.playerscenebundletimeoverride;
        m_str_anim = m_s_bundle.viewanim;
        m_str_obj_anim = m_s_bundle.entityanim;
        m_b_reusable = m_s_bundle.b_reusable;
        m_b_auto_reenable = m_s_bundle.autoreenable;
        m_str_identifier = m_s_bundle.str_identifier;
        m_str_trigger_type = m_s_bundle.triggertype;
        m_b_gameobject_scene_alignment = m_s_bundle.playerscenebundlegameobjectalignment;
        var_b4037f88 = m_s_bundle.var_492e0dc0;
        var_67923c70 = m_s_bundle.var_1000a0ad;
        m_n_trigger_use_time = m_s_bundle.n_trigger_use_time;
        if (!isdefined(m_n_trigger_use_time)) {
            m_n_trigger_use_time = 0;
        }
        var_79cbfce0 = m_s_bundle.var_1fce93ec;
        if (!isdefined(var_79cbfce0)) {
            var_79cbfce0 = 0;
        }
        if (isdefined(str_identifier_override)) {
            m_str_identifier = str_identifier_override;
        }
        m_str_hint = m_s_bundle.str_hint;
        if (isdefined(str_objective_override)) {
            m_str_objective = str_objective_override;
        } else {
            m_str_objective = isdefined(m_s_bundle.objective) ? m_s_bundle.objective : undefined;
        }
        e_object.str_objective_name = m_s_bundle.objective;
        e_object.var_be9e5b22 = m_str_objective;
        m_str_type = m_s_bundle.gameobjecttype;
        if (isdefined(m_s_bundle.allowweapons) && m_s_bundle.allowweapons) {
            m_b_allow_weapons = 1;
        } else {
            m_b_allow_weapons = 0;
        }
        if (isdefined(str_team_override)) {
            m_str_team = str_team_override;
        }
        m_str_team = util::get_team_mapping(m_str_team);
        if (isdefined(a_keyline_objects)) {
            m_a_keyline_objects = a_keyline_objects;
        } else if (isdefined(m_s_bundle.model)) {
            var_3318f93e = util::spawn_model(m_s_bundle.model, e_object.origin, e_object.angles);
            m_a_keyline_objects = array(var_3318f93e);
        }
        n_trig_x = m_s_bundle.triggerxoffset;
        if (!isdefined(n_trig_x)) {
            n_trig_x = 0;
        }
        n_trig_y = m_s_bundle.triggeryoffset;
        if (!isdefined(n_trig_y)) {
            n_trig_y = 0;
        }
        n_trig_z = m_s_bundle.triggerzoffset;
        if (!isdefined(n_trig_z)) {
            n_trig_z = 0;
        }
        m_n_trigger_offset = (n_trig_x, n_trig_y, n_trig_z);
        if (isdefined(e_object.func_custom_gameobject_position)) {
            m_n_trigger_offset = (0, 0, 0);
            m_v_tag_origin = e_object [[ e_object.func_custom_gameobject_position ]]();
        }
        m_b_allow_companion_command = b_allow_companion_command;
        if (isdefined(t_override) && isdefined(t_override.classname)) {
            if (is_valid_gameobject_trigger(t_override)) {
                m_t_interact = t_override;
            } else {
                assert("<dev string:x388>");
            }
        }
        var_6103b3ae = [];
        var_b229ee82 = [];
        self create_gameobject_trigger();
        self thread function_a231b3c1();
    }

}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x2
// Checksum 0xe9f9e77e, Offset: 0x418
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"gameobjects", &__init__, undefined, undefined);
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x13024fc1, Offset: 0x460
// Size: 0xe4
function __init__() {
    level.numgametypereservedobjectives = 1;
    level.releasedobjectives = [];
    level.a_gameobjects = [];
    callback::on_spawned(&function_d653ac1c);
    callback::on_vehicle_spawned(&function_d653ac1c);
    callback::on_ai_spawned(&function_d653ac1c);
    callback::on_disconnect(&on_disconnect);
    callback::on_laststand(&on_player_last_stand);
    level thread function_33111018();
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x9498113b, Offset: 0x550
// Size: 0x1a4
function main() {
    level.vehiclesenabled = getgametypesetting(#"vehiclesenabled");
    level.vehiclestimed = getgametypesetting(#"vehiclestimed");
    level.objectivepingdelay = getgametypesetting(#"objectivepingtime");
    level.nonteambasedteam = #"allies";
    if (!isdefined(level.allowedgameobjects)) {
        level.allowedgameobjects = [];
    }
    if (level.vehiclesenabled) {
        level.allowedgameobjects[level.allowedgameobjects.size] = "vehicle";
        filter_script_vehicles_from_vehicle_descriptors(level.allowedgameobjects);
    }
    a_ents = getentarray();
    for (entity_index = a_ents.size - 1; entity_index >= 0; entity_index--) {
        entity = a_ents[entity_index];
        if (!entity_is_allowed(entity, level.allowedgameobjects)) {
            entity delete();
        }
    }
    level thread function_e3e95b90();
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x15c444c1, Offset: 0x700
// Size: 0x46
function register_allowed_gameobject(gameobject) {
    if (!isdefined(level.allowedgameobjects)) {
        level.allowedgameobjects = [];
    }
    level.allowedgameobjects[level.allowedgameobjects.size] = gameobject;
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0xa1a87f21, Offset: 0x750
// Size: 0x12
function clear_allowed_gameobjects() {
    level.allowedgameobjects = [];
}

// Namespace gameobjects/gameobjects_shared
// Params 2, eflags: 0x0
// Checksum 0xfb8a7846, Offset: 0x770
// Size: 0x10c
function entity_is_allowed(entity, allowed_game_modes) {
    allowed = 1;
    if (isdefined(entity.script_gameobjectname) && entity.script_gameobjectname != "[all_modes]") {
        allowed = 0;
        gameobjectnames = strtok(entity.script_gameobjectname, " ");
        for (i = 0; i < allowed_game_modes.size && !allowed; i++) {
            for (j = 0; j < gameobjectnames.size && !allowed; j++) {
                allowed = gameobjectnames[j] == allowed_game_modes[i];
            }
        }
    }
    return allowed;
}

// Namespace gameobjects/gameobjects_shared
// Params 2, eflags: 0x0
// Checksum 0xe1a931ee, Offset: 0x888
// Size: 0x110
function location_is_allowed(entity, location) {
    allowed = 1;
    location_list = undefined;
    if (isdefined(entity.script_noteworthy)) {
        location_list = entity.script_noteworthy;
    }
    if (isdefined(entity.script_location)) {
        location_list = entity.script_location;
    }
    if (isdefined(location_list)) {
        if (location_list == "[all_modes]") {
            allowed = 1;
        } else {
            allowed = 0;
            gameobjectlocations = strtok(location_list, " ");
            for (j = 0; j < gameobjectlocations.size; j++) {
                if (gameobjectlocations[j] == location) {
                    allowed = 1;
                    break;
                }
            }
        }
    }
    return allowed;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x99fae7fd, Offset: 0x9a0
// Size: 0x1d6
function filter_script_vehicles_from_vehicle_descriptors(allowed_game_modes) {
    vehicle_descriptors = getentarray("vehicle_descriptor", "targetname");
    script_vehicles = getentarray("script_vehicle", "classname");
    vehicles_to_remove = [];
    for (descriptor_index = 0; descriptor_index < vehicle_descriptors.size; descriptor_index++) {
        descriptor = vehicle_descriptors[descriptor_index];
        closest_distance_sq = 1e+12;
        closest_vehicle = undefined;
        for (vehicle_index = 0; vehicle_index < script_vehicles.size; vehicle_index++) {
            vehicle = script_vehicles[vehicle_index];
            dsquared = distancesquared(vehicle getorigin(), descriptor getorigin());
            if (dsquared < closest_distance_sq) {
                closest_distance_sq = dsquared;
                closest_vehicle = vehicle;
            }
        }
        if (isdefined(closest_vehicle)) {
            if (!entity_is_allowed(descriptor, allowed_game_modes)) {
                vehicles_to_remove[vehicles_to_remove.size] = closest_vehicle;
            }
        }
    }
    for (vehicle_index = 0; vehicle_index < vehicles_to_remove.size; vehicle_index++) {
        vehicles_to_remove[vehicle_index] delete();
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x86ac5756, Offset: 0xb80
// Size: 0x110
function function_33111018() {
    level.a_s_gameobjects = struct::get_script_bundle_instances("gameobject");
    n_count = 1;
    foreach (s_radiant in level.a_s_gameobjects) {
        if (isdefined(s_radiant.targetname)) {
            s_radiant.str_identifier = s_radiant.targetname + "_" + n_count;
        } else {
            s_radiant.str_identifier = "gameobject_" + n_count;
        }
        n_count++;
        s_radiant.var_492c489b = 1;
        s_radiant init_flags();
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0xc19e2d0a, Offset: 0xc98
// Size: 0x24c
function function_e3e95b90() {
    waittillframeend();
    foreach (s_radiant in level.a_s_gameobjects) {
        if (isdefined(s_radiant.script_team) && s_radiant.script_team != #"none") {
            str_team_override = s_radiant.script_team;
        } else {
            str_team_override = undefined;
        }
        s_radiant init_game_objects(undefined, str_team_override, s_radiant.var_5b4da21d, undefined, undefined, s_radiant.script_objective_override);
        s_radiant disable_object(1);
        if (isdefined(s_radiant.script_enable_on_start) && s_radiant.script_enable_on_start) {
            s_radiant thread enable_object(1);
        }
        if (isdefined(s_radiant.script_carry_object_key_target) && isdefined(s_radiant.script_destroy_keys_after_use) && s_radiant.script_destroy_keys_after_use) {
            s_radiant function_82444b48();
        }
        s_radiant function_a794ba53();
        if (isdefined(s_radiant.script_paired_gameobject)) {
            s_radiant.var_b23bfdbb = struct::get_array(s_radiant.script_paired_gameobject, "script_paired_gameobject");
            s_radiant.mdl_gameobject.b_auto_reenable = 0;
        }
    }
    function_239b0d8a();
    function_555d3681();
    function_bd5840e0();
    level flagsys::set(#"radiant_gameobjects_initialized");
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x4
// Checksum 0xf88fe8c7, Offset: 0xef0
// Size: 0xe4
function private init_flags() {
    self flag::init("enabled");
    self flag::init("success");
    if (isdefined(self.script_flag_true)) {
        util::create_flags_and_return_tokens(self.script_flag_true);
    }
    if (isdefined(self.script_flag_false)) {
        util::create_flags_and_return_tokens(self.script_flag_false);
    }
    if (isdefined(self.script_flag_set_start)) {
        util::create_flags_and_return_tokens(self.script_flag_set_start);
    }
    if (isdefined(self.script_flag_set)) {
        util::create_flags_and_return_tokens(self.script_flag_set);
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x4
// Checksum 0x4d98bc98, Offset: 0xfe0
// Size: 0xd4
function private function_80753d2a() {
    if (self flag::get("enabled")) {
        return;
    }
    self.mdl_gameobject endon(#"death");
    if (!(isdefined(self.mdl_gameobject.var_1b812b8c) && self.mdl_gameobject.var_1b812b8c)) {
        self.mdl_gameobject.var_1b812b8c = 1;
        self util::function_25ed2811();
    }
    self flag::set("enabled");
    if (isdefined(self.script_flag_set_start)) {
        util::function_e59544c3(self.script_flag_set_start);
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 2, eflags: 0x0
// Checksum 0xda683490, Offset: 0x10c0
// Size: 0x54
function function_af0bf601(b_success, b_destroyed) {
    if (level flagsys::get(#"radiant_gameobjects_initialized")) {
        self flag::clear("enabled");
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 3, eflags: 0x4
// Checksum 0x7ec88fd6, Offset: 0x1120
// Size: 0x64
function private function_c3969120(str_team, e_player, b_success = 0) {
    if (b_success) {
        if (isdefined(self.var_b23bfdbb)) {
        }
        if (isdefined(self.script_flag_set)) {
            util::function_e59544c3(self.script_flag_set);
        }
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x4
// Checksum 0x504b117c, Offset: 0x1190
// Size: 0x178
function private function_239b0d8a() {
    foreach (var_ca698447 in trigger::get_all()) {
        var_afd09356 = [];
        foreach (e_gameobject in level.a_gameobjects) {
            if (isdefined(e_gameobject) && isdefined(e_gameobject.e_object) && isdefined(var_ca698447.target) && var_ca698447.target === e_gameobject.e_object.targetname) {
                array::add(var_afd09356, e_gameobject);
            }
        }
        if (var_afd09356.size) {
            if (isdefined(var_ca698447)) {
                var_ca698447 thread function_954cda4a(var_afd09356);
            }
        }
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x4
// Checksum 0x2bccefb1, Offset: 0x1310
// Size: 0xd0
function private function_954cda4a(var_afd09356) {
    self endon(#"death");
    self trigger::wait_till();
    foreach (e_gameobject in var_afd09356) {
        if (isdefined(e_gameobject) && isdefined(e_gameobject.e_object)) {
            e_gameobject.e_object enable_object(1);
        }
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x4
// Checksum 0xe0ace870, Offset: 0x13e8
// Size: 0x248
function private function_555d3681() {
    foreach (s_key in struct::get_script_bundle_instances("gameobject")) {
        if (isdefined(s_key.script_carry_object_key_src)) {
            var_88a8b15 = strtok(s_key.script_carry_object_key_src, " ");
            s_key.a_s_locks = [];
            foreach (var_cb672d6 in var_88a8b15) {
                s_key.a_s_locks = arraycombine(s_key.a_s_locks, struct::get_array(var_cb672d6, "script_carry_object_key_target"), 0, 0);
            }
            foreach (s_lock in s_key.a_s_locks) {
                if (isdefined(s_lock.mdl_gameobject)) {
                    s_lock set_key_object(s_key);
                    continue;
                }
                s_lock.var_fdb4a31e = s_key;
            }
            if (isdefined(s_key.script_toggle_lock_visibility) && s_key.script_toggle_lock_visibility && isdefined(s_key.a_s_locks)) {
                s_key thread function_3e62b47f();
            }
        }
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0xa85a6861, Offset: 0x1638
// Size: 0x24a
function function_3e62b47f() {
    self.mdl_gameobject endon(#"death");
    while (true) {
        self.mdl_gameobject waittill(#"pickup_object");
        self hide_waypoint();
        foreach (s_lock in self.a_s_locks) {
            if (isdefined(s_lock.mdl_gameobject)) {
                s_lock show_waypoint();
                continue;
            }
            if (isdefined(s_lock.var_fdb4a31e)) {
                s_lock notify(#"hash_58b8542ed702b2a5", {#var_60a758b7:1, #player:self.mdl_gameobject.carrier});
                s_lock.var_7724bf42 = 1;
            }
        }
        self.mdl_gameobject waittill(#"dropped");
        self show_waypoint();
        foreach (s_lock in self.a_s_locks) {
            if (isdefined(s_lock.mdl_gameobject)) {
                s_lock function_336b5791(s_lock get_owner_team());
                continue;
            }
            if (isdefined(s_lock.var_fdb4a31e)) {
                s_lock notify(#"hash_58b8542ed702b2a5", {#var_60a758b7:0});
                s_lock.var_7724bf42 = undefined;
            }
        }
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x4
// Checksum 0x93d8bea, Offset: 0x1890
// Size: 0x134
function private function_bd5840e0() {
    foreach (var_49ccb9a5 in struct::get_script_bundle_instances("gameobject")) {
        if (isdefined(var_49ccb9a5.linkto)) {
            a_s_structs = struct::get_array(var_49ccb9a5.linkto, "linkname");
            var_d1f00202 = array::random(a_s_structs);
            if (isdefined(var_d1f00202.mdl_gameobject) && var_d1f00202.mdl_gameobject.type === "carryObject") {
                var_49ccb9a5.mdl_gameobject thread function_d0ac43a3(var_d1f00202.mdl_gameobject);
            }
        }
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x4
// Checksum 0x97ef940f, Offset: 0x19d0
// Size: 0x3ce
function private function_d0ac43a3(var_eeed3388) {
    level endon(#"game_ended");
    self.trigger endon(#"destroyed", #"death");
    var_eeed3388.trigger endon(#"destroyed", #"death");
    self endon(#"death");
    var_eeed3388 endon(#"death");
    self.trigger unlink();
    self.trigger.origin = var_eeed3388.curorigin;
    self.trigger linkto(var_eeed3388);
    self.e_object.origin = var_eeed3388.curorigin;
    self.e_object.angles = var_eeed3388.e_object.angles;
    self.var_7cec2052 = var_eeed3388;
    if (!isdefined(var_eeed3388.var_8d29f8bf)) {
        var_eeed3388.var_8d29f8bf = [];
    } else if (!isarray(var_eeed3388.var_8d29f8bf)) {
        var_eeed3388.var_8d29f8bf = array(var_eeed3388.var_8d29f8bf);
    }
    var_eeed3388.var_8d29f8bf[var_eeed3388.var_8d29f8bf.size] = self;
    while (true) {
        if (isdefined(var_eeed3388.carrier)) {
            if (!(isdefined(self.var_8ec77d4c) && self.var_8ec77d4c)) {
                var_2d13f641 = self.interactteam;
                self.interrupted = 1;
                self allow_use(#"none");
                self set_flags(1);
                self.trigger unlink();
                self.trigger.origin = var_eeed3388.carrier.origin + (0, 0, 64);
                self.trigger linkto(var_eeed3388.carrier);
                var_eeed3388 waittill(#"dropped", #"reset", #"death");
                self set_flags(0);
                self.interrupted = undefined;
                self.trigger unlink();
                self.trigger.origin = var_eeed3388.curorigin + (0, 0, 32);
                self.e_object.origin = var_eeed3388.curorigin;
                self.e_object.angles = var_eeed3388.angles;
                waitframe(2);
                self.trigger linkto(var_eeed3388);
                self allow_use(var_2d13f641);
            }
        }
        waitframe(1);
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 2, eflags: 0x0
// Checksum 0x1dc41d84, Offset: 0x1da8
// Size: 0x124
function function_12fb188(var_3c3f2c9f, var_7b6749b = 0) {
    mdl_gameobject = self function_22fb6ee8();
    mdl_gameobject.trigger unlink();
    if (isvec(var_3c3f2c9f)) {
        mdl_gameobject.trigger.origin = var_3c3f2c9f;
    } else if (isdefined(var_3c3f2c9f.curorigin)) {
        mdl_gameobject.trigger.origin = var_3c3f2c9f.curorigin;
    } else {
        mdl_gameobject.trigger.origin = var_3c3f2c9f.origin;
    }
    if (isentity(var_3c3f2c9f) && var_7b6749b) {
        mdl_gameobject.trigger linkto(var_3c3f2c9f);
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x37b8f3f, Offset: 0x1ed8
// Size: 0x154
function function_a794ba53() {
    if (isdefined(self.target)) {
        a_s_targets = struct::get_array(self.target);
        foreach (s_target in a_s_targets) {
            if (s_target.classname === "scriptbundle_scene") {
                if (!isdefined(self.var_f8f4489b)) {
                    self.var_f8f4489b = [];
                }
                if (!isdefined(self.var_f8f4489b)) {
                    self.var_f8f4489b = [];
                } else if (!isarray(self.var_f8f4489b)) {
                    self.var_f8f4489b = array(self.var_f8f4489b);
                }
                self.var_f8f4489b[self.var_f8f4489b.size] = s_target;
            }
        }
        if (isdefined(self.var_f8f4489b)) {
            self thread function_1add7ced();
        }
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x7ddeb73a, Offset: 0x2038
// Size: 0x22e
function function_1add7ced() {
    self.mdl_gameobject.trigger endon(#"destroyed");
    self.mdl_gameobject endon(#"death");
    self endon(#"hash_767d05d04b5ba2f6");
    while (true) {
        s_waitresult = self.mdl_gameobject waittill(#"gameobject_end_use_player");
        foreach (s_scene in self.var_f8f4489b) {
            if (isplayer(s_waitresult.player) && scene::get_player_count(s_scene.scriptbundlename) >= 1) {
                s_waitresult.player animation::stop(0);
                s_scene thread scene::play(s_waitresult.player);
                continue;
            }
            s_scene thread scene::play();
        }
        foreach (s_scene in self.var_f8f4489b) {
            if (isdefined(s_scene.script_play_multiple) && s_scene.script_play_multiple) {
                continue;
            }
            arrayremovevalue(self.var_f8f4489b, s_scene, 1);
        }
        if (self.var_f8f4489b.size == 0) {
            return;
        }
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x4fac447, Offset: 0x2270
// Size: 0x1a
function set_use_multiplier_callback(callbackfunction) {
    self.getuseratemultiplier = callbackfunction;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x66e28403, Offset: 0x2298
// Size: 0x166
function defaultuseratescalercallback(player) {
    useobj = self;
    characterindex = player getspecialistindex();
    assert(player_role::is_valid(characterindex));
    playerrole = getplayerrolecategory(characterindex, currentsessionmode());
    if (isdefined(playerrole) && isdefined(useobj.bundle)) {
        switch (playerrole) {
        case #"prc_mp_slayer":
            scaler = useobj.bundle.slayer_userate_scaler;
            break;
        case #"prc_mp_objective":
            scaler = useobj.bundle.objective_userate_scaler;
            break;
        case #"prc_mp_support":
            scaler = useobj.bundle.support_userate_scaler;
            break;
        }
    }
    if (!isdefined(scaler)) {
        scaler = 1;
    }
    return scaler;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x3c648dc8, Offset: 0x2408
// Size: 0x196
function defaultallowweaponscallback(object) {
    player = self;
    characterindex = player getspecialistindex();
    assert(player_role::is_valid(characterindex));
    playerrole = getplayerrolecategory(characterindex, currentsessionmode());
    if (isdefined(playerrole) && isdefined(object.bundle)) {
        switch (playerrole) {
        case #"prc_mp_slayer":
            return (isdefined(object.bundle.slayer_allow_weapons) && object.bundle.slayer_allow_weapons);
        case #"prc_mp_objective":
            return (isdefined(object.bundle.objective_allow_weapons) && object.bundle.objective_allow_weapons);
        case #"prc_mp_support":
            return (isdefined(object.bundle.support_allow_weapons) && object.bundle.support_allow_weapons);
        }
    }
    return object.allowweapons;
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x6edd40d5, Offset: 0x25a8
// Size: 0x56
function function_d653ac1c() {
    self.touchtriggers = [];
    self.packobject = [];
    self.packicon = [];
    self.carryobject = undefined;
    self.claimtrigger = undefined;
    self.canpickupobject = 1;
    self.disabledweapon = 0;
    self.killedinuse = undefined;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xecd8bbea, Offset: 0x2608
// Size: 0x3c
function function_252df564(params) {
    if (game.state != "playing") {
        return;
    }
    self thread gameobjects_dropped();
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x6f5f1a8c, Offset: 0x2650
// Size: 0x1c
function on_disconnect() {
    self thread gameobjects_dropped();
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x378c730a, Offset: 0x2678
// Size: 0x1c
function on_player_last_stand() {
    self thread gameobjects_dropped();
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x86870248, Offset: 0x26a0
// Size: 0xc0
function gameobjects_dropped() {
    if (isdefined(self.carryobject)) {
        self.carryobject thread set_dropped();
    }
    if (isdefined(self.packobject) && self.packobject.size > 0) {
        foreach (item in self.packobject) {
            item thread set_dropped();
        }
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x53e4d535, Offset: 0x2768
// Size: 0x3a
function function_7efc3a2f() {
    if (!isdefined(self.trigger.var_198df85d)) {
        return true;
    }
    if (self.trigger.var_198df85d) {
        return true;
    }
    return false;
}

// Namespace gameobjects/gameobjects_shared
// Params 8, eflags: 0x0
// Checksum 0x200d429d, Offset: 0x27b0
// Size: 0x6a6
function create_carry_object(ownerteam, trigger, visuals, offset, objectivename, hitsound, allowinitialholddelay = 0, allowweaponcyclingduringhold = 0) {
    carryobject = spawn("script_model", trigger.origin);
    carryobject.type = "carryObject";
    carryobject.curorigin = trigger.origin;
    carryobject.entnum = trigger getentitynumber();
    carryobject.hitsound = hitsound;
    if (issubstr(trigger.classname, "use")) {
        carryobject.triggertype = "use";
    } else {
        carryobject.triggertype = "proximity";
    }
    trigger.baseorigin = trigger.origin;
    carryobject.trigger = trigger;
    trigger enablelinkto();
    carryobject linkto(trigger);
    carryobject.useweapon = undefined;
    if (!isdefined(offset)) {
        offset = (0, 0, 0);
    }
    for (index = 0; index < visuals.size; index++) {
        visuals[index].baseorigin = visuals[index].origin;
        visuals[index].baseangles = visuals[index].angles;
    }
    carryobject.visuals = visuals;
    carryobject _set_team(ownerteam);
    carryobject.compassicons = [];
    carryobject.objidpingfriendly = 0;
    carryobject.objidpingenemy = 0;
    if (carryobject function_7efc3a2f()) {
        assert(isdefined(objectivename), "<dev string:x30>");
        carryobject.objid = [];
        level.objidstart += 2;
        carryobject.objectiveid = get_next_obj_id();
        objective_add(carryobject.objectiveid, "invisible", carryobject.curorigin, objectivename);
    }
    carryobject.carrier = undefined;
    carryobject.isresetting = 0;
    carryobject.interactteam = #"none";
    carryobject.allowweapons = 0;
    carryobject.visiblecarriermodel = undefined;
    carryobject.dropoffset = 0;
    carryobject.disallowremotecontrol = 0;
    carryobject.var_9c48a02d = 1;
    carryobject.worldicons = [];
    carryobject.carriervisible = 0;
    carryobject.visibleteam = #"none";
    carryobject.worldiswaypoint = [];
    carryobject.worldicons_disabled = [];
    carryobject.carryicon = undefined;
    carryobject.setdropped = undefined;
    carryobject.ondrop = undefined;
    carryobject.onpickup = undefined;
    carryobject.onreset = undefined;
    carryobject.usetime = 10000;
    carryobject.decayprogress = 0;
    carryobject.var_9d9c7b7 = 1;
    carryobject.var_ccca48dc = 0;
    carryobject clear_progress();
    if (carryobject.triggertype == "use") {
        carryobject.trigger setcursorhint("HINT_INTERACTIVE_PROMPT");
        carryobject.userate = 1;
        carryobject thread use_object_use_think(!allowinitialholddelay, !allowweaponcyclingduringhold);
        if (!carryobject function_7efc3a2f() && isdefined(carryobject.trigger.str_hint)) {
            carryobject.trigger setcursorhint("HINT_NOICON");
            carryobject.trigger sethintstring(carryobject.trigger.str_hint);
        }
    } else {
        carryobject setup_touching();
        carryobject.curprogress = 0;
        carryobject.userate = 0;
        carryobject.claimteam = #"none";
        carryobject.claimplayer = undefined;
        carryobject.lastclaimteam = #"none";
        carryobject.lastclaimtime = 0;
        carryobject.claimgraceperiod = 0;
        carryobject.mustmaintainclaim = 0;
        carryobject.cancontestclaim = 0;
        carryobject.teamusetimes = [];
        carryobject.teamusetexts = [];
        carryobject thread use_object_prox_think();
    }
    carryobject.getuseratemultiplier = &defaultuseratescalercallback;
    carryobject.allowweaponscallback = &defaultallowweaponscallback;
    if (carryobject function_7efc3a2f()) {
        carryobject thread update_carry_object_objective_origin();
    }
    array::add(level.a_gameobjects, carryobject, 0);
    carryobject.b_reusable = 1;
    return carryobject;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xd4404037, Offset: 0x2e60
// Size: 0x1a
function function_c64a0782(soundalias) {
    self.var_5b7c9503 = soundalias;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xb1ee9605, Offset: 0x2e88
// Size: 0x92
function pickup_object_delay(origin) {
    level endon(#"game_ended");
    self endon(#"death");
    self endon(#"disconnect");
    self.canpickupobject = 0;
    for (;;) {
        if (distancesquared(self.origin, origin) > 4096) {
            break;
        }
        wait 0.2;
    }
    self.canpickupobject = 1;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x6ce39a8c, Offset: 0x2f28
// Size: 0x214
function set_picked_up(player) {
    if (!isalive(player)) {
        return;
    }
    if (self.type == "carryObject") {
        if (isdefined(player.carryobject)) {
            if (isdefined(player.carryobject.swappable) && player.carryobject.swappable) {
                player.carryobject thread set_dropped();
            } else {
                if (isdefined(self.onpickupfailed)) {
                    self [[ self.onpickupfailed ]](player);
                }
                return;
            }
        }
        player give_object(self);
    } else if (self.type == "packObject") {
        if (isdefined(level.max_packobjects) && level.max_packobjects <= player.packobject.size) {
            if (isdefined(self.onpickupfailed)) {
                self [[ self.onpickupfailed ]](player);
            }
            return;
        }
        player give_pack_object(self);
    }
    self set_carrier(player);
    self ghost_visuals();
    self.trigger triggerenable(0);
    self notify(#"pickup_object");
    if (isdefined(self.onpickup)) {
        self [[ self.onpickup ]](player);
    }
    if (isdefined(self.var_5b7c9503)) {
        self playsound(self.var_5b7c9503);
    }
    self update_objective();
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x50cd4af5, Offset: 0x3148
// Size: 0x1e0
function unlink_grenades() {
    radius = 32;
    origin = self.origin;
    grenades = getentarray("grenade", "classname");
    radiussq = radius * radius;
    linkedgrenades = [];
    foreach (grenade in grenades) {
        if (distancesquared(origin, grenade.origin) < radiussq) {
            if (grenade islinkedto(self)) {
                grenade unlink();
                linkedgrenades[linkedgrenades.size] = grenade;
            }
        }
    }
    waittillframeend();
    foreach (grenade in linkedgrenades) {
        grenade launch((randomfloatrange(-5, 5), randomfloatrange(-5, 5), 5));
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x7d54c552, Offset: 0x3330
// Size: 0x90
function ghost_visuals() {
    foreach (visual in self.visuals) {
        visual ghost();
        visual thread unlink_grenades();
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x56bfb32b, Offset: 0x33c8
// Size: 0x11e
function update_carry_object_objective_origin() {
    self endon(#"hash_431541b507a8c588");
    level endon(#"game_ended");
    self.trigger endon(#"destroyed", #"death");
    objpingdelay = level.objectivepingdelay;
    for (;;) {
        if (isdefined(self.carrier)) {
            self.curorigin = self.carrier.origin;
            if (isdefined(self.objectiveid)) {
                objective_setposition(self.objectiveid, self.curorigin);
            }
            self util::wait_endon(objpingdelay, "dropped", "reset");
            continue;
        }
        if (isdefined(self.objectiveid)) {
            objective_setposition(self.objectiveid, self.curorigin);
        }
        waitframe(1);
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xbe57383b, Offset: 0x34f0
// Size: 0x2e4
function give_object(object) {
    assert(!isdefined(self.carryobject));
    self.carryobject = object;
    self callback::on_death(&function_252df564);
    self thread track_carrier(object);
    allowweapons = object.allowweapons;
    if (isdefined(object.allowweaponscallback)) {
        allowweapons = [[ object.allowweaponscallback ]](object);
    }
    if (isdefined(object.carryweapon)) {
        if (isdefined(object.carryweaponthink)) {
            self thread [[ object.carryweaponthink ]]();
        }
        count = 0;
        while (self ismeleeing() && count < 10) {
            count++;
            wait 0.2;
        }
        self giveweapon(object.carryweapon);
        if (self isswitchingweapons()) {
            self waittilltimeout(2, #"weapon_change");
        }
        self switchtoweaponimmediate(object.carryweapon);
        self setblockweaponpickup(object.carryweapon, 1);
        self disableweaponcycling();
    } else if (!allowweapons) {
        self val::set(#"carry_object", "disable_weapons");
        if (!(isdefined(object.droponusebutton) && object.droponusebutton)) {
            self thread manual_drop_think();
        }
    }
    if (isdefined(object.droponusebutton) && object.droponusebutton) {
        if (object.droponusehasdelay === 1) {
            self thread droponholdusebutton();
        } else {
            self thread droponusebutton();
        }
    }
    self.disallowvehicleusage = 1;
    if (isdefined(object.visiblecarriermodel)) {
        self weapons::force_stowed_weapon_update();
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x551e4e27, Offset: 0x37e0
// Size: 0xc0
function move_visuals_to_base() {
    foreach (visual in self.visuals) {
        visual.origin = visual.baseorigin;
        visual.angles = visual.baseangles;
        visual dontinterpolate();
        visual show();
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0xc484a9be, Offset: 0x38a8
// Size: 0x1a6
function return_home() {
    self.isresetting = 1;
    prev_origin = self.trigger.origin;
    self notify(#"reset");
    self move_visuals_to_base();
    self.trigger.origin = self.trigger.baseorigin;
    self.curorigin = self.trigger.origin;
    if (isdefined(self.e_object)) {
        self.e_object.origin = self.curorigin;
    }
    if (isdefined(self.var_8d29f8bf)) {
        foreach (var_95b88142 in self.var_8d29f8bf) {
            if (isdefined(var_95b88142) && isdefined(var_95b88142.e_object)) {
                var_95b88142.e_object.origin = self.curorigin;
            }
        }
    }
    if (isdefined(self.onreset)) {
        self [[ self.onreset ]](prev_origin);
    }
    self clear_carrier();
    update_objective();
    self.isresetting = 0;
}

// Namespace gameobjects/gameobjects_shared
// Params 2, eflags: 0x0
// Checksum 0x8747cb31, Offset: 0x3a58
// Size: 0xda
function set_new_base_position(v_base_pos, v_angles) {
    mdl_gameobject = self function_22fb6ee8();
    foreach (visual in mdl_gameobject.visuals) {
        visual.baseorigin = v_base_pos;
        if (isdefined(v_angles)) {
            visual.baseangles = v_angles;
        }
    }
    mdl_gameobject.trigger.baseorigin = v_base_pos;
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0xb625d0f7, Offset: 0x3b40
// Size: 0x52
function is_object_away_from_home() {
    if (isdefined(self.carrier)) {
        return true;
    }
    if (distancesquared(self.trigger.origin, self.trigger.baseorigin) > 4) {
        return true;
    }
    return false;
}

// Namespace gameobjects/gameobjects_shared
// Params 2, eflags: 0x0
// Checksum 0xfde69311, Offset: 0x3ba0
// Size: 0x25a
function set_position(origin, angles) {
    mdl_gameobject = self function_22fb6ee8();
    mdl_gameobject.isresetting = 1;
    foreach (visual in mdl_gameobject.visuals) {
        visual.origin = origin;
        visual.angles = angles;
        visual dontinterpolate();
        visual show();
    }
    mdl_gameobject.trigger set_trigger_origin(origin);
    mdl_gameobject.curorigin = origin;
    if (isdefined(mdl_gameobject.e_object)) {
        mdl_gameobject.e_object.origin = origin;
        mdl_gameobject.e_object.angles = angles;
    }
    mdl_gameobject clear_carrier();
    mdl_gameobject update_objective();
    mdl_gameobject.isresetting = 0;
    if (isdefined(mdl_gameobject.var_8d29f8bf)) {
        foreach (var_95b88142 in mdl_gameobject.var_8d29f8bf) {
            if (isdefined(var_95b88142) && isdefined(var_95b88142.e_object)) {
                var_95b88142.e_object.origin = origin;
                var_95b88142.e_object.angles = angles;
            }
        }
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x359a5f9f, Offset: 0x3e08
// Size: 0x36
function set_drop_offset(height) {
    mdl_gameobject = function_22fb6ee8();
    mdl_gameobject.dropoffset = height;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x88c7326d, Offset: 0x3e48
// Size: 0x9a
function set_trigger_origin(origin) {
    offset = (self.maxs[2] - self.mins[2]) / 2;
    self.origin = (origin[0], origin[1], origin[2] + offset);
    if (isvec(self.trigger_offset)) {
        self.origin += self.trigger_offset;
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x87f33d88, Offset: 0x3ef0
// Size: 0x79e
function set_dropped(var_95fdad91) {
    if (isdefined(self.carrier) && isdefined(self.objectiveid)) {
        objective_setvisibletoplayer(self.objectiveid, self.carrier);
    }
    if (self.type == "carryObject" && isdefined(self.droptrigger)) {
        self.droptrigger delete();
    }
    if (isdefined(self.setdropped)) {
        if ([[ self.setdropped ]]()) {
            return;
        }
    }
    if (isdefined(self.var_8ccbb92c)) {
        self thread [[ self.var_8ccbb92c ]](var_95fdad91);
        return;
    }
    self.isresetting = 1;
    self notify(#"dropped");
    startorigin = (0, 0, 0);
    endorigin = (0, 0, 0);
    body = undefined;
    if (isdefined(self.carrier) && self.carrier.team != #"spectator") {
        startorigin = self.carrier.origin + (0, 0, 20);
        endorigin = self.carrier.origin - (0, 0, 2000);
        body = self.carrier.body;
    } else if (isdefined(self.safeorigin)) {
        startorigin = self.safeorigin + (0, 0, 20);
        endorigin = self.safeorigin - (0, 0, 20);
    } else {
        startorigin = self.curorigin + (0, 0, 20);
        endorigin = self.curorigin - (0, 0, 20);
    }
    if (isplayer(var_95fdad91)) {
        var_eba10f07 = var_95fdad91;
    } else {
        var_eba10f07 = self.carrier;
    }
    trace_size = 10;
    trace = physicstrace(startorigin, endorigin, (trace_size * -1, trace_size * -1, trace_size * -1), (trace_size, trace_size, trace_size), var_eba10f07, 32);
    droppingplayer = var_eba10f07;
    self clear_carrier();
    if (isdefined(trace)) {
        tempangle = randomfloat(360);
        droporigin = trace[#"position"] + (0, 0, self.dropoffset);
        if (trace[#"fraction"] < 1) {
            forward = (cos(tempangle), sin(tempangle), 0);
            forward = vectornormalize(forward - vectorscale(trace[#"normal"], vectordot(forward, trace[#"normal"])));
            if (isdefined(trace[#"walkable"])) {
                if (trace[#"walkable"] == 0) {
                    end_reflect = forward * 1000 + trace[#"position"];
                    reflect_trace = physicstrace(trace[#"position"], end_reflect, (trace_size * -1, trace_size * -1, trace_size * -1), (trace_size, trace_size, trace_size), self, 32);
                    if (isdefined(reflect_trace)) {
                        droporigin = reflect_trace[#"position"] + (0, 0, self.dropoffset);
                        if (reflect_trace[#"fraction"] < 1) {
                            forward = (cos(tempangle), sin(tempangle), 0);
                            forward = vectornormalize(forward - vectorscale(reflect_trace[#"normal"], vectordot(forward, reflect_trace[#"normal"])));
                        }
                    }
                }
            }
            dropangles = vectortoangles(forward);
        } else {
            dropangles = (0, tempangle, 0);
        }
        foreach (visual in self.visuals) {
            visual animation::stop(0);
            visual.origin = droporigin;
            visual.angles = dropangles;
            visual dontinterpolate();
            visual show();
        }
        self.trigger set_trigger_origin(droporigin);
        self.curorigin = droporigin;
        if (isdefined(self.e_object)) {
            self.e_object.origin = droporigin;
            self.e_object.angles = dropangles;
        }
        self thread pickup_timeout(trace[#"position"][2], startorigin[2]);
    } else {
        self move_visuals_to_base();
        self.trigger.origin = self.trigger.baseorigin;
        self.curorigin = self.trigger.baseorigin;
    }
    if (isdefined(self.ondrop)) {
        self [[ self.ondrop ]](droppingplayer);
    }
    self.trigger triggerenable(1);
    self update_objective();
    self.isresetting = 0;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x581c1f93, Offset: 0x4698
// Size: 0x54
function set_carrier(carrier) {
    self.carrier = carrier;
    self notify(#"reset");
    if (isdefined(self.objectiveid)) {
        objective_setplayerusing(self.objectiveid, carrier);
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0xd6efeb52, Offset: 0x46f8
// Size: 0x32
function get_carrier() {
    mdl_gameobject = self function_22fb6ee8();
    return mdl_gameobject.carrier;
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x89a41404, Offset: 0x4738
// Size: 0xbe
function clear_carrier() {
    if (!isdefined(self.carrier)) {
        return;
    }
    self.carrier callback::remove_on_death(&function_252df564);
    self.carrier take_object(self);
    if (isdefined(self.objectiveid)) {
        objective_clearplayerusing(self.objectiveid, self.carrier);
        objective_setvisibletoplayer(self.objectiveid, self.carrier);
    }
    self.carrier = undefined;
    self notify(#"carrier_cleared");
}

// Namespace gameobjects/gameobjects_shared
// Params 3, eflags: 0x0
// Checksum 0xa3a717b5, Offset: 0x4800
// Size: 0xa2
function is_touching_any_trigger(triggers, minz, maxz) {
    foreach (trigger in triggers) {
        if (self istouchingswept(trigger, minz, maxz)) {
            return true;
        }
    }
    return false;
}

// Namespace gameobjects/gameobjects_shared
// Params 4, eflags: 0x0
// Checksum 0xc143ea6b, Offset: 0x48b0
// Size: 0x52
function is_touching_any_trigger_key_value(value, key, minz, maxz) {
    return self is_touching_any_trigger(getentarray(value, key), minz, maxz);
}

// Namespace gameobjects/gameobjects_shared
// Params 2, eflags: 0x0
// Checksum 0x226a5ae3, Offset: 0x4910
// Size: 0x1c2
function should_be_reset(minz, maxz) {
    if (self.visuals[0] is_touching_any_trigger_key_value("minefield", "targetname", minz, maxz)) {
        return true;
    }
    if (self.visuals[0] is_touching_any_trigger_key_value("trigger_hurt_new", "classname", minz, maxz)) {
        return true;
    }
    level.oob_triggers = array::remove_undefined(level.oob_triggers);
    if (self.visuals[0] is_touching_any_trigger(level.oob_triggers, minz, maxz)) {
        return true;
    }
    elevators = getentarray("script_elevator", "targetname");
    foreach (elevator in elevators) {
        assert(isdefined(elevator.occupy_volume));
        if (self.visuals[0] istouchingswept(elevator.occupy_volume, minz, maxz)) {
            return true;
        }
    }
    return false;
}

// Namespace gameobjects/gameobjects_shared
// Params 2, eflags: 0x0
// Checksum 0xc7a37ad2, Offset: 0x4ae0
// Size: 0x2cc
function pickup_timeout(minz, maxz) {
    self endon(#"pickup_object", #"reset", #"death");
    waitframe(1);
    if (self should_be_reset(minz, maxz)) {
        self thread return_home();
        return;
    } else if (self.var_9c48a02d && !ispointonnavmesh(self.visuals[0].origin, 32)) {
        v_pos = getclosestpointonnavmesh(self.visuals[0].origin, 256, 16);
        if (!isdefined(v_pos) || sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
            self thread return_home();
            return;
        }
        v_drop = v_pos + (0, 0, self.dropoffset);
        foreach (visual in self.visuals) {
            visual animation::stop(0);
            visual.origin = v_drop;
            visual dontinterpolate();
            visual show();
        }
        self.trigger set_trigger_origin(v_drop);
        self.curorigin = v_drop;
        if (isdefined(self.e_object)) {
            self.e_object.origin = v_drop;
        }
    }
    if (isdefined(self.pickuptimeoutoverride)) {
        self thread [[ self.pickuptimeoutoverride ]]();
        return;
    }
    if (isdefined(self.autoresettime)) {
        wait self.autoresettime;
        if (!isdefined(self.carrier)) {
            self thread return_home();
        }
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xef79c55b, Offset: 0x4db8
// Size: 0x324
function take_object(object) {
    if (isdefined(object.visiblecarriermodel)) {
        self weapons::detach_all_weapons();
    }
    shouldenableweapon = 1;
    if (isdefined(object.carryweapon) && !isdefined(self.player_disconnected)) {
        shouldenableweapon = 0;
        self thread wait_take_carry_weapon(object.carryweapon);
    }
    if (object.type == "carryObject") {
        /#
            if (isdefined(self.carryicon)) {
                self.carryicon hud::destroyelem();
            }
        #/
        self.carryobject = undefined;
    } else if (object.type == "packObject") {
        if (isdefined(self.packicon) && self.packicon.size > 0) {
            for (i = 0; i < self.packicon.size; i++) {
                if (isdefined(self.packicon[i].script_string)) {
                    if (self.packicon[i].script_string == object.packicon) {
                        elem = self.packicon[i];
                        arrayremovevalue(self.packicon, elem);
                        /#
                            elem hud::destroyelem();
                        #/
                        self thread adjust_remaining_packicons();
                    }
                }
            }
        }
        arrayremovevalue(self.packobject, object);
    }
    if (!isalive(self) || isdefined(self.player_disconnected)) {
        return;
    }
    self notify(#"drop_object");
    self.disallowvehicleusage = 0;
    if (object.triggertype == "proximity") {
        self thread pickup_object_delay(object.trigger.origin);
    }
    if (isdefined(object.visiblecarriermodel)) {
        self weapons::force_stowed_weapon_update();
    }
    allowweapons = object.allowweapons;
    if (isdefined(object.allowweaponscallback)) {
        allowweapons = [[ object.allowweaponscallback ]](object);
    }
    if (!allowweapons && shouldenableweapon) {
        self val::reset(#"carry_object", "disable_weapons");
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x35d15681, Offset: 0x50e8
// Size: 0x8c
function wait_take_carry_weapon(weapon) {
    self thread take_carry_weapon_on_death(weapon);
    wait max(0, weapon.firetime - 2 * float(function_f9f48566()) / 1000);
    self take_carry_weapon(weapon);
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x6c467c15, Offset: 0x5180
// Size: 0x4c
function take_carry_weapon_on_death(weapon) {
    self endon(#"take_carry_weapon");
    self waittill(#"death");
    self take_carry_weapon(weapon);
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xc94c7fbe, Offset: 0x51d8
// Size: 0x134
function take_carry_weapon(weapon) {
    self notify(#"take_carry_weapon");
    if (self hasweapon(weapon, 1)) {
        ballweapon = getweapon(#"ball");
        currweapon = self getcurrentweapon();
        if (weapon == ballweapon && currweapon === ballweapon) {
            self killstreaks::switch_to_last_non_killstreak_weapon(undefined, 1);
        }
        self setblockweaponpickup(weapon, 0);
        self takeweapon(weapon);
        self enableweaponcycling();
        if (level.gametype == "ball") {
            self enableoffhandweapons();
        }
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x4eec2188, Offset: 0x5318
// Size: 0x6e
function function_3c6d0c02(weapon) {
    assert(isweapon(weapon), "<dev string:x60>");
    mdl_gameobject = self function_22fb6ee8();
    mdl_gameobject.carryweapon = weapon;
}

// Namespace gameobjects/gameobjects_shared
// Params 2, eflags: 0x0
// Checksum 0xe4c04c37, Offset: 0x5390
// Size: 0x56
function function_3d736506(var_d95da1f1, b_delay) {
    mdl_gameobject = self function_22fb6ee8();
    mdl_gameobject.droponusebutton = var_d95da1f1;
    mdl_gameobject.droponusehasdelay = b_delay;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x6e35b32b, Offset: 0x53f0
// Size: 0x144
function track_carrier(object) {
    level endon(#"game_ended");
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"drop_object");
    waitframe(1);
    while (isdefined(object.carrier) && object.carrier == self && isalive(self)) {
        if (self isonground()) {
            trace = bullettrace(self.origin + (0, 0, 20), self.origin - (0, 0, 20), 0, undefined);
            if (trace[#"fraction"] < 1) {
                object.safeorigin = trace[#"position"];
            }
        }
        waitframe(1);
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0xfee8c203, Offset: 0x5540
// Size: 0x168
function manual_drop_think() {
    level endon(#"game_ended");
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"drop_object");
    for (;;) {
        while (self attackbuttonpressed() || self fragbuttonpressed() || self secondaryoffhandbuttonpressed() || self meleebuttonpressed()) {
            waitframe(1);
        }
        while (!self attackbuttonpressed() && !self fragbuttonpressed() && !self secondaryoffhandbuttonpressed() && !self meleebuttonpressed()) {
            waitframe(1);
        }
        if (isdefined(self.carryobject) && !self usebuttonpressed()) {
            self.carryobject thread set_dropped();
        }
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0xb322fa30, Offset: 0x56b0
// Size: 0xb4
function droponusebutton() {
    level endon(#"game_ended");
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"drop_object");
    while (self usebuttonpressed()) {
        waitframe(1);
    }
    while (!self usebuttonpressed()) {
        waitframe(1);
    }
    if (isdefined(self.carryobject)) {
        self.carryobject thread set_dropped();
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x579fa566, Offset: 0x5778
// Size: 0x2d0
function watchholdusedrop() {
    level endon(#"game_ended");
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"drop_object");
    assert(isdefined(self.carryobject));
    assert(isdefined(self.carryobject.droptrigger));
    trigger = self.carryobject.droptrigger;
    while (true) {
        waitresult = trigger waittill(#"trigger");
        if (self usebuttonpressed() && !self.throwinggrenade && !self meleebuttonpressed() && !self attackbuttonpressed() && !(isdefined(self.isplanting) && self.isplanting) && !(isdefined(self.isdefusing) && self.isdefusing) && !self isremotecontrolling()) {
            if (isdefined(self.carryobject)) {
                if (!isdefined(self.carryobject.ignore_use_time)) {
                    self.carryobject.ignore_use_time = [];
                }
                self.carryobject.ignore_use_time[self getentitynumber()] = level.time + 500;
                self sethintstring("");
                if (!self.carryobject function_7efc3a2f() && isdefined(self.carryobject.trigger.str_hint)) {
                    self.carryobject.trigger setcursorhint("HINT_NOICON");
                    self.carryobject.trigger sethintstring(self.carryobject.trigger.str_hint);
                }
                self.carryobject thread set_dropped();
            }
        }
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x3fd7997d, Offset: 0x5a50
// Size: 0x264
function droponholdusebutton() {
    level endon(#"game_ended");
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"drop_object");
    if (!isdefined(self.carryobject)) {
        return;
    }
    while (self usebuttonpressed()) {
        waitframe(1);
    }
    if (!isdefined(self.carryobject.droptrigger)) {
        pos = self.origin + (0, 0, 15);
        self.carryobject.droptrigger = spawn("trigger_radius_use", pos);
    }
    self.carryobject.droptrigger sethintlowpriority(1);
    self.carryobject.droptrigger sethintstring(#"hash_7944e4820b9c7227");
    self.carryobject.droptrigger setcursorhint("HINT_NOICON", self.carryobject);
    self.carryobject.droptrigger enablelinkto();
    self.carryobject.droptrigger linkto(self, "tag_origin", (0, 0, 15));
    self.carryobject.droptrigger setteamfortrigger(self.team);
    self.carryobject.droptrigger setinvisibletoall();
    self.carryobject.droptrigger setvisibletoplayer(self);
    self clientclaimtrigger(self.carryobject.droptrigger);
    self thread watchholdusedrop();
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x4
// Checksum 0xb565347a, Offset: 0x5cc0
// Size: 0x15c
function private setup_touching() {
    self.var_c518b47a = 0;
    self.touchinguserate[#"neutral"] = 0;
    self.touchinguserate[#"none"] = 0;
    self.numtouching[#"neutral"] = 0;
    self.numtouching[#"none"] = 0;
    self.touchlist[#"neutral"] = [];
    self.touchlist[#"none"] = [];
    foreach (team, _ in level.teams) {
        self.touchinguserate[team] = 0;
        self.numtouching[team] = 0;
        self.touchlist[team] = [];
    }
    if (self.var_ccca48dc) {
        self function_d16ad285();
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x4
// Checksum 0xec2fc89a, Offset: 0x5e28
// Size: 0xaa
function private function_d16ad285() {
    self.var_17a75d13[#"neutral"] = [];
    self.var_17a75d13[#"none"] = [];
    foreach (team, _ in level.teams) {
        self.var_17a75d13[team] = [];
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 4, eflags: 0x0
// Checksum 0xddd4e504, Offset: 0x5ee0
// Size: 0x32e
function create_generic_object(ownerteam, trigger, visuals, offset) {
    generic_object = spawn("script_model", trigger.origin);
    generic_object.type = "GenericObject";
    generic_object.curorigin = trigger.origin;
    generic_object.entnum = trigger getentitynumber();
    generic_object.keyobject = undefined;
    generic_object.triggertype = "proximity";
    generic_object.trigger = trigger;
    generic_object linkto(trigger);
    for (index = 0; index < visuals.size; index++) {
        visuals[index].baseorigin = visuals[index].origin;
        visuals[index].baseangles = visuals[index].angles;
    }
    generic_object.visuals = visuals;
    generic_object _set_team(ownerteam);
    if (!isdefined(offset)) {
        offset = (0, 0, 0);
    }
    if (sessionmodeiscampaigngame()) {
        generic_object.keepweapon = 1;
    }
    generic_object.interactteam = #"none";
    generic_object.onuse = undefined;
    generic_object.oncantuse = undefined;
    generic_object.onresumeuse = undefined;
    generic_object.usetime = 10000;
    generic_object.decayprogress = 0;
    generic_object.var_9d9c7b7 = 1;
    generic_object.var_ccca48dc = 0;
    generic_object clear_progress();
    if (generic_object.triggertype == "proximity") {
        generic_object setup_touching();
        generic_object.teamusetimes = [];
        generic_object.teamusetexts = [];
        generic_object.userate = 0;
        generic_object.claimteam = #"none";
        generic_object.claimplayer = undefined;
        generic_object.lastclaimteam = #"none";
        generic_object.lastclaimtime = 0;
        generic_object.claimgraceperiod = 1;
        generic_object.mustmaintainclaim = 0;
        generic_object.cancontestclaim = 0;
    }
    array::add(level.a_gameobjects, generic_object, 0);
    generic_object.b_reusable = 1;
    return generic_object;
}

// Namespace gameobjects/gameobjects_shared
// Params 8, eflags: 0x0
// Checksum 0xa2b44bc1, Offset: 0x6218
// Size: 0x5b6
function create_use_object(ownerteam, trigger, visuals, offset, objectivename, allowinitialholddelay = 0, allowweaponcyclingduringhold = 0, start_enabled = 1) {
    useobject = spawn("script_model", trigger.origin);
    useobject.type = "useObject";
    useobject.curorigin = trigger.origin;
    useobject.entnum = trigger getentitynumber();
    useobject.keyobject = undefined;
    if (issubstr(trigger.classname, "use")) {
        useobject.triggertype = "use";
    } else {
        useobject.triggertype = "proximity";
    }
    if (visuals.size > 0) {
        useobject.angles = visuals[0].angles;
    }
    useobject.trigger = trigger;
    useobject linkto(trigger);
    for (index = 0; index < visuals.size; index++) {
        visuals[index].baseorigin = visuals[index].origin;
        visuals[index].baseangles = visuals[index].angles;
    }
    useobject.visuals = visuals;
    useobject _set_team(ownerteam);
    if (!isdefined(offset)) {
        offset = (0, 0, 0);
    }
    if (sessionmodeiscampaigngame()) {
        useobject.keepweapon = 1;
    }
    useobject.compassicons = [];
    if (useobject function_7efc3a2f()) {
        assert(isdefined(objectivename), "<dev string:x97>");
        useobject.objid = [];
        useobject.var_977e04c1 = objectivename;
        useobject.var_a279243a = &function_dd8869dd;
        if (isdefined(start_enabled) && start_enabled) {
            useobject enable_object();
        }
    } else if (isdefined(useobject.trigger.str_hint)) {
        useobject.trigger setcursorhint("HINT_NOICON");
        useobject.trigger sethintstring(useobject.trigger.str_hint);
    }
    useobject.interactteam = #"none";
    useobject.worldicons = [];
    useobject.visibleteam = #"none";
    useobject.worldiswaypoint = [];
    useobject.worldicons_disabled = [];
    useobject.onuse = undefined;
    useobject.oncantuse = undefined;
    useobject.onresumeuse = undefined;
    useobject.usetext = "default";
    useobject.usetime = 10000;
    useobject.decayprogress = 0;
    useobject.var_9d9c7b7 = 1;
    useobject.var_ccca48dc = 1;
    useobject.curprogress = 0;
    useobject.decayprogressmin = 0;
    if (useobject.triggertype == "proximity") {
        useobject setup_touching();
        useobject.teamusetimes = [];
        useobject.teamusetexts = [];
        useobject.userate = 0;
        useobject.claimteam = #"none";
        useobject.claimplayer = undefined;
        useobject.lastclaimteam = #"none";
        useobject.lastclaimtime = 0;
        useobject.claimgraceperiod = 1;
        useobject.mustmaintainclaim = 0;
        useobject.cancontestclaim = 0;
        useobject thread use_object_prox_think();
    } else {
        useobject.userate = 1;
        useobject thread use_object_use_think(!allowinitialholddelay, !allowweaponcyclingduringhold);
    }
    useobject clear_progress();
    array::add(level.a_gameobjects, useobject, 0);
    useobject.b_reusable = 1;
    return useobject;
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x4
// Checksum 0xc3fb2d3, Offset: 0x67d8
// Size: 0x184
function private function_dd8869dd() {
    useobject = self;
    assert(isdefined(useobject.var_977e04c1));
    assert(!isdefined(useobject.objectiveid));
    useobject.objectiveid = get_next_obj_id();
    objective_add(useobject.objectiveid, "invisible", useobject, useobject.var_977e04c1);
    requiredspecialty = objective_getrequiredspecialty(useobject.var_977e04c1);
    if (isdefined(useobject.trigger) && isdefined(requiredspecialty) && requiredspecialty != "None") {
        useobject.trigger setperkfortrigger(requiredspecialty);
    }
    requiredweapon = function_959272c8(useobject.objectiveid);
    if (isdefined(requiredweapon)) {
        useobject.requiredweapon = getweapon(requiredweapon);
        useobject.trigger function_8eca61f(useobject.requiredweapon);
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x1bbd7ef9, Offset: 0x6968
// Size: 0x12e
function set_key_object(object) {
    mdl_gameobject = self function_22fb6ee8();
    object = object function_22fb6ee8();
    if (!isdefined(object)) {
        mdl_gameobject.keyobject = undefined;
        return;
    }
    if (!isdefined(mdl_gameobject.keyobject)) {
        mdl_gameobject.keyobject = [];
    }
    if (isarray(object)) {
        foreach (obj in object) {
            mdl_gameobject.keyobject[mdl_gameobject.keyobject.size] = obj;
        }
        return;
    }
    mdl_gameobject.keyobject[mdl_gameobject.keyobject.size] = object;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x4409d8a1, Offset: 0x6aa0
// Size: 0x15e
function function_4c7c8b9(object) {
    mdl_gameobject = self function_22fb6ee8();
    object = object function_22fb6ee8();
    if (!isdefined(mdl_gameobject.keyobject)) {
        return;
    }
    mdl_gameobject.keyobject = array::remove_undefined(mdl_gameobject.keyobject, 0);
    if (isarray(object)) {
        foreach (obj in object) {
            arrayremovevalue(mdl_gameobject.keyobject, obj, 0);
        }
    } else {
        arrayremovevalue(mdl_gameobject.keyobject, object, 0);
    }
    if (!mdl_gameobject.keyobject.size) {
        mdl_gameobject.keyobject = undefined;
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x29f3a5d5, Offset: 0x6c08
// Size: 0xe6
function has_key_object(use) {
    if (!isdefined(use.keyobject)) {
        return false;
    }
    for (x = 0; x < use.keyobject.size; x++) {
        if (isdefined(self.carryobject) && self.carryobject == use.keyobject[x]) {
            return true;
        }
        if (isdefined(self.packobject)) {
            for (i = 0; i < self.packobject.size; i++) {
                if (self.packobject[i] == use.keyobject[x]) {
                    return true;
                }
            }
        }
    }
    return false;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x1858322b, Offset: 0x6cf8
// Size: 0x4e
function function_82444b48(b_enable = 1) {
    mdl_gameobject = self function_22fb6ee8();
    mdl_gameobject.var_786d032a = b_enable;
}

// Namespace gameobjects/gameobjects_shared
// Params 2, eflags: 0x0
// Checksum 0xacd37f5e, Offset: 0x6d50
// Size: 0x90
function function_df77cc92(e_player, var_99178d12 = 0) {
    mdl_gameobject = self function_22fb6ee8();
    e_player.var_a05717bb = 1;
    mdl_gameobject.trigger notify(#"trigger", {#activator:e_player, #forced:var_99178d12});
}

// Namespace gameobjects/gameobjects_shared
// Params 2, eflags: 0x0
// Checksum 0x8551c186, Offset: 0x6de8
// Size: 0x5f0
function use_object_use_think(disableinitialholddelay, disableweaponcyclingduringhold) {
    self.trigger.mdl_gameobject = self;
    self.trigger endon(#"destroyed", #"death");
    if (self.usetime > 0 && disableinitialholddelay) {
        self.trigger usetriggerignoreuseholdtime();
    }
    while (true) {
        waitresult = self.trigger waittill(#"trigger");
        player = waitresult.activator;
        if (level.gameended) {
            continue;
        }
        if (!self can_touch(player) && !(isdefined(waitresult.forced) && waitresult.forced)) {
            continue;
        }
        if (!self can_interact_with(player) && !(isdefined(waitresult.forced) && waitresult.forced)) {
            continue;
        }
        if (!(isdefined(self.var_7460107b) && self.var_7460107b)) {
            if ((!player isonground() || player iswallrunning()) && !(isdefined(waitresult.forced) && waitresult.forced)) {
                continue;
            }
        }
        if (isdefined(self.useweapon) && isdefined(self.useweapon.var_6a110104) && self.useweapon.var_6a110104 && player function_500afda2()) {
            continue;
        }
        if (isdefined(self.keyobject) && !player has_key_object(self)) {
            if (isdefined(self.oncantuse)) {
                self [[ self.oncantuse ]](player);
            }
            continue;
        }
        self notify(#"engaged");
        result = 1;
        if (self.usetime > 0) {
            self thread play_interact_anim(player);
            self apply_player_use_modifiers(player);
            if (isdefined(self.onbeginuse)) {
                if (isdefined(self.classobj)) {
                    self.classobj [[ self.onbeginuse ]](self, player);
                } else {
                    self [[ self.onbeginuse ]](player);
                }
            }
            team = player.pers[#"team"];
            result = self use_hold_think(player, disableweaponcyclingduringhold);
            self remove_player_use_modifiers(player);
            if (isdefined(self.onenduse)) {
                if (isdefined(self.classobj)) {
                    self.classobj [[ self.onenduse ]](self, team, player, result);
                } else {
                    self [[ self.onenduse ]](team, player, result);
                }
            }
        }
        if (isdefined(self.e_object) && isdefined(self.e_object.var_492c489b) && self.e_object.var_492c489b) {
            self.e_object thread function_c3969120(team, player, result);
        }
        if (!(isdefined(result) && result)) {
            self notify(#"gameobject_abort");
            if (isdefined(self.e_object)) {
                self.e_object notify(#"gameobject_abort");
            }
            continue;
        }
        if (isdefined(self.e_object)) {
            if (!self.e_object flag::exists("gameobject_end_use")) {
                self.e_object flag::init("gameobject_end_use");
            }
            self.e_object flag::set("gameobject_end_use");
        }
        potm::bookmark(#"interact", gettime(), player);
        self notify(#"gameobject_end_use_player", {#player:player});
        if (isdefined(self.onuse)) {
            if (isdefined(self.onuse_thread) && self.onuse_thread) {
                self thread use_object_onuse(player);
            } else {
                self use_object_onuse(player);
            }
        }
        if (self.type == "carryObject" || self.type === "packObject") {
            self set_picked_up(player);
        }
        self check_gameobject_reenable();
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x4b6cde7b, Offset: 0x73e0
// Size: 0x90
function use_object_onuse(player) {
    level endon(#"game_ended");
    self.trigger endon(#"destroyed", #"death");
    if (isdefined(self.classobj)) {
        self.classobj [[ self.onuse ]](self, player);
        return;
    }
    self [[ self.onuse ]](player);
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0xde255, Offset: 0x7478
// Size: 0x12a
function get_earliest_claim_player() {
    assert(self.claimteam != #"none");
    team = self.claimteam;
    earliestplayer = self.claimplayer;
    if (self.touchlist[team].size > 0) {
        earliesttime = undefined;
        foreach (touchdata in self.touchlist[team]) {
            if (!isdefined(earliesttime) || touchdata.starttime < earliesttime) {
                earliestplayer = touchdata.player;
                earliesttime = touchdata.starttime;
            }
        }
    }
    return earliestplayer;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x1f8a5dd1, Offset: 0x75b0
// Size: 0x30
function apply_player_use_modifiers(e_player) {
    if (isdefined(level.var_790e8f6f)) {
        e_player [[ level.var_790e8f6f ]]();
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xb821833c, Offset: 0x75e8
// Size: 0x30
function remove_player_use_modifiers(e_player) {
    if (isdefined(level.var_b579aa04)) {
        e_player [[ level.var_b579aa04 ]]();
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x4
// Checksum 0xfb9c43fa, Offset: 0x7620
// Size: 0x68
function private function_d35a8d2e() {
    if (self.cancontestclaim) {
        num = function_564662aa(self.claimteam);
        numother = get_num_touching_except_team(self.claimteam);
        if (num && numother) {
            return true;
        }
    }
    return false;
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x4
// Checksum 0x8653746f, Offset: 0x7690
// Size: 0x66
function private function_31f5af82() {
    if (isdefined(self.oncontested)) {
        self [[ self.oncontested ]]();
    }
    if (!self.decayprogress || self.curprogress == 0) {
        self set_claim_team(#"none");
        self.claimplayer = undefined;
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x4
// Checksum 0xcc056f26, Offset: 0x7700
// Size: 0x198
function private function_68548a93(progress) {
    if (!self.var_ccca48dc || !progress) {
        return;
    }
    if (0 > progress) {
        foreach (var_88d5d3bf in self.var_17a75d13[self.claimteam]) {
            var_88d5d3bf.contribution = math::clamp(var_88d5d3bf.contribution + progress, 0, self.usetime);
        }
        return;
    }
    keys = getarraykeys(self.touchlist[self.claimteam]);
    for (i = 0; i < keys.size; i++) {
        self.var_17a75d13[self.claimteam][keys[i]].contribution = math::clamp(self.var_17a75d13[self.claimteam][keys[i]].contribution + progress, 0, self.usetime);
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x7ecb629c, Offset: 0x78a0
// Size: 0x1a
function function_c60ddd9f(enabled) {
    self.var_2edbd95f = enabled;
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x126a5e, Offset: 0x78c8
// Size: 0xef8
function use_object_prox_think() {
    level endon(#"game_ended");
    self.trigger endon(#"destroyed", #"death");
    self thread prox_trigger_think();
    while (true) {
        if (self.usetime && self.curprogress >= self.usetime || self.usetime <= 0 && self.numtouching[self.claimteam] > 0) {
            creditplayer = get_earliest_claim_player();
            if (isdefined(self.onenduse)) {
                if (isdefined(self.classobj)) {
                    self.classobj [[ self.onenduse ]](self, self get_claim_team(), creditplayer, isdefined(creditplayer));
                } else {
                    self [[ self.onenduse ]](self get_claim_team(), creditplayer, isdefined(creditplayer));
                }
            }
            if (isdefined(self.e_object)) {
                if (!self.e_object flag::exists("gameobject_end_use")) {
                    self.e_object flag::init("gameobject_end_use");
                }
                self.e_object flag::set("gameobject_end_use");
                if (isdefined(self.e_object.var_492c489b) && self.e_object.var_492c489b) {
                    self.e_object thread function_c3969120(self get_claim_team(), creditplayer, isdefined(creditplayer));
                }
            }
            if (isdefined(creditplayer)) {
                self notify(#"gameobject_end_use_player", {#player:creditplayer});
            }
            if (isdefined(creditplayer) && isdefined(self.onuse)) {
                if (isdefined(self.classobj)) {
                    self.classobj [[ self.onuse ]](self, creditplayer);
                } else {
                    self [[ self.onuse ]](creditplayer);
                }
            }
            self clear_progress();
            if (!self.mustmaintainclaim) {
                self set_claim_team(#"none");
                self.claimplayer = undefined;
            }
            self thread check_gameobject_reenable();
            if (isdefined(creditplayer) && (self.type == "carryObject" || self.type === "packObject")) {
                self set_picked_up(creditplayer);
            }
        }
        previousprogress = self.curprogress;
        if (self.claimteam != #"none") {
            if (self use_object_locked_for_team(self.claimteam)) {
                if (isdefined(self.onenduse)) {
                    if (isdefined(self.classobj)) {
                        self.classobj [[ self.onenduse ]](self, self get_claim_team(), self.claimplayer, 0);
                    } else {
                        self [[ self.onenduse ]](self get_claim_team(), self.claimplayer, 0);
                    }
                }
                if (isdefined(self.e_object) && isdefined(self.e_object.var_492c489b) && self.e_object.var_492c489b) {
                    self.e_object thread function_c3969120(self get_claim_team(), self.claimplayer, 0);
                }
                self clear_progress();
                self set_claim_team(#"none");
                self.claimplayer = undefined;
            } else if (self.usetime && (!self.mustmaintainclaim || self get_owner_team() != self get_claim_team())) {
                if (self.decayprogress && !self.numtouching[self.claimteam]) {
                    if (isdefined(self.autodecaytime) && self.autodecaytime > 0 && self.curprogress > 0) {
                        self.curprogress -= level.var_b5db3a4 * self.usetime / int(self.autodecaytime * 1000);
                        deltaprogress = self.curprogress - previousprogress;
                        function_68548a93(deltaprogress);
                        self update_current_progress();
                        if (self.curprogress <= 0) {
                            self clear_progress();
                        }
                        previousprogress = self.curprogress;
                    }
                    self.inuse = 0;
                    hadprogress = self.curprogress > 0;
                    if (isdefined(self.claimplayer)) {
                        if (isdefined(self.onenduse)) {
                            if (isdefined(self.classobj)) {
                                self.classobj [[ self.onenduse ]](self, self get_claim_team(), self.claimplayer, 0);
                            } else {
                                self [[ self.onenduse ]](self get_claim_team(), self.claimplayer, 0);
                            }
                        }
                        if (isdefined(self.e_object) && isdefined(self.e_object.var_492c489b) && self.e_object.var_492c489b) {
                            self.e_object thread function_c3969120(self get_claim_team(), self.claimplayer, 0);
                        }
                        self.claimplayer = undefined;
                    }
                    decayscale = 0;
                    if (self.var_9d9c7b7 && isdefined(self.decaytime) && self.decaytime > 0) {
                        decayscale = self.usetime / self.decaytime;
                    }
                    self.curprogress -= level.var_b5db3a4 * self.userate * decayscale;
                    deltaprogress = self.curprogress - previousprogress;
                    function_68548a93(deltaprogress);
                    if (isdefined(self.decayprogressmin) && self.curprogress < self.decayprogressmin) {
                        self.curprogress = self.decayprogressmin;
                    }
                    if (self.curprogress <= 0) {
                        self clear_progress();
                    }
                    self update_current_progress();
                    if (isdefined(self.onuseupdate)) {
                        self [[ self.onuseupdate ]](self get_claim_team(), self.curprogress / self.usetime, deltaprogress / self.usetime);
                    }
                    if (isdefined(self.var_674b13d1)) {
                        self [[ self.var_674b13d1 ]](self get_claim_team(), self.curprogress / self.usetime, deltaprogress / self.usetime);
                    }
                    if (self.curprogress == 0) {
                        if (self.claimteam != #"none") {
                            self set_claim_team(#"none");
                        }
                    }
                    if (isdefined(hadprogress) && hadprogress && isdefined(self.ondecaycomplete) && self.curprogress <= (isdefined(self.decayprogressmin) ? self.decayprogressmin : 0)) {
                        self [[ self.ondecaycomplete ]]();
                    }
                } else if (!self.numtouching[self.claimteam]) {
                    self.inuse = 0;
                    if (isdefined(self.onenduse)) {
                        if (isdefined(self.classobj)) {
                            self.classobj [[ self.onenduse ]](self, self get_claim_team(), self.claimplayer, 0);
                        } else {
                            self [[ self.onenduse ]](self get_claim_team(), self.claimplayer, 0);
                        }
                    }
                    if (isdefined(self.e_object) && isdefined(self.e_object.var_492c489b) && self.e_object.var_492c489b) {
                        self.e_object thread function_c3969120(self get_claim_team(), self.claimplayer, 0);
                    }
                    self set_claim_team(#"none");
                    self.claimplayer = undefined;
                } else if (function_d35a8d2e()) {
                    function_31f5af82();
                } else {
                    self.curprogress += level.var_b5db3a4 * self.userate;
                    deltaprogress = self.curprogress - previousprogress;
                    function_68548a93(deltaprogress);
                    self update_current_progress();
                    if (isdefined(self.onuseupdate)) {
                        self [[ self.onuseupdate ]](self get_claim_team(), self.curprogress / self.usetime, level.var_b5db3a4 * self.userate / self.usetime);
                    }
                    if (isdefined(self.var_674b13d1)) {
                        self [[ self.var_674b13d1 ]](self get_claim_team(), self.curprogress / self.usetime, level.var_b5db3a4 * self.userate / self.usetime);
                    }
                }
            } else if (!self.mustmaintainclaim) {
                if (isdefined(self.onuse)) {
                    self use_object_onuse(self.claimplayer);
                }
                if (!self.mustmaintainclaim && self.claimteam != #"none") {
                    self set_claim_team(#"none");
                    self.claimplayer = undefined;
                }
            } else if (!self.numtouching[self.claimteam]) {
                self.inuse = 0;
                if (isdefined(self.onunoccupied)) {
                    self [[ self.onunoccupied ]]();
                }
                self set_claim_team(#"none");
                self.claimplayer = undefined;
            } else if (function_d35a8d2e()) {
                function_31f5af82();
            }
        } else {
            if (!self.decayprogress && self.curprogress > 0 && self.var_2edbd95f !== 1 && gettime() - self.lastclaimtime > int(self.claimgraceperiod * 1000)) {
                self clear_progress();
            }
            if (self.mustmaintainclaim && self get_owner_team() != #"none") {
                if (!self.numtouching[self get_owner_team()]) {
                    self.inuse = 0;
                    if (isdefined(self.onunoccupied)) {
                        self [[ self.onunoccupied ]]();
                    }
                } else if (self.cancontestclaim && self.lastclaimteam != #"none" && self.numtouching[self.lastclaimteam]) {
                    numother = get_num_touching_except_team(self.lastclaimteam);
                    if (numother == 0) {
                        if (isdefined(self.onuncontested)) {
                            self [[ self.onuncontested ]](self.lastclaimteam);
                        }
                    }
                }
            } else if (function_d35a8d2e()) {
                function_31f5af82();
            }
        }
        waitframe(1);
        hostmigration::waittillhostmigrationdone();
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x52109d67, Offset: 0x87c8
// Size: 0x244
function check_gameobject_reenable() {
    self endon(#"death");
    if (isdefined(self.e_object) && isdefined(self.b_reusable) && self.b_reusable) {
        self.e_object endon(#"death");
        if (!self.e_object flag::exists("gameobject_end_use")) {
            self.e_object flag::init("gameobject_end_use");
        }
        if (isdefined(self.b_auto_reenable) && self.b_auto_reenable) {
            self disable_object();
            wait 1;
            self.e_object flag::clear("gameobject_end_use");
            self enable_object();
        } else {
            waittillframeend();
            self.e_object flag::clear("gameobject_end_use");
        }
    }
    if (isdefined(self.keyobject) && isdefined(self.var_786d032a) && self.var_786d032a) {
        foreach (mdl_key in self.keyobject) {
            mdl_key destroy_object(1, 1);
        }
    }
    if (!(isdefined(self.b_reusable) && self.b_reusable)) {
        self.e_object flagsys::set(#"gameobject_destroyed");
        util::wait_network_frame();
        self thread destroy_object(1, 1);
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xf26a7cd3, Offset: 0x8a18
// Size: 0x5c
function use_object_locked_for_team(team) {
    team = util::get_team_mapping(team);
    if (isdefined(self.teamlock) && isdefined(level.teams[team])) {
        return self.teamlock[team];
    }
    return 0;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x1b157d18, Offset: 0x8a80
// Size: 0x90
function can_claim(sentient) {
    if (isdefined(self.carrier)) {
        return false;
    }
    if (self.cancontestclaim) {
        numother = get_num_touching_except_team(sentient.team);
        if (numother != 0) {
            return false;
        }
    }
    if (!isdefined(self.keyobject) || sentient has_key_object(self)) {
        return true;
    }
    return false;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x4
// Checksum 0xa91e1358, Offset: 0x8b18
// Size: 0x17a
function private function_5deff6ef(player) {
    if (!isalive(player) || self use_object_locked_for_team(player.pers[#"team"])) {
        return false;
    }
    if (isdefined(player.laststand) && player.laststand && !(isdefined(player.can_capture) && player.can_capture) && !(isdefined(player.can_contest) && player.can_contest)) {
        return false;
    }
    if (player.spawntime == gettime()) {
        return false;
    }
    if (isdefined(player.selectinglocation) && player.selectinglocation) {
        return false;
    }
    if (player isweaponviewonlylinked()) {
        return false;
    }
    if (!(isdefined(self.cancontestclaim) && self.cancontestclaim) && isdefined(self.keyobject) && !player has_key_object(self)) {
        return false;
    }
    return true;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x4
// Checksum 0x34e1b5ce, Offset: 0x8ca0
// Size: 0x1e2
function private function_20e6ab64(sentient) {
    if (!self can_interact_with(sentient)) {
        return false;
    }
    if (self.claimteam == #"none") {
        if (self can_claim(sentient)) {
            set_claim_team(sentient.team);
            self.claimplayer = sentient;
            relativeteam = self get_relative_team(sentient.team);
            if (isdefined(self.teamusetimes[relativeteam])) {
                self.usetime = self.teamusetimes[relativeteam];
            }
            self notify(#"engaged");
            self.inuse = 1;
            if (self.usetime && isdefined(self.onbeginuse)) {
                if (isdefined(self.classobj)) {
                    self.classobj [[ self.onbeginuse ]](self, self.claimplayer);
                } else {
                    self [[ self.onbeginuse ]](self.claimplayer);
                }
            }
        } else if (isdefined(self.oncantuse)) {
            self [[ self.oncantuse ]](sentient);
        }
    } else if (self.claimteam == sentient.team && self can_claim(sentient) && self.numtouching[self.claimteam] == 0) {
        return true;
    }
    return false;
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0xfb59e63f, Offset: 0x8e90
// Size: 0x170
function prox_trigger_think() {
    level endon(#"game_ended");
    self.trigger endon(#"destroyed", #"death");
    entitynumber = self.entnum;
    while (true) {
        waitresult = self.trigger waittill(#"trigger");
        sentient = waitresult.activator;
        if (!self can_touch(sentient) || !isdefined(sentient.touchtriggers)) {
            continue;
        }
        resume_use = self function_20e6ab64(sentient);
        if (isalive(sentient) && !isdefined(sentient.touchtriggers[entitynumber])) {
            sentient thread trigger_touch_think(self);
            if (resume_use && isdefined(self.onresumeuse)) {
                self [[ self.onresumeuse ]](sentient);
            }
        }
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xf21b9093, Offset: 0x9008
// Size: 0xac
function is_excluded(sentient) {
    if (!isdefined(self.exclusions)) {
        return false;
    }
    foreach (exclusion in self.exclusions) {
        if (isdefined(exclusion) && sentient is_touching_trigger(exclusion)) {
            return true;
        }
    }
    return false;
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0xcc62122e, Offset: 0x90c0
// Size: 0x48
function clear_progress() {
    self.curprogress = 0;
    self.decayprogressmin = 0;
    self update_current_progress();
    if (isdefined(self.onuseclear)) {
        self [[ self.onuseclear ]]();
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x378254c3, Offset: 0x9110
// Size: 0xde
function function_1aca7f5() {
    if (!isdefined(self.var_17a75d13)) {
        return;
    }
    foreach (var_17a75d13 in self.var_17a75d13) {
        foreach (contributor in var_17a75d13) {
            contributor.contribution = 0;
        }
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xac69214a, Offset: 0x91f8
// Size: 0x1a
function function_12cc0652(enabled) {
    self.var_5cdbe56b = enabled;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xa1f5ea4f, Offset: 0x9220
// Size: 0x124
function set_claim_team(newteam) {
    assert(newteam != self.claimteam);
    if (self.var_5cdbe56b !== 1) {
        if (!self.decayprogress && self.claimteam == #"none" && gettime() - self.lastclaimtime > int(self.claimgraceperiod * 1000)) {
            self clear_progress();
        } else if (newteam != #"none" && newteam != self.lastclaimteam) {
            self clear_progress();
        }
    }
    self.lastclaimteam = self.claimteam;
    self.lastclaimtime = gettime();
    self.claimteam = newteam;
    self update_use_rate();
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0xae58660f, Offset: 0x9350
// Size: 0xa
function get_claim_team() {
    return self.claimteam;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xe1a47d8e, Offset: 0x9368
// Size: 0x22
function is_touching_trigger(trigger) {
    return self istouching(trigger);
}

// Namespace gameobjects/gameobjects_shared
// Params 2, eflags: 0x0
// Checksum 0x73f21761, Offset: 0x9398
// Size: 0x1ee
function continue_trigger_touch_think(team, object) {
    if (!isalive(self)) {
        return false;
    }
    var_1dd09e4d = isvehicle(self) || isplayer(self) && self isinvehicle() && !self function_80cbd71f();
    if (var_1dd09e4d && !(isdefined(level.b_allow_vehicle_proximity_pickup) && level.b_allow_vehicle_proximity_pickup) && !(isdefined(object.b_allow_vehicle_proximity_pickup) && object.b_allow_vehicle_proximity_pickup)) {
        return false;
    }
    if (self use_object_locked_for_team(team)) {
        return false;
    }
    if (isdefined(self.laststand) && self.laststand && !(isdefined(self.can_capture) && self.can_capture) && !(isdefined(self.can_contest) && self.can_contest)) {
        return false;
    }
    if (!isdefined(object) || !isdefined(object.trigger)) {
        return false;
    }
    if (!object.trigger istriggerenabled()) {
        return false;
    }
    if (!object can_touch(self)) {
        return false;
    }
    if (!self is_touching_trigger(object.trigger)) {
        return false;
    }
    return true;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x88851227, Offset: 0x9590
// Size: 0x1a
function setplayergametypeuseratecallback(callbackfunc) {
    self.gametypeuseratecallback = callbackfunc;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x74a72a0d, Offset: 0x95b8
// Size: 0x36
function allow_vehicle_proximity_pickup(b_enable) {
    mdl_gameobject = function_22fb6ee8();
    mdl_gameobject.b_allow_vehicle_proximity_pickup = b_enable;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x73a548d3, Offset: 0x95f8
// Size: 0x6a4
function trigger_touch_think(object) {
    object.trigger endon(#"destroyed", #"death");
    team = self.team;
    score = 1;
    player_use_rate = 1;
    object.numtouching[team] = object.numtouching[team] + score;
    if (isdefined(self.playerrole) && isdefined(self.playerrole.gameobjectuserate)) {
        player_use_rate = self.playerrole.gameobjectuserate;
    }
    if (isdefined(self.gametypeuseratecallback)) {
        player_use_rate *= self [[ self.gametypeuseratecallback ]](object);
    }
    object.touchinguserate[team] = object.touchinguserate[team] + player_use_rate;
    touchname = self getentitynumber();
    struct = spawnstruct();
    struct.player = self;
    struct.starttime = gettime();
    struct.userate = player_use_rate;
    object.touchlist[team][touchname] = struct;
    if (object.var_ccca48dc) {
        if (isdefined(object.var_17a75d13[team][touchname])) {
            var_dc4c6660 = object.var_17a75d13[team][touchname];
            if (!isdefined(var_dc4c6660.player)) {
                var_dc4c6660.player = self;
            }
        } else {
            var_dc4c6660 = spawnstruct();
            var_dc4c6660.player = self;
            var_dc4c6660.contribution = 0;
            object.var_17a75d13[team][touchname] = var_dc4c6660;
        }
        var_dc4c6660.starttime = gettime();
        var_dc4c6660.var_664a1806 = 1;
    }
    if (object.usetime) {
        object update_use_rate();
    }
    if (isdefined(object.objectiveid) && object.type != "carryObject") {
        if (isplayer(self)) {
            objective_setplayerusing(object.objectiveid, self);
        } else {
            objective_setplayerusing(object.objectiveid, self.owner);
        }
    }
    self.touchtriggers[object.entnum] = object.trigger;
    if (isdefined(object.ontouchuse)) {
        object [[ object.ontouchuse ]](self);
    }
    if (isdefined(self.var_a05717bb) && self.var_a05717bb) {
        object.curprogress = object.usetime + 1;
        object.numtouching[object.claimteam] = 1;
        self.var_a05717bb = undefined;
        while (object.curprogress >= 1) {
            waitframe(1);
        }
    } else {
        while (self continue_trigger_touch_think(team, object)) {
            waitframe(1);
        }
    }
    if (isdefined(self)) {
        self.touchtriggers[object.entnum] = undefined;
        if (isdefined(object.objectiveid) && object.type != "carryObject") {
            if (isplayer(self)) {
                objective_clearplayerusing(object.objectiveid, self);
            } else {
                objective_clearplayerusing(object.objectiveid, self.owner);
            }
        }
    } else if (isdefined(object.var_17a75d13) && isdefined(object.var_17a75d13[team])) {
        object.var_17a75d13[team][touchname] = undefined;
    }
    if (level.gameended) {
        return;
    }
    if (isdefined(var_dc4c6660)) {
        var_dc4c6660.var_664a1806 = 0;
    }
    object.touchlist[team][touchname] = undefined;
    object.numtouching[team] = object.numtouching[team] - score;
    object.touchinguserate[team] = object.touchinguserate[team] - player_use_rate;
    if (object.numtouching[team] < 1) {
        object.numtouching[team] = 0;
        object.touchinguserate[team] = 0;
    }
    if (object.usetime) {
        if (object.numtouching[team] <= 0 && object.curprogress >= object.usetime) {
            object.curprogress = object.usetime - 1;
            object update_current_progress();
        }
    }
    if (isdefined(self) && isdefined(object.onendtouchuse)) {
        object [[ object.onendtouchuse ]](self);
    }
    object update_use_rate();
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x42465d42, Offset: 0x9ca8
// Size: 0xaa
function get_num_touching_except_team(ignoreteam) {
    numtouching = 0;
    foreach (team, _ in level.teams) {
        if (ignoreteam == team) {
            continue;
        }
        numtouching += self.numtouching[team];
    }
    return numtouching;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xbbcb137a, Offset: 0x9d60
// Size: 0x18
function function_564662aa(team) {
    return self.numtouching[team];
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x4d289c89, Offset: 0x9d80
// Size: 0xb0
function get_touching_use_rate_except_team(ignoreteam) {
    numtouching = 0;
    foreach (team, _ in level.teams) {
        if (ignoreteam == team) {
            continue;
        }
        numtouching += get_team_use_rate(team);
    }
    return numtouching;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x2ad8eda8, Offset: 0x9e38
// Size: 0x108
function get_team_use_rate(team) {
    if (self.var_c518b47a) {
        useobject = self;
        userate = 0;
        if (useobject.touchlist[team].size > 0) {
            foreach (touchdata in useobject.touchlist[team]) {
                if (isdefined(touchdata.userate) && touchdata.userate > userate) {
                    userate = touchdata.userate;
                }
            }
        }
    } else {
        userate = self.touchinguserate[team];
    }
    return userate;
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x4d6b2411, Offset: 0x9f48
// Size: 0x150
function update_use_rate() {
    numclaimants = self.numtouching[self.claimteam];
    claimantsuserate = get_team_use_rate(self.claimteam);
    numother = 0;
    numother = get_num_touching_except_team(self.claimteam);
    otheruserate = get_touching_use_rate_except_team(self.claimteam);
    self.userate = 0;
    if (self.decayprogress) {
        if (numclaimants && !numother) {
            self.userate = claimantsuserate;
        } else if (!numclaimants && numother) {
            self.userate = otheruserate;
        } else if (!numclaimants && !numother) {
            self.userate = 0;
        }
    } else if (numclaimants && !numother) {
        self.userate = claimantsuserate;
    }
    if (isdefined(self.onupdateuserate)) {
        self [[ self.onupdateuserate ]]();
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 2, eflags: 0x0
// Checksum 0xce2de1a, Offset: 0xa0a0
// Size: 0x5b0
function use_hold_think(player, disableweaponcyclingduringhold) {
    player notify(#"use_hold");
    if (!isdefined(self.var_322784b9)) {
        self.var_322784b9 = spawnstruct();
    }
    self.var_322784b9.player = player;
    if (!(isdefined(self.dontlinkplayertotrigger) && self.dontlinkplayertotrigger)) {
        if (!sessionmodeismultiplayergame() && !sessionmodeiswarzonegame()) {
            gameobject_link = util::spawn_model("tag_origin", player.origin, player.angles);
            player playerlinkto(gameobject_link);
        } else {
            player playerlinkto(self.trigger);
            player playerlinkedoffsetenable();
        }
    }
    player clientclaimtrigger(self.trigger);
    player.claimtrigger = self.trigger;
    useweapon = self.useweapon;
    if (isdefined(useweapon)) {
        if (isdefined(useweapon.var_6a110104) && useweapon.var_6a110104) {
            player val::set(#"gameobject_use", "disable_gestures");
        }
        player giveweapon(useweapon);
        player setweaponammostock(useweapon, 0);
        player setweaponammoclip(useweapon, 0);
        player switchtoweapon(useweapon);
    } else if (self.keepweapon !== 1) {
        player val::set(#"gameobject_use", "disable_weapons");
    }
    self clear_progress();
    self.inuse = 1;
    self.userate = 0;
    if (isdefined(self.objectiveid)) {
        objective_setplayerusing(self.objectiveid, player);
    }
    if (disableweaponcyclingduringhold) {
        player disableweaponcycling();
        enableweaponcyclingafterhold = 1;
        self.var_322784b9.enableweaponcycling = 1;
    }
    if (isdefined(player.var_a05717bb) && player.var_a05717bb) {
        self.curprogress = self.usetime;
        result = 1;
        player.var_a05717bb = undefined;
    } else {
        result = use_hold_think_loop(player);
        if (!isdefined(result)) {
            result = 0;
        }
    }
    self.inuse = 0;
    if (isdefined(player)) {
        if (enableweaponcyclingafterhold === 1) {
            player enableweaponcycling();
            self.var_322784b9.enableweaponcycling = 0;
        }
        if (isdefined(self.objectiveid)) {
            objective_clearplayerusing(self.objectiveid, player);
        }
        self clear_progress();
        if (isdefined(player.attachedusemodel)) {
            player detach(player.attachedusemodel, "tag_inhand");
            player.attachedusemodel = undefined;
        }
        player notify(#"done_using");
        if (isdefined(useweapon)) {
            player thread take_use_weapon(useweapon);
        }
        player.claimtrigger = undefined;
        player clientreleasetrigger(self.trigger);
        if (isdefined(useweapon)) {
            player killstreaks::switch_to_last_non_killstreak_weapon();
        } else if (self.keepweapon !== 1) {
            player val::reset(#"gameobject_use", "disable_weapons");
        }
        if (!(isdefined(self.dontlinkplayertotrigger) && self.dontlinkplayertotrigger)) {
            player unlink();
        }
        if (!isalive(player)) {
            player.killedinuse = 1;
        }
        if (level.gameended) {
            player waitthenfreezeplayercontrolsifgameendedstill();
        }
    }
    if (isdefined(gameobject_link)) {
        gameobject_link delete();
    }
    return result;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x3c6f3556, Offset: 0xa658
// Size: 0x74
function waitthenfreezeplayercontrolsifgameendedstill(wait_time = 1) {
    player = self;
    wait wait_time;
    if (isdefined(player) && level.gameended) {
        player val::set(#"gameobjects_gameended", "freezecontrols", 1);
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x519d74f, Offset: 0xa6d8
// Size: 0xe4
function take_use_weapon(useweapon) {
    self endon(#"use_hold");
    self endon(#"death");
    self endon(#"disconnect");
    level endon(#"game_ended");
    while (self getcurrentweapon() == useweapon && !self.throwinggrenade) {
        waitframe(1);
    }
    if (isdefined(useweapon.var_6a110104) && useweapon.var_6a110104) {
        self val::reset(#"gameobject_use", "disable_gestures");
    }
    self takeweapon(useweapon);
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x2a9eee56, Offset: 0xa7c8
// Size: 0x62
function has_line_of_sight(player) {
    eye = player util::get_eye();
    trace = sighttracepassed(eye, self.origin, 0, self.var_c477841c, player);
    return trace;
}

// Namespace gameobjects/gameobjects_shared
// Params 4, eflags: 0x0
// Checksum 0xd5f517d4, Offset: 0xa838
// Size: 0x272
function continue_hold_think_loop(player, waitforweapon, timedout, usetime) {
    maxwaittime = 1.5;
    if (!isalive(player)) {
        return false;
    }
    if (isdefined(player.laststand) && player.laststand) {
        return false;
    }
    if (self.curprogress >= usetime) {
        return false;
    }
    if (!player usebuttonpressed()) {
        return false;
    }
    if (player.throwinggrenade && (!isdefined(self.var_bd06a07) || self.var_bd06a07 != 14 && self.var_bd06a07 != 15)) {
        return false;
    }
    if (player isinvehicle()) {
        return false;
    }
    if (player isremotecontrolling() || player util::isusingremote()) {
        return false;
    }
    if (isdefined(player.selectinglocation) && player.selectinglocation) {
        return false;
    }
    if (player isweaponviewonlylinked()) {
        return false;
    }
    if (!player is_touching_trigger(self.trigger)) {
        if (!isdefined(player.cursorhintent) || player.cursorhintent != self) {
            return false;
        }
    }
    if (isdefined(self.requireslos) && self.requireslos && !has_line_of_sight(player)) {
        return false;
    }
    if (!self.userate && !waitforweapon) {
        return false;
    }
    if (waitforweapon && timedout > maxwaittime) {
        return false;
    }
    if (isdefined(self.interrupted) && self.interrupted) {
        return false;
    }
    if (level.gameended) {
        return false;
    }
    return true;
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x74646ede, Offset: 0xaab8
// Size: 0x94
function update_current_progress() {
    if (self.usetime) {
        if (isdefined(self.curprogress)) {
            progress = float(self.curprogress) / self.usetime;
        } else {
            progress = 0;
        }
        if (isdefined(self.objectiveid)) {
            objective_setprogress(self.objectiveid, math::clamp(progress, 0, 1));
        }
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xb3416f0f, Offset: 0xab58
// Size: 0x30a
function use_hold_think_loop(player) {
    self endon(#"disabled");
    useweapon = self.useweapon;
    waitforweapon = 1;
    timedout = 0;
    while (self continue_hold_think_loop(player, waitforweapon, timedout, self.usetime)) {
        timedout += 0.05;
        if (!isdefined(useweapon) || useweapon == level.weaponnone || player getcurrentweapon() == useweapon) {
            playerusemultiplier = 1;
            if (isdefined(self.getuseratemultiplier)) {
                playerusemultiplier = self [[ self.getuseratemultiplier ]](player);
            }
            previousprogress = self.curprogress;
            self.curprogress += level.var_b5db3a4 * self.userate * playerusemultiplier;
            deltaprogress = self.curprogress - previousprogress;
            if (isdefined(self.var_ccca48dc) && self.var_ccca48dc && isdefined(self.var_17a75d13)) {
                function_68548a93(deltaprogress);
            }
            self update_current_progress();
            if (isdefined(self.onuseupdate)) {
                self [[ self.onuseupdate ]](self get_claim_team(), self.curprogress / self.usetime, deltaprogress / self.usetime);
            }
            if (isdefined(self.var_674b13d1)) {
                self [[ self.var_674b13d1 ]](self get_claim_team(), self.curprogress / self.usetime, deltaprogress / self.usetime);
            }
            self.userate = 1;
            waitforweapon = 0;
        } else {
            self.userate = 0;
        }
        if (sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
            if (self.curprogress >= self.usetime) {
                return true;
            }
            waitframe(1);
        } else {
            waitframe(1);
            if (self.curprogress >= self.usetime) {
                util::wait_network_frame();
                return true;
            }
        }
        hostmigration::waittillhostmigrationdone();
    }
    return false;
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0xfd1ed7f3, Offset: 0xae70
// Size: 0x204
function update_trigger() {
    if (self.triggertype != "use") {
        return;
    }
    if (!isdefined(self.trigger)) {
        return;
    }
    if (isdefined(self.absolute_visible_and_interact_team)) {
        self.trigger triggerenable(1);
        self.trigger setteamfortrigger(self.absolute_visible_and_interact_team);
        return;
    }
    if (self.interactteam == #"none") {
        self.trigger triggerenable(0);
        return;
    }
    if (self.interactteam == #"any" || !level.teambased) {
        self.trigger triggerenable(1);
        self.trigger setteamfortrigger(#"none");
        return;
    }
    if (self.interactteam == #"friendly") {
        self.trigger triggerenable(1);
        if (isdefined(level.teams[self.ownerteam])) {
            self.trigger setteamfortrigger(self.ownerteam);
        } else {
            self.trigger triggerenable(0);
        }
        return;
    }
    if (self.interactteam == #"enemy") {
        self.trigger triggerenable(1);
        self.trigger setexcludeteamfortrigger(self.ownerteam);
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0xe5db88dc, Offset: 0xb080
// Size: 0x454
function update_objective() {
    if (self.type === "GenericObject" || !isdefined(self.objectiveid)) {
        return;
    }
    if (isdefined(self.e_object) && isdefined(self.e_object.var_492c489b) && self.e_object.var_492c489b) {
        objective_setteam(self.objectiveid, #"none");
    } else {
        objective_setteam(self.objectiveid, self.ownerteam);
    }
    if (isdefined(self.absolute_visible_and_interact_team) && self.visibleteam != #"none") {
        objective_setstate(self.objectiveid, "active");
        function_eeba3a5c(self.objectiveid, 0);
        function_c3a2445a(self.objectiveid, self.absolute_visible_and_interact_team, 1);
    } else if (self.visibleteam == #"any") {
        objective_setstate(self.objectiveid, "active");
        function_eeba3a5c(self.objectiveid, 1);
    } else if (isdefined(self.ownerteam) && isdefined(level.spawnsystem.ispawn_teammask[self.ownerteam]) && self.visibleteam == #"friendly") {
        objective_setstate(self.objectiveid, "active");
        function_eeba3a5c(self.objectiveid, 0);
        function_c3a2445a(self.objectiveid, self.ownerteam, 1);
    } else if (isdefined(self.ownerteam) && isdefined(level.spawnsystem.ispawn_teammask[self.ownerteam]) && self.visibleteam == #"enemy") {
        objective_setstate(self.objectiveid, "active");
        function_eeba3a5c(self.objectiveid, 1);
        function_c3a2445a(self.objectiveid, self.ownerteam, 0);
    } else {
        objective_setstate(self.objectiveid, "invisible");
        function_eeba3a5c(self.objectiveid, 0);
    }
    if (self.type == "carryObject" || self.type == "packObject") {
        if (isalive(self.carrier)) {
            objective_onentity(self.objectiveid, self.carrier);
            objective_setinvisibletoplayer(self.objectiveid, self.carrier);
            return;
        }
        if (isdefined(self.objectiveonvisuals) && self.objectiveonvisuals) {
            objective_onentity(self.objectiveid, self.visuals[0]);
            return;
        }
        if (isdefined(self.objectiveonself) && self.objectiveonself) {
            objective_onentity(self.objectiveid, self);
            return;
        }
        objective_clearentity(self.objectiveid);
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x918b10c7, Offset: 0xb4e0
// Size: 0xe8
function function_336b5791(team) {
    mdl_gameobject = self function_22fb6ee8();
    if (!isdefined(team)) {
        team = team.ownerteam;
    }
    team = util::get_team_mapping(team);
    foreach (e_player in util::get_players(team)) {
        mdl_gameobject hide_waypoint(e_player);
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xf4923c17, Offset: 0xb5d0
// Size: 0xd0
function function_88d9fc38(team) {
    mdl_gameobject = self function_22fb6ee8();
    team = util::get_team_mapping(team);
    foreach (e_player in util::get_players(team)) {
        mdl_gameobject show_waypoint(e_player);
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x169bde93, Offset: 0xb6a8
// Size: 0xbc
function hide_waypoint(e_player) {
    mdl_gameobject = self function_22fb6ee8();
    if (!isdefined(mdl_gameobject.objectiveid)) {
        return;
    }
    if (isdefined(e_player)) {
        if (!isplayer(e_player)) {
            assert(0, "<dev string:xc5>");
            return;
        }
        objective_setinvisibletoplayer(mdl_gameobject.objectiveid, e_player);
        return;
    }
    objective_setinvisibletoall(mdl_gameobject.objectiveid);
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xdedb7d64, Offset: 0xb770
// Size: 0xbc
function show_waypoint(e_player) {
    mdl_gameobject = self function_22fb6ee8();
    if (!isdefined(mdl_gameobject.objectiveid)) {
        return;
    }
    if (isdefined(e_player)) {
        if (!isplayer(e_player)) {
            assert(0, "<dev string:x102>");
            return;
        }
        objective_setvisibletoplayer(mdl_gameobject.objectiveid, e_player);
        return;
    }
    objective_setvisibletoall(mdl_gameobject.objectiveid);
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x9a96be96, Offset: 0xb838
// Size: 0x64
function should_ping_object(relativeteam) {
    if (relativeteam == #"friendly" && self.objidpingfriendly) {
        return true;
    } else if (relativeteam == #"enemy" && self.objidpingenemy) {
        return true;
    }
    return false;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x5260bcb5, Offset: 0xb8a8
// Size: 0x1b4
function get_update_teams(relativeteam) {
    updateteams = [];
    if (level.teambased) {
        if (relativeteam == #"friendly") {
            foreach (team, _ in level.teams) {
                if (self is_friendly_team(team)) {
                    updateteams[updateteams.size] = team;
                }
            }
        } else if (relativeteam == #"enemy") {
            foreach (team, _ in level.teams) {
                if (!self is_friendly_team(team)) {
                    updateteams[updateteams.size] = team;
                }
            }
        }
    } else if (relativeteam == #"friendly") {
        updateteams[updateteams.size] = level.nonteambasedteam;
    } else {
        updateteams[updateteams.size] = #"axis";
    }
    return updateteams;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xb30f79dc, Offset: 0xba68
// Size: 0x9a
function should_show_compass_due_to_radar(team) {
    showcompass = 0;
    if (!isdefined(self.carrier)) {
        return 0;
    }
    if (self.carrier hasperk(#"specialty_gpsjammer") == 0) {
        if (killstreaks::hasuav(team)) {
            showcompass = 1;
        }
    }
    if (killstreaks::hassatellite(team)) {
        showcompass = 1;
    }
    return showcompass;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x4
// Checksum 0x235294cf, Offset: 0xbb10
// Size: 0xae
function private _set_team(team) {
    self.ownerteam = team;
    if (team != #"any") {
        self.team = team;
        foreach (visual in self.visuals) {
            visual.team = team;
        }
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x5317f530, Offset: 0xbbc8
// Size: 0xb4
function set_owner_team(team) {
    mdl_gameobject = self function_22fb6ee8();
    if (team == #"any") {
        team = #"none";
    }
    team = util::get_team_mapping(team);
    mdl_gameobject _set_team(team);
    mdl_gameobject update_trigger();
    mdl_gameobject update_objective();
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x45e4e20a, Offset: 0xbc88
// Size: 0x32
function get_owner_team() {
    mdl_gameobject = self function_22fb6ee8();
    return mdl_gameobject.ownerteam;
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0xae609105, Offset: 0xbcc8
// Size: 0xd4
function flip_owner_team() {
    team = get_owner_team();
    b_trigger_enabled = self.trigger istriggerenabled();
    if (team === #"allies") {
        self set_owner_team(#"axis");
    } else if (team === #"axis") {
        self set_owner_team(#"allies");
    }
    self.trigger triggerenable(b_trigger_enabled);
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0xfdc4d91c, Offset: 0xbda8
// Size: 0x3c
function flip_owner_team_on_all_gameobjects() {
    if (isdefined(level.a_gameobjects)) {
        array::thread_all(level.a_gameobjects, &flip_owner_team);
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x5b12013a, Offset: 0xbdf0
// Size: 0x24
function function_7d73edfd() {
    self allow_use(#"none");
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0xfb8a7895, Offset: 0xbe20
// Size: 0x3c
function function_b3676c5c() {
    if (isdefined(level.a_gameobjects)) {
        array::thread_all(level.a_gameobjects, &function_7d73edfd);
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xfd92d50a, Offset: 0xbe68
// Size: 0x3c
function function_90353b55(point) {
    if (isdefined(level.a_gameobjects)) {
        return arraygetclosest(point, level.a_gameobjects);
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x40e3e2fc, Offset: 0xbeb0
// Size: 0x32
function set_decay_time(time) {
    self.decaytime = int(time * 1000);
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xb1a582f1, Offset: 0xbef0
// Size: 0x32
function set_use_time(time) {
    self.usetime = int(time * 1000);
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x698a811, Offset: 0xbf30
// Size: 0x32
function function_8fcdcc17(time) {
    self.var_c9cf215f = int(time * 1000);
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xc08fe45a, Offset: 0xbf70
// Size: 0x1a
function set_use_text(text) {
    self.usetext = text;
}

// Namespace gameobjects/gameobjects_shared
// Params 2, eflags: 0x0
// Checksum 0xe6c72a98, Offset: 0xbf98
// Size: 0x42
function set_team_use_time(relativeteam, time) {
    self.teamusetimes[relativeteam] = int(time * 1000);
}

// Namespace gameobjects/gameobjects_shared
// Params 2, eflags: 0x0
// Checksum 0x6ec9cc3f, Offset: 0xbfe8
// Size: 0x2a
function set_team_use_text(relativeteam, text) {
    self.teamusetexts[relativeteam] = text;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x9e34de26, Offset: 0xc020
// Size: 0x24
function set_use_hint_text(text) {
    self.trigger sethintstring(text);
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xfb4a2eae, Offset: 0xc050
// Size: 0x24
function allow_carry(relativeteam) {
    allow_use(relativeteam);
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x3aeb9ebb, Offset: 0xc080
// Size: 0x54
function allow_use(relativeteam) {
    mdl_gameobject = self function_22fb6ee8();
    mdl_gameobject.interactteam = relativeteam;
    mdl_gameobject update_trigger();
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x7ec3453b, Offset: 0xc0e0
// Size: 0x8c
function set_visible_team(relativeteam) {
    mdl_gameobject = self function_22fb6ee8();
    mdl_gameobject.visibleteam = relativeteam;
    if (!tweakables::gettweakablevalue("hud", "showobjicons")) {
        mdl_gameobject.visibleteam = #"none";
    }
    mdl_gameobject update_objective();
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x4ed049a6, Offset: 0xc178
// Size: 0x17e
function set_model_visibility(visibility) {
    if (visibility) {
        for (index = 0; index < self.visuals.size; index++) {
            self.visuals[index] show();
            if (self.visuals[index].classname == "script_brushmodel" || self.visuals[index].classname == "script_model") {
                self.visuals[index] thread make_solid();
            }
        }
        return;
    }
    for (index = 0; index < self.visuals.size; index++) {
        self.visuals[index] ghost();
        if (self.visuals[index].classname == "script_brushmodel" || self.visuals[index].classname == "script_model") {
            self.visuals[index] notify(#"changing_solidness");
            self.visuals[index] notsolid();
        }
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x637f5636, Offset: 0xc300
// Size: 0xd2
function make_solid() {
    self endon(#"death");
    self notify(#"changing_solidness");
    self endon(#"changing_solidness");
    while (true) {
        for (i = 0; i < level.players.size; i++) {
            if (level.players[i] is_touching_trigger(self)) {
                break;
            }
        }
        if (i == level.players.size) {
            self solid();
            break;
        }
        waitframe(1);
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xe840ea60, Offset: 0xc3e0
// Size: 0x1a
function set_carrier_visible(relativeteam) {
    self.carriervisible = relativeteam;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xcd5d53b8, Offset: 0xc408
// Size: 0x1a
function set_can_use(relativeteam) {
    self.useteam = relativeteam;
}

// Namespace gameobjects/gameobjects_shared
// Params 2, eflags: 0x0
// Checksum 0x6deca1c8, Offset: 0xc430
// Size: 0x2a
function set_2d_icon(relativeteam, shader) {
    self.compassicons[relativeteam] = shader;
}

// Namespace gameobjects/gameobjects_shared
// Params 2, eflags: 0x0
// Checksum 0xc16c11f1, Offset: 0xc468
// Size: 0x5e
function set_3d_icon(relativeteam, shader) {
    if (!isdefined(shader)) {
        self.worldicons_disabled[relativeteam] = 1;
    } else {
        self.worldicons_disabled[relativeteam] = 0;
    }
    self.worldicons[relativeteam] = shader;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x70e55796, Offset: 0xc4d0
// Size: 0x34
function set_objective_entity(entity) {
    if (isdefined(self.objectiveid)) {
        objective_onentity(self.objectiveid, entity);
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xe7181d60, Offset: 0xc510
// Size: 0x80
function get_objective_ids(team) {
    a_objective_ids = [];
    if (isdefined(self.objectiveid)) {
        if (!isdefined(a_objective_ids)) {
            a_objective_ids = [];
        } else if (!isarray(a_objective_ids)) {
            a_objective_ids = array(a_objective_ids);
        }
        a_objective_ids[a_objective_ids.size] = self.objectiveid;
    }
    return a_objective_ids;
}

// Namespace gameobjects/gameobjects_shared
// Params 5, eflags: 0x0
// Checksum 0xd013e327, Offset: 0xc598
// Size: 0x236
function gameobject_is_player_looking_at(origin, dot, do_trace, ignore_ent, ignore_trace_distance) {
    assert(isplayer(self), "<dev string:x13f>");
    if (!isdefined(dot)) {
        dot = 0.7;
    }
    if (!isdefined(do_trace)) {
        do_trace = 1;
    }
    eye = self util::get_eye();
    delta_vec = anglestoforward(vectortoangles(origin - eye));
    view_vec = anglestoforward(self getplayerangles());
    new_dot = vectordot(delta_vec, view_vec);
    if (new_dot >= dot) {
        if (do_trace) {
            trace = bullettrace(eye, origin, 0, ignore_ent);
            if (trace[#"position"] == origin) {
                return true;
            } else if (isdefined(ignore_trace_distance)) {
                n_mag = distance(origin, eye);
                n_dist = distance(trace[#"position"], eye);
                n_delta = abs(n_dist - n_mag);
                if (n_delta <= ignore_trace_distance) {
                    return true;
                }
            }
        } else {
            return true;
        }
    }
    return false;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xf6cd3d61, Offset: 0xc7d8
// Size: 0x1d4
function hide_icons(team) {
    if (self.visibleteam == #"any" || self.visibleteam == #"friendly") {
        hide_friendly = 1;
    } else {
        hide_friendly = 0;
    }
    if (self.visibleteam == #"any" || self.visibleteam == #"enemy") {
        hide_enemy = 1;
    } else {
        hide_enemy = 0;
    }
    self.hidden_compassicon = [];
    self.hidden_worldicon = [];
    if (hide_friendly == 1) {
        self.hidden_compassicon[#"friendly"] = self.compassicons[#"friendly"];
        self.hidden_worldicon[#"friendly"] = self.worldicons[#"friendly"];
    }
    if (hide_enemy == 1) {
        self.hidden_compassicon[#"enemy"] = self.compassicons[#"enemyy"];
        self.hidden_worldicon[#"enemy"] = self.worldicons[#"enemy"];
    }
    self set_2d_icon(team, undefined);
    self set_3d_icon(team, undefined);
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xddd263f8, Offset: 0xc9b8
// Size: 0x7c
function show_icons(team) {
    if (isdefined(self.hidden_compassicon[team])) {
        self set_2d_icon(team, self.hidden_compassicon[team]);
    }
    if (isdefined(self.hidden_worldicon[team])) {
        self set_3d_icon(team, self.hidden_worldicon[team]);
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 2, eflags: 0x0
// Checksum 0x5b391bd8, Offset: 0xca40
// Size: 0x2a
function set_3d_use_icon(relativeteam, shader) {
    self.worlduseicons[relativeteam] = shader;
}

// Namespace gameobjects/gameobjects_shared
// Params 2, eflags: 0x0
// Checksum 0xafe3c929, Offset: 0xca78
// Size: 0x2a
function set_3d_is_waypoint(relativeteam, waypoint) {
    self.worldiswaypoint[relativeteam] = waypoint;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x51de6851, Offset: 0xcab0
// Size: 0x4a
function set_carry_icon(shader) {
    assert(self.type == "<dev string:x16d>", "<dev string:x179>");
    self.carryicon = shader;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xf1e8b235, Offset: 0xcb08
// Size: 0x1a
function set_visible_carrier_model(visiblemodel) {
    self.visiblecarriermodel = visiblemodel;
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x5c5eeecd, Offset: 0xcb30
// Size: 0xa
function get_visible_carrier_model() {
    return self.visiblecarriermodel;
}

// Namespace gameobjects/gameobjects_shared
// Params 4, eflags: 0x0
// Checksum 0x75e8c75f, Offset: 0xcb48
// Size: 0x454
function destroy_object(deletetrigger, forcehide, b_connect_paths = 0, b_success = 0) {
    mdl_gameobject = function_22fb6ee8();
    if (isdefined(mdl_gameobject.e_object)) {
        mdl_gameobject.e_object flagsys::set(#"gameobject_destroyed");
    }
    mdl_gameobject endon(#"death");
    if (!isdefined(forcehide)) {
        forcehide = 1;
    }
    mdl_gameobject disable_object(forcehide, undefined, b_success, 1);
    if (isdefined(self.c_door) && self.c_door.m_str_type === "security") {
        if (isdefined(self.c_door.m_e_door)) {
            self.c_door.m_e_door notify(#"door_cleared");
        }
    }
    waittillframeend();
    foreach (visual in mdl_gameobject.visuals) {
        if (b_connect_paths) {
            visual connectpaths();
        }
        if (isdefined(visual)) {
            visual ghost();
            visual delete();
        }
    }
    if (isdefined(mdl_gameobject.trigger)) {
        mdl_gameobject.trigger notify(#"destroyed");
        if (isdefined(deletetrigger) && deletetrigger) {
            mdl_gameobject.trigger delete();
        } else {
            mdl_gameobject.trigger triggerenable(1);
        }
    }
    if (isinarray(level.a_gameobjects, mdl_gameobject)) {
        arrayremovevalue(level.a_gameobjects, mdl_gameobject);
    }
    if (isdefined(mdl_gameobject.var_322784b9) && isdefined(mdl_gameobject.var_322784b9.player)) {
        if (isdefined(mdl_gameobject.var_322784b9.enableweaponcycling) && mdl_gameobject.var_322784b9.enableweaponcycling) {
            mdl_gameobject.var_322784b9.player enableweaponcycling();
        }
    }
    if (isdefined(mdl_gameobject.var_322784b9) && isdefined(mdl_gameobject.var_322784b9.player)) {
        mdl_gameobject.var_322784b9.player val::reset(#"carry_object", "disable_weapons");
    }
    if (isdefined(mdl_gameobject.droptrigger)) {
        mdl_gameobject.droptrigger delete();
    }
    mdl_gameobject notify(#"destroyed_complete");
    e_container = mdl_gameobject.e_object;
    if (!isdefined(e_container) || !(isdefined(e_container.var_492c489b) && e_container.var_492c489b)) {
        mdl_gameobject release_all_objective_ids();
    }
    mdl_gameobject delete();
}

// Namespace gameobjects/gameobjects_shared
// Params 4, eflags: 0x0
// Checksum 0x263ae6f0, Offset: 0xcfa8
// Size: 0x2e4
function disable_object(var_dd2a09d4, var_b1e86ce8 = 1, b_success = 0, b_destroyed = 0) {
    mdl_gameobject = function_22fb6ee8();
    mdl_gameobject.b_enabled = undefined;
    mdl_gameobject notify(#"disabled");
    if (isdefined(mdl_gameobject.type) && (mdl_gameobject.type == "carryObject" || mdl_gameobject.type == "packObject") || isdefined(var_dd2a09d4) && var_dd2a09d4) {
        if (isdefined(mdl_gameobject.carrier)) {
            mdl_gameobject.carrier take_object(mdl_gameobject);
        }
        for (i = 0; i < mdl_gameobject.visuals.size; i++) {
            if (isdefined(mdl_gameobject.visuals[i])) {
                mdl_gameobject.visuals[i] ghost();
                mdl_gameobject.visuals[i] notsolid();
            }
        }
    }
    if (isdefined(mdl_gameobject.trigger)) {
        mdl_gameobject.trigger triggerenable(0);
    }
    if (var_b1e86ce8) {
        if (!isdefined(mdl_gameobject.str_restore_visible_team_after_disable)) {
            mdl_gameobject.str_restore_visible_team_after_disable = mdl_gameobject.visibleteam;
        }
        mdl_gameobject set_visible_team("none");
        if (isdefined(mdl_gameobject.objectiveid)) {
            objective_clearentity(mdl_gameobject.objectiveid);
            if (isdefined(mdl_gameobject.var_a279243a)) {
                release_obj_id(mdl_gameobject.objectiveid);
                objective_delete(mdl_gameobject.objectiveid);
                mdl_gameobject.objectiveid = undefined;
            }
        }
    }
    e_container = mdl_gameobject.e_object;
    if (isdefined(e_container) && isdefined(e_container.var_492c489b) && e_container.var_492c489b) {
        e_container function_af0bf601(b_success, b_destroyed);
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 2, eflags: 0x0
// Checksum 0x35ba82a7, Offset: 0xd298
// Size: 0x32c
function enable_object(var_12968e2f, b_show_objective = 1) {
    mdl_gameobject = function_22fb6ee8();
    mdl_gameobject endon(#"death");
    e_container = mdl_gameobject.e_object;
    if (isdefined(e_container) && isdefined(e_container.var_492c489b) && e_container.var_492c489b) {
        e_container function_80753d2a();
    }
    mdl_gameobject.b_enabled = 1;
    if (isdefined(mdl_gameobject.type) && (mdl_gameobject.type == "carryObject" || mdl_gameobject.type == "packObject") || isdefined(var_12968e2f) && var_12968e2f) {
        for (i = 0; i < mdl_gameobject.visuals.size; i++) {
            mdl_gameobject.visuals[i] show();
            mdl_gameobject.visuals[i] solid();
        }
    }
    if (isdefined(mdl_gameobject.trigger)) {
        mdl_gameobject.trigger triggerenable(1);
    }
    if (b_show_objective) {
        if (!isdefined(mdl_gameobject.objectiveid) && isdefined(mdl_gameobject.var_a279243a)) {
            mdl_gameobject [[ mdl_gameobject.var_a279243a ]]();
        }
        if (isdefined(mdl_gameobject.str_restore_visible_team_after_disable)) {
            mdl_gameobject set_visible_team(mdl_gameobject.str_restore_visible_team_after_disable);
            mdl_gameobject.str_restore_visible_team_after_disable = undefined;
        } else if (isdefined(mdl_gameobject.visibleteam)) {
            mdl_gameobject set_visible_team(mdl_gameobject.visibleteam);
        } else {
            mdl_gameobject set_visible_team(#"any");
        }
        if (isdefined(mdl_gameobject.objectiveid)) {
            objective_onentity(mdl_gameobject.objectiveid, mdl_gameobject);
            if (mdl_gameobject.type == "carryObject" || mdl_gameobject.type == "packObject") {
                mdl_gameobject notify(#"hash_431541b507a8c588");
                objective_setposition(mdl_gameobject.objectiveid, (0, 0, 0));
            }
        }
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x7cae8e0f, Offset: 0xd5d0
// Size: 0xac
function get_relative_team(team) {
    team = util::get_team_mapping(team);
    if (self.ownerteam == #"any") {
        return #"friendly";
    }
    if (team == self.ownerteam) {
        return #"friendly";
    }
    if (team == get_enemy_team(self.ownerteam)) {
        return #"enemy";
    }
    return #"neutral";
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x3c995334, Offset: 0xd688
// Size: 0x70
function is_friendly_team(team) {
    team = util::get_team_mapping(team);
    if (!level.teambased) {
        return true;
    }
    if (self.ownerteam == #"any") {
        return true;
    }
    if (self.ownerteam == team) {
        return true;
    }
    return false;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x902b3901, Offset: 0xd700
// Size: 0x30e
function can_touch(sentient) {
    var_1dd09e4d = isvehicle(sentient) || isplayer(sentient) && sentient isinvehicle() && !sentient function_80cbd71f();
    if (var_1dd09e4d && !(isdefined(level.b_allow_vehicle_proximity_pickup) && level.b_allow_vehicle_proximity_pickup) && !(isdefined(self.b_allow_vehicle_proximity_pickup) && self.b_allow_vehicle_proximity_pickup)) {
        return false;
    }
    if (isdefined(level.b_allow_vehicle_proximity_pickup) && level.b_allow_vehicle_proximity_pickup || isdefined(self.b_allow_vehicle_proximity_pickup) && self.b_allow_vehicle_proximity_pickup) {
        if (!isplayer(sentient) && !isvehicle(sentient)) {
            return false;
        }
    } else if (!isplayer(sentient)) {
        return false;
    }
    if (isplayer(sentient)) {
        if (!function_5deff6ef(sentient)) {
            return false;
        }
        if (isdefined(self.var_d1de9af) && self.var_d1de9af && sentient isreloading()) {
            return false;
        }
    } else if (!isdefined(sentient.var_32eedb1a) || sentient.var_32eedb1a == 0) {
        return false;
    }
    if (self is_excluded(sentient)) {
        return false;
    }
    if (isdefined(self.canuseobject) && ![[ self.canuseobject ]](sentient)) {
        return false;
    }
    if (isdefined(sentient.var_a304768d) && sentient.var_a304768d.size > 0) {
        foreach (var_c31ded42 in sentient.var_a304768d) {
            if (isdefined(var_c31ded42.var_2fcb5e92) && (isdefined(var_c31ded42.var_2fcb5e92.var_b585cb7a) ? var_c31ded42.var_2fcb5e92.var_b585cb7a : 0)) {
                return false;
            }
        }
    }
    return true;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xf075c687, Offset: 0xda18
// Size: 0x27e
function can_interact_with(sentient) {
    if (isdefined(self.ignore_use_time)) {
        ignore_time = self.ignore_use_time[sentient getentitynumber()];
        if (isdefined(ignore_time)) {
            if (level.time < ignore_time) {
                return false;
            } else {
                self.ignore_use_time[sentient getentitynumber()] = undefined;
            }
        }
    }
    team = sentient.team;
    if (isdefined(self.absolute_visible_and_interact_team)) {
        if (team == self.absolute_visible_and_interact_team) {
            return true;
        }
    }
    if (isdefined(self.requiredweapon) && isplayer(sentient)) {
        player = sentient;
        if (!player hasweapon(self.requiredweapon)) {
            return false;
        }
        ammocount = player getammocount(self.requiredweapon);
        if (ammocount == 0) {
            return false;
        }
    }
    switch (self.interactteam) {
    case #"none":
        return false;
    case #"any":
        return true;
    case #"friendly":
        if (level.teambased) {
            if (team == self.ownerteam) {
                return true;
            } else {
                return false;
            }
        } else if (sentient == self.ownerteam) {
            return true;
        } else {
            return false;
        }
    case #"enemy":
        if (level.teambased) {
            if (team != self.ownerteam) {
                return true;
            } else if (isdefined(self.decayprogress) && self.decayprogress && self.curprogress > 0 && (!isdefined(self.decayprogressmin) || self.curprogress > self.decayprogressmin)) {
                return true;
            } else {
                return false;
            }
        } else if (sentient != self.ownerteam) {
            return true;
        } else {
            return false;
        }
    default:
        assert(0, "<dev string:x1a7>");
        return false;
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xe2e1cf6c, Offset: 0xdd00
// Size: 0x8e
function is_team(team) {
    team = util::get_team_mapping(team);
    switch (team) {
    case #"none":
    case #"neutral":
    case #"any":
        return true;
    }
    if (isdefined(level.teams[team])) {
        return true;
    }
    return false;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x9583a2f8, Offset: 0xdd98
// Size: 0x82
function is_relative_team(relativeteam) {
    switch (relativeteam) {
    case #"friendly":
    case #"none":
    case #"enemy":
    case #"any":
        return 1;
    default:
        return 0;
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x5e628fc2, Offset: 0xde28
// Size: 0xa2
function get_enemy_team(team) {
    team = util::get_team_mapping(team);
    switch (team) {
    case #"neutral":
        return #"none";
    case #"allies":
        return #"axis";
    default:
        return #"allies";
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xb09924c7, Offset: 0xded8
// Size: 0x7a
function set_absolute_visible_and_interact_team(team) {
    team = util::get_team_mapping(team);
    assert(team == #"allies" || team == #"axis", "<dev string:x1bc>");
    self.absolute_visible_and_interact_team = team;
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0xb2710c87, Offset: 0xdf60
// Size: 0xa0
function get_next_obj_id() {
    if (level.numgametypereservedobjectives < 64) {
        nextid = level.numgametypereservedobjectives;
        level.numgametypereservedobjectives++;
    } else if (level.releasedobjectives.size > 0) {
        nextid = array::pop_front(level.releasedobjectives, 0);
    }
    if (!isdefined(nextid)) {
        println("<dev string:x1ee>");
        nextid = 63;
    }
    return nextid;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x8167212d, Offset: 0xe008
// Size: 0xec
function release_obj_id(objid) {
    assert(objid < level.numgametypereservedobjectives);
    for (i = 0; i < level.releasedobjectives.size; i++) {
        if (objid == level.releasedobjectives[i] && objid == 63) {
            return;
        }
        assert(objid != level.releasedobjectives[i]);
    }
    level.releasedobjectives[level.releasedobjectives.size] = objid;
    objective_setstate(objid, "empty");
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0xae04608, Offset: 0xe100
// Size: 0xac
function release_all_objective_ids() {
    if (isdefined(self.objid)) {
        foreach (v in self.objid) {
            release_obj_id(v);
        }
    }
    if (isdefined(self.objectiveid)) {
        release_obj_id(self.objectiveid);
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x5fb61a7f, Offset: 0xe1b8
// Size: 0x5e
function get_label() {
    label = self.trigger.script_label;
    if (!isdefined(label)) {
        label = "";
        return label;
    }
    if (label[0] != "_") {
        return ("_" + label);
    }
    return label;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x238f84b2, Offset: 0xe220
// Size: 0x1a
function must_maintain_claim(enabled) {
    self.mustmaintainclaim = enabled;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x79fc5dd6, Offset: 0xe248
// Size: 0x1a
function can_contest_claim(enabled) {
    self.cancontestclaim = enabled;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x450d02e8, Offset: 0xe270
// Size: 0x34
function set_flags(flags) {
    if (isdefined(self.objectiveid)) {
        objective_setgamemodeflags(self.objectiveid, flags);
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x66cb1e90, Offset: 0xe2b0
// Size: 0x36
function get_flags(flags) {
    if (isdefined(self.objectiveid)) {
        return objective_getgamemodeflags(self.objectiveid);
    }
    return 0;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x58589005, Offset: 0xe2f0
// Size: 0x1a
function set_identifier(identifier) {
    self.identifier = identifier;
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0xefb43fd7, Offset: 0xe318
// Size: 0xa
function get_identifier() {
    return self.identifier;
}

// Namespace gameobjects/gameobjects_shared
// Params 7, eflags: 0x0
// Checksum 0x8158d6aa, Offset: 0xe330
// Size: 0x5e6
function create_pack_object(ownerteam, trigger, visuals, offset, objectivename, allowinitialholddelay = 0, allowweaponcyclingduringhold = 0) {
    if (!isdefined(level.max_packobjects)) {
        level.max_packobjects = 4;
    }
    assert(level.max_packobjects < 5, "<dev string:x21a>");
    packobject = spawn("script_model", trigger.origin);
    packobject.type = "packObject";
    packobject.curorigin = trigger.origin;
    packobject.entnum = trigger getentitynumber();
    if (issubstr(trigger.classname, "use")) {
        packobject.triggertype = "use";
    } else {
        packobject.triggertype = "proximity";
    }
    trigger.baseorigin = trigger.origin;
    packobject.trigger = trigger;
    trigger enablelinkto();
    packobject linkto(trigger);
    packobject.useweapon = undefined;
    if (!isdefined(offset)) {
        offset = (0, 0, 0);
    }
    if (!isdefined(objectivename)) {
        /#
            iprintln("<dev string:x261>");
        #/
        return;
    }
    for (index = 0; index < visuals.size; index++) {
        visuals[index].baseorigin = visuals[index].origin;
        visuals[index].baseangles = visuals[index].angles;
    }
    packobject.visuals = visuals;
    packobject _set_team(ownerteam);
    packobject.compassicons = [];
    packobject.objidpingfriendly = 0;
    packobject.objidpingenemy = 0;
    if (packobject function_7efc3a2f()) {
        assert(isdefined(objectivename), "<dev string:x30>");
        packobject.objid = [];
        level.objidstart += 2;
        packobject.objectiveid = get_next_obj_id();
        objective_add(packobject.objectiveid, "invisible", packobject.curorigin, objectivename);
    }
    packobject.carrier = undefined;
    packobject.isresetting = 0;
    packobject.interactteam = #"none";
    packobject.allowweapons = 1;
    packobject.visiblecarriermodel = undefined;
    packobject.dropoffset = 0;
    packobject.worldicons = [];
    packobject.carriervisible = 0;
    packobject.visibleteam = #"none";
    packobject.worldiswaypoint = [];
    packobject.worldicons_disabled = [];
    packobject.packicon = undefined;
    packobject.setdropped = undefined;
    packobject.ondrop = undefined;
    packobject.onpickup = undefined;
    packobject.onreset = undefined;
    packobject.usetime = 10000;
    packobject.decayprogress = 0;
    packobject.var_9d9c7b7 = 1;
    packobject.var_ccca48dc = 0;
    if (packobject.triggertype == "use") {
        packobject.trigger setcursorhint("HINT_INTERACTIVE_PROMPT");
        packobject.userate = 1;
        packobject thread use_object_use_think(!allowinitialholddelay, !allowweaponcyclingduringhold);
    } else {
        packobject setup_touching();
        packobject.curprogress = 0;
        packobject.userate = 0;
        packobject.claimteam = #"none";
        packobject.claimplayer = undefined;
        packobject.lastclaimteam = #"none";
        packobject.lastclaimtime = 0;
        packobject.claimgraceperiod = 0;
        packobject.mustmaintainclaim = 0;
        packobject.cancontestclaim = 0;
        packobject.teamusetimes = [];
        packobject.teamusetexts = [];
        packobject thread use_object_prox_think();
    }
    packobject thread update_carry_object_objective_origin();
    packobject.b_reusable = 1;
    return packobject;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xb4a3bcfb, Offset: 0xe920
// Size: 0x3c
function give_pack_object(object) {
    self.packobject[self.packobject.size] = object;
    self thread track_carrier(object);
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xffe75649, Offset: 0xe968
// Size: 0x82
function get_packicon_offset(index = 0) {
    if (self issplitscreen()) {
        size = 25;
        base = -130;
    } else {
        size = 35;
        base = -40;
    }
    int = base - size * index;
    return int;
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0xd557f5c9, Offset: 0xe9f8
// Size: 0x74
function adjust_remaining_packicons() {
    if (!isdefined(self.packicon)) {
        return;
    }
    if (self.packicon.size > 0) {
        for (i = 0; i < self.packicon.size; i++) {
            self.packicon[i].x = get_packicon_offset(i);
        }
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xfc1ec674, Offset: 0xea78
// Size: 0x4a
function set_pack_icon(shader) {
    assert(self.type == "<dev string:x290>", "<dev string:x29b>");
    self.packicon = shader;
}

// Namespace gameobjects/gameobjects_shared
// Params 8, eflags: 0x0
// Checksum 0x8273ec0b, Offset: 0xead0
// Size: 0x120
function init_game_objects(str_gameobject_bundle, str_team_override, b_allow_companion_command, t_override, a_keyline_objects, str_objective_override, str_tag_override, str_identifier_override) {
    c_interact_obj = new cinteractobj();
    c_interact_obj.e_object = self;
    str_bundle = undefined;
    if (isdefined(str_gameobject_bundle)) {
        str_bundle = str_gameobject_bundle;
        self.scriptbundlename = str_bundle;
    } else if (self.classname === "scriptbundle_gameobject") {
        str_bundle = self.scriptbundlename;
    }
    assert(isdefined(str_bundle), "<dev string:x2cb>" + self.origin);
    [[ c_interact_obj ]]->init_game_object(str_bundle, str_team_override, str_tag_override, str_identifier_override, a_keyline_objects, t_override, b_allow_companion_command, str_objective_override);
    return c_interact_obj;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x7da69cf7, Offset: 0x10558
// Size: 0x36
function assign_class_object(o_class) {
    mdl_gameobject = function_22fb6ee8();
    mdl_gameobject.classobj = o_class;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xf1b988f9, Offset: 0x10598
// Size: 0x36
function set_onbeginuse_event(func) {
    mdl_gameobject = function_22fb6ee8();
    mdl_gameobject.onbeginuse = func;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x50f961b2, Offset: 0x105d8
// Size: 0x36
function set_onuse_event(func) {
    mdl_gameobject = function_22fb6ee8();
    mdl_gameobject.onuse = func;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x8df0edcb, Offset: 0x10618
// Size: 0x36
function set_onenduse_event(func) {
    mdl_gameobject = function_22fb6ee8();
    mdl_gameobject.onenduse = func;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x4e66bcd2, Offset: 0x10658
// Size: 0x36
function set_onpickup_event(func) {
    mdl_gameobject = function_22fb6ee8();
    mdl_gameobject.onpickup = func;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xc7796c96, Offset: 0x10698
// Size: 0x36
function function_3aedc503(func) {
    mdl_gameobject = function_22fb6ee8();
    mdl_gameobject.ondrop = func;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x1a424c7c, Offset: 0x106d8
// Size: 0x36
function function_6b132559(func) {
    mdl_gameobject = function_22fb6ee8();
    mdl_gameobject.oncantuse = func;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x1cf4f4c7, Offset: 0x10718
// Size: 0x36
function function_505e6730(func) {
    mdl_gameobject = function_22fb6ee8();
    mdl_gameobject.onuseupdate = func;
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x4
// Checksum 0x327ee4c, Offset: 0x10758
// Size: 0x20
function private function_22fb6ee8() {
    if (isdefined(self.mdl_gameobject)) {
        return self.mdl_gameobject;
    }
    return self;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xa27e6702, Offset: 0x10780
// Size: 0x47c
function play_interact_anim(e_player) {
    e_player endon(#"disconnect");
    if (isdefined(self.str_player_scene_anim)) {
        str_player_scene = self.str_player_scene_anim;
        if (isdefined(self.b_use_gameobject_for_alignment) && self.b_use_gameobject_for_alignment) {
            e_align = self.e_object;
        } else if (isdefined(self.var_1746dca5) && self.var_1746dca5) {
            e_align = e_player;
        } else {
            e_align = level;
        }
        a_ents = array(e_player);
        if (self.type == "carryObject") {
            if (!isdefined(a_ents)) {
                a_ents = [];
            } else if (!isarray(a_ents)) {
                a_ents = array(a_ents);
            }
            a_ents[a_ents.size] = self.visuals[0];
        }
        if (isdefined(self.var_9a11b419) && self.var_9a11b419) {
            s_waitresult = self waittill(#"gameobject_end_use_player", #"gameobject_abort", #"death");
            if (s_waitresult._notify === "gameobject_end_use_player") {
                e_align thread scene::play(str_player_scene, a_ents);
            }
        } else {
            e_align thread scene::play(str_player_scene, a_ents);
            waitframe(1);
            if (isdefined(self) && isdefined(e_player.str_current_anim) && isdefined(self.b_scene_use_time_override) && self.b_scene_use_time_override) {
                var_41b6c34b = getanimlength(e_player.str_current_anim);
                self set_use_time(var_41b6c34b);
            }
            while (e_player usebuttonpressed() && isdefined(self) && isdefined(self.e_object) && !self.e_object flag::get("gameobject_end_use")) {
                waitframe(1);
            }
            e_align scene::stop(str_player_scene);
            if (isdefined(self) && self.type == "carryObject" && !isdefined(self.carrier)) {
                self thread set_dropped(e_player);
            }
        }
        return;
    }
    if (isdefined(self.str_anim)) {
        mdl_anchor = util::spawn_model("tag_origin", e_player.origin, e_player.angles);
        self thread anchor_delete_watcher(mdl_anchor);
        str_anim = self.str_anim;
        if (isdefined(str_anim)) {
            e_player thread animation::play(str_anim, mdl_anchor, undefined, 1, 0.2, 0);
        }
        if (isdefined(self.str_obj_anim)) {
            self.e_object thread animation::play(self.str_obj_anim, self.e_object, undefined, 1, 0.2, 0);
        }
        while (e_player usebuttonpressed() && isdefined(self) && !self.e_object flag::get("gameobject_end_use")) {
            waitframe(1);
        }
        if (e_player.str_current_anim === str_anim) {
            e_player thread animation::stop();
        }
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xd8f15f9c, Offset: 0x10c08
// Size: 0x6c
function anchor_delete_watcher(mdl_anchor) {
    self.e_object waittill(#"gameobject_end_use", #"gameobject_abort");
    util::wait_network_frame();
    if (isdefined(mdl_anchor)) {
        mdl_anchor delete();
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 2, eflags: 0x0
// Checksum 0xa6dc1923, Offset: 0x10c80
// Size: 0xc2
function function_4de10422(touchlist, touch) {
    if (!isplayer(touch.player)) {
        if (isdefined(touch.player.owner) && isplayer(touch.player.owner)) {
            if (array::find(touchlist, touch.player.owner) == undefined) {
                return touch.player.owner;
            }
        }
    } else {
        return touch.player;
    }
    return undefined;
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x487021e6, Offset: 0x10d50
// Size: 0x1b8
function function_1a1e5850() {
    if (!(isdefined(self.var_ccca48dc) && self.var_ccca48dc)) {
        return;
    }
    contributors = [];
    var_17a75d13 = self.var_17a75d13[self.team];
    if (!var_17a75d13.size) {
        var_17a75d13 = self.var_17a75d13[self.claimteam];
    }
    foreach (contribution in var_17a75d13) {
        contributor = contribution.player;
        percentage = 100 * contribution.contribution / self.usetime;
        contributor.var_7709e43f = int(0.5 + percentage);
        if (contributor.var_7709e43f > getgametypesetting(#"contributionmin")) {
            if (!isdefined(contributors)) {
                contributors = [];
            } else if (!isarray(contributors)) {
                contributors = array(contributors);
            }
            contributors[contributors.size] = contributor;
        }
    }
    return contributors;
}

