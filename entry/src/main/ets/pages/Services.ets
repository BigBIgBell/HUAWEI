import router from '@ohos.router';

// 定义参数类型接口
interface RouterParams {
  initialTab?: number;
}

@Entry
@Component
struct Services {
  @State currentTab: number = 0;
  // 1. 把tabs数组中的“学生信息”改为“选课查询”
  private tabs: string[] = ['成绩查询', '图书查询', '选课查询', '个人资料'];

  onPageShow() {
    // 获取传递的参数，使用定义好的接口
    const params = router.getParams() as RouterParams;
    if (params && params.initialTab) {
      // 参数中的tabIndex是从1开始的，而数组索引是从0开始的
      this.currentTab = params.initialTab - 1;
    }
  }

  build() {
    Column() {
      // 顶部标题
      Row() {
        Text('←')
          .fontSize(24)
          .margin({ left: 12 })
          .onClick(() => {
            router.back();
          })

        Text('服务大厅')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .margin({ left: 16 })
          .flexGrow(1)
      }
      .width('100%')
      .height(56)
      .backgroundColor('#FFFFFF')
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Center)
      .border({ width: { bottom: 1 }, color: '#E0E0E0' })

      // Tab切换
      Row() {
        ForEach(this.tabs, (tab: string, index: number) => {
          Column() {
            Text(tab)
              .fontSize(16)
              .fontColor(this.currentTab === index ? Color.Blue : Color.Gray)
              .fontWeight(this.currentTab === index ? FontWeight.Bold : FontWeight.Normal)

            if (this.currentTab === index) {
              Divider()
                .color(Color.Blue)
                .strokeWidth(2)
                .width(40)
                .margin({ top: 4 })
            }
          }
          .height(50)
          .flexGrow(1)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .onClick(() => {
            this.currentTab = index;
          })
        })
      }
      .width('100%')
      .height(50)
      .backgroundColor(Color.White)
      .border({ width: { bottom: 1 }, color: '#E0E0E0' })

      // 内容区域 - 根据currentTab显示不同内容
      Column() {
        if (this.currentTab === 0) {
          // 成绩查询页面
          Column() {
            Text('成绩查询')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .margin({ top: 30, bottom: 20 })

            Column() {
              Text('学期：2023-2024学年 第二学期')
                .fontSize(14)
                .margin({ bottom: 8 })
              Text('总学分：85')
                .fontSize(14)
                .margin({ bottom: 8 })
              Text('平均绩点：3.5')
                .fontSize(14)
                .margin({ bottom: 8 })
              Text('班级排名：15/120')
                .fontSize(14)
            }
            .padding(16)
            .backgroundColor(0xF5F5F5)
            .borderRadius(8)
            .margin({ left: 16, right: 16 })
          }
        } else if (this.currentTab === 1) {
          // 图书查询页面
          Column() {
            Text('图书查询')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .margin({ top: 30, bottom: 20 })

            Column() {
              Text('已借阅图书：5本')
                .fontSize(14)
                .margin({ bottom: 8 })
              Text('归还期限：2024-06-30')
                .fontSize(14)
                .margin({ bottom: 8 })
              Text('可借阅数：10本')
                .fontSize(14)
                .margin({ bottom: 8 })
            }
            .padding(16)
            .backgroundColor(0xF5F5F5)
            .borderRadius(8)
            .margin({ left: 16, right: 16 })
          }
        } else if (this.currentTab === 2) {
          // 2. 替换为选课查询页面（简化版）
          Column() {
            Text('选课查询')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .margin({ top: 30, bottom: 20 })

            Column() {
              Text('已选课程：6门')
                .fontSize(14)
                .margin({ bottom: 8 })
              Text('已修学分：24')
                .fontSize(14)
                .margin({ bottom: 8 })
              Text('剩余选课名额：2门')
                .fontSize(14)
            }
            .padding(16)
            .backgroundColor(0xF5F5F5)
            .borderRadius(8)
            .margin({ left: 16, right: 16 })
          }
        } else if (this.currentTab === 3) {
          // 个人资料页面
          Column() {
            Text('个人资料')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .margin({ top: 30, bottom: 20 })

            Column() {
              Text('名字：谢英豪')
                .fontSize(14)
                .margin({ bottom: 8 })
              Text('学号：22240404748')
                .fontSize(14)
                .margin({ bottom: 8 })

              Text('出入年月：2002年2月')
                .fontSize(14)
                .margin({ bottom: 8 })
              Text('户籍：广西玉林')
                .fontSize(14)
                .margin({ bottom: 8 })

              Text('班级：22计科7班')
                .fontSize(14)
            }
            .padding(16)
            .backgroundColor(0xF5F5F5)
            .borderRadius(8)
            .margin({ left: 16, right: 16 })
          }
        }
      }
      .flexGrow(1)
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}