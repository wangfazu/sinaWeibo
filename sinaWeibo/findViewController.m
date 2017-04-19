//
//  findViewController.m
//  sinaWeibo
//
//  Created by app on 17/4/13.
//  Copyright © 2017年 Feizj. All rights reserved.
//

#import "findViewController.h"

@interface findViewController ()

@end

@implementation findViewController
{
    
    UIScrollView *hotOrStarView;
    UITableView *hotTableView ;
    UITableView *starTableView ;
    NSArray *arr;
    NSMutableArray *dataArr;
    NSMutableArray *dataArr2;
    NSMutableArray *fourseArr;
    NSMutableArray *fourseArr2;
    UITableView *temptableView ;
    NSString *Token;
    NSDictionary *jsonObject;
    NSInteger weiboNumCount;
    NSString *weiboDetilString;
    CGSize weiboStringsize;
}
/**
 *  在视图即将加载的时候，隐藏findViewController的navigationBar上面的所有东西，包括文字
 */
- (void)viewWillAppear:(BOOL)animated{
   
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden=YES;
    
    self.tabBarController.tabBar.hidden=NO;

    

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
  
   //NSLog(@"%@  ",[jsonObject objectForKey:)
    self.title = @"发现";
    /**
     控制点赞的，0 -》为点赞
               1 -》已点赞
     */
    #pragma mark - 控制点赞的，0 -》为点赞   1 -》已点赞
  
    dataArr=[[NSMutableArray alloc]init];
    fourseArr = [[NSMutableArray alloc]init];
    dataArr2=[[NSMutableArray alloc]init];
    fourseArr2= [[NSMutableArray alloc]init];
    
    for (int i=0; i<20; i++) {
        [dataArr addObject:@"0"];
        [fourseArr addObject:@"+关注"];
        [dataArr2 addObject:@"0"];
        [fourseArr2 addObject:@"+关注"];
          }
  
    NSLog(@"%@   nicaiciai",dataArr2);
    #pragma mark -  通过BUtton来进入hotView，或者starView
    
    /**
     通过BUtton来进入hotView，或者starView
     */
    UIButton *hotBtn = [[UIButton alloc]initWithFrame:CGRectMake(w/2-60, 10, 40, 40)];
    //hotBtn.backgroundColor = [UIColor purpleColor];
    [hotBtn setTitle:@"热门" forState:normal];
    [self.view addSubview:hotBtn];
    [hotBtn addTarget:self action:@selector(goToHotView) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *starBtn = [[UIButton alloc]initWithFrame:CGRectMake(w/2+30, 10, 40, 40)];
    //starBtn.backgroundColor = [UIColor redColor];
    [starBtn setTitle:@"明星" forState:normal];
    [self.view addSubview:starBtn];
    [starBtn addTarget:self action:@selector(goToStarView) forControlEvents:UIControlEventTouchUpInside];
    #pragma mark - 初始化UIScrollView
    /**
     *  初始化UIScrollView
     */
    hotOrStarView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, w, h)];
    hotOrStarView.backgroundColor = [UIColor purpleColor];
    hotOrStarView.delegate=self;
    hotOrStarView.contentSize = CGSizeMake(2*w, h);
    [self.view addSubview:hotOrStarView];
    
    /**
      测试UIScrollView是否可行的lab
     */
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 88, 100)];
    lab.backgroundColor= [UIColor whiteColor];
    [hotOrStarView addSubview:lab];
    #pragma mark - 初始化，已经创建的hotTableView &  starTableView
    /**
     *初始化，已经创建的hotTableView &  starTableView
     */
    hotTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, w, h) style:UITableViewStyleGrouped];
    hotTableView.delegate = self;
    hotTableView.dataSource = self;
    [hotOrStarView addSubview:hotTableView];
    /**
     *  初始化
     *
     *
     */
    starTableView = [[UITableView alloc]initWithFrame:CGRectMake(w, 0, w, h) style:UITableViewStyleGrouped];
    starTableView.delegate = self;
    starTableView.dataSource = self;
    [hotOrStarView addSubview:starTableView];
    
    
       temptableView=hotTableView;
    /**
     *  网络请求
     */
