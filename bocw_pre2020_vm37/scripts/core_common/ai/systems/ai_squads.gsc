#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;

#namespace aisquads;

// Namespace aisquads
// Method(s) 9 Total 9
class aisquad {

    var squadbreadcrumb;
    var squadleader;
    var squadmembers;

    // Namespace aisquad/ai_squads
    // Params 0, eflags: 0x9 linked
    // Checksum 0xfbc05bab, Offset: 0x168
    // Size: 0x26
    constructor() {
        squadleader = 0;
        squadmembers = [];
        squadbreadcrumb = [];
    }

    // Namespace aisquad/ai_squads
    // Params 0, eflags: 0x1 linked
    // Checksum 0x3c01aa26, Offset: 0x270
    // Size: 0xa
    function getmembers() {
        return squadmembers;
    }

    // Namespace aisquad/ai_squads
    // Params 1, eflags: 0x1 linked
    // Checksum 0x7f6e4abb, Offset: 0x310
    // Size: 0x5e
    function removeaifromsqaud(ai) {
        if (isinarray(squadmembers, ai)) {
            arrayremovevalue(squadmembers, ai, 0);
            if (squadleader === ai) {
                squadleader = undefined;
            }
        }
    }

    // Namespace aisquad/ai_squads
    // Params 0, eflags: 0x1 linked
    // Checksum 0x1bb7923a, Offset: 0x240
    // Size: 0xa
    function getsquadbreadcrumb() {
        return squadbreadcrumb;
    }

    // Namespace aisquad/ai_squads
    // Params 0, eflags: 0x1 linked
    // Checksum 0x4b895cb5, Offset: 0x378
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

    // Namespace aisquad/ai_squads
    // Params 1, eflags: 0x1 linked
    // Checksum 0x96db39f9, Offset: 0x198
    // Size: 0x9e
    function addsquadbreadcrumbs(ai) {
        assert(squadleader == ai);
        if (distance2dsquared(squadbreadcrumb, ai.origin) >= 9216) {
            /#
                recordcircle(ai.origin, 4, (0, 0, 1), "<dev string:x38>", ai);
            #/
            squadbreadcrumb = ai.origin;
        }
    }

    // Namespace aisquad/ai_squads
    // Params 1, eflags: 0x1 linked
    // Checksum 0x87e925d6, Offset: 0x288
    // Size: 0x7c
    function addaitosquad(ai) {
        if (!isinarray(squadmembers, ai)) {
            if (ai.archetype == #"robot") {
                ai ai::set_behavior_attribute("move_mode", "squadmember");
            }
            squadmembers[squadmembers.size] = ai;
        }
    }

    // Namespace aisquad/ai_squads
    // Params 0, eflags: 0x1 linked
    // Checksum 0xef961bbb, Offset: 0x258
    // Size: 0xa
    function getleader() {
        return squadleader;
    }

}

// Namespace aisquads/ai_squads
// Params 0, eflags: 0x6
// Checksum 0xe7a76bb1, Offset: 0xa8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"ai_squads", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace aisquads/ai_squads
// Params 0, eflags: 0x5 linked
// Checksum 0xa4614869, Offset: 0xf0
// Size: 0x6c
function private function_70a657d8() {
    level._squads = [];
    actorspawnerarray = getactorspawnerteamarray(#"axis");
    array::run_all(actorspawnerarray, &spawner::add_spawn_function, &squadmemberthink);
}

// Namespace aisquads/ai_squads
// Params 1, eflags: 0x5 linked
// Checksum 0x65466b22, Offset: 0x5f0
// Size: 0x3c
function private createsquad(squadname) {
    level._squads[squadname] = new aisquad();
    return level._squads[squadname];
}

// Namespace aisquads/ai_squads
// Params 1, eflags: 0x5 linked
// Checksum 0x7178140, Offset: 0x638
// Size: 0x44
function private removesquad(squadname) {
    if (isdefined(level._squads) && isdefined(level._squads[squadname])) {
        level._squads[squadname] = undefined;
    }
}

// Namespace aisquads/ai_squads
// Params 1, eflags: 0x5 linked
// Checksum 0x6bc80a6a, Offset: 0x688
// Size: 0x1c
function private getsquad(squadname) {
    return level._squads[squadname];
}

// Namespace aisquads/ai_squads
// Params 1, eflags: 0x5 linked
// Checksum 0x341f8151, Offset: 0x6b0
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
// Params 0, eflags: 0x5 linked
// Checksum 0xb2d43f60, Offset: 0x718
// Size: 0x60
function private squadmemberdeath() {
    self waittill(#"death");
    if (isdefined(self.squadname) && isdefined(level._squads[self.squadname])) {
        [[ level._squads[self.squadname] ]]->removeaifromsqaud(self);
    }
}

// Namespace aisquads/ai_squads
// Params 0, eflags: 0x5 linked
// Checksum 0x4c3a7b83, Offset: 0x780
// Size: 0x40e
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
        if (is_true(newsquadcreated)) {
            level thread thinksquad(self.squadname);
        }
        while (true) {
            squadleader = [[ level._squads[self.squadname] ]]->getleader();
            if (isdefined(squadleader) && !(isint(squadleader) && squadleader == 0)) {
                if (squadleader == self) {
                    /#
                        recordenttext(self.squadname + "<dev string:x46>", self, (0, 1, 0), "<dev string:x38>");
                    #/
                    /#
                        recordenttext(self.squadname + "<dev string:x46>", self, (0, 1, 0), "<dev string:x38>");
                    #/
                    /#
                        recordcircle(self.origin, 300, (1, 0.5, 0), "<dev string:x38>", self);
                    #/
                    if (isdefined(self.enemy)) {
                        self setgoal(self.enemy);
                    }
                    [[ squad ]]->addsquadbreadcrumbs(self);
                } else {
                    /#
                        recordline(self.origin, squadleader.origin, (0, 1, 0), "<dev string:x38>", self);
                    #/
                    /#
                        recordenttext(self.squadname + "<dev string:x52>", self, (0, 1, 0), "<dev string:x38>");
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
// Checksum 0x3f88bc37, Offset: 0xb98
// Size: 0xb6
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
// Params 1, eflags: 0x1 linked
// Checksum 0x631fcd9b, Offset: 0xc58
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
// Checksum 0x4c2c709e, Offset: 0xcc8
// Size: 0x72
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
// Params 1, eflags: 0x1 linked
// Checksum 0x5b1de841, Offset: 0xd48
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

