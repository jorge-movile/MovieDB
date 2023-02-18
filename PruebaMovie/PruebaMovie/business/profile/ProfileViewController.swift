//
//  ProfileViewController.swift
//  PruebaMovie
//
//  Created Jorge Espinoza on 16/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import Nuke
import SCLAlertView

class ProfileViewController: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var lbTitleView: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lbUsername: UILabel!
    @IBOutlet weak var lbTitleFavorites: UILabel!
    @IBOutlet weak var collectionFavorites: UICollectionView!
    
    var presenter: ProfilePresenterProtocol?
    private let cellIdentifier = "MovieCell"
    private var dbManager = DBManager()
    private var moviesList: [FavoritesTable]?

	override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        
        presenter?.getAccount()
        
        moviesList = presenter?.getFavoriteList()
        collectionFavorites.reloadData()
    }
    
    func setUpView() {
        
        imgProfile.layer.cornerRadius = imgProfile.frame.size.width / 2
        
        lbTitleView.text = Constants.profileTitle
        lbTitleView.textColor = Colors.greenItemMovies
        lbUsername.textColor = Colors.greenItemMovies
        lbTitleFavorites.text = Constants.favoritesTitle
        lbTitleFavorites.textColor = Colors.greenItemMovies
        
        collectionFavorites.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        
        
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesList?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MovieCell
        
        let movie = moviesList?[indexPath.row]
        
        cell.btnFavorite.isHidden = true
        cell.lbTitleMovie.text = movie?.title ?? ""
        cell.lbDateMovie.text = DateTimeFunctions.dateFormat(dateString: movie?.date ?? "", inputFormat: "yyyy-mm-dd", outputFomrat: "MMM, d yyyy")
        cell.lbRateMovie.text = "\(movie?.rate ?? 0)"
        cell.lbDescriptionMovie.text = movie?.overview ?? ""
        
        if let urlPhoto = movie?.posterPath {
            cell.imageMovie.setImageFromUrl(urlPhoto: urlPhoto)
        }
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension ProfileViewController: ProfileViewProtocol {
    
    func showMessage(message: String) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            SCLAlertView().showError("Warning", subTitle: message)
        }
    }
    
    func showLoading() {
        self.startAnimating(Constants.LoadingConfig.size, type: NVActivityIndicatorType.lineSpinFadeLoader, color: Colors.greenItemMovies)
    }
    
    func hideLoading() {
        self.stopAnimating()
    }
    
    func setAccount(response: AccountResponse) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.lbUsername.text = response.username
        }
    }
}
