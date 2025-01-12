#using scripts/core_common/scene_objects_shared;

#namespace scene;

// Namespace scene
// Method(s) 3 Total 69
class cscenevehicle : csceneobject {

    var _e;
    var _o_scene;
    var _s;

    // Namespace cscenevehicle/scene_vehicle_shared
    // Params 0, eflags: 0x0
    // Checksum 0xb0d3db0d, Offset: 0xf0
    // Size: 0xdc
    function _spawn_ent() {
        if (isdefined(_s.model)) {
            if (isassetloaded("vehicle", _s.model)) {
                _e = spawnvehicle(_s.model, _o_scene._e_root.origin, _o_scene._e_root.angles);
                _e useanimtree(#generic);
                _e.animtree = "generic";
            }
        }
    }

}

