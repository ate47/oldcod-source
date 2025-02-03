#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;

#namespace destructserverutils;

// Namespace destructserverutils/destructible_character
// Params 0, eflags: 0x6
// Checksum 0xa48cec22, Offset: 0x260
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"destructible_character", &preinit, undefined, undefined, undefined);
}

// Namespace destructserverutils/destructible_character
// Params 0, eflags: 0x4
// Checksum 0xcdf7f268, Offset: 0x2a8
// Size: 0x5b0
function private preinit() {
    clientfield::register("actor", "destructible_character_state", 1, 21, "int");
    destructibles = getscriptbundles("destructiblecharacterdef");
    processedbundles = [];
    foreach (destructible in destructibles) {
        destructbundle = spawnstruct();
        destructbundle.piececount = destructible.piececount;
        destructbundle.pieces = [];
        destructbundle.name = destructible.name;
        for (index = 1; index <= destructbundle.piececount; index++) {
            piecestruct = spawnstruct();
            piecestruct.name = destructible.("piece" + index + "_name");
            piecestruct.gibmodel = destructible.("piece" + index + "_gibmodel");
            piecestruct.gibtag = destructible.("piece" + index + "_gibtag");
            piecestruct.gibfx = destructible.("piece" + index + "_gibfx");
            piecestruct.gibfxtag = destructible.("piece" + index + "_gibeffecttag");
            piecestruct.gibdynentfx = destructible.("piece" + index + "_gibdynentfx");
            piecestruct.gibsound = destructible.("piece" + index + "_gibsound");
            piecestruct.hitlocation = destructible.("piece" + index + "_hitlocation");
            piecestruct.hidetag = destructible.("piece" + index + "_hidetag");
            piecestruct.detachmodel = destructible.("piece" + index + "_detachmodel");
            piecestruct.detachtag = destructible.("piece" + index + "_detachtag");
            if (isdefined(destructible.("piece" + index + "_hittags"))) {
                piecestruct.hittags = [];
                foreach (var_5440c126 in destructible.("piece" + index + "_hittags")) {
                    if (!isdefined(piecestruct.hittags)) {
                        piecestruct.hittags = [];
                    } else if (!isarray(piecestruct.hittags)) {
                        piecestruct.hittags = array(piecestruct.hittags);
                    }
                    piecestruct.hittags[piecestruct.hittags.size] = var_5440c126.hittag;
                }
            }
            if (isdefined(destructible.("piece" + index + "_additionalhitlocations"))) {
                piecestruct.hittags = [];
                foreach (var_9c2171bc in destructible.("piece" + index + "_additionalhitlocations")) {
                    if (!isdefined(piecestruct.var_47627399)) {
                        piecestruct.var_47627399 = [];
                    } else if (!isarray(piecestruct.var_47627399)) {
                        piecestruct.var_47627399 = array(piecestruct.var_47627399);
                    }
                    piecestruct.var_47627399[piecestruct.var_47627399.size] = var_9c2171bc.hitlocation;
                }
            }
            destructbundle.pieces[destructbundle.pieces.size] = piecestruct;
        }
        processedbundles[destructible.name] = destructbundle;
    }
    level.destructiblecharacterdefs = processedbundles;
}

// Namespace destructserverutils/destructible_character
// Params 1, eflags: 0x4
// Checksum 0xdff1c64e, Offset: 0x860
// Size: 0x20
function private _getdestructibledef(entity) {
    return level.destructiblecharacterdefs[entity.destructibledef];
}

// Namespace destructserverutils/destructible_character
// Params 1, eflags: 0x0
// Checksum 0x9b06f883, Offset: 0x888
// Size: 0x2a
function getdestructstate(entity) {
    if (isdefined(entity._destruct_state)) {
        return entity._destruct_state;
    }
    return 0;
}

// Namespace destructserverutils/destructible_character
// Params 3, eflags: 0x0
// Checksum 0xc6553d92, Offset: 0x8c0
// Size: 0x5c
function function_f865501b(entity, var_e9807706, var_9cea16fe) {
    entity._destruct_state = var_e9807706;
    togglespawngibs(entity, var_9cea16fe);
    reapplydestructedpieces(entity);
}

// Namespace destructserverutils/destructible_character
// Params 2, eflags: 0x4
// Checksum 0x3c9f5b39, Offset: 0x928
// Size: 0x64
function private _setdestructed(entity, destructflag) {
    entity._destruct_state = getdestructstate(entity) | destructflag;
    entity clientfield::set("destructible_character_state", entity._destruct_state);
}

// Namespace destructserverutils/destructible_character
// Params 2, eflags: 0x0
// Checksum 0xd019b84b, Offset: 0x998
// Size: 0x64
function copydestructstate(originalentity, newentity) {
    newentity._destruct_state = getdestructstate(originalentity);
    togglespawngibs(newentity, 0);
    reapplydestructedpieces(newentity);
}

