#using script_1da833573eb80e61;
#using script_2feaeed9ab01d6f7;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\character_customization;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\multi_extracam;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace lui;

// Namespace lui
// Method(s) 12 Total 12
class cluielem {

    var var_57a3d576;
    var var_96b5410c;

    // Namespace cluielem/lui_shared
    // Params 2, eflags: 0x0
    // Checksum 0x53369dc0, Offset: 0x25a0
    // Size: 0x5a
    function get_data(localclientnum, field) {
        assert(var_96b5410c, "<dev string:x150>");
        return function_a1e55f0e(localclientnum, var_57a3d576, field);
    }

    // Namespace cluielem/lui_shared
    // Params 3, eflags: 0x0
    // Checksum 0xd7aeebde, Offset: 0x2530
    // Size: 0x64
    function set_data(localclientnum, field, value) {
        assert(var_96b5410c, "<dev string:x150>");
        function_c1d1626a(localclientnum, var_57a3d576, field, value);
    }

    // Namespace cluielem/lui_shared
    // Params 1, eflags: 0x0
    // Checksum 0x2ed646f0, Offset: 0x24d0
    // Size: 0x54
    function close(localclientnum) {
        assert(var_96b5410c, "<dev string:x111>");
        closeluielem(localclientnum, var_57a3d576);
    }

    // Namespace cluielem/lui_shared
    // Params 1, eflags: 0x0
    // Checksum 0x51b5604, Offset: 0x2470
    // Size: 0x52
    function is_open(localclientnum) {
        assert(var_96b5410c, "<dev string:xd2>");
        return isluielemopen(localclientnum, var_57a3d576);
    }

    // Namespace cluielem/lui_shared
    // Params 2, eflags: 0x0
    // Checksum 0xf137d7ea, Offset: 0x23f8
    // Size: 0x6c
    function open(localclientnum, menu_name) {
        assert(var_96b5410c, "<dev string:xd2>");
        openluielem(localclientnum, menu_name, var_57a3d576);
        function_cf9c4603(localclientnum);
    }

    // Namespace cluielem/lui_shared
    // Params 1, eflags: 0x0
    // Checksum 0x2985c77f, Offset: 0x23b8
    // Size: 0x34
    function function_cf9c4603(localclientnum) {
        assert(var_96b5410c, "<dev string:x90>");
    }

    // Namespace cluielem/lui_shared
    // Params 1, eflags: 0x0
    // Checksum 0x35ab06b3, Offset: 0x2388
    // Size: 0x26
    function register_clientside(uid) {
        var_57a3d576 = uid;
        var_96b5410c = 1;
    }

    // Namespace cluielem/lui_shared
    // Params 3, eflags: 0x0
    // Checksum 0x1e42056b, Offset: 0x22f0
    // Size: 0x8c
    function function_52818084(var_16dcb09f, field_name, version) {
        assert(!var_96b5410c, "<dev string:x53>");
        clientfield::register_bgcache("clientuimodel", var_16dcb09f, "luielement." + var_57a3d576 + "." + field_name, version, undefined, 0, 0);
    }

    // Namespace cluielem/lui_shared
    // Params 5, eflags: 0x0
    // Checksum 0xa795864b, Offset: 0x2260
    // Size: 0x84
    function add_clientfield(field_name, version, bits, type, callback) {
        assert(!var_96b5410c, "<dev string:x53>");
        clientfield::register_luielem(var_57a3d576, field_name, version, bits, type, callback, 0, 0);
    }

    // Namespace cluielem/lui_shared
    // Params 1, eflags: 0x0
    // Checksum 0xa1715f5c, Offset: 0x2230
    // Size: 0x26
    function setup_clientfields(uid) {
        var_57a3d576 = uid;
        var_96b5410c = 0;
    }

}

// Namespace lui/lui_shared
// Params 0, eflags: 0x2
// Checksum 0x4fd768b9, Offset: 0x1a0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"lui_shared", &__init__, undefined, undefined);
}

