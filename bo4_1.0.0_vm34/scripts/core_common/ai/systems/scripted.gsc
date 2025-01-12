#namespace scripted;

// Namespace scripted/scripted
// Params 0, eflags: 0x0
// Checksum 0xe8b53fc6, Offset: 0x78
// Size: 0x9a
function main() {
    self endon(#"death");
    self notify(#"killanimscript");
    self notify(#"clearsuppressionattack");
    self.codescripted[#"root"] = "body";
    self endon(#"end_sequence");
    self.a.script = "scripted";
    self waittill(#"killanimscript");
}

// Namespace scripted/scripted
// Params 9, eflags: 0x0
// Checksum 0x5e3afe7c, Offset: 0x120
// Size: 0x4c
function init(notifyname, origin, angles, theanim, animmode, root, rate, goaltime, lerptime) {
    
}

// Namespace scripted/scripted
// Params 0, eflags: 0x0
// Checksum 0xda1e6231, Offset: 0x178
// Size: 0x20
function end_script() {
    if (isdefined(self.___archetypeonbehavecallback)) {
        [[ self.___archetypeonbehavecallback ]](self);
    }
}

