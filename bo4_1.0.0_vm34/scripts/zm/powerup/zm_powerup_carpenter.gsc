#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_blockers;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_utility;

#namespace zm_powerup_carpenter;

// Namespace zm_powerup_carpenter/zm_powerup_carpenter
// Params 0, eflags: 0x2
// Checksum 0x91ac69db, Offset: 0x158
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_powerup_carpenter", &__init__, undefined, undefined);
}

// Namespace zm_powerup_carpenter/zm_powerup_carpenter
// Params 0, eflags: 0x0
// Checksum 0x3c16a1b8, Offset: 0x1a0
// Size: 0x84
function __init__() {
    zm_powerups::register_powerup("carpenter", &grab_carpenter);
    if (zm_powerups::function_b2585f85()) {
        zm_powerups::add_zombie_powerup("carpenter", "p7_zm_power_up_carpenter", #"zombie/powerup_max_ammo", &func_should_drop_carpenter, 0, 0, 0);
    }
}

// Namespace zm_powerup_carpenter/zm_powerup_carpenter
// Params 1, eflags: 0x0
// Checksum 0x170bf120, Offset: 0x230
// Size: 0x70
function grab_carpenter(e_player) {
    level thread start_carpenter(e_player);
    e_player thread zm_powerups::powerup_vo("carpenter");
    level notify(#"carpenter_started", {#var_b5a9d4:e_player});
}

// Namespace zm_powerup_carpenter/zm_powerup_carpenter
// Params 2, eflags: 0x0
// Checksum 0x219b713c, Offset: 0x2a8
// Size: 0x11c
function get_closest_window_repair(windows, origin) {
    current_window = undefined;
    shortest_distance = undefined;
    for (i = 0; i < windows.size; i++) {
        if (zm_utility::all_chunks_intact(windows, windows[i].barrier_chunks)) {
            continue;
        }
        if (!isdefined(current_window)) {
            current_window = windows[i];
            shortest_distance = distancesquared(current_window.origin, origin);
            continue;
        }
        if (distancesquared(windows[i].origin, origin) < shortest_distance) {
            current_window = windows[i];
            shortest_distance = distancesquared(windows[i].origin, origin);
        }
    }
    return current_window;
}

// Namespace zm_powerup_carpenter/zm_powerup_carpenter
// Params 1, eflags: 0x0
// Checksum 0x5be1c699, Offset: 0x3d0
// Size: 0x4da
function start_carpenter(var_b5a9d4) {
    level.carpenter_powerup_active = 1;
    carp_ent = spawn("script_origin", (0, 0, 0));
    carp_ent playloopsound(#"evt_carpenter");
    if (zm_custom::function_5638f689(#"zmbarricadestate")) {
        window_boards = struct::get_array("exterior_goal", "targetname");
        if (isdefined(level._additional_carpenter_nodes)) {
            window_boards = arraycombine(window_boards, level._additional_carpenter_nodes, 0, 0);
        }
        boards_near_players = get_near_boards(window_boards);
        boards_far_from_players = get_far_boards(window_boards);
        level repair_far_boards(boards_far_from_players);
        for (i = 0; i < boards_near_players.size; i++) {
            window = boards_near_players[i];
            num_chunks_checked = 0;
            last_repaired_chunk = undefined;
            while (true) {
                if (zm_utility::all_chunks_intact(window, window.barrier_chunks)) {
                    break;
                }
                chunk = zm_utility::get_random_destroyed_chunk(window, window.barrier_chunks);
                if (!isdefined(chunk)) {
                    break;
                }
                window thread zm_blockers::replace_chunk(window, chunk, 1);
                last_repaired_chunk = chunk;
                if (isdefined(window.clip)) {
                    window.clip triggerenable(1);
                    window.clip disconnectpaths();
                } else {
                    zm_blockers::blocker_disconnect_paths(window.neg_start, window.neg_end);
                }
                util::wait_network_frame();
                num_chunks_checked++;
                if (num_chunks_checked >= 20) {
                    break;
                }
            }
            if (isdefined(window.zbarrier)) {
                if (isdefined(last_repaired_chunk)) {
                    while (window.zbarrier getzbarrierpiecestate(last_repaired_chunk) == "closing") {
                        waitframe(1);
                    }
                    if (isdefined(window._post_carpenter_callback)) {
                        window [[ window._post_carpenter_callback ]]();
                    }
                }
                continue;
            }
            while (isdefined(last_repaired_chunk) && last_repaired_chunk.state == "mid_repair") {
                waitframe(1);
            }
        }
    }
    carp_ent stoploopsound(1);
    carp_ent playsoundwithnotify("evt_carpenter_end", "sound_done");
    carp_ent waittill(#"sound_done");
    if (zm_powerups::function_ffd24ecc(#"carpenter") && isplayer(var_b5a9d4)) {
        var_b5a9d4 zm_score::player_add_points("carpenter_powerup", 200, undefined, undefined, undefined, undefined, 1);
    } else {
        foreach (e_player in level.players) {
            e_player zm_score::player_add_points("carpenter_powerup", 200, undefined, undefined, undefined, undefined, 1);
        }
    }
    carp_ent delete();
    level notify(#"carpenter_finished");
    level.carpenter_powerup_active = undefined;
}

// Namespace zm_powerup_carpenter/zm_powerup_carpenter
// Params 1, eflags: 0x0
// Checksum 0x34b31191, Offset: 0x8b8
// Size: 0x14c
function get_near_boards(windows) {
    players = getplayers();
    boards_near_players = [];
    for (j = 0; j < windows.size; j++) {
        close = 0;
        for (i = 0; i < players.size; i++) {
            origin = undefined;
            if (isdefined(windows[j].zbarrier)) {
                origin = windows[j].zbarrier.origin;
            } else {
                origin = windows[j].origin;
            }
            if (distancesquared(players[i].origin, origin) <= 562500) {
                close = 1;
                break;
            }
        }
        if (close) {
            boards_near_players[boards_near_players.size] = windows[j];
        }
    }
    return boards_near_players;
}

// Namespace zm_powerup_carpenter/zm_powerup_carpenter
// Params 1, eflags: 0x0
// Checksum 0x3705d546, Offset: 0xa10
// Size: 0x14c
function get_far_boards(windows) {
    players = getplayers();
    boards_far_from_players = [];
    for (j = 0; j < windows.size; j++) {
        close = 0;
        for (i = 0; i < players.size; i++) {
            origin = undefined;
            if (isdefined(windows[j].zbarrier)) {
                origin = windows[j].zbarrier.origin;
            } else {
                origin = windows[j].origin;
            }
            if (distancesquared(players[i].origin, origin) >= 562500) {
                close = 1;
                break;
            }
        }
        if (close) {
            boards_far_from_players[boards_far_from_players.size] = windows[j];
        }
    }
    return boards_far_from_players;
}

// Namespace zm_powerup_carpenter/zm_powerup_carpenter
// Params 1, eflags: 0x0
// Checksum 0xbe9329c7, Offset: 0xb68
// Size: 0x24e
function repair_far_boards(barriers) {
    for (i = 0; i < barriers.size; i++) {
        barrier = barriers[i];
        if (zm_utility::all_chunks_intact(barrier, barrier.barrier_chunks)) {
            continue;
        }
        if (isdefined(barrier.zbarrier)) {
            a_pieces = barrier.zbarrier getzbarrierpieceindicesinstate("open");
            if (isdefined(a_pieces)) {
                for (xx = 0; xx < a_pieces.size; xx++) {
                    chunk = a_pieces[xx];
                    barrier.zbarrier zbarrierpieceusedefaultmodel(chunk);
                    barrier.zbarrier.chunk_health[chunk] = 0;
                }
            }
            for (x = 0; x < barrier.zbarrier getnumzbarrierpieces(); x++) {
                barrier.zbarrier setzbarrierpiecestate(x, "closed");
                barrier.zbarrier showzbarrierpiece(x);
            }
        }
        if (isdefined(barrier.clip)) {
            barrier.clip triggerenable(1);
            barrier.clip disconnectpaths();
        } else {
            zm_blockers::blocker_disconnect_paths(barrier.neg_start, barrier.neg_end);
        }
        if (i % 4 == 0) {
            util::wait_network_frame();
        }
    }
}

// Namespace zm_powerup_carpenter/zm_powerup_carpenter
// Params 0, eflags: 0x0
// Checksum 0x46e66057, Offset: 0xdc0
// Size: 0x48
function func_should_drop_carpenter() {
    if (get_num_window_destroyed() < 5 && !(isdefined(level.var_336e4c03) && level.var_336e4c03)) {
        return false;
    }
    return true;
}

// Namespace zm_powerup_carpenter/zm_powerup_carpenter
// Params 0, eflags: 0x0
// Checksum 0x70d78046, Offset: 0xe10
// Size: 0x8a
function get_num_window_destroyed() {
    num = 0;
    for (i = 0; i < level.exterior_goals.size; i++) {
        if (zm_utility::all_chunks_destroyed(level.exterior_goals[i], level.exterior_goals[i].barrier_chunks)) {
            num += 1;
        }
    }
    return num;
}

