//
//  FiltersViewController.swift
//  TestProject
//
//  Created by Muhammad Waqas Bhati on 3/6/18.
//  Copyright © 2018 Emaar . All rights reserved.
//

import UIKit

protocol FilterViewDelegate: class {
    func applyFilter(minYear: Int, maxYear: Int)
    func resetFilter()
}

enum FieldNum: Int {
    case minYear = 1
    case maxYear
}

class FiltersViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet weak var textFieldMinYear: BindingTextField!
    @IBOutlet weak var textFieldMaxYear: BindingTextField!
    
    weak var delegate: FilterViewDelegate?
    var filterVM: FilterViewModel? {
        didSet {
            binder()
        }
    }
    private var currentFocus: FieldNum = .minYear
    private var selectedMinYear = 0
    private var selectedMaxYear = 0
    
    lazy var yearsTillNow : [String] = {
        var years = [String]()
        for i in (1970..<2018).reversed() {
            years.append("\(i)")
        }
        return years
    }()
    
    lazy var picker: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        return pickerView
    }()
    
    lazy var toolBar: UIToolbar = {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolBar.tintColor = UIColor.black
        toolBar.backgroundColor = UIColor.lightGray
        let cancelButton = UIBarButtonItem(title: Constant.Alert.cancel, style: UIBarButtonItemStyle.plain, target: self, action: #selector(cancelPressed(sender:)))
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(donePressed(sender:)))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        toolBar.setItems([cancelButton,flexSpace, doneButton], animated: true)
        return toolBar
    }()
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addPicker()
    }
    func binder() {
        filterVM?.minYear.bind = { [unowned self] in
            self.textFieldMinYear.text = $0
        }
        filterVM?.maxYear.bind = { [unowned self] in
            self.textFieldMaxYear.text = $0
        }

    }
    // MARK: - IBActions

    @IBAction func resetBtnPressed(_ sender: Any) {
        delegate?.resetFilter()
        navigationController?.popViewController(animated: true)
    }
    @IBAction func cancelBtnPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func resultBtnPressed(_ sender: Any) {
        if verifySelection() {
            if selectedMinYear > selectedMaxYear {
                self.showAlertInViewController(titleStr: Constant.Alert.ok, messageStr: Constant.Alert.message, okButtonTitle: Constant.Alert.ok)
                return
            }
            delegate?.applyFilter(minYear: selectedMinYear, maxYear: selectedMaxYear)
        }
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helper Methods

    func addPicker() {
        
        textFieldMinYear.inputView = picker
        textFieldMaxYear.inputView = picker
        textFieldMinYear.inputAccessoryView = toolBar
        textFieldMaxYear.inputAccessoryView = toolBar
        
    }
    func verifySelection() -> Bool {
        if (filterVM?.minYear.value != nil && filterVM?.minYear.value != "") && (filterVM?.maxYear.value != nil  && filterVM?.maxYear.value != "") {
            selectedMinYear = Int(filterVM?.minYear.value ?? "") ?? 0
            selectedMaxYear = Int(filterVM?.maxYear.value ?? "") ?? 0
            return true
        }
        return false
    }
    @objc func donePressed(sender: UIBarButtonItem) {
        if verifySelection() {
            if selectedMinYear > selectedMaxYear {
                self.showAlertInViewController(titleStr: Constant.Alert.ok, messageStr: Constant.Alert.message, okButtonTitle: Constant.Alert.ok)
            }
        }
        view.endEditing(true)
    }
    @objc func cancelPressed(sender: UIBarButtonItem) {
        view.endEditing(true)
    }
}

extension FiltersViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    // MARK: - UIPickerView Delegate & DataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return yearsTillNow.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return yearsTillNow[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            filterVM?.minYear.value = yearsTillNow[row]
        } else if pickerView.tag == 2 {
            filterVM?.maxYear.value = yearsTillNow[row]
        }
        
    }
    
}

extension FiltersViewController: UITextFieldDelegate {
    
    // MARK: - UITextField Delegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        picker.tag = textField.tag
        if let mValue = FieldNum(rawValue: picker.tag) {
            currentFocus = mValue
        }
    }
    
}

