#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\player\player_role;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\rat_shared;
#using scripts\core_common\serverfield_shared;
#using scripts\core_common\spectating;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\gametypes\globallogic;
#using scripts\zm_common\gametypes\globallogic_audio;
#using scripts\zm_common\gametypes\globallogic_spawn;

#namespace draft;

// Namespace draft/draft
// Params 0, eflags: 0x2
// Checksum 0xe1729f4f, Offset: 0x1a8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"draft", &__init__, undefined, undefined);
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0x3716205, Offset: 0x1f0
// Size: 0x146
function __init__() {
    clientfield::register("world", "draft", 1, 3, "int");
    clientfield::register("clientuimodel", "PositionDraft.stage", 1, 3, "int");
    clientfield::register("clientuimodel", "PositionDraft.autoSelected", 1, 1, "int");
    clientfield::register("clientuimodel", "PositionDraft.cooldown", 1, 5, "int");
    clientfield::register("worlduimodel", "PositionDraft.timeRemaining", 1, 7, "int");
    serverfield::register("PositionDraft.uiLoaded", 1, 1, "int", &function_c10691d1);
    level.var_95c2a39c = 0;
    level.draftstage = 0;
}

// Namespace draft/draft
// Params 2, eflags: 0x0
// Checksum 0x662eb1ef, Offset: 0x340
// Size: 0x1b4
function function_168be332(response, intval) {
    if (response == #"changecharacter") {
        if (self function_2cfc07fc()) {
            self player_role::clear();
        }
        return;
    }
    if (response == #"randomcharacter") {
        self player_role::clear();
        assign_remaining_players(self);
        if (!(isdefined(level.inprematchperiod) && level.inprematchperiod)) {
            self close();
            self closeingamemenu();
        }
        return;
    }
    if (response == #"ready") {
        self client_ready();
        return;
    }
    if (response == #"opendraft") {
        self open();
        return;
    }
    if (response == #"closedraft") {
        self close();
        return;
    }
    if (response == #"draft") {
        select_character(intval, 0);
    }
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0xf104848a, Offset: 0x500
// Size: 0xea
function is_enabled() {
    /#
        if (getdvarint(#"art_review", 0) > 0) {
            return 0;
        }
    #/
    if (getdvarint(#"mp_prototype", 0) == 0) {
        return 0;
    }
    autoselectcharacter = getdvarint(#"force_char", -1);
    if (player_role::is_valid(autoselectcharacter)) {
        return 0;
    }
    if (isdefined(level.disableclassselection) && level.disableclassselection) {
        return 0;
    }
    return getgametypesetting(#"draftenabled");
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0x961aa919, Offset: 0x5f8
// Size: 0x72
function is_draft_this_round() {
    if (!is_enabled()) {
        return 0;
    }
    if (getgametypesetting(#"drafteveryround") == 1) {
        return 1;
    }
    if (util::isoneround()) {
        return 1;
    }
    return util::isfirstround();
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0x575c9682, Offset: 0x678
// Size: 0x34
function function_ca20e02d() {
    player = self;
    return isdefined(player.var_43a97b51) && player.var_43a97b51 > 0;
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0xa557fc3b, Offset: 0x6b8
// Size: 0x134
function start_cooldown() {
    player = self;
    assert(isplayer(player));
    player endon(#"disconnect");
    cooldowntime = getgametypesetting(#"hash_2b88c6ac064e9c59");
    var_3e8a7d82 = cooldowntime * 1000 + gettime();
    while (gettime() < var_3e8a7d82) {
        timeleft = (var_3e8a7d82 - gettime()) / 1000;
        player clientfield::set_player_uimodel("PositionDraft.cooldown", int(timeleft));
        player.var_43a97b51 = timeleft;
        wait 1;
    }
    player.var_43a97b51 = 0;
    player clientfield::set_player_uimodel("PositionDraft.cooldown", 0);
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0xb3f9a1e5, Offset: 0x7f8
// Size: 0x13e
function function_2cfc07fc() {
    player = self;
    if (player function_ca20e02d()) {
        println("<dev string:x30>" + player.name);
        return false;
    }
    if (level.draftstage == 0) {
        return true;
    }
    if (level.draftstage == 3 && !player isready()) {
        return true;
    }
    /#
        if (level.draftstage != 3) {
            println("<dev string:x65>" + player.name + "<dev string:x9e>" + level.draftstage);
        }
        if (player isready()) {
            println("<dev string:xa7>" + player.name);
        }
    #/
    return false;
}

// Namespace draft/draft
// Params 1, eflags: 0x0
// Checksum 0x1e0f0db6, Offset: 0x940
// Size: 0x200
function can_select_character(characterindex) {
    player = self;
    if (!function_2cfc07fc()) {
        return false;
    }
    maxuniqueroles = getgametypesetting(#"maxuniquerolesperteam", characterindex);
    if (maxuniqueroles == 0) {
        println("<dev string:xdb>" + player.name + "<dev string:x11b>" + characterindex);
        return false;
    }
    rolecount = 0;
    foreach (player in level.players) {
        if (player == self) {
            continue;
        }
        playercharacterindex = player player_role::get();
        if (isdefined(player.pers[#"team"]) && player.pers[#"team"] == self.pers[#"team"] && playercharacterindex == characterindex) {
            rolecount++;
            if (rolecount >= maxuniqueroles) {
                println("<dev string:x12e>" + player.name + "<dev string:x11b>" + characterindex);
                return false;
            }
        }
    }
    return true;
}

// Namespace draft/draft
// Params 2, eflags: 0x0
// Checksum 0x3fa314bc, Offset: 0xb48
// Size: 0x1be
function select_character(characterindex, forceselection) {
    player = self;
    assert(player_role::is_valid(characterindex));
    if (!(isdefined(forceselection) && forceselection) && !can_select_character(characterindex)) {
        return false;
    }
    if (self player_role::set(characterindex)) {
        self.characterindex = characterindex;
        if (isdefined(forceselection) && forceselection) {
            self player::spawn_player();
        }
        if (level.draftstage == 0) {
            self thread start_cooldown();
            self close();
        }
        println("<dev string:x16f>" + player.name + "<dev string:x11b>" + characterindex);
        return true;
    } else {
        self player_role::clear();
        println("<dev string:x189>" + self.name + "<dev string:x11b>" + characterindex);
        self util::clientnotify("PositionDraft_Reject");
    }
    return false;
}

// Namespace draft/draft
// Params 2, eflags: 0x0
// Checksum 0x3dece4c3, Offset: 0xd10
// Size: 0x3c
function function_c10691d1(oldval, newval) {
    player = self;
    player function_3cb7f9e6(newval);
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0x4b3e59ab, Offset: 0xd58
// Size: 0x2c
function client_ready() {
    player = self;
    player function_681d40bc(1);
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0x3a884ea9, Offset: 0xd90
// Size: 0xac
function draft_initialize() {
    foreach (player in level.players) {
        player clientfield::set_player_uimodel("PositionDraft.autoSelected", 0);
    }
    while (isloadingcinematicplaying()) {
        wait 1;
    }
}

// Namespace draft/draft
// Params 1, eflags: 0x0
// Checksum 0x59bf585a, Offset: 0xe48
// Size: 0x66
function function_8b9c6c29(starttime) {
    if (gettime() - starttime > int(120 * 1000)) {
        println("<dev string:x1ac>");
        while (true) {
            wait 10;
        }
    }
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0x9ed5166c, Offset: 0xeb8
// Size: 0x110
function all_players_connected() {
    var_e38cd205 = getnumexpectedplayers(0);
    if (level.players.size < var_e38cd205) {
        return false;
    }
    foreach (player in level.players) {
        if (!player function_ed3756be() && !isbot(player)) {
            return false;
        }
    }
    if (level.players.size <= getgametypesetting(#"draftrequiredclients")) {
        return false;
    }
    return true;
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0xd43598ce, Offset: 0xfd0
// Size: 0x48
function wait_for_players() {
    starttime = gettime();
    while (!all_players_connected()) {
        wait 0.2;
        function_8b9c6c29(starttime);
    }
}

// Namespace draft/draft
// Params 1, eflags: 0x0
// Checksum 0xb078fc47, Offset: 0x1020
// Size: 0x5c
function decrement(timeremaining) {
    /#
        if (level.draftstage == 3 && getdvarint(#"draft_pause", 0) != 0) {
            return timeremaining;
        }
    #/
    return timeremaining - 1;
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0x37c218cb, Offset: 0x1088
// Size: 0x478
function draft_run() {
    /#
        rat::function_98499d2();
    #/
    timeremaining = getgametypesetting(#"drafttime");
    foreach (player in level.players) {
        if (isbot(player)) {
            player player_role::clear();
        }
    }
    if (timeremaining == 0) {
        level clientfield::set_world_uimodel("PositionDraft.timeRemaining", 0);
        ready = 0;
        while (!ready) {
            ready = 1;
            foreach (player in level.players) {
                if (player.pers[#"team"] == "spectator" || isbot(player)) {
                    continue;
                }
                characterindex = player player_role::get();
                if (!player_role::is_valid(characterindex) || !player isready()) {
                    ready = 0;
                }
            }
            wait 1;
        }
    } else {
        while (timeremaining > 0 && !level.gameended) {
            level clientfield::set_world_uimodel("PositionDraft.timeRemaining", timeremaining);
            timeremaining = decrement(timeremaining);
            level.var_95c2a39c = 1;
            foreach (player in level.players) {
                if (player.pers[#"team"] == "spectator" || isbot(player)) {
                    continue;
                }
                if (!player isready()) {
                    level.var_95c2a39c = 0;
                    break;
                }
            }
            if (level.var_95c2a39c && all_players_connected()) {
                level clientfield::set_world_uimodel("PositionDraft.timeRemaining", 0);
                break;
            }
            wait 1;
        }
        level clientfield::set_world_uimodel("PositionDraft.timeRemaining", 0);
    }
    foreach (player in level.players) {
        if (isbot(player)) {
            assign_remaining_players(player);
            player client_ready();
        }
    }
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0x62367987, Offset: 0x1508
// Size: 0x2c
function function_61f6afb7() {
    level clientfield::set_world_uimodel("PositionDraft.timeRemaining", 0);
    wait 2;
}

// Namespace draft/draft
// Params 3, eflags: 0x0
// Checksum 0xab890eff, Offset: 0x1540
// Size: 0x2a
function sort_categories(left, right, param) {
    return left.size > right.size;
}

// Namespace draft/draft
// Params 1, eflags: 0x0
// Checksum 0x3c304c12, Offset: 0x1578
// Size: 0x380
function assign_remaining_players(only_assign_player) {
    roles = [];
    playerroletemplatecount = getplayerroletemplatecount(currentsessionmode());
    for (i = 0; i < playerroletemplatecount; i++) {
        fields = getplayerrolefields(i, currentsessionmode());
        if (isdefined(fields) && isdefined(fields.var_fac8128c) && fields.var_fac8128c == 1) {
            if (!isdefined(roles)) {
                roles = [];
            } else if (!isarray(roles)) {
                roles = array(roles);
            }
            roles[roles.size] = i;
        }
    }
    players = getplayers();
    foreach (player in players) {
        if (!isdefined(only_assign_player) || player === only_assign_player) {
            playerrole = player player_role::get();
            if (player_role::is_valid(playerrole)) {
                println("<dev string:x16f>" + player.name + "<dev string:x11b>" + playerrole);
                arrayremovevalue(roles, playerrole);
            }
        }
    }
    players = getplayers();
    foreach (player in players) {
        if (!isdefined(only_assign_player) || player === only_assign_player) {
            playerrole = player player_role::get();
            if (!player_role::is_valid(playerrole)) {
                var_bd84f6a1 = roles[randomint(roles.size)];
                println("<dev string:x1e1>" + player.name + "<dev string:x11b>" + playerrole);
                arrayremovevalue(roles, var_bd84f6a1);
                player select_character(var_bd84f6a1, 1);
            }
        }
    }
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0xffaddea5, Offset: 0x1900
// Size: 0x1bc
function game_start() {
    timeremaining = getgametypesetting(#"hash_4e4352bd1aaeedfe");
    starttime = gettime();
    if (level.var_95c2a39c == 1) {
        timeremaining++;
    }
    while (timeremaining > 0 && !level.gameended) {
        level clientfield::set_world_uimodel("PositionDraft.timeRemaining", int(timeremaining));
        if (timeremaining == 3) {
            foreach (player in level.players) {
                if (player.hasspawned || player.pers[#"team"] == "spectator") {
                }
            }
        }
        if (timeremaining == 2) {
        }
        timeremaining = decrement(timeremaining);
        if (timeremaining == 0) {
            wait 0.75;
            luinotifyevent(#"quick_fade", 0);
            wait 0.25;
            continue;
        }
        wait 1;
    }
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0x6b56fe3b, Offset: 0x1ac8
// Size: 0x1a4
function draft_finalize() {
    level.inprematchperiod = 0;
    foreach (player in level.players) {
        if (player.sessionstate == "playing") {
            player player::spawn_player();
            player [[ level.givecustomcharacters ]]();
        }
    }
    foreach (player in level.players) {
        player clientfield::set_player_uimodel("PositionDraft.autoSelected", 0);
    }
    luinotifyevent(#"draft_complete", 2, 1, 0);
    level notify(#"draft_complete");
    waitframe(1);
    set_draft_stage(0);
    /#
        rat::function_7f411587();
    #/
}

// Namespace draft/draft
// Params 1, eflags: 0x0
// Checksum 0xc1fcf7db, Offset: 0x1c78
// Size: 0x274
function set_draft_stage(draftstage) {
    level.draftstage = draftstage;
    level clientfield::set("draft", level.draftstage);
    waitframe(1);
    /#
        if (draftstage == 0) {
            println("<dev string:x1fc>");
        } else if (draftstage == 1) {
            println("<dev string:x20f>");
        } else if (draftstage == 2) {
            println("<dev string:x228>");
        } else if (draftstage == 3) {
            println("<dev string:x24a>");
        } else if (draftstage == 5) {
            println("<dev string:x25e>");
        } else if (draftstage == 6) {
            println("<dev string:x277>");
        } else if (draftstage == 7) {
            println("<dev string:x290>");
        }
    #/
    if (draftstage == 1) {
        draft_initialize();
        return;
    }
    if (draftstage == 2) {
        wait_for_players();
        return;
    }
    if (draftstage == 3) {
        draft_run();
        return;
    }
    if (draftstage == 4) {
        function_61f6afb7();
        return;
    }
    if (draftstage == 5) {
        assign_remaining_players();
        return;
    }
    if (draftstage == 6) {
        game_start();
        return;
    }
    if (draftstage == 7) {
        draft_finalize();
    }
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0x1612ddd8, Offset: 0x1ef8
// Size: 0x34
function watch_game_ended() {
    level waittill(#"game_ended");
    set_draft_stage(0);
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0xcd8370b3, Offset: 0x1f38
// Size: 0x11c
function start() {
    level endon(#"game_ended");
    level thread watch_game_ended();
    waitframe(1);
    println("<dev string:x2a7>");
    set_draft_stage(1);
    if (!all_players_connected()) {
        set_draft_stage(2);
    }
    set_draft_stage(3);
    if (level.var_95c2a39c == 1) {
        set_draft_stage(4);
    } else {
        set_draft_stage(5);
    }
    set_draft_stage(6);
    set_draft_stage(7);
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0x7c500f65, Offset: 0x2060
// Size: 0xf4
function open() {
    player = self;
    assert(isplayer(self));
    /#
        autoselection = getdvarint(#"force_char", -1);
        if (player_role::is_valid(autoselection)) {
            player player_role::set(autoselection);
            return;
        }
    #/
    player player_role::clear();
    level clientfield::set_world_uimodel("PositionDraft.timeRemaining", 0);
    player clientfield::set_player_uimodel("PositionDraft.stage", 3);
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0x11d65e70, Offset: 0x2160
// Size: 0x44
function close() {
    player = self;
    player spectating::set_permissions();
    self clientfield::set_player_uimodel("PositionDraft.stage", 0);
}

