//
//  ViewController.swift
//  practica say whaat
//
//  Created by Edward Pizzurro Fortun on 26/6/17.
//  Copyright © 2017 Pencil. All rights reserved.
//

import UIKit
import GoogleMobileAds


class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, GADBannerViewDelegate {

    
    var navBar: UINavigationBar = UINavigationBar()
    
    var holaqlq = 0
    var turno = 0
    var fotoFinal = UIImageView()
    
    var botonIzquierda = UIButton()
    var botonDerecha = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interstitial = createAndLoadInterstitial()
        
        setupView()
        
        setupImagenAbajo()
        
        self.navBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 82)
        view.addSubview(navBar)
        
       
        let height: CGFloat = 38
        let bounds = self.navigationController?.navigationBar.bounds
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: (bounds?.width)!, height: (bounds?.height)! + height)
        
        collectionView?.register(FooterCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "Footer")
        
        
        botonIzquierda = UIButton(frame: CGRect(x: 10, y: 27, width: 47, height: 45))
        botonIzquierda.setTitle("Reset", for: .normal)
        botonIzquierda.addTarget(self, action: #selector(handleReset), for: .touchUpInside)
        botonIzquierda.setTitleColor(UIColor(red: 54/255, green: 149/255, blue: 251/255, alpha: 1.0) , for: .normal)
        botonIzquierda.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        navBar.addSubview(botonIzquierda)
        //navigationItem.leftBarButtonItem = botonIzquierda
        
        
        botonDerecha = UIButton(frame: CGRect(x: navBar.frame.width - 100, y: 27, width: 100, height: 45))
        botonDerecha.setTitle("Get it done!", for: .normal)
        botonDerecha.addTarget(self, action: #selector(handleDone), for: .touchUpInside)
        botonDerecha.setTitleColor(UIColor(red: 54/255, green: 149/255, blue: 251/255, alpha: 1.0) , for: .normal)
        botonDerecha.titleLabel?.font = UIFont.systemFont(ofSize: 16.5)
        navBar.addSubview(botonDerecha)
        //botonDerecha = UIBarButtonItem(title: "Get it done!", style: .plain, target: self, action: #selector(handleDone))
        //navigationItem.rightBarButtonItem = botonDerecha
        
        
        inputContainerView.isHidden = true
        
        
        collectionView?.contentInset = UIEdgeInsets(top: 87, left: 0, bottom: 14, right: 0)
        collectionView?.backgroundColor = .white
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(ChatMessageCell.self, forCellWithReuseIdentifier: "cellId")
        
        swiche.isOn = true
        
        setupKeyboardObservers()
        collectionView?.keyboardDismissMode = .interactive
        
        
        /*NotificationCenter.default.addObserver(
            self,
            selector: #selector(HomeViewController.keyboardWillShow(event:)),
            name: NSNotification.Name.UIKeyboardWillShow,
            object: nil
        )*/
 
        image_view.isHidden = true
        
        
        
        if turno == 0 {
            self.inputTextField.placeholder = "Name to show on top"
            swiche.isEnabled = false
            self.uploadImageView.alpha = 0.5
        }
        
        initUI()
        
        
        //PRIMER LAUNCH
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "FirstLaunch") {
            
            holaqlq = 0
            
        } else {
            
            holaqlq = 1
            setupFondoImage(Imagen: UIImage(named:"Tutorial#1")!, gestor: UITapGestureRecognizer(target: self, action: #selector(imageTapped)),alpha: 1.0)
            
            defaults.set(true, forKey: "FirstLaunch")
            defaults.synchronize()
        }
        
        
        let colorAzul = UIColor(red: 23/255, green: 140/255, blue: 246/255, alpha: 1.0)
        
        self.swiche.onTintColor = colorAzul
        self.swiche.tintColor = .gray
        
    }
    
    //ads
    var interstitial:GADInterstitial!
    
    private func createAndLoadInterstitial() -> GADInterstitial? {
        
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-1545419340469541/4639930711" )
        
        
        guard let interstitial = interstitial else {
            return nil
        }
        
        let request = GADRequest()
        
        // Remove the following line before you upload the app
        request.testDevices = [ kGADSimulatorID ]
        
        interstitial.load(request)
        
        return interstitial
    }
    
    
    func setupKeyboardObservers() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardDidShow), name: Notification.Name.UIKeyboardDidShow, object: nil)
    }
    
    @objc func handleKeyboardDidShow() {
        
        if messages.count > 0 {
            let indexpath = IndexPath(item: messages.count - 1, section: 0)
            self.collectionView?.scrollToItem(at: indexpath, at: .bottom, animated: true)
        }
    }
    
    
    
    //MARK: imagen-fondo
    var imagenn = UIImageView()
    
    func setupFondoImage(Imagen:UIImage, gestor: UITapGestureRecognizer, alpha: CGFloat) {
        
        let imagen = UIImageView(image: Imagen)
        imagen.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        //self.navigationController?.isNavigationBarHidden = true
        navBar.isHidden = true
        self.inputContainerView.isHidden = true
        let tapGestureRecognizer = gestor
        imagen.isUserInteractionEnabled = true
        imagen.addGestureRecognizer(tapGestureRecognizer)
        imagenn = imagen
        imagenn.alpha = alpha
        self.view.addSubview(imagenn)
    }
    
    
    @objc func imageTapped(){
        
        navBar.isHidden = false
        self.inputContainerView.isHidden = false
        imagenn.isHidden = true
        
        createAlert(title: "Pon las dos letras para arriba")
    }
    
    
    //MARK: Handlers
    
    @objc func handleUploadTap() {
        
        if turno == 1 {
            
            let imagePickerController = UIImagePickerController()
        
            imagePickerController.allowsEditing = true
            imagePickerController.delegate = self
        
            present(imagePickerController, animated: true, completion: nil)
        }
        
    }
    
    
    @objc func handleReset() {
        
        collectionView?.reloadData()
        createAlert(title: "Please, put 2 characters")
        hacerNuevoFake()
        self.inputTextField.text = nil
        //.....
        reusableView.etiqueta.isHidden = true
        inputContainerView.isHidden = true
        fotoFinal.isHidden = true
        
    }
    
    
    
    func hacerNuevoFake() {
        
        image_view.isHidden = true
        label.text = nil
        dosletras.text = nil
        
        if turno == 1 {
            
            //fotoFinal.isHidden = true
            self.inputContainerView.isHidden = false
            messages.removeAll()
            swiche.isOn = true
            turno = 0
            inputTextField.placeholder = "Name to show on top"
            swiche.isEnabled = false
            inputTextField.resignFirstResponder()
            collectionView?.reloadData()
        }
            
        else if turno == 1 {
            //QLQ
        }
        
    }
    
    
    //MARK: IMG2 Y SCREENSHOT
    @objc func imagentutorial2() {
        
        imagenn.isHidden = true
        navBar.isHidden = false
        
        viewDeScreen()
    }
    
    
    var viewww = UIView()
    
    func viewDeScreen() {
        
        if self.view.frame.size.width == 414.0 {
            viewww = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 30))
        }
        
        viewww = UIView(frame: CGRect(x: 0, y: navBar.frame.height, width: self.view.frame.width, height: self.view.frame.height - navBar.frame.height))
        
        let tapGestureRecognizerDelScreenShot = UITapGestureRecognizer(target:self, action:#selector(tomarScreenShot))
        viewww.backgroundColor = UIColor.clear
        viewww.isUserInteractionEnabled = true
        viewww.addGestureRecognizer(tapGestureRecognizerDelScreenShot)
        self.view.addSubview(viewww)
    }
    
    
    //screenshot
    func screenshot() -> UIImage {
        
        
        let imageSize = UIScreen.main.bounds.size as CGSize;
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
        let context = UIGraphicsGetCurrentContext()
        for obj : AnyObject in UIApplication.shared.windows {
            if let window = obj as? UIWindow {
                if window.responds(to: #selector(getter: UIWindow.screen)) || window.screen == UIScreen.main {
                    // so we must first apply the layer's geometry to the graphics context
                    context!.saveGState();
                    // Center the context around the window's anchor point
                    context!.translateBy(x: window.center.x, y: window.center
                        .y);
                    // Apply the window's transform about the anchor point
                    context!.concatenate(window.transform);
                    // Offset by the portion of the bounds left of and above the anchor point
                    context!.translateBy(x: -window.bounds.size.width * window.layer.anchorPoint.x,
                                         y: -window.bounds.size.height * window.layer.anchorPoint.y);
                    
                    // Render the layer hierarchy to the current context
                    window.layer.render(in: context!)
                    
                    // Restore the context
                    context!.restoreGState();
                }
            }
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext();
        return image!
    }
    
    
    //tomar screenshot
    @objc func tomarScreenShot() {
        
        UIImageWriteToSavedPhotosAlbum(screenshot(), nil, nil, nil)
        
        let alertController = UIAlertController(title: "ScreenShot saved", message: "The screenshot has been saved correctly!!!", preferredStyle: UIAlertControllerStyle.alert)
        
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            
            self.inputContainerView.isHidden = false
            
            self.botonIzquierda.isHidden = false
            self.botonDerecha.isHidden = false
        }
        
        alertController.addAction(okAction)
        
        infoButton.isHidden = true
        backButton.isHidden = true
        self.inputContainerView.isHidden = true
        
        viewww.removeFromSuperview()
        
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    
    @objc func handleDone() {
        
        if turno == 1 {
            
            if messages.count > 0 {
                let indexpath = IndexPath(item: messages.count - 1, section: 0)
                self.collectionView?.scrollToItem(at: indexpath, at: .bottom, animated: true)
            }
            
            if messages.last?.id == 2 {
                reusableView.etiqueta.isHidden = true
            
            } else {
                reusableView.etiqueta.isHidden = false
            }
            
            self.inputTextField.text = nil
            inputTextField.resignFirstResponder()
            
            
            if (self.interstitial.isReady)
            {
                self.interstitial.present(fromRootViewController: self)
                interstitial = createAndLoadInterstitial()
            }
            
            collectionView?.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
            
            
            fotoFinal.isHidden = false
            self.inputContainerView.isHidden = true
            infoButton.isHidden = false
            backButton.isHidden = false
           
           // navigationItem.leftBarButtonItem = nil
           // navigationItem.rightBarButtonItem = nil
            
            botonIzquierda.isHidden = true
            botonDerecha.isHidden = true
            
            setupFondoImage(Imagen: UIImage(named:"Tutorial2")!, gestor: UITapGestureRecognizer(target:self, action:#selector(imagentutorial2)), alpha: 0.77)
            
            if swiche.isOn == true {
                let qlq = FooterCell()
                qlq.etiqueta.isHidden = false
            }
                
        }
    }
    
    
    
    @objc func acciondelswiche(){
        
        
        if swiche.isOn {
            
            inputTextField.placeholder = "Blue turn"
            
        } else {
            
            inputTextField.placeholder = "Gray turn"
        }
    }
    
    
    //MARK: Metodos CollectionView Delegate
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return messages.count
    }
    
    var messages = [Message]()
    
    var cell: ChatMessageCell!
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! ChatMessageCell
        
        let message = messages[indexPath.item]
        cell.textView.text = message.text
        
        setupCell(cell, message: message)
        
        if let text = message.text {
            //a text message
            cell.bubbleWidthAnchor?.constant = estimateFrameForText(text).width + 32
            cell.textView.isHidden = false
        
        } else if message.text == nil {
            //fall in here if its an image message
            cell.bubbleWidthAnchor?.constant = 200
            cell.textView.isHidden = true
        }
        
        return cell
    }
    
    //................................................................................................
    
    fileprivate func setupCell(_ cell: ChatMessageCell, message: Message) {
        
        if message.id == 1 {
            //outgoing blue
            
            cell.bubbleViewRightAnchor?.isActive = true
            cell.bubbleViewLeftAnchor?.isActive = false
            
            if message.text != nil {
                //text message
                cell.bubbleView.backgroundColor = ChatMessageCell.blueColor
                cell.textView.textColor = UIColor.white
                cell.messageImageView.isHidden = true
            
            } else {
                //image message
                cell.messageImageView.image = message.imagen
                cell.messageImageView.isHidden = false
                cell.bubbleView.backgroundColor = UIColor.clear
            }
            
            
        } else if message.id == 2 {
            //incoming gray
            
            cell.bubbleViewRightAnchor?.isActive = false
            cell.bubbleViewLeftAnchor?.isActive = true
            
            if message.text != nil {
                //mensaje de texto
                cell.bubbleView.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 234/255, alpha: 1.0)
                cell.textView.textColor = UIColor.black
                cell.messageImageView.isHidden = true
            
            } else {
                //mensaje de imagen
                cell.messageImageView.image = message.imagen
                cell.messageImageView.isHidden = false
                cell.bubbleView.backgroundColor = UIColor.clear
            }
            
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 80
        
        let message = messages[indexPath.item]
        if let text = message.text {
            height = estimateFrameForText(text).height + 20
        }
        
        else if let imageWidth = message.imageWidth?.floatValue, let imageHeight = message.imageHeight?.floatValue {
            
            // h1 / w1 = h2 / w2
            // solve for h1
            // h1 = h2 / w2 * w1
            
            height = CGFloat(imageHeight / imageWidth * 200)
        }
        
        let width = UIScreen.main.bounds.width
        return CGSize(width: width, height: height)
    }
    
    
    fileprivate func estimateFrameForText(_ text: String) -> CGRect {
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16)], context: nil)
    }
    
    
    var reusableView = FooterCell()
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        if kind == UICollectionElementKindSectionFooter {
        
            reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,  withReuseIdentifier: "Footer", for: indexPath) as! FooterCell
            
        }
        
        return reusableView
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        return CGSize(width: self.view.frame.width, height: 50)
    }
    
    
    
    //MARK: PickerController
    
    var imagenSeleccionada: UIImage?
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        //we selected an image
        handleImageSelectedForInfo(info as [String : AnyObject])
        
        
        dismiss(animated: true, completion: nil)
    }
    
    
    private func handleImageSelectedForInfo(_ info: [String: AnyObject]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
            
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            
            imagenSeleccionada = selectedImage
        }
        
        
        var message: Message?
    
        if swiche.isOn == true {
            //azul
            message = Message(text: nil, id: 1, imagen: imagenSeleccionada, imageHeight: imagenSeleccionada?.size.height as NSNumber?, imageWidth: imagenSeleccionada?.size.width as NSNumber?)
            
        } else {
            
            message = Message(text: nil, id: 2, imagen: imagenSeleccionada, imageHeight: imagenSeleccionada?.size.height as NSNumber?, imageWidth: imagenSeleccionada?.size.width as NSNumber?)
        }
        
        messages.append(message!)
        collectionView?.reloadData()
        
    }
    
    
    
    // MARK: containerview
    lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter message..."
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.frame.size.width = 150.0
        return textField
    }()
    
    
    lazy var swiche: UISwitch = {
        let swiche = UISwitch()
        swiche.translatesAutoresizingMaskIntoConstraints = false
        swiche.addTarget(self, action: #selector(acciondelswiche), for: UIControlEvents.valueChanged)
        return swiche
        
    }()
    
    lazy var separatorLineView: UIView = {
        
        let separatorLineView = UIView()
        separatorLineView.translatesAutoresizingMaskIntoConstraints = false
        separatorLineView.backgroundColor = UIColor.lightGray
        return separatorLineView
    }()
    
    
    lazy var uploadImageView: UIImageView = {
        let imagen = UIImageView()
        imagen.isUserInteractionEnabled = true
        imagen.image = UIImage(named: "qlq")
        imagen.translatesAutoresizingMaskIntoConstraints = false
        imagen.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleUploadTap)))
        return imagen
    }()
    
    
    
    lazy var inputContainerView: UIView = {
        
        let containerView = UIView()
        containerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
        containerView.backgroundColor = UIColor.white
        
        
        containerView.addSubview(self.inputTextField)
        containerView.addSubview(self.swiche)
        containerView.addSubview(self.separatorLineView)
        containerView.addSubview(self.uploadImageView)
        
        
        //x,y,w,h
        self.inputTextField.leftAnchor.constraint(equalTo: self.swiche.rightAnchor, constant: 4).isActive = true
        self.inputTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        self.inputTextField.rightAnchor.constraint(equalTo: self.uploadImageView.leftAnchor, constant: 4).isActive = true
        self.inputTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        self.inputTextField.backgroundColor = UIColor.clear
        
        
        //x,y,w,h
        self.swiche.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 4).isActive = true
        self.swiche.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        self.swiche.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.swiche.widthAnchor.constraint(equalToConstant: 55).isActive = true
        
        
        
        //x,y,w,h
        self.uploadImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        self.uploadImageView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        self.uploadImageView.widthAnchor.constraint(equalToConstant: 47).isActive = true
        self.uploadImageView.heightAnchor.constraint(equalToConstant: 47).isActive = true
        
        
        //x,y,w,h
        self.separatorLineView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        self.separatorLineView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        self.separatorLineView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        self.separatorLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
        return containerView
        
    }()
    
    
    
    
    //MARK: AccesoryView
    override var inputAccessoryView: UIView? {
        get {
            
            return inputContainerView
            
        }
    }
    
    override var canBecomeFirstResponder : Bool {
        return true
    }
    
    
    //MARK: Metodos del textfield
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if swiche.isOn {
            
            inputTextField.placeholder = "Blue turn"
            
            if turno == 1 {
                //reusableView.etiqueta.isHidden = false
            }
            
        } else {
            
            inputTextField.placeholder = "Gray turn"
            
            if turno == 1 {
                //reusableView.etiqueta.isHidden = true
            }
        }
        
        
        self.uploadImageView.alpha = 1.0
        
        if inputTextField.text != "" {
            
            
            if turno == 0 {
                label.text = inputTextField.text
            }
            
            
            if turno == 1 {
                
                var message: Message?
                if swiche.isOn == true {
                    
                    message = Message(text: self.inputTextField.text, id: 1, imagen: nil, imageHeight: nil, imageWidth: nil)
                    
                } else {
                    
                    message = Message(text: self.inputTextField.text, id: 2, imagen: nil, imageHeight: nil, imageWidth: nil)
                }
                
                messages.append(message!)
                self.inputTextField.text = nil
                collectionView?.reloadData()
                
            }
            
            swiche.isEnabled = true
            turno = 1
            
            collectionView?.reloadData()
            inputTextField.text = ""
            
            if messages.count > 0 {
                let indexpath = IndexPath(item: self.messages.count - 1, section: 0)
                self.collectionView?.scrollToItem(at: indexpath, at: .bottom, animated: true)
            }
            
            
            
        }
        
        //handleKeyboardDidShow()
        
        return true
    }
    
    
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if holaqlq == 0 {
            
            if dosletras.text == nil {
                createAlert(title: "Pon las dos letras para arriba")
                //createCustomAlert()
            }
        }
    }
    
    
    //MARK: Icono NavBar
    
    var label = UILabel()
    var dosletras = UILabel()
    var image_view = UIImageView()
    let infoButton = UIButton(type: .infoLight)
    let backButton = UIButton(type: .custom)
    
    func initUI() {
        
        //let rect:CGRect = CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: CGSize.init(width: 64, height: 64))
        //let titleView:UIView = UIView.init(frame: rect)
        
        backButton.addTarget(self, action: #selector(irParaAtras), for: .touchUpInside)
        
        infoButton.frame = CGRect(x: navBar.frame.width - 40, y: 32, width: 40, height: 25)
        backButton.frame = CGRect(x: 10, y: 32, width: 25, height: 25)
        
        /* image */
        image_view.backgroundColor = UIColor(red: 138/255, green: 143/255, blue: 154/255, alpha: 1.0)
        image_view.frame = CGRect.init(x: 0, y: 0, width: 38, height: 38)
        //image_view.center = CGPoint.init(x: titleView.center.x, y: titleView.center.y - 22)
        image_view.center = CGPoint(x: navBar.center.x, y: navBar.center.y)
        image_view.layer.cornerRadius = image_view.bounds.size.width / 2.0
        image_view.layer.masksToBounds = true
        //titleView.addSubview(image_view)
        navBar.addSubview(image_view)
        
        /* label */
        label = UILabel.init(frame: CGRect.init(x: 0, y: 27, width: 170, height: 24))
        label.font = UIFont.systemFont(ofSize: 12)
        //label.center = CGPoint.init(x: titleView.center.x, y: titleView.center.y + 7)
        label.center = CGPoint.init(x: navBar.center.x, y: navBar.center.y + 28)
        label.textAlignment = .center
        //titleView.addSubview(label)
        navBar.addSubview(label)
        
        
        backButton.setImage(UIImage(named: "back"), for: .normal)
        
        //titleView.addSubview(backButton)
        //titleView.addSubview(infoButton)
        
        navBar.addSubview(backButton)
        navBar.addSubview(infoButton)
        
        dosletras = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 25))
        //dosletras.center = CGPoint.init(x: titleView.center.x, y: titleView.center.y - 22)
        dosletras.center = image_view.center
        dosletras.textColor = .white
        dosletras.font = UIFont.boldSystemFont(ofSize: 17)
        dosletras.textAlignment = .center
        //titleView.addSubview(dosletras)
        navBar.addSubview(dosletras)
        
        
        //self.navigationItem.titleView = titleView
        
        
    }
    
    func createAlert(title: String) {
        
        self.inputContainerView.isHidden = true
        
        let alertController = UIAlertController(title: title, message: "", preferredStyle: .alert)
        
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {
            alert -> Void in
            
            self.inputContainerView.isHidden = false
            
            let firstTextField = alertController.textFields![0] as UITextField
            
            let text = firstTextField.text
            if (text?.characters.count)! <= 2 && text != " " && text != "  " && text != "" {
                
                self.dosletras.text = text
                self.image_view.isHidden = false
            
            } else {
                
                self.createAlert(title: "Please, put 2 characters")
            }
    
        })
        
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Choose the acronym (max 2 letters)"
        }
        
        alertController.addAction(saveAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    //.....
    /*
 func handlePan(gestureRecognizer: UIPanGestureRecognizer) {
 
 if gestureRecognizer.state == .began {
 // When the drag is first recognized, you can get the starting coordinates here
 UIView.animate(withDuration: 0.5, delay: 0.5, options: UIViewAnimationOptions.curveEaseOut, animations: {
 //maybe this code works.??
 }, completion: nil)
 }
 
 if gestureRecognizer.state == .changed {
 let translation = gestureRecognizer.translation(in: self.view)
 // Translation has both .x and .y values
 reset(sender: gestureRecognizer)
 print(translation.x, translation.y)
 }
 }
 
 
 func reset(sender: UIGestureRecognizer) {
 
 let cell = sender.view as! UICollectionViewCell
 let i = self.collectionView?.indexPath(for: cell)?.item
 
 if let qlq = i {
 self.messages.remove(at: qlq)
 }
 self.collectionView?.reloadData()
 
 }
 */
    
    /*let cSelector = #selector(reset(sender:))
     let UpSwipe = UISwipeGestureRecognizer(target: self, action: cSelector)
     UpSwipe.direction = UISwipeGestureRecognizerDirection.left
     //cell.addGestureRecognizer(UpSwipe)
     
     let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gestureRecognizer:)))
     cell.addGestureRecognizer(gestureRecognizer)*/
 
    /*let height: CGFloat = 38 //whatever height you want
     let bounds = self.navigationController!.navigationBar.bounds
     self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height + height)*/
    
    
    
/*func keyboardWillShow(event: Notification) {
 //let keyboardqlq = inputTextField.frame.height
 guard let keyboardFrame = (event.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
 guard let colelctionview = self.collectionView else { return }
 
 colelctionview.contentInset.bottom = keyboardFrame.height - 200
 colelctionview.scrollIndicatorInsets.bottom = keyboardFrame.height - 200
 
 // do NOT scroll messages if the keyboard is the `accessoryView`
 if keyboardFrame.height != inputContainerView.frame.height {
 handleKeyboardDidShow()
 }
 }
 
 
 func handleKeyboardDidShow() {
 
 if messages.count > 0 {
 let indexPath = IndexPath(item: messages.count - 1, section: 0)
 collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
 }
 }
 
 func setupKeyboardObservers() {
 
 NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardDidShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
 }
 
 */
 
}
