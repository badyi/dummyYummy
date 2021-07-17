//
//  FileService.swift
//  dummyYummy
//
//  Created by badyi on 14.07.2021.
//

import UIKit

protocol FileSystemServiceProtocol {
    
    /// Store image data by key
    /// - Parameters:
    ///   - imageData: image in data representation
    ///   - key: the unique key to create a unique path
    func store(imageData: Data, forKey key: String)
    
    /// Retrive image from file system
    /// - Parameter key: the unique key that was used to store the image data
    func retrieveImageData(forKey key: String) -> Data?
    
    /// Delete image data from file system
    /// - Parameter key: the unique key that was used to store the image data
    func delete(forKey key: String)
}

final class FileSystemService {
    let writeQueue = DispatchQueue(label: "fileSystemServiceBackground", qos: .userInitiated, attributes: .concurrent, autoreleaseFrequency: .workItem, target: nil)
}

extension FileSystemService: FileSystemServiceProtocol {
    func store(imageData: Data, forKey key: String) {
        writeQueue.async { [weak self] in
            if let filePath = self?.filePath(forKey: key) {
                do  {
                    try imageData.write(to: filePath,
                                                options: .atomic)
                } catch {
                    #warning("handle error")
                    fatalError("cant write image")
                }
            }
        }
    }
    
    func delete(forKey key: String) {
        writeQueue.async { [weak self] in
            if let filePath = self?.filePath(forKey: key) {
                do {
                    try FileManager.default.removeItem(atPath: filePath.path)
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func retrieveImageData(forKey key: String) -> Data? {
        if let filePath = self.filePath(forKey: key),
            let fileData = FileManager.default.contents(atPath: filePath.path) {
            return fileData
        }
        return nil
    }
}

private extension FileSystemService {
    private func filePath(forKey key: String) -> URL? {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory,
                                                in: .userDomainMask).first else { return nil }
        
        return documentURL.appendingPathComponent(key + ".png")
    }
}
