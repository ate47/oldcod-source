#using scripts\core_common\bb_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;

#namespace bb;

// Namespace bb/bb
// Params 0, eflags: 0x2
// Checksum 0xe155d8b5, Offset: 0xa0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"bb", &__init__, undefined, undefined);
}

// Namespace bb/bb
// Params 0, eflags: 0x0
// Checksum 0x8940c33a, Offset: 0xe8
// Size: 0x34
function __init__() {
    init_shared();
    callback::on_spawned(&on_player_spawned);
}

// Namespace bb/bb
// Params 0, eflags: 0x0
// Checksum 0x36c8f752, Offset: 0x128
// Size: 0xa4
function on_player_spawned() {
    self._bbdata = [];
    self._bbdata[#"score"] = 0;
    self._bbdata[#"momentum"] = 0;
    self._bbdata[#"spawntime"] = gettime();
    self._bbdata[#"shots"] = 0;
    self._bbdata[#"hits"] = 0;
    callback::on_death(&on_player_death);
}

// Namespace bb/bb
// Params 1, eflags: 0x0
// Checksum 0x1784cf67, Offset: 0x1d8
// Size: 0x2cc
function function_a4648ef4(gamemodedata) {
    matchtime = (isdefined(level.var_a033439c.roundend) ? level.var_a033439c.roundend : 0) - (isdefined(level.var_a033439c.roundstart) ? level.var_a033439c.roundstart : 0);
    firstblood = (isdefined(level.var_a033439c.firstblood) ? level.var_a033439c.firstblood : 0) - (isdefined(level.var_a033439c.roundstart) ? level.var_a033439c.roundstart : 0);
    alliesscore = isdefined([[ level._getteamscore ]](#"allies")) ? [[ level._getteamscore ]](#"allies") : 0;
    axisscore = isdefined([[ level._getteamscore ]](#"axis")) ? [[ level._getteamscore ]](#"axis") : 0;
    var_ac57d34e = abs(alliesscore - axisscore);
    gamemodedata = {};
    gamemodedata.gamemode = level.gametype;
    gamemodedata.wintype = isdefined(gamemodedata.wintype) ? gamemodedata.wintype : "NA";
    gamemodedata.matchtime = matchtime;
    gamemodedata.firstblood = firstblood;
    gamemodedata.var_ac57d34e = var_ac57d34e;
    gamemodedata.timeremaining = isdefined(gamemodedata.remainingtime) ? gamemodedata.remainingtime : 0;
    gamemodedata.var_3cb5bfaa = isdefined(gamemodedata.var_3cb5bfaa) ? gamemodedata.var_3cb5bfaa : 0;
    gamemodedata.var_f3a584bb = isdefined(gamemodedata.var_f3a584bb) ? gamemodedata.var_f3a584bb : 0;
    function_b1f6086c(#"hash_1a63efe7c6121b24", gamemodedata);
}

// Namespace bb/bb
// Params 4, eflags: 0x0
// Checksum 0xa3756ee9, Offset: 0x4b0
// Size: 0xe4
function function_9cca214a(var_3561beab, label, team, origin) {
    function_b1f6086c(#"hash_d424efe4db1dff7", {#gametime:function_25e96038(), #objtype:var_3561beab, #label:label, #team:team, #playerx:origin[0], #playery:origin[1], #playerz:origin[2]});
}

// Namespace bb/bb
// Params 14, eflags: 0x0
// Checksum 0x55c053b2, Offset: 0x5a0
// Size: 0x234
function function_2384c738(eattacker, attackerorigin, attackerspecialist, attackerweapon, evictim, victimorigin, victimspecialist, victimweapon, idamage, smeansofdeath, shitloc, death, isusingheropower, killstreak) {
    mpattacks = {};
    mpattacks.gametime = function_25e96038();
    if (isdefined(eattacker)) {
        mpattacks.attackerspawnid = getplayerspawnid(eattacker);
    }
    if (isdefined(attackerorigin)) {
        mpattacks.attackerx = attackerorigin[0];
        mpattacks.attackery = attackerorigin[1];
        mpattacks.attackerz = attackerorigin[2];
    }
    mpattacks.attackerspecialist = attackerspecialist;
    mpattacks.attackerweapon = attackerweapon;
    if (isdefined(evictim)) {
        mpattacks.victimspawnid = getplayerspawnid(evictim);
    }
    if (isdefined(victimorigin)) {
        mpattacks.victimx = victimorigin[0];
        mpattacks.victimy = victimorigin[1];
        mpattacks.victimz = victimorigin[2];
    }
    mpattacks.victimspecialist = victimspecialist;
    mpattacks.victimweapon = victimweapon;
    mpattacks.damage = idamage;
    mpattacks.damagetype = smeansofdeath;
    mpattacks.damagelocation = shitloc;
    mpattacks.death = death;
    mpattacks.isusingheropower = isusingheropower;
    mpattacks.killstreak = killstreak;
    function_b1f6086c(#"hash_67e3a427b7ec1819", mpattacks);
}

// Namespace bb/bb
// Params 1, eflags: 0x0
// Checksum 0x34094d5, Offset: 0x7e0
// Size: 0x54
function on_player_death(params) {
    if (isbot(self)) {
        return;
    }
    if (game.state == "playing") {
        self commit_spawn_data();
    }
}

// Namespace bb/bb
// Params 0, eflags: 0x0
// Checksum 0x898f2e22, Offset: 0x840
// Size: 0x664
function function_d2e9b6c2() {
    if (isbot(self)) {
        return;
    }
    assert(isdefined(self._bbdata));
    if (!isdefined(self.class_num)) {
        return;
    }
    mploadout = spawnstruct();
    mploadout.gametime = function_25e96038();
    mploadout.spawnid = getplayerspawnid(self);
    primaryweapon = self getloadoutweapon(self.class_num, "primary");
    mploadout.primary = primaryweapon.name;
    primaryattachments = function_753291e4(primaryweapon);
    mploadout.primaryattachment1 = primaryattachments.attachment0;
    mploadout.primaryattachment2 = primaryattachments.attachment1;
    mploadout.primaryattachment3 = primaryattachments.attachment2;
    mploadout.primaryattachment4 = primaryattachments.attachment3;
    mploadout.primaryattachment5 = primaryattachments.attachment4;
    mploadout.primaryreticle = hash(self getweaponoptic(primaryweapon));
    secondaryweapon = self getloadoutweapon(self.class_num, "secondary");
    mploadout.secondary = secondaryweapon.name;
    secondaryattachments = function_753291e4(secondaryweapon);
    mploadout.secondaryattachment1 = secondaryattachments.attachment0;
    mploadout.secondaryattachment2 = secondaryattachments.attachment1;
    mploadout.secondaryattachment3 = secondaryattachments.attachment2;
    mploadout.secondaryattachment4 = secondaryattachments.attachment3;
    mploadout.secondaryattachment5 = secondaryattachments.attachment4;
    mploadout.secondaryreticle = hash(self getweaponoptic(secondaryweapon));
    mploadout.tacticalgear = self function_5e761013(self.class_num);
    mploadout.killstreak1 = self.killstreak.size < 0 ? 0 : hash(self.killstreak[0]);
    mploadout.killstreak2 = self.killstreak.size < 1 ? 0 : hash(self.killstreak[1]);
    mploadout.killstreak3 = self.killstreak.size < 2 ? 0 : hash(self.killstreak[2]);
    talents = self function_c7acb07a(self.class_num);
    mploadout.var_fbdf5321 = talents.size < 0 ? 0 : talents[0];
    mploadout.talent1 = talents.size < 1 ? 0 : talents[1];
    mploadout.talent2 = talents.size < 2 ? 0 : talents[2];
    mploadout.talent3 = talents.size < 3 ? 0 : talents[3];
    mploadout.talent4 = talents.size < 4 ? 0 : talents[4];
    mploadout.talent5 = talents.size < 5 ? 0 : talents[5];
    wildcards = self function_7579fbae(self.class_num);
    mploadout.wildcard0 = wildcards.size < 0 ? 0 : wildcards[0];
    mploadout.wildcard1 = wildcards.size < 1 ? 0 : wildcards[1];
    mploadout.var_364dc627 = wildcards.size < 2 ? 0 : wildcards[2];
    if (isdefined(self.playerrole) && isdefined(self.playerrole.var_4c698c3d)) {
        var_cd1039e4 = getweapon(isdefined(self.playerrole.var_4c698c3d) ? self.playerrole.var_4c698c3d : level.weaponnone);
    } else {
        var_cd1039e4 = level.weaponnone;
    }
    mploadout.var_d0689f28 = var_cd1039e4.name;
    mploadout.specialistindex = isdefined(self getspecialistindex()) ? self getspecialistindex() : -1;
    function_b1f6086c(#"hash_30b542620e21966d", #"mploadouts", mploadout);
}

// Namespace bb/bb
// Params 0, eflags: 0x0
// Checksum 0xf2230110, Offset: 0xeb0
// Size: 0x1c4
function commit_spawn_data() {
    if (isbot(self)) {
        return;
    }
    assert(isdefined(self._bbdata));
    if (!isdefined(self._bbdata)) {
        return;
    }
    specialistindex = isdefined(self getspecialistindex()) ? self getspecialistindex() : -1;
    mpplayerlives = {#gametime:function_25e96038(), #spawnid:getplayerspawnid(self), #lifescore:self._bbdata[#"score"], #lifemomentum:self._bbdata[#"momentum"], #lifetime:gettime() - self._bbdata[#"spawntime"], #name:self.name, #specialist:specialistindex};
    function_b1f6086c(#"hash_6fc210ad5f081ce8", mpplayerlives);
    self function_d2e9b6c2();
}

// Namespace bb/bb
// Params 1, eflags: 0x0
// Checksum 0x956da002, Offset: 0x1080
// Size: 0x2b2
function function_753291e4(weapon) {
    var_79a4fa1d = spawnstruct();
    var_79a4fa1d.attachment0 = 0;
    var_79a4fa1d.attachment1 = 0;
    var_79a4fa1d.attachment2 = 0;
    var_79a4fa1d.attachment3 = 0;
    var_79a4fa1d.attachment4 = 0;
    var_79a4fa1d.attachment5 = 0;
    var_79a4fa1d.attachment6 = 0;
    if (!isdefined(weapon) || weapon.attachments.size == 0) {
        return var_79a4fa1d;
    }
    var_79a4fa1d.attachment0 = hash(weapon.attachments[0]);
    if (weapon.attachments.size == 1) {
        return var_79a4fa1d;
    }
    var_79a4fa1d.attachment1 = hash(weapon.attachments[1]);
    if (weapon.attachments.size == 2) {
        return var_79a4fa1d;
    }
    var_79a4fa1d.attachment2 = hash(weapon.attachments[2]);
    if (weapon.attachments.size == 3) {
        return var_79a4fa1d;
    }
    var_79a4fa1d.attachment3 = hash(weapon.attachments[3]);
    if (weapon.attachments.size == 4) {
        return var_79a4fa1d;
    }
    var_79a4fa1d.attachment4 = hash(weapon.attachments[4]);
    if (weapon.attachments.size == 5) {
        return var_79a4fa1d;
    }
    var_79a4fa1d.attachment5 = hash(weapon.attachments[5]);
    if (weapon.attachments.size == 6) {
        return var_79a4fa1d;
    }
    var_79a4fa1d.attachment6 = hash(weapon.attachments[6]);
    return var_79a4fa1d;
}

