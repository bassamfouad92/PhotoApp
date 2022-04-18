//  Created on 08/03/2022.

import Foundation

enum Type: String, Codable {
    case photo = "photo"
    case video = "video"
}

public struct ImageItem: Codable {
    let id: Int
    let type: Type
    let largeImageURL: String
    let previewURL: String
    
    init(id: Int, type: Type, largeImageURL: String, imageURL: String) {
        self.id = id
        self.type = type
        self.largeImageURL = largeImageURL
        self.previewURL = imageURL
    }
}
