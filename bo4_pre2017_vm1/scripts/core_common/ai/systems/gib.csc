#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/util_shared;

#namespace gibclientutils;

// Namespace gibclientutils/gib
// Params 0, eflags: 0x2
// Checksum 0xb0d39ee, Offset: 0x238
// Size: 0x3f4
function autoexec main() {
    clientfield::register("actor", "gib_state", 1, 9, "int", &_gibhandler, 0, 0);
    clientfield::register("playercorpse", "gib_state", 1, 15, "int", &_gibhandler, 0, 0);
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
            var_5ec70049.var_5ce61d20[var_79390ec7] = gibstruct;
        }
        processedbundles[definition.name] = var_5ec70049;
    }
    level.var_6a65aa40 = processedbundles;
    level thread _annihilatecorpse();
}

// Namespace gibclientutils/gib
// Params 1, eflags: 0x4
// Checksum 0xb1841302, Offset: 0x638
// Size: 0x1c
function private function_4af7d1fa(name) {
    return level.var_6a65aa40[name];
}

// Namespace gibclientutils/gib
// Params 0, eflags: 0x4
// Checksum 0xe432ec38, Offset: 0x660
// Size: 0x238
function private _annihilatecorpse() {
    while (true) {
        waitresult = level waittill("corpse_explode");
        localclientnum = waitresult.localclientnum;
        body = waitresult.body;
        origin = waitresult.position;
        if (!util::is_mature() || util::is_gib_restricted_build()) {
            continue;
        }
        if (isdefined(body) && _hasgibdef(body) && body isragdoll()) {
            cliententgibhead(localclientnum, body);
            cliententgibrightarm(localclientnum, body);
            cliententgibleftarm(localclientnum, body);
            cliententgibrightleg(localclientnum, body);
            cliententgibleftleg(localclientnum, body);
        }
        if (isdefined(body) && _hasgibdef(body) && body.archetype == "human") {
            if (randomint(100) >= 50) {
                continue;
            }
            if (isdefined(origin) && distancesquared(body.origin, origin) <= 14400) {
                body.ignoreragdoll = 1;
                body _gibentity(localclientnum, 50 | 384, 1);
            }
        }
    }
}

// Namespace gibclientutils/gib
// Params 3, eflags: 0x4
// Checksum 0x78f4879b, Offset: 0x8a0
// Size: 0x20c
function private _clonegibdata(localclientnum, entity, clone) {
    clone.gib_data = spawnstruct();
    clone.gib_data.gib_state = entity.gib_state;
    clone.gib_data.gibdef = entity.gibdef;
    clone.gib_data.hatmodel = entity.hatmodel;
    clone.gib_data.head = entity.head;
    clone.gib_data.legdmg1 = entity.legdmg1;
    clone.gib_data.legdmg2 = entity.legdmg2;
    clone.gib_data.legdmg3 = entity.legdmg3;
    clone.gib_data.legdmg4 = entity.legdmg4;
    clone.gib_data.torsodmg1 = entity.torsodmg1;
    clone.gib_data.torsodmg2 = entity.torsodmg2;
    clone.gib_data.torsodmg3 = entity.torsodmg3;
    clone.gib_data.torsodmg4 = entity.torsodmg4;
    clone.gib_data.torsodmg5 = entity.torsodmg5;
}

// Namespace gibclientutils/gib
// Params 1, eflags: 0x4
// Checksum 0xf1cf03f8, Offset: 0xab8
// Size: 0x92
function private function_e2149f4f(entity) {
    if (entity isplayer() || entity isplayercorpse()) {
        return entity getplayergibdef();
    } else if (isdefined(entity.gib_data)) {
        return entity.gib_data.gibdef;
    }
    return entity.gibdef;
}

// Namespace gibclientutils/gib
// Params 2, eflags: 0x4
// Checksum 0x1976b8c, Offset: 0xb58
// Size: 0x86
function private _getgibbedstate(localclientnum, entity) {
    if (isdefined(entity.gib_data) && isdefined(entity.gib_data.gib_state)) {
        return entity.gib_data.gib_state;
    } else if (isdefined(entity.gib_state)) {
        return entity.gib_state;
    }
    return 0;
}

