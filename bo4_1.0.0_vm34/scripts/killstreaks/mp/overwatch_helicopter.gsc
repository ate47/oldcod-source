#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\oob;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\killstreaks\airsupport;
#using scripts\killstreaks\helicopter_shared;
#using scripts\killstreaks\killstreak_bundles;
#using scripts\killstreaks\killstreak_hacking;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\mp\swat_team;
#using scripts\mp_common\gametypes\battlechatter;
#using scripts\mp_common\gametypes\globallogic_audio;
#using scripts\mp_common\util;
#using scripts\weapons\hacker_tool;
#using scripts\weapons\heatseekingmissile;

#namespace overwatch_helicopter;

// Namespace overwatch_helicopter/overwatch_helicopter
// Params 0, eflags: 0x2
// Checksum 0x7e71b0c5, Offset: 0x398
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"overwatch_helicopter", &__init__, undefined, #"killstreaks");
}

// Namespace overwatch_helicopter/overwatch_helicopter
// Params 0, eflags: 0x0
// Checksum 0xcdffb035, Offset: 0x3e8
// Size: 0x354
function __init__() {
    killstreaks::register_killstreak("killstreak_overwatch_helicopter", &function_5527417e);
    killstreaks::register_alt_weapon("overwatch_helicopter", getweapon(#"hash_6c1be4b025206124"));
    killstreaks::set_team_kill_penalty_scale("overwatch_helicopter", level.teamkillreducedpenalty);
    callback::on_player_killed_with_params(&on_player_killed);
    level.var_18df0256 = &function_18df0256;
    level.killstreaks[#"overwatch_helicopter"].threatonkill = 1;
    level.var_a8adc247 = getdvarint(#"hash_1300f6ba32e8d68c", 2500);
    level.var_e4560d96 = getdvarint(#"hash_163c95340307e3aa", 1800);
    level.var_89b02f08 = getdvarint(#"hash_16579f34031ebc60", 2000);
    level.var_c64714c8 = getdvarint(#"hash_3a28b6936bc7d2a9", 200);
    level.var_28b3556b = getdvarint(#"hash_26f6fa23a134bc05", 4);
    level.var_3dd1fd05 = getdvarint(#"hash_27120423a14b94bb", 6);
    if (!isdefined(level.var_9c4fd5ca)) {
        level.var_9c4fd5ca = [];
        level.var_9c4fd5ca[#"allies"] = [];
        level.var_9c4fd5ca[#"allies"][0] = "spawner_mp_swat_gunner_team1_male";
        level.var_9c4fd5ca[#"allies"][1] = "spawner_mp_swat_gunner_team1_female";
        level.var_9c4fd5ca[#"allies"][2] = "spawner_mp_swat_gunner_team1_male";
        level.var_9c4fd5ca[#"axis"] = [];
        level.var_9c4fd5ca[#"axis"][0] = "spawner_mp_swat_gunner_team2_male";
        level.var_9c4fd5ca[#"axis"][1] = "spawner_mp_swat_gunner_team2_female";
        level.var_9c4fd5ca[#"axis"][2] = "spawner_mp_swat_gunner_team2_male";
    }
}

// Namespace overwatch_helicopter/overwatch_helicopter
// Params 1, eflags: 0x0
// Checksum 0x1fccdc09, Offset: 0x748
// Size: 0xd0
function function_5527417e(var_e409027f) {
    if (!self killstreakrules::iskillstreakallowed("overwatch_helicopter", self.team)) {
        return 0;
    }
    self val::set(#"hash_1ddc89a14806a229", "freezecontrols");
    result = self function_680c31b1();
    self val::reset(#"hash_1ddc89a14806a229", "freezecontrols");
    if (level.gameended) {
        return 1;
    }
    if (!isdefined(result)) {
        return 0;
    }
    return result;
}

// Namespace overwatch_helicopter/overwatch_helicopter
// Params 0, eflags: 0x0
// Checksum 0x9b52d68a, Offset: 0x820
// Size: 0x600
function function_680c31b1() {
    player = self;
    player endon(#"disconnect");
    level endon(#"game_ended");
    killstreak_id = player killstreakrules::killstreakstart("overwatch_helicopter", player.team, undefined, 1);
    if (killstreak_id == -1) {
        return false;
    }
    if (!isdefined(level.heli_primary_path) || !level.heli_primary_path.size) {
        return false;
    }
    random_path = randomint(level.heli_paths[0].size);
    startnode = level.heli_paths[0][random_path];
    protectlocation = (player.origin[0], player.origin[1], int(airsupport::getminimumflyheight()));
    bundle = struct::get_script_bundle("killstreak", "killstreak_overwatch_helicopter");
    helicopter = spawnvehicle(bundle.ksvehicle, startnode.origin, startnode.angles);
    helicopter setowner(player);
    helicopter killstreaks::configure_team("overwatch_helicopter", killstreak_id, player, "helicopter");
    helicopter.killstreak_id = killstreak_id;
    helicopter.destroyfunc = &deletehelicoptercallback;
    helicopter.hardpointtype = "overwatch_helicopter";
    helicopter clientfield::set("enemyvehicle", 1);
    helicopter vehicle::init_target_group();
    helicopter.killstreak_timer_started = 0;
    helicopter.allowdeath = 0;
    helicopter.targeting_delay = level.heli_targeting_delay;
    helicopter.playermovedrecently = 0;
    helicopter.soundmod = "heli";
    helicopter.usage = [];
    helicopter.shuttingdown = 0;
    helicopter.maxhealth = isdefined(killstreak_bundles::get_max_health("overwatch_helicopter")) ? killstreak_bundles::get_max_health("overwatch_helicopter") : 5000;
    helicopter.original_health = helicopter.maxhealth;
    helicopter.health = helicopter.maxhealth;
    helicopter.damagetaken = 0;
    helicopter thread helicopter::heli_health("overwatch_helicopter");
    helicopter setcandamage(1);
    target_set(helicopter, (0, 0, -100));
    target_setallowhighsteering(helicopter, 1);
    helicopter thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile("death");
    helicopter thread helicopter::create_flare_ent((0, 0, -150));
    helicopter.totalrockethits = 0;
    helicopter.turretrockethits = 0;
    helicopter.overridevehicledamage = &function_3044d91c;
    helicopter thread helicopter::heli_health("overwatch_helicopter");
    helicopter thread function_aa916444(startnode, protectlocation, "overwatch_helicopter", player.team);
    helicopter thread helicopter::heli_targeting(0, "overwatch_helicopter");
    player thread killstreaks::play_killstreak_start_dialog("overwatch_helicopter", player.team, killstreak_id);
    helicopter killstreaks::play_pilot_dialog_on_owner("arrive", "overwatch_helicopter", killstreak_id);
    settings = getscriptbundle("killstreak_overwatch_helicopter");
    player addweaponstat(settings.ksweapon, #"used", 1);
    player thread function_dfa7581(helicopter);
    player thread watchplayerteamchangethread(helicopter);
    function_a2ee96(player, helicopter);
    util::function_d1f9db00(21, player.team, player getentitynumber(), #"hash_76bc8a74d60388e4");
    return true;
}

// Namespace overwatch_helicopter/overwatch_helicopter
// Params 3, eflags: 0x0
// Checksum 0x36da138a, Offset: 0xe28
// Size: 0x19c
function function_20d55215(helicopter, player, ownerleft) {
    if (!isdefined(helicopter) || helicopter.completely_shutdown === 1) {
        return;
    }
    if (isdefined(player)) {
        player vehicle::stop_monitor_missiles_locked_on_to_me();
        player vehicle::stop_monitor_damage_as_occupant();
    }
    helicopter.shuttingdown = 1;
    helicopter.occupied = 0;
    helicopter.hardpointtype = "overwatch_helicopter";
    helicopter thread audio::sndupdatevehiclecontext(0);
    if (isdefined(player)) {
        player notify(#"overwatch_left");
    }
    helicopter.completely_shutdown = 1;
    if (isdefined(helicopter.var_3ba5a2d9)) {
        foreach (swat_gunner in helicopter.var_3ba5a2d9) {
            if (isdefined(swat_gunner)) {
                swat_gunner.ignoreall = 1;
            }
        }
    }
    helicopter helicopter::heli_leave();
    swat_cleanup(helicopter);
}

// Namespace overwatch_helicopter/overwatch_helicopter
// Params 0, eflags: 0x0
// Checksum 0x8106e72e, Offset: 0xfd0
// Size: 0x28
function deletehelicoptercallback() {
    helicopter = self;
    helicopter notify(#"hash_3904c1a9ebdc27de");
}

// Namespace overwatch_helicopter/overwatch_helicopter
// Params 15, eflags: 0x0
// Checksum 0x57a590b1, Offset: 0x1000
// Size: 0x3ae
function function_3044d91c(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    helicopter = self;
    if (smeansofdeath == "MOD_TRIGGER_HURT") {
        return 0;
    }
    if (helicopter.shuttingdown) {
        return 0;
    }
    idamage = self killstreaks::ondamageperweapon("overwatch_helicopter", eattacker, idamage, idflags, smeansofdeath, weapon, helicopter.maxhealth, undefined, helicopter.maxhealth * 0.4, undefined, 0, undefined, 1, 1);
    if (idamage == 0) {
        return 0;
    }
    handleasrocketdamage = smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_EXPLOSIVE";
    if (weapon.statindex == level.weaponshotgunenergy.statindex || weapon.statindex == level.weaponpistolenergy.statindex) {
        handleasrocketdamage = 0;
    }
    if (idamage >= helicopter.health && !helicopter.shuttingdown) {
        helicopter.shuttingdown = 1;
        helicopter thread wait_and_explode();
        eattacker = self [[ level.figure_out_attacker ]](eattacker);
        if (!isdefined(helicopter.destroyscoreeventgiven) && isdefined(eattacker) && (!isdefined(helicopter.owner) || helicopter.owner util::isenemyplayer(eattacker))) {
            if (isplayer(eattacker)) {
                luinotifyevent(#"player_callout", 2, #"hash_bbc64fd3a1e88d", eattacker.entnum);
                helicopter killstreaks::function_8acf563(eattacker, weapon, helicopter.owner);
                helicopter killstreaks::play_destroyed_dialog_on_owner("overwatch_helicopter", helicopter.killstreak_id);
                eattacker battlechatter::function_b5530e2c("overwatch_helicopter", weapon);
                helicopter.destroyscoreeventgiven = 1;
            }
        }
        helicopter thread performleavehelicopterfromdamage();
    } else if (!helicopter.shuttingdown && !(isdefined(helicopter.var_5f24e046) && helicopter.var_5f24e046)) {
        helicopter killstreaks::play_pilot_dialog_on_owner("damaged", "overwatch_helicopter", helicopter.killstreak_id);
        helicopter.var_5f24e046 = 1;
    }
    return idamage;
}

// Namespace overwatch_helicopter/overwatch_helicopter
// Params 0, eflags: 0x0
// Checksum 0xc84c3c2f, Offset: 0x13b8
// Size: 0x5e
function wait_and_explode() {
    self endon(#"death");
    wait 2;
    if (isdefined(self)) {
        self vehicle::do_death_fx();
        wait 0.25;
        if (isdefined(self)) {
            self notify(#"hash_3904c1a9ebdc27de");
        }
    }
}

// Namespace overwatch_helicopter/overwatch_helicopter
// Params 0, eflags: 0x0
// Checksum 0xe30b5f0c, Offset: 0x1420
// Size: 0x9c
function performleavehelicopterfromdamage() {
    helicopter = self;
    helicopter endon(#"death");
    if (self.leave_by_damage_initiated === 1) {
        return;
    }
    self.leave_by_damage_initiated = 1;
    failsafe_timeout = 5;
    helicopter waittilltimeout(failsafe_timeout, #"static_fx_done");
    function_20d55215(helicopter, helicopter.owner, 1);
}

// Namespace overwatch_helicopter/overwatch_helicopter
// Params 1, eflags: 0x0
// Checksum 0xd9a64332, Offset: 0x14c8
// Size: 0x162
function function_dfa7581(helicopter) {
    waitresult = helicopter waittill(#"hash_3904c1a9ebdc27de");
    attacker = waitresult.attacker;
    if (isdefined(attacker)) {
        luinotifyevent(#"player_callout", 2, #"hash_20aa28bee9cfdd61", attacker.entnum);
    }
    if (target_istarget(helicopter)) {
        target_remove(helicopter);
    }
    if (isdefined(helicopter.flare_ent)) {
        helicopter.flare_ent delete();
        helicopter.flare_ent = undefined;
    }
    killstreakrules::killstreakstop("overwatch_helicopter", helicopter.originalteam, helicopter.killstreak_id);
    function_20d55215(helicopter, helicopter.owner, 1);
    helicopter delete();
    helicopter = undefined;
}

// Namespace overwatch_helicopter/overwatch_helicopter
// Params 1, eflags: 0x0
// Checksum 0x83b0cde6, Offset: 0x1638
// Size: 0x120
function watchplayerteamchangethread(helicopter) {
    helicopter notify(#"hash_73c07c54a285eb73");
    helicopter endon(#"hash_73c07c54a285eb73");
    assert(isplayer(self));
    player = self;
    player endon(#"overwatch_left");
    player waittill(#"joined_team", #"disconnect", #"joined_spectators");
    ownerleft = helicopter.ownerentnum == player.entnum;
    player thread function_20d55215(helicopter, player, ownerleft);
    if (ownerleft) {
        helicopter notify(#"hash_3904c1a9ebdc27de");
    }
}

// Namespace overwatch_helicopter/overwatch_helicopter
// Params 4, eflags: 0x0
// Checksum 0x574c59df, Offset: 0x1760
// Size: 0x1aa
function function_f56a549(startnode, protectdest, hardpointtype, heli_team) {
    self endon(#"death", #"abandoned");
    self.protectdest = protectdest;
    self.var_f1a9f7c5 = protectdest;
    radius = 10000;
    if (isdefined(self.owner)) {
        radius = distance(protectdest, self.origin);
    }
    var_40c02d23 = getclosestpointonnavvolume(protectdest, "navvolume_big", radius);
    if (isdefined(var_40c02d23)) {
        protectdest = var_40c02d23;
        self.var_f1a9f7c5 = protectdest;
        var_c987c8fc = heli_get_protect_spot(protectdest, 300, heli_team);
        if (isdefined(var_c987c8fc)) {
            self helicopter::function_6d273cc0(var_c987c8fc.origin, 1);
            protectdest = var_c987c8fc.origin;
            self.var_f1a9f7c5 = var_c987c8fc.origin;
        } else {
            self helicopter::function_6d273cc0(protectdest, 1);
        }
    }
    self helicopter::function_6d273cc0(protectdest, 1);
    self waittill(#"near_goal");
}

// Namespace overwatch_helicopter/overwatch_helicopter
// Params 4, eflags: 0x0
// Checksum 0x9999e0a9, Offset: 0x1918
// Size: 0x31c
function function_aa916444(startnode, protectdest, hardpointtype, heli_team) {
    self endon(#"death", #"abandoned");
    helicopter::heli_reset();
    self.reached_dest = 0;
    self.goalradius = 30;
    starttime = gettime();
    self.halftime = starttime + int(level.heli_protect_time * 0.5 * 1000);
    self.killstreakendtime = starttime + int(level.heli_protect_time * 1000);
    self.endtime = starttime + int(level.heli_protect_time * 1000);
    var_fc62536f = level.heli_protect_pos_time;
    self thread helicopter::function_b973a2e3();
    self thread helicopter::function_91fa8e0d();
    self function_f56a549(startnode, protectdest, hardpointtype, heli_team);
    while (gettime() < self.killstreakendtime) {
        if (!(isdefined(self.var_b79daf6c) && self.var_b79daf6c) && gettime() >= self.halftime) {
            self killstreaks::play_pilot_dialog_on_owner("timecheck", hardpointtype);
            self.var_b79daf6c = 1;
        }
        var_fc62536f = randomintrange(level.var_28b3556b, level.var_3dd1fd05);
        waitresult = self waittilltimeout(var_fc62536f, #"locking on", #"locking on hacking", #"damage state");
        newdest = heli_get_protect_spot(protectdest, undefined, heli_team);
        if (isdefined(newdest)) {
            self helicopter::function_6d273cc0(newdest.origin, 1);
            self waittill(#"near_goal");
        } else {
            wait var_fc62536f;
        }
        hostmigration::waittillhostmigrationdone();
    }
    self helicopter::heli_set_active_camo_state(1);
    self thread function_20d55215(self, self.owner, 0);
}

// Namespace overwatch_helicopter/overwatch_helicopter
// Params 1, eflags: 0x0
// Checksum 0x28972d38, Offset: 0x1c40
// Size: 0xaa
function function_5e5d399b(helicopter) {
    if (isdefined(helicopter.var_3ba5a2d9)) {
        foreach (swat in helicopter.var_3ba5a2d9) {
            if (isdefined(swat) && isdefined(swat.enemy)) {
                return swat.enemy;
            }
        }
    }
    return undefined;
}

// Namespace overwatch_helicopter/overwatch_helicopter
// Params 3, eflags: 0x0
// Checksum 0x737cd8e7, Offset: 0x1cf8
// Size: 0x42e
function heli_get_protect_spot(protectdest, overrideradius, heli_team) {
    assert(isdefined(level.var_a8adc247));
    if (!isdefined(overrideradius)) {
        overrideradius = level.var_a8adc247;
    }
    min_radius = int(overrideradius * 0.6);
    max_radius = overrideradius;
    groundpos = getclosestpointonnavmesh(protectdest, 10000);
    assert(isdefined(level.var_e4560d96) && isdefined(level.var_89b02f08));
    assert(isdefined(level.var_89b02f08 >= level.var_e4560d96));
    heightmin = level.var_e4560d96;
    heightmax = level.var_89b02f08;
    if (heli_team == #"axis") {
        assert(isdefined(level.var_c64714c8));
        heightmin += level.var_c64714c8;
        heightmax += level.var_c64714c8;
    }
    hoverheight = heightmin + (heightmax - heightmin) / 2;
    radius = 10000;
    if (isdefined(groundpos)) {
        var_6f77f9b8 = undefined;
        target = function_5e5d399b(self);
        if (isdefined(target)) {
            var_6f77f9b8 = getclosestpointonnavmesh(target.origin, 10000);
        }
        if (isdefined(var_6f77f9b8)) {
            groundpos = var_6f77f9b8;
        }
        protectdest = (groundpos[0], groundpos[1], groundpos[2] + hoverheight);
        protectdest = getclosestpointonnavvolume(protectdest, "navvolume_big", radius);
        self.var_29ef9ebf = groundpos;
        self.var_b0b3cf42 = protectdest;
        halfheight = (heightmax - heightmin) / 2;
        queryresult = positionquery_source_navigation(protectdest, min_radius, max_radius, halfheight, 50, self);
        if (isdefined(queryresult.data) && queryresult.data.size) {
            validpoints = [];
            var_4ca2e438 = randomintrange(heightmin, heightmax);
            foreach (point in queryresult.data) {
                distsq = distancesquared(self.origin, point.origin);
                if (distsq >= var_4ca2e438 * var_4ca2e438) {
                    array::add(validpoints, point);
                }
            }
            if (validpoints.size) {
                return array::random(validpoints);
            }
        }
    }
    return undefined;
}

// Namespace overwatch_helicopter/overwatch_helicopter
// Params 2, eflags: 0x0
// Checksum 0x8434ece8, Offset: 0x2130
// Size: 0x4ae
function function_a2ee96(owner, helicopter) {
    assert(isdefined(helicopter));
    owner.var_3ba5a2d9 = [];
    helicopter.var_3ba5a2d9 = [];
    aitypes = level.var_9c4fd5ca[#"axis"];
    if (isdefined(owner.team) && owner.team == #"allies") {
        aitypes = level.var_9c4fd5ca[#"allies"];
    }
    for (i = 0; i < 3; i++) {
        swat_gunner = spawnactor(aitypes[i], helicopter.origin, (0, 0, 0), "swat_gunner");
        if (!isdefined(owner.var_3ba5a2d9)) {
            owner.var_3ba5a2d9 = [];
        } else if (!isarray(owner.var_3ba5a2d9)) {
            owner.var_3ba5a2d9 = array(owner.var_3ba5a2d9);
        }
        owner.var_3ba5a2d9[owner.var_3ba5a2d9.size] = swat_gunner;
        if (!isdefined(helicopter.var_3ba5a2d9)) {
            helicopter.var_3ba5a2d9 = [];
        } else if (!isarray(helicopter.var_3ba5a2d9)) {
            helicopter.var_3ba5a2d9 = array(helicopter.var_3ba5a2d9);
        }
        helicopter.var_3ba5a2d9[helicopter.var_3ba5a2d9.size] = swat_gunner;
        swat_gunner setentityowner(owner);
        swat_gunner setteam(owner.team);
        swat_gunner.voxid = i;
        aiutility::addaioverridedamagecallback(swat_gunner, &swat_team::function_eabb08f8);
        swat_gunner swat_team::function_27eb0046(swat_gunner);
        swat_gunner thread swat_team::function_16eeeb93(owner);
        swat_gunner callback::function_1dea870d(#"on_ai_damage", &function_fb881366);
        if (i == 0) {
            swat_gunner linkto(helicopter, "tag_rider1", (0, 0, 0), (0, 90, 0));
        } else if (i == 1) {
            swat_gunner linkto(helicopter, "tag_rider2", (0, 0, 0), (0, -90, 0));
        } else {
            swat_gunner linkto(helicopter, "tag_driver", (0, 0, 0), (0, 0, 0));
            swat_gunner.ai.var_e8804f32 = 1;
            swat_gunner.ignoreall = 1;
            swat_gunner ai::gun_remove();
        }
        swat_gunner.ai.swat_gunner = 1;
        swat_gunner function_27eb0046(swat_gunner);
        swat_gunner thread swat_team::function_16eeeb93(owner);
        swat_gunner thread function_885c54ce(swat_gunner, helicopter);
        swat_gunner thread function_75a32df0(swat_gunner, helicopter);
        swat_gunner thread function_1684cecb(swat_gunner, helicopter);
        swat_gunner thread aiutility::preshootlaserandglinton(swat_gunner);
        swat_gunner thread aiutility::postshootlaserandglintoff(swat_gunner);
    }
}

// Namespace overwatch_helicopter/overwatch_helicopter
// Params 2, eflags: 0x0
// Checksum 0xe84a74e4, Offset: 0x25e8
// Size: 0x146
function function_1684cecb(swat_gunner, helicopter) {
    swat_gunner endon(#"death");
    while (true) {
        event = undefined;
        if (isdefined(self.enemy)) {
            enemy = self.enemy;
            result = self waittill(#"enemy");
            if (isdefined(self.enemy)) {
                event = "found_new_enemy";
            } else if (isalive(enemy)) {
                event = "lost_enemy";
            }
        } else {
            result = self waittill(#"enemy");
            event = "found_new_enemy";
        }
        if (!isdefined(event)) {
            waitframe(1);
            continue;
        }
        switch (event) {
        case #"found_new_enemy":
            break;
        case #"lost_enemy":
            break;
        default:
            break;
        }
    }
}

// Namespace overwatch_helicopter/overwatch_helicopter
// Params 1, eflags: 0x4
// Checksum 0xcf329ece, Offset: 0x2738
// Size: 0x2f2
function private on_player_killed(params) {
    self notify("11bf2109b788686");
    self endon("11bf2109b788686");
    if (!isdefined(params) || !isdefined(self) || !isdefined(params.einflictor) || !isdefined(params.einflictor.script_owner) || !isdefined(params.einflictor.voxid) || !isdefined(params.einflictor.ai) || !(isdefined(params.einflictor.ai.swat_gunner) && params.einflictor.ai.swat_gunner) || params.einflictor.weapon.name != #"hash_6c1be4b025206124" || self == params.einflictor.script_owner || level.teambased && self.team == params.einflictor.script_owner.team) {
        return;
    }
    swat_gunner = params.einflictor;
    if (!isdefined(swat_gunner.bda)) {
        swat_gunner.bda = 0;
    }
    swat_gunner.bda++;
    wait 2;
    if (!isdefined(swat_gunner) || !isdefined(swat_gunner.script_owner)) {
        return;
    }
    if (swat_gunner.voxid == 0) {
        if (swat_gunner.bda == 1) {
            swat_gunner.script_owner globallogic_audio::play_taacom_dialog("kill1", "overwatch_helicopter_snipers");
        } else {
            swat_gunner.script_owner globallogic_audio::play_taacom_dialog("killMultiple", "overwatch_helicopter_snipers");
        }
    } else if (swat_gunner.bda == 1) {
        swat_gunner.script_owner globallogic_audio::play_taacom_dialog("secondaryKill1", "overwatch_helicopter_snipers");
    } else {
        swat_gunner.script_owner globallogic_audio::play_taacom_dialog("secondaryKillMultiple", "overwatch_helicopter_snipers");
    }
    swat_gunner.bda = 0;
}

// Namespace overwatch_helicopter/overwatch_helicopter
// Params 1, eflags: 0x0
// Checksum 0x1c812478, Offset: 0x2a38
// Size: 0xea
function function_fb881366(params) {
    if (!isdefined(self) || !isdefined(self.voxid) || !isdefined(self.script_owner) || isdefined(self.var_63a55000) && self.var_63a55000 || self.damagetaken > self.maxhealth * 0.5) {
        return;
    }
    if (self.voxid == 0) {
        self.script_owner globallogic_audio::play_taacom_dialog("damaged", "overwatch_helicopter_snipers");
    } else {
        self.script_owner globallogic_audio::play_taacom_dialog("damaged1", "overwatch_helicopter_snipers");
    }
    self.var_63a55000 = 1;
}

// Namespace overwatch_helicopter/overwatch_helicopter
// Params 2, eflags: 0x0
// Checksum 0xffb80a8d, Offset: 0x2b30
// Size: 0x136
function function_18df0256(var_2c02a525, owner) {
    if (!isdefined(self) || !isdefined(owner) || !isplayer(var_2c02a525) || var_2c02a525.team == owner.team || self.enemy != var_2c02a525) {
        return;
    }
    if (owner.killstreakdialogqueue.size > 1 || isdefined(owner.currentkillstreakdialog) || isdefined(owner.var_2c8c0646) && owner.var_2c8c0646 < gettime()) {
        return;
    }
    if (self.voxid == 0) {
        owner globallogic_audio::play_taacom_dialog("killNone", "overwatch_helicopter_snipers");
    } else {
        owner globallogic_audio::play_taacom_dialog("secondaryKillNone", "overwatch_helicopter_snipers");
    }
    owner.var_2c8c0646 = gettime() + 5000;
}

// Namespace overwatch_helicopter/overwatch_helicopter
// Params 1, eflags: 0x4
// Checksum 0x86614011, Offset: 0x2c70
// Size: 0x60
function private function_68d27db2(swat_gunner) {
    self endon(#"death");
    while (true) {
        swat_gunner animation::play(#"ai_crew_macv_driver_idle", self.origin, self.angles);
    }
}

// Namespace overwatch_helicopter/overwatch_helicopter
// Params 1, eflags: 0x0
// Checksum 0xea888edb, Offset: 0x2cd8
// Size: 0x6e
function function_27eb0046(swat_gunner) {
    swat_gunner.perfectaim = 1;
    swat_gunner.sightlatency = 0;
    swat_gunner.fovcosine = 0;
    swat_gunner.fovcosinebusy = 0;
    swat_gunner laseron();
    self.health = 800;
    self.maxhealth = 2000;
}

// Namespace overwatch_helicopter/overwatch_helicopter
// Params 2, eflags: 0x4
// Checksum 0x48c90f14, Offset: 0x2d50
// Size: 0x1bc
function private function_885c54ce(swat, helicopter) {
    swat waittill(#"death");
    if (isdefined(helicopter) && !helicopter.shuttingdown) {
        if (isdefined(helicopter.var_3ba5a2d9)) {
            foreach (swat_gunner in helicopter.var_3ba5a2d9) {
                if (isdefined(swat_gunner) && isalive(swat_gunner) && !(isdefined(swat_gunner.ignoreall) && swat_gunner.ignoreall)) {
                    var_7c49cbf5 = 1;
                    break;
                }
            }
        }
        if (isdefined(var_7c49cbf5) && var_7c49cbf5) {
            helicopter killstreaks::play_pilot_dialog_on_owner("weaponDestroyed", "overwatch_helicopter", helicopter.killstreak_id);
        } else {
            helicopter killstreaks::play_pilot_dialog_on_owner("destroyed", "overwatch_helicopter", helicopter.killstreak_id);
        }
    }
    if (isdefined(swat)) {
        swat unlink();
        swat startragdoll();
    }
}

// Namespace overwatch_helicopter/overwatch_helicopter
// Params 3, eflags: 0x4
// Checksum 0xba2543ec, Offset: 0x2f18
// Size: 0xac
function private function_75a32df0(swat, helicopter, killstreak_id) {
    swat endon(#"death");
    helicopter endon(#"death");
    helicopter waittill(#"hash_3904c1a9ebdc27de");
    swat unlink();
    swat startragdoll();
    swat kill();
}

// Namespace overwatch_helicopter/overwatch_helicopter
// Params 1, eflags: 0x4
// Checksum 0x81696675, Offset: 0x2fd0
// Size: 0xae
function private swat_cleanup(helicopter) {
    if (isdefined(helicopter.var_3ba5a2d9)) {
        for (i = helicopter.var_3ba5a2d9.size; i >= 0; i--) {
            if (isdefined(helicopter.var_3ba5a2d9[i]) && isalive(helicopter.var_3ba5a2d9[i])) {
                helicopter.var_3ba5a2d9[i] delete();
            }
        }
    }
}

