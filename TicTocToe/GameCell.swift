//
//  GameCell.swift
//  TicTocToe
//
//  Created by DCS on 03/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class GameCell: UICollectionViewCell {
    
    private let myImg: UIImageView = {
        
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.layer.cornerRadius = 6
        img.clipsToBounds = true
        img.tintColor = .purple
        return img
    }()
    
    func setupCell(with status:Int){
        contentView.layer.borderColor = UIColor.blue.cgColor
        contentView.layer.borderWidth = 3
        contentView.addSubview(myImg)
        myImg.frame = CGRect(x: 10, y: 10, width: 60, height: 60)
        let name = status == 0 ? "O" : status == 1 ? "X" : ""
            myImg.image = UIImage(named: name)
        
    }
    
}
