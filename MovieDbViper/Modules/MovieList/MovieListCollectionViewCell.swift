//
//  MovieListCollectionViewCell.swift
//  MovieDbViper
//
//  Created by Hansel Matthew on 21/10/22.
//

import UIKit
import SDWebImage

class MovieListCollectionViewCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
}
