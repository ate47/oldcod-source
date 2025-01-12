#using scripts/core_common/flag_shared;
#using scripts/core_common/hud_util_shared;
#using scripts/core_common/struct;
#using scripts/core_common/util_shared;

#namespace laststand;

// Namespace laststand/laststand_shared
// Params 0, eflags: 0x0
// Checksum 0xdd21f338, Offset: 0x1b0
// Size: 0x4c
function player_is_in_laststand() {
    if (!(isdefined(self.no_revive_trigger) && self.no_revive_trigger)) {
        return isdefined(self.revivetrigger);
    }
    return isdefined(self.laststand) && self.laststand;
}

// Namespace laststand/laststand_shared
// Params 0, eflags: 0x0
// Checksum 0x286a9c18, Offset: 0x208
// Size: 0x82
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
// Checksum 0x75a81973, Offset: 0x298
// Size: 0x26
function player_all_players_in_laststand() {
    return player_num_in_laststand() == getplayers().size;
}

// Namespace laststand/laststand_shared
// Params 0, eflags: 0x0
// Checksum 0xe378d03, Offset: 0x2c8
// Size: 0x16
function player_any_player_in_laststand() {
    return player_num_in_laststand() > 0;
}

// Namespace laststand/laststand_shared
// Params 3, eflags: 0x0
// Checksum 0xec02ae9c, Offset: 0x2e8
// Size: 0x3c
function function_cd4ced7a(sweapon, smeansofdeath, shitloc) {
    if (level.laststandpistol == "none") {
        return false;
    }
    return true;
}

// Namespace laststand/laststand_shared
// Params 0, eflags: 0x0
// Checksum 0x435c3786, Offset: 0x330
// Size: 0x96
function function_4a66f284() {
    if (isdefined(self.suicideprompt)) {
        self.suicideprompt destroy();
        self.suicideprompt = undefined;
    }
    if (isdefined(self.var_292c9541)) {
        self.var_292c9541 destroy();
        self.var_292c9541 = undefined;
    }
    if (isdefined(self.var_af0e0d25)) {
        self.var_af0e0d25 hud::destroyelem();
        self.var_af0e0d25 = undefined;
    }
}

