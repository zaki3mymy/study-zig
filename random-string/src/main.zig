const std = @import("std");

const characters = [_]u8{
    'a', 'b', 'c', 'd', 'e', 'f', 'g', //
    'h', 'i', 'j', 'k', 'l', 'm', 'n', //
    'o', 'p', 'q', 'r', 's', 't', 'u', //
    'v', 'w', 'x', 'y', 'z', //
    'A', 'B', 'C', 'D', 'E', 'F', 'G', //
    'H', 'I', 'J', 'K', 'L', 'M', 'N', //
    'O', 'P', 'Q', 'R', 'S', 'T', 'U', //
    'V', 'W', 'X', 'Y', 'Z',
};

fn randomString(n: u64) ![]const u8 {
    // Generate a pseudo-random number generator (PRNG) with an unpredictable seed.
    var prng = std.rand.DefaultPrng.init(blk: {
        var seed: u64 = undefined;
        try std.os.getrandom(std.mem.asBytes(&seed));
        break :blk seed;
    });
    const rand = prng.random();

    // Allocate a fixed-size buffer on the stack to be used as the initial memory for the allocator.
    var buf: [1024]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buf);
    var allocator = fba.allocator();
    defer allocator.free(&buf);

    // Allocate a dynamic array to store the random string.
    var string = try allocator.alloc(u8, n);
    var i: u64 = 0;
    while (i < n) : (i += 1) {
        var x = rand.intRangeAtMost(u8, 0, characters.len - 1);
        string[i] = characters[x];
    }
    std.debug.print("{s}\n", .{string});

    return string;
}

test "randomString" {
    var str: []const u8 = try randomString(8);
    try std.testing.expect(8 == str.len);

    str = try randomString(16);
    try std.testing.expect(16 == str.len);
}
