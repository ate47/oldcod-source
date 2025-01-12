#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\duplicaterender_mgr;
#using scripts\core_common\multi_extracam;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace character_customization;

// Namespace character_customization
// Method(s) 59 Total 59
class class_66ff794 {

    var _angles;
    var _i_mode;
    var _origin;
    var _xuid;
    var var_1fb74197;
    var var_2147297b;
    var var_2ae2f536;
    var var_2d6451be;
    var var_305436a5;
    var var_3f8be83a;
    var var_4f083ddd;
    var var_52e7d84e;
    var var_55244804;
    var var_5681d345;
    var var_5bd66c8b;
    var var_6850510d;
    var var_719fd699;
    var var_741de1af;
    var var_7503266f;
    var var_7b9244ca;
    var var_8406fd0a;
    var var_86aa6489;
    var var_895b3db7;
    var var_8fbf6304;
    var var_95daa89d;
    var var_b42323e9;
    var var_b9a0a858;
    var var_bf862db6;
    var var_c4c7ce1b;
    var var_c7765764;
    var var_c91d5394;
    var var_d1ad4841;
    var var_d6fee7aa;
    var var_e57502a0;

    // Namespace class_66ff794/character_customization
    // Params 0, eflags: 0x8
    // Checksum 0xbfc65cbc, Offset: 0x2f0
    // Size: 0x1f2
    constructor() {
        var_c7765764 = 0;
        var_895b3db7 = 0;
        _xuid = undefined;
        _i_mode = 4;
        var_e57502a0 = 0;
        var_2147297b = 0;
        var_c91d5394 = 0;
        var_8fbf6304 = [0, 0, 0, 0, 0, 0, 0, 0];
        assert(-1);
        var_7503266f = undefined;
        var_741de1af = 0;
        var_d6fee7aa = 0;
        _origin = (0, 0, 0);
        _angles = (0, 0, 0);
        var_5681d345 = undefined;
        var_8406fd0a = undefined;
        var_b9a0a858 = undefined;
        var_3f8be83a = undefined;
        var_7b9244ca = undefined;
        var_1fb74197 = 0;
        var_86aa6489 = [];
        var_305436a5 = [];
        var_bf862db6 = [];
        var_4f083ddd = undefined;
        var_55244804 = 1;
        var_719fd699 = 1;
        var_95daa89d = 1;
        var_c4c7ce1b = 0;
        var_5bd66c8b = 1;
        var_2ae2f536 = 0;
        var_2d6451be = undefined;
        var_b42323e9 = undefined;
        var_d1ad4841 = undefined;
        var_52e7d84e = undefined;
        var_6850510d = [];
    }

    // Namespace namespace_66ff794/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0xa5d98d39, Offset: 0x2990
    // Size: 0x4c
    function function_43f376f0(on_off) {
        if (var_d6fee7aa != on_off) {
            var_d6fee7aa = on_off;
            var_7503266f duplicate_render::set_entity_draft_unselected(var_c7765764, on_off);
        }
    }

    // Namespace namespace_66ff794/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0x9534f573, Offset: 0x28a0
    // Size: 0xe2
    function is_streamed() {
        if (isdefined(var_7503266f)) {
            if (!var_7503266f isstreamed()) {
                return false;
            }
        }
        if (var_c4c7ce1b && function_508b09d9()) {
            return false;
        }
        foreach (ent in var_bf862db6) {
            if (isdefined(ent)) {
                if (!ent isstreamed()) {
                    return false;
                }
            }
        }
        return true;
    }

    // Namespace namespace_66ff794/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0xc4d4cc37, Offset: 0x2840
    // Size: 0x58
    function function_55039a51() {
        var_93df1740 = function_56bda4dd();
        head_index = getequippedheadindexforhero(var_93df1740, _i_mode);
        set_character_head(head_index);
    }

    // Namespace namespace_66ff794/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0x9a1ff88e, Offset: 0x27e0
    // Size: 0x58
    function function_94936fb3() {
        var_93df1740 = function_56bda4dd();
        character_index = getequippedheroindex(var_93df1740, _i_mode);
        set_character_index(character_index);
    }

    // Namespace namespace_66ff794/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0xa9aca7d0, Offset: 0x2788
    // Size: 0x50
    function function_7443faff(itemtype) {
        set_character_outfit_item(function_e701e83d(var_c7765764, _i_mode, var_e57502a0, var_c91d5394, itemtype), itemtype);
    }

    // Namespace namespace_66ff794/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0x9eca08d, Offset: 0x2740
    // Size: 0x3a
    function function_f3500f07() {
        for (itemtype = 0; itemtype < 8; itemtype++) {
            function_7443faff(itemtype);
        }
    }

    // Namespace namespace_66ff794/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0x3037b0a2, Offset: 0x26e0
    // Size: 0x58
    function function_fd80d28b() {
        function_55039a51();
        set_character_outfit(function_6bd3c3c8(var_c7765764, _i_mode, var_e57502a0));
        function_f3500f07();
    }

    // Namespace namespace_66ff794/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0x94b8a8b8, Offset: 0x25b0
    // Size: 0x124
    function function_1a1fd7cd(var_52a60d51) {
        set_xuid(var_52a60d51.xuid);
        set_character_mode(var_52a60d51.charactermode);
        set_character_index(var_52a60d51.charactertype);
        set_character_head(var_52a60d51.characterhead);
        set_character_outfit(var_52a60d51.outfit);
        assert(var_52a60d51.outfititems.size == 8);
        foreach (itemtype, itemindex in var_52a60d51.outfititems) {
            set_character_outfit_item(itemindex, itemtype);
        }
    }

    // Namespace namespace_66ff794/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0xbc57c4dc, Offset: 0x2558
    // Size: 0x4a
    function function_44330d1b() {
        set_character_outfit(0);
        for (itemtype = 0; itemtype < 8; itemtype++) {
            set_character_outfit_item(0, itemtype);
        }
    }

    // Namespace namespace_66ff794/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0xb7b8a5c9, Offset: 0x2488
    // Size: 0xc4
    function function_8991e454() {
        self notify("1e7ede9f3a789371");
        self endon("1e7ede9f3a789371");
        if (var_c4c7ce1b) {
            while (function_508b09d9()) {
                waitframe(1);
            }
            if (isdefined(var_4f083ddd)) {
                var_7503266f function_6e6aa241(var_4f083ddd);
            } else {
                var_7503266f function_8dd2f825(var_c7765764, _i_mode);
            }
            return;
        }
        var_7503266f function_3e3e8d5b();
    }

