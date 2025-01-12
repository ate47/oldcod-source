#using scripts\core_common\sound_shared;

#namespace zombie_shared;

// Namespace zombie_shared/zombie_shared
// Params 0, eflags: 0x0
// Checksum 0x8bb1d600, Offset: 0x1c8
// Size: 0x24
function deleteatlimit() {
    wait 30;
    self delete();
}

// Namespace zombie_shared/zombie_shared
// Params 5, eflags: 0x0
// Checksum 0xe9fce81, Offset: 0x1f8
// Size: 0x1be
function lookatposition(looktargetpos, lookduration, lookspeed, eyesonly, interruptothers) {
    assert(isai(self), "<dev string:x30>");
    assert(self.a.targetlookinitilized == 1, "<dev string:x5f>");
    assert(lookspeed == "<dev string:x9d>" || lookspeed == "<dev string:xa4>", "<dev string:xaa>");
    if (!isdefined(interruptothers) || interruptothers == "interrupt others" || gettime() > self.a.lookendtime) {
        self.a.looktargetpos = looktargetpos;
        self.a.lookendtime = gettime() + lookduration * 1000;
        if (lookspeed == "casual") {
            self.a.looktargetspeed = 800;
        } else {
            self.a.looktargetspeed = 1600;
        }
        if (isdefined(eyesonly) && eyesonly == "eyes only") {
            self notify(#"eyes look now");
            return;
        }
        self notify(#"look now");
    }
}

// Namespace zombie_shared/zombie_shared
// Params 2, eflags: 0x0
// Checksum 0x662a02f9, Offset: 0x3c0
// Size: 0x3a
function lookatanimations(leftanim, rightanim) {
    self.a.lookanimationleft = leftanim;
    self.a.lookanimationright = rightanim;
}

// Namespace zombie_shared/zombie_shared
// Params 1, eflags: 0x0
// Checksum 0xbe78efbc, Offset: 0x408
// Size: 0x140
function handledogsoundnotetracks(note) {
    if (note == "sound_dogstep_run_default" || note == "dogstep_rf" || note == "dogstep_lf") {
        self playsound(#"fly_dog_step_run_default");
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
// Checksum 0xb78c4d73, Offset: 0x550
// Size: 0xc
function growling() {
    return isdefined(self.script_growl);
}

// Namespace zombie_shared/zombie_shared
// Params 0, eflags: 0x0
// Checksum 0xfd1fd1af, Offset: 0x568
// Size: 0x3f2
function registernotetracks() {
    anim.notetracks[#"anim_pose = "stand""] = &notetrackposestand;
    anim.notetracks[#"anim_pose = "crouch""] = &notetrackposecrouch;
    anim.notetracks[#"anim_movement = "stop""] = &notetrackmovementstop;
    anim.notetracks[#"hash_4170f46935239626"] = &notetrackmovementwalk;
    anim.notetracks[#"anim_movement = "run""] = &notetrackmovementrun;
    anim.notetracks[#"hash_40fdc55d0cf02732"] = &notetrackalertnesscasual;
    anim.notetracks[#"anim_alertness = alert"] = &notetrackalertnessalert;
    anim.notetracks[#"gravity on"] = &notetrackgravity;
    anim.notetracks[#"gravity off"] = &notetrackgravity;
    anim.notetracks[#"hash_3a65333187809d2e"] = &notetrackgravity;
    anim.notetracks[#"bodyfall large"] = &notetrackbodyfall;
    anim.notetracks[#"bodyfall small"] = &notetrackbodyfall;
    anim.notetracks[#"footstep"] = &notetrackfootstep;
    anim.notetracks[#"step"] = &notetrackfootstep;
    anim.notetracks[#"footstep_right_large"] = &notetrackfootstep;
    anim.notetracks[#"footstep_right_small"] = &notetrackfootstep;
    anim.notetracks[#"footstep_left_large"] = &notetrackfootstep;
    anim.notetracks[#"footstep_left_small"] = &notetrackfootstep;
    anim.notetracks[#"footscrape"] = &notetrackfootscrape;
    anim.notetracks[#"land"] = &notetrackland;
    anim.notetracks[#"start_ragdoll"] = &notetrackstartragdoll;
}

// Namespace zombie_shared/zombie_shared
// Params 2, eflags: 0x0
// Checksum 0x8aab737c, Offset: 0x968
// Size: 0x14
function notetrackstopanim(note, flagname) {
    
}

// Namespace zombie_shared/zombie_shared
// Params 2, eflags: 0x0
// Checksum 0xc0852a32, Offset: 0x988
// Size: 0x4c
function notetrackstartragdoll(note, flagname) {
    if (isdefined(self.noragdoll)) {
        return;
    }
    self unlink();
    self startragdoll();
}

// Namespace zombie_shared/zombie_shared
// Params 2, eflags: 0x0
// Checksum 0x1c120d0, Offset: 0x9e0
// Size: 0x46
function notetrackmovementstop(note, flagname) {
    if (issentient(self)) {
        self.a.movement = "stop";
    }
}

// Namespace zombie_shared/zombie_shared
// Params 2, eflags: 0x0
// Checksum 0xa4ddcd4e, Offset: 0xa30
// Size: 0x46
function notetrackmovementwalk(note, flagname) {
    if (issentient(self)) {
        self.a.movement = "walk";
    }
}

// Namespace zombie_shared/zombie_shared
// Params 2, eflags: 0x0
// Checksum 0xc5068778, Offset: 0xa80
// Size: 0x46
function notetrackmovementrun(note, flagname) {
    if (issentient(self)) {
        self.a.movement = "run";
    }
}

// Namespace zombie_shared/zombie_shared
// Params 2, eflags: 0x0
// Checksum 0xd7ca8dbc, Offset: 0xad0
// Size: 0x46
function notetrackalertnesscasual(note, flagname) {
    if (issentient(self)) {
        self.a.alertness = "casual";
    }
}

// Namespace zombie_shared/zombie_shared
// Params 2, eflags: 0x0
// Checksum 0x4edf3807, Offset: 0xb20
// Size: 0x46
function notetrackalertnessalert(note, flagname) {
    if (issentient(self)) {
        self.a.alertness = "alert";
    }
}

// Namespace zombie_shared/zombie_shared
// Params 2, eflags: 0x0
// Checksum 0x13d33ceb, Offset: 0xb70
// Size: 0x40
function notetrackposestand(note, flagname) {
    self.a.pose = "stand";
    self notify("entered_pose" + "stand");
}

// Namespace zombie_shared/zombie_shared
// Params 2, eflags: 0x0
// Checksum 0x657d2be7, Offset: 0xbb8
// Size: 0x6e
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
// Checksum 0x1eacba00, Offset: 0xc30
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
// Checksum 0xb33f4ebb, Offset: 0xd28
// Size: 0xcc
function notetrackbodyfall(note, flagname) {
    if (isdefined(self.groundtype)) {
        groundtype = self.groundtype;
    } else {
        groundtype = "dirt";
    }
    if (issubstr(note, "large")) {
        self playsound(#"fly_bodyfall_large_" + groundtype);
        return;
    }
    if (issubstr(note, "small")) {
        self playsound(#"fly_bodyfall_small_" + groundtype);
    }
}

// Namespace zombie_shared/zombie_shared
// Params 2, eflags: 0x0
// Checksum 0xc20904cf, Offset: 0xe00
// Size: 0x9c
function notetrackfootstep(note, flagname) {
    if (issubstr(note, "left")) {
        playfootstep("J_Ball_LE");
    } else {
        playfootstep("J_BALL_RI");
    }
    if (!level.clientscripts) {
        self playsound(#"fly_gear_run");
    }
}

// Namespace zombie_shared/zombie_shared
// Params 2, eflags: 0x0
// Checksum 0xe788feb8, Offset: 0xea8
// Size: 0x6c
function notetrackfootscrape(note, flagname) {
    if (isdefined(self.groundtype)) {
        groundtype = self.groundtype;
    } else {
        groundtype = "dirt";
    }
    self playsound(#"fly_step_scrape_" + groundtype);
}

// Namespace zombie_shared/zombie_shared
// Params 2, eflags: 0x0
// Checksum 0xa716e090, Offset: 0xf20
// Size: 0x6c
function notetrackland(note, flagname) {
    if (isdefined(self.groundtype)) {
        groundtype = self.groundtype;
    } else {
        groundtype = "dirt";
    }
    self playsound(#"fly_land_npc_" + groundtype);
}

// Namespace zombie_shared/zombie_shared
// Params 4, eflags: 0x0
// Checksum 0xd1f1d08b, Offset: 0xf98
// Size: 0x372
function handlenotetrack(note, flagname, customfunction, var1) {
    if (isai(self) && isdefined(anim.notetracks)) {
        notetrackfunc = anim.notetracks[note];
        if (isdefined(notetrackfunc)) {
            return [[ notetrackfunc ]](note, flagname);
        }
    }
    switch (note) {
    case #"undefined":
    case #"end":
    case #"finish":
        if (isai(self) && self.a.pose == "back") {
        }
        return note;
    case #"hash_701bc5c059dfaa52":
        self thread sound::play_in_space("fly_gear_enemy", self gettagorigin("TAG_WEAPON_RIGHT"));
        break;
    case #"hash_5f5e275b9f3b93ee":
        self thread sound::play_in_space("fly_gear_enemy_large", self gettagorigin("TAG_WEAPON_RIGHT"));
        break;
    case #"no death":
        self.a.nodeath = 1;
        break;
    case #"no pain":
        self.allowpain = 0;
        break;
    case #"hash_50c6c08f5de3ec2a":
        self.allowpain = 1;
        break;
    case #"anim_melee = right":
    case #"hash_39ec7b0969bab796":
        self.a.meleestate = "right";
        break;
    case #"hash_1791db148d16d825":
    case #"hash_6b554a9080ec8b07":
        self.a.meleestate = "left";
        break;
    case #"swap taghelmet to tagleft":
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
// Checksum 0x5d4322e2, Offset: 0x1318
// Size: 0xa0
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
// Checksum 0x1297e694, Offset: 0x13c0
// Size: 0x12e
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
                println(gettime() + "<dev string:xcc>" + flagname + "<dev string:x119>" + returnednote + "<dev string:x125>");
                wait 0.05 - timetaken;
            }
        }
    }
}

// Namespace zombie_shared/zombie_shared
// Params 4, eflags: 0x0
// Checksum 0x8b5717c4, Offset: 0x14f8
// Size: 0x54
function donotetracksforever(flagname, killstring, customfunction, var1) {
    donotetracksforeverproc(&donotetracks, flagname, killstring, customfunction, var1);
}

// Namespace zombie_shared/zombie_shared
// Params 6, eflags: 0x0
// Checksum 0x28ee59e3, Offset: 0x1558
// Size: 0x62
function donotetracksfortimeproc(donotetracksforeverfunc, time, flagname, customfunction, ent, var1) {
    ent endon(#"stop_notetracks");
    [[ donotetracksforeverfunc ]](flagname, undefined, customfunction, var1);
}

// Namespace zombie_shared/zombie_shared
// Params 4, eflags: 0x0
// Checksum 0xc3f19d10, Offset: 0x15c8
// Size: 0x84
function donotetracksfortime(time, flagname, customfunction, var1) {
    ent = spawnstruct();
    ent thread donotetracksfortimeendnotify(time);
    donotetracksfortimeproc(&donotetracksforever, time, flagname, customfunction, ent, var1);
}

// Namespace zombie_shared/zombie_shared
// Params 1, eflags: 0x0
// Checksum 0x54ec717a, Offset: 0x1658
// Size: 0x26
function donotetracksfortimeendnotify(time) {
    wait time;
    self notify(#"stop_notetracks");
}

// Namespace zombie_shared/zombie_shared
// Params 1, eflags: 0x0
// Checksum 0xfa1cf776, Offset: 0x1688
// Size: 0x11c
function playfootstep(foot) {
    if (!level.clientscripts) {
        if (!isai(self)) {
            self playsound(#"fly_step_run_dirt");
            return;
        }
    }
    groundtype = undefined;
    if (!isdefined(self.groundtype)) {
        if (!isdefined(self.lastgroundtype)) {
            if (!level.clientscripts) {
                self playsound(#"fly_step_run_dirt");
            }
            return;
        }
        groundtype = self.lastgroundtype;
    } else {
        groundtype = self.groundtype;
        self.lastgroundtype = self.groundtype;
    }
    if (!level.clientscripts) {
        self playsound(#"fly_step_run_" + groundtype);
    }
    [[ anim.optionalstepeffectfunction ]](foot, groundtype);
}

// Namespace zombie_shared/zombie_shared
// Params 2, eflags: 0x0
// Checksum 0xd846ceb1, Offset: 0x17b0
// Size: 0x100
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
// Checksum 0x67d8ba9d, Offset: 0x18b8
// Size: 0x15e
function movetooriginovertime(origin, time) {
    self endon(#"killanimscript");
    if (distancesquared(self.origin, origin) > 256 && !self maymovetopoint(origin)) {
        println("<dev string:x127>" + origin + "<dev string:x154>");
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
// Checksum 0xf919f6cf, Offset: 0x1a20
// Size: 0x8
function returntrue() {
    return true;
}

// Namespace zombie_shared/zombie_shared
// Params 2, eflags: 0x0
// Checksum 0x9478abef, Offset: 0x1a30
// Size: 0xfa
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
// Checksum 0xd8916f, Offset: 0x1b38
// Size: 0xae
function incranimaimweight() {
    if (self.a.aimweight_t < self.a.aimweight_transframes) {
        self.a.aimweight_t++;
        t = 1 * self.a.aimweight_t / self.a.aimweight_transframes;
        self.a.aimweight = self.a.aimweight_start * (1 - t) + self.a.aimweight_end * t;
    }
}

