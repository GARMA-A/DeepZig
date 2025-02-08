# lets talk about if (statement & expresion) and other related staff



## if statement

```zig

if (true){
       //do something
}else if(){
       // do another somethig 
} else {
       // do default thing
}

```

## if expression

```zig
cosnt foo : u8 = if(1==1) 12 else 17; // foo now is equal 12
```


## catch the error union using if or if it optional catch the null
``zig
pub fn main() void {
        const n = numberMaybeFail(num);
        if (n) |value| {
            std.debug.print("={}. ", .{value});
        } else |err| switch (err) {
    }
}
fn numberMaybeFail(n: u8) MyNumberError!u8 {
    if (n > 4) return MyNumberError.TooBig;
    if (n < 4) return MyNumberError.TooSmall;
    return n;
}


```
