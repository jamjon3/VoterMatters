(function($) {
    $.widget("ui.voter", {
        options: {
            display: 'activate',
            speakText: 'No text was provided',
            url: 'espeakToOggService.php',
            attributesAudio: {
                controls: 'controls'
            }
        },
        _create: function() {
            var self = this,
                o = self.options,
                el = self.element;
                // self._buildDisplay(o.display);

            $.ajaxSetup({
                dataType : "json",
                type: "POST",
                // url: 'index3.php',
                title: 'Please wait...',
                beforeSend: function(XMLHttpRequest, settings) {
                    $.blockUI({
                        message: this.title,
                        css: {
                            border: 'none',
                            padding: '15px',
                            backgroundColor: '#00573C',
                            '-webkit-border-radius': '10px',
                            '-moz-border-radius': '10px',
                            opacity: .8,
                            color: '#fff'
                        }
                    });
                },
                complete: function() {
                    $.unblockUI();
                },
                async: true,
                error: function (jqXHR,  textStatus, errorThrown) {
                    if(jqXHR.status === 0) {
                        // Session has probably expired and needs to reload and let CAS take care of the rest
                        // alert('Your session has expired, the page will need to reload and you may be asked to log back in');
                        // reload entire page - this leads to login page
                        // window.location.reload();
                    }
                }
            });
        },
        destroy: function() {
            this.audioElement.remove();
            this.waitElement.remove();
        },
        _setOption: function(option, value) {
            $.Widget.prototype._setOption.apply( this, arguments );

            var self = this,
                el = self.element,
                o = self.options,
                au = self.audioElement;

            switch (option) {
                case "display":
                    o.display = value;
                    self._buildDisplay(value);
                    break;
                case "speakText":
                    o.speakText = value;
                    self._loadAudio();
                    break;
                case "attributesAudio":
                    o.attributesAudio = $.extend({},o.attributesAudio,value);
                    $.each(o.attributesAudio,function(key,value) {
                        au.attr(key,value);
                    });
                    break;
                case "removeAudioAttribute":
                    delete o.attributesAudio[value];
                    au.removeAttr(value);
                    break;
                case "url":
                    o.url = value;
                    break;
            }
        }
    });
})(jQuery);
