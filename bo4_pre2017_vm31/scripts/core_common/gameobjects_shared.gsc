#using scripts/core_common/animation_shared;
#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/hostmigration_shared;
#using scripts/core_common/hud_util_shared;
#using scripts/core_common/killstreaks_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/player_role;
#using scripts/core_common/scene_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/trigger_shared;
#using scripts/core_common/tweakables_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/values_shared;
#using scripts/core_common/weapons_shared;

#namespace gameobjects;

// Namespace gameobjects
// Method(s) 5 Total 5
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

    // Namespace cinteractobj/gameobjects_shared
    // Params 0, eflags: 0x0
    // Checksum 0x1b93275, Offset: 0xb5f0
    // Size: 0x14
    function constructor() {
        m_str_trigger_type = "use";
    }

    // Namespace cinteractobj/gameobjects_shared
    // Params 0, eflags: 0x0
    // Checksum 0xfedd5785, Offset: 0xb610
    // Size: 0x24
    function destructor() {
        /#
            iprintlnbold("<dev string:x290>");
        #/
    }

    // Namespace cinteractobj/gameobjects_shared
    // Params 1, eflags: 0x0
    // Checksum 0x8ca550f1, Offset: 0xc398
    // Size: 0xb4
    function is_valid_gameobject_trigger(t_override) {
        if (m_str_trigger_type === "proximity") {
            switch (t_override.classname) {
            case #"trigger_box":
            case #"trigger_multiple":
            case #"trigger_once":
            case #"trigger_radius":
                return true;
            default:
                return false;
            }
        } else {
            switch (t_override.classname) {
            case #"trigger_radius_use":
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
    // Checksum 0x5a94a31a, Offset: 0xbc00
    // Size: 0x78c
    function create_gameobject_trigger() {
        if (!isdefined(m_t_interact)) {
            if (m_str_type === "generic" || m_str_trigger_type === "proximity") {
                m_t_interact = spawn("trigger_radius", m_v_tag_origin + m_n_trigger_offset + (0, 0, m_n_trigger_height / 2), 0, m_n_trigger_radius, m_n_trigger_height, 1);
            } else {
                m_t_interact = spawn("trigger_radius_use", m_v_tag_origin + m_n_trigger_offset + (0, 0, m_n_trigger_height / 2), 0, m_n_trigger_radius, m_n_trigger_height, 1);
            }
        }
        m_t_interact triggerignoreteam();
        m_t_interact setvisibletoall();
        m_t_interact setcursorhint("HINT_INTERACTIVE_PROMPT");
        if (m_str_team != "any") {
            m_t_interact setteamfortrigger(m_str_team);
        }
        if (!isdefined(m_a_keyline_objects)) {
            m_a_keyline_objects = [];
        } else if (!isarray(m_a_keyline_objects)) {
            m_a_keyline_objects = array(m_a_keyline_objects);
        }
        switch (m_str_type) {
        case #"use":
            mdl_gameobject = gameobjects::create_use_object(m_str_team, m_t_interact, m_a_keyline_objects, (0, 0, 0), m_str_objective);
            break;
        case #"carry":
            assert(isdefined(m_a_keyline_objects[0]), "<dev string:x311>");
            mdl_gameobject = gameobjects::create_carry_object(m_str_team, m_t_interact, m_a_keyline_objects, (0, 0, 0), m_str_objective);
            break;
        case #"pack":
            assert(isdefined(m_a_keyline_objects[0]), "<dev string:x311>");
            mdl_gameobject = gameobjects::create_pack_object(m_str_team, m_t_interact, m_a_keyline_objects, (0, 0, 0), m_str_objective);
            break;
        case #"generic":
            mdl_gameobject = gameobjects::create_generic_object(m_str_team, m_t_interact, m_a_keyline_objects, (0, 0, 0));
            break;
        default:
            mdl_gameobject = gameobjects::create_use_object(m_str_team, m_t_interact, m_a_keyline_objects, (0, 0, 0), m_str_objective);
            break;
        }
        mdl_gameobject.single_use = 0;
        mdl_gameobject gameobjects::set_identifier(m_str_identifier);
        mdl_gameobject.origin = m_t_interact.origin;
        mdl_gameobject.angles = m_t_interact.angles;
        mdl_gameobject gameobjects::set_owner_team(m_str_team);
        if (m_str_team == "any") {
            mdl_gameobject gameobjects::allow_use(m_str_team);
            mdl_gameobject gameobjects::set_visible_team(m_str_team);
        } else {
            mdl_gameobject gameobjects::allow_use("friendly");
            mdl_gameobject gameobjects::set_visible_team("friendly");
        }
        mdl_gameobject gameobjects::set_use_time(m_n_trigger_use_time);
        mdl_gameobject.str_player_scene_anim = m_str_player_scene_anim;
        mdl_gameobject.str_anim = m_str_anim;
        mdl_gameobject.b_reusable = m_b_reusable;
        mdl_gameobject.b_auto_reenable = m_b_auto_reenable;
        mdl_gameobject.allowweapons = m_b_allow_weapons;
        mdl_gameobject.b_scene_use_time_override = m_b_scene_use_time_override;
        mdl_gameobject.b_use_gameobject_for_alignment = m_b_gameobject_scene_alignment;
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
    // Params 7, eflags: 0x0
    // Checksum 0x3d5e571d, Offset: 0xb640
    // Size: 0x5b4
    function init_game_object(str_bundle, str_team_override, str_tag_override, str_identifier_override, a_keyline_objects, t_override, b_allow_companion_command) {
        if (!isdefined(b_allow_companion_command)) {
            b_allow_companion_command = 1;
        }
        m_s_bundle = getscriptbundle(str_bundle);
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
                    println("<dev string:x2b0>" + m_s_bundle.str_tag + "<dev string:x2c3>" + e_object.model);
                }
            #/
        }
        m_n_trigger_height = m_s_bundle.n_trigger_height;
        m_n_trigger_radius = m_s_bundle.n_trigger_radius;
        m_str_team = m_s_bundle.str_team;
        m_str_player_scene_anim = m_s_bundle.playerscenebundle;
        m_b_scene_use_time_override = m_s_bundle.playerscenebundletimeoverride;
        m_str_anim = m_s_bundle.viewanim;
        m_str_obj_anim = m_s_bundle.entityanim;
        m_b_reusable = m_s_bundle.b_reusable;
        m_b_auto_reenable = m_s_bundle.autoreenable;
        m_str_identifier = m_s_bundle.str_identifier;
        m_str_trigger_type = m_s_bundle.triggertype;
        m_b_gameobject_scene_alignment = m_s_bundle.playerscenebundlegameobjectalignment;
        m_n_trigger_use_time = m_s_bundle.n_trigger_use_time;
        if (!isdefined(m_n_trigger_use_time)) {
            m_n_trigger_use_time = 0;
        }
        if (isdefined(str_identifier_override)) {
            m_str_identifier = str_identifier_override;
        }
        m_str_hint = istring(m_s_bundle.str_hint);
        m_str_objective = istring(m_s_bundle.objective);
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
        m_a_keyline_objects = a_keyline_objects;
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
                assert("<dev string:x2e7>");
            }
        }
        self create_gameobject_trigger();
    }

}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x2
// Checksum 0x6b07f311, Offset: 0x6c0
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gameobjects", &__init__, undefined, undefined);
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x9f3a7b39, Offset: 0x700
// Size: 0x94
function __init__() {
    level.numgametypereservedobjectives = 0;
    level.releasedobjectives = [];
    level.a_gameobjects = [];
    callback::on_spawned(&on_player_spawned);
    callback::on_disconnect(&on_disconnect);
    callback::on_laststand(&on_player_last_stand);
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x8be2aa6b, Offset: 0x7a0
// Size: 0x1ac
function main() {
    level.vehiclesenabled = getgametypesetting("vehiclesEnabled");
    level.vehiclestimed = getgametypesetting("vehiclesTimed");
    level.objectivepingdelay = getgametypesetting("objectivePingTime");
    level.nonteambasedteam = "allies";
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
    level thread function_872a12c6();
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x7ebed030, Offset: 0x958
// Size: 0x4a
function register_allowed_gameobject(gameobject) {
    if (!isdefined(level.allowedgameobjects)) {
        level.allowedgameobjects = [];
    }
    level.allowedgameobjects[level.allowedgameobjects.size] = gameobject;
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x15535acc, Offset: 0x9b0
// Size: 0x14
function clear_allowed_gameobjects() {
    level.allowedgameobjects = [];
}

// Namespace gameobjects/gameobjects_shared
// Params 2, eflags: 0x0
// Checksum 0x6ccf95c8, Offset: 0x9d0
// Size: 0x118
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
// Checksum 0xf008702b, Offset: 0xaf0
// Size: 0x130
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
// Checksum 0x27544552, Offset: 0xc28
// Size: 0x206
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
// Checksum 0x71dc6dcf, Offset: 0xe38
// Size: 0x15c
function function_872a12c6() {
    foreach (s_radiant in struct::get_script_bundle_instances("gameobject")) {
        if (isdefined(s_radiant.script_team) && s_radiant.script_team != "none") {
            str_team_override = s_radiant.script_team;
        } else {
            str_team_override = undefined;
        }
        s_radiant init_game_objects(undefined, str_team_override);
        if (!(isdefined(s_radiant.script_enable_on_start) && s_radiant.script_enable_on_start)) {
            s_radiant.mdl_gameobject disable_object(1);
        }
    }
    level flagsys::set("radiant_gameobjects_initialized");
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xcc79be7d, Offset: 0xfa0
// Size: 0x1c
function set_use_multiplier_callback(callbackfunction) {
    self.getuseratemultiplier = callbackfunction;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xbce526e2, Offset: 0xfc8
// Size: 0x162
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
// Checksum 0xe56ab855, Offset: 0x1138
// Size: 0x18a
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
// Checksum 0xb7178e0b, Offset: 0x12d0
// Size: 0x8e
function on_player_spawned() {
    self endon(#"disconnect");
    level endon(#"game_ended");
    self thread on_death();
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
// Params 0, eflags: 0x0
// Checksum 0x8107ca25, Offset: 0x1368
// Size: 0x44
function on_death() {
    level endon(#"game_ended");
    self endon(#"hash_7156ad3a");
    self waittill("death");
    self thread gameobjects_dropped();
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0xae163d29, Offset: 0x13b8
// Size: 0x24
function on_disconnect() {
    level endon(#"game_ended");
    self thread gameobjects_dropped();
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x7444801e, Offset: 0x13e8
// Size: 0x1c
function on_player_last_stand() {
    self thread gameobjects_dropped();
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0xd2c998a7, Offset: 0x1410
// Size: 0xda
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
// Params 8, eflags: 0x0
// Checksum 0x98b18508, Offset: 0x14f8
// Size: 0x674
function create_carry_object(ownerteam, trigger, visuals, offset, objectivename, hitsound, allowinitialholddelay, allowweaponcyclingduringhold) {
    if (!isdefined(allowinitialholddelay)) {
        allowinitialholddelay = 0;
    }
    if (!isdefined(allowweaponcyclingduringhold)) {
        allowweaponcyclingduringhold = 0;
    }
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
    if (!isdefined(objectivename)) {
        /#
            iprintln("<dev string:x28>");
        #/
        return;
    }
    for (index = 0; index < visuals.size; index++) {
        visuals[index].baseorigin = visuals[index].origin;
        visuals[index].baseangles = visuals[index].angles;
    }
    carryobject.visuals = visuals;
    carryobject _set_team(ownerteam);
    carryobject.compassicons = [];
    carryobject.objid = [];
    carryobject.objidpingfriendly = 0;
    carryobject.objidpingenemy = 0;
    level.objidstart += 2;
    carryobject.objectiveid = get_next_obj_id();
    objective_add(carryobject.objectiveid, "invisible", carryobject.curorigin, objectivename);
    carryobject.carrier = undefined;
    carryobject.isresetting = 0;
    carryobject.interactteam = "none";
    carryobject.allowweapons = 0;
    carryobject.visiblecarriermodel = undefined;
    carryobject.dropoffset = 0;
    carryobject.disallowremotecontrol = 0;
    carryobject.worldicons = [];
    carryobject.carriervisible = 0;
    carryobject.visibleteam = "none";
    carryobject.worldiswaypoint = [];
    carryobject.worldicons_disabled = [];
    carryobject.carryicon = undefined;
    carryobject.setdropped = undefined;
    carryobject.ondrop = undefined;
    carryobject.onpickup = undefined;
    carryobject.onreset = undefined;
    carryobject.usetime = 10000;
    carryobject.decayprogress = 0;
    carryobject clear_progress();
    if (carryobject.triggertype == "use") {
        carryobject.trigger setcursorhint("HINT_INTERACTIVE_PROMPT");
        carryobject.userate = 1;
        carryobject thread use_object_use_think(!allowinitialholddelay, !allowweaponcyclingduringhold);
    } else {
        carryobject setup_touching();
        carryobject.curprogress = 0;
        carryobject.userate = 0;
        carryobject.claimteam = "none";
        carryobject.claimplayer = undefined;
        carryobject.lastclaimteam = "none";
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
    carryobject thread update_carry_object_objective_origin();
    array::add(level.a_gameobjects, carryobject, 0);
    carryobject.b_reusable = 1;
    return carryobject;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x3f89497d, Offset: 0x1b78
// Size: 0x84
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
// Checksum 0xebfcc9d5, Offset: 0x1c08
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
    self update_objective();
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0xa758de7c, Offset: 0x1e28
// Size: 0x212
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
// Checksum 0xeb2f033b, Offset: 0x2048
// Size: 0xaa
function ghost_visuals() {
    foreach (visual in self.visuals) {
        visual ghost();
        visual thread unlink_grenades();
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0xe7017c1a, Offset: 0x2100
// Size: 0xe6
function update_carry_object_objective_origin() {
    level endon(#"game_ended");
    self.trigger endon(#"destroyed");
    objpingdelay = level.objectivepingdelay;
    for (;;) {
        if (isdefined(self.carrier)) {
            self.curorigin = self.carrier.origin;
            objective_setposition(self.objectiveid, self.curorigin);
            self util::wait_endon(objpingdelay, "dropped", "reset");
            continue;
        }
        objective_setposition(self.objectiveid, self.curorigin);
        waitframe(1);
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x69d3ef95, Offset: 0x21f0
// Size: 0x2d4
function give_object(object) {
    assert(!isdefined(self.carryobject));
    self.carryobject = object;
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
            self waittilltimeout(2, "weapon_change");
        }
        self switchtoweaponimmediate(object.carryweapon);
        self setblockweaponpickup(object.carryweapon, 1);
        self disableweaponcycling();
    } else if (!allowweapons) {
        self util::_disableweapon();
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
// Checksum 0x72923754, Offset: 0x24d0
// Size: 0xda
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
// Checksum 0xc85012dc, Offset: 0x25b8
// Size: 0xf0
function return_home() {
    self.isresetting = 1;
    prev_origin = self.trigger.origin;
    self notify(#"reset");
    self move_visuals_to_base();
    self.trigger.origin = self.trigger.baseorigin;
    self.curorigin = self.trigger.origin;
    if (isdefined(self.onreset)) {
        self [[ self.onreset ]](prev_origin);
    }
    self clear_carrier();
    update_objective();
    self.isresetting = 0;
}

// Namespace gameobjects/gameobjects_shared
// Params 2, eflags: 0x0
// Checksum 0xe3d9a27d, Offset: 0x26b0
// Size: 0xcc
function set_new_base_position(v_base_pos, v_angles) {
    foreach (visual in self.visuals) {
        visual.baseorigin = v_base_pos;
        if (isdefined(v_angles)) {
            visual.baseangles = v_angles;
        }
    }
    self.trigger.baseorigin = v_base_pos;
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x5958c240, Offset: 0x2788
// Size: 0x5c
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
// Checksum 0x767f76dd, Offset: 0x27f0
// Size: 0x150
function set_position(origin, angles) {
    self.isresetting = 1;
    foreach (visual in self.visuals) {
        visual.origin = origin;
        visual.angles = angles;
        visual dontinterpolate();
        visual show();
    }
    self.trigger set_trigger_origin(origin);
    self.curorigin = origin;
    self clear_carrier();
    update_objective();
    self.isresetting = 0;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x7d5c9fac, Offset: 0x2948
// Size: 0x1c
function set_drop_offset(height) {
    self.dropoffset = height;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xa21a42f0, Offset: 0x2970
// Size: 0x70
function set_trigger_origin(origin) {
    offset = (self.maxs[2] - self.mins[2]) / 2;
    self.origin = (origin[0], origin[1], origin[2] + offset);
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x426bb310, Offset: 0x29e8
// Size: 0x730
function set_dropped() {
    if (isdefined(self.carrier)) {
        objective_setvisibletoplayer(self.objectiveid, self.carrier);
    }
    if (isdefined(self.setdropped)) {
        if ([[ self.setdropped ]]()) {
            return;
        }
    }
    self.isresetting = 1;
    self notify(#"dropped");
    startorigin = (0, 0, 0);
    endorigin = (0, 0, 0);
    body = undefined;
    if (isdefined(self.carrier) && self.carrier.team != "spectator") {
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
    trace_size = 10;
    trace = physicstrace(startorigin, endorigin, (trace_size * -1, trace_size * -1, trace_size * -1), (trace_size, trace_size, trace_size), self.carrier, 32);
    droppingplayer = self.carrier;
    self clear_carrier();
    if (isdefined(trace)) {
        tempangle = randomfloat(360);
        droporigin = trace["position"] + (0, 0, self.dropoffset);
        if (trace["fraction"] < 1) {
            forward = (cos(tempangle), sin(tempangle), 0);
            forward = vectornormalize(forward - vectorscale(trace["normal"], vectordot(forward, trace["normal"])));
            if (sessionmodeismultiplayergame()) {
                if (isdefined(trace["walkable"])) {
                    if (trace["walkable"] == 0) {
                        end_reflect = forward * 1000 + trace["position"];
                        reflect_trace = physicstrace(trace["position"], end_reflect, (trace_size * -1, trace_size * -1, trace_size * -1), (trace_size, trace_size, trace_size), self, 32);
                        if (isdefined(reflect_trace)) {
                            droporigin = reflect_trace["position"] + (0, 0, self.dropoffset);
                            if (reflect_trace["fraction"] < 1) {
                                forward = (cos(tempangle), sin(tempangle), 0);
                                forward = vectornormalize(forward - vectorscale(reflect_trace["normal"], vectordot(forward, reflect_trace["normal"])));
                            }
                        }
                    }
                }
            }
            dropangles = vectortoangles(forward);
        } else {
            dropangles = (0, tempangle, 0);
        }
        foreach (visual in self.visuals) {
            visual.origin = droporigin;
            visual.angles = dropangles;
            visual dontinterpolate();
            visual show();
        }
        self.trigger set_trigger_origin(droporigin);
        self.curorigin = droporigin;
        self thread pickup_timeout(trace["position"][2], startorigin[2]);
    } else {
        self move_visuals_to_base();
        self.trigger.origin = self.trigger.baseorigin;
        self.curorigin = self.trigger.baseorigin;
    }
    if (isdefined(self.ondrop)) {
        self [[ self.ondrop ]](droppingplayer);
    }
    self.trigger triggerenable(1);
    self function_983a9443();
    self.isresetting = 0;
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x68696a66, Offset: 0x3120
// Size: 0x1c
function function_983a9443() {
    self update_objective();
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x72d75029, Offset: 0x3148
// Size: 0x4c
function set_carrier(carrier) {
    self.carrier = carrier;
    self notify(#"reset");
    objective_setplayerusing(self.objectiveid, carrier);
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x809de096, Offset: 0x31a0
// Size: 0xe
function get_carrier() {
    return self.carrier;
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0xad281465, Offset: 0x31b8
// Size: 0x6a
function clear_carrier() {
    if (!isdefined(self.carrier)) {
        return;
    }
    self.carrier take_object(self);
    objective_clearplayerusing(self.objectiveid, self.carrier);
    self.carrier = undefined;
    self notify(#"carrier_cleared");
}

// Namespace gameobjects/gameobjects_shared
// Params 3, eflags: 0x0
// Checksum 0xb812a3ab, Offset: 0x3230
// Size: 0xb4
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
// Checksum 0x64b5543d, Offset: 0x32f0
// Size: 0x5a
function is_touching_any_trigger_key_value(value, key, minz, maxz) {
    return self is_touching_any_trigger(getentarray(value, key), minz, maxz);
}

// Namespace gameobjects/gameobjects_shared
// Params 3, eflags: 0x0
// Checksum 0x3a294f5d, Offset: 0x3358
// Size: 0x1ec
function should_be_reset(minz, maxz, var_5a190e09) {
    if (self.visuals[0] is_touching_any_trigger_key_value("minefield", "targetname", minz, maxz)) {
        return true;
    }
    if (isdefined(var_5a190e09) && var_5a190e09 && self.visuals[0] is_touching_any_trigger_key_value("trigger_hurt", "classname", minz, maxz)) {
        return true;
    }
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
// Checksum 0xc4154f40, Offset: 0x3550
// Size: 0xd4
function pickup_timeout(minz, maxz) {
    self endon(#"pickup_object");
    self endon(#"reset");
    waitframe(1);
    if (self should_be_reset(minz, maxz, 1)) {
        self thread return_home();
        return;
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
// Checksum 0x2635a83c, Offset: 0x3630
// Size: 0x354
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
        if (isdefined(self.carryicon)) {
            self.carryicon hud::destroyelem();
        }
        self.carryobject = undefined;
    } else if (object.type == "packObject") {
        if (isdefined(self.packicon) && self.packicon.size > 0) {
            for (i = 0; i < self.packicon.size; i++) {
                if (isdefined(self.packicon[i].script_string)) {
                    if (self.packicon[i].script_string == object.packicon) {
                        elem = self.packicon[i];
                        arrayremovevalue(self.packicon, elem);
                        elem hud::destroyelem();
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
        self util::_enableweapon();
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x47604f0f, Offset: 0x3990
// Size: 0x64
function wait_take_carry_weapon(weapon) {
    self thread take_carry_weapon_on_death(weapon);
    wait max(0, weapon.firetime - 0.1);
    self take_carry_weapon(weapon);
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x3f72153f, Offset: 0x3a00
// Size: 0x3c
function take_carry_weapon_on_death(weapon) {
    self endon(#"take_carry_weapon");
    self waittill("death");
    self take_carry_weapon(weapon);
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xb5a37962, Offset: 0x3a48
// Size: 0x124
function take_carry_weapon(weapon) {
    self notify(#"take_carry_weapon");
    if (self hasweapon(weapon, 1)) {
        ballweapon = getweapon("ball");
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
// Checksum 0x2da0dee, Offset: 0x3b78
// Size: 0x12e
function track_carrier(object) {
    level endon(#"game_ended");
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"drop_object");
    waitframe(1);
    while (isdefined(object.carrier) && object.carrier == self && isalive(self)) {
        if (self isonground()) {
            trace = bullettrace(self.origin + (0, 0, 20), self.origin - (0, 0, 20), 0, undefined);
            if (trace["fraction"] < 1) {
                object.safeorigin = trace["position"];
            }
        }
        waitframe(1);
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0xbe2070fa, Offset: 0x3cb0
// Size: 0x150
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
// Checksum 0x8715b08f, Offset: 0x3e08
// Size: 0xa4
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
// Checksum 0xb4af6d5c, Offset: 0x3ec0
// Size: 0x260
function watchholdusedrop() {
    level endon(#"game_ended");
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"drop_object");
    assert(isdefined(self.carryobject));
    assert(isdefined(self.carryobject.droptrigger));
    trigger = self.carryobject.droptrigger;
    while (true) {
        waitresult = trigger waittill("trigger");
        if (self usebuttonpressed() && !self.throwinggrenade && !self meleebuttonpressed() && !self attackbuttonpressed() && !(isdefined(self.isplanting) && self.isplanting) && !(isdefined(self.isdefusing) && self.isdefusing) && !self isremotecontrolling()) {
            if (isdefined(self.carryobject)) {
                if (!isdefined(self.carryobject.ignore_use_time)) {
                    self.carryobject.ignore_use_time = [];
                }
                self.carryobject.ignore_use_time[self getentitynumber()] = level.time + 500;
                self sethintstring("");
                if (isdefined(self.carryobject.droptrigger)) {
                    self.carryobject.droptrigger delete();
                }
                self.carryobject thread set_dropped();
            }
        }
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x66a1eb6a, Offset: 0x4128
// Size: 0x24c
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
    self.carryobject.droptrigger sethintstring(%GAMEPLAY_HOLD_TO_DROP);
    self.carryobject.droptrigger setcursorhint("HINT_NOICON", self.carryobject);
    self.carryobject.droptrigger enablelinkto();
    self.carryobject.droptrigger linkto(self);
    self.carryobject.droptrigger setteamfortrigger(self.team);
    self.carryobject.droptrigger setinvisibletoall();
    self.carryobject.droptrigger setvisibletoplayer(self);
    self clientclaimtrigger(self.carryobject.droptrigger);
    self thread watchholdusedrop();
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x2f9d0c21, Offset: 0x4380
// Size: 0x94
function function_67317efa() {
    level endon(#"game_ended");
    self endon(#"disconnect");
    self endon(#"death");
    wait_time = level.time + 500;
    while (level.time < wait_time && self usebuttonpressed()) {
        waitframe(1);
    }
    self util::_enableweapon();
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x4
// Checksum 0x7ee22bdd, Offset: 0x4420
// Size: 0x130
function private setup_touching() {
    self.touchinguserate["neutral"] = 0;
    self.touchinguserate["none"] = 0;
    self.numtouching["neutral"] = 0;
    self.numtouching["none"] = 0;
    self.touchlist["neutral"] = [];
    self.touchlist["none"] = [];
    foreach (str_team in level.teams) {
        self.touchinguserate[str_team] = 0;
        self.numtouching[str_team] = 0;
        self.touchlist[str_team] = [];
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 4, eflags: 0x0
// Checksum 0xd5b22790, Offset: 0x4558
// Size: 0x36c
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
    generic_object.interactteam = "none";
    generic_object.onuse = undefined;
    generic_object.oncantuse = undefined;
    generic_object.onresumeuse = undefined;
    generic_object.usetime = 10000;
    generic_object clear_progress();
    generic_object.decayprogress = 0;
    if (generic_object.triggertype == "proximity") {
        generic_object setup_touching();
        generic_object.teamusetimes = [];
        generic_object.teamusetexts = [];
        generic_object.userate = 0;
        generic_object.claimteam = "none";
        generic_object.claimplayer = undefined;
        generic_object.lastclaimteam = "none";
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
// Params 7, eflags: 0x0
// Checksum 0x3da2d77e, Offset: 0x48d0
// Size: 0x57c
function create_use_object(ownerteam, trigger, visuals, offset, objectivename, allowinitialholddelay, allowweaponcyclingduringhold) {
    if (!isdefined(allowinitialholddelay)) {
        allowinitialholddelay = 0;
    }
    if (!isdefined(allowweaponcyclingduringhold)) {
        allowweaponcyclingduringhold = 0;
    }
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
    if (!isdefined(objectivename)) {
        /#
            iprintln("<dev string:x58>");
        #/
        return;
    }
    useobject.compassicons = [];
    useobject.objid = [];
    useobject.objectiveid = get_next_obj_id();
    if (sessionmodeiscampaigngame()) {
        useobject.keepweapon = 1;
    }
    objective_add(useobject.objectiveid, "invisible", useobject, objectivename);
    requiredspecialty = undefined;
    if (isdefined(objectivename)) {
        requiredspecialty = objective_getrequiredspecialty(objectivename);
    }
    if (isdefined(requiredspecialty)) {
        useobject.trigger setperkfortrigger(requiredspecialty);
    }
    useobject.interactteam = "none";
    useobject.worldicons = [];
    useobject.visibleteam = "none";
    useobject.worldiswaypoint = [];
    useobject.worldicons_disabled = [];
    useobject.onuse = undefined;
    useobject.oncantuse = undefined;
    useobject.onresumeuse = undefined;
    useobject.usetext = "default";
    useobject.usetime = 10000;
    useobject clear_progress();
    useobject.decayprogress = 0;
    if (useobject.triggertype == "proximity") {
        useobject setup_touching();
        useobject.teamusetimes = [];
        useobject.teamusetexts = [];
        useobject.userate = 0;
        useobject.claimteam = "none";
        useobject.claimplayer = undefined;
        useobject.lastclaimteam = "none";
        useobject.lastclaimtime = 0;
        useobject.claimgraceperiod = 1;
        useobject.mustmaintainclaim = 0;
        useobject.cancontestclaim = 0;
        useobject thread use_object_prox_think();
    } else {
        useobject.userate = 1;
        useobject thread use_object_use_think(!allowinitialholddelay, !allowweaponcyclingduringhold);
    }
    array::add(level.a_gameobjects, useobject, 0);
    useobject.b_reusable = 1;
    return useobject;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xdb2dd6fc, Offset: 0x4e58
// Size: 0x102
function set_key_object(object) {
    if (!isdefined(object)) {
        self.keyobject = undefined;
        return;
    }
    if (!isdefined(self.keyobject)) {
        self.keyobject = [];
    }
    if (isarray(object)) {
        foreach (obj in object) {
            self.keyobject[self.keyobject.size] = obj;
        }
        return;
    }
    self.keyobject[self.keyobject.size] = object;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x9328fc2f, Offset: 0x4f68
// Size: 0x102
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
// Params 2, eflags: 0x0
// Checksum 0xba61f9d7, Offset: 0x5078
// Size: 0x528
function use_object_use_think(disableinitialholddelay, disableweaponcyclingduringhold) {
    self.trigger endon(#"destroyed");
    if (self.usetime > 0 && disableinitialholddelay) {
        self.trigger usetriggerignoreuseholdtime();
    }
    while (true) {
        waitresult = self.trigger waittill("trigger");
        player = waitresult.activator;
        if (level.gameended) {
            continue;
        }
        if (!isalive(player)) {
            continue;
        }
        if (!self can_interact_with(player)) {
            continue;
        }
        if (isdefined(self.var_6f180198) && ![[ self.var_6f180198 ]](player)) {
            continue;
        }
        if (!player isonground() || player iswallrunning()) {
            continue;
        }
        if (player isinvehicle()) {
            continue;
        }
        if (isdefined(self.keyobject) && !player has_key_object(self)) {
            if (isdefined(self.oncantuse)) {
                self [[ self.oncantuse ]](player);
            }
            continue;
        }
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
            team = player.pers["team"];
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
        if (!(isdefined(result) && result)) {
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
        self notify(#"gameobject_end_use_player", {#player:player});
        if (player util::is_companion()) {
            level notify(#"hash_2b26439b", {#event:"complete", #player:player.owner, #object:self});
        }
        if (isdefined(self.onuse)) {
            if (isdefined(self.onuse_thread) && self.onuse_thread) {
                self thread use_object_onuse(player);
            } else {
                self use_object_onuse(player);
            }
        }
        self thread check_gameobject_reenable();
        if (self.type == "carryObject" || self.type === "packObject") {
            self set_picked_up(player);
        }
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xb40086dc, Offset: 0x55a8
// Size: 0x78
function use_object_onuse(player) {
    level endon(#"game_ended");
    self.trigger endon(#"destroyed");
    if (isdefined(self.classobj)) {
        self.classobj [[ self.onuse ]](self, player);
        return;
    }
    self [[ self.onuse ]](player);
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x8b54c565, Offset: 0x5628
// Size: 0x15a
function get_earliest_claim_player() {
    assert(self.claimteam != "<dev string:x86>");
    team = self.claimteam;
    earliestplayer = self.claimplayer;
    if (self.touchlist[team].size > 0) {
        earliesttime = undefined;
        players = getarraykeys(self.touchlist[team]);
        for (index = 0; index < players.size; index++) {
            touchdata = self.touchlist[team][players[index]];
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
// Checksum 0xf7f6ff11, Offset: 0x5790
// Size: 0xbc
function apply_player_use_modifiers(e_player) {
    if (e_player.team == "allies") {
        var_8f7e32a3 = level.var_d8c98a68;
    } else {
        var_8f7e32a3 = level.var_617511a5;
    }
    if (isdefined(var_8f7e32a3)) {
        var_650e605 = e_player getthreatbiasgroup();
        if (var_650e605 !== var_8f7e32a3) {
            e_player.var_33a1d78f = var_650e605;
            e_player setthreatbiasgroup(var_8f7e32a3);
        }
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xf38f50c, Offset: 0x5858
// Size: 0xaa
function remove_player_use_modifiers(e_player) {
    if (e_player.team == "allies") {
        var_8f7e32a3 = level.var_d8c98a68;
    } else {
        var_8f7e32a3 = level.var_617511a5;
    }
    if (isdefined(var_8f7e32a3)) {
        if (e_player getthreatbiasgroup() == var_8f7e32a3) {
            e_player setthreatbiasgroup(e_player.var_33a1d78f);
        }
        e_player.var_33a1d78f = undefined;
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x5a1bf3da, Offset: 0x5910
// Size: 0xbb0
function use_object_prox_think() {
    level endon(#"game_ended");
    self.trigger endon(#"destroyed");
    self thread prox_trigger_think();
    while (true) {
        if (self.usetime <= 0 && (self.usetime && self.curprogress >= self.usetime || self.numtouching[self.claimteam] > 0)) {
            self clear_progress();
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
            if (!self.mustmaintainclaim) {
                self set_claim_team("none");
                self.claimplayer = undefined;
            }
            self thread check_gameobject_reenable();
            if (self.type == "carryObject" || isdefined(creditplayer) && self.type === "packObject") {
                self set_picked_up(creditplayer);
            }
        }
        if (self.claimteam != "none") {
            if (self use_object_locked_for_team(self.claimteam)) {
                if (isdefined(self.onenduse)) {
                    if (isdefined(self.classobj)) {
                        self.classobj [[ self.onenduse ]](self, self get_claim_team(), self.claimplayer, 0);
                    } else {
                        self [[ self.onenduse ]](self get_claim_team(), self.claimplayer, 0);
                    }
                }
                self set_claim_team("none");
                self.claimplayer = undefined;
                self clear_progress();
            } else if (!self.mustmaintainclaim || self.usetime && self get_owner_team() != self get_claim_team()) {
                if (self.decayprogress && !self.numtouching[self.claimteam]) {
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
                        self.claimplayer = undefined;
                    }
                    decayscale = 0;
                    if (self.decaytime) {
                        decayscale = self.usetime / self.decaytime;
                    }
                    previousprogress = self.curprogress;
                    self.curprogress -= 50 * self.userate * decayscale;
                    if (isdefined(self.decayprogressmin) && self.curprogress < self.decayprogressmin) {
                        self.curprogress = self.decayprogressmin;
                    }
                    if (self.curprogress <= 0) {
                        self clear_progress();
                    }
                    self update_current_progress();
                    if (isdefined(self.onuseupdate)) {
                        deltaprogress = self.curprogress - previousprogress;
                        self [[ self.onuseupdate ]](self get_claim_team(), self.curprogress / self.usetime, deltaprogress / self.usetime);
                    }
                    if (self.curprogress == 0) {
                        self set_claim_team("none");
                    }
                    if (isdefined(hadprogress) && hadprogress && isdefined(self.ondecaycomplete) && self.curprogress <= 0) {
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
                    self set_claim_team("none");
                    self.claimplayer = undefined;
                } else {
                    self.curprogress += 50 * self.userate;
                    self update_current_progress();
                    if (isdefined(self.onuseupdate)) {
                        self [[ self.onuseupdate ]](self get_claim_team(), self.curprogress / self.usetime, 50 * self.userate / self.usetime);
                    }
                }
            } else if (!self.mustmaintainclaim) {
                if (isdefined(self.onuse)) {
                    self [[ self.onuse ]](self.claimplayer);
                }
                if (!self.mustmaintainclaim) {
                    self set_claim_team("none");
                    self.claimplayer = undefined;
                }
            } else if (!self.numtouching[self.claimteam]) {
                self.inuse = 0;
                if (isdefined(self.onunoccupied)) {
                    self [[ self.onunoccupied ]]();
                }
                self set_claim_team("none");
                self.claimplayer = undefined;
            } else if (self.cancontestclaim) {
                numother = get_num_touching_except_team(self.claimteam);
                if (numother > 0) {
                    if (isdefined(self.oncontested)) {
                        self [[ self.oncontested ]]();
                    }
                    self set_claim_team("none");
                    self.claimplayer = undefined;
                }
            }
        } else {
            if (!self.decayprogress && self.curprogress > 0 && gettime() - self.lastclaimtime > self.claimgraceperiod * 1000) {
                self clear_progress();
            }
            if (self.mustmaintainclaim && self get_owner_team() != "none") {
                if (!self.numtouching[self get_owner_team()]) {
                    self.inuse = 0;
                    if (isdefined(self.onunoccupied)) {
                        self [[ self.onunoccupied ]]();
                    }
                } else if (self.cancontestclaim && self.lastclaimteam != "none" && self.numtouching[self.lastclaimteam]) {
                    numother = get_num_touching_except_team(self.lastclaimteam);
                    if (numother == 0) {
                        if (isdefined(self.onuncontested)) {
                            self [[ self.onuncontested ]](self.lastclaimteam);
                        }
                    }
                }
            }
        }
        waitframe(1);
        hostmigration::waittillhostmigrationdone();
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0xe89d726b, Offset: 0x64c8
// Size: 0x17c
function check_gameobject_reenable() {
    self endon(#"death");
    if (isdefined(self.b_reusable) && isdefined(self.e_object) && self.b_reusable) {
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
            self.e_object flag::clear("gameobject_end_use");
        }
    }
    if (!(isdefined(self.b_reusable) && self.b_reusable)) {
        util::wait_network_frame();
        self thread destroy_object(1, 1);
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x66aeca0d, Offset: 0x6650
// Size: 0x60
function use_object_locked_for_team(str_team) {
    str_team = util::get_team_mapping(str_team);
    if (isdefined(self.teamlock) && isdefined(level.teams[str_team])) {
        return self.teamlock[str_team];
    }
    return 0;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xf3054fd7, Offset: 0x66b8
// Size: 0xa6
function can_claim(player) {
    if (isdefined(self.carrier)) {
        return false;
    }
    if (self.cancontestclaim) {
        numother = get_num_touching_except_team(player.pers["team"]);
        if (numother != 0) {
            return false;
        }
    }
    if (!isdefined(self.keyobject) || player has_key_object(self)) {
        return true;
    }
    return false;
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0xfd7c3a01, Offset: 0x6768
// Size: 0x510
function prox_trigger_think() {
    level endon(#"game_ended");
    self.trigger endon(#"destroyed");
    entitynumber = self.entnum;
    if (!isdefined(self.trigger.var_f52dc901)) {
        self.trigger.var_f52dc901 = 0;
    }
    while (true) {
        waitresult = self.trigger waittill("trigger");
        player = waitresult.activator;
        if (!isplayer(player)) {
            continue;
        }
        if (isdefined(level.vehicle_map) && level.vehicle_map) {
            if (!(isdefined(player.usingvehicle) && player.usingvehicle)) {
                continue;
            }
        }
        if (!isalive(player) || self use_object_locked_for_team(player.pers["team"])) {
            continue;
        }
        if (isdefined(player.laststand) && player.laststand) {
            continue;
        }
        if (player.spawntime == gettime()) {
            continue;
        }
        if (self.trigger.var_f52dc901 == 0) {
            if (player isremotecontrolling() || player util::isusingremote()) {
                continue;
            }
        }
        if (isdefined(player.selectinglocation) && player.selectinglocation) {
            continue;
        }
        if (player isweaponviewonlylinked()) {
            continue;
        }
        if (self is_excluded(player)) {
            continue;
        }
        if (isdefined(self.canuseobject) && ![[ self.canuseobject ]](player)) {
            continue;
        }
        resume_use = 0;
        if (self can_interact_with(player)) {
            if (self.claimteam == "none") {
                if (self can_claim(player)) {
                    set_claim_team(player.pers["team"]);
                    self.claimplayer = player;
                    relativeteam = self get_relative_team(player.pers["team"]);
                    if (isdefined(self.teamusetimes[relativeteam])) {
                        self.usetime = self.teamusetimes[relativeteam];
                    }
                    self.inuse = 1;
                    if (self.usetime && isdefined(self.onbeginuse)) {
                        if (isdefined(self.classobj)) {
                            self.classobj [[ self.onbeginuse ]](self, self.claimplayer);
                        } else {
                            self [[ self.onbeginuse ]](self.claimplayer);
                        }
                    }
                } else if (isdefined(self.oncantuse)) {
                    self [[ self.oncantuse ]](player);
                }
            } else if (self.claimteam == player.pers["team"] && self can_claim(player) && self.numtouching[self.claimteam] == 0) {
                resume_use = 1;
            }
        }
        if (isalive(player) && !isdefined(player.touchtriggers[entitynumber])) {
            player thread trigger_touch_think(self);
            if (resume_use && isdefined(self.onresumeuse)) {
                self [[ self.onresumeuse ]](player);
            }
        }
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x77f9a0f8, Offset: 0x6c80
// Size: 0xbc
function is_excluded(player) {
    if (!isdefined(self.exclusions)) {
        return false;
    }
    foreach (exclusion in self.exclusions) {
        if (exclusion istouching(player)) {
            return true;
        }
    }
    return false;
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x8188fdf1, Offset: 0x6d48
// Size: 0x58
function clear_progress() {
    self.curprogress = 0;
    self.decayprogressmin = 0;
    self update_current_progress();
    if (isdefined(self.onuseclear)) {
        self [[ self.onuseclear ]]();
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xcb97ea5a, Offset: 0x6da8
// Size: 0x11c
function set_claim_team(newteam) {
    assert(newteam != self.claimteam);
    if (!self.decayprogress && self.claimteam == "none" && gettime() - self.lastclaimtime > self.claimgraceperiod * 1000) {
        self clear_progress();
    } else if (newteam != "none" && newteam != self.lastclaimteam) {
        self clear_progress();
    }
    self.lastclaimteam = self.claimteam;
    self.lastclaimtime = gettime();
    self.claimteam = newteam;
    self update_use_rate();
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x985dedaf, Offset: 0x6ed0
// Size: 0xe
function get_claim_team() {
    return self.claimteam;
}

// Namespace gameobjects/gameobjects_shared
// Params 2, eflags: 0x0
// Checksum 0xe6e1522e, Offset: 0x6ee8
// Size: 0x18e
function continue_trigger_touch_think(team, object) {
    if (!isalive(self)) {
        return false;
    }
    if (isdefined(level.vehicle_map) && level.vehicle_map) {
        if (!(isdefined(self.usingvehicle) && self.usingvehicle)) {
            return false;
        }
    } else if (self isinvehicle() && !(isdefined(level.b_allow_vehicle_proximity_pickup) && level.b_allow_vehicle_proximity_pickup) && !(isdefined(object.b_allow_vehicle_proximity_pickup) && object.b_allow_vehicle_proximity_pickup)) {
        return false;
    }
    if (self use_object_locked_for_team(team)) {
        return false;
    }
    if (isdefined(self.laststand) && self.laststand) {
        return false;
    }
    if (!isdefined(object) || !isdefined(object.trigger)) {
        return false;
    }
    if (!object.trigger istriggerenabled()) {
        return false;
    }
    if (!self istouching(object.trigger)) {
        return false;
    }
    return true;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x3b783262, Offset: 0x7080
// Size: 0x1c
function setplayergametypeuseratecallback(callbackfunc) {
    self.gametypeuseratecallback = callbackfunc;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xc292a1a2, Offset: 0x70a8
// Size: 0x1c
function allow_vehicle_proximity_pickup(b_enable) {
    self.b_allow_vehicle_proximity_pickup = b_enable;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xab2f416e, Offset: 0x70d0
// Size: 0x494
function trigger_touch_think(object) {
    object.trigger endon(#"destroyed");
    team = self.pers["team"];
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
    touchname = "player" + self.clientid;
    struct = spawnstruct();
    struct.player = self;
    struct.starttime = gettime();
    struct.userate = player_use_rate;
    object.touchlist[team][touchname] = struct;
    if (object.usetime) {
        object update_use_rate();
    }
    if (isdefined(object.objectiveid)) {
        objective_setplayerusing(object.objectiveid, self);
    }
    self.touchtriggers[object.entnum] = object.trigger;
    if (isdefined(object.ontouchuse)) {
        object [[ object.ontouchuse ]](self);
    }
    while (self continue_trigger_touch_think(team, object)) {
        waitframe(1);
    }
    if (isdefined(self)) {
        self.touchtriggers[object.entnum] = undefined;
        if (isdefined(object.objectiveid)) {
            objective_clearplayerusing(object.objectiveid, self);
        }
    }
    if (level.gameended) {
        return;
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
// Checksum 0x6d46f622, Offset: 0x7570
// Size: 0xc2
function get_num_touching_except_team(ignoreteam) {
    numtouching = 0;
    foreach (team in level.teams) {
        if (ignoreteam == team) {
            continue;
        }
        numtouching += self.numtouching[team];
    }
    return numtouching;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x4c48043, Offset: 0x7640
// Size: 0xc4
function get_touching_use_rate_except_team(ignoreteam) {
    numtouching = 0;
    foreach (team in level.teams) {
        if (ignoreteam == team) {
            continue;
        }
        numtouching += get_team_use_rate(team);
    }
    return numtouching;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xabad5ae4, Offset: 0x7710
// Size: 0x11a
function get_team_use_rate(team) {
    useobject = self;
    userate = 0;
    if (useobject.touchlist[team].size > 0) {
        players = getarraykeys(useobject.touchlist[team]);
        for (i = 0; i < players.size; i++) {
            touchdata = useobject.touchlist[team][players[i]];
            if (isdefined(touchdata.userate) && touchdata.userate > userate) {
                userate = touchdata.userate;
            }
        }
    }
    return userate;
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x1faf44bd, Offset: 0x7838
// Size: 0x174
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
// Checksum 0x5397f104, Offset: 0x79b8
// Size: 0x4b0
function use_hold_think(player, disableweaponcyclingduringhold) {
    player notify(#"use_hold");
    if (!(isdefined(self.dontlinkplayertotrigger) && self.dontlinkplayertotrigger)) {
        if (!sessionmodeismultiplayergame()) {
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
        player giveweapon(useweapon);
        player setweaponammostock(useweapon, 0);
        player setweaponammoclip(useweapon, 0);
        player switchtoweapon(useweapon);
    } else if (self.keepweapon !== 1) {
        player util::_disableweapon();
    }
    self clear_progress();
    self.inuse = 1;
    self.userate = 0;
    objective_setplayerusing(self.objectiveid, player);
    if (disableweaponcyclingduringhold) {
        player disableweaponcycling();
        enableweaponcyclingafterhold = 1;
    }
    result = use_hold_think_loop(player);
    self.inuse = 0;
    if (isdefined(player)) {
        if (enableweaponcyclingafterhold === 1) {
            player enableweaponcycling();
        }
        objective_clearplayerusing(self.objectiveid, player);
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
            player util::_enableweapon();
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
// Checksum 0x2d0f602d, Offset: 0x7e70
// Size: 0x7c
function waitthenfreezeplayercontrolsifgameendedstill(wait_time) {
    if (!isdefined(wait_time)) {
        wait_time = 1;
    }
    player = self;
    wait wait_time;
    if (isdefined(player) && level.gameended) {
        player val::set("gameobjects_gameended", "freezecontrols", 1);
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xc7aa0f96, Offset: 0x7ef8
// Size: 0x8c
function take_use_weapon(useweapon) {
    self endon(#"use_hold");
    self endon(#"death");
    self endon(#"disconnect");
    level endon(#"game_ended");
    while (self getcurrentweapon() == useweapon && !self.throwinggrenade) {
        waitframe(1);
    }
    self takeweapon(useweapon);
}

// Namespace gameobjects/gameobjects_shared
// Params 4, eflags: 0x0
// Checksum 0x63833013, Offset: 0x7f90
// Size: 0x21a
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
    if (player.throwinggrenade) {
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
    if (!player istouching(self.trigger)) {
        if (!isdefined(player.cursorhintent) || player.cursorhintent != self) {
            return false;
        }
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
// Checksum 0x5b7813cd, Offset: 0x81b8
// Size: 0xa4
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
// Checksum 0x78c1d2af, Offset: 0x8268
// Size: 0x202
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
            self.curprogress += 50 * self.userate * playerusemultiplier;
            self update_current_progress();
            self.userate = 1;
            waitforweapon = 0;
        } else {
            self.userate = 0;
        }
        if (sessionmodeismultiplayergame()) {
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
// Checksum 0x6d340fcd, Offset: 0x8478
// Size: 0x1fc
function update_trigger() {
    if (self.triggertype != "use") {
        return;
    }
    if (isdefined(self.absolute_visible_and_interact_team)) {
        self.trigger triggerenable(1);
        self.trigger setteamfortrigger(self.absolute_visible_and_interact_team);
        return;
    }
    if (self.interactteam == "none") {
        self.trigger triggerenable(0);
        return;
    }
    if (self.interactteam == "any" || !level.teambased) {
        self.trigger triggerenable(1);
        self.trigger setteamfortrigger("none");
        return;
    }
    if (self.interactteam == "friendly") {
        self.trigger triggerenable(1);
        if (isdefined(level.teams[self.ownerteam])) {
            self.trigger setteamfortrigger(self.ownerteam);
        } else {
            self.trigger triggerenable(0);
        }
        return;
    }
    if (self.interactteam == "enemy") {
        self.trigger triggerenable(1);
        self.trigger setexcludeteamfortrigger(self.ownerteam);
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0xb4ea8d69, Offset: 0x8680
// Size: 0x3d4
function update_objective() {
    if (self.type === "GenericObject") {
        return;
    }
    objective_setteam(self.objectiveid, self.ownerteam);
    if (isdefined(self.absolute_visible_and_interact_team) && self.visibleteam != "none") {
        objective_setstate(self.objectiveid, "active");
        objective_visibleteams(self.objectiveid, level.spawnsystem.ispawn_teammask[self.absolute_visible_and_interact_team]);
    } else if (self.visibleteam == "any") {
        objective_setstate(self.objectiveid, "active");
        objective_visibleteams(self.objectiveid, level.spawnsystem.ispawn_teammask["all"]);
    } else if (self.visibleteam == "friendly") {
        objective_setstate(self.objectiveid, "active");
        objective_visibleteams(self.objectiveid, level.spawnsystem.ispawn_teammask[self.ownerteam]);
    } else if (self.visibleteam == "enemy") {
        objective_setstate(self.objectiveid, "active");
        objective_visibleteams(self.objectiveid, level.spawnsystem.ispawn_teammask["all"] & ~level.spawnsystem.ispawn_teammask[self.ownerteam]);
    } else {
        objective_setstate(self.objectiveid, "invisible");
        objective_visibleteams(self.objectiveid, 0);
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
// Checksum 0xdf199b26, Offset: 0x8a60
// Size: 0x8c
function hide_waypoint(e_player) {
    if (isdefined(e_player)) {
        assert(isplayer(e_player), "<dev string:x8b>");
        objective_setinvisibletoplayer(self.objectiveid, e_player);
        return;
    }
    objective_setinvisibletoall(self.objectiveid);
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x24636303, Offset: 0x8af8
// Size: 0x8c
function show_waypoint(e_player) {
    if (isdefined(e_player)) {
        assert(isplayer(e_player), "<dev string:x8b>");
        objective_setvisibletoplayer(self.objectiveid, e_player);
        return;
    }
    objective_setvisibletoall(self.objectiveid);
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xd6cae329, Offset: 0x8b90
// Size: 0x5a
function should_ping_object(relativeteam) {
    if (relativeteam == "friendly" && self.objidpingfriendly) {
        return true;
    } else if (relativeteam == "enemy" && self.objidpingenemy) {
        return true;
    }
    return false;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x283199b, Offset: 0x8bf8
// Size: 0x1d8
function get_update_teams(relativeteam) {
    updateteams = [];
    if (level.teambased) {
        if (relativeteam == "friendly") {
            foreach (team in level.teams) {
                if (self is_friendly_team(team)) {
                    updateteams[updateteams.size] = team;
                }
            }
        } else if (relativeteam == "enemy") {
            foreach (team in level.teams) {
                if (!self is_friendly_team(team)) {
                    updateteams[updateteams.size] = team;
                }
            }
        }
    } else if (relativeteam == "friendly") {
        updateteams[updateteams.size] = level.nonteambasedteam;
    } else {
        updateteams[updateteams.size] = "axis";
    }
    return updateteams;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xa013eb4b, Offset: 0x8dd8
// Size: 0xa4
function should_show_compass_due_to_radar(team) {
    showcompass = 0;
    if (!isdefined(self.carrier)) {
        return 0;
    }
    if (self.carrier hasperk("specialty_gpsjammer") == 0) {
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
// Checksum 0x5325040c, Offset: 0x8e88
// Size: 0xc2
function private _set_team(team) {
    self.ownerteam = team;
    if (team != "any") {
        self.team = team;
        foreach (visual in self.visuals) {
            visual.team = team;
        }
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x4ec2fc32, Offset: 0x8f58
// Size: 0x8c
function set_owner_team(str_team) {
    if (str_team == "any") {
        str_team = "none";
    }
    str_team = util::get_team_mapping(str_team);
    self _set_team(str_team);
    self update_trigger();
    self function_983a9443();
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x79ebd5d3, Offset: 0x8ff0
// Size: 0xe
function get_owner_team() {
    return self.ownerteam;
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x6ed3ce27, Offset: 0x9008
// Size: 0xc4
function flip_owner_team() {
    str_team = get_owner_team();
    b_trigger_enabled = self.trigger istriggerenabled();
    if (str_team === "allies") {
        self set_owner_team("axis");
    } else if (str_team === "axis") {
        self set_owner_team("allies");
    }
    self.trigger triggerenable(b_trigger_enabled);
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x5c0a0c4a, Offset: 0x90d8
// Size: 0x3c
function flip_owner_team_on_all_gameobjects() {
    if (isdefined(level.a_gameobjects)) {
        array::thread_all(level.a_gameobjects, &flip_owner_team);
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x2c2aaebe, Offset: 0x9120
// Size: 0x34
function set_decay_time(time) {
    self.decaytime = int(time * 1000);
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xc2bd138b, Offset: 0x9160
// Size: 0x34
function set_use_time(time) {
    self.usetime = int(time * 1000);
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x346eb568, Offset: 0x91a0
// Size: 0x1c
function set_use_text(text) {
    self.usetext = text;
}

// Namespace gameobjects/gameobjects_shared
// Params 2, eflags: 0x0
// Checksum 0x8be8d250, Offset: 0x91c8
// Size: 0x42
function set_team_use_time(relativeteam, time) {
    self.teamusetimes[relativeteam] = int(time * 1000);
}

// Namespace gameobjects/gameobjects_shared
// Params 2, eflags: 0x0
// Checksum 0x37881d34, Offset: 0x9218
// Size: 0x2a
function set_team_use_text(relativeteam, text) {
    self.teamusetexts[relativeteam] = text;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xe676778, Offset: 0x9250
// Size: 0x2c
function set_use_hint_text(text) {
    self.trigger sethintstring(text);
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x68eddb89, Offset: 0x9288
// Size: 0x24
function allow_carry(relativeteam) {
    allow_use(relativeteam);
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xd6586948, Offset: 0x92b8
// Size: 0x2c
function allow_use(relativeteam) {
    self.interactteam = relativeteam;
    update_trigger();
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x528ccc57, Offset: 0x92f0
// Size: 0x64
function set_visible_team(relativeteam) {
    self.visibleteam = relativeteam;
    if (!tweakables::gettweakablevalue("hud", "showobjicons")) {
        self.visibleteam = "none";
    }
    function_983a9443();
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x3d18214, Offset: 0x9360
// Size: 0x1b6
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
// Checksum 0xdfa1e0f6, Offset: 0x9520
// Size: 0xca
function make_solid() {
    self endon(#"death");
    self notify(#"changing_solidness");
    self endon(#"changing_solidness");
    while (true) {
        for (i = 0; i < level.players.size; i++) {
            if (level.players[i] istouching(self)) {
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
// Checksum 0xc27ac4f5, Offset: 0x95f8
// Size: 0x1c
function set_carrier_visible(relativeteam) {
    self.carriervisible = relativeteam;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x2d2f7594, Offset: 0x9620
// Size: 0x1c
function set_can_use(relativeteam) {
    self.useteam = relativeteam;
}

// Namespace gameobjects/gameobjects_shared
// Params 2, eflags: 0x0
// Checksum 0x8400ae6c, Offset: 0x9648
// Size: 0x2a
function set_2d_icon(relativeteam, shader) {
    self.compassicons[relativeteam] = shader;
}

// Namespace gameobjects/gameobjects_shared
// Params 2, eflags: 0x0
// Checksum 0x8281e465, Offset: 0x9680
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
// Params 3, eflags: 0x0
// Checksum 0x6455ad1b, Offset: 0x96e8
// Size: 0x6c
function function_73ca9fb7(relativeteam, v_color, alpha) {
    if (!isdefined(alpha)) {
        alpha = 1;
    }
    objective_setcolor(self.objectiveid, v_color[0], v_color[1], v_color[2], alpha);
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x4c5d5807, Offset: 0x9760
// Size: 0x3c
function set_objective_entity(entity) {
    if (isdefined(self.objectiveid)) {
        objective_onentity(self.objectiveid, entity);
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x73829e76, Offset: 0x97a8
// Size: 0x84
function get_objective_ids(str_team) {
    a_objective_ids = [];
    if (!isdefined(a_objective_ids)) {
        a_objective_ids = [];
    } else if (!isarray(a_objective_ids)) {
        a_objective_ids = array(a_objective_ids);
    }
    a_objective_ids[a_objective_ids.size] = self.objectiveid;
    return a_objective_ids;
}

// Namespace gameobjects/gameobjects_shared
// Params 5, eflags: 0x0
// Checksum 0xf9cc8ab3, Offset: 0x9838
// Size: 0x240
function gameobject_is_player_looking_at(origin, dot, do_trace, ignore_ent, ignore_trace_distance) {
    assert(isplayer(self), "<dev string:xc8>");
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
            if (trace["position"] == origin) {
                return true;
            } else if (isdefined(ignore_trace_distance)) {
                n_mag = distance(origin, eye);
                n_dist = distance(trace["position"], eye);
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
// Checksum 0xd4c27946, Offset: 0x9a80
// Size: 0x19c
function hide_icons(team) {
    if (self.visibleteam == "any" || self.visibleteam == "friendly") {
        hide_friendly = 1;
    } else {
        hide_friendly = 0;
    }
    if (self.visibleteam == "any" || self.visibleteam == "enemy") {
        hide_enemy = 1;
    } else {
        hide_enemy = 0;
    }
    self.hidden_compassicon = [];
    self.hidden_worldicon = [];
    if (hide_friendly == 1) {
        self.hidden_compassicon["friendly"] = self.compassicons["friendly"];
        self.hidden_worldicon["friendly"] = self.worldicons["friendly"];
    }
    if (hide_enemy == 1) {
        self.hidden_compassicon["enemy"] = self.compassicons["enemyy"];
        self.hidden_worldicon["enemy"] = self.worldicons["enemy"];
    }
    self set_2d_icon(team, undefined);
    self set_3d_icon(team, undefined);
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xcadcfa2a, Offset: 0x9c28
// Size: 0x8c
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
// Checksum 0x3dd9859e, Offset: 0x9cc0
// Size: 0x2a
function set_3d_use_icon(relativeteam, shader) {
    self.worlduseicons[relativeteam] = shader;
}

// Namespace gameobjects/gameobjects_shared
// Params 2, eflags: 0x0
// Checksum 0x959379a6, Offset: 0x9cf8
// Size: 0x2a
function set_3d_is_waypoint(relativeteam, waypoint) {
    self.worldiswaypoint[relativeteam] = waypoint;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x616e4f6b, Offset: 0x9d30
// Size: 0x4c
function set_carry_icon(shader) {
    assert(self.type == "<dev string:xf6>", "<dev string:x102>");
    self.carryicon = shader;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x1abbca01, Offset: 0x9d88
// Size: 0x1c
function set_visible_carrier_model(visiblemodel) {
    self.visiblecarriermodel = visiblemodel;
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x23425c43, Offset: 0x9db0
// Size: 0xe
function get_visible_carrier_model() {
    return self.visiblecarriermodel;
}

// Namespace gameobjects/gameobjects_shared
// Params 3, eflags: 0x0
// Checksum 0xa9c7f601, Offset: 0x9dc8
// Size: 0x1ec
function destroy_object(deletetrigger, forcehide, b_connect_paths) {
    if (!isdefined(b_connect_paths)) {
        b_connect_paths = 0;
    }
    if (!isdefined(forcehide)) {
        forcehide = 1;
    }
    self disable_object(forcehide);
    foreach (visual in self.visuals) {
        if (b_connect_paths) {
            visual connectpaths();
        }
        if (isdefined(visual)) {
            visual ghost();
            visual delete();
        }
    }
    self.trigger notify(#"destroyed");
    if (isdefined(deletetrigger) && deletetrigger) {
        self.trigger delete();
    } else {
        self.trigger triggerenable(1);
    }
    if (isinarray(level.a_gameobjects, self)) {
        arrayremovevalue(level.a_gameobjects, self);
    }
    self notify(#"destroyed_complete");
    self delete();
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xf3dd507b, Offset: 0x9fc0
// Size: 0x174
function disable_object(forcehide) {
    self notify(#"disabled");
    if (isdefined(forcehide) && (self.type == "carryObject" || self.type == "packObject" || forcehide)) {
        if (isdefined(self.carrier)) {
            self.carrier take_object(self);
        }
        for (index = 0; index < self.visuals.size; index++) {
            if (isdefined(self.visuals[index])) {
                self.visuals[index] ghost();
            }
        }
    }
    self.trigger triggerenable(0);
    if (!isdefined(self.str_restore_visible_team_after_disable)) {
        self.str_restore_visible_team_after_disable = self.visibleteam;
    }
    self set_visible_team("none");
    if (isdefined(self.objectiveid)) {
        objective_clearentity(self.objectiveid);
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x2d1c076c, Offset: 0xa140
// Size: 0x174
function enable_object(forceshow) {
    if (isdefined(forceshow) && (self.type == "carryObject" || self.type == "packObject" || forceshow)) {
        for (index = 0; index < self.visuals.size; index++) {
            self.visuals[index] show();
        }
    }
    self.trigger triggerenable(1);
    if (isdefined(self.str_restore_visible_team_after_disable)) {
        self set_visible_team(self.str_restore_visible_team_after_disable);
        self.str_restore_visible_team_after_disable = undefined;
    } else if (isdefined(self.visibleteam)) {
        self set_visible_team(self.visibleteam);
    } else {
        self set_visible_team("any");
    }
    if (isdefined(self.objectiveid)) {
        objective_onentity(self.objectiveid, self);
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x247a82ca, Offset: 0xa2c0
// Size: 0x9c
function get_relative_team(str_team) {
    str_team = util::get_team_mapping(str_team);
    if (self.ownerteam == "any") {
        return "friendly";
    }
    if (str_team == self.ownerteam) {
        return "friendly";
    }
    if (str_team == get_enemy_team(self.ownerteam)) {
        return "enemy";
    }
    return "neutral";
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x8b592c6a, Offset: 0xa368
// Size: 0x74
function is_friendly_team(str_team) {
    str_team = util::get_team_mapping(str_team);
    if (!level.teambased) {
        return true;
    }
    if (self.ownerteam == "any") {
        return true;
    }
    if (self.ownerteam == str_team) {
        return true;
    }
    return false;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xdb94b4d0, Offset: 0xa3e8
// Size: 0x256
function can_interact_with(player) {
    if (isdefined(level.vehicle_map) && level.vehicle_map) {
        if (!(isdefined(player.usingvehicle) && player.usingvehicle)) {
            return false;
        }
    }
    if (isdefined(self.ignore_use_time)) {
        ignore_time = self.ignore_use_time[player getentitynumber()];
        if (isdefined(ignore_time)) {
            if (level.time < ignore_time) {
                return false;
            } else {
                self.ignore_use_time[player getentitynumber()] = undefined;
            }
        }
    }
    team = player.pers["team"];
    if (isdefined(self.absolute_visible_and_interact_team)) {
        if (team == self.absolute_visible_and_interact_team) {
            return true;
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
        } else if (player == self.ownerteam) {
            return true;
        } else {
            return false;
        }
    case #"enemy":
        if (level.teambased) {
            if (team != self.ownerteam) {
                return true;
            } else if (!isdefined(self.decayprogressmin) || isdefined(self.decayprogress) && self.decayprogress && self.curprogress > 0 && self.curprogress > self.decayprogressmin) {
                return true;
            } else {
                return false;
            }
        } else if (player != self.ownerteam) {
            return true;
        } else {
            return false;
        }
    default:
        assert(0, "<dev string:x130>");
        return false;
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xe5dc49e8, Offset: 0xa678
// Size: 0x7a
function is_team(str_team) {
    str_team = util::get_team_mapping(str_team);
    switch (str_team) {
    case #"any":
    case #"neutral":
    case #"none":
        return true;
    }
    if (isdefined(level.teams[str_team])) {
        return true;
    }
    return false;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x3c5ec604, Offset: 0xa700
// Size: 0x56
function is_relative_team(relativeteam) {
    switch (relativeteam) {
    case #"any":
    case #"enemy":
    case #"friendly":
    case #"none":
        return 1;
    default:
        return 0;
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x77e88df, Offset: 0xa760
// Size: 0x76
function get_enemy_team(str_team) {
    str_team = util::get_team_mapping(str_team);
    switch (str_team) {
    case #"neutral":
        return "none";
    case #"allies":
        return "axis";
    default:
        return "allies";
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x4642a756, Offset: 0xa7e0
// Size: 0x74
function set_absolute_visible_and_interact_team(str_team) {
    str_team = util::get_team_mapping(str_team);
    assert(str_team == "<dev string:x145>" || str_team == "<dev string:x14c>", "<dev string:x151>");
    self.absolute_visible_and_interact_team = str_team;
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0xdf025279, Offset: 0xa860
// Size: 0xd8
function get_next_obj_id() {
    nextid = 0;
    if (level.releasedobjectives.size > 0) {
        nextid = level.releasedobjectives[level.releasedobjectives.size - 1];
        level.releasedobjectives[level.releasedobjectives.size - 1] = undefined;
    } else {
        nextid = level.numgametypereservedobjectives;
        level.numgametypereservedobjectives++;
    }
    /#
        if (nextid >= 128) {
            println("<dev string:x183>");
        }
    #/
    if (nextid > 127) {
        nextid = 127;
    }
    return nextid;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x7751b664, Offset: 0xa940
// Size: 0x124
function release_obj_id(objid) {
    assert(objid < level.numgametypereservedobjectives);
    for (i = 0; i < level.releasedobjectives.size; i++) {
        if (objid == level.releasedobjectives[i] && objid == 127) {
            return;
        }
        assert(objid != level.releasedobjectives[i]);
    }
    level.releasedobjectives[level.releasedobjectives.size] = objid;
    objective_setcolor(objid, 1, 1, 1, 1);
    objective_setstate(objid, "empty");
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x7d7daf6b, Offset: 0xaa70
// Size: 0xb4
function release_all_objective_ids() {
    if (isdefined(self.objid)) {
        a_keys = getarraykeys(self.objid);
        for (i = 0; i < a_keys.size; i++) {
            release_obj_id(self.objid[a_keys[i]]);
        }
    }
    if (isdefined(self.objectiveid)) {
        release_obj_id(self.objectiveid);
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0x4947521e, Offset: 0xab30
// Size: 0x6a
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
// Checksum 0xf2674d24, Offset: 0xaba8
// Size: 0x1c
function must_maintain_claim(enabled) {
    self.mustmaintainclaim = enabled;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x1e39e348, Offset: 0xabd0
// Size: 0x1c
function can_contest_claim(enabled) {
    self.cancontestclaim = enabled;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x8e5d1ad5, Offset: 0xabf8
// Size: 0x2c
function set_flags(flags) {
    objective_setgamemodeflags(self.objectiveid, flags);
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x91dddff1, Offset: 0xac30
// Size: 0x22
function get_flags(flags) {
    return objective_getgamemodeflags(self.objectiveid);
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xd8e442ae, Offset: 0xac60
// Size: 0x1c
function set_identifier(identifier) {
    self.identifier = identifier;
}

// Namespace gameobjects/gameobjects_shared
// Params 0, eflags: 0x0
// Checksum 0xddb449a5, Offset: 0xac88
// Size: 0xe
function get_identifier() {
    return self.identifier;
}

// Namespace gameobjects/gameobjects_shared
// Params 7, eflags: 0x0
// Checksum 0x26ad2cbe, Offset: 0xaca0
// Size: 0x63c
function create_pack_object(ownerteam, trigger, visuals, offset, objectivename, allowinitialholddelay, allowweaponcyclingduringhold) {
    if (!isdefined(allowinitialholddelay)) {
        allowinitialholddelay = 0;
    }
    if (!isdefined(allowweaponcyclingduringhold)) {
        allowweaponcyclingduringhold = 0;
    }
    if (!isdefined(level.max_packobjects)) {
        level.max_packobjects = 4;
    }
    assert(level.max_packobjects < 5, "<dev string:x1ae>");
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
            iprintln("<dev string:x1f5>");
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
    packobject.objid = [];
    packobject.objidpingfriendly = 0;
    packobject.objidpingenemy = 0;
    level.objidstart += 2;
    packobject.objectiveid = get_next_obj_id();
    objective_add(packobject.objectiveid, "invisible", packobject.curorigin, objectivename);
    packobject.carrier = undefined;
    packobject.isresetting = 0;
    packobject.interactteam = "none";
    packobject.allowweapons = 1;
    packobject.visiblecarriermodel = undefined;
    packobject.dropoffset = 0;
    packobject.worldicons = [];
    packobject.carriervisible = 0;
    packobject.visibleteam = "none";
    packobject.worldiswaypoint = [];
    packobject.worldicons_disabled = [];
    packobject.packicon = undefined;
    packobject.setdropped = undefined;
    packobject.ondrop = undefined;
    packobject.onpickup = undefined;
    packobject.onreset = undefined;
    packobject.usetime = 10000;
    packobject.decayprogress = 0;
    if (packobject.triggertype == "use") {
        packobject.trigger setcursorhint("HINT_INTERACTIVE_PROMPT");
        packobject.userate = 1;
        packobject thread use_object_use_think(!allowinitialholddelay, !allowweaponcyclingduringhold);
    } else {
        packobject setup_touching();
        packobject.curprogress = 0;
        packobject.userate = 0;
        packobject.claimteam = "none";
        packobject.claimplayer = undefined;
        packobject.lastclaimteam = "none";
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
// Checksum 0xd9074baa, Offset: 0xb2e8
// Size: 0x44
function give_pack_object(object) {
    self.packobject[self.packobject.size] = object;
    self thread track_carrier(object);
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xff08153e, Offset: 0xb338
// Size: 0x94
function get_packicon_offset(index) {
    if (!isdefined(index)) {
        index = 0;
    }
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
// Checksum 0x59211b93, Offset: 0xb3d8
// Size: 0x86
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
// Checksum 0x5c4afc81, Offset: 0xb468
// Size: 0x4c
function set_pack_icon(shader) {
    assert(self.type == "<dev string:x224>", "<dev string:x22f>");
    self.packicon = shader;
}

// Namespace gameobjects/gameobjects_shared
// Params 8, eflags: 0x0
// Checksum 0x864d63c, Offset: 0xb4c0
// Size: 0x124
function init_game_objects(str_gameobject_bundle, str_team_override, b_allow_companion_command, t_override, a_keyline_objects, str_objective_override, str_tag_override, str_identifier_override) {
    c_interact_obj = new cinteractobj();
    c_interact_obj.e_object = self;
    str_bundle = undefined;
    if (isdefined(str_gameobject_bundle)) {
        str_bundle = str_gameobject_bundle;
    } else if (self.classname === "scriptbundle_gameobject") {
        str_bundle = self.scriptbundlename;
    }
    assert(isdefined(str_bundle), "<dev string:x25f>" + self.origin);
    [[ c_interact_obj ]]->init_game_object(str_bundle, str_team_override, str_tag_override, str_identifier_override, a_keyline_objects, t_override, b_allow_companion_command);
    return c_interact_obj;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x3aa78784, Offset: 0xc578
// Size: 0x1c
function assign_class_object(o_class) {
    self.classobj = o_class;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x42c79180, Offset: 0xc5a0
// Size: 0x1c
function set_onbeginuse_event(func) {
    self.onbeginuse = func;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xdb52d883, Offset: 0xc5c8
// Size: 0x1c
function set_onuse_event(func) {
    self.onuse = func;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xc7ee1bf2, Offset: 0xc5f0
// Size: 0x1c
function set_onenduse_event(func) {
    self.onenduse = func;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x9743d2f1, Offset: 0xc618
// Size: 0x1c
function set_onpickup_event(func) {
    self.onpickup = func;
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0xaf296216, Offset: 0xc640
// Size: 0x31c
function play_interact_anim(e_player) {
    if (isdefined(self.str_player_scene_anim)) {
        str_player_scene = self.str_player_scene_anim;
        if (isdefined(self.b_use_gameobject_for_alignment) && self.b_use_gameobject_for_alignment) {
            e_align = self.e_object;
        } else {
            e_align = level;
        }
        a_ents["Player 1"] = e_player;
        e_align thread scene::play(str_player_scene, a_ents);
        waitframe(1);
        if (isdefined(self.b_scene_use_time_override) && isdefined(self) && isdefined(e_player.str_current_anim) && self.b_scene_use_time_override) {
            self set_use_time(getanimlength(e_player.str_current_anim));
        }
        while (isdefined(self) && isdefined(self.e_object) && e_player usebuttonpressed() && !self.e_object flag::get("gameobject_end_use")) {
            waitframe(1);
        }
        e_align thread scene::stop(str_player_scene);
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
        while (isdefined(self) && e_player usebuttonpressed() && !self.e_object flag::get("gameobject_end_use")) {
            waitframe(1);
        }
        if (e_player.str_current_anim === str_anim) {
            e_player thread animation::stop();
        }
    }
}

// Namespace gameobjects/gameobjects_shared
// Params 1, eflags: 0x0
// Checksum 0x1af49442, Offset: 0xc968
// Size: 0x5c
function anchor_delete_watcher(mdl_anchor) {
    self.e_object waittill("gameobject_end_use", "gameobject_abort");
    util::wait_network_frame();
    if (isdefined(mdl_anchor)) {
        mdl_anchor delete();
    }
}

