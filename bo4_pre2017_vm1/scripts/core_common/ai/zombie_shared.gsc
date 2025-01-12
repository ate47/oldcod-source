#using scripts/core_common/ai/zombie_utility;
#using scripts/core_common/math_shared;
#using scripts/core_common/sound_shared;
#using scripts/core_common/struct;

#namespace zombie_shared;

// Namespace zombie_shared/zombie_shared
// Params 0, eflags: 0x0
// Checksum 0xc3654cb1, Offset: 0x4f8
// Size: 0x24
function deleteatlimit() {
    wait 30;
    self delete();
}

// Namespace zombie_shared/zombie_shared
// Params 5, eflags: 0x0
// Checksum 0xad6b024d, Offset: 0x528
// Size: 0x2c
function lookatentity(var_22ba4c26, lookduration, lookspeed, eyesonly, interruptothers) {
    
}

// Namespace zombie_shared/zombie_shared
// Params 5, eflags: 0x0
// Checksum 0x936e2bd8, Offset: 0x560
// Size: 0x1be
function lookatposition(looktargetpos, lookduration, lookspeed, eyesonly, interruptothers) {
    /#
        assert(isai(self), "<dev string:x28>");
    #/
    /#
        assert(self.a.targetlookinitilized == 1, "<dev string:x57>");
    #/
    /#
        assert(lookspeed == "<dev string:x95>" || lookspeed == "<dev string:x9c>", "<dev string:xa2>");
    #/
    if (!isdefined(interruptothers) || interruptothers == "interrupt others" || gettime() > self.a.lookendtime) {
        self.a.looktargetpos = looktargetpos;
        self.a.lookendtime = gettime() + lookduration * 1000;
        if (lookspeed == "casual") {
            self.a.looktargetspeed = 800;
        } else {
            self.a.looktargetspeed = 1600;
        }
        if (isdefined(eyesonly) && eyesonly == "eyes only") {
            self notify(#"hash_c1896d90");
            return;
        }
        self notify(#"hash_9a1a418c");
    }
}

// Namespace zombie_shared/zombie_shared
// Params 2, eflags: 0x0
// Checksum 0xd055d053, Offset: 0x728
// Size: 0x44
function lookatanimations(leftanim, rightanim) {
    self.a.lookanimationleft = leftanim;
    self.a.lookanimationright = rightanim;
}

// Namespace zombie_shared/zombie_shared
// Params 1, eflags: 0x0
// Checksum 0x9d51f550, Offset: 0x778
// Size: 0x138
function handledogsoundnotetracks(note) {
    if (note == "sound_dogstep_run_default" || note == "dogstep_rf" || note == "dogstep_lf") {
        self playsound("fly_dog_step_run_default");
        return true;
    }
    prefix = getsubstr(note, 0, 5);
    if (prefix != "sound") {
        return false;
    }
    alias = "aml" + getsubstr(note, 5);
    if (isalive(self)) {
        self thread sound::play_on_tag(alias, "tag_eye");
    } else {
        self thread sound::play_in_space(alias, self gettagorigin("tag_eye"));
    }
    return true;
}

// Namespace zombie_shared/zombie_shared
// Params 0, eflags: 0x0
// Checksum 0xd0dccfd8, Offset: 0x8b8
// Size: 0x10
function growling() {
    return isdefined(self.script_growl);
}

// Namespace zombie_shared/zombie_shared
// Params 0, eflags: 0x0
// Checksum 0xd21df1f8, Offset: 0x8d0
// Size: 0x34a
function registernotetracks() {
    anim.notetracks["anim_pose = \"stand\""] = &notetrackposestand;
    anim.notetracks["anim_pose = \"crouch\""] = &notetrackposecrouch;
    anim.notetracks["anim_movement = \"stop\""] = &notetrackmovementstop;
    anim.notetracks["anim_movement = \"walk\""] = &notetrackmovementwalk;
    anim.notetracks["anim_movement = \"run\""] = &notetrackmovementrun;
    anim.notetracks["anim_alertness = causal"] = &notetrackalertnesscasual;
    anim.notetracks["anim_alertness = alert"] = &notetrackalertnessalert;
    anim.notetracks["gravity on"] = &notetrackgravity;
    anim.notetracks["gravity off"] = &notetrackgravity;
    anim.notetracks["gravity code"] = &notetrackgravity;
    anim.notetracks["bodyfall large"] = &notetrackbodyfall;
    anim.notetracks["bodyfall small"] = &notetrackbodyfall;
    anim.notetracks["footstep"] = &notetrackfootstep;
    anim.notetracks["step"] = &notetrackfootstep;
    anim.notetracks["footstep_right_large"] = &notetrackfootstep;
    anim.notetracks["footstep_right_small"] = &notetrackfootstep;
    anim.notetracks["footstep_left_large"] = &notetrackfootstep;
    anim.notetracks["footstep_left_small"] = &notetrackfootstep;
    anim.notetracks["footscrape"] = &notetrackfootscrape;
    anim.notetracks["land"] = &notetrackland;
    anim.notetracks["start_ragdoll"] = &notetrackstartragdoll;
}

// Namespace zombie_shared/zombie_shared
// Params 2, eflags: 0x0
// Checksum 0xac767398, Offset: 0xc28
// Size: 0x14
function notetrackstopanim(note, flagname) {
    
}

// Namespace zombie_shared/zombie_shared
// Params 2, eflags: 0x0
// Checksum 0xf0f063b7, Offset: 0xc48
// Size: 0x54
function notetrackstartragdoll(note, flagname) {
    if (isdefined(self.noragdoll)) {
        return;
    }
    self unlink();
    self startragdoll();
}

// Namespace zombie_shared/zombie_shared
// Params 2, eflags: 0x0
// Checksum 0xc4b62ea5, Offset: 0xca8
// Size: 0x48
function notetrackmovementstop(note, flagname) {
    if (issentient(self)) {
        self.a.movement = "stop";
    }
}

// Namespace zombie_shared/zombie_shared
// Params 2, eflags: 0x0
// Checksum 0x7c8f5128, Offset: 0xcf8
// Size: 0x48
function notetrackmovementwalk(note, flagname) {
    if (issentient(self)) {
        self.a.movement = "walk";
    }
}

// Namespace zombie_shared/zombie_shared
// Params 2, eflags: 0x0
// Checksum 0xf0c78e98, Offset: 0xd48
// Size: 0x48
function notetrackmovementrun(note, flagname) {
    if (issentient(self)) {
        self.a.movement = "run";
    }
}

// Namespace zombie_shared/zombie_shared
// Params 2, eflags: 0x0
// Checksum 0x522da736, Offset: 0xd98
// Size: 0x48
function notetrackalertnesscasual(note, flagname) {
    if (issentient(self)) {
        self.a.alertness = "casual";
    }
}

// Namespace zombie_shared/zombie_shared
// Params 2, eflags: 0x0
// Checksum 0x241de951, Offset: 0xde8
// Size: 0x48
function notetrackalertnessalert(note, flagname) {
    if (issentient(self)) {
        self.a.alertness = "alert";
    }
}

// Namespace zombie_shared/zombie_shared
// Params 2, eflags: 0x0
// Checksum 0xb9123de4, Offset: 0xe38
// Size: 0x44
function notetrackposestand(note, flagname) {
    self.a.pose = "stand";
    self notify("entered_pose" + "stand");
}

// Namespace zombie_shared/zombie_shared
// Params 2, eflags: 0x0
// Checksum 0xf0cf9df8, Offset: 0xe88
// Size: 0x80
function notetrackposecrouch(note, flagname) {
    self.a.pose = "crouch";
    self notify("entered_pose" + "crouch");
    if (self.a.crouchpain) {
        self.a.crouchpain = 0;
        self.health = 150;
    }
}

// Namespace zombie_shared/zombie_shared
// Params 2, eflags: 0x0
// Checksum 0xcbac24d1, Offset: 0xf10
// Size: 0xee
function notetrackgravity(note, flagname) {
    if (issubstr(note, "on")) {
        self animmode("gravity");
        return;
    }
    if (issubstr(note, "off")) {
        self animmode("nogravity");
        self.nogravity = 1;
        return;
    }
    if (issubstr(note, "code")) {
        self animmode("none");
        self.nogravity = undefined;
    }
}

// Namespace zombie_shared/zombie_shared
// Params 2, eflags: 0x0
// Checksum 0x949887ea, Offset: 0x1008
// Size: 0xcc
function notetrackbodyfall(note, flagname) {
    if (isdefined(self.groundtype)) {
        groundtype = self.groundtype;
    } else {
        groundtype = "dirt";
    }
    if (issubstr(note, "large")) {
        self playsound("fly_bodyfall_large_" + groundtype);
        return;
    }
    if (issubstr(note, "small")) {
        self playsound("fly_bodyfall_small_" + groundtype);
    }
}

// Namespace zombie_shared/zombie_shared
// Params 2, eflags: 0x0
// Checksum 0x60f155b7, Offset: 0x10e0
// Size: 0x94
function notetrackfootstep(note, flagname) {
    if (issubstr(note, "left")) {
        playfootstep("J_Ball_LE");
    } else {
        playfootstep("J_BALL_RI");
    }
    if (!level.clientscripts) {
        self playsound("fly_gear_run");
    }
}

// Namespace zombie_shared/zombie_shared
// Params 2, eflags: 0x0
// Checksum 0xbc0fc435, Offset: 0x1180
// Size: 0x6c
function notetrackfootscrape(note, flagname) {
    if (isdefined(self.groundtype)) {
        groundtype = self.groundtype;
    } else {
        groundtype = "dirt";
    }
    self playsound("fly_step_scrape_" + groundtype);
}

// Namespace zombie_shared/zombie_shared
// Params 2, eflags: 0x0
// Checksum 0x8dd2dfc7, Offset: 0x11f8
// Size: 0x6c
function notetrackland(note, flagname) {
    if (isdefined(self.groundtype)) {
        groundtype = self.groundtype;
    } else {
        groundtype = "dirt";
    }
    self playsound("fly_land_npc_" + groundtype);
}

// Namespace zombie_shared/zombie_shared
// Params 4, eflags: 0x0
// Checksum 0x4558fcb7, Offset: 0x1270
// Size: 0x322
function handlenotetrack(note, flagname, customfunction, var1) {
    if (isai(self) && isdefined(anim.notetracks)) {
        notetrackfunc = anim.notetracks[note];
        if (isdefined(notetrackfunc)) {
            return [[ notetrackfunc ]](note, flagname);
        }
    }
    switch (note) {
    case #"end":
    case #"finish":
    case #"undefined":
        if (isai(self) && self.a.pose == "back") {
        }
        return note;
    case #"hash_3b702830":
        self thread sound::play_in_space("fly_gear_enemy", self gettagorigin("TAG_WEAPON_RIGHT"));
        break;
    case #"hash_e4078d18":
        self thread sound::play_in_space("fly_gear_enemy_large", self gettagorigin("TAG_WEAPON_RIGHT"));
        break;
    case #"hash_b8285fa":
        self.a.nodeath = 1;
        break;
    case #"hash_930e628c":
        self.allowpain = 0;
        break;
    case #"hash_6e2baff8":
        self.allowpain = 1;
        break;
    case #"hash_73b7918":
    case #"hash_4bcfe6f8":
        self.a.meleestate = "right";
        break;
    case #"hash_b6f405b3":
    case #"hash_5efcad95":
        self.a.meleestate = "left";
        break;
    case #"hash_8ac7d189":
        if (isdefined(self.hatmodel)) {
            if (isdefined(self.helmetsidemodel)) {
                self detach(self.helmetsidemodel, "TAG_HELMETSIDE");
                self.helmetsidemodel = undefined;
            }
            self detach(self.hatmodel, "");
            self attach(self.hatmodel, "TAG_WEAPON_LEFT");
            self.hatmodel = undefined;
        }
        break;
    default:
        if (isdefined(customfunction)) {
            if (!isdefined(var1)) {
                return [[ customfunction ]](note);
            } else {
                return [[ customfunction ]](note, var1);
            }
        }
        break;
    }
}

// Namespace zombie_shared/zombie_shared
// Params 3, eflags: 0x0
// Checksum 0xb975b7ca, Offset: 0x15a0
// Size: 0xac
function donotetracks(flagname, customfunction, var1) {
    for (;;) {
        waitresult = self waittill(flagname);
        note = waitresult.notetrack;
        if (!isdefined(note)) {
            note = "undefined";
        }
        val = self handlenotetrack(note, flagname, customfunction, var1);
        if (isdefined(val)) {
            return val;
        }
    }
}

// Namespace zombie_shared/zombie_shared
// Params 5, eflags: 0x0
// Checksum 0x9cfc4465, Offset: 0x1658
// Size: 0x13e
function donotetracksforeverproc(notetracksfunc, flagname, killstring, customfunction, var1) {
    if (isdefined(killstring)) {
        self endon(killstring);
    }
    self endon(#"killanimscript");
    for (;;) {
        time = gettime();
        returnednote = [[ notetracksfunc ]](flagname, customfunction, var1);
        timetaken = gettime() - time;
        if (timetaken < 0.05) {
            time = gettime();
            returnednote = [[ notetracksfunc ]](flagname, customfunction, var1);
            timetaken = gettime() - time;
            if (timetaken < 0.05) {
                /#
                    println(gettime() + "<dev string:xc4>" + flagname + "<dev string:x111>" + returnednote + "<dev string:x11d>");
                #/
                wait 0.05 - timetaken;
            }
        }
    }
}

// Namespace zombie_shared/zombie_shared
// Params 4, eflags: 0x0
// Checksum 0x5f2f1e72, Offset: 0x17a0
// Size: 0x54
function donotetracksforever(flagname, killstring, customfunction, var1) {
    donotetracksforeverproc(&donotetracks, flagname, killstring, customfunction, var1);
}

// Namespace zombie_shared/zombie_shared
// Params 6, eflags: 0x0
// Checksum 0x2f68b760, Offset: 0x1800
// Size: 0x5c
function donotetracksfortimeproc(donotetracksforeverfunc, time, flagname, customfunction, ent, var1) {
    ent endon(#"stop_notetracks");
    [[ donotetracksforeverfunc ]](flagname, undefined, customfunction, var1);
}

// Namespace zombie_shared/zombie_shared
// Params 4, eflags: 0x0
// Checksum 0xb25b3290, Offset: 0x1868
// Size: 0x94
function donotetracksfortime(time, flagname, customfunction, var1) {
    ent = spawnstruct();
    ent thread donotetracksfortimeendnotify(time);
    donotetracksfortimeproc(&donotetracksforever, time, flagname, customfunction, ent, var1);
}

// Namespace zombie_shared/zombie_shared
// Params 1, eflags: 0x0
// Checksum 0x6d192939, Offset: 0x1908
// Size: 0x1e
function donotetracksfortimeendnotify(time) {
    wait time;
    self notify(#"stop_notetracks");
}

// Namespace zombie_shared/zombie_shared
// Params 1, eflags: 0x0
// Checksum 0x729d692, Offset: 0x1930
// Size: 0x128
function playfootstep(foot) {
    if (!level.clientscripts) {
        if (!isai(self)) {
            self playsound("fly_step_run_dirt");
            return;
        }
    }
    groundtype = undefined;
    if (!isdefined(self.groundtype)) {
        if (!isdefined(self.lastgroundtype)) {
            if (!level.clientscripts) {
                self playsound("fly_step_run_dirt");
            }
            return;
        }
        groundtype = self.lastgroundtype;
    } else {
        groundtype = self.groundtype;
        self.lastgroundtype = self.groundtype;
    }
    if (!level.clientscripts) {
        self playsound("fly_step_run_" + groundtype);
    }
    [[ anim.optionalstepeffectfunction ]](foot, groundtype);
}

// Namespace zombie_shared/zombie_shared
// Params 2, eflags: 0x0
// Checksum 0xe8f215b2, Offset: 0x1a60
// Size: 0x118
function playfootstepeffect(foot, groundtype) {
    if (level.clientscripts) {
        return;
    }
    for (i = 0; i < anim.optionalstepeffects.size; i++) {
        if (isdefined(self.fire_footsteps) && self.fire_footsteps) {
            groundtype = "fire";
        }
        if (groundtype != anim.optionalstepeffects[i]) {
            continue;
        }
        org = self gettagorigin(foot);
        playfx(level._effect["step_" + anim.optionalstepeffects[i]], org, org + (0, 0, 100));
        return;
    }
}

// Namespace zombie_shared/zombie_shared
// Params 2, eflags: 0x0
// Checksum 0x4a848b93, Offset: 0x1b80
// Size: 0x168
function movetooriginovertime(origin, time) {
    self endon(#"killanimscript");
    if (distancesquared(self.origin, origin) > 256 && !self maymovetopoint(origin)) {
        /#
            println("<dev string:x11f>" + origin + "<dev string:x14c>");
        #/
        return;
    }
    self.keepclaimednodeingoal = 1;
    offset = self.origin - origin;
    frames = int(time * 20);
    offsetreduction = vectorscale(offset, 1 / frames);
    for (i = 0; i < frames; i++) {
        offset -= offsetreduction;
        self teleport(origin + offset);
        waitframe(1);
    }
    self.keepclaimednodeingoal = 0;
}

// Namespace zombie_shared/zombie_shared
// Params 0, eflags: 0x0
// Checksum 0x7bd5781e, Offset: 0x1cf0
// Size: 0x8
function returntrue() {
    return true;
}

// Namespace zombie_shared/zombie_shared
// Params 2, eflags: 0x0
// Checksum 0xfb8e1197, Offset: 0x1d00
// Size: 0x120
function setanimaimweight(goalweight, goaltime) {
    if (!isdefined(goaltime) || goaltime <= 0) {
        self.a.aimweight = goalweight;
        self.a.aimweight_start = goalweight;
        self.a.aimweight_end = goalweight;
        self.a.aimweight_transframes = 0;
    } else {
        self.a.aimweight = goalweight;
        self.a.aimweight_start = self.a.aimweight;
        self.a.aimweight_end = goalweight;
        self.a.aimweight_transframes = int(goaltime * 20);
    }
    self.a.aimweight_t = 0;
}

// Namespace zombie_shared/zombie_shared
// Params 0, eflags: 0x0
// Checksum 0xca41e7da, Offset: 0x1e28
// Size: 0xc0
function incranimaimweight() {
    if (self.a.aimweight_t < self.a.aimweight_transframes) {
        self.a.aimweight_t++;
        t = 1 * self.a.aimweight_t / self.a.aimweight_transframes;
        self.a.aimweight = self.a.aimweight_start * (1 - t) + self.a.aimweight_end * t;
    }
}

