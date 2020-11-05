//
//  ShootPreview.swift
//  Shotlist
//
//  Created by Daniel Ashy on 9/28/20.
//  Copyright © 2020 Daniel Ashy. All rights reserved.
//

import SwiftUI


struct ShootPreview: View {
    var shoot: Shoot = Shoot.sample
    @State private var description: String = Shoot.sample.description
    
    // MARK: For Sticky Header View
    @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    @State var showStickyHeader = false
    
    var body: some View {
        ZStack(alignment: .top, content: {
            ScrollView(showsIndicators: false) {
                // MARK: Adding geometry reader for the "Sticky Header"
                GeometryReader {g in
                    ShotlistHeader(shoot: shoot).zIndex(40)
                        .offset(y: g.frame(in: .global).minY > 0 ? -g.frame(in: .global).minY : 0)
                        .frame(height: g.frame(in: .global).minY > 0 ? UIScreen.main.bounds.height / 2.2 + g.frame(in: .global).minY  : UIScreen.main.bounds.height / 2.2)
                        .onReceive(self.time) { (_) in
                            // For tracking the image is scrolled out or not
                            // print(g.frame(in: .global).minY)
                            
                            let y = g.frame(in: .global).minY
                            if -y > (UIScreen.main.bounds.height / 2.2) - 50 {
                                withAnimation{
                                    self.showStickyHeader = true
                                }
                            }else {
                                withAnimation{
                                    self.showStickyHeader = false
                                }
                            }
                        }
                    
                }
                .frame(height: UIScreen.main.bounds.height / 2.2)
                
                Group {
                    ShotlistStatusBar()
                        .padding(.horizontal, 38)
                    BackgroundInfo(description: $description)
                    Options()
                    ShotlistRequiredShots()
                    ShotlistLocations()
                    TasksPreview()
                    ShotlistTeamChat()
                }.padding(.horizontal, 16).zIndex(10)
            }
            // MARK: Show Sticky Header
            if self.showStickyHeader {
                HeaderView()
            }
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(foundationPrimaryB)
        .edgesIgnoringSafeArea(.all)
    }
}

struct ShotlistStatusBar: View {
    private var states: [String] = [
        "Concept", "Scheduled", "Editing", "Complete"
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            StateBar(states: self.states,
                     current: "Scheduled")
        }.frame(height: 80)
    }
}

// MARK: Sticky View
struct HeaderView: View {
    var body: some View {
        HStack{
            Image(uiImage: #imageLiteral(resourceName: "shotlist-hero"))
                .resizable()
                .clipShape(Circle())
                .frame(width: 50, height: 50)
            Spacer()
            Text("Sample Shotlist")
                .bold()
            Spacer()
        }
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top == 0 ? 15 : (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 5)
        .padding(.horizontal)
        .padding(.bottom)
        .background(BlurBG())
    }
    
}

// MARK: Blur background custom view
struct BlurBG: UIViewRepresentable {
    func makeUIView(context: Context) -> UIVisualEffectView {
        
        // for dark mode adoption
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
        
        return view
        
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}

struct ShootPreview_Previews: PreviewProvider {
    static var previews: some View {
        ShootPreview()
    }
}
