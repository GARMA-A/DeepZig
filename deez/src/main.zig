const std = @import("std");
const expect = std.testing.expect;

pub fn main() !void {
    var x: u4 = 15;
    std.debug.print("{d}\n", .{x});
    x +|= 2;
    std.debug.print("{d}", .{x});
}
