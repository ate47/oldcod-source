#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_stats;

#namespace namespace_a33fa77c;

// Namespace namespace_a33fa77c/namespace_a33fa77c
// Params 0, eflags: 0x0
// Checksum 0x73e70adf, Offset: 0xd8
// Size: 0x22
function init() {
    if (!isdefined(level.var_2547ba72)) {
        level.var_2547ba72 = 1;
    }
}

// Namespace namespace_a33fa77c/namespace_a33fa77c
// Params 2, eflags: 0x0
// Checksum 0xa6680f33, Offset: 0x108
// Size: 0x414
function on_spawn(watcher, player) {
    player endon(#"death");
    player endon(#"disconnect");
    player endon(#"hash_1fdb7e931333fd8b");
    level endon(#"game_ended");
    waitresult = self waittill(#"stationary");
    endpos = waitresult.position;
    normal = waitresult.normal;
    angles = waitresult.direction;
    attacker = waitresult.attacker;
    prey = waitresult.target;
    bone = waitresult.bone_name;
    isfriendly = 0;
    if (isdefined(endpos)) {
        retrievable_model = spawn("script_model", endpos);
        retrievable_model setmodel(#"hash_5728fcb777e42f5");
        retrievable_model setowner(player);
        retrievable_model.owner = player;
        retrievable_model.angles = angles;
        retrievable_model.weapon = watcher.weapon;
        if (isdefined(prey)) {
            if (isplayer(prey) && player.team == prey.team) {
                isfriendly = 1;
            } else if (isai(prey) && player.team == prey.team) {
                isfriendly = 1;
            }
            if (!isfriendly) {
                retrievable_model linkto(prey, bone);
                retrievable_model thread function_ae011034(player, prey);
            } else if (isfriendly) {
                retrievable_model physicslaunch(normal, (randomint(10), randomint(10), randomint(10)));
                normal = (0, 0, 1);
            }
        }
        watcher.objectarray[watcher.objectarray.size] = retrievable_model;
        if (isfriendly) {
            retrievable_model waittill(#"stationary");
        }
        retrievable_model thread function_c6372501(player);
        if (isfriendly) {
            player notify(#"ballistic_knife_stationary", {#retrievable_model:retrievable_model, #normal:normal});
        } else {
            player notify(#"ballistic_knife_stationary", {#retrievable_model:retrievable_model, #normal:normal, #target:prey});
        }
        retrievable_model thread function_9830e7bc(prey);
    }
}

// Namespace namespace_a33fa77c/namespace_a33fa77c
// Params 1, eflags: 0x0
// Checksum 0xff86add8, Offset: 0x528
// Size: 0x5c
function function_9830e7bc(prey) {
    level endon(#"game_ended");
    self endon(#"death");
    wait 2;
    self setmodel(#"hash_5728fcb777e42f5");
}

// Namespace namespace_a33fa77c/namespace_a33fa77c
// Params 2, eflags: 0x0
// Checksum 0x9f8a0d7d, Offset: 0x590
// Size: 0x4ac
function on_spawn_retrieve_trigger(watcher, player) {
    player endon(#"death");
    player endon(#"disconnect");
    player endon(#"hash_1fdb7e931333fd8b");
    level endon(#"game_ended");
    waitresult = player waittill(#"ballistic_knife_stationary");
    retrievable_model = waitresult.retrievable_model;
    normal = retrievable_model.normal;
    prey = retrievable_model.target;
    if (!isdefined(retrievable_model)) {
        return;
    }
    trigger_pos = [];
    if (isdefined(prey) && (isplayer(prey) || isai(prey))) {
        trigger_pos[0] = prey.origin[0];
        trigger_pos[1] = prey.origin[1];
        trigger_pos[2] = prey.origin[2] + 10;
    } else {
        trigger_pos[0] = retrievable_model.origin[0] + 10 * normal[0];
        trigger_pos[1] = retrievable_model.origin[1] + 10 * normal[1];
        trigger_pos[2] = retrievable_model.origin[2] + 10 * normal[2];
    }
    if (isdefined(level.var_2547ba72) && level.var_2547ba72) {
        trigger_pos[2] = trigger_pos[2] - 50;
        var_9dbe9414 = spawn("trigger_radius", (trigger_pos[0], trigger_pos[1], trigger_pos[2]), 0, 50, 100);
    } else {
        var_9dbe9414 = spawn("trigger_radius_use", (trigger_pos[0], trigger_pos[1], trigger_pos[2]));
        var_9dbe9414 setcursorhint("HINT_NOICON");
    }
    var_9dbe9414.owner = player;
    retrievable_model.var_a7c7bd14 = var_9dbe9414;
    hint_string = #"hash_3d0eb6f03a816e08";
    if (isdefined(hint_string)) {
        var_9dbe9414 sethintstring(hint_string);
    } else {
        var_9dbe9414 sethintstring(#"generic_pickup");
    }
    var_9dbe9414 setteamfortrigger(player.team);
    player clientclaimtrigger(var_9dbe9414);
    var_9dbe9414 enablelinkto();
    if (isdefined(prey)) {
        var_9dbe9414 linkto(prey);
    } else {
        var_9dbe9414 linkto(retrievable_model);
    }
    if (isdefined(level.var_b33b8405)) {
        [[ level.var_b33b8405 ]](retrievable_model, var_9dbe9414, prey);
    }
    retrievable_model thread function_35579833(var_9dbe9414, retrievable_model, &pick_up, watcher.weapon, watcher.pickupsoundplayer, watcher.pickupsound);
    player thread watch_shutdown(var_9dbe9414, retrievable_model);
}

/#

    // Namespace namespace_a33fa77c/namespace_a33fa77c
    // Params 1, eflags: 0x0
    // Checksum 0xa5159dfc, Offset: 0xa48
    // Size: 0x4e
    function debug_print(endpos) {
        self endon(#"death");
        while (true) {
            print3d(endpos, "<dev string:x30>");
            waitframe(1);
        }
    }

#/

// Namespace namespace_a33fa77c/namespace_a33fa77c
// Params 6, eflags: 0x0
// Checksum 0xff4fb701, Offset: 0xaa0
// Size: 0x34e
function function_35579833(trigger, model, callback, weapon, playersoundonuse, npcsoundonuse) {
    self endon(#"death");
    self endon(#"delete");
    level endon(#"game_ended");
    max_ammo = weapon.maxammo + 1;
    var_462338e8 = isdefined(level.var_2547ba72) && level.var_2547ba72;
    while (true) {
        waitresult = trigger waittill(#"trigger");
        player = waitresult.activator;
        if (!isalive(player)) {
            continue;
        }
        if (!player isonground() && !(isdefined(trigger.var_de9cafd) && trigger.var_de9cafd)) {
            continue;
        }
        if (isdefined(trigger.triggerteam) && player.team != trigger.triggerteam) {
            continue;
        }
        if (isdefined(trigger.claimedby) && player != trigger.claimedby) {
            continue;
        }
        ammo_stock = player getweaponammostock(weapon);
        ammo_clip = player getweaponammoclip(weapon);
        current_weapon = player getcurrentweapon();
        total_ammo = ammo_stock + ammo_clip;
        var_34eba11f = 1;
        if (total_ammo > 0 && ammo_stock == total_ammo && current_weapon == weapon) {
            var_34eba11f = 0;
        }
        if (total_ammo >= max_ammo || !var_34eba11f) {
            continue;
        }
        if (var_462338e8 || player usebuttonpressed() && !player.throwinggrenade && !player meleebuttonpressed() || isdefined(trigger.var_de9cafd) && trigger.var_de9cafd) {
            if (isdefined(playersoundonuse)) {
                player playlocalsound(playersoundonuse);
            }
            if (isdefined(npcsoundonuse)) {
                player playsound(npcsoundonuse);
            }
            player thread [[ callback ]](weapon, model, trigger);
            break;
        }
    }
}

// Namespace namespace_a33fa77c/namespace_a33fa77c
// Params 3, eflags: 0x0
// Checksum 0x99e644c2, Offset: 0xdf8
// Size: 0x194
function pick_up(weapon, model, trigger) {
    if (self hasweapon(weapon)) {
        current_weapon = self getcurrentweapon();
        if (current_weapon != weapon) {
            clip_ammo = self getweaponammoclip(weapon);
            if (!clip_ammo) {
                self setweaponammoclip(weapon, 1);
            } else {
                var_e728627d = self getweaponammostock(weapon) + 1;
                self setweaponammostock(weapon, var_e728627d);
            }
        } else {
            var_e728627d = self getweaponammostock(weapon) + 1;
            self setweaponammostock(weapon, var_e728627d);
        }
    }
    self zm_stats::increment_client_stat("ballistic_knives_pickedup");
    self zm_stats::increment_player_stat("ballistic_knives_pickedup");
    model destroy_ent();
    trigger destroy_ent();
}

// Namespace namespace_a33fa77c/namespace_a33fa77c
// Params 0, eflags: 0x0
// Checksum 0xcbd909b1, Offset: 0xf98
// Size: 0x4c
function destroy_ent() {
    if (isdefined(self)) {
        if (isdefined(self.var_ceaf3848)) {
            self.var_ceaf3848 delete();
        }
        self delete();
    }
}

// Namespace namespace_a33fa77c/namespace_a33fa77c
// Params 2, eflags: 0x0
// Checksum 0xd8c42cdd, Offset: 0xff0
// Size: 0x74
function watch_shutdown(trigger, model) {
    self waittill(#"death", #"disconnect", #"hash_1fdb7e931333fd8b");
    trigger destroy_ent();
    model destroy_ent();
}

// Namespace namespace_a33fa77c/namespace_a33fa77c
// Params 1, eflags: 0x0
// Checksum 0x542e3f26, Offset: 0x1070
// Size: 0xf8
function function_c6372501(player) {
    player endon(#"death");
    player endon(#"hash_1fdb7e931333fd8b");
    for (;;) {
        waitresult = level waittill(#"drop_objects_to_ground");
        origin = waitresult.position;
        radius = waitresult.radius;
        if (distancesquared(origin, self.origin) < radius * radius) {
            self physicslaunch((0, 0, 1), (5, 5, 5));
            self thread function_963df1d8(player);
        }
    }
}

// Namespace namespace_a33fa77c/namespace_a33fa77c
// Params 2, eflags: 0x0
// Checksum 0xbbda9de2, Offset: 0x1170
// Size: 0xac
function function_ae011034(player, prey) {
    self endon(#"death");
    player endon(#"hash_1fdb7e931333fd8b");
    prey waittill(#"death");
    self unlink();
    self physicslaunch((0, 0, 1), (5, 5, 5));
    self thread function_963df1d8(player);
}

// Namespace namespace_a33fa77c/namespace_a33fa77c
// Params 1, eflags: 0x0
// Checksum 0x682116dc, Offset: 0x1228
// Size: 0xd4
function function_963df1d8(player) {
    self endon(#"death");
    player endon(#"hash_1fdb7e931333fd8b");
    if (isdefined(level.var_b7b04aa6)) {
        self [[ level.var_b7b04aa6 ]](player);
        return;
    }
    self waittill(#"stationary");
    trigger = self.var_a7c7bd14;
    trigger.origin = (self.origin[0], self.origin[1], self.origin[2] + 10);
    trigger linkto(self);
}

