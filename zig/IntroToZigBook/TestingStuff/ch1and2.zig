const std = @import("std");

// first the author realy tell me a great ways to learn zig with this book
// 1. Advent of code in zig solutions
// https://github.com/SpexGuy/Zig-AoC-Template;
// https://github.com/fjebaker/advent-of-code-2022;
//-----------------------------------------------
// 2. see code written by one of inventors of zig
// https://github.com/kubkon
//-----------------------------------------------
// 3. zig news all news about the zig
// https://zig.news/
pub fn main() !void {}

fn helloYou() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    const str1 = "Hello";
    const str2 = " you!";
    const str3 = try std.mem.concat(allocator, u8, &[_][]const u8{ str1, str2 });
    std.debug.print("{s}\n", .{str3}); // Hello you!

}

// // It does not compile.
// const age = 15;
// _ = age;
// // Using a discarded value!
// std.debug.print("{d}\n", .{age + 2});

//label blocks in zig
// var y: i32 = 123;
// const x = add_one: {
//     y += 1;
//     break :add_one y;
// };
// if (x == 124 and y == 124) {
//     try stdout.print("Hey!", .{});
// }

//----------------------------------
//string build in functions
//----------------------------------
// std.mem.eql(): to compare if two strings are equal.
// const name: []const u8 = "Pedro";
// try stdout.print(
//     "{any}\n", .{std.mem.eql(u8, name, "Pedro")}
// );

// std.mem.splitScalar(): to split a string into an array of substrings given a delimiter value.
// std.mem.splitSequence(): to split a string into an array of substrings given a substring delimiter.
// The difference between these two methods is that the splitScalar()
// uses a single character as the separator to split the string,
// while splitSequence() uses a sequence of characters (a.k.a. a substring)
// as the separator.

// std.mem.startsWith(): to check if string starts with substring.
// std.mem.endsWith(): to check if string ends with substring.
// std.mem.trim(): to remove specific values from both start and end of the string.
// std.mem.concat(): to concatenate strings together.
// std.mem.count(): to count the occurrences of substring in the string.
// std.mem.replace(): to replace the occurrences of substring in the string.

// const str1 = "Hello";
// const str2 = " you!";
// const str3 = try std.mem.concat(
//     allocator, u8, &[_][]const u8{ str1, str2 }
// );
// std.debug.print("{s}\n", .{str3});// Hello you!

// const str1 = "Hello";
// var buffer: [5]u8 = undefined;
// const nrep = std.mem.replace(
//     u8, str1, "el", "34", buffer[0..]
// );
// try stdout.print("New string: {s}\n", .{buffer}); H34lo
// try stdout.print("N of replacements: {d}\n", .{nrep}); 1
