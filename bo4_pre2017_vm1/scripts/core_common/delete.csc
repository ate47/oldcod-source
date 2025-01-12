#namespace delete;

// Namespace delete/delete
// Params 1, eflags: 0x40
// Checksum 0x235a8b83, Offset: 0x78
// Size: 0x11c
function event_handler[delete] main(eventstruct) {
    /#
        assert(isdefined(self));
    #/
    waitframe(1);
    if (isdefined(self)) {
        /#
            if (isdefined(self.classname)) {
                if (self.classname == "<dev string:x28>" || self.classname == "<dev string:x35>" || self.classname == "<dev string:x44>") {
                    println("<dev string:x55>");
                    println("<dev string:x56>" + self getentitynumber() + "<dev string:x94>" + self.origin);
                    println("<dev string:x55>");
                }
            }
        #/
        self delete();
    }
}

