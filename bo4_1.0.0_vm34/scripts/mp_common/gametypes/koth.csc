#using script_354f0cf6dd1c85c4;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;

#namespace koth;

// Namespace koth/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x26cc5483, Offset: 0x1c0
// Size: 0x394
function event_handler[gametype_init] main(eventstruct) {
    level.current_zone = [];
    level.current_state = [];
    for (i = 0; i < 4; i++) {
        level.current_zone[i] = 0;
        level.current_state[i] = 0;
    }
    level.hardpoints = [];
    level.visuals = [];
    level.hardpointfx = [];
    clientfield::register("world", "hardpoint", 1, 5, "int", &hardpoint, 0, 0);
    clientfield::register("world", "hardpointteam", 1, 5, "int", &hardpoint_state, 0, 0);
    level.effect_scriptbundles = [];
    level.effect_scriptbundles[#"zoneedgemarker"] = struct::get_script_bundle("teamcolorfx", "teamcolorfx_koth_edge_marker");
    level.effect_scriptbundles[#"zoneedgemarkerwndw"] = struct::get_script_bundle("teamcolorfx", "teamcolorfx_koth_edge_marker_window");
    level._effect[#"zoneedgemarker"] = [];
    level._effect[#"zoneedgemarker"][0] = #"ui/fx8_infil_marker_neutral";
    level._effect[#"zoneedgemarker"][1] = #"hash_5c2ae9f4f331d4b9";
    level._effect[#"zoneedgemarker"][2] = #"hash_7d1b0f001ea88b82";
    level._effect[#"zoneedgemarker"][3] = #"hash_7981eb245ea536fc";
    level._effect[#"zoneedgemarkerwndw"] = [];
    level._effect[#"zoneedgemarkerwndw"][0] = #"ui/fx8_infil_marker_neutral_window";
    level._effect[#"zoneedgemarkerwndw"][1] = #"hash_5565c3fc2c7742fe";
    level._effect[#"zoneedgemarkerwndw"][2] = #"hash_3283b765fe480df7";
    level._effect[#"zoneedgemarkerwndw"][3] = #"hash_6a512c225256a2e9";
    callback::on_spawned(&function_9a25f8b4);
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0xe2d4316d, Offset: 0x560
// Size: 0x84
function function_9a25f8b4() {
    localclientnum = self getlocalclientnumber();
    if (isdefined(localclientnum) && isdefined(level.current_zone) && isdefined(level.current_state)) {
        setup_hardpoint_fx(localclientnum, level.current_zone[localclientnum], level.current_state[localclientnum]);
    }
}

// Namespace koth/koth
// Params 1, eflags: 0x0
// Checksum 0x53ebd65c, Offset: 0x5f0
// Size: 0x198
function get_shoutcaster_fx(local_client_num) {
    var_7377ff1a = [];
    var_7377ff1a[#"zoneedgemarker"] = shoutcaster::get_color_fx(local_client_num, level.effect_scriptbundles[#"zoneedgemarker"]);
    var_7377ff1a[#"zoneedgemarkerwndw"] = shoutcaster::get_color_fx(local_client_num, level.effect_scriptbundles[#"zoneedgemarkerwndw"]);
    effects = [];
    effects[#"zoneedgemarker"] = level._effect[#"zoneedgemarker"];
    effects[#"zoneedgemarkerwndw"] = level._effect[#"zoneedgemarkerwndw"];
    effects[#"zoneedgemarker"][1] = "ui/fx8_infil_marker_shoutcaster_allies";
    effects[#"zoneedgemarker"][2] = "ui/fx8_infil_marker_shoutcaster_axis";
    effects[#"zoneedgemarkerwndw"][1] = "ui/fx8_infil_marker_shoutcaster_allies_window";
    effects[#"zoneedgemarkerwndw"][2] = "ui/fx8_infil_marker_shoutcaster_axis_window";
    return effects;
}

// Namespace koth/koth
// Params 3, eflags: 0x0
// Checksum 0xdd77a59f, Offset: 0x790
// Size: 0xbc
function get_fx_state(local_client_num, state, is_shoutcaster) {
    if (is_shoutcaster) {
        return state;
    }
    if (state == 1) {
        if (function_98901e1a(local_client_num) == #"allies") {
            return 1;
        } else {
            return 2;
        }
    } else if (state == 2) {
        if (function_98901e1a(local_client_num) == #"axis") {
            return 1;
        } else {
            return 2;
        }
    }
    return state;
}

// Namespace koth/koth
// Params 3, eflags: 0x0
// Checksum 0xc39876fe, Offset: 0x858
// Size: 0x2c
function get_fx(fx_name, fx_state, effects) {
    return effects[fx_name][fx_state];
}

// Namespace koth/koth
// Params 3, eflags: 0x0
// Checksum 0x174ec644, Offset: 0x890
// Size: 0x3bc
function setup_hardpoint_fx(local_client_num, zone_index, state) {
    effects = [];
    if (shoutcaster::is_shoutcaster_using_team_identity(local_client_num)) {
        effects = get_shoutcaster_fx(local_client_num);
    } else {
        effects[#"zoneedgemarker"] = level._effect[#"zoneedgemarker"];
        effects[#"zoneedgemarkerwndw"] = level._effect[#"zoneedgemarkerwndw"];
    }
    if (isdefined(level.hardpointfx[local_client_num])) {
        foreach (fx in level.hardpointfx[local_client_num]) {
            stopfx(local_client_num, fx);
        }
    }
    level.hardpointfx[local_client_num] = [];
    if (zone_index) {
        if (isdefined(level.visuals[zone_index])) {
            fx_state = get_fx_state(local_client_num, state, shoutcaster::is_shoutcaster(local_client_num));
            foreach (visual in level.visuals[zone_index]) {
                if (!isdefined(visual.script_fxid)) {
                    continue;
                }
                fxid = get_fx(visual.script_fxid, fx_state, effects);
                if (isdefined(visual.angles)) {
                    forward = anglestoforward(visual.angles);
                } else {
                    forward = (0, 0, 0);
                }
                fxhandle = playfx(local_client_num, fxid, visual.origin, forward);
                level.hardpointfx[local_client_num][level.hardpointfx[local_client_num].size] = fxhandle;
                if (isdefined(fxhandle)) {
                    if (state == 1) {
                        setfxteam(local_client_num, fxhandle, #"allies");
                        continue;
                    }
                    if (state == 2) {
                        setfxteam(local_client_num, fxhandle, #"axis");
                        continue;
                    }
                    setfxteam(local_client_num, fxhandle, "free");
                }
            }
        }
    }
    thread watch_for_team_change(local_client_num);
}

// Namespace koth/koth
// Params 7, eflags: 0x0
// Checksum 0x9220895b, Offset: 0xc58
// Size: 0x1f4
function hardpoint(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (level.hardpoints.size == 0) {
        hardpoints = struct::get_array("koth_zone_center", "targetname");
        foreach (point in hardpoints) {
            level.hardpoints[point.script_index] = point;
        }
        foreach (point in level.hardpoints) {
            level.visuals[point.script_index] = struct::get_array(point.target, "targetname");
        }
    }
    level.current_zone[localclientnum] = newval;
    level.current_state[localclientnum] = 0;
    setup_hardpoint_fx(localclientnum, level.current_zone[localclientnum], level.current_state[localclientnum]);
}

// Namespace koth/koth
// Params 7, eflags: 0x0
// Checksum 0x1f1ab274, Offset: 0xe58
// Size: 0xa4
function hardpoint_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval != level.current_state[localclientnum]) {
        level.current_state[localclientnum] = newval;
        setup_hardpoint_fx(localclientnum, level.current_zone[localclientnum], level.current_state[localclientnum]);
    }
}

// Namespace koth/koth
// Params 1, eflags: 0x0
// Checksum 0x3c656373, Offset: 0xf08
// Size: 0x84
function watch_for_team_change(localclientnum) {
    level notify(#"end_team_change_watch");
    level endon(#"end_team_change_watch");
    level waittill(#"team_changed");
    thread setup_hardpoint_fx(localclientnum, level.current_zone[localclientnum], level.current_state[localclientnum]);
}

