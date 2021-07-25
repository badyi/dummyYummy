//
//  FakeReachability.swift
//  dummyYummyTests
//
//  Created by badyi on 17.07.2021.
//

import Foundation
@testable import dummyYummy

class FakeReachability: ReachabilityProtocol {
    var isReachable: Bool

    init(isReachable: Bool) {
        self.isReachable = isReachable
    }
}
