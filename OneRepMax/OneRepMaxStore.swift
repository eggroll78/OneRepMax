//
//  OneRepMaxStore.swift
//  OneRepMax
//
//  Created by Cliff Chen on 3/10/23.
//

import Foundation
import Combine

class OneRepMaxStore: ObservableObject {
    @Published var oneRepMaxForExercise = [PersonalRecordForExercise]()

    let dataSource: WorkoutLoader
    let formula: OneRepMaxFormula
    let simulateLatency: Bool
    var cancellable = [AnyCancellable]()

    init(dataSource: WorkoutLoader,
         formula: OneRepMaxFormula,
         simulateLatency: Bool = true) {
        self.dataSource = dataSource
        self.formula = formula
        self.simulateLatency = simulateLatency
    }

    /// Triggers the async task to load and calculate the workout data
    func compute() {
        dataSource.load()
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink { _ in } receiveValue: { workout in
                self.update(with: workout)
            }
            .store(in: &cancellable)
    }

    private func update(with workout: Workout)  {
        let exercise: PersonalRecordForExercise
        // First find the exercise we want to update or create new
        if let existingExercise = oneRepMaxForExercise.first(where: { $0.name == workout.exerciseName }) {
            exercise = existingExercise
        } else {
            exercise = PersonalRecordForExercise(name: workout.exerciseName)
            oneRepMaxForExercise.append(exercise)
        }

        // Now find the date of the exercise to see if we have a new personal record.
        let newOneRepMax = formula.calculateFor(weight: workout.weight, reps: workout.reps)
        if let oneRepMaxForDate = exercise.history.first(where: { $0.date == workout.date }) {
            if oneRepMaxForDate.oneRepMax < newOneRepMax {
                oneRepMaxForDate.oneRepMax = newOneRepMax
            }
        } else {
            exercise.history.append(PersonalRecordForDate(date: workout.date, oneRepMax: newOneRepMax))
        }
    }
}
