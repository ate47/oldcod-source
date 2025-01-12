#using script_57491143f0b931b5;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicles\seeker_mine;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\mp_common\gametypes\battlechatter;
#using scripts\weapons\arc;

#namespace seeker_mine_mp;

// Namespace seeker_mine_mp/seeker_mine
// Params 0, eflags: 0x2
// Checksum 0x35e2f050, Offset: 0x2f0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"seeker_mine_mp", &__init__, undefined, undefined);
}

// Namespace seeker_mine_mp/seeker_mine
// Params 0, eflags: 0x0
// Checksum 0xe9193408, Offset: 0x338
// Size: 0x274
function __init__() {
    level.seeker_mine = [];
    level.var_f334548c = &function_17fd3502;
    level.var_888baf22 = spawnstruct();
    level.var_888baf22.script = &function_95c0e529;
    level.var_888baf22.weapon = getweapon("eq_seeker_mine");
    level.var_888baf22.prompt = seeker_mine_prompt::register("seeker_mine_prompt");
    level.var_888baf22.var_f9fe06f9 = getweapon(#"hash_27d90cc12712230f");
    level.var_888baf22.var_45d14d4f = getweapon(#"hash_1ca0e9052a71989");
    level.var_888baf22.var_9f0feab8 = getweapon(#"hash_597ead6ff2ce9284");
    level.var_c0375a43 = &function_88757c6;
    function_184d8f82();
    callback::on_connect(&onplayerconnect);
    callback::on_spawned(&onspawned);
    clientfield::register("allplayers", "seeker_mine_shock", 1, 1, "int");
    clientfield::register("scriptmover", "seeker_mine_fx", 1, 2, "int");
    var_e36ea2fe = getweapon("seeker_mine_arc");
    bundle = getscriptbundle("seeker_mine_arc_settings");
    arc::init_arc(var_e36ea2fe, bundle);
}

// Namespace seeker_mine_mp/seeker_mine
// Params 0, eflags: 0x0
// Checksum 0x97286eb6, Offset: 0x5b8
// Size: 0x346
function function_184d8f82() {
    level.var_888baf22.tunables = getscriptbundle("seeker_mine_tunables");
    if (!isdefined(level.var_888baf22.tunables.var_dd3764a5)) {
        level.var_888baf22.tunables.var_dd3764a5 = 0;
    }
    if (!isdefined(level.var_888baf22.tunables.var_23d9416c)) {
        level.var_888baf22.tunables.var_23d9416c = 0;
    }
    if (!isdefined(level.var_888baf22.tunables.var_92b8c5e7)) {
        level.var_888baf22.tunables.var_92b8c5e7 = 0;
    }
    if (!isdefined(level.var_888baf22.tunables.var_258738ca)) {
        level.var_888baf22.tunables.var_258738ca = 0;
    }
    if (!isdefined(level.var_888baf22.tunables.var_f44d7dda)) {
        level.var_888baf22.tunables.var_f44d7dda = 0;
    }
    if (!isdefined(level.var_888baf22.tunables.var_f8706001)) {
        level.var_888baf22.tunables.var_f8706001 = 0;
    }
    if (!isdefined(level.var_888baf22.tunables.var_c14f4a9e)) {
        level.var_888baf22.tunables.var_c14f4a9e = 0;
    }
    if (!isdefined(level.var_888baf22.tunables.var_ac6e5309)) {
        level.var_888baf22.tunables.var_ac6e5309 = 0;
    }
    level.var_888baf22.tunables.var_99e0abb0 = level.var_888baf22.tunables.var_23d9416c + level.var_888baf22.tunables.var_92b8c5e7 + level.var_888baf22.tunables.var_258738ca + level.var_888baf22.tunables.var_f44d7dda + level.var_888baf22.tunables.var_dd3764a5;
    level.var_888baf22.tunables.maxduration = level.var_888baf22.tunables.var_99e0abb0 + level.var_888baf22.tunables.var_f8706001;
    if (!isdefined(level.var_888baf22.tunables.yaw)) {
        level.var_888baf22.tunables.yaw = 0;
    }
    if (!isdefined(level.var_888baf22.tunables.pitch)) {
        level.var_888baf22.tunables.pitch = 0;
    }
}

// Namespace seeker_mine_mp/seeker_mine
// Params 0, eflags: 0x0
// Checksum 0xd559b710, Offset: 0x908
// Size: 0x86
function onplayerconnect() {
    self.entnum = self getentitynumber();
    level.seeker_mine[self.entnum] = spawnstruct();
    level.seeker_mine[self.entnum].killstreak_id = -1;
    level.seeker_mine[self.entnum].mines = [];
}

// Namespace seeker_mine_mp/seeker_mine
// Params 0, eflags: 0x0
// Checksum 0xbc97c23f, Offset: 0x998
// Size: 0x2a
function onspawned() {
    self.var_db63b8ae = 0;
    self.var_40726073 = spawnstruct();
}

// Namespace seeker_mine_mp/seeker_mine
// Params 2, eflags: 0x0
// Checksum 0x9a417966, Offset: 0x9d0
// Size: 0x3c
function onteamchanged(entnum, event) {
    abandoned = 1;
    function_a7e8406d(entnum, abandoned);
}

// Namespace seeker_mine_mp/seeker_mine
// Params 2, eflags: 0x0
// Checksum 0x15a07e49, Offset: 0xa18
// Size: 0x2c
function onemp(attacker, ownerentnum) {
    function_a7e8406d(ownerentnum);
}

// Namespace seeker_mine_mp/seeker_mine
// Params 2, eflags: 0x0
// Checksum 0x8d2a3149, Offset: 0xa50
// Size: 0x7c
function function_95c0e529(grenade, weapon) {
    var_990c40f1 = getweapon("eq_seeker_mine");
    if (isdefined(var_990c40f1) && var_990c40f1.name == weapon.name) {
        self function_84fd1f52(grenade, weapon);
    }
}

// Namespace seeker_mine_mp/seeker_mine
// Params 2, eflags: 0x0
// Checksum 0x60d35b22, Offset: 0xad8
// Size: 0x84
function function_84fd1f52(grenade, weapon) {
    grenade endon(#"death");
    grenade waittill(#"stationary");
    self function_17fd3502(grenade.origin, grenade.angles);
    grenade delete();
}

// Namespace seeker_mine_mp/seeker_mine
// Params 2, eflags: 0x0
// Checksum 0xf1b0e3a4, Offset: 0xb68
// Size: 0x374
function function_17fd3502(origin, angles) {
    originalowner = self;
    originalownerentnum = originalowner.entnum;
    mine = spawnvehicle("veh_seeker_mine_mp", origin, angles, "dynamic_spawn_ai");
    mine.arcweapon = getweapon("seeker_mine_arc");
    mine.weapon = getweapon("eq_seeker_mine");
    mine setweapon(mine.weapon);
    mine.var_6eca641d = &function_9e4b2245;
    mine.var_6d47bbe8 = &function_6168afd3;
    mine.var_3582f3a5 = &cleartarget;
    mine.var_4a1352fc = 0;
    mine.var_b0c1f126 = getweapon(#"eq_seeker_mine").var_b0c1f126;
    mine.var_1a880ac7 = &function_c4d5a729;
    mine.var_c0cd58ea = 1;
    if (!isdefined(mine)) {
        return;
    }
    if (isdefined(level.var_8e75a9aa)) {
        mine thread [[ level.var_8e75a9aa ]](self);
    }
    if (!isdefined(level.seeker_mine[originalownerentnum].mines)) {
        level.seeker_mine[originalownerentnum].mines = [];
    } else if (!isarray(level.seeker_mine[originalownerentnum].mines)) {
        level.seeker_mine[originalownerentnum].mines = array(level.seeker_mine[originalownerentnum].mines);
    }
    level.seeker_mine[originalownerentnum].mines[level.seeker_mine[originalownerentnum].mines.size] = mine;
    mine killstreaks::configure_team("raps", "raps", originalowner, undefined, undefined, &configureteampost);
    mine clientfield::set("enemyvehicle", 1);
    mine setinvisibletoall();
    mine thread autosetvisibletoall();
    mine playsound("mpl_seeker_mine_activate");
    mine vehicle::toggle_sounds(1);
    mine thread function_7aa99140(originalowner);
    mine thread watchabandoned();
}

// Namespace seeker_mine_mp/seeker_mine
// Params 1, eflags: 0x0
// Checksum 0x5a5a54a7, Offset: 0xee8
// Size: 0x48
function function_c4d5a729(target) {
    if (isplayer(target) && target isgrappling()) {
        return false;
    }
    return true;
}

// Namespace seeker_mine_mp/seeker_mine
// Params 0, eflags: 0x0
// Checksum 0x92556ac8, Offset: 0xf38
// Size: 0xda
function watchabandoned() {
    self endon(#"death");
    while (true) {
        if (!isdefined(self.owner) || !isdefined(self.owner.team) || self.owner.team != self.team || !self.owner hasweapon(level.var_888baf22.weapon)) {
            self notify(#"abandoned");
            self.abandoned = 1;
            self function_9d24198b();
            break;
        }
        waitframe(1);
    }
}

// Namespace seeker_mine_mp/seeker_mine
// Params 2, eflags: 0x0
// Checksum 0xba97899a, Offset: 0x1020
// Size: 0x34
function configureteampost(owner, ishacked) {
    mine = self;
    mine thread function_3513e6c8();
}

// Namespace seeker_mine_mp/seeker_mine
// Params 0, eflags: 0x0
// Checksum 0x84e51ae3, Offset: 0x1060
// Size: 0x3c
function autosetvisibletoall() {
    self endon(#"death");
    waitframe(1);
    waitframe(1);
    self setvisibletoall();
}

// Namespace seeker_mine_mp/seeker_mine
// Params 1, eflags: 0x0
// Checksum 0xe24b9cad, Offset: 0x10a8
// Size: 0x1b4
function function_7aa99140(originalowner) {
    originalownerentnum = originalowner.entnum;
    waitresult = self waittill(#"death");
    attacker = waitresult.attacker;
    weapon = waitresult.weapon;
    attacker = self [[ level.figure_out_attacker ]](attacker);
    if (isdefined(attacker) && isplayer(attacker)) {
        if (isdefined(self.owner) && self.owner != attacker && self.owner.team != attacker.team) {
            self.owner globallogic_score::function_a63adb85(attacker, weapon, level.var_888baf22.weapon);
            attacker challenges::destroyscorestreak(weapon, 1);
            attacker challenges::function_90c432bd(weapon);
        }
        if (isdefined(level.var_b31e16d4)) {
            self [[ level.var_b31e16d4 ]](attacker, self.owner, self.arcweapon, weapon);
        }
    }
    arrayremovevalue(level.seeker_mine[originalownerentnum].mines, self);
}

// Namespace seeker_mine_mp/seeker_mine
// Params 2, eflags: 0x0
// Checksum 0x50e17018, Offset: 0x1268
// Size: 0xd8
function function_a7e8406d(entnum, abandoned = 0) {
    foreach (mine in level.seeker_mine[entnum].mines) {
        if (isalive(mine)) {
            mine.owner = undefined;
            mine.abandoned = abandoned;
            mine function_9d24198b();
        }
    }
}

// Namespace seeker_mine_mp/seeker_mine
// Params 0, eflags: 0x0
// Checksum 0xe31f4309, Offset: 0x1348
// Size: 0x84
function function_3513e6c8() {
    mine = self;
    preset = getinfluencerpreset("raps");
    if (!isdefined(preset)) {
        return;
    }
    enemy_team_mask = mine influencers::get_enemy_team_mask(mine.team);
    mine influencers::create_entity_influencer("raps", enemy_team_mask);
}

// Namespace seeker_mine_mp/seeker_mine
// Params 0, eflags: 0x0
// Checksum 0xb14e2e46, Offset: 0x13d8
// Size: 0xc8
function function_7b1e31b3() {
    name = "tag_shocker_";
    dir = "l";
    if (randomfloat(1) < 0.5) {
        dir = "r";
    }
    count = "_0" + randomint(4) + 1;
    suffix = "_fx";
    tag = name + dir + count + suffix;
    return tag;
}

// Namespace seeker_mine_mp/seeker_mine
// Params 0, eflags: 0x4
// Checksum 0x18d32b63, Offset: 0x14a8
// Size: 0xc8
function private shock_rumble_loop() {
    self notify(#"shock_rumble_loop");
    self endon(#"shock_rumble_loop");
    self endon(#"death");
    self endon(#"disconnect");
    waitframe(1);
    if (!isplayer(self)) {
        return;
    }
    while (isdefined(self) && (isdefined(self.var_40726073.isshocked) ? self.var_40726073.isshocked : 0)) {
        self playrumbleonentity("shock_rumble");
        wait 0.1;
    }
}

// Namespace seeker_mine_mp/seeker_mine
// Params 1, eflags: 0x0
// Checksum 0x333df912, Offset: 0x1578
// Size: 0x274
function function_9e4b2245(target) {
    if (self.var_4a1352fc >= 3) {
        scoreevents::processscoreevent(#"hash_4c3a3c0de382362f", self.owner, target, self.arcweapon);
    }
    if (isdefined(self.owner)) {
        if (target status_effect::function_508e1a13(5) > 0) {
            self.owner damagefeedback::update(undefined, undefined, "resistance");
        } else {
            self.owner util::show_hit_marker(0, 1);
        }
    }
    target.var_40726073.state = 0;
    target.var_8236e828 = self.owner;
    target.var_4243ae4 = self.arcweapon;
    target freezecontrolsallowlook(1);
    target allowjump(0);
    target allowmelee(0);
    target thread shock_rumble_loop();
    self.var_4a1352fc++;
    target clientfield::set("seeker_mine_shock", 1);
    self thread function_c4da6d59(target, "j_spineupper", (0, 0, 10), 0);
    tag = "tag_origin";
    pos = (0, 0, target getplayerviewheight() - 10);
    forward = anglestoforward(target.angles);
    pos -= forward * 5;
    self thread function_c4da6d59(target, tag, pos, 1);
    target thread watchtargetdeath(self);
}

// Namespace seeker_mine_mp/seeker_mine
// Params 4, eflags: 0x0
// Checksum 0xb538c73b, Offset: 0x17f8
// Size: 0x26c
function function_c4da6d59(target, tag, offset, var_be77715e) {
    self endon(#"death");
    target endon(#"death");
    util::wait_network_frame();
    tagfx = function_7b1e31b3();
    tagpos = self gettagorigin(tagfx);
    if (!isdefined(tagpos)) {
        return;
    }
    pos = target gettagorigin(tag);
    pos += offset;
    var_c4598f48 = spawn("script_model", pos);
    var_c4598f48 setmodel("tag_origin");
    beam = beamlaunch(self, var_c4598f48, tagfx, "tag_origin", self.arcweapon);
    if (var_be77715e) {
        var_c4598f48 setinvisibletoall();
        var_c4598f48 setvisibletoplayer(target);
        if (isdefined(beam)) {
            beam setinvisibletoall();
            beam setvisibletoplayer(target);
        }
    } else {
        var_c4598f48 setinvisibletoplayer(target);
        if (isdefined(beam)) {
            beam setinvisibletoplayer(target);
        }
    }
    var_c4598f48 thread function_51500d4a(target, tag, offset, tagpos, self);
    level thread function_865cf27(var_c4598f48);
    target thread function_727121d7(var_c4598f48);
    self thread function_727121d7(var_c4598f48);
}

// Namespace seeker_mine_mp/seeker_mine
// Params 5, eflags: 0x0
// Checksum 0x9833744, Offset: 0x1a70
// Size: 0x19e
function function_51500d4a(target, tag, offset, tagpos, seekermine) {
    seekermine endon(#"death");
    self endon(#"death");
    target endon(#"death");
    self clientfield::set("seeker_mine_fx", 1);
    while (true) {
        pos = target gettagorigin(tag);
        pos += offset;
        self.origin = pos;
        dir = pos - tagpos;
        dir = vectornormalize(dir);
        self.angles = vectortoangles(dir);
        if (isdefined(target.var_40726073.state) && (target.var_40726073.state == 4 || target.var_40726073.state == 2)) {
            self clientfield::set("seeker_mine_fx", 2);
        }
        waitframe(1);
    }
}

// Namespace seeker_mine_mp/seeker_mine
// Params 1, eflags: 0x0
// Checksum 0x2f6853f1, Offset: 0x1c18
// Size: 0x164
function watchtargetdeath(seekermine) {
    seekermine endon(#"death");
    params = self waittill(#"death");
    var_595f6ea7 = isdefined(params.attacker) && isplayer(params.attacker) && isdefined(seekermine.owner) && seekermine.owner == params.attacker;
    if (isdefined(params.mod) && params.mod == "MOD_HEAD_SHOT" && var_595f6ea7) {
        scoreevents::processscoreevent(#"seeker_shock_mine_paralyzed_headshot", seekermine.owner, self, params.weapon);
        seekermine.owner globallogic_score::specialistmedalachievement(level.var_888baf22.weapon, undefined);
    }
    wait 2;
    if (isdefined(seekermine)) {
        seekermine function_9d24198b();
    }
}

// Namespace seeker_mine_mp/seeker_mine
// Params 1, eflags: 0x0
// Checksum 0x634279cc, Offset: 0x1d88
// Size: 0x6c
function function_727121d7(var_c4598f48) {
    var_c4598f48 endon(#"death");
    self waittill(#"death");
    if (isdefined(var_c4598f48)) {
        var_c4598f48 delete();
        self.seeker_fx delete();
    }
}

// Namespace seeker_mine_mp/seeker_mine
// Params 1, eflags: 0x0
// Checksum 0x3e7bf8ee, Offset: 0x1e00
// Size: 0x44
function function_865cf27(var_c4598f48) {
    var_c4598f48 endon(#"death");
    wait 11;
    if (isdefined(var_c4598f48)) {
        var_c4598f48 delete();
    }
}

// Namespace seeker_mine_mp/seeker_mine
// Params 3, eflags: 0x0
// Checksum 0xd108963c, Offset: 0x1e50
// Size: 0xbe
function function_6168afd3(var_3c0b4194, arcsource, depth) {
    /#
        if (isgodmode(self)) {
            return 0;
        }
    #/
    if (isplayer(self)) {
        self function_15242077(var_3c0b4194, arcsource);
        function_60fcf7b0(level.var_888baf22.tunables.var_fcf66d43, arcsource.arcweapon, arcsource.owner);
        return self.seeker_mine_se.var_804bc9d5;
    }
    return 0;
}

// Namespace seeker_mine_mp/seeker_mine
// Params 3, eflags: 0x0
// Checksum 0x1351482f, Offset: 0x1f18
// Size: 0xac
function function_60fcf7b0(effect, weapon, owner) {
    if (isdefined(self.seeker_mine_se)) {
        self status_effect::function_280d8ac0(self.seeker_mine_se.setype, self.seeker_mine_se.var_d20b8ed2);
        self.seeker_mine_se = undefined;
    }
    if (isdefined(effect)) {
        self.seeker_mine_se = getstatuseffect(effect);
        self status_effect::status_effect_apply(self.seeker_mine_se, weapon, owner);
    }
}

// Namespace seeker_mine_mp/seeker_mine
// Params 3, eflags: 0x0
// Checksum 0xe179e839, Offset: 0x1fd0
// Size: 0x114
function cleartarget(target, var_3c0b4194, seekermine) {
    function_60fcf7b0();
    target freezecontrolsallowlook(0);
    target setviewclamp(0, 0, 0, 0);
    target allowjump(1);
    target allowmelee(1);
    target stoprumble("shock_rumble");
    target clientfield::set("seeker_mine_shock", 0);
    if (isdefined(target.var_40726073)) {
        target.var_40726073.isshocked = 0;
    }
    if (isdefined(seekermine)) {
        seekermine function_9d24198b();
    }
}

// Namespace seeker_mine_mp/seeker_mine
// Params 0, eflags: 0x0
// Checksum 0x3b8a06e0, Offset: 0x20f0
// Size: 0x3c
function function_9d24198b() {
    self seeker_mine::function_9d24198b();
    self clientfield::set("enemyvehicle", 0);
}

// Namespace seeker_mine_mp/seeker_mine
// Params 2, eflags: 0x0
// Checksum 0x77efdb7e, Offset: 0x2138
// Size: 0x134
function function_15242077(var_3c0b4194, seekermine) {
    self.var_40726073.state = 0;
    self.var_40726073.prompt = 0;
    self.var_40726073.isshocked = 1;
    self thread function_2ef56bc1(undefined, "gestable_shocked_reaction", level.var_888baf22.tunables.var_99e0abb0 + level.var_888baf22.tunables.var_c14f4a9e, 1);
    self.seekermine = seekermine;
    self.var_6fb89b03 = var_3c0b4194;
    self thread function_5c30818b(seekermine, var_3c0b4194);
    self thread function_43d30df7();
    self thread function_b4041ed5();
    self thread function_a06cde26();
    self thread function_de9cd53a(var_3c0b4194, seekermine);
}

// Namespace seeker_mine_mp/seeker_mine
// Params 2, eflags: 0x0
// Checksum 0x29911abc, Offset: 0x2278
// Size: 0x74
function function_5c30818b(seekermine, var_3c0b4194) {
    self endon(#"death");
    seekermine waittill(#"death");
    self notify(#"hash_11759ff8ab95f65c");
    self notify(#"seekermine_minigame_complete");
    function_88757c6(seekermine, var_3c0b4194);
}

// Namespace seeker_mine_mp/seeker_mine
// Params 1, eflags: 0x0
// Checksum 0xb1f17690, Offset: 0x22f8
// Size: 0x7c
function function_6749f1af(time) {
    self waittilltimeout(time, #"death");
    if (!isdefined(self)) {
        return;
    }
    if (level.var_888baf22.prompt seeker_mine_prompt::is_open(self)) {
        level.var_888baf22.prompt seeker_mine_prompt::close(self);
    }
}

// Namespace seeker_mine_mp/seeker_mine
// Params 0, eflags: 0x0
// Checksum 0x3f387f0b, Offset: 0x2380
// Size: 0x1a2
function function_b4041ed5() {
    self endon(#"death");
    self endon(#"seekermine_minigame_complete");
    level.var_888baf22.prompt seeker_mine_prompt::open(self, 0);
    self thread function_6749f1af(level.var_888baf22.tunables.var_99e0abb0);
    wait level.var_888baf22.tunables.var_dd3764a5;
    self.var_40726073.prompt = 1;
    if (self status_effect::function_508e1a13(5) > 0) {
        return;
    }
    self thread function_f1839d41();
    wait level.var_888baf22.tunables.var_23d9416c;
    self.var_40726073.prompt = 2;
    self.var_40726073.var_31b6b9d1 = gettime();
    wait level.var_888baf22.tunables.var_258738ca;
    wait level.var_888baf22.tunables.var_92b8c5e7;
    self.var_40726073.prompt = 0;
    wait level.var_888baf22.tunables.var_f44d7dda;
    self notify(#"hash_13bc4f053f8da5b0");
    self.var_40726073.prompt = 3;
}

// Namespace seeker_mine_mp/seeker_mine
// Params 0, eflags: 0x0
// Checksum 0x863e7fc, Offset: 0x2530
// Size: 0xc4
function function_f1839d41() {
    self endon(#"death", #"seekermine_minigame_complete");
    waittime = level.var_888baf22.tunables.var_23d9416c * 1000;
    starttime = gettime();
    do {
        progress = (gettime() - starttime) / waittime;
        level.var_888baf22.prompt seeker_mine_prompt::set_progress(self, 1 - progress);
        waitframe(1);
    } while (progress < 1.2);
}

// Namespace seeker_mine_mp/seeker_mine
// Params 0, eflags: 0x0
// Checksum 0xbdc5d163, Offset: 0x2600
// Size: 0x3e
function function_a06cde26() {
    self endon(#"death");
    while (isdefined(self.seekermine)) {
        waitframe(1);
    }
    self notify(#"hash_89051c7805b3d19");
}

// Namespace seeker_mine_mp/seeker_mine
// Params 0, eflags: 0x0
// Checksum 0x617cfc56, Offset: 0x2648
// Size: 0x266
function function_43d30df7() {
    self endon(#"death");
    var_17abcca7 = self usebuttonpressed();
    while (self.var_40726073.prompt < 3) {
        pressed = self usebuttonpressed();
        if (var_17abcca7) {
            if (!pressed) {
                var_17abcca7 = 0;
            }
        } else if (self status_effect::function_508e1a13(5) > 0 && self.var_40726073.prompt == 1) {
            self.var_40726073.state = 1;
            break;
        } else if (pressed) {
            if (self.var_40726073.prompt == 1) {
                self.var_40726073.state = 1;
            } else if (self.var_40726073.prompt == 2) {
                lastservertime = self function_b8a19341();
                if (lastservertime < self.var_40726073.var_31b6b9d1) {
                    self.var_40726073.state = 1;
                } else {
                    self.var_40726073.state = 2;
                }
            } else {
                self.var_40726073.state = 2;
            }
            break;
        }
        level.var_888baf22.prompt seeker_mine_prompt::set_promptstate(self, self.var_40726073.state);
        waitframe(1);
    }
    if (self.var_40726073.state == 0) {
        self.var_40726073.state = 4;
    }
    level.var_888baf22.prompt seeker_mine_prompt::set_promptstate(self, self.var_40726073.state);
    self notify(#"seekermine_minigame_complete");
}

// Namespace seeker_mine_mp/seeker_mine
// Params 2, eflags: 0x0
// Checksum 0xe4688513, Offset: 0x28b8
// Size: 0x48c
function function_de9cd53a(var_3c0b4194, seekermine) {
    self endon(#"hash_11759ff8ab95f65c");
    waitresult = self waittill(#"seekermine_minigame_complete", #"death");
    if (waitresult._notify == "death") {
        return;
    }
    self notify(#"hash_13bc4f053f8da5b0");
    gesturetable = "gestable_shocked_reaction";
    var_bcf2c409 = undefined;
    waitduration = 0;
    islooping = 1;
    if (!isdefined(seekermine)) {
        self.var_40726073.state = 3;
    }
    switch (self.var_40726073.state) {
    case 4:
        waitduration = level.var_888baf22.tunables.var_c14f4a9e;
        println("<dev string:x30>");
        self playsoundtoplayer("uin_seeker_qte_fail", self);
        if (isdefined(level.var_888baf22.tunables.var_4596aa8e)) {
            self playrumbleonentity(level.var_888baf22.tunables.var_4596aa8e);
        }
        self battlechatter::pain_vox("MOD_ELECTROCUTED", self.arcweapon);
        break;
    case 1:
        gesturetable = "gestable_shocked_success";
        var_bcf2c409 = getweapon(#"hash_597ead6ff2ce9284");
        islooping = 0;
        self playsoundtoplayer("uin_seeker_qte_success", self);
        function_60fcf7b0(level.var_888baf22.tunables.var_d316a9da, seekermine.arcweapon, seekermine.owner);
        println("<dev string:x4f>");
        break;
    case 2:
        waitduration = level.var_888baf22.tunables.var_f8706001;
        gesturetable = "gestable_shocked_fail";
        self playsoundtoplayer("uin_seeker_qte_fail", self);
        self battlechatter::pain_vox("MOD_ELECTROCUTED", self.arcweapon);
        function_60fcf7b0(level.var_888baf22.tunables.var_ace0e52d, seekermine.arcweapon, seekermine.owner);
        println("<dev string:x6a>");
        break;
    case 3:
        gesturetable = "gestable_shocked_success";
        var_bcf2c409 = getweapon(#"hash_597ead6ff2ce9284");
        islooping = 0;
        self playsoundtoplayer("uin_seeker_qte_success", self);
        println("<dev string:x84>");
        break;
    default:
        assert(0);
        break;
    }
    self thread function_2ef56bc1(var_bcf2c409, gesturetable, waitduration, islooping);
    self thread function_505a4a0(seekermine, waitduration, var_3c0b4194);
}

// Namespace seeker_mine_mp/seeker_mine
// Params 3, eflags: 0x0
// Checksum 0x87fdd4aa, Offset: 0x2d50
// Size: 0xb4
function function_505a4a0(seekermine, waitduration, var_3c0b4194) {
    self notify("7ec4bdf3fb6f7b1d");
    self endon("7ec4bdf3fb6f7b1d");
    self endon(#"death");
    self waittilltimeout(waitduration, #"hash_89051c7805b3d19");
    thread function_2ef56bc1(undefined, undefined, 0, 0);
    wait level.var_888baf22.tunables.var_ac6e5309;
    cleartarget(self, var_3c0b4194, seekermine);
}

// Namespace seeker_mine_mp/seeker_mine
// Params 2, eflags: 0x0
// Checksum 0x88ce8c2c, Offset: 0x2e10
// Size: 0x5c
function function_88757c6(seekermine, var_3c0b4194) {
    level.var_888baf22.prompt seeker_mine_prompt::close(self);
    self function_505a4a0(seekermine, 0, var_3c0b4194);
}

// Namespace seeker_mine_mp/seeker_mine
// Params 4, eflags: 0x0
// Checksum 0xc6ae894d, Offset: 0x2e78
// Size: 0x2ca
function function_2ef56bc1(var_bcf2c409, gesturetable, waitduration, islooping) {
    self notify("218e784b6df21349");
    self endon("218e784b6df21349");
    self endon(#"death");
    if (isdefined(var_bcf2c409) && var_bcf2c409 == level.weaponnone) {
        var_bcf2c409 = undefined;
    }
    if (isdefined(gesturetable)) {
        newgesture = self gestures::function_ce8466b6(gesturetable);
    }
    if (isdefined(self.var_40726073.gesture) && (isdefined(var_bcf2c409) || isdefined(newgesture) && newgesture != self.var_40726073.gesture)) {
        self stopgestureviewmodel(self.var_40726073.gesture, 50, 1);
        self.var_40726073.gesture = undefined;
        self.var_40726073.islooping = undefined;
    }
    if (isdefined(var_bcf2c409) && var_bcf2c409 != getweapon(#"none")) {
        self.var_40726073.gesture = undefined;
        self.var_40726073.islooping = undefined;
        self giveandfireoffhand(var_bcf2c409);
    } else if (isdefined(newgesture)) {
        while (isdefined(self.var_40726073.isshocked) ? self.var_40726073.isshocked : 0) {
            if (self gestures::play_gesture(newgesture, undefined, 1)) {
                self.var_40726073.gesture = newgesture;
                self.var_40726073.islooping = islooping;
                break;
            }
            waitframe(1);
        }
    }
    if (isdefined(self.var_40726073.islooping) && self.var_40726073.islooping) {
        self waittilltimeout(waitduration, #"hash_89051c7805b3d19");
        if (isdefined(self) && isdefined(self.var_40726073.gesture)) {
            self stopgestureviewmodel(self.var_40726073.gesture, 0, 0);
            self.var_40726073.gesture = undefined;
            self.var_40726073.islooping = undefined;
        }
    }
}

