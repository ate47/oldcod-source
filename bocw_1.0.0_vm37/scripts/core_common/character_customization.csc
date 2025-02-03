#using scripts\core_common\activecamo_shared;
#using scripts\core_common\activecamo_shared_util;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\multi_extracam;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace character_customization;

// Namespace character_customization
// Method(s) 84 Total 84
class class_7da27482 {

    var _angles;
    var _i_mode;
    var _origin;
    var _target_name;
    var _xuid;
    var var_180f1c7d;
    var var_1d18f5c7;
    var var_1d73bad9;
    var var_228f64da;
    var var_266b2ff0;
    var var_27af8d38;
    var var_43b94d19;
    var var_444a0d45;
    var var_45210dc7;
    var var_506d3c33;
    var var_54430cb6;
    var var_5633914d;
    var var_5d01abf7;
    var var_609efd3e;
    var var_640fbaae;
    var var_6ce65c01;
    var var_81bd1932;
    var var_851003fe;
    var var_8d2161e9;
    var var_9896541c;
    var var_9a4a8ea;
    var var_9bea772f;
    var var_a287debe;
    var var_b3113387;
    var var_b627749c;
    var var_bf273e28;
    var var_bf4feef5;
    var var_c31e86ed;
    var var_cbcee022;
    var var_cf55444c;
    var var_cfe86a3e;
    var var_d781e2e4;
    var var_eb95665;
    var var_ef017bf9;
    var var_f141235b;
    var var_f5c0467b;
    var var_ff2bed36;

    // Namespace class_7da27482/character_customization
    // Params 0, eflags: 0x8
    // Checksum 0x210086f5, Offset: 0x548
    // Size: 0x256
    constructor() {
        var_f141235b = 0;
        var_81bd1932 = 0;
        _xuid = undefined;
        _target_name = undefined;
        _i_mode = 4;
        var_1d73bad9 = 0;
        var_cf55444c = 0;
        var_cfe86a3e = 0;
        var_f5c0467b = [0, 0, 0, 0, 0, 0, 0, 0];
        assert(-1);
        var_228f64da = undefined;
        var_43b94d19 = 1;
        var_c31e86ed = 0;
        var_b3113387 = 0;
        var_444a0d45 = 0;
        _origin = (0, 0, 0);
        _angles = (0, 0, 0);
        var_9a4a8ea = undefined;
        var_cbcee022 = undefined;
        var_54430cb6 = undefined;
        var_5d01abf7 = undefined;
        var_6ce65c01 = undefined;
        var_9bea772f = undefined;
        var_a287debe = undefined;
        var_8d2161e9 = 0;
        var_45210dc7 = [];
        var_bf273e28 = [];
        var_5633914d = [];
        var_eb95665 = undefined;
        var_b627749c = 1;
        var_27af8d38 = [];
        var_bf4feef5 = 1;
        var_609efd3e = 1;
        var_9896541c = 0;
        var_851003fe = 1;
        var_ef017bf9 = 0;
        var_506d3c33 = [];
        var_ff2bed36 = undefined;
        var_640fbaae = undefined;
        var_266b2ff0 = undefined;
        var_d781e2e4 = undefined;
        var_180f1c7d = [];
        var_1d18f5c7 = 0;
    }

    // Namespace namespace_7da27482/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0x49e2ac98, Offset: 0x3a88
    // Size: 0x44
    function function_47ad026() {
        if (var_1d18f5c7 && isdefined(var_cbcee022)) {
            var_228f64da thread animation::play(var_cbcee022, var_228f64da);
        }
    }

