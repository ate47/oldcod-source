#using scripts/core_common/ai/archetype_utility;
#using scripts/core_common/ai/systems/blackboard;
#using scripts/core_common/ai/systems/shared;

#namespace blackboard;

/#

    // Namespace blackboard/blackboard_vehicle
    // Params 0, eflags: 0x0
    // Checksum 0x667d52b4, Offset: 0x110
    // Size: 0x34
    function registervehicleblackboardattributes() {
        assert(isvehicle(self), "<dev string:x28>");
    }

#/

// Namespace blackboard/blackboard_vehicle
// Params 0, eflags: 0x0
// Checksum 0x7b45ba9e, Offset: 0x150
// Size: 0x3a
function bb_getspeed() {
    velocity = self getvelocity();
    return length(velocity);
}

// Namespace blackboard/blackboard_vehicle
// Params 0, eflags: 0x0
// Checksum 0xa84392d7, Offset: 0x198
// Size: 0x54
function bb_vehgetenemyyaw() {
    enemy = self.enemy;
    if (!isdefined(enemy)) {
        return 0;
    }
    toenemyyaw = vehgetpredictedyawtoenemy(self, 0.2);
    return toenemyyaw;
}

// Namespace blackboard/blackboard_vehicle
// Params 2, eflags: 0x0
// Checksum 0x6eeb7c99, Offset: 0x1f8
// Size: 0x190
function vehgetpredictedyawtoenemy(entity, lookaheadtime) {
    if (isdefined(entity.predictedyawtoenemy) && isdefined(entity.predictedyawtoenemytime) && entity.predictedyawtoenemytime == gettime()) {
        return entity.predictedyawtoenemy;
    }
    selfpredictedpos = entity.origin;
    moveangle = entity.angles[1] + entity getmotionangle();
    selfpredictedpos += (cos(moveangle), sin(moveangle), 0) * 200 * lookaheadtime;
    yaw = vectortoangles(entity.enemy.origin - selfpredictedpos)[1] - entity.angles[1];
    yaw = absangleclamp360(yaw);
    entity.predictedyawtoenemy = yaw;
    entity.predictedyawtoenemytime = gettime();
    return yaw;
}

