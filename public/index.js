window.addEvent('domready',function() {
   $$('input[type=text]').each(function(t) {
      t.set('value', t.title);
      t.addEvents({
         'focus': function() { t.value = (t.value == t.title ? '' : t.value); },
         'blur': function()  { t.value = (t.value == '' ? t.title : t.value); }
      });
   });
});
