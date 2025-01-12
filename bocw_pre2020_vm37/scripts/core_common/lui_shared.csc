#using script_1da833573eb80e61;
#using script_2feaeed9ab01d6f7;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\character_customization;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\multi_extracam;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace lui;

// Namespace lui
// Method(s) 12 Total 12
class cluielem {

    var var_47d8642e;
    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace cluielem/lui_shared
    // Params 0, eflags: 0x9 linked
    // Checksum 0x42c3f029, Offset: 0x25e0
    // Size: 0x1e
    constructor() {
        var_d5213cbb = "";
        var_bf9c8c95 = undefined;
    }

    // Namespace cluielem/lui_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x55340aef, Offset: 0x2be0
    // Size: 0x74
    function open(local_client_num) {
        assert(var_47d8642e, "<dev string:xe3>");
        openluielem(local_client_num, hash(var_d5213cbb), var_bf9c8c95);
        function_fa582112(local_client_num);
    }

    // Namespace cluielem/lui_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0xf0c20689, Offset: 0x2cd0
    // Size: 0x64
    function close(local_client_num) {
        assert(var_47d8642e, "<dev string:x125>");
        closeluielem(local_client_num, hash(var_d5213cbb), var_bf9c8c95);
    }

    // Namespace cluielem/lui_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0xb6accf50, Offset: 0x2ab8
    // Size: 0xda
    function register_clientside(menu_name) {
        if (!isdefined(level.var_c6881a61)) {
            level.var_c6881a61 = associativearray();
        }
        if (!isdefined(level.var_c6881a61[hash(menu_name)])) {
            level.var_c6881a61[hash(menu_name)] = 0;
        }
        var_d5213cbb = menu_name;
        var_bf9c8c95 = level.var_c6881a61[hash(menu_name)];
        level.var_c6881a61[hash(menu_name)]++;
        var_47d8642e = 1;
    }

    // Namespace cluielem/lui_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0xce8c204e, Offset: 0x2608
    // Size: 0xda
    function setup_clientfields(menu_name) {
        if (!isdefined(level.var_f70b6db)) {
            level.var_f70b6db = associativearray();
        }
        if (!isdefined(level.var_f70b6db[hash(menu_name)])) {
            level.var_f70b6db[hash(menu_name)] = 0;
        }
        var_d5213cbb = menu_name;
        var_bf9c8c95 = level.var_f70b6db[hash(menu_name)];
        level.var_f70b6db[hash(menu_name)]++;
        var_47d8642e = 0;
    }

    // Namespace cluielem/lui_shared
    // Params 2, eflags: 0x1 linked
    // Checksum 0x891d4565, Offset: 0x2dc8
    // Size: 0x6a
    function get_data(local_client_num, field) {
        assert(var_47d8642e, "<dev string:x167>");
        return function_88759655(local_client_num, hash(var_d5213cbb), var_bf9c8c95, field);
    }

    // Namespace cluielem/lui_shared
    // Params 3, eflags: 0x1 linked
    // Checksum 0xd987d23a, Offset: 0x2d40
    // Size: 0x7c
    function set_data(local_client_num, field, value) {
        assert(var_47d8642e, "<dev string:x167>");
        function_bcc2134a(local_client_num, hash(var_d5213cbb), var_bf9c8c95, field, value);
    }

    // Namespace cluielem/lui_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x2c1a025a, Offset: 0x2c60
    // Size: 0x62
    function is_open(local_client_num) {
        assert(var_47d8642e, "<dev string:xe3>");
        return isluielemopen(local_client_num, hash(var_d5213cbb), var_bf9c8c95);
    }

    // Namespace cluielem/lui_shared
    // Params 5, eflags: 0x1 linked
    // Checksum 0x78d13fec, Offset: 0x26f0
    // Size: 0x1e4
    function add_clientfield(field_name, version, bits, type, callback) {
        assert(!var_47d8642e, "<dev string:x5e>");
        var_8e016f22 = strtok(field_name, ".");
        var_2637b994 = [];
        foreach (field in var_8e016f22) {
            if (!isdefined(var_2637b994)) {
                var_2637b994 = [];
            } else if (!isarray(var_2637b994)) {
                var_2637b994 = array(var_2637b994);
            }
            var_2637b994[var_2637b994.size] = hash(field);
        }
        clientfield::register_luielem("luielement." + var_d5213cbb + "." + (isdefined(var_bf9c8c95) ? "" + var_bf9c8c95 : "") + field_name, hash(var_d5213cbb), var_bf9c8c95, var_2637b994, version, bits, type, callback, 0, 0);
    }

