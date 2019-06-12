//
//  YXWebViewController.m
//  YXVC
//
//  Created by 李涛 on 2017/12/1.
//  Copyright © 2017年 Tao_Lee. All rights reserved.
//

#import "YXWebViewController.h"
#import "YXBaseVCHeader.h"
#import <WebKit/WebKit.h>
#import "YXWeakScriptMessageDelegate.h"

@interface YXWebViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) NSMutableSet *scriptNameSet;

@property (nonatomic, assign) CGFloat lastTimeSP;

@end

@implementation YXWebViewController

- (void)dealloc{
    if (self.useWebTitle) {
        [self.webView removeObserver:self forKeyPath:@"title"];
    }
    [self.webView removeObserver:self forKeyPath:@"URL"];
    
    for (NSString *name in self.scriptNameSet) {
        [[_webView configuration].userContentController removeScriptMessageHandlerForName:name];
    }
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _useWebTitle = YES;
        _directPop = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - WKNavigationDelegate
// 页面加载开始  Provisional临时的
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"页面开始加载");
}
// 加载内容
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    NSLog(@"内容正在加载当中");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    NSString *doc = @"document.body.outerHTML";
    [webView evaluateJavaScript:doc
                     completionHandler:^(id _Nullable htmlStr, NSError * _Nullable error) {
                         if (error) {
                             NSLog(@"JSError:%@",error);
                         }
//                         NSLog(@"html:%@",htmlStr);
                     }] ;
}
//  页面加载失败
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"页面加载失败");
}

// 接收到服务器重新配置请求之后再执行
-(void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
    
}
// API是根据WebView对于即将跳转的HTTP请求头信息和相关信息来决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSURL *url = navigationAction.request.URL;
    NSString *scheme = [url scheme];
    UIApplication *app = [UIApplication sharedApplication];
    // 打电话
    if ([scheme isEqualToString:@"tel"]) {
        if ([app canOpenURL:url]) {
            [app openURL:url];
            // 一定要加上这句,否则会打开新页面
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    // 打开appstore
    if ([url.absoluteString containsString:@"itunes.apple.com"]) {
        if ([app canOpenURL:url]) {
            [app openURL:url];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    
    if ([url.absoluteString containsString:@"itms-services://"]) {
        if (@available(iOS 10.0, *)) {
            [app openURL:url options:@{} completionHandler:^(BOOL success) {
                
            }];
        } else {
            [app openURL:url];
        }
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}
#pragma mark - WKUIDelegate
- (void)webViewDidClose:(WKWebView *)webView {
    NSLog(@"%s", __FUNCTION__);
}

// 在JS端调用alert函数时，会触发此代理方法。
// JS端调用alert时所传的数据可以通过message拿到
// 在原生得到结果后，需要回调JS，是通过completionHandler回调
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    NSLog(@"%s", __FUNCTION__);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"alert" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];

    [self presentViewController:alert animated:YES completion:NULL];
    NSLog(@"%@", message);
}

// JS端调用confirm函数时，会触发此方法
// 通过message可以拿到JS端所传的数据
// 在iOS端显示原生alert得到YES/NO后
// 通过completionHandler回调给JS端
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
    NSLog(@"%s", __FUNCTION__);
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:message message:nil  preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
    
    NSLog(@"%@", message);
}

// JS端调用prompt函数时，会触发此方法
// 要求输入一段文本
// 在原生输入得到文本内容后，通过completionHandler回调给JS
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:prompt message:defaultText preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
    }];

    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler([[alert.textFields lastObject] text]);
    }]];

    [self presentViewController:alert animated:YES completion:NULL];
}

- (void)evaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^)(id, NSError *))completionHandler{
    
}

#pragma mark - WKScriptMessageHandler
//js回调iOS
- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
    if (self.receiveJSHandle && !message.name && message.name.length > 0) {
        self.receiveJSHandle(message.name, message.body);
    }
}

#pragma mark - observe
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:@"title"]) {
        self.baseNavTitle.text = self.webView.title;
    }
    if ([keyPath isEqualToString:@"URL"]) {
        NSString *urlStr = [_webView.URL absoluteString];
        urlStr = [urlStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//        if ([urlStr containsString:YYZScheme]) {
//            [SchemeTool pushTargetViewControllerWithTargetUrl:urlStr];
//        }
    }
}



#pragma mark - httpRequest

#pragma mark - click
- (void)goBack{
    
    if (_directPop) {
        [self removeCache];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        CGFloat currrentTimesp = [CommonTools timeSp] * 1000;
        CGFloat differValue = currrentTimesp - _lastTimeSP;
        _lastTimeSP = currrentTimesp;
        if ([self.webView canGoBack] && differValue > 500) {
            [self.webView goBack];
        }else{
            [self removeCache];
            [self.navigationController popViewControllerAnimated:YES];
            
        }
    }
    
    
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else{
        [self removeCache];
        [self.navigationController popViewControllerAnimated:YES];
     
    }
}

#pragma mark - private method
- (void)addScriptHandleName:(NSString *)name{
    if ([self.scriptNameSet containsObject:name]) {
        
    }else{
        [self.webView.configuration.userContentController addScriptMessageHandler: [[YXWeakScriptMessageDelegate alloc] initWithDelegate:self] name:name];
    }
}

