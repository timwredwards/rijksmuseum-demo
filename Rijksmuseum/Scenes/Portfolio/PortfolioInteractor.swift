
import UIKit

class PortfolioInteractor: PortfolioDataStore{
    let presenter: PortfolioPresenterInput
    let artPrimitiveWorker: ArtPrimitiveWorker
    init(presenter:PortfolioPresenterInput,
         artPrimitiveWorker:ArtPrimitiveWorker) {
        self.presenter = presenter
        self.artPrimitiveWorker = artPrimitiveWorker
    }

    var artPrimitives = [ArtPrimitive]()
    var selectedArtPrimitive: ArtPrimitive?
}

extension PortfolioInteractor: PortfolioInteractorInput {
    func performFetchListings(request: Portfolio.FetchListings.Request) {
        presentFetchListings(state: .loading)
        artPrimitiveWorker.fetchPrimitives {[weak self] (result) in
            self?.processFetchListingsResult(result)
        }
    }
}

private extension PortfolioInteractor {
    func processFetchListingsResult(_ result:ArtPrimitiveResult){
        switch result {
        case .success(let artPrimtives):
            self.artPrimitives = artPrimtives
            presentFetchListings(state: .loaded(artPrimtives))
        case .failure(let error):
            presentFetchListings(state: .error(error))
        }
    }

    func presentFetchListings(state:Portfolio.FetchListings.Response.State){
        let response = Portfolio.FetchListings.Response(state: state)
        presenter.presentFetchListings(response: response)
    }
}
