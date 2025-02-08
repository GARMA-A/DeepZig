const std = @import("std");

//
//        4     4     4     4     4
//  PI = --- - --- + --- - --- + --- ...
//        1     3     5     7     9

const number = enum(i8) { FOUR = 4, nugativeOne = -1 };

fn PI() !void {
    var i: u8 = 1;
    var sign: i8 = 1;
    var pi_value: f64 = 0.0;

    while (i <= 100) : (i += 2) {
        pi_value += (@as(f64, @intFromEnum(number.FOUR)) / @as(f64, @floatFromInt(i))) * @as(f64,@floatFromInt(sign));
        sign *= @intFromEnum(number.nugativeOne);
    }
    try std.io.getStdOut().writer().print("{}", .{pi_value});
}

pub fn main() !void {
    try PI();
}

fn threads() !void {
    std.debug.print("Starting work...\n", .{});

    {
        const handle = try std.Thread.spawn(.{}, thread_function, .{1});
        defer handle.join();

        const handle2 = try std.Thread.spawn(.{}, thread_function, .{2});
        defer handle2.join();

        const handle3 = try std.Thread.spawn(.{}, thread_function, .{3});
        defer handle3.join();

        std.time.sleep(1500 * std.time.ns_per_ms);
        std.debug.print("Some weird stuff, after starting the threads.\n", .{});
    }
    std.debug.print("Zig is cool!\n", .{});
}

fn thread_function(num: usize) !void {
    std.debug.print("thread {d}: {s}\n", .{ num, "started." });
    std.time.sleep(200 * std.time.ns_per_ms);
    std.debug.print("thread {d}: {s}\n", .{ num, "finished." });
}

fn takeInputFromUser() void {
    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer().print("", .{});

    try stdout.print("Enter something: ", .{});

    var buffer: [100]u8 = undefined; // Buffer to store the input
    const input = try stdin.readUntilDelimiterOrEof(buffer[0..], '\n');

    if (input) |user_input| {
        try stdout.print("You entered: {s}\n", .{user_input});
    } else {
        try stdout.print("No input received.\n", .{});
    }
}

fn printAfterTrySendPointer() !void {
    const allocator = std.heap.page_allocator;
    const usePtr = try trySendPointer(&allocator);
    defer allocator.free(usePtr);
    std.debug.print("{s}", .{usePtr});
}

fn trySendPointer(allocator: *const std.mem.Allocator) !*const [5]u8 {
    const ptr = try allocator.create([5]u8);
    ptr.* = [_]u8{ 'h', 'e', 'l', 'l', 'o' };
    return ptr;
}
