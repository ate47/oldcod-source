#using scripts\abilities\gadgets\gadget_health_regen;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\status_effects\status_effect_explosive_damage;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\visionset_mgr_shared;

#namespace healthoverlay;

// Namespace healthoverlay/healthoverlay
// Params 0, eflags: 0x6
// Checksum 0xe7851b29, Offset: 0xd0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"healthoverlay", &preinit, undefined, undefined, undefined);
}

// Namespace healthoverlay/healthoverlay
// Params 0, eflags: 0x4
// Checksum 0x11aad30a, Offset: 0x118
// Size: 0x20c
function private preinit() {
    callback::on_start_gametype(&init);
    level.new_health_model = getdvarint(#"new_health_model", 1) > 0;
    level.var_a7985066 = getdvarint(#"hash_1b8e30b9cc6b8dbc", 50);
    level.var_9b350462 = getdvarint(#"hash_3dfb7b6187d80898", 70);
    callback::on_joined_team(&function_5c4a1c21);
    callback::on_joined_spectate(&function_5c4a1c21);
    callback::on_disconnect(&end_health_regen);
    callback::on_player_killed(&function_5c4a1c21);
    if (level.new_health_model) {
        callback::on_spawned(&player_health_regen);
        level.start_player_health_regen = &player_health_regen;
    } else {
        callback::on_spawned(&player_health_regen_t7);
        level.start_player_health_regen = &player_health_regen_t7;
    }
    if (sessionmodeismultiplayergame()) {
        level.specialisthealspeed = getgametypesetting(#"specialisthealspeed_allies_1");
    }
    level thread function_b506b922();
}

// Namespace healthoverlay/healthoverlay
// Params 0, eflags: 0x0
// Checksum 0x466b1bc1, Offset: 0x330
// Size: 0x14
function init() {
    level.healthoverlaycutoff = 0.55;
}

// Namespace healthoverlay/healthoverlay
// Params 0, eflags: 0x0
// Checksum 0xa1cf572, Offset: 0x350
// Size: 0x30
function restart_player_health_regen() {
    self end_health_regen();
    self thread [[ level.start_player_health_regen ]]();
}

// Namespace healthoverlay/healthoverlay
// Params 1, eflags: 0x0
// Checksum 0xc8ee01a7, Offset: 0x388
// Size: 0x26
function function_5c4a1c21(*params) {
    self.var_4d9b2bc3 = 0;
    self notify(#"end_healthregen");
}

// Namespace healthoverlay/healthoverlay
// Params 0, eflags: 0x0
// Checksum 0xcfba47b5, Offset: 0x3b8
// Size: 0x1e
function end_health_regen() {
    self.var_4d9b2bc3 = 0;
    self notify(#"end_healthregen");
}

// Namespace healthoverlay/healthoverlay
// Params 0, eflags: 0x0
// Checksum 0xd46875db, Offset: 0x3e0
// Size: 0x4a6
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
// Checksum 0x5ea01731, Offset: 0x890
// Size: 0x4e
function function_f7a21c4() {
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
// Checksum 0x2f603072, Offset: 0x8e8
// Size: 0x74
function function_8335b12() {
    if (getdvarint(#"new_blood_version", 3) != 3) {
        self visionset_mgr::activate("visionset", "crithealth", self, 0.5, &function_f7a21c4, 0.5);
    }
}

// Namespace healthoverlay/healthoverlay
// Params 0, eflags: 0x0
// Checksum 0xea284858, Offset: 0x968
// Size: 0x6c
function function_306c4d60() {
    if (getdvarint(#"new_blood_version", 3) != 3) {
        self notify(#"hash_2d775ef016d5c651");
        self visionset_mgr::deactivate_per_player("visionset", "crithealth", self);
    }
}

// Namespace healthoverlay/healthoverlay
// Params 0, eflags: 0x0
// Checksum 0xc4a91abc, Offset: 0x9e0
// Size: 0x2a
function function_c48cb1fc() {
    self thread function_8335b12();
    self.var_61e6c24d = 1;
}

// Namespace healthoverlay/healthoverlay
// Params 0, eflags: 0x0
// Checksum 0x47eb4172, Offset: 0xa18
// Size: 0x26
function j_sticks_front1_end_le1() {
    self thread function_306c4d60();
    self.var_61e6c24d = 0;
}

// Namespace healthoverlay/healthoverlay
// Params 0, eflags: 0x4
// Checksum 0x2ba6d4f8, Offset: 0xa48
// Size: 0x24
function private function_2eee85c1() {
    if (self.var_61e6c24d) {
        self j_sticks_front1_end_le1();
    }
}

// Namespace healthoverlay/healthoverlay
// Params 0, eflags: 0x4
// Checksum 0x474f3ecb, Offset: 0xa78
// Size: 0x68
function private function_df99db2() {
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
// Checksum 0xb53d4c42, Offset: 0xae8
// Size: 0xa8
function private should_heal(var_dc77251f, regen_delay) {
    if (is_true(self.disable_health_regen_delay)) {
        var_dc77251f.var_ba47a7a3 = 1;
    }
    if (!is_true(self.ignore_health_regen_delay) && var_dc77251f.time_now - var_dc77251f.var_ba47a7a3 < regen_delay) {
        return false;
    }
    if (regen_delay <= 0) {
        return false;
    }
    if (self.health >= self.var_66cb03ad) {
        return false;
    }
    return true;
}

// Namespace healthoverlay/healthoverlay
// Params 2, eflags: 0x4
// Checksum 0xd9008093, Offset: 0xb98
// Size: 0x25a
function private function_53964fa3(var_bc840360, var_dc77251f) {
    if (self.heal.enabled == 0) {
        return 0;
    }
    regen_rate = self function_8ca62ae3();
    if (regen_rate <= 0) {
        return 0;
    }
    heal_amount = self.heal.heal_amount;
    if (!isdefined(heal_amount) || heal_amount <= 0) {
        return 0;
    }
    if (!isdefined(var_dc77251f.time_now)) {
        var_dc77251f.time_now = gettime();
    }
    if (!isdefined(self.heal.var_fa57541f)) {
        self.heal.var_fa57541f = self.health;
    }
    var_c59b0d1e = heal_amount / regen_rate;
    nt = float(var_dc77251f.time_now - (isdefined(self.heal.var_f37a08a8) ? self.heal.var_f37a08a8 : var_dc77251f.time_now)) / 1000 / var_c59b0d1e;
    exp = isdefined(self.heal.var_4e6c244d) ? self.heal.var_4e6c244d : 1;
    if (nt != 1) {
        var_6f934ab = self.heal.var_fa57541f + var_bc840360 * 1 / (1 + pow(nt / (1 - nt), exp * -1));
    } else {
        var_6f934ab = self.heal.var_fa57541f + var_bc840360;
    }
    var_6f934ab = min(var_6f934ab, var_bc840360);
    regen_amount = (var_6f934ab - var_dc77251f.old_health) / var_bc840360;
    return regen_amount;
}

// Namespace healthoverlay/healthoverlay
// Params 0, eflags: 0x4
// Checksum 0x576e01ee, Offset: 0xe00
// Size: 0x19e
function private function_8ca62ae3() {
    if (self.heal.enabled == 0) {
        return 0;
    }
    regen_rate = self.heal.rate;
    if (regen_rate == 0) {
        regen_rate = isdefined(self.n_regen_rate) ? self.n_regen_rate : self.playerrole.healthhealrate;
        if (self hasperk(#"specialty_quickrevive")) {
            regen_rate *= 1.5;
        }
        if (isdefined(self.var_5762241e)) {
            regen_rate += self.var_5762241e;
        }
        regen_rate *= self function_4e64ede5();
    }
    if (isdefined(level.specialisthealspeed)) {
        switch (level.specialisthealspeed) {
        case 0:
            regen_rate *= 0.5;
            break;
        case 1:
        default:
            break;
        case 2:
            regen_rate *= 2;
            break;
        case 3:
            regen_rate = 2147483647;
            break;
        }
    }
    return regen_rate;
}

// Namespace healthoverlay/healthoverlay
// Params 0, eflags: 0x4
// Checksum 0x23ec505f, Offset: 0xfa8
// Size: 0x10a
function private function_f8139729() {
    assert(isdefined(self.var_66cb03ad));
    assert(isdefined(self.maxhealth));
    assert(isplayer(self));
    var_bc840360 = isdefined(self.heal) && isdefined(self.heal.var_bc840360) ? self.heal.var_bc840360 : 0;
    if (var_bc840360 == 0) {
        var_bc840360 = self.var_66cb03ad;
    }
    var_bc840360 = math::clamp(var_bc840360, 0, max(self.maxhealth, self.var_66cb03ad));
    return var_bc840360;
}

// Namespace healthoverlay/healthoverlay
// Params 1, eflags: 0x4
// Checksum 0xb85b0ed8, Offset: 0x10c0
// Size: 0x524
function private heal(var_dc77251f) {
    player = self;
    healing_enabled = player.heal.enabled == 1;
    regen_delay = 1;
    if (healing_enabled && player.heal.var_c8777194 === 1) {
        regen_delay = isdefined(player.n_regen_delay) ? player.n_regen_delay : player.healthregentime;
        regen_delay = int(int(regen_delay * 1000));
        specialty_healthregen_enabled = 0;
        if (specialty_healthregen_enabled && player hasperk(#"specialty_healthregen") || player hasperk(#"specialty_quickrevive")) {
            regen_delay = int(regen_delay / getdvarfloat(#"perk_healthregenmultiplier", 0));
        }
    }
    if (!should_heal(var_dc77251f, regen_delay)) {
        return;
    }
    if (var_dc77251f.time_now - var_dc77251f.var_7cb44c56 > regen_delay) {
        var_dc77251f.var_7cb44c56 = var_dc77251f.time_now;
        self notify(#"snd_breathing_better");
    }
    var_bc840360 = player function_f8139729();
    assert(var_bc840360 > 0);
    if (is_true(player.var_44d52546)) {
        regen_amount = 1;
    } else if (getdvarint(#"hash_7f9cfdea69a18091", 1) == 1) {
        regen_amount = player function_53964fa3(var_bc840360, var_dc77251f);
    } else {
        regen_rate = player function_8ca62ae3();
        regen_amount = regen_rate * float(var_dc77251f.time_elapsed) / 1000 / var_bc840360;
    }
    if (regen_amount == 0) {
        return;
    }
    var_dc77251f.var_ec8863bf = math::clamp(var_dc77251f.ratio + regen_amount, 0, 1);
    if (var_dc77251f.var_ec8863bf <= 0) {
        return;
    }
    if (player.var_61e6c24d && var_dc77251f.var_ec8863bf > var_dc77251f.var_dae4d7ea) {
        player j_sticks_front1_end_le1();
    }
    new_health = var_dc77251f.var_ec8863bf * var_bc840360 + var_dc77251f.var_e65dca8d;
    if (new_health < player.health) {
        new_health = player.health;
    }
    player.health = int(math::clamp(floor(new_health), 0, max(self.maxhealth, self.var_66cb03ad)));
    var_dc77251f.var_e65dca8d = new_health - player.health;
    if (player.health >= var_bc840360 && var_dc77251f.old_health < var_bc840360) {
        player player::function_c6fe9951();
    }
    if (player.health >= player.var_66cb03ad && var_dc77251f.old_health < player.var_66cb03ad) {
        player player::reset_attacker_list();
        player player::function_d1768e8e();
        return;
    }
    change = player.health - var_dc77251f.old_health;
    if (change > 0) {
        player decay_player_damages(change);
        if (sessionmodeismultiplayergame()) {
            player stats::function_dad108fa(#"total_heals", change);
        }
    }
}

// Namespace healthoverlay/healthoverlay
// Params 1, eflags: 0x4
// Checksum 0xdb69bfc2, Offset: 0x15f0
// Size: 0x9e
function private check_max_health(var_dc77251f) {
    player = self;
    var_66cb03ad = player.var_66cb03ad < 0 ? player.maxhealth : player.var_66cb03ad;
    if (player.health >= var_66cb03ad) {
        if (isdefined(self.atbrinkofdeath)) {
            self notify(#"challenge_survived_from_death");
            self.atbrinkofdeath = undefined;
        }
        var_dc77251f.old_health = player.health;
        return true;
    }
    return false;
}

// Namespace healthoverlay/healthoverlay
// Params 1, eflags: 0x4
// Checksum 0xdc529b97, Offset: 0x1698
// Size: 0x4a
function private function_69e7b01c(ratio) {
    if (ratio <= level.healthoverlaycutoff) {
        self.atbrinkofdeath = 1;
        self.isneardeath = 1;
        return;
    }
    self.isneardeath = 0;
}

// Namespace healthoverlay/healthoverlay
// Params 0, eflags: 0x0
// Checksum 0xf844fdd1, Offset: 0x16f0
// Size: 0x14c
function player_health_regen() {
    if (self.health <= 0) {
        assert(!isalive(self));
        self.var_4d9b2bc3 = 0;
        return;
    }
    player = self;
    player.var_4d9b2bc3 = 1;
    player.breathingstoptime = -10000;
    player.var_dc77251f = {#var_ba47a7a3:0, #time_now:0, #time_elapsed:0, #ratio:0, #var_ec8863bf:0, #var_e65dca8d:0, #var_215539de:0, #var_dae4d7ea:0, #old_health:player.health, #var_7cb44c56:0, #var_d1e06a5f:gettime()};
    player j_sticks_front1_end_le1();
}

// Namespace healthoverlay/healthoverlay
// Params 2, eflags: 0x4
// Checksum 0x1eeae0b2, Offset: 0x1848
// Size: 0x376
function private function_8f2722f6(now, var_677a3e37) {
    player = self;
    if (!is_true(player.var_4d9b2bc3)) {
        return;
    }
    if (player.maxhealth == 0) {
        return;
    }
    if (!isalive(player)) {
        return;
    }
    if (level.autoheal && !var_677a3e37) {
        if (player.health < player.var_66cb03ad && player.heal.enabled !== 1) {
            player gadget_health_regen::function_ef6c7869(now);
        }
    }
    var_dc77251f = player.var_dc77251f;
    if (player check_max_health(var_dc77251f)) {
        var_dc77251f.var_e65dca8d = 0;
        player function_2eee85c1();
        return;
    }
    if (!player function_df99db2()) {
        var_dc77251f.var_e65dca8d = 0;
        player function_2eee85c1();
        return;
    }
    var_bc840360 = player function_f8139729();
    if (var_bc840360 <= player.health) {
        player.health = var_bc840360;
        var_dc77251f.var_e65dca8d = 0;
        player function_2eee85c1();
        return;
    }
    var_dc77251f.ratio = player.health / var_bc840360;
    var_dc77251f.var_ec8863bf = var_dc77251f.ratio;
    player function_69e7b01c(player.health / player.maxhealth);
    var_dc77251f.time_now = now;
    if (player.health < var_dc77251f.old_health) {
        player.breathingstoptime = now + 6000;
        var_dc77251f.var_ba47a7a3 = now;
    } else {
        var_dc77251f.time_elapsed = now - var_dc77251f.var_d1e06a5f;
        player heal(var_dc77251f);
        if (var_dc77251f.var_ec8863bf <= 0) {
            player.var_4d9b2bc3 = 0;
            return;
        }
    }
    var_dc77251f.var_a83bd8fd = level.var_a7985066 / player.maxhealth;
    var_dc77251f.var_dae4d7ea = level.var_9b350462 / player.maxhealth;
    if (!player.var_61e6c24d && var_dc77251f.var_ec8863bf <= var_dc77251f.var_a83bd8fd) {
        player function_c48cb1fc();
    } else if (player.var_61e6c24d && var_dc77251f.var_ec8863bf > var_dc77251f.var_dae4d7ea) {
        player j_sticks_front1_end_le1();
    }
    var_dc77251f.old_health = player.health;
}

// Namespace healthoverlay/healthoverlay
// Params 0, eflags: 0x4
// Checksum 0x21e2557f, Offset: 0x1bc8
// Size: 0x166
function private function_b506b922() {
    level endon(#"game_ended");
    while (true) {
        profilestart();
        var_677a3e37 = getdvarint(#"hash_4371c604abfbb2eb", 0) > 0;
        var_1556c25 = getlevelframenumber();
        now = gettime();
        foreach (player in getplayers()) {
            if ((player getentitynumber() + var_1556c25 & 1) != 0) {
                continue;
            }
            if (!isdefined(player.var_dc77251f)) {
                continue;
            }
            player function_8f2722f6(now, var_677a3e37);
            player.var_dc77251f.var_d1e06a5f = now;
        }
        profilestop();
        waitframe(1);
    }
}

// Namespace healthoverlay/healthoverlay
// Params 1, eflags: 0x0
// Checksum 0x37d85436, Offset: 0x1d38
// Size: 0x112
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
// Checksum 0xc421b515, Offset: 0x1e58
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
// Checksum 0x6e0491ea, Offset: 0x1f50
// Size: 0x12e
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

// Namespace healthoverlay/healthoverlay
// Params 0, eflags: 0x0
// Checksum 0xc895348b, Offset: 0x2088
// Size: 0x56
function function_d2880c8f() {
    if (is_true(self.heal.enabled)) {
        self.health = self function_f8139729();
        return;
    }
    self.health = self.maxhealth;
}

