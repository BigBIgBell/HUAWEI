import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import { BusinessError } from '@ohos.base';

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

interface User {
  studentId: string;
  password: string;
}

@Entry
@Component
struct Index {
  @State currentIndex: number = 0;
  @State showRedDot: boolean = true;
  @State isLoggedIn: boolean = false;
  @State studentId: string = '';
  @State password: string = '';

  private tabs: Array<TabItem> = [
    { name: '测试', icon: '💬', page: 'SubPage' },
    { name: '课表', icon: '📅', page: 'SchedulePage' },
    { name: '地图', icon: '📍', page: 'MapPage' },
    { name: '服务', icon: '🎓', page: 'Services' }
  ];

  // 轮播图
  private banners: Array<Resource> = [
    $r('app.media.banner1'),
    $r('app.media.banner2'),
    $r('app.media.banner3')
  ];

  // 快捷功能
  private serviceTabs: Array<ServiceTabItem> = [
    { name: '成绩查询', icon: '📊', tabIndex: 1 },
    { name: '图书查询', icon: '📚', tabIndex: 2 },
    { name: '选课查询', icon: '👨‍🎓', tabIndex: 3 },
    { name: '个人信息', icon: '📝', tabIndex: 4 }
  ];

  private copyText: string = '校园热线：400-123-4567';
  private recommendations: Array<string> = ['讲座', '比赛', '招聘', '活动', '新闻'];

  // 模拟用户数据
  private mockUsers: Array<User> = [
    { studentId: '2224040738', password: '123456' },
    { studentId: '2224040701', password: '123456' },
    { studentId: '2224040702', password: '123456' }
  ];

  // 切换Tab
  private switchTab(index: number): void {
    try {
      this.currentIndex = index;

      // 如果点击的是课表Tab（索引为1），清除红点
      if (index === 1) {
        this.showRedDot = false;
      }

      const page = this.tabs[index].page;
      if (page !== 'Index') {
        router.pushUrl({
          url: `pages/${page}`
        } as router.RouterOptions).then(() => {
          console.log('页面跳转成功');
        }).catch((err: BusinessError) => {
          console.error('页面跳转失败:', err);
        });
      }
    } catch (error) {
      console.error('切换Tab错误:', error);
    }
  }

