#using script_1cc417743d7c262d;
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
#using scripts\mp_common\player\player_loadout;

#namespace draft;

// Namespace draft/draft
// Params 0, eflags: 0x6
// Checksum 0x23dab18e, Offset: 0x210
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"draft", &preinit, undefined, undefined, undefined);
}

// Namespace draft/draft
// Params 0, eflags: 0x4
// Checksum 0xab152da1, Offset: 0x258
// Size: 0x17c
function private preinit() {
    clientfield::register("world", "draft", 1, 3, "int");
    clientfield::register_clientuimodel("PositionDraft.stage", 1, 4, "int");
    clientfield::register_clientuimodel("PositionDraft.autoSelected", 1, 1, "int");
    clientfield::register_clientuimodel("PositionDraft.cooldown", 1, 5, "int");
    clientfield::function_5b7d846d("PositionDraft.timeRemaining", 1, 7, "int");
    clientfield::function_5b7d846d("PositionDraft.waitingForPlayers", 1, 1, "int");
    serverfield::register("PositionDraft.uiLoaded", 1, 1, "int", &function_9f408cf7);
    level.var_5be52892 = 0;
    level.draftstage = 0;
    /#
        level.var_5fa54158 = "<dev string:x38>";
    #/
    /#
        level thread function_e8a5f9ba();
    #/
}

