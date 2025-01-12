#using scripts\core_common\callbacks_shared;
#using scripts\core_common\filter_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace duplicate_render;

// Namespace duplicate_render/duplicaterender_mgr
// Params 0, eflags: 0x2
// Checksum 0xa08ff0c8, Offset: 0x350
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"duplicate_render", &__init__, undefined, undefined);
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 0, eflags: 0x0
// Checksum 0xf7791cfb, Offset: 0x398
// Size: 0x46e
function __init__() {
    if (!isdefined(level.drfilters)) {
        level.drfilters = [];
    }
    set_dr_filter_framebuffer("none_fb", 0, undefined, undefined, 0, 1, 0);
    set_dr_filter_framebuffer_duplicate("none_fbd", 0, undefined, undefined, 1, 0, 0);
    set_dr_filter_offscreen("none_os", 0, undefined, undefined, 2, 0, 0);
    set_dr_filter_framebuffer("frveh_fb", 8, "friendlyvehicle_fb", undefined, 0, 1, 1);
    set_dr_filter_offscreen("retrv", 5, "retrievable", undefined, 2, "mc/hud_keyline_retrievable", 1);
    set_dr_filter_offscreen("unplc", 7, "unplaceable", undefined, 2, "mc/hud_keyline_unplaceable", 1);
    set_dr_filter_offscreen("eneqp", 8, "enemyequip", undefined, 2, "mc/hud_outline_rim", 1);
    set_dr_filter_offscreen("enexp", 8, "enemyexplo", undefined, 2, "mc/hud_outline_rim", 1);
    set_dr_filter_offscreen("enveh", 8, "enemyvehicle", undefined, 2, "mc/hud_outline_rim", 1);
    set_dr_filter_offscreen("freqp", 8, "friendlyequip", undefined, 2, "mc/hud_keyline_friendlyequip", 1);
    set_dr_filter_offscreen("frexp", 8, "friendlyexplo", undefined, 2, "mc/hud_keyline_friendlyequip", 1);
    set_dr_filter_offscreen("frveh", 8, "friendlyvehicle", undefined, 2, "mc/hud_keyline_friendlyequip", 1);
    set_dr_filter_offscreen("infrared", 9, "infrared_entity", undefined, 2, 2, 1);
    set_dr_filter_offscreen("threat_detector_enemy", 10, "threat_detector_enemy", undefined, 2, "mc/hud_keyline_enemyequip", 1);
    set_dr_filter_offscreen("hthacked", 5, "hacker_tool_hacked", undefined, 2, "mc/mtl_hacker_tool_hacked", 1);
    set_dr_filter_offscreen("hthacking", 5, "hacker_tool_hacking", undefined, 2, "mc/mtl_hacker_tool_hacking", 1);
    set_dr_filter_offscreen("htbreaching", 5, "hacker_tool_breaching", undefined, 2, "mc/mtl_hacker_tool_breaching", 1);
    set_dr_filter_offscreen("bcarrier", 9, "ballcarrier", undefined, 2, "mc/hud_keyline_friendlyequip", 1);
    set_dr_filter_offscreen("poption", 9, "passoption", undefined, 2, "mc/hud_keyline_friendlyequip", 1);
    set_dr_filter_offscreen("draft_unselected", 10, "draft_unselected", undefined, 0, "mc/hud_outline_model_z_scriptint", 1);
    level.friendlycontentoutlines = getdvarint(#"friendlycontentoutlines", 0);
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 1, eflags: 0x0
// Checksum 0x1f142efd, Offset: 0x810
// Size: 0x74
function on_player_spawned(local_client_num) {
    self.currentdrfilter = [];
    self change_dr_flags(local_client_num);
    if (!level flagsys::get(#"duplicaterender_registry_ready")) {
        waitframe(1);
        level flagsys::set(#"duplicaterender_registry_ready");
    }
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 14, eflags: 0x0
// Checksum 0x1327a5f5, Offset: 0x890
// Size: 0x37c
function set_dr_filter(filterset, name, priority, require_flags, refuse_flags, drtype1, drval1, drcull1, drtype2, drval2, drcull2, drtype3, drval3, drcull3) {
    if (!isdefined(level.drfilters)) {
        level.drfilters = [];
    }
    if (!isdefined(level.drfilters[filterset])) {
        level.drfilters[filterset] = [];
    }
    if (!isdefined(level.drfilters[filterset][name])) {
        level.drfilters[filterset][name] = spawnstruct();
    }
    filter = level.drfilters[filterset][name];
    filter.name = name;
    filter.priority = priority * -1;
    if (!isdefined(require_flags)) {
        filter.require = [];
    } else if (isarray(require_flags)) {
        filter.require = require_flags;
    } else {
        filter.require = strtok(require_flags, ",");
    }
    if (!isdefined(refuse_flags)) {
        filter.refuse = [];
    } else if (isarray(refuse_flags)) {
        filter.refuse = refuse_flags;
    } else {
        filter.refuse = strtok(refuse_flags, ",");
    }
    filter.types = [];
    filter.values = [];
    filter.culling = [];
    filter.method = [];
    if (isdefined(drtype1)) {
        idx = filter.types.size;
        filter.types[idx] = drtype1;
        filter.values[idx] = drval1;
        filter.culling[idx] = drcull1;
    }
    if (isdefined(drtype2)) {
        idx = filter.types.size;
        filter.types[idx] = drtype2;
        filter.values[idx] = drval2;
        filter.culling[idx] = drcull2;
    }
    if (isdefined(drtype3)) {
        idx = filter.types.size;
        filter.types[idx] = drtype3;
        filter.values[idx] = drval3;
        filter.culling[idx] = drcull3;
    }
    thread register_filter_materials(filter);
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 13, eflags: 0x0
// Checksum 0x3cd07c3e, Offset: 0xc18
// Size: 0xb4
function set_dr_filter_framebuffer(name, priority, require_flags, refuse_flags, drtype1, drval1, drcull1, drtype2, drval2, drcull2, drtype3, drval3, drcull3) {
    set_dr_filter("framebuffer", name, priority, require_flags, refuse_flags, drtype1, drval1, drcull1, drtype2, drval2, drcull2, drtype3, drval3, drcull3);
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 13, eflags: 0x0
// Checksum 0x308e63c5, Offset: 0xcd8
// Size: 0xb4
function set_dr_filter_framebuffer_duplicate(name, priority, require_flags, refuse_flags, drtype1, drval1, drcull1, drtype2, drval2, drcull2, drtype3, drval3, drcull3) {
    set_dr_filter("framebuffer_duplicate", name, priority, require_flags, refuse_flags, drtype1, drval1, drcull1, drtype2, drval2, drcull2, drtype3, drval3, drcull3);
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 13, eflags: 0x0
// Checksum 0x217c8af4, Offset: 0xd98
// Size: 0xb4
function set_dr_filter_offscreen(name, priority, require_flags, refuse_flags, drtype1, drval1, drcull1, drtype2, drval2, drcull2, drtype3, drval3, drcull3) {
    set_dr_filter("offscreen", name, priority, require_flags, refuse_flags, drtype1, drval1, drcull1, drtype2, drval2, drcull2, drtype3, drval3, drcull3);
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 1, eflags: 0x0
// Checksum 0xbf8959b1, Offset: 0xe58
// Size: 0x17e
function register_filter_materials(filter) {
    playercount = undefined;
    opts = filter.types.size;
    for (i = 0; i < opts; i++) {
        value = filter.values[i];
        if (isstring(value)) {
            if (!isdefined(playercount)) {
                while (!isdefined(level.localplayers) && !isdefined(level.frontendclientconnected)) {
                    waitframe(1);
                }
                if (isdefined(level.frontendclientconnected)) {
                    playercount = 1;
                } else {
                    util::waitforallclients();
                    playercount = level.localplayers.size;
                }
            }
            if (!isdefined(filter::mapped_material_id(value))) {
                for (localclientnum = 0; localclientnum < playercount; localclientnum++) {
                    filter::map_material_helper_by_localclientnum(localclientnum, value);
                }
            }
        }
    }
    filter.priority = abs(filter.priority);
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 3, eflags: 0x0
// Checksum 0xfaa5d970, Offset: 0xfe0
// Size: 0x5c
function update_dr_flag(localclientnum, toset, setto = 1) {
    if (set_dr_flag(toset, setto)) {
        update_dr_filters(localclientnum);
    }
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 2, eflags: 0x0
// Checksum 0x1c1dee8e, Offset: 0x1048
// Size: 0xc0
function set_dr_flag_not_array(toset, setto = 1) {
    if (!isdefined(self.flag) || !isdefined(self.flag[toset])) {
        self flag::init(toset);
    }
    if (setto == self.flag[toset]) {
        return false;
    }
    if (isdefined(setto) && setto) {
        self flag::set(toset);
    } else {
        self flag::clear(toset);
    }
    return true;
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 2, eflags: 0x0
// Checksum 0xab35aa8c, Offset: 0x1110
// Size: 0x170
function set_dr_flag(toset, setto = 1) {
    assert(isdefined(setto));
    if (isarray(toset)) {
        foreach (ts in toset) {
            set_dr_flag(ts, setto);
        }
        return;
    }
    if (!isdefined(self.flag) || !isdefined(self.flag[toset])) {
        self flag::init(toset);
    }
    if (setto == self.flag[toset]) {
        return 0;
    }
    if (isdefined(setto) && setto) {
        self flag::set(toset);
    } else {
        self flag::clear(toset);
    }
    return 1;
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 1, eflags: 0x0
// Checksum 0x51bcd1eb, Offset: 0x1288
// Size: 0x24
function clear_dr_flag(toclear) {
    set_dr_flag(toclear, 0);
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 3, eflags: 0x0
// Checksum 0x756afc49, Offset: 0x12b8
// Size: 0xe4
function change_dr_flags(localclientnum, toset, toclear) {
    if (isdefined(toset)) {
        if (isstring(toset)) {
            toset = strtok(toset, ",");
        }
        self set_dr_flag(toset);
    }
    if (isdefined(toclear)) {
        if (isstring(toclear)) {
            toclear = strtok(toclear, ",");
        }
        self clear_dr_flag(toclear);
    }
    update_dr_filters(localclientnum);
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 1, eflags: 0x0
// Checksum 0x6e2486c7, Offset: 0x13a8
// Size: 0x164
function _update_dr_filters(localclientnum) {
    self notify(#"update_dr_filters");
    self endon(#"update_dr_filters");
    self endon(#"death");
    waittillframeend();
    foreach (key, filterset in level.drfilters) {
        filter = self find_dr_filter(filterset);
        if (isdefined(filter) && (!isdefined(self.currentdrfilter) || !(self.currentdrfilter[key] === filter.name))) {
            self apply_filter(localclientnum, filter, key);
        }
    }
    if (sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
        self thread disable_all_filters_on_game_ended();
    }
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 1, eflags: 0x0
// Checksum 0xf52c7c4a, Offset: 0x1518
// Size: 0x24
function update_dr_filters(localclientnum) {
    self thread _update_dr_filters(localclientnum);
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 1, eflags: 0x0
// Checksum 0xdf401630, Offset: 0x1548
// Size: 0xe6
function find_dr_filter(filterset = level.drfilters[#"framebuffer"]) {
    best = undefined;
    foreach (filter in filterset) {
        if (self can_use_filter(filter)) {
            if (!isdefined(best) || filter.priority > best.priority) {
                best = filter;
            }
        }
    }
    return best;
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 1, eflags: 0x0
// Checksum 0x765f556f, Offset: 0x1638
// Size: 0xb8
function can_use_filter(filter) {
    for (i = 0; i < filter.require.size; i++) {
        if (!self flagsys::get(filter.require[i])) {
            return false;
        }
    }
    for (i = 0; i < filter.refuse.size; i++) {
        if (self flagsys::get(filter.refuse[i])) {
            return false;
        }
    }
    return true;
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 3, eflags: 0x0
// Checksum 0x3c6c9d9f, Offset: 0x16f8
// Size: 0x306
function apply_filter(localclientnum, filter, filterset = "framebuffer") {
    if (isdefined(level.postgame) && level.postgame && !(isdefined(level.showedtopthreeplayers) && level.showedtopthreeplayers)) {
        if (!function_1fe374eb(localclientnum)) {
            return;
        }
    }
    /#
        if (getdvarint(#"scr_debug_duplicaterender", 0)) {
            name = "<dev string:x30>";
            if (self isplayer()) {
                if (isdefined(self.name)) {
                    name = "<dev string:x39>" + self.name;
                }
            } else if (isdefined(self.model)) {
                name += "<dev string:x41>" + self.model;
            }
            msg = "<dev string:x43>" + filter.name + "<dev string:x65>" + name + "<dev string:x6a>" + filterset;
            println(msg);
        }
    #/
    if (!isdefined(self.currentdrfilter)) {
        self.currentdrfilter = [];
    }
    self.currentdrfilter[filterset] = filter.name;
    opts = filter.types.size;
    for (i = 0; i < opts; i++) {
        type = filter.types[i];
        value = filter.values[i];
        culling = filter.culling[i];
        var_7ae15d3d = filter.method[i];
        material = undefined;
        if (isstring(value)) {
            material = filter::mapped_material_id(value);
            if (!isdefined(var_7ae15d3d)) {
                var_7ae15d3d = 3;
            }
            if (isdefined(material)) {
                self addduplicaterenderoption(type, var_7ae15d3d, material, culling);
            } else {
                self.currentdrfilter[filterset] = undefined;
            }
            continue;
        }
        self addduplicaterenderoption(type, value, -1, culling);
    }
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 0, eflags: 0x0
// Checksum 0xc1bb8925, Offset: 0x1a08
// Size: 0x6c
function disable_all_filters_on_game_ended() {
    self endon(#"death");
    self notify(#"disable_all_filters_on_game_ended");
    self endon(#"disable_all_filters_on_game_ended");
    level waittill(#"post_game");
    self disableduplicaterendering();
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 2, eflags: 0x0
// Checksum 0x441ca285, Offset: 0x1a80
// Size: 0x34
function set_item_retrievable(localclientnum, on_off) {
    self update_dr_flag(localclientnum, "retrievable", on_off);
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 2, eflags: 0x0
// Checksum 0xf2a86a93, Offset: 0x1ac0
// Size: 0x34
function set_item_unplaceable(localclientnum, on_off) {
    self update_dr_flag(localclientnum, "unplaceable", on_off);
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 2, eflags: 0x0
// Checksum 0x24be231e, Offset: 0x1b00
// Size: 0x34
function set_item_enemy_equipment(localclientnum, on_off) {
    self update_dr_flag(localclientnum, "enemyequip", on_off);
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 2, eflags: 0x0
// Checksum 0x9af33460, Offset: 0x1b40
// Size: 0x34
function set_item_friendly_equipment(localclientnum, on_off) {
    self update_dr_flag(localclientnum, "friendlyequip", on_off);
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 2, eflags: 0x0
// Checksum 0x4a216064, Offset: 0x1b80
// Size: 0x34
function set_entity_thermal(localclientnum, on_off) {
    self update_dr_flag(localclientnum, "infrared_entity", on_off);
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 2, eflags: 0x0
// Checksum 0xe8f68de2, Offset: 0x1bc0
// Size: 0x34
function set_player_threat_detected(localclientnum, on_off) {
    self update_dr_flag(localclientnum, "threat_detector_enemy", on_off);
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 2, eflags: 0x0
// Checksum 0x553857d8, Offset: 0x1c00
// Size: 0x34
function set_hacker_tool_hacked(localclientnum, on_off) {
    self update_dr_flag(localclientnum, "hacker_tool_hacked", on_off);
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 2, eflags: 0x0
// Checksum 0x14c533d0, Offset: 0x1c40
// Size: 0x34
function set_hacker_tool_hacking(localclientnum, on_off) {
    self update_dr_flag(localclientnum, "hacker_tool_hacking", on_off);
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 2, eflags: 0x0
// Checksum 0x7c4911f1, Offset: 0x1c80
// Size: 0xd4
function set_hacker_tool_breaching(localclientnum, on_off) {
    flags_changed = self set_dr_flag("hacker_tool_breaching", on_off);
    if (on_off) {
        flags_changed = self set_dr_flag("enemyvehicle", 0) || flags_changed;
    } else if (isdefined(self.var_2c088b81) && self.var_2c088b81) {
        flags_changed = self set_dr_flag("enemyvehicle", 1) || flags_changed;
    }
    if (flags_changed) {
        update_dr_filters(localclientnum);
    }
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 1, eflags: 0x0
// Checksum 0x2ab39854, Offset: 0x1d60
// Size: 0x4e
function show_friendly_outlines(local_client_num) {
    if (!(isdefined(level.friendlycontentoutlines) && level.friendlycontentoutlines)) {
        return false;
    }
    if (function_d224c0e6(local_client_num)) {
        return false;
    }
    return true;
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 2, eflags: 0x0
// Checksum 0xaf2112e3, Offset: 0x1db8
// Size: 0x94
function set_entity_draft_unselected(localclientnum, on_off) {
    if (util::is_frontend_map()) {
        rob = #"hash_79892e1d5a8f9f33";
    } else {
        rob = #"hash_68bd6efcb1324e3";
    }
    if (isdefined(on_off) && on_off) {
        self playrenderoverridebundle(rob);
        return;
    }
    self stoprenderoverridebundle(rob);
}

