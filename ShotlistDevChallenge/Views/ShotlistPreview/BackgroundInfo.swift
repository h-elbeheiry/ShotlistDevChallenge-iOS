//
//  ShotlistBackgroundInfo.swift
//  Shotlist
//
//  Created by Daniel Ashy on 9/28/20.
//  Copyright © 2020 Daniel Ashy. All rights reserved.
//

import SwiftUI

struct BackgroundInfo: View {
  @Binding var description: String
  
  var body: some View {
    VStack(spacing: 8) {
      HStack {
        Text("Background")
          .font(.custom("Avenir-Heavy", size: 20))
          .foregroundColor(contentPrimary)
        Spacer()
      }
      
      // MARK: TODO edit this description box
        if #available(iOS 14.0, *) {
            TextEditor(text: $description)
                .font(.custom("Avenir-Roman", size: 14))
                .foregroundColor(contentPrimary)
        } else {
            // Fallback on earlier versions
            TextField(description, text: $description)
                .font(.custom("Avenir-Roman", size: 14))
                .foregroundColor(contentPrimary)
        }
    }
  }
}
