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
import SnapKit

// MARK: Protocols

/// Should be conformed to by the `HomeViewController` and referenced by `HomePresenter`
protocol HomePresenterViewProtocol: class {
	/** Sets the title for the view
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
    func updateGenre(_ genres: [Genre])
}

// MARK: -

/// The View Controller for the Home module
class HomeViewController: UIViewController, HomePresenterViewProtocol {

	// MARK: - Constants

	let presenter: HomeViewPresenterProtocol

	// MARK: Variables
    
    // TODO: delete later
    private let data: [String] = ["India","Horror","Comedy","Alfa","Omega"]
    
    private var genresData: [Genre] = []
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .clear
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    

	// MARK: Inits

	init(presenter: HomeViewPresenterProtocol) {
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
        setupTableView()
		view.backgroundColor = .white
    }

	// MARK: - Home Presenter to View Protocol

	func set(title: String?) {
		self.title = title
	}
    
    func updateGenre(_ genres: [Genre]) {
        self.genresData = genres
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genresData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.backgroundColor = UIColor.white
        cell.textLabel?.text = genresData[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        presenter.goToMovie
    }
    
}
