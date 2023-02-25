//
//  NasaGalleryApp.swift
//  NasaGallery
//
//  Created by Bhavik Bhatt on 22/02/23.
//

import SwiftUI

@main
struct NasaGalleryApp: App {
    var url: URL? = nil
    init() {
        // You can use different url for the service if you want

        let url = URL(string: "https://raw.githubusercontent.com/obvious/take-home-exercise-data/trunk/nasa-pictures.json")
        guard let url = url else {
            print("Json url is wrong")
            return
        }
        self.url = url
    }
    var body: some Scene {
        WindowGroup {
            if let url = url{
                // you can pass the different service to your sandbox environment if you wamt
                GridView(vm: GridViewModel(dataService: ProductionDataService(url: url)))
            }
        }
    }
}
