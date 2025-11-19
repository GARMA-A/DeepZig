const stack_mod = @import("stack.zig");
const std = @import("std");

pub fn stack_implementation() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    var stack = stack_mod.Stack(i32).init(gpa.allocator());
    defer stack.deinit();

    try stack.push(10);
    try stack.push(20);
    stack.print();
    const val = stack.pop();
    if (val) |v| {
        std.debug.print("\npoped : {d} \n", .{v});
    }
    try stack.push(30);
    stack.print();
}
