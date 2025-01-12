#using scripts\core_common\array_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\dev_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\weapons_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\mp_common\gametypes\globallogic_utils;

#namespace devgui;

/#

    // Namespace devgui/devgui
    // Params 0, eflags: 0x2
    // Checksum 0xbe1f3d02, Offset: 0xc8
    // Size: 0x4c
    function autoexec __init__system__() {
        system::register(#"devgui", &__init__, undefined, #"load");
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0x11a0dd0, Offset: 0x120
    // Size: 0x344
    function __init__() {
        util::set_dvar_if_unset("<dev string:x30>", "<dev string:x3f>");
        util::set_dvar_if_unset("<dev string:x40>", 0);
        util::set_dvar_if_unset("<dev string:x54>", 0);
        util::set_dvar_if_unset("<dev string:x70>", 0);
        util::set_dvar_if_unset("<dev string:x98>", 0);
        util::set_dvar_if_unset("<dev string:xba>", "<dev string:xdd>");
        level.attachment_cycling_dvars = [];
        level.attachment_cycling_dvars[level.attachment_cycling_dvars.size] = "<dev string:xe2>";
        level.attachment_cycling_dvars[level.attachment_cycling_dvars.size] = "<dev string:x101>";
        level.attachment_cycling_dvars[level.attachment_cycling_dvars.size] = "<dev string:x120>";
        level.attachment_cycling_dvars[level.attachment_cycling_dvars.size] = "<dev string:x13f>";
        level.attachment_cycling_dvars[level.attachment_cycling_dvars.size] = "<dev string:x15e>";
        level.attachment_cycling_dvars[level.attachment_cycling_dvars.size] = "<dev string:x17d>";
        level thread devgui_weapon_think();
        level thread devgui_weapon_asset_name_display_think();
        level thread devgui_player_weapons();
        level thread function_b960d41e();
        level thread dev::devgui_test_chart_think();
        level thread devgui_player_spawn_think();
        level thread devgui_vehicle_spawn_think();
        level thread function_859001e1();
        level thread function_2b2247e1();
        level thread dev::function_43a9e5a6();
        level thread function_bfe42701();
        level thread function_13eb324f();
        level thread function_cb135528();
        level thread function_d4324bae();
        thread init_debug_center_screen();
        level thread dev::body_customization_devgui(currentsessionmode());
        callback::on_connect(&hero_art_on_player_connect);
        callback::on_connect(&on_player_connect);
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0x970a4c73, Offset: 0x470
    // Size: 0x24
    function on_player_connect() {
        self.devguilockspawn = 0;
        self thread devgui_player_spawn();
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0x79e8323a, Offset: 0x4a0
    // Size: 0x148
    function devgui_player_spawn() {
        wait 1;
        player_devgui_base_mp = "<dev string:x19c>";
        waitframe(1);
        players = getplayers();
        foreach (player in players) {
            if (player != self) {
                continue;
            }
            temp = player_devgui_base_mp + player.playername + "<dev string:x1bb>" + "<dev string:x54>" + "<dev string:x1c3>" + player.playername + "<dev string:x1c5>";
            adddebugcommand(player_devgui_base_mp + player.playername + "<dev string:x1bb>" + "<dev string:x54>" + "<dev string:x1c3>" + player.playername + "<dev string:x1c5>");
        }
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0xd39ca7cb, Offset: 0x5f0
    // Size: 0x170
    function devgui_player_spawn_think() {
        for (;;) {
            playername = getdvarstring(#"mp_lockspawn_command_devgui");
            if (playername == "<dev string:x3f>") {
                waitframe(1);
                continue;
            }
            players = getplayers();
            foreach (player in players) {
                if (player.playername != playername) {
                    continue;
                }
                player.devguilockspawn = !player.devguilockspawn;
                if (player.devguilockspawn) {
                    player.resurrect_origin = player.origin;
                    player.resurrect_angles = player.angles;
                }
            }
            setdvar(#"mp_lockspawn_command_devgui", "<dev string:x3f>");
            wait 0.5;
        }
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0x697cc6c5, Offset: 0x768
    // Size: 0xee
    function devgui_vehicle_spawn_think() {
        waitframe(1);
        for (;;) {
            val = getdvarint(#"scr_spawnvehicle", 0);
            if (val != 0) {
                if (val == 1) {
                    add_vehicle_at_eye_trace("<dev string:x1c8>");
                } else if (val == 2) {
                    add_vehicle_at_eye_trace("<dev string:x1d1>");
                } else if (val == 3) {
                    add_vehicle_at_eye_trace("<dev string:x1df>");
                }
                setdvar(#"scr_spawnvehicle", 0);
            }
            waitframe(1);
        }
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0xcb0de9c4, Offset: 0x860
    // Size: 0x164
    function function_b960d41e() {
        level endon(#"game_ended");
        if (isdefined(game.var_cc616107) && game.var_cc616107) {
            return;
        }
        var_5a15530c = getscriptbundle("<dev string:x1e8>");
        player_devgui_base = "<dev string:x1ef>";
        setdvar(#"scr_boast_gesture", "<dev string:x3f>");
        if (isdefined(var_5a15530c) && isdefined(var_5a15530c.boasts)) {
            for (i = 0; i < var_5a15530c.boasts.size; i++) {
                var_66b0b16 = var_5a15530c.boasts[i].name;
                adddebugcommand(player_devgui_base + var_66b0b16 + "<dev string:x1bb>" + "<dev string:x212>" + "<dev string:x1c3>" + var_66b0b16);
            }
            game.var_cc616107 = 1;
        }
        level thread function_29671414();
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0x903ddb77, Offset: 0x9d0
    // Size: 0xde
    function function_29671414() {
        while (true) {
            gesture = getdvarstring(#"scr_boast_gesture");
            if (gesture != "<dev string:x3f>") {
                setdvar(#"bg_boastenabled", 1);
                players = getplayers();
                players[0] function_d65cc3c6(gesture);
                setdvar(#"scr_boast_gesture", "<dev string:x3f>");
            }
            waitframe(1);
        }
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0xd4a29fd9, Offset: 0xab8
    // Size: 0x60c
    function devgui_player_weapons() {
        level endon(#"game_ended");
        if (isdefined(game.devgui_weapons_added) && game.devgui_weapons_added) {
            return;
        }
        level flag::wait_till("<dev string:x224>");
        a_weapons = enumerateweapons("<dev string:x238>");
        a_weapons_mp = [];
        a_grenades_mp = [];
        a_misc_mp = [];
        var_a6216dd3 = [];
        for (i = 0; i < a_weapons.size; i++) {
            if (strstartswith(getweaponname(a_weapons[i]), "<dev string:x23f>")) {
                arrayinsert(var_a6216dd3, a_weapons[i], 0);
                continue;
            }
            if ((weapons::is_primary_weapon(a_weapons[i]) || weapons::is_side_arm(a_weapons[i])) && !killstreaks::is_killstreak_weapon(a_weapons[i])) {
                arrayinsert(a_weapons_mp, a_weapons[i], 0);
                continue;
            }
            if (weapons::is_grenade(a_weapons[i])) {
                arrayinsert(a_grenades_mp, a_weapons[i], 0);
                continue;
            }
            arrayinsert(a_misc_mp, a_weapons[i], 0);
        }
        player_devgui_base_mp = "<dev string:x243>";
        menu_index = 1;
        level thread devgui_add_player_weapons(player_devgui_base_mp, "<dev string:x25f>", 0, a_weapons_mp, "<dev string:x263>", menu_index);
        menu_index++;
        level thread devgui_add_player_weapons(player_devgui_base_mp, "<dev string:x25f>", 0, a_grenades_mp, "<dev string:x268>", menu_index);
        menu_index++;
        level thread devgui_add_player_weapons(player_devgui_base_mp, "<dev string:x25f>", 0, a_misc_mp, "<dev string:x271>", menu_index);
        menu_index++;
        level thread devgui_add_player_weapons(player_devgui_base_mp, "<dev string:x25f>", 0, var_a6216dd3, "<dev string:x276>", menu_index);
        menu_index++;
        game.devgui_weapons_added = 1;
        waitframe(1);
        adddebugcommand(player_devgui_base_mp + "<dev string:x283>" + "<dev string:x297>" + "<dev string:x70>" + "<dev string:x2a2>");
        menu_index++;
        adddebugcommand(player_devgui_base_mp + "<dev string:x2aa>" + "<dev string:x297>" + "<dev string:x40>" + "<dev string:x2a2>");
        menu_index++;
        adddebugcommand(player_devgui_base_mp + "<dev string:x2c5>" + "<dev string:x297>" + "<dev string:x98>" + "<dev string:x2a2>");
        menu_index++;
        waitframe(1);
        attachment_cycling_devgui_base_mp = player_devgui_base_mp + "<dev string:x2e6>" + "<dev string:x2f9>";
        adddebugcommand(attachment_cycling_devgui_base_mp + "<dev string:x2fb>" + "<dev string:xba>" + "<dev string:x30c>");
        adddebugcommand(attachment_cycling_devgui_base_mp + "<dev string:x31a>" + "<dev string:xba>" + "<dev string:x329>");
        attachmentnames = getattachmentnames();
        for (i = 0; i < 6; i++) {
            attachment_cycling_sub_menu_index = 1;
            adddebugcommand(attachment_cycling_devgui_base_mp + "<dev string:x334>" + i + 1 + "<dev string:x340>" + "<dev string:xba>" + "<dev string:x350>" + i + "<dev string:x358>");
            for (attachmentname = 0; attachmentname < attachmentnames.size; attachmentname++) {
                util::waittill_can_add_debug_command();
                adddebugcommand(attachment_cycling_devgui_base_mp + "<dev string:x334>" + i + 1 + "<dev string:x2f9>" + attachmentnames[attachmentname] + "<dev string:x1bb>" + "<dev string:xba>" + "<dev string:x35c>" + level.attachment_cycling_dvars[i] + "<dev string:x1c3>" + attachmentnames[attachmentname] + "<dev string:x358>");
                attachment_cycling_sub_menu_index++;
            }
            if (i % 4) {
                waitframe(1);
            }
        }
        level thread devgui_attachment_cycling_think();
    }

    // Namespace devgui/devgui
    // Params 6, eflags: 0x0
    // Checksum 0xef9fe121, Offset: 0x10d0
    // Size: 0x20e
    function devgui_add_player_weapons(root, pname, index, a_weapons, weapon_type, mindex) {
        level endon(#"game_ended");
        if (isdedicated()) {
            return;
        }
        devgui_root = root + weapon_type + "<dev string:x2f9>";
        if (isdefined(a_weapons)) {
            for (i = 0; i < a_weapons.size; i++) {
                attachments = a_weapons[i].supportedattachments;
                name = getweaponname(a_weapons[i]);
                if (attachments.size) {
                    devgui_add_player_weap_command(devgui_root + name + "<dev string:x2f9>", index, name, i + 1);
                    foreach (att in attachments) {
                        if (att != "<dev string:xdd>") {
                            devgui_add_player_weap_command(devgui_root + name + "<dev string:x2f9>", index, name + "<dev string:x36a>" + att, i + 1);
                        }
                    }
                    continue;
                }
                devgui_add_player_weap_command(devgui_root, index, name, i + 1);
            }
        }
    }

    // Namespace devgui/devgui
    // Params 4, eflags: 0x0
    // Checksum 0xc3cdc37b, Offset: 0x12e8
    // Size: 0x84
    function devgui_add_player_weap_command(root, pid, weap_name, cmdindex) {
        util::waittill_can_add_debug_command();
        adddebugcommand(root + weap_name + "<dev string:x1bb>" + "<dev string:x30>" + "<dev string:x1c3>" + weap_name + "<dev string:x358>");
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0xdff350f6, Offset: 0x1378
    // Size: 0xa0
    function devgui_weapon_think() {
        for (;;) {
            weapon_name = getdvarstring(#"mp_weap_devgui");
            if (weapon_name != "<dev string:x3f>") {
                devgui_handle_player_command(&devgui_give_weapon, weapon_name);
            }
            setdvar(#"mp_weap_devgui", "<dev string:x3f>");
            wait 0.5;
        }
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0x6761e6c2, Offset: 0x1420
    // Size: 0x22
    function hero_art_on_player_connect() {
        self._debugheromodels = spawnstruct();
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0x2543e26a, Offset: 0x1450
    // Size: 0x42e
    function devgui_weapon_asset_name_display_think() {
        update_time = 1;
        print_duration = int(update_time / float(function_f9f48566()) / 1000);
        printlnbold_update = int(1 / update_time);
        printlnbold_counter = 0;
        colors = [];
        colors[colors.size] = (1, 1, 1);
        colors[colors.size] = (1, 0, 0);
        colors[colors.size] = (0, 1, 0);
        colors[colors.size] = (1, 1, 0);
        colors[colors.size] = (1, 0, 1);
        colors[colors.size] = (0, 1, 1);
        for (;;) {
            wait update_time;
            display = getdvarint(#"mp_weap_asset_name_display_devgui", 0);
            if (!display) {
                continue;
            }
            if (!printlnbold_counter) {
                iprintlnbold(getweaponname(level.players[0] getcurrentweapon()));
            }
            printlnbold_counter++;
            if (printlnbold_counter >= printlnbold_update) {
                printlnbold_counter = 0;
            }
            color_index = 0;
            for (i = 1; i < level.players.size; i++) {
                player = level.players[i];
                weapon = player getcurrentweapon();
                if (!isdefined(weapon) || level.weaponnone == weapon) {
                    continue;
                }
                var_626fca71 = player gettagorigin("<dev string:x36c>");
                if (!isdefined(var_626fca71)) {
                    continue;
                }
                print3d(var_626fca71, getweaponname(weapon), colors[color_index], 1, 0.15, print_duration);
                color_index++;
                if (color_index >= colors.size) {
                    color_index = 0;
                }
            }
            color_index = 0;
            ai_list = getaiarray();
            for (i = 0; i < ai_list.size; i++) {
                ai = ai_list[i];
                if (isvehicle(ai)) {
                    weapon = ai.turretweapon;
                } else {
                    weapon = ai.weapon;
                }
                if (!isdefined(weapon) || level.weaponnone == weapon) {
                    continue;
                }
                var_626fca71 = ai gettagorigin("<dev string:x36c>");
                if (!isdefined(var_626fca71)) {
                    continue;
                }
                print3d(var_626fca71, getweaponname(weapon), colors[color_index], 1, 0.15, print_duration);
                color_index++;
                if (color_index >= colors.size) {
                    color_index = 0;
                }
            }
        }
    }

    // Namespace devgui/devgui
    // Params 1, eflags: 0x0
    // Checksum 0x3d9d0bc7, Offset: 0x1888
    // Size: 0x3c
    function devgui_attachment_cycling_clear(index) {
        setdvar(level.attachment_cycling_dvars[index], "<dev string:xdd>");
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0xd584f7d5, Offset: 0x18d0
    // Size: 0x3a4
    function devgui_attachment_cycling_update() {
        currentweapon = self getcurrentweapon();
        rootweapon = currentweapon.rootweapon;
        supportedattachments = currentweapon.supportedattachments;
        textcolors = [];
        attachments = [];
        originalattachments = [];
        for (i = 0; i < 6; i++) {
            originalattachments[i] = getdvarstring(level.attachment_cycling_dvars[i]);
            textcolor[i] = "<dev string:x376>";
            attachments[i] = "<dev string:xdd>";
            name = originalattachments[i];
            if ("<dev string:xdd>" == name) {
                continue;
            }
            textcolor[i] = "<dev string:x379>";
            for (supportedindex = 0; supportedindex < supportedattachments.size; supportedindex++) {
                if (name == supportedattachments[supportedindex]) {
                    textcolor[i] = "<dev string:x376>";
                    attachments[i] = name;
                    break;
                }
            }
        }
        for (i = 0; i < 6; i++) {
            if ("<dev string:xdd>" == originalattachments[i]) {
                continue;
            }
            for (j = i + 1; j < 6; j++) {
                if (originalattachments[i] == originalattachments[j]) {
                    textcolor[j] = "<dev string:x37c>";
                    attachments[j] = "<dev string:xdd>";
                }
            }
        }
        msg = "<dev string:x3f>";
        for (i = 0; i < 6; i++) {
            if ("<dev string:xdd>" == originalattachments[i]) {
                continue;
            }
            msg += textcolor[i];
            msg += i;
            msg += "<dev string:x37f>";
            msg += originalattachments[i];
            msg += "<dev string:x382>";
        }
        iprintlnbold(msg);
        self takeweapon(currentweapon);
        currentweapon = getweapon(rootweapon.name, attachments[0], attachments[1], attachments[2], attachments[3], attachments[4], attachments[5]);
        wait 0.25;
        self giveweapon(currentweapon, undefined);
        self switchtoweapon(currentweapon);
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0xd4824bae, Offset: 0x1c80
    // Size: 0x178
    function devgui_attachment_cycling_think() {
        for (;;) {
            state = getdvarstring(#"mp_attachment_cycling_state_devgui");
            setdvar(#"mp_attachment_cycling_state_devgui", "<dev string:xdd>");
            if (issubstr(state, "<dev string:x385>")) {
                if ("<dev string:x38c>" == state) {
                    for (i = 0; i < 6; i++) {
                        devgui_attachment_cycling_clear(i);
                    }
                } else {
                    index = int(getsubstr(state, 6, 7));
                    devgui_attachment_cycling_clear(index);
                }
                state = "<dev string:x396>";
            }
            if ("<dev string:x396>" == state) {
                array::thread_all(getplayers(), &devgui_attachment_cycling_update);
            }
            wait 0.5;
        }
    }

    // Namespace devgui/devgui
    // Params 1, eflags: 0x0
    // Checksum 0x810f6f83, Offset: 0x1e00
    // Size: 0x804
    function devgui_give_weapon(weapon_name) {
        assert(isdefined(self));
        assert(isplayer(self));
        self notify(#"devgui_give_ammo");
        self endon(#"devgui_give_ammo");
        endtime = gettime() + 10000;
        while (!isalive(self) && gettime() < endtime) {
            wait 0.25;
        }
        if (!isalive(self)) {
            util::warning("<dev string:x39d>" + weapon_name + "<dev string:x3ad>" + self.name + "<dev string:x3b2>" + self.name + "<dev string:x3bc>");
            return;
        }
        takeweapon = undefined;
        currentweapon = self getcurrentweapon();
        if (strstartswith(weapon_name, "<dev string:x3cb>")) {
            split = strtok(weapon_name, "<dev string:x3dd>");
            if (isdefined(split[2])) {
                if (split[2] == "<dev string:x3df>") {
                    var_224c94ef = 1;
                } else if (split[2] == "<dev string:x3e4>") {
                    var_224c94ef = -1;
                }
                currentweaponname = currentweapon.name;
                currentattachment = "<dev string:xdd>";
                if (isdefined(currentweapon.attachments) && isdefined(currentweapon.attachments[0]) && currentweapon.attachments[0] != "<dev string:x3f>") {
                    currentattachment = currentweapon.attachments[0];
                }
                supportedattachments = currentweapon.supportedattachments;
                var_60429539 = -1;
                if (supportedattachments.size) {
                    var_60429539 = supportedattachments.size;
                    for (i = 0; i < supportedattachments.size; i++) {
                        if (supportedattachments[i] == currentattachment) {
                            var_60429539 = i;
                            break;
                        }
                    }
                }
                weapon = currentweapon;
                nextindex = -1;
                if (var_60429539 == supportedattachments.size) {
                    if (var_224c94ef > 0) {
                        nextindex = 0;
                    } else {
                        nextindex = supportedattachments.size - 1;
                    }
                } else if (var_60429539 >= 0) {
                    nextindex = (supportedattachments.size + var_60429539 + var_224c94ef) % supportedattachments.size;
                }
                if (nextindex >= 0 && nextindex < supportedattachments.size) {
                    if (isdefined(supportedattachments[nextindex])) {
                        attachment = supportedattachments[nextindex];
                        takeweapon = currentweapon;
                        weapon = getweapon(currentweaponname, attachment);
                    }
                }
            }
        } else {
            split = strtok(weapon_name, "<dev string:x36a>");
            switch (split.size) {
            case 1:
            default:
                weapon = getweapon(split[0]);
                break;
            case 2:
                weapon = getweapon(split[0], split[1]);
                break;
            case 3:
                weapon = getweapon(split[0], split[1], split[2]);
                break;
            case 4:
                weapon = getweapon(split[0], split[1], split[2], split[3]);
                break;
            case 5:
                weapon = getweapon(split[0], split[1], split[2], split[3], split[4]);
                break;
            }
        }
        if (currentweapon != weapon) {
            if (weapon.isgrenadeweapon && !getdvarint(#"hash_1fce8e806b5356fc", 0)) {
                grenades = 0;
                pweapons = self getweaponslist();
                foreach (pweapon in pweapons) {
                    if (pweapon != weapon && pweapon.isgrenadeweapon) {
                        grenades++;
                    }
                }
                if (grenades > 1) {
                    foreach (pweapon in pweapons) {
                        if (pweapon != weapon && pweapon.isgrenadeweapon) {
                            grenades--;
                            self takeweapon(pweapon);
                            if (grenades < 2) {
                                break;
                            }
                        }
                    }
                }
            }
            if (isdefined(takeweapon)) {
                self takeweapon(takeweapon);
            }
            if (getdvarint(#"mp_weap_use_give_console_command_devgui", 0)) {
                adddebugcommand("<dev string:x3e9>" + weapon_name);
                waitframe(1);
            } else {
                self giveweapon(weapon);
                if (!weapon.isgrenadeweapon) {
                    self switchtoweapon(weapon);
                }
            }
            max = weapon.maxammo;
            if (max) {
                self setweaponammostock(weapon, max);
            }
        }
    }

    // Namespace devgui/devgui
    // Params 3, eflags: 0x0
    // Checksum 0xb78be45c, Offset: 0x2610
    // Size: 0x134
    function devgui_handle_player_command(playercallback, pcb_param_1, pcb_param_2) {
        pid = getdvarint(#"mp_weap_devgui", 0);
        if (pid > 0) {
            player = getplayers()[pid - 1];
            if (isdefined(player)) {
                if (isdefined(pcb_param_2)) {
                    player thread [[ playercallback ]](pcb_param_1, pcb_param_2);
                } else if (isdefined(pcb_param_1)) {
                    player thread [[ playercallback ]](pcb_param_1);
                } else {
                    player thread [[ playercallback ]]();
                }
            }
        } else {
            array::thread_all(getplayers(), playercallback, pcb_param_1, pcb_param_2);
        }
        setdvar(#"mp_weap_devgui", "<dev string:x3ef>");
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0x3556199c, Offset: 0x2750
    // Size: 0x12c
    function init_debug_center_screen() {
        zero_idle_movement = 0;
        for (;;) {
            if (getdvarint(#"debug_center_screen", 0)) {
                if (!isdefined(level.center_screen_debug_hudelem_active) || level.center_screen_debug_hudelem_active == 0) {
                    thread debug_center_screen();
                    zero_idle_movement = getdvarint(#"zero_idle_movement", 0);
                    if (zero_idle_movement == 0) {
                        setdvar(#"zero_idle_movement", 1);
                        zero_idle_movement = 1;
                    }
                }
            } else {
                level notify(#"stop center screen debug");
                if (zero_idle_movement == 1) {
                    setdvar(#"zero_idle_movement", 0);
                    zero_idle_movement = 0;
                }
            }
            waitframe(1);
        }
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0xf5ec4d69, Offset: 0x2888
    // Size: 0x24a
    function debug_center_screen() {
        level.center_screen_debug_hudelem_active = 1;
        wait 0.1;
        level.center_screen_debug_hudelem1 = newdebughudelem(level.players[0]);
        level.center_screen_debug_hudelem1.alignx = "<dev string:x3f2>";
        level.center_screen_debug_hudelem1.aligny = "<dev string:x3f9>";
        level.center_screen_debug_hudelem1.fontscale = 1;
        level.center_screen_debug_hudelem1.alpha = 0.5;
        level.center_screen_debug_hudelem1.x = 320 - 1;
        level.center_screen_debug_hudelem1.y = 240;
        level.center_screen_debug_hudelem1 setshader("<dev string:x400>", 1000, 1);
        level.center_screen_debug_hudelem2 = newdebughudelem(level.players[0]);
        level.center_screen_debug_hudelem2.alignx = "<dev string:x3f2>";
        level.center_screen_debug_hudelem2.aligny = "<dev string:x3f9>";
        level.center_screen_debug_hudelem2.fontscale = 1;
        level.center_screen_debug_hudelem2.alpha = 0.5;
        level.center_screen_debug_hudelem2.x = 320 - 1;
        level.center_screen_debug_hudelem2.y = 240;
        level.center_screen_debug_hudelem2 setshader("<dev string:x400>", 1, 480);
        level waittill(#"stop center screen debug");
        level.center_screen_debug_hudelem1 destroy();
        level.center_screen_debug_hudelem2 destroy();
        level.center_screen_debug_hudelem_active = 0;
    }

    // Namespace devgui/devgui
    // Params 1, eflags: 0x0
    // Checksum 0x6cf5cb8c, Offset: 0x2ae0
    // Size: 0x12a
    function add_vehicle_at_eye_trace(vehiclename) {
        host = util::gethostplayer();
        trace = host bot::eye_trace();
        veh_spawner = getent(vehiclename + "<dev string:x406>", "<dev string:x40f>");
        vehicle = veh_spawner spawnfromspawner(vehiclename, 1, 1, 1);
        vehicle asmrequestsubstate(#"locomotion@movement");
        waitframe(1);
        vehicle makevehicleusable();
        vehicle.origin = trace[#"position"];
        vehicle.nojumping = 1;
        vehicle thread watch_player_death();
        return vehicle;
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0x11e216d9, Offset: 0x2c18
    // Size: 0x8e
    function watch_player_death() {
        self endon(#"death");
        vehicle = self;
        while (true) {
            driver = self getseatoccupant(0);
            if (isdefined(driver) && !isalive(driver)) {
                driver unlink();
            }
            waitframe(1);
        }
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0xcaf1c9f7, Offset: 0x2cb0
    // Size: 0x54
    function devgui_add_ve_map_switches() {
        adddebugcommand("<dev string:x41a>");
        adddebugcommand("<dev string:x468>");
        adddebugcommand("<dev string:x4c0>");
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0xcc8b5de6, Offset: 0x2d10
    // Size: 0x65e
    function function_cb135528() {
        level notify(#"hash_254f5df0e8f1d66");
        level endon(#"hash_254f5df0e8f1d66");
        setdvar(#"hash_3a3f995b08f2b9b8", -1);
        setdvar(#"hash_2aab28ebf600b8c7", -1);
        setdvar(#"hash_4874e2dd28221d6c", -1);
        wait 0.5;
        path = "<dev string:x506>";
        cmd = "<dev string:x523>";
        util::add_devgui(path + "<dev string:x544>", cmd + "<dev string:x54a>");
        for (minutes = 0; minutes < 10; minutes++) {
            for (seconds = 0; seconds < 60; seconds += 15) {
                var_5e7b16f7 = "<dev string:x3f>" + seconds;
                totalseconds = minutes * 60 + seconds;
                if (seconds == 0) {
                    if (minutes == 0) {
                        totalseconds = 1;
                        var_5e7b16f7 = "<dev string:x54c>";
                    } else {
                        var_5e7b16f7 = "<dev string:x54f>";
                    }
                }
                util::add_devgui(path + minutes + "<dev string:x552>" + var_5e7b16f7, cmd + totalseconds);
            }
            waitframe(1);
        }
        var_25796932 = "<dev string:x554>";
        var_bb774781 = "<dev string:x56f>";
        var_826a3deb = "<dev string:x58e>";
        var_8690076 = "<dev string:x5a7>";
        if (util::isroundbased()) {
            var_8e88f2d0 = level.roundlimit * level.roundscorelimit;
        } else {
            var_8e88f2d0 = level.scorelimit;
        }
        var_8e88f2d0 = math::clamp(var_8e88f2d0, 0, 300);
        wait 0.5;
        for (score = 0; score <= var_8e88f2d0; score++) {
            var_8229ad9f = int(score / 10) * 10;
            var_577f5929 = int(score / 10) * 10 + 10;
            util::add_devgui(var_25796932 + var_8229ad9f + "<dev string:x5c4>" + var_577f5929 + "<dev string:x5c7>" + var_8229ad9f + "<dev string:x2f9>" + score, var_bb774781 + score);
            util::add_devgui(var_826a3deb + var_8229ad9f + "<dev string:x5c4>" + var_577f5929 + "<dev string:x5c7>" + var_8229ad9f + "<dev string:x2f9>" + score, var_8690076 + score);
            if (score == var_577f5929) {
                waitframe(1);
            }
        }
        while (true) {
            if (getdvarint(#"hash_3a3f995b08f2b9b8", -1) != -1) {
                var_ebfdfdad = getdvarint(#"hash_3a3f995b08f2b9b8", -1);
                var_34ccc737 = (int(var_ebfdfdad * 1000) + globallogic_utils::gettimepassed()) / int(60 * 1000);
                if (var_ebfdfdad == 0) {
                    var_34ccc737 = 0;
                }
                setdvar(#"timelimit_override", var_34ccc737);
                setdvar(#"hash_3a3f995b08f2b9b8", -1);
            }
            if (getdvarint(#"hash_2aab28ebf600b8c7", -1) != -1) {
                var_7b665fb8 = getdvarint(#"hash_2aab28ebf600b8c7", -1);
                [[ level._setteamscore ]](#"allies", var_7b665fb8);
                setdvar(#"hash_2aab28ebf600b8c7", -1);
            }
            if (getdvarint(#"hash_4874e2dd28221d6c", -1) != -1) {
                var_df4a549 = getdvarint(#"hash_4874e2dd28221d6c", -1);
                [[ level._setteamscore ]](#"axis", var_df4a549);
                setdvar(#"hash_4874e2dd28221d6c", -1);
            }
            wait 1;
        }
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0xec4b0ffc, Offset: 0x3378
    // Size: 0x1a0
    function function_859001e1() {
        level notify(#"hash_6a8b1c9e1485919d");
        level endon(#"hash_6a8b1c9e1485919d");
        wait 5;
        function_e2f6bef5();
        wait 1;
        while (true) {
            wait 0.25;
            remaining_health = getdvarint(#"hash_28af507d964c5802", 0);
            if (remaining_health <= 0) {
                continue;
            }
            player = level.players[0];
            if (isplayer(player)) {
                remaining_health = math::clamp(remaining_health, 0, isdefined(player.maxhealth) ? player.maxhealth : 100);
                damage = player.health - remaining_health;
                if (damage <= 0) {
                    player.health = remaining_health;
                } else {
                    player dodamage(damage, player.origin + (100, 0, 0));
                }
            }
            setdvar(#"hash_28af507d964c5802", 0);
        }
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0x8ae298a, Offset: 0x3520
    // Size: 0x1b8
    function function_bfe42701() {
        level notify(#"hash_4c09c9d01060d7ad");
        level endon(#"hash_4c09c9d01060d7ad");
        wait 2;
        function_fe712960();
        wait 0.5;
        while (true) {
            wait 0.5;
            if (level.gameended) {
                continue;
            }
            var_b6197d3b = getdvarint(#"scr_end_round", 0);
            if (var_b6197d3b == 0) {
                continue;
            }
            setdvar(#"scr_end_round", 0);
            var_d8518127 = getgametypesetting(#"timelimit");
            var_59932c19 = 0.25;
            setgametypesetting("<dev string:x5c9>", var_59932c19);
            for (aborted = 0; !level.gameended && !aborted; aborted = getgametypesetting(#"timelimit") != var_59932c19) {
                wait 0.5;
            }
            if (!aborted) {
                setgametypesetting("<dev string:x5c9>", var_d8518127);
            }
        }
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0x6c66f3a, Offset: 0x36e0
    // Size: 0x1d8
    function function_2b2247e1() {
        level notify(#"hash_7528b3262d076f59");
        level endon(#"hash_7528b3262d076f59");
        wait 5.5;
        function_b093dde2();
        wait 1;
        while (true) {
            wait 0.25;
            damage = getdvarint(#"scr_damage_health", 0);
            if (damage == 0) {
                continue;
            }
            player = level.players[0];
            if (isplayer(player)) {
                if (damage <= 0) {
                    heal = damage * -1;
                    var_63f2cd6e = player.var_63f2cd6e < 0 ? player.maxhealth : player.var_63f2cd6e;
                    if (!isdefined(var_63f2cd6e)) {
                        var_63f2cd6e = 100;
                    }
                    if (player.health + heal > var_63f2cd6e) {
                        player.health = var_63f2cd6e;
                    } else {
                        player.health += heal;
                    }
                } else {
                    player dodamage(damage, player.origin + (100, 0, 0));
                }
            }
            setdvar(#"scr_damage_health", 0);
        }
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0x81558980, Offset: 0x38c0
    // Size: 0x250
    function function_13eb324f() {
        level notify(#"hash_6534754fb1d75ea7");
        level endon(#"hash_6534754fb1d75ea7");
        while (!isdefined(level.scoreinfo)) {
            wait 1;
        }
        function_d27128f6();
        while (true) {
            wait 0.1;
            actionid = getdvarint(#"hash_649ea18bd5e55893", -1);
            var_e1581549 = getdvarint(#"hash_6ad3f58a8e0a1e59", -1);
            hotstreakstage = getdvarint(#"scr_hotstreak_stage", -1);
            if (actionid == -1 && var_e1581549 == -1 && hotstreakstage == -1) {
                continue;
            }
            player = level.players[0];
            if (isplayer(player)) {
                if (actionid != -1) {
                    player luinotifyevent(#"challenge_coin_received", 1, actionid);
                }
                if (var_e1581549 != -1) {
                    player luinotifyevent(#"end_sustaining_action", 1, var_e1581549);
                }
                if (hotstreakstage != -1) {
                    player clientfield::set_player_uimodel("<dev string:x5d3>", hotstreakstage);
                }
            }
            setdvar(#"hash_649ea18bd5e55893", -1);
            setdvar(#"hash_6ad3f58a8e0a1e59", -1);
        }
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0x6fa3f302, Offset: 0x3b18
    // Size: 0x124
    function function_e2f6bef5() {
        path = "<dev string:x5ec>";
        cmd = "<dev string:x602>";
        util::add_devgui(path + "<dev string:x61c>", cmd + "<dev string:x627>");
        util::add_devgui(path + "<dev string:x629>", cmd + "<dev string:x635>");
        util::add_devgui(path + "<dev string:x638>", cmd + "<dev string:x644>");
        util::add_devgui(path + "<dev string:x647>", cmd + "<dev string:x653>");
        util::add_devgui(path + "<dev string:x656>", cmd + "<dev string:x663>");
        util::add_devgui(path + "<dev string:x667>", cmd + "<dev string:x677>");
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0x80987f86, Offset: 0x3c48
    // Size: 0x174
    function function_b093dde2() {
        path = "<dev string:x67c>";
        cmd = "<dev string:x697>";
        util::add_devgui(path + "<dev string:x6ae>", cmd + "<dev string:x6c0>");
        util::add_devgui(path + "<dev string:x6c4>", cmd + "<dev string:x6d5>");
        util::add_devgui(path + "<dev string:x6d8>", cmd + "<dev string:x3ef>");
        util::add_devgui(path + "<dev string:x6e9>", cmd + "<dev string:x6fb>");
        util::add_devgui(path + "<dev string:x6fd>", cmd + "<dev string:x627>");
        util::add_devgui(path + "<dev string:x70f>", cmd + "<dev string:x722>");
        util::add_devgui(path + "<dev string:x725>", cmd + "<dev string:x739>");
        util::add_devgui(path + "<dev string:x73d>", cmd + "<dev string:x751>");
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0x4a255834, Offset: 0x3dc8
    // Size: 0x2c
    function function_fe712960() {
        util::add_devgui("<dev string:x755>", "<dev string:x76d>");
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0x65adc232, Offset: 0x3e00
    // Size: 0x2cc
    function function_d27128f6() {
        path = "<dev string:x781>";
        cmd = "<dev string:x791>";
        var_b16deb02 = "<dev string:x7aa>";
        var_8067ad05 = getarraykeys(level.scoreinfo);
        for (i = 0; i < var_8067ad05.size; i++) {
            key = var_8067ad05[i];
            action = level.scoreinfo[key];
            if (isdefined(action) && isdefined(action[#"row"])) {
                if (isdefined(action[#"job_type"])) {
                    keystring = function_15979fa9(key);
                    util::add_devgui(path + "<dev string:x7c7>" + keystring[0] + "<dev string:x2f9>" + keystring, cmd + action[#"row"]);
                    if (isdefined(action[#"hash_401b1493e5188252"]) && action[#"hash_401b1493e5188252"] == #"ender") {
                        util::add_devgui(path + "<dev string:x7cd>" + keystring[0] + "<dev string:x2f9>" + keystring, var_b16deb02 + action[#"row"]);
                    }
                }
            }
        }
        var_6ecc27b3 = path + "<dev string:x7d2>";
        var_cca676ce = "<dev string:x7e3>";
        util::add_devgui(var_6ecc27b3 + "<dev string:x7fc>", var_cca676ce + "<dev string:x54a>");
        util::add_devgui(var_6ecc27b3 + "<dev string:x808>", var_cca676ce + "<dev string:x6fb>");
        util::add_devgui(var_6ecc27b3 + "<dev string:x814>", var_cca676ce + "<dev string:x820>");
        util::add_devgui(var_6ecc27b3 + "<dev string:x822>", var_cca676ce + "<dev string:x82e>");
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x4
    // Checksum 0xeaadb9b2, Offset: 0x40d8
    // Size: 0x1de
    function private function_d4324bae() {
        if (isnavvolumeloaded()) {
        }
        util::add_devgui("<dev string:x830>", "<dev string:x851>");
        util::add_devgui("<dev string:x868>", "<dev string:x88a>");
        while (true) {
            if (getdvarint(#"scr_drone_camera", 0)) {
                if (isdefined(level.drone_camera)) {
                    waitframe(1);
                    continue;
                }
                player = getplayers()[0];
                if (!isdefined(player)) {
                    waitframe(1);
                    continue;
                }
                drone_camera = spawnvehicle("<dev string:x8a1>", player.origin + (0, 0, 150), player.angles, "<dev string:x8b5>");
                drone_camera.ignoreme = 1;
                drone_camera usevehicle(player, 0);
                level.drone_camera = drone_camera;
            } else if (isdefined(level.drone_camera)) {
                driver = level.drone_camera getseatoccupant(0);
                if (isdefined(driver)) {
                    driver unlink();
                }
                level.drone_camera delete();
            }
            waitframe(1);
        }
    }

#/
