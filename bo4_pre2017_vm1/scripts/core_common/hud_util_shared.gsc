#using scripts/core_common/lui_shared;
#using scripts/core_common/struct;
#using scripts/core_common/util_shared;

#namespace hud;

// Namespace hud/hud_util_shared
// Params 1, eflags: 0x0
// Checksum 0xe1bc8985, Offset: 0x2f0
// Size: 0xf4
function setparent(element) {
    if (isdefined(self.parent) && self.parent == element) {
        return;
    }
    if (isdefined(self.parent)) {
        self.parent removechild(self);
    }
    self.parent = element;
    self.parent addchild(self);
    if (isdefined(self.point)) {
        self setpoint(self.point, self.relativepoint, self.xoffset, self.yoffset);
        return;
    }
    self setpoint("TOP");
}

// Namespace hud/hud_util_shared
// Params 0, eflags: 0x0
// Checksum 0x77d6369d, Offset: 0x3f0
// Size: 0xe
function getparent() {
    return self.parent;
}

// Namespace hud/hud_util_shared
// Params 1, eflags: 0x0
// Checksum 0x1aef2914, Offset: 0x408
// Size: 0x46
function addchild(element) {
    element.index = self.children.size;
    self.children[self.children.size] = element;
}

// Namespace hud/hud_util_shared
// Params 1, eflags: 0x0
// Checksum 0x84117f08, Offset: 0x458
// Size: 0xca
function removechild(element) {
    element.parent = undefined;
    if (self.children[self.children.size - 1] != element) {
        self.children[element.index] = self.children[self.children.size - 1];
        self.children[element.index].index = element.index;
    }
    self.children[self.children.size - 1] = undefined;
    element.index = undefined;
}

// Namespace hud/hud_util_shared
// Params 5, eflags: 0x0
// Checksum 0xd8440672, Offset: 0x530
// Size: 0x84c
function setpoint(point, relativepoint, xoffset, yoffset, movetime) {
    if (!isdefined(movetime)) {
        movetime = 0;
    }
    element = self getparent();
    if (movetime) {
        self moveovertime(movetime);
    }
    if (!isdefined(xoffset)) {
        xoffset = 0;
    }
    self.xoffset = xoffset;
    if (!isdefined(yoffset)) {
        yoffset = 0;
    }
    self.yoffset = yoffset;
    self.point = point;
    self.alignx = "center";
    self.aligny = "middle";
    switch (point) {
    case #"center":
        break;
    case #"top":
        self.aligny = "top";
        break;
    case #"bottom":
        self.aligny = "bottom";
        break;
    case #"left":
        self.alignx = "left";
        break;
    case #"right":
        self.alignx = "right";
        break;
    case #"topright":
    case #"top_right":
        self.aligny = "top";
        self.alignx = "right";
        break;
    case #"topleft":
    case #"top_left":
        self.aligny = "top";
        self.alignx = "left";
        break;
    case #"topcenter":
        self.aligny = "top";
        self.alignx = "center";
        break;
    case #"BOTTOM RIGHT":
    case #"bottom_right":
        self.aligny = "bottom";
        self.alignx = "right";
        break;
    case #"BOTTOM LEFT":
    case #"bottom_left":
        self.aligny = "bottom";
        self.alignx = "left";
        break;
    default:
        println("<dev string:x28>" + point);
        break;
    }
    if (!isdefined(relativepoint)) {
        relativepoint = point;
    }
    self.relativepoint = relativepoint;
    relativex = "center";
    relativey = "middle";
    switch (relativepoint) {
    case #"center":
        break;
    case #"top":
        relativey = "top";
        break;
    case #"bottom":
        relativey = "bottom";
        break;
    case #"left":
        relativex = "left";
        break;
    case #"right":
        relativex = "right";
        break;
    case #"topright":
    case #"top_right":
        relativey = "top";
        relativex = "right";
        break;
    case #"topleft":
    case #"top_left":
        relativey = "top";
        relativex = "left";
        break;
    case #"topcenter":
        relativey = "top";
        relativex = "center";
        break;
    case #"BOTTOM RIGHT":
    case #"bottom_right":
        relativey = "bottom";
        relativex = "right";
        break;
    case #"BOTTOM LEFT":
    case #"bottom_left":
        relativey = "bottom";
        relativex = "left";
        break;
    default:
        println("<dev string:x58>" + relativepoint);
        break;
    }
    if (element == level.uiparent) {
        self.horzalign = relativex;
        self.vertalign = relativey;
    } else {
        self.horzalign = element.horzalign;
        self.vertalign = element.vertalign;
    }
    if (relativex == element.alignx) {
        offsetx = 0;
        xfactor = 0;
    } else if (relativex == "center" || element.alignx == "center") {
        offsetx = int(element.width / 2);
        if (relativex == "left" || element.alignx == "right") {
            xfactor = -1;
        } else {
            xfactor = 1;
        }
    } else {
        offsetx = element.width;
        if (relativex == "left") {
            xfactor = -1;
        } else {
            xfactor = 1;
        }
    }
    self.x = element.x + offsetx * xfactor;
    if (relativey == element.aligny) {
        offsety = 0;
        yfactor = 0;
    } else if (relativey == "middle" || element.aligny == "middle") {
        offsety = int(element.height / 2);
        if (relativey == "top" || element.aligny == "bottom") {
            yfactor = -1;
        } else {
            yfactor = 1;
        }
    } else {
        offsety = element.height;
        if (relativey == "top") {
            yfactor = -1;
        } else {
            yfactor = 1;
        }
    }
    self.y = element.y + offsety * yfactor;
    self.x += self.xoffset;
    self.y += self.yoffset;
    switch (self.elemtype) {
    case #"bar":
        setpointbar(point, relativepoint, xoffset, yoffset);
        self.barframe setparent(self getparent());
        self.barframe setpoint(point, relativepoint, xoffset, yoffset);
        break;
    }
    self updatechildren();
}

