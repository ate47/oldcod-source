#using script_1940fc077a028a81;
#using script_2c5daa95f8fec03c;
#using script_3357acf79ce92f4b;
#using script_3411bb48d41bd3b;
#using script_3751b21462a54a7d;
#using script_3819e7a1427df6d2;
#using script_3a88f428c6d8ef90;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\destructible_character;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\globallogic\globallogic_vehicle;
#using scripts\core_common\math_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_behavior;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_weapons;

#namespace namespace_98decc78;

// Namespace namespace_98decc78/namespace_98decc78
// Params 0, eflags: 0x6
// Checksum 0x4fdac60c, Offset: 0x468
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"hash_5cb28995c23c44a", &function_70a657d8, &main, undefined, undefined);
}

// Namespace namespace_98decc78/namespace_98decc78
// Params 0, eflags: 0x5 linked
// Checksum 0xeb347d1d, Offset: 0x4c0
// Size: 0x35c
function private function_70a657d8() {
    gametype = util::get_game_type();
    if (gametype == #"zsurvival") {
        level.var_9ee73630 = [];
        level.var_9ee73630[#"walk"] = [];
        level.var_9ee73630[#"run"] = [];
        level.var_9ee73630[#"sprint"] = [];
        level.var_9ee73630[#"super_sprint"] = [];
        level.var_9ee73630[#"walk"][#"down"] = 14;
        level.var_9ee73630[#"walk"][#"up"] = 16;
        level.var_9ee73630[#"run"][#"down"] = 13;
        level.var_9ee73630[#"run"][#"up"] = 12;
        level.var_9ee73630[#"sprint"][#"down"] = 9;
        level.var_9ee73630[#"sprint"][#"up"] = 8;
        level.var_9ee73630[#"super_sprint"][#"down"] = 1;
        level.var_9ee73630[#"super_sprint"][#"up"] = 1;
        level.var_9ee73630[#"super_super_sprint"][#"down"] = 8;
        level.var_9ee73630[#"super_super_sprint"][#"up"] = 8;
        spawner::add_archetype_spawn_function(#"zombie", &function_42151b1b);
        spawner::add_archetype_spawn_function(#"zombie", &function_1bc8ecf1);
        spawner::function_89a2cd87(#"zombie", &function_95d1bec9);
    }
    clientfield::register("toplayer", "" + #"hash_3a86c740229275b7", 1, 3, "counter");
    initzombiebehaviors();
}

// Namespace namespace_98decc78/namespace_98decc78
// Params 0, eflags: 0x5 linked
// Checksum 0x5acbfddb, Offset: 0x828
// Size: 0x210
function private main() {
    level.custom_melee_fire = &namespace_85745671::custom_melee_fire;
    if (isdefined(getgametypesetting(#"hash_4ac1f31d592e3f3d")) ? getgametypesetting(#"hash_4ac1f31d592e3f3d") : 0) {
        callback::add_callback(#"hash_70eeb7d813f149b2", &namespace_85745671::function_cf065988);
        callback::add_callback(#"hash_15858698313c5f32", &namespace_85745671::function_b0503d98);
        callback::add_callback(#"hash_6d9bdacc6c29cfa5", &namespace_85745671::function_68cc8bce);
        callback::add_callback(#"on_turret_destroyed", &namespace_85745671::on_turret_destroyed);
        turretweapon = getweapon(#"gun_ultimate_turret");
        if (isdefined(turretweapon)) {
            turretweapon = turretweapon.rootweapon;
        }
        if (isdefined(turretweapon) && !isinarray(level.var_7fc48a1a, turretweapon)) {
            level.var_7fc48a1a[level.var_7fc48a1a.size] = turretweapon;
        }
        if (isdefined(level.smartcoversettings) && !isinarray(level.var_7fc48a1a, level.smartcoversettings.var_8d86ade8)) {
            level.var_7fc48a1a[level.var_7fc48a1a.size] = level.smartcoversettings.var_8d86ade8;
        }
    }
}

// Namespace namespace_98decc78/namespace_98decc78
// Params 0, eflags: 0x1 linked
// Checksum 0xe17a3972, Offset: 0xa40
// Size: 0xbc
function initzombiebehaviors() {
    assert(isscriptfunctionptr(&function_197fdaee));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2e71bc334e0009ba", &function_197fdaee);
    animationstatenetwork::registernotetrackhandlerfunction("show_projectile", &function_a7d522bd);
    animationstatenetwork::registernotetrackhandlerfunction("fire_projectile", &function_f45f4725);
}

// Namespace namespace_98decc78/namespace_98decc78
// Params 0, eflags: 0x5 linked
// Checksum 0xa4241037, Offset: 0xb08
// Size: 0x274
function private function_42151b1b() {
    self.ai.var_870d0893 = 1;
    self callback::function_d8abfc3d(#"on_ai_damage", &zombie_gib_on_damage);
    self callback::function_d8abfc3d(#"on_ai_melee", &namespace_85745671::function_b8eb5dea);
    self callback::function_d8abfc3d(#"hash_3bb51ce51020d0eb", &namespace_85745671::function_16e2f075);
    self callback::function_d8abfc3d(#"on_ai_killed", &function_bf21203e);
    aiutility::addaioverridedamagecallback(self, &function_853cd0f0);
    self.ai.var_a5dabb8b = 1;
    self.var_65e57a10 = 1;
    self.ignorepathenemyfightdist = 1;
    self.var_1c0eb62a = 180;
    self.var_737e8510 = 128;
    self.var_b8c61fc5 = 1;
    self.cant_move_cb = &function_9c573bc6;
    self.var_20e07206 = 1;
    self.var_16dd87ad = 0.1;
    self.var_90d0c0ff = "anim_spawn_from_ground";
    self.var_ecbef856 = "anim_zombie_dig_down_stand";
    self.clamptonavmesh = 1;
    self.var_958e7ee4 = 10;
    self.var_eb3258b = 15;
    self.completed_emerging_into_playable_area = 1;
    self.zombie_think_done = 1;
    self setavoidancemask("avoid actor");
    self namespace_85745671::function_9758722("walk");
    self thread namespace_85745671::function_6c308e81();
    self callback::function_d8abfc3d(#"hash_10ab46b52df7967a", &namespace_85745671::function_5cb3181e);
    self thread zombie_utility::hide_pop();
}

// Namespace namespace_98decc78/namespace_98decc78
// Params 0, eflags: 0x1 linked
// Checksum 0x1ce9e371, Offset: 0xd88
// Size: 0x5a
function function_1bc8ecf1() {
    self.var_b3c613a7 = [1, 1, 1, 1, 1];
    self.var_414bc881 = 1;
}

// Namespace namespace_98decc78/namespace_98decc78
// Params 0, eflags: 0x5 linked
// Checksum 0xe1c463e, Offset: 0xdf0
// Size: 0x4c
function private function_95d1bec9() {
    setup_awareness(self);
    function_cea9ab47(self);
    self thread awareness::function_fa6e010d();
}

// Namespace namespace_98decc78/namespace_98decc78
// Params 1, eflags: 0x5 linked
// Checksum 0xc64ff191, Offset: 0xe48
// Size: 0x68
function private function_bf21203e(params) {
    if (params.smeansofdeath === "MOD_CRUSH") {
        self globallogic_vehicle::function_621234f9(params.eattacker, params.einflictor);
    }
    if (!isplayer(params.eattacker)) {
        return;
    }
}

// Namespace namespace_98decc78/namespace_98decc78
// Params 13, eflags: 0x5 linked
// Checksum 0xceb0ee25, Offset: 0xeb8
// Size: 0x5a8
function private function_853cd0f0(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, *vpoint, *vdir, shitloc, psoffsettime, *damagefromunderneath, *modelindex, *partname) {
    self.var_67f98db0 = 0;
    if (isactor(vpoint) && vpoint.team == self.team) {
        return 0;
    }
    if (isdefined(damagefromunderneath) && psoffsettime !== "MOD_DOT") {
        dot_params = function_f74d2943(damagefromunderneath, 7);
        if (isdefined(dot_params)) {
            status_effect::status_effect_apply(dot_params, damagefromunderneath, weapon);
        }
    }
    var_3b037158 = isdefined(damagefromunderneath) && isarray(level.var_7fc48a1a) && isinarray(level.var_7fc48a1a, damagefromunderneath);
    if (var_3b037158 && isdefined(weapon)) {
        if (!isdefined(self.attackable) && isdefined(weapon.var_b79a8ac7)) {
            if (weapon namespace_85745671::get_attackable_slot(self)) {
                self.attackable = weapon;
            }
        }
        if (isdefined(weapon.var_d83d7db3)) {
            if (isdefined(self.var_1b3acc36) && gettime() < self.var_1b3acc36) {
                return 0;
            } else {
                self.var_1b3acc36 = gettime() + weapon.var_d83d7db3;
            }
        }
        vdir = isdefined(weapon.var_ba721a2c) ? weapon.var_ba721a2c : vdir;
    }
    if (!isdefined(self.enemy_override) && !isdefined(self.favoriteenemy) && isdefined(vpoint) && isplayer(vpoint)) {
        if (isdefined(psoffsettime) && (psoffsettime == "MOD_MELEE" || psoffsettime == "MOD_MELEE_WEAPON_BUTT") || isdefined(damagefromunderneath) && damagefromunderneath.statname === #"hatchet") {
            n_radius = 128;
        } else {
            n_radius = 512;
        }
        awareness::function_e732359c(1, self.origin, n_radius, self, {#position:vpoint.origin});
    }
    if (weapon.classname === "script_vehicle" && psoffsettime == "MOD_CRUSH" && isdefined(self.var_5ace757d)) {
        foreach (bundle in self.var_5ace757d) {
            foreach (hitloc in bundle.var_3d2f9bf0) {
                modelindex = hitloc;
                function_29c1ba76(weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname);
            }
        }
    }
    vdir = function_29c1ba76(weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname);
    /#
        if (is_true(level.var_85a39c96)) {
            vdir = self.health + 1;
        }
    #/
    if (vdir > 0) {
        var_ebcff177 = 1;
        weakpoint = namespace_81245006::function_3131f5dd(self, modelindex, 1);
        if (weakpoint.var_3765e777 === 1) {
            var_ebcff177 = 2;
        }
        if (self.var_67f98db0 === 1) {
            var_ebcff177 = 3;
        }
        callback::callback(#"hash_3886c79a26cace38", {#eattacker:vpoint, #var_dcc8dd60:self getentitynumber(), #idamage:vdir, #type:var_ebcff177});
    }
    return vdir;
}

// Namespace namespace_98decc78/namespace_98decc78
// Params 8, eflags: 0x1 linked
// Checksum 0xfd591956, Offset: 0x1468
// Size: 0x460
function function_29c1ba76(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, shitloc, psoffsettime) {
    self.var_426947c4 = undefined;
    var_e9809e9a = 0;
    if (isplayer(eattacker)) {
        if (eattacker namespace_791d0451::function_56cedda7(#"hash_1f95b38e4a49dd97") || eattacker namespace_791d0451::function_56cedda7(#"hash_1f95b28e4a49dbe4") || eattacker namespace_791d0451::function_56cedda7(#"hash_1f95b18e4a49da31") || eattacker namespace_791d0451::function_56cedda7(#"hash_1f95b08e4a49d87e")) {
            var_e9809e9a = 1;
        }
    }
    weakpoint = namespace_81245006::function_3131f5dd(self, shitloc, 1);
    if (isdefined(weakpoint) && weakpoint.type === #"armor") {
        namespace_81245006::function_ef87b7e8(weakpoint, idamage);
        if (namespace_81245006::function_f29756fe(weakpoint) === 3 && isdefined(weakpoint.var_f371ebb0)) {
            destructserverutils::function_8475c53a(self, weakpoint.var_f371ebb0);
            level scoreevents::doscoreeventcallback("scoreEventZM", {#attacker:eattacker, #scoreevent:"destroyed_armor_zm"});
            self.var_426947c4 = 1;
            if (weakpoint.var_f371ebb0 === "body_armor") {
                callback::callback(#"hash_7d67d0e9046494fb");
            }
        }
        eattacker damagefeedback::update(smeansofdeath, einflictor, "armor", weapon, self, psoffsettime, shitloc, 0, idflags | 2048, 0);
        w_base = zm_weapons::get_base_weapon(weapon);
        var_36d55c9c = 1;
        if (level.zombie_weapons[w_base].weapon_classname === "lmg") {
            n_tier = eattacker namespace_b61a349a::function_998f8321(weapon);
            if (n_tier >= 2) {
                var_36d55c9c = n_tier >= 4 ? 1.25 : 1.1;
            }
        }
        if (self.var_9fde8624 === #"hash_7a778318514578f7") {
            if (var_e9809e9a) {
                idamage = int(idamage * 0.375 * var_36d55c9c);
            } else {
                idamage = int(idamage * 0.25 * var_36d55c9c);
            }
        } else if (self.var_9fde8624 === #"hash_622e7c9cc7c06c7") {
            if (var_e9809e9a) {
                idamage = int(idamage * 0.75 * var_36d55c9c);
            } else {
                idamage = int(idamage * 0.5 * var_36d55c9c);
            }
        }
        self.var_67f98db0 = 1;
        var_43f0e034 = function_f4e9bba4(self);
        self function_2d4173a8(var_43f0e034);
    }
    return idamage;
}

// Namespace namespace_98decc78/namespace_98decc78
// Params 1, eflags: 0x1 linked
// Checksum 0x2edbbfd, Offset: 0x18d0
// Size: 0x12a
function function_f4e9bba4(entity) {
    max_health = 0;
    var_765c0df4 = 0;
    weakpoints = namespace_81245006::function_fab3ee3e(entity);
    if (!isdefined(weakpoints)) {
        return 0;
    }
    foreach (weakpoint in weakpoints) {
        if (weakpoint.type === #"armor") {
            max_health += weakpoint.maxhealth;
            var_765c0df4 += max(weakpoint.health, 0);
        }
    }
    if (max_health == 0) {
        return 0;
    }
    return var_765c0df4 / max_health;
}

// Namespace namespace_98decc78/namespace_98decc78
// Params 1, eflags: 0x5 linked
// Checksum 0x2a66f81f, Offset: 0x1a08
// Size: 0x54
function private zombie_gib_on_damage(params) {
    zombie_utility::zombie_gib(params.idamage, params.eattacker, params.vdir, params.vpoint, params.smeansofdeath, undefined, undefined, undefined, params.weapon);
}

// Namespace namespace_98decc78/namespace_98decc78
// Params 1, eflags: 0x5 linked
// Checksum 0x8949c873, Offset: 0x1a68
// Size: 0x7c
function private function_9c573bc6(*entity) {
    self notify("62b2b8a85ae89c4d");
    self endon("31be8271eb200fb2", #"death");
    if (isdefined(self.enemy_override)) {
        return;
    }
    self collidewithactors(0);
    wait 2;
    self collidewithactors(1);
}

// Namespace namespace_98decc78/namespace_98decc78
// Params 1, eflags: 0x5 linked
// Checksum 0x6b1f6a11, Offset: 0x1af0
// Size: 0xaa
function private function_197fdaee(entity) {
    if (entity asmgetstatus() != "asm_status_complete" && isdefined(entity.var_1087b4ab) && entity isattached(entity.var_376ab36f, entity.var_1087b4ab)) {
        entity detach(entity.var_376ab36f, entity.var_1087b4ab);
        entity.var_1087b4ab = undefined;
        entity.var_376ab36f = undefined;
    }
}

// Namespace namespace_98decc78/namespace_98decc78
// Params 1, eflags: 0x5 linked
// Checksum 0x19132caf, Offset: 0x1ba8
// Size: 0x11c
function private function_a7d522bd(entity) {
    model = array::random(array("c_t9_gore_chunk_03", "c_t9_gore_chunk_03_a", "c_t9_gore_chunk_03_b", "c_t9_gore_chunk_03_c", "c_t9_gore_chunk_03_d"));
    entity.var_376ab36f = model;
    entity.var_1087b4ab = "tag_weapon_left";
    if (gibserverutils::isgibbed(self, 32)) {
        entity.var_1087b4ab = "tag_weapon_right";
    }
    if (entity isattached(entity.var_376ab36f, entity.var_1087b4ab)) {
        entity detach(entity.var_376ab36f, entity.var_1087b4ab);
    }
    entity attach(entity.var_376ab36f, entity.var_1087b4ab);
}

// Namespace namespace_98decc78/namespace_98decc78
// Params 1, eflags: 0x5 linked
// Checksum 0x145a536a, Offset: 0x1cd0
// Size: 0x26e
function private function_f45f4725(entity) {
    entity detach(entity.var_376ab36f, entity.var_1087b4ab);
    if (namespace_85745671::is_player_valid(entity.enemy)) {
        start_pos = entity gettagorigin(entity.var_1087b4ab);
        target_pos = entity.enemy gettagorigin("j_spine4");
        to_target = target_pos - start_pos;
        time = length((to_target[0], to_target[1], 0)) / 700;
        var_813d38fa = (0.5 * getdvarfloat(#"bg_lowgravity", 400) * function_a3f6cdac(time) + to_target[2]) / time;
        to_target = vectornormalize((to_target[0], to_target[1], 0));
        grenade = entity magicgrenademanual(start_pos, (to_target[0] * 700, to_target[1] * 700, var_813d38fa), 6);
        grenade.angles = entity gettagangles(entity.var_1087b4ab);
        grenade setmodel(entity.var_376ab36f);
        grenade thread function_6f78caa9();
        entity.var_735e0049 = grenade;
        entity.var_8c4d3e5d = undefined;
        entity.var_42ecd9f3 = gettime() + int(2 * 1000);
    }
    entity.var_376ab36f = undefined;
    entity.var_1087b4ab = undefined;
}

// Namespace namespace_98decc78/namespace_98decc78
// Params 0, eflags: 0x5 linked
// Checksum 0x7ebbdd3e, Offset: 0x1f48
// Size: 0x304
function private function_6f78caa9() {
    if (isdefined(self.owner)) {
        attacker = self.owner;
        start_pos = self.owner.origin;
    }
    waitresult = self waittilltimeout(5, #"projectile_impact_player", #"death");
    if (waitresult._notify == #"projectile_impact_player" && isdefined(waitresult.player)) {
        player = waitresult.player;
        player playsound(#"hash_7531b73b4b99b19d");
        player dodamage(self.weapon.var_2d276877[0], start_pos, attacker, self);
        var_622f0175 = player.origin - self.origin;
        var_f1ff3ca1 = vectornormalize((var_622f0175[0], var_622f0175[1], 0));
        player_forward = anglestoforward(player.angles);
        var_d885fce5 = vectornormalize((player_forward[0], player_forward[1], 0));
        var_60ab7d13 = anglestoright(player.angles);
        var_f39d8ba7 = vectornormalize((var_60ab7d13[0], var_60ab7d13[1], 0));
        dot = vectordot(var_f1ff3ca1, var_d885fce5);
        if (dot >= 0.5) {
            direction = 1;
        } else if (dot < 0.5 && dot > -0.5) {
            dot = vectordot(var_f1ff3ca1, var_f39d8ba7);
            if (dot > 0) {
                direction = 3;
            } else {
                direction = 4;
            }
        } else {
            direction = 2;
        }
        player clientfield::increment_to_player("" + #"hash_3a86c740229275b7", direction);
    }
    self deletedelay();
}

// Namespace namespace_98decc78/namespace_98decc78
// Params 1, eflags: 0x5 linked
// Checksum 0x1b335740, Offset: 0x2258
// Size: 0x1d2
function private setup_awareness(entity) {
    if (is_true(entity.ai.var_870d0893)) {
        entity.has_awareness = 1;
        entity.ignorelaststandplayers = 1;
        entity callback::function_d8abfc3d(#"on_ai_damage", &awareness::function_5f511313);
        awareness::register_state(entity, #"wander", &function_962ec972, &awareness::function_4ebe4a6d, &awareness::function_b264a0bc, undefined, &awareness::function_555d960b);
        awareness::register_state(entity, #"investigate", &function_18cf0569, &awareness::function_9eefc327, &function_60856c6d, undefined, &awareness::function_a360dd00);
        awareness::register_state(entity, #"chase", &function_88586098, &function_e85f22b3, &function_5b3d00f3, &awareness::function_5c40e824, &function_1ae9512e);
        awareness::set_state(entity, #"wander");
        return;
    }
    entity.has_awareness = 0;
}

// Namespace namespace_98decc78/namespace_98decc78
// Params 1, eflags: 0x1 linked
// Checksum 0x4c556560, Offset: 0x2438
// Size: 0x74
function function_962ec972(entity) {
    entity.fovcosine = 0.5;
    entity.maxsightdistsqrd = function_a3f6cdac(900);
    entity namespace_85745671::function_9758722("walk");
    entity.var_1267fdea = 0;
    awareness::function_9c9d96b5(entity);
}

// Namespace namespace_98decc78/namespace_98decc78
// Params 1, eflags: 0x1 linked
// Checksum 0xadb1dda7, Offset: 0x24b8
// Size: 0x7c
function function_18cf0569(entity) {
    self.fovcosine = 0;
    self.maxsightdistsqrd = function_a3f6cdac(1100);
    self.var_1267fdea = 0;
    entity namespace_85745671::function_9758722("run");
    awareness::function_b41f0471(entity);
}

// Namespace namespace_98decc78/namespace_98decc78
// Params 1, eflags: 0x1 linked
// Checksum 0xd7bbc418, Offset: 0x2540
// Size: 0x24
function function_60856c6d(entity) {
    awareness::function_34162a25(entity);
}

// Namespace namespace_98decc78/namespace_98decc78
// Params 1, eflags: 0x1 linked
// Checksum 0x188b86e8, Offset: 0x2570
// Size: 0x11c
function function_88586098(entity) {
    self.fovcosine = 0;
    self.maxsightdistsqrd = function_a3f6cdac(3000);
    self.var_1267fdea = 0;
    if (isdefined(self.aat_turned)) {
    } else if (isdefined(self.var_9602c8b2)) {
        [[ self.var_9602c8b2 ]]();
    } else if (isdefined(level.var_9602c8b2)) {
        [[ level.var_9602c8b2 ]]();
    } else {
        n_random = randomint(100);
        if (n_random < 33) {
            entity namespace_85745671::function_9758722("sprint");
        } else {
            entity namespace_85745671::function_9758722("super_sprint");
        }
    }
    awareness::function_978025e4(entity);
}

// Namespace namespace_98decc78/namespace_98decc78
// Params 1, eflags: 0x1 linked
// Checksum 0x3ad6e071, Offset: 0x2698
// Size: 0x1d4
function function_e85f22b3(entity) {
    if (isdefined(entity.enemy) && distancesquared(entity.enemy.origin, entity.origin) < entity.maxsightdistsqrd) {
        if (is_true(entity.var_1fa24724)) {
            if (entity isatgoal() && (!isdefined(entity.var_898c5e62) || entity.var_898c5e62 <= gettime()) && (!isdefined(entity.var_42ecd9f3) || entity.var_42ecd9f3 <= gettime())) {
                zm_behavior::function_d5fbbdf8(entity);
                entity.var_898c5e62 = gettime() + int(0.25 * 1000);
            }
            if (isarray(entity.enemy.var_f904e440) && isinarray(entity.enemy.var_f904e440, entity)) {
                return;
            }
        } else if (isarray(entity.enemy.var_f904e440)) {
            arrayremovevalue(entity.enemy.var_f904e440, entity);
        }
    }
    awareness::function_39da6c3c(entity);
}

// Namespace namespace_98decc78/namespace_98decc78
// Params 1, eflags: 0x1 linked
// Checksum 0x2a9bdb5d, Offset: 0x2878
// Size: 0x2c
function function_5b3d00f3(entity) {
    self.var_6ca50f69 = undefined;
    awareness::function_b9f81e8b(entity);
}

// Namespace namespace_98decc78/namespace_98decc78
// Params 1, eflags: 0x1 linked
// Checksum 0x8cc7c9b2, Offset: 0x28b0
// Size: 0x64
function function_1ae9512e(entity) {
    if (is_true(entity.var_1fa24724)) {
        /#
            record3dtext("<dev string:x38>", entity.origin, (1, 0.5, 0), "<dev string:x51>", entity);
        #/
    }
}

// Namespace namespace_98decc78/namespace_98decc78
// Params 1, eflags: 0x1 linked
// Checksum 0x32e09725, Offset: 0x2920
// Size: 0x1a4
function function_cea9ab47(entity) {
    namespace_81245006::initweakpoints(self);
    if (!isdefined(entity.var_9fde8624)) {
        return;
    }
    self.no_powerups = 1;
    switch (entity.var_9fde8624) {
    case #"hash_622e7c9cc7c06c7":
        entity attach("c_t9_zmb_zombie_medium_helmet");
        entity attach("c_t9_zmb_zombie_medium_armor");
        self function_2d4173a8(1);
        break;
    case #"hash_7a778318514578f7":
        entity attach("c_t9_zmb_zombie_heavy_torso_armor");
        entity attach("c_t9_zmb_zombie_heavy_arm_armor_lt");
        entity attach("c_t9_zmb_zombie_heavy_arm_armor_rt");
        entity attach("c_t9_zmb_zombie_heavy_leg_armor_lt");
        entity attach("c_t9_zmb_zombie_heavy_leg_armor_rt");
        self function_2d4173a8(1);
        break;
    }
    entity destructserverutils::togglespawngibs(entity, 1);
}

