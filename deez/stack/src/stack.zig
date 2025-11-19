const std = @import("std");

pub fn Stack(comptime T: type) type {
    return struct {
        const Self = @This();
        const Node = struct { value: T, next: ?*Node };
        allocator: std.mem.Allocator,
        top: ?*Node,
        pub fn init(allocator: std.mem.Allocator) Self {
            return Self{ .allocator = allocator, .top = null };
        }
        pub fn deinit(self: *Self) void {
            while (self.pop()) |_| {}
        }
        pub fn push(self: *Self, value: T) !void {
            const node = try self.allocator.create(Node);
            node.value = value;
            node.next = self.top;
            self.top = node;
        }
        pub fn pop(self: *Self) ?T {
            const node = self.top orelse return null;
            self.top = node.next;
            const value = node.value;
            self.allocator.destroy(node);
            return value;
        }
        pub fn peek(self: Self) ?T {
            if (self.top) |node| {
                return node.value;
            }
            return null;
        }
        pub fn print(self: *Self) void {
            var curr = self.top;
            while (curr) |node| {
                std.debug.print("{d} , ", .{node.value});
                if (node.next) |next_node| {
                    curr = next_node;
                } else {
                    break;
                }
            }
        }
    };
}
