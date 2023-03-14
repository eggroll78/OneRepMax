//
//  OneRepMaxFormula.swift
//  OneRepMax
//
//  Created by Cliff Chen on 3/10/23.
//

import Foundation

protocol OneRepMaxFormula {
    func calculateFor(weight: Int, reps: Int) -> Int
}

struct BrzyckiOneRepMaxFormula: OneRepMaxFormula {
    func calculateFor(weight: Int, reps: Int) -> Int {
        weight * (36 / (37 - reps))
    }
}
