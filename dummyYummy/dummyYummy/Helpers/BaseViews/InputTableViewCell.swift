//
//  BaseInputTableViewCell.swift
//  dummyYummy
//
//  Created by badyi on 11.07.2021.
//

import UIKit

protocol InputCellDelegate: AnyObject {
    func insertText(_ text: String, didFinishUpdate: ((Int) -> Void)?)
    func deleteBackwards( didFinishUpdate: ((Int) -> Void)?)
    func doneButtonTapped()
}

class InputTableViewCell: UITableViewCell {
    override var inputAccessoryView: UIView? {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
                                        target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done,
                                                    target: self, action: #selector(doneTapped))

        var items: [UIBarButtonItem] = []
        items.append(flexSpace)
        items.append(done)

        doneToolbar.items = items
        doneToolbar.sizeToFit()
        return doneToolbar
    }

    weak var inputDelegate: InputCellDelegate?
    var keyboardType: UIKeyboardType = .numberPad
    var isUsingKeyBoard: Bool = false

    /// kinda virtual funcs
    func update(using data: Int) {}
    func stylize() {}
    func setupTextFiled() {}
}

extension InputTableViewCell {
    @objc private func doneTapped() {
        inputDelegate?.doneButtonTapped()
    }
}

extension InputTableViewCell: UIKeyInput {
    // MARK: Input Related Extensions
    var hasText: Bool {
        return true
    }

    override var canBecomeFirstResponder: Bool { return isUsingKeyBoard }

    @discardableResult
    override func becomeFirstResponder() -> Bool {
        let becameFirstResponder = super.becomeFirstResponder()
        stylize()
        return becameFirstResponder
    }

    @discardableResult
    override func resignFirstResponder() -> Bool {
        let resignedFirstResponder = super.resignFirstResponder()
        stylize()
        return resignedFirstResponder
    }

    func insertText(_ text: String) {
        inputDelegate?.insertText(text, didFinishUpdate: self.update(using:))
    }

    func deleteBackward() {
        inputDelegate?.deleteBackwards(didFinishUpdate: self.update(using:))
    }
}
