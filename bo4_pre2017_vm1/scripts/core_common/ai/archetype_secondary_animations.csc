#using scripts/core_common/ai_shared;
#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;

#namespace archetype_secondary_animations;

// Namespace archetype_secondary_animations/archetype_secondary_animations
// Params 0, eflags: 0x2
// Checksum 0x70775af1, Offset: 0x3e0
// Size: 0xa4
function autoexec main() {
    if (sessionmodeiszombiesgame() && getdvarint("splitscreen_playerCount") > 2) {
        return;
    }
    ai::add_archetype_spawn_function("human", &secondaryanimationsinit);
    ai::add_archetype_spawn_function("zombie", &secondaryanimationsinit);
    ai::add_ai_spawn_function(&on_entity_spawn);
}

// Namespace archetype_secondary_animations/archetype_secondary_animations
// Params 1, eflags: 0x4
// Checksum 0x2b0ef458, Offset: 0x490
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
// Checksum 0x1793b440, Offset: 0x508
// Size: 0x5c
function private on_entity_spawn(localclientnum) {
    if (self hasdobj(localclientnum)) {
        self clearanim(generic%faces, 0);
    }
    self._currentfacestate = "inactive";
}

// Namespace archetype_secondary_animations/archetype_secondary_animations
// Params 1, eflags: 0x4
// Checksum 0x9f4d137b, Offset: 0x570
// Size: 0x6c
function private on_entity_shutdown(localclientnum) {
    if (isdefined(self)) {
        self notify(#"stopFacialThread");
        if (isdefined(self.facialdeathanimstarted) && self.facialdeathanimstarted) {
            return;
        }
        self applydeathanim(localclientnum);
        self.facialdeathanimstarted = 1;
    }
}

// Namespace archetype_secondary_animations/archetype_secondary_animations
// Params 1, eflags: 0x0
// Checksum 0xa796d4dd, Offset: 0x5e8
// Size: 0x5ca
function buildandvalidatefacialanimationlist(localclientnum) {
    /#
        assert(!isdefined(level.__facialanimationslist));
    #/
    level.__facialanimationslist = [];
    level.__facialanimationslist["human"] = [];
    level.__facialanimationslist["human"]["combat"] = array("ai_face_male_generic_idle_1", "ai_face_male_generic_idle_2", "ai_face_male_generic_idle_3");
    level.__facialanimationslist["human"]["combat_aim"] = array("ai_face_male_aim_idle_1", "ai_face_male_aim_idle_2", "ai_face_male_aim_idle_3");
    level.__facialanimationslist["human"]["combat_shoot"] = array("ai_face_male_aim_fire_1", "ai_face_male_aim_fire_2", "ai_face_male_aim_fire_3");
    level.__facialanimationslist["human"]["death"] = array("ai_face_male_death_1", "ai_face_male_death_2", "ai_face_male_death_3");
    level.__facialanimationslist["human"]["melee"] = array("ai_face_male_melee_1");
    level.__facialanimationslist["human"]["pain"] = array("ai_face_male_pain_1");
    level.__facialanimationslist["human"]["animscripted"] = array("ai_face_male_generic_idle_1");
    level.__facialanimationslist["zombie"] = [];
    level.__facialanimationslist["zombie"]["combat"] = array("ai_face_zombie_generic_idle_1");
    level.__facialanimationslist["zombie"]["combat_aim"] = array("ai_face_zombie_generic_idle_1");
    level.__facialanimationslist["zombie"]["combat_shoot"] = array("ai_face_zombie_generic_idle_1");
    level.__facialanimationslist["zombie"]["death"] = array("ai_face_zombie_generic_death_1");
    level.__facialanimationslist["zombie"]["melee"] = array("ai_face_zombie_generic_attack_1");
    level.__facialanimationslist["zombie"]["pain"] = array("ai_face_zombie_generic_pain_1");
    level.__facialanimationslist["zombie"]["animscripted"] = array("ai_face_zombie_generic_idle_1");
    deathanims = [];
    foreach (animation in level.__facialanimationslist["human"]["death"]) {
        array::add(deathanims, animation);
    }
    foreach (animation in level.__facialanimationslist["zombie"]["death"]) {
        array::add(deathanims, animation);
    }
    foreach (deathanim in deathanims) {
        /#
            assert(!isanimlooping(localclientnum, deathanim), "<dev string:x28>" + deathanim + "<dev string:x4e>");
        #/
    }
}

// Namespace archetype_secondary_animations/archetype_secondary_animations
// Params 1, eflags: 0x4
// Checksum 0xacbc492a, Offset: 0xbc0
// Size: 0x18e
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
// Checksum 0xcf15bdea, Offset: 0xd58
// Size: 0x62c
function private secondaryfacialanimationthink(localclientnum) {
    /#
        assert(self.archetype == "<dev string:x89>" || isdefined(self.archetype) && self.archetype == "<dev string:x8f>");
    #/
    self endon(#"death");
    self endon(#"stopFacialThread");
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
                if (!isdefined(self._scriptedanim) || isdefined(scriptedanim) && self._scriptedanim != scriptedanim) {
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
        closestplayer = arraygetclosest(self.origin, level.localplayers, getdvarint("ai_clientFacialCullDist", 2000));
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
        if (isdefined(currentasmstate)) {
            currentasmstate = tolower(currentasmstate);
        }
        if (self asmisterminating(localclientnum)) {
            nextfacestate = "death";
        } else if (asmstatus == "asm_status_inactive") {
            nextfacestate = "animscripted";
        } else if (isdefined(currentasmstate) && issubstr(currentasmstate, "pain")) {
            nextfacestate = "pain";
        } else if (isdefined(currentasmstate) && issubstr(currentasmstate, "melee")) {
            nextfacestate = "melee";
        } else if (self asmisshootlayeractive(localclientnum)) {
            nextfacestate = "combat_shoot";
        } else if (self asmisaimlayeractive(localclientnum)) {
            nextfacestate = "combat_aim";
        } else {
            nextfacestate = "combat";
        }
        if (currfacestate == "inactive" || currfacestate != nextfacestate || forcenewanim) {
            /#
                assert(isdefined(level.__facialanimationslist[self.archetype][nextfacestate]));
            #/
            clearoncompletion = 0;
            if (nextfacestate == "death") {
            }
            animtoplay = array::random(level.__facialanimationslist[self.archetype][nextfacestate]);
            if (isdefined(animoverride)) {
                animtoplay = animoverride;
                /#
                    assert(nextfacestate != "<dev string:x96>" || !isanimlooping(localclientnum, animtoplay), "<dev string:x28>" + animtoplay + "<dev string:x4e>");
                #/
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
// Checksum 0x78612f66, Offset: 0x1390
// Size: 0xfc
function private applynewfaceanim(localclientnum, animation, clearoncompletion) {
    if (!isdefined(clearoncompletion)) {
        clearoncompletion = 0;
    }
    clearcurrentfacialanim(localclientnum);
    if (isdefined(animation)) {
        self._currentfaceanim = animation;
        if (self hasdobj(localclientnum) && self hasanimtree()) {
            self setflaggedanimknob("ai_secondary_facial_anim", animation, 1, 0.1, 1);
            if (clearoncompletion) {
                wait getanimlength(animation);
                clearcurrentfacialanim(localclientnum);
            }
        }
    }
}

// Namespace archetype_secondary_animations/archetype_secondary_animations
// Params 1, eflags: 0x4
// Checksum 0xe29f5348, Offset: 0x1498
// Size: 0x14c
function private applydeathanim(localclientnum) {
    if (isdefined(self._currentfacestate) && self._currentfacestate == "death") {
        return;
    }
    if (getmigrationstatus(localclientnum)) {
        return;
    }
    if (isdefined(self) && isdefined(level.__facialanimationslist) && isdefined(level.__facialanimationslist[self.archetype]) && isdefined(level.__facialanimationslist[self.archetype]["death"])) {
        animtoplay = array::random(level.__facialanimationslist[self.archetype]["death"]);
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
// Checksum 0x141d85f3, Offset: 0x15f0
// Size: 0x7e
function private clearcurrentfacialanim(localclientnum) {
    if (isdefined(self._currentfaceanim) && self hasdobj(localclientnum) && self hasanimtree()) {
        self clearanim(self._currentfaceanim, 0.2);
    }
    self._currentfaceanim = undefined;
}

