//
//  Validation.swift
//  Saturday
//
//  Created by Titus Lowe on 27/7/22.
//

import Foundation
import Firebase

enum AuthError: LocalizedError {
    case invalidName
    case invalidUsername
    case invalidEmail
    case invalidPassword1
    case invalidPassword2
    case invalidLogin
    
    var errorDescription: String? {
        switch self {
        case .invalidName:
            return "Invalid Name Format"
        case .invalidUsername:
            return "Invalid Username Format"
        case .invalidEmail:
            return "Invalid Email Format"
        case .invalidPassword1:
            return "Password needs at least 6 characters"
        case .invalidPassword2:
            return "Passwords do not match"
        case .invalidLogin:
            return "Enter an email and password"
        }
    }
}

func isValidName(_ name: String) throws {
    if name == "" {
        throw AuthError.invalidName
    }
}

func isValidUsername(_ username: String) throws {
    if username == "" {
        throw AuthError.invalidUsername
    }
}

func isValidEmail(_ email: String) throws {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    if !emailPred.evaluate(with: email) {
        throw AuthError.invalidEmail
    }
}

func isValidPassword1(_ password: String) throws {
    if password.count < 6 {
        throw AuthError.invalidPassword1
    }
}

func isValidPassword2(_ password: String, _ password2: String) throws {
    if password != password2 {
        throw AuthError.invalidPassword2
    }
}

func isValidLogin(_ email: String, _ password: String) throws {
    if email == "" || password == "" {
        throw AuthError.invalidLogin
    }
}

func isValidForm(email: String, name: String) {
    do {
        try isValidEmail(email)
    } catch {
        print(error.localizedDescription)
    }
}
