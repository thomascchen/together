$(document).ready(function() {
  $(window).load(function() {
    if (Cookies.get('dialogShown') != 'true') {
      $('.welcome-modal').trigger('click');
      Cookies.set('dialogShown', 'true', { expires: 1 });
    };
  });
});
