const std = @import("std");
const c = @cImport({
    @cInclude("SDL.h");
});

const overlaps = c.SDL_HasIntersection;

const WINDOW_HEIGHT: usize = 800;
const WINDOW_WIDTH: usize = 800;

const SDL_WINDOWPOS_UNDEFINED = @bitCast(c_int, c.SDL_WINDOWPOS_UNDEFINED_MASK);

extern fn SDL_PollEvent(event: *c.SDL_Event) c_int;

const SDL_INIT_EVERYTHING =
    c.SDL_INIT_TIMER |
    c.SDL_INIT_AUDIO |
    c.SDL_INIT_VIDEO |
    c.SDL_INIT_EVENTS |
    c.SDL_INIT_JOYSTICK |
    c.SDL_INIT_HAPTIC |
    c.SDL_INIT_GAMECONTROLLER;

pub fn main() anyerror!void {
    if (c.SDL_Init(SDL_INIT_EVERYTHING) != 0) {
        c.SDL_Log("Unable to initialize SDL: %s", c.SDL_GetError());
        return error.SDLInitializationFailed;
    }
    defer c.SDL_Quit();

    const window = c.SDL_CreateWindow("My Game Window", c.SDL_WINDOWPOS_UNDEFINED, c.SDL_WINDOWPOS_UNDEFINED, WINDOW_HEIGHT, WINDOW_WIDTH, c.SDL_WINDOW_OPENGL) orelse
        {
        c.SDL_Log("Unable to create window: %s", c.SDL_GetError());
        return error.SDLInitializationFailed;
    };
    defer c.SDL_DestroyWindow(window);

    const renderer = c.SDL_CreateRenderer(window, -1, c.SDL_RENDERER_ACCELERATED);

    var frame: usize = 0;

    var mouse_left_pressed = false;
    var mouse_right_pressed = false;

    mainloop: while (true) {
        var event: c.SDL_Event = undefined;
        while (c.SDL_PollEvent(&event) != 0) {
            switch (event.@"type") {
                c.SDL_QUIT => break :mainloop,

                c.SDL_MOUSEBUTTONUP => {
                    if (event.button.button == c.SDL_BUTTON_LEFT) {
                        mouse_left_pressed = false;
                    } else if (event.button.button == c.SDL_BUTTON_RIGHT) {
                        mouse_right_pressed = false;
                    }
                },
                else => {},
            }
        }

        _ = c.SDL_RenderClear(renderer);
        _ = c.SDL_RenderCopy(renderer, zig_texture, null, null);

        c.SDL_RenderPresent(renderer);

        c.SDL_Delay(17);

        // _ = c.SDL_SetRenderDrawColor(renderer, 0xff, 0xff, 0xff, 0xff);
        // _ = c.SDL_RenderClear(renderer);
        // var rect = c.SDL_Rect{ .x = 0, .y = 0, .w = 60, .h = 60 };
        // const a = 0.06 * @intToFloat(f32, frame);
        // const t = 2 * std.math.pi / 3.0;
        // const r = 100 * @cos(0.1 * a);
        // rect.x = 290 + @floatToInt(i32, r * @cos(a));
        // rect.y = 170 + @floatToInt(i32, r * @sin(a));
        // _ = c.SDL_SetRenderDrawColor(renderer, 0xff, 0, 0, 0xff);
        // _ = c.SDL_RenderFillRect(renderer, &rect);
        // rect.x = 290 + @floatToInt(i32, r * @cos(a + t));
        // rect.y = 170 + @floatToInt(i32, r * @sin(a + t));
        // _ = c.SDL_SetRenderDrawColor(renderer, 0, 0xff, 0, 0xff);
        // _ = c.SDL_RenderFillRect(renderer, &rect);
        // rect.x = 290 + @floatToInt(i32, r * @cos(a + 2 * t));
        // rect.y = 170 + @floatToInt(i32, r * @sin(a + 2 * t));
        // _ = c.SDL_SetRenderDrawColor(renderer, 0, 0, 0xff, 0xff);
        // _ = c.SDL_RenderFillRect(renderer, &rect);
        // c.SDL_RenderPresent(renderer);
        // frame += 1;
    }
}
