# So lets talk about declaration and conversion between types in zig

### lets start with hello world programm
```zig
const std = @import("std");

pub fn main() void {
    std.debug.print("Hello world\n", .{});
}

```

```zig
const std = @import("std");
```
### this code will return a new struct with all the methods on it that you can 
### access if you type `std.(XXX)`

## declaring variables 

### using the `var`
```zig 
var x : u8 = 0;
var y : i22 = 0;
var z : u3 = 0;
```
### using `const` 
```zig
cosnt x = 0;
const y :u32 = 0;
const z :u8 = 'A';
```

## types 
### you can use in  `u` and `i` types with any number of bits you want like one bit 
### two or `i50`

```zig
const std = @import("std");
pub fn main() void {
    // Integer Types
    const unsigned_8: u8 = 255;
    const unsigned_16: u16 = 65535;
    const unsigned_32: u32 = 4294967295;
    const unsigned_64: u64 = 18446744073709551615;
    const unsigned_128: u128 = 340282366920938463463374607431768211455;
```
```zig
    const signed_8: i8 = -128;
    const signed_16: i16 = -32768;
    const signed_32: i32 = -2147483648;
    const signed_64: i64 = -9223372036854775808;
    const signed_128: i128 = -170141183460469231731687303715884105728;
```
```zig
    // Floating-Point Types
    const float_16: f16 = 3.14;
    const float_32: f32 = 3.14;
    const float_64: f64 = 3.141592653589793;
    const float_128: f128 = 3.141592653589793238462643383279502884197;

```
``zig

    // Boolean
    const is_valid: bool = true;

    // Void
    const nothing: void = {}; // Used in functions returning nothing

    // Error Type
    const err_type: error{} = error.SomeError;

    // Opaque Type (cannot be directly instantiated)
    const opaque_type: opaque {} = opaque {};
```
```zig
    // Pointer & Reference Types
    var some_value: i32 = 42;
    const ptr_to_value: *i32 = &some_value;
    const const_ptr: *const i32 = &some_value;
    const nullable_ptr: ?*i32 = &some_value;
```
```zig
    // Arrays
    const fixed_array: [3]u8 = [3]u8{1, 2, 3};
    const array :[_]u8 = [_]u8{1,2,3};
    const slice: []const u8 = "Hello"; // pointer plus len (computed at runtime) 
```
```zig
    // Struct
    const Person = struct {
        name: []const u8,
        age: u8,
    };
    const john: Person = .{ .name = "John", .age = 30 };
```
```zig
    // Union
    const Data = union(enum) {
        int_value: i32,
        float_value: f32,
    };
    const my_data: Data = .{ .int_value = 42 };
```
```zig
    // Enum
    const Status = enum { Pending, Completed, Failed };
    const current_status: Status = .Completed;

    // Any Type (used in generic functions)
    const some_anytype: anytype = 42;

    // Never Type (for functions that never return)
    fn crash() noreturn {
        @panic("Something went wrong!");
    }
}
```








