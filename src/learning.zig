const builtin = @import("builtin");
const std = @import("std");
const fmt = std.fmt;
const io = std.io;

const Point = struct {
    x: f32,
    y: f32,
};

const p = Point{
    .x = 0.12,
    .y = 0.12,
};

const Op = enum {
    Sum,
    Mul,
    Sub,
};

fn ask_user() !i64 {
    var buf: [10]u8 = undefined;
    std.debug.warn("A number please: ");
    const user_input = try io.readLineSlice(buf[0..]);
    return fmt.parseInt(i64, user_input, 10);
}

fn apply_ops(comptime operations: []const Op, num: i64) i64 {
    var acc: i64 = 0;
    inline for (operations) |op| {
        switch (op) {
            .Sum => acc +%= num,
            .Mul => acc *%= num,
            .Sub => acc -%= num,
        }
    }
    return acc;
}

pub fn main() !void {
    const user_num = try ask_user();
    const ops = [4]Op{ .Sum, .Mul, .Sub, .Sub };
    const x = apply_ops(ops[0..], user_num);
    std.debug.warn("Result: {}\n", x);
}

/// Compares two slices and returns whether they are equal.
pub fn eql(comptime T: type, a: []const T, b: []const T) bool {
    if (a.len != b.len) return false;
    for (a) |item, index| {
        if (b[index] != item) return false;
    }
    return true;
}

const Timestamp = struct {
    /// The number of seconds since the epoch (this is also a doc comment).
    seconds: i64, // signed so we can represent pre-1970 (not a doc comment)
    /// The number of nanoseconds past the second (doc comment again).
    nanos: u32,

    /// Returns a `Timestamp` struct representing the Unix epoch; that is, the
    /// moment of 1970 Jan 1 00:00:00 UTC (this is a doc comment too).
    pub fn unixEpoch() Timestamp {
        return Timestamp{
            .seconds = 0,
            .nanos = 0,
        };
    }
};
