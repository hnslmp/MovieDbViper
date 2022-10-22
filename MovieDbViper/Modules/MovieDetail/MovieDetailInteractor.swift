//
//  MovieDetailInteractor.swift
//  Project: MovieDbViper
//
//  Module: MovieDetail
//
//  By Hansel Matthew 22/10/22
//  ___ORGANIZATIONNAME___ 2022
//

// MARK: Imports

import Foundation
import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `MovieDetailInteractor` and referenced by `MovieDetailPresenter`
protocol MovieDetailPresenterInteractorProtocol {
	/// Requests the title for the presenter
	func requestTitle()
}

// MARK: -

/// The Interactor for the MovieDetail module
final class MovieDetailInteractor: MovieDetailPresenterInteractorProtocol {

	// MARK: - Variables

	weak var presenter: MovieDetailInteractorPresenterProtocol?

	// MARK: - MovieDetail Presenter to Interactor Protocol

	func requestTitle() {
		presenter?.set(title: "MovieDetail")
	}
}
