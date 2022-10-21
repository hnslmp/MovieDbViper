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
    func requestApiMovieList()
}

// MARK: -

/// The Interactor for the MovieList module
final class MovieListInteractor: MovieListPresenterInteractorProtocol {
    
	// MARK: - Variables
    var genreSelected: String?
	weak var presenter: MovieListInteractorPresenterProtocol?

	// MARK: - MovieList Presenter to Interactor Protocol

	func requestTitle() {
		presenter?.set(title: "MovieList")
	}
    
    func requestApiMovieList() {
        guard let genreSelected = genreSelected else { return }
        ApiManager.shared.getMoviesList(genre: genreSelected) { result in
            switch result {
            case .success(let movies):
                self.presenter?.setMovieListData(movies)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
