//
//  PhoneViewController.swift
//  Busy
//
//  Created by Davit Muradyan on 29.12.21.
//

import UIKit

class PhoneViewController: UIViewController {
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let forgotPinViewModel = ForgotPinViewModel()
    var receivedPhoneNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        registerKeyboardNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTextFieldContent()
    }
    
    func setupTextFieldContent() {
        phoneTextField.text = receivedPhoneNumber
    }
    
    func setupTextField() {
        phoneTextField.delegate = self
        phoneTextField.setupLeftView()
        phoneTextField.addInputAccessoryView(title: "Done", target: self, selector: #selector(donePressed))
    }
    
    func goingToForgotPinVC(_ phoneNumber: String) {
        let forgorPinVC = storyboard?.instantiateViewController(withIdentifier: "ForgotPinViewController") as! ForgotPinViewController
        forgorPinVC.phoneNumber = phoneNumber
        navigationController?.pushViewController(forgorPinVC, animated: true)
    }
    
    @objc func donePressed() {
        view.endEditing(true)
    }
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextPressed(_ sender: UIButton) {
        forgotPinViewModel.verifyPhone(phoneTextField.text!) { result in
            switch result {
            case .success(let phoneNumber):
                self.goingToForgotPinVC(phoneNumber)
            case .failure(_):
                print("Nicht")
            }
        }
    }
}

extension PhoneViewController: UITextFieldDelegate {}

extension PhoneViewController {
    
    ///Register for keyboard willHide willShow notifiication
    func registerKeyboardNotifications() { NotificationCenter.default.addObserver(self, selector: #selector(PhoneViewController.keyboardNotification(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
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

