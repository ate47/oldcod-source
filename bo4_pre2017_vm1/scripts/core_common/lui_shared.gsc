#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/string_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/values_shared;

#namespace lui;

// Namespace lui/lui_shared
// Params 0, eflags: 0x2
// Checksum 0x555ebf01, Offset: 0x400
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("lui_shared", &__init__, undefined, undefined);
}

// Namespace lui/lui_shared
// Params 0, eflags: 0x0
// Checksum 0xe591aba0, Offset: 0x440
// Size: 0x94
function __init__() {
    callback::on_spawned(&refresh_menu_values);
    clientfield::register("clientuimodel", "hudItems.showCPNotificationText", 1, 1, "int");
    clientfield::register("clientuimodel", "hudItems.cpInstructionText", 1, getlocalizedstringindexbitcount(), "int");
}

// Namespace lui/lui_shared
// Params 0, eflags: 0x4
// Checksum 0x6a696d60, Offset: 0x4e0
// Size: 0x138
function private refresh_menu_values() {
    if (!isdefined(level.lui_script_globals)) {
        return;
    }
    var_7f819867 = getarraykeys(level.lui_script_globals);
    for (i = 0; i < var_7f819867.size; i++) {
        str_menu = var_7f819867[i];
        var_6733360b = getarraykeys(level.lui_script_globals[str_menu]);
        for (j = 0; j < var_6733360b.size; j++) {
            var_f0ab9680 = var_6733360b[j];
            value = level.lui_script_globals[str_menu][var_f0ab9680];
            self set_value_for_player(str_menu, var_f0ab9680, value);
        }
    }
}

// Namespace lui/lui_shared
// Params 2, eflags: 0x0
// Checksum 0xf2f07a27, Offset: 0x620
// Size: 0x9c
function play_animation(menu, str_anim) {
    str_curr_anim = self getluimenudata(menu, "current_animation");
    str_new_anim = str_anim;
    if (isdefined(str_curr_anim) && str_curr_anim == str_anim) {
        str_new_anim = "";
    }
    self setluimenudata(menu, "current_animation", str_new_anim);
}

// Namespace lui/lui_shared
// Params 2, eflags: 0x0
// Checksum 0xdef491c3, Offset: 0x6c8
// Size: 0x8c
function set_color(menu, color) {
    self setluimenudata(menu, "red", color[0]);
    self setluimenudata(menu, "green", color[1]);
    self setluimenudata(menu, "blue", color[2]);
}

// Namespace lui/lui_shared
// Params 3, eflags: 0x0
// Checksum 0x99d25550, Offset: 0x760
// Size: 0x9c
function set_value_for_player(str_menu_id, str_variable_id, value) {
    if (!isdefined(self.lui_script_menus)) {
        self.lui_script_menus = [];
    }
    if (!isdefined(self.lui_script_menus[str_menu_id])) {
        self.lui_script_menus[str_menu_id] = self openluimenu(str_menu_id);
    }
    self setluimenudata(self.lui_script_menus[str_menu_id], str_variable_id, value);
}

// Namespace lui/lui_shared
// Params 3, eflags: 0x0
// Checksum 0xb912c722, Offset: 0x808
// Size: 0x12a
function set_global(str_menu_id, str_variable_id, value) {
    if (!isdefined(level.lui_script_globals)) {
        level.lui_script_globals = [];
    }
    if (!isdefined(level.lui_script_globals[str_menu_id])) {
        level.lui_script_globals[str_menu_id] = [];
    }
    level.lui_script_globals[str_menu_id][str_variable_id] = value;
    if (isdefined(level.players)) {
        foreach (player in level.players) {
            player set_value_for_player(str_menu_id, str_variable_id, value);
        }
    }
}

