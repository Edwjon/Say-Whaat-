//
//  HomeViewController+navbar.swift
//  practica say whaat
//
//  Created by Edward Pizzurro Fortun on 1/7/17.
//  Copyright © 2017 Pencil. All rights reserved.
//

import UIKit

extension HomeViewController {

    
    func setupImagenAbajo() {
        
        fotoFinal.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(fotoFinal)
        
        fotoFinal.isHidden = true
        infoButton.isHidden = true
        backButton.isHidden = true
        
        if self.view.frame.size.width == 320.0 {
            
            fotoFinal.image = UIImage(named: "pequeno")
            fotoFinal.contentMode = .scaleAspectFit
            fotoFinal.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20).isActive = true
            
            //infoButton.frame = CGRect.init(x: 145, y: 7, width: 40, height: 25)
            //backButton.frame = CGRect.init(x: -120, y: 7, width: 25, height: 25)
            
        }
        
        if self.view.frame.size.width == 375.0 {
            
            fotoFinal.image = UIImage(named: "medio")
            fotoFinal.contentMode = .scaleAspectFit
            fotoFinal.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20).isActive = true
            
            //infoButton.frame = CGRect.init(x: 170, y: 7, width: 40, height: 25)
            //backButton.frame = CGRect.init(x: -145, y: 7, width: 25, height: 25)
            
        }
        
        if self.view.frame.size.width == 414.0 {
            
            fotoFinal.image = UIImage(named: "grande")
            fotoFinal.contentMode = .scaleAspectFit
            fotoFinal.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 40).isActive = true
            
            //infoButton.frame = CGRect.init(x: 190, y: 7, width: 40, height: 25)
            //backButton.frame = CGRect.init(x: -170, y: 7, width: 25, height: 25)
        }
        
        
        fotoFinal.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        fotoFinal.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        fotoFinal.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(irParaAtras)))
        fotoFinal.isUserInteractionEnabled = true
        
    }
    
    
    @objc func irParaAtras() {
        
        //navigationItem.leftBarButtonItem = botonIzquierda
        //navigationItem.rightBarButtonItem = botonDerecha
        
        reusableView.etiqueta.isHidden = true
        
        self.botonIzquierda.isHidden = false
        self.botonDerecha.isHidden = false
        
        infoButton.isHidden = true
        backButton.isHidden = true
        
        self.inputContainerView.isHidden = false
        
        viewww.removeFromSuperview()
    }
    
    
    
    
    func createCustomAlert() {
        
        self.navigationController?.isNavigationBarHidden = true
        inputContainerView.isHidden = true
        
        
        let blackView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        let imagen = UIImageView(image: UIImage(named: "aja"))
        imagen.frame = CGRect(x: 0, y: 0, width: blackView.frame.size.width, height: blackView.frame.size.height)
        blackView.addSubview(imagen)
        view.addSubview(blackView)
        
        let customAlert = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width / 2 + 80 , height: self.view.frame.width - 60))
        customAlert.backgroundColor = .white
        customAlert.layer.cornerRadius = 16
        customAlert.layer.masksToBounds = true
        customAlert.center = CGPoint(x: blackView.center.x, y: blackView.center.y)
        blackView.addSubview(customAlert)
        
        
        let lineaSeparadora1: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .lightGray
            return view
        }()
        
        let labelPrincipal: UILabel = {
            let label = UILabel()
            label.text = "Setup Contact Info"
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let descripcionLabel: UILabel = {
            let label = UILabel()
            label.text = "Put 2 letters to show on the top. Or, select a default image to show on top"
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            label.font = UIFont.boldSystemFont(ofSize: 12)
            return label
        }()
        
        let textfield1: UITextField = {
            let tf = UITextField()
            tf.placeholder = "Letters... (max 2)"
            tf.translatesAutoresizingMaskIntoConstraints = false
            tf.textAlignment = .center
            return tf
        }()
        
        let boton1: UIButton = {
            let boton = UIButton(type: .system)
            boton.translatesAutoresizingMaskIntoConstraints = false
            boton.setTitle("Set Letters", for: .normal)
            return boton
        }()
        
        let boton2: UIButton = {
            let boton = UIButton(type: .system)
            boton.translatesAutoresizingMaskIntoConstraints = false
            boton.setTitle("Set Image", for: .normal)
            return boton
        }()
        
        let lineaSeparadora2: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .lightGray
            return view
        }()
        
        let lineaSeparadora3: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .lightGray
            return view
        }()
        
        let lineaSeparadora4: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .lightGray
            return view
        }()
        
        let label2: UILabel = {
            let label = UILabel()
            label.text = "Please, put the name to show on the top"
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            label.font = UIFont.boldSystemFont(ofSize: 12)
            return label
        }()
        
        let textfield2: UITextField = {
            let tf = UITextField()
            tf.placeholder = "Name..."
            tf.translatesAutoresizingMaskIntoConstraints = false
            tf.textAlignment = .center
            return tf
            
        }()
        
        
        customAlert.addSubview(labelPrincipal)
        customAlert.addSubview(lineaSeparadora1)
        customAlert.addSubview(descripcionLabel)
        customAlert.addSubview(boton1)
        customAlert.addSubview(boton2)
        customAlert.addSubview(lineaSeparadora2)
        customAlert.addSubview(lineaSeparadora3)
        customAlert.addSubview(textfield1)
        customAlert.addSubview(lineaSeparadora4)
        customAlert.addSubview(label2)
        customAlert.addSubview(textfield2)
        
        labelPrincipal.topAnchor.constraint(equalTo: customAlert.topAnchor, constant: 8).isActive = true
        labelPrincipal.leftAnchor.constraint(equalTo: customAlert.leftAnchor, constant: 4).isActive = true
        labelPrincipal.rightAnchor.constraint(equalTo: customAlert.rightAnchor, constant: 4).isActive = true
        labelPrincipal.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        lineaSeparadora1.topAnchor.constraint(equalTo: labelPrincipal.bottomAnchor, constant: 4).isActive = true
        lineaSeparadora1.rightAnchor.constraint(equalTo: customAlert.rightAnchor, constant: 1).isActive = true
        lineaSeparadora1.leftAnchor.constraint(equalTo: customAlert.leftAnchor, constant: 1).isActive = true
        lineaSeparadora1.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        descripcionLabel.topAnchor.constraint(equalTo: lineaSeparadora1.bottomAnchor, constant: 8).isActive = true
        descripcionLabel.rightAnchor.constraint(equalTo: customAlert.rightAnchor, constant: -10).isActive = true
        descripcionLabel.leftAnchor.constraint(equalTo: customAlert.leftAnchor, constant: 10).isActive = true
        descripcionLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        textfield1.topAnchor.constraint(equalTo: descripcionLabel.bottomAnchor, constant: 10).isActive = true
        textfield1.leftAnchor.constraint(equalTo: customAlert.leftAnchor, constant: 8).isActive = true
        textfield1.rightAnchor.constraint(equalTo: customAlert.rightAnchor, constant: -8).isActive = true
        textfield1.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        boton1.topAnchor.constraint(equalTo: textfield1.bottomAnchor, constant: 8).isActive = true
        boton1.leftAnchor.constraint(equalTo: customAlert.leftAnchor, constant: 2).isActive = true
        boton1.rightAnchor.constraint(equalTo: lineaSeparadora2.leftAnchor, constant: -10).isActive = true
        boton1.heightAnchor.constraint(equalToConstant: 50).isActive = true
        boton1.widthAnchor.constraint(equalTo: boton2.widthAnchor).isActive = true
        
        lineaSeparadora2.bottomAnchor.constraint(equalTo: boton1.bottomAnchor, constant: 0).isActive = true
        lineaSeparadora2.topAnchor.constraint(equalTo: boton2.topAnchor, constant: 0).isActive = true
        lineaSeparadora2.widthAnchor.constraint(equalToConstant: 1).isActive = true
        
        boton2.topAnchor.constraint(equalTo: textfield1.bottomAnchor, constant: 8).isActive = true
        boton2.leftAnchor.constraint(equalTo: lineaSeparadora2.rightAnchor, constant: 10).isActive = true
        boton2.rightAnchor.constraint(equalTo: customAlert.rightAnchor, constant: -2).isActive = true
        boton2.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        lineaSeparadora3.topAnchor.constraint(equalTo: boton1.bottomAnchor, constant: 0).isActive = true
        lineaSeparadora3.rightAnchor.constraint(equalTo: customAlert.rightAnchor, constant: 1).isActive = true
        lineaSeparadora3.leftAnchor.constraint(equalTo: customAlert.leftAnchor, constant: 1).isActive = true
        lineaSeparadora3.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        lineaSeparadora4.bottomAnchor.constraint(equalTo: lineaSeparadora2.topAnchor, constant: 0).isActive = true
        lineaSeparadora4.rightAnchor.constraint(equalTo: customAlert.rightAnchor, constant: 1).isActive = true
        lineaSeparadora4.leftAnchor.constraint(equalTo: customAlert.leftAnchor, constant: 1).isActive = true
        lineaSeparadora4.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        label2.topAnchor.constraint(equalTo: lineaSeparadora3.bottomAnchor, constant: 12).isActive = true
        label2.rightAnchor.constraint(equalTo: customAlert.rightAnchor, constant: -10).isActive = true
        label2.leftAnchor.constraint(equalTo: customAlert.leftAnchor, constant: 10).isActive = true
        label2.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        textfield2.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 10).isActive = true
        textfield2.leftAnchor.constraint(equalTo: customAlert.leftAnchor, constant: 8).isActive = true
        textfield2.rightAnchor.constraint(equalTo: customAlert.rightAnchor, constant: -8).isActive = true
        textfield2.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
    }
    
    
    
    //CODIGO RED VIEW
    
    func setupView(){
        
        let swipeUp : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(userDidSwipeUp(_:)))
        swipeUp.direction = .left
        collectionView?.addGestureRecognizer(swipeUp)
    }
    
    
    func getCellAtPoint(_ point: CGPoint) -> ChatMessageCell? {
        // Function for getting item at point. Note optionals as it could be nil
        let indexPath = collectionView?.indexPathForItem(at: point)
        var cell : ChatMessageCell?
        
        if indexPath != nil {
            cell = collectionView?.cellForItem(at: indexPath!) as? ChatMessageCell
        } else {
            cell = nil
        }
        
        return cell
    }
    
    @objc func userDidSwipeUp(_ gesture : UISwipeGestureRecognizer) {
        
        let point = gesture.location(in: collectionView)
        let duration = 0.5
        
        if (cell == nil) {
            
            cell = getCellAtPoint(point)
            
            UIView.animate(withDuration: duration, animations: {
                //self.activeCell.myCellView.transform = CGAffineTransform(translationX: 0, y: -self.activeCell.frame.height)
                self.cell.celdaNormal.transform = CGAffineTransform(translationX: -self.cell.frame.width , y: 0)
                
            })
            
        }  else {
            
            // Getting the cell at the point
            let cell = getCellAtPoint(point)
            
            // If the cell is the previously swiped cell, or nothing assume its the previously one.
            if cell == nil || cell == cell {
                // To target the cell after that animation I test if the point of the swiping exists inside the now twice as tall cell frame
                let cellFrame = cell?.frame
                
                var rect = CGRect()
                
                if cell != nil {
                    rect = CGRect(x: (cellFrame?.origin.x)! - (cellFrame?.width)!, y: (cellFrame?.origin.y)!, width: (cellFrame?.width)!*2, height: (cellFrame?.height)!)
                }
                
                if rect.contains(point) {
                    // If swipe point is in the cell delete it
                    
                    let indexPath = collectionView?.indexPath(for: cell!)
                    messages.remove(at: indexPath!.row)
                    collectionView?.deleteItems(at: [indexPath!])
                    
                }
            }
        }
    }
    
    
}