//    NSString *urlString=@"https://api.weibo.com/oauth2/access_token?client_id=2412034927&client_secret=9b6c3fcadd485c91451266b9959cef11&grant_type=authorization_code&redirect_uri=YOUR_REGISTERED_REDIRECT_URI&code=CODE";
//    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//        NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        
//        
//        NSData *aJsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
//        
//        NSError *error = nil;
//        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:aJsonData
//                                                                   options:NSJSONReadingMutableContainers
//                                                                     error:&error];
//    }];

    /************************************数据处理************************************************/
    
    
    
    
    
    /************************************⬆️************************************************/
    
    
    
    
    Token=[[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    
    if (Token) {
        NSString *urlString=[NSString stringWithFormat:@"https://api.weibo.com/2/statuses/public_timeline.json?access_token=%@",Token];
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            
            NSData *aJsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
            
            NSError *error = nil;
            jsonObject = [NSJSONSerialization JSONObjectWithData:aJsonData
                                                         options:NSJSONReadingMutableContainers
                          
                          
                                                           error:&error];
            
            
            //NSLog(@"获取的微博总数 %ld",[[jsonObject objectForKey:@"statuses"] count]);
            /**
             *  获取用户
             */
            NSLog(@"ID -----%@",[[jsonObject objectForKey:@"statuses"][0]  objectForKey:@"text"] );
            
           // weiboDetilString = [[jsonObject objectForKey:@"statuses"][0]  objectForKey:@"text"];
            weiboNumCount = [[jsonObject objectForKey:@"statuses"] count];
              NSLog(@"%@",[jsonObject objectForKey:@"statuses"][0]);
            [hotTableView reloadData];
          
            
            
//            NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)firstObject];
//            
//            NSString *newFielPath = [documentsPathstringByAppendingPathComponent:@"aa.txt” ];
//            
            
        }];
        
        NSLog(@"finish to request!!!");
    }
    
    
 }
