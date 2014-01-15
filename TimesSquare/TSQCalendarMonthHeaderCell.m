//
//  TSQCalendarMonthHeaderCell.m
//  TimesSquare
//
//  Created by Jim Puls on 11/14/12.
//  Licensed to Square, Inc. under one or more contributor license agreements.
//  See the LICENSE file distributed with this work for the terms under
//  which Square, Inc. licenses this file to you.

#import "TSQCalendarMonthHeaderCell.h"


@interface TSQCalendarMonthHeaderCell ()

@property (nonatomic, strong) NSDateFormatter *monthDateFormatter;

@end


@implementation TSQCalendarMonthHeaderCell

- (id)initWithCalendar:(NSCalendar *)calendar reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithCalendar:calendar reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    
    [self createHeaderLabels];
    
    return self;
}


+ (CGFloat)cellHeight;
{
    return 65.0f;
}

- (NSString *)headerDayLabelDateFormatterPattern
{
	return @"cccccc"; // Tu
}

- (CGFloat) headerLabelRectOffsetDX
{
	return 0.0f;
}

- (CGFloat) headerLabelRectOffsetDY
{
	return 5.0f;
}

- (BOOL) disableMonthHeaders
{
	return NO;
}

- (UIColor *) headerDayLabelTextColor
{
	return self.textColor;
}

- (CGFloat) columnSpacing
{
	return 1.0f / [UIScreen mainScreen].scale;
}

- (CGFloat) headerCellMonthsHeight
{
	return 20.0f;
}

- (UIFont *) headerDayLabelFont
{
	return [UIFont boldSystemFontOfSize:12.f];
}

- (UIFont *) headerMonthLabelFont
{
	return [UIFont systemFontOfSize:18.f];
}

- (UIColor *) headerMonthTextColor
{
	return self.textColor;
}

- (NSDateFormatter *)monthDateFormatter;
{
    if (!_monthDateFormatter) {
        _monthDateFormatter = [NSDateFormatter new];
        _monthDateFormatter.calendar = self.calendar;
        
        NSString *dateComponents = @"yyyyLLLL";
        _monthDateFormatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:dateComponents options:0 locale:[NSLocale currentLocale]];
    }
    return _monthDateFormatter;
}

- (void)createHeaderLabels;
{
    NSDate *referenceDate = [NSDate dateWithTimeIntervalSinceReferenceDate:0];
    NSDateComponents *offset = [NSDateComponents new];
    offset.day = 1;
    NSMutableArray *headerLabels = [NSMutableArray arrayWithCapacity:self.daysInWeek];
    
    NSDateFormatter *dayFormatter = [NSDateFormatter new];
    dayFormatter.calendar = self.calendar;
	dayFormatter.dateFormat = self.headerLabelDateFormatterPattern;
    
    for (NSUInteger index = 0; index < self.daysInWeek; index++) {
        [headerLabels addObject:@""];
    }
    
    for (NSUInteger index = 0; index < self.daysInWeek; index++) {
        NSInteger ordinality = [self.calendar ordinalityOfUnit:NSDayCalendarUnit inUnit:NSWeekCalendarUnit forDate:referenceDate];
        UILabel *label = [[UILabel alloc] initWithFrame:self.frame];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [dayFormatter stringFromDate:referenceDate];
		label.font = self.headerDayLabelFont;
		label.backgroundColor = self.backgroundColor;
        label.textColor = self.headerDayLabelTextColor;
        label.shadowColor = [UIColor whiteColor];
        label.shadowOffset = self.shadowOffset;
        [label sizeToFit];
        headerLabels[ordinality - 1] = label;
        [self.contentView addSubview:label];
        
        referenceDate = [self.calendar dateByAddingComponents:offset toDate:referenceDate options:0];
    }
    
    self.headerLabels = headerLabels;
	
	if(!self.disableMonthHeaders) {
		self.textLabel.font = self.headerMonthLabelFont;
		self.textLabel.textAlignment = NSTextAlignmentCenter;
		self.textLabel.textColor = self.headerMonthTextColor;
		self.textLabel.shadowColor = [UIColor whiteColor];
		self.textLabel.shadowOffset = self.shadowOffset;
	}
}

- (void)layoutSubviews;
{
    [super layoutSubviews];

	CGRect bounds = self.contentView.bounds;
	bounds.size.height -= self.headerCellMonthsHeight;
	self.textLabel.frame = CGRectOffset(bounds, self.headerLabelRectOffsetDX, self.headerLabelRectOffsetDY);
}

- (void)layoutViewsForColumnAtIndex:(NSUInteger)index inRect:(CGRect)rect;
{
    UILabel *label = self.headerLabels[index];
    CGRect labelFrame = rect;
	labelFrame.size.height = self.headerCellMonthsHeight * 2.0f;
	labelFrame.origin.y = self.bounds.size.height - (self.headerCellMonthsHeight + self.headerCellMonthsHeight / 2.0f);
    label.frame = labelFrame;
}

- (void)setFirstOfMonth:(NSDate *)firstOfMonth;
{
    [super setFirstOfMonth:firstOfMonth];
	if(!self.disableMonthHeaders) {
		self.textLabel.text = [self.monthDateFormatter stringFromDate:firstOfMonth];
		self.accessibilityLabel = self.textLabel.text;
	}
}

- (void)setBackgroundColor:(UIColor *)backgroundColor;
{
    [super setBackgroundColor:backgroundColor];
    for (UILabel *label in self.headerLabels) {
        label.backgroundColor = self.headerDayLabelBackgroundColor ? self.headerDayLabelBackgroundColor : backgroundColor;
    }
}

@end
