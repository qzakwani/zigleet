const std = @import("std");
const eq = std.testing.expectEqual;

fn lengthOfLongestSubstring(s: []const u8) !u32 {
    if (s.len == 0) {
        return 0;
    }

    if (s.len == 1) {
        return 1;
    }

    const allocator = std.heap.page_allocator;
    var temp = std.AutoHashMap(u8, void).init(allocator);
    defer temp.deinit();

    try temp.put(s[0], {});

    var longest: u32 = 1;
    var _longest: u32 = 1;

    for (s[1..]) |letter| {
        if (temp.contains(letter)) {
            if (_longest > longest) {
                longest = _longest;
            }
            _longest = 1;
            temp.clearAndFree();
            try temp.put(letter, {});
            continue;
        }
        try temp.put(letter, {});
        _longest += 1;
    }

    if (_longest > longest) {
        longest = _longest;
    }

    return longest;
}

test "abcabcbb" {
    const s: []const u8 = "abcabcbb";
    try eq(3, try lengthOfLongestSubstring(s));
}

test "bbbbb" {
    const s: []const u8 = "bbbbb";
    try eq(1, try lengthOfLongestSubstring(s));
}

test "pwwkew" {
    const s: []const u8 = "pwwkew";
    try eq(3, try lengthOfLongestSubstring(s));
}
