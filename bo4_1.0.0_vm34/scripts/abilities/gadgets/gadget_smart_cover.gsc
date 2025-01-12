#using scripts\abilities\ability_player;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\damage;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\weapons\deployable;
#using scripts\weapons\weaponobjects;

#namespace smart_cover;

// Namespace smart_cover/gadget_smart_cover
// Params 0, eflags: 0x0
// Checksum 0x6e70874, Offset: 0x278
// Size: 0x494
function init_shared() {
    level.smartcoversettings = spawnstruct();
    if (sessionmodeismultiplayergame()) {
        level.smartcoversettings.bundle = getscriptbundle(#"smartcover_settings_mp");
    } else if (sessionmodeiswarzonegame()) {
        level.smartcoversettings.bundle = getscriptbundle(#"smartcover_settings_wz");
    } else if (sessionmodeiscampaigngame()) {
        level.smartcoversettings.bundle = getscriptbundle(#"smartcover_settings_cp");
    }
    level.smartcoversettings.var_54dfedd9 = "smart_cover_objective_full";
    level.smartcoversettings.var_bdc049de = "smart_cover_objective_open";
    level.smartcoversettings.smartcoverweapon = getweapon("ability_smart_cover");
    level.smartcoversettings.var_4bc676c7 = getweapon(#"hash_34575452eba07c65");
    setupdvars();
    ability_player::register_gadget_should_notify(27, 1);
    weaponobjects::function_f298eae6(#"ability_smart_cover", &function_94d9086f, 1);
    callback::on_spawned(&on_player_spawned);
    level.smartcoversettings.var_d8404722 = [];
    deployable::register_deployable(level.smartcoversettings.smartcoverweapon, undefined, &function_ace879c6, undefined, undefined, 1);
    level.smartcoversettings.var_bee3c05a = 10000;
    level.smartcoversettings.var_4a83e2d2 = level.smartcoversettings.bundle.var_8dd8c6b1 * level.smartcoversettings.bundle.var_8dd8c6b1;
    globallogic_score::register_kill_callback(level.smartcoversettings.smartcoverweapon, &function_20ab07ea);
    globallogic_score::function_55e3f7c(level.smartcoversettings.smartcoverweapon, &function_20ab07ea);
    clientfield::register("clientuimodel", "hudItems.smartCoverState", 1, 1, "int");
    clientfield::register("scriptmover", "smartcover_placed", 1, 5, "float");
    clientfield::register("scriptmover", "start_smartcover_microwave", 1, 1, "int");
    callback::on_end_game(&on_end_game);
    setdvar(#"hash_4d17057924212aa9", 20);
    setdvar(#"hash_686a676b28ae0af4", 0);
    setdvar(#"hash_7f893c50ae5356c8", -15);
    setdvar(#"hash_70ce44b2b0b4005", 30);
    setdvar(#"hash_477cc29b988c0b75", -10);
    setdvar(#"hash_41cfd0e34c53ef02", 30);
}

// Namespace smart_cover/gadget_smart_cover
// Params 0, eflags: 0x0
// Checksum 0x280002e2, Offset: 0x718
// Size: 0x1c0
function on_end_game() {
    if (!isdefined(level.smartcoversettings) || !isdefined(level.smartcoversettings.smartcoverweapon)) {
        return;
    }
    foreach (player in level.players) {
        var_15f00635 = player gadgetgetslot(level.smartcoversettings.smartcoverweapon);
        player gadgetdeactivate(var_15f00635, level.smartcoversettings.smartcoverweapon);
        player function_68b8ba6e(var_15f00635, level.smartcoversettings.smartcoverweapon);
    }
    if (!isdefined(level.smartcoversettings.var_d8404722)) {
        return;
    }
    foreach (smartcover in level.smartcoversettings.var_d8404722) {
        if (!isdefined(smartcover)) {
            continue;
        }
        smartcover function_49b67b21(1);
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 0, eflags: 0x0
// Checksum 0xe54989a3, Offset: 0x8e0
// Size: 0x174
function setupdvars() {
    setdvar(#"hash_4f4ce3cb18b004bc", 8);
    setdvar(#"hash_417afa70d515fba5", isdefined(level.smartcoversettings.bundle.var_8dd8c6b1) ? level.smartcoversettings.bundle.var_8dd8c6b1 : 0);
    setdvar(#"hash_1d8eb304f5cf8033", 1);
    setdvar(#"hash_71f8bd4cd30de4b3", isdefined(level.smartcoversettings.bundle.var_6a71dfe) ? level.smartcoversettings.bundle.var_6a71dfe : 0);
    setdvar(#"hash_39a564d4801c4b2e", isdefined(level.smartcoversettings.bundle.var_caed4c6d) ? level.smartcoversettings.bundle.var_caed4c6d : 0);
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0x8a3bbc15, Offset: 0xa60
// Size: 0x1a
function function_a2d000d3(func) {
    level.onsmartcoverplaced = func;
}

// Namespace smart_cover/gadget_smart_cover
// Params 0, eflags: 0x0
// Checksum 0x46e5b97a, Offset: 0xa88
// Size: 0x174
function function_f470146c() {
    self endon(#"death");
    if ((isdefined(level.smartcoversettings.bundle.timeout) ? level.smartcoversettings.bundle.timeout : 0) == 0) {
        return;
    }
    wait level.smartcoversettings.bundle.timeout - (isdefined(level.smartcoversettings.bundle.var_b6958e61) ? level.smartcoversettings.bundle.var_b6958e61 : 0);
    if (!isdefined(self)) {
        return;
    } else if (isdefined(level.smartcoversettings.bundle.var_ea1cfbe9)) {
        self playsound(level.smartcoversettings.bundle.var_ea1cfbe9);
    }
    wait isdefined(level.smartcoversettings.bundle.var_b6958e61) ? level.smartcoversettings.bundle.var_b6958e61 : 0;
    if (isdefined(self)) {
        self thread function_49b67b21(1);
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 0, eflags: 0x0
// Checksum 0x60ee0e18, Offset: 0xc08
// Size: 0xa0
function function_f5935828() {
    if (!isdefined(self.smartcover)) {
        return;
    }
    foreach (smartcover in self.smartcover.var_f45e90eb) {
        if (isdefined(smartcover)) {
            smartcover function_49b67b21(1);
        }
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 2, eflags: 0x0
// Checksum 0x63583f93, Offset: 0xcb0
// Size: 0x374
function function_a411efa6(player, smartcover) {
    level endon(#"game_ended");
    player notify(#"hash_53db5f084a244a94");
    player endon(#"hash_53db5f084a244a94");
    player endon(#"death", #"disconnect", #"joined_team", #"changed_specialist");
    smartcover endon(#"death");
    var_44edf260 = gettime() + int((isdefined(level.smartcoversettings.bundle.var_1461532a) ? level.smartcoversettings.bundle.var_1461532a : 0) * 1000);
    player.var_e3b6cf63 = 1;
    currenttime = gettime();
    timeelapsed = 0;
    while (var_44edf260 > gettime()) {
        if (!player gamepadusedlast()) {
            break;
        }
        if (!player offhandspecialbuttonpressed()) {
            player clientfield::set_player_uimodel("huditems.abilityDelayProgress", 0);
            player.var_e3b6cf63 = 0;
            return;
        }
        timeelapsed = gettime() - currenttime;
        var_1f806d74 = timeelapsed / int((isdefined(level.smartcoversettings.bundle.var_1461532a) ? level.smartcoversettings.bundle.var_1461532a : 0) * 1000);
        player clientfield::set_player_uimodel("huditems.abilityDelayProgress", var_1f806d74);
        waitframe(1);
    }
    player giveandfireoffhand(level.smartcoversettings.var_4bc676c7);
    if (isdefined(level.smartcoversettings.bundle.var_ea1cfbe9)) {
        smartcover playsound(level.smartcoversettings.bundle.var_ea1cfbe9);
    }
    player clientfield::set_player_uimodel("huditems.abilityHoldToActivate", 0);
    player clientfield::set_player_uimodel("huditems.abilityDelayProgress", 0);
    wait isdefined(level.smartcoversettings.bundle.detonationtime) ? level.smartcoversettings.bundle.detonationtime : 0;
    player.var_e3b6cf63 = 0;
    player.var_6f5497a9 = 1;
    smartcover function_49b67b21(1);
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0xf3123b99, Offset: 0x1030
// Size: 0x426
function function_648d802a(player) {
    level endon(#"game_ended");
    player notify(#"hash_51faf1a32d7e36b0");
    player endon(#"hash_51faf1a32d7e36b0");
    player endon(#"death", #"disconnect", #"joined_team", #"changed_specialist");
    while (true) {
        waitframe(1);
        while (level.inprematchperiod) {
            waitframe(1);
            continue;
        }
        if (!player hasweapon(level.smartcoversettings.smartcoverweapon)) {
            return;
        }
        var_15f00635 = player gadgetgetslot(level.smartcoversettings.smartcoverweapon);
        if (!isdefined(var_15f00635) || var_15f00635 == -1) {
            continue;
        }
        ammocount = player getammocount(level.smartcoversettings.smartcoverweapon);
        gadgetpower = player gadgetpowerget(var_15f00635);
        if (gadgetpower >= 100 || ammocount > 0) {
            player clientfield::set_player_uimodel("huditems.abilityHoldToActivate", 0);
            player clientfield::set_player_uimodel("hudItems.smartCoverState", 0);
            continue;
        }
        if (player.smartcover.var_dbb9c2c2.size == 0) {
            continue;
        }
        if (isdefined(level.smartcoversettings.bundle.var_caaf388d) ? level.smartcoversettings.bundle.var_caaf388d : 0) {
            player clientfield::set_player_uimodel("huditems.abilityHoldToActivate", 2);
            player clientfield::set_player_uimodel("hudItems.smartCoverState", 1);
            if ((isdefined(level.smartcoversettings.bundle.var_caaf388d) ? level.smartcoversettings.bundle.var_caaf388d : 0) && player offhandspecialbuttonpressed() && (!isdefined(player.var_e3b6cf63) || !player.var_e3b6cf63) && !(isdefined(player.var_6f5497a9) ? player.var_6f5497a9 : 0)) {
                foreach (smartcover in player.smartcover.var_f45e90eb) {
                    if (!isdefined(smartcover)) {
                        continue;
                    }
                    smartcover thread function_a411efa6(player, smartcover);
                    break;
                }
                continue;
            }
            if (!player offhandspecialbuttonpressed() && (isdefined(player.var_6f5497a9) ? player.var_6f5497a9 : 0)) {
                player.var_6f5497a9 = 0;
            }
        }
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 0, eflags: 0x0
// Checksum 0x46097381, Offset: 0x1460
// Size: 0xf4
function on_player_spawned() {
    if (!isdefined(self.smartcover)) {
        self.smartcover = spawnstruct();
        self.smartcover.var_f45e90eb = [];
        self.smartcover.var_dbb9c2c2 = [];
        self.smartcover.var_910f17bf = [];
    }
    if (!self hasweapon(level.smartcoversettings.smartcoverweapon) && self.smartcover.var_f45e90eb.size > 0) {
        self function_f5935828();
    }
    self clientfield::set_player_uimodel("huditems.abilityDelayProgress", 0);
    self.var_e3b6cf63 = 0;
    self reset_being_microwaved();
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0x5c5a0482, Offset: 0x1560
// Size: 0x1e0
function function_ace879c6(player) {
    var_83c20ba7 = player function_92f39379(level.smartcoversettings.bundle.var_bbde0b27, level.smartcoversettings.bundle.maxwidth, 1, 1);
    player.smartcover.lastvalid = var_83c20ba7;
    var_eead19cf = 0;
    if (isdefined(var_83c20ba7) && isdefined(var_83c20ba7.origin)) {
        var_eead19cf = function_fee79db3(var_83c20ba7.origin, level.smartcoversettings.var_4a83e2d2);
    }
    var_dd3a1baa = function_faeab28a(var_83c20ba7.origin);
    candeploy = isdefined(var_83c20ba7) && var_83c20ba7.isvalid && !var_eead19cf && !var_dd3a1baa;
    if (candeploy && (isdefined(var_83c20ba7.width) ? var_83c20ba7.width : 0) >= level.smartcoversettings.bundle.maxwidth) {
        player function_d83e9f0e(candeploy, var_83c20ba7.origin, var_83c20ba7.angles);
    } else {
        player function_d83e9f0e(candeploy, (0, 0, 0), (0, 0, 0));
    }
    return var_83c20ba7;
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0xfe2bf49d, Offset: 0x1748
// Size: 0xe8
function function_8e180cc(var_9c755030) {
    var_9c755030 endon(#"death");
    var_9c755030 useanimtree("generic");
    var_9c755030 setanim(level.smartcoversettings.bundle.deployanim);
    animtime = 0;
    while (animtime < 1) {
        var_9c755030 clientfield::set("smartcover_placed", 1 - animtime);
        animtime = var_9c755030 getanimtime(level.smartcoversettings.bundle.deployanim);
        waitframe(1);
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0xb17dfb3a, Offset: 0x1838
// Size: 0x350
function function_61a45d1e(traceresults) {
    if (!traceresults.var_a6ebd4f3 && !traceresults.var_49043cc6) {
        return traceresults.origin;
    }
    halfwidth = level.smartcoversettings.bundle.maxwidth * 0.5;
    var_67397f90 = halfwidth * halfwidth;
    var_b8b4300e = distance2d(traceresults.origin, traceresults.var_80fcfd6f);
    var_f6c3fcdb = distance2d(traceresults.origin, traceresults.var_430f8c00);
    if (traceresults.var_a6ebd4f3 && traceresults.var_49043cc6) {
        pointright = traceresults.var_80fcfd6f;
        pointleft = traceresults.var_430f8c00;
    } else if (traceresults.var_a6ebd4f3 && var_b8b4300e < halfwidth) {
        pointright = traceresults.var_80fcfd6f;
        directionleft = vectornormalize(traceresults.var_430f8c00 - traceresults.var_80fcfd6f);
        pointleft = traceresults.var_80fcfd6f + level.smartcoversettings.bundle.maxwidth * directionleft;
    } else if (traceresults.var_a6ebd4f3 && var_b8b4300e >= halfwidth) {
        return traceresults.origin;
    } else if (traceresults.var_49043cc6 && var_f6c3fcdb < halfwidth) {
        pointleft = traceresults.var_430f8c00;
        directionright = vectornormalize(traceresults.var_80fcfd6f - traceresults.var_430f8c00);
        pointright = traceresults.var_430f8c00 + level.smartcoversettings.bundle.maxwidth * directionright;
    } else if (traceresults.var_49043cc6 && var_f6c3fcdb >= halfwidth) {
        return traceresults.origin;
    }
    direction = vectornormalize(pointright - pointleft);
    origin = (pointleft[0], pointleft[1], traceresults.origin[2]) + level.smartcoversettings.bundle.maxwidth * 0.5 * direction;
    return origin;
}

// Namespace smart_cover/gadget_smart_cover
// Params 2, eflags: 0x0
// Checksum 0xe44b9884, Offset: 0x1b90
// Size: 0x384
function function_7dec71fd(watcher, owner) {
    self endon(#"death");
    player = owner;
    self hide();
    if (!isdefined(player.smartcover.lastvalid) || !player.smartcover.lastvalid.isvalid) {
        player deployable::function_76d9b29b(level.smartcoversettings.smartcoverweapon);
        return;
    }
    profilestart();
    var_9c755030 = player createsmartcover(watcher, self, player.smartcover.lastvalid.var_4e170d74, player.smartcover.lastvalid.angles, 1);
    profilestop();
    var_9c755030.angles = player.angles;
    var_9c755030.var_13df95bb = [];
    var_9c755030.var_c3a5aeb3 = 0;
    array::add(player.smartcover.var_dbb9c2c2, var_9c755030);
    var_ed4ce56d = function_5914ac9e(player.smartcover.var_dbb9c2c2, level.smartcoversettings.bundle.var_ebaaad96);
    if (isdefined(var_ed4ce56d)) {
        var_ed4ce56d function_49b67b21(1);
    }
    if (isdefined(level.onsmartcoverplaced)) {
        owner [[ level.onsmartcoverplaced ]](self);
    }
    self thread function_bdba0753(player);
    if (isdefined(level.smartcoversettings.bundle.deployanim)) {
        thread function_8e180cc(var_9c755030);
    }
    if (isdefined(level.smartcoversettings.bundle.var_caaf388d) ? level.smartcoversettings.bundle.var_caaf388d : 0) {
        player clientfield::set_player_uimodel("huditems.abilityHoldToActivate", 2);
    }
    var_9c755030 influencers::create_entity_enemy_influencer("turret_close", owner.team);
    if (isdefined(level.smartcoversettings.smartcoverweapon.var_e49dec4b)) {
        player playrumbleonentity(level.smartcoversettings.smartcoverweapon.var_e49dec4b);
    }
    thread function_648d802a(player);
    var_9c755030 thread function_9a01f62f();
    var_9c755030 thread function_f470146c();
}

// Namespace smart_cover/gadget_smart_cover
// Params 0, eflags: 0x0
// Checksum 0x553d80ed, Offset: 0x1f20
// Size: 0x80
function function_9a01f62f() {
    self endon(#"death");
    self.var_67ba89f5 = [];
    while (true) {
        waitresult = self waittill(#"grenade_stuck");
        if (isdefined(waitresult.projectile)) {
            array::add(self.var_67ba89f5, waitresult.projectile);
        }
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0xb5deeffb, Offset: 0x1fa8
// Size: 0x42
function function_94d9086f(watcher) {
    watcher.watchforfire = 1;
    watcher.onspawn = &function_7dec71fd;
    watcher.deleteonplayerspawn = 0;
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0xb1ca3055, Offset: 0x1ff8
// Size: 0x5c
function function_bdba0753(player) {
    self endon(#"death");
    player waittill(#"joined_team", #"disconnect");
    player function_f5935828();
}

// Namespace smart_cover/gadget_smart_cover
// Params 0, eflags: 0x0
// Checksum 0xd988cdc7, Offset: 0x2060
// Size: 0xa4
function function_d5344b62() {
    level endon(#"game_ended");
    self.owner endon(#"disconnect", #"joined_team", #"changed_specialist");
    self endon(#"hash_5de1fc3780ea0eaa");
    waitresult = self waittill(#"death");
    if (!isdefined(self)) {
        return;
    }
    self thread onkilled(waitresult);
}

// Namespace smart_cover/gadget_smart_cover
// Params 0, eflags: 0x0
// Checksum 0x76e0cdf3, Offset: 0x2110
// Size: 0x108
function ondamage() {
    self endon(#"death");
    level endon(#"game_ended");
    while (true) {
        waitresult = self waittill(#"damage");
        if (isdefined(waitresult.attacker) && isplayer(waitresult.attacker)) {
            if (waitresult.amount > 0 && damagefeedback::dodamagefeedback(waitresult.weapon, waitresult.attacker)) {
                waitresult.attacker damagefeedback::update(waitresult.mod, waitresult.inflictor, undefined, waitresult.weapon, self);
            }
        }
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0x8883cdfc, Offset: 0x2220
// Size: 0x4fc
function function_49b67b21(isselfdestruct) {
    smartcover = self;
    smartcover clientfield::set("enemyequip", 0);
    smartcover notify(#"hash_5de1fc3780ea0eaa");
    smartcover clientfield::set("friendlyequip", 0);
    if (isdefined(smartcover.owner)) {
        smartcover.owner clientfield::set_player_uimodel("hudItems.smartCoverState", 0);
        smartcover.owner clientfield::set_player_uimodel("huditems.abilityHoldToActivate", 0);
        smartcover.owner clientfield::set_player_uimodel("huditems.abilityDelayProgress", 0);
    }
    objective_delete(smartcover.objectiveid);
    gameobjects::release_obj_id(smartcover.objectiveid);
    if (isdefined(level.smartcoversettings.bundle.var_f2279079)) {
        if (isdefined(isselfdestruct) && isselfdestruct) {
            var_e4caf320 = level.smartcoversettings.bundle.var_d4b78df7;
            var_511fc28c = level.smartcoversettings.bundle.var_9d321615;
        } else {
            var_e4caf320 = level.smartcoversettings.bundle.var_f2279079;
            var_511fc28c = level.smartcoversettings.bundle.var_5be3e16b;
        }
        var_e313ea4a = self gettagorigin("tag_cover_base_d0");
        var_7787e02c = self gettagangles("tag_cover_base_d0");
        var_82a3f7eb = anglestoforward(var_7787e02c);
        var_992de64b = anglestoup(var_7787e02c);
        playfx(var_e4caf320, var_e313ea4a, var_82a3f7eb, var_992de64b);
        if (isdefined(var_511fc28c)) {
            smartcover playsound(var_511fc28c);
        }
    }
    removeindex = -1;
    for (index = 0; index < level.smartcoversettings.var_d8404722.size; index++) {
        if (level.smartcoversettings.var_d8404722[index] == smartcover) {
            array::remove_index(level.smartcoversettings.var_d8404722, index, 0);
            break;
        }
    }
    if (isdefined(smartcover.owner)) {
        for (index = 0; index < smartcover.owner.smartcover.var_dbb9c2c2.size; index++) {
            if (smartcover.owner.smartcover.var_dbb9c2c2[index] == smartcover) {
                arrayremovevalue(smartcover.owner.smartcover.var_dbb9c2c2, smartcover);
                smartcover.owner.smartcover.var_dbb9c2c2 = array::remove_undefined(smartcover.owner.smartcover.var_dbb9c2c2, 0);
                break;
            }
        }
    }
    if (isdefined(level.smartcoversettings.bundle.var_c99d7dc7) && level.smartcoversettings.bundle.var_c99d7dc7) {
        smartcover stopmicrowave();
        smartcover notify(#"microwave_turret_shutdown");
    }
    if (isdefined(smartcover.owner)) {
        smartcover.owner globallogic_score::function_8fe8d71e(#"hash_78cb6a053f51a857");
    }
    deployable::function_2cefe05a(smartcover);
    smartcover delete();
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0x9a626263, Offset: 0x2728
// Size: 0x10c
function onkilled(var_d484027) {
    smartcover = self;
    if (var_d484027.attacker != smartcover.owner) {
        smartcover.owner globallogic_score::function_a63adb85(var_d484027.attacker, var_d484027.weapon, smartcover.weapon);
        if (isdefined(level.var_b31e16d4)) {
            self [[ level.var_b31e16d4 ]](var_d484027.attacker, smartcover.owner, smartcover.weapon, var_d484027.weapon);
        }
        if (isdefined(self.owner)) {
            self.owner thread killstreaks::play_taacom_dialog("smartCoverWeaponDestroyedFriendly");
        }
    }
    smartcover thread function_49b67b21(0);
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0xe15bf92c, Offset: 0x2840
// Size: 0x5e
function function_d01d6d15(var_f1be9112) {
    return self.team == #"allies" ? level.smartcoversettings.bundle.var_7d03f1f2 : level.smartcoversettings.bundle.var_30621ed3;
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0x6919a644, Offset: 0x28a8
// Size: 0x5e
function getmodel(var_f1be9112) {
    return self.team == #"allies" ? level.smartcoversettings.bundle.var_9208ce87 : level.smartcoversettings.bundle.var_4e1d6636;
}

// Namespace smart_cover/gadget_smart_cover
// Params 12, eflags: 0x0
// Checksum 0x265ec8ae, Offset: 0x2910
// Size: 0x3ea
function function_c2a8f9b7(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, iboneindex, imodelindex) {
    bundle = level.smartcoversettings.bundle;
    startinghealth = isdefined(self.startinghealth) ? self.startinghealth : 0;
    if (isdefined(bundle.rocketstokill) && weapon == getweapon(#"launcher_standard")) {
        idamage = startinghealth / bundle.rocketstokill;
    }
    if (isdefined(bundle.kshero_annihilator) && weapon == getweapon(#"hero_annihilator")) {
        idamage = startinghealth / bundle.kshero_annihilator;
    } else if (isdefined(bundle.var_96fbccdc) && weapon == getweapon(#"hero_flamethrower")) {
        idamage = startinghealth / bundle.var_96fbccdc;
    } else if (isdefined(bundle.kshero_gravityspikes) && weapon == getweapon(#"eq_gravityslam")) {
        idamage = startinghealth / bundle.kshero_gravityspikes;
    } else if (isdefined(bundle.var_e8dfe37b) && weapon == getweapon(#"shock_rifle")) {
        idamage = startinghealth / bundle.var_e8dfe37b;
    } else if (isdefined(bundle.var_28cb88f2) && weapon == getweapon(#"planemortar")) {
        idamage = startinghealth / bundle.var_28cb88f2;
    } else if (isdefined(bundle.ksdartstokill) && (weapon == getweapon(#"dart_blade") || weapon == getweapon(#"dart_turret"))) {
        idamage = startinghealth / bundle.ksdartstokill;
    } else if (isdefined(bundle.var_c6c908f1) && weapon == getweapon(#"recon_car")) {
        idamage = startinghealth / bundle.var_c6c908f1;
    } else if (isdefined(bundle.ksremote_missile_missile) && weapon == getweapon(#"remote_missile_missile")) {
        idamage = startinghealth / bundle.ksremote_missile_missile;
    }
    return int(idamage);
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0xf27215cb, Offset: 0x2d08
// Size: 0x232
function function_1467b3be(smartcover) {
    smartcover.var_8b6782ff = [];
    forwardangles = anglestoforward(smartcover.angles);
    rightangles = anglestoright(smartcover.angles);
    var_389957e3 = smartcover.origin + (0, 0, 1) * getdvarfloat(#"hash_4d17057924212aa9", 1);
    smartcover.var_8b6782ff[smartcover.var_8b6782ff.size] = var_389957e3 + forwardangles * getdvarfloat(#"hash_477cc29b988c0b75", 1);
    smartcover.var_8b6782ff[smartcover.var_8b6782ff.size] = smartcover.var_8b6782ff[0] + (0, 0, 1) * getdvarfloat(#"hash_41cfd0e34c53ef02", 1);
    backpoint = var_389957e3 + forwardangles * getdvarfloat(#"hash_7f893c50ae5356c8", 1);
    smartcover.var_8b6782ff[smartcover.var_8b6782ff.size] = backpoint + rightangles * getdvarfloat(#"hash_70ce44b2b0b4005", 1);
    smartcover.var_8b6782ff[smartcover.var_8b6782ff.size] = backpoint - rightangles * getdvarfloat(#"hash_70ce44b2b0b4005", 1);
}

// Namespace smart_cover/gadget_smart_cover
// Params 5, eflags: 0x0
// Checksum 0x5eae58d8, Offset: 0x2f48
// Size: 0x5c8
function createsmartcover(watcher, var_b5a48d86, origin, angles, var_f1be9112) {
    player = self;
    var_11182651 = spawn("script_model", origin);
    var_b5a48d86.smartcover = var_11182651;
    var_11182651 setmodel(player getmodel(var_f1be9112));
    watcher.objectarray[watcher.objectarray.size] = var_11182651;
    var_4717ded8 = getdvarint(#"hash_1d8eb304f5cf8033", 0);
    if (var_4717ded8 == 1) {
        var_11182651 function_1f5068be(player function_d01d6d15(var_f1be9112));
    }
    var_11182651.angles = angles;
    var_11182651.owner = player;
    var_11182651.takedamage = 1;
    var_11182651.startinghealth = isdefined(level.smartcoversettings.bundle.var_c50a3341) ? level.smartcoversettings.bundle.var_c50a3341 : var_f1be9112 ? isdefined(level.smartcoversettings.bundle.var_b8059cb0) ? level.smartcoversettings.bundle.var_b8059cb0 : 100 : 100;
    var_11182651.health = var_11182651.startinghealth;
    var_11182651 solid();
    if (!sessionmodeiswarzonegame()) {
        var_11182651 disconnectpaths();
    }
    var_11182651 setteam(player getteam());
    var_11182651.var_6b0336c0 = &function_c2a8f9b7;
    var_11182651.weapon = level.smartcoversettings.smartcoverweapon;
    var_11182651 setweapon(var_11182651.weapon);
    array::add(player.smartcover.var_f45e90eb, var_11182651);
    var_a083421a = var_f1be9112 ? level.smartcoversettings.var_bdc049de : level.smartcoversettings.var_54dfedd9;
    if (isdefined(var_a083421a)) {
        var_11182651.objectiveid = gameobjects::get_next_obj_id();
        objective_add(var_11182651.objectiveid, "active", var_11182651, var_a083421a);
        function_eeba3a5c(var_11182651.objectiveid, 1);
        objective_setteam(var_11182651.objectiveid, player.team);
    }
    var_15f00635 = player gadgetgetslot(level.smartcoversettings.smartcoverweapon);
    if (!sessionmodeiswarzonegame()) {
        self gadgetpowerset(var_15f00635, 0);
    }
    var_11182651 setteam(player.team);
    array::add(level.smartcoversettings.var_d8404722, var_11182651);
    function_1467b3be(var_11182651);
    var_11182651 clientfield::set("friendlyequip", 1);
    var_11182651 clientfield::set("enemyequip", 1);
    var_11182651 thread ondamage();
    var_11182651 thread function_d5344b62();
    thread function_104f9c0a(var_11182651);
    player deployable::function_c0980d61(var_11182651, level.smartcoversettings.smartcoverweapon);
    if (isdefined(level.smartcoversettings.bundle.var_c99d7dc7) && level.smartcoversettings.bundle.var_c99d7dc7) {
        var_11182651 thread startmicrowave();
    }
    if (isdefined(level.var_67af0a7)) {
        [[ level.var_67af0a7 ]](var_11182651, &function_649a7b11, &function_d5640ab6);
    }
    return var_11182651;
}

// Namespace smart_cover/gadget_smart_cover
// Params 2, eflags: 0x0
// Checksum 0x17e070fe, Offset: 0x3518
// Size: 0x58
function function_649a7b11(var_252bd17, jammerent) {
    var_252bd17 stopmicrowave();
    if (isdefined(level.var_4c4ba90e)) {
        [[ level.var_4c4ba90e ]](var_252bd17, 1);
    }
    return true;
}

// Namespace smart_cover/gadget_smart_cover
// Params 2, eflags: 0x0
// Checksum 0xe0dde59, Offset: 0x3578
// Size: 0x54
function function_d5640ab6(var_252bd17, jammerent) {
    var_252bd17 startmicrowave();
    if (isdefined(level.var_4c4ba90e)) {
        [[ level.var_4c4ba90e ]](var_252bd17, 0);
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0x80ce1028, Offset: 0x35d8
// Size: 0xa0
function function_104f9c0a(smartcover) {
    level endon(#"game_ended");
    smartcover endon(#"death");
    while (true) {
        waitresult = smartcover waittill(#"broken");
        if (waitresult.type == "base_piece_broken") {
            smartcover function_49b67b21(0);
        }
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 2, eflags: 0x0
// Checksum 0xbd1d60e8, Offset: 0x3680
// Size: 0xb6
function function_fee79db3(origin, maxdistancesq) {
    foreach (smartcover in level.smartcoversettings.var_d8404722) {
        if (!isdefined(smartcover)) {
            continue;
        }
        if (distancesquared(smartcover.origin, origin) < maxdistancesq) {
            return true;
        }
    }
    return false;
}

// Namespace smart_cover/gadget_smart_cover
// Params 0, eflags: 0x0
// Checksum 0x655db24e, Offset: 0x3740
// Size: 0x88
function watchweaponchange() {
    player = self;
    self notify(#"watchweaponchange_singleton");
    self endon(#"watchweaponchange_singleton");
    while (true) {
        if (self weaponswitchbuttonpressed()) {
            if (isdefined(player.smartcover)) {
                player.smartcover.var_ba2d79e8 = 1;
            }
        }
        waitframe(1);
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 2, eflags: 0x0
// Checksum 0x6d4e2283, Offset: 0x37d0
// Size: 0x6a
function function_5914ac9e(&coverlist, maxallowed) {
    if (coverlist.size <= maxallowed) {
        return undefined;
    }
    var_455b9443 = array::pop_front(coverlist, 0);
    coverlist = array::remove_undefined(coverlist, 0);
    return var_455b9443;
}

// Namespace smart_cover/gadget_smart_cover
// Params 5, eflags: 0x0
// Checksum 0xb27c9358, Offset: 0x3848
// Size: 0x326
function function_20ab07ea(attacker, victim, weapon, attackerweapon, meansofdeath) {
    if (!isdefined(level.smartcoversettings) || !isdefined(level.smartcoversettings.var_d8404722) || !isdefined(victim) || !isdefined(attacker) || !isdefined(attackerweapon) || !isdefined(weapon)) {
        return false;
    }
    if (isdefined(level.iskillstreakweapon) && [[ level.iskillstreakweapon ]](attackerweapon) || attackerweapon == weapon) {
        return false;
    }
    foreach (smartcover in level.smartcoversettings.var_d8404722) {
        if (!isdefined(smartcover)) {
            continue;
        }
        if (victim == smartcover.owner || level.teambased && victim.team == smartcover.owner.team) {
            continue;
        }
        var_6bb3efd = distancesquared(smartcover.origin, attacker.origin);
        if (var_6bb3efd > level.smartcoversettings.var_bee3c05a) {
            continue;
        }
        var_d280e2c4 = distancesquared(victim.origin, smartcover.origin);
        var_9bdfaca3 = distancesquared(victim.origin, attacker.origin);
        var_bede1ff6 = var_9bdfaca3 > var_6bb3efd;
        var_9b852882 = var_9bdfaca3 > var_d280e2c4;
        if (var_bede1ff6 && var_9b852882) {
            var_9308fab1 = 1;
            var_7b62838a = smartcover.owner;
            break;
        }
    }
    if (isdefined(var_7b62838a) && isdefined(var_9308fab1) && var_9308fab1) {
        if (smartcover.owner == attacker) {
            return true;
        } else {
            scoreevents::processscoreevent(#"deployable_cover_assist", var_7b62838a, victim, level.smartcoversettings.smartcoverweapon);
        }
    }
    return false;
}

// Namespace smart_cover/gadget_smart_cover
// Params 3, eflags: 0x4
// Checksum 0xf2138ebc, Offset: 0x3b78
// Size: 0x2bc
function private function_fccffefa(smartcover, origins, radii) {
    assert(isarray(origins));
    assert(!isarray(radii) || origins.size == radii.size);
    assert(isdefined(smartcover.var_8b6782ff) && smartcover.var_8b6782ff.size > 0);
    foreach (var_b1dc533c in smartcover.var_8b6782ff) {
        for (index = 0; index < origins.size; index++) {
            distance = distancesquared(origins[index], var_b1dc533c);
            radius = isarray(radii) ? radii[index] : radii;
            combinedradius = radius + getdvarfloat(#"hash_4d17057924212aa9", 1);
            if (getdvarint(#"hash_686a676b28ae0af4", 0) == 1) {
                /#
                    sphere(origins[index], radius, (0, 0, 1), 0.5, 0, 10, 500);
                    sphere(var_b1dc533c, getdvarfloat(#"hash_4d17057924212aa9", 1), (1, 0, 0), 0.5, 0, 10, 500);
                #/
            }
            radiussqr = combinedradius * combinedradius;
            if (distance < radiussqr) {
                return true;
            }
        }
    }
    return false;
}

// Namespace smart_cover/gadget_smart_cover
// Params 2, eflags: 0x0
// Checksum 0x78735768, Offset: 0x3e40
// Size: 0xd2
function function_5929f896(origins, radii) {
    if (!isdefined(level.smartcoversettings.var_d8404722)) {
        return false;
    }
    foreach (smartcover in level.smartcoversettings.var_d8404722) {
        if (!isdefined(smartcover)) {
            continue;
        }
        if (function_fccffefa(smartcover, origins, radii)) {
            return true;
        }
    }
    return false;
}

// Namespace smart_cover/gadget_smart_cover
// Params 0, eflags: 0x0
// Checksum 0xa2ce6016, Offset: 0x3f20
// Size: 0x16
function reset_being_microwaved() {
    self.lastmicrowavedby = undefined;
    self.beingmicrowavedby = undefined;
}

// Namespace smart_cover/gadget_smart_cover
// Params 0, eflags: 0x0
// Checksum 0x66a07cab, Offset: 0x3f40
// Size: 0x18c
function startmicrowave() {
    if (isdefined(self.trigger)) {
        self.trigger delete();
    }
    self clientfield::set("start_smartcover_microwave", 1);
    self.trigger = spawn("trigger_radius", self.origin + (0, 0, (isdefined(level.smartcoversettings.bundle.var_d600d0ee) ? level.smartcoversettings.bundle.var_d600d0ee : 0) * -1), 4096 | 16384 | level.aitriggerspawnflags | level.vehicletriggerspawnflags, isdefined(level.smartcoversettings.bundle.var_d600d0ee) ? level.smartcoversettings.bundle.var_d600d0ee : 0, (isdefined(level.smartcoversettings.bundle.var_d600d0ee) ? level.smartcoversettings.bundle.var_d600d0ee : 0) * 2);
    self thread turretthink();
    /#
        self thread turretdebugwatch();
    #/
}

// Namespace smart_cover/gadget_smart_cover
// Params 0, eflags: 0x0
// Checksum 0x1eca3fb0, Offset: 0x40d8
// Size: 0x8e
function stopmicrowave() {
    if (!isdefined(self)) {
        return;
    }
    self playsound(#"mpl_microwave_beam_off");
    self clientfield::set("start_smartcover_microwave", 0);
    if (isdefined(self.trigger)) {
        self.trigger delete();
    }
    /#
        self notify(#"stop_turret_debug");
    #/
}

// Namespace smart_cover/gadget_smart_cover
// Params 0, eflags: 0x0
// Checksum 0x5618c676, Offset: 0x4170
// Size: 0x7c
function turretdebugwatch() {
    turret = self;
    turret endon(#"stop_turret_debug");
    for (;;) {
        if (getdvarint(#"scr_microwave_turret_debug", 0) != 0) {
            turret turretdebug();
            waitframe(1);
            continue;
        }
        wait 1;
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 0, eflags: 0x0
// Checksum 0x458f7c5d, Offset: 0x41f8
// Size: 0x17c
function turretdebug() {
    turret = self;
    angles = turret gettagangles("tag_flash");
    origin = turret gettagorigin("tag_flash");
    cone_apex = origin;
    forward = anglestoforward(angles);
    dome_apex = cone_apex + vectorscale(forward, isdefined(level.smartcoversettings.bundle.var_d600d0ee) ? level.smartcoversettings.bundle.var_d600d0ee : 0);
    /#
        util::debug_spherical_cone(cone_apex, dome_apex, isdefined(level.smartcoversettings.bundle.var_368ce1d2) ? level.smartcoversettings.bundle.var_368ce1d2 : 0, 16, (0.95, 0.1, 0.1), 0.3, 1, 3);
    #/
}

// Namespace smart_cover/gadget_smart_cover
// Params 0, eflags: 0x0
// Checksum 0x4d4959d3, Offset: 0x4380
// Size: 0x130
function turretthink() {
    turret = self;
    turret endon(#"microwave_turret_shutdown");
    turret endon(#"death");
    turret.trigger endon(#"death");
    turret.turret_vehicle_entnum = turret getentitynumber();
    while (true) {
        waitresult = turret.trigger waittill(#"trigger");
        ent = waitresult.activator;
        if (ent == turret) {
            continue;
        }
        if (!isdefined(ent.beingmicrowavedby)) {
            ent.beingmicrowavedby = [];
        }
        if (!isdefined(ent.beingmicrowavedby[turret.turret_vehicle_entnum])) {
            turret thread microwaveentity(ent);
        }
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0x8a75eb3f, Offset: 0x44b8
// Size: 0xcc
function microwaveentitypostshutdowncleanup(entity) {
    entity endon(#"disconnect");
    entity endon(#"end_microwaveentitypostshutdowncleanup");
    self endon(#"death");
    turret = self;
    turret_vehicle_entnum = turret.turret_vehicle_entnum;
    turret waittill(#"microwave_turret_shutdown");
    if (isdefined(entity)) {
        if (isdefined(entity.beingmicrowavedby) && isdefined(entity.beingmicrowavedby[turret_vehicle_entnum])) {
            entity.beingmicrowavedby[turret_vehicle_entnum] = undefined;
        }
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0x7e2ecb2, Offset: 0x4590
// Size: 0x750
function microwaveentity(entity) {
    turret = self;
    turret endon(#"microwave_turret_shutdown");
    turret endon(#"death");
    entity endon(#"disconnect");
    entity endon(#"death");
    if (isplayer(entity)) {
        entity endon(#"joined_team");
        entity endon(#"joined_spectators");
    }
    turret thread microwaveentitypostshutdowncleanup(entity);
    entity.beingmicrowavedby[turret.turret_vehicle_entnum] = turret.owner;
    entity.microwavedamageinitialdelay = 1;
    entity.microwaveeffect = 0;
    shellshockscalar = 1;
    viewkickscalar = 1;
    damagescalar = 1;
    if (isplayer(entity) && entity hasperk(#"specialty_microwaveprotection")) {
        shellshockscalar = getdvarfloat(#"specialty_microwaveprotection_shellshock_scalar", 0.5);
        viewkickscalar = getdvarfloat(#"specialty_microwaveprotection_viewkick_scalar", 0.5);
        damagescalar = getdvarfloat(#"specialty_microwaveprotection_damage_scalar", 0.5);
    }
    var_adce82d2 = getstatuseffect(#"microwave_slowed");
    var_9d155aaa = getstatuseffect(#"microwave_dot");
    turret_vehicle_entnum = turret.turret_vehicle_entnum;
    while (true) {
        if (!isdefined(turret) || !isdefined(turret.trigger) || !turret microwaveturretaffectsentity(entity)) {
            if (!isdefined(entity)) {
                return;
            }
            if (isdefined(entity.beingmicrowavedby[turret_vehicle_entnum])) {
                entity thread status_effect::function_280d8ac0(var_adce82d2.setype, var_adce82d2.var_d20b8ed2);
                entity thread status_effect::function_280d8ac0(var_9d155aaa.setype, var_9d155aaa.var_d20b8ed2);
                if (isdefined(entity.var_6ac8485b)) {
                    entity stoprumble(entity.var_6ac8485b);
                    entity.var_6ac8485b = undefined;
                }
            }
            entity.beingmicrowavedby[turret_vehicle_entnum] = undefined;
            if (isdefined(entity.microwavepoisoning) && entity.microwavepoisoning) {
                entity.microwavepoisoning = 0;
            }
            entity notify(#"end_microwaveentitypostshutdowncleanup");
            return;
        }
        damage = (isdefined(level.smartcoversettings.bundle.var_799d42af) ? level.smartcoversettings.bundle.var_799d42af : 0) * damagescalar;
        if (level.hardcoremode) {
            damage /= 2;
        }
        if (!isai(entity) && entity util::mayapplyscreeneffect()) {
            if (!isdefined(entity.microwavepoisoning) || !entity.microwavepoisoning) {
                entity.microwavepoisoning = 1;
                entity.microwaveeffect = 0;
            }
        }
        if (isdefined(entity.microwavedamageinitialdelay)) {
            wait randomfloatrange(0.1, 0.3);
            entity.microwavedamageinitialdelay = undefined;
        }
        entity thread status_effect::status_effect_apply(var_9d155aaa, level.smartcoversettings.smartcoverweapon, self, 0);
        entity.microwaveeffect++;
        entity.lastmicrowavedby = turret.owner;
        time = gettime();
        if (isplayer(entity)) {
            entity playsoundtoplayer(#"hash_5eecc78116b1fc85", entity);
            if (!entity isremotecontrolling() && time - (isdefined(entity.microwaveshellshockandviewkicktime) ? entity.microwaveshellshockandviewkicktime : 0) > 950) {
                if (entity.microwaveeffect % 2 == 1) {
                    entity viewkick(int(25 * viewkickscalar), turret.origin);
                    entity.microwaveshellshockandviewkicktime = time;
                    entity thread status_effect::status_effect_apply(var_adce82d2, level.smartcoversettings.smartcoverweapon, self, 0);
                    var_d140815b = level.smartcoversettings.bundle.var_26047b9f;
                    if (isdefined(var_d140815b)) {
                        entity playrumbleonentity(var_d140815b);
                        entity.var_6ac8485b = var_d140815b;
                    }
                }
            }
            if (!isdefined(turret.playersdamaged)) {
                turret.playersdamaged = [];
            }
            turret.playersdamaged[entity.clientid] = 1;
            if (entity.microwaveeffect % 3 == 2) {
                scoreevents::processscoreevent(#"hpm_suppress", turret.owner, entity, level.smartcoversettings.smartcoverweapon, turret.playersdamaged.size);
            }
        }
        wait 0.5;
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0x263ee96b, Offset: 0x4ce8
// Size: 0x46a
function microwaveturretaffectsentity(entity) {
    turret = self;
    if (!isalive(entity)) {
        return false;
    }
    if (!isplayer(entity) && !isai(entity)) {
        return false;
    }
    if (entity.ignoreme === 1) {
        return false;
    }
    if (isdefined(turret.carried) && turret.carried) {
        return false;
    }
    if (turret weaponobjects::isstunned()) {
        return false;
    }
    if (isdefined(turret.owner) && entity == turret.owner) {
        return false;
    }
    if (!damage::friendlyfirecheck(turret.owner, entity, 0)) {
        return false;
    }
    if (isplayer(entity) && entity geteye()[2] < turret.origin[2]) {
        return false;
    }
    if (isai(entity)) {
        entityheight = entity.maxs[2] - entity.mins[2] + entity.origin[2];
        if (entityheight < turret.origin[2]) {
            return false;
        }
    }
    if ((isdefined(level.smartcoversettings.bundle.var_a89502bb) ? level.smartcoversettings.bundle.var_a89502bb : 0) > 0 && entity.origin[2] > turret.origin[2] + level.smartcoversettings.bundle.var_a89502bb) {
        return false;
    }
    if (distancesquared(entity.origin, turret.origin) > (isdefined(level.smartcoversettings.bundle.var_d600d0ee) ? level.smartcoversettings.bundle.var_d600d0ee : 0) * (isdefined(level.smartcoversettings.bundle.var_d600d0ee) ? level.smartcoversettings.bundle.var_d600d0ee : 0)) {
        return false;
    }
    angles = turret getangles();
    origin = turret.origin + (0, 0, 30);
    shoot_at_pos = entity getshootatpos(turret);
    entdirection = vectornormalize(shoot_at_pos - origin);
    forward = anglestoforward(angles);
    dot = vectordot(entdirection, forward);
    if (dot < cos(isdefined(level.smartcoversettings.bundle.var_368ce1d2) ? level.smartcoversettings.bundle.var_368ce1d2 : 0)) {
        return false;
    }
    if (entity damageconetrace(origin, turret, forward) <= 0) {
        return false;
    }
    return true;
}

