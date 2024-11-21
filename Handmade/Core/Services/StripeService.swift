//
//  StripeService.swift
//  Handmaden
//
//  Created by alfeng on 11/2/24.
//

import Foundation

class StripeService {
    static let shared = StripeService()
    
    // Endpoint for creating payment intent
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

// Define a struct for the payment response
struct PaymentIntentResponse: Codable {
    let clientSecret: String
}
