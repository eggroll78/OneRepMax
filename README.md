#  One Rep Max App

This app takes in a data file containing one's workout history and displays the max 1RM per exercise.

In the `OneRepMaxApp` file, the `FileWorkoutLoader` class can be configured to simulate real time updates by
setting the `simulateLatency` parameter to `true`.

```
let workoutLoader = FileWorkoutLoader(fileName: "workoutData",
                                      fileType: "txt",
                                      simulateLatency: true

```
