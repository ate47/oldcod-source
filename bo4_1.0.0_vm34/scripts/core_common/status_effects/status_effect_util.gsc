#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\util_shared;

#namespace status_effect;

// Namespace status_effect/status_effect_util
// Params 1, eflags: 0x4
// Checksum 0xcb4033e5, Offset: 0xc0
// Size: 0x66
function private register_status_effect(status_effect_type) {
    if (!isdefined(level._status_effects)) {
        level._status_effects = [];
    }
    if (!isdefined(level._status_effects[status_effect_type])) {
        level._status_effects[status_effect_type] = spawnstruct();
    }
}

// Namespace status_effect/status_effect_util
// Params 1, eflags: 0x0
// Checksum 0x49008077, Offset: 0x130
// Size: 0x92
function function_5cf962b4(var_adce82d2) {
    if (!isdefined(var_adce82d2)) {
        println("<dev string:x30>");
        return;
    }
    if (!isdefined(var_adce82d2.setype)) {
        var_adce82d2.setype = 0;
    }
    register_status_effect(var_adce82d2.setype);
    level.var_693f098d[var_adce82d2.setype] = var_adce82d2;
}

// Namespace status_effect/status_effect_util
// Params 2, eflags: 0x0
// Checksum 0x7fc008ad, Offset: 0x1d0
// Size: 0x52
function register_status_effect_callback_apply(status_effect, apply_func) {
    register_status_effect(status_effect);
    if (isdefined(apply_func)) {
        level._status_effects[status_effect].apply = apply_func;
    }
}

