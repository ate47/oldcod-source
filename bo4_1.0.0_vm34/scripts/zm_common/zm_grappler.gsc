#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\zm_utility;

#namespace zm_grappler;

// Namespace zm_grappler/zm_grappler
// Params 0, eflags: 0x2
// Checksum 0xa2e7b440, Offset: 0x110
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_grappler", &__init__, &__main__, undefined);
}

// Namespace zm_grappler/zm_grappler
// Params 0, eflags: 0x0
// Checksum 0x972275ab, Offset: 0x160
// Size: 0xcc
function __init__() {
    clientfield::register("scriptmover", "grappler_beam_source", 1, getminbitcountfornum(5), "int");
    clientfield::register("scriptmover", "grappler_beam_target", 1, getminbitcountfornum(5), "int");
    level.grapple_ids = [];
    for (id = 1; id < 5; id++) {
        level.grapple_ids[id] = 0;
    }
}

// Namespace zm_grappler/zm_grappler
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x238
// Size: 0x4
function __main__() {
    
}

// Namespace zm_grappler/zm_grappler
// Params 0, eflags: 0x4
// Checksum 0x3d652fde, Offset: 0x248
// Size: 0x92
function private function_c4b36e17() {
    foreach (key, value in level.grapple_ids) {
        if (value === 0) {
            level.grapple_ids[key] = 1;
            return key;
        }
    }
    return undefined;
}

// Namespace zm_grappler/zm_grappler
// Params 0, eflags: 0x0
// Checksum 0xf279e962, Offset: 0x2e8
// Size: 0x7c
function function_86ba73d5() {
    foreach (value in level.grapple_ids) {
        if (value === 0) {
            return false;
        }
    }
    return true;
}

// Namespace zm_grappler/zm_grappler
// Params 1, eflags: 0x4
// Checksum 0xbe7c23f2, Offset: 0x370
// Size: 0x62
function private function_2ea39ae8(id) {
    assert(isdefined(level.grapple_ids[id]) && level.grapple_ids[id] === 1);
    level.grapple_ids[id] = 0;
}

