const std = @import("std");
const eq = std.testing.expectEqual;

fn lengthOfLongestSubstring(s: []const u8) usize {
    if (s.len <= 1) return s.len;

    var seen = [_]bool{false} ** 256;
    var left: usize = 0;
    var longest: usize = 0;

    for (s, 0..) |letter, right| {
        while (seen[letter]) {
            seen[s[left]] = false;
            left += 1;
        }

        seen[letter] = true;
        longest = @max(longest, right - left + 1);
    }

    return longest;
}

test "abcabcbb" {
    const s: []const u8 = "abcabcbb";
    try eq(3, lengthOfLongestSubstring(s));
}

test "bbbbb" {
    const s: []const u8 = "bbbbb";
    try eq(1, lengthOfLongestSubstring(s));
}

test "pwwkew" {
    const s: []const u8 = "pwwkew";
    try eq(3, lengthOfLongestSubstring(s));
}
