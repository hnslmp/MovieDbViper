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
    func requestMovieVideo()
    func requestMovieReview()
}

// MARK: -

/// The Interactor for the MovieDetail module
final class MovieDetailInteractor: MovieDetailPresenterInteractorProtocol {
    
	// MARK: - Variables
    var movieSelected: MovieResult?
    var moviePage = 1
	weak var presenter: MovieDetailInteractorPresenterProtocol?

	// MARK: - MovieDetail Presenter to Interactor Protocol

	func requestTitle() {
        presenter?.set(title: "Movie Detail")
	}
    
    func requestMovieVideo() {
        guard let movieSelected = movieSelected else { return }
        ApiManager.shared.getMovieVideo(movieId: movieSelected.id) { result in
            switch result {
            case .success(let videos):
                self.presenter?.setMovieVideoData(videos)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestMovieReview() {
        guard let movieSelected = movieSelected else { return }
        ApiManager.shared.getMovieReview(movieId: movieSelected.id, page: moviePage) { result in
            switch result {
            case .success(let reviews):
                self.presenter?.setMovieReviewData(reviews)
                self.moviePage += 1
            case .failure(let error):
                print(error)
            }
        }
    }
}
