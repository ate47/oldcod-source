#using scripts/core_common/callbacks_shared;
#using scripts/core_common/exploder_shared;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace fx;

// Namespace fx/fx_shared
// Params 0, eflags: 0x2
// Checksum 0x3573783a, Offset: 0x170
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("fx", &__init__, undefined, undefined);
}

// Namespace fx/fx_shared
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x1b0
// Size: 0x4
function __init__() {
    
}

// Namespace fx/fx_shared
// Params 0, eflags: 0x0
// Checksum 0xecc482eb, Offset: 0x1c0
// Size: 0x76
function set_forward_and_up_vectors() {
    self.v["up"] = anglestoup(self.v["angles"]);
    self.v["forward"] = anglestoforward(self.v["angles"]);
}

// Namespace fx/fx_shared
// Params 1, eflags: 0x0
// Checksum 0x5a8bb7d5, Offset: 0x240
// Size: 0x5c
function get(fx) {
    /#
        assert(isdefined(level._effect[fx]), "<dev string:x28>" + fx + "<dev string:x2c>");
    #/
    return level._effect[fx];
}

// Namespace fx/fx_shared
// Params 2, eflags: 0x0
// Checksum 0xdae83d69, Offset: 0x2a8
// Size: 0x15c
function create_effect(type, fxid) {
    ent = undefined;
    if (!isdefined(level.createfxent)) {
        level.createfxent = [];
    }
    if (type == "exploder") {
        ent = spawnstruct();
    } else {
        if (!isdefined(level._fake_createfx_struct)) {
            level._fake_createfx_struct = spawnstruct();
        }
        ent = level._fake_createfx_struct;
    }
    level.createfxent[level.createfxent.size] = ent;
    ent.v = [];
    ent.v["type"] = type;
    ent.v["fxid"] = fxid;
    ent.v["angles"] = (0, 0, 0);
    ent.v["origin"] = (0, 0, 0);
    ent.drawn = 1;
    return ent;
}

// Namespace fx/fx_shared
// Params 1, eflags: 0x0
// Checksum 0xf983f462, Offset: 0x410
// Size: 0x5a
function create_loop_effect(fxid) {
    ent = create_effect("loopfx", fxid);
    ent.v["delay"] = 0.5;
    return ent;
}

// Namespace fx/fx_shared
// Params 1, eflags: 0x0
// Checksum 0x5af0e99c, Offset: 0x478
// Size: 0x56
function create_oneshot_effect(fxid) {
    ent = create_effect("oneshotfx", fxid);
    ent.v["delay"] = -15;
    return ent;
}

// Namespace fx/fx_shared
// Params 8, eflags: 0x0
// Checksum 0xe0b577b5, Offset: 0x4d8
// Size: 0x294
function play(str_fx, v_origin, v_angles, time_to_delete_or_notify, b_link_to_self, str_tag, b_no_cull, b_ignore_pause_world) {
    if (!isdefined(v_origin)) {
        v_origin = (0, 0, 0);
    }
    if (!isdefined(v_angles)) {
        v_angles = (0, 0, 0);
    }
    if (!isdefined(b_link_to_self)) {
        b_link_to_self = 0;
    }
    self notify(str_fx);
    if (isdefined(b_link_to_self) && !isstring(time_to_delete_or_notify) && (!isdefined(time_to_delete_or_notify) || time_to_delete_or_notify == -1) && b_link_to_self && isdefined(str_tag)) {
        playfxontag(get(str_fx), self, str_tag, b_ignore_pause_world);
        return self;
    }
    if (isdefined(time_to_delete_or_notify)) {
        m_fx = util::spawn_model("tag_origin", v_origin, v_angles);
        if (isdefined(b_link_to_self) && b_link_to_self) {
            if (isdefined(str_tag)) {
                m_fx linkto(self, str_tag, (0, 0, 0), (0, 0, 0));
            } else {
                m_fx linkto(self);
            }
        }
        if (isdefined(b_no_cull) && b_no_cull) {
            m_fx setforcenocull();
        }
        playfxontag(get(str_fx), m_fx, "tag_origin", b_ignore_pause_world);
        m_fx thread _play_fx_delete(self, time_to_delete_or_notify);
        return m_fx;
    }
    playfx(get(str_fx), v_origin, anglestoforward(v_angles), anglestoup(v_angles), b_ignore_pause_world);
}

// Namespace fx/fx_shared
// Params 2, eflags: 0x0
// Checksum 0xf42e6c44, Offset: 0x778
// Size: 0xb4
function _play_fx_delete(ent, time_to_delete_or_notify) {
    if (!isdefined(time_to_delete_or_notify)) {
        time_to_delete_or_notify = -1;
    }
    if (isstring(time_to_delete_or_notify)) {
        ent util::waittill_either("death", time_to_delete_or_notify);
    } else if (time_to_delete_or_notify > 0) {
        ent waittilltimeout(time_to_delete_or_notify, "death");
    } else {
        ent waittill("death");
    }
    if (isdefined(self)) {
        self delete();
    }
}
