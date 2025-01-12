#using scripts\core_common\ai\systems\destructible_character;
#using scripts\core_common\ai\systems\shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\throttle_shared;

#namespace gib;

// Namespace gib/gib
// Params 0, eflags: 0x2
// Checksum 0xc43eca81, Offset: 0x180
// Size: 0xb8
function autoexec main() {
    clientfield::register("actor", "gib_state", 1, 9, "int");
    clientfield::register("playercorpse", "gib_state", 1, 15, "int");
    level.var_2c09fea0 = [];
    if (!isdefined(level.gib_throttle)) {
        level.gib_throttle = new throttle();
        [[ level.gib_throttle ]]->initialize(2, 0.2);
    }
}

#namespace gibserverutils;

// Namespace gibserverutils/gib
// Params 2, eflags: 0x4
// Checksum 0xc26e3e8c, Offset: 0x240
// Size: 0x32e
function private function_5e68b448(name, entity) {
    gibdef = level.var_2c09fea0[name];
    if (isdefined(gibdef)) {
        return gibdef;
    }
    var_19c51405 = struct::get_script_bundles("gibcharacterdef");
    if (!isdefined(var_19c51405) || !isdefined(name)) {
        return undefined;
    }
    definition = var_19c51405[name];
    if (!isdefined(definition)) {
        assertmsg("<dev string:x30>" + name);
        return undefined;
    }
    gibpiecelookup = [];
    gibpiecelookup[2] = "annihilate";
    gibpiecelookup[8] = "head";
    gibpiecelookup[16] = "rightarm";
    gibpiecelookup[32] = "leftarm";
    gibpiecelookup[128] = "rightleg";
    gibpiecelookup[256] = "leftleg";
    gibpieces = [];
    foreach (gibflag, gibpiece in gibpiecelookup) {
        if (!isdefined(gibpiece)) {
            assertmsg("<dev string:x4e>" + gibflag);
            continue;
        }
        gibstruct = spawnstruct();
        gibstruct.gibmodel = definition.(gibpiece + "_gibmodel");
        gibstruct.gibtag = definition.(gibpiece + "_gibtag");
        gibstruct.gibfx = definition.(gibpiece + "_gibfx");
        gibstruct.gibfxtag = definition.(gibpiece + "_gibeffecttag");
        gibstruct.gibdynentfx = definition.(gibpiece + "_gibdynentfx");
        gibstruct.var_37031286 = definition.(gibpiece + "_gibcinematicfx");
        gibstruct.gibsound = definition.(gibpiece + "_gibsound");
        gibstruct.gibhidetag = definition.(gibpiece + "_gibhidetag");
        gibpieces[gibflag] = gibstruct;
    }
    level.var_2c09fea0[name] = gibpieces;
    return gibpieces;
}

