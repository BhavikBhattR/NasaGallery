//
//  DataService_tests.swift
//  NasaGalleryTests
//
//  Created by Bhavik Bhatt on 23/02/23.
//

import XCTest
@testable import NasaGallery
import Combine
import SwiftUI

/* naming structure of the function : test_[struct or class]_[var or function]_[value of var or result of a function]
  In naming structure:
  1. test denotes test
  2. struct or class is of that function/variable we want to test
  3. var or function we want to check on
  4. at last, what should be the value of variable after some action (ex. After running a function)
  
  Testing structure : Given, When, Then
  Given denotes, current state
  When denotes, our actions
  Then denotes, expected output of those actions
 */

// Here we are testing the data service function, so if any unexpected output appears, to find out what kind of problem really occured, custom error for each problem is thrown, so other developer while testing can find out what really went wrong

final class DataService_tests: XCTestCase {
    var correctURL: URL? = URL(string: "https://raw.githubusercontent.com/obvious/take-home-exercise-data/trunk/nasa-pictures.json")
    
    var anyCancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        anyCancellables.removeAll()
    }

    
    // Purpose: To check if we are handling the response properly or not by throwing an error if the returned data is nil via handleResponse function. HERE DUMMY DATA AND RESPONSE ARE CREATED
    func test_DataService_handleResponse_mustThrowErrorIfDataIsNil(){
        if let correctURL = correctURL{
            //Given
            let dataService = ProductionDataService(url: correctURL)
            
            //When
            let data: Data? = nil
            let response = URLResponse()
            
            //Then
            do{
                let _ = try dataService.handleResponse(data: data, response: response)
            }catch let error{
                let returnedError = error as? Errors
                XCTAssertEqual(returnedError, Errors.returnedDataIsNil)
            }
            XCTAssertThrowsError(try dataService.handleResponse(data: data, response: response))
        }
    }
    
    // Purpose: To check if we are handling the response properly or not by throwing an error if the response is not HTTPURLResponse via handleResponse function. HERE DUMMY DATA AND RESPONSE ARE CREATED
    func test_DataService_handleResponse_mustThrowErrorIfResponseIsNotHTTPURLResponse(){
        if let correctURL = correctURL{
            //Given
            let dataService = ProductionDataService(url: correctURL)
            
            //When
            let data: Data = Data()
            let response = URLResponse()
            
            //Then
            do{
                let _ = try dataService.handleResponse(data: data, response: response)
            }catch let error{
                let returnedError = error as? Errors
                XCTAssertEqual(returnedError, Errors.responseIsNotHTTPURL)
            }
            XCTAssertThrowsError(try dataService.handleResponse(data: data, response: response))
        }
    }

   // Purpose: To know exactly, what is causing the data service to fail. If all the above test cases are true than developer can just run this below code and know the exact problem.
    func test_dataService_handleResponse_DoNotThrowErrorIfDataServiceIsCorrect(){
        if let correctURL = correctURL{
            let dataService = ProductionDataService(url: correctURL)
            var error_: Error? = nil
            let expectation = XCTestExpectation(description: "waiting for the data")
           URLSession.shared.dataTaskPublisher(for: correctURL)
                .tryMap(dataService.handleResponse)
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion{
                    case .finished:
                        break
                    case .failure(let error):
                        error_ = error
                        expectation.fulfill()
                    }
                } receiveValue: { output in
                    expectation.fulfill()
                }
                .store(in: &anyCancellables)
            
            wait(for: [expectation], timeout: 10)
            if let error_ = error_ {
                let returnedError = error_ as? Errors
                if returnedError == Errors.dataCouldNotBeDecoded{
                    XCTFail("Decoding of data is not done properly")
                }else if returnedError == Errors.returnedDataIsNil{
                    XCTFail("Data is not found in response")
                }else if returnedError == Errors.responseIsNotHTTPURL{
                    XCTFail("Response received is not HTTPURL")
                }else{
                    XCTFail("Bad server response")
                }
            }
        }
    }
    
}
