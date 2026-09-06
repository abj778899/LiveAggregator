import SwiftUI
import WebKit

struct WebBrowserView: View {
    let url: URL
    let title: String
    
    @State private var canGoBack = false
    @State private var canGoForward = false
    @State private var isLoading = true
    @State private var showError = false
    
    var body: some View {
        VStack(spacing: 0) {
            WebViewWrapper(
                url: url,
                onNavigationChange: { back, forward, loading in
                    canGoBack = back
                    canGoForward = forward
                    isLoading = loading
                },
                onError: {
                    showError = true
                }
            )
            
            if isLoading {
                ProgressView()
                    .progressViewStyle(LinearProgressViewStyle())
                    .padding(.horizontal)
            }
            
            HStack(spacing: 0) {
                Button(action: {
                    NotificationCenter.default.post(name: .webGoBack, object: nil)
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(canGoBack ? .blue : .gray)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                }
                .disabled(!canGoBack)
                
                Button(action: {
                    NotificationCenter.default.post(name: .webGoForward, object: nil)
                }) {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(canGoForward ? .blue : .gray)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                }
                .disabled(!canGoForward)
                
                Button(action: {
                    NotificationCenter.default.post(name: .webReload, object: nil)
                }) {
                    Image(systemName: "arrow.clockwise")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                }
                
                Button(action: {
                    if let url = URL(string: url.absoluteString) {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Image(systemName: "safari")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                }
            }
            .background(Color(.systemBackground))
            .overlay(Divider(), alignment: .top)
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showError) {
            Alert(
                title: Text("加载失败"),
                message: Text("页面加载失败，请检查网络后重试"),
                primaryButton: .default(Text("重试")) {
                    NotificationCenter.default.post(name: .webReload, object: nil)
                    showError = false
                },
                secondaryButton: .cancel(Text("取消"))
            )
        }
    }
}

extension Notification.Name {
    static let webGoBack = Notification.Name("webGoBack")
    static let webGoForward = Notification.Name("webGoForward")
    static let webReload = Notification.Name("webReload")
}

struct WebViewWrapper: UIViewRepresentable {
    let url: URL
    let onNavigationChange: (Bool, Bool, Bool) -> Void
    let onError: () -> Void
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []
        
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator
        webView.customUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 16_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6 Mobile/15E148 Safari/604.1"
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.bounces = true
        
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 30)
        webView.load(request)
        
        context.coordinator.webView = webView
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
    
    class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
        var parent: WebViewWrapper
        weak var webView: WKWebView?
        
        init(_ parent: WebViewWrapper) {
            self.parent = parent
            super.init()
            
            NotificationCenter.default.addObserver(self, selector: #selector(goBack), name: .webGoBack, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(goForward), name: .webGoForward, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(reload), name: .webReload, object: nil)
        }
        
        @objc func goBack() { webView?.goBack() }
        @objc func goForward() { webView?.goForward() }
        @objc func reload() { webView?.reload() }
        
        func updateState() {
            guard let webView = webView else { return }
            parent.onNavigationChange(webView.canGoBack, webView.canGoForward, webView.isLoading)
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            updateState()
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            updateState()
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            updateState()
            parent.onError()
        }
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            updateState()
            if (error as NSError).code != NSURLErrorCancelled {
                parent.onError()
            }
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            decisionHandler(.allow)
        }
        
        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            if navigationAction.targetFrame == nil {
                webView.load(navigationAction.request)
            }
            return nil
        }
        
        deinit {
            NotificationCenter.default.removeObserver(self)
        }
    }
}
