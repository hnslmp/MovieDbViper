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
protocol MovieListPresenterViewProtocol: AnyObject {
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
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 144, height: 288)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieListCollectionViewCell.self, forCellWithReuseIdentifier: MovieListCollectionViewCell.identifier)
        return collectionView
    }()

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
        
        configureCollectionView()
    }
    
    func configureCollectionView() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }

	// MARK: - MovieList Presenter to View Protocol

	func set(title: String?) {
		self.title = title
	}
    
    func updateMovieListData(_ movies: [MovieResult]) {
        self.movieListData.append(contentsOf: movies)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieListData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.identifier, for: indexPath) as? MovieListCollectionViewCell else { return UICollectionViewCell() }
        cell.backgroundColor = .systemPink
        cell.configure(with: movieListData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = movieListData[indexPath.row]
        presenter.goToMovieDetail(selectedMovie)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == movieListData.count - 2 {
            presenter.requestApiMovieList()
        }
    }
}
