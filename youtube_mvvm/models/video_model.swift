//
//  video_model.swift
//  youtube_mvvm
//
//  Created by neta yamin on 04/03/2021.
//

import Foundation



struct Video : Identifiable {
    var id : String = UUID().uuidString
    var title : String
    var image : String
    var videoURL : String
}

func FetchMoviesFromDatabase() -> [Video]?  {
    
    if let path = Bundle.main.path(forResource: "movies", ofType: "json") {
        
        let uri = URL(fileURLWithPath: path)
        
        if let data = try? Data(contentsOf: uri ) {
            
            let object = try! JSONSerialization.jsonObject(with: data as Data, options: .allowFragments)
            
            if let dictionary = object as? [[String: AnyObject]] {
                
                let filmObject = dictionary[0]
                
                let title = filmObject["title"] as! String
                
                let screen = filmObject["screenshot"] as! [String: AnyObject]
                
                let normalPic = screen["normal"] as! String
                
                let original_video = filmObject["original_video"] as! [String: AnyObject]
                
                let uri = original_video["http_uri"] as! String
                
                let videos =  [Video(title: title, image: normalPic, videoURL: uri) ,
                                      Video(title: title, image: normalPic, videoURL: uri),
                                      Video(title: title, image: normalPic, videoURL: uri),
                                      Video(title: title, image: normalPic, videoURL: uri),
                                      Video(title: title, image: normalPic, videoURL: uri)
                                      ]
                
                return videos
                
            }
        }
    }
    return nil
}

