//
//  SignUpView.swift
//  Handmaden
//
//  Created by alfeng on 11/2/24.
//

import SwiftUI

import SwiftUI

struct SignUpView: View {
    @State private var email = ""
    @State private var fullName = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    @Binding var isSignedIn: Bool
    
    var body: some View {
        VStack {
            Text("Sign Up")
                .font(.largeTitle).bold()
                .foregroundStyle(Color(red: 75/255, green: 156/255, blue: 211/255))
                .padding(10)
            Text("Start shopping for handmade creations from UNC students today!")
                .multilineTextAlignment(.center)
                .foregroundStyle(Color(.systemGray))
                .padding(.horizontal, 40)
                .padding(.bottom, 10)
            VStack {
                VStack {
                    InputView(text: $email,
                              title: "Email Address",
                              placeHolder: "name@example.com")
                    .textInputAutocapitalization(.never)
                    if !validEmail && !email.isEmpty{
                        HStack {
                            Text("Please enter a valid email")
                                .font(.custom("error", size: 10.0))
                                .foregroundStyle(Color(.systemGray))
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 10, height: 10)
                                .foregroundStyle(Color(.systemRed))
                            Spacer()
                        }
                    }
                }
                .padding(.bottom, 24)
                
                VStack {
                    InputView(text: $fullName,
                              title: "Name",
                              placeHolder: "Your Name")
                    .textInputAutocapitalization(.none)
                    
                    if !validName && !fullName.isEmpty{
                        HStack {
                            Text("Please enter at least 3 characters")
                                .font(.custom("error", size: 10.0))
                                .foregroundStyle(Color(.systemGray))
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 10, height: 10)
                                .foregroundStyle(Color(.systemRed))
                            Spacer()
                        }
                    }
                }
                .padding(.bottom, 24)
                
                VStack {
                    InputView(text: $password,
                              title: "Password",
                              placeHolder: "Enter your password")
                    
                    if !validPassword && !password.isEmpty{
                        HStack {
                            Text("Please enter at least 8 characters")
                                .font(.custom("error", size: 10.0))
                                .foregroundStyle(Color(.systemGray))
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 10, height: 10)
                                .foregroundStyle(Color(.systemRed))
                            Spacer()
                        }
                    }
                }
                .padding(.bottom, 24)
                
                InputView(text: $confirmPassword,
                          title: "Confirm Password",
                          placeHolder: "Re-enter your password",
                          isSecureField: true)
                
                if password != confirmPassword && !confirmPassword.isEmpty{
                    HStack {
                        Text("Passwords do not match")
                            .font(.custom("error", size: 10.0))
                            .foregroundStyle(Color(.systemGray))
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 10, height: 10)
                            .foregroundStyle(Color(.systemRed))
                        Spacer()
                    }
                }
                
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            Button {
                Task {
                    try await viewModel.createUser(withEmail: email,
                                                   password: password,
                                                   fullName: fullName)
                }
            } label: {
                HStack {
                    Text("SIGN UP")
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
            
            Button {
                dismiss()
            } label: {
                HStack {
                    Text("Already have an account?")
                    Text("Sign in ")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
            }
        }
    }
}

extension SignUpView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return validEmail && validName && validPassword && password == confirmPassword
    }
    
    var validEmail: Bool {
        return !email.isEmpty && email.contains("@")
        && (email.contains(".com") || email.contains(".edu") || email.contains(".org") || email.contains(".net"))
    }
    
    var validName: Bool {
        return !fullName.isEmpty && fullName.count > 3
    }
    
    var validPassword: Bool {
        return !password.isEmpty
        && password.count > 7
    }
}

#Preview {
    SignUpView(isSignedIn: .constant(true))
}
