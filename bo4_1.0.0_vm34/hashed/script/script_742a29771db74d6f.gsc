#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace zm_arcade_timer;

// Namespace zm_arcade_timer
// Method(s) 9 Total 16
class czm_arcade_timer : cluielem {

    var var_57a3d576;

    // Namespace czm_arcade_timer/zm_arcade_timer
    // Params 2, eflags: 0x0
    // Checksum 0x6be3546e, Offset: 0xa70
    // Size: 0x3c
    function set_title(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "title", value);
    }

    // Namespace czm_arcade_timer/zm_arcade_timer
    // Params 2, eflags: 0x0
    // Checksum 0xb0a8f57d, Offset: 0xa28
    // Size: 0x3c
    function set_minutes(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "minutes", value);
    }

    // Namespace czm_arcade_timer/zm_arcade_timer
    // Params 2, eflags: 0x0
    // Checksum 0x682fb4fe, Offset: 0x9e0
    // Size: 0x3c
    function set_seconds(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "seconds", value);
    }

    // Namespace czm_arcade_timer/zm_arcade_timer
    // Params 2, eflags: 0x0
    // Checksum 0xabb75b24, Offset: 0x998
    // Size: 0x3c
    function set_showzero(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "showzero", value);
    }

    // Namespace czm_arcade_timer/zm_arcade_timer
    // Params 1, eflags: 0x0
    // Checksum 0x17561d07, Offset: 0x968
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace czm_arcade_timer/zm_arcade_timer
    // Params 2, eflags: 0x0
    // Checksum 0x25fbf559, Offset: 0x918
    // Size: 0x44
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, "zm_arcade_timer", persistent);
    }

    // Namespace czm_arcade_timer/zm_arcade_timer
    // Params 1, eflags: 0x0
    // Checksum 0x4f2e1e8e, Offset: 0x848
    // Size: 0xc4
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("showzero", 1, 1, "int");
        cluielem::add_clientfield("seconds", 1, 6, "int");
        cluielem::add_clientfield("minutes", 1, 4, "int");
        cluielem::function_52818084("string", "title", 1);
    }

}

// Namespace zm_arcade_timer/zm_arcade_timer
// Params 3, eflags: 0x0
// Checksum 0xbd267462, Offset: 0xd8
// Size: 0x134
function set_timer(player, var_348e23ad, var_ef67aac3) {
    self open_timer(player);
    n_minutes = int(floor(var_348e23ad / 60));
    n_seconds = int(var_348e23ad - n_minutes * 60);
    self set_minutes(player, n_minutes);
    self set_seconds(player, n_seconds);
    if (n_seconds < 10) {
        self set_showzero(player, 1);
    } else {
        self set_showzero(player, 0);
    }
    if (isdefined(var_ef67aac3)) {
        self set_title(player, var_ef67aac3);
    }
}

// Namespace zm_arcade_timer/zm_arcade_timer
// Params 1, eflags: 0x0
// Checksum 0xfdc1a099, Offset: 0x218
// Size: 0xc0
function function_a9f676cf(str_notify) {
    foreach (player in level.players) {
        if (isdefined(level.var_49197edc) && level.var_49197edc is_open(player)) {
            level.var_49197edc close(player);
        }
    }
}

