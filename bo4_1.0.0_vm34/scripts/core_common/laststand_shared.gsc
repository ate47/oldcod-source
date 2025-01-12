#using script_243ea03c7a285692;

#namespace laststand;

// Namespace laststand/laststand_shared
// Params 0, eflags: 0x0
// Checksum 0x43dbdf1c, Offset: 0x70
// Size: 0x18
function player_is_in_laststand() {
    return isdefined(self.laststand) && self.laststand;
}

// Namespace laststand/laststand_shared
// Params 0, eflags: 0x0
// Checksum 0xf7ccd655, Offset: 0x90
// Size: 0x7a
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
// Checksum 0xd138ddaa, Offset: 0x118
// Size: 0x26
function player_all_players_in_laststand() {
    return player_num_in_laststand() == getplayers().size;
}

// Namespace laststand/laststand_shared
// Params 0, eflags: 0x0
// Checksum 0x2ac7fe48, Offset: 0x148
// Size: 0x16
function player_any_player_in_laststand() {
    return player_num_in_laststand() > 0;
}

// Namespace laststand/laststand_shared
// Params 2, eflags: 0x0
// Checksum 0x572de149, Offset: 0x168
// Size: 0x130
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
// Params 0, eflags: 0x0
// Checksum 0xc61a93af, Offset: 0x2a0
// Size: 0x8c
function revive_hud_create() {
    assert(isdefined(level.revive_hud));
    if (!level.revive_hud revive_hud::is_open(self)) {
        level.revive_hud revive_hud::open(self);
        waitframe(1);
        level.revive_hud revive_hud::set_fadetime(self, 0);
    }
}

// Namespace laststand/laststand_shared
// Params 3, eflags: 0x0
// Checksum 0x73519b34, Offset: 0x338
// Size: 0x12c
function revive_hud_show_n_fade(text, time, player = undefined) {
    if (!(isdefined(level.var_fc04f28d) && level.var_fc04f28d) && isdefined(level.revive_hud) && level.revive_hud revive_hud::is_open(self)) {
        level.revive_hud revive_hud::set_fadetime(self, 0);
        waitframe(1);
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
    // Checksum 0x75d655a6, Offset: 0x470
    // Size: 0x23e
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
// Params 0, eflags: 0x0
// Checksum 0x9d926cd7, Offset: 0x6b8
// Size: 0x74
function function_692e99d6() {
    self endon(#"player_revived", #"player_suicide", #"bled_out");
    self waittill(#"disconnect");
    if (isdefined(self.revivetrigger)) {
        self.revivetrigger delete();
    }
}