// Namespace lui/lui_shared
// Params 0, eflags: 0x0
// Checksum 0x16eb8780, Offset: 0x1e8
// Size: 0x8c
function __init__() {
    level.client_menus = associativearray();
    level.var_d219d19b = associativearray();
    callback::on_localclient_connect(&on_player_connect);
    full_screen_black::register("full_screen_black");
    initial_black::register("initial_black");
}

// Namespace lui/lui_shared
// Params 1, eflags: 0x0
// Checksum 0xce8c2789, Offset: 0x280
// Size: 0x24
function on_player_connect(localclientnum) {
    level thread client_menus(localclientnum);
}

// Namespace lui/lui_shared
// Params 1, eflags: 0x0
// Checksum 0xe4e0fe8e, Offset: 0x2b0
// Size: 0x56
function initmenudata(localclientnum) {
    assert(!isdefined(level.client_menus[localclientnum]));
    level.client_menus[localclientnum] = associativearray();
}

// Namespace lui/lui_shared
// Params 7, eflags: 0x0
// Checksum 0x172896da, Offset: 0x310
// Size: 0x176
function createextracamxcamdata(menu_name, localclientnum, extracam_index, target_name, xcam, sub_xcam, xcam_frame) {
    assert(isdefined(level.client_menus[localclientnum][menu_name]));
    menu_data = level.client_menus[localclientnum][menu_name];
    extracam_data = {#extracam_index:extracam_index, #target_name:target_name, #xcam:xcam, #sub_xcam:sub_xcam, #xcam_frame:xcam_frame};
    if (!isdefined(menu_data.extra_cams)) {
        menu_data.extra_cams = [];
    } else if (!isarray(menu_data.extra_cams)) {
        menu_data.extra_cams = array(menu_data.extra_cams);
    }
    menu_data.extra_cams[menu_data.extra_cams.size] = extracam_data;
}

// Namespace lui/lui_shared
// Params 4, eflags: 0x0
// Checksum 0x8f5998d5, Offset: 0x490
// Size: 0x12e
function createcustomextracamxcamdata(menu_name, localclientnum, extracam_index, camera_function) {
    assert(isdefined(level.client_menus[localclientnum][menu_name]));
    menu_data = level.client_menus[localclientnum][menu_name];
    extracam_data = {#extracam_index:extracam_index, #camera_function:camera_function};
    if (!isdefined(menu_data.extra_cams)) {
        menu_data.extra_cams = [];
    } else if (!isarray(menu_data.extra_cams)) {
        menu_data.extra_cams = array(menu_data.extra_cams);
    }
    menu_data.extra_cams[menu_data.extra_cams.size] = extracam_data;
}

// Namespace lui/lui_shared
// Params 3, eflags: 0x0
// Checksum 0x56b7fa86, Offset: 0x5c8
// Size: 0x1f6
function addmenuexploders(menu_name, localclientnum, exploder) {
    assert(isdefined(level.client_menus[localclientnum][menu_name]));
    menu_data = level.client_menus[localclientnum][menu_name];
    if (isarray(exploder)) {
        foreach (expl in exploder) {
            if (!isdefined(menu_data.exploders)) {
                menu_data.exploders = [];
            } else if (!isarray(menu_data.exploders)) {
                menu_data.exploders = array(menu_data.exploders);
            }
            menu_data.exploders[menu_data.exploders.size] = expl;
        }
        return;
    }
    if (!isdefined(menu_data.exploders)) {
        menu_data.exploders = [];
    } else if (!isarray(menu_data.exploders)) {
        menu_data.exploders = array(menu_data.exploders);
    }
    menu_data.exploders[menu_data.exploders.size] = exploder;
}

// Namespace lui/lui_shared
// Params 3, eflags: 0x0
// Checksum 0xd030a413, Offset: 0x7c8
// Size: 0x156
function linktocustomcharacter(menu_name, localclientnum, target_name) {
    assert(isdefined(level.client_menus[localclientnum][menu_name]));
    menu_data = level.client_menus[localclientnum][menu_name];
    assert(!isdefined(menu_data.custom_character));
    model = getent(localclientnum, target_name, "targetname");
    if (!isdefined(model)) {
        model = util::spawn_model(localclientnum, "tag_origin");
        model.targetname = target_name;
    }
    model useanimtree("all_player");
    menu_data.custom_character = character_customization::function_9de1b403(model, localclientnum);
    model hide();
    return menu_data.custom_character;
}

// Namespace lui/lui_shared
// Params 2, eflags: 0x0
// Checksum 0x97981fac, Offset: 0x928
// Size: 0x52
function getcharacterdataformenu(menu_name, localclientnum) {
    if (isdefined(level.client_menus[localclientnum][menu_name])) {
        return level.client_menus[localclientnum][menu_name].custom_character;
    }
    return undefined;
}

// Namespace lui/lui_shared
// Params 10, eflags: 0x0
// Checksum 0x50eb941a, Offset: 0x988
// Size: 0x17a
function createcameramenu(menu_name, localclientnum, target_name, xcam, sub_xcam, xcam_frame = undefined, var_3122eae6 = undefined, var_dd603074 = undefined, lerp_time = 0, lut_index = 0) {
    assert(!isdefined(level.client_menus[localclientnum][menu_name]));
    level.client_menus[localclientnum][menu_name] = {#target_name:target_name, #xcam:xcam, #sub_xcam:sub_xcam, #xcam_frame:xcam_frame, #var_3122eae6:var_3122eae6, #var_dd603074:var_dd603074, #lerp_time:lerp_time, #lut_index:lut_index};
    return level.client_menus[localclientnum][menu_name];
}

// Namespace lui/lui_shared
// Params 7, eflags: 0x0
// Checksum 0xb141e7be, Offset: 0xb10
// Size: 0x11a
function createcustomcameramenu(menu_name, localclientnum, camera_function, has_state, var_3122eae6 = undefined, var_dd603074 = undefined, lut_index = 0) {
    assert(!isdefined(level.client_menus[localclientnum][menu_name]));
    level.client_menus[localclientnum][menu_name] = {#camera_function:camera_function, #has_state:has_state, #var_3122eae6:var_3122eae6, #var_dd603074:var_dd603074, #lut_index:lut_index};
    return level.client_menus[localclientnum][menu_name];
}

// Namespace lui/lui_shared
// Params 3, eflags: 0x0
// Checksum 0x5e97cc1f, Offset: 0xc38
// Size: 0x7f0
function setup_menu(localclientnum, menu_data, previous_menu) {
    if (isdefined(menu_data)) {
        new_menu = level.client_menus[localclientnum][menu_data.menu_name];
    }
    if (isdefined(previous_menu) && isdefined(level.client_menus[localclientnum][previous_menu.menu_name])) {
        previous_menu_info = level.client_menus[localclientnum][previous_menu.menu_name];
        if (isdefined(previous_menu_info.var_dd603074)) {
            if (isarray(previous_menu_info.var_dd603074)) {
                foreach (fn in previous_menu_info.var_dd603074) {
                    [[ fn ]](localclientnum, previous_menu_info);
                }
            } else {
                [[ previous_menu_info.var_dd603074 ]](localclientnum, previous_menu_info);
            }
        }
        if (isdefined(previous_menu_info.extra_cams)) {
            foreach (extracam_data in previous_menu_info.extra_cams) {
                multi_extracam::extracam_reset_index(localclientnum, extracam_data.extracam_index);
            }
        }
        level notify(previous_menu.menu_name + "_closed");
        if (isdefined(previous_menu_info.camera_function)) {
            stopmaincamxcam(localclientnum);
        } else if (isdefined(previous_menu_info.xcam)) {
            stopmaincamxcam(localclientnum);
        }
        if (isdefined(previous_menu_info.custom_character) && (!isdefined(new_menu) || previous_menu_info.custom_character !== new_menu.custom_character)) {
            [[ previous_menu_info.custom_character ]]->hide_model();
            [[ previous_menu_info.custom_character ]]->function_4f7c691e();
        }
        if (isdefined(previous_menu_info.exploders)) {
            foreach (exploder in previous_menu_info.exploders) {
                killradiantexploder(localclientnum, exploder);
            }
        }
    }
    if (isdefined(new_menu)) {
        if (isdefined(new_menu.custom_character)) {
            [[ new_menu.custom_character ]]->show_model();
        }
        if (isdefined(new_menu.exploders)) {
            foreach (exploder in new_menu.exploders) {
                playradiantexploder(localclientnum, exploder);
            }
        }
        if (isdefined(new_menu.lut_index)) {
            setdvar(#"vc_lut", new_menu.lut_index);
        }
        if (isdefined(new_menu.camera_function)) {
            if (new_menu.has_state === 1) {
                level thread [[ new_menu.camera_function ]](localclientnum, menu_data.menu_name, menu_data.state);
            } else {
                level thread [[ new_menu.camera_function ]](localclientnum, menu_data.menu_name);
            }
        } else if (isdefined(new_menu.xcam)) {
            camera_ent = struct::get(new_menu.target_name);
            if (isdefined(camera_ent)) {
                playmaincamxcam(localclientnum, new_menu.xcam, new_menu.lerp_time, new_menu.sub_xcam, "", camera_ent.origin, camera_ent.angles);
            }
        }
        if (isdefined(new_menu.var_3122eae6)) {
            if (isarray(new_menu.var_3122eae6)) {
                foreach (fn in new_menu.var_3122eae6) {
                    [[ fn ]](localclientnum, new_menu);
                }
            } else {
                if (isdefined(menu_data.charactermode) && isdefined(new_menu.custom_character)) {
                    [[ new_menu.custom_character ]]->set_character_mode(menu_data.charactermode);
                }
                [[ new_menu.var_3122eae6 ]](localclientnum, new_menu);
            }
        }
        if (isdefined(new_menu.extra_cams)) {
            foreach (extracam_data in new_menu.extra_cams) {
                if (isdefined(extracam_data.camera_function)) {
                    if (new_menu.has_state === 1) {
                        level thread [[ extracam_data.camera_function ]](localclientnum, menu_data.menu_name, extracam_data, menu_data.state);
                    } else {
                        level thread [[ extracam_data.camera_function ]](localclientnum, menu_data.menu_name, extracam_data);
                    }
                    continue;
                }
                camera_ent = multi_extracam::extracam_init_index(localclientnum, extracam_data.target_name, extracam_data.extracam_index);
                if (isdefined(camera_ent)) {
                    if (isdefined(extracam_data.xcam_frame)) {
                        camera_ent playextracamxcam(extracam_data.xcam, 0, extracam_data.sub_xcam, extracam_data.xcam_frame);
                        continue;
                    }
                    camera_ent playextracamxcam(extracam_data.xcam, 0, extracam_data.sub_xcam);
                }
            }
        }
    }
}

// Namespace lui/lui_shared
// Params 1, eflags: 0x0
// Checksum 0x783b74c5, Offset: 0x1430
// Size: 0x430
function client_menus(localclientnum) {
    level endon(#"disconnect");
    level.var_d219d19b[localclientnum] = array();
    clientmenustack = level.var_d219d19b[localclientnum];
    while (true) {
        waitresult = level waittill("menu_change" + localclientnum);
        menu_name = waitresult.menu;
        status = waitresult.status;
        state = waitresult.state;
        menu_index = undefined;
        for (i = 0; i < clientmenustack.size; i++) {
            if (clientmenustack[i].menu_name == menu_name) {
                menu_index = i;
                break;
            }
        }
        if (status === "closeToMenu" && isdefined(menu_index)) {
            topmenu = undefined;
            for (i = 0; i < menu_index; i++) {
                popped = array::pop(clientmenustack, 0, 0);
                if (!isdefined(topmenu)) {
                    topmenu = popped;
                }
            }
            setup_menu(localclientnum, clientmenustack[0], topmenu);
            continue;
        }
        statechange = isdefined(menu_index) && status !== "closed" && clientmenustack[menu_index].state !== state && !(!isdefined(clientmenustack[menu_index].state) && !isdefined(state));
        updateonly = statechange && menu_index !== 0;
        if (updateonly) {
            clientmenustack[i].state = state;
            continue;
        }
        if (status === "closed" && isdefined(menu_index)) {
            assert(menu_index == 0);
            popped = array::pop(clientmenustack, 0, 0);
            setup_menu(localclientnum, clientmenustack[0], popped);
            continue;
        }
        if (status === "opened" && !isdefined(menu_index)) {
            menu_data = spawnstruct();
            menu_data.menu_name = menu_name;
            menu_data.state = state;
            if (isdefined(waitresult.mode)) {
                menu_data.charactermode = waitresult.mode;
            }
            lastmenu = clientmenustack.size < 0 ? undefined : clientmenustack[0];
            setup_menu(localclientnum, menu_data, lastmenu);
            array::push_front(clientmenustack, menu_data);
            continue;
        }
        if (isdefined(menu_index) && statechange) {
            assert(menu_index == 0);
            clientmenustack[0].state = state;
            setup_menu(localclientnum, clientmenustack[0], undefined);
        }
    }
}

// Namespace lui/lui_shared
// Params 3, eflags: 0x0
// Checksum 0xa1eedacc, Offset: 0x1868
// Size: 0xa6
function is_current_menu(localclientnum, menu_name, state = undefined) {
    if (!isdefined(level.var_d219d19b[localclientnum]) || level.var_d219d19b[localclientnum].size == 0) {
        return false;
    }
    return level.var_d219d19b[localclientnum][0].menu_name === menu_name && level.var_d219d19b[localclientnum][0].state === state;
}

// Namespace lui/lui_shared
// Params 5, eflags: 0x0
// Checksum 0x95dbcf5b, Offset: 0x1918
// Size: 0x134
function screen_fade(n_time, n_target_alpha = 1, n_start_alpha = 0, str_color = "black", b_force_close_menu = 0) {
    if (self == level) {
        foreach (player in level.players) {
            player thread _screen_fade(n_time, n_target_alpha, n_start_alpha, str_color, b_force_close_menu);
        }
        return;
    }
    self thread _screen_fade(n_time, n_target_alpha, n_start_alpha, str_color, b_force_close_menu);
}

// Namespace lui/lui_shared
// Params 2, eflags: 0x0
// Checksum 0x9e834671, Offset: 0x1a58
// Size: 0x3a
function screen_fade_out(n_time, str_color) {
    screen_fade(n_time, 1, 0, str_color, 0);
    wait n_time;
}

// Namespace lui/lui_shared
// Params 2, eflags: 0x0
// Checksum 0xa1e20dda, Offset: 0x1aa0
// Size: 0x42
function screen_fade_in(n_time, str_color) {
    screen_fade(n_time, 0, 1, str_color, 1);
    wait n_time;
}

// Namespace lui/lui_shared
// Params 0, eflags: 0x0
// Checksum 0x3bf61adf, Offset: 0x1af0
// Size: 0xa4
function screen_close_menu() {
    if (self == level) {
        foreach (player in level.players) {
            player thread _screen_close_menu();
        }
        return;
    }
    self thread _screen_close_menu();
}

// Namespace lui/lui_shared
// Params 0, eflags: 0x4
// Checksum 0x6e95cd0f, Offset: 0x1ba0
// Size: 0xfc
function private _screen_close_menu() {
    self notify(#"_screen_fade");
    self endon(#"_screen_fade");
    self endon(#"disconnect");
    if (isdefined(self.screen_fade_menus)) {
        str_menu = "FullScreenBlack";
        if (isdefined(self.screen_fade_menus[str_menu])) {
            closeluimenu(self.localclientnum, self.screen_fade_menus[str_menu].lui_menu);
            self.screen_fade_menus[str_menu] = undefined;
        }
        str_menu = "FullScreenWhite";
        if (isdefined(self.screen_fade_menus[str_menu])) {
            closeluimenu(self.localclientnum, self.screen_fade_menus[str_menu].lui_menu);
            self.screen_fade_menus[str_menu] = undefined;
        }
    }
}

// Namespace lui/lui_shared
// Params 5, eflags: 0x4
// Checksum 0x3070f527, Offset: 0x1ca8
// Size: 0x3dc
function private _screen_fade(n_time, n_target_alpha, n_start_alpha, v_color, b_force_close_menu) {
    self notify(#"_screen_fade");
    self endon(#"_screen_fade");
    self endon(#"disconnect");
    self endon(#"death");
    if (!isdefined(self.screen_fade_menus)) {
        self.screen_fade_menus = [];
    }
    if (!isdefined(v_color)) {
        v_color = (0, 0, 0);
    }
    n_time_ms = int(int(n_time * 1000));
    str_menu = "FullScreenBlack";
    if (isstring(v_color)) {
        switch (v_color) {
        case #"black":
            v_color = (0, 0, 0);
            break;
        case #"white":
            v_color = (1, 1, 1);
            break;
        default:
            assertmsg("<dev string:x30>");
            break;
        }
    }
    lui_menu = "";
    if (isdefined(self.screen_fade_menus[str_menu])) {
        s_menu = self.screen_fade_menus[str_menu];
        lui_menu = s_menu.lui_menu;
        closeluimenu(self.localclientnum, lui_menu);
        n_start_alpha = lerpfloat(s_menu.n_start_alpha, s_menu.n_target_alpha, gettime() - s_menu.n_start_time);
    }
    lui_menu = createluimenu(self.localclientnum, str_menu);
    self.screen_fade_menus[str_menu] = spawnstruct();
    self.screen_fade_menus[str_menu].lui_menu = lui_menu;
    self.screen_fade_menus[str_menu].n_start_alpha = n_start_alpha;
    self.screen_fade_menus[str_menu].n_target_alpha = n_target_alpha;
    self.screen_fade_menus[str_menu].n_target_time = n_time_ms;
    self.screen_fade_menus[str_menu].n_start_time = gettime();
    self set_color(lui_menu, v_color);
    setluimenudata(self.localclientnum, lui_menu, "startAlpha", n_start_alpha);
    setluimenudata(self.localclientnum, lui_menu, "endAlpha", n_target_alpha);
    setluimenudata(self.localclientnum, lui_menu, "fadeOverTime", n_time_ms);
    openluimenu(self.localclientnum, lui_menu);
    wait n_time;
    if (b_force_close_menu || n_target_alpha == 0) {
        closeluimenu(self.localclientnum, self.screen_fade_menus[str_menu].lui_menu);
        self.screen_fade_menus[str_menu] = undefined;
    }
}

// Namespace lui/lui_shared
// Params 2, eflags: 0x0
// Checksum 0x41e9e076, Offset: 0x2090
// Size: 0xa4
function set_color(menu, color) {
    setluimenudata(self.localclientnum, menu, "red", color[0]);
    setluimenudata(self.localclientnum, menu, "green", color[1]);
    setluimenudata(self.localclientnum, menu, "blue", color[2]);
}

// Namespace lui/lui_shared
// Params 1, eflags: 0x0
// Checksum 0xc9a6d1bf, Offset: 0x2140
// Size: 0x40
function function_c1a676bc(uid) {
    elem = new cluielem();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace lui/lui_shared
// Params 5, eflags: 0x0
// Checksum 0x9b64b626, Offset: 0x2188
// Size: 0x4c
function add_clientfield(field_name, version, bits, type, callback) {
    [[ self ]]->add_clientfield(field_name, version, bits, type, callback);
}

// Namespace lui/lui_shared
// Params 3, eflags: 0x0
// Checksum 0xeb53fa31, Offset: 0x21e0
// Size: 0x34
function function_52818084(var_16dcb09f, field_name, version) {
    [[ self ]]->function_52818084(var_16dcb09f, field_name, version);
}

