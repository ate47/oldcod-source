#using scripts\core_common\callbacks_shared;
#using scripts\core_common\potm_shared;
#using scripts\core_common\system_shared;

#namespace demo;

// Namespace demo/demo_shared
// Params 0, eflags: 0x2
// Checksum 0xae73dc0f, Offset: 0x80
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"demo", &__init__, undefined, undefined);
}

// Namespace demo/demo_shared
// Params 0, eflags: 0x0
// Checksum 0xc17b87f6, Offset: 0xc8
// Size: 0x54
function __init__() {
    game.var_51a30ea5 = #"demo";
    callback::on_start_gametype(&init);
    level thread watch_actor_bookmarks();
}

// Namespace demo/demo_shared
// Params 0, eflags: 0x4
// Checksum 0x70491c79, Offset: 0x128
// Size: 0x14
function private init() {
    potm::function_2a4c0867();
}

// Namespace demo/demo_shared
// Params 2, eflags: 0x4
// Checksum 0xf0fe99d, Offset: 0x148
// Size: 0xa4
function private add_bookmark(bookmark, overrideentitycamera) {
    if (!isdefined(bookmark)) {
        return;
    }
    if (!isdefined(overrideentitycamera)) {
        overrideentitycamera = 0;
    }
    adddemobookmark(bookmark.var_a2e574d8.id, bookmark.time, bookmark.mainclientnum, bookmark.otherclientnum, bookmark.scoreeventpriority, bookmark.inflictorentnum, bookmark.inflictorenttype, bookmark.var_96ec641c, overrideentitycamera);
}

// Namespace demo/demo_shared
// Params 5, eflags: 0x0
// Checksum 0xa8853a13, Offset: 0x1f8
// Size: 0x8c
function kill_bookmark(var_cf6a9c68, var_e6df0461, einflictor, var_fc963626, overrideentitycamera) {
    bookmark = potm::function_e778864(game.var_51a30ea5, #"kill", gettime(), var_cf6a9c68, var_e6df0461, 0, einflictor, var_fc963626, overrideentitycamera);
    add_bookmark(bookmark, overrideentitycamera);
}

// Namespace demo/demo_shared
// Params 2, eflags: 0x0
// Checksum 0x9b85a8cb, Offset: 0x290
// Size: 0x6c
function function_fed85dee(var_cf6a9c68, einflictor) {
    bookmark = potm::function_e778864(game.var_51a30ea5, #"object_destroy", gettime(), var_cf6a9c68, undefined, 0, einflictor);
    add_bookmark(bookmark);
}

// Namespace demo/demo_shared
// Params 5, eflags: 0x0
// Checksum 0xf42d2717, Offset: 0x308
// Size: 0x84
function event_bookmark(bookmarkname, time, var_cf6a9c68, scoreeventpriority, eventdata) {
    bookmark = potm::function_e778864(game.var_51a30ea5, bookmarkname, time, var_cf6a9c68, undefined, scoreeventpriority, undefined, undefined, 0, eventdata);
    add_bookmark(bookmark);
}

// Namespace demo/demo_shared
// Params 5, eflags: 0x0
// Checksum 0x72627ff9, Offset: 0x398
// Size: 0x7c
function bookmark(bookmarkname, time, var_cf6a9c68, var_e6df0461, scoreeventpriority) {
    bookmark = potm::function_e778864(game.var_51a30ea5, bookmarkname, time, var_cf6a9c68, var_e6df0461, scoreeventpriority);
    add_bookmark(bookmark);
}

// Namespace demo/demo_shared
// Params 3, eflags: 0x0
// Checksum 0xf49d2b95, Offset: 0x420
// Size: 0xcc
function function_dc6e0ae8(bookmarkname, winningteamindex, losingteamindex) {
    bookmark = potm::function_e778864(game.var_51a30ea5, bookmarkname, gettime(), undefined, undefined, 0);
    if (!isdefined(bookmark)) {
        println("<dev string:x30>" + bookmarkname + "<dev string:x50>");
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
// Checksum 0xfb70c91e, Offset: 0x4f8
// Size: 0x5a
function initactorbookmarkparams(killtimescount, killtimemsec, killtimedelay) {
    level.actor_bookmark_kill_times_count = killtimescount;
    level.actor_bookmark_kill_times_msec = killtimemsec;
    level.actor_bookmark_kill_times_delay = killtimedelay;
    level.actorbookmarkparamsinitialized = 1;
}

// Namespace demo/demo_shared
// Params 0, eflags: 0x0
// Checksum 0x816f7b41, Offset: 0x560
// Size: 0x78
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
// Checksum 0xc2534591, Offset: 0x5e0
// Size: 0xe6
function add_actor_bookmark_kill_time() {
    if (!isdefined(level.actorbookmarkparamsinitialized)) {
        return;
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
// Checksum 0x7e2c0af, Offset: 0x6d0
// Size: 0x1fc
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

