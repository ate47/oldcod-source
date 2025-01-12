#using scripts/core_common/ai_shared;
#using scripts/core_common/array_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/system_shared;
#using scripts/core_common/trigger_shared;
#using scripts/core_common/util_shared;

#namespace aisquads;

// Namespace aisquads/ai_squads
// Params 0, eflags: 0x2
// Checksum 0xa7d0819, Offset: 0x1c0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("ai_squads", &__init__, undefined, undefined);
}

// Namespace aisquads/ai_squads
// Params 0, eflags: 0x0
// Checksum 0x40ce907c, Offset: 0x200
// Size: 0x6c
function __init__() {
    level._squads = [];
    actorspawnerarray = getactorspawnerteamarray("axis");
    array::run_all(actorspawnerarray, &spawner::add_spawn_function, &squadmemberthink);
}

#namespace squad;

// Namespace squad/ai_squads
// Params 0, eflags: 0x0
// Checksum 0x28cad7ba, Offset: 0x278
// Size: 0x28
function __constructor() {
    self.squadleader = 0;
    self.squadmembers = [];
    self.squadbreadcrumb = [];
}

// Namespace squad/ai_squads
// Params 1, eflags: 0x0
// Checksum 0xc91dbcbc, Offset: 0x2a8
// Size: 0xb4
function addsquadbreadcrumbs(ai) {
    /#
        assert(self.squadleader == ai);
    #/
    if (distance2dsquared(self.squadbreadcrumb, ai.origin) >= 9216) {
        /#
            recordcircle(ai.origin, 4, (0, 0, 1), "<dev string:x28>", ai);
        #/
        self.squadbreadcrumb = ai.origin;
    }
}

// Namespace squad/ai_squads
// Params 0, eflags: 0x0
// Checksum 0xc8394992, Offset: 0x368
// Size: 0xe
function getsquadbreadcrumb() {
    return self.squadbreadcrumb;
}

// Namespace squad/ai_squads
// Params 0, eflags: 0x0
// Checksum 0x43f5abea, Offset: 0x380
// Size: 0xe
function getleader() {
    return self.squadleader;
}

// Namespace squad/ai_squads
// Params 0, eflags: 0x0
// Checksum 0xd7295fd0, Offset: 0x398
// Size: 0xe
function getmembers() {
    return self.squadmembers;
}

// Namespace squad/ai_squads
// Params 1, eflags: 0x0
// Checksum 0x4e5c60c, Offset: 0x3b0
// Size: 0x8a
function addaitosquad(ai) {
    if (!isinarray(self.squadmembers, ai)) {
        if (ai.archetype == "robot") {
            ai ai::set_behavior_attribute("move_mode", "squadmember");
        }
        self.squadmembers[self.squadmembers.size] = ai;
    }
}

// Namespace squad/ai_squads
// Params 1, eflags: 0x0
// Checksum 0xbf90d7bd, Offset: 0x448
// Size: 0x6c
function removeaifromsqaud(ai) {
    if (isinarray(self.squadmembers, ai)) {
        arrayremovevalue(self.squadmembers, ai, 0);
        if (self.squadleader === ai) {
            self.squadleader = undefined;
        }
    }
}

// Namespace squad/ai_squads
// Params 0, eflags: 0x0
// Checksum 0xc698fc82, Offset: 0x4c0
// Size: 0x90
function think() {
    if (isint(self.squadleader) && self.squadleader == 0 || !isdefined(self.squadleader)) {
        if (self.squadmembers.size > 0) {
            self.squadleader = self.squadmembers[0];
            self.squadbreadcrumb = self.squadleader.origin;
        } else {
            return false;
        }
    }
    return true;
}

// Namespace squad/ai_squads
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x558
// Size: 0x4
function __destructor() {
    
}

#namespace aisquads;

// Namespace aisquads/ai_squads
// Params 0, eflags: 0x6
// Checksum 0x25c26923, Offset: 0x568
// Size: 0x1d6
function private autoexec squad() {
    classes.squad[0] = spawnstruct();
    classes.squad[0].__vtable[1606033458] = &squad::__destructor;
    classes.squad[0].__vtable[1077602763] = &squad::think;
    classes.squad[0].__vtable[-956678077] = &squad::removeaifromsqaud;
    classes.squad[0].__vtable[2131588255] = &squad::addaitosquad;
    classes.squad[0].__vtable[16176468] = &squad::getmembers;
    classes.squad[0].__vtable[-667235832] = &squad::getleader;
    classes.squad[0].__vtable[-407785572] = &squad::getsquadbreadcrumb;
    classes.squad[0].__vtable[-997895106] = &squad::addsquadbreadcrumbs;
    classes.squad[0].__vtable[-1690805083] = &squad::__constructor;
}

// Namespace aisquads/ai_squads
// Params 1, eflags: 0x4
// Checksum 0x7bbfd321, Offset: 0x748
// Size: 0x40
function private createsquad(squadname) {
    [[ new squad ]]->__constructor();
    level._squads[squadname] = <error pop>;
    return level._squads[squadname];
}

// Namespace aisquads/ai_squads
// Params 1, eflags: 0x4
// Checksum 0x57b2da87, Offset: 0x790
// Size: 0x44
function private removesquad(squadname) {
    if (isdefined(level._squads) && isdefined(level._squads[squadname])) {
        level._squads[squadname] = undefined;
    }
}

