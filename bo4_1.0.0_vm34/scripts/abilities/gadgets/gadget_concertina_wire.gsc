#using scripts\abilities\ability_player;
#using scripts\abilities\gadgets\gadget_smart_cover;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\killstreaks\killstreak_bundles;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\weapons\deployable;
#using scripts\weapons\weapon_utils;
#using scripts\weapons\weaponobjects;

#namespace concertina_wire;

// Namespace concertina_wire/gadget_concertina_wire
// Params 1, eflags: 0x0
// Checksum 0x3bee7b13, Offset: 0x268
// Size: 0x2e4
function init_shared(var_a9bc8d6e) {
    level.var_a33e1621 = spawnstruct();
    level.var_a33e1621.bundle = getscriptbundle(var_a9bc8d6e);
    level.var_a33e1621.concertinawireweapon = getweapon(#"eq_concertina_wire");
    level.var_a33e1621.var_bdc049de = "concertina_wire_objective_default";
    level.var_a33e1621.var_b2cf3d75 = [];
    setdvar(#"hash_430cc236fe8b2561", 8);
    ability_player::register_gadget_should_notify(37, 1);
    weaponobjects::function_f298eae6(#"eq_concertina_wire", &function_36433f52, 1);
    callback::on_spawned(&on_player_spawned);
    callback::on_player_killed_with_params(&onplayerkilled);
    deployable::register_deployable(level.var_a33e1621.concertinawireweapon, undefined, &function_d90c4119, undefined, undefined, 1);
    level.var_a33e1621.var_bee3c05a = 10000;
    clientfield::register("scriptmover", "concertinaWire_placed", 1, 5, "float");
    clientfield::register("scriptmover", "concertinaWireDestroyed", 1, 1, "int");
    clientfield::register("scriptmover", "concertinaWireDroopyBits", 1, 3, "int");
    level.var_a33e1621.var_4a83e2d2 = level.var_a33e1621.bundle.var_8dd8c6b1 * level.var_a33e1621.bundle.var_8dd8c6b1;
    level.var_a33e1621.bucklerweapon = getweapon(#"sig_buckler_turret");
    setdvar(#"hash_753335900deb89ea", 25);
    thread function_e435e7e0();
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 5, eflags: 0x0
// Checksum 0xfaa3f291, Offset: 0x558
// Size: 0xcc
function function_5fc00d5a(attacker, victim, weapon, attackerweapon, meansofdeath) {
    if (!isdefined(victim) || !isdefined(victim.var_d587776e) || (isdefined(victim.var_8042b500) ? victim.var_8042b500 : 0) + 500 < gettime()) {
        return false;
    }
    if (isdefined(attacker) && (!isdefined(victim.var_d587776e.owner) || attacker != victim.var_d587776e.owner)) {
        return false;
    }
    return true;
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 1, eflags: 0x0
// Checksum 0x43abcfb0, Offset: 0x630
// Size: 0x424
function onplayerkilled(s_params) {
    if (!isdefined(s_params.weapon)) {
        return;
    }
    if (!function_5fc00d5a(s_params.eattacker, self)) {
        return;
    }
    if (s_params.weapon != level.var_a33e1621.concertinawireweapon) {
        killstreaks::processscoreevent(#"concertina_wire_snared_kill", s_params.eattacker, self, level.var_a33e1621.concertinawireweapon);
    }
    if (s_params.weapon != level.var_a33e1621.concertinawireweapon) {
        return;
    }
    weapon = s_params.weapon;
    var_ecff4b29 = isdefined(self.var_d587776e.owner) ? self.var_d587776e.owner == s_params.eattacker : 0;
    if (!isdefined(s_params.eattacker) || !isplayer(s_params.eattacker)) {
        return;
    }
    var_3ef79bd = s_params.eattacker loadout::function_3d8b02a0("primarygrenade");
    var_ce93f3d1 = s_params.eattacker loadout::function_3d8b02a0("specialgrenade");
    ultimateweapon = s_params.eattacker loadout::function_3d8b02a0("ultimate");
    var_5ad8def5 = 0;
    if (isdefined(var_3ef79bd) && var_3ef79bd.statname == weapon.statname || isdefined(var_ce93f3d1) && var_ce93f3d1.statname == weapon.statname || isdefined(ultimateweapon) && ultimateweapon.statname == weapon.statname) {
        var_5ad8def5 = 1;
    }
    if (var_5ad8def5) {
        killstreaks::processscoreevent(#"hash_152856ae19af395b", self.var_d587776e.owner, self, level.var_a33e1621.concertinawireweapon);
    }
    if (var_ecff4b29) {
        relativepos = vectornormalize(self.origin - s_params.eattacker.origin);
        dir = anglestoforward(s_params.eattacker getplayerangles());
        dotproduct = vectordot(dir, relativepos);
        if (dotproduct > 0 && sighttracepassed(s_params.eattacker geteye(), self geteye(), 1, s_params.eattacker, self)) {
            s_params.eattacker [[ level.playgadgetsuccess ]](level.var_a33e1621.concertinawireweapon, undefined, self, undefined);
        }
    }
    if (isdefined(self.var_d587776e.owner)) {
        self.var_d587776e.owner thread function_71cd592b();
    }
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 1, eflags: 0x0
// Checksum 0xcc2c2322, Offset: 0xa60
// Size: 0x1a
function function_a9398b3c(func) {
    level.onconcertinawireplaced = func;
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 0, eflags: 0x0
// Checksum 0x19a99f0, Offset: 0xa88
// Size: 0xa0
function function_cc8ec02b() {
    if (!isdefined(self.concertinawire)) {
        return;
    }
    foreach (concertinawire in self.concertinawire.var_fa48128e) {
        if (isdefined(concertinawire)) {
            concertinawire function_1454821a(1);
        }
    }
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 0, eflags: 0x0
// Checksum 0x115fb789, Offset: 0xb30
// Size: 0x9c
function function_cd28b99d() {
    self endon(#"death");
    if ((isdefined(level.var_a33e1621.bundle.timeout) ? level.var_a33e1621.bundle.timeout : 0) == 0) {
        return;
    }
    wait level.var_a33e1621.bundle.timeout;
    if (isdefined(self)) {
        self function_1454821a(1);
    }
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 0, eflags: 0x0
// Checksum 0x99b2802e, Offset: 0xbd8
// Size: 0xa4
function on_player_spawned() {
    if (!isdefined(self.concertinawire)) {
        self.concertinawire = spawnstruct();
        self.concertinawire.var_fa48128e = [];
        self.concertinawire.activelist = [];
    }
    if (!self hasweapon(level.var_a33e1621.concertinawireweapon) && self.concertinawire.var_fa48128e.size > 0) {
        self function_cc8ec02b();
    }
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 1, eflags: 0x0
// Checksum 0x15fc7048, Offset: 0xc88
// Size: 0x3f0
function function_d90c4119(player) {
    assert(isdefined(level.var_a33e1621.bundle.var_bbde0b27));
    var_83c20ba7 = player function_92f39379(level.var_a33e1621.bundle.var_bbde0b27, level.var_a33e1621.bundle.maxwidth, 0, 0);
    if (!var_83c20ba7.isvalid) {
        player.concertinawire.lastvalid = undefined;
        player function_d83e9f0e(0, (0, 0, 0), (0, 0, 0));
        return var_83c20ba7;
    }
    player.concertinawire.lastvalid = var_83c20ba7;
    var_dd3a1baa = function_faeab28a(var_83c20ba7.origin);
    var_59eabe50 = function_2255ed94(var_83c20ba7.origin, level.var_a33e1621.var_4a83e2d2);
    playerright = anglestoright(player.angles);
    origins = [];
    if (!isdefined(origins)) {
        origins = [];
    } else if (!isarray(origins)) {
        origins = array(origins);
    }
    origins[origins.size] = var_83c20ba7.origin;
    var_9c3a8bdf = var_83c20ba7.origin + playerright * getdvarfloat(#"hash_753335900deb89ea", 1);
    if (!isdefined(origins)) {
        origins = [];
    } else if (!isarray(origins)) {
        origins = array(origins);
    }
    origins[origins.size] = var_9c3a8bdf;
    var_ee4ef5b0 = var_83c20ba7.origin - playerright * getdvarfloat(#"hash_753335900deb89ea", 1);
    if (!isdefined(origins)) {
        origins = [];
    } else if (!isarray(origins)) {
        origins = array(origins);
    }
    origins[origins.size] = var_ee4ef5b0;
    if (smart_cover::function_5929f896(origins, getdvarfloat(#"hash_753335900deb89ea", 1))) {
        var_83c20ba7.isvalid = 0;
        return var_83c20ba7;
    }
    candeploy = !var_59eabe50 && !var_dd3a1baa;
    if (!candeploy) {
        var_83c20ba7.isvalid = 0;
        player function_d83e9f0e(candeploy, (0, 0, 0), (0, 0, 0));
        return var_83c20ba7;
    }
    player function_d83e9f0e(candeploy, var_83c20ba7.origin, var_83c20ba7.angles);
    return var_83c20ba7;
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 2, eflags: 0x0
// Checksum 0x4c197067, Offset: 0x1080
// Size: 0xc6
function function_1dc48211(point, upangles) {
    var_de6a796a = point + upangles * -10;
    var_88b9de22 = point + upangles * 10;
    mins = (-10, -10, -10);
    maxs = (10, 10, 10);
    var_5a6b34b4 = physicstrace(var_88b9de22, var_de6a796a, mins, maxs, self, 1);
    return var_5a6b34b4[#"fraction"] < 1;
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 3, eflags: 0x4
// Checksum 0x2065e097, Offset: 0x1150
// Size: 0x2ea
function private function_20ef6d20(var_11b3f518, startlocation, var_b2a16660) {
    var_83c20ba7 = spawnstruct();
    var_83c20ba7.var_61663965 = 1;
    var_83c20ba7.var_e8e29558 = 1;
    var_83c20ba7.var_a755d65f = var_b2a16660;
    dirright = anglestoright(var_11b3f518.angles);
    var_fc2870b0 = 0;
    lasttime = gettime();
    var_71ca7e17 = 1 / level.var_a33e1621.bundle.deploytime;
    var_d4e1a77 = 0;
    var_f4c5c53f = 0;
    while (var_fc2870b0 <= var_b2a16660) {
        var_11b3f518 clientfield::set("concertinaWire_placed", 1 - var_fc2870b0);
        var_1e8ee9f6 = level.var_a33e1621.bundle.maxwidth * var_fc2870b0 * 0.5;
        rightpoint = startlocation + dirright * var_1e8ee9f6;
        upangles = anglestoup(var_11b3f518.angles);
        if (!var_11b3f518 function_1dc48211(rightpoint, upangles)) {
            var_83c20ba7.var_61663965 = 0;
        }
        leftpoint = startlocation - dirright * var_1e8ee9f6;
        if (!var_11b3f518 function_1dc48211(leftpoint, upangles)) {
            var_83c20ba7.var_e8e29558 = 0;
        }
        var_d4e1a77 = var_fc2870b0;
        if (var_f4c5c53f || !var_83c20ba7.var_e8e29558 || !var_83c20ba7.var_61663965) {
            break;
        }
        waitframe(1);
        var_d0e516ad = gettime() - lasttime;
        var_fc2870b0 += var_d0e516ad * var_71ca7e17;
        if (var_fc2870b0 >= var_b2a16660) {
            var_f4c5c53f = 1;
            var_fc2870b0 = min(var_fc2870b0, var_b2a16660);
        }
        var_11b3f518.var_a92e3f27 = var_fc2870b0;
        lasttime = gettime();
    }
    var_83c20ba7.var_a755d65f = max(var_b2a16660 - var_d4e1a77, 0);
    return var_83c20ba7;
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 7, eflags: 0x4
// Checksum 0x8fc2a78e, Offset: 0x1448
// Size: 0x244
function private function_cc204ccd(var_11b3f518, startorigin, direction, var_fc2870b0, var_b2a16660, movedirection, var_a399f539) {
    var_db45b290 = var_fc2870b0 * level.var_a33e1621.bundle.maxwidth;
    lasttime = gettime();
    var_71ca7e17 = 1 / level.var_a33e1621.bundle.deploytime;
    while (var_fc2870b0 <= var_b2a16660) {
        var_11b3f518 clientfield::set("concertinaWire_placed", 1 - var_fc2870b0);
        if (var_fc2870b0 == var_b2a16660) {
            break;
        }
        var_1e8ee9f6 = level.var_a33e1621.bundle.maxwidth * var_fc2870b0;
        var_9bd04080 = var_1e8ee9f6 - var_db45b290;
        var_11b3f518.origin = startorigin + vectorscale(direction, var_9bd04080 * 0.5);
        var_c512e302 = startorigin + direction * var_1e8ee9f6;
        upangles = anglestoup(var_11b3f518.angles);
        if (!var_11b3f518 function_1dc48211(var_c512e302, upangles)) {
            if (movedirection == 0) {
                var_a399f539.var_61663965 = 0;
            } else {
                var_a399f539.var_e8e29558 = 1;
            }
            break;
        }
        waitframe(1);
        var_d0e516ad = gettime() - lasttime;
        var_fc2870b0 += var_d0e516ad * var_71ca7e17;
        var_fc2870b0 = min(var_fc2870b0, 1);
        var_11b3f518.var_a92e3f27 = var_fc2870b0;
        lasttime = gettime();
    }
    return var_a399f539;
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 2, eflags: 0x0
// Checksum 0x7b0d2710, Offset: 0x1698
// Size: 0x6dc
function function_90afaa2b(var_11b3f518, traceresults) {
    var_11b3f518 endon(#"death");
    var_11b3f518 useanimtree("generic");
    var_11b3f518 setanim(level.var_a33e1621.bundle.deployanim, 1, 0, 0);
    var_11b3f518 clientfield::set("concertinaWire_placed", 1);
    waitframe(1);
    var_b2a16660 = traceresults.width / level.var_a33e1621.bundle.maxwidth;
    var_71ca7e17 = 1 / level.var_a33e1621.bundle.deploytime;
    var_5dcfea98 = var_b2a16660 * level.var_a33e1621.bundle.deploytime;
    lasttime = gettime();
    moveamount = 0;
    var_fc2870b0 = 0;
    var_b8b4300e = distance2d(traceresults.origin, traceresults.var_80fcfd6f);
    var_f6c3fcdb = distance2d(traceresults.origin, traceresults.var_430f8c00);
    dirright = vectornormalize(traceresults.var_80fcfd6f - traceresults.origin);
    dirleft = vectornormalize(traceresults.var_430f8c00 - traceresults.origin);
    if (var_b8b4300e < var_f6c3fcdb) {
        var_42609bd1 = var_b8b4300e;
        movementdirection = vectornormalize(traceresults.var_430f8c00 - traceresults.origin);
        movedirection = 1;
    } else {
        var_42609bd1 = var_f6c3fcdb;
        movementdirection = vectornormalize(traceresults.var_80fcfd6f - traceresults.origin);
        movedirection = 0;
    }
    var_a2ceae98 = min(var_42609bd1 * 2 / level.var_a33e1621.bundle.maxwidth, 1);
    var_a399f539 = function_20ef6d20(var_11b3f518, traceresults.origin, var_a2ceae98);
    var_1e8ee9f6 = (var_a2ceae98 - var_a399f539.var_a755d65f) * level.var_a33e1621.bundle.maxwidth;
    var_fc2870b0 = var_a2ceae98 - var_a399f539.var_a755d65f;
    var_6bab4592 = 0;
    distanceremaining = traceresults.width - var_1e8ee9f6;
    if (!var_a399f539.var_61663965 && !var_a399f539.var_e8e29558) {
        var_6bab4592 = 0;
    } else if (!var_a399f539.var_61663965 || !var_a399f539.var_e8e29558) {
        var_6bab4592 = 1;
        if (!var_a399f539.var_61663965) {
            movementdirection = dirleft;
            distanceremaining = min(var_f6c3fcdb - var_1e8ee9f6, distanceremaining);
            movedirection = 1;
        } else {
            movementdirection = dirright;
            distanceremaining = min(var_b8b4300e - var_1e8ee9f6, distanceremaining);
            movedirection = 0;
        }
        var_b2a16660 = (distanceremaining + var_1e8ee9f6) / level.var_a33e1621.bundle.maxwidth;
    }
    if (var_b2a16660 - var_fc2870b0 > 0.05) {
        var_a399f539 = function_cc204ccd(var_11b3f518, traceresults.origin, movementdirection, var_fc2870b0, var_b2a16660, movedirection, var_a399f539);
    }
    if (!var_a399f539.var_61663965 && !var_a399f539.var_e8e29558) {
        var_11b3f518 clientfield::set("concertinaWireDroopyBits", 3);
    } else if (!var_a399f539.var_61663965) {
        var_11b3f518 clientfield::set("concertinaWireDroopyBits", 1);
    } else if (!var_a399f539.var_e8e29558) {
        var_11b3f518 clientfield::set("concertinaWireDroopyBits", 2);
    }
    if (isdefined(var_11b3f518.var_a92e3f27)) {
        var_525cfc2 = var_11b3f518.var_a92e3f27;
        if (var_525cfc2 < 0.85) {
            var_525cfc2 *= 0.9;
        }
        var_11b3f518 setanimtime(level.var_a33e1621.bundle.deployanim, var_525cfc2);
    }
    var_11b3f518.trigger = spawn("trigger_box_new", var_11b3f518.origin + (0, 0, 30), getvehicletriggerflags(), 20, int(var_fc2870b0 * traceresults.width * 0.8), 60);
    var_11b3f518.trigger.angles = var_11b3f518.angles;
    thread function_da979aae(var_11b3f518);
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 2, eflags: 0x0
// Checksum 0xf9ed7298, Offset: 0x1d80
// Size: 0x30c
function function_18b2035c(watcher, owner) {
    self endon(#"death");
    player = owner;
    self hide();
    if (!isdefined(player.concertinawire.lastvalid) || !player.concertinawire.lastvalid.isvalid) {
        player deployable::function_76d9b29b(level.var_a33e1621.concertinawireweapon);
        return;
    }
    var_11b3f518 = player function_fbc86b52(watcher, self, player.concertinawire.lastvalid.origin, player.concertinawire.lastvalid.angles, 1, player.concertinawire.lastvalid.width);
    array::add(player.concertinawire.activelist, var_11b3f518);
    var_ed4ce56d = function_5914ac9e(player.concertinawire.activelist, level.var_a33e1621.bundle.var_ebaaad96);
    if (isdefined(var_ed4ce56d)) {
        var_ed4ce56d function_1454821a(1);
    }
    if (isdefined(level.onconcertinawireplaced)) {
        owner [[ level.onconcertinawireplaced ]](self);
    }
    self thread function_bdba0753(player);
    var_11b3f518 clientfield::set("concertinaWire_placed", 1);
    assert(isdefined(level.var_a33e1621), "<dev string:x30>");
    assert(isdefined(level.var_a33e1621.bundle), "<dev string:x5c>");
    var_11b3f518 influencers::create_entity_enemy_influencer("grenade", owner.team);
    if (isdefined(level.var_a33e1621.bundle.deployanim)) {
        thread function_90afaa2b(var_11b3f518, player.concertinawire.lastvalid);
    }
    var_11b3f518 function_cd28b99d();
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 1, eflags: 0x0
// Checksum 0xd71a6b19, Offset: 0x2098
// Size: 0x42
function function_36433f52(watcher) {
    watcher.watchforfire = 1;
    watcher.onspawn = &function_18b2035c;
    watcher.deleteonplayerspawn = 0;
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 1, eflags: 0x0
// Checksum 0x13039a1b, Offset: 0x20e8
// Size: 0x5c
function function_bdba0753(player) {
    self endon(#"death");
    player waittill(#"joined_team", #"disconnect");
    player function_cc8ec02b();
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 0, eflags: 0x0
// Checksum 0xc9f47160, Offset: 0x2150
// Size: 0xa4
function function_63c57e3d() {
    level endon(#"game_ended");
    self.owner endon(#"disconnect", #"joined_team", #"changed_specialist");
    self endon(#"hash_c72d58e3d4735b");
    waitresult = self waittill(#"death");
    if (!isdefined(self)) {
        return;
    }
    self thread onkilled(waitresult);
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 0, eflags: 0x0
// Checksum 0xc673e195, Offset: 0x2200
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

// Namespace concertina_wire/gadget_concertina_wire
// Params 0, eflags: 0x0
// Checksum 0x68ade547, Offset: 0x2310
// Size: 0x1c
function function_c82034c2() {
    wait 10;
    self delete();
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 0, eflags: 0x0
// Checksum 0x872e72b1, Offset: 0x2338
// Size: 0x24
function function_47b2def3() {
    self clientfield::set("concertinaWireDestroyed", 1);
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 1, eflags: 0x0
// Checksum 0xdc94d309, Offset: 0x2368
// Size: 0x41c
function function_1454821a(isselfdestruct) {
    concertinawire = self;
    concertinawire clientfield::set("enemyequip", 0);
    concertinawire notify(#"hash_c72d58e3d4735b");
    concertinawire clientfield::set("friendlyequip", 0);
    objective_delete(concertinawire.objectiveid);
    gameobjects::release_obj_id(concertinawire.objectiveid);
    if (isdefined(level.var_a33e1621.bundle.var_f2279079)) {
        if (isdefined(isselfdestruct) && isselfdestruct) {
            var_e4caf320 = level.var_a33e1621.bundle.var_d4b78df7;
            var_511fc28c = level.var_a33e1621.bundle.var_9d321615;
        } else {
            var_e4caf320 = level.var_a33e1621.bundle.var_f2279079;
            var_511fc28c = level.var_a33e1621.bundle.var_5be3e16b;
        }
        playfx(var_e4caf320, concertinawire.origin, anglestoforward(concertinawire.angles), anglestoup(concertinawire.angles));
        if (isdefined(var_511fc28c)) {
            concertinawire playsound(var_511fc28c);
        }
    }
    removeindex = -1;
    for (index = 0; index < level.var_a33e1621.var_b2cf3d75.size; index++) {
        if (level.var_a33e1621.var_b2cf3d75[index] == concertinawire) {
            array::remove_index(level.var_a33e1621.var_b2cf3d75, index, 0);
            break;
        }
    }
    if (isdefined(concertinawire.owner)) {
        for (index = 0; index < concertinawire.owner.concertinawire.activelist.size; index++) {
            if (concertinawire.owner.concertinawire.activelist[index] == concertinawire) {
                arrayremovevalue(concertinawire.owner.concertinawire.activelist, concertinawire);
                concertinawire.owner.concertinawire.activelist = array::remove_undefined(concertinawire.owner.concertinawire.activelist, 0);
                break;
            }
        }
    }
    foreach (zoneid in concertinawire.var_51916838) {
        deployable::function_4b1687ca(zoneid);
    }
    if (isdefined(concertinawire.owner)) {
        concertinawire.owner thread function_71cd592b();
    }
    deployable::function_2cefe05a(concertinawire);
    concertinawire delete();
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 1, eflags: 0x0
// Checksum 0x95855099, Offset: 0x2790
// Size: 0xdc
function onkilled(var_d484027) {
    concertinawire = self;
    if (var_d484027.attacker != concertinawire.owner) {
        concertinawire.owner globallogic_score::function_a63adb85(var_d484027.attacker, var_d484027.weapon, concertinawire.weapon);
        if (isdefined(level.var_b31e16d4)) {
            self [[ level.var_b31e16d4 ]](var_d484027.attacker, concertinawire.owner, concertinawire.weapon, var_d484027.weapon);
        }
    }
    concertinawire thread function_1454821a(0);
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 1, eflags: 0x0
// Checksum 0x5ab424bf, Offset: 0x2878
// Size: 0x5e
function getmodel(var_f1be9112) {
    return self.team == #"allies" ? level.var_a33e1621.bundle.var_9208ce87 : level.var_a33e1621.bundle.var_4e1d6636;
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 2, eflags: 0x0
// Checksum 0x6b50a318, Offset: 0x28e0
// Size: 0x494
function function_a092384(player, concertinawire) {
    speed = length(player getvelocity());
    var_183e2f18 = !(isdefined(level.var_a2ddb254) && level.var_a2ddb254) && level.var_a33e1621.bundle.var_4f84ae03 && player status_effect::function_508e1a13(2) >= level.var_a33e1621.bundle.var_4f84ae03;
    if (speed <= (isdefined(level.var_a33e1621.bundle.speedthreshold) ? level.var_a33e1621.bundle.speedthreshold : 0)) {
        if (isdefined(player.var_438ad4bf) ? player.var_438ad4bf : 0) {
            return;
        }
        if (var_183e2f18) {
            damageamount = isdefined(level.var_a33e1621.bundle.var_566df341) ? level.var_a33e1621.bundle.var_566df341 : 0;
        } else {
            damageamount = level.var_a33e1621.concertinawireweapon.meleedamage;
        }
        if (player getstance() == "prone") {
            if (var_183e2f18) {
                damageamount *= isdefined(level.var_a33e1621.bundle.var_8a125b11) ? level.var_a33e1621.bundle.var_8a125b11 : 0;
            } else {
                damageamount *= isdefined(level.var_a33e1621.bundle.var_488e9e90) ? level.var_a33e1621.bundle.var_488e9e90 : 0;
            }
        }
        player dodamage(damageamount, player.origin, concertinawire.owner, concertinawire, undefined, "MOD_IMPACT", 0, level.var_a33e1621.concertinawireweapon);
        player.var_438ad4bf = 1;
    } else {
        if (isdefined(player.var_90e3973e) && player.var_90e3973e > gettime()) {
            return;
        }
        params = getstatuseffect("shock_concertina_wire");
        assert(isdefined(params), "<dev string:x8f>");
        duration = params.var_804bc9d5;
        player.var_90e3973e = gettime() + duration;
        if (var_183e2f18) {
            damageamount = isdefined(level.var_a33e1621.bundle.var_e9052d0e) ? level.var_a33e1621.bundle.var_e9052d0e : 0;
        } else {
            damageamount = isdefined(level.var_a33e1621.bundle.var_edf23bb7) ? level.var_a33e1621.bundle.var_edf23bb7 : 0;
        }
        player dodamage(damageamount, player.origin, concertinawire.owner, concertinawire, undefined, "MOD_IMPACT", 0, level.var_a33e1621.concertinawireweapon);
        player status_effect::status_effect_apply(params, level.var_a33e1621.concertinawireweapon, concertinawire.owner, 0, undefined, undefined, player.origin);
    }
    concertinawire function_2b3a6dd5(damageamount, player);
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 0, eflags: 0x0
// Checksum 0xd9e721e0, Offset: 0x2d80
// Size: 0x13a
function function_e435e7e0() {
    level endon(#"game_ended");
    params = getstatuseffect("concertina_wire_slowed");
    while (true) {
        foreach (player in level.players) {
            if (!isdefined(player.var_8042b500) || !player.var_89c6abfb) {
                continue;
            }
            timesincelast = gettime() - player.var_8042b500;
            if (timesincelast > 250) {
                player.var_89c6abfb = 0;
                player status_effect::function_280d8ac0(params.setype, params.var_d20b8ed2);
            }
        }
        waitframe(1);
    }
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 1, eflags: 0x0
// Checksum 0x9990f9f9, Offset: 0x2ec8
// Size: 0x59e
function function_da979aae(concertinawire) {
    level endon(#"game_ended");
    concertinawire endon(#"death");
    while (true) {
        waitresult = concertinawire.trigger waittill(#"trigger");
        player = waitresult.activator;
        if (!isplayer(player)) {
            isenemy = isdefined(concertinawire.owner) && isdefined(player.owner) && (!level.teambased || player.team != concertinawire.owner.team) && player.owner != concertinawire.owner;
            if (isdefined(player.killstreaktype) && player.killstreaktype == "recon_car" && isenemy) {
                player dodamage(1, player.origin, concertinawire.owner, concertinawire, undefined, "MOD_IMPACT", 0, level.var_a33e1621.concertinawireweapon);
            }
            continue;
        }
        player.var_8042b500 = gettime();
        player.var_d587776e = concertinawire;
        player.var_89c6abfb = 1;
        var_5244614a = isdefined(concertinawire.owner) && (!level.teambased || player.team != concertinawire.owner.team) && player != concertinawire.owner;
        var_f4f0d2c0 = 0;
        if (level.var_a33e1621.bucklerweapon == player.currentweapon) {
            var_f4f0d2c0 = 1;
        }
        var_4b8c6dd1 = var_f4f0d2c0 || player isslamming();
        if (var_5244614a && !var_4b8c6dd1) {
            concertinawire function_6120646f(player);
            concertinawire thread function_12a0629e(player);
        }
        var_ac3897ee = 0;
        if (isdefined(player.prevposition)) {
            distancemoved = distance2d(player.prevposition, player.origin);
            if (distancemoved < 0.0001) {
                continue;
            } else if (!isdefined(player.var_fc8ffdf1) || gettime() > player.var_fc8ffdf1 + 350 && distancemoved > 0.5) {
                var_ac3897ee = 1;
            }
        } else {
            var_ac3897ee = 1;
        }
        if (var_ac3897ee) {
            player playsound(#"hash_4b5965717e4efc71");
            player.var_fc8ffdf1 = gettime();
            if ((isdefined(var_5244614a) ? var_5244614a : 0) && !var_4b8c6dd1) {
                player gestures::function_42215dfa(#"hash_3e06c757e4b20f4f", undefined, 0);
            }
        }
        player.prevposition = player.origin;
        if (var_5244614a && !var_4b8c6dd1) {
            function_a092384(player, concertinawire);
        }
        if (var_f4f0d2c0 && isdefined(level.var_a33e1621.bundle.var_220e5627)) {
            if (!isdefined(concertinawire.var_321b8172[player.clientid]) || concertinawire.var_321b8172[player.clientid] + 500 < gettime()) {
                if (!isdefined(concertinawire.var_321b8172[player.clientid])) {
                    concertinawire.var_321b8172[player.clientid] = gettime();
                }
                var_b117dc81 = level.var_a33e1621.bundle.var_220e5627 * 0.5;
                concertinawire dodamage(var_b117dc81, player.origin, player, undefined, undefined, "MOD_IMPACT", 0, player.currentweapon);
                concertinawire.var_321b8172[player.clientid] = gettime();
            }
        }
    }
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 2, eflags: 0x4
// Checksum 0x4bab2550, Offset: 0x3470
// Size: 0x82
function private function_83f2e6fa(player, var_a493c841) {
    player endon(#"death");
    player allowjump(0);
    player.var_45a9f3ae = 0;
    wait var_a493c841;
    player allowjump(1);
    player.var_45a9f3ae = 1;
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 1, eflags: 0x4
// Checksum 0x9d102efb, Offset: 0x3500
// Size: 0x4aa
function private function_6120646f(player) {
    concertinawire = self;
    player allowprone(0);
    var_183e2f18 = !(isdefined(level.var_a2ddb254) && level.var_a2ddb254) && level.var_a33e1621.bundle.var_4f84ae03 && player status_effect::function_508e1a13(2) >= level.var_a33e1621.bundle.var_4f84ae03;
    if (player jumpbuttonpressed() && (isdefined(player.var_45a9f3ae) ? player.var_45a9f3ae : 1)) {
        if (!isdefined(player.var_9f4e5a67) || !player.var_9f4e5a67) {
            if (var_183e2f18) {
                damageamount = isdefined(level.var_a33e1621.bundle.var_e9052d0e) ? level.var_a33e1621.bundle.var_e9052d0e : 0;
                var_40919795 = isdefined(level.var_a33e1621.bundle.var_e4cbe3f5) ? level.var_a33e1621.bundle.var_e4cbe3f5 : 0;
            } else {
                damageamount = isdefined(level.var_a33e1621.bundle.var_edf23bb7) ? level.var_a33e1621.bundle.var_edf23bb7 : 0;
                var_40919795 = isdefined(level.var_a33e1621.bundle.var_83f2e6fa) ? level.var_a33e1621.bundle.var_83f2e6fa : 0;
            }
            player dodamage(damageamount, player.origin, concertinawire.owner, concertinawire, undefined, "MOD_IMPACT", 0, level.var_a33e1621.concertinawireweapon);
            player.var_9f4e5a67 = 1;
            thread function_83f2e6fa(player, var_40919795);
            concertinawire function_2b3a6dd5(damageamount, player);
        }
    } else {
        player.var_9f4e5a67 = 0;
    }
    if (player isdoublejumping()) {
        player setdoublejumpenergy(0);
    }
    if (!isdefined(player.var_6b8f8a01) || player.var_6b8f8a01 < gettime()) {
        params = getstatuseffect("concertina_wire_slowed");
        assert(isdefined(params), "<dev string:x8f>");
        duration = params.var_804bc9d5;
        player.var_6b8f8a01 = gettime() + duration;
        player.var_438ad4bf = 0;
    }
    if (!isdefined(player.var_ccb24d2d) || player.var_ccb24d2d < gettime()) {
        params = getstatuseffect("concertina_wire_slowed");
        assert(isdefined(params), "<dev string:x8f>");
        player status_effect::status_effect_apply(params, level.var_a33e1621.concertinawireweapon, concertinawire.owner, 1, undefined, undefined, player.origin);
        endtime = player status_effect::function_bffec895(params.var_d20b8ed2);
        player.var_ccb24d2d = endtime - 75;
        player.var_e921a690 = endtime;
    }
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 1, eflags: 0x4
// Checksum 0xd954ba29, Offset: 0x39b8
// Size: 0xb0
function private function_12a0629e(player) {
    concertinawire = self;
    player endon(#"death", #"disconnect");
    self notify("4341e9519fe1174");
    self endon("4341e9519fe1174");
    while (true) {
        if (isdefined(player.var_e921a690) && player.var_e921a690 < gettime()) {
            player allowprone(1);
        }
        wait 0.25;
    }
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 2, eflags: 0x0
// Checksum 0xda216a70, Offset: 0x3a70
// Size: 0x17c
function function_2b3a6dd5(damagedealt, player) {
    if (!isdefined(player) || !isdefined(damagedealt) || !isdefined(self)) {
        return;
    }
    damagedealt = int(damagedealt);
    self.damagedealt = (isdefined(self.damagedealt) ? self.damagedealt : 0) + damagedealt;
    if (!isdefined(self.playersdamaged)) {
        self.playersdamaged = [];
    }
    entnumb = player getentitynumber();
    self.playersdamaged[entnumb] = 1;
    if (isdefined(level.var_a33e1621.bundle.var_9344921d) && self.damagedealt >= level.var_a33e1621.bundle.var_9344921d) {
        scoreevents::processscoreevent(#"hash_6024b59ca1d3b641", self.owner, undefined, self.weapon, self.playersdamaged.size);
        self.damagedealt -= level.var_a33e1621.bundle.var_9344921d;
    }
    player thread function_71cd592b();
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 0, eflags: 0x0
// Checksum 0x11d420a5, Offset: 0x3bf8
// Size: 0x6c
function function_71cd592b() {
    self endon(#"disconnect");
    level endon(#"game_ended");
    self notify("3b74d8ae7b6adf86");
    self endon("3b74d8ae7b6adf86");
    wait 5;
    self globallogic_score::function_8fe8d71e(#"hash_54a5706bf2b2b41c");
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 12, eflags: 0x0
// Checksum 0x574b0780, Offset: 0x3c70
// Size: 0x322
function function_eef9542c(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, iboneindex, imodelindex) {
    if (weapon_utils::ismeleemod(smeansofdeath) && isdefined(level.var_a33e1621.bundle.var_d4775c7a) && eattacker != self.owner) {
        var_183e2f18 = !(isdefined(level.var_a2ddb254) && level.var_a2ddb254) && level.var_a33e1621.bundle.var_4f84ae03 && eattacker status_effect::function_508e1a13(2) >= level.var_a33e1621.bundle.var_4f84ae03;
        if (var_183e2f18) {
            damageamount = isdefined(level.var_a33e1621.bundle.var_5c6f3fff) ? level.var_a33e1621.bundle.var_5c6f3fff : 0;
        } else {
            damageamount = isdefined(level.var_a33e1621.bundle.var_d4775c7a) ? level.var_a33e1621.bundle.var_d4775c7a : 0;
        }
        eattacker dodamage(damageamount, self.origin, self.owner, self, undefined, "MOD_IMPACT", 0, level.var_a33e1621.concertinawireweapon);
        self function_2b3a6dd5(damageamount, eattacker);
    }
    if (weapon_utils::isexplosivedamage(smeansofdeath)) {
        idamage = int(idamage * (isdefined(level.var_a33e1621.bundle.var_8cc7c516) ? level.var_a33e1621.bundle.var_8cc7c516 : 0));
    }
    shotstokill = killstreak_bundles::get_shots_to_kill(weapon, smeansofdeath, level.var_a33e1621.bundle);
    if (shotstokill == 0) {
    } else if (shotstokill > 0) {
        idamage = self.startinghealth / shotstokill + 1;
    } else {
        idamage = 0;
    }
    return int(idamage);
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 0, eflags: 0x0
// Checksum 0xd979fe8f, Offset: 0x3fa0
// Size: 0x4c
function function_b0d945a1() {
    self endon(#"death");
    level waittill(#"game_ended");
    if (!isdefined(self)) {
        return;
    }
    self function_1454821a(1);
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 6, eflags: 0x0
// Checksum 0x19cf1226, Offset: 0x3ff8
// Size: 0x64e
function function_fbc86b52(watcher, var_792abbe1, origin, angles, var_f1be9112, width) {
    player = self;
    var_fa62fea = spawn("script_model", origin);
    var_792abbe1.concertinawire = var_fa62fea;
    var_fa62fea setmodel(level.var_a33e1621.concertinawireweapon.var_bb65ee6b);
    watcher.objectarray[watcher.objectarray.size] = var_fa62fea;
    var_fa62fea.var_51916838 = [];
    var_fa62fea.var_321b8172 = [];
    rightangles = anglestoright(angles);
    var_e68f5519 = origin - width * 0.5 * rightangles;
    var_ea070134 = int(width / 32);
    for (index = 0; index < var_ea070134; index++) {
        zoneid = deployable::function_94621b37(var_e68f5519, 32);
        array::add(var_fa62fea.var_51916838, zoneid);
        var_e68f5519 += rightangles * 64;
    }
    var_fa62fea.var_6b0336c0 = &function_eef9542c;
    var_fa62fea.angles = angles;
    var_fa62fea.owner = player;
    var_fa62fea.takedamage = 1;
    var_fa62fea.startinghealth = isdefined(level.var_a33e1621.concertinawireweapon.gadget_max_hitpoints) ? level.var_a33e1621.concertinawireweapon.gadget_max_hitpoints : 0;
    var_fa62fea.health = var_fa62fea.startinghealth;
    if (!sessionmodeiswarzonegame()) {
        var_fa62fea disconnectpaths();
    }
    var_fa62fea setteam(player getteam());
    var_fa62fea setweapon(level.var_a33e1621.concertinawireweapon);
    var_fa62fea.weapon = level.var_a33e1621.concertinawireweapon;
    array::add(player.concertinawire.var_fa48128e, var_fa62fea);
    if (isdefined(level.var_a33e1621.var_bdc049de)) {
        var_fa62fea.objectiveid = gameobjects::get_next_obj_id();
        objective_add(var_fa62fea.objectiveid, "active", var_fa62fea, level.var_a33e1621.var_bdc049de);
        function_eeba3a5c(var_fa62fea.objectiveid, 1);
        objective_setteam(var_fa62fea.objectiveid, player.team);
    }
    var_319f201e = player gadgetgetslot(level.var_a33e1621.concertinawireweapon);
    self gadgetpowerset(var_319f201e, 0);
    var_fa62fea setteam(player.team);
    array::add(level.var_a33e1621.var_b2cf3d75, var_fa62fea);
    var_fa62fea clientfield::set("friendlyequip", 1);
    var_fa62fea clientfield::set("enemyequip", 1);
    var_fa62fea thread ondamage();
    var_fa62fea thread function_63c57e3d();
    var_fa62fea thread function_b0d945a1();
    killcament = spawn("script_model", var_fa62fea.origin + (isdefined(level.var_a33e1621.bundle.var_3134e741) ? level.var_a33e1621.bundle.var_3134e741 : 0, isdefined(level.var_a33e1621.bundle.var_b326cd8) ? level.var_a33e1621.bundle.var_b326cd8 : 0, isdefined(level.var_a33e1621.bundle.var_7d39dc13) ? level.var_a33e1621.bundle.var_7d39dc13 : 0));
    var_fa62fea.killcament = killcament;
    player deployable::function_c0980d61(var_fa62fea, level.var_a33e1621.concertinawireweapon);
    watcher.objectarray[watcher.objectarray.size] = killcament;
    return var_fa62fea;
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 1, eflags: 0x0
// Checksum 0x4b176b10, Offset: 0x4650
// Size: 0xa0
function function_104f9c0a(concertinawire) {
    level endon(#"game_ended");
    concertinawire endon(#"death");
    while (true) {
        waitresult = concertinawire waittill(#"broken");
        if (waitresult.type == "base_piece_broken") {
            concertinawire function_1454821a(0);
        }
    }
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 2, eflags: 0x0
// Checksum 0xeb33fd08, Offset: 0x46f8
// Size: 0xb6
function function_2255ed94(origin, maxdistancesq) {
    foreach (concertinawire in level.var_a33e1621.var_b2cf3d75) {
        if (!isdefined(concertinawire)) {
            continue;
        }
        if (distancesquared(concertinawire.origin, origin) < maxdistancesq) {
            return true;
        }
    }
    return false;
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 0, eflags: 0x0
// Checksum 0x7f8064c7, Offset: 0x47b8
// Size: 0x88
function watchweaponchange() {
    player = self;
    self notify(#"watchweaponchange_singleton");
    self endon(#"watchweaponchange_singleton");
    while (true) {
        if (self weaponswitchbuttonpressed()) {
            if (isdefined(player.concertinawire)) {
                player.concertinawire.var_ba2d79e8 = 1;
            }
        }
        waitframe(1);
    }
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 2, eflags: 0x0
// Checksum 0x5c1e6a25, Offset: 0x4848
// Size: 0x6a
function function_5914ac9e(&coverlist, maxallowed) {
    if (coverlist.size <= maxallowed) {
        return undefined;
    }
    var_455b9443 = array::pop_front(coverlist, 0);
    coverlist = array::remove_undefined(coverlist, 0);
    return var_455b9443;
}

