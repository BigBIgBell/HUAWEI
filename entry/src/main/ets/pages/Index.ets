import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

// 定义类型
interface TabItem {
  name: string;
  icon: string;
  page: string;
}

interface ServiceTabItem {
  name: string;
  icon: string;
  tabIndex: number;
}

@Entry
@Component
struct Index {
  @State currentIndex: number = 0;
  @State showRedDot: boolean = true;

  // 底部导航Tabs - 将导航改为课表
  private tabs: TabItem[] = [
    { name: '首页', icon: '🏠', page: 'Index' },
    { name: '课表', icon: '📅', page: 'SchedulePage' },
    { name: '地图', icon: '📍', page: 'MapPage' },
    { name: '服务', icon: '🎓', page: 'Services' }
  ];

  // 轮播图 - 改为图片资源
  private banners: Resource[] = [
    $r('app.media.banner1'), // 第一张轮播图
    $r('app.media.banner2'), // 第二张轮播图
    $r('app.media.banner3')  // 第三张轮播图
  ];

  // 快捷功能
  private serviceTabs: ServiceTabItem[] = [
    { name: '成绩查询', icon: '📊', tabIndex: 1 },
    { name: '图书查询', icon: '📚', tabIndex: 2 },
    { name: '选课查询', icon: '👨‍🎓', tabIndex: 3 },
    { name: '个人信息', icon: '📝', tabIndex: 4 }
  ];

  private copyText: string = '校园热线：400-123-4567';
  private recommendations: string[] = ['讲座', '比赛', '招聘', '活动', '新闻'];

  // 切换Tab
  private switchTab(index: number): void {
    try {
      this.currentIndex = index;
      const page = this.tabs[index].page;
      if (page !== 'Index') {
        router.pushUrl({ url: `pages/${page}` });
      }
    } catch (error) {
      console.error('切换Tab错误:', error);
    }
  }

  // 点击服务快捷功能
  private onServiceTabClick(tabIndex: number): void {
    try {
      const serviceName = this.serviceTabs[tabIndex - 1].name;
      promptAction.showToast({
        message: `切换到${serviceName}`,
        duration: 1500
      });

      router.pushUrl({
        url: 'pages/Services',
        params: { initialTab: tabIndex }
      });
    } catch (error) {
      console.error('服务功能点击错误:', error);
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
      // 页面内容 - 使用Stack确保内容适应屏幕
      Stack() {
        Column() {
          // 1. 轮播图 - 改为Image组件
          Swiper() {
            ForEach(this.banners, (item: Resource, index: number) => {
              Image(item)
                .width('100%')
                .height(120)
                .objectFit(ImageFit.Cover)
            }, (item: Resource, index: number) => `banner-${index}`)
          }
          .width('100%')
          .height(120)
          .indicator(true)
          .loop(true)
          .margin({ top: 10 });

          // 2. 横向滚动区
          Column() {
            Text('热门推荐')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .margin({ top: 10, bottom: 8, left: 12 });

            Scroll() {
              Row() {
                ForEach(this.recommendations, (item: string) => {
                  Column() {
                    Text(item)
                      .fontSize(14)
                      .fontColor(Color.White);
                  }
                  .width(100)
                  .height(60)
                  .backgroundColor(Color.Blue)
                  .borderRadius(6)
                  .margin({ right: 8 })
                  .justifyContent(FlexAlign.Center);
                }, (item: string) => item)
              }
              .padding({ left: 12, right: 12 });
            }
            .scrollable(ScrollDirection.Horizontal)
            .height(70);
          }

          // 3. 快捷功能入口
          Column() {
            Text('快捷功能')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .margin({ top: 10, bottom: 8, left: 12 });

            Grid() {
              ForEach(this.serviceTabs, (item: ServiceTabItem) => {
                GridItem() {
                  Column() {
                    // 图标
                    Stack() {
                      Circle({ width: 40, height: 40 })
                        .fill(Color.Blue);
                      Text(item.icon)
                        .fontSize(16);
                    }
                    .margin({ bottom: 4 });

                    Text(item.name)
                      .fontSize(12)
                      .margin({ top: 2 });
                  }
                  .onClick(() => {
                    this.onServiceTabClick(item.tabIndex);
                  })
                  .justifyContent(FlexAlign.Center)
                  .alignItems(HorizontalAlign.Center)
                  .height(90);
                }
              }, (item: ServiceTabItem) => `${item.name}-${item.tabIndex}`)
            }
            .columnsTemplate('1fr 1fr')
            .rowsTemplate('1fr 1fr')
            .columnsGap(10)
            .rowsGap(10)
            .height(200)
            .margin({ bottom: 10, left: 12, right: 12 });
          }

          // 4. 富文本展示区
          Column() {
            Text('校园公告')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .margin({ bottom: 8, left: 12 });

            Column() {
              Text('重要通知')
                .fontSize(14)
                .fontColor(Color.Red)
                .fontWeight(FontWeight.Bold);
              Text('系统维护通知')
                .fontSize(12)
                .margin({ top: 4 });
              Text('时间：周末00:00-06:00')
                .fontSize(10)
                .fontColor(Color.Gray)
                .margin({ top: 4 });
            }
            .padding(12)
            .backgroundColor(0xF5F5F5)
            .borderRadius(8)
            .margin({ left: 12, right: 12 });
          }

          // 5. 文字复制功能
          Column() {
            Text('联系方式')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .margin({ top: 10, bottom: 8, left: 12 });

            Text(this.copyText)
              .fontSize(12)
              .padding(12)
              .backgroundColor(0xF5F5F5)
              .borderRadius(8)
              .margin({ left: 12, right: 12 })
              .onClick(() => {
                this.onCopyText();
              });
          }
          .margin({ bottom: 12 });
        }
        .width('100%')
      }
      .flexGrow(1)

      // 底部TabBar
      Row() {
        ForEach(this.tabs, (tab: TabItem, index: number) => {
          Column() {
            // 红点标记
            if (tab.name === '课表' && this.showRedDot) {
              Circle({ width: 6, height: 6 })
                .fill(Color.Red)
                .position({ x: 20, y: 0 });
            }

            Text(tab.icon)
              .fontSize(18);

            Text(tab.name)
              .fontSize(10)
              .fontColor(this.currentIndex === index ? Color.Blue : Color.Gray)
              .margin({ top: 2 });
          }
          .width('25%')
          .height(50)
          .justifyContent(FlexAlign.Center)
          .onClick(() => {
            this.switchTab(index);
          });
        }, (tab: TabItem) => tab.name)
      }
      .width('100%')
      .height(50)
      .backgroundColor(Color.White)
      .border({ width: 1, color: 0xE0E0E0 });
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White);
  }
}