//
//  HttpMethod.swift
//  dummyYummy
//
//  Created by badyi on 13.06.2021.
//

import Foundation

public enum HttpMethod<T> {
    case get
    case post(T)
}

extension HttpMethod {
    var stringValue: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        }
    }

    /// Маппер одного типа тела в другой
    ///
    /// - Parameter f: функция трансляции типа Body в тип B
    /// - Returns: возвращает HttpMethod с новым типом B
    func map<B>(transform: (T) -> B) -> HttpMethod<B> {
        switch self {
        case .get:
            return .get
        case .post(let body):
            return .post(transform(body))
        }
    }
}
