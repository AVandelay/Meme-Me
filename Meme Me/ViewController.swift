//
//  ViewController.swift
//  Meme Me
//
//  Created by Ken Westdorp on 7/4/17.
//
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: Outlets
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var albumButton: UIButton!
    @IBOutlet weak var memeImage: UIImageView!

    // MARK: Properties
    let memeTextFieldDelegate = MemeTextFieldDelegate()

    let memeTextAttributes:[String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -3.0]

    //MARK: Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()

        if memeImage.image == nil {
            shareButton.isEnabled = false
        } else {
            shareButton.isEnabled = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black

        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            cameraButton.isEnabled = false
        }

        // text field font and style
        textFieldStyle(textField: topTextField, text: "TOP")
        textFieldStyle(textField: bottomTextField, text: "BOTTOM")
    }

    func textFieldStyle(textField: UITextField, text: String) {
        textField.defaultTextAttributes = memeTextAttributes
        textField.text = text
        textField.textAlignment = .center
        textField.delegate = memeTextFieldDelegate
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }

    // MARK: Methods

    // keyboad dodger
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }

    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }

    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }

    func keyboardWillShow(_ notification:Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = 0 - getKeyboardHeight(notification)
        }
    }

    func keyboardWillHide(_ notification:Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = 0
        }
    }

    // image picker

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)

    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            memeImage.image = image

            picker.dismiss(animated: true, completion: nil)
        }
    }

    // MARK: IBActions

    @IBAction func shareButton(_ sender: Any) {
    }

    @IBAction func deleteButton(_ sender: Any) {
    }

    @IBAction func cameraButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        } else {
            print("Camera not available")
        }
    }
    
    @IBAction func albumButton(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        self.present(pickerController, animated: true, completion: nil)
    }

}

