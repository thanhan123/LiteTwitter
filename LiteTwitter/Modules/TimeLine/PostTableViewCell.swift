//
//  PostTableViewCell.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 10/12/2018.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    var titleLabel: UILabel = {
        var label = UILabel()
        return label
    }()
    
    var contentLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.numberOfLines = 0
        return label
    }()
    
    var editIncon: UIImageView = {
        var imageView = UIImageView(image: #imageLiteral(resourceName: "icon-edit.png"))
        return imageView
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let horizontalStackView = UIStackView(arrangedSubviews: [titleLabel, editIncon])
        horizontalStackView.axis = .horizontal
        
        stackView.addArrangedSubview(horizontalStackView)
        stackView.addArrangedSubview(contentLabel)
        contentView.addSubview(stackView)
        
        let layoutsGuide = contentView.layoutMarginsGuide
        
        stackView.topAnchor.constraint(equalTo: layoutsGuide.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: layoutsGuide.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: layoutsGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: layoutsGuide.trailingAnchor).isActive = true
        
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
