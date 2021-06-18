
import Foundation

class ValidationError: Error {
    var message: String
    
    init(_ message: String) {
        self.message = message
    }
}

protocol ValidatorConvertible {
    func validated(_ value: String) throws -> String
}

enum ValidatorType {
    case email
    case phoneNumber
    case name(field: String)
    case requiredField(field: String)
    case age
}

enum ValidatorFactory {
    static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
        switch type {
        case .email: return EmailValidator()
        case .requiredField(let fieldName): return RequiredFieldValidator(fieldName)
        case .age: return AgeValidator()
        case .phoneNumber: return PhoneNumberValidator()
        case .name(let fieldName): return NameValidator(fieldName)
        }
    }
}

class AgeValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count > 0 else {throw ValidationError("Age is required")}
        guard let age = Int(value) else {throw ValidationError("Age must be a number!")}
        guard value.count < 3 else {throw ValidationError("Invalid age number!")}
        guard age >= 18 else {throw ValidationError("You have to be over 12 years old")}
        return value
    }
}


struct NameValidator: ValidatorConvertible {
    
    private let fieldName: String
    
    init(_ field: String) {
        fieldName = field
    }
    
    func validated(_ value: String) throws -> String {
        do {
            if try NSRegularExpression(pattern: "^[a-z]{2,20}$",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError(fieldName + " field should not contain whitespaces, numbers or special characters")
            }
        } catch {
            throw ValidationError(fieldName + " field should not contain whitespaces, or special characters")
        }
        return value
    }
}

struct RequiredFieldValidator: ValidatorConvertible {
    private let fieldName: String
    
    init(_ field: String) {
        fieldName = field
    }
    
    func validated(_ value: String) throws -> String {
        guard !value.isEmpty else {
            throw ValidationError(fieldName + " can't be empty")
        }
        return value
    }
}

struct EmailValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        do {
            if try NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid e-mail Address")
            }
        } catch {
            throw ValidationError("Invalid e-mail Address")
        }
        return value
    }
}


struct PhoneNumberValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        do {
            if try NSRegularExpression(pattern: "^[+]{1}[0-9]{8,15}$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid phone number")
            }
        } catch {
            throw ValidationError("Invalid phone number")
        }
        return value
    }
}
