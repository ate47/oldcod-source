#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/damagefeedback_shared;
#using scripts/core_common/dialog_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/gameobjects_shared;
#using scripts/core_common/globallogic/globallogic_player;
#using scripts/core_common/globallogic/globallogic_score;
#using scripts/core_common/loadout_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/util_shared;
#using scripts/core_common/vehicle_shared;

#namespace globallogic_vehicle;

// Namespace globallogic_vehicle/globallogic_vehicle
// Params 1, eflags: 0x0
// Checksum 0x567302d9, Offset: 0x510
// Size: 0x314
function callback_vehiclespawned(spawner) {
    self.health = self.healthdefault;
    if (isdefined(level.vehicle_main_callback)) {
        if (isdefined(level.vehicle_main_callback[self.vehicletype])) {
            self thread [[ level.vehicle_main_callback[self.vehicletype] ]]();
        } else if (isdefined(self.scriptvehicletype) && isdefined(level.vehicle_main_callback[self.scriptvehicletype])) {
            self thread [[ level.vehicle_main_callback[self.scriptvehicletype] ]]();
        }
    }
    if (isdefined(level.a_str_vehicle_spawn_custom_keys)) {
        foreach (str_key in level.a_str_vehicle_spawn_custom_keys) {
            if (isdefined(spawner)) {
                if (isdefined(spawner.(str_key))) {
                    str_value = spawner.(str_key);
                }
            } else if (isdefined(self.(str_key))) {
                str_value = self.(str_key);
            }
            a_key_spawn_funcs = level.("a_str_vehicle_spawn_key_" + str_key);
            if (isdefined(str_value) && isdefined(a_key_spawn_funcs[str_value])) {
                foreach (func in a_key_spawn_funcs[str_value]) {
                    util::single_thread(self, func["function"], func["param1"], func["param2"], func["param3"], func["param4"]);
                }
            }
        }
    }
    if (issentient(self)) {
        self spawner::spawn_think(spawner);
    } else if (self.vehicletype != "zm_zod_train") {
        vehicle::init(self);
    }
    function_9a2dd68a(self);
}

// Namespace globallogic_vehicle/globallogic_vehicle
// Params 2, eflags: 0x0
// Checksum 0x8b97a762, Offset: 0x830
// Size: 0xc4
function isfriendlyfire(eself, eattacker) {
    if (!isdefined(eattacker)) {
        return false;
    }
    occupant_team = eself vehicle::vehicle_get_occupant_team();
    if (occupant_team === eattacker.team && occupant_team != "free") {
        return true;
    }
    if (!level.hardcoremode && isdefined(eself.owner) && eself.owner === eattacker.owner) {
        return true;
    }
    return false;
}

