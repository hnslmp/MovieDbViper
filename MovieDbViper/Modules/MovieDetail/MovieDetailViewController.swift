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
}

// MARK: -

/// The View Controller for the MovieDetail module
class MovieDetailViewController: UIViewController, MovieDetailPresenterViewProtocol {
    
    // MARK: - Constants
    
    let presenter: MovieDetailViewPresenterProtocol
    
    // MARK: Variables
    
    var movieSelected: MovieResult?
    var videoData: MovieVideoResult?
    
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
        view.backgroundColor = .red
    }
    
    func setupView() {
        
        view.addSubview(playerView)
        playerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.width.equalToSuperview().inset(24)
            make.height.equalTo(320)
            make.centerX.equalToSuperview()
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
}

extension MovieDetailViewController: WKYTPlayerViewDelegate {
    
    func playerViewDidBecomeReady(_ playerView: WKYTPlayerView) {
        playerView.playVideo()
    }
    
}
