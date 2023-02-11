//
//  Constants.swift
//  youtube-dayonebuile
//
//  Created by apple on 2/10/23.
//

import Foundation

struct Constants {
    // API_KEY
    // PLAYLIST_ID
    // API_URL
    static var API_KEY = "AIzaSyC85a3cejx7ia85jVwMeN8hYzNcrIdH5do"
    static var PLAYLIST_ID = "PL5hq3tApc7D7RYIT-HL2Yw1d7i9-3bqgz"
    static var API_URL = " https://youtube.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(PLAYLIST_ID)&key=\(API_KEY)"
}
