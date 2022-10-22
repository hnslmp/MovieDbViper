//
//  MovieDetailPresenter.swift
//  Project: MovieDbViper
//
//  Module: MovieDetail
//
//  By Hansel Matthew 22/10/22
//  ___ORGANIZATIONNAME___ 2022
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `MovieDetailPresenter` and referenced by `MovieDetailViewController`
protocol MovieDetailViewPresenterProtocol: ViewPresenterProtocol {

}

/// Should be conformed to by the `MovieDetailPresenter` and referenced by `MovieDetailInteractor`
protocol MovieDetailInteractorPresenterProtocol: AnyObject {
	/** Sets the title for the presenter
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
    func setMovieVideoData(_ videoData: MovieVideoResult)
}

// MARK: -

/// The Presenter for the MovieDetail module
final class MovieDetailPresenter: MovieDetailViewPresenterProtocol, MovieDetailInteractorPresenterProtocol {
    

	// MARK: - Constants

	let router: MovieDetailPresenterRouterProtocol
	let interactor: MovieDetailPresenterInteractorProtocol

	// MARK: Variables

	weak var view: MovieDetailPresenterViewProtocol?

	// MARK: Inits

	init(router: MovieDetailPresenterRouterProtocol, interactor: MovieDetailPresenterInteractorProtocol) {
		self.router = router
		self.interactor = interactor
	}

	// MARK: - MovieDetail View to Presenter Protocol

	func viewLoaded() {
		interactor.requestTitle()
        interactor.requestMovieVideo()
	}

	// MARK: - MovieDetail Interactor to Presenter Protocol

	func set(title: String?) {
		view?.set(title: title)
	}
    
    func setMovieVideoData(_ videoData: MovieVideoResult) {
        view?.setMovieVideoData(videoData)
    }
}
