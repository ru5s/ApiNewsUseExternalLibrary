//
//  TableViewCell.swift
//  ApiNewsUseExternalLibrary
//
//  Created by Ruslan Ismailov on 23/11/22.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    let image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 5
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        
        return image
    }()
    
    let author: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .brown
        
        return label
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .brown
        label.textAlignment = .left
        label.numberOfLines = 2
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(image)
        image.widthAnchor.constraint(equalToConstant: 60).isActive = true
        image.heightAnchor.constraint(equalToConstant: 60).isActive = true
        image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        image.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        
        contentView.addSubview(author)
        author.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        author.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        author.rightAnchor.constraint(equalTo: image.leftAnchor, constant: -10).isActive = true
        
        contentView.addSubview(title)
        title.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        title.topAnchor.constraint(equalTo: author.bottomAnchor, constant: 5).isActive = true
        title.rightAnchor.constraint(equalTo: image.leftAnchor, constant: -10).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
