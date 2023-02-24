//
//  GridView.swift
//  NasaGallery
//
//  Created by Bhavik Bhatt on 22/02/23.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI


struct GridView: View {
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    @StateObject var vm: GridViewModel
    var body: some View {
            NavigationStack{
                ZStack{
                    Color.colorTheme.backgroundColorHome.edgesIgnoringSafeArea(.bottom)
                ScrollView{
                    LazyVGrid(columns: columns){
                        ForEach(0..<vm.nasaImages.count, id: \.self) { index in
                            NavigationLink{
                                DetailView(nasaImages: vm.nasaImages, selectedImageIndex: index)
                            } label: {
                                ZStack{
                                    Rectangle()
                                        .fill(Colors.returnedColor(index: index))
                                        .cornerRadius(10)
                                    
                                    VStack{
                                        GeometryReader{ geo in
                                            WebImage(url: URL(string: vm.nasaImages[index].url))
                                                .resizable()
                                                .scaledToFill()
                                        }.clipped()
                                            .aspectRatio(1, contentMode: .fit)
                                    }
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.colorTheme.borderColor)
                                    )
                                }
                                
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                    .padding([.bottom, .top])
                }
            }
                .navigationTitle("Nasa Gallery")
                .navigationBarTitleDisplayMode(.inline)
            }
        .task {
            vm.downloadNasaImages()
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView(vm: GridViewModel(dataService: ProductionDataService(url: URL(string: "https://raw.githubusercontent.com/obvious/take-home-exercise-data/trunk/nasa-pictures.json")!)))
    }
}
