#using script_243ea03c7a285692;
#using script_5394c653bafe1358;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\demo_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\oob;
#using scripts\core_common\potm_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\weapons\weapon_utils;
#using scripts\weapons\weapons;

#namespace laststand_mp;

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x2
// Checksum 0xdae64121, Offset: 0x218
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"laststand_mp", &__init__, undefined, undefined);
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x0
// Checksum 0xf171581e, Offset: 0x260
// Size: 0x34c
function __init__() {
    level.revive_hud = revive_hud::register("revive_hud");
    level.mp_revive_prompt = array(mp_revive_prompt::register("mp_revive_prompt_1"), mp_revive_prompt::register("mp_revive_prompt_2"), mp_revive_prompt::register("mp_revive_prompt_3"));
    clientfield::register("clientuimodel", "hudItems.laststand.progress", 1, 5, "float");
    clientfield::register("clientuimodel", "hudItems.laststand.beingRevived", 1, 1, "int");
    clientfield::register("clientuimodel", "EnemyTeamLastLivesData.numPlayersDowned", 1, 3, "int");
    clientfield::register("clientuimodel", "PlayerTeamLastLivesData.numPlayersDowned", 1, 3, "int");
    level.var_1ac85360 = 1;
    level.var_67140788 = &playerlaststand;
    level.laststandlives = getgametypesetting(#"hash_83f11b8abac148f");
    level.var_c03c95bb = getgametypesetting(#"hash_4c7c8c4bd1b2a58b");
    level.laststandweapon = getweapon(#"downed");
    level.var_27051a61 = getweapon(#"notdowned");
    level.weaponrevivetool = getweapon("syrette");
    level.var_df17f4cf = [];
    level thread revive_hud_think();
    if (!isdefined(getdvar(#"revive_trigger_radius"))) {
        setdvar(#"revive_trigger_radius", 100);
    }
    callback::on_spawned(&on_player_spawned);
    callback::on_player_damage(&on_player_damage);
    level.var_8d92e32 = [];
    level.var_8d92e32[#"axis"] = 0;
    level.var_8d92e32[#"allies"] = 0;
    /#
        level thread force_last_stand();
    #/
}

// Namespace laststand_mp/laststand
// Params 1, eflags: 0x0
// Checksum 0x51ec2026, Offset: 0x5b8
// Size: 0x1a
function function_e2cfa34c(callbackfunc) {
    level.var_fe214075 = callbackfunc;
}

// Namespace laststand_mp/laststand
// Params 1, eflags: 0x0
// Checksum 0xe2d9dd41, Offset: 0x5e0
// Size: 0x1a
function function_499f611d(callbackfunc) {
    level.var_ca669cb2 = callbackfunc;
}

// Namespace laststand_mp/laststand
// Params 2, eflags: 0x0
// Checksum 0x6669b56a, Offset: 0x608
// Size: 0x66
function function_e551580a(time, health) {
    tier = {#time:time, #health:health};
    level.var_df17f4cf[level.var_df17f4cf.size] = tier;
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x0
// Checksum 0x7b940f3c, Offset: 0x678
// Size: 0x100
function on_player_spawned() {
    self laststand::revive_hud_create();
    self thread function_bf75827c();
    self thread function_6548b20();
    self.var_4ff0fc47 = undefined;
    foreach (prompt in level.mp_revive_prompt) {
        [[ prompt ]]->set_clientnum(self, int(pow(2, 6) - 1));
    }
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x0
// Checksum 0xa6502927, Offset: 0x780
// Size: 0x62
function function_bf75827c() {
    self endon(#"death", #"disconnect");
    self.enteredvehicle = 0;
    while (true) {
        self waittill(#"enter_vehicle");
        self.enteredvehicle = 1;
    }
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x0
// Checksum 0x5b770a9, Offset: 0x7f0
// Size: 0x56
function function_6548b20() {
    self endon(#"death", #"disconnect");
    while (true) {
        self waittill(#"exit_vehicle");
        waitframe(1);
        self.enteredvehicle = 0;
    }
}

// Namespace laststand_mp/laststand
// Params 1, eflags: 0x0
// Checksum 0x478daae2, Offset: 0x850
// Size: 0xba
function on_player_damage(params) {
    if (self is_reviving_any()) {
        if (isdefined(self.reviving_player) && isdefined(self.reviving_player.var_919b04d)) {
            self.reviving_player.var_919b04d.var_ec3f882c += params.idamage;
            if (self.health <= params.idamage) {
                self.reviving_player.var_919b04d.var_47fb3f6c = 1;
            }
        }
    }
}

// Namespace laststand_mp/laststand
// Params 2, eflags: 0x0
// Checksum 0xc59d2199, Offset: 0x918
// Size: 0xbc
function function_125a0b40(prompt, var_189a4f0a) {
    var_189a4f0a waittill(#"player_revived", #"disconnect", #"bled_out", #"death");
    if (isdefined(self)) {
        [[ prompt ]]->close(self);
        [[ prompt ]]->set_clientnum(self, int(pow(2, 6) - 1));
    }
}

// Namespace laststand_mp/laststand
// Params 2, eflags: 0x0
// Checksum 0xe3ca8ea6, Offset: 0x9e0
// Size: 0xe0
function function_48ec2382(prompt, var_189a4f0a) {
    var_189a4f0a endon(#"player_revived", #"disconnect", #"bled_out", #"death");
    self endon(#"disconnect");
    while (true) {
        if (isalive(self)) {
            [[ prompt ]]->set_health(self, var_189a4f0a.var_a698f56d);
            [[ prompt ]]->set_reviveprogress(self, var_189a4f0a.reviveprogress);
        }
        util::wait_network_frame();
    }
}

// Namespace laststand_mp/laststand
// Params 1, eflags: 0x0
// Checksum 0x81c25a8, Offset: 0xac8
// Size: 0x12c
function function_90c21c9(var_189a4f0a) {
    foreach (prompt in level.mp_revive_prompt) {
        if (![[ prompt ]]->function_76692f88(self)) {
            [[ prompt ]]->open(self);
            [[ prompt ]]->set_health(self, 1);
            [[ prompt ]]->set_reviveprogress(self, 0);
            [[ prompt ]]->set_clientnum(self, var_189a4f0a getentitynumber());
            self thread function_125a0b40(prompt, var_189a4f0a);
            self thread function_48ec2382(prompt, var_189a4f0a);
            break;
        }
    }
}

// Namespace laststand_mp/laststand
// Params 7, eflags: 0x0
// Checksum 0xda28d650, Offset: 0xc00
// Size: 0x192
function function_b5f8b7a2(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc) {
    self.laststandparams = spawnstruct();
    self.var_afe5253c = spawnstruct();
    self.laststandparams.einflictor = einflictor;
    self.var_afe5253c.var_a21e8eb8 = isdefined(einflictor) ? einflictor getentitynumber() : -1;
    self.laststandparams.attacker = attacker;
    self.var_afe5253c.attackernum = isdefined(attacker) ? attacker getentitynumber() : -1;
    self.laststandparams.idamage = idamage;
    self.laststandparams.smeansofdeath = smeansofdeath;
    self.laststandparams.sweapon = weapon;
    self.laststandparams.vdir = vdir;
    self.laststandparams.shitloc = shitloc;
    self.laststandparams.laststandstarttime = gettime();
    self.laststandparams.bledout = 0;
    self.laststandparams.var_3c2026c5 = 1;
}

// Namespace laststand_mp/laststand
// Params 7, eflags: 0x0
// Checksum 0x4f91dd54, Offset: 0xda0
// Size: 0x166
function function_5f9f674(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc) {
    if (!isdefined(self)) {
        return;
    }
    if (!isdefined(self.laststandparams)) {
        self.laststandparams = [];
    }
    if (!isdefined(self.var_afe5253c)) {
        self.var_afe5253c = [];
    }
    self.laststandparams.einflictor = einflictor;
    self.var_afe5253c.var_a21e8eb8 = isdefined(einflictor) ? einflictor getentitynumber() : -1;
    self.laststandparams.attacker = attacker;
    self.var_afe5253c.attackernum = isdefined(attacker) ? attacker getentitynumber() : -1;
    self.laststandparams.idamage = idamage;
    self.laststandparams.smeansofdeath = smeansofdeath;
    self.laststandparams.sweapon = weapon;
    self.laststandparams.vdir = vdir;
    self.laststandparams.shitloc = shitloc;
}

// Namespace laststand_mp/laststand
// Params 2, eflags: 0x0
// Checksum 0xfae143b6, Offset: 0xf10
// Size: 0x2c
function function_1b0660bb(attacker, weapon) {
    self function_4ff3f50c();
}

/#

    // Namespace laststand_mp/laststand
    // Params 0, eflags: 0x0
    // Checksum 0x7f7dedc1, Offset: 0xf48
    // Size: 0xbc
    function function_c7424b61() {
        self endon(#"player_revived", #"death");
        while (true) {
            if (getdvarstring(#"scr_last_stand", "<dev string:x30>") == "<dev string:x31>") {
                self notify(#"auto_revive");
                waittillframeend();
                setdvar(#"scr_last_stand", "<dev string:x30>");
                return;
            }
            wait 0.1;
        }
    }

    // Namespace laststand_mp/laststand
    // Params 0, eflags: 0x0
    // Checksum 0x82deb077, Offset: 0x1010
    // Size: 0x1c0
    function force_last_stand() {
        level endon(#"game_ended");
        while (true) {
            if (getdvarstring(#"scr_last_stand", "<dev string:x30>") == "<dev string:x3b>") {
                host = util::gethostplayer();
                angles = host getplayerangles();
                dir = anglestoforward(angles);
                eye = host geteye();
                dir *= 500;
                trace = bullettrace(eye, eye + dir, 1, host);
                target = trace[#"entity"];
                if (!isdefined(target) || !isplayer(target)) {
                    target = host;
                }
                target dodamage(target.health, target.origin);
                setdvar(#"scr_last_stand", "<dev string:x30>");
            }
            wait 0.1;
        }
    }

#/

// Namespace laststand_mp/laststand
// Params 9, eflags: 0x0
// Checksum 0x11c72d29, Offset: 0x11d8
// Size: 0x934
function playerlaststand(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, delayoverride) {
    if (self laststand::player_is_in_laststand()) {
        return;
    }
    self.var_85515238 = self getcurrentweapon();
    self function_b5f8b7a2(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc);
    if (!isdefined(self.laststandcount)) {
        self.laststandcount = 0;
    }
    self.laststandcount++;
    self function_c7bb87ea();
    if (isdefined(level.var_60230117)) {
        [[ level.var_60230117 ]]();
    }
    var_c3180227 = 1;
    friendlies = getplayers(self.team);
    var_8eb8f773 = 0;
    foreach (player in friendlies) {
        if (player == self) {
            continue;
        }
        if (isalive(player) && !player laststand::player_is_in_laststand()) {
            var_c3180227 = 0;
            var_8eb8f773 = 1;
            break;
        }
    }
    if (self isplayerswimming() || isdefined(self.enteredvehicle) && self.enteredvehicle) {
        var_c3180227 = 1;
    }
    if (level.laststandlives && self.laststandcount > level.laststandlives) {
        var_c3180227 = 1;
    }
    if (isdefined(self.last_valid_position) && self.last_valid_position[2] - self.origin[2] > 200) {
        var_c3180227 = 1;
    }
    if (attacker === self) {
        var_c3180227 = 1;
    }
    if (var_c3180227) {
        self undolaststand();
        self.uselaststandparams = 1;
        self function_b2a9a30f();
        self suicide(smeansofdeath);
        if (isdefined(self.var_919b04d)) {
            self.var_919b04d.death = 1;
        }
        self function_170721bb();
        if (!var_8eb8f773) {
            foreach (player in friendlies) {
                if (player != self && isalive(player) && player laststand::player_is_in_laststand()) {
                    player thread bleed_out();
                }
            }
        }
        return;
    }
    if (isdefined(attacker) && isplayer(attacker)) {
        if (attacker != self) {
            scoreevents::processscoreevent(#"downed_enemy", attacker, self, weapon);
        }
        if (isdefined(level.var_fe214075)) {
            [[ level.var_fe214075 ]](attacker, self, einflictor, weapon, smeansofdeath);
        }
    }
    self.reviveprogress = 0;
    self.var_a698f56d = 1;
    level.var_8d92e32[self.team]++;
    foreach (player in friendlies) {
        if (!player laststand::player_is_in_laststand()) {
            player clientfield::set_player_uimodel("PlayerTeamLastLivesData.numPlayersDowned", level.var_8d92e32[self.team]);
        }
        var_db0c9327 = player != self && isalive(player);
        if ((var_db0c9327 || sessionmodeismultiplayergame()) && !player laststand::player_is_in_laststand()) {
            player thread function_90c21c9(self);
        }
    }
    enemies = getplayers(util::getotherteam(self.team));
    foreach (player in enemies) {
        if (!player laststand::player_is_in_laststand()) {
            player clientfield::set_player_uimodel("EnemyTeamLastLivesData.numPlayersDowned", level.var_8d92e32[self.team]);
        }
    }
    self notify(#"entering_last_stand");
    self allowjump(0);
    self disableoffhandweapons();
    /#
        self thread function_c7424b61();
    #/
    self.health = 5;
    self.laststand = 1;
    self.meleeattackers = undefined;
    callback::callback(#"on_player_laststand");
    self function_1b0660bb(attacker, weapon);
    if (!(isdefined(self.no_revive_trigger) && self.no_revive_trigger)) {
        if (!self oob::isoutofbounds()) {
            self revive_trigger_spawn();
        }
    }
    self laststand_disable_player_weapons();
    bleedout_time = getdvarfloat(#"player_laststandbleedouttime", 0);
    var_aab2a993 = self.maxhealth;
    var_af64e279 = self.laststandcount - 1;
    if (var_af64e279 >= level.var_df17f4cf.size) {
        var_af64e279 = level.var_df17f4cf.size - 1;
    }
    var_df17f4cf = level.var_df17f4cf[var_af64e279];
    if (isdefined(var_df17f4cf)) {
        bleedout_time = var_df17f4cf.time;
        var_aab2a993 = var_df17f4cf.health;
    }
    self thread laststand_bleedout(bleedout_time, var_aab2a993);
    self thread laststand_invulnerability();
    demo::bookmark(#"player_downed", gettime(), self);
    potm::bookmark(#"player_downed", gettime(), self);
    self thread laststand::function_692e99d6();
    self thread auto_revive_on_notify();
    self thread function_4c6720fc();
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x0
// Checksum 0xc65cebcb, Offset: 0x1b18
// Size: 0x64
function function_4c6720fc() {
    self endon(#"player_revived", #"disconnect");
    self waittill(#"death");
    self function_4ff3f50c();
    self undolaststand();
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x0
// Checksum 0xa12d1caa, Offset: 0x1b88
// Size: 0x94
function laststand_disable_player_weapons() {
    self giveweapon(level.laststandweapon);
    self givemaxammo(level.laststandweapon);
    self switchtoweapon(level.laststandweapon, 1);
    self disableweaponcycling();
    self disableoffhandweapons();
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x0
// Checksum 0xc35643b9, Offset: 0x1c28
// Size: 0x64
function function_2e411425() {
    self takeweapon(level.laststandweapon);
    self giveweapon(level.var_27051a61);
    self switchtoweapon(level.var_27051a61, 1);
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x0
// Checksum 0xcab2d3c4, Offset: 0x1c98
// Size: 0x74
function laststand_enable_player_weapons() {
    self takeweapon(level.var_27051a61);
    self enableweaponcycling();
    self enableoffhandweapons();
    self weapons::function_3c7b37f2(self.var_85515238);
}

// Namespace laststand_mp/laststand
// Params 1, eflags: 0x0
// Checksum 0x7a66c3fc, Offset: 0x1d18
// Size: 0xfc
function laststand_clean_up_on_interrupt(playerbeingrevived) {
    self endon(#"do_revive_ended_normally");
    revivetrigger = playerbeingrevived.revivetrigger;
    playerbeingrevived waittill(#"disconnect", #"game_ended", #"death");
    if (isdefined(playerbeingrevived)) {
        playerbeingrevived clientfield::set_player_uimodel("hudItems.laststand.beingRevived", 0);
    }
    self stoploopsound(1);
    if (isdefined(revivetrigger)) {
        revivetrigger delete();
    }
    self function_4ff3f50c();
    self revive_give_back_weapons();
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x0
// Checksum 0x9c6aa15c, Offset: 0x1e20
// Size: 0x18e
function laststand_bleedout_damage() {
    self endon(#"player_revived", #"disconnect", #"bled_out");
    while (true) {
        waitresult = self waittill(#"laststand_damage");
        if (waitresult.smeansofdeath == "MOD_MELEE") {
            self.var_aab2a993 = 0;
        } else {
            self.var_aab2a993 -= waitresult.idamage;
        }
        if (self.var_aab2a993 <= 0) {
            self.bleedout_time = 0;
            self.var_f1055d8b = 1;
            self function_5f9f674(waitresult.einflictor, waitresult.eattacker, waitresult.idamage, waitresult.smeansofdeath, waitresult.weapon, waitresult.vdir, waitresult.shitloc);
            self notify(#"update_bleedout");
        }
        if (isdefined(self.var_919b04d)) {
            self.var_919b04d.damage += int(waitresult.idamage);
        }
    }
}

// Namespace laststand_mp/laststand
// Params 2, eflags: 0x0
// Checksum 0x9b8f5e8, Offset: 0x1fb8
// Size: 0x24c
function laststand_bleedout(bleedouttime, var_aab2a993) {
    self endon(#"player_revived", #"player_bleedout", #"death");
    self.var_320b6880 = bleedouttime;
    self.bleedout_time = bleedouttime;
    self.var_aab2a993 = var_aab2a993;
    self.var_a698f56d = 0;
    if (self.bleedout_time > 0) {
        self thread laststand_bleedout_damage();
        var_d06d82d6 = gettime();
        while (self.bleedout_time > 0) {
            time = gettime();
            if (time >= var_d06d82d6) {
                being_revived = isdefined(self.revivetrigger) && isdefined(self.revivetrigger.beingrevived) && self.revivetrigger.beingrevived == 1;
                if (!being_revived) {
                    self.var_a698f56d = self.bleedout_time / bleedouttime;
                    self.bleedout_time -= 1;
                    self clientfield::set_player_uimodel("hudItems.laststand.progress", self.var_a698f56d);
                }
                var_d06d82d6 = time + 1000;
            }
            self waittilltimeout(float(var_d06d82d6 - time) / 1000, #"update_bleedout");
        }
        while (isdefined(self.revivetrigger) && isdefined(self.revivetrigger.beingrevived) && self.revivetrigger.beingrevived == 1) {
            wait 0.1;
        }
    }
    if (self.var_4ff0fc47 === 1) {
        return;
    }
    self notify(#"bled_out");
    self thread bleed_out();
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x0
// Checksum 0xcae07313, Offset: 0x2210
// Size: 0x5c
function laststand_invulnerability() {
    self endon(#"disconnect", #"death");
    self enableinvulnerability();
    wait level.var_c03c95bb;
    self disableinvulnerability();
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x0
// Checksum 0x28d45342, Offset: 0x2278
// Size: 0x46
function function_b2a9a30f() {
    if (isdefined(self) && isdefined(self.laststandparams) && !isdefined(self.laststandparams.attacker)) {
        self.laststandparams.attacker = self;
    }
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x0
// Checksum 0x83ceb6e9, Offset: 0x22c8
// Size: 0x3c4
function bleed_out() {
    self endon(#"player_revived", #"death");
    util::wait_network_frame();
    self function_4ff3f50c();
    if (isdefined(self.revivetrigger)) {
        self.revivetrigger delete();
        self.revivetrigger = undefined;
    }
    demo::bookmark(#"player_bledout", gettime(), self, undefined, 1);
    potm::bookmark(#"player_bledout", gettime(), self, undefined, 1);
    level notify(#"bleed_out", {#character_index:self.characterindex});
    self notify(#"player_bleedout");
    callback::callback(#"on_player_bleedout");
    self undolaststand();
    self.uselaststandparams = 1;
    self function_b2a9a30f();
    if (isdefined(self.laststandparams) && !(isdefined(self.var_f1055d8b) && self.var_f1055d8b)) {
        self.laststandparams.bledout = 1;
    }
    if (isdefined(self.var_919b04d)) {
        self.var_919b04d.death = isdefined(self.var_f1055d8b) && self.var_f1055d8b;
        self.var_919b04d.bleed_out = !self.var_919b04d.death;
        self function_170721bb();
    }
    self function_4ff3f50c();
    if (isdefined(self.laststandparams) && isdefined(self.laststandparams.smeansofdeath)) {
        self suicide(self.laststandparams.smeansofdeath);
    } else {
        self suicide();
    }
    if (getdvarint(#"hash_62b8db0428755a32", 1) && isplayer(self)) {
        var_6afb4351 = getdvarfloat(#"hash_44de9418bb6289ac", 1.5);
        self playsoundtoplayer(#"hash_11d39dca0f911535", self);
        self lui::screen_fade(var_6afb4351, 1, 0, "black", 0);
        wait var_6afb4351 + 0.2;
        self lui::screen_fade(var_6afb4351, 0, 1, "black", 0);
    }
    if (isdefined(self) && self.no_respawn !== 1) {
        self thread respawn_player_after_time(15);
    }
}

// Namespace laststand_mp/laststand
// Params 1, eflags: 0x0
// Checksum 0xf2888219, Offset: 0x2698
// Size: 0xbc
function respawn_player_after_time(n_time_seconds) {
    self endon(#"death", #"disconnect");
    players = getplayers();
    if (players.size == 1) {
        return;
    }
    self waittill(#"spawned_spectator");
    level endon(#"objective_changed");
    wait n_time_seconds;
    if (self.sessionstate == #"spectator") {
        self thread globallogic_spawn::waitandspawnclient();
    }
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x0
// Checksum 0xbd026c47, Offset: 0x2760
// Size: 0x44
function function_4ff3f50c() {
    self clientfield::set_player_uimodel("hudItems.laststand.progress", 0);
    self clientfield::set_player_uimodel("hudItems.laststand.beingRevived", 0);
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x0
// Checksum 0xa3c3ba34, Offset: 0x27b0
// Size: 0x164
function revive_trigger_spawn() {
    radius = getdvarint(#"revive_trigger_radius", 100);
    self.revivetrigger = spawn("trigger_radius", (0, 0, 0), 0, radius, radius);
    self.revivetrigger sethintstring("");
    self.revivetrigger setcursorhint("HINT_NOICON");
    self.revivetrigger setmovingplatformenabled(1);
    self.revivetrigger enablelinkto();
    self.revivetrigger.origin = self.origin;
    self.revivetrigger linkto(self);
    self.revivetrigger.beingrevived = 0;
    self.revivetrigger.createtime = gettime();
    self.revivetrigger setteamfortrigger(self.team);
    self thread revive_trigger_think();
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x0
// Checksum 0x3e47fc68, Offset: 0x2920
// Size: 0x3a4
function revive_trigger_think() {
    self endon(#"death", #"stop_revive_trigger");
    level endon(#"game_ended");
    while (true) {
        wait 0.1;
        if (!isdefined(self.revivetrigger)) {
            self notify(#"stop_revive_trigger");
        }
        self.revivetrigger sethintstring("");
        /#
            if (getdvarint(#"lastand_selfrevive", 0) && self attackbuttonpressed() && self throwbuttonpressed() && self fragbuttonpressed()) {
                self thread revive_success(self);
                self function_4ff3f50c();
                return;
            }
        #/
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (players[i] can_revive(self)) {
                self.revivetrigger setrevivehintstring(#"hash_51a0f083a5566a3", self.team);
                break;
            }
        }
        for (i = 0; i < players.size; i++) {
            reviver = players[i];
            if (self == reviver || !reviver is_reviving(self)) {
                continue;
            }
            gun = reviver getcurrentweapon();
            assert(isdefined(gun));
            if (gun == level.weaponrevivetool) {
                continue;
            }
            reviver giveweapon(level.weaponrevivetool);
            reviver switchtoweapon(level.weaponrevivetool, 1);
            reviver setweaponammostock(level.weaponrevivetool, 1);
            reviver disableweaponcycling();
            reviver disableusability();
            reviver disableoffhandweapons();
            revive_success = reviver revive_do_revive(self);
            reviver revive_give_back_weapons();
            if (revive_success) {
                self thread revive_success(reviver);
                self function_4ff3f50c();
                return;
            }
        }
    }
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x0
// Checksum 0x92622878, Offset: 0x2cd0
// Size: 0x9c
function revive_give_back_weapons() {
    if (isdefined(self.laststand) && self.laststand) {
        return;
    }
    self takeweapon(level.weaponrevivetool);
    self enableweaponcycling();
    self enableusability();
    self enableoffhandweapons();
    self weapons::function_3c7b37f2();
}

// Namespace laststand_mp/laststand
// Params 3, eflags: 0x0
// Checksum 0x7d298e3e, Offset: 0x2d78
// Size: 0x2a6
function can_revive(revivee, ignore_sight_checks = 0, ignore_touch_checks = 0) {
    if (!isdefined(revivee.revivetrigger)) {
        return false;
    }
    if (!isalive(self)) {
        return false;
    }
    if (self laststand::player_is_in_laststand()) {
        return false;
    }
    if (self.team != revivee.team) {
        return false;
    }
    if (isdefined(level.can_revive) && ![[ level.can_revive ]](revivee)) {
        return false;
    }
    if (isdefined(level.var_ae6ced2b) && ![[ level.var_ae6ced2b ]](revivee)) {
        return false;
    }
    if (!ignore_sight_checks && isdefined(level.revive_trigger_should_ignore_sight_checks)) {
        ignore_sight_checks = [[ level.revive_trigger_should_ignore_sight_checks ]](self);
        if (ignore_sight_checks && isdefined(revivee.revivetrigger.beingrevived) && revivee.revivetrigger.beingrevived == 1) {
            ignore_touch_checks = 1;
        }
    }
    if (!ignore_touch_checks) {
        if (!self istouching(revivee.revivetrigger)) {
            return false;
        }
    }
    if (!ignore_sight_checks) {
        if (!self laststand::is_facing(revivee, 0.8)) {
            return false;
        }
        if (distancesquared(revivee.origin, self.origin) > 140 * 140) {
            return false;
        }
        if (!sighttracepassed(self.origin + (0, 0, 50), revivee.origin + (0, 0, 30), 0, undefined)) {
            return false;
        }
        if (!bullettracepassed(self.origin + (0, 0, 50), revivee.origin + (0, 0, 30), 0, undefined)) {
            return false;
        }
    }
    return true;
}

// Namespace laststand_mp/laststand
// Params 1, eflags: 0x0
// Checksum 0xff92333a, Offset: 0x3028
// Size: 0x54
function is_reviving(revivee) {
    if (!isdefined(self) || !isdefined(revivee)) {
        return false;
    }
    return self usebuttonpressed() && can_revive(revivee);
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x0
// Checksum 0x3be17778, Offset: 0x3088
// Size: 0x18
function is_reviving_any() {
    return isdefined(self.is_reviving_any) && self.is_reviving_any;
}

// Namespace laststand_mp/laststand
// Params 1, eflags: 0x0
// Checksum 0xe04228c6, Offset: 0x30a8
// Size: 0x4f2
function revive_do_revive(playerbeingrevived) {
    self endon(#"disconnect");
    if (!isdefined(playerbeingrevived)) {
        return 0;
    }
    assert(self is_reviving(playerbeingrevived));
    revivetime = getdvarfloat(#"g_revivetime", 3) * self function_6fd5dbec();
    timer = 0;
    revived = 0;
    playerbeingrevived clientfield::set_player_uimodel("hudItems.laststand.beingRevived", 1);
    playerbeingrevived.revivetrigger.beingrevived = 1;
    playerbeingrevived thread laststand::revive_hud_show_n_fade(#"hash_33e29c2dd8e2d480", 3, self);
    playerbeingrevived.revivetrigger sethintstring("");
    if (isplayer(playerbeingrevived)) {
        playerbeingrevived startrevive(self);
    }
    self thread laststand_clean_up_on_interrupt(playerbeingrevived);
    if (!isdefined(self.is_reviving_any)) {
        self.is_reviving_any = 0;
    }
    self.is_reviving_any++;
    self playsound(#"hash_7f077925d3f525ad");
    self playloopsound(#"hash_67a426610a2d2a2d");
    if (isdefined(playerbeingrevived.var_919b04d)) {
        playerbeingrevived.var_919b04d.var_1883b3a3++;
    }
    self.reviving_player = playerbeingrevived;
    while (self is_reviving(playerbeingrevived)) {
        waitframe(1);
        timer += 0.05;
        if (self laststand::player_is_in_laststand()) {
            playerbeingrevived.reviveprogress = 0;
            break;
        }
        if (isdefined(playerbeingrevived.revivetrigger.auto_revive) && playerbeingrevived.revivetrigger.auto_revive) {
            playerbeingrevived.reviveprogress = 0;
            break;
        }
        playerbeingrevived.reviveprogress = min(timer / revivetime, 1);
        if (timer >= revivetime) {
            revived = 1;
            break;
        }
    }
    self stoploopsound(1);
    if (isdefined(playerbeingrevived)) {
        playerbeingrevived clientfield::set_player_uimodel("hudItems.laststand.beingRevived", 0);
        playerbeingrevived.reviveprogress = 0;
        if (isdefined(revived) && revived) {
            playerbeingrevived playsound(#"hash_39e55bff84ce34c8");
        } else {
            self playsound(#"hash_c2688a5ec1ca2b5");
        }
        if (!(isdefined(playerbeingrevived.revivetrigger.auto_revive) && playerbeingrevived.revivetrigger.auto_revive) && !revived) {
            if (isplayer(playerbeingrevived)) {
                playerbeingrevived stoprevive(self);
            }
        }
        playerbeingrevived.revivetrigger sethintstring(#"hash_51a0f083a5566a3");
        playerbeingrevived.revivetrigger.beingrevived = 0;
        if (isdefined(revived) && revived && isdefined(level.var_ca669cb2)) {
            [[ level.var_ca669cb2 ]](playerbeingrevived, self);
        }
    }
    self.reviving_player = undefined;
    self notify(#"do_revive_ended_normally");
    self.is_reviving_any--;
    if (self.is_reviving_any < 0) {
        self.is_reviving_any = 0;
    } else if (self.is_reviving_any > 99999) {
        self.is_reviving_any = 99999;
    }
    return revived;
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x0
// Checksum 0x31163eca, Offset: 0x35a8
// Size: 0x6c
function auto_revive_on_notify() {
    self endon(#"death", #"disconnect", #"player_revived");
    waitresult = self waittill(#"auto_revive");
    auto_revive(waitresult.reviver);
}

// Namespace laststand_mp/laststand
// Params 1, eflags: 0x0
// Checksum 0x97dd1189, Offset: 0x3620
// Size: 0x216
function auto_revive(reviver) {
    if (!isdefined(self)) {
        return;
    }
    self endon(#"disconnect");
    self.var_4ff0fc47 = 1;
    var_5b7fcf85 = gettime() + getdvarint(#"hash_77107267fe87b359", 350);
    if (isdefined(self.revivetrigger)) {
        self.revivetrigger.auto_revive = 1;
        while (isdefined(self.revivetrigger.beingrevived) && self.revivetrigger.beingrevived) {
            util::wait_network_frame();
        }
        self.revivetrigger.auto_trigger = 0;
    }
    self function_2e411425();
    if (var_5b7fcf85 >= gettime()) {
        revive_wait_time = (var_5b7fcf85 - gettime()) / 1000;
        wait revive_wait_time;
    }
    if (!isdefined(self)) {
        return;
    }
    self reviveplayer();
    self.var_4ff0fc47 = undefined;
    self notify(#"stop_revive_trigger");
    if (isdefined(self.revivetrigger)) {
        self.revivetrigger delete();
        self.revivetrigger = undefined;
    }
    self function_4ff3f50c();
    self laststand_enable_player_weapons();
    self allowjump(1);
    self.laststand = undefined;
    self lui::screen_close_menu();
    self notify(#"player_revived", {#reviver:reviver});
}

// Namespace laststand_mp/laststand
// Params 2, eflags: 0x0
// Checksum 0x874ac9c9, Offset: 0x3840
// Size: 0x35c
function revive_success(reviver, b_track_stats = 1) {
    if (!isplayer(self)) {
        self notify(#"player_revived", {#reviver:reviver});
        return;
    }
    self function_2e411425();
    self.var_4ff0fc47 = 1;
    revive_wait_time = getdvarint(#"hash_77107267fe87b359", 350) / 1000;
    wait revive_wait_time;
    if (!isdefined(self)) {
        return;
    }
    if (isdefined(b_track_stats) && b_track_stats) {
        demo::bookmark(#"player_revived", gettime(), reviver, self);
        potm::bookmark(#"player_revived", gettime(), reviver, self);
    }
    if (isplayer(self)) {
        self allowjump(1);
    }
    self.laststand = undefined;
    self notify(#"player_revived", {#reviver:reviver});
    self reviveplayer();
    self.var_4ff0fc47 = undefined;
    health = getdvarint(#"hash_7036719f41a78d54", 0);
    if (isdefined(reviver)) {
        var_9264c00c = reviver function_287cc4c8();
        if (var_9264c00c > 0) {
            health = var_9264c00c;
        }
        reviver scoreevents::processscoreevent(#"revived_teammate", reviver, self);
    }
    self.health = health;
    if (isdefined(self.revivetrigger)) {
        self.revivetrigger delete();
        self.revivetrigger = undefined;
    }
    self function_4ff3f50c();
    self laststand_enable_player_weapons();
    self lui::screen_close_menu();
    self function_170721bb();
    voiceevent("player_revived", self, {#reviver:reviver});
    callback::callback(#"on_player_revived");
    if (isdefined(level.var_80d46925)) {
        reviver [[ level.var_80d46925 ]](self);
    }
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x0
// Checksum 0xfdf74339, Offset: 0x3ba8
// Size: 0x274
function revive_hud_think() {
    level endon(#"game_ended");
    while (true) {
        wait 0.1;
        if (!laststand::player_any_player_in_laststand()) {
            continue;
        }
        revived = 0;
        foreach (team, _ in level.teams) {
            playertorevive = undefined;
            foreach (player in level.aliveplayers[team]) {
                if (!isdefined(player.revivetrigger) || !isdefined(player.revivetrigger.createtime)) {
                    continue;
                }
                if (!isdefined(playertorevive) || playertorevive.revivetrigger.createtime > player.revivetrigger.createtime) {
                    playertorevive = player;
                }
            }
            if (isdefined(playertorevive)) {
                foreach (player in level.aliveplayers[team]) {
                    if (player laststand::player_is_in_laststand()) {
                        continue;
                    }
                    player thread faderevivemessageover(playertorevive, 3);
                }
                playertorevive.revivetrigger.createtime = undefined;
                revived = 1;
            }
        }
        if (revived) {
            wait 3.5;
        }
    }
}

// Namespace laststand_mp/laststand
// Params 2, eflags: 0x0
// Checksum 0x96716630, Offset: 0x3e28
// Size: 0x3c
function faderevivemessageover(playertorevive, time) {
    self thread laststand::revive_hud_show_n_fade(#"hash_14cc93f11ba8334a", time, playertorevive);
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x0
// Checksum 0xb9d307d3, Offset: 0x3e70
// Size: 0xf6
function function_c7bb87ea() {
    if (!isplayer(self) || isdefined(self.var_919b04d)) {
        return;
    }
    self.var_919b04d = {#player_xuid:int(self getxuid(1)), #start_time:gettime(), #end_time:0, #damage:0, #death:0, #bleed_out:0, #var_1883b3a3:0, #var_ec3f882c:0, #var_59524993:0};
}

// Namespace laststand_mp/laststand
// Params 0, eflags: 0x0
// Checksum 0x1a03035, Offset: 0x3f70
// Size: 0x198
function function_170721bb() {
    if (!isplayer(self) || !isdefined(self.var_919b04d)) {
        return;
    }
    self.var_919b04d.end_time = gettime();
    function_b1f6086c(#"hash_142816c2e7c5da66", self.var_919b04d);
    self.var_919b04d = undefined;
    level.var_8d92e32[self.team]--;
    players = getplayers();
    foreach (player in players) {
        if (!isdefined(level.var_8d92e32[player.team])) {
            continue;
        }
        player clientfield::set_player_uimodel("PlayerTeamLastLivesData.numPlayersDowned", level.var_8d92e32[player.team]);
        player clientfield::set_player_uimodel("EnemyTeamLastLivesData.numPlayersDowned", level.var_8d92e32[util::getotherteam(player.team)]);
    }
}

