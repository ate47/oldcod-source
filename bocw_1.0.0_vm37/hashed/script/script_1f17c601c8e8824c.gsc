#using script_396f7d71538c9677;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\weapon_utils;

#namespace battlechatter;

/#

    // Namespace battlechatter/namespace_2987c8a4
    // Params 0, eflags: 0x0
    // Checksum 0x230acc59, Offset: 0xa0
    // Size: 0x408
    function devgui_think() {
        setdvar(#"devgui_mpdialog", "<dev string:x38>");
        setdvar(#"testalias_player", "<dev string:x3c>");
        setdvar(#"testalias_taacom", "<dev string:x5a>");
        setdvar(#"testalias_commander", "<dev string:x77>");
        while (true) {
            wait 1;
            player = util::gethostplayer();
            if (!isdefined(player)) {
                continue;
            }
            spacing = getdvarfloat(#"testdialog_spacing", 0.25);
            switch (getdvarstring(#"devgui_mpdialog", "<dev string:x38>")) {
            case #"hash_7912e80189f9c6":
                player thread test_player_dialog(0);
                player thread test_taacom_dialog(spacing);
                player thread test_commander_dialog(2 * spacing);
                break;
            case #"hash_69c6be086f76a9d4":
                player thread test_player_dialog(0);
                player thread test_commander_dialog(spacing);
                break;
            case #"hash_3af5f0a904b3f8fa":
                player thread test_other_dialog(0);
                player thread test_commander_dialog(spacing);
                break;
            case #"hash_32945da5f7ac491":
                player thread test_taacom_dialog(0);
                player thread test_commander_dialog(spacing);
                break;
            case #"hash_597b27a5c8857d19":
                player thread test_player_dialog(0);
                player thread test_taacom_dialog(spacing);
                break;
            case #"hash_74f798193af006b3":
                player thread test_other_dialog(0);
                player thread test_taacom_dialog(spacing);
                break;
            case #"hash_5bd6a2c5d0ff3cb2":
                player thread test_other_dialog(0);
                player thread test_player_dialog(spacing);
                break;
            case #"hash_4a5a66c89be92eb":
                player thread play_conv_self_other();
                break;
            case #"hash_18683ef7652f40ed":
                player thread play_conv_other_self();
                break;
            case #"hash_2b559b1a5e81715f":
                player thread play_conv_other_other();
                break;
            }
            setdvar(#"devgui_mpdialog", "<dev string:x38>");
        }
    }

    // Namespace battlechatter/namespace_2987c8a4
    // Params 1, eflags: 0x0
    // Checksum 0xc838bc46, Offset: 0x4b0
    // Size: 0xea
    function test_other_dialog(delay) {
        players = arraysort(level.players, self.origin);
        foreach (player in players) {
            if (player != self && isalive(player)) {
                player thread test_player_dialog(delay);
                return;
            }
        }
    }

    // Namespace battlechatter/namespace_2987c8a4
    // Params 1, eflags: 0x0
    // Checksum 0x3a80f29a, Offset: 0x5a8
    // Size: 0x64
    function test_player_dialog(delay) {
        if (!isdefined(delay)) {
            delay = 0;
        }
        wait delay;
        self playsoundontag(getdvarstring(#"testalias_player", "<dev string:x38>"), "<dev string:x9b>");
    }

    // Namespace battlechatter/namespace_2987c8a4
    // Params 1, eflags: 0x0
    // Checksum 0x2e7a1596, Offset: 0x618
    // Size: 0x5c
    function test_taacom_dialog(delay) {
        if (!isdefined(delay)) {
            delay = 0;
        }
        wait delay;
        self playlocalsound(getdvarstring(#"testalias_taacom", "<dev string:x38>"));
    }

    // Namespace battlechatter/namespace_2987c8a4
    // Params 1, eflags: 0x0
    // Checksum 0xab72f64e, Offset: 0x680
    // Size: 0x5c
    function test_commander_dialog(delay) {
        if (!isdefined(delay)) {
            delay = 0;
        }
        wait delay;
        self playlocalsound(getdvarstring(#"testalias_commander", "<dev string:x38>"));
    }

    // Namespace battlechatter/namespace_2987c8a4
    // Params 1, eflags: 0x0
    // Checksum 0x91f16907, Offset: 0x6e8
    // Size: 0x54
    function play_test_dialog(dialogkey) {
        dialogalias = self get_player_dialog_alias(dialogkey, undefined);
        self playsoundontag(dialogalias, "<dev string:x9b>");
    }

    // Namespace battlechatter/namespace_2987c8a4
    // Params 0, eflags: 0x0
    // Checksum 0xf193c7ab, Offset: 0x748
    // Size: 0x10c
    function response_key() {
        switch (self getmpdialogname()) {
        case #"spectre":
            return "<dev string:xa5>";
        case #"battery":
            return "<dev string:xb0>";
        case #"outrider":
            return "<dev string:xbb>";
        case #"prophet":
            return "<dev string:xc7>";
        case #"firebreak":
            return "<dev string:xd2>";
        case #"reaper":
            return "<dev string:xdf>";
        case #"ruin":
            return "<dev string:xe9>";
        case #"seraph":
            return "<dev string:xf1>";
        case #"nomad":
            return "<dev string:xfb>";
        }
        return "<dev string:x38>";
    }

    // Namespace battlechatter/namespace_2987c8a4
    // Params 0, eflags: 0x0
    // Checksum 0xf73761a5, Offset: 0x860
    // Size: 0x144
    function play_conv_self_other() {
        num = randomintrange(0, 4);
        self play_test_dialog("<dev string:x104>" + num);
        wait 4;
        players = arraysort(level.players, self.origin);
        foreach (player in players) {
            if (player != self && isalive(player)) {
                player play_test_dialog("<dev string:x112>" + self response_key() + num);
                break;
            }
        }
    }

    // Namespace battlechatter/namespace_2987c8a4
    // Params 0, eflags: 0x0
    // Checksum 0x6d6e484, Offset: 0x9b0
    // Size: 0x144
    function play_conv_other_self() {
        num = randomintrange(0, 4);
        players = arraysort(level.players, self.origin);
        foreach (player in players) {
            if (player != self && isalive(player)) {
                player play_test_dialog("<dev string:x104>" + num);
                break;
            }
        }
        wait 4;
        self play_test_dialog("<dev string:x112>" + player response_key() + num);
    }

    // Namespace battlechatter/namespace_2987c8a4
    // Params 0, eflags: 0x0
    // Checksum 0xbf4a3e66, Offset: 0xb00
    // Size: 0x1ec
    function play_conv_other_other() {
        num = randomintrange(0, 4);
        players = arraysort(level.players, self.origin);
        foreach (player in players) {
            if (player != self && isalive(player)) {
                player play_test_dialog("<dev string:x104>" + num);
                firstplayer = player;
                break;
            }
        }
        wait 4;
        foreach (player in players) {
            if (player != self && player !== firstplayer && isalive(player)) {
                player play_test_dialog("<dev string:x112>" + firstplayer response_key() + num);
                break;
            }
        }
    }

#/
