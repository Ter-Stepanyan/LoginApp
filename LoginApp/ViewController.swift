//
//  ViewController.swift
//  LoginApp
//
//  Created by Artak Ter-Stepanyan on 25.01.24.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerLabel: UILabel!
    @IBOutlet weak var loginImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        loginLabel.font = UIFont.boldSystemFont(ofSize: loginLabel.font.pointSize)
        passwordTextField.textContentType = .password
        emailTextField.textContentType = .emailAddress
        addUnderline(to: passwordTextField)
        addUnderline(to: emailTextField)
        loginButton.isEnabled = false
        loginButton.setTitleColor(.lightGray, for: .disabled)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 8

        emailTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        let attributedText = NSMutableAttributedString(string: "Don't have an account yet? Register")
        let range = (attributedText.string as NSString).range(of: "Register")

        attributedText.addAttribute(.foregroundColor, value: UIColor.black, range: range)
        attributedText.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)

        registerLabel.attributedText = attributedText

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(registerLabelTapped))
        registerLabel.isUserInteractionEnabled = true
        registerLabel.addGestureRecognizer(tapGesture)
        configureLoginButton()
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        if let emailText = emailTextField.text, let passwordText = passwordTextField.text,
            !emailText.isEmpty, !passwordText.isEmpty {
            loginButton.isEnabled = true
        } else {
            loginButton.isEnabled = false
        }
        configureLoginButton()
    }

    @objc func registerLabelTapped() {
            print("Register label tapped!")
    }

    @IBAction func loginButtonTapped(_ sender: Any) {
        print("Login button tapped")
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }

    func configureLoginButton() {
        loginButton.backgroundColor = loginButton.isEnabled ? UIColor.darkGray : UIColor.gray
        }

    func addUnderline(to textField: UITextField) {
        let border = CALayer()
        let borderWidth = CGFloat(1.0)

        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(
        x: 0,
        y: textField.frame.size.height - borderWidth,
        width: textField.frame.size.width,
        height: textField.frame.size.height
        )

        border.borderWidth = borderWidth
        textField.layer.addSublayer(border)
        textField.layer.masksToBounds = true
    }
}
