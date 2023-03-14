//
//  OneRepMaxCard.swift
//  OneRepMax
//
//  Created by Cliff Chen on 3/11/23.
//

import SwiftUI

struct OneRepMaxCard: View {
    @ObservedObject var exercise: PersonalRecordForExercise

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(exercise.name)
                    .font(.title)
                    .fontWeight(.bold)
                Text("One Rep Max • lbs")
            }
            Spacer()
            Text("\(exercise.oneRepMax)")
                .font(.title)
        }
    }
}

struct ExerciseSummaryCard_Previews: PreviewProvider {
    static var previews: some View {
        let now = Date()
        let testData = PersonalRecordForExercise(name: "Barbell Bench Press")
        testData.history = [
            PersonalRecordForDate(date: now, oneRepMax: 50),
            PersonalRecordForDate(date: now.addingTimeInterval(1), oneRepMax: 150)
        ]
        return List(1..<10) { _ in
            OneRepMaxCard(exercise: testData)
        }
    }
}
