import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

// 定义参数类型接口
interface RouterParams {
  initialTab?: number;
}

// 个人信息数据类型
interface PersonalInfo {
  name: string;
  studentId: string;
  birthDate: string; // 出生年月日
  hometown: string;
  className: string;
}

@Entry
@Component
struct Services {
  @State currentTab: number = 0;
  private tabs: string[] = ['成绩查询', '图书查询', '选课查询', '个人资料'];

  // 个人信息数据
  @State personalInfo: PersonalInfo = {
    name: '谢英豪',
    studentId: '22240404748',
    birthDate: '2002年2月1日', // 改为出生年月日
    hometown: '广西玉林',
    className: '22计科7班'
  };

  // 编辑弹窗相关状态
  @State isEditDialogVisible: boolean = false;
  @State editField: string = '';
  @State editValue: string = '';

  // 编辑模式状态
  @State isEditMode: boolean = false;

  // 月份选择器数据
  private months: string[] = ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'];
  @State selectedMonthIndex: number = 1; // 2月的索引是1

  // 年份选择器数据 - 出生年份，从1900年到2024年
  private years: string[] = [];
  @State selectedYearIndex: number = 102; // 2002年的索引

  // 日期选择器数据 - 1到31日
  private days: string[] = [];
  @State selectedDayIndex: number = 0; // 1日的索引是0

  aboutToAppear() {
    // 初始化年份数组（1900-2024年）
    for (let i = 1900; i <= 2024; i++) {
      this.years.push(i + '年');
    }

    // 初始化日期数组（1-31日）
    for (let i = 1; i <= 31; i++) {
      this.days.push(i + '日');
    }

    const params = router.getParams() as RouterParams;
    if (params && params.initialTab !== undefined) {
      this.currentTab = params.initialTab - 1;
    }

    // 设置默认选中索引
    this.selectedYearIndex = 102; // 2002年
    this.selectedMonthIndex = 1; // 2月
    this.selectedDayIndex = 0; // 1日
  }

  // 打开编辑弹窗
  openEditDialog(field: string, value: string) {
    // 只有在编辑模式下才能打开编辑弹窗
    if (!this.isEditMode) {
      return;
    }

    this.editField = field;
    this.editValue = value;
    this.isEditDialogVisible = true;

    if (field === 'birthDate') {
      const dateMatch = value.match(/(\d{4})年(\d{1,2})月(\d{1,2})日/);
      if (dateMatch) {
        const year = dateMatch[1] + '年';
        const month = parseInt(dateMatch[2]) + '月';
        const day = parseInt(dateMatch[3]) + '日';

        // 查找年份索引
        const yearIndex = this.years.findIndex(y => y === year);
        if (yearIndex !== -1) {
          this.selectedYearIndex = yearIndex;
        }

        // 查找月份索引
        const monthIndex = this.months.findIndex(m => m === month);
        if (monthIndex !== -1) {
          this.selectedMonthIndex = monthIndex;
        }

        // 查找日期索引（注意日期是1-based，索引是0-based）
        const dayIndex = this.days.findIndex(d => d === day);
        if (dayIndex !== -1) {
          this.selectedDayIndex = dayIndex;
        }
      }
    }
  }

  // 保存编辑
  saveEdit() {
    if (this.editField === 'birthDate') {
      // 组合出生年月日
      const year = this.years[this.selectedYearIndex].replace('年', '');
      const month = this.months[this.selectedMonthIndex].replace('月', '');
      const day = this.days[this.selectedDayIndex].replace('日', '');
      this.personalInfo.birthDate = `${year}年${month}月${day}日`;

      try {
        promptAction.showToast({
          message: '出生日期已更新',
          duration: 2000
        });
      } catch (error) {
        console.error('showToast error:', error);
      }
    } else {
      switch (this.editField) {
        case 'name':
          this.personalInfo.name = this.editValue;
          break;
        case 'hometown':
          this.personalInfo.hometown = this.editValue;
          break;
        case 'className':
          this.personalInfo.className = this.editValue;
          break;
      }

      try {
        promptAction.showToast({
          message: '信息已更新',
          duration: 2000
        });
      } catch (error) {
        console.error('showToast error:', error);
      }
    }

    this.closeEditDialog();
  }

