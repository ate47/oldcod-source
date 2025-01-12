#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\player\player_role;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\rat_shared;
#using scripts\core_common\serverfield_shared;
#using scripts\core_common\spectating;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_audio;
#using scripts\mp_common\player\player_loadout;

#namespace draft;

// Namespace draft/draft
// Params 0, eflags: 0x2
// Checksum 0xa452acac, Offset: 0x210
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"draft", &__init__, undefined, undefined);
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0x70954de8, Offset: 0x258
// Size: 0x18e
function __init__() {
    clientfield::register("world", "draft", 1, 3, "int");
    clientfield::register("clientuimodel", "PositionDraft.stage", 1, 4, "int");
    clientfield::register("clientuimodel", "PositionDraft.autoSelected", 1, 1, "int");
    clientfield::register("clientuimodel", "PositionDraft.cooldown", 1, 5, "int");
    clientfield::register("worlduimodel", "PositionDraft.timeRemaining", 1, 7, "int");
    clientfield::register("worlduimodel", "PositionDraft.waitingForPlayers", 1, 1, "int");
    serverfield::register("PositionDraft.uiLoaded", 1, 1, "int", &function_c10691d1);
    level.var_95c2a39c = 0;
    level.draftstage = 0;
    /#
        level.var_4ab92d3e = "<dev string:x30>";
    #/
}

/#

    // Namespace draft/draft
    // Params 0, eflags: 0x0
    // Checksum 0x670c1c9d, Offset: 0x3f0
    // Size: 0x3e
    function function_e43edb04() {
        self notify("<invalid>");
        self endon("<invalid>");
        wait 5;
        level.var_4ab92d3e = "<dev string:x30>";
    }

    // Namespace draft/draft
    // Params 1, eflags: 0x0
    // Checksum 0x8aaeb125, Offset: 0x438
    // Size: 0x64
    function function_620ac56(message) {
        if (message == level.var_4ab92d3e) {
            return;
        }
        level.var_4ab92d3e = message;
        println(message);
        level thread function_e43edb04();
    }

