//
//  ViewController.m
//  CustomICarView
//
//  Created by cpwxw on 2022/10/14.
//

#import "ViewController.h"
#import "iCarousel.h"

typedef NS_ENUM(NSInteger, iCarAlignStyle){
    iCarAlignStyleCenter = 0,
    iCarAlignStyleLeftTop,
    iCarAlignStyleLeftBottom,
    iCarAlignStyleRightTop,
    iCarAlignStyleRightBottom,
};

@interface ViewController () <iCarouselDataSource, iCarouselDelegate>

@property (nonatomic, strong) iCarousel *icarview;

@property (nonatomic, assign) CGSize item_size;
@property (nonatomic, assign) CGFloat margin;
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) iCarAlignStyle alignStyle;
@property (nonatomic, strong) NSMutableArray *array_data;

@property (nonatomic, strong) UIButton *btn;

@property (nonatomic, assign) NSInteger page;

@end

@implementation ViewController
 
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.groupTableViewBackgroundColor;
    [self inits];
}

- (void)inits{
    
    self.icarview = [[iCarousel alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.icarview];
    self.icarview.scrollSpeed = .5;
    self.icarview.decelerationRate = .5;
    self.icarview.bounces = YES;
    self.icarview.pagingEnabled = YES;
    self.icarview.type = iCarouselTypeCustom;
    
    //    [self.icarview mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(@100);
    //        make.left.equalTo(@10);
    //        make.right.equalTo(@-10);
    //        make.height.equalTo(@110);
    //    }];
    self.icarview.backgroundColor = [UIColor clearColor];
    self.icarview.dataSource = self;
    self.icarview.delegate = self;
    
    self.btn = [[UIButton alloc]init];
    [self.btn setTitle:@"change style" forState:(UIControlStateNormal)];
    self.btn.layer.masksToBounds = YES;
    self.btn.layer.cornerRadius = 8;
    [self.btn setBackgroundColor:UIColor.greenColor];
    [self.btn setTitleColor:UIColor.whiteColor forState:(UIControlStateNormal)];
    [self.btn addTarget:self action:@selector(action_change) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.btn];
    
    self.icarview.frame = CGRectMake(10, 100, self.view.bounds.size.width-10*2, 110);
    self.btn.frame = CGRectMake(10, 100+110+20, self.view.bounds.size.width-20, 44);
    
    self.page = 0;
    self.array_data = [NSMutableArray array];
    
    [self action_change];
}

- (void)action_change{
    
    if(self.page == 0){//左大底边对齐
        self.item_size = CGSizeMake(81, 110);//min CGSizeMake(44, 60);
        self.margin = 10.0;
        self.scale = 6.0/11.0;
        self.alignStyle = iCarAlignStyleLeftBottom;
        self.array_data = @[
            @"http://p3-tt.byteimg.com/img/pgc-image/c3cf16275bb2409b883b20c53b8ae3d0~180x234.jpg",
            @"http://p3-tt.byteimg.com/img/novel-images/599f5272063fff081bef0a1206186997~180x234.jpg",
            @"http://p3-tt.byteimg.com/img/novel-images/f2c3add542e297a7a47ad88c2d4b0676~180x234.jpg",
            @"http://p3-tt.byteimg.com/img/pgc-image/4211f147cc894dbda232995fe353acd1~180x234.jpg",
            @"http://p3-tt.byteimg.com/img/novel-images/7752eb8177baf5e7dc73f6d85d4fd1ab~180x234.jpg",
            @"http://p3-tt.byteimg.com/img/novel-pic/b0f314174a55533555544aa42155fd65~180x234.jpg",
            @"http://p3-tt.byteimg.com/img/novel-pic/339e273d9adddac0dab2924311e21548~240x312.jpg",
            @"http://p3-tt.byteimg.com/img/novel-pic/2c174eef76a3aae821596014002d73e3~240x312.jpg",
        ].mutableCopy;
        
        self.icarview.frame = CGRectMake(10, 100, self.view.bounds.size.width-10*2, 110);
        self.btn.frame = CGRectMake(10, 100+110+20, self.view.bounds.size.width-20, 44);
        
    }else if (self.page == 1){
        CGFloat ratio = 131.0 / 414.0;
        CGFloat item_w = self.view.bounds.size.width-50*2;
        CGFloat item_h = ratio * item_w;
        self.item_size = CGSizeMake(item_w, item_h);//min CGSizeMake(44, 60);
        self.margin = 12.0;
        self.scale = 8.0/10.0;
        self.alignStyle = iCarAlignStyleCenter;
        self.array_data = @[
            @"https://img.zcool.cn/community/01c09259ddd589a801204463b9a295.jpg?x-oss-process=image/auto-orient,1/resize,m_lfit,w_1280,limit_1/sharpen,100/format,webp/quality,q_100",
            @"https://img.zcool.cn/community/01c2e659ddd58ea801204463e2b643.jpg?x-oss-process=image/auto-orient,1/resize,m_lfit,w_1280,limit_1/sharpen,100/format,webp/quality,q_100",
            @"https://img.zcool.cn/community/01530e59ddd591a80121ae0c1e8ebd.jpg?x-oss-process=image/auto-orient,1/resize,m_lfit,w_1280,limit_1/sharpen,100/format,webp/quality,q_100",
            @"https://img.zcool.cn/community/01200759df045ca80121ae0cb2bc29.jpg?x-oss-process=image/auto-orient,1/resize,m_lfit,w_1280,limit_1/sharpen,100/format,webp/quality,q_100",
            @"https://img.zcool.cn/community/01aa5859df0460a8012044638d4020.jpg?x-oss-process=image/auto-orient,1/resize,m_lfit,w_1280,limit_1/sharpen,100/format,webp/quality,q_100",
        ].mutableCopy;
        
        self.icarview.frame = CGRectMake(10, 100, self.view.bounds.size.width-10*2, item_h);
        self.btn.frame = CGRectMake(10, 100+item_h+20, self.view.bounds.size.width-20, 44);
        
    }else if (self.page == 2){
        self.item_size = CGSizeMake(110, 110);
        self.margin = 20.0;
        self.scale = 1.0/1.0;
        self.alignStyle = iCarAlignStyleCenter;
        self.array_data = @[
            @"http://p3-tt.byteimg.com/img/pgc-image/c3cf16275bb2409b883b20c53b8ae3d0~180x234.jpg",
            @"http://p3-tt.byteimg.com/img/novel-images/599f5272063fff081bef0a1206186997~180x234.jpg",
            @"http://p3-tt.byteimg.com/img/novel-images/f2c3add542e297a7a47ad88c2d4b0676~180x234.jpg",
            @"http://p3-tt.byteimg.com/img/pgc-image/4211f147cc894dbda232995fe353acd1~180x234.jpg",
            @"http://p3-tt.byteimg.com/img/novel-images/7752eb8177baf5e7dc73f6d85d4fd1ab~180x234.jpg",
            @"http://p3-tt.byteimg.com/img/novel-pic/b0f314174a55533555544aa42155fd65~180x234.jpg",
            @"http://p3-tt.byteimg.com/img/novel-pic/339e273d9adddac0dab2924311e21548~240x312.jpg",
            @"http://p3-tt.byteimg.com/img/novel-pic/2c174eef76a3aae821596014002d73e3~240x312.jpg",
        ].mutableCopy;
        
        self.icarview.frame = CGRectMake(10, 100, self.view.bounds.size.width-10*2, 110);
        self.btn.frame = CGRectMake(10, 100+110+20, self.view.bounds.size.width-20, 44);
    }
    

    self.page ++;
    if(self.page == 3){
        self.page = 0;
    }
    
    [self requestData];
}

- (void)requestData{
    
    NSArray *arr_s = self.array_data.mutableCopy;
    
    NSMutableArray *arr_more = [NSMutableArray array];
    CGFloat item_w_min = self.item_size.width * self.scale;
    CGFloat width_total = 0;
    while (width_total < (self.view.bounds.size.width-10*2) * 3) {
        [arr_more addObjectsFromArray:arr_s];
        width_total = (arr_more.count-1) * (item_w_min+self.margin) + (self.item_size.width+self.margin);
    };
    self.array_data = arr_more.mutableCopy;
    
    [self.icarview reloadData];
    
}

#pragma mark - icarousel data & dele

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(long)index reusingView:(UIView *)view{
    UIImageView *iv;
    if (view == nil) {
        view = [[UIView alloc] init];
        iv = [[UIImageView alloc]init];
        [view addSubview:iv];
        // [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        //     make.edges.equalTo(@0);
        // }];
        // [iv addBorderRadius:6 borderWidth:0 BorderColor:nil];
        // [iv addShadowView];
        iv.layer.masksToBounds = YES;
        iv.layer.borderColor = UIColor.lightGrayColor.CGColor;
        iv.layer.borderWidth = 1;
        iv.layer.cornerRadius = 8;
        
        iv.tag = 100;
                
    }else{
        iv = [view viewWithTag:100];
    }
    
    view.frame = CGRectMake(0, 0, self.item_size.width, self.item_size.height);
    iv.frame = view.bounds;
    
    dispatch_async( dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0 ), ^(void) {
        NSString *string = self.array_data[index];
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:string]];
        UIImage *resultImage = [UIImage imageWithData:imageData];
        dispatch_async( dispatch_get_main_queue(), ^(void){
            iv.image = resultImage;
        });
    });
    
    return view;
}

