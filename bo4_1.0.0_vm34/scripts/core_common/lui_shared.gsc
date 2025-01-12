#using script_4194df57536e11ed;
#using script_50719ad9bcd4b183;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;

#namespace lui;

// Namespace lui
// Method(s) 10 Total 10
class cluielem {

    var var_57a3d576;

    // Namespace cluielem/lui_shared
    // Params 0, eflags: 0x8
    // Checksum 0x2aad0a67, Offset: 0x2690
    // Size: 0x12
    constructor() {
        var_57a3d576 = "";
    }

    // Namespace cluielem/lui_shared
    // Params 1, eflags: 0x0
    // Checksum 0x125e7de5, Offset: 0x28b8
    // Size: 0x44
    function close_luielem(player) {
        if (isplayer(player)) {
            player closeluielem(var_57a3d576);
        }
    }

    // Namespace cluielem/lui_shared
    // Params 1, eflags: 0x0
    // Checksum 0xeaaba998, Offset: 0x2880
    // Size: 0x2a
    function function_76692f88(player) {
        return player function_476e4812(var_57a3d576);
    }

    // Namespace cluielem/lui_shared
    // Params 3, eflags: 0x0
    // Checksum 0x9be9ab6f, Offset: 0x2828
    // Size: 0x4c
    function open_luielem(player, menu_name, persistent = 0) {
        player openluielem(menu_name, var_57a3d576, persistent);
    }

    // Namespace cluielem/lui_shared
    // Params 3, eflags: 0x0
    // Checksum 0x79f0c5a4, Offset: 0x27e0
    // Size: 0x3c
    function function_9671fe91(player, field_name, value) {
        player clientfield::function_8fe7322a(var_57a3d576, field_name, value);
    }

    // Namespace cluielem/lui_shared
    // Params 3, eflags: 0x0
    // Checksum 0xb914ef7f, Offset: 0x2798
    // Size: 0x3c
    function set_clientfield(player, field_name, value) {
        player clientfield::function_8fe7322a(var_57a3d576, field_name, value);
    }

    // Namespace cluielem/lui_shared
    // Params 3, eflags: 0x0
    // Checksum 0x953f090, Offset: 0x2730
    // Size: 0x5c
    function function_52818084(var_16dcb09f, field_name, version) {
        clientfield::register_bgcache("clientuimodel", var_16dcb09f, "luielement." + var_57a3d576 + "." + field_name, version);
    }

    // Namespace cluielem/lui_shared
    // Params 4, eflags: 0x0
    // Checksum 0xb20e1c7f, Offset: 0x26d8
    // Size: 0x4c
    function add_clientfield(field_name, version, bits, type) {
        clientfield::register_luielem(var_57a3d576, field_name, version, bits, type);
    }

    // Namespace cluielem/lui_shared
    // Params 1, eflags: 0x0
    // Checksum 0x42e70d44, Offset: 0x26b0
    // Size: 0x1a
    function setup_clientfields(uid) {
        var_57a3d576 = uid;
    }

}

// Namespace lui/lui_shared
// Params 0, eflags: 0x2
// Checksum 0xe6b28c0a, Offset: 0x228
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"lui_shared", &__init__, undefined, undefined);
}

// Namespace lui/lui_shared
// Params 0, eflags: 0x0
// Checksum 0x2f44463, Offset: 0x270
// Size: 0x84
function __init__() {
    callback::on_spawned(&refresh_menu_values);
    add_luimenu("FullScreenBlack", &full_screen_black::register, "full_screen_black");
    add_luimenu("InitialBlack", &initial_black::register, "initial_black");
}

// Namespace lui/lui_shared
// Params 3, eflags: 0x0
// Checksum 0x39398a68, Offset: 0x300
// Size: 0x66
function add_luimenu(alias, registerfunc, uid) {
    if (!isdefined(level.luimenus)) {
        level.luimenus = array();
    }
    level.luimenus[alias] = [[ registerfunc ]](uid);
}

// Namespace lui/lui_shared
// Params 1, eflags: 0x0
// Checksum 0x68659db7, Offset: 0x370
// Size: 0x1c
function get_luimenu(alias) {
    return level.luimenus[alias];
}

// Namespace lui/lui_shared
// Params 0, eflags: 0x4
// Checksum 0x19956183, Offset: 0x398
// Size: 0xf4
function private refresh_menu_values() {
    if (!isdefined(level.lui_script_globals)) {
        return;
    }
    foreach (k, v in level.lui_script_globals) {
        foreach (k2, v2 in v) {
            self set_value_for_player(k, k2, v2);
        }
    }
}

