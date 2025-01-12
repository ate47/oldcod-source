#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;

#namespace gibclientutils;

// Namespace gibclientutils/gib
// Params 0, eflags: 0x2
// Checksum 0x74ea2f74, Offset: 0x1e8
// Size: 0xbc
function autoexec main() {
    clientfield::register("actor", "gib_state", 1, 9, "int", &_gibhandler, 0, 0);
    clientfield::register("playercorpse", "gib_state", 1, 15, "int", &_gibhandler, 0, 0);
    level.var_2c09fea0 = [];
    level thread _annihilatecorpse();
}

// Namespace gibclientutils/gib
// Params 1, eflags: 0x4
// Checksum 0x3c11cba4, Offset: 0x2b0
// Size: 0x326
function private function_5e68b448(name) {
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

// Namespace gibclientutils/gib
// Params 2, eflags: 0x4
// Checksum 0xc40c5b07, Offset: 0x5e0
// Size: 0x396
function private function_7e9b74d2(entity, gibflag) {
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
        assertmsg("<dev string:x7e>" + gibflag);
        return undefined;
    }
    gibdef = level.var_2c09fea0[name];
    if (isdefined(gibdef)) {
        return gibdef;
    }
    var_19c51405 = struct::get_script_bundles("playeroutfitgibdef");
    if (!isdefined(var_19c51405) || !isdefined(name)) {
        return undefined;
    }
    definition = var_19c51405[name];
    if (!isdefined(definition)) {
        assertmsg("<dev string:x30>" + name);
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
        gibstruct.var_37031286 = definition.(gibpiece + "_gibcinematicfx");
        gibstruct.gibsound = definition.(gibpiece + "_gibsound");
        gibstruct.gibhidetag = definition.(gibpiece + "_gibhidetag");
        gibpieces[side] = gibstruct;
    }
    level.var_2c09fea0[name] = gibpieces;
    return gibpieces;
}

