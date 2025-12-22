@Entry
@Component
struct MapPage {
  build() {
    Column() {
      Text('地图页面')
        .fontSize(30)
        .fontColor(Color.Blue);

      Text('这里显示校园地图')
        .fontSize(18)
        .margin({ top: 20 });
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center);
  }
}