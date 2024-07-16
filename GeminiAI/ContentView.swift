//
//  ContentView.swift
//  SecurityGeminiAI
//
//  Created by kaito on 2024/07/16.
//

import SwiftUI

struct message {
    let message: String
    let isFormUser: Bool
}

struct ContentView: View {
    @State var prompt = ""
    @State var MessageList: [message] = []
    
    @State var isLoading = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Image(systemName: "brain")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .foregroundColor(.blue)
                    .opacity(0.2)
                
                VStack {
                    //タイトル
                    HStack{
                        VStack(alignment: .leading) {
                            Text("Welcome")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Text("Gemini AI")
                                .font(.title)
                                .fontWeight(.heavy)
                                .foregroundColor(.blue)
                        }.padding()
                        
                        Spacer()
                    }
                    
                    Spacer()

                    //やりとり
                    VStack(alignment: .leading, spacing: 8) {
                        ScrollView {
                            ForEach(0..<MessageList.count, id: \.self) { index in
                                HStack{
                                    if MessageList[index].isFormUser {
                                        Spacer()
                                        Text(MessageList[index].message)
                                            .padding()
                                            .fontWeight(.bold)
                                            .background(Color.green.opacity(1))
                                            .foregroundColor(.white)
                                            .cornerRadius(7)
                                            .padding()
                                    } else {
                                        Text(MessageList[index].message)
                                            .padding()
                                            .fontWeight(.bold)
                                            .background(Color.red)
                                            .foregroundColor(.white)
                                            .cornerRadius(7)
                                            .padding()
                                        Spacer()
                                    }
                                }
                            }
                        }
                    }
                    
                    Spacer()
                    
                    HStack{
                        //プロンプト入力
                        TextField("Aa", text: $prompt)
                            .frame(maxWidth: .infinity)
                            .textFieldStyle(.roundedBorder)
                            .padding()
                        
                        Button(action: {
                            MessageList.append(message(message: prompt, isFormUser: true))
                            
                            isLoading = true //ローディング開始
                            
                            //生成
                            Task {
                                do {
                                    let response = try await Gemini.shared.generateRespons(prompt: prompt)
                                    MessageList.append(message(message: response, isFormUser: false))
                                    isLoading = false
                                } catch {
                                    let response = "Sometimes went wrong \n \(error.localizedDescription)"
                                    MessageList.append(message(message: response, isFormUser: false))
                                    isLoading = false
                                }
                            }
                        }){
                            Image(systemName: "arrow.up")
                                .frame(width: 40, height: 40)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                        }.padding()
                    }
                }
                
                if isLoading {
                    Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
                    ProgressView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
