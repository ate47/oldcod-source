#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;

#namespace gibclientutils;

// Namespace gibclientutils/gib
// Params 0, eflags: 0x2
// Checksum 0xa43e8b87, Offset: 0x218
// Size: 0xb4
function autoexec main() {
    clientfield::register("actor", "gib_state", 1, 9, "int", &_gibhandler, 0, 0);
    clientfield::register("playercorpse", "gib_state", 1, 15, "int", &_gibhandler, 0, 0);
    level.var_ad0f5efa = [];
    level thread _annihilatecorpse();
}

// Namespace gibclientutils/gib
// Params 1, eflags: 0x5 linked
// Checksum 0x8e0a1e4c, Offset: 0x2d8
// Size: 0x2e8
function private function_3aa023f1(name) {
    if (!isdefined(name)) {
        return undefined;
    }
    gibdef = level.var_ad0f5efa[name];
    if (isdefined(gibdef)) {
        return gibdef;
    }
    definition = getscriptbundle(name);
    if (!isdefined(definition)) {
        assertmsg("<dev string:x38>" + name);
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
    level.var_ad0f5efa[name] = gibpieces;
    return gibpieces;
}

// Namespace gibclientutils/gib
// Params 2, eflags: 0x5 linked
// Checksum 0xd378cc39, Offset: 0x5c8
// Size: 0x358
function private function_9fe14ca3(entity, gibflag) {
    if (gibflag == 8) {
        part = "head";
    } else if (gibflag == 16 || gibflag == 32) {
        part = "arms";
    } else if (gibflag == 128 || gibflag == 256) {
        part = "legs";
    }
    if (!isdefined(part)) {
        return undefined;
    }
    name = entity getplayergibdef(part);
    if (!isdefined(name)) {
        assertmsg("<dev string:x8c>" + gibflag);
        return undefined;
    }
    gibdef = level.var_ad0f5efa[name];
    if (isdefined(gibdef)) {
        return gibdef;
    }
    definition = getscriptbundle(name);
    if (!isdefined(definition)) {
        assertmsg("<dev string:x38>" + name);
        return undefined;
    }
    gibpiecelookup = [];
    gibpiecelookup[0] = "left";
    gibpiecelookup[1] = "right";
    gibpieces = [];
    foreach (side, gibpiece in gibpiecelookup) {
        if (!isdefined(gibpiece)) {
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
        gibpieces[side] = gibstruct;
    }
    level.var_ad0f5efa[name] = gibpieces;
    return gibpieces;
}

// Namespace gibclientutils/gib
// Params 2, eflags: 0x1 linked
// Checksum 0x726f9a00, Offset: 0x928
// Size: 0xb6
function function_c0099e86(entity, gibflag) {
    gibpiece = function_9fe14ca3(entity, gibflag);
    if (!isdefined(gibpiece)) {
        return undefined;
    }
    if (gibflag == 8) {
        side = 0;
    } else if (gibflag == 16 || gibflag == 128) {
        side = 1;
    } else if (gibflag == 32 || gibflag == 256) {
        side = 0;
    }
    return gibpiece[side];
}

// Namespace gibclientutils/gib
// Params 2, eflags: 0x5 linked
// Checksum 0x9158ece5, Offset: 0x9e8
// Size: 0xc4
function private function_69db754(entity, gibflag) {
    if (isplayer(entity) || entity isplayercorpse()) {
        return function_c0099e86(entity, gibflag);
    }
    if (isdefined(entity.gib_data)) {
        gibpieces = function_3aa023f1(entity.gib_data.gibdef);
    } else {
        gibpieces = function_3aa023f1(entity.gibdef);
    }
    return gibpieces[gibflag];
}

// Namespace gibclientutils/gib
// Params 0, eflags: 0x5 linked
// Checksum 0x2e48855, Offset: 0xab8
// Size: 0x228
function private _annihilatecorpse() {
    while (true) {
        waitresult = level waittill(#"corpse_explode");
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
        if (isdefined(body) && _hasgibdef(body) && body.archetype == #"human") {
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
// Params 3, eflags: 0x5 linked
// Checksum 0x7ba78dc3, Offset: 0xce8
// Size: 0x16a
function private _clonegibdata(*localclientnum, entity, clone) {
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
// Params 2, eflags: 0x5 linked
// Checksum 0x1e0c57ce, Offset: 0xe60
// Size: 0x72
function private _getgibbedstate(*localclientnum, entity) {
    if (isdefined(entity.gib_data) && isdefined(entity.gib_data.gib_state)) {
        return entity.gib_data.gib_state;
    } else if (isdefined(entity.gib_state)) {
        return entity.gib_state;
    }
    return 0;
}

// Namespace gibclientutils/gib
// Params 2, eflags: 0x5 linked
// Checksum 0x9e8ef20c, Offset: 0xee0
// Size: 0x14a
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
// Params 3, eflags: 0x5 linked
// Checksum 0xfbd7f931, Offset: 0x1038
// Size: 0xbc
function private _getgibextramodel(*localclientnumm, entity, gibflag) {
    if (gibflag == 4) {
        return (isdefined(entity.gib_data) ? entity.gib_data.hatmodel : entity.hatmodel);
    }
    if (gibflag == 8) {
        return (isdefined(entity.gib_data) ? entity.gib_data.head : entity.head);
    }
    assertmsg("<dev string:xb3>");
}

// Namespace gibclientutils/gib
// Params 2, eflags: 0x5 linked
// Checksum 0xbfefbe7c, Offset: 0x1100
// Size: 0x14a
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
// Params 3, eflags: 0x5 linked
// Checksum 0xe0fda881, Offset: 0x1258
// Size: 0x70
function private _gibpiecetag(*localclientnum, entity, gibflag) {
    if (!_hasgibdef(self)) {
        return;
    }
    gibpiece = function_69db754(entity, gibflag);
    if (isdefined(gibpiece)) {
        return gibpiece.gibfxtag;
    }
}

// Namespace gibclientutils/gib
// Params 1, eflags: 0x5 linked
// Checksum 0xa7ed4dee, Offset: 0x12d0
// Size: 0x72
function private function_ba120c50(gibflags) {
    var_ec7623a6 = 0;
    if (gibflags & 12) {
        var_ec7623a6 |= 1;
    }
    if (gibflags & 48) {
        var_ec7623a6 |= 2;
    }
    if (gibflags & 384) {
        var_ec7623a6 |= 4;
    }
    return var_ec7623a6;
}

// Namespace gibclientutils/gib
// Params 3, eflags: 0x5 linked
// Checksum 0x1f0f0830, Offset: 0x1350
// Size: 0x3de
function private _gibentity(localclientnum, gibflags, shouldspawngibs) {
    entity = self;
    if (!_hasgibdef(entity)) {
        return;
    }
    currentgibflag = 2;
    gibdir = undefined;
    gibdirscale = undefined;
    if (isplayer(entity) || entity isplayercorpse()) {
        yaw_bits = gibflags >> 9 & 8 - 1;
        yaw = getanglefrombits(yaw_bits, 3);
        gibdir = anglestoforward((0, yaw, 0));
    }
    while (gibflags >= currentgibflag) {
        if (gibflags & currentgibflag) {
            if (currentgibflag == 2) {
                if (isplayer(entity) || entity isplayercorpse()) {
                    var_c0c9eae3 = entity function_4976d5ee();
                    _playgibfx(localclientnum, entity, var_c0c9eae3[#"fx"], var_c0c9eae3[#"tag"]);
                } else {
                    gibpiece = function_69db754(entity, currentgibflag);
                    if (isdefined(gibpiece)) {
                        _playgibfx(localclientnum, entity, gibpiece.gibfx, gibpiece.gibfxtag);
                        if (isdefined(gibpiece.var_42c89fa1)) {
                            if (function_92beaa28(localclientnum)) {
                                _playgibfx(localclientnum, entity, gibpiece.var_42c89fa1, gibpiece.gibfxtag);
                            }
                        }
                        _playgibsound(localclientnum, entity, gibpiece.gibsound);
                    }
                }
                entity hide();
                entity.ignoreragdoll = 1;
            } else {
                gibpiece = function_69db754(entity, currentgibflag);
                if (isdefined(gibpiece)) {
                    if (shouldspawngibs) {
                        var_cd61eb7d = function_ba120c50(currentgibflag);
                        entity thread _gibpiece(localclientnum, entity, gibpiece.gibmodel, gibpiece.gibtag, gibpiece.gibdynentfx, gibdir, gibdirscale, var_cd61eb7d);
                    }
                    _playgibfx(localclientnum, entity, gibpiece.gibfx, gibpiece.gibfxtag);
                    if (isdefined(gibpiece.var_42c89fa1)) {
                        if (function_92beaa28(localclientnum)) {
                            _playgibfx(localclientnum, entity, gibpiece.var_42c89fa1, gibpiece.gibfxtag);
                        }
                    }
                    _playgibsound(localclientnum, entity, gibpiece.gibsound);
                }
            }
            _handlegibcallbacks(localclientnum, entity, currentgibflag);
        }
        currentgibflag <<= 1;
    }
}

// Namespace gibclientutils/gib
// Params 3, eflags: 0x5 linked
// Checksum 0x23a88198, Offset: 0x1738
// Size: 0x82
function private _setgibbed(localclientnum, entity, gibflag) {
    gib_state = _getgibbedstate(localclientnum, entity) | gibflag & 512 - 1;
    if (isdefined(entity.gib_data)) {
        entity.gib_data.gib_state = gib_state;
        return;
    }
    entity.gib_state = gib_state;
}

// Namespace gibclientutils/gib
// Params 3, eflags: 0x5 linked
// Checksum 0xfb234d47, Offset: 0x17c8
// Size: 0x19c
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
// Params 3, eflags: 0x5 linked
// Checksum 0xac45d707, Offset: 0x1970
// Size: 0x1b4
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
// Params 7, eflags: 0x5 linked
// Checksum 0x7b6e7feb, Offset: 0x1b30
// Size: 0x19a
function private _gibhandler(localclientnum, oldvalue, newvalue, bnewent, *binitialsnap, *fieldname, *wasdemojump) {
    entity = self;
    if (isplayer(entity) || entity isplayercorpse()) {
        if (!util::is_mature() || util::is_gib_restricted_build()) {
            return;
        }
    } else {
        if (isdefined(entity.maturegib) && entity.maturegib && (!util::is_mature() || !isshowgibsenabled())) {
            return;
        }
        if (isdefined(entity.restrictedgib) && entity.restrictedgib && !isshowgibsenabled()) {
            return;
        }
    }
    gibflags = binitialsnap ^ fieldname;
    shouldspawngibs = !(fieldname & 1);
    if (wasdemojump) {
        gibflags = 0 ^ fieldname;
    }
    entity _gibentity(bnewent, gibflags, shouldspawngibs);
    entity.gib_state = fieldname;
}

// Namespace gibclientutils/gib
// Params 8, eflags: 0x1 linked
// Checksum 0x6001fb16, Offset: 0x1cd8
// Size: 0x324
function _gibpiece(localclientnum, entity, gibmodel, gibtag, gibfx, gibdir, gibdirscale, var_bf41adc0) {
    if (!isdefined(gibtag) || !isdefined(gibmodel)) {
        return;
    }
    startposition = entity gettagorigin(gibtag);
    startangles = entity gettagangles(gibtag);
    endposition = startposition;
    endangles = startangles;
    forwardvector = undefined;
    if (!isdefined(startposition) || !isdefined(startangles)) {
        return;
    }
    if (isdefined(gibdir) && !isdefined(gibdirscale)) {
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
            return;
        }
        scale = randomfloatrange(0.6, 1);
        dir = (randomfloatrange(0, 0.2), randomfloatrange(0, 0.2), randomfloatrange(0.2, 0.7));
        if (isdefined(gibdir) && isdefined(gibdirscale) && gibdirscale > 0) {
            dir = gibdir + dir;
            scale = gibdirscale;
        }
        forwardvector = vectornormalize(endposition - startposition);
        forwardvector *= scale;
        forwardvector += dir;
    }
    if (isdefined(entity)) {
        gibentity = createdynentandlaunch(localclientnum, gibmodel, endposition, endangles, startposition, forwardvector, gibfx, 1, !is_true(level.var_2f78f66c));
        if (isdefined(gibentity)) {
            function_1cfbe3d4(gibentity, entity function_c70446c2(), var_bf41adc0);
        }
    }
}

// Namespace gibclientutils/gib
// Params 3, eflags: 0x5 linked
// Checksum 0xcc355397, Offset: 0x2008
// Size: 0xc6
function private _handlegibcallbacks(localclientnum, entity, gibflag) {
    if (isdefined(entity._gibcallbacks) && isdefined(entity._gibcallbacks[gibflag])) {
        foreach (callback in entity._gibcallbacks[gibflag]) {
            [[ callback ]](localclientnum, entity, gibflag);
        }
    }
}

// Namespace gibclientutils/gib
// Params 1, eflags: 0x5 linked
// Checksum 0x3aaee71c, Offset: 0x20d8
// Size: 0x7c
function private _handlegibannihilate(localclientnum) {
    entity = self;
    entity endon(#"death");
    entity waittillmatch({#notetrack:"gib_annihilate"}, #"_anim_notify_");
    cliententgibannihilate(localclientnum, entity);
}

// Namespace gibclientutils/gib
// Params 1, eflags: 0x5 linked
// Checksum 0x734e5c67, Offset: 0x2160
// Size: 0x7c
function private _handlegibhead(localclientnum) {
    entity = self;
    entity endon(#"death");
    entity waittillmatch({#notetrack:"gib = \"head\""}, #"_anim_notify_");
    cliententgibhead(localclientnum, entity);
}

// Namespace gibclientutils/gib
// Params 1, eflags: 0x5 linked
// Checksum 0x560a7146, Offset: 0x21e8
// Size: 0x7c
function private _handlegibrightarm(localclientnum) {
    entity = self;
    entity endon(#"death");
    entity waittillmatch({#notetrack:"gib = \"arm_right\""}, #"_anim_notify_");
    cliententgibrightarm(localclientnum, entity);
}

// Namespace gibclientutils/gib
// Params 1, eflags: 0x5 linked
// Checksum 0xc51e5b37, Offset: 0x2270
// Size: 0x7c
function private _handlegibleftarm(localclientnum) {
    entity = self;
    entity endon(#"death");
    entity waittillmatch({#notetrack:"gib = \"arm_left\""}, #"_anim_notify_");
    cliententgibleftarm(localclientnum, entity);
}

// Namespace gibclientutils/gib
// Params 1, eflags: 0x5 linked
// Checksum 0x1e2fb751, Offset: 0x22f8
// Size: 0x7c
function private _handlegibrightleg(localclientnum) {
    entity = self;
    entity endon(#"death");
    entity waittillmatch({#notetrack:"gib = \"leg_right\""}, #"_anim_notify_");
    cliententgibrightleg(localclientnum, entity);
}

// Namespace gibclientutils/gib
// Params 1, eflags: 0x5 linked
// Checksum 0xfc066c18, Offset: 0x2380
// Size: 0x7c
function private _handlegibleftleg(localclientnum) {
    entity = self;
    entity endon(#"death");
    entity waittillmatch({#notetrack:"gib = \"leg_left\""}, #"_anim_notify_");
    cliententgibleftleg(localclientnum, entity);
}

// Namespace gibclientutils/gib
// Params 1, eflags: 0x5 linked
// Checksum 0x3d49986e, Offset: 0x2408
// Size: 0x88
function private _hasgibdef(entity) {
    return isdefined(entity.gib_data) && isdefined(entity.gib_data.gibdef) || isdefined(entity.gibdef) || isdefined(entity getplayergibdef("arms")) && isdefined(entity getplayergibdef("legs"));
}

// Namespace gibclientutils/gib
// Params 4, eflags: 0x1 linked
// Checksum 0xb793473b, Offset: 0x2498
// Size: 0xea
function _playgibfx(localclientnum, entity, fxfilename, fxtag) {
    if (isdefined(fxfilename) && isdefined(fxtag) && entity hasdobj(localclientnum)) {
        fx = util::playfxontag(localclientnum, fxfilename, entity, fxtag);
        if (isdefined(fx)) {
            if (isdefined(entity.team)) {
                setfxteam(localclientnum, fx, entity.team);
            }
            if (is_true(level.setgibfxtoignorepause)) {
                setfxignorepause(localclientnum, fx, 1);
            }
        }
        return fx;
    }
}

// Namespace gibclientutils/gib
// Params 3, eflags: 0x1 linked
// Checksum 0xd633268e, Offset: 0x2590
// Size: 0x44
function _playgibsound(localclientnum, entity, soundalias) {
    if (isdefined(soundalias)) {
        playsound(localclientnum, soundalias, entity.origin);
    }
}

// Namespace gibclientutils/gib
// Params 4, eflags: 0x1 linked
// Checksum 0xd2367424, Offset: 0x25e0
// Size: 0xc0
function addgibcallback(*localclientnum, entity, gibflag, callbackfunction) {
    assert(isfunctionptr(callbackfunction));
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
// Params 2, eflags: 0x1 linked
// Checksum 0x8cb70614, Offset: 0x26a8
// Size: 0x74
function cliententgibannihilate(localclientnum, entity) {
    if (!util::is_mature() || util::is_gib_restricted_build()) {
        return;
    }
    entity.ignoreragdoll = 1;
    entity _gibentity(localclientnum, 50 | 384, 1);
}

// Namespace gibclientutils/gib
// Params 2, eflags: 0x1 linked
// Checksum 0x5051ba96, Offset: 0x2728
// Size: 0x2c
function cliententgibhead(localclientnum, entity) {
    _gibclientextrainternal(localclientnum, entity, 8);
}

// Namespace gibclientutils/gib
// Params 2, eflags: 0x1 linked
// Checksum 0x5d439c71, Offset: 0x2760
// Size: 0x4c
function cliententgibleftarm(localclientnum, entity) {
    if (isgibbed(localclientnum, entity, 16)) {
        return;
    }
    _gibcliententityinternal(localclientnum, entity, 32);
}

// Namespace gibclientutils/gib
// Params 2, eflags: 0x1 linked
// Checksum 0xc61cc2b7, Offset: 0x27b8
// Size: 0x4c
function cliententgibrightarm(localclientnum, entity) {
    if (isgibbed(localclientnum, entity, 32)) {
        return;
    }
    _gibcliententityinternal(localclientnum, entity, 16);
}

// Namespace gibclientutils/gib
// Params 2, eflags: 0x1 linked
// Checksum 0x9b79e53d, Offset: 0x2810
// Size: 0x2c
function cliententgibleftleg(localclientnum, entity) {
    _gibcliententityinternal(localclientnum, entity, 256);
}

// Namespace gibclientutils/gib
// Params 2, eflags: 0x1 linked
// Checksum 0x9c4de8f3, Offset: 0x2848
// Size: 0x2c
function cliententgibrightleg(localclientnum, entity) {
    _gibcliententityinternal(localclientnum, entity, 128);
}

// Namespace gibclientutils/gib
// Params 2, eflags: 0x0
// Checksum 0x3a377d7a, Offset: 0x2880
// Size: 0x2f8
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
// Params 3, eflags: 0x1 linked
// Checksum 0xdc4b82ea, Offset: 0x2b80
// Size: 0x38
function isgibbed(localclientnum, entity, gibflag) {
    return _getgibbedstate(localclientnum, entity) & gibflag;
}

// Namespace gibclientutils/gib
// Params 2, eflags: 0x0
// Checksum 0xb1e527f, Offset: 0x2bc0
// Size: 0x2e
function isundamaged(localclientnum, entity) {
    return _getgibbedstate(localclientnum, entity) == 0;
}

// Namespace gibclientutils/gib
// Params 2, eflags: 0x1 linked
// Checksum 0x1dc517d3, Offset: 0x2bf8
// Size: 0x66
function gibentity(localclientnum, gibflags) {
    self _gibentity(localclientnum, gibflags, 1);
    self.gib_state = _getgibbedstate(localclientnum, self) | gibflags & 512 - 1;
}

// Namespace gibclientutils/gib
// Params 1, eflags: 0x0
// Checksum 0x7307e00d, Offset: 0x2c68
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
// Checksum 0x8bb7e987, Offset: 0x2d20
// Size: 0x2c
function playergibleftarm(localclientnum) {
    self gibentity(localclientnum, 32);
}

// Namespace gibclientutils/gib
// Params 1, eflags: 0x0
// Checksum 0x45bd23e9, Offset: 0x2d58
// Size: 0x2c
function playergibrightarm(localclientnum) {
    self gibentity(localclientnum, 16);
}

// Namespace gibclientutils/gib
// Params 1, eflags: 0x0
// Checksum 0x58eabb89, Offset: 0x2d90
// Size: 0x2c
function playergibleftleg(localclientnum) {
    self gibentity(localclientnum, 256);
}

// Namespace gibclientutils/gib
// Params 1, eflags: 0x0
// Checksum 0xd249025a, Offset: 0x2dc8
// Size: 0x2c
function playergibrightleg(localclientnum) {
    self gibentity(localclientnum, 128);
}

// Namespace gibclientutils/gib
// Params 1, eflags: 0x0
// Checksum 0x2a69e0dd, Offset: 0x2e00
// Size: 0x4c
function playergiblegs(localclientnum) {
    self gibentity(localclientnum, 128);
    self gibentity(localclientnum, 256);
}

// Namespace gibclientutils/gib
// Params 2, eflags: 0x0
// Checksum 0xdc9d1a16, Offset: 0x2e58
// Size: 0x2a
function playergibtag(localclientnum, gibflag) {
    return _gibpiecetag(localclientnum, self, gibflag);
}

