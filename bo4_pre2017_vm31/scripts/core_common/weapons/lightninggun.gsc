#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/killcam_shared;
#using scripts/core_common/player_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/visionset_mgr_shared;
#using scripts/core_common/weapons/weaponobjects;

#namespace lightninggun;

// Namespace lightninggun/lightninggun
// Params 0, eflags: 0x0
// Checksum 0xced8c619, Offset: 0x3a8
// Size: 0x1dc
function init_shared() {
    level.weaponlightninggun = getweapon("hero_lightninggun");
    level.weaponlightninggunarc = getweapon("hero_lightninggun_arc");
    level.weaponlightninggunkillcamtime = getdvarfloat("scr_lightningGunKillcamTime", 0.35);
    level.weaponlightninggunkillcamdecelpercent = getdvarfloat("scr_lightningGunKillcamDecelPercent", 0.25);
    level.weaponlightninggunkillcamoffset = getdvarfloat("scr_lightningGunKillcamOffset", 150);
    level.lightninggun_arc_range = 300;
    level.lightninggun_arc_range_sq = level.lightninggun_arc_range * level.lightninggun_arc_range;
    level.lightninggun_arc_speed = 650;
    level.lightninggun_arc_speed_sq = level.lightninggun_arc_speed * level.lightninggun_arc_speed;
    level.lightninggun_arc_fx_min_range = 1;
    level.lightninggun_arc_fx_min_range_sq = level.lightninggun_arc_fx_min_range * level.lightninggun_arc_fx_min_range;
    level._effect["lightninggun_arc"] = "weapon/fx_lightninggun_arc";
    callback::add_weapon_damage(level.weaponlightninggun, &on_damage_lightninggun);
    /#
        level thread update_dvars();
    #/
}

/#

    // Namespace lightninggun/lightninggun
    // Params 0, eflags: 0x0
    // Checksum 0xbb3aeab5, Offset: 0x590
    // Size: 0xa4
    function update_dvars() {
        while (true) {
            wait 1;
            level.weaponlightninggunkillcamtime = getdvarfloat("<dev string:x28>", 0.35);
            level.weaponlightninggunkillcamdecelpercent = getdvarfloat("<dev string:x44>", 0.25);
            level.weaponlightninggunkillcamoffset = getdvarfloat("<dev string:x68>", 150);
        }
    }

#/

