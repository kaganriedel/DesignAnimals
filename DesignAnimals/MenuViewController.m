//
//  ViewController.m
//  DesignAnimals
//
//  Created by Kagan Riedel on 8/20/14.
//  Copyright (c) 2014 612 Development. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

#pragma mark - Private Properties

@property (strong, nonatomic) NSArray *leftButtons;
@property (strong, nonatomic) NSArray *rightButtons;

#pragma mark - IBOutlets

@property (weak, nonatomic) IBOutlet UIButton *allAnimalsButton;
@property (weak, nonatomic) IBOutlet UIButton *landAnimalsButton;
@property (weak, nonatomic) IBOutlet UIButton *seaCreaturesButton;
@property (weak, nonatomic) IBOutlet UIButton *wingedAnimalsButton;
@property (weak, nonatomic) IBOutlet UIButton *mythicalCreaturesButton;
@property (weak, nonatomic) IBOutlet UIButton *tutorialButton;
@property (weak, nonatomic) IBOutlet UIButton *settingsButton;

@end

@implementation MenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.leftButtons = @[self.allAnimalsButton,
                         self.seaCreaturesButton,
                         self.mythicalCreaturesButton,
                         self.settingsButton];
    
    self.rightButtons = @[self.landAnimalsButton,
                          self.wingedAnimalsButton,
                          self.tutorialButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    CGFloat viewWidth = self.view.frame.size.width;
    
    CGAffineTransform slideLeft = CGAffineTransformMakeTranslation(-viewWidth, 0.0);
    for (UIButton* button in self.rightButtons)
    {
        button.transform = slideLeft;
    }
    
    CGAffineTransform slideRight = CGAffineTransformMakeTranslation(viewWidth, 0.0);
    for (UIButton* button in self.leftButtons)
    {
        button.transform = slideRight;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSTimeInterval animationDuration = 0.5;
    NSTimeInterval halfAnimationDuration = animationDuration / 2.0;
    
    [self animateViewToIdentity:self.allAnimalsButton duration:animationDuration withDelay:halfAnimationDuration];
    [self animateViewToIdentity:self.landAnimalsButton duration:animationDuration withDelay:halfAnimationDuration];
    [self animateViewToIdentity:self.seaCreaturesButton duration:animationDuration withDelay:halfAnimationDuration];
    [self animateViewToIdentity:self.wingedAnimalsButton duration:animationDuration withDelay:halfAnimationDuration];
    [self animateViewToIdentity:self.mythicalCreaturesButton duration:animationDuration withDelay:halfAnimationDuration];
    [self animateViewToIdentity:self.tutorialButton duration:animationDuration withDelay:halfAnimationDuration];
    [self animateViewToIdentity:self.settingsButton duration:animationDuration withDelay:halfAnimationDuration];
}

- (void)animateViewToIdentity:(UIView*)view duration:(NSTimeInterval)duration withDelay:(NSTimeInterval)delay
{
    [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseOut animations:^{
        view.transform = CGAffineTransformIdentity;
    } completion:nil];
}

@end
