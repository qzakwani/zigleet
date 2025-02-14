const eq = @import("std").testing.expectEqual;

fn twoSum(nums: []const u8, target: u8) [2]usize {
    const l = nums.len;
    for (nums, 0..) |n, i| {
        for (nums[i + 1 .. l], 0..) |nn, j| {
            if (n + nn == target) {
                return [2]usize{ i, i + j + 1 };
            }
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