// Namespace lightninggun/lightninggun
// Params 1, eflags: 0x0
// Checksum 0xef0eac17, Offset: 0x640
// Size: 0xac
function lightninggun_start_damage_effects(eattacker) {
    self endon(#"disconnect");
    /#
        if (isgodmode(self)) {
            return;
        }
    #/
    self setelectrifiedstate(1);
    self.electrifiedby = eattacker;
    self playrumbleonentity("lightninggun_victim");
    wait 2;
    self.electrifiedby = undefined;
    self setelectrifiedstate(0);
}

// Namespace lightninggun/lightninggun
// Params 5, eflags: 0x0
// Checksum 0xf0324e4c, Offset: 0x6f8
// Size: 0xbc
function lightninggun_arc_killcam(arc_source_pos, arc_target, arc_target_pos, original_killcam_ent, waittime) {
    arc_target.killcamkilledbyent = create_killcam_entity(original_killcam_ent.origin, original_killcam_ent.angles, level.weaponlightninggunarc);
    arc_target.killcamkilledbyent killcam::store_killcam_entity_on_entity(original_killcam_ent);
    arc_target.killcamkilledbyent killcam_move(arc_source_pos, arc_target_pos, waittime);
}

// Namespace lightninggun/lightninggun
// Params 5, eflags: 0x0
// Checksum 0x4f67dac, Offset: 0x7c0
// Size: 0x292
function lightninggun_arc_fx(arc_source_pos, arc_target, arc_target_pos, distancesq, original_killcam_ent) {
    if (!isdefined(arc_target) || !isdefined(original_killcam_ent)) {
        return;
    }
    waittime = 0.25;
    if (level.lightninggun_arc_speed_sq > 100 && distancesq > 1) {
        waittime = distancesq / level.lightninggun_arc_speed_sq;
    }
    lightninggun_arc_killcam(arc_source_pos, arc_target, arc_target_pos, original_killcam_ent, waittime);
    killcamentity = arc_target.killcamkilledbyent;
    if (!isdefined(arc_target) || !isdefined(original_killcam_ent)) {
        return;
    }
    if (distancesq < level.lightninggun_arc_fx_min_range_sq) {
        wait waittime;
        killcamentity delete();
        if (isdefined(arc_target)) {
            arc_target.killcamkilledbyent = undefined;
        }
        return;
    }
    fxorg = spawn("script_model", arc_source_pos);
    fxorg setmodel("tag_origin");
    fx = playfxontag(level._effect["lightninggun_arc"], fxorg, "tag_origin");
    playsoundatposition("wpn_lightning_gun_bounce", fxorg.origin);
    fxorg moveto(arc_target_pos, waittime);
    fxorg waittill("movedone");
    util::wait_network_frame();
    util::wait_network_frame();
    util::wait_network_frame();
    fxorg delete();
    killcamentity delete();
    if (isdefined(arc_target)) {
        arc_target.killcamkilledbyent = undefined;
    }
}

// Namespace lightninggun/lightninggun
// Params 8, eflags: 0x0
// Checksum 0x32befdc6, Offset: 0xa60
// Size: 0x14c
function lightninggun_arc(delay, eattacker, arc_source, arc_source_origin, arc_source_pos, arc_target, arc_target_pos, distancesq) {
    if (delay) {
        wait delay;
        if (!isdefined(arc_target) || !isalive(arc_target)) {
            return;
        }
        distancesq = distancesquared(arc_target.origin, arc_source_origin);
        if (distancesq > level.lightninggun_arc_range_sq) {
            return;
        }
    }
    level thread lightninggun_arc_fx(arc_source_pos, arc_target, arc_target_pos, distancesq, arc_source.killcamkilledbyent);
    arc_target thread lightninggun_start_damage_effects(eattacker);
    arc_target dodamage(arc_target.health, arc_source_pos, eattacker, arc_source, "none", "MOD_PISTOL_BULLET", 0, level.weaponlightninggunarc);
}

// Namespace lightninggun/lightninggun
// Params 4, eflags: 0x0
// Checksum 0xb39b94dc, Offset: 0xbb8
// Size: 0x234
function lightninggun_find_arc_targets(eattacker, arc_source, arc_source_origin, arc_source_pos) {
    delay = 0.05;
    allenemyaliveplayers = util::function_a791434c(eattacker.team);
    closestplayers = arraysort(allenemyaliveplayers.a, arc_source_origin, 1);
    foreach (player in closestplayers) {
        if (isdefined(arc_source) && player == arc_source) {
            continue;
        }
        if (player player::is_spawn_protected()) {
            continue;
        }
        distancesq = distancesquared(player.origin, arc_source_origin);
        if (distancesq > level.lightninggun_arc_range_sq) {
            break;
        }
        if (eattacker != player && weaponobjects::friendlyfirecheck(eattacker, player)) {
            if (isdefined(self) && !player damageconetrace(arc_source_pos, self)) {
                continue;
            }
            level thread lightninggun_arc(delay, eattacker, arc_source, arc_source_origin, arc_source_pos, player, player gettagorigin("j_spineupper"), distancesq);
            delay += 0.05;
        }
    }
}

// Namespace lightninggun/lightninggun
// Params 3, eflags: 0x0
// Checksum 0xe4bc12c4, Offset: 0xdf8
// Size: 0x98
function create_killcam_entity(origin, angles, weapon) {
    killcamkilledbyent = spawn("script_model", origin);
    killcamkilledbyent setmodel("tag_origin");
    killcamkilledbyent.angles = angles;
    killcamkilledbyent setweapon(weapon);
    return killcamkilledbyent;
}

// Namespace lightninggun/lightninggun
// Params 3, eflags: 0x0
// Checksum 0x9d52a0eb, Offset: 0xe98
// Size: 0x150
function killcam_move(start_origin, end_origin, time) {
    delta = end_origin - start_origin;
    dist = length(delta);
    delta = vectornormalize(delta);
    move_to_dist = dist - level.weaponlightninggunkillcamoffset;
    end_angles = (0, 0, 0);
    if (move_to_dist > 0) {
        move_to_pos = start_origin + delta * move_to_dist;
        self moveto(move_to_pos, time, 0, time * level.weaponlightninggunkillcamdecelpercent);
        end_angles = vectortoangles(delta);
        return;
    }
    delta = end_origin - self.origin;
    end_angles = vectortoangles(delta);
}

// Namespace lightninggun/lightninggun
// Params 5, eflags: 0x0
// Checksum 0xc5c797a1, Offset: 0xff0
// Size: 0x25a
function lightninggun_damage_response(eattacker, einflictor, weapon, meansofdeath, damage) {
    source_pos = eattacker.origin;
    bolt_source_pos = eattacker gettagorigin("tag_flash");
    arc_source = self;
    arc_source_origin = self.origin;
    arc_source_pos = self gettagorigin("j_spineupper");
    delta = arc_source_pos - bolt_source_pos;
    angles = (0, 0, 0);
    arc_source.killcamkilledbyent = create_killcam_entity(bolt_source_pos, angles, weapon);
    arc_source.killcamkilledbyent killcam_move(bolt_source_pos, arc_source_pos, level.weaponlightninggunkillcamtime);
    killcamentity = arc_source.killcamkilledbyent;
    self thread lightninggun_start_damage_effects(eattacker);
    wait 2;
    if (!isdefined(self)) {
        self thread lightninggun_find_arc_targets(eattacker, undefined, arc_source_origin, arc_source_pos);
        return;
    }
    if (isdefined(self.body)) {
        arc_source_origin = self.body.origin;
        arc_source_pos = self.body gettagorigin("j_spineupper");
    }
    self thread lightninggun_find_arc_targets(eattacker, arc_source, arc_source_origin, arc_source_pos);
    wait 0.45;
    killcamentity delete();
    if (isdefined(arc_source)) {
        arc_source.killcamkilledbyent = undefined;
    }
}

// Namespace lightninggun/lightninggun
// Params 5, eflags: 0x0
// Checksum 0xc81eb58d, Offset: 0x1258
// Size: 0x74
function on_damage_lightninggun(eattacker, einflictor, weapon, meansofdeath, damage) {
    if ("MOD_PISTOL_BULLET" != meansofdeath && "MOD_HEAD_SHOT" != meansofdeath) {
        return;
    }
    self thread lightninggun_damage_response(eattacker, einflictor, weapon, meansofdeath, damage);
}

