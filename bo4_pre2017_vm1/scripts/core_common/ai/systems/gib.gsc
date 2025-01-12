#using scripts/core_common/ai/systems/destructible_character;
#using scripts/core_common/ai/systems/shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/throttle_shared;

#namespace gib;

// Namespace gib/gib
// Params 0, eflags: 0x2
// Checksum 0xa77166e2, Offset: 0x208
// Size: 0x42c
function autoexec main() {
    clientfield::register("actor", "gib_state", 1, 9, "int");
    clientfield::register("playercorpse", "gib_state", 1, 15, "int");
    var_19c51405 = struct::get_script_bundles("gibcharacterdef");
    gibpiecelookup = [];
    gibpiecelookup[2] = "annihilate";
    gibpiecelookup[8] = "head";
    gibpiecelookup[16] = "rightarm";
    gibpiecelookup[32] = "leftarm";
    gibpiecelookup[128] = "rightleg";
    gibpiecelookup[256] = "leftleg";
    processedbundles = [];
    foreach (definition in var_19c51405) {
        var_5ec70049 = spawnstruct();
        var_5ec70049.var_5ce61d20 = [];
        var_5ec70049.name = definition.name;
        foreach (var_79390ec7, var_f815bc88 in gibpiecelookup) {
            gibstruct = spawnstruct();
            gibstruct.gibmodel = definition.(gibpiecelookup[var_79390ec7] + "_gibmodel");
            gibstruct.gibtag = definition.(gibpiecelookup[var_79390ec7] + "_gibtag");
            gibstruct.gibfx = definition.(gibpiecelookup[var_79390ec7] + "_gibfx");
            gibstruct.gibfxtag = definition.(gibpiecelookup[var_79390ec7] + "_gibeffecttag");
            gibstruct.gibdynentfx = definition.(gibpiecelookup[var_79390ec7] + "_gibdynentfx");
            gibstruct.gibsound = definition.(gibpiecelookup[var_79390ec7] + "_gibsound");
            gibstruct.gibhidetag = definition.(gibpiecelookup[var_79390ec7] + "_gibhidetag");
            var_5ec70049.var_5ce61d20[var_79390ec7] = gibstruct;
        }
        processedbundles[definition.name] = var_5ec70049;
    }
    level.var_6a65aa40 = processedbundles;
    if (!isdefined(level.gib_throttle)) {
        level.gib_throttle = new throttle();
        [[ level.gib_throttle ]]->initialize(2, 0.2);
    }
}

#namespace gibserverutils;

// Namespace gibserverutils/gib
// Params 1, eflags: 0x4
// Checksum 0xbf3285ba, Offset: 0x640
// Size: 0x1c
function private function_4af7d1fa(name) {
    return level.var_6a65aa40[name];
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x4
// Checksum 0x4db42a42, Offset: 0x668
// Size: 0x2c
function private _annihilate(entity) {
    if (isdefined(entity)) {
        entity notsolid();
    }
}

// Namespace gibserverutils/gib
// Params 2, eflags: 0x4
// Checksum 0xb22a4fdb, Offset: 0x6a0
// Size: 0xcc
function private _getgibextramodel(entity, gibflag) {
    if (gibflag == 4) {
        return (isdefined(entity.gib_data) ? entity.gib_data.hatmodel : entity.hatmodel);
    }
    if (gibflag == 8) {
        return (isdefined(entity.gib_data) ? entity.gib_data.head : entity.head);
    }
    assertmsg("<dev string:x28>");
}

// Namespace gibserverutils/gib
// Params 2, eflags: 0x4
// Checksum 0xc6fa0ee0, Offset: 0x778
// Size: 0x78
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
// Checksum 0xb73ba726, Offset: 0x7f8
// Size: 0x1fc
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
    if (isdefined(gibmodel)) {
        entity detach(gibmodel, "");
    }
    destructserverutils::reapplydestructedpieces(entity);
    reapplyhiddengibpieces(entity);
}

