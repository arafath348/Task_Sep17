//
//  CustomTableViewCell.swift
//  Task_Sep17
//
//  Created by L-156157182 on 17/09/18.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    let profileImageView = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let customView = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let marginGuide = contentView.layoutMarginsGuide
        
        // configure profileImageView
        contentView.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: marginGuide.leftAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 75).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = 37.5
        profileImageView.clipsToBounds = true
        profileImageView.layer.shadowColor = UIColor.black.cgColor
        profileImageView.layer.shadowOffset =  CGSize(width: 0, height: 2)
        profileImageView.layer.shadowOpacity = 1
        profileImageView.backgroundColor = UIColor.white

        // configure titleLabel
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 15)

        // configure descriptionLabel
        contentView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.font = UIFont(name: "HelveticaNeue", size: 13)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
   
        // configure customView
        contentView.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        customView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        customView.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        customView.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        customView.heightAnchor.constraint(greaterThanOrEqualToConstant: 91).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     func setData(data: DataViewModel) {
        self.titleLabel.text = data.title
        self.descriptionLabel.text = data.description
        
        if let imageHref = data.url{
            self.profileImageView.sd_setImage(with: URL(string: imageHref), placeholderImage: UIImage(named: "Placeholder.png"))
        }
        else{
            self.profileImageView.image =  UIImage(named: "Placeholder.png")
        }
    }
 
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
