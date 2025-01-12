#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;

#namespace archetype_secondary_animations;

// Namespace archetype_secondary_animations/archetype_secondary_animations
// Params 0, eflags: 0x2
// Checksum 0xae2d5713, Offset: 0x140
// Size: 0xcc
function autoexec main() {
    if (sessionmodeiszombiesgame() && getdvarint(#"splitscreen_playercount", 0) > 2) {
        return;
    }
    ai::add_archetype_spawn_function(#"human", &secondaryanimationsinit);
    ai::add_archetype_spawn_function(#"zombie", &secondaryanimationsinit);
    ai::add_ai_spawn_function(&on_entity_spawn);
}

// Namespace archetype_secondary_animations/archetype_secondary_animations
// Params 1, eflags: 0x5 linked
// Checksum 0xbb223e10, Offset: 0x218
// Size: 0x6c
function private secondaryanimationsinit(localclientnum) {
    if (!isdefined(level.__facialanimationslist)) {
        buildandvalidatefacialanimationlist(localclientnum);
    }
    self callback::on_shutdown(&on_entity_shutdown);
    self thread secondaryfacialanimationthink(localclientnum);
}

// Namespace archetype_secondary_animations/archetype_secondary_animations
// Params 1, eflags: 0x5 linked
// Checksum 0xc8a4d7ba, Offset: 0x290
// Size: 0x66
function private on_entity_spawn(localclientnum) {
    if (self hasdobj(localclientnum)) {
        self clearanim(#"faces", 0);
    }
    self._currentfacestate = "inactive";
    self.var_a5cdf0bd = 0;
}

// Namespace archetype_secondary_animations/archetype_secondary_animations
// Params 1, eflags: 0x5 linked
// Checksum 0xab2d09cf, Offset: 0x300
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
// Params 1, eflags: 0x1 linked
// Checksum 0xa6aeb73d, Offset: 0x378
// Size: 0x7d0
function buildandvalidatefacialanimationlist(localclientnum) {
    assert(!isdefined(level.__facialanimationslist));
    level.__facialanimationslist = [];
    level.__facialanimationslist[#"human"] = [];
    level.__facialanimationslist[#"human"][#"combat"] = array(#"ai_t8_face_hero_generic_idle_1", #"ai_t8_face_hero_generic_idle_2", #"ai_t8_face_hero_generic_idle_3");
    level.__facialanimationslist[#"human"][#"combat_aim"] = array(#"ai_t8_face_hero_aim_idle_1", #"ai_t8_face_hero_aim_idle_2", #"ai_t8_face_hero_aim_idle_3");
    level.__facialanimationslist[#"human"][#"combat_shoot"] = array(#"ai_t8_face_hero_aim_fire_1", #"ai_t8_face_hero_aim_fire_2", #"ai_t8_face_hero_aim_fire_3");
    level.__facialanimationslist[#"human"][#"death"] = array(#"ai_t8_face_hero_dth_1", #"ai_t8_face_hero_dth_2", #"ai_t8_face_hero_dth_3");
    level.__facialanimationslist[#"human"][#"melee"] = array(#"ai_t8_face_hero_melee_1");
    level.__facialanimationslist[#"human"][#"pain"] = array(#"ai_t8_face_hero_pain_1");
    level.__facialanimationslist[#"human"][#"animscripted"] = array(#"ai_t8_face_hero_generic_idle_1");
    level.__facialanimationslist[#"zombie"] = [];
    level.__facialanimationslist[#"zombie"][#"combat"] = array(#"ai_t8_face_zombie_generic_idle_01");
    level.__facialanimationslist[#"zombie"][#"combat_aim"] = array(#"ai_t8_face_zombie_generic_idle_01");
    level.__facialanimationslist[#"zombie"][#"combat_shoot"] = array(#"ai_t8_face_zombie_generic_idle_01");
    level.__facialanimationslist[#"zombie"][#"death"] = array(#"ai_t8_face_zombie_generic_death_01");
    level.__facialanimationslist[#"zombie"][#"melee"] = array(#"ai_t8_face_zombie_generic_attack_01", #"ai_t8_face_zombie_generic_attack_02");
    level.__facialanimationslist[#"zombie"][#"pain"] = array(#"ai_t8_face_zombie_generic_pain_01");
    level.__facialanimationslist[#"zombie"][#"animscripted"] = array(#"ai_t8_face_zombie_generic_idle_01");
    level.var_e776187e[0] = array(#"hash_3c8c7be61c0c54bf", #"hash_3c8c7ce61c0c5672");
    level.var_e776187e[1] = array(#"hash_1be71f9083c3a62b", #"hash_1be7209083c3a7de");
    level.var_e776187e[2] = array(#"hash_284df1f0899aeec2");
    level.var_e776187e[3] = array(#"hash_11dfb67db7575849");
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
// Params 1, eflags: 0x5 linked
// Checksum 0xa08d8702, Offset: 0xb50
// Size: 0x176
function private getfacialanimoverride(localclientnum) {
    if (sessionmodeiscampaigngame()) {
        primarydeltaanim = self getprimarydeltaanim();
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
// Params 1, eflags: 0x5 linked
// Checksum 0x769d61dc, Offset: 0xcd0
// Size: 0xa6
function private function_176c97f8(substate) {
    if (!isdefined(substate)) {
        return false;
    }
    return substate == #"pain" || substate == #"inplace_pain" || substate == #"pain_intro" || substate == #"pain_outro" || substate == #"painrecovery" || substate == #"pronepain";
}

// Namespace archetype_secondary_animations/archetype_secondary_animations
// Params 1, eflags: 0x5 linked
// Checksum 0x1bf9dc13, Offset: 0xd80
// Size: 0x5e
function private function_f5dde44(substate) {
    if (!isdefined(substate)) {
        return false;
    }
    return substate == #"melee" || substate == #"charge_melee" || substate == #"hash_48dda7ed88efe32f";
}

// Namespace archetype_secondary_animations/archetype_secondary_animations
// Params 1, eflags: 0x5 linked
// Checksum 0x6d64f261, Offset: 0xde8
// Size: 0x1ce
function private function_9d9508f(localclientnum) {
    self.var_a5cdf0bd = 0;
    self.var_74a451af = 1;
    if (!isdefined(self.archetype) || self.archetype != #"human") {
        return;
    }
    self endon(#"death");
    self endon(#"stopfacialthread");
    while (true) {
        waitresult = self waittill(#"hash_f88532a558ad684", #"vox");
        if (waitresult._notify == #"vox") {
            self.var_74a451af = 1;
            continue;
        }
        if (waitresult.start) {
            if (self.var_74a451af == 0) {
                var_fe545d7d = clientfield::get("lipflap_anim");
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
        }
        self.var_74a451af = 0;
    }
}

// Namespace archetype_secondary_animations/archetype_secondary_animations
// Params 1, eflags: 0x5 linked
// Checksum 0x1421f8be, Offset: 0xfc0
// Size: 0x688
function private secondaryfacialanimationthink(localclientnum) {
    if (!(isdefined(self.archetype) && (self.archetype == #"human" || self.archetype == #"zombie"))) {
        assert(0, "<dev string:x9f>");
        return;
    }
    if (isdefined(level.var_e45a8859) && [[ level.var_e45a8859 ]]() == 0) {
        return;
    }
    self endon(#"death");
    self endon(#"stopfacialthread");
    self._currentfacestate = "inactive";
    self thread function_9d9508f(localclientnum);
    while (isdefined(self.archetype)) {
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
                assert(nextfacestate != "<dev string:x10d>" || !isanimlooping(localclientnum, animtoplay), "<dev string:x38>" + animtoplay + "<dev string:x61>");
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
// Params 3, eflags: 0x5 linked
// Checksum 0x9d8b3894, Offset: 0x1650
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
// Params 1, eflags: 0x5 linked
// Checksum 0xd670f827, Offset: 0x1758
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
// Params 1, eflags: 0x5 linked
// Checksum 0xd6585452, Offset: 0x18f0
// Size: 0x76
function private clearcurrentfacialanim(localclientnum) {
    if (isdefined(self._currentfaceanim) && self hasdobj(localclientnum) && self hasanimtree()) {
        self clearanim(self._currentfaceanim, 0.2);
    }
    self._currentfaceanim = undefined;
}

