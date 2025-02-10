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


pub fn main() !void {
  const array = [_]u8{1, 2, 3, 4};
  _ = array;

}

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
//----------------------------------------------------
//----------------------------------------------------
//----------------------------------------------------
//----------------------------------------------------
// Switch statements must exhaust all possibilities
// const std = @import("std");
// const stdout = std.io.getStdOut().writer();
// const Role = enum {
//     SE, DPE, DE, DA, PM, PO, KS
// };

// pub fn main() !void {
//     var area: []const u8 = undefined;
//     const role = Role.SE;
//     switch (role) {
//         .PM, .SE, .DPE, .PO => {
//             area = "Platform";
//         },
//         .DE, .DA => {
//             area = "Data & Analytics";
//         },
//         .KS => {
//             area = "Sales";
//         },
//     }
//     try stdout.print("{s}\n", .{area});
// }
//---------------------------------------
// Using ranges in switch
// const level: u8 = 4;
// const category = switch (level) {
//     0...25 => "beginner",
//     26...75 => "intermediary",
//     76...100 => "professional",
//     else => {
//         @panic("Not supported level!");
//     },
// };
// try stdout.print("{s}\n", .{category});
//-----------------------------------------
//-----------------------------------------
// Labeled switch statements
// xsw: switch (@as(u8, 1)) {
//     1 => {
//         try stdout.print("First branch\n", .{});
//         continue :xsw 2;
//     },
//     2 => continue :xsw 3,
//     3 => return,
//     4 => {},
//     else => {
//         try stdout.print(
//             "Unmatched case, value: {d}\n", .{@as(u8, 1)}
//         );
//     },
// }

//-----------------------------------------------------
// defer and errdefer fisrt in last out order of excution (the order from bottom to top)
//------------------------------------------------------

// oop in zig
// zig is c like lang we use struct as a class with methods and variables inside it
// the constructor  is normal method in zig (naming convention is init) the destructor (naming convention is deinit)

// example
// const std = @import("std");
// const stdout = std.io.getStdOut().writer();
// const User = struct {
//     id: u64,
//     name: []const u8,
//     email: []const u8,

//     pub fn init(id: u64,
//                 name: []const u8,
//                 email: []const u8) User {

//         return User {
//             .id = id,
//             .name = name,
//             .email = email
//         };
//     }

//     pub fn print_name(self: User) !void {
//         try stdout.print("{s}\n", .{self.name});
//     }
// };

// pub fn main() !void {
//     const u = User.init(1, "pedro", "email@gmail.com");
//     try u.print_name();
// }
