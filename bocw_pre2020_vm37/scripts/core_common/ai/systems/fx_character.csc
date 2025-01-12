#using scripts\core_common\ai\systems\destructible_character;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\struct;

#namespace fx_character;

// Namespace fx_character/fx_character
// Params 0, eflags: 0x2
// Checksum 0x4f10e06, Offset: 0xd0
// Size: 0x240
function autoexec main() {
    fxbundles = getscriptbundles("fxcharacterdef");
    processedfxbundles = [];
    foreach (fxbundle in fxbundles) {
        processedfxbundle = spawnstruct();
        processedfxbundle.effectcount = fxbundle.effectcount;
        processedfxbundle.fx = [];
        processedfxbundle.name = fxbundle.name;
        for (index = 1; index <= fxbundle.effectcount; index++) {
            fx = fxbundle.("effect" + index + "_fx");
            if (isdefined(fx)) {
                fxstruct = spawnstruct();
                fxstruct.attachtag = fxbundle.("effect" + index + "_attachtag");
                fxstruct.fx = fxbundle.("effect" + index + "_fx");
                fxstruct.stopongib = fxclientutils::_gibpartnametogibflag(fxbundle.("effect" + index + "_stopongib"));
                fxstruct.stoponpiecedestroyed = fxbundle.("effect" + index + "_stoponpiecedestroyed");
                processedfxbundle.fx[processedfxbundle.fx.size] = fxstruct;
            }
        }
        processedfxbundles[fxbundle.name] = processedfxbundle;
    }
    level.fxcharacterdefs = processedfxbundles;
}

#namespace fxclientutils;

// Namespace fxclientutils/fx_character
// Params 1, eflags: 0x5 linked
// Checksum 0xa08dc066, Offset: 0x318
// Size: 0x1c
function private _getfxbundle(name) {
    return level.fxcharacterdefs[name];
}

// Namespace fxclientutils/fx_character
// Params 2, eflags: 0x5 linked
// Checksum 0xecd40f46, Offset: 0x340
// Size: 0x13c
function private _configentity(localclientnum, entity) {
    if (!isdefined(entity._fxcharacter)) {
        entity._fxcharacter = [];
        handledgibs = array(8, 16, 32, 128, 256);
        foreach (gibflag in handledgibs) {
            gibclientutils::addgibcallback(localclientnum, entity, gibflag, &_gibhandler);
        }
        for (index = 1; index <= 20; index++) {
            destructclientutils::adddestructpiececallback(localclientnum, entity, index, &_destructhandler);
        }
    }
}

// Namespace fxclientutils/fx_character
// Params 3, eflags: 0x5 linked
// Checksum 0x6232f4f0, Offset: 0x488
// Size: 0x132
function private _destructhandler(localclientnum, entity, piecenumber) {
    if (!isdefined(entity._fxcharacter)) {
        return;
    }
    foreach (fxbundlename, fxbundleinst in entity._fxcharacter) {
        fxbundle = _getfxbundle(fxbundlename);
        for (index = 0; index < fxbundle.fx.size; index++) {
            if (isdefined(fxbundleinst[index]) && fxbundle.fx[index].stoponpiecedestroyed === piecenumber) {
                stopfx(localclientnum, fxbundleinst[index]);
                fxbundleinst[index] = undefined;
            }
        }
    }
}

// Namespace fxclientutils/fx_character
// Params 3, eflags: 0x5 linked
// Checksum 0x2fe93f34, Offset: 0x5c8
// Size: 0x132
function private _gibhandler(localclientnum, entity, gibflag) {
    if (!isdefined(entity._fxcharacter)) {
        return;
    }
    foreach (fxbundlename, fxbundleinst in entity._fxcharacter) {
        fxbundle = _getfxbundle(fxbundlename);
        for (index = 0; index < fxbundle.fx.size; index++) {
            if (isdefined(fxbundleinst[index]) && fxbundle.fx[index].stopongib === gibflag) {
                stopfx(localclientnum, fxbundleinst[index]);
                fxbundleinst[index] = undefined;
            }
        }
    }
}

// Namespace fxclientutils/fx_character
// Params 1, eflags: 0x5 linked
// Checksum 0x578d74ae, Offset: 0x708
// Size: 0x92
function private _gibpartnametogibflag(gibpartname) {
    if (isdefined(gibpartname)) {
        switch (gibpartname) {
        case #"head":
            return 8;
        case #"right arm":
            return 16;
        case #"left arm":
            return 32;
        case #"right leg":
            return 128;
        case #"left leg":
            return 256;
        }
    }
}

