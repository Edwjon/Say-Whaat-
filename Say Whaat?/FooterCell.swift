//
//  FooterCell.swift
//  practica say whaat
//
//  Created by Edward Pizzurro Fortun on 9/7/17.
//  Copyright © 2017 Pencil. All rights reserved.
//

import UIKit

class FooterCell: UICollectionViewCell {
    
    let etiqueta: UILabel = {
        
        let label = UILabel()
        label.text = "Delivered"
        label.textColor = UIColor(red: 142/255, green: 142/255, blue: 147/255, alpha: 1.0)
        label.font = UIFont.boldSystemFont(ofSize: 11.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(etiqueta)
        
        etiqueta.isHidden = true
        
        
        etiqueta.topAnchor.constraint(equalTo: self.topAnchor, constant: -5).isActive = true
        etiqueta.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 5).isActive = true
        etiqueta.widthAnchor.constraint(equalToConstant: 70).isActive = true
        etiqueta.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
