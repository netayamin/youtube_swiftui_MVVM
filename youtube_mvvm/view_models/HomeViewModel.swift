//
//  File.swift
//  youtube_mvvm
//
//  Created by neta yamin on 04/03/2021.
//

import Foundation
import SwiftUI


class HomeViewModel : ObservableObject {
        

    @Published var showMiniPlayer = false
    
    @Published var offset : CGFloat = 0.0
    
    @Published var opacity : Double = 1.0
    
    @Published var height : CGFloat = 250
    
    @Published var videos: [Video]
    
    init() {
        videos = FetchMoviesFromDatabase()!
    }
    
    func didDrag(val: DragGesture.Value) {
        let scrollHeight = val.translation.height

        let _opacity = 0.6 - scrollHeight / 1000
        
        //check user scroll down
        if scrollHeight >= 0 {
            offset = scrollHeight
            opacity = Double(_opacity)
            height = 250 * (1 - scrollHeight/1000)
        }
        
        //if user is in mini player mood and - scroll num
        // don't show mini player
        if showMiniPlayer == true && scrollHeight < 0  {
            showMiniPlayer = false
        
        } else {
            showMiniPlayer = true
        }
       
    }
    
    func didEndDragging(val: DragGesture.Value) {
        let screenHeight = UIScreen.main.bounds.height

        //user wants to leave page
        if showMiniPlayer {
            height = 100
            offset = screenHeight - 180
            opacity = 0
        } else {
            //stay in page
            offset = 0
            opacity = 1
            height = 250
        }
    }
    
}

