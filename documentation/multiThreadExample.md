```zig

pub fn main() !void {
    // This is where the preparatory work takes place
    // before the parallel processing begins.
    std.debug.print("Starting work...\n", .{});

    // These curly brackets are very important, they are necessary
    // to enclose the area where the threads are called.
    // Without these brackets, the program would not wait for the
    // end of the threads and they would continue to run beyond the
    // end of the program.
    {
        // Now we start the first thread, with the number as parameter
        const handle = try std.Thread.spawn(.{}, thread_function, .{1});

        // Waits for the thread to complete,
        // then deallocates any resources created on `spawn()`.
        defer handle.join();

        // Second thread
        const handle2 = try std.Thread.spawn(.{}, thread_function, .{4}); // that can't be right?
        defer handle2.join();

        // Third thread
        const handle3 = try std.Thread.spawn(.{}, thread_function, .{3});
        defer handle3.join(); // <-- something is missing

        // After the threads have been started,
        // they run in parallel and we can still do some work in between.
        std.posix.nanosleep(4, 0);
        std.debug.print("Some weird stuff, after starting the threads.\n", .{});
    }
    // After we have left the closed area, we wait until
    // the threads have run through, if this has not yet been the case.
    std.debug.print("Zig is cool!\n", .{});
}

// This function is started with every thread that we set up.
// In our example, we pass the number of the thread as a parameter.
fn thread_function(num: usize) !void {
    std.posix.nanosleep(1 * num, 0);
    std.debug.print("thread {d}: {s}\n", .{ num, "started." });

    // This timer simulates the work of the thread.
    const work_time = 3 * ((5 - num % 3) - 2);
    std.posix.nanosleep(work_time, 0);

    std.debug.print("thread {d}: {s}\n", .{ num, "finished." });
}
// This is the easiest way to run threads in parallel.
// In general, however, more management effort is required,
// e.g. by setting up a pool and allowing the threads to communicate
// with each other using semaphores.
//
// But that's a topic for another exercise.

```
