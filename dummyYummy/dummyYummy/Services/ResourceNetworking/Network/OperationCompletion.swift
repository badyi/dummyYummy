//
//  OperationCompletion.swift
//  dummyYummy
//
//  Created by badyi on 13.06.2021.
//

import Foundation

public enum OperationCompletion<ResponseType> {
    case success(ResponseType)
    case failure(Error)
}
