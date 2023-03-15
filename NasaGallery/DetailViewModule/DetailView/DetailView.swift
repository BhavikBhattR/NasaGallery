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
    @Environment(\.dismiss) var dismiss
    init(nasaImages: [NasaImage], selectedImageIndex: Int){
        self._vm = StateObject(wrappedValue: DetailViewModel(nasaImages: nasaImages, selectedImageIndex: selectedImageIndex))
    }
    var body: some View {
        ZStack{
            Color.black.background().edgesIgnoringSafeArea([.bottom, .top])
            TabView(selection: $vm.selectedImageIndex){
            ForEach(vm.nasaImages, id: \.url) { nasaImage in
                ZStack{
                    Colors.returnedColor(index: vm.nasaImages.firstIndex(where: {$0.url == nasaImage.url}) ?? 0).ignoresSafeArea()
                
                    GeometryReader{ geometry in
                        ScrollView(showsIndicators: false){
                            VStack(spacing: 20){
                                TitleOf(nasaImage: nasaImage)
                                if let image = SDImageCache.shared.imageFromCache(forKey: nasaImage.url){
                                    cachedImageOf(image: image)
                                }else{
                                    downloadedImageOf(nasaImage: nasaImage)
                                }
                                    CapturedData(nasaImage: nasaImage)
                                VStack(alignment: .leading){
                                 customDivider
                                 DetailSectionOf(nasaImage: nasaImage)
                                }
                            }
                        }
                        .padding([.bottom])
                        .padding(.horizontal, 7)
                    }.padding(.top)
                } .tag(vm.nasaImages.firstIndex(where: {$0.url == nasaImage.url}) ?? 0)
            }
            
        }
        .cornerRadius(10)
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .interactive))
        .navigationTitle("hello")
        .toolbar(.hidden, for: .bottomBar, .navigationBar)
        .overlay {
          customBackButton
        }
        
        }.onDisappear{
            Colors.allColors.shuffle()
        }
    }
}

extension DetailView{
    
    private var customBackButton: some View{
        Button{
            withAnimation(Animation.linear(duration: 2)) {
                dismiss()
            }
        }label: {
            Image(systemName: "chevron.left")
                .bold()
                .foregroundColor(.black)
                .padding()
                .background(Circle().fill(.white.opacity(0.3)))
                .padding(.leading, 5)
                .padding([.trailing, .top])
        }.frame(maxWidth: .infinity, alignment: .leading)
            .frame(maxHeight:.infinity, alignment: .top)
    }
    
    struct TitleOf: View{
        let nasaImage: NasaImage
        
        var body: some View{
            Text(nasaImage.title)
                .font(.headline.bold())
                .padding([.horizontal, .vertical, .top])
                .background(Rectangle().fill(.white.opacity(0.6)))
                .foregroundColor(.black)
                .border(.black)
                .cornerRadius(10)
        }
    }
    
    private func downloadedImageOf(nasaImage: NasaImage) -> some View{
            return WebImage(url: URL(string: nasaImage.url))
                .resizable()
                .border(.black)
                .scaledToFit()
                .frame(width: 350, height: 250)
//                .clipped()
//                .aspectRatio(1, contentMode: .fit)
                .shadow(radius: 2)
                .cornerRadius(10)
    }
    
    private func cachedImageOf(image: UIImage) -> some View{
        return Image(uiImage: image)
            .resizable()
            .border(.black)
            .scaledToFit()
            .frame(width: 350, height: 250)
//            .clipped()
//            .aspectRatio(1, contentMode: .fit)
            .shadow(radius: 2)
            .cornerRadius(10)
    }
    
    struct CapturedData: View{
        let nasaImage: NasaImage
        
        var body: some View{
            VStack(alignment: .leading ,spacing: 7){
                Text("Captured On: \(nasaImage.date)")
                Text("Captured By: \(nasaImage.copyright ?? "N/A")")
            }.font(.caption)
             .fontWeight(.bold)
             .foregroundColor(.black)
             .padding()
             .background(Rectangle().fill(.white.opacity(0.6)))
             .border(.black)
             .cornerRadius(10)
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
                .background(Rectangle().fill(.white.opacity(0.6)))
                .border(.black)
                .cornerRadius(10)
                .foregroundColor(.black)
            Text(nasaImage.explanation)
                .padding()
                .background(Rectangle().fill(.white.opacity(0.6)))
                .border(.black)
                .cornerRadius(10)
                .foregroundColor(.black)
                .fontWeight(.semibold)
        }
    }
}
