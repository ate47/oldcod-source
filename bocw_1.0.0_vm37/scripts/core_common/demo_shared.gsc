#using scripts\core_common\callbacks_shared;
#using scripts\core_common\potm_shared;
#using scripts\core_common\system_shared;

#namespace demo;

// Namespace demo/demo_shared
// Params 0, eflags: 0x6
// Checksum 0x78b23366, Offset: 0x78
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"demo", &preinit, undefined, undefined, undefined);
}

// Namespace demo/demo_shared
// Params 0, eflags: 0x4
// Checksum 0x732c8836, Offset: 0xc0
// Size: 0x54
function private preinit() {
    game.var_e9714926 = #"demo";
    callback::on_start_gametype(&init);
    level thread watch_actor_bookmarks();
}

// Namespace demo/demo_shared
// Params 0, eflags: 0x4
// Checksum 0x90ac58e0, Offset: 0x120
// Size: 0x14
function private init() {
    potm::function_d71338e4();
}

// Namespace demo/demo_shared
// Params 2, eflags: 0x4
// Checksum 0xea1a3ba9, Offset: 0x140
// Size: 0x8c
function private add_bookmark(bookmark, overrideentitycamera) {
    if (!isdefined(bookmark)) {
        return;
    }
    if (!isdefined(overrideentitycamera)) {
        overrideentitycamera = 0;
    }
    adddemobookmark(bookmark.var_900768bc.id, bookmark.time, bookmark.mainclientnum, bookmark.otherclientnum, bookmark.scoreeventpriority, bookmark.inflictorentnum, bookmark.inflictorenttype, bookmark.var_5f0256c4, overrideentitycamera);
}

