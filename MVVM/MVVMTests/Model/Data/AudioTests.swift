//
//  AudioTests.swift
//  MVVMTests
//
//  Created by Csongor G. Korosi on 05/12/2018.
//  Copyright © 2018 BrotherSoft. All rights reserved.
//

import XCTest

class AudioTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDesignitadInitializer1() {
        let audio = Audio(imageURL: URL(string: "https://www.google.com"), previewURL: URL(string: "https://www.google.com"))
        
        XCTAssertNotNil(audio)
        XCTAssertEqual(audio.imageURL?.absoluteString, "https://www.google.com")
        XCTAssertEqual(audio.previewURL?.absoluteString, "https://www.google.com")
        XCTAssertNil(audio.image)
        XCTAssertNil(audio.trackName)
        XCTAssertNil(audio.artistName)
    }

    func testDesignitadInitializer2() {
        let audio = Audio(imageURL: URL(string: ""), previewURL: URL(string: ""))
        
        XCTAssertNotNil(audio)
        XCTAssertNil(audio.previewURL)
        XCTAssertNil(audio.imageURL)
        XCTAssertNil(audio.image)
        XCTAssertNil(audio.trackName)
        XCTAssertNil(audio.artistName)
    }
    
    func testConvinienceInitializer() {
        let audio = Audio(trackName: "8 Mile", artistName: "Eminem", imageURL: URL(string: "https://www.google.com"), previewURL: URL(string: "https://www.google.com"))
        
        XCTAssertNotNil(audio)
        XCTAssertEqual(audio.imageURL?.absoluteString, "https://www.google.com")
        XCTAssertEqual(audio.previewURL?.absoluteString, "https://www.google.com")
        XCTAssertNil(audio.image)
        XCTAssertEqual(audio.trackName, "8 Mile")
        XCTAssertEqual(audio.trackName, "8 Mile")
    }
}
