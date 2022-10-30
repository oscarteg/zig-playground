const print = @import("std").debug.print;

fn max(comptime T: type, a: T, b: T) T {
    return if (a > b) a else b;
}

fn gimmeTheBiggerFloat(a: f32, b: f32) f32 {
    return max(f32, a, b);
}
fn gimmeTheBiggerInteger(a: u64, b: u64) u64 {
    return max(u64, a, b);
}

// Compares two strings ignoring case (ascii strings only).
// Specialzied version where `uppr` is comptime known and *uppercase*.
fn insensitive_eql(comptime uppr: []const u8, str: []const u8) bool {
    comptime {
        var i: usize = 0;
        while (i < uppr.len) : (i += 1) {
            if (uppr[i] >= 'a' and uppr[i] <= 'z') {
                @compileError("`uppr` must be all uppercase");
            }
        }
    }
    var i: usize = 0;
    while (i < uppr.len) : (i += 1) {
        const val = if (str[i] >= 'a' and str[i] <= 'z')
            str[i] - 32
        else
            str[i];
        if (val != uppr[i]) return false;
    }
    return true;
}

pub fn main() void {
    const x = insensitive_eql("HELLO", "hElLo");
}
