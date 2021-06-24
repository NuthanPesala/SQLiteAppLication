//
//  SecondViewController.swift
//  SqLiteDataBase
//
//  Created by Nuthan Raju Pesala on 19/06/21.
//

import UIKit

class SecondViewController: UIViewController {
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(ProfileInfoHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier)
        
        collectionView.register(PhotoCollectionView.self, forCellWithReuseIdentifier: PhotoCollectionView.identifier)
    
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }


}

extension SecondViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionView.identifier, for: indexPath) as! PhotoCollectionView
        cell.backgroundColor = .link
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier, for: indexPath) as! ProfileInfoHeaderCollectionReusableView
        header.backgroundColor = .brown
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let label = UILabel()
        label.text = "This is my first Account!,This is my first Account!,This is my first Account!,   This is my first Account!"
        label.numberOfLines = 0
        let maximumLabelSize: CGSize = CGSize(width: collectionView.width - 10, height: 9999)
        let expectedLabelSize: CGSize = label.sizeThatFits(maximumLabelSize)
        let height = (collectionView.frame.width / 4) + 25 + expectedLabelSize.height + 50 + 35
         
        return CGSize(width: collectionView.frame.width, height: height)
      
    }
}

class PhotoCollectionView: UICollectionViewCell {
    static let identifier = "PhotoCollectionView"
}
