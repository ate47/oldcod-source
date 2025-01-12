#using scripts/core_common/ai/animation_selector_table_evaluators;
#using scripts/core_common/ai/archetype_cover_utility;
#using scripts/core_common/ai/archetype_damage_effects;
#using scripts/core_common/ai/archetype_locomotion_utility;
#using scripts/core_common/ai/archetype_mocomps_utility;
#using scripts/core_common/ai/archetype_utility;
#using scripts/core_common/ai/behavior_state_machine_planners_utility;
#using scripts/core_common/ai/zombie;
#using scripts/core_common/animation_shared;
#using scripts/core_common/array_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/lui_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/player_shared;
#using scripts/core_common/scene_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/util_shared;

#namespace frontend;

// Namespace frontend/frontend
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x9e0
// Size: 0x4
function callback_void() {
    
}

// Namespace frontend/frontend
// Params 1, eflags: 0x0
// Checksum 0xf284e063, Offset: 0x9f0
// Size: 0x24
function callback_actorspawnedfrontend(spawner) {
    self thread spawner::spawn_think(spawner);
}

// Namespace frontend/GameType_Init
// Params 1, eflags: 0x40
// Checksum 0x1d018855, Offset: 0xa20
// Size: 0x494
function event_handler[GameType_Init] main(eventstruct) {
    level.callbackstartgametype = &callback_void;
    level.callbackplayerconnect = &callback_playerconnect;
    level.callbackplayerdisconnect = &callback_void;
    level.callbackentityspawned = &callback_void;
    level.callbackactorspawned = &callback_actorspawnedfrontend;
    level.orbis = getdvarstring("orbisGame") == "true";
    level.durango = getdvarstring("durangoGame") == "true";
    scene::add_scene_func("sb_frontend_black_market", &function_98e4f876, "play");
    clientfield::register("world", "first_time_flow", 1, getminbitcountfornum(1), "int");
    clientfield::register("world", "cp_bunk_anim_type", 1, getminbitcountfornum(1), "int");
    clientfield::register("actor", "zombie_has_eyes", 1, 1, "int");
    clientfield::register("scriptmover", "dni_eyes", 1000, 1, "int");
    level.weaponnone = getweapon("none");
    level.teambased = 0;
    /#
        level thread dailychallengedevguiinit();
        setdvar("<dev string:x28>", 0);
        adddebugcommand("<dev string:x41>");
        setdvar("<dev string:x91>", "<dev string:xa8>");
        adddebugcommand("<dev string:xb0>");
        adddebugcommand("<dev string:x104>");
        adddebugcommand("<dev string:x15a>");
        adddebugcommand("<dev string:x1b6>");
    #/
    level thread function_f7d50167();
    level scene::add_scene_func("sb_frontend_lineup_battery", &function_e77875e0, undefined, 3, "frontend_battery_character", "battery_head");
    level scene::add_scene_func("sb_frontend_lineup_blackmarket", &function_e77875e0, undefined, 9, "frontend_blackmarket_character", "blackmarket_head");
    level scene::add_scene_func("sb_frontend_lineup_firebreak", &function_e77875e0, undefined, 8, "frontend_firebreak_character", "firebreak_head");
    level scene::add_scene_func("sb_frontend_lineup_outrider", &function_e77875e0, undefined, 1, "frontend_outrider_character", "outrider_head");
    level scene::add_scene_func("sb_frontend_lineup_reaper", &function_e77875e0, undefined, 6, "frontend_reaper_character", "reaper_head");
    level scene::add_scene_func("sb_frontend_lineup_ruin", &function_e77875e0, undefined, 0, "frontend_ruin_character", "ruin_head");
}

// Namespace frontend/frontend
// Params 0, eflags: 0x0
// Checksum 0x4d118d40, Offset: 0xec0
// Size: 0x114
function function_f7d50167() {
    waitframe(1);
    if (world.var_1048aced !== 0) {
        world.cp_bunk_anim_type = 0;
        level clientfield::set("first_time_flow", 1);
        /#
            printtoprightln("<dev string:x20e>", (1, 1, 1));
        #/
        return;
    }
    if (math::cointoss()) {
        world.cp_bunk_anim_type = 0;
        /#
            printtoprightln("<dev string:x22e>", (1, 1, 1));
        #/
    } else {
        world.cp_bunk_anim_type = 1;
        /#
            printtoprightln("<dev string:x23b>", (1, 1, 1));
        #/
    }
    level clientfield::set("cp_bunk_anim_type", world.cp_bunk_anim_type);
}

// Namespace frontend/frontend
// Params 0, eflags: 0x0
// Checksum 0xf442afac, Offset: 0xfe0
// Size: 0x4c
function callback_playerconnect() {
    self thread function_c7410880();
    self thread function_8b6c3765();
    /#
        self thread dailychallengedevguithink();
    #/
}

