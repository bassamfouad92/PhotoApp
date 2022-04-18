//  Created on 08/03/2022.

import XCTest
@testable import ALiftPhoto

class RemoteImageLoaderTests: XCTestCase {

    func test_load_requestDataFromURL() {
        let (request, client) = Helpers.makeRequest()
        request.load(completion: { _ in })
        XCTAssertNotNil(client.requestedURL)
    }

    func test_retreiveImagesFromRemote() {
        let session = HTTPSessionImp()
        let remoteImageLoader = RemoteImageLoader(url: URL(string: Constants.API_URL)!, client: URLSessionHTTPClient(session: session))
        remoteImageLoader.load(completion: { result in
            switch result {
              case let .success(images):
                XCTAssertGreaterThan(images.count, 0)
            case .failed(_):
                break
            }
        })
    }
    
}
