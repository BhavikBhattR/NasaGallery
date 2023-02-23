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
}

class ProductionDataService: DataServiceProtocol{
    let url: URL
    var anyCancellables = Set<AnyCancellable>()
    
    init(url: URL) {
            self.url = url
        }
    
    func handleResponse(data: Data?, response: URLResponse?) throws -> Data{
        guard
            let data = data,
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else{
            throw URLError(.badServerResponse)
        }
        return data
    }
    
        func downloadData() -> AnyPublisher<[NasaImage], Error>{
            
            URLSession.shared.dataTaskPublisher(for: url)
                .tryMap(handleResponse)
                .decode(type: [NasaImage].self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
                
//
//            do{
//                let (data, _) = try await URLSession.shared.data(from: url)
//                print(data)
//                print(data[0])
//                let nasaComponents = try JSONDecoder().decode([NasaImage].self, from: data)
//                print(data)
//                await MainActor.run(body: {
//                    self.nasaComponents = nasaComponents
//                })
//            }catch{
//                print("couldn't decode")
//            }
        }
}
