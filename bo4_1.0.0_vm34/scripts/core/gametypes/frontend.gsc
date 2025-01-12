#using scripts\core_common\animation_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;

#namespace frontend;

// Namespace frontend/frontend
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x1f8
// Size: 0x4
function callback_void() {
    
}

// Namespace frontend/frontend
// Params 1, eflags: 0x0
// Checksum 0x4c503626, Offset: 0x208
// Size: 0x24
function callback_actorspawnedfrontend(spawner) {
    self thread spawner::spawn_think(spawner);
}

// Namespace frontend/gametype_init
// Params 1, eflags: 0x40
// Checksum 0xa02fd3fc, Offset: 0x238
// Size: 0x1c4
function event_handler[gametype_init] main(eventstruct) {
    level.callbackstartgametype = &callback_void;
    level.callbackplayerconnect = &callback_playerconnect;
    level.callbackplayerdisconnect = &callback_void;
    level.callbackentityspawned = &callback_void;
    level.callbackactorspawned = &callback_actorspawnedfrontend;
    level.orbis = getdvarstring(#"orbisgame") == "true";
    level.durango = getdvarstring(#"durangogame") == "true";
    scene::add_scene_func("sb_frontend_black_market", &function_98e4f876, "play");
    clientfield::register("scriptmover", "dni_eyes", 1, 1, "int");
    level.weaponnone = getweapon(#"none");
    level.teambased = 0;
    game.state = "pregame";
    /#
        level function_3a680086();
        level thread function_d79afb78();
    #/
}

// Namespace frontend/frontend
// Params 0, eflags: 0x0
// Checksum 0x74236d5c, Offset: 0x408
// Size: 0x34
function callback_playerconnect() {
    self thread function_c7410880();
    /#
        self thread dailychallengedevguithink();
    #/
}

// Namespace frontend/frontend
// Params 1, eflags: 0x0
// Checksum 0x76dc2cf8, Offset: 0x448
// Size: 0xac
function function_98e4f876(a_ents) {
    level.var_65f83320 = self.origin;
    level.var_a1674e6e = self.angles;
    level.var_cc4f1e31 = a_ents[#"hash_70908058ebc2056"];
    level.var_bd18dfbe = a_ents[#"lefthand"];
    level.var_54a434fc = a_ents[#"righthand"];
    level scene::stop("sb_frontend_black_market");
}

// Namespace frontend/frontend
// Params 0, eflags: 0x0
// Checksum 0x2a9d89a9, Offset: 0x500
// Size: 0x306
function function_c7410880() {
    self endon(#"disconnect");
    while (true) {
        waitresult = self waittill(#"menuresponse");
        menu = waitresult.menu;
        response = waitresult.response;
        if (menu != "BlackMarket") {
            continue;
        }
        switch (response) {
        case #"hash_5bdc244fa0b52af6":
            thread function_d9abcfe();
            break;
        case #"hash_5f1d06e7c83098bf":
            function_888326b9("vox_mark_greeting_first");
            break;
        case #"hash_403fb2a5f5822a70":
            thread function_f174105a();
            break;
        case #"roll":
            function_888326b9("vox_mark_roll_in_progress");
            break;
        case #"hash_7c844116bbba6d5e":
            function_888326b9("vox_mark_complete_common");
            break;
        case #"hash_4c289cf90e92bd77":
            function_888326b9("vox_mark_complete_rare");
            break;
        case #"hash_723071ffa3379684":
            function_888326b9("vox_mark_complete_legendary");
            break;
        case #"hash_2bda815888a97fb6":
            function_888326b9("vox_mark_complete_epic");
            break;
        case #"hash_fa8b34c3f2df43f":
            thread function_ae2deb8();
            break;
        case #"stopsounds":
            level.var_cc4f1e31 stopsounds();
            break;
        case #"closed":
            level.var_cc4f1e31 stopsounds();
            level.var_cc4f1e31 thread animation::stop(0.2);
            level.var_bd18dfbe thread animation::stop(0.2);
            level.var_54a434fc thread animation::stop(0.2);
            level.var_cc4f1e31 notify(#"closed");
            break;
        }
    }
}

// Namespace frontend/frontend
// Params 1, eflags: 0x0
// Checksum 0xc6466a7d, Offset: 0x810
// Size: 0x5c
function function_888326b9(dialogalias) {
    if (!isdefined(dialogalias)) {
        return;
    }
    level.var_cc4f1e31 stopsounds();
    level.var_cc4f1e31 playsoundontag(dialogalias, "J_Head");
}

// Namespace frontend/frontend
// Params 0, eflags: 0x0
// Checksum 0xb6bc4ca7, Offset: 0x878
// Size: 0xb0
function function_c2c50a17() {
    if (getlocalprofileint("com_firsttime_blackmarket")) {
        return false;
    }
    level.var_cc4f1e31 endon(#"closed");
    function_c5205bdc(#"hash_6cfc22afa768745e", "o_black_marketeer_tumbler_1st_time_greeting_", "o_black_marketeer_pistol_1st_time_greeting_", "01");
    level.var_cc4f1e31 waittill(#"hash_426f281ca489d6a5");
    setlocalprofilevar("com_firsttime_blackmarket", 1);
    return true;
}

// Namespace frontend/frontend
// Params 0, eflags: 0x0
// Checksum 0x3c2c8cd7, Offset: 0x930
// Size: 0x9c
function function_d9abcfe() {
    level.var_cc4f1e31 endon(#"closed");
    if (function_c2c50a17()) {
        return;
    }
    var_27284619 = function_b64618f7(11);
    function_c5205bdc(#"hash_49d65f74fcf983eb", #"hash_4d5fcd9151b3da36", #"hash_3afdd6240896ed6", var_27284619);
}

// Namespace frontend/frontend
// Params 0, eflags: 0x0
// Checksum 0xc2e27965, Offset: 0x9d8
// Size: 0x9c
function function_f174105a() {
    level.var_cc4f1e31 endon(#"closed");
    if (function_c2c50a17()) {
        return;
    }
    var_27284619 = function_b64618f7(10);
    function_c5205bdc(#"hash_6766df4daefe5ba2", #"hash_1d2f9e06fabcb557", #"hash_35640e2cb1675b7", var_27284619);
}

// Namespace frontend/frontend
// Params 0, eflags: 0x0
// Checksum 0x2502bff1, Offset: 0xa80
// Size: 0x6c
function function_ae2deb8() {
    var_27284619 = function_b64618f7(6);
    function_c5205bdc(#"hash_64ba783f8b2a25f3", #"hash_5183e8afd8fa8b5e", #"hash_193962e3b1037d3e", var_27284619);
}

// Namespace frontend/frontend
// Params 1, eflags: 0x0
// Checksum 0xe86b9116, Offset: 0xaf8
// Size: 0x4e
function function_b64618f7(var_1c7f095f) {
    var_27284619 = randomint(var_1c7f095f);
    if (var_27284619 < 10) {
        return ("0" + var_27284619);
    }
    return var_27284619;
}

// Namespace frontend/frontend
// Params 4, eflags: 0x0
// Checksum 0x19a3bde0, Offset: 0xb50
// Size: 0x114
function function_c5205bdc(var_515c5969, var_2759f5e5, var_a12eee4f, var_27284619 = "") {
    level.var_cc4f1e31 stopsounds();
    level.var_cc4f1e31 thread function_c0d629d(var_515c5969 + var_27284619, #"pb_black_marketeer_idle", level.var_65f83320, level.var_a1674e6e);
    level.var_bd18dfbe thread function_c0d629d(var_2759f5e5 + var_27284619, #"hash_19fa4cd17f0ff1a8", level.var_cc4f1e31, "tag_origin");
    level.var_54a434fc thread function_c0d629d(var_a12eee4f + var_27284619, #"hash_5fd0e5e6bacf5f88", level.var_cc4f1e31, "tag_origin");
}

// Namespace frontend/frontend
// Params 4, eflags: 0x0
// Checksum 0xe23d2b6e, Offset: 0xc70
// Size: 0xf4
function function_c0d629d(animname, idleanimname, var_19357182, tagangles) {
    self notify(#"hash_22447db5611f1945");
    self endon(#"hash_22447db5611f1945");
    level.var_cc4f1e31 endon(#"closed");
    self thread animation::stop(0.2);
    self animation::play(animname, var_19357182, tagangles, 1, 0.2, 0.2);
    self notify(#"hash_426f281ca489d6a5");
    self thread animation::play(idleanimname, var_19357182, tagangles, 1, 0.2, 0);
}

/#

    // Namespace frontend/frontend
    // Params 0, eflags: 0x0
    // Checksum 0xa8f9e741, Offset: 0xd70
    // Size: 0x14e
    function dailychallengedevguiinit() {
        setdvar(#"daily_challenge_cmd", 0);
        num_rows = tablelookuprowcount(#"gamedata/stats/zm/statsmilestones4.csv");
        for (row_num = 2; row_num < num_rows; row_num++) {
            challenge_name = tablelookupcolumnforrow(#"gamedata/stats/zm/statsmilestones4.csv", row_num, 5);
            display_row_num = row_num - 2;
            devgui_string = "<dev string:x30>" + "<dev string:x3d>" + (display_row_num > 10 ? display_row_num : "<dev string:x52>" + display_row_num) + "<dev string:x54>" + function_15979fa9(challenge_name) + "<dev string:x56>" + row_num + "<dev string:x6e>";
            adddebugcommand(devgui_string);
        }
    }

    // Namespace frontend/frontend
    // Params 0, eflags: 0x0
    // Checksum 0x192674cf, Offset: 0xec8
    // Size: 0x190
    function dailychallengedevguithink() {
        self endon(#"disconnect");
        while (true) {
            daily_challenge_cmd = getdvarint(#"daily_challenge_cmd", 0);
            if (daily_challenge_cmd == 0 || !sessionmodeiszombiesgame()) {
                wait 1;
                continue;
            }
            daily_challenge_row = daily_challenge_cmd;
            daily_challenge_index = tablelookupcolumnforrow(#"gamedata/stats/zm/statsmilestones4.csv", daily_challenge_row, 0);
            daily_challenge_stat = tablelookupcolumnforrow(#"gamedata/stats/zm/statsmilestones4.csv", daily_challenge_row, 4);
            adddebugcommand("<dev string:x72>" + daily_challenge_stat + "<dev string:x90>" + "<dev string:xa2>");
            adddebugcommand("<dev string:xa5>" + daily_challenge_index + "<dev string:xa2>");
            adddebugcommand("<dev string:xe8>" + "<dev string:xa2>");
            setdvar(#"daily_challenge_cmd", 0);
        }
    }

    // Namespace frontend/frontend
    // Params 0, eflags: 0x0
    // Checksum 0x9879c939, Offset: 0x1060
    // Size: 0x3dc
    function function_3a680086() {
        level.var_29e827fa = getscriptbundle("<dev string:x12e>");
        if (!isdefined(level.var_29e827fa)) {
            return;
        }
        setdvar(#"callings_cmd", "<dev string:x143>");
        adddebugcommand("<dev string:x144>");
        for (seasonid = 1; seasonid <= level.var_29e827fa.size; seasonid++) {
            for (var_473005c4 = 0; var_473005c4 < 4; var_473005c4++) {
                faction = getscriptbundle(level.var_29e827fa.factionlist[var_473005c4].faction);
                factionname = makelocalizedstring(faction.factionname);
                var_9054854d = array(0, 1, 3, 6, 12);
                counter = 1;
                foreach (tokens in var_9054854d) {
                    var_ab15325c = "<dev string:x196>" + seasonid + "<dev string:x1a3>" + var_473005c4 + "<dev string:x1a3>" + tokens;
                    devgui_string = "<dev string:x1a5>" + seasonid + "<dev string:x1d8>" + factionname + "<dev string:x1db>" + tokens + "<dev string:x1dd>" + (tokens != 1 ? "<dev string:x1e4>" : "<dev string:x143>") + "<dev string:x1e6>" + counter + "<dev string:x1e8>" + var_ab15325c + "<dev string:x1f9>";
                    adddebugcommand(devgui_string);
                    counter++;
                }
                counter = 1;
                for (var_27efe5b4 = 0; var_27efe5b4 <= 12; var_27efe5b4++) {
                    var_9118bca4 = "<dev string:x1fc>" + seasonid + "<dev string:x1a3>" + var_473005c4 + "<dev string:x1a3>" + var_27efe5b4;
                    devgui_string = "<dev string:x210>" + seasonid + "<dev string:x1d8>" + factionname + "<dev string:x24b>" + var_27efe5b4 + "<dev string:x1e6>" + counter + "<dev string:x1e8>" + var_9118bca4 + "<dev string:x1f9>";
                    adddebugcommand(devgui_string);
                    counter++;
                }
            }
            adddebugcommand("<dev string:x252>" + seasonid + "<dev string:x1e6>" + seasonid + "<dev string:x288>" + seasonid + "<dev string:x1f9>");
            seasonid++;
        }
    }

    // Namespace frontend/frontend
    // Params 1, eflags: 0x20 variadic
    // Checksum 0xeb3c9612, Offset: 0x1448
    // Size: 0xc4
    function function_d0123b77(...) {
        assert(vararg.size > 1);
        if (vararg.size <= 1) {
            return;
        }
        cmd = "<dev string:x2a7>";
        for (i = 0; i < vararg.size; i++) {
            cmd += vararg[i] + "<dev string:x54>";
        }
        cmd += "<dev string:x2b5>";
        adddebugcommand(cmd);
    }

    // Namespace frontend/frontend
    // Params 1, eflags: 0x0
    // Checksum 0xec228d7c, Offset: 0x1518
    // Size: 0x212
    function function_8db211f9(seasonid) {
        function_d0123b77("<dev string:x2b8>", seasonid - 1, "<dev string:x2cd>");
        function_d0123b77("<dev string:x2b8>", seasonid - 1, "<dev string:x2e0>");
        function_d0123b77("<dev string:x2b8>", seasonid - 1, "<dev string:x2f3>");
        function_d0123b77("<dev string:x2b8>", seasonid - 1, "<dev string:x306>");
        for (var_473005c4 = 0; var_473005c4 < 4; var_473005c4++) {
            function_d0123b77("<dev string:x2b8>", seasonid - 1, "<dev string:x316>", var_473005c4, "<dev string:x31f>");
            function_d0123b77("<dev string:x2b8>", seasonid - 1, "<dev string:x316>", var_473005c4, "<dev string:x326>");
            function_d0123b77("<dev string:x2b8>", seasonid - 1, "<dev string:x316>", var_473005c4, "<dev string:x335>");
            for (groupid = 0; groupid < 3; groupid++) {
                for (categoryid = 0; categoryid < 4; categoryid++) {
                    function_d0123b77("<dev string:x2b8>", seasonid - 1, "<dev string:x316>", var_473005c4, "<dev string:x340>", groupid, "<dev string:x350>", categoryid, "<dev string:x361>");
                }
            }
        }
    }

    // Namespace frontend/frontend
    // Params 0, eflags: 0x0
    // Checksum 0x18606926, Offset: 0x1738
    // Size: 0x2a6
    function function_606766fc() {
        for (seasonid = 1; seasonid <= level.var_29e827fa.size; seasonid++) {
            function_8db211f9(seasonid);
        }
        function_d0123b77("<dev string:x36b>", "<dev string:x379>");
        function_d0123b77("<dev string:x36b>", "<dev string:x385>");
        function_d0123b77("<dev string:x36b>", "<dev string:x391>");
        function_d0123b77("<dev string:x36b>", "<dev string:x3a7>");
        function_d0123b77("<dev string:x36b>", "<dev string:x3b5>");
        function_d0123b77("<dev string:x36b>", "<dev string:x3c2>");
        function_d0123b77("<dev string:x36b>", "<dev string:x3d5>");
        function_d0123b77("<dev string:x36b>", "<dev string:x3ee>");
        for (i = 0; i < 4; i++) {
            function_d0123b77("<dev string:x36b>", "<dev string:x402>", i, "<dev string:x40b>");
            function_d0123b77("<dev string:x36b>", "<dev string:x402>", i, "<dev string:x411>");
            function_d0123b77("<dev string:x36b>", "<dev string:x41a>", i, "<dev string:x425>");
            function_d0123b77("<dev string:x36b>", "<dev string:x41a>", i, "<dev string:x42d>");
            function_d0123b77("<dev string:x36b>", "<dev string:x41a>", i, "<dev string:x40b>");
        }
        for (var_473005c4 = 0; var_473005c4 < 4; var_473005c4++) {
            function_d0123b77("<dev string:x36b>", "<dev string:x43a>", var_473005c4);
        }
    }

    // Namespace frontend/frontend
    // Params 0, eflags: 0x0
    // Checksum 0x83e92a4a, Offset: 0x19e8
    // Size: 0x388
    function function_d79afb78() {
        if (!isdefined(level.var_29e827fa)) {
            return;
        }
        level endon(#"game_ended");
        while (true) {
            callings_cmd = getdvarstring(#"callings_cmd", "<dev string:x143>");
            if (callings_cmd == "<dev string:x143>") {
                wait 0.25;
                continue;
            }
            if (callings_cmd == "<dev string:x44b>") {
                function_606766fc();
            } else if (strstartswith(callings_cmd, "<dev string:x196>")) {
                str = strreplace(callings_cmd, "<dev string:x196>", "<dev string:x143>");
                arr = strtok(str, "<dev string:x1a3>");
                seasonid = arr[0];
                var_473005c4 = arr[1];
                tokens = arr[2];
                statpath = "<dev string:x45b>" + int(seasonid) - 1 + "<dev string:x471>" + var_473005c4 + "<dev string:x47c>" + tokens;
                adddebugcommand("<dev string:x2a7>" + statpath + "<dev string:xa2>");
            } else if (strstartswith(callings_cmd, "<dev string:x485>")) {
                str = strreplace(callings_cmd, "<dev string:x485>", "<dev string:x143>");
                seasonid = int(str);
                function_8db211f9(seasonid);
            } else if (strstartswith(callings_cmd, "<dev string:x1fc>")) {
                str = strreplace(callings_cmd, "<dev string:x1fc>", "<dev string:x143>");
                arr = strtok(str, "<dev string:x1a3>");
                seasonid = arr[0];
                var_473005c4 = arr[1];
                tier = arr[2];
                statpath = "<dev string:x45b>" + int(seasonid) - 1 + "<dev string:x471>" + var_473005c4 + "<dev string:x494>" + tier;
                adddebugcommand("<dev string:x2a7>" + statpath + "<dev string:xa2>");
            }
            setdvar(#"callings_cmd", "<dev string:x143>");
        }
    }

#/
