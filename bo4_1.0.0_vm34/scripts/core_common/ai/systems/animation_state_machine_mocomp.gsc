#namespace animationstatenetwork;

// Namespace animationstatenetwork/animation_state_machine_mocomp
// Params 0, eflags: 0x2
// Checksum 0xea475a6f, Offset: 0xa8
// Size: 0x12
function autoexec initanimationmocomps() {
    level._animationmocomps = [];
}

// Namespace animationstatenetwork/runanimationmocomp
// Params 1, eflags: 0x40
// Checksum 0x9afb526f, Offset: 0xc8
// Size: 0x192
function event_handler[runanimationmocomp] runanimationmocomp(eventstruct) {
    assert(eventstruct.status >= 0 && eventstruct.status <= 2, "<dev string:x30>" + eventstruct.status + "<dev string:x50>");
    assert(isdefined(level._animationmocomps[eventstruct.name]), "<dev string:x69>" + eventstruct.name + "<dev string:x8d>");
    if (eventstruct.status == 0) {
        eventstruct.status = "asm_mocomp_start";
    } else if (eventstruct.status == 1) {
        eventstruct.status = "asm_mocomp_update";
    } else {
        eventstruct.status = "asm_mocomp_terminate";
    }
    animationmocompresult = eventstruct.entity [[ level._animationmocomps[eventstruct.name][eventstruct.status] ]](eventstruct.entity, eventstruct.delta_anim, eventstruct.blend_out_time, "", eventstruct.duration);
    return animationmocompresult;
}

// Namespace animationstatenetwork/animation_state_machine_mocomp
// Params 4, eflags: 0x0
// Checksum 0x58e61518, Offset: 0x268
// Size: 0x258
function registeranimationmocomp(mocompname, startfuncptr, updatefuncptr, terminatefuncptr) {
    mocompname = tolower(mocompname);
    assert(isstring(mocompname), "<dev string:x9f>");
    assert(!isdefined(level._animationmocomps[mocompname]), "<dev string:xde>" + mocompname + "<dev string:xf0>");
    level._animationmocomps[mocompname] = array();
    assert(isdefined(startfuncptr) && isfunctionptr(startfuncptr), "<dev string:x108>");
    level._animationmocomps[mocompname][#"asm_mocomp_start"] = startfuncptr;
    if (isdefined(updatefuncptr)) {
        assert(isfunctionptr(updatefuncptr), "<dev string:x165>");
        level._animationmocomps[mocompname][#"asm_mocomp_update"] = updatefuncptr;
    } else {
        level._animationmocomps[mocompname][#"asm_mocomp_update"] = &animationmocompemptyfunc;
    }
    if (isdefined(terminatefuncptr)) {
        assert(isfunctionptr(terminatefuncptr), "<dev string:x1bf>");
        level._animationmocomps[mocompname][#"asm_mocomp_terminate"] = terminatefuncptr;
        return;
    }
    level._animationmocomps[mocompname][#"asm_mocomp_terminate"] = &animationmocompemptyfunc;
}

// Namespace animationstatenetwork/animation_state_machine_mocomp
// Params 5, eflags: 0x0
// Checksum 0xf7e01bf3, Offset: 0x4c8
// Size: 0x2c
function animationmocompemptyfunc(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    
}

