#namespace scripted;

// Namespace scripted/scripted
// Params 0, eflags: 0x1 linked
// Checksum 0xc5133f9, Offset: 0x78
// Size: 0x5a
function main() {
    self notify(#"killanimscript");
    self notify(#"clearsuppressionattack");
    self.codescripted[#"root"] = "body";
    self.a.script = "scripted";
}

// Namespace scripted/scripted
// Params 9, eflags: 0x0
// Checksum 0x596ab68e, Offset: 0xe0
// Size: 0x4c
function init(*notifyname, *origin, *angles, *theanim, *animmode, *root, *rate, *goaltime, *lerptime) {
    
}

// Namespace scripted/scripted
// Params 0, eflags: 0x1 linked
// Checksum 0x8aecb036, Offset: 0x138
// Size: 0x20
function end_script() {
    if (isdefined(self.___archetypeonbehavecallback)) {
        [[ self.___archetypeonbehavecallback ]](self);
    }
}