// Namespace globallogic_vehicle/globallogic_vehicle
// Params 15, eflags: 0x0
// Checksum 0x2e6de846, Offset: 0x900
// Size: 0xd64
function callback_vehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    params = spawnstruct();
    params.einflictor = einflictor;
    params.eattacker = eattacker;
    params.idamage = idamage;
    params.idflags = idflags;
    params.smeansofdeath = smeansofdeath;
    params.weapon = weapon;
    params.vpoint = vpoint;
    params.vdir = vdir;
    params.shitloc = shitloc;
    params.vdamageorigin = vdamageorigin;
    params.psoffsettime = psoffsettime;
    params.damagefromunderneath = damagefromunderneath;
    params.modelindex = modelindex;
    params.partname = partname;
    params.vsurfacenormal = vsurfacenormal;
    params.isselfdestruct = eattacker === self.owner && (eattacker === self || self.selfdestruct === 1);
    params.friendlyfire = !params.isselfdestruct && isfriendlyfire(self, eattacker);
    if (!isdefined(self.maxhealth)) {
        self.maxhealth = self.healthdefault;
    }
    if (game.state == "postgame") {
        avoid_damage_in_postgame = !sessionmodeismultiplayergame();
        if (avoid_damage_in_postgame) {
            return;
        }
    }
    if (!(1 & idflags)) {
        idamage = loadout::cac_modified_vehicle_damage(self, eattacker, idamage, smeansofdeath, weapon, einflictor);
    }
    if (idamage == 0) {
        return;
    }
    if (!isdefined(vdir)) {
        idflags |= 4;
    }
    self.idflags = idflags;
    self.idflagstime = gettime();
    if (self.health == self.maxhealth || !isdefined(self.attackers)) {
        self.attackers = [];
        self.attackerdata = [];
        self.attackerdamage = [];
    }
    if (weapon == level.weaponnone && isdefined(einflictor)) {
        if (isdefined(einflictor.targetname) && einflictor.targetname == "explodable_barrel") {
            weapon = getweapon("explodable_barrel");
        } else if (isdefined(einflictor.destructible_type) && issubstr(einflictor.destructible_type, "vehicle_")) {
            weapon = getweapon("destructible_car");
        }
    }
    if (smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_GRENADE") {
        idamage *= weapon.vehicleprojectiledamagescalar;
    } else if (smeansofdeath == "MOD_GRENADE_SPLASH") {
        idamage *= getvehicleunderneathsplashscalar(weapon);
    }
    idamage *= level.vehicledamagescalar;
    idamage *= self getvehdamagemultiplier(smeansofdeath);
    idamage = int(idamage);
    if (isdefined(self.overridevehicledamage)) {
        idamage = self [[ self.overridevehicledamage ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
    } else if (isdefined(level.overridevehicledamage)) {
        idamage = self [[ level.overridevehicledamage ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
    }
    if (isdefined(level.cybercom) && isdefined(isdefined(level.cybercom.overrideactordamage))) {
        idamage = self [[ level.cybercom.overridevehicledamage ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
    }
    if (isdefined(self.aioverridedamage)) {
        for (index = 0; index < self.aioverridedamage.size; index++) {
            damagecallback = self.aioverridedamage[index];
            idamage = self [[ damagecallback ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
        }
    }
    assert(isdefined(idamage), "<dev string:x28>");
    params.idamage = int(idamage);
    params.idflags = idflags;
    if (issentient(self)) {
        self callback::callback(#"hash_eb4a4369", params);
    }
    self callback::callback(#"hash_9bd1e27f", params);
    if (self isvehicleimmunetodamage(idflags, smeansofdeath, weapon)) {
        return;
    }
    if (idflags & 8192) {
        return;
    }
    if (idamage == 0) {
        return;
    }
    damageteammates = 0;
    if (params.friendlyfire) {
        if (!allowfriendlyfiredamage(einflictor, eattacker, smeansofdeath, weapon)) {
            return;
        }
        damageteammates = 1;
    }
    if (idamage < 1) {
        idamage = 1;
    }
    idamage = int(idamage);
    if (isdefined(eattacker) && isplayer(eattacker)) {
        eattacker.pers["participation"]++;
    }
    driver = self getseatoccupant(0);
    if (isplayer(driver)) {
        damagepct = idamage / self.maxhealth;
        damagepct = int(max(damagepct, 3));
        driver addtodamageindicator(damagepct, vdir);
    }
    self globallogic_player::giveattackerandinflictorownerassist(eattacker, einflictor, idamage, smeansofdeath, weapon);
    if ((!isdefined(params.isselfdestruct) || isdefined(eattacker) && !params.isselfdestruct) && self.nodamagefeedback !== 1) {
        if (damagefeedback::dodamagefeedback(weapon, einflictor)) {
            if (idamage > 0 && self.health - idamage > 0) {
                eattacker thread damagefeedback::update(smeansofdeath, einflictor, undefined, weapon, self, psoffsettime, shitloc);
            }
        }
    }
    if (isplayer(eattacker) && isdefined(level.challenges_callback_vehicledamaged)) {
        self thread [[ level.challenges_callback_vehicledamaged ]](eattacker, eattacker, idamage, weapon, shitloc);
    }
    selfentnum = self getentitynumber();
    self finishvehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname, damageteammates);
    /#
        if (getdvarint("<dev string:x61>")) {
            println("<dev string:x6f>" + selfentnum + "<dev string:x78>" + self.health + "<dev string:x81>" + eattacker.clientid + "<dev string:x8c>" + isplayer(einflictor) + "<dev string:xa2>" + idamage + "<dev string:xab>" + shitloc);
        }
    #/
    if (true) {
        lpselfnum = selfentnum;
        lpselfteam = "";
        lpattackerteam = "";
        if (isplayer(eattacker)) {
            lpattacknum = eattacker getentitynumber();
            lpattackguid = eattacker getguid();
            lpattackname = eattacker.name;
            lpattackerteam = eattacker.pers["team"];
        } else {
            lpattacknum = -1;
            lpattackguid = "";
            lpattackname = "";
            lpattackerteam = "world";
        }
        logprint("VD;" + lpselfnum + ";" + lpselfteam + ";" + lpattackguid + ";" + lpattacknum + ";" + lpattackerteam + ";" + lpattackname + ";" + weapon.name + ";" + idamage + ";" + smeansofdeath + ";" + shitloc + "\n");
    }
}

// Namespace globallogic_vehicle/globallogic_vehicle
// Params 13, eflags: 0x0
// Checksum 0x97e33802, Offset: 0x1670
// Size: 0x2fc
function callback_vehicleradiusdamage(einflictor, eattacker, idamage, finnerdamage, fouterdamage, idflags, smeansofdeath, weapon, vpoint, fradius, fconeanglecos, vconedir, psoffsettime) {
    idamage = loadout::cac_modified_vehicle_damage(self, eattacker, idamage, smeansofdeath, weapon, einflictor);
    finnerdamage = loadout::cac_modified_vehicle_damage(self, eattacker, finnerdamage, smeansofdeath, weapon, einflictor);
    fouterdamage = loadout::cac_modified_vehicle_damage(self, eattacker, fouterdamage, smeansofdeath, weapon, einflictor);
    self.idflags = idflags;
    self.idflagstime = gettime();
    isselfdestruct = eattacker === self.owner && (eattacker === self || self.selfdestruct === 1);
    friendlyfire = !isselfdestruct && isfriendlyfire(self, eattacker);
    if (game.state == "postgame") {
        return;
    }
    if (smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_EXPLOSIVE") {
        scalar = weapon.vehicleprojectilesplashdamagescalar;
        idamage = int(idamage * scalar);
        finnerdamage *= scalar;
        fouterdamage *= scalar;
        if (finnerdamage == 0) {
            return;
        }
    }
    if (self isvehicleimmunetodamage(idflags, smeansofdeath, weapon)) {
        return;
    }
    if (idflags & 8192) {
        return;
    }
    if (friendlyfire) {
        if (!allowfriendlyfiredamage(einflictor, eattacker, smeansofdeath, weapon)) {
            return;
        }
    }
    if (idamage < 1) {
        idamage = 1;
    }
    self finishvehicleradiusdamage(einflictor, eattacker, idamage, finnerdamage, fouterdamage, idflags, smeansofdeath, weapon, vpoint, fradius, fconeanglecos, vconedir, psoffsettime);
}

// Namespace globallogic_vehicle/globallogic_vehicle
// Params 8, eflags: 0x0
// Checksum 0x63597866, Offset: 0x1978
// Size: 0x66c
function callback_vehiclekilled(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    params = spawnstruct();
    params.einflictor = einflictor;
    params.eattacker = eattacker;
    params.idamage = idamage;
    params.smeansofdeath = smeansofdeath;
    params.weapon = weapon;
    params.vdir = vdir;
    params.shitloc = shitloc;
    params.psoffsettime = psoffsettime;
    if (game.state == "postgame") {
        return;
    }
    eattacker = globallogic_player::figureoutattacker(eattacker);
    if (isdefined(eattacker) && isplayer(eattacker)) {
        globallogic_score::inctotalkills(eattacker.team);
        eattacker thread globallogic_score::givekillstats(smeansofdeath, weapon, self);
    }
    if (isai(eattacker) && isdefined(eattacker.script_owner)) {
        if (eattacker.script_owner.team != self.team) {
            eattacker = eattacker.script_owner;
        }
    }
    if (isdefined(eattacker) && isdefined(eattacker.onkill)) {
        eattacker [[ eattacker.onkill ]](self);
    }
    if (isdefined(einflictor)) {
        self.damageinflictor = einflictor;
    }
    if (issentient(self)) {
        self callback::callback(#"hash_fc2ec5ff", params);
    }
    self callback::callback(#"hash_acb66515", params);
    if (isdefined(self.overridevehiclekilled)) {
        self [[ self.overridevehiclekilled ]](einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
    }
    player = eattacker;
    if (eattacker.classname == "script_vehicle" && isdefined(eattacker) && isdefined(eattacker.owner)) {
        player = eattacker.owner;
    }
    if (sessionmodeiscampaigngame()) {
        if (isdefined(player) && isplayer(player) && isalive(player)) {
            if (weapon.isheavyweapon) {
                dialog_shared::heavyweaponkilllogic(eattacker, weapon, undefined);
            } else {
                enemykilled_cooldown = "enemy_killed_vo_" + player.team;
                if (level util::iscooldownready(enemykilled_cooldown)) {
                    dialog_flag_team = 1;
                    level util::cooldown(enemykilled_cooldown, 4);
                    player dialog_shared::play_dialog("killenemy", dialog_flag_team);
                    level util::addcooldowntime(enemykilled_cooldown, 4);
                }
            }
        }
        if (isdefined(player) && isplayer(player) && !(isdefined(self.disable_score_events) && self.disable_score_events)) {
            if (!level.teambased || self.team != player.pers["team"]) {
                if (smeansofdeath == "MOD_MELEE" || smeansofdeath == "MOD_MELEE_ASSASSINATE") {
                    scoreevents::processscoreevent("melee_kill" + self.scoretype, player, self, weapon);
                } else {
                    scoreevents::processscoreevent("kill" + self.scoretype, player, self, weapon);
                }
                if (isdefined(level.challenges_callback_vehiclekilled)) {
                    self thread [[ level.challenges_callback_vehiclekilled ]](einflictor, player, idamage, smeansofdeath, weapon, shitloc);
                }
                self vehiclekilled_awardassists(einflictor, eattacker, weapon, eattacker.team);
            }
        }
        if (!isdefined(self.nodamagefeedback) || (!isdefined(params.isselfdestruct) || isdefined(eattacker) && !params.isselfdestruct) && self.nodamagefeedback !== 1) {
            if (damagefeedback::dodamagefeedback(weapon, einflictor)) {
                eattacker thread damagefeedback::update(smeansofdeath, einflictor, undefined, weapon, self, psoffsettime, shitloc);
            }
        }
    }
}

// Namespace globallogic_vehicle/globallogic_vehicle
// Params 0, eflags: 0x0
// Checksum 0x2c579be4, Offset: 0x1ff0
// Size: 0x9c
function vehiclecrush() {
    self endon(#"disconnect");
    if (isdefined(level._effect) && isdefined(level._effect["tanksquish"])) {
        playfx(level._effect["tanksquish"], self.origin + (0, 0, 30));
    }
    self playsound("chr_crunch");
}

// Namespace globallogic_vehicle/globallogic_vehicle
// Params 1, eflags: 0x0
// Checksum 0xe0aea903, Offset: 0x2098
// Size: 0x64
function getvehicleunderneathsplashscalar(weapon) {
    if (weapon.name == "satchel_charge") {
        scale = 10;
        scale *= 3;
    } else {
        scale = 1;
    }
    return scale;
}

// Namespace globallogic_vehicle/globallogic_vehicle
// Params 4, eflags: 0x0
// Checksum 0x55a10bd5, Offset: 0x2108
// Size: 0x9e
function allowfriendlyfiredamage(einflictor, eattacker, smeansofdeath, weapon) {
    if (getdvarint("g_vehicleBypassFriendlyFire") != 0) {
        return 1;
    }
    if (isdefined(self.skipfriendlyfirecheck) && self.skipfriendlyfirecheck) {
        return 1;
    }
    if (isdefined(self.allowfriendlyfiredamageoverride)) {
        return [[ self.allowfriendlyfiredamageoverride ]](einflictor, eattacker, smeansofdeath, weapon);
    }
    return 0;
}

// Namespace globallogic_vehicle/globallogic_vehicle
// Params 4, eflags: 0x0
// Checksum 0x8a11e19a, Offset: 0x21b0
// Size: 0x194
function vehiclekilled_awardassists(einflictor, eattacker, weapon, lpattackteam) {
    pixbeginevent("VehicleKilled assists");
    if (!isdefined(self.scoretype) || self.scoretype == "none") {
        return;
    }
    if (isdefined(self.attackers)) {
        for (j = 0; j < self.attackers.size; j++) {
            player = self.attackers[j];
            if (!isdefined(player)) {
                continue;
            }
            if (player == eattacker) {
                continue;
            }
            if (player.team != lpattackteam) {
                continue;
            }
            damage_done = self.attackerdamage[player.clientid].damage;
            player thread globallogic_score::processassist(self, damage_done, self.attackerdamage[player.clientid].weapon, "assist" + self.scoretype);
        }
    }
    pixendevent();
}

// Namespace globallogic_vehicle/globallogic_vehicle
// Params 1, eflags: 0x0
// Checksum 0x91942b9e, Offset: 0x2350
// Size: 0x1c4
function function_9a2dd68a(vehicle) {
    if (isdefined(vehicle.scriptbundlesettings)) {
        settings = struct::get_script_bundle("vehiclecustomsettings", vehicle.scriptbundlesettings);
        if (!isdefined(settings)) {
            return;
        }
    } else {
        return;
    }
    vehicle.var_ae92c796 = [];
    if (isdefined(settings.var_e80580dd)) {
        vehicle function_23f52910(0, settings.var_e80580dd);
    }
    if (isdefined(settings.var_c2030674)) {
        vehicle function_23f52910(1, settings.var_c2030674);
    }
    if (isdefined(settings.var_340a75af)) {
        vehicle function_23f52910(2, settings.var_340a75af);
    }
    if (isdefined(settings.var_e07fb46)) {
        vehicle function_23f52910(3, settings.var_e07fb46);
    }
    if (isdefined(settings.var_4ffb9739)) {
        vehicle function_23f52910(4, settings.var_4ffb9739);
    }
    vehicle flagsys::set("gameobject_seat_setup_complete");
    vehicle thread function_cc6cc0a3();
}

// Namespace globallogic_vehicle/globallogic_vehicle
// Params 2, eflags: 0x0
// Checksum 0xf9baa928, Offset: 0x2520
// Size: 0xbc
function function_23f52910(n_seat, str_gameobject_bundle) {
    self makevehicleunusable();
    self gameobjects::init_game_objects(str_gameobject_bundle, undefined, 0);
    self.var_ae92c796[n_seat] = self.mdl_gameobject;
    self.var_ae92c796[n_seat].n_seat = n_seat;
    self.var_ae92c796[n_seat].var_d58ebbd1 = 1;
    self thread function_74ac1dd9(n_seat);
}

// Namespace globallogic_vehicle/globallogic_vehicle
// Params 1, eflags: 0x0
// Checksum 0x5aef7180, Offset: 0x25e8
// Size: 0x138
function function_74ac1dd9(n_seat) {
    self endon(#"death");
    self.var_ae92c796[n_seat] endon(#"death");
    while (true) {
        waitresult = self.var_ae92c796[n_seat] waittill("gameobject_end_use_player");
        e_player = waitresult.player;
        if (isdefined(self.riders) && self.riders.size) {
            continue;
        }
        waitframe(1);
        self usevehicle(e_player, n_seat);
        self.var_ae92c796[n_seat] gameobjects::disable_object(1);
        array::thread_all(self.var_ae92c796, &gameobjects::hide_waypoint, e_player);
        e_player thread function_3966b965(self, n_seat);
    }
}

// Namespace globallogic_vehicle/globallogic_vehicle
// Params 2, eflags: 0x0
// Checksum 0xeacc39c7, Offset: 0x2728
// Size: 0x26c
function function_3966b965(vehicle, n_seat) {
    self endon(#"death");
    vehicle endon(#"death");
    vehicle.var_ae92c796[n_seat] endon(#"death");
    while (self usebuttonpressed() && self === vehicle getseatoccupant(n_seat)) {
        waitframe(1);
    }
    var_acf94e4c = 0;
    while (self === vehicle getseatoccupant(n_seat)) {
        if (self usebuttonpressed()) {
            var_acf94e4c++;
        } else {
            var_acf94e4c = 0;
        }
        if (var_acf94e4c >= 3) {
            break;
        }
        waitframe(1);
    }
    if (self === vehicle getseatoccupant(n_seat)) {
        vehicle usevehicle(self, n_seat);
        array::thread_all(vehicle.var_ae92c796, &gameobjects::show_waypoint, self);
    } else {
        var_37ade1ca = vehicle getoccupantseat(self);
        if (isdefined(var_37ade1ca) && var_37ade1ca !== -1 && isdefined(vehicle.var_ae92c796[var_37ade1ca])) {
            vehicle.var_ae92c796[var_37ade1ca] gameobjects::disable_object(1);
            self thread function_3966b965(vehicle, var_37ade1ca);
        }
    }
    if (!vehicle isvehicleseatoccupied(n_seat)) {
        vehicle.var_ae92c796[n_seat] gameobjects::enable_object(1);
    }
}

// Namespace globallogic_vehicle/globallogic_vehicle
// Params 0, eflags: 0x0
// Checksum 0xb186ed73, Offset: 0x29a0
// Size: 0xba
function function_cc6cc0a3() {
    a_gameobjects = self.var_ae92c796;
    self waittill("death");
    foreach (e_gameobject in a_gameobjects) {
        e_gameobject gameobjects::destroy_object(1, 1);
    }
}

