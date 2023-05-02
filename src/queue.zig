const std = @import("std");

pub fn Queue(comptime Child: type) type {
    return struct {
        const This = @This();

        const Node = struct {
            child: Child,
            next: ?*Node,
        };

        qpa: std.mem.Allocator,
        start: ?*Node,
        end: ?*Node,

        pub fn init(gpa: *std.mem.Allocator) This {
            return .{
                .qpa = std.mem.Allocator.init(gpa),
                .start = null,
                .end = null,
            };
        }

        pub fn enqueue(this: *This, value: Child) !void {
            const node = try this.qpa.create(Node);
            node.* = .{
                .child = value,
                .next = null,
            };

            if (this.end) |end| {
                end.next = node;
                this.end = node;
            } else {
                this.start = node;
                this.end = node;
            }
        }
    };
}
