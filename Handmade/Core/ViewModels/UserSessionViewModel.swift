//
//  UserSessionViewModel.swift
//  Handmaden
//
//  Created by alfeng on 11/2/24.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class UserSessionViewModel: ObservableObject {
//    @Published var currentUser: User?
//    @Published var isLoggedIn: Bool = false
//    private var authViewModel: AuthViewModel
//    
//    init(authViewModel: AuthViewModel) {
//        self.authViewModel = authViewModel
//        setupAuthStateObserver()
//    }
//    
//    private func setupAuthStateObserver() {
//            // Observe the `userSession` in AuthViewModel
//            authViewModel.$userSession
//                .sink { [weak self] userSession in
//                    guard let self = self else { return }
//                    
//                    if let userSession = userSession {
//                        Task {
//                            // User is signed in, fetch user data
//                            await self.loadUserData(for: userSession.uid)
//                            self.isLoggedIn = true
//                        }
//                    } else {
//                        // User is signed out, clear current user data
//                        self.currentUser = nil
//                        self.isLoggedIn = false
//                    }
//                }
//                .store(in: &cancellables)
//        }
//        
//        func loadUserData(for uid: String) async {
//            let db = Firestore.firestore()
//            let userRef = db.collection("users").document(uid)
//            
//            do {
//                let document = try await userRef.getDocument()
//                if let userData = try document.data(as: User.self) {
//                    self.currentUser = userData
//                }
//            } catch {
//                print("DEBUG: Failed to load user data \(error.localizedDescription)")
//            }
//        }
//        
//        func updateUserInDatabase() async {
//            guard let currentUser = currentUser else { return }
//            
//            let db = Firestore.firestore()
//            let userRef = db.collection("users").document(currentUser.id)
//            
//            do {
//                try await userRef.setData(from: currentUser, merge: true)
//            } catch {
//                print("DEBUG: Failed to update user data \(error.localizedDescription)")
//            }
//        }
}
