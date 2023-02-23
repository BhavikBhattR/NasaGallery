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
                            VStack(spacing: 20){
                                TitleOf(nasaImage: nasaImage)
                                    returnImageOf(nasaImage: nasaImage)
                                    CapturedData(nasaImage: nasaImage)
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
        .overlay {
            
            Button{
                withAnimation(Animation.linear(duration: 2)) {
                    dismiss()
                }
            }label: {
                Image(systemName: "chevron.left")
                    .bold()
                    .foregroundColor(.black)
                    .padding()
            }.frame(maxWidth: .infinity, alignment: .leading)
                .frame(maxHeight:.infinity, alignment: .top)
        }
        
        }.onDisappear{
            Colors.allColors.shuffle()
        }
    }
}

extension DetailView{
    
    struct TitleOf: View{
        let nasaImage: NasaImage
        
        var body: some View{
            Text(nasaImage.title)
                .font(.headline.bold())
                .padding([.horizontal, .vertical, .top])
                .background(Rectangle().stroke(.black, lineWidth: 0.8))
                .cornerRadius(10)
                .foregroundColor(.black)
        }
    }
    
    private func returnImageOf(nasaImage: NasaImage) -> some View{
        return  WebImage(url: URL(string: nasaImage.url))
            .resizable()
            .scaledToFill()
            .frame(width: 250, height: 250)
            .clipped()
            .aspectRatio(1, contentMode: .fit)
            .border(.black)
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
             .background(Rectangle().stroke(.black, lineWidth: 0.4))
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
