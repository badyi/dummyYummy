//
//  CancelationProtocol.swift
//  dummyYummy
//
//  Created by badyi on 19.06.2021.
//

import Foundation

/// Протокол отмены операций
public protocol Cancellation {
    // Функция отмены запроса
    func cancel()
}

// URLSessionTask(метод cancel() уже есть)
// MARK: - Cancellation
extension URLSessionTask: Cancellation {
}
