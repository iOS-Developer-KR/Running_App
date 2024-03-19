//
//  Constants.swift
//  team_project
//
//  Created by Taewon Yoon on 10/31/23.
//

import Foundation

struct Constants {
    private static let baseUrlPath = "http://lsproject.shop:8080"
    
    var registerPath = URL(string: baseUrlPath + "/join")
    var loginPath = URL(string: baseUrlPath + "/login")
    
    var changePasswordPath = URL(string: baseUrlPath + "/changePassword")
    var exercise = URL(string: baseUrlPath + "/exercise/user-data")
    var currentmusic = URL(string: baseUrlPath + "/music")
    var previousmusic = URL(string: "/previous")
    var nextmusic = URL(string: baseUrlPath + "/next")
}


//eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJsc2gyIiwiaWF0IjoxNzAwNDU3MTUzLCJleHAiOjE3MDA0NTczMzN9.EcVVrEs8hvEslyPuyw00dLrQ4klJ8Aht_hdKDOgbFj_bt84edI-FK0hq5-_TUmHsed8mH-giSrm97nr-xZyB_w
//eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJsc2gyIiwiaWF0IjoxNzAwNDU3MTUzLCJleHAiOjE3MDA0NTczMzN9.EcVVrEs8hvEslyPuyw00dLrQ4klJ8Aht_hdKDOgbFj_bt84edI-FK0hq5-_TUmHsed8mH-giSrm97nr-xZyB_w
//"https://myawsbucket334.s3.amazonaws.com/music/Future+House.mp3",
//    "albumUrl": "https://myawsbucket334.s3.amazonaws.com/image/Alan+Walker.jpg",
///"filePath": "https://myawsbucket334.s3.amazonaws.com/music/Fade.mp3",
