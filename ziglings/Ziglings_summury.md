## ziglings summury

```js
// "try" is  instead of writing \\ myFunction() catch |err| {return err;}\\
// if struct field is optional we can do this 
// structName.field.?   the ".?" instead of writing \\structName.field orelse unreachable\\;
// mean that if it is = null so throw error 

```



```js

// Zig has at least four ways of expressing "no value":
//
// * undefined
//
//       var foo: u8 = undefined;
//
//       "undefined" should not be thought of as a value, but as a way
//       of telling the compiler that you are not assigning a value
//       _yet_. Any type may be set to undefined, but attempting
//       to read or use that value is _always_ a mistake.
//
// * null
//
//       var foo: ?u8 = null;
//
//       The "null" primitive value _is_ a value that means "no value".
//       This is typically used with optional types as with the ?u8
//       shown above. When foo equals null, that's not a value of type
//       u8. It means there is _no value_ of type u8 in foo at all!
//
// * error
//
//       var foo: MyError!u8 = BadError;
//
//       Errors are _very_ similar to nulls. They _are_ a value, but
//       they usually indicate that the "real value" you were looking
//       for does not exist. Instead, you have an error. The example
//       error union type of MyError!u8 means that foo either holds
//       a u8 value OR an error. There is _no value_ of type u8 in foo
//       when it's set to an error!
//
// * void
//
//       var foo: void = {};
//
//       "void" is a _type_, not a value. It is the most popular of the
//       Zero Bit Types (those types which take up absolutely no space
//       and have only a semantic value. When compiled to executable
//       code, zero bit types generate no code at all. The above example
//       shows a variable foo of type void which is assigned the value
//       of an empty expression. It's much more common to see void as
//       the return type of a function that returns nothing.
//
// Zig has all of these ways of expressing different types of "no value"
// because they each serve a purpose. Briefly:
//
//   * undefined - there is no value YET, this cannot be read YET
//   * null      - there is an explicit value of "no value"
//   * errors    - there is no value because something went wrong
//   * void      - there will NEVER be a value stored here
//
// Please use the correct "no value" for each ??? to make this program
// print out a cursed quote from the Necronomicon. ...If you dare.
//


```


```js
//   +---------------+----------------------------------------------+
//   |  u8           |  one u8                                      |
//   |  *u8          |  pointer to one u8                           |
//   |  [2]u8        |  two u8s                                     |
//   |  [*]u8        |  pointer to unknown number of u8s            |
//   |  [*]const u8  |  pointer to unknown number of immutable u8s  |
//   |  *[2]u8       |  pointer to an array of 2 u8s                |
//   |  *const [2]u8 |  pointer to an immutable array of 2 u8s      |
//   |  []u8         |  slice of u8s                                |
//   |  []const u8   |  slice of immutable u8s                      |
//   +---------------+----------------------------------------------+
```


```js

// In this example, an instance of Foo always takes up u64 of
// space in memory even if you're currently storing a u8.
//
//     const Foo = union {
//         small: u8,
//         medium: u32,
//         large: u64,
//     };

```

```js
const en = enum(u8) { a = 0, b  = 1}; // valid code in zig
```


```js
//                          u8  single item
//                         *u8  single-item pointer
//                        []u8  slice (size known at runtime)
//                       [5]u8  array of 5 u8s
//                       [*]u8  many-item pointer (zero or more)
//                 enum {a, b}  set of unique values a and b
//                error {e, f}  set of unique error values e and f
//      struct {y: u8, z: i32}  group of values y and z
// union(enum) {a: u8, b: i32}  single value either u8 or i32
```


```js
//     const a1: u8 = 65;          // decimal
//     const a2: u8 = 0x41;        // hexadecimal
//     const a3: u8 = 0o101;       // octal
//     const a4: u8 = 0b1000001;   // binary
//     const a5: u8 = 'A';         // ASCII code point literal
//     const a6: u16 = '\u{0041}'; // Unicode code points can take up to 21 bits

```



