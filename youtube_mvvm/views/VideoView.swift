//
//  VideoView.swift
//  youtube_mvvm
//
//  Created by neta yamin on 04/03/2021.
//

import SwiftUI
import AVKit

struct VideoView: View {
    
    @EnvironmentObject var model : HomeViewModel
    var video : Video
    
    
    var body: some View {
        GeometryReader { g in
            VStack {
                HStack {
                    VideoPlayerView()
                        .frame(width: model.showMiniPlayer ? 150 : g.size.width)
                    Spacer()
                }.frame(height: model.height)
                .background(Color.black)
                
                ScrollView {
                    VStack(spacing: 15) {
                        HStack {
                            Text(video.title)
                            Spacer()
                        }
                        ForEach(model.videos) {video in
                            Rectangle()
                                .fill(Color.gray)
                                .frame(height: 200)
                        }
                    }.padding(.horizontal, 15)
                    .opacity(model.opacity)
                    
                }
            }.onTapGesture {
                model.showMiniPlayer = false
                model.offset = 0
                model.opacity = 1
                model.height = 250
            }
        }
        
        .background(Color.white).edgesIgnoringSafeArea(.all)
        .offset(y: model.offset)
        .gesture(
            DragGesture()
                .onChanged(model.didDrag)
                .onEnded(model.didEndDragging)
        )
      
    }
}


struct VideoPlayerView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        
        guard let file = Bundle.main.path(forResource: "video", ofType: "mp4") else {
            return controller
        }
        
        let uri = URL(fileURLWithPath: file)
        
        let player = AVPlayer(url: uri)
        
        player.play()
        
        controller.player = player
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        
    }
    
    
    
}