// Namespace laststand/laststand_shared
// Params 0, eflags: 0x0
// Checksum 0xc3ab7b21, Offset: 0x3d0
// Size: 0x64
function function_9a3e66fc() {
    self endon(#"disconnect");
    self endon(#"stop_revive_trigger");
    self endon(#"player_revived");
    self endon(#"bled_out");
    level waittill("game_ended", "stop_suicide_trigger");
    self function_4a66f284();
}

// Namespace laststand/laststand_shared
// Params 0, eflags: 0x0
// Checksum 0x4c2025e8, Offset: 0x440
// Size: 0x4c
function function_a5c40dbc() {
    self endon(#"disconnect");
    self endon(#"stop_revive_trigger");
    self waittill("bled_out", "player_revived", "fake_death");
    self function_4a66f284();
}

// Namespace laststand/laststand_shared
// Params 2, eflags: 0x0
// Checksum 0x76b1c762, Offset: 0x498
// Size: 0x15a
function is_facing(facee, requireddot) {
    if (!isdefined(requireddot)) {
        requireddot = 0.9;
    }
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
// Checksum 0xca72f917, Offset: 0x600
// Size: 0x15c
function revive_hud_create() {
    if (isdefined(self.revive_hud)) {
        return;
    }
    self.revive_hud = newclienthudelem(self);
    self.revive_hud.alignx = "center";
    self.revive_hud.aligny = "middle";
    self.revive_hud.horzalign = "center";
    self.revive_hud.vertalign = "bottom";
    self.revive_hud.foreground = 1;
    self.revive_hud.font = "default";
    self.revive_hud.fontscale = 1.5;
    self.revive_hud.alpha = 0;
    self.revive_hud.color = (1, 1, 1);
    self.revive_hud.hidewheninmenu = 1;
    self.revive_hud settext("");
    self.revive_hud.y = -148;
}

// Namespace laststand/laststand_shared
// Params 0, eflags: 0x0
// Checksum 0x503bf861, Offset: 0x768
// Size: 0x54
function function_89c586ec() {
    /#
        assert(isdefined(self));
    #/
    /#
        assert(isdefined(self.revive_hud));
    #/
    self.revive_hud.alpha = 1;
}

// Namespace laststand/laststand_shared
// Params 1, eflags: 0x0
// Checksum 0xb8cb6a99, Offset: 0x7c8
// Size: 0x50
function revive_hud_show_n_fade(time) {
    function_89c586ec();
    self.revive_hud fadeovertime(time);
    self.revive_hud.alpha = 0;
}

/#

    // Namespace laststand/laststand_shared
    // Params 3, eflags: 0x0
    // Checksum 0xdcc79d48, Offset: 0x820
    // Size: 0x25e
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
// Checksum 0x2ff8884d, Offset: 0xa88
// Size: 0x86
function function_fa369ede() {
    /#
        assert(level.var_da98bf76, "<dev string:x28>");
    #/
    if (level.var_da98bf76 && isdefined(self.var_5ad7ff7e) && isdefined(self.var_5ad7ff7e.var_5aa0f5d3)) {
        return max(0, self.var_5ad7ff7e.var_5aa0f5d3);
    }
    return 0;
}

// Namespace laststand/laststand_shared
// Params 1, eflags: 0x0
// Checksum 0xffa62386, Offset: 0xb18
// Size: 0xe2
function function_cd85ffaf(increment) {
    /#
        assert(level.var_da98bf76, "<dev string:x28>");
    #/
    /#
        assert(isdefined(increment), "<dev string:x56>");
    #/
    increment = isdefined(increment) ? increment : 0;
    self.var_5ad7ff7e.var_5aa0f5d3 = max(0, increment ? self.var_5ad7ff7e.var_5aa0f5d3 + 1 : self.var_5ad7ff7e.var_5aa0f5d3 - 1);
    self notify(#"hash_e4b1bf1f");
}

// Namespace laststand/laststand_shared
// Params 0, eflags: 0x0
// Checksum 0xf3368ce, Offset: 0xc08
// Size: 0x50
function function_590a49b2() {
    /#
        println("<dev string:x7b>");
    #/
    self.var_5ad7ff7e = spawnstruct();
    self.var_5ad7ff7e.var_5aa0f5d3 = 0;
}

// Namespace laststand/laststand_shared
// Params 0, eflags: 0x0
// Checksum 0xa88daf72, Offset: 0xc60
// Size: 0x94
function function_5d050fca() {
    self endon(#"player_revived");
    self endon(#"disconnect");
    while (true) {
        self waittill("damage");
        self.var_5ad7ff7e.var_8b479de8 -= 0.1;
        if (self.var_5ad7ff7e.var_8b479de8 < 0) {
            self.var_5ad7ff7e.var_8b479de8 = 0;
        }
    }
}

// Namespace laststand/laststand_shared
// Params 0, eflags: 0x0
// Checksum 0xaf486451, Offset: 0xd00
// Size: 0x196
function function_5006c91f() {
    self endon(#"player_revived");
    self endon(#"disconnect");
    hudelem = newclienthudelem(self);
    hudelem.alignx = "left";
    hudelem.aligny = "middle";
    hudelem.horzalign = "left";
    hudelem.vertalign = "middle";
    hudelem.x = 5;
    hudelem.y = 170;
    hudelem.font = "big";
    hudelem.fontscale = 1.5;
    hudelem.foreground = 1;
    hudelem.hidewheninmenu = 1;
    hudelem.hidewhendead = 1;
    hudelem.sort = 2;
    hudelem.label = %SO_WAR_LASTSTAND_GETUP_BAR;
    self thread function_fed0ee90(hudelem);
    while (true) {
        hudelem setvalue(self.var_5ad7ff7e.var_8b479de8);
        waitframe(1);
    }
}

// Namespace laststand/laststand_shared
// Params 1, eflags: 0x0
// Checksum 0x8034f295, Offset: 0xea0
// Size: 0x4c
function function_fed0ee90(hudelem) {
    self util::waittill_either("player_revived", "disconnect");
    hudelem destroy();
}

// Namespace laststand/laststand_shared
// Params 0, eflags: 0x0
// Checksum 0x496d781f, Offset: 0xef8
// Size: 0x6c
function function_d4eb424f() {
    self endon(#"player_revived");
    self endon(#"player_suicide");
    self endon(#"bled_out");
    trig = self.revivetrigger;
    self waittill("disconnect");
    if (isdefined(trig)) {
        trig delete();
    }
}

