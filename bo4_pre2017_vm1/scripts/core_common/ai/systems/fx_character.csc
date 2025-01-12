#using scripts/core_common/ai/systems/destructible_character;
#using scripts/core_common/ai/systems/gib;
#using scripts/core_common/struct;

#namespace fx_character;

// Namespace fx_character/fx_character
// Params 0, eflags: 0x2
// Checksum 0xb2394c38, Offset: 0x180
// Size: 0x2b8
function autoexec main() {
    fxbundles = struct::get_script_bundles("fxcharacterdef");
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
// Params 1, eflags: 0x4
// Checksum 0x702a2a25, Offset: 0x440
// Size: 0x1c
function private _getfxbundle(name) {
    return level.fxcharacterdefs[name];
}

// Namespace fxclientutils/fx_character
// Params 2, eflags: 0x4
// Checksum 0x56705652, Offset: 0x468
// Size: 0x156
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
// Params 3, eflags: 0x4
// Checksum 0xe10b660a, Offset: 0x5c8
// Size: 0x166
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
// Params 3, eflags: 0x4
// Checksum 0x9451a821, Offset: 0x738
// Size: 0x166
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
// Params 1, eflags: 0x4
// Checksum 0xcd9ee4d8, Offset: 0x8a8
// Size: 0x6e
function private _gibpartnametogibflag(gibpartname) {
    if (isdefined(gibpartname)) {
        switch (gibpartname) {
        case #"head":
            return 8;
        case #"hash_bee411d3":
            return 16;
        case #"hash_9bea6b4c":
            return 32;
        case #"hash_e89bced9":
            return 128;
        case #"hash_3b50f9fa":
            return 256;
        }
    }
}

// Namespace fxclientutils/fx_character
// Params 3, eflags: 0x4
// Checksum 0xde52507a, Offset: 0x920
// Size: 0x4a
function private _isgibbed(localclientnum, entity, stopongibflag) {
    if (!isdefined(stopongibflag)) {
        return 0;
    }
    return gibclientutils::isgibbed(localclientnum, entity, stopongibflag);
}

// Namespace fxclientutils/fx_character
// Params 3, eflags: 0x4
// Checksum 0x69d240fe, Offset: 0x978
// Size: 0x4a
function private _ispiecedestructed(localclientnum, entity, stoponpiecedestroyed) {
    if (!isdefined(stoponpiecedestroyed)) {
        return 0;
    }
    return destructclientutils::ispiecedestructed(localclientnum, entity, stoponpiecedestroyed);
}

// Namespace fxclientutils/fx_character
// Params 3, eflags: 0x4
// Checksum 0x8202e5ab, Offset: 0x9d0
// Size: 0x7e
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
// Params 3, eflags: 0x0
// Checksum 0xd123c43, Offset: 0xa58
// Size: 0x186
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
// Checksum 0xb12708e6, Offset: 0xbe8
// Size: 0x14a
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
// Params 3, eflags: 0x0
// Checksum 0x189e0d54, Offset: 0xd40
// Size: 0x14c
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

