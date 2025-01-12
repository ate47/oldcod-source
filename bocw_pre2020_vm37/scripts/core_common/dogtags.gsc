#using script_6167e26342be354b;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\oob;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spectating;
#using scripts\core_common\util_shared;

#namespace dogtags;

// Namespace dogtags/dogtags
// Params 0, eflags: 0x0
// Checksum 0xeedbf7d0, Offset: 0x238
// Size: 0xcc
function init() {
    level.antiboostdistance = getgametypesetting(#"antiboostdistance");
    level.dogtags = [];
    callback::on_spawned(&on_spawn_player);
    callback::on_player_killed(&on_player_killed);
    gameobjects::function_ad0c0995(&function_1d8e2a5b);
    clientfield::register("scriptmover", "dogtag_flag", 1, 2, "int");
}

// Namespace dogtags/dogtags
// Params 3, eflags: 0x5 linked
// Checksum 0x4da7616c, Offset: 0x310
// Size: 0x308
function private function_bf06b7aa(victim, *attacker, on_use_function) {
    dogtag = function_afe6cbc4(attacker);
    if (isdefined(dogtag)) {
        return dogtag;
    }
    if (is_true(getgametypesetting("dogTagPooling"))) {
        arrayremovevalue(level.dogtags, undefined, 0);
        poolsize = isdefined(getgametypesetting("dogTagPoolSize")) ? getgametypesetting("dogTagPoolSize") : 0;
        if (poolsize > 0 && level.dogtags.size > poolsize) {
            level.dogtags[0] reset_tags();
        }
    } else {
        arrayremovevalue(level.dogtags, undefined, 1);
    }
    visuals = [];
    trigger = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);
    objectivename = isdefined(level.var_febab1ea) ? level.var_febab1ea : #"conf_dogtags";
    dogtag = gameobjects::create_use_object(attacker.team, trigger, visuals, (0, 0, 0), objectivename);
    trigger.dogtag = dogtag;
    dogtag gameobjects::set_use_time(0);
    dogtag.onuse = &onuse;
    dogtag.custom_onuse = on_use_function;
    dogtag.victim = attacker;
    dogtag.victimteam = attacker.team;
    dogtag.var_5ee49ea8 = attacker getspecialistindex();
    level thread clear_on_victim_disconnect(attacker);
    attacker thread team_updater(dogtag);
    if (is_true(getgametypesetting("dogTagPooling"))) {
        level.dogtags[level.dogtags.size] = dogtag;
    } else {
        level.dogtags[attacker getentitynumber()] = dogtag;
    }
    return dogtag;
}

