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

// 成绩数据类型
interface ScoreItem {
  courseName: string; // 课程名
  score: number;      // 分数
  credit: number;     // 学分
  grade: string;      // 等级（优/良/中/及格/不及格）
}

// 图书数据类型
interface BookItem {
  bookName: string;   // 书名
  author: string;     // 作者
  borrowDate: string; // 借阅日期
  returnDate: string; // 归还日期
  status: string;     // 状态（正常/逾期）
}

// 选课数据类型
interface CourseItem {
  courseName: string; // 课程名
  teacher: string;    // 授课老师
  credit: number;     // 学分
  time: string;       // 上课时间
  room: string;       // 上课教室
}

@Entry
@Component
struct Services {
  @State currentTab: number = 0;
  private tabs: string[] = ['成绩查询', '图书查询', '选课查询', '个人资料'];

  // 个人信息数据
  @State personalInfo: PersonalInfo = {
    name: '谢英豪',
    studentId: '2224040748',
    birthDate: '2002年2月1日',
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
  @State selectedMonthIndex: number = 1;
  @State selectedYearIndex: number = 102;
  @State selectedDayIndex: number = 0;

  // ========== 新增交互状态 ==========
  // 成绩查询
  @State scoreQueryTerm: string = '2023-2024学年 第二学期'; // 查询学期
  @State scoreInput: string = ''; // 课程名输入框
  @State scoreList: ScoreItem[] = []; // 成绩列表
  @State isScoreEmpty: boolean = true; // 成绩列表是否为空

  // 图书查询
  @State bookInput: string = ''; // 图书名/作者输入框
  @State bookList: BookItem[] = []; // 图书列表
  @State isBookEmpty: boolean = true; // 图书列表是否为空

  // 选课查询
  @State courseQueryTerm: string = '2023-2024学年 第二学期'; // 查询学期
  @State courseList: CourseItem[] = []; // 选课列表
  @State isCourseEmpty: boolean = true; // 选课列表是否为空

  aboutToAppear() {
    // 初始化年份/日期数组
    for (let i = 1900; i <= 2024; i++) {
      this.years.push(i + '年');
    }
    for (let i = 1; i <= 31; i++) {
      this.days.push(i + '日');
    }

    // 路由参数处理
    const params = router.getParams() as RouterParams;
    if (params && params.initialTab !== undefined) {
      this.currentTab = params.initialTab - 1;
    }

    // 默认选中日期索引
    this.selectedYearIndex = 102;
    this.selectedMonthIndex = 1;
    this.selectedDayIndex = 0;
  }

  // ========== 新增：成绩查询方法 ==========
  queryScore() {
    if (!this.scoreInput.trim()) {
      promptAction.showToast({ message: '请输入课程名关键词', duration: 2000 });
      return;
    }

    // 模拟查询结果（根据输入关键词匹配）
    const mockScores: ScoreItem[] = [
      { courseName: '计算机组成原理', score: 85, credit: 3, grade: '良' },
      { courseName: '操作系统', score: 92, credit: 3, grade: '优' },
      { courseName: '数据结构', score: 78, credit: 4, grade: '中' },
      { courseName: 'Python编程', score: 95, credit: 2, grade: '优' },
      { courseName: '离散数学', score: 88, credit: 3, grade: '良' }
    ];

    // 筛选匹配的课程
    this.scoreList = mockScores.filter(item =>
    item.courseName.includes(this.scoreInput.trim())
    );
    this.isScoreEmpty = this.scoreList.length === 0;

    // 提示
    if (this.isScoreEmpty) {
      promptAction.showToast({ message: '未查询到该课程成绩', duration: 2000 });
    } else {
      promptAction.showToast({ message: `查询到${this.scoreList.length}门课程`, duration: 2000 });
    }
  }

  // ========== 新增：图书查询方法 ==========
  queryBook() {
    if (!this.bookInput.trim()) {
      promptAction.showToast({ message: '请输入图书名/作者关键词', duration: 2000 });
      return;
    }

    // 模拟查询结果
    const mockBooks: BookItem[] = [
      { bookName: '算法导论', author: 'Thomas H. Cormen', borrowDate: '2025-03-15', returnDate: '2025-06-30', status: '正常' },
      { bookName: 'Python编程：从入门到实践', author: '埃里克·马瑟斯', borrowDate: '2025-02-20', returnDate: '2025-05-20', status: '正常' },
      { bookName: '数据结构与算法分析', author: 'Mark Allen Weiss', borrowDate: '2025-01-10', returnDate: '2025-04-10', status: '逾期' },
      { bookName: '深入理解计算机系统', author: 'Randal E. Bryant', borrowDate: '2025-04-05', returnDate: '2025-07-05', status: '正常' }
    ];

    // 筛选匹配的图书
    this.bookList = mockBooks.filter(item =>
    item.bookName.includes(this.bookInput.trim()) || item.author.includes(this.bookInput.trim())
    );
    this.isBookEmpty = this.bookList.length === 0;

    // 提示
    if (this.isBookEmpty) {
      promptAction.showToast({ message: '未查询到相关图书', duration: 2000 });
    } else {
      promptAction.showToast({ message: `查询到${this.bookList.length}本图书`, duration: 2000 });
    }
  }

  // ========== 新增：选课查询方法 ==========
  queryCourse() {
    // 模拟查询结果
    const mockCourses: CourseItem[] = [
      { courseName: '人工智能导论', teacher: '张教授', credit: 3, time: '周一3-4节', room: '教1-301' },
      { courseName: '机器学习', teacher: '李老师', credit: 3, time: '周三5-6节', room: '教2-205' },
      { courseName: '计算机网络', teacher: '王老师', credit: 4, time: '周二1-2节', room: '教3-108' },
      { courseName: '数据库原理', teacher: '赵教授', credit: 3, time: '周四7-8节', room: '教1-402' }
    ];

    this.courseList = mockCourses;
    this.isCourseEmpty = false;
    promptAction.showToast({ message: `查询到${this.courseList.length}门选课`, duration: 2000 });
  }

  // ========== 原有方法（无修改） ==========
  openEditDialog(field: string, value: string) {
    if (!this.isEditMode) return;
    this.editField = field;
    this.editValue = value;
    this.isEditDialogVisible = true;

    if (field === 'birthDate') {
      const dateMatch = value.match(/(\d{4})年(\d{1,2})月(\d{1,2})日/);
      if (dateMatch) {
        const year = dateMatch[1] + '年';
        const month = parseInt(dateMatch[2]) + '月';
        const day = parseInt(dateMatch[3]) + '日';

        const yearIndex = this.years.findIndex(y => y === year);
        if (yearIndex !== -1) this.selectedYearIndex = yearIndex;

        const monthIndex = this.months.findIndex(m => m === month);
        if (monthIndex !== -1) this.selectedMonthIndex = monthIndex;

        const dayIndex = this.days.findIndex(d => d === day);
        if (dayIndex !== -1) this.selectedDayIndex = dayIndex;
      }
    }
  }

  saveEdit() {
    if (this.editField === 'birthDate') {
      const year = this.years[this.selectedYearIndex].replace('年', '');
      const month = this.months[this.selectedMonthIndex].replace('月', '');
      const day = this.days[this.selectedDayIndex].replace('日', '');
      this.personalInfo.birthDate = `${year}年${month}月${day}日`;
      promptAction.showToast({ message: '出生日期已更新', duration: 2000 });
    } else {
      switch (this.editField) {
        case 'name': this.personalInfo.name = this.editValue; break;
        case 'hometown': this.personalInfo.hometown = this.editValue; break;
        case 'className': this.personalInfo.className = this.editValue; break;
      }
      promptAction.showToast({ message: '信息已更新', duration: 2000 });
    }
    this.closeEditDialog();
  }

  closeEditDialog() {
    this.isEditDialogVisible = false;
    this.editValue = '';
  }

  toggleEditMode() {
    this.isEditMode = !this.isEditMode;
    if (!this.isEditMode) {
      promptAction.showToast({ message: '已退出编辑模式', duration: 2000 });
    }
  }

  // ========== 年份/日期数组（补充定义） ==========
  private years: string[] = [];
  private days: string[] = [];

  build() {
    Stack() {
      Column() {
        // 顶部标题栏
        Row() {
          Text('←')
            .fontSize(24)
            .margin({ left: 12 })
            .onClick(() => router.back());

          Text('服务大厅')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .margin({ left: 16 })
            .flexGrow(1);

          if (this.currentTab === 3) {
            Text(this.isEditMode ? '完成' : '编辑')
              .fontSize(16)
              .fontColor(Color.Blue)
              .margin({ right: 16 })
              .onClick(() => this.toggleEditMode());
          }
        }
        .width('100%')
        .height(56)
        .backgroundColor('#FFFFFF')
        .justifyContent(FlexAlign.Start)
        .alignItems(VerticalAlign.Center)
        .border({ width: { bottom: 1 }, color: '#E0E0E0' });

        // Tab切换栏
        Row() {
          ForEach(this.tabs, (tab: string, index: number) => {
            Column() {
              Text(tab)
                .fontSize(16)
                .fontColor(this.currentTab === index ? Color.Blue : Color.Gray)
                .fontWeight(this.currentTab === index ? FontWeight.Bold : FontWeight.Normal);

              if (this.currentTab === index) {
                Divider()
                  .color(Color.Blue)
                  .strokeWidth(2)
                  .width(40)
                  .margin({ top: 4 });
              }
            }
            .height(50)
            .flexGrow(1)
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
            .onClick(() => {
              this.currentTab = index;
              if (index !== 3) this.isEditMode = false;
            });
          });
        }
        .width('100%')
        .height(50)
        .backgroundColor(Color.White)
        .border({ width: { bottom: 1 }, color: '#E0E0E0' });

        // 内容区域
        Column() {
          // ========== 成绩查询（新增交互） ==========
          if (this.currentTab === 0) {
            Column() {
              Text('成绩查询')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .margin({ top: 30, bottom: 20 });

              // 查询条件区域
              Column() {
                // 学期选择
                Row() {
                  Text('查询学期：')
                    .fontSize(14)
                    .margin({ left: 16 });
                  Text(this.scoreQueryTerm)
                    .fontSize(14)
                    .flexGrow(1)
                    .margin({ left: 8 });
                }
                .width('100%')
                .padding({ top: 8, bottom: 8 });

                // 课程名输入框 + 查询按钮
                Row() {
                  TextInput({
                    placeholder: '请输入课程名关键词（如：数据结构）',
                    text: this.scoreInput
                  })
                    .width('70%')
                    .height(40)
                    .padding({ left: 8 })
                    .backgroundColor(Color.White)
                    .border({ width: 1, color: '#E0E0E0' })
                    .borderRadius(4)
                    .onChange((value) => this.scoreInput = value);

                  Button('查询')
                    .width('25%')
                    .height(40)
                    .backgroundColor(Color.Blue)
                    .fontColor(Color.White)
                    .margin({ left: 8 })
                    .onClick(() => this.queryScore());
                }
                .width('90%')
                .margin({ top: 12, bottom: 16 });

                // 成绩结果列表
                if (!this.isScoreEmpty) {
                  Scroll() {
                    Column() {
                      ForEach(this.scoreList, (item: ScoreItem) => {
                        Row() {
                          Column() {
                            Text(item.courseName)
                              .fontSize(14)
                              .fontWeight(FontWeight.Bold);
                            Text(`学分：${item.credit} | 等级：${item.grade}`)
                              .fontSize(12)
                              .fontColor(Color.Gray)
                              .margin({ top: 4 });
                          }
                          .flexGrow(1);

                          Text(item.score + '分')
                            .fontSize(16)
                            .fontWeight(FontWeight.Bold)
                            .fontColor(item.score >= 90 ? Color.Green : item.score >= 60 ? Color.Black : Color.Red);
                        }
                        .width('100%')
                        .padding({ top: 12, bottom: 12, left: 16, right: 16 })
                        .border({ width: { bottom: 1 }, color: '#E0E0E0' });
                      });
                    }
                  }
                  .width('90%')
                  .height(200)
                  .backgroundColor(Color.White)
                  .borderRadius(8)
                  .margin({ top: 8 });
                } else {
                  // 空状态提示
                  Text('暂无查询结果，请输入关键词查询')
                    .fontSize(14)
                    .fontColor(Color.Gray)
                    .margin({ top: 20 });
                }
              }
              .padding(16)
              .backgroundColor(0xF5F5F5)
              .borderRadius(8)
              .margin({ left: 16, right: 16 });
            }
          }

          // ========== 图书查询（新增交互） ==========
          else if (this.currentTab === 1) {
            Column() {
              Text('图书查询')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .margin({ top: 30, bottom: 20 });

              // 查询区域
              Column() {
                // 输入框 + 查询按钮
                Row() {
                  TextInput({
                    placeholder: '请输入图书名/作者关键词',
                    text: this.bookInput
                  })
                    .width('70%')
                    .height(40)
                    .padding({ left: 8 })
                    .backgroundColor(Color.White)
                    .border({ width: 1, color: '#E0E0E0' })
                    .borderRadius(4)
                    .onChange((value) => this.bookInput = value);

                  Button('查询')
                    .width('25%')
                    .height(40)
                    .backgroundColor(Color.Green)
                    .fontColor(Color.White)
                    .margin({ left: 8 })
                    .onClick(() => this.queryBook());
                }
                .width('90%')
                .margin({ bottom: 16 });

                // 图书结果列表
                if (!this.isBookEmpty) {
                  Scroll() {
                    Column() {
                      ForEach(this.bookList, (item: BookItem) => {
                        Column() {
                          Row() {
                            Text(item.bookName)
                              .fontSize(14)
                              .fontWeight(FontWeight.Bold)
                              .flexGrow(1);
                            Text(item.status)
                              .fontSize(12)
                              .fontColor(item.status === '逾期' ? Color.Red : Color.Green)
                              .backgroundColor(item.status === '逾期' ? 0xFFF0E6 : 0xE6F7EF)
                              .padding({ left: 8, right: 8, top: 2, bottom: 2 })
                              .borderRadius(4);
                          }
                          .margin({ bottom: 4 });

                          Text(`作者：${item.author}`)
                            .fontSize(12)
                            .fontColor(Color.Gray)
                            .margin({ bottom: 4 });

                          Row() {
                            Text(`借阅：${item.borrowDate}`)
                              .fontSize(12)
                              .fontColor(Color.Gray);
                            Text(`归还：${item.returnDate}`)
                              .fontSize(12)
                              .fontColor(Color.Gray)
                              .margin({ left: 16 });
                          }
                        }
                        .width('100%')
                        .padding({ top: 12, bottom: 12, left: 16, right: 16 })
                        .border({ width: { bottom: 1 }, color: '#E0E0E0' });
                      });
                    }
                  }
                  .width('90%')
                  .height(200)
                  .backgroundColor(Color.White)
                  .borderRadius(8)
                  .margin({ top: 8 });
                } else {
                  Text('暂无查询结果，请输入关键词查询')
                    .fontSize(14)
                    .fontColor(Color.Gray)
                    .margin({ top: 20 });
                }
              }
              .padding(16)
              .backgroundColor(0xF5F5F5)
              .borderRadius(8)
              .margin({ left: 16, right: 16 });
            }
          }

          // ========== 选课查询（新增交互） ==========
          else if (this.currentTab === 2) {
            Column() {
              Text('选课查询')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .margin({ top: 30, bottom: 20 });

              // 查询区域
              Column() {
                // 学期选择 + 查询按钮
                Row() {
                  Text('查询学期：')
                    .fontSize(14)
                    .margin({ left: 16 });
                  Text(this.courseQueryTerm)
                    .fontSize(14)
                    .flexGrow(1)
                    .margin({ left: 8 });

                  Button('查询选课')
                    .width('30%')
                    .height(36)
                    .backgroundColor(Color.Orange)
                    .fontColor(Color.White)
                    .margin({ right: 16 })
                    .onClick(() => this.queryCourse());
                }
                .width('100%')
                .padding({ top: 8, bottom: 8 })
                .margin({ bottom: 16 });

                // 选课结果列表
                if (!this.isCourseEmpty) {
                  Scroll() {
                    Column() {
                      ForEach(this.courseList, (item: CourseItem) => {
                        Column() {
                          Text(item.courseName)
                            .fontSize(14)
                            .fontWeight(FontWeight.Bold)
                            .margin({ bottom: 4 });

                          Row() {
                            Text(`授课老师：${item.teacher}`)
                              .fontSize(12)
                              .fontColor(Color.Gray)
                              .flexGrow(1);
                            Text(`学分：${item.credit}`)
                              .fontSize(12)
                              .fontColor(Color.Gray);
                          }
                          .margin({ bottom: 4 });

                          Row() {
                            Text(`时间：${item.time}`)
                              .fontSize(12)
                              .fontColor(Color.Gray);
                            Text(`教室：${item.room}`)
                              .fontSize(12)
                              .fontColor(Color.Gray)
                              .margin({ left: 16 });
                          }
                        }
                        .width('100%')
                        .padding({ top: 12, bottom: 12, left: 16, right: 16 })
                        .border({ width: { bottom: 1 }, color: '#E0E0E0' });
                      });
                    }
                  }
                  .width('90%')
                  .height(200)
                  .backgroundColor(Color.White)
                  .borderRadius(8)
                  .margin({ top: 8 });
                } else {
                  Text('点击上方按钮查询本学期选课')
                    .fontSize(14)
                    .fontColor(Color.Gray)
                    .margin({ top: 20 });
                }
              }
              .padding(16)
              .backgroundColor(0xF5F5F5)
              .borderRadius(8)
              .margin({ left: 16, right: 16 });
            }
          }

          // ========== 个人资料（无修改） ==========
          else if (this.currentTab === 3) {
            Column() {
              Text('个人资料')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .margin({ top: 30, bottom: 20 });

              Column() {
                // 姓名
                Row() {
                  Text('名字：')
                    .fontSize(14)
                    .fontWeight(FontWeight.Bold);
                  Text(this.personalInfo.name)
                    .fontSize(14)
                    .margin({ left: 8 });
                  Blank();
                  if (this.isEditMode) {
                    Text('编辑')
                      .fontSize(12)
                      .fontColor(Color.Blue)
                      .border({ width: 1, color: Color.Blue })
                      .borderRadius(4)
                      .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                      .onClick(() => this.openEditDialog('name', this.personalInfo.name));
                  }
                }
                .width('90%')
                .padding({ top: 12, bottom: 12 })
                .border({ width: { bottom: 1 }, color: '#E0E0E0' });

                // 学号
                Row() {
                  Text('学号：')
                    .fontSize(14)
                    .fontWeight(FontWeight.Bold);
                  Text(this.personalInfo.studentId)
                    .fontSize(14)
                    .margin({ left: 8 });
                  Blank();
                  Text('不可编辑')
                    .fontSize(12)
                    .fontColor(Color.Gray);
                }
                .width('90%')
                .padding({ top: 12, bottom: 12 })
                .border({ width: { bottom: 1 }, color: '#E0E0E0' });

                // 出生年月日
                Row() {
                  Text('出生年月日：')
                    .fontSize(14)
                    .fontWeight(FontWeight.Bold);
                  Text(this.personalInfo.birthDate)
                    .fontSize(14)
                    .margin({ left: 8 });
                  Blank();
                  if (this.isEditMode) {
                    Text('编辑')
                      .fontSize(12)
                      .fontColor(Color.Blue)
                      .border({ width: 1, color: Color.Blue })
                      .borderRadius(4)
                      .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                      .onClick(() => this.openEditDialog('birthDate', this.personalInfo.birthDate));
                  }
                }
                .width('90%')
                .padding({ top: 12, bottom: 12 })
                .border({ width: { bottom: 1 }, color: '#E0E0E0' });

                // 户籍
                Row() {
                  Text('户籍：')
                    .fontSize(14)
                    .fontWeight(FontWeight.Bold);
                  Text(this.personalInfo.hometown)
                    .fontSize(14)
                    .margin({ left: 8 });
                  Blank();
                  if (this.isEditMode) {
                    Text('编辑')
                      .fontSize(12)
                      .fontColor(Color.Blue)
                      .border({ width: 1, color: Color.Blue })
                      .borderRadius(4)
                      .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                      .onClick(() => this.openEditDialog('hometown', this.personalInfo.hometown));
                  }
                }
                .width('90%')
                .padding({ top: 12, bottom: 12 })
                .border({ width: { bottom: 1 }, color: '#E0E0E0' });

                // 班级
                Row() {
                  Text('班级：')
                    .fontSize(14)
                    .fontWeight(FontWeight.Bold);
                  Text(this.personalInfo.className)
                    .fontSize(14)
                    .margin({ left: 8 });
                  Blank();
                  if (this.isEditMode) {
                    Text('编辑')
                      .fontSize(12)
                      .fontColor(Color.Blue)
                      .border({ width: 1, color: Color.Blue })
                      .borderRadius(4)
                      .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                      .onClick(() => this.openEditDialog('className', this.personalInfo.className));
                  }
                }
                .width('90%')
                .padding({ top: 12, bottom: 12 });
              }
              .padding(16)
              .backgroundColor(Color.White)
              .borderRadius(8)
              .margin({ left: 16, right: 16 })
              .border({ width: 1, color: '#E0E0E0' });
            }
          }
        }
        .flexGrow(1)
        .width('100%')
        .justifyContent(FlexAlign.Start)
        .alignItems(HorizontalAlign.Center);
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White);

      // 编辑弹窗（无修改）
      if (this.isEditDialogVisible) {
        Column() {
          Column() {
            Text(this.editField === 'birthDate' ? '编辑出生日期' : '编辑信息')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .margin({ top: 24, bottom: 20 });

            if (this.editField === 'birthDate') {
              Column() {
                Text('选择年份：')
                  .fontSize(14)
                  .margin({ bottom: 8 })
                  .alignSelf(ItemAlign.Start)
                  .margin({ left: 24 });

                Scroll() {
                  Column() {
                    ForEach(this.years, (year: string, index: number) => {
                      Row() {
                        Radio({ value: year, group: 'year' })
                          .checked(this.selectedYearIndex === index)
                          .onChange((checked: boolean) => {
                            if (checked) this.selectedYearIndex = index;
                          });
                        Text(year)
                          .fontSize(14)
                          .fontColor(this.selectedYearIndex === index ? Color.Blue : Color.Black)
                          .margin({ left: 8 });
                      }
                      .width('100%')
                      .height(40)
                      .justifyContent(FlexAlign.Start)
                      .alignItems(VerticalAlign.Center)
                      .padding({ left: 16 });
                    });
                  }
                }
                .height(120)
                .width('80%')
                .border({ width: 1, color: '#E0E0E0' })
                .borderRadius(4);

                Text('选择月份：')
                  .fontSize(14)
                  .margin({ top: 16, bottom: 8 })
                  .alignSelf(ItemAlign.Start)
                  .margin({ left: 24 });

                Scroll() {
                  Column() {
                    ForEach(this.months, (month: string, index: number) => {
                      Row() {
                        Radio({ value: month, group: 'month' })
                          .checked(this.selectedMonthIndex === index)
                          .onChange((checked: boolean) => {
                            if (checked) this.selectedMonthIndex = index;
                          });
                        Text(month)
                          .fontSize(14)
                          .fontColor(this.selectedMonthIndex === index ? Color.Blue : Color.Black)
                          .margin({ left: 8 });
                      }
                      .width('100%')
                      .height(40)
                      .justifyContent(FlexAlign.Start)
                      .alignItems(VerticalAlign.Center)
                      .padding({ left: 16 });
                    });
                  }
                }
                .height(120)
                .width('80%')
                .border({ width: 1, color: '#E0E0E0' })
                .borderRadius(4);

                Text('选择日期：')
                  .fontSize(14)
                  .margin({ top: 16, bottom: 8 })
                  .alignSelf(ItemAlign.Start)
                  .margin({ left: 24 });

                Scroll() {
                  Column() {
                    ForEach(this.days, (day: string, index: number) => {
                      Row() {
                        Radio({ value: day, group: 'day' })
                          .checked(this.selectedDayIndex === index)
                          .onChange((checked: boolean) => {
                            if (checked) this.selectedDayIndex = index;
                          });
                        Text(day)
                          .fontSize(14)
                          .fontColor(this.selectedDayIndex === index ? Color.Blue : Color.Black)
                          .margin({ left: 8 });
                      }
                      .width('100%')
                      .height(40)
                      .justifyContent(FlexAlign.Start)
                      .alignItems(VerticalAlign.Center)
                      .padding({ left: 16 });
                    });
                  }
                }
                .height(120)
                .width('80%')
                .border({ width: 1, color: '#E0E0E0' })
                .borderRadius(4);

                Text('预览：' +
                this.years[this.selectedYearIndex].replace('年', '') + '年' +
                this.months[this.selectedMonthIndex].replace('月', '') + '月' +
                this.days[this.selectedDayIndex].replace('日', '') + '日')
                  .fontSize(14)
                  .margin({ top: 20 })
                  .fontColor(Color.Blue)
                  .fontWeight(FontWeight.Bold);
              }
              .width('100%')
              .alignItems(HorizontalAlign.Center);
            } else {
              Column() {
                Text(this.editField === 'name' ? '姓名' :
                  this.editField === 'hometown' ? '户籍' : '班级')
                  .fontSize(14)
                  .margin({ bottom: 8 })
                  .alignSelf(ItemAlign.Start)
                  .margin({ left: 24 });

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
                  });
              }
              .width('100%')
              .alignItems(HorizontalAlign.Center);
            }

            Row() {
              Button('取消')
                .width('40%')
                .height(40)
                .backgroundColor(Color.White)
                .fontColor(Color.Black)
                .border({ width: 1, color: '#E0E0E0' })
                .onClick(() => this.closeEditDialog());

              Button('保存')
                .width('40%')
                .height(40)
                .backgroundColor(Color.Blue)
                .fontColor(Color.White)
                .margin({ left: 16 })
                .onClick(() => this.saveEdit());
            }
            .margin({ top: 32, bottom: 24 })
            .justifyContent(FlexAlign.Center);
          }
          .width('90%')
          .backgroundColor(Color.White)
          .borderRadius(8)
          .padding({ left: 16, right: 16 });
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor(0x80000000)
        .zIndex(10)
        .onClick(() => this.closeEditDialog());
      }
    }
    .width('100%')
    .height('100%');
  }
}