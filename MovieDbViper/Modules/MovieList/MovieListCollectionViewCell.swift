//
//  MovieListCollectionViewCell.swift
//  MovieDbViper
//
//  Created by Hansel Matthew on 21/10/22.
//

import UIKit
import SDWebImage

class MovieListCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MovieListCollectionViewCell"
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with movie: MovieResult) {
        guard let imageUrl = URL(string: movie.posterPath) else { return }
        imageView.sd_setImage(with: imageUrl, completed: nil)
    }
    
}
