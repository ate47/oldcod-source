#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;

#namespace status_effect_pulse;

// Namespace status_effect_pulse/status_effect_pulse
// Params 0, eflags: 0x2
// Checksum 0x489aa5af, Offset: 0xc8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"status_effect_pulse", &__init__, undefined, undefined);
}

// Namespace status_effect_pulse/status_effect_pulse
// Params 0, eflags: 0x0
// Checksum 0x4c370297, Offset: 0x110
// Size: 0xbc
function __init__() {
    status_effect::register_status_effect_callback_apply(9, &pulse_apply);
    status_effect::function_81221eab(9, &pulse_end);
    status_effect::function_5cf962b4(getstatuseffect("pulse"));
    clientfield::register("toplayer", "pulsed", 1, 1, "int");
    callback::on_spawned(&on_player_spawned);
}

// Namespace status_effect_pulse/status_effect_pulse
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x1d8
// Size: 0x4
function on_player_spawned() {
    
}

// Namespace status_effect_pulse/status_effect_pulse
// Params 3, eflags: 0x0
// Checksum 0xb902dc8f, Offset: 0x1e8
// Size: 0x154
function pulse_apply(var_adce82d2, weapon, applicant) {
    self.owner clientfield::set_to_player("pulsed", 1);
    shutdownpulserebootindicatormenu();
    pulserebootmenu = self.owner openluimenu("EmpRebootIndicator");
    self.owner setluimenudata(pulserebootmenu, #"endtime", int(self.endtime));
    self.owner setluimenudata(pulserebootmenu, #"starttime", int(self.endtime - self.duration));
    self thread pulse_rumble_loop(0.75);
    self.owner setempjammed(1);
}

// Namespace status_effect_pulse/status_effect_pulse
// Params 1, eflags: 0x4
// Checksum 0x2a74ec32, Offset: 0x348
// Size: 0xae
function private pulse_rumble_loop(duration) {
    self endon(#"pulse_rumble_loop");
    self notify(#"pulse_rumble_loop");
    self endon(#"endstatuseffect");
    goaltime = gettime() + int(duration * 1000);
    while (gettime() < goaltime) {
        self.owner playrumbleonentity("damage_heavy");
        waitframe(1);
    }
}

// Namespace status_effect_pulse/status_effect_pulse
// Params 0, eflags: 0x0
// Checksum 0x6aecc95e, Offset: 0x400
// Size: 0x8c
function pulse_end() {
    if (isdefined(self)) {
        shutdownpulserebootindicatormenu();
        if (isdefined(level.emp_shared.enemyempactivefunc)) {
            if (self [[ level.emp_shared.enemyempactivefunc ]]()) {
                return;
            }
        }
        self.owner setempjammed(0);
        self.owner clientfield::set_to_player("pulsed", 0);
    }
}

// Namespace status_effect_pulse/status_effect_pulse
// Params 0, eflags: 0x0
// Checksum 0xe7a38061, Offset: 0x498
// Size: 0x54
function shutdownpulserebootindicatormenu() {
    emprebootmenu = self.owner getluimenu("EmpRebootIndicator");
    if (isdefined(emprebootmenu)) {
        self.owner closeluimenu(emprebootmenu);
    }
}

