#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;

#namespace array;

// Namespace array/array_shared
// Params 4, eflags: 0x20 variadic
// Checksum 0x67db8534, Offset: 0x90
// Size: 0x190
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
            if (is_true(b_keep_keys)) {
                a_new[key] = val;
                continue;
            }
            a_new[a_new.size] = val;
        }
    }
    return a_new;
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0xc4baa04a, Offset: 0x228
// Size: 0x3a
function filter_classname(&array, b_keep_keys, str_classname) {
    return filter(array, b_keep_keys, &_filter_classname, str_classname);
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0x75aca202, Offset: 0x270
// Size: 0x3a
function function_f23011ac(&array, b_keep_keys, str_classname) {
    return filter(array, b_keep_keys, &function_e01a747e, str_classname);
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0xf8412718, Offset: 0x2b8
// Size: 0xfa
function get_touching(a_ents, e_volume) {
    a_touching = [];
    foreach (e_ent in a_ents) {
        if (e_ent istouching(e_volume)) {
            if (!isdefined(a_touching)) {
                a_touching = [];
            } else if (!isarray(a_touching)) {
                a_touching = array(a_touching);
            }
            a_touching[a_touching.size] = e_ent;
        }
    }
    return a_touching;
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0xdb48d275, Offset: 0x3c0
// Size: 0xe0
function remove_index(array, index, b_keep_keys) {
    a_new = [];
    foreach (key, val in array) {
        if (key == index) {
            continue;
        }
        if (is_true(b_keep_keys)) {
            a_new[key] = val;
            continue;
        }
        a_new[a_new.size] = val;
    }
    return a_new;
}

// Namespace array/array_shared
// Params 1, eflags: 0x0
// Checksum 0xaa1d13d1, Offset: 0x4a8
// Size: 0x1ea
function function_b1d17853(&array) {
    remove = [];
    checked = [];
    foreach (key, item in array) {
        if (!isdefined(item)) {
            add(remove, key);
            continue;
        }
        checked[key] = 1;
        foreach (var_279de89e, var_cc6c9b0a in array) {
            if (var_279de89e != key && var_cc6c9b0a == item && !isdefined(checked[var_279de89e])) {
                add(remove, key);
                break;
            }
        }
    }
    foreach (key in remove) {
        array[key] = undefined;
    }
    return array;
}

// Namespace array/array_shared
// Params 1, eflags: 0x0
// Checksum 0xb09c666d, Offset: 0x6a0
// Size: 0x100
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
// Checksum 0xc3744830, Offset: 0x7a8
// Size: 0x8a
function notify_all(&array, str_notify) {
    foreach (elem in array) {
        elem notify(str_notify);
    }
}

// Namespace array/array_shared
// Params 8, eflags: 0x0
// Checksum 0x1bce70df, Offset: 0x840
// Size: 0x15c
function thread_all(&entities, func, arg1, arg2, arg3, arg4, arg5, arg6) {
    assert(isdefined(entities), "<dev string:x38>");
    assert(isdefined(func), "<dev string:x6e>");
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
// Checksum 0xcd78cf37, Offset: 0x9a8
// Size: 0x14c
function thread_all_ents(&entities, func, arg1, arg2, arg3, arg4, arg5) {
    assert(isdefined(entities), "<dev string:xa0>");
    assert(isdefined(func), "<dev string:xdb>");
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
// Checksum 0x4eecf1df, Offset: 0xb00
// Size: 0x15c
function run_all(&entities, func, arg1, arg2, arg3, arg4, arg5, arg6) {
    assert(isdefined(entities), "<dev string:x112>");
    assert(isdefined(func), "<dev string:x145>");
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
// Checksum 0x67672790, Offset: 0xc68
// Size: 0xe0
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
// Checksum 0x987a0f37, Offset: 0xd50
// Size: 0x66
function add(&array, item, allow_dupes = 1) {
    if (isdefined(item)) {
        if (allow_dupes || !isinarray(array, item)) {
            array[array.size] = item;
        }
    }
}

// Namespace array/array_shared
// Params 5, eflags: 0x0
// Checksum 0xe881be26, Offset: 0xdc0
// Size: 0x118
function add_sorted(&array, item, allow_dupes = 1, func_compare, var_e19f0739 = 0) {
    if (isdefined(item)) {
        if (allow_dupes || !isinarray(array, item)) {
            for (i = 0; i <= array.size; i++) {
                if (i == array.size || isdefined(func_compare) && ([[ func_compare ]](item, array[i]) || var_e19f0739) || !isdefined(func_compare) && (item <= array[i] || var_e19f0739)) {
                    arrayinsert(array, item, i);
                    break;
                }
            }
        }
    }
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0x1add1fa0, Offset: 0xee0
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
// Checksum 0xef8f6cf, Offset: 0x1040
// Size: 0x184
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
// Checksum 0x40042a33, Offset: 0x11d0
// Size: 0x54
function _waitlogic_match(s_tracker, str_notify, str_match) {
    self endon(#"death");
    self waittillmatch(str_match, str_notify);
    update_waitlogic_tracker(s_tracker);
}

// Namespace array/array_shared
// Params 1, eflags: 0x0
// Checksum 0xf41268f9, Offset: 0x1230
// Size: 0x34
function _waitlogic_death(s_tracker) {
    self waittill(#"death");
    update_waitlogic_tracker(s_tracker);
}

// Namespace array/array_shared
// Params 1, eflags: 0x0
// Checksum 0x60682293, Offset: 0x1270
// Size: 0x40
function update_waitlogic_tracker(s_tracker) {
    s_tracker._array_wait_count--;
    if (s_tracker._array_wait_count == 0) {
        s_tracker notify(#"array_wait");
    }
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0x58feb546, Offset: 0x12b8
// Size: 0x8c
function flag_wait(&array, str_flag) {
    for (i = 0; i < array.size; i++) {
        ent = array[i];
        if (isdefined(ent) && !ent flag::get(str_flag)) {
            ent waittill(#"death", str_flag);
            i = -1;
        }
    }
}

// Namespace array/array_shared
// Params 2, eflags: 0x20 variadic
// Checksum 0x88c11c01, Offset: 0x1350
// Size: 0x108
function function_d77ef691(&array, ...) {
    for (i = 0; i < array.size; i++) {
        ent = array[i];
        if (isdefined(ent)) {
            b_flag_set = 0;
            foreach (str_flag in vararg) {
                if (ent flag::get(str_flag)) {
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
// Params 3, eflags: 0x0
// Checksum 0x53b759f0, Offset: 0x1460
// Size: 0xc8
function flag_wait_clear(&array, str_flag, n_timeout) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
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
// Checksum 0x3dfcd2df, Offset: 0x1530
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
// Checksum 0x7a8d00e3, Offset: 0x1690
// Size: 0x78
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
// Checksum 0x154a77e3, Offset: 0x1710
// Size: 0xd4
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
// Checksum 0x3affd301, Offset: 0x17f0
// Size: 0x54
function random(&array) {
    if (array.size > 0) {
        keys = getarraykeys(array);
        return array[keys[randomint(keys.size)]];
    }
}

// Namespace array/array_shared
// Params 1, eflags: 0x0
// Checksum 0xd4bf9f7, Offset: 0x1850
// Size: 0x7e
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
// Checksum 0x9cfbeacf, Offset: 0x18d8
// Size: 0x7e
function function_20973c2b(array) {
    for (i = 0; i < array.size; i++) {
        j = function_d59c2d03(array.size);
        temp = array[i];
        array[i] = array[j];
        array[j] = temp;
    }
    return array;
}

// Namespace array/array_shared
// Params 1, eflags: 0x0
// Checksum 0x20b9e00, Offset: 0x1960
// Size: 0x5c
function reverse(array) {
    a_array2 = [];
    for (i = array.size - 1; i >= 0; i--) {
        a_array2[a_array2.size] = array[i];
    }
    return a_array2;
}

// Namespace array/array_shared
// Params 4, eflags: 0x0
// Checksum 0xa63b4ddc, Offset: 0x19c8
// Size: 0xc2
function slice(&array, var_12692bcf = 0, var_d88b3814 = 2147483647, n_increment = 1) {
    var_d88b3814 = min(var_d88b3814, array.size - 1);
    a_ret = [];
    for (i = var_12692bcf; i <= var_d88b3814; i += n_increment) {
        a_ret[a_ret.size] = array[i];
    }
    return a_ret;
}

// Namespace array/array_shared
// Params 1, eflags: 0x0
// Checksum 0x9d08e2bb, Offset: 0x1a98
// Size: 0x9e
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
// Checksum 0xe0a61366, Offset: 0x1b40
// Size: 0x98
function swap(&array, index1, index2) {
    assert(index1 < array.size, "<dev string:x174>");
    assert(index2 < array.size, "<dev string:x193>");
    temp = array[index1];
    array[index1] = array[index2];
    array[index2] = temp;
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0x37167092, Offset: 0x1be0
// Size: 0x92
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
// Checksum 0xe03e3f11, Offset: 0x1c80
// Size: 0x5a
function pop_front(&array, b_keep_keys = 1) {
    index = getfirstarraykey(array);
    return pop(array, index, b_keep_keys);
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0xdb0ead9, Offset: 0x1ce8
// Size: 0x5a
function function_a3b0f814(&array, b_keep_keys = 1) {
    return pop(array, random(getarraykeys(array)), b_keep_keys);
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0x9a80c383, Offset: 0x1d50
// Size: 0x4c
function push(&array, val, index = array.size + 1) {
    arrayinsert(array, val, index);
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0x8b8f9229, Offset: 0x1da8
// Size: 0x2c
function push_front(&array, val) {
    push(array, val, 0);
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0x68388a45, Offset: 0x1de0
// Size: 0xa0
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
// Checksum 0x335b8f25, Offset: 0x1e88
// Size: 0x1a
function private function_80fe1cb6(a, b) {
    return a === b;
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0xf963fd4b, Offset: 0x1eb0
// Size: 0x72
function find(&array, ent, func_compare = &function_80fe1cb6) {
    for (i = 0; i < array.size; i++) {
        if ([[ func_compare ]](array[i], ent)) {
            return i;
        }
    }
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0xa4a3cbdb, Offset: 0x1f30
// Size: 0x1a
function closerfunc(dist1, dist2) {
    return dist1 >= dist2;
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0xc56a0f27, Offset: 0x1f58
// Size: 0x1a
function fartherfunc(dist1, dist2) {
    return dist1 <= dist2;
}

// Namespace array/array_shared
// Params 5, eflags: 0x0
// Checksum 0xf27fed57, Offset: 0x1f80
// Size: 0xaa
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
// Checksum 0x7e6ed508, Offset: 0x2038
// Size: 0xaa
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
// Checksum 0x12c51708, Offset: 0x20f0
// Size: 0x22
function alphabetize(&array) {
    return sort_by_value(array, 1);
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0xcead99a7, Offset: 0x2120
// Size: 0x42
function sort_by_value(&array, b_lowest_first = 0) {
    return merge_sort(array, &_compare_value, b_lowest_first);
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0xe1379cba, Offset: 0x2170
// Size: 0x42
function sort_by_script_int(&a_ents, b_lowest_first = 0) {
    return merge_sort(a_ents, &_compare_script_int, b_lowest_first);
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0x42c67218, Offset: 0x21c0
// Size: 0x1a2
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
// Checksum 0x8249a0ae, Offset: 0x2370
// Size: 0x140
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
// Params 2, eflags: 0x0
// Checksum 0xaa692f8e, Offset: 0x24b8
// Size: 0x160
function bubble_sort(&array, sort_func) {
    start = 0;
    end = array.size;
    var_f9038db1 = 1;
    while (var_f9038db1 && start < end) {
        var_f9038db1 = 0;
        i = start;
        for (j = start + 1; j < end; j++) {
            if ([[ sort_func ]](array[j], array[i])) {
                swap(array, j, i);
                var_f9038db1 = 1;
            }
            i++;
        }
        end--;
        if (var_f9038db1 && start < end) {
            var_f9038db1 = 0;
            i = end - 2;
            for (j = i + 1; i >= start; j--) {
                if ([[ sort_func ]](array[j], array[i])) {
                    swap(array, j, i);
                    var_f9038db1 = 1;
                }
                i--;
            }
            start++;
        }
    }
}

// Namespace array/array_shared
// Params 7, eflags: 0x0
// Checksum 0x44b2d894, Offset: 0x2620
// Size: 0x18c
function spread_all(&entities, func, arg1, arg2, arg3, arg4, arg5) {
    assert(isdefined(entities), "<dev string:x1b2>");
    assert(isdefined(func), "<dev string:x1ed>");
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
// Checksum 0x6398401, Offset: 0x27b8
// Size: 0x38
function wait_till_touching(&a_ents, e_volume) {
    while (!is_touching(a_ents, e_volume)) {
        waitframe(1);
    }
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0xa5208e00, Offset: 0x27f8
// Size: 0xa2
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
// Checksum 0x416f270f, Offset: 0x28a8
// Size: 0xb4
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
// Checksum 0x312f1d66, Offset: 0x2968
// Size: 0xe6
function function_460f3c24(array1, array2) {
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
// Checksum 0x3a009e5b, Offset: 0x2a58
// Size: 0x60
function quick_sort(&array, compare_func) {
    sorted_array = arraycopy(array);
    quick_sort_mid(sorted_array, 0, sorted_array.size - 1, compare_func);
    return sorted_array;
}

// Namespace array/array_shared
// Params 4, eflags: 0x0
// Checksum 0x5da85655, Offset: 0x2ac0
// Size: 0x124
function quick_sort_mid(&array, start, end, compare_func) {
    if (end - start >= 1) {
        if (!isdefined(compare_func)) {
            compare_func = &_compare_value;
        }
        pivot = array[end];
        i = start;
        for (k = start; k < end; k++) {
            if ([[ compare_func ]](array[k], pivot)) {
                swap(array, i, k);
                i++;
            }
        }
        if (i != end) {
            swap(array, i, end);
        }
        quick_sort_mid(array, start, i - 1, compare_func);
        quick_sort_mid(array, i + 1, end, compare_func);
    }
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0x4ee73407, Offset: 0x2bf0
// Size: 0x48
function _compare_value(val1, val2, b_lowest_first = 1) {
    if (b_lowest_first) {
        return (val1 <= val2);
    }
    return val1 > val2;
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0xbcf84cd2, Offset: 0x2c40
// Size: 0x1a
function function_5b554cb6(val1, val2) {
    return val1 > val2;
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0xcbbeee2, Offset: 0x2c68
// Size: 0x62
function _compare_script_int(e1, e2, b_lowest_first = 1) {
    if (b_lowest_first) {
        return (e1.script_int <= e2.script_int);
    }
    return e1.script_int > e2.script_int;
}

// Namespace array/array_shared
// Params 1, eflags: 0x0
// Checksum 0x11a833fc, Offset: 0x2cd8
// Size: 0x10
function _filter_undefined(val) {
    return isdefined(val);
}

// Namespace array/array_shared
// Params 1, eflags: 0x0
// Checksum 0x782743d2, Offset: 0x2cf0
// Size: 0x22
function _filter_dead(val) {
    return isalive(val);
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0xa034920d, Offset: 0x2d20
// Size: 0x44
function _filter_classname(val, arg) {
    return isdefined(val.classname) && issubstr(val.classname, arg);
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0x951af5cd, Offset: 0x2d70
// Size: 0x46
function function_e01a747e(val, arg) {
    return !(isdefined(val.classname) && issubstr(val.classname, arg));
}

/#

    // Namespace array/array_shared
    // Params 0, eflags: 0x0
    // Checksum 0xff1aafac, Offset: 0x2dc0
    // Size: 0xc2
    function function_f2d037b1() {
        wait 5;
        for (maxval = 0; maxval < 100; maxval++) {
            for (i = 0; i < 100; i++) {
                minval = randomintrangeinclusive(0, maxval);
                function_d1f43a84(undefined, minval, maxval);
                function_d1f43a84(undefined, minval, maxval, &function_5b554cb6, 0);
                waitframe(1);
            }
        }
    }

    // Namespace array/array_shared
    // Params 5, eflags: 0x0
    // Checksum 0x760ef07b, Offset: 0x2e90
    // Size: 0x274
    function function_d1f43a84(max_entries, minval, maxval, compare_func, var_c8e96eee) {
        if (!isdefined(max_entries)) {
            max_entries = 20;
        }
        if (!isdefined(minval)) {
            minval = 0;
        }
        if (!isdefined(maxval)) {
            maxval = 100;
        }
        if (!isdefined(compare_func)) {
            compare_func = undefined;
        }
        if (!isdefined(var_c8e96eee)) {
            var_c8e96eee = 1;
        }
        var_365f3054 = randomintrange(0, max_entries);
        println("<dev string:x224>" + var_365f3054 + "<dev string:x240>" + minval + "<dev string:x25e>" + maxval + "<dev string:x266>");
        source_array = [];
        for (i = 0; i < var_365f3054; i++) {
            if (!isdefined(source_array)) {
                source_array = [];
            } else if (!isarray(source_array)) {
                source_array = array(source_array);
            }
            source_array[source_array.size] = randomintrangeinclusive(minval, maxval);
        }
        test_array = arraycopy(source_array);
        sorted_array = quick_sort(test_array, compare_func);
        if (var_c8e96eee) {
            for (i = 0; i < var_365f3054 - 1; i++) {
                assert(sorted_array[i] <= sorted_array[i + 1], "<dev string:x275>");
            }
        } else {
            for (i = 0; i < var_365f3054 - 1; i++) {
                assert(sorted_array[i] >= sorted_array[i + 1], "<dev string:x275>");
            }
        }
        println("<dev string:x28b>");
    }

    // Namespace array/array_shared
    // Params 0, eflags: 0x0
    // Checksum 0x71ccbbf0, Offset: 0x3110
    // Size: 0xca
    function function_81d0d595() {
        wait 5;
        for (maxval = 0; maxval < 100; maxval++) {
            for (i = 0; i < 100; i++) {
                minval = randomintrangeinclusive(0, maxval);
                function_70daaa9d(undefined, minval, maxval, &_compare_value);
                function_70daaa9d(undefined, minval, maxval, &function_5b554cb6, 0);
                waitframe(1);
            }
        }
    }

    // Namespace array/array_shared
    // Params 5, eflags: 0x0
    // Checksum 0xd7de15b0, Offset: 0x31e8
    // Size: 0x26c
    function function_70daaa9d(max_entries, minval, maxval, compare_func, var_c8e96eee) {
        if (!isdefined(max_entries)) {
            max_entries = 50;
        }
        if (!isdefined(minval)) {
            minval = 0;
        }
        if (!isdefined(maxval)) {
            maxval = 100;
        }
        if (!isdefined(compare_func)) {
            compare_func = undefined;
        }
        if (!isdefined(var_c8e96eee)) {
            var_c8e96eee = 1;
        }
        var_365f3054 = randomintrange(0, max_entries);
        println("<dev string:x293>" + var_365f3054 + "<dev string:x240>" + minval + "<dev string:x25e>" + maxval + "<dev string:x266>");
        source_array = [];
        for (i = 0; i < var_365f3054; i++) {
            if (!isdefined(source_array)) {
                source_array = [];
            } else if (!isarray(source_array)) {
                source_array = array(source_array);
            }
            source_array[source_array.size] = randomintrangeinclusive(minval, maxval);
        }
        sorted_array = arraycopy(source_array);
        bubble_sort(sorted_array, compare_func);
        if (var_c8e96eee) {
            for (i = 0; i < var_365f3054 - 1; i++) {
                assert(sorted_array[i] <= sorted_array[i + 1], "<dev string:x2b0>");
            }
        } else {
            for (i = 0; i < var_365f3054 - 1; i++) {
                assert(sorted_array[i] >= sorted_array[i + 1], "<dev string:x2b0>");
            }
        }
        println("<dev string:x28b>");
    }

#/
