#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\mp_common\gametypes\globallogic_audio;
#using scripts\mp_common\load;
#using scripts\mp_common\util;

#namespace load;

// Namespace load/load
// Params 0, eflags: 0x0
// Checksum 0x9cffd0e0, Offset: 0x1d0
// Size: 0x144
function main() {
    assert(isdefined(level.first_frame), "<dev string:x30>");
    level._loadstarted = 1;
    /#
        util::check_art_mode();
    #/
    /#
        util::apply_dev_overrides();
    #/
    setclearanceceiling(30);
    register_clientfields();
    level.aitriggerspawnflags = getaitriggerflags();
    level.vehicletriggerspawnflags = getvehicletriggerflags();
    setup_traversals();
    level.globallogic_audio_dialog_on_player_override = &globallogic_audio::leader_dialog_on_player;
    level.growing_hitmarker = 1;
    system::wait_till("all");
    level flagsys::set(#"load_main_complete");
}

// Namespace load/load
// Params 2, eflags: 0x0
// Checksum 0x454d3fe7, Offset: 0x320
// Size: 0xae
function setfootstepeffect(name, fx) {
    assert(isdefined(name), "<dev string:x5c>");
    assert(isdefined(fx), "<dev string:x86>");
    if (!isdefined(anim.optionalstepeffects)) {
        anim.optionalstepeffects = [];
    }
    anim.optionalstepeffects[anim.optionalstepeffects.size] = name;
    level._effect["step_" + name] = fx;
}

// Namespace load/load
// Params 0, eflags: 0x0
// Checksum 0x1bf5e021, Offset: 0x3d8
// Size: 0x224
function footsteps() {
    setfootstepeffect("asphalt", "_t6/bio/player/fx_footstep_dust");
    setfootstepeffect("brick", "_t6/bio/player/fx_footstep_dust");
    setfootstepeffect("carpet", "_t6/bio/player/fx_footstep_dust");
    setfootstepeffect("cloth", "_t6/bio/player/fx_footstep_dust");
    setfootstepeffect("concrete", "_t6/bio/player/fx_footstep_dust");
    setfootstepeffect("dirt", "_t6/bio/player/fx_footstep_sand");
    setfootstepeffect("foliage", "_t6/bio/player/fx_footstep_sand");
    setfootstepeffect("gravel", "_t6/bio/player/fx_footstep_dust");
    setfootstepeffect("grass", "_t6/bio/player/fx_footstep_dust");
    setfootstepeffect("metal", "_t6/bio/player/fx_footstep_dust");
    setfootstepeffect("mud", "_t6/bio/player/fx_footstep_mud");
    setfootstepeffect("paper", "_t6/bio/player/fx_footstep_dust");
    setfootstepeffect("plaster", "_t6/bio/player/fx_footstep_dust");
    setfootstepeffect("rock", "_t6/bio/player/fx_footstep_dust");
    setfootstepeffect("sand", "_t6/bio/player/fx_footstep_sand");
    setfootstepeffect("water", "_t6/bio/player/fx_footstep_water");
    setfootstepeffect("wood", "_t6/bio/player/fx_footstep_dust");
}

// Namespace load/load
// Params 0, eflags: 0x0
// Checksum 0x38e88c1f, Offset: 0x608
// Size: 0xb2
function init_traverse() {
    point = getent(self.target, "targetname");
    if (isdefined(point)) {
        self.traverse_height = point.origin[2];
        point delete();
        return;
    }
    point = struct::get(self.target, "targetname");
    if (isdefined(point)) {
        self.traverse_height = point.origin[2];
    }
}

// Namespace load/load
// Params 0, eflags: 0x0
// Checksum 0x3b2465c6, Offset: 0x6c8
// Size: 0x8e
function setup_traversals() {
    potential_traverse_nodes = getallnodes();
    for (i = 0; i < potential_traverse_nodes.size; i++) {
        node = potential_traverse_nodes[i];
        if (node.type == #"begin") {
            node init_traverse();
        }
    }
}

// Namespace load/load
// Params 0, eflags: 0x0
// Checksum 0x77c2d2a0, Offset: 0x760
// Size: 0x94
function register_clientfields() {
    clientfield::register("missile", "cf_m_proximity", 1, 1, "int");
    clientfield::register("missile", "cf_m_emp", 1, 1, "int");
    clientfield::register("missile", "cf_m_stun", 1, 1, "int");
}

