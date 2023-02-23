//
//  ColorTheme.swift
//  NasaGallery
//
//  Created by Bhavik Bhatt on 23/02/23.
//

import Foundation
import SwiftUI

struct Colors{
    static var allColors: [Color] = [.pink, .blue, .green, .yellow, .purple, .cyan]
    static func returnedColor(index: Int) -> Color{
        if index > allColors.count - 1{
            return allColors[index % allColors.count]
        }else{
            return allColors[index]
        }
    }
}
