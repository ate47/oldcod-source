#using script_1435f3c9fc699e04;
#using script_1cc417743d7c262d;
#using script_306215d6cfd5f1f4;
#using script_335d0650ed05d36d;
#using script_3d703ef87a841fe4;
#using script_3e196d275a6fb180;
#using script_44b0b8420eabacad;
#using script_7d712f77ab8d0c16;
#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\demo_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\popups_shared;
#using scripts\core_common\potm_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\territory;
#using scripts\core_common\territory_util;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\bb;
#using scripts\mp_common\gametypes\gametype;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\gametypes\round;
#using scripts\mp_common\util;

#namespace namespace_5c32f369;

// Namespace namespace_5c32f369/ui_menuresponse
// Params 1, eflags: 0x40
// Checksum 0x194cb2b1, Offset: 0x758
// Size: 0xac
function event_handler[ui_menuresponse] codecallback_menuresponse(eventstruct) {
    spawningplayer = self;
    menu = eventstruct.menu;
    response = eventstruct.response;
    if (!isdefined(menu)) {
        menu = "";
    }
    if (!isdefined(response)) {
        response = "";
    }
    if (menu == "Hud_NavigableUI") {
        if (response == "spectateObjective") {
            spawningplayer function_5ca9806b(eventstruct.intpayload);
        }
    }
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 0, eflags: 0x0
// Checksum 0x3b328966, Offset: 0x810
// Size: 0xcc
function init() {
    level.onstartgametype = &onstartgametype;
    level.var_f5a73a96 = 1;
    level.onroundswitch = &on_round_switch;
    level.var_5c32f369 = spawnstruct();
    function_daaeaa95();
    spawning::addsupportedspawnpointtype("dom");
    /#
        spawning::function_a860c440(&function_8d90ce2e);
    #/
    callback::on_game_playing(&on_game_playing);
}

/#

    // Namespace namespace_5c32f369/namespace_5c32f369
    // Params 0, eflags: 0x0
    // Checksum 0x16fa1eb5, Offset: 0x8e8
    // Size: 0x15c
    function function_8d90ce2e() {
        spawning::function_25e7711a("<dev string:x38>", #"none", "<dev string:x40>", "<dev string:x51>");
        spawning::function_25e7711a("<dev string:x59>", #"none", "<dev string:x61>", "<dev string:x51>");
        spawning::function_25e7711a("<dev string:x72>", #"none", "<dev string:x7a>", "<dev string:x51>");
        spawning::function_25e7711a("<dev string:x8b>", #"none", "<dev string:x93>", "<dev string:x51>");
        spawning::function_25e7711a("<dev string:xa4>", #"none", "<dev string:xac>", "<dev string:x51>");
        spawning::function_25e7711a("<dev string:xbd>", #"none", "<dev string:xc5>", "<dev string:x51>");
    }

#/

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 0, eflags: 0x0
// Checksum 0xfd268ddf, Offset: 0xa50
// Size: 0xb8
function function_fdbc620d() {
    var_bd4d0f54 = getentarray("flag_primary", "targetname");
    foreach (zone in var_bd4d0f54) {
        zone setmodel("tag_origin");
    }
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 1, eflags: 0x0
// Checksum 0x509a209b, Offset: 0xb10
// Size: 0xb2
function function_4480f87e(capturearea) {
    capturearea.onuse = &on_use;
    capturearea.onbeginuse = &on_begin_use;
    capturearea.onuseupdate = &on_use_update;
    capturearea.onenduse = &on_end_use;
    capturearea.onupdateuserate = &function_bcaf6836;
    capturearea.ondecaycomplete = &on_decay_complete;
    capturearea.ontouchuse = &on_touch_use;
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 0, eflags: 0x0
// Checksum 0x97d0caaf, Offset: 0xbd0
// Size: 0x38
function function_dbba0e25() {
    var_bd4d0f54 = getentarray("flag_primary", "targetname");
    return var_bd4d0f54.size > 0;
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 1, eflags: 0x0
// Checksum 0xab3df8df, Offset: 0xc10
// Size: 0x61a
function function_16ee17b2(var_6c9e0594) {
    flag_capture_rate_increase = isdefined(getgametypesetting(#"flagcapturerateincrease")) ? getgametypesetting(#"flagcapturerateincrease") : 0;
    decay_progress = isdefined(getgametypesetting(#"decayprogress")) ? getgametypesetting(#"decayprogress") : 0;
    var_3bf7dda = isdefined(getgametypesetting(#"autodecaytime")) ? getgametypesetting(#"autodecaytime") : undefined;
    var_1c72bdec = getgametypesetting(#"capturetime");
    var_17cc111a = getgametypesetting(#"hash_130d127406ab976e");
    var_49e24f2 = getgametypesetting(#"maxusers");
    if (level.flagcanbeneutralized) {
        var_1c72bdec /= 2;
        var_17cc111a /= 2;
    }
    var_bd4d0f54 = getentarray("flag_primary", "targetname");
    if (var_bd4d0f54.size == 0) {
        /#
            for (index = 0; index < 20; index++) {
                println("<dev string:xd6>");
            }
        #/
        callback::abort_level();
        return [];
    }
    var_3a0ebe3c = function_fa8f5fda(var_bd4d0f54);
    var_b96c9514 = [];
    foreach (index, trigger in var_3a0ebe3c) {
        visuals = [];
        visuals[0] = trigger.visual;
        name = #"dom" + trigger.visual.script_label;
        var_6b67c295 = gameobjects::create_use_object(#"none", trigger, visuals, (0, 0, 0), name);
        var_6b67c295 gameobjects::allow_use(#"group_enemy");
        var_6b67c295 gameobjects::set_use_text(#"mp/capturing_flag");
        var_6b67c295 gameobjects::set_visible(#"group_all");
        var_6b67c295 gameobjects::set_owner_team(#"neutral");
        var_6b67c295 gameobjects::set_objective_entity(visuals[0]);
        var_6b67c295.label = var_6b67c295 gameobjects::get_label();
        var_6b67c295 gameobjects::function_5ea37c7c(&gameobjects::function_83eda4c0);
        var_6b67c295 gameobjects::set_use_time(var_1c72bdec);
        var_6b67c295 gameobjects::function_3dc7107c(var_49e24f2);
        var_6b67c295 gameobjects::function_e887a9d0(var_17cc111a);
        var_6b67c295.var_45438686 = 1;
        var_6b67c295.var_d1c3006c = 1;
        var_6b67c295.hasbeencaptured = 0;
        var_6b67c295.flagindex = trigger.visual.script_index;
        var_6b67c295.var_56d394cd = 0;
        var_6b67c295.var_a0ff5eb8 = !flag_capture_rate_increase;
        var_6b67c295.decayprogress = decay_progress;
        var_6b67c295.autodecaytime = var_3bf7dda;
        if (var_6b67c295.decayprogress) {
            var_6b67c295 gameobjects::must_maintain_claim(0);
            var_6b67c295 gameobjects::set_decay_time(var_1c72bdec);
        }
        assert(isdefined(var_6c9e0594));
        [[ var_6c9e0594 ]](var_6b67c295);
        var_6b67c295.var_249009fd = [];
        function_229b384c(var_6b67c295);
        var_6b67c295.var_c851244c = 0;
        if (isdefined(var_6b67c295.data.var_95afd88f)) {
            var_6b67c295.var_c851244c = namespace_99c84a33::function_99652b58(var_6b67c295.data.var_95afd88f, var_6b67c295.objectiveid);
        }
        trigger.gameobject = var_6b67c295;
        if (!isdefined(var_b96c9514)) {
            var_b96c9514 = [];
        } else if (!isarray(var_b96c9514)) {
            var_b96c9514 = array(var_b96c9514);
        }
        var_b96c9514[var_b96c9514.size] = var_6b67c295;
    }
    return var_b96c9514;
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 1, eflags: 0x0
// Checksum 0xe773ad46, Offset: 0x1238
// Size: 0x32e
function function_229b384c(zone) {
    data = {};
    label = zone gameobjects::get_label();
    switch (label) {
    case #"_a":
        data.var_1629d8a0 = #"hash_3ff1c88b4360ea84";
        data.var_44e9bd00 = #"hash_5b47de31c97a49ff";
        data.spawnlist = "spl1";
        data.var_bd674032 = 1;
        data.var_95afd88f = "dom_a_cam";
        break;
    case #"_b":
        data.var_1629d8a0 = #"hash_dd6191acefd6847";
        data.var_44e9bd00 = #"hash_481e5e34f798331e";
        data.var_bd674032 = 2;
        data.spawnlist = "spl2";
        data.var_ecee1402 = 1;
        data.var_95afd88f = "dom_b_cam";
        break;
    case #"_c":
        data.var_1629d8a0 = #"hash_25a2a0aff40c76aa";
        data.var_44e9bd00 = #"hash_6a0c2383d37849bd";
        data.spawnlist = "spl3";
        data.var_bd674032 = 3;
        data.var_95afd88f = "dom_c_cam";
        break;
    case #"_d":
        data.var_1629d8a0 = #"hash_2bcd7171f9aae4a5";
        data.var_44e9bd00 = #"hash_5079687d6a87790c";
        data.spawnlist = "spl4";
        data.var_bd674032 = 4;
        data.var_95afd88f = "dom_d_cam";
        break;
    case #"_e":
        data.var_1629d8a0 = #"hash_5334d65b46b55660";
        data.var_44e9bd00 = #"hash_78e2a90cf85daa3b";
        data.spawnlist = "spl5";
        data.var_bd674032 = 5;
        data.var_95afd88f = "dom_d_cam";
        break;
    case #"_f":
        data.var_1629d8a0 = #"hash_6848900356c78b93";
        data.var_44e9bd00 = #"hash_cd72c0a5ba856da";
        data.spawnlist = "spl6";
        data.var_bd674032 = 6;
        data.var_95afd88f = "dom_f_cam";
        break;
    default:
        break;
    }
    data.dialog_key = "objective" + label;
    zone.data = data;
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 0, eflags: 0x0
// Checksum 0xfdf6f232, Offset: 0x1570
// Size: 0x22a
function function_669e3110() {
    var_9a6d57c4 = territory::function_1deaf019("headquarter", "targetname");
    if (var_9a6d57c4.size == 0) {
        return [];
    }
    var_db1e5a88 = [];
    foreach (headquarter in var_9a6d57c4) {
        if (!isdefined(level.teams[headquarter.script_team])) {
            continue;
        }
        headquarter.objectiveid = gameobjects::get_next_obj_id();
        headquarter.var_c851244c = 0;
        objective_add(headquarter.objectiveid, "active", headquarter, "dom_headquarter");
        objective_setteam(headquarter.objectiveid, headquarter.script_team);
        function_4339912c(headquarter.objectiveid);
        function_29ef32ee(headquarter.objectiveid, headquarter.script_team);
        headquarter.var_95afd88f = "dom_" + headquarter.script_team + "_hq_cam";
        headquarter.var_c851244c = namespace_99c84a33::function_99652b58(headquarter.var_95afd88f, headquarter.objectiveid, headquarter.script_team);
        if (!isdefined(var_db1e5a88)) {
            var_db1e5a88 = [];
        } else if (!isarray(var_db1e5a88)) {
            var_db1e5a88 = array(var_db1e5a88);
        }
        var_db1e5a88[var_db1e5a88.size] = headquarter;
    }
    return var_db1e5a88;
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 0, eflags: 0x0
// Checksum 0xc1223959, Offset: 0x17a8
// Size: 0x534
function function_daaeaa95() {
    game.dialog[#"securing_a"] = "domFriendlySecuringA";
    game.dialog[#"securing_b"] = "domFriendlySecuringB";
    game.dialog[#"securing_c"] = "domFriendlySecuringC";
    game.dialog[#"securing_d"] = "domFriendlySecuringD";
    game.dialog[#"securing_e"] = "domFriendlySecuringE";
    game.dialog[#"securing_f"] = "domFriendlySecuringF";
    game.dialog[#"secured_a"] = "domFriendlySecuredA";
    game.dialog[#"secured_b"] = "domFriendlySecuredB";
    game.dialog[#"secured_c"] = "domFriendlySecuredC";
    game.dialog[#"secured_d"] = "domFriendlySecuredD";
    game.dialog[#"secured_e"] = "domFriendlySecuredE";
    game.dialog[#"secured_f"] = "domFriendlySecuredF";
    game.dialog[#"secured_all"] = "domFriendlySecuredAll";
    game.dialog[#"losing_a"] = "domEnemySecuringA";
    game.dialog[#"losing_b"] = "domEnemySecuringB";
    game.dialog[#"losing_c"] = "domEnemySecuringC";
    game.dialog[#"losing_d"] = "domEnemySecuringD";
    game.dialog[#"losing_e"] = "domEnemySecuringE";
    game.dialog[#"losing_f"] = "domEnemySecuringF";
    game.dialog[#"lost_a"] = "domEnemySecuredA";
    game.dialog[#"lost_b"] = "domEnemySecuredB";
    game.dialog[#"lost_c"] = "domEnemySecuredC";
    game.dialog[#"lost_d"] = "domEnemySecuredD";
    game.dialog[#"lost_e"] = "domEnemySecuredE";
    game.dialog[#"lost_f"] = "domEnemySecuredF";
    game.dialog[#"lost_all"] = "domEnemySecuredAll";
    game.dialog[#"enemy_a"] = "domEnemyHasA";
    game.dialog[#"enemy_b"] = "domEnemyHasB";
    game.dialog[#"enemy_c"] = "domEnemyHasC";
    game.dialog[#"enemy_d"] = "domEnemyHasD";
    game.dialog[#"enemy_e"] = "domEnemyHasE";
    game.dialog[#"enemy_f"] = "domEnemyHasF";
    game.dialogtime = [];
    game.dialogtime[#"securing_a"] = 0;
    game.dialogtime[#"securing_b"] = 0;
    game.dialogtime[#"securing_c"] = 0;
    game.dialogtime[#"securing_d"] = 0;
    game.dialogtime[#"securing_e"] = 0;
    game.dialogtime[#"securing_f"] = 0;
    game.dialogtime[#"losing_a"] = 0;
    game.dialogtime[#"losing_b"] = 0;
    game.dialogtime[#"losing_c"] = 0;
    game.dialogtime[#"losing_d"] = 0;
    game.dialogtime[#"losing_e"] = 0;
    game.dialogtime[#"losing_f"] = 0;
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 1, eflags: 0x4
// Checksum 0xa39ca40, Offset: 0x1ce8
// Size: 0x394
function private function_fa8f5fda(var_bd4d0f54) {
    var_3a0ebe3c = [];
    foreach (var_68adb4a4 in var_bd4d0f54) {
        if (!var_68adb4a4 territory::is_inside(var_68adb4a4.origin)) {
            continue;
        }
        if (isdefined(var_68adb4a4.target)) {
            var_68adb4a4 setmodel("tag_origin");
            triggers = territory::function_1deaf019(var_68adb4a4.target, "targetname");
            /#
                var_99db19f5 = "<dev string:x103>";
                if (isdefined(level.territory) && isdefined(level.territory.targetname)) {
                    var_99db19f5 = "<dev string:x107>" + level.territory.targetname + "<dev string:x11a>";
                }
                assert(triggers.size == 1, "<dev string:x11f>" + var_68adb4a4.target + "<dev string:x14b>" + triggers.size + var_99db19f5);
            #/
            trigger = triggers[0];
            trigger trigger::add_flags(16);
            if (isdefined(trigger)) {
                trigger.visual = var_68adb4a4;
                trigger.script_label = var_68adb4a4.script_label;
            } else {
                /#
                    util::error("<dev string:x15b>" + var_68adb4a4.script_label + "<dev string:x17e>" + var_68adb4a4.target);
                #/
            }
        } else {
            /#
                util::error("<dev string:x15b>" + var_68adb4a4.script_label);
            #/
        }
        if (trigger.script_label == "_a") {
            var_3a0ebe3c[0] = trigger;
            continue;
        }
        if (trigger.script_label == "_b") {
            var_3a0ebe3c[1] = trigger;
            continue;
        }
        if (trigger.script_label == "_c") {
            var_3a0ebe3c[2] = trigger;
            continue;
        }
        if (trigger.script_label == "_d") {
            var_3a0ebe3c[3] = trigger;
            continue;
        }
        if (trigger.script_label == "_e") {
            var_3a0ebe3c[4] = trigger;
            continue;
        }
        if (trigger.script_label == "_f") {
            var_3a0ebe3c[5] = trigger;
            continue;
        }
        /#
            util::error("<dev string:x193>" + trigger.script_label);
        #/
    }
    return var_3a0ebe3c;
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 1, eflags: 0x4
// Checksum 0xf72b07a0, Offset: 0x2088
// Size: 0x66
function private function_c6b70aba(dialog) {
    dialogtime = game.dialogtime[dialog];
    if (isdefined(dialogtime)) {
        time = gettime();
        if (dialogtime > time) {
            return true;
        }
        game.dialogtime[dialog] = time + 10000;
    }
    return false;
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 1, eflags: 0x4
// Checksum 0xee07f061, Offset: 0x20f8
// Size: 0x2e
function private function_32f614e2(objectivekey) {
    if (isdefined(objectivekey)) {
        if (objectivekey != "objective_all") {
            return "domPointDialogBuffer";
        }
    }
    return undefined;
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 3, eflags: 0x0
// Checksum 0x58a3822, Offset: 0x2130
// Size: 0x84
function function_ea620e62(dialog, players, objectivekey) {
    if (function_c6b70aba(dialog)) {
        return;
    }
    dialogbufferkey = function_32f614e2(objectivekey);
    globallogic_audio::function_61e17de0(game.dialog[dialog], players, objectivekey, undefined, dialogbufferkey);
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 1, eflags: 0x0
// Checksum 0x53c3a1a7, Offset: 0x21c0
// Size: 0x22
function function_66d7165e(user) {
    return getplayers(user);
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 1, eflags: 0x0
// Checksum 0x712b9e52, Offset: 0x21f0
// Size: 0x32
function function_67e581be(team) {
    user = team;
    return function_66d7165e(user);
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 1, eflags: 0x0
// Checksum 0xe256453f, Offset: 0x2230
// Size: 0x22
function function_1575fa8b(user) {
    return getenemyplayers(user);
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 1, eflags: 0x0
// Checksum 0xe2d7688b, Offset: 0x2260
// Size: 0x32
function function_843bafab(team) {
    user = team;
    return function_1575fa8b(user);
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 1, eflags: 0x0
// Checksum 0x7e0bafef, Offset: 0x22a0
// Size: 0x7e
function on_begin_use(sentient) {
    self.didstatusnotify = 0;
    if (!self gameobjects::function_abb86400()) {
        function_ea620e62("securing" + self.label, function_67e581be(sentient.team), "objective" + self.label);
        return;
    }
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 3, eflags: 0x0
// Checksum 0x80d61935, Offset: 0x2328
// Size: 0x5a
function on_end_use(*var_98fb2758, *player, success) {
    if (!success) {
        globallogic_audio::flush_objective_dialog("objective" + self.label);
    }
    self.var_d1c3006c = 1;
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 1, eflags: 0x4
// Checksum 0xf5e6b30f, Offset: 0x2390
// Size: 0xaa
function private function_5eef5cf4(var_77efb18) {
    foreach (key, user in self.users) {
        if (key == var_77efb18) {
            continue;
        }
        if (user.touching.players.size > 0) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 0, eflags: 0x0
// Checksum 0x13ded154, Offset: 0x2448
// Size: 0x160
function on_decay_complete() {
    user = self gameobjects::function_167d3a40();
    if (self gameobjects::get_num_touching(user) > 0 && !function_5eef5cf4(user)) {
        self.var_670f7a7f = 1;
        touchlist = arraycopy(self.users[user].touching.players);
        foreach (st in touchlist) {
            player_from_touchlist = gameobjects::function_73944efe(touchlist, st);
            if (!isdefined(player_from_touchlist)) {
                continue;
            }
            scoreevents::processscoreevent(#"hash_7edabe01ed05afa3", player_from_touchlist, undefined, undefined);
        }
    }
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 1, eflags: 0x0
// Checksum 0x7daca58f, Offset: 0x25b0
// Size: 0xbc
function on_touch_use(sentient) {
    if (isplayer(sentient)) {
        if ((isdefined(self.contested) ? self.contested : 0) && (isdefined(sentient.var_c8d27c06) ? sentient.var_c8d27c06 : 0) < gettime()) {
            sentient playsoundtoplayer(#"hash_78e92d9f21eef6d1", sentient);
            sentient.var_c8d27c06 = gettime() + 5000;
        }
        battlechatter::function_98898d14(sentient, self);
    }
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 3, eflags: 0x0
// Checksum 0xcc5066a4, Offset: 0x2678
// Size: 0x372
function on_use_update(var_98fb2758, progress, change) {
    if (change > 0) {
        self gameobjects::set_flags(var_98fb2758 == "allies" ? 1 : 2);
    }
    if (progress > 0.05 && change && !self.didstatusnotify) {
        if (!self gameobjects::function_abb86400()) {
            var_e6d916f3 = function_66d7165e(var_98fb2758);
            function_ea620e62("securing" + self.label, var_e6d916f3, "objective" + self.label);
        } else {
            var_53a985f3 = function_66d7165e(self gameobjects::function_167d3a40());
            var_e6d916f3 = function_66d7165e(var_98fb2758);
            function_ea620e62("losing" + self.label, var_53a985f3, "objective" + self.label);
            function_ea620e62("securing" + self.label, var_e6d916f3, "objective" + self.label);
            globallogic_audio::flush_objective_dialog("objective_all");
        }
        self.didstatusnotify = 1;
    }
    if (change > 0 && self.var_d1c3006c) {
        self.var_d1c3006c = 0;
        var_53a985f3 = function_66d7165e(self gameobjects::function_167d3a40());
        var_e6d916f3 = function_66d7165e(var_98fb2758);
        foreach (player in var_e6d916f3) {
            player playsoundtoplayer(#"hash_5739d2bc3554b3f9", player);
        }
        foreach (player in var_53a985f3) {
            player playsoundtoplayer(#"hash_3d00e79976c2e9da", player);
        }
        return;
    }
    if (change == 0 && !self.var_d1c3006c) {
        self.var_d1c3006c = 1;
    }
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 0, eflags: 0x0
// Checksum 0x76ea152e, Offset: 0x29f8
// Size: 0x252
function function_bcaf6836() {
    if (!isdefined(self.contested)) {
        self.contested = 0;
    }
    var_1694a3a1 = self gameobjects::get_num_touching(self.var_a4926509);
    previousstate = self.contested;
    if (var_1694a3a1 > 0 && self gameobjects::function_abb86400() && !self gameobjects::function_abe3458c()) {
        if (previousstate == 0) {
            foreach (user in self.users) {
                foreach (struct in user.touching.players) {
                    player = struct.player;
                    if (isdefined(player) && isplayer(player) && (isdefined(player.var_c8d27c06) ? player.var_c8d27c06 : 0) < gettime()) {
                        player playsoundtoplayer(#"hash_78e92d9f21eef6d1", player);
                        player.var_c8d27c06 = gettime() + 5000;
                    }
                }
            }
        }
        self.contested = 1;
        return;
    }
    if (previousstate == 1) {
        self notify(#"contest_over");
    }
    self.contested = 0;
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 0, eflags: 0x0
// Checksum 0xa7aa83ac, Offset: 0x2c58
// Size: 0x98
function function_ef42f0bd() {
    foreach (zone in level.domflags) {
        globallogic_audio::flush_objective_dialog(zone.data.dialog_key);
    }
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 1, eflags: 0x4
// Checksum 0x9aaaf09f, Offset: 0x2cf8
// Size: 0xb0
function private function_88134907(team) {
    score = 0;
    foreach (var_85344832 in level.domflags) {
        if (var_85344832 gameobjects::get_owner_team() == team) {
            score++;
        }
    }
    return score;
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 1, eflags: 0x0
// Checksum 0x8ec4967, Offset: 0x2db0
// Size: 0x4a
function function_48b377(team) {
    count = function_88134907(team);
    if (count == level.domflags.size) {
        return true;
    }
    return false;
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 0, eflags: 0x0
// Checksum 0xd3448c5f, Offset: 0x2e08
// Size: 0xce
function function_95470569() {
    players = [];
    foreach (team, _ in level.teams) {
        if (function_88134907(team) == 0) {
            players = arraycombine(players, getplayers(team));
        }
    }
    return players;
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 4, eflags: 0x0
// Checksum 0x526b3a6b, Offset: 0x2ee0
// Size: 0xdc
function function_7d0692bc(user, var_24672ed6, string, var_81b74b24) {
    if (is_true(getgametypesetting(#"contributioncapture"))) {
        self thread function_ef09febd(self.users[user].contributors, self.users[user].touching.players, string, var_24672ed6, var_81b74b24, 0);
        return;
    }
    thread give_capture_credit(self.users[user].touching.players, string, var_24672ed6, var_81b74b24, 1);
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 2, eflags: 0x0
// Checksum 0x36893e69, Offset: 0x2fc8
// Size: 0x1a4
function capture_flag(var_5e54cb59, var_24672ed6) {
    user = gameobjects::function_4e3386a8(var_5e54cb59);
    var_d89c1031 = var_5e54cb59;
    if (level.flagcanbeneutralized && !var_24672ed6) {
        level notify(#"flag_neutralized");
        string = self.data.var_1629d8a0;
        var_d89c1031 = #"neutral";
        thread give_neutralized_credit(self.users[user].touching.players, string, var_24672ed6);
    } else {
        level notify(#"flag_captured");
        function_7d0692bc(user, var_24672ed6, self.data.var_44e9bd00, is_true(self.var_ecee1402));
        if (!isdefined(self.var_249009fd)) {
            self.var_249009fd = [];
        } else if (!isarray(self.var_249009fd)) {
            self.var_249009fd = array(self.var_249009fd);
        }
        self.var_249009fd[self.var_249009fd.size] = gettime() - self.var_56d394cd;
    }
    self gameobjects::set_owner_team(var_d89c1031);
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 2, eflags: 0x0
// Checksum 0xf041fc11, Offset: 0x3178
// Size: 0x114
function function_bb3152b7(var_d89c1031, var_b4950c2b) {
    if (var_d89c1031 == #"neutral") {
        return;
    }
    var_50782ea4 = function_67e581be(var_d89c1031);
    if (var_b4950c2b) {
        function_ea620e62("secured_all", var_50782ea4, "objective_all");
        function_ef42f0bd();
    } else {
        function_ea620e62("secured" + self.label, var_50782ea4, self.data.dialog_key);
        globallogic_audio::flush_objective_dialog("objective_all");
    }
    thread util::function_f0b75565(var_50782ea4, "mpl_dom_captured_by_friendly");
    globallogic_audio::function_abf21f69("mpl_dom_captured_by_friendly", var_50782ea4);
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 3, eflags: 0x0
// Checksum 0x6f8b7447, Offset: 0x3298
// Size: 0x15e
function function_91cdcd1e(enemy_players, var_24672ed6, var_b4950c2b) {
    if (var_b4950c2b) {
        function_ea620e62("lost_all", enemy_players, "objective_all");
        function_ef42f0bd();
    } else {
        if (!var_24672ed6) {
            var_56fa1097 = randomint(2) ? "lost" + self.label : #"enemy" + self.label;
        } else {
            var_56fa1097 = #"enemy" + self.label;
        }
        function_ea620e62(var_56fa1097, enemy_players, self.data.dialog_key);
        globallogic_audio::flush_objective_dialog("objective_all");
    }
    thread util::function_f0b75565(enemy_players, "mpl_dom_captured_by_enemy");
    globallogic_audio::function_abf21f69("mpl_dom_captured_by_enemy", enemy_players);
    if (!var_24672ed6) {
        self.var_45438686 = 0;
    }
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 1, eflags: 0x0
// Checksum 0x498855a5, Offset: 0x3400
// Size: 0x244
function on_use(sentient) {
    var_5e54cb59 = sentient.team;
    assert(var_5e54cb59 != #"neutral");
    /#
        print("<dev string:x1aa>" + self.label);
    #/
    var_24672ed6 = !self gameobjects::function_abb86400();
    enemy_players = function_1575fa8b(var_5e54cb59);
    self capture_flag(var_5e54cb59, var_24672ed6);
    var_d89c1031 = self gameobjects::function_167d3a40();
    var_b4950c2b = function_48b377(var_5e54cb59);
    self function_bb3152b7(var_d89c1031, var_b4950c2b);
    self function_91cdcd1e(enemy_players, var_24672ed6, var_b4950c2b);
    self.var_56d394cd = gettime();
    spawning::function_7a87efaa();
    if (dominated_challenge_check()) {
        level thread function_1bcd5536(var_5e54cb59);
        util::function_a3f7de13(25, var_5e54cb59);
    } else if (!var_24672ed6) {
        util::function_a3f7de13(20, var_5e54cb59, -1, self.data.var_bd674032);
    }
    self update_spawn_influencers(self gameobjects::get_owner_team());
    bb::function_95a5b5c2("dom_capture", self gameobjects::get_label(), var_5e54cb59, sentient.origin);
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 1, eflags: 0x0
// Checksum 0x104db44, Offset: 0x3650
// Size: 0x13e
function update_caps_per_minute(var_24672ed6) {
    if (!isdefined(self.capsperminute)) {
        self.numcaps = 0;
        self.capsperminute = 0;
    }
    if (var_24672ed6) {
        return;
    }
    self.numcaps++;
    minutespassed = float(globallogic_utils::gettimepassed()) / 60000;
    if (isplayer(self) && isdefined(self.timeplayed[#"total"])) {
        minutespassed = self.timeplayed[#"total"] / 60;
    }
    if ((isdefined(minutespassed) ? minutespassed : 0) > 0) {
        self.capsperminute = self.numcaps / minutespassed;
    } else {
        self.capsperminute = self.numcaps;
    }
    if (self.capsperminute > self.numcaps) {
        self.capsperminute = self.numcaps;
    }
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 3, eflags: 0x0
// Checksum 0xcfc7c691, Offset: 0x3798
// Size: 0x248
function give_neutralized_credit(touchlist, string, var_24672ed6) {
    time = gettime();
    waitframe(1);
    util::waittillslowprocessallowed();
    foreach (touch in touchlist) {
        player_from_touchlist = gameobjects::function_73944efe(touchlist, touch);
        if (!isdefined(player_from_touchlist)) {
            continue;
        }
        player_from_touchlist update_caps_per_minute(var_24672ed6);
        if (!is_score_boosting(player_from_touchlist, self)) {
            scoreevents::processscoreevent(#"dom_point_neutralized_neutralizing", player_from_touchlist, undefined, undefined);
            player_from_touchlist recordgameevent("neutralized");
            if (isdefined(player_from_touchlist.pers[#"neutralizes"])) {
                player_from_touchlist.pers[#"neutralizes"]++;
                player_from_touchlist.captures = player_from_touchlist.pers[#"neutralizes"];
            }
            demo::bookmark(#"event", gettime(), player_from_touchlist);
            potm::bookmark(#"event", gettime(), player_from_touchlist);
        } else {
            /#
                player_from_touchlist iprintlnbold("<dev string:x1bd>");
            #/
        }
        level thread popups::displayteammessagetoall(string, player_from_touchlist);
    }
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 5, eflags: 0x0
// Checksum 0xd8cc2656, Offset: 0x39e8
// Size: 0x128
function give_capture_credit(touchlist, string, var_24672ed6, var_81b74b24, neutralizing) {
    time = gettime();
    waitframe(1);
    util::waittillslowprocessallowed();
    self update_caps_per_minute(var_24672ed6);
    foreach (touch in touchlist) {
        player_from_touchlist = gameobjects::function_73944efe(touchlist, touch);
        if (!isdefined(player_from_touchlist)) {
            continue;
        }
        credit_player(player_from_touchlist, string, var_24672ed6, var_81b74b24, neutralizing, time, 0, 1);
    }
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 8, eflags: 0x0
// Checksum 0xdd023051, Offset: 0x3b18
// Size: 0x484
function credit_player(player, string, var_24672ed6, var_81b74b24, neutralizing, time, var_a84f97bf, var_af8f6146) {
    player update_caps_per_minute(var_24672ed6);
    if (!is_score_boosting(player, self)) {
        player challenges::capturedobjective(time, self.trigger);
        battlechatter::function_924699f4(player, self);
        if (var_24672ed6 && neutralizing && is_true(self.hasbeencaptured)) {
            scoreevents::processscoreevent(#"dom_point_secured_neutralizing", player, level.weaponnone, undefined);
        } else if (var_24672ed6) {
            if (var_81b74b24) {
                scoreevents::processscoreevent(#"neutral_b_secured", player, level.weaponnone, undefined);
                player stats::function_dad108fa(#"hash_60545a50ce7c9791", 1);
            } else {
                scoreevents::processscoreevent(#"dom_point_neutral_secured", player, level.weaponnone, undefined);
            }
        } else {
            scoreevents::processscoreevent(#"dom_point_secured", player, level.weaponnone, undefined);
        }
        self.hasbeencaptured = 1;
        player recordgameevent("capture");
        if (var_81b74b24) {
            level notify(#"hash_3809ea07643ef10e", {#player:player});
        }
        if (isdefined(player.pers[#"captures"])) {
            player.pers[#"captures"]++;
            player.captures = player.pers[#"captures"];
        }
        player.pers[#"objectives"]++;
        player.objectives = player.pers[#"objectives"];
        demo::bookmark(#"event", gettime(), player);
        potm::bookmark(#"event", gettime(), player);
        player stats::function_bb7eedf0(#"captures", 1);
        player globallogic_score::incpersstat(#"objectivescore", 1, 0, 1);
        if (is_true(getgametypesetting(#"contributioncapture"))) {
            player luinotifyevent(#"waypoint_captured", 2, self.objectiveid, player.var_759a143b);
            player.var_759a143b = undefined;
        }
        if (var_af8f6146) {
            player stats::function_dad108fa(#"captures_in_capture_area", 1);
            player contracts::increment_contract(#"contract_mp_objective_capture");
        }
    } else {
        /#
            player iprintlnbold("<dev string:x1bd>");
        #/
    }
    if (var_a84f97bf) {
        level thread popups::displayteammessagetoall(string, player);
    }
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 0, eflags: 0x0
// Checksum 0xc0f5e109, Offset: 0x3fa8
// Size: 0xc4
function dominated_challenge_check() {
    var_e9954a42 = undefined;
    foreach (var_85344832 in level.domflags) {
        var_62d0eda0 = var_85344832 gameobjects::function_167d3a40();
        if (!isdefined(var_e9954a42)) {
            var_e9954a42 = var_62d0eda0;
        }
        if (var_62d0eda0 != var_e9954a42) {
            return false;
        }
    }
    return true;
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 1, eflags: 0x0
// Checksum 0x8dd17b6f, Offset: 0x4078
// Size: 0x4c
function function_1bcd5536(team) {
    level endon(#"flag_captured", #"game_ended");
    wait 180;
    challenges::totaldomination(team);
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 6, eflags: 0x0
// Checksum 0xbaa942b1, Offset: 0x40d0
// Size: 0x39c
function function_ef09febd(var_1dbb2b2b, var_6d7ae157, string, var_24672ed6, var_81b74b24, neutralizing) {
    time = gettime();
    waitframe(1);
    util::waittillslowprocessallowed();
    self update_caps_per_minute(var_24672ed6);
    var_b4613aa2 = [];
    earliestplayer = undefined;
    foreach (contribution in var_1dbb2b2b) {
        if (isdefined(contribution)) {
            contributor = contribution.player;
            if (isdefined(contributor) && isdefined(contribution.contribution)) {
                percentage = 100 * contribution.contribution / self.usetime;
                contributor.var_759a143b = int(0.5 + percentage);
                contributor.var_1aea8209 = contribution.starttime;
                if (percentage < getgametypesetting(#"contributionmin")) {
                    continue;
                }
                if (contribution.var_e22ea52b && (!isdefined(earliestplayer) || contributor.var_1aea8209 < earliestplayer.var_1aea8209)) {
                    earliestplayer = contributor;
                }
                if (!isdefined(var_b4613aa2)) {
                    var_b4613aa2 = [];
                } else if (!isarray(var_b4613aa2)) {
                    var_b4613aa2 = array(var_b4613aa2);
                }
                var_b4613aa2[var_b4613aa2.size] = contributor;
            }
        }
    }
    foreach (player in var_b4613aa2) {
        var_a84f97bf = earliestplayer === player;
        var_af8f6146 = 0;
        foreach (touch in var_6d7ae157) {
            if (!isdefined(touch)) {
                continue;
            }
            if (touch.player === player) {
                var_af8f6146 = 1;
                break;
            }
        }
        credit_player(player, string, var_24672ed6, var_81b74b24, neutralizing, time, var_a84f97bf, var_af8f6146);
    }
    self gameobjects::function_bd47b0c7();
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 0, eflags: 0x0
// Checksum 0xcd31798a, Offset: 0x4478
// Size: 0x148
function function_a059441e() {
    if (function_5995018a() > 0) {
        return;
    }
    round_score_limit = util::get_current_round_score_limit();
    var_91766e40 = 0;
    var_c9949377 = level.teams;
    var_f7ad20df = &teams::function_7f8faff9;
    var_bc3edf78 = &function_88134907;
    foreach (scorer, _ in var_c9949377) {
        if ([[ var_f7ad20df ]](scorer) == round_score_limit - 1 && [[ var_bc3edf78 ]](scorer) > 0) {
            var_91766e40++;
        }
    }
    if (var_91766e40 > 1) {
        level.clampscorelimit = 0;
    }
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 3, eflags: 0x0
// Checksum 0x58bbaeed, Offset: 0x45c8
// Size: 0xf4
function function_ce1f2f60(var_77d0878c, var_6d179b9d, is_draw) {
    if (util::islastround() || util::isoneround()) {
        nearwinning = "nearWinningFinal";
        nearlosing = "nearLosingFinal";
    } else {
        nearwinning = "nearWinning";
        nearlosing = "nearLosing";
    }
    if (is_draw) {
        neardrawing = "nearDrawing";
        globallogic_audio::function_61e17de0(neardrawing, var_77d0878c);
    } else {
        globallogic_audio::function_61e17de0(nearwinning, var_77d0878c);
    }
    globallogic_audio::function_61e17de0(nearlosing, var_6d179b9d);
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 1, eflags: 0x0
// Checksum 0x1577c2d9, Offset: 0x46c8
// Size: 0x2a0
function function_c2b3568d(var_a7c860e6) {
    top_score = 0;
    var_c9949377 = level.teams;
    var_f7ad20df = &teams::function_7f8faff9;
    var_6e5994f6 = &getplayers;
    var_b47a98a8 = [];
    is_draw = 0;
    foreach (scorer, _ in var_c9949377) {
        score = [[ var_f7ad20df ]](scorer) - level.var_af6ca8c2[scorer];
        var_b47a98a8[scorer] = score;
        if (score > top_score) {
            top_score = score;
            var_37bafbf8 = scorer;
        }
    }
    if (top_score < var_a7c860e6) {
        return false;
    }
    if (isdefined(var_37bafbf8)) {
        var_77d0878c = [];
        var_6d179b9d = [];
        var_77d0878c = [[ var_6e5994f6 ]](var_37bafbf8);
        foreach (loser, _ in var_c9949377) {
            if (var_37bafbf8 == loser) {
                continue;
            }
            if (top_score - var_b47a98a8[loser] < 2) {
                is_draw = 1;
                var_77d0878c = arraycombine(var_77d0878c, [[ var_6e5994f6 ]](loser));
                continue;
            }
            var_6d179b9d = arraycombine(var_6d179b9d, [[ var_6e5994f6 ]](loser));
        }
        function_ce1f2f60(var_77d0878c, var_6d179b9d, is_draw);
        level notify(#"hash_15b8b6edc4ed3032", {#var_7090bf53:0});
        return true;
    }
    return false;
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 0, eflags: 0x0
// Checksum 0x32a6abc6, Offset: 0x4970
// Size: 0x114
function function_3201d5d3() {
    numownedflags = 0;
    var_2fc17e92 = level.teams;
    var_f7ad20df = &globallogic_score::giveteamscoreforobjective_delaypostprocessing;
    var_bc3edf78 = &function_88134907;
    foreach (user, _ in var_2fc17e92) {
        numflags = [[ var_bc3edf78 ]](user);
        numownedflags += numflags;
        if (numflags) {
            [[ var_f7ad20df ]](user, numflags);
        }
    }
    if (numownedflags) {
        globallogic_score::postprocessteamscores();
    }
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 0, eflags: 0x0
// Checksum 0xe3b4581c, Offset: 0x4a90
// Size: 0x22
function function_5995018a() {
    return function_88134907(#"neutral");
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 0, eflags: 0x0
// Checksum 0x111a4d85, Offset: 0x4ac0
// Size: 0x1cc
function function_1932f845() {
    if (level.domflags.size == 0) {
        return false;
    }
    var_bac44d7f = level.teamscoreperkill ? 0 : 1;
    /#
        if (getdvarint(#"hash_697b325da5b79b83", 0) > 0) {
            var_bac44d7f = 0;
        }
    #/
    if (!var_bac44d7f) {
        return false;
    }
    var_da0f2c7b = function_5995018a();
    if (var_da0f2c7b == 0) {
        return false;
    }
    var_16dc5e49 = math::clamp(level.domflags.size - var_da0f2c7b, 2, level.domflags.size);
    var_cce15e08 = var_16dc5e49 * 90 + var_16dc5e49 * float(level.domflags[0].usetime) / 1000;
    timepassed = float(globallogic_utils::gettimepassed()) / 1000;
    if (timepassed > var_cce15e08 && gamemodeismode(0)) {
        round::set_flag("tie");
        thread globallogic::end_round(0);
        return true;
    }
    return false;
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 0, eflags: 0x0
// Checksum 0x527b3661, Offset: 0x4c98
// Size: 0xa0
function function_8ad6d42f() {
    level.var_af6ca8c2 = [];
    foreach (team, _ in level.teams) {
        level.var_af6ca8c2[team] = [[ level._getteamscore ]](team);
    }
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 0, eflags: 0x0
// Checksum 0x18db1424, Offset: 0x4d40
// Size: 0x110
function function_7bc4ede8() {
    if (level.roundscorelimit && !level.timelimit) {
        warningscore = max(0, level.roundscorelimit - 12);
    } else {
        warningscore = 0;
    }
    playednearendvo = 0;
    function_8ad6d42f();
    while (!level.gameended) {
        function_a059441e();
        function_3201d5d3();
        if (function_1932f845()) {
            return;
        }
        if (warningscore && !playednearendvo) {
            playednearendvo = function_c2b3568d(warningscore);
        }
        wait 5;
        hostmigration::waittillhostmigrationdone();
    }
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 0, eflags: 0x0
// Checksum 0x97a65d78, Offset: 0x4e58
// Size: 0xcc
function update_settings() {
    level.playercapturelpm = getgametypesetting(#"maxplayereventsperminute");
    level.flagcapturelpm = getgametypesetting(#"maxobjectiveeventsperminute");
    level.playeroffensivemax = getgametypesetting(#"maxplayeroffensive");
    level.playerdefensivemax = getgametypesetting(#"maxplayerdefensive");
    level.flagcanbeneutralized = getgametypesetting(#"flagcanbeneutralized");
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 0, eflags: 0x0
// Checksum 0xa7d618ff, Offset: 0x4f30
// Size: 0x84
function onstartgametype() {
    level.b_allow_vehicle_proximity_pickup = 1;
    update_settings();
    function_de560341();
    if (!getgametypesetting(#"hash_4e8cafe9a4470898")) {
        setup_zones();
        return;
    }
    function_fdbc620d();
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 0, eflags: 0x0
// Checksum 0xec8d57c7, Offset: 0x4fc0
// Size: 0x784
function function_de560341() {
    spawning::function_c40af6fa();
    spawning::addsupportedspawnpointtype("dom");
    spawning::function_32b97d1b(&spawning::function_90dee50d);
    spawning::function_adbbb58a(&spawning::function_c24e290c);
    spawning::addspawns();
    var_273a84a9 = [];
    if (!isdefined(var_273a84a9)) {
        var_273a84a9 = [];
    } else if (!isarray(var_273a84a9)) {
        var_273a84a9 = array(var_273a84a9);
    }
    var_273a84a9[var_273a84a9.size] = "dom_flag_a";
    if (!isdefined(var_273a84a9)) {
        var_273a84a9 = [];
    } else if (!isarray(var_273a84a9)) {
        var_273a84a9 = array(var_273a84a9);
    }
    var_273a84a9[var_273a84a9.size] = "dom_flag_b";
    if (!isdefined(var_273a84a9)) {
        var_273a84a9 = [];
    } else if (!isarray(var_273a84a9)) {
        var_273a84a9 = array(var_273a84a9);
    }
    var_273a84a9[var_273a84a9.size] = "dom_flag_c";
    if (!isdefined(var_273a84a9)) {
        var_273a84a9 = [];
    } else if (!isarray(var_273a84a9)) {
        var_273a84a9 = array(var_273a84a9);
    }
    var_273a84a9[var_273a84a9.size] = "dom_flag_d";
    if (!isdefined(var_273a84a9)) {
        var_273a84a9 = [];
    } else if (!isarray(var_273a84a9)) {
        var_273a84a9 = array(var_273a84a9);
    }
    var_273a84a9[var_273a84a9.size] = "dom_flag_e";
    if (!isdefined(var_273a84a9)) {
        var_273a84a9 = [];
    } else if (!isarray(var_273a84a9)) {
        var_273a84a9 = array(var_273a84a9);
    }
    var_273a84a9[var_273a84a9.size] = "dom_flag_f";
    flagspawns = spawning::function_d400d613(#"mp_spawn_point", var_273a84a9);
    foreach (var_de435199 in flagspawns) {
        foreach (spawn in var_de435199) {
            if (!isdefined(spawn.enabled)) {
                spawn.enabled = -1;
            }
        }
    }
    if (isdefined(flagspawns)) {
        if (isdefined(flagspawns[#"dom_flag_a"])) {
            addspawnpoints(#"allies", flagspawns[#"dom_flag_a"], "spl1");
            addspawnpoints(#"axis", flagspawns[#"dom_flag_a"], "spl1");
        }
        if (isdefined(flagspawns[#"dom_flag_b"])) {
            addspawnpoints(#"allies", flagspawns[#"dom_flag_b"], "spl2");
            addspawnpoints(#"axis", flagspawns[#"dom_flag_b"], "spl2");
        }
        if (isdefined(flagspawns[#"dom_flag_c"])) {
            addspawnpoints(#"allies", flagspawns[#"dom_flag_c"], "spl3");
            addspawnpoints(#"axis", flagspawns[#"dom_flag_c"], "spl3");
        }
        if (isdefined(flagspawns[#"dom_flag_d"])) {
            addspawnpoints(#"allies", flagspawns[#"dom_flag_d"], "spl4");
            addspawnpoints(#"axis", flagspawns[#"dom_flag_d"], "spl4");
        }
        if (isdefined(flagspawns[#"dom_flag_e"])) {
            addspawnpoints(#"allies", flagspawns[#"dom_flag_e"], "spl5");
            addspawnpoints(#"axis", flagspawns[#"dom_flag_e"], "spl5");
        }
        if (isdefined(flagspawns[#"dom_flag_f"])) {
            addspawnpoints(#"allies", flagspawns[#"dom_flag_f"], "spl6");
            addspawnpoints(#"axis", flagspawns[#"dom_flag_f"], "spl6");
        }
    }
    spawning::add_default_spawnlist("spl1");
    spawning::add_default_spawnlist("spl2");
    spawning::add_default_spawnlist("spl3");
    spawning::add_default_spawnlist("spl4");
    spawning::add_default_spawnlist("spl5");
    spawning::add_default_spawnlist("spl6");
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 0, eflags: 0x0
// Checksum 0x46d181fb, Offset: 0x5750
// Size: 0xcc
function setup_zones() {
    level.domflags = function_16ee17b2(&function_4480f87e);
    foreach (var_85344832 in level.domflags) {
        var_85344832 createflagspawninfluencers();
    }
    level.var_db1e5a88 = function_669e3110();
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 0, eflags: 0x0
// Checksum 0xa18c3198, Offset: 0x5828
// Size: 0x4c
function on_game_playing() {
    if (getgametypesetting(#"hash_4e8cafe9a4470898")) {
        setup_zones();
    }
    thread function_7bc4ede8();
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 0, eflags: 0x0
// Checksum 0x77d9302f, Offset: 0x5880
// Size: 0x34
function on_round_switch() {
    gametype::on_round_switch();
    if (level.scoreroundwinbased) {
        globallogic_score::function_9779ac61();
    }
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 2, eflags: 0x0
// Checksum 0x8cf431eb, Offset: 0x58c0
// Size: 0x5e
function is_score_boosting(player, flag) {
    if (!level.rankedmatch) {
        return false;
    }
    if (player.capsperminute > level.playercapturelpm) {
        return true;
    }
    if (flag.capsperminute > level.flagcapturelpm) {
        return true;
    }
    return false;
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 0, eflags: 0x0
// Checksum 0xdcf6c780, Offset: 0x5928
// Size: 0x70
function onscoreclosemusic() {
    if (!isdefined(level.sndhalfway)) {
        level.sndhalfway = 0;
    }
    if (!level.sndhalfway && function_5d57c045()) {
        level notify(#"sndmusichalfway");
        level.sndhalfway = 1;
    }
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 0, eflags: 0x0
// Checksum 0x2d3ce71e, Offset: 0x59a0
// Size: 0x8a
function function_5d57c045() {
    halfwayscore = level.scorelimit * 0.5;
    if (isdefined(level.roundscorelimit)) {
        halfwayscore = level.roundscorelimit * 0.5;
        if (game.roundsplayed == 1) {
            halfwayscore += level.roundscorelimit;
        }
    }
    return teams::function_712e3ba6(halfwayscore);
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 0, eflags: 0x0
// Checksum 0xb63f75ec, Offset: 0x5a38
// Size: 0x1f4
function createflagspawninfluencers() {
    ss = level.spawnsystem;
    self.owned_flag_influencer = self influencers::create_influencer("dom_friendly", self.trigger.origin, 0);
    self.neutral_flag_influencer = self influencers::create_influencer("dom_neutral", self.trigger.origin, 0);
    self.enemy_flag_influencer = self influencers::create_influencer("dom_enemy", self.trigger.origin, 0);
    var_4b91b8a4 = self function_58306805();
    if (isdefined(var_4b91b8a4)) {
        self.var_7f85bfce = self influencers::create_influencer("dom_flag_spawn_friendly", self.trigger.origin, 0);
        function_8b51d4df(self.var_7f85bfce, var_4b91b8a4);
        self.var_b56facb1 = self influencers::create_influencer("dom_flag_spawn_enemy", self.trigger.origin, 0);
        function_8b51d4df(self.var_b56facb1, var_4b91b8a4);
        self.var_b0f6f826 = self influencers::create_influencer("dom_flag_spawn_neutral", self.trigger.origin, 0);
        function_8b51d4df(self.var_b0f6f826, var_4b91b8a4);
    }
    self update_spawn_influencers(#"neutral");
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 1, eflags: 0x0
// Checksum 0xb669061b, Offset: 0x5c38
// Size: 0x2cc
function update_spawn_influencers(team) {
    assert(isdefined(self.neutral_flag_influencer));
    assert(isdefined(self.owned_flag_influencer));
    assert(isdefined(self.enemy_flag_influencer));
    if (team == #"neutral") {
        enableinfluencer(self.neutral_flag_influencer, 1);
        enableinfluencer(self.owned_flag_influencer, 0);
        enableinfluencer(self.enemy_flag_influencer, 0);
        if (isdefined(self function_58306805())) {
            enableinfluencer(self.var_b0f6f826, 1);
            enableinfluencer(self.var_7f85bfce, 0);
            enableinfluencer(self.var_b56facb1, 0);
        }
        return;
    }
    enableinfluencer(self.neutral_flag_influencer, 0);
    enableinfluencer(self.owned_flag_influencer, 1);
    enableinfluencer(self.enemy_flag_influencer, 1);
    if (isdefined(self function_58306805())) {
        enableinfluencer(self.var_b0f6f826, 0);
        enableinfluencer(self.var_7f85bfce, 1);
        enableinfluencer(self.var_b56facb1, 1);
        setinfluencerteammask(self.var_7f85bfce, util::getteammask(team));
        setinfluencerteammask(self.var_b56facb1, util::getotherteamsmask(team));
    }
    setinfluencerteammask(self.owned_flag_influencer, util::getteammask(team));
    setinfluencerteammask(self.enemy_flag_influencer, util::getotherteamsmask(team));
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 0, eflags: 0x0
// Checksum 0xd25f4442, Offset: 0x5f10
// Size: 0x12
function function_58306805() {
    return self.data.spawnlist;
}

// Namespace namespace_5c32f369/namespace_5c32f369
// Params 1, eflags: 0x0
// Checksum 0x43bba164, Offset: 0x5f30
// Size: 0x1c2
function function_5ca9806b(var_e9670377) {
    if (self.sessionstate === "playing") {
        return;
    }
    foreach (index, var_85344832 in level.domflags) {
        if (is_true(var_85344832.var_c851244c) && var_85344832.objectiveid == var_e9670377) {
            if (self.team == var_85344832 gameobjects::get_owner_team()) {
                self namespace_99c84a33::function_99c84a33(var_85344832.objectiveid);
            }
            return;
        }
    }
    foreach (headquarter in level.var_db1e5a88) {
        if (is_true(headquarter.var_c851244c) && headquarter.objectiveid == var_e9670377) {
            if (self.team == headquarter.script_team) {
                self namespace_99c84a33::function_99c84a33(headquarter.objectiveid);
            }
            return;
        }
    }
}

