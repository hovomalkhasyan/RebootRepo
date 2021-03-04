//
//  TrainingCell.swift
//  Reboot
//
//  Created by Hovo on 11/16/20.
//

import UIKit

protocol DidSelectDelegate: class {
    func didSelect(selectedIndex: String)
}

class TrainingCell: UITableViewCell {
    //MARK: - collectionView
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Property
    private var adsArray: [Ads] = []
    weak var delegate: DidSelectDelegate?
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    //MARK: - setupDelegate
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}

extension TrainingCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return adsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        if let image = adsArray[indexPath.row].image {
            cell.collectionCellImage.setImage(urlString: Constants.imageUrl + image)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelect(selectedIndex: adsArray[indexPath.row].url )
    }
}

extension TrainingCell {
    func setData(ads: [Ads]) {
        self.adsArray = ads
    }
}
