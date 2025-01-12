#using script_64111d5c475f54c2;
#using scripts\core_common\flag_shared;
#using scripts\zm_common\zm_devgui;

#namespace zm_silver_util;

// Namespace zm_silver_util/zm_silver_util
// Params 0, eflags: 0x1 linked
// Checksum 0x302ff284, Offset: 0x78
// Size: 0x34
function init() {
    level.zm_silver_hud = zm_silver_hud::register();
    /#
        level thread function_37597f29();
    #/
}

// Namespace zm_silver_util/zm_silver_util
// Params 2, eflags: 0x1 linked
// Checksum 0xf44f9d6b, Offset: 0xb8
// Size: 0xd0
function function_30fe7a2(n_display_time = 0, str_waittill = undefined) {
    a_players = function_a1ef346b();
    foreach (player in a_players) {
        player thread function_2c918ed(n_display_time, str_waittill);
    }
}

// Namespace zm_silver_util/zm_silver_util
// Params 0, eflags: 0x1 linked
// Checksum 0x304ee90d, Offset: 0x190
// Size: 0xa0
function function_8fbe908e() {
    a_players = function_a1ef346b();
    foreach (player in a_players) {
        player thread function_b9adea4e();
    }
}

// Namespace zm_silver_util/zm_silver_util
// Params 0, eflags: 0x1 linked
// Checksum 0x1fd75bfa, Offset: 0x238
// Size: 0x44
function function_1aeb4889() {
    if (!level.zm_silver_hud zm_silver_hud::is_open(self)) {
        level.zm_silver_hud zm_silver_hud::open(self);
    }
}

// Namespace zm_silver_util/zm_silver_util
// Params 0, eflags: 0x0
// Checksum 0x3989c5e4, Offset: 0x288
// Size: 0x44
function close_hud() {
    if (level.zm_silver_hud zm_silver_hud::is_open(self)) {
        level.zm_silver_hud zm_silver_hud::close(self);
    }
}

// Namespace zm_silver_util/zm_silver_util
// Params 1, eflags: 0x1 linked
// Checksum 0x36f3b467, Offset: 0x2d8
// Size: 0x2c
function function_12995a01(status) {
    level.zm_silver_hud zm_silver_hud::function_9efecfd1(self, status);
}

// Namespace zm_silver_util/zm_silver_util
// Params 2, eflags: 0x1 linked
// Checksum 0xcf5eb685, Offset: 0x310
// Size: 0x124
function function_2c918ed(n_display_time = 0, str_waittill = undefined) {
    self endon(#"death");
    self function_1aeb4889();
    level.zm_silver_hud zm_silver_hud::set_state(self, #"hash_6cf1a586f517c6b0");
    if (n_display_time) {
        self waittilltimeout(n_display_time, #"death", #"disconnect", str_waittill);
    } else {
        self waittill(#"death", #"disconnect", str_waittill);
    }
    if (isdefined(self)) {
        if (level.zm_silver_hud zm_silver_hud::is_open(self)) {
            level.zm_silver_hud zm_silver_hud::set_state(self, #"hash_7fc6d62e63e7c7eb");
        }
    }
}

// Namespace zm_silver_util/zm_silver_util
// Params 0, eflags: 0x1 linked
// Checksum 0xe0a687ec, Offset: 0x440
// Size: 0x15c
function function_b9adea4e() {
    self endon(#"death");
    self function_1aeb4889();
    level.zm_silver_hud zm_silver_hud::set_state(self, #"hash_78afa944bedce9e5");
    while (true) {
        if (self flag::get(#"hash_7ef7aab6a305d0b0")) {
            self function_12995a01(#"hash_128884f6af1ec50e");
        } else if (self flag::get(#"hash_1154242c9b1e4518")) {
            self function_12995a01(#"hash_1b28943c2a3c98fb");
        } else {
            self function_12995a01(#"hash_2f75a1f4b67c97d2");
        }
        self waittill(#"hash_1154242c9b1e4518", #"hash_7ef7aab6a305d0b0");
    }
    level.zm_silver_hud zm_silver_hud::set_state(self, #"hash_5f0709f7c6680cea");
}

/#

    // Namespace zm_silver_util/zm_silver_util
    // Params 0, eflags: 0x0
    // Checksum 0x93f97b6d, Offset: 0x5a8
    // Size: 0xac
    function function_37597f29() {
        adddebugcommand("<dev string:x38>");
        adddebugcommand("<dev string:x8d>");
        adddebugcommand("<dev string:xf4>");
        adddebugcommand("<dev string:x16d>");
        level flag::wait_till("<dev string:x1dd>");
        zm_devgui::add_custom_devgui_callback(&function_72c803d3);
    }

    // Namespace zm_silver_util/zm_silver_util
    // Params 0, eflags: 0x0
    // Checksum 0xc12e96c6, Offset: 0x660
    // Size: 0x1c
    function function_14a89247() {
        function_30fe7a2(3);
    }

    // Namespace zm_silver_util/zm_silver_util
    // Params 0, eflags: 0x0
    // Checksum 0x6e85d8d9, Offset: 0x688
    // Size: 0x1c
    function function_701cd5cf() {
        function_8fbe908e();
    }

    // Namespace zm_silver_util/zm_silver_util
    // Params 2, eflags: 0x0
    // Checksum 0x3cec420e, Offset: 0x6b0
    // Size: 0x150
    function function_df4b3116(status, n_time) {
        if (!isdefined(n_time)) {
            n_time = 0;
        }
        a_players = function_a1ef346b();
        if (n_time) {
            foreach (player in a_players) {
                player thread flag::set_for_time(n_time, status);
            }
            return;
        }
        foreach (player in a_players) {
            player thread flag::toggle(status);
        }
    }

    // Namespace zm_silver_util/zm_silver_util
    // Params 1, eflags: 0x0
    // Checksum 0xa6c960e2, Offset: 0x808
    // Size: 0xf2
    function function_72c803d3(cmd) {
        switch (cmd) {
        case #"hash_bfe1136366775c6":
            function_14a89247();
            break;
        case #"hash_385b6dd43dd64f63":
            function_701cd5cf();
            break;
        case #"hash_61aa29debb64fda1":
            function_df4b3116(#"hash_1154242c9b1e4518");
            break;
        case #"hash_61aa28debb64fbee":
            function_df4b3116(#"hash_7ef7aab6a305d0b0", 2);
            break;
        default:
            break;
        }
    }

#/
