import promptAction from '@ohos.promptAction';

@Entry
@Component
struct Form {
  @State startPoint: string = '';
  @State endPoint: string = '';
  @State transportType: string = 'walking';
  @State selectedOptions: string[] = [];
  @State sliderValue: number = 5;
  @State additionalInfo: string = '';

  // 提交表单
  private onSubmit(): void {
    if (this.startPoint === '' || this.endPoint === '') {
      promptAction.showDialog({
        title: '提示',
        message: '请填写起点和终点'
      });
      return;
    }

    promptAction.showToast({
      message: '导航请求已提交',
      duration: 2000
    });
  }

  // 重置表单
  private onReset(): void {
    this.startPoint = '';
    this.endPoint = '';
    this.transportType = 'walking';
    this.selectedOptions = [];
    this.sliderValue = 5;
    this.additionalInfo = '';

    promptAction.showToast({
      message: '表单已重置',
      duration: 1500
    });
  }

  // 切换复选框
  private toggleOption(option: string): void {
    const index: number = this.selectedOptions.indexOf(option);
    if (index > -1) {
      const newOptions: string[] = [...this.selectedOptions];
      newOptions.splice(index, 1);
      this.selectedOptions = newOptions;
    } else {
      this.selectedOptions = [...this.selectedOptions, option];
    }
  }

  build() {
    Scroll() {
      Column({ space: 15 }) {
        Text('地图导航')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Blue);

        // 起点输入
        Column({ space: 5 }) {
          Text('起点位置')
            .fontSize(16);
          Text('请输入起点')
            .fontSize(12)
            .fontColor(Color.Gray);
          TextInput({ text: this.startPoint })
            .width('100%')
            .height(40)
            .backgroundColor(0xF5F5F5)
            .onChange((value: string) => {
              this.startPoint = value;
            });
        }

        // 终点输入
        Column({ space: 5 }) {
          Text('终点位置')
            .fontSize(16);
          Text('请输入终点')
            .fontSize(12)
            .fontColor(Color.Gray);
          TextInput({ text: this.endPoint })
            .width('100%')
            .height(40)
            .backgroundColor(0xF5F5F5)
            .onChange((value: string) => {
              this.endPoint = value;
            });
        }

        // 出行方式 (单选)
        Column({ space: 5 }) {
          Text('出行方式')
            .fontSize(16);
          Column() {
            // 步行
            Row() {
              Circle({ width: 20, height: 20 })
                .fill(this.transportType === 'walking' ? Color.Blue : Color.Gray);
              Text('步行')
                .fontSize(14)
                .margin({ left: 10 });
            }
            .onClick(() => {
              this.transportType = 'walking';
            })
            .padding(5);

            // 骑车
            Row() {
              Circle({ width: 20, height: 20 })
                .fill(this.transportType === 'bike' ? Color.Blue : Color.Gray);
              Text('骑车')
                .fontSize(14)
                .margin({ left: 10 });
            }
            .onClick(() => {
              this.transportType = 'bike';
            })
            .padding(5);

            // 驾车
            Row() {
              Circle({ width: 20, height: 20 })
                .fill(this.transportType === 'car' ? Color.Blue : Color.Gray);
              Text('驾车')
                .fontSize(14)
                .margin({ left: 10 });
            }
            .onClick(() => {
              this.transportType = 'car';
            })
            .padding(5);
          }
        }

        // 路线选项 (多选)
        Column({ space: 5 }) {
          Text('路线选项')
            .fontSize(16);
          Column() {
            // 避开拥堵
            Row() {
              Circle({ width: 20, height: 20 })
                .fill(this.selectedOptions.includes('避开拥堵') ? Color.Blue : Color.Gray);
              Text('避开拥堵')
                .fontSize(14)
                .margin({ left: 10 });
            }
            .onClick(() => {
              this.toggleOption('避开拥堵');
            })
            .padding(5);

            // 高速优先
            Row() {
              Circle({ width: 20, height: 20 })
                .fill(this.selectedOptions.includes('高速优先') ? Color.Blue : Color.Gray);
              Text('高速优先')
                .fontSize(14)
                .margin({ left: 10 });
            }
            .onClick(() => {
              this.toggleOption('高速优先');
            })
            .padding(5);
          }
        }

        // 偏好设置 (滑块)
        Column({ space: 5 }) {
          Text('偏好设置：' + this.sliderValue)
            .fontSize(16);
          Slider({
            value: this.sliderValue,
            min: 0,
            max: 10,
            step: 1
          })
            .width('100%')
            .onChange((value: number) => {
              this.sliderValue = value;
            });
        }

        // 附加信息 (文本域)
        Column({ space: 5 }) {
          Text('附加信息')
            .fontSize(16);
          Text('请输入备注信息...')
            .fontSize(12)
            .fontColor(Color.Gray);
          TextArea({ text: this.additionalInfo })
            .width('100%')
            .height(80)
            .backgroundColor(0xF5F5F5)
            .onChange((value: string) => {
              this.additionalInfo = value;
            });
        }

        // 按钮区域 - 使用正确的Button语法
        Row({ space: 20 }) {
          // 提交按钮
          Button() {
            Text('提交')
              .fontSize(16);
          }
          .width(120)
          .height(40)
          .backgroundColor(Color.Blue)
          .onClick(() => {
            this.onSubmit();
          });

          // 重置按钮
          Button() {
            Text('重置')
              .fontSize(16);
          }
          .width(120)
          .height(40)
          .backgroundColor(Color.Gray)
          .onClick(() => {
            this.onReset();
          });
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .margin({ top: 20 });
      }
      .padding(20);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White);
  }
}