#using scripts\core_common\callbacks_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace status_effect;

// Namespace status_effect/status_effects
// Params 0, eflags: 0x2
// Checksum 0x2f24293d, Offset: 0x88
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"status_effects", &__init__, undefined, undefined);
}

// Namespace status_effect/status_effects
// Params 0, eflags: 0x0
// Checksum 0xa5d0c6f2, Offset: 0xd0
// Size: 0x7c
function __init__() {
    callback::on_connect(&on_player_connect);
    callback::on_disconnect(&on_player_disconnect);
    callback::on_end_game(&on_end_game);
    /#
        level thread status_effects_init();
    #/
}

// Namespace status_effect/status_effects
// Params 0, eflags: 0x0
// Checksum 0x3f02c729, Offset: 0x158
// Size: 0x34
function on_player_connect() {
    if (!isdefined(self._gadgets_player)) {
        self._gadgets_player = [];
    }
    /#
        self thread status_effects_devgui_player_connect();
    #/
}

// Namespace status_effect/status_effects
// Params 0, eflags: 0x0
// Checksum 0x489d7f7d, Offset: 0x198
// Size: 0x1c
function on_player_disconnect() {
    /#
        self thread status_effects_devgui_player_disconnect();
    #/
}

// Namespace status_effect/status_effects
// Params 0, eflags: 0x0
// Checksum 0x3b9e5acb, Offset: 0x1c0
// Size: 0x80
function on_end_game() {
    foreach (player in level.players) {
        player thread function_3332ef07();
    }
}

