//
//  ProfileInfoHeaderCollectionReusableView.swift
//  SqLiteDataBase
//
//  Created by Nuthan Raju Pesala on 17/06/21.
//

import UIKit

class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
       
    static let identifier = "ProfileInfoHeaderCollectionReusableView"
    
    let profileImageView: UIImageView = {
       let img = UIImageView()
        img.clipsToBounds = true
        img.backgroundColor = UIColor.red
        return img
    }()
    
    let postsButton: UIButton = {
       let btn = UIButton()
        btn.setTitle("Posts", for: .normal)
        btn.setTitleColor(UIColor.label, for: .normal)
        return btn
    }()
    let followersButton: UIButton = {
       let btn = UIButton()
        btn.setTitle("Followers", for: .normal)
        btn.setTitleColor(UIColor.label, for: .normal)
        return btn
    }()
    let followingButton: UIButton = {
       let btn = UIButton()
        btn.setTitle("Following", for: .normal)
        btn.setTitleColor(UIColor.label, for: .normal)
        return btn
    }()
    
    let editYourProfileBtn: UIButton = {
       let btn = UIButton()
        btn.setTitle("Edit Your Profile", for: .normal)
        btn.setTitleColor(UIColor.label, for: .normal)
        return btn
    }()
    
    let nameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.text = "Nuthan Raju"
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    let bioLabel: UILabel = {
       let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.text = "This is my first Account!,This is my first Account!,This is my first Account!,   This is my first Account!"
        return label
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillProportionally
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       // backgroundColor = UIColor.green
        clipsToBounds = true
        addSubview(profileImageView)
        addSubview(stackView)
        stackView.addArrangedSubview(postsButton)
        stackView.addArrangedSubview(followersButton)
        stackView.addArrangedSubview(followingButton)
        addSubview(nameLabel)
        addSubview(bioLabel)
        addSubview(editYourProfileBtn)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let photoImageSize = frame.width / 4
        profileImageView.frame = CGRect(x: 5, y: 5, width: photoImageSize, height: photoImageSize).integral
        profileImageView.layer.cornerRadius = photoImageSize / 2
        profileImageView.layer.masksToBounds = true
        
        stackView.frame = CGRect(x: profileImageView.right + 5, y: 5, width: frame.width - profileImageView.width - 10, height: 50)
        nameLabel.frame =  CGRect(x: frame.origin.x + 5, y: profileImageView.frame.height + profileImageView.frame.origin.y + 10, width: frame.width - 10, height: 25)
        
       
        bioLabel.numberOfLines = 0
        let maximumLabelSize: CGSize = CGSize(width: frame.width - 10, height: 9999)
        let expectedLabelSize: CGSize = bioLabel.sizeThatFits(maximumLabelSize)
        // create a frame that is filled with the UILabel frame data
       
        bioLabel.frame =  CGRect(x: frame.origin.x + 5, y: nameLabel.frame.height + nameLabel.frame.origin.y + 10, width: expectedLabelSize.width, height: expectedLabelSize.height)
     
        editYourProfileBtn.frame = CGRect(x: frame.origin.x + 5, y: bioLabel.bottom + 5, width: frame.width - 10, height: 50)
        
        
    }
    
 
    
 
}

extension UIView {
    
    public var width: CGFloat {
        return self.frame.width
    }
    public var height: CGFloat {
        return self.frame.height
    }
    public var top: CGFloat {
        return self.frame.origin.y
    }
    public var bottom: CGFloat {
        return self.frame.height + self.frame.origin.y
    }
    public var left: CGFloat {
        return self.frame.origin.x
    }
    public var right: CGFloat {
        return self.frame.width + self.frame.origin.x
    }
    
}


