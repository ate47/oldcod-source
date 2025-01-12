#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\airsupport;
#using scripts\killstreaks\killstreak_hacking;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\planemortar_shared;
#using scripts\weapons\heatseekingmissile;

#namespace artillery_barrage;

// Namespace artillery_barrage/artillery_barrage_shared
// Params 0, eflags: 0x0
// Checksum 0xd4383a67, Offset: 0x1e8
// Size: 0x4a
function init_shared() {
    if (!isdefined(level.var_ac1c6910)) {
        level.var_ac1c6910 = {};
        airsupport::init_shared();
        level.var_f04e5fdd = undefined;
        level.var_cb2c3b6e = undefined;
    }
}

// Namespace artillery_barrage/artillery_barrage_shared
// Params 0, eflags: 0x0
// Checksum 0xaf6b095a, Offset: 0x240
// Size: 0xf0
function function_ac0edc30() {
    if (self killstreakrules::iskillstreakallowed("artillery_barrage", self.team) == 0) {
        return 0;
    }
    result = self function_4abd0006();
    killstreak_used = result === 1;
    if (killstreak_used && isdefined(self)) {
        bundle = level.killstreaks[#"artillery_barrage"].script_bundle;
        var_430ddeb1 = self gadgetgetslot(bundle.ksweapon);
        self gadgetpowerset(var_430ddeb1, 0);
    }
    return killstreak_used;
}

// Namespace artillery_barrage/artillery_barrage_shared
// Params 0, eflags: 0x0
// Checksum 0xd2792c4, Offset: 0x338
// Size: 0x24
function function_74e994d() {
    self beginlocationartilleryselection("map_directional_selector");
}

// Namespace artillery_barrage/artillery_barrage_shared
// Params 0, eflags: 0x0
// Checksum 0x598209b4, Offset: 0x368
// Size: 0x19a
function function_4abd0006() {
    self airsupport::function_277a9e(&function_74e994d);
    locations = [];
    if (!isdefined(self.pers[#"hash_3b8a938c10ba768b"]) || !self.pers[#"hash_3b8a938c10ba768b"]) {
        self thread planemortar::singleradarsweep();
    }
    location = self airsupport::waitforlocationselection();
    if (!isdefined(self)) {
        return 0;
    }
    if (!isdefined(location.origin)) {
        self.pers[#"hash_3b8a938c10ba768b"] = 1;
        self notify(#"cancel_selection");
        return 0;
    }
    if (self killstreakrules::iskillstreakallowed("artillery_barrage", self.team) == 0) {
        self.pers[#"hash_3b8a938c10ba768b"] = 1;
        self notify(#"cancel_selection");
        return 0;
    }
    self.pers[#"hash_3b8a938c10ba768b"] = 0;
    return self airsupport::function_4293d951(location, &function_a0dd5bc1, "artillery_barrage");
}

// Namespace artillery_barrage/artillery_barrage_shared
// Params 2, eflags: 0x0
// Checksum 0x3d696e80, Offset: 0x510
// Size: 0xc8
function function_a0dd5bc1(location, killstreak_id) {
    team = self.team;
    spawn_influencer = level influencers::create_enemy_influencer("artillery", location.origin, team);
    self thread watchforkillstreakend(team, spawn_influencer, killstreak_id);
    yaw = location.yaw;
    self thread function_5f4fa03c(location.origin, location.yaw, team, killstreak_id);
    return true;
}

// Namespace artillery_barrage/artillery_barrage_shared
// Params 3, eflags: 0x0
// Checksum 0xd488067f, Offset: 0x5e0
// Size: 0x94
function watchforkillstreakend(team, influencer, killstreak_id) {
    self waittill(#"disconnect", #"joined_team", #"joined_spectators", #"hash_6a70219902316c7e", #"emp_jammed");
    killstreakrules::killstreakstop("artillery_barrage", team, killstreak_id);
}

// Namespace artillery_barrage/artillery_barrage_shared
// Params 1, eflags: 0x0
// Checksum 0x184a7f97, Offset: 0x680
// Size: 0x74
function getplaneflyheight(bundle) {
    return airsupport::getminimumflyheight() + (isdefined(bundle.var_363268b4) ? bundle.var_363268b4 : 0) + randomint(isdefined(bundle.var_f321db35) ? bundle.var_f321db35 : 1);
}

// Namespace artillery_barrage/artillery_barrage_shared
// Params 4, eflags: 0x0
// Checksum 0xdf519646, Offset: 0x700
// Size: 0x5a0
function function_5f4fa03c(sweep_start, var_64b7852f, team, killstreak_id) {
    owner = self;
    owner endon(#"emp_jammed", #"joined_team", #"joined_spectators", #"disconnect");
    bundle = level.killstreaks[#"artillery_barrage"].script_bundle;
    var_2af602fa = bundle.var_ca4d588b;
    var_bfd5eff1 = bundle.var_e987abd4;
    var_9395c977 = 26000;
    height = getplaneflyheight(bundle);
    plane_start = (level.mapcenter[0], level.mapcenter[1], height);
    team_center = self getteamcenter(self.team);
    var_d0b6b03b = vectornormalize((team_center[0], team_center[1], height) - (level.mapcenter[0], level.mapcenter[1], height));
    var_172c8aac = (level.mapcenter[0], level.mapcenter[1], height) + vectorscale(var_d0b6b03b, var_bfd5eff1);
    var_2e9c4e = vectorcross((0, 0, 1), var_d0b6b03b);
    plane_start = var_172c8aac - vectorscale(var_2e9c4e, var_2af602fa);
    var_cc4a7c27 = var_172c8aac + vectorscale(var_2e9c4e, var_9395c977);
    var_af912c48 = vectortoangles(var_2e9c4e);
    if (isdefined(bundle.var_a6c4a468)) {
        var_af912c48 = (var_af912c48[0], var_af912c48[1], bundle.var_a6c4a468 * 0.75);
    }
    plane = spawnvehicle(bundle.var_e3e73c45, plane_start, var_af912c48);
    plane setowner(owner);
    plane notsolid();
    plane killstreaks::configure_team("artillery_barrage", killstreak_id, owner, undefined, undefined, &configurechopperteampost);
    plane killstreak_hacking::enable_hacking("artillery_barrage");
    plane endon(#"hash_1fe75f940ce5fd52");
    var_85591199 = bundle.var_7fdd850f;
    plane.var_86a6580 = var_85591199 * 2;
    plane.var_5a4d82f = var_85591199 * 2;
    plane setspeedimmediate(var_85591199, plane.var_86a6580, plane.var_5a4d82f);
    target_set(plane, (0, 0, 100));
    plane solid();
    plane killstreaks::function_1c47e9c9("artillery_barrage", &function_8163bdfa, &function_54dd91e4);
    plane thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile("crashing", "death");
    plane thread function_148b5239();
    plane thread watchgameended();
    owner thread function_ede05d75(plane, sweep_start, var_64b7852f, team, killstreak_id, height);
    owner function_96d70cb2(plane, var_172c8aac, var_2e9c4e, var_d0b6b03b);
    plane.var_cc4a7c27 = var_cc4a7c27;
    plane.var_8f994c47 = var_2e9c4e;
    plane.var_9395c977 = var_9395c977;
    plane thread function_3bb0b84a();
    owner waittill(#"hash_6a70219902316c7e");
    wait 1.5;
    if (function_c0b4719d(plane)) {
        plane notify(#"hash_1fe75f940ce5fd52", {#is_killed:0});
    }
}

// Namespace artillery_barrage/artillery_barrage_shared
// Params 0, eflags: 0x0
// Checksum 0x873d624e, Offset: 0xca8
// Size: 0xac
function function_3bb0b84a() {
    plane = self;
    wait 0.5;
    if (function_c0b4719d(plane)) {
        bundle = level.killstreaks[#"artillery_barrage"].script_bundle;
        playfxontag(bundle.var_91ccdb60, plane, "tag_fx_engine2");
        playfxontag(bundle.var_91ccdb60, plane, "tag_fx_engine5");
    }
}

// Namespace artillery_barrage/artillery_barrage_shared
// Params 1, eflags: 0x0
// Checksum 0x7e1e609c, Offset: 0xd60
// Size: 0x122
function getteamcenter(team) {
    if (!isdefined(team)) {
        return self.origin;
    }
    teamplayers = getplayers(team);
    totalaliveplayers = 0;
    var_54b7db73 = (0, 0, 0);
    foreach (teammate in teamplayers) {
        if (!isdefined(teammate)) {
            continue;
        }
        if (!isalive(teammate)) {
            continue;
        }
        var_54b7db73 += teammate.origin;
        totalaliveplayers++;
    }
    if (totalaliveplayers == 0) {
        return self.origin;
    }
    return vectorscale(var_54b7db73, 1 / totalaliveplayers);
}

// Namespace artillery_barrage/artillery_barrage_shared
// Params 0, eflags: 0x0
// Checksum 0xf8542caa, Offset: 0xe90
// Size: 0x134
function function_494675e6() {
    plane = self;
    if (plane.isleaving === 1) {
        return;
    }
    plane.isleaving = 1;
    var_99b09e65 = 10;
    planedir = anglestoforward(plane.angles);
    var_14dc73fd = 30000;
    var_f6085aac = plane.origin + vectorscale(planedir, 30000);
    plane setplanegoalpos(var_f6085aac, var_f6085aac + vectorscale(planedir, 300));
    plane setspeed(0.0568182 * var_14dc73fd / var_99b09e65, 100);
    plane setneargoalnotifydist(100);
    plane waittill(#"curve_end");
}

// Namespace artillery_barrage/artillery_barrage_shared
// Params 4, eflags: 0x0
// Checksum 0x8d6ec03, Offset: 0xfd0
// Size: 0xa28
function function_96d70cb2(plane, var_172c8aac, var_2e9c4e, var_d0b6b03b) {
    owner = self;
    owner endon(#"hash_6a70219902316c7e");
    plane endon(#"death");
    bundle = level.killstreaks[#"artillery_barrage"].script_bundle;
    if (isdefined(bundle.var_a6c4a468)) {
        plane setplanebarrelroll(bundle.var_a6c4a468 / 360, 25, 1);
    }
    novox = [];
    var_6815cc10 = [];
    var_fe25f60e = bundle.var_22e56fe7 * 2;
    var_f4fa1d0e = var_fe25f60e * bundle.var_406259fa;
    var_becde0f8 = var_fe25f60e * 0.5;
    var_fcbd7410 = var_f4fa1d0e * 0.5;
    var_68a7fe1e = 15 + 30 / bundle.var_406259fa;
    var_ac2d20ac = var_becde0f8 * sin(var_68a7fe1e);
    var_79ab731c = var_fcbd7410 * cos(var_68a7fe1e);
    var_32486dd8 = 15 + 15 / bundle.var_406259fa;
    var_a2e7bd06 = var_becde0f8 * sin(var_32486dd8);
    var_d0743636 = var_fcbd7410 * cos(var_32486dd8);
    var_68794581 = 60;
    var_33a97d3c = var_becde0f8 * sin(var_68794581);
    var_45bccb2c = var_fcbd7410 * cos(var_68794581);
    if (!isdefined(novox)) {
        novox = [];
    } else if (!isarray(novox)) {
        novox = array(novox);
    }
    novox[novox.size] = var_172c8aac + vectorscale(var_2e9c4e, 50);
    if (!isdefined(novox)) {
        novox = [];
    } else if (!isarray(novox)) {
        novox = array(novox);
    }
    novox[novox.size] = var_172c8aac + vectorscale(var_2e9c4e, var_45bccb2c) + vectorscale(var_d0b6b03b, var_becde0f8 * -1 + var_33a97d3c);
    if (!isdefined(novox)) {
        novox = [];
    } else if (!isarray(novox)) {
        novox = array(novox);
    }
    novox[novox.size] = var_172c8aac + vectorscale(var_2e9c4e, var_79ab731c) + vectorscale(var_d0b6b03b, var_becde0f8 * -1 + var_ac2d20ac);
    if (!isdefined(novox)) {
        novox = [];
    } else if (!isarray(novox)) {
        novox = array(novox);
    }
    novox[novox.size] = var_172c8aac + vectorscale(var_2e9c4e, var_d0743636) + vectorscale(var_d0b6b03b, var_becde0f8 * -1 + var_a2e7bd06);
    if (!isdefined(novox)) {
        novox = [];
    } else if (!isarray(novox)) {
        novox = array(novox);
    }
    novox[novox.size] = var_172c8aac + vectorscale(var_2e9c4e, var_fcbd7410) + vectorscale(var_d0b6b03b, var_becde0f8 * -1);
    if (!isdefined(novox)) {
        novox = [];
    } else if (!isarray(novox)) {
        novox = array(novox);
    }
    novox[novox.size] = var_172c8aac + vectorscale(var_2e9c4e, var_d0743636) + vectorscale(var_d0b6b03b, var_becde0f8 * -1 - var_a2e7bd06);
    if (!isdefined(novox)) {
        novox = [];
    } else if (!isarray(novox)) {
        novox = array(novox);
    }
    novox[novox.size] = var_172c8aac + vectorscale(var_2e9c4e, var_79ab731c) + vectorscale(var_d0b6b03b, var_becde0f8 * -1 - var_ac2d20ac);
    if (!isdefined(var_6815cc10)) {
        var_6815cc10 = [];
    } else if (!isarray(var_6815cc10)) {
        var_6815cc10 = array(var_6815cc10);
    }
    var_6815cc10[var_6815cc10.size] = var_172c8aac + vectorscale(var_d0b6b03b, var_fe25f60e * -1);
    if (!isdefined(var_6815cc10)) {
        var_6815cc10 = [];
    } else if (!isarray(var_6815cc10)) {
        var_6815cc10 = array(var_6815cc10);
    }
    var_6815cc10[var_6815cc10.size] = var_172c8aac + vectorscale(var_2e9c4e, var_79ab731c * -1) + vectorscale(var_d0b6b03b, var_becde0f8 * -1 - var_ac2d20ac);
    if (!isdefined(var_6815cc10)) {
        var_6815cc10 = [];
    } else if (!isarray(var_6815cc10)) {
        var_6815cc10 = array(var_6815cc10);
    }
    var_6815cc10[var_6815cc10.size] = var_172c8aac + vectorscale(var_2e9c4e, var_d0743636 * -1) + vectorscale(var_d0b6b03b, var_becde0f8 * -1 - var_a2e7bd06);
    if (!isdefined(var_6815cc10)) {
        var_6815cc10 = [];
    } else if (!isarray(var_6815cc10)) {
        var_6815cc10 = array(var_6815cc10);
    }
    var_6815cc10[var_6815cc10.size] = var_172c8aac + vectorscale(var_2e9c4e, var_fcbd7410 * -1) + vectorscale(var_d0b6b03b, var_becde0f8 * -1);
    if (!isdefined(var_6815cc10)) {
        var_6815cc10 = [];
    } else if (!isarray(var_6815cc10)) {
        var_6815cc10 = array(var_6815cc10);
    }
    var_6815cc10[var_6815cc10.size] = var_172c8aac + vectorscale(var_2e9c4e, var_d0743636 * -1) + vectorscale(var_d0b6b03b, var_becde0f8 * -1 + var_a2e7bd06);
    if (!isdefined(var_6815cc10)) {
        var_6815cc10 = [];
    } else if (!isarray(var_6815cc10)) {
        var_6815cc10 = array(var_6815cc10);
    }
    var_6815cc10[var_6815cc10.size] = var_172c8aac + vectorscale(var_2e9c4e, var_79ab731c * -1) + vectorscale(var_d0b6b03b, var_becde0f8 * -1 + var_ac2d20ac);
    if (!isdefined(var_6815cc10)) {
        var_6815cc10 = [];
    } else if (!isarray(var_6815cc10)) {
        var_6815cc10 = array(var_6815cc10);
    }
    var_6815cc10[var_6815cc10.size] = var_172c8aac + vectorscale(var_2e9c4e, var_45bccb2c * -1) + vectorscale(var_d0b6b03b, var_becde0f8 * -1 + var_33a97d3c);
    /#
        function_2658c22f(novox);
    #/
    /#
        function_2658c22f(var_6815cc10);
    #/
    var_85591199 = bundle.var_7fdd850f;
    plane setspeed(var_85591199, plane.var_86a6580, plane.var_5a4d82f);
    while (function_c0b4719d(plane)) {
        plane setplanegoalpos(novox, var_85591199);
        plane waittill(#"curve_end");
        plane setplanegoalpos(var_6815cc10, var_85591199);
        plane waittill(#"curve_end");
    }
}

/#

    // Namespace artillery_barrage/artillery_barrage_shared
    // Params 1, eflags: 0x0
    // Checksum 0x2fa16d68, Offset: 0x1a00
    // Size: 0x148
    function function_2658c22f(path) {
        draw_path = getdvarint(#"hash_619e2bb393e45754", 0);
        if (draw_path == 0) {
            return;
        }
        var_33d77033 = 0;
        radius = 100;
        alpha = 0.9;
        var_195b850b = 2000;
        foreach (point in path) {
            if (!var_33d77033) {
                var_33d77033 = 1;
                util::debug_sphere(point, radius, (0, 1, 0), alpha, var_195b850b);
                continue;
            }
            util::debug_sphere(point, radius, (0, 0, 1), alpha, var_195b850b);
        }
    }

#/

// Namespace artillery_barrage/artillery_barrage_shared
// Params 6, eflags: 0x0
// Checksum 0xb720b899, Offset: 0x1b50
// Size: 0x998
function function_ede05d75(plane, position, yaw, team, killstreak_id, fly_height) {
    owner = self;
    owner endon(#"emp_jammed", #"joined_team", #"joined_spectators", #"disconnect");
    bundle = level.killstreaks[#"artillery_barrage"].script_bundle;
    var_e26345a3 = (0, yaw, 0);
    var_dba517ab = anglestoforward(var_e26345a3);
    var_5795d34a = (position[0], position[1], fly_height);
    tracestartpos = (position[0], position[1], fly_height);
    traceendpos = (position[0], position[1], fly_height * -1);
    trace = bullettrace(tracestartpos, traceendpos, 0, undefined);
    targetpoint = trace[#"fraction"] > 1 ? (position[0], position[1], 0) : trace[#"position"];
    /#
        if (getdvarint(#"hash_bbfcab5c3429103", 0) > 0) {
            for (i = 0; i < 10; i++) {
                sphere(targetpoint + (0, 0, 50 * i), 20, (1, 0, 0), 1, 1, 10, 800);
            }
        }
    #/
    initialoffset = (0, 0, 0);
    if (isdefined(bundle.var_11f30607)) {
        wait bundle.var_11f30607;
    }
    for (sweep = 0; sweep < bundle.var_fbe20949 && function_c0b4719d(plane); sweep++) {
        for (var_a474865c = 0; var_a474865c < bundle.var_674a4c2c && function_c0b4719d(plane); var_a474865c++) {
            startpoint = plane.origin;
            var_3213a26e = vectornormalize(var_5795d34a - startpoint);
            var_4ceebaa0 = anglestoright(var_e26345a3);
            rightoffset = vectorscale(var_4ceebaa0, bundle.var_dab6083f + util::function_1e539051(bundle.var_f71f27dc));
            leftoffset = vectorscale(var_4ceebaa0, bundle.var_dab6083f * -1 + util::function_1e539051(bundle.var_f71f27dc));
            fire_right = vectorcross((0, 0, 1), var_3213a26e);
            var_96c2dd2b = plane gettagorigin("tag_gunner_flash2");
            var_d0a22d74 = plane gettagorigin("tag_gunner_flash1");
            playfxontag(bundle.var_aca8f0a3, plane, "tag_gunner_flash2");
            playfxontag(bundle.var_aca8f0a3, plane, "tag_gunner_flash1");
            var_b84f6cbb = targetpoint + initialoffset + rightoffset + vectorscale(var_dba517ab, var_a474865c * bundle.var_98e4149c + util::function_1e539051(bundle.var_57a200c5));
            var_80c21a44 = targetpoint + initialoffset + leftoffset + vectorscale(var_dba517ab, var_a474865c * bundle.var_98e4149c + util::function_1e539051(bundle.var_57a200c5));
            var_a5fa5104 = 1;
            if (var_a5fa5104) {
                /#
                    if (getdvarint(#"hash_2d8cc6ef214202c9", 0) > 0) {
                        sphere(var_b84f6cbb, 12, (0, 0, 1), 0.8, 1, 10, 120);
                        sphere(var_80c21a44, 12, (0, 0, 1), 0.8, 1, 10, 120);
                    }
                #/
                if (!ispointonnavmesh(var_b84f6cbb)) {
                    var_a59b0ccf = getclosestpointonnavmesh(var_b84f6cbb, bundle.var_fd23cebc);
                    if (isdefined(var_a59b0ccf)) {
                        var_b84f6cbb = var_a59b0ccf;
                    }
                }
                if (!ispointonnavmesh(var_80c21a44)) {
                    var_da6895b4 = getclosestpointonnavmesh(var_80c21a44, bundle.var_fd23cebc);
                    if (isdefined(var_da6895b4)) {
                        var_80c21a44 = var_da6895b4;
                    }
                }
            }
            /#
                if (getdvarint(#"hash_2d8cc6ef214202c9", 0) > 0) {
                    sphere(var_b84f6cbb, 20, (0, 1, 0), 0.9, 1, 10, 120);
                    sphere(var_80c21a44, 20, (0, 1, 0), 0.9, 1, 10, 120);
                }
            #/
            var_6ccab78e = vectornormalize((var_b84f6cbb[0], var_b84f6cbb[1], startpoint[2]) - var_96c2dd2b);
            var_969ebed1 = vectornormalize((var_80c21a44[0], var_80c21a44[1], startpoint[2]) - var_d0a22d74);
            var_e4485aae = var_b84f6cbb - vectorscale(var_6ccab78e, bundle.var_8072853b);
            var_e4485aae = (var_e4485aae[0], var_e4485aae[1], var_96c2dd2b[2]);
            var_64873efb = var_80c21a44 - vectorscale(var_969ebed1, bundle.var_8072853b);
            var_64873efb = (var_64873efb[0], var_64873efb[1], var_d0a22d74[2]);
            var_d0ac77d5 = vectortoangles(var_e4485aae - var_96c2dd2b);
            var_6d0dd61a = vectortoangles(var_64873efb - var_d0a22d74);
            self thread function_2fa67e3a(var_96c2dd2b, var_e4485aae, var_b84f6cbb, var_d0ac77d5, self.team, killstreak_id);
            self thread function_2fa67e3a(var_d0a22d74, var_64873efb, var_80c21a44, var_6d0dd61a, self.team, killstreak_id);
            plane playsound(#"hash_3e7e330ab5fcdcd");
            wait bundle.var_a55887a9;
        }
        if (sweep + 1 < bundle.var_fbe20949 && bundle.var_539e8171 > 0 && function_c0b4719d(plane)) {
            wait bundle.var_539e8171;
        }
    }
    wait 3;
    owner notify(#"hash_6a70219902316c7e");
}

// Namespace artillery_barrage/artillery_barrage_shared
// Params 1, eflags: 0x0
// Checksum 0x72697c50, Offset: 0x24f0
// Size: 0x3c
function function_c0b4719d(plane) {
    return isdefined(plane) && !isdefined(plane.destroyed) && !(plane.isleaving === 1);
}

// Namespace artillery_barrage/artillery_barrage_shared
// Params 6, eflags: 0x0
// Checksum 0x4def9a9e, Offset: 0x2538
// Size: 0x6b4
function function_2fa67e3a(startpoint, endpoint, targetpoint, angles, team, killstreak_id) {
    bundle = level.killstreakbundle[#"artillery_barrage"];
    shell = spawn("script_model", startpoint);
    shell.team = team;
    shell.targetname = "guided_artillery_shell";
    shell setowner(self);
    shell.owner = self;
    shell.owner thread watchownerevents(shell);
    shell killstreaks::configure_team("artillery_barrage", killstreak_id, self);
    shell killstreak_hacking::enable_hacking("artillery_barrage");
    target_set(shell);
    shell endon(#"delete");
    shell endon(#"death");
    shell.angles = angles;
    shell setmodel(bundle.dronemodel);
    shell setenemymodel(bundle.var_9f7537aa);
    shell notsolid();
    playfxontag(bundle.var_5a4eb5a4, shell, "tag_bomb_fx");
    shell clientfield::set("enemyvehicle", 1);
    shell killstreaks::function_1c47e9c9("artillery_barrage", &function_60e44a99, undefined, &function_35df3954);
    shell thread watchforemp(self);
    var_e777f2bd = max(bundle.var_90bcb2bf - 0.1, 0.1);
    var_e777f2bd = min(var_e777f2bd, 1.5);
    shell moveto(endpoint, bundle.var_90bcb2bf, 0, var_e777f2bd);
    wait bundle.var_90bcb2bf * 0.5;
    velocity = shell getvelocity();
    wait bundle.var_90bcb2bf * 0.5;
    remainingdistance = distance2d(shell.origin, targetpoint);
    halfgravity = getdvarfloat(#"bg_gravity", 0) * 0.5;
    dxy = abs(remainingdistance);
    dz = endpoint[2] - targetpoint[2];
    droptime = sqrt(dz / halfgravity);
    dvxy = dxy / droptime;
    nvel = vectornormalize(velocity);
    launchvel = nvel * dvxy;
    bomb = self magicmissile(bundle.ksweapon, shell.origin, launchvel);
    target_set(bomb);
    bomb killstreaks::configure_team("artillery_barrage", killstreak_id, self);
    bomb killstreak_hacking::enable_hacking("artillery_barrage");
    shell notify(#"hackertool_update_ent", {#entity:bomb});
    bomb clientfield::set("enemyvehicle", 1);
    bomb.targetname = "guided_artillery_shell";
    bomb setowner(self);
    bomb.owner = self;
    bomb.team = team;
    var_af017065 = max(droptime - 4, 2);
    bomb thread function_e5c42af4(var_af017065);
    bomb killstreaks::function_1c47e9c9("artillery_barrage", &function_60e44a99, undefined, &function_35df3954);
    bomb thread watchforemp(self);
    bomb thread watchforimpact(self);
    bomb.owner thread watchownerevents(bomb);
    if (isdefined(level.var_2843e1f6)) {
        bomb.owner thread [[ level.var_2843e1f6 ]](bundle.ksweapon, bomb);
    }
    waitframe(1);
    shell hide();
    waitframe(1);
    shell delete();
}

// Namespace artillery_barrage/artillery_barrage_shared
// Params 1, eflags: 0x0
// Checksum 0x8e1bc120, Offset: 0x2bf8
// Size: 0x3c
function function_e5c42af4(delay) {
    wait delay;
    if (isdefined(self)) {
        self playloopsound(#"hash_6e9ee0f0f9ecd8d7");
    }
}

// Namespace artillery_barrage/artillery_barrage_shared
// Params 2, eflags: 0x0
// Checksum 0xb078bcf7, Offset: 0x2c40
// Size: 0x18c
function function_60e44a99(attacker, weapon) {
    self endon(#"death");
    bundle = level.killstreakbundle[#"artillery_barrage"];
    attacker = self [[ level.figure_out_attacker ]](attacker);
    if (isdefined(attacker) && (!isdefined(self.owner) || self.owner util::isenemyplayer(attacker))) {
        challenges::destroyedaircraft(attacker, weapon, 0);
        attacker challenges::addflyswatterstat(weapon, self);
        scoreevents::processscoreevent(bundle.var_2df60b42, attacker, self.owner, weapon);
    }
    if (isdefined(bundle.ksexplosionfx)) {
        playfxontag(bundle.ksexplosionfx, self, "tag_origin");
    }
    self setmodel(#"tag_origin");
    self stoploopsound();
    wait 0.5;
    self delete();
}

// Namespace artillery_barrage/artillery_barrage_shared
// Params 1, eflags: 0x0
// Checksum 0xcd2b60b3, Offset: 0x2dd8
// Size: 0x9c
function watchownerevents(bomb) {
    player = self;
    bomb endon(#"death");
    player waittill(#"disconnect", #"joined_team", #"joined_spectators");
    if (isdefined(isalive(bomb))) {
        bomb delete();
    }
}

// Namespace artillery_barrage/artillery_barrage_shared
// Params 1, eflags: 0x0
// Checksum 0xfbe0905c, Offset: 0x2e80
// Size: 0x64
function watchforemp(owner) {
    self endon(#"delete");
    self endon(#"death");
    waitresult = self waittill(#"emp_deployed");
    function_35df3954(waitresult.attacker);
}

// Namespace artillery_barrage/artillery_barrage_shared
// Params 1, eflags: 0x0
// Checksum 0xa0f448f7, Offset: 0x2ef0
// Size: 0x98
function watchforimpact(owner) {
    if (!isdefined(level.var_cb2c3b6e)) {
        return;
    }
    s_info = spawnstruct();
    s_info.origin = self.origin;
    while (isalive(self)) {
        s_info.origin = self.origin;
        waitframe(1);
    }
    [[ level.var_cb2c3b6e ]](s_info);
}

// Namespace artillery_barrage/artillery_barrage_shared
// Params 1, eflags: 0x0
// Checksum 0xeb495317, Offset: 0x2f90
// Size: 0xcc
function function_35df3954(attacker) {
    if (isdefined(level.var_f04e5fdd)) {
        thread [[ level.var_f04e5fdd ]](attacker, self);
    }
    bundle = level.killstreakbundle[#"artillery_barrage"];
    if (isdefined(self) && isdefined(bundle.ksexplosionfx)) {
        playfx(bundle.ksexplosionfx, self.origin);
    }
    self stoploopsound();
    wait 0.1;
    self delete();
}

// Namespace artillery_barrage/artillery_barrage_shared
// Params 2, eflags: 0x0
// Checksum 0xb30520d5, Offset: 0x3068
// Size: 0x174
function function_8163bdfa(attacker, weapon) {
    plane = self;
    plane.destroyed = 1;
    if (isdefined(attacker) && (!isdefined(plane.owner) || plane.owner util::isenemyplayer(attacker))) {
        challenges::destroyedaircraft(attacker, weapon, 0);
        attacker challenges::addflyswatterstat(weapon, self);
        luinotifyevent(#"player_callout", 2, #"hash_5d32f6a46883ef3c", attacker.entnum);
        plane notify(#"hash_1fe75f940ce5fd52", {#is_killed:1});
    }
    if (plane.isleaving !== 1) {
        plane killstreaks::play_pilot_dialog_on_owner("destroyed", "artillery_barrage");
        plane killstreaks::play_destroyed_dialog_on_owner("artillery_barrage", self.killstreakid);
    }
}

// Namespace artillery_barrage/artillery_barrage_shared
// Params 2, eflags: 0x0
// Checksum 0xdba56eb, Offset: 0x31e8
// Size: 0x64
function function_54dd91e4(attacker, weapon) {
    bundle = level.killstreaks[#"artillery_barrage"].script_bundle;
    playfxontag(bundle.var_1407d9d, self, "tag_fx_engine3");
}

// Namespace artillery_barrage/artillery_barrage_shared
// Params 0, eflags: 0x0
// Checksum 0x3ef54f2e, Offset: 0x3258
// Size: 0x354
function function_148b5239() {
    plane = self;
    waitresult = plane waittill(#"hash_1fe75f940ce5fd52");
    killed = waitresult.is_killed;
    if (target_istarget(plane)) {
        target_remove(plane);
    }
    if (killed) {
        wait randomfloatrange(0.1, 0.2);
        plane function_5e159475();
        plane function_ab8ddbb2();
        plane thread function_c21618d0();
        goalx = randomfloatrange(650, 700);
        goaly = randomfloatrange(650, 700);
        if (randomintrange(0, 2) > 0) {
            goalx *= -1;
        }
        if (randomintrange(0, 2) > 0) {
            goaly *= -1;
        }
        planedir = anglestoforward(plane.angles);
        plane setplanegoalpos(plane.origin + (goalx, goaly, randomfloatrange(600, 700) * -1) + vectorscale(planedir, 3500));
        var_73949010 = randomfloatrange(3, 4);
        plane setplanebarrelroll(randomfloatrange(0.0833333, 0.111111), randomfloatrange(4, 5));
        plane_speed = plane getspeedmph();
        wait 0.7;
        plane setspeed(plane_speed * 1.5, 20);
        wait var_73949010 - 0.7;
        plane function_4016192a();
        wait 0.1;
        plane ghost();
        wait 0.5;
    } else {
        plane function_494675e6();
    }
    plane delete();
}

// Namespace artillery_barrage/artillery_barrage_shared
// Params 0, eflags: 0x0
// Checksum 0xeb24b68e, Offset: 0x35b8
// Size: 0x7c
function function_5e159475() {
    bundle = level.killstreaks[#"artillery_barrage"].script_bundle;
    playfxontag(bundle.var_5dff0b5e, self, "tag_fx_engine4");
    self playsound(level.heli_sound[#"crash"]);
}

// Namespace artillery_barrage/artillery_barrage_shared
// Params 0, eflags: 0x0
// Checksum 0xc23c9fdb, Offset: 0x3640
// Size: 0x54
function function_ab8ddbb2() {
    bundle = level.killstreaks[#"artillery_barrage"].script_bundle;
    playfxontag(bundle.var_1407d9d, self, "tag_fx_engine1");
}

// Namespace artillery_barrage/artillery_barrage_shared
// Params 0, eflags: 0x0
// Checksum 0x27e9ed0d, Offset: 0x36a0
// Size: 0x10c
function function_c21618d0() {
    bundle = level.killstreaks[#"artillery_barrage"].script_bundle;
    wait randomfloatrange(0.2, 0.4);
    playfxontag(bundle.var_1407d9d, self, "tag_fx_engine5");
    playfxontag(bundle.var_5dff0b5e, self, "tag_fx_engine4");
    self playsound(level.heli_sound[#"crash"]);
    wait randomfloatrange(0.2, 0.4);
    playfxontag(bundle.var_1407d9d, self, "tag_fx_engine3");
}

// Namespace artillery_barrage/artillery_barrage_shared
// Params 0, eflags: 0x0
// Checksum 0xf6b45e88, Offset: 0x37b8
// Size: 0x7c
function function_4016192a() {
    bundle = level.killstreaks[#"artillery_barrage"].script_bundle;
    playfxontag(bundle.ksexplosionfx, self, "tag_body_animate");
    self playsound(level.heli_sound[#"crash"]);
}

// Namespace artillery_barrage/artillery_barrage_shared
// Params 2, eflags: 0x0
// Checksum 0xc1b5cf04, Offset: 0x3840
// Size: 0x3c
function configurechopperteampost(owner, ishacked) {
    plane = self;
    plane thread watchownerdisconnect(owner);
}

// Namespace artillery_barrage/artillery_barrage_shared
// Params 1, eflags: 0x0
// Checksum 0xad3e5c5d, Offset: 0x3888
// Size: 0xb0
function watchownerdisconnect(owner) {
    self notify("4b076c5c988211fe");
    self endon("4b076c5c988211fe");
    plane = self;
    plane endon(#"hash_1fe75f940ce5fd52");
    owner waittill(#"joined_team", #"disconnect", #"joined_spectators");
    plane notify(#"hash_1fe75f940ce5fd52", {#is_killed:0});
}

// Namespace artillery_barrage/artillery_barrage_shared
// Params 0, eflags: 0x0
// Checksum 0x3d621523, Offset: 0x3940
// Size: 0x88
function watchgameended() {
    plane = self;
    plane endon(#"hash_1fe75f940ce5fd52");
    plane endon(#"death");
    level waittill(#"game_ended");
    plane notify(#"hash_1fe75f940ce5fd52", {#is_killed:0});
}

