//
//  ForgotPinViewController.swift
//  Busy
//
//  Created by Davit Muradyan on 29.12.21.
//

import UIKit

class ForgotPinViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var codeViews: [CodeView]!
    @IBOutlet weak var codeTextField: UITextField!
    
    let forgorPinViewModel = ForgotPinViewModel()
    var phoneNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        registerKeyboardNotifications()
    }
    
    func setupTextField() {
        codeTextField.delegate = self
        codeTextField.addInputAccessoryView(title: "Done", target: self, selector: #selector(donePressed))
    }
    
    func goingToSetNewPinVC() {
        let setNewPinVC = storyboard?.instantiateViewController(withIdentifier: "SetNewPinViewController") as! SetNewPinViewController
        setNewPinVC.phoneNumber = phoneNumber
        navigationController?.pushViewController(setNewPinVC, animated: true)
    }
    
    @objc func donePressed() {
        view.endEditing(true)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func confirmPressed(_ sender: UIButton) {
        forgorPinViewModel.verifySMS(phoneNumber, codeTextField.text!) { result in
            switch result {
            case .success():
                self.goingToSetNewPinVC()
            case .failure(_):
                print("Net")
            }
        }
    }
}

extension ForgotPinViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let fullText = textField.text! + string
        if fullText.count == 5 && string != "" {
            return false
        }
        if string == "" {
            codeViews[textField.text!.count - 1].numberLabel.text = "0"
        } else {
            codeViews[textField.text!.count].numberLabel.text = string
        }
        return fixingLength(textField: textField, maxLength: 4, range: range, string: string) && minimizingLength(textField: textField, minLength: 0, range: range, string: string)
    }
}

extension ForgotPinViewController {
    
    ///Register for keyboard willHide willShow notifiication
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(ForgotPinViewController.keyboardNotification(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
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
