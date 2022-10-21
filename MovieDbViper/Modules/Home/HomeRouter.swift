//
//  HomeRouter.swift
//  Project: MovieDbViper
//
//  Module: Home
//
//  By Hansel Matthew 21/10/22
//  ___ORGANIZATIONNAME___ 2022
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `HomeRouter` and referenced by `HomePresenter`
protocol HomePresenterRouterProtocol: PresenterRouterProtocol {

    func goToMovieList(_ genreSelected: String)

}

// MARK: -

/// The Router for the Home module
final class HomeRouter: RouterProtocol, HomePresenterRouterProtocol {
    
	// MARK: - Variables

	weak var viewController: UIViewController?
    
    func goToMovieList(_ genreSelected: String) {
        viewController?.navigationController?.pushViewController(MovieListModule(genreSelected: genreSelected).view, animated: true)
    }
}
