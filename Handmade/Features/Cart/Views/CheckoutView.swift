////
////  CheckoutView.swift
////  Handmaden
////
////  Created by alfeng on 11/2/24.
////
//
//import SwiftUI
//import UIKit
//import Stripe
//
//class CheckoutCoordinator: NSObject, STPAuthenticationContext {
//    // Provide the required UIViewController for Stripe authentication
//    func authenticationPresentingViewController() -> UIViewController {
//        // Return the top-most view controller (or root view controller)
//        return UIApplication.shared.windows.first?.rootViewController ?? UIViewController()
//    }
//}
//
//struct CheckoutView: View, STPAuthenticationContext {
//    @EnvironmentObject private var viewModel: AuthViewModel
//    @EnvironmentObject var productViewModel: ProductViewModel
//    @EnvironmentObject private var cartViewModel: CartViewModel
//    @EnvironmentObject var savedViewModel: SavedViewModel
//
//    private let checkoutCoordinator = CheckoutCoordinator()
//
//    var body: some View {
//        VStack {
//            Text("Total: \(cartViewModel.totalCost, specifier: "%.2f")")
//                .font(.title)
//
//            Button(action: {
//                Task {
//                    await cartViewModel.startCheckout()
//                    if let clientSecret = cartViewModel.clientSecret {
//                        handlePayment(clientSecret: clientSecret)
//                    }
//                }
//            }) {
//                Text("Pay Now")
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//        }
//        .padding()
//    }
//    
//    func handlePayment(clientSecret: String) {
//        let paymentIntentParams = STPPaymentIntentParams(clientSecret: clientSecret)
//        
//        STPPaymentHandler.shared().confirmPayment(paymentIntentParams, with: checkoutCoordinator) { status, _, error in
//            switch status {
//            case .succeeded:
//                print("Payment successful!")
//                // Handle successful payment, clear cart, etc.
//            case .failed:
//                print("Payment failed: \(String(describing: error?.localizedDescription))")
//            case .canceled:
//                print("Payment canceled.")
//            @unknown default:
//                fatalError()
//            }
//        }
//    }
//}
//
//#Preview {
//    CheckoutView()
//        .environmentObject(AuthViewModel())
//        .environmentObject(ProductViewModel())
//        .environmentObject(CartViewModel())
//        .environmentObject(SavedViewModel())
//}
