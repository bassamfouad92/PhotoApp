//  Created on 08/03/2022.

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failed(Error)
}

protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
