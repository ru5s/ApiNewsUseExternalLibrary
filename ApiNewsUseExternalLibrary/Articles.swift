//
//  Articles.swift
//  ApiNewsUseExternalLibrary
//
//  Created by Ruslan Ismailov on 21/11/22.
//

import Foundation
import ObjectMapper

class HeaderArticles: Mappable {
    
    
    var allNews: [Articles] = []
    
    required convenience init?(map: ObjectMapper.Map) {
        self.init(map: map)
    }
    
    func mapping(map: Map) {
        allNews <- map["articles"]
    }
}

class Articles: Mappable {
    
    var author: String = ""
    var title: String = ""
    var urlToImage: String = ""
    
    
    required convenience init?(map: ObjectMapper.Map) {
        self.init(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        author <- map["author"]
        title <- map["title"]
        urlToImage <- map["urlToImage"]
    }
    
    
}
