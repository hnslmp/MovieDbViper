//
//  MovieListPresenter.swift
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

/// Should be conformed to by the `MovieListPresenter` and referenced by `MovieListViewController`
protocol MovieListViewPresenterProtocol: ViewPresenterProtocol {
    func goToMovieDetail(_ selectedMovie: MovieResult)
}

/// Should be conformed to by the `MovieListPresenter` and referenced by `MovieListInteractor`
protocol MovieListInteractorPresenterProtocol: AnyObject {
	/** Sets the title for the presenter
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
    func setMovieListData(_ movies: [MovieResult])
}

// MARK: -

/// The Presenter for the MovieList module
final class MovieListPresenter: MovieListViewPresenterProtocol, MovieListInteractorPresenterProtocol {
    
	// MARK: - Constants

	let router: MovieListPresenterRouterProtocol
	let interactor: MovieListPresenterInteractorProtocol

	// MARK: Variables

	weak var view: MovieListPresenterViewProtocol?

	// MARK: Inits

	init(router: MovieListPresenterRouterProtocol, interactor: MovieListPresenterInteractorProtocol) {
		self.router = router
		self.interactor = interactor
	}

	// MARK: - MovieList View to Presenter Protocol

	func viewLoaded() {
		interactor.requestTitle()
        interactor.requestApiMovieList()
	}
    
    func goToMovieDetail(_ selectedMovie: MovieResult) {
        router.goToMovieDetail(selectedMovie)
    }

	// MARK: - MovieList Interactor to Presenter Protocol

	func set(title: String?) {
		view?.set(title: title)
	}
    
    func setMovieListData(_ movies: [MovieResult]) {
        view?.updateMovieListData(movies)
    }
}
