import Foundation

class StripeService {
    static let shared = StripeService()
    
    let baseURL = "https://glitch.com/edit/#!/flicker-chocolate-polish?path=server.js%3A7%3A0"

    func createPaymentIntent(amount: Int, currency: String = "usd") async throws -> String {
        guard let url = URL(string: baseURL) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "amount": amount,
            "currency": currency
        ]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(PaymentIntentResponse.self, from: data)
        
        return response.clientSecret
    }
}

struct PaymentIntentResponse: Codable {
    let clientSecret: String
}
