//
//  MovieListViewModel.swift
//  TestProject
//
//  Created by Muhammad Waqas Bhati on 3/18/18.
//  Copyright © 2018 Emaar . All rights reserved.
//

import Foundation

class MovieListViewModel {
    
    var movieContainer: MovieContainer?
    private var dataAccessManager: MovieAPI?
    
    var movieSuccess: (() -> ())?
    var movieError: ((NetworkError?) -> ())?
    
    private var cellViewModels: [MovieViewModel] = [MovieViewModel]() {
        didSet {
            self.movieSuccess?()
        }
    }
    private var error: NetworkError? {
        didSet {
            self.movieError?(error)
        }
    }
    init(movieContainer: MovieContainer?) {
        self.movieContainer = movieContainer
    }
    init( apiService: MovieAPI?) {
        self.dataAccessManager = apiService
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> MovieViewModel {
        return cellViewModels[indexPath.row]
    }
    func initFetch() {
        dataAccessManager?.getMoviesList(url: Constant.MOVIE_URL.path, completion: { [weak self] (movieContainer, error) in
            self?.processFetchedData(movieContainer: (movieContainer as? MovieContainer)!, error: error)
        })
        
    }
    private func processFetchedData( movieContainer: MovieContainer , error: NetworkError?) {
        guard error == nil else {
            self.error = error!
            return
        }
        self.movieContainer = movieContainer
        var vms = [MovieViewModel]()
        for movie in self.movieContainer?.results ?? [Movie]() {
            vms.append(MovieViewModel(id: movie.id, imageURL: movie.poster_path, title: movie.title))
        }
        self.cellViewModels = vms
    }
    
}

struct MovieViewModel {
    var id: Int
    var imageURL: String
    var title: String
    
}
