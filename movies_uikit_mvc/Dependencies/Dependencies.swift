import UIKit
import os

struct Dependencies{
    static let apiLogger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "", category: "API")
    
    static let apiProvider = ApiProviderImpl(
        logger: apiLogger
    )
    
    static let moviesVC = MoviesVC(
        apiProvider: apiProvider,
        moviesView: MoviesView()
    )
    
    static func detailsVC(id: Int) -> UIViewController {
        return DetailsVC(
            apiProvider: apiProvider,
            detailsView: DetailsView(),
            id: id
        )
    }
}