// Namespace zm_arcade_timer/zm_arcade_timer
// Params 4, eflags: 0x0
// Checksum 0x45ea4308, Offset: 0x2e0
// Size: 0x19c
function function_49fb9a81(player, var_348e23ad, var_ef67aac3, var_2de72807 = 0) {
    player endon(#"disconnect", #"hash_660dedc4af5b4336");
    level endoncallback(&function_a9f676cf, #"end_game");
    if (!var_2de72807) {
        player endoncallback(&function_1c9127dd, #"hash_2a4a6c3c411261d8");
    }
    self function_4ba8fb9c(player);
    if (var_2de72807 || !isdefined(player.var_8f5fe43e)) {
        player.var_8f5fe43e = var_ef67aac3;
    }
    while (var_348e23ad >= 0) {
        if (player.var_8f5fe43e === var_ef67aac3) {
            self set_timer(player, var_348e23ad, var_ef67aac3);
        }
        wait 1;
        var_348e23ad--;
        if (!isdefined(player.var_8f5fe43e)) {
            player.var_8f5fe43e = var_ef67aac3;
        }
    }
    if (player.var_8f5fe43e === var_ef67aac3) {
        player.var_8f5fe43e = undefined;
    }
    self function_7ccee86d(player, 0, var_ef67aac3);
}

// Namespace zm_arcade_timer/zm_arcade_timer
// Params 1, eflags: 0x0
// Checksum 0xb562750f, Offset: 0x488
// Size: 0x3c
function function_1c9127dd(str_notify) {
    if (!isdefined(self.var_dcdf21b8)) {
        self.var_dcdf21b8 = 0;
    }
    if (self.var_dcdf21b8 > 0) {
        self.var_dcdf21b8--;
    }
}

// Namespace zm_arcade_timer/zm_arcade_timer
// Params 1, eflags: 0x0
// Checksum 0x583e95a2, Offset: 0x4d0
// Size: 0x4c
function function_4ba8fb9c(player) {
    if (!isdefined(player.var_dcdf21b8)) {
        player.var_dcdf21b8 = 0;
    }
    player.var_dcdf21b8++;
    self open_timer(player);
}

// Namespace zm_arcade_timer/zm_arcade_timer
// Params 1, eflags: 0x0
// Checksum 0x2d8598e8, Offset: 0x528
// Size: 0x44
function open_timer(player) {
    if (!self is_open(player)) {
        self open(player, 1);
    }
}

// Namespace zm_arcade_timer/zm_arcade_timer
// Params 3, eflags: 0x0
// Checksum 0x80cf1c, Offset: 0x578
// Size: 0x110
function function_7ccee86d(player, b_force_close = 0, var_ef67aac3) {
    if (!isdefined(player.var_dcdf21b8)) {
        player.var_dcdf21b8 = 0;
    }
    player.var_dcdf21b8--;
    if (player.var_8f5fe43e === var_ef67aac3) {
        player.var_8f5fe43e = undefined;
    }
    if (self is_open(player) && (player.var_dcdf21b8 <= 0 || b_force_close)) {
        player.var_dcdf21b8 = 0;
        self close(player);
        player notify(#"hash_2a4a6c3c411261d8");
        player.var_8f5fe43e = undefined;
        if (b_force_close) {
            player notify(#"hash_660dedc4af5b4336");
        }
    }
}

// Namespace zm_arcade_timer/zm_arcade_timer
// Params 1, eflags: 0x0
// Checksum 0x7e063410, Offset: 0x690
// Size: 0x40
function register(uid) {
    elem = new czm_arcade_timer();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace zm_arcade_timer/zm_arcade_timer
// Params 2, eflags: 0x0
// Checksum 0xb81400de, Offset: 0x6d8
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace zm_arcade_timer/zm_arcade_timer
// Params 1, eflags: 0x0
// Checksum 0xfeb5c932, Offset: 0x718
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_arcade_timer/zm_arcade_timer
// Params 1, eflags: 0x0
// Checksum 0x58c684e4, Offset: 0x740
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_76692f88(player);
}

// Namespace zm_arcade_timer/zm_arcade_timer
// Params 2, eflags: 0x0
// Checksum 0x1d0c2603, Offset: 0x768
// Size: 0x28
function set_showzero(player, value) {
    [[ self ]]->set_showzero(player, value);
}

// Namespace zm_arcade_timer/zm_arcade_timer
// Params 2, eflags: 0x0
// Checksum 0xa62b39b8, Offset: 0x798
// Size: 0x28
function set_seconds(player, value) {
    [[ self ]]->set_seconds(player, value);
}

// Namespace zm_arcade_timer/zm_arcade_timer
// Params 2, eflags: 0x0
// Checksum 0x69b5cd94, Offset: 0x7c8
// Size: 0x28
function set_minutes(player, value) {
    [[ self ]]->set_minutes(player, value);
}

// Namespace zm_arcade_timer/zm_arcade_timer
// Params 2, eflags: 0x0
// Checksum 0x8ce431df, Offset: 0x7f8
// Size: 0x28
function set_title(player, value) {
    [[ self ]]->set_title(player, value);
}

