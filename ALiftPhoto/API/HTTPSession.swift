//  Created on 08/03/2022.

import Foundation

protocol HTTPSession {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

class HTTPSessionImp: HTTPSession {
    
    let session = URLSession.shared
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
          let task = session.dataTask(with: urlRequest, completionHandler: { data, response ,error in
               completionHandler(data, response, error as? Error)
          })
        return task
    }

}