/**
 *  对 scrollView 偏移量 进行操作
 根据偏移量的不同抵达，不同的页面
 *    当偏移量 >   抵达新的页面
 *  @param scrollView
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (hotOrStarView==scrollView) { //将 scrollView 设置为当前的页面
        NSLog(@"%f------",scrollView.contentOffset.x);
        if (scrollView.contentOffset.x<375) {
            temptableView = hotTableView;
        }else{
            temptableView = starTableView;
        }
        

    }
}
#pragma mark - 通过UIScrollView 偏移量进入hotView & starView

- (void)goToHotView{//通过UIScrollView 偏移量进入hotView
//    hotViewController *hotView = [[hotViewController alloc]init];
//    [self presentViewController:hotView animated:YES completion:nil];
    

    [UIView animateWithDuration:0.75 animations:^{
          hotOrStarView.contentOffset = CGPointMake(0, 0);
    }];
    temptableView=hotTableView;
}
- (void)goToStarView{////通过UIScrollView 偏移量进入starView
    /**
     *  用动画效果来实现，动画效果
     */
        [UIView animateWithDuration:0.75 animations:^{
        hotOrStarView.contentOffset = CGPointMake(w, 0);
    }];
    temptableView=starTableView;
}
#pragma mark - 控制cell的个数  获取微博的数量
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return weiboNumCount;
}
#pragma mark - 初始化 cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 #pragma mark -  /*****************************热门  tableView***************/
/************************************************************************************/
    /**
     *  热门  tableView
     */
    if (tableView==hotTableView) {
        tableView.tag= 999;
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
#pragma mark - 创建用户的 ID
            /**
             创建用户的 ID
             */
            UILabel *useID = [[UILabel alloc]initWithFrame:CGRectMake(w/4, 10, w/2, h/20)];
            [cell addSubview:useID];
          //  useID.text = @"海贼王";
            useID.tag = 98007;
            useID.textColor = [UIColor redColor];
            // useID.backgroundColor = [UIColor blackColor];
            UILabel *usePushTime = [[UILabel alloc]initWithFrame:CGRectMake(w/4, 10+h/19, w/4, h/20)];
            [cell addSubview:usePushTime ];
#pragma mark - 创建时间戳，可以在网上获取，时间
            /**
             *  创建时间戳，可以在网上获取，时间
             */
            
            NSDate *nowdate =  [NSDate dateWithTimeIntervalSince1970:19990909];
            NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
            /**
             *  时间格式器
             */
            NSString *formatterString = @"yyyy-MM-dd HH:mm:ss";
            [formatter2 setDateFormat:formatterString];
            NSString *returnString = [formatter2 stringFromDate:nowdate];
            
            usePushTime.text = returnString;
            usePushTime.textColor = [UIColor blackColor];
            //usePushTime.backgroundColor = [UIColor blackColor];
            UILabel *useFrom = [[UILabel alloc]initWithFrame:CGRectMake(w/2+2, 10+h/19, w/4, h/20)];
            [cell addSubview:useFrom];
            useFrom.text = @"from China";
            useFrom.textColor = [UIColor blackColor];
            usePushTime.font = [UIFont systemFontOfSize:9];
            //useFrom.backgroundColor = [UIColor blackColor];
#pragma mark - 通过for循环创建三个按钮 =》 点赞.333，评论.334，转发.335 ;
            /**
             *  通过for循环创建三个按钮 =》 点赞，评论，转发
             */
            for (int i=0; i<3; i++) {
                myBtn *goodSendCommentBtn = [[myBtn alloc]initWithFrame:CGRectMake(i*w/3.1+5, h*3/5-30, w/3.1, 25)];
                goodSendCommentBtn.backgroundColor = [UIColor orangeColor];
                
                goodSendCommentBtn.tag = 333+i;
                goodSendCommentBtn.index = indexPath.row ;;
                
                [cell addSubview:goodSendCommentBtn];
            }
#pragma mark - 创建头像，的按钮，并设置tag 为 666
            /**
             创建头像，的按钮，并设置tag
             */
            UIButton *headBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, w/6, h/10)];
            headBtn.tag=666;
            headBtn.layer.cornerRadius = h/20 ;
            headBtn.clipsToBounds = YES;
            [cell addSubview:headBtn];
#pragma mark - 创建 关注 按钮 ，点击后变为  已关注 tag = 777
            /**
             *  创建 关注 按钮 ，点击后变为  已关注
             */
            myBtn *addFourseBtn = [[myBtn alloc]initWithFrame:CGRectMake(w-80, 10, w/5, 25)];
            addFourseBtn.backgroundColor = [UIColor lightGrayColor];
            addFourseBtn.tag = 777;
            addFourseBtn.index = indexPath.row;
            [cell addSubview:addFourseBtn];
            UILabel *weiboDetilLab = [[UILabel alloc]initWithFrame:CGRectMake(10, h/7.6, w-20, h/2.4)];
            weiboDetilLab.tag = 9527;
            weiboDetilLab.numberOfLines=0;
            [cell addSubview:weiboDetilLab];
            //weiboDetilLab.backgroundColor = [UIColor redColor];
            
            
        }