// Namespace destructserverutils/destructible_character
// Params 2, eflags: 0x0
// Checksum 0xa2ce2308, Offset: 0xa08
// Size: 0xd4
function function_8475c53a(entity, piecename) {
    if (isdefined(entity.destructibledef)) {
        destructbundle = _getdestructibledef(entity);
        for (index = 1; index <= destructbundle.pieces.size; index++) {
            piece = destructbundle.pieces[index - 1];
            if (isdefined(piece.name) && piece.name == piecename) {
                destructpiece(entity, index);
            }
        }
    }
}

// Namespace destructserverutils/destructible_character
// Params 2, eflags: 0x0
// Checksum 0x190d9227, Offset: 0xae8
// Size: 0x104
function destructhitlocpieces(entity, hitloc) {
    if (isdefined(entity.destructibledef)) {
        destructbundle = _getdestructibledef(entity);
        for (index = 1; index <= destructbundle.pieces.size; index++) {
            piece = destructbundle.pieces[index - 1];
            if (isdefined(piece.hitlocation) && piece.hitlocation === hitloc || isdefined(piece.var_47627399) && isinarray(piece.var_47627399, hitloc)) {
                destructpiece(entity, index);
            }
        }
    }
}

// Namespace destructserverutils/destructible_character
// Params 2, eflags: 0x0
// Checksum 0xc406a0e0, Offset: 0xbf8
// Size: 0xec
function function_629a8d54(entity, hittag) {
    if (isdefined(hittag) && isdefined(entity.destructibledef)) {
        destructbundle = _getdestructibledef(entity);
        for (index = 1; index <= destructbundle.pieces.size; index++) {
            piece = destructbundle.pieces[index - 1];
            if (isdefined(piece.hittags) && isinarray(piece.hittags, hittag)) {
                destructpiece(entity, index);
            }
        }
    }
}

// Namespace destructserverutils/destructible_character
// Params 1, eflags: 0x0
// Checksum 0xbe2a08f, Offset: 0xcf0
// Size: 0x6c
function destructleftarmpieces(entity) {
    destructhitlocpieces(entity, "left_arm_upper");
    destructhitlocpieces(entity, "left_arm_lower");
    destructhitlocpieces(entity, "left_hand");
}

// Namespace destructserverutils/destructible_character
// Params 1, eflags: 0x0
// Checksum 0x8b37359d, Offset: 0xd68
// Size: 0x6c
function destructleftlegpieces(entity) {
    destructhitlocpieces(entity, "left_leg_upper");
    destructhitlocpieces(entity, "left_leg_lower");
    destructhitlocpieces(entity, "left_foot");
}

// Namespace destructserverutils/destructible_character
// Params 2, eflags: 0x0
// Checksum 0xea657271, Offset: 0xde0
// Size: 0x1ac
function destructpiece(entity, piecenumber) {
    assert(1 <= piecenumber && piecenumber <= 20);
    if (isdestructed(entity, piecenumber)) {
        return;
    }
    _setdestructed(entity, 1 << piecenumber);
    if (!isdefined(entity.destructibledef)) {
        return;
    }
    destructbundle = _getdestructibledef(entity);
    piece = destructbundle.pieces[piecenumber - 1];
    if (isdefined(piece.hidetag) && entity haspart(piece.hidetag)) {
        entity hidepart(piece.hidetag);
    }
    if (isdefined(piece.detachmodel) && entity isattached(piece.detachmodel)) {
        detachtag = "";
        if (isdefined(piece.detachtag)) {
            detachtag = piece.detachtag;
        }
        entity detach(piece.detachmodel, detachtag);
    }
}

// Namespace destructserverutils/destructible_character
// Params 2, eflags: 0x0
// Checksum 0x339556dc, Offset: 0xf98
// Size: 0x15c
function destructnumberrandompieces(entity, num_pieces_to_destruct = 0) {
    destructible_pieces_list = [];
    destructablepieces = getpiececount(entity);
    if (num_pieces_to_destruct == 0) {
        num_pieces_to_destruct = destructablepieces;
    }
    for (i = 0; i < destructablepieces; i++) {
        destructible_pieces_list[i] = i + 1;
    }
    destructible_pieces_list = array::randomize(destructible_pieces_list);
    foreach (piece in destructible_pieces_list) {
        if (!isdestructed(entity, piece)) {
            destructpiece(entity, piece);
            num_pieces_to_destruct--;
            if (num_pieces_to_destruct == 0) {
                break;
            }
        }
    }
}

// Namespace destructserverutils/destructible_character
// Params 1, eflags: 0x0
// Checksum 0x134f1c09, Offset: 0x1100
// Size: 0x7c
function destructrandompieces(entity) {
    destructpieces = getpiececount(entity);
    for (index = 0; index < destructpieces; index++) {
        if (math::cointoss()) {
            destructpiece(entity, index + 1);
        }
    }
}

