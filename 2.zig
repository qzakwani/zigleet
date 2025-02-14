const std = @import("std");
const eq = @import("std").testing.expectEqual;
const print = std.debug.print;

const ListNode = struct {
    Val: u8,
    Next: ?*ListNode = null,

    fn put(self: *ListNode, val: u8) *ListNode {
        var l = ListNode{
            .Val = val,
            .Next = null,
        };
        self.Next = &l;
        return &l;
    }

    fn from(vals: []const u8) *const ListNode {
        const len = vals.len;
        if (len == 0) {
            // no need now
        }

        var l = ListNode{
            .Val = vals[0],
            .Next = null,
        };

        const fl = l;

        for (vals[1..]) |v| {
            var ll = ListNode{
                .Val = v,
                .Next = null,
            };
            l.Next = &ll;
            l = ll;
        }

        return &fl;
    }
};

fn addTwoNumbers(l1: *ListNode, l2: *ListNode) !*const ListNode {
    var i: u128 = 1;
    var n1: u32 = l1.Val;
    var n2: u32 = l2.Val;
    var next1 = l1.Next;
    var next2 = l2.Next;
    while (next1 != null) {
        n1 = n1 + (next1.Val * (i * 10));
        i += 1;
        next1 = next1.Next;
    }
    i = 1;
    while (next2 != null) {
        n2 = n2 + (next2.Val * (i * 10));
        i += 1;
        next2 = next2.Next;
    }

    var res: u32 = n1 + n2;
    var l = ListNode{
        .Val = res % 10,
        .Next = null,
    };
    const fl = &l;
    res = res / 10;
    while (res != 0) {
        var ll = ListNode{
            .Val = res % 10,
            .Next = null,
        };
        l.Next = &ll;
        l = ll;

        res = res / 10;
    }

    return fl;
}

pub fn main() !void {
    var l1 = ListNode.from(&.{ 2, 4, 3 });

    print("{}, {}, {}\n", .{ l1.Val, l1.Next.?.Val, l1.Next.?.Next.?.Val });
    _ = &l1;
}
