//
//  PersonalRecordForExercise.swift
//  OneRepMax
//
//  Created by Cliff Chen on 3/10/23.
//

import SwiftUI

class PersonalRecordForExercise: ObservableObject {
    let name: String
    var oneRepMax: Int {
        history.max(by: { $0.oneRepMax < $1.oneRepMax })?.oneRepMax ?? 0
    }
    @Published var history = [PersonalRecordForDate]()
    
    init(name: String) {
        self.name = name
    }
}
