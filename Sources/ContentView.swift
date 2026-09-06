import SwiftUI

struct Platform: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let bgColor: Color
    let textColor: Color
    let urlScheme: String
    let appStoreURL: String
}

struct ContentView: View {
    
    let platforms: [Platform] = [
        Platform(name: "抖音", icon: "🎵", bgColor: Color(red: 0.0, green: 0.0, blue: 0.0), textColor: .white,
                 urlScheme: "douyin://", appStoreURL: "https://apps.apple.com/app/id1128356669"),
        Platform(name: "快手", icon: "⚡", bgColor: Color(red: 1.0, green: 0.45, blue: 0.0), textColor: .white,
                 urlScheme: "kwai://", appStoreURL: "https://apps.apple.com/app/id493836867"),
        Platform(name: "B站", icon: "📺", bgColor: Color(red: 0.96, green: 0.65, blue: 0.76), textColor: .white,
                 urlScheme: "bilibili://", appStoreURL: "https://apps.apple.com/app/id736536674"),
        Platform(name: "虎牙", icon: "🐯", bgColor: Color(red: 1.0, green: 0.85, blue: 0.0), textColor: .black,
                 urlScheme: "huya://", appStoreURL: "https://apps.apple.com/app/id494398038"),
        Platform(name: "斗鱼", icon: "🐟", bgColor: Color(red: 1.0, green: 0.6, blue: 0.0), textColor: .white,
                 urlScheme: "douyutv://", appStoreURL: "https://apps.apple.com/app/id633645878"),
        Platform(name: "YY", icon: "🎤", bgColor: Color(red: 0.0, green: 0.5, blue: 1.0), textColor: .white,
                 urlScheme: "yy://", appStoreURL: "https://apps.apple.com/app/id334522008"),
        Platform(name: "小红书", icon: "📕", bgColor: Color(red: 1.0, green: 0.25, blue: 0.25), textColor: .white,
                 urlScheme: "xhsdiscover://", appStoreURL: "https://apps.apple.com/app/id741292507"),
        Platform(name: "微博", icon: "👁️", bgColor: Color(red: 1.0, green: 0.35, blue: 0.35), textColor: .white,
                 urlScheme: "weibo://", appStoreURL: "https://apps.apple.com/app/id350962117"),
        Platform(name: "百度", icon: "🔍", bgColor: Color(red: 0.15, green: 0.45, blue: 0.95), textColor: .white,
                 urlScheme: "baiduboxapp://", appStoreURL: "https://apps.apple.com/app/id468596381"),
        Platform(name: "网易CC", icon: "🎮", bgColor: Color(red: 0.9, green: 0.2, blue: 0.2), textColor: .white,
                 urlScheme: "cc://", appStoreURL: "https://apps.apple.com/app/id582803680"),
        Platform(name: "企鹅电竞", icon: "🐧", bgColor: Color(red: 0.0, green: 0.7, blue: 1.0), textColor: .white,
                 urlScheme: "egame://", appStoreURL: "https://apps.apple.com/app/id1066534057"),
        Platform(name: "花椒", icon: "🌶️", bgColor: Color(red: 1.0, green: 0.4, blue: 0.5), textColor: .white,
                 urlScheme: "huajiao://", appStoreURL: "https://apps.apple.com/app/id1050738717"),
    ]
    
    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(platforms) { platform in
                        Button(action: {
                            openApp(platform)
                        }) {
                            VStack(spacing: 8) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(platform.bgColor)
                                        .frame(width: 60, height: 60)
                                    Text(platform.icon)
                                        .font(.system(size: 28))
                                }
                                Text(platform.name)
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(.primary)
                                    .lineLimit(1)
                            }
                            .padding(.vertical, 8)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
            }
            .navigationTitle("直播聚合")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func openApp(_ platform: Platform) {
        if let url = URL(string: platform.urlScheme) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                return
            }
        }
        if let appStoreURL = URL(string: platform.appStoreURL) {
            UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
        }
    }
}
