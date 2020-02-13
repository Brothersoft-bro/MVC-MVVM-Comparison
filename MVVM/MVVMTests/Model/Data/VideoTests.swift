//
//  VideoTests.swift
//  MVVMTests
//
//  Created by Csongor G. Korosi on 05/12/2018.
//  Copyright © 2018 BrotherSoft. All rights reserved.
//

import XCTest

class VideoTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDesignitadInitializer1() {
        let video = Video(imageURL: URL(string: ""), previewURL: URL(string: ""))
        
        XCTAssertNotNil(video)
        XCTAssertNil(video.previewURL)
        XCTAssertNil(video.imageURL)
        XCTAssertNil(video.image)
        XCTAssertNil(video.title)
        XCTAssertNil(video.details)
    }
    
    func testDesignitadInitializer2() {
        let video = Video(imageURL: URL(string: ""), previewURL: URL(string: ""))

        XCTAssertNotNil(video)
        XCTAssertNil(video.previewURL)
        XCTAssertNil(video.imageURL)
        XCTAssertNil(video.image)
        XCTAssertNil(video.title)
        XCTAssertNil(video.details)
    }
    
    func testConvinienceInitializer() {
        let video = Video(title: "8 Mile", details: "Cool movie", imageURL: nil, previewURL: nil)
        
        XCTAssertNotNil(video)
        XCTAssertNil(video.imageURL)
        XCTAssertNil(video.previewURL)
        XCTAssertNil(video.image)
        XCTAssertEqual(video.title, "8 Mile")
        XCTAssertEqual(video.details, "Cool movie")
    }
}
