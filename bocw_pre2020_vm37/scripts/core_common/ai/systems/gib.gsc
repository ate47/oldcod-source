#using scripts\core_common\ai\systems\destructible_character;
#using scripts\core_common\ai\systems\shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\throttle_shared;

#namespace gib;

// Namespace gib/gib
// Params 0, eflags: 0x2
// Checksum 0xd667d34a, Offset: 0x1b8
// Size: 0xbc
function autoexec main() {
    clientfield::register("actor", "gib_state", 1, 9, "int");
    clientfield::register("playercorpse", "gib_state", 1, 15, "int");
    level.var_ad0f5efa = [];
    if (!isdefined(level.gib_throttle)) {
        level.gib_throttle = new throttle();
        [[ level.gib_throttle ]]->initialize(2, 0.2);
    }
}

#namespace gibserverutils;

// Namespace gibserverutils/gib
// Params 2, eflags: 0x5 linked
// Checksum 0x7bbad036, Offset: 0x280
// Size: 0x2f0
function private function_3aa023f1(name, *entity) {
    if (!isdefined(entity)) {
        return undefined;
    }
    gibdef = level.var_ad0f5efa[entity];
    if (isdefined(gibdef)) {
        return gibdef;
    }
    definition = getscriptbundle(entity);
    if (!isdefined(definition)) {
        assertmsg("<dev string:x38>" + entity);
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
            assertmsg("<dev string:x59>" + gibflag);
            continue;
        }
        gibstruct = spawnstruct();
        gibstruct.gibmodel = definition.(gibpiece + "_gibmodel");
        gibstruct.gibtag = definition.(gibpiece + "_gibtag");
        gibstruct.gibfx = definition.(gibpiece + "_gibfx");
        gibstruct.gibfxtag = definition.(gibpiece + "_gibeffecttag");
        gibstruct.gibdynentfx = definition.(gibpiece + "_gibdynentfx");
        gibstruct.var_42c89fa1 = definition.(gibpiece + "_gibcinematicfx");
        gibstruct.gibsound = definition.(gibpiece + "_gibsound");
        gibstruct.gibhidetag = definition.(gibpiece + "_gibhidetag");
        gibpieces[gibflag] = gibstruct;
    }
    level.var_ad0f5efa[entity] = gibpieces;
    return gibpieces;
}

