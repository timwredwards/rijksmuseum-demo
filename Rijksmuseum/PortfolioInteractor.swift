//
//  PortfolioInteractor.swift
//  Rijksmuseum
//
//  Created by Tim Edwards on 29/07/2018.
//  Copyright (c) 2018 Tim Edwards. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol PortfolioInteractorData{
    //
}

protocol PortfolioInteractorInput{
    func fetchArt(request: Portfolio.FetchArt.Request)
}

class PortfolioInteractor: PortfolioInteractorData{
    var presenter: PortfolioPresenterInput?
}

extension PortfolioInteractor: PortfolioInteractorInput {
    func fetchArt(request: Portfolio.FetchArt.Request) {
        let worker = ArtListingWorker()
        worker.fetchListings { (result) in
            presenter?.didFetchArt(response: Portfolio.FetchArt.Response())
        }
    }
}
