import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

// 定义类型
interface TabItem {
  name: string;
  icon: string;
  page: string;
}

@Entry
@Component
struct Index {
  @State currentIndex: number = 0;
  @State showRedDot: boolean = true;

  // 明确类型声明
  private tabs: TabItem[] = [
    { name: '首页', icon: '🏠', page: 'Index' },
    { name: '导航', icon: '🗺️', page: 'Form' },
    { name: '地图', icon: '📍', page: 'MapPage' },
    { name: '服务', icon: '🎓', page: 'Services' }
  ];

  private banners: string[] = ['banner1', 'banner2', 'banner3'];
  private quickActions: string[] = ['地图', '成绩', '图书', '服务'];
  private copyText: string = '校园热线：400-123-4567';
  private recommendations: string[] = ['讲座', '比赛', '招聘', '活动', '新闻'];

  // 切换Tab - 添加错误处理
  private switchTab(index: number): void {
    try {
      this.currentIndex = index;
      const page = this.tabs[index].page;
      if (page !== 'Index') {
        // 使用新的导航方法
        router.pushUrl({ url: `pages/${page}` });
      }
    } catch (error) {
      console.error('切换Tab错误:', error);
    }
  }

  // 点击快捷功能
  private onQuickActionClick(index: number): void {
    try {
      promptAction.showToast({
        message: '点击了：' + this.quickActions[index],
        duration: 1500
      });

      if (index === 0) {
        router.pushUrl({ url: 'pages/MapPage' });
      } else if (index === 1 || index === 2) {
        router.pushUrl({ url: 'pages/Services' });
      }
    } catch (error) {
      console.error('快捷功能点击错误:', error);
    }
  }

  // 复制文本
  private onCopyText(): void {
    try {
      promptAction.showToast({
        message: '已复制到剪贴板',
        duration: 1500
      });
    } catch (error) {
      console.error('复制错误:', error);
    }
  }

  build() {
    Column() {
      // 页面内容
      Scroll() {
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

          // 2. 横向滚动区
          Column() {
            Text('热门推荐')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .margin({ top: 20, bottom: 10 });

            Scroll() {
              Row() {
                ForEach(this.recommendations, (item: string) => {
                  Column() {
                    Text(item)
                      .fontSize(16)
                      .fontColor(Color.White);
                  }
                  .width(120)
                  .height(80)
                  .backgroundColor(Color.Blue)
                  .borderRadius(8)
                  .margin({ right: 10 })
                  .justifyContent(FlexAlign.Center);
                }, (item: string) => item)
              }
              .padding(10);
            }
            .scrollable(ScrollDirection.Horizontal)
            .height(100);
          }

          // 3. 快捷功能入口
          Column() {
            Text('快捷功能')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .margin({ top: 20, bottom: 10 });

            Grid() {
              ForEach(this.quickActions, (item: string, index: number) => {
                GridItem() {
                  Column() {
                    // 图标
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
                  .onClick(() => {
                    this.onQuickActionClick(index);
                  });
                }
              }, (item: string) => item)
            }
            .columnsTemplate('1fr 1fr 1fr 1fr')
            .rowsTemplate('1fr')
            .columnsGap(10)
            .rowsGap(10)
            .height(100)
            .margin({ bottom: 20 });
          }

          // 4. 富文本展示区
          Column() {
            Text('校园公告')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .margin({ bottom: 10 });

            Column() {
              Text('重要通知')
                .fontSize(16)
                .fontColor(Color.Red)
                .fontWeight(FontWeight.Bold);
              Text('系统维护通知')
                .fontSize(14)
                .margin({ top: 5 });
              Text('时间：周末00:00-06:00')
                .fontSize(12)
                .fontColor(Color.Gray)
                .margin({ top: 5 });
            }
            .padding(15)
            .backgroundColor(0xF5F5F5)
            .borderRadius(8);
          }

          // 5. 文字复制功能
          Column() {
            Text('联系方式')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .margin({ top: 20, bottom: 10 });

            Text(this.copyText)
              .fontSize(14)
              .padding(15)
              .backgroundColor(0xF5F5F5)
              .borderRadius(8)
              .onClick(() => {
                this.onCopyText();
              });
          }
        }
        .padding(20);
      }
      .flexGrow(1);

      // 底部TabBar
      Row() {
        ForEach(this.tabs, (tab: TabItem, index: number) => {
          Column() {
            // 红点标记
            if (tab.name === '导航' && this.showRedDot) {
              Circle({ width: 8, height: 8 })
                .fill(Color.Red)
                .position({ x: 25, y: 0 });
            }

            Text(tab.icon)
              .fontSize(20);

            Text(tab.name)
              .fontSize(12)
              .fontColor(this.currentIndex === index ? Color.Blue : Color.Gray);
          }
          .width('25%')
          .height(60)
          .justifyContent(FlexAlign.Center)
          .onClick(() => {
            this.switchTab(index);
          });
        }, (tab: TabItem) => tab.name)
      }
      .width('100%')
      .height(60)
      .backgroundColor(Color.White)
      .border({ width: 1, color: 0xE0E0E0 }); // 修复border语法
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White);
  }
}