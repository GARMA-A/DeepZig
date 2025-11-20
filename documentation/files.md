```zig

const std = @import("std");

pub fn main() !void {
    // first we get the current working directory
    const cwd: std.fs.Dir = std.fs.cwd();

    // then we'll try to make a new directory /output/
    // to store our output files.
    cwd.makeDir("output") catch |e| switch (e) {
        // there is a chance you might want to run this
        // program more than once and the path might already
        // have been created, so we'll have to handle this error
        // by doing nothing
        //
        // we want to catch error.PathAlreadyExists and do nothing
        error.PathAlreadyExists => {},
        // if there's any other unexpected error we just propagate it through
        else => return e,
    };

    // then we'll try to open our freshly created directory
    // wait a minute...
    // opening a directory might fail!
    // what should we do here?
    var output_dir: std.fs.Dir = try cwd.openDir("output", .{});
    defer output_dir.close();

    // we try to open the file `zigling.txt`,
    // and propagate any error up
    const file: std.fs.File = try output_dir.createFile("zigling.txt", .{});
    // it is a good habit to close a file after you are done with it
    // so that other programs can read it and prevent data corruption
    // but here we are not yet done writing to the file
    // if only there were a keyword in Zig that
    // allowed you to "defer" code execution to the end of the scope...
    defer file.close();

    // you are not allowed to move these two lines above the file closing line!
    const byte_written = try file.write("It's zigling time!");
    std.debug.print("Successfully wrote {d} bytes.\n", .{byte_written});
}
// to check if you actually write to the file, you can either,
// 1. open the file in your text editor, or
// 2. print the content of the file in the console with one of these commands
//    Linux/macOS:   >> cat ./output/zigling.txt
//    Windows (CMD): >> type .\output\zigling.txt
//
//
// More on Creating files
//
// notice in:
// ... try output_dir.createFile("zigling.txt", .{});
//                                              ^^^
//                 we passed this anonymous struct to the function call
//
// this is the struct `CreateFlag` with default fields
// {
//      read: bool = false,
//      truncate: bool = true,
//      exclusive: bool = false,
//      lock: Lock = .none,
//      lock_nonblocking: bool = false,
//      mode: Mode = default_mode
// }
//
// Question:
//   - what should you do if you want to also read the file after opening it?
//   - go to the documentation of the struct `std.fs.Dir` here:
//     https://ziglang.org/documentation/master/std/#std.fs.Dir
//       - can you find a function for opening a file? how about deleting a file?
//       - what kind of options can you use with those functions?

```
```zig 


const std = @import("std");

pub fn main() !void {
    // Get the current working directory
    const cwd = std.fs.cwd();

    // try to open ./output assuming you did your 106_files exercise
    var output_dir = try cwd.openDir("output", .{});
    defer output_dir.close();

    // try to open the file
    const file = try output_dir.openFile("zigling.txt", .{});
    defer file.close();

    // initialize an array of u8 with all letter 'A'
    // we need to pick the size of the array, 64 seems like a good number
    // fix the initialization below
    var content = [_]u8{'A'} ** 64;
    // this should print out : `AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA`
    std.debug.print("{s}\n", .{content});

    // okay, seems like a threat of violence is not the answer in this case
    // can you go here to find a way to read the content?
    // https://ziglang.org/documentation/master/std/#std.fs.File
    // hint: you might find two answers that are both valid in this case
    const bytes_read = try file.read(&content);

    // Woah, too screamy. I know you're excited for zigling time but tone it down a bit.
    // Can you print only what we read from the file?
    std.debug.print("Successfully Read {d} bytes: {s}\n", .{
        bytes_read,
        content[0..18], // change this line only
    });
}
```
