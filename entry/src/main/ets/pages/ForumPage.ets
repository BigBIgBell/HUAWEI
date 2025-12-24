import router from '@ohos.router';

// 定义用户类型
interface User {
  id: string;
  name: string;
  avatar: string;
}

// 定义帖子类型
interface Post {
  id: string;
  userId: string;
  userName: string;
  avatar: string;
  content: string;
  time: string;
  likes: number;
  comments: number;
  shares: number;
  type: 'text' | 'image' | 'video' | 'file';
}

@Entry
@Component
struct ForumPage {
  // 当前用户
  private currentUser: User = { id: 'user1', name: '小明', avatar: '😊' };

  @State posts: Post[] = [
    {
      id: 'post1',
      userId: 'user1',
      userName: '小明',
      avatar: '😊',
      content: '今天学校的樱花开了，太美了！大家一起去看樱花吧！',
      time: '2小时前',
      likes: 45,
      comments: 12,
      shares: 3,
      type: 'text'
    },
    {
      id: 'post2',
      userId: 'user2',
      userName: '小红',
      avatar: '👩',
      content: '刚刚参加了学校的编程比赛，获得了第一名！太开心了！',
      time: '4小时前',
      likes: 128,
      comments: 56,
      shares: 8,
      type: 'text'
    },
    {
      id: 'post3',
      userId: 'user3',
      userName: '小刚',
      avatar: '👨',
      content: '今天拍了一张漂亮的风景照，分享给大家！',
      time: '6小时前',
      likes: 89,
      comments: 24,
      shares: 5,
      type: 'image'
    },
    {
      id: 'post4',
      userId: 'user4',
      userName: '小花',
      avatar: '🌸',
      content: '上传了一份学习资料，需要的同学可以下载！',
      time: '8小时前',
      likes: 156,
      comments: 42,
      shares: 12,
      type: 'file'
    }
  ];

  @State newPostContent: string = '';
  @State isTakingPhoto: boolean = false;
  @State isSelectingFile: boolean = false;