// Namespace status_effect/status_effect_util
// Params 0, eflags: 0x4
// Checksum 0x32d933d3, Offset: 0x230
// Size: 0x146
function private function_3e96c9bb() {
    if (isdefined(self.owner)) {
        if (function_6d9b9d98(self.setype)) {
            self.owner function_58fd4769(self.namehash);
        }
        if (isdefined(self.var_eb2f858d)) {
            if (isplayer(self.owner)) {
                self.owner playlocalsound(self.var_eb2f858d);
            }
        }
        if (isdefined(self.var_bd10ce36)) {
            if (isplayer(self.owner)) {
                self.owner stoploopsound(0.5);
            }
        }
        self.owner function_962155c2(self.var_2fcb5e92);
        self [[ level._status_effects[self.setype].var_369b23d4 ]]();
        self.owner.var_a304768d[self.var_d20b8ed2] = undefined;
        self notify(#"endstatuseffect");
    }
}

// Namespace status_effect/status_effect_util
// Params 2, eflags: 0x0
// Checksum 0xf7a6f7ab, Offset: 0x380
// Size: 0xa2
function function_81221eab(status_effect, end_func) {
    register_status_effect(status_effect);
    if (isdefined(end_func)) {
        level._status_effects[status_effect].end = &function_3e96c9bb;
        level._status_effects[status_effect].var_369b23d4 = end_func;
        level._status_effects[status_effect].death = level._status_effects[status_effect].end;
    }
}

// Namespace status_effect/status_effect_util
// Params 2, eflags: 0x0
// Checksum 0x9f942b21, Offset: 0x430
// Size: 0x52
function function_d799a969(status_effect, death_func) {
    register_status_effect(status_effect);
    if (isdefined(death_func)) {
        level._status_effects[status_effect].death = death_func;
    }
}

// Namespace status_effect/status_effect_util
// Params 3, eflags: 0x0
// Checksum 0x3fc80168, Offset: 0x490
// Size: 0x5c
function function_8ca25db4(status_effect_type, weapon, applicant) {
    if (isdefined(level.var_693f098d[status_effect_type])) {
        self status_effect_apply(level.var_693f098d[status_effect_type], weapon, applicant);
    }
}

// Namespace status_effect/status_effect_util
// Params 3, eflags: 0x4
// Checksum 0x1e55aa53, Offset: 0x4f8
// Size: 0x15a
function private function_2addb096(sourcetype, setype, namehash) {
    if (!isdefined(self.var_a304768d)) {
        self.var_a304768d = [];
    }
    if (!isdefined(self.var_a304768d[sourcetype])) {
        self.var_a304768d[sourcetype] = spawnstruct();
    }
    if (!isdefined(self.var_a304768d[sourcetype].duration)) {
        self.var_a304768d[sourcetype].duration = 0;
    }
    if (!isdefined(self.var_a304768d[sourcetype].endtime)) {
        self.var_a304768d[sourcetype].endtime = 0;
    }
    if (!isdefined(self.var_a304768d[sourcetype].owner)) {
        self.var_a304768d[sourcetype].owner = self;
    }
    self.var_a304768d[sourcetype].setype = setype;
    self.var_a304768d[sourcetype].namehash = namehash;
    self.var_a304768d[sourcetype].var_d20b8ed2 = sourcetype;
}

// Namespace status_effect/status_effect_util
// Params 7, eflags: 0x0
// Checksum 0x3c74a492, Offset: 0x660
// Size: 0x794
function status_effect_apply(var_adce82d2, weapon, applicant, isadditive, durationoverride, var_c1550143, location) {
    assert(isdefined(var_adce82d2.setype));
    assert(isdefined(var_adce82d2.var_d20b8ed2));
    if (isdefined(self.var_46d4b6b6) && self.var_46d4b6b6) {
        return;
    }
    if (isdefined(var_c1550143)) {
        var_adce82d2.var_804bc9d5 *= var_c1550143;
        if (isdefined(durationoverride)) {
            durationoverride *= var_c1550143;
        }
    }
    register_status_effect(var_adce82d2.setype);
    var_76a98834 = 0;
    if (isdefined(applicant) && applicant != self && !self function_1e8e4e1e(applicant, var_adce82d2.var_d20b8ed2)) {
        var_337a4ab5 = 1;
        if (isdefined(var_adce82d2.var_980d2212)) {
            var_2032630b = globallogic_score::function_c8e9dad8(var_adce82d2.var_980d2212);
        }
        if (isdefined(var_2032630b) && isdefined(var_2032630b.var_cb60f06e)) {
            resistance = function_508e1a13(var_adce82d2.setype);
            if (var_2032630b.var_cb60f06e < resistance) {
                var_337a4ab5 = 0;
            }
        }
        if (var_337a4ab5) {
            applicant thread globallogic_score::function_e0e7bfe2(var_adce82d2, weapon);
        }
        var_76a98834 = 1;
    }
    self function_2addb096(var_adce82d2.var_d20b8ed2, var_adce82d2.setype, var_adce82d2.namehash);
    self function_f96dbd5(var_adce82d2);
    self callback::callback(#"on_status_effect", var_adce82d2);
    var_31c5f97f = function_bffec895(var_adce82d2.var_d20b8ed2) > level.time;
    var_f519416 = applicant === self;
    if (!isdefined(isadditive)) {
        isadditive = getdvarint(#"hash_6ce4aefbba354e2d", 0);
    }
    effect = self.var_a304768d[var_adce82d2.var_d20b8ed2];
    effect.var_2fcb5e92 = var_adce82d2;
    if (isdefined(location)) {
        effect.location = location;
    } else if (isdefined(applicant)) {
        effect.location = applicant.origin;
    }
    effect handle_sounds(var_adce82d2);
    var_e0987ab7 = 1;
    if (isdefined(var_adce82d2.var_e0987ab7)) {
        var_e0987ab7 = var_adce82d2.var_e0987ab7;
    }
    if (var_e0987ab7) {
        if (isadditive && var_adce82d2.setype != 4) {
            effect function_6cafe054(var_adce82d2, var_f519416, durationoverride, applicant, var_76a98834, weapon);
        } else {
            effect update_duration(var_adce82d2, var_f519416, durationoverride, applicant, var_76a98834);
        }
    }
    maxduration = effect function_542e60e3(var_adce82d2);
    if (maxduration > 0 && self.var_a304768d[var_adce82d2.var_d20b8ed2].duration > maxduration) {
        self.var_a304768d[var_adce82d2.var_d20b8ed2].duration = maxduration;
    } else if (self.var_a304768d[var_adce82d2.var_d20b8ed2].duration > 65536 - 1) {
        self.var_a304768d[var_adce82d2.var_d20b8ed2].duration = 65536 - 1;
    }
    if (isdefined(weapon) && weapon.doesfiredamage) {
        if (isplayer(self)) {
            self clientfield::set("burn", 1);
        }
    }
    if (!var_31c5f97f) {
        effect function_89b249d1();
    }
    if (isdefined(level._status_effects[var_adce82d2.setype].apply)) {
        effect.var_85e878ff = applicant;
        effect.var_ed5f2f94 = weapon;
        effect thread [[ level._status_effects[var_adce82d2.setype].apply ]](var_adce82d2, weapon, applicant);
        thread function_3318f2ef(effect, "begin");
    }
    if (!isdefined(effect.var_cda7f645)) {
        if (isdefined(var_adce82d2.var_43ae2bfb)) {
            effect.var_cda7f645 = self gestures::function_ce8466b6(var_adce82d2.var_43ae2bfb);
        }
        if (!isdefined(effect.var_cda7f645)) {
            if (isdefined(var_adce82d2.var_cda7f645)) {
                effect.var_cda7f645 = var_adce82d2.var_cda7f645;
            }
        }
        if (isdefined(effect.var_cda7f645)) {
            self thread function_45a1b311(effect);
        }
    }
    if (function_6d9b9d98(var_adce82d2.setype)) {
        self thread function_5728e728(var_adce82d2, isadditive);
    }
    if (isdefined(weapon) && isdefined(applicant) && applicant != self && isdefined(var_adce82d2.var_2395fd34) && var_adce82d2.var_2395fd34) {
        var_144f0193 = isdefined(weapon) && isdefined(weapon.var_2e32def5) && weapon.var_2e32def5;
        applicant util::show_hit_marker(0, var_144f0193);
    }
    if (isdefined(level._status_effects[var_adce82d2.setype].end)) {
        effect thread wait_for_end();
    }
}

// Namespace status_effect/status_effect_util
// Params 1, eflags: 0x4
// Checksum 0xcf26c6f4, Offset: 0xe00
// Size: 0xa4
function private function_45a1b311(effect) {
    effect endon(#"endstatuseffect");
    self endon(#"death");
    while (isdefined(effect.var_cda7f645)) {
        if (isdefined(level.var_2c7fac3b)) {
            self [[ level.var_2c7fac3b ]](effect);
        }
        if (self gestures::play_gesture(effect.var_cda7f645, undefined, 0)) {
            return;
        }
        wait 0.5;
    }
}

// Namespace status_effect/status_effect_util
// Params 2, eflags: 0x4
// Checksum 0x284f3cd8, Offset: 0xeb0
// Size: 0x10c
function private function_5728e728(var_adce82d2, isadditive) {
    var_d20b8ed2 = var_adce82d2.var_d20b8ed2;
    setype = var_adce82d2.setype;
    if (isdefined(self.var_a304768d[var_d20b8ed2]) && isdefined(self.var_a304768d[var_d20b8ed2].duration)) {
        if (setype != 4) {
            if (isplayer(self)) {
                assert(!isfloat(self.var_a304768d[var_d20b8ed2].duration), "<dev string:x8a>");
                self applystatuseffect(var_adce82d2.namehash, self.var_a304768d[var_d20b8ed2].duration, isadditive);
            }
        }
    }
}

// Namespace status_effect/status_effect_util
// Params 1, eflags: 0x4
// Checksum 0x7d401afe, Offset: 0xfc8
// Size: 0x3c
function private function_58fd4769(sename) {
    if (isplayer(self)) {
        self endstatuseffect(sename);
    }
}

// Namespace status_effect/status_effect_util
// Params 1, eflags: 0x4
// Checksum 0x59f349ae, Offset: 0x1010
// Size: 0x84
function private function_f96dbd5(var_adce82d2) {
    player = self;
    if (isdefined(var_adce82d2.var_d9bb9188) && var_adce82d2.var_d9bb9188 && isplayer(player)) {
        player disableoffhandspecial();
        player disableoffhandweapons();
    }
}

// Namespace status_effect/status_effect_util
// Params 1, eflags: 0x4
// Checksum 0xa0a3b569, Offset: 0x10a0
// Size: 0x84
function private function_962155c2(var_adce82d2) {
    player = self;
    if (isdefined(var_adce82d2.var_d9bb9188) && var_adce82d2.var_d9bb9188 && isplayer(player)) {
        player enableoffhandspecial();
        player enableoffhandweapons();
    }
}

// Namespace status_effect/status_effect_util
// Params 1, eflags: 0x4
// Checksum 0x8104ade5, Offset: 0x1130
// Size: 0x17e
function private function_a3fb62bf(status_effect_type) {
    if (isdefined(self.var_cda7f645)) {
        self.owner stopgestureviewmodel(self.var_cda7f645, 1, 0);
        self.var_cda7f645 = undefined;
    }
    if (isdefined(self.var_85e878ff)) {
        self.var_85e878ff globallogic_score::function_63de40fa(self.var_2fcb5e92);
    }
    if (isdefined(level._status_effects) && isdefined(level._status_effects[status_effect_type]) && isdefined(level._status_effects[status_effect_type].end)) {
        self thread [[ level._status_effects[status_effect_type].end ]]();
    }
    thread function_3318f2ef(self, "end");
    if (isdefined(self.var_ed5f2f94) && isdefined(self.owner) && self.var_ed5f2f94.doesfiredamage) {
        if (isplayer(self.owner)) {
            self.owner clientfield::set("burn", 0);
        }
    }
    self.var_85e878ff = undefined;
    self notify(#"endstatuseffect");
}

// Namespace status_effect/status_effect_util
// Params 0, eflags: 0x4
// Checksum 0x33cc8831, Offset: 0x12b8
// Size: 0xb4
function private wait_for_end() {
    if (0 && self.setype == 6) {
        return;
    }
    self notify(#"endwaiter");
    self endon(#"endwaiter");
    self endon(#"endstatuseffect");
    self.owner endon(#"disconnect");
    while (self.endtime > level.time) {
        waitframe(1);
    }
    if (isdefined(self)) {
        self thread function_a3fb62bf(self.setype);
    }
}

// Namespace status_effect/status_effect_util
// Params 2, eflags: 0x0
// Checksum 0x3c1d5a18, Offset: 0x1378
// Size: 0x74
function function_280d8ac0(setype, var_d20b8ed2) {
    if (isdefined(self.var_a304768d)) {
        if (isdefined(level._status_effects[setype].end)) {
            effect = self.var_a304768d[var_d20b8ed2];
            if (isdefined(effect)) {
                effect function_a3fb62bf(setype);
            }
        }
    }
}

// Namespace status_effect/status_effect_util
// Params 0, eflags: 0x0
// Checksum 0x7acb9db, Offset: 0x13f8
// Size: 0xb0
function function_3332ef07() {
    if (isdefined(self.var_a304768d)) {
        foreach (effect in self.var_a304768d) {
            if (isdefined(level._status_effects[effect.setype].end)) {
                effect function_a3fb62bf(effect.setype);
            }
        }
    }
}

// Namespace status_effect/status_effect_util
// Params 1, eflags: 0x4
// Checksum 0xdfea1e55, Offset: 0x14b0
// Size: 0x122
function private handle_sounds(var_adce82d2) {
    endtime = self.endtime;
    if (isdefined(var_adce82d2.var_cc40a478)) {
        if (level.time > endtime && isplayer(self.owner)) {
            self.owner playlocalsound(var_adce82d2.var_cc40a478);
        }
    }
    if (isdefined(var_adce82d2.var_bd10ce36)) {
        if (level.time > endtime && isplayer(self.owner)) {
            self.owner playloopsound(var_adce82d2.var_bd10ce36);
        }
        self.var_bd10ce36 = var_adce82d2.var_bd10ce36;
    }
    if (isdefined(var_adce82d2.var_eb2f858d)) {
        self.var_eb2f858d = var_adce82d2.var_eb2f858d;
    }
}

// Namespace status_effect/status_effect_util
// Params 1, eflags: 0x0
// Checksum 0x1b903348, Offset: 0x15e0
// Size: 0x50
function status_effect_get_duration(var_a1c6564a) {
    if (!isdefined(self.var_a304768d)) {
        self.var_a304768d = [];
    }
    return isdefined(self.var_a304768d[var_a1c6564a]) ? self.var_a304768d[var_a1c6564a].duration : 0;
}

// Namespace status_effect/status_effect_util
// Params 1, eflags: 0x0
// Checksum 0xf066c84d, Offset: 0x1638
// Size: 0x50
function function_bffec895(var_a1c6564a) {
    if (!isdefined(self.var_a304768d)) {
        self.var_a304768d = [];
    }
    return isdefined(self.var_a304768d[var_a1c6564a]) ? self.var_a304768d[var_a1c6564a].endtime : 0;
}

// Namespace status_effect/status_effect_util
// Params 1, eflags: 0x0
// Checksum 0xac163160, Offset: 0x1690
// Size: 0xd0
function function_f67d618d(status_effect_type) {
    if (!isdefined(self.var_a304768d)) {
        self.var_a304768d = [];
    }
    var_e73bf688 = 0;
    foreach (effect in self.var_a304768d) {
        if (effect.setype == 7) {
            var_e73bf688 += effect.var_f6884c49 * effect.var_b804cb6d / 1000;
        }
    }
    return var_e73bf688;
}

// Namespace status_effect/status_effect_util
// Params 1, eflags: 0x0
// Checksum 0xda444ec1, Offset: 0x1768
// Size: 0xa0
function function_d7236ba9(status_effect_type) {
    if (!isdefined(self.var_a304768d)) {
        self.var_a304768d = [];
    }
    foreach (effect in self.var_a304768d) {
        if (effect.setype == status_effect_type) {
            return true;
        }
    }
    return false;
}

// Namespace status_effect/status_effect_util
// Params 1, eflags: 0x4
// Checksum 0x7b2dd27a, Offset: 0x1810
// Size: 0x2a
function private function_1ee6f86a(status_effect_type) {
    if (status_effect_type == 3) {
        return "flakjacket";
    }
    return "resistance";
}

// Namespace status_effect/status_effect_util
// Params 5, eflags: 0x4
// Checksum 0x91b1d979, Offset: 0x1848
// Size: 0x24e
function private update_duration(var_adce82d2, var_f519416, durationoverride, applicant, var_76a98834) {
    setype = var_adce82d2.setype;
    resistance = self function_ff6cef96(var_adce82d2);
    var_1a8c30f3 = var_f519416 ? self.owner function_1a7334aa() : 1;
    if (resistance > 0 && isdefined(applicant) && var_76a98834) {
        applicant damagefeedback::update(undefined, undefined, function_1ee6f86a(setype));
    }
    newduration = 0;
    if (isdefined(durationoverride)) {
        newduration = durationoverride;
    } else {
        newduration = var_adce82d2.var_804bc9d5;
    }
    newduration = int(newduration * (1 - resistance) * var_1a8c30f3);
    var_5663b14c = self.endtime;
    time = level.time;
    maxduration = self function_542e60e3(var_adce82d2);
    if (isdefined(var_5663b14c)) {
        var_327a3c5d = var_5663b14c - time;
        if (var_327a3c5d < newduration) {
            self.duration = newduration;
            if (maxduration && self.duration > maxduration) {
                self.duration = maxduration;
            }
            self.endtime = time + self.duration;
        }
        return;
    }
    self.duration = newduration;
    if (maxduration && self.duration > maxduration) {
        self.duration = maxduration;
    }
    self.endtime = time + self.duration;
}

// Namespace status_effect/status_effect_util
// Params 6, eflags: 0x4
// Checksum 0x296ce5c7, Offset: 0x1aa0
// Size: 0x2c2
function private function_6cafe054(var_adce82d2, var_f519416, durationoverride, applicant, var_76a98834, weapon) {
    setype = var_adce82d2.setype;
    resistance = self function_ff6cef96(var_adce82d2);
    if (isdefined(var_adce82d2.var_15916d20) && var_adce82d2.var_15916d20) {
        resistance = 0;
    }
    var_1a8c30f3 = var_f519416 ? self.owner function_1a7334aa() : 1;
    if (resistance > 0 && setype != 0 && isdefined(applicant) && var_76a98834) {
        applicant damagefeedback::update(undefined, undefined, function_1ee6f86a(setype), weapon);
    }
    newduration = 0;
    if (isdefined(durationoverride)) {
        newduration = durationoverride;
    } else {
        newduration = var_adce82d2.var_804bc9d5;
    }
    newduration = int(newduration * (1 - resistance) * var_1a8c30f3);
    time = level.time;
    maxduration = self function_542e60e3(var_adce82d2);
    if (isdefined(self.duration)) {
        if (isdefined(self.endtime) && self.endtime > time) {
            if (maxduration && newduration > maxduration) {
                newduration = maxduration;
            }
            self.duration += newduration;
            self.endtime = gettime() + newduration;
        } else {
            self.duration = newduration;
            if (maxduration && self.duration > maxduration) {
                self.duration = maxduration;
            }
            self.endtime = time + newduration;
        }
        return;
    }
    self.duration = newduration;
    if (maxduration && self.duration > maxduration) {
        self.duration = maxduration;
    }
    self.endtime = time + newduration;
}

// Namespace status_effect/status_effect_util
// Params 0, eflags: 0x4
// Checksum 0xde0ab580, Offset: 0x1d70
// Size: 0x34
function private function_89b249d1() {
    self thread function_97576aeb();
    self thread function_ed733205();
}

// Namespace status_effect/status_effect_util
// Params 0, eflags: 0x0
// Checksum 0xb8f34ea5, Offset: 0x1db0
// Size: 0x15e
function function_ed733205() {
    self notify(#"loadoutwatcher");
    self endon(#"loadoutwatcher");
    self endon(#"endstatuseffect");
    self.owner endon(#"death", #"disconnect");
    var_5ac0b7e1 = self.owner function_508e1a13(self.setype);
    while (true) {
        self.owner waittill(#"loadout_given");
        newres = self.owner function_508e1a13(self.setype);
        currtime = level.time;
        if (newres != var_5ac0b7e1) {
            timeremaining = self.endtime - currtime;
            timeremaining *= newres;
            self.endtime = int(currtime + timeremaining);
            self.duration = int(timeremaining);
        }
    }
}

// Namespace status_effect/status_effect_util
// Params 0, eflags: 0x0
// Checksum 0xbf109566, Offset: 0x1f18
// Size: 0xc4
function function_97576aeb() {
    self notify(#"deathwatcher");
    self endon(#"deathwatcher");
    self endon(#"endstatuseffect");
    self.owner waittill(#"death");
    if (isdefined(self.var_85e878ff)) {
        self.var_85e878ff thread globallogic_score::function_be88174b(self.var_2fcb5e92);
    }
    if (isdefined(self) && isdefined(level._status_effects[self.setype].death)) {
        self [[ level._status_effects[self.setype].death ]]();
    }
}

// Namespace status_effect/status_effect_util
// Params 1, eflags: 0x0
// Checksum 0x954872c1, Offset: 0x1fe8
// Size: 0x52
function function_508e1a13(status_effect_type) {
    if (!isplayer(self)) {
        return 0;
    }
    resistance = self getplayerresistance(status_effect_type);
    return resistance;
}

// Namespace status_effect/status_effect_util
// Params 0, eflags: 0x0
// Checksum 0x729d492b, Offset: 0x2048
// Size: 0x2a
function function_1a7334aa() {
    scalar = self function_66ff021f();
    return scalar;
}

// Namespace status_effect/status_effect_util
// Params 1, eflags: 0x4
// Checksum 0x5c1b8bd5, Offset: 0x2080
// Size: 0x9e
function private function_ff6cef96(var_adce82d2) {
    effect = self;
    setype = var_adce82d2.setype;
    resistance = effect.owner function_508e1a13(setype);
    if (isdefined(var_adce82d2.var_15916d20) && var_adce82d2.var_15916d20) {
        resistance = 0;
    }
    if (setype == 7) {
        resistance = 0;
    }
    return resistance;
}

// Namespace status_effect/status_effect_util
// Params 1, eflags: 0x4
// Checksum 0xf1dd96cc, Offset: 0x2128
// Size: 0x72
function private function_542e60e3(var_adce82d2) {
    effect = self;
    resistance = effect function_ff6cef96(var_adce82d2);
    maxduration = int(var_adce82d2.var_37e78f9d * (1 - resistance));
    return maxduration;
}

// Namespace status_effect/status_effect_util
// Params 1, eflags: 0x4
// Checksum 0x6a6bf205, Offset: 0x21a8
// Size: 0x16
function private function_6d9b9d98(status_effect_type) {
    return status_effect_type < 9;
}

// Namespace status_effect/status_effect_util
// Params 1, eflags: 0x0
// Checksum 0xdbea37ee, Offset: 0x21c8
// Size: 0x1a
function function_a95bb02c(callback_function) {
    level.var_d9342599 = callback_function;
}

// Namespace status_effect/status_effect_util
// Params 2, eflags: 0x0
// Checksum 0x16115098, Offset: 0x21f0
// Size: 0x3c
function function_3318f2ef(status_effect, var_2c5d9a58) {
    if (!isdefined(level.var_d9342599)) {
        return;
    }
    [[ level.var_d9342599 ]](status_effect, var_2c5d9a58);
}

// Namespace status_effect/status_effect_util
// Params 2, eflags: 0x4
// Checksum 0x8a235149, Offset: 0x2238
// Size: 0xd0
function private function_1e8e4e1e(var_f7381b9a, sourcetype) {
    gametime = level.time;
    endtime = function_bffec895(sourcetype);
    isactive = function_bffec895(sourcetype) > gametime;
    if (!isactive) {
        return false;
    }
    if (!isdefined(self.var_a304768d[sourcetype]) || !isdefined(self.var_a304768d[sourcetype].var_85e878ff) || !isdefined(var_f7381b9a)) {
        return false;
    }
    return self.var_a304768d[sourcetype].var_85e878ff == var_f7381b9a;
}