/#

    // Namespace status_effect/status_effects
    // Params 0, eflags: 0x0
    // Checksum 0x81ac66b4, Offset: 0x248
    // Size: 0xe4
    function status_effects_init() {
        setdvar(#"scr_status_effects_devgui_cmd", "<dev string:x30>");
        setdvar(#"scr_status_effects_devgui_arg", 0);
        setdvar(#"scr_status_effects_devgui_player", 0);
        if (isdedicated()) {
            return;
        }
        level.status_effects_devgui_base = "<dev string:x31>";
        level.status_effects_devgui_player_connect = &status_effects_devgui_player_connect;
        level.status_effects_devgui_player_disconnect = &status_effects_devgui_player_disconnect;
        level thread status_effects_devgui_think();
    }

    // Namespace status_effect/status_effects
    // Params 0, eflags: 0x0
    // Checksum 0x770e374d, Offset: 0x338
    // Size: 0x5c
    function status_effects_devgui_player_disconnect() {
        if (!isdefined(level.status_effects_devgui_base)) {
            return;
        }
        remove_cmd_with_root = "<dev string:x4a>" + level.status_effects_devgui_base + self.playername + "<dev string:x59>";
        util::add_queued_debug_command(remove_cmd_with_root);
    }

    // Namespace status_effect/status_effects
    // Params 0, eflags: 0x0
    // Checksum 0x6587c020, Offset: 0x3a0
    // Size: 0x108
    function status_effects_devgui_player_connect() {
        if (!isdefined(level.status_effects_devgui_base)) {
            return;
        }
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (players[i] != self) {
                continue;
            }
            status_effects_devgui_add_player_status_effects(level.status_effects_devgui_base, players[i].playername, i + 1);
            status_effects_devgui_add_player_grenades(level.status_effects_devgui_base, players[i].playername, i + 1);
            function_1d4fb2a9(level.status_effects_devgui_base, players[i].playername, i + 1);
            return;
        }
    }

    // Namespace status_effect/status_effects
    // Params 3, eflags: 0x0
    // Checksum 0xf95e40de, Offset: 0x4b0
    // Size: 0x8c
    function function_1d4fb2a9(root, pname, index) {
        add_cmd_with_root = "<dev string:x5d>" + root + pname + "<dev string:x69>";
        pid = "<dev string:x30>" + index;
        status_effects_devgui_add_player_command(add_cmd_with_root, pid, "<dev string:x6b>", "<dev string:x7f>", undefined);
    }

    // Namespace status_effect/status_effects
    // Params 3, eflags: 0x0
    // Checksum 0x59c8ced4, Offset: 0x548
    // Size: 0x11e
    function status_effects_devgui_add_player_status_effects(root, pname, index) {
        add_cmd_with_root = "<dev string:x5d>" + root + pname + "<dev string:x89>";
        pid = "<dev string:x30>" + index;
        if (isdefined(level.var_693f098d)) {
            for (i = 0; i < level.var_693f098d.size; i++) {
                if (!isdefined(level.var_693f098d[i])) {
                    println("<dev string:x9a>" + i);
                }
                if (isdefined(level.var_693f098d[i].var_d20b8ed2)) {
                    status_effects_devgui_add_player_command(add_cmd_with_root, pid, level.var_693f098d[i].var_d20b8ed2, "<dev string:x117>", i);
                }
            }
        }
    }

    // Namespace status_effect/status_effects
    // Params 3, eflags: 0x0
    // Checksum 0x7c32c338, Offset: 0x670
    // Size: 0x136
    function status_effects_devgui_add_player_grenades(root, pname, index) {
        add_cmd_with_root = "<dev string:x5d>" + root + pname + "<dev string:x122>";
        pid = "<dev string:x30>" + index;
        if (isdefined(level.var_693f098d)) {
            for (i = 0; i < level.var_693f098d.size; i++) {
                if (!isdefined(level.var_693f098d[i])) {
                    println("<dev string:x133>" + i);
                }
                if (isdefined(level.var_693f098d[i].var_d20b8ed2)) {
                    grenade = "<dev string:x1b8>" + level.var_693f098d[i].var_d20b8ed2;
                    status_effects_devgui_add_player_command(add_cmd_with_root, pid, grenade, "<dev string:x1cf>", grenade);
                }
            }
        }
    }

    // Namespace status_effect/status_effects
    // Params 5, eflags: 0x0
    // Checksum 0x5ebcc568, Offset: 0x7b0
    // Size: 0xc4
    function status_effects_devgui_add_player_command(root, pid, cmdname, cmddvar, argdvar) {
        if (!isdefined(argdvar)) {
            argdvar = "<dev string:x1dc>";
        }
        adddebugcommand(root + cmdname + "<dev string:x1e4>" + "<dev string:x1ec>" + "<dev string:x20d>" + pid + "<dev string:x20f>" + "<dev string:x215>" + "<dev string:x20d>" + cmddvar + "<dev string:x20f>" + "<dev string:x233>" + "<dev string:x20d>" + argdvar + "<dev string:x59>");
    }

    // Namespace status_effect/status_effects
    // Params 0, eflags: 0x0
    // Checksum 0xbfb58925, Offset: 0x880
    // Size: 0x178
    function status_effects_devgui_think() {
        for (;;) {
            cmd = getdvarstring(#"scr_status_effects_devgui_cmd");
            if (cmd == "<dev string:x30>") {
                waitframe(1);
                continue;
            }
            pid = getdvarint(#"scr_status_effects_devgui_player", 0);
            switch (cmd) {
            case #"set_active":
                status_effects_set_active_effect(pid);
                break;
            case #"give_grenade":
                status_effects_give_grenade(pid);
                break;
            case #"clear_all":
                function_59248ab0(pid);
            default:
                break;
            }
            setdvar(#"scr_status_effects_devgui_cmd", "<dev string:x30>");
            setdvar(#"scr_status_effects_devgui_arg", "<dev string:x30>");
            wait 0.5;
        }
    }

    // Namespace status_effect/status_effects
    // Params 1, eflags: 0x0
    // Checksum 0x43a26fe2, Offset: 0xa00
    // Size: 0x54
    function function_59248ab0(pid) {
        player = getplayers()[pid - 1];
        if (isdefined(player)) {
            player function_3332ef07();
        }
    }

    // Namespace status_effect/status_effects
    // Params 1, eflags: 0x0
    // Checksum 0xc96e8a48, Offset: 0xa60
    // Size: 0x8c
    function status_effects_set_active_effect(pid) {
        arg = getdvarint(#"scr_status_effects_devgui_arg", 0);
        player = getplayers()[pid - 1];
        if (isdefined(player)) {
            player function_8ca25db4(arg, undefined, player);
        }
    }

    // Namespace status_effect/status_effects
    // Params 1, eflags: 0x0
    // Checksum 0x7bbef87, Offset: 0xaf8
    // Size: 0x20c
    function status_effects_give_grenade(pid) {
        arg = getdvarstring(#"scr_status_effects_devgui_arg");
        player = getplayers()[pid - 1];
        if (isdefined(player)) {
            weapon = getweapon(arg);
            grenades = 0;
            pweapons = player getweaponslist();
            foreach (pweapon in pweapons) {
                if (pweapon != weapon && pweapon.isgrenadeweapon) {
                    grenades++;
                }
            }
            if (grenades > 1) {
                foreach (pweapon in pweapons) {
                    if (pweapon != weapon && pweapon.isgrenadeweapon) {
                        grenades--;
                        player takeweapon(pweapon);
                        if (grenades < 2) {
                            break;
                        }
                    }
                }
            }
            player giveweapon(weapon);
        }
    }

#/