// Namespace zm_grappler/zm_grappler
// Params 4, eflags: 0x0
// Checksum 0xcfcd6f44, Offset: 0x3e0
// Size: 0x3ac
function start_grapple(var_683c052c, e_grapplee, n_type, n_speed = 1800) {
    assert(n_type == 2);
    e_source = create_mover(var_683c052c function_1e702195(), var_683c052c.angles);
    e_beamend = create_mover(var_683c052c function_1e702195(), var_683c052c.angles * -1);
    thread function_28ac2916(e_source, e_beamend);
    if (isdefined(e_beamend)) {
        e_grapplee function_63b4b8a5(1, 1);
        util::wait_network_frame();
        n_time = function_3e1b1cea(var_683c052c, e_grapplee, n_speed);
        e_beamend.origin = var_683c052c function_1e702195();
        var_c35f0f99 = e_grapplee function_1e702195();
        e_beamend playsound(#"zmb_grapple_start");
        e_beamend moveto(var_c35f0f99, n_time);
        e_beamend waittill(#"movedone");
        var_8986f6e8 = var_c35f0f99 - e_grapplee.origin;
        e_beamend.origin = e_grapplee.origin;
        if (isplayer(e_grapplee)) {
            e_grapplee playerlinkto(e_beamend, "tag_origin");
        } else {
            e_grapplee linkto(e_beamend);
        }
        e_grapplee playsound(#"zmb_grapple_grab");
        var_de84fe14 = var_683c052c function_1e702195() - var_8986f6e8;
        e_beamend moveto(var_de84fe14, n_time);
        e_beamend playsound(#"zmb_grapple_pull");
        e_beamend waittill(#"movedone");
        function_b7c692b0();
        e_beamend clientfield::set("grappler_beam_target", 0);
        e_grapplee unlink();
        e_grapplee function_63b4b8a5(0, 1);
        util::wait_network_frame();
        destroy_mover(e_beamend);
        destroy_mover(e_source);
    }
}

// Namespace zm_grappler/zm_grappler
// Params 0, eflags: 0x0
// Checksum 0xf5eeecb3, Offset: 0x798
// Size: 0x2e
function function_b7c692b0() {
    while (isdefined(level.var_5b94112c) && level.var_5b94112c) {
        waitframe(1);
    }
}

// Namespace zm_grappler/zm_grappler
// Params 3, eflags: 0x4
// Checksum 0x8c063b4e, Offset: 0x7d0
// Size: 0xac
function private function_be44ad06(e_source, e_target, id) {
    util::waittill_any_ents_two(e_source, "death", e_target, "death");
    if (isdefined(e_source)) {
        e_source waittill(#"death");
    } else if (isdefined(e_target)) {
        e_target waittill(#"death");
    }
    util::wait_network_frame();
    function_2ea39ae8(id);
}

// Namespace zm_grappler/zm_grappler
// Params 2, eflags: 0x0
// Checksum 0x6a1b821f, Offset: 0x888
// Size: 0xea
function function_28ac2916(e_source, e_target) {
    function_b7c692b0();
    level.var_5b94112c = 1;
    grapple_id = function_c4b36e17();
    if (isdefined(e_source)) {
        e_source clientfield::set("grappler_beam_source", grapple_id);
    }
    util::wait_network_frame();
    if (isdefined(e_target)) {
        e_target clientfield::set("grappler_beam_target", grapple_id);
    }
    thread function_be44ad06(e_source, e_target, grapple_id);
    util::wait_network_frame();
    level.var_5b94112c = 0;
}

// Namespace zm_grappler/zm_grappler
// Params 3, eflags: 0x4
// Checksum 0xeb771eb0, Offset: 0x980
// Size: 0x68
function private function_3e1b1cea(e_from, e_to, n_speed) {
    n_distance = distance(e_from function_1e702195(), e_to function_1e702195());
    return n_distance / n_speed;
}

// Namespace zm_grappler/zm_grappler
// Params 2, eflags: 0x0
// Checksum 0x3ab70cf2, Offset: 0x9f0
// Size: 0x194
function function_63b4b8a5(var_365c612, var_47ec1c40) {
    if (!isdefined(self)) {
        return;
    }
    if (var_365c612 != (isdefined(self.var_14f171d3) && self.var_14f171d3)) {
        if (isdefined(var_365c612) && var_365c612) {
            self notify(#"hash_3219c34bb024ffb7");
        } else {
            self notify(#"hash_5d85f16cb4fd5a32");
        }
        self.var_14f171d3 = var_365c612;
        if (isplayer(self)) {
            self freezecontrols(var_365c612);
            self setplayercollision(!var_365c612);
            if (var_365c612) {
                self val::set(#"zm_grappler", "ignoreme");
                if (isdefined(var_47ec1c40) && var_47ec1c40) {
                    self.var_61f01d73 = self enableinvulnerability();
                }
                return;
            }
            self val::reset(#"zm_grappler", "ignoreme");
            if (!(isdefined(self.var_61f01d73) && self.var_61f01d73) && isdefined(var_47ec1c40) && var_47ec1c40) {
                self disableinvulnerability();
            }
        }
    }
}

// Namespace zm_grappler/zm_grappler
// Params 0, eflags: 0x0
// Checksum 0xd09f7bdf, Offset: 0xb90
// Size: 0x42
function function_1e702195() {
    if (isdefined(self.grapple_tag)) {
        v_origin = self gettagorigin(self.grapple_tag);
        return v_origin;
    }
    return self.origin;
}

// Namespace zm_grappler/zm_grappler
// Params 2, eflags: 0x0
// Checksum 0xdd5fa0cc, Offset: 0xbe0
// Size: 0x52
function create_mover(v_origin, v_angles) {
    model = "tag_origin";
    e_ent = util::spawn_model(model, v_origin, v_angles);
    return e_ent;
}

// Namespace zm_grappler/zm_grappler
// Params 1, eflags: 0x0
// Checksum 0xebb968e, Offset: 0xc40
// Size: 0x2c
function destroy_mover(e_beamend) {
    if (isdefined(e_beamend)) {
        e_beamend delete();
    }
}