    // Namespace cluielem/lui_shared
    // Params 3, eflags: 0x1 linked
    // Checksum 0x6018259b, Offset: 0x28e0
    // Size: 0x1cc
    function function_dcb34c80(var_2a0de052, field_name, version) {
        assert(!var_47d8642e, "<dev string:x5e>");
        var_8e016f22 = strtok(field_name, ".");
        var_2637b994 = [];
        foreach (field in var_8e016f22) {
            if (!isdefined(var_2637b994)) {
                var_2637b994 = [];
            } else if (!isarray(var_2637b994)) {
                var_2637b994 = array(var_2637b994);
            }
            var_2637b994[var_2637b994.size] = hash(field);
        }
        clientfield::function_b63c5dfe(var_2a0de052, "luielement." + var_d5213cbb + "." + (isdefined(var_bf9c8c95) ? "" + var_bf9c8c95 : "") + field_name, hash(var_d5213cbb), var_bf9c8c95, var_2637b994, version, undefined, 0, 0);
    }

    // Namespace cluielem/lui_shared
    // Params 1, eflags: 0x1 linked
    // Checksum 0x48258645, Offset: 0x2ba0
    // Size: 0x34
    function function_fa582112(*local_client_num) {
        assert(var_47d8642e, "<dev string:x9e>");
    }

}

// Namespace lui/lui_shared
// Params 0, eflags: 0x6
// Checksum 0xf5858a05, Offset: 0x168
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"lui_shared", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace lui/lui_shared
// Params 0, eflags: 0x5 linked
// Checksum 0xf9a2d3ba, Offset: 0x1b0
// Size: 0x5c
function private function_70a657d8() {
    level.client_menus = [];
    level.var_a14cc36b = [];
    callback::on_localclient_connect(&on_player_connect);
    full_screen_black::register();
    initial_black::register();
}

// Namespace lui/lui_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x64700451, Offset: 0x218
// Size: 0x24
function on_player_connect(local_client_num) {
    level thread client_menus(local_client_num);
}

// Namespace lui/lui_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x2908ae82, Offset: 0x248
// Size: 0x50
function function_2888ee3c(local_client_num) {
    assert(!isdefined(level.client_menus[local_client_num]));
    level.client_menus[local_client_num] = associativearray();
}

// Namespace lui/lui_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x8e2197a3, Offset: 0x2a0
// Size: 0x98
function function_6f3e10a2(local_client_num, var_c12be4a6) {
    if (!isdefined(var_c12be4a6)) {
        return undefined;
    }
    data = function_63446d7f(local_client_num, var_c12be4a6);
    if (isdefined(data) && isdefined(var_c12be4a6.state)) {
        data = isdefined(data.states[var_c12be4a6.state]) ? data.states[var_c12be4a6.state] : data;
    }
    return data;
}

// Namespace lui/lui_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x734f0f16, Offset: 0x340
// Size: 0x3a
function function_63446d7f(local_client_num, var_c12be4a6) {
    if (!isdefined(var_c12be4a6)) {
        return undefined;
    }
    return level.client_menus[local_client_num][var_c12be4a6.menu_name];
}

// Namespace lui/lui_shared
// Params 4, eflags: 0x1 linked
// Checksum 0x26501e78, Offset: 0x388
// Size: 0x156
function function_1337c436(menu_name, local_client_num, target_name, alt_render_mode = 1) {
    assert(isdefined(level.client_menus[local_client_num][menu_name]));
    menu_data = level.client_menus[local_client_num][menu_name];
    assert(!isdefined(menu_data.custom_character));
    model = getent(local_client_num, target_name, "targetname");
    if (!isdefined(model)) {
        model = util::spawn_model(local_client_num, "tag_origin");
        model.targetname = target_name;
    }
    model useanimtree("all_player");
    menu_data.custom_character = character_customization::function_dd295310(model, local_client_num, alt_render_mode);
    model hide();
    return menu_data.custom_character;
}

