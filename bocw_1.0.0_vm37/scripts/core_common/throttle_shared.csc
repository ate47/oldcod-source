#namespace throttle;

// Namespace throttle
// Method(s) 9 Total 9
class throttle {

    var processed_;
    var processlimit_;
    var queue_;
    var updaterate_;
    var var_3cd6b18f;

    // Namespace throttle/throttle_shared
    // Params 0, eflags: 0x8
    // Checksum 0xcc7fc578, Offset: 0xb0
    // Size: 0x42
    constructor() {
        queue_ = [];
        processed_ = 0;
        processlimit_ = 1;
        var_3cd6b18f = [];
        updaterate_ = 0.05;
    }

    // Namespace throttle/throttle_shared
    // Params 1, eflags: 0x0
    // Checksum 0x8a9734a, Offset: 0x408
    // Size: 0x22
    function wm_ht_posidlestart(entity) {
        return isinarray(queue_, entity);
    }

    // Namespace throttle/throttle_shared
    // Params 1, eflags: 0x4
    // Checksum 0x2dc63c0d, Offset: 0x70
    // Size: 0x34
    function private _updatethrottlethread(throttle) {
        while (isdefined(throttle)) {
            [[ throttle ]]->_updatethrottle();
            wait throttle.updaterate_;
        }
    }

    // Namespace throttle/throttle_shared
    // Params 2, eflags: 0x0
    // Checksum 0xd000b8b8, Offset: 0x260
    // Size: 0x44
    function initialize(processlimit, updaterate) {
        processlimit_ = processlimit;
        updaterate_ = updaterate;
        self thread _updatethrottlethread(self);
    }

    // Namespace throttle/throttle_shared
    // Params 1, eflags: 0x0
    // Checksum 0x884f7d8e, Offset: 0x438
    // Size: 0x24
    function leavequeue(entity) {
        arrayremovevalue(queue_, entity);
    }

    // Namespace throttle/throttle_shared
    // Params 0, eflags: 0x4
    // Checksum 0xc5a84c40, Offset: 0x110
    // Size: 0x146
    function private _updatethrottle() {
        processed_ = 0;
        currentqueue = queue_;
        queue_ = [];
        foreach (item in currentqueue) {
            if (!isdefined(item)) {
                continue;
            }
            foreach (var_fe3b6341 in var_3cd6b18f) {
                if (item === var_fe3b6341) {
                    queue_[queue_.size] = item;
                    break;
                }
            }
        }
        var_3cd6b18f = [];
    }

    // Namespace throttle/throttle_shared
    // Params 1, eflags: 0x0
    // Checksum 0xe9c7f027, Offset: 0x2b0
    // Size: 0x150
    function waitinqueue(entity = randomint(2147483647)) {
        if (processed_ >= processlimit_) {
            nextqueueindex = queue_.size < 0 ? 0 : getlastarraykey(queue_) + 1;
            queue_[nextqueueindex] = entity;
            firstinqueue = 0;
            while (!firstinqueue) {
                if (!isdefined(entity)) {
                    return;
                }
                firstqueueindex = getfirstarraykey(queue_);
                if (processed_ < processlimit_ && queue_[firstqueueindex] === entity) {
                    firstinqueue = 1;
                    queue_[firstqueueindex] = undefined;
                    continue;
                }
                var_3cd6b18f[var_3cd6b18f.size] = entity;
                wait updaterate_;
            }
        }
        processed_++;
    }

    // Namespace throttle/throttle_shared
    // Params 1, eflags: 0x4
    // Checksum 0x1789fcb1, Offset: 0x640
    // Size: 0x34
    function private function_f629508d(throttle) {
        while (isdefined(throttle)) {
            [[ throttle ]]->function_eba90b67();
            wait throttle.updaterate_;
        }
    }

}

// Namespace throttle
// Method(s) 7 Total 7
class class_c6c0e94 {

    var processlimit_;
    var queue_;
    var updaterate_;
    var var_53070152;

    // Namespace class_c6c0e94/throttle_shared
    // Params 0, eflags: 0x8
    // Checksum 0x725e530e, Offset: 0x680
    // Size: 0x2a
    constructor() {
        queue_ = [];
        processlimit_ = 1;
        updaterate_ = 0.05;
    }

    // Namespace namespace_c6c0e94/throttle_shared
    // Params 1, eflags: 0x0
    // Checksum 0x54b92ad2, Offset: 0x8e8
    // Size: 0x22
    function wm_ht_posidlestart(entity) {
        return isinarray(queue_, entity);
    }

    // Namespace namespace_c6c0e94/throttle_shared
    // Params 3, eflags: 0x0
    // Checksum 0x630767ed, Offset: 0x7b8
    // Size: 0x64
    function initialize(name, processlimit, updaterate) {
        processlimit_ = processlimit;
        updaterate_ = updaterate;
        var_53070152 = name + "_wake_up";
        self thread throttle::function_f629508d(self);
    }

    // Namespace namespace_c6c0e94/throttle_shared
    // Params 1, eflags: 0x0
    // Checksum 0xbc127c66, Offset: 0x918
    // Size: 0x24
    function leavequeue(entity) {
        arrayremovevalue(queue_, entity);
    }

    // Namespace namespace_c6c0e94/throttle_shared
    // Params 1, eflags: 0x0
    // Checksum 0xa3948e8b, Offset: 0x828
    // Size: 0xb4
    function waitinqueue(entity) {
        if (!isdefined(entity)) {
            return;
        }
        if (!isentity(entity) && !isstruct(entity)) {
            return;
        }
        if (!isinarray(queue_, entity)) {
            queue_[queue_.size] = entity;
        }
        entity endon(#"death", #"delete");
        entity waittill(var_53070152);
    }

    // Namespace namespace_c6c0e94/throttle_shared
    // Params 0, eflags: 0x4
    // Checksum 0xea82aa3d, Offset: 0x6c8
    // Size: 0xe8
    function private function_eba90b67() {
        arrayremovevalue(queue_, undefined);
        processed = 0;
        foreach (item in queue_) {
            if (!isdefined(item)) {
                continue;
            }
            arrayremovevalue(queue_, item);
            item notify(var_53070152);
            processed++;
            if (processed >= processlimit_) {
                break;
            }
        }
    }

}

