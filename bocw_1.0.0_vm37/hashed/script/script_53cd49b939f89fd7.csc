#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\character_customization;
#using scripts\core_common\custom_class;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace lui_camera;

// Namespace lui_camera/lui_camera
// Params 0, eflags: 0x6
// Checksum 0xb8bc4088, Offset: 0x120
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"lui_camera", &preinit, undefined, undefined, undefined);
}

// Namespace lui_camera/lui_camera
// Params 0, eflags: 0x4
// Checksum 0xca495b8a, Offset: 0x168
// Size: 0x4c
function private preinit() {
    level.client_menus = associativearray();
    level.var_a14cc36b = [];
    callback::on_localclient_connect(&on_player_connect);
}

// Namespace lui_camera/lui_camera
// Params 1, eflags: 0x0
// Checksum 0xbc5be3f8, Offset: 0x1c0
// Size: 0x24
function on_player_connect(local_client_num) {
    level thread client_menus(local_client_num);
}

// Namespace lui_camera/lui_camera
// Params 1, eflags: 0x0
// Checksum 0x7fe1165e, Offset: 0x1f0
// Size: 0x88
function function_6f3e10a2(var_c12be4a6) {
    if (!isdefined(var_c12be4a6)) {
        return undefined;
    }
    data = function_63446d7f(var_c12be4a6);
    if (isdefined(data) && isdefined(var_c12be4a6.state)) {
        data = isdefined(data.states[var_c12be4a6.state]) ? data.states[var_c12be4a6.state] : data;
    }
    return data;
}

// Namespace lui_camera/lui_camera
// Params 1, eflags: 0x0
// Checksum 0x17e5c23e, Offset: 0x280
// Size: 0x2c
function function_63446d7f(var_c12be4a6) {
    if (!isdefined(var_c12be4a6)) {
        return undefined;
    }
    return level.client_menus[var_c12be4a6.menu_name];
}

// Namespace lui_camera/lui_camera
// Params 3, eflags: 0x0
// Checksum 0x1a0b514a, Offset: 0x2b8
// Size: 0xae
function function_1337c436(menu_name, target_name, alt_render_mode = 1) {
    assert(isdefined(level.client_menus[menu_name]));
    menu_data = level.client_menus[menu_name];
    assert(!isdefined(menu_data.var_cf15815a));
    menu_data.var_cf15815a = target_name;
    menu_data.var_c27fdce9 = alt_render_mode;
}

// Namespace lui_camera/lui_camera
// Params 2, eflags: 0x0
// Checksum 0xdad461fc, Offset: 0x370
// Size: 0x140
function function_daadc836(menu_name, local_client_num) {
    if (isdefined(menu_name)) {
        menu_data = level.client_menus[menu_name];
        character = menu_data.custom_characters[local_client_num];
        if (!isdefined(character) && isdefined(menu_data.var_cf15815a)) {
            model = getent(local_client_num, menu_data.var_cf15815a, "targetname");
            if (!isdefined(model)) {
                model = util::spawn_model(local_client_num, "tag_origin");
                model.targetname = menu_data.var_cf15815a;
            }
            model useanimtree("all_player");
            menu_data.custom_characters[local_client_num] = character_customization::function_dd295310(model, local_client_num, menu_data.var_c27fdce9);
            model hide();
            character = menu_data.custom_characters[local_client_num];
        }
    }
    return character;
}

// Namespace lui_camera/lui_camera
// Params 1, eflags: 0x0
// Checksum 0x44b982a7, Offset: 0x4b8
// Size: 0x5a
function function_e41243c1(var_e953aca6) {
    if (!isdefined(var_e953aca6)) {
        return array();
    } else if (isarray(var_e953aca6)) {
        return var_e953aca6;
    }
    return array(var_e953aca6);
}