// Namespace gibserverutils/gib
// Params 3, eflags: 0x5 linked
// Checksum 0x7e7bfd8d, Offset: 0x578
// Size: 0x44
function private function_69db754(name, gibflag, entity) {
    gibpieces = function_3aa023f1(name, entity);
    return gibpieces[gibflag];
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x5 linked
// Checksum 0x48ebab6, Offset: 0x5c8
// Size: 0x2c
function private _annihilate(entity) {
    if (isdefined(entity)) {
        entity notsolid();
    }
}

// Namespace gibserverutils/gib
// Params 2, eflags: 0x5 linked
// Checksum 0x6abd465a, Offset: 0x600
// Size: 0xb4
function private _getgibextramodel(entity, gibflag) {
    if (gibflag == 4) {
        return (isdefined(entity.gib_data) ? entity.gib_data.hatmodel : entity.hatmodel);
    }
    if (gibflag == 8) {
        return (isdefined(entity.gib_data) ? entity.gib_data.head : entity.head);
    }
    assertmsg("<dev string:x8c>");
}

// Namespace gibserverutils/gib
// Params 2, eflags: 0x5 linked
// Checksum 0x4c1c55c7, Offset: 0x6c0
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
// Params 2, eflags: 0x5 linked
// Checksum 0xf95b2d69, Offset: 0x730
// Size: 0x1dc
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
// Params 2, eflags: 0x5 linked
// Checksum 0x8a2b9f22, Offset: 0x918
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
// Params 2, eflags: 0x5 linked
// Checksum 0xf654b350, Offset: 0x9a8
// Size: 0x18c
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
// Params 1, eflags: 0x5 linked
// Checksum 0xce181266, Offset: 0xb40
// Size: 0x142
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
// Params 1, eflags: 0x5 linked
// Checksum 0x6e94e23e, Offset: 0xc90
// Size: 0x2a
function private _getgibbedstate(entity) {
    if (isdefined(entity.gib_state)) {
        return entity.gib_state;
    }
    return 0;
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x5 linked
// Checksum 0x3c26596b, Offset: 0xcc8
// Size: 0x142
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
// Params 1, eflags: 0x5 linked
// Checksum 0xdbcf8c56, Offset: 0xe18
// Size: 0x18
function private _hasgibdef(entity) {
    return isdefined(entity.gibdef);
}

// Namespace gibserverutils/gib
// Params 2, eflags: 0x5 linked
// Checksum 0x7ae01031, Offset: 0xe38
// Size: 0xa2
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
// Params 3, eflags: 0x5 linked
// Checksum 0x588aaadd, Offset: 0xee8
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
// Params 1, eflags: 0x1 linked
// Checksum 0x161b00e4, Offset: 0x1018
// Size: 0xac
function annihilate(entity) {
    if (!_hasgibdef(entity)) {
        return false;
    }
    gibpiecestruct = function_69db754(entity.gibdef, 2, entity);
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
// Params 2, eflags: 0x1 linked
// Checksum 0xe8ed5c74, Offset: 0x10d0
// Size: 0x64
function copygibstate(originalentity, newentity) {
    newentity.gib_state = _getgibbedstate(originalentity);
    togglespawngibs(newentity, 0);
    reapplyhiddengibpieces(newentity);
}

// Namespace gibserverutils/gib
// Params 2, eflags: 0x1 linked
// Checksum 0x8b64b395, Offset: 0x1140
// Size: 0x30
function isgibbed(entity, gibflag) {
    return _getgibbedstate(entity) & gibflag;
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x1 linked
// Checksum 0x675806ec, Offset: 0x1178
// Size: 0x22
function gibhat(entity) {
    return _gibextra(entity, 4);
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x1 linked
// Checksum 0xac3d42a3, Offset: 0x11a8
// Size: 0xb2
function gibhead(entity) {
    gibhat(entity);
    level notify(#"gib", {#entity:entity, #attacker:self.attacker, #area:"head"});
    entity callback::callback(#"head_gibbed");
    return _gibextra(entity, 8);
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x1 linked
// Checksum 0x56adb186, Offset: 0x1268
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
// Params 1, eflags: 0x1 linked
// Checksum 0x9d9d6154, Offset: 0x1328
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
// Params 1, eflags: 0x1 linked
// Checksum 0x18f4342a, Offset: 0x1400
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
// Params 1, eflags: 0x1 linked
// Checksum 0xa2e8ba5a, Offset: 0x14a0
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
// Params 1, eflags: 0x1 linked
// Checksum 0xb4000acf, Offset: 0x1540
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
// Checksum 0x40f555e, Offset: 0x15f8
// Size: 0x4c
function playergibleftarm(entity) {
    if (isdefined(entity.body)) {
        dir = (1, 0, 0);
        _setgibbed(entity.body, 32, dir);
    }
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x0
// Checksum 0x87f24088, Offset: 0x1650
// Size: 0x4c
function playergibrightarm(entity) {
    if (isdefined(entity.body)) {
        dir = (1, 0, 0);
        _setgibbed(entity.body, 16, dir);
    }
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x0
// Checksum 0x2b1761e, Offset: 0x16a8
// Size: 0x4c
function playergibleftleg(entity) {
    if (isdefined(entity.body)) {
        dir = (1, 0, 0);
        _setgibbed(entity.body, 256, dir);
    }
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x0
// Checksum 0x40093107, Offset: 0x1700
// Size: 0x4c
function playergibrightleg(entity) {
    if (isdefined(entity.body)) {
        dir = (1, 0, 0);
        _setgibbed(entity.body, 128, dir);
    }
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x0
// Checksum 0xa193ba52, Offset: 0x1758
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
// Checksum 0xa53b9b8, Offset: 0x17d0
// Size: 0x54
function event_handler[player_gibleftarmvel] playergibleftarmvel(entitystruct) {
    if (isdefined(entitystruct.player.body)) {
        _setgibbed(entitystruct.player.body, 32, entitystruct.direction);
    }
}

// Namespace gibserverutils/player_gibrightarmvel
// Params 1, eflags: 0x40
// Checksum 0x9890420d, Offset: 0x1830
// Size: 0x54
function event_handler[player_gibrightarmvel] playergibrightarmvel(entitystruct) {
    if (isdefined(entitystruct.player.body)) {
        _setgibbed(entitystruct.player.body, 16, entitystruct.direction);
    }
}

// Namespace gibserverutils/player_gibleftlegvel
// Params 1, eflags: 0x40
// Checksum 0x6df5c32a, Offset: 0x1890
// Size: 0x54
function event_handler[player_gibleftlegvel] playergibleftlegvel(entitystruct) {
    if (isdefined(entitystruct.player.body)) {
        _setgibbed(entitystruct.player.body, 256, entitystruct.direction);
    }
}

// Namespace gibserverutils/player_gibrightlegvel
// Params 1, eflags: 0x40
// Checksum 0xdee04087, Offset: 0x18f0
// Size: 0x54
function event_handler[player_gibrightlegvel] playergibrightlegvel(entitystruct) {
    if (isdefined(entitystruct.player.body)) {
        _setgibbed(entitystruct.player.body, 128, entitystruct.direction);
    }
}

// Namespace gibserverutils/player_gibbothlegsvel
// Params 1, eflags: 0x40
// Checksum 0xc2ca4d4b, Offset: 0x1950
// Size: 0x84
function event_handler[player_gibbothlegsvel] playergiblegsvel(entitystruct) {
    if (isdefined(entitystruct.player.body)) {
        _setgibbed(entitystruct.player.body, 128, entitystruct.direction);
        _setgibbed(entitystruct.player.body, 256, entitystruct.direction);
    }
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x1 linked
// Checksum 0xb21d3941, Offset: 0x19e0
// Size: 0x170
function reapplyhiddengibpieces(entity) {
    if (!_hasgibdef(entity)) {
        return;
    }
    gibpieces = function_3aa023f1(entity.gibdef, entity);
    foreach (gibflag, gib in gibpieces) {
        if (!isgibbed(entity, gibflag)) {
            continue;
        }
        if (!isdefined(gib)) {
            continue;
        }
        if (isdefined(gib.gibhidetag) && isalive(entity) && entity haspart(gib.gibhidetag)) {
            if (!is_true(entity.skipdeath)) {
                entity hidepart(gib.gibhidetag, "", 1);
            }
        }
    }
}

// Namespace gibserverutils/gib
// Params 1, eflags: 0x1 linked
// Checksum 0x3859cdaf, Offset: 0x1b58
// Size: 0x120
function showhiddengibpieces(entity) {
    if (!_hasgibdef(entity)) {
        return;
    }
    gibpieces = function_3aa023f1(entity.gibdef, entity);
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
// Params 2, eflags: 0x1 linked
// Checksum 0x94b1b715, Offset: 0x1c80
// Size: 0x94
function togglespawngibs(entity, shouldspawngibs) {
    if (!shouldspawngibs) {
        entity.gib_state = _getgibbedstate(entity) | 1;
    } else {
        entity.gib_state = _getgibbedstate(entity) & -2;
    }
    entity clientfield::set("gib_state", entity.gib_state);
}

