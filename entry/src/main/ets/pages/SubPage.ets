// 导入路由模块（返回功能需要）
import router from '@ohos.router';

@Entry
@Component
struct SubPage {
  // 子页面自有状态
  @State subPageText: string = "这是子页面 ✨";

  build() {
    Column() {
      // 核心文本
      Text(this.subPageText)
        .fontSize(28)        // 字体大小
        .fontWeight(FontWeight.Bold) // 加粗
        .margin({ bottom: 40 });     // 底部间距

      // 交互按钮：修改文本
      Button("修改子页文本")
        .backgroundColor(Color.Green) // 背景色
        .fontColor(Color.White)       // 文字色（统一用fontColor）
        .borderRadius(8)              // 圆角
        .padding(10)                  // 内边距
        .margin({ bottom: 15 })       // 底部间距
        .onClick(() => {
          this.subPageText = "子页内容已修改 🎈";
        });

      // 返回按钮
      Button("返回父页面")
        .backgroundColor(Color.Blue)
        .fontColor(Color.White)
        .borderRadius(8)
        .padding(10)
        .onClick(() => {
          // 简单返回（无参数版）
          router.back();
        });
    }
    // 根容器样式：占满屏幕、内容居中
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .padding(20);
  }
}
