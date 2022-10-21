//
//  HomePresenter.swift
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

/// Should be conformed to by the `HomePresenter` and referenced by `HomeViewController`
protocol HomeViewPresenterProtocol: ViewPresenterProtocol {
    func goToMovieList(_ genreSelected: String)
}

/// Should be conformed to by the `HomePresenter` and referenced by `HomeInteractor`
protocol HomeInteractorPresenterProtocol: class {
	/** Sets the title for the presenter
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
    func setGenreData(_ genres: [Genre])
}

// MARK: -

/// The Presenter for the Home module
final class HomePresenter: HomeViewPresenterProtocol, HomeInteractorPresenterProtocol {
    
	// MARK: - Constants

	let router: HomePresenterRouterProtocol
	let interactor: HomePresenterInteractorProtocol

	// MARK: Variables

	weak var view: HomePresenterViewProtocol?

	// MARK: Inits

	init(router: HomePresenterRouterProtocol, interactor: HomePresenterInteractorProtocol) {
		self.router = router
		self.interactor = interactor
	}

	// MARK: - Home View to Presenter Protocol

	func viewLoaded() {
		interactor.requestTitle()
        interactor.requestApiGenres()
	}

	// MARK: - Home Interactor to Presenter Protocol

	func set(title: String?) {
		view?.set(title: title)
	}
    
    func setGenreData(_ genres: [Genre]) {
        view?.updateGenre(genres)
    }
    
    func goToMovieList(_ genreSelected: String) {
        router.goToMovieList(genreSelected)
    }
}
