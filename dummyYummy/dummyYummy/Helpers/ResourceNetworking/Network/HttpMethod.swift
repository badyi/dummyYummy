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

    /// Mapper of one body type to another
    ///
    /// - Parameter transform: function of transfrom from T type to B type
    /// - Returns: returns HttpMethod with new type B
    func map<B>(transform: (T) -> B) -> HttpMethod<B> {
        switch self {
        case .get:
            return .get
        case .post(let body):
            return .post(transform(body))
        }
    }
}
