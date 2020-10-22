//
//  CardCollectionViewCell.swift
//  Agency APP
//
//  Created by hosam on 10/22/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    var data:TravelData?{
        didSet{
            guard let data = data else { return  }
            imageView.image = UIImage(named: data.img)
            placeLabel.text = data.title
            timeLabel.text = data.date
            statusLabel.text = data.statusLabel
            imageView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }
    }
    
    
    lazy var cardView:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 20
        v.backgroundColor = .white
        v.layer.masksToBounds = true
        return v
    }()
    
    lazy var imageView:UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "demo")
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    lazy var placeLabel = UILabel(text: "DOMINICIAN REPUBLIC", font: UIFont.systemFont(ofSize: 40, weight: .bold), textColor: .white, numberOfLines: 0)
    
    lazy var timeLabel = UILabel(text: "1.12.2020 - 26.12.2020", font: UIFont.systemFont(ofSize: 17, weight: .semibold), textColor: .white)
    
    lazy var overlayCard:UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(white: 0, alpha: 0.3)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var bottomCardView:UIView = {
        let v = UIView(backgroundColor: .white)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.constrainHeight(constant: 70)
        return v
    }()
    
    lazy var userImage1:UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "demo")
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.layer.borderColor = UIColor.white.cgColor
        img.layer.borderWidth = 3
        img.layer.cornerRadius = 17.5
        img.constrainWidth(constant: 35)
        img.constrainHeight(constant: 35)
        return img
    }()
    
    lazy var userImage2:UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "demo")
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.layer.borderColor = UIColor.white.cgColor
        img.layer.borderWidth = 3
        img.layer.cornerRadius = 17.5
        return img
    }()
    
    lazy var statusLabel = UILabel(text: "1 day until departure", font: UIFont.systemFont(ofSize: 15, weight: .semibold), textColor: .darkGray)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews()  {
        statusLabel.translatesAutoresizingMaskIntoConstraints=false
        stack(cardView)
        
        cardView.addSubViews(views: imageView,overlayCard,bottomCardView,placeLabel,timeLabel)
        bottomCardView.addSubViews(views: userImage1,userImage2,statusLabel)
        
        overlayCard.anchor(top: cardView.topAnchor, leading: cardView.leadingAnchor, bottom: cardView.bottomAnchor, trailing: cardView.trailingAnchor)
        imageView.anchor(top: cardView.topAnchor, leading: cardView.leadingAnchor, bottom: bottomCardView.topAnchor, trailing: cardView.trailingAnchor)
        bottomCardView.anchor(top: nil, leading: cardView.leadingAnchor, bottom: cardView.bottomAnchor, trailing: cardView.trailingAnchor)
        
        placeLabel.anchor(top: nil, leading: cardView.leadingAnchor, bottom: timeLabel.topAnchor, trailing: cardView.trailingAnchor,padding: .init(top: 0, left: 20, bottom: 5, right: 20))
        timeLabel.anchor(top: nil, leading: cardView.leadingAnchor, bottom: bottomCardView.topAnchor, trailing: cardView.trailingAnchor,padding: .init(top: 0, left: 20, bottom: 5, right: 20))
        
        NSLayoutConstraint.activate([
            
            userImage1.trailingAnchor.constraint(equalTo: bottomCardView.trailingAnchor, constant: -15),
            userImage1.centerYAnchor.constraint(equalTo: bottomCardView.centerYAnchor),
            
            userImage2.trailingAnchor.constraint(equalTo: userImage1.trailingAnchor, constant: -20),
            userImage2.heightAnchor.constraint(equalToConstant: 35),
            userImage2.widthAnchor.constraint(equalToConstant: 35),
            userImage2.centerYAnchor.constraint(equalTo: bottomCardView.centerYAnchor),
            
            statusLabel.centerYAnchor.constraint(equalTo: bottomCardView.centerYAnchor),
            statusLabel.leadingAnchor.constraint(equalTo: bottomCardView.leadingAnchor, constant: 20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