/#

    // Namespace draft/draft
    // Params 0, eflags: 0x0
    // Checksum 0xbe4bf32e, Offset: 0x3e0
    // Size: 0x3c
    function function_6bea5139() {
        self notify("<dev string:x3c>");
        self endon("<dev string:x3c>");
        wait 5;
        level.var_5fa54158 = "<dev string:x38>";
    }

    // Namespace draft/draft
    // Params 1, eflags: 0x0
    // Checksum 0x85aa1813, Offset: 0x428
    // Size: 0x64
    function function_95c03d66(message) {
        if (message == level.var_5fa54158) {
            return;
        }
        level.var_5fa54158 = message;
        println(message);
        level thread function_6bea5139();
    }

    // Namespace draft/draft
    // Params 1, eflags: 0x0
    // Checksum 0xe65ce839, Offset: 0x498
    // Size: 0xe6
    function function_947fe5c4(character) {
        if (character != "<dev string:x38>") {
            var_44dd7e5d = hash(character);
            playerroletemplatecount = getplayerroletemplatecount(currentsessionmode());
            for (i = 0; i < playerroletemplatecount; i++) {
                var_3c6fd4f7 = function_b14806c6(i, currentsessionmode());
                if (var_3c6fd4f7 == var_44dd7e5d) {
                    self select_character(i, 1);
                    return;
                }
            }
        }
    }

    // Namespace draft/draft
    // Params 0, eflags: 0x0
    // Checksum 0xf0e42ecf, Offset: 0x588
    // Size: 0x13a
    function function_e8a5f9ba() {
        current = getdvarstring(#"character", "<dev string:x38>");
        if (current != "<dev string:x38>") {
            while (true) {
                autoselection = getdvarstring(#"character");
                if (autoselection != "<dev string:x38>" && autoselection != current) {
                    foreach (player in level.players) {
                        player function_947fe5c4(autoselection);
                    }
                }
                wait 1;
            }
        }
    }

#/

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0x68cb1da8, Offset: 0x6d0
// Size: 0x92
function is_enabled() {
    autoselectcharacter = getdvarint(#"auto_select_character", -1);
    if (player_role::is_valid(autoselectcharacter)) {
        return 0;
    }
    if (is_true(level.var_b3c4b7b7)) {
        return 0;
    }
    return getgametypesetting(#"draftenabled");
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0xd88efb6d, Offset: 0x770
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
// Checksum 0x565c7881, Offset: 0x7f0
// Size: 0x30
function function_2c7b2ff() {
    player = self;
    return isdefined(player.var_7d68fce3) && player.var_7d68fce3 > 0;
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0x31da7f98, Offset: 0x828
// Size: 0x13c
function start_cooldown() {
    player = self;
    assert(isplayer(player));
    player endon(#"disconnect", #"hash_7fa9c275efb510e2");
    cooldowntime = getgametypesetting(#"hash_2b88c6ac064e9c59");
    var_e5e81b59 = cooldowntime * 1000 + gettime();
    while (gettime() < var_e5e81b59) {
        timeleft = (var_e5e81b59 - gettime()) / 1000;
        player clientfield::set_player_uimodel("PositionDraft.cooldown", int(timeleft));
        player.var_7d68fce3 = timeleft;
        wait 1;
    }
    player.var_7d68fce3 = 0;
    player clientfield::set_player_uimodel("PositionDraft.cooldown", 0);
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0x85fdbe51, Offset: 0x970
// Size: 0x7c
function clear_cooldown() {
    player = self;
    assert(isplayer(player));
    player notify(#"hash_7fa9c275efb510e2");
    player.var_7d68fce3 = 0;
    player clientfield::set_player_uimodel("PositionDraft.cooldown", 0);
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0xedc668ba, Offset: 0x9f8
// Size: 0x92
function function_904deeb2() {
    player = self;
    if (player.var_6b4e7428 === 1) {
        return false;
    }
    if (player function_2c7b2ff()) {
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
// Checksum 0x778fe063, Offset: 0xa98
// Size: 0x182
function can_select_character(characterindex) {
    if (!function_904deeb2()) {
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
// Checksum 0xdfae2bd4, Offset: 0xc28
// Size: 0xb6
function select_character(characterindex, forceselection, *var_8a239568) {
    if (!player_role::is_valid(forceselection)) {
        return false;
    }
    assert(player_role::is_valid(forceselection));
    if (!is_true(var_8a239568) && !can_select_character(forceselection)) {
        return false;
    }
    self player_role::set(forceselection);
    return false;
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0xcb0027c3, Offset: 0xce8
// Size: 0xc4
function function_ca33311e() {
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
// Checksum 0xa01c9027, Offset: 0xdb8
// Size: 0x6c
function function_9f408cf7(*oldval, newval) {
    player = self;
    /#
        function_95c03d66("<dev string:x50>" + player.name + "<dev string:x5b>");
    #/
    player function_4b8d2217(newval);
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0xc1263b1e, Offset: 0xe30
// Size: 0x2c
function client_ready() {
    player = self;
    player function_427981d0(1);
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0x6ca41d3c, Offset: 0xe68
// Size: 0x13c
function draft_initialize() {
    level.inprematchperiod = 1;
    foreach (player in level.players) {
        player clientfield::set_player_uimodel("PositionDraft.autoSelected", 0);
    }
    level.var_b318d3d1 = getgametypesetting(#"drafttime") + getgametypesetting(#"hash_4e4352bd1aaeedfe");
    function_ee80d2e8(int(max(0, level.var_b318d3d1)));
}

// Namespace draft/draft
// Params 2, eflags: 0x0
// Checksum 0xb8009774, Offset: 0xfb0
// Size: 0x64
function function_c5394b83(starttime, seconds) {
    if (gettime() - starttime > int(seconds * 1000)) {
        println("<dev string:x6a>");
        return true;
    }
    return false;
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0xbcc83c24, Offset: 0x1020
// Size: 0x158
function all_players_connected() {
    var_5c6783e9 = getnumexpectedplayers(0);
    if (level.players.size < var_5c6783e9) {
        /#
            function_95c03d66("<dev string:xa2>" + var_5c6783e9 + "<dev string:xcc>" + level.players.size);
        #/
        return false;
    }
    foreach (player in level.players) {
        if (!player function_9b95ed9f() && !isbot(player)) {
            /#
                function_95c03d66("<dev string:xe5>" + player.name + "<dev string:x105>");
            #/
            return false;
        }
    }
    return true;
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0x918e6b71, Offset: 0x1180
// Size: 0x92
function function_d255fb3e() {
    foreach (player in level.players) {
        if (player function_9b95ed9f()) {
            return true;
        }
    }
    return false;
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0xa570c362, Offset: 0x1220
// Size: 0x208
function function_21f5a2c1() {
    var_e8cb777 = getgametypesetting(#"draftrequiredclients");
    if (var_e8cb777 <= 0) {
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
        if (teamcount[team] < var_e8cb777) {
            /#
                function_95c03d66("<dev string:x11c>" + var_e8cb777 + "<dev string:x157>" + team + "<dev string:x15d>" + teamcount[team]);
            #/
            return false;
        }
    }
    return true;
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0x7375501f, Offset: 0x1430
// Size: 0x194
function wait_for_players() {
    while (!function_d255fb3e()) {
        wait 0.2;
    }
    level.var_b318d3d1 = getgametypesetting(#"drafttime") + getgametypesetting(#"hash_4e4352bd1aaeedfe") + 20;
    function_ee80d2e8(int(max(0, level.var_b318d3d1)));
    starttime = gettime();
    while (!all_players_connected()) {
        wait 0.2;
        if (function_c5394b83(starttime, 20)) {
            break;
        }
    }
    level.var_b318d3d1 = getgametypesetting(#"drafttime") + getgametypesetting(#"hash_4e4352bd1aaeedfe");
    function_ee80d2e8(int(max(0, level.var_b318d3d1)));
}

// Namespace draft/draft
// Params 1, eflags: 0x0
// Checksum 0x7661dab9, Offset: 0x15d0
// Size: 0xb6
function decrement(timeremaining) {
    /#
        if (level.draftstage == 3 && getdvarint(#"draft_pause", 0) != 0) {
            return timeremaining;
        }
    #/
    level.var_b318d3d1 -= 1;
    function_ee80d2e8(int(max(0, level.var_b318d3d1)));
    return timeremaining - 1;
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0xc7ee5bdf, Offset: 0x1690
// Size: 0x14
function pause_draft() {
    level.var_297320a8 = 1;
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0x1414792a, Offset: 0x16b0
// Size: 0x10
function function_3e648d9b() {
    level.var_297320a8 = 0;
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0x9bd9f478, Offset: 0x16c8
// Size: 0x580
function draft_run() {
    /#
        rat::function_b4f2a076();
    #/
    timeremaining = getgametypesetting(#"drafttime");
    function_ee80d2e8(int(max(0, level.var_b318d3d1)));
    foreach (player in level.players) {
        if (isbot(player)) {
            player player_role::clear();
        }
        class_num = player stats::get_stat(#"selectedcustomclass");
        player setplayerstateloadoutweapons(class_num);
    }
    if (timeremaining == 0) {
        level.var_9205f2e8 = gettime();
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
        while (!function_d255fb3e()) {
            wait 1;
        }
        level.var_9205f2e8 = gettime();
        while (timeremaining > 0 && !level.gameended) {
            level clientfield::set_world_uimodel("PositionDraft.timeRemaining", timeremaining);
            timeremaining = decrement(timeremaining);
            level.var_5be52892 = 1;
            var_97286e53 = 1;
            foreach (player in level.players) {
                if (player.pers[#"team"] == #"spectator") {
                    continue;
                }
                var_97286e53 = 0;
                if (isbot(player)) {
                    continue;
                }
                if (!player isready()) {
                    level.var_5be52892 = 0;
                    break;
                }
            }
            if (level.var_5be52892 && !var_97286e53 && all_players_connected()) {
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
// Checksum 0x37db69c2, Offset: 0x1c50
// Size: 0x2c
function function_404f08f3() {
    level clientfield::set_world_uimodel("PositionDraft.timeRemaining", 0);
    wait 2;
}

// Namespace draft/draft
// Params 3, eflags: 0x0
// Checksum 0x5d1f192a, Offset: 0x1c88
// Size: 0x2a
function sort_categories(left, right, *param) {
    return right.size > param.size;
}

// Namespace draft/draft
// Params 1, eflags: 0x0
// Checksum 0xdc0ed578, Offset: 0x1cc0
// Size: 0xdb6
function assign_remaining_players(only_assign_player) {
    teams = [];
    characters = [];
    validcharacters = [];
    categorymap = [];
    playerroletemplatecount = getplayerroletemplatecount(currentsessionmode());
    for (i = 0; i < playerroletemplatecount; i++) {
        playerrolefields = getplayerrolefields(i, currentsessionmode());
        characterfields = getcharacterfields(i, currentsessionmode());
        characters[i] = spawnstruct();
        characters[i].index = i;
        characters[i].available = 0;
        characters[i].enabled = function_f4bf7e3f(i) && is_true(playerrolefields.var_422e172f) && !isdefined(characterfields.requireddvar);
        characters[i].category = player_role::get_category_for_index(i);
        characters[i].var_9a6db9eb = isdefined(getgametypesetting(#"maxuniquerolesperteam", i)) ? getgametypesetting(#"maxuniquerolesperteam", i) : 1;
        if (characters[i].enabled && player_role::is_valid(i) && characters[i].category != "default" && characters[i].var_9a6db9eb != 0) {
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
        println("<dev string:x169>" + team[0].team);
        playersneedingassignment = [];
        foreach (character in validcharacters) {
            character.available = 0;
            if (character.var_9a6db9eb > 0) {
                character.available = 1;
            }
        }
        /#
            println("<dev string:x19a>");
            foreach (player in team) {
                characterindex = player player_role::get();
                println("<dev string:x1b8>" + player.name + "<dev string:x1cb>" + characterindex);
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
        println("<dev string:x1e1>");
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
                println("<dev string:x205>");
                println("<dev string:x205>");
                println("<dev string:x205>");
                println("<dev string:x205>");
                println("<dev string:x205>");
                println("<dev string:x205>");
                println("<dev string:x205>");
                println("<dev string:x205>");
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
            println("<dev string:x239>" + player.name + "<dev string:x256>" + selectedcharacter);
            if (player select_character(selectedcharacter, 1, 1)) {
                characters[selectedcharacter].available = 0;
            }
        }
    }
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0x14ce026, Offset: 0x2a80
// Size: 0x218
function game_start() {
    timeremaining = getgametypesetting(#"hash_4e4352bd1aaeedfe");
    starttime = gettime();
    if (level.var_5be52892 == 1) {
        timeremaining++;
    }
    if (level.gametype !== "bounty") {
        foreach (player in level.players) {
            if (player.hasspawned || player.pers[#"team"] == #"spectator") {
                player globallogic_audio::set_music_on_player("spawn");
            }
        }
    }
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
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0x7f9b6551, Offset: 0x2ca0
// Size: 0x3dc
function draft_finalize() {
    level.inprematchperiod = 0;
    foreach (player in level.players) {
        if (player.sessionstate == "spectator" && player.team != #"spectator") {
            assign_remaining_players(player);
        }
        if (player.sessionstate == "playing") {
            println("<dev string:x25f>" + player.name + "<dev string:x27b>" + player.curclass + "<dev string:x287>" + player getspecialistindex());
            if (!is_true(level.disableclassselection)) {
                player loadout::give_loadout(player.team, player.curclass);
            }
            player.pers[#"lastcurclass"] = player.curclass;
            player.pers[#"lastspecialistindex"] = player.curclass;
            if (is_true(getgametypesetting(#"hash_1b85ace023e616a1"))) {
                player val::function_4671dfff(#"spawn_player", 0);
            } else {
                player val::reset(#"spawn_player", "freezecontrols");
                player val::reset(#"spawn_player", "disablegadgets");
            }
            player enableweapons();
            player callback::callback(#"prematch_end");
        }
    }
    level callback::callback(#"prematch_end");
    foreach (player in level.players) {
        player clientfield::set_player_uimodel("PositionDraft.autoSelected", 0);
        player clientfield::set_player_uimodel("PositionDraft.stage", 0);
    }
    luinotifyevent(#"draft_complete", 2, 1, 0);
    level notify(#"draft_complete");
    set_draft_stage(0);
    /#
        rat::function_6aa20375();
    #/
}

// Namespace draft/draft
// Params 1, eflags: 0x0
// Checksum 0x148bffe5, Offset: 0x3088
// Size: 0x274
function set_draft_stage(draftstage) {
    level.draftstage = draftstage;
    level clientfield::set("draft", level.draftstage);
    waitframe(1);
    /#
        if (draftstage == 0) {
            println("<dev string:x29c>");
        } else if (draftstage == 1) {
            println("<dev string:x2b2>");
        } else if (draftstage == 2) {
            println("<dev string:x2ce>");
        } else if (draftstage == 3) {
            println("<dev string:x2f3>");
        } else if (draftstage == 5) {
            println("<dev string:x30a>");
        } else if (draftstage == 6) {
            println("<dev string:x326>");
        } else if (draftstage == 7) {
            println("<dev string:x342>");
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
        function_404f08f3();
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
// Checksum 0x2996309e, Offset: 0x3308
// Size: 0x34
function watch_game_ended() {
    level waittill(#"game_ended");
    set_draft_stage(0);
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0xc84cb58b, Offset: 0x3348
// Size: 0x10c
function start() {
    level endon(#"game_ended");
    level thread watch_game_ended();
    level thread function_ca33311e();
    waitframe(1);
    println("<dev string:x35c>");
    set_draft_stage(1);
    set_draft_stage(3);
    if (level.var_5be52892 == 1) {
        set_draft_stage(4);
    } else {
        set_draft_stage(5);
    }
    set_draft_stage(6);
    set_draft_stage(7);
}

// Namespace draft/draft
// Params 0, eflags: 0x0
// Checksum 0x7bc5016b, Offset: 0x3460
// Size: 0x19c
function open() {
    player = self;
    assert(isplayer(self));
    if (isdefined(level.var_edd52efc)) {
        self [[ level.var_edd52efc ]]();
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
// Checksum 0x60d17555, Offset: 0x3608
// Size: 0x44
function close() {
    player = self;
    player spectating::set_permissions();
    self clientfield::set_player_uimodel("PositionDraft.stage", 0);
}

