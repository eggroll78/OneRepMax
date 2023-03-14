//
//  PersonalRecordForDate.swift
//  OneRepMax
//
//  Created by Cliff Chen on 3/12/23.
//

import Foundation

class PersonalRecordForDate: ObservableObject {
    let date: Date
    @Published var oneRepMax: Int

    init(date: Date, oneRepMax: Int) {
        self.date = date
        self.oneRepMax = oneRepMax
    }
}
