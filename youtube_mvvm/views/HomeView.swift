//
//  ContentView.swift
//  youtube_mvvm
//
//  Created by neta yamin on 04/03/2021.
//

import SwiftUI
import Combine
import SwURL
import URLImage

struct HomeView: View {
    
    @ObservedObject var model = HomeViewModel()
    
    @State var showFullVideo = false
    
    @State var selectedVideo : Video?
    
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(model.videos) {video in
                        VideoCard(video: video)
                            .onTapGesture(){
                                showFullVideo = true
                                selectedVideo = video
                            }
                            
                        HStack {
                            Text(video.title).bold()
                            Spacer()
                            Text("23k views")
                        }
                    }
                }.padding(.horizontal, 15)
            }
            
            if showFullVideo == true {
                VideoView(video: selectedVideo! )
                    .environmentObject(model)
                    .transition(.move(edge: .bottom))
                    .animation(.linear)
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}




struct VideoCard: View {
    
    var video : Video
    
    var body: some View {
        URLImage(url: URL(string: "https://" + video.image)!,
                 content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                 })
    }
}
