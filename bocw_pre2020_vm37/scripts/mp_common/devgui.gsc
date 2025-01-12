#using script_7edb54aca54e9a2b;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\dev_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\weapons_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\mp_common\gametypes\globallogic_utils;

#namespace devgui;

/#

    // Namespace devgui/devgui
    // Params 0, eflags: 0x6
    // Checksum 0x262a253f, Offset: 0xc8
    // Size: 0x4c
    function private autoexec __init__system__() {
        system::register(#"devgui", &function_70a657d8, undefined, undefined, #"load");
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x4
    // Checksum 0xb62f76fd, Offset: 0x120
    // Size: 0x37c
    function private function_70a657d8() {
        level.var_f9f04b00 = debug_center_screen::register();
        function_5ac4dc99("<dev string:x38>", "<dev string:x4a>");
        function_5ac4dc99("<dev string:x4e>", 0);
        function_5ac4dc99("<dev string:x65>", "<dev string:x4a>");
        function_5ac4dc99("<dev string:x84>", 0);
        function_5ac4dc99("<dev string:xaf>", 0);
        function_5ac4dc99("<dev string:xd4>", "<dev string:xfa>");
        level.attachment_cycling_dvars = [];
        level.attachment_cycling_dvars[level.attachment_cycling_dvars.size] = "<dev string:x102>";
        level.attachment_cycling_dvars[level.attachment_cycling_dvars.size] = "<dev string:x124>";
        level.attachment_cycling_dvars[level.attachment_cycling_dvars.size] = "<dev string:x146>";
        level.attachment_cycling_dvars[level.attachment_cycling_dvars.size] = "<dev string:x168>";
        level.attachment_cycling_dvars[level.attachment_cycling_dvars.size] = "<dev string:x18a>";
        level.attachment_cycling_dvars[level.attachment_cycling_dvars.size] = "<dev string:x1ac>";
        level.attachment_cycling_dvars[level.attachment_cycling_dvars.size] = "<dev string:x1ce>";
        level.attachment_cycling_dvars[level.attachment_cycling_dvars.size] = "<dev string:x1f0>";
        level thread devgui_weapon_think();
        level thread devgui_weapon_asset_name_display_think();
        level thread devgui_player_weapons();
        level thread function_cb7cee87();
        level thread dev::devgui_test_chart_think();
        level thread devgui_player_spawn_think();
        level thread devgui_vehicle_spawn_think();
        level thread function_7bef8d25();
        level thread function_be0f9897();
        level thread dev::function_487bf571();
        level thread function_46b22d99();
        level thread function_773432e2();
        level thread function_6a24e58f();
        level thread function_57edec18();
        thread init_debug_center_screen();
        level thread dev::body_customization_devgui(currentsessionmode());
        callback::on_connect(&hero_art_on_player_connect);
        callback::on_connect(&on_player_connect);
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0xa3af3652, Offset: 0x4a8
    // Size: 0x24
    function on_player_connect() {
        self.devguilockspawn = 0;
        self thread devgui_player_spawn();
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0x1dad38f1, Offset: 0x4d8
    // Size: 0x158
    function devgui_player_spawn() {
        wait 1;
        player_devgui_base_mp = "<dev string:x212>";
        waitframe(1);
        players = getplayers();
        foreach (player in players) {
            if (player != self) {
                continue;
            }
            temp = player_devgui_base_mp + player.playername + "<dev string:x234>" + "<dev string:x65>" + "<dev string:x23f>" + player.playername + "<dev string:x244>";
            adddebugcommand(player_devgui_base_mp + player.playername + "<dev string:x234>" + "<dev string:x65>" + "<dev string:x23f>" + player.playername + "<dev string:x244>");
        }
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0xc3458cdc, Offset: 0x638
    // Size: 0x168
    function devgui_player_spawn_think() {
        for (;;) {
            playername = getdvarstring(#"mp_lockspawn_command_devgui");
            if (playername == "<dev string:x4a>") {
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
            setdvar(#"mp_lockspawn_command_devgui", "<dev string:x4a>");
            wait 0.5;
        }
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0xb2162f9b, Offset: 0x7a8
    // Size: 0xee
    function devgui_vehicle_spawn_think() {
        waitframe(1);
        for (;;) {
            val = getdvarint(#"scr_spawnvehicle", 0);
            if (val != 0) {
                if (val == 1) {
                    add_vehicle_at_eye_trace("<dev string:x24a>");
                } else if (val == 2) {
                    add_vehicle_at_eye_trace("<dev string:x256>");
                } else if (val == 3) {
                    add_vehicle_at_eye_trace("<dev string:x267>");
                }
                setdvar(#"scr_spawnvehicle", 0);
            }
            waitframe(1);
        }
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0xc17bb020, Offset: 0x8a0
    // Size: 0x2fc
    function function_cb7cee87() {
        if (is_true(game.var_461b2589)) {
            return;
        }
        self notify("<dev string:x273>");
        self endon("<dev string:x273>");
        level endon(#"game_ended");
        player_devgui_base = "<dev string:x287>";
        setdvar(#"scr_boast_gesture", "<dev string:x4a>");
        util::add_devgui(player_devgui_base + "<dev string:x2a1>", "<dev string:x2b1>" + "<dev string:x2b9>" + "<dev string:x2ce>");
        while (getdvarstring(#"scr_boast_gesture", "<dev string:x4a>") == "<dev string:x4a>") {
            wait 1;
        }
        game.var_461b2589 = 1;
        setdvar(#"scr_boast_gesture", "<dev string:x4a>");
        var_fca60300 = function_5e2d2d9b();
        foreach (item_hash, boasts in var_fca60300) {
            item_root = player_devgui_base + function_9e72a96(item_hash) + "<dev string:x2d4>";
            foreach (boast in boasts) {
                util::add_devgui(item_root + function_9e72a96(boast), "<dev string:x2b1>" + "<dev string:x2b9>" + "<dev string:x23f>" + function_9e72a96(boast));
            }
            waitframe(1);
        }
        util::remove_devgui(player_devgui_base + "<dev string:x2a1>");
        level thread function_42644f29();
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0x3b5f2dca, Offset: 0xba8
    // Size: 0x14e
    function function_42644f29() {
        while (true) {
            level.boastplayer = getdvarint(#"scr_boast_player", 0);
            gesture = getdvarstring(#"scr_boast_gesture");
            if (gesture != "<dev string:x4a>") {
                setdvar(#"bg_boastenabled", 1);
                players = getplayers();
                if (isdefined(level.boastplayer) && isdefined(players[level.boastplayer])) {
                    players[level.boastplayer] function_c6775cf9(gesture);
                } else {
                    players[0] function_c6775cf9(gesture);
                }
                setdvar(#"scr_boast_gesture", "<dev string:x4a>");
            }
            waitframe(1);
        }
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0x872e186f, Offset: 0xd00
    // Size: 0x6d4
    function devgui_player_weapons() {
        level endon(#"game_ended");
        if (is_true(game.devgui_weapons_added)) {
            return;
        }
        level flag::wait_till("<dev string:x2d9>");
        a_weapons = enumerateweapons("<dev string:x2f0>");
        var_b4bc030d = [];
        var_179cce42 = [];
        var_5046ba65 = [];
        var_dce9ec82 = [];
        var_a327f68 = [];
        a_misc_mp = [];
        foreach (weapon in a_weapons) {
            weapon_index = getitemindexfromref(weapon.name);
            if (weapon_index > 0) {
                var_c8570f9 = getunlockableiteminfofromindex(weapon_index, 1);
                if (isdefined(var_c8570f9.loadoutslotname)) {
                    switch (var_c8570f9.loadoutslotname) {
                    case #"primary":
                        arrayinsert(var_b4bc030d, weapon, 0);
                        continue;
                    case #"secondary":
                        arrayinsert(var_179cce42, weapon, 0);
                        continue;
                    case #"primarygrenade":
                        arrayinsert(var_5046ba65, weapon, 0);
                        continue;
                    case #"secondarygrenade":
                        arrayinsert(var_dce9ec82, weapon, 0);
                        continue;
                    case #"specialgrenade":
                        arrayinsert(var_a327f68, weapon, 0);
                        continue;
                    }
                }
            }
            arrayinsert(a_misc_mp, weapon, 0);
        }
        menu_index = 100;
        level thread devgui_add_player_weapons("<dev string:x2fa>", var_b4bc030d, "<dev string:x319>", menu_index);
        menu_index++;
        level thread devgui_add_player_weapons("<dev string:x2fa>", var_179cce42, "<dev string:x32a>", menu_index);
        menu_index++;
        level thread devgui_add_player_weapons("<dev string:x2fa>", var_5046ba65, "<dev string:x33d>", menu_index);
        menu_index++;
        level thread devgui_add_player_weapons("<dev string:x2fa>", var_dce9ec82, "<dev string:x354>", menu_index);
        menu_index++;
        level thread devgui_add_player_weapons("<dev string:x2fa>", var_a327f68, "<dev string:x36d>", menu_index);
        menu_index++;
        level thread devgui_add_player_weapons("<dev string:x2fa>", a_misc_mp, "<dev string:x383>", menu_index);
        game.devgui_weapons_added = 1;
        waitframe(1);
        adddebugcommand("<dev string:x2fa>" + "<dev string:x38f>" + "<dev string:x3a6>" + "<dev string:x84>" + "<dev string:x3b4>");
        adddebugcommand("<dev string:x2fa>" + "<dev string:x3bf>" + "<dev string:x3a6>" + "<dev string:x4e>" + "<dev string:x3b4>");
        adddebugcommand("<dev string:x2fa>" + "<dev string:x3dd>" + "<dev string:x3a6>" + "<dev string:xaf>" + "<dev string:x3b4>");
        waitframe(1);
        menu_index = 30;
        attachment_cycling_devgui_base_mp = "<dev string:x2fa>" + "<dev string:x401>" + menu_index + "<dev string:x2d4>";
        adddebugcommand(attachment_cycling_devgui_base_mp + "<dev string:x418>" + "<dev string:xd4>" + "<dev string:x42c>");
        adddebugcommand(attachment_cycling_devgui_base_mp + "<dev string:x43d>" + "<dev string:xd4>" + "<dev string:x44f>");
        attachmentnames = getattachmentnames();
        for (i = 0; i < 8; i++) {
            attachment_cycling_sub_menu_index = 1;
            adddebugcommand(attachment_cycling_devgui_base_mp + "<dev string:x45d>" + i + 1 + "<dev string:x46c>" + "<dev string:xd4>" + "<dev string:x47f>" + i + "<dev string:x48a>");
            for (attachmentname = 0; attachmentname < attachmentnames.size; attachmentname++) {
                util::waittill_can_add_debug_command();
                adddebugcommand(attachment_cycling_devgui_base_mp + "<dev string:x45d>" + i + 1 + "<dev string:x2d4>" + attachmentnames[attachmentname] + "<dev string:x234>" + "<dev string:xd4>" + "<dev string:x491>" + level.attachment_cycling_dvars[i] + "<dev string:x23f>" + attachmentnames[attachmentname] + "<dev string:x48a>");
                attachment_cycling_sub_menu_index++;
            }
            if (i % 4) {
                waitframe(1);
            }
        }
        level thread devgui_attachment_cycling_think();
    }

    // Namespace devgui/devgui
    // Params 4, eflags: 0x0
    // Checksum 0xeb0db0f2, Offset: 0x13e0
    // Size: 0x2a0
    function devgui_add_player_weapons(root, a_weapons, weapon_type, mindex) {
        level endon(#"game_ended");
        if (isdedicated()) {
            return;
        }
        devgui_root = root + weapon_type + "<dev string:x4a2>" + mindex + "<dev string:x2d4>";
        if (isdefined(a_weapons)) {
            foreach (weapon in a_weapons) {
                attachments = weapon.supportedattachments;
                name = getweaponname(weapon);
                displayname = weapon.displayname;
                if (displayname == #"") {
                    displayname = "<dev string:x4a7>";
                } else {
                    displayname = "<dev string:x4ae>" + makelocalizedstring(displayname) + "<dev string:x4b4>";
                }
                if (attachments.size) {
                    devgui_add_player_weap_command(devgui_root + name + displayname + "<dev string:x2d4>", name, "<dev string:x4a>");
                    foreach (att in attachments) {
                        if (att != "<dev string:xfa>") {
                            devgui_add_player_weap_command(devgui_root + name + displayname + "<dev string:x2d4>", name + "<dev string:x4b9>" + att, "<dev string:x4a>");
                        }
                    }
                    continue;
                }
                devgui_add_player_weap_command(devgui_root, name, displayname);
            }
        }
    }

    // Namespace devgui/devgui
    // Params 3, eflags: 0x0
    // Checksum 0xde5740a6, Offset: 0x1688
    // Size: 0x7c
    function devgui_add_player_weap_command(root, weap_name, displayname) {
        util::waittill_can_add_debug_command();
        adddebugcommand(root + weap_name + displayname + "<dev string:x234>" + "<dev string:x38>" + "<dev string:x23f>" + weap_name + "<dev string:x48a>");
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0x57657e29, Offset: 0x1710
    // Size: 0xa0
    function devgui_weapon_think() {
        for (;;) {
            weapon_name = getdvarstring(#"mp_weap_devgui");
            if (weapon_name != "<dev string:x4a>") {
                devgui_handle_player_command(&devgui_give_weapon, weapon_name);
            }
            setdvar(#"mp_weap_devgui", "<dev string:x4a>");
            wait 0.5;
        }
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0x70a16323, Offset: 0x17b8
    // Size: 0x22
    function hero_art_on_player_connect() {
        self._debugheromodels = spawnstruct();
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0x669ae0f8, Offset: 0x17e8
    // Size: 0x3ee
    function devgui_weapon_asset_name_display_think() {
        update_time = 1;
        print_duration = int(update_time / float(function_60d95f53()) / 1000);
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
                var_9643e38d = player gettagorigin("<dev string:x4be>");
                if (!isdefined(var_9643e38d)) {
                    continue;
                }
                print3d(var_9643e38d, getweaponname(weapon), colors[color_index], 1, 0.15, print_duration);
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
                var_9643e38d = ai gettagorigin("<dev string:x4be>");
                if (!isdefined(var_9643e38d)) {
                    continue;
                }
                print3d(var_9643e38d, getweaponname(weapon), colors[color_index], 1, 0.15, print_duration);
                color_index++;
                if (color_index >= colors.size) {
                    color_index = 0;
                }
            }
        }
    }

    // Namespace devgui/devgui
    // Params 1, eflags: 0x0
    // Checksum 0x927f2f45, Offset: 0x1be0
    // Size: 0x3c
    function devgui_attachment_cycling_clear(index) {
        setdvar(level.attachment_cycling_dvars[index], "<dev string:xfa>");
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0x4476484a, Offset: 0x1c28
    // Size: 0x354
    function devgui_attachment_cycling_update() {
        currentweapon = self getcurrentweapon();
        rootweapon = currentweapon.rootweapon;
        supportedattachments = currentweapon.supportedattachments;
        textcolors = [];
        attachments = [];
        originalattachments = [];
        for (i = 0; i < 8; i++) {
            originalattachments[i] = getdvarstring(level.attachment_cycling_dvars[i]);
            textcolor[i] = "<dev string:x4cb>";
            attachments[i] = "<dev string:xfa>";
            name = originalattachments[i];
            if ("<dev string:xfa>" == name) {
                continue;
            }
            textcolor[i] = "<dev string:x4d1>";
            for (supportedindex = 0; supportedindex < supportedattachments.size; supportedindex++) {
                if (name == supportedattachments[supportedindex]) {
                    textcolor[i] = "<dev string:x4cb>";
                    attachments[i] = name;
                    break;
                }
            }
        }
        for (i = 0; i < 8; i++) {
            if ("<dev string:xfa>" == originalattachments[i]) {
                continue;
            }
            for (j = i + 1; j < 8; j++) {
                if (originalattachments[i] == originalattachments[j]) {
                    textcolor[j] = "<dev string:x4d7>";
                    attachments[j] = "<dev string:xfa>";
                }
            }
        }
        msg = "<dev string:x4a>";
        for (i = 0; i < 8; i++) {
            if ("<dev string:xfa>" == originalattachments[i]) {
                continue;
            }
            msg += textcolor[i];
            msg += i;
            msg += "<dev string:x4dd>";
            msg += originalattachments[i];
            msg += "<dev string:x4e3>";
        }
        iprintlnbold(msg);
        self takeweapon(currentweapon);
        currentweapon = getweapon(rootweapon.name, attachments[0], attachments[1], attachments[2], attachments[3], attachments[4], attachments[5], attachments[6], attachments[7]);
        wait 0.25;
        self giveweapon(currentweapon, undefined);
        self switchtoweapon(currentweapon);
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0xe33038ad, Offset: 0x1f88
    // Size: 0x178
    function devgui_attachment_cycling_think() {
        for (;;) {
            state = getdvarstring(#"mp_attachment_cycling_state_devgui");
            setdvar(#"mp_attachment_cycling_state_devgui", "<dev string:xfa>");
            if (issubstr(state, "<dev string:x4e9>")) {
                if ("<dev string:x4f3>" == state) {
                    for (i = 0; i < 8; i++) {
                        devgui_attachment_cycling_clear(i);
                    }
                } else {
                    index = int(getsubstr(state, 6, 7));
                    devgui_attachment_cycling_clear(index);
                }
                state = "<dev string:x500>";
            }
            if ("<dev string:x500>" == state) {
                array::thread_all(getplayers(), &devgui_attachment_cycling_update);
            }
            wait 0.5;
        }
    }

    // Namespace devgui/devgui
    // Params 1, eflags: 0x0
    // Checksum 0x7c3e9a50, Offset: 0x2108
    // Size: 0xcc4
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
            util::warning("<dev string:x50a>" + weapon_name + "<dev string:x51d>" + self.name + "<dev string:x525>" + self.name + "<dev string:x532>");
            return;
        }
        takeweapon = undefined;
        currentweapon = self getcurrentweapon();
        if (strstartswith(weapon_name, "<dev string:x544>")) {
            split = strtok(weapon_name, "<dev string:x559>");
            if (isdefined(split[2])) {
                if (split[2] == "<dev string:x55e>") {
                    var_18a8ed6e = 1;
                } else if (split[2] == "<dev string:x566>") {
                    var_18a8ed6e = -1;
                }
                currentweaponname = currentweapon.name;
                currentattachment = "<dev string:xfa>";
                if (isdefined(currentweapon.attachments) && isdefined(currentweapon.attachments[0]) && currentweapon.attachments[0] != "<dev string:x4a>") {
                    currentattachment = currentweapon.attachments[0];
                }
                supportedattachments = currentweapon.supportedattachments;
                var_a67ed7c5 = -1;
                if (supportedattachments.size) {
                    var_a67ed7c5 = supportedattachments.size;
                    for (i = 0; i < supportedattachments.size; i++) {
                        if (supportedattachments[i] == currentattachment) {
                            var_a67ed7c5 = i;
                            break;
                        }
                    }
                }
                weapon = currentweapon;
                nextindex = -1;
                if (var_a67ed7c5 == supportedattachments.size) {
                    if (var_18a8ed6e > 0) {
                        nextindex = 0;
                    } else {
                        nextindex = supportedattachments.size - 1;
                    }
                } else if (var_a67ed7c5 >= 0) {
                    nextindex = (supportedattachments.size + var_a67ed7c5 + var_18a8ed6e) % supportedattachments.size;
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
            split = strtok(weapon_name, "<dev string:x4b9>");
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
        if (weapon == getweapon(#"none")) {
            iprintln("<dev string:x56e>");
        }
        assert(isdefined(level.var_34d27b26));
        assert(isdefined(level.var_6388e216));
        assert(isdefined(level.var_43a51921));
        if (currentweapon != weapon) {
            gadgets = [];
            gadgets[0] = level.var_34d27b26;
            gadgets[1] = level.var_6388e216;
            gadgets[2] = level.var_43a51921;
            var_63fee5a7 = [];
            if (isdefined(self._gadgets_player)) {
                for (slot = 0; slot < 3; slot++) {
                    if (isdefined(self._gadgets_player[slot])) {
                        gadgets[slot] = self._gadgets_player[slot];
                        var_63fee5a7[slot] = self gadgetpowerget(slot);
                    }
                }
            }
            for (slot = 0; slot < 3; slot++) {
                if (self hasweapon(gadgets[slot])) {
                    self takeweapon(gadgets[slot]);
                }
            }
            if (weapon.isgrenadeweapon && !getdvarint(#"hash_1fce8e806b5356fc", 0)) {
            }
            if (weapon.inventorytype == #"offhand" || weapon.inventorytype == #"offhand_primary") {
                pweapons = self getweaponslist();
                foreach (pweapon in pweapons) {
                    if (pweapon != weapon && pweapon.gadget_type == 0 && (pweapon.inventorytype == #"offhand" || pweapon.inventorytype == #"offhand_primary")) {
                        if (self hasweapon(pweapon)) {
                            self takeweapon(pweapon);
                        }
                    }
                }
            } else if (weapon.inventorytype == #"ability" && weapon.offhandslot == "<dev string:x5ac>") {
                pweapons = self getweaponslist();
                foreach (pweapon in pweapons) {
                    if (pweapon != weapon && pweapon.inventorytype == #"ability" && pweapon.offhandslot == "<dev string:x5ac>") {
                        if (self hasweapon(pweapon)) {
                            self takeweapon(pweapon);
                        }
                    }
                }
            }
            if (isdefined(takeweapon) && self hasweapon(takeweapon)) {
                self takeweapon(takeweapon);
            }
            if (getdvarint(#"mp_weap_use_give_console_command_devgui", 0)) {
                adddebugcommand("<dev string:x5b7>" + weapon_name);
                waitframe(1);
            } else {
                if (weapon.gadget_type == 0) {
                    self giveweapon(weapon);
                    if (weapon.inventorytype == #"offhand" || weapon.inventorytype == #"offhand_primary") {
                        gadgets[0] = level.var_34d27b26;
                    } else {
                        gadgets[2] = level.var_43a51921;
                    }
                } else if (weapon.inventorytype == #"offhand" || weapon.inventorytype == #"offhand_primary") {
                    if (weapon.gadget_type == 23) {
                        gadgets[1] = weapon;
                    } else {
                        gadgets[0] = weapon;
                    }
                } else if (weapon.inventorytype == #"ability") {
                    gadgets[2] = weapon;
                }
                for (slot = 0; slot < 3; slot++) {
                    if (isdefined(gadgets[slot])) {
                        if (!self hasweapon(gadgets[slot])) {
                            self giveweapon(gadgets[slot]);
                            if (!isdefined(var_63fee5a7[slot])) {
                                var_63fee5a7[slot] = 100;
                            }
                            self gadgetpowerset(slot, var_63fee5a7[slot]);
                        }
                    }
                }
                if (!weapon.isgrenadeweapon && weapon.inventorytype != #"ability") {
                    self switchtoweapon(weapon);
                }
            }
            max = weapon.maxammo;
            if (max) {
                self setweaponammostock(weapon, max);
                return;
            }
            clipammo = self getweaponammoclip(weapon);
            if (clipammo == 0) {
                self setweaponammoclip(weapon, 1);
            }
        }
    }

    // Namespace devgui/devgui
    // Params 3, eflags: 0x0
    // Checksum 0x1c805d01, Offset: 0x2dd8
    // Size: 0x124
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
        setdvar(#"mp_weap_devgui", "<dev string:x5c0>");
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0x7aa6c3df, Offset: 0x2f08
    // Size: 0x12c
    function init_debug_center_screen() {
        zero_idle_movement = 0;
        for (;;) {
            if (getdvarint(#"debug_center_screen", 0)) {
                if (!isdefined(level.var_7929a046) || level.var_7929a046 == 0) {
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
    // Checksum 0xec074c08, Offset: 0x3040
    // Size: 0x98
    function debug_center_screen() {
        level.var_7929a046 = 1;
        wait 0.1;
        level.var_f9f04b00 debug_center_screen::open(level.players[0], 1);
        level waittill(#"stop center screen debug");
        level.var_f9f04b00 debug_center_screen::close(level.players[0]);
        level.var_7929a046 = 0;
    }

    // Namespace devgui/devgui
    // Params 1, eflags: 0x0
    // Checksum 0xdbb75944, Offset: 0x30e0
    // Size: 0x122
    function add_vehicle_at_eye_trace(vehiclename) {
        host = util::gethostplayer();
        trace = host eye_trace();
        veh_spawner = getent(vehiclename + "<dev string:x5c6>", "<dev string:x5d2>");
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
    // Checksum 0xbb125130, Offset: 0x3210
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
    // Checksum 0x5171b684, Offset: 0x32a8
    // Size: 0x54
    function devgui_add_ve_map_switches() {
        adddebugcommand("<dev string:x5e0>");
        adddebugcommand("<dev string:x631>");
        adddebugcommand("<dev string:x68c>");
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0xdf358ce1, Offset: 0x3308
    // Size: 0x64e
    function function_6a24e58f() {
        level notify(#"hash_254f5df0e8f1d66");
        level endon(#"hash_254f5df0e8f1d66");
        setdvar(#"hash_3a3f995b08f2b9b8", -1);
        setdvar(#"hash_2aab28ebf600b8c7", -1);
        setdvar(#"hash_4874e2dd28221d6c", -1);
        wait 0.5;
        path = "<dev string:x6d5>";
        cmd = "<dev string:x6f5>";
        util::add_devgui(path + "<dev string:x719>", cmd + "<dev string:x722>");
        for (minutes = 0; minutes < 10; minutes++) {
            for (seconds = 0; seconds < 60; seconds += 15) {
                var_99cfbb07 = "<dev string:x4a>" + seconds;
                totalseconds = minutes * 60 + seconds;
                if (seconds == 0) {
                    if (minutes == 0) {
                        totalseconds = 1;
                        var_99cfbb07 = "<dev string:x727>";
                    } else {
                        var_99cfbb07 = "<dev string:x72d>";
                    }
                }
                util::add_devgui(path + minutes + "<dev string:x733>" + var_99cfbb07, cmd + totalseconds);
            }
            waitframe(1);
        }
        var_a11730e4 = "<dev string:x738>";
        var_eb72e2d3 = "<dev string:x756>";
        var_3b0a5dad = "<dev string:x778>";
        var_5f2cb965 = "<dev string:x794>";
        if (util::isroundbased()) {
            var_ca373442 = level.roundlimit * level.roundscorelimit;
        } else {
            var_ca373442 = level.scorelimit;
        }
        var_ca373442 = math::clamp(var_ca373442, 0, 300);
        wait 0.5;
        for (score = 0; score <= var_ca373442; score++) {
            var_8acb4d22 = int(score / 10) * 10;
            var_daf8d664 = int(score / 10) * 10 + 10;
            util::add_devgui(var_a11730e4 + var_8acb4d22 + "<dev string:x7b4>" + var_daf8d664 + "<dev string:x4a2>" + var_8acb4d22 + "<dev string:x2d4>" + score, var_eb72e2d3 + score);
            util::add_devgui(var_3b0a5dad + var_8acb4d22 + "<dev string:x7b4>" + var_daf8d664 + "<dev string:x4a2>" + var_8acb4d22 + "<dev string:x2d4>" + score, var_5f2cb965 + score);
            if (score == var_daf8d664) {
                waitframe(1);
            }
        }
        while (true) {
            if (getdvarint(#"hash_3a3f995b08f2b9b8", -1) != -1) {
                var_6d2040ea = getdvarint(#"hash_3a3f995b08f2b9b8", -1);
                var_14f1a63 = (int(var_6d2040ea * 1000) + globallogic_utils::gettimepassed()) / int(60 * 1000);
                if (var_6d2040ea == 0) {
                    var_14f1a63 = 0;
                }
                setdvar(#"timelimit_override", var_14f1a63);
                setdvar(#"hash_3a3f995b08f2b9b8", -1);
            }
            if (getdvarint(#"hash_2aab28ebf600b8c7", -1) != -1) {
                var_168b7d5 = getdvarint(#"hash_2aab28ebf600b8c7", -1);
                [[ level._setteamscore ]](#"allies", var_168b7d5);
                setdvar(#"hash_2aab28ebf600b8c7", -1);
            }
            if (getdvarint(#"hash_4874e2dd28221d6c", -1) != -1) {
                var_46c53e6e = getdvarint(#"hash_4874e2dd28221d6c", -1);
                [[ level._setteamscore ]](#"axis", var_46c53e6e);
                setdvar(#"hash_4874e2dd28221d6c", -1);
            }
            wait 1;
        }
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0x80b59f8d, Offset: 0x3960
    // Size: 0x198
    function function_7bef8d25() {
        level notify(#"hash_6a8b1c9e1485919d");
        level endon(#"hash_6a8b1c9e1485919d");
        wait 5;
        function_e4b86469();
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
    // Checksum 0x60010888, Offset: 0x3b00
    // Size: 0x1b8
    function function_46b22d99() {
        level notify(#"hash_4c09c9d01060d7ad");
        level endon(#"hash_4c09c9d01060d7ad");
        wait 2;
        function_9fb69cba();
        wait 0.5;
        while (true) {
            wait 0.5;
            if (level.gameended) {
                continue;
            }
            var_7442b0e6 = getdvarint(#"scr_end_round", 0);
            if (var_7442b0e6 == 0) {
                continue;
            }
            setdvar(#"scr_end_round", 0);
            var_53b4c3ae = getgametypesetting(#"timelimit");
            var_c585681e = 0.25;
            setgametypesetting("<dev string:x7ba>", var_c585681e);
            for (aborted = 0; !level.gameended && !aborted; aborted = getgametypesetting(#"timelimit") != var_c585681e) {
                wait 0.5;
            }
            if (!aborted) {
                setgametypesetting("<dev string:x7ba>", var_53b4c3ae);
            }
        }
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0xdac772db, Offset: 0x3cc0
    // Size: 0x1c8
    function function_be0f9897() {
        level notify(#"hash_7528b3262d076f59");
        level endon(#"hash_7528b3262d076f59");
        wait 5.5;
        function_51cc2292();
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
                    var_66cb03ad = player.var_66cb03ad < 0 ? player.maxhealth : player.var_66cb03ad;
                    if (!isdefined(var_66cb03ad)) {
                        var_66cb03ad = 100;
                    }
                    if (player.health + heal > var_66cb03ad) {
                        player.health = var_66cb03ad;
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
    // Checksum 0x26c1c553, Offset: 0x3e90
    // Size: 0x250
    function function_773432e2() {
        level notify(#"hash_6534754fb1d75ea7");
        level endon(#"hash_6534754fb1d75ea7");
        while (!isdefined(level.scoreinfo)) {
            wait 1;
        }
        function_354e12a4();
        while (true) {
            wait 0.1;
            actionid = getdvarint(#"hash_649ea18bd5e55893", -1);
            var_97c83f66 = getdvarint(#"hash_6ad3f58a8e0a1e59", -1);
            hotstreakstage = getdvarint(#"scr_hotstreak_stage", -1);
            if (actionid == -1 && var_97c83f66 == -1 && hotstreakstage == -1) {
                continue;
            }
            player = level.players[0];
            if (isplayer(player)) {
                if (actionid != -1) {
                    player luinotifyevent(#"challenge_coin_received", 1, actionid);
                }
                if (var_97c83f66 != -1) {
                    player luinotifyevent(#"end_sustaining_action", 1, var_97c83f66);
                }
                if (hotstreakstage != -1) {
                    player clientfield::set_player_uimodel("<dev string:x7c7>", hotstreakstage);
                }
            }
            setdvar(#"hash_649ea18bd5e55893", -1);
            setdvar(#"hash_6ad3f58a8e0a1e59", -1);
        }
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0x9e4d2659, Offset: 0x40e8
    // Size: 0x124
    function function_e4b86469() {
        path = "<dev string:x7e3>";
        cmd = "<dev string:x7fc>";
        util::add_devgui(path + "<dev string:x819>", cmd + "<dev string:x827>");
        util::add_devgui(path + "<dev string:x82c>", cmd + "<dev string:x83b>");
        util::add_devgui(path + "<dev string:x841>", cmd + "<dev string:x850>");
        util::add_devgui(path + "<dev string:x856>", cmd + "<dev string:x865>");
        util::add_devgui(path + "<dev string:x86b>", cmd + "<dev string:x87b>");
        util::add_devgui(path + "<dev string:x882>", cmd + "<dev string:x895>");
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0xced5c55f, Offset: 0x4218
    // Size: 0x174
    function function_51cc2292() {
        path = "<dev string:x89d>";
        cmd = "<dev string:x8bb>";
        util::add_devgui(path + "<dev string:x8d5>", cmd + "<dev string:x8ea>");
        util::add_devgui(path + "<dev string:x8f1>", cmd + "<dev string:x905>");
        util::add_devgui(path + "<dev string:x90b>", cmd + "<dev string:x5c0>");
        util::add_devgui(path + "<dev string:x91f>", cmd + "<dev string:x934>");
        util::add_devgui(path + "<dev string:x939>", cmd + "<dev string:x827>");
        util::add_devgui(path + "<dev string:x94e>", cmd + "<dev string:x964>");
        util::add_devgui(path + "<dev string:x96a>", cmd + "<dev string:x981>");
        util::add_devgui(path + "<dev string:x988>", cmd + "<dev string:x99f>");
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0xe1971d46, Offset: 0x4398
    // Size: 0x2c
    function function_9fb69cba() {
        util::add_devgui("<dev string:x9a6>", "<dev string:x9c1>");
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0xb83e4794, Offset: 0x43d0
    // Size: 0x2b4
    function function_354e12a4() {
        path = "<dev string:x9d8>";
        cmd = "<dev string:x9eb>";
        var_ab79c6df = "<dev string:xa07>";
        var_b917e8e0 = getarraykeys(level.scoreinfo);
        for (i = 0; i < var_b917e8e0.size; i++) {
            key = var_b917e8e0[i];
            action = level.scoreinfo[key];
            if (isdefined(action) && isdefined(action[#"row"])) {
                if (isdefined(action[#"job_type"])) {
                    keystring = function_9e72a96(key);
                    util::add_devgui(path + "<dev string:xa27>" + keystring[0] + "<dev string:x2d4>" + keystring, cmd + action[#"row"]);
                    if (isdefined(action[#"hash_401b1493e5188252"]) && action[#"hash_401b1493e5188252"] == #"ender") {
                        util::add_devgui(path + "<dev string:xa30>" + keystring[0] + "<dev string:x2d4>" + keystring, var_ab79c6df + action[#"row"]);
                    }
                }
            }
        }
        var_e625686f = path + "<dev string:xa38>";
        var_f99507b8 = "<dev string:xa4c>";
        util::add_devgui(var_e625686f + "<dev string:xa68>", var_f99507b8 + "<dev string:x722>");
        util::add_devgui(var_e625686f + "<dev string:xa77>", var_f99507b8 + "<dev string:x934>");
        util::add_devgui(var_e625686f + "<dev string:xa86>", var_f99507b8 + "<dev string:xa95>");
        util::add_devgui(var_e625686f + "<dev string:xa9a>", var_f99507b8 + "<dev string:xaa9>");
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x4
    // Checksum 0xfbf010f, Offset: 0x4690
    // Size: 0x1ce
    function private function_57edec18() {
        if (isnavvolumeloaded()) {
        }
        util::add_devgui("<dev string:xaae>", "<dev string:xad2>");
        util::add_devgui("<dev string:xaec>", "<dev string:xb11>");
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
                drone_camera = spawnvehicle("<dev string:xb2b>", player.origin + (0, 0, 150), player.angles, "<dev string:xb42>");
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

    // Namespace devgui/devgui
    // Params 1, eflags: 0x0
    // Checksum 0xa077ac91, Offset: 0x4868
    // Size: 0xdc
    function eye_trace(hitents) {
        if (!isdefined(hitents)) {
            hitents = 0;
        }
        angles = self getplayerangles();
        fwd = anglestoforward(angles);
        var_98b02a87 = self getplayerviewheight();
        eye = self.origin + (0, 0, var_98b02a87);
        end = eye + fwd * 8000;
        return bullettrace(eye, end, hitents, self);
    }

#/
