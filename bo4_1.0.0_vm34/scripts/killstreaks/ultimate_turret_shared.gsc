#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\placeables;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\popups_shared;
#using scripts\core_common\targetting_delay;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\killstreaks\killstreak_bundles;
#using scripts\killstreaks\killstreak_hacking;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\remote_weapons;
#using scripts\weapons\deployable;
#using scripts\weapons\weaponobjects;

#namespace ultimate_turret;

// Namespace ultimate_turret/ultimate_turret_shared
// Params 0, eflags: 0x0
// Checksum 0xcd3c00b0, Offset: 0x3b0
// Size: 0x354
function init_shared() {
    if (!isdefined(level.ultimate_turret_shared)) {
        level.ultimate_turret_shared = {};
        killstreaks::register_killstreak("killstreak_ultimate_turret", &activateturret);
        killstreaks::register_alt_weapon("ultimate_turret", getweapon("ultimate_turret_deploy"));
        killstreaks::function_96737296("ultimate_turret", getweapon("ultimate_turret_deploy"));
        killstreaks::register_alt_weapon("ultimate_turret", getweapon(#"gun_ultimate_turret"));
        killstreaks::allow_assists("ultimate_turret", 1);
        level.killstreaks[#"ultimate_turret"].threatonkill = 1;
        clientfield::register("vehicle", "ultimate_turret_open", 1, 1, "int");
        clientfield::register("vehicle", "ultimate_turret_init", 1, 1, "int");
        clientfield::register("vehicle", "ultimate_turret_close", 1, 1, "int");
        clientfield::register("clientuimodel", "hudItems.ultimateTurretCount", 1, 3, "int");
        level.var_9cbcea6d = "o_turret_sentry_deploy";
        level.var_1f47d6a1 = "o_turret_sentry_close";
        if (sessionmodeiscampaigngame()) {
            vehicle::add_main_callback("veh_ultimate_turret" + "_cp", &initturret);
        } else {
            vehicle::add_main_callback("veh_ultimate_turret", &initturret);
        }
        callback::on_spawned(&on_player_spawned);
        callback::on_player_killed(&on_player_killed);
        weaponobjects::function_f298eae6(#"ultimate_turret", &function_3075fea3, undefined);
        weaponobjects::function_f298eae6(#"inventory_ultimate_turret", &function_3075fea3, undefined);
        level.var_b74546df = 0;
        deployable::register_deployable(getweapon("ultimate_turret"), undefined);
    }
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 0, eflags: 0x0
// Checksum 0xc42a4b6a, Offset: 0x710
// Size: 0x76
function on_player_spawned() {
    weapon = getweapon("ultimate_turret");
    if (isdefined(weapon) && !self hasweapon(weapon)) {
        self clientfield::set_player_uimodel("hudItems.ultimateTurretCount", 0);
    }
    self.var_96a00271 = undefined;
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 0, eflags: 0x0
// Checksum 0xff96d7bc, Offset: 0x790
// Size: 0x126
function initturret() {
    turretvehicle = self;
    turretvehicle.dontfreeme = 1;
    turretvehicle.damage_on_death = 0;
    turretvehicle.delete_on_death = undefined;
    turretvehicle.maxhealth = 2000;
    turretvehicle.damagetaken = 0;
    tablehealth = killstreak_bundles::get_max_health("ultimate_turret");
    if (isdefined(tablehealth)) {
        turretvehicle.maxhealth = tablehealth;
    }
    turretvehicle.health = turretvehicle.maxhealth;
    turretvehicle turretsetontargettolerance(0, 15);
    turretvehicle clientfield::set("enemyvehicle", 1);
    turretvehicle.soundmod = "mini_turret";
    turretvehicle.overridevehicledamage = &onturretdamage;
    turretvehicle.overridevehiclekilled = &onturretdeath;
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 0, eflags: 0x0
// Checksum 0x7d4791c6, Offset: 0x8c0
// Size: 0x73a
function activateturret() {
    player = self;
    assert(isplayer(player));
    if (isdefined(player.var_96a00271)) {
        return false;
    }
    killstreakid = self killstreakrules::killstreakstart("ultimate_turret", player.team, 0, 0);
    if (killstreakid == -1) {
        return false;
    }
    if (level.var_b74546df) {
        return false;
    }
    bundle = level.killstreakbundle[#"ultimate_turret"];
    var_ce2438e6 = 0;
    if (var_ce2438e6) {
        turret = player killstreaks::function_ee1921e5("ultimate_turret", killstreakid, &onplaceturret, &oncancelplacement, undefined, &onshutdown, undefined, undefined, "tag_origin", "tag_origin", "tag_origin", 1, #"killstreak_sentry_turret_pickup", bundle.ksduration, undefined, 0, bundle.ksplaceablehint, bundle.ksplaceableinvalidlocationhint);
        turret thread watchturretshutdown(player, killstreakid, player.team);
        turret thread util::ghost_wait_show_to_player(player);
        turret.othermodel thread util::ghost_wait_show_to_others(player);
        event = turret waittill(#"placed", #"cancelled", #"death");
        if (event._notify != "placed") {
            return false;
        }
        return true;
    }
    turret_team = player.team;
    if (false) {
        var_8f5d1127 = getweapon(#"ultimate_turret_deploy");
        if (var_8f5d1127 == level.weaponnone) {
            return false;
        }
        player.var_96a00271 = killstreakid;
        player giveweapon(var_8f5d1127);
        slot = player gadgetgetslot(var_8f5d1127);
        player gadgetpowerreset(slot);
        player gadgetpowerset(slot, 100);
        waitresult = player waittilltimeout(0.1, #"death");
        if (!isdefined(waitresult._notify) || waitresult._notify == "death") {
            if (isdefined(player)) {
                player.var_96a00271 = undefined;
            }
            killstreakrules::killstreakstop("ultimate_turret", turret_team, killstreakid);
            return false;
        }
        player switchtoweapon(var_8f5d1127);
        player setoffhandvisible(1);
        waitresult = player waittill(#"death", #"weapon_change");
        if (!isdefined(waitresult._notify) || waitresult._notify == "death") {
            if (isdefined(player)) {
                player setoffhandvisible(0);
                player.var_96a00271 = undefined;
            }
            killstreakrules::killstreakstop("ultimate_turret", turret_team, killstreakid);
            return false;
        }
    }
    waitresult = player waittill(#"ultimate_turret_deployed", #"death", #"weapon_change", #"weapon_fired");
    if (waitresult._notify === "weapon_change" && waitresult.last_weapon === var_8f5d1127 && waitresult.weapon === level.weaponnone) {
        waitresult = player waittilltimeout(2, #"ultimate_turret_deployed", #"death");
    } else if (waitresult._notify === "weapon_change" && waitresult.weapon === var_8f5d1127) {
        waitresult = player waittill(#"ultimate_turret_deployed", #"death", #"weapon_fired");
    }
    if (isdefined(player) && false) {
        player takeweapon(var_8f5d1127);
    }
    if (waitresult._notify === "weapon_fired") {
        waitresult = player waittill(#"ultimate_turret_deployed", #"death");
    }
    if (!isdefined(waitresult._notify) || waitresult._notify != "ultimate_turret_deployed") {
        if (isdefined(player)) {
            player setoffhandvisible(0);
            player.var_96a00271 = undefined;
        }
        killstreakrules::killstreakstop("ultimate_turret", turret_team, killstreakid);
        return false;
    }
    if (waitresult._notify == "ultimate_turret_deployed" && isdefined(waitresult.turret)) {
        waitresult.turret thread watchturretshutdown(player, waitresult.turret.killstreakid, player.team);
    }
    player.var_96a00271 = undefined;
    return true;
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 1, eflags: 0x0
// Checksum 0xf2031fd0, Offset: 0x1008
// Size: 0x32
function function_3075fea3(watcher) {
    watcher.onspawn = &function_83353a1b;
    watcher.deleteonplayerspawn = 0;
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 2, eflags: 0x0
// Checksum 0x6d7738ce, Offset: 0x1048
// Size: 0x3f2
function function_83353a1b(watcher, player) {
    player endon(#"death");
    player endon(#"disconnect");
    level endon(#"game_ended");
    self endon(#"death");
    slot = player gadgetgetslot(self.weapon);
    player gadgetpowerreset(slot);
    player gadgetpowerset(slot, 0);
    self weaponobjects::onspawnuseweaponobject(watcher, player);
    self hide();
    var_d18e9bbb = 0;
    if (var_d18e9bbb && isdefined(player)) {
        player val::set(#"ultimate_turret", "freezecontrols");
    }
    self waittill(#"stationary");
    player stats::function_4f10b697(self.weapon, #"used", 1);
    player notify(#"ultimate_turret_deployed", {#turret:self});
    self deployable::function_c334d8f9(player);
    self.origin += (0, 0, 2);
    player onplaceturret(self);
    if (var_d18e9bbb && isdefined(player)) {
        player val::reset(#"ultimate_turret", "freezecontrols");
    }
    if (!isdefined(player.var_ec37a54c)) {
        player.var_ec37a54c = [];
    }
    if (!isdefined(player.var_ec37a54c)) {
        player.var_ec37a54c = [];
    } else if (!isarray(player.var_ec37a54c)) {
        player.var_ec37a54c = array(player.var_ec37a54c);
    }
    player.var_ec37a54c[player.var_ec37a54c.size] = self.vehicle;
    player clientfield::set_player_uimodel("hudItems.ultimateTurretCount", player.var_ec37a54c.size);
    if (isdefined(self.weapon) && isdefined(self.vehicle)) {
        self.vehicle thread weaponobjects::function_15617e5c(self.weapon.fusetime, &function_ab629407);
        self thread function_542371bc();
    }
    self ghost();
    self thread function_69af0157();
    self.vehicle thread function_b84173e2();
    self.vehicle.var_b0c1f126 = getweapon(#"ultimate_turret").var_b0c1f126;
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 0, eflags: 0x0
// Checksum 0x55adbdfd, Offset: 0x1448
// Size: 0x74
function function_542371bc() {
    self.vehicle endon(#"death");
    self.vehicle clientfield::set("ultimate_turret_init", 1);
    wait 0.25;
    self.vehicle clientfield::set("ultimate_turret_open", 1);
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 0, eflags: 0x0
// Checksum 0x9eaf6cf, Offset: 0x14c8
// Size: 0x74
function function_69af0157() {
    vehicle = self.vehicle;
    waitresult = self waittill(#"death");
    if (waitresult._notify != "death") {
        return;
    }
    if (isdefined(vehicle)) {
        vehicle function_a0ddd1d3(undefined, undefined);
    }
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 0, eflags: 0x0
// Checksum 0x8f2c242e, Offset: 0x1548
// Size: 0x10c
function function_b84173e2() {
    owner = self.owner;
    owner endon(#"disconnect");
    waitresult = self waittill(#"death", #"death_started");
    if (!isdefined(self)) {
        arrayremovevalue(owner.var_ec37a54c, undefined);
    } else if (self.damagetaken > self.health) {
        arrayremovevalue(owner.var_ec37a54c, self);
        self.owner luinotifyevent(#"hash_126effa63f6e04bd");
    }
    owner clientfield::set_player_uimodel("hudItems.ultimateTurretCount", owner.var_ec37a54c.size);
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 1, eflags: 0x0
// Checksum 0x14e09d13, Offset: 0x1660
// Size: 0x91c
function onplaceturret(turret) {
    player = self;
    assert(isplayer(player));
    if (isdefined(turret.vehicle)) {
        turret.vehicle.origin = turret.origin;
        turret.vehicle.angles = turret.angles;
        turret.vehicle thread util::ghost_wait_show(0.05);
        turret.vehicle playsound(#"mpl_turret_startup");
    } else {
        if (sessionmodeiscampaigngame()) {
            turret.vehicle = spawnvehicle("veh_ultimate_turret" + "_cp", turret.origin, turret.angles, "dynamic_spawn_ai");
        } else {
            turret.vehicle = spawnvehicle("veh_ultimate_turret", turret.origin, turret.angles, "dynamic_spawn_ai");
        }
        turret.vehicle.owner = player;
        turret.vehicle setowner(player);
        turret.vehicle.ownerentnum = player.entnum;
        turret.vehicle.parentstruct = turret;
        turret.vehicle.controlled = 0;
        turret.vehicle.treat_owner_damage_as_friendly_fire = 1;
        turret.vehicle.ignore_team_kills = 1;
        turret.vehicle.deal_no_crush_damage = 1;
        turret.vehicle.turret = turret;
        turret.killstreakid = player.var_96a00271;
        turret.killstreakref = "ultimate_turret";
        turret.vehicle.team = player.team;
        turret.vehicle setteam(player.team);
        turret.vehicle turret::set_team(player.team, 0);
        turret.vehicle turret::set_torso_targetting(0);
        turret.vehicle turret::set_target_leading(0);
        turret.vehicle.use_non_teambased_enemy_selection = 1;
        turret.vehicle.waittill_turret_on_target_delay = 0.25;
        turret.vehicle.ignore_vehicle_underneath_splash_scalar = 1;
        turret.vehicle killstreaks::configure_team("ultimate_turret", turret.killstreakid, player, undefined);
        turret.vehicle killstreak_hacking::enable_hacking("ultimate_turret", &hackedcallbackpre, &hackedcallbackpost);
        turret.vehicle thread turret_watch_owner_events();
        turret.vehicle thread turret_laser_watch();
        turret.vehicle thread setup_death_watch_for_new_targets();
        turret.vehicle thread function_695b5a53();
        turret.vehicle.spawninfluencers = [];
        turret.vehicle.spawninfluencers[0] = turret.vehicle createturretinfluencer("turret");
        turret.vehicle.spawninfluencers[1] = turret.vehicle createturretinfluencer("turret_close");
        turret.vehicle thread util::ghost_wait_show(0.05);
        turret.vehicle.var_85970f89 = "arc";
        turret.vehicle.var_daf5024 = [];
        if (issentient(turret.vehicle) == 0) {
            turret.vehicle makesentient();
        }
        turret.vehicle function_33fc4cfc();
        turret.vehicle.var_21af1e0f = 1;
        player killstreaks::play_killstreak_start_dialog("ultimate_turret", player.pers[#"team"], turret.killstreakid);
        level thread popups::displaykillstreakteammessagetoall("ultimate_turret", player);
        player stats::function_4f10b697(getweapon("ultimate_turret"), #"used", 1);
        turret.vehicle.killstreak_duration = level.killstreakbundle[#"ultimate_turret"].ksduration + 5000;
        turret.vehicle.killstreak_end_time = gettime() + turret.vehicle.killstreak_duration;
        bundle = get_killstreak_bundle();
        turret.vehicle thread killstreaks::waitfortimeout("ultimate_turret", turret.vehicle.killstreak_duration, &function_35ff6769, "delete", "death");
        turret.vehicle.maxsightdistsqrd = 1;
    }
    player deployable::function_c0980d61(turret.vehicle, getweapon("ultimate_turret"));
    turret.vehicle playloopsound(#"hash_69240c6db92da5bf", 0.25);
    foreach (player in level.players) {
        turret.vehicle respectnottargetedbysentryperk(player);
    }
    turret.vehicle.turret_enabled = 1;
    target_set(turret.vehicle);
    turret.vehicle unlink();
    turret.vehicle vehicle::disconnect_paths(0, 0);
    bundle = get_killstreak_bundle();
    turret.vehicle thread vehicle::watch_freeze_on_flash(3);
    turret.vehicle thread turretscanning();
    turret.vehicle thread function_51417b07();
    turret.vehicle thread targetting_delay::function_3362444f(bundle.var_50d8ae50);
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 1, eflags: 0x0
// Checksum 0x795a54fb, Offset: 0x1f88
// Size: 0x74
function respectnottargetedbysentryperk(player) {
    if (!isplayer(player)) {
        return;
    }
    turretvehicle = self;
    turretvehicle setignoreent(player, player hasperk(#"specialty_nottargetedbysentry"));
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 1, eflags: 0x0
// Checksum 0x61472bcc, Offset: 0x2008
// Size: 0x11c
function hackedcallbackpre(hacker) {
    turretvehicle = self;
    turretvehicle clientfield::set("enemyvehicle", 2);
    turretvehicle.owner clientfield::set_to_player("static_postfx", 0);
    if (turretvehicle.controlled === 1) {
        visionset_mgr::deactivate("visionset", "turret_visionset", turretvehicle.owner);
    }
    turretvehicle.owner remote_weapons::removeandassignnewremotecontroltrigger(turretvehicle.usetrigger);
    turretvehicle remote_weapons::endremotecontrolweaponuse(1);
    turretvehicle.owner unlink();
    turretvehicle clientfield::set("vehicletransition", 0);
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 1, eflags: 0x0
// Checksum 0x759ae8e0, Offset: 0x2130
// Size: 0x76
function hackedcallbackpost(hacker) {
    turretvehicle = self;
    hacker remote_weapons::useremoteweapon(turretvehicle, "ultimate_turret", 0);
    turretvehicle notify(#"watchremotecontroldeactivate_remoteweapons");
    turretvehicle.killstreak_end_time = hacker killstreak_hacking::set_vehicle_drivable_time_starting_now(turretvehicle);
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 1, eflags: 0x0
// Checksum 0x7f3d3b83, Offset: 0x21b0
// Size: 0x4c
function play_deploy_anim_after_wait(wait_time) {
    turret = self;
    turret endon(#"death");
    wait wait_time;
    turret play_deploy_anim();
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 0, eflags: 0x0
// Checksum 0x6a96c3b4, Offset: 0x2208
// Size: 0x94
function play_deploy_anim() {
    turret = self;
    turret clientfield::set("auto_turret_close", 0);
    turret.othermodel clientfield::set("auto_turret_close", 0);
    if (isdefined(turret.vehicle)) {
        turret.vehicle clientfield::set("auto_turret_open", 1);
    }
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 1, eflags: 0x0
// Checksum 0xc7dc35ce, Offset: 0x22a8
// Size: 0x20
function oncancelplacement(turret) {
    turret notify(#"ultimate_turret_shutdown");
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 1, eflags: 0x0
// Checksum 0x91600f9c, Offset: 0x22d0
// Size: 0x1e4
function onpickupturret(turret) {
    player = self;
    turret.vehicle ghost();
    turret.vheicle.turret_enabled = 0;
    turret.vehicle linkto(turret);
    target_remove(turret.vehicle);
    turret clientfield::set("auto_turret_close", 1);
    turret.othermodel clientfield::set("auto_turret_close", 1);
    if (isdefined(turret.vehicle)) {
        turret.vehicle notify(#"end_turret_scanning");
        turret.vehicle turretsettargetangles(0, (0, 0, 0));
        turret.vehicle clientfield::set("auto_turret_open", 0);
        if (isdefined(turret.vehicle.usetrigger)) {
            turret.vehicle.usetrigger delete();
            turret.vehicle playsound(#"mpl_turret_down");
        }
        turret.vehicle vehicle::connect_paths();
        turret.vehicle stoploopsound(0.5);
    }
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 15, eflags: 0x0
// Checksum 0xf7bd5280, Offset: 0x24c0
// Size: 0x3a0
function onturretdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    empdamage = int(idamage + self.healthdefault * 1 + 0.5);
    var_34a70b9a = self.damagetaken;
    idamage = self killstreaks::ondamageperweapon("ultimate_turret", eattacker, idamage, idflags, smeansofdeath, weapon, self.maxhealth, undefined, self.maxhealth * 0.4, undefined, empdamage, undefined, 1, 1);
    self.damagetaken += idamage;
    if (self.controlled) {
        self.owner vehicle::update_damage_as_occupant(self.damagetaken, self.maxhealth);
    }
    if (self.damagetaken > self.maxhealth && !isdefined(self.will_die)) {
        self.will_die = 1;
        self thread ondeathafterframeend(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
    } else {
        bundle = get_killstreak_bundle();
        if (isdefined(einflictor) && isvehicle(einflictor) && issentient(einflictor)) {
            if (is_valid_target(einflictor, self.team)) {
                self.favoriteenemy = einflictor;
                self.var_28c6e4 = gettime();
                self.var_daf5024[einflictor getentitynumber()] = #"damage";
                self targetting_delay::function_4ba58de4(einflictor);
            }
        } else if (isalive(eattacker) && issentient(eattacker) && !(isplayer(eattacker) && eattacker isremotecontrolling()) && is_valid_target(eattacker, self.team)) {
            self.favoriteenemy = eattacker;
            self.var_28c6e4 = gettime();
            self.var_daf5024[eattacker getentitynumber()] = #"damage";
            self targetting_delay::function_4ba58de4(eattacker);
        }
    }
    return idamage;
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 8, eflags: 0x0
// Checksum 0xcbd8f78c, Offset: 0x2868
// Size: 0x74
function onturretdeath(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    self ondeath(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 8, eflags: 0x0
// Checksum 0xdcffb509, Offset: 0x28e8
// Size: 0x84
function ondeathafterframeend(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    waittillframeend();
    if (isdefined(self)) {
        self ondeath(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
    }
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 8, eflags: 0x0
// Checksum 0x3219c5f2, Offset: 0x2978
// Size: 0x4bc
function ondeath(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    turretvehicle = self;
    turretvehicle notify(#"death_started");
    if (turretvehicle.dead === 1) {
        return;
    }
    turretvehicle.dead = 1;
    turretvehicle disabledriverfiring(1);
    turretvehicle.turret_enabled = 0;
    turretvehicle vehicle::connect_paths();
    eattacker = self [[ level.figure_out_attacker ]](eattacker);
    if (isdefined(turretvehicle.parentstruct)) {
        turretvehicle.parentstruct placeables::forceshutdown();
        if (turretvehicle.parentstruct.killstreaktimedout === 1 && isdefined(turretvehicle.owner)) {
            if (isdefined(level.var_383a5cc9)) {
                turretvehicle.owner [[ level.var_383a5cc9 ]](turretvehicle.parentstruct.killstreaktype);
            }
        } else if (isdefined(eattacker) && isdefined(turretvehicle.owner) && eattacker != turretvehicle.owner) {
            turretvehicle.parentstruct killstreaks::play_destroyed_dialog_on_owner(turretvehicle.killstreaktype, turretvehicle.killstreakid);
            if (isplayer(eattacker) && isdefined(level.var_7d3194e)) {
                self [[ level.var_7d3194e ]](eattacker, weapon);
            }
        }
    }
    if (isdefined(eattacker) && isplayer(eattacker) && (!isdefined(self.owner) || self.owner util::isenemyplayer(eattacker))) {
        eattacker challenges::destroyscorestreak(weapon, turretvehicle.controlled, 1, 0);
        eattacker challenges::function_90c432bd(weapon);
        eattacker stats::function_b48aa4e(#"destroy_turret", 1);
        eattacker stats::function_4f10b697(weapon, #"destroy_turret", 1);
    }
    if (isdefined(level.var_b31e16d4)) {
        self [[ level.var_b31e16d4 ]](eattacker, self.owner, self.turretweapon, weapon);
    }
    turretvehicle stoploopsound(0.5);
    turretvehicle playsound("mpl_turret_exp");
    turretvehicle function_36534b2d();
    if (isdefined(level.playequipmentdestroyedonplayer)) {
        self.owner [[ level.playequipmentdestroyedonplayer ]]();
    }
    var_9fe8e1bb = self.turret;
    wait 0.1;
    turretvehicle ghost();
    turretvehicle notsolid();
    turretvehicle waittilltimeout(2, #"remote_weapon_end");
    if (isdefined(turretvehicle)) {
        while (isdefined(turretvehicle) && (turretvehicle.controlled || !isdefined(turretvehicle.owner))) {
            waitframe(1);
        }
        turretvehicle.dontfreeme = undefined;
        wait 0.5;
        if (isdefined(turretvehicle)) {
            turretvehicle delete();
        }
    }
    if (isdefined(var_9fe8e1bb)) {
        var_9fe8e1bb delete();
    }
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 1, eflags: 0x0
// Checksum 0xf246fc3a, Offset: 0x2e40
// Size: 0x20
function onshutdown(turret) {
    turret notify(#"ultimate_turret_shutdown");
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 1, eflags: 0x0
// Checksum 0x526bd6c2, Offset: 0x2e68
// Size: 0x7a
function enableturretafterwait(wait_time) {
    self endon(#"death");
    if (isdefined(self.owner)) {
        self.owner endon(#"disconnect", #"joined_team", #"joined_spectators");
    }
    wait wait_time;
    self.turret_enabled = 1;
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 1, eflags: 0x0
// Checksum 0x5c7dc44f, Offset: 0x2ef0
// Size: 0xba
function createturretinfluencer(name) {
    turret = self;
    preset = getinfluencerpreset(name);
    if (!isdefined(preset)) {
        return;
    }
    projected_point = turret.origin + vectorscale(anglestoforward(turret.angles), preset[#"radius"] * 0.7);
    return influencers::create_enemy_influencer(name, turret.origin, turret.team);
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 0, eflags: 0x0
// Checksum 0x3ff4362a, Offset: 0x2fb8
// Size: 0x82
function function_36534b2d() {
    foreach (influencer in self.spawninfluencers) {
        self influencers::remove_influencer(influencer);
    }
    self.spawninfluencers = [];
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 0, eflags: 0x0
// Checksum 0x4474cb54, Offset: 0x3048
// Size: 0x14c
function turret_watch_owner_events() {
    self notify(#"turret_watch_owner_events_singleton");
    self endon(#"hash_10adb1481d5f4457");
    self endon(#"death");
    self.owner waittill(#"joined_team", #"disconnect", #"joined_spectators");
    self makevehicleusable();
    self.controlled = 0;
    if (isdefined(self.owner)) {
        self.owner unlink();
        self clientfield::set("vehicletransition", 0);
    }
    self makevehicleunusable();
    if (isdefined(self.owner)) {
        self.owner killstreaks::clear_using_remote();
    }
    self.abandoned = 1;
    onshutdown(self);
    self function_ab629407();
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 0, eflags: 0x0
// Checksum 0x6515b3f5, Offset: 0x31a0
// Size: 0x108
function turret_laser_watch() {
    veh = self;
    veh endon(#"death");
    while (true) {
        laser_should_be_on = !veh.controlled && isdefined(veh.enemy) && !(isdefined(veh.isstunned) && veh.isstunned);
        if (laser_should_be_on) {
            if (islaseron(veh) == 0) {
                veh vehicle::enable_laser(1, 0);
            }
        } else if (islaseron(veh)) {
            veh vehicle::enable_laser(0, 0);
        }
        wait 0.25;
    }
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 0, eflags: 0x0
// Checksum 0x933d2545, Offset: 0x32b0
// Size: 0xa6
function setup_death_watch_for_new_targets() {
    turretvehicle = self;
    turretvehicle endon(#"death");
    for (old_target = undefined; true; old_target = waitresult.target) {
        waitresult = turretvehicle waittill(#"has_new_target");
        if (isdefined(old_target)) {
            old_target notify(#"abort_death_watch");
        }
        waitresult.target thread target_death_watch(turretvehicle);
    }
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 1, eflags: 0x0
// Checksum 0xe8f05a1f, Offset: 0x3360
// Size: 0xac
function target_death_watch(turretvehicle) {
    target = self;
    target endon(#"abort_death_watch");
    turretvehicle endon(#"death");
    target waittill(#"death", #"disconnect", #"joined_team", #"joined_spectators");
    turretvehicle clearenemy();
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 0, eflags: 0x0
// Checksum 0xc4738b31, Offset: 0x3418
// Size: 0x1c
function get_killstreak_bundle() {
    return level.killstreakbundle[#"ultimate_turret"];
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 2, eflags: 0x0
// Checksum 0xcc86eed2, Offset: 0x3440
// Size: 0x8a
function is_valid_target(potential_target, friendly_team) {
    if (isdefined(potential_target)) {
        if (issentient(potential_target) && potential_target.var_5a892a1f === 1) {
            return false;
        }
        if (!isdefined(potential_target.team) || potential_target.team == friendly_team) {
            return false;
        }
        return true;
    }
    return false;
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 0, eflags: 0x0
// Checksum 0xe46b45e7, Offset: 0x34d8
// Size: 0x320
function function_51417b07() {
    veh = self;
    turret_index = 0;
    veh endon(#"death", #"death_started", #"end_turret_scanning");
    wait 0.8;
    bundle = get_killstreak_bundle();
    var_6e0c03c = isdefined(bundle.var_81f552a3) ? bundle.var_81f552a3 : 300;
    while (true) {
        if (!isdefined(veh.enemy) && !(isdefined(veh.isstunned) && veh.isstunned)) {
            /#
                var_6e0c03c = isdefined(bundle.var_81f552a3) ? bundle.var_81f552a3 : 300;
            #/
            var_21d01999 = getplayers(util::getotherteam(veh.team), veh.origin, var_6e0c03c);
            if (var_21d01999.size > 0) {
                if (veh.var_427d077a != #"hash_2d94a5f22d36fc73") {
                    veh function_8f7257d3();
                } else {
                    foreach (nearby_enemy in var_21d01999) {
                        if (veh cansee(nearby_enemy) == 0) {
                            continue;
                        }
                        if (veh targetting_delay::function_3b2437d9(nearby_enemy) == 0) {
                            continue;
                        }
                        if (veh function_bca51daf(nearby_enemy)) {
                            continue;
                        }
                        veh.favoriteenemy = nearby_enemy;
                        veh.var_28c6e4 = gettime();
                        veh.var_daf5024[nearby_enemy getentitynumber()] = #"hash_47697c94ffb4a5bd";
                        break;
                    }
                }
            } else if (veh.var_427d077a != #"standard_sight") {
                veh function_33fc4cfc();
            }
        }
        wait_time = veh.var_427d077a == #"standard_sight" ? 0.25 : 0.1;
        wait wait_time;
    }
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 1, eflags: 0x0
// Checksum 0xcadb710b, Offset: 0x3800
// Size: 0x102
function function_bca51daf(enemy) {
    fire_origin = self getseatfiringorigin(0);
    fire_angles = self getseatfiringangles(0);
    shoot_at_pos = enemy getshootatpos(self);
    var_969d9ad9 = anglestoforward(fire_angles);
    target_offset = shoot_at_pos - fire_origin;
    if (lengthsquared(target_offset) < 22 * 22 && vectordot(var_969d9ad9, target_offset) < 0) {
        return true;
    }
    return false;
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 1, eflags: 0x0
// Checksum 0x235f7173, Offset: 0x3910
// Size: 0x154
function function_4f88e28e(bundle) {
    var_88746dc3 = isdefined(self.enemy) ? max(isdefined(self.enemylastseentime) ? self.enemylastseentime : 0, isdefined(self.var_28c6e4) ? self.var_28c6e4 : 0) : 0;
    var_bc8b4321 = int((isdefined(bundle.var_d2bd9094) ? bundle.var_d2bd9094 : 1) * 1000);
    if (isdefined(self.enemy) && self.var_daf5024[self.enemy getentitynumber()] === #"damage") {
        var_bc8b4321 = int((isdefined(bundle.var_a8c33e83) ? bundle.var_a8c33e83 : 3) * 1000);
    }
    return gettime() < var_88746dc3 + var_bc8b4321;
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 0, eflags: 0x0
// Checksum 0x3c640a2e, Offset: 0x3a70
// Size: 0x82
function function_51f4dcef() {
    veh = self;
    if (isdefined(veh.enemy)) {
        veh.var_28c6e4 = undefined;
        veh.var_daf5024[veh.enemy getentitynumber()] = undefined;
    }
    veh clearenemy();
    veh.favoriteenemy = undefined;
    veh.turret_target = undefined;
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 0, eflags: 0x0
// Checksum 0x8ffb0609, Offset: 0x3b00
// Size: 0x4a
function function_33fc4cfc() {
    self.sightlatency = 100;
    self.fovcosine = 0.5;
    self.fovcosinebusy = 0.5;
    self.var_427d077a = #"standard_sight";
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 0, eflags: 0x0
// Checksum 0xacfbc557, Offset: 0x3b58
// Size: 0x42
function function_8f7257d3() {
    self.sightlatency = 100;
    self.fovcosine = 0;
    self.fovcosinebusy = 0;
    self.var_427d077a = #"hash_2d94a5f22d36fc73";
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 1, eflags: 0x0
// Checksum 0x776b563c, Offset: 0x3ba8
// Size: 0x62
function get_target_offset(target) {
    var_248db1 = -12;
    stance = target getstance();
    if (stance == "prone") {
        var_248db1 = -2;
    }
    return (0, 0, var_248db1);
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 1, eflags: 0x0
// Checksum 0x2749ae4e, Offset: 0x3c18
// Size: 0x160
function function_6a3e69e0(turret_index) {
    self notify("51ea6f600e0c5dab");
    self endon("51ea6f600e0c5dab");
    veh = self;
    while (isdefined(veh.enemy) && !(isdefined(veh.isstunned) && veh.isstunned)) {
        var_54d0e529 = veh.enemy getvelocity() * getdvarfloat(#"hash_3a25aaa27558e77b", 0.075);
        if (isplayer(veh.enemy)) {
            target_offset = get_target_offset(veh.enemy);
            veh turretsettarget(turret_index, veh.enemy, target_offset + var_54d0e529);
        } else {
            veh turretsettarget(turret_index, veh.enemy, var_54d0e529);
        }
        wait 0.1;
    }
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 0, eflags: 0x0
// Checksum 0x57ffd63d, Offset: 0x3d80
// Size: 0xe44
function turretscanning() {
    veh = self;
    veh endon(#"death", #"death_started", #"end_turret_scanning");
    veh.turret_target = undefined;
    veh.do_not_clear_targets_during_think = 1;
    wait 0.8;
    veh playsound(#"mpl_turret_startup");
    veh playloopsound(#"hash_69240c6db92da5bf");
    bundle = get_killstreak_bundle();
    min_burst_time = bundle.ksburstfiremintime;
    max_burst_time = bundle.ksburstfiremaxtime;
    min_pause_time = bundle.ksburstfiredelaymintime;
    max_pause_time = bundle.ksburstfiredelaymaxtime;
    burst_fire_enabled = bundle.ksburstfireenabled;
    veh.maxsightdistsqrd = (isdefined(bundle.var_50d8ae50) ? bundle.var_50d8ae50 : 3500) * (isdefined(bundle.var_50d8ae50) ? bundle.var_50d8ae50 : 3500);
    veh.var_b22f38d1 = (isdefined(bundle.var_356c62e7) ? bundle.var_356c62e7 : 2500) * (isdefined(bundle.var_356c62e7) ? bundle.var_356c62e7 : 2500);
    veh.var_c70a949b = (isdefined(bundle.var_81f552a3) ? bundle.var_81f552a3 : 500) * (isdefined(bundle.var_81f552a3) ? bundle.var_81f552a3 : 500);
    while (true) {
        /#
            veh.maxsightdistsqrd = (isdefined(bundle.var_50d8ae50) ? bundle.var_50d8ae50 : 3500) * (isdefined(bundle.var_50d8ae50) ? bundle.var_50d8ae50 : 3500);
            veh.var_b22f38d1 = (isdefined(bundle.var_356c62e7) ? bundle.var_356c62e7 : 2500) * (isdefined(bundle.var_356c62e7) ? bundle.var_356c62e7 : 2500);
            veh.var_c70a949b = (isdefined(bundle.var_81f552a3) ? bundle.var_81f552a3 : 500) * (isdefined(bundle.var_81f552a3) ? bundle.var_81f552a3 : 500);
        #/
        if (isdefined(veh.isstunned) && veh.isstunned) {
            veh function_51f4dcef();
            wait 0.5;
            continue;
        }
        if (veh.controlled || !veh.turret_enabled) {
            wait 0.5;
            continue;
        }
        if (isdefined(veh.enemy)) {
            if (!is_valid_target(veh.enemy, veh.team)) {
                veh setignoreent(veh.enemy, 1);
                veh function_51f4dcef();
                wait 0.1;
                continue;
            }
            var_c5d9e0f5 = 0;
            if (distancesquared(veh.enemy.origin, veh.origin) > veh.var_c70a949b && veh.var_daf5024[veh.enemy getentitynumber()] === #"forwardscan") {
                var_c5d9e0f5 = 1;
            } else if (veh function_bca51daf(veh.enemy)) {
                var_c5d9e0f5 = 1;
            }
            if (var_c5d9e0f5) {
                veh setpersonalignore(veh.enemy, 1);
                veh function_51f4dcef();
                wait 0.1;
                continue;
            }
            if (!isdefined(veh.var_daf5024[veh.enemy getentitynumber()]) && veh targetting_delay::function_3b2437d9(veh.enemy)) {
                veh.var_28c6e4 = gettime();
                veh.var_daf5024[veh.enemy getentitynumber()] = #"forwardscan";
            }
        }
        if (veh has_active_enemy(bundle) && isdefined(veh.enemy) && isalive(veh.enemy)) {
            veh.turretrotscale = getdvarfloat(#"hash_7a767607be3081e9", 3);
            if (!isdefined(veh.turret_target) || veh.turret_target != veh.enemy) {
                veh.turret_target = veh.enemy;
                if (!isdefined(veh.var_a2e7eaae) || veh.var_a2e7eaae + 5000 < gettime()) {
                    veh playsoundtoteam("mpl_ultimate_turret_lockon", veh.team);
                    veh playsoundtoteam("mpl_ultimate_turret_lockon_enemy", util::getotherteam(veh.team));
                    veh.var_a2e7eaae = gettime();
                }
                veh function_6a3e69e0(0);
            }
            if (veh.turretontarget && veh function_4f88e28e(bundle) && veh cansee(veh.enemy)) {
                if (burst_fire_enabled) {
                    fire_time = min_burst_time > max_burst_time ? min_burst_time : randomfloatrange(min_burst_time, max_burst_time);
                    var_e6c7ec56 = veh.enemy;
                    veh vehicle_ai::fire_for_time(fire_time, 0, veh.enemy);
                    var_1f7b58dc = !isdefined(var_e6c7ec56) || !isalive(var_e6c7ec56);
                    if (min_pause_time > 0 && !var_1f7b58dc) {
                        pause_time = min_pause_time > max_pause_time ? min_pause_time : randomfloatrange(min_pause_time, max_pause_time);
                        waitresult = veh.turret_target waittilltimeout(pause_time, #"death", #"disconnect");
                        var_1f7b58dc = waitresult._notify === "death";
                    }
                } else {
                    var_e6c7ec56 = veh.enemy;
                    veh vehicle_ai::fire_for_rounds(10, 0, veh.enemy);
                    var_1f7b58dc = !isdefined(var_e6c7ec56) || !isalive(var_e6c7ec56);
                }
                if (var_1f7b58dc && isdefined(veh.turret_target) && isdefined(veh.turret_target.var_eb95f255) && veh.turret_target.var_eb95f255 == veh) {
                    veh.owner luinotifyevent(#"mini_turret_kill");
                    veh.owner playsoundtoplayer(#"hash_7ea486136cd776c", veh.owner);
                    veh.turretrotscale = 1;
                    wait randomfloatrange(0.05, 0.2);
                }
            } else {
                wait 0.25;
            }
            continue;
        }
        var_cd349918 = isdefined(veh.turret_target);
        var_d3e33850 = 0;
        if (var_cd349918) {
            var_d3e33850 = isalive(veh.turret_target);
            veh setpersonalignore(veh.turret_target, 1.5);
        }
        veh function_51f4dcef();
        veh.turretrotscale = 1;
        if (var_cd349918 && var_d3e33850) {
            veh playsoundtoteam("mpl_turret_lost", veh.team);
            veh playsoundtoteam("mpl_turret_lost_enemy", util::getotherteam(veh.team));
        }
        if (veh.var_85970f89 == "arc") {
            if (veh.scanpos === "left") {
                veh turretsettargetangles(0, (-10, 40, 0));
                veh.scanpos = "right";
            } else {
                veh turretsettargetangles(0, (-10, -40, 0));
                veh.scanpos = "left";
            }
        } else if (veh.scanpos === "left") {
            veh turretsettargetangles(0, (-10, 180, 0));
            veh.scanpos = "left2";
        } else if (veh.scanpos === "left2") {
            veh turretsettargetangles(0, (-10, 360, 0));
            veh.scanpos = "right";
        } else if (veh.scanpos === "right") {
            veh turretsettargetangles(0, (-10, -180, 0));
            veh.scanpos = "right2";
        } else {
            veh turretsettargetangles(0, (-10, -360, 0));
            veh.scanpos = "left";
        }
        waitresult = veh waittilltimeout(3.5, #"enemy");
        if (waitresult._notify == #"enemy" && isdefined(veh.enemy)) {
            if (veh.var_21af1e0f && !isdefined(veh.enemylastseentime)) {
                attempts = 0;
                max_tries = 10;
                while (attempts < max_tries && !isdefined(veh.enemylastseentime) && isdefined(veh.enemy)) {
                    veh getperfectinfo(self.enemy, 0);
                    attempts++;
                    wait 0.1;
                }
            }
        }
    }
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 2, eflags: 0x0
// Checksum 0xef34a6fb, Offset: 0x4bd0
// Size: 0xb4
function turretshutdown(killstreakid, team) {
    turret = self;
    if (turret.shuttingdown === 1) {
        return;
    }
    if (isdefined(turret)) {
        turret.shuttingdown = 1;
    }
    killstreakrules::killstreakstop("ultimate_turret", team, killstreakid);
    deployable::function_2cefe05a(turret);
    if (isdefined(turret.vehicle)) {
        turret.vehicle function_36534b2d();
    }
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 3, eflags: 0x0
// Checksum 0x1bdb196c, Offset: 0x4c90
// Size: 0xc4
function watchturretshutdown(player, killstreakid, team) {
    player endon(#"disconnect", #"joined_team", #"joined_spectators");
    player thread function_c38105ca(player, killstreakid, team);
    turret = self;
    self waittill(#"ultimate_turret_shutdown", #"death");
    turretshutdown(killstreakid, team);
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 3, eflags: 0x0
// Checksum 0x88d25e05, Offset: 0x4d60
// Size: 0x8c
function function_c38105ca(player, killstreakid, team) {
    turret = self;
    player waittill(#"disconnect", #"joined_team", #"joined_spectators");
    if (isdefined(turret)) {
        turret turretshutdown(killstreakid, team);
    }
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 1, eflags: 0x0
// Checksum 0xc27007e7, Offset: 0x4df8
// Size: 0xfa
function has_active_enemy(bundle) {
    if (self.var_21af1e0f === 1) {
    } else if (!isdefined(self.enemylastseentime)) {
        return 0;
    }
    if (isdefined(self.favoriteenemy)) {
        if (!isalive(self.favoriteenemy)) {
            return 0;
        }
        if (self targetting_delay::function_3b2437d9(self.favoriteenemy) == 0) {
            return 0;
        }
    }
    if (isdefined(self.enemy) && self.favoriteenemy !== self.enemy) {
        if (!isalive(self.enemy)) {
            return 0;
        }
        if (self targetting_delay::function_3b2437d9(self.enemy) == 0) {
            return 0;
        }
    }
    return function_4f88e28e(bundle);
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 0, eflags: 0x0
// Checksum 0xd3141776, Offset: 0x4f00
// Size: 0x34
function function_35ff6769() {
    onshutdown(self.turret);
    self function_ab629407();
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 0, eflags: 0x0
// Checksum 0x3147b9fa, Offset: 0x4f40
// Size: 0x1c
function function_ab629407() {
    self thread function_a0ddd1d3(undefined, undefined);
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 2, eflags: 0x0
// Checksum 0xd9f1e169, Offset: 0x4f68
// Size: 0xf4
function function_a0ddd1d3(attacker, callback_data) {
    if (!isdefined(self)) {
        return;
    }
    if (self.dead === 1) {
        return;
    }
    playfx(level._equipment_explode_fx_lg, self.origin);
    self playsound("mpl_turret_exp");
    self stoploopsound(0.5);
    self function_36534b2d();
    turret = self.turret;
    self delete();
    waittillframeend();
    if (isdefined(turret)) {
        turret delete();
    }
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 0, eflags: 0x0
// Checksum 0xe074c310, Offset: 0x5068
// Size: 0x1d4
function function_695b5a53() {
    self endon(#"death");
    waitframe(1);
    var_1e3cc337 = 386.089 * float(function_f9f48566()) / 1000;
    max_delta = 1;
    while (true) {
        if (!isdefined(self.turret)) {
            wait 1;
            continue;
        }
        trace = physicstrace(self.origin + (0, 0, 15), self.origin + (0, 0, -10), (-3, -3, -1), (3, 3, 1), self.turret, 1 | 16);
        if (trace[#"fraction"] > 0) {
            new_origin = trace[#"position"];
            self.origin = (new_origin[0], new_origin[1], self.origin[2] - min(max_delta, self.origin[2] - new_origin[2]));
            max_delta += var_1e3cc337;
            waitframe(1);
            continue;
        }
        max_delta = 1;
        wait 1;
    }
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 0, eflags: 0x0
// Checksum 0xc47e0dc6, Offset: 0x5248
// Size: 0x1f0
function on_player_killed() {
    if (!isdefined(self.var_aad77fda)) {
        return;
    }
    var_6c099205 = [];
    foreach (var_5f8d3e81 in self.var_aad77fda) {
        if (!isdefined(var_5f8d3e81)) {
            continue;
        }
        if (!isdefined(var_5f8d3e81.owner)) {
            continue;
        }
        if (!isdefined(self.var_eb95f255)) {
            continue;
        }
        if (self.var_eb95f255.vehicletype === #"ultimate_turret") {
            continue;
        }
        if (var_5f8d3e81.vehicletype === #"ultimate_turret") {
            if (!isdefined(var_6c099205)) {
                var_6c099205 = [];
            } else if (!isarray(var_6c099205)) {
                var_6c099205 = array(var_6c099205);
            }
            if (!isinarray(var_6c099205, var_5f8d3e81.owner)) {
                var_6c099205[var_6c099205.size] = var_5f8d3e81.owner;
            }
        }
    }
    foreach (player in var_6c099205) {
        player playsoundtoplayer(#"hash_37ffaa04e3f898fa", player);
    }
}

