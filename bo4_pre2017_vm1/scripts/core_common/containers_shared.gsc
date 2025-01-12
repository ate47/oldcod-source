#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/doors_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/scene_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/visionset_mgr_shared;

#namespace ccontainer;

// Namespace ccontainer/containers_shared
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x310
// Size: 0x4
function __constructor() {
    
}

// Namespace ccontainer/containers_shared
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x320
// Size: 0x4
function __destructor() {
    
}

// Namespace ccontainer/containers_shared
// Params 3, eflags: 0x0
// Checksum 0xb3c33fe0, Offset: 0x330
// Size: 0x66
function init_xmodel(str_xmodel, v_origin, v_angles) {
    if (!isdefined(str_xmodel)) {
        str_xmodel = "script_origin";
    }
    self.m_e_container = util::spawn_model(str_xmodel, v_origin, v_angles);
    return self.m_e_container;
}

#namespace containers;

// Namespace containers/containers_shared
// Params 0, eflags: 0x6
// Checksum 0xbfdad90d, Offset: 0x3a0
// Size: 0xb6
function private autoexec ccontainer() {
    classes.ccontainer[0] = spawnstruct();
    classes.ccontainer[0].__vtable[-1234449151] = &ccontainer::init_xmodel;
    classes.ccontainer[0].__vtable[1606033458] = &ccontainer::__destructor;
    classes.ccontainer[0].__vtable[-1690805083] = &ccontainer::__constructor;
}

// Namespace containers/containers_shared
// Params 0, eflags: 0x2
// Checksum 0xf482147e, Offset: 0x460
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("containers", &__init__, undefined, undefined);
}

// Namespace containers/containers_shared
// Params 0, eflags: 0x0
// Checksum 0x34a0b032, Offset: 0x4a0
// Size: 0xda
function __init__() {
    a_containers = struct::get_array("scriptbundle_containers", "classname");
    foreach (s_instance in a_containers) {
        c_container = s_instance init();
        if (isdefined(c_container)) {
            s_instance.c_container = c_container;
        }
    }
}

// Namespace containers/containers_shared
// Params 0, eflags: 0x0
// Checksum 0x65606aae, Offset: 0x588
// Size: 0x6a
function init() {
    if (!isdefined(self.angles)) {
        self.angles = (0, 0, 0);
    }
    s_bundle = struct::get_script_bundle("containers", self.scriptbundlename);
    return setup_container_scriptbundle(s_bundle, self);
}

// Namespace containers/containers_shared
// Params 2, eflags: 0x0
// Checksum 0x6ccbbbb6, Offset: 0x600
// Size: 0xd8
function setup_container_scriptbundle(s_bundle, s_container_instance) {
    [[ new ccontainer ]]->__constructor();
    c_container = <error pop>;
    c_container.m_s_container_bundle = s_bundle;
    c_container.m_s_fxanim_bundle = struct::get_script_bundle("scene", s_bundle.theeffectbundle);
    c_container.m_s_container_instance = s_container_instance;
    self scene::init(s_bundle.theeffectbundle, c_container.m_e_container);
    level thread container_update(c_container);
    return c_container;
}

// Namespace containers/containers_shared
// Params 1, eflags: 0x0
// Checksum 0x49f21f9c, Offset: 0x6e0
// Size: 0x104
function container_update(c_container) {
    e_ent = c_container.m_e_container;
    s_bundle = c_container.m_s_container_bundle;
    targetname = c_container.m_s_container_instance.targetname;
    n_radius = s_bundle.trigger_radius;
    e_trigger = create_locker_trigger(c_container.m_s_container_instance.origin, n_radius, "Press [{+activate}] to open");
    e_trigger waittill("trigger");
    e_trigger delete();
    scene::play(targetname, "targetname");
}

// Namespace containers/containers_shared
// Params 3, eflags: 0x0
// Checksum 0x84031f10, Offset: 0x7f0
// Size: 0x118
function create_locker_trigger(v_pos, n_radius, str_message) {
    v_pos = (v_pos[0], v_pos[1], v_pos[2] + 50);
    e_trig = spawn("trigger_radius_use", v_pos, 0, n_radius, 100);
    e_trig triggerignoreteam();
    e_trig setvisibletoall();
    e_trig setteamfortrigger("none");
    e_trig usetriggerrequirelookat();
    e_trig setcursorhint("HINT_NOICON");
    e_trig sethintstring(str_message);
    return e_trig;
}

