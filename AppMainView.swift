//
//  AppMainView.swift
//  GeneralSetting
//
//  Created by HarrisShao on 2025/6/12.
//

import SwiftUI
import StoreKit

struct AppMainView: View {
    @AppStorage("isBellSlash") private var isBellSlash: Bool = false
    @AppStorage("isDark") private var isDark:Bool = false
    @State private var selectedColor: Color = .blue
    @AppStorage("selectLanguage") private var selectLanguage: String = "English"
    @State private var languageItems: [String] = [
        "简体中文", "English", "Spanish"
    ]
    
    @AppStorage("selectedSizeNumber")  private var selectedSizeNumber : Int = 17
    
    var body: some View {

        NavigationStack {
            Form {
                // 常规设置
                Section {
                    NotificationToggleView
                    DarkModelToggleView
                } header: {
                    Text("General Setting")
                }
                .padding(.vertical, 4)

                // 个性化
                Section {
                    SelectedColorView
                    SystemLanguageView
                    SystemFontView
                } header: {
                    Text("Personalization")
                }
                .padding(.vertical, 6)

                // 关于我们
                Section {
                    FeedMessageView
                    AppstoreRatingView
                    AbountApplicationView
                } header: {
                    Text("Abount we")
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("Setting")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
    
    // 通知
    private var NotificationToggleView: some View {
        Toggle(isOn: $isBellSlash) {
            HStack {
                Image(systemName: "bell")
                    .font(.system(size:20))
                Text("Notification")
            }
        }
    }
    
    // 黑暗模式
    private var DarkModelToggleView: some View {
        Toggle(isOn: $isDark) {
            HStack {
                Image(systemName: "moon.stars")
                    .font(.system(size:20))
                Text("Dark")
            }
        }
        .preferredColorScheme(isDark ? .dark : .light)
    }
    
    // 主题
    private var SelectedColorView: some View {
        ColorPicker(selection: $selectedColor) {
            HStack {
                Image(systemName: "paintbrush")
                    .font(.system(size: 20))
                Text("Theme Color")
            }
        }
    }
    // 系统语言
    private var SystemLanguageView: some View {
        Picker(selection: $selectLanguage) {
            ForEach(languageItems, id: \.self) { language in
                Text(language)
            }
        } label: {
            HStack {
                Image(systemName: "waveform")
                    .font(.system(size: 20))
                Text("System Language")
            }
        }

    }
    // 字体
    private var SystemFontView: some View {
        Stepper(value: $selectedSizeNumber, in: 1...48) {
            HStack {
                Image(systemName: "a.circle")
                    .font(.system(size: 20))
                Text("Font Size: \(selectedSizeNumber)")
            }
        }
    }
    
    // 意见反馈
    private var FeedMessageView: some View {
        Button(action: {
            //
        }){
            HStack {
                Image(systemName: "ellipsis.message")
                    .font(.system(size: 20))
                Text("Feed Message")
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    // appstore 评分
    private var AppstoreRatingView: some View {
        Button(action: {
            appReview()
        }){
            HStack {
                Image(systemName: "star")
                    .font(.system(size: 20))
                Text("Appstore Rating")
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
    func appReview() {
        if let scene = UIApplication.shared.connectedScenes.first(where: {
            $0.activationState == .foregroundActive
        }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
    
    // 关于我们
    private var AbountApplicationView:some View {
        Button(action: {}, label: {
            HStack{
                Image(systemName: "person")
                    .font(.system(size: 20))
                Text("About Application")
            }
        })
        .buttonStyle(PlainButtonStyle())
    }
    
    
    
}

#Preview {
    AppMainView()
}
