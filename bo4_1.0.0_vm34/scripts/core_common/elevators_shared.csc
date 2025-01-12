#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\map;
#using scripts\core_common\struct;

#namespace elevators;

// Namespace elevators/elevators_shared
// Params 0, eflags: 0x2
// Checksum 0x82c8f0f1, Offset: 0x120
// Size: 0x4c
function autoexec init() {
    clientfield::register("toplayer", "elevator_floor_selection", 1, 1, "int", &function_f638b2a5, 0, 0);
}

// Namespace elevators/elevators_shared
// Params 7, eflags: 0x0
// Checksum 0x6a79a5d4, Offset: 0x178
// Size: 0x5fc
function function_f638b2a5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 0) {
        var_15596146 = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.elevator");
        setuimodelvalue(createuimodel(var_15596146, "open"), 0);
        return;
    }
    var_2f753dbf = struct::get_array("scriptbundle_elevators", "classname");
    var_990d223c = struct::get_array("elevator_button_call", "targetname");
    var_8d5f362d = arraygetclosest(self.origin, var_2f753dbf);
    var_3f7be432 = [];
    foreach (i, button in var_990d223c) {
        if (button.target === var_8d5f362d.targetname) {
            var_3f7be432[i] = button;
        }
    }
    var_3f7be432 = array::sort_by_script_int(var_3f7be432, 1);
    var_15596146 = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.elevator");
    count = var_990d223c.size;
    mapbundle = map::get_script_bundle();
    foreach (i, button in var_3f7be432) {
        floornum = button.script_int;
        switch (floornum) {
        case 1:
            var_9fb08a1f = i;
            break;
        case 2:
            var_9fb08a1f = i;
            break;
        case 3:
            var_9fb08a1f = i;
            break;
        case 4:
            var_9fb08a1f = i;
            break;
        case 5:
            var_9fb08a1f = i;
            break;
        case 6:
            var_9fb08a1f = i;
            break;
        case 7:
            var_9fb08a1f = i;
            break;
        case 45:
            var_9fb08a1f = 23;
            break;
        case 46:
            var_9fb08a1f = 24;
            break;
        case 57:
            var_9fb08a1f = 30;
            break;
        case 58:
            var_9fb08a1f = 31;
            break;
        case 59:
            var_9fb08a1f = 32;
            break;
        case 97:
            var_9fb08a1f = 53;
            break;
        case 21:
            var_9fb08a1f = i + 6;
            break;
        case 22:
            var_9fb08a1f = i + 6;
            break;
        case 35:
            var_9fb08a1f = i + 10;
            break;
        case 36:
            var_9fb08a1f = i + 10;
            break;
        case 37:
            var_9fb08a1f = i + 10;
            break;
        case 38:
            var_9fb08a1f = i + 10;
            break;
        }
        itemuimodel = createuimodel(var_15596146, "item" + i);
        setuimodelvalue(createuimodel(itemuimodel, "name"), mapbundle.var_83ddbbac[1].var_f232f67f[var_9fb08a1f].displayname);
        setuimodelvalue(createuimodel(itemuimodel, "id"), floornum);
    }
    setuimodelvalue(createuimodel(var_15596146, "count"), count);
    setuimodelvalue(createuimodel(var_15596146, "open"), 1);
}

