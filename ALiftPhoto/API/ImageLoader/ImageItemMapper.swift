//  Created on 08/03/2022.

import Foundation

private struct Root: Decodable {
    let hits: [ImageItem]
}

class ImageItemMapper {
    
    private static var isOK: Int { return 200 }
    
    static func map(_ data: Data,_ response: HTTPURLResponse) throws -> [ImageItem] {
        guard response.statusCode == isOK else {
            throw Error.invalidData
        }
        return try JSONDecoder().decode(Root.self, from: data).hits
    }
}