#pragma mark - index & tag 共同组成一个二维向量，来确定 button 准确的位置
        
        /**
         * index & tag 共同组成一个二维向量，来确定 button 准确的位置
         * 先由 myBtn 中 index 的属性 确定 按钮所在的 cell 的行数
         然后，通过 myBtn 相应的 tag 找到 分别找到 点赞，评论，转发 这三个按钮，添加与之对应的点击事件
         */
        myBtn *goodbtn = [cell viewWithTag:333];
        goodbtn.index=indexPath.row;
        NSString *str =[dataArr objectAtIndex:indexPath.row];
        [goodbtn setTitle:str forState:normal];
        [goodbtn addTarget:self action:@selector(goodbtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        myBtn *pinglunbtn = [cell viewWithTag:334];
        [pinglunbtn setTitle:@"评论" forState:normal];
        pinglunbtn.index = indexPath.row;
        [pinglunbtn addTarget:self action:@selector(pinglunClick:) forControlEvents:UIControlEventTouchUpInside];
        
        myBtn *zhuanfaBtn = [cell viewWithTag:335];
        zhuanfaBtn.index = indexPath.row;
        [zhuanfaBtn addTarget:self action:@selector(zhuangfaClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        /**
         *  为 headBtn 添加 图片 通过[UIImage imageNamed:@"tx"] 这种格式来电用，因为 [UIImage imageNamed:@"tx"] 方法，返回一个一个 Image 的对象
         */
        UIButton *headBtn = [cell viewWithTag:666];
        [headBtn setImage:[UIImage imageNamed:@"tx"]  forState:normal];
        
        /**
         *  对 添加关注 按钮，进行操作，点击是变为 已关注
         */
        myBtn *addFourseBTn = [cell viewWithTag:777];
        addFourseBTn.index = indexPath.row;
        NSString *fourseStr = [fourseArr objectAtIndex:indexPath.row];
        [addFourseBTn setTitle:fourseStr forState:normal];
        [addFourseBTn addTarget:self action:@selector(addFourseBTnClick:) forControlEvents:UIControlEventTouchUpInside];
        #pragma mark - 为微博设置正文内容
        /**
         *  为微博设置正文内容
         */
        weiboDetilString =  [[jsonObject objectForKey:@"statuses"][ indexPath.row ]  objectForKey:@"text"];
        /**
         *  由于微博内容长度的不同，对CELL进行变换
         */
         weiboStringsize = [weiboDetilString sizeWithFont:[UIFont systemFontOfSize:17] forWidth:w-20 lineBreakMode:NSLineBreakByWordWrapping];
        //NSLog(@"size------------%ld ",size.height);
        
//        size.width

        UILabel *weiboDetilLab = [cell viewWithTag:9527];
        weiboDetilLab.text = weiboDetilString;
        NSLog(@"%@",weiboDetilString);
        /**
         *  获取用户名
         */
        UILabel *useName = [cell viewWithTag:98007];
        useName.text =  [[[jsonObject objectForKey:@"statuses"][ indexPath.row ]  objectForKey:@"user"] objectForKey:@"name"];
        
        cell.selectionStyle = UITableViewCellStyleDefault;
        return  cell;

        
    }
    #pragma mark -  /*****************************明星  tableView***************/
 /************************************************************************************/
    /**
     *  明星  tableView
     */
    else{
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            tableView.tag =888;
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
#pragma mark - 创建用户的 ID
            /**
             创建用户的 ID
             */
            UILabel *useID = [[UILabel alloc]initWithFrame:CGRectMake(w/4, 10, w/2, h/20)];
            [cell addSubview:useID];
            useID.text = @"海贼王";
            useID.textColor = [UIColor redColor];
            // useID.backgroundColor = [UIColor blackColor];
            UILabel *usePushTime = [[UILabel alloc]initWithFrame:CGRectMake(w/4, 10+h/19, w/4, h/20)];
            [cell addSubview:usePushTime ];
#pragma mark - 创建时间戳，可以在网上获取，时间
            /**
             *  创建时间戳，可以在网上获取，时间
             */
            
            NSDate *nowdate =  [NSDate dateWithTimeIntervalSince1970:19990909];
            NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
            /**
             *  时间格式器
             */
            NSString *formatterString = @"yyyy-MM-dd HH:mm:ss";
            [formatter2 setDateFormat:formatterString];
            NSString *returnString = [formatter2 stringFromDate:nowdate];
            
            usePushTime.text = returnString;
            usePushTime.textColor = [UIColor blackColor];
            //usePushTime.backgroundColor = [UIColor blackColor];
            UILabel *useFrom = [[UILabel alloc]initWithFrame:CGRectMake(w/2+2, 10+h/19, w/4, h/20)];
            [cell addSubview:useFrom];
            useFrom.text = @"from China";
            useFrom.textColor = [UIColor blackColor];
            usePushTime.font = [UIFont systemFontOfSize:9];
            //useFrom.backgroundColor = [UIColor blackColor];
#pragma mark - 通过for循环创建三个按钮 =》 点赞.333，评论.334，转发.335 ;
            /**
             *  通过for循环创建三个按钮 =》 点赞，评论，转发
             */
            for (int i=0; i<3; i++) {
                myBtn *goodSendCommentBtn = [[myBtn alloc]initWithFrame:CGRectMake(i*w/3.1+5, h*3/5-30, w/3.1, 25)];
                goodSendCommentBtn.backgroundColor = [UIColor orangeColor];
                
                goodSendCommentBtn.tag = 333+i;
                goodSendCommentBtn.index = indexPath.row ;;
                
                [cell addSubview:goodSendCommentBtn];
            }
#pragma mark - 创建头像，的按钮，并设置tag 为 666
            /**
             创建头像，的按钮，并设置tag
             */
            UIButton *headBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, w/6, h/10)];
            headBtn.tag=666;
            headBtn.layer.cornerRadius = h/20 ;
            headBtn.clipsToBounds = YES;
            [cell addSubview:headBtn];
#pragma mark - 创建 关注 按钮 ，点击后变为  已关注 tag = 777
            /**
             *  创建 关注 按钮 ，点击后变为  已关注
             */
            myBtn *addFourseBtn = [[myBtn alloc]initWithFrame:CGRectMake(w-80, 4, w/5, 25)];
            addFourseBtn.backgroundColor = [UIColor lightGrayColor];
            addFourseBtn.tag = 777;
            addFourseBtn.index = indexPath.row;
            [cell addSubview:addFourseBtn];
            
            
            
        }
#pragma mark - index & tag 共同组成一个二维向量，来确定 button 准确的位置
        
        /**
         * index & tag 共同组成一个二维向量，来确定 button 准确的位置
         * 先由 myBtn 中 index 的属性 确定 按钮所在的 cell 的行数
         然后，通过 myBtn 相应的 tag 找到 分别找到 点赞，评论，转发 这三个按钮，添加与之对应的点击事件
         */
        myBtn *goodbtn = [cell viewWithTag:333];
        goodbtn.index=indexPath.row;
        NSString *str =[dataArr2 objectAtIndex:indexPath.row];
        [goodbtn setTitle:str forState:normal];
        NSLog(@"%@star的页面",str);
        [goodbtn addTarget:self action:@selector(goodbtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        myBtn *pinglunbtn = [cell viewWithTag:334];
        [pinglunbtn setTitle:@"评论" forState:normal];
        pinglunbtn.index = indexPath.row;
        [pinglunbtn addTarget:self action:@selector(pinglunClick:) forControlEvents:UIControlEventTouchUpInside];
        
        myBtn *zhuanfaBtn = [cell viewWithTag:335];
        zhuanfaBtn.index = indexPath.row;
        [zhuanfaBtn addTarget:self action:@selector(zhuangfaClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        /**
         *  为 headBtn 添加 图片 通过[UIImage imageNamed:@"tx"] 这种格式来电用，因为 [UIImage imageNamed:@"tx"] 方法，返回一个一个 Image 的对象
         */
        UIButton *headBtn = [cell viewWithTag:666];
        [headBtn setImage:[UIImage imageNamed:@"tx"]  forState:normal];
        
        /**
         *  对 添加关注 按钮，进行操作，点击是变为 已关注
         */
        myBtn *addFourseBTn = [cell viewWithTag:777];
        addFourseBTn.index = indexPath.row;
        NSString *fourseStr = [fourseArr2 objectAtIndex:indexPath.row];
        [addFourseBTn setTitle:fourseStr forState:normal];
        [addFourseBTn addTarget:self action:@selector(addFourseBTnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.selectionStyle = UITableViewCellStyleDefault;
        return  cell;

        
    }
    
  }
#pragma mark - 定义表格中每一个CELL的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSString *str  =  [[jsonObject objectForKey:@"statuses"][ indexPath.row ]  objectForKey:@"text"];
    /**
     *  由于微博内容长度的不同，对CELL进行变换
     */
    CGSize asize  = [str sizeWithFont:[UIFont systemFontOfSize:17] forWidth:w-20 lineBreakMode:NSLineBreakByWordWrapping];

    if (asize.height > 60) {
        return asize.height;
    }
   
    return h*3/5;
}
#pragma mark - 定义表格的头部
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == starTableView) {
        for (int i = 0; i<4; i++) {
#pragma mark - 创建四个 Button分别对应 “热门人物1000，特别推荐1001，娱乐明星1002，当地名人1003”
            /**
              创建四个 Button 分别对应 “热门人物，特别推荐，娱乐明星，当地名人”
             */
            UIButton *btttn = [[UIButton alloc]initWithFrame:CGRectMake(14+w/4*i, 44, 70, 70)];
            btttn.backgroundColor = [UIColor redColor];
            btttn.tag=1000+i;
            [btttn addTarget:self action:@selector(btttnClick:) forControlEvents:UIControlEventTouchUpInside];
            [tableView addSubview:btttn];
#pragma mark - 创建四个 lab分别对应 “热门人物2000，特别推荐2001，娱乐明星2002，当地名人2003”
            /**
             创建 四个 lab 分别为 “热门人物，特别推荐，娱乐明星，当地名人”
             */
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(14+w/4*i, 44+70+10, 70, 30)];
            //lab.backgroundColor = [UIColor greenColor];
            lab.tag = 2000 + i;
            [tableView addSubview:lab];
            NSArray *arr = @[@"热门人物",@"特别推荐",@"娱乐明星",@"当地名人"];
            lab.text = arr[i];
          
            }
     }
    if (tableView == hotTableView) {
        #pragma mark - 创建 button 分别 i = 0~3 对应最热门的 四个话题， 话题可以从微博直接获取，一个最简单的算法，取余运算！！
        /**
         创建 button 分别 i = 0~3 对应最热门的 四个话题， 话题可以从微博直接获取
         */
        
        for (int i=0; i<4; i++) {
            /**
             i = 0,1,2,3
             i%2 = 0,1,0,1
             i/2 = 0,0.5,1,1.5
             一个最简单的算法，取余运算！！！
             */
             #pragma mark - 一个最简单的算法，取余运算！！
            UIButton *btnnn1 = [[UIButton alloc]initWithFrame:CGRectMake(3.5+(7+w/2-7+7)*(i%2), 44+(7+30)*(i/2), w/2, 30)];
            /**
             *  将 btnnn1 上的字体颜色，更改为 黑色，系统默认为：白色；
             */
            [btnnn1 setTitleColor:[UIColor blackColor] forState:normal];
            btnnn1.tag=300+i;
            [btnnn1 addTarget:self action:@selector(goToHotTopicalDetialViewClick:) forControlEvents:UIControlEventTouchUpInside];
              arr = @[@"#朗读者王源#",@"#咸鱼如我#",@"#徐海乔生日快乐#",@"更多热门话题"];
            [btnnn1 setTitle:arr[i] forState:normal];
            [tableView addSubview:btnnn1];
        }
        
      
        
        
        
        
    }
#pragma mark - 创建搜索框
    /**
     *  创建搜索框
     */
    UITextField *serchView = [[UITextField alloc]initWithFrame:CGRectMake(7, 7, w-14, 30)];
    serchView.placeholder = @"请输入你想要搜索的内容";
    serchView.backgroundColor = [UIColor whiteColor];
    [tableView addSubview:serchView];

    
    if (tableView==hotTableView) {
        return  120;
    }
    
    return  160;
}







/*********************************************************************************/
/**
 *  事件点击相应
 *
 *  @param btn 所有事件点击
 */
#pragma mark - btn 所有事件点击
- (void)btttnClick:(UIButton *)btn{
    
    /**
     *  index所得到的是 tag 所对应的那个 button
     */
    
    NSInteger index=btn.tag-1000;
    /**
     初始化：热门人物，特别推荐，娱乐明星，当地名人这四个页面
     并在 navigationController 中进行 push操作，向右弹出相应的界面，自带返回方法
     */
    hotPeopleViewController *hotPeopleView = [[hotPeopleViewController alloc ]init];
    specialRecommendViewController *specialRecommendView = [[specialRecommendViewController alloc]init];
    amusementStarViewController *amusementStarView = [[amusementStarViewController alloc]init];
    localFamousPersonViewController *localFamousPersonView = [[localFamousPersonViewController alloc]init];
    /**
     *  通过 switch 来对 index 所对应的 button 进行事件点击相应
     0=> 热门人物
     1=> 特别推荐
     2=> 娱乐明星
     3=> 当地名人
     */
    
    switch (index) {
        case 0:
            [self.navigationController pushViewController:hotPeopleView animated:YES];
            break;
            
        case 1:
            [self.navigationController pushViewController:specialRecommendView animated:YES];
            
            break;
        case 2:
            [self.navigationController pushViewController:amusementStarView animated:YES];
            
            break;
        case 3:
            [self.navigationController pushViewController:localFamousPersonView animated:YES];
            
            break;
            
        default:
            break;
    }
    NSLog(@"你点击了第%ld个按钮",index);
    
    
    
    
}

- (void)goToHotTopicalDetialViewClick:(UIButton *)btn{
    NSInteger index = btn.tag-300;
    hotTopicDetailViewController *hotTopicDetailView = [[hotTopicDetailViewController alloc]init];
    /**
     *  将 arr 数组里面的东西，通过 array 这个数组传递到 hotTopicDetailView 中，hotTopicDetailView界面中就可以使用里面的内容了
     */
    hotTopicDetailView.array= arr[index];
    [self.navigationController pushViewController:hotTopicDetailView animated:YES];
}

- (void)goodbtnClick:(myBtn *)btn{
//    [dataArr replaceObjectAtIndex:btn.index withObject:@"已点赞"];
//    NSLog(@"@you select %ld row",btn.index);
//    //[btn setTitle:@"已点赞" forState:normal];
//    [hotTableView reloadData];
    if (temptableView ==  hotTableView) {
        [dataArr replaceObjectAtIndex:btn.index withObject:@"已点赞"];
        [hotTableView reloadData];
    }else if (temptableView == starTableView){
        [dataArr2 replaceObjectAtIndex:btn.index withObject:@"已点赞"];
        [starTableView reloadData];
        
    }

}

- (void)pinglunClick:(myBtn *)btn{
    
    NSLog(@"@you select %ld row",btn.index);
   // [hotTableView reloadData];
}

- (void)zhuangfaClick:(myBtn *)btn{
    btn.tag = 335;
//    [dataArr replaceObjectAtIndex:btn.index withObject:@"已点赞"];
//    NSLog(@"@you select %ld row",btn.index);
   // [hotTableView reloadData];
}

- (void)addFourseBTnClick:(myBtn *)btn{
    
    
   //UITableViewCell *cell = (UITableViewCell *)[btn superview];

    
    
    if (temptableView ==  hotTableView) {
        [fourseArr replaceObjectAtIndex:btn.index withObject:@"已关注"];
         [hotTableView reloadData];
   }
        else {
        [fourseArr2 replaceObjectAtIndex:btn.index withObject:@"已关注"];
        [starTableView reloadData];

 }
    
    
    
//    btn.tag = 777;
//   NSString *ofo = btn.titleLabel.text ;
    

   
  
    
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
