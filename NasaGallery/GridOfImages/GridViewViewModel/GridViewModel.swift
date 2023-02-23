//
//  GridViewModel.swift
//  NasaGallery
//
//  Created by Bhavik Bhatt on 22/02/23.
//

import Foundation
import Combine

class GridViewModel: ObservableObject{
    
    let dataService: DataServiceProtocol
    @Published var nasaImages: [NasaImage] = [].sorted(by: {$0.date > $1.date})
    var anyCancellables = Set<AnyCancellable>()
    
    init(dataService: DataServiceProtocol){
        self.dataService = dataService
    }
    
    func downloadNasaImages(){
        self.dataService.downloadData()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error)
                case .finished:
                    print("returned data successfully")
                }
            } receiveValue: { [weak self] returnedImages in
                self?.nasaImages = returnedImages
            }
            .store(in: &anyCancellables)

    }
    
    
}
