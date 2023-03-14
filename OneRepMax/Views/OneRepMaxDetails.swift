//
//  OneRepMaxDetails.swift
//  OneRepMax
//
//  Created by Cliff Chen on 3/12/23.
//

import SwiftUI
import Charts

struct OneRepMaxDetails: View {
    @ObservedObject var exercise: PersonalRecordForExercise
    var body: some View {
        VStack(alignment: .leading) {
            OneRepMaxCard(exercise: exercise)
            Chart {
                ForEach(exercise.history, id: \.date) { item in
                    LineMark(x: .value("Date", item.date),
                             y: .value("lbs", item.oneRepMax)
                    )
                }
            }.frame(height: UIScreen.main.bounds.height/4)
            Spacer()
        }
        .padding()
    }
}

struct OneRepMaxDetails_Previews: PreviewProvider {
    static var previews: some View {
        let now = Date()
        let testData = PersonalRecordForExercise(name: "Barbell Bench Press")
        testData.history = [
            PersonalRecordForDate(date: now, oneRepMax: 50),
            PersonalRecordForDate(date: now.addingTimeInterval(86400), oneRepMax: 150),
            PersonalRecordForDate(date: now.addingTimeInterval(86400 * 2), oneRepMax: 75),
            PersonalRecordForDate(date: now.addingTimeInterval(86400 * 3), oneRepMax: 250),
            PersonalRecordForDate(date: now.addingTimeInterval(86400 * 4), oneRepMax: 25),
            PersonalRecordForDate(date: now.addingTimeInterval(86400 * 5), oneRepMax: 300)
        ]
        return OneRepMaxDetails(exercise: testData)
    }
}