// Namespace hud/hud_util_shared
// Params 4, eflags: 0x0
// Checksum 0x5bbb5f9a, Offset: 0xd88
// Size: 0x1fc
function setpointbar(point, relativepoint, xoffset, yoffset) {
    self.bar.horzalign = self.horzalign;
    self.bar.vertalign = self.vertalign;
    self.bar.alignx = "left";
    self.bar.aligny = self.aligny;
    self.bar.y = self.y;
    if (self.alignx == "left") {
        self.bar.x = self.x;
    } else if (self.alignx == "right") {
        self.bar.x = self.x - self.width;
    } else {
        self.bar.x = self.x - int(self.width / 2);
    }
    if (self.aligny == "top") {
        self.bar.y = self.y;
    } else if (self.aligny == "bottom") {
        self.bar.y = self.y;
    }
    self updatebar(self.bar.frac);
}

// Namespace hud/hud_util_shared
// Params 2, eflags: 0x0
// Checksum 0xf214c1c9, Offset: 0xf90
// Size: 0x44
function updatebar(barfrac, rateofchange) {
    if (self.elemtype == "bar") {
        updatebarscale(barfrac, rateofchange);
    }
}

// Namespace hud/hud_util_shared
// Params 2, eflags: 0x0
// Checksum 0xa57aba2d, Offset: 0xfe0
// Size: 0x260
function updatebarscale(barfrac, rateofchange) {
    barwidth = int(self.width * barfrac + 0.5);
    if (!barwidth) {
        barwidth = 1;
    }
    self.bar.frac = barfrac;
    self.bar setshader(self.bar.shader, barwidth, self.height);
    assert(barwidth <= self.width, "<dev string:x90>" + barwidth + "<dev string:xa9>" + self.width + "<dev string:xae>" + barfrac);
    if (isdefined(rateofchange) && barwidth < self.width) {
        if (rateofchange > 0) {
            assert((1 - barfrac) / rateofchange > 0, "<dev string:xbe>" + barfrac + "<dev string:xc8>" + rateofchange);
            self.bar scaleovertime((1 - barfrac) / rateofchange, self.width, self.height);
        } else if (rateofchange < 0) {
            assert(barfrac / -1 * rateofchange > 0, "<dev string:xbe>" + barfrac + "<dev string:xc8>" + rateofchange);
            self.bar scaleovertime(barfrac / -1 * rateofchange, 1, self.height);
        }
    }
    self.bar.rateofchange = rateofchange;
    self.bar.lastupdatetime = gettime();
}

