#using scripts\abilities\ability_player;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\math_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\util_shared;

#namespace gadget_radiation_field;

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 0, eflags: 0x0
// Checksum 0xeea99c10, Offset: 0x2a0
// Size: 0x124
function init_shared() {
    level.radiationfield_bundle = getscriptbundle("radiation_field_bundle");
    clientfield::register("scriptmover", "cf_overclock_fx", 1, 1, "int");
    clientfield::register("scriptmover", "self_destruct_start", 1, 1, "int");
    clientfield::register("scriptmover", "self_destruct_end", 1, 1, "int");
    ability_player::register_gadget_activation_callbacks(24, &gadget_on, &gadget_off);
    ability_player::register_gadget_ready_callbacks(24, &on_ready);
    callback::on_spawned(&on_player_spawned);
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 2, eflags: 0x0
// Checksum 0xf676d2c0, Offset: 0x3d0
// Size: 0xbc
function on_ready(slot, weapon) {
    player = self;
    if (player._gadgets_player[2].name === "gadget_radiation_field") {
        if (player function_e77afe2f(player._gadgets_player[2].var_1ccf6f54)) {
            player clientfield::set_player_uimodel("huditems.abilityHoldToActivate", 0);
            return;
        }
        player clientfield::set_player_uimodel("huditems.abilityHoldToActivate", 1);
    }
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 1, eflags: 0x0
// Checksum 0x36d239dc, Offset: 0x498
// Size: 0x1a
function function_16e396e9(func) {
    level.var_b8682531 = func;
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 0, eflags: 0x0
// Checksum 0x7952cc28, Offset: 0x4c0
// Size: 0x17c
function on_player_spawned() {
    player = self;
    player endon(#"death", #"disconnect");
    if (isdefined(player.var_ef36361c) && player.var_ef36361c) {
        player function_e4a6ba37();
    }
    if (isdefined(player.var_53b1c4dd)) {
        objective_delete(player.var_53b1c4dd);
        gameobjects::release_obj_id(player.var_53b1c4dd);
        player.var_53b1c4dd = undefined;
    }
    while (!isdefined(player._gadgets_player[2])) {
        waitframe(1);
    }
    if (player._gadgets_player[0].name === "gadget_radiation_field") {
        player clientfield::set_player_uimodel("huditems.abilityHoldToActivate", 1);
        player.overrideplayerdamage = &player_damage_override;
    } else {
        player clientfield::set_player_uimodel("huditems.abilityHoldToActivate", 0);
    }
    player function_ab04c23b();
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 11, eflags: 0x0
// Checksum 0x34ca2b11, Offset: 0x648
// Size: 0x156
function player_damage_override(einflictor, eattacker, idamage, idflags, mod, weapon, vpoint, vdir, shitloc, modelindex, psoffsettime) {
    if (isdefined(self.var_1dee8972)) {
        if (mod == "MOD_BULLET" || mod == "MOD_RIFLE_BULLET" || mod == "MOD_PISTOL_BULLET" || mod == "MOD_HEAD_SHOT") {
            idamage *= isdefined(level.radiationfield_bundle.var_2c404866) ? level.radiationfield_bundle.var_2c404866 : 1;
            fx = level.radiationfield_bundle.var_e8ca12bb;
            if (isdefined(fx)) {
                fxhandle = playfx(fx, vpoint, vdir * -1);
                fxhandle.team = self.team;
            }
        }
    }
    return idamage;
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 0, eflags: 0x0
// Checksum 0x24d2b824, Offset: 0x7a8
// Size: 0x358
function function_75a37454() {
    player = self;
    player endon(#"death", #"disconnect", #"radiation_shutdown");
    rate = 0.15;
    cur_time = 0;
    if (isdefined(player.var_53b1c4dd)) {
        objective_setprogress(player.var_53b1c4dd, 0);
    }
    total_time = level.radiationfield_bundle.baseduration + level.radiationfield_bundle.var_1207426d;
    redline = 0.75;
    player notify(#"hash_477083bb681cce64");
    while (true) {
        wait rate;
        cur_time += rate;
        percent = min(1, cur_time / total_time);
        if (isdefined(player.var_53b1c4dd)) {
            objective_setprogress(player.var_53b1c4dd, percent * redline);
        }
        if (cur_time > total_time) {
            break;
        }
    }
    if (isdefined(player.var_53b1c4dd)) {
        objective_setprogress(player.var_53b1c4dd, redline);
    }
    for (dps = player status_effect::function_f67d618d(); dps == 0; dps = player status_effect::function_f67d618d()) {
        waitframe(1);
    }
    total_time = player.health / dps;
    start_health = player.health;
    if (start_health < 1) {
        if (isdefined(player.var_53b1c4dd)) {
            objective_delete(player.var_53b1c4dd);
            gameobjects::release_obj_id(player.var_53b1c4dd);
            player.var_53b1c4dd = undefined;
        }
        return;
    }
    cur_time = 0;
    while (true) {
        wait rate;
        cur_time += rate;
        percent = min(1, 1 - player.health / start_health);
        value = redline + percent * (1 - redline);
        value = math::clamp(value, 0, 0.99);
        if (isdefined(player.var_53b1c4dd)) {
            objective_setprogress(player.var_53b1c4dd, value);
        }
        if (cur_time > total_time) {
            break;
        }
    }
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 2, eflags: 0x0
// Checksum 0x4d3f5b02, Offset: 0xb08
// Size: 0x44
function vecscale(vec, scalar) {
    return (vec[0] * scalar, vec[1] * scalar, vec[2] * scalar);
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 1, eflags: 0x0
// Checksum 0xef2acc3, Offset: 0xb58
// Size: 0x114
function on_player_killed(s_params) {
    player = self;
    attacker = s_params.eattacker;
    if (isdefined(player.var_a541ee78) && player.var_a541ee78) {
        attacker = s_params.eattacker;
        if (attacker === player) {
            player.var_1dee8972 clientfield::set("self_destruct_end", 1);
        } else {
            weapon = s_params.weapon;
            scoreevents::processscoreevent(#"radiation_field_shutdown", attacker, player, weapon);
        }
    }
    player callback::function_1f42556c(#"on_player_killed_with_params", &on_player_killed);
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 1, eflags: 0x0
// Checksum 0x88f4ddeb, Offset: 0xc78
// Size: 0x3e4
function function_b3e716d1(weapon) {
    player = self;
    player setclientthirdperson(1);
    player disableweaponcycling();
    prevstance = player getstance();
    player setstance("crouch");
    player allowprone(0);
    player allowstand(0);
    player function_7c335f14(1);
    player.var_a541ee78 = 1;
    player callback::function_1dea870d(#"on_player_killed_with_params", &on_player_killed);
    fwd = vecscale(vectornormalize(anglestoforward(player.angles)), 20);
    player.var_cb794a39 = player.origin;
    player.var_cb794a39 += fwd;
    player.var_53b1c4dd = gameobjects::get_next_obj_id();
    objective_add(player.var_53b1c4dd, "active", (player.var_cb794a39[0], player.var_cb794a39[1], player.var_cb794a39[2]), #"hash_1bf4e9e4ba326a9");
    objective_setteam(player.var_53b1c4dd, player.team);
    objective_setinvisibletoall(player.var_53b1c4dd);
    objective_setvisibletoplayer(player.var_53b1c4dd, player);
    anchor = spawn("script_model", player.var_cb794a39, 0, (0, 0, 1));
    anchor setowner(player);
    anchor setteam(player.team);
    anchor setmodel(#"wpn_t8_sig_radiation_device_world");
    anchor ghost();
    anchor linkto(player);
    player thread function_75a37454();
    anchor clientfield::set("cf_overclock_fx", 1);
    anchor clientfield::set("self_destruct_start", 0);
    anchor clientfield::set("self_destruct_end", 0);
    player.var_1dee8972 = anchor;
    player thread function_7ba77f33(weapon);
    player thread function_cec8eeab();
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 2, eflags: 0x0
// Checksum 0x797503ef, Offset: 0x1068
// Size: 0x56
function state_watch(state_id, time) {
    player = self;
    player endon(#"radiation_shutdown");
    wait time;
    player notify("state_done_" + state_id);
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 0, eflags: 0x0
// Checksum 0xe9fe4639, Offset: 0x10c8
// Size: 0x122
function function_ab04c23b() {
    player = self;
    if (isdefined(player.var_4dd31d2d)) {
        foreach (loop_ent in player.var_4dd31d2d) {
            loop_ent stoploopsound(0.1);
        }
        foreach (loop_ent in player.var_4dd31d2d) {
            loop_ent delete();
        }
        player.var_4dd31d2d = undefined;
    }
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 2, eflags: 0x0
// Checksum 0x6d630944, Offset: 0x11f8
// Size: 0x36
function function_ca6a4e21(val, arg) {
    return isdefined(val.archetype) && val.archetype == arg;
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 10, eflags: 0x0
// Checksum 0xe648fa79, Offset: 0x1238
// Size: 0xc3e
function damage_state(state_id, weapon, min_radius, max_radius, min_height, max_height, duration, var_67b51e3f, loop_sound, var_ea216908) {
    player = self;
    if (state_id < 3) {
        player thread state_watch(state_id, duration);
    }
    player endon("state_done_" + state_id, #"radiation_shutdown");
    var_bd87ca87 = getstatuseffect(var_67b51e3f);
    var_5da43efa = undefined;
    if (isdefined(var_ea216908)) {
        var_5da43efa = getstatuseffect(var_ea216908);
        if (isdefined(level.heroplaydialog)) {
            buffer = 0;
            if (isdefined(level.var_86ebfbc0)) {
                buffer = [[ level.var_86ebfbc0 ]]("playerExertBuffer", 0);
            }
            player [[ level.heroplaydialog ]]("exertRadiationSelfStart", 30, buffer);
            var_464ef3cd = gettime() + 1000;
        }
    }
    enemyteam = util::getotherteam(player.team);
    dt = 0.1;
    radius = min_radius;
    half_height = min_height;
    nsteps = duration / dt;
    radius_delta = (max_radius - min_radius) / nsteps;
    var_5396b9a3 = (max_height - min_height) / nsteps;
    player_radius = 10;
    var_4274af2c = int(level.radiationfield_bundle.var_52a853f8 * 1000);
    while (true) {
        fwd = vecscale(vectornormalize(anglestoforward(player.angles)), 20);
        player.var_cb794a39 = player.origin;
        player.var_cb794a39 += fwd;
        radius += player_radius;
        radius2 = radius * radius;
        if (isdefined(var_5da43efa)) {
            player thread status_effect::status_effect_apply(var_5da43efa, weapon, player, 0);
            if (isdefined(level.heroplaydialog) && gettime() > var_464ef3cd) {
                buffer = 0;
                if (isdefined(level.var_86ebfbc0)) {
                    buffer = [[ level.var_86ebfbc0 ]]("playerExertBuffer", 0);
                }
                player [[ level.heroplaydialog ]]("exertRadiationSelfLoop", 30, buffer);
                var_464ef3cd = gettime() + 1000;
            }
        }
        var_7894d945 = 0;
        var_2a15d9cd = 0;
        if (!isdefined(player.var_28653462) || gettime() - player.var_28653462 >= var_4274af2c) {
            var_2a15d9cd = 1;
        }
        players = level.aliveplayers[enemyteam];
        var_9abc8b5d = getactorteamarray(enemyteam);
        var_dd82b67 = arraycombine(players, var_9abc8b5d, 0, 0);
        var_a6c5a84d = 0;
        foreach (var_802d8574 in var_dd82b67) {
            if (!isdefined(var_802d8574)) {
                continue;
            }
            dist = distance2d(player.var_cb794a39, var_802d8574.origin);
            var_cf9a323a = dist < radius && var_802d8574.origin[2] < player.var_cb794a39[2] + half_height && var_802d8574.origin[2] > player.var_cb794a39[2] - half_height;
            if (var_cf9a323a) {
                if (!isdefined(var_802d8574.var_bf8a060a)) {
                    var_802d8574.var_bf8a060a = player;
                    if (!isdefined(player.var_4d695a8a)) {
                        player.var_4d695a8a = [];
                    }
                    array::add(player.var_4d695a8a, var_802d8574);
                    player playlocalsound(#"hash_6808d51f3971786e");
                    if (isplayer(var_802d8574)) {
                        var_802d8574 playlocalsound(#"hash_7890710107740214");
                    }
                }
                if (!var_a6c5a84d && var_802d8574 status_effect::function_508e1a13(7) > 0) {
                    player damagefeedback::update(undefined, undefined, "resistance");
                    var_5de7c536 = 1;
                }
                if (isdefined(var_2a15d9cd) && var_2a15d9cd) {
                    var_7894d945++;
                }
                var_802d8574.var_355829db = player;
                dot_scaler = 1;
                if (dist < level.radiationfield_bundle.var_4fa0f37a) {
                    t = 1 - dist / level.radiationfield_bundle.var_4fa0f37a;
                    dot_scaler = 1 - t + level.radiationfield_bundle.var_b0460e3d * t;
                }
                var_33d8b746 = var_bd87ca87.dotdamage;
                var_f6edaf2a = var_bd87ca87.var_3d16b1d9;
                var_bd87ca87.dotdamage = int(var_bd87ca87.dotdamage * dot_scaler);
                var_bd87ca87.var_3d16b1d9 = int(var_bd87ca87.var_3d16b1d9 * dot_scaler);
                var_802d8574 thread status_effect::status_effect_apply(var_bd87ca87, weapon, player, 0);
                var_bd87ca87.dotdamage = var_33d8b746;
                var_bd87ca87.var_3d16b1d9 = var_f6edaf2a;
                continue;
            }
            var_802d8574 status_effect::function_280d8ac0(var_bd87ca87.setype, var_bd87ca87.var_d20b8ed2);
            var_802d8574.var_14d89bd = 0;
        }
        vehicles = getentarraybytype(12);
        for (i = 0; i < vehicles.size; i++) {
            veh = vehicles[i];
            if (veh.team != player.team) {
                if (veh.archetype === "mini_ai_quadtank" || veh.archetype === "rcbomb") {
                    dist = distance2d(player.var_cb794a39, veh.origin);
                    var_cf9a323a = dist < radius && veh.origin[2] < player.var_cb794a39[2] + half_height && veh.origin[2] > player.var_cb794a39[2] - half_height;
                    if (isdefined(var_cf9a323a) && var_cf9a323a) {
                        if (veh.archetype === "rcbomb") {
                            health = level.killstreakbundle[#"recon_car"].kshealth;
                            lifetime = level.killstreakbundle[#"recon_car"].var_5334c3c9;
                        } else {
                            health = level.killstreakbundle[#"tank_robot"].kshealth;
                            lifetime = level.killstreakbundle[#"tank_robot"].var_5334c3c9;
                        }
                        var_2d170316 = health / lifetime;
                        var_2d170316 *= dt;
                        veh dodamage(var_2d170316, veh.origin, player, player, "none", "MOD_BURNED");
                    }
                }
            }
        }
        if (isdefined(var_2a15d9cd) && var_2a15d9cd) {
            if (var_7894d945 > 0) {
                player.var_28653462 = gettime();
                scoreevents::processscoreevent(#"radiation_field_radiating_enemy", player, undefined, weapon, var_7894d945);
            }
        }
        if (isdefined(level.playgadgetsuccess) && isdefined(player.radiationdamage)) {
            if (isdefined(level.var_86ebfbc0)) {
                var_848752a7 = [[ level.var_86ebfbc0 ]]("RadiationFieldSuccessLineCount", 0) * 25;
            }
            if (player.radiationdamage > (isdefined(var_848752a7) ? var_848752a7 : 0) && !(isdefined(player.var_10e5a554) && player.var_10e5a554)) {
                player.var_10e5a554 = 1;
                player [[ level.playgadgetsuccess ]](weapon, undefined, undefined, undefined);
            }
        }
        wait dt;
        radius += radius_delta;
        half_height += var_5396b9a3;
        if (radius > max_radius) {
            radius = max_radius;
        }
        if (half_height > max_height) {
            height = max_height;
        }
    }
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 1, eflags: 0x0
// Checksum 0xd64dc2a, Offset: 0x1e80
// Size: 0x2a4
function function_7ba77f33(weapon) {
    player = self;
    player endon(#"radiation_shutdown");
    player.var_28653462 = undefined;
    damage_state(1, weapon, level.radiationfield_bundle.var_9f4ba7b4, level.radiationfield_bundle.var_1c6065aa, level.radiationfield_bundle.var_15f80e41, level.radiationfield_bundle.var_c3209f7f, level.radiationfield_bundle.baseduration, level.radiationfield_bundle.var_1b022f0a, level.radiationfield_bundle.var_c331a6b0);
    damage_state(2, weapon, level.radiationfield_bundle.var_1c6065aa, level.radiationfield_bundle.var_103d9ddb, level.radiationfield_bundle.var_c3209f7f, level.radiationfield_bundle.midheight, level.radiationfield_bundle.var_1207426d, level.radiationfield_bundle.var_1b022f0a, level.radiationfield_bundle.var_c331a6b0);
    player playlocalsound(#"hash_352529c7ca9f6143");
    player hide_player();
    player.var_1dee8972 clientfield::set("self_destruct_start", 1);
    player function_3813fd32(1);
    player function_6db11d86("RAISEWEAPON", weapon, 0, 0, 1, 0);
    damage_state(3, weapon, level.radiationfield_bundle.var_103d9ddb, level.radiationfield_bundle.var_fc6c2739, level.radiationfield_bundle.midheight, level.radiationfield_bundle.var_55292856, level.radiationfield_bundle.finalduration, level.radiationfield_bundle.var_c35a1eed, level.radiationfield_bundle.var_30a42b61, level.radiationfield_bundle.var_c580ecd9);
    player function_ab04c23b();
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 1, eflags: 0x0
// Checksum 0x1c1a7bfb, Offset: 0x2130
// Size: 0xa2
function function_a7962f7d(var_faefacc9) {
    player = self;
    player setclientthirdperson(0);
    player function_7c335f14(0);
    player enableweaponcycling();
    player setstance("stand");
    if (isdefined(var_faefacc9) && var_faefacc9) {
        player.var_a541ee78 = 0;
    }
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 0, eflags: 0x0
// Checksum 0x9581fd51, Offset: 0x21e0
// Size: 0x17c
function function_cec8eeab() {
    player = self;
    player endon(#"death", #"disconnect", #"radiation_shutdown");
    wait isdefined(player.gadget_weapon.var_1cc17dee / 1000) ? player.gadget_weapon.var_1cc17dee / 1000 : 0.5;
    if (player function_e77afe2f(player.gadget_weapon.var_1ccf6f54)) {
        waspressed = player fragbuttonpressed();
        for (var_aff039b1 = waspressed; (!var_aff039b1 || waspressed) && player function_468fbb51(); var_aff039b1 = player fragbuttonpressed()) {
            waitframe(1);
            waspressed = var_aff039b1;
        }
    } else {
        while (player fragbuttonpressed()) {
            waitframe(1);
        }
    }
    player shutdown(1);
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 1, eflags: 0x0
// Checksum 0xc9df447e, Offset: 0x2368
// Size: 0x54
function waitanddelete(time) {
    self ghost();
    self endon(#"death");
    wait time;
    self delete();
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 1, eflags: 0x0
// Checksum 0x188c6517, Offset: 0x23c8
// Size: 0x3aa
function shutdown(var_faefacc9) {
    profilestart();
    player = self;
    player notify(#"hash_4aaf6d6479e7cf20");
    if (isdefined(player) && player function_7209ea4e()) {
        player deactivate_gadget();
    }
    player clientfield::set_player_uimodel("hudItems.abilityHintIndex", 0);
    player.radiationdamage = 0;
    player.var_10e5a554 = 0;
    if (isdefined(player.var_1dee8972)) {
        player.var_1dee8972 clientfield::set("cf_overclock_fx", 0);
        player.var_1dee8972 thread waitanddelete(1);
        player.var_1dee8972 = undefined;
    }
    player function_a7962f7d(var_faefacc9);
    player.gadget_slot = undefined;
    player.gadget_weapon = undefined;
    if (isdefined(var_faefacc9) && var_faefacc9) {
        player function_e4a6ba37();
    }
    if (isdefined(player.var_4d695a8a)) {
        foreach (var_802d8574 in player.var_4d695a8a) {
            if (isdefined(var_802d8574)) {
                var_802d8574.var_bf8a060a = undefined;
                params = getstatuseffect(level.radiationfield_bundle.var_1b022f0a);
                var_802d8574 status_effect::function_280d8ac0(params.setype, params.var_d20b8ed2);
            }
        }
    }
    if (isdefined(player.var_53b1c4dd)) {
        objective_delete(player.var_53b1c4dd);
        gameobjects::release_obj_id(player.var_53b1c4dd);
        player.var_53b1c4dd = undefined;
    }
    player.var_4d695a8a = undefined;
    var_69188cee = getstatuseffect(level.radiationfield_bundle.var_c580ecd9);
    player status_effect::function_280d8ac0(var_69188cee.setype, var_69188cee.var_d20b8ed2);
    if (isdefined(var_faefacc9) && var_faefacc9 && isdefined(level.heroplaydialog)) {
        buffer = 0;
        if (isdefined(level.var_86ebfbc0)) {
            buffer = [[ level.var_86ebfbc0 ]]("playerExertBuffer", 0);
        }
        player thread [[ level.heroplaydialog ]]("exertRadiationSelfEnd", 30, buffer);
    }
    player function_ab04c23b();
    player thread function_71cd592b();
    player notify(#"radiation_shutdown");
    profilestop();
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 0, eflags: 0x0
// Checksum 0xe3de6213, Offset: 0x2780
// Size: 0x54
function function_71cd592b() {
    self endon(#"disconnect");
    level endon(#"game_ended");
    wait 5;
    self globallogic_score::function_8fe8d71e(#"hash_871db7c54ac4c8");
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 0, eflags: 0x0
// Checksum 0x941e13bf, Offset: 0x27e0
// Size: 0x22
function hide_player() {
    player = self;
    player.var_ef36361c = 1;
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 0, eflags: 0x0
// Checksum 0xbdfbfd61, Offset: 0x2810
// Size: 0x4e
function function_e4a6ba37() {
    player = self;
    player allowprone(1);
    player allowstand(1);
    player.var_ef36361c = undefined;
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 2, eflags: 0x0
// Checksum 0x726dc9aa, Offset: 0x2868
// Size: 0x14c
function gadget_on(slot, weapon) {
    player = self;
    if (isdefined(player.var_a541ee78) && player.var_a541ee78) {
        return;
    }
    if (isdefined(player.var_db63b8ae) && player.var_db63b8ae) {
        return;
    }
    player.gadget_slot = slot;
    player.gadget_weapon = weapon;
    player gadgetpowerset(slot, 0);
    if (isdefined(level.var_b8682531)) {
        player [[ level.var_b8682531 ]](weapon);
    }
    player setclientuivisibilityflag("weapon_hud_visible", 0);
    player function_b3e716d1(weapon);
    if (isdefined(player.health) && player.health > 0) {
        player clientfield::set_player_uimodel("hudItems.abilityHintIndex", 2);
    }
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 2, eflags: 0x0
// Checksum 0x8078d79f, Offset: 0x29c0
// Size: 0x3c
function gadget_off(slot, weapon) {
    player = self;
    player shutdown(1);
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 0, eflags: 0x0
// Checksum 0xff074448, Offset: 0x2a08
// Size: 0xc
function function_7209ea4e() {
    return isdefined(self.gadget_slot);
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 0, eflags: 0x0
// Checksum 0xac2a1f0d, Offset: 0x2a20
// Size: 0x3a
function get_power() {
    if (self function_7209ea4e()) {
        return 0;
    }
    return self gadgetpowerget(self.gadget_slot);
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 0, eflags: 0x0
// Checksum 0x50459cab, Offset: 0x2a68
// Size: 0x4c
function deactivate_gadget() {
    self setclientuivisibilityflag("weapon_hud_visible", 1);
    self gadgetdeactivate(self.gadget_slot, self.gadget_weapon);
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 0, eflags: 0x0
// Checksum 0xe05febc8, Offset: 0x2ac0
// Size: 0x24
function power_off() {
    self gadgetpowerset(self.gadget_slot, 0);
}

// Namespace gadget_radiation_field/gadget_radiation_field
// Params 0, eflags: 0x0
// Checksum 0xdd828b65, Offset: 0x2af0
// Size: 0x3c
function power_on() {
    if (self function_7209ea4e()) {
        self gadgetpowerset(self.gadget_slot, 100);
    }
}

