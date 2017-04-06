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
        
        if msjOrImage == true {
            
            /*let bubbleImage = imagenqlq
            bubbleImageView?.image = resizeImage(image: bubbleImage!, newWidth: 250)
            msjOrImage = false*/
            
            let bubbleImage = imagenqlq
            messageLabel?.isHidden = true
            bubbleImageView?.image = resizeImage(image: bubbleImage, newWidth: 250)
            msjOrImage = false
        }
        else {
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
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}

