const std = @import("std");

const Cat = struct {
    pub fn talk() void {
        std.debug.print("meow!", .{});
    }
};

const Dog = struct {
    pub fn talk() void {
        std.debug.print("bark!", .{});
    }
};

const Snake = struct {
    pub fn not() void {
        std.debug.print("lisp", .{});
    }
};

const Animal = ;

pub fn main() anyerror!void {
    const nums = [_]usize{ 1, 2, 3 };

    var accumulator: usize = 0;
    inline for (nums) |n| {
        accumulator += n;
    }
}
