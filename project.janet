(declare-project
  :name "lorenz"
  :description "Lorenz attractor simulation"
  :dependencies [
    "https://github.com/janet-lang/jaylib.git" # Raylib bindings for Janet
    ])

(declare-executable
  :name "lorenz"
  :entry "lorenz.janet")
