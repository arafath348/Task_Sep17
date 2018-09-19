//
//  Task_Sep17Tests.swift
//  Task_Sep17Tests
//
//  Created by L-156157182 on 17/09/18.
//

import XCTest
import Alamofire
import SwiftyJSON
@testable import Task_Sep17

class Task_Sep17Tests: XCTestCase {
    
    let model = ApiService(rootUrl: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")

    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testModelEqual(){
        let dataModel = DataModel(title: "Apple", description: "Welcome to Apple", url: "https://www.apple.com/")
        let dataViewModel = DataViewModel(data: dataModel)
        XCTAssertEqual(dataViewModel.title, "Apple")
        XCTAssertEqual(dataViewModel.description, "Welcome to Google")
        XCTAssertEqual(dataViewModel.url, "https://www.apple.com/")
    }
  
    func testModelNotNil() {
        XCTAssertNotNil(model, "model is nil")
    }
    
    func testIsNew() {
        XCTAssertTrue(model.isNew(), "model should be new")
        model.data["id"] = "id1"
        XCTAssertFalse(model.isNew(), "model should not be new")
    }
    
    func testFetchNewModel() {
        let expectation = self.expectation(description: "fetch")
        
        model.fetch(
            success: {
                response in
                XCTAssertNotNil(self.model.data, "response is empty")
                XCTAssertNotEqual(self.model.data.arrayValue.count, 0, "collection is empty")
                expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 30.0, handler: nil)
    }
    
    func testFetchExistingModel() {
        let expectation = self.expectation(description: "fetch")
        
        model.data["id"] = "1"
        model.fetch(
            success: {
                response in
                XCTAssertNotNil(self.model.data, "response is empty")
                XCTAssertEqual(self.model.data.arrayValue.count, 0, "collection is not empty")
                expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 30.0, handler: nil)
    }


    func testErrorHandler() {
        let expectation = self.expectation(description: "error-handler")
        
        model.rootUrl = "http://fake-domain"
        model.fetch(
            error: {
                response in
                XCTAssertNotNil(response, "response is not empty")
                XCTAssertNotNil(response["error"], "response error is not empty")
                expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 30.0, handler: nil)
    }
    
    func testErrorWithResponse() {
        let expectation = self.expectation(description: "error-response-handler")
        model.rootUrl = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/"
        
        model.fetch(
            error: {
                response in
                XCTAssertNotNil(response, "response is not empty")
                XCTAssertNotNil(response["error"], "response is not empty")
                XCTAssertEqual(response["status"], 404, "status code is 404")
                expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 30.0, handler: nil)
    }
    
    
    
    
}
