//
//  ReserveViewController.swift
//  Busy
//
//  Created by Davit Muradyan on 09.02.22.
//

import UIKit

protocol ReserveViewControllerDelegate: AnyObject {
    func reloadPage()
}

class ReserveViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var networkNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var peopleCountTF: UITextField!
    @IBOutlet weak var hallTF: UITextField!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet weak var dayTF: UITextField!
    @IBOutlet weak var hourTF: UITextField!
    
    weak var delegate: ReserveViewControllerDelegate?
    let reserveViewModel = ReserveViewModel()
    let storageManager = StorageManager()
    
    var hallPicker = UIPickerView()
    var datePicker = UIDatePicker()
    var hourPicker = UIDatePicker()
    
    var halls = [RestuarantHall]()
    var logoImage: UIImage?
    var name: String?
    var networkName: String?
    var selectedHall: RestuarantHall?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        registerKeyboardNotifications()
        setupInnerViews()
    }
    
    func setupTextField() {
        peopleCountTF.delegate = self
        hallTF.delegate = self
        dayTF.delegate = self
        hourTF.delegate = self
        addInputAccessoryView(textField: peopleCountTF)
        addInputAccessoryView(textField: hallTF)
        addInputAccessoryView(textField: dayTF)
        addInputAccessoryView(textField: hourTF)
        createPicker(textField: hallTF, picker: hallPicker)
        peopleCountTF.setupLeftView()
        hallTF.setupLeftView()
        dayTF.setupLeftView()
        hourTF.setupLeftView()
        
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 100)
        dayTF.inputView = datePicker
        datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 0, to: Date())
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: 1, to: Date())
        datePicker.tintColor = UIColor(named: "CustomRed")
        
        hourPicker.datePickerMode = .time
        hourPicker.addTarget(self, action: #selector(hourPickerValueChanged(sender:)), for: .valueChanged)
        hourPicker.frame.size = CGSize(width: 0, height: 100)
        hourTF.inputView = hourPicker
        hourPicker.minimumDate = Calendar.current.date(byAdding: .hour, value: 0, to: Date())
        hourPicker.tintColor = UIColor(named: "CustomRed")
    }
    
    func addInputAccessoryView(textField: UITextField) {
        textField.addInputAccessoryView(title: "Done", target: self, selector: #selector(donePressed))
    }
    
    func createPicker(textField: UITextField, picker: UIPickerView) {
        textField.inputView = picker
        picker.delegate = self
        picker.dataSource = self
    }
    
    func setupInnerViews() {
        logoImageView.image = logoImage
        networkNameLabel.text = name!
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        let dayDate = sender.date
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        dayTF.text = dateFormater.string(from: dayDate)
    }
    
    @objc func hourPickerValueChanged(sender: UIDatePicker) {
        let hourDate = sender.date
        let hourFormmater = DateFormatter()
        hourFormmater.dateFormat = "HH:mm"
        hourTF.text = hourFormmater.string(from: hourDate)
    }
    
    @objc func donePressed() {
        view.endEditing(true)
    }
    
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        peopleCountTF.text = String(sender.tag)
    }
    
    @IBAction func reservePressed(_ sender: UIButton) {
        let date = "\(dayTF.text!)'T'\(hourTF.text!):ssZ"
        
        print(date)
//        print(setupDate(format: "d MMM, yyyy HH:mm", date: date))
        reserveViewModel.addReservation(branchId: selectedHall!.branchId, peopleCount: peopleCountTF.text!, hallId: selectedHall!.id, reservationTime: date) { [self] result in
            switch result {
            case .success():
                print(selectedHall!.branchId,peopleCountTF.text!,selectedHall!.id)
                delegate?.reloadPage()
                self.dismiss(animated: true, completion: nil)
            case .failure(_):
                print("Could not reserve")
            }
        }
    }
    func setupDate(format: String, date: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = format

        if let date = dateFormatterGet.date(from: date) {
            return dateFormatterPrint.string(from: date)
        }
        return ""
    }
}

extension ReserveViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case peopleCountTF :
            textField.text = ""
        case hallTF:
            textField.text = halls[0].name
        case dayTF:
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "d MMM, yyyy"
            textField.text = dateFormater.string(from: Date())
        case hourTF:
            let hourFormmater = DateFormatter()
            hourFormmater.dateFormat = "HH:mm"
            textField.text = hourFormmater.string(from: Date())
        default:
            print("default")
        }
    }
}

extension ReserveViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case hallPicker:
            return halls.count
        default:
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case hallPicker:
            hallTF.text = halls[row].name
            selectedHall = halls[row]
        default:
            print("asd")
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case hallPicker:
            return halls[row].name
        default:
            return ""
        }
    }
}
extension ReserveViewController {
    
    ///Register for keyboard willHide willShow notifiication
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(ReserveViewController.keyboardNotification(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
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
