//
//  OrderFooterView.swift
//  Busy
//
//  Created by Davit Muradyan on 04.02.22.
//

import UIKit

protocol OrderFooterViewDelegate: AnyObject {
    func onlinePressed()
    func offlinePressed()
    func addNewCard()
    func orderPressed()
}

class OrderFooterView: UICollectionReusableView {
    static let reuseId = "OrderFooterView"
    weak var delegate: OrderFooterViewDelegate?
    let cardsTableView = UITableView()
    let paymentButton = UIButton()
    let orderButton = UIButton()
    let paymentMethodLabel = UILabel()
    var isOnOnline = false
    let sectionLabel = UILabel()
    let cardNumberTF = UITextField()
    let nameTF = UITextField()
    let dateTF = UITextField()
    let cvvTF = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTableView() {
        cardsTableView.delegate = self
        cardsTableView.dataSource = self
        cardsTableView.register(UINib(nibName: "CardTableViewCell", bundle: .main), forCellReuseIdentifier: "CardTableViewCell")
        cardsTableView.frame = CGRect(x: 24, y: paymentButton.frame.maxY + 24, width: frame.width - 48, height: 0)
        cardsTableView.backgroundColor = .white
        cardsTableView.separatorStyle = .none
        cardsTableView.isScrollEnabled = false
        addSubview(cardsTableView)
    }
    
    func setupTextFieldDesign(_ textField: UITextField, placeholder: String) {
        textField.borderStyle = .none
        textField.backgroundColor = UIColor(named: "CustomGray")
        textField.layer.cornerRadius = 4
        textField.placeholder = placeholder
        textField.font = UIFont(name: "Montserratarm-Regular", size: 13)
        textField.setupLeftView()
        addSubview(textField)
    }
    
    func removeViews(view: UIView) {
        view.removeFromSuperview()
    }
    
    func setupFeeLabels(percent: Int, fee: Int, wholePrice: Int, receivableCoins: Int, availabelCoins: Int) {
        setupTableView()
        let serviceFeePercent = UILabel()
        let serviceFee = UILabel()
        let lineView = UIView()
        serviceFeePercent.text = "\(percent)% սպասարկում"
        serviceFeePercent.frame = CGRect(x: 24, y: 24, width: 200, height: 16)
        serviceFeePercent.font = UIFont(name: "Montserratarm-Regular", size: 13)
        addSubview(serviceFeePercent)
        serviceFee.text = "\(fee) AMD"
        serviceFee.frame = CGRect(x: frame.width - 94, y: 24, width: 100, height: 16)
        serviceFee.font = UIFont(name: "Montserratarm-Medium", size: 13)
        addSubview(serviceFee)
        lineView.frame = CGRect(x: frame.minX + 24, y: serviceFee.frame.maxY + 24, width: frame.width - 48, height: 1)
        lineView.backgroundColor = UIColor(named: "CustomGray")
        addSubview(lineView)
        let wholeLabel = UILabel(frame: CGRect(x: 24, y: lineView.frame.maxY + 32.5, width: 105, height: 20))
        wholeLabel.font = UIFont(name: "Montserratarm-Medium", size: 16)
        wholeLabel.text = "Ընդհանուր՝"
        addSubview(wholeLabel)
        let wholePriceLabel = UILabel(frame: CGRect(x: frame.width - 115, y: wholeLabel.frame.minY - 8.5, width: 90, height: 20))
        wholePriceLabel.textAlignment = .right
        wholePriceLabel.font = UIFont(name: "Montserratarm-Medium", size: 16)
        wholePriceLabel.text = "\(wholePrice) AMD"
        addSubview(wholePriceLabel)
        let receivableCoinsLabel = UILabel(frame: CGRect(x: frame.width - 137, y: wholeLabel.frame.maxY, width: 112, height: 13))
        receivableCoinsLabel.textAlignment = .right
        receivableCoinsLabel.font = UIFont(name: "Montserratarm-Regular", size: 11)
        receivableCoinsLabel.textColor = UIColor(named: "CustomDarkGray")
        receivableCoinsLabel.text = "Կստանաք \(receivableCoins) Bcoin"
        addSubview(receivableCoinsLabel)
        let switcher = UISwitch(frame: CGRect(x: 18, y: receivableCoinsLabel.frame.maxY + 24, width: 20, height: 20))
        switcher.onTintColor = UIColor(named: "CustomRed")
        switcher.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        addSubview(switcher)
        let saleLabel = UILabel(frame: CGRect(x: switcher.frame.maxX + 8, y: 0, width: 150, height: 16))
        saleLabel.center.y = switcher.center.y
        saleLabel.font = UIFont(name: "Montserratarm-Regular", size: 13)
        saleLabel.text = "10% զեղչ (1000 BCoin)"
        addSubview(saleLabel)
        let availabelCoinsLabel = UILabel(frame: CGRect(x: frame.width - 125, y: 0, width: 100, height: 13))
        availabelCoinsLabel.center.y = saleLabel.center.y
        availabelCoinsLabel.textAlignment = .right
        availabelCoinsLabel.font = UIFont(name: "Montserratarm-Regular", size: 11)
        availabelCoinsLabel.textColor = UIColor(named: "CustomDarkGray")
        availabelCoinsLabel.text = "Ունեք \(availabelCoins) BCoin"
        addSubview(availabelCoinsLabel)
        paymentMethodLabel.frame = CGRect(x: 24, y: saleLabel.frame.maxY + 24, width: 205, height: 16)
        paymentMethodLabel.font = UIFont(name: "Montserratarm-Regular", size: 13)
        paymentMethodLabel.text = "Վճարման տարբերակը"
        addSubview(paymentMethodLabel)
        paymentButton.frame = CGRect(x: frame.width - 98, y: 0, width: 73, height: 16)
        paymentButton.center.y = paymentMethodLabel.center.y
        paymentButton.setTitleColor(.black, for: .normal)
        paymentButton.setImage( UIImage(named: "blackDown"), for: .normal)
        paymentButton.setTitle("Կանխիկ", for: .normal)
        paymentButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -140)
        paymentButton.titleLabel!.font = UIFont(name: "Montserratarm-Regular", size: 13)
        paymentButton.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        addSubview(paymentButton)
        orderButton.frame = CGRect(x: 24, y: cardsTableView.frame.maxY, width: frame.width - 48, height: 55)
        orderButton.titleLabel!.font = UIFont(name: "Montserratarm-Medium", size: 14)
        orderButton.setTitle("Պատվիրել", for: .normal)
        orderButton.backgroundColor = UIColor(named: "CustomRed")
        orderButton.layer.cornerRadius = 4
        orderButton.addTarget(self, action: #selector(orderPressed), for: .touchUpInside)
    
        addSubview(orderButton)
    }
    
