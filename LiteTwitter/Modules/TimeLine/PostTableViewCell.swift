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
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    static var identifier: String {
        return "\(type(of: self))"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(contentLabel)
        contentView.addSubview(stackView)
        
        let layoutsGuide = contentView.layoutMarginsGuide
        
        stackView.topAnchor.constraint(equalTo: layoutsGuide.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: layoutsGuide.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: layoutsGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: layoutsGuide.trailingAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
