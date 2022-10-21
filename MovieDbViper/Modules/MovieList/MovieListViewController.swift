//
//  MovieListViewController.swift
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

/// Should be conformed to by the `MovieListViewController` and referenced by `MovieListPresenter`
protocol MovieListPresenterViewProtocol: class {
	/** Sets the title for the view
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
    func updateMovieListData(_ movies: [MovieResult])
}

// MARK: -

/// The View Controller for the MovieList module
class MovieListViewController: UIViewController, MovieListPresenterViewProtocol {

	// MARK: - Constants

	let presenter: MovieListViewPresenterProtocol

	// MARK: Variables
    private var movieListData: [MovieResult] = []

	// MARK: Inits

	init(presenter: MovieListViewPresenterProtocol) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Load Functions

	override func viewDidLoad() {
    	super.viewDidLoad()
		presenter.viewLoaded()

		view.backgroundColor = .white
    }

	// MARK: - MovieList Presenter to View Protocol

	func set(title: String?) {
		self.title = title
	}
    
    func updateMovieListData(_ movies: [MovieResult]) {
        self.movieListData = movies
    }
}
