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

}

/// Should be conformed to by the `MovieListPresenter` and referenced by `MovieListInteractor`
protocol MovieListInteractorPresenterProtocol: class {
	/** Sets the title for the presenter
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
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

	// MARK: - MovieList Interactor to Presenter Protocol

	func set(title: String?) {
		view?.set(title: title)
	}
}
