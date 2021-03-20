//
//  MovieCollectionViewCell.swift
//  Movie Search
//
//  Created by Mohmed Master on 2021/03/04.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var movieRatingLabel: UILabel!
    @IBOutlet private weak var movieGenreLabel: UILabel!
    @IBOutlet private weak var movieTitleLabelHeightConstraint: NSLayoutConstraint! = nil

    var currentTitleLabelHeight: CGFloat {
        movieTitleLabelHeightConstraint.constant
    }

    func updateTitleLabelHeight(to value: CGFloat) {
        movieTitleLabelHeightConstraint.constant = value
        movieTitleLabel.setNeedsUpdateConstraints()
        movieTitleLabel.setNeedsLayout()
    }

    func updateMovieTitleRating(_ title: String, _ rating: Double) {
        movieTitleLabel.text = title
        movieTitleLabelHeightConstraint.constant = movieTitleLabel.sizeThatFits(movieTitleLabel.bounds.size).height
        movieRatingLabel.text = NSLocalizedString("Rating: ", comment: "How's the movie rating?") + rating.description
    }

    func updateMovieGenre(genre: [Genre]) {
        let genreNames = genre.compactMap({ $0.name })
        movieGenreLabel.text = genreNames.joined(separator: ", ")
    }

    func updateMovieImage(movieImage: UIImage) {
        movieImageView.image = movieImage
    }
}