// Namespace aisquads/ai_squads
// Params 1, eflags: 0x4
// Checksum 0x8e79d246, Offset: 0x7e0
// Size: 0x1c
function private getsquad(squadname) {
    return level._squads[squadname];
}

// Namespace aisquads/ai_squads
// Params 1, eflags: 0x4
// Checksum 0xccc4c0c0, Offset: 0x808
// Size: 0x64
function private thinksquad(squadname) {
    while (true) {
        if ([[ level._squads[squadname] ]]->think()) {
            wait 0.5;
            continue;
        }
        removesquad(squadname);
        break;
    }
}

// Namespace aisquads/ai_squads
// Params 0, eflags: 0x4
// Checksum 0xd11d52be, Offset: 0x878
// Size: 0x64
function private squadmemberdeath() {
    self waittill("death");
    if (isdefined(self.squadname) && isdefined(level._squads[self.squadname])) {
        [[ level._squads[self.squadname] ]]->removeaifromsqaud(self);
    }
}

// Namespace aisquads/ai_squads
// Params 0, eflags: 0x4
// Checksum 0xbee1cd20, Offset: 0x8e8
// Size: 0x456
function private squadmemberthink() {
    self endon(#"death");
    if (!isdefined(self.script_aisquadname)) {
        return;
    }
    wait 0.5;
    self.squadname = self.script_aisquadname;
    if (isdefined(self.squadname)) {
        if (!isdefined(level._squads[self.squadname])) {
            squad = createsquad(self.squadname);
            newsquadcreated = 1;
        } else {
            squad = getsquad(self.squadname);
        }
        [[ squad ]]->addaitosquad(self);
        self thread squadmemberdeath();
        if (isdefined(newsquadcreated) && newsquadcreated) {
            level thread thinksquad(self.squadname);
        }
        while (true) {
            squadleader = [[ level._squads[self.squadname] ]]->getleader();
            if (isdefined(squadleader) && !(isint(squadleader) && squadleader == 0)) {
                if (squadleader == self) {
                    /#
                        recordenttext(self.squadname + "<dev string:x33>", self, (0, 1, 0), "<dev string:x28>");
                    #/
                    /#
                        recordenttext(self.squadname + "<dev string:x33>", self, (0, 1, 0), "<dev string:x28>");
                    #/
                    /#
                        recordcircle(self.origin, 300, (1, 0.5, 0), "<dev string:x28>", self);
                    #/
                    if (isdefined(self.enemy)) {
                        self setgoal(self.enemy);
                    }
                    [[ squad ]]->addsquadbreadcrumbs(self);
                } else {
                    /#
                        recordline(self.origin, squadleader.origin, (0, 1, 0), "<dev string:x28>", self);
                    #/
                    /#
                        recordenttext(self.squadname + "<dev string:x3c>", self, (0, 1, 0), "<dev string:x28>");
                    #/
                    followposition = [[ squad ]]->getsquadbreadcrumb();
                    followdistsq = distance2dsquared(self.goalpos, followposition);
                    if (isdefined(squadleader.enemy)) {
                        if (isdefined(self.enemy) && (!isdefined(self.enemy) || self.enemy != squadleader.enemy)) {
                            self setentitytarget(squadleader.enemy, 1);
                        }
                    }
                    if (isdefined(self.goalpos) && followdistsq >= 256) {
                        if (followdistsq >= 22500) {
                            self ai::set_behavior_attribute("sprint", 1);
                        } else {
                            self ai::set_behavior_attribute("sprint", 0);
                        }
                        self setgoal(followposition, 1);
                    }
                }
            }
            wait 1;
        }
    }
}

// Namespace aisquads/ai_squads
// Params 1, eflags: 0x0
// Checksum 0xdb39e6a3, Offset: 0xd48
// Size: 0xbc
function isfollowingsquadleader(ai) {
    if (ai ai::get_behavior_attribute("move_mode") != "squadmember") {
        return false;
    }
    squadmember = issquadmember(ai);
    currentsquadleader = getsquadleader(ai);
    isaisquadleader = isdefined(currentsquadleader) && currentsquadleader == ai;
    if (squadmember && !isaisquadleader) {
        return true;
    }
    return false;
}

// Namespace aisquads/ai_squads
// Params 1, eflags: 0x0
// Checksum 0xf8122ada, Offset: 0xe10
// Size: 0x76
function issquadmember(ai) {
    if (isdefined(ai.squadname)) {
        squad = getsquad(ai.squadname);
        if (isdefined(squad)) {
            return isinarray([[ squad ]]->getmembers(), ai);
        }
    }
    return 0;
}

// Namespace aisquads/ai_squads
// Params 1, eflags: 0x0
// Checksum 0xa0e00383, Offset: 0xe90
// Size: 0x88
function issquadleader(ai) {
    if (isdefined(ai.squadname)) {
        squad = getsquad(ai.squadname);
        if (isdefined(squad)) {
            squadleader = [[ squad ]]->getleader();
            return (isdefined(squadleader) && squadleader == ai);
        }
    }
    return false;
}

// Namespace aisquads/ai_squads
// Params 1, eflags: 0x0
// Checksum 0x7d5d150e, Offset: 0xf20
// Size: 0x66
function getsquadleader(ai) {
    if (isdefined(ai.squadname)) {
        squad = getsquad(ai.squadname);
        if (isdefined(squad)) {
            return [[ squad ]]->getleader();
        }
    }
    return undefined;
}