// Namespace lui/lui_shared
// Params 2, eflags: 0x0
// Checksum 0xa7d7a99b, Offset: 0x498
// Size: 0x9c
function play_animation(menu, str_anim) {
    str_curr_anim = self getluimenudata(menu, "current_animation");
    str_new_anim = str_anim;
    if (isdefined(str_curr_anim) && str_curr_anim == str_anim) {
        str_new_anim = "";
    }
    self setluimenudata(menu, #"current_animation", str_new_anim);
}

// Namespace lui/lui_shared
// Params 2, eflags: 0x0
// Checksum 0xb74e5b41, Offset: 0x540
// Size: 0x80
function set_color(menu, color) {
    if (!isint(menu)) {
        [[ menu ]]->set_red(self, color[0]);
        [[ menu ]]->set_green(self, color[1]);
        [[ menu ]]->set_blue(self, color[2]);
    }
}

// Namespace lui/lui_shared
// Params 3, eflags: 0x0
// Checksum 0x23ef868, Offset: 0x5c8
// Size: 0x94
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
// Checksum 0xa7dbbdf1, Offset: 0x668
// Size: 0x118
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
// Checksum 0xd85df09b, Offset: 0x788
// Size: 0x184
function timer(n_time, str_endon, x = 1080, y = 200, height = 60) {
    lui = self openluimenu("HudElementTimer");
    self setluimenudata(lui, #"x", x);
    self setluimenudata(lui, #"y", y);
    self setluimenudata(lui, #"height", height);
    self setluimenudata(lui, #"time", gettime() + int(n_time * 1000));
    if (isdefined(str_endon)) {
        self waittilltimeout(n_time, str_endon);
    } else {
        wait n_time;
    }
    self closeluimenu(lui);
}

// Namespace lui/lui_shared
// Params 3, eflags: 0x0
// Checksum 0xf658db11, Offset: 0x918
// Size: 0x184
function prime_movie(str_movie, b_looping = 0, str_key = "") {
    if (isarray(self)) {
        foreach (player in self) {
            player primemovie(str_movie, b_looping, str_key);
        }
        return;
    }
    if (self == level) {
        foreach (player in level.players) {
            player primemovie(str_movie, b_looping, str_key);
        }
        return;
    }
    self primemovie(str_movie, b_looping, str_key);
}

// Namespace lui/lui_shared
// Params 4, eflags: 0x0
// Checksum 0xc1077ffc, Offset: 0xaa8
// Size: 0x100
function function_2fba96b5(str_team, str_movie, b_looping = 0, str_key = "") {
    callback::on_connect(&function_3654c49b, undefined, str_team, str_movie, b_looping, str_key);
    foreach (player in util::get_human_players(str_team)) {
        player prime_movie(str_movie);
    }
}

// Namespace lui/lui_shared
// Params 4, eflags: 0x4
// Checksum 0xa1883b16, Offset: 0xbb0
// Size: 0x6c
function private function_3654c49b(str_team, str_movie, b_looping, str_key) {
    if (util::is_on_side(str_team)) {
        if (util::function_30b386cd(self)) {
            prime_movie(str_movie);
        }
    }
}

// Namespace lui/lui_shared
// Params 7, eflags: 0x0
// Checksum 0xaea3518d, Offset: 0xc28
// Size: 0x128
function function_1d44e0be(str_team, str_movie, str_type, show_black_screen = 0, b_looping = 0, str_key = "", n_timeout) {
    callback::remove_on_connect(&function_3654c49b);
    foreach (player in util::get_human_players(str_team)) {
        player thread play_movie(str_movie, str_type, show_black_screen, b_looping, str_key, n_timeout);
    }
}

// Namespace lui/lui_shared
// Params 6, eflags: 0x0
// Checksum 0x744015cc, Offset: 0xd58
// Size: 0x390
function play_movie(str_movie, str_type, show_black_screen = 0, b_looping = 0, str_key = "", n_timeout) {
    if (str_type === "fullscreen" || str_type === "fullscreen_additive") {
        b_hide_hud = 1;
    }
    if (isarray(self)) {
        a_players = self;
    } else if (self == level) {
        a_players = level.players;
    }
    if (isarray(a_players)) {
        foreach (player in a_players) {
            if (isdefined(b_hide_hud)) {
                player flagsys::set(#"playing_movie_hide_hud");
                player val::set(#"play_movie", "show_hud", 0);
            }
            player thread _play_movie_for_player(str_movie, str_type, show_black_screen, b_looping, str_key, n_timeout);
        }
        array::wait_till(a_players, "movie_done");
        if (isdefined(b_hide_hud)) {
            foreach (player in a_players) {
                player flagsys::clear(#"playing_movie_hide_hud");
                player val::reset(#"play_movie", "show_hud");
            }
        }
    } else {
        if (isdefined(b_hide_hud)) {
            self flagsys::set(#"playing_movie_hide_hud");
            self val::set(#"play_movie", "show_hud", 0);
        }
        _play_movie_for_player(str_movie, str_type, 0, b_looping, str_key, n_timeout);
        if (isdefined(b_hide_hud) && isdefined(self)) {
            self flagsys::clear(#"playing_movie_hide_hud");
            self val::reset(#"play_movie", "show_hud");
        }
    }
    level notify(#"movie_done", {#type:str_type});
}

// Namespace lui/lui_shared
// Params 6, eflags: 0x4
// Checksum 0xf91ec44c, Offset: 0x10f0
// Size: 0x2f6
function private _play_movie_for_player(str_movie, str_type, show_black_screen, b_looping, str_key, n_timeout) {
    self endon(#"disconnect");
    str_menu = undefined;
    switch (str_type) {
    case #"fullscreen_additive":
    case #"fullscreen":
        str_menu = "FullScreenMovie";
        break;
    default:
        assertmsg("<dev string:x30>" + str_type + "<dev string:x45>");
        break;
    }
    if (str_type == "pip") {
        self playsoundtoplayer(#"uin_pip_open", self);
    }
    lui_menu = get_luimenu(str_menu);
    [[ lui_menu ]]->open(self);
    if (isdefined(lui_menu)) {
        [[ lui_menu ]]->set_moviename(self, str_movie);
        [[ lui_menu ]]->set_showblackscreen(self, show_black_screen);
        [[ lui_menu ]]->set_looping(self, b_looping);
        [[ lui_menu ]]->set_additive(self, 0);
        if (issubstr(str_type, "additive")) {
            [[ lui_menu ]]->set_additive(self, 1);
        }
        while (true) {
            if (isdefined(n_timeout)) {
                waitresult = self waittilltimeout(n_timeout, #"menuresponse");
            } else {
                waitresult = self waittill(#"menuresponse");
            }
            menu = waitresult.menu;
            response = waitresult.response;
            if (waitresult._notify == "timeout" || menu === hash(str_menu) && response === #"finished_movie_playback") {
                if (str_type == "pip") {
                    self playsoundtoplayer(#"uin_pip_close", self);
                }
                [[ lui_menu ]]->close(self);
                self notify(#"movie_done");
                break;
            }
        }
    }
}

// Namespace lui/lui_shared
// Params 1, eflags: 0x0
// Checksum 0xd3369fc4, Offset: 0x13f0
// Size: 0x318
function play_outro_movie(show_black_screen = 1) {
    outro_movie = getmapoutromovie();
    if (!isdefined(outro_movie) || outro_movie == #"") {
        return;
    }
    if (isarray(self)) {
        a_players = self;
    } else if (self == level) {
        a_players = level.players;
    }
    level flagsys::set("playing_outro_movie");
    if (isarray(a_players)) {
        foreach (player in a_players) {
            player flagsys::set("playing_movie_hide_hud");
            player val::set(#"play_movie", "show_hud", 0);
        }
        array::wait_till(a_players, "movie_done");
        foreach (player in a_players) {
            player flagsys::clear("playing_movie_hide_hud");
            player val::reset(#"play_movie", "show_hud");
        }
    } else {
        self flagsys::set("playing_movie_hide_hud");
        self val::set(#"play_movie", "show_hud", 0);
        if (isdefined(self)) {
            self flagsys::clear("playing_movie_hide_hud");
            self val::reset(#"play_movie", "show_hud");
        }
    }
    level flagsys::clear("playing_outro_movie");
    level notify(#"movie_done", {#type:"outro"});
}

// Namespace lui/lui_shared
// Params 0, eflags: 0x4
// Checksum 0x91cfeab6, Offset: 0x1710
// Size: 0x174
function private function_6b6a623d() {
    lui_menu = get_luimenu("FullScreenMovie");
    [[ lui_menu ]]->open(self);
    if (isdefined(lui_menu)) {
        [[ lui_menu ]]->set_playoutromovie(self, 1);
        [[ lui_menu ]]->set_showblackscreen(self, 1);
        while (true) {
            waitresult = self waittill(#"menuresponse");
            menu = waitresult.menu;
            response = waitresult.response;
            value = waitresult.value;
            if (menu === #"full_screen_movie") {
                if (response === #"finished_movie_playback") {
                    [[ lui_menu ]]->close(self);
                    self notify(#"movie_done");
                    break;
                }
                if (response === #"skippable" && isdefined(value)) {
                    [[ lui_menu ]]->function_7d4e5f11(self, value);
                }
            }
        }
    }
}

// Namespace lui/lui_shared
// Params 6, eflags: 0x0
// Checksum 0xe427517e, Offset: 0x1890
// Size: 0x154
function screen_flash(n_fadein_time, n_hold_time, n_fadeout_time, n_target_alpha = 1, v_color, b_force_close_menu = 0) {
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
// Params 7, eflags: 0x0
// Checksum 0x2ce43ba5, Offset: 0x19f0
// Size: 0x13c
function screen_fade(n_time, n_target_alpha = 1, n_start_alpha = 0, v_color, b_force_close_menu = 0, str_menu_id, var_a8e58224) {
    if (self == level) {
        foreach (player in level.players) {
            player thread _screen_fade(n_time, n_target_alpha, n_start_alpha, v_color, b_force_close_menu, str_menu_id, var_a8e58224);
        }
        return;
    }
    self thread _screen_fade(n_time, n_target_alpha, n_start_alpha, v_color, b_force_close_menu, str_menu_id, var_a8e58224);
}

// Namespace lui/lui_shared
// Params 4, eflags: 0x0
// Checksum 0x65fe35fb, Offset: 0x1b38
// Size: 0x52
function screen_fade_out(n_time, v_color, str_menu_id, var_a8e58224) {
    screen_fade(n_time, 1, 0, v_color, 0, str_menu_id, var_a8e58224);
    wait n_time;
}

// Namespace lui/lui_shared
// Params 4, eflags: 0x0
// Checksum 0x6e749663, Offset: 0x1b98
// Size: 0x52
function screen_fade_in(n_time, v_color, str_menu_id, var_a8e58224) {
    screen_fade(n_time, 0, 1, v_color, 1, str_menu_id, var_a8e58224);
    wait n_time;
}

// Namespace lui/lui_shared
// Params 0, eflags: 0x0
// Checksum 0xcf63357e, Offset: 0x1bf8
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
// Checksum 0x4785ea65, Offset: 0x1ca8
// Size: 0x10c
function private _screen_close_menu() {
    self notify(#"_screen_fade");
    self endon(#"_screen_fade");
    self endon(#"disconnect");
    if (isdefined(self.screen_fade_menus)) {
        foreach (str_menu_id, lui_menu in self.screen_fade_menus) {
            if (isint(lui_menu.lui_menu)) {
                self closeluimenu(lui_menu.lui_menu);
            } else {
                [[ lui_menu.lui_menu ]]->close(self);
            }
            self.screen_fade_menus[str_menu_id] = undefined;
        }
    }
}

// Namespace lui/lui_shared
// Params 7, eflags: 0x4
// Checksum 0x2a8a77e6, Offset: 0x1dc0
// Size: 0x5ba
function private _screen_fade(n_time, n_target_alpha, n_start_alpha, v_color, b_force_close_menu, str_menu_id = "default", var_a8e58224 = 0) {
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
    n_time_ms = int(int(n_time * 1000));
    str_menu = var_a8e58224 ? "FullScreenColorUnderHUD" : "FullScreenBlack";
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
    lui_menu = 0;
    if (isdefined(self.screen_fade_menus[str_menu_id])) {
        s_menu = self.screen_fade_menus[str_menu_id];
        lui_menu = s_menu.lui_menu;
        _one_screen_fade_per_network_frame(s_menu);
        n_start_alpha = lerpfloat(s_menu.n_start_alpha, s_menu.n_target_alpha, gettime() - s_menu.n_start_time);
    } else {
        if (isdefined(get_luimenu(str_menu))) {
            lui_menu = get_luimenu(str_menu);
            [[ lui_menu ]]->open(self);
        } else {
            lui_menu = self openluimenu(str_menu);
        }
        self.screen_fade_menus[str_menu_id] = spawnstruct();
        self.screen_fade_menus[str_menu_id].lui_menu = lui_menu;
    }
    self.screen_fade_menus[str_menu_id].n_start_alpha = n_start_alpha;
    self.screen_fade_menus[str_menu_id].n_target_alpha = n_target_alpha;
    self.screen_fade_menus[str_menu_id].n_target_time = n_time_ms;
    self.screen_fade_menus[str_menu_id].n_start_time = gettime();
    self set_color(lui_menu, v_color);
    if (isint(lui_menu)) {
        self setluimenudata(lui_menu, #"startalpha", n_start_alpha);
        self setluimenudata(lui_menu, #"endalpha", n_target_alpha);
        self setluimenudata(lui_menu, #"fadeovertime", n_time_ms);
    } else {
        [[ lui_menu ]]->set_startalpha(self, n_start_alpha);
        [[ lui_menu ]]->set_endalpha(self, n_target_alpha);
        [[ lui_menu ]]->set_fadeovertime(self, n_time_ms);
    }
    /#
        if (!isdefined(level.n_fade_debug_time)) {
            level.n_fade_debug_time = 0;
        }
        n_debug_time = gettime();
        if (n_debug_time - level.n_fade_debug_time > 5000) {
            printtoprightln("<dev string:x48>");
        }
        level.n_fade_debug_time = n_debug_time;
    #/
    if (n_time > 0) {
        wait n_time;
    }
    if (isint(lui_menu)) {
        self setluimenudata(lui_menu, #"fadeovertime", 0);
    } else {
        [[ lui_menu ]]->set_fadeovertime(self, 0);
    }
    if (isdefined(self.screen_fade_menus) && (b_force_close_menu || n_target_alpha == 0)) {
        if (isdefined(self.screen_fade_menus[str_menu_id])) {
            if (isint(lui_menu)) {
                self closeluimenu(self.screen_fade_menus[str_menu_id].lui_menu);
            } else {
                [[ lui_menu ]]->close(self);
            }
        }
        self.screen_fade_menus[str_menu_id] = undefined;
        if (!self.screen_fade_menus.size) {
            self.screen_fade_menus = undefined;
        }
    }
}

// Namespace lui/lui_shared
// Params 1, eflags: 0x4
// Checksum 0xce5ea082, Offset: 0x2388
// Size: 0x4e
function private _one_screen_fade_per_network_frame(s_menu) {
    while (s_menu.screen_fade_network_frame === level.network_frame) {
        util::wait_network_frame();
    }
    s_menu.screen_fade_network_frame = level.network_frame;
}

// Namespace lui/lui_shared
// Params 2, eflags: 0x0
// Checksum 0xb14911ba, Offset: 0x23e0
// Size: 0x166
function open_generic_script_dialog(title, description) {
    self endoncallback(&function_83c4bd9, #"close_generic_script_dialog", #"disconnect");
    dialog = self openluimenu("ScriptMessageDialog_Compact");
    self setluimenudata(dialog, #"title", title);
    self setluimenudata(dialog, #"description", description);
    self.var_4748a989 = dialog;
    do {
        waitresult = self waittill(#"menuresponse");
        menu = waitresult.menu;
        response = waitresult.response;
    } while (menu != "ScriptMessageDialog_Compact" || response != "close");
    self closeluimenu(dialog);
    self.var_4748a989 = undefined;
}

// Namespace lui/lui_shared
// Params 1, eflags: 0x0
// Checksum 0xb40784b0, Offset: 0x2550
// Size: 0x44
function function_83c4bd9(str_notify) {
    if (str_notify == "close_generic_script_dialog") {
        if (isdefined(self.var_4748a989)) {
            self closeluimenu(self.var_4748a989);
        }
    }
}

// Namespace lui/lui_shared
// Params 0, eflags: 0x0
// Checksum 0xea4e6799, Offset: 0x25a0
// Size: 0x16
function close_generic_script_dialog() {
    self notify(#"close_generic_script_dialog");
}

// Namespace lui/lui_shared
// Params 1, eflags: 0x0
// Checksum 0x18255166, Offset: 0x25c0
// Size: 0xc4
function open_script_dialog(dialog_name) {
    self endon(#"disconnect");
    dialog = self openluimenu(dialog_name);
    do {
        waitresult = self waittill(#"menuresponse");
        menu = waitresult.menu;
        response = waitresult.response;
    } while (menu != dialog_name || response != "close");
    self closeluimenu(dialog);
}

