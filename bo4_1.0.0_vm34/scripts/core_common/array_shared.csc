#using scripts\core_common\flag_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;

#namespace array;

// Namespace array/array_shared
// Params 4, eflags: 0x20 variadic
// Checksum 0xb57b8bf8, Offset: 0x98
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
// Checksum 0xbc59cc71, Offset: 0x238
// Size: 0x3a
function remove_undefined(&array, b_keep_keys) {
    return filter(array, b_keep_keys, &_filter_undefined);
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0xe4cde1f1, Offset: 0x280
// Size: 0x3a
function remove_dead(&array, b_keep_keys) {
    return filter(array, b_keep_keys, &_filter_dead);
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0xca6a50f4, Offset: 0x2c8
// Size: 0x42
function filter_classname(&array, b_keep_keys, str_classname) {
    return filter(array, b_keep_keys, &_filter_classname, str_classname);
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0x459faecb, Offset: 0x318
// Size: 0x42
function function_b0432d33(&array, b_keep_keys, str_classname) {
    return filter(array, b_keep_keys, &function_3274b192, str_classname);
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0xb60ef45d, Offset: 0x368
// Size: 0x3a
function get_touching(&array, b_keep_keys) {
    return filter(array, b_keep_keys, &istouching);
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0x3ef2603, Offset: 0x3b0
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
// Params 2, eflags: 0x0
// Checksum 0x5ae79061, Offset: 0x498
// Size: 0xf0
function delete_all(&array, is_struct) {
    foreach (ent in array) {
        if (isdefined(ent)) {
            if (isdefined(is_struct) && is_struct) {
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
// Checksum 0x6e40bc0d, Offset: 0x590
// Size: 0x7c
function notify_all(&array, str_notify) {
    foreach (elem in array) {
        elem notify(str_notify);
    }
}

// Namespace array/array_shared
// Params 8, eflags: 0x0
// Checksum 0x2ee6595f, Offset: 0x618
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
// Checksum 0xb95d1f3e, Offset: 0x788
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
// Checksum 0x5636ed1c, Offset: 0x8e8
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
// Checksum 0xdb774a1e, Offset: 0xa58
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
// Checksum 0xe55101a5, Offset: 0xb38
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
// Checksum 0xb7e5f08f, Offset: 0xbb0
// Size: 0x122
function add_sorted(&array, item, allow_dupes = 1, func_compare, var_9917772f = 0) {
    if (isdefined(item)) {
        if (allow_dupes || !isinarray(array, item)) {
            for (i = 0; i <= array.size; i++) {
                if (i == array.size || isdefined(func_compare) && ([[ func_compare ]](item, array[i]) || var_9917772f) || item <= array[i] || var_9917772f) {
                    arrayinsert(array, item, i);
                    break;
                }
            }
        }
    }
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0xe73c19f5, Offset: 0xce0
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
// Checksum 0x2c077e51, Offset: 0xe40
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
// Checksum 0x293d64dd, Offset: 0xfe0
// Size: 0x54
function _waitlogic_match(s_tracker, str_notify, str_match) {
    self endon(#"death");
    self waittillmatch(str_match, str_notify);
    update_waitlogic_tracker(s_tracker);
}

// Namespace array/array_shared
// Params 1, eflags: 0x0
// Checksum 0xfda95963, Offset: 0x1040
// Size: 0x34
function _waitlogic_death(s_tracker) {
    self waittill(#"death");
    update_waitlogic_tracker(s_tracker);
}

// Namespace array/array_shared
// Params 1, eflags: 0x0
// Checksum 0xd3369fb7, Offset: 0x1080
// Size: 0x40
function update_waitlogic_tracker(s_tracker) {
    s_tracker._array_wait_count--;
    if (s_tracker._array_wait_count == 0) {
        s_tracker notify(#"array_wait");
    }
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0x3e090db9, Offset: 0x10c8
// Size: 0x7e
function flag_wait(&array, str_flag) {
    for (i = 0; i < array.size; i++) {
        ent = array[i];
        if (!ent flag::get(str_flag)) {
            ent waittill(str_flag);
            i = -1;
        }
    }
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0xe62738c7, Offset: 0x1150
// Size: 0x7e
function flagsys_wait(&array, str_flag) {
    for (i = 0; i < array.size; i++) {
        ent = array[i];
        if (!ent flagsys::get(str_flag)) {
            ent waittill(str_flag);
            i = -1;
        }
    }
}

// Namespace array/array_shared
// Params 2, eflags: 0x20 variadic
// Checksum 0x96c6e6f0, Offset: 0x11d8
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
// Checksum 0x7068e182, Offset: 0x12e8
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
// Checksum 0xc34ed52c, Offset: 0x13a0
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
// Checksum 0x6af0c689, Offset: 0x1428
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
// Checksum 0xa8095864, Offset: 0x1528
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
// Checksum 0x4b58c60e, Offset: 0x1688
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
// Checksum 0xb67b582d, Offset: 0x1710
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
// Checksum 0xb6335902, Offset: 0x17e0
// Size: 0x4e
function random(array) {
    keys = getarraykeys(array);
    return array[keys[randomint(keys.size)]];
}

// Namespace array/array_shared
// Params 1, eflags: 0x0
// Checksum 0xc52b8f41, Offset: 0x1838
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
// Checksum 0x127791e, Offset: 0x18d0
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
// Checksum 0x66474b7b, Offset: 0x1940
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
// Checksum 0x761bc8e2, Offset: 0x19e0
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
// Checksum 0x8bee59c7, Offset: 0x1a90
// Size: 0xa2
function pop(&array, index, b_keep_keys = 1) {
    if (array.size > 0) {
        if (!isdefined(index)) {
            index = getfirstarraykey(array);
        }
        if (isdefined(array[index])) {
            ret = array[index];
            arrayremoveindex(array, index, b_keep_keys);
            return ret;
        }
    }
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0xcb14f6dd, Offset: 0x1b40
// Size: 0x64
function push(&array, val, index = getlastarraykey(array) + 1) {
    arrayinsert(array, val, index);
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0xda3e1743, Offset: 0x1bb0
// Size: 0x34
function push_front(&array, val) {
    push(array, val, 0);
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0xfaa42f39, Offset: 0x1bf0
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
// Checksum 0x3d043a01, Offset: 0x1c98
// Size: 0x1e
function private function_7fe1a364(a, b) {
    return a === b;
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0xe2c1c313, Offset: 0x1cc0
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
// Checksum 0xf956d64c, Offset: 0x1d48
// Size: 0x1e
function closerfunc(dist1, dist2) {
    return dist1 >= dist2;
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0xe71d07db, Offset: 0x1d70
// Size: 0x1e
function fartherfunc(dist1, dist2) {
    return dist1 <= dist2;
}

// Namespace array/array_shared
// Params 5, eflags: 0x0
// Checksum 0x99a328b9, Offset: 0x1d98
// Size: 0x2f8
function get_all_closest(org, &array, excluders = [], max = array.size, maxdist) {
    maxdists2rd = undefined;
    if (isdefined(maxdist)) {
        maxdists2rd = maxdist * maxdist;
    }
    dist = [];
    index = [];
    for (i = 0; i < array.size; i++) {
        if (!isdefined(array[i])) {
            continue;
        }
        excluded = 0;
        for (p = 0; p < excluders.size; p++) {
            if (array[i] != excluders[p]) {
                continue;
            }
            excluded = 1;
            break;
        }
        if (excluded) {
            continue;
        }
        length = distancesquared(org, array[i].origin);
        if (isdefined(maxdists2rd) && maxdists2rd < length) {
            continue;
        }
        dist[dist.size] = length;
        index[index.size] = i;
    }
    for (;;) {
        change = 0;
        for (i = 0; i < dist.size - 1; i++) {
            if (dist[i] <= dist[i + 1]) {
                continue;
            }
            change = 1;
            temp = dist[i];
            dist[i] = dist[i + 1];
            dist[i + 1] = temp;
            temp = index[i];
            index[i] = index[i + 1];
            index[i + 1] = temp;
        }
        if (!change) {
            break;
        }
    }
    newarray = [];
    if (max > dist.size) {
        max = dist.size;
    }
    for (i = 0; i < max; i++) {
        newarray[i] = array[index[i]];
    }
    return newarray;
}

// Namespace array/array_shared
// Params 1, eflags: 0x0
// Checksum 0x10e32a6b, Offset: 0x2098
// Size: 0x22
function alphabetize(&array) {
    return sort_by_value(array, 1);
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0x61b5db8d, Offset: 0x20c8
// Size: 0x42
function sort_by_value(&array, b_lowest_first = 0) {
    return merge_sort(array, &_compare_value, b_lowest_first);
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0xb80bf158, Offset: 0x2118
// Size: 0x42
function sort_by_script_int(&a_ents, b_lowest_first = 0) {
    return merge_sort(a_ents, &_compare_script_int, b_lowest_first);
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0xaf44ea59, Offset: 0x2168
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
// Checksum 0x65c05c81, Offset: 0x2330
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
// Checksum 0xb69fee0a, Offset: 0x24b8
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
// Checksum 0xf5e709cd, Offset: 0x2660
// Size: 0x38
function wait_till_touching(&a_ents, e_volume) {
    while (!is_touching(a_ents, e_volume)) {
        waitframe(1);
    }
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0x39bd6bd9, Offset: 0x26a0
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
// Checksum 0xe9f95911, Offset: 0x2740
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
// Checksum 0x7beed5cb, Offset: 0x27f8
// Size: 0x3a
function quick_sort(array, compare_func) {
    return quick_sort_mid(array, 0, array.size - 1, compare_func);
}

// Namespace array/array_shared
// Params 4, eflags: 0x0
// Checksum 0x386ab69f, Offset: 0x2840
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
// Checksum 0x87ee58e0, Offset: 0x2a10
// Size: 0x50
function _compare_value(val1, val2, b_lowest_first = 1) {
    if (b_lowest_first) {
        return (val1 <= val2);
    }
    return val1 > val2;
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0x5548bd23, Offset: 0x2a68
// Size: 0x6e
function _compare_script_int(e1, e2, b_lowest_first = 1) {
    if (b_lowest_first) {
        return (e1.script_int <= e2.script_int);
    }
    return e1.script_int > e2.script_int;
}

// Namespace array/array_shared
// Params 1, eflags: 0x0
// Checksum 0x2c411361, Offset: 0x2ae0
// Size: 0x10
function _filter_undefined(val) {
    return isdefined(val);
}

// Namespace array/array_shared
// Params 1, eflags: 0x0
// Checksum 0xcc47b6e8, Offset: 0x2af8
// Size: 0x22
function _filter_dead(val) {
    return isalive(val);
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0xfac1414b, Offset: 0x2b28
// Size: 0x44
function _filter_classname(val, arg) {
    return isdefined(val.classname) && issubstr(val.classname, arg);
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0x1562aac6, Offset: 0x2b78
// Size: 0x46
function function_3274b192(val, arg) {
    return !(isdefined(val.classname) && issubstr(val.classname, arg));
}

