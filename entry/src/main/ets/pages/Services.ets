import promptAction from '@ohos.promptAction';

// 定义学生信息类型
interface StudentInfo {
  name: string;
  studentId: string;
  gender: string;
  birthDate: string;
  hometown: string;
  className: string;
  phone: string;
  email: string;
}

// 日期选择器状态
interface DatePickerState {
  showYearPicker: boolean;
  showMonthPicker: boolean;
  showDayPicker: boolean;
  selectedYear: string;
  selectedMonth: string;
  selectedDay: string;
}

@Entry
@Component
struct Services {
  @State tab: number = 1;
  @State studentId: string = '2224040738';
  @State searchText: string = '';
  @State regionSearchText: string = ''; // 单独的地域搜索文本

  // 学生信息
  @State studentInfo: StudentInfo = {
    name: '谢英豪',
    studentId: '2224040738',
    gender: '男',
    birthDate: '2002-02-12',
    hometown: '北京市',
    className: '计算机科学与技术7班',
    phone: '17377081423',
    email: '1679332820@qq.com'
  };

  // 编辑状态
  @State isEditing: boolean = false;
  @State showDatePicker: boolean = false;
  @State showRegionPicker: boolean = false;

  // 日期选择器状态
  @State datePickerState: DatePickerState = {
    showYearPicker: true,
    showMonthPicker: false,
    showDayPicker: false,
    selectedYear: '2002',
    selectedMonth: '02',
    selectedDay: '12'
  };

  // 生成年份列表 (1980-2024)
  private yearOptions: string[] = [];
  // 生成月份列表 (01-12)
  private monthOptions: string[] = ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'];
  // 生成日期列表 (01-31)
  private dayOptions: string[] = [];

  // 性别选项
  private genderOptions: string[] = ['男', '女'];

  // 省份选项
  private provinceOptions: string[] = [
    '北京市', '上海市', '天津市', '重庆市',
    '河北省', '山西省', '辽宁省', '吉林省', '黑龙江省',
    '江苏省', '浙江省', '安徽省', '福建省', '江西省', '山东省',
    '河南省', '湖北省', '湖南省', '广东省', '海南省',
    '四川省', '贵州省', '云南省', '陕西省', '甘肃省',
    '青海省', '台湾省',
    '内蒙古自治区', '广西壮族自治区', '西藏自治区',
    '宁夏回族自治区', '新疆维吾尔自治区',
    '香港特别行政区', '澳门特别行政区'
  ];

  // 班级选项
  private classOptions: string[] = [
    '计算机科学与技术1班',
    '计算机科学与技术2班',
    '计算机科学与技术3班',
    '计算机科学与技术4班',
    '计算机科学与技术5班',
    '计算机科学与技术6班',
    '计算机科学与技术7班',

  ];

  // 初始化
  aboutToAppear() {
    // 生成年份列表 (1980-2024)
    for (let year = 1980; year <= 2024; year++) {
      this.yearOptions.push(year.toString());
    }

    // 生成日期列表 (01-31)
    for (let day = 1; day <= 31; day++) {
      this.dayOptions.push(day < 10 ? '0' + day.toString() : day.toString());
    }

    // 初始化日期选择器
    const dateParts = this.studentInfo.birthDate.split('-');
    if (dateParts.length >= 3) {
      this.datePickerState.selectedYear = dateParts[0];
      this.datePickerState.selectedMonth = dateParts[1];
      this.datePickerState.selectedDay = dateParts[2];
    }
  }

  // 切换标签页
  private switchTab(index: number): void {
    this.tab = index;
  }

  // 查询成绩 - 添加try-catch
  private queryScore(): void {
    try {
      promptAction.showToast({
        message: '查询学号：' + this.studentId,
        duration: 1500
      });
    } catch (error) {
      console.error('查询错误:', error);
    }
  }

  // 搜索图书 - 添加try-catch
  private searchBook(): void {
    try {
      promptAction.showToast({
        message: '搜索：' + this.searchText,
        duration: 1500
      });
    } catch (error) {
      console.error('搜索错误:', error);
    }
  }

  // 保存个人信息 - 添加try-catch
  private saveProfile(): void {
    try {
      promptAction.showToast({
        message: '个人信息已保存',
        duration: 1500
      });
      this.isEditing = false;
    } catch (error) {
      console.error('保存错误:', error);
    }
  }

