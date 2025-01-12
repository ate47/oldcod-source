#using scripts\core_common\scene_objects_shared;

#namespace scene;

// Namespace scene
// Method(s) 7 Total 116
class cscenevehicle : csceneobject {

    var _e;
    var _o_scene;
    var _s;
    var var_5c4adc26;

    // Namespace cscenevehicle/scene_vehicle_shared
    // Params 0, eflags: 0x0
    // Checksum 0xd0d624a0, Offset: 0x388
    // Size: 0xdc
    function function_4c774cdb() {
        self notify(#"hash_3451c0bca5c1ca69");
        self endon(#"hash_3451c0bca5c1ca69");
        _o_scene endon(#"scene_done", #"scene_stop", #"scene_skip_completed");
        s_waitresult = _e waittill(#"death");
        var_5c4adc26 = 1;
        _e notify(#"hash_6e7fd8207fd988c6", {#str_scene:_o_scene._str_name});
        csceneobject::function_2550967e();
    }

    // Namespace cscenevehicle/scene_vehicle_shared
    // Params 0, eflags: 0x0
    // Checksum 0x80f724d1, Offset: 0x378
    // Size: 0x4
    function _cleanup() {
        
    }

    // Namespace cscenevehicle/scene_vehicle_shared
    // Params 0, eflags: 0x0
    // Checksum 0x1641ecd2, Offset: 0x358
    // Size: 0x14
    function _prepare() {
        csceneobject::set_objective();
    }

    // Namespace cscenevehicle/scene_vehicle_shared
    // Params 1, eflags: 0x0
    // Checksum 0x1f967983, Offset: 0x210
    // Size: 0x13c
    function _set_values(ent = self._e) {
        if (!csceneobject::error(!isvehicle(ent) && ent.classname !== "script_model", "entity is not actually a Vehicle or script_model, but set to Vehicle in scene. Check the GDT to make sure the proper object type is set")) {
            scene::prepare_generic_model_anim(ent);
        }
        csceneobject::set_ent_val("takedamage", isdefined(_s.takedamage) && _s.takedamage, ent);
        csceneobject::set_ent_val("ignoreme", !(isdefined(_s.attackme) && _s.attackme), ent);
        csceneobject::set_ent_val("allowdeath", isdefined(_s.allowdeath) && _s.allowdeath, ent);
    }

    // Namespace cscenevehicle/scene_vehicle_shared
    // Params 0, eflags: 0x0
    // Checksum 0xa0d8106a, Offset: 0x158
    // Size: 0xac
    function _spawn_ent() {
        if (isdefined(_s.model)) {
            if (isassetloaded("vehicle", _s.model)) {
                _e = spawnvehicle(_s.model, csceneobject::function_33de018f(), csceneobject::function_df0e1071());
                scene::prepare_generic_model_anim(_e);
            }
        }
    }

}

