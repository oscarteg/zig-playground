const std = @import("std");
const expectEqual = std.testing.expectEqual;

test "basic vector usage" {
    const a = @Vector(4, i32){ 1, 2, 3, 4 };

    try expectEqual(1, a[0]);
}

test "conversion between vectors arrys slices" {
    // Vectors and fixed-length arrays can be automatically assigned back and forth
    var arr1: [4]f32 = [_]f32{ 1.1, 3.2, 4.5, 5.6 };
    var vec: @Vector(4, f32) = arr1;
    var arr2: [4]f32 = vec;
    try expectEqual(arr1, arr2);
}
