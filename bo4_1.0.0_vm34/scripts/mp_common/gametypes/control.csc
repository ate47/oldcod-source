#using script_354f0cf6dd1c85c4;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;

#namespace control;

// Namespace control/gametype_init
// Params 1, eflags: 0x40
// Checksum 0xdda09a93, Offset: 0x200
// Size: 0x45c
function event_handler[gametype_init] main(eventstruct) {
    level.current_zone_mask = [];
    level.current_zone_state_mask = [];
    level.visuals = [];
    level.warzonefx = [];
    level.zones = [];
    for (i = 0; i < 4; i++) {
        level.current_zone_mask[i] = 0;
        level.current_zone_state_mask[i] = 0;
        level.warzonefx[i] = [];
    }
    clientfield::register("world", "warzone", 1, 5, "int", &warzone, 0, 0);
    clientfield::register("world", "warzonestate", 1, 10, "int", &warzone_state, 0, 0);
    clientfield::register("worlduimodel", "hudItems.missions.captureMultiplierStatus", 1, 2, "int", undefined, 0, 1);
    clientfield::register("worlduimodel", "hudItems.war.attackingTeam", 1, 2, "int", undefined, 0, 1);
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
    level.mission_bundle = getscriptbundle("mission_settings_control");
    callback::on_localclient_connect(&on_localclient_connect);
    callback::on_spawned(&function_f97c0d2c);
}

// Namespace control/control
// Params 1, eflags: 0x0
// Checksum 0xcccf5185, Offset: 0x668
// Size: 0x24
function on_localclient_connect(localclientnum) {
    thread function_c58e66a8(localclientnum, undefined, undefined);
}

