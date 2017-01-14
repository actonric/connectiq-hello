using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Application as App;
using Toybox.Communications as Comm;

class helloView extends Ui.View {

        var url = "https://hooks.slack.com/services/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";
    	var params = {
    		"channel" => "@richard",
			"username" => "ram-bot",
			"text" => "test garmin slack integration",
			"icon_emoji" => ":athletic_shoe:"
		};
		var headers = {
			"Content-Type" => Comm.REQUEST_CONTENT_TYPE_JSON,
			"Accept" => "application/json"
		};
		var options = {
			:method => Comm.HTTP_REQUEST_METHOD_POST,
			:headers => headers
		};

 
		
    function initialize() {
        Ui.View.initialize();
    }
    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    // seems to be most helpful https://forums.garmin.com/showthread.php?358535-makeJsonRequest-makeWebRequest-examples but still not working
    // possibly helpful http://stackoverflow.com/questions/39680036/connect-iq-unexpected-type-error-when-using-settext
    //
		
	Comm.makeWebRequest(url, params, options, method(:onReceive)
		);	
    
	}
    

    // Update the view
    function onUpdate(dc) {
    
   
		
        // Get the current time and format it correctly
        var timeFormat = "$1$:$2$";
        var clockTime = Sys.getClockTime();
        var hours = clockTime.hour;
        if (!Sys.getDeviceSettings().is24Hour) {
            if (hours > 12) {
                hours = hours - 12;
            }
        } else {
            if (App.getApp().getProperty("UseMilitaryFormat")) {
                timeFormat = "$1$$2$";
                hours = hours.format("%02d");
            }
        }
        var timeString = Lang.format(timeFormat, [hours, clockTime.min.format("%02d")]);

        // Update the view
        var view = View.findDrawableById("TimeLabel");
        view.setColor(App.getApp().getProperty("ForegroundColor"));
        view.setText(timeString+"\nhello world");

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }


    function onReceive(responseCode, data) {
       responseCode.toString();
    }
    }