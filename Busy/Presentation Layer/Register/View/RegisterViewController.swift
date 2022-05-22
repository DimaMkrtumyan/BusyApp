//
//  ViewController.swift
//  Busy
//
//  Created by Davit Muradyan on 06.12.21.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    let registerViewModel = RegisterViewModel()
    let storageManager = StorageManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        registerKeyboardNotifications()
        welcomeLabel.attributedText = setupMainLabel(string: "Բարև՛։ Ես Busy-ն եմ :)", location: 10, length: 6, color: UIColor(named: "CustomRed")!, fontSize: 24)
        setupTextFields()
        setupNavigation()
    }
    
    func setupTextFields() {
        nameTextField.delegate = self
        phoneTextField.delegate = self
        nameTextField.setupLeftView()
        phoneTextField.setupLeftView()
        phoneTextField.addInputAccessoryView(title: "Done", target: self, selector: #selector(donePressed))
    }
    
    func setupNavigation() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func goingToVerifyVC(_ phoneNumber: String) {
        let verifyVC = storyboard!.instantiateViewController(withIdentifier: "VerifyViewController") as! VerifyViewController
        verifyVC.phoneNumber = phoneNumber
        navigationController?.pushViewController(verifyVC, animated: true)
    }
    
    func goingoToSigiInVC() {
        let signInVC = UIStoryboard(name: "Login", bundle: .main).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        navigationController?.pushViewController(signInVC, animated: true)
    }
    
    @objc func donePressed() {
        view.endEditing(true)
    }

    @IBAction func nextPressed(_ sender: UIButton) {
        showLoader()
        registerViewModel.register(name: nameTextField.text!, phoneNumber: phoneTextField.text!) { result in
            switch result {
            case .success(let phoneNumber):
                self.hideLoader()
                self.goingToVerifyVC(phoneNumber)
            case .failure(_):
                self.hideLoader()
            }
        }
    }
    
    @IBAction func goingToSignIn(_ sender: UIButton) {
        goingoToSigiInVC()
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

extension RegisterViewController {
    
    ///Register for keyboard willHide willShow notifiication
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterViewController.keyboardNotification(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardNotification(notification: NSNotification) {
        
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration: TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve: UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                scrollView.contentInset = .zero
                
            } else {
                let height: CGFloat = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)!.size.height + 5
                scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0)
            }
            
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
}
