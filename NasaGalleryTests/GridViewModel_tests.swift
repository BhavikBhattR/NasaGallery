//
//  GridViewModel_tests.swift
//  NasaGalleryTests
//
//  Created by Bhavik Bhatt on 23/02/23.
//

import XCTest
@testable import NasaGallery
import Combine

final class GridViewModel_tests: XCTestCase {
    
    var anyCancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        anyCancellables.removeAll()
    }

    // Purpose: To check the array holding image data must be empty when view model is initialised
    func test_NasaImagesViewModel_nasaImages_shouldBeEmptyWhenViewModelIsInitialised(){
        // Given
        //When
        let vm = GridViewModel(dataService: ProductionDataService())
        //Then
        XCTAssertEqual(vm.nasaImages.count, 0)
        
    }
    

    // Purpose: To check if returned images' data is getting stored in view model's published property nasaImages or not
    func test_NasaImagesViewModel_downloadImages_shouldReturnItems(){
        //Given
        let vm = GridViewModel(dataService: ProductionDataService())
        
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
    
    
    // Purpose: Checking if the stored image details in an nasaImages array is sorted as per the latest images first sorting
    func test_NasaImagesViewModel_nasaImages_mustContainLatestImagesFirstWhenReturnedDataAssigned(){
        //Given
        let vm = GridViewModel(dataService: ProductionDataService())
        
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
    
    // Purpose: It checks that the anyCancellables set(AnyCancellables type, provided by Combine) does not store any publisher when view model is initialised
    func test_NasaImagesViewModel_anyCancellables_shouldNotStoreAnyPublisherWhenVieModelIsInitialised(){
        //Given
        //When
        let vm = GridViewModel(dataService: ProductionDataService())
        //Then
        XCTAssertEqual(vm.anyCancellables.count, 0)
    }
    
    // Purpose: It checks that after calling the downloadImages method, anyCancellables set is having one item in it or not
    func test_NasaImagesViewModel_anyCancellbles_mustHoldOnePublisherWhendownloadImagesMethodCalled(){
        //Given
        let vm = GridViewModel(dataService: ProductionDataService())
        //When
        vm.downloadNasaImages()
        //Then
        XCTAssertEqual(vm.anyCancellables.count, 1)
    }
    

}
