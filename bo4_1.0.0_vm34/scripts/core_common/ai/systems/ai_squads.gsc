#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;

#namespace aisquads;

// Namespace aisquads
// Method(s) 9 Total 9
class squad {

    var squadbreadcrumb;
    var squadleader;
    var squadmembers;

    // Namespace squad/ai_squads
    // Params 0, eflags: 0x8
    // Checksum 0xc22a3800, Offset: 0x170
    // Size: 0x26
    constructor() {
        squadleader = 0;
        squadmembers = [];
        squadbreadcrumb = [];
    }

    // Namespace squad/ai_squads
    // Params 0, eflags: 0x0
    // Checksum 0xd4ffe309, Offset: 0x380
    // Size: 0x86
    function think() {
        if (isint(squadleader) && squadleader == 0 || !isdefined(squadleader)) {
            if (squadmembers.size > 0) {
                squadleader = squadmembers[0];
                squadbreadcrumb = squadleader.origin;
            } else {
                return false;
            }
        }
        return true;
    }

    // Namespace squad/ai_squads
    // Params 1, eflags: 0x0
    // Checksum 0x66fcff7, Offset: 0x318
    // Size: 0x5e
    function removeaifromsqaud(ai) {
        if (isinarray(squadmembers, ai)) {
            arrayremovevalue(squadmembers, ai, 0);
            if (squadleader === ai) {
                squadleader = undefined;
            }
        }
    }

    // Namespace squad/ai_squads
    // Params 1, eflags: 0x0
    // Checksum 0xa8213ff8, Offset: 0x290
    // Size: 0x7e
    function addaitosquad(ai) {
        if (!isinarray(squadmembers, ai)) {
            if (ai.archetype == "robot") {
                ai ai::set_behavior_attribute("move_mode", "squadmember");
            }
            squadmembers[squadmembers.size] = ai;
        }
    }

    // Namespace squad/ai_squads
    // Params 0, eflags: 0x0
    // Checksum 0x9e3ff094, Offset: 0x278
    // Size: 0xa
    function getmembers() {
        return squadmembers;
    }

    // Namespace squad/ai_squads
    // Params 0, eflags: 0x0
    // Checksum 0x7481d781, Offset: 0x260
    // Size: 0xa
    function getleader() {
        return squadleader;
    }

    // Namespace squad/ai_squads
    // Params 0, eflags: 0x0
    // Checksum 0x31165a48, Offset: 0x248
    // Size: 0xa
    function getsquadbreadcrumb() {
        return squadbreadcrumb;
    }

    // Namespace squad/ai_squads
    // Params 1, eflags: 0x0
    // Checksum 0xb6a3e39f, Offset: 0x1a0
    // Size: 0x9e
    function addsquadbreadcrumbs(ai) {
        assert(squadleader == ai);
        if (distance2dsquared(squadbreadcrumb, ai.origin) >= 9216) {
            /#
                recordcircle(ai.origin, 4, (0, 0, 1), "<dev string:x30>", ai);
            #/
            squadbreadcrumb = ai.origin;
        }
    }

}

// Namespace aisquads/ai_squads
// Params 0, eflags: 0x2
// Checksum 0xdb3b2fa7, Offset: 0xb0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"ai_squads", &__init__, undefined, undefined);
}

// Namespace aisquads/ai_squads
// Params 0, eflags: 0x0
// Checksum 0xd27b7d44, Offset: 0xf8
// Size: 0x6c
function __init__() {
    level._squads = [];
    actorspawnerarray = getactorspawnerteamarray(#"axis");
    array::run_all(actorspawnerarray, &spawner::add_spawn_function, &squadmemberthink);
}

// Namespace aisquads/ai_squads
// Params 1, eflags: 0x4
// Checksum 0x8e016f94, Offset: 0x600
// Size: 0x3c
function private createsquad(squadname) {
    level._squads[squadname] = new squad();
    return level._squads[squadname];
}

// Namespace aisquads/ai_squads
// Params 1, eflags: 0x4
// Checksum 0xf835b04a, Offset: 0x648
// Size: 0x44
function private removesquad(squadname) {
    if (isdefined(level._squads) && isdefined(level._squads[squadname])) {
        level._squads[squadname] = undefined;
    }
}

// Namespace aisquads/ai_squads
// Params 1, eflags: 0x4
// Checksum 0xe3891714, Offset: 0x698
// Size: 0x1c
function private getsquad(squadname) {
    return level._squads[squadname];
}

// Namespace aisquads/ai_squads
// Params 1, eflags: 0x4
// Checksum 0x10f1b83c, Offset: 0x6c0
// Size: 0x5c
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
// Checksum 0x67554947, Offset: 0x728
// Size: 0x60
function private squadmemberdeath() {
    self waittill(#"death");
    if (isdefined(self.squadname) && isdefined(level._squads[self.squadname])) {
        [[ level._squads[self.squadname] ]]->removeaifromsqaud(self);
    }
}

// Namespace aisquads/ai_squads
// Params 0, eflags: 0x4
// Checksum 0x1be9a60b, Offset: 0x790
// Size: 0x416
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
                        recordenttext(self.squadname + "<dev string:x3b>", self, (0, 1, 0), "<dev string:x30>");
                    #/
                    /#
                        recordenttext(self.squadname + "<dev string:x3b>", self, (0, 1, 0), "<dev string:x30>");
                    #/
                    /#
                        recordcircle(self.origin, 300, (1, 0.5, 0), "<dev string:x30>", self);
                    #/
                    if (isdefined(self.enemy)) {
                        self setgoal(self.enemy);
                    }
                    [[ squad ]]->addsquadbreadcrumbs(self);
                } else {
                    /#
                        recordline(self.origin, squadleader.origin, (0, 1, 0), "<dev string:x30>", self);
                    #/
                    /#
                        recordenttext(self.squadname + "<dev string:x44>", self, (0, 1, 0), "<dev string:x30>");
                    #/
                    followposition = [[ squad ]]->getsquadbreadcrumb();
                    followdistsq = distance2dsquared(self.goalpos, followposition);
                    if (isdefined(squadleader.enemy)) {
                        if (!isdefined(self.enemy) || isdefined(self.enemy) && self.enemy != squadleader.enemy) {
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
// Checksum 0x6903397f, Offset: 0xbb0
// Size: 0xba
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
// Checksum 0xc30d0608, Offset: 0xc78
// Size: 0x66
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
// Checksum 0xe1f9151b, Offset: 0xce8
// Size: 0x76
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
// Checksum 0x5a08be90, Offset: 0xd68
// Size: 0x56
function getsquadleader(ai) {
    if (isdefined(ai.squadname)) {
        squad = getsquad(ai.squadname);
        if (isdefined(squad)) {
            return [[ squad ]]->getleader();
        }
    }
    return undefined;
}

