#using script_1cc417743d7c262d;
#using script_4721de209091b1a6;
#using scripts\abilities\ability_player;
#using scripts\core_common\array_shared;
#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\damage;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreak_bundles;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\weapons\deployable;
#using scripts\weapons\weaponobjects;

#namespace smart_cover;

// Namespace smart_cover/gadget_smart_cover
// Params 0, eflags: 0x0
// Checksum 0x78ed1c96, Offset: 0x360
// Size: 0x53c
function init_shared() {
    level.smartcoversettings = spawnstruct();
    if (sessionmodeismultiplayergame()) {
        if (getgametypesetting(#"competitivesettings") === 1) {
            level.smartcoversettings.bundle = getscriptbundle(#"smartcover_custom_settings_comp");
        } else {
            level.smartcoversettings.bundle = getscriptbundle(#"smartcover_settings_mp");
        }
    } else if (sessionmodeiswarzonegame()) {
        level.smartcoversettings.bundle = getscriptbundle(#"smartcover_settings_wz");
    } else if (sessionmodeiscampaigngame()) {
        level.smartcoversettings.bundle = getscriptbundle(#"smartcover_settings_cp");
    }
    level.smartcoversettings.var_ac3f76c7 = "smart_cover_objective_full";
    level.smartcoversettings.var_546a220c = "smart_cover_objective_open";
    level.smartcoversettings.smartcoverweapon = getweapon("ability_smart_cover");
    level.smartcoversettings.var_4115bb3a = getweapon(#"hash_34575452eba07c65");
    level.smartcoversettings.objectivezones = [];
    setupdvars();
    ability_player::register_gadget_should_notify(27, 1);
    weaponobjects::function_e6400478(#"ability_smart_cover", &function_21e722f6, 1);
    callback::on_spawned(&on_player_spawned);
    level.smartcoversettings.var_f115c746 = [];
    deployable::register_deployable(level.smartcoversettings.smartcoverweapon, &function_b7f5b1cc, &function_a47ce1c2, undefined, undefined, 1);
    level.smartcoversettings.var_357db326 = 10000;
    level.smartcoversettings.var_ff1a491d = level.smartcoversettings.bundle.var_76d79155 * level.smartcoversettings.bundle.var_76d79155;
    if (!sessionmodeiswarzonegame()) {
        globallogic_score::register_kill_callback(level.smartcoversettings.smartcoverweapon, &function_92112113);
        globallogic_score::function_86f90713(level.smartcoversettings.smartcoverweapon, &function_92112113);
    }
    clientfield::register_clientuimodel("hudItems.smartCoverState", 1, 1, "int");
    clientfield::register("scriptmover", "smartcover_placed", 1, 5, "float");
    clientfield::register("scriptmover", "start_smartcover_microwave", 1, 1, "int");
    callback::on_end_game(&on_end_game);
    setdvar(#"hash_4d17057924212aa9", 20);
    setdvar(#"hash_686a676b28ae0af4", 0);
    setdvar(#"hash_7f893c50ae5356c8", -15);
    setdvar(#"hash_70ce44b2b0b4005", 30);
    setdvar(#"hash_477cc29b988c0b75", -10);
    setdvar(#"hash_41cfd0e34c53ef02", 30);
    callback::on_finalize_initialization(&function_1c601b99);
}

// Namespace smart_cover/gadget_smart_cover
// Params 0, eflags: 0x0
// Checksum 0x59bc968f, Offset: 0x8a8
// Size: 0x80
function function_1c601b99() {
    if (isdefined(level.var_1b900c1d)) {
        [[ level.var_1b900c1d ]](level.smartcoversettings.smartcoverweapon, &function_bff5c062);
    }
    if (isdefined(level.var_a5dacbea)) {
        [[ level.var_a5dacbea ]](level.smartcoversettings.smartcoverweapon, &function_127fb8f3);
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 0, eflags: 0x0
// Checksum 0x95437fa0, Offset: 0x930
// Size: 0xe4
function function_716c6c70() {
    self endon(#"death", #"cancel_timeout");
    util::wait_network_frame(1);
    if (isdefined(self) && self getentitytype() == 6) {
        self clientfield::set("start_smartcover_microwave", 0);
    }
    util::wait_network_frame(1);
    if (isdefined(self) && self getentitytype() == 6) {
        self clientfield::set("start_smartcover_microwave", 1);
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 2, eflags: 0x0
// Checksum 0xfc711a20, Offset: 0xa20
// Size: 0x31a
function function_bff5c062(smartcover, attackingplayer) {
    original_owner = smartcover.owner;
    original_owner weaponobjects::hackerremoveweapon(smartcover);
    smartcover notify(#"hacked");
    if (isdefined(smartcover.grenade)) {
        smartcover.grenade notify(#"hacked");
    }
    smartcover notify(#"cancel_timeout");
    function_375cfa56(smartcover, original_owner);
    smartcover.owner = attackingplayer;
    smartcover setowner(attackingplayer);
    smartcover.team = attackingplayer.team;
    if (isdefined(smartcover.var_40bfd9cf)) {
        smartcover influencers::remove_influencer(smartcover.var_40bfd9cf);
    }
    if (isdefined(smartcover.var_2d045452) && isdefined(original_owner)) {
        watcher = original_owner weaponobjects::getweaponobjectwatcherbyweapon(smartcover.var_2d045452.weapon);
        if (isdefined(watcher)) {
            smartcover.var_2d045452 thread weaponobjects::function_6d8aa6a0(attackingplayer, watcher);
        }
    }
    smartcover.var_40bfd9cf = smartcover influencers::create_entity_enemy_influencer("turret_close", attackingplayer.team);
    smartcover thread function_37f1dcd1();
    array::add(attackingplayer.smartcover.var_19e1ea69, smartcover);
    var_26c9fcc2 = function_57f553e9(attackingplayer.smartcover.var_19e1ea69, level.smartcoversettings.bundle.var_a0b69d8b);
    if (isdefined(var_26c9fcc2)) {
        var_26c9fcc2 function_2a494565(1);
    }
    smartcover thread function_716c6c70();
    if (isdefined(level.var_f1edf93f)) {
        var_eb79e7c3 = [[ level.var_f1edf93f ]]();
        smartcover thread function_b397b517(var_eb79e7c3);
    }
    if (is_true(smartcover.smartcoverjammed)) {
        smartcover startmicrowave();
        smartcover.smartcoverjammed = 0;
        if (isdefined(level.var_fc1bbaef)) {
            [[ level.var_fc1bbaef ]](smartcover);
        }
        smartcover.smartcoverjammed = 0;
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 0, eflags: 0x0
// Checksum 0xcc906ed2, Offset: 0xd48
// Size: 0x1f8
function on_end_game() {
    if (!isdefined(level.smartcoversettings) || !isdefined(level.smartcoversettings.smartcoverweapon)) {
        return;
    }
    foreach (player in level.players) {
        var_9d063af9 = player gadgetgetslot(level.smartcoversettings.smartcoverweapon);
        player gadgetdeactivate(var_9d063af9, level.smartcoversettings.smartcoverweapon);
        player function_48e08b4(var_9d063af9, level.smartcoversettings.smartcoverweapon);
    }
    if (!isdefined(level.smartcoversettings.var_f115c746)) {
        return;
    }
    var_73137502 = arraycopy(level.smartcoversettings.var_f115c746);
    foreach (smartcover in var_73137502) {
        if (!isdefined(smartcover)) {
            continue;
        }
        smartcover function_2a494565(1);
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 0, eflags: 0x0
// Checksum 0x3a7edf1c, Offset: 0xf48
// Size: 0x16c
function setupdvars() {
    setdvar(#"hash_4f4ce3cb18b004bc", 8);
    setdvar(#"hash_417afa70d515fba5", isdefined(level.smartcoversettings.bundle.var_76d79155) ? level.smartcoversettings.bundle.var_76d79155 : 0);
    setdvar(#"hash_1d8eb304f5cf8033", 0);
    setdvar(#"hash_71f8bd4cd30de4b3", isdefined(level.smartcoversettings.bundle.var_e35fc674) ? level.smartcoversettings.bundle.var_e35fc674 : 0);
    setdvar(#"hash_39a564d4801c4b2e", isdefined(level.smartcoversettings.bundle.var_1f0ae388) ? level.smartcoversettings.bundle.var_1f0ae388 : 0);
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0xfc18745a, Offset: 0x10c0
// Size: 0x1c
function function_649f8cbe(func) {
    level.onsmartcoverplaced = func;
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0xbfd6aa9f, Offset: 0x10e8
// Size: 0x1c
function function_a9427b5c(func) {
    level.var_a430cceb = func;
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0x49cc07dc, Offset: 0x1110
// Size: 0xac
function function_b397b517(timeoutoverride) {
    self endon(#"death", #"cancel_timeout");
    timeouttime = isdefined(timeoutoverride) ? timeoutoverride : level.smartcoversettings.bundle.timeout;
    if ((isdefined(timeouttime) ? timeouttime : 0) == 0) {
        return;
    }
    wait timeouttime;
    if (isdefined(self)) {
        self thread function_2a494565(1);
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 0, eflags: 0x0
// Checksum 0x74c30d71, Offset: 0x11c8
// Size: 0x84
function function_b11be5dc() {
    if (!isdefined(self.smartcover)) {
        return;
    }
    for (index = self.smartcover.var_58e8b64d.size; index >= 0; index--) {
        smartcover = self.smartcover.var_58e8b64d[index];
        if (isdefined(smartcover)) {
            smartcover function_2a494565(1);
        }
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 2, eflags: 0x0
// Checksum 0x30ec1685, Offset: 0x1258
// Size: 0x384
function function_bd071599(player, smartcover) {
    level endon(#"game_ended");
    player notify(#"hash_53db5f084a244a94");
    player endon(#"hash_53db5f084a244a94");
    player endon(#"death", #"disconnect", #"joined_team", #"changed_specialist");
    smartcover endon(#"death");
    var_f5929597 = gettime() + int((isdefined(level.smartcoversettings.bundle.var_fee887dc) ? level.smartcoversettings.bundle.var_fee887dc : 0) * 1000);
    player.var_622765b5 = 1;
    currenttime = gettime();
    timeelapsed = 0;
    while (var_f5929597 > gettime()) {
        if (!player gamepadusedlast()) {
            break;
        }
        if (!player offhandspecialbuttonpressed()) {
            player clientfield::set_player_uimodel("huditems.abilityDelayProgress", 0);
            player.var_622765b5 = 0;
            return;
        }
        timeelapsed = gettime() - currenttime;
        var_1cf1ae8b = timeelapsed / int((isdefined(level.smartcoversettings.bundle.var_fee887dc) ? level.smartcoversettings.bundle.var_fee887dc : 0) * 1000);
        player clientfield::set_player_uimodel("huditems.abilityDelayProgress", var_1cf1ae8b);
        waitframe(1);
    }
    player thread gestures::function_f3e2696f(player, level.smartcoversettings.var_4115bb3a, undefined, 0.75, undefined, undefined, undefined);
    if (isdefined(level.smartcoversettings.bundle.var_d47e600f)) {
        smartcover playsound(level.smartcoversettings.bundle.var_d47e600f);
    }
    player clientfield::set_player_uimodel("huditems.abilityHoldToActivate", 0);
    player clientfield::set_player_uimodel("huditems.abilityDelayProgress", 0);
    wait isdefined(level.smartcoversettings.bundle.detonationtime) ? level.smartcoversettings.bundle.detonationtime : 0;
    player.var_622765b5 = 0;
    player.var_d3bf8986 = 1;
    smartcover function_2a494565(1);
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0x967c10c6, Offset: 0x15e8
// Size: 0x426
function function_7ecb04ff(player) {
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
        var_9d063af9 = player gadgetgetslot(level.smartcoversettings.smartcoverweapon);
        if (!isdefined(var_9d063af9) || var_9d063af9 == -1) {
            continue;
        }
        ammocount = player getammocount(level.smartcoversettings.smartcoverweapon);
        gadgetpower = player gadgetpowerget(var_9d063af9);
        if (gadgetpower >= 100 || ammocount > 0) {
            player clientfield::set_player_uimodel("huditems.abilityHoldToActivate", 0);
            player clientfield::set_player_uimodel("hudItems.smartCoverState", 0);
            continue;
        }
        if (player.smartcover.var_19e1ea69.size == 0) {
            continue;
        }
        if (isdefined(level.smartcoversettings.bundle.var_ad7084b4) ? level.smartcoversettings.bundle.var_ad7084b4 : 0) {
            player clientfield::set_player_uimodel("huditems.abilityHoldToActivate", 2);
            player clientfield::set_player_uimodel("hudItems.smartCoverState", 1);
            if ((isdefined(level.smartcoversettings.bundle.var_ad7084b4) ? level.smartcoversettings.bundle.var_ad7084b4 : 0) && player offhandspecialbuttonpressed() && (!isdefined(player.var_622765b5) || !player.var_622765b5) && !(isdefined(player.var_d3bf8986) ? player.var_d3bf8986 : 0)) {
                foreach (smartcover in player.smartcover.var_58e8b64d) {
                    if (!isdefined(smartcover)) {
                        continue;
                    }
                    smartcover thread function_bd071599(player, smartcover);
                    break;
                }
                continue;
            }
            if (!player offhandspecialbuttonpressed() && (isdefined(player.var_d3bf8986) ? player.var_d3bf8986 : 0)) {
                player.var_d3bf8986 = 0;
            }
        }
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 0, eflags: 0x0
// Checksum 0x2646c0c1, Offset: 0x1a18
// Size: 0x9c
function on_player_spawned() {
    if (!isdefined(self.smartcover)) {
        self.smartcover = spawnstruct();
        self.smartcover.var_58e8b64d = [];
        self.smartcover.var_19e1ea69 = [];
        self.smartcover.var_d5258d02 = [];
    }
    self clientfield::set_player_uimodel("huditems.abilityDelayProgress", 0);
    self.var_622765b5 = 0;
    self reset_being_microwaved();
}

// Namespace smart_cover/gadget_smart_cover
// Params 3, eflags: 0x0
// Checksum 0x7519d402, Offset: 0x1ac0
// Size: 0x48
function function_b7f5b1cc(origin, angles, player) {
    if (isdefined(level.var_b57c1895)) {
        return [[ level.var_b57c1895 ]](origin, angles, player);
    }
    return 1;
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0x8f1028fb, Offset: 0x1b10
// Size: 0x1d0
function function_a47ce1c2(player) {
    var_b43e8dc2 = player function_287dcf4b(level.smartcoversettings.bundle.var_63aab046, level.smartcoversettings.bundle.maxwidth, 1, 1, level.smartcoversettings.smartcoverweapon);
    player.smartcover.lastvalid = var_b43e8dc2;
    var_9e596670 = 0;
    if (isdefined(var_b43e8dc2) && isdefined(var_b43e8dc2.origin)) {
        var_9e596670 = function_bf4c81d2(var_b43e8dc2.origin, level.smartcoversettings.var_ff1a491d);
    }
    var_2b68b641 = function_54267517(var_b43e8dc2.origin);
    candeploy = isdefined(var_b43e8dc2) && var_b43e8dc2.isvalid && !var_9e596670 && !var_2b68b641;
    if (candeploy && (isdefined(var_b43e8dc2.width) ? var_b43e8dc2.width : 0) >= level.smartcoversettings.bundle.maxwidth) {
        player function_bf191832(candeploy, var_b43e8dc2.origin, var_b43e8dc2.angles);
    } else {
        player function_bf191832(candeploy, (0, 0, 0), (0, 0, 0));
    }
    return var_b43e8dc2;
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0x5dbd0685, Offset: 0x1ce8
// Size: 0xe8
function function_408a9ea8(var_bf2bf1a) {
    var_bf2bf1a endon(#"death");
    var_bf2bf1a useanimtree("generic");
    var_bf2bf1a setanim(level.smartcoversettings.bundle.deployanim);
    animtime = 0;
    while (animtime < 1) {
        var_bf2bf1a clientfield::set("smartcover_placed", 1 - animtime);
        animtime = var_bf2bf1a getanimtime(level.smartcoversettings.bundle.deployanim);
        waitframe(1);
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0xa1326bd, Offset: 0x1dd8
// Size: 0x2f8
function function_548a710a(traceresults) {
    if (!traceresults.var_e2543923 && !traceresults.var_e18fd6c3) {
        return traceresults.origin;
    }
    halfwidth = level.smartcoversettings.bundle.maxwidth * 0.5;
    var_93cd60ae = halfwidth * halfwidth;
    var_b80b6889 = distance2d(traceresults.origin, traceresults.var_c0e006dc);
    var_65ea35de = distance2d(traceresults.origin, traceresults.var_44cf251d);
    if (traceresults.var_e2543923 && traceresults.var_e18fd6c3) {
        pointright = traceresults.var_c0e006dc;
        pointleft = traceresults.var_44cf251d;
    } else if (traceresults.var_e2543923 && var_b80b6889 < halfwidth) {
        pointright = traceresults.var_c0e006dc;
        directionleft = vectornormalize(traceresults.var_44cf251d - traceresults.var_c0e006dc);
        pointleft = traceresults.var_c0e006dc + level.smartcoversettings.bundle.maxwidth * directionleft;
    } else if (traceresults.var_e2543923 && var_b80b6889 >= halfwidth) {
        return traceresults.origin;
    } else if (traceresults.var_e18fd6c3 && var_65ea35de < halfwidth) {
        pointleft = traceresults.var_44cf251d;
        directionright = vectornormalize(traceresults.var_c0e006dc - traceresults.var_44cf251d);
        pointright = traceresults.var_44cf251d + level.smartcoversettings.bundle.maxwidth * directionright;
    } else if (traceresults.var_e18fd6c3 && var_65ea35de >= halfwidth) {
        return traceresults.origin;
    }
    direction = vectornormalize(pointright - pointleft);
    origin = (pointleft[0], pointleft[1], traceresults.origin[2]) + level.smartcoversettings.bundle.maxwidth * 0.5 * direction;
    return origin;
}

// Namespace smart_cover/gadget_smart_cover
// Params 2, eflags: 0x0
// Checksum 0xbc1955cb, Offset: 0x20d8
// Size: 0x38c
function function_3b96637(watcher, owner) {
    self endon(#"death");
    player = owner;
    self.canthack = 1;
    self.delete_on_death = 1;
    self hide();
    if (!isdefined(player.smartcover.lastvalid) || !player.smartcover.lastvalid.isvalid) {
        player deployable::function_416f03e6(level.smartcoversettings.smartcoverweapon);
        return;
    }
    profilestart();
    var_bf2bf1a = player createsmartcover(watcher, self, player.smartcover.lastvalid.var_83050ca1, player.smartcover.lastvalid.angles, 1);
    profilestop();
    var_bf2bf1a.var_48d842c3 = 1;
    var_bf2bf1a.var_515d6dda = 1;
    var_bf2bf1a.angles = player.angles;
    var_bf2bf1a.var_8120c266 = [];
    var_bf2bf1a.var_9a3bd50f = 0;
    array::add(player.smartcover.var_19e1ea69, var_bf2bf1a);
    var_26c9fcc2 = function_57f553e9(player.smartcover.var_19e1ea69, level.smartcoversettings.bundle.var_a0b69d8b);
    if (isdefined(var_26c9fcc2)) {
        var_26c9fcc2 function_2a494565(1);
    }
    if (isdefined(level.onsmartcoverplaced)) {
        owner [[ level.onsmartcoverplaced ]](self);
    }
    if (isdefined(level.smartcoversettings.bundle.deployanim)) {
        thread function_408a9ea8(var_bf2bf1a);
    }
    if (isdefined(level.smartcoversettings.bundle.var_ad7084b4) ? level.smartcoversettings.bundle.var_ad7084b4 : 0) {
        player clientfield::set_player_uimodel("huditems.abilityHoldToActivate", 2);
    }
    var_bf2bf1a.var_40bfd9cf = var_bf2bf1a influencers::create_entity_enemy_influencer("turret_close", owner.team);
    var_bf2bf1a util::make_sentient();
    if (isdefined(level.smartcoversettings.smartcoverweapon.var_414fa79e)) {
        player playrumbleonentity(level.smartcoversettings.smartcoverweapon.var_414fa79e);
    }
    thread function_7ecb04ff(player);
    var_bf2bf1a thread function_670cd4a3();
    var_bf2bf1a thread function_b397b517();
}

// Namespace smart_cover/gadget_smart_cover
// Params 0, eflags: 0x0
// Checksum 0x3c9f4770, Offset: 0x2470
// Size: 0x80
function function_670cd4a3() {
    self endon(#"death");
    self.var_19fde5b7 = [];
    while (true) {
        waitresult = self waittill(#"grenade_stuck");
        if (isdefined(waitresult.projectile)) {
            array::add(self.var_19fde5b7, waitresult.projectile);
        }
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0x521de815, Offset: 0x24f8
// Size: 0x5a
function function_21e722f6(watcher) {
    watcher.watchforfire = 1;
    watcher.onspawn = &function_3b96637;
    watcher.var_994b472b = &function_46f4e542;
    watcher.var_10efd558 = "switched_field_upgrade";
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0x7ac7e226, Offset: 0x2560
// Size: 0x34
function function_46f4e542(*player) {
    if (isdefined(self.smartcover)) {
        self.smartcover thread function_2a494565(1);
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 0, eflags: 0x0
// Checksum 0x25be6cd, Offset: 0x25a0
// Size: 0xbc
function function_37f1dcd1() {
    level endon(#"game_ended");
    self.owner endon(#"disconnect", #"joined_team", #"changed_specialist", #"hacked");
    self endon(#"hash_5de1fc3780ea0eaa");
    waitresult = self waittill(#"death");
    if (!isdefined(self)) {
        return;
    }
    self thread onkilled(waitresult);
}

// Namespace smart_cover/gadget_smart_cover
// Params 0, eflags: 0x0
// Checksum 0xb33344ef, Offset: 0x2668
// Size: 0xf8
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
// Params 2, eflags: 0x0
// Checksum 0x4a566329, Offset: 0x2768
// Size: 0x44
function function_375cfa56(smartcover, owner) {
    if (isdefined(owner)) {
        arrayremovevalue(owner.smartcover.var_19e1ea69, smartcover);
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0x319be76, Offset: 0x27b8
// Size: 0x544
function function_2a494565(isselfdestruct) {
    smartcover = self;
    smartcover notify(#"hash_5de1fc3780ea0eaa");
    smartcover clientfield::set("enemyequip", 0);
    smartcover clientfield::set("friendlyequip", 0);
    if (isdefined(smartcover.objectiveid)) {
        objective_delete(smartcover.objectiveid);
        gameobjects::release_obj_id(smartcover.objectiveid);
    }
    smartcover function_9813d292();
    if (isdefined(level.smartcoversettings.bundle.var_35fbc280)) {
        if (is_true(isselfdestruct)) {
            var_415135a0 = level.smartcoversettings.bundle.var_28811698;
            var_72db9941 = level.smartcoversettings.bundle.var_5493f8b0;
        } else {
            var_415135a0 = level.smartcoversettings.bundle.var_35fbc280;
            var_72db9941 = level.smartcoversettings.bundle.var_b3756378;
        }
        var_b0e81be9 = isdefined(self gettagorigin("tag_cover_base_d0")) ? self gettagorigin("tag_cover_base_d0") : self.origin;
        var_505e3308 = isdefined(self gettagangles("tag_cover_base_d0")) ? self gettagangles("tag_cover_base_d0") : self.angles;
        var_8fec56c4 = anglestoforward(var_505e3308);
        var_61753233 = anglestoup(var_505e3308);
        playfx(var_415135a0, var_b0e81be9, var_8fec56c4, var_61753233);
        if (isdefined(var_72db9941)) {
            smartcover playsound(var_72db9941);
        }
    }
    if (isdefined(level.smartcoversettings.bundle.var_bb6c29b4) && isdefined(self.var_d02ddb8e) && self.var_d02ddb8e == getweapon(#"shock_rifle")) {
        playfx(level.smartcoversettings.bundle.var_bb6c29b4, smartcover.origin);
    }
    removeindex = -1;
    arrayremovevalue(level.smartcoversettings.var_f115c746, smartcover);
    if (isdefined(smartcover.owner)) {
        arrayremovevalue(smartcover.owner.smartcover.var_58e8b64d, smartcover);
        arrayremovevalue(smartcover.owner.smartcover.var_19e1ea69, smartcover);
    }
    if (is_true(level.smartcoversettings.bundle.var_f4e0e7d7)) {
        smartcover stopmicrowave();
        smartcover notify(#"microwave_turret_shutdown");
    }
    if (isdefined(smartcover.owner)) {
        smartcover.owner globallogic_score::function_d3ca3608(#"hash_78cb6a053f51a857");
    }
    deployable::function_81598103(smartcover);
    if (isdefined(smartcover.killcament)) {
        smartcover.killcament thread util::deleteaftertime(5);
    }
    if (isdefined(smartcover.grenade)) {
        smartcover.grenade thread util::deleteaftertime(1);
    }
    if (isdefined(smartcover.trigger)) {
        smartcover.trigger delete();
    }
    if (isdefined(smartcover.var_2d045452)) {
        smartcover.var_2d045452 delete();
    }
    smartcover deletedelay();
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0x560224a9, Offset: 0x2d08
// Size: 0x174
function onkilled(var_c946c04c) {
    smartcover = self;
    if (isdefined(var_c946c04c.attacker) && var_c946c04c.attacker != smartcover.owner) {
        smartcover.owner globallogic_score::function_5829abe3(var_c946c04c.attacker, var_c946c04c.weapon, smartcover.weapon);
        self battlechatter::function_d2600afc(var_c946c04c.attacker, smartcover.owner, smartcover.weapon, var_c946c04c.weapon);
        if (isdefined(self.owner)) {
            var_f3ab6571 = self.owner weaponobjects::function_8481fc06(smartcover.weapon) > 1;
            smartcover.owner thread globallogic_audio::function_6daffa93(smartcover.weapon, var_f3ab6571);
        }
    }
    smartcover.var_d02ddb8e = var_c946c04c.weapon;
    if (isdefined(level.var_a430cceb)) {
        smartcover [[ level.var_a430cceb ]](var_c946c04c.attacker, smartcover.var_d02ddb8e);
    }
    smartcover thread function_2a494565(0);
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0x84c36534, Offset: 0x2e88
// Size: 0x5e
function function_884d0700(*var_796be15d) {
    return self.team == #"allies" ? level.smartcoversettings.bundle.var_ee0c73a5 : level.smartcoversettings.bundle.var_d3ea02d6;
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0xb7e1ef90, Offset: 0x2ef0
// Size: 0x5e
function getmodel(*var_796be15d) {
    return self.team == #"allies" ? level.smartcoversettings.bundle.var_397ed90c : level.smartcoversettings.bundle.var_b256e3da;
}

// Namespace smart_cover/gadget_smart_cover
// Params 12, eflags: 0x0
// Checksum 0x484a1e33, Offset: 0x2f58
// Size: 0x1c2
function function_d2368084(*einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, *vpoint, *vdir, *shitloc, *psoffsettime, *iboneindex, *imodelindex) {
    bundle = getscriptbundle("killstreak_smart_cover");
    startinghealth = isdefined(self.startinghealth) ? self.startinghealth : 0;
    if ((isdefined(self.health) ? self.health : 0) < startinghealth * 0.5 && !(self.var_2cf2e843 === 1) && isdefined(self.owner) && isplayer(self.owner) && !(vdir === self.owner)) {
        self.owner thread namespace_f9b02f80::play_taacom_dialog("smartCoverWeaponDamaged");
        self.var_2cf2e843 = 1;
    }
    finaldamage = killstreak_bundles::function_dd7587e4(bundle, startinghealth, vdir, imodelindex, iboneindex, shitloc, psoffsettime);
    if (!isdefined(finaldamage)) {
        finaldamage = killstreaks::get_old_damage(vdir, imodelindex, iboneindex, shitloc, 1);
    }
    return int(finaldamage);
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0x8cd0edc6, Offset: 0x3128
// Size: 0x204
function function_20be77a3(smartcover) {
    smartcover.var_eda9690f = [];
    forwardangles = anglestoforward(smartcover.angles);
    rightangles = anglestoright(smartcover.angles);
    var_526ec5aa = smartcover.origin + (0, 0, 1) * getdvarfloat(#"hash_4d17057924212aa9", 1);
    smartcover.var_eda9690f[smartcover.var_eda9690f.size] = var_526ec5aa + forwardangles * getdvarfloat(#"hash_477cc29b988c0b75", 1);
    smartcover.var_eda9690f[smartcover.var_eda9690f.size] = smartcover.var_eda9690f[0] + (0, 0, 1) * getdvarfloat(#"hash_41cfd0e34c53ef02", 1);
    backpoint = var_526ec5aa + forwardangles * getdvarfloat(#"hash_7f893c50ae5356c8", 1);
    smartcover.var_eda9690f[smartcover.var_eda9690f.size] = backpoint + rightangles * getdvarfloat(#"hash_70ce44b2b0b4005", 1);
    smartcover.var_eda9690f[smartcover.var_eda9690f.size] = backpoint - rightangles * getdvarfloat(#"hash_70ce44b2b0b4005", 1);
}

// Namespace smart_cover/gadget_smart_cover
// Params 0, eflags: 0x4
// Checksum 0x729ca0c3, Offset: 0x3338
// Size: 0x3c
function private function_9813d292() {
    if (isdefined(self)) {
        badplace_delete("smart_cover_badplace" + self getentitynumber());
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x4
// Checksum 0xee1d3352, Offset: 0x3380
// Size: 0x11c
function private function_d2d0a813(var_24e0878b) {
    var_3b0688ef = "smart_cover_badplace" + self getentitynumber();
    var_2c0980ab = self.origin + self getboundsmidpoint();
    var_e5afa076 = self getboundshalfsize();
    var_921c5821 = max(var_e5afa076[0], var_e5afa076[1]) + 5;
    var_e5afa076 = (var_921c5821, var_921c5821, var_e5afa076[2]);
    if (var_24e0878b === 1) {
        badplace_cylinder(var_3b0688ef, 0, var_2c0980ab, var_921c5821, var_e5afa076[2] * 2, "all");
        return;
    }
    badplace_box(var_3b0688ef, 0, var_2c0980ab, var_e5afa076, "all");
}

// Namespace smart_cover/gadget_smart_cover
// Params 5, eflags: 0x0
// Checksum 0xaa6b9987, Offset: 0x34a8
// Size: 0x670
function createsmartcover(watcher, var_5ebbec19, origin, angles, var_796be15d) {
    player = self;
    var_89b6fd44 = spawn("script_model", origin);
    var_89b6fd44.targetname = "smart_cover";
    var_5ebbec19.smartcover = var_89b6fd44;
    var_89b6fd44.grenade = var_5ebbec19;
    var_89b6fd44 setmodel(player getmodel(var_796be15d));
    var_89b6fd44.var_2d045452 = var_5ebbec19;
    var_c6f47ca9 = getdvarint(#"hash_1d8eb304f5cf8033", 0);
    if (var_c6f47ca9 == 1) {
        var_89b6fd44 function_41b29ff0(player function_884d0700(var_796be15d));
    }
    var_89b6fd44.angles = angles;
    var_89b6fd44.owner = player;
    var_89b6fd44.takedamage = 1;
    var_89b6fd44.startinghealth = isdefined(level.smartcoversettings.bundle.var_4d358e2d) ? level.smartcoversettings.bundle.var_4d358e2d : var_796be15d ? isdefined(level.smartcoversettings.bundle.var_d9317c6b) ? level.smartcoversettings.bundle.var_d9317c6b : 100 : 100;
    var_89b6fd44.health = var_89b6fd44.startinghealth;
    var_89b6fd44 solid();
    var_89b6fd44 function_d2d0a813();
    var_89b6fd44 setteam(player getteam());
    var_89b6fd44.var_86a21346 = &function_d2368084;
    var_89b6fd44.weapon = level.smartcoversettings.smartcoverweapon;
    var_89b6fd44 setweapon(var_89b6fd44.weapon);
    player.smartcover.var_58e8b64d[player.smartcover.var_58e8b64d.size] = var_89b6fd44;
    var_c892a9a = var_796be15d ? level.smartcoversettings.var_546a220c : level.smartcoversettings.var_ac3f76c7;
    if (isdefined(var_c892a9a)) {
        var_89b6fd44.objectiveid = gameobjects::get_next_obj_id();
        objective_add(var_89b6fd44.objectiveid, "active", var_89b6fd44, var_c892a9a);
        function_6da98133(var_89b6fd44.objectiveid);
        objective_setteam(var_89b6fd44.objectiveid, player.team);
    }
    var_9d063af9 = player gadgetgetslot(level.smartcoversettings.smartcoverweapon);
    if (!sessionmodeiswarzonegame()) {
        self gadgetpowerset(var_9d063af9, 0);
    }
    var_89b6fd44 setteam(player.team);
    array::add(level.smartcoversettings.var_f115c746, var_89b6fd44);
    function_20be77a3(var_89b6fd44);
    var_89b6fd44 clientfield::set("friendlyequip", 1);
    var_89b6fd44 clientfield::set("enemyequip", 1);
    var_89b6fd44.var_24ac884b = 1;
    var_89b6fd44 thread ondamage();
    var_89b6fd44 thread function_37f1dcd1();
    thread function_18dd6b22(var_89b6fd44);
    player deployable::function_6ec9ee30(var_89b6fd44, level.smartcoversettings.smartcoverweapon);
    var_89b6fd44.victimsoundmod = "vehicle";
    if (is_true(level.smartcoversettings.bundle.var_f4e0e7d7)) {
        var_89b6fd44 thread startmicrowave();
    }
    killcament = spawn("script_model", var_89b6fd44.origin + (isdefined(level.smartcoversettings.bundle.var_eb9150a5) ? level.smartcoversettings.bundle.var_eb9150a5 : 0, isdefined(level.smartcoversettings.bundle.var_26a346c8) ? level.smartcoversettings.bundle.var_26a346c8 : 0, isdefined(level.smartcoversettings.bundle.var_d0fb9b7a) ? level.smartcoversettings.bundle.var_d0fb9b7a : 0));
    killcament.targetname = "smart_cover_killcament";
    var_89b6fd44.killcament = killcament;
    watcher.objectarray[watcher.objectarray.size] = killcament;
    return var_89b6fd44;
}

// Namespace smart_cover/gadget_smart_cover
// Params 2, eflags: 0x0
// Checksum 0xfd2789c7, Offset: 0x3b20
// Size: 0xfc
function function_127fb8f3(smartcover, attackingplayer) {
    if (!is_true(smartcover.smartcoverjammed)) {
        smartcover stopmicrowave();
        smartcover clientfield::set("enemyequip", 0);
    }
    smartcover.smartcoverjammed = 1;
    if (isdefined(level.var_86e3d17a)) {
        smartcover notify(#"cancel_timeout");
        var_77b9f495 = [[ level.var_86e3d17a ]]();
        smartcover thread function_b397b517(var_77b9f495);
    }
    if (isdefined(level.var_1794f85f)) {
        [[ level.var_1794f85f ]](attackingplayer, "disrupted_barricade");
    }
    return true;
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0xcc4033ed, Offset: 0x3c28
// Size: 0x98
function function_18dd6b22(smartcover) {
    level endon(#"game_ended");
    smartcover endon(#"death");
    while (true) {
        waitresult = smartcover waittill(#"broken");
        if (waitresult.type == "base_piece_broken") {
            smartcover function_2a494565(0);
        }
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 2, eflags: 0x0
// Checksum 0x7b0af91d, Offset: 0x3cc8
// Size: 0xc6
function function_bf4c81d2(origin, maxdistancesq) {
    foreach (smartcover in level.smartcoversettings.var_f115c746) {
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
// Checksum 0xf703ecf2, Offset: 0x3d98
// Size: 0x84
function watchweaponchange() {
    player = self;
    self notify(#"watchweaponchange_singleton");
    self endon(#"watchweaponchange_singleton");
    while (true) {
        if (self weaponswitchbuttonpressed()) {
            if (isdefined(player.smartcover)) {
                player.smartcover.var_5af6633b = 1;
            }
        }
        waitframe(1);
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 2, eflags: 0x0
// Checksum 0x8fb6b8ed, Offset: 0x3e28
// Size: 0x70
function function_57f553e9(&coverlist, maxallowed) {
    if (coverlist.size <= maxallowed) {
        return undefined;
    }
    outstayed_spawner = array::pop_front(coverlist, 0);
    arrayremovevalue(coverlist, undefined, 0);
    return outstayed_spawner;
}

// Namespace smart_cover/gadget_smart_cover
// Params 5, eflags: 0x0
// Checksum 0x837a3ff8, Offset: 0x3ea0
// Size: 0x34e
function function_92112113(attacker, victim, weapon, attackerweapon, *meansofdeath) {
    if (!isdefined(level.smartcoversettings) || !isdefined(level.smartcoversettings.var_f115c746) || !isdefined(weapon) || !isdefined(victim) || !isdefined(meansofdeath) || !isdefined(attackerweapon)) {
        return false;
    }
    if (isdefined(level.iskillstreakweapon) && [[ level.iskillstreakweapon ]](meansofdeath) || meansofdeath == attackerweapon) {
        return false;
    }
    foreach (smartcover in level.smartcoversettings.var_f115c746) {
        if (!isdefined(smartcover)) {
            continue;
        }
        if (!isdefined(weapon) || !isdefined(weapon.team) || !isdefined(smartcover.owner)) {
            continue;
        }
        if (weapon == smartcover.owner || level.teambased && !util::function_fbce7263(weapon.team, smartcover.owner.team)) {
            continue;
        }
        var_583e1573 = distancesquared(smartcover.origin, victim.origin);
        if (var_583e1573 > level.smartcoversettings.var_357db326) {
            continue;
        }
        var_eb870c = distancesquared(weapon.origin, smartcover.origin);
        var_ae30f518 = distancesquared(weapon.origin, victim.origin);
        var_d9ecf725 = var_ae30f518 > var_583e1573;
        var_1d1ca33b = var_ae30f518 > var_eb870c;
        if (var_d9ecf725 && var_1d1ca33b) {
            var_a3aba5a9 = 1;
            var_71eedb0b = smartcover.owner;
            break;
        }
    }
    if (isdefined(var_71eedb0b) && isdefined(var_a3aba5a9) && var_a3aba5a9) {
        if (smartcover.owner == victim) {
            return true;
        } else {
            scoreevents::processscoreevent(#"deployable_cover_assist", var_71eedb0b, weapon, level.smartcoversettings.smartcoverweapon);
        }
    }
    return false;
}

// Namespace smart_cover/gadget_smart_cover
// Params 3, eflags: 0x4
// Checksum 0xf7f4d572, Offset: 0x41f8
// Size: 0x2aa
function private function_4e6d9621(smartcover, origins, radii) {
    assert(isarray(origins));
    assert(!isarray(radii) || origins.size == radii.size);
    assert(isdefined(smartcover.var_eda9690f) && smartcover.var_eda9690f.size > 0);
    foreach (var_592587c3 in smartcover.var_eda9690f) {
        for (index = 0; index < origins.size; index++) {
            distance = distancesquared(origins[index], var_592587c3);
            radius = isarray(radii) ? radii[index] : radii;
            combinedradius = radius + getdvarfloat(#"hash_4d17057924212aa9", 1);
            if (getdvarint(#"hash_686a676b28ae0af4", 0) == 1) {
                /#
                    sphere(origins[index], radius, (0, 0, 1), 0.5, 0, 10, 500);
                    sphere(var_592587c3, getdvarfloat(#"hash_4d17057924212aa9", 1), (1, 0, 0), 0.5, 0, 10, 500);
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
// Checksum 0x7a61c4f9, Offset: 0x44b0
// Size: 0xda
function function_e3a901c(origins, radii) {
    if (!isdefined(level.smartcoversettings.var_f115c746)) {
        return false;
    }
    foreach (smartcover in level.smartcoversettings.var_f115c746) {
        if (!isdefined(smartcover)) {
            continue;
        }
        if (function_4e6d9621(smartcover, origins, radii)) {
            return true;
        }
    }
    return false;
}

// Namespace smart_cover/gadget_smart_cover
// Params 0, eflags: 0x0
// Checksum 0x8f5a13c4, Offset: 0x4598
// Size: 0x16
function reset_being_microwaved() {
    self.lastmicrowavedby = undefined;
    self.beingmicrowavedby = undefined;
}

// Namespace smart_cover/gadget_smart_cover
// Params 0, eflags: 0x0
// Checksum 0xa10e9181, Offset: 0x45b8
// Size: 0x18c
function startmicrowave() {
    if (isdefined(self.trigger)) {
        self.trigger delete();
    }
    self clientfield::set("start_smartcover_microwave", 1);
    self.trigger = spawn("trigger_radius", self.origin + (0, 0, (isdefined(level.smartcoversettings.bundle.var_b345c668) ? level.smartcoversettings.bundle.var_b345c668 : 0) * -1), 4096 | 16384 | level.aitriggerspawnflags | level.vehicletriggerspawnflags, isdefined(level.smartcoversettings.bundle.var_b345c668) ? level.smartcoversettings.bundle.var_b345c668 : 0, (isdefined(level.smartcoversettings.bundle.var_b345c668) ? level.smartcoversettings.bundle.var_b345c668 : 0) * 2);
    self thread turretthink();
    /#
        self thread turretdebugwatch();
    #/
}

// Namespace smart_cover/gadget_smart_cover
// Params 0, eflags: 0x0
// Checksum 0x4f75337c, Offset: 0x4750
// Size: 0xae
function stopmicrowave() {
    if (!isdefined(self)) {
        return;
    }
    self playsound(#"mpl_microwave_beam_off");
    if (self getentitytype() == 6) {
        self clientfield::set("start_smartcover_microwave", 0);
    }
    if (isdefined(self.trigger)) {
        self.trigger delete();
    }
    /#
        self notify(#"stop_turret_debug");
    #/
}

// Namespace smart_cover/gadget_smart_cover
// Params 0, eflags: 0x0
// Checksum 0x3064652f, Offset: 0x4808
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
// Checksum 0x615803b, Offset: 0x4890
// Size: 0x174
function turretdebug() {
    turret = self;
    angles = turret gettagangles("tag_flash");
    origin = turret gettagorigin("tag_flash");
    cone_apex = origin;
    forward = anglestoforward(angles);
    dome_apex = cone_apex + vectorscale(forward, isdefined(level.smartcoversettings.bundle.var_b345c668) ? level.smartcoversettings.bundle.var_b345c668 : 0);
    /#
        util::debug_spherical_cone(cone_apex, dome_apex, isdefined(level.smartcoversettings.bundle.var_cbd5f27c) ? level.smartcoversettings.bundle.var_cbd5f27c : 0, 16, (0.95, 0.1, 0.1), 0.3, 1, 3);
    #/
}

// Namespace smart_cover/gadget_smart_cover
// Params 0, eflags: 0x0
// Checksum 0x73dbb4e7, Offset: 0x4a10
// Size: 0x138
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
        if (turret microwaveturretaffectsentity(ent) && !isdefined(ent.beingmicrowavedby[turret.turret_vehicle_entnum])) {
            turret thread microwaveentity(ent);
        }
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0xe310bd20, Offset: 0x4b50
// Size: 0xc0
function microwaveentitypostshutdowncleanup(entity) {
    entity endon(#"disconnect", #"end_microwaveentitypostshutdowncleanup");
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
// Checksum 0x4956d138, Offset: 0x4c18
// Size: 0x7f0
function microwaveentity(entity) {
    turret = self;
    turret endon(#"microwave_turret_shutdown", #"death");
    entity endon(#"disconnect", #"death");
    if (isplayer(entity)) {
        entity endon(#"joined_team", #"joined_spectators");
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
    if (getgametypesetting(#"competitivesettings") === 1) {
        var_756fda07 = getstatuseffect(#"hash_4571e9bb8d1be2af");
        var_2b29cf8c = getstatuseffect(#"hash_13ef8ef2acaa9aec");
    } else {
        var_756fda07 = getstatuseffect(#"microwave_slowed");
        var_2b29cf8c = getstatuseffect(#"microwave_dot");
    }
    turret_vehicle_entnum = turret.turret_vehicle_entnum;
    var_2b29cf8c.killcament = turret;
    while (true) {
        if (!isdefined(turret) || !isdefined(turret.trigger) || !turret microwaveturretaffectsentity(entity)) {
            if (!isdefined(entity)) {
                return;
            }
            if (isdefined(entity.beingmicrowavedby[turret_vehicle_entnum])) {
                entity thread status_effect::function_408158ef(var_756fda07.setype, var_756fda07.var_18d16a6b);
                entity thread status_effect::function_408158ef(var_2b29cf8c.setype, var_2b29cf8c.var_18d16a6b);
                if (isdefined(entity.var_553267c8)) {
                    entity stoprumble(entity.var_553267c8);
                    entity.var_553267c8 = undefined;
                }
            }
            entity.beingmicrowavedby[turret_vehicle_entnum] = undefined;
            if (isdefined(entity.microwavepoisoning) && entity.microwavepoisoning) {
                entity.microwavepoisoning = 0;
            }
            entity notify(#"end_microwaveentitypostshutdowncleanup");
            return;
        }
        damage = (isdefined(level.smartcoversettings.bundle.var_d2369c5a) ? level.smartcoversettings.bundle.var_d2369c5a : 0) * damagescalar;
        if (level.hardcoremode) {
            damage *= isdefined(level.smartcoversettings.bundle.var_78c1e37b) ? level.smartcoversettings.bundle.var_78c1e37b : 0.25;
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
        entity thread status_effect::status_effect_apply(var_2b29cf8c, level.smartcoversettings.smartcoverweapon, self, 0);
        entity.microwaveeffect++;
        entity.lastmicrowavedby = turret.owner;
        time = gettime();
        if (isplayer(entity) && isdefined(entity.clientid)) {
            entity playsoundtoplayer(#"hash_5eecc78116b1fc85", entity);
            if (!entity isremotecontrolling() && time - (isdefined(entity.microwaveshellshockandviewkicktime) ? entity.microwaveshellshockandviewkicktime : 0) > 950) {
                if (entity.microwaveeffect % 2 == 1) {
                    entity viewkick(int(25 * viewkickscalar), turret.origin);
                    entity.microwaveshellshockandviewkicktime = time;
                    entity thread status_effect::status_effect_apply(var_756fda07, level.smartcoversettings.smartcoverweapon, self, 0);
                    var_83cd8106 = level.smartcoversettings.bundle.var_5223868e;
                    if (isdefined(var_83cd8106)) {
                        entity playrumbleonentity(var_83cd8106);
                        entity.var_553267c8 = var_83cd8106;
                    }
                }
            }
            if (!isdefined(turret.playersdamaged)) {
                turret.playersdamaged = [];
            }
            turret.playersdamaged[entity.clientid] = 1;
            if (!(isdefined(level.smartcoversettings.bundle.var_74dcfa31) ? level.smartcoversettings.bundle.var_74dcfa31 : 0) && entity.microwaveeffect % 3 == 2) {
                scoreevents::processscoreevent(#"hpm_suppress", turret.owner, entity, level.smartcoversettings.smartcoverweapon, turret.playersdamaged.size);
            }
        }
        wait 0.5;
    }
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0x36269652, Offset: 0x5410
// Size: 0x49a
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
    if ((isdefined(level.smartcoversettings.bundle.var_7ba68eb6) ? level.smartcoversettings.bundle.var_7ba68eb6 : 0) > 0 && entity.origin[2] > turret.origin[2] + level.smartcoversettings.bundle.var_7ba68eb6) {
        return false;
    }
    if (distancesquared(entity.origin, turret.origin) > (isdefined(level.smartcoversettings.bundle.var_b345c668) ? level.smartcoversettings.bundle.var_b345c668 : 0) * (isdefined(level.smartcoversettings.bundle.var_b345c668) ? level.smartcoversettings.bundle.var_b345c668 : 0)) {
        return false;
    }
    angles = turret getangles();
    realorigin = turret.origin + (0, 0, 30);
    forward = anglestoforward(angles);
    origin = realorigin - forward * 50;
    shoot_at_pos = entity getshootatpos(turret);
    var_29d7e93f = vectornormalize(shoot_at_pos - realorigin);
    var_2d95367c = vectordot(var_29d7e93f, forward);
    if (var_2d95367c < 0) {
        return false;
    }
    entdirection = vectornormalize(shoot_at_pos - origin);
    dot = vectordot(entdirection, forward);
    if (dot < cos(isdefined(level.smartcoversettings.bundle.var_cbd5f27c) ? level.smartcoversettings.bundle.var_cbd5f27c : 0)) {
        return false;
    }
    if (entity damageconetrace(origin, turret, forward) <= 0) {
        return false;
    }
    return true;
}

