const std = @import("std");
const mem = std.mem;

/// Returns the set of strings in `candidates` that are anagrams of `word`.
/// Caller owns the returned memory.
pub fn detectAnagrams(
    allocator: mem.Allocator,
    word: []const u8,
    candidates: []const []const u8,
) !std.BufSet {
    var set = std.BufSet.init(allocator);
    errdefer set.deinit();
    const lower_word = try std.ascii.allocLowerString(allocator, word);

    defer allocator.free(lower_word);

    for (candidates) |str| {
        const lower_str = try std.ascii.allocLowerString(allocator, str);
        defer allocator.free(lower_str);

        if (std.mem.eql(u8, lower_word, lower_str))
            continue;

        const mutable_lower_str = try allocator.dupe(u8, lower_str);
        defer allocator.free(mutable_lower_str);

        std.mem.sort(u8, mutable_lower_str, {}, comptime std.sort.asc(u8));

        const mutable_lower_word = try allocator.dupe(u8, lower_word);
        defer allocator.free(mutable_lower_word);

        std.mem.sort(u8, mutable_lower_word, {}, comptime std.sort.asc(u8));

        if (std.mem.eql(u8, mutable_lower_str, mutable_lower_word)) {
            try set.insert(str);
        }
    }
    return set;
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    const allocator = gpa.allocator();

    var set = std.BufSet.init(allocator);
    defer set.deinit();

    try set.insert("welcome");
    try set.insert("hi");
    try set.insert("no no");

    var iter = set.iterator();
    while (iter.next()) |el| {
        std.debug.print("{s}\n", .{el.*});
    }
}