// Namespace lui_camera/lui_camera
// Params 9, eflags: 0x0
// Checksum 0x3b20cb62, Offset: 0x520
// Size: 0x1ac
function function_f603fc4d(menu_name, target_name, xcam, sub_xcam, xcam_frame = undefined, var_1f199068 = undefined, var_2c679be0 = undefined, lerp_time = 0, lut_index = 0) {
    assert(!isdefined(level.client_menus[menu_name]));
    level.client_menus[menu_name] = {#menu_name:menu_name, #target_name:target_name, #xcam:xcam, #sub_xcam:sub_xcam, #xcam_frame:xcam_frame, #var_1f199068:function_e41243c1(var_1f199068), #var_2c679be0:function_e41243c1(var_2c679be0), #lerp_time:lerp_time, #lut_index:lut_index, #var_e57ed98b:[]};
    return level.client_menus[menu_name];
}

// Namespace lui_camera/lui_camera
// Params 8, eflags: 0x0
// Checksum 0x9c12ea38, Offset: 0x6d8
// Size: 0x118
function function_460e6001(menu_name, session_mode, target_name, xcam, sub_xcam, xcam_frame = undefined, lerp_time = 0, lut_index = 0) {
    assert(isdefined(level.client_menus[menu_name]));
    level.client_menus[menu_name].var_e57ed98b[session_mode] = {#target_name:target_name, #xcam:xcam, #sub_xcam:sub_xcam, #xcam_frame:xcam_frame, #lerp_time:lerp_time, #lut_index:lut_index};
}

// Namespace lui_camera/lui_camera
// Params 7, eflags: 0x0
// Checksum 0xd369f3b4, Offset: 0x7f8
// Size: 0x154
function function_969a2881(menu_name, camera_function, has_state, var_1f199068 = undefined, var_2c679be0 = undefined, lut_index = 0, var_ef0a4d1e) {
    assert(!isdefined(level.client_menus[menu_name]));
    level.client_menus[menu_name] = {#menu_name:menu_name, #camera_function:camera_function, #has_state:has_state, #var_1f199068:function_e41243c1(var_1f199068), #var_2c679be0:function_e41243c1(var_2c679be0), #lut_index:lut_index, #var_ef0a4d1e:var_ef0a4d1e};
    return level.client_menus[menu_name];
}

// Namespace lui_camera/lui_camera
// Params 5, eflags: 0x0
// Checksum 0x1d29a01a, Offset: 0x958
// Size: 0x10c
function function_6425472c(menu_name, str_scene, var_f647c5b2 = undefined, var_559c5c3e = undefined, var_3e7fd594 = undefined) {
    assert(!isdefined(level.client_menus[menu_name]));
    level.client_menus[menu_name] = {#menu_name:menu_name, #str_scene:str_scene, #var_f647c5b2:var_f647c5b2, #var_559c5c3e:var_559c5c3e, #var_3e7fd594:var_3e7fd594, #states:[], #var_b80d1ad4:[]};
    return level.client_menus[menu_name];
}

// Namespace lui_camera/lui_camera
// Params 2, eflags: 0x0
// Checksum 0xc7ab76f0, Offset: 0xa70
// Size: 0x56
function function_17384292(menu_name, callback_fn) {
    assert(isdefined(level.client_menus[menu_name]));
    level.client_menus[menu_name].var_a362e358 = callback_fn;
}

// Namespace lui_camera/lui_camera
// Params 6, eflags: 0x0
// Checksum 0x9919c4f, Offset: 0xad0
// Size: 0x100
function function_866692f8(menu_name, state, str_scene, var_f647c5b2 = undefined, var_559c5c3e = undefined, var_3e7fd594 = undefined) {
    assert(isdefined(level.client_menus[menu_name]));
    level.client_menus[menu_name].states[state] = {#menu_name:menu_name, #str_scene:str_scene, #var_f647c5b2:var_f647c5b2, #var_559c5c3e:var_559c5c3e, #var_3e7fd594:var_3e7fd594, #var_b80d1ad4:[]};
}

// Namespace lui_camera/lui_camera
// Params 3, eflags: 0x0
// Checksum 0x2e91ab49, Offset: 0xbd8
// Size: 0xd6
function function_f852c52c(menu_name, state_name = undefined, var_a180b828 = 1) {
    assert(isdefined(level.client_menus[menu_name]));
    if (isdefined(state_name)) {
        assert(isdefined(level.client_menus[menu_name].states[state_name]));
        level.client_menus[menu_name].states[state_name].var_b2ad82eb = var_a180b828;
        return;
    }
    level.client_menus[menu_name].var_b2ad82eb = var_a180b828;
}

// Namespace lui_camera/lui_camera
// Params 4, eflags: 0x0
// Checksum 0x171663a0, Offset: 0xcb8
// Size: 0x10c
function function_8950260c(menu_name, from_state = "__default__", to_state = "__default__", str_shot) {
    assert(from_state !== to_state);
    assert(isdefined(level.client_menus[menu_name]));
    menu = level.client_menus[menu_name];
    if (from_state != "__default__" && isdefined(menu.states[from_state])) {
        menu.states[from_state].var_b80d1ad4[to_state] = str_shot;
        return;
    }
    menu.states.var_b80d1ad4[to_state] = str_shot;
}

// Namespace lui_camera/lui_camera
// Params 2, eflags: 0x0
// Checksum 0xccf4e27e, Offset: 0xdd0
// Size: 0xa0
function function_ffa1213e(var_8de6b51a, var_e3315405) {
    var_cd1475a5 = function_6f3e10a2(var_8de6b51a);
    new_menu = function_6f3e10a2(var_e3315405);
    if (var_cd1475a5.menu_name === new_menu.menu_name) {
        return var_cd1475a5.var_b80d1ad4[isdefined(var_e3315405.state) ? var_e3315405.state : "__default__"];
    }
    return undefined;
}

// Namespace lui_camera/lui_camera
// Params 3, eflags: 0x0
// Checksum 0x901f1c13, Offset: 0xe78
// Size: 0x73c
function setup_menu(local_client_num, var_8de6b51a, var_e3315405) {
    var_cd1475a5 = function_6f3e10a2(var_8de6b51a);
    var_a8080f41 = function_6f3e10a2(var_8de6b51a);
    new_menu = function_6f3e10a2(var_e3315405);
    var_f81682ee = function_63446d7f(var_e3315405);
    var_fdb39764 = var_cd1475a5.menu_name === new_menu.menu_name;
    var_d2bf9838 = var_cd1475a5.str_scene !== level.var_6dfc0bcf;
    var_ad156153 = function_daadc836(var_cd1475a5.menu_name, local_client_num);
    var_9168605c = function_daadc836(new_menu.menu_name, local_client_num);
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
            if (isdefined(var_ad156153) && var_ad156153 !== var_9168605c) {
                [[ var_ad156153 ]]->hide_model();
                [[ var_ad156153 ]]->function_39a68bf2();
            }
        }
    }
    if (isdefined(new_menu)) {
        if ((isdefined(var_cd1475a5.var_b2ad82eb) ? var_cd1475a5.var_b2ad82eb : var_a8080f41.var_b2ad82eb) !== (isdefined(new_menu.var_b2ad82eb) ? new_menu.var_b2ad82eb : var_f81682ee.var_b2ad82eb)) {
            if (is_true(isdefined(new_menu.var_b2ad82eb) ? new_menu.var_b2ad82eb : var_f81682ee.var_b2ad82eb)) {
                customclass::function_831397a7(local_client_num);
            } else {
                customclass::function_415febc4(local_client_num);
            }
        }
        if (isdefined(var_e3315405.charactermode) && isdefined(var_9168605c)) {
            [[ var_9168605c ]]->set_character_mode(var_e3315405.charactermode);
        }
        if (isdefined(var_f81682ee.var_a362e358)) {
            level thread [[ var_f81682ee.var_a362e358 ]](local_client_num, var_e3315405.menu_name, var_e3315405.state);
        }
        if (var_fdb39764) {
            if (isdefined(new_menu.str_scene)) {
                level thread function_4e55f369(var_8de6b51a, var_e3315405);
            } else if (isdefined(new_menu.camera_function)) {
                level thread [[ new_menu.camera_function ]](local_client_num, var_e3315405.menu_name, var_e3315405.state);
            }
            return;
        }
        if (isdefined(var_9168605c)) {
            [[ var_9168605c ]]->show_model();
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

// Namespace lui_camera/lui_camera
// Params 1, eflags: 0x0
// Checksum 0x60767f64, Offset: 0x15c0
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

// Namespace lui_camera/lui_camera
// Params 4, eflags: 0x0
// Checksum 0x4662d14d, Offset: 0x19f0
// Size: 0x1d4
function function_befcd4f0(str_scene, var_f647c5b2 = undefined, var_559c5c3e = undefined, var_472bee8f = undefined) {
    assert(!isdefined(var_f647c5b2) || scene::function_9730988a(str_scene, var_f647c5b2));
    assert(!isdefined(var_559c5c3e) || scene::function_9730988a(str_scene, var_559c5c3e));
    level notify(#"hash_46855140938f532c");
    level endon(#"hash_46855140938f532c");
    if (isdefined(var_472bee8f)) {
        level endon(var_472bee8f);
    }
    if (level.var_6dfc0bcf !== str_scene) {
        level scene::stop(level.var_6dfc0bcf);
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

// Namespace lui_camera/lui_camera
// Params 4, eflags: 0x0
// Checksum 0xe43f1d68, Offset: 0x1bd0
// Size: 0x94
function function_5993fa03(str_scene, str_shot, time, var_472bee8f = undefined) {
    level notify(#"hash_46855140938f532c");
    level endon(#"hash_46855140938f532c");
    if (isdefined(var_472bee8f)) {
        level endon(var_472bee8f);
    }
    level thread scene::play_from_time(str_scene, str_shot, undefined, time, 1, 1);
}

// Namespace lui_camera/lui_camera
// Params 1, eflags: 0x0
// Checksum 0xca6745ef, Offset: 0x1c70
// Size: 0x4c
function function_4aa3b942(new_menu) {
    function_befcd4f0(new_menu.str_scene, new_menu.var_f647c5b2, new_menu.var_559c5c3e, new_menu.menu_name + "_closed");
}

// Namespace lui_camera/lui_camera
// Params 2, eflags: 0x0
// Checksum 0x40b225ec, Offset: 0x1cc8
// Size: 0x44
function function_7851a662(var_cd1475a5, shot) {
    function_befcd4f0(var_cd1475a5.str_scene, shot, undefined, var_cd1475a5.menu_name + "_closed");
}

// Namespace lui_camera/lui_camera
// Params 1, eflags: 0x0
// Checksum 0x75708f51, Offset: 0x1d18
// Size: 0x84
function function_4c61e7c(var_cd1475a5) {
    level notify(#"hash_46855140938f532c");
    level endon(var_cd1475a5.menu_name + "_closed");
    level endon(#"hash_46855140938f532c");
    level.var_6dfc0bcf = undefined;
    level scene::stop(var_cd1475a5.str_scene, 1);
}

// Namespace lui_camera/lui_camera
// Params 2, eflags: 0x0
// Checksum 0xbf981926, Offset: 0x1da8
// Size: 0x124
function function_4e55f369(var_8de6b51a, var_e3315405) {
    level notify(#"hash_46855140938f532c");
    new_menu = function_6f3e10a2(var_e3315405);
    var_ffb43fb8 = function_ffa1213e(var_8de6b51a, var_e3315405);
    if (isdefined(var_ffb43fb8)) {
        level endon(#"hash_46855140938f532c");
        level endon(new_menu.menu_name + "_closed");
        level scene::play(new_menu.str_scene, var_ffb43fb8);
        return;
    }
    var_cd1475a5 = function_6f3e10a2(var_8de6b51a);
    if (var_cd1475a5.str_scene !== new_menu.str_scene) {
        new_menu = function_6f3e10a2(var_e3315405);
        function_4aa3b942(new_menu);
    }
}

// Namespace lui_camera/lui_camera
// Params 3, eflags: 0x0
// Checksum 0x3a79e1fc, Offset: 0x1ed8
// Size: 0xb4
function is_current_menu(local_client_num, menu_name, state = undefined) {
    if (!isdefined(level.var_a14cc36b[local_client_num]) || level.var_a14cc36b[local_client_num].size == 0) {
        return false;
    }
    return level.var_a14cc36b[local_client_num][0].menu_name === menu_name && (!isdefined(state) || level.var_a14cc36b[local_client_num][0].state === state);
}

