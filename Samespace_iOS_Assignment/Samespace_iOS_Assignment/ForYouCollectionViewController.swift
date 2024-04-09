//
//  ForYouCollectionViewController.swift
//  Samespace_iOS_Assignment
//
//  Created by Prasenjeet Pandagale on 09/04/24.
//

import UIKit

private let reuseIdentifier = "Cell"

class ForYouCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var songsArray: [Song] = []
    var imageArray = ["imagee","imagee","imagee","imagee"]
    override func viewDidLoad() {
        super.viewDidLoad()

       
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                   layout.scrollDirection = .horizontal
                   layout.minimumLineSpacing = 0
                   layout.minimumInteritemSpacing = 0
                   collectionView.isPagingEnabled = true
               }
    }

  

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return songsArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ForYouCollectionViewCell
        let imageUrl = imageArray[indexPath.item]
        cell.imageView.layer.bounds.size = cell.bounds.size
        cell.imageView.image = UIImage(named: imageUrl)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            let collectionViewSize = collectionView.bounds.size
            return CGSize(width: collectionViewSize.width, height: collectionViewSize.height)
    }
    
 
}
    


