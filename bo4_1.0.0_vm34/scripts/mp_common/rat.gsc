#using scripts\core_common\bots\bot;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\rat_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\gametypes\dev;
#using scripts\mp_common\util;

#namespace rat;

/#

    // Namespace rat/rat
    // Params 0, eflags: 0x2
    // Checksum 0x5ed41d79, Offset: 0xa0
    // Size: 0x3c
    function autoexec __init__system__() {
        system::register(#"rat", &__init__, undefined, undefined);
    }

    // Namespace rat/rat
    // Params 0, eflags: 0x0
    // Checksum 0x1953734d, Offset: 0xe8
    // Size: 0xc4
    function __init__() {
        init();
        level.rat.common.gethostplayer = &util::gethostplayer;
        level.rat.deathcount = 0;
        addratscriptcmd("<dev string:x30>", &rscaddenemy);
        addratscriptcmd("<dev string:x39>", &function_f8df2823);
        setdvar(#"rat_death_count", 0);
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x11f09921, Offset: 0x1b8
    // Size: 0x11e
    function function_f8df2823(params) {
        player = util::gethostplayerforbots();
        setdvar(#"bot_allowmovement", 0);
        setdvar(#"bot_pressattackbtn", 0);
        setdvar(#"bot_pressmeleebtn", 0);
        setdvar(#"scr_botsallowkillstreaks", 0);
        setdvar(#"bot_allowgrenades", 0);
        team = bot::devgui_relative_team(player, "<dev string:x47>");
        bot = level bot::add_bot(team);
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0x76786545, Offset: 0x2e0
    // Size: 0x254
    function rscaddenemy(params) {
        player = [[ level.rat.common.gethostplayer ]]();
        team = #"axis";
        if (isdefined(player.pers[#"team"])) {
            team = util::getotherteam(player.pers[#"team"]);
        }
        bot = dev::getormakebot(team);
        if (!isdefined(bot)) {
            println("<dev string:x4d>");
            ratreportcommandresult(params._id, 0, "<dev string:x4d>");
            return;
        }
        bot thread testenemy(team);
        bot thread deathcounter();
        wait 2;
        pos = (float(params.x), float(params.y), float(params.z));
        bot setorigin(pos);
        if (isdefined(params.ax)) {
            angles = (float(params.ax), float(params.ay), float(params.az));
            bot setplayerangles(angles);
        }
        ratreportcommandresult(params._id, 1);
    }

    // Namespace rat/rat
    // Params 1, eflags: 0x0
    // Checksum 0xdd2e7811, Offset: 0x540
    // Size: 0xf4
    function testenemy(team) {
        self endon(#"disconnect");
        while (!isdefined(self.pers[#"team"])) {
            waitframe(1);
        }
        if (level.teambased) {
            params = {#menu:game.menu[#"menu_team"], #response:level.teams[team], #intpayload:0};
            self notify(#"menuresponse", params);
            self callback::callback(#"menu_response", params);
        }
    }

    // Namespace rat/rat
    // Params 0, eflags: 0x0
    // Checksum 0x3da3059c, Offset: 0x640
    // Size: 0x5c
    function deathcounter() {
        self waittill(#"death");
        level.rat.deathcount++;
        setdvar(#"rat_death_count", level.rat.deathcount);
    }

#/
