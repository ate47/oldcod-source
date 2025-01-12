#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;

#namespace serverfaceanim;

// Namespace serverfaceanim/serverfaceanim_shared
// Params 0, eflags: 0x2
// Checksum 0xea3293b3, Offset: 0xb8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"serverfaceanim", &__init__, undefined, undefined);
}

// Namespace serverfaceanim/serverfaceanim_shared
// Params 0, eflags: 0x0
// Checksum 0xcab49a10, Offset: 0x100
// Size: 0x44
function __init__() {
    if (!(isdefined(level._use_faceanim) && level._use_faceanim)) {
        return;
    }
    callback::on_spawned(&init_serverfaceanim);
}

// Namespace serverfaceanim/serverfaceanim_shared
// Params 0, eflags: 0x0
// Checksum 0xe84e38a6, Offset: 0x150
// Size: 0x1d4
function init_serverfaceanim() {
    self.do_face_anims = 1;
    if (!isdefined(level.face_event_handler)) {
        level.face_event_handler = spawnstruct();
        level.face_event_handler.events = [];
        level.face_event_handler.events[#"death"] = "face_death";
        level.face_event_handler.events[#"grenade danger"] = "face_alert";
        level.face_event_handler.events[#"bulletwhizby"] = "face_alert";
        level.face_event_handler.events[#"projectile_impact"] = "face_alert";
        level.face_event_handler.events[#"explode"] = "face_alert";
        level.face_event_handler.events[#"alert"] = "face_alert";
        level.face_event_handler.events[#"shoot"] = "face_shoot_single";
        level.face_event_handler.events[#"melee"] = "face_melee";
        level.face_event_handler.events[#"damage"] = "face_pain";
        level thread wait_for_face_event();
    }
}

// Namespace serverfaceanim/serverfaceanim_shared
// Params 0, eflags: 0x0
// Checksum 0xcd76b57e, Offset: 0x330
// Size: 0xd8
function wait_for_face_event() {
    while (true) {
        waitresult = level waittill(#"face");
        face_notify = waitresult.face_notify;
        ent = waitresult.entity;
        if (isdefined(ent) && isdefined(ent.do_face_anims) && ent.do_face_anims) {
            if (isdefined(level.face_event_handler.events[face_notify])) {
                ent sendfaceevent(level.face_event_handler.events[face_notify]);
            }
        }
    }
}