  build() {
    Column() {
      // 标题栏 - 添加返回按钮
      Row() {
        // 返回按钮
        Button('←')
          .width(40)
          .height(40)
          .fontSize(20)
          .fontColor(Color.White)
          .backgroundColor(Color.Transparent)
          .onClick(() => {
            this.goBackToHome();
          })
          .margin({ left: 10 })

        Text('校园论坛')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .margin({ left: 10 })
          .flexGrow(1)
      }
      .width('100%')
      .height(60)
      .backgroundColor('#409EFF')
      .alignItems(VerticalAlign.Center)

      // 发布新帖子区域
      Column() {
        Row() {
          // 用户头像
          Text(this.currentUser.avatar)
            .fontSize(30)
            .margin({ left: 15, right: 10 })

          // 发布输入框
          Column() {
            TextInput({ placeholder: '分享你的想法...' })
              .width('100%')
              .height(60)
              .fontSize(16)
              .onChange((value: string) => {
                this.newPostContent = value;
              })

            Row() {
              // 拍照按钮
              Button('📸 拍照')
                .height(36)
                .fontSize(14)
                .backgroundColor('#ECF5FF')
                .fontColor('#409EFF')
                .margin({ right: 10 })
                .onClick(() => {
                  this.takePhoto();
                })

              // 文件选择按钮
              Button('📁 文件')
                .height(36)
                .fontSize(14)
                .backgroundColor('#F0F9EB')
                .fontColor('#67C23A')
                .margin({ right: 10 })
                .onClick(() => {
                  this.selectFile();
                })

              Button('发布')
                .height(36)
                .fontSize(14)
                .backgroundColor('#409EFF')
                .fontColor(Color.White)
                .onClick(() => {
                  this.publishPost();
                })
            }
            .margin({ top: 10 })
          }
          .layoutWeight(1)
          .margin({ right: 15 })
        }
        .padding({ top: 15, bottom: 15 })
        .backgroundColor(Color.White)
      }
      .width('100%')
      .shadow({ radius: 2, color: 0x10000000 })

      // 拍照和文件选择状态提示
      if (this.isTakingPhoto) {
        Column() {
          Text('📸 正在打开相机...')
            .fontSize(16)
            .fontColor('#409EFF')
            .margin({ top: 10, bottom: 5 })
          Text('请允许相机权限，对准拍摄目标')
            .fontSize(14)
            .fontColor('#909399')
          Text('处理中...')
            .fontSize(16)
            .fontColor('#409EFF')
            .margin({ top: 10 })
        }
        .padding(15)
        .backgroundColor('#F0F9FF')
        .borderRadius(8)
        .margin({ top: 10, left: 15, right: 15 })
      }

      if (this.isSelectingFile) {
        Column() {
          Text('📂 正在打开文件管理器...')
            .fontSize(16)
            .fontColor('#67C23A')
            .margin({ top: 10, bottom: 5 })
          Text('请选择要上传的文件')
            .fontSize(14)
            .fontColor('#909399')
          Text('处理中...')
            .fontSize(16)
            .fontColor('#67C23A')
            .margin({ top: 10 })
        }
        .padding(15)
        .backgroundColor('#F0F9EB')
        .borderRadius(8)
        .margin({ top: 10, left: 15, right: 15 })
      }

      // 帖子列表
      Scroll() {
        Column() {
          // 顶部统计信息
          Row() {
            Column() {
              Text('今日帖子')
                .fontSize(12)
                .fontColor('#909399')
              Text('4')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor('#409EFF')
            }
            .padding(10)
            .backgroundColor('#F5F7FA')
            .borderRadius(8)
            .margin({ right: 10 })

            Column() {
              Text('活跃用户')
                .fontSize(12)
                .fontColor('#909399')
              Text('128')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor('#67C23A')
            }
            .padding(10)
            .backgroundColor('#F5F7FA')
            .borderRadius(8)
            .margin({ right: 10 })

            Column() {
              Text('总帖子数')
                .fontSize(12)
                .fontColor('#909399')
              Text('1,234')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor('#E6A23C')
            }
            .padding(10)
            .backgroundColor('#F5F7FA')
            .borderRadius(8)
          }
          .padding({ left: 15, right: 15, top: 15, bottom: 10 })
          .justifyContent(FlexAlign.SpaceBetween)

          // 帖子列表
          ForEach(this.posts, (post: Post) => {
            Column() {
              // 用户信息行
              Row() {
                // 用户头像
                Column() {
                  Text(post.avatar)
                    .fontSize(28)
                }
                .width(50)
                .height(50)
                .backgroundColor('#ECF5FF')
                .borderRadius(25)
                .justifyContent(FlexAlign.Center)

                // 用户名和时间
                Column() {
                  Text(post.userName)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                  Text(post.time)
                    .fontSize(12)
                    .fontColor('#909399')
                }
                .margin({ left: 10 })
                .layoutWeight(1)
              }
              .padding({ left: 15, right: 15, top: 15 })

              // 帖子内容
              Text(post.content)
                .fontSize(15)
                .lineHeight(22)
                .padding({ left: 15, right: 15, top: 10, bottom: 10 })

              // 根据类型显示不同的内容
              if (post.type === 'image') {
                Column() {
                  Row() {
                    Text('📸')
                      .fontSize(16)
                      .margin({ right: 8 })
                    Text('照片：风景照.jpg')
                      .fontSize(14)
                      .fontColor('#409EFF')
                  }
                  .padding(10)
                  .width('90%')
                  .backgroundColor('#F0F9FF')
                  .borderRadius(8)
                }
                .margin({ left: 15, right: 15, bottom: 10 })
              } else if (post.type === 'file') {
                Column() {
                  Row() {
                    Text('📁')
                      .fontSize(16)
                      .margin({ right: 8 })
                    Column() {
                      Text('学习资料.pdf')
                        .fontSize(14)
                        .fontColor('#67C23A')
                      Text('2.5 MB • 点击下载')
                        .fontSize(12)
                        .fontColor('#909399')
                    }
                  }
                  .padding(10)
                  .width('90%')
                  .backgroundColor('#F0F9EB')
                  .borderRadius(8)
                }
                .margin({ left: 15, right: 15, bottom: 10 })
              }

              // 互动按钮行
              Row() {
                // 点赞按钮
                Button() {
                  Row() {
                    Text('👍')
                      .fontSize(16)
                      .margin({ right: 5 })
                    Text(post.likes.toString())
                      .fontSize(14)
                  }
                }
                .height(36)
                .backgroundColor(Color.Transparent)
                .borderColor('#DCDFE6')
                .borderWidth(1)
                .onClick(() => {
                  this.likePost(post.id);
                })

                // 评论按钮
                Button() {
                  Row() {
                    Text('💬')
                      .fontSize(16)
                      .margin({ right: 5 })
                    Text(post.comments.toString())
                      .fontSize(14)
                  }
                }
                .height(36)
                .backgroundColor(Color.Transparent)
                .borderColor('#DCDFE6')
                .borderWidth(1)
                .margin({ left: 10 })
                .onClick(() => {
                  this.commentPost(post.id);
                })

                // 分享按钮
                Button() {
                  Row() {
                    Text('↪️')
                      .fontSize(16)
                      .margin({ right: 5 })
                    Text(post.shares.toString())
                      .fontSize(14)
                  }
                }
                .height(36)
                .backgroundColor(Color.Transparent)
                .borderColor('#DCDFE6')
                .borderWidth(1)
                .margin({ left: 10 })
                .onClick(() => {
                  this.sharePost(post.id);
                })
              }
              .padding({ left: 15, right: 15, bottom: 15 })
            }
            .backgroundColor(Color.White)
            .borderRadius(12)
            .margin({ top: 10, left: 10, right: 10, bottom: 10 })
            .shadow({ radius: 4, color: 0x08000000 })
          }, (post: Post) => post.id)
        }
        .padding({ bottom: 20 })
      }
      .layoutWeight(1)
      .backgroundColor('#F0F2F5')
    }
    .width('100%')
    .height('100%')
  }

