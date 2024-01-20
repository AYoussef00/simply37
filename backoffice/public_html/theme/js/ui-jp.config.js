// lazyload config
var theme_url = $('#base_url').val() + 'public_html/theme';
var jp_config = {
  easyPieChart:   [   theme_url + '/libs/jquery/jquery.easy-pie-chart/dist/jquery.easypiechart.fill.js'],
  sparkline:      [   theme_url + '/libs/jquery/jquery.sparkline/dist/jquery.sparkline.retina.js'],
  plot:           [   theme_url + '/libs/jquery/flot/jquery.flot.js',
                      theme_url + '/libs/jquery/flot/jquery.flot.pie.js', 
                      theme_url + '/libs/jquery/flot/jquery.flot.resize.js',
                      theme_url + '/libs/jquery/flot.tooltip/js/jquery.flot.tooltip.min.js',
                      theme_url + '/libs/jquery/flot.orderbars/js/jquery.flot.orderBars.js',
                      theme_url + '/libs/jquery/flot-spline/js/jquery.flot.spline.min.js'],
  moment:         [   theme_url + '/libs/jquery/moment/moment.js'],
  screenfull:     [   theme_url + '/libs/jquery/screenfull/dist/screenfull.min.js'],
  slimScroll:     [   theme_url + '/libs/jquery/slimscroll/jquery.slimscroll.min.js'],
  sortable:       [   theme_url + '/libs/jquery/html5sortable/jquery.sortable.js'],
  nestable:       [   theme_url + '/libs/jquery/nestable/jquery.nestable.js',
                      theme_url + '/libs/jquery/nestable/jquery.nestable.css'],
  filestyle:      [   theme_url + '/libs/jquery/bootstrap-filestyle/src/bootstrap-filestyle.js'],
  slider:         [   theme_url + '/libs/jquery/bootstrap-slider/bootstrap-slider.js',
                      theme_url + '/libs/jquery/bootstrap-slider/bootstrap-slider.css'],
  chosen:         [   theme_url + '/libs/jquery/chosen/chosen.jquery.min.js',
                      theme_url + '/libs/jquery/chosen/bootstrap-chosen.css'],
  TouchSpin:      [   theme_url + '/libs/jquery/bootstrap-touchspin/dist/jquery.bootstrap-touchspin.min.js',
                      theme_url + '/libs/jquery/bootstrap-touchspin/dist/jquery.bootstrap-touchspin.min.css'],
  wysiwyg:        [   theme_url + '/libs/jquery/bootstrap-wysiwyg/bootstrap-wysiwyg.js',
                      theme_url + '/libs/jquery/bootstrap-wysiwyg/external/jquery.hotkeys.js'],
  dataTable:      [   theme_url + '/libs/jquery/datatables/media/js/jquery.dataTables.min.js',
                      theme_url + '/libs/jquery/plugins/integration/bootstrap/3/dataTables.bootstrap.js',
                      theme_url + '/libs/jquery/plugins/integration/bootstrap/3/dataTables.bootstrap.css'],
  vectorMap:      [   theme_url + '/libs/jquery/bower-jvectormap/jquery-jvectormap-2.0.3.min.js', 
                      theme_url + '/libs/jquery/bower-jvectormap/jquery-jvectormap-world-mill-en.js',
                      theme_url + '/libs/jquery/bower-jvectormap/jquery-jvectormap-us-aea-en.js',
                      theme_url + '/libs/jquery/bower-jvectormap/jquery-jvectormap-2.0.3.css'],
  footable:       [   theme_url + '/libs/jquery/footable/v3/js/footable.min.js',
                          theme_url + '/libs/jquery/footable/v3/css/footable.bootstrap.min.css'],
  fullcalendar:   [   theme_url + '/libs/jquery/moment/moment.js',
                      theme_url + '/libs/jquery/fullcalendar/dist/fullcalendar.min.js',
                      theme_url + '/libs/jquery/fullcalendar/dist/fullcalendar.css',
                      theme_url + '/libs/jquery/fullcalendar/dist/fullcalendar.theme.css'],
  daterangepicker:[   theme_url + '/libs/jquery/moment/moment.js',
                      theme_url + '/libs/jquery/bootstrap-daterangepicker/daterangepicker.js',
                      theme_url + '/libs/jquery/bootstrap-daterangepicker/daterangepicker-bs3.css'],
  tagsinput:      [   theme_url + '/libs/jquery/bootstrap-tagsinput/dist/bootstrap-tagsinput.js',
                      theme_url + '/libs/jquery/bootstrap-tagsinput/dist/bootstrap-tagsinput.css']
                      
};