// Namespace dogtags/dogtags
// Params 1, eflags: 0x5 linked
// Checksum 0xf7b15122, Offset: 0x620
// Size: 0x17c
function private function_329adc0f(dogtag) {
    dogtag gameobjects::allow_use(#"hash_161f03feaadc9b8f");
    playfx("ui/fx_kill_confirmed_vanish", dogtag.curorigin);
    dogtag notify(#"reset");
    waitframe(1);
    if (isdefined(dogtag)) {
        if (isdefined(dogtag.objectiveid)) {
            objective_delete(dogtag.objectiveid);
        }
        if (isdefined(dogtag.trigger)) {
            dogtag.trigger delete();
        }
        if (isdefined(dogtag.var_2581d0d)) {
            dogtag.var_2581d0d deletedelay();
        }
        dogtag notify(#"deleted");
        dogtag gameobjects::destroy_object(1);
        if (!is_true(getgametypesetting("dogTagPooling"))) {
            arrayremovevalue(level.dogtags, undefined, 1);
            return;
        }
        arrayremovevalue(level.dogtags, undefined, 0);
    }
}

// Namespace dogtags/dogtags
// Params 1, eflags: 0x5 linked
// Checksum 0x6b694737, Offset: 0x7a8
// Size: 0x54
function private function_afe6cbc4(victim) {
    if (is_true(getgametypesetting("dogTagPooling"))) {
        return;
    }
    return level.dogtags[victim getentitynumber()];
}

// Namespace dogtags/dogtags
// Params 5, eflags: 0x0
// Checksum 0x6bd40926, Offset: 0x808
// Size: 0x4f8
function spawn_dog_tag(victim, attacker, on_use_function, objectives_for_attacker_and_victim_only, posoffset) {
    dogtag = function_afe6cbc4(victim);
    if (isdefined(dogtag)) {
        playfx("ui/fx_kill_confirmed_vanish", dogtag.curorigin);
        dogtag notify(#"reset");
        dogtag dontinterpolate();
        var_5ee49ea8 = victim getspecialistindex();
        if (var_5ee49ea8 != dogtag.var_5ee49ea8) {
            dogtag.var_5ee49ea8 = var_5ee49ea8;
        }
        if (isdefined(dogtag.var_2581d0d)) {
            dogtag.var_2581d0d delete();
            dogtag.var_2581d0d = undefined;
        }
    } else {
        dogtag = function_bf06b7aa(victim, attacker, on_use_function);
    }
    dogtag gameobjects::allow_use(#"hash_5ccfd7bbbf07c770");
    baseoffset = (0, 0, 14);
    pos = victim.origin + baseoffset;
    if (isvec(posoffset)) {
        pos += posoffset;
    }
    dogtag.origin = pos;
    dogtag.curorigin = pos;
    dogtag.trigger.origin = pos;
    dogtag function_9b289986(dogtag.var_5ee49ea8);
    dogtag.team = victim.team;
    dogtag.attacker = attacker;
    dogtag.attackerteam = attacker.team;
    dogtag.unreachable = undefined;
    dogtag.tacinsert = 0;
    if ((isdefined(getgametypesetting("dogTagTimeOut")) ? getgametypesetting("dogTagTimeOut") : 0) > 0) {
        dogtag thread time_out(victim);
    }
    if (isdefined(dogtag.objectiveid)) {
        objective_setstate(dogtag.objectiveid, "active");
        objective_setteam(dogtag.objectiveid, victim.team);
        objective_setposition(dogtag.objectiveid, pos);
    }
    if (objectives_for_attacker_and_victim_only) {
        objective_setinvisibletoall(dogtag.objectiveid);
        if (isplayer(attacker)) {
            objective_setvisibletoplayer(dogtag.objectiveid, attacker);
        }
        if (isplayer(victim)) {
            objective_setvisibletoplayer(dogtag.objectiveid, victim);
        }
    }
    var_ab7c8c8a = victim isonladder();
    var_1175c328 = victim isinvehicle() && !victim getvehicleoccupied() isremotecontrol();
    var_35fcab51 = victim depthinwater() > abs(victim.origin[2] - pos[2]) && !var_1175c328;
    var_f5ac9ac4 = victim oob::istouchinganyoobtrigger() || !victim oob::function_323d32db();
    if (!var_35fcab51 && !var_ab7c8c8a && !var_f5ac9ac4) {
        dogtag function_78a745d7(pos, victim);
    } else {
        dogtag function_b2a61c9d();
    }
    level notify(#"dogtag_spawned");
}

// Namespace dogtags/dogtags
// Params 1, eflags: 0x5 linked
// Checksum 0x8ac12594, Offset: 0xd08
// Size: 0x34
function private function_9b289986(index = 0) {
    self function_209d6da2(index);
}

// Namespace dogtags/dogtags
// Params 2, eflags: 0x1 linked
// Checksum 0x579a01d3, Offset: 0xd48
// Size: 0x164
function function_78a745d7(var_561c6e7c, var_5bb2a7e9) {
    dropangles = (-60, randomint(360), 0);
    force = anglestoforward(dropangles) * randomfloatrange(150, 220);
    self.var_2581d0d = var_5bb2a7e9 magicmissile(getweapon(#"hash_1a8e376e04ffed9d"), var_561c6e7c, force);
    self.var_2581d0d setmodel(#"tag_origin");
    self.var_2581d0d hide();
    self.var_2581d0d notsolid();
    self thread function_b9937933();
    self thread function_924c73e6();
    self clientfield::set("dogtag_flag", 1);
}

// Namespace dogtags/dogtags
// Params 0, eflags: 0x1 linked
// Checksum 0x9cf8c79, Offset: 0xeb8
// Size: 0x74
function function_b2a61c9d() {
    if (self clientfield::get("dogtag_flag") == 2) {
        self clientfield::set("dogtag_flag", 3);
        return;
    }
    self clientfield::set("dogtag_flag", 2);
}

// Namespace dogtags/dogtags
// Params 0, eflags: 0x1 linked
// Checksum 0xa04884b8, Offset: 0xf38
// Size: 0x1b0
function function_b9937933() {
    level endon(#"game_ended");
    self endon(#"reset");
    self.var_2581d0d endon(#"death", #"stationary");
    while (true) {
        if (!isdefined(self.var_2581d0d)) {
            return;
        }
        if (self depthinwater() > 0) {
            self.trigger.origin = self.var_2581d0d.origin;
            self.var_2581d0d notify(#"stationary");
            return;
        }
        if (self.var_2581d0d oob::istouchinganyoobtrigger() || !self.var_2581d0d oob::function_323d32db() || self.var_2581d0d gameobjects::is_touching_any_trigger_key_value("trigger_hurt", "classname", self.trigger.origin[2], self.trigger.origin[2] + 32)) {
            self.trigger.origin = self.var_2581d0d.origin;
            self.var_2581d0d notify(#"stationary");
            return;
        }
        self.trigger.origin = self.var_2581d0d.origin;
        waitframe(1);
    }
}

// Namespace dogtags/dogtags
// Params 0, eflags: 0x1 linked
// Checksum 0x73f182d4, Offset: 0x10f0
// Size: 0x10e
function function_924c73e6() {
    level endon(#"game_ended");
    self endon(#"reset");
    self.var_2581d0d endon(#"death");
    self.var_2581d0d waittill(#"stationary");
    self.trigger.origin = self.var_2581d0d.origin;
    self.origin = self.trigger.origin;
    waittillframeend();
    if (!isdefined(self)) {
        return;
    }
    objective_setposition(self.objectiveid, self.origin);
    self function_b2a61c9d();
    if (isdefined(self.var_2581d0d)) {
        self.var_2581d0d delete();
        self.var_2581d0d = undefined;
    }
}

// Namespace dogtags/dogtags
// Params 1, eflags: 0x1 linked
// Checksum 0x53c1490c, Offset: 0x1208
// Size: 0x29c
function onuse(player) {
    if (!isdefined(player) || !isdefined(self)) {
        return;
    }
    player playsoundontag("mpl_killconfirm_tags_pickup", "j_head");
    tacinsertboost = 0;
    if (!util::function_fbce7263(player.team, self.victimteam)) {
        player stats::function_dad108fa(#"killsdenied", 1);
        player recordgameevent("return");
        event = "kill_denied";
        if (self.victim == player) {
            if (self.tacinsert == 0) {
                event = "retrieve_own_tags";
            } else {
                tacinsertboost = 1;
            }
        }
        if (!tacinsertboost) {
            player.pers[#"killsdenied"]++;
            player.killsdenied = player.pers[#"killsdenied"];
        }
    } else {
        event = "kill_confirmed";
        if (util::function_fbce7263(player.team, self.attackerteam)) {
            event = "squad_confirmed_kill_stolen";
        }
        player stats::function_dad108fa(#"killsconfirmed", 1);
        player recordgameevent("capture");
        if (isdefined(self.attacker) && self.attacker != player && !util::function_fbce7263(player.team, self.attacker.team)) {
            self.attacker onpickup("teammate_kill_confirmed");
        }
    }
    if (!tacinsertboost && isdefined(player)) {
        player onpickup(event);
    }
    if (isdefined(self.custom_onuse)) {
        [[ self.custom_onuse ]](player);
    }
    self thread reset_tags();
}

// Namespace dogtags/dogtags
// Params 0, eflags: 0x1 linked
// Checksum 0x32e5074d, Offset: 0x14b0
// Size: 0x13c
function reset_tags() {
    self.attacker = undefined;
    self.unreachable = 1;
    self notify(#"reset");
    self.curorigin = (0, 0, 1000);
    self.trigger.origin = (0, 0, 1000);
    self.tacinsert = 0;
    self gameobjects::allow_use(#"hash_161f03feaadc9b8f");
    self clientfield::set("dogtag_flag", 0);
    if (isdefined(self.var_2581d0d)) {
        self.var_2581d0d deletedelay();
        self.var_2581d0d = undefined;
    }
    objective_setstate(self.objectiveid, "invisible");
    if (is_true(getgametypesetting("dogTagPooling"))) {
        function_329adc0f(self);
    }
}

// Namespace dogtags/dogtags
// Params 1, eflags: 0x1 linked
// Checksum 0x8bceccd, Offset: 0x15f8
// Size: 0x2c
function onpickup(event) {
    scoreevents::processscoreevent(event, self, undefined, undefined);
}

// Namespace dogtags/dogtags
// Params 1, eflags: 0x1 linked
// Checksum 0x3c6a347f, Offset: 0x1630
// Size: 0x94
function clear_on_victim_disconnect(victim) {
    level endon(#"game_ended");
    guid = victim getentitynumber();
    victim waittill(#"disconnect");
    dogtag = function_afe6cbc4(victim);
    if (!isdefined(dogtag)) {
        return;
    }
    function_329adc0f(dogtag);
}

// Namespace dogtags/dogtags
// Params 0, eflags: 0x1 linked
// Checksum 0xa13312a, Offset: 0x16d0
// Size: 0xf2
function on_spawn_player() {
    if (!(isdefined(level.droppedtagrespawn) && level.droppedtagrespawn)) {
        return;
    }
    if (level.rankedmatch || level.leaguematch) {
        if (isdefined(self.tacticalinsertiontime) && self.tacticalinsertiontime + 100 > gettime()) {
            mindist = level.antiboostdistance;
            mindistsqr = mindist * mindist;
            dogtag = function_afe6cbc4(self);
            if (!isdefined(dogtag)) {
                return;
            }
            distsqr = distancesquared(self.origin, dogtag.curorigin);
            if (distsqr < mindistsqr) {
                dogtag.tacinsert = 1;
            }
        }
    }
}

// Namespace dogtags/dogtags
// Params 1, eflags: 0x1 linked
// Checksum 0x7faeb176, Offset: 0x17d0
// Size: 0xc4
function on_player_killed(*params) {
    self endon(#"disconnect");
    if (is_true(level.droppedtagrespawn) && squad_spawn::function_d072f205()) {
        self squad_spawn::function_5f976259();
        /#
            var_f26d6aa7 = getdvarint(#"hash_40b119703c5fa11e", 0);
            if (var_f26d6aa7 > 0) {
                wait var_f26d6aa7;
                self dt_respawn();
            }
        #/
    }
}

// Namespace dogtags/dogtags
// Params 1, eflags: 0x1 linked
// Checksum 0x279b3b8d, Offset: 0x18a0
// Size: 0x7a
function function_1d8e2a5b(activator) {
    if (isplayer(activator) && activator isinvehicle()) {
        vehicle = activator getvehicleoccupied();
    }
    if (!isdefined(vehicle)) {
        return 0;
    }
    return vehicle.settings.var_a6f70f60;
}

// Namespace dogtags/dogtags
// Params 1, eflags: 0x1 linked
// Checksum 0x25574c01, Offset: 0x1928
// Size: 0x78
function team_updater(tags) {
    level endon(#"game_ended");
    self endon(#"disconnect");
    while (true) {
        self waittill(#"joined_team");
        tags.victimteam = self.team;
        tags reset_tags();
    }
}

// Namespace dogtags/dogtags
// Params 1, eflags: 0x1 linked
// Checksum 0xb5734c2c, Offset: 0x19a8
// Size: 0xf4
function time_out(victim) {
    level endon(#"game_ended");
    victim endon(#"disconnect");
    self notify(#"timeout");
    self endon(#"timeout", #"death");
    timeout = isdefined(getgametypesetting("dogTagTimeOut")) ? getgametypesetting("dogTagTimeOut") : 0;
    level hostmigration::waitlongdurationwithhostmigrationpause(timeout);
    if (!isdefined(self)) {
        return;
    }
    self reset_tags();
}

// Namespace dogtags/dogtags
// Params 0, eflags: 0x0
// Checksum 0x132ac939, Offset: 0x1aa8
// Size: 0x34
function checkallowspectating() {
    self endon(#"disconnect");
    waitframe(1);
    spectating::update_settings();
}

// Namespace dogtags/dogtags
// Params 9, eflags: 0x1 linked
// Checksum 0x622f0144, Offset: 0x1ae8
// Size: 0x150
function should_spawn_tags(*einflictor, attacker, *idamage, *smeansofdeath, *weapon, *vdir, *shitloc, *psoffsettime, *deathanimduration) {
    if (isalive(self)) {
        return false;
    }
    if (isdefined(self.switching_teams)) {
        return false;
    }
    if (isdefined(deathanimduration) && deathanimduration == self) {
        return false;
    }
    if (level.teambased && isdefined(deathanimduration) && isdefined(deathanimduration.team) && deathanimduration.team == self.team) {
        return false;
    }
    if (isdefined(deathanimduration) && (!isdefined(deathanimduration.team) || deathanimduration.team == #"none") && (deathanimduration.classname == "trigger_hurt" || deathanimduration.classname == "worldspawn")) {
        return false;
    }
    return true;
}

// Namespace dogtags/dogtags
// Params 1, eflags: 0x0
// Checksum 0xc34a3009, Offset: 0x1c40
// Size: 0xc4
function onusedogtag(player) {
    if (player.pers[#"team"] == self.victimteam) {
        player.pers[#"rescues"]++;
        if (isdefined(self.victim)) {
            if (!level.gameended) {
                self.victim thread dt_respawn();
            }
        }
        return;
    }
    if (is_true(level.var_d0252074) && isdefined(self.victim)) {
        self.victim squad_spawn::function_44c6679();
    }
}

// Namespace dogtags/dogtags
// Params 0, eflags: 0x1 linked
// Checksum 0x863fd77e, Offset: 0x1d10
// Size: 0x84
function dt_respawn() {
    if (is_true(level.var_d0252074)) {
        self.pers[#"lives"] = 1;
        self squad_spawn::function_6a7e8977();
        self squad_spawn::function_250e04e5();
        return;
    }
    self thread waittillcanspawnclient();
}

// Namespace dogtags/dogtags
// Params 0, eflags: 0x1 linked
// Checksum 0x87b5082c, Offset: 0x1da0
// Size: 0x7a
function waittillcanspawnclient() {
    for (;;) {
        wait 0.05;
        if (isdefined(self) && (self.sessionstate == "spectator" || !isalive(self))) {
            self.pers[#"lives"] = 1;
            self thread [[ level.spawnclient ]]();
            continue;
        }
        return;
    }
}