// Namespace fxclientutils/fx_character
// Params 3, eflags: 0x5 linked
// Checksum 0x66304413, Offset: 0x7a8
// Size: 0x42
function private _isgibbed(localclientnum, entity, stopongibflag) {
    if (!isdefined(stopongibflag)) {
        return 0;
    }
    return gibclientutils::isgibbed(localclientnum, entity, stopongibflag);
}

// Namespace fxclientutils/fx_character
// Params 3, eflags: 0x5 linked
// Checksum 0x7244815c, Offset: 0x7f8
// Size: 0x42
function private _ispiecedestructed(localclientnum, entity, stoponpiecedestroyed) {
    if (!isdefined(stoponpiecedestroyed)) {
        return 0;
    }
    return destructclientutils::ispiecedestructed(localclientnum, entity, stoponpiecedestroyed);
}

// Namespace fxclientutils/fx_character
// Params 3, eflags: 0x5 linked
// Checksum 0x8e2d2b34, Offset: 0x848
// Size: 0x6e
function private _shouldplayfx(localclientnum, entity, fxstruct) {
    if (_isgibbed(localclientnum, entity, fxstruct.stopongib)) {
        return false;
    }
    if (_ispiecedestructed(localclientnum, entity, fxstruct.stoponpiecedestroyed)) {
        return false;
    }
    return true;
}

// Namespace fxclientutils/fx_character
// Params 3, eflags: 0x1 linked
// Checksum 0xaa9b89ad, Offset: 0x8c0
// Size: 0x134
function playfxbundle(localclientnum, entity, fxscriptbundle) {
    if (!isdefined(fxscriptbundle)) {
        return;
    }
    _configentity(localclientnum, entity);
    fxbundle = _getfxbundle(fxscriptbundle);
    if (isdefined(entity._fxcharacter[fxbundle.name])) {
        return;
    }
    if (isdefined(fxbundle)) {
        playingfx = [];
        for (index = 0; index < fxbundle.fx.size; index++) {
            fxstruct = fxbundle.fx[index];
            if (_shouldplayfx(localclientnum, entity, fxstruct)) {
                playingfx[index] = gibclientutils::_playgibfx(localclientnum, entity, fxstruct.fx, fxstruct.attachtag);
            }
        }
        if (playingfx.size > 0) {
            entity._fxcharacter[fxbundle.name] = playingfx;
        }
    }
}

// Namespace fxclientutils/fx_character
// Params 2, eflags: 0x0
// Checksum 0x7ac794d, Offset: 0xa00
// Size: 0x130
function stopallfxbundles(localclientnum, entity) {
    _configentity(localclientnum, entity);
    fxbundlenames = [];
    foreach (fxbundlename, fxbundle in entity._fxcharacter) {
        fxbundlenames[fxbundlenames.size] = fxbundlename;
    }
    foreach (fxbundlename in fxbundlenames) {
        stopfxbundle(localclientnum, entity, fxbundlename);
    }
}

// Namespace fxclientutils/fx_character
// Params 3, eflags: 0x1 linked
// Checksum 0x39b11be, Offset: 0xb38
// Size: 0x124
function stopfxbundle(localclientnum, entity, fxscriptbundle) {
    if (!isdefined(fxscriptbundle)) {
        return;
    }
    _configentity(localclientnum, entity);
    fxbundle = _getfxbundle(fxscriptbundle);
    if (isdefined(entity._fxcharacter[fxbundle.name])) {
        foreach (fx in entity._fxcharacter[fxbundle.name]) {
            if (isdefined(fx)) {
                stopfx(localclientnum, fx);
            }
        }
        entity._fxcharacter[fxbundle.name] = undefined;
    }
}

// Namespace fxclientutils/fx_character
// Params 3, eflags: 0x1 linked
// Checksum 0xd79ca500, Offset: 0xc68
// Size: 0x124
function function_ae92446(localclientnum, entity, fxscriptbundle) {
    if (!isdefined(fxscriptbundle)) {
        return;
    }
    _configentity(localclientnum, entity);
    fxbundle = _getfxbundle(fxscriptbundle);
    if (isdefined(entity._fxcharacter[fxbundle.name])) {
        foreach (fx in entity._fxcharacter[fxbundle.name]) {
            if (isdefined(fx)) {
                killfx(localclientnum, fx);
            }
        }
        entity._fxcharacter[fxbundle.name] = undefined;
    }
}

