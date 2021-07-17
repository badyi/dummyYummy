//
//  FakeNetworking.swift
//  dummyYummyTests
//
//  Created by badyi on 17.07.2021.
//

import Foundation
@testable import dummyYummy

class FakeNetworking: Networking {
    func execute<A>(_ resource: Resource<A>, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> Cancellation? {
        if A.self == SuccessResponse.self {
            let jsonDict = ["id": "one"]
            let json = try! JSONEncoder().encode(jsonDict)
            completionHandler(json, nil, nil)
        } else if A.self == Data.self {
            completionHandler(Data(), nil, NSError(domain: "Fake", code: 1, userInfo: nil))
        } else if A.self == Int.self {
            completionHandler(Data(), nil, nil)
        } else {
            completionHandler(nil, nil, NSError(domain: "Fake", code: 1, userInfo: nil))
        }
        return nil
    }
}

struct SuccessResponse: Codable {
    let id: String
}

class ResourceFactory {
    static let successEncoded = Resource<SuccessResponse>(url: URL(fileURLWithPath: "success"), headers: nil)
    static let failure = Resource<String>(url: URL(fileURLWithPath: "failure"), headers: nil)
    static let failureWithData = Resource<Data>(url: URL(fileURLWithPath: "failureWithData"), headers: nil)
    static let parseFailure = Resource<Int>(url: URL(fileURLWithPath: "parseFailure"), method: .get, parse: { _ in throw NSError(domain: "Fake parse", code: 0, userInfo: nil) })
}
