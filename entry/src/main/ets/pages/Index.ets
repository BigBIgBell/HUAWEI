import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct Index {
  @State currentIndex: number = 0;

  // 使用数组存储数据
  private banners: string[] = ['banner1', 'banner2', 'banner3'];
  private quickActions: string[] = ['地图', '成绩', '图书', '服务'];
  private copyText: string = '校园热线：400-123-4567';

  // 点击快捷功能
  private onQuickActionClick(index: number): void {
    promptAction.showToast({
      message: '点击了：' + this.quickActions[index],
      duration: 1500
    });

    if (index === 0) {
      router.pushUrl({ url: 'pages/Form' });
    }
  }

  // 复制文本
  private onCopyText(): void {
    promptAction.showToast({
      message: '已复制到剪贴板',
      duration: 1500
    });
  }

  build() {
    Column() {
      // 1. 轮播图
      Swiper() {
        ForEach(this.banners, (item: string, index: number) => {
          Column() {
            Text(item)
              .fontSize(20)
              .fontColor(Color.White);
          }
          .width('100%')
          .height(150)
          .backgroundColor(index === 0 ? Color.Blue :
            index === 1 ? Color.Green : Color.Red);
        }, (item: string) => item)
      }
      .width('100%')
      .height(150)
      .indicator(true)
      .loop(true);

      // 2. 快捷功能
      Text('快捷功能')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 10 });

      Row() {
        ForEach(this.quickActions, (item: string, index: number) => {
          Column() {
            // 模拟图标
            Stack() {
              Circle({ width: 50, height: 50 })
                .fill(Color.Blue);
              Text(item.charAt(0))
                .fontSize(20)
                .fontColor(Color.White);
            }
            Text(item)
              .fontSize(12)
              .margin({ top: 5 });
          }
          .margin({ right: 10 })
          .onClick(() => {
            this.onQuickActionClick(index);
          });
        }, (item: string) => item)
      }
      .justifyContent(FlexAlign.SpaceAround)
      .width('100%')
      .padding(10);

      // 3. 富文本展示
      Text('校园公告')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 10 });

      Column() {
        Text('重要通知')
          .fontSize(16)
          .fontColor(Color.Red);
        Text('系统维护通知')
          .fontSize(14);
        Text('维护时间：周末00:00-06:00')
          .fontSize(12)
          .fontColor(Color.Gray);
      }
      .padding(10)
      .backgroundColor(0xF5F5F5)
      .borderRadius(8)
      .width('90%');

      // 4. 可复制文本 - 使用onClick而不是onLongPress
      Text('联系方式')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 10 });

      Text(this.copyText)
        .fontSize(14)
        .padding(10)
        .backgroundColor(0xF5F5F5)
        .borderRadius(8)
        .width('90%')
        .onClick(() => {
          this.onCopyText();
        });
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .padding(10);
  }
}