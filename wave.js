(function(global) {
    global.Wave = function (opt) {        
        if ((!opt) || (typeof(opt) != 'object')) {
            this.inited = false;
            return;
        }
        this.rad = opt.rad || 20;
        this.cx = opt.cx || 10;
        this.cy = opt.cy || 10;
        this.paper = opt.paper || Raphael(0, 0, 800, 800);
        this.rad_inc = 20;
        this.next_rad = this.rad + this.rad_inc;
        this.ring_color = opt.ring_color || '#000000';
        this.delay = opt.delay || 20;
        this.erase_back = true;
        if (opt.hasOwnProperty('erase_back')) {
            this.erase_back = opt.erase_back;
        }
        this.inited = true;
    };
    
    global.Wave.prototype.start = function () {
        if (!this.inited) {
            return;
        }
        var that = this;
        if (!global.setInterval || !global.clearInterval) {
            return;
        }
        this.in_id = global.setInterval(function () {
            //console.log('Circle@(%i, %i)@(rad:%i)', that.cx, that.cy, that.rad);
            if (that.prev_circle) {
                if (that.erase_back) {
                    that.prev_circle.attr('stroke', '#ffffff');
                }
            }
            that.prev_circle = that.paper.circle(that.cx, that.cy, that.rad);
            that.rad = that.next_rad;
            that.next_rad += that.rad_inc;
            if (that.rad > (that.paper.width + that.rad_inc + 100) && 
                that.rad > (that.paper.height + that.rad_inc + 100)) {
                global.clearInterval(that.in_id);
            }
        }, that.delay);
    };
})(this);
