#using scripts/core_common/callbacks_shared;
#using scripts/core_common/lui_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;

#namespace hud;

// Namespace hud/hud_shared
// Params 0, eflags: 0x2
// Checksum 0x8361db6f, Offset: 0x140
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("hud", &__init__, undefined, undefined);
}

// Namespace hud/hud_shared
// Params 0, eflags: 0x0
// Checksum 0xdbb3c249, Offset: 0x180
// Size: 0x24
function __init__() {
    callback::on_start_gametype(&init);
}

// Namespace hud/hud_shared
// Params 0, eflags: 0x0
// Checksum 0xdbaa1614, Offset: 0x1b0
// Size: 0x450
function init() {
    level.uiparent = spawnstruct();
    level.uiparent.horzalign = "left";
    level.uiparent.vertalign = "top";
    level.uiparent.alignx = "left";
    level.uiparent.aligny = "top";
    level.uiparent.x = 0;
    level.uiparent.y = 0;
    level.uiparent.width = 0;
    level.uiparent.height = 0;
    level.uiparent.children = [];
    level.fontheight = 12;
    foreach (team in level.teams) {
        level.hud[team] = spawnstruct();
    }
    level.primaryprogressbary = -61;
    level.primaryprogressbarx = 0;
    level.primaryprogressbarheight = 9;
    level.primaryprogressbarwidth = 120;
    level.primaryprogressbartexty = -75;
    level.primaryprogressbartextx = 0;
    level.primaryprogressbarfontsize = 1.4;
    if (level.splitscreen) {
        level.primaryprogressbarx = 20;
        level.primaryprogressbartextx = 20;
        level.primaryprogressbary = 15;
        level.primaryprogressbartexty = 0;
        level.primaryprogressbarheight = 2;
    }
    level.secondaryprogressbary = -85;
    level.secondaryprogressbarx = 0;
    level.secondaryprogressbarheight = 9;
    level.secondaryprogressbarwidth = 120;
    level.secondaryprogressbartexty = -100;
    level.secondaryprogressbartextx = 0;
    level.secondaryprogressbarfontsize = 1.4;
    if (level.splitscreen) {
        level.secondaryprogressbarx = 20;
        level.secondaryprogressbartextx = 20;
        level.secondaryprogressbary = 15;
        level.secondaryprogressbartexty = 0;
        level.secondaryprogressbarheight = 2;
    }
    level.teamprogressbary = 32;
    level.teamprogressbarheight = 14;
    level.teamprogressbarwidth = 192;
    level.teamprogressbartexty = 8;
    level.teamprogressbarfontsize = 1.65;
    setdvar("ui_generic_status_bar", 0);
    if (level.splitscreen) {
        level.lowertextyalign = "BOTTOM";
        level.lowertexty = -42;
        level.lowertextfontsize = 1.4;
        return;
    }
    level.lowertextyalign = "CENTER";
    level.lowertexty = 40;
    level.lowertextfontsize = 1.4;
}

// Namespace hud/hud_shared
// Params 0, eflags: 0x0
// Checksum 0xe01c0382, Offset: 0x608
// Size: 0x54
function function_1ad5c13d() {
    self.basefontscale = self.fontscale;
    self.maxfontscale = self.fontscale * 2;
    self.inframes = 1.5;
    self.outframes = 3;
}

// Namespace hud/hud_shared
// Params 1, eflags: 0x0
// Checksum 0xcac47ac, Offset: 0x668
// Size: 0x198
function function_5e2578bc(player) {
    self notify(#"fontpulse");
    self endon(#"fontpulse");
    self endon(#"death");
    player endon(#"disconnect");
    player endon(#"joined_team");
    player endon(#"joined_spectators");
    if (self.outframes == 0) {
        self.fontscale = 0.01;
    } else {
        self.fontscale = self.fontscale;
    }
    if (self.inframes > 0) {
        self changefontscaleovertime(self.inframes * 0.05);
        self.fontscale = self.maxfontscale;
        waitframe(self.inframes);
    } else {
        self.fontscale = self.maxfontscale;
        self.alpha = 0;
        self fadeovertime(self.outframes * 0.05);
        self.alpha = 1;
    }
    if (self.outframes > 0) {
        self changefontscaleovertime(self.outframes * 0.05);
        self.fontscale = self.basefontscale;
    }
}

// Namespace hud/hud_shared
// Params 5, eflags: 0x0
// Checksum 0xe8015f9d, Offset: 0x808
// Size: 0x7c
function fade_to_black_for_x_sec(startwait, blackscreenwait, fadeintime, fadeouttime, shadername) {
    self endon(#"disconnect");
    wait startwait;
    lui::screen_fade_out(fadeintime, shadername);
    wait blackscreenwait;
    lui::screen_fade_in(fadeouttime, shadername);
}

// Namespace hud/hud_shared
// Params 1, eflags: 0x0
// Checksum 0xab478101, Offset: 0x890
// Size: 0x24
function screen_fade_in(fadeintime) {
    lui::screen_fade_in(fadeintime);
}

