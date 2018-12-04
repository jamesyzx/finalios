//
//  TableViewCell.swift
//  Assignment9
//
//  Created by Chung-Yang Li on 11/13/18.
//  Copyright © 2018 Chung-Yang Li. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    //    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
//    

    
//    let vehicleTitleDetailedLabel:UILabel = {
//        let label = UILabel()
//        label.font = UIFont.boldSystemFont(ofSize: 18)
//        //        label.textColor =  colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        //        label.backgroundColor =  colorLiteral(red: 0.2431372549, green: 0.7647058824, blue: 0.8392156863, alpha: 1)
//        label.layer.cornerRadius = 5
//        label.clipsToBounds = true
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    let nameLabel:UILabel = {
//        let label = UILabel()
//        label.font = UIFont.boldSystemFont(ofSize: 30)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    let containerView:UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
//        return view
//    }()
//    let actionButton: UIButton = {
//        let btn = UIButton()
//        btn.setTitle("Delete", for: .normal)
//        return btn
//    }()
//    let profileImageView:UIImageView = {
//        let img = UIImageView()
//        img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
//        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
//        //        img.layer.cornerRadius = 35
//        img.clipsToBounds = true
//        return img
//    }()
//
//    //    var myTableViewController: ViewController?
//    var vehicle:Vehicle? {
//        didSet {
//            guard let vehicleItem = vehicle else {return}
//
//            let dateformatter = DateFormatter()
//            dateformatter.dateFormat = "yyyy"
//            let year = dateformatter.string(from: vehicleItem.year)
//            nameLabel.text = vehicleItem.make
//            profileImageView.image = UIImage(named: vehicleItem.photo)
//            vehicleTitleDetailedLabel.text = vehicleItem.model + "  " + year
//
//        }
//    }
//
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupViews()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func setupViews(){
//        //        addSubview(nameLabel)
//        //        addSubview(actionButton)
//        self.contentView.addSubview(profileImageView)
//        self.contentView.addSubview(nameLabel)
//        self.contentView.addSubview(vehicleTitleDetailedLabel)
//        self.contentView.addSubview(containerView)
//
//        profileImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
//        profileImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
//        profileImageView.widthAnchor.constraint(equalToConstant:70).isActive = true
//        profileImageView.heightAnchor.constraint(equalToConstant:70).isActive = true
//
//        //            containerView auto layout constraints
//
//        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
//        containerView.leadingAnchor.constraint(equalTo:self.profileImageView.trailingAnchor, constant:10).isActive = true
//        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
//        containerView.heightAnchor.constraint(equalToConstant:60).isActive = true
//        //            nameLabel auto layout constraints
//
//        nameLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
//        nameLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
//        nameLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
//
//        //            vehicleTitleDetailedLabel auto layout constraints
//
//        vehicleTitleDetailedLabel.topAnchor.constraint(equalTo:self.nameLabel.bottomAnchor).isActive = true
//        vehicleTitleDetailedLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
//        vehicleTitleDetailedLabel.topAnchor.constraint(equalTo:self.nameLabel.bottomAnchor).isActive = true
//        vehicleTitleDetailedLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
//
//        //        actionButton.addTarget(self, action: "Action", for: .touchUpInside)
//        //        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[message]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": actionButton]));
//    }
    




}