// Namespace hud/hud_util_shared
// Params 2, eflags: 0x0
// Checksum 0xe93aa117, Offset: 0x1248
// Size: 0x140
function createfontstring(font, fontscale) {
    fontelem = newclienthudelem(self);
    fontelem.elemtype = "font";
    fontelem.font = font;
    fontelem.fontscale = fontscale;
    fontelem.x = 0;
    fontelem.y = 0;
    fontelem.width = 0;
    fontelem.height = int(level.fontheight * fontscale);
    fontelem.xoffset = 0;
    fontelem.yoffset = 0;
    fontelem.children = [];
    fontelem setparent(level.uiparent);
    fontelem.hidden = 0;
    return fontelem;
}

// Namespace hud/hud_util_shared
// Params 3, eflags: 0x0
// Checksum 0x8210a1ac, Offset: 0x1390
// Size: 0x168
function createserverfontstring(font, fontscale, team) {
    if (isdefined(team)) {
        fontelem = newteamhudelem(team);
    } else {
        fontelem = newhudelem();
    }
    fontelem.elemtype = "font";
    fontelem.font = font;
    fontelem.fontscale = fontscale;
    fontelem.x = 0;
    fontelem.y = 0;
    fontelem.width = 0;
    fontelem.height = int(level.fontheight * fontscale);
    fontelem.xoffset = 0;
    fontelem.yoffset = 0;
    fontelem.children = [];
    fontelem setparent(level.uiparent);
    fontelem.hidden = 0;
    return fontelem;
}

// Namespace hud/hud_util_shared
// Params 3, eflags: 0x0
// Checksum 0xb832c425, Offset: 0x1500
// Size: 0x168
function createservertimer(font, fontscale, team) {
    if (isdefined(team)) {
        timerelem = newteamhudelem(team);
    } else {
        timerelem = newhudelem();
    }
    timerelem.elemtype = "timer";
    timerelem.font = font;
    timerelem.fontscale = fontscale;
    timerelem.x = 0;
    timerelem.y = 0;
    timerelem.width = 0;
    timerelem.height = int(level.fontheight * fontscale);
    timerelem.xoffset = 0;
    timerelem.yoffset = 0;
    timerelem.children = [];
    timerelem setparent(level.uiparent);
    timerelem.hidden = 0;
    return timerelem;
}

// Namespace hud/hud_util_shared
// Params 2, eflags: 0x0
// Checksum 0x669f77dc, Offset: 0x1670
// Size: 0x140
function createclienttimer(font, fontscale) {
    timerelem = newclienthudelem(self);
    timerelem.elemtype = "timer";
    timerelem.font = font;
    timerelem.fontscale = fontscale;
    timerelem.x = 0;
    timerelem.y = 0;
    timerelem.width = 0;
    timerelem.height = int(level.fontheight * fontscale);
    timerelem.xoffset = 0;
    timerelem.yoffset = 0;
    timerelem.children = [];
    timerelem setparent(level.uiparent);
    timerelem.hidden = 0;
    return timerelem;
}

// Namespace hud/hud_util_shared
// Params 3, eflags: 0x0
// Checksum 0xa75d194e, Offset: 0x17b8
// Size: 0x130
function createicon(shader, width, height) {
    iconelem = newclienthudelem(self);
    iconelem.elemtype = "icon";
    iconelem.x = 0;
    iconelem.y = 0;
    iconelem.width = width;
    iconelem.height = height;
    iconelem.xoffset = 0;
    iconelem.yoffset = 0;
    iconelem.children = [];
    iconelem setparent(level.uiparent);
    iconelem.hidden = 0;
    if (isdefined(shader)) {
        iconelem setshader(shader, width, height);
    }
    return iconelem;
}

// Namespace hud/hud_util_shared
// Params 4, eflags: 0x0
// Checksum 0xb2366384, Offset: 0x18f0
// Size: 0x158
function function_d945e9e7(shader, width, height, team) {
    if (isdefined(team)) {
        iconelem = newteamhudelem(team);
    } else {
        iconelem = newhudelem();
    }
    iconelem.elemtype = "icon";
    iconelem.x = 0;
    iconelem.y = 0;
    iconelem.width = width;
    iconelem.height = height;
    iconelem.xoffset = 0;
    iconelem.yoffset = 0;
    iconelem.children = [];
    iconelem setparent(level.uiparent);
    iconelem.hidden = 0;
    if (isdefined(shader)) {
        iconelem setshader(shader, width, height);
    }
    return iconelem;
}

