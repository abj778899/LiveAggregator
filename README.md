# 直播聚合 iOS App

把抖音、快手、B站、虎牙、斗鱼等12个平台的直播入口集合在一个App里，基于WKWebView加载各平台官方直播页面。

## 已集成平台
抖音直播、快手直播、B站直播、虎牙直播、斗鱼直播、YY直播、小红书、微博直播、百度直播、网易CC、企鹅电竞、花椒直播

## 功能
- 12个平台一键切换
- 内置浏览器（返回/前进/刷新/Safari打开）
- 支持横屏观看
- 模拟iPhone Safari UA，避免被强制跳转App Store

## 如何编译出IPA（用GitHub Actions，不需要Mac）

### 第一步：创建GitHub仓库
1. 登录 https://github.com
2. 点右上角 `+` → `New repository`
3. 仓库名随便填（如 `LiveAggregator`），选 Public 或 Private 都行
4. 不要勾选 "Add a README file"，点 Create repository

### 第二步：上传代码
1. 在仓库页面点 `uploading an existing file`
2. 把本文件夹里的**所有文件和文件夹**拖进去（包括 .github 文件夹、Sources、Assets.xcassets、project.yml）
3. 注意：`.github` 文件夹可能被隐藏，确保一起上传
4. 点 `Commit changes`

### 第三步：等待自动编译
1. 上传后点仓库顶部的 `Actions` 标签
2. 会看到一个 "Build IPA" 的任务正在运行
3. 等大约3-5分钟编译完成
4. 编译成功后，点进该次运行记录，最下方 `Artifacts` 里有 `LiveAggregator.ipa`
5. 下载这个IPA文件

### 第四步：用巨魔安装
1. 把IPA传到手机（AirDrop / 微信文件传输助手 / iCloud）
2. 打开巨魔(TrollStore)
3. 点右上角 `+` → 选择刚才的IPA文件
4. 点 `Install` 安装
5. 桌面出现"直播聚合"图标，打开即可用

## 常见问题

**Q: Actions里编译失败怎么办？**
A: 点进失败的任务，看红色报错信息，截图发给我排查。

**Q: 安装后打开闪退？**
A: 巨魔版本需要支持你的iOS版本。确认巨魔已正确安装并启用了Persistence Helper。

**Q: 某个平台直播打不开？**
A: 部分平台网页版需要登录才能看直播，在App内点该平台后登录一次即可。

**Q: 想加更多平台？**
A: 修改 `Sources/ContentView.swift` 里的 `platforms` 数组，添加新平台的名称和直播网址，重新上传编译即可。

## 技术说明
- 最低系统：iOS 14.0
- 架构：arm64
- 未签名IPA，需用巨魔或其他侧载工具安装
- 本App仅为各平台官方网页的导航容器，不存储、不抓取任何直播流
