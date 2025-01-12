#using scripts/core_common/ai/systems/gib;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;

#namespace destructible_character;

// Namespace destructible_character/destructible_character
// Params 0, eflags: 0x2
// Checksum 0x7ef954e8, Offset: 0x1b0
// Size: 0x3a8
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
            piecestruct.gibdynentfx = destructible.("piece" + index + "_gibdynentfx");
            piecestruct.gibsound = destructible.("piece" + index + "_gibsound");
            piecestruct.hitlocation = destructible.("piece" + index + "_hitlocation");
            piecestruct.hidetag = destructible.("piece" + index + "_hidetag");
            piecestruct.detachmodel = destructible.("piece" + index + "_detachmodel");
            destructbundle.pieces[destructbundle.pieces.size] = piecestruct;
        }
        processedbundles[destructible.name] = destructbundle;
    }
    level.destructiblecharacterdefs = processedbundles;
}

#namespace destructclientutils;

// Namespace destructclientutils/destructible_character
// Params 1, eflags: 0x4
// Checksum 0xa844a832, Offset: 0x560
// Size: 0x28
function private _getdestructibledef(entity) {
    return level.destructiblecharacterdefs[entity.destructibledef];
}

// Namespace destructclientutils/destructible_character
// Params 7, eflags: 0x4
// Checksum 0xcfe89403, Offset: 0x590
// Size: 0x138
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
// Checksum 0x4b8135d9, Offset: 0x6d0
// Size: 0x154
function private _destructpiece(localclientnum, entity, piecenumber, shouldspawngibs) {
    if (!isdefined(entity.destructibledef)) {
        return;
    }
    destructbundle = _getdestructibledef(entity);
    piece = destructbundle.pieces[piecenumber - 1];
    if (isdefined(piece)) {
        if (shouldspawngibs) {
            gibclientutils::_playgibfx(localclientnum, entity, piece.gibfx, piece.gibfxtag);
            entity thread gibclientutils::_gibpiece(localclientnum, entity, piece.gibmodel, piece.gibtag, piece.gibdynentfx);
            gibclientutils::_playgibsound(localclientnum, entity, piece.gibsound);
        }
        _handledestructcallbacks(localclientnum, entity, piecenumber);
    }
}

// Namespace destructclientutils/destructible_character
// Params 2, eflags: 0x4
// Checksum 0x60b9c8dc, Offset: 0x830
// Size: 0x3a
function private _getdestructstate(localclientnum, entity) {
    if (isdefined(entity._destruct_state)) {
        return entity._destruct_state;
    }
    return 0;
}

// Namespace destructclientutils/destructible_character
// Params 3, eflags: 0x4
// Checksum 0xedbe6f64, Offset: 0x878
// Size: 0xf4
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
// Checksum 0x975e422a, Offset: 0x978
// Size: 0xf6
function adddestructpiececallback(localclientnum, entity, piecenumber, callbackfunction) {
    /#
        assert(isfunctionptr(callbackfunction));
    #/
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
// Checksum 0x153ddb, Offset: 0xa78
// Size: 0x3e
function ispiecedestructed(localclientnum, entity, piecenumber) {
    return _getdestructstate(localclientnum, entity) & 1 << piecenumber;
}

