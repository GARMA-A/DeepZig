// Take a look at the tests, you might have to change the function arguments

pub fn binarySearch(comptime T: type, target: T, items: []const T) ?usize {
    if (items.len == 0) return null;
    var l: usize, var r: usize = .{ 0, items.len - 1 };
    while (l <= r) {
        const mid = l + (r - l) / 2;
        if (items[mid] == target) {
            return mid;
        } else if (items[mid] < target) {
            l = mid + 1;
        } else {
            if (mid == 0) break;
            r = mid - 1;
        }
    }
    return null;
}
