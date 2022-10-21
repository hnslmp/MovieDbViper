//
//  MovieListInteractor.swift
//  Project: MovieDbViper
//
//  Module: MovieList
//
//  By Hansel Matthew 21/10/22
//  ___ORGANIZATIONNAME___ 2022
//

// MARK: Imports

import Foundation
import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `MovieListInteractor` and referenced by `MovieListPresenter`
protocol MovieListPresenterInteractorProtocol {
	/// Requests the title for the presenter
	func requestTitle()
}

// MARK: -

/// The Interactor for the MovieList module
final class MovieListInteractor: MovieListPresenterInteractorProtocol {

	// MARK: - Variables

	weak var presenter: MovieListInteractorPresenterProtocol?

	// MARK: - MovieList Presenter to Interactor Protocol

	func requestTitle() {
		presenter?.set(title: "MovieList")
	}
}
