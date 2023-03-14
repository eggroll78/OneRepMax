//
//  WorkoutFileSubscription.swift
//  OneRepMax
//
//  Created by Cliff Chen on 3/12/23.
//

import Foundation
import Combine

class WorkoutFileSubscription<S: Subscriber>: Subscription
    where S.Input == String, S.Failure == Error {

    private let filePath: String
    private var subscriber: S?
    private let simulateLatency: Bool

    init?(fileName: String, fileType: String, subscriber: S, simulateLatency: Bool) {
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: fileType) else {
            return nil
        }
        self.simulateLatency = simulateLatency
        self.filePath = filePath
        self.subscriber = subscriber
    }

    func request(_ demand: Subscribers.Demand) {
        guard demand > 0 else { return }

        guard let file = freopen(filePath, "r", stdin) else { return  }

        defer {
            fclose(file)
        }
        while let line = readLine() {
            _ = subscriber?.receive(line)

            // Simulates latency
            if simulateLatency {
                usleep(20000)
            }
        }

        subscriber?.receive(completion: .finished)
    }

    func cancel() {
        subscriber = nil
    }
}
