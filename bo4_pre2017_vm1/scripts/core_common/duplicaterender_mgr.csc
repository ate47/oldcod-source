#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/filter_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/visionset_mgr_shared;

#namespace duplicate_render;

// Namespace duplicate_render/duplicaterender_mgr
// Params 0, eflags: 0x2
// Checksum 0x4a63016, Offset: 0x510
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("duplicate_render", &__init__, undefined, undefined);
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 0, eflags: 0x0
// Checksum 0x9b453998, Offset: 0x550
// Size: 0x4a8
function __init__() {
    if (!isdefined(level.drfilters)) {
        level.drfilters = [];
    }
    callback::on_spawned(&on_player_spawned);
    callback::on_localclient_connect(&on_player_connect);
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
    level.friendlycontentoutlines = getdvarint("friendlyContentOutlines", 0);
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 1, eflags: 0x0
// Checksum 0x1f5fafa0, Offset: 0xa00
// Size: 0x7c
function on_player_spawned(local_client_num) {
    self.currentdrfilter = [];
    self change_dr_flags(local_client_num);
    if (!level flagsys::get("duplicaterender_registry_ready")) {
        waitframe(1);
        level flagsys::set("duplicaterender_registry_ready");
    }
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 1, eflags: 0x0
// Checksum 0x2fe7b07d, Offset: 0xa88
// Size: 0x24
function on_player_connect(localclientnum) {
    level wait_team_changed(localclientnum);
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 1, eflags: 0x0
// Checksum 0x9709762b, Offset: 0xab8
// Size: 0x90
function wait_team_changed(localclientnum) {
    while (true) {
        level waittill("team_changed");
        while (!isdefined(getlocalplayer(localclientnum))) {
            waitframe(1);
        }
        player = getlocalplayer(localclientnum);
        player codcaster_keyline_enable(0);
    }
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 14, eflags: 0x0
// Checksum 0x45440955, Offset: 0xb50
// Size: 0x3cc
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
// Checksum 0x99b7adf3, Offset: 0xf28
// Size: 0xbc
function set_dr_filter_framebuffer(name, priority, require_flags, refuse_flags, drtype1, drval1, drcull1, drtype2, drval2, drcull2, drtype3, drval3, drcull3) {
    set_dr_filter("framebuffer", name, priority, require_flags, refuse_flags, drtype1, drval1, drcull1, drtype2, drval2, drcull2, drtype3, drval3, drcull3);
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 13, eflags: 0x0
// Checksum 0x189e748, Offset: 0xff0
// Size: 0xbc
function set_dr_filter_framebuffer_duplicate(name, priority, require_flags, refuse_flags, drtype1, drval1, drcull1, drtype2, drval2, drcull2, drtype3, drval3, drcull3) {
    set_dr_filter("framebuffer_duplicate", name, priority, require_flags, refuse_flags, drtype1, drval1, drcull1, drtype2, drval2, drcull2, drtype3, drval3, drcull3);
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 13, eflags: 0x0
// Checksum 0xa01d99ae, Offset: 0x10b8
// Size: 0xbc
function set_dr_filter_offscreen(name, priority, require_flags, refuse_flags, drtype1, drval1, drcull1, drtype2, drval2, drcull2, drtype3, drval3, drcull3) {
    set_dr_filter("offscreen", name, priority, require_flags, refuse_flags, drtype1, drval1, drcull1, drtype2, drval2, drcull2, drtype3, drval3, drcull3);
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 1, eflags: 0x0
// Checksum 0x1894baab, Offset: 0x1180
// Size: 0x1a8
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
// Checksum 0x31095fe8, Offset: 0x1330
// Size: 0x64
function update_dr_flag(localclientnum, toset, setto) {
    if (!isdefined(setto)) {
        setto = 1;
    }
    if (set_dr_flag(toset, setto)) {
        update_dr_filters(localclientnum);
    }
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 2, eflags: 0x0
// Checksum 0x598072c3, Offset: 0x13a0
// Size: 0xd8
function set_dr_flag_not_array(toset, setto) {
    if (!isdefined(setto)) {
        setto = 1;
    }
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
// Checksum 0xce7333f, Offset: 0x1480
// Size: 0x198
function set_dr_flag(toset, setto) {
    if (!isdefined(setto)) {
        setto = 1;
    }
    /#
        assert(isdefined(setto));
    #/
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
// Checksum 0x8114cdd, Offset: 0x1620
// Size: 0x24
function clear_dr_flag(toclear) {
    set_dr_flag(toclear, 0);
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 3, eflags: 0x0
// Checksum 0x81a2bfe0, Offset: 0x1650
// Size: 0xf4
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
// Checksum 0x37ccdff7, Offset: 0x1750
// Size: 0x12a
function _update_dr_filters(localclientnum) {
    self notify(#"update_dr_filters");
    self endon(#"update_dr_filters");
    self endon(#"death");
    waittillframeend();
    foreach (key, filterset in level.drfilters) {
        filter = self find_dr_filter(filterset);
        if (!isdefined(self.currentdrfilter) || isdefined(filter) && !(self.currentdrfilter[key] === filter.name)) {
            self apply_filter(localclientnum, filter, key);
        }
    }
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 1, eflags: 0x0
// Checksum 0x19a46e89, Offset: 0x1888
// Size: 0x24
function update_dr_filters(localclientnum) {
    self thread _update_dr_filters(localclientnum);
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 1, eflags: 0x0
// Checksum 0x41470c99, Offset: 0x18b8
// Size: 0x104
function find_dr_filter(filterset) {
    if (!isdefined(filterset)) {
        filterset = level.drfilters["framebuffer"];
    }
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
// Checksum 0x4cf8fcf5, Offset: 0x19c8
// Size: 0xc8
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
// Checksum 0x6a50ad52, Offset: 0x1a98
// Size: 0x384
function apply_filter(localclientnum, filter, filterset) {
    if (!isdefined(filterset)) {
        filterset = "framebuffer";
    }
    if (isdefined(level.postgame) && level.postgame && !(isdefined(level.showedtopthreeplayers) && level.showedtopthreeplayers)) {
        player = getlocalplayer(localclientnum);
        if (!player getinkillcam(localclientnum)) {
            return;
        }
    }
    /#
        if (getdvarint("<dev string:x28>")) {
            name = "<dev string:x42>";
            if (self isplayer()) {
                if (isdefined(self.name)) {
                    name = "<dev string:x4b>" + self.name;
                }
            } else if (isdefined(self.model)) {
                name += "<dev string:x53>" + self.model;
            }
            msg = "<dev string:x55>" + filter.name + "<dev string:x77>" + name + "<dev string:x7c>" + filterset;
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
        material = undefined;
        if (isstring(value)) {
            material = filter::mapped_material_id(value);
            value = 3;
            if (isdefined(value) && isdefined(material)) {
                self addduplicaterenderoption(type, value, material, culling);
            } else {
                self.currentdrfilter[filterset] = undefined;
            }
            continue;
        }
        self addduplicaterenderoption(type, value, -1, culling);
    }
    if (sessionmodeismultiplayergame()) {
        self thread disable_all_filters_on_game_ended();
    }
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 0, eflags: 0x0
// Checksum 0xdad253e3, Offset: 0x1e28
// Size: 0x54
function disable_all_filters_on_game_ended() {
    self endon(#"death");
    self notify(#"disable_all_filters_on_game_ended");
    self endon(#"disable_all_filters_on_game_ended");
    level waittill("post_game");
    self disableduplicaterendering();
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 2, eflags: 0x0
// Checksum 0x3de433cb, Offset: 0x1e88
// Size: 0x3c
function set_item_retrievable(localclientnum, on_off) {
    self update_dr_flag(localclientnum, "retrievable", on_off);
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 2, eflags: 0x0
// Checksum 0xbd73a1e2, Offset: 0x1ed0
// Size: 0x3c
function set_item_unplaceable(localclientnum, on_off) {
    self update_dr_flag(localclientnum, "unplaceable", on_off);
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 2, eflags: 0x0
// Checksum 0x6309f824, Offset: 0x1f18
// Size: 0x3c
function set_item_enemy_equipment(localclientnum, on_off) {
    self update_dr_flag(localclientnum, "enemyequip", on_off);
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 2, eflags: 0x0
// Checksum 0x8c2ceb68, Offset: 0x1f60
// Size: 0x3c
function set_item_friendly_equipment(localclientnum, on_off) {
    self update_dr_flag(localclientnum, "friendlyequip", on_off);
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 2, eflags: 0x0
// Checksum 0xfe145e8a, Offset: 0x1fa8
// Size: 0x3c
function function_5ceb14b2(localclientnum, on_off) {
    self update_dr_flag(localclientnum, "enemyexplo", on_off);
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 2, eflags: 0x0
// Checksum 0x380cb9c3, Offset: 0x1ff0
// Size: 0x3c
function function_4e2867e3(localclientnum, on_off) {
    self update_dr_flag(localclientnum, "friendlyexplo", on_off);
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 2, eflags: 0x0
// Checksum 0xaf63641e, Offset: 0x2038
// Size: 0x3c
function function_a28d1a5f(localclientnum, on_off) {
    self update_dr_flag(localclientnum, "enemyvehicle", on_off);
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 2, eflags: 0x0
// Checksum 0x9357bc65, Offset: 0x2080
// Size: 0x3c
function function_48e05b4a(localclientnum, on_off) {
    self update_dr_flag(localclientnum, "friendlyvehicle", on_off);
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 2, eflags: 0x0
// Checksum 0x765f38ae, Offset: 0x20c8
// Size: 0x3c
function set_entity_thermal(localclientnum, on_off) {
    self update_dr_flag(localclientnum, "infrared_entity", on_off);
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 2, eflags: 0x0
// Checksum 0xe4f773f9, Offset: 0x2110
// Size: 0x3c
function set_player_threat_detected(localclientnum, on_off) {
    self update_dr_flag(localclientnum, "threat_detector_enemy", on_off);
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 2, eflags: 0x0
// Checksum 0x8662502e, Offset: 0x2158
// Size: 0x3c
function set_hacker_tool_hacked(localclientnum, on_off) {
    self update_dr_flag(localclientnum, "hacker_tool_hacked", on_off);
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 2, eflags: 0x0
// Checksum 0xe3264953, Offset: 0x21a0
// Size: 0x3c
function set_hacker_tool_hacking(localclientnum, on_off) {
    self update_dr_flag(localclientnum, "hacker_tool_hacking", on_off);
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 2, eflags: 0x0
// Checksum 0x1c772f76, Offset: 0x21e8
// Size: 0xdc
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
// Checksum 0x8bbb4135, Offset: 0x22d0
// Size: 0x4e
function show_friendly_outlines(local_client_num) {
    if (!(isdefined(level.friendlycontentoutlines) && level.friendlycontentoutlines)) {
        return false;
    }
    if (isshoutcaster(local_client_num)) {
        return false;
    }
    return true;
}

// Namespace duplicate_render/duplicaterender_mgr
// Params 2, eflags: 0x0
// Checksum 0xa596072b, Offset: 0x2328
// Size: 0x104
function set_entity_draft_unselected(localclientnum, on_off) {
    if (isdefined(on_off) && on_off) {
        self mapshaderconstant(localclientnum, 0, "scriptVector5", 0.1, 0.1, 0.1, 1);
        self mapshaderconstant(localclientnum, 0, "scriptVector7", 0, 0, 0, 0);
    } else {
        self addduplicaterenderoption(2, 0);
        self addduplicaterenderoption(1, 0);
        self addduplicaterenderoption(0, 1);
    }
    self update_dr_flag(localclientnum, "draft_unselected", on_off);
}

