//
//  MovieDetailRouter.swift
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

/// Should be conformed to by the `MovieDetailRouter` and referenced by `MovieDetailPresenter`
protocol MovieDetailPresenterRouterProtocol: PresenterRouterProtocol {

}

// MARK: -

/// The Router for the MovieDetail module
final class MovieDetailRouter: RouterProtocol, MovieDetailPresenterRouterProtocol {

	// MARK: - Variables

	weak var viewController: UIViewController?
}