- (long)numberOfItemsInCarousel:(iCarousel *)carousel {
    return self.array_data.count;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
    
}

- (CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform{

    CGFloat scale = 1;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat margin = 0;
    
    margin = self.margin;
    
    if(offset >= 1){
        scale = self.scale;
    }else if (offset > 0){//线性变化过程
        CGFloat height = offset * (self.item_size.height*self.scale-self.item_size.height) + self.item_size.height;
        scale = height / self.item_size.height;
    }else if (offset == 0){
        scale = 1;
    }else if (offset > -1){
        CGFloat height = -offset * (self.item_size.height*self.scale-self.item_size.height) + self.item_size.height;
        scale = height / self.item_size.height;
    }else{
        scale = self.scale;
    }
        
    if(offset >= 1){
        x = offset * self.item_size.width + margin*offset + (self.item_size.width-self.item_size.width*scale)*.5 - offset*(self.item_size.width-self.item_size.width*scale);
    }else if (offset > 0){//线性变化过程
        x = offset * self.item_size.width + margin*offset + (self.item_size.width-self.item_size.width*scale)*.5 - (self.item_size.width-self.item_size.width*scale);
    }else if (offset == 0){
        x = offset * self.item_size.width + margin*offset ;
    }else if (offset > -1){
        x = offset * self.item_size.width + margin*offset - (self.item_size.width-self.item_size.width*scale)*.5 + (self.item_size.width-self.item_size.width*scale);
    }else{
        x = offset * self.item_size.width + margin*offset - (self.item_size.width-self.item_size.width*scale)*.5 - offset*(self.item_size.width-self.item_size.width*scale);
    }

    switch (self.alignStyle) {
        case iCarAlignStyleLeftTop:{
            CGFloat offset_x_custom = (self.icarview.bounds.size.width - self.item_size.width) * .5;
            x = x - offset_x_custom;
            y = -[self y_offset:offset];
        }break;
        case iCarAlignStyleRightTop:{
            CGFloat offset_x_custom = (self.icarview.bounds.size.width - self.item_size.width) * .5;
            x = x + offset_x_custom;
            y = -[self y_offset:offset];
        }break;
        case iCarAlignStyleLeftBottom:{
            CGFloat offset_x_custom = (self.icarview.bounds.size.width - self.item_size.width) * .5;
            x = x - offset_x_custom;
            y = +[self y_offset:offset];
        }break;
        case iCarAlignStyleRightBottom:{
            CGFloat offset_x_custom = (self.icarview.bounds.size.width - self.item_size.width) * .5;
            x = x + offset_x_custom;
            y = +[self y_offset:offset];
        }break;
        default:{
            y = 0;
        }break;
    }
    
    //顶部对齐 -y  底部对齐 y
    //CGFloat z = (NSInteger)offset;
    transform = CATransform3DTranslate(transform, x, y, 1);
    transform = CATransform3DScale(transform, scale, scale, 1);
    
    return transform;
}

- (CGFloat)y_offset:(CGFloat)offset{
    CGFloat y = 0;
    if(offset >= 1){
        y = .5*(self.item_size.height*(1-self.scale));
    }else if (offset > 0){//线性变化过程
        y = .5*(self.item_size.height*(1-self.scale))*offset;
    }else if(offset == 0){
        y = 0;
    }else if (offset > -1){
        y = -.5*(self.item_size.height*(1-self.scale))*offset;
    }else{
        y = .5*(self.item_size.height*(1-self.scale));
    }
    return y;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    switch (option){
        case iCarouselOptionWrap:{
            return YES;
        }
       
        default:{
            return value;
        }
    }
}

@end
