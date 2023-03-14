//
//  OneRepMaxList.swift
//  OneRepMax
//
//  Created by Cliff Chen on 3/9/23.
//

import SwiftUI

struct OneRepMaxList: View {
    @ObservedObject var store: OneRepMaxStore
    var body: some View {
        NavigationView {
            List(store.oneRepMaxForExercise, id: \.name) { exercise in
                NavigationLink(destination: OneRepMaxDetails(exercise: exercise)) {
                    OneRepMaxCard(exercise: exercise)
                }
            }
        }
    }
}

struct OneRepMaxList_Previews: PreviewProvider {
    static var previews: some View {
        let workoutLoader = FileWorkoutLoader(fileName: "workoutData",
                                              fileType: "txt",
                                              simulateLatency: false
        )
        let formula = BrzyckiOneRepMaxFormula()
        let store = OneRepMaxStore(dataSource: workoutLoader,
                                   formula: formula)
        return OneRepMaxList(store: store)
            .task {
                store.compute()
            }
    }    
}
