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
    init(nasaImage: NasaImage, nasaImages: [NasaImage]){
        self._vm = StateObject(wrappedValue: DetailViewModel(nasaImage: nasaImage, nasaImages: nasaImages))
    }
    var body: some View {
        NavigationStack{
            ZStack{
                Color.black.opacity(0.2)
                    .ignoresSafeArea()
            GeometryReader{ geometry in
                ScrollView(showsIndicators: false){
                    VStack(spacing: 0){
                        Title
                        returnImage(geometry: geometry)
                        DateWhenShot
                        VStack(alignment: .leading){
                            customDivider
                             Details
                            Explanation
                        }
                    }
                }
                .overlay {
                    ChevronButtonContainer
                }
                .padding(.horizontal, 7)
            }
            .contentTransition(.interpolate)
        }
    }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(nasaImage: NasaImage(copyright: "ESA/HubbleNASA", date: "2019-12-01", explanation: "Why does this galaxy have a ring of bright blue stars?  Beautiful island universe Messier 94 lies a mere 15 million light-years distant in the northern constellation of the Hunting Dogs (Canes Venatici). A popular target for Earth-based astronomers, the face-on spiral galaxy is about 30,000 light-years across, with spiral arms sweeping through the outskirts of its broad disk. But this Hubble Space Telescope field of view spans about 7,000 light-years across M94's central region. The featured close-up highlights the galaxy's compact, bright nucleus, prominent inner dust lanes, and the remarkable bluish ring of young massive stars. The ring stars are all likely less than 10 million years old, indicating that M94 is a starburst galaxy that is experiencing an epoch of rapid star formation from inspiraling gas. The circular ripple of blue stars is likely a wave propagating outward, having been triggered by the gravity and rotation of a oval matter distributions. Because M94 is relatively nearby, astronomers can better explore details of its starburst ring.    Astrophysicists: Browse 2,000+ codes in the Astrophysics Source Code Library", hdurl: "https://apod.nasa.gov/apod/image/1912/M94_Hubble_1002.jpg", media_type: "image", service_version: "v1", title: "Starburst Galaxy M94 from Hubble", url: "https://apod.nasa.gov/apod/image/1912/M94_Hubble_960.jpg"), nasaImages: [])
    }
}

extension DetailView{
    
    private var Title: some View{
        Text(vm.nasaImage.title)
            .font(.headline.bold())
            .padding([.horizontal, .vertical])
            .background(Rectangle().stroke())
            .cornerRadius(10)
    }
    
    
    private func returnImage(geometry: GeometryProxy) -> some View{
  
//        return AsyncImage(url: URL(string: vm.nasaImage.url)) { image in
//            image
//                .resizable()
//                .scaledToFit()
//                .border(.black)
//                .frame(width: 250, height: 150)
//                .padding(.top)
//                .cornerRadius(20)
//        } placeholder: {
//            ProgressView()
//        }

        return WebImage(url: URL(string: vm.nasaImage.url))
            .resizable()
            .scaledToFit()
            .border(.black)
            .frame(width: 250, height: 150)
            .fixedSize(horizontal: true, vertical: false)
//            .frame(width: geometry.size.width * 0.1)
            .padding(.top)
           
    }
    
    private var Date: some View{
        Text(vm.nasaImage.date)
            .font(.callout)
            .padding([.vertical])
            .cornerRadius(10)
    }
    
    private var DateWhenShot: some View{
        Text("Captured on: \(vm.nasaImage.date)")
            .font(.caption)
            .padding(.vertical)
    }
    
    private var customDivider: some View{
        Rectangle()
            .frame(height: 2)
            .padding(.vertical)
    }
    
    private var Details: some View{
        Text("Details:")
            .font(.headline.bold())
            .padding([.horizontal, .vertical])
            .background(.white.opacity(0.6))
            .cornerRadius(10)
    }
    
    private var Explanation: some View{
        Text(vm.nasaImage.explanation)
            .padding()
            .background(.white.opacity(0.6))
            .cornerRadius(10)
    }
    
    private func isCurrentImageFirst() -> Bool{
        self.vm.nasaImages.firstIndex(where: {$0.url == vm.nasaImage.url}) == 0
    }
    
    private func isCurrentImageLast() -> Bool{
        self.vm.nasaImages.firstIndex(where: {$0.url == vm.nasaImage.url}) == vm.nasaImages.count - 1
    }
    
    private var ChevronButtonContainer: some View{
        VStack{
            HStack{
                if isCurrentImageFirst() {
                    
                }else{
                   ChevronButton(systemName: "chevron.left")
                        .onTapGesture {
                            vm.seeTheLeftImage(index: self.vm.nasaImages.firstIndex(where: {$0.url == vm.nasaImage.url}) ?? 0)
                            
                        }
                }
                Spacer()
                if isCurrentImageLast() {
                    
                }else{
                    ChevronButton(systemName: "chevron.right")
                        .onTapGesture {
                            vm.seeTheRightImage(index: self.vm.nasaImages.firstIndex(where: {$0.url == vm.nasaImage.url}) ?? 0)
                        }
                }
            }
        }
    }
}
