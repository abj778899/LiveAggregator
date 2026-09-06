import SwiftUI

struct Platform: Identifiable {
    let id = UUID()
    let name: String
    let url: String
    let icon: String
    let bgColor: Color
    let textColor: Color
}

struct ContentView: View {
    
    let platforms: [Platform] = [
        Platform(name: "抖音直播", url: "https://live.douyin.com", icon: "🎵", bgColor: Color(red: 0.0, green: 0.0, blue: 0.0), textColor: .white),
        Platform(name: "快手直播", url: "https://live.kuaishou.com", icon: "⚡", bgColor: Color(red: 1.0, green: 0.45, blue: 0.0), textColor: .white),
        Platform(name: "B站直播", url: "https://live.bilibili.com", icon: "📺", bgColor: Color(red: 0.96, green: 0.65, blue: 0.76), textColor: .white),
        Platform(name: "虎牙直播", url: "https://m.huya.com", icon: "🐯", bgColor: Color(red: 1.0, green: 0.85, blue: 0.0), textColor: .black),
        Platform(name: "斗鱼直播", url: "https://m.douyu.com", icon: "🐟", bgColor: Color(red: 1.0, green: 0.6, blue: 0.0), textColor: .white),
        Platform(name: "YY直播", url: "https://www.yy.com", icon: "🎤", bgColor: Color(red: 0.0, green: 0.5, blue: 1.0), textColor: .white),
        Platform(name: "小红书", url: "https://www.xiaohongshu.com", icon: "📕", bgColor: Color(red: 1.0, green: 0.25, blue: 0.25), textColor: .white),
        Platform(name: "微博直播", url: "https://weibo.com", icon: "👁️", bgColor: Color(red: 1.0, green: 0.35, blue: 0.35), textColor: .white),
        Platform(name: "百度直播", url: "https://live.baidu.com", icon: "🔍", bgColor: Color(red: 0.15, green: 0.45, blue: 0.95), textColor: .white),
        Platform(name: "网易CC", url: "https://cc.163.com", icon: "🎮", bgColor: Color(red: 0.9, green: 0.2, blue: 0.2), textColor: .white),
        Platform(name: "企鹅电竞", url: "https://egame.qq.com", icon: "🐧", bgColor: Color(red: 0.0, green: 0.7, blue: 1.0), textColor: .white),
        Platform(name: "花椒直播", url: "https://www.huajiao.com", icon: "🌶️", bgColor: Color(red: 1.0, green: 0.4, blue: 0.5), textColor: .white),
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
                        NavigationLink(destination: WebBrowserView(url: URL(string: platform.url)!, title: platform.name)) {
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
}
