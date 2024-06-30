//
//  ContentView.swift
//  CountingLetters
//
//  Created by 심성곤 on 6/30/24.
//

import SwiftUI

/// 글자수 세기
struct ContentView: View {
    
    @State var text = ""
    @FocusState var isFocused: Bool
    
    /// 공백 제외
    var removeSpaceTextCount: Int {
        String(text.filter { $0 != " " }).count
    }
    /// 줄 개수
    var newLineCount: Int {
        text.reduce(text.isEmpty ? 0 : 1) { $1 == "\n" ? $0 + 1 : $0 }
    }
    /// 단어 개수
    var wordCount: Int {
        text.isEmpty ? 0 : text.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .whitespacesAndNewlines).count
    }
    
    var body: some View {
        VStack {
            HStack {
                Button("전체삭제") {
                    text = ""
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                Button("전체복사") {
                    UIPasteboard.general.string = text
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                ShareLink(item: text) {
                    Text("공유")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .frame(height: 30)
            .disabled(text.isEmpty)
            
            TextEditor(text: $text)
                .padding(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.gray.opacity(0.5))
                )
                .focused($isFocused)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("공백포함 : 총 \(text.count)자")
                    Text("공백제외 : 총 \(removeSpaceTextCount)자")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("줄 : \(newLineCount)")
                    Text("단어 : \(wordCount)")
                }
            }
        }
        .padding()
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                
                Button {
                    isFocused = false
                } label: {
                    Image(systemName: "keyboard.chevron.compact.down")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
