import router from '@ohos.router';

@Entry
@Component
struct SchedulePage {
  @State selectedDay: number = 0;

  private weekDays: string[] = ['周一', '周二', '周三', '周四', '周五','周六','周日'];

  build() {
    Column() {
      // 顶部标题栏
      Row() {
        Text('←')
          .fontSize(24)
          .margin({ left: 12 })
          .onClick(() => {
            router.back();
          })

        Text('我的课表')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .margin({ left: 16 })
          .flexGrow(1)

        Text('第17周')
          .fontSize(14)
          .fontColor(Color.Gray)
          .margin({ right: 16 })
      }
      .width('100%')
      .height(56)
      .backgroundColor('#FFFFFF')
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Center)
      .border({ width: { bottom: 1 }, color: '#E0E0E0' })

      // 日期选择
      Row() {
        ForEach(this.weekDays, (day: string, index: number) => {
          Column() {
            Text(day)
              .fontSize(16)
              .fontColor(this.selectedDay === index ? Color.Blue : Color.Gray)
              .fontWeight(this.selectedDay === index ? FontWeight.Bold : FontWeight.Normal)

            if (this.selectedDay === index) {
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
            this.selectedDay = index;
          })
        })
      }
      .width('100%')
      .height(50)
      .backgroundColor(Color.White)
      .border({ width: { bottom: 1 }, color: '#E0E0E0' })

      // 最简单的课表表格 - 直接写死数据
      Column() {
        // 周一课表
        if (this.selectedDay === 0) {
          Column() {
            Row() {
              Text('08:00-09:40')
                .width('30%')
                .textAlign(TextAlign.Center)
              Text('高等数学')
                .width('35%')
                .textAlign(TextAlign.Center)
              Text('7教101')
                .width('35%')
                .textAlign(TextAlign.Center)
            }
            .height(50)
            .border({ width: 1, color: '#E0E0E0' })

            Row() {
              Text('10:00-11:40')
                .width('30%')
                .textAlign(TextAlign.Center)
              Text('大学英语')
                .width('35%')
                .textAlign(TextAlign.Center)
              Text('7教202')
                .width('35%')
                .textAlign(TextAlign.Center)
            }
            .height(50)
            .border({ width: 1, color: '#E0E0E0' })

            Row() {
              Text('13:30-15:10')
                .width('30%')
                .textAlign(TextAlign.Center)
              Text('空闲')
                .width('35%')
                .textAlign(TextAlign.Center)
                .fontColor(Color.Gray)
              Text('-')
                .width('35%')
                .textAlign(TextAlign.Center)
            }
            .height(50)
            .border({ width: 1, color: '#E0E0E0' })

            Row() {
              Text('15:30-17:10')
                .width('30%')
                .textAlign(TextAlign.Center)
              Text('计算机基础')
                .width('35%')
                .textAlign(TextAlign.Center)
              Text('7教301')
                .width('35%')
                .textAlign(TextAlign.Center)
            }
            .height(50)
            .border({ width: 1, color: '#E0E0E0' })
          }
        }

        // 周二课表
        if (this.selectedDay === 1) {
          Column() {
            Row() {
              Text('08:00-09:40')
                .width('30%')
                .textAlign(TextAlign.Center)
              Text('空闲')
                .width('35%')
                .textAlign(TextAlign.Center)
                .fontColor(Color.Gray)
              Text('-')
                .width('35%')
                .textAlign(TextAlign.Center)
            }
            .height(50)
            .border({ width: 1, color: '#E0E0E0' })

            Row() {
              Text('10:00-11:40')
                .width('30%')
                .textAlign(TextAlign.Center)
              Text('数据结构')
                .width('35%')
                .textAlign(TextAlign.Center)
              Text('7教102')
                .width('35%')
                .textAlign(TextAlign.Center)
            }
            .height(50)
            .border({ width: 1, color: '#E0E0E0' })

            Row() {
              Text('13:30-15:10')
                .width('30%')
                .textAlign(TextAlign.Center)
              Text('软件测试')
                .width('35%')
                .textAlign(TextAlign.Center)
              Text('7教303')
                .width('35%')
                .textAlign(TextAlign.Center)
            }
            .height(50)
            .border({ width: 1, color: '#E0E0E0' })

            Row() {
              Text('15:30-17:10')
                .width('30%')
                .textAlign(TextAlign.Center)
              Text('空闲')
                .width('35%')
                .textAlign(TextAlign.Center)
                .fontColor(Color.Gray)
              Text('-')
                .width('35%')
                .textAlign(TextAlign.Center)
            }
            .height(50)
            .border({ width: 1, color: '#E0E0E0' })
          }
        }

        // 周三课表
        if (this.selectedDay === 2) {
          Column() {
            Row() {
              Text('08:00-09:40')
                .width('30%')
                .textAlign(TextAlign.Center)
              Text('操作系统')
                .width('35%')
                .textAlign(TextAlign.Center)
              Text('7教201')
                .width('35%')
                .textAlign(TextAlign.Center)
            }
            .height(50)
            .border({ width: 1, color: '#E0E0E0' })

            Row() {
              Text('10:00-11:40')
                .width('30%')
                .textAlign(TextAlign.Center)
              Text('空闲')
                .width('35%')
                .textAlign(TextAlign.Center)
                .fontColor(Color.Gray)
              Text('-')
                .width('35%')
                .textAlign(TextAlign.Center)
            }
            .height(50)
            .border({ width: 1, color: '#E0E0E0' })

            Row() {
              Text('13:30-15:10')
                .width('30%')
                .textAlign(TextAlign.Center)
              Text('数据库原理')
                .width('35%')
                .textAlign(TextAlign.Center)
              Text('7教303')
                .width('35%')
                .textAlign(TextAlign.Center)
            }
            .height(50)
            .border({ width: 1, color: '#E0E0E0' })

            Row() {
              Text('15:30-17:10')
                .width('30%')
                .textAlign(TextAlign.Center)
              Text('软件设计')
                .width('35%')
                .textAlign(TextAlign.Center)
              Text('7教105')
                .width('35%')
                .textAlign(TextAlign.Center)
            }
            .height(50)
            .border({ width: 1, color: '#E0E0E0' })
          }
        }
        if (this.selectedDay === 3) {
          Column() {
            Row() {
              Text('08:00-09:40')
                .width('30%')
                .textAlign(TextAlign.Center)
              Text('操作系统')
                .width('35%')
                .textAlign(TextAlign.Center)
              Text('7教201')
                .width('35%')
                .textAlign(TextAlign.Center)
            }
            .height(50)
            .border({ width: 1, color: '#E0E0E0' })

            Row() {
              Text('10:00-11:40')
                .width('30%')
                .textAlign(TextAlign.Center)
              Text('空闲')
                .width('35%')
                .textAlign(TextAlign.Center)
                .fontColor(Color.Gray)
              Text('-')
                .width('35%')
                .textAlign(TextAlign.Center)
            }
            .height(50)
            .border({ width: 1, color: '#E0E0E0' })

            Row() {
              Text('13:30-15:10')
                .width('30%')
                .textAlign(TextAlign.Center)
              Text('数据结构')
                .width('35%')
                .textAlign(TextAlign.Center)
              Text('7教303')
                .width('35%')
                .textAlign(TextAlign.Center)
            }
            .height(50)
            .border({ width: 1, color: '#E0E0E0' })

            Row() {
              Text('15:30-17:10')
                .width('30%')
                .textAlign(TextAlign.Center)
              Text('软件设计')
                .width('35%')
                .textAlign(TextAlign.Center)
              Text('7教105')
                .width('35%')
                .textAlign(TextAlign.Center)
            }
            .height(50)
            .border({ width: 1, color: '#E0E0E0' })
          }
        }
        if (this.selectedDay === 4) {
          Column() {
            Row() {
              Text('08:00-09:40')
                .width('30%')
                .textAlign(TextAlign.Center)
              Text('wbe前端')
                .width('35%')
                .textAlign(TextAlign.Center)
              Text('7教201')
                .width('35%')
                .textAlign(TextAlign.Center)
            }
            .height(50)
            .border({ width: 1, color: '#E0E0E0' })

            Row() {
              Text('10:00-11:40')
                .width('30%')
                .textAlign(TextAlign.Center)
              Text('空闲')
                .width('35%')
                .textAlign(TextAlign.Center)
                .fontColor(Color.Gray)
              Text('-')
                .width('35%')
                .textAlign(TextAlign.Center)
            }
            .height(50)
            .border({ width: 1, color: '#E0E0E0' })

            Row() {
              Text('13:30-15:10')
                .width('30%')
                .textAlign(TextAlign.Center)
              Text('数据库原理')
                .width('35%')
                .textAlign(TextAlign.Center)
              Text('7教303')
                .width('35%')
                .textAlign(TextAlign.Center)
            }
            .height(50)
            .border({ width: 1, color: '#E0E0E0' })

            Row() {
              Text('15:30-17:10')
                .width('30%')
                .textAlign(TextAlign.Center)
              Text('软件设计')
                .width('35%')
                .textAlign(TextAlign.Center)
              Text('7教105')
                .width('35%')
                .textAlign(TextAlign.Center)
            }
            .height(50)
            .border({ width: 1, color: '#E0E0E0' })
          }
        }
      }
      .width('100%')
      .flexGrow(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}