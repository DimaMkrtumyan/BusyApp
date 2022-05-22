//
//  CardsViewController.swift
//  Busy
//
//  Created by Davit Muradyan on 16.02.22.
//

import UIKit

class CardsViewController: UIViewController {
    @IBOutlet weak var cardsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        registerKeyboardNotifications()
    }
    
    func setupTableView() {
        cardsTableView.delegate = self
        cardsTableView.dataSource = self
        cardsTableView.register(UINib(nibName: "CardTableViewCell", bundle: .main), forCellReuseIdentifier: "CardTableViewCell")
    }
    
    func setupTextField(texfield: UITextField) {
        texfield.delegate = self
        texfield.font = UIFont(name: "Montserratarm-Regular", size: 13)
        texfield.borderStyle = .none
        texfield.layer.cornerRadius = 4
        texfield.backgroundColor = UIColor(named: "CustomGray")
        texfield.setupLeftView()
        texfield.addInputAccessoryView(title: "Done", target: self, selector: #selector(donePressed))
    }
    @objc func donePressed() {
        view.endEditing(true)
    }
    @objc func addPressed() {
        print("Added")
    }
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension CardsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardTableViewCell", for: indexPath) as! CardTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0))
        headerView.backgroundColor = .white
        let headerLabel = UILabel(frame: CGRect(x: 24, y: 24, width: 76, height: 20))
        headerLabel.font = UIFont(name: "Montserratarm-Medium", size: 16)
        headerLabel.text = "Քարտեր"
        headerView.addSubview(headerLabel)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0))
        footerView.backgroundColor = .white
        let footerLabel = UILabel(frame: CGRect(x: 24, y: 40, width: 133, height: 20))
        footerLabel.font = UIFont(name: "Montserratarm-Medium", size: 16)
        footerLabel.text = "Կցել նոր քարտ"
        footerView.addSubview(footerLabel)
        let cardTextField = UITextField(frame: CGRect(x: 24, y: footerLabel.frame.maxY + 15, width: tableView.frame.width - 48, height: 58))
        cardTextField.placeholder = "0000 - 0000 - 0000 - 0000"
        cardTextField.keyboardType = .numberPad
        setupTextField(texfield: cardTextField)
        footerView.addSubview(cardTextField)
        let fullNameTextField = UITextField(frame: CGRect(x: 24, y: cardTextField.frame.maxY + 10, width: tableView.frame.width - 48, height: 58))
        fullNameTextField.placeholder = "NAME SURNAME"
        fullNameTextField.keyboardType = .namePhonePad
        setupTextField(texfield: fullNameTextField)
        footerView.addSubview(fullNameTextField)
        let dateTextField = UITextField(frame: CGRect(x: 24, y: fullNameTextField.frame.maxY + 10, width: (fullNameTextField.frame.width / 2) - 4, height: 58))
        dateTextField.placeholder = "mm / yy"
        dateTextField.keyboardType = .numberPad
        setupTextField(texfield: dateTextField)
        footerView.addSubview(dateTextField)
        let cvvTextField = UITextField(frame: CGRect(x: dateTextField.frame.maxX + 8, y: dateTextField.frame.origin.y, width: dateTextField.frame.width, height: 58))
        cvvTextField.placeholder = "CVC/CVV"
        cvvTextField.keyboardType = .numberPad
        setupTextField(texfield: cvvTextField)
        footerView.addSubview(cvvTextField)
        let addButton = UIButton(frame: CGRect(x: 24, y: cvvTextField.frame.maxY + 16, width: tableView.frame.width - 48, height: 55))
        addButton.setTitle("Ավելացնել", for: .normal)
        addButton.titleLabel?.textColor = .white
        addButton.backgroundColor = UIColor(named: "CustomRed")
        addButton.titleLabel!.font = UIFont(name: "Montserratarm-Bold", size: 14)
        addButton.layer.cornerRadius = 4
        addButton.addTarget(self, action: #selector(addPressed), for: .touchUpInside)
        footerView.addSubview(addButton)
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 53
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 285
    }
}

extension CardsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

extension CardsViewController {
    
    ///Register for keyboard willHide willShow notifiication
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(CardsViewController.keyboardNotification(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardNotification(notification: NSNotification) {
        
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration: TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve: UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                cardsTableView.contentInset = .zero
                
            } else {
                let height: CGFloat = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)!.size.height + 5
                cardsTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0)
            }
            
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
}
