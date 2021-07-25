//
//  SimpleCancelation.swift
//  dummyYummyTests
//
//  Created by badyi on 17.07.2021.
//

@testable import dummyYummy

class SimpleCancellation: Cancellation {
    var isCanceled = false

    func cancel() {
        isCanceled = true
    }
}
