#namespace tracking;

// Namespace tracking/tracking
// Params 0, eflags: 0x4
// Checksum 0xd86036e1, Offset: 0x68
// Size: 0x26
function private function_7af8a60b() {
    if (!isalive(self)) {
        return false;
    }
    return true;
}

// Namespace tracking/tracking
// Params 0, eflags: 0x4
// Checksum 0xd4c36a31, Offset: 0x98
// Size: 0xde
function private function_553c93dd() {
    if (function_7af8a60b()) {
        if (level.time >= self.tracking.breadcrumbs[self.tracking.current_crumb].time + self.tracking.time_step) {
            return;
        }
        self.tracking.current_crumb = (self.tracking.current_crumb + 1) % 20;
        self.tracking.breadcrumbs[self.tracking.current_crumb] = {#point:self.origin, #time:level.time};
    }
}

// Namespace tracking/tracking
// Params 1, eflags: 0x0
// Checksum 0xa0cdd6c1, Offset: 0x180
// Size: 0x192
function init_tracking(window) {
    self.tracking = {#breadcrumbs:[], #current_crumb:0, #var_7b78073c:0, #velocity:(0, 0, 0), #speed:0, #window:window, #time_step:int(window * 1000) / 20};
    crumb = {#point:self.origin, #time:level.time};
    if (!isdefined(self.tracking.breadcrumbs)) {
        self.tracking.breadcrumbs = [];
    } else if (!isarray(self.tracking.breadcrumbs)) {
        self.tracking.breadcrumbs = array(self.tracking.breadcrumbs);
    }
    self.tracking.breadcrumbs[self.tracking.breadcrumbs.size] = crumb;
}

// Namespace tracking/tracking
// Params 0, eflags: 0x4
// Checksum 0xe3a3dad7, Offset: 0x320
// Size: 0x3e
function private track_points() {
    self endon(#"disconnect");
    while (true) {
        self function_553c93dd();
        waitframe(1);
    }
}

// Namespace tracking/tracking
// Params 1, eflags: 0x0
// Checksum 0x380cf7c5, Offset: 0x368
// Size: 0x4c
function track(window) {
    if (isdefined(self.tracking)) {
        return;
    }
    self init_tracking(window);
    self thread track_points();
}

// Namespace tracking/tracking
// Params 0, eflags: 0x0
// Checksum 0x191caa9, Offset: 0x3c0
// Size: 0x236
function get_velocity() {
    if (level.time == self.tracking.var_7b78073c) {
        return self.tracking.velocity;
    }
    crumb_index = self.tracking.current_crumb % 20;
    crumb = self.tracking.breadcrumbs[crumb_index];
    last_point = crumb.point;
    last_time = crumb.time;
    travel = (0, 0, 0);
    total_time = 0;
    breadcrumb_count = self.tracking.breadcrumbs.size;
    for (index = breadcrumb_count - 2; index >= 0; index--) {
        crumb_index--;
        if (crumb_index < 0) {
            crumb_index += breadcrumb_count;
        }
        crumb = self.tracking.breadcrumbs[crumb_index];
        travel += last_point - crumb.point;
        total_time += last_time - crumb.time;
        last_point = crumb.point;
        last_time = crumb.time;
    }
    if (total_time > 0) {
        self.tracking.velocity = travel / float(total_time) / 1000;
        self.tracking.speed = length(travel) / float(total_time) / 1000;
    }
    self.tracking.var_7b78073c = level.time;
    return self.tracking.velocity;
}

/#

    // Namespace tracking/tracking
    // Params 0, eflags: 0x0
    // Checksum 0x1c2d38b6, Offset: 0x600
    // Size: 0x8e
    function debug_tracking() {
        self endon(#"disconnect");
        while (true) {
            if (function_7af8a60b()) {
                velocity = self get_velocity();
                sphere(self.origin + velocity, 10, (1, 0, 0), 1, 0);
            }
            waitframe(1);
        }
    }

#/
