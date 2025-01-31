# this repo from the book introducing to zig a project-based book

[The zig book](https://pedropark99.github.io/zig-book/)

# ch1

```sh
mkdir hello_world
cd hello_world
zig init
#info: created build.zig
#info: created build.zig.zon
#info: created src/main.zig
#nfo: created src/root.zig
#info: see `zig build --help` for a menu of options
zig run src/main.zig
```

## creating new variable syntax

```zig
const name = value;
// ctreate immutable variabele

var name  = value ;
// create mutable variable
```

```zig
const std = @import("std");
const stdout = std.io.getStdOut().writer();
pub fn main() !void {
    _ = try stdout.write("Hello\n");
   try stdout.print("{}\n",.{x});
}
```

## take input from user

```zig
const std = @import("std");

pub fn main() !void {
    const stdin = std.io.getStdIn().reader();
    var input: [128]u8 = undefined;
    const bytes_read = try stdin.readUntilDelimiterOrEof(&input, '\n');
    const user_input = input[0..bytes_read.?.len];
    _ = try std.io.getStdOut().writer().print("you enter : {s}\n", .{user_input});
}
```

### some blocks futures of zig

```zig
const std = @import("std");

pub fn main() !void {
    var y: i32 = 123;

    const x = add_one: {
        y += 1;
        break  :add_one y ;
    };

    _ = try std.io.getStdOut().writer().print("the x = {d}", .{x});
    // the x = 124
}
```