// Namespace demo/demo_shared
// Params 5, eflags: 0x0
// Checksum 0x22f1fc38, Offset: 0x1d8
// Size: 0x84
function kill_bookmark(var_81538b15, var_f28fb772, einflictor, var_50d1e41a, overrideentitycamera) {
    bookmark = potm::function_5b1e9ed4(game.var_e9714926, #"kill", gettime(), var_81538b15, var_f28fb772, 0, einflictor, var_50d1e41a, overrideentitycamera);
    add_bookmark(bookmark, overrideentitycamera);
}

// Namespace demo/demo_shared
// Params 2, eflags: 0x0
// Checksum 0xa11d460c, Offset: 0x268
// Size: 0x6c
function function_651a5f4(var_81538b15, einflictor) {
    bookmark = potm::function_5b1e9ed4(game.var_e9714926, #"object_destroy", gettime(), var_81538b15, undefined, 0, einflictor);
    add_bookmark(bookmark);
}

// Namespace demo/demo_shared
// Params 5, eflags: 0x0
// Checksum 0x9f723f23, Offset: 0x2e0
// Size: 0x7c
function event_bookmark(bookmarkname, time, var_81538b15, scoreeventpriority, eventdata) {
    bookmark = potm::function_5b1e9ed4(game.var_e9714926, bookmarkname, time, var_81538b15, undefined, scoreeventpriority, undefined, undefined, 0, eventdata);
    add_bookmark(bookmark);
}

// Namespace demo/demo_shared
// Params 5, eflags: 0x0
// Checksum 0x327e3cdb, Offset: 0x368
// Size: 0x74
function bookmark(bookmarkname, time, var_81538b15, var_f28fb772, scoreeventpriority) {
    bookmark = potm::function_5b1e9ed4(game.var_e9714926, bookmarkname, time, var_81538b15, var_f28fb772, scoreeventpriority);
    add_bookmark(bookmark);
}

// Namespace demo/demo_shared
// Params 3, eflags: 0x0
// Checksum 0x5915d165, Offset: 0x3e8
// Size: 0xc4
function function_c6ae5fd6(bookmarkname, winningteamindex, losingteamindex) {
    bookmark = potm::function_5b1e9ed4(game.var_e9714926, bookmarkname, gettime(), undefined, undefined, 0);
    if (!isdefined(bookmark)) {
        println("<dev string:x38>" + bookmarkname + "<dev string:x5b>");
        return;
    }
    if (isdefined(winningteamindex)) {
        bookmark.mainclientnum = winningteamindex;
    }
    if (isdefined(losingteamindex)) {
        bookmark.otherclientnum = losingteamindex;
    }
    add_bookmark(bookmark);
}

// Namespace demo/demo_shared
// Params 3, eflags: 0x0
// Checksum 0x260c75de, Offset: 0x4b8
// Size: 0x5c
function initactorbookmarkparams(killtimescount, killtimemsec, killtimedelay) {
    level.actor_bookmark_kill_times_count = killtimescount;
    level.actor_bookmark_kill_times_msec = killtimemsec;
    level.actor_bookmark_kill_times_delay = killtimedelay;
    level.actorbookmarkparamsinitialized = 1;
}

// Namespace demo/demo_shared
// Params 0, eflags: 0x0
// Checksum 0x8d46078b, Offset: 0x520
// Size: 0x74
function reset_actor_bookmark_kill_times() {
    if (!isdefined(level.actorbookmarkparamsinitialized)) {
        return;
    }
    if (!isdefined(self.actor_bookmark_kill_times)) {
        self.actor_bookmark_kill_times = [];
        self.ignore_actor_kill_times = 0;
    }
    for (i = 0; i < level.actor_bookmark_kill_times_count; i++) {
        self.actor_bookmark_kill_times[i] = 0;
    }
}

// Namespace demo/demo_shared
// Params 0, eflags: 0x0
// Checksum 0x94d1ae31, Offset: 0x5a0
// Size: 0x10c
function add_actor_bookmark_kill_time() {
    if (!isdefined(self)) {
        return;
    }
    if (!isdefined(level.actorbookmarkparamsinitialized)) {
        return;
    }
    if (!isdefined(self.ignore_actor_kill_times)) {
        self reset_actor_bookmark_kill_times();
    }
    now = gettime();
    if (now <= self.ignore_actor_kill_times) {
        return;
    }
    oldest_index = 0;
    oldest_time = now + 1;
    for (i = 0; i < level.actor_bookmark_kill_times_count; i++) {
        if (!self.actor_bookmark_kill_times[i]) {
            oldest_index = i;
            break;
        }
        if (oldest_time > self.actor_bookmark_kill_times[i]) {
            oldest_index = i;
            oldest_time = self.actor_bookmark_kill_times[i];
        }
    }
    self.actor_bookmark_kill_times[oldest_index] = now;
}

// Namespace demo/demo_shared
// Params 0, eflags: 0x0
// Checksum 0xda9da01a, Offset: 0x6b8
// Size: 0x1e2
function watch_actor_bookmarks() {
    while (true) {
        if (!isdefined(level.actorbookmarkparamsinitialized)) {
            wait 0.5;
            continue;
        }
        waitframe(1);
        waittillframeend();
        now = gettime();
        oldest_allowed = now - level.actor_bookmark_kill_times_msec;
        players = getplayers();
        for (player_index = 0; player_index < players.size; player_index++) {
            player = players[player_index];
            /#
                if (isbot(player)) {
                    continue;
                }
            #/
            for (time_index = 0; time_index < level.actor_bookmark_kill_times_count; time_index++) {
                if (!isdefined(player.actor_bookmark_kill_times) || !player.actor_bookmark_kill_times[time_index]) {
                    break;
                }
                if (oldest_allowed > player.actor_bookmark_kill_times[time_index]) {
                    player.actor_bookmark_kill_times[time_index] = 0;
                    break;
                }
            }
            if (time_index >= level.actor_bookmark_kill_times_count) {
                bookmark(#"actor_kill", gettime(), player);
                potm::bookmark(#"actor_kill", gettime(), player);
                player reset_actor_bookmark_kill_times();
                player.ignore_actor_kill_times = now + level.actor_bookmark_kill_times_delay;
            }
        }
    }
}

