#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;

#namespace archetype_secondary_animations;

// Namespace archetype_secondary_animations/archetype_secondary_animations
// Params 0, eflags: 0x2
// Checksum 0x2e5971fc, Offset: 0x108
// Size: 0xbc
function autoexec main() {
    if (sessionmodeiszombiesgame() && getdvarint(#"splitscreen_playercount", 0) > 2) {
        return;
    }
    ai::add_archetype_spawn_function("human", &secondaryanimationsinit);
    ai::add_archetype_spawn_function("zombie", &secondaryanimationsinit);
    ai::add_ai_spawn_function(&on_entity_spawn);
}

// Namespace archetype_secondary_animations/archetype_secondary_animations
// Params 1, eflags: 0x4
// Checksum 0x4d73918d, Offset: 0x1d0
// Size: 0x6c
function private secondaryanimationsinit(localclientnum) {
    if (!isdefined(level.__facialanimationslist)) {
        buildandvalidatefacialanimationlist(localclientnum);
    }
    self callback::on_shutdown(&on_entity_shutdown);
    self thread secondaryfacialanimationthink(localclientnum);
}

// Namespace archetype_secondary_animations/archetype_secondary_animations
// Params 1, eflags: 0x4
// Checksum 0xbc1f789a, Offset: 0x248
// Size: 0x5a
function private on_entity_spawn(localclientnum) {
    if (self hasdobj(localclientnum)) {
        self clearanim(#"faces", 0);
    }
    self._currentfacestate = "inactive";
}

// Namespace archetype_secondary_animations/archetype_secondary_animations
// Params 1, eflags: 0x4
// Checksum 0xfe694302, Offset: 0x2b0
// Size: 0x6a
function private on_entity_shutdown(localclientnum) {
    if (isdefined(self)) {
        self notify(#"stopfacialthread");
        if (isdefined(self.facialdeathanimstarted) && self.facialdeathanimstarted) {
            return;
        }
        self applydeathanim(localclientnum);
        self.facialdeathanimstarted = 1;
    }
}

// Namespace archetype_secondary_animations/archetype_secondary_animations
// Params 1, eflags: 0x0
// Checksum 0x2bc35185, Offset: 0x328
// Size: 0x748
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
    deathanims = [];
    foreach (animation in level.__facialanimationslist[#"human"][#"death"]) {
        array::add(deathanims, animation);
    }
    foreach (animation in level.__facialanimationslist[#"zombie"][#"death"]) {
        array::add(deathanims, animation);
    }
    foreach (deathanim in deathanims) {
        assert(!isanimlooping(localclientnum, deathanim), "<dev string:x30>" + deathanim + "<dev string:x56>");
    }
}

// Namespace archetype_secondary_animations/archetype_secondary_animations
// Params 1, eflags: 0x4
// Checksum 0xd95c54d, Offset: 0xa78
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
// Params 1, eflags: 0x4
// Checksum 0xd443cd5f, Offset: 0xbf8
// Size: 0xa6
function private function_aa9e9a84(substate) {
    if (!isdefined(substate)) {
        return false;
    }
    return substate == #"pain" || substate == #"inplace_pain" || substate == #"pain_intro" || substate == #"pain_outro" || substate == #"painrecovery" || substate == #"pronepain";
}

// Namespace archetype_secondary_animations/archetype_secondary_animations
// Params 1, eflags: 0x4
// Checksum 0x70cfe10a, Offset: 0xca8
// Size: 0x5e
function private function_c4678552(substate) {
    if (!isdefined(substate)) {
        return false;
    }
    return substate == #"melee" || substate == #"charge_melee" || substate == #"hash_48dda7ed88efe32f";
}

// Namespace archetype_secondary_animations/archetype_secondary_animations
// Params 1, eflags: 0x4
// Checksum 0x5db79a2a, Offset: 0xd10
// Size: 0x5a0
function private secondaryfacialanimationthink(localclientnum) {
    assert(isdefined(self.archetype) && (self.archetype == "<dev string:x91>" || self.archetype == "<dev string:x97>"));
    self endon(#"death");
    self endon(#"stopfacialthread");
    self._currentfacestate = "inactive";
    while (true) {
        if (self.archetype == "human" && self clientfield::get("facial_dial")) {
            self._currentfacestate = "inactive";
            self clearcurrentfacialanim(localclientnum);
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
        } else if (function_aa9e9a84(currentasmstate)) {
            nextfacestate = "pain";
        } else if (function_c4678552(currentasmstate)) {
            nextfacestate = "melee";
        } else if (self asmisshootlayeractive(localclientnum)) {
            nextfacestate = "combat_shoot";
        } else if (self asmisaimlayeractive(localclientnum)) {
            nextfacestate = "combat_aim";
        } else {
            nextfacestate = "combat";
        }
        if (currfacestate == "inactive" || currfacestate != nextfacestate || forcenewanim) {
            assert(isdefined(level.__facialanimationslist[self.archetype][nextfacestate]));
            clearoncompletion = 0;
            if (nextfacestate == "death") {
            }
            animtoplay = array::random(level.__facialanimationslist[self.archetype][nextfacestate]);
            if (isdefined(animoverride)) {
                animtoplay = animoverride;
                assert(nextfacestate != "<dev string:x9e>" || !isanimlooping(localclientnum, animtoplay), "<dev string:x30>" + animtoplay + "<dev string:x56>");
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
// Params 3, eflags: 0x4
// Checksum 0x9dd1b904, Offset: 0x12b8
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
// Checksum 0xf4f11094, Offset: 0x13c0
// Size: 0x134
function private applydeathanim(localclientnum) {
    if (isdefined(self._currentfacestate) && self._currentfacestate == "death") {
        return;
    }
    if (getmigrationstatus(localclientnum)) {
        return;
    }
    if (isdefined(self) && isdefined(level.__facialanimationslist) && isdefined(level.__facialanimationslist[self.archetype]) && isdefined(level.__facialanimationslist[self.archetype][#"death"])) {
        animtoplay = array::random(level.__facialanimationslist[self.archetype][#"death"]);
        animoverride = self getfacialanimoverride(localclientnum);
        if (isdefined(animoverride)) {
            animtoplay = animoverride;
        }
        self._currentfacestate = "death";
        applynewfaceanim(localclientnum, animtoplay);
    }
}

// Namespace archetype_secondary_animations/archetype_secondary_animations
// Params 1, eflags: 0x4
// Checksum 0x8b37953, Offset: 0x1500
// Size: 0x76
function private clearcurrentfacialanim(localclientnum) {
    if (isdefined(self._currentfaceanim) && self hasdobj(localclientnum) && self hasanimtree()) {
        self clearanim(self._currentfaceanim, 0.2);
    }
    self._currentfaceanim = undefined;
}

