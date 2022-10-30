const sdl = @cImport({
    @cInclude("SDL2/SDL.h");
});
const std = @import("std");

pub fn main() void {
    _ = sdl.SDL_Init(sdl.SDL_INIT_VIDEO);
    defer sdl.SDL_Quit();
    const window = sdl.SDL_CreateWindow("Hello", sdl.SDL_WINDOWPOS_CENTERED, sdl.SDL_WINDOWPOS_CENTERED, 166, 166, 0);
    defer sdl.SDL_DestroyWindow(window);
    const surface = sdl.SDL_GetWindowSurface(window);

    var quit = false;
    while (!quit) {
        var event: sdl.SDL_Event = undefined;
        while (sdl.SDL_PollEvent(&event) != 0) {
            switch (event.@"type") {
                sdl.SDL_QUIT => {
                    quit = true;
                },
                else => {},
            }
        }
        // Draw a white cross on red background
        _ = sdl.SDL_FillRect(surface, 0, 0xff0000);
        const v = sdl.SDL_Rect{ .x = 33, .y = 66, .w = 100, .h = 34 };
        _ = sdl.SDL_FillRect(surface, &v, 0xffffff);
        const h = sdl.SDL_Rect{ .x = 66, .y = 33, .w = 34, .h = 100 };
        _ = sdl.SDL_FillRect(surface, &h, 0xffffff);
        _ = sdl.SDL_UpdateWindowSurface(window);
    }
}
