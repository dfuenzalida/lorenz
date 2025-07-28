(use jaylib)

### Lorenz Attractor

(def sigma 10.0)
(def rho 28.0)
(def beta (/ 8.0 3.0))
(var dt 0.005)

(def initial-range 60.0)

(defn rand-float []
  (- (/ initial-range 2) (* initial-range (math/random))))

(defn random-color []
  (let [r (math/floor (* 255 (math/random)))
        g (math/floor (* 255 (math/random)))
        b (math/floor (* 255 (math/random)))]
    [r g b]))

(defn next-lorenz [[x y z color]]
  @[(+ x (* dt (* sigma (- y x))))
    (+ y (* dt (- (* x (- rho z)) y)))
    (+ z (* dt (- (* x y) (* beta z))))
    color])

### Initialize the Lorenz attractor

# Initialize the points array
(def num-points 40_000)
(def points (array/new num-points))

(defn init-points []
  (for i 0 num-points
    (put points i @[(rand-float) (rand-float) (rand-float) (random-color)])))

### Main loop

(def height 800)
(def width (math/floor (/ (* height 16) 9)))
(var show-fps true)
(var drawing-mode 0) # draw points, circles, etc.
(var cursor-enabled? true)

(defn lorenz-loop []
  (init-window width height "Lorenz")
  (set-target-fps 60)
  (init-points)

  (while (not (window-should-close))

    # Handle keyboard input    
    (if (key-pressed? :r) (init-points)) # Randomize points with the 'R' key
    (if (key-pressed? :f) (set show-fps (not show-fps))) # Toggle FPS display with the 'F' key
    (if (key-pressed? :d) (set drawing-mode (mod (+ drawing-mode 1) 5))) # Cycle through drawing modes pressing the 'D' key
    (if (key-down? :c) (set drawing-mode (mod (+ drawing-mode 1) 5))) # Fast-cycle through drawing modes holding the 'C' key
    (if (key-pressed? :m) (set cursor-enabled? (not cursor-enabled?))) # Toggle the mouse cursor with the 'M' key
    (if (key-down? :1) (set dt (* 0.98 dt))) # Slow down the simulation with the '1' key
    (if (key-down? :2) (set dt (* 1.02 dt))) # Speed up the simulation with the '2' key

    # Show/hide the mouse cursor
    (if cursor-enabled? (show-cursor) (hide-cursor))

    (begin-drawing)

    (clear-background [0 0 0])
    (let [[mouse-x mouse-y] (get-mouse-position)]

      # Draw every point
      (def cam-pos @[ (* 20 (math/sin (* 0.01 mouse-x)))
                      (* 20 (math/sin (* 0.01 mouse-y)))
                      (+ -2 (* 0.4 mouse-y))])

      (def cam (camera-3d :target [0 0 0]
                          :up [0 1 0]
                          :fovy 60
                          :type :perspective
                          :position cam-pos))

      (begin-mode-3d cam)

      (for i 0 num-points
        (let [point (get points i)
              color (get point 3)]
          # Draw the point in the selected mode
          (case drawing-mode
            0 (draw-cube-wires point 0.1 0.1 0.1 color)
            1 (draw-circle-3d point 0.1 [0 0 0] 0 color)
            2 (draw-line-3d point [0 0 0] color)
            3 (draw-point-3d point color)
            4 (draw-sphere-wires point 0.1 2 2 color))

          (put points i (next-lorenz point)) # move the point
          ))

      (end-mode-3d)
    ) # end let

    # draw FPS
    (if (true? show-fps) (draw-fps 10 10))

    (end-drawing)) # end while

  (close-window)
)

### Entry point

(defn main
  [& args]
  (lorenz-loop))

# (main)