// Namespace gibclientutils/gib
// Params 2, eflags: 0x0
// Checksum 0xb69f2472, Offset: 0x980
// Size: 0xba
function function_c2031e3(entity, gibflag) {
    gibpiece = function_7e9b74d2(entity, gibflag);
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
// Params 2, eflags: 0x4
// Checksum 0xb9a7ebd7, Offset: 0xa48
// Size: 0xc8
function private function_9893c890(entity, gibflag) {
    if (entity isplayer() || entity isplayercorpse()) {
        return function_c2031e3(entity, gibflag);
    }
    if (isdefined(entity.gib_data)) {
        gibpieces = function_5e68b448(entity.gib_data.gibdef);
    } else {
        gibpieces = function_5e68b448(entity.gibdef);
    }
    return gibpieces[gibflag];
}

// Namespace gibclientutils/gib
// Params 0, eflags: 0x4
// Checksum 0xc47d7813, Offset: 0xb18
// Size: 0x230
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
// Checksum 0x909c07, Offset: 0xd50
// Size: 0x1d6
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
// Params 2, eflags: 0x4
// Checksum 0x447f43f7, Offset: 0xf30
// Size: 0x76
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
// Checksum 0x380ec3ed, Offset: 0xfb0
// Size: 0x15a
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
// Checksum 0xabeaf4e8, Offset: 0x1118
// Size: 0xcc
function private _getgibextramodel(localclientnumm, entity, gibflag) {
    if (gibflag == 4) {
        return (isdefined(entity.gib_data) ? entity.gib_data.hatmodel : entity.hatmodel);
    }
    if (gibflag == 8) {
        return (isdefined(entity.gib_data) ? entity.gib_data.head : entity.head);
    }
    assertmsg("<dev string:xa2>");
}

// Namespace gibclientutils/gib
// Params 2, eflags: 0x4
// Checksum 0x3a8a3f64, Offset: 0x11f0
// Size: 0x15a
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
// Checksum 0x3ef52e1e, Offset: 0x1358
// Size: 0x74
function private _gibpiecetag(localclientnum, entity, gibflag) {
    if (!_hasgibdef(self)) {
        return;
    }
    gibpiece = function_9893c890(entity, gibflag);
    if (isdefined(gibpiece)) {
        return gibpiece.gibfxtag;
    }
}

// Namespace gibclientutils/gib
// Params 3, eflags: 0x4
// Checksum 0x50d00545, Offset: 0x13d8
// Size: 0x3f6
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
    while (gibflags >= currentgibflag) {
        if (gibflags & currentgibflag) {
            if (currentgibflag == 2) {
                if (entity isplayer() || entity isplayercorpse()) {
                    var_b5b42ad9 = entity function_a08ecf28();
                    _playgibfx(localclientnum, entity, var_b5b42ad9[#"fx"], var_b5b42ad9[#"tag"]);
                } else {
                    gibpiece = function_9893c890(entity, currentgibflag);
                    if (isdefined(gibpiece)) {
                        _playgibfx(localclientnum, entity, gibpiece.gibfx, gibpiece.gibfxtag);
                        if (isdefined(gibpiece.var_37031286)) {
                            if (function_c29e20cf(localclientnum)) {
                                _playgibfx(localclientnum, entity, gibpiece.var_37031286, gibpiece.gibfxtag);
                            }
                        }
                        _playgibsound(localclientnum, entity, gibpiece.gibsound);
                    }
                }
                entity hide();
                entity.ignoreragdoll = 1;
            } else {
                gibpiece = function_9893c890(entity, currentgibflag);
                if (isdefined(gibpiece)) {
                    if (shouldspawngibs) {
                        entity thread _gibpiece(localclientnum, entity, gibpiece.gibmodel, gibpiece.gibtag, gibpiece.gibdynentfx, gibdir);
                    }
                    _playgibfx(localclientnum, entity, gibpiece.gibfx, gibpiece.gibfxtag);
                    if (isdefined(gibpiece.var_37031286)) {
                        if (function_c29e20cf(localclientnum)) {
                            _playgibfx(localclientnum, entity, gibpiece.var_37031286, gibpiece.gibfxtag);
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
// Params 3, eflags: 0x4
// Checksum 0xc567e382, Offset: 0x17d8
// Size: 0x8a
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
// Checksum 0xa3795352, Offset: 0x1870
// Size: 0x1ac
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
// Checksum 0x9e33cc05, Offset: 0x1a28
// Size: 0x1dc
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
// Checksum 0x29704e6e, Offset: 0x1c10
// Size: 0x192
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
// Params 7, eflags: 0x0
// Checksum 0xe062b356, Offset: 0x1db0
// Size: 0x324
function _gibpiece(localclientnum, entity, gibmodel, gibtag, gibfx, gibdir, gibdirscale) {
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
            return 0;
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
        gibentity = createdynentandlaunch(localclientnum, gibmodel, endposition, endangles, startposition, forwardvector, gibfx, 1);
        if (isdefined(gibentity)) {
            setdynentbodyrenderoptionspacked(gibentity, entity getbodyrenderoptionspacked());
        }
    }
}

// Namespace gibclientutils/gib
// Params 3, eflags: 0x4
// Checksum 0x4dc7d534, Offset: 0x20e0
// Size: 0xc4
function private _handlegibcallbacks(localclientnum, entity, gibflag) {
    if (isdefined(entity._gibcallbacks) && isdefined(entity._gibcallbacks[gibflag])) {
        foreach (callback in entity._gibcallbacks[gibflag]) {
            [[ callback ]](localclientnum, entity, gibflag);
        }
    }
}

// Namespace gibclientutils/gib
// Params 1, eflags: 0x4
// Checksum 0x47a082d, Offset: 0x21b0
// Size: 0x7c
function private _handlegibannihilate(localclientnum) {
    entity = self;
    entity endon(#"death");
    entity waittillmatch({#notetrack:"gib_annihilate"}, #"_anim_notify_");
    cliententgibannihilate(localclientnum, entity);
}

// Namespace gibclientutils/gib
// Params 1, eflags: 0x4
// Checksum 0xfdd914b4, Offset: 0x2238
// Size: 0x7c
function private _handlegibhead(localclientnum) {
    entity = self;
    entity endon(#"death");
    entity waittillmatch({#notetrack:"gib = \"head\""}, #"_anim_notify_");
    cliententgibhead(localclientnum, entity);
}

// Namespace gibclientutils/gib
// Params 1, eflags: 0x4
// Checksum 0x45b0fb7c, Offset: 0x22c0
// Size: 0x7c
function private _handlegibrightarm(localclientnum) {
    entity = self;
    entity endon(#"death");
    entity waittillmatch({#notetrack:"gib = \"arm_right\""}, #"_anim_notify_");
    cliententgibrightarm(localclientnum, entity);
}

// Namespace gibclientutils/gib
// Params 1, eflags: 0x4
// Checksum 0x5af93cfb, Offset: 0x2348
// Size: 0x7c
function private _handlegibleftarm(localclientnum) {
    entity = self;
    entity endon(#"death");
    entity waittillmatch({#notetrack:"gib = \"arm_left\""}, #"_anim_notify_");
    cliententgibleftarm(localclientnum, entity);
}

// Namespace gibclientutils/gib
// Params 1, eflags: 0x4
// Checksum 0xad694a27, Offset: 0x23d0
// Size: 0x7c
function private _handlegibrightleg(localclientnum) {
    entity = self;
    entity endon(#"death");
    entity waittillmatch({#notetrack:"gib = \"leg_right\""}, #"_anim_notify_");
    cliententgibrightleg(localclientnum, entity);
}

// Namespace gibclientutils/gib
// Params 1, eflags: 0x4
// Checksum 0x6c84f10f, Offset: 0x2458
// Size: 0x7c
function private _handlegibleftleg(localclientnum) {
    entity = self;
    entity endon(#"death");
    entity waittillmatch({#notetrack:"gib = \"leg_left\""}, #"_anim_notify_");
    cliententgibleftleg(localclientnum, entity);
}

// Namespace gibclientutils/gib
// Params 1, eflags: 0x4
// Checksum 0xe2549286, Offset: 0x24e0
// Size: 0x88
function private _hasgibdef(entity) {
    return isdefined(entity.gib_data) && isdefined(entity.gib_data.gibdef) || isdefined(entity.gibdef) || isdefined(entity getplayergibdef("arms")) && isdefined(entity getplayergibdef("legs"));
}

// Namespace gibclientutils/gib
// Params 4, eflags: 0x0
// Checksum 0x597250b0, Offset: 0x2570
// Size: 0x102
function _playgibfx(localclientnum, entity, fxfilename, fxtag) {
    if (isdefined(fxfilename) && isdefined(fxtag) && entity hasdobj(localclientnum)) {
        fx = util::playfxontag(localclientnum, fxfilename, entity, fxtag);
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
// Checksum 0xe79cb3f3, Offset: 0x2680
// Size: 0x44
function _playgibsound(localclientnum, entity, soundalias) {
    if (isdefined(soundalias)) {
        playsound(localclientnum, soundalias, entity.origin);
    }
}

// Namespace gibclientutils/gib
// Params 4, eflags: 0x0
// Checksum 0xc343ab85, Offset: 0x26d0
// Size: 0xde
function addgibcallback(localclientnum, entity, gibflag, callbackfunction) {
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
// Params 2, eflags: 0x0
// Checksum 0x1630bb87, Offset: 0x27b8
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
// Checksum 0xa756140a, Offset: 0x2840
// Size: 0x34
function cliententgibhead(localclientnum, entity) {
    _gibclientextrainternal(localclientnum, entity, 8);
}

// Namespace gibclientutils/gib
// Params 2, eflags: 0x0
// Checksum 0xf49bcff8, Offset: 0x2880
// Size: 0x54
function cliententgibleftarm(localclientnum, entity) {
    if (isgibbed(localclientnum, entity, 16)) {
        return;
    }
    _gibcliententityinternal(localclientnum, entity, 32);
}

// Namespace gibclientutils/gib
// Params 2, eflags: 0x0
// Checksum 0xb28995ca, Offset: 0x28e0
// Size: 0x54
function cliententgibrightarm(localclientnum, entity) {
    if (isgibbed(localclientnum, entity, 32)) {
        return;
    }
    _gibcliententityinternal(localclientnum, entity, 16);
}

// Namespace gibclientutils/gib
// Params 2, eflags: 0x0
// Checksum 0x3690894d, Offset: 0x2940
// Size: 0x34
function cliententgibleftleg(localclientnum, entity) {
    _gibcliententityinternal(localclientnum, entity, 256);
}

// Namespace gibclientutils/gib
// Params 2, eflags: 0x0
// Checksum 0x5c2209ee, Offset: 0x2980
// Size: 0x34
function cliententgibrightleg(localclientnum, entity) {
    _gibcliententityinternal(localclientnum, entity, 128);
}

// Namespace gibclientutils/gib
// Params 2, eflags: 0x0
// Checksum 0xb62adf24, Offset: 0x29c0
// Size: 0x330
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
// Checksum 0x36849f35, Offset: 0x2cf8
// Size: 0x38
function isgibbed(localclientnum, entity, gibflag) {
    return _getgibbedstate(localclientnum, entity) & gibflag;
}

// Namespace gibclientutils/gib
// Params 2, eflags: 0x0
// Checksum 0x1ba09b78, Offset: 0x2d38
// Size: 0x2e
function isundamaged(localclientnum, entity) {
    return _getgibbedstate(localclientnum, entity) == 0;
}

// Namespace gibclientutils/gib
// Params 2, eflags: 0x0
// Checksum 0xb00bcd19, Offset: 0x2d70
// Size: 0x66
function gibentity(localclientnum, gibflags) {
    self _gibentity(localclientnum, gibflags, 1);
    self.gib_state = _getgibbedstate(localclientnum, self) | gibflags & 512 - 1;
}

// Namespace gibclientutils/gib
// Params 1, eflags: 0x0
// Checksum 0x226e0937, Offset: 0x2de0
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
// Checksum 0xd9b5d9e8, Offset: 0x2e98
// Size: 0x2c
function playergibleftarm(localclientnum) {
    self gibentity(localclientnum, 32);
}

// Namespace gibclientutils/gib
// Params 1, eflags: 0x0
// Checksum 0x9e0920aa, Offset: 0x2ed0
// Size: 0x2c
function playergibrightarm(localclientnum) {
    self gibentity(localclientnum, 16);
}

// Namespace gibclientutils/gib
// Params 1, eflags: 0x0
// Checksum 0x20e5f9ac, Offset: 0x2f08
// Size: 0x2c
function playergibleftleg(localclientnum) {
    self gibentity(localclientnum, 256);
}

// Namespace gibclientutils/gib
// Params 1, eflags: 0x0
// Checksum 0x5ad83d4, Offset: 0x2f40
// Size: 0x2c
function playergibrightleg(localclientnum) {
    self gibentity(localclientnum, 128);
}

// Namespace gibclientutils/gib
// Params 1, eflags: 0x0
// Checksum 0x6a7f68b6, Offset: 0x2f78
// Size: 0x4c
function playergiblegs(localclientnum) {
    self gibentity(localclientnum, 128);
    self gibentity(localclientnum, 256);
}

// Namespace gibclientutils/gib
// Params 2, eflags: 0x0
// Checksum 0x8b7498f3, Offset: 0x2fd0
// Size: 0x2a
function playergibtag(localclientnum, gibflag) {
    return _gibpiecetag(localclientnum, self, gibflag);
}