  // 关闭编辑弹窗
  closeEditDialog() {
    this.isEditDialogVisible = false;
    this.editValue = '';
  }

  // 切换编辑模式
  toggleEditMode() {
    this.isEditMode = !this.isEditMode;
    if (!this.isEditMode) {
      // 退出编辑模式时的提示
      try {
        promptAction.showToast({
          message: '已退出编辑模式',
          duration: 2000
        });
      } catch (error) {
        console.error('showToast error:', error);
      }
    }
  }

  build() {
    Stack() {
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

          // 右上角编辑/完成按钮
          if (this.currentTab === 3) {
            Text(this.isEditMode ? '完成' : '编辑')
              .fontSize(16)
              .fontColor(Color.Blue)
              .margin({ right: 16 })
              .onClick(() => {
                this.toggleEditMode();
              })
          }
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
              // 切换到其他标签页时，自动退出编辑模式
              if (index !== 3) {
                this.isEditMode = false;
              }
            })
          })
        }
        .width('100%')
        .height(50)
        .backgroundColor(Color.White)
        .border({ width: { bottom: 1 }, color: '#E0E0E0' })

        // 内容区域
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
            // 选课查询页面
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

              // 个人信息项目
              Column() {
                // 姓名 - 可编辑
                Row() {
                  Text('名字：')
                    .fontSize(14)
                    .fontWeight(FontWeight.Bold)
                  Text(this.personalInfo.name)
                    .fontSize(14)
                    .margin({ left: 8 })
                  Blank()
                  // 编辑按钮 - 根据编辑模式显示或隐藏
                  if (this.isEditMode) {
                    Text('编辑')
                      .fontSize(12)
                      .fontColor(Color.Blue)
                      .border({ width: 1, color: Color.Blue })
                      .borderRadius(4)
                      .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                      .onClick(() => {
                        this.openEditDialog('name', this.personalInfo.name);
                      })
                  }
                }
                .width('90%')
                .padding({ top: 12, bottom: 12 })
                .border({ width: { bottom: 1 }, color: '#E0E0E0' })

                // 学号 - 不可编辑
                Row() {
                  Text('学号：')
                    .fontSize(14)
                    .fontWeight(FontWeight.Bold)
                  Text(this.personalInfo.studentId)
                    .fontSize(14)
                    .margin({ left: 8 })
                  Blank()
                  Text('不可编辑')
                    .fontSize(12)
                    .fontColor(Color.Gray)
                }
                .width('90%')
                .padding({ top: 12, bottom: 12 })
                .border({ width: { bottom: 1 }, color: '#E0E0E0' })

                // 出生年月日 - 可编辑
                Row() {
                  Text('出生年月日：')
                    .fontSize(14)
                    .fontWeight(FontWeight.Bold)
                  Text(this.personalInfo.birthDate)
                    .fontSize(14)
                    .margin({ left: 8 })
                  Blank()
                  // 编辑按钮 - 根据编辑模式显示或隐藏
                  if (this.isEditMode) {
                    Text('编辑')
                      .fontSize(12)
                      .fontColor(Color.Blue)
                      .border({ width: 1, color: Color.Blue })
                      .borderRadius(4)
                      .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                      .onClick(() => {
                        this.openEditDialog('birthDate', this.personalInfo.birthDate);
                      })
                  }
                }
                .width('90%')
                .padding({ top: 12, bottom: 12 })
                .border({ width: { bottom: 1 }, color: '#E0E0E0' })

                // 户籍 - 可编辑
                Row() {
                  Text('户籍：')
                    .fontSize(14)
                    .fontWeight(FontWeight.Bold)
                  Text(this.personalInfo.hometown)
                    .fontSize(14)
                    .margin({ left: 8 })
                  Blank()
                  // 编辑按钮 - 根据编辑模式显示或隐藏
                  if (this.isEditMode) {
                    Text('编辑')
                      .fontSize(12)
                      .fontColor(Color.Blue)
                      .border({ width: 1, color: Color.Blue })
                      .borderRadius(4)
                      .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                      .onClick(() => {
                        this.openEditDialog('hometown', this.personalInfo.hometown);
                      })
                  }
                }
                .width('90%')
                .padding({ top: 12, bottom: 12 })
                .border({ width: { bottom: 1 }, color: '#E0E0E0' })

                // 班级 - 可编辑
                Row() {
                  Text('班级：')
                    .fontSize(14)
                    .fontWeight(FontWeight.Bold)
                  Text(this.personalInfo.className)
                    .fontSize(14)
                    .margin({ left: 8 })
                  Blank()
                  // 编辑按钮 - 根据编辑模式显示或隐藏
                  if (this.isEditMode) {
                    Text('编辑')
                      .fontSize(12)
                      .fontColor(Color.Blue)
                      .border({ width: 1, color: Color.Blue })
                      .borderRadius(4)
                      .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                      .onClick(() => {
                        this.openEditDialog('className', this.personalInfo.className);
                      })
                  }
                }
                .width('90%')
                .padding({ top: 12, bottom: 12 })
              }
              .padding(16)
              .backgroundColor(Color.White)
              .borderRadius(8)
              .margin({ left: 16, right: 16 })
              .border({ width: 1, color: '#E0E0E0' })
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

      // 编辑弹窗
      if (this.isEditDialogVisible) {
        // 半透明背景遮罩
        Column() {
          // 弹窗内容
          Column() {
            // 弹窗标题
            Text(this.editField === 'birthDate' ? '编辑出生日期' : '编辑信息')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .margin({ top: 24, bottom: 20 })

            if (this.editField === 'birthDate') {
              // 出生日期选择器 - 使用统一的滚动单选方式
              Column() {
                // 年份选择
                Text('选择年份：')
                  .fontSize(14)
                  .margin({ bottom: 8 })
                  .alignSelf(ItemAlign.Start)
                  .margin({ left: 24 })

                Scroll() {
                  Column() {
                    ForEach(this.years, (year: string, index: number) => {
                      Row() {
                        Radio({ value: year, group: 'year' })
                          .checked(this.selectedYearIndex === index)
                          .onChange((checked: boolean) => {
                            if (checked) {
                              this.selectedYearIndex = index;
                            }
                          })
                        Text(year)
                          .fontSize(14)
                          .fontColor(this.selectedYearIndex === index ? Color.Blue : Color.Black)
                          .margin({ left: 8 })
                      }
                      .width('100%')
                      .height(40)
                      .justifyContent(FlexAlign.Start)
                      .alignItems(VerticalAlign.Center)
                      .padding({ left: 16 })
                    })
                  }
                }
                .height(120)
                .width('80%')
                .border({ width: 1, color: '#E0E0E0' })
                .borderRadius(4)

                // 月份选择
                Text('选择月份：')
                  .fontSize(14)
                  .margin({ top: 16, bottom: 8 })
                  .alignSelf(ItemAlign.Start)
                  .margin({ left: 24 })

                Scroll() {
                  Column() {
                    ForEach(this.months, (month: string, index: number) => {
                      Row() {
                        Radio({ value: month, group: 'month' })
                          .checked(this.selectedMonthIndex === index)
                          .onChange((checked: boolean) => {
                            if (checked) {
                              this.selectedMonthIndex = index;
                            }
                          })
                        Text(month)
                          .fontSize(14)
                          .fontColor(this.selectedMonthIndex === index ? Color.Blue : Color.Black)
                          .margin({ left: 8 })
                      }
                      .width('100%')
                      .height(40)
                      .justifyContent(FlexAlign.Start)
                      .alignItems(VerticalAlign.Center)
                      .padding({ left: 16 })
                    })
                  }
                }
                .height(120)
                .width('80%')
                .border({ width: 1, color: '#E0E0E0' })
                .borderRadius(4)

                // 日期选择
                Text('选择日期：')
                  .fontSize(14)
                  .margin({ top: 16, bottom: 8 })
                  .alignSelf(ItemAlign.Start)
                  .margin({ left: 24 })

                Scroll() {
                  Column() {
                    ForEach(this.days, (day: string, index: number) => {
                      Row() {
                        Radio({ value: day, group: 'day' })
                          .checked(this.selectedDayIndex === index)
                          .onChange((checked: boolean) => {
                            if (checked) {
                              this.selectedDayIndex = index;
                            }
                          })
                        Text(day)
                          .fontSize(14)
                          .fontColor(this.selectedDayIndex === index ? Color.Blue : Color.Black)
                          .margin({ left: 8 })
                      }
                      .width('100%')
                      .height(40)
                      .justifyContent(FlexAlign.Start)
                      .alignItems(VerticalAlign.Center)
                      .padding({ left: 16 })
                    })
                  }
                }
                .height(120)
                .width('80%')
                .border({ width: 1, color: '#E0E0E0' })
                .borderRadius(4)

                // 预览
                Text('预览：' +
                this.years[this.selectedYearIndex].replace('年', '') + '年' +
                this.months[this.selectedMonthIndex].replace('月', '') + '月' +
                this.days[this.selectedDayIndex].replace('日', '') + '日')
                  .fontSize(14)
                  .margin({ top: 20 })
                  .fontColor(Color.Blue)
                  .fontWeight(FontWeight.Bold)
              }
              .width('100%')
              .alignItems(HorizontalAlign.Center)
            } else {
              // 输入框
              Column() {
                Text(this.editField === 'name' ? '姓名' :
                  this.editField === 'hometown' ? '户籍' : '班级')
                  .fontSize(14)
                  .margin({ bottom: 8 })
                  .alignSelf(ItemAlign.Start)
                  .margin({ left: 24 })

                // 输入框
                TextInput({
                  text: this.editValue,
                  placeholder: this.editField === 'name' ? '请输入姓名' :
                    this.editField === 'hometown' ? '请输入户籍' : '请输入班级'
                })
                  .width('80%')
                  .height(40)
                  .padding({ left: 8, right: 8 })
                  .backgroundColor(Color.White)
                  .border({ width: 1, color: '#E0E0E0' })
                  .borderRadius(4)
                  .onChange((value: string) => {
                    this.editValue = value;
                  })
              }
              .width('100%')
              .alignItems(HorizontalAlign.Center)
            }

            // 按钮区域
            Row() {
              Button('取消')
                .width('40%')
                .height(40)
                .backgroundColor(Color.White)
                .fontColor(Color.Black)
                .border({ width: 1, color: '#E0E0E0' })
                .onClick(() => {
                  this.closeEditDialog();
                })

              Button('保存')
                .width('40%')
                .height(40)
                .backgroundColor(Color.Blue)
                .fontColor(Color.White)
                .margin({ left: 16 })
                .onClick(() => {
                  this.saveEdit();
                })
            }
            .margin({ top: 32, bottom: 24 })
            .justifyContent(FlexAlign.Center)
          }
          .width('90%')
          .backgroundColor(Color.White)
          .borderRadius(8)
          .padding({ left: 16, right: 16 })
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor(0x80000000)
        .zIndex(10)
        .onClick(() => {
          this.closeEditDialog();
        })
      }
    }
    .width('100%')
    .height('100%')
  }
}