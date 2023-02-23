//
//  ChevronButton.swift
//  NasaGallery
//
//  Created by Bhavik Bhatt on 23/02/23.
//

import SwiftUI

struct ChevronButton: View {
    let systemName: String
    init(systemName: String) {
        self.systemName = systemName
    }
    var body: some View {
        Image(systemName: systemName)
            .frame(width: 40, height: 44)
            .background(content: {
                Rectangle()
                    .fill(.blue).opacity(0.1)
                    .cornerRadius(10)
            })
    }
}

struct ChevronButton_Previews: PreviewProvider {
    static var previews: some View {
        ChevronButton(systemName: "chevron.left")
    }
}
