## chapter 1,2 are just basic syntax and common 
## behavior so i do not make summury for.

### in this chapter we will talk about the heap vs stack 


#### in short the heap is not fixed size of memory and the programmer 
#### need to allocate it manualy to reach the heap any thing else is stored 
#### in the stack 


### stack overflow example to show that stack is very limited on size
```zig
var very_big_alloc: [1000 * 1000 * 24]u64 = undefined;
@memset(very_big_alloc[0..], 0); // fill the memory with the value provided (zero in this case)
```
### allocator for access the stack !!
### there is no need for free this allocator because it is on the stack(free automaticly at the end of the scope)
```zig
const std = @import("std");

pub fn main() void {
    var buffer: [1024]u8 = undefined; // Define a fixed-size stack buffer
    var fba = std.heap.FixedBufferAllocator.init(&buffer); // Create FixedBufferAllocator
    const allocator = fba.allocator(); // Get allocator

    const mem = allocator.alloc(u8, 10) catch unreachable; // Allocate 10 bytes
}
    std.debug.print("Allocated {} bytes on stack.\n", .{mem.len});
    // Insert values into the allocated memory
    for (mem, 0..) |*byte, i| {
        byte.* = @intCast(u8, i * 10); // Assign values (multiples of 10)
    }

    // Print the values stored in `mem`
    std.debug.print("Memory contents: ", .{});
    for (mem) |byte| {
        std.debug.print("{} ", .{byte});
    }
    std.debug.print("\n", .{});
}



```

### allocating memory on the stack is faster but limited on size
### allocating memory on the heap is slower but almost no limit on size

```zig
// One key aspect about Zig, is that there are “no hidden-memory allocations” in Zig. 
// What that really means, is that “no allocations happen behind your back 
// in the standard library” 

// This is a known problem, especially in C++. Because in C++, 
// there are some operators that do allocate memory behind the scene,
// and there is no way for you to know that, until you actually read 
// the source code of these operators, and find the memory allocation calls. 
// Many programmers find this behaviour annoying and hard to keep track of.

// But, in Zig, if a function, an operator, or anything from the standard library needs 
// to allocate some memory during its execution, then, this 
// function/operator needs to receive (as input) an allocator 
// provided by the user, to actually be able to allocate the memory it needs.
```
### example of build in function need to allocate memory 

```zig
var gpa = std.heap.GeneralPurposeAllocator(.{}){};
const allocator = gpa.allocator();
const name = "Pedro";
const output = try std.fmt.allocPrint(
    allocator,
    "Hello {s}!!!",
    .{name}
);
try stdout.print("{s}\n", .{output}); // Hello Pedro!!!
```
### important Notes About allocators
```zig
// Zig offers different types of allocators, and they are usually available 
// through the std.heap module of the standard library. Thus, 
// Furthermore, every allocator object is built on top of the Allocator interface 
// in Zig. This means that, every allocator object you find in Zig must 
// have the methods alloc(), create(), free() and destroy(). 
// So, you can change the type of allocator you are using, but you don’t
// need to change the function calls to the methods that do the memory 
// allocation (and the free memory operations) for your program.
```
### when we use allocator
```zig
// every function call placed on the stack and must have fixed size 
// But in reality, there are two very common instances where this 
// “fixed length limitation” of the stack is a deal braker:

// the objects that you create inside your function might grow in size during the 
// execution of the function.
// sometimes, it is impossible to know upfront how many inputs you 
// will receive, or how big this input will be.
// or simply you want to return pointer to some data (that data must be on the heap or it will be loss)
```

 ### `GeneralPurposeAllocator().`
 ### `page_allocator().`
 ### `FixedBufferAllocator() and ThreadSafeFixedBufferAllocator().`
 ### `ArenaAllocator().`
 ### `c_allocator() (requires you to link to libc).`

### The `page_allocator()` is an allocator that allocates full pages 
### of memory in the heap. In other words, every time you allocate memory 
### with page_allocator(), a full page of memory in the heap is allocated, 
### instead of just a small piece of it.
### The size of this page depends on the system you are using. 
### Most systems use a page size of 4KB in the heap


### The `ArenaAllocator()` is an allocator object that takes a 
### child allocator as input. The idea behind the ArenaAllocator() 
### in Zig is similar to the concept of “arenas” in the programming language Go.
### It is an allocator object that allows you to allocate memory as many times you want
### but free all memory only once In other words, if you have, 
### for example, called 5 times the method alloc() of an ArenaAllocator() object, 
### you can free all the memory you allocated over these 5 calls at once, by simply calling 
### the deinit() method of the same ArenaAllocator() object

## free once instead of 3 times
```Zig
var gpa = std.heap.GeneralPurposeAllocator(.{}){};
var aa = std.heap.ArenaAllocator.init(gpa.allocator());
defer aa.deinit();
const allocator = aa.allocator();

const in1 = try allocator.alloc(u8, 5);
const in2 = try allocator.alloc(u8, 10);
const in3 = try allocator.alloc(u8, 15);
_ = in1; _ = in2; _ = in3;

```


```zig
// fn alloc(comptime T: type, count: usize) ![]T
// Purpose: Allocates an array of count elements of type T on the heap.
// Returns: A slice []T pointing to the allocated memory.

// fn free(slice: []T) void
// Purpose: Frees memory allocated with alloc().

//-----------------------------------------------
//-----------------------------------------------

// fn create(comptime T: type) !*T
// Purpose: Allocates memory for a single object of type T on the heap and returns a pointer to it.
// Returns: A pointer *T to the allocated memory.

// destroy()
// fn destroy(ptr: *T) void
// Purpose: Frees memory allocated with create().


const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    const some_number = try allocator.create(u32);
    defer allocator.destroy(some_number);

    some_number.* = @as(u32, 45);
}
```


