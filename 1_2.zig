const std = @import("std");
const eq = std.testing.expectEqual;

fn twoSum(nums: []const u8, target: u8) ![2]usize {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer std.debug.assert(gpa.deinit() == .ok);
    const allocator = gpa.allocator();
    var temp = std.AutoHashMap(u8, usize).init(allocator);
    defer temp.deinit();

    var j: ?usize = null;
    for (nums, 0..) |n, i| {
        j = temp.get(target - n);
        if (j != null) {
            return [2]usize{ j.?, i };
        }
        try temp.put(n, i);
    }

    return [2]usize{ 0, 0 };
}

test "[2, 7, 11, 15]" {
    const nums = &.{ 2, 7, 11, 15 };
    const target = 9;
    const got = twoSum(nums, target);
    const expected = [2]usize{ 0, 1 };
    try eq(expected, got);
}

test "[3, 2, 4]" {
    const nums = &.{ 3, 2, 4 };
    const target = 6;
    const got = twoSum(nums, target);
    const expected = [2]usize{ 1, 2 };
    try eq(expected, got);
}

test "[3, 3]" {
    const nums = &.{ 3, 3 };
    const target = 6;
    const got = twoSum(nums, target);
    const expected = [2]usize{ 0, 1 };
    try eq(expected, got);
}