// Namespace lui/lui_shared
// Params 5, eflags: 0x0
// Checksum 0x381e9734, Offset: 0x940
// Size: 0x174
function timer(n_time, str_endon, x, y, height) {
    if (!isdefined(x)) {
        x = 1080;
    }
    if (!isdefined(y)) {
        y = 200;
    }
    if (!isdefined(height)) {
        height = 60;
    }
    lui = self openluimenu("HudElementTimer");
    self setluimenudata(lui, "x", x);
    self setluimenudata(lui, "y", y);
    self setluimenudata(lui, "height", height);
    self setluimenudata(lui, "time", gettime() + n_time * 1000);
    if (isdefined(str_endon)) {
        self waittilltimeout(n_time, str_endon);
    } else {
        wait n_time;
    }
    self closeluimenu(lui);
}

// Namespace lui/lui_shared
// Params 3, eflags: 0x0
// Checksum 0xc3a3828f, Offset: 0xac0
// Size: 0x114
function prime_movie(str_movie, b_looping, str_key) {
    if (!isdefined(b_looping)) {
        b_looping = 0;
    }
    if (!isdefined(str_key)) {
        str_key = "";
    }
    if (self == level) {
        foreach (player in level.players) {
            player primemovie(str_movie, b_looping, str_key);
        }
        return;
    }
    player primemovie(str_movie, b_looping, str_key);
}

