@Entry
@Component
struct Services {
  build() {
    Column() {
      Text('校园服务页面')
        .fontSize(30)
        .fontColor(Color.Blue);

      Text('成绩查询、图书查询等功能')
        .fontSize(18)
        .margin({ top: 20 });
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center);
  }
}