// Namespace destructserverutils/destructible_character
// Params 1, eflags: 0x0
// Checksum 0x404a58b4, Offset: 0x1188
// Size: 0x6c
function destructrightarmpieces(entity) {
    destructhitlocpieces(entity, "right_arm_upper");
    destructhitlocpieces(entity, "right_arm_lower");
    destructhitlocpieces(entity, "right_hand");
}

// Namespace destructserverutils/destructible_character
// Params 1, eflags: 0x0
// Checksum 0xbe8271, Offset: 0x1200
// Size: 0x6c
function destructrightlegpieces(entity) {
    destructhitlocpieces(entity, "right_leg_upper");
    destructhitlocpieces(entity, "right_leg_lower");
    destructhitlocpieces(entity, "right_foot");
}

// Namespace destructserverutils/destructible_character
// Params 1, eflags: 0x0
// Checksum 0x78091ff, Offset: 0x1278
// Size: 0x52
function getpiececount(entity) {
    if (isdefined(entity.destructibledef)) {
        destructbundle = _getdestructibledef(entity);
        if (isdefined(destructbundle)) {
            return destructbundle.piececount;
        }
    }
    return 0;
}

// Namespace destructserverutils/destructible_character
// Params 12, eflags: 0x0
// Checksum 0x3a54b5fe, Offset: 0x12d8
// Size: 0x130
function handledamage(*einflictor, *eattacker, idamage, *idflags, *smeansofdeath, *weapon, *vpoint, *vdir, shitloc, *psoffsettime, var_a9e3f040, *modelindex) {
    entity = self;
    if (is_true(entity.skipdeath)) {
        return psoffsettime;
    }
    togglespawngibs(entity, 1);
    destructhitlocpieces(entity, var_a9e3f040);
    if (isdefined(modelindex)) {
        bonename = modelindex;
        if (!isstring(modelindex)) {
            bonename = getpartname(entity, modelindex);
        }
        if (isdefined(bonename)) {
            function_629a8d54(entity, bonename);
        }
    }
    return psoffsettime;
}

// Namespace destructserverutils/destructible_character
// Params 3, eflags: 0x0
// Checksum 0xb94bc9bc, Offset: 0x1410
// Size: 0xb4
function function_9885f550(entity, hitloc, var_a9e3f040) {
    togglespawngibs(entity, 1);
    destructhitlocpieces(entity, hitloc);
    if (isdefined(var_a9e3f040)) {
        bonename = var_a9e3f040;
        if (!isstring(var_a9e3f040)) {
            bonename = getpartname(entity, var_a9e3f040);
        }
        if (isdefined(bonename)) {
            function_629a8d54(entity, bonename);
        }
    }
}

// Namespace destructserverutils/destructible_character
// Params 2, eflags: 0x0
// Checksum 0xf255da5a, Offset: 0x14d0
// Size: 0x6e
function isdestructed(entity, piecenumber) {
    assert(1 <= piecenumber && piecenumber <= 20);
    return getdestructstate(entity) & 1 << piecenumber;
}

// Namespace destructserverutils/destructible_character
// Params 1, eflags: 0x0
// Checksum 0x8a3126fd, Offset: 0x1548
// Size: 0x17c
function reapplydestructedpieces(entity) {
    if (!isdefined(entity.destructibledef)) {
        return;
    }
    destructbundle = _getdestructibledef(entity);
    for (index = 1; index <= destructbundle.pieces.size; index++) {
        if (!isdestructed(entity, index)) {
            continue;
        }
        piece = destructbundle.pieces[index - 1];
        if (isdefined(piece.hidetag) && entity haspart(piece.hidetag)) {
            entity hidepart(piece.hidetag);
        }
        if (isdefined(piece.detachmodel)) {
            detachtag = "";
            if (isdefined(piece.detachtag)) {
                detachtag = piece.detachtag;
            }
            if (entity isattached(piece.detachmodel, detachtag)) {
                entity detach(piece.detachmodel, detachtag);
            }
        }
    }
}

// Namespace destructserverutils/destructible_character
// Params 1, eflags: 0x0
// Checksum 0xfd5fc3d3, Offset: 0x16d0
// Size: 0xdc
function showdestructedpieces(entity) {
    if (!isdefined(entity.destructibledef)) {
        return;
    }
    destructbundle = _getdestructibledef(entity);
    for (index = 1; index <= destructbundle.pieces.size; index++) {
        piece = destructbundle.pieces[index - 1];
        if (isdefined(piece.hidetag) && entity haspart(piece.hidetag)) {
            entity showpart(piece.hidetag);
        }
    }
}

// Namespace destructserverutils/destructible_character
// Params 2, eflags: 0x0
// Checksum 0x545ab06f, Offset: 0x17b8
// Size: 0x94
function togglespawngibs(entity, shouldspawngibs) {
    if (shouldspawngibs) {
        entity._destruct_state = getdestructstate(entity) | 1;
    } else {
        entity._destruct_state = getdestructstate(entity) & -2;
    }
    entity clientfield::set("destructible_character_state", entity._destruct_state);
}

