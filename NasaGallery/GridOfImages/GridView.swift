//
//  GridView.swift
//  NasaGallery
//
//  Created by Bhavik Bhatt on 22/02/23.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI

struct Colors{
    static let allColors: [Color] = [.red, .blue, .green, .yellow, .pink, .purple, .cyan]
    static func returnedColor(index: Int) -> Color{
        if index > allColors.count - 1{
            return allColors[index % allColors.count]
        }else{
            return allColors[index]
        }
    }
}

struct GridView: View {
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    @StateObject var vm: GridViewModel
    var body: some View {
        VStack{
            NavigationStack{
                ScrollView{
                    LazyVGrid(columns: columns){
                        ForEach(0..<vm.nasaImages.count, id: \.self) { index in
                            NavigationLink{
                               Text("Detail View")
                            } label: {
                                ZStack{
//                                    Rectangle()
//                                        .fill(Colors.returnedColor(index: index))
//                                        .cornerRadius(10)
                                        
                                VStack{
                                    GeometryReader{ geo in
                                            WebImage(url: URL(string: vm.nasaImages[index].url))
                                                .resizable()
                                                .scaledToFill()
                                            //                                            .fixedSize(horizontal: (true), vertical: (true))
                                            //                                            .scaledToFit()
                                            //                                            .border(.white)
                                            //                                            .frame(width: 150, height: 100)
                                            //                                            .padding()
                                        
                                    }.clipped()
                                        .aspectRatio(1, contentMode: .fit)
//                                    Spacer()
//                                    VStack{
//                                        Text(vm.nasaImages[index].title)
//                                            .font(.headline)
//                                            .foregroundColor(.black)
//                                        Text(vm.nasaImages[index].date)
//                                            .foregroundColor(.black.opacity(0.5))
//                                    }
//                                    .padding(.vertical)
//                                    .frame(maxWidth: .infinity)
//                                    .background(.white.opacity(0.5))
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                    
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black)
                                )
                            }
                                
                        }
                    }
                    }
                    .padding(.horizontal, 5)
                    .padding([.bottom])
                }
                .navigationTitle("Nasa Gallery")
//                .background(.white.opacity(0.8))
//                    .preferredColorScheme(.dark)
            }
        }.task {
             vm.downloadNasaImages()
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView(vm: GridViewModel(dataService: ProductionDataService()))
    }
}
