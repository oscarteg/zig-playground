const std = @import("std");
const net = std.net;
const StreamServer = net.StreamServer;
const Address = net.Address;
const GeneralPurposeAllocator = std.heap.GeneralPurposeAllocator;
const print = std.debug.print;
const http = @import("http.zig");
const HTTPContext = http.HTTPContext;
const Status = http.Status;
const HTTPServer = http.HTTPServer;

pub const io_mode = .evented;

pub fn main() anyerror!void {
    var gpa = GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var server = try HTTPServer.init(allocator, .{});
    try server.listen();
}
