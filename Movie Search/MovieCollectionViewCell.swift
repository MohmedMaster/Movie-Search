//
//  MovieCollectionViewCell.swift
//  Movie Search
//
//  Created by Mohmed Master on 2021/03/04.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieGenreLabel: UILabel!
    @IBOutlet weak var movieTitleLabelHeightConstraint: NSLayoutConstraint!
    
    var currentTitleLabelHeight: CGFloat {
        movieTitleLabelHeightConstraint.constant
    }

    
    func updateTitleLabelHeight(to value: CGFloat) {
        movieTitleLabelHeightConstraint.constant = value
        movieTitleLabel.setNeedsLayout()
    }


    func updateMovieTitleAndRating(with title: String, with number: Double)
    {
        movieTitleLabel.text = title
        movieTitleLabelHeightConstraint.constant = movieTitleLabel.sizeThatFits(movieTitleLabel.bounds.size).height
        movieRatingLabel.text = "Rating:  " + number.description
    }
    
    func updateMovieGenre(with genre: [Genre]) {
        let genreNames = genre.compactMap({ $0.name })
        movieGenreLabel.text = genreNames.joined(separator: ", ")
    }
    
    func loadMovieImage(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self?.movieImageView.image = image
            }
        }
        task.resume()
    }
}
