#using scripts/core_common/ai/archetype_cover_utility;
#using scripts/core_common/ai/archetype_locomotion_utility;
#using scripts/core_common/ai/archetype_utility;
#using scripts/core_common/ai/systems/ai_interface;
#using scripts/core_common/ai/systems/blackboard;
#using scripts/core_common/ai/systems/shared;
#using scripts/core_common/ai_shared;
#using scripts/core_common/array_shared;

#namespace blackboard;

// Namespace blackboard/archetype_human_blackboard
// Params 0, eflags: 0x4
// Checksum 0x447586e2, Offset: 0x350
// Size: 0x36
function private bb_getarrivaltype() {
    if (self ai::get_behavior_attribute("disablearrivals")) {
        return "dont_arrive_at_goal";
    }
    return "arrive_at_goal";
}

// Namespace blackboard/archetype_human_blackboard
// Params 0, eflags: 0x4
// Checksum 0x7cc90d44, Offset: 0x390
// Size: 0x3a
function private bb_gettacticalarrivalfacingyaw() {
    return angleclamp180(self.angles[1] - self.node.angles[1]);
}

// Namespace blackboard/archetype_human_blackboard
// Params 0, eflags: 0x4
// Checksum 0x9a8b0568, Offset: 0x3d8
// Size: 0x1da
function private bb_getlocomotionmovementtype() {
    if (!ai::getaiattribute(self, "disablesprint")) {
        if (ai::getaiattribute(self, "sprint")) {
            return "human_locomotion_movement_sprint";
        }
        if (!isdefined(self.nearbyfriendlycheck)) {
            self.nearbyfriendlycheck = 0;
        }
        now = gettime();
        if (now >= self.nearbyfriendlycheck) {
            self.nearbyfriendlycount = getactorteamcountradius(self.origin, 120, self.team, "neutral");
            self.nearbyfriendlycheck = now + 500;
        }
        if (self.nearbyfriendlycount >= 3) {
            return "human_locomotion_movement_default";
        }
        if (isdefined(self.enemy) && isdefined(self.runandgundist)) {
            if (distancesquared(self.origin, self lastknownpos(self.enemy)) > self.runandgundist * self.runandgundist) {
                return "human_locomotion_movement_sprint";
            }
        } else if (isdefined(self.goalpos) && isdefined(self.runandgundist)) {
            if (distancesquared(self.origin, self.goalpos) > self.runandgundist * self.runandgundist) {
                return "human_locomotion_movement_sprint";
            }
        }
    }
    return "human_locomotion_movement_default";
}

// Namespace blackboard/archetype_human_blackboard
// Params 0, eflags: 0x4
// Checksum 0x24031764, Offset: 0x5c0
// Size: 0x1ce
function private bb_getcoverflankability() {
    if (self asmistransitionrunning()) {
        return "unflankable";
    }
    if (!isdefined(self.node)) {
        return "unflankable";
    }
    covermode = self getblackboardattribute("_cover_mode");
    if (isdefined(covermode)) {
        covernode = self.node;
        if (covermode == "cover_alert" || covermode == "cover_mode_none") {
            return "flankable";
        }
        if (covernode.type == "Cover Pillar") {
            return (covermode == "cover_blind");
        } else if (covernode.type == "Cover Left" || covernode.type == "Cover Right") {
            return (covermode == "cover_blind" || covermode == "cover_over");
        } else if (covernode.type == "Cover Crouch" || covernode.type == "Cover Crouch Window" || covernode.type == "Cover Stand" || covernode.type == "Conceal Stand" || covernode.type == "Conceal Crouch") {
            return "flankable";
        }
    }
    return "unflankable";
}

