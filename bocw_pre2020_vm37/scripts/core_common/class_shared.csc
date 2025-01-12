#namespace class_shared;

// Namespace class_shared
// Method(s) 6 Total 6
class class_d0a0a887 {

    var _avail;
    var _used;

    // Namespace class_d0a0a887/class_shared
    // Params 0, eflags: 0x8
    // Checksum 0xda938912, Offset: 0x60
    // Size: 0x1a
    constructor() {
        _avail = [];
        _used = [];
    }

    // Namespace namespace_d0a0a887/class_shared
    // Params 1, eflags: 0x0
    // Checksum 0xc7e814b6, Offset: 0x248
    // Size: 0x74
    function function_271aec18(index) {
        assert(isdefined(_used[index]));
        _used[index] = undefined;
        assert(!isdefined(_avail[index]));
        _avail[index] = index;
    }

    // Namespace namespace_d0a0a887/class_shared
    // Params 1, eflags: 0x0
    // Checksum 0xede72013, Offset: 0x118
    // Size: 0x128
    function function_65cdd2df(owner) {
        index = undefined;
        foreach (key, value in _avail) {
            index = key;
            break;
        }
        if (isdefined(index)) {
            assert(!isdefined(_used[index]));
            if (isdefined(owner)) {
                _used[index] = owner;
            } else {
                _used[index] = index;
            }
            assert(isdefined(_avail[index]));
            _avail[index] = undefined;
        }
        return index;
    }

    // Namespace namespace_d0a0a887/class_shared
    // Params 0, eflags: 0x0
    // Checksum 0x5264c4a9, Offset: 0x2c8
    // Size: 0xa
    function function_85a5add5() {
        return _used;
    }

    // Namespace namespace_d0a0a887/class_shared
    // Params 1, eflags: 0x0
    // Checksum 0x743af6d4, Offset: 0x88
    // Size: 0x88
    function init(count) {
        assert(_avail.size == 0);
        assert(_used.size == 0);
        for (i = 0; i < count; i++) {
            _avail[i] = i;
        }
    }

}

