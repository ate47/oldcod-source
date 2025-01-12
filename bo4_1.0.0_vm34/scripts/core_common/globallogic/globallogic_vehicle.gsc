#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\dialog_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\gamestate;
#using scripts\core_common\globallogic\globallogic_player;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\loadout_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\weapons_shared;
#using scripts\weapons\weapon_utils;

#namespace globallogic_vehicle;

// Namespace globallogic_vehicle/globallogic_vehicle
// Params 1, eflags: 0x0
// Checksum 0x32ba8b5d, Offset: 0x1f0
// Size: 0x32c
function callback_vehiclespawned(spawner) {
    if (self.var_3e9c2d0b) {
        self.health = self.healthdefault;
    }
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
                    util::single_thread(self, func[#"function"], func[#"param1"], func[#"param2"], func[#"param3"], func[#"param4"]);
                }
            }
        }
    }
    self.spawner = spawner;
    if (issentient(self)) {
        self spawner::spawn_think(spawner);
    }
    if (self.vehicletype != #"zm_zod_train") {
        vehicle::init(self);
    }
    self thread function_43dc7b5a();
    vehicle::function_fc750064(self);
    self flagsys::set(#"vehicle_spawn_setup_complete");
}

// Namespace globallogic_vehicle/globallogic_vehicle
// Params 0, eflags: 0x0
// Checksum 0x2bd61ed6, Offset: 0x528
// Size: 0x9a
function function_43dc7b5a() {
    if (isdefined(self.var_16985b05) && self.var_16985b05 >= 0 && self.var_16985b05 < 2) {
        level flagsys::wait_till("all_players_spawned");
        a_e_players = util::get_players(self.team);
        if (isdefined(a_e_players[self.var_16985b05])) {
            self.owner = a_e_players[self.var_16985b05];
        }
    }
}

// Namespace globallogic_vehicle/globallogic_vehicle
// Params 2, eflags: 0x0
// Checksum 0x59239b39, Offset: 0x5d0
// Size: 0x112
function isfriendlyfire(eself, eattacker) {
    if (!isdefined(eattacker)) {
        return false;
    }
    if (isdefined(level.friendlyfire) && level.friendlyfire > 0) {
        return false;
    }
    occupant_team = eself vehicle::vehicle_get_occupant_team();
    if (occupant_team != "free" && occupant_team != "neutral" && (occupant_team === eattacker.team || util::function_baf4e8ea(occupant_team, eattacker.team))) {
        return true;
    }
    if (!level.hardcoremode && isdefined(eself.owner) && eself.owner === eattacker.owner) {
        return true;
    }
    return false;
}

