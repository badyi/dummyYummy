//
//  CancelationProtocol.swift
//  dummyYummy
//
//  Created by badyi on 19.06.2021.
//

import Foundation

/// Протокол отмены операций
public protocol CancellationProtocol {
    // Функция отмены запроса
    func cancel()
}

// URLSessionTask(there is already a cancel () method)
// MARK: - CancellationProtocol
extension URLSessionTask: CancellationProtocol {
}
