#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\damage;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\weapons_shared;
#using scripts\weapons\weaponobjects;

#namespace gadget_tripwire;

// Namespace gadget_tripwire/gadget_tripwire
// Params 0, eflags: 0x2
// Checksum 0xc15d5000, Offset: 0x178
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"gadget_tripwire", &__init__, undefined, undefined);
}

// Namespace gadget_tripwire/gadget_tripwire
// Params 0, eflags: 0x0
// Checksum 0xc2612b08, Offset: 0x1c0
// Size: 0x17e
function __init__() {
    clientfield::register("missile", "tripwire_state", 1, 1, "int");
    clientfield::register("scriptmover", "tripwire_solo_beam_fx", 1, 1, "int");
    callback::on_connect(&function_91d0b125);
    weaponobjects::function_f298eae6(#"eq_tripwire", &function_6e14127, 1);
    level.tripwireweapon = getweapon("eq_tripwire");
    if (isdefined(level.tripwireweapon.customsettings)) {
        level.var_39fd437f = getscriptbundle(level.tripwireweapon.customsettings);
    } else {
        level.var_39fd437f = getscriptbundle("tripwire_custom_settings");
    }
    if (!isdefined(level.tripwires)) {
        level.tripwires = [];
    }
    if (!isdefined(level.var_5d0e72b2)) {
        level.var_5d0e72b2 = [];
    }
}

// Namespace gadget_tripwire/gadget_tripwire
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x348
// Size: 0x4
function function_91d0b125() {
    
}

// Namespace gadget_tripwire/gadget_tripwire
// Params 1, eflags: 0x0
// Checksum 0x55208df7, Offset: 0x358
// Size: 0x11e
function function_6e14127(watcher) {
    watcher.watchforfire = 1;
    watcher.ondetonatecallback = &function_1f0c140a;
    watcher.ownergetsassist = 1;
    watcher.ignoredirection = 1;
    watcher.immediatedetonation = 0;
    watcher.onspawn = &on_tripwire_spawn;
    watcher.ondamage = &function_85849681;
    watcher.ondestroyed = &function_a9094e43;
    watcher.var_46869d39 = &function_1db5c06d;
    watcher.deleteonplayerspawn = 0;
    watcher.activatesound = #"hash_3185e3ad37d8b947";
    watcher.ontimeout = &function_a9094e43;
    watcher.onfizzleout = &function_a9094e43;
}

// Namespace gadget_tripwire/gadget_tripwire
// Params 1, eflags: 0x0
// Checksum 0x76be04bb, Offset: 0x480
// Size: 0x184
function function_33c1ed1(pos) {
    newx = pos[0] - int(pos[0]) >= 0.5 ? ceil(pos[0]) : floor(pos[0]);
    newy = pos[1] - int(pos[1]) >= 0.5 ? ceil(pos[1]) : floor(pos[1]);
    newz = pos[2] - int(pos[2]) >= 0.5 ? ceil(pos[2]) : floor(pos[2]);
    pos = (newx, newy, newz);
    return pos;
}

// Namespace gadget_tripwire/gadget_tripwire
// Params 2, eflags: 0x0
// Checksum 0x89bb1185, Offset: 0x610
// Size: 0x32c
function on_tripwire_spawn(watcher, player) {
    player endon(#"death");
    player endon(#"disconnect");
    level endon(#"game_ended");
    self endon(#"death");
    weaponobjects::onspawnuseweaponobject(watcher, player);
    self.weapon = level.tripwireweapon;
    self setweapon(level.tripwireweapon);
    waitresult = self waittill(#"stationary");
    self.hitnormal = waitresult.normal;
    self.origin = function_33c1ed1(waitresult.position);
    killcament = spawn("script_model", self.origin + self.hitnormal * 5);
    self.killcament = killcament;
    if (isdefined(waitresult.target) && (isvehicle(waitresult.target) || waitresult.target ismovingplatform())) {
        self thread function_c97ee6cf(waitresult.target);
    }
    self.var_524fc611 = self gettagorigin("tag_fx");
    self.owner = player;
    self.team = player.team;
    self clientfield::set("friendlyequip", 1);
    self influencers::create_entity_enemy_influencer("claymore", player.team);
    self.destroyablebytrophysystem = 0;
    self.detonating = 0;
    wait level.var_39fd437f.var_436499e0;
    player notify(#"tripwire_spawn", {#tripwire:self});
    self clientfield::set("tripwire_state", 1);
    arrayinsert(level.tripwires, self, level.tripwires.size);
    level function_7b6dbdc();
    self thread function_43b0e6e6();
}

// Namespace gadget_tripwire/gadget_tripwire
// Params 1, eflags: 0x0
// Checksum 0x220830, Offset: 0x948
// Size: 0xca
function function_c97ee6cf(ent) {
    self endon(#"death");
    oldpos = ent.origin;
    while (true) {
        curpos = ent.origin;
        if (distancesquared(oldpos, curpos)) {
            self thread function_1f0c140a(undefined, self.weapon, undefined, undefined);
        }
        oldpos = curpos;
        wait float(function_f9f48566()) / 1000;
    }
}

// Namespace gadget_tripwire/gadget_tripwire
// Params 0, eflags: 0x0
// Checksum 0xcfe3cd72, Offset: 0xa20
// Size: 0x160
function function_7b6dbdc() {
    foreach (tripwire in level.tripwires) {
        if (!isdefined(tripwire)) {
            continue;
        }
        tripwire thread function_51e9873e();
    }
    foreach (tripwire in level.tripwires) {
        if (!isdefined(tripwire)) {
            continue;
        }
        if (tripwire.var_25c452f6) {
            tripwire thread function_63c2e091();
            continue;
        }
        if (!isdefined(tripwire.var_aa289753)) {
            tripwire function_ddb1c8();
        }
        tripwire.var_aa289753 clientfield::set("tripwire_solo_beam_fx", 1);
    }
}

// Namespace gadget_tripwire/gadget_tripwire
// Params 0, eflags: 0x0
// Checksum 0x8fb7c94d, Offset: 0xb88
// Size: 0x19c
function function_ddb1c8() {
    self endon(#"death");
    angles = vectortoangles(self.hitnormal);
    pos = self gettagorigin("tag_fx");
    fxorg = spawn("script_model", pos, 0, angles);
    fxorg.angles = angles;
    fxorg setmodel(#"tag_origin");
    self.var_aa289753 = fxorg;
    fxorg linkto(self);
    self playsound(#"hash_58a0696fb1726978");
    self playloopsound(#"hash_3e09d676ac6291c1", 0.25);
    if (isdefined(self.owner)) {
        fxorg setowner(self.owner);
        fxorg setteam(self.owner.team);
        return;
    }
    fxorg setteam(self.team);
}

// Namespace gadget_tripwire/gadget_tripwire
// Params 0, eflags: 0x0
// Checksum 0xe86b4473, Offset: 0xd30
// Size: 0x34
function function_63c2e091() {
    if (isdefined(self.var_aa289753)) {
        self.var_aa289753 clientfield::set("tripwire_solo_beam_fx", 0);
    }
}

// Namespace gadget_tripwire/gadget_tripwire
// Params 1, eflags: 0x0
// Checksum 0xbf61e0fe, Offset: 0xd70
// Size: 0x30
function function_39a33da3(trace) {
    if (trace[#"fraction"] < 1) {
        return false;
    }
    return true;
}

// Namespace gadget_tripwire/gadget_tripwire
// Params 0, eflags: 0x0
// Checksum 0x1ae8f796, Offset: 0xda8
// Size: 0x26e
function function_51e9873e() {
    self endon(#"death");
    self.var_25c452f6 = 0;
    self.var_c903f723 = [];
    foreach (tripwire in level.tripwires) {
        if (!isdefined(tripwire)) {
            continue;
        }
        if (self.owner != tripwire.owner) {
            continue;
        }
        if (self == tripwire) {
            continue;
        }
        if (distancesquared(tripwire.origin, self.origin) >= 100 && distancesquared(tripwire.origin, self.origin) <= level.var_39fd437f.var_60431f90 * level.var_39fd437f.var_60431f90) {
            trace = beamtrace(tripwire.var_524fc611, self.var_524fc611, 0, self, 0, 0, tripwire);
            var_5110ef20 = beamtrace(self.var_524fc611, tripwire.var_524fc611, 0, self, 0, 0, tripwire);
            if (self function_39a33da3(trace) && self function_39a33da3(var_5110ef20)) {
                arrayinsert(self.var_c903f723, tripwire, self.var_c903f723.size);
                self.var_25c452f6 = 1;
                self playsound(#"hash_58a0696fb1726978");
                self playloopsound(#"hash_3e09d676ac6291c1", 0.25);
            }
        }
    }
    return self.var_25c452f6;
}

// Namespace gadget_tripwire/gadget_tripwire
// Params 2, eflags: 0x0
// Checksum 0xf13cf5e8, Offset: 0x1020
// Size: 0x110
function function_dbdb2f10(entity, tripmine) {
    if (sessionmodeiswarzonegame() && !isdefined(entity)) {
        return true;
    }
    if (!isdefined(entity)) {
        return false;
    }
    if (entity.team == tripmine.team) {
        return false;
    }
    if (!isplayer(entity) && !isvehicle(entity) && !isai(entity) && !entity ismovingplatform()) {
        return false;
    }
    if (isplayer(entity) && entity hasperk(#"specialty_nottargetedbytripwire")) {
        return false;
    }
    return true;
}

// Namespace gadget_tripwire/gadget_tripwire
// Params 1, eflags: 0x0
// Checksum 0x4acb5e88, Offset: 0x1138
// Size: 0xaa
function function_1f670463(player) {
    if (!player isgrappling()) {
        return false;
    }
    if (player.team == self.team) {
        return false;
    }
    if (player hasperk(#"specialty_nottargetedbytripwire")) {
        return false;
    }
    if (distancesquared(player.origin, player.prev_origin) == 0) {
        return false;
    }
    return true;
}

// Namespace gadget_tripwire/gadget_tripwire
// Params 1, eflags: 0x0
// Checksum 0xa46f6dc6, Offset: 0x11f0
// Size: 0x1ea
function function_2d09bb5e(endpoint) {
    self endon(#"death");
    result = 0;
    foreach (player in getplayers()) {
        if (!isdefined(player.prev_origin)) {
            player.prev_origin = player.origin;
        }
        if (!function_1f670463(player)) {
            player.prev_origin = player.origin;
            continue;
        }
        points = math::function_5b5ab257(self.var_524fc611, endpoint, player.origin, player.prev_origin, 1);
        if (!isdefined(points)) {
            return 0;
        }
        mins = player getmins() + points.pointb;
        maxs = player getmaxs() + points.pointb;
        result = function_4d318532(mins, maxs, points.pointa);
        if (result) {
            return result;
        }
        player.prev_origin = player.origin;
    }
    return result;
}

// Namespace gadget_tripwire/gadget_tripwire
// Params 0, eflags: 0x0
// Checksum 0xa2695456, Offset: 0x13e8
// Size: 0x2e6
function function_43b0e6e6() {
    self endon(#"death");
    while (true) {
        if (self.var_25c452f6) {
            foreach (tripwire in self.var_c903f723) {
                if (!isdefined(self)) {
                    return;
                }
                if (!isdefined(tripwire)) {
                    continue;
                }
                if (!self.detonating && !tripwire.detonating) {
                    dotrace = 1;
                    if (function_2d09bb5e(tripwire.var_524fc611)) {
                        self thread function_1f0c140a(undefined, self.weapon, undefined, tripwire);
                        dotrace = 0;
                        break;
                    }
                    if (dotrace) {
                        trace = beamtrace(tripwire.var_524fc611, self.var_524fc611, 1, self);
                        if (trace[#"fraction"] < 0.95) {
                            if (function_dbdb2f10(trace[#"entity"], self)) {
                                self thread function_1f0c140a(undefined, self.weapon, undefined, tripwire);
                            }
                        }
                    }
                }
            }
        } else if (self.detonating == 0) {
            endpos = self.var_524fc611 + self.hitnormal * level.var_39fd437f.var_969a1ac6;
            dotrace = 1;
            if (function_2d09bb5e(endpos)) {
                self thread function_1f0c140a(undefined, self.weapon, undefined, undefined);
                dotrace = 0;
                break;
            }
            if (dotrace) {
                trace = beamtrace(self.origin, endpos, 1, self);
                if (trace[#"fraction"] < 0.95) {
                    if (function_dbdb2f10(trace[#"entity"], self)) {
                        self thread function_1f0c140a(undefined, self.weapon, undefined, undefined);
                    }
                }
            }
        }
        waitframe(1);
    }
}

// Namespace gadget_tripwire/gadget_tripwire
// Params 4, eflags: 0x0
// Checksum 0x9c3c47cb, Offset: 0x16d8
// Size: 0x814
function function_1f0c140a(attacker, weapon, target, var_b8761ab1) {
    self endon(#"death");
    if (isdefined(attacker)) {
        if (self.owner util::isenemyplayer(attacker)) {
            self.owner globallogic_score::function_a63adb85(attacker, weapon, self.weapon);
        }
        self radiusdamage(self.origin, 55, 10, 10, self.owner, "MOD_UNKNOWN");
        if (isdefined(level.var_b31e16d4)) {
            self [[ level.var_b31e16d4 ]](attacker, self.owner, self.weapon, weapon);
        }
        self thread function_a9094e43();
    } else {
        self playsound(#"hash_1f0de5f27d29d3aa");
        self.detonating = 1;
        if (isdefined(var_b8761ab1)) {
            var_b8761ab1.detonating = 1;
        }
        wait level.var_39fd437f.var_d4a07b0d;
        if (isdefined(var_b8761ab1)) {
            explosiondist = isdefined(level.var_39fd437f.var_5a9e53a3) ? level.var_39fd437f.var_5a9e53a3 : 0;
            nearradius = isdefined(level.var_39fd437f.var_c9851f4f) ? level.var_39fd437f.var_c9851f4f : 0;
            farradius = isdefined(level.var_39fd437f.var_fb6c90a) ? level.var_39fd437f.var_fb6c90a : 0;
            maxdamage = isdefined(level.var_39fd437f.var_93401d3b) ? level.var_39fd437f.var_93401d3b : 0;
            mindamage = isdefined(level.var_39fd437f.var_1ef96fd5) ? level.var_39fd437f.var_1ef96fd5 : 0;
        } else {
            explosiondist = isdefined(level.var_39fd437f.var_7187ca54) ? level.var_39fd437f.var_7187ca54 : 0;
            nearradius = isdefined(level.var_39fd437f.var_ccf46880) ? level.var_39fd437f.var_ccf46880 : 0;
            farradius = isdefined(level.var_39fd437f.var_84aaf42d) ? level.var_39fd437f.var_84aaf42d : 0;
            maxdamage = isdefined(level.var_39fd437f.var_c35bcd1c) ? level.var_39fd437f.var_c35bcd1c : 0;
            mindamage = isdefined(level.var_39fd437f.var_3f567242) ? level.var_39fd437f.var_3f567242 : 0;
        }
        explosiondir = self.hitnormal;
        explosionsound = #"exp_tripwire";
        if (isdefined(var_b8761ab1)) {
            explosionsound = #"exp_tripwire";
            explosiondir = self.origin - var_b8761ab1.origin;
            explosiondir = vectornormalize(explosiondir);
            perpvec = perpendicularvector(explosiondir);
            var_b8761ab1 cylinderdamage(explosiondir * explosiondist, var_b8761ab1.origin, nearradius, farradius, maxdamage, mindamage, var_b8761ab1.owner, "MOD_EXPLOSIVE", self.weapon);
            playfx(#"hash_69455dfeef0311c2", var_b8761ab1.origin, explosiondir, perpvec);
            playsoundatposition(explosionsound, self.origin);
            playsoundatposition(explosionsound, var_b8761ab1.origin);
            var_b8761ab1 ghost();
            explosiondir = var_b8761ab1.origin - self.origin;
            explosiondir = vectornormalize(explosiondir);
        }
        if (isdefined(self)) {
            perpvec = perpendicularvector(explosiondir);
            playfx(#"hash_69455dfeef0311c2", self.origin, explosiondir, perpvec);
            self playsound(explosionsound);
            if (!isdefined(var_b8761ab1)) {
                self radiusdamage(self.origin + self.hitnormal * 5, explosiondist / 2, maxdamage, mindamage, self.owner, "MOD_EXPLOSIVE", self.weapon);
            } else {
                self cylinderdamage(explosiondir * explosiondist, self.origin, nearradius, farradius, maxdamage, mindamage, self.owner, "MOD_EXPLOSIVE", self.weapon);
            }
        }
    }
    self ghost();
    wait 0.1;
    if (!isdefined(self)) {
        return;
    }
    if (isdefined(var_b8761ab1)) {
        arrayremovevalue(level.tripwires, var_b8761ab1);
        if (isdefined(var_b8761ab1.var_aa289753)) {
            var_b8761ab1.var_aa289753 clientfield::set("tripwire_solo_beam_fx", 0);
            util::wait_network_frame();
            if (isdefined(var_b8761ab1)) {
                var_b8761ab1.var_aa289753 delete();
                var_b8761ab1.var_aa289753 = undefined;
            }
        }
        if (isdefined(var_b8761ab1)) {
            var_b8761ab1 delete();
        }
    }
    self stoploopsound(0.5);
    arrayremovevalue(level.tripwires, self);
    if (isdefined(self.var_aa289753)) {
        self.var_aa289753 clientfield::set("tripwire_solo_beam_fx", 0);
        util::wait_network_frame();
        self.var_aa289753 delete();
        self.var_aa289753 = undefined;
    }
    level thread function_7b6dbdc();
    self delete();
}

// Namespace gadget_tripwire/gadget_tripwire
// Params 1, eflags: 0x0
// Checksum 0x420f1967, Offset: 0x1ef8
// Size: 0x24
function function_1db5c06d(player) {
    self function_a9094e43();
}

// Namespace gadget_tripwire/gadget_tripwire
// Params 0, eflags: 0x0
// Checksum 0x40b0f2b6, Offset: 0x1f28
// Size: 0x134
function function_a9094e43() {
    self clientfield::set("friendlyequip", 1);
    playfx(#"hash_65c5042becfbaa7d", self.origin);
    playsoundatposition(#"hash_5a530df2bd2b027c", self.origin);
    self stoploopsound(0.5);
    arrayremovevalue(level.tripwires, self);
    if (isdefined(self.var_aa289753)) {
        self.var_aa289753 clientfield::set("tripwire_solo_beam_fx", 0);
        self.var_aa289753 delete();
        self.var_aa289753 = undefined;
    }
    level thread function_7b6dbdc();
    self delete();
}

// Namespace gadget_tripwire/gadget_tripwire
// Params 1, eflags: 0x0
// Checksum 0x19ba1624, Offset: 0x2068
// Size: 0x31a
function function_85849681(watcher) {
    self endon(#"death");
    self setcandamage(1);
    damagemax = 20;
    self.maxhealth = 100000;
    self.health = self.maxhealth;
    self.damagetaken = 0;
    attacker = undefined;
    while (true) {
        waitresult = self waittill(#"damage");
        attacker = waitresult.attacker;
        weapon = waitresult.weapon;
        damage = waitresult.amount;
        type = waitresult.mod;
        idflags = waitresult.flags;
        if (weapon == getweapon("eq_tripwire")) {
            continue;
        }
        damage = weapons::function_fa5602(damage, weapon, self.weapon);
        attacker = self [[ level.figure_out_attacker ]](waitresult.attacker);
        if (level.teambased && isplayer(attacker)) {
            if (!level.hardcoremode && self.owner.team == attacker.pers[#"team"] && self.owner != attacker) {
                continue;
            }
        }
        if (watcher.stuntime > 0 && weapon.dostun) {
            self thread weaponobjects::stunstart(watcher, watcher.stuntime);
        }
        if (damage::friendlyfirecheck(self.owner, attacker)) {
            if (damagefeedback::dodamagefeedback(weapon, attacker)) {
                attacker damagefeedback::update();
            }
        }
        if (type == "MOD_MELEE" || weapon.isemp || weapon.destroysequipment) {
            self.damagetaken = damagemax;
        } else {
            self.damagetaken += damage;
        }
        if (self.damagetaken >= damagemax) {
            watcher thread weaponobjects::waitanddetonate(self, 0.05, attacker, weapon);
            return;
        }
    }
}

