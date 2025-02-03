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
    // Params 0, eflags: 0x8
    // Checksum 0x7e6ac137, Offset: 0x168
    // Size: 0x26
    constructor() {
        squadleader = 0;
        squadmembers = [];
        squadbreadcrumb = [];
    }

    // Namespace aisquad/ai_squads
    // Params 0, eflags: 0x0
    // Checksum 0xefbfc7a6, Offset: 0x270
    // Size: 0xa
    function getmembers() {
        return squadmembers;
    }

    // Namespace aisquad/ai_squads
    // Params 1, eflags: 0x0
    // Checksum 0xed550fb5, Offset: 0x310
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
    // Params 0, eflags: 0x0
    // Checksum 0x1f89ccfc, Offset: 0x240
    // Size: 0xa
    function getsquadbreadcrumb() {
        return squadbreadcrumb;
    }

    // Namespace aisquad/ai_squads
    // Params 0, eflags: 0x0
    // Checksum 0xdf570bb3, Offset: 0x378
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
    // Params 1, eflags: 0x0
    // Checksum 0x120feef3, Offset: 0x198
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
    // Params 1, eflags: 0x0
    // Checksum 0x18daa5a5, Offset: 0x288
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
    // Params 0, eflags: 0x0
    // Checksum 0x36d0bb37, Offset: 0x258
    // Size: 0xa
    function getleader() {
        return squadleader;
    }

}

// Namespace aisquads/ai_squads
// Params 0, eflags: 0x6
// Checksum 0x2e9f817f, Offset: 0xa8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"ai_squads", &preinit, undefined, undefined, undefined);
}

// Namespace aisquads/ai_squads
// Params 0, eflags: 0x4
// Checksum 0x8ffdd0ba, Offset: 0xf0
// Size: 0x6c
function private preinit() {
    level._squads = [];
    actorspawnerarray = getactorspawnerteamarray(#"axis");
    array::run_all(actorspawnerarray, &spawner::add_spawn_function, &squadmemberthink);
}

// Namespace aisquads/ai_squads
// Params 1, eflags: 0x4
// Checksum 0xc50c681d, Offset: 0x5f0
// Size: 0x3c
function private createsquad(squadname) {
    level._squads[squadname] = new aisquad();
    return level._squads[squadname];
}

// Namespace aisquads/ai_squads
// Params 1, eflags: 0x4
// Checksum 0xec07104f, Offset: 0x638
// Size: 0x44
function private removesquad(squadname) {
    if (isdefined(level._squads) && isdefined(level._squads[squadname])) {
        level._squads[squadname] = undefined;
    }
}

// Namespace aisquads/ai_squads
// Params 1, eflags: 0x4
// Checksum 0x642a7471, Offset: 0x688
// Size: 0x1c
function private getsquad(squadname) {
    return level._squads[squadname];
}

// Namespace aisquads/ai_squads
// Params 1, eflags: 0x4
// Checksum 0x6148a71, Offset: 0x6b0
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
// Checksum 0x5e7066d4, Offset: 0x718
// Size: 0x60
function private squadmemberdeath() {
    self waittill(#"death");
    if (isdefined(self.squadname) && isdefined(level._squads[self.squadname])) {
        [[ level._squads[self.squadname] ]]->removeaifromsqaud(self);
    }
}

// Namespace aisquads/ai_squads
// Params 0, eflags: 0x4
// Checksum 0xdc5a0450, Offset: 0x780
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
// Checksum 0x44afbd54, Offset: 0xb98
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
// Params 1, eflags: 0x0
// Checksum 0xdf0d1a3d, Offset: 0xc58
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
// Checksum 0x543a647d, Offset: 0xcc8
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
// Params 1, eflags: 0x0
// Checksum 0x8840d283, Offset: 0xd48
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

