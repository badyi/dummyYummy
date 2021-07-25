//
//  FakeReachability.swift
//  dummyYummy
//
//  Created by badyi on 13.06.2021.
//

import Foundation
import Network

final class Reachability: ReachabilityProtocol {
    private(set) var isReachable: Bool
    private let monitor: NWPathMonitor
    private let queue: DispatchQueue

    init() {
        isReachable = false
        queue = DispatchQueue(label: "Monitor")
        monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                self?.isReachable = true
            } else {
                self?.isReachable = false
            }
        }

        monitor.start(queue: queue)
    }
}
