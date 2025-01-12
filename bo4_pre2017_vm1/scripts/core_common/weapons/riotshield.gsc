#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/killstreaks_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace riotshield;

// Namespace riotshield/riotshield
// Params 0, eflags: 0x0
// Checksum 0x695620e8, Offset: 0x598
// Size: 0x15c
function init_shared() {
    if (!isdefined(level.weaponriotshield)) {
        level.weaponriotshield = getweapon("riotshield");
    }
    level.deployedshieldmodel = "wpn_t7_shield_riot_world";
    level.stowedshieldmodel = "wpn_t7_shield_riot_world";
    level.carriedshieldmodel = "wpn_t7_shield_riot_world";
    level.detectshieldmodel = "wpn_t7_shield_riot_world";
    level.riotshielddestroyanim = mp_riotshield%o_riot_stand_destroyed;
    level.riotshielddeployanim = mp_riotshield%o_riot_stand_deploy;
    level.riotshieldshotanimfront = mp_riotshield%o_riot_stand_shot;
    level.riotshieldshotanimback = mp_riotshield%o_riot_stand_shot_back;
    level.riotshieldmeleeanimfront = mp_riotshield%o_riot_stand_melee_front;
    level.riotshieldmeleeanimback = mp_riotshield%o_riot_stand_melee_back;
    level.riotshield_placement_zoffset = 26;
    thread register();
    callback::on_spawned(&on_player_spawned);
}

// Namespace riotshield/riotshield
// Params 0, eflags: 0x0
// Checksum 0x28ccaeb4, Offset: 0x700
// Size: 0x34
function register() {
    clientfield::register("scriptmover", "riotshield_state", 1, 2, "int");
}

// Namespace riotshield/riotshield
// Params 0, eflags: 0x0
// Checksum 0x4e4938e, Offset: 0x740
// Size: 0x9c
function watchpregameclasschange() {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"track_riot_shield");
    self waittill("changed_class");
    if (level.ingraceperiod && !self.hasdonecombat) {
        self clearstowedweapon();
        self refreshshieldattachment();
        self thread trackriotshield();
    }
}

