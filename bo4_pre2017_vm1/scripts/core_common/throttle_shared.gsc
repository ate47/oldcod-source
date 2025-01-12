#namespace throttle;

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

// Namespace throttle/throttle_shared
// Params 0, eflags: 0x0
// Checksum 0x963dabb9, Offset: 0xc8
// Size: 0x3c
function __constructor() {
    self.queue_ = [];
    self.processed_ = 0;
    self.processlimit_ = 1;
    self.updaterate_ = 0.05;
}

// Namespace throttle/throttle_shared
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x110
// Size: 0x4
function __destructor() {
    
}

// Namespace throttle/throttle_shared
// Params 0, eflags: 0x4
// Checksum 0x67140f99, Offset: 0x120
// Size: 0xc8
function private _updatethrottle() {
    self.processed_ = 0;
    currentqueue = self.queue_;
    self.queue_ = [];
    foreach (item in currentqueue) {
        if (isdefined(item)) {
            self.queue_[self.queue_.size] = item;
        }
    }
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
    self.processlimit_ = processlimit;
    self.updaterate_ = updaterate;
    self thread _updatethrottlethread(self);
}

// Namespace throttle/throttle_shared
// Params 1, eflags: 0x0
// Checksum 0xc78fbdf4, Offset: 0x270
// Size: 0x13c
function waitinqueue(entity) {
    if (self.processed_ >= self.processlimit_) {
        nextqueueindex = self.queue_.size > 0 ? getlastarraykey(self.queue_) + 1 : 0;
        self.queue_[nextqueueindex] = entity;
        firstinqueue = 0;
        while (!firstinqueue) {
            if (!isdefined(entity)) {
                return;
            }
            firstqueueindex = getfirstarraykey(self.queue_);
            if (self.processed_ < self.processlimit_ && self.queue_[firstqueueindex] === entity) {
                firstinqueue = 1;
                self.queue_[firstqueueindex] = undefined;
                continue;
            }
            wait self.updaterate_;
        }
    }
    self.processed_++;
}

// Namespace throttle/throttle_shared
// Params 0, eflags: 0x6
// Checksum 0xba458f95, Offset: 0x3b8
// Size: 0x146
function private autoexec throttle() {
    classes.throttle[0] = spawnstruct();
    classes.throttle[0].__vtable[1123417372] = &waitinqueue;
    classes.throttle[0].__vtable[-422924033] = &initialize;
    classes.throttle[0].__vtable[-1487653173] = &_updatethrottle;
    classes.throttle[0].__vtable[1606033458] = &__destructor;
    classes.throttle[0].__vtable[-1690805083] = &__constructor;
    classes.throttle[0].__vtable[-758537977] = &_updatethrottlethread;
}

