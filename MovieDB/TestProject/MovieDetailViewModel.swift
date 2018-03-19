//
//  MovieDetailViewModel.swift
//  TestProject
//
//  Created by Muhammad Waqas Bhati on 3/18/18.
//  Copyright © 2018 Emaar . All rights reserved.
//

import Foundation
import UIKit

class MovieDetailViewModel {
    
    var movieDetail: MovieDetail?
    
    var movieId: Int?
    var movieImage: UIImage?

    var releaseDate: String?
    var originalTitle: String?
    var tagLine: String?
    var voteCount: Int?
    var overView: String?
    var voteAverage: Double?
    
    private var dataAccessManager: MovieDetailAPI?
    
    var movieSuccess: (() -> ())?
    var movieError: ((NetworkError?) -> ())?
    
    private var movieViewModel: MovieDetailViewModel? {
        didSet {
            self.movieSuccess?()
        }
    }
    private var error: NetworkError? {
        didSet {
            self.movieError?(error)
        }
    }
    func getMovieVM() -> MovieDetailViewModel? {
        return movieViewModel
    }
    init(releaseDate: String, originalTitle: String, tagLine: String, voteCount: Int, overView: String, voteAverage: Double, movieImage: UIImage, movieID: Int) {
        self.releaseDate = releaseDate
        self.originalTitle = originalTitle
        self.tagLine = tagLine
        self.voteCount = voteCount
        self.overView = overView
        self.voteAverage = voteAverage
        self.movieImage = movieImage
        self.movieId = movieID
    }
    init(movieID: Int, movieImage: UIImage, apiService: MovieDetailAPI) {
        self.movieId = movieID
        self.movieImage = movieImage
        self.dataAccessManager = apiService
    }
    init(movieDetail: MovieDetail?) {
        self.movieDetail = movieDetail
    }
    init( apiService: MovieDetailAPI) {
        self.dataAccessManager = apiService
    }
    
    func initFetch(url: String) {
        dataAccessManager?.getMovieDetail(url: url, completion: { [weak self] (movieDetail, error) in
            self?.processFetchedData(movieDetail: (movieDetail as? MovieDetail)!, error: error)
        })
    }
    private func processFetchedData( movieDetail: MovieDetail , error: NetworkError?) {
        guard error == nil else {
            self.error = error!
            return
        }
        self.movieDetail = movieDetail
        self.movieViewModel = MovieDetailViewModel(releaseDate: movieDetail.release_date, originalTitle: movieDetail.original_title, tagLine: movieDetail.tagline, voteCount: movieDetail.vote_count, overView: movieDetail.overview, voteAverage: movieDetail.vote_average, movieImage: self.movieImage!, movieID: self.movieId!)
    }
    
}
