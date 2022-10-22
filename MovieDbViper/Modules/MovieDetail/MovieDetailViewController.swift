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
    private var videoData: MovieVideoResult?
    private var reviewData: [MovieReviewResult] = []
    
    private lazy var playerView: WKYTPlayerView = {
        let player = WKYTPlayerView()
        return player
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var tableViewLabel = UILabel()
    
    private var labelStackView = UIStackView()
    
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
            
            labelStackView = UIStackView(arrangedSubviews: [titleLabel, releaseDateLabel, overviewLabel])
            labelStackView.axis = .vertical
            labelStackView.spacing = 8
            
            view.addSubview(labelStackView)
            labelStackView.snp.makeConstraints { make in
                make.top.equalTo(playerView.snp.bottom).offset(24)
                make.leading.equalToSuperview().inset(24)
                make.trailing.equalToSuperview().inset(24)
            }
        }
        
        setupTableView()
    }
    
    func setupTableView() {
        tableViewLabel.text = "Movie Reviews: "
        view.addSubview(tableViewLabel)
        tableViewLabel.snp.makeConstraints { make in
            make.top.equalTo(labelStackView.snp.bottom).offset(12)
            make.leading.equalToSuperview().inset(24)
            make.trailing.equalToSuperview().inset(24)
        }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(tableViewLabel.snp.bottom)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(24)
            make.trailing.equalToSuperview().inset(24)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
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
        if reviewData.isEmpty {
            DispatchQueue.main.async {
                self.tableViewLabel.text = "No Review Data Available!"
            }
        } else {
            self.reviewData = reviewData
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension MovieDetailViewController: WKYTPlayerViewDelegate {
    
    func playerViewDidBecomeReady(_ playerView: WKYTPlayerView) {
        playerView.playVideo()
    }
    
}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.backgroundColor = UIColor.white
        cell.textLabel?.text = reviewData[indexPath.row].content
        return cell
    }
    
}
