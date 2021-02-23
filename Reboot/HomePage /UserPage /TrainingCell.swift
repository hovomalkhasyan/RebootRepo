//
//  TrainingCell.swift
//  Reboot
//
//  Created by Hovo on 11/16/20.
//

import UIKit
import Alamofire
class TrainingCell: UITableViewCell {
    
    var ads = [String]()
    @IBOutlet weak private var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
//        userInfoRequest()
        //        accountRequest()
    }
    
    private func userInfoRequest() {
        NetWorkService.request(url: Constants.MOBILE_API, method: .get, param: nil, encoding: JSONEncoding.prettyPrinted) { (resp: RequestResult<BaseResponseModel?>) in
            switch resp {
            case .success(let model):
                guard let m = model, let finalModel = m else { return }
//                self.ads = finalModel.ads ?? []
                print(model)
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}

extension TrainingCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
//        if let image = ads[indexPath.row].image {
//            cell.collectionCellImage.setImage(urlString: image)
//        } else {
//            cell.collectionCellImage.image = UIImage(named: "Group 1")
//        }
        cell.collectionCellImage.image = UIImage(named: "MAp")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = contentView.frame.height
        let width = height * 15 / 6
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
