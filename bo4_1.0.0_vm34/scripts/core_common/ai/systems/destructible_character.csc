#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;

#namespace destructible_character;

// Namespace destructible_character/destructible_character
// Params 0, eflags: 0x2
// Checksum 0x41cd9faf, Offset: 0x158
// Size: 0x5e6
function autoexec main() {
    clientfield::register("actor", "destructible_character_state", 1, 21, "int", &destructclientutils::_destructhandler, 0, 0);
    destructibles = struct::get_script_bundles("destructiblecharacterdef");
    processedbundles = [];
    foreach (destructible in destructibles) {
        destructbundle = spawnstruct();
        destructbundle.piececount = destructible.piececount;
        destructbundle.pieces = [];
        destructbundle.name = destructible.name;
        for (index = 1; index <= destructbundle.piececount; index++) {
            piecestruct = spawnstruct();
            piecestruct.gibmodel = destructible.("piece" + index + "_gibmodel");
            piecestruct.gibtag = destructible.("piece" + index + "_gibtag");
            piecestruct.gibfx = destructible.("piece" + index + "_gibfx");
            piecestruct.gibfxtag = destructible.("piece" + index + "_gibeffecttag");
            if (isdefined(destructible.("piece" + index + "_gibdirX")) || isdefined(destructible.("piece" + index + "_gibdirY")) || isdefined(destructible.("piece" + index + "_gibdirZ"))) {
                piecestruct.gibdir = (isdefined(destructible.("piece" + index + "_gibdirX")) ? destructible.("piece" + index + "_gibdirX") : 0, isdefined(destructible.("piece" + index + "_gibdirY")) ? destructible.("piece" + index + "_gibdirY") : 0, isdefined(destructible.("piece" + index + "_gibdirZ")) ? destructible.("piece" + index + "_gibdirZ") : 0);
            }
            piecestruct.gibdirscale = destructible.("piece" + index + "_gibdirscale");
            piecestruct.gibdynentfx = destructible.("piece" + index + "_gibdynentfx");
            piecestruct.gibsound = destructible.("piece" + index + "_gibsound");
            piecestruct.hitlocation = destructible.("piece" + index + "_hitlocation");
            piecestruct.hidetag = destructible.("piece" + index + "_hidetag");
            piecestruct.detachmodel = destructible.("piece" + index + "_detachmodel");
            if (isdefined(destructible.("piece" + index + "_hittags"))) {
                piecestruct.hittags = [];
                foreach (var_d4e0cbeb in destructible.("piece" + index + "_hittags")) {
                    if (!isdefined(piecestruct.hittags)) {
                        piecestruct.hittags = [];
                    } else if (!isarray(piecestruct.hittags)) {
                        piecestruct.hittags = array(piecestruct.hittags);
                    }
                    piecestruct.hittags[piecestruct.hittags.size] = var_d4e0cbeb.hittag;
                }
            }
            destructbundle.pieces[destructbundle.pieces.size] = piecestruct;
        }
        processedbundles[destructible.name] = destructbundle;
    }
    level.destructiblecharacterdefs = processedbundles;
}

#namespace destructclientutils;

// Namespace destructclientutils/destructible_character
// Params 1, eflags: 0x4
// Checksum 0xc54b6001, Offset: 0x748
// Size: 0x20
function private _getdestructibledef(entity) {
    return level.destructiblecharacterdefs[entity.destructibledef];
}

// Namespace destructclientutils/destructible_character
// Params 7, eflags: 0x4
// Checksum 0xf89900a9, Offset: 0x770
// Size: 0x122
function private _destructhandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    entity = self;
    destructflags = oldvalue ^ newvalue;
    shouldspawngibs = newvalue & 1;
    if (bnewent) {
        destructflags = 0 ^ newvalue;
    }
    if (!isdefined(entity.destructibledef)) {
        return;
    }
    currentdestructflag = 2;
    for (piecenumber = 1; destructflags >= currentdestructflag; piecenumber++) {
        if (destructflags & currentdestructflag) {
            _destructpiece(localclientnum, entity, piecenumber, shouldspawngibs);
        }
        currentdestructflag <<= 1;
    }
    entity._destruct_state = newvalue;
}

// Namespace destructclientutils/destructible_character
// Params 4, eflags: 0x4
// Checksum 0x3954f42c, Offset: 0x8a0
// Size: 0x1ac
function private _destructpiece(localclientnum, entity, piecenumber, shouldspawngibs) {
    if (!isdefined(entity.destructibledef)) {
        return;
    }
    destructbundle = _getdestructibledef(entity);
    piece = destructbundle.pieces[piecenumber - 1];
    if (isdefined(piece)) {
        if (shouldspawngibs) {
            gibclientutils::_playgibfx(localclientnum, entity, piece.gibfx, piece.gibfxtag);
            entity thread gibclientutils::_gibpiece(localclientnum, entity, piece.gibmodel, piece.gibtag, piece.gibdynentfx, piece.gibdir, piece.gibdirscale);
            gibclientutils::_playgibsound(localclientnum, entity, piece.gibsound);
        } else if (isdefined(piece.gibfx) && function_7d14ac3b(piece.gibfx)) {
            gibclientutils::_playgibfx(localclientnum, entity, piece.gibfx, piece.gibfxtag);
        }
        _handledestructcallbacks(localclientnum, entity, piecenumber);
    }
}

// Namespace destructclientutils/destructible_character
// Params 2, eflags: 0x4
// Checksum 0x17c51d16, Offset: 0xa58
// Size: 0x32
function private _getdestructstate(localclientnum, entity) {
    if (isdefined(entity._destruct_state)) {
        return entity._destruct_state;
    }
    return 0;
}

// Namespace destructclientutils/destructible_character
// Params 3, eflags: 0x4
// Checksum 0x1a9bc910, Offset: 0xa98
// Size: 0xd8
function private _handledestructcallbacks(localclientnum, entity, piecenumber) {
    if (isdefined(entity._destructcallbacks) && isdefined(entity._destructcallbacks[piecenumber])) {
        foreach (callback in entity._destructcallbacks[piecenumber]) {
            if (isfunctionptr(callback)) {
                [[ callback ]](localclientnum, entity, piecenumber);
            }
        }
    }
}

// Namespace destructclientutils/destructible_character
// Params 4, eflags: 0x0
// Checksum 0x538eb55e, Offset: 0xb78
// Size: 0xde
function adddestructpiececallback(localclientnum, entity, piecenumber, callbackfunction) {
    assert(isfunctionptr(callbackfunction));
    if (!isdefined(entity._destructcallbacks)) {
        entity._destructcallbacks = [];
    }
    if (!isdefined(entity._destructcallbacks[piecenumber])) {
        entity._destructcallbacks[piecenumber] = [];
    }
    destructcallbacks = entity._destructcallbacks[piecenumber];
    destructcallbacks[destructcallbacks.size] = callbackfunction;
    entity._destructcallbacks[piecenumber] = destructcallbacks;
}

// Namespace destructclientutils/destructible_character
// Params 3, eflags: 0x0
// Checksum 0xf6444c61, Offset: 0xc60
// Size: 0x3e
function ispiecedestructed(localclientnum, entity, piecenumber) {
    return _getdestructstate(localclientnum, entity) & 1 << piecenumber;
}