// Namespace gibserverutils/gib
// Params 2, eflags: 0x4
// Checksum 0x505b55fe, Offset: 0xa00
// Size: 0x98
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
// Checksum 0x984c285b, Offset: 0xaa0
// Size: 0x1ac
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
// Checksum 0xb93820c7, Offset: 0xc58
// Size: 0x176
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
// Checksum 0x8edf4e72, Offset: 0xdd8
// Size: 0x32
function private _getgibbedstate(entity) {
    if (isdefined(entity.gib_state)) {
        return entity.gib_state;
    }
    return 0;
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x4
// Checksum 0x302253dd, Offset: 0xe18
// Size: 0x176
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
// Checksum 0x9e52bd6e, Offset: 0xf98
// Size: 0x1c
function private _hasgibdef(entity) {
    return isdefined(entity.gibdef);
}

// Namespace gibserverutils/gib
// Params 2, eflags: 0x4
// Checksum 0x1e78b0ff, Offset: 0xfc0
// Size: 0xc0
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
// Checksum 0x16050d00, Offset: 0x1088
// Size: 0x144
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
// Checksum 0x4a6daa0e, Offset: 0x11d8
// Size: 0xfc
function annihilate(entity) {
    if (!_hasgibdef(entity)) {
        return false;
    }
    var_5ec70049 = function_4af7d1fa(entity.gibdef);
    if (!isdefined(var_5ec70049) || !isdefined(var_5ec70049.var_5ce61d20)) {
        return false;
    }
    gibpiecestruct = var_5ec70049.var_5ce61d20[2];
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
// Checksum 0xf366fee9, Offset: 0x12e0
// Size: 0x6c
function copygibstate(originalentity, newentity) {
    newentity.gib_state = _getgibbedstate(originalentity);
    togglespawngibs(newentity, 0);
    reapplyhiddengibpieces(newentity);
}

// Namespace gibserverutils/gib
// Params 2, eflags: 0x0
// Checksum 0x9581100f, Offset: 0x1358
// Size: 0x30
function isgibbed(entity, gibflag) {
    return _getgibbedstate(entity) & gibflag;
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x0
// Checksum 0x5f287c07, Offset: 0x1390
// Size: 0x22
function gibhat(entity) {
    return _gibextra(entity, 4);
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x0
// Checksum 0x6cd0d2ba, Offset: 0x13c0
// Size: 0x3a
function gibhead(entity) {
    gibhat(entity);
    return _gibextra(entity, 8);
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x0
// Checksum 0x5008e385, Offset: 0x1408
// Size: 0x64
function gibleftarm(entity) {
    if (isgibbed(entity, 16)) {
        return false;
    }
    if (_gibentity(entity, 32)) {
        destructserverutils::destructleftarmpieces(entity);
        return true;
    }
    return false;
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x0
// Checksum 0x9f728405, Offset: 0x1478
// Size: 0x7c
function gibrightarm(entity) {
    if (isgibbed(entity, 32)) {
        return false;
    }
    if (_gibentity(entity, 16)) {
        destructserverutils::destructrightarmpieces(entity);
        entity thread shared::dropaiweapon();
        return true;
    }
    return false;
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x0
// Checksum 0x3fa490f8, Offset: 0x1500
// Size: 0x44
function gibleftleg(entity) {
    if (_gibentity(entity, 256)) {
        destructserverutils::destructleftlegpieces(entity);
        return true;
    }
    return false;
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x0
// Checksum 0x6da6f8bf, Offset: 0x1550
// Size: 0x44
function gibrightleg(entity) {
    if (_gibentity(entity, 128)) {
        destructserverutils::destructrightlegpieces(entity);
        return true;
    }
    return false;
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x0
// Checksum 0xc624e5e, Offset: 0x15a0
// Size: 0x5c
function giblegs(entity) {
    if (_gibentity(entity, 384)) {
        destructserverutils::destructrightlegpieces(entity);
        destructserverutils::destructleftlegpieces(entity);
        return true;
    }
    return false;
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x0
// Checksum 0x32286d08, Offset: 0x1608
// Size: 0x5c
function playergibleftarm(entity) {
    if (isdefined(entity.body)) {
        dir = (1, 0, 0);
        _setgibbed(entity.body, 32, dir);
    }
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x0
// Checksum 0x9f892b5b, Offset: 0x1670
// Size: 0x5c
function playergibrightarm(entity) {
    if (isdefined(entity.body)) {
        dir = (1, 0, 0);
        _setgibbed(entity.body, 16, dir);
    }
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x0
// Checksum 0xa6346393, Offset: 0x16d8
// Size: 0x5c
function playergibleftleg(entity) {
    if (isdefined(entity.body)) {
        dir = (1, 0, 0);
        _setgibbed(entity.body, 256, dir);
    }
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x0
// Checksum 0xba9bcb8a, Offset: 0x1740
// Size: 0x5c
function playergibrightleg(entity) {
    if (isdefined(entity.body)) {
        dir = (1, 0, 0);
        _setgibbed(entity.body, 128, dir);
    }
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x0
// Checksum 0xe4deab1e, Offset: 0x17a8
// Size: 0x84
function playergiblegs(entity) {
    if (isdefined(entity.body)) {
        dir = (1, 0, 0);
        _setgibbed(entity.body, 128, dir);
        _setgibbed(entity.body, 256, dir);
    }
}

// Namespace gibserverutils/player_gibleftarmvel
// Params 1, eflags: 0x40
// Checksum 0xdabd2e47, Offset: 0x1838
// Size: 0x5c
function event_handler[player_gibleftarmvel] playergibleftarmvel(entitystruct) {
    if (isdefined(entitystruct.player.body)) {
        _setgibbed(entitystruct.player.body, 32, entitystruct.direction);
    }
}

// Namespace gibserverutils/player_gibrightarmvel
// Params 1, eflags: 0x40
// Checksum 0xbd84e4d7, Offset: 0x18a0
// Size: 0x5c
function event_handler[player_gibrightarmvel] playergibrightarmvel(entitystruct) {
    if (isdefined(entitystruct.player.body)) {
        _setgibbed(entitystruct.player.body, 16, entitystruct.direction);
    }
}

// Namespace gibserverutils/player_gibleftlegvel
// Params 1, eflags: 0x40
// Checksum 0x5f0bc6e7, Offset: 0x1908
// Size: 0x5c
function event_handler[player_gibleftlegvel] playergibleftlegvel(entitystruct) {
    if (isdefined(entitystruct.player.body)) {
        _setgibbed(entitystruct.player.body, 256, entitystruct.direction);
    }
}

// Namespace gibserverutils/player_gibrightlegvel
// Params 1, eflags: 0x40
// Checksum 0x43500a7f, Offset: 0x1970
// Size: 0x5c
function event_handler[player_gibrightlegvel] playergibrightlegvel(entitystruct) {
    if (isdefined(entitystruct.player.body)) {
        _setgibbed(entitystruct.player.body, 128, entitystruct.direction);
    }
}

// Namespace gibserverutils/player_gibbothlegsvel
// Params 1, eflags: 0x40
// Checksum 0xd45c2eb2, Offset: 0x19d8
// Size: 0x94
function event_handler[player_gibbothlegsvel] playergiblegsvel(entitystruct) {
    if (isdefined(entitystruct.player.body)) {
        _setgibbed(entitystruct.player.body, 128, entitystruct.direction);
        _setgibbed(entitystruct.player.body, 256, entitystruct.direction);
    }
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x0
// Checksum 0x1b9b035d, Offset: 0x1a78
// Size: 0x18a
function reapplyhiddengibpieces(entity) {
    if (!_hasgibdef(entity)) {
        return;
    }
    var_5ec70049 = function_4af7d1fa(entity.gibdef);
    foreach (gibflag, gib in var_5ec70049.var_5ce61d20) {
        if (!isgibbed(entity, gibflag)) {
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
// Checksum 0x99a317c0, Offset: 0x1c10
// Size: 0x12a
function showhiddengibpieces(entity) {
    if (!_hasgibdef(entity)) {
        return;
    }
    var_5ec70049 = function_4af7d1fa(entity.gibdef);
    foreach (gib in var_5ec70049.var_5ce61d20) {
        if (isdefined(gib.gibhidetag) && entity haspart(gib.gibhidetag)) {
            entity showpart(gib.gibhidetag, "", 1);
        }
    }
}

// Namespace gibserverutils/gib
// Params 2, eflags: 0x0
// Checksum 0xe9ab71a8, Offset: 0x1d48
// Size: 0xa4
function togglespawngibs(entity, shouldspawngibs) {
    if (!shouldspawngibs) {
        entity.gib_state = _getgibbedstate(entity) | 1;
    } else {
        entity.gib_state = _getgibbedstate(entity) & -2;
    }
    entity clientfield::set("gib_state", entity.gib_state);
}

