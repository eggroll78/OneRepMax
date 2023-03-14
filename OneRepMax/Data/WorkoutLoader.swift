//
//  WorkoutLoader.swift
//  OneRepMax
//
//  Created by Cliff Chen on 3/9/23.
//

import Foundation
import Combine


protocol WorkoutLoader {
//    func load() async -> [Workout]
    func load() -> AnyPublisher<Workout, Error>
}

/* In a real world scenario we'd load from persistence layer or network
struct NetworkWorkoutLoader: WorkoutLoaderProtocol {
    func load() -> AnyPublisher<Workout, Error> {

    }
}
 */

// Loads workouts from file. Could be a super large file so
// let's load line by line.
struct FileWorkoutLoader: WorkoutLoader {
    let parser = WorkoutParser()
    let fileName: String
    let fileType: String
    let simulateLatency: Bool

    func load() -> AnyPublisher<Workout, Error> {
        return WorkoutFilePublisher(fileName: fileName, fileType: fileType, simulateLatency: simulateLatency)
            .compactMap {
                parser.parse($0)
            }
            .eraseToAnyPublisher()
    }

}
