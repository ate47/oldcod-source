#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\util_shared;

#namespace util;

// Namespace util/util
// Params 4, eflags: 0x0
// Checksum 0x4fe2f3b2, Offset: 0x168
// Size: 0x90
function within_fov(start_origin, start_angles, end_origin, fov) {
    normal = vectornormalize(end_origin - start_origin);
    forward = anglestoforward(start_angles);
    dot = vectordot(forward, normal);
    return dot >= fov;
}

// Namespace util/util
// Params 0, eflags: 0x0
// Checksum 0xa1b30b6b, Offset: 0x200
// Size: 0xa
function get_player_height() {
    return 70;
}

// Namespace util/util
// Params 1, eflags: 0x0
// Checksum 0x5495463a, Offset: 0x218
// Size: 0x3e
function isbulletimpactmod(smeansofdeath) {
    return issubstr(smeansofdeath, "BULLET") || smeansofdeath == "MOD_HEAD_SHOT";
}

// Namespace util/util
// Params 0, eflags: 0x0
// Checksum 0xd772a548, Offset: 0x260
// Size: 0x4e
function waitrespawnbutton() {
    self endon(#"disconnect");
    self endon(#"end_respawn");
    while (self usebuttonpressed() != 1) {
        waitframe(1);
    }
}

// Namespace util/util
// Params 2, eflags: 0x0
// Checksum 0xb757569, Offset: 0x2b8
// Size: 0xd6
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
// Checksum 0x31ba0b40, Offset: 0x398
// Size: 0xd6
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
// Checksum 0xa29db5b, Offset: 0x478
// Size: 0xe6
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
// Checksum 0x6688a45a, Offset: 0x568
// Size: 0x1c
function printonteamarg(text, team, arg) {
    
}

// Namespace util/util
// Params 2, eflags: 0x0
// Checksum 0x7618fb3, Offset: 0x590
// Size: 0xe6
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
// Params 7, eflags: 0x0
// Checksum 0xe6f16c08, Offset: 0x680
// Size: 0x4fe
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
// Checksum 0x779317df, Offset: 0xb88
// Size: 0x4c
function _playlocalsound(soundalias) {
    if (level.splitscreen && !self ishost()) {
        return;
    }
    self playlocalsound(soundalias);
}

// Namespace util/util
// Params 1, eflags: 0x0
// Checksum 0xc934c9b7, Offset: 0xbe0
// Size: 0x8c
function getotherteam(team) {
    if (team == #"allies") {
        return #"axis";
    } else if (team == #"axis") {
        return #"allies";
    } else {
        return #"allies";
    }
    assertmsg("<dev string:x30>" + team);
}

// Namespace util/util
// Params 1, eflags: 0x0
// Checksum 0xf372bb11, Offset: 0xc78
// Size: 0x6c
function getteamenum(team) {
    if (team == #"allies") {
        return 1;
    } else if (team == #"axis") {
        return 2;
    }
    assertmsg("<dev string:x4c>" + team);
}

// Namespace util/util
// Params 1, eflags: 0x0
// Checksum 0x9105b537, Offset: 0xcf0
// Size: 0x74
function getteammask(team) {
    if (!level.teambased || !isdefined(team) || !isdefined(level.spawnsystem.ispawn_teammask[team])) {
        return level.spawnsystem.ispawn_teammask_free;
    }
    return level.spawnsystem.ispawn_teammask[team];
}

// Namespace util/util
// Params 1, eflags: 0x0
// Checksum 0xa3020987, Offset: 0xd70
// Size: 0xb0
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
// Checksum 0xc6ec3d2f, Offset: 0xe28
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
// Checksum 0x96684c10, Offset: 0xea8
// Size: 0x5c
function getfx(fx) {
    assert(isdefined(level._effect[fx]), "<dev string:x67>" + fx + "<dev string:x6b>");
    return level._effect[fx];
}

// Namespace util/util
// Params 1, eflags: 0x0
// Checksum 0x384ec733, Offset: 0xf10
// Size: 0x52
function add_trigger_to_ent(ent) {
    if (!isdefined(ent._triggers)) {
        ent._triggers = [];
    }
    ent._triggers[self getentitynumber()] = 1;
}

// Namespace util/util
// Params 1, eflags: 0x0
// Checksum 0x2bef13e6, Offset: 0xf70
// Size: 0x72
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
// Params 1, eflags: 0x0
// Checksum 0xad8d7e6d, Offset: 0xff0
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
// Params 2, eflags: 0x0
// Checksum 0x10fb816, Offset: 0x1068
// Size: 0x4c
function trigger_thread_death_monitor(ent, ender) {
    ent waittill(#"death");
    self endon(ender);
    self remove_trigger_from_ent(ent);
}

// Namespace util/util
// Params 3, eflags: 0x0
// Checksum 0xf90c18c0, Offset: 0x10c0
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
// Checksum 0x7b9e44a4, Offset: 0x1250
// Size: 0x38
function isstrstart(string1, substr) {
    return getsubstr(string1, 0, substr.size) == substr;
}

// Namespace util/util
// Params 0, eflags: 0x0
// Checksum 0x98154b5b, Offset: 0x1290
// Size: 0x20
function iskillstreaksenabled() {
    return isdefined(level.killstreaksenabled) && level.killstreaksenabled;
}

// Namespace util/util
// Params 3, eflags: 0x4
// Checksum 0xbb8ad4c0, Offset: 0x12b8
// Size: 0xa4
function private function_7f281f03(team, index, objective_strings) {
    setobjectivetext(team, objective_strings.text);
    if (level.splitscreen) {
        setobjectivescoretext(team, objective_strings.score_text);
    } else {
        setobjectivescoretext(team, objective_strings.var_b2906558);
    }
    function_8569097d(team, index);
}

// Namespace util/util
// Params 1, eflags: 0x0
// Checksum 0x3968b3de, Offset: 0x1368
// Size: 0x23a
function function_c250a0e4(team) {
    if (!isdefined(level.var_b77eff6f)) {
        return;
    }
    objective_strings = level.var_b77eff6f.objective_strings;
    foreach (index, var_836ccdd2 in objective_strings) {
        if (isdefined(var_836ccdd2.attacker) && var_836ccdd2.attacker && team != game.attackers) {
            continue;
        }
        if (isdefined(var_836ccdd2.defender) && var_836ccdd2.defender && team != game.defenders) {
            continue;
        }
        if (isdefined(var_836ccdd2.overtime) && var_836ccdd2.overtime) {
            if (!game.overtime_round) {
                continue;
            }
            if (isdefined(var_836ccdd2.overtime_round) && var_836ccdd2.overtime_round && var_836ccdd2.overtime_round != game.overtime_round) {
                continue;
            }
            if (isdefined(var_836ccdd2.var_f5f0cf06) && var_836ccdd2.var_f5f0cf06 && isdefined(game.overtime_first_winner) && team != game.overtime_first_winner) {
                continue;
            }
            if (isdefined(var_836ccdd2.var_3506ebe) && var_836ccdd2.var_3506ebe && isdefined(game.overtime_first_winner) && team == game.overtime_first_winner) {
                continue;
            }
        }
        function_7f281f03(team, index, var_836ccdd2);
        return;
    }
}

// Namespace util/util
// Params 0, eflags: 0x0
// Checksum 0x16f6216f, Offset: 0x15b0
// Size: 0x90
function function_bbca659b() {
    if (!isdefined(level.var_b77eff6f)) {
        return;
    }
    foreach (team, _ in level.teams) {
        function_c250a0e4(team);
    }
}

// Namespace util/util
// Params 2, eflags: 0x0
// Checksum 0xf3ceeb58, Offset: 0x1648
// Size: 0x3e
function setobjectivetext(team, text) {
    game.strings["objective_" + level.teams[team]] = text;
}

// Namespace util/util
// Params 2, eflags: 0x0
// Checksum 0xe39ab691, Offset: 0x1690
// Size: 0x3e
function setobjectivescoretext(team, text) {
    game.strings["objective_score_" + level.teams[team]] = text;
}

// Namespace util/util
// Params 2, eflags: 0x0
// Checksum 0x551a8efa, Offset: 0x16d8
// Size: 0x3e
function function_8569097d(team, text) {
    game.strings["objective_first_spawn_hint_" + level.teams[team]] = text;
}

// Namespace util/util
// Params 1, eflags: 0x0
// Checksum 0x2b611bb6, Offset: 0x1720
// Size: 0x2c
function getobjectivetext(team) {
    return game.strings["objective_" + level.teams[team]];
}

// Namespace util/util
// Params 1, eflags: 0x0
// Checksum 0x945a90d2, Offset: 0x1758
// Size: 0x2c
function getobjectivescoretext(team) {
    return game.strings["objective_score_" + level.teams[team]];
}

// Namespace util/util
// Params 1, eflags: 0x0
// Checksum 0x4928ffa7, Offset: 0x1790
// Size: 0x2c
function function_83576051(team) {
    return game.strings["objective_first_spawn_hint_" + level.teams[team]];
}

// Namespace util/util
// Params 2, eflags: 0x0
// Checksum 0x3620ccf2, Offset: 0x17c8
// Size: 0x76
function registerroundswitch(minvalue, maxvalue) {
    level.roundswitch = math::clamp(getgametypesetting(#"roundswitch"), minvalue, maxvalue);
    level.roundswitchmin = minvalue;
    level.roundswitchmax = maxvalue;
}

// Namespace util/util
// Params 2, eflags: 0x0
// Checksum 0x53a7e663, Offset: 0x1848
// Size: 0x76
function registerroundlimit(minvalue, maxvalue) {
    level.roundlimit = math::clamp(getgametypesetting(#"roundlimit"), minvalue, maxvalue);
    level.roundlimitmin = minvalue;
    level.roundlimitmax = maxvalue;
}

// Namespace util/util
// Params 2, eflags: 0x0
// Checksum 0x95e17955, Offset: 0x18c8
// Size: 0x76
function registerroundwinlimit(minvalue, maxvalue) {
    level.roundwinlimit = math::clamp(getgametypesetting(#"roundwinlimit"), minvalue, maxvalue);
    level.roundwinlimitmin = minvalue;
    level.roundwinlimitmax = maxvalue;
}

// Namespace util/util
// Params 2, eflags: 0x0
// Checksum 0x27bcb9d6, Offset: 0x1948
// Size: 0x76
function registerscorelimit(minvalue, maxvalue) {
    level.scorelimit = math::clamp(getgametypesetting(#"scorelimit"), minvalue, maxvalue);
    level.scorelimitmin = minvalue;
    level.scorelimitmax = maxvalue;
}

// Namespace util/util
// Params 2, eflags: 0x0
// Checksum 0xd8ac6146, Offset: 0x19c8
// Size: 0x76
function registerroundscorelimit(minvalue, maxvalue) {
    level.roundscorelimit = math::clamp(getgametypesetting(#"roundscorelimit"), minvalue, maxvalue);
    level.roundscorelimitmin = minvalue;
    level.roundscorelimitmax = maxvalue;
}

// Namespace util/util
// Params 2, eflags: 0x0
// Checksum 0x1c70b49c, Offset: 0x1a48
// Size: 0x8a
function registertimelimit(minvalue, maxvalue) {
    level.timelimit = math::clamp(getgametypesetting(#"timelimit"), minvalue, maxvalue);
    /#
        override_gts_timelimit();
    #/
    level.timelimitmin = minvalue;
    level.timelimitmax = maxvalue;
}

// Namespace util/util
// Params 4, eflags: 0x0
// Checksum 0x2f00106a, Offset: 0x1ae0
// Size: 0x12e
function registernumlives(minvalue, maxvalue, teamlivesminvalue = minvalue, teamlivesmaxvalue = maxvalue) {
    level.numlives = math::clamp(getgametypesetting(#"playernumlives"), minvalue, maxvalue);
    level.numlivesmin = minvalue;
    level.numlivesmax = maxvalue;
    level.numteamlives = math::clamp(getgametypesetting(#"teamnumlives"), teamlivesminvalue, teamlivesmaxvalue);
    level.numteamlivesmin = isdefined(teamlivesminvalue) ? teamlivesminvalue : level.numlivesmin;
    level.numteamlivesmax = isdefined(teamlivesmaxvalue) ? teamlivesmaxvalue : level.numlivesmax;
}

// Namespace util/util
// Params 1, eflags: 0x0
// Checksum 0xbaf7eb9c, Offset: 0x1c18
// Size: 0x82
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
// Checksum 0x9b67091f, Offset: 0x1ca8
// Size: 0x52
function ispressbuild() {
    buildtype = getdvarstring(#"buildtype");
    if (isdefined(buildtype) && buildtype == "press") {
        return true;
    }
    return false;
}

// Namespace util/util
// Params 0, eflags: 0x0
// Checksum 0x8d5be476, Offset: 0x1d08
// Size: 0x1e
function isflashbanged() {
    return isdefined(self.flashendtime) && gettime() < self.flashendtime;
}

// Namespace util/util
// Params 5, eflags: 0x0
// Checksum 0xf82b12b6, Offset: 0x1d30
// Size: 0xbc
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
// Checksum 0x4659eb19, Offset: 0x1df8
// Size: 0x24
function self_delete() {
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace util/util
// Params 0, eflags: 0x0
// Checksum 0xc3bbcf09, Offset: 0x1e28
// Size: 0x4a
function use_button_pressed() {
    assert(isplayer(self), "<dev string:x8d>");
    return self usebuttonpressed();
}

// Namespace util/util
// Params 0, eflags: 0x0
// Checksum 0x1ab775dd, Offset: 0x1e80
// Size: 0x28
function waittill_use_button_pressed() {
    while (!self use_button_pressed()) {
        waitframe(1);
    }
}

// Namespace util/util
// Params 4, eflags: 0x0
// Checksum 0x947cb8b6, Offset: 0x1eb0
// Size: 0x184
function show_hint_text(str_text_to_show, b_should_blink = 0, str_turn_off_notify = "notify_turn_off_hint_text", n_display_time = 4) {
    self endon(#"notify_turn_off_hint_text");
    self endon(#"hint_text_removed");
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
// Params 1, eflags: 0x0
// Checksum 0x2b9266fa, Offset: 0x2040
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
// Params 2, eflags: 0x0
// Checksum 0xba3b657f, Offset: 0x2120
// Size: 0x94
function fade_hint_text_after_time(n_display_time, str_turn_off_notify) {
    self endon(#"hint_text_removed");
    self endon(#"death");
    self endon(#"kill_hint_text");
    self waittilltimeout(n_display_time - 0.75, str_turn_off_notify, #"hint_text_removed", #"kill_hint_text");
    hide_hint_text(1);
}

// Namespace util/util
// Params 1, eflags: 0x0
// Checksum 0x39b56357, Offset: 0x21c0
// Size: 0x8c
function hide_hint_text_listener(n_time) {
    self endon(#"hint_text_removed");
    self endon(#"disconnect");
    self waittilltimeout(n_time, #"kill_hint_text", #"death", #"hint_text_removed", #"disconnect");
    hide_hint_text(0);
}

// Namespace util/util
// Params 2, eflags: 0x0
// Checksum 0x94497755, Offset: 0x2258
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
// Params 0, eflags: 0x0
// Checksum 0xc32d9fd4, Offset: 0x22e0
// Size: 0x22
function init_player_contract_events() {
    if (!isdefined(level.player_contract_events)) {
        level.player_contract_events = [];
    }
}

// Namespace util/util
// Params 3, eflags: 0x0
// Checksum 0xdf61b4fa, Offset: 0x2310
// Size: 0x106
function register_player_contract_event(event_name, event_func, max_param_count = 0) {
    if (!isdefined(level.player_contract_events[event_name])) {
        level.player_contract_events[event_name] = spawnstruct();
        level.player_contract_events[event_name].param_count = max_param_count;
        level.player_contract_events[event_name].events = [];
    }
    assert(max_param_count == level.player_contract_events[event_name].param_count);
    level.player_contract_events[event_name].events[level.player_contract_events[event_name].events.size] = event_func;
}

// Namespace util/util
// Params 4, eflags: 0x0
// Checksum 0x3177a03, Offset: 0x2420
// Size: 0x32a
function player_contract_event(event_name, param1 = undefined, param2 = undefined, param3 = undefined) {
    if (!isdefined(level.player_contract_events[event_name])) {
        return;
    }
    param_count = isdefined(level.player_contract_events[event_name].param_count) ? level.player_contract_events[event_name].param_count : 0;
    switch (param_count) {
    case 0:
    default:
        foreach (event_func in level.player_contract_events[event_name].events) {
            if (isdefined(event_func)) {
                self [[ event_func ]]();
            }
        }
        break;
    case 1:
        foreach (event_func in level.player_contract_events[event_name].events) {
            if (isdefined(event_func)) {
                self [[ event_func ]](param1);
            }
        }
        break;
    case 2:
        foreach (event_func in level.player_contract_events[event_name].events) {
            if (isdefined(event_func)) {
                self [[ event_func ]](param1, param2);
            }
        }
        break;
    case 3:
        foreach (event_func in level.player_contract_events[event_name].events) {
            if (isdefined(event_func)) {
                self [[ event_func ]](param1, param2, param3);
            }
        }
        break;
    }
}

// Namespace util/util
// Params 1, eflags: 0x0
// Checksum 0xb2ae3344, Offset: 0x2758
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
// Checksum 0x25752b4, Offset: 0x27f0
// Size: 0x20
function isprophuntgametype() {
    return isdefined(level.isprophunt) && level.isprophunt;
}

// Namespace util/util
// Params 0, eflags: 0x0
// Checksum 0x7dbd1f4f, Offset: 0x2818
// Size: 0x4a
function isprop() {
    return isdefined(self.pers[#"team"]) && self.pers[#"team"] == game.defenders;
}

// Namespace util/util
// Params 1, eflags: 0x0
// Checksum 0xd362fe30, Offset: 0x2870
// Size: 0x30
function function_82f4ab63(team) {
    if (game.switchedsides) {
        return getotherteam(team);
    }
    return team;
}

// Namespace util/util
// Params 2, eflags: 0x0
// Checksum 0xe19703d4, Offset: 0x28a8
// Size: 0x2c
function function_bd7299c5(item, var_f41d7c88) {
    if (game.switchedsides) {
        return var_f41d7c88;
    }
    return item;
}

// Namespace util/util
// Params 1, eflags: 0x0
// Checksum 0x2f0c53a9, Offset: 0x28e0
// Size: 0x100
function function_12544d86(team) {
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
// Params 4, eflags: 0x0
// Checksum 0xcc12ccd1, Offset: 0x29e8
// Size: 0x168
function function_d1f9db00(var_f39eb252, s_team, n_clientnum, extradata = 0) {
    if (!isdefined(var_f39eb252)) {
        return;
    }
    switch (s_team) {
    case #"axis":
        var_f73eddf = 2;
        break;
    case #"allies":
        var_f73eddf = 1;
        break;
    default:
        var_f73eddf = 0;
        break;
    }
    if (!isdefined(n_clientnum)) {
        n_clientnum = -1;
    }
    players = get_players();
    foreach (player in players) {
        player luinotifyevent(#"announcement_event", 4, var_f39eb252, var_f73eddf, n_clientnum, extradata);
    }
}

/#

    // Namespace util/util
    // Params 0, eflags: 0x0
    // Checksum 0x14f026f9, Offset: 0x2b58
    // Size: 0x44
    function check_art_mode() {
        if (getdvarint(#"art_mode", 0) > 0) {
            init_map_art_dev();
        }
    }

    // Namespace util/util
    // Params 0, eflags: 0x0
    // Checksum 0x997c929d, Offset: 0x2ba8
    // Size: 0x1c
    function apply_dev_overrides() {
        override_gts_timelimit();
    }

    // Namespace util/util
    // Params 0, eflags: 0x0
    // Checksum 0x3208fc83, Offset: 0x2bd0
    // Size: 0x4c
    function init_map_art_dev() {
        disable_gameplay_timers();
        disable_draft();
        disable_ui();
        enable_art_fps();
    }

    // Namespace util/util
    // Params 0, eflags: 0x0
    // Checksum 0xc7e0f280, Offset: 0x2c28
    // Size: 0x6c
    function disable_gameplay_timers() {
        setdvar(#"timelimitoverride", 0);
        setdvar(#"prematchperiodoverride", 0);
        setdvar(#"preroundperiodoverride", 0);
    }

    // Namespace util/util
    // Params 0, eflags: 0x0
    // Checksum 0xe8ae55c3, Offset: 0x2ca0
    // Size: 0x54
    function disable_draft() {
        setdvar(#"draftenabled", 0);
        setdvar(#"auto_select_character", 1);
    }

    // Namespace util/util
    // Params 0, eflags: 0x0
    // Checksum 0xdd453ac5, Offset: 0x2d00
    // Size: 0x2c
    function disable_ui() {
        setdvar(#"ui_enabled", 0);
    }

    // Namespace util/util
    // Params 0, eflags: 0x0
    // Checksum 0xa4c9a0a2, Offset: 0x2d38
    // Size: 0x7c
    function override_gts_timelimit() {
        timelimitoverride = getdvarint(#"timelimitoverride", -1);
        if (timelimitoverride >= 0) {
            if (level.timelimit != timelimitoverride) {
                level.timelimit = timelimitoverride;
                setgametypesetting("<dev string:xb9>", timelimitoverride);
            }
        }
    }

    // Namespace util/util
    // Params 0, eflags: 0x0
    // Checksum 0x6ffd983d, Offset: 0x2dc0
    // Size: 0x54
    function enable_art_fps() {
        setdvar(#"cg_drawfps", 0);
        setdvar(#"cg_drawartfps", 1);
    }

#/