  // 显示日期选择器
  private showDatePickerDialog(): void {
    this.showDatePicker = true;
    this.datePickerState.showYearPicker = true;
    this.datePickerState.showMonthPicker = false;
    this.datePickerState.showDayPicker = false;
  }

  // 显示地域选择器
  private showRegionPickerDialog(): void {
    this.showRegionPicker = true;
    this.regionSearchText = ''; // 清空搜索文本
  }

  // 选择年份
  private selectYear(year: string): void {
    this.datePickerState.selectedYear = year;
    this.datePickerState.showYearPicker = false;
    this.datePickerState.showMonthPicker = true;
  }

  // 选择月份
  private selectMonth(month: string): void {
    this.datePickerState.selectedMonth = month;
    this.datePickerState.showMonthPicker = false;
    this.datePickerState.showDayPicker = true;
  }

  // 选择日期
  private selectDay(day: string): void {
    this.datePickerState.selectedDay = day;
    this.studentInfo.birthDate = `${this.datePickerState.selectedYear}-${this.datePickerState.selectedMonth}-${this.datePickerState.selectedDay}`;
    this.showDatePicker = false;
  }

  // 取消日期选择
  private cancelDatePicker(): void {
    this.showDatePicker = false;
    // 恢复原始状态
    this.datePickerState.showYearPicker = true;
    this.datePickerState.showMonthPicker = false;
    this.datePickerState.showDayPicker = false;
  }

  // 筛选省份的方法
  private getFilteredProvinces(): string[] {
    if (this.regionSearchText === '') {
      return this.provinceOptions;
    }
    return this.provinceOptions.filter(province =>
    province.includes(this.regionSearchText)
    );
  }

