//
//  IncomingMessageCell.swift
//  APLICACION FAKE TEXT
//
//  Created by Cheng-Yu Hsu on 7/27/16.
//  Copyright © 2016 Edwjon. All rights reserved.
//

import UIKit

//ME LO MANDAN
class IncomingMessageCell: MessageCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = UITableViewCellSelectionStyle.none
        
        
        let bubbleImage = UIImage(named:"ImagenEntrada")!
        bubbleImageView?.image = bubbleImage.resizableImage(
    
            withCapInsets: UIEdgeInsetsMake(
                round(bubbleImage.size.height * 0.5),
                round(bubbleImage.size.width * 0.5),
                round(bubbleImage.size.height * 0.5),
                round(bubbleImage.size.width * 0.5)
            )
        )
        
        messageLabel?.text = nil
            
        }
}

