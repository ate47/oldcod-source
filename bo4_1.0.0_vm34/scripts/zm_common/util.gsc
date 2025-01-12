#using scripts\core_common\array_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\sound_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;

#namespace util;

// Namespace util/util
// Params 0, eflags: 0x0
// Checksum 0x1f2c2840, Offset: 0x108
// Size: 0x114
function brush_delete() {
    num = self.v[#"exploder"];
    if (isdefined(self.v[#"delay"])) {
        wait self.v[#"delay"];
    } else {
        wait 0.05;
    }
    if (!isdefined(self.model)) {
        return;
    }
    assert(isdefined(self.model));
    if (!isdefined(self.v[#"fxid"]) || self.v[#"fxid"] == "No FX") {
        self.v[#"exploder"] = undefined;
    }
    waittillframeend();
    self.model delete();
}

// Namespace util/util
// Params 0, eflags: 0x0
// Checksum 0xbe3744e1, Offset: 0x228
// Size: 0x8c
function brush_show() {
    if (isdefined(self.v[#"delay"])) {
        wait self.v[#"delay"];
    }
    assert(isdefined(self.model));
    self.model show();
    self.model solid();
}

// Namespace util/util
// Params 0, eflags: 0x0
// Checksum 0xcd50941a, Offset: 0x2c0
// Size: 0x224
function brush_throw() {
    if (isdefined(self.v[#"delay"])) {
        wait self.v[#"delay"];
    }
    ent = undefined;
    if (isdefined(self.v[#"target"])) {
        ent = getent(self.v[#"target"], "targetname");
    }
    if (!isdefined(ent)) {
        self.model delete();
        return;
    }
    self.model show();
    startorg = self.v[#"origin"];
    startang = self.v[#"angles"];
    org = ent.origin;
    temp_vec = org - self.v[#"origin"];
    x = temp_vec[0];
    y = temp_vec[1];
    z = temp_vec[2];
    self.model rotatevelocity((x, y, z), 12);
    self.model movegravity((x, y, z), 12);
    self.v[#"exploder"] = undefined;
    wait 6;
    self.model delete();
}

// Namespace util/util
// Params 2, eflags: 0x0
// Checksum 0xd3feb836, Offset: 0x4f0
// Size: 0x17e
function playsoundonplayers(sound, team) {
    assert(isdefined(level.players));
    if (level.splitscreen) {
        if (isdefined(level.players[0])) {
            level.players[0] playlocalsound(sound);
        }
        return;
    }
    if (isdefined(team)) {
        for (i = 0; i < level.players.size; i++) {
            player = level.players[i];
            if (isdefined(player.pers[#"team"]) && player.pers[#"team"] == team) {
                player playlocalsound(sound);
            }
        }
        return;
    }
    for (i = 0; i < level.players.size; i++) {
        level.players[i] playlocalsound(sound);
    }
}

// Namespace util/util
// Params 0, eflags: 0x0
// Checksum 0x528f40ec, Offset: 0x678
// Size: 0xa
function get_player_height() {
    return 70;
}

// Namespace util/util
// Params 1, eflags: 0x0
// Checksum 0xecd79073, Offset: 0x690
// Size: 0x3e
function isbulletimpactmod(smeansofdeath) {
    return issubstr(smeansofdeath, "BULLET") || smeansofdeath == "MOD_HEAD_SHOT";
}

// Namespace util/util
// Params 0, eflags: 0x0
// Checksum 0x68963974, Offset: 0x6d8
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
// Checksum 0x8beedaf0, Offset: 0x730
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
// Checksum 0xa869aa11, Offset: 0x810
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
// Checksum 0x10a1f2d6, Offset: 0x8f0
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
// Checksum 0xdec3468, Offset: 0x9e0
// Size: 0x1c
function printonteamarg(text, team, arg) {
    
}

// Namespace util/util
// Params 2, eflags: 0x0
// Checksum 0x6b51e9e1, Offset: 0xa08
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
// Checksum 0xc8176f71, Offset: 0xaf8
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
// Checksum 0x24ec953a, Offset: 0x1000
// Size: 0x4c
function _playlocalsound(soundalias) {
    if (level.splitscreen && !self ishost()) {
        return;
    }
    self playlocalsound(soundalias);
}

// Namespace util/util
// Params 1, eflags: 0x0
// Checksum 0x2285094, Offset: 0x1058
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
// Checksum 0x3638ce9, Offset: 0x10f0
// Size: 0x74
function getteammask(team) {
    if (!level.teambased || !isdefined(team) || !isdefined(level.spawnsystem.ispawn_teammask[team])) {
        return level.spawnsystem.ispawn_teammask_free;
    }
    return level.spawnsystem.ispawn_teammask[team];
}

// Namespace util/util
// Params 1, eflags: 0x0
// Checksum 0x65c55c70, Offset: 0x1170
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
// Params 1, eflags: 0x0
// Checksum 0x67fe7781, Offset: 0x1228
// Size: 0x5c
function getfx(fx) {
    assert(isdefined(level._effect[fx]), "<dev string:x4c>" + fx + "<dev string:x50>");
    return level._effect[fx];
}

// Namespace util/util
// Params 2, eflags: 0x0
// Checksum 0x5915064, Offset: 0x1290
// Size: 0x38
function isstrstart(string1, substr) {
    return getsubstr(string1, 0, substr.size) == substr;
}

// Namespace util/util
// Params 0, eflags: 0x0
// Checksum 0xdce92ad1, Offset: 0x12d0
// Size: 0x20
function iskillstreaksenabled() {
    return isdefined(level.killstreaksenabled) && level.killstreaksenabled;
}

// Namespace util/util
// Params 0, eflags: 0x0
// Checksum 0x868a471e, Offset: 0x12f8
// Size: 0x32
function getremotename() {
    assert(self isusingremote());
    return self.usingremote;
}

// Namespace util/util
// Params 2, eflags: 0x0
// Checksum 0x54176fe8, Offset: 0x1338
// Size: 0x3e
function setobjectivetext(team, text) {
    game.strings["objective_" + level.teams[team]] = text;
}

// Namespace util/util
// Params 2, eflags: 0x0
// Checksum 0x54217896, Offset: 0x1380
// Size: 0x3e
function setobjectivescoretext(team, text) {
    game.strings["objective_score_" + level.teams[team]] = text;
}

// Namespace util/util
// Params 1, eflags: 0x0
// Checksum 0x1352c437, Offset: 0x13c8
// Size: 0x2c
function getobjectivetext(team) {
    return game.strings["objective_" + level.teams[team]];
}

// Namespace util/util
// Params 1, eflags: 0x0
// Checksum 0x10d9620a, Offset: 0x1400
// Size: 0x2c
function getobjectivescoretext(team) {
    return game.strings["objective_score_" + level.teams[team]];
}

// Namespace util/util
// Params 1, eflags: 0x0
// Checksum 0xc0fc0155, Offset: 0x1438
// Size: 0x2c
function getobjectivehinttext(team) {
    return game.strings["objective_hint_" + level.teams[team]];
}

// Namespace util/util
// Params 2, eflags: 0x0
// Checksum 0x8be2548e, Offset: 0x1470
// Size: 0x76
function registerroundswitch(minvalue, maxvalue) {
    level.roundswitch = math::clamp(getgametypesetting(#"roundswitch"), minvalue, maxvalue);
    level.roundswitchmin = minvalue;
    level.roundswitchmax = maxvalue;
}

// Namespace util/util
// Params 2, eflags: 0x0
// Checksum 0x47797c40, Offset: 0x14f0
// Size: 0x76
function registerroundlimit(minvalue, maxvalue) {
    level.roundlimit = math::clamp(getgametypesetting(#"roundlimit"), minvalue, maxvalue);
    level.roundlimitmin = minvalue;
    level.roundlimitmax = maxvalue;
}

// Namespace util/util
// Params 2, eflags: 0x0
// Checksum 0x977b13b7, Offset: 0x1570
// Size: 0x76
function registerroundwinlimit(minvalue, maxvalue) {
    level.roundwinlimit = math::clamp(getgametypesetting(#"roundwinlimit"), minvalue, maxvalue);
    level.roundwinlimitmin = minvalue;
    level.roundwinlimitmax = maxvalue;
}

// Namespace util/util
// Params 2, eflags: 0x0
// Checksum 0xf87fe60e, Offset: 0x15f0
// Size: 0x76
function registerscorelimit(minvalue, maxvalue) {
    level.scorelimit = math::clamp(getgametypesetting(#"scorelimit"), minvalue, maxvalue);
    level.scorelimitmin = minvalue;
    level.scorelimitmax = maxvalue;
}

// Namespace util/util
// Params 2, eflags: 0x0
// Checksum 0xfba3b2ef, Offset: 0x1670
// Size: 0x76
function registertimelimit(minvalue, maxvalue) {
    level.timelimit = math::clamp(getgametypesetting(#"timelimit"), minvalue, maxvalue);
    level.timelimitmin = minvalue;
    level.timelimitmax = maxvalue;
}

// Namespace util/util
// Params 2, eflags: 0x0
// Checksum 0x9307737, Offset: 0x16f0
// Size: 0x76
function registernumlives(minvalue, maxvalue) {
    level.numlives = math::clamp(getgametypesetting(#"playernumlives"), minvalue, maxvalue);
    level.numlivesmin = minvalue;
    level.numlivesmax = maxvalue;
}

// Namespace util/util
// Params 1, eflags: 0x0
// Checksum 0x17605737, Offset: 0x1770
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
// Checksum 0x830c0984, Offset: 0x1800
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
// Checksum 0xe648ac26, Offset: 0x1860
// Size: 0x1e
function isflashbanged() {
    return isdefined(self.flashendtime) && gettime() < self.flashendtime;
}

// Namespace util/util
// Params 5, eflags: 0x0
// Checksum 0xec071198, Offset: 0x1888
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
// Params 5, eflags: 0x0
// Checksum 0xae2c006e, Offset: 0x1950
// Size: 0x2f0
function get_array_of_closest(org, array, excluders = [], max = array.size, maxdist) {
    maxdists2rd = undefined;
    if (isdefined(maxdist)) {
        maxdists2rd = maxdist * maxdist;
    }
    dist = [];
    index = [];
    for (i = 0; i < array.size; i++) {
        if (!isdefined(array[i])) {
            continue;
        }
        if (isinarray(excluders, array[i])) {
            continue;
        }
        if (isvec(array[i])) {
            length = distancesquared(org, array[i]);
        } else {
            length = distancesquared(org, array[i].origin);
        }
        if (isdefined(maxdists2rd) && maxdists2rd < length) {
            continue;
        }
        dist[dist.size] = length;
        index[index.size] = i;
    }
    for (;;) {
        change = 0;
        for (i = 0; i < dist.size - 1; i++) {
            if (dist[i] <= dist[i + 1]) {
                continue;
            }
            change = 1;
            temp = dist[i];
            dist[i] = dist[i + 1];
            dist[i + 1] = temp;
            temp = index[i];
            index[i] = index[i + 1];
            index[i + 1] = temp;
        }
        if (!change) {
            break;
        }
    }
    newarray = [];
    if (max > dist.size) {
        max = dist.size;
    }
    for (i = 0; i < max; i++) {
        newarray[i] = array[index[i]];
    }
    return newarray;
}

