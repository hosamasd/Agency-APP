//
//  ViewController.swift
//  Agency APP
//
//  Created by hosam on 10/22/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class AgencyVC: UIViewController {

    let imgArr = [
        TravelData(title: "BORACAY PHILIPPINES", date: "22.10.2020 - 5.11.2020", statusLabel: "1 day until departure", img: "img1"),
        TravelData(title: "ECUADOR", date: "24.10.2020 - 8.11.2020", statusLabel: "3 day until departure", img: "img2"),
        TravelData(title: "DOMINICIAN REPUBLIC", date: "27.10.2020 - 10.11.2020",statusLabel: "5 day until departure",img: "img3"),
    ]
    
    var currentCell = 0
    let collectionMargin = CGFloat(25)
    let itemSpacing = CGFloat(15)
    var itemWidth = CGFloat(0)
    let itemHeight = CGFloat(430)
    var context = CIContext(options: nil)
    
    lazy var collectionView:UICollectionView = {
        
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        itemWidth =  UIScreen.main.bounds.width - collectionMargin * 2.0
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.headerReferenceSize = CGSize(width: collectionMargin, height: 0)
        layout.footerReferenceSize = CGSize(width: collectionMargin, height: 0)
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumLineSpacing = itemSpacing
        
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.collectionViewLayout = layout
        cv.decelerationRate = UIScrollView.DecelerationRate.fast
        cv.backgroundColor = .clear
        cv.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: "CardCollectionViewCell")
        cv.delegate = self
        cv.dataSource = self
        cv.constrainHeight(constant: 450)
        return cv
    }()
    
    lazy var backgroundImg:UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: imgArr[0].img)
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }
    
    func setupViews()  {
        view.backgroundColor = UIColor(red: 231/255, green: 232/255, blue: 232/255, alpha: 1)

        view.addSubViews(views: backgroundImg,collectionView)
        
        backgroundImg.fillSuperview()
        collectionView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        /// Blurr the background image
        blurEffect()
    }

    func blurEffect() {
           let currentFilter = CIFilter(name: "CIGaussianBlur")
           let beginImage = CIImage(image: backgroundImg.image!)
           currentFilter!.setValue(beginImage, forKey: kCIInputImageKey)
           currentFilter!.setValue(10, forKey: kCIInputRadiusKey)

           let cropFilter = CIFilter(name: "CICrop")
           cropFilter!.setValue(currentFilter!.outputImage, forKey: kCIInputImageKey)
           cropFilter!.setValue(CIVector(cgRect: beginImage!.extent), forKey: "inputRectangle")

           let output = cropFilter!.outputImage
           let cgimg = context.createCGImage(output!, from: output!.extent)
           let processedImage = UIImage(cgImage: cgimg!)
           backgroundImg.image = processedImage
       }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
           let pageWidth = Float(itemWidth + itemSpacing)
           let targetXContentOffset = Float(targetContentOffset.pointee.x)
           let contentWidth = Float(collectionView.contentSize.width)
           var newPage = Float(self.currentCell)

           if velocity.x == 0 {
               newPage = floor( (targetXContentOffset - Float(pageWidth) / 2) / Float(pageWidth)) + 1.0
           } else {
               newPage = Float(velocity.x > 0 ? self.currentCell + 1 : self.currentCell - 1)
               if newPage < 0 {
                   newPage = 0
               }
               if (newPage > contentWidth / pageWidth) {
                   newPage = ceil(contentWidth / pageWidth) - 1.0
               }
           }
           self.currentCell = Int(newPage)
           let point = CGPoint (x: CGFloat(newPage * pageWidth), y: targetContentOffset.pointee.y)
           targetContentOffset.pointee = point
           
           let index = Int(targetContentOffset.pointee.x / (UIScreen.main.bounds.width - collectionMargin * 2.0))
           let indexPath = IndexPath(row: index, section: 0)
           let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
           if indexPath.row >= 0 && indexPath.row < imgArr.count {
               UIView.animate(withDuration: 0.5) {
                   self.backgroundImg.image = UIImage(named: self.imgArr[indexPath.row].img)
                   self.blurEffect()
               }
           }
           
           UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: .calculationModeCubic, animations: {
               cell?.imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
           })
           
           /// scale image back to normal for next and previous cell
           let previousIndex = index - 1
           let nextIndex = index + 1
           if previousIndex >= 0 {
               let indexPath = IndexPath(row: previousIndex, section: 0)
               let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
               UIView.animate(withDuration: 0.5) {
                   cell?.imageView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
               }
           }
           if nextIndex < imgArr.count {
               let indexPath = IndexPath(row: nextIndex, section: 0)
               let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
               UIView.animate(withDuration: 0.5) {
                   cell?.imageView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
               }
           }
       }
    

}


extension AgencyVC:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as! CardCollectionViewCell
        let data = imgArr[indexPath.item]
        
        cell.data=data
        return cell
    }
}
