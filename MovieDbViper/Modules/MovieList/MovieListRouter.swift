//
//  MovieListRouter.swift
//  Project: MovieDbViper
//
//  Module: MovieList
//
//  By Hansel Matthew 21/10/22
//  ___ORGANIZATIONNAME___ 2022
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `MovieListRouter` and referenced by `MovieListPresenter`
protocol MovieListPresenterRouterProtocol: PresenterRouterProtocol {
    func goToMovieDetail(_ selectedMovie: MovieResult)
}

// MARK: -

/// The Router for the MovieList module
final class MovieListRouter: RouterProtocol, MovieListPresenterRouterProtocol {

	// MARK: - Variables

	weak var viewController: UIViewController?
    
    func goToMovieDetail(_ selectedMovie: MovieResult) {
        viewController?.navigationController?.pushViewController(MovieDetailModule(movieSelected: selectedMovie).view, animated: true)
    }
}
