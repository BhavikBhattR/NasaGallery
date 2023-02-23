//
//  DataService_tests.swift
//  NasaGalleryTests
//
//  Created by Bhavik Bhatt on 23/02/23.
//

import XCTest
@testable import NasaGallery
import Combine

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
            XCTAssertThrowsError(try dataService.handleResponse(data: data, response: response))
        }
    }
}
