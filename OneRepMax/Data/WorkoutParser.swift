//
//  WorkoutParser.swift
//  OneRepMax
//
//  Created by Cliff Chen on 3/9/23.
//

import Foundation
import RegexBuilder

class WorkoutParser {
    /// Sample data: Oct 05 2020,Barbell Bench Press,1,2,225
    let workoutMatcher = Regex {
        // Date
        Capture {
            One(.date(format: "\(month: .abbreviated) \(day: .twoDigits) \(year: .defaultDigits)",
                              locale: Locale(languageCode: .english, languageRegion: .unitedStates),
                              timeZone: TimeZone(identifier: "PST")!))
        }
        One(",")
        // Exercise
        TryCapture {
            /[\w\s]+/
        } transform: {
            String($0)
        }
        One(",")
        // sets
        TryCapture {
            OneOrMore(.digit)
        } transform: {
            Int($0)
        }
        One(",")
        // Reps
        TryCapture {
            OneOrMore(.digit)
        } transform: {
            Int($0)
        }
        One(",")
        // Weight
        TryCapture {
            OneOrMore(.digit)
        } transform: {
            Int($0)
        }
    }

    init() {
    }

    func parse(_ line: String) -> Workout? {
        guard let matches = try? workoutMatcher.wholeMatch(in: line) else { return nil }

        return Workout(date: matches.1,
                       exerciseName: matches.2,
                       sets: matches.3,
                       reps: matches.4,
                       weight: matches.5)
    }
}
