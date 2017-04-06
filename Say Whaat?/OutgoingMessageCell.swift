//
//  OutgoingMessageCell.swift
//  APLICACION FAKE TEXT
//
//  Created by Cheng-Yu Hsu on 7/27/16.
//  Copyright © 2016 Edwjon. All rights reserved.
//

import UIKit

//Yo lo mando
class OutgoingMessageCell: MessageCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = UITableViewCellSelectionStyle.none
        
        
        let bubbleImage = UIImage(named: "ImagenSalida")!
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
