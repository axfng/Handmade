//
//  LoginView.swift
//  Handmaden
//
//  Created by alfeng on 11/2/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    @Binding var isSignedIn: Bool
    
    var body: some View {
        NavigationStack {
            Text("Welcome Back")
                .font(.largeTitle).bold()
                .foregroundStyle(Color(red: 75/255, green: 156/255, blue: 211/255))
                .padding(10)
            Text("Enter your credentials to log in")
                .multilineTextAlignment(.center)
                .foregroundStyle(Color(.systemGray))
                .padding(.horizontal, 40)
                .padding(.bottom, 10)
            
            VStack(spacing: 24) {
                InputView(text: $email,
                          title: "Email Address",
                          placeHolder: "name@example.com")
                .textInputAutocapitalization(.never)
                
                InputView(text: $password,
                          title: "Password",
                          placeHolder: "Enter your password",
                          isSecureField: true)
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            Button {
                Task {
                    try await viewModel.signIn(withEmail: email, password: password)
                    isSignedIn = true
                }
            } label: {
                HStack {
                    Text("SIGN IN")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }
                .foregroundStyle(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            }
            .background(Color(.systemBlue))
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.5)
            .clipShape(.rect(cornerRadius: 10))
            .padding(.top, 24)
            
            Spacer()
            
            NavigationLink {
                SignUpView(isSignedIn: $isSignedIn)
                    .navigationBarBackButtonHidden(true)
            } label: {
                HStack {
                    Text("Don't have an account?")
                    Text("Sign up")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
            }
        }
    }
}

extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && (email.contains(".com") || email.contains(".edu") || email.contains(".org") || email.contains(".net"))
        && !password.isEmpty
        && password.count > 7
    }
}

#Preview {
    LoginView(isSignedIn: .constant(true))
}
