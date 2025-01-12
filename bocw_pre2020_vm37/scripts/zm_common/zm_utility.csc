#using scripts\core_common\activecamo_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_maptable;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_weapons;

#namespace zm_utility;

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x6
// Checksum 0x4e762850, Offset: 0x1d8
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"zm_utility", &function_70a657d8, &postinit, undefined, undefined);
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x5 linked
// Checksum 0x3ba5e4e5, Offset: 0x230
// Size: 0x24c
function private function_70a657d8() {
    level._effect[#"zm_zone_edge_marker"] = #"hash_3002526b7ff53cbf";
    clientfield::register_clientuimodel("hudItems.armorType", #"hash_6f4b11a0bee9b73d", #"armortype", 1, 2, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.armorPercent", #"hash_6f4b11a0bee9b73d", #"armorpercent", 1, 7, "float", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.scrap", #"hash_6f4b11a0bee9b73d", #"hash_568103fb62eae412", 1, 16, "int", undefined, 0, 0);
    clientfield::register("scriptmover", "zm_zone_edge_marker_count", 1, getminbitcountfornum(15), "int", &zm_zone_edge_marker_count, 0, 0);
    clientfield::register("toplayer", "zm_zone_out_of_bounds", 1, 1, "int", &zm_zone_out_of_bounds, 0, 0);
    clientfield::register("actor", "flame_corpse_fx", 1, 1, "int", &flame_corpse_fx, 0, 0);
    clientfield::register("scriptmover", "model_rarity_rob", 1, 3, "int", &model_rarity_rob, 0, 0);
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x5 linked
// Checksum 0x80f724d1, Offset: 0x488
// Size: 0x4
function private postinit() {
    
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x3c058dd6, Offset: 0x498
// Size: 0x5a
function ignore_triggers(timer) {
    if (!isdefined(self)) {
        return;
    }
    self endon(#"death");
    self.ignoretriggers = 1;
    if (isdefined(timer)) {
        wait timer;
    } else {
        wait 0.5;
    }
    self.ignoretriggers = 0;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x6a2b01f9, Offset: 0x500
// Size: 0x6
function is_encounter() {
    return false;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x7786b85a, Offset: 0x510
// Size: 0x3e
function round_up_to_ten(score) {
    new_score = score - score % 10;
    if (new_score < score) {
        new_score += 10;
    }
    return new_score;
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x1 linked
// Checksum 0xacca451b, Offset: 0x558
// Size: 0x5c
function round_up_score(score, value) {
    score = int(score);
    new_score = score - score % value;
    if (new_score < score) {
        new_score += value;
    }
    return new_score;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x870c8602, Offset: 0x5c0
// Size: 0x3a
function halve_score(n_score) {
    n_score /= 2;
    n_score = round_up_score(n_score, 10);
    return n_score;
}

// Namespace zm_utility/zm_utility
// Params 6, eflags: 0x0
// Checksum 0x7e3d7f12, Offset: 0x608
// Size: 0xc8
function spawn_weapon_model(localclientnum, weapon, model = weapon.worldmodel, origin, angles, options) {
    weapon_model = spawn(localclientnum, origin, "script_model");
    if (isdefined(angles)) {
        weapon_model.angles = angles;
    }
    if (isdefined(options)) {
        weapon_model useweaponmodel(weapon, model, options);
    } else {
        weapon_model useweaponmodel(weapon, model);
    }
    return weapon_model;
}

// Namespace zm_utility/zm_utility
// Params 5, eflags: 0x1 linked
// Checksum 0x9c3bc4ab, Offset: 0x6d8
// Size: 0xa0
function spawn_buildkit_weapon_model(localclientnum, weapon, camo, origin, angles) {
    weapon_model = spawn(localclientnum, origin, "script_model");
    if (isdefined(angles)) {
        weapon_model.angles = angles;
    }
    weapon_model usebuildkitweaponmodel(localclientnum, weapon, camo);
    weapon_model activecamo::function_e40c785a(localclientnum);
    return weapon_model;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x586f3fde, Offset: 0x780
// Size: 0x40
function is_classic() {
    str_gametype = util::get_game_type();
    if (str_gametype == #"zclassic") {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x791b60fd, Offset: 0x7c8
// Size: 0x40
function is_survival() {
    str_gametype = util::get_game_type();
    if (str_gametype == #"zsurvival") {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x11d631aa, Offset: 0x810
// Size: 0x40
function is_standard() {
    str_gametype = util::get_game_type();
    if (str_gametype == #"zstandard") {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x269b9618, Offset: 0x858
// Size: 0x68
function is_trials() {
    str_gametype = util::get_game_type();
    if (str_gametype == #"ztrials" || level flag::exists(#"ztrial")) {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0xcdba40be, Offset: 0x8c8
// Size: 0x40
function is_tutorial() {
    str_gametype = util::get_game_type();
    if (str_gametype == #"ztutorial") {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0xbe1ec8af, Offset: 0x910
// Size: 0x40
function is_grief() {
    str_gametype = util::get_game_type();
    if (str_gametype == #"zgrief") {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0xcd75ec47, Offset: 0x958
// Size: 0x92
function is_gametype_active(a_gametypes) {
    b_is_gametype_active = 0;
    if (!isarray(a_gametypes)) {
        a_gametypes = array(a_gametypes);
    }
    for (i = 0; i < a_gametypes.size; i++) {
        if (util::get_game_type() == a_gametypes[i]) {
            b_is_gametype_active = 1;
        }
    }
    return b_is_gametype_active;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x5c9f86d8, Offset: 0x9f8
// Size: 0x42
function is_ee_enabled() {
    if (!getdvarint(#"zm_ee_enabled", 0)) {
        return false;
    }
    if (level.gamedifficulty == 0) {
        return false;
    }
    return true;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x8e5b8ddc, Offset: 0xa48
// Size: 0x36
function function_7ab3b826() {
    if (!getdvarint(#"hash_2184263c92bdc58d", 1)) {
        return false;
    }
    return true;
}

// Namespace zm_utility/zm_utility
// Params 7, eflags: 0x0
// Checksum 0xa7b5808b, Offset: 0xa88
// Size: 0xa4
function setinventoryuimodels(localclientnum, *oldval, newval, *bnewent, *binitialsnap, fieldname, *bwastimejump) {
    if (function_65b9eb0f(binitialsnap)) {
        return;
    }
    setuimodelvalue(createuimodel(function_1df4c3b0(binitialsnap, #"zm_inventory"), bwastimejump), fieldname);
}

// Namespace zm_utility/zm_utility
// Params 7, eflags: 0x0
// Checksum 0x937ad074, Offset: 0xb38
// Size: 0x84
function setsharedinventoryuimodels(localclientnum, *oldval, newval, *bnewent, *binitialsnap, fieldname, *bwastimejump) {
    setuimodelvalue(createuimodel(function_1df4c3b0(binitialsnap, #"zm_inventory"), bwastimejump), fieldname);
}

// Namespace zm_utility/zm_utility
// Params 7, eflags: 0x0
// Checksum 0x2fa5142a, Offset: 0xbc8
// Size: 0xec
function zm_ui_infotext(localclientnum, *oldval, newval, *bnewent, *binitialsnap, fieldname, *bwastimejump) {
    if (fieldname) {
        setuimodelvalue(createuimodel(function_1df4c3b0(binitialsnap, #"zm_inventory"), "infoText"), bwastimejump);
        return;
    }
    setuimodelvalue(createuimodel(function_1df4c3b0(binitialsnap, #"zm_inventory"), "infoText"), "");
}

/#

    // Namespace zm_utility/zm_utility
    // Params 4, eflags: 0x0
    // Checksum 0x7519eebb, Offset: 0xcc0
    // Size: 0x274
    function drawcylinder(pos, rad, height, color) {
        currad = rad;
        curheight = height;
        debugstar(pos, 1, color);
        for (r = 0; r < 20; r++) {
            theta = r / 20 * 360;
            theta2 = (r + 1) / 20 * 360;
            line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta2) * currad, sin(theta2) * currad, 0), color, 1, 1, 100);
            line(pos + (cos(theta) * currad, sin(theta) * currad, curheight), pos + (cos(theta2) * currad, sin(theta2) * currad, curheight), color, 1, 1, 100);
            line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta) * currad, sin(theta) * currad, curheight), color, 1, 1, 100);
        }
    }

#/

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xf6cf9672, Offset: 0xf40
// Size: 0xbe
function function_f8796df3(localclientnum) {
    b_first = 0;
    if (isplayer(self) && self function_21c0fa55() && !isdemoplaying()) {
        var_27cd9fcb = self getlocalclientnumber();
        if ((!isdefined(var_27cd9fcb) || localclientnum == var_27cd9fcb) && !isthirdperson(localclientnum)) {
            b_first = 1;
        }
    }
    return b_first;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x5a7e1ded, Offset: 0x1008
// Size: 0x14e
function function_467efa7b(var_9f3fb329 = 0) {
    if (!isdefined(self.archetype)) {
        return "tag_origin";
    }
    switch (self.archetype) {
    case #"stoker":
    case #"catalyst":
    case #"gladiator":
    case #"nova_crawler":
    case #"zombie":
    case #"ghost":
    case #"brutus":
        if (var_9f3fb329) {
            str_tag = "j_spine4";
        } else {
            str_tag = "j_spineupper";
        }
        break;
    case #"blight_father":
    case #"tiger":
    case #"elephant":
        str_tag = "j_head";
        break;
    default:
        str_tag = "tag_origin";
        break;
    }
    return str_tag;
}

// Namespace zm_utility/zm_utility
// Params 3, eflags: 0x0
// Checksum 0x6bcfcae1, Offset: 0x1160
// Size: 0x108
function function_bb54a31f(*localclientnum, var_20804e3b, var_3ab46b9) {
    self endon(var_3ab46b9);
    s_result = level waittill(#"respawn");
    a_e_players = getlocalplayers();
    foreach (e_player in a_e_players) {
        if (e_player postfx::function_556665f2(var_20804e3b)) {
            e_player postfx::exitpostfxbundle(var_20804e3b);
        }
    }
}

// Namespace zm_utility/zm_utility
// Params 3, eflags: 0x0
// Checksum 0xe15df011, Offset: 0x1270
// Size: 0xfe
function function_ae3780f1(localclientnum, n_fx_id, var_3ab46b9) {
    self endon(var_3ab46b9);
    s_result = level waittill(#"respawn");
    a_e_players = getlocalplayers();
    foreach (e_player in a_e_players) {
        if (isdefined(n_fx_id)) {
            deletefx(localclientnum, n_fx_id);
            n_fx_id = undefined;
        }
    }
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0xef35e647, Offset: 0x1378
// Size: 0x12
function get_cast() {
    return zm_maptable::get_cast();
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xfd5ad972, Offset: 0x1398
// Size: 0x12
function get_story() {
    return zm_maptable::get_story();
}

// Namespace zm_utility/zm_utility
// Params 7, eflags: 0x1 linked
// Checksum 0xf979a181, Offset: 0x13b8
// Size: 0x250
function zm_zone_edge_marker_count(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump > 0) {
        v_forward = anglestoforward(self.angles);
        v_right = anglestoright(self.angles);
        v_spacing = (0, 0, 0);
        self.origin += v_right * 6;
        for (i = 1; i <= bwastimejump; i++) {
            var_a05a609b = playfx(fieldname, level._effect[#"zm_zone_edge_marker"], self.origin + v_spacing, v_forward);
            if (!isdefined(self.var_dd1709dd)) {
                self.var_dd1709dd = [];
            } else if (!isarray(self.var_dd1709dd)) {
                self.var_dd1709dd = array(self.var_dd1709dd);
            }
            self.var_dd1709dd[self.var_dd1709dd.size] = var_a05a609b;
            v_spacing = v_right * 32 * i;
        }
        return;
    }
    if (isarray(self.var_dd1709dd)) {
        foreach (var_a05a609b in self.var_dd1709dd) {
            stopfx(fieldname, var_a05a609b);
        }
    }
}

// Namespace zm_utility/zm_utility
// Params 7, eflags: 0x1 linked
// Checksum 0xceab818b, Offset: 0x1610
// Size: 0x14c
function zm_zone_out_of_bounds(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!isdefined(level.var_20861007)) {
        level.var_20861007 = [];
    }
    if (!isdefined(level.var_20861007[fieldname])) {
        level.var_20861007[fieldname] = util::spawn_model(fieldname, "tag_origin");
    }
    if (bwastimejump) {
        level.var_20861007[fieldname] playloopsound(#"hash_6da7ae12f538ef5e", 0.5);
        self postfx::playpostfxbundle(#"hash_798237aa1bad3d7d");
        return;
    }
    level.var_20861007[fieldname] stopallloopsounds(0.5);
    self postfx::exitpostfxbundle(#"hash_798237aa1bad3d7d");
}

// Namespace zm_utility/zm_utility
// Params 7, eflags: 0x1 linked
// Checksum 0xb64ee313, Offset: 0x1768
// Size: 0x14e
function flame_corpse_fx(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump) {
    if (bwasdemojump == 1) {
        if (isdefined(self.var_71a7fc1c)) {
            stopfx(fieldname, self.var_71a7fc1c);
        }
        str_tag = "j_spineupper";
        if (!isdefined(self gettagorigin(str_tag))) {
            str_tag = "tag_origin";
        }
        if (isdefined(level._effect) && isdefined(level._effect[#"character_fire_death_torso"])) {
            self.var_71a7fc1c = util::playfxontag(fieldname, level._effect[#"character_fire_death_torso"], self, str_tag);
        }
        return;
    }
    if (isdefined(self.var_71a7fc1c)) {
        stopfx(fieldname, self.var_71a7fc1c);
        self.var_71a7fc1c = undefined;
    }
}

// Namespace zm_utility/zm_utility
// Params 7, eflags: 0x1 linked
// Checksum 0x5117f32e, Offset: 0x18c0
// Size: 0x1ec
function model_rarity_rob(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump) {
    switch (bwasdemojump) {
    case 1:
        self.var_d9e5ccb2 = #"hash_6f1ab68ac78ac2ea";
        break;
    case 2:
        self.var_d9e5ccb2 = #"hash_312ceb838675b80";
        break;
    case 3:
        self.var_d9e5ccb2 = #"hash_70c807782a37573e";
        break;
    case 4:
        self.var_d9e5ccb2 = #"hash_5b08235c0b55a003";
        break;
    case 5:
        self.var_d9e5ccb2 = #"rob_sr_item_purple";
        break;
    case 6:
        self.var_d9e5ccb2 = #"hash_64261dabb4df88cd";
        break;
    case 7:
        self.var_d9e5ccb2 = #"rob_sr_item_gold";
        break;
    case 0:
    default:
        if (isdefined(self.var_d9e5ccb2)) {
            self stoprenderoverridebundle(self.var_d9e5ccb2);
            self.var_d9e5ccb2 = undefined;
        }
        break;
    }
    if (isdefined(self.var_d9e5ccb2)) {
        self playrenderoverridebundle(self.var_d9e5ccb2);
    }
}

