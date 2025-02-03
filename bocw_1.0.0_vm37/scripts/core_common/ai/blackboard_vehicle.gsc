#namespace blackboard;

/#

    // Namespace blackboard/blackboard_vehicle
    // Params 0, eflags: 0x0
    // Checksum 0x461f3a2b, Offset: 0x60
    // Size: 0x34
    function registervehicleblackboardattributes() {
        assert(isvehicle(self), "<dev string:x38>");
    }

#/

// Namespace blackboard/blackboard_vehicle
// Params 0, eflags: 0x0
// Checksum 0x41f51406, Offset: 0xa0
// Size: 0x3a
function bb_getspeed() {
    velocity = self getvelocity();
    return length(velocity);
}

// Namespace blackboard/blackboard_vehicle
// Params 0, eflags: 0x0
// Checksum 0x744e507b, Offset: 0xe8
// Size: 0x4a
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
// Checksum 0xc365a4b, Offset: 0x140
// Size: 0x152
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

