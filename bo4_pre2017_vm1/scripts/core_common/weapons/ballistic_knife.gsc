#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/weapons/weaponobjects;

#namespace ballistic_knife;

// Namespace ballistic_knife/ballistic_knife
// Params 0, eflags: 0x0
// Checksum 0xa9b5faa2, Offset: 0x230
// Size: 0x24
function init_shared() {
    callback::add_weapon_watcher(&createballisticknifewatcher);
}

// Namespace ballistic_knife/ballistic_knife
// Params 2, eflags: 0x0
// Checksum 0x923dd210, Offset: 0x260
// Size: 0x3cc
function onspawn(watcher, player) {
    player endon(#"death", #"disconnect");
    level endon(#"game_ended");
    waitresult = self waittill("stationary");
    endpos = waitresult.position;
    normal = waitresult.normal;
    angles = waitresult.direction;
    attacker = waitresult.attacker;
    prey = waitresult.target;
    bone = waitresult.bone_name;
    isfriendly = 0;
    if (isdefined(endpos)) {
        retrievable_model = spawn("script_model", endpos);
        retrievable_model setmodel("t6_wpn_ballistic_knife_projectile");
        retrievable_model setteam(player.team);
        retrievable_model setowner(player);
        retrievable_model.owner = player;
        retrievable_model.angles = angles;
        retrievable_model.name = watcher.weapon;
        retrievable_model.targetname = "sticky_weapon";
        if (isdefined(prey)) {
            if (level.teambased && player.team == prey.team) {
                isfriendly = 1;
            }
            if (!isfriendly) {
                if (isalive(prey)) {
                    retrievable_model droptoground(retrievable_model.origin, 80);
                } else {
                    retrievable_model linkto(prey, bone);
                }
            } else if (isfriendly) {
                retrievable_model physicslaunch(normal, (randomint(10), randomint(10), randomint(10)));
                normal = (0, 0, 1);
            }
        }
        watcher.objectarray[watcher.objectarray.size] = retrievable_model;
        if (isfriendly) {
            retrievable_model waittill("stationary");
        }
        retrievable_model thread dropknivestoground();
        if (isfriendly) {
            player notify(#"ballistic_knife_stationary", {#retrievable_model:retrievable_model, #normal:normal});
            return;
        }
        player notify(#"ballistic_knife_stationary", {#retrievable_model:retrievable_model, #normal:normal, #target:prey});
    }
}

// Namespace ballistic_knife/ballistic_knife
// Params 0, eflags: 0x0
// Checksum 0x281d27f9, Offset: 0x638
// Size: 0x4c
function watch_shutdown() {
    pickuptrigger = self.pickuptrigger;
    self waittill("death");
    if (isdefined(pickuptrigger)) {
        pickuptrigger delete();
    }
}

// Namespace ballistic_knife/ballistic_knife
// Params 2, eflags: 0x0
// Checksum 0x9eaca7d2, Offset: 0x690
// Size: 0x374
function onspawnretrievetrigger(watcher, player) {
    player endon(#"death");
    player endon(#"disconnect");
    level endon(#"game_ended");
    waitresult = player waittill("ballistic_knife_stationary");
    retrievable_model = waitresult.retrievable_model;
    normal = retrievable_model.normal;
    prey = retrievable_model.target;
    if (!isdefined(retrievable_model)) {
        return;
    }
    vec_scale = 10;
    trigger_pos = [];
    if (isplayer(prey) || isdefined(prey) && isai(prey)) {
        trigger_pos[0] = prey.origin[0];
        trigger_pos[1] = prey.origin[1];
        trigger_pos[2] = prey.origin[2] + vec_scale;
    } else {
        trigger_pos[0] = retrievable_model.origin[0] + vec_scale * normal[0];
        trigger_pos[1] = retrievable_model.origin[1] + vec_scale * normal[1];
        trigger_pos[2] = retrievable_model.origin[2] + vec_scale * normal[2];
    }
    trigger_pos[2] = trigger_pos[2] - 50;
    retrievable_model clientfield::set("retrievable", 1);
    var_9dbe9414 = spawn("trigger_radius", (trigger_pos[0], trigger_pos[1], trigger_pos[2]), 0, 50, 100);
    var_9dbe9414.owner = player;
    retrievable_model.pickuptrigger = var_9dbe9414;
    var_9dbe9414 enablelinkto();
    if (isdefined(prey)) {
        var_9dbe9414 linkto(prey);
    } else {
        var_9dbe9414 linkto(retrievable_model);
    }
    retrievable_model thread function_35579833(var_9dbe9414, retrievable_model, &pick_up, watcher.pickupsoundplayer, watcher.pickupsound);
    retrievable_model thread watch_shutdown();
}

// Namespace ballistic_knife/ballistic_knife
// Params 5, eflags: 0x0
// Checksum 0xc8cc6389, Offset: 0xa10
// Size: 0x2ee
function function_35579833(trigger, model, callback, playersoundonuse, npcsoundonuse) {
    self endon(#"death");
    self endon(#"delete");
    level endon(#"game_ended");
    max_ammo = level.weaponballisticknife.maxammo + 1;
    while (true) {
        waitresult = trigger waittill("trigger");
        player = waitresult.activator;
        if (!isalive(player)) {
            continue;
        }
        if (!player isonground()) {
            continue;
        }
        if (isdefined(trigger.triggerteam) && player.team != trigger.triggerteam) {
            continue;
        }
        if (isdefined(trigger.claimedby) && player != trigger.claimedby) {
            continue;
        }
        if (!player hasweapon(level.weaponballisticknife)) {
            continue;
        }
        ammo_stock = player getweaponammostock(level.weaponballisticknife);
        ammo_clip = player getweaponammoclip(level.weaponballisticknife);
        current_weapon = player getcurrentweapon();
        total_ammo = ammo_stock + ammo_clip;
        var_34eba11f = 1;
        if (total_ammo > 0 && ammo_stock == total_ammo && current_weapon == level.weaponballisticknife) {
            var_34eba11f = 0;
        }
        if (total_ammo >= max_ammo || !var_34eba11f) {
            continue;
        }
        if (isdefined(playersoundonuse)) {
            player playlocalsound(playersoundonuse);
        }
        if (isdefined(npcsoundonuse)) {
            player playsound(npcsoundonuse);
        }
        self thread [[ callback ]](player);
        break;
    }
}

// Namespace ballistic_knife/ballistic_knife
// Params 1, eflags: 0x0
// Checksum 0xe8a2c57, Offset: 0xd08
// Size: 0x184
function pick_up(player) {
    self destroy_ent();
    current_weapon = player getcurrentweapon();
    player challenges::pickedupballisticknife();
    if (current_weapon != level.weaponballisticknife) {
        clip_ammo = player getweaponammoclip(level.weaponballisticknife);
        if (!clip_ammo) {
            player setweaponammoclip(level.weaponballisticknife, 1);
        } else {
            var_e728627d = player getweaponammostock(level.weaponballisticknife) + 1;
            player setweaponammostock(level.weaponballisticknife, var_e728627d);
        }
        return;
    }
    var_e728627d = player getweaponammostock(level.weaponballisticknife) + 1;
    player setweaponammostock(level.weaponballisticknife, var_e728627d);
}

// Namespace ballistic_knife/ballistic_knife
// Params 0, eflags: 0x0
// Checksum 0x4d75e3e3, Offset: 0xe98
// Size: 0x5c
function destroy_ent() {
    if (isdefined(self)) {
        pickuptrigger = self.pickuptrigger;
        if (isdefined(pickuptrigger)) {
            pickuptrigger delete();
        }
        self delete();
    }
}

// Namespace ballistic_knife/ballistic_knife
// Params 0, eflags: 0x0
// Checksum 0x4f03735c, Offset: 0xf00
// Size: 0x60
function dropknivestoground() {
    self endon(#"death");
    for (;;) {
        waitresult = level waittill("drop_objects_to_ground");
        self droptoground(waitresult.position, waitresult.radius);
    }
}

// Namespace ballistic_knife/ballistic_knife
// Params 2, eflags: 0x0
// Checksum 0x8a9da168, Offset: 0xf68
// Size: 0x7c
function droptoground(origin, radius) {
    if (distancesquared(origin, self.origin) < radius * radius) {
        self physicslaunch((0, 0, 1), (5, 5, 5));
        self thread updateretrievetrigger();
    }
}

// Namespace ballistic_knife/ballistic_knife
// Params 0, eflags: 0x0
// Checksum 0x9528e42e, Offset: 0xff0
// Size: 0x8c
function updateretrievetrigger() {
    self endon(#"death");
    self waittill("stationary");
    trigger = self.pickuptrigger;
    trigger.origin = (self.origin[0], self.origin[1], self.origin[2] + 10);
    trigger linkto(self);
}

// Namespace ballistic_knife/ballistic_knife
// Params 0, eflags: 0x0
// Checksum 0x7f9291ac, Offset: 0x1088
// Size: 0x94
function createballisticknifewatcher() {
    watcher = self weaponobjects::createuseweaponobjectwatcher("knife_ballistic", self.team);
    watcher.onspawn = &onspawn;
    watcher.ondetonatecallback = &weaponobjects::deleteent;
    watcher.onspawnretrievetriggers = &onspawnretrievetrigger;
    watcher.storedifferentobject = 1;
}

