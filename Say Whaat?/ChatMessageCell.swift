//
//  ChatMessageCell.swift
//  gameofchats
//
//  Created by Brian Voong on 7/12/16.
//  Copyright © 2016 letsbuildthatapp. All rights reserved.
//

import UIKit

class ChatMessageCell: UICollectionViewCell {
    
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = UIColor.clear
        tv.textColor = .white
        tv.isEditable = false
        return tv
    }()
    
    static let blueColor = UIColor(red: 0/255, green: 137/255, blue: 249/255, alpha: 1.0)
    
    let bubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = blueColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        return view
    }()
    
    
    lazy var messageImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    //......
    let redSpace: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
    let celdaNormal: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    
    
    var bubbleWidthAnchor: NSLayoutConstraint?
    var bubbleViewRightAnchor: NSLayoutConstraint?
    var bubbleViewLeftAnchor: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //addSubview(redSpace)
        addSubview(celdaNormal)
        
        celdaNormal.addSubview(bubbleView)
        celdaNormal.addSubview(textView)
        
        //addSubview(bubbleView)
        //addSubview(textView)
        
        
        
        //x,y,w,h
        /*redSpace.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        redSpace.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        redSpace.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        redSpace.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true*/
        
        celdaNormal.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        celdaNormal.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        celdaNormal.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        celdaNormal.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        
        
        //x,y,w,h
        bubbleViewRightAnchor = bubbleView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8)
        //bubbleViewRightAnchor?.isActive = true
        bubbleView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        bubbleWidthAnchor = bubbleView.widthAnchor.constraint(equalToConstant: 200)
        bubbleWidthAnchor?.isActive = true
        bubbleView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        bubbleViewLeftAnchor = bubbleView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8)
        //bubbleViewLeftAnchor?.isActive = false
        
        
        //x,y,w,h
        textView.leftAnchor.constraint(equalTo: bubbleView.leftAnchor, constant: 10).isActive = true
        textView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textView.rightAnchor.constraint(equalTo: bubbleView.rightAnchor).isActive = true
        textView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        
        //x,y,w,h
        bubbleView.addSubview(messageImageView)
        messageImageView.leftAnchor.constraint(equalTo: bubbleView.leftAnchor).isActive = true
        messageImageView.topAnchor.constraint(equalTo: bubbleView.topAnchor).isActive = true
        messageImageView.widthAnchor.constraint(equalTo: bubbleView.widthAnchor).isActive = true
        messageImageView.heightAnchor.constraint(equalTo: bubbleView.heightAnchor).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
