//
//  LoginViewController.swift
//  Busy
//
//  Created by Davit Muradyan on 06.12.21.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var phoneTextField: UITextField!
    
    let loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        registerKeyboardNotifications()
    }
    
    func goingtoPicVC(_ phoneNumber: String) {
        let pinVC = storyboard?.instantiateViewController(withIdentifier: "PinViewController") as! PinViewController
        navigationController?.pushViewController(pinVC, animated: true)
        pinVC.receivedPhoneNumber = phoneNumber
    }
    
    func setupTextField() {
        phoneTextField.delegate = self
        phoneTextField.setupLeftView()
        phoneTextField.addInputAccessoryView(title: "Done", target: self, selector: #selector(donePressed))
    }
    
    @objc func donePressed() {
        view.endEditing(true)
    }

    @IBAction func nextPressed(_ sender: UIButton) {
        showLoader()
        loginViewModel.checkNumber(phoneNumber: phoneTextField.text!) { result in
            switch result {
            case .success(let phoneNumber):
                self.hideLoader()
                self.goingtoPicVC(phoneNumber)
            case .failure(_):
                self.hideLoader()
                print("Nope!!!")
            }
        }
    }
    
    @IBAction func goingToRegisterVC(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {}

extension LoginViewController {
    
    ///Register for keyboard willHide willShow notifiication
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardNotification(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
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
