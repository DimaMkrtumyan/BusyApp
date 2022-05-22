//
//  SettingsViewController.swift
//  Busy
//
//  Created by Davit Muradyan on 16.02.22.
//

import UIKit

protocol UserUpdatedDelegate: AnyObject {
    func saveSuccess()
}
class SettingsViewController: UIViewController {

    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let datePicker = UIDatePicker()
    let personalViewModel = PersonalViewModel()
    let settingsViewModel = SettingsViewModel()
    weak var delegate: UserUpdatedDelegate?
    var name = String()
    var phone = String()
    var dob = String()
    var image = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerKeyboardNotifications()
        personImageView.layer.cornerRadius = personImageView.frame.width / 2
        setupContent()
        setupTextField(textField: nameTextField)
        setupTextField(textField: phoneTextField)
        setupTextField(textField: dobTextField)
        setupTextNumberTextFields()
        datePicker.addTarget(self, action: #selector(handler), for: .valueChanged)
        creatingDatePicker()
    }
    
    func setupPhoto() -> String {
            let imageData = personImageView.image?.pngData()
            return imageData!.base64EncodedString()
        }
    
    private func updateUserData() {
        showLoader()
        settingsViewModel.updateUserData(name: nameTextField.text!, phone: phoneTextField.text!, dob: dobTextField.text!, image: "") { result in // ! pahe nayel
            
            switch result {
            case .success():
                self.hideLoader()
                print("User Updated")
                self.delegate?.saveSuccess()
                self.navigationController?.popViewController(animated: true)
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    func setupImage(_ sourceType: UIImagePickerController.SourceType) {
        let photoVC = UIImagePickerController()
        photoVC.sourceType = sourceType
        photoVC.allowsEditing = true
        photoVC.delegate = self
        present(photoVC, animated: true)
    }
    
    func setupTextField(textField: UITextField) {
        textField.delegate = self
        textField.setupLeftView()
        textField.setupRightViewIcon("pencil")
    }
    
    func setupContent() {
        personImageView.load(str: image)
        nameTextField.text = name
        phoneTextField.text = phone
        dobTextField.text = dob
    }
    
    func setupTextNumberTextFields() {
        phoneTextField.addInputAccessoryView(title: "Done", target: self, selector: #selector(donePressed))
        dobTextField.addInputAccessoryView(title: "Done", target: self, selector: #selector(donePressed))
        dobTextField.inputAccessoryView = datePicker
    }
    
    func creatingDatePicker() {
        dobTextField.inputView = datePicker
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.datePickerMode = .date
//        datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -70, to: Date())
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: -1, to: Date())
        dobTextField.addInputAccessoryView(title: "Done", target: self, selector: #selector(dobDone))
    }
     func setDob(_ newDate: Date?) {
        guard let dob = newDate else { return }
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MMM d, yyyy"
        dobTextField.text = dateFormater.string(from: dob)
    }
    
    @objc func donePressed() {
        view.endEditing(true)
    }
    
    @objc func handler(_ sender: UIDatePicker) {
        setDob(datePicker.date)
    }
    @objc func dobDone() {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MMM d, yyyy"
        let strDate = dateFormater.string(from: datePicker.date)
        dobTextField.text = strDate
        view.endEditing(true)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func choosePhotoPressed(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: "asd", message: "asdasdasd", preferredStyle: .actionSheet)
        self.present(actionSheet, animated: true)
        let camera = UIAlertAction(title: "Open Camera", style: .default, handler: { (action) -> Void in
            self.setupImage(.camera)
        })
        let photos = UIAlertAction(title: "Select from Photos", style: .default, handler: { (action) -> Void in
            self.setupImage(.photoLibrary)
        })
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
        }))
        actionSheet.addAction(camera)
        actionSheet.addAction(photos)
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        print("Saved")
        updateUserData()
    }
}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
}

extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
//        removeButton.alpha = 1
        personImageView.image = image
    }
}

extension SettingsViewController {
    
    ///Register for keyboard willHide willShow notifiication
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(SettingsViewController.keyboardNotification(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
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
