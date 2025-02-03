#using scripts\core_common\callbacks_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace status_effect;

// Namespace status_effect/status_effects
// Params 0, eflags: 0x6
// Checksum 0xd78609c7, Offset: 0x80
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"status_effects", &preinit, undefined, undefined, undefined);
}

// Namespace status_effect/status_effects
// Params 0, eflags: 0x4
// Checksum 0x660974af, Offset: 0xc8
// Size: 0x7c
function private preinit() {
    callback::on_connect(&on_player_connect);
    callback::on_disconnect(&on_player_disconnect);
    callback::on_end_game(&on_end_game);
    /#
        level thread status_effects_init();
    #/
}

// Namespace status_effect/status_effects
// Params 0, eflags: 0x0
// Checksum 0xbbf598e2, Offset: 0x150
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
// Checksum 0x89140df8, Offset: 0x190
// Size: 0x1c
function on_player_disconnect() {
    /#
        self thread status_effects_devgui_player_disconnect();
    #/
}

// Namespace status_effect/status_effects
// Params 0, eflags: 0x0
// Checksum 0xaece5d7e, Offset: 0x1b8
// Size: 0x88
function on_end_game() {
    foreach (player in level.players) {
        player thread function_6519f95f();
    }
}

/#

    // Namespace status_effect/status_effects
    // Params 0, eflags: 0x0
    // Checksum 0x40aa29d5, Offset: 0x248
    // Size: 0xdc
    function status_effects_init() {
        setdvar(#"scr_status_effects_devgui_cmd", "<dev string:x38>");
        setdvar(#"scr_status_effects_devgui_arg", 0);
        setdvar(#"scr_status_effects_devgui_player", 0);
        if (isdedicated()) {
            return;
        }
        level.status_effects_devgui_base = "<dev string:x3c>";
        level.status_effects_devgui_player_connect = &status_effects_devgui_player_connect;
        level.status_effects_devgui_player_disconnect = &status_effects_devgui_player_disconnect;
        level thread status_effects_devgui_think();
    }

    // Namespace status_effect/status_effects
    // Params 0, eflags: 0x0
    // Checksum 0xcb17454b, Offset: 0x330
    // Size: 0x5c
    function status_effects_devgui_player_disconnect() {
        if (!isdefined(level.status_effects_devgui_base)) {
            return;
        }
        remove_cmd_with_root = "<dev string:x58>" + level.status_effects_devgui_base + self.playername + "<dev string:x6a>";
        util::add_queued_debug_command(remove_cmd_with_root);
    }

    // Namespace status_effect/status_effects
    // Params 0, eflags: 0x0
    // Checksum 0x8329a14a, Offset: 0x398
    // Size: 0x9c
    function status_effects_devgui_player_connect() {
        if (!isdefined(level.status_effects_devgui_base)) {
            return;
        }
        index = self getentitynumber() + 1;
        status_effects_devgui_add_player_status_effects(level.status_effects_devgui_base, self.playername, index);
        status_effects_devgui_add_player_grenades(level.status_effects_devgui_base, self.playername, index);
        function_2a302935(level.status_effects_devgui_base, self.playername, index);
    }

    // Namespace status_effect/status_effects
    // Params 3, eflags: 0x0
    // Checksum 0xcac13167, Offset: 0x440
    // Size: 0x84
    function function_2a302935(root, pname, index) {
        add_cmd_with_root = "<dev string:x71>" + root + pname + "<dev string:x80>";
        pid = "<dev string:x38>" + index;
        status_effects_devgui_add_player_command(add_cmd_with_root, pid, "<dev string:x85>", "<dev string:x9c>", undefined);
    }

    // Namespace status_effect/status_effects
    // Params 3, eflags: 0x0
    // Checksum 0x6fc5e5a5, Offset: 0x4d0
    // Size: 0x11c
    function status_effects_devgui_add_player_status_effects(root, pname, index) {
        add_cmd_with_root = "<dev string:x71>" + root + pname + "<dev string:xa9>";
        pid = "<dev string:x38>" + index;
        if (isdefined(level.var_233471d2)) {
            for (i = 0; i < level.var_233471d2.size; i++) {
                if (!isdefined(level.var_233471d2[i])) {
                    println("<dev string:xbd>" + i);
                }
                if (isdefined(level.var_233471d2[i].var_18d16a6b)) {
                    status_effects_devgui_add_player_command(add_cmd_with_root, pid, level.var_233471d2[i].var_18d16a6b, "<dev string:x13d>", i);
                }
            }
        }
    }

    // Namespace status_effect/status_effects
    // Params 3, eflags: 0x0
    // Checksum 0x587b2da6, Offset: 0x5f8
    // Size: 0x134
    function status_effects_devgui_add_player_grenades(root, pname, index) {
        add_cmd_with_root = "<dev string:x71>" + root + pname + "<dev string:x14b>";
        pid = "<dev string:x38>" + index;
        if (isdefined(level.var_233471d2)) {
            for (i = 0; i < level.var_233471d2.size; i++) {
                if (!isdefined(level.var_233471d2[i])) {
                    println("<dev string:x15f>" + i);
                }
                if (isdefined(level.var_233471d2[i].var_18d16a6b)) {
                    grenade = "<dev string:x1e7>" + level.var_233471d2[i].var_18d16a6b;
                    status_effects_devgui_add_player_command(add_cmd_with_root, pid, grenade, "<dev string:x201>", grenade);
                }
            }
        }
    }

    // Namespace status_effect/status_effects
    // Params 5, eflags: 0x0
    // Checksum 0x6ba4b203, Offset: 0x738
    // Size: 0xc4
    function status_effects_devgui_add_player_command(root, pid, cmdname, cmddvar, argdvar) {
        if (!isdefined(argdvar)) {
            argdvar = "<dev string:x211>";
        }
        adddebugcommand(root + cmdname + "<dev string:x21c>" + "<dev string:x227>" + "<dev string:x24b>" + pid + "<dev string:x250>" + "<dev string:x259>" + "<dev string:x24b>" + cmddvar + "<dev string:x250>" + "<dev string:x27a>" + "<dev string:x24b>" + argdvar + "<dev string:x6a>");
    }

    // Namespace status_effect/status_effects
    // Params 0, eflags: 0x0
    // Checksum 0xacc0e176, Offset: 0x808
    // Size: 0x178
    function status_effects_devgui_think() {
        for (;;) {
            cmd = getdvarstring(#"scr_status_effects_devgui_cmd");
            if (cmd == "<dev string:x38>") {
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
                function_64ba1c7e(pid);
            default:
                break;
            }
            setdvar(#"scr_status_effects_devgui_cmd", "<dev string:x38>");
            setdvar(#"scr_status_effects_devgui_arg", "<dev string:x38>");
            wait 0.5;
        }
    }

    // Namespace status_effect/status_effects
    // Params 1, eflags: 0x0
    // Checksum 0xcae0371f, Offset: 0x988
    // Size: 0x54
    function function_64ba1c7e(pid) {
        player = getplayers()[pid - 1];
        if (isdefined(player)) {
            player function_6519f95f();
        }
    }

    // Namespace status_effect/status_effects
    // Params 1, eflags: 0x0
    // Checksum 0x914d72fe, Offset: 0x9e8
    // Size: 0x8c
    function status_effects_set_active_effect(pid) {
        arg = getdvarint(#"scr_status_effects_devgui_arg", 0);
        player = getplayers()[pid - 1];
        if (isdefined(player)) {
            player function_e2bff3ce(arg, undefined, player);
        }
    }

    // Namespace status_effect/status_effects
    // Params 1, eflags: 0x0
    // Checksum 0x498984d4, Offset: 0xa80
    // Size: 0x21c
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