// Namespace control/control
// Params 1, eflags: 0x0
// Checksum 0xbed25245, Offset: 0x698
// Size: 0x198
function get_shoutcaster_fx(local_client_num) {
    var_7377ff1a = [];
    var_7377ff1a[#"zoneedgemarker"] = shoutcaster::get_color_fx(local_client_num, level.effect_scriptbundles[#"zoneedgemarker"]);
    var_7377ff1a[#"zoneedgemarkerwndw"] = shoutcaster::get_color_fx(local_client_num, level.effect_scriptbundles[#"zoneedgemarkerwndw"]);
    effects = [];
    effects[#"zoneedgemarker"] = level._effect[#"zoneedgemarker"];
    effects[#"zoneedgemarkerwndw"] = level._effect[#"zoneedgemarkerwndw"];
    effects[#"zoneedgemarker"][1] = "ui/fx8_infil_marker_neutral";
    effects[#"zoneedgemarker"][2] = "ui/fx8_infil_marker_neutral";
    effects[#"zoneedgemarkerwndw"][1] = "ui/fx8_infil_marker_neutral_window";
    effects[#"zoneedgemarkerwndw"][2] = "ui/fx8_infil_marker_neutral_window";
    return effects;
}

// Namespace control/control
// Params 4, eflags: 0x0
// Checksum 0xcea3ab39, Offset: 0x838
// Size: 0xb0
function get_fx_state(local_client_num, state, attackers, is_shoutcaster) {
    if (is_shoutcaster) {
        return state;
    }
    if (state == 1) {
        if (function_98901e1a(local_client_num) != attackers) {
            return 1;
        } else {
            return 2;
        }
    } else if (state == 2) {
        if (function_98901e1a(local_client_num) == attackers) {
            return 1;
        } else {
            return 2;
        }
    }
    return state;
}

// Namespace control/control
// Params 3, eflags: 0x0
// Checksum 0xfde51dff, Offset: 0x8f0
// Size: 0x2c
function get_fx(fx_name, fx_state, effects) {
    return effects[fx_name][fx_state];
}

// Namespace control/control
// Params 0, eflags: 0x4
// Checksum 0x2651e68b, Offset: 0x928
// Size: 0x62
function private get_attacking_team() {
    attackers_key = codegetworlduimodelfield("hudItems.war.attackingTeam");
    attackers = #"allies";
    if (attackers_key == 2) {
        attackers = #"axis";
    }
    return attackers;
}

// Namespace control/control
// Params 0, eflags: 0x0
// Checksum 0xa2f782d5, Offset: 0x998
// Size: 0x54
function function_f97c0d2c() {
    if (isdefined(level.current_zone_state_mask)) {
        local_client_num = self getlocalclientnumber();
        if (isdefined(local_client_num)) {
            setup_warzone_fx(local_client_num);
        }
    }
}

// Namespace control/control
// Params 1, eflags: 0x0
// Checksum 0x42f0fde5, Offset: 0x9f8
// Size: 0x464
function setup_warzone_fx(local_client_num) {
    for (zi = 0; zi < level.zones.size; zi++) {
        zonestate = level.current_zone_state_mask[local_client_num] >> zi * 2 & 3;
        effects = [];
        if (shoutcaster::is_shoutcaster_using_team_identity(local_client_num)) {
            effects = get_shoutcaster_fx(local_client_num);
        } else {
            effects[#"zoneedgemarker"] = level._effect[#"zoneedgemarker"];
            effects[#"zoneedgemarkerwndw"] = level._effect[#"zoneedgemarkerwndw"];
        }
        if (isdefined(level.warzonefx[local_client_num][zi])) {
            foreach (fx in level.warzonefx[local_client_num][zi]) {
                stopfx(local_client_num, fx);
            }
        }
        level.warzonefx[local_client_num][zi] = [];
        if (level.current_zone_mask[local_client_num] & 1 << zi) {
            if (isdefined(level.visuals[zi])) {
                attackers = get_attacking_team();
                fx_state = get_fx_state(local_client_num, zonestate, attackers, shoutcaster::is_shoutcaster(local_client_num));
                foreach (visual in level.visuals[zi]) {
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
                    level.warzonefx[local_client_num][zi][level.warzonefx[local_client_num][zi].size] = fxhandle;
                    if (isdefined(fxhandle)) {
                        if (zonestate == 2) {
                            setfxteam(local_client_num, fxhandle, attackers);
                            continue;
                        }
                        if (zonestate == 1) {
                            defenders = util::get_other_team(attackers);
                            setfxteam(local_client_num, fxhandle, defenders);
                            continue;
                        }
                        setfxteam(local_client_num, fxhandle, "free");
                    }
                }
            }
        }
    }
    thread watch_for_team_change(local_client_num);
}

// Namespace control/control
// Params 2, eflags: 0x0
// Checksum 0x5ff83714, Offset: 0xe68
// Size: 0xfc
function compare_zone_indicies(zone_a, zone_b) {
    script_index_a = zone_a.script_index;
    script_index_b = zone_b.script_index;
    if (!isdefined(script_index_a) && !isdefined(script_index_b)) {
        return false;
    }
    if (!isdefined(script_index_a) && isdefined(script_index_b)) {
        println("<dev string:x30>" + zone_a.origin);
        return true;
    }
    if (isdefined(script_index_a) && !isdefined(script_index_b)) {
        println("<dev string:x30>" + zone_b.origin);
        return false;
    }
    if (script_index_a > script_index_b) {
        return true;
    }
    return false;
}

// Namespace control/control
// Params 0, eflags: 0x0
// Checksum 0x84ee8d9a, Offset: 0xf70
// Size: 0x2ec
function get_zone_array() {
    allzones = struct::get_array("control_zone_center", "targetname");
    if (allzones.size > 1) {
        if (!isdefined(allzones)) {
            return;
        }
        zoneindices = [];
        numberofzones = allzones.size;
        for (i = 0; i < numberofzones; i++) {
            fieldname = "zoneinfo" + numberofzones + i + 1;
            index = isdefined(level.mission_bundle.(fieldname)) ? level.mission_bundle.(fieldname) : 0;
            zoneindices[zoneindices.size] = index;
        }
        zones = [];
        for (i = 0; i < allzones.size; i++) {
            ind = allzones[i].script_index;
            if (isdefined(ind)) {
                for (j = 0; j < zoneindices.size; j++) {
                    if (zoneindices[j] == ind) {
                        zones[zones.size] = allzones[i];
                        break;
                    }
                }
            }
        }
    } else {
        zones = struct::get_array("control_zone_center", "targetname");
    }
    if (!isdefined(zones)) {
        return undefined;
    }
    swapped = 1;
    for (n = zones.size; swapped; n--) {
        swapped = 0;
        for (i = 0; i < n - 1; i++) {
            if (compare_zone_indicies(zones[i], zones[i + 1])) {
                temp = zones[i];
                zones[i] = zones[i + 1];
                zones[i + 1] = temp;
                swapped = 1;
            }
        }
    }
    for (i = 0; i < zones.size; i++) {
        zones[i].zone_index = i;
    }
    return zones;
}

// Namespace control/control
// Params 7, eflags: 0x0
// Checksum 0x387521eb, Offset: 0x1268
// Size: 0x254
function warzone(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (level.zones.size == 0) {
        level.zones = get_zone_array();
        for (zi = 0; zi < level.zones.size; zi++) {
            if (isdefined(level.zones[zi].target)) {
                level.visuals[zi] = struct::get_array(level.zones[zi].target, "targetname");
            }
            level.zones[zi].objectiveid = serverobjective_getobjective(localclientnum, "control_" + zi);
            level.zones[zi].objectiveentity = spawn(0, level.zones[zi].origin, "script_origin");
            level.zones[zi].var_dc7f1d01 = 0;
        }
        level notify(#"zone_initialization");
    }
    level.current_zone_mask[localclientnum] = newval;
    for (zi = 0; zi < level.zones.size; zi++) {
        if ((oldval & 1 << zi) != (newval & 1 << zi)) {
            level.current_zone_state_mask[localclientnum] = level.current_zone_state_mask[localclientnum] & ~(3 << zi);
        }
    }
    setup_warzone_fx(localclientnum);
}

// Namespace control/control
// Params 7, eflags: 0x0
// Checksum 0xbd9b50d9, Offset: 0x14c8
// Size: 0x84
function warzone_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval != level.current_zone_state_mask[localclientnum]) {
        level.current_zone_state_mask[localclientnum] = newval;
        setup_warzone_fx(localclientnum);
    }
}

// Namespace control/control
// Params 1, eflags: 0x0
// Checksum 0xa9e3544f, Offset: 0x1558
// Size: 0x64
function watch_for_team_change(localclientnum) {
    level notify(#"end_team_change_watch");
    level endon(#"end_team_change_watch");
    level waittill(#"team_changed");
    thread setup_warzone_fx(localclientnum);
}

// Namespace control/control
// Params 3, eflags: 0x0
// Checksum 0x4402f4fb, Offset: 0x15c8
// Size: 0x28c
function function_c58e66a8(localclientnum, oldval, newval) {
    level endon(#"game_ended");
    self notify("159d5eec68040a62");
    self endon("159d5eec68040a62");
    basepitch = 0.8;
    var_c4405d05 = 1;
    var_4f881ca8 = 255;
    progresspercentage = 1 / var_4f881ca8;
    waitresult = level waittill(#"zone_initialization");
    while (true) {
        foreach (zone in level.zones) {
            if (!isdefined(zone.objectiveid)) {
                continue;
            }
            progress = serverobjective_getobjectiveprogress(localclientnum, zone.objectiveid);
            change = progress - (isdefined(zone.lastprogress) ? zone.lastprogress : 0);
            if (change <= 0) {
                if (zone.var_dc7f1d01) {
                    zone.objectiveentity stoploopsound(zone.soundid);
                    zone.var_dc7f1d01 = 0;
                }
            } else {
                if (!zone.var_dc7f1d01) {
                    zone.soundid = zone.objectiveentity playloopsound(#"hash_5a0b392405d5f148");
                    zone.var_dc7f1d01 = 1;
                }
                newpitch = basepitch + var_c4405d05 * progress * progresspercentage;
                setsoundpitch(zone.soundid, newpitch);
            }
            zone.lastprogress = progress;
        }
        wait 0.25;
    }
}

