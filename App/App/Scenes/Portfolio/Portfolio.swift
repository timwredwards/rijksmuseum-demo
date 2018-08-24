
import UIKit
import Services
import Utilities

protocol PortfolioInteractorInterface{
    func performFetchArt(request: Portfolio.FetchArt.Request)
}

protocol PortfolioPresenterInterface{
    func presentFetchArt(response: Portfolio.FetchArt.Response)
}

protocol PortfolioViewControllerInterface: class{
    func displayFetchArt(viewModel:Portfolio.FetchArt.ViewModel)
}

protocol PortfolioDataStore{
    var selectedArt:Art? { get }
}

protocol PortfolioRouterInterface{
    var dataStore: PortfolioDataStore? { get }
}

enum Portfolio{
    enum FetchArt{
        struct Request{}
        struct Response{
            enum State {
                case loading
                case loaded([Art])
                case error(ResultError)
            }
            let state:State
        }
        struct ViewModel{
            enum State {
                case loading
                case loaded([URL])
                case error(String)
            }
            let state:State
        }
    }

    static func build()->PortfolioViewController{
        let presenter = PortfolioPresenter()
        let apiService = APIService(apiSession: URLSession.shared,
                                    apiConfig: LiveAPIConfig())
        let artService = ArtServiceAPI(apiService: apiService)
        let router = PortfolioRouter()
        let interactor = PortfolioInteractor(presenter: presenter,
                                             artService: artService)
        let viewController = PortfolioViewController(interactor: interactor,
                                                     router: router)
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        return viewController
    }
}
