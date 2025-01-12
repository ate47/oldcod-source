#using scripts\core_common\animation_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\visionset_mgr_shared;

#namespace gadget_vision_pulse;

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 0, eflags: 0x0
// Checksum 0xb22a49a0, Offset: 0x140
// Size: 0x184
function init_shared() {
    level.vision_pulse = [];
    level.weaponvisionpulse = getweapon(#"gadget_vision_pulse");
    callback::on_localplayer_spawned(&on_localplayer_spawned);
    callback::on_spawned(&on_player_spawned);
    callback::on_player_corpse(&on_player_corpse);
    clientfield::register("toplayer", "vision_pulse_active", 1, 1, "int", &vision_pulse_changed, 0, 1);
    clientfield::register("toplayer", "toggle_postfx", 1, 1, "int", &toggle_postfx, 0, 1);
    visionset_mgr::register_visionset_info("vision_pulse", 1, 12, undefined, "vision_puls_bw");
    animation::add_notetrack_func(#"gadget_vision_pulse::vision_pulse_notetracks", &function_434f0022);
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 1, eflags: 0x0
// Checksum 0xb1fe8fce, Offset: 0x2d0
// Size: 0xbc
function on_localplayer_spawned(localclientnum) {
    if (self function_60dbc438()) {
        level.vision_pulse[localclientnum] = 0;
        self.vision_pulse_owner = undefined;
        self.var_877d027a = undefined;
        self gadgetpulseresetreveal();
        self set_reveal_self(localclientnum, 0);
        self set_reveal_enemy(localclientnum, 0);
    }
    if (self function_40efd9db()) {
        self stop_postfx(1);
    }
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 1, eflags: 0x0
// Checksum 0xdce2fd65, Offset: 0x398
// Size: 0xbc
function on_player_spawned(local_client_num) {
    team = function_e4542aa3(local_client_num);
    if (self.team != team && !function_d224c0e6(local_client_num)) {
        self playrenderoverridebundle(#"rob_sonar_set_enemy");
    }
    self clearanim(#"pt_recon_t8_stand_vision_pulse_goggles_down_loop", 0);
    self clearanim(#"pt_recon_t8_prone_vision_pulse_goggles_down_loop", 0);
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 2, eflags: 0x0
// Checksum 0xcd109fcc, Offset: 0x460
// Size: 0xbc
function on_player_corpse(localclientnum, params) {
    self endon(#"death");
    var_48857b45 = params.player.visionpulsereveal;
    if (isdefined(var_48857b45) && var_48857b45) {
        self.visionpulsereveal = 1;
        self.var_7ac37d1 = params.player.var_7ac37d1;
        self util::waittill_dobj(localclientnum);
        self set_reveal_enemy(localclientnum, 1);
    }
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 1, eflags: 0x0
// Checksum 0xfa7d7b08, Offset: 0x528
// Size: 0x9c
function stop_postfx(immediate) {
    if (isdefined(self)) {
        self.var_877d027a = undefined;
        if (self postfx::function_7348f3a5(#"hash_5a76eaaf7f7e3de5")) {
            if (isdefined(immediate) && immediate) {
                self postfx::stoppostfxbundle(#"hash_5a76eaaf7f7e3de5");
                return;
            }
            self postfx::exitpostfxbundle(#"hash_5a76eaaf7f7e3de5");
        }
    }
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 0, eflags: 0x0
// Checksum 0xb38fbeff, Offset: 0x5d0
// Size: 0x126
function function_2f1b807b() {
    self endon(#"stop_googles", #"death");
    if (!self isplayer()) {
        return;
    }
    while (true) {
        if (self isplayerprone()) {
            self clearanim(#"pt_recon_t8_stand_vision_pulse_goggles_down_loop", 0);
            self setanimknob(#"pt_recon_t8_prone_vision_pulse_goggles_down_loop", 1, 0, 1);
        } else {
            self clearanim(#"pt_recon_t8_prone_vision_pulse_goggles_down_loop", 0);
            self setanimknob(#"pt_recon_t8_stand_vision_pulse_goggles_down_loop", 1, 0, 1);
        }
        waitframe(1);
    }
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 1, eflags: 0x0
// Checksum 0x651ddee0, Offset: 0x700
// Size: 0x50
function function_4fffc11c(local_client_num) {
    self endon(#"stop_googles");
    wait 0.8;
    level.vision_pulse[local_client_num] = 1;
    level notify(#"hash_7f642789ed08aae0");
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 1, eflags: 0x0
// Checksum 0x8e69ed78, Offset: 0x758
// Size: 0x50
function function_b720e0d(local_client_num) {
    self endon(#"stop_googles");
    wait 0.85;
    level.vision_pulse[local_client_num] = 0;
    level notify(#"hash_7f642789ed08aae0");
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 1, eflags: 0x0
// Checksum 0x643cce36, Offset: 0x7b0
// Size: 0x3cc
function function_434f0022(notifystring) {
    self endon(#"death");
    localclientnum = self.localclientnum;
    if (notifystring == "visor_down") {
        self function_2f1b807b();
    } else if (notifystring == "visor_up") {
        self clearanim(#"pt_recon_t8_stand_vision_pulse_goggles_down_loop", 0);
        self clearanim(#"pt_recon_t8_prone_vision_pulse_goggles_down_loop", 0);
        self notify(#"stop_googles");
    }
    if (self function_60dbc438()) {
        if (notifystring == "visor_up") {
            stop_postfx();
            return;
        }
        if (notifystring == "overlay_on") {
            if (!isdefined(self.var_877d027a)) {
                stop_postfx();
                self thread function_4fffc11c(localclientnum);
                self.var_877d027a = 1;
                self postfx::playpostfxbundle(#"hash_5a76eaaf7f7e3de5");
                self function_202a8b08(#"hash_5a76eaaf7f7e3de5", #"hash_7c1a0903a45d4d45", 0);
                self function_202a8b08(#"hash_5a76eaaf7f7e3de5", #"hash_51ebcff0b5d75894", 0);
                self function_202a8b08(#"hash_5a76eaaf7f7e3de5", #"hash_2efccfad2b32081a", 1);
                self thread function_44b05805(localclientnum);
                self callback::on_end_game(&on_game_ended);
                waitframe(1);
                self.var_230e515c = 0;
                enemies = getplayers(localclientnum);
                foreach (enemy in enemies) {
                    if (isdefined(enemy) && enemy.team != self.team) {
                        enemy.var_38cfc17e = 0;
                    }
                }
                extraduration = 3000;
                thread util::lerp_generic(localclientnum, level.weaponvisionpulse.gadget_pulse_duration + extraduration, &do_vision_world_pulse_lerp_helper);
            }
            return;
        }
        if (notifystring == "overlay_off") {
            self notify(#"stop_googles");
            self thread function_b720e0d(localclientnum);
            stop_postfx();
            self function_31e40037(localclientnum);
        }
    }
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 1, eflags: 0x0
// Checksum 0x1242c805, Offset: 0xb88
// Size: 0x18c
function function_31e40037(localclientnum) {
    if (isdefined(self)) {
        players = getplayers(localclientnum);
        foreach (enemy in players) {
            if (isdefined(enemy) && isalive(enemy) && enemy.team !== self.team && (isdefined(enemy.visionpulsereveal) && enemy.visionpulsereveal || isdefined(enemy.var_9d12437d) && enemy.var_9d12437d)) {
                enemy stoprenderoverridebundle(#"hash_75f4d8048e6adb94");
                enemy stoprenderoverridebundle(#"hash_62b3e8ea5469c2f5");
                enemy function_b2e26d0(localclientnum, 0);
                enemy notify(#"rob_cleanup");
            }
        }
    }
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 1, eflags: 0x0
// Checksum 0x8dc77961, Offset: 0xd20
// Size: 0x4c
function on_game_ended(localclientnum) {
    local_player = function_f97e7787(localclientnum);
    if (isdefined(local_player)) {
        local_player shutdown_vision_pulse(localclientnum);
    }
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 1, eflags: 0x0
// Checksum 0x3a76d601, Offset: 0xd78
// Size: 0x7a
function shutdown_vision_pulse(localclientnum) {
    if (isdefined(level.vision_pulse[localclientnum]) && level.vision_pulse[localclientnum]) {
        self stop_postfx(1);
        self function_31e40037(localclientnum);
        level.vision_pulse[localclientnum] = 0;
    }
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 1, eflags: 0x0
// Checksum 0x438b0063, Offset: 0xe00
// Size: 0x7c
function function_44b05805(localclientnum) {
    self notify(#"hash_54f15501beb799f9");
    self endon(#"hash_54f15501beb799f9");
    self endon(#"stop_googles");
    self waittill(#"death", #"game_ended");
    self shutdown_vision_pulse(localclientnum);
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 4, eflags: 0x0
// Checksum 0xb80b9b7c, Offset: 0xe88
// Size: 0x274
function do_vision_world_pulse_lerp_helper(currenttime, elapsedtime, localclientnum, duration) {
    if (!isdefined(self)) {
        return;
    }
    pulseduration = level.weaponvisionpulse.gadget_pulse_duration;
    if (elapsedtime < pulseduration * 0.1) {
        irisamount = elapsedtime / pulseduration * 0.1;
    } else if (elapsedtime < pulseduration * 0.6) {
        irisamount = 1 - elapsedtime / pulseduration * 0.5;
    } else {
        irisamount = 0;
    }
    pulseradius = getvisionpulseradius(localclientnum);
    pulsemaxradius = level.weaponvisionpulse.gadget_pulse_max_range;
    if (pulseradius > 0 && self.var_230e515c == 0) {
        self.var_230e515c = 1;
        playsound(localclientnum, #"hash_151b724086b2955b");
    }
    if (pulseradius > pulsemaxradius) {
        if (self.var_230e515c * pulsemaxradius < pulseradius) {
            self.var_230e515c++;
            playsound(localclientnum, #"hash_151b724086b2955b");
        }
        pulseradius = int(pulseradius) % pulsemaxradius;
    }
    if (self postfx::function_7348f3a5(#"hash_5a76eaaf7f7e3de5")) {
        self function_202a8b08(#"hash_5a76eaaf7f7e3de5", #"hash_7c1a0903a45d4d45", pulseradius);
        self function_202a8b08(#"hash_5a76eaaf7f7e3de5", #"hash_51ebcff0b5d75894", irisamount);
        self function_202a8b08(#"hash_5a76eaaf7f7e3de5", #"hash_2efccfad2b32081a", pulsemaxradius);
    }
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 1, eflags: 0x0
// Checksum 0xb6e5af1, Offset: 0x1108
// Size: 0x50
function vision_pulse_owner_valid(owner) {
    if (isdefined(owner) && owner isplayer() && isalive(owner)) {
        return true;
    }
    return false;
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 1, eflags: 0x0
// Checksum 0xf261bff2, Offset: 0x1160
// Size: 0x1a6
function watch_vision_pulse_owner_death(localclientnum) {
    self endon(#"death");
    self endon(#"finished_local_pulse");
    self notify(#"watch_vision_pulse_owner_death");
    self endon(#"watch_vision_pulse_owner_death");
    owner = self.vision_pulse_owner;
    if (vision_pulse_owner_valid(owner)) {
        owner waittill(#"death");
    }
    self notify(#"vision_pulse_owner_death");
    self stoprenderoverridebundle(#"hash_75f4d8048e6adb94");
    self stoprenderoverridebundle(#"hash_62b3e8ea5469c2f5");
    self stoprenderoverridebundle(#"rob_sonar_set_enemy");
    if (self function_40a6c199(#"hash_1978eff2ac047e65")) {
        self function_98a01e4c(#"hash_1978eff2ac047e65", #"brightness", 0);
        self stoprenderoverridebundle(#"hash_1978eff2ac047e65");
    }
    level callback::callback(#"vision_pulse_off", localclientnum);
    self.vision_pulse_owner = undefined;
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 1, eflags: 0x0
// Checksum 0x8c1f40b2, Offset: 0x1310
// Size: 0x3fe
function do_vision_local_pulse(localclientnum) {
    self endon(#"death");
    self endon(#"vision_pulse_owner_death");
    self notify(#"local_pulse");
    self endon(#"startlocalpulse");
    self thread watch_vision_pulse_owner_death(localclientnum);
    self playrenderoverridebundle(#"hash_1978eff2ac047e65");
    origin = getrevealpulseorigin(localclientnum);
    self function_98a01e4c(#"hash_1978eff2ac047e65", #"brightness", 1);
    starttime = function_a436e4da(localclientnum);
    revealtime = level.weaponvisionpulse.var_9397a4c8;
    fadeout_duration = level.weaponvisionpulse.var_1f84215a;
    jammed = self clientfield::get("gps_jammer_active");
    var_5458f75b = isdefined(level.weaponvisionpulse.var_6af7628) ? level.weaponvisionpulse.var_6af7628 : 1;
    var_9944bdff = fadeout_duration * (jammed ? var_5458f75b : 1);
    var_fbb31a83 = var_9944bdff * (isdefined(level.weaponvisionpulse.var_97378dd6) ? level.weaponvisionpulse.var_97378dd6 : 0.8);
    while (true) {
        elapsedtime = getservertime(localclientnum) - starttime;
        if (elapsedtime >= revealtime) {
            break;
        }
        pulseradius = 0;
        if (getservertime(localclientnum) - starttime < level.weaponvisionpulse.gadget_pulse_duration) {
            pulseradius = (getservertime(localclientnum) - starttime) / level.weaponvisionpulse.gadget_pulse_duration * 2000;
        }
        t = elapsedtime % fadeout_duration;
        if (t < var_fbb31a83) {
            frac = 1;
        } else if (t < var_9944bdff) {
            frac = 1 - (t - var_fbb31a83) / (var_9944bdff - var_fbb31a83);
        } else {
            frac = 0;
        }
        self function_98a01e4c(#"hash_1978eff2ac047e65", #"brightness", frac);
        waitframe(1);
    }
    self function_98a01e4c(#"hash_1978eff2ac047e65", #"brightness", 0);
    self stoprenderoverridebundle(#"hash_75f4d8048e6adb94");
    self notify(#"finished_local_pulse");
    self function_b2e26d0(localclientnum, 0);
    self.vision_pulse_owner = undefined;
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 1, eflags: 0x0
// Checksum 0x94132be, Offset: 0x1718
// Size: 0x74
function function_95d66ca(localclientnum) {
    self endon(#"death", #"disconnect", #"rob_cleanup");
    wait 1;
    self stop_postfx();
    self function_31e40037(localclientnum);
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 7, eflags: 0x0
// Checksum 0x460be634, Offset: 0x1798
// Size: 0x14c
function vision_pulse_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval && bnewent && bwastimejump) {
        self postfx::playpostfxbundle(#"hash_5a76eaaf7f7e3de5");
        self function_202a8b08(#"hash_5a76eaaf7f7e3de5", #"hash_7c1a0903a45d4d45", 0);
        self function_202a8b08(#"hash_5a76eaaf7f7e3de5", #"hash_51ebcff0b5d75894", 0);
        self function_202a8b08(#"hash_5a76eaaf7f7e3de5", #"hash_2efccfad2b32081a", 1);
        return;
    }
    if (newval == 0) {
        self thread function_95d66ca(localclientnum);
    }
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 7, eflags: 0x0
// Checksum 0x26c98274, Offset: 0x18f0
// Size: 0xe4
function toggle_postfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (is_active(localclientnum)) {
        if (newval) {
            if (self postfx::function_7348f3a5(#"hash_5a76eaaf7f7e3de5")) {
                self postfx::stoppostfxbundle(#"hash_5a76eaaf7f7e3de5");
            }
            return;
        }
        if (!self postfx::function_7348f3a5(#"hash_5a76eaaf7f7e3de5")) {
            self postfx::playpostfxbundle(#"hash_5a76eaaf7f7e3de5");
        }
    }
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 2, eflags: 0x0
// Checksum 0xa0eec6f8, Offset: 0x19e0
// Size: 0x378
function function_77621712(localclientnum, robname) {
    self notify("5d73a2cc23bbdaf9");
    self endon("5d73a2cc23bbdaf9");
    self endon(#"death", #"disconnect", #"rob_cleanup");
    speed = function_a5a8c26f(localclientnum);
    maxradius = getvisionpulsemaxradius(localclientnum);
    fadeout_duration = level.weaponvisionpulse.var_1f84215a;
    jammed = 0;
    if (self isplayer()) {
        jammed = self clientfield::get("gps_jammer_active");
    }
    var_5458f75b = isdefined(level.weaponvisionpulse.var_6af7628) ? level.weaponvisionpulse.var_6af7628 : 1;
    var_9944bdff = fadeout_duration * (jammed ? var_5458f75b : 1);
    var_fbb31a83 = var_9944bdff * (isdefined(level.weaponvisionpulse.var_97378dd6) ? level.weaponvisionpulse.var_97378dd6 : 0.8);
    elapsedtime = 0;
    owner = self gadgetpulsegetowner(localclientnum);
    while (true) {
        waitframe(1);
        if (isdefined(self.visionpulsereveal) && self.visionpulsereveal) {
            currenttime = getservertime(localclientnum);
            elapsedtime = currenttime - self.var_7ac37d1;
            if (elapsedtime < var_fbb31a83) {
                alpha = 1;
            } else if (elapsedtime < var_9944bdff) {
                alpha = 1 - (elapsedtime - var_fbb31a83) / (var_9944bdff - var_fbb31a83);
            } else if (elapsedtime < fadeout_duration) {
                alpha = 0;
            } else {
                self.visionpulsereveal = 0;
                alpha = 0;
                if (!isdefined(self.var_38cfc17e)) {
                    self.var_38cfc17e = 0;
                }
                self.var_38cfc17e++;
                self stoprenderoverridebundle(robname);
                self function_b2e26d0(localclientnum, 0);
            }
            self function_98a01e4c(robname, "Alpha", alpha);
            if (self postfx::function_7348f3a5(#"hash_5a76eaaf7f7e3de5")) {
                self function_202a8b08(#"hash_5a76eaaf7f7e3de5", #"enemy tint", 1 - alpha);
            }
        }
    }
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 2, eflags: 0x0
// Checksum 0xedeea43b, Offset: 0x1d60
// Size: 0x256
function set_reveal_enemy(localclientnum, on_off) {
    if (on_off) {
        owner = self gadgetpulsegetowner(localclientnum);
        owner thread function_44b05805(localclientnum);
        if (isalive(owner) && isdefined(level.gameended) && !level.gameended) {
            robname = #"hash_75f4d8048e6adb94";
            if (!owner function_60dbc438()) {
                robname = #"hash_62b3e8ea5469c2f5";
            }
            if (!(isdefined(self.var_9d12437d) && self.var_9d12437d)) {
                self function_b2e26d0(localclientnum, 1);
                self stoprenderoverridebundle(#"rob_sonar_set_enemy");
                self playrenderoverridebundle(robname);
                self thread function_77621712(localclientnum, robname);
            }
            self function_98a01e4c(robname, "Alpha", 1);
            if (!owner function_60dbc438()) {
                self function_98a01e4c(robname, "Tint", 0);
                self function_98a01e4c(robname, "Alpha", 1);
            }
        }
        return;
    }
    self stoprenderoverridebundle(#"hash_75f4d8048e6adb94");
    self stoprenderoverridebundle(#"hash_62b3e8ea5469c2f5");
    self function_b2e26d0(localclientnum, 0);
    self notify(#"rob_cleanup");
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 2, eflags: 0x0
// Checksum 0xac0a764f, Offset: 0x1fc0
// Size: 0x64
function set_reveal_self(localclientnum, on_off) {
    if (!self isplayer()) {
        return;
    }
    if (on_off && self function_60dbc438()) {
        self thread do_vision_local_pulse(localclientnum);
    }
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 2, eflags: 0x0
// Checksum 0x2e659cfd, Offset: 0x2030
// Size: 0x31e
function gadget_visionpulse_reveal(localclientnum, breveal) {
    self notify(#"gadget_visionpulse_changed");
    if (!isdefined(self.visionpulserevealself) && self function_60dbc438()) {
        self.visionpulserevealself = 0;
    }
    if (!isdefined(self.visionpulsereveal)) {
        self.visionpulsereveal = 0;
    }
    if (!isdefined(self)) {
        return;
    }
    owner = self gadgetpulsegetowner(localclientnum);
    if (owner !== self) {
        if (self function_60dbc438()) {
            if (self.visionpulserevealself != breveal || isdefined(self.vision_pulse_owner) && isdefined(owner) && self.vision_pulse_owner != owner) {
                self.vision_pulse_owner = owner;
                self.visionpulserevealself = breveal;
                self set_reveal_self(localclientnum, breveal);
            }
            return;
        }
        if (isalive(self) && self.visionpulsereveal != breveal) {
            if (isdefined(breveal) && breveal) {
                pulseradius = owner function_ba182063(localclientnum);
                pulsemaxradius = level.weaponvisionpulse.gadget_pulse_max_range;
                var_230e515c = int(pulseradius) / int(pulsemaxradius);
                if (isdefined(self.var_38cfc17e) && self.var_38cfc17e > 0 && self.var_38cfc17e >= var_230e515c) {
                    return;
                }
                dist = distance2d(owner.origin, self.origin);
                dist2 = dist * dist;
                radius = int(pulseradius) % pulsemaxradius;
                radius2 = radius * radius;
                if (dist2 > radius2) {
                    return;
                }
                self.var_7ac37d1 = getservertime(localclientnum);
            }
            self.visionpulsereveal = breveal;
            if (!(isdefined(breveal) && breveal)) {
                self.var_38cfc17e = 0;
            }
            self set_reveal_enemy(localclientnum, breveal);
            return;
        }
        if (!(isdefined(breveal) && breveal)) {
            self.var_38cfc17e = 0;
        }
    }
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 2, eflags: 0x0
// Checksum 0x5e9ccdfa, Offset: 0x2358
// Size: 0x22
function function_b2e26d0(local_client_num, pulsed) {
    self.var_9d12437d = pulsed;
}

// Namespace gadget_vision_pulse/gadget_vision_pulse
// Params 1, eflags: 0x0
// Checksum 0xf61df879, Offset: 0x2388
// Size: 0x44
function is_active(local_client_num) {
    return isdefined(level.vision_pulse) && isdefined(level.vision_pulse[local_client_num]) && level.vision_pulse[local_client_num];
}

