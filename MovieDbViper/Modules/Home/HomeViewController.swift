//
//  HomeViewController.swift
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

/// Should be conformed to by the `HomeViewController` and referenced by `HomePresenter`
protocol HomePresenterViewProtocol: class {
	/** Sets the title for the view
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}

// MARK: -

/// The View Controller for the Home module
class HomeViewController: UIViewController, StoryboardIdentifiable, HomePresenterViewProtocol {

	// MARK: - Constants

	// MARK: Variables

	var presenter: HomeViewPresenterProtocol?

	// MARK: - Load Functions

	override func viewDidLoad() {
    	super.viewDidLoad()
		presenter?.viewLoaded()

		view.backgroundColor = .white
    }

	// MARK: - Home Presenter to View Protocol

	func set(title: String?) {
		self.title = title
	}
}