```js
// It'll only take us a moment to learn the Zig type coercion
// rules because they're quite logical.
//
// 1. Types can always be made _more_ restrictive.
//
//    var foo: u8 = 5;
//    var p1: *u8 = &foo;
//    var p2: *const u8 = p1; // mutable to immutable
//
// 2. Numeric types can coerce to _larger_ types.
//
//    var n1: u8 = 5;
//    var n2: u16 = n1; // integer "widening"
//
//    var n3: f16 = 42.0;
//    var n4: f32 = n3; // float "widening"
//
// 3. Single-item pointers to arrays coerce to slices and
//    many-item pointers.
//
//    const arr: [3]u8 = [3]u8{5, 6, 7};
//    const s: []const u8 = &arr;  // to slice
//    const p: [*]const u8 = &arr; // to many-item pointer
//
// 4. Single-item mutable pointers can coerce to single-item
//    pointers pointing to an array of length 1. (Interesting!)
//
//    var five: u8 = 5;
//    var a_five: *[1]u8 = &five;
//
// 5. Payload types and null coerce to optionals.
//
//    var num: u8 = 5;
//    var maybe_num: ?u8 = num; // payload type
//    maybe_num = null;         // null
//
// 6. Payload types and errors coerce to error unions.
//
//    const MyError = error{Argh};
//    var char: u8 = 'x';
//    var char_or_die: MyError!u8 = char; // payload type
//    char_or_die = MyError.Argh;         // error
//
// 7. 'undefined' coerces to any type (or it wouldn't work!)
//
// 8. Compile-time numbers coerce to compatible types.
//
//    Just about every single exercise program has had an example
//    of this, but a full and proper explanation is coming your
//    way soon in the third-eye-opening subject of comptime.
//
// 9. Tagged unions coerce to the current tagged enum.
//
// 10. Enums coerce to a tagged union when that tagged field is a
//     zero-length type that has only one value (like void).
//
// 11. Zero-bit types (like void) can be coerced into single-item
//     pointers.
//
// The last three are fairly esoteric, but you're more than
// welcome to read more about them in the official Zig language
// documentation and write your own experiments.
```
```js

// Remember using if/else statements as expressions like this?
//
//     var foo: u8 = if (true) 5 else 0;
//
// Zig also lets you use for and while loops as expressions.
//
// Like 'return' for functions, you can return a value from a
// loop block with break:
//
//     break true; // return boolean value from block
//
// But what value is returned from a loop if a break statement is
// never reached? We need a default expression. Thankfully, Zig
// loops also have 'else' clauses! As you might have guessed, the
// 'else' clause is evaluated when: 1) a 'while' condition becomes
// false or 2) a 'for' loop runs out of items.
//
//     const two: u8 = while (true) break 2 else 0;         // 2
//     const three: u8 = for ([1]u8{1}) |f| break 3 else 0; // 3
//
// If you do not provide an else clause, an empty one will be
// provided for you, which will evaluate to the void type, which
// is probably not what you want. So consider the else clause
// essential when using loops as expressions.
//
//     const four: u8 = while (true) {
//         break 4;
//     };               // <-- ERROR! Implicit 'else void' here!
//
// With that in mind, see if you can fix the problem with this
// program.
//



```
```js
comptime can make the code after it run at compile time 
inline (for/while) make the loops or the block after it run at comptime

```


```js

// In addition to knowing when to use the 'comptime' keyword,
// it's also good to know when you DON'T need it.
//
// The following contexts are already IMPLICITLY evaluated at
// compile time, and adding the 'comptime' keyword would be
// superfluous, redundant, and smelly:
//
//    * The container-level scope (outside of any function in a source file)
//    * Type declarations of:
//        * Variables
//        * Functions (types of parameters and return values)
//        * Structs
//        * Unions
//        * Enums
//    * The test expressions in inline for and while loops
//    * An expression passed to the @cImport() builtin
//
// Work with Zig for a while, and you'll start to develop an
// intuition for these contexts. Let's work on that now.
//
// You have been given just one 'comptime' statement to use in
// the program below. Here it is:
//
//     comptime
//
// Just one is all it takes. Use it wisely!
```





