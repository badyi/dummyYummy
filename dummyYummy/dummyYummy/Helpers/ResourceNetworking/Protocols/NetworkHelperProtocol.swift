//
//  NetworkHelperProtocol.swift
//  dummyYummy
//
//  Created by badyi on 13.06.2021.
//

import Foundation

/// Протокол для работы с сервером на основе ресурсов
protocol NetworkHelperProtocol: AnyObject {
    /// Метод загрузки данных на основе Resource(ресурс далее)
    ///
    /// - Parameters:
    ///   - resource: ресурс
    ///   - completion: результат выполнения операции
    /// - Returns: объект отмены операции загрузки данных
    func load<T>(resource: Resource<T>, completion: @escaping (OperationCompletion<T>) -> Void) -> Cancellation?
}
