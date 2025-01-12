#namespace targetting_delay;

// Namespace targetting_delay/targetting_delay
// Params 1, eflags: 0x0
// Checksum 0xe0786bcb, Offset: 0x68
// Size: 0x41a
function function_3362444f(radius) {
    self endon(#"death");
    level endon(#"game_ended");
    if (!isdefined(radius)) {
        radius = 8000;
    }
    self.var_41d92e29 = {};
    info = self.var_41d92e29;
    info.var_869a18d1 = [];
    info.var_276f3701 = [];
    update_interval = isdefined(self.var_b154c656) ? self.var_b154c656 : min(0.25, 1);
    var_bf1b43ed = int(update_interval * 1000);
    while (true) {
        enemy_players = self getenemiesinradius(self.origin, radius);
        foreach (enemy in enemy_players) {
            if (!isplayer(enemy)) {
                continue;
            }
            delay = int(max(enemy function_4e6e7f24(), 250));
            if (delay <= 0) {
                continue;
            }
            entnum = enemy getentitynumber();
            if (isdefined(info.var_869a18d1[entnum]) && (!isalive(enemy) || isdefined(enemy.lastspawntime) && enemy.lastspawntime > info.var_869a18d1[entnum])) {
                info.var_869a18d1[entnum] = undefined;
                info.var_276f3701[entnum] = undefined;
            }
            if (!isalive(enemy)) {
                continue;
            }
            if (issentient(self) && self cansee(enemy)) {
                if (!isdefined(info.var_276f3701[entnum])) {
                    info.var_276f3701[entnum] = 0;
                }
                if (info.var_276f3701[entnum] < delay) {
                    self setpersonalignore(enemy, update_interval);
                }
                info.var_869a18d1[entnum] = gettime();
                info.var_276f3701[entnum] = info.var_276f3701[entnum] + var_bf1b43ed;
                continue;
            }
            if (isdefined(info.var_869a18d1[entnum])) {
                resettime = int(max(enemy function_ba5e4df6(), 250));
                if (gettime() - info.var_869a18d1[entnum] > resettime) {
                    info.var_869a18d1[entnum] = undefined;
                    info.var_276f3701[entnum] = undefined;
                }
            }
        }
        wait update_interval;
    }
}

// Namespace targetting_delay/targetting_delay
// Params 2, eflags: 0x0
// Checksum 0xe45e8e61, Offset: 0x490
// Size: 0x12e
function function_3b2437d9(enemy, defaultdelay = 250) {
    if (!isplayer(enemy)) {
        return true;
    }
    delay = int(max(enemy function_4e6e7f24(), defaultdelay));
    if (delay <= 0) {
        return true;
    }
    info = self.var_41d92e29;
    if (!isdefined(info) || !isdefined(info.var_276f3701)) {
        return false;
    }
    if ((isdefined(info.var_276f3701[enemy getentitynumber()]) ? info.var_276f3701[enemy getentitynumber()] : 0) < delay) {
        return false;
    }
    return true;
}

// Namespace targetting_delay/targetting_delay
// Params 2, eflags: 0x0
// Checksum 0x15cbd8e6, Offset: 0x5c8
// Size: 0x13e
function function_4ba58de4(enemy, var_3c791cc4) {
    if (!isplayer(enemy)) {
        return;
    }
    delay = int(max(enemy function_4e6e7f24(), 250));
    if (delay <= 0) {
        return;
    }
    if (!isdefined(var_3c791cc4)) {
        var_3c791cc4 = delay;
    }
    info = self.var_41d92e29;
    if (!isdefined(info) || !isdefined(info.var_276f3701)) {
        return;
    }
    entnum = enemy getentitynumber();
    if (!isdefined(info.var_276f3701[entnum])) {
        info.var_276f3701[entnum] = 0;
    }
    info.var_276f3701[entnum] = info.var_276f3701[entnum] + var_3c791cc4;
}

