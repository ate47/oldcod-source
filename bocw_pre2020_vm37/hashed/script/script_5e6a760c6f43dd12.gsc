#using scripts\core_common\ai_shared;

#namespace namespace_94e44221;

// Namespace namespace_94e44221/namespace_94e44221
// Params 0, eflags: 0x1 linked
// Checksum 0x1d1cac81, Offset: 0x68
// Size: 0x37c
function update() {
    if (!self isplayerswimming()) {
        self.bot.resurfacetime = undefined;
        return;
    }
    if (!self ai::get_behavior_attribute(#"swim")) {
        if (self isplayerunderwater()) {
            self bottapbutton(67);
        }
        return;
    }
    if (isdefined(self.drownstage) && self.drownstage != 0) {
        self bottapbutton(67);
        return;
    }
    if (self isplayerunderwater()) {
        if (!isdefined(self.bot.resurfacetime)) {
            if (isdefined(self.playerrole) && isdefined(self.playerrole.swimtime)) {
                self.bot.resurfacetime = gettime() + int((self.playerrole.swimtime - 1) * 1000);
            } else {
                self.bot.resurfacetime = gettime() + 3000;
            }
        }
    } else {
        if (isdefined(self.bot.resurfacetime) && gettime() - self.bot.resurfacetime < int(2 * 1000)) {
            self bottapbutton(67);
            return;
        }
        self.bot.resurfacetime = undefined;
    }
    if (self botundermanualcontrol()) {
        return;
    }
    goalposition = self.goalpos;
    if (distance2dsquared(goalposition, self.origin) <= 16384 && getwaterheight(goalposition) > 0) {
        self bottapbutton(68);
        return;
    }
    if (isdefined(self.bot.resurfacetime) && self.bot.resurfacetime <= gettime()) {
        self bottapbutton(67);
        return;
    }
    bottomtrace = groundtrace(self.origin, self.origin + (0, 0, -1000), 0, self, 1);
    swimheight = self.origin[2] - bottomtrace[#"position"][2];
    if (swimheight < 25) {
        self bottapbutton(67);
        return;
    }
    if (swimheight > 45) {
        self bottapbutton(68);
    }
}

