const std = @import("std");
const expect = std.testing.expect;
const print = std.debug.print;

pub fn main() void {
    if (foo(1200, 34) != 1234) {
        print("Test failed: foo(1200, 34) did not return 1234\n", .{});
    }
}

inline fn foo(a: i32, b: i32) i32 {
    std.debug.print("runtime a = {} b = {}", .{ a, b });
    return a + b;
}
