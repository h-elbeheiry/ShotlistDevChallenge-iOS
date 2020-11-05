//
//  CreatorOnboardView.swift
//  UserAuth
//
//  Created by Daniel Ashy on 8/12/20.
//  Copyright © 2020 ashy. All rights reserved.
//

import SwiftUI

struct StateBar: View {
  var states: [String]
  var current: String
  
  var dotSize: CGFloat = 15
  var checkSize: CGFloat = 8
  
  init(states: [String], current: String) {
    self.states = states
    self.current = current
  }
  
  private func isComplete(_ index: Int) -> Bool {
    return self.states.firstIndex(of: self.current)! > index
  }
  
  // MARK: TODO add a line between each dot that is responsive to both screen size and dot count.
  var body: some View {
    HStack(spacing: 0) {
      ForEach(states.indices) { i in
        Group {
          VStack(spacing: 2) {
            StateBubble(
              current: self.current,
              state: self.states[i],
              completed: self.isComplete(i)
            )
            Text(self.states[i])
              .font(.custom("Avenir-Heavy", size: 12))
              .foregroundColor(contentPrimary)
              .fixedSize()
          }.frame(width: 15)
          
          if (i < (self.states.count - 1)) {
            // MARK: Changed the Spacer() to VStacker with a Divider()
            VStack{
                Divider().padding(.bottom, 18)
            }
          }
        }
      }
    }
  }
}

struct StateBubble: View {
  var current: String
  var state: String
  var completed: Bool
  
  var dotSize: CGFloat = 15
  var checkSize: CGFloat = 6
  
  var body: some View {
    ZStack {
      Circle()
        .frame(width: dotSize, height: dotSize)
        .foregroundColor(current == state
          ? foundationAccent
          : (completed ? contentTertiary : borderGray))
        .overlay(
          Image(systemName: "checkmark")
            .resizable()
            .frame(width: checkSize, height: checkSize)
            .foregroundColor(.white)
            .opacity(completed ? 1 : 0)
      )
    }.frame(width: dotSize, height: dotSize, alignment: .center)
  }
}

struct CreatorOnboardingStateBar_Previews: PreviewProvider {
  static var previews: some View {
    StateBar(
      states: [ "Concept", "Scheduled", "Editing", "Complete" ],
      current: "Editing"
    )
  }
}
