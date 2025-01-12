#namespace animationstatenetwork;

// Namespace animationstatenetwork/animation_state_machine_mocomp
// Params 0, eflags: 0x2
// Checksum 0x3b2a4b0e, Offset: 0xd8
// Size: 0x14
function autoexec initanimationmocomps() {
    level._animationmocomps = [];
}

// Namespace animationstatenetwork/runanimationmocomp
// Params 1, eflags: 0x40
// Checksum 0xe8e112a2, Offset: 0xf8
// Size: 0x1b4
function event_handler[runanimationmocomp] runanimationmocomp(eventstruct) {
    /#
        assert(eventstruct.status >= 0 && eventstruct.status <= 2, "<dev string:x28>" + eventstruct.status + "<dev string:x48>");
    #/
    /#
        assert(isdefined(level._animationmocomps[eventstruct.name]), "<dev string:x61>" + eventstruct.name + "<dev string:x85>");
    #/
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
// Checksum 0x6f06c8cb, Offset: 0x2b8
// Size: 0x248
function registeranimationmocomp(mocompname, startfuncptr, updatefuncptr, terminatefuncptr) {
    mocompname = tolower(mocompname);
    /#
        assert(isstring(mocompname), "<dev string:x97>");
    #/
    /#
        assert(!isdefined(level._animationmocomps[mocompname]), "<dev string:xd6>" + mocompname + "<dev string:xe8>");
    #/
    level._animationmocomps[mocompname] = array();
    /#
        assert(isdefined(startfuncptr) && isfunctionptr(startfuncptr), "<dev string:x100>");
    #/
    level._animationmocomps[mocompname]["asm_mocomp_start"] = startfuncptr;
    if (isdefined(updatefuncptr)) {
        /#
            assert(isfunctionptr(updatefuncptr), "<dev string:x15d>");
        #/
        level._animationmocomps[mocompname]["asm_mocomp_update"] = updatefuncptr;
    } else {
        level._animationmocomps[mocompname]["asm_mocomp_update"] = &animationmocompemptyfunc;
    }
    if (isdefined(terminatefuncptr)) {
        /#
            assert(isfunctionptr(terminatefuncptr), "<dev string:x1b7>");
        #/
        level._animationmocomps[mocompname]["asm_mocomp_terminate"] = terminatefuncptr;
        return;
    }
    level._animationmocomps[mocompname]["asm_mocomp_terminate"] = &animationmocompemptyfunc;
}

// Namespace animationstatenetwork/animation_state_machine_mocomp
// Params 5, eflags: 0x0
// Checksum 0x74b7240e, Offset: 0x508
// Size: 0x2c
function animationmocompemptyfunc(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    
}