  // 点击服务快捷功能
  private onServiceTabClick(tabIndex: number): void {
    try {
      const serviceItem = this.serviceTabs.find((item: ServiceTabItem) => item.tabIndex === tabIndex);
      const serviceName = serviceItem?.name || '未知功能';

      promptAction.showToast({
        message: `切换到${serviceName}`,
        duration: 1500
      });

      router.pushUrl({
        url: 'pages/Services',
        params: { initialTab: tabIndex }
      } as router.RouterOptions).then(() => {
        console.log('跳转到服务页面成功');
      }).catch((err: BusinessError) => {
        console.error('跳转到服务页面失败:', err);
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

  // 显示提示信息
  private showToast(message: string): void {
    try {
      promptAction.showToast({
        message: message,
        duration: 1500
      });
    } catch (error) {
      console.error('显示提示信息错误:', error);
    }
  }

  // 处理登录
  private handleLogin(): void {
    try {
      // 验证输入
      if (!this.studentId.trim() || !this.password.trim()) {
        this.showToast('请输入学号和密码');
        return;
      }

      // 模拟登录验证
      const user = this.mockUsers.find(u =>
      u.studentId === this.studentId && u.password === this.password
      );

      if (user) {
        // 登录成功
        this.isLoggedIn = true;
        this.showToast('登录成功！');

        // 保存登录状态（实际应用中应该使用更安全的存储方式）
        console.log('用户登录成功:', this.studentId);
      } else {
        // 登录失败
        this.showToast('学号或密码错误');
      }
    } catch (error) {
      console.error('登录处理错误:', error);
      this.showToast('登录失败，请重试');
    }
  }

  // 构建登录遮罩层
  @Builder
  buildLoginOverlay() {
    Stack({ alignContent: Alignment.Center }) {
      // 半透明背景
      Image($r('app.media.login_logo')) // 使用资源管理器中的图片
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Cover) // 设置图片填充模式
      // 登录框
      Column() {
        // 标题
        Text('校园助手登录')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ bottom: 30 });

        // 学号输入框
        Column() {
          Text('学号')
            .fontSize(14)
            .fontColor(Color.Black)
            .margin({ bottom: 5 });

          TextInput({
            text: this.studentId,
            placeholder: '请输入学号'
          })
            .width('100%')
            .height(40)
            .backgroundColor(Color.White)
            .borderRadius(6)
            .padding({ left: 10, right: 10 })
            .type(InputType.Normal)
            .onChange((value: string) => {
              this.studentId = value;
            });
        }
        .margin({ bottom: 20 });

        // 密码输入框
        Column() {
          Text('密码')
            .fontSize(14)
            .fontColor(Color.Black)
            .margin({ bottom: 5 });

          TextInput({
            text: this.password,
            placeholder: '请输入密码'
          })
            .width('100%')
            .height(40)
            .backgroundColor(Color.White)
            .borderRadius(6)
            .padding({ left: 10, right: 10 })
            .type(InputType.Password)
            .onChange((value: string) => {
              this.password = value;
            });
        }
        .margin({ bottom: 30 });

        // 登录按钮
        Button('登录', { type: ButtonType.Capsule })
          .width('80%')
          .height(40)
          .backgroundColor(Color.Blue)
          .fontColor(Color.White)
          .fontSize(16)
          .onClick(() => {
            this.handleLogin();
          });

        // 提示信息
        Text('测试账号：2224040738 密码：123456')
          .fontSize(12)
          .fontColor(Color.Gray)
          .margin({ top: 20 });
      }
      .width('80%')
      .padding(30)
      .backgroundColor('rgba(255, 255, 255, 0.85)')
      .borderRadius(15)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
    .position({ x: 0, y: 0 })
    .zIndex(999)
  }

  // 构建主页面内容
  @Builder
  buildMainContent() {
    Column() {
      Stack() {
        Column() {
          // 1. 轮播图
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

            Scroll() {
              Row() {
                ForEach(this.serviceTabs, (item: ServiceTabItem) => {
                  Column() {
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
                  .width(80)
                  .height(90)
                  .margin({ right: 15 })
                }, (item: ServiceTabItem) => `${item.name}-${item.tabIndex}`)
              }
              .padding({ left: 12, right: 12 })
            }
            .scrollable(ScrollDirection.Horizontal)
            .height(100)
            .margin({ bottom: 10 })
          }

          // 4. 校园公告
          Column() {
            Text('校园公告')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .margin({ top: 10, bottom: 10, left: 12 });

            Column() {
              Text('重要通知')
                .fontSize(16)
                .fontColor(Color.Red)
                .fontWeight(FontWeight.Bold)
                .margin({ bottom: 6 });
              Text('系统维护通知')
                .fontSize(14)
                .margin({ top: 4 });
              Text('时间：周末00:00-06:00')
                .fontSize(12)
                .fontColor(Color.Gray)
                .margin({ top: 6, bottom: 4 });
              Text('维护范围：成绩查询、选课系统、图书借阅系统')
                .fontSize(12)
                .fontColor(Color.Gray)
                .margin({ top: 6 });
            }
            .padding(20)
            .backgroundColor(0xF5F5F5)
            .borderRadius(8)
            .margin({ left: 12, right: 12 })
            .width('95%')
            .height(180)
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

  build() {
    Stack() {
      // 主页面内容
      this.buildMainContent();

      // 如果未登录，显示登录遮罩
      if (!this.isLoggedIn) {
        this.buildLoginOverlay();
      }
    }
    .width('100%')
    .height('100%');
  }
}