// Namespace hud/hud_util_shared
// Params 6, eflags: 0x0
// Checksum 0xe40f3b90, Offset: 0x1a50
// Size: 0x478
function function_6f88521b(color, width, height, flashfrac, team, selected) {
    if (isdefined(team)) {
        barelem = newteamhudelem(team);
    } else {
        barelem = newhudelem();
    }
    barelem.x = 0;
    barelem.y = 0;
    barelem.frac = 0;
    barelem.color = color;
    barelem.sort = -2;
    barelem.shader = "progress_bar_fill";
    barelem setshader("progress_bar_fill", width, height);
    barelem.hidden = 0;
    if (isdefined(flashfrac)) {
        barelem.flashfrac = flashfrac;
    }
    if (isdefined(team)) {
        barelemframe = newteamhudelem(team);
    } else {
        barelemframe = newhudelem();
    }
    barelemframe.elemtype = "icon";
    barelemframe.x = 0;
    barelemframe.y = 0;
    barelemframe.width = width;
    barelemframe.height = height;
    barelemframe.xoffset = 0;
    barelemframe.yoffset = 0;
    barelemframe.bar = barelem;
    barelemframe.barframe = barelemframe;
    barelemframe.children = [];
    barelemframe.sort = -1;
    barelemframe.color = (1, 1, 1);
    barelemframe setparent(level.uiparent);
    if (isdefined(selected)) {
        barelemframe setshader("progress_bar_fg_sel", width, height);
    } else {
        barelemframe setshader("progress_bar_fg", width, height);
    }
    barelemframe.hidden = 0;
    if (isdefined(team)) {
        barelembg = newteamhudelem(team);
    } else {
        barelembg = newhudelem();
    }
    barelembg.elemtype = "bar";
    barelembg.x = 0;
    barelembg.y = 0;
    barelembg.width = width;
    barelembg.height = height;
    barelembg.xoffset = 0;
    barelembg.yoffset = 0;
    barelembg.bar = barelem;
    barelembg.barframe = barelemframe;
    barelembg.children = [];
    barelembg.sort = -3;
    barelembg.color = (0, 0, 0);
    barelembg.alpha = 0.5;
    barelembg setparent(level.uiparent);
    barelembg setshader("progress_bar_bg", width, height);
    barelembg.hidden = 0;
    return barelembg;
}

// Namespace hud/hud_util_shared
// Params 4, eflags: 0x0
// Checksum 0x3d8ddac6, Offset: 0x1ed0
// Size: 0x400
function createbar(color, width, height, flashfrac) {
    barelem = newclienthudelem(self);
    barelem.x = 0;
    barelem.y = 0;
    barelem.frac = 0;
    barelem.color = color;
    barelem.sort = -2;
    barelem.shader = "progress_bar_fill";
    barelem setshader("progress_bar_fill", width, height);
    barelem.hidden = 0;
    if (isdefined(flashfrac)) {
        barelem.flashfrac = flashfrac;
    }
    barelemframe = newclienthudelem(self);
    barelemframe.elemtype = "icon";
    barelemframe.x = 0;
    barelemframe.y = 0;
    barelemframe.width = width;
    barelemframe.height = height;
    barelemframe.xoffset = 0;
    barelemframe.yoffset = 0;
    barelemframe.bar = barelem;
    barelemframe.barframe = barelemframe;
    barelemframe.children = [];
    barelemframe.sort = -1;
    barelemframe.color = (1, 1, 1);
    barelemframe setparent(level.uiparent);
    barelemframe.hidden = 0;
    barelembg = newclienthudelem(self);
    barelembg.elemtype = "bar";
    if (!level.splitscreen) {
        barelembg.x = -2;
        barelembg.y = -2;
    }
    barelembg.width = width;
    barelembg.height = height;
    barelembg.xoffset = 0;
    barelembg.yoffset = 0;
    barelembg.bar = barelem;
    barelembg.barframe = barelemframe;
    barelembg.children = [];
    barelembg.sort = -3;
    barelembg.color = (0, 0, 0);
    barelembg.alpha = 0.5;
    barelembg setparent(level.uiparent);
    if (!level.splitscreen) {
        barelembg setshader("progress_bar_bg", width + 4, height + 4);
    } else {
        barelembg setshader("progress_bar_bg", width + 0, height + 0);
    }
    barelembg.hidden = 0;
    return barelembg;
}