  // 返回主页
  private goBackToHome(): void {
    console.log('返回主页');
    // 在实际应用中，这里应该使用 router 返回上一个页面或跳转到主页
  }

  // 拍照功能
  private takePhoto(): void {
    console.log('调用系统相机拍照');
    this.isTakingPhoto = true;

    // 模拟拍照过程
    setTimeout(() => {
      this.isTakingPhoto = false;
      console.log('拍照完成，照片已保存');

      // 在实际应用中，这里应该处理相机返回的照片
      // 例如：将照片添加到帖子内容中

      // 这里我们只是模拟添加一条包含照片的帖子
      const photoPost: Post = {
        id: 'photo_' + new Date().getTime(),
        userId: this.currentUser.id,
        userName: this.currentUser.name,
        avatar: this.currentUser.avatar,
        content: '刚刚拍了一张照片！',
        time: '刚刚',
        likes: 0,
        comments: 0,
        shares: 0,
        type: 'image'
      };

      const updatedPosts: Post[] = [];
      updatedPosts.push(photoPost);
      for (let i = 0; i < this.posts.length; i++) {
        updatedPosts.push(this.posts[i]);
      }
      this.posts = updatedPosts;

    }, 2000);
  }

  // 选择文件功能
  private selectFile(): void {
    console.log('调用系统文件管理器');
    this.isSelectingFile = true;

    // 模拟文件选择过程
    setTimeout(() => {
      this.isSelectingFile = false;
      console.log('文件选择完成');

      // 在实际应用中，这里应该处理文件选择器返回的文件
      // 例如：将文件信息添加到帖子内容中

      // 这里我们只是模拟添加一条包含文件的帖子
      const filePost: Post = {
        id: 'file_' + new Date().getTime(),
        userId: this.currentUser.id,
        userName: this.currentUser.name,
        avatar: this.currentUser.avatar,
        content: '上传了一个文件！',
        time: '刚刚',
        likes: 0,
        comments: 0,
        shares: 0,
        type: 'file'
      };

      const updatedPosts: Post[] = [];
      updatedPosts.push(filePost);
      for (let i = 0; i < this.posts.length; i++) {
        updatedPosts.push(this.posts[i]);
      }
      this.posts = updatedPosts;

    }, 1500);
  }

  // 发布新帖子
  private publishPost(): void {
    if (!this.newPostContent.trim()) {
      console.log('请输入内容');
      return;
    }

    // 创建新帖子
    const newPost: Post = {
      id: 'post_' + new Date().getTime(),
      userId: this.currentUser.id,
      userName: this.currentUser.name,
      avatar: this.currentUser.avatar,
      content: this.newPostContent,
      time: '刚刚',
      likes: 0,
      comments: 0,
      shares: 0,
      type: 'text'
    };

    // 更新帖子列表
    const updatedPosts: Post[] = [];
    updatedPosts.push(newPost);

    for (let i = 0; i < this.posts.length; i++) {
      updatedPosts.push(this.posts[i]);
    }

    this.posts = updatedPosts;
    this.newPostContent = '';

    console.log('发布成功');
  }

  // 点赞帖子
  private likePost(postId: string): void {
    const updatedPosts: Post[] = [];

    for (let i = 0; i < this.posts.length; i++) {
      const post = this.posts[i];
      if (post.id === postId) {
        // 创建新对象
        const updatedPost: Post = {
          id: post.id,
          userId: post.userId,
          userName: post.userName,
          avatar: post.avatar,
          content: post.content,
          time: post.time,
          likes: post.likes + 1,
          comments: post.comments,
          shares: post.shares,
          type: post.type
        };
        updatedPosts.push(updatedPost);
      } else {
        updatedPosts.push(post);
      }
    }

    this.posts = updatedPosts;
    console.log('点赞帖子:', postId);
  }

  // 评论帖子
  private commentPost(postId: string): void {
    const updatedPosts: Post[] = [];

    for (let i = 0; i < this.posts.length; i++) {
      const post = this.posts[i];
      if (post.id === postId) {
        const updatedPost: Post = {
          id: post.id,
          userId: post.userId,
          userName: post.userName,
          avatar: post.avatar,
          content: post.content,
          time: post.time,
          likes: post.likes,
          comments: post.comments + 1,
          shares: post.shares,
          type: post.type
        };
        updatedPosts.push(updatedPost);
      } else {
        updatedPosts.push(post);
      }
    }

    this.posts = updatedPosts;
    console.log('评论帖子:', postId);
  }

  // 分享帖子
  private sharePost(postId: string): void {
    const updatedPosts: Post[] = [];

    for (let i = 0; i < this.posts.length; i++) {
      const post = this.posts[i];
      if (post.id === postId) {
        const updatedPost: Post = {
          id: post.id,
          userId: post.userId,
          userName: post.userName,
          avatar: post.avatar,
          content: post.content,
          time: post.time,
          likes: post.likes,
          comments: post.comments,
          shares: post.shares + 1,
          type: post.type
        };
        updatedPosts.push(updatedPost);
      } else {
        updatedPosts.push(post);
      }
    }

    this.posts = updatedPosts;
    console.log('分享帖子:', postId);
  }
}