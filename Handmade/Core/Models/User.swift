import Foundation

struct User: Identifiable, Codable {
    let id: String
    let fullName: String
    let email: String
    var likedItems: [Int]
    var cartItems: [Int]
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullName) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}

extension User {
    static var mockUser = User(id: NSUUID().uuidString, fullName: "Alex Feng", email: "alexlfeng22@gmail.com", likedItems: [], cartItems: [])
}
