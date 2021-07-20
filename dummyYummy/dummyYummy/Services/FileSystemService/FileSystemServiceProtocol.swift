//
//  FileSystemServiceProtocol.swift
//  dummyYummy
//
//  Created by badyi on 18.07.2021.
//

import Foundation

protocol FileSystemServiceProtocol {

    /// Store image data by key
    /// - Parameters:
    ///   - imageData: image in data representation
    ///   - key: the unique key to create a unique path
    ///   - completionStatus: status of operation
    func store(imageData: Data, forKey key: String, completionStatus: ((FileOperationCompletion) -> Void)?)

    /// Retrive image from file system
    /// - Parameter key: the unique key that was used to store the image data
    func retrieveImageData(forKey key: String) -> Data?

    /// Delete image data from file system
    /// - Parameter key: the unique key that was used to store the image data
    ///   - completionStatus: status of operation
    func delete(forKey key: String, completionStatus: ((FileOperationCompletion) -> Void)?)
}
