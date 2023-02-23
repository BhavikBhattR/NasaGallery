//
//  DetailView.swift
//  NasaGallery
//
//  Created by Bhavik Bhatt on 23/02/23.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI

struct DetailView: View {
    @StateObject var vm: DetailViewModel
    init(nasaImages: [NasaImage]){
        self._vm = StateObject(wrappedValue: DetailViewModel(nasaImages: nasaImages))
    }
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
        TabView{
            ForEach(vm.nasaImages, id: \.url) { nasaImage in
                ZStack{
                    Colors.returnedColor(index: vm.nasaImages.firstIndex(where: {$0.url == nasaImage.url}) ?? 2).ignoresSafeArea()
                    GeometryReader{ geometry in
                        ScrollView(showsIndicators: false){
                            VStack(spacing: 0){
                                TitleOf(nasaImage: nasaImage)
                                returnImageOf(geometry: geometry, nasaImage: nasaImage)
                                CapturedDateOf(nasaImage: nasaImage)
                                VStack(alignment: .leading){
                                 customDivider
                                 DetailSectionOf(nasaImage: nasaImage)
                                }
                            }
                        }
                        .padding(.horizontal, 7)
                        .padding(.top)
                    }
                }
            }
            
        }
        .tabViewStyle(.page)
                    .indexViewStyle(.page(backgroundDisplayMode: .interactive))
        .navigationTitle("hello")
        .toolbar(.hidden, for: .navigationBar)
        
    }
    }
}

extension DetailView{
    
    struct TitleOf: View{
        let nasaImage: NasaImage
        
        var body: some View{
            Text(nasaImage.title)
                .font(.headline.bold())
                .padding([.horizontal, .vertical])
                .background(Rectangle().stroke())
                .cornerRadius(10)
                .foregroundColor(.white)
        }
    }
    
    private func returnImageOf(geometry: GeometryProxy, nasaImage: NasaImage) -> some View{
        return WebImage(url: URL(string: nasaImage.url))
            .resizable()
            .scaledToFit()
            .border(.black)
            .frame(width: 250, height: 150)
            .fixedSize(horizontal: true, vertical: false)
            .padding(.top)
    }
    
    struct CapturedDateOf: View{
        let nasaImage: NasaImage
        
        var body: some View{
            Text("Captured on: \(nasaImage.date)")
                .font(.caption)
                .padding()
                .background(Rectangle().stroke(lineWidth: 0.4))
                .padding(.vertical)
               
        }
    }
    
    private var customDivider: some View{
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.black)
            .padding(.vertical)
    }
    
    struct  DetailSectionOf: View{
        let nasaImage: NasaImage
        
        @ViewBuilder var body: some View{
            Text("Details:")
                .font(.headline.bold())
                .padding([.horizontal, .vertical])
                .background(.white.opacity(0.6))
                .cornerRadius(10)
                .foregroundColor(.black)
            Text(nasaImage.explanation)
                .padding()
                .background(.white.opacity(0.6))
                .cornerRadius(10)
                .foregroundColor(.black)
                .fontWeight(.semibold)
        }
    }
    
  
    
}