// Namespace lui/lui_shared
// Params 5, eflags: 0x0
// Checksum 0xb5ba667c, Offset: 0xbe0
// Size: 0x358
function play_movie(str_movie, str_type, show_black_screen, b_looping, str_key) {
    if (!isdefined(show_black_screen)) {
        show_black_screen = 0;
    }
    if (!isdefined(b_looping)) {
        b_looping = 0;
    }
    if (!isdefined(str_key)) {
        str_key = "";
    }
    if (str_type === "fullscreen" || str_type === "fullscreen_additive") {
        b_hide_hud = 1;
    }
    if (self == level) {
        foreach (player in level.players) {
            if (isdefined(b_hide_hud)) {
                player flagsys::set("playing_movie_hide_hud");
                player val::set("play_movie", "show_hud", 0);
            }
            player thread _play_movie_for_player(str_movie, str_type, show_black_screen, b_looping, str_key);
        }
        array::wait_till(level.players, "movie_done");
        if (isdefined(b_hide_hud)) {
            foreach (player in level.players) {
                player flagsys::clear("playing_movie_hide_hud");
                player val::reset("play_movie", "show_hud");
            }
        }
    } else {
        if (isdefined(b_hide_hud)) {
            self flagsys::set("playing_movie_hide_hud");
            self val::set("play_movie", "show_hud", 0);
        }
        _play_movie_for_player(str_movie, str_type, 0, b_looping, str_key);
        if (isdefined(b_hide_hud)) {
            self flagsys::clear("playing_movie_hide_hud");
            self val::reset("play_movie", "show_hud");
        }
    }
    level notify(#"movie_done", {#type:str_type});
}

// Namespace lui/lui_shared
// Params 5, eflags: 0x4
// Checksum 0x39efe1f, Offset: 0xf40
// Size: 0x2fe
function private _play_movie_for_player(str_movie, str_type, show_black_screen, b_looping, str_key) {
    self endon(#"disconnect");
    str_menu = undefined;
    switch (str_type) {
    case #"fullscreen":
    case #"fullscreen_additive":
        str_menu = "FullscreenMovie";
        break;
    case #"pip":
        str_menu = "PiPMenu";
        break;
    default:
        assertmsg("<dev string:x28>" + str_type + "<dev string:x3d>");
        break;
    }
    if (str_type == "pip") {
        self playsoundtoplayer("uin_pip_open", self);
    }
    lui_menu = self openluimenu(str_menu);
    if (isdefined(lui_menu)) {
        self setluimenudata(lui_menu, "movieName", str_movie);
        self setluimenudata(lui_menu, "movieKey", str_key);
        self setluimenudata(lui_menu, "showBlackScreen", show_black_screen);
        self setluimenudata(lui_menu, "looping", b_looping);
        self setluimenudata(lui_menu, "additive", 0);
        if (issubstr(str_type, "additive")) {
            self setluimenudata(lui_menu, "additive", 1);
        }
        while (true) {
            waitresult = self waittill("menuresponse");
            menu = waitresult.menu;
            response = waitresult.response;
            if (menu == str_menu && response == "finished_movie_playback") {
                if (str_type == "pip") {
                    self playsoundtoplayer("uin_pip_close", self);
                }
                self closeluimenu(lui_menu);
                self notify(#"movie_done");
            }
        }
    }
}

// Namespace lui/lui_shared
// Params 6, eflags: 0x0
// Checksum 0x5a7a31ae, Offset: 0x1248
// Size: 0x2b8
function function_be38d8cd(str_movie, str_type, timeout, show_black_screen, b_looping, str_key) {
    if (!isdefined(show_black_screen)) {
        show_black_screen = 0;
    }
    if (!isdefined(b_looping)) {
        b_looping = 0;
    }
    if (!isdefined(str_key)) {
        str_key = "";
    }
    if (str_type === "fullscreen" || str_type === "fullscreen_additive") {
        b_hide_hud = 1;
    }
    assert(self == level);
    foreach (player in level.players) {
        if (isdefined(b_hide_hud)) {
            player flagsys::set("playing_movie_hide_hud");
            player val::set("play_movie", "show_hud", 0);
        }
        player thread function_adc333e0(str_movie, str_type, timeout, show_black_screen, b_looping, str_key);
    }
    array::wait_till(level.players, "movie_done");
    if (isdefined(b_hide_hud)) {
        foreach (player in level.players) {
            player flagsys::clear("playing_movie_hide_hud");
            player val::reset("play_movie", "show_hud");
        }
    }
    level notify(#"movie_done", {#type:str_type});
}

// Namespace lui/lui_shared
// Params 6, eflags: 0x4
// Checksum 0xd772e522, Offset: 0x1508
// Size: 0x292
function private function_adc333e0(str_movie, str_type, timeout, show_black_screen, b_looping, str_key) {
    self endon(#"disconnect");
    str_menu = undefined;
    switch (str_type) {
    case #"fullscreen":
    case #"fullscreen_additive":
        str_menu = "FullscreenMovie";
        break;
    case #"pip":
        str_menu = "PiPMenu";
        break;
    default:
        assertmsg("<dev string:x28>" + str_type + "<dev string:x3d>");
        break;
    }
    if (str_type == "pip") {
        self playsoundtoplayer("uin_pip_open", self);
    }
    lui_menu = self openluimenu(str_menu);
    if (isdefined(lui_menu)) {
        self setluimenudata(lui_menu, "movieName", str_movie);
        self setluimenudata(lui_menu, "movieKey", str_key);
        self setluimenudata(lui_menu, "showBlackScreen", show_black_screen);
        self setluimenudata(lui_menu, "looping", b_looping);
        self setluimenudata(lui_menu, "additive", 0);
        if (issubstr(str_type, "additive")) {
            self setluimenudata(lui_menu, "additive", 1);
        }
        wait timeout;
        if (str_type == "pip") {
            self playsoundtoplayer("uin_pip_close", self);
        }
        self closeluimenu(lui_menu);
        self notify(#"movie_done");
    }
}

// Namespace lui/lui_shared
// Params 6, eflags: 0x0
// Checksum 0x16632f62, Offset: 0x17a8
// Size: 0x174
function screen_flash(n_fadein_time, n_hold_time, n_fadeout_time, n_target_alpha, v_color, b_force_close_menu) {
    if (!isdefined(n_target_alpha)) {
        n_target_alpha = 1;
    }
    if (!isdefined(b_force_close_menu)) {
        b_force_close_menu = 0;
    }
    if (self == level) {
        foreach (player in level.players) {
            player thread screen_flash(n_fadein_time, n_hold_time, n_fadeout_time, n_target_alpha, v_color, b_force_close_menu);
        }
        return;
    }
    self endon(#"disconnect");
    self _screen_fade(n_fadein_time, n_target_alpha, 0, v_color, b_force_close_menu);
    wait n_hold_time;
    self _screen_fade(n_fadeout_time, 0, n_target_alpha, v_color, b_force_close_menu);
}

// Namespace lui/lui_shared
// Params 6, eflags: 0x0
// Checksum 0x3e0f697, Offset: 0x1928
// Size: 0x14c
function screen_fade(n_time, n_target_alpha, n_start_alpha, v_color, b_force_close_menu, str_menu_id) {
    if (!isdefined(n_target_alpha)) {
        n_target_alpha = 1;
    }
    if (!isdefined(n_start_alpha)) {
        n_start_alpha = 0;
    }
    if (!isdefined(b_force_close_menu)) {
        b_force_close_menu = 0;
    }
    if (self == level) {
        foreach (player in level.players) {
            player thread _screen_fade(n_time, n_target_alpha, n_start_alpha, v_color, b_force_close_menu, str_menu_id);
        }
        return;
    }
    self thread _screen_fade(n_time, n_target_alpha, n_start_alpha, v_color, b_force_close_menu, str_menu_id);
}

// Namespace lui/lui_shared
// Params 3, eflags: 0x0
// Checksum 0x7579be4e, Offset: 0x1a80
// Size: 0x4a
function screen_fade_out(n_time, v_color, str_menu_id) {
    screen_fade(n_time, 1, 0, v_color, 0, str_menu_id);
    wait n_time;
}

// Namespace lui/lui_shared
// Params 3, eflags: 0x0
// Checksum 0x7e86574a, Offset: 0x1ad8
// Size: 0x4a
function screen_fade_in(n_time, v_color, str_menu_id) {
    screen_fade(n_time, 0, 1, v_color, 1, str_menu_id);
    wait n_time;
}

// Namespace lui/lui_shared
// Params 0, eflags: 0x0
// Checksum 0x8cd404c6, Offset: 0x1b30
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
// Params 0, eflags: 0x4
// Checksum 0x3e50bfb2, Offset: 0x1bf0
// Size: 0xe2
function private _screen_close_menu() {
    self notify(#"_screen_fade");
    self endon(#"_screen_fade");
    self endon(#"disconnect");
    if (isdefined(self.screen_fade_menus)) {
        foreach (str_menu_id, lui_menu in self.screen_fade_menus) {
            self closeluimenu(lui_menu.lui_menu);
            self.screen_fade_menus[str_menu_id] = undefined;
        }
    }
}

// Namespace lui/lui_shared
// Params 6, eflags: 0x4
// Checksum 0x4254dc33, Offset: 0x1ce0
// Size: 0x4be
function private _screen_fade(n_time, n_target_alpha, n_start_alpha, v_color, b_force_close_menu, str_menu_id) {
    if (!isdefined(str_menu_id)) {
        str_menu_id = "default";
    }
    self notify("_screen_fade_" + str_menu_id);
    self endon("_screen_fade_" + str_menu_id);
    self endon(#"disconnect");
    if (!isdefined(self.screen_fade_menus)) {
        self.screen_fade_menus = [];
    }
    if (!isdefined(level.screen_fade_network_frame)) {
        level.screen_fade_network_frame = 0;
    }
    if (!isdefined(v_color)) {
        v_color = (0, 0, 0);
    }
    n_time_ms = int(n_time * 1000);
    str_menu = "FullScreenBlack";
    if (isstring(v_color)) {
        switch (v_color) {
        case #"black":
            v_color = (0, 0, 0);
            break;
        case #"white":
            v_color = (1, 1, 1);
            break;
        }
    }
    lui_menu = "";
    if (isdefined(self.screen_fade_menus[str_menu_id])) {
        s_menu = self.screen_fade_menus[str_menu_id];
        lui_menu = s_menu.lui_menu;
        _one_screen_fade_per_network_frame(s_menu);
        n_start_alpha = lerpfloat(s_menu.n_start_alpha, s_menu.n_target_alpha, gettime() - s_menu.n_start_time);
    } else {
        lui_menu = self openluimenu(str_menu);
        self.screen_fade_menus[str_menu_id] = spawnstruct();
        self.screen_fade_menus[str_menu_id].lui_menu = lui_menu;
    }
    self.screen_fade_menus[str_menu_id].n_start_alpha = n_start_alpha;
    self.screen_fade_menus[str_menu_id].n_target_alpha = n_target_alpha;
    self.screen_fade_menus[str_menu_id].n_target_time = n_time_ms;
    self.screen_fade_menus[str_menu_id].n_start_time = gettime();
    self set_color(lui_menu, v_color);
    self setluimenudata(lui_menu, "startAlpha", n_start_alpha);
    self setluimenudata(lui_menu, "endAlpha", n_target_alpha);
    self setluimenudata(lui_menu, "fadeOverTime", n_time_ms);
    /#
        if (!isdefined(level.n_fade_debug_time)) {
            level.n_fade_debug_time = 0;
        }
        n_debug_time = gettime();
        if (n_debug_time - level.n_fade_debug_time > 5000) {
            printtoprightln("<dev string:x40>");
        }
        level.n_fade_debug_time = n_debug_time;
    #/
    if (n_time > 0) {
        wait n_time;
    }
    self setluimenudata(lui_menu, "fadeOverTime", 0);
    if (b_force_close_menu || n_target_alpha == 0) {
        if (isdefined(self.screen_fade_menus[str_menu_id])) {
            self closeluimenu(self.screen_fade_menus[str_menu_id].lui_menu);
        }
        self.screen_fade_menus[str_menu_id] = undefined;
        if (!self.screen_fade_menus.size) {
            self.screen_fade_menus = undefined;
        }
    }
}

// Namespace lui/lui_shared
// Params 1, eflags: 0x4
// Checksum 0x54681ec3, Offset: 0x21a8
// Size: 0x58
function private _one_screen_fade_per_network_frame(s_menu) {
    while (s_menu.screen_fade_network_frame === level.network_frame) {
        util::wait_network_frame();
    }
    s_menu.screen_fade_network_frame = level.network_frame;
}

// Namespace lui/lui_shared
// Params 2, eflags: 0x0
// Checksum 0xd7f811ab, Offset: 0x2208
// Size: 0x11c
function open_generic_script_dialog(title, description) {
    self endon(#"disconnect");
    dialog = self openluimenu("ScriptMessageDialog_Compact");
    self setluimenudata(dialog, "title", title);
    self setluimenudata(dialog, "description", description);
    do {
        waitresult = self waittill("menuresponse");
        menu = waitresult.menu;
        response = waitresult.response;
    } while (menu != "ScriptMessageDialog_Compact" || response != "close");
    self closeluimenu(dialog);
}

// Namespace lui/lui_shared
// Params 1, eflags: 0x0
// Checksum 0xcd95b9bc, Offset: 0x2330
// Size: 0xcc
function open_script_dialog(dialog_name) {
    self endon(#"disconnect");
    dialog = self openluimenu(dialog_name);
    do {
        waitresult = self waittill("menuresponse");
        menu = waitresult.menu;
        response = waitresult.response;
    } while (menu != dialog_name || response != "close");
    self closeluimenu(dialog);
}

// Namespace lui/lui_shared
// Params 0, eflags: 0x0
// Checksum 0xad8768c6, Offset: 0x2408
// Size: 0x24
function function_59ff8f29() {
    clientfield::set_player_uimodel("hudItems.showCPNotificationText", 1);
}

// Namespace lui/lui_shared
// Params 0, eflags: 0x0
// Checksum 0x1352f436, Offset: 0x2438
// Size: 0x1c
function function_4c7e8e7a() {
    clientfield::set_player_uimodel("hudItems.showCPNotificationText", 0);
}

// Namespace lui/lui_shared
// Params 1, eflags: 0x0
// Checksum 0x8222b22b, Offset: 0x2460
// Size: 0x4c
function function_e3c4750(var_2e45eaa3) {
    clientfield::set_player_uimodel("hudItems.cpInstructionText", getlocalizedstringindex(istring(var_2e45eaa3)));
}

// Namespace lui/lui_shared
// Params 0, eflags: 0x0
// Checksum 0x61445cc5, Offset: 0x24b8
// Size: 0x4c
function function_81d5cb4b() {
    clientfield::set_player_uimodel("hudItems.cpInstructionText", getlocalizedstringindex(istring("")));
}

