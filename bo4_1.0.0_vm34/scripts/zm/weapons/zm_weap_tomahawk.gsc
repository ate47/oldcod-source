#using scripts\abilities\ability_player;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_net;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_weap_tomahawk;

// Namespace zm_weap_tomahawk/zm_weap_tomahawk
// Params 0, eflags: 0x2
// Checksum 0x33fcf9b8, Offset: 0x240
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_weap_tomahawk", &__init__, &__main__, undefined);
}

// Namespace zm_weap_tomahawk/zm_weap_tomahawk
// Params 0, eflags: 0x0
// Checksum 0x13c112e7, Offset: 0x290
// Size: 0x294
function __init__() {
    clientfield::register("toplayer", "tomahawk_in_use", 1, 2, "int");
    clientfield::register("toplayer", "" + #"upgraded_tomahawk_in_use", 1, 1, "int");
    clientfield::register("scriptmover", "play_tomahawk_fx", 1, 2, "int");
    clientfield::register("actor", "play_tomahawk_hit_sound", 1, 1, "int");
    clientfield::register("toplayer", "tomahawk_rumble", 1, 2, "counter");
    clientfield::register("actor", "tomahawk_impact_fx", 1, 2, "int");
    clientfield::register("allplayers", "tomahawk_charge_up_fx", 1, 2, "counter");
    var_2a409e1b = getminbitcountfornum(3);
    clientfield::register("scriptmover", "tomahawk_trail_fx", 1, var_2a409e1b, "int");
    clientfield::register("missile", "tomahawk_trail_fx", 1, var_2a409e1b, "int");
    callback::on_connect(&tomahawk_on_player_connect);
    zm_powerups::set_weapon_ignore_max_ammo(#"tomahawk_t8_zm");
    zm_powerups::set_weapon_ignore_max_ammo(#"hash_57fcbff622b2ad9f");
    level.a_tomahawk_pickup_funcs = [];
    zm_loadout::register_lethal_grenade_for_level(#"tomahawk_t8");
    zm_loadout::register_lethal_grenade_for_level(#"tomahawk_t8_upgraded");
}

// Namespace zm_weap_tomahawk/zm_weap_tomahawk
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x530
// Size: 0x4
function __main__() {
    
}

// Namespace zm_weap_tomahawk/zm_weap_tomahawk
// Params 0, eflags: 0x0
// Checksum 0xa4c69d58, Offset: 0x540
// Size: 0x44
function tomahawk_on_player_connect() {
    self.var_77e5e3ce = #"tomahawk_t8";
    self thread watch_for_tomahawk_throw();
    self thread watch_for_tomahawk_charge();
}

// Namespace zm_weap_tomahawk/zm_weap_tomahawk
// Params 0, eflags: 0x4
// Checksum 0x6e35a8d3, Offset: 0x590
// Size: 0x216
function private watch_for_tomahawk_throw() {
    self endon(#"disconnect");
    while (true) {
        s_result = self waittill(#"grenade_fire");
        e_grenade = s_result.projectile;
        w_weapon = s_result.weapon;
        w_tomahawk = getweapon(#"tomahawk_t8");
        w_upgraded = getweapon(#"tomahawk_t8_upgraded");
        if (w_weapon == w_tomahawk || w_weapon == w_upgraded) {
            self thread tomahawk_rumble(2);
            self ability_player::function_184edba5(w_weapon);
            e_grenade.use_grenade_special_bookmark = 1;
            e_grenade.grenade_multiattack_bookmark_count = 1;
            e_grenade.low_level_instant_kill_charge = 1;
            e_grenade.owner = self;
            self notify(#"throwing_tomahawk", {#e_grenade:e_grenade, #w_weapon:w_weapon});
            self thread function_af2b1425(w_weapon);
            if (isdefined(self.n_tomahawk_cooking_time)) {
                e_grenade.n_cookedtime = e_grenade.birthtime - self.n_tomahawk_cooking_time;
            } else {
                e_grenade.n_cookedtime = 0;
            }
            self thread check_for_time_out(e_grenade);
            self thread tomahawk_thrown(e_grenade);
            self waittill(#"tomahawk_returned");
        }
    }
}

// Namespace zm_weap_tomahawk/zm_weap_tomahawk
// Params 1, eflags: 0x4
// Checksum 0x3c81bf83, Offset: 0x7b0
// Size: 0x13c
function private function_af2b1425(w_weapon) {
    self endon(#"disconnect");
    self waittill(#"hash_1a7714f0d7e25f27");
    self ability_player::function_281eba9f(w_weapon);
    var_c20d6fc5 = 100 / 8 / 0.25;
    n_start_time = gettime();
    n_total_time = 0;
    n_power = 0;
    while (n_total_time < 8) {
        n_power += var_c20d6fc5;
        self gadgetpowerset(self gadgetgetslot(w_weapon), n_power);
        wait 0.25;
        n_current_time = gettime();
        n_total_time = (n_current_time - n_start_time) / 1000;
    }
    self gadgetpowerset(self gadgetgetslot(w_weapon), 100);
}

// Namespace zm_weap_tomahawk/zm_weap_tomahawk
// Params 0, eflags: 0x4
// Checksum 0x9012cb51, Offset: 0x8f8
// Size: 0x13a
function private watch_for_tomahawk_charge() {
    self endon(#"disconnect");
    while (true) {
        s_result = self waittill(#"grenade_pullback");
        w_grenade = s_result.weapon;
        w_tomahawk = getweapon(#"tomahawk_t8");
        w_upgraded = getweapon(#"tomahawk_t8_upgraded");
        if (w_grenade == w_tomahawk || w_grenade == w_upgraded) {
            self.n_tomahawk_cooking_time = gettime();
            self thread play_charge_fx(w_grenade);
            self thread function_b76d85e0(w_grenade);
            self waittill(#"grenade_fire", #"grenade_throw_cancelled");
            wait 0.1;
            self.n_tomahawk_cooking_time = undefined;
        }
    }
}

// Namespace zm_weap_tomahawk/zm_weap_tomahawk
// Params 1, eflags: 0x4
// Checksum 0x44c34a81, Offset: 0xa40
// Size: 0x17a
function private play_charge_fx(w_grenade) {
    self endon(#"death", #"disconnect", #"grenade_fire", #"grenade_throw_cancelled");
    waittillframeend();
    var_917ae55f = 1000;
    while (true) {
        time = gettime() - self.n_tomahawk_cooking_time;
        self.var_77e5e3ce = w_grenade.name;
        if (time >= var_917ae55f) {
            if (self.var_77e5e3ce == #"tomahawk_t8_upgraded") {
                self clientfield::increment("tomahawk_charge_up_fx", 2);
            } else {
                self clientfield::increment("tomahawk_charge_up_fx", 1);
            }
            var_917ae55f += 1000;
            self playrumbleonentity("reload_small");
        }
        if (var_917ae55f > 2400 && self.var_77e5e3ce != #"tomahawk_t8_upgraded") {
            break;
        }
        if (var_917ae55f >= 3400) {
            break;
        }
        waitframe(1);
    }
}

// Namespace zm_weap_tomahawk/zm_weap_tomahawk
// Params 1, eflags: 0x4
// Checksum 0x180bbd8b, Offset: 0xbc8
// Size: 0xb0
function private function_b76d85e0(w_grenade) {
    self endon(#"death", #"disconnect", #"grenade_fire", #"grenade_throw_cancelled");
    self thread tomahawk_rumble(3);
    wait 1;
    while (true) {
        self playrumbleonentity("damage_light");
        wait 0.3;
    }
}

// Namespace zm_weap_tomahawk/zm_weap_tomahawk
// Params 1, eflags: 0x4
// Checksum 0xa74698be, Offset: 0xc80
// Size: 0x12e
function private get_grenade_charge_power(player) {
    player endon(#"disconnect");
    if (!isdefined(self)) {
        return 1;
    }
    if (self.n_cookedtime > 1000 && self.n_cookedtime < 2000) {
        if (player.var_77e5e3ce == #"tomahawk_t8_upgraded") {
            return 4.5;
        }
        return 1.5;
    } else if (self.n_cookedtime > 2000 && self.n_cookedtime < 3000) {
        if (player.var_77e5e3ce == #"tomahawk_t8_upgraded") {
            return 6;
        }
        return 2;
    } else if (self.n_cookedtime >= 3000 && player.var_77e5e3ce != #"tomahawk_t8_upgraded") {
        return 2;
    } else if (self.n_cookedtime >= 3000) {
        return 3;
    }
    return 1;
}

// Namespace zm_weap_tomahawk/zm_weap_tomahawk
// Params 1, eflags: 0x4
// Checksum 0xd8cd460a, Offset: 0xdb8
// Size: 0x70c
function private tomahawk_thrown(e_grenade) {
    self endon(#"disconnect");
    grenade_owner = undefined;
    if (isdefined(e_grenade.owner)) {
        grenade_owner = e_grenade.owner;
    }
    var_77e36895 = 0;
    var_c3f38721 = 0;
    e_grenade clientfield::set("tomahawk_trail_fx", 3);
    self clientfield::set_to_player("tomahawk_in_use", 2);
    e_grenade waittill(#"death", #"time_out");
    n_grenade_charge_power = e_grenade get_grenade_charge_power(self);
    if (isdefined(level.a_tomahawk_pickup_funcs)) {
        foreach (tomahawk_func in level.a_tomahawk_pickup_funcs) {
            if ([[ tomahawk_func ]](e_grenade, n_grenade_charge_power)) {
                return;
            }
        }
    }
    a_powerups = [];
    if (level.active_powerups.size) {
        foreach (e_powerup in level.active_powerups) {
            if (isdefined(e_powerup sightconetrace(self geteye(), self, anglestoforward(self.angles), 4)) && e_powerup sightconetrace(self geteye(), self, anglestoforward(self.angles), 4)) {
                if (!isdefined(a_powerups)) {
                    a_powerups = [];
                } else if (!isarray(a_powerups)) {
                    a_powerups = array(a_powerups);
                }
                if (!isinarray(a_powerups, e_powerup)) {
                    a_powerups[a_powerups.size] = e_powerup;
                }
            }
        }
    }
    if (a_powerups.size) {
        mdl_tomahawk = tomahawk_spawn(e_grenade.origin, n_grenade_charge_power);
        mdl_tomahawk.n_grenade_charge_power = n_grenade_charge_power;
        mdl_tomahawk.low_level_instant_kill_charge = e_grenade.low_level_instant_kill_charge;
        if (isdefined(e_grenade)) {
            e_grenade delete();
        }
        foreach (powerup in a_powerups) {
            powerup.origin = mdl_tomahawk.origin;
            powerup linkto(mdl_tomahawk);
            mdl_tomahawk.a_has_powerup = a_powerups;
        }
        self thread tomahawk_return_player(mdl_tomahawk, 0);
        return;
    }
    a_ai_zombies = util::get_array_of_closest(e_grenade.origin, getaiteamarray(level.zombie_team), undefined, undefined, 64);
    if (a_ai_zombies.size) {
        while (a_ai_zombies.size) {
            if (isalive(a_ai_zombies[0])) {
                var_60c97e44 = a_ai_zombies[0];
                arrayremovevalue(a_ai_zombies, var_60c97e44);
                var_60c97e44 clientfield::set("play_tomahawk_hit_sound", 1);
                n_tomahawk_damage = calculate_tomahawk_damage(var_60c97e44, n_grenade_charge_power, e_grenade);
                var_60c97e44 dodamage(n_tomahawk_damage, e_grenade.origin, self, self, "none", "MOD_GRENADE", 0, getweapon(#"tomahawk_t8"));
                if (var_60c97e44.health < 0) {
                    var_c3f38721++;
                }
                var_60c97e44.hit_by_tomahawk = 1;
                var_68f6c2f1 = var_60c97e44;
                var_77e36895++;
                self zm_score::add_to_player_score(10);
                if (var_77e36895 >= 5) {
                    if (var_c3f38721 >= 5) {
                        self notify(#"hash_3669499a148a6d6e", {#weapon:e_grenade.weapon});
                    }
                    mdl_tomahawk = tomahawk_spawn(e_grenade.origin, n_grenade_charge_power);
                    mdl_tomahawk.n_grenade_charge_power = n_grenade_charge_power;
                    mdl_tomahawk.low_level_instant_kill_charge = e_grenade.low_level_instant_kill_charge;
                    if (isdefined(e_grenade)) {
                        e_grenade delete();
                    }
                    self thread tomahawk_return_player(mdl_tomahawk, var_77e36895);
                    return;
                }
            }
            a_ai_zombies = array::remove_undefined(a_ai_zombies);
        }
        self thread tomahawk_ricochet_attack(var_77e36895, e_grenade, n_grenade_charge_power, var_68f6c2f1);
        return;
    }
    self thread tomahawk_ricochet_attack(var_77e36895, e_grenade, n_grenade_charge_power, var_68f6c2f1);
}

// Namespace zm_weap_tomahawk/zm_weap_tomahawk
// Params 1, eflags: 0x4
// Checksum 0x70c987c3, Offset: 0x14d0
// Size: 0x50
function private check_for_time_out(e_grenade) {
    self endon(#"disconnect");
    e_grenade endon(#"death");
    wait 0.5;
    e_grenade notify(#"time_out");
}

// Namespace zm_weap_tomahawk/zm_weap_tomahawk
// Params 4, eflags: 0x4
// Checksum 0x812338d5, Offset: 0x1528
// Size: 0x60c
function private tomahawk_ricochet_attack(var_77e36895, e_grenade, var_d47dc3fb, e_ignore) {
    self endon(#"disconnect");
    mdl_tomahawk = tomahawk_spawn(e_grenade.origin, var_d47dc3fb);
    mdl_tomahawk.n_grenade_charge_power = var_d47dc3fb;
    mdl_tomahawk.low_level_instant_kill_charge = e_grenade.low_level_instant_kill_charge;
    mdl_tomahawk endon(#"death");
    if (isdefined(e_grenade)) {
        e_grenade delete();
    }
    if (var_77e36895 >= 5) {
        self thread tomahawk_return_player(mdl_tomahawk, var_77e36895);
        return;
    }
    a_ai_zombies = util::get_array_of_closest(self.origin, getaiteamarray(level.zombie_team), undefined, undefined, 900);
    if (!a_ai_zombies.size) {
        self thread tomahawk_return_player(mdl_tomahawk, var_77e36895);
        return;
    }
    var_406c619c = [];
    var_f87b8de4 = 5 - var_77e36895;
    v_start_pos = self.origin + (0, 0, 50);
    e_ignore = self;
    do {
        s_trace = bullettrace(v_start_pos, v_start_pos + anglestoforward(self getplayerangles()) * 900, 1, e_ignore);
        if (isdefined(s_trace[#"entity"]) && isinarray(getaiteamarray(level.zombie_team), s_trace[#"entity"])) {
            if (!(isdefined(s_trace[#"entity"].hit_by_tomahawk) && s_trace[#"entity"].hit_by_tomahawk)) {
                if (!isdefined(var_406c619c)) {
                    var_406c619c = [];
                } else if (!isarray(var_406c619c)) {
                    var_406c619c = array(var_406c619c);
                }
                if (!isinarray(var_406c619c, s_trace[#"entity"])) {
                    var_406c619c[var_406c619c.size] = s_trace[#"entity"];
                }
            }
            v_start_pos = s_trace[#"entity"].origin + (0, 0, 50);
            e_ignore = s_trace[#"entity"];
        }
        if (var_406c619c.size >= var_f87b8de4) {
            break;
        }
    } while (isdefined(s_trace[#"entity"]) && isinarray(a_ai_zombies, s_trace[#"entity"]));
    v_start_pos = self.origin + (0, 0, 50);
    e_ignore = self;
    foreach (ai_zombie in a_ai_zombies) {
        if (var_406c619c.size >= var_f87b8de4) {
            break;
        }
        if (isdefined(ai_zombie sightconetrace(v_start_pos, e_ignore, vectornormalize(self getplayerangles()), 5)) && ai_zombie sightconetrace(v_start_pos, e_ignore, vectornormalize(self getplayerangles()), 5)) {
            if (!(isdefined(ai_zombie.hit_by_tomahawk) && ai_zombie.hit_by_tomahawk)) {
                if (!isdefined(var_406c619c)) {
                    var_406c619c = [];
                } else if (!isarray(var_406c619c)) {
                    var_406c619c = array(var_406c619c);
                }
                if (!isinarray(var_406c619c, ai_zombie)) {
                    var_406c619c[var_406c619c.size] = ai_zombie;
                }
            }
            v_start_pos = ai_zombie.origin + (0, 0, 50);
            e_ignore = ai_zombie;
        }
    }
    if (var_406c619c.size) {
        var_406c619c = arraysortclosest(var_406c619c, self.origin);
        var_77e36895 = self function_147f1df9(mdl_tomahawk, var_406c619c, var_77e36895);
    }
    if (var_77e36895 >= 5) {
        self thread tomahawk_return_player(mdl_tomahawk, var_77e36895);
        return;
    }
    self thread function_406e4465(mdl_tomahawk, var_77e36895);
}

// Namespace zm_weap_tomahawk/zm_weap_tomahawk
// Params 2, eflags: 0x4
// Checksum 0x3f220c42, Offset: 0x1b40
// Size: 0x284
function private function_406e4465(mdl_tomahawk, var_77e36895) {
    var_406c619c = [];
    a_ai_zombies = util::get_array_of_closest(self.origin, getaiteamarray(level.zombie_team), undefined, undefined, 900);
    foreach (ai_zombie in a_ai_zombies) {
        if (isdefined(ai_zombie sightconetrace(self geteye(), self, vectornormalize(self getplayerangles()), 17)) && ai_zombie sightconetrace(self geteye(), self, vectornormalize(self getplayerangles()), 17) && !(isdefined(ai_zombie.hit_by_tomahawk) && ai_zombie.hit_by_tomahawk)) {
            if (!isdefined(var_406c619c)) {
                var_406c619c = [];
            } else if (!isarray(var_406c619c)) {
                var_406c619c = array(var_406c619c);
            }
            if (!isinarray(var_406c619c, ai_zombie)) {
                var_406c619c[var_406c619c.size] = ai_zombie;
            }
        }
    }
    if (var_406c619c.size) {
        var_406c619c = arraysortclosest(var_406c619c, self.origin);
        var_406c619c = array::reverse(var_406c619c);
        var_77e36895 = self function_147f1df9(mdl_tomahawk, var_406c619c, var_77e36895);
    }
    self thread tomahawk_return_player(mdl_tomahawk, var_77e36895);
}

// Namespace zm_weap_tomahawk/zm_weap_tomahawk
// Params 3, eflags: 0x4
// Checksum 0x65851130, Offset: 0x1dd0
// Size: 0x21c
function private function_147f1df9(mdl_tomahawk, a_ai_zombie, var_77e36895) {
    self endon(#"disconnect");
    while (true) {
        ai_zombie = undefined;
        for (i = 0; i < a_ai_zombie.size; i++) {
            if (isalive(a_ai_zombie[i]) && !(isdefined(a_ai_zombie[i].hit_by_tomahawk) && a_ai_zombie[i].hit_by_tomahawk)) {
                if (isdefined(bullettracepassed(mdl_tomahawk.origin, a_ai_zombie[i] geteye(), 0, mdl_tomahawk)) && bullettracepassed(mdl_tomahawk.origin, a_ai_zombie[i] geteye(), 0, mdl_tomahawk)) {
                    ai_zombie = a_ai_zombie[i];
                    break;
                }
            }
        }
        if (!isdefined(ai_zombie)) {
            return var_77e36895;
        }
        n_dist = distance(mdl_tomahawk.origin, ai_zombie gettagorigin("j_head"));
        var_178904fe = n_dist / 1600;
        var_178904fe = var_178904fe < 0.05 ? 0.05 : var_178904fe;
        self thread function_615a3feb(mdl_tomahawk, ai_zombie, var_178904fe);
        wait var_178904fe;
        var_77e36895++;
        if (var_77e36895 >= 5) {
            return var_77e36895;
        }
    }
    return var_77e36895;
}

// Namespace zm_weap_tomahawk/zm_weap_tomahawk
// Params 3, eflags: 0x4
// Checksum 0x136c448, Offset: 0x1ff8
// Size: 0x20c
function private function_615a3feb(mdl_tomahawk, ai_zombie, var_178904fe = 0.25) {
    self endon(#"disconnect");
    if (isalive(ai_zombie) && !(isdefined(ai_zombie.hit_by_tomahawk) && ai_zombie.hit_by_tomahawk)) {
        v_target = ai_zombie gettagorigin("J_Head");
        mdl_tomahawk moveto(v_target, var_178904fe);
        wait var_178904fe;
        if (isalive(ai_zombie)) {
            ai_zombie.hit_by_tomahawk = 1;
            if (self.var_77e5e3ce == #"tomahawk_t8_upgraded") {
                ai_zombie clientfield::set("tomahawk_impact_fx", 2);
            } else {
                ai_zombie clientfield::set("tomahawk_impact_fx", 1);
            }
            ai_zombie clientfield::set("play_tomahawk_hit_sound", 1);
            self zm_score::add_to_player_score(10);
            n_tomahawk_damage = calculate_tomahawk_damage(ai_zombie, mdl_tomahawk.n_grenade_charge_power, mdl_tomahawk);
            ai_zombie dodamage(n_tomahawk_damage, mdl_tomahawk.origin, self, mdl_tomahawk, "none", "MOD_GRENADE", 0, getweapon(self.var_77e5e3ce));
        }
    }
}

// Namespace zm_weap_tomahawk/zm_weap_tomahawk
// Params 3, eflags: 0x0
// Checksum 0xcb17735f, Offset: 0x2210
// Size: 0x416
function tomahawk_return_player(mdl_tomahawk, var_77e36895, n_move_speed = 1600) {
    self endon(#"disconnect");
    if (isdefined(mdl_tomahawk)) {
        n_dist = distance(mdl_tomahawk.origin, self geteye());
        var_b24738 = n_dist / n_move_speed;
        var_b24738 = var_b24738 < 0.05 ? 0.05 : var_b24738;
        n_total_time = undefined;
        n_dist_sq = distance2dsquared(mdl_tomahawk.origin, self geteye());
        if (!isdefined(var_77e36895)) {
            var_77e36895 = 5;
        }
        while (n_dist_sq > 1600) {
            mdl_tomahawk moveto(self geteye(), var_b24738);
            if (var_77e36895 < 5) {
                self function_9849e6ea(mdl_tomahawk);
                var_77e36895++;
                wait 0.1;
            } else {
                if (!isdefined(n_total_time)) {
                    n_start_time = gettime();
                    n_total_time = 0;
                }
                wait 0.1;
                n_current_time = gettime();
                n_total_time = (n_current_time - n_start_time) / 1000;
                var_b24738 = self function_c7b344d7(mdl_tomahawk, n_move_speed, n_total_time);
            }
            n_dist_sq = distance2dsquared(mdl_tomahawk.origin, self geteye());
        }
        if (isdefined(mdl_tomahawk.a_has_powerup)) {
            foreach (powerup in mdl_tomahawk.a_has_powerup) {
                if (isdefined(powerup)) {
                    powerup.origin = self.origin;
                }
            }
        }
        mdl_tomahawk delete();
    }
    self thread tomahawk_rumble(1);
    self playsound("wpn_tomahawk_return");
    self notify(#"hash_1a7714f0d7e25f27");
    wait 8;
    self playsoundtoplayer("wpn_tomahawk_cooldown_complete", self);
    self givemaxammo(getweapon(self.var_77e5e3ce));
    a_zombies = getaispeciesarray(level.zombie_team, "all");
    foreach (ai_zombie in a_zombies) {
        ai_zombie.hit_by_tomahawk = undefined;
    }
    self clientfield::set_to_player("tomahawk_in_use", 3);
    self notify(#"tomahawk_returned");
}

// Namespace zm_weap_tomahawk/zm_weap_tomahawk
// Params 3, eflags: 0x4
// Checksum 0x8ee495b2, Offset: 0x2630
// Size: 0x11c
function private function_c7b344d7(mdl_tomahawk, n_move_speed, n_total_time) {
    if (n_total_time < 0.05) {
        var_dd160c2d = 0.05 - n_total_time;
        var_dd160c2d = var_dd160c2d < 0.05 ? 0.05 : var_dd160c2d;
    } else {
        var_dd160c2d = 0.05;
    }
    var_e3817aa9 = n_total_time * 0.25;
    var_388061ea = n_move_speed + n_move_speed * var_e3817aa9;
    n_dist = distance(mdl_tomahawk.origin, self geteye());
    var_b24738 = n_dist / var_388061ea;
    var_b24738 = var_b24738 < var_dd160c2d ? var_dd160c2d : var_b24738;
    return var_b24738;
}

// Namespace zm_weap_tomahawk/zm_weap_tomahawk
// Params 1, eflags: 0x4
// Checksum 0x853fdc59, Offset: 0x2758
// Size: 0x10c
function private function_9849e6ea(mdl_tomahawk) {
    self endon(#"disconnect");
    mdl_tomahawk endon(#"death");
    a_ai_zombies = getaiteamarray(level.zombie_team);
    if (a_ai_zombies.size) {
        ai_zombie = arraygetclosest(mdl_tomahawk.origin, a_ai_zombies);
        if (isalive(ai_zombie) && distance2dsquared(mdl_tomahawk.origin, ai_zombie.origin) <= 10000) {
            if (!(isdefined(ai_zombie.hit_by_tomahawk) && ai_zombie.hit_by_tomahawk)) {
                self function_615a3feb(mdl_tomahawk, ai_zombie);
            }
        }
    }
}

// Namespace zm_weap_tomahawk/zm_weap_tomahawk
// Params 2, eflags: 0x0
// Checksum 0x4bf9ac81, Offset: 0x2870
// Size: 0x166
function tomahawk_spawn(grenade_origin, charged) {
    mdl_tomahawk = util::spawn_model("wpn_t8_zm_tomahawk_world", grenade_origin);
    mdl_tomahawk thread tomahawk_spin();
    if (self.var_77e5e3ce == #"tomahawk_t8_upgraded" || isdefined(self.var_fa61bb16) && self.var_fa61bb16) {
        mdl_tomahawk clientfield::set("tomahawk_trail_fx", 2);
    } else {
        mdl_tomahawk clientfield::set("tomahawk_trail_fx", 1);
    }
    if (isdefined(charged) && charged > 1 && isdefined(self.var_fa61bb16)) {
        mdl_tomahawk clientfield::set("tomahawk_trail_fx", 4);
    } else if (isdefined(charged) && charged > 1) {
        mdl_tomahawk clientfield::set("tomahawk_trail_fx", 3);
    }
    mdl_tomahawk.low_level_instant_kill_charge = 1;
    return mdl_tomahawk;
}

// Namespace zm_weap_tomahawk/zm_weap_tomahawk
// Params 0, eflags: 0x4
// Checksum 0x28981e3e, Offset: 0x29e0
// Size: 0x50
function private tomahawk_spin() {
    self endon(#"death");
    while (isdefined(self)) {
        self rotatepitch(90, 0.2);
        wait 0.15;
    }
}

// Namespace zm_weap_tomahawk/zm_weap_tomahawk
// Params 3, eflags: 0x4
// Checksum 0x521460bd, Offset: 0x2a38
// Size: 0x132
function private calculate_tomahawk_damage(var_1190d3d4, n_tomahawk_power, tomahawk) {
    if (n_tomahawk_power > 2) {
        return (var_1190d3d4.health + 1);
    }
    if (level.round_number >= 10 && level.round_number < 13 && tomahawk.low_level_instant_kill_charge <= 3) {
        tomahawk.low_level_instant_kill_charge += 1;
        return (var_1190d3d4.health + 1);
    }
    if (level.round_number >= 13 && level.round_number < 15 && tomahawk.low_level_instant_kill_charge <= 2) {
        tomahawk.low_level_instant_kill_charge += 1;
        return (var_1190d3d4.health + 1);
    }
    return 1000 * n_tomahawk_power;
}

// Namespace zm_weap_tomahawk/zm_weap_tomahawk
// Params 1, eflags: 0x4
// Checksum 0x53564c4d, Offset: 0x2b78
// Size: 0xca
function private tomahawk_rumble(var_b35c2422) {
    if (var_b35c2422) {
        switch (var_b35c2422) {
        case 3:
            self playrumbleonentity("zm_weap_special_activate_rumble");
            break;
        case 1:
            self clientfield::increment_to_player("tomahawk_rumble", 1);
            break;
        case 2:
            self clientfield::increment_to_player("tomahawk_rumble", 2);
            break;
        }
    }
}

