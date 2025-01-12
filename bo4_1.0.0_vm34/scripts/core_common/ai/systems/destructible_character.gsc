#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\struct;

#namespace destructible_character;

// Namespace destructible_character/destructible_character
// Params 0, eflags: 0x2
// Checksum 0xd120f543, Offset: 0x1f0
// Size: 0x47e
function autoexec main() {
    clientfield::register("actor", "destructible_character_state", 1, 21, "int");
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
            piecestruct.detachtag = destructible.("piece" + index + "_detachtag");
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

#namespace destructserverutils;

// Namespace destructserverutils/destructible_character
// Params 1, eflags: 0x4
// Checksum 0x313704a5, Offset: 0x678
// Size: 0x20
function private _getdestructibledef(entity) {
    return level.destructiblecharacterdefs[entity.destructibledef];
}

// Namespace destructserverutils/destructible_character
// Params 1, eflags: 0x0
// Checksum 0xdbc18ebc, Offset: 0x6a0
// Size: 0x2a
function getdestructstate(entity) {
    if (isdefined(entity._destruct_state)) {
        return entity._destruct_state;
    }
    return 0;
}

// Namespace destructserverutils/destructible_character
// Params 3, eflags: 0x0
// Checksum 0xfdc9aec1, Offset: 0x6d8
// Size: 0x5c
function function_e95033a8(entity, var_fcf255b1, var_9dfb4d60) {
    entity._destruct_state = var_fcf255b1;
    togglespawngibs(entity, var_9dfb4d60);
    reapplydestructedpieces(entity);
}

// Namespace destructserverutils/destructible_character
// Params 2, eflags: 0x4
// Checksum 0xe594a385, Offset: 0x740
// Size: 0x64
function private _setdestructed(entity, destructflag) {
    entity._destruct_state = getdestructstate(entity) | destructflag;
    entity clientfield::set("destructible_character_state", entity._destruct_state);
}

// Namespace destructserverutils/destructible_character
// Params 2, eflags: 0x0
// Checksum 0x7be28c4a, Offset: 0x7b0
// Size: 0x64
function copydestructstate(originalentity, newentity) {
    newentity._destruct_state = getdestructstate(originalentity);
    togglespawngibs(newentity, 0);
    reapplydestructedpieces(newentity);
}

// Namespace destructserverutils/destructible_character
// Params 2, eflags: 0x0
// Checksum 0x2fef4407, Offset: 0x820
// Size: 0xd6
function destructhitlocpieces(entity, hitloc) {
    if (isdefined(entity.destructibledef)) {
        destructbundle = _getdestructibledef(entity);
        for (index = 1; index <= destructbundle.pieces.size; index++) {
            piece = destructbundle.pieces[index - 1];
            if (isdefined(piece.hitlocation) && piece.hitlocation == hitloc) {
                destructpiece(entity, index);
            }
        }
    }
}

// Namespace destructserverutils/destructible_character
// Params 2, eflags: 0x0
// Checksum 0xfd55827e, Offset: 0x900
// Size: 0xee
function function_2a60056f(entity, hittag) {
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
// Checksum 0x7788c229, Offset: 0x9f8
// Size: 0x6c
function destructleftarmpieces(entity) {
    destructhitlocpieces(entity, "left_arm_upper");
    destructhitlocpieces(entity, "left_arm_lower");
    destructhitlocpieces(entity, "left_hand");
}

// Namespace destructserverutils/destructible_character
// Params 1, eflags: 0x0
// Checksum 0xc84bd6ae, Offset: 0xa70
// Size: 0x6c
function destructleftlegpieces(entity) {
    destructhitlocpieces(entity, "left_leg_upper");
    destructhitlocpieces(entity, "left_leg_lower");
    destructhitlocpieces(entity, "left_foot");
}

// Namespace destructserverutils/destructible_character
// Params 2, eflags: 0x0
// Checksum 0xdeb9ab8c, Offset: 0xae8
// Size: 0x1b4
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
// Checksum 0x51be07c0, Offset: 0xca8
// Size: 0x15e
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
// Checksum 0x3b3eecf7, Offset: 0xe10
// Size: 0x86
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
// Checksum 0x17fcabfb, Offset: 0xea0
// Size: 0x6c
function destructrightarmpieces(entity) {
    destructhitlocpieces(entity, "right_arm_upper");
    destructhitlocpieces(entity, "right_arm_lower");
    destructhitlocpieces(entity, "right_hand");
}

// Namespace destructserverutils/destructible_character
// Params 1, eflags: 0x0
// Checksum 0xaa2fb2b3, Offset: 0xf18
// Size: 0x6c
function destructrightlegpieces(entity) {
    destructhitlocpieces(entity, "right_leg_upper");
    destructhitlocpieces(entity, "right_leg_lower");
    destructhitlocpieces(entity, "right_foot");
}

// Namespace destructserverutils/destructible_character
// Params 1, eflags: 0x0
// Checksum 0x40adfb5d, Offset: 0xf90
// Size: 0x56
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
// Checksum 0x88ec9819, Offset: 0xff0
// Size: 0x138
function handledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, var_c5843dc3, modelindex) {
    entity = self;
    if (isdefined(entity.skipdeath) && entity.skipdeath) {
        return idamage;
    }
    togglespawngibs(entity, 1);
    destructhitlocpieces(entity, shitloc);
    if (isdefined(var_c5843dc3)) {
        bonename = var_c5843dc3;
        if (!isstring(var_c5843dc3)) {
            bonename = getpartname(entity, var_c5843dc3);
        }
        if (isdefined(bonename)) {
            function_2a60056f(entity, bonename);
        }
    }
    return idamage;
}

// Namespace destructserverutils/destructible_character
// Params 3, eflags: 0x0
// Checksum 0x21c42f93, Offset: 0x1130
// Size: 0xb4
function function_fa9a6761(entity, hitloc, var_c5843dc3) {
    togglespawngibs(entity, 1);
    destructhitlocpieces(entity, hitloc);
    if (isdefined(var_c5843dc3)) {
        bonename = var_c5843dc3;
        if (!isstring(var_c5843dc3)) {
            bonename = getpartname(entity, var_c5843dc3);
        }
        if (isdefined(bonename)) {
            function_2a60056f(entity, bonename);
        }
    }
}

// Namespace destructserverutils/destructible_character
// Params 2, eflags: 0x0
// Checksum 0x50d6273c, Offset: 0x11f0
// Size: 0x6e
function isdestructed(entity, piecenumber) {
    assert(1 <= piecenumber && piecenumber <= 20);
    return getdestructstate(entity) & 1 << piecenumber;
}

// Namespace destructserverutils/destructible_character
// Params 1, eflags: 0x0
// Checksum 0xefd61fb9, Offset: 0x1268
// Size: 0x18e
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
// Checksum 0x4e62ba40, Offset: 0x1400
// Size: 0xde
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
// Checksum 0xe6938b6e, Offset: 0x14e8
// Size: 0x94
function togglespawngibs(entity, shouldspawngibs) {
    if (shouldspawngibs) {
        entity._destruct_state = getdestructstate(entity) | 1;
    } else {
        entity._destruct_state = getdestructstate(entity) & -2;
    }
    entity clientfield::set("destructible_character_state", entity._destruct_state);
}

