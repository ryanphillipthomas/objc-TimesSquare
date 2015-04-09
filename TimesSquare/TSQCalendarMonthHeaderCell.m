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
@property (nonatomic, strong) NSArray *headerLabelTopSeparators;
@property (nonatomic, strong) NSArray *headerLabelBottomSeparators;

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

- (BOOL) showHeaderDayLabelTopSeparator
{
	return NO;
}

- (BOOL) showHeaderDayLabelBottomSeparator
{
	return NO;
}

- (UIColor *) headerDayLabelSeparatorBackgroundColor
{
	return [UIColor grayColor];
}

- (UIColor *) monthHeaderBackgroundColor
{
	return [UIColor clearColor];
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
	NSMutableArray *headerLabelTopSeparators = [NSMutableArray arrayWithCapacity:self.daysInWeek];
	NSMutableArray *headerLabelBottomSeparators = [NSMutableArray arrayWithCapacity:self.daysInWeek];
    
    NSDateFormatter *dayFormatter = [NSDateFormatter new];
    dayFormatter.calendar = self.calendar;
	dayFormatter.dateFormat = self.headerLabelDateFormatterPattern;
    
    for (NSUInteger index = 0; index < self.daysInWeek; index++) {
        [headerLabels addObject:@""];
    }
	if(self.showHeaderDayLabelTopSeparator) {
		for (NSUInteger index = 0; index < self.daysInWeek; index++) {
			[headerLabelTopSeparators addObject:@""];
		}
	}
	if(self.showHeaderDayLabelBottomSeparator) {
		for (NSUInteger index = 0; index < self.daysInWeek; index++) {
			[headerLabelBottomSeparators addObject:@""];
		}
	}
	
    for (NSUInteger index = 0; index < self.daysInWeek; index++) {
		
		// day of week label
        NSInteger ordinality = [self.calendar ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:referenceDate];
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

		if(self.showHeaderDayLabelTopSeparator) {
			// top separator
			UIView *topSeparator = [[UIView alloc] initWithFrame:label.frame];
			headerLabelTopSeparators[ordinality - 1] = topSeparator;
			[self.contentView addSubview:topSeparator];
		}
		if(self.showHeaderDayLabelBottomSeparator) {
			// bottom separator
			UIView *bottomSeparator = [[UIView alloc] initWithFrame:label.frame];
			headerLabelBottomSeparators[ordinality - 1] = bottomSeparator;
			[self.contentView addSubview:bottomSeparator];
		}
		
        referenceDate = [self.calendar dateByAddingComponents:offset toDate:referenceDate options:0];
    }
    
    self.headerLabels = headerLabels;
	self.headerLabelTopSeparators = headerLabelTopSeparators;
	self.headerLabelBottomSeparators = headerLabelBottomSeparators;
	
	if(!self.disableMonthHeaders) {
		self.textLabel.font = self.headerMonthLabelFont;
		self.textLabel.textAlignment = NSTextAlignmentCenter;
		self.textLabel.textColor = self.headerMonthTextColor;
		self.textLabel.shadowColor = [UIColor whiteColor];
		self.textLabel.shadowOffset = self.shadowOffset;
		self.textLabel.backgroundColor = self.monthHeaderBackgroundColor;
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
	labelFrame.size.height = self.headerCellMonthsHeight;
	labelFrame.origin.y = self.bounds.size.height - self.headerCellMonthsHeight;
    label.frame = labelFrame;
	
	if(self.showHeaderDayLabelTopSeparator) {
		UIView *topSeparator = self.headerLabelTopSeparators[index];
		CGRect topSeparatorFrame = rect;
		topSeparatorFrame.size.height = (1.0f / [UIScreen mainScreen].scale);
		topSeparatorFrame.origin.y = label.frame.origin.y;
		topSeparator.frame = topSeparatorFrame;
	}
	if(self.showHeaderDayLabelBottomSeparator) {
		UIView *bottomSeparator = self.headerLabelBottomSeparators[index];
		CGRect bottomSeparatorFrame = rect;
		bottomSeparatorFrame.size.height = (1.0f / [UIScreen mainScreen].scale);
		bottomSeparatorFrame.origin.y = self.bounds.size.height - (1.0f / [UIScreen mainScreen].scale);
		bottomSeparator.frame = bottomSeparatorFrame;
	}
}

- (void)setFirstOfMonth:(NSDate *)firstOfMonth;
{
    [super setFirstOfMonth:firstOfMonth];
	if(!self.disableMonthHeaders) {
		self.textLabel.text = [self.monthDateFormatter stringFromDate:firstOfMonth];
		self.accessibilityLabel = self.textLabel.text;
		self.textLabel.backgroundColor = self.monthHeaderBackgroundColor;
	}
}

- (void)setBackgroundColor:(UIColor *)backgroundColor;
{
    [super setBackgroundColor:backgroundColor];
    for (UILabel *label in self.headerLabels) {
        label.backgroundColor = self.headerDayLabelBackgroundColor ? self.headerDayLabelBackgroundColor : backgroundColor;
    }
	if(self.showHeaderDayLabelTopSeparator) {
		for (UIView *separator in self.headerLabelTopSeparators) {
			separator.backgroundColor = self.headerDayLabelSeparatorBackgroundColor;
		}
	}
	if(self.showHeaderDayLabelBottomSeparator) {
		for (UIView *separator in self.headerLabelBottomSeparators) {
			separator.backgroundColor = self.headerDayLabelSeparatorBackgroundColor;
		}
	}
}

@end
