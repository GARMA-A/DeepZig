const std = @import("std");
const stack_impl = @import("stack_impl.zig");

pub fn main() !void {
    try stack_impl.stack_implementation();
}
