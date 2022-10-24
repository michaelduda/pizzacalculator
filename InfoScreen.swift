//
//  InfoScreen.swift
//  Pizza Calculator
//
//  Created by Michal Duda on 01/05/2022.
//

import SwiftUI
import SceneKit

struct InfoScreen: View {
    
    //    @State private var isRotated = false
    //    var animation: Animation {
    //
    //        Animation.linear(duration: 3)
    //
    //            .repeatForever(autoreverses: false)
    //    }
    @State var scale: CGFloat = 1
    
    
    var body: some View {
        
        
        
        ZStack {
            LinearGradient(colors: [Color(red: 2/255, green: 10/255, blue: 30/255), .black],
                           startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
            
            
            ZStack {
                
                
                
                
                SceneView(scene: SCNScene(named: "pizzadude2.scn"), options: [.autoenablesDefaultLighting,.allowsCameraControl])
                    .frame(width: UIScreen.main.bounds.width-50 , height: UIScreen.main.bounds.height/2.5)
                    .clipShape(Circle())
                
                
                
                AngularGradient(colors: [.orange, .yellow, .green, .teal, .blue,
                                         .blue, .indigo, .indigo, .black, .black,
                                         .black, .purple, .purple, .purple, .black,
                                         .black, .black, .black, .black, .orange].reversed(),
                                center: .center, startAngle: .degrees(-90), endAngle: .degrees(270))
                .mask {
                    Circle()
                        .stroke(lineWidth: 3)
                }
                .rotationEffect(Angle.degrees(scale))
                //                            .animation(animation)
                .onAppear {
                    let baseAnimation = Animation.linear(duration: 5)
                    let repeated = baseAnimation.repeatForever(autoreverses: false)
                    
                    withAnimation(repeated) {
                        scale = 360
                    }
                }
                .padding(25)
                
                
                VStack {
                    Text("Friday pizza calculator")
                        .font(.title.weight(.bold))
                        .padding(.vertical, 1.0)
                    Text("Version 1.1")
                    Text("by Michał Duda")
                        .font(.footnote)
                    //                            Button("Rotate")
                    //                            {
                    //                                self.isRotated.toggle()
                    //                            }
                    
                }
                .foregroundColor(Color(red: 198/255, green: 225/255, blue: 230/255))
                .offset(x: 0, y: 250)
                
            }
            .offset(x: 0, y: -50)
            
            
            
            
        }
        
        
        
        
        
        
    }
}

struct InfoScreen_Previews: PreviewProvider {
    static var previews: some View {
        InfoScreen()
    }
}
