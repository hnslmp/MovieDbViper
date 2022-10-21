//
//  MovieListModule.swift
//  Project: MovieDbViper
//
//  Module: MovieList
//
//  By Hansel Matthew 21/10/22
//  ___ORGANIZATIONNAME___ 2022
//

// MARK: Imports

import SwiftyVIPER
import UIKit

// MARK: -

/// Used to initialize the MovieList VIPER module
final class MovieListModule: ModuleProtocol {

	// MARK: - Variables

	private(set) lazy var interactor: MovieListInteractor = {
		MovieListInteractor()
	}()

	private(set) lazy var router: MovieListRouter = {
		MovieListRouter()
	}()

	private(set) lazy var presenter: MovieListPresenter = {
		MovieListPresenter(router: self.router, interactor: self.interactor)
	}()

	private(set) lazy var view: MovieListViewController = {
		MovieListViewController(presenter: self.presenter)
	}()

	// MARK: - Module Protocol Variables

	var viewController: UIViewController {
		return view
	}

	// MARK: Inits

	init() {
		presenter.view = view
		router.viewController = view
		interactor.presenter = presenter
	}
}
