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
    
    init(nasaImages: [NasaImage]){
        self.nasaImages = nasaImages
    }
}