// Namespace frontend/frontend
// Params 0, eflags: 0x0
// Checksum 0x2c2c5221, Offset: 0x1038
// Size: 0xc0
function function_8b6c3765() {
    self endon(#"disconnect");
    while (true) {
        waitresult = self waittill("menuresponse");
        if (waitresult.menu != "Main") {
            continue;
        }
        if (waitresult.response == "close") {
            var_1d60e359 = getent("start_screen_bg", "targetname");
            if (isdefined(var_1d60e359)) {
                var_1d60e359 hide();
            }
        }
    }
}

// Namespace frontend/frontend
// Params 1, eflags: 0x0
// Checksum 0x74621fa3, Offset: 0x1100
// Size: 0xcc
function function_98e4f876(a_ents) {
    level.var_65f83320 = self.origin;
    level.var_a1674e6e = self.angles;
    level.var_cc4f1e31 = a_ents["sb_frontend_black_market_character"];
    level.var_bd18dfbe = a_ents["lefthand"];
    level.var_54a434fc = a_ents["righthand"];
    level scene::stop("sb_frontend_black_market");
    level.var_cc4f1e31 clientfield::set("dni_eyes", 1);
}

// Namespace frontend/frontend
// Params 0, eflags: 0x0
// Checksum 0x270ce924, Offset: 0x11d8
// Size: 0x2c2
function function_c7410880() {
    self endon(#"disconnect");
    while (true) {
        waitresult = self waittill("menuresponse");
        menu = waitresult.menu;
        response = waitresult.response;
        if (menu != "BlackMarket") {
            continue;
        }
        switch (response) {
        case #"hash_b416e220":
            thread function_d9abcfe();
            break;
        case #"hash_4761db8b":
            function_888326b9("vox_mark_greeting_first");
            break;
        case #"hash_c14583b2":
            thread function_f174105a();
            break;
        case #"roll":
            function_888326b9("vox_mark_roll_in_progress");
            break;
        case #"hash_efec28c0":
            function_888326b9("vox_mark_complete_common");
            break;
        case #"hash_130d01bb":
            function_888326b9("vox_mark_complete_rare");
            break;
        case #"hash_f0f04b2":
            function_888326b9("vox_mark_complete_legendary");
            break;
        case #"hash_99ac55fc":
            function_888326b9("vox_mark_complete_epic");
            break;
        case #"hash_ffa76927":
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
// Checksum 0xbf9eb8f2, Offset: 0x14a8
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
// Checksum 0xfc11efa4, Offset: 0x1510
// Size: 0xa8
function function_c2c50a17() {
    if (getlocalprofileint("com_firsttime_blackmarket")) {
        return false;
    }
    level.var_cc4f1e31 endon(#"closed");
    function_c5205bdc("pb_black_marketeer_1st_time_greeting_", "o_black_marketeer_tumbler_1st_time_greeting_", "o_black_marketeer_pistol_1st_time_greeting_", "01");
    level.var_cc4f1e31 waittill("finished_black_market_animation");
    setlocalprofilevar("com_firsttime_blackmarket", 1);
    return true;
}

// Namespace frontend/frontend
// Params 0, eflags: 0x0
// Checksum 0xfdadf794, Offset: 0x15c0
// Size: 0x7c
function function_d9abcfe() {
    level.var_cc4f1e31 endon(#"closed");
    if (function_c2c50a17()) {
        return;
    }
    var_27284619 = function_b64618f7(11);
    function_c5205bdc("pb_black_marketeer_greeting_", "o_black_marketeer_tumbler_greeting_", "o_black_marketeer_pistol_greeting_", var_27284619);
}

// Namespace frontend/frontend
// Params 0, eflags: 0x0
// Checksum 0x6a13cf71, Offset: 0x1648
// Size: 0x7c
function function_f174105a() {
    level.var_cc4f1e31 endon(#"closed");
    if (function_c2c50a17()) {
        return;
    }
    var_27284619 = function_b64618f7(10);
    function_c5205bdc("pb_black_marketeer_insufficient_funds_", "o_black_marketeer_tumbler_insufficient_funds_", "o_black_marketeer_pistol_insufficient_funds_", var_27284619);
}

// Namespace frontend/frontend
// Params 0, eflags: 0x0
// Checksum 0x71292f66, Offset: 0x16d0
// Size: 0x54
function function_ae2deb8() {
    var_27284619 = function_b64618f7(6);
    function_c5205bdc("pb_black_marketeer_burn_dupes_", "o_black_marketeer_tumbler_burn_dupes_", "o_black_marketeer_pistol_burn_dupes_", var_27284619);
}

// Namespace frontend/frontend
// Params 1, eflags: 0x0
// Checksum 0x5b43a9a3, Offset: 0x1730
// Size: 0x52
function function_b64618f7(var_1c7f095f) {
    var_27284619 = randomint(var_1c7f095f);
    if (var_27284619 < 10) {
        return ("0" + var_27284619);
    }
    return var_27284619;
}

// Namespace frontend/frontend
// Params 4, eflags: 0x0
// Checksum 0xef27a7ae, Offset: 0x1790
// Size: 0x124
function function_c5205bdc(var_515c5969, var_2759f5e5, var_a12eee4f, var_27284619) {
    if (!isdefined(var_27284619)) {
        var_27284619 = "";
    }
    level.var_cc4f1e31 stopsounds();
    level.var_cc4f1e31 thread function_c0d629d(var_515c5969 + var_27284619, "pb_black_marketeer_idle", level.var_65f83320, level.var_a1674e6e);
    level.var_bd18dfbe thread function_c0d629d(var_2759f5e5 + var_27284619, "o_black_marketeer_tumbler_idle", level.var_cc4f1e31, "tag_origin");
    level.var_54a434fc thread function_c0d629d(var_a12eee4f + var_27284619, "o_black_marketeer_pistol_idle", level.var_cc4f1e31, "tag_origin");
}

// Namespace frontend/frontend
// Params 4, eflags: 0x0
// Checksum 0x8b0dcb9f, Offset: 0x18c0
// Size: 0xec
function function_c0d629d(animname, idleanimname, var_19357182, tagangles) {
    self notify(#"hash_c0d629d");
    self endon(#"hash_c0d629d");
    level.var_cc4f1e31 endon(#"closed");
    self thread animation::stop(0.2);
    self animation::play(animname, var_19357182, tagangles, 1, 0.2, 0.2);
    self notify(#"finished_black_market_animation");
    self thread animation::play(idleanimname, var_19357182, tagangles, 1, 0.2, 0);
}

// Namespace frontend/frontend
// Params 3, eflags: 0x20 variadic
// Checksum 0xb9483e0a, Offset: 0x19b8
// Size: 0x16a
function function_e77875e0(a_ents, characterindex, ...) {
    var_957cc42 = getcharactermoderenderoptions(1);
    var_6f30937d = getcharacterbodyrenderoptions(characterindex, 0, 0, 0, 0);
    var_d44a8060 = getcharacterhelmetrenderoptions(characterindex, 0, 0, 0, 0);
    var_ebda9e17 = getcharacterheadrenderoptions(0);
    foreach (targetname in vararg) {
        ent = a_ents[targetname];
        if (isdefined(ent)) {
            ent setcustombodyrenderoptions(var_957cc42, var_6f30937d, var_d44a8060, var_ebda9e17);
        }
    }
}

/#

    // Namespace frontend/frontend
    // Params 0, eflags: 0x0
    // Checksum 0xa5f57d00, Offset: 0x1b30
    // Size: 0x15e
    function dailychallengedevguiinit() {
        setdvar("<dev string:x249>", 0);
        num_rows = tablelookuprowcount("<dev string:x25d>");
        for (row_num = 2; row_num < num_rows; row_num++) {
            challenge_name = tablelookupcolumnforrow("<dev string:x25d>", row_num, 5);
            challenge_name = getsubstr(challenge_name, 11);
            display_row_num = row_num - 2;
            devgui_string = "<dev string:x284>" + "<dev string:x291>" + (display_row_num < 10 ? "<dev string:x2a6>" + display_row_num : display_row_num) + "<dev string:x2a8>" + challenge_name + "<dev string:x2aa>" + row_num + "<dev string:x2c2>";
            adddebugcommand(devgui_string);
        }
    }

    // Namespace frontend/frontend
    // Params 0, eflags: 0x0
    // Checksum 0xf638045c, Offset: 0x1c98
    // Size: 0x178
    function dailychallengedevguithink() {
        self endon(#"disconnect");
        while (true) {
            daily_challenge_cmd = getdvarint("<dev string:x249>");
            if (daily_challenge_cmd == 0 || !sessionmodeiszombiesgame()) {
                wait 1;
                continue;
            }
            daily_challenge_row = daily_challenge_cmd;
            daily_challenge_index = tablelookupcolumnforrow("<dev string:x25d>", daily_challenge_row, 0);
            daily_challenge_stat = tablelookupcolumnforrow("<dev string:x25d>", daily_challenge_row, 4);
            adddebugcommand("<dev string:x2c6>" + daily_challenge_stat + "<dev string:x2e4>" + "<dev string:x2f6>");
            adddebugcommand("<dev string:x2f9>" + daily_challenge_index + "<dev string:x2f6>");
            adddebugcommand("<dev string:x33c>" + "<dev string:x2f6>");
            setdvar("<dev string:x249>", 0);
        }
    }

#/
