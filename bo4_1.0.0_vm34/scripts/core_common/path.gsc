#namespace path;

/#

    // Namespace path/path
    // Params 5, eflags: 0x4
    // Checksum 0xd577d939, Offset: 0x68
    // Size: 0x158
    function private function_b1a3bbcd(path, var_23669902, point_color, line_color, var_c65cfc3b) {
        assert(isdefined(path));
        for (i = 0; i < path.size; i++) {
            if (isdefined(path[i + 1])) {
                direction = vectornormalize(path[i + 1] - path[i]);
                radius = distance(path[i], path[i + 1]) / 2;
                center = path[i] + vectorscale(direction, radius);
                [[ var_23669902 ]](path[i], path[i + 1], center, radius, point_color, line_color, var_c65cfc3b);
            }
        }
    }

    // Namespace path/path
    // Params 7, eflags: 0x4
    // Checksum 0x448e18d7, Offset: 0x1c8
    // Size: 0xb4
    function private function_3b21275a(path_1, path_2, center, radius, point_color, line_color, var_c65cfc3b) {
        recordline(path_1, path_2, line_color, "<dev string:x30>");
        recordsphere(path_1, 2, point_color, "<dev string:x30>");
        recordcircle(center, radius, var_c65cfc3b, "<dev string:x30>");
    }

    // Namespace path/path
    // Params 7, eflags: 0x4
    // Checksum 0xcbb378e6, Offset: 0x288
    // Size: 0xb4
    function private function_91ca7513(path_1, path_2, center, radius, point_color, line_color, var_c65cfc3b) {
        line(path_1, path_2, point_color, 1, 1);
        sphere(path_1, 5, line_color, 1, 1);
        circle(center, radius, var_c65cfc3b, 0, 1, 1);
    }

    // Namespace path/path
    // Params 4, eflags: 0x0
    // Checksum 0xf286dfca, Offset: 0x348
    // Size: 0x8c
    function function_2d83a00(path_points, point_color, line_color, var_c65cfc3b) {
        if (!isdefined(point_color)) {
            point_color = (0, 0, 1);
        }
        if (!isdefined(line_color)) {
            line_color = (0, 1, 0);
        }
        if (!isdefined(var_c65cfc3b)) {
            var_c65cfc3b = (1, 0.5, 0);
        }
        function_b1a3bbcd(path_points, &function_3b21275a, point_color, line_color, var_c65cfc3b);
    }

    // Namespace path/path
    // Params 4, eflags: 0x0
    // Checksum 0xe1115f75, Offset: 0x3e0
    // Size: 0x8c
    function function_7e36a15b(path_points, point_color, line_color, var_c65cfc3b) {
        if (!isdefined(point_color)) {
            point_color = (0, 0, 1);
        }
        if (!isdefined(line_color)) {
            line_color = (0, 1, 0);
        }
        if (!isdefined(var_c65cfc3b)) {
            var_c65cfc3b = (1, 0.5, 0);
        }
        function_b1a3bbcd(path_points, &function_91ca7513, point_color, line_color, var_c65cfc3b);
    }

#/
