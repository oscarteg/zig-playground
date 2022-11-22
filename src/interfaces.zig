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

// const Animal = union(enum) {
//     cat: Cat,
//     dog: Dog,
//
//     pub fn talk(self: Animal) void {
//         switch (self) {
//             .cat => |cat| cat.talk(),
//             .dog => |dog| dog.talk(),
//         }
//     }
// };
//

const Snake = struct {
    pub fn not() void {
        std.debug.print("lisp", .{});
    }
};

const Animal = union(enum) {
    cat: Cat,
    dog: Dog,
    snake: Snake,

    pub fn talk(self: Animal) void {
        switch (self) {
            .snake => std.debug.print("Ssss~~~", .{}),
            inline else => |case| case.talk(),
        }
    }
};

pub fn main() anyerror!void {
    const nums = [_]usize{ 1, 2, 3 };

    var accumulator: usize = 0;
    inline for (nums) |n| {
        accumulator += n;
    }
}
