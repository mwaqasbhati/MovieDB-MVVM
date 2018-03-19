//
//  InventoryViewController.swift
//  TestProject
//
//  Created by Muhammad Waqas on 3/06/18.
//  Copyright © 2018 Emaar . All rights reserved.
//

import Foundation
import UIKit
import HCSStarRatingView

class MovieDetailViewController: UIViewController {
    
    // MARK: - Properties

    var movieDetailViewModel: MovieDetailViewModel?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagLineLabel: UILabel!
    @IBOutlet weak var ratingView: HCSStarRatingView!
    @IBOutlet weak var voteCountBtn: UIButton!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var imageViewCover: UIImageView!
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        HUD.show(view: view)
        movieDetailViewModel?.movieSuccess = { [weak self] in
            HUD.hide(view: self?.view)
            self?.movieDetailViewModel = self?.movieDetailViewModel?.getMovieVM()
            DispatchQueue.main.async {
                self?.updateUI()
            }
        }
        movieDetailViewModel?.movieError = { [weak self] (error) in
            HUD.hide(view: self?.view)
            guard error == nil else {
                self?.showAlertInViewController(titleStr: Constant.Alert.title, messageStr: error?.localizedDescription ?? "", okButtonTitle: Constant.Alert.ok)
                return
            }
        }
        let id = movieDetailViewModel?.movieId
        let url = Constant.MOVIE_DETAIL_URL.path + String(describing: id!) + "?api_key=" + Constant.API_KEY
        movieDetailViewModel?.initFetch(url: url)
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension MovieDetailViewController {
    // MARK: - Helpers
    private func updateUI() {
        guard movieDetailViewModel != nil else { return }
        let date: String? = movieDetailViewModel?.releaseDate
        titleLabel.text = (movieDetailViewModel?.originalTitle ?? "") + " (\(String(describing: date!.getYear())))"
        tagLineLabel.text = movieDetailViewModel?.tagLine
        let count: Int? = movieDetailViewModel?.voteCount
        let voteCount = String(describing: count ?? 0)
        voteCountBtn.setTitle(voteCount, for: .normal)
        descLabel.text = movieDetailViewModel?.overView
        ratingView.value = CGFloat((movieDetailViewModel?.voteAverage)!)
        imageViewCover.image = movieDetailViewModel?.movieImage
    }

}