  build() {
    Column() {
      // 标题
      Text('校园服务')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Blue)
        .margin({ top: 20, bottom: 20 });

      // 标签页切换
      Row() {
        Button('成绩查询')
          .width('25%')
          .backgroundColor(this.tab === 1 ? Color.Blue : Color.White)
          .fontColor(this.tab === 1 ? Color.White : Color.Black)
          .onClick(() => {
            this.switchTab(1);
          });

        Button('图书查询')
          .width('25%')
          .backgroundColor(this.tab === 2 ? Color.Blue : Color.White)
          .fontColor(this.tab === 2 ? Color.White : Color.Black)
          .onClick(() => {
            this.switchTab(2);
          });

        Button('学生信息')
          .width('25%')
          .backgroundColor(this.tab === 3 ? Color.Blue : Color.White)
          .fontColor(this.tab === 3 ? Color.White : Color.Black)
          .onClick(() => {
            this.switchTab(3);
          });

        Button('个人资料')
          .width('25%')
          .backgroundColor(this.tab === 4 ? Color.Blue : Color.White)
          .fontColor(this.tab === 4 ? Color.White : Color.Black)
          .onClick(() => {
            this.switchTab(4);
          });
      }
      .width('100%')
      .height(50);

      // 内容区域
      Scroll() {
        Column() {
          if (this.tab === 1) {
            // 成绩查询
            this.buildScoreTab();
          } else if (this.tab === 2) {
            // 图书查询
            this.buildBookTab();
          } else if (this.tab === 3) {
            // 学生信息
            this.buildStudentTab();
          } else {
            // 个人资料编辑
            this.buildProfileTab();
          }
        }
        .padding(10);
      }
      .height('75%');
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White);
  }

  @Builder
  buildScoreTab() {
    Column() {
      // 学号输入
      Row() {
        TextInput({ text: this.studentId })
          .width('70%')
          .height(40)
          .padding(10)
          .backgroundColor(0xF5F5F5)
          .borderRadius(5)
          .onChange((value: string) => {
            this.studentId = value;
          });

        Button() {
          Text('查询')
            .fontSize(16);
        }
        .width(80)
        .height(40)
        .margin({ left: 10 })
        .backgroundColor(Color.Blue)
        .onClick(() => {
          this.queryScore();
        });
      }
      .margin({ bottom: 20 });

      // 成绩表格
      Column() {
        // 表头
        Row() {
          Text('课程')
            .width('40%')
            .fontWeight(FontWeight.Bold);
          Text('成绩')
            .width('30%')
            .fontWeight(FontWeight.Bold);
          Text('学分')
            .width('30%')
            .fontWeight(FontWeight.Bold);
        }
        .padding(10)
        .backgroundColor(0xE6F7FF);

        // 数据行
        Row() {
          Text('高等数学')
            .width('40%');
          Text('92')
            .width('30%');
          Text('4')
            .width('30%');
        }
        .padding(10);

        Row() {
          Text('大学英语')
            .width('40%');
          Text('88')
            .width('30%');
          Text('3')
            .width('30%');
        }
        .padding(10);

        Row() {
          Text('程序设计')
            .width('40%');
          Text('95')
            .width('30%');
          Text('4')
            .width('30%');
        }
        .padding(10);

        // 平均分
        Row() {
          Text('平均分')
            .width('40%')
            .fontWeight(FontWeight.Bold);
          Text('91.7')
            .width('30%')
            .fontColor(Color.Blue)
            .fontWeight(FontWeight.Bold);
          Text('11')
            .width('30%');
        }
        .padding(10)
        .backgroundColor(0xFAFAFA);
      }
      .border({ width: 1, color: Color.Gray })
      .borderRadius(5);
    }
  }

  @Builder
  buildBookTab() {
    Column() {
      // 搜索框
      Row() {
        TextInput({ text: this.searchText })
          .width('70%')
          .height(40)
          .padding(10)
          .backgroundColor(0xF5F5F5)
          .borderRadius(5)
          .onChange((value: string) => {
            this.searchText = value;
          });

        Button() {
          Text('搜索')
            .fontSize(16);
        }
        .width(80)
        .height(40)
        .margin({ left: 10 })
        .backgroundColor(Color.Blue)
        .onClick(() => {
          this.searchBook();
        });
      }
      .margin({ bottom: 20 });

      // 图书列表
      Column() {
        // 第一本书
        Column() {
          Text('深入理解计算机系统')
            .fontSize(16)
            .fontWeight(FontWeight.Bold);
          Text('作者：Randal E. Bryant')
            .fontSize(14)
            .fontColor(Color.Gray);
          Text('可借阅 3/10 本')
            .fontSize(12)
            .fontColor(Color.Green);
        }
        .padding(10)
        .backgroundColor(Color.White)
        .margin({ bottom: 10 })
        .border({ width: 1, color: Color.Gray })
        .borderRadius(5);

        // 第二本书
        Column() {
          Text('算法导论')
            .fontSize(16)
            .fontWeight(FontWeight.Bold);
          Text('作者：Thomas H. Cormen')
            .fontSize(14)
            .fontColor(Color.Gray);
          Text('可借阅 2/8 本')
            .fontSize(12)
            .fontColor(Color.Green);
        }
        .padding(10)
        .backgroundColor(Color.White)
        .margin({ bottom: 10 })
        .border({ width: 1, color: Color.Gray })
        .borderRadius(5);
      }
    }
  }

  @Builder
  buildStudentTab() {
    Column() {
      // 头像和信息
      Row() {
        // 头像
        Stack() {
          Circle({ width: 60, height: 60 })
            .fill(Color.Blue);
          Text('张')
            .fontSize(24)
            .fontColor(Color.White);
        }
        .margin({ right: 15 });

        Column() {
          Text(this.studentInfo.name)
            .fontSize(20)
            .fontWeight(FontWeight.Bold);
          Text(this.studentInfo.className)
            .fontSize(14)
            .fontColor(Color.Gray);
        }
      }
      .margin({ bottom: 20 });

      // 详细信息
      Column() {
        // 学号
        Row() {
          Text('学号：')
            .width(60)
            .fontColor(Color.Gray);
          Text(this.studentInfo.studentId);
        }
        .padding(10);

        // 性别
        Row() {
          Text('性别：')
            .width(60)
            .fontColor(Color.Gray);
          Text(this.studentInfo.gender);
        }
        .padding(10);

        // 出生日期
        Row() {
          Text('生日：')
            .width(60)
            .fontColor(Color.Gray);
          Text(this.studentInfo.birthDate);
        }
        .padding(10);

        // 籍贯
        Row() {
          Text('籍贯：')
            .width(60)
            .fontColor(Color.Gray);
          Text(this.studentInfo.hometown);
        }
        .padding(10);

        // 电话
        Row() {
          Text('电话：')
            .width(60)
            .fontColor(Color.Gray);
          Text(this.studentInfo.phone);
        }
        .padding(10);

        // 邮箱
        Row() {
          Text('邮箱：')
            .width(60)
            .fontColor(Color.Gray);
          Text(this.studentInfo.email);
        }
        .padding(10);
      }
      .border({ width: 1, color: Color.Gray })
      .borderRadius(5);
    }
  }

  @Builder
  buildProfileTab() {
    Column({ space: 15 }) {
      Text('编辑个人信息')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Blue);

      // 姓名
      Column({ space: 5 }) {
        Text('姓名')
          .fontSize(16);
        TextInput({ text: this.studentInfo.name })
          .width('100%')
          .height(40)
          .backgroundColor(0xF5F5F5)
          .borderRadius(5)
          .enabled(this.isEditing)
          .onChange((value: string) => {
            this.studentInfo.name = value;
          });
      }

      // 学号
      Column({ space: 5 }) {
        Text('学号')
          .fontSize(16);
        TextInput({ text: this.studentInfo.studentId })
          .width('100%')
          .height(40)
          .backgroundColor(0xF5F5F5)
          .borderRadius(5)
          .enabled(this.isEditing)
          .onChange((value: string) => {
            this.studentInfo.studentId = value;
          });
      }

      // 性别选择器 (Picker - 单选)
      Column({ space: 5 }) {
        Text('性别')
          .fontSize(16);
        Row() {
          ForEach(this.genderOptions, (gender: string) => {
            Row() {
              Circle({ width: 20, height: 20 })
                .fill(this.studentInfo.gender === gender ? Color.Blue : Color.Gray);
              Text(gender)
                .fontSize(14)
                .margin({ left: 10 });
            }
            .onClick(() => {
              if (this.isEditing) {
                this.studentInfo.gender = gender;
              }
            })
            .padding(5)
            .margin({ right: 20 });
          }, (gender: string) => gender)
        }
      }

      // 出生日期选择器 (Picker - 日期) - 增强版
      Column({ space: 5 }) {
        Text('出生日期')
          .fontSize(16);
        Row() {
          Text(this.studentInfo.birthDate)
            .fontSize(14)
            .padding(10)
            .backgroundColor(0xF5F5F5)
            .borderRadius(5);

          if (this.isEditing) {
            Button() {
              Text('选择日期')
                .fontSize(14);
            }
            .width(100)
            .height(40)
            .margin({ left: 10 })
            .backgroundColor(Color.Blue)
            .onClick(() => {
              this.showDatePickerDialog();
            });
          }
        }

        // 增强版日期选择器弹窗
        if (this.showDatePicker) {
          Column({ space: 10 }) {
            // 标题
            Row() {
              Text('选择出生日期')
                .fontSize(16)
                .fontWeight(FontWeight.Bold);

              Text(`${this.datePickerState.selectedYear}年${this.datePickerState.selectedMonth}月${this.datePickerState.selectedDay}日`)
                .fontSize(14)
                .fontColor(Color.Blue)
                .margin({ left: 10 });
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween);

            // 步骤指示器
            Row({ space: 20 }) {
              Column() {
                Circle({ width: 30, height: 30 })
                  .fill(this.datePickerState.showYearPicker ? Color.Blue : Color.Gray);
                Text('1')
                  .fontSize(12)
                  .fontColor(Color.White);
                Text('年份')
                  .fontSize(10);
              }

              Column() {
                Circle({ width: 30, height: 30 })
                  .fill(this.datePickerState.showMonthPicker ? Color.Blue : Color.Gray);
                Text('2')
                  .fontSize(12)
                  .fontColor(Color.White);
                Text('月份')
                  .fontSize(10);
              }

              Column() {
                Circle({ width: 30, height: 30 })
                  .fill(this.datePickerState.showDayPicker ? Color.Blue : Color.Gray);
                Text('3')
                  .fontSize(12)
                  .fontColor(Color.White);
                Text('日期')
                  .fontSize(10);
              }
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceAround)
            .margin({ top: 10, bottom: 10 });

            // 年份选择 (1980-2024)
            if (this.datePickerState.showYearPicker) {
              Column() {
                Text('选择年份')
                  .fontSize(14)
                  .margin({ bottom: 10 });

                Scroll() {
                  Column() {
                    ForEach(this.yearOptions, (year: string) => {
                      Row() {
                        Text(year + '年')
                          .fontSize(14);

                        if (this.datePickerState.selectedYear === year) {
                          Text('✓')
                            .fontSize(16)
                            .fontColor(Color.Blue)
                            .margin({ left: 10 });
                        }
                      }
                      .width('100%')
                      .padding(10)
                      .backgroundColor(this.datePickerState.selectedYear === year ? 0xE6F7FF : Color.White)
                      .onClick(() => {
                        this.selectYear(year);
                      });
                    }, (year: string) => year)
                  }
                }
                .height(200);
              }
            }

            // 月份选择 (01-12)
            if (this.datePickerState.showMonthPicker) {
              Column() {
                Text('选择月份')
                  .fontSize(14)
                  .margin({ bottom: 10 });

                Scroll() {
                  Column() {
                    ForEach(this.monthOptions, (month: string) => {
                      Row() {
                        Text(month + '月')
                          .fontSize(14);

                        if (this.datePickerState.selectedMonth === month) {
                          Text('✓')
                            .fontSize(16)
                            .fontColor(Color.Blue)
                            .margin({ left: 10 });
                        }
                      }
                      .width('100%')
                      .padding(10)
                      .backgroundColor(this.datePickerState.selectedMonth === month ? 0xE6F7FF : Color.White)
                      .onClick(() => {
                        this.selectMonth(month);
                      });
                    }, (month: string) => month)
                  }
                }
                .height(200);
              }
            }

            // 日期选择 (01-31)
            if (this.datePickerState.showDayPicker) {
              Column() {
                Text('选择日期')
                  .fontSize(14)
                  .margin({ bottom: 10 });

                Scroll() {
                  Column() {
                    ForEach(this.dayOptions, (day: string) => {
                      Row() {
                        Text(day + '日')
                          .fontSize(14);

                        if (this.datePickerState.selectedDay === day) {
                          Text('✓')
                            .fontSize(16)
                            .fontColor(Color.Blue)
                            .margin({ left: 10 });
                        }
                      }
                      .width('100%')
                      .padding(10)
                      .backgroundColor(this.datePickerState.selectedDay === day ? 0xE6F7FF : Color.White)
                      .onClick(() => {
                        this.selectDay(day);
                      });
                    }, (day: string) => day)
                  }
                }
                .height(200);
              }
            }

            // 按钮区域
            Row({ space: 20 }) {
              if (this.datePickerState.showMonthPicker || this.datePickerState.showDayPicker) {
                Button() {
                  Text('上一步')
                    .fontSize(14);
                }
                .width(100)
                .height(40)
                .backgroundColor(Color.Gray)
                .onClick(() => {
                  if (this.datePickerState.showDayPicker) {
                    this.datePickerState.showDayPicker = false;
                    this.datePickerState.showMonthPicker = true;
                  } else if (this.datePickerState.showMonthPicker) {
                    this.datePickerState.showMonthPicker = false;
                    this.datePickerState.showYearPicker = true;
                  }
                });
              }

              Button() {
                Text('取消')
                  .fontSize(14);
              }
              .width(100)
              .height(40)
              .backgroundColor(Color.Gray)
              .onClick(() => {
                this.cancelDatePicker();
              });

              if (this.datePickerState.showDayPicker) {
                Button() {
                  Text('确定')
                    .fontSize(14);
                }
                .width(100)
                .height(40)
                .backgroundColor(Color.Blue)
                .onClick(() => {
                  this.selectDay(this.datePickerState.selectedDay);
                });
              }
            }
            .width('100%')
            .justifyContent(FlexAlign.Center)
            .margin({ top: 20 });
          }
          .padding(20)
          .backgroundColor(Color.White)
          .border({ width: 1, color: Color.Gray })
          .borderRadius(10)
          .margin({ top: 10 });
        }
      }

      // 籍贯选择器
      Column({ space: 5 }) {
        Text('籍贯')
          .fontSize(16);
        Row() {
          Text(this.studentInfo.hometown)
            .fontSize(14)
            .padding(10)
            .backgroundColor(0xF5F5F5)
            .borderRadius(5);

          if (this.isEditing) {
            Button() {
              Text('选择地区')
                .fontSize(14);
            }
            .width(100)
            .height(40)
            .margin({ left: 10 })
            .backgroundColor(Color.Blue)
            .onClick(() => {
              this.showRegionPickerDialog();
            });
          }
        }

        // 增强版地域选择器弹窗
        if (this.showRegionPicker) {
          Column({ space: 10 }) {
            Text('选择籍贯')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .margin({ bottom: 10 });

            // 搜索框
            Column({ space: 5 }) {
              Text('搜索省份')
                .fontSize(12)
                .fontColor(Color.Gray);
              TextInput({ text: this.regionSearchText })
                .width('100%')
                .height(40)
                .padding(10)
                .backgroundColor(0xF5F5F5)
                .borderRadius(5)
                .onChange((value: string) => {
                  this.regionSearchText = value;
                });
            }
            .margin({ bottom: 10 });

            // 地区列表 - 使用预先计算的方法
            Scroll() {
              Column() {
                ForEach(this.getFilteredProvinces(), (province: string) => {
                  Row() {
                    Text(province)
                      .fontSize(14);

                    if (this.studentInfo.hometown === province) {
                      Text('✓')
                        .fontSize(16)
                        .fontColor(Color.Blue)
                        .margin({ left: 10 });
                    }
                  }
                  .width('100%')
                  .padding(10)
                  .backgroundColor(this.studentInfo.hometown === province ? 0xE6F7FF : Color.White)
                  .onClick(() => {
                    this.studentInfo.hometown = province;
                    this.showRegionPicker = false;
                    this.regionSearchText = '';
                  });
                }, (province: string) => province)
              }
            }
            .height(300);

            // 按钮
            Row({ space: 20 }) {
              Button() {
                Text('取消')
                  .fontSize(14);
              }
              .width(100)
              .height(40)
              .backgroundColor(Color.Gray)
              .onClick(() => {
                this.showRegionPicker = false;
                this.regionSearchText = '';
              });
            }
            .width('100%')
            .justifyContent(FlexAlign.Center)
            .margin({ top: 20 });
          }
          .padding(20)
          .backgroundColor(Color.White)
          .border({ width: 1, color: Color.Gray })
          .borderRadius(10)
          .margin({ top: 10 });
        }
      }

      // 班级选择器
      Column({ space: 5 }) {
        Text('班级')
          .fontSize(16);
        Column() {
          ForEach(this.classOptions, (className: string) => {
            Row() {
              Circle({ width: 20, height: 20 })
                .fill(this.studentInfo.className === className ? Color.Blue : Color.Gray);
              Text(className)
                .fontSize(14)
                .margin({ left: 10 });
            }
            .onClick(() => {
              if (this.isEditing) {
                this.studentInfo.className = className;
              }
            })
            .padding(5);
          }, (className: string) => className)
        }
      }

      // 电话
      Column({ space: 5 }) {
        Text('电话')
          .fontSize(16);
        TextInput({ text: this.studentInfo.phone })
          .width('100%')
          .height(40)
          .backgroundColor(0xF5F5F5)
          .borderRadius(5)
          .enabled(this.isEditing)
          .onChange((value: string) => {
            this.studentInfo.phone = value;
          });
      }

      // 邮箱
      Column({ space: 5 }) {
        Text('邮箱')
          .fontSize(16);
        TextInput({ text: this.studentInfo.email })
          .width('100%')
          .height(40)
          .backgroundColor(0xF5F5F5)
          .borderRadius(5)
          .enabled(this.isEditing)
          .onChange((value: string) => {
            this.studentInfo.email = value;
          });
      }

      // 操作按钮
      Row({ space: 20 }) {
        if (!this.isEditing) {
          // 编辑按钮
          Button() {
            Text('编辑信息')
              .fontSize(16);
          }
          .width(120)
          .height(40)
          .backgroundColor(Color.Blue)
          .onClick(() => {
            this.isEditing = true;
          });
        } else {
          // 保存和取消按钮
          Button() {
            Text('保存')
              .fontSize(16);
          }
          .width(120)
          .height(40)
          .backgroundColor(Color.Green)
          .onClick(() => {
            this.saveProfile();
          });

          Button() {
            Text('取消')
              .fontSize(16);
          }
          .width(120)
          .height(40)
          .backgroundColor(Color.Gray)
          .onClick(() => {
            this.isEditing = false;
          });
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .margin({ top: 20 });
    }
    .padding(20);
  }
}