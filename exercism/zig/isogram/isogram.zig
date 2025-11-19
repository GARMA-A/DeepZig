const std = @import("std");
pub fn isIsogram(str: []const u8) bool {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var set = std.AutoHashMap(u8, void).init(allocator);
    defer set.deinit();

    for (str) |ch| {
        if (ch == '-' or ch == ' ')
            continue;

        const lower_letter = std.ascii.toLower(ch);

        if (set.contains(lower_letter))
            return false;

        set.put(lower_letter, {}) catch {
            std.debug.print("the set.put() fails\n", .{});
        };
    }
    return true;
}