// Namespace gibserverutils/gib
// Params 3, eflags: 0x4
// Checksum 0xa44c62ad, Offset: 0x578
// Size: 0x48
function private function_9893c890(name, gibflag, entity) {
    gibpieces = function_5e68b448(name, entity);
    return gibpieces[gibflag];
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x4
// Checksum 0x17a18e81, Offset: 0x5c8
// Size: 0x2c
function private _annihilate(entity) {
    if (isdefined(entity)) {
        entity notsolid();
    }
}

// Namespace gibserverutils/gib
// Params 2, eflags: 0x4
// Checksum 0x59fdd22d, Offset: 0x600
// Size: 0xc4
function private _getgibextramodel(entity, gibflag) {
    if (gibflag == 4) {
        return (isdefined(entity.gib_data) ? entity.gib_data.hatmodel : entity.hatmodel);
    }
    if (gibflag == 8) {
        return (isdefined(entity.gib_data) ? entity.gib_data.head : entity.head);
    }
    assertmsg("<dev string:x7e>");
}

// Namespace gibserverutils/gib
// Params 2, eflags: 0x4
// Checksum 0xa11d94f9, Offset: 0x6d0
// Size: 0x68
function private _gibextra(entity, gibflag) {
    if (isgibbed(entity, gibflag)) {
        return false;
    }
    if (!_hasgibdef(entity)) {
        return false;
    }
    entity thread _gibextrainternal(entity, gibflag);
    return true;
}

// Namespace gibserverutils/gib
// Params 2, eflags: 0x4
// Checksum 0x707701e6, Offset: 0x740
// Size: 0x1f4
function private _gibextrainternal(entity, gibflag) {
    if (entity.gib_time !== gettime()) {
        [[ level.gib_throttle ]]->waitinqueue(entity);
    }
    if (!isdefined(entity)) {
        return;
    }
    entity.gib_time = gettime();
    if (isgibbed(entity, gibflag)) {
        return 0;
    }
    if (gibflag == 8) {
        if (isdefined(isdefined(entity.gib_data) ? entity.gib_data.torsodmg5 : entity.torsodmg5)) {
            entity attach(isdefined(entity.gib_data) ? entity.gib_data.torsodmg5 : entity.torsodmg5, "", 1);
        }
    }
    _setgibbed(entity, gibflag, undefined);
    destructserverutils::showdestructedpieces(entity);
    showhiddengibpieces(entity);
    gibmodel = _getgibextramodel(entity, gibflag);
    if (isdefined(gibmodel) && entity isattached(gibmodel)) {
        entity detach(gibmodel, "");
    }
    destructserverutils::reapplydestructedpieces(entity);
    reapplyhiddengibpieces(entity);
}

// Namespace gibserverutils/gib
// Params 2, eflags: 0x4
// Checksum 0x9fd41ea5, Offset: 0x940
// Size: 0x88
function private _gibentity(entity, gibflag) {
    if (isgibbed(entity, gibflag) || !_hasgibpieces(entity, gibflag)) {
        return false;
    }
    if (!_hasgibdef(entity)) {
        return false;
    }
    entity thread _gibentityinternal(entity, gibflag);
    return true;
}

// Namespace gibserverutils/gib
// Params 2, eflags: 0x4
// Checksum 0x33ac5f8c, Offset: 0x9d0
// Size: 0x194
function private _gibentityinternal(entity, gibflag) {
    if (entity.gib_time !== gettime()) {
        [[ level.gib_throttle ]]->waitinqueue(entity);
    }
    if (!isdefined(entity)) {
        return;
    }
    entity.gib_time = gettime();
    if (isgibbed(entity, gibflag)) {
        return;
    }
    destructserverutils::showdestructedpieces(entity);
    showhiddengibpieces(entity);
    if (!(_getgibbedstate(entity) < 16)) {
        legmodel = _getgibbedlegmodel(entity);
        entity detach(legmodel);
    }
    _setgibbed(entity, gibflag, undefined);
    entity setmodel(_getgibbedtorsomodel(entity));
    entity attach(_getgibbedlegmodel(entity));
    destructserverutils::reapplydestructedpieces(entity);
    reapplyhiddengibpieces(entity);
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x4
// Checksum 0x4459112, Offset: 0xb70
// Size: 0x152
function private _getgibbedlegmodel(entity) {
    gibstate = _getgibbedstate(entity);
    rightleggibbed = gibstate & 128;
    leftleggibbed = gibstate & 256;
    if (rightleggibbed && leftleggibbed) {
        return (isdefined(entity.gib_data) ? entity.gib_data.legdmg4 : entity.legdmg4);
    } else if (rightleggibbed) {
        return (isdefined(entity.gib_data) ? entity.gib_data.legdmg2 : entity.legdmg2);
    } else if (leftleggibbed) {
        return (isdefined(entity.gib_data) ? entity.gib_data.legdmg3 : entity.legdmg3);
    }
    return isdefined(entity.gib_data) ? entity.gib_data.legdmg1 : entity.legdmg1;
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x4
// Checksum 0x96002ad3, Offset: 0xcd0
// Size: 0x2a
function private _getgibbedstate(entity) {
    if (isdefined(entity.gib_state)) {
        return entity.gib_state;
    }
    return 0;
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x4
// Checksum 0xd26c8733, Offset: 0xd08
// Size: 0x152
function private _getgibbedtorsomodel(entity) {
    gibstate = _getgibbedstate(entity);
    rightarmgibbed = gibstate & 16;
    leftarmgibbed = gibstate & 32;
    if (rightarmgibbed && leftarmgibbed) {
        return (isdefined(entity.gib_data) ? entity.gib_data.torsodmg2 : entity.torsodmg2);
    } else if (rightarmgibbed) {
        return (isdefined(entity.gib_data) ? entity.gib_data.torsodmg2 : entity.torsodmg2);
    } else if (leftarmgibbed) {
        return (isdefined(entity.gib_data) ? entity.gib_data.torsodmg3 : entity.torsodmg3);
    }
    return isdefined(entity.gib_data) ? entity.gib_data.torsodmg1 : entity.torsodmg1;
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x4
// Checksum 0xad49726c, Offset: 0xe68
// Size: 0x18
function private _hasgibdef(entity) {
    return isdefined(entity.gibdef);
}

// Namespace gibserverutils/gib
// Params 2, eflags: 0x4
// Checksum 0xcddbb2b0, Offset: 0xe88
// Size: 0xae
function private _hasgibpieces(entity, gibflag) {
    hasgibpieces = 0;
    gibstate = _getgibbedstate(entity);
    entity.gib_state = gibstate | gibflag & 512 - 1;
    if (isdefined(_getgibbedtorsomodel(entity)) && isdefined(_getgibbedlegmodel(entity))) {
        hasgibpieces = 1;
    }
    entity.gib_state = gibstate;
    return hasgibpieces;
}

// Namespace gibserverutils/gib
// Params 3, eflags: 0x4
// Checksum 0x64b0943, Offset: 0xf40
// Size: 0x124
function private _setgibbed(entity, gibflag, gibdir) {
    if (isdefined(gibdir)) {
        angles = vectortoangles(gibdir);
        yaw = angles[1];
        yaw_bits = getbitsforangle(yaw, 3);
        entity.gib_state = (_getgibbedstate(entity) | gibflag & 512 - 1) + (yaw_bits << 9);
    } else {
        entity.gib_state = _getgibbedstate(entity) | gibflag & 512 - 1;
    }
    entity.gibbed = 1;
    entity clientfield::set("gib_state", entity.gib_state);
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x0
// Checksum 0x86c6c784, Offset: 0x1070
// Size: 0xac
function annihilate(entity) {
    if (!_hasgibdef(entity)) {
        return false;
    }
    gibpiecestruct = function_9893c890(entity.gibdef, 2, entity);
    if (isdefined(gibpiecestruct)) {
        if (isdefined(gibpiecestruct.gibfx)) {
            _setgibbed(entity, 2, undefined);
            entity thread _annihilate(entity);
            return true;
        }
    }
    return false;
}

// Namespace gibserverutils/gib
// Params 2, eflags: 0x0
// Checksum 0x5acd7d72, Offset: 0x1128
// Size: 0x64
function copygibstate(originalentity, newentity) {
    newentity.gib_state = _getgibbedstate(originalentity);
    togglespawngibs(newentity, 0);
    reapplyhiddengibpieces(newentity);
}

// Namespace gibserverutils/gib
// Params 2, eflags: 0x0
// Checksum 0x2ffefd18, Offset: 0x1198
// Size: 0x30
function isgibbed(entity, gibflag) {
    return _getgibbedstate(entity) & gibflag;
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x0
// Checksum 0x770be498, Offset: 0x11d0
// Size: 0x22
function gibhat(entity) {
    return _gibextra(entity, 4);
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x0
// Checksum 0xfe2efa9, Offset: 0x1200
// Size: 0x92
function gibhead(entity) {
    gibhat(entity);
    level notify(#"gib", {#entity:entity, #attacker:self.attacker, #area:"head"});
    return _gibextra(entity, 8);
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x0
// Checksum 0xbdc93bee, Offset: 0x12a0
// Size: 0xb8
function gibleftarm(entity) {
    if (isgibbed(entity, 16)) {
        return false;
    }
    if (_gibentity(entity, 32)) {
        destructserverutils::destructleftarmpieces(entity);
        level notify(#"gib", {#entity:entity, #attacker:self.attacker, #area:"left_arm"});
        return true;
    }
    return false;
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x0
// Checksum 0xb81af4bf, Offset: 0x1360
// Size: 0xd0
function gibrightarm(entity) {
    if (isgibbed(entity, 32)) {
        return false;
    }
    if (_gibentity(entity, 16)) {
        destructserverutils::destructrightarmpieces(entity);
        entity thread shared::dropaiweapon();
        level notify(#"gib", {#entity:entity, #attacker:self.attacker, #area:"right_arm"});
        return true;
    }
    return false;
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x0
// Checksum 0x438299b4, Offset: 0x1438
// Size: 0x98
function gibleftleg(entity) {
    if (_gibentity(entity, 256)) {
        destructserverutils::destructleftlegpieces(entity);
        level notify(#"gib", {#entity:entity, #attacker:self.attacker, #area:"left_leg"});
        return true;
    }
    return false;
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x0
// Checksum 0x886369c0, Offset: 0x14d8
// Size: 0x98
function gibrightleg(entity) {
    if (_gibentity(entity, 128)) {
        destructserverutils::destructrightlegpieces(entity);
        level notify(#"gib", {#entity:entity, #attacker:self.attacker, #area:"right_leg"});
        return true;
    }
    return false;
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x0
// Checksum 0x5bd355c1, Offset: 0x1578
// Size: 0xb0
function giblegs(entity) {
    if (_gibentity(entity, 384)) {
        destructserverutils::destructrightlegpieces(entity);
        destructserverutils::destructleftlegpieces(entity);
        level notify(#"gib", {#entity:entity, #attacker:self.attacker, #area:"both_legs"});
        return true;
    }
    return false;
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x0
// Checksum 0x4de71d03, Offset: 0x1630
// Size: 0x4c
function playergibleftarm(entity) {
    if (isdefined(entity.body)) {
        dir = (1, 0, 0);
        _setgibbed(entity.body, 32, dir);
    }
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x0
// Checksum 0x20b012d5, Offset: 0x1688
// Size: 0x4c
function playergibrightarm(entity) {
    if (isdefined(entity.body)) {
        dir = (1, 0, 0);
        _setgibbed(entity.body, 16, dir);
    }
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x0
// Checksum 0x53715505, Offset: 0x16e0
// Size: 0x4c
function playergibleftleg(entity) {
    if (isdefined(entity.body)) {
        dir = (1, 0, 0);
        _setgibbed(entity.body, 256, dir);
    }
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x0
// Checksum 0x68cb7018, Offset: 0x1738
// Size: 0x4c
function playergibrightleg(entity) {
    if (isdefined(entity.body)) {
        dir = (1, 0, 0);
        _setgibbed(entity.body, 128, dir);
    }
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x0
// Checksum 0x8eaae3fa, Offset: 0x1790
// Size: 0x6c
function playergiblegs(entity) {
    if (isdefined(entity.body)) {
        dir = (1, 0, 0);
        _setgibbed(entity.body, 128, dir);
        _setgibbed(entity.body, 256, dir);
    }
}

// Namespace gibserverutils/player_gibleftarmvel
// Params 1, eflags: 0x40
// Checksum 0xb4a309ce, Offset: 0x1808
// Size: 0x54
function event_handler[player_gibleftarmvel] playergibleftarmvel(entitystruct) {
    if (isdefined(entitystruct.player.body)) {
        _setgibbed(entitystruct.player.body, 32, entitystruct.direction);
    }
}

// Namespace gibserverutils/player_gibrightarmvel
// Params 1, eflags: 0x40
// Checksum 0xf721c5e6, Offset: 0x1868
// Size: 0x54
function event_handler[player_gibrightarmvel] playergibrightarmvel(entitystruct) {
    if (isdefined(entitystruct.player.body)) {
        _setgibbed(entitystruct.player.body, 16, entitystruct.direction);
    }
}

// Namespace gibserverutils/player_gibleftlegvel
// Params 1, eflags: 0x40
// Checksum 0x46931264, Offset: 0x18c8
// Size: 0x54
function event_handler[player_gibleftlegvel] playergibleftlegvel(entitystruct) {
    if (isdefined(entitystruct.player.body)) {
        _setgibbed(entitystruct.player.body, 256, entitystruct.direction);
    }
}

// Namespace gibserverutils/player_gibrightlegvel
// Params 1, eflags: 0x40
// Checksum 0xe03c8f94, Offset: 0x1928
// Size: 0x54
function event_handler[player_gibrightlegvel] playergibrightlegvel(entitystruct) {
    if (isdefined(entitystruct.player.body)) {
        _setgibbed(entitystruct.player.body, 128, entitystruct.direction);
    }
}

// Namespace gibserverutils/player_gibbothlegsvel
// Params 1, eflags: 0x40
// Checksum 0xb1989249, Offset: 0x1988
// Size: 0x84
function event_handler[player_gibbothlegsvel] playergiblegsvel(entitystruct) {
    if (isdefined(entitystruct.player.body)) {
        _setgibbed(entitystruct.player.body, 128, entitystruct.direction);
        _setgibbed(entitystruct.player.body, 256, entitystruct.direction);
    }
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x0
// Checksum 0x64770425, Offset: 0x1a18
// Size: 0x170
function reapplyhiddengibpieces(entity) {
    if (!_hasgibdef(entity)) {
        return;
    }
    gibpieces = function_5e68b448(entity.gibdef, entity);
    foreach (gibflag, gib in gibpieces) {
        if (!isgibbed(entity, gibflag)) {
            continue;
        }
        if (!isdefined(gib)) {
            continue;
        }
        if (isdefined(gib.gibhidetag) && isalive(entity) && entity haspart(gib.gibhidetag)) {
            if (!(isdefined(entity.skipdeath) && entity.skipdeath)) {
                entity hidepart(gib.gibhidetag, "", 1);
            }
        }
    }
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x0
// Checksum 0x1e935e04, Offset: 0x1b90
// Size: 0x118
function showhiddengibpieces(entity) {
    if (!_hasgibdef(entity)) {
        return;
    }
    gibpieces = function_5e68b448(entity.gibdef, entity);
    foreach (gib in gibpieces) {
        if (!isdefined(gib)) {
            continue;
        }
        if (isdefined(gib.gibhidetag) && entity haspart(gib.gibhidetag)) {
            entity showpart(gib.gibhidetag, "", 1);
        }
    }
}

// Namespace gibserverutils/gib
// Params 2, eflags: 0x0
// Checksum 0x5ff3cf48, Offset: 0x1cb0
// Size: 0x94
function togglespawngibs(entity, shouldspawngibs) {
    if (!shouldspawngibs) {
        entity.gib_state = _getgibbedstate(entity) | 1;
    } else {
        entity.gib_state = _getgibbedstate(entity) & -2;
    }
    entity clientfield::set("gib_state", entity.gib_state);
}

