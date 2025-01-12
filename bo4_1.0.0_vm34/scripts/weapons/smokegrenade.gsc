#using scripts\core_common\player\player_stats;
#using scripts\core_common\sound_shared;
#using scripts\core_common\util_shared;

#namespace smokegrenade;

// Namespace smokegrenade/smokegrenade
// Params 0, eflags: 0x0
// Checksum 0x9c1b6a4a, Offset: 0xb8
// Size: 0x7e
function init_shared() {
    level.willypetedamageradius = 300;
    level.willypetedamageheight = 128;
    level.smokegrenadeduration = 8;
    level.smokegrenadedissipation = 4;
    level.smokegrenadetotaltime = level.smokegrenadeduration + level.smokegrenadedissipation;
    level.fx_smokegrenade_single = "smoke_center";
    level.smoke_grenade_triggers = [];
}

// Namespace smokegrenade/smokegrenade
// Params 5, eflags: 0x0
// Checksum 0xf89730a, Offset: 0x140
// Size: 0x164
function watchsmokegrenadedetonation(owner, statweapon, smokeweapon, duration, totaltime) {
    self endon(#"trophy_destroyed");
    if (isplayer(owner)) {
        owner stats::function_4f10b697(statweapon, #"used", 1);
    }
    waitresult = self waittill(#"explode", #"death");
    if (waitresult._notify != "explode") {
        return;
    }
    onefoot = (0, 0, 12);
    startpos = waitresult.position + onefoot;
    smokedetonate(owner, statweapon, smokeweapon, waitresult.position, 128, totaltime, duration);
    damageeffectarea(owner, startpos, smokeweapon.explosionradius, level.willypetedamageheight);
}

// Namespace smokegrenade/smokegrenade
// Params 7, eflags: 0x0
// Checksum 0x6ee0c3b9, Offset: 0x2b0
// Size: 0x160
function smokedetonate(owner, statweapon, smokeweapon, position, radius, effectlifetime, smokeblockduration) {
    dir_up = (0, 0, 1);
    ent = spawntimedfx(smokeweapon, position, dir_up, effectlifetime);
    if (isdefined(owner)) {
        ent setteam(owner.team);
        if (isplayer(owner)) {
            ent setowner(owner);
        }
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
// Params 4, eflags: 0x0
// Checksum 0x14e8127c, Offset: 0x418
// Size: 0x94
function damageeffectarea(owner, position, radius, height) {
    effectarea = spawn("trigger_radius", position, 0, radius, height);
    if (isdefined(level.dogsonflashdogs)) {
        owner thread [[ level.dogsonflashdogs ]](effectarea);
    }
    effectarea delete();
}

// Namespace smokegrenade/smokegrenade
// Params 1, eflags: 0x0
// Checksum 0x781042f2, Offset: 0x4b8
// Size: 0xa8
function smokeblocksight(radius) {
    self endon(#"death");
    while (true) {
        fxblocksight(self, radius);
        /#
            if (getdvarint(#"scr_smokegrenade_debug", 0)) {
                sphere(self.origin, 128, (1, 0, 0), 0.25, 0, 10, 15);
            }
        #/
        wait 0.75;
    }
}

// Namespace smokegrenade/smokegrenade
// Params 1, eflags: 0x0
// Checksum 0x7cdbfc9, Offset: 0x568
// Size: 0x12c
function spawnsmokegrenadetrigger(duration) {
    team = self.team;
    trigger = spawn("trigger_radius", self.origin, 0, 128, 128);
    if (!isdefined(level.smoke_grenade_triggers)) {
        level.smoke_grenade_triggers = [];
    } else if (!isarray(level.smoke_grenade_triggers)) {
        level.smoke_grenade_triggers = array(level.smoke_grenade_triggers);
    }
    level.smoke_grenade_triggers[level.smoke_grenade_triggers.size] = trigger;
    self waittilltimeout(duration, #"death");
    arrayremovevalue(level.smoke_grenade_triggers, trigger);
    trigger delete();
}

// Namespace smokegrenade/smokegrenade
// Params 0, eflags: 0x0
// Checksum 0x14f8e270, Offset: 0x6a0
// Size: 0x8a
function function_c7ecc8f3() {
    foreach (trigger in level.smoke_grenade_triggers) {
        if (self istouching(trigger)) {
            return true;
        }
    }
    return false;
}

// Namespace smokegrenade/grenade_fire
// Params 1, eflags: 0x40
// Checksum 0x8dabe211, Offset: 0x738
// Size: 0x194
function event_handler[grenade_fire] function_1c84017a(eventstruct) {
    weapon_smoke = getweapon(#"willy_pete");
    var_f4e23c23 = getweapon(#"hash_615e6c73989c85b4");
    var_cedfc1ba = getweapon(#"hash_7a88daffaea7a9cf");
    duration = isdefined(level.smokegrenadeduration) ? level.smokegrenadeduration : 7;
    totaltime = isdefined(level.smokegrenadetotaltime) ? level.smokegrenadetotaltime : 8;
    grenade = eventstruct.projectile;
    weapon = eventstruct.weapon;
    if (grenade util::ishacked()) {
        return;
    }
    if (weapon.rootweapon == weapon_smoke || weapon.rootweapon == var_f4e23c23 || weapon.rootweapon == var_cedfc1ba) {
        grenade thread watchsmokegrenadedetonation(self, weapon_smoke, weapon_smoke, duration, totaltime);
    }
}

// Namespace smokegrenade/smokegrenade
// Params 5, eflags: 0x0
// Checksum 0xf64c424b, Offset: 0x8d8
// Size: 0x124
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