#/

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0xb752c38d, Offset: 0x4a8
// Size: 0x82
function is_enabled() {
    autoselectcharacter = getdvarint(#"auto_select_character", -1);
    if (player_role::is_valid(autoselectcharacter)) {
        return 0;
    }
    if (level.disableclassselection) {
        return 0;
    }
    return getgametypesetting(#"draftenabled");
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0x646d0c1b, Offset: 0x538
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
// Checksum 0x608828a3, Offset: 0x5b8
// Size: 0x34
function function_ca20e02d() {
    player = self;
    return isdefined(player.var_43a97b51) && player.var_43a97b51 > 0;
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0xabcd7994, Offset: 0x5f8
// Size: 0x144
function start_cooldown() {
    player = self;
    assert(isplayer(player));
    player endon(#"disconnect", #"hash_7fa9c275efb510e2");
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
// Checksum 0xf44b3bb0, Offset: 0x748
// Size: 0x5e
function clear_cooldown() {
    player = self;
    assert(isplayer(player));
    player notify(#"hash_7fa9c275efb510e2");
    player.var_43a97b51 = 0;
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0x836a30bb, Offset: 0x7b0
// Size: 0x7a
function function_2cfc07fc() {
    player = self;
    if (player function_ca20e02d()) {
        return false;
    }
    if (level.draftstage == 0) {
        return true;
    }
    if (level.draftstage == 3 && !player isready()) {
        return true;
    }
    return false;
}

// Namespace draft/draft
// Params 1, eflags: 0x0
// Checksum 0x9b3c3101, Offset: 0x838
// Size: 0x184
function can_select_character(characterindex) {
    if (!function_2cfc07fc()) {
        return false;
    }
    maxuniqueroles = getgametypesetting(#"maxuniquerolesperteam", characterindex);
    if (maxuniqueroles == 0) {
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
                return false;
            }
        }
    }
    return true;
}

// Namespace draft/draft
// Params 3, eflags: 0x0
// Checksum 0xb24d5e45, Offset: 0x9c8
// Size: 0x1de
function select_character(characterindex, forceselection, var_ff1a39dd) {
    assert(player_role::is_valid(characterindex));
    if (!(isdefined(forceselection) && forceselection) && !can_select_character(characterindex)) {
        return false;
    }
    if (self player_role::set(characterindex)) {
        if (level.draftstage == 0) {
            self thread start_cooldown();
            self close();
        } else if (isdefined(level.var_7bf21f79)) {
            game_time = gettime();
            var_1036e1f1 = {#xuid:self getxuid(), #character_index:characterindex, #game_time:game_time, #var_79837d4c:game_time - level.var_7bf21f79, #var_9cb61910:var_ff1a39dd};
            function_b1f6086c(#"hash_3a95edd667fd3e7d", var_1036e1f1);
        }
        return true;
    } else {
        self player_role::clear();
        self util::clientnotify("PositionDraft_Reject");
    }
    return false;
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0xa89b35e7, Offset: 0xbb0
// Size: 0xb4
function function_3a188a0() {
    level endon(#"game_ended", #"draft_complete");
    while (true) {
        foreach (player in level.players) {
            player resetinactivitytimer();
        }
        wait 5;
    }
}

// Namespace draft/draft
// Params 2, eflags: 0x0
// Checksum 0xd72e5e97, Offset: 0xc70
// Size: 0x6c
function function_c10691d1(oldval, newval) {
    player = self;
    /#
        function_620ac56("<dev string:x41>" + player.name + "<dev string:x49>");
    #/
    player function_3cb7f9e6(newval);
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0xb8f22bad, Offset: 0xce8
// Size: 0x2c
function client_ready() {
    player = self;
    player function_681d40bc(1);
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0x4ee48b4a, Offset: 0xd20
// Size: 0x124
function draft_initialize() {
    level.inprematchperiod = 1;
    foreach (player in level.players) {
        player clientfield::set_player_uimodel("PositionDraft.autoSelected", 0);
    }
    level.var_2f13bd57 = getgametypesetting(#"drafttime") + getgametypesetting(#"hash_4e4352bd1aaeedfe");
    function_5c53a9b3(int(max(0, level.var_2f13bd57)));
}

// Namespace draft/draft
// Params 2, eflags: 0x0
// Checksum 0x8dc8c949, Offset: 0xe50
// Size: 0x64
function function_6e6a32a9(starttime, seconds) {
    if (gettime() - starttime > int(seconds * 1000)) {
        println("<dev string:x55>");
        return true;
    }
    return false;
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0x1ed381f, Offset: 0xec0
// Size: 0x148
function all_players_connected() {
    var_e38cd205 = getnumexpectedplayers(0);
    if (level.players.size < var_e38cd205) {
        /#
            function_620ac56("<dev string:x8a>" + var_e38cd205 + "<dev string:xb1>" + level.players.size);
        #/
        return false;
    }
    foreach (player in level.players) {
        if (!player function_ed3756be() && !isbot(player)) {
            /#
                function_620ac56("<dev string:xc7>" + player.name + "<dev string:xe4>");
            #/
            return false;
        }
    }
    return true;
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0x8d33251b, Offset: 0x1010
// Size: 0xae
function function_cec7fe97() {
    foreach (player in level.players) {
        if (player function_ed3756be() || player.team == #"spectator") {
            return true;
        }
    }
    return false;
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0xf4b272ec, Offset: 0x10c8
// Size: 0x1f8
function function_412d2216() {
    var_f306dafc = getgametypesetting(#"draftrequiredclients");
    if (var_f306dafc <= 0) {
        return true;
    }
    foreach (team, _ in level.teams) {
        teamcount[team] = 0;
    }
    foreach (player in level.players) {
        if (isdefined(level.teams[player.team])) {
            teamcount[player.team]++;
        }
    }
    foreach (team, _ in level.teams) {
        if (teamcount[team] < var_f306dafc) {
            /#
                function_620ac56("<dev string:xf8>" + var_f306dafc + "<dev string:x130>" + team + "<dev string:x133>" + teamcount[team]);
            #/
            return false;
        }
    }
    return true;
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0x7f61ee43, Offset: 0x12c8
// Size: 0x19c
function wait_for_players() {
    while (!function_cec7fe97()) {
        wait 0.2;
    }
    level.var_2f13bd57 = getgametypesetting(#"drafttime") + getgametypesetting(#"hash_4e4352bd1aaeedfe") + 20;
    function_5c53a9b3(int(max(0, level.var_2f13bd57)));
    starttime = gettime();
    while (!all_players_connected()) {
        wait 0.2;
        if (function_6e6a32a9(starttime, 20)) {
            break;
        }
    }
    level.var_2f13bd57 = getgametypesetting(#"drafttime") + getgametypesetting(#"hash_4e4352bd1aaeedfe");
    function_5c53a9b3(int(max(0, level.var_2f13bd57)));
}

// Namespace draft/draft
// Params 1, eflags: 0x0
// Checksum 0x14d30593, Offset: 0x1470
// Size: 0xb6
function decrement(timeremaining) {
    /#
        if (level.draftstage == 3 && getdvarint(#"draft_pause", 0) != 0) {
            return timeremaining;
        }
    #/
    level.var_2f13bd57 -= 1;
    function_5c53a9b3(int(max(0, level.var_2f13bd57)));
    return timeremaining - 1;
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0x46006cff, Offset: 0x1530
// Size: 0x12
function pause_draft() {
    level.var_95be9413 = 1;
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0x5a1bf5a1, Offset: 0x1550
// Size: 0x12
function function_572cb68() {
    level.var_95be9413 = 0;
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0x24217ba, Offset: 0x1570
// Size: 0x538
function draft_run() {
    /#
        rat::function_98499d2();
    #/
    timeremaining = getgametypesetting(#"drafttime");
    function_5c53a9b3(int(max(0, level.var_2f13bd57)));
    foreach (player in level.players) {
        if (isbot(player)) {
            player player_role::clear();
        }
        class_num = player stats::get_stat(#"selectedcustomclass");
        player setplayerstateloadoutweapons(class_num);
    }
    if (timeremaining == 0) {
        level.var_7bf21f79 = gettime();
        level clientfield::set_world_uimodel("PositionDraft.timeRemaining", 0);
        ready = 0;
        while (!ready) {
            ready = 1;
            foreach (player in level.players) {
                if (player.pers[#"team"] == #"spectator" || isbot(player)) {
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
        while (!function_cec7fe97()) {
            wait 1;
        }
        level.var_7bf21f79 = gettime();
        while (timeremaining > 0 && !level.gameended) {
            level clientfield::set_world_uimodel("PositionDraft.timeRemaining", timeremaining);
            timeremaining = decrement(timeremaining);
            level.var_95c2a39c = 1;
            foreach (player in level.players) {
                if (player.pers[#"team"] == #"spectator" || isbot(player)) {
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
        }
        player client_ready();
    }
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0xbda9d246, Offset: 0x1ab0
// Size: 0x2c
function function_61f6afb7() {
    level clientfield::set_world_uimodel("PositionDraft.timeRemaining", 0);
    wait 2;
}

// Namespace draft/draft
// Params 3, eflags: 0x0
// Checksum 0x3302e3bd, Offset: 0x1ae8
// Size: 0x2a
function sort_categories(left, right, param) {
    return left.size > right.size;
}

// Namespace draft/draft
// Params 1, eflags: 0x0
// Checksum 0x56d6c55, Offset: 0x1b20
// Size: 0xcfa
function assign_remaining_players(only_assign_player) {
    teams = [];
    characters = [];
    validcharacters = [];
    categorymap = [];
    playerroletemplatecount = getplayerroletemplatecount(currentsessionmode());
    for (i = 0; i < playerroletemplatecount; i++) {
        playerrolefields = getplayerrolefields(i, currentsessionmode());
        characters[i] = spawnstruct();
        characters[i].index = i;
        characters[i].available = 0;
        characters[i].enabled = function_fab05cb7(i) && isdefined(playerrolefields.var_fac8128c) && playerrolefields.var_fac8128c;
        characters[i].category = player_role::get_category_for_index(i);
        characters[i].var_f791e6c2 = getgametypesetting(#"maxuniquerolesperteam", i);
        if (characters[i].enabled && player_role::is_valid(i) && characters[i].category != "default" && characters[i].var_f791e6c2 != 0) {
            characters[i].available = 1;
            if (!isdefined(validcharacters)) {
                validcharacters = [];
            } else if (!isarray(validcharacters)) {
                validcharacters = array(validcharacters);
            }
            validcharacters[validcharacters.size] = characters[i];
            if (!isdefined(categorymap[characters[i].category])) {
                categorymap[characters[i].category] = categorymap.size;
            }
        }
    }
    if (getdvarint(#"hash_595a93ece672a7da", -1) == 1) {
        foreach (player in level.players) {
            if (!isdefined(only_assign_player)) {
                validcharacters = array::randomize(validcharacters);
                player select_character(validcharacters[0].index, 1, 0);
                continue;
            }
            if (only_assign_player == player) {
                validcharacters = array::randomize(validcharacters);
                player select_character(validcharacters[0].index, 1, 0);
                break;
            }
        }
        return;
    }
    foreach (player in level.players) {
        if (player.pers[#"team"] == #"spectator") {
            continue;
        }
        if (!isdefined(teams[player.team])) {
            teams[player.team] = [];
        }
        if (!isdefined(teams[player.team])) {
            teams[player.team] = [];
        } else if (!isarray(teams[player.team])) {
            teams[player.team] = array(teams[player.team]);
        }
        teams[player.team][teams[player.team].size] = player;
    }
    foreach (team in teams) {
        println("<dev string:x13c>" + team[0].team);
        playersneedingassignment = [];
        foreach (character in validcharacters) {
            character.available = 0;
            if (character.var_f791e6c2 > 0) {
                character.available = 1;
            }
        }
        /#
            println("<dev string:x16a>");
            foreach (player in team) {
                characterindex = player player_role::get();
                println("<dev string:x185>" + player.name + "<dev string:x195>" + characterindex);
            }
        #/
        foreach (player in team) {
            characterindex = player player_role::get();
            if (player_role::is_valid(characterindex)) {
                characters[characterindex].available = 0;
                continue;
            }
            if (!isdefined(only_assign_player)) {
                player player_role::clear();
                if (!isdefined(playersneedingassignment)) {
                    playersneedingassignment = [];
                } else if (!isarray(playersneedingassignment)) {
                    playersneedingassignment = array(playersneedingassignment);
                }
                playersneedingassignment[playersneedingassignment.size] = player;
                player clientfield::set_player_uimodel("PositionDraft.autoSelected", 1);
                continue;
            }
            if (only_assign_player == player) {
                player player_role::clear();
                if (!isdefined(playersneedingassignment)) {
                    playersneedingassignment = [];
                } else if (!isarray(playersneedingassignment)) {
                    playersneedingassignment = array(playersneedingassignment);
                }
                playersneedingassignment[playersneedingassignment.size] = player;
            }
        }
        println("<dev string:x1a8>");
        foreach (player in playersneedingassignment) {
            categories = [];
            categorynames = getarraykeys(categorymap);
            for (i = 0; i < categorymap.size; i++) {
                categories[i] = [];
            }
            foreach (character in characters) {
                if (character.category == "default") {
                    continue;
                }
                if (character.available == 1) {
                    categoryindex = categorymap[character.category];
                    if (!isdefined(categories[categoryindex])) {
                        categories[categoryindex] = [];
                    } else if (!isarray(categories[categoryindex])) {
                        categories[categoryindex] = array(categories[categoryindex]);
                    }
                    categories[categoryindex][categories[categoryindex].size] = character.index;
                }
            }
            categories = array::randomize(categories);
            categories = array::merge_sort(categories, &sort_categories);
            selectedcharacter = 0;
            if (categories.size > 0) {
                selectedcategory = categories[0];
                selectedcharacter = array::random(selectedcategory);
            }
            if (validcharacters.size == 0) {
                println("<dev string:x1c9>");
                globallogic::exit_level();
                while (true) {
                    wait 10;
                }
            }
            if (!isdefined(selectedcharacter) || selectedcharacter == 0) {
                randomcharacter = array::random(validcharacters);
                selectedcharacter = randomcharacter.index;
            }
            oldspecialistindex = player getspecialistindex();
            if (isdefined(oldspecialistindex) && oldspecialistindex != selectedcharacter) {
                player.pers[#"class"] = undefined;
            }
            println("<dev string:x1fa>" + player.name + "<dev string:x214>" + selectedcharacter);
            if (player select_character(selectedcharacter, 1, 1)) {
                characters[selectedcharacter].available = 0;
            }
        }
    }
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0x4f85f0a2, Offset: 0x2828
// Size: 0x24c
function game_start() {
    timeremaining = getgametypesetting(#"hash_4e4352bd1aaeedfe");
    starttime = gettime();
    if (level.var_95c2a39c == 1) {
        timeremaining++;
    }
    if (level.gametype !== "bounty") {
        foreach (player in level.players) {
            if (player.hasspawned || player.pers[#"team"] == #"spectator") {
                player globallogic_audio::set_music_on_player("spawnPreRise");
            }
        }
    }
    level thread globallogic::sndsetmatchsnapshot(0);
    while (timeremaining > 0 && !level.gameended) {
        level clientfield::set_world_uimodel("PositionDraft.timeRemaining", int(timeremaining));
        if (timeremaining == 2) {
            globallogic::mpintro_visionset_deactivate_func();
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
    level notify(#"hash_4c62fe02843b1a98");
    level thread globallogic::sndsetmatchsnapshot(0);
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0x8ef82b1, Offset: 0x2a80
// Size: 0x2ec
function draft_finalize() {
    level.inprematchperiod = 0;
    foreach (player in level.players) {
        if (player.sessionstate == "playing") {
            println("<dev string:x21a>" + player.name + "<dev string:x233>" + player.curclass + "<dev string:x23c>" + player getspecialistindex());
            player loadout::give_loadout(player.team, player.curclass);
            player.pers[#"lastcurclass"] = player.curclass;
            player.pers[#"lastspecialistindex"] = player.curclass;
            player enableweapons();
            player val::reset(#"spawn_player", "freezecontrols");
            player val::reset(#"spawn_player", "disablegadgets");
            player callback::callback(#"prematch_end");
        }
    }
    level callback::callback(#"prematch_end");
    foreach (player in level.players) {
        player clientfield::set_player_uimodel("PositionDraft.autoSelected", 0);
    }
    luinotifyevent(#"draft_complete", 2, 1, 0);
    level notify(#"draft_complete");
    set_draft_stage(0);
    /#
        rat::function_7f411587();
    #/
}

// Namespace draft/draft
// Params 1, eflags: 0x0
// Checksum 0x197a76e7, Offset: 0x2d78
// Size: 0x274
function set_draft_stage(draftstage) {
    level.draftstage = draftstage;
    level clientfield::set("draft", level.draftstage);
    waitframe(1);
    /#
        if (draftstage == 0) {
            println("<dev string:x24e>");
        } else if (draftstage == 1) {
            println("<dev string:x261>");
        } else if (draftstage == 2) {
            println("<dev string:x27a>");
        } else if (draftstage == 3) {
            println("<dev string:x29c>");
        } else if (draftstage == 5) {
            println("<dev string:x2b0>");
        } else if (draftstage == 6) {
            println("<dev string:x2c9>");
        } else if (draftstage == 7) {
            println("<dev string:x2e2>");
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
// Checksum 0x8b2a2250, Offset: 0x2ff8
// Size: 0x34
function watch_game_ended() {
    level waittill(#"game_ended");
    set_draft_stage(0);
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0xc6d0e400, Offset: 0x3038
// Size: 0x10c
function start() {
    level endon(#"game_ended");
    level thread watch_game_ended();
    level thread function_3a188a0();
    waitframe(1);
    println("<dev string:x2f9>");
    set_draft_stage(1);
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
// Checksum 0x7a2e89f9, Offset: 0x3150
// Size: 0x19c
function open() {
    player = self;
    assert(isplayer(self));
    if (isdefined(level.var_a7d910d3)) {
        self [[ level.var_a7d910d3 ]]();
        return;
    }
    /#
        autoselection = getdvarint(#"auto_select_character", -1);
        if (player_role::is_valid(autoselection)) {
            player player_role::set(autoselection);
            return;
        }
    #/
    player allowspectateallteams(0);
    player allowspectateteam("freelook", 0);
    player allowspectateteam(#"none", 1);
    player allowspectateteam("localplayers", 0);
    player player_role::clear();
    level clientfield::set_world_uimodel("PositionDraft.timeRemaining", 0);
    player clientfield::set_player_uimodel("PositionDraft.stage", 8);
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0x71c2575b, Offset: 0x32f8
// Size: 0x44
function close() {
    player = self;
    player spectating::set_permissions();
    self clientfield::set_player_uimodel("PositionDraft.stage", 0);
}

