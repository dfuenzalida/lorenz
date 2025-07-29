# Lorenz attractor toy

A simple [Lorenz attractor](https://en.wikipedia.org/wiki/Lorenz_system) interactive toy written in Janet using the Raylib bindings for Janet.

## Building from source

* [Install Janet](https://janet-lang.org/docs/index.html)
* [Install JPM](https://janet-lang.org/docs/jpm.html)

On Linux, the following libraries are required to use RayLib: `libxcursor-dev`, `libxrandr-dev`, `libxinerama-dev` and `libxi-dev`. On Debian you can install them with `sudo apt install libxcursor-dev libxrandr-dev libxinerama-dev libxi-dev`.

* [Install Jaylib](https://github.com/janet-lang/jaylib)

Finally, build with: `jpm build` and launch the program with `./build/lorenz`

## Interactive options

* Move the camera with the mouse
* `ESC` closes the application
* `1` and `2` slow down/speed up the animation
* `R` to randomize (reset) the particles to a random location
* `F` toggles the FPS display
* `D` changes between the particle display modes (points, lines, cubes, etc.)
  * Holding `C` does the same, but quickly
* `M` toggles the mouse cursor
* `P` changes the color palette
* `O` cycles fast through the color palettes

# Other interesting chaotic maps

* https://en.wikipedia.org/wiki/Bogdanov_map
* https://en.wikipedia.org/wiki/Duffing_map
* https://en.wikipedia.org/wiki/R%C3%B6ssler_attractor
