#namespace scripted;

// Namespace scripted/scripted
// Params 0, eflags: 0x0
// Checksum 0x73c0afe1, Offset: 0x78
// Size: 0x5a
function main() {
    self notify(#"killanimscript");
    self notify(#"clearsuppressionattack");
    self.codescripted[#"root"] = "body";
    self.a.script = "scripted";
}

// Namespace scripted/scripted
// Params 9, eflags: 0x0
// Checksum 0xe83dd9f2, Offset: 0xe0
// Size: 0x4c
function init(*notifyname, *origin, *angles, *theanim, *animmode, *root, *rate, *goaltime, *lerptime) {
    
}

// Namespace scripted/scripted
// Params 0, eflags: 0x0
// Checksum 0x76bba6c0, Offset: 0x138
// Size: 0x20
function end_script() {
    if (isdefined(self.___archetypeonbehavecallback)) {
        [[ self.___archetypeonbehavecallback ]](self);
    }
}

