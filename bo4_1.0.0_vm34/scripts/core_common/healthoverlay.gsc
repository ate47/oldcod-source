#using scripts\abilities\gadgets\gadget_health_regen;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\status_effects\status_effect_explosive_damage;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\visionset_mgr_shared;

#namespace healthoverlay;

// Namespace healthoverlay/healthoverlay
// Params 0, eflags: 0x2
// Checksum 0x6268de44, Offset: 0xd8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"healthoverlay", &__init__, undefined, undefined);
}

// Namespace healthoverlay/healthoverlay
// Params 0, eflags: 0x0
// Checksum 0xa1cc798c, Offset: 0x120
// Size: 0x1de
function __init__() {
    callback::on_start_gametype(&init);
    level.new_health_model = getdvarint(#"new_health_model", 1) > 0;
    if (level.new_health_model) {
        callback::on_joined_team(&function_51935eb4);
        callback::on_joined_spectate(&function_51935eb4);
        callback::on_spawned(&player_health_regen);
        callback::on_disconnect(&end_health_regen);
        callback::on_player_killed(&end_health_regen);
        level.start_player_health_regen = &player_health_regen;
        return;
    }
    callback::on_joined_team(&function_51935eb4);
    callback::on_joined_spectate(&function_51935eb4);
    callback::on_spawned(&player_health_regen_t7);
    callback::on_disconnect(&end_health_regen);
    callback::on_player_killed(&end_health_regen);
    level.start_player_health_regen = &player_health_regen_t7;
}

// Namespace healthoverlay/healthoverlay
// Params 0, eflags: 0x0
// Checksum 0xf06f7a70, Offset: 0x308
// Size: 0x16
function init() {
    level.healthoverlaycutoff = 0.55;
}

// Namespace healthoverlay/healthoverlay
// Params 0, eflags: 0x0
// Checksum 0xb6ef0c1f, Offset: 0x328
// Size: 0x30
function restart_player_health_regen() {
    self end_health_regen();
    self thread [[ level.start_player_health_regen ]]();
}

// Namespace healthoverlay/healthoverlay
// Params 1, eflags: 0x0
// Checksum 0x75fb0a5f, Offset: 0x360
// Size: 0x1e
function function_51935eb4(params) {
    self notify(#"end_healthregen");
}

// Namespace healthoverlay/healthoverlay
// Params 0, eflags: 0x0
// Checksum 0x96259d6e, Offset: 0x388
// Size: 0x16
function end_health_regen() {
    self notify(#"end_healthregen");
}

// Namespace healthoverlay/healthoverlay
// Params 0, eflags: 0x0
// Checksum 0xb05911d2, Offset: 0x3a8
// Size: 0x4c6
function player_health_regen_t7() {
    self endon(#"end_healthregen");
    if (self.health <= 0) {
        assert(!isalive(self));
        return;
    }
    maxhealth = self.health;
    oldhealth = maxhealth;
    player = self;
    regenrate = 0.1;
    usetrueregen = 0;
    veryhurt = 0;
    player.breathingstoptime = -10000;
    thread player_breathing_sound(maxhealth * 0.35);
    thread player_heartbeat_sound(maxhealth * 0.35);
    lastsoundtime_recover = 0;
    hurttime = 0;
    newhealth = 0;
    for (;;) {
        waitframe(1);
        if (isdefined(player.regenrate)) {
            regenrate = player.regenrate;
            usetrueregen = 1;
        }
        if (player.health == maxhealth) {
            veryhurt = 0;
            if (isdefined(self.atbrinkofdeath)) {
                self notify(#"challenge_survived_from_death");
                self.atbrinkofdeath = undefined;
            }
            continue;
        }
        if (player.health <= 0) {
            return;
        }
        if (isdefined(player.laststand) && player.laststand) {
            continue;
        }
        wasveryhurt = veryhurt;
        ratio = player.health / maxhealth;
        if (ratio <= level.healthoverlaycutoff) {
            veryhurt = 1;
            self.atbrinkofdeath = 1;
            self.isneardeath = 1;
            if (!wasveryhurt) {
                hurttime = gettime();
            }
        } else {
            self.isneardeath = 0;
        }
        if (player.health >= oldhealth) {
            regentime = 5000;
            if (player hasperk(#"specialty_healthregen")) {
                regentime = int(regentime / getdvarfloat(#"perk_healthregenmultiplier", 0));
            }
            if (gettime() - hurttime < regentime) {
                continue;
            }
            if (regentime <= 0) {
                continue;
            }
            if (gettime() - lastsoundtime_recover > regentime) {
                lastsoundtime_recover = gettime();
                self notify(#"snd_breathing_better");
            }
            if (veryhurt) {
                newhealth = ratio;
                veryhurttime = 3000;
                if (player hasperk(#"specialty_healthregen")) {
                    veryhurttime = int(veryhurttime / getdvarfloat(#"perk_healthregenmultiplier", 0));
                }
                if (gettime() > hurttime + veryhurttime) {
                    newhealth += regenrate;
                }
            } else if (usetrueregen) {
                newhealth = ratio + regenrate;
            } else {
                newhealth = 1;
            }
            if (newhealth >= 1) {
                self player::reset_attacker_list();
                newhealth = 1;
            }
            if (newhealth <= 0) {
                return;
            }
            player setnormalhealth(newhealth);
            change = player.health - oldhealth;
            if (change > 0) {
                player decay_player_damages(change);
            }
            oldhealth = player.health;
            continue;
        }
        oldhealth = player.health;
        hurttime = gettime();
        player.breathingstoptime = hurttime + 6000;
    }
}

// Namespace healthoverlay/healthoverlay
// Params 0, eflags: 0x0
// Checksum 0xf58c8676, Offset: 0x878
// Size: 0x4e
function function_74fd8f87() {
    self endon(#"hash_2d775ef016d5c651");
    while (true) {
        if (!isdefined(self)) {
            return;
        }
        level visionset_mgr::set_state_active(self, 1);
        waitframe(1);
    }
}

// Namespace healthoverlay/healthoverlay
// Params 0, eflags: 0x0
// Checksum 0x584cf7fc, Offset: 0x8d0
// Size: 0x74
function function_c9364736() {
    if (getdvarint(#"new_blood_version", 3) != 3) {
        self visionset_mgr::activate("visionset", "crithealth", self, 0.5, &function_74fd8f87, 0.5);
    }
}

// Namespace healthoverlay/healthoverlay
// Params 0, eflags: 0x0
// Checksum 0x8be2a010, Offset: 0x950
// Size: 0x6c
function function_a5db017f() {
    if (getdvarint(#"new_blood_version", 3) != 3) {
        self notify(#"hash_2d775ef016d5c651");
        self visionset_mgr::deactivate_per_player("visionset", "crithealth", self);
    }
}

// Namespace healthoverlay/healthoverlay
// Params 0, eflags: 0x0
// Checksum 0xade25c7, Offset: 0x9c8
// Size: 0x4c
function function_59be6aaf() {
    self thread function_c9364736();
    self.var_d65e977 = 1;
    self clientfield::set_to_player("sndCriticalHealth", 1);
}

// Namespace healthoverlay/healthoverlay
// Params 0, eflags: 0x0
// Checksum 0x3d6d5137, Offset: 0xa20
// Size: 0x44
function function_bec00c46() {
    self thread function_a5db017f();
    self.var_d65e977 = 0;
    self clientfield::set_to_player("sndCriticalHealth", 0);
}

// Namespace healthoverlay/healthoverlay
// Params 0, eflags: 0x4
// Checksum 0x772bf36, Offset: 0xa70
// Size: 0x24
function private function_c93f60e5() {
    if (self.var_d65e977) {
        self function_bec00c46();
    }
}

// Namespace healthoverlay/healthoverlay
// Params 0, eflags: 0x4
// Checksum 0x7569bfc9, Offset: 0xaa0
// Size: 0x6c
function private function_a8f910ea() {
    player = self;
    if (player.health <= 0) {
        return false;
    }
    if (player isremotecontrolling()) {
        return false;
    }
    if (isdefined(player.laststand) && player.laststand) {
        return false;
    }
    return true;
}

// Namespace healthoverlay/healthoverlay
// Params 2, eflags: 0x4
// Checksum 0x6c7a2919, Offset: 0xb18
// Size: 0x8c
function private should_heal(var_fa5c7c12, regen_delay) {
    if (isdefined(self.var_f60f5bef) && self.var_f60f5bef) {
        var_fa5c7c12.var_5837e4ee = 1;
    }
    if (var_fa5c7c12.time_now - var_fa5c7c12.var_5837e4ee < regen_delay) {
        return false;
    }
    if (regen_delay <= 0) {
        return false;
    }
    if (self.health >= self.var_63f2cd6e) {
        return false;
    }
    return true;
}

// Namespace healthoverlay/healthoverlay
// Params 0, eflags: 0x4
// Checksum 0xb88eb3ff, Offset: 0xbb0
// Size: 0xe4
function private function_b99d7149() {
    if (self.heal.enabled == 0) {
        return 0;
    }
    regen_rate = self.heal.rate;
    if (regen_rate == 0) {
        regen_rate = isdefined(self.n_regen_rate) ? self.n_regen_rate : self.playerrole.healthhealrate;
        if (self hasperk(#"specialty_quickrevive")) {
            regen_rate *= 1.5;
        }
        if (isdefined(self.var_307a0e18)) {
            regen_rate += self.var_307a0e18;
        }
        regen_rate *= self function_a4fc5ded();
    }
    return regen_rate;
}

// Namespace healthoverlay/healthoverlay
// Params 0, eflags: 0x4
// Checksum 0xd936afca, Offset: 0xca0
// Size: 0xe2
function private function_ba125dc() {
    assert(isdefined(self.var_63f2cd6e));
    assert(isdefined(self.maxhealth));
    assert(isplayer(self));
    var_93dfabb3 = self.heal.var_93dfabb3;
    if (var_93dfabb3 == 0) {
        var_93dfabb3 = self.var_63f2cd6e;
    }
    var_93dfabb3 = math::clamp(var_93dfabb3, 0, max(self.maxhealth, self.var_63f2cd6e));
    return var_93dfabb3;
}

// Namespace healthoverlay/healthoverlay
// Params 1, eflags: 0x4
// Checksum 0xde8e7d95, Offset: 0xd90
// Size: 0x4dc
function private heal(var_fa5c7c12) {
    player = self;
    healing_enabled = player.heal.enabled == 1;
    regen_delay = 1;
    if (healing_enabled && player.heal.var_f26dc4ce === 1) {
        regen_delay = isdefined(player.n_regen_delay) ? player.n_regen_delay : player.healthregentime;
        regen_delay = int(int(regen_delay * 1000));
        specialty_healthregen_enabled = 0;
        if (specialty_healthregen_enabled && player hasperk(#"specialty_healthregen") || player hasperk(#"specialty_quickrevive")) {
            regen_delay = int(regen_delay / getdvarfloat(#"perk_healthregenmultiplier", 0));
        }
    }
    if (!should_heal(var_fa5c7c12, regen_delay)) {
        return;
    }
    if (var_fa5c7c12.time_now - var_fa5c7c12.var_5a1a98bc > regen_delay) {
        var_fa5c7c12.var_5a1a98bc = var_fa5c7c12.time_now;
        self notify(#"snd_breathing_better");
    }
    var_93dfabb3 = player function_ba125dc();
    assert(var_93dfabb3 > 0);
    regen_rate = player function_b99d7149();
    if (isdefined(player.var_36b14302) && player.var_36b14302) {
        regen_amount = 1;
    } else {
        regen_amount = regen_rate * float(var_fa5c7c12.time_elapsed) / 1000 / var_93dfabb3;
    }
    if (regen_amount == 0) {
        return;
    }
    var_fa5c7c12.var_c44d3299 = math::clamp(var_fa5c7c12.ratio + regen_amount, 0, 1);
    if (var_fa5c7c12.var_c44d3299 <= 0) {
        return;
    }
    if (player.var_d65e977 && var_fa5c7c12.var_c44d3299 > var_fa5c7c12.var_40c5676c) {
        player function_bec00c46();
    }
    new_health = var_fa5c7c12.var_c44d3299 * var_93dfabb3 + var_fa5c7c12.var_2c83af87;
    player.health = int(math::clamp(floor(new_health), 0, max(self.maxhealth, self.var_63f2cd6e)));
    var_fa5c7c12.var_2c83af87 = new_health - player.health;
    if (player.health >= var_93dfabb3 && var_fa5c7c12.old_health < var_93dfabb3) {
        player player::function_9dbfe984();
    }
    if (player.health >= player.var_63f2cd6e && var_fa5c7c12.old_health < player.var_63f2cd6e) {
        player player::reset_attacker_list();
        player player::function_581b3131();
        return;
    }
    change = player.health - var_fa5c7c12.old_health;
    if (change > 0) {
        player decay_player_damages(change);
    }
}

// Namespace healthoverlay/healthoverlay
// Params 1, eflags: 0x4
// Checksum 0xace95ff, Offset: 0x1278
// Size: 0xae
function private check_max_health(var_fa5c7c12) {
    player = self;
    var_63f2cd6e = player.var_63f2cd6e < 0 ? player.maxhealth : player.var_63f2cd6e;
    if (player.health >= var_63f2cd6e) {
        if (isdefined(self.atbrinkofdeath)) {
            self notify(#"challenge_survived_from_death");
            self.atbrinkofdeath = undefined;
        }
        var_fa5c7c12.old_health = player.health;
        return true;
    }
    return false;
}

// Namespace healthoverlay/healthoverlay
// Params 1, eflags: 0x4
// Checksum 0x94a99eb0, Offset: 0x1330
// Size: 0x4a
function private function_fcc46fed(ratio) {
    if (ratio <= level.healthoverlaycutoff) {
        self.atbrinkofdeath = 1;
        self.isneardeath = 1;
        return;
    }
    self.isneardeath = 0;
}

// Namespace healthoverlay/healthoverlay
// Params 0, eflags: 0x0
// Checksum 0xa0641361, Offset: 0x1388
// Size: 0x4ee
function player_health_regen() {
    self notify(#"hash_78a6dfe50bd6e6eb");
    self endon(#"hash_78a6dfe50bd6e6eb");
    self endon(#"end_healthregen");
    self endon(#"player_suicide");
    if (self.health <= 0) {
        assert(!isalive(self));
        return;
    }
    player = self;
    player.breathingstoptime = -10000;
    var_fa5c7c12 = {#var_5837e4ee:0, #time_now:0, #time_elapsed:0, #ratio:0, #var_c44d3299:0, #var_2c83af87:0, #var_391e50bf:0, #var_40c5676c:0, #old_health:player.health, #var_5a1a98bc:0};
    player function_bec00c46();
    var_84a4de3b = getdvarint(#"hash_1b8e30b9cc6b8dbc", 50);
    var_f73c18e9 = getdvarint(#"hash_3dfb7b6187d80898", 70);
    wait randomfloatrange(0, 0.1);
    while (true) {
        lasttime = gettime();
        wait 0.1;
        if (player.maxhealth == 0) {
            continue;
        }
        if (player check_max_health(var_fa5c7c12)) {
            var_fa5c7c12.var_2c83af87 = 0;
            function_c93f60e5();
            continue;
        }
        if (!function_a8f910ea()) {
            var_fa5c7c12.var_2c83af87 = 0;
            function_c93f60e5();
            continue;
        }
        var_93dfabb3 = player function_ba125dc();
        if (var_93dfabb3 <= player.health) {
            player.health = var_93dfabb3;
            var_fa5c7c12.var_2c83af87 = 0;
            function_c93f60e5();
            continue;
        }
        var_fa5c7c12.ratio = player.health / var_93dfabb3;
        var_fa5c7c12.var_c44d3299 = var_fa5c7c12.ratio;
        player function_fcc46fed(player.health / player.maxhealth);
        var_fa5c7c12.time_now = gettime();
        if (player.health < var_fa5c7c12.old_health) {
            player.breathingstoptime = var_fa5c7c12.time_now + 6000;
            var_fa5c7c12.var_5837e4ee = var_fa5c7c12.time_now;
        } else {
            var_fa5c7c12.time_elapsed = var_fa5c7c12.time_now - lasttime;
            player heal(var_fa5c7c12);
            if (var_fa5c7c12.var_c44d3299 <= 0) {
                return;
            }
        }
        var_fa5c7c12.var_2458230 = var_84a4de3b / player.maxhealth;
        var_fa5c7c12.var_40c5676c = var_f73c18e9 / player.maxhealth;
        if (!player.var_d65e977 && var_fa5c7c12.var_c44d3299 <= var_fa5c7c12.var_2458230) {
            player function_59be6aaf();
        } else if (player.var_d65e977 && var_fa5c7c12.var_c44d3299 > var_fa5c7c12.var_40c5676c) {
            player function_bec00c46();
        }
        var_fa5c7c12.old_health = player.health;
    }
}

// Namespace healthoverlay/healthoverlay
// Params 1, eflags: 0x0
// Checksum 0x4597d04e, Offset: 0x1880
// Size: 0x120
function decay_player_damages(decay) {
    if (!isdefined(self.attackerdamage)) {
        return;
    }
    if (!isdefined(self.attackers)) {
        return;
    }
    for (j = 0; j < self.attackers.size; j++) {
        player = self.attackers[j];
        if (!isdefined(player)) {
            continue;
        }
        if (self.attackerdamage[player.clientid].damage == 0) {
            continue;
        }
        self.attackerdamage[player.clientid].damage = self.attackerdamage[player.clientid].damage - decay;
        if (self.attackerdamage[player.clientid].damage < 0) {
            self.attackerdamage[player.clientid].damage = 0;
        }
    }
}

// Namespace healthoverlay/healthoverlay
// Params 1, eflags: 0x0
// Checksum 0xc42bd5c6, Offset: 0x19a8
// Size: 0xea
function player_breathing_sound(healthcap) {
    self endon(#"end_healthregen");
    wait 2;
    player = self;
    for (;;) {
        wait 0.2;
        if (player.health <= 0) {
            return;
        }
        if (player util::isusingremote()) {
            continue;
        }
        if (player.health >= healthcap) {
            continue;
        }
        if (player.healthregentime <= 0 && gettime() > player.breathingstoptime) {
            continue;
        }
        player notify(#"snd_breathing_hurt");
        wait 0.784;
        wait 0.1 + randomfloat(0.8);
    }
}

// Namespace healthoverlay/healthoverlay
// Params 1, eflags: 0x0
// Checksum 0x5b2f7c14, Offset: 0x1aa0
// Size: 0x136
function player_heartbeat_sound(healthcap) {
    self endon(#"end_healthregen");
    self.hearbeatwait = 0.2;
    wait 2;
    player = self;
    for (;;) {
        wait 0.2;
        if (player.health <= 0) {
            return;
        }
        if (player util::isusingremote()) {
            continue;
        }
        if (player.health >= healthcap) {
            self.hearbeatwait = 0.3;
            continue;
        }
        if (player.healthregentime <= 0 && gettime() > player.breathingstoptime) {
            self.hearbeatwait = 0.3;
            continue;
        }
        player playlocalsound(#"mpl_player_heartbeat");
        wait self.hearbeatwait;
        if (self.hearbeatwait <= 0.6) {
            self.hearbeatwait += 0.1;
        }
    }
}

