#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\util_shared;

#namespace util;

// Namespace util/util
// Params 4, eflags: 0x1 linked
// Checksum 0xbb697899, Offset: 0x190
// Size: 0x8c
function within_fov(start_origin, start_angles, end_origin, fov) {
    normal = vectornormalize(end_origin - start_origin);
    forward = anglestoforward(start_angles);
    dot = vectordot(forward, normal);
    return dot >= fov;
}

// Namespace util/util
// Params 0, eflags: 0x0
// Checksum 0x55e8d2d5, Offset: 0x228
// Size: 0xa
function get_player_height() {
    return 70;
}

// Namespace util/util
// Params 1, eflags: 0x0
// Checksum 0xb1afd519, Offset: 0x240
// Size: 0x3e
function isbulletimpactmod(smeansofdeath) {
    return issubstr(smeansofdeath, "BULLET") || smeansofdeath == "MOD_HEAD_SHOT";
}

// Namespace util/util
// Params 0, eflags: 0x0
// Checksum 0xbe7863f1, Offset: 0x288
// Size: 0x4e
function waitrespawnbutton() {
    self endon(#"disconnect", #"end_respawn");
    while (self usebuttonpressed() != 1) {
        waitframe(1);
    }
}

// Namespace util/util
// Params 2, eflags: 0x0
// Checksum 0x845ee4a3, Offset: 0x2e0
// Size: 0xd4
function printonteam(text, team) {
    assert(isdefined(level.players));
    for (i = 0; i < level.players.size; i++) {
        player = level.players[i];
        if (isdefined(player.pers[#"team"]) && player.pers[#"team"] == team) {
            player iprintln(text);
        }
    }
}

// Namespace util/util
// Params 2, eflags: 0x0
// Checksum 0xfb408a14, Offset: 0x3c0
// Size: 0xd4
function printboldonteam(text, team) {
    assert(isdefined(level.players));
    for (i = 0; i < level.players.size; i++) {
        player = level.players[i];
        if (isdefined(player.pers[#"team"]) && player.pers[#"team"] == team) {
            player iprintlnbold(text);
        }
    }
}

// Namespace util/util
// Params 3, eflags: 0x0
// Checksum 0x576c872c, Offset: 0x4a0
// Size: 0xdc
function printboldonteamarg(text, team, arg) {
    assert(isdefined(level.players));
    for (i = 0; i < level.players.size; i++) {
        player = level.players[i];
        if (isdefined(player.pers[#"team"]) && player.pers[#"team"] == team) {
            player iprintlnbold(text, arg);
        }
    }
}

// Namespace util/util
// Params 3, eflags: 0x0
// Checksum 0xcee74a50, Offset: 0x588
// Size: 0x1c
function printonteamarg(*text, *team, *arg) {
    
}

// Namespace util/util
// Params 2, eflags: 0x0
// Checksum 0xaf21d9ea, Offset: 0x5b0
// Size: 0xd4
function printonplayers(text, team) {
    players = level.players;
    for (i = 0; i < players.size; i++) {
        if (isdefined(team)) {
            if (isdefined(players[i].pers[#"team"]) && players[i].pers[#"team"] == team) {
                players[i] iprintln(text);
            }
            continue;
        }
        players[i] iprintln(text);
    }
}

// Namespace util/util
// Params 2, eflags: 0x0
// Checksum 0x8cf9cdb5, Offset: 0x690
// Size: 0x120
function function_f0b75565(players, sound) {
    assert(isdefined(sound));
    if (level.splitscreen) {
        assert(level.splitscreen);
        assert(isdefined(players[0]));
        players[0] playlocalsound(sound);
        return;
    }
    foreach (player in players) {
        player playlocalsound(sound);
    }
}

// Namespace util/util
// Params 7, eflags: 0x0
// Checksum 0x67dccab, Offset: 0x7b8
// Size: 0x4bc
function printandsoundoneveryone(team, enemyteam, printfriendly, printenemy, soundfriendly, soundenemy, printarg) {
    shoulddosounds = isdefined(soundfriendly);
    shoulddoenemysounds = 0;
    if (isdefined(soundenemy)) {
        assert(shoulddosounds);
        shoulddoenemysounds = 1;
    }
    if (!isdefined(printarg)) {
        printarg = "";
    }
    if (level.splitscreen || !shoulddosounds) {
        for (i = 0; i < level.players.size; i++) {
            player = level.players[i];
            playerteam = player.pers[#"team"];
            if (isdefined(playerteam)) {
                if (playerteam == team && isdefined(printfriendly) && printfriendly != #"") {
                    player iprintln(printfriendly, printarg);
                    continue;
                }
                if (isdefined(printenemy) && printenemy != #"") {
                    if (isdefined(enemyteam) && playerteam == enemyteam) {
                        player iprintln(printenemy, printarg);
                        continue;
                    }
                    if (!isdefined(enemyteam) && playerteam != team) {
                        player iprintln(printenemy, printarg);
                    }
                }
            }
        }
        if (shoulddosounds) {
            assert(level.splitscreen);
            level.players[0] playlocalsound(soundfriendly);
        }
        return;
    }
    assert(shoulddosounds);
    if (shoulddoenemysounds) {
        for (i = 0; i < level.players.size; i++) {
            player = level.players[i];
            playerteam = player.pers[#"team"];
            if (isdefined(playerteam)) {
                if (playerteam == team) {
                    if (isdefined(printfriendly) && printfriendly != #"") {
                        player iprintln(printfriendly, printarg);
                    }
                    player playlocalsound(soundfriendly);
                    continue;
                }
                if (isdefined(enemyteam) && playerteam == enemyteam || !isdefined(enemyteam) && playerteam != team) {
                    if (isdefined(printenemy) && printenemy != #"") {
                        player iprintln(printenemy, printarg);
                    }
                    player playlocalsound(soundenemy);
                }
            }
        }
        return;
    }
    for (i = 0; i < level.players.size; i++) {
        player = level.players[i];
        playerteam = player.pers[#"team"];
        if (isdefined(playerteam)) {
            if (playerteam == team) {
                if (isdefined(printfriendly) && printfriendly != #"") {
                    player iprintln(printfriendly, printarg);
                }
                player playlocalsound(soundfriendly);
                continue;
            }
            if (isdefined(printenemy) && printenemy != #"") {
                if (isdefined(enemyteam) && playerteam == enemyteam) {
                    player iprintln(printenemy, printarg);
                    continue;
                }
                if (!isdefined(enemyteam) && playerteam != team) {
                    player iprintln(printenemy, printarg);
                }
            }
        }
    }
}

// Namespace util/util
// Params 1, eflags: 0x0
// Checksum 0x295383d, Offset: 0xc80
// Size: 0x4c
function _playlocalsound(soundalias) {
    if (level.splitscreen && !self ishost()) {
        return;
    }
    self playlocalsound(soundalias);
}

// Namespace util/util
// Params 1, eflags: 0x1 linked
// Checksum 0x71e593f2, Offset: 0xcd8
// Size: 0x8c
function getotherteam(team) {
    if (team == #"allies") {
        return #"axis";
    } else if (team == #"axis") {
        return #"allies";
    } else {
        return #"allies";
    }
    assertmsg("<dev string:x38>" + team);
}

// Namespace util/util
// Params 1, eflags: 0x0
// Checksum 0xb1b38ccf, Offset: 0xd70
// Size: 0x6c
function getteamenum(team) {
    if (team == #"allies") {
        return 1;
    } else if (team == #"axis") {
        return 2;
    }
    assertmsg("<dev string:x57>" + team);
}

// Namespace util/util
// Params 1, eflags: 0x1 linked
// Checksum 0x9575b6dd, Offset: 0xde8
// Size: 0x74
function getteammask(team) {
    if (!level.teambased || !isdefined(team) || !isdefined(level.spawnsystem.ispawn_teammask[team])) {
        return level.spawnsystem.var_c2989de;
    }
    return level.spawnsystem.ispawn_teammask[team];
}

// Namespace util/util
// Params 1, eflags: 0x0
// Checksum 0xd71e86ad, Offset: 0xe68
// Size: 0xb8
function getotherteamsmask(skip_team) {
    mask = 0;
    foreach (team, _ in level.teams) {
        if (team == skip_team) {
            continue;
        }
        mask |= getteammask(team);
    }
    return mask;
}

// Namespace util/util
// Params 5, eflags: 0x0
// Checksum 0xbe215de0, Offset: 0xf28
// Size: 0x76
function wait_endon(waittime, endonstring, endonstring2, endonstring3, endonstring4) {
    self endon(endonstring);
    if (isdefined(endonstring2)) {
        self endon(endonstring2);
    }
    if (isdefined(endonstring3)) {
        self endon(endonstring3);
    }
    if (isdefined(endonstring4)) {
        self endon(endonstring4);
    }
    wait waittime;
    return true;
}

// Namespace util/util
// Params 1, eflags: 0x0
// Checksum 0xfc8977ee, Offset: 0xfa8
// Size: 0x5c
function getfx(fx) {
    assert(isdefined(level._effect[fx]), "<dev string:x75>" + fx + "<dev string:x7c>");
    return level._effect[fx];
}

// Namespace util/util
// Params 1, eflags: 0x1 linked
// Checksum 0xe0eefc9, Offset: 0x1010
// Size: 0x44
function add_trigger_to_ent(ent) {
    if (!isdefined(ent._triggers)) {
        ent._triggers = [];
    }
    ent._triggers[self getentitynumber()] = 1;
}

// Namespace util/util
// Params 1, eflags: 0x1 linked
// Checksum 0xdc9fae57, Offset: 0x1060
// Size: 0x6c
function remove_trigger_from_ent(ent) {
    if (!isdefined(ent)) {
        return;
    }
    if (!isdefined(ent._triggers)) {
        return;
    }
    if (!isdefined(ent._triggers[self getentitynumber()])) {
        return;
    }
    ent._triggers[self getentitynumber()] = 0;
}

// Namespace util/util
// Params 1, eflags: 0x1 linked
// Checksum 0x4808d11b, Offset: 0x10d8
// Size: 0x70
function ent_already_in_trigger(trig) {
    if (!isdefined(self._triggers)) {
        return false;
    }
    if (!isdefined(self._triggers[trig getentitynumber()])) {
        return false;
    }
    if (!self._triggers[trig getentitynumber()]) {
        return false;
    }
    return true;
}

// Namespace util/util
// Params 2, eflags: 0x1 linked
// Checksum 0x42785fce, Offset: 0x1150
// Size: 0x4c
function trigger_thread_death_monitor(ent, ender) {
    ent waittill(#"death");
    self endon(ender);
    self remove_trigger_from_ent(ent);
}

// Namespace util/util
// Params 3, eflags: 0x0
// Checksum 0xc60c5eb5, Offset: 0x11a8
// Size: 0x184
function trigger_thread(ent, on_enter_payload, on_exit_payload) {
    ent endon(#"death");
    if (ent ent_already_in_trigger(self)) {
        return;
    }
    self add_trigger_to_ent(ent);
    ender = "end_trig_death_monitor" + self getentitynumber() + " " + ent getentitynumber();
    self thread trigger_thread_death_monitor(ent, ender);
    endon_condition = "leave_trigger_" + self getentitynumber();
    if (isdefined(on_enter_payload)) {
        self thread [[ on_enter_payload ]](ent, endon_condition);
    }
    while (isdefined(ent) && ent istouching(self)) {
        wait 0.01;
    }
    ent notify(endon_condition);
    if (isdefined(ent) && isdefined(on_exit_payload)) {
        self thread [[ on_exit_payload ]](ent);
    }
    if (isdefined(ent)) {
        self remove_trigger_from_ent(ent);
    }
    self notify(ender);
}

// Namespace util/util
// Params 2, eflags: 0x0
// Checksum 0xe72af730, Offset: 0x1338
// Size: 0x38
function isstrstart(string1, substr) {
    return getsubstr(string1, 0, substr.size) == substr;
}

// Namespace util/util
// Params 0, eflags: 0x0
// Checksum 0x284aa65f, Offset: 0x1378
// Size: 0x20
function iskillstreaksenabled() {
    return isdefined(level.killstreaksenabled) && level.killstreaksenabled;
}

// Namespace util/util
// Params 3, eflags: 0x5 linked
// Checksum 0x33365c17, Offset: 0x13a0
// Size: 0xa4
function private function_78e3e07b(team, index, objective_strings) {
    setobjectivetext(team, objective_strings.text);
    if (level.splitscreen) {
        setobjectivescoretext(team, objective_strings.var_27a7a289);
    } else {
        setobjectivescoretext(team, objective_strings.var_4687634f);
    }
    function_db4846b(team, index);
}

// Namespace util/util
// Params 1, eflags: 0x1 linked
// Checksum 0x314e76db, Offset: 0x1450
// Size: 0x24a
function function_e17a230f(team) {
    if (!isdefined(level.var_d1455682)) {
        return;
    }
    objective_strings = level.var_d1455682.var_e64a4485;
    if (!isdefined(objective_strings)) {
        setobjectivetext(team, "");
        return;
    }
    foreach (index, var_53c9b682 in objective_strings) {
        if (is_true(var_53c9b682.attacker) && team != game.attackers) {
            continue;
        }
        if (is_true(var_53c9b682.defender) && team != game.defenders) {
            continue;
        }
        if (is_true(var_53c9b682.overtime)) {
            if (!game.overtime_round) {
                continue;
            }
            if (is_true(var_53c9b682.overtime_round) && var_53c9b682.overtime_round != game.overtime_round) {
                continue;
            }
            if (is_true(var_53c9b682.var_47177317) && isdefined(game.overtime_first_winner) && team != game.overtime_first_winner) {
                continue;
            }
            if (is_true(var_53c9b682.var_76fa703c) && isdefined(game.overtime_first_winner) && team == game.overtime_first_winner) {
                continue;
            }
        }
        function_78e3e07b(team, index, var_53c9b682);
        return;
    }
}

// Namespace util/util
// Params 0, eflags: 0x1 linked
// Checksum 0x14036e05, Offset: 0x16a8
// Size: 0x98
function function_9540d9b6() {
    if (!isdefined(level.var_d1455682)) {
        return;
    }
    foreach (team, _ in level.teams) {
        function_e17a230f(team);
    }
}

// Namespace util/util
// Params 2, eflags: 0x1 linked
// Checksum 0xbeb27da8, Offset: 0x1748
// Size: 0x38
function setobjectivetext(team, text) {
    game.strings["objective_" + level.teams[team]] = text;
}

// Namespace util/util
// Params 2, eflags: 0x1 linked
// Checksum 0xe3e460ad, Offset: 0x1788
// Size: 0x38
function setobjectivescoretext(team, text) {
    game.strings["objective_score_" + level.teams[team]] = text;
}

// Namespace util/util
// Params 2, eflags: 0x1 linked
// Checksum 0xcd34d2a0, Offset: 0x17c8
// Size: 0x38
function function_db4846b(team, text) {
    game.strings["objective_first_spawn_hint_" + level.teams[team]] = text;
}

// Namespace util/util
// Params 1, eflags: 0x1 linked
// Checksum 0x52ada39e, Offset: 0x1808
// Size: 0x2c
function getobjectivetext(team) {
    return game.strings["objective_" + level.teams[team]];
}

// Namespace util/util
// Params 1, eflags: 0x1 linked
// Checksum 0x6efe9a78, Offset: 0x1840
// Size: 0x2c
function getobjectivescoretext(team) {
    return game.strings["objective_score_" + level.teams[team]];
}

// Namespace util/util
// Params 1, eflags: 0x1 linked
// Checksum 0x6393f1c4, Offset: 0x1878
// Size: 0x2c
function function_4a118b30(team) {
    return game.strings["objective_first_spawn_hint_" + level.teams[team]];
}

// Namespace util/util
// Params 2, eflags: 0x1 linked
// Checksum 0xa2d95a5c, Offset: 0x18b0
// Size: 0x74
function registerroundswitch(minvalue, maxvalue) {
    level.roundswitch = math::clamp(getgametypesetting(#"roundswitch"), minvalue, maxvalue);
    level.roundswitchmin = minvalue;
    level.roundswitchmax = maxvalue;
}

// Namespace util/util
// Params 2, eflags: 0x1 linked
// Checksum 0x9bd59b20, Offset: 0x1930
// Size: 0x74
function registerroundlimit(minvalue, maxvalue) {
    level.roundlimit = math::clamp(getgametypesetting(#"roundlimit"), minvalue, maxvalue);
    level.roundlimitmin = minvalue;
    level.roundlimitmax = maxvalue;
}

// Namespace util/util
// Params 2, eflags: 0x1 linked
// Checksum 0xf5b58663, Offset: 0x19b0
// Size: 0x74
function registerroundwinlimit(minvalue, maxvalue) {
    level.roundwinlimit = math::clamp(getgametypesetting(#"roundwinlimit"), minvalue, maxvalue);
    level.roundwinlimitmin = minvalue;
    level.roundwinlimitmax = maxvalue;
}

// Namespace util/util
// Params 2, eflags: 0x1 linked
// Checksum 0x25036e63, Offset: 0x1a30
// Size: 0x74
function registerscorelimit(minvalue, maxvalue) {
    level.scorelimit = math::clamp(getgametypesetting(#"scorelimit"), minvalue, maxvalue);
    level.scorelimitmin = minvalue;
    level.scorelimitmax = maxvalue;
}

// Namespace util/util
// Params 2, eflags: 0x1 linked
// Checksum 0x86481c04, Offset: 0x1ab0
// Size: 0x74
function registerroundscorelimit(minvalue, maxvalue) {
    level.roundscorelimit = math::clamp(getgametypesetting(#"roundscorelimit"), minvalue, maxvalue);
    level.roundscorelimitmin = minvalue;
    level.roundscorelimitmax = maxvalue;
}

// Namespace util/util
// Params 2, eflags: 0x1 linked
// Checksum 0xa29f06d2, Offset: 0x1b30
// Size: 0x8c
function registertimelimit(minvalue, maxvalue) {
    level.timelimit = math::clamp(getgametypesetting(#"timelimit"), minvalue, maxvalue);
    /#
        override_gts_timelimit();
    #/
    level.timelimitmin = minvalue;
    level.timelimitmax = maxvalue;
}

// Namespace util/util
// Params 4, eflags: 0x1 linked
// Checksum 0x80b70450, Offset: 0x1bc8
// Size: 0x12c
function registernumlives(minvalue, maxvalue, teamlivesminvalue = minvalue, teamlivesmaxvalue = maxvalue) {
    level.numlives = math::clamp(getgametypesetting(#"playernumlives"), minvalue, maxvalue);
    level.numlivesmin = minvalue;
    level.numlivesmax = maxvalue;
    level.numteamlives = math::clamp(getgametypesetting(#"teamnumlives"), teamlivesminvalue, teamlivesmaxvalue);
    level.numteamlivesmin = isdefined(teamlivesminvalue) ? teamlivesminvalue : level.numlivesmin;
    level.numteamlivesmax = isdefined(teamlivesmaxvalue) ? teamlivesmaxvalue : level.numlivesmax;
}

// Namespace util/util
// Params 1, eflags: 0x1 linked
// Checksum 0xb0b65567, Offset: 0x1d00
// Size: 0x80
function getplayerfromclientnum(clientnum) {
    if (clientnum < 0) {
        return undefined;
    }
    for (i = 0; i < level.players.size; i++) {
        if (level.players[i] getentitynumber() == clientnum) {
            return level.players[i];
        }
    }
    return undefined;
}

// Namespace util/util
// Params 0, eflags: 0x0
// Checksum 0xba81225a, Offset: 0x1d88
// Size: 0x52
function ispressbuild() {
    buildtype = getdvarstring(#"buildtype");
    if (isdefined(buildtype) && buildtype == "press") {
        return true;
    }
    return false;
}

// Namespace util/util
// Params 0, eflags: 0x1 linked
// Checksum 0xfd34d6cd, Offset: 0x1de8
// Size: 0x1e
function isflashbanged() {
    return isdefined(self.flashendtime) && gettime() < self.flashendtime;
}

// Namespace util/util
// Params 5, eflags: 0x0
// Checksum 0x11654288, Offset: 0x1e10
// Size: 0xb4
function domaxdamage(origin, attacker, inflictor, headshot, mod) {
    if (isdefined(self.damagedtodeath) && self.damagedtodeath) {
        return;
    }
    if (isdefined(self.maxhealth)) {
        damage = self.maxhealth + 1;
    } else {
        damage = self.health + 1;
    }
    self.damagedtodeath = 1;
    self dodamage(damage, origin, attacker, inflictor, headshot, mod);
}

// Namespace util/util
// Params 0, eflags: 0x0
// Checksum 0xc144030b, Offset: 0x1ed0
// Size: 0x24
function self_delete() {
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace util/util
// Params 0, eflags: 0x1 linked
// Checksum 0x97ed1e62, Offset: 0x1f00
// Size: 0x4a
function use_button_pressed() {
    assert(isplayer(self), "<dev string:xa1>");
    return self usebuttonpressed();
}

// Namespace util/util
// Params 0, eflags: 0x0
// Checksum 0x1b469b1a, Offset: 0x1f58
// Size: 0x28
function waittill_use_button_pressed() {
    while (!self use_button_pressed()) {
        waitframe(1);
    }
}

// Namespace util/util
// Params 4, eflags: 0x0
// Checksum 0xc5c7e5ca, Offset: 0x1f88
// Size: 0x184
function show_hint_text(str_text_to_show, b_should_blink = 0, str_turn_off_notify = "notify_turn_off_hint_text", n_display_time = 4) {
    self endon(#"notify_turn_off_hint_text", #"hint_text_removed");
    if (isdefined(self.hint_menu_handle)) {
        hide_hint_text(0);
    }
    self.hint_menu_handle = self openluimenu("MPHintText");
    self setluimenudata(self.hint_menu_handle, #"hint_text_line", str_text_to_show);
    if (b_should_blink) {
        lui::play_animation(self.hint_menu_handle, "blinking");
    } else {
        lui::play_animation(self.hint_menu_handle, "display_noblink");
    }
    if (n_display_time != -1) {
        self thread hide_hint_text_listener(n_display_time);
        self thread fade_hint_text_after_time(n_display_time, str_turn_off_notify);
    }
}

// Namespace util/util
// Params 1, eflags: 0x1 linked
// Checksum 0x70be62e8, Offset: 0x2118
// Size: 0xd6
function hide_hint_text(b_fade_before_hiding = 1) {
    self endon(#"hint_text_removed");
    if (isdefined(self.hint_menu_handle)) {
        if (b_fade_before_hiding) {
            lui::play_animation(self.hint_menu_handle, "fadeout");
            self waittilltimeout(0.75, #"kill_hint_text", #"death", #"hint_text_removed");
        }
        self closeluimenu(self.hint_menu_handle);
        self.hint_menu_handle = undefined;
    }
    self notify(#"hint_text_removed");
}

// Namespace util/util
// Params 2, eflags: 0x1 linked
// Checksum 0x1227a14, Offset: 0x21f8
// Size: 0x8c
function fade_hint_text_after_time(n_display_time, str_turn_off_notify) {
    self endon(#"hint_text_removed", #"death", #"kill_hint_text");
    self waittilltimeout(n_display_time - 0.75, str_turn_off_notify, #"hint_text_removed", #"kill_hint_text");
    hide_hint_text(1);
}

// Namespace util/util
// Params 1, eflags: 0x1 linked
// Checksum 0xc529df4e, Offset: 0x2290
// Size: 0x8c
function hide_hint_text_listener(n_time) {
    self endon(#"hint_text_removed", #"disconnect");
    self waittilltimeout(n_time, #"kill_hint_text", #"death", #"hint_text_removed", #"disconnect");
    hide_hint_text(0);
}

// Namespace util/util
// Params 2, eflags: 0x1 linked
// Checksum 0x527bf8c6, Offset: 0x2328
// Size: 0x7c
function set_team_radar(team, value) {
    if (team == #"allies") {
        setmatchflag("radar_allies", value);
        return;
    }
    if (team == #"axis") {
        setmatchflag("radar_axis", value);
    }
}

// Namespace util/util
// Params 1, eflags: 0x0
// Checksum 0x61b0a95d, Offset: 0x23b0
// Size: 0x8a
function is_objective_game(game_type) {
    switch (game_type) {
    case #"dm":
    case #"conf":
    case #"gun":
    case #"tdm":
    case #"clean":
        return 0;
    default:
        return 1;
    }
}

// Namespace util/util
// Params 0, eflags: 0x0
// Checksum 0x3e6d599a, Offset: 0x2448
// Size: 0x1a
function isprophuntgametype() {
    return is_true(level.isprophunt);
}

// Namespace util/util
// Params 0, eflags: 0x0
// Checksum 0x5173892f, Offset: 0x2470
// Size: 0x4a
function isprop() {
    return isdefined(self.pers[#"team"]) && self.pers[#"team"] == game.defenders;
}

// Namespace util/util
// Params 1, eflags: 0x1 linked
// Checksum 0x24a961a6, Offset: 0x24c8
// Size: 0x30
function function_6f4ff113(team) {
    if (game.switchedsides) {
        return getotherteam(team);
    }
    return team;
}

// Namespace util/util
// Params 2, eflags: 0x0
// Checksum 0xf8d728a7, Offset: 0x2500
// Size: 0x2c
function function_920dcdbf(item, var_3ec5ff40) {
    if (game.switchedsides) {
        return var_3ec5ff40;
    }
    return item;
}

// Namespace util/util
// Params 1, eflags: 0x0
// Checksum 0xb07b89ce, Offset: 0x2538
// Size: 0xea
function function_ff74bf7(team) {
    players = level.players;
    for (i = 0; i < players.size; i++) {
        player = players[i];
        if (isdefined(player.pers[#"team"]) && player.pers[#"team"] == team && isdefined(player.pers[#"class"])) {
            if (player.sessionstate == "playing" && !player.afk) {
                return i;
            }
        }
    }
    return players.size;
}

// Namespace util/util
// Params 4, eflags: 0x1 linked
// Checksum 0x69e94f70, Offset: 0x2630
// Size: 0x170
function function_a3f7de13(var_e0dd85aa, s_team, n_clientnum, extradata = 0) {
    if (!isdefined(var_e0dd85aa)) {
        return;
    }
    switch (s_team) {
    case #"axis":
        var_dfc4aab4 = 2;
        break;
    case #"allies":
        var_dfc4aab4 = 1;
        break;
    default:
        var_dfc4aab4 = 0;
        break;
    }
    if (!isdefined(n_clientnum)) {
        n_clientnum = -1;
    }
    players = getplayers();
    foreach (player in players) {
        player luinotifyevent(#"announcement_event", 4, var_e0dd85aa, var_dfc4aab4, n_clientnum, extradata);
    }
}

// Namespace util/util
// Params 0, eflags: 0x0
// Checksum 0xbdde0573, Offset: 0x27a8
// Size: 0xbe
function function_94a3be2() {
    if (is_true(level.var_903e2252)) {
        return true;
    }
    if ((isdefined(getgametypesetting(#"drafttime")) ? getgametypesetting(#"drafttime") : 0) < 30) {
        return true;
    }
    if (!is_true(getgametypesetting(#"draftenabled"))) {
        return true;
    }
    return false;
}

/#

    // Namespace util/util
    // Params 0, eflags: 0x0
    // Checksum 0x9d35db00, Offset: 0x2870
    // Size: 0x4c
    function check_art_mode() {
        if (getdvarint(#"art_mode", 0) > 0) {
            adddebugcommand("<dev string:xd0>");
        }
    }

    // Namespace util/util
    // Params 0, eflags: 0x0
    // Checksum 0x255816f5, Offset: 0x28c8
    // Size: 0x1c
    function apply_dev_overrides() {
        override_gts_timelimit();
    }

    // Namespace util/util
    // Params 0, eflags: 0x0
    // Checksum 0x72be0bd2, Offset: 0x28f0
    // Size: 0x7c
    function override_gts_timelimit() {
        timelimitoverride = getdvarint(#"timelimitoverride", -1);
        if (timelimitoverride >= 0) {
            if (level.timelimit != timelimitoverride) {
                level.timelimit = timelimitoverride;
                setgametypesetting("<dev string:xe5>", timelimitoverride);
            }
        }
    }

#/
