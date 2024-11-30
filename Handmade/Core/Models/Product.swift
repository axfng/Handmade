import Foundation

struct Review: Codable {
    let rating: Double
    let comment: String
    let date: String
    let reviewerName: String
    let reviewerEmail: String
    
    var dateObject: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter.date(from: date)
    }
    var formattedDate: String {
        if let date = dateObject {
            return date.formatted(date: .abbreviated, time: .omitted)
        } else {
            return "N/A"
        }
    }

    enum CodingKeys: String, CodingKey {
        case rating, comment, date, reviewerName, reviewerEmail
    }
}

struct Product: Identifiable, Codable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let rating: Double
    let thumbnail: String
    let tags: [String]
    let reviews: [Review]
    
    var formattedRating: String {
        String(format: "%.2f", rating)
    }
    var formattedPrice: String {
        String(format: "%.2f", price)
    }
    
    var isLiked: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, price, rating, thumbnail, reviews, tags
    }
}
