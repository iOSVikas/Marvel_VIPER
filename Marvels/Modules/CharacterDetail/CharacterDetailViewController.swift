//
//  CharacterDetailViewController.swift
//  Marvels
//
//  Created by Vikas on 02/06/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import UIKit

class CharacterDetailViewController: UIViewController {

    var presenter: CharacterDetailPresenter!
    
    @IBOutlet weak var stackContainerView: UIStackView!
    @IBOutlet weak var headerContainerView: UIView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var marvelCollectionView: UICollectionView!
    @IBOutlet weak var headerWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerHeightConstraing: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
        self.setupCollectionView()
        self.updateHeaderFrame()
        self.setbackButton()

    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.updateHeaderFrame()
        })
    }
}


//MARK: Supporting functions
extension CharacterDetailViewController: CharacterDetailViewProtocol {
    
    func updateHeaderFrame() {
        if UIDevice.current.orientation.isLandscape {
            stackContainerView.axis = .horizontal
            headerWidthConstraint.constant = self.view.bounds.width/2
            headerHeightConstraing.constant = self.view.bounds.height
        } else {
            stackContainerView.axis = .vertical
            headerWidthConstraint.constant = self.view.bounds.width
            headerHeightConstraing.constant = self.view.bounds.height*0.40
        }
        self.view.setNeedsLayout()
        self.view.setNeedsDisplay()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15, execute: {
            self.marvelCollectionView.reloadData()
        })
        
    }
    
    func showLoader(message: String?) {
        MLoader.shared.showLoader(message: message ?? "")
    }
    
    func hideLoader() {
        MLoader.shared.hideLoader()
    }
    
    func setupCollectionView() {
        
        marvelCollectionView.register(UINib(nibName: "CharacterDetailCell", bundle: nil), forCellWithReuseIdentifier: CharacterDetailCell.reuseIdentifier)
        
        self.marvelCollectionView.delegate = self
        self.marvelCollectionView.dataSource = self
    }
    
    func setbackButton() {
        let leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "Navigation_Back"), style: .done, target: self, action: #selector(self.didSelectBackButton))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    @objc func didSelectBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message,preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
            self.didSelectBackButton()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: UICollectionView Delegate and Datasource
extension CharacterDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.presenter.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter.numberOfRowsAt(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionHeader) {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CartHeaderCollectionReusableView", for: indexPath)
            for view in headerView.subviews {
                view.removeFromSuperview()
            }
            let label = UILabel(frame: CGRect(x: 20, y: 20, width: collectionView.frame.width - 10, height: 40))
            label.textColor = .red
            label.font = UIFont.boldSystemFont(ofSize: 19)
            label.text = presenter.titleFor(section: indexPath.section)
            headerView.addSubview(label)
            
            // Customize headerView here
            return headerView
        }
        fatalError()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 60.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterDetailCell.reuseIdentifier, for: indexPath) as! CharacterDetailCell
        if let item = self.presenter.characterAt(indexPath: indexPath) {
            cell.configure(item: item)
        }
        return cell
        
    }
}

extension CharacterDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(UIDevice.current.orientation.isLandscape) {
            let width = (collectionView.frame.width-30)/3
            return CGSize(width: width, height: width*1.20)
        }
        else {
            let width = (self.view.frame.width-30)/3
            return CGSize(width: width, height: width*1.20)
        }
    }
}



// MARK - ViewModel Interactor methods
extension CharacterDetailViewController {
    
    func setDisplayFrom(character: Character) {
        headerImageView.image = UIImage(named: "BannerPlaceholder")
        if let imageURL = character.imageUrl() {
            headerImageView.kf.indicatorType = .activity
            headerImageView.kf.setImage(with: URL(string: imageURL))
        }
        titleLabel.text = character.name
        descriptionLabel.text = character.description
        marvelCollectionView.reloadData()
    }
    
    func clearDisplayValues(message: String) {
        headerImageView.image = UIImage(named: "BannerPlaceholder")
        titleLabel.text = ""
        descriptionLabel.text = ""
        marvelCollectionView.reloadData()
        self.showAlert(title: "Marvels!", message: message)
    }
}
