#using script_1da833573eb80e61;
#using script_2feaeed9ab01d6f7;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;

#namespace lui;

// Namespace lui
// Method(s) 13 Total 13
class cluielem {

    var var_47d8642e;
    var var_779239b4;
    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace cluielem/lui_shared
    // Params 0, eflags: 0x8
    // Checksum 0x9479aaa2, Offset: 0x808
    // Size: 0x2a
    constructor() {
        var_d5213cbb = "";
        var_bf9c8c95 = undefined;
        var_779239b4 = 0;
    }

    // Namespace cluielem/lui_shared
    // Params 0, eflags: 0x10
    // Checksum 0xb6a7f47e, Offset: 0x840
    // Size: 0x96
    destructor() {
        if (lui::function_4206783a() && isdefined(var_d5213cbb) && var_d5213cbb != "" && isdefined(level.var_a706401b[hash(var_d5213cbb)][var_bf9c8c95])) {
            level.var_a706401b[hash(var_d5213cbb)][var_bf9c8c95] = undefined;
        }
    }

    // Namespace cluielem/lui_shared
    // Params 1, eflags: 0x0
    // Checksum 0x793210a2, Offset: 0xf68
    // Size: 0x82
    function open(local_client_num) {
        assert(var_47d8642e, "<dev string:xe3>");
        openluielem(local_client_num, hash(var_d5213cbb), var_bf9c8c95);
        function_fa582112(local_client_num);
        var_779239b4 = 1;
    }

    // Namespace cluielem/lui_shared
    // Params 1, eflags: 0x0
    // Checksum 0xe5c2398f, Offset: 0x1068
    // Size: 0x6e
    function close(local_client_num) {
        assert(var_47d8642e, "<dev string:x125>");
        closeluielem(local_client_num, hash(var_d5213cbb), var_bf9c8c95);
        var_779239b4 = 0;
    }

    // Namespace cluielem/lui_shared
    // Params 1, eflags: 0x0
    // Checksum 0x2ff5d047, Offset: 0xd90
    // Size: 0x18e
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
        if (lui::function_4206783a()) {
            if (!isdefined(level.var_a706401b)) {
                level.var_a706401b = associativearray();
            }
            if (!isdefined(level.var_a706401b[hash(menu_name)])) {
                level.var_a706401b[hash(menu_name)] = [];
            }
            level.var_a706401b[hash(menu_name)][var_bf9c8c95] = {#var_34327e5a:self};
        }
    }

    // Namespace cluielem/lui_shared
    // Params 1, eflags: 0x0
    // Checksum 0x2b742c47, Offset: 0x8e0
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
    // Params 2, eflags: 0x0
    // Checksum 0xbcb6d227, Offset: 0x1310
    // Size: 0x6a
    function get_data(local_client_num, field) {
        assert(var_47d8642e, "<dev string:x167>");
        return function_88759655(local_client_num, hash(var_d5213cbb), var_bf9c8c95, field);
    }

    // Namespace cluielem/lui_shared
    // Params 1, eflags: 0x0
    // Checksum 0xe3bb486f, Offset: 0x1388
    // Size: 0x26c
    function function_cbca32d8(local_client_num) {
        if (lui::function_4206783a() && isdefined(level.var_a706401b[hash(var_d5213cbb)][var_bf9c8c95])) {
            data = level.var_a706401b[hash(var_d5213cbb)][var_bf9c8c95].data;
            if (isdefined(data)) {
                if (isdefined(local_client_num)) {
                    if (isdefined(data[local_client_num])) {
                        foreach (kvp in data[local_client_num]) {
                            function_bcc2134a(local_client_num, hash(var_d5213cbb), var_bf9c8c95, kvp.field, kvp.value);
                        }
                    }
                    return;
                }
                foreach (local_client_num in data) {
                    foreach (kvp in data[local_client_num]) {
                        function_bcc2134a(local_client_num, hash(var_d5213cbb), var_bf9c8c95, kvp.field, kvp.value);
                    }
                }
            }
        }
    }

