//
// Steps & Time Data Field
// Shows current daily steps and time of day
//

import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

//! Main application class
class StepsTimeApp extends Application.AppBase {

    //! Constructor
    public function initialize() {
        AppBase.initialize();
    }

    //! Return the initial view for the app
    public function getInitialView() {
        return [new StepsTimeView()];
    }
}

//! Application entry point
function getApp() as Application.AppBase {
    return Application.getApp();
}
