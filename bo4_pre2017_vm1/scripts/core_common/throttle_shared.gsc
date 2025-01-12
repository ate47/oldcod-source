#namespace throttle;

// Namespace throttle
// Method(s) 6 Total 6
class throttle {

    var processed_;
    var processlimit_;
    var queue_;
    var updaterate_;

    // Namespace throttle/throttle_shared
    // Params 1, eflags: 0x0
    // Checksum 0xc78fbdf4, Offset: 0x270
    // Size: 0x13c
    function waitinqueue(entity) {
        if (processed_ >= processlimit_) {
            nextqueueindex = queue_.size > 0 ? getlastarraykey(queue_) + 1 : 0;
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
                wait updaterate_;
            }
        }
        processed_++;
    }

    // Namespace throttle/throttle_shared
    // Params 2, eflags: 0x0
    // Checksum 0x8d14da58, Offset: 0x1f0
    // Size: 0x74
    function initialize(processlimit, updaterate) {
        if (!isdefined(processlimit)) {
            processlimit = 1;
        }
        if (!isdefined(updaterate)) {
            updaterate = 0.05;
        }
        processlimit_ = processlimit;
        updaterate_ = updaterate;
        self thread _updatethrottlethread(self);
    }

    // Namespace throttle/throttle_shared
    // Params 0, eflags: 0x4
    // Checksum 0x67140f99, Offset: 0x120
    // Size: 0xc8
    function private _updatethrottle() {
        processed_ = 0;
        currentqueue = queue_;
        queue_ = [];
        foreach (item in currentqueue) {
            if (isdefined(item)) {
                queue_[queue_.size] = item;
            }
        }
    }

    // Namespace throttle/throttle_shared
    // Params 0, eflags: 0x0
    // Checksum 0x80f724d1, Offset: 0x110
    // Size: 0x4
    function __destructor() {
        
    }

    // Namespace throttle/throttle_shared
    // Params 0, eflags: 0x0
    // Checksum 0x963dabb9, Offset: 0xc8
    // Size: 0x3c
    function __constructor() {
        queue_ = [];
        processed_ = 0;
        processlimit_ = 1;
        updaterate_ = 0.05;
    }

    // Namespace throttle/throttle_shared
    // Params 1, eflags: 0x4
    // Checksum 0x3a0ebd63, Offset: 0x80
    // Size: 0x3c
    function private _updatethrottlethread(throttle) {
        while (isdefined(throttle)) {
            [[ throttle ]]->_updatethrottle();
            wait throttle.updaterate_;
        }
    }

}

