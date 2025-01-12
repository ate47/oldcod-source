#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/damagefeedback_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/sound_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/tacticalinsertion;
#using scripts/core_common/weapons/weaponobjects;

#namespace smokegrenade;

// Namespace smokegrenade/smokegrenade
// Params 0, eflags: 0x0
// Checksum 0x168aa8b, Offset: 0x2d8
// Size: 0xac
function init_shared() {
    level.willypetedamageradius = 300;
    level.willypetedamageheight = 128;
    level.smokegrenadeduration = 8;
    level.smokegrenadedissipation = 4;
    level.smokegrenadetotaltime = level.smokegrenadeduration + level.smokegrenadedissipation;
    level.fx_smokegrenade_single = "smoke_center";
    level.smoke_grenade_triggers = [];
    callback::on_spawned(&on_player_spawned);
}

// Namespace smokegrenade/smokegrenade
// Params 5, eflags: 0x0
// Checksum 0x28b956c, Offset: 0x390
// Size: 0x154
function watchsmokegrenadedetonation(owner, statweapon, grenadeweaponname, duration, totaltime) {
    self endon(#"trophy_destroyed");
    if (isplayer(owner)) {
        owner addweaponstat(statweapon, "used", 1);
    }
    waitresult = self waittill("explode");
    onefoot = (0, 0, 12);
    startpos = waitresult.position + onefoot;
    smokeweapon = getweapon(grenadeweaponname);
    smokedetonate(owner, statweapon, smokeweapon, waitresult.position, 128, totaltime, duration);
    damageeffectarea(owner, startpos, smokeweapon.explosionradius, level.willypetedamageheight, undefined);
}

// Namespace smokegrenade/smokegrenade
// Params 7, eflags: 0x0
// Checksum 0xf5c0d1ab, Offset: 0x4f0
// Size: 0x180
function smokedetonate(owner, statweapon, smokeweapon, position, radius, effectlifetime, smokeblockduration) {
    dir_up = (0, 0, 1);
    ent = spawntimedfx(smokeweapon, position, dir_up, effectlifetime);
    ent setteam(owner.team);
    if (isplayer(owner)) {
        ent setowner(owner);
    }
    ent thread smokeblocksight(radius);
    ent thread spawnsmokegrenadetrigger(smokeblockduration);
    if (isdefined(owner)) {
        owner.smokegrenadetime = gettime();
        owner.smokegrenadeposition = position;
    }
    thread playsmokesound(position, smokeblockduration, statweapon.projsmokestartsound, statweapon.projsmokeendsound, statweapon.projsmokeloopsound);
    return ent;
}

// Namespace smokegrenade/smokegrenade
// Params 5, eflags: 0x0
// Checksum 0x46d90fa0, Offset: 0x678
// Size: 0xa4
function damageeffectarea(owner, position, radius, height, killcament) {
    effectarea = spawn("trigger_radius", position, 0, radius, height);
    if (isdefined(level.dogsonflashdogs)) {
        owner thread [[ level.dogsonflashdogs ]](effectarea);
    }
    effectarea delete();
}

// Namespace smokegrenade/smokegrenade
// Params 1, eflags: 0x0
// Checksum 0x541184b0, Offset: 0x728
// Size: 0xa0
function smokeblocksight(radius) {
    self endon(#"death");
    while (true) {
        fxblocksight(self, radius);
        /#
            if (getdvarint("<dev string:x28>", 0)) {
                sphere(self.origin, 128, (1, 0, 0), 0.25, 0, 10, 15);
            }
        #/
        wait 0.75;
    }
}

// Namespace smokegrenade/smokegrenade
// Params 1, eflags: 0x0
// Checksum 0xd3d39adb, Offset: 0x7d0
// Size: 0x13c
function spawnsmokegrenadetrigger(duration) {
    team = self.team;
    trigger = spawn("trigger_radius", self.origin, 0, 128, 128);
    if (!isdefined(level.smoke_grenade_triggers)) {
        level.smoke_grenade_triggers = [];
    } else if (!isarray(level.smoke_grenade_triggers)) {
        level.smoke_grenade_triggers = array(level.smoke_grenade_triggers);
    }
    level.smoke_grenade_triggers[level.smoke_grenade_triggers.size] = trigger;
    self waittilltimeout(duration, "death");
    arrayremovevalue(level.smoke_grenade_triggers, trigger);
    trigger delete();
}

// Namespace smokegrenade/smokegrenade
// Params 0, eflags: 0x0
// Checksum 0x513fdf11, Offset: 0x918
// Size: 0x9c
function isinsmokegrenade() {
    foreach (trigger in level.smoke_grenade_triggers) {
        if (self istouching(trigger)) {
            return true;
        }
    }
    return false;
}

// Namespace smokegrenade/smokegrenade
// Params 0, eflags: 0x0
// Checksum 0x14a0e2ae, Offset: 0x9c0
// Size: 0x24
function on_player_spawned() {
    self endon(#"disconnect");
    self thread begin_other_grenade_tracking();
}

// Namespace smokegrenade/smokegrenade
// Params 0, eflags: 0x0
// Checksum 0x3de3b91e, Offset: 0x9f0
// Size: 0x168
function begin_other_grenade_tracking() {
    self endon(#"death");
    self endon(#"disconnect");
    self notify(#"hash_a852d5c9");
    self endon(#"hash_a852d5c9");
    weapon_smoke = getweapon("willy_pete");
    var_f4e23c23 = getweapon("willy_pete_l2");
    for (;;) {
        waitresult = self waittill("grenade_fire");
        grenade = waitresult.projectile;
        weapon = waitresult.weapon;
        if (grenade util::ishacked()) {
            continue;
        }
        if (weapon.rootweapon == weapon_smoke || weapon.rootweapon == var_f4e23c23) {
            grenade thread watchsmokegrenadedetonation(self, weapon_smoke, level.fx_smokegrenade_single, level.smokegrenadeduration, level.smokegrenadetotaltime);
        }
    }
}

// Namespace smokegrenade/smokegrenade
// Params 5, eflags: 0x0
// Checksum 0xbd7e7498, Offset: 0xb60
// Size: 0x13c
function playsmokesound(position, duration, startsound, stopsound, loopsound) {
    smokesound = spawn("script_origin", (0, 0, 1));
    smokesound.origin = position;
    if (isdefined(startsound)) {
        smokesound playsound(startsound);
    }
    if (isdefined(loopsound)) {
        smokesound playloopsound(loopsound);
    }
    if (duration > 0.5) {
        wait duration - 0.5;
    }
    if (isdefined(stopsound)) {
        thread sound::play_in_space(stopsound, position);
    }
    smokesound stoploopsound(0.5);
    wait 0.5;
    smokesound delete();
}

