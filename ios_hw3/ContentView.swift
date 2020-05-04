//
//  ContentView.swift
//  ios_hw3
//
//  Created by User04 on 2020/5/4.
//  Copyright © 2020 7021. All rights reserved.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var selectDate = Date()
    @State private var mvpViewer = false
    @State private var valueOfClap = 0
    @State private var showAlert = true
    let player = AVPlayer()

    let today = Date()
    let startDate = Calendar.current.date(byAdding: .year, value: -3, to: Date())!
    var body: some View {
        GeometryReader{ geometry in
            NavigationView {
                VStack{
                    if self.valueOfClap==10
                    {
                        Image("champcup")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width, height: geometry.size.width / 4 * 3)
                        .clipped()
                            .alert(isPresented: self.$showAlert) {
                                   Alert(title: Text("Congratulation"), message: Text("Celebrate with the team you love"))
                               }
                        
                    }
                    else
                    {
                         TenYearImage(width: geometry.size.width, selectDate: self.selectDate)
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.width / 4 * 3)
                        .clipped()
                    }
                Form{
                    DatePicker("Season:",selection: self.$selectDate, in: self.startDate...self.today ,displayedComponents: .date )
                    Toggle("View MVP:",isOn: self.$mvpViewer).sheet(isPresented: self.$mvpViewer){ShowMvp(selectDate: self.selectDate)}
                    Stepper("Clap for this team:\(self.valueOfClap)", value: self.$valueOfClap, in: 0...10)
                    }
                    NavigationLink(destination: Feedback())
                    {
                        Text("Feedback")
                    }
            
                }
            .navigationBarTitle("超級籃球聯賽")
            }
        }
        .onAppear {
                let fileUrl = Bundle.main.url(forResource: "music", withExtension: "mp4")!
                let playerItem = AVPlayerItem(url: fileUrl)
                self.player.replaceCurrentItem(with: playerItem)
                self.player.play()
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct TenYearImage: View {
    
    let width: CGFloat
    let selectDate: Date
    var year: Int {
        return Calendar.current.component(.year, from: selectDate)
    }
    
    var body: some View {
        Image("champ\(self.year)")
            .resizable()
    }
}
struct ShowMvp: View {
    
    let selectDate: Date
    var year: Int {
        return Calendar.current.component(.year, from: selectDate)
    }
    
    var body: some View {
        VStack {
            Image("mvp\(self.year)")
                .resizable()
                .scaledToFill()
            Text("Final MVP of \(self.year)").foregroundColor(Color.blue)
            .bold()
            .padding()
               .border(Color.red, width: 1)
                .shadow(radius: 5)
        }
      
            
            
    }
}
