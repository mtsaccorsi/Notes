//
//  RegisterView.swift
//  Notas
//
//  Created by Matheus Accorsi on 10/11/23.
//

import SwiftUI
import FirebaseAuth

struct RegisterView: View {
    
    @State var email = ""
    @State var password = ""
    @State var passwordConfirmation = ""
    @State var goNotes = false
    @State var isPresentedAlert = false
    @State var errorMessage = ""
    
    var disabledButton: Bool {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPasswordConfirmation = passwordConfirmation.trimmingCharacters(in: .whitespacesAndNewlines)
        
        return trimmedEmail.isEmpty ||
        trimmedPassword.isEmpty ||
        trimmedPasswordConfirmation.isEmpty
        //        || trimmedPassword != trimmedPasswordConfirmation
    }
    
    var body: some View {
        ZStack {
            Color.backgroundColor.ignoresSafeArea()
            
            VStack(spacing: 25.0) {
                Text("Register")
                    .font(.system(size: 55, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.top, 5)
                    .padding(.bottom, 50)
                
                //                    Spacer()
                //                        .frame(height: 20)
                
                Group {
                    TextField("", text: $email, prompt: Text("E-mail").foregroundStyle(.white))
                        .keyboardType(.emailAddress)
                    
                    SecureField("", text: $password, prompt: Text("Password").foregroundStyle(.white))
                    SecureField("", text: $passwordConfirmation, prompt: Text("Confirm password").foregroundStyle(.white))
                }
                .frame(height: 40)
                .padding(7)
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 8).stroke(Color.pinkColor, lineWidth: 2)
                })
                .padding(7)
                .foregroundStyle(.white)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                
                Spacer()
                
                Button {
                    registerUser()
                } label: {
                    Text("Register")
                        .frame(maxWidth: .infinity)
                        .frame(height: 45)
                        .foregroundStyle(.white)
                        .font(.system(size: 18, weight: .bold))
                        .background(Color.pinkColor)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .opacity(disabledButton ? 0.5 : 1)
                }
                .disabled(disabledButton)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 50)
        }
        .alert("Attention!", isPresented: $isPresentedAlert, actions: {
            Button("OK", role: .cancel) {}
        }, message: {
            Text(errorMessage)
        })
        .navigationDestination(isPresented: $goNotes) {
            NotesView()
        }
    }
    
    private func registerUser() {
        
        if password == passwordConfirmation {
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let error {
                    errorMessage = error.localizedDescription
                } else {
                    goNotes.toggle()
                }
            }
            
        } else {
            errorMessage = "Check password and confirm password and then try again"
            isPresentedAlert.toggle()
        }
    }
}

#Preview {
    NavigationStack{
        RegisterView()
    }
}
