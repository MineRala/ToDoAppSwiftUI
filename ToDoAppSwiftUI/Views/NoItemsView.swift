//
//  NoItemsView.swift
//  ToDoAppSwiftUI
//
//  Created by Mine Rala on 12.02.2024.
//

import SwiftUI

protocol NoItemViewDelegate {
    func addButtonTapped()
}

struct NoItemsView: View {
    @State private var animate = false
    var delegate: NoItemViewDelegate?
    
    var body: some View {
        ScrollView {
            VStack {
                Text("There are no items!")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer(minLength: 10)
                Text("Are you a productive person? I think you should click the add button and a bunch of to your todo list!")
                    .padding(.bottom, 20)
                Button {
                    delegate?.addButtonTapped()
                } label: {
                    Text("Add Something")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(animate ? Color.secondaryAccentColor : Color.accentColor)
                        .cornerRadius(10)
                }
                .padding(.horizontal, animate ? 30 : 50)
                .shadow(
                    color: animate ? Color.secondaryAccentColor.opacity(0.7) : Color.accentColor.opacity(0.7),
                    radius: animate ? 30: 10,
                    x: 0,
                    y: animate ? 50 : 30)
                .scaleEffect(animate ? 1.1 : 1.0)
                .offset(y: animate ? -7 : 0)
            }
            .multilineTextAlignment(.center)
            .padding(40)
            .onAppear(perform: addAnimation)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func addAnimation() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                animate.toggle()
            }
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationView{
        NoItemsView()
            .navigationTitle("Title")
    }
}
