//
//  FakeReachability.swift
//  dummyYummy
//
//  Created by badyi on 13.06.2021.
//

import Foundation
import Network

final class Reachability: ReachabilityProtocol {
    var isReachable: Bool = false
    let monitor: NWPathMonitor
    let queue = DispatchQueue(label: "Monitor")

    init() {
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