    func setupTextFields() {
        delegate?.addNewCard()
        sectionLabel.frame = CGRect(x: 24, y: cardsTableView.frame.maxY + 12, width: 200, height: 20)
        sectionLabel.font = UIFont(name: "Montserratarm-Medium", size: 16)
        sectionLabel.text = "Ավելացնել նոր քարտ"
        addSubview(sectionLabel)
        cardNumberTF.frame = CGRect(x: 24, y: sectionLabel.frame.maxY + 15, width: frame.width - 48, height: 58)
        setupTextFieldDesign(cardNumberTF, placeholder: "0000 - 0000 - 0000 - 0000")
        nameTF.frame = CGRect(x: 24, y: cardNumberTF.frame.maxY + 10, width: frame.width - 48, height: 58)
        setupTextFieldDesign(nameTF, placeholder: "NAME SURNAME")
        dateTF.frame = CGRect(x: 24, y: nameTF.frame.maxY + 10, width: (nameTF.frame.width / 2) - 4, height: 58)
        setupTextFieldDesign(dateTF, placeholder: "mm / yy")
        cvvTF.frame = CGRect(x: dateTF.frame.maxX + 8, y: dateTF.frame.origin.y, width: dateTF.frame.width, height: 58)
        setupTextFieldDesign(cvvTF, placeholder: "CVC/CVV")
        UIView.animate(withDuration: 0.5) {
            self.orderButton.frame = CGRect(x: 24, y: self.cvvTF.frame.maxY, width: self.frame.width - 48, height: 55)
        }
    }
    
    @objc func pressed() {
        if !isOnOnline {
            paymentButton.frame = CGRect(x: frame.width - 159, y: 0, width: 134, height: 16)
            paymentButton.center.y = paymentMethodLabel.center.y
            paymentButton.setTitle("Բանկային քարտ", for: .normal)
            paymentButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -265)
            delegate?.onlinePressed()
            UIView.animate(withDuration: 0.5) {
                self.cardsTableView.frame = CGRect(x: 24, y: self.paymentButton.frame.maxY + 24, width: self.frame.width - 48, height: 176)
                self.orderButton.frame = CGRect(x: 24, y: self.cardsTableView.frame.maxY, width: self.frame.width - 48, height: 55)
            }
            isOnOnline.toggle()
        } else {
            paymentButton.frame = CGRect(x: frame.width - 98, y: 0, width: 73, height: 16)
            paymentButton.center.y = paymentMethodLabel.center.y
            paymentButton.setTitle("Կանխիկ", for: .normal)
            paymentButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -140)
            paymentButton.titleLabel!.font = UIFont(name: "Montserratarm-Regular", size: 13)
            isOnOnline.toggle()
            delegate?.offlinePressed()
            UIView.animate(withDuration: 0.5) {
                self.cardsTableView.frame = CGRect(x: 24, y: self.paymentButton.frame.maxY + 24, width: self.frame.width - 48, height: 0)
                self.orderButton.frame = CGRect(x: 24, y: self.cardsTableView.frame.maxY, width: self.frame.width - 48, height: 55)
            }
            removeViews(view: sectionLabel)
            removeViews(view: cardNumberTF)
            removeViews(view: nameTF)
            removeViews(view: dateTF)
            removeViews(view: cvvTF)
        }
    }
    @objc func orderPressed() {
        delegate?.orderPressed()
    }
}

extension OrderFooterView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardTableViewCell", for: indexPath) as! CardTableViewCell
        cell.deleteButton.isHidden = true
        if indexPath.section == 2 {
            cell.cardTypeLabel.isHidden = true
            cell.cardNumberLabel.text = "Նոր քարտ"
            cell.cardLogoImageView.image = UIImage(named: "newCard")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 47
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: 0))
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 12
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? CardTableViewCell {
            cell.contentView.backgroundColor = UIColor(named: "CustomRed")
            cell.cardNumberLabel.textColor = .white
            cell.cardTypeLabel.textColor = UIColor(named: "CustomGray")
            if indexPath.section == 2 {
                setupTextFields()
            } else {
                UIView.animate(withDuration: 0.5) { [self] in
                    orderButton.frame = CGRect(x: 24, y: cardsTableView.frame.maxY + 12, width: frame.width - 48, height: 55)
                    removeViews(view: sectionLabel)
                    removeViews(view: cardNumberTF)
                    removeViews(view: nameTF)
                    removeViews(view: dateTF)
                    removeViews(view: cvvTF)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? CardTableViewCell {
            cell.contentView.backgroundColor = UIColor(named: "CustomGray")
            cell.cardTypeLabel.textColor = UIColor(named: "CustomDarkGray")
            cell.cardNumberLabel.textColor = .black
        }
    }
}