    // Namespace namespace_66ff794/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0xdbc923a6, Offset: 0x23e8
    // Size: 0x94
    function function_31328254(params) {
        if (var_b42323e9 !== params.exploder_id) {
            if (isdefined(var_b42323e9)) {
                killradiantexploder(var_c7765764, var_b42323e9);
            }
            var_b42323e9 = params.exploder_id;
            if (isdefined(var_b42323e9)) {
                playradiantexploder(var_c7765764, var_b42323e9);
            }
        }
    }

    // Namespace namespace_66ff794/character_customization
    // Params 2, eflags: 0x0
    // Checksum 0x559fcfb3, Offset: 0x22d8
    // Size: 0x104
    function function_2f5627c4(params, force_updates) {
        if (isdefined(params.weapon_right) || isdefined(params.weapon_left)) {
            update_model_attachment(params.weapon_right, "tag_weapon_right", params.weapon_right_anim, params.weapon_right_anim_intro, force_updates);
            update_model_attachment(params.weapon_left, "tag_weapon_left", params.weapon_left_anim, params.weapon_left_anim_intro, force_updates);
            return;
        }
        if (isdefined(params.activeweapon)) {
            var_7503266f attachweapon(params.activeweapon);
            var_7503266f useweaponhidetags(params.activeweapon);
        }
    }

