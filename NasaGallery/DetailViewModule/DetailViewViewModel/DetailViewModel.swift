//
//  DetailViewModel.swift
//  NasaGallery
//
//  Created by Bhavik Bhatt on 23/02/23.
//

import Foundation
import SwiftUI

class DetailViewModel: ObservableObject{
    
    let nasaImages: [NasaImage]
    @Published var selectedImageIndex: Int
    
    init(nasaImages: [NasaImage], selectedImageIndex: Int){
        self.nasaImages = nasaImages
        self.selectedImageIndex = selectedImageIndex
    }
}
