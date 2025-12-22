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

@Entry
@Component
struct Services {
  @State tab: number = 1;
  @State studentId: string = '20230001';
  @State searchText: string = '';

  // 学生信息
  @State studentInfo: StudentInfo = {
    name: '张三',
    studentId: '20230001',
    gender: '男',
    birthDate: '2002-05-15',
    hometown: '北京市',
    className: '计算机科学与技术1班',
    phone: '13800138000',
    email: 'zhangsan@school.edu'
  };

  // 编辑状态
  @State isEditing: boolean = false;
  @State showDatePicker: boolean = false;
  @State showRegionPicker: boolean = false;

  // 性别选项
  private genderOptions: string[] = ['男', '女'];

  // 省份选项
  private provinceOptions: string[] = ['北京市', '上海市', '广东省', '江苏省', '浙江省', '四川省', '湖北省', '陕西省'];

  // 班级选项
  private classOptions: string[] = [
    '计算机科学与技术1班',
    '计算机科学与技术2班',
    '软件工程1班',
    '软件工程2班',
    '人工智能1班',
    '数据科学1班'
  ];

  // 切换标签页
  private switchTab(index: number): void {
    this.tab = index;
  }

  // 查询成绩
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

  // 搜索图书
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

  // 保存个人信息
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
  }

  // 显示地域选择器
  private showRegionPickerDialog(): void {
    this.showRegionPicker = true;
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

      // 出生日期选择器 (Picker - 日期)
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

        // 日期选择器弹窗
        if (this.showDatePicker) {
          Column() {
            Text('选择出生日期')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .margin({ bottom: 10 });

            // 模拟日期选择 - 实际项目中使用DatePicker组件
            Row({ space: 10 }) {
              ForEach(['2000', '2001', '2002', '2003', '2004'], (year: string) => {
                Text(year)
                  .fontSize(14)
                  .padding(10)
                  .backgroundColor(this.studentInfo.birthDate.includes(year) ? Color.Blue : 0xF5F5F5)
                  .fontColor(this.studentInfo.birthDate.includes(year) ? Color.White : Color.Black)
                  .borderRadius(5)
                  .onClick(() => {
                    this.studentInfo.birthDate = year + '-05-15';
                    this.showDatePicker = false;
                  });
              }, (year: string) => year)
            }

            Button() {
              Text('取消')
                .fontSize(14);
            }
            .width(100)
            .height(40)
            .margin({ top: 20 })
            .backgroundColor(Color.Gray)
            .onClick(() => {
              this.showDatePicker = false;
            });
          }
          .padding(20)
          .backgroundColor(Color.White)
          .border({ width: 1, color: Color.Gray })
          .borderRadius(10)
          .margin({ top: 10 });
        }
      }

      // 籍贯选择器 (Picker - 地域)
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

        // 地域选择器弹窗
        if (this.showRegionPicker) {
          Column() {
            Text('选择籍贯')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .margin({ bottom: 10 });

            // 模拟地区选择
            Column() {
              ForEach(this.provinceOptions, (province: string) => {
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
                });
              }, (province: string) => province)
            }

            Button() {
              Text('取消')
                .fontSize(14);
            }
            .width(100)
            .height(40)
            .margin({ top: 20 })
            .backgroundColor(Color.Gray)
            .onClick(() => {
              this.showRegionPicker = false;
            });
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