    // Namespace namespace_66ff794/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0x18c720f1, Offset: 0x2250
    // Size: 0x7a
    function function_4f7c691e(stop_update = 1) {
        if (stop_update) {
            self notify(#"hash_578cb70e92c24a5a");
        }
        if (isdefined(var_b9a0a858)) {
            var_7b9244ca scene::cancel(var_b9a0a858, 0);
            var_b9a0a858 = undefined;
            var_7b9244ca = undefined;
        }
    }

    // Namespace namespace_66ff794/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0xb0a83126, Offset: 0x20e0
    // Size: 0x168
    function function_993f7930() {
        if (isdefined(var_8406fd0a)) {
            function_4f7c691e();
            var_7503266f thread character_customization::play_intro_and_animation(_origin, _angles, undefined, var_8406fd0a, 0);
        } else if (isdefined(var_b9a0a858)) {
            function_4f7c691e();
            if (var_1fb74197) {
                var_7b9244ca thread scene::play(var_b9a0a858, var_7503266f);
            } else {
                var_7b9244ca thread scene::play(var_b9a0a858);
            }
        }
        foreach (slot, ent in var_bf862db6) {
            ent thread character_customization::play_intro_and_animation(_origin, _angles, undefined, var_305436a5[slot], 1);
        }
    }

    // Namespace namespace_66ff794/character_customization
    // Params 2, eflags: 0x0
    // Checksum 0x9c8f8d01, Offset: 0x1d40
    // Size: 0x398
    function function_2e36a96d(params, force_update) {
        changed = 0;
        if (!isdefined(params)) {
            params = spawnstruct();
        }
        if (!isdefined(params.exploder_id)) {
            params.exploder_id = var_d1ad4841;
        }
        align_changed = 0;
        if (isdefined(var_5681d345)) {
            if (!isdefined(params.align_struct)) {
                params.align_struct = struct::get(var_5681d345);
            }
        }
        if (isdefined(params.align_struct) && (params.align_struct.origin !== _origin || params.align_struct.angles !== _angles)) {
            _origin = params.align_struct.origin;
            _angles = params.align_struct.angles;
            if (!isdefined(params.anim_name)) {
                params.anim_name = var_8406fd0a;
            }
            align_changed = 1;
        }
        if (isdefined(params.anim_name) && (params.anim_name !== var_8406fd0a || align_changed || force_update)) {
            changed = 1;
            function_4f7c691e(0);
            var_8406fd0a = params.anim_name;
            var_b9a0a858 = undefined;
            var_7b9244ca = undefined;
            var_7503266f thread character_customization::play_intro_and_animation(_origin, _angles, params.anim_intro_name, var_8406fd0a, 0);
        } else if (isdefined(params.scene) && (params.scene !== var_b9a0a858 || params.scene_target !== var_7b9244ca || (isdefined(params.var_573638fb) && params.var_573638fb) != var_1fb74197 || force_update)) {
            changed = 1;
            function_4f7c691e(0);
            var_b9a0a858 = params.scene;
            var_7b9244ca = isdefined(params.scene_target) ? params.scene_target : level;
            var_1fb74197 = isdefined(params.var_573638fb) && params.var_573638fb;
            var_8406fd0a = undefined;
            if (var_1fb74197) {
                var_7b9244ca thread scene::play(var_b9a0a858, var_7503266f);
            } else {
                var_7b9244ca thread scene::play(var_b9a0a858);
            }
        }
        return changed;
    }

    // Namespace namespace_66ff794/character_customization
    // Params 5, eflags: 0x0
    // Checksum 0xf77252fd, Offset: 0x1998
    // Size: 0x3a0
    function update_model_attachment(attached_model, slot, model_anim, model_intro_anim, force_update) {
        assert(isdefined(level.model_type_bones));
        if (force_update || attached_model !== var_86aa6489[slot] || model_anim !== var_305436a5[slot]) {
            bone = isdefined(level.model_type_bones[slot]) ? level.model_type_bones[slot] : slot;
            assert(isdefined(bone));
            if (isdefined(var_86aa6489[slot])) {
                if (isdefined(var_bf862db6[slot])) {
                    var_bf862db6[slot] unlink();
                    var_bf862db6[slot] delete();
                    var_bf862db6[slot] = undefined;
                } else if (var_7503266f isattached(var_86aa6489[slot], bone)) {
                    var_7503266f detach(var_86aa6489[slot], bone);
                }
                var_86aa6489[slot] = undefined;
            }
            var_86aa6489[slot] = attached_model;
            if (isdefined(var_86aa6489[slot])) {
                if (isdefined(model_anim)) {
                    ent = spawn(var_c7765764, var_7503266f.origin, "script_model");
                    ent sethighdetail(var_5bd66c8b, var_719fd699);
                    var_bf862db6[slot] = ent;
                    ent setmodel(var_86aa6489[slot]);
                    if (!ent hasanimtree()) {
                        ent useanimtree("generic");
                    }
                    ent.origin = _origin;
                    ent.angles = _angles;
                    ent thread character_customization::play_intro_and_animation(_origin, _angles, model_intro_anim, model_anim, 1);
                } else if (!var_7503266f isattached(var_86aa6489[slot], bone)) {
                    var_7503266f attach(var_86aa6489[slot], bone);
                }
                var_305436a5[slot] = model_anim;
            }
        }
        if (isdefined(var_bf862db6[slot])) {
            function_98aaed45(var_bf862db6[slot]);
        }
    }

    // Namespace namespace_66ff794/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0x16d61207, Offset: 0x1260
    // Size: 0x72c
    function update_internal(params) {
        self notify("715b8304d0e3d864");
        self endon("715b8304d0e3d864");
        self endon(#"deleted");
        self endon(#"hash_578cb70e92c24a5a");
        if (isdefined(var_3f8be83a)) {
            function_5094c112(var_3f8be83a);
            var_3f8be83a = undefined;
        }
        if (!isdefined(params)) {
            params = {};
        }
        if (function_872d9360()) {
            base_model = function_8f60b365();
            attached_models = [#"head":function_4ff7d788(params), #"outfit_head":function_52ec781c(params), #"outfit_legs":#"tag_origin", #"outfit_torso":#"tag_origin"];
        } else {
            base_model = function_993d8be1();
            attached_models = [#"head":function_4ff7d788(params), #"outfit_head":function_52ec781c(params), #"outfit_headgear":function_5382b392(), #"outfit_legs":function_ce3571a3(), #"outfit_torso":function_8f60b365()];
        }
        if (isdefined(params.var_40b25178) && params.var_40b25178 && !var_741de1af) {
            if (isdefined(var_2d6451be)) {
                var_2d6451be delete();
                var_2d6451be = undefined;
            }
            if (isdefined(base_model)) {
                var_2d6451be = util::spawn_model(var_c7765764, base_model, (0, 0, 0));
                function_98aaed45(var_2d6451be);
                _models = [];
                foreach (slot, model in attached_models) {
                    if (!isdefined(array::find(_models, model))) {
                        array::add(_models, model);
                        bone = isdefined(level.model_type_bones[slot]) ? level.model_type_bones[slot] : slot;
                        var_2d6451be attach(model, bone);
                    }
                }
                while (!var_2d6451be isstreamed()) {
                    wait 0.1;
                }
            }
        }
        if (isdefined(params.var_4cc8f4b3) && params.var_4cc8f4b3 && isdefined(params.scene)) {
            var_3f8be83a = params.scene;
            while (!forcestreambundle(params.scene)) {
                wait 0.1;
            }
        }
        var_19279d61 = 0;
        if (var_55244804) {
            var_55244804 = 0;
            var_19279d61 = 1;
            function_4f7c691e(0);
            if (isdefined(base_model)) {
                old_model = var_7503266f;
                new_model = util::spawn_model(var_c7765764, base_model, old_model.origin, old_model.angles);
                new_model.targetname = old_model.targetname;
                function_cc3e9e1e(new_model);
                var_7503266f setmodel(base_model);
                old_model delete();
                var_86aa6489 = [];
                var_305436a5 = [];
                var_bf862db6 = [];
            }
        }
        function_98aaed45(var_7503266f);
        if (!var_7503266f hasanimtree()) {
            var_7503266f useanimtree("all_player");
        }
        foreach (slot, model in attached_models) {
            update_model_attachment(model, slot, undefined, undefined, 1);
        }
        if (isdefined(var_2d6451be)) {
            var_2d6451be delete();
            var_2d6451be = undefined;
        }
        changed = function_2e36a96d(params, var_19279d61);
        function_2f5627c4(params, changed);
        function_31328254(params);
        var_3f8be83a = undefined;
        if (isdefined(params.var_40b25178) && params.var_40b25178) {
            function_43f376f0(0);
        }
        if (isdefined(params.var_c921b849) && params.var_c921b849) {
            fbc = getuimodel(getglobaluimodel(), "lobbyRoot.fullscreenBlackCount");
            setuimodelvalue(fbc, 0);
        }
        thread function_8991e454();
    }

    // Namespace namespace_66ff794/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0x34ab86ec, Offset: 0x1230
    // Size: 0x24
    function update(params) {
        self thread update_internal(params);
    }

    // Namespace namespace_66ff794/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0x4c4d5cf8, Offset: 0x1188
    // Size: 0x9c
    function function_98aaed45(model) {
        render_options = function_db6e6295({#mode:_i_mode, #characterindex:var_e57502a0, #outfitindex:var_c91d5394, #outfitoptions:var_8fbf6304});
        model setbodyrenderoptionspacked(render_options);
    }

    // Namespace namespace_66ff794/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0xc467594f, Offset: 0x1128
    // Size: 0x52
    function function_8f60b365() {
        if (var_741de1af) {
            return #"c_t8_mp_swatbuddy_body2";
        }
        return function_fb7ff145(var_e57502a0, var_c91d5394, var_8fbf6304[6], _i_mode);
    }

    // Namespace namespace_66ff794/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0xdfb276a5, Offset: 0x10c8
    // Size: 0x52
    function function_ce3571a3() {
        if (var_741de1af) {
            return #"tag_origin";
        }
        return function_2d8b2021(var_e57502a0, var_c91d5394, var_8fbf6304[4], _i_mode);
    }

    // Namespace namespace_66ff794/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0x45e758c4, Offset: 0x1040
    // Size: 0x7a
    function function_5382b392() {
        if (var_741de1af) {
            return #"tag_origin";
        }
        var_2fac2f0 = function_50a2ef71(var_e57502a0, var_c91d5394, var_8fbf6304[3], _i_mode);
        return isdefined(var_2fac2f0) ? var_2fac2f0 : #"tag_origin";
    }

    // Namespace namespace_66ff794/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0x7e95f3f8, Offset: 0xfb8
    // Size: 0x7a
    function function_52ec781c(params) {
        if (var_741de1af) {
            return #"c_t8_mp_swatbuddy_head2";
        }
        if (!function_82309e0e(params)) {
            return #"tag_origin";
        }
        return function_48b6673e(var_e57502a0, var_c91d5394, var_8fbf6304[2], _i_mode);
    }

    // Namespace namespace_66ff794/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0xf58013e9, Offset: 0xf60
    // Size: 0x4a
    function function_993d8be1() {
        if (var_741de1af) {
            return #"tag_origin";
        }
        return function_dd025223(var_e57502a0, var_c91d5394, var_8fbf6304[0], _i_mode);
    }

    // Namespace namespace_66ff794/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0x9c710f67, Offset: 0xef0
    // Size: 0x62
    function function_4ff7d788(params) {
        if (var_741de1af) {
            return #"tag_origin";
        }
        if (!function_350dd6e1(params)) {
            return #"tag_origin";
        }
        return getcharacterheadmodel(var_2147297b, _i_mode);
    }

    // Namespace namespace_66ff794/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0xcaa343d0, Offset: 0xed8
    // Size: 0x10
    function function_82309e0e(params) {
        return true;
    }

    // Namespace namespace_66ff794/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0xb098f7da, Offset: 0xec0
    // Size: 0x10
    function function_350dd6e1(params) {
        return true;
    }

    // Namespace namespace_66ff794/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0xae979640, Offset: 0xe80
    // Size: 0x32
    function function_872d9360() {
        if (var_741de1af) {
            return 1;
        }
        return function_738e1e58(_i_mode, var_e57502a0);
    }

    // Namespace namespace_66ff794/character_customization
    // Params 2, eflags: 0x0
    // Checksum 0x22be085c, Offset: 0xdb0
    // Size: 0xc2
    function set_character_outfit_item(item_index, item_type) {
        assert(_i_mode != 4);
        if (var_8fbf6304[item_type] != item_index) {
            var_55244804 |= item_type == 0 || item_type == 2 || item_type == 3 || item_type == 4 || item_type == 6;
            var_8fbf6304[item_type] = item_index;
        }
    }

    // Namespace namespace_66ff794/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0x42495042, Offset: 0xd48
    // Size: 0x5e
    function set_character_outfit(outfit_index) {
        assert(_i_mode != 4);
        if (var_c91d5394 != outfit_index) {
            var_55244804 = 1;
            var_c91d5394 = outfit_index;
        }
    }

    // Namespace namespace_66ff794/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0xfd597a40, Offset: 0xce0
    // Size: 0x5e
    function set_character_head(head_index) {
        assert(_i_mode != 4);
        if (var_2147297b != head_index) {
            var_55244804 = 1;
            var_2147297b = head_index;
        }
    }

    // Namespace namespace_66ff794/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0x92c00f23, Offset: 0xcc8
    // Size: 0xa
    function get_character_index() {
        return var_e57502a0;
    }

    // Namespace namespace_66ff794/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0xffefd27b, Offset: 0xc68
    // Size: 0x56
    function set_character_index(character_index) {
        assert(isdefined(character_index));
        if (var_e57502a0 != character_index) {
            var_55244804 = 1;
            var_e57502a0 = character_index;
        }
    }

    // Namespace namespace_66ff794/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0x4853072e, Offset: 0xc08
    // Size: 0x56
    function set_character_mode(character_mode) {
        assert(isdefined(character_mode));
        if (_i_mode != character_mode) {
            var_55244804 = 1;
            _i_mode = character_mode;
        }
    }

    // Namespace namespace_66ff794/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0x78521790, Offset: 0xbd0
    // Size: 0x2c
    function function_7dd7d627(character_mode) {
        assert(character_mode === _i_mode);
    }

    // Namespace namespace_66ff794/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0xc854cc91, Offset: 0xba0
    // Size: 0x22
    function function_c35b901() {
        return getcharacterfields(var_e57502a0, _i_mode);
    }

    // Namespace namespace_66ff794/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0x32f8df3, Offset: 0xb60
    // Size: 0x32
    function function_e5bdd4ae() {
        if (!isdefined(var_52e7d84e)) {
            var_52e7d84e = spawnstruct();
        }
        return var_52e7d84e;
    }

    // Namespace namespace_66ff794/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0x90b05c33, Offset: 0xa28
    // Size: 0x12e
    function delete_models() {
        self notify(#"deleted");
        foreach (ent in var_bf862db6) {
            ent unlink();
            ent delete();
        }
        level.custom_characters[var_c7765764][var_7503266f.targetname] = undefined;
        var_bf862db6 = [];
        var_7503266f delete();
        var_7503266f = undefined;
        if (isdefined(var_2d6451be)) {
            var_2d6451be delete();
            var_2d6451be = undefined;
        }
    }

    // Namespace namespace_66ff794/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0xcd8100db, Offset: 0xa10
    // Size: 0xa
    function get_angles() {
        return _angles;
    }

    // Namespace namespace_66ff794/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0x791d077b, Offset: 0x9f8
    // Size: 0xa
    function get_origin() {
        return _origin;
    }

    // Namespace namespace_66ff794/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0x7cbb3d7f, Offset: 0x9e0
    // Size: 0xa
    function function_d629e80b() {
        return var_2ae2f536;
    }

    // Namespace namespace_66ff794/character_customization
    // Params 2, eflags: 0x0
    // Checksum 0x160cfb15, Offset: 0x978
    // Size: 0x5a
    function function_4c9d5ac7(var_88649fa, angles) {
        var_2ae2f536 = var_88649fa;
        if (isdefined(angles)) {
            var_7503266f.angles = angles;
            return;
        }
        var_7503266f.angles = _angles;
    }

    // Namespace namespace_66ff794/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0xacf8c9bf, Offset: 0x950
    // Size: 0x1c
    function hide_model() {
        var_7503266f hide();
    }

    // Namespace namespace_66ff794/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0x8f6d17c5, Offset: 0x928
    // Size: 0x1c
    function show_model() {
        var_7503266f show();
    }

    // Namespace namespace_66ff794/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0xb45717fb, Offset: 0x900
    // Size: 0x1a
    function function_295fce60() {
        return var_7503266f getentitynumber();
    }

    // Namespace namespace_66ff794/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0x421443b5, Offset: 0x8d8
    // Size: 0x1a
    function set_xuid(xuid) {
        _xuid = xuid;
    }

    // Namespace namespace_66ff794/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0x5319939b, Offset: 0x8a8
    // Size: 0x22
    function function_56bda4dd() {
        return isdefined(var_895b3db7) ? var_895b3db7 : var_c7765764;
    }

    // Namespace namespace_66ff794/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0x3cf499a7, Offset: 0x868
    // Size: 0x38
    function set_show_helmets(show_helmets) {
        if (var_95daa89d != show_helmets) {
            var_95daa89d = show_helmets;
            function_84e93c8();
        }
    }

    // Namespace namespace_66ff794/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0x80f874f8, Offset: 0x840
    // Size: 0x1a
    function function_d13542d0(var_80337283) {
        var_895b3db7 = var_80337283;
    }

    // Namespace namespace_66ff794/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0xf7ffd623, Offset: 0x818
    // Size: 0x1a
    function function_73b050c4(var_69257f2f) {
        var_c4c7ce1b = var_69257f2f;
    }

    // Namespace namespace_66ff794/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0x28fc4be8, Offset: 0x7f0
    // Size: 0x1a
    function set_alt_render_mode(alt_render_mode) {
        var_719fd699 = alt_render_mode;
    }

    // Namespace namespace_66ff794/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0xaa312632, Offset: 0x7c8
    // Size: 0x1a
    function function_ed5fd20c(default_exploder) {
        var_d1ad4841 = default_exploder;
    }

    // Namespace namespace_66ff794/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0xcd0758b0, Offset: 0x788
    // Size: 0x36
    function function_abb62848(var_6973181b) {
        if (var_6973181b != var_741de1af) {
            var_741de1af = var_6973181b;
            var_55244804 = 1;
        }
    }

    // Namespace namespace_66ff794/character_customization
    // Params 0, eflags: 0x4
    // Checksum 0xcac855bd, Offset: 0x770
    // Size: 0xa
    function private function_8741ac11() {
        return var_7503266f;
    }

    // Namespace namespace_66ff794/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0xc3e291cc, Offset: 0x6d0
    // Size: 0x92
    function function_91db38af(callback_fn) {
        if (!isdefined(var_6850510d)) {
            var_6850510d = [];
        } else if (!isarray(var_6850510d)) {
            var_6850510d = array(var_6850510d);
        }
        if (!isinarray(var_6850510d, callback_fn)) {
            var_6850510d[var_6850510d.size] = callback_fn;
        }
    }

    // Namespace namespace_66ff794/character_customization
    // Params 3, eflags: 0x0
    // Checksum 0xba9acc67, Offset: 0x608
    // Size: 0xba
    function function_feabc9c0(local_client_num, character_model, alt_render_mode = 1) {
        assert(!isdefined(var_7503266f), "<dev string:x30>");
        var_c7765764 = local_client_num;
        var_895b3db7 = local_client_num;
        var_719fd699 = alt_render_mode;
        function_cc3e9e1e(character_model);
        _origin = character_model.origin;
        _angles = character_model.angles;
    }

    // Namespace namespace_66ff794/character_customization
    // Params 1, eflags: 0x4
    // Checksum 0xdf7fa02c, Offset: 0x4f0
    // Size: 0x110
    function private function_cc3e9e1e(character_model) {
        var_7503266f = character_model;
        var_7503266f sethighdetail(var_5bd66c8b, var_719fd699);
        var_7503266f.var_1836c993 = self;
        var_7503266f.var_33dc1533 = 1;
        if (var_d6fee7aa) {
            var_7503266f duplicate_render::set_entity_draft_unselected(var_c7765764, 1);
        }
        foreach (callback in var_6850510d) {
            [[ callback ]](var_c7765764, self);
        }
    }

}

// Namespace character_customization/character_customization
// Params 0, eflags: 0x2
// Checksum 0xd72ee0f7, Offset: 0x2a8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"character_customization", &__init__, undefined, undefined);
}

// Namespace character_customization/character_customization
// Params 0, eflags: 0x0
// Checksum 0x5c693e49, Offset: 0x3538
// Size: 0x1be
function __init__() {
    level.extra_cam_render_current_hero_headshot_func_callback = &process_current_hero_headshot_extracam_request;
    level.extra_cam_render_head_preview_func_callback = &process_head_preview_extracam_request;
    level.var_75d55119 = &function_4cd508e6;
    level.extra_cam_render_character_head_item_func_callback = &process_character_head_item_extracam_request;
    level.extra_cam_render_gender_func_callback = &process_gender_extracam_request;
    level.model_type_bones = [#"head":"", #"outfit_head":"", #"outfit_headgear":"", #"outfit_legs":"", #"outfit_torso":""];
    if (!isdefined(level.liveccdata)) {
        level.liveccdata = [];
    }
    if (!isdefined(level.custom_characters)) {
        level.custom_characters = [];
    }
    if (!isdefined(level.extra_cam_hero_data)) {
        level.extra_cam_hero_data = [];
    }
    if (!isdefined(level.extra_cam_headshot_hero_data)) {
        level.extra_cam_headshot_hero_data = [];
    }
    if (!isdefined(level.extra_cam_head_preview_data)) {
        level.extra_cam_head_preview_data = [];
    }
    if (!isdefined(level.extra_cam_gender_preview_data)) {
        level.extra_cam_gender_preview_data = [];
    }
    level.charactercustomizationsetup = &localclientconnect;
}

// Namespace character_customization/character_customization
// Params 1, eflags: 0x0
// Checksum 0xe340e073, Offset: 0x3700
// Size: 0x5e
function localclientconnect(localclientnum) {
    level.liveccdata[localclientnum] = setup_live_character_customization_target(localclientnum, "updateHero");
    level.staticccdata = setup_static_character_customization_target(localclientnum);
}

// Namespace character_customization/character_customization
// Params 3, eflags: 0x0
// Checksum 0x4e27516f, Offset: 0x3768
// Size: 0x100
function function_9de1b403(charactermodel, localclientnum, alt_render_mode = 1) {
    if (!isdefined(charactermodel)) {
        return undefined;
    }
    if (!isdefined(level.custom_characters[localclientnum])) {
        level.custom_characters[localclientnum] = [];
    }
    if (isdefined(level.custom_characters[localclientnum][charactermodel.targetname])) {
        return level.custom_characters[localclientnum][charactermodel.targetname];
    }
    var_e3570966 = new class_66ff794();
    [[ var_e3570966 ]]->function_feabc9c0(localclientnum, charactermodel, alt_render_mode);
    level.custom_characters[localclientnum][charactermodel.targetname] = var_e3570966;
    return var_e3570966;
}

// Namespace character_customization/character_customization
// Params 5, eflags: 0x0
// Checksum 0x9049a2d4, Offset: 0x3870
// Size: 0xb4
function play_intro_and_animation(origin, angles, intro_anim_name, anim_name, b_keep_link) {
    self notify("5beb8c74f95a77d7");
    self endon("5beb8c74f95a77d7");
    if (isdefined(intro_anim_name)) {
        self animation::play(intro_anim_name, origin, angles, 1, 0, 0, 0, b_keep_link);
    }
    if (isdefined(self)) {
        self animation::play(anim_name, origin, angles, 1, 0, 0, 0, b_keep_link);
    }
}

// Namespace character_customization/character_customization
// Params 2, eflags: 0x0
// Checksum 0x37ba7578, Offset: 0x3930
// Size: 0xb4
function setup_live_character_customization_target(localclientnum, notifyname) {
    characterent = getent(localclientnum, "character_customization", "targetname");
    if (isdefined(characterent)) {
        var_5a840c8a = function_9de1b403(characterent, localclientnum, 1);
        [[ var_5a840c8a ]]->function_ed5fd20c("char_customization");
        level thread updateeventthread(localclientnum, var_5a840c8a, notifyname);
        return var_5a840c8a;
    }
    return undefined;
}

// Namespace character_customization/character_customization
// Params 2, eflags: 0x0
// Checksum 0x7c9e35d1, Offset: 0x39f0
// Size: 0x74
function update_locked_shader(localclientnum, params) {
    if (isdefined(params.isitemunlocked) && params.isitemunlocked != 1) {
        enablefrontendlockedweaponoverlay(localclientnum, 1);
        return;
    }
    enablefrontendlockedweaponoverlay(localclientnum, 0);
}

// Namespace character_customization/character_customization
// Params 3, eflags: 0x0
// Checksum 0xfeb5ab76, Offset: 0x3a70
// Size: 0x36
function function_e084dd62(var_5a840c8a, waitresult, params) {
    params.anim_name = #"pb_cac_main_lobby_idle";
}

// Namespace character_customization/character_customization
// Params 4, eflags: 0x0
// Checksum 0x15c3ccd0, Offset: 0x3ab0
// Size: 0x636
function updateeventthread(localclientnum, var_5a840c8a, notifyname, var_9c6c2b1f = &function_e084dd62) {
    while (true) {
        waitresult = level waittill(notifyname + localclientnum);
        switch (waitresult.event_name) {
        case #"update_lcn":
            [[ var_5a840c8a ]]->function_d13542d0(waitresult.local_client_num);
            break;
        case #"refresh":
            [[ var_5a840c8a ]]->function_d13542d0(waitresult.local_client_num);
            [[ var_5a840c8a ]]->set_character_mode(waitresult.mode);
            [[ var_5a840c8a ]]->function_94936fb3();
            [[ var_5a840c8a ]]->function_fd80d28b();
            params = spawnstruct();
            [[ var_9c6c2b1f ]](var_5a840c8a, waitresult, params);
            if (isdefined(params.var_40b25178) && params.var_40b25178) {
                [[ var_5a840c8a ]]->function_43f376f0(1);
            }
            [[ var_5a840c8a ]]->update(params);
            break;
        case #"changehero":
            [[ var_5a840c8a ]]->set_character_mode(waitresult.mode);
            [[ var_5a840c8a ]]->set_character_index(waitresult.character_index);
            [[ var_5a840c8a ]]->function_fd80d28b();
            params = spawnstruct();
            [[ var_9c6c2b1f ]](var_5a840c8a, waitresult, params);
            if (isdefined(params.var_40b25178) && params.var_40b25178) {
                [[ var_5a840c8a ]]->function_43f376f0(1);
            }
            [[ var_5a840c8a ]]->update(params);
            break;
        case #"changegender":
            bodyindex = getfirstheroofgender(waitresult.gender, waitresult.mode);
            headindex = getfirstheadofgender(waitresult.gender, waitresult.mode);
            [[ var_5a840c8a ]]->set_character_mode(waitresult.mode);
            [[ var_5a840c8a ]]->set_character_index(bodyindex);
            [[ var_5a840c8a ]]->function_fd80d28b();
            [[ var_5a840c8a ]]->set_character_head(headindex);
            params = spawnstruct();
            [[ var_9c6c2b1f ]](var_5a840c8a, waitresult, params);
            [[ var_5a840c8a ]]->update(params);
            break;
        case #"changehead":
            [[ var_5a840c8a ]]->function_7dd7d627(waitresult.mode);
            [[ var_5a840c8a ]]->set_character_head(waitresult.head);
            params = spawnstruct();
            [[ var_5a840c8a ]]->update(params);
            break;
        case #"changeoutfit":
            [[ var_5a840c8a ]]->set_character_outfit(waitresult.outfit_index);
            [[ var_5a840c8a ]]->function_f3500f07();
            params = spawnstruct();
            [[ var_9c6c2b1f ]](var_5a840c8a, waitresult, params);
            if (isdefined(params.var_40b25178) && params.var_40b25178) {
                [[ var_5a840c8a ]]->function_43f376f0(1);
            }
            [[ var_5a840c8a ]]->update(params);
            break;
        case #"changeoutfititem":
            [[ var_5a840c8a ]]->set_character_outfit_item(waitresult.item_index, waitresult.item_type);
            params = spawnstruct();
            [[ var_9c6c2b1f ]](var_5a840c8a, waitresult, params);
            if (isdefined(params.var_40b25178) && params.var_40b25178) {
                [[ var_5a840c8a ]]->function_43f376f0(1);
            }
            [[ var_5a840c8a ]]->update(params);
            break;
        case #"hash_220546ce38834f4c":
            [[ var_5a840c8a ]]->function_7443faff(waitresult.item_type);
            params = spawnstruct();
            [[ var_9c6c2b1f ]](var_5a840c8a, waitresult, params);
            if (isdefined(params.var_40b25178) && params.var_40b25178) {
                [[ var_5a840c8a ]]->function_43f376f0(1);
            }
            [[ var_5a840c8a ]]->update(params);
            break;
        case #"updateface":
            [[ var_5a840c8a ]]->function_7dd7d627(waitresult.mode);
            thread [[ var_5a840c8a ]]->function_8991e454();
            break;
        case #"hide":
            [[ var_5a840c8a ]]->hide_model();
            break;
        case #"show":
            [[ var_5a840c8a ]]->show_model();
            break;
        }
    }
}

// Namespace character_customization/character_customization
// Params 3, eflags: 0x0
// Checksum 0xa3cbd4b5, Offset: 0x40f0
// Size: 0xba
function rotation_thread_spawner(localclientnum, var_5a840c8a, endonevent) {
    self notify("4fa542d1d931089b");
    self endon("4fa542d1d931089b");
    if (!isdefined(endonevent)) {
        return;
    }
    baseangles = [[ var_5a840c8a ]]->function_8741ac11().angles;
    level update_model_rotation_for_right_stick(localclientnum, var_5a840c8a, endonevent);
    level waittill(endonevent);
    if (![[ var_5a840c8a ]]->function_d629e80b()) {
        [[ var_5a840c8a ]]->function_8741ac11().angles = baseangles;
    }
}

// Namespace character_customization/character_customization
// Params 3, eflags: 0x4
// Checksum 0x5052b7d, Offset: 0x41b8
// Size: 0x270
function private update_model_rotation_for_right_stick(localclientnum, var_5a840c8a, endonevent) {
    level endon(endonevent);
    while (true) {
        data_lcn = [[ var_5a840c8a ]]->function_56bda4dd();
        if (localclientnum == data_lcn && localclientactive(data_lcn) && ![[ var_5a840c8a ]]->function_d629e80b()) {
            model = [[ var_5a840c8a ]]->function_8741ac11();
            if (isdefined(model)) {
                pos = getcontrollerposition(data_lcn);
                if (isdefined(pos[#"rightstick"])) {
                    model.angles = (model.angles[0], absangleclamp360(model.angles[1] + pos[#"rightstick"][0] * 3), model.angles[2]);
                } else {
                    model.angles = (model.angles[0], absangleclamp360(model.angles[1] + pos[#"look"][0] * 3), model.angles[2]);
                }
                if (ispc()) {
                    pos = getxcammousecontrol(data_lcn);
                    model.angles = (model.angles[0], absangleclamp360(model.angles[1] - pos[#"yaw"] * 3), model.angles[2]);
                }
            }
        }
        waitframe(1);
    }
}

// Namespace character_customization/character_customization
// Params 1, eflags: 0x0
// Checksum 0x28ff21d, Offset: 0x4430
// Size: 0x18c
function setup_static_character_customization_target(localclientnum) {
    characterent = getent(localclientnum, "character_customization_staging", "targetname");
    level.extra_cam_hero_data[localclientnum] = setup_character_extracam_struct("ui_cam_character_customization", "cam_menu_unfocus", #"pb_cac_main_lobby_idle");
    level.extra_cam_headshot_hero_data[localclientnum] = setup_character_extracam_struct("ui_cam_char_identity", "cam_bust", #"pb_cac_vs_screen_idle_1");
    level.extra_cam_head_preview_data[localclientnum] = setup_character_extracam_struct("ui_cam_char_identity", "cam_bust", #"pb_cac_main_lobby_idle");
    level.extra_cam_gender_preview_data[localclientnum] = setup_character_extracam_struct("ui_cam_char_identity", "cam_bust", #"pb_cac_main_lobby_idle");
    if (isdefined(characterent)) {
        var_5a840c8a = function_9de1b403(characterent, localclientnum);
        level thread update_character_extracam(localclientnum, var_5a840c8a);
        return var_5a840c8a;
    }
    return undefined;
}

// Namespace character_customization/character_customization
// Params 3, eflags: 0x0
// Checksum 0xcdb9cb25, Offset: 0x45c8
// Size: 0x6a
function setup_character_extracam_struct(xcam, subxcam, model_animation) {
    newstruct = spawnstruct();
    newstruct.xcam = xcam;
    newstruct.subxcam = subxcam;
    newstruct.anim_name = model_animation;
    return newstruct;
}

// Namespace character_customization/character_customization
// Params 3, eflags: 0x0
// Checksum 0xa6ed6050, Offset: 0x4640
// Size: 0x400
function setup_character_extracam_settings(localclientnum, var_5a840c8a, extracam_data_struct) {
    assert(isdefined(extracam_data_struct.jobindex));
    if (!isdefined(level.camera_ents)) {
        level.camera_ents = [];
    }
    initializedextracam = 0;
    camera_ent = isdefined(level.camera_ents[localclientnum]) ? level.camera_ents[localclientnum][extracam_data_struct.extracamindex] : undefined;
    if (!isdefined(camera_ent)) {
        initializedextracam = 1;
        multi_extracam::extracam_init_index(localclientnum, "character_staging_extracam" + extracam_data_struct.extracamindex + 1, extracam_data_struct.extracamindex);
        camera_ent = level.camera_ents[localclientnum][extracam_data_struct.extracamindex];
    }
    assert(isdefined(camera_ent));
    camera_ent playextracamxcam(extracam_data_struct.xcam, 0, extracam_data_struct.subxcam);
    params = spawnstruct();
    params.anim_name = extracam_data_struct.anim_name;
    params.extracam_data = extracam_data_struct;
    params.sessionmode = extracam_data_struct.sessionmode;
    params.hide_helmet = isdefined(extracam_data_struct.hidehelmet) && extracam_data_struct.hidehelmet;
    [[ var_5a840c8a ]]->function_73b050c4(extracam_data_struct.sessionmode === 2);
    [[ var_5a840c8a ]]->set_alt_render_mode(0);
    [[ var_5a840c8a ]]->set_character_mode(extracam_data_struct.sessionmode);
    [[ var_5a840c8a ]]->set_character_index(extracam_data_struct.characterindex);
    if (isdefined(extracam_data_struct.isdefaulthero) && extracam_data_struct.isdefaulthero || isdefined(extracam_data_struct.defaultimagerender) && extracam_data_struct.defaultimagerender) {
        [[ var_5a840c8a ]]->function_44330d1b();
    } else {
        [[ var_5a840c8a ]]->function_fd80d28b();
        if (isdefined(extracam_data_struct.var_d37ebe37) && isdefined(extracam_data_struct.var_6b53de31)) {
            [[ var_5a840c8a ]]->set_character_outfit_item(extracam_data_struct.var_6b53de31, extracam_data_struct.var_d37ebe37);
        }
        if (isdefined(extracam_data_struct.useheadindex)) {
            [[ var_5a840c8a ]]->set_character_head(extracam_data_struct.useheadindex);
        }
    }
    [[ var_5a840c8a ]]->update(params);
    while (![[ var_5a840c8a ]]->is_streamed()) {
        waitframe(1);
    }
    if (isdefined(extracam_data_struct.defaultimagerender) && extracam_data_struct.defaultimagerender) {
        wait 0.5;
    } else {
        wait 0.1;
    }
    setextracamrenderready(extracam_data_struct.jobindex);
    extracam_data_struct.jobindex = undefined;
    level waittill("render_complete_" + localclientnum + "_" + extracam_data_struct.extracamindex);
    if (initializedextracam) {
        multi_extracam::extracam_reset_index(localclientnum, extracam_data_struct.extracamindex);
    }
    [[ var_5a840c8a ]]->function_73b050c4(0);
}

// Namespace character_customization/character_customization
// Params 2, eflags: 0x0
// Checksum 0x7bbec3ed, Offset: 0x4a48
// Size: 0x78
function update_character_extracam(localclientnum, var_5a840c8a) {
    level endon(#"disconnect");
    while (true) {
        waitresult = level waittill("process_character_extracam" + localclientnum);
        setup_character_extracam_settings(localclientnum, var_5a840c8a, waitresult.extracam_data_struct);
    }
}

// Namespace character_customization/character_customization
// Params 6, eflags: 0x0
// Checksum 0x277d7bb5, Offset: 0x4ac8
// Size: 0xf6
function process_current_hero_headshot_extracam_request(localclientnum, jobindex, extracamindex, sessionmode, characterindex, isdefaulthero) {
    level.extra_cam_headshot_hero_data[localclientnum].jobindex = jobindex;
    level.extra_cam_headshot_hero_data[localclientnum].extracamindex = extracamindex;
    level.extra_cam_headshot_hero_data[localclientnum].characterindex = characterindex;
    level.extra_cam_headshot_hero_data[localclientnum].isdefaulthero = isdefaulthero;
    level.extra_cam_headshot_hero_data[localclientnum].sessionmode = sessionmode;
    level notify("process_character_extracam" + localclientnum, {#extracam_data_struct:level.extra_cam_headshot_hero_data[localclientnum]});
}

// Namespace character_customization/character_customization
// Params 5, eflags: 0x0
// Checksum 0x1621801f, Offset: 0x4bc8
// Size: 0x10e
function process_head_preview_extracam_request(localclientnum, jobindex, extracamindex, sessionmode, headindex) {
    level.extra_cam_head_preview_data[localclientnum].jobindex = jobindex;
    level.extra_cam_head_preview_data[localclientnum].extracamindex = extracamindex;
    level.extra_cam_head_preview_data[localclientnum].useheadindex = headindex;
    level.extra_cam_head_preview_data[localclientnum].characterindex = getfirstheroofgender(getheadgender(headindex, sessionmode), sessionmode);
    level.extra_cam_head_preview_data[localclientnum].sessionmode = sessionmode;
    level notify("process_character_extracam" + localclientnum, {#extracam_data_struct:level.extra_cam_outfit_preview_data[localclientnum]});
}

// Namespace character_customization/character_customization
// Params 9, eflags: 0x0
// Checksum 0xcdfd0b7c, Offset: 0x4ce0
// Size: 0x1ae
function function_4cd508e6(localclientnum, jobindex, extracamindex, sessionmode, characterindex, outfitindex, itemtype, itemindex, defaultimagerender) {
    extracam_data = undefined;
    if (defaultimagerender) {
        extracam_data = setup_character_extracam_struct("ui_cam_char_customization_icons_render", "loot_body", #"pb_cac_vs_screen_idle_1");
        extracam_data.useheadindex = getfirstheadofgender(getherogender(characterindex, sessionmode), sessionmode);
    } else {
        extracam_data = setup_character_extracam_struct("ui_cam_char_customization_icons", "cam_body", #"pb_cac_vs_screen_idle_1");
    }
    extracam_data.jobindex = jobindex;
    extracam_data.extracamindex = extracamindex;
    extracam_data.sessionmode = sessionmode;
    extracam_data.characterindex = characterindex;
    extracam_data.outfitindex = outfitindex;
    extracam_data.var_d37ebe37 = itemtype;
    extracam_data.var_6b53de31 = itemindex;
    extracam_data.defaultimagerender = defaultimagerender;
    level notify("process_character_extracam" + localclientnum, {#extracam_data_struct:extracam_data});
}

// Namespace character_customization/character_customization
// Params 6, eflags: 0x0
// Checksum 0xea4336c2, Offset: 0x4e98
// Size: 0x176
function process_character_head_item_extracam_request(localclientnum, jobindex, extracamindex, sessionmode, headindex, defaultimagerender) {
    extracam_data = undefined;
    if (defaultimagerender) {
        extracam_data = setup_character_extracam_struct("ui_cam_char_customization_icons_render", "cam_head", #"pb_cac_vs_screen_idle_1");
    } else {
        extracam_data = setup_character_extracam_struct("ui_cam_char_customization_icons", "cam_head", #"pb_cac_vs_screen_idle_1");
    }
    extracam_data.jobindex = jobindex;
    extracam_data.extracamindex = extracamindex;
    extracam_data.sessionmode = sessionmode;
    extracam_data.useheadindex = headindex;
    extracam_data.hidehelmet = 1;
    extracam_data.defaultimagerender = defaultimagerender;
    extracam_data.characterindex = getfirstheroofgender(getheadgender(headindex, sessionmode), sessionmode);
    level notify("process_character_extracam" + localclientnum, {#extracam_data_struct:extracam_data});
}

// Namespace character_customization/character_customization
// Params 5, eflags: 0x0
// Checksum 0xa4aaa7b8, Offset: 0x5018
// Size: 0x10e
function process_gender_extracam_request(localclientnum, jobindex, extracamindex, sessionmode, gender) {
    level.extra_cam_gender_preview_data[localclientnum].jobindex = jobindex;
    level.extra_cam_gender_preview_data[localclientnum].extracamindex = extracamindex;
    level.extra_cam_gender_preview_data[localclientnum].useheadindex = getfirstheadofgender(gender, sessionmode);
    level.extra_cam_gender_preview_data[localclientnum].characterindex = getfirstheroofgender(gender, sessionmode);
    level.extra_cam_gender_preview_data[localclientnum].sessionmode = sessionmode;
    level notify("process_character_extracam" + localclientnum, {#extracam_data_struct:level.extra_cam_gender_preview_data[localclientnum]});
}

