//
//  DetailViewModel.swift
//  NasaGallery
//
//  Created by Bhavik Bhatt on 23/02/23.
//

import Foundation
import SwiftUI

class DetailViewModel: ObservableObject{
    
    @Published var offset = CGSize.zero
    @Published var SwipeToAnotherView: Bool = false
    @Published var nasaImage: NasaImage
    let nasaImages: [NasaImage]
    
    init(nasaImage: NasaImage, nasaImages: [NasaImage]){
        self.nasaImage = nasaImage
        self.nasaImages = nasaImages
    }
        
    func seeTheRightImage(index: Int){
        if index == self.nasaImages.count - 1 {
            offset = .zero
            return
        }
        self.nasaImage = self.nasaImages[index + 1]
    }
    
    func seeTheLeftImage(index: Int){
        if index == 0 {
            offset = .zero
            return
        }
        print("right side swiped")
        self.nasaImage = self.nasaImages[index - 1]
    }
}
