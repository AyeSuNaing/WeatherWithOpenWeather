//
//  WeatherwithOpenWeatherMapTests.swift
//  WeatherwithOpenWeatherMapTests
//
//  Created by Brycen on 12/4/23.
//

import XCTest
@testable import WeatherwithOpenWeatherMap

final class WeatherwithOpenWeatherMapTests: XCTestCase {

    var viewController: ViewController!

   
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
    viewController = storyboard.instantiateViewController(withIdentifier: ViewController.identifier) as? ViewController
        viewController.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewController = nil
        super.tearDown()
    }

    func testSetupCollectionView() {
            // Perform any setup necessary for collection view
            viewController.setupCollectionView()
            // Assert that collection view is not nil and delegate/datasource are set
            XCTAssertNotNil(viewController.collectionView)
            XCTAssertNotNil(viewController.collectionView.delegate)
            XCTAssertNotNil(viewController.collectionView.dataSource)
        }

        func testSetupSearchView() {
            // Perform any setup necessary for search view
            viewController.setupSearchView()
            // Assert that tap gesture is added and user interaction is enabled
            XCTAssertNotNil(viewController.searchView.gestureRecognizers)
            XCTAssertTrue(viewController.searchView.isUserInteractionEnabled)
        }

        func testSearchViewTapped() {
            // Ensure the method is called without crashing
            viewController.searchViewTapped()
            // Add assertions if necessary
        }

        func testHandleItemSelected() {
            let latitude = 37.7749
            let longitude = -122.4194

            // Ensure the method is called without crashing
            viewController.handleItemSelected(latitude: latitude, longitude: longitude)
            // Add assertions if necessary
            XCTAssertEqual(viewController.selectedLatitude, latitude)
            XCTAssertEqual(viewController.selectedLongitude, longitude)
        }

        // Add more tests as needed for other methods and functionalities

        // Example of asynchronous testing
        func testBindViewModel() {
            let expectation = XCTestExpectation(description: "ViewModel binding")

            // Assuming you have some async operations in bindViewModel
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                // Fulfill the expectation after the async operation is completed
                expectation.fulfill()
            }

            wait(for: [expectation], timeout: 6.0) // Adjust the timeout as needed
        }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
