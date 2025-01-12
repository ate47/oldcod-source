#using script_243ea03c7a285692;
#using scripts\core_common\util_shared;

#namespace laststand;

// Namespace laststand/laststand_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x11a68780, Offset: 0x70
// Size: 0x1a
function player_is_in_laststand() {
    return is_true(self.laststand);
}

// Namespace laststand/laststand_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x39b5b7f2, Offset: 0x98
// Size: 0x6e
function player_num_in_laststand() {
    num = 0;
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (players[i] player_is_in_laststand()) {
            num++;
        }
    }
    return num;
}

// Namespace laststand/laststand_shared
// Params 0, eflags: 0x0
// Checksum 0xfe073139, Offset: 0x110
// Size: 0x26
function player_all_players_in_laststand() {
    return player_num_in_laststand() == getplayers().size;
}

// Namespace laststand/laststand_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x56dd5671, Offset: 0x140
// Size: 0x16
function player_any_player_in_laststand() {
    return player_num_in_laststand() > 0;
}

// Namespace laststand/laststand_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x6ed37ef8, Offset: 0x160
// Size: 0xf2
function function_7fb2bbfc() {
    var_5eb47b1d = [];
    foreach (player in function_a1ef346b()) {
        if (!player inlaststand()) {
            if (!isdefined(var_5eb47b1d)) {
                var_5eb47b1d = [];
            } else if (!isarray(var_5eb47b1d)) {
                var_5eb47b1d = array(var_5eb47b1d);
            }
            var_5eb47b1d[var_5eb47b1d.size] = player;
        }
    }
    return var_5eb47b1d;
}

// Namespace laststand/laststand_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x5da9eb3e, Offset: 0x260
// Size: 0x124
function is_facing(facee, requireddot = 0.9) {
    orientation = self getplayerangles();
    forwardvec = anglestoforward(orientation);
    forwardvec2d = (forwardvec[0], forwardvec[1], 0);
    unitforwardvec2d = vectornormalize(forwardvec2d);
    tofaceevec = facee.origin - self.origin;
    tofaceevec2d = (tofaceevec[0], tofaceevec[1], 0);
    unittofaceevec2d = vectornormalize(tofaceevec2d);
    dotproduct = vectordot(unitforwardvec2d, unittofaceevec2d);
    return dotproduct > requireddot;
}

// Namespace laststand/laststand_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x880ff7b2, Offset: 0x390
// Size: 0x7c
function revive_hud_create() {
    assert(isdefined(level.revive_hud));
    if (!level.revive_hud revive_hud::is_open(self)) {
        level.revive_hud revive_hud::open(self);
        self thread function_60e0ae8c();
    }
}

// Namespace laststand/laststand_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x2cc4b748, Offset: 0x418
// Size: 0x44
function function_60e0ae8c() {
    waitframe(1);
    if (isdefined(self) && isdefined(level.revive_hud)) {
        level.revive_hud revive_hud::set_fadetime(self, 0);
    }
}

// Namespace laststand/laststand_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x42a612ff, Offset: 0x468
// Size: 0x13c
function revive_hud_show_n_fade(text, time, player = undefined) {
    if (!is_true(level.var_dc60105c) && isdefined(level.revive_hud) && level.revive_hud revive_hud::is_open(self)) {
        level.revive_hud revive_hud::set_fadetime(self, 0);
        util::wait_network_frame();
        if (!isdefined(self)) {
            return;
        }
        level.revive_hud revive_hud::set_text(self, text);
        if (isdefined(player)) {
            level.revive_hud revive_hud::set_clientnum(self, player getentitynumber());
        }
        level.revive_hud revive_hud::set_fadetime(self, int(time * 10));
    }
}

/#

    // Namespace laststand/laststand_shared
    // Params 3, eflags: 0x0
    // Checksum 0xa335e178, Offset: 0x5b0
    // Size: 0x234
    function drawcylinder(pos, rad, height) {
        currad = rad;
        curheight = height;
        for (r = 0; r < 20; r++) {
            theta = r / 20 * 360;
            theta2 = (r + 1) / 20 * 360;
            line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta2) * currad, sin(theta2) * currad, 0));
            line(pos + (cos(theta) * currad, sin(theta) * currad, curheight), pos + (cos(theta2) * currad, sin(theta2) * currad, curheight));
            line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta) * currad, sin(theta) * currad, curheight));
        }
    }

#/

// Namespace laststand/laststand_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x7aeabacb, Offset: 0x7f0
// Size: 0x74
function function_d4c9e1b5() {
    self endon(#"player_revived", #"player_suicide", #"bled_out");
    self waittill(#"disconnect");
    if (isdefined(self.revivetrigger)) {
        self.revivetrigger delete();
    }
}