    // Namespace namespace_7da27482/character_customization
    // Params 3, eflags: 0x4
    // Checksum 0xb6af5a78, Offset: 0x1358
    // Size: 0xe2
    function private function_c358189(model_name, lod = -1, mip = -1) {
        index = array::find(var_506d3c33, {#model:model_name, #lod:lod, #mip:mip}, &function_1a57b132);
        assert(isdefined(index));
        if (!isdefined(index)) {
            return 1;
        }
        return character_customization::function_c358189(model_name, lod, mip);
    }

    // Namespace namespace_7da27482/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0x79b73827, Offset: 0x44f8
    // Size: 0xf2
    function is_streamed() {
        if (isdefined(var_228f64da)) {
            if (!var_228f64da isstreamed()) {
                return false;
            }
        }
        if (var_9896541c && function_d9aed86()) {
            return false;
        }
        foreach (ent in var_5633914d) {
            if (isdefined(ent)) {
                if (!ent isstreamed()) {
                    return false;
                }
            }
        }
        return true;
    }

    // Namespace namespace_7da27482/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0x9fe59ac7, Offset: 0x42f8
    // Size: 0x38
    function function_10b0cbea() {
        function_158505aa(function_76fbb09e(var_f141235b, _i_mode, var_1d73bad9));
    }

    // Namespace namespace_7da27482/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0x8bfa03eb, Offset: 0x17f0
    // Size: 0x42
    function function_158505aa(outfit_index) {
        assert(_i_mode != 4);
        var_cfe86a3e = outfit_index;
    }

    // Namespace namespace_7da27482/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0x1e849745, Offset: 0x4088
    // Size: 0x144
    function function_15a8906a(var_23904c1d) {
        if (isdefined(var_23904c1d.xuid)) {
            set_xuid(var_23904c1d.xuid);
        }
        set_character_mode(var_23904c1d.charactermode);
        set_character_index(var_23904c1d.charactertype);
        set_character_outfit(var_23904c1d.outfit);
        function_158505aa(var_23904c1d.warpaintoutfit);
        assert(var_23904c1d.outfititems.size == 8);
        foreach (itemtype, itemindex in var_23904c1d.outfititems) {
            set_character_outfit_item(itemindex, itemtype);
        }
    }

    // Namespace namespace_7da27482/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0x92654f27, Offset: 0xae0
    // Size: 0x90
    function function_184a4d2e(callback_fn) {
        if (!isdefined(var_180f1c7d)) {
            var_180f1c7d = [];
        } else if (!isarray(var_180f1c7d)) {
            var_180f1c7d = array(var_180f1c7d);
        }
        if (!isinarray(var_180f1c7d, callback_fn)) {
            var_180f1c7d[var_180f1c7d.size] = callback_fn;
        }
    }

    // Namespace namespace_7da27482/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0xc13e55cf, Offset: 0x19b0
    // Size: 0x62
    function function_1978bfeb() {
        if (var_c31e86ed) {
            return #"tag_origin";
        }
        return character_customization::function_6bca50af(&function_6b7000e, var_1d73bad9, var_cf55444c, var_f5c0467b[3], _i_mode);
    }

    // Namespace namespace_7da27482/character_customization
    // Params 2, eflags: 0x4
    // Checksum 0x967098dc, Offset: 0x1448
    // Size: 0x5a
    function private function_1a57b132(data_1, data_2) {
        return data_1.model === data_2.model && data_1.lod === data_2.lod && data_1.mip === data_2.mip;
    }

    // Namespace namespace_7da27482/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0x7c63c637, Offset: 0xb90
    // Size: 0x36
    function function_1ec9448d(var_6ef2ca20) {
        if (var_6ef2ca20 != var_c31e86ed) {
            var_c31e86ed = var_6ef2ca20;
            var_b627749c = 1;
        }
    }

    // Namespace namespace_7da27482/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0x7af281ca, Offset: 0xda0
    // Size: 0xa
    function function_1f70adfe() {
        return var_6ce65c01;
    }

    // Namespace namespace_7da27482/character_customization
    // Params 0, eflags: 0x4
    // Checksum 0x2d8f10b4, Offset: 0xb78
    // Size: 0xa
    function private function_217b10ed() {
        return var_228f64da;
    }

    // Namespace namespace_7da27482/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0x138ed69c, Offset: 0x3ff8
    // Size: 0x44
    function function_22039feb() {
        set_character_outfit(0);
        function_158505aa(0);
        function_95779b72();
    }

    // Namespace namespace_7da27482/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0x7416fe6a, Offset: 0x1bc0
    // Size: 0x24
    function update(params) {
        self thread update_internal(params);
    }

    // Namespace namespace_7da27482/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0x163f6e05, Offset: 0x4498
    // Size: 0x58
    function function_225b6e07() {
        var_65496229 = function_690c9509();
        character_index = getequippedheroindex(var_65496229, _i_mode);
        set_character_index(character_index);
    }

    // Namespace namespace_7da27482/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0x919472fb, Offset: 0x16a8
    // Size: 0xa
    function get_character_mode() {
        return _i_mode;
    }

    // Namespace namespace_7da27482/character_customization
    // Params 2, eflags: 0x0
    // Checksum 0xe6589519, Offset: 0x46d0
    // Size: 0x5c
    function function_27945cb8(on_off, force = 0) {
        if (var_b3113387 != on_off || force) {
            var_b3113387 = on_off;
            function_2a5421e3();
        }
    }

    // Namespace namespace_7da27482/character_customization
    // Params 0, eflags: 0x4
    // Checksum 0xa56a5dba, Offset: 0x45f8
    // Size: 0xcc
    function private function_2a5421e3() {
        if (var_b3113387 && !var_228f64da function_d2503806(#"hash_79892e1d5a8f9f33")) {
            var_228f64da playrenderoverridebundle(#"hash_79892e1d5a8f9f33");
            return;
        }
        if (!var_b3113387 && var_228f64da function_d2503806(#"hash_79892e1d5a8f9f33")) {
            var_228f64da stoprenderoverridebundle(#"hash_79892e1d5a8f9f33");
        }
    }

    // Namespace namespace_7da27482/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0xcccbc59f, Offset: 0xbf8
    // Size: 0x1a
    function set_alt_render_mode(alt_render_mode) {
        var_bf4feef5 = alt_render_mode;
    }

    // Namespace namespace_7da27482/character_customization
    // Params 2, eflags: 0x0
    // Checksum 0xfa10a150, Offset: 0x3b80
    // Size: 0xca
    function function_39a68bf2(stop_update = 1, var_93eea46f = 0) {
        var_1d18f5c7 = 0;
        if (stop_update) {
            self notify(#"hash_578cb70e92c24a5a");
            var_1d18f5c7 = 1;
        }
        if (isdefined(var_54430cb6)) {
            var_a287debe scene::cancel(var_54430cb6, 0);
            if (!var_93eea46f) {
                var_54430cb6 = undefined;
                var_5d01abf7 = undefined;
                var_6ce65c01 = undefined;
                var_a287debe = undefined;
            }
        }
    }

    // Namespace namespace_7da27482/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0x49176a60, Offset: 0xce0
    // Size: 0x1a
    function set_xuid(xuid) {
        _xuid = xuid;
    }

    // Namespace namespace_7da27482/character_customization
    // Params 2, eflags: 0x0
    // Checksum 0x8c2324b4, Offset: 0xea8
    // Size: 0x5a
    function function_4240a39a(var_1f64805f, angles) {
        var_ef017bf9 = var_1f64805f;
        if (isdefined(angles)) {
            var_228f64da.angles = angles;
            return;
        }
        var_228f64da.angles = _angles;
    }

    // Namespace namespace_7da27482/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0x71a6baae, Offset: 0xdb8
    // Size: 0x1a
    function function_47cb6b19() {
        return var_228f64da getentitynumber();
    }

    // Namespace namespace_7da27482/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0x98942ddb, Offset: 0x16c0
    // Size: 0x5e
    function set_character_outfit(outfit_index) {
        assert(_i_mode != 4);
        if (var_cf55444c != outfit_index) {
            var_b627749c = 1;
            var_cf55444c = outfit_index;
        }
    }

    // Namespace namespace_7da27482/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0x40682bbb, Offset: 0xf10
    // Size: 0xa
    function function_4a271da1() {
        return var_ef017bf9;
    }

    // Namespace namespace_7da27482/character_customization
    // Params 4, eflags: 0x4
    // Checksum 0x50997656, Offset: 0x3c58
    // Size: 0xc2
    function private function_4b2b3712(localclientnum, weaponmodel, camooptions, var_49daa2f6) {
        camoindex = getcamoindex(camooptions);
        var_f4eb4a50 = activecamo::function_13e12ab1(camoindex);
        if (!isdefined(var_f4eb4a50)) {
            return 0;
        }
        stage = getactivecamostage(camooptions);
        var_3594168e = var_f4eb4a50.stages[stage];
        return activecamo::function_6c9e0e1a(localclientnum, weaponmodel, var_3594168e, var_49daa2f6);
    }

    // Namespace namespace_7da27482/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0x37051d97, Offset: 0x4338
    // Size: 0x38
    function function_59d1302f() {
        for (itemtype = 0; itemtype < 8; itemtype++) {
            function_ac9cc79d(itemtype);
        }
    }

    // Namespace namespace_7da27482/character_customization
    // Params 2, eflags: 0x4
    // Checksum 0xff9e7926, Offset: 0x36d0
    // Size: 0xcc
    function private function_60b3658e(var_2ec36514, need_wait) {
        if (need_wait) {
            self endon(#"deleted", #"hash_578cb70e92c24a5a");
            self waittill(#"cancel_gesture", #"gesture_ended");
        }
        if (isdefined(var_2ec36514)) {
            var_228f64da thread animation::play(var_2ec36514, var_228f64da);
            return;
        }
        if (isdefined(var_54430cb6)) {
            if (var_8d2161e9) {
                var_a287debe thread scene::play(var_54430cb6, var_228f64da);
            }
        }
    }

    // Namespace namespace_7da27482/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0xdc191a7b, Offset: 0x1598
    // Size: 0x2c
    function function_617a9ce4(character_mode) {
        assert(character_mode === _i_mode);
    }

    // Namespace namespace_7da27482/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0x482dc193, Offset: 0x1b00
    // Size: 0xb4
    function function_62dd99d6(model) {
        render_options = function_aa478513({#mode:_i_mode, #characterindex:var_1d73bad9, #outfitindex:var_cf55444c, #warpaintoutfitindex:var_cfe86a3e, #outfitoptions:var_f5c0467b});
        model function_1fac41e4(render_options);
    }

    // Namespace namespace_7da27482/character_customization
    // Params 0, eflags: 0x4
    // Checksum 0x47fa9d44, Offset: 0x11c0
    // Size: 0xda
    function private function_66de4847() {
        if (isdefined(var_ff2bed36)) {
            var_ff2bed36 delete();
            var_ff2bed36 = undefined;
        }
        foreach (model_data in var_506d3c33) {
            character_customization::function_247f6628(model_data.model, model_data.lod, model_data.mip);
        }
        var_506d3c33 = [];
    }

    // Namespace namespace_7da27482/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0x6aabff2a, Offset: 0xcb0
    // Size: 0x22
    function function_690c9509() {
        return isdefined(var_81bd1932) ? var_81bd1932 : var_f141235b;
    }

    // Namespace namespace_7da27482/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0x530734ed, Offset: 0x3b48
    // Size: 0x2e
    function function_69ac4009(gesture_index) {
        gesture = get_gesture(gesture_index);
    }

    // Namespace namespace_7da27482/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0xa9aba399, Offset: 0x42b8
    // Size: 0x38
    function function_72be01b9() {
        set_character_outfit(function_9ec573f1(var_f141235b, _i_mode, var_1d73bad9));
    }

    // Namespace namespace_7da27482/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0x47157c4, Offset: 0x1630
    // Size: 0x56
    function set_character_index(character_index) {
        assert(isdefined(character_index));
        if (var_1d73bad9 != character_index) {
            var_b627749c = 1;
            var_1d73bad9 = character_index;
        }
    }

    // Namespace namespace_7da27482/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0xc319cf5e, Offset: 0x3e90
    // Size: 0x8c
    function function_7412658d(params) {
        if (var_640fbaae !== params.exploder_id) {
            if (isdefined(var_640fbaae)) {
                killradiantexploder(var_f141235b, var_640fbaae);
            }
            var_640fbaae = params.exploder_id;
            if (isdefined(var_640fbaae)) {
                playradiantexploder(var_f141235b, var_640fbaae);
            }
        }
    }

    // Namespace namespace_7da27482/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0x3f6cbad8, Offset: 0x4738
    // Size: 0x3c
    function function_7792df22(locked) {
        if (var_444a0d45 != locked) {
            var_444a0d45 = locked;
            function_2a5421e3();
        }
    }

    // Namespace namespace_7da27482/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0xebee04cb, Offset: 0x4278
    // Size: 0x34
    function function_77e3be08() {
        function_72be01b9();
        function_10b0cbea();
        function_59d1302f();
    }

    // Namespace namespace_7da27482/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0x2035ec09, Offset: 0xd70
    // Size: 0xa
    function function_782bdd96() {
        return var_54430cb6;
    }

    // Namespace namespace_7da27482/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0x2145506c, Offset: 0xc20
    // Size: 0x1a
    function function_79f89fb6(var_925f39ce) {
        var_9896541c = var_925f39ce;
    }

    // Namespace namespace_7da27482/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0x216c453f, Offset: 0x1bf0
    // Size: 0x1240
    function update_internal(params) {
        self notify("579dc20ab8721e11");
        self endon("579dc20ab8721e11");
        level endon(#"disconnect");
        self endon(#"deleted", #"hash_578cb70e92c24a5a");
        if (isdefined(var_9bea772f)) {
            function_66b6e720(var_9bea772f);
            var_9bea772f = undefined;
            if (var_43b94d19) {
                var_228f64da show();
            }
        }
        function_66de4847();
        if (!isdefined(params)) {
            params = {};
        }
        var_1d18f5c7 = 0;
        if (function_bf7bce05()) {
            base_model = function_d5e754c6();
            attached_models = [#"outfit_head":function_8c6b7af7(params), #"outfit_headgear":#"tag_origin", #"outfit_legs":#"tag_origin", #"outfit_torso":#"tag_origin"];
        } else {
            base_model = function_b06080fb();
            attached_models = [#"outfit_head":function_8c6b7af7(params), #"outfit_headgear":function_1978bfeb(), #"outfit_legs":function_cdc02b18(), #"outfit_torso":function_d5e754c6()];
        }
        var_9e7c4fde = array(base_model);
        var_ff2bed36 = util::spawn_model(var_f141235b, base_model, (0, 0, 0));
        var_ff2bed36 hide();
        _models = [];
        foreach (slot, model in attached_models) {
            if (isdefined(model) && !isdefined(array::find(var_9e7c4fde, model))) {
                array::add(var_9e7c4fde, model);
                bone = isdefined(level.model_type_bones[slot]) ? level.model_type_bones[slot] : slot;
                var_ff2bed36 attach(model, bone);
            }
        }
        if (isdefined(params.activeweapon)) {
            var_ff2bed36 attachweapon(params.activeweapon, isdefined(params.var_b8f20727) ? params.var_b8f20727 : 0);
        }
        foreach (model in var_9e7c4fde) {
            force_stream_model(model);
        }
        if (is_true(params.var_d8cb38a9) && isdefined(params.scene)) {
            var_9bea772f = params.scene;
            var_a942d0c7 = 1;
            while (!forcestreambundle(params.scene)) {
                if (var_a942d0c7) {
                    var_228f64da hide();
                    var_a942d0c7 = 0;
                }
                waitframe(1);
            }
            if (var_43b94d19) {
                var_228f64da show();
            }
        }
        var_56293673 = 1;
        foreach (model in var_9e7c4fde) {
            var_56293673 &= function_c358189(model);
        }
        function_62dd99d6(var_ff2bed36);
        if (is_true(params.var_c76f3e47) && !var_c31e86ed && !var_ff2bed36 isstreamed(params.var_5bd51249, params.var_13fb1841)) {
            if (is_true(params.var_401d9a1)) {
                if (isdefined(var_228f64da)) {
                    var_228f64da hide();
                }
                function_27945cb8(1, 1);
                outfit_index = function_9ec573f1(var_f141235b, _i_mode, var_1d73bad9);
                var_d92aad5c = function_bd9a67ae(var_f141235b, _i_mode, var_1d73bad9, outfit_index, 0);
                var_2f1dcdbb = function_bd9a67ae(var_f141235b, _i_mode, var_1d73bad9, outfit_index, 2);
                var_cb9bcfe7 = function_bd9a67ae(var_f141235b, _i_mode, var_1d73bad9, outfit_index, 3);
                var_173f7170 = function_bd9a67ae(var_f141235b, _i_mode, var_1d73bad9, outfit_index, 4);
                var_1f170bc0 = function_bd9a67ae(var_f141235b, _i_mode, var_1d73bad9, outfit_index, 6);
                if (function_bf7bce05()) {
                    var_867954ad = character_customization::function_6bca50af(&function_92ea4100, var_1d73bad9, outfit_index, 0, _i_mode);
                    var_89610e9c = [#"outfit_head":character_customization::function_6bca50af(&startquantity, var_1d73bad9, outfit_index, 0, _i_mode), #"outfit_headgear":#"tag_origin", #"outfit_legs":#"tag_origin", #"outfit_torso":#"tag_origin"];
                } else {
                    var_867954ad = character_customization::function_6bca50af(&function_5d23af5b, var_1d73bad9, outfit_index, var_d92aad5c, _i_mode);
                    var_89610e9c = [#"outfit_head":character_customization::function_6bca50af(&startquantity, var_1d73bad9, outfit_index, var_2f1dcdbb, _i_mode), #"outfit_headgear":character_customization::function_6bca50af(&function_6b7000e, var_1d73bad9, outfit_index, var_cb9bcfe7, _i_mode), #"outfit_legs":character_customization::function_6bca50af(&function_cde23658, var_1d73bad9, outfit_index, var_173f7170, _i_mode), #"outfit_torso":character_customization::function_6bca50af(&function_92ea4100, var_1d73bad9, outfit_index, var_1f170bc0, _i_mode)];
                }
                var_cf2f5fb7 = array(var_867954ad);
                foreach (model in var_89610e9c) {
                    if (!isdefined(var_cf2f5fb7)) {
                        var_cf2f5fb7 = [];
                    } else if (!isarray(var_cf2f5fb7)) {
                        var_cf2f5fb7 = array(var_cf2f5fb7);
                    }
                    if (!isinarray(var_cf2f5fb7, model)) {
                        var_cf2f5fb7[var_cf2f5fb7.size] = model;
                    }
                }
                var_a9916921 = getdvarint(#"hash_388720e05d574ed2", 1);
                foreach (model in var_cf2f5fb7) {
                    force_stream_model(model, var_a9916921, 0);
                }
                do {
                    waitframe(1);
                    var_e2e2ee90 = 1;
                    foreach (model in var_cf2f5fb7) {
                        var_e2e2ee90 &= function_c358189(model, var_a9916921, 0);
                    }
                } while (!var_e2e2ee90);
                function_91cd5499(util::spawn_model(var_f141235b, var_867954ad, _origin, _angles), 0, 0);
                var_b627749c = 1;
                function_27945cb8(1, 1);
                if (!var_43b94d19) {
                    var_228f64da hide();
                }
                var_cc204afb = [];
                foreach (slot, model in var_89610e9c) {
                    if (isdefined(model) && !isdefined(array::find(var_cc204afb, model))) {
                        array::add(var_cc204afb, model);
                        bone = isdefined(level.model_type_bones[slot]) ? level.model_type_bones[slot] : slot;
                        var_228f64da attach(model, bone);
                    }
                }
                function_ef064067(params, 1);
                var_61ef988d = 1;
                foreach (model in var_cf2f5fb7) {
                    function_b020b858(model, var_a9916921, 0);
                }
            }
            do {
                waitframe(1);
            } while (!var_ff2bed36 isstreamed(params.var_5bd51249, params.var_13fb1841));
        }
        var_ff704b7c = is_true(params.var_99a89f83);
        if (var_b627749c) {
            var_b627749c = 0;
            var_ff704b7c = 1;
            function_39a68bf2(0);
            if (is_true(var_61ef988d) && !isdefined(params.var_f5332569)) {
                params.var_f5332569 = function_98d70bef();
            }
            if (isdefined(base_model)) {
                function_91cd5499(util::spawn_model(var_f141235b, base_model, _origin, _angles));
                var_45210dc7 = [];
                var_bf273e28 = [];
                var_5633914d = [];
            }
            if (!var_43b94d19) {
                var_228f64da hide();
            }
        }
        foreach (slot, model in attached_models) {
            update_model_attachment(model, slot, undefined, undefined, 1);
        }
        function_62dd99d6(var_228f64da);
        function_66de4847();
        changed = function_ef064067(params, var_ff704b7c);
        function_dd872e2b(params, changed);
        function_7412658d(params);
        var_9bea772f = undefined;
        if (is_true(params.var_c76f3e47)) {
            function_27945cb8(0);
        }
        if (is_true(params.var_8d3b5f69)) {
            fbc = getuimodel(function_5f72e972(#"lobby_root"), "fullscreenBlackCount");
            setuimodelvalue(fbc, 0);
        }
        thread function_81d84c71();
        var_1d18f5c7 = 1;
        var_2d0192e5 = function_82e05d64();
        if (isdefined(var_2d0192e5)) {
            if (isdefined(var_2d0192e5.visible_model)) {
                setuimodelvalue(var_2d0192e5.visible_model, function_ea4ac9f8() && is_visible());
            }
        }
        gestureindex = character_customization::function_6aee5a4e(self);
        if (isdefined(gestureindex) && gestureindex > 0) {
            thread play_gesture(gestureindex, 0, 1, 0);
        }
    }

    // Namespace namespace_7da27482/character_customization
    // Params 3, eflags: 0x0
    // Checksum 0x3011764e, Offset: 0xa10
    // Size: 0xc4
    function function_7ed995de(local_client_num, character_model, alt_render_mode = 1) {
        assert(!isdefined(var_228f64da), "<dev string:x38>");
        var_f141235b = local_client_num;
        var_81bd1932 = local_client_num;
        var_bf4feef5 = alt_render_mode;
        _target_name = character_model.targetname;
        _origin = character_model.origin;
        _angles = character_model.angles;
        function_91cd5499(character_model);
    }

    // Namespace namespace_7da27482/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0x5fdf3588, Offset: 0x3ad8
    // Size: 0x64
    function function_8144231c() {
        if (!var_c31e86ed && #"female" === getherogender(var_1d73bad9, _i_mode)) {
            return #"pb_fem_frontend_default";
        }
        return #"pb_male_frontend_default";
    }

    // Namespace namespace_7da27482/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0x9bbb4101, Offset: 0x3f28
    // Size: 0xc4
    function function_81d84c71() {
        self notify("dba7d56ecbe29f4");
        self endon("dba7d56ecbe29f4");
        if (var_9896541c) {
            while (function_d9aed86()) {
                waitframe(1);
            }
            if (isdefined(var_eb95665)) {
                var_228f64da function_5790ec6e(var_eb95665);
            } else {
                var_228f64da function_a72ef0c5(var_f141235b, _i_mode);
            }
            return;
        }
        var_228f64da function_a7842493();
    }

    // Namespace namespace_7da27482/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0x39c0adc6, Offset: 0x1078
    // Size: 0x22
    function function_82e05d64() {
        if (!isdefined(var_d781e2e4)) {
            var_d781e2e4 = {};
        }
        return var_d781e2e4;
    }

    // Namespace namespace_7da27482/character_customization
    // Params 2, eflags: 0x0
    // Checksum 0xde474a8, Offset: 0x1728
    // Size: 0xbc
    function set_character_outfit_item(item_index, item_type) {
        assert(_i_mode != 4);
        if (var_f5c0467b[item_type] != item_index) {
            var_b627749c |= item_type == 0 || item_type == 2 || item_type == 3 || item_type == 4 || item_type == 6;
            var_f5c0467b[item_type] = item_index;
        }
    }

    // Namespace namespace_7da27482/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0x4e2d69ee, Offset: 0x1918
    // Size: 0x8a
    function function_8c6b7af7(params) {
        if (var_c31e86ed) {
            return #"c_t8_mp_swatbuddy_head2";
        }
        if (!function_ef6f931f(params)) {
            return #"tag_origin";
        }
        return character_customization::function_6bca50af(&startquantity, var_1d73bad9, var_cf55444c, var_f5c0467b[2], _i_mode);
    }

    // Namespace namespace_7da27482/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0x96732035, Offset: 0x1690
    // Size: 0xa
    function get_character_index() {
        return var_1d73bad9;
    }

    // Namespace namespace_7da27482/character_customization
    // Params 2, eflags: 0x0
    // Checksum 0xf00515d, Offset: 0x43f8
    // Size: 0x94
    function function_9146bf81(itemindex, itemtype) {
        outfit_index = itemtype == 7 ? var_cfe86a3e : var_cf55444c;
        if (!isdefined(itemindex)) {
            itemindex = function_bd9a67ae(var_f141235b, _i_mode, var_1d73bad9, outfit_index, itemtype);
        }
        set_character_outfit_item(itemindex, itemtype);
    }

    // Namespace namespace_7da27482/character_customization
    // Params 3, eflags: 0x4
    // Checksum 0x9f5c1602, Offset: 0x838
    // Size: 0x1cc
    function private function_91cd5499(character_model, var_87606b20, var_584905de) {
        if (isdefined(var_228f64da)) {
            _origin = var_228f64da.origin;
            _angles = var_228f64da.angles;
            function_39a68bf2(0);
            var_228f64da delete();
        }
        var_228f64da = character_model;
        var_228f64da.targetname = _target_name;
        var_228f64da.origin = _origin;
        var_228f64da.angles = _angles;
        var_228f64da sethighdetail(isdefined(var_87606b20) ? var_87606b20 : var_851003fe, isdefined(var_584905de) ? var_584905de : var_bf4feef5);
        if (var_228f64da hasdobj(var_f141235b) && !var_228f64da hasanimtree()) {
            var_228f64da useanimtree("all_player");
        }
        var_228f64da.var_90ff9782 = self;
        var_228f64da.var_463f8196 = 1;
        function_2a5421e3();
        function_c39fbf91();
    }

    // Namespace namespace_7da27482/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0xee09e199, Offset: 0x4048
    // Size: 0x38
    function function_95779b72() {
        for (itemtype = 0; itemtype < 8; itemtype++) {
            set_character_outfit_item(0, itemtype);
        }
    }

    // Namespace namespace_7da27482/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0x37a0fa9e, Offset: 0xd08
    // Size: 0x5c
    function function_98d70bef() {
        if (isdefined(var_228f64da)) {
            animation = var_228f64da getcurrentanimscriptedname();
            if (isdefined(animation)) {
                return var_228f64da getanimtime(animation);
            }
        }
    }

    // Namespace namespace_7da27482/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0x8de09871, Offset: 0xd88
    // Size: 0xa
    function function_9afbd994() {
        return var_5d01abf7;
    }

    // Namespace namespace_7da27482/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0x368e2e0, Offset: 0xdf8
    // Size: 0x4c
    function show_model() {
        if (isdefined(var_228f64da)) {
            var_228f64da show();
        }
        var_43b94d19 = 1;
        function_c39fbf91();
    }

    // Namespace namespace_7da27482/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0x697aad23, Offset: 0xf40
    // Size: 0xa
    function get_angles() {
        return _angles;
    }

    // Namespace namespace_7da27482/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0x546436a5, Offset: 0x4378
    // Size: 0x78
    function function_ac9cc79d(itemtype) {
        outfit_index = itemtype == 7 ? var_cfe86a3e : var_cf55444c;
        set_character_outfit_item(function_bd9a67ae(var_f141235b, _i_mode, var_1d73bad9, outfit_index, itemtype), itemtype);
    }

    // Namespace namespace_7da27482/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0x56547c10, Offset: 0xf58
    // Size: 0x114
    function delete_models() {
        self notify(#"deleted");
        foreach (ent in var_5633914d) {
            ent unlink();
            ent delete();
        }
        level.custom_characters[var_f141235b][var_228f64da.targetname] = undefined;
        var_5633914d = [];
        var_228f64da delete();
        var_228f64da = undefined;
        function_66de4847();
    }

    // Namespace namespace_7da27482/character_customization
    // Params 3, eflags: 0x4
    // Checksum 0x67b9f8d2, Offset: 0x14b0
    // Size: 0xdc
    function private function_b020b858(model_name, lod = -1, mip = -1) {
        index = array::find(var_506d3c33, {#model:model_name, #lod:lod, #mip:mip}, &function_1a57b132);
        if (isdefined(index)) {
            array::pop(var_506d3c33, index, 0);
            character_customization::function_247f6628(model_name, lod, mip);
        }
    }

    // Namespace namespace_7da27482/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0x7e359c1b, Offset: 0x18b0
    // Size: 0x5a
    function function_b06080fb() {
        if (var_c31e86ed) {
            return #"tag_origin";
        }
        return character_customization::function_6bca50af(&function_5d23af5b, var_1d73bad9, var_cf55444c, var_f5c0467b[0], _i_mode);
    }

    // Namespace namespace_7da27482/character_customization
    // Params 4, eflags: 0x0
    // Checksum 0xa23100f4, Offset: 0x37a8
    // Size: 0x2d4
    function play_gesture(gesture_index, wait_until_model_steam_ends, replay_if_already_playing = 1, ignore_if_already_playing = 0) {
        self endon(#"deleted");
        self endon(#"cancel_gesture");
        if (wait_until_model_steam_ends && isdefined(var_1d18f5c7)) {
            while (!function_ea4ac9f8()) {
                wait 0.25;
            }
        }
        var_2ec36514 = var_cbcee022;
        function_39a68bf2(1, 1);
        gesture = get_gesture(gesture_index);
        if (isdefined(gesture) && isdefined(gesture.animation)) {
            self endon(#"hash_578cb70e92c24a5a", #"cancel_gesture");
            while (!isdefined(var_cbcee022) && !isdefined(var_54430cb6)) {
                wait 0.1;
            }
            var_a7e34ee1 = var_228f64da getcurrentanimscriptedname();
            var_99789677 = var_a7e34ee1 === gesture.animation || var_a7e34ee1 === gesture.intro || var_a7e34ee1 === gesture.outro;
            if (!ignore_if_already_playing || !var_99789677) {
                if (replay_if_already_playing || !var_99789677) {
                    self thread function_60b3658e(var_2ec36514, 1);
                    character_customization::function_bee62aa1(self);
                    if (isdefined(gesture.intro)) {
                        var_228f64da animation::play(gesture.intro, var_228f64da);
                    }
                    var_228f64da animation::play(gesture.animation, var_228f64da);
                    if (isdefined(gesture.outro)) {
                        var_228f64da animation::play(gesture.outro, var_228f64da);
                    }
                    self notify(#"gesture_ended");
                    return;
                }
                self thread function_60b3658e(var_2ec36514, 0);
            }
        }
    }

    // Namespace namespace_7da27482/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0x5b8f39f4, Offset: 0xde0
    // Size: 0xa
    function is_visible() {
        return var_43b94d19;
    }

    // Namespace namespace_7da27482/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0x9a1f5ec0, Offset: 0x3558
    // Size: 0x170
    function function_b94f710e() {
        if (isdefined(var_cbcee022)) {
            function_39a68bf2();
            var_228f64da thread character_customization::play_intro_and_animation(_origin, _angles, undefined, var_cbcee022, 0);
        } else if (isdefined(var_54430cb6)) {
            function_39a68bf2();
            if (var_8d2161e9) {
                var_a287debe thread scene::play(var_54430cb6, var_228f64da);
            } else {
                var_a287debe thread scene::play(var_54430cb6);
            }
        }
        foreach (slot, ent in var_5633914d) {
            ent thread character_customization::play_intro_and_animation(_origin, _angles, undefined, var_bf273e28[slot], 1);
        }
    }

    // Namespace namespace_7da27482/character_customization
    // Params 3, eflags: 0x4
    // Checksum 0x5f75663f, Offset: 0x12a8
    // Size: 0xa4
    function private force_stream_model(model_name, lod = -1, mip = -1) {
        array::add(var_506d3c33, {#model:model_name, #lod:lod, #mip:mip});
        character_customization::function_221a94ac(model_name, lod, mip);
    }

    // Namespace namespace_7da27482/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0x4deb402f, Offset: 0xe50
    // Size: 0x4c
    function hide_model() {
        var_228f64da hide();
        self notify(#"cancel_gesture");
        var_43b94d19 = 0;
        function_c39fbf91();
    }

    // Namespace namespace_7da27482/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0xa9379210, Offset: 0x1840
    // Size: 0x32
    function function_bf7bce05() {
        if (var_c31e86ed) {
            return 1;
        }
        return function_4611d0e6(_i_mode, var_1d73bad9);
    }

    // Namespace namespace_7da27482/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0x98d4f1de, Offset: 0xbd0
    // Size: 0x1a
    function function_c0ccd9ea(default_exploder) {
        var_266b2ff0 = default_exploder;
    }

    // Namespace namespace_7da27482/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0x711e545c, Offset: 0x15d0
    // Size: 0x56
    function set_character_mode(character_mode) {
        assert(isdefined(character_mode));
        if (_i_mode != character_mode) {
            var_b627749c = 1;
            _i_mode = character_mode;
        }
    }

    // Namespace namespace_7da27482/character_customization
    // Params 0, eflags: 0x4
    // Checksum 0xf3ab6f7, Offset: 0x7a8
    // Size: 0x88
    function private function_c39fbf91() {
        foreach (callback in var_180f1c7d) {
            [[ callback ]](var_f141235b, self);
        }
    }

    // Namespace namespace_7da27482/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0x43f28d3d, Offset: 0x1a20
    // Size: 0x62
    function function_cdc02b18() {
        if (var_c31e86ed) {
            return #"tag_origin";
        }
        return character_customization::function_6bca50af(&function_cde23658, var_1d73bad9, var_cf55444c, var_f5c0467b[4], _i_mode);
    }

    // Namespace namespace_7da27482/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0xd641ee9a, Offset: 0xc70
    // Size: 0x38
    function set_show_helmets(show_helmets) {
        if (var_609efd3e != show_helmets) {
            var_609efd3e = show_helmets;
            function_c1aab607();
        }
    }

    // Namespace namespace_7da27482/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0x6be4bb6f, Offset: 0x1a90
    // Size: 0x62
    function function_d5e754c6() {
        if (var_c31e86ed) {
            return #"c_t8_mp_swatbuddy_body2";
        }
        return character_customization::function_6bca50af(&function_92ea4100, var_1d73bad9, var_cf55444c, var_f5c0467b[6], _i_mode);
    }

    // Namespace namespace_7da27482/character_customization
    // Params 2, eflags: 0x0
    // Checksum 0x852d3925, Offset: 0x3d28
    // Size: 0x15c
    function function_dd872e2b(params, force_updates) {
        if (isdefined(params.weapon_right) || isdefined(params.weapon_left)) {
            update_model_attachment(params.weapon_right, "tag_weapon_right", params.weapon_right_anim, params.weapon_right_anim_intro, force_updates);
            update_model_attachment(params.weapon_left, "tag_weapon_left", params.weapon_left_anim, params.weapon_left_anim_intro, force_updates);
            return;
        }
        if (isdefined(params.activeweapon)) {
            var_228f64da attachweapon(params.activeweapon, isdefined(params.var_b8f20727) ? params.var_b8f20727 : 0, 1);
            function_4b2b3712(var_f141235b, var_228f64da, isdefined(params.var_b8f20727) ? params.var_b8f20727 : 0, var_27af8d38);
            var_228f64da useweaponhidetags(params.activeweapon);
        }
    }

    // Namespace namespace_7da27482/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0x63fdf0d4, Offset: 0xc48
    // Size: 0x1a
    function function_e08bf4f2(var_db61785f) {
        var_81bd1932 = var_db61785f;
    }

    // Namespace namespace_7da27482/character_customization
    // Params 5, eflags: 0x0
    // Checksum 0x27970a26, Offset: 0x2e38
    // Size: 0x370
    function update_model_attachment(attached_model, slot, model_anim, model_intro_anim, force_update) {
        assert(isdefined(level.model_type_bones));
        if (force_update || attached_model !== var_45210dc7[slot] || model_anim !== var_bf273e28[slot]) {
            bone = isdefined(level.model_type_bones[slot]) ? level.model_type_bones[slot] : slot;
            assert(isdefined(bone));
            if (isdefined(var_45210dc7[slot])) {
                if (isdefined(var_5633914d[slot])) {
                    var_5633914d[slot] unlink();
                    var_5633914d[slot] delete();
                    var_5633914d[slot] = undefined;
                } else if (var_228f64da isattached(var_45210dc7[slot], bone)) {
                    var_228f64da detach(var_45210dc7[slot], bone);
                }
                var_45210dc7[slot] = undefined;
            }
            var_45210dc7[slot] = attached_model;
            if (isdefined(var_45210dc7[slot])) {
                if (isdefined(model_anim)) {
                    ent = spawn(var_f141235b, var_228f64da.origin, "script_model");
                    ent sethighdetail(var_851003fe, var_bf4feef5);
                    var_5633914d[slot] = ent;
                    ent setmodel(var_45210dc7[slot]);
                    if (!ent hasanimtree()) {
                        ent useanimtree("generic");
                    }
                    ent.origin = _origin;
                    ent.angles = _angles;
                    ent thread character_customization::play_intro_and_animation(_origin, _angles, model_intro_anim, model_anim, 1);
                } else if (!var_228f64da isattached(var_45210dc7[slot], bone)) {
                    var_228f64da attach(var_45210dc7[slot], bone);
                }
                var_bf273e28[slot] = model_anim;
            }
        }
        if (isdefined(var_5633914d[slot])) {
            function_62dd99d6(var_5633914d[slot]);
        }
    }

    // Namespace namespace_7da27482/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0xae6682e, Offset: 0x41d8
    // Size: 0x94
    function function_e599283f() {
        return {#xuid:_xuid, #charactermode:_i_mode, #charactertype:var_1d73bad9, #outfit:var_cf55444c, #warpaintoutfit:var_cfe86a3e, #outfititems:var_f5c0467b};
    }

    // Namespace namespace_7da27482/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0x349c38b0, Offset: 0xf28
    // Size: 0xa
    function get_origin() {
        return _origin;
    }

    // Namespace namespace_7da27482/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0x79b1e4a5, Offset: 0x10a8
    // Size: 0x22
    function function_e8b0acef() {
        return getcharacterfields(var_1d73bad9, _i_mode);
    }

    // Namespace namespace_7da27482/character_customization
    // Params 0, eflags: 0x0
    // Checksum 0xc7bbcefd, Offset: 0x11a8
    // Size: 0xa
    function function_ea4ac9f8() {
        return var_1d18f5c7;
    }

    // Namespace namespace_7da27482/character_customization
    // Params 2, eflags: 0x0
    // Checksum 0xa754bb03, Offset: 0x31b0
    // Size: 0x3a0
    function function_ef064067(params, force_update) {
        changed = 0;
        if (!isdefined(params)) {
            params = {};
        }
        if (!isdefined(params.exploder_id)) {
            params.exploder_id = var_266b2ff0;
        }
        align_changed = 0;
        if (isdefined(var_9a4a8ea)) {
            if (!isdefined(params.align_struct)) {
                params.align_struct = struct::get(var_9a4a8ea);
            }
        }
        if (isdefined(params.align_struct) && (params.align_struct.origin !== _origin || params.align_struct.angles !== _angles)) {
            _origin = params.align_struct.origin;
            _angles = params.align_struct.angles;
            if (!isdefined(params.anim_name)) {
                params.anim_name = var_cbcee022;
            }
            align_changed = 1;
        }
        if (isdefined(params.anim_name) && (params.anim_name !== var_cbcee022 || align_changed || force_update)) {
            changed = 1;
            function_39a68bf2(0);
            var_cbcee022 = params.anim_name;
            var_54430cb6 = undefined;
            var_5d01abf7 = undefined;
            var_6ce65c01 = undefined;
            var_a287debe = undefined;
            var_228f64da thread character_customization::play_intro_and_animation(_origin, _angles, params.anim_intro_name, var_cbcee022, 0);
        } else if (isdefined(params.scene) && (params.scene !== var_54430cb6 || params.scene_target !== var_a287debe || is_true(params.var_a34c858c) != var_8d2161e9 || force_update)) {
            changed = 1;
            function_39a68bf2(0);
            var_54430cb6 = params.scene;
            var_5d01abf7 = params.var_74741b75;
            var_6ce65c01 = params.var_a68ab9c2;
            var_a287debe = isdefined(params.scene_target) ? params.scene_target : level;
            var_8d2161e9 = is_true(params.var_a34c858c);
            var_cbcee022 = undefined;
            if (var_8d2161e9) {
                model = var_228f64da;
            }
            thread character_customization::function_f7a5fba4(var_a287debe, var_54430cb6, model, var_5d01abf7, var_6ce65c01, params.var_f5332569, params.var_b1e821c5, params.var_bfbc1f4f);
        }
        return changed;
    }

    // Namespace namespace_7da27482/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0x32101c6d, Offset: 0x1898
    // Size: 0x10
    function function_ef6f931f(*params) {
        return true;
    }

    // Namespace namespace_7da27482/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0x58833d23, Offset: 0x1880
    // Size: 0x10
    function function_f941c5de(*params) {
        return true;
    }

    // Namespace namespace_7da27482/character_customization
    // Params 1, eflags: 0x0
    // Checksum 0x184c3b3f, Offset: 0x10d8
    // Size: 0xc2
    function get_gesture(gesture_index) {
        if (gesture_index == -1) {
            if (#"female" === getherogender(var_1d73bad9, _i_mode)) {
                return {#animation:#"pb_rifle_fem_stand_spray_fb"};
            } else {
                return {#animation:#"pb_rifle_male_stand_spray_fb"};
            }
        }
        return function_2a6a2af(var_1d73bad9, _i_mode, gesture_index);
    }

}

// Namespace character_customization/character_customization
// Params 0, eflags: 0x6
// Checksum 0x87cdb54c, Offset: 0x2e0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"character_customization", &preinit, undefined, undefined, undefined);
}

// Namespace character_customization/character_customization
// Params 5, eflags: 0x0
// Checksum 0x7247cea, Offset: 0x328
// Size: 0xa2
function function_6bca50af(fn, character_index, outfit_index, var_e1daa8d9, mode) {
    model = [[ fn ]](character_index, outfit_index, var_e1daa8d9, mode);
    if (!isdefined(model)) {
        model = [[ fn ]](character_index, outfit_index, 0, mode);
        if (!isdefined(model)) {
            model = [[ fn ]](character_index, 0, 0, mode);
        }
    }
    return isdefined(model) ? model : #"tag_origin";
}

// Namespace character_customization/character_customization
// Params 1, eflags: 0x0
// Checksum 0x323c4ba6, Offset: 0x3d8
// Size: 0xac
function function_6aee5a4e(character) {
    if (isdefined(level.var_6963abdb)) {
        var_2d0192e5 = [[ character ]]->function_82e05d64();
        if (isdefined(var_2d0192e5) && isdefined(var_2d0192e5.xuid)) {
            xuid = xuidtostring(var_2d0192e5.xuid);
            return level.var_6963abdb[xuid];
        }
        if (isdefined(character._xuid)) {
            return level.var_6963abdb[character._xuid];
        }
    }
    return 0;
}

// Namespace character_customization/character_customization
// Params 1, eflags: 0x0
// Checksum 0x790ecf03, Offset: 0x490
// Size: 0xac
function function_bee62aa1(character) {
    if (isdefined(level.var_6963abdb)) {
        var_2d0192e5 = [[ character ]]->function_82e05d64();
        if (isdefined(var_2d0192e5) && isdefined(var_2d0192e5.xuid)) {
            xuid = xuidtostring(var_2d0192e5.xuid);
            level.var_6963abdb[xuid] = 0;
        }
        if (isdefined(character._xuid)) {
            level.var_6963abdb[character._xuid] = 0;
        }
    }
}

// Namespace character_customization/character_customization
// Params 0, eflags: 0x4
// Checksum 0xc5e91fef, Offset: 0x5778
// Size: 0x100
function private preinit() {
    level.var_dda8e1d8 = &function_1c0ddf49;
    level.model_type_bones = [#"outfit_head":"", #"outfit_headgear":"", #"outfit_legs":"", #"outfit_torso":""];
    if (!isdefined(level.liveccdata)) {
        level.liveccdata = [];
    }
    if (!isdefined(level.custom_characters)) {
        level.custom_characters = [];
    }
    if (!isdefined(level.extra_cam_hero_data)) {
        level.extra_cam_hero_data = [];
    }
    level.charactercustomizationsetup = &localclientconnect;
    level.var_6e23b0fc = [];
}

// Namespace character_customization/character_customization
// Params 1, eflags: 0x0
// Checksum 0xdea4f194, Offset: 0x5880
// Size: 0x54
function localclientconnect(localclientnum) {
    level.liveccdata[localclientnum] = setup_live_character_customization_target(localclientnum, "updateHero");
    level.staticccdata = setup_static_character_customization_target(localclientnum);
}

// Namespace character_customization/character_customization
// Params 3, eflags: 0x4
// Checksum 0xce1e3a80, Offset: 0x58e0
// Size: 0xc0
function private function_cb64c6d0(model_name, lod, mip) {
    if (!isdefined(level.var_6e23b0fc[model_name])) {
        level.var_6e23b0fc[model_name] = array();
    }
    if (!isdefined(level.var_6e23b0fc[model_name][lod])) {
        level.var_6e23b0fc[model_name][lod] = array();
    }
    if (!isdefined(level.var_6e23b0fc[model_name][lod][mip])) {
        level.var_6e23b0fc[model_name][lod][mip] = 0;
    }
}

// Namespace character_customization/character_customization
// Params 3, eflags: 0x0
// Checksum 0x41dcd1dc, Offset: 0x59a8
// Size: 0x8c
function function_221a94ac(model_name, lod, mip) {
    if (!isdefined(model_name)) {
        return;
    }
    function_cb64c6d0(model_name, lod, mip);
    level.var_6e23b0fc[model_name][lod][mip]++;
    if (level.var_6e23b0fc[model_name][lod][mip] == 1) {
        forcestreamxmodel(model_name, lod, mip);
    }
}

// Namespace character_customization/character_customization
// Params 3, eflags: 0x4
// Checksum 0xf685acc0, Offset: 0x5a40
// Size: 0x92
function private function_c358189(model_name, lod, mip) {
    if (!isdefined(model_name)) {
        return 1;
    }
    function_cb64c6d0(model_name, lod, mip);
    if (level.var_6e23b0fc[model_name][lod][mip] == 0) {
        function_221a94ac(model_name);
    }
    return forcestreamxmodel(model_name, lod, mip);
}

// Namespace character_customization/character_customization
// Params 3, eflags: 0x0
// Checksum 0x92ce81dc, Offset: 0x5ae0
// Size: 0x12c
function function_247f6628(model_name, lod, mip) {
    if (!isdefined(model_name)) {
        return;
    }
    function_cb64c6d0(model_name, lod, mip);
    level.var_6e23b0fc[model_name][lod][mip]--;
    if (level.var_6e23b0fc[model_name][lod][mip] == 0) {
        stopforcestreamingxmodel(model_name);
        array::pop(level.var_6e23b0fc[model_name][lod], mip);
        if (level.var_6e23b0fc[model_name][lod].size == 0) {
            array::pop(level.var_6e23b0fc[model_name], lod);
            if (level.var_6e23b0fc[model_name].size == 0) {
                array::pop(level.var_6e23b0fc, model_name);
            }
        }
    }
}

// Namespace character_customization/character_customization
// Params 3, eflags: 0x0
// Checksum 0x79bee30b, Offset: 0x5c18
// Size: 0xee
function function_dd295310(charactermodel, localclientnum, alt_render_mode = 1) {
    if (!isdefined(charactermodel)) {
        return undefined;
    }
    if (!isdefined(level.custom_characters[localclientnum])) {
        level.custom_characters[localclientnum] = [];
    }
    if (isdefined(level.custom_characters[localclientnum][charactermodel.targetname])) {
        return level.custom_characters[localclientnum][charactermodel.targetname];
    }
    var_c372a4ea = new class_7da27482();
    [[ var_c372a4ea ]]->function_7ed995de(localclientnum, charactermodel, alt_render_mode);
    level.custom_characters[localclientnum][charactermodel.targetname] = var_c372a4ea;
    return var_c372a4ea;
}

// Namespace character_customization/character_customization
// Params 3, eflags: 0x0
// Checksum 0x309b80d, Offset: 0x5d10
// Size: 0x11a
function function_aa5382ed(customization1, customization2, check_xuid = 1) {
    if (isdefined(customization1) != isdefined(customization2)) {
        return true;
    } else if (!isdefined(customization1)) {
        return false;
    }
    if (check_xuid && customization1.xuid !== customization2.xuid) {
        return true;
    }
    if (customization1.charactertype != customization2.charactertype) {
        return true;
    }
    if (customization1.outfit != customization2.outfit) {
        return true;
    }
    if (customization1.var_cfe86a3e != customization2.var_cfe86a3e) {
        return true;
    }
    for (i = 0; i < customization1.outfititems.size; i++) {
        if (customization1.outfititems[i] != customization2.outfititems[i]) {
            return true;
        }
    }
    return false;
}

// Namespace character_customization/character_customization
// Params 3, eflags: 0x0
// Checksum 0x45bf7bbc, Offset: 0x5e38
// Size: 0x134
function function_7474681d(local_client_num, session_mode, character_index) {
    outfit_index = function_9ec573f1(local_client_num, session_mode, character_index);
    var_17b172ca = function_76fbb09e(local_client_num, session_mode, character_index);
    outfit_items = [];
    for (itemtype = 0; itemtype < 8; itemtype++) {
        var_9b90e15d = itemtype == 7 ? var_17b172ca : outfit_index;
        outfit_items[itemtype] = function_bd9a67ae(local_client_num, session_mode, character_index, var_9b90e15d, itemtype);
    }
    return {#charactermode:session_mode, #charactertype:character_index, #outfit:outfit_index, #warpaintoutfit:var_17b172ca, #outfititems:outfit_items};
}

// Namespace character_customization/character_customization
// Params 2, eflags: 0x0
// Checksum 0xf9333768, Offset: 0x5f78
// Size: 0xb4
function function_3f5625f1(mode, character_index = 1) {
    outfit_items = [];
    for (itemtype = 0; itemtype < 8; itemtype++) {
        outfit_items[itemtype] = 0;
    }
    return {#charactermode:mode, #charactertype:character_index, #outfit:0, #warpaintoutfit:0, #outfititems:outfit_items};
}

// Namespace character_customization/character_customization
// Params 5, eflags: 0x0
// Checksum 0x44f16e95, Offset: 0x6038
// Size: 0xac
function play_intro_and_animation(origin, angles, intro_anim_name, anim_name, b_keep_link) {
    self notify("9d2d2bfb6cd0e98");
    self endon("9d2d2bfb6cd0e98");
    if (isdefined(intro_anim_name)) {
        self animation::play(intro_anim_name, origin, angles, 1, 0, 0, 0, b_keep_link);
    }
    if (isdefined(self)) {
        self animation::play(anim_name, origin, angles, 1, 0, 0, 0, b_keep_link);
    }
}

// Namespace character_customization/character_customization
// Params 8, eflags: 0x0
// Checksum 0x8770b370, Offset: 0x60f0
// Size: 0x2cc
function function_f7a5fba4(align_target, str_scene, model, var_f647c5b2, var_559c5c3e, var_b8f75d74, var_b1e821c5, var_bfbc1f4f = 0) {
    self notify("21d509137d1ba11f");
    self endon("21d509137d1ba11f");
    if (isdefined(var_b8f75d74) && var_b8f75d74 > 0 && var_b8f75d74 < 1) {
        if (isdefined(var_f647c5b2)) {
            align_target scene::play_from_time(str_scene, var_f647c5b2, model, var_b8f75d74, 1, 1, var_b1e821c5);
            if (isdefined(var_559c5c3e)) {
                str_scene = function_9faa5b77(str_scene);
                var_559c5c3e = function_7d2b4e1f(str_scene, var_559c5c3e);
                align_target = function_bdd0baed(var_bfbc1f4f, align_target);
                if (isdefined(var_b1e821c5.var_9e6d8a3d)) {
                    var_b1e821c5.blend = var_b1e821c5.var_9e6d8a3d;
                }
                align_target thread scene::play(str_scene, var_559c5c3e, model, undefined, undefined, undefined, var_b1e821c5);
            }
        } else {
            str_scene = function_9faa5b77(str_scene);
            var_559c5c3e = function_7d2b4e1f(str_scene, var_559c5c3e);
            align_target = function_bdd0baed(var_bfbc1f4f, align_target);
            align_target thread scene::play_from_time(str_scene, var_559c5c3e, model, var_b8f75d74, 1, 1, var_b1e821c5);
        }
        return;
    }
    if (isdefined(var_f647c5b2) || isdefined(var_559c5c3e)) {
        if (isdefined(var_f647c5b2)) {
            align_target scene::play(str_scene, var_f647c5b2, model, undefined, undefined, undefined, var_b1e821c5);
        }
        if (isdefined(var_559c5c3e)) {
            str_scene = function_9faa5b77(str_scene);
            var_559c5c3e = function_7d2b4e1f(str_scene, var_559c5c3e);
            align_target = function_bdd0baed(var_bfbc1f4f, align_target);
            if (isdefined(var_b1e821c5.var_9e6d8a3d)) {
                var_b1e821c5.blend = var_b1e821c5.var_9e6d8a3d;
            }
            align_target thread scene::play(str_scene, var_559c5c3e, model, undefined, undefined, undefined, var_b1e821c5);
        }
        return;
    }
    align_target thread scene::play(str_scene, model, undefined, undefined, undefined, undefined, var_b1e821c5);
}

// Namespace character_customization/character_customization
// Params 1, eflags: 0x0
// Checksum 0x1cb040d8, Offset: 0x63c8
// Size: 0x2e
function function_9faa5b77(str_scene) {
    if (isdefined(self.var_72e4ebb3)) {
        str_scene = self.var_72e4ebb3;
        self.var_72e4ebb3 = undefined;
    }
    return str_scene;
}

// Namespace character_customization/character_customization
// Params 2, eflags: 0x0
// Checksum 0x77eaa260, Offset: 0x6400
// Size: 0x56
function function_7d2b4e1f(str_scene, var_559c5c3e) {
    if (isdefined(self.var_31ccd6da) && scene::function_9730988a(str_scene, self.var_31ccd6da)) {
        var_559c5c3e = self.var_31ccd6da;
        self.var_31ccd6da = undefined;
    }
    return var_559c5c3e;
}

// Namespace character_customization/character_customization
// Params 2, eflags: 0x0
// Checksum 0x13da6939, Offset: 0x6460
// Size: 0x94
function function_bdd0baed(var_bfbc1f4f = 0, align_target) {
    if (var_bfbc1f4f && [[ self ]]->function_ea4ac9f8()) {
        model = [[ self ]]->function_217b10ed();
        align_target = {#origin:model.origin, #angles:model.angles};
    }
    return align_target;
}

// Namespace character_customization/character_customization
// Params 2, eflags: 0x0
// Checksum 0x24264e5b, Offset: 0x6500
// Size: 0xb4
function setup_live_character_customization_target(localclientnum, notifyname) {
    characterent = getent(localclientnum, "character_customization", "targetname");
    if (isdefined(characterent)) {
        var_d0b01271 = function_dd295310(characterent, localclientnum, 1);
        [[ var_d0b01271 ]]->function_c0ccd9ea("char_customization");
        level thread updateeventthread(localclientnum, var_d0b01271, notifyname);
        return var_d0b01271;
    }
    return undefined;
}

// Namespace character_customization/character_customization
// Params 2, eflags: 0x0
// Checksum 0xc2526bd5, Offset: 0x65c0
// Size: 0x74
function update_locked_shader(localclientnum, params) {
    if (isdefined(params.isitemunlocked) && params.isitemunlocked != 1) {
        enablefrontendlockedweaponoverlay(localclientnum, 1);
        return;
    }
    enablefrontendlockedweaponoverlay(localclientnum, 0);
}

// Namespace character_customization/character_customization
// Params 4, eflags: 0x0
// Checksum 0x5ddaedb2, Offset: 0x6640
// Size: 0x3a
function function_bcc8bdf4(*localclientnum, var_d0b01271, *waitresult, params) {
    params.anim_name = [[ waitresult ]]->function_8144231c();
}

// Namespace character_customization/character_customization
// Params 4, eflags: 0x0
// Checksum 0x83603ff, Offset: 0x6688
// Size: 0xaae
function updateeventthread(localclientnum, var_d0b01271, notifyname, var_1d7f1597 = &function_bcc8bdf4) {
    while (true) {
        waitresult = level waittill(notifyname + localclientnum);
        switch (waitresult.event_name) {
        case #"update_lcn":
            [[ var_d0b01271 ]]->function_e08bf4f2(waitresult.local_client_num);
            break;
        case #"update_locked":
            [[ var_d0b01271 ]]->function_7792df22(waitresult.locked);
            break;
        case #"refresh":
            [[ var_d0b01271 ]]->function_e08bf4f2(waitresult.local_client_num);
            [[ var_d0b01271 ]]->set_character_mode(waitresult.mode);
            [[ var_d0b01271 ]]->function_225b6e07();
            [[ var_d0b01271 ]]->function_77e3be08();
            params = {};
            [[ var_1d7f1597 ]](localclientnum, var_d0b01271, waitresult, params);
            if (is_true(params.var_c76f3e47)) {
                [[ var_d0b01271 ]]->function_27945cb8(1);
            }
            [[ var_d0b01271 ]]->update(params);
            break;
        case #"refresh_anim":
            params = {};
            [[ var_1d7f1597 ]](localclientnum, var_d0b01271, waitresult, params);
            params.var_99a89f83 = 1;
            if (is_true(params.var_c76f3e47)) {
                [[ var_d0b01271 ]]->function_27945cb8(1);
            }
            [[ var_d0b01271 ]]->update(params);
            break;
        case #"changehero":
            [[ var_d0b01271 ]]->set_character_mode(waitresult.mode);
            [[ var_d0b01271 ]]->set_character_index(waitresult.character_index);
            [[ var_d0b01271 ]]->function_77e3be08();
            params = {};
            [[ var_1d7f1597 ]](localclientnum, var_d0b01271, waitresult, params);
            if (is_true(params.var_c76f3e47)) {
                [[ var_d0b01271 ]]->function_27945cb8(1);
            }
            [[ var_d0b01271 ]]->update(params);
            break;
        case #"resetcharacter":
            [[ var_d0b01271 ]]->function_77e3be08();
            params = {};
            [[ var_1d7f1597 ]](localclientnum, var_d0b01271, waitresult, params);
            [[ var_d0b01271 ]]->update(params);
            break;
        case #"changeoutfit":
            [[ var_d0b01271 ]]->set_character_outfit(waitresult.outfit_index);
            [[ var_d0b01271 ]]->function_10b0cbea();
            [[ var_d0b01271 ]]->function_59d1302f();
            params = {};
            [[ var_1d7f1597 ]](localclientnum, var_d0b01271, waitresult, params);
            if (is_true(params.var_c76f3e47)) {
                [[ var_d0b01271 ]]->function_27945cb8(1);
            }
            [[ var_d0b01271 ]]->update(params);
            break;
        case #"changewarpaintoutfit":
            [[ var_d0b01271 ]]->function_72be01b9();
            [[ var_d0b01271 ]]->function_158505aa(waitresult.outfit_index);
            [[ var_d0b01271 ]]->function_59d1302f();
            params = {};
            [[ var_1d7f1597 ]](localclientnum, var_d0b01271, waitresult, params);
            if (is_true(params.var_c76f3e47)) {
                [[ var_d0b01271 ]]->function_27945cb8(1);
            }
            [[ var_d0b01271 ]]->update(params);
            break;
        case #"changeoutfititem":
            if (isdefined(waitresult.outfit_index)) {
                if (waitresult.item_type == 7) {
                    [[ var_d0b01271 ]]->function_158505aa(waitresult.outfit_index);
                } else {
                    [[ var_d0b01271 ]]->set_character_outfit(waitresult.outfit_index);
                }
            }
            [[ var_d0b01271 ]]->set_character_outfit_item(waitresult.item_index, waitresult.item_type);
            params = {};
            [[ var_1d7f1597 ]](localclientnum, var_d0b01271, waitresult, params);
            if (is_true(params.var_c76f3e47)) {
                [[ var_d0b01271 ]]->function_27945cb8(1);
            }
            [[ var_d0b01271 ]]->update(params);
            break;
        case #"hash_220546ce38834f4c":
            [[ var_d0b01271 ]]->function_ac9cc79d(waitresult.item_type);
            params = {};
            [[ var_1d7f1597 ]](localclientnum, var_d0b01271, waitresult, params);
            if (is_true(params.var_c76f3e47)) {
                [[ var_d0b01271 ]]->function_27945cb8(1);
            }
            [[ var_d0b01271 ]]->update(params);
            break;
        case #"updateface":
            [[ var_d0b01271 ]]->function_617a9ce4(waitresult.mode);
            thread [[ var_d0b01271 ]]->function_81d84c71();
            break;
        case #"previewshop":
        case #"previewshopface":
            [[ var_d0b01271 ]]->set_character_mode(waitresult.mode);
            [[ var_d0b01271 ]]->set_character_index(waitresult.character_index);
            [[ var_d0b01271 ]]->set_character_outfit(waitresult.outfit_index);
            [[ var_d0b01271 ]]->function_158505aa(waitresult.outfit_index);
            outfititems = strtok(waitresult.outfititems, ";");
            foreach (type, item in outfititems) {
                [[ var_d0b01271 ]]->function_9146bf81(int(item), type);
            }
            params = {};
            [[ var_1d7f1597 ]](localclientnum, var_d0b01271, waitresult, params);
            if (waitresult.event_name == "previewShopFace") {
                params.align_struct = struct::get(#"tag_align_quartermaster_character_head");
            }
            if (is_true(params.var_c76f3e47)) {
                [[ var_d0b01271 ]]->function_27945cb8(1);
            }
            [[ var_d0b01271 ]]->update(params);
            break;
        case #"loadpreset":
            if (isdefined(waitresult.outfit_index)) {
                [[ var_d0b01271 ]]->set_character_outfit(waitresult.outfit_index);
            }
            outfititems = strtok(waitresult.presets, ";");
            foreach (type, item in outfititems) {
                if (type != 7 && type != 1) {
                    [[ var_d0b01271 ]]->function_9146bf81(int(item), type);
                }
            }
            params = {};
            [[ var_1d7f1597 ]](localclientnum, var_d0b01271, waitresult, params);
            if (is_true(params.var_c76f3e47)) {
                [[ var_d0b01271 ]]->function_27945cb8(1);
            }
            [[ var_d0b01271 ]]->update(params);
            break;
        case #"previewshopgesture":
            [[ var_d0b01271 ]]->set_character_mode(waitresult.mode);
            [[ var_d0b01271 ]]->set_character_index(waitresult.character_index);
            [[ var_d0b01271 ]]->function_22039feb();
            params = {};
            [[ var_1d7f1597 ]](localclientnum, var_d0b01271, waitresult, params);
            if (is_true(params.var_c76f3e47)) {
                [[ var_d0b01271 ]]->function_27945cb8(1);
            }
            [[ var_d0b01271 ]]->update(params);
            break;
        case #"previewgesture":
            thread [[ var_d0b01271 ]]->play_gesture(waitresult.gesture_index, waitresult.wait_until_model_steam_ends, waitresult.replay_if_already_playing, waitresult.ignore_if_already_playing);
            break;
        case #"stopgesture":
            var_d0b01271 notify(#"cancel_gesture");
            break;
        case #"hide":
            [[ var_d0b01271 ]]->hide_model();
            break;
        case #"show":
            [[ var_d0b01271 ]]->show_model();
            break;
        }
    }
}

// Namespace character_customization/character_customization
// Params 4, eflags: 0x0
// Checksum 0x740c494d, Offset: 0x7140
// Size: 0x9e
function rotation_thread_spawner(localclientnum, var_d0b01271, endonevent, var_cd34be2e) {
    if (!isdefined(endonevent)) {
        return;
    }
    baseangles = [[ var_d0b01271 ]]->function_217b10ed().angles;
    level update_model_rotation_for_right_stick(localclientnum, var_d0b01271, endonevent, var_cd34be2e);
    var_d0b01271.var_c492e538 = undefined;
    if (![[ var_d0b01271 ]]->function_4a271da1()) {
        [[ var_d0b01271 ]]->function_217b10ed().angles = baseangles;
    }
}

// Namespace character_customization/character_customization
// Params 4, eflags: 0x4
// Checksum 0x2aa33962, Offset: 0x71e8
// Size: 0x47c
function private update_model_rotation_for_right_stick(localclientnum, var_d0b01271, endonevent, var_cd34be2e) {
    level endon(endonevent);
    while (true) {
        data_lcn = [[ var_d0b01271 ]]->function_690c9509();
        if (localclientnum == data_lcn && localclientactive(data_lcn) && ![[ var_d0b01271 ]]->function_4a271da1()) {
            model = [[ var_d0b01271 ]]->function_217b10ed();
            if (isdefined(model)) {
                pos = getcontrollerposition(data_lcn);
                change = pos[#"rightstick"][0];
                if (!gamepadusedlast(localclientnum)) {
                    pos = getxcammousecontrol(data_lcn);
                    change -= pos[#"yaw"];
                }
                s_align = {#origin:model.origin, #angles:model.angles};
                if (isdefined(var_cd34be2e.str_scene)) {
                    if (isdefined(var_cd34be2e.var_c76d5a0b) && isdefined(var_cd34be2e.var_e982dc6b) && change < -0.5) {
                        var_d0b01271.var_c492e538 = var_cd34be2e.var_c76d5a0b;
                        var_d0b01271.var_ae32b908 = model.origin;
                        var_d0b01271.var_aba63ea = model.angles;
                        if (isdefined(level.var_6365df1f)) {
                            params = [[ level.var_6365df1f ]](localclientnum, var_d0b01271);
                            [[ var_d0b01271 ]]->update(params);
                        } else {
                            var_d0b01271 thread function_f7a5fba4(s_align, var_cd34be2e.str_scene, model, var_cd34be2e.var_c76d5a0b, var_cd34be2e.var_e982dc6b);
                        }
                        var_41173053 = scene::function_8582657c(var_cd34be2e.str_scene, var_cd34be2e.var_c76d5a0b);
                        wait var_41173053;
                        var_d0b01271.var_c492e538 = undefined;
                        var_d0b01271.var_ae32b908 = undefined;
                        var_d0b01271.var_aba63ea = undefined;
                        var_d0b01271 notify(#"hash_6b33c66d373ab370");
                    } else if (isdefined(var_cd34be2e.var_3480dd47) && isdefined(var_cd34be2e.var_1aa99c8b) && change > 0.5) {
                        var_d0b01271.var_c492e538 = var_cd34be2e.var_3480dd47;
                        var_d0b01271.var_ae32b908 = model.origin;
                        var_d0b01271.var_aba63ea = model.angles;
                        if (isdefined(level.var_6365df1f)) {
                            params = [[ level.var_6365df1f ]](localclientnum, var_d0b01271);
                            [[ var_d0b01271 ]]->update(params);
                        } else {
                            var_d0b01271 thread function_f7a5fba4(s_align, var_cd34be2e.str_scene, model, var_cd34be2e.var_3480dd47, var_cd34be2e.var_1aa99c8b);
                        }
                        var_41173053 = scene::function_8582657c(var_cd34be2e.str_scene, var_cd34be2e.var_3480dd47);
                        wait var_41173053;
                        var_d0b01271.var_c492e538 = undefined;
                        var_d0b01271.var_ae32b908 = undefined;
                        var_d0b01271.var_aba63ea = undefined;
                        var_d0b01271 notify(#"hash_6b33c66d373ab370");
                    }
                } else if (abs(change) > 0.0001) {
                    model.angles = (model.angles[0], absangleclamp360(model.angles[1] + change * 3), model.angles[2]);
                }
            }
        }
        waitframe(1);
    }
}

// Namespace character_customization/character_customization
// Params 0, eflags: 0x0
// Checksum 0x1dbd37b, Offset: 0x7670
// Size: 0xc
function function_f40eb809() {
    return isdefined(self.var_c492e538);
}

// Namespace character_customization/character_customization
// Params 1, eflags: 0x0
// Checksum 0x7d597a6d, Offset: 0x7688
// Size: 0xcc
function setup_static_character_customization_target(localclientnum) {
    characterent = getent(localclientnum, "character_customization_staging", "targetname");
    level.extra_cam_hero_data[localclientnum] = setup_character_extracam_struct("ui_cam_character_customization", "cam_menu_unfocus", #"pb_cac_main_lobby_idle");
    if (isdefined(characterent)) {
        var_d0b01271 = function_dd295310(characterent, localclientnum);
        level thread update_character_extracam(localclientnum, var_d0b01271);
        return var_d0b01271;
    }
    return undefined;
}

// Namespace character_customization/character_customization
// Params 3, eflags: 0x0
// Checksum 0x3de867f, Offset: 0x7760
// Size: 0x64
function setup_character_extracam_struct(xcam, subxcam, model_animation) {
    newstruct = {#xcam:xcam, #subxcam:subxcam, #anim_name:model_animation};
    return newstruct;
}

// Namespace character_customization/character_customization
// Params 3, eflags: 0x0
// Checksum 0x8089f12f, Offset: 0x77d0
// Size: 0x3c0
function setup_character_extracam_settings(localclientnum, var_d0b01271, extracam_data_struct) {
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
    params = {#anim_name:extracam_data_struct.anim_name, #extracam_data:extracam_data_struct, #sessionmode:extracam_data_struct.sessionmode, #hide_helmet:is_true(extracam_data_struct.hidehelmet)};
    [[ var_d0b01271 ]]->function_79f89fb6(extracam_data_struct.sessionmode === 2);
    [[ var_d0b01271 ]]->set_alt_render_mode(0);
    [[ var_d0b01271 ]]->set_character_mode(extracam_data_struct.sessionmode);
    [[ var_d0b01271 ]]->set_character_index(extracam_data_struct.characterindex);
    if (is_true(extracam_data_struct.isdefaulthero) || is_true(extracam_data_struct.defaultimagerender)) {
        [[ var_d0b01271 ]]->function_22039feb();
    } else {
        [[ var_d0b01271 ]]->function_77e3be08();
        if (isdefined(extracam_data_struct.var_d3927004) && isdefined(extracam_data_struct.var_eb3dfef8)) {
            [[ var_d0b01271 ]]->set_character_outfit_item(extracam_data_struct.var_eb3dfef8, extracam_data_struct.var_d3927004);
        }
    }
    [[ var_d0b01271 ]]->update(params);
    while (![[ var_d0b01271 ]]->is_streamed()) {
        waitframe(1);
    }
    if (is_true(extracam_data_struct.defaultimagerender)) {
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
    [[ var_d0b01271 ]]->function_79f89fb6(0);
}

// Namespace character_customization/character_customization
// Params 2, eflags: 0x0
// Checksum 0x5b6e3f7, Offset: 0x7b98
// Size: 0x78
function update_character_extracam(localclientnum, var_d0b01271) {
    level endon(#"disconnect");
    while (true) {
        waitresult = level waittill("process_character_extracam" + localclientnum);
        setup_character_extracam_settings(localclientnum, var_d0b01271, waitresult.extracam_data_struct);
    }
}

// Namespace character_customization/character_customization
// Params 9, eflags: 0x0
// Checksum 0xc3185e8e, Offset: 0x7c18
// Size: 0x156
function function_1c0ddf49(localclientnum, jobindex, extracamindex, sessionmode, characterindex, outfitindex, itemtype, itemindex, defaultimagerender) {
    extracam_data = undefined;
    if (defaultimagerender) {
        extracam_data = setup_character_extracam_struct("ui_cam_char_customization_icons_render", "loot_body", #"pb_cac_vs_screen_idle_1");
    } else {
        extracam_data = setup_character_extracam_struct("ui_cam_char_customization_icons", "cam_body", #"pb_cac_vs_screen_idle_1");
    }
    extracam_data.jobindex = jobindex;
    extracam_data.extracamindex = extracamindex;
    extracam_data.sessionmode = sessionmode;
    extracam_data.characterindex = characterindex;
    extracam_data.outfitindex = outfitindex;
    extracam_data.var_d3927004 = itemtype;
    extracam_data.var_eb3dfef8 = itemindex;
    extracam_data.defaultimagerender = defaultimagerender;
    level notify("process_character_extracam" + localclientnum, {#extracam_data_struct:extracam_data});
}