// Namespace lui/lui_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x85d01855, Offset: 0x4e8
// Size: 0x4a
function function_daadc836(menu_name, local_client_num) {
    if (isdefined(level.client_menus[local_client_num][menu_name])) {
        return level.client_menus[local_client_num][menu_name].custom_character;
    }
    return undefined;
}

// Namespace lui/lui_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x50362cda, Offset: 0x540
// Size: 0x5a
function function_e41243c1(var_e953aca6) {
    if (!isdefined(var_e953aca6)) {
        return array();
    } else if (isarray(var_e953aca6)) {
        return var_e953aca6;
    }
    return array(var_e953aca6);
}

// Namespace lui/lui_shared
// Params 10, eflags: 0x1 linked
// Checksum 0xa0e8dc3a, Offset: 0x5a8
// Size: 0x1b6
function function_f603fc4d(menu_name, local_client_num, target_name, xcam, sub_xcam, xcam_frame = undefined, var_1f199068 = undefined, var_2c679be0 = undefined, lerp_time = 0, lut_index = 0) {
    assert(!isdefined(level.client_menus[local_client_num][menu_name]));
    level.client_menus[local_client_num][menu_name] = {#menu_name:menu_name, #target_name:target_name, #xcam:xcam, #sub_xcam:sub_xcam, #xcam_frame:xcam_frame, #var_1f199068:function_e41243c1(var_1f199068), #var_2c679be0:function_e41243c1(var_2c679be0), #lerp_time:lerp_time, #lut_index:lut_index, #var_e57ed98b:[]};
    return level.client_menus[local_client_num][menu_name];
}

// Namespace lui/lui_shared
// Params 9, eflags: 0x1 linked
// Checksum 0x9103057e, Offset: 0x768
// Size: 0x12c
function function_460e6001(menu_name, local_client_num, session_mode, target_name, xcam, sub_xcam, xcam_frame = undefined, lerp_time = 0, lut_index = 0) {
    assert(isdefined(level.client_menus[local_client_num][menu_name]));
    level.client_menus[local_client_num][menu_name].var_e57ed98b[session_mode] = {#target_name:target_name, #xcam:xcam, #sub_xcam:sub_xcam, #xcam_frame:xcam_frame, #lerp_time:lerp_time, #lut_index:lut_index};
}

// Namespace lui/lui_shared
// Params 8, eflags: 0x1 linked
// Checksum 0x8995a86, Offset: 0x8a0
// Size: 0x166
function function_969a2881(menu_name, local_client_num, camera_function, has_state, var_1f199068 = undefined, var_2c679be0 = undefined, lut_index = 0, var_ef0a4d1e) {
    assert(!isdefined(level.client_menus[local_client_num][menu_name]));
    level.client_menus[local_client_num][menu_name] = {#menu_name:menu_name, #camera_function:camera_function, #has_state:has_state, #var_1f199068:function_e41243c1(var_1f199068), #var_2c679be0:function_e41243c1(var_2c679be0), #lut_index:lut_index, #var_ef0a4d1e:var_ef0a4d1e};
    return level.client_menus[local_client_num][menu_name];
}

// Namespace lui/lui_shared
// Params 6, eflags: 0x1 linked
// Checksum 0x548cdf62, Offset: 0xa10
// Size: 0x11e
function function_6425472c(menu_name, local_client_num, str_scene, var_f647c5b2 = undefined, var_559c5c3e = undefined, var_3e7fd594 = undefined) {
    assert(!isdefined(level.client_menus[local_client_num][menu_name]));
    level.client_menus[local_client_num][menu_name] = {#menu_name:menu_name, #str_scene:str_scene, #var_f647c5b2:var_f647c5b2, #var_559c5c3e:var_559c5c3e, #var_3e7fd594:var_3e7fd594, #states:[], #var_b80d1ad4:[]};
    return level.client_menus[local_client_num][menu_name];
}

// Namespace lui/lui_shared
// Params 3, eflags: 0x1 linked
// Checksum 0xfb5f5546, Offset: 0xb38
// Size: 0x6a
function function_17384292(menu_name, local_client_num, callback_fn) {
    assert(isdefined(level.client_menus[local_client_num][menu_name]));
    level.client_menus[local_client_num][menu_name].var_a362e358 = callback_fn;
}

// Namespace lui/lui_shared
// Params 7, eflags: 0x1 linked
// Checksum 0xc174f59, Offset: 0xbb0
// Size: 0x114
function function_866692f8(menu_name, local_client_num, state, str_scene, var_f647c5b2 = undefined, var_559c5c3e = undefined, var_3e7fd594 = undefined) {
    assert(isdefined(level.client_menus[local_client_num][menu_name]));
    level.client_menus[local_client_num][menu_name].states[state] = {#menu_name:menu_name, #str_scene:str_scene, #var_f647c5b2:var_f647c5b2, #var_559c5c3e:var_559c5c3e, #var_3e7fd594:var_3e7fd594, #var_b80d1ad4:[]};
}

// Namespace lui/lui_shared
// Params 5, eflags: 0x1 linked
// Checksum 0x25f67ff6, Offset: 0xcd0
// Size: 0x120
function function_8950260c(menu_name, local_client_num, from_state = "__default__", to_state = "__default__", str_shot) {
    assert(from_state !== to_state);
    assert(isdefined(level.client_menus[local_client_num][menu_name]));
    menu = level.client_menus[local_client_num][menu_name];
    if (from_state != "__default__" && isdefined(menu.states[from_state])) {
        menu.states[from_state].var_b80d1ad4[to_state] = str_shot;
        return;
    }
    menu.states.var_b80d1ad4[to_state] = str_shot;
}

// Namespace lui/lui_shared
// Params 3, eflags: 0x1 linked
// Checksum 0xba18a9b5, Offset: 0xdf8
// Size: 0xa8
function function_ffa1213e(local_client_num, var_8de6b51a, var_e3315405) {
    var_cd1475a5 = function_6f3e10a2(local_client_num, var_8de6b51a);
    new_menu = function_6f3e10a2(local_client_num, var_e3315405);
    if (var_cd1475a5.menu_name === new_menu.menu_name) {
        return var_cd1475a5.var_b80d1ad4[isdefined(var_e3315405.state) ? var_e3315405.state : "__default__"];
    }
    return undefined;
}

// Namespace lui/lui_shared
// Params 3, eflags: 0x1 linked
// Checksum 0xe164518c, Offset: 0xea8
// Size: 0x674
function setup_menu(local_client_num, var_8de6b51a, var_e3315405) {
    var_cd1475a5 = function_6f3e10a2(local_client_num, var_8de6b51a);
    var_a8080f41 = function_6f3e10a2(local_client_num, var_8de6b51a);
    new_menu = function_6f3e10a2(local_client_num, var_e3315405);
    var_f81682ee = function_63446d7f(local_client_num, var_e3315405);
    var_fdb39764 = var_cd1475a5.menu_name === new_menu.menu_name;
    var_d2bf9838 = var_cd1475a5.str_scene !== level.var_6dfc0bcf;
    if (isdefined(var_cd1475a5)) {
        if (!var_fdb39764) {
            if (isdefined(var_a8080f41.var_2c679be0)) {
                foreach (fn in var_a8080f41.var_2c679be0) {
                    if (is_true(var_a8080f41.var_ef0a4d1e)) {
                        level [[ fn ]](local_client_num, var_a8080f41);
                        continue;
                    }
                    level thread [[ fn ]](local_client_num, var_a8080f41);
                }
            }
            if (!var_fdb39764 && isdefined(var_cd1475a5.str_scene) && var_d2bf9838) {
                outro = isdefined(var_cd1475a5.var_3e7fd594) ? var_cd1475a5.var_3e7fd594 : var_a8080f41.var_3e7fd594;
                if (isdefined(outro)) {
                    function_7851a662(var_cd1475a5, outro);
                } else {
                    function_4c61e7c(var_cd1475a5);
                }
            }
            level notify(var_8de6b51a.menu_name + "_closed");
            if (isdefined(var_a8080f41.camera_function)) {
                stopmaincamxcam(local_client_num);
            } else if (isdefined(var_a8080f41.xcam)) {
                stopmaincamxcam(local_client_num);
            }
            if (isdefined(var_a8080f41.custom_character) && var_a8080f41.custom_character !== var_f81682ee.custom_character) {
                [[ var_a8080f41.custom_character ]]->hide_model();
                [[ var_a8080f41.custom_character ]]->function_39a68bf2();
            }
        }
    }
    if (isdefined(new_menu)) {
        if (isdefined(var_e3315405.charactermode) && isdefined(var_e3315405.custom_character)) {
            [[ var_f81682ee.custom_character ]]->set_character_mode(var_e3315405.charactermode);
        }
        if (var_fdb39764) {
            if (isdefined(var_f81682ee.var_a362e358)) {
                level thread [[ var_f81682ee.var_a362e358 ]](local_client_num, var_e3315405.menu_name, var_e3315405.state);
            }
            if (isdefined(new_menu.str_scene)) {
                level thread function_4e55f369(local_client_num, var_8de6b51a, var_e3315405);
            } else if (isdefined(new_menu.camera_function)) {
                level thread [[ new_menu.camera_function ]](local_client_num, var_e3315405.menu_name, var_e3315405.state);
            }
            return;
        }
        if (isdefined(var_f81682ee.custom_character)) {
            [[ var_f81682ee.custom_character ]]->show_model();
        }
        if (isdefined(var_f81682ee.lut_index)) {
            setdvar(#"vc_lut", var_f81682ee.lut_index);
        }
        if (isdefined(var_f81682ee.camera_function)) {
            if (var_f81682ee.has_state === 1) {
                level thread [[ var_f81682ee.camera_function ]](local_client_num, var_e3315405.menu_name, var_e3315405.state);
            } else {
                level thread [[ var_f81682ee.camera_function ]](local_client_num, var_e3315405.menu_name);
            }
        } else if (isdefined(var_f81682ee.xcam)) {
            camera_data = isdefined(var_f81682ee.var_e57ed98b[currentsessionmode()]) ? var_f81682ee.var_e57ed98b[currentsessionmode()] : var_f81682ee;
            camera_ent = struct::get(camera_data.target_name);
            if (isdefined(camera_ent)) {
                playmaincamxcam(local_client_num, camera_data.xcam, camera_data.lerp_time, camera_data.sub_xcam, "", camera_ent.origin, camera_ent.angles);
            }
        }
        if (isdefined(new_menu.str_scene) && new_menu.var_559c5c3e !== var_cd1475a5.var_559c5c3e) {
            level thread function_4aa3b942(new_menu);
        }
        if (isdefined(var_f81682ee.var_1f199068)) {
            foreach (fn in var_f81682ee.var_1f199068) {
                level thread [[ fn ]](local_client_num, var_f81682ee);
            }
        }
    }
}

// Namespace lui/lui_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xd4ce9276, Offset: 0x1528
// Size: 0x428
function client_menus(local_client_num) {
    level endon(#"disconnect");
    level.var_a14cc36b[local_client_num] = [];
    clientmenustack = level.var_a14cc36b[local_client_num];
    while (true) {
        waitresult = level waittill("menu_change" + local_client_num);
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
            setup_menu(local_client_num, topmenu, clientmenustack[0]);
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
            if (menu_index == 0) {
                popped = array::pop(clientmenustack, 0, 0);
                setup_menu(local_client_num, popped, clientmenustack[0]);
            }
            continue;
        }
        if (status === "opened" && !isdefined(menu_index)) {
            menu_data = {#menu_name:menu_name, #state:state, #charactermode:waitresult.mode};
            lastmenu = clientmenustack.size < 0 ? undefined : clientmenustack[0];
            setup_menu(local_client_num, lastmenu, menu_data);
            array::push_front(clientmenustack, menu_data);
            continue;
        }
        if (isdefined(menu_index) && statechange) {
            assert(menu_index == 0);
            var_80c09ee8 = clientmenustack[0];
            clientmenustack[0] = {#menu_name:menu_name, #state:state, #charactermode:waitresult.mode};
            setup_menu(local_client_num, var_80c09ee8, clientmenustack[0]);
        }
    }
}

// Namespace lui/lui_shared
// Params 4, eflags: 0x1 linked
// Checksum 0xed72d7bc, Offset: 0x1958
// Size: 0x1dc
function function_befcd4f0(str_scene, var_f647c5b2 = undefined, var_559c5c3e = undefined, var_472bee8f = undefined) {
    assert(!isdefined(var_f647c5b2) || scene::function_9730988a(str_scene, var_f647c5b2));
    assert(!isdefined(var_559c5c3e) || scene::function_9730988a(str_scene, var_559c5c3e));
    level notify(#"hash_46855140938f532c");
    level endon(#"hash_46855140938f532c");
    if (isdefined(var_472bee8f)) {
        level endon(var_472bee8f);
    }
    if (level.var_6dfc0bcf !== str_scene) {
        level scene::stop(level.var_6dfc0bcf, 1);
    } else if (isdefined(level.var_6dfc0bcf)) {
        level scene::cancel(level.var_6dfc0bcf);
    }
    level.var_6dfc0bcf = str_scene;
    if (isdefined(var_f647c5b2)) {
        level scene::play(str_scene, var_f647c5b2);
    }
    if (isdefined(var_559c5c3e)) {
        level thread scene::play(str_scene, var_559c5c3e);
        return;
    }
    level thread scene::play(str_scene);
}

// Namespace lui/lui_shared
// Params 4, eflags: 0x0
// Checksum 0x7caf3d90, Offset: 0x1b40
// Size: 0x94
function function_5993fa03(str_scene, str_shot, time, var_472bee8f = undefined) {
    level notify(#"hash_46855140938f532c");
    level endon(#"hash_46855140938f532c");
    if (isdefined(var_472bee8f)) {
        level endon(var_472bee8f);
    }
    level thread scene::play_from_time(str_scene, str_shot, undefined, time, 1, 1);
}

// Namespace lui/lui_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xcaa11512, Offset: 0x1be0
// Size: 0x4c
function function_4aa3b942(new_menu) {
    function_befcd4f0(new_menu.str_scene, new_menu.var_f647c5b2, new_menu.var_559c5c3e, new_menu.menu_name + "_closed");
}

// Namespace lui/lui_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xf9ed5088, Offset: 0x1c38
// Size: 0x44
function function_7851a662(var_cd1475a5, shot) {
    function_befcd4f0(var_cd1475a5.str_scene, shot, undefined, var_cd1475a5.menu_name + "_closed");
}

// Namespace lui/lui_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xe891b1cc, Offset: 0x1c88
// Size: 0x84
function function_4c61e7c(var_cd1475a5) {
    level notify(#"hash_46855140938f532c");
    level endon(var_cd1475a5.menu_name + "_closed");
    level endon(#"hash_46855140938f532c");
    level.var_6dfc0bcf = undefined;
    level scene::stop(var_cd1475a5.str_scene, 1);
}

// Namespace lui/lui_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x36a600e2, Offset: 0x1d18
// Size: 0x13c
function function_4e55f369(local_client_num, var_8de6b51a, var_e3315405) {
    level notify(#"hash_46855140938f532c");
    new_menu = function_6f3e10a2(local_client_num, var_e3315405);
    var_ffb43fb8 = function_ffa1213e(local_client_num, var_8de6b51a, var_e3315405);
    if (isdefined(var_ffb43fb8)) {
        level endon(#"hash_46855140938f532c");
        level endon(new_menu.menu_name + "_closed");
        level scene::play(new_menu.str_scene, var_ffb43fb8);
        return;
    }
    var_cd1475a5 = function_6f3e10a2(local_client_num, var_8de6b51a);
    if (var_cd1475a5.str_scene !== new_menu.str_scene) {
        new_menu = function_6f3e10a2(local_client_num, var_e3315405);
        function_4aa3b942(new_menu);
    }
}

// Namespace lui/lui_shared
// Params 3, eflags: 0x1 linked
// Checksum 0xe0c6dae6, Offset: 0x1e60
// Size: 0xb4
function is_current_menu(local_client_num, menu_name, state = undefined) {
    if (!isdefined(level.var_a14cc36b[local_client_num]) || level.var_a14cc36b[local_client_num].size == 0) {
        return false;
    }
    return level.var_a14cc36b[local_client_num][0].menu_name === menu_name && (!isdefined(state) || level.var_a14cc36b[local_client_num][0].state === state);
}

// Namespace lui/lui_shared
// Params 5, eflags: 0x1 linked
// Checksum 0xf7426486, Offset: 0x1f20
// Size: 0x12c
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
// Params 2, eflags: 0x1 linked
// Checksum 0x4e45b6c3, Offset: 0x2058
// Size: 0x3a
function screen_fade_out(n_time, str_color) {
    screen_fade(n_time, 1, 0, str_color, 0);
    wait n_time;
}

// Namespace lui/lui_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x197e277, Offset: 0x20a0
// Size: 0x42
function screen_fade_in(n_time, str_color) {
    screen_fade(n_time, 0, 1, str_color, 1);
    wait n_time;
}

// Namespace lui/lui_shared
// Params 0, eflags: 0x0
// Checksum 0xf26521d0, Offset: 0x20f0
// Size: 0xb4
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
// Params 0, eflags: 0x5 linked
// Checksum 0x2c784578, Offset: 0x21b0
// Size: 0x68
function private _screen_close_menu() {
    self notify(#"_screen_fade");
    self endon(#"_screen_fade");
    self endon(#"disconnect");
    if (isdefined(self.full_screen_black)) {
        [[ self.full_screen_black.lui_menu ]]->close(self.localclientnum);
    }
}

// Namespace lui/lui_shared
// Params 5, eflags: 0x5 linked
// Checksum 0x9e004c3d, Offset: 0x2220
// Size: 0x3b4
function private _screen_fade(n_time, n_target_alpha, n_start_alpha, v_color, b_force_close_menu) {
    self notify(#"_screen_fade");
    self endon(#"_screen_fade");
    self endon(#"disconnect");
    self endon(#"death");
    if (!isdefined(v_color)) {
        v_color = (0, 0, 0);
    }
    n_time_ms = int(int(n_time * 1000));
    str_menu = "full_screen_black";
    if (isstring(v_color)) {
        switch (v_color) {
        case #"black":
            v_color = (0, 0, 0);
            break;
        case #"white":
            v_color = (1, 1, 1);
            break;
        default:
            assertmsg("<dev string:x38>");
            break;
        }
    }
    lui_menu = "";
    if (isdefined(self.full_screen_black)) {
        s_menu = self.full_screen_black;
        [[ s_menu.lui_menu ]]->close(self.localclientnum);
        n_start_alpha = lerpfloat(s_menu.n_start_alpha, s_menu.n_target_alpha, gettime() - s_menu.n_start_time);
    } else {
        self.full_screen_black = spawnstruct();
        self.full_screen_black.lui_menu = full_screen_black::register_clientside();
    }
    self.full_screen_black.n_start_alpha = n_start_alpha;
    self.full_screen_black.n_target_alpha = n_target_alpha;
    self.full_screen_black.n_target_time = n_time_ms;
    self.full_screen_black.n_start_time = gettime();
    [[ self.full_screen_black.lui_menu ]]->open(self.localclientnum);
    [[ self.full_screen_black.lui_menu ]]->set_red(self.localclientnum, v_color[0]);
    [[ self.full_screen_black.lui_menu ]]->set_green(self.localclientnum, v_color[1]);
    [[ self.full_screen_black.lui_menu ]]->set_blue(self.localclientnum, v_color[2]);
    [[ self.full_screen_black.lui_menu ]]->set_startalpha(self.localclientnum, n_start_alpha);
    [[ self.full_screen_black.lui_menu ]]->set_endalpha(self.localclientnum, n_target_alpha);
    [[ self.full_screen_black.lui_menu ]]->set_fadeovertime(self.localclientnum, n_time_ms);
    wait n_time;
    if (b_force_close_menu || n_target_alpha == 0) {
        [[ self.full_screen_black.lui_menu ]]->close(self.localclientnum);
    }
}

// Namespace lui/lui_shared
// Params 2, eflags: 0x0
// Checksum 0x80ff5872, Offset: 0x30b8
// Size: 0xc4
function function_ca036b2c(local_client_num, name) {
    var_cad692a8 = getentarray(local_client_num, name, "targetname");
    foreach (trigger in var_cad692a8) {
        trigger function_c06a8682(local_client_num);
    }
    return var_cad692a8;
}

