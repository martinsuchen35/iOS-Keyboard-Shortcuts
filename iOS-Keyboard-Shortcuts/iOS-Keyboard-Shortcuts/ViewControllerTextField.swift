//
//  ViewController.swift
//  iOS-Keyboard-Shortcuts
//
//  Created by Chen Su on 3/30/18.
//  Copyright © 2018 Chen Su. All rights reserved.
//

import UIKit

class ViewControllerTextField: UIViewController {

    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Disable the auto correction in the middle of the keyboard assistant row
        textField.autocorrectionType = .no

        configKeyboardShortcuts()
    }

    func configKeyboardShortcuts() {
        textField.inputAssistantItem.leadingBarButtonGroups = []
        textField.inputAssistantItem.trailingBarButtonGroups = []

        let buttonLeading1: UIBarButtonItem = UIBarButtonItem(title: "Button L1", style: .plain, target: self, action: #selector(customButtonPressed))

        let buttonLeading2: UIBarButtonItem = UIBarButtonItem(title: "Button L2", style: .plain, target: self, action: #selector(customButtonPressed))
        buttonLeading2.image = UIImage(named: "Alert")!.withRenderingMode(.alwaysOriginal)

        let buttonTrailing1: UIBarButtonItem = UIBarButtonItem(title: "Button T1", style: .plain, target: self, action: #selector(customButtonPressed))


        let groupLeading: UIBarButtonItemGroup = UIBarButtonItemGroup.init(barButtonItems: [buttonLeading1, buttonLeading2], representativeItem: nil)
        let groupTrailing: UIBarButtonItemGroup = UIBarButtonItemGroup.init(barButtonItems: [buttonTrailing1], representativeItem: nil)

        textField.inputAssistantItem.leadingBarButtonGroups.append(groupLeading)
        textField.inputAssistantItem.trailingBarButtonGroups.append(groupTrailing)
    }

    @objc func customButtonPressed() {
        print("button pressed!")
    }

}

