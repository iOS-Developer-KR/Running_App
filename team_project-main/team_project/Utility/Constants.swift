//
//  Constants.swift
//  team_project
//
//  Created by Taewon Yoon on 10/31/23.
//

import Foundation

struct Constants {
    private static let baseUrlPath = "http://lsproject.shop"
    
    var registerPath = URL(string: baseUrlPath + "/register")
    var loginPath = URL(string: baseUrlPath + ":8080/login")
    
    var changePasswordPath = URL(string: baseUrlPath + "/changePassword")
    var exercise = URL(string: baseUrlPath + "/exercise/user-data")
    var currentmusic = URL(string: "http://lsproject.shop:8080/audio/play")
    var previousmusic = URL(string: "http://lsproject.shop:8080/audio/previous")
    var nextmusic = URL(string: "http://lsproject.shop:8080/audio/next")
}


//eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJsc2gyIiwiaWF0IjoxNzAwNDU3MTUzLCJleHAiOjE3MDA0NTczMzN9.EcVVrEs8hvEslyPuyw00dLrQ4klJ8Aht_hdKDOgbFj_bt84edI-FK0hq5-_TUmHsed8mH-giSrm97nr-xZyB_w
//eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJsc2gyIiwiaWF0IjoxNzAwNDU3MTUzLCJleHAiOjE3MDA0NTczMzN9.EcVVrEs8hvEslyPuyw00dLrQ4klJ8Aht_hdKDOgbFj_bt84edI-FK0hq5-_TUmHsed8mH-giSrm97nr-xZyB_w
