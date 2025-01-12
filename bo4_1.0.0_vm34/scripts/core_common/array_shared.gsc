#using scripts\core_common\flag_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;

#namespace array;

// Namespace array/array_shared
// Params 4, eflags: 0x20 variadic
// Checksum 0x6da6dd60, Offset: 0x98
// Size: 0x196
function filter(&array, b_keep_keys, func_filter, ...) {
    a_new = [];
    foreach (key, val in array) {
        a_args = arraycombine(array(val), vararg, 1, 0);
        if (util::single_func_argarray(undefined, func_filter, a_args)) {
            if (isstring(key) || isweapon(key)) {
                if (isdefined(b_keep_keys) && !b_keep_keys) {
                    a_new[a_new.size] = val;
                } else {
                    a_new[key] = val;
                }
                continue;
            }
            if (isdefined(b_keep_keys) && b_keep_keys) {
                a_new[key] = val;
                continue;
            }
            a_new[a_new.size] = val;
        }
    }
    return a_new;
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0x790a927d, Offset: 0x238
// Size: 0x30
function remove_undefined(&array, b_keep_keys) {
    arrayremovevalue(array, undefined, b_keep_keys);
    return array;
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0x811287f, Offset: 0x270
// Size: 0x30
function remove_dead(&array, b_keep_keys) {
    function_526005d6(array, b_keep_keys);
    return array;
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0x68570593, Offset: 0x2a8
// Size: 0x42
function filter_classname(&array, b_keep_keys, str_classname) {
    return filter(array, b_keep_keys, &_filter_classname, str_classname);
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0x7c8d20ea, Offset: 0x2f8
// Size: 0x42
function function_b0432d33(&array, b_keep_keys, str_classname) {
    return filter(array, b_keep_keys, &function_3274b192, str_classname);
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0x46942086, Offset: 0x348
// Size: 0x3a
function get_touching(&array, b_keep_keys) {
    return filter(array, b_keep_keys, &istouching);
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0x3e6ad2d0, Offset: 0x390
// Size: 0xda
function remove_index(array, index, b_keep_keys) {
    a_new = [];
    foreach (key, val in array) {
        if (key == index) {
            continue;
        }
        if (isdefined(b_keep_keys) && b_keep_keys) {
            a_new[key] = val;
            continue;
        }
        a_new[a_new.size] = val;
    }
    return a_new;
}

// Namespace array/array_shared
// Params 1, eflags: 0x0
// Checksum 0x7f3630d1, Offset: 0x478
// Size: 0xf0
function delete_all(&array) {
    foreach (ent in array) {
        if (isdefined(ent)) {
            if (isstruct(ent)) {
                ent struct::delete();
                continue;
            }
            if (isdefined(ent.__vtable)) {
                ent._deleted = 1;
                ent notify(#"death");
                ent = undefined;
                continue;
            }
            ent delete();
        }
    }
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0x43306464, Offset: 0x570
// Size: 0x7c
function notify_all(&array, str_notify) {
    foreach (elem in array) {
        elem notify(str_notify);
    }
}

// Namespace array/array_shared
// Params 8, eflags: 0x0
// Checksum 0x231e8ac1, Offset: 0x5f8
// Size: 0x164
function thread_all(&entities, func, arg1, arg2, arg3, arg4, arg5, arg6) {
    assert(isdefined(entities), "<dev string:x30>");
    assert(isdefined(func), "<dev string:x63>");
    if (isarray(entities)) {
        foreach (ent in entities) {
            util::single_thread(ent, func, arg1, arg2, arg3, arg4, arg5, arg6);
        }
        return;
    }
    util::single_thread(entities, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

// Namespace array/array_shared
// Params 7, eflags: 0x0
// Checksum 0xdba24a87, Offset: 0x768
// Size: 0x154
function thread_all_ents(&entities, func, arg1, arg2, arg3, arg4, arg5) {
    assert(isdefined(entities), "<dev string:x92>");
    assert(isdefined(func), "<dev string:xca>");
    if (isarray(entities)) {
        foreach (v in entities) {
            util::single_thread(self, func, v, arg1, arg2, arg3, arg4, arg5);
        }
        return;
    }
    util::single_thread(self, func, entities, arg1, arg2, arg3, arg4, arg5);
}

// Namespace array/array_shared
// Params 8, eflags: 0x0
// Checksum 0x508ba1c, Offset: 0x8c8
// Size: 0x164
function run_all(&entities, func, arg1, arg2, arg3, arg4, arg5, arg6) {
    assert(isdefined(entities), "<dev string:xfe>");
    assert(isdefined(func), "<dev string:x12e>");
    if (isarray(entities)) {
        foreach (ent in entities) {
            util::single_func(ent, func, arg1, arg2, arg3, arg4, arg5, arg6);
        }
        return;
    }
    util::single_func(entities, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0xc57f4da9, Offset: 0xa38
// Size: 0xd8
function exclude(array, array_exclude) {
    newarray = array;
    if (isarray(array_exclude)) {
        foreach (exclude_item in array_exclude) {
            arrayremovevalue(newarray, exclude_item);
        }
    } else {
        arrayremovevalue(newarray, array_exclude);
    }
    return newarray;
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0x95538a3d, Offset: 0xb18
// Size: 0x6c
function add(&array, item, allow_dupes = 1) {
    if (isdefined(item)) {
        if (allow_dupes || !isinarray(array, item)) {
            array[array.size] = item;
        }
    }
}

// Namespace array/array_shared
// Params 5, eflags: 0x0
// Checksum 0x384f071, Offset: 0xb90
// Size: 0x132
function add_sorted(&array, item, allow_dupes = 1, func_compare, var_9917772f = 0) {
    if (isdefined(item)) {
        if (allow_dupes || !isinarray(array, item)) {
            for (i = 0; i <= array.size; i++) {
                if (i == array.size || isdefined(func_compare) && ([[ func_compare ]](item, array[i]) || var_9917772f) || !isdefined(func_compare) && (item <= array[i] || var_9917772f)) {
                    arrayinsert(array, item, i);
                    break;
                }
            }
        }
    }
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0xdec43e54, Offset: 0xcd0
// Size: 0x154
function wait_till(&array, notifies, n_timeout) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    s_tracker = spawnstruct();
    s_tracker._wait_count = 0;
    foreach (ent in array) {
        if (isdefined(ent)) {
            ent thread util::timeout(n_timeout, &util::_waitlogic, s_tracker, notifies);
        }
    }
    if (s_tracker._wait_count > 0) {
        s_tracker waittill(#"waitlogic_finished");
    }
}

// Namespace array/array_shared
// Params 4, eflags: 0x0
// Checksum 0x4b18d2b6, Offset: 0xe30
// Size: 0x194
function wait_till_match(&array, str_notify, str_match, n_timeout) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    s_tracker = spawnstruct();
    s_tracker._array_wait_count = 0;
    foreach (ent in array) {
        if (isdefined(ent)) {
            s_tracker._array_wait_count++;
            ent thread util::timeout(n_timeout, &_waitlogic_match, s_tracker, str_notify, str_match);
            ent thread util::timeout(n_timeout, &_waitlogic_death, s_tracker);
        }
    }
    if (s_tracker._array_wait_count > 0) {
        s_tracker waittill(#"array_wait");
    }
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0x945799be, Offset: 0xfd0
// Size: 0x54
function _waitlogic_match(s_tracker, str_notify, str_match) {
    self endon(#"death");
    self waittillmatch(str_match, str_notify);
    update_waitlogic_tracker(s_tracker);
}

// Namespace array/array_shared
// Params 1, eflags: 0x0
// Checksum 0x6a9f8c96, Offset: 0x1030
// Size: 0x34
function _waitlogic_death(s_tracker) {
    self waittill(#"death");
    update_waitlogic_tracker(s_tracker);
}

// Namespace array/array_shared
// Params 1, eflags: 0x0
// Checksum 0x51d4631d, Offset: 0x1070
// Size: 0x40
function update_waitlogic_tracker(s_tracker) {
    s_tracker._array_wait_count--;
    if (s_tracker._array_wait_count == 0) {
        s_tracker notify(#"array_wait");
    }
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0xd64a1c8c, Offset: 0x10b8
// Size: 0x9e
function flag_wait(&array, str_flag) {
    for (i = 0; i < array.size; i++) {
        ent = array[i];
        if (isdefined(ent) && !ent flag::get(str_flag)) {
            ent util::waittill_either("death", str_flag);
            i = -1;
        }
    }
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0x18da0611, Offset: 0x1160
// Size: 0x9e
function flagsys_wait(&array, str_flag) {
    for (i = 0; i < array.size; i++) {
        ent = array[i];
        if (isdefined(ent) && !ent flagsys::get(str_flag)) {
            ent util::waittill_either("death", str_flag);
            i = -1;
        }
    }
}

// Namespace array/array_shared
// Params 2, eflags: 0x20 variadic
// Checksum 0xc1d7da4e, Offset: 0x1208
// Size: 0x106
function flagsys_wait_any_flag(&array, ...) {
    for (i = 0; i < array.size; i++) {
        ent = array[i];
        if (isdefined(ent)) {
            b_flag_set = 0;
            foreach (str_flag in vararg) {
                if (ent flagsys::get(str_flag)) {
                    b_flag_set = 1;
                    break;
                }
            }
            if (!b_flag_set) {
                ent waittill(vararg);
                i = -1;
            }
        }
    }
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0xf91bbbc1, Offset: 0x1318
// Size: 0xac
function flagsys_wait_any(&array, str_flag) {
    foreach (ent in array) {
        if (ent flagsys::get(str_flag)) {
            return ent;
        }
    }
    wait_any(array, str_flag);
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0xd4c42d39, Offset: 0x13d0
// Size: 0x7e
function flag_wait_clear(&array, str_flag) {
    for (i = 0; i < array.size; i++) {
        ent = array[i];
        if (ent flag::get(str_flag)) {
            ent waittill(str_flag);
            i = -1;
        }
    }
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0x1865de0, Offset: 0x1458
// Size: 0xf6
function flagsys_wait_clear(&array, str_flag, n_timeout) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    for (i = 0; i < array.size; i++) {
        ent = array[i];
        if (isdefined(ent) && ent flagsys::get(str_flag)) {
            ent util::waittill_either("death", str_flag);
            i = -1;
        }
    }
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0x8aa7a6e6, Offset: 0x1558
// Size: 0x154
function wait_any(array, msg, n_timeout) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    s_tracker = spawnstruct();
    foreach (ent in array) {
        if (isdefined(ent)) {
            level thread util::timeout(n_timeout, &_waitlogic2, s_tracker, ent, msg);
        }
    }
    s_tracker endon(#"array_wait");
    wait_till(array, "death");
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0x53b4ad74, Offset: 0x16b8
// Size: 0x80
function _waitlogic2(s_tracker, ent, msg) {
    s_tracker endon(#"array_wait");
    if (msg != "death") {
        ent endon(#"death");
    }
    ent waittill(msg);
    s_tracker notify(#"array_wait");
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0x498d154d, Offset: 0x1740
// Size: 0xc4
function flag_wait_any(array, str_flag) {
    self endon(#"death");
    foreach (ent in array) {
        if (ent flag::get(str_flag)) {
            return ent;
        }
    }
    wait_any(array, str_flag);
}

// Namespace array/array_shared
// Params 1, eflags: 0x0
// Checksum 0xcdfa95b6, Offset: 0x1810
// Size: 0x58
function random(array) {
    if (array.size > 0) {
        keys = getarraykeys(array);
        return array[keys[randomint(keys.size)]];
    }
}

// Namespace array/array_shared
// Params 1, eflags: 0x0
// Checksum 0x8afc1983, Offset: 0x1870
// Size: 0x90
function randomize(array) {
    for (i = 0; i < array.size; i++) {
        j = randomint(array.size);
        temp = array[i];
        array[i] = array[j];
        array[j] = temp;
    }
    return array;
}

// Namespace array/array_shared
// Params 1, eflags: 0x0
// Checksum 0xc1a14b, Offset: 0x1908
// Size: 0x64
function reverse(array) {
    a_array2 = [];
    for (i = array.size - 1; i >= 0; i--) {
        a_array2[a_array2.size] = array[i];
    }
    return a_array2;
}

// Namespace array/array_shared
// Params 1, eflags: 0x0
// Checksum 0xad6a0688, Offset: 0x1978
// Size: 0x96
function remove_keys(array) {
    a_new = [];
    foreach (val in array) {
        if (isdefined(val)) {
            a_new[a_new.size] = val;
        }
    }
    return a_new;
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0x7fdf4df7, Offset: 0x1a18
// Size: 0xa8
function swap(&array, index1, index2) {
    assert(index1 < array.size, "<dev string:x15a>");
    assert(index2 < array.size, "<dev string:x176>");
    temp = array[index1];
    array[index1] = array[index2];
    array[index2] = temp;
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0x9b0a6951, Offset: 0x1ac8
// Size: 0xa2
function pop(&array, index, b_keep_keys = 1) {
    if (array.size > 0) {
        if (!isdefined(index)) {
            index = getlastarraykey(array);
        }
        if (isdefined(array[index])) {
            ret = array[index];
            arrayremoveindex(array, index, b_keep_keys);
            return ret;
        }
    }
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0xd65e3878, Offset: 0x1b78
// Size: 0x62
function pop_front(&array, b_keep_keys = 1) {
    index = getfirstarraykey(array);
    return pop(array, index, b_keep_keys);
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0xbe375156, Offset: 0x1be8
// Size: 0x54
function push(&array, val, index = array.size + 1) {
    arrayinsert(array, val, index);
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0x1070e821, Offset: 0x1c48
// Size: 0x34
function push_front(&array, val) {
    push(array, val, 0);
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0xb9ee7226, Offset: 0x1c88
// Size: 0x9c
function replace(array, value, replacement) {
    foreach (i, val in array) {
        if (val === value) {
            array[i] = replacement;
        }
    }
    return array;
}

// Namespace array/array_shared
// Params 2, eflags: 0x4
// Checksum 0xa71b8441, Offset: 0x1d30
// Size: 0x1e
function private function_7fe1a364(a, b) {
    return a === b;
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0x79d5ef68, Offset: 0x1d58
// Size: 0x7c
function find(&array, ent, func_compare = &function_7fe1a364) {
    for (i = 0; i < array.size; i++) {
        if ([[ func_compare ]](array[i], ent)) {
            return i;
        }
    }
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0x2f208b61, Offset: 0x1de0
// Size: 0x1e
function closerfunc(dist1, dist2) {
    return dist1 >= dist2;
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0xa931a298, Offset: 0x1e08
// Size: 0x1e
function fartherfunc(dist1, dist2) {
    return dist1 <= dist2;
}

// Namespace array/array_shared
// Params 5, eflags: 0x0
// Checksum 0x3c1b94cc, Offset: 0x1e30
// Size: 0xba
function get_all_farthest(org, &array, a_exclude, n_max = array.size, n_maxdist) {
    a_ret = exclude(array, a_exclude);
    if (isdefined(n_maxdist)) {
        a_ret = arraysort(a_ret, org, 0, n_max, n_maxdist);
    } else {
        a_ret = arraysort(a_ret, org, 0, n_max);
    }
    return a_ret;
}

// Namespace array/array_shared
// Params 5, eflags: 0x0
// Checksum 0x2c07e1b0, Offset: 0x1ef8
// Size: 0xba
function get_all_closest(org, &array, a_exclude, n_max = array.size, n_maxdist) {
    a_ret = exclude(array, a_exclude);
    if (isdefined(n_maxdist)) {
        a_ret = arraysort(a_ret, org, 1, n_max, n_maxdist);
    } else {
        a_ret = arraysort(a_ret, org, 1, n_max);
    }
    return a_ret;
}

// Namespace array/array_shared
// Params 1, eflags: 0x0
// Checksum 0x357d573e, Offset: 0x1fc0
// Size: 0x22
function alphabetize(&array) {
    return sort_by_value(array, 1);
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0x9f4ca607, Offset: 0x1ff0
// Size: 0x42
function sort_by_value(&array, b_lowest_first = 0) {
    return merge_sort(array, &_compare_value, b_lowest_first);
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0x6c42bb5c, Offset: 0x2040
// Size: 0x42
function sort_by_script_int(&a_ents, b_lowest_first = 0) {
    return merge_sort(a_ents, &_compare_script_int, b_lowest_first);
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0x95699623, Offset: 0x2090
// Size: 0x1ba
function merge_sort(&current_list, func_sort, param) {
    if (current_list.size <= 1) {
        return current_list;
    }
    left = [];
    right = [];
    middle = current_list.size / 2;
    for (x = 0; x < middle; x++) {
        if (!isdefined(left)) {
            left = [];
        } else if (!isarray(left)) {
            left = array(left);
        }
        left[left.size] = current_list[x];
    }
    while (x < current_list.size) {
        if (!isdefined(right)) {
            right = [];
        } else if (!isarray(right)) {
            right = array(right);
        }
        right[right.size] = current_list[x];
        x++;
    }
    left = merge_sort(left, func_sort, param);
    right = merge_sort(right, func_sort, param);
    result = merge(left, right, func_sort, param);
    return result;
}

// Namespace array/array_shared
// Params 4, eflags: 0x0
// Checksum 0xc099d1bc, Offset: 0x2258
// Size: 0x17e
function merge(left, right, func_sort, param) {
    result = [];
    li = 0;
    for (ri = 0; li < left.size && ri < right.size; ri++) {
        b_result = undefined;
        if (isdefined(param)) {
            b_result = [[ func_sort ]](left[li], right[ri], param);
        } else {
            b_result = [[ func_sort ]](left[li], right[ri]);
        }
        if (b_result) {
            result[result.size] = left[li];
            li++;
            continue;
        }
        result[result.size] = right[ri];
    }
    while (li < left.size) {
        result[result.size] = left[li];
        li++;
    }
    while (ri < right.size) {
        result[result.size] = right[ri];
        ri++;
    }
    return result;
}

// Namespace array/array_shared
// Params 7, eflags: 0x0
// Checksum 0xced82265, Offset: 0x23e0
// Size: 0x19c
function spread_all(&entities, func, arg1, arg2, arg3, arg4, arg5) {
    assert(isdefined(entities), "<dev string:x192>");
    assert(isdefined(func), "<dev string:x1ca>");
    if (isarray(entities)) {
        foreach (ent in entities) {
            if (isdefined(ent)) {
                util::single_thread(ent, func, arg1, arg2, arg3, arg4, arg5);
            }
            wait randomfloatrange(0.0666667, 0.133333);
        }
        return;
    }
    util::single_thread(entities, func, arg1, arg2, arg3, arg4, arg5);
    wait randomfloatrange(0.0666667, 0.133333);
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0xe7ab1a2b, Offset: 0x2588
// Size: 0x38
function wait_till_touching(&a_ents, e_volume) {
    while (!is_touching(a_ents, e_volume)) {
        waitframe(1);
    }
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0x38652555, Offset: 0x25c8
// Size: 0x92
function is_touching(&a_ents, e_volume) {
    foreach (e_ent in a_ents) {
        if (!e_ent istouching(e_volume)) {
            return false;
        }
    }
    return true;
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0xa8e5dd28, Offset: 0x2668
// Size: 0xae
function contains(array_or_val, value) {
    if (isarray(array_or_val)) {
        foreach (element in array_or_val) {
            if (element === value) {
                return true;
            }
        }
        return false;
    }
    return array_or_val === value;
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0xaf6b7cad, Offset: 0x2720
// Size: 0xde
function function_c4488d38(array1, array2) {
    if (!isarray(array1) || !isarray(array2)) {
        return false;
    }
    if (array1.size != array2.size) {
        return false;
    }
    foreach (key, v in array1) {
        if (v !== array2[key]) {
            return false;
        }
    }
    return true;
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0x61eba714, Offset: 0x2808
// Size: 0x3a
function quick_sort(array, compare_func) {
    return quick_sort_mid(array, 0, array.size - 1, compare_func);
}

// Namespace array/array_shared
// Params 4, eflags: 0x0
// Checksum 0x79e49326, Offset: 0x2850
// Size: 0x1c4
function quick_sort_mid(array, start, end, compare_func) {
    i = start;
    k = end;
    if (!isdefined(compare_func)) {
        compare_func = &_compare_value;
    }
    if (end - start >= 1) {
        pivot = array[start];
        while (k > i) {
            while ([[ compare_func ]](array[i], pivot) && i <= end && k > i) {
                i++;
            }
            while (![[ compare_func ]](array[k], pivot) && k >= start && k >= i) {
                k--;
            }
            if (k > i) {
                swap(array, i, k);
            }
        }
        swap(array, start, k);
        array = quick_sort_mid(array, start, k - 1, compare_func);
        array = quick_sort_mid(array, k + 1, end, compare_func);
    } else {
        return array;
    }
    return array;
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0xc1ad71e4, Offset: 0x2a20
// Size: 0x50
function _compare_value(val1, val2, b_lowest_first = 1) {
    if (b_lowest_first) {
        return (val1 <= val2);
    }
    return val1 > val2;
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0xfb60e2f, Offset: 0x2a78
// Size: 0x6e
function _compare_script_int(e1, e2, b_lowest_first = 1) {
    if (b_lowest_first) {
        return (e1.script_int <= e2.script_int);
    }
    return e1.script_int > e2.script_int;
}

// Namespace array/array_shared
// Params 1, eflags: 0x0
// Checksum 0x521ef796, Offset: 0x2af0
// Size: 0x10
function _filter_undefined(val) {
    return isdefined(val);
}

// Namespace array/array_shared
// Params 1, eflags: 0x0
// Checksum 0xb6d73002, Offset: 0x2b08
// Size: 0x22
function _filter_dead(val) {
    return isalive(val);
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0x2380970, Offset: 0x2b38
// Size: 0x44
function _filter_classname(val, arg) {
    return isdefined(val.classname) && issubstr(val.classname, arg);
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0xa440c0fd, Offset: 0x2b88
// Size: 0x46
function function_3274b192(val, arg) {
    return !(isdefined(val.classname) && issubstr(val.classname, arg));
}

