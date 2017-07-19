//
//  ViewController.swift
//  APLICACION FAKE TEXT
//
//  Created by Edward Pizzurro Fortun on 15/7/16.
//  Copyright © 2016 Edwjon. All rights reserved.
//

import UIKit
import GoogleMobileAds



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, GADBannerViewDelegate

{
    
    @IBOutlet var constrainTop: NSLayoutConstraint!
    
    
    // MARK: Clase del mensaje
    // data structure of message
    class Message {
        var content: String?
        var isOutgoing: Bool = false

        init(content: String, isOutgoing: Bool = false) {
            self.content = content
            self.isOutgoing = isOutgoing
        }
    }


    // MARK: Outlets
    @IBOutlet var fotoFinal: UIImageView!

    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var readyboton: UIBarButtonItem!
    @IBOutlet var botonReset: UIBarButtonItem!
    
    
    var turno = Int()
    
    // MutableArray which has the messages
    var messages: [Message] = []
    
   
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
      let defaults = UserDefaults.standard
        
      NotificationCenter.default.addObserver(
            self,
            selector: #selector(ViewController.keyboardWillShow(event:)),
            name: NSNotification.Name.UIKeyboardWillShow,
            object: nil
      )
            
            
      inputTextField.delegate = self
            
      interstitial = createAndLoadInterstitial()
            
      fotoFinal.isHidden = true
            
      swiche.isEnabled = false
            
      swiche.isOn = true
            
            
      tableView.delegate = self
      tableView.dataSource = self
      
      tableView.separatorStyle = UITableViewCellSeparatorStyle.none
      tableView.bottomAnchor.accessibilityActivate()
        
      inputTextField.placeholder = "Name to show on top"
        
        
        
      self.tableView.rowHeight = UITableViewAutomaticDimension
      self.tableView.estimatedRowHeight = 48.0
        
      self.tableView.keyboardDismissMode = .interactive
            
   
      let color = UIColor.init(colorLiteralRed: 0.021, green: 0.500, blue: 0.999, alpha: 1.0)
      
      
      self.swiche.onTintColor = color
      self.swiche.tintColor = .gray

      
      
      if defaults.bool(forKey: "FirstLaunch") {
            //qlq
      } else {
        
         setupFondoImage(Imagen: UIImage(named:"Tutorial#1")!, gestor: UITapGestureRecognizer(target: self, action:#selector(ViewController.imageTapped)),alpha: 1.0)
         
         defaults.set(true, forKey: "FirstLaunch")
         defaults.synchronize()
      }
   }
    
    

    //MARK: tecladoApareceYBaja
    func keyboardWillShow(event: Notification) {
        guard let keyboardFrame = (event.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        guard let tableVieww = self.tableView else { return }

        tableVieww.contentInset.bottom = keyboardFrame.height
        tableVieww.scrollIndicatorInsets.bottom = keyboardFrame.height

        // do NOT scroll messages if the keyboard is the `accessoryView`
        if keyboardFrame.height != inputContainerView.frame.height {
            scrollToBottom()
        }
    }

    
    func scrollToBottom() {
       if messages.count > 0 {
          tableView.scrollToRow(at: IndexPath(row: messages.count - 1 , section: 0), at: .bottom, animated: false)
      }
    }


    
    //MARK: imagen-fondo
    var imagenn = UIImageView()
    
    func setupFondoImage(Imagen:UIImage, gestor: UITapGestureRecognizer, alpha: CGFloat) {
        
        let imagen = UIImageView(image: Imagen)
        imagen.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.navigationController?.isNavigationBarHidden = true
        self.inputContainerView.isHidden = true
        let tapGestureRecognizer = gestor
        imagen.isUserInteractionEnabled = true
        imagen.addGestureRecognizer(tapGestureRecognizer)
        imagenn = imagen
        imagenn.alpha = alpha
        self.view.addSubview(imagenn)
    }

    
    func imageTapped(){
        
        self.navigationController?.isNavigationBarHidden = false
        self.inputContainerView.isHidden = false
        imagenn.isHidden = true
    }

    
    
    
    // MARK: cellForRowAtIndexPath
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let message = messages[(indexPath as NSIndexPath).row]

        let cellIdentifier = message.isOutgoing ? "OutgoingCell" : "IncomingCell"

        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        if let messageCell = cell as? MessageCell {
            messageCell.messageLabel?.text = message.content
        }
        return cell

   }
   
   
   
    // MARK: sections y rows
    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return messages.count
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        
        if editingStyle == UITableViewCellEditingStyle.delete{
            
            messages.remove(at: (indexPath.row))
            
            tableView.reloadData()
        }
    }




    // MARK: memoria
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    

    // MARK: botones, swiches, textfield, ads y screenshot

    //el boton para hacer nueva conversacion

    
    @IBAction func botonResetAction(_ sender: AnyObject) {
        
      hacerNuevoFake()
      self.inputTextField.text = ""
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
        //request.testDevices = [ kGADSimulatorID ]
        
        interstitial.load(request)
        
        return interstitial
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
    
    
   
    
    //boton ready
    @IBAction func botonReady(_ sender: AnyObject)
    {
      
      if self.tableView.isEditing {
         //nothing happen...
      }
      
      else {
      
        
         
         let aka = (self.navigationController?.navigationBar.frame.size.height)! + 1.0
         constrainTop.constant = aka
        
        if turnoDelBoton == 0 {
            
            inputTextField.resignFirstResponder()
         
         
                if inputTextField.text == "" {
                  
                  
                        if (self.interstitial.isReady)
                        {
                            self.interstitial.present(fromRootViewController: self)
                            interstitial = createAndLoadInterstitial()
                        }
                    
                        
                        fotoFinal.isHidden = false
                  
                  if self.view.frame.size.width > 325.0 {
                     
                     fotoFinal.image = UIImage(named: "ParteAbajo")
                  
                  } else {
                     
                     fotoFinal.image = UIImage(named: "qlq2")
                  }
                     
                        self.inputContainerView.isHidden = true
                        
                        readyboton.title = "Details"
                        navigationItem.leftBarButtonItem = nil
                        
                        let button = UIButton.init(type: .custom)
                        button.setImage(UIImage.init(named: "Back"), for: UIControlState.normal)
                        button.frame = CGRect.init(x: 0, y: 0, width: 101.5, height: 30)
                        button.addTarget(self, action: #selector(irParaAtras), for: .touchUpInside)
                        let barButton = UIBarButtonItem.init(customView: button)
                        self.navigationItem.leftBarButtonItem = barButton
                }
                
                setupFondoImage(Imagen: UIImage(named:"Tutorial2")!, gestor: UITapGestureRecognizer(target:self, action:#selector(ViewController.imagentutorial2)), alpha: 0.77)
         
            
            turnoDelBoton = 1
            
        } else if turnoDelBoton == 1 {
            
            //QLQ
        }
      }
    }
    
    func irParaAtras() {
        
        turnoDelBoton = 0
        readyboton.title = "Get it done!"
        navigationItem.leftBarButtonItem = self.botonReset
        self.inputContainerView.isHidden = false
        
        viewww.removeFromSuperview()
        
    }
    
    
    private var turnoDelBoton = 0
    
    func imagentutorial2() {
        
        imagenn.isHidden = true
        self.navigationController?.isNavigationBarHidden = false
        viewDeScreen()
        //NSLayoutConstraint.deactivate([holamama])
        constrainTop.constant = 0
    }
    
    
    
    var viewww = UIView()
    
    func viewDeScreen() {
        
       viewww = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        let tapGestureRecognizerDelScreenShot = UITapGestureRecognizer(target:self, action:#selector(ViewController.tomarScreenShot))
        viewww.backgroundColor = UIColor.clear
        viewww.isUserInteractionEnabled = true
        viewww.addGestureRecognizer(tapGestureRecognizerDelScreenShot)
        self.view.addSubview(viewww)
        
        
    }
    

    //tomar screenshot
    func tomarScreenShot() {
    
        UIImageWriteToSavedPhotosAlbum(screenshot(), nil, nil, nil)
        
        let alertController = UIAlertController(title: "ScreenShot saved", message: "The screenshot has been saved correctly!!!", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            print("OK")
        }
        
        alertController.addAction(okAction)
        
        
        turnoDelBoton = 0
        readyboton.title = "Get it done!"
        navigationItem.leftBarButtonItem = self.botonReset
        self.inputContainerView.isHidden = false
        
        viewww.removeFromSuperview()

        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    
    //hacer una nueva conversacion
    func hacerNuevoFake () {
        
      if turnoDelBoton == 0 {
        
         readyboton.title = "Get it done!"
        
         fotoFinal.isHidden = true
        
         self.inputContainerView.isHidden = false
        
         messages.removeAll()
        
         swiche.isOn = true
        
         navigationItem.title = ""
        
         turno = 0
        
         inputTextField.placeholder = "Name to show on top"
        
         swiche.isEnabled = false
        
         inputTextField.resignFirstResponder()
            
         tableView.reloadData()
      
        }
        
        else if turnoDelBoton == 1 {
            //QLQ
        }
        
    }
    
    
    //accion del swiche
    func acciondelswiche(){

        if swiche.isOn {

            inputTextField.placeholder = "Blue turn"

        } else {

            inputTextField.placeholder = "Gray turn"
        }
    }

    
    
    //textfiedl should return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        inputTextField.resignFirstResponder()

        inputTextField.becomeFirstResponder()
        
        
        if swiche.isOn {

            inputTextField.placeholder = "Blue turn"

        } else {

            inputTextField.placeholder = "Gray turn"
        }



      if inputTextField.text != "" {

            if turno == 0 {

                navigationItem.title = inputTextField.text

            }
         
            if turno == 1 {
            
               messages.append(Message(content: inputTextField.text!, isOutgoing: swiche.isOn))
               swiche.isEnabled = true

            }

            swiche.isEnabled = true
            turno = 1
         
            tableView.reloadData()
            inputTextField.text = ""
      }

      scrollToBottom()
        

        return true
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

   
    lazy var inputContainerView: UIView = {

        let containerView = UIView()
        containerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
        containerView.backgroundColor = UIColor.white
      

      
        containerView.addSubview(self.inputTextField)

        containerView.addSubview(self.swiche)

        //x,y,w,h
        self.inputTextField.leftAnchor.constraint(equalTo: self.swiche.rightAnchor).isActive = true
        self.inputTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        self.inputTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        self.inputTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        self.inputTextField.backgroundColor = UIColor.clear



        //x,y,w,h
      
        self.swiche.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 5.0).isActive = true
        self.swiche.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        self.swiche.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.swiche.rightAnchor.constraint(equalTo: self.inputTextField.leftAnchor).isActive = true
        self.swiche.widthAnchor.constraint(equalToConstant: 55).isActive = true


        
        containerView.addSubview(self.separatorLineView)
        //x,y,w,h
        self.separatorLineView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        self.separatorLineView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        self.separatorLineView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        self.separatorLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true

        return containerView
    }()


    
    
    // MARK: metodos del container
    
    override var inputAccessoryView: UIView? {
        get {
            return inputContainerView
        }
    }

    override var canBecomeFirstResponder : Bool {
        return true
    }



    // MARK: mandarImagen
    //Mandar imagen
   

    
}




