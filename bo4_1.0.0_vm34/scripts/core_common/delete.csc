#namespace delete;

// Namespace delete/delete
// Params 1, eflags: 0x40
// Checksum 0x7eaf2b64, Offset: 0x68
// Size: 0x10c
function event_handler[delete] main(eventstruct) {
    assert(isdefined(self));
    waitframe(1);
    if (isdefined(self)) {
        /#
            if (isdefined(self.classname)) {
                if (self.classname == "<dev string:x30>" || self.classname == "<dev string:x3d>" || self.classname == "<dev string:x4c>") {
                    println("<dev string:x5d>");
                    println("<dev string:x5e>" + self getentitynumber() + "<dev string:x9c>" + self.origin);
                    println("<dev string:x5d>");
                }
            }
        #/
        self delete();
    }
}

