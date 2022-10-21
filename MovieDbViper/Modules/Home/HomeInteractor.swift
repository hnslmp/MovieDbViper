//
//  HomeInteractor.swift
//  Project: MovieDbViper
//
//  Module: Home
//
//  By Hansel Matthew 21/10/22
//  ___ORGANIZATIONNAME___ 2022
//

// MARK: Imports

import Foundation
import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `HomeInteractor` and referenced by `HomePresenter`
protocol HomePresenterInteractorProtocol {
	/// Requests the title for the presenter
	func requestTitle()
}

// MARK: -

/// The Interactor for the Home module
final class HomeInteractor: HomePresenterInteractorProtocol {

	// MARK: - Variables

	weak var presenter: HomeInteractorPresenterProtocol?

	// MARK: - Home Presenter to Interactor Protocol

	func requestTitle() {
		presenter?.set(title: "Home")
	}
}
