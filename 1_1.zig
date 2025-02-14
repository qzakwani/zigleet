const std = @import("std");
const eq = std.testing.expectEqual;

fn twoSum(nums: []const u8, target: u8) [2]usize {
    // var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    // defer std.debug.assert(gpa.deinit() == .ok);
    // const allocator = gpa.allocator();
    const allocator = std.heap.page_allocator;
    var temp = std.AutoHashMap(u8, usize).init(allocator);
    defer temp.deinit();

    for (nums, 0..10) |n, i| {
        try temp.put(n, i);
    }
    var j: ?u8 = null;
    for (nums, 0..) |n, i| {
        j = temp.get(target - n);
        if (j != null and j.* != i) {
            return [2]usize{ i, j.* };
        }
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
