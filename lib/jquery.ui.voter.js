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
        addButton: function(name) {
            var self = this,
                o = self.options,
                el = self.element,
                bl = self.buttonList;
            $('<a />',{
                'href': '#',
                'data-role': 'button'
            })
            .val(name)
            .click(function() {
                $(this).parent().remove();
            })
            .appendTo(bl)
            .button();
        },
        addButtons: function(names) {
            var self = this;
            $.each(names,function(index,name) {
                self.addButton(name);
            });
        },
        removeButtons: function() {
            var self = this,
                o = self.options,
                el = self.element,
                bl = self.buttonList;
            bl.children().remove();
        },
        _create: function() {
            var self = this,
                o = self.options,
                el = self.element,
                page = $(self.page = $('div').first()),
                content = $(self.content=$('div',page).first()),
                name = $(self.name = $('input',page).first()),
                bi = $(self.buttonInput = $('<input />',{
                            'type': 'text',
                            'name': 'buttonInput',
                            'id': 'buttonInput'
                        })
                        .val("")
                        .appendTo(
                            $('<div />',{
                                'data-role': 'fieldcontain'
                            })
                            .append(
                                $('<legend />',{
                                    'for': 'buttonInput'
                                })
                                .append('Add text and click to create a new button')
                            )
                            .page()
                            .appendTo(content)

                        )
                        .textinput()
                    ),
                sb = $(self.startButton = $('<input />',{
                            'id': 'ajaxStartButton',
                            'type': 'button'
                        })
                        .val('Build Dynamic button set')
                        .appendTo(content)
                    )
                    .click(function() {
                        self.addButton(bi.val());
                    })
                    .button(),
                bl = $(self.buttonList = $('<div />',{
                            'data-role': 'controlgroup',
                            'data-type': 'horizontal'
                        })
                        .page()
                        .addClass('ui-corner-all ui-controlgroup-horizontal')
                        .appendTo(content)
                    );
                // $.mobile.initializePage;
                // self._buildDisplay(o.display);
                // $.mobile.changePage()
            $.ajaxSetup({
                dataType : "json",
                type: "POST",
                // url: 'index3.php',
                title: 'Please wait...',
                beforeSend: function(XMLHttpRequest, settings) {

                    //$.blockUI({
                    //    message: this.title,
                    //    css: {
                    //        border: 'none',
                    //        padding: '15px',
                    //        backgroundColor: '#00573C',
                    //        '-webkit-border-radius': '10px',
                    //        '-moz-border-radius': '10px',
                    //        opacity: .8,
                    //        color: '#fff'
                    //    }
                    //});
                },
                complete: function() {
                    // $.unblockUI();
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
