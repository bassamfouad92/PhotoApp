//  Created on 08/03/2022.

import Foundation

public enum Result {
   case success([ImageItem])
   case failed(Error)
}

public enum ImageDataResult {
   case success(Data)
   case failed(Error)
}
