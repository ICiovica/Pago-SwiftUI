//
//  InputDetailView.swift
//  Pago-SwiftUI
//
//  Created by IonutCiovica on 15/12/2023.
//

import SwiftUI

struct InputDetailView: View {
    @FocusState private var isFocused
    @State private var input: String = ""
    @State private var invalidInput = false
    @Binding var user: UserDetailsModel
    let detail: UserDetail
    
    var placeHolder: String {
        switch detail {
        case .firstName:
            return user.firstName
        case .lastName:
            return user.lastName
        case .phone:
            return user.phone
        case .email:
            return user.email
        }
    }
    
    var body: some View {
        Section {
            VStack(alignment: .leading) {
                detailTitleVw
                textFieldVw
                rectangleVw
                if invalidInput {
                    alertVw
                }
            }
        }
        .onTapGesture { isFocused.toggle() }
    }
}

// MARK: - Views
private extension InputDetailView {
    var detailTitleVw: some View {
        Text(detail.rawValue)
            .font(.system(.callout, design: .rounded, weight: .semibold))
    }
    
    var textFieldVw: some View {
        TextField(placeHolder, text: $input)
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
private extension InputDetailView {
    func inputChanged(_ input: String) {
        switch detail {
        case .firstName:
            user.firstName = input
        case .lastName:
            user.lastName = input
        case .email:
            user.email = input
        case .phone:
            user.phone = input
        }
        invalidInput = user.invalidDetail(detail)
    }
}

#Preview {
    InputDetailView(user: .constant(.init()), detail: .firstName)
}
