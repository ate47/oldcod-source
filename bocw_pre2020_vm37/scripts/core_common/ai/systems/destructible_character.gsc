#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;

#namespace destructserverutils;

// Namespace destructserverutils/destructible_character
// Params 0, eflags: 0x6
// Checksum 0x1da43a8a, Offset: 0x248
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"destructible_character", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace destructserverutils/destructible_character
// Params 0, eflags: 0x5 linked
// Checksum 0x1abc2c47, Offset: 0x290
// Size: 0x480
function private function_70a657d8() {
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
            destructbundle.pieces[destructbundle.pieces.size] = piecestruct;
        }
        processedbundles[destructible.name] = destructbundle;
    }
    level.destructiblecharacterdefs = processedbundles;
}

// Namespace destructserverutils/destructible_character
// Params 1, eflags: 0x5 linked
// Checksum 0x6450b16b, Offset: 0x718
// Size: 0x20
function private _getdestructibledef(entity) {
    return level.destructiblecharacterdefs[entity.destructibledef];
}

// Namespace destructserverutils/destructible_character
// Params 1, eflags: 0x1 linked
// Checksum 0x6da8cf52, Offset: 0x740
// Size: 0x2a
function function_b9568365(entity) {
    if (isdefined(entity._destruct_state)) {
        return entity._destruct_state;
    }
    return 0;
}

// Namespace destructserverutils/destructible_character
// Params 3, eflags: 0x0
// Checksum 0x68e7ea21, Offset: 0x778
// Size: 0x5c
function function_f865501b(entity, var_e9807706, var_9cea16fe) {
    entity._destruct_state = var_e9807706;
    togglespawngibs(entity, var_9cea16fe);
    reapplydestructedpieces(entity);
}

// Namespace destructserverutils/destructible_character
// Params 2, eflags: 0x5 linked
// Checksum 0x5b645db5, Offset: 0x7e0
// Size: 0x64
function private _setdestructed(entity, destructflag) {
    entity._destruct_state = function_b9568365(entity) | destructflag;
    entity clientfield::set("destructible_character_state", entity._destruct_state);
}

// Namespace destructserverutils/destructible_character
// Params 2, eflags: 0x1 linked
// Checksum 0x5483a8e0, Offset: 0x850
// Size: 0x64
function copydestructstate(originalentity, newentity) {
    newentity._destruct_state = function_b9568365(originalentity);
    togglespawngibs(newentity, 0);
    reapplydestructedpieces(newentity);
}

// Namespace destructserverutils/destructible_character
// Params 2, eflags: 0x1 linked
// Checksum 0x38766f4f, Offset: 0x8c0
// Size: 0xd4
function function_8475c53a(entity, var_ba9eac46) {
    if (isdefined(entity.destructibledef)) {
        destructbundle = _getdestructibledef(entity);
        for (index = 1; index <= destructbundle.pieces.size; index++) {
            piece = destructbundle.pieces[index - 1];
            if (isdefined(piece.name) && piece.name == var_ba9eac46) {
                destructpiece(entity, index);
            }
        }
    }
}

// Namespace destructserverutils/destructible_character
// Params 2, eflags: 0x1 linked
// Checksum 0xcecf758e, Offset: 0x9a0
// Size: 0xd4
function destructhitlocpieces(entity, hitloc) {
    if (isdefined(entity.destructibledef)) {
        destructbundle = _getdestructibledef(entity);
        for (index = 1; index <= destructbundle.pieces.size; index++) {
            piece = destructbundle.pieces[index - 1];
            if (isdefined(piece.hitlocation) && piece.hitlocation === hitloc) {
                destructpiece(entity, index);
            }
        }
    }
}

// Namespace destructserverutils/destructible_character
// Params 2, eflags: 0x1 linked
// Checksum 0xa5286846, Offset: 0xa80
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
// Params 1, eflags: 0x1 linked
// Checksum 0x43ff2fce, Offset: 0xb78
// Size: 0x6c
function destructleftarmpieces(entity) {
    destructhitlocpieces(entity, "left_arm_upper");
    destructhitlocpieces(entity, "left_arm_lower");
    destructhitlocpieces(entity, "left_hand");
}

// Namespace destructserverutils/destructible_character
// Params 1, eflags: 0x1 linked
// Checksum 0xa203bd62, Offset: 0xbf0
// Size: 0x6c
function destructleftlegpieces(entity) {
    destructhitlocpieces(entity, "left_leg_upper");
    destructhitlocpieces(entity, "left_leg_lower");
    destructhitlocpieces(entity, "left_foot");
}

// Namespace destructserverutils/destructible_character
// Params 2, eflags: 0x1 linked
// Checksum 0x90fd177f, Offset: 0xc68
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
// Checksum 0x20ba59a, Offset: 0xe20
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
// Checksum 0x84d81f11, Offset: 0xf88
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
// Params 1, eflags: 0x1 linked
// Checksum 0xa509cf61, Offset: 0x1010
// Size: 0x6c
function destructrightarmpieces(entity) {
    destructhitlocpieces(entity, "right_arm_upper");
    destructhitlocpieces(entity, "right_arm_lower");
    destructhitlocpieces(entity, "right_hand");
}

// Namespace destructserverutils/destructible_character
// Params 1, eflags: 0x1 linked
// Checksum 0xc93d915e, Offset: 0x1088
// Size: 0x6c
function destructrightlegpieces(entity) {
    destructhitlocpieces(entity, "right_leg_upper");
    destructhitlocpieces(entity, "right_leg_lower");
    destructhitlocpieces(entity, "right_foot");
}

// Namespace destructserverutils/destructible_character
// Params 1, eflags: 0x1 linked
// Checksum 0x7fc3279f, Offset: 0x1100
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
// Params 12, eflags: 0x1 linked
// Checksum 0x545c6a72, Offset: 0x1160
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
// Checksum 0x6f43fe38, Offset: 0x1298
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
// Params 2, eflags: 0x1 linked
// Checksum 0x5c91d101, Offset: 0x1358
// Size: 0x6e
function isdestructed(entity, piecenumber) {
    assert(1 <= piecenumber && piecenumber <= 20);
    return function_b9568365(entity) & 1 << piecenumber;
}

// Namespace destructserverutils/destructible_character
// Params 1, eflags: 0x1 linked
// Checksum 0x550e3c8, Offset: 0x13d0
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
// Params 1, eflags: 0x1 linked
// Checksum 0x7de4c799, Offset: 0x1558
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
// Params 2, eflags: 0x1 linked
// Checksum 0x4b8aed4e, Offset: 0x1640
// Size: 0x94
function togglespawngibs(entity, shouldspawngibs) {
    if (shouldspawngibs) {
        entity._destruct_state = function_b9568365(entity) | 1;
    } else {
        entity._destruct_state = function_b9568365(entity) & -2;
    }
    entity clientfield::set("destructible_character_state", entity._destruct_state);
}

