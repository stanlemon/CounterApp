//
//  ContentView.swift
//  CounterApp
//
//  Created by Stan Lemon on 6/11/19.
//  Copyright © 2019 Stan Lemon. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    
    @EnvironmentObject var counterData: CounterData
    
    @State var hasClicked: Bool = false
    
    private func increment() {
        print("Incrementing")
        self.hasClicked = true
        self.counterData.count = self.counterData.count + 1
    }
    
    private func decrement() {
        print("Decrementing")
        self.hasClicked = true
        self.counterData.count = self.counterData.count - 1
    }
    
    var body: some View {
        VStack() {
            Spacer()
            Text("Counter App")
                .font(.title)
                .color(.blue)
            Text("Because everyone deserves a demo!")
                .font(.subheadline)
            Spacer()
            Text("Have you clicked a button yet? \(self.hasClicked == true ? "Yes!" : "No.")")
            Spacer()
            Text("\(self.counterData.count)")
                .font(.largeTitle)
            Spacer()
            HStack() {
                Button(action: increment) {
                    Text("Increment +")
                }
                Button(action: decrement) {
                    Text("Decrement -")
                }
            };
            Spacer()
        }.onAppear(perform: {
            print("View has appeared")
        })
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CounterData())
    }
}
#endif