// Namespace hud/hud_util_shared
// Params 0, eflags: 0x0
// Checksum 0xa94d0cf3, Offset: 0x22d8
// Size: 0xa0
function getcurrentfraction() {
    frac = self.bar.frac;
    if (isdefined(self.bar.rateofchange)) {
        frac += (gettime() - self.bar.lastupdatetime) * self.bar.rateofchange;
        if (frac > 1) {
            frac = 1;
        }
        if (frac < 0) {
            frac = 0;
        }
    }
    return frac;
}

// Namespace hud/hud_util_shared
// Params 0, eflags: 0x0
// Checksum 0x161e22b7, Offset: 0x2380
// Size: 0xc0
function createprimaryprogressbar() {
    bar = createbar((1, 1, 1), level.primaryprogressbarwidth, level.primaryprogressbarheight);
    if (level.splitscreen) {
        bar setpoint("TOP", undefined, level.primaryprogressbarx, level.primaryprogressbary);
    } else {
        bar setpoint("CENTER", undefined, level.primaryprogressbarx, level.primaryprogressbary);
    }
    return bar;
}

// Namespace hud/hud_util_shared
// Params 0, eflags: 0x0
// Checksum 0x94e14435, Offset: 0x2448
// Size: 0xcc
function createprimaryprogressbartext() {
    text = createfontstring("objective", level.primaryprogressbarfontsize);
    if (level.splitscreen) {
        text setpoint("TOP", undefined, level.primaryprogressbartextx, level.primaryprogressbartexty);
    } else {
        text setpoint("CENTER", undefined, level.primaryprogressbartextx, level.primaryprogressbartexty);
    }
    text.sort = -1;
    return text;
}

// Namespace hud/hud_util_shared
// Params 0, eflags: 0x0
// Checksum 0x1e42425b, Offset: 0x2520
// Size: 0x128
function function_2dc3c5fb() {
    secondaryprogressbarheight = getdvarint("scr_secondaryProgressBarHeight", level.secondaryprogressbarheight);
    secondaryprogressbarx = getdvarint("scr_secondaryProgressBarX", level.secondaryprogressbarx);
    secondaryprogressbary = getdvarint("scr_secondaryProgressBarY", level.secondaryprogressbary);
    bar = createbar((1, 1, 1), level.secondaryprogressbarwidth, secondaryprogressbarheight);
    if (level.splitscreen) {
        bar setpoint("TOP", undefined, secondaryprogressbarx, secondaryprogressbary);
    } else {
        bar setpoint("CENTER", undefined, secondaryprogressbarx, secondaryprogressbary);
    }
    return bar;
}

// Namespace hud/hud_util_shared
// Params 0, eflags: 0x0
// Checksum 0xa216781b, Offset: 0x2650
// Size: 0x10c
function function_220d67ce() {
    secondaryprogressbartextx = getdvarint("scr_btx", level.secondaryprogressbartextx);
    secondaryprogressbartexty = getdvarint("scr_bty", level.secondaryprogressbartexty);
    text = createfontstring("objective", level.primaryprogressbarfontsize);
    if (level.splitscreen) {
        text setpoint("TOP", undefined, secondaryprogressbartextx, secondaryprogressbartexty);
    } else {
        text setpoint("CENTER", undefined, secondaryprogressbartextx, secondaryprogressbartexty);
    }
    text.sort = -1;
    return text;
}

// Namespace hud/hud_util_shared
// Params 1, eflags: 0x0
// Checksum 0x4080da1f, Offset: 0x2768
// Size: 0x78
function function_a276e732(team) {
    bar = function_6f88521b((1, 0, 0), level.teamprogressbarwidth, level.teamprogressbarheight, undefined, team);
    bar setpoint("TOP", undefined, 0, level.teamprogressbary);
    return bar;
}

