#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\throttle_shared;
#using scripts\core_common\util_shared;

#namespace archetype_secondary_animations;

// Namespace archetype_secondary_animations/archetype_secondary_animations
// Params 0, eflags: 0x2
// Checksum 0xabeca302, Offset: 0x168
// Size: 0x11c
function autoexec main() {
    if (sessionmodeiszombiesgame() && getdvarint(#"splitscreen_playercount", 0) > 2) {
        return;
    }
    ai::add_archetype_spawn_function(#"human", &secondaryanimationsinit);
    ai::add_archetype_spawn_function(#"civilian", &secondaryanimationsinit);
    ai::add_archetype_spawn_function(#"zombie", &secondaryanimationsinit);
    ai::add_ai_spawn_function(&on_entity_spawn);
    ai::function_2315ecfa(&function_b27b8716);
}

// Namespace archetype_secondary_animations/archetype_secondary_animations
// Params 1, eflags: 0x4
// Checksum 0xb32d4e5d, Offset: 0x290
// Size: 0xfc
function private secondaryanimationsinit(localclientnum) {
    if (!isdefined(level.__facialanimationslist)) {
        buildandvalidatefacialanimationlist(localclientnum);
    }
    if (!isdefined(level.var_e07bea93)) {
        level.var_e07bea93 = new class_c6c0e94();
        [[ level.var_e07bea93 ]]->initialize("secondaryAnimationThrottle", 1, 0.016);
    }
    self callback::on_shutdown(&on_entity_shutdown);
    if (self function_8d8e91af()) {
        self thread function_3673906(localclientnum);
        return;
    }
    self thread secondaryfacialanimationthink(localclientnum);
}

// Namespace archetype_secondary_animations/archetype_secondary_animations
// Params 1, eflags: 0x4
// Checksum 0x3ee79f0a, Offset: 0x398
// Size: 0x66
function private on_entity_spawn(localclientnum) {
    if (self hasdobj(localclientnum)) {
        self clearanim(#"faces", 0);
    }
    self._currentfacestate = "inactive";
    self.var_a5cdf0bd = 0;
}

// Namespace archetype_secondary_animations/archetype_secondary_animations
// Params 1, eflags: 0x4
// Checksum 0xbaa1aa9c, Offset: 0x408
// Size: 0x54
function private function_b27b8716(localclientnum) {
    self on_entity_spawn(localclientnum);
    self.archetype = #"human";
    self secondaryanimationsinit(localclientnum);
}

// Namespace archetype_secondary_animations/archetype_secondary_animations
// Params 1, eflags: 0x4
// Checksum 0xed1d98f1, Offset: 0x468
// Size: 0x6a
function private on_entity_shutdown(localclientnum) {
    if (isdefined(self)) {
        self notify(#"stopfacialthread");
        if (is_true(self.facialdeathanimstarted)) {
            return;
        }
        self applydeathanim(localclientnum);
        if (isdefined(self)) {
            self.facialdeathanimstarted = 1;
        }
    }
}

// Namespace archetype_secondary_animations/archetype_secondary_animations
// Params 1, eflags: 0x0
// Checksum 0xda375f4d, Offset: 0x4e0
// Size: 0x8c8
function buildandvalidatefacialanimationlist(localclientnum) {
    assert(!isdefined(level.__facialanimationslist));
    level.__facialanimationslist = [];
    level.__facialanimationslist[#"human"] = [];
    level.__facialanimationslist[#"human"][#"combat"] = array(#"ai_t8_face_hero_generic_idle_1", #"ai_t8_face_hero_generic_idle_2", #"ai_t8_face_hero_generic_idle_3");
    level.__facialanimationslist[#"human"][#"combat_aim"] = array(#"ai_t8_face_hero_aim_idle_1", #"ai_t8_face_hero_aim_idle_2", #"ai_t8_face_hero_aim_idle_3");
    level.__facialanimationslist[#"human"][#"combat_shoot"] = array(#"ai_t8_face_hero_aim_fire_1", #"ai_t8_face_hero_aim_fire_2", #"ai_t8_face_hero_aim_fire_3");
    level.__facialanimationslist[#"human"][#"death"] = array(#"hash_6475991c6b5d94bb", #"hash_64759a1c6b5d966e", #"hash_64759b1c6b5d9821", #"hash_64759c1c6b5d99d4", #"hash_64759d1c6b5d9b87");
    level.__facialanimationslist[#"human"][#"melee"] = array(#"ai_t8_face_hero_melee_1");
    level.__facialanimationslist[#"human"][#"pain"] = array(#"hash_ee9591a50acc77b", #"hash_ee95a1a50acc92e", #"hash_ee95b1a50accae1");
    level.__facialanimationslist[#"human"][#"animscripted"] = array(#"ai_t8_face_hero_generic_idle_1");
    level.__facialanimationslist[#"zombie"] = [];
    level.__facialanimationslist[#"zombie"][#"combat"] = array(#"hash_f64275707b76883");
    level.__facialanimationslist[#"zombie"][#"combat_aim"] = array(#"hash_f64275707b76883");
    level.__facialanimationslist[#"zombie"][#"combat_shoot"] = array(#"hash_f64275707b76883");
    level.__facialanimationslist[#"zombie"][#"death"] = array(#"hash_7a6d64b8e60f262d");
    level.__facialanimationslist[#"zombie"][#"melee"] = array(#"hash_3181a3ee96a8d5d", #"hash_318173ee96a8844");
    level.__facialanimationslist[#"zombie"][#"pain"] = array(#"hash_711aa10330a50fd");
    level.__facialanimationslist[#"zombie"][#"animscripted"] = array(#"hash_f64275707b76883");
    level.var_e776187e[0] = array(#"hash_3c8c7be61c0c54bf", #"hash_3c8c7ce61c0c5672");
    level.var_e776187e[1] = array(#"hash_1be71f9083c3a62b", #"hash_1be7209083c3a7de");
    level.var_e776187e[2] = array(#"hash_284df1f0899aeec2");
    level.var_e776187e[3] = array(#"hash_11dfb67db7575849");
    var_72e0db27 = [];
    foreach (key, value in level.__facialanimationslist[#"human"]) {
        var_72e0db27[key] = value;
    }
    level.__facialanimationslist[#"civilian"] = var_72e0db27;
    deathanims = [];
    foreach (animation in level.__facialanimationslist[#"human"][#"death"]) {
        array::add(deathanims, animation);
    }
    foreach (animation in level.__facialanimationslist[#"zombie"][#"death"]) {
        array::add(deathanims, animation);
    }
    foreach (deathanim in deathanims) {
        assert(!isanimlooping(localclientnum, deathanim), "<dev string:x38>" + deathanim + "<dev string:x61>");
    }
}

// Namespace archetype_secondary_animations/archetype_secondary_animations
// Params 0, eflags: 0x4
// Checksum 0x5373311d, Offset: 0xdb0
// Size: 0x4c
function private function_77fa627c() {
    if (self function_8d8e91af()) {
        return self getcurrentanimscriptedname();
    }
    return self getprimarydeltaanim();
}

// Namespace archetype_secondary_animations/archetype_secondary_animations
// Params 1, eflags: 0x4
// Checksum 0x2d744ae2, Offset: 0xe08
// Size: 0x176
function private getfacialanimoverride(localclientnum) {
    if (sessionmodeiscampaigngame()) {
        primarydeltaanim = self function_77fa627c();
        if (isdefined(primarydeltaanim)) {
            primarydeltaanimlength = getanimlength(primarydeltaanim);
            notetracks = getnotetracksindelta(primarydeltaanim, 0, 1);
            foreach (notetrack in notetracks) {
                if (notetrack[1] == "facial_anim") {
                    facialanim = notetrack[2];
                    facialanimlength = getanimlength(facialanim);
                    /#
                        if (facialanimlength < primarydeltaanimlength && !isanimlooping(localclientnum, facialanim)) {
                        }
                    #/
                    return facialanim;
                }
            }
        }
    }
    return undefined;
}

// Namespace archetype_secondary_animations/archetype_secondary_animations
// Params 1, eflags: 0x4
// Checksum 0xd23a7400, Offset: 0xf88
// Size: 0xa6
function private function_176c97f8(substate) {
    if (!isdefined(substate)) {
        return false;
    }
    return substate == #"pain" || substate == #"inplace_pain" || substate == #"pain_intro" || substate == #"pain_outro" || substate == #"painrecovery" || substate == #"pronepain";
}

// Namespace archetype_secondary_animations/archetype_secondary_animations
// Params 1, eflags: 0x4
// Checksum 0x22628ca5, Offset: 0x1038
// Size: 0x5e
function private function_f5dde44(substate) {
    if (!isdefined(substate)) {
        return false;
    }
    return substate == #"melee" || substate == #"charge_melee" || substate == #"hash_48dda7ed88efe32f";
}

// Namespace archetype_secondary_animations/archetype_secondary_animations
// Params 1, eflags: 0x4
// Checksum 0x1e7d3061, Offset: 0x10a0
// Size: 0x240
function private function_9d9508f(localclientnum) {
    self.var_a5cdf0bd = 0;
    self.var_74a451af = 0;
    if (!isdefined(self.archetype) || self.archetype != #"human" && self.archetype != #"civilian") {
        return;
    }
    self endon(#"death");
    self endon(#"stopfacialthread");
    while (true) {
        waitresult = self waittill(#"hash_f88532a558ad684", #"vox");
        if (waitresult._notify == #"vox") {
            self.var_74a451af++;
            continue;
        }
        if (waitresult.start) {
            var_8d8e91af = self function_8d8e91af();
            if (self.var_74a451af == 0 && (var_8d8e91af || !self asmisterminating(localclientnum))) {
                if (var_8d8e91af) {
                    var_fe545d7d = 0;
                } else {
                    var_fe545d7d = clientfield::get("lipflap_anim");
                }
                animtoplay = array::random(level.var_e776187e[var_fe545d7d]);
                self applynewfaceanim(localclientnum, animtoplay, 0);
                self.var_a5cdf0bd++;
            }
            continue;
        }
        if (self.var_74a451af == 0) {
            self.var_a5cdf0bd--;
            if (self.var_a5cdf0bd <= 0) {
                self clearcurrentfacialanim(localclientnum);
                self.var_a5cdf0bd = 0;
            }
            continue;
        }
        self.var_74a451af--;
    }
}

// Namespace archetype_secondary_animations/archetype_secondary_animations
// Params 1, eflags: 0x4
// Checksum 0xd4904038, Offset: 0x12e8
// Size: 0x1e0
function private function_3673906(localclientnum) {
    if (!self function_8d8e91af()) {
        assert(0, "<dev string:x9f>");
        return;
    }
    if (isdefined(level.var_e45a8859) && [[ level.var_e45a8859 ]]() == 0) {
        return;
    }
    self endoncallback(&function_60bde6c, #"death", #"stopfacialthread");
    self thread function_9d9508f(localclientnum);
    while (true) {
        if (self.var_a5cdf0bd > 0) {
            wait 0.5;
            continue;
        }
        closestplayer = arraygetclosest(self.origin, level.localplayers, getdvarint(#"ai_clientfacialculldist", 2000));
        if (!isdefined(closestplayer)) {
            wait 0.5;
            continue;
        }
        if (!self hasdobj(localclientnum) || !self hasanimtree()) {
            wait 0.5;
            continue;
        }
        animoverride = self getfacialanimoverride(localclientnum);
        if (isdefined(animoverride) && self._currentfaceanim !== animoverride) {
            applynewfaceanim(localclientnum, animoverride);
        }
        wait 0.25;
    }
}

// Namespace archetype_secondary_animations/archetype_secondary_animations
// Params 1, eflags: 0x4
// Checksum 0x59c43127, Offset: 0x14d0
// Size: 0x6e8
function private secondaryfacialanimationthink(localclientnum) {
    if (!(isdefined(self.archetype) && (self.archetype == #"human" || self.archetype == #"zombie" || self.archetype == #"civilian"))) {
        assert(0, "<dev string:xb2>");
        return;
    }
    if (isdefined(level.var_e45a8859) && [[ level.var_e45a8859 ]]() == 0) {
        return;
    }
    self endoncallback(&function_60bde6c, #"death", #"stopfacialthread");
    self._currentfacestate = "inactive";
    self thread function_9d9508f(localclientnum);
    while (isdefined(self.archetype)) {
        if (sessionmodeiszombiesgame()) {
            [[ level.var_e07bea93 ]]->waitinqueue(self);
        }
        if (self.archetype == #"human" && self clientfield::get("facial_dial")) {
            self._currentfacestate = "inactive";
            self clearcurrentfacialanim(localclientnum);
            wait 0.5;
            continue;
        }
        if (self.var_a5cdf0bd > 0) {
            wait 0.5;
            continue;
        }
        animoverride = self getfacialanimoverride(localclientnum);
        asmstatus = self asmgetstatus(localclientnum);
        forcenewanim = 0;
        switch (asmstatus) {
        case #"asm_status_terminated":
            return;
        case #"asm_status_inactive":
            if (isdefined(animoverride)) {
                scriptedanim = self getprimarydeltaanim();
                if (isdefined(scriptedanim) && (!isdefined(self._scriptedanim) || self._scriptedanim != scriptedanim)) {
                    self._scriptedanim = scriptedanim;
                    forcenewanim = 1;
                }
                if (isdefined(animoverride) && animoverride !== self._currentfaceanim) {
                    forcenewanim = 1;
                }
            } else {
                if (self._currentfacestate !== "death") {
                    self._currentfacestate = "inactive";
                    self clearcurrentfacialanim(localclientnum);
                }
                wait 0.5;
                continue;
            }
            break;
        }
        closestplayer = arraygetclosest(self.origin, level.localplayers, getdvarint(#"ai_clientfacialculldist", 2000));
        if (!isdefined(closestplayer)) {
            wait 0.5;
            continue;
        }
        if (!self hasdobj(localclientnum) || !self hasanimtree()) {
            wait 0.5;
            continue;
        }
        currfacestate = self._currentfacestate;
        currentasmstate = self asmgetcurrentstate(localclientnum);
        if (self asmisterminating(localclientnum)) {
            nextfacestate = "death";
        } else if (asmstatus == "asm_status_inactive") {
            nextfacestate = "animscripted";
        } else if (self function_cbf629f(localclientnum)) {
            nextfacestate = "asm_internal";
        } else if (function_176c97f8(currentasmstate) || self function_bc69e3d4(localclientnum)) {
            nextfacestate = "pain";
        } else if (function_f5dde44(currentasmstate)) {
            nextfacestate = "melee";
        } else if (self asmisshootlayeractive(localclientnum)) {
            nextfacestate = "combat_shoot";
        } else if (self asmisaimlayeractive(localclientnum)) {
            nextfacestate = "combat_aim";
        } else {
            nextfacestate = "combat";
        }
        if (nextfacestate == "asm_internal") {
            if (currfacestate != "asm_internal") {
                clearcurrentfacialanim(localclientnum);
            }
            self._currentfacestate = nextfacestate;
        } else if (currfacestate == "inactive" || currfacestate != nextfacestate || forcenewanim) {
            assert(isdefined(level.__facialanimationslist[self.archetype][nextfacestate]));
            clearoncompletion = 0;
            if (nextfacestate == "death") {
            }
            animtoplay = array::random(level.__facialanimationslist[self.archetype][nextfacestate]);
            if (isdefined(animoverride)) {
                animtoplay = animoverride;
                assert(nextfacestate != "<dev string:x148>" || !isanimlooping(localclientnum, animtoplay), "<dev string:x38>" + animtoplay + "<dev string:x61>");
            }
            applynewfaceanim(localclientnum, animtoplay, clearoncompletion);
            self._currentfacestate = nextfacestate;
        }
        if (self._currentfacestate == "death") {
            break;
        }
        wait 0.25;
    }
}

// Namespace archetype_secondary_animations/archetype_secondary_animations
// Params 1, eflags: 0x4
// Checksum 0xc89c5832, Offset: 0x1bc0
// Size: 0x24
function private function_60bde6c(*notifyhash) {
    [[ level.var_e07bea93 ]]->leavequeue(self);
}

// Namespace archetype_secondary_animations/archetype_secondary_animations
// Params 3, eflags: 0x4
// Checksum 0x5c2d7ce4, Offset: 0x1bf0
// Size: 0xfc
function private applynewfaceanim(localclientnum, animation, clearoncompletion = 0) {
    clearcurrentfacialanim(localclientnum);
    if (isdefined(animation)) {
        self._currentfaceanim = animation;
        if (self hasdobj(localclientnum) && self hasanimtree()) {
            self setflaggedanimknob(#"ai_secondary_facial_anim", animation, 1, 0.1, 1);
            if (clearoncompletion) {
                wait getanimlength(animation);
                clearcurrentfacialanim(localclientnum);
            }
        }
    }
}

// Namespace archetype_secondary_animations/archetype_secondary_animations
// Params 1, eflags: 0x4
// Checksum 0xc198c30a, Offset: 0x1cf8
// Size: 0x18a
function private applydeathanim(localclientnum) {
    if (getmigrationstatus(localclientnum)) {
        return;
    }
    if (!isdefined(self)) {
        return;
    }
    util::waitforclient(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (self._currentfacestate === "death") {
        return;
    }
    if (self hasdobj(localclientnum) && self hasanimtree()) {
        if (isdefined(self) && isdefined(self.archetype) && isdefined(level.__facialanimationslist) && isdefined(level.__facialanimationslist[self.archetype]) && isdefined(level.__facialanimationslist[self.archetype][#"death"])) {
            animtoplay = array::random(level.__facialanimationslist[self.archetype][#"death"]);
            animoverride = self getfacialanimoverride(localclientnum);
            if (isdefined(animoverride)) {
                animtoplay = animoverride;
            }
            applynewfaceanim(localclientnum, animtoplay);
        }
        self._currentfacestate = "death";
    }
}

// Namespace archetype_secondary_animations/archetype_secondary_animations
// Params 1, eflags: 0x4
// Checksum 0x3fe642c5, Offset: 0x1e90
// Size: 0x76
function private clearcurrentfacialanim(localclientnum) {
    if (isdefined(self._currentfaceanim) && self hasdobj(localclientnum) && self hasanimtree()) {
        self clearanim(self._currentfaceanim, 0.2);
    }
    self._currentfaceanim = undefined;
}

