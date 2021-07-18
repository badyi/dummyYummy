//
//  TestFileSystemService.swift
//  dummyYummyTests
//
//  Created by badyi on 18.07.2021.
//

import XCTest
import UIKit
@testable import dummyYummy

class TestFileSystemService: XCTestCase {
    var sut: FileSystemServiceProtocol!
    var image = "🤪".image()
    
    override func setUp() {
        super.setUp()
        sut = FileSystemService()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testStoreImage() {
        var statusResult = ""
        let imageData = image!.pngData()!
        
        let expectation = self.expectation(description: "store image")
        sut.store(imageData: imageData, forKey: "imageTest", completionStatus: { status in
            switch status {
            case let .success(status):
                statusResult = status
            case let .failure(error):
                XCTAssertNotNil(error, "cant't be error in this case")
            }
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertEqual(statusResult, "operation successful")
        
        deleteAllImages()
        
        let expectation2 = self.expectation(description: "store image")
        sut.store(imageData: imageData, forKey: "'/\\/////\\;d'/\\\"/", completionStatus: { status in
            switch status {
            case .success(_):
                XCTFail("can't be success")
            case let .failure(error):
                XCTAssertNotNil(error)
            }
            expectation2.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testDeleteImage() {
        let imageData = image!.pngData()!
        let imageKey = "image key"
        var statusResult = ""
        
        /// store image to system
        let expectation = self.expectation(description: "store image")
        sut.store(imageData: imageData, forKey: imageKey, completionStatus: { status in
            switch status {
            case let .success(status):
                statusResult = status
            case .failure(_):
                XCTFail("cant't be error in this case")
            }
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertEqual(statusResult, "operation successful")
        
        let expectation2 = self.expectation(description: "delete image")
        
        sut.delete(forKey: imageKey, completionStatus: { status in
            switch status {
            case let .success(status):
                statusResult = status
            case let .failure(error):
                XCTAssertNotNil(error, "cant't be error in this case")
            }
            expectation2.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(statusResult, "operation successful")
        
        let searchForDeletedImage = sut.retrieveImageData(forKey: imageKey)
        
        XCTAssertNil(searchForDeletedImage, "should be nil")
        
        let expectation3 = self.expectation(description: "delete non-existent image")
        
        sut.delete(forKey: imageKey, completionStatus: { status in
            switch status {
            case .success(_):
                XCTFail("can't be success")
            case let .failure(error):
                XCTAssertNotNil(error)
            }
            expectation3.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testRetriveImage() {
        let imageData = image!.pngData()!
        let imageKey = "image key"
        var statusResult = ""
       
        /// store image to system
        let expectation = self.expectation(description: "store image")
        sut.store(imageData: imageData, forKey: imageKey, completionStatus: { status in
            switch status {
            case let .success(status):
                statusResult = status
            case let .failure(error):
                XCTAssertNotNil(error, "cant't be error in this case")
            }
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertEqual(statusResult, "operation successful")
        
        let storedImageData = sut.retrieveImageData(forKey: imageKey)
        XCTAssertNotNil(storedImageData)
        XCTAssertNotNil(UIImage(data: storedImageData!), "shoudn't be nil")
        deleteAllImages()
    }
}

extension TestFileSystemService {
    func deleteAllImages() {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURLs = try! FileManager.default.contentsOfDirectory(at: documentsUrl,
                                                                       includingPropertiesForKeys: nil,
                                                                       options: .skipsHiddenFiles)
        for fileURL in fileURLs {
            if fileURL.pathExtension == ".png" {
                try! FileManager.default.removeItem(at: fileURL)
            }
        }
    }

}

fileprivate extension String {
    func image(fontSize:CGFloat = 40, bgColor:UIColor = UIColor.clear, imageSize:CGSize? = nil) -> UIImage? {
        let font = UIFont.systemFont(ofSize: fontSize)
        let attributes = [NSAttributedString.Key.font: font]
        let imageSize = imageSize ?? self.size(withAttributes: attributes)

        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
        bgColor.set()
        let rect = CGRect(origin: .zero, size: imageSize)
        UIRectFill(rect)
        self.draw(in: rect, withAttributes: [.font: font])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