// Namespace riotshield/riotshield
// Params 0, eflags: 0x0
// Checksum 0x397def22, Offset: 0x7e8
// Size: 0x10c
function watchriotshieldpickup() {
    self endon(#"death", #"disconnect", #"track_riot_shield");
    self notify(#"watch_riotshield_pickup");
    self endon(#"watch_riotshield_pickup");
    self waittill("pickup_riotshield");
    self endon(#"weapon_change");
    println("<dev string:x28>");
    wait 0.5;
    println("<dev string:x60>");
    currentweapon = self getcurrentweapon();
    self.hasriotshield = self hasriotshield();
    self.hasriotshieldequipped = currentweapon.isriotshield;
    self refreshshieldattachment();
}

// Namespace riotshield/riotshield
// Params 0, eflags: 0x0
// Checksum 0x7fe5606b, Offset: 0x900
// Size: 0x260
function trackriotshield() {
    self endon(#"death");
    self endon(#"disconnect");
    self notify(#"track_riot_shield");
    self endon(#"track_riot_shield");
    self thread watchpregameclasschange();
    self waittill("weapon_change");
    self refreshshieldattachment();
    currentweapon = self getcurrentweapon();
    self.hasriotshield = self hasriotshield();
    self.hasriotshieldequipped = currentweapon.isriotshield;
    self.lastnonshieldweapon = level.weaponnone;
    while (true) {
        self thread watchriotshieldpickup();
        currentweapon = self getcurrentweapon();
        currentweapon = self getcurrentweapon();
        self.hasriotshield = self hasriotshield();
        self.hasriotshieldequipped = currentweapon.isriotshield;
        refresh_attach = 0;
        waitresult = self waittill("weapon_change");
        if (waitresult.weapon.isriotshield) {
            refresh_attach = 1;
            if (isdefined(self.riotshieldentity)) {
                self notify(#"destroy_riotshield");
            }
            if (self.hasriotshield) {
                if (isdefined(self.riotshieldtakeweapon)) {
                    self takeweapon(self.riotshieldtakeweapon);
                    self.riotshieldtakeweapon = undefined;
                }
            }
            if (isvalidnonshieldweapon(currentweapon)) {
                self.lastnonshieldweapon = currentweapon;
            }
        }
        if (self.hasriotshield || refresh_attach == 1) {
            self refreshshieldattachment();
        }
    }
}

// Namespace riotshield/riotshield
// Params 1, eflags: 0x0
// Checksum 0x9a1e94d, Offset: 0xb68
// Size: 0x86
function isvalidnonshieldweapon(weapon) {
    if (killstreaks::is_killstreak_weapon(weapon)) {
        return false;
    }
    if (weapon.iscarriedkillstreak) {
        return false;
    }
    if (weapon.isgameplayweapon) {
        return false;
    }
    if (weapon == level.weaponnone) {
        return false;
    }
    if (weapon.isequipment) {
        return false;
    }
    return true;
}

// Namespace riotshield/riotshield
// Params 0, eflags: 0x0
// Checksum 0x8707fb29, Offset: 0xbf8
// Size: 0x24
function startriotshielddeploy() {
    self notify(#"start_riotshield_deploy");
    self thread watchriotshielddeploy();
}

// Namespace riotshield/riotshield
// Params 1, eflags: 0x0
// Checksum 0x488a6dd8, Offset: 0xc28
// Size: 0x186
function resetreconmodelvisibility(owner) {
    if (!isdefined(self)) {
        return;
    }
    self setinvisibletoall();
    self setforcenocull();
    if (!isdefined(owner)) {
        return;
    }
    for (i = 0; i < level.players.size; i++) {
        if (level.players[i] hasperk("specialty_showenemyequipment")) {
            if (level.players[i].team == "spectator") {
                continue;
            }
            isenemy = 1;
            if (level.teambased) {
                if (level.players[i].team == owner.team) {
                    isenemy = 0;
                }
            } else if (level.players[i] == owner) {
                isenemy = 0;
            }
            if (isenemy) {
                self setvisibletoplayer(level.players[i]);
            }
        }
    }
}

// Namespace riotshield/riotshield
// Params 2, eflags: 0x0
// Checksum 0x5089fa65, Offset: 0xdb8
// Size: 0x80
function resetreconmodelonevent(eventname, owner) {
    self endon(#"death");
    for (;;) {
        waitresult = level waittill(eventname);
        if (isdefined(waitresult.player)) {
            owner = waitresult.player;
        }
        self resetreconmodelvisibility(owner);
    }
}

// Namespace riotshield/riotshield
// Params 2, eflags: 0x0
// Checksum 0x3996ff40, Offset: 0xe40
// Size: 0x134
function attachreconmodel(modelname, owner) {
    if (!isdefined(self)) {
        return;
    }
    reconmodel = spawn("script_model", self.origin);
    reconmodel.angles = self.angles;
    reconmodel setmodel(modelname);
    reconmodel.model_name = modelname;
    reconmodel linkto(self);
    reconmodel setcontents(0);
    reconmodel resetreconmodelvisibility(owner);
    reconmodel thread resetreconmodelonevent("joined_team", owner);
    reconmodel thread resetreconmodelonevent("player_spawned", owner);
    self.reconmodel = reconmodel;
}

// Namespace riotshield/riotshield
// Params 2, eflags: 0x0
// Checksum 0xffa51ec8, Offset: 0xf80
// Size: 0x160
function spawnriotshieldcover(origin, angles) {
    shield_ent = spawn("script_model", origin, 1);
    shield_ent.targetname = "riotshield_mp";
    shield_ent.angles = angles;
    shield_ent setmodel(level.deployedshieldmodel);
    shield_ent setowner(self);
    shield_ent.owner = self;
    shield_ent.team = self.team;
    shield_ent setteam(self.team);
    shield_ent attachreconmodel(level.detectshieldmodel, self);
    shield_ent useanimtree(#mp_riotshield);
    shield_ent setscriptmoverflag(0);
    shield_ent disconnectpaths();
    return shield_ent;
}

// Namespace riotshield/riotshield
// Params 0, eflags: 0x0
// Checksum 0xe7c56656, Offset: 0x10e8
// Size: 0x46c
function watchriotshielddeploy() {
    self endon(#"death", #"disconnect", #"start_riotshield_deploy");
    waitresult = self waittill("deploy_riotshield");
    deploy_attempt = waitresult.is_deploy_attempt;
    weapon = waitresult.weapon;
    self setplacementhint(1);
    placement_hint = 0;
    if (deploy_attempt) {
        placement = self canplaceriotshield("deploy_riotshield");
        if (placement["result"]) {
            self.hasdonecombat = 1;
            zoffset = level.riotshield_placement_zoffset;
            shield_ent = self spawnriotshieldcover(placement["origin"] + (0, 0, zoffset), placement["angles"]);
            item_ent = deployriotshield(self, shield_ent);
            primaries = self getweaponslistprimaries();
            /#
                assert(isdefined(item_ent));
                assert(!isdefined(self.riotshieldretrievetrigger));
                assert(!isdefined(self.riotshieldentity));
                if (level.gametype != "<dev string:x97>") {
                    assert(primaries.size > 0);
                }
            #/
            shield_ent clientfield::set("riotshield_state", 1);
            shield_ent.reconmodel clientfield::set("riotshield_state", 1);
            if (level.gametype != "shrp") {
                if (self.lastnonshieldweapon != level.weaponnone && self hasweapon(self.lastnonshieldweapon)) {
                    self switchtoweapon(self.lastnonshieldweapon);
                } else {
                    self switchtoweapon(primaries[0]);
                }
            }
            if (!self hasweapon(level.weaponbasemeleeheld)) {
                self giveweapon(level.weaponbasemeleeheld);
                self.riotshieldtakeweapon = level.weaponbasemeleeheld;
            }
            self.riotshieldretrievetrigger = item_ent;
            self.riotshieldentity = shield_ent;
            self thread watchdeployedriotshieldents();
            self thread deleteshieldontriggerdeath(self.riotshieldretrievetrigger);
            self thread deleteshieldonplayerdeathordisconnect(shield_ent);
            self.riotshieldentity thread watchdeployedriotshielddamage();
            level notify(#"riotshield_planted", {#player:self});
        } else {
            placement_hint = 1;
            clip_max_ammo = weapon.clipsize;
            self setweaponammoclip(weapon, clip_max_ammo);
        }
    } else {
        placement_hint = 1;
    }
    if (placement_hint) {
        self setriotshieldfailhint();
    }
}

// Namespace riotshield/riotshield
// Params 1, eflags: 0x0
// Checksum 0xd76197d4, Offset: 0x1560
// Size: 0x12e
function riotshielddistancetest(origin) {
    assert(isdefined(origin));
    min_dist_squared = getdvarfloat("riotshield_deploy_limit_radius");
    min_dist_squared *= min_dist_squared;
    for (i = 0; i < level.players.size; i++) {
        if (isdefined(level.players[i].riotshieldentity)) {
            dist_squared = distancesquared(level.players[i].riotshieldentity.origin, origin);
            if (min_dist_squared > dist_squared) {
                println("<dev string:x9c>");
                return false;
            }
        }
    }
    return true;
}

// Namespace riotshield/riotshield
// Params 0, eflags: 0x0
// Checksum 0xfe9a722d, Offset: 0x1698
// Size: 0xfc
function watchdeployedriotshieldents() {
    /#
        assert(isdefined(self.riotshieldretrievetrigger));
        assert(isdefined(self.riotshieldentity));
    #/
    self waittill("destroy_riotshield");
    if (isdefined(self.riotshieldretrievetrigger)) {
        self.riotshieldretrievetrigger delete();
    }
    if (isdefined(self.riotshieldentity)) {
        if (isdefined(self.riotshieldentity.reconmodel)) {
            self.riotshieldentity.reconmodel delete();
        }
        self.riotshieldentity connectpaths();
        self.riotshieldentity delete();
    }
}

// Namespace riotshield/riotshield
// Params 0, eflags: 0x0
// Checksum 0x8235b090, Offset: 0x17a0
// Size: 0x364
function watchdeployedriotshielddamage() {
    self endon(#"death");
    damagemax = getdvarint("riotshield_deployed_health");
    self.damagetaken = 0;
    while (true) {
        self.maxhealth = 100000;
        self.health = self.maxhealth;
        waitresult = self waittill("damage");
        attacker = waitresult.attacker;
        damage = waitresult.amount;
        weapon = waitresult.weapon;
        type = waitresult.mod;
        if (!isdefined(attacker)) {
            continue;
        }
        assert(isdefined(self.owner) && isdefined(self.owner.team));
        if (isplayer(attacker)) {
            if (level.teambased && attacker.team == self.owner.team && attacker != self.owner) {
                continue;
            }
        }
        if (type == "MOD_MELEE" || type == "MOD_MELEE_ASSASSINATE") {
            damage *= getdvarfloat("riotshield_melee_damage_scale");
        } else if (type == "MOD_PISTOL_BULLET" || type == "MOD_RIFLE_BULLET") {
            damage *= getdvarfloat("riotshield_bullet_damage_scale");
        } else if (type == "MOD_GRENADE" || type == "MOD_GRENADE_SPLASH" || type == "MOD_EXPLOSIVE" || type == "MOD_EXPLOSIVE_SPLASH" || type == "MOD_PROJECTILE" || type == "MOD_PROJECTILE_SPLASH") {
            damage *= getdvarfloat("riotshield_explosive_damage_scale");
        } else if (type == "MOD_IMPACT") {
            damage *= getdvarfloat("riotshield_projectile_damage_scale");
        } else if (type == "MOD_CRUSH") {
            damage = damagemax;
        }
        self.damagetaken += damage;
        if (self.damagetaken >= damagemax) {
            self thread damagethendestroyriotshield(attacker, weapon);
            break;
        }
    }
}

// Namespace riotshield/riotshield
// Params 2, eflags: 0x0
// Checksum 0x15a63921, Offset: 0x1b10
// Size: 0x184
function damagethendestroyriotshield(attacker, weapon) {
    self notify(#"damagethendestroyriotshield");
    self endon(#"death");
    if (isdefined(self.owner.riotshieldretrievetrigger)) {
        self.owner.riotshieldretrievetrigger delete();
    }
    if (isdefined(self.reconmodel)) {
        self.reconmodel delete();
    }
    self connectpaths();
    self.owner.riotshieldentity = undefined;
    self notsolid();
    self clientfield::set("riotshield_state", 2);
    if (isdefined(attacker) && attacker != self.owner && isplayer(attacker)) {
        scoreevents::processscoreevent("destroyed_shield", attacker, self.owner, weapon);
    }
    wait getdvarfloat("riotshield_destroyed_cleanup_time");
    self delete();
}

// Namespace riotshield/riotshield
// Params 1, eflags: 0x0
// Checksum 0x506938e5, Offset: 0x1ca0
// Size: 0x32
function deleteshieldontriggerdeath(shield_trigger) {
    shield_trigger waittill("trigger", "death");
    self notify(#"destroy_riotshield");
}

// Namespace riotshield/riotshield
// Params 1, eflags: 0x0
// Checksum 0xef416e8f, Offset: 0x1ce0
// Size: 0x64
function deleteshieldonplayerdeathordisconnect(shield_ent) {
    shield_ent endon(#"death");
    shield_ent endon(#"damagethendestroyriotshield");
    self waittill("death", "disconnect", "remove_planted_weapons");
    shield_ent thread damagethendestroyriotshield();
}

// Namespace riotshield/riotshield
// Params 2, eflags: 0x0
// Checksum 0xe6250997, Offset: 0x1d50
// Size: 0x6c
function watchriotshieldstuckentitydeath(grenade, owner) {
    grenade endon(#"death");
    self waittill("damageThenDestroyRiotshield", "death", "disconnect", "weapon_change", "deploy_riotshield");
    grenade detonate(owner);
}

// Namespace riotshield/riotshield
// Params 0, eflags: 0x0
// Checksum 0x9552e399, Offset: 0x1dc8
// Size: 0x34
function on_player_spawned() {
    self thread watch_riot_shield_use();
    self thread begin_other_grenade_tracking();
}

// Namespace riotshield/riotshield
// Params 0, eflags: 0x0
// Checksum 0x9e1b0aae, Offset: 0x1e08
// Size: 0x58
function watch_riot_shield_use() {
    self endon(#"death");
    self endon(#"disconnect");
    self thread trackriotshield();
    for (;;) {
        self waittill("raise_riotshield");
        self thread startriotshielddeploy();
    }
}

// Namespace riotshield/riotshield
// Params 0, eflags: 0x0
// Checksum 0x43af8b1e, Offset: 0x1e68
// Size: 0xf2
function begin_other_grenade_tracking() {
    self endon(#"death");
    self endon(#"disconnect");
    self notify(#"hash_7fac4805");
    self endon(#"hash_7fac4805");
    for (;;) {
        waitresult = self waittill("grenade_fire");
        grenade = waitresult.projectile;
        weapon = waitresult.weapon;
        if (grenade util::ishacked()) {
            continue;
        }
        switch (weapon.name) {
        case #"explosive_bolt":
        case #"proximity_grenade":
        case #"sticky_grenade":
            grenade thread check_stuck_to_shield();
            break;
        }
    }
}

// Namespace riotshield/riotshield
// Params 0, eflags: 0x0
// Checksum 0x10109718, Offset: 0x1f68
// Size: 0x5c
function check_stuck_to_shield() {
    self endon(#"death");
    waitresult = self waittill("stuck_to_shield");
    waitresult.entity watchriotshieldstuckentitydeath(self, waitresult.owner);
}

