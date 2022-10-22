//
//  MovieDetailViewController.swift
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
import YoutubePlayer_in_WKWebView

// MARK: Protocols

/// Should be conformed to by the `MovieDetailViewController` and referenced by `MovieDetailPresenter`
protocol MovieDetailPresenterViewProtocol: AnyObject {
    /** Sets the title for the view
     - parameters:
     - title The title to set
     */
    func set(title: String?)
    func setMovieVideoData(_ videoData: MovieVideoResult)
    func setMovieReviewData(_ reviewData: [MovieReviewResult])
}

// MARK: -

/// The View Controller for the MovieDetail module
class MovieDetailViewController: UIViewController, MovieDetailPresenterViewProtocol {

    // MARK: - Constants
    
    let presenter: MovieDetailViewPresenterProtocol
    
    // MARK: Variables
    
    var movieSelected: MovieResult?
    var videoData: MovieVideoResult?
    var reviewData: [MovieReviewResult]?
    
    lazy var playerView: WKYTPlayerView = {
        let player = WKYTPlayerView()
        return player
    }()
    
    // MARK: Inits
    
    init(presenter: MovieDetailViewPresenterProtocol) {
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
        setupView()
        view.backgroundColor = .white
    }
    
    func setupView() {
        
        view.addSubview(playerView)
        playerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.width.equalToSuperview().inset(24)
            make.height.equalTo(320)
            make.centerX.equalToSuperview()
        }
        
        if let movieSelected = movieSelected {

            let titleLabel = UILabel()
            titleLabel.text = "Title: \(movieSelected.title)"
            
            let releaseDateLabel = UILabel()
            releaseDateLabel.text = "Release date: \(movieSelected.releaseDate)"
            
            let overviewLabel = UILabel()
            overviewLabel.text = "Overview : \(movieSelected.overview)"
            overviewLabel.lineBreakMode = .byWordWrapping
            overviewLabel.numberOfLines = 8
            
            let labelStackView = UIStackView(arrangedSubviews: [titleLabel, releaseDateLabel, overviewLabel])
            labelStackView.axis = .vertical
            labelStackView.spacing = 8
            
            view.addSubview(labelStackView)
            labelStackView.snp.makeConstraints { make in
                make.top.equalTo(playerView.snp.bottom).offset(24)
                make.leading.equalToSuperview().inset(24)
                make.trailing.equalToSuperview().inset(24)
            }
        }
    }
    
    // MARK: - MovieDetail Presenter to View Protocol
    
    func set(title: String?) {
        self.title = title
    }
    
    func setMovieVideoData(_ videoData: MovieVideoResult) {
        self.videoData = videoData
        DispatchQueue.main.async {
            self.playerView.load(withVideoId: videoData.key)
        }
    }
    
    func setMovieReviewData(_ reviewData: [MovieReviewResult]) {
        self.reviewData = reviewData
    }
}

extension MovieDetailViewController: WKYTPlayerViewDelegate {
    
    func playerViewDidBecomeReady(_ playerView: WKYTPlayerView) {
        playerView.playVideo()
    }
    
}