// Namespace containers/containers_shared
// Params 4, eflags: 0x0
// Checksum 0xd67ddc5d, Offset: 0x910
// Size: 0x36c
function setup_general_container_bundle(str_targetname, str_intel_vo, str_narrative_collectable_model, force_open) {
    s_struct = struct::get(str_targetname, "targetname");
    if (!isdefined(s_struct)) {
        return;
    }
    level flag::wait_till("all_players_spawned");
    e_trigger = create_locker_trigger(s_struct.origin, 64, "Press [{+activate}] to open");
    if (!isdefined(force_open) || force_open == 0) {
        waitresult = e_trigger waittill("trigger");
        e_who = waitresult.activator;
    } else {
        rand_time = randomfloatrange(1, 1.5);
        wait rand_time;
    }
    e_trigger delete();
    level thread scene::play(str_targetname, "targetname");
    if (isdefined(s_struct.a_entity)) {
        for (i = 0; i < s_struct.a_entity.size; i++) {
            s_struct.a_entity[i] notify(#"opened");
        }
    }
    if (isdefined(str_narrative_collectable_model)) {
        v_pos = s_struct.origin + (0, 0, 30);
        if (!isdefined(s_struct.angles)) {
            v_angles = (0, 0, 0);
        } else {
            v_angles = s_struct.angles;
        }
        v_angles = (v_angles[0], v_angles[1] + 90, v_angles[2]);
        e_collectable = spawn("script_model", v_pos);
        e_collectable setmodel("p7_int_narrative_collectable");
        e_collectable.angles = v_angles;
        wait 1;
        e_trigger = create_locker_trigger(s_struct.origin, 64, "Press [{+activate}] to pickup collectable");
        waitresult = e_trigger waittill("trigger");
        e_who = waitresult.activator;
        e_trigger delete();
        e_collectable delete();
    }
    if (isdefined(str_intel_vo)) {
        e_who playsound(str_intel_vo);
    }
}

// Namespace containers/containers_shared
// Params 3, eflags: 0x0
// Checksum 0x8d0acac7, Offset: 0xc88
// Size: 0x196
function setup_locker_double_doors(str_left_door_name, str_right_door_name, center_point_offset) {
    a_left_doors = getentarray(str_left_door_name, "targetname");
    if (!isdefined(a_left_doors)) {
        return;
    }
    a_right_doors = getentarray(str_right_door_name, "targetname");
    if (!isdefined(a_right_doors)) {
        return;
    }
    for (i = 0; i < a_left_doors.size; i++) {
        e_left_door = a_left_doors[i];
        if (isdefined(center_point_offset)) {
            v_forward = anglestoforward(e_left_door.angles);
            v_search_pos = e_left_door.origin + v_forward * center_point_offset;
        } else {
            v_search_pos = e_left_door.origin;
        }
        e_right_door = get_closest_ent_from_array(v_search_pos, a_right_doors);
        level thread create_locker_doors(e_left_door, e_right_door, 120, 0.4);
    }
}

// Namespace containers/containers_shared
// Params 2, eflags: 0x0
// Checksum 0xe38f9a71, Offset: 0xe28
// Size: 0xc6
function get_closest_ent_from_array(v_pos, a_ents) {
    e_closest = undefined;
    n_closest_dist = 9999999;
    for (i = 0; i < a_ents.size; i++) {
        dist = distance(v_pos, a_ents[i].origin);
        if (dist < n_closest_dist) {
            n_closest_dist = dist;
            e_closest = a_ents[i];
        }
    }
    return e_closest;
}

// Namespace containers/containers_shared
// Params 4, eflags: 0x0
// Checksum 0x5e65a4db, Offset: 0xef8
// Size: 0x1ac
function create_locker_doors(e_left_door, e_right_door, door_open_angle, door_open_time) {
    v_locker_pos = (e_left_door.origin + e_right_door.origin) / 2;
    n_trigger_radius = 48;
    e_trigger = create_locker_trigger(v_locker_pos, n_trigger_radius, "Press [{+activate}] to open");
    e_trigger waittill("trigger");
    e_left_door playsound("evt_cabinet_open");
    v_angle = (e_left_door.angles[0], e_left_door.angles[1] - door_open_angle, e_left_door.angles[2]);
    e_left_door rotateto(v_angle, door_open_time);
    v_angle = (e_right_door.angles[0], e_right_door.angles[1] + door_open_angle, e_right_door.angles[2]);
    e_right_door rotateto(v_angle, door_open_time);
    e_trigger delete();
}