- (void)removeCache{
    if ([[CommonTools getSystemVersion] floatValue] > 9.0) {
        NSSet *websiteDataTypes = [NSSet setWithArray:@[
                                                        WKWebsiteDataTypeDiskCache,
                                                        WKWebsiteDataTypeOfflineWebApplicationCache,
                                                        WKWebsiteDataTypeMemoryCache,
                                                        WKWebsiteDataTypeLocalStorage,
                                                        WKWebsiteDataTypeCookies,
                                                        WKWebsiteDataTypeSessionStorage,
                                                        WKWebsiteDataTypeIndexedDBDatabases,
                                                        WKWebsiteDataTypeWebSQLDatabases
                                                        ]];
        //你可以选择性的删除一些你需要删除的文件 or 也可以直接全部删除所有缓存的type
        //NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes
                                                   modifiedSince:dateFrom completionHandler:^{
                                                       // code
                                                   }];
    }else{
        NSString*libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES)objectAtIndex:0];

        NSString*cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];

        NSError*errors;

        [[NSFileManager defaultManager]removeItemAtPath:cookiesFolderPath error:&errors];
        NSLog(@"%@",errors);
    }
    NSString *libraryDir = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
                                                               NSUserDomainMask, YES)[0];
    NSString *bundleId  =  [[[NSBundle mainBundle] infoDictionary]
                            objectForKey:@"CFBundleIdentifier"];
    NSString *webkitFolderInLib = [NSString stringWithFormat:@"%@/WebKit",libraryDir];
    NSString *webKitFolderInCaches = [NSString
                                      stringWithFormat:@"%@/Caches/%@/WebKit",libraryDir,bundleId];
    NSString *webKitFolderInCachesfs = [NSString
                                        stringWithFormat:@"%@/Caches/%@/fsCachedData",libraryDir,bundleId];

    NSError *error;
    /* iOS8.0 WebView Cache的存放路径 */
    [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCaches error:&error];
    [[NSFileManager defaultManager] removeItemAtPath:webkitFolderInLib error:nil];

    /* iOS7.0 WebView Cache的存放路径 */
    [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCachesfs error:&error];
}
#pragma mark - setter

#pragma mark - init

- (void)initUI{
    WS(ws)
    
    _lastTimeSP = [CommonTools timeSp] * 1000;
    [self createNav];
    [self.view addSubview:self.webView];
    
    
}

- (void)createNav{
    WS(ws)
    NSString *bundlePath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"YXBaseVC.bundle"];
    
    
    NSString *img_path = [[NSBundle bundleWithPath:bundlePath] pathForResource:@"yx_back@2x" ofType:@"png"];
    UIImage *img = [UIImage imageWithContentsOfFile:img_path];
    
    [self createNavWithTitle:_titleStr andBackImage:@"yx_back" andRightImg:nil andRightBtnTitle:nil andBackClick:^{
        [ws goBack];
    } andRightClick:nil];
    [self.backBtn setImage:img forState:(UIControlStateNormal)];
}

- (WKWebView *)webView{
    if (!_webView) {
        WKWebViewConfiguration *cfg = [[WKWebViewConfiguration alloc] init];
        //是否支持JavaScript
        cfg.preferences.javaScriptEnabled = YES;
        //不通过用户交互，是否可以打开窗口
        cfg.preferences.javaScriptCanOpenWindowsAutomatically = NO;
        
        /*
         当JS端想传一些数据给iOS.那它们会调用下方方法来发送.
         window.webkit.messageHandlers.<对象名>.postMessage(<数据>)
         那么在OC中的处理方法如下.它是WKScriptMessageHandler的代理方法.name和上方JS中的对象名相对应.
         - (void)addScriptMessageHandler:(id <WKScriptMessageHandler>)scriptMessageHandler name:(NSString *)name;
         
         
         */
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
//        [userContentController addScriptMessageHandler:[[YXWeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"PayParam"];
        cfg.userContentController = userContentController;
        
        cfg.allowsInlineMediaPlayback = YES;
        if (@available(iOS 10.0, *)) {
            cfg.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypeNone;
        }else {
            cfg.mediaPlaybackRequiresUserAction = NO;
        }
        
        
        _webView = [[WKWebView alloc] initWithFrame:(CGRectMake(0, NavH, kScreenWidth, kScreenHeight-NavH)) configuration:cfg];
        _webView.backgroundColor = ColorFrom0xRGB(0xf2f1f1);
        _webView.scrollView.backgroundColor = ColorFrom0xRGB(0xf2f1f1);
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        
        
        if (_contentStr) {
            [_webView loadHTMLString:_contentStr baseURL:nil];
        }else{
            //url收尾进行去空格处理
            _urlStr = [_urlStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            [_webView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:_urlStr]]];
        }
        if (self.useWebTitle) {
            [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
        }
        
        [_webView addObserver:self forKeyPath:@"URL" options:(NSKeyValueObservingOptionNew) context:nil];
    }
    return _webView;
}

- (NSMutableSet *)scriptNameSet{
    if (!_scriptNameSet) {
        _scriptNameSet = [NSMutableSet set];
    }
    return _scriptNameSet;
}

@end
