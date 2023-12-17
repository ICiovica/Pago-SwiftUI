//
//  DetailInputView.swift
//  Pago-SwiftUI
//
//  Created by IonutCiovica on 15/12/2023.
//

import SwiftUI

struct DetailInputView: View {
    @FocusState private var isFocused
    @State private var input: String = ""
    @State private var invalidInput = false
    @Binding var newUser: NewUserModel
    let detail: UserDetail
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                detailTitleVw
                textFieldVw
                rectangleVw
            }
            .transaction { transaction in
                transaction.animation = nil
            }
            if invalidInput {
                alertVw
            }
        }
        .onTapGesture { isFocused.toggle() }
    }
}

// MARK: - Views
private extension DetailInputView {
    var detailTitleVw: some View {
        Text(detail.rawValue)
            .font(.system(.callout, design: .rounded, weight: .semibold))
    }
    
    var textFieldVw: some View {
        TextField("", text: $input)
            .focused($isFocused)
            .onChange(of: input, perform: inputChanged(_:))
    }
    
    var rectangleVw: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(Color.rectangleBackground)
    }
    
    var alertVw: some View {
        HStack {
            Text(detail.alertDescription)
            Spacer()
        }
        .transition(.move(edge: .bottom))
    }
}

// MARK: Methods
private extension DetailInputView {
    func inputChanged(_ input: String) {
        switch detail {
        case .firstName:
            newUser.firstName = input
        case .lastName:
            newUser.lastName = input
        case .email:
            newUser.email = input
        case .phone:
            newUser.phone = input
        }
        withAnimation(.easeOut(duration: 0.25)) {
            invalidInput = newUser.invalidDetail(detail)
        }
    }
}

#Preview {
    DetailInputView(newUser: .constant(.init()), detail: .firstName)
}
