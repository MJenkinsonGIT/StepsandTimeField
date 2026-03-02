//
// Steps & Time Data Field View
// Displays current daily steps and time of day
//

import Toybox.Activity;
import Toybox.ActivityMonitor;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.Time;
import Toybox.WatchUi;

//! Main data field view class
class StepsTimeView extends WatchUi.DataField {
    
    // Display values
    private var _steps as Number;
    private var _timeString as String;
    
    //! Constructor
    public function initialize() {
        DataField.initialize();
        _steps = 0;
        _timeString = "--:--";
    }
    
    //! Called once when layout is determined
    public function onLayout(dc as Dc) as Void {
        // Layout handled by parent
    }
    
    //! Called periodically to update calculations
    public function compute(info as Activity.Info) as Void {
        // Get current steps from ActivityMonitor
        var activityInfo = ActivityMonitor.getInfo();
        if (activityInfo != null && activityInfo.steps != null) {
            _steps = activityInfo.steps;
        } else {
            _steps = 0;
        }
        
        // Get current time
        var clockTime = System.getClockTime();
        var hour = clockTime.hour;
        var minute = clockTime.min;
        
        // Format time based on device settings (12hr vs 24hr)
        var deviceSettings = System.getDeviceSettings();
        if (!deviceSettings.is24Hour) {
            // 12-hour format
            var amPm = "AM";
            if (hour >= 12) {
                amPm = "PM";
                if (hour > 12) {
                    hour = hour - 12;
                }
            }
            if (hour == 0) {
                hour = 12;
            }
            _timeString = hour.format("%d") + ":" + minute.format("%02d") + " " + amPm;
        } else {
            // 24-hour format
            _timeString = hour.format("%02d") + ":" + minute.format("%02d");
        }
    }
    
    //! Called to render the data field
    public function onUpdate(dc as Dc) as Void {
        // Get background/foreground colors
        var bgColor = getBackgroundColor();
        var fgColor = Graphics.COLOR_WHITE;
        if (bgColor == Graphics.COLOR_WHITE) {
            fgColor = Graphics.COLOR_BLACK;
        }
        
        // Clear screen
        dc.setColor(fgColor, bgColor);
        dc.clear();
        
        // Get dimensions
        var width = dc.getWidth();
        var height = dc.getHeight();
        var xCenter = width / 2;
        
        // Calculate positions for two rows
        var ySteps = height / 3;
        var yTime = (2 * height) / 3;
        
        // Draw Steps label (same color as value for consistency with default fields)
        dc.setColor(fgColor, Graphics.COLOR_TRANSPARENT);
        dc.drawText(xCenter, ySteps - 25, Graphics.FONT_XTINY, "Steps", Graphics.TEXT_JUSTIFY_CENTER);
        
        // Draw Steps value
        var stepsText = _steps.format("%d");
        dc.drawText(xCenter, ySteps + 2, Graphics.FONT_SMALL, stepsText, Graphics.TEXT_JUSTIFY_CENTER);
        
        // Draw Time value only (no label)
        dc.drawText(xCenter, yTime, Graphics.FONT_SMALL, _timeString, Graphics.TEXT_JUSTIFY_CENTER);
    }
}
