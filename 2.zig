const std = @import("std");
const eq = @import("std").testing.expectEqual;
const print = std.debug.print;
const pow = std.math.pow;

const ListNode = struct {
    Val: u128,
    Next: ?*ListNode = null,

    fn put(self: *ListNode, val: u128) *ListNode {
        var l = ListNode{
            .Val = val,
            .Next = null,
        };
        self.Next = &l;
        return &l;
    }

    fn from(allocator: *const std.mem.Allocator, vals: []const u128) !*const ListNode {
        const len = vals.len;
        if (len == 0) {
            // no need now
        }

        const head = try allocator.create(ListNode);
        head.* = ListNode{
            .Val = vals[0],
            .Next = null,
        };

        var current = head;
        for (vals[1..]) |v| {
            const new_node = try allocator.create(ListNode);
            new_node.* = ListNode{
                .Val = v,
                .Next = null,
            };
            current.Next = new_node;
            current = new_node;
        }

        return head;
    }

    fn free(allocator: *const std.mem.Allocator, head: *const ListNode) void {
        var current: ?*const ListNode = head;
        while (current) |node| {
            current = node.Next;
            allocator.destroy(node);
        }
    }
};

fn addTwoNumbers(allocator: *const std.mem.Allocator, l1: *const ListNode, l2: *const ListNode) !*const ListNode {
    var i: u128 = 1;
    var n1: u128 = l1.Val;
    var n2: u128 = l2.Val;
    var next1 = l1.Next;
    var next2 = l2.Next;
    while (next1 != null) {
        n1 = n1 + (next1.?.Val * pow(u128, 10, i));
        i += 1;
        next1 = next1.?.Next;
    }
    i = 1;
    while (next2 != null) {
        n2 = n2 + (next2.?.Val * pow(u128, 10, i));
        i += 1;
        next2 = next2.?.Next;
    }

    var res: u128 = n1 + n2;

    const _allocator = std.heap.page_allocator;
    var list = std.ArrayList(u128).init(_allocator);
    defer list.deinit();

    try list.append(res % 10);
    res = res / 10;
    while (res != 0) {
        try list.append(res % 10);
        res = res / 10;
    }

    return try ListNode.from(allocator, list.items);
}

pub fn main() !void {
    var allocator = std.heap.page_allocator;
    const l1 = try ListNode.from(&allocator, &.{ 2, 4, 3 });
    defer ListNode.free(&allocator, l1);
    const l2 = try ListNode.from(&allocator, &.{ 5, 6, 4 });
    defer ListNode.free(&allocator, l2);

    const res = try addTwoNumbers(&allocator, l1, l2);

    print("{}, {}, {}\n", .{ res.Val, res.Next.?.Val, res.Next.?.Next.?.Val });
    _ = &l1;
}