    // Namespace cluielem/lui_shared
    // Params 3, eflags: 0x0
    // Checksum 0x2c79c99b, Offset: 0x10e0
    // Size: 0x222
    function set_data(local_client_num, field, value) {
        assert(var_47d8642e, "<dev string:x167>");
        function_bcc2134a(local_client_num, hash(var_d5213cbb), var_bf9c8c95, field, value);
        if (lui::function_4206783a() && !level flag::get(#"player_spawning") && isdefined(level.var_a706401b[hash(var_d5213cbb)][var_bf9c8c95])) {
            if (!isdefined(level.var_a706401b[hash(var_d5213cbb)][var_bf9c8c95].data)) {
                level.var_a706401b[hash(var_d5213cbb)][var_bf9c8c95].data = [];
            }
            if (!isdefined(level.var_a706401b[hash(var_d5213cbb)][var_bf9c8c95].data[local_client_num])) {
                level.var_a706401b[hash(var_d5213cbb)][var_bf9c8c95].data[local_client_num] = [];
            }
            level.var_a706401b[hash(var_d5213cbb)][var_bf9c8c95].data[local_client_num][field] = {#field:field, #value:value};
        }
    }

    // Namespace cluielem/lui_shared
    // Params 1, eflags: 0x0
    // Checksum 0x61bb6ee5, Offset: 0xff8
    // Size: 0x62
    function is_open(local_client_num) {
        assert(var_47d8642e, "<dev string:xe3>");
        return isluielemopen(local_client_num, hash(var_d5213cbb), var_bf9c8c95);
    }

    // Namespace cluielem/lui_shared
    // Params 5, eflags: 0x0
    // Checksum 0xbd1b2ba8, Offset: 0x9c8
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
    // Params 3, eflags: 0x0
    // Checksum 0x74ad515e, Offset: 0xbb8
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
    // Params 1, eflags: 0x0
    // Checksum 0xb60f884f, Offset: 0xf28
    // Size: 0x34
    function function_fa582112(*local_client_num) {
        assert(var_47d8642e, "<dev string:x9e>");
    }

}

// Namespace lui/lui_shared
// Params 0, eflags: 0x6
// Checksum 0x3cbd60cb, Offset: 0xe0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"lui_shared", &preinit, undefined, undefined, undefined);
}

// Namespace lui/lui_shared
// Params 0, eflags: 0x4
// Checksum 0xa6cfb696, Offset: 0x128
// Size: 0x70
function private preinit() {
    full_screen_black::register();
    initial_black::register();
    level.localclients = [];
    level.localclients[0] = {};
    level.localclients[1] = {};
    level.localclients[2] = {};
    level.localclients[3] = {};
}

// Namespace lui/lui_shared
// Params 6, eflags: 0x0
// Checksum 0x887b0535, Offset: 0x1a0
// Size: 0x9c
function screen_fade(localclientnum, n_time, n_target_alpha = 1, n_start_alpha = 0, str_color = "black", b_force_close_menu = 0) {
    level thread _screen_fade(localclientnum, n_time, n_target_alpha, n_start_alpha, str_color, b_force_close_menu);
}

// Namespace lui/lui_shared
// Params 3, eflags: 0x0
// Checksum 0xe9d9768a, Offset: 0x248
// Size: 0x42
function screen_fade_out(localclientnum, n_time, str_color) {
    screen_fade(localclientnum, n_time, 1, 0, str_color, 0);
    wait n_time;
}

// Namespace lui/lui_shared
// Params 3, eflags: 0x0
// Checksum 0x9be07ed4, Offset: 0x298
// Size: 0x4a
function screen_fade_in(localclientnum, n_time, str_color) {
    screen_fade(localclientnum, n_time, 0, 1, str_color, 1);
    wait n_time;
}

// Namespace lui/lui_shared
// Params 1, eflags: 0x0
// Checksum 0x3ff22e85, Offset: 0x2f0
// Size: 0x24
function screen_close_menu(localclientnum) {
    level thread _screen_close_menu(localclientnum);
}

// Namespace lui/lui_shared
// Params 1, eflags: 0x4
// Checksum 0x75d49233, Offset: 0x320
// Size: 0x80
function private _screen_close_menu(localclientnum) {
    level notify("_screen_fade" + localclientnum);
    level endon("_screen_fade" + localclientnum);
    if (isdefined(level.localclients[localclientnum].full_screen_black)) {
        [[ level.localclients[localclientnum].full_screen_black.lui_menu ]]->close(localclientnum);
    }
}

// Namespace lui/lui_shared
// Params 6, eflags: 0x4
// Checksum 0x92251ad5, Offset: 0x3a8
// Size: 0x438
function private _screen_fade(localclientnum, n_time, n_target_alpha, n_start_alpha, v_color, b_force_close_menu) {
    level notify("_screen_fade" + localclientnum);
    level endon("_screen_fade" + localclientnum);
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
    if (isdefined(level.localclients[localclientnum].full_screen_black)) {
        s_menu = level.localclients[localclientnum].full_screen_black;
        [[ s_menu.lui_menu ]]->close(localclientnum);
        n_start_alpha = lerpfloat(s_menu.n_start_alpha, s_menu.n_target_alpha, gettime() - s_menu.n_start_time);
    } else {
        level.localclients[localclientnum].full_screen_black = spawnstruct();
        level.localclients[localclientnum].full_screen_black.lui_menu = full_screen_black::register_clientside();
    }
    level.localclients[localclientnum].full_screen_black.n_start_alpha = n_start_alpha;
    level.localclients[localclientnum].full_screen_black.n_target_alpha = n_target_alpha;
    level.localclients[localclientnum].full_screen_black.n_target_time = n_time_ms;
    level.localclients[localclientnum].full_screen_black.n_start_time = gettime();
    [[ level.localclients[localclientnum].full_screen_black.lui_menu ]]->open(localclientnum);
    [[ level.localclients[localclientnum].full_screen_black.lui_menu ]]->set_red(localclientnum, v_color[0]);
    [[ level.localclients[localclientnum].full_screen_black.lui_menu ]]->set_green(localclientnum, v_color[1]);
    [[ level.localclients[localclientnum].full_screen_black.lui_menu ]]->set_blue(localclientnum, v_color[2]);
    [[ level.localclients[localclientnum].full_screen_black.lui_menu ]]->set_startalpha(localclientnum, n_start_alpha);
    [[ level.localclients[localclientnum].full_screen_black.lui_menu ]]->set_endalpha(localclientnum, n_target_alpha);
    [[ level.localclients[localclientnum].full_screen_black.lui_menu ]]->set_fadeovertime(localclientnum, n_time_ms);
    wait n_time;
    if (b_force_close_menu || n_target_alpha == 0) {
        [[ level.localclients[localclientnum].full_screen_black.lui_menu ]]->close(localclientnum);
    }
}

// Namespace lui/lui_shared
// Params 0, eflags: 0x4
// Checksum 0x816c828d, Offset: 0x7e8
// Size: 0x12
function private function_4206783a() {
    return sessionmodeiscampaigngame();
}

// Namespace lui/lui_shared
// Params 2, eflags: 0x0
// Checksum 0xd3100bdb, Offset: 0x1898
// Size: 0xc4
function function_ca036b2c(local_client_num, name) {
    var_cad692a8 = getentarray(local_client_num, name, "targetname");
    foreach (trigger in var_cad692a8) {
        trigger function_c06a8682(local_client_num);
    }
    return var_cad692a8;
}