// Namespace globallogic_vehicle/globallogic_vehicle
// Params 15, eflags: 0x0
// Checksum 0x6156f04b, Offset: 0x6f0
// Size: 0xcc4
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
    params.isselfdestruct = eattacker === self || eattacker === self.owner && self.selfdestruct === 1;
    params.friendlyfire = !params.isselfdestruct && isfriendlyfire(self, eattacker);
    if (!isdefined(self.maxhealth)) {
        self.maxhealth = self.healthdefault;
    }
    if (gamestate::is_game_over()) {
        avoid_damage_in_postgame = !sessionmodeismultiplayergame() && !sessionmodeiswarzonegame();
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
            weapon = getweapon(#"explodable_barrel");
        } else if (isdefined(einflictor.destructible_type) && issubstr(einflictor.destructible_type, "vehicle_")) {
            weapon = getweapon(#"destructible_car");
        }
    }
    if (smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_GRENADE") {
        idamage *= weapon.vehicleprojectiledamagescalar;
    } else if (smeansofdeath == "MOD_GRENADE_SPLASH") {
        idamage *= getvehicleunderneathsplashscalar(weapon);
    }
    idamage *= level.vehicledamagescalar;
    idamage *= self getvehdamagemultiplier(smeansofdeath);
    if (isdefined(weapon) && weapon == getweapon(#"eq_breachlauncher") && weapon_utils::isexplosivedamage(smeansofdeath) && isdefined(self.var_45711a0e) && self.var_45711a0e > 0) {
        idamage = int(self.healthdefault / self.var_45711a0e);
    }
    idamage = weapons::function_fa5602(idamage, weapon, self);
    idamage = int(idamage);
    unmodified = idamage;
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
    if (idflags & 8192 && idamage < unmodified) {
        idamage = unmodified;
    }
    assert(isdefined(idamage), "<dev string:x30>");
    if (idamage == 0) {
        return;
    }
    damageteammates = 0;
    if (!(idflags & 8192)) {
        if (self isvehicleimmunetodamage(idflags, smeansofdeath, weapon)) {
            return;
        }
        if (params.friendlyfire) {
            if (!allowfriendlyfiredamage(einflictor, eattacker, smeansofdeath, weapon)) {
                return;
            }
            damageteammates = 1;
        }
    }
    if (idamage < 1) {
        idamage = 1;
    }
    params.idamage = int(idamage);
    params.idflags = idflags;
    if (issentient(self)) {
        self callback::callback(#"on_ai_damage", params);
    }
    self callback::callback(#"on_vehicle_damage", params);
    idamage = int(idamage);
    if (isdefined(eattacker) && isplayer(eattacker)) {
        eattacker.pers[#"participation"]++;
    }
    if (!(isdefined(self.var_9c931473) && self.var_9c931473)) {
        driver = self getseatoccupant(0);
        if (isdefined(driver) && isplayer(driver) && !isbot(driver)) {
            damagepct = idamage / self.maxhealth;
            damagepct = int(max(damagepct, 3));
            driver addtodamageindicator(damagepct, vdir);
        } else {
            gunner = self getseatoccupant(1);
            if (isdefined(gunner) && isplayer(gunner) && !isbot(gunner)) {
                damagepct = idamage / self.maxhealth;
                damagepct = int(max(damagepct, 3));
                gunner addtodamageindicator(damagepct, vdir);
            }
        }
    }
    self globallogic_player::giveattackerandinflictorownerassist(eattacker, einflictor, idamage, smeansofdeath, weapon);
    if (isdefined(eattacker) && (!isdefined(params.isselfdestruct) || !params.isselfdestruct) && self.nodamagefeedback !== 1) {
        if (damagefeedback::dodamagefeedback(weapon, einflictor)) {
            eattacker thread damagefeedback::update(smeansofdeath, einflictor, undefined, weapon, self, psoffsettime, shitloc, 0);
        }
    }
    if (isplayer(eattacker) && isdefined(level.challenges_callback_vehicledamaged)) {
        self thread [[ level.challenges_callback_vehicledamaged ]](eattacker, eattacker, idamage, weapon, shitloc);
    }
    selfentnum = self getentitynumber();
    self finishvehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname, damageteammates);
    /#
        if (getdvarint(#"g_debugdamage", 0)) {
            println("<dev string:x69>" + selfentnum + "<dev string:x72>" + self.health + "<dev string:x7b>" + eattacker.clientid + "<dev string:x86>" + isplayer(einflictor) + "<dev string:x9c>" + idamage + "<dev string:xa5>" + shitloc);
        }
    #/
}

// Namespace globallogic_vehicle/globallogic_vehicle
// Params 13, eflags: 0x0
// Checksum 0x1d57da98, Offset: 0x13c0
// Size: 0x2e4
function callback_vehicleradiusdamage(einflictor, eattacker, idamage, finnerdamage, fouterdamage, idflags, smeansofdeath, weapon, vpoint, fradius, fconeanglecos, vconedir, psoffsettime) {
    idamage = loadout::cac_modified_vehicle_damage(self, eattacker, idamage, smeansofdeath, weapon, einflictor);
    finnerdamage = loadout::cac_modified_vehicle_damage(self, eattacker, finnerdamage, smeansofdeath, weapon, einflictor);
    fouterdamage = loadout::cac_modified_vehicle_damage(self, eattacker, fouterdamage, smeansofdeath, weapon, einflictor);
    self.idflags = idflags;
    self.idflagstime = gettime();
    isselfdestruct = eattacker === self || eattacker === self.owner && self.selfdestruct === 1;
    friendlyfire = !isselfdestruct && isfriendlyfire(self, eattacker);
    if (gamestate::is_game_over()) {
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
    if (idamage == 0) {
        return;
    }
    if (!(idflags & 8192)) {
        if (self isvehicleimmunetodamage(idflags, smeansofdeath, weapon)) {
            return;
        }
        if (friendlyfire) {
            if (!allowfriendlyfiredamage(einflictor, eattacker, smeansofdeath, weapon)) {
                return;
            }
        }
    }
    if (idamage < 1) {
        idamage = 1;
    }
    self finishvehicleradiusdamage(einflictor, eattacker, idamage, finnerdamage, fouterdamage, idflags, smeansofdeath, weapon, vpoint, fradius, fconeanglecos, vconedir, psoffsettime);
}

// Namespace globallogic_vehicle/globallogic_vehicle
// Params 8, eflags: 0x0
// Checksum 0x4c60d0ff, Offset: 0x16b0
// Size: 0x67c
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
    if (gamestate::is_game_over()) {
        return;
    }
    eattacker = globallogic_player::figureoutattacker(eattacker);
    if (isdefined(eattacker) && isplayer(eattacker) && !(isdefined(level.var_e4f168ac) && level.var_e4f168ac)) {
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
        self callback::callback(#"on_ai_killed", params);
    }
    self callback::callback(#"on_vehicle_killed", params);
    if (isdefined(self.overridevehiclekilled)) {
        self [[ self.overridevehiclekilled ]](einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
    }
    player = eattacker;
    if (isdefined(eattacker) && isdefined(eattacker.classname) && eattacker.classname == "script_vehicle" && isdefined(eattacker.owner)) {
        player = eattacker.owner;
    }
    if (sessionmodeiscampaigngame()) {
        if (isdefined(player) && isplayer(player) && isalive(player)) {
            if (weapon.isheavyweapon) {
                dialog_shared::heavyweaponkilllogic(eattacker, weapon, undefined);
            } else {
                enemykilled_cooldown = "enemy_killed_vo_" + string(player.team);
                if (level util::iscooldownready(enemykilled_cooldown)) {
                    var_2f0ec686 = 1;
                    level util::cooldown(enemykilled_cooldown, 4);
                    player dialog_shared::play_dialog("killenemy", var_2f0ec686);
                    level util::addcooldowntime(enemykilled_cooldown, 4);
                }
            }
        }
        if (isdefined(player) && isplayer(player) && !(isdefined(self.disable_score_events) && self.disable_score_events)) {
            if (!level.teambased || self.team != player.pers[#"team"]) {
                if (smeansofdeath == "MOD_MELEE" || smeansofdeath == "MOD_MELEE_ASSASSINATE") {
                    scoreevents::processscoreevent(#"melee_kill" + self.scoretype, player, self, weapon);
                } else {
                    scoreevents::processscoreevent(#"kill" + self.scoretype, player, self, weapon);
                }
                if (isdefined(level.challenges_callback_vehiclekilled)) {
                    self thread [[ level.challenges_callback_vehiclekilled ]](einflictor, player, idamage, smeansofdeath, weapon, shitloc);
                }
                self vehiclekilled_awardassists(einflictor, eattacker, weapon, eattacker.team);
            }
        }
        if (isdefined(eattacker) && (!isdefined(params.isselfdestruct) || !params.isselfdestruct) && (!isdefined(self.nodamagefeedback) || self.nodamagefeedback !== 1)) {
            if (damagefeedback::dodamagefeedback(weapon, einflictor)) {
                eattacker thread damagefeedback::update(smeansofdeath, einflictor, undefined, weapon, self, psoffsettime, shitloc, 0);
            }
        }
    }
}

// Namespace globallogic_vehicle/globallogic_vehicle
// Params 1, eflags: 0x0
// Checksum 0xe9483085, Offset: 0x1d38
// Size: 0x4e
function function_bc49bd22(vec) {
    inverse = 0.0568182;
    return (vec[0] * inverse, vec[1] * inverse, vec[2] * inverse);
}

// Namespace globallogic_vehicle/globallogic_vehicle
// Params 2, eflags: 0x0
// Checksum 0xe4e74957, Offset: 0x1d90
// Size: 0x2fc
function vehiclecrush(eattacker, einflictor) {
    self endon(#"disconnect");
    if (isdefined(level._effect) && isdefined(level._effect[#"tanksquish"])) {
        playfx(level._effect[#"tanksquish"], self.origin + (0, 0, 30));
    }
    self playsound(#"chr_crunch");
    vehicle = einflictor;
    if (!isvehicle(vehicle)) {
        vehicle = eattacker;
    }
    if (isvehicle(vehicle)) {
        velocity = function_bc49bd22(vehicle getvelocity());
        speedscale = length(velocity) / 30;
        forwardvec = vectornormalize(velocity);
        upvec = (0, 0, 1);
        leftvec = vectornormalize(vectorcross(upvec, forwardvec));
        forwardscale = speedscale * randomfloatrange(50, 150);
        upscale = speedscale * randomfloatrange(50, 75);
        leftscale = speedscale * randomfloatrange(-25, 25);
        force = velocity + forwardvec * forwardscale + upvec * upscale + leftvec * leftscale;
        var_5685599a = length(force);
        force = vectornormalize(force) * math::clamp(var_5685599a, 5, 250);
        self launchragdoll(force);
    }
}

// Namespace globallogic_vehicle/globallogic_vehicle
// Params 1, eflags: 0x0
// Checksum 0x788fcc9c, Offset: 0x2098
// Size: 0x5e
function getvehicleunderneathsplashscalar(weapon) {
    if (weapon.name == #"satchel_charge") {
        scale = 10;
        scale *= 3;
    } else {
        scale = 1;
    }
    return scale;
}

// Namespace globallogic_vehicle/globallogic_vehicle
// Params 4, eflags: 0x0
// Checksum 0xe10d4634, Offset: 0x2100
// Size: 0x9a
function allowfriendlyfiredamage(einflictor, eattacker, smeansofdeath, weapon) {
    if (getdvarint(#"g_vehiclebypassfriendlyfire", 0) != 0) {
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
// Checksum 0x4b2f0011, Offset: 0x21a8
// Size: 0x1cc
function vehiclekilled_awardassists(einflictor, eattacker, weapon, lpattackteam) {
    pixbeginevent(#"hash_1ec5cd32e99d8672");
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
            time = self.attackerdamage[player.clientid].time;
            meansofdeath = self.attackerdamage[player.clientid].meansofdeath;
            player thread globallogic_score::processassist(self, damage_done, self.attackerdamage[player.clientid].weapon, "assist" + self.scoretype, time, meansofdeath);
        }
    }
    pixendevent();
}

