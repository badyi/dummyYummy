//
//  SimpleCancelation.swift
//  dummyYummyTests
//
//  Created by badyi on 17.07.2021.
//

@testable import dummyYummy

class SimpleCancellation: CancellationProtocol {
    var isCanceled = false

    func cancel() {
        isCanceled = true
    }
}