// Namespace hud/hud_util_shared
// Params 1, eflags: 0x0
// Checksum 0x29b139, Offset: 0x27e8
// Size: 0x70
function function_67fad4f(team) {
    text = createserverfontstring("default", level.teamprogressbarfontsize, team);
    text setpoint("TOP", undefined, 0, level.teamprogressbartexty);
    return text;
}

// Namespace hud/hud_util_shared
// Params 1, eflags: 0x0
// Checksum 0x185df872, Offset: 0x2860
// Size: 0x24
function setflashfrac(flashfrac) {
    self.bar.flashfrac = flashfrac;
}

// Namespace hud/hud_util_shared
// Params 0, eflags: 0x0
// Checksum 0xb0d3e10, Offset: 0x2890
// Size: 0x104
function hideelem() {
    if (self.hidden) {
        return;
    }
    self.hidden = 1;
    if (self.alpha != 0) {
        self.alpha = 0;
    }
    if (self.elemtype == "bar" || self.elemtype == "bar_shader") {
        self.bar.hidden = 1;
        if (self.bar.alpha != 0) {
            self.bar.alpha = 0;
        }
        self.barframe.hidden = 1;
        if (self.barframe.alpha != 0) {
            self.barframe.alpha = 0;
        }
    }
}

// Namespace hud/hud_util_shared
// Params 0, eflags: 0x0
// Checksum 0x75b8aed9, Offset: 0x29a0
// Size: 0x130
function showelem() {
    if (!self.hidden) {
        return;
    }
    self.hidden = 0;
    if (self.elemtype == "bar" || self.elemtype == "bar_shader") {
        if (self.alpha != 0.5) {
            self.alpha = 0.5;
        }
        self.bar.hidden = 0;
        if (self.bar.alpha != 1) {
            self.bar.alpha = 1;
        }
        self.barframe.hidden = 0;
        if (self.barframe.alpha != 1) {
            self.barframe.alpha = 1;
        }
        return;
    }
    if (self.alpha != 1) {
        self.alpha = 1;
    }
}

