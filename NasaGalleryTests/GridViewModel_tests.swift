//
//  GridViewModel_tests.swift
//  NasaGalleryTests
//
//  Created by Bhavik Bhatt on 23/02/23.
//

import XCTest
@testable import NasaGallery
import Combine

/* naming structure of the function : test_[struct or class]_[var or function]_[value of var or result of a function]
 In naming structure:
  1. test denotes test
  2. struct or class is of that function/variable we want to test
  3. var or function we want to check on
  4. at last, what should be the value of variable after some action (ex. After running a function)
 */
/*Testing structure : Given, When, Then
  Given denotes, current state
  When denotes, our actions
  Then denotes, expected output of those actions
 */

final class GridViewModel_tests: XCTestCase {
    
    var anyCancellables = Set<AnyCancellable>()
    var correctURL: URL? = URL(string: "https://raw.githubusercontent.com/obvious/take-home-exercise-data/trunk/nasa-pictures.json")

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        anyCancellables.removeAll()
    }

    // Purpose: To check the array which is holding the image data must be empty when view model is initialised
    func test_gridViewModel_nasaImages_shouldBeEmptyWhenViewModelIsInitialised(){
        if let correctURL = correctURL{
            // Given
            //When
            let vm = GridViewModel(dataService: ProductionDataService(url: correctURL))
            //Then
            XCTAssertEqual(vm.nasaImages.count, 0)
        }
    }
    

    // Purpose: To check if returned images' data is getting stored in view model's published property nasaImages or not
    func test_gridViewModel_downloadImages_shouldReturnItems(){
        if let correctURL = correctURL{
            //Given
            let vm = GridViewModel(dataService: ProductionDataService(url: correctURL))
            
            //When
            let expectation = XCTestExpectation(description: "Waiting for images to get returned")
            vm.downloadNasaImages()
            vm.$nasaImages
                .dropFirst()
                .sink{ _ in
                    expectation.fulfill()
                }
                .store(in: &anyCancellables)
            
            // Then
            wait(for: [expectation], timeout: 5)
            XCTAssertGreaterThan(vm.nasaImages.count, 0)
        }
    }
    
    
    // Purpose: Checking if the stored image details in an nasaImages array is sorted as per the sorting of latest images first 
    func test_gridViewModel_nasaImages_mustContainLatestImagesFirstWhenReturnedDataAssigned(){
        if let correctURL = correctURL{
            //Given
            let vm = GridViewModel(dataService: ProductionDataService(url: correctURL))
            
            //When
            let expectation = XCTestExpectation(description: "Waiting for images to get returned")
            vm.downloadNasaImages()
            vm.$nasaImages
                .dropFirst()
                .sink(receiveValue: { _ in
                    expectation.fulfill()
                })
                .store(in: &anyCancellables)
            
            //Then
            wait(for: [expectation], timeout: 5)
            for index in 0..<vm.nasaImages.count{
                if index != vm.nasaImages.count - 1 {
                    XCTAssertGreaterThan(vm.nasaImages[index].date, vm.nasaImages[index + 1].date)
                }
            }
        }
    }
    
    // Purpose: It checks that the anyCancellables set(AnyCancellables type, provided by Combine) does not store any publisher when view model is initialised
    func test_gridViewModel_anyCancellables_shouldNotStoreAnyPublisherWhenVieModelIsInitialised(){
        if let correctURL = correctURL{
            //Given
            //When
            let vm = GridViewModel(dataService: ProductionDataService(url: correctURL))
            //Then
            XCTAssertEqual(vm.anyCancellables.count, 0)
        }
    }
    
    // Purpose: It checks that after calling the downloadImages method, anyCancellables set is having one item in it or not
    func test_gridViewModel_anyCancellbles_mustHoldOnePublisherWhendownloadImagesMethodCalled(){
        if let correctURL = correctURL{
            //Given
            let vm = GridViewModel(dataService: ProductionDataService(url: correctURL))
            //When
            vm.downloadNasaImages()
            //Then
            XCTAssertEqual(vm.anyCancellables.count, 1)
        }
    }
    
    func test_gridViewModel_isErrorDownloadingImage_mustBeFalseWhenViewModelIsInitialised(){
        if let correctURL = correctURL{
            //Given
            //When
            let vm = GridViewModel(dataService: ProductionDataService(url: correctURL))
            //Then
            XCTAssertFalse(vm.isErrorDownloadingImage)
        }
    }
}
