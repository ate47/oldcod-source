#using scripts\abilities\gadgets\gadget_vision_pulse;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\mp_common\gametypes\battlechatter;
#using scripts\mp_common\util;

#namespace gadget_vision_pulse;

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 0, eflags: 0x2
// Checksum 0xc63ad204, Offset: 0xa8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"gadget_vision_pulse", &__init__, undefined, undefined);
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 0, eflags: 0x0
// Checksum 0x1815618a, Offset: 0xf0
// Size: 0x4e
function __init__() {
    init_shared();
    function_664b9227(&function_b95105cb);
    level.var_b4fc9d7 = &awardscore;
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 1, eflags: 0x0
// Checksum 0x2156af0c, Offset: 0x148
// Size: 0x92
function function_ebf65709(pulsedenemy) {
    pulsedenemy notify(#"hash_7dc65ec6fe251daf");
    pulsedenemy endon(#"hash_7dc65ec6fe251daf", #"death", #"disconnect");
    wait float(level.weaponvisionpulse.var_c9c3fdbb) / 1000;
    if (isdefined(pulsedenemy)) {
        pulsedenemy.ispulsed = 0;
    }
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 1, eflags: 0x0
// Checksum 0x6917b831, Offset: 0x1e8
// Size: 0x74
function function_b95105cb(pulsedenemy) {
    self battlechatter::function_b505bc94(getweapon(#"gadget_vision_pulse"), pulsedenemy, pulsedenemy.origin, self, 2);
    pulsedenemy.ispulsed = 1;
    thread function_ebf65709(pulsedenemy);
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 2, eflags: 0x0
// Checksum 0x48a72996, Offset: 0x268
// Size: 0xac
function function_9cdafa92(victim, waittime) {
    self endon(#"disconnect", #"death", #"emp_vp_jammed");
    wait float(waittime) / 1000;
    if (isalive(victim)) {
        scoreevents::processscoreevent(#"hash_5fa940b319171088", self, victim, level.weaponvisionpulse);
    }
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 0, eflags: 0x0
// Checksum 0xc3adb2a5, Offset: 0x320
// Size: 0x208
function awardscore() {
    self endon(#"disconnect", #"death", #"emp_vp_jammed");
    waittime = level.weaponvisionpulse.gadget_pulse_duration / 3;
    radius = level.weaponvisionpulse.gadget_pulse_max_range;
    for (i = 0; i < 3; i++) {
        enemyteam = getplayers(util::getotherteam(self.team), self.origin, radius);
        if (isarray(enemyteam)) {
            foreach (enemy in enemyteam) {
                if (isalive(enemy)) {
                    var_921670b7 = distance2d(self.origin, enemy.origin);
                    if (var_921670b7 > level.weaponvisionpulse.gadget_pulse_max_range) {
                        continue;
                    }
                    timetotarget = var_921670b7 / level.weaponvisionpulse.var_109dc967;
                    self thread function_9cdafa92(enemy, timetotarget);
                }
            }
        }
        wait float(waittime) / 1000;
    }
}

