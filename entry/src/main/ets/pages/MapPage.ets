import { router } from '@kit.ArkUI';
import { webview } from '@kit.ArkWeb';

@Entry
@Component
struct MapPage {
  // 地图URL
  private mapUrl: string = 'https://uri.amap.com/marker?position=108.154475,22.410922&name=广西民族大学相思湖学院&src=mypage&callnative=0';

  // Web控制器
  private webController: webview.WebviewController = new webview.WebviewController();

  // 加载状态
  @State isLoading: boolean = true;

  build() {
    Column() {
      // 顶部导航栏（保持不变）
      Row() {
        Button('返回')
          .width(80)
          .height(40)
          .fontColor(Color.White)
          .backgroundColor('#1677FF')
          .onClick(() => {
            router.pushUrl({
              url: 'pages/Index'
            }, router.RouterMode.Single);
          })
          .margin({ left: 20 })

        Text('校园地图')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .margin({ left: 16 })
          .flexGrow(1)
      }
      .width('100%')
      .height(56)
      .backgroundColor(Color.White)
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Center)
      .border({ width: { bottom: 1 }, color: '#E0E0E0' })

      // 地图容器
      Stack() {
        // 地图WebView
        Web({
          src: this.mapUrl,
          controller: this.webController
        })
          .width('100%')
          .height('100%')
          .javaScriptAccess(true)
          .fileAccess(true)
          .onPageEnd(() => {
            // 页面加载完成时隐藏加载指示器
            this.isLoading = false;
          })
          .onRefreshAccessedHistory((event) => {
            console.log('刷新访问历史');
          })

        // 条件渲染加载指示器
        if (this.isLoading) {
          Column() {
            Progress({ value: 0, total: 100 })
              .width(100)
              .height(100)
            Text('加载地图中...')
              .fontSize(14)
              .margin({ top: 10 })
          }
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .width('100%')
          .height('100%')
          .backgroundColor(Color.White)
        }
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}