//
//  ContentView.swift
//  Distributed-Computing-Network
//
//  Created by Andrew Hurlbut on 1/28/25.
//

import SwiftUI

struct ContentView: View {
    @State private var displayText: String = "Default"
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Text(displayText)
            Button("Get tasl"){
                getTask()
            }
            
            ChildView(title: "First Child")

        }
        .padding()
    }
    
    
    func getTask(){
        guard let url = URL(string: "https://distributedcompute.pythonanywhere.com/task/TASK001") else {
                    displayText = "Invalid URL"
                    return
                }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    if let error = error {
                        DispatchQueue.main.async {
                            displayText = "Error: \(error.localizedDescription)"
                        }
                        return
                    }
                    
                    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                        DispatchQueue.main.async {
                            displayText = "Error: Invalid response"
                        }
                        return
                    }
                    
                    guard let data = data, let taskDetails = String(data: data, encoding: .utf8) else {
                        DispatchQueue.main.async {
                            displayText = "Error: Unable to parse data"
                        }
                        return
                    }
                    
                    DispatchQueue.main.async {
                        displayText = taskDetails
                    }
                }
                
            task.resume()
        
    }
    
}

struct ChildView: View {
    let title: String

    var body: some View {
        Text(title)
            .padding()
            .background(Color.blue)
            .cornerRadius(8)
            .foregroundColor(.white)
        VStack{
            Image(systemName: "hat")
        }
    }
}




#Preview {
    ContentView()
}
