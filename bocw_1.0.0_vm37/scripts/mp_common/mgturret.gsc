#namespace mgturret;

// Namespace mgturret/mgturret
// Params 0, eflags: 0x0
// Checksum 0xa3c6db70, Offset: 0x100
// Size: 0x74
function main() {
    level.magic_distance = 24;
    turretinfos = getentarray("turretInfo", "targetname");
    for (index = 0; index < turretinfos.size; index++) {
        turretinfos[index] delete();
    }
}

// Namespace mgturret/mgturret
// Params 1, eflags: 0x0
// Checksum 0x4a67302c, Offset: 0x180
// Size: 0x144
function set_difficulty(difficulty) {
    init_turret_difficulty_settings();
    turrets = getentarray("misc_turret", "classname");
    for (index = 0; index < turrets.size; index++) {
        if (isdefined(turrets[index].script_skilloverride)) {
            switch (turrets[index].script_skilloverride) {
            case #"easy":
                difficulty = "easy";
                break;
            case #"medium":
                difficulty = "medium";
                break;
            case #"hard":
                difficulty = "hard";
                break;
            case #"fu":
                difficulty = "fu";
                break;
            default:
                continue;
            }
        }
        turret_set_difficulty(turrets[index], difficulty);
    }
}

// Namespace mgturret/mgturret
// Params 0, eflags: 0x0
// Checksum 0xf16ff866, Offset: 0x2d0
// Size: 0x3c6
function init_turret_difficulty_settings() {
    level.mgturretsettings[#"easy"][#"convergencetime"] = 2.5;
    level.mgturretsettings[#"easy"][#"suppressiontime"] = 3;
    level.mgturretsettings[#"easy"][#"accuracy"] = 0.38;
    level.mgturretsettings[#"easy"][#"aispread"] = 2;
    level.mgturretsettings[#"easy"][#"playerspread"] = 0.5;
    level.mgturretsettings[#"medium"][#"convergencetime"] = 1.5;
    level.mgturretsettings[#"medium"][#"suppressiontime"] = 3;
    level.mgturretsettings[#"medium"][#"accuracy"] = 0.38;
    level.mgturretsettings[#"medium"][#"aispread"] = 2;
    level.mgturretsettings[#"medium"][#"playerspread"] = 0.5;
    level.mgturretsettings[#"hard"][#"convergencetime"] = 0.8;
    level.mgturretsettings[#"hard"][#"suppressiontime"] = 3;
    level.mgturretsettings[#"hard"][#"accuracy"] = 0.38;
    level.mgturretsettings[#"hard"][#"aispread"] = 2;
    level.mgturretsettings[#"hard"][#"playerspread"] = 0.5;
    level.mgturretsettings[#"fu"][#"convergencetime"] = 0.4;
    level.mgturretsettings[#"fu"][#"suppressiontime"] = 3;
    level.mgturretsettings[#"fu"][#"accuracy"] = 0.38;
    level.mgturretsettings[#"fu"][#"aispread"] = 2;
    level.mgturretsettings[#"fu"][#"playerspread"] = 0.5;
}

// Namespace mgturret/mgturret
// Params 2, eflags: 0x0
// Checksum 0x25d4f685, Offset: 0x6a0
// Size: 0xda
function turret_set_difficulty(turret, difficulty) {
    turret.convergencetime = level.mgturretsettings[difficulty][#"convergencetime"];
    turret.suppressiontime = level.mgturretsettings[difficulty][#"suppressiontime"];
    turret.script_accuracy = level.mgturretsettings[difficulty][#"accuracy"];
    turret.aispread = level.mgturretsettings[difficulty][#"aispread"];
    turret.playerspread = level.mgturretsettings[difficulty][#"playerspread"];
}

// Namespace mgturret/mgturret
// Params 1, eflags: 0x0
// Checksum 0x5e8be2af, Offset: 0x788
// Size: 0xd4
function turret_suppression_fire(targets) {
    self endon(#"death", #"stop_suppression_fire");
    if (!isdefined(self.suppresionfire)) {
        self.suppresionfire = 1;
    }
    for (;;) {
        while (self.suppresionfire) {
            self turretsettarget(0, targets[randomint(targets.size)]);
            wait 2 + randomfloat(2);
        }
        self turretcleartarget(0);
        while (!self.suppresionfire) {
            wait 1;
        }
    }
}

// Namespace mgturret/mgturret
// Params 1, eflags: 0x0
// Checksum 0xa8b5785a, Offset: 0x868
// Size: 0x76
function burst_fire_settings(setting) {
    if (setting == "delay") {
        return 0.2;
    }
    if (setting == "delay_range") {
        return 0.5;
    }
    if (setting == "burst") {
        return 0.5;
    }
    if (setting == "burst_range") {
        return 4;
    }
}

// Namespace mgturret/mgturret
// Params 2, eflags: 0x0
// Checksum 0xccd0769a, Offset: 0x8e8
// Size: 0x1da
function burst_fire(turret, manual_target) {
    turret endon(#"death", #"stopfiring");
    self endon(#"stop_using_built_in_burst_fire");
    if (isdefined(turret.script_delay_min)) {
        turret_delay = turret.script_delay_min;
    } else {
        turret_delay = burst_fire_settings("delay");
    }
    if (isdefined(turret.script_delay_max)) {
        turret_delay_range = turret.script_delay_max - turret_delay;
    } else {
        turret_delay_range = burst_fire_settings("delay_range");
    }
    if (isdefined(turret.script_burst_min)) {
        turret_burst = turret.script_burst_min;
    } else {
        turret_burst = burst_fire_settings("burst");
    }
    if (isdefined(turret.script_burst_max)) {
        turret_burst_range = turret.script_burst_max - turret_burst;
    } else {
        turret_burst_range = burst_fire_settings("burst_range");
    }
    while (true) {
        if (isdefined(manual_target)) {
            turret thread random_spread(manual_target);
        }
        turret do_shoot();
        wait turret_burst + randomfloat(turret_burst_range);
        wait turret_delay + randomfloat(turret_delay_range);
    }
}

// Namespace mgturret/mgturret
// Params 0, eflags: 0x0
// Checksum 0x163876d6, Offset: 0xad0
// Size: 0x37e
function burst_fire_unmanned() {
    self notify(#"stop_burst_fire_unmanned");
    self endon(#"stop_burst_fire_unmanned", #"death", #"remote_start");
    level endon(#"game_ended");
    if (isdefined(self.controlled) && self.controlled) {
        return;
    }
    if (isdefined(self.script_delay_min)) {
        turret_delay = self.script_delay_min;
    } else {
        turret_delay = burst_fire_settings("delay");
    }
    if (isdefined(self.script_delay_max)) {
        turret_delay_range = self.script_delay_max - turret_delay;
    } else {
        turret_delay_range = burst_fire_settings("delay_range");
    }
    if (isdefined(self.script_burst_min)) {
        turret_burst = self.script_burst_min;
    } else {
        turret_burst = burst_fire_settings("burst");
    }
    if (isdefined(self.script_burst_max)) {
        turret_burst_range = self.script_burst_max - turret_burst;
    } else {
        turret_burst_range = burst_fire_settings("burst_range");
    }
    pauseuntiltime = gettime();
    turretstate = "start";
    self.script_shooting = 0;
    for (;;) {
        if (isdefined(self.manual_targets)) {
            self turretcleartarget(0);
            self turretsettarget(0, self.manual_targets[randomint(self.manual_targets.size)]);
        }
        duration = (pauseuntiltime - gettime()) * 0.001;
        if (duration <= 0) {
            if (turretstate != "fire") {
                turretstate = "fire";
                self playsound(#"mpl_turret_alert");
                self thread do_shoot();
                self.script_shooting = 1;
            }
            duration = turret_burst + randomfloat(turret_burst_range);
            self thread turret_timer(duration);
            self waittill(#"turretstatechange");
            self.script_shooting = 0;
            duration = turret_delay + randomfloat(turret_delay_range);
            pauseuntiltime = gettime() + int(duration * 1000);
            continue;
        }
        if (turretstate != "aim") {
            turretstate = "aim";
        }
        self thread turret_timer(duration);
        self waittill(#"turretstatechange");
    }
}

// Namespace mgturret/mgturret
// Params 0, eflags: 0x0
// Checksum 0xd5408d79, Offset: 0xe58
// Size: 0x34
function do_shoot() {
    self endon(#"death", #"turretstatechange");
    for (;;) {
        wait 0.112;
    }
}

// Namespace mgturret/mgturret
// Params 1, eflags: 0x0
// Checksum 0xeac16dca, Offset: 0xe98
// Size: 0x4e
function turret_timer(duration) {
    if (duration <= 0) {
        return;
    }
    self endon(#"turretstatechange");
    wait duration;
    if (isdefined(self)) {
        self notify(#"turretstatechange");
    }
}

// Namespace mgturret/mgturret
// Params 1, eflags: 0x0
// Checksum 0x8ba13ae3, Offset: 0xef0
// Size: 0x148
function random_spread(ent) {
    self endon(#"death");
    self notify(#"stop random_spread");
    self endon(#"stop random_spread", #"stopfiring");
    self turretsettarget(0, ent);
    self.manual_target = ent;
    while (true) {
        if (isplayer(ent)) {
            ent.origin = self.manual_target getorigin();
        } else {
            ent.origin = self.manual_target.origin;
        }
        ent.origin += (20 - randomfloat(40), 20 - randomfloat(40), 20 - randomfloat(60));
        wait 0.2;
    }
}

