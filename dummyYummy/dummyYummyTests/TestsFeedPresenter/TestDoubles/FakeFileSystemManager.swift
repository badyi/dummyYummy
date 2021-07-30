//
//  FakeFileSystemManager.swift
//  dummyYummyTests
//
//  Created by badyi on 28.07.2021.
//

import Foundation

final class FakeFileSystemService: FileSystemServiceProtocol {
    var images: [String: Data] = [:]

    func store(imageData: Data, forKey key: String, completionStatus: ((FileOperationCompletion) -> Void)?) {
        images[key] = imageData
        completionStatus?(.success("operation successful"))
    }

    func retrieveImageData(forKey key: String) -> Data? {
        return images[key]
    }

    func delete(forKey key: String, completionStatus: ((FileOperationCompletion) -> Void)?) {
        images[key] = nil
    }
}
