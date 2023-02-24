//
//  DataService.swift
//  NasaGallery
//
//  Created by Bhavik Bhatt on 22/02/23.
//

import Foundation
import Combine

protocol DataServiceProtocol{
    func downloadData() -> AnyPublisher<[NasaImage], Error>
    func handleResponse(data: Data?, response: URLResponse?) throws -> [NasaImage]
}

enum Errors: Error{
    case dataCouldNotBeDecoded, returnedDataIsNil, responseIsNotHTTPURL
}

class ProductionDataService: DataServiceProtocol{
    let url: URL
    
    init(url: URL) {
            self.url = url
        }
    
    func handleResponse(data: Data?, response: URLResponse?) throws -> [NasaImage]{
        guard let data = data else {
            throw Errors.returnedDataIsNil
        }
            
        guard let response = response as? HTTPURLResponse else{
            throw Errors.responseIsNotHTTPURL
        }
        guard response.statusCode >= 200 && response.statusCode < 300 else{
            throw URLError(.badServerResponse)
        }
        
        do{
            let imagesData = try JSONDecoder().decode([NasaImage].self, from: data)
            return imagesData
        }catch{
            print("data could not be decoded")
            throw Errors.dataCouldNotBeDecoded
        }
    }
    
        func downloadData() -> AnyPublisher<[NasaImage], Error>{
            
            URLSession.shared.dataTaskPublisher(for: url)
                .tryMap(handleResponse)
//                .decode(type: [NasaImage].self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
        }
}
