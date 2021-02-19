//
//  ReserveCell.swift
//  Reboot
//
//  Created by Hovo on 11/13/20.
//

import UIKit
import Kingfisher

class ReserveCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak private var cellView: UIView!
    @IBOutlet weak private var date: UILabel!
    
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

//MARK: - setupView
extension ReserveCell {
    private func setupView() {
        cellView.layer.cornerRadius = 10
        cellView.layer.borderColor = UIColor.lightGray.cgColor
        cellView.layer.borderWidth = 0.1
        UIColor.black.withAlphaComponent(0.16)
        cellView.layer.shadowColor =  UIColor.black.withAlphaComponent(0.16).cgColor
        cellView.layer.shadowRadius = 10
        cellView.layer.shadowOffset = CGSize(width: 0, height: 1)
        cellView.layer.shadowOpacity = 1
        cellView.layer.shadowRadius = 3
    }
}

extension ReserveCell {
    func setData(model: Object) {
        let finalString = NSMutableAttributedString(string: "")
            finalString
            .withGiloryMadium(model.workout.dateFrom.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss", outGoingFormat: "dd.MM/"))
            .withUltraLightItalic(model.workout.dateFrom.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss", outGoingFormat: "HH:mm"))
            .withBold(" \(model.workout.trainer.title)")
            .withGilroyRegular(" \(model.workout.workoutDay.room.slug)")
            .withGilroyRegular(" \(model.workoutPlace.roomPlace.placeNumber)")
        
        self.date.attributedText = finalString
    }
}
