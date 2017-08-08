Timer = function(time_in_secs, path, windowobj) {  // window object must be injected, else location replace will fail specs
  var self = this;    // 'this' not avail in setInterval, must set to local var avail to all functions
  this.state = 'init'
  this.time_remaining = time_in_secs;
  this.timer_id = undefined;

  this.start = function() {
    // if restarting, there will be a timer id.  Clear it to prevent creating a new timer, reset time remaining
    if (this.timer_id !== undefined) {
      this.time_remaining = time_in_secs;
      this.clear_timer(this.timer_id, self); 
    }
    this.state = 'running';

    this.timer_id = setInterval(function() {    // IE any version does not allow args to setInterval.  Therefore, local variables or refer to self obj
      self.time_remaining -= 1;

      // log status every 10 seconds
      if ((self.time_remaining % 10) === 0) {
        console.log("logging user out in " + self.time_remaining + " seconds");
      };

      if (self.time_remaining <= 10) {
        alert(self.time_remaining + " seconds");
      };
      // when timer runs out, clear timer and redirect
      if ( self.time_remaining == 0 ) {
        self.clear_timer(self.timer_id, self);
        self.do_redirect(path, windowobj);
      };


    }, 1000);
    return this.timer_id;
  };

  this.clear_timer = function(timer_id, self) {
    self.state = 'stopped';
    clearInterval(self.timer_id);
  }

  this.remaining = function() {
    return this.time_remaining;
  };

  this.do_redirect = function(path, windowobj) {
    console.log("Redirecting to " + path);
    self.state = 'redirecting';
    windowobj.location = path;
  }
}