// Namespace gibclientutils/gib
// Params 2, eflags: 0x4
// Checksum 0x29415c2a, Offset: 0xbe8
// Size: 0x17e
function private _getgibbedlegmodel(localclientnum, entity) {
    gibstate = _getgibbedstate(localclientnum, entity);
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

// Namespace gibclientutils/gib
// Params 3, eflags: 0x4
// Checksum 0x5c704141, Offset: 0xd70
// Size: 0xd4
function private _getgibextramodel(localclientnumm, entity, gibflag) {
    if (gibflag == 4) {
        return (isdefined(entity.gib_data) ? entity.gib_data.hatmodel : entity.hatmodel);
    }
    if (gibflag == 8) {
        return (isdefined(entity.gib_data) ? entity.gib_data.head : entity.head);
    }
    /#
        assertmsg("<dev string:x28>");
    #/
}

// Namespace gibclientutils/gib
// Params 2, eflags: 0x4
// Checksum 0xf6e11785, Offset: 0xe50
// Size: 0x17e
function private _getgibbedtorsomodel(localclientnum, entity) {
    gibstate = _getgibbedstate(localclientnum, entity);
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

// Namespace gibclientutils/gib
// Params 3, eflags: 0x4
// Checksum 0xdf4e2665, Offset: 0xfd8
// Size: 0xac
function private _gibpiecetag(localclientnum, entity, gibflag) {
    if (!_hasgibdef(self)) {
        return;
    }
    var_5ec70049 = function_4af7d1fa(function_e2149f4f(entity));
    gibpiece = var_5ec70049.var_5ce61d20[gibflag];
    if (isdefined(gibpiece)) {
        return gibpiece.gibfxtag;
    }
}

// Namespace gibclientutils/gib
// Params 3, eflags: 0x4
// Checksum 0x95f495cd, Offset: 0x1090
// Size: 0x298
function private _gibentity(localclientnum, gibflags, shouldspawngibs) {
    entity = self;
    if (!_hasgibdef(entity)) {
        return;
    }
    currentgibflag = 2;
    gibdir = undefined;
    if (entity isplayer() || entity isplayercorpse()) {
        yaw_bits = gibflags >> 9 & 8 - 1;
        yaw = getanglefrombits(yaw_bits, 3);
        gibdir = anglestoforward((0, yaw, 0));
    }
    var_5ec70049 = function_4af7d1fa(function_e2149f4f(entity));
    while (gibflags >= currentgibflag) {
        if (gibflags & currentgibflag) {
            gibpiece = var_5ec70049.var_5ce61d20[currentgibflag];
            if (isdefined(gibpiece)) {
                if (shouldspawngibs) {
                    entity thread _gibpiece(localclientnum, entity, gibpiece.gibmodel, gibpiece.gibtag, gibpiece.gibdynentfx, gibdir);
                }
                _playgibfx(localclientnum, entity, gibpiece.gibfx, gibpiece.gibfxtag);
                _playgibsound(localclientnum, entity, gibpiece.gibsound);
                if (currentgibflag == 2) {
                    entity hide();
                    entity.ignoreragdoll = 1;
                }
            }
            _handlegibcallbacks(localclientnum, entity, currentgibflag);
        }
        currentgibflag <<= 1;
    }
}

// Namespace gibclientutils/gib
// Params 3, eflags: 0x4
// Checksum 0x5d6f34a, Offset: 0x1330
// Size: 0x98
function private _setgibbed(localclientnum, entity, gibflag) {
    gib_state = _getgibbedstate(localclientnum, entity) | gibflag & 512 - 1;
    if (isdefined(entity.gib_data)) {
        entity.gib_data.gib_state = gib_state;
        return;
    }
    entity.gib_state = gib_state;
}

// Namespace gibclientutils/gib
// Params 3, eflags: 0x4
// Checksum 0xfd5b5205, Offset: 0x13d0
// Size: 0x1c4
function private _gibcliententityinternal(localclientnum, entity, gibflag) {
    if (!util::is_mature() || util::is_gib_restricted_build()) {
        return;
    }
    if (!isdefined(entity) || !_hasgibdef(entity)) {
        return;
    }
    if (entity.type !== "scriptmover") {
        return;
    }
    if (isgibbed(localclientnum, entity, gibflag)) {
        return;
    }
    if (!(_getgibbedstate(localclientnum, entity) < 16)) {
        legmodel = _getgibbedlegmodel(localclientnum, entity);
        entity detach(legmodel, "");
    }
    _setgibbed(localclientnum, entity, gibflag);
    entity setmodel(_getgibbedtorsomodel(localclientnum, entity));
    entity attach(_getgibbedlegmodel(localclientnum, entity), "");
    entity _gibentity(localclientnum, gibflag, 1);
}

// Namespace gibclientutils/gib
// Params 3, eflags: 0x4
// Checksum 0x6e895d0b, Offset: 0x15a0
// Size: 0x1ec
function private _gibclientextrainternal(localclientnum, entity, gibflag) {
    if (!util::is_mature() || util::is_gib_restricted_build()) {
        return;
    }
    if (!isdefined(entity)) {
        return;
    }
    if (entity.type !== "scriptmover") {
        return;
    }
    if (isgibbed(localclientnum, entity, gibflag)) {
        return;
    }
    gibmodel = _getgibextramodel(localclientnum, entity, gibflag);
    if (isdefined(gibmodel) && entity isattached(gibmodel, "")) {
        entity detach(gibmodel, "");
    }
    if (gibflag == 8) {
        if (isdefined(isdefined(entity.gib_data) ? entity.gib_data.torsodmg5 : entity.torsodmg5)) {
            entity attach(isdefined(entity.gib_data) ? entity.gib_data.torsodmg5 : entity.torsodmg5, "");
        }
    }
    _setgibbed(localclientnum, entity, gibflag);
    entity _gibentity(localclientnum, gibflag, 1);
}

// Namespace gibclientutils/gib
// Params 7, eflags: 0x4
// Checksum 0xde402a94, Offset: 0x1798
// Size: 0x1b0
function private _gibhandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    entity = self;
    if (entity isplayer() || entity isplayercorpse()) {
        if (!util::is_mature() || util::is_gib_restricted_build()) {
            return;
        }
    } else {
        if (isdefined(entity.maturegib) && entity.maturegib && !util::is_mature()) {
            return;
        }
        if (isdefined(entity.restrictedgib) && entity.restrictedgib && !isshowgibsenabled()) {
            return;
        }
    }
    gibflags = oldvalue ^ newvalue;
    shouldspawngibs = !(newvalue & 1);
    if (bnewent) {
        gibflags = 0 ^ newvalue;
    }
    entity _gibentity(localclientnum, gibflags, shouldspawngibs);
    entity.gib_state = newvalue;
}

// Namespace gibclientutils/gib
// Params 6, eflags: 0x0
// Checksum 0xa9867d81, Offset: 0x1950
// Size: 0x304
function _gibpiece(localclientnum, entity, gibmodel, gibtag, gibfx, gibdir) {
    if (!isdefined(gibtag) || !isdefined(gibmodel)) {
        return;
    }
    startposition = entity gettagorigin(gibtag);
    startangles = entity gettagangles(gibtag);
    endposition = startposition;
    endangles = startangles;
    forwardvector = undefined;
    if (!isdefined(startposition) || !isdefined(startangles)) {
        return 0;
    }
    if (isdefined(gibdir)) {
        startposition = (0, 0, 0);
        forwardvector = gibdir;
        forwardvector *= randomfloatrange(100, 500);
    } else {
        waitframe(1);
        if (isdefined(entity)) {
            endposition = entity gettagorigin(gibtag);
            endangles = entity gettagangles(gibtag);
        } else {
            endposition = startposition + anglestoforward(startangles) * 10;
            endangles = startangles;
        }
        if (!isdefined(endposition) || !isdefined(endangles)) {
            return 0;
        }
        forwardvector = vectornormalize(endposition - startposition);
        forwardvector *= randomfloatrange(0.6, 1);
        forwardvector += (randomfloatrange(0, 0.2), randomfloatrange(0, 0.2), randomfloatrange(0.2, 0.7));
    }
    if (isdefined(entity)) {
        gibentity = createdynentandlaunch(localclientnum, gibmodel, endposition, endangles, startposition, forwardvector, gibfx, 1);
        if (isdefined(gibentity)) {
            setdynentbodyrenderoptionspacked(gibentity, entity getbodyrenderoptionspacked());
        }
    }
}

// Namespace gibclientutils/gib
// Params 3, eflags: 0x4
// Checksum 0x170541dc, Offset: 0x1c60
// Size: 0xde
function private _handlegibcallbacks(localclientnum, entity, gibflag) {
    if (isdefined(entity._gibcallbacks) && isdefined(entity._gibcallbacks[gibflag])) {
        foreach (callback in entity._gibcallbacks[gibflag]) {
            [[ callback ]](localclientnum, entity, gibflag);
        }
    }
}

// Namespace gibclientutils/gib
// Params 1, eflags: 0x4
// Checksum 0xe4b83744, Offset: 0x1d48
// Size: 0x6c
function private _handlegibannihilate(localclientnum) {
    entity = self;
    entity endon(#"death");
    entity waittillmatch({#notetrack:"gib_annihilate"}, "_anim_notify_");
    cliententgibannihilate(localclientnum, entity);
}

// Namespace gibclientutils/gib
// Params 1, eflags: 0x4
// Checksum 0xd0807096, Offset: 0x1dc0
// Size: 0x6c
function private _handlegibhead(localclientnum) {
    entity = self;
    entity endon(#"death");
    entity waittillmatch({#notetrack:"gib = \"head\""}, "_anim_notify_");
    cliententgibhead(localclientnum, entity);
}

// Namespace gibclientutils/gib
// Params 1, eflags: 0x4
// Checksum 0xb01b9e95, Offset: 0x1e38
// Size: 0x6c
function private _handlegibrightarm(localclientnum) {
    entity = self;
    entity endon(#"death");
    entity waittillmatch({#notetrack:"gib = \"arm_right\""}, "_anim_notify_");
    cliententgibrightarm(localclientnum, entity);
}

// Namespace gibclientutils/gib
// Params 1, eflags: 0x4
// Checksum 0xf4b43d98, Offset: 0x1eb0
// Size: 0x6c
function private _handlegibleftarm(localclientnum) {
    entity = self;
    entity endon(#"death");
    entity waittillmatch({#notetrack:"gib = \"arm_left\""}, "_anim_notify_");
    cliententgibleftarm(localclientnum, entity);
}

// Namespace gibclientutils/gib
// Params 1, eflags: 0x4
// Checksum 0xaebc55d3, Offset: 0x1f28
// Size: 0x6c
function private _handlegibrightleg(localclientnum) {
    entity = self;
    entity endon(#"death");
    entity waittillmatch({#notetrack:"gib = \"leg_right\""}, "_anim_notify_");
    cliententgibrightleg(localclientnum, entity);
}

// Namespace gibclientutils/gib
// Params 1, eflags: 0x4
// Checksum 0xe1531846, Offset: 0x1fa0
// Size: 0x6c
function private _handlegibleftleg(localclientnum) {
    entity = self;
    entity endon(#"death");
    entity waittillmatch({#notetrack:"gib = \"leg_left\""}, "_anim_notify_");
    cliententgibleftleg(localclientnum, entity);
}

// Namespace gibclientutils/gib
// Params 1, eflags: 0x4
// Checksum 0x5c161b62, Offset: 0x2018
// Size: 0x6c
function private _hasgibdef(entity) {
    return isdefined(entity.gib_data) && isdefined(entity.gib_data.gibdef) || isdefined(entity.gibdef) || entity getplayergibdef() != "unknown";
}

// Namespace gibclientutils/gib
// Params 4, eflags: 0x0
// Checksum 0xdbff9372, Offset: 0x2090
// Size: 0x112
function _playgibfx(localclientnum, entity, fxfilename, fxtag) {
    if (isdefined(fxfilename) && isdefined(fxtag) && entity hasdobj(localclientnum)) {
        fx = playfxontag(localclientnum, fxfilename, entity, fxtag);
        if (isdefined(fx)) {
            if (isdefined(entity.team)) {
                setfxteam(localclientnum, fx, entity.team);
            }
            if (isdefined(level.setgibfxtoignorepause) && level.setgibfxtoignorepause) {
                setfxignorepause(localclientnum, fx, 1);
            }
        }
        return fx;
    }
}

// Namespace gibclientutils/gib
// Params 3, eflags: 0x0
// Checksum 0x5938415a, Offset: 0x21b0
// Size: 0x4c
function _playgibsound(localclientnum, entity, soundalias) {
    if (isdefined(soundalias)) {
        playsound(localclientnum, soundalias, entity.origin);
    }
}

// Namespace gibclientutils/gib
// Params 4, eflags: 0x0
// Checksum 0x3536ef83, Offset: 0x2208
// Size: 0xf6
function addgibcallback(localclientnum, entity, gibflag, callbackfunction) {
    /#
        assert(isfunctionptr(callbackfunction));
    #/
    if (!isdefined(entity._gibcallbacks)) {
        entity._gibcallbacks = [];
    }
    if (!isdefined(entity._gibcallbacks[gibflag])) {
        entity._gibcallbacks[gibflag] = [];
    }
    gibcallbacks = entity._gibcallbacks[gibflag];
    gibcallbacks[gibcallbacks.size] = callbackfunction;
    entity._gibcallbacks[gibflag] = gibcallbacks;
}

// Namespace gibclientutils/gib
// Params 2, eflags: 0x0
// Checksum 0xe5df578e, Offset: 0x2308
// Size: 0x7c
function cliententgibannihilate(localclientnum, entity) {
    if (!util::is_mature() || util::is_gib_restricted_build()) {
        return;
    }
    entity.ignoreragdoll = 1;
    entity _gibentity(localclientnum, 50 | 384, 1);
}

// Namespace gibclientutils/gib
// Params 2, eflags: 0x0
// Checksum 0x3dc455d0, Offset: 0x2390
// Size: 0x54
function cliententgibhead(localclientnum, entity) {
    _gibclientextrainternal(localclientnum, entity, 4);
    _gibclientextrainternal(localclientnum, entity, 8);
}

// Namespace gibclientutils/gib
// Params 2, eflags: 0x0
// Checksum 0x51a04029, Offset: 0x23f0
// Size: 0x54
function cliententgibleftarm(localclientnum, entity) {
    if (isgibbed(localclientnum, entity, 16)) {
        return;
    }
    _gibcliententityinternal(localclientnum, entity, 32);
}

// Namespace gibclientutils/gib
// Params 2, eflags: 0x0
// Checksum 0x5ddd6211, Offset: 0x2450
// Size: 0x54
function cliententgibrightarm(localclientnum, entity) {
    if (isgibbed(localclientnum, entity, 32)) {
        return;
    }
    _gibcliententityinternal(localclientnum, entity, 16);
}

// Namespace gibclientutils/gib
// Params 2, eflags: 0x0
// Checksum 0x433a9f74, Offset: 0x24b0
// Size: 0x34
function cliententgibleftleg(localclientnum, entity) {
    _gibcliententityinternal(localclientnum, entity, 256);
}

// Namespace gibclientutils/gib
// Params 2, eflags: 0x0
// Checksum 0xf7e9b92c, Offset: 0x24f0
// Size: 0x34
function cliententgibrightleg(localclientnum, entity) {
    _gibcliententityinternal(localclientnum, entity, 128);
}

// Namespace gibclientutils/gib
// Params 2, eflags: 0x0
// Checksum 0xd937f328, Offset: 0x2530
// Size: 0x378
function createscriptmodelofentity(localclientnum, entity) {
    clone = spawn(localclientnum, entity.origin, "script_model");
    clone.angles = entity.angles;
    _clonegibdata(localclientnum, entity, clone);
    gibstate = _getgibbedstate(localclientnum, clone);
    if (!util::is_mature() || util::is_gib_restricted_build()) {
        gibstate = 0;
    }
    if (!(_getgibbedstate(localclientnum, entity) < 16)) {
        clone setmodel(_getgibbedtorsomodel(localclientnum, entity));
        clone attach(_getgibbedlegmodel(localclientnum, entity), "");
    } else {
        clone setmodel(entity.model);
    }
    if (gibstate & 8) {
        if (isdefined(isdefined(clone.gib_data) ? clone.gib_data.torsodmg5 : clone.torsodmg5)) {
            clone attach(isdefined(clone.gib_data) ? clone.gib_data.torsodmg5 : clone.torsodmg5, "");
        }
    } else {
        if (isdefined(isdefined(clone.gib_data) ? clone.gib_data.head : clone.head)) {
            clone attach(isdefined(clone.gib_data) ? clone.gib_data.head : clone.head, "");
        }
        if (!(gibstate & 4) && isdefined(isdefined(clone.gib_data) ? clone.gib_data.hatmodel : clone.hatmodel)) {
            clone attach(isdefined(clone.gib_data) ? clone.gib_data.hatmodel : clone.hatmodel, "");
        }
    }
    return clone;
}

// Namespace gibclientutils/gib
// Params 3, eflags: 0x0
// Checksum 0x5353acab, Offset: 0x28b0
// Size: 0x38
function isgibbed(localclientnum, entity, gibflag) {
    return _getgibbedstate(localclientnum, entity) & gibflag;
}

// Namespace gibclientutils/gib
// Params 2, eflags: 0x0
// Checksum 0x5101490d, Offset: 0x28f0
// Size: 0x2e
function isundamaged(localclientnum, entity) {
    return _getgibbedstate(localclientnum, entity) == 0;
}

// Namespace gibclientutils/gib
// Params 2, eflags: 0x0
// Checksum 0xf10e3eb8, Offset: 0x2928
// Size: 0x68
function gibentity(localclientnum, gibflags) {
    self _gibentity(localclientnum, gibflags, 1);
    self.gib_state = _getgibbedstate(localclientnum, self) | gibflags & 512 - 1;
}

// Namespace gibclientutils/gib
// Params 1, eflags: 0x0
// Checksum 0x30fb1b50, Offset: 0x2998
// Size: 0xac
function handlegibnotetracks(localclientnum) {
    entity = self;
    entity thread _handlegibannihilate(localclientnum);
    entity thread _handlegibhead(localclientnum);
    entity thread _handlegibrightarm(localclientnum);
    entity thread _handlegibleftarm(localclientnum);
    entity thread _handlegibrightleg(localclientnum);
    entity thread _handlegibleftleg(localclientnum);
}

// Namespace gibclientutils/gib
// Params 1, eflags: 0x0
// Checksum 0xa16d8987, Offset: 0x2a50
// Size: 0x2c
function playergibleftarm(localclientnum) {
    self gibentity(localclientnum, 32);
}

// Namespace gibclientutils/gib
// Params 1, eflags: 0x0
// Checksum 0x9d755172, Offset: 0x2a88
// Size: 0x2c
function playergibrightarm(localclientnum) {
    self gibentity(localclientnum, 16);
}

// Namespace gibclientutils/gib
// Params 1, eflags: 0x0
// Checksum 0xd9d3b6e, Offset: 0x2ac0
// Size: 0x2c
function playergibleftleg(localclientnum) {
    self gibentity(localclientnum, 256);
}

// Namespace gibclientutils/gib
// Params 1, eflags: 0x0
// Checksum 0x4021814d, Offset: 0x2af8
// Size: 0x2c
function playergibrightleg(localclientnum) {
    self gibentity(localclientnum, 128);
}

// Namespace gibclientutils/gib
// Params 1, eflags: 0x0
// Checksum 0x736aa460, Offset: 0x2b30
// Size: 0x4c
function playergiblegs(localclientnum) {
    self gibentity(localclientnum, 128);
    self gibentity(localclientnum, 256);
}

// Namespace gibclientutils/gib
// Params 2, eflags: 0x0
// Checksum 0xbeff54df, Offset: 0x2b88
// Size: 0x32
function playergibtag(localclientnum, gibflag) {
    return _gibpiecetag(localclientnum, self, gibflag);
}

