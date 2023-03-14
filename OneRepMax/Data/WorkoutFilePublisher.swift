//
//  WorkoutFilePublisher.swift
//  OneRepMax
//
//  Created by Cliff Chen on 3/12/23.
//

import Foundation
import Combine

struct WorkoutFilePublisher: Publisher {
    typealias Output = String

    typealias Failure = Error

    let fileName: String
    let fileType: String
    let simulateLatency: Bool

    func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
        guard let subscription = WorkoutFileSubscription(fileName: fileName,
                                                         fileType: fileType,
                                                         subscriber: subscriber,
                                                         simulateLatency: simulateLatency) else {
            return
        }

        subscriber.receive(subscription: subscription)
    }
}
