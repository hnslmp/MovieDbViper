//
//  MovieDetailModule.swift
//  Project: MovieDbViper
//
//  Module: MovieDetail
//
//  By Hansel Matthew 22/10/22
//  ___ORGANIZATIONNAME___ 2022
//

// MARK: Imports

import SwiftyVIPER
import UIKit

// MARK: -

/// Used to initialize the MovieDetail VIPER module
final class MovieDetailModule: ModuleProtocol {

	// MARK: - Variables

	private(set) lazy var interactor: MovieDetailInteractor = {
		MovieDetailInteractor()
	}()

	private(set) lazy var router: MovieDetailRouter = {
		MovieDetailRouter()
	}()

	private(set) lazy var presenter: MovieDetailPresenter = {
		MovieDetailPresenter(router: self.router, interactor: self.interactor)
	}()

	private(set) lazy var view: MovieDetailViewController = {
		MovieDetailViewController(presenter: self.presenter)
	}()

	// MARK: - Module Protocol Variables

	var viewController: UIViewController {
		return view
	}

	// MARK: Inits

    init(movieSelected: MovieResult) {
		presenter.view = view
		router.viewController = view
		interactor.presenter = presenter

	}
}
