#namespace throttle;

// Namespace throttle
// Method(s) 6 Total 6
class throttle {

    var processed_;
    var processlimit_;
    var queue_;
    var updaterate_;
    var var_c448ec39;

    // Namespace throttle/throttle_shared
    // Params 0, eflags: 0x8
    // Checksum 0xd97b8632, Offset: 0xa8
    // Size: 0x66
    constructor() {
        queue_ = [];
        processed_ = 0;
        processlimit_ = 1;
        var_c448ec39 = [];
        updaterate_ = float(function_f9f48566()) / 1000;
    }

    // Namespace throttle/throttle_shared
    // Params 1, eflags: 0x0
    // Checksum 0x2e104a5b, Offset: 0x308
    // Size: 0x154
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
                var_c448ec39[var_c448ec39.size] = entity;
                wait updaterate_;
            }
        }
        processed_++;
    }

    // Namespace throttle/throttle_shared
    // Params 2, eflags: 0x0
    // Checksum 0xb2bc9e3c, Offset: 0x268
    // Size: 0x94
    function initialize(processlimit = 1, updaterate = float(function_f9f48566()) / 1000) {
        processlimit_ = processlimit;
        updaterate_ = updaterate;
        self thread _updatethrottlethread(self);
    }

    // Namespace throttle/throttle_shared
    // Params 0, eflags: 0x4
    // Checksum 0xe23a7da2, Offset: 0x128
    // Size: 0x132
    function private _updatethrottle() {
        processed_ = 0;
        currentqueue = queue_;
        queue_ = [];
        foreach (item in currentqueue) {
            if (!isdefined(item)) {
                continue;
            }
            foreach (var_b3a1c10a in var_c448ec39) {
                if (item === var_b3a1c10a) {
                    queue_[queue_.size] = item;
                    break;
                }
            }
        }
        var_c448ec39 = [];
    }

    // Namespace throttle/throttle_shared
    // Params 1, eflags: 0x4
    // Checksum 0xb66079d8, Offset: 0x68
    // Size: 0x34
    function private _updatethrottlethread(throttle) {
        while (isdefined(throttle)) {
            [[ throttle ]]->_updatethrottle();
            wait throttle.updaterate_;
        }
    }

}

