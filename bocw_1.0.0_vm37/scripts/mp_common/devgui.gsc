#using script_7edb54aca54e9a2b;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\dev_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gestures;
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
    // Checksum 0x15b7724b, Offset: 0xd0
    // Size: 0x4c
    function private autoexec __init__system__() {
        system::register(#"devgui", &preinit, undefined, undefined, #"load");
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x4
    // Checksum 0x2cc7159b, Offset: 0x128
    // Size: 0x37c
    function private preinit() {
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
        level thread function_d14c2698();
        level thread function_caed2ca6();
        level thread dev::devgui_test_chart_think();
        level thread devgui_player_spawn_think();
        level thread devgui_vehicle_spawn_think();
        level thread function_7bef8d25();
        level thread function_be0f9897();
        level thread dev::function_487bf571();
        level thread function_46b22d99();
        level thread function_6a24e58f();
        level thread function_57edec18();
        thread init_debug_center_screen();
        level thread dev::body_customization_devgui(currentsessionmode());
        callback::on_connect(&hero_art_on_player_connect);
        callback::on_connect(&on_player_connect);
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0xfa291b5a, Offset: 0x4b0
    // Size: 0x24
    function on_player_connect() {
        self.devguilockspawn = 0;
        self thread devgui_player_spawn();
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0x34c38dd9, Offset: 0x4e0
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
    // Checksum 0xf253c925, Offset: 0x640
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
    // Checksum 0x2cb69f87, Offset: 0x7b0
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
    // Checksum 0xe687b064, Offset: 0x8a8
    // Size: 0x2fc
    function function_d14c2698() {
        if (is_true(game.var_67f8923f)) {
            return;
        }
        self notify("<dev string:x273>");
        self endon("<dev string:x273>");
        level endon(#"game_ended");
        player_devgui_base = "<dev string:x286>";
        setdvar(#"hash_57f1a3b4775bec24", "<dev string:x4a>");
        util::add_devgui(player_devgui_base + "<dev string:x2a3>", "<dev string:x2b3>" + "<dev string:x2bb>" + "<dev string:x2d2>");
        while (getdvarstring(#"hash_57f1a3b4775bec24", "<dev string:x4a>") == "<dev string:x4a>") {
            wait 1;
        }
        game.var_67f8923f = 1;
        setdvar(#"hash_57f1a3b4775bec24", "<dev string:x4a>");
        var_81fd4bd0 = function_72eeb31d();
        foreach (item_hash, callouts in var_81fd4bd0) {
            item_root = player_devgui_base + function_9e72a96(item_hash) + "<dev string:x2d8>";
            foreach (callout in callouts) {
                util::add_devgui(item_root + function_9e72a96(callout), "<dev string:x2b3>" + "<dev string:x2bb>" + "<dev string:x23f>" + function_9e72a96(callout));
            }
            waitframe(1);
        }
        util::remove_devgui(player_devgui_base + "<dev string:x2a3>");
        level thread function_d08b7aef();
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0x124f42ce, Offset: 0xbb0
    // Size: 0x1ae
    function function_d08b7aef() {
        while (true) {
            level.calloutplayer = getdvarint(#"scr_boast_player", 0);
            var_600cca03 = getdvarstring(#"hash_57f1a3b4775bec24");
            if (var_600cca03 != "<dev string:x4a>") {
                setdvar(#"hash_6aec7b5b37bd66cd", 0);
                players = getplayers();
                if (isdefined(level.calloutplayer) && isdefined(players[level.calloutplayer])) {
                    callout = players[level.calloutplayer] gestures::function_c77349d4(var_600cca03);
                    if (isdefined(callout)) {
                        players[level.calloutplayer] gestures::play_gesture(callout, undefined, 0);
                    }
                } else {
                    callout = players[0] gestures::function_c77349d4(var_600cca03);
                    if (isdefined(callout)) {
                        players[0] gestures::play_gesture(callout, undefined, 0);
                    }
                }
                setdvar(#"hash_57f1a3b4775bec24", "<dev string:x4a>");
            }
            waitframe(1);
        }
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0x5df17a01, Offset: 0xd68
    // Size: 0x2fc
    function function_caed2ca6() {
        if (is_true(game.var_ea16e22a)) {
            level thread function_f9e5168a();
            return;
        }
        self notify("<dev string:x2dd>");
        self endon("<dev string:x2dd>");
        level endon(#"game_ended");
        player_devgui_base = "<dev string:x2f1>";
        var_7713817f = getdvarstring(#"scr_execution", "<dev string:x4a>") != "<dev string:x4a>";
        if (!var_7713817f) {
            util::add_devgui(player_devgui_base + "<dev string:x307>", "<dev string:x2b3>" + "<dev string:x319>" + "<dev string:x2d2>");
            while (getdvarstring(#"scr_execution", "<dev string:x4a>") == "<dev string:x4a>") {
                wait 1;
            }
            util::remove_devgui(player_devgui_base + "<dev string:x307>");
        }
        setdvar(#"scr_execution", "<dev string:x4a>");
        game.var_ea16e22a = 1;
        executionlist = getscriptbundle("<dev string:x32a>");
        if (isdefined(executionlist)) {
            var_eb7a15a5 = executionlist.executions;
            item_root = player_devgui_base;
            count = 0;
            foreach (execution in var_eb7a15a5) {
                if (isdefined(execution.execution)) {
                    count++;
                    util::add_devgui(item_root + function_9e72a96(execution.execution), "<dev string:x2b3>" + "<dev string:x319>" + "<dev string:x23f>" + function_9e72a96(execution.execution));
                    waitframe(1);
                }
            }
            if (count > 0) {
                level thread function_f9e5168a();
            }
        }
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0x5a7cdc9c, Offset: 0x1070
    // Size: 0x196
    function function_f9e5168a() {
        while (true) {
            level.var_fba97209 = getdvarint(#"hash_2702f51d0ea9e486", 0);
            execution = getdvarstring(#"scr_execution");
            if (execution != "<dev string:x4a>") {
                setdvar(#"hash_61dac11dea7f8b8d", 1);
                players = getplayers();
                foreach (player in players) {
                    player clearexecution();
                    player giveexecution(hash(execution));
                }
                setdvar(#"scr_execution", "<dev string:x4a>");
            }
            wait 1;
        }
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0x9f3c51d2, Offset: 0x1210
    // Size: 0x6d4
    function devgui_player_weapons() {
        level endon(#"game_ended");
        if (is_true(game.devgui_weapons_added)) {
            return;
        }
        level flag::wait_till("<dev string:x338>");
        a_weapons = enumerateweapons("<dev string:x34f>");
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
        level thread devgui_add_player_weapons("<dev string:x359>", var_b4bc030d, "<dev string:x378>", menu_index);
        menu_index++;
        level thread devgui_add_player_weapons("<dev string:x359>", var_179cce42, "<dev string:x389>", menu_index);
        menu_index++;
        level thread devgui_add_player_weapons("<dev string:x359>", var_5046ba65, "<dev string:x39c>", menu_index);
        menu_index++;
        level thread devgui_add_player_weapons("<dev string:x359>", var_dce9ec82, "<dev string:x3b3>", menu_index);
        menu_index++;
        level thread devgui_add_player_weapons("<dev string:x359>", var_a327f68, "<dev string:x3cc>", menu_index);
        menu_index++;
        level thread devgui_add_player_weapons("<dev string:x359>", a_misc_mp, "<dev string:x3e2>", menu_index);
        game.devgui_weapons_added = 1;
        waitframe(1);
        adddebugcommand("<dev string:x359>" + "<dev string:x3ee>" + "<dev string:x405>" + "<dev string:x84>" + "<dev string:x413>");
        adddebugcommand("<dev string:x359>" + "<dev string:x41e>" + "<dev string:x405>" + "<dev string:x4e>" + "<dev string:x413>");
        adddebugcommand("<dev string:x359>" + "<dev string:x43c>" + "<dev string:x405>" + "<dev string:xaf>" + "<dev string:x413>");
        waitframe(1);
        menu_index = 30;
        attachment_cycling_devgui_base_mp = "<dev string:x359>" + "<dev string:x460>" + menu_index + "<dev string:x2d8>";
        adddebugcommand(attachment_cycling_devgui_base_mp + "<dev string:x477>" + "<dev string:xd4>" + "<dev string:x48b>");
        adddebugcommand(attachment_cycling_devgui_base_mp + "<dev string:x49c>" + "<dev string:xd4>" + "<dev string:x4ae>");
        attachmentnames = getattachmentnames();
        for (i = 0; i < 8; i++) {
            attachment_cycling_sub_menu_index = 1;
            adddebugcommand(attachment_cycling_devgui_base_mp + "<dev string:x4bc>" + i + 1 + "<dev string:x4cb>" + "<dev string:xd4>" + "<dev string:x4de>" + i + "<dev string:x4e9>");
            for (attachmentname = 0; attachmentname < attachmentnames.size; attachmentname++) {
                util::waittill_can_add_debug_command();
                adddebugcommand(attachment_cycling_devgui_base_mp + "<dev string:x4bc>" + i + 1 + "<dev string:x2d8>" + attachmentnames[attachmentname] + "<dev string:x234>" + "<dev string:xd4>" + "<dev string:x4f0>" + level.attachment_cycling_dvars[i] + "<dev string:x23f>" + attachmentnames[attachmentname] + "<dev string:x4e9>");
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
    // Checksum 0x31e5742b, Offset: 0x18f0
    // Size: 0x2a0
    function devgui_add_player_weapons(root, a_weapons, weapon_type, mindex) {
        level endon(#"game_ended");
        if (isdedicated()) {
            return;
        }
        devgui_root = root + weapon_type + "<dev string:x501>" + mindex + "<dev string:x2d8>";
        if (isdefined(a_weapons)) {
            foreach (weapon in a_weapons) {
                attachments = weapon.supportedattachments;
                name = getweaponname(weapon);
                displayname = weapon.displayname;
                if (displayname == #"") {
                    displayname = "<dev string:x506>";
                } else {
                    displayname = "<dev string:x50d>" + makelocalizedstring(displayname) + "<dev string:x513>";
                }
                if (attachments.size) {
                    devgui_add_player_weap_command(devgui_root + name + displayname + "<dev string:x2d8>", name, "<dev string:x4a>");
                    foreach (att in attachments) {
                        if (att != "<dev string:xfa>") {
                            devgui_add_player_weap_command(devgui_root + name + displayname + "<dev string:x2d8>", name + "<dev string:x518>" + att, "<dev string:x4a>");
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
    // Checksum 0xc0074c83, Offset: 0x1b98
    // Size: 0x7c
    function devgui_add_player_weap_command(root, weap_name, displayname) {
        util::waittill_can_add_debug_command();
        adddebugcommand(root + weap_name + displayname + "<dev string:x234>" + "<dev string:x38>" + "<dev string:x23f>" + weap_name + "<dev string:x4e9>");
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0xc859cc9b, Offset: 0x1c20
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
    // Checksum 0x7f9d0fe7, Offset: 0x1cc8
    // Size: 0x22
    function hero_art_on_player_connect() {
        self._debugheromodels = spawnstruct();
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0xb587f8b, Offset: 0x1cf8
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
                var_9643e38d = player gettagorigin("<dev string:x51d>");
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
                var_9643e38d = ai gettagorigin("<dev string:x51d>");
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
    // Checksum 0xa1c4388a, Offset: 0x20f0
    // Size: 0x3c
    function devgui_attachment_cycling_clear(index) {
        setdvar(level.attachment_cycling_dvars[index], "<dev string:xfa>");
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0x111425c2, Offset: 0x2138
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
            textcolor[i] = "<dev string:x52a>";
            attachments[i] = "<dev string:xfa>";
            name = originalattachments[i];
            if ("<dev string:xfa>" == name) {
                continue;
            }
            textcolor[i] = "<dev string:x530>";
            for (supportedindex = 0; supportedindex < supportedattachments.size; supportedindex++) {
                if (name == supportedattachments[supportedindex]) {
                    textcolor[i] = "<dev string:x52a>";
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
                    textcolor[j] = "<dev string:x536>";
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
            msg += "<dev string:x53c>";
            msg += originalattachments[i];
            msg += "<dev string:x542>";
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
    // Checksum 0x903f6b0b, Offset: 0x2498
    // Size: 0x178
    function devgui_attachment_cycling_think() {
        for (;;) {
            state = getdvarstring(#"mp_attachment_cycling_state_devgui");
            setdvar(#"mp_attachment_cycling_state_devgui", "<dev string:xfa>");
            if (issubstr(state, "<dev string:x548>")) {
                if ("<dev string:x552>" == state) {
                    for (i = 0; i < 8; i++) {
                        devgui_attachment_cycling_clear(i);
                    }
                } else {
                    index = int(getsubstr(state, 6, 7));
                    devgui_attachment_cycling_clear(index);
                }
                state = "<dev string:x55f>";
            }
            if ("<dev string:x55f>" == state) {
                array::thread_all(getplayers(), &devgui_attachment_cycling_update);
            }
            wait 0.5;
        }
    }

    // Namespace devgui/devgui
    // Params 1, eflags: 0x0
    // Checksum 0xa9dce0af, Offset: 0x2618
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
            util::warning("<dev string:x569>" + weapon_name + "<dev string:x57c>" + self.name + "<dev string:x584>" + self.name + "<dev string:x591>");
            return;
        }
        takeweapon = undefined;
        currentweapon = self getcurrentweapon();
        if (strstartswith(weapon_name, "<dev string:x5a3>")) {
            split = strtok(weapon_name, "<dev string:x5b8>");
            if (isdefined(split[2])) {
                if (split[2] == "<dev string:x5bd>") {
                    var_18a8ed6e = 1;
                } else if (split[2] == "<dev string:x5c5>") {
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
            split = strtok(weapon_name, "<dev string:x518>");
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
            iprintln("<dev string:x5cd>");
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
            } else if (weapon.inventorytype == #"ability" && weapon.offhandslot == "<dev string:x60b>") {
                pweapons = self getweaponslist();
                foreach (pweapon in pweapons) {
                    if (pweapon != weapon && pweapon.inventorytype == #"ability" && pweapon.offhandslot == "<dev string:x60b>") {
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
                adddebugcommand("<dev string:x616>" + weapon_name);
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
    // Checksum 0xe6094901, Offset: 0x32e8
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
        setdvar(#"mp_weap_devgui", "<dev string:x61f>");
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0x1f8cd6be, Offset: 0x3418
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
    // Checksum 0x91f4078b, Offset: 0x3550
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
    // Checksum 0xb3e875c2, Offset: 0x35f0
    // Size: 0x122
    function add_vehicle_at_eye_trace(vehiclename) {
        host = util::gethostplayer();
        trace = host eye_trace();
        veh_spawner = getent(vehiclename + "<dev string:x625>", "<dev string:x631>");
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
    // Checksum 0x5adde1e0, Offset: 0x3720
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
    // Checksum 0x1d24bc60, Offset: 0x37b8
    // Size: 0x54
    function devgui_add_ve_map_switches() {
        adddebugcommand("<dev string:x63f>");
        adddebugcommand("<dev string:x690>");
        adddebugcommand("<dev string:x6eb>");
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0x64ff6ed1, Offset: 0x3818
    // Size: 0x64e
    function function_6a24e58f() {
        level notify(#"hash_254f5df0e8f1d66");
        level endon(#"hash_254f5df0e8f1d66");
        setdvar(#"hash_3a3f995b08f2b9b8", -1);
        setdvar(#"hash_2aab28ebf600b8c7", -1);
        setdvar(#"hash_4874e2dd28221d6c", -1);
        wait 0.5;
        path = "<dev string:x734>";
        cmd = "<dev string:x754>";
        util::add_devgui(path + "<dev string:x778>", cmd + "<dev string:x781>");
        for (minutes = 0; minutes < 10; minutes++) {
            for (seconds = 0; seconds < 60; seconds += 15) {
                var_99cfbb07 = "<dev string:x4a>" + seconds;
                totalseconds = minutes * 60 + seconds;
                if (seconds == 0) {
                    if (minutes == 0) {
                        totalseconds = 1;
                        var_99cfbb07 = "<dev string:x786>";
                    } else {
                        var_99cfbb07 = "<dev string:x78c>";
                    }
                }
                util::add_devgui(path + minutes + "<dev string:x792>" + var_99cfbb07, cmd + totalseconds);
            }
            waitframe(1);
        }
        var_a11730e4 = "<dev string:x797>";
        var_eb72e2d3 = "<dev string:x7b5>";
        var_3b0a5dad = "<dev string:x7d7>";
        var_5f2cb965 = "<dev string:x7f3>";
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
            util::add_devgui(var_a11730e4 + var_8acb4d22 + "<dev string:x813>" + var_daf8d664 + "<dev string:x501>" + var_8acb4d22 + "<dev string:x2d8>" + score, var_eb72e2d3 + score);
            util::add_devgui(var_3b0a5dad + var_8acb4d22 + "<dev string:x813>" + var_daf8d664 + "<dev string:x501>" + var_8acb4d22 + "<dev string:x2d8>" + score, var_5f2cb965 + score);
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
    // Checksum 0xa4fbce83, Offset: 0x3e70
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
    // Checksum 0x1655a842, Offset: 0x4010
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
            setgametypesetting("<dev string:x819>", var_c585681e);
            for (aborted = 0; !level.gameended && !aborted; aborted = getgametypesetting(#"timelimit") != var_c585681e) {
                wait 0.5;
            }
            if (!aborted) {
                setgametypesetting("<dev string:x819>", var_53b4c3ae);
            }
        }
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0x991e3e7d, Offset: 0x41d0
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
    // Checksum 0xff37df1b, Offset: 0x43a0
    // Size: 0x124
    function function_e4b86469() {
        path = "<dev string:x826>";
        cmd = "<dev string:x83f>";
        util::add_devgui(path + "<dev string:x85c>", cmd + "<dev string:x86a>");
        util::add_devgui(path + "<dev string:x86f>", cmd + "<dev string:x87e>");
        util::add_devgui(path + "<dev string:x884>", cmd + "<dev string:x893>");
        util::add_devgui(path + "<dev string:x899>", cmd + "<dev string:x8a8>");
        util::add_devgui(path + "<dev string:x8ae>", cmd + "<dev string:x8be>");
        util::add_devgui(path + "<dev string:x8c5>", cmd + "<dev string:x8d8>");
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0x89b92159, Offset: 0x44d0
    // Size: 0x174
    function function_51cc2292() {
        path = "<dev string:x8e0>";
        cmd = "<dev string:x8fe>";
        util::add_devgui(path + "<dev string:x918>", cmd + "<dev string:x92d>");
        util::add_devgui(path + "<dev string:x934>", cmd + "<dev string:x948>");
        util::add_devgui(path + "<dev string:x94e>", cmd + "<dev string:x61f>");
        util::add_devgui(path + "<dev string:x962>", cmd + "<dev string:x977>");
        util::add_devgui(path + "<dev string:x97c>", cmd + "<dev string:x86a>");
        util::add_devgui(path + "<dev string:x991>", cmd + "<dev string:x9a7>");
        util::add_devgui(path + "<dev string:x9ad>", cmd + "<dev string:x9c4>");
        util::add_devgui(path + "<dev string:x9cb>", cmd + "<dev string:x9e2>");
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0xc6b0fd56, Offset: 0x4650
    // Size: 0x2c
    function function_9fb69cba() {
        util::add_devgui("<dev string:x9e9>", "<dev string:xa04>");
    }

    // Namespace devgui/devgui
    // Params 0, eflags: 0x4
    // Checksum 0xca2cf40f, Offset: 0x4688
    // Size: 0x1ce
    function private function_57edec18() {
        if (isnavvolumeloaded()) {
        }
        util::add_devgui("<dev string:xa1b>", "<dev string:xa3f>");
        util::add_devgui("<dev string:xa59>", "<dev string:xa7e>");
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
                drone_camera = spawnvehicle("<dev string:xa98>", player.origin + (0, 0, 150), player.angles, "<dev string:xaaf>");
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
    // Checksum 0x4d2bff01, Offset: 0x4860
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
