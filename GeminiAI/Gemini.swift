//
//  Gemini.swift
//  SecurityGeminiAI
//
//  Created by kaito on 2024/07/16.
//

import Foundation
import GoogleGenerativeAI

class Gemini {
    static let shared = Gemini()
    
    let model = GenerativeModel(name: "gemini-1.5-flash", apiKey: APIKey.default)
    
    private init() {}
    
    func generateRespons(prompt: String) async throws -> String {
        let result = try await model.generateContent(prompt)
        return result.text ?? "No Respons found"
    }
}
