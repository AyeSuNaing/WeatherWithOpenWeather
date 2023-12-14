//
//  WeatherwithOpenWeatherMapUITests.swift
//  WeatherwithOpenWeatherMapUITests
//
//  Created by Brycen on 12/4/23.
//

import XCTest

final class WeatherwithOpenWeatherMapUITests: XCTestCase {
    
    
    var app: XCUIApplication!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app = nil
    }
    
    func testTapSearchView() {
        // Tap on the search view
        
        let searchView = app.otherElements["SearchViewIdentifier1"]
        // Print the debug description before interacting with the element
        print("shwebhone \(app.debugDescription)")
        XCTAssert(searchView.exists)

        searchView.tap()

        let searchSwiftUIView = app.textFields["SearchSwiftUIViewIdentifier"]
        XCTAssertTrue(searchSwiftUIView.exists)
    }
    
    func testHandleItemSelection() {
        let latitude = "37.7749"
        let longitude = "-122.4194"
        
        let searchSwiftUIView = app.otherElements["SearchSwiftUIListIdentifier"]
        XCTAssertTrue(searchSwiftUIView.exists)
        
        
        searchSwiftUIView.tap()
        
        let latLongLabel = app.staticTexts["LatitudeLongitudeLabelIdentifier"]
        XCTAssertTrue(latLongLabel.exists)
        XCTAssertEqual(latLongLabel.label, "")
    }
    
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