// Namespace hud/hud_util_shared
// Params 0, eflags: 0x0
// Checksum 0x1d042eac, Offset: 0x2ad8
// Size: 0x106
function flashthread() {
    self endon(#"death");
    if (!self.hidden) {
        self.alpha = 1;
    }
    while (true) {
        if (self.frac >= self.flashfrac) {
            if (!self.hidden) {
                self fadeovertime(0.3);
                self.alpha = 0.2;
                wait 0.35;
                self fadeovertime(0.3);
                self.alpha = 1;
            }
            wait 0.7;
            continue;
        }
        if (!self.hidden && self.alpha != 1) {
            self.alpha = 1;
        }
        waitframe(1);
    }
}

// Namespace hud/hud_util_shared
// Params 0, eflags: 0x0
// Checksum 0x18238d70, Offset: 0x2be8
// Size: 0x13c
function destroyelem() {
    tempchildren = [];
    for (index = 0; index < self.children.size; index++) {
        if (isdefined(self.children[index])) {
            tempchildren[tempchildren.size] = self.children[index];
        }
    }
    for (index = 0; index < tempchildren.size; index++) {
        tempchildren[index] setparent(self getparent());
    }
    if (self.elemtype == "bar" || self.elemtype == "bar_shader") {
        self.bar destroy();
        self.barframe destroy();
    }
    self destroy();
}

// Namespace hud/hud_util_shared
// Params 1, eflags: 0x0
// Checksum 0x9f16aa01, Offset: 0x2d30
// Size: 0x34
function seticonshader(shader) {
    self setshader(shader, self.width, self.height);
}

// Namespace hud/hud_util_shared
// Params 1, eflags: 0x0
// Checksum 0x6ba5f16e, Offset: 0x2d70
// Size: 0x1c
function setwidth(width) {
    self.width = width;
}

// Namespace hud/hud_util_shared
// Params 1, eflags: 0x0
// Checksum 0xba615715, Offset: 0x2d98
// Size: 0x1c
function setheight(height) {
    self.height = height;
}

// Namespace hud/hud_util_shared
// Params 2, eflags: 0x0
// Checksum 0xd1770b61, Offset: 0x2dc0
// Size: 0x34
function setsize(width, height) {
    self.width = width;
    self.height = height;
}

// Namespace hud/hud_util_shared
// Params 0, eflags: 0x0
// Checksum 0x456cd9d9, Offset: 0x2e00
// Size: 0x96
function updatechildren() {
    for (index = 0; index < self.children.size; index++) {
        child = self.children[index];
        child setpoint(child.point, child.relativepoint, child.xoffset, child.yoffset);
    }
}

// Namespace hud/hud_util_shared
// Params 5, eflags: 0x0
// Checksum 0xccb63f61, Offset: 0x2ea0
// Size: 0x140
function function_21f67f44(player, var_15524e1c, var_f5409200, xpos, ypos) {
    iconsize = 32;
    if (player issplitscreen()) {
        iconsize = 22;
    }
    ypos -= 90 + iconsize * (3 - var_15524e1c);
    xpos -= 10 + iconsize * var_f5409200;
    icon = createicon("white", iconsize, iconsize);
    icon setpoint("BOTTOM RIGHT", "BOTTOM RIGHT", xpos, ypos);
    icon.horzalign = "user_right";
    icon.vertalign = "user_bottom";
    icon.archived = 0;
    icon.foreground = 0;
    return icon;
}

// Namespace hud/hud_util_shared
// Params 5, eflags: 0x0
// Checksum 0xc9a2a6a5, Offset: 0x2fe8
// Size: 0x114
function function_5bb28094(player, var_15524e1c, var_f5409200, xpos, ypos) {
    iconsize = 32;
    if (player issplitscreen()) {
        iconsize = 22;
    }
    ypos -= 90 + iconsize * (3 - var_15524e1c);
    xpos -= 10 + iconsize * var_f5409200;
    self setpoint("BOTTOM RIGHT", "BOTTOM RIGHT", xpos, ypos);
    self.horzalign = "user_right";
    self.vertalign = "user_bottom";
    self.archived = 0;
    self.foreground = 0;
    self.alpha = 1;
}

// Namespace hud/hud_util_shared
// Params 1, eflags: 0x0
// Checksum 0xd7043de9, Offset: 0x3108
// Size: 0x34
function function_59b607f6(xcoord) {
    self setpoint("RIGHT", "LEFT", xcoord, 0);
}

// Namespace hud/hud_util_shared
// Params 2, eflags: 0x0
// Checksum 0x859eef91, Offset: 0x3148
// Size: 0xd0
function function_81ff9096(icon, xcoord) {
    text = createfontstring("small", 1);
    text setparent(icon);
    text setpoint("RIGHT", "LEFT", xcoord, 0);
    text.archived = 0;
    text.alignx = "right";
    text.aligny = "middle";
    text.foreground = 0;
    return text;
}

// Namespace hud/hud_util_shared
// Params 5, eflags: 0x0
// Checksum 0xbc738abf, Offset: 0x3220
// Size: 0xbc
function function_489f386e(iconelem, icon, alpha, var_31704579, text) {
    iconsize = 32;
    iconelem.alpha = alpha;
    if (alpha) {
        iconelem setshader(icon, iconsize, iconsize);
    }
    if (isdefined(var_31704579)) {
        var_31704579.alpha = alpha;
        if (alpha) {
            var_31704579 settext(text);
        }
    }
}

// Namespace hud/hud_util_shared
// Params 4, eflags: 0x0
// Checksum 0xd80358c9, Offset: 0x32e8
// Size: 0xc8
function function_c7cd3259(iconelem, fadetime, var_31704579, var_deead00e) {
    if (isdefined(fadetime)) {
        if (!isdefined(var_deead00e) || !var_deead00e) {
            iconelem fadeovertime(fadetime);
        }
        if (isdefined(var_31704579)) {
            var_31704579 fadeovertime(fadetime);
        }
    }
    if (!isdefined(var_deead00e) || !var_deead00e) {
        iconelem.alpha = 0;
    }
    if (isdefined(var_31704579)) {
        var_31704579.alpha = 0;
    }
}

// Namespace hud/hud_util_shared
// Params 0, eflags: 0x0
// Checksum 0x6287b4ba, Offset: 0x33b8
// Size: 0x24
function showperks() {
    self luinotifyevent(%show_perk_notification, 0);
}

// Namespace hud/hud_util_shared
// Params 3, eflags: 0x0
// Checksum 0xdf741e9d, Offset: 0x33e8
// Size: 0x314
function function_ae77a5ba(index, perk, ypos) {
    assert(game.state != "<dev string:xd7>");
    if (!isdefined(self.perkicon)) {
        self.perkicon = [];
        self.perkname = [];
    }
    if (!isdefined(self.perkicon[index])) {
        assert(!isdefined(self.perkname[index]));
        self.perkicon[index] = function_21f67f44(self, index, 0, 200, ypos);
        self.perkname[index] = function_81ff9096(self.perkicon[index], 160);
    } else {
        self.perkicon[index] function_5bb28094(self, index, 0, 200, ypos);
        self.perkname[index] function_59b607f6(160);
    }
    if (perk == "perk_null" || perk == "weapon_null" || perk == "specialty_null") {
        alpha = 0;
    } else {
        assert(isdefined(level.perknames[perk]), perk);
        alpha = 1;
    }
    function_489f386e(self.perkicon[index], perk, alpha, self.perkname[index], level.perknames[perk]);
    self.perkicon[index] moveovertime(0.3);
    self.perkicon[index].x = -5;
    self.perkicon[index].hidewheninmenu = 1;
    self.perkname[index] moveovertime(0.3);
    self.perkname[index].x = -40;
    self.perkname[index].hidewheninmenu = 1;
}

// Namespace hud/hud_util_shared
// Params 3, eflags: 0x0
// Checksum 0x48b1e5b4, Offset: 0x3708
// Size: 0x19c
function function_74b6cb2d(index, fadetime, var_deead00e) {
    if (!isdefined(fadetime)) {
        fadetime = 0.05;
    }
    if (level.perksenabled == 1) {
        if (game.state == "postgame") {
            if (isdefined(self.perkicon)) {
                assert(!isdefined(self.perkicon[index]));
                assert(!isdefined(self.perkname[index]));
            }
            return;
        }
        assert(isdefined(self.perkicon[index]));
        assert(isdefined(self.perkname[index]));
        if (isdefined(self.perkicon) && isdefined(self.perkicon[index]) && isdefined(self.perkname) && isdefined(self.perkname[index])) {
            function_c7cd3259(self.perkicon[index], fadetime, self.perkname[index], var_deead00e);
        }
    }
}

// Namespace hud/hud_util_shared
// Params 4, eflags: 0x0
// Checksum 0x22156db1, Offset: 0x38b0
// Size: 0x16c
function function_8842ffe4(index, killstreak, xpos, ypos) {
    assert(game.state != "<dev string:xd7>");
    if (!isdefined(self.killstreakicon)) {
        self.killstreakicon = [];
    }
    if (!isdefined(self.killstreakicon[index])) {
        self.killstreakicon[index] = function_21f67f44(self, 3, self.killstreak.size - 1 - index, xpos, ypos);
    }
    if (killstreak == "killstreak_null" || killstreak == "weapon_null") {
        alpha = 0;
    } else {
        assert(isdefined(level.killstreakicons[killstreak]), killstreak);
        alpha = 1;
    }
    function_489f386e(self.killstreakicon[index], level.killstreakicons[killstreak], alpha);
}

// Namespace hud/hud_util_shared
// Params 2, eflags: 0x0
// Checksum 0x43a25846, Offset: 0x3a28
// Size: 0xbc
function function_743093ab(index, fadetime) {
    if (util::is_killstreaks_enabled()) {
        if (game.state == "postgame") {
            assert(!isdefined(self.killstreakicon[index]));
            return;
        }
        assert(isdefined(self.killstreakicon[index]));
        function_c7cd3259(self.killstreakicon[index], fadetime);
    }
}

// Namespace hud/hud_util_shared
// Params 0, eflags: 0x0
// Checksum 0xe1210a9e, Offset: 0x3af0
// Size: 0x64
function function_21804f26() {
    self.x = 11;
    self.y = 120;
    self.horzalign = "user_left";
    self.vertalign = "user_top";
    self.alignx = "left";
    self.aligny = "top";
}

