//
//  MediaTest.swift
//  MVVMTests
//
//  Created by Csongor G. Korosi on 05/12/2018.
//  Copyright © 2018 BrotherSoft. All rights reserved.
//

import XCTest

class MediaTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInit() {
        let media = Media(imageURL: nil, previewURL: nil)
        XCTAssertNotNil(media)
        XCTAssertNil(media.imageURL)
        XCTAssertNil(media.previewURL)
        XCTAssertNil(media.image)
    }
    
    func testProperties() {
        let media = Media(imageURL: URL(string: "https://www.google.com"), previewURL: URL(string: "https://www.google.com"))
        XCTAssertEqual(media.imageURL?.absoluteString, "https://www.google.com")
        XCTAssertEqual(media.imageURL?.absoluteString, "https://www.google.com")
        XCTAssertNil(media.image)
    }
}
