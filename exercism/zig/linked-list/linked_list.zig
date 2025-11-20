pub fn LinkedList(comptime T: type) type {
    return struct {
        // Please implement the doubly linked `Node` (replacing each `void`).
        pub const Node = struct {
            prev: ?*Node = null,
            next: ?*Node = null,
            data: T,
        };

        // Please implement the fields of the linked list (replacing each `void`).
        first: ?*Node = null,
        last: ?*Node = null,
        len: usize = 0,

        // Please implement the below methods.
        // You need to add the parameters to each method.

        pub fn push(self: *@This(), newNode: *Node) void {
            // Please implement this method.
            if (self.last) |last| {
                last.next = newNode;
            } else {
                self.first = newNode;
            }
            newNode.prev = self.last;
            self.last = newNode;
            self.len += 1;
        }

        pub fn pop(self: *@This()) ?*Node {
            // Please implement this method.
            // It must return an optional pointer to a Node.
            const node = self.last orelse return null;
            const prev = node.prev;

            self.last = prev;
            if (prev) |p| {
                p.next = null;
            } else {
                // list became empty
                self.first = null;
            }

            self.len -= 1;
            return node;
        }

        pub fn shift(self: *@This()) ?*Node {
            // Please implement this method.
            // It must return an optional pointer to a Node.
            // remove from head
            const node = self.first orelse return null;
            const next = node.next;

            self.first = next;
            if (next) |n| {
                n.prev = null;
            } else {
                // list became empty
                self.last = null;
            }

            node.prev = null;
            node.next = null;
            self.len -= 1;
            return node;
        }

        pub fn unshift(self: *@This(), newNode: *Node) void {
            // Please implement this method.
            newNode.prev = null;
            newNode.next = self.first;

            if (self.first) |first| {
                first.prev = newNode;
            } else {
                // list was empty
                self.last = newNode;
            }

            self.first = newNode;
            self.len += 1;
        }

        pub fn delete(self: *@This(), node: *Node) void {
            // Please implement this method.
            // It must modify the list only when it contains the given node.
            var cur = self.first;
            while (cur) |curNode| : (cur = curNode.next) {
                if (curNode == node) {
                    const prev = curNode.prev;
                    const next = curNode.next;

                    // relink previous
                    if (prev) |p| {
                        p.next = next;
                    } else {
                        self.first = next;
                    }

                    // relink next
                    if (next) |n| {
                        n.prev = prev;
                    } else {
                        self.last = prev;
                    }

                    curNode.prev = null;
                    curNode.next = null;
                    self.len -= 1;
                    return; // only first occurrence
                }
            }
        }
    };
}
