$(document).ready(function() {

  console.log(Gmaps.map)

//revenue

  var RevenueRangeFilter = {
    min: Market.min_revenue,
    max: Market.max_revenue,
  };

  $( "#filtered-rev" ).val( "$" + RevenueRangeFilter.min + " - $" + RevenueRangeFilter.max );

  $("#revenue-range").slider({
      range: true,
      min: Market.min_revenue,
      max: Market.max_revenue,
      values: [ 0, Market.max_revenue ],
      slide: function(event, ui) {
        RevenueRangeFilter.min = ui.values[0];
        RevenueRangeFilter.max = ui.values[1];
        applyAllFilters()
        $( "#filtered-rev" ).val( '$' +(ui.values[ 0 ]).formatMoney(0, '.', ',') + " - $" + (ui.values[ 1 ]).formatMoney(0, '.', ',') );
      }
    });

//properties

  var AllPropertyFilters = [];

  var markerCount = Gmaps.map.markers.length;

  $("input.showhide:checkbox").click(function() {
    var name       = $(this).data('property-name');
    var value      = $(this).data('property-value');
    var shouldShow = $(this).attr('checked') || 'unchecked';
    AllPropertyFilters = _.filter(AllPropertyFilters, function(propertyFilter){ return propertyFilter.name != name; });
    var filter = {name: name, value: value, shouldShow: shouldShow}
    AllPropertyFilters.push(filter);
    applyAllFilters();
  });



// dates

  var DateRangeFilter = {
    recent: 0,
    oldest: Market.max_days,
  };
  
  $( "#date-range" ).slider({
    range: true,
    min: 0,
    step: 1,
    max: Market.max_days,
    values: [ 0, Market.max_days ],
    slide: function(event, ui) {
      recent_day = Market.max_days - ui.values[1];
      oldest_day = Market.max_days - ui.values[0];
      DateRangeFilter.recent = recent_day;
      DateRangeFilter.oldest = oldest_day;
      var old_date = calculateDate(oldest_day);
      var recent_date = calculateDate(recent_day);
      $("#filtered-dates").val( dateToYMD(old_date) + " - " + dateToYMD(recent_date) );
      applyAllFilters();
    }
  });

  $("#filtered-dates").val(dateToYMD(calculateDate(Market.max_days)) + " - " + dateToYMD(calculateDate(0)))

  function calculateDate(days){
    date = new Date();
    date.setDate(date.getDate() - days );
    return date
  };

//categories

  var CategoryFilter = [];

  $(".chzn-select-categories").chosen();

  $("#categories").change(function(){
    CategoryFilter = $(this).val();
    applyAllFilters();
  });

//zips

  var ZipFilter = [];

  $(".chzn-select-zips").chosen();

  $("#zips").change(function(){
    ZipFilter = $(this).val();
    applyAllFilters();
  });


//markets

  $(".chzn-select-markets").chosen();

  $(".chzn-select-markets").change(function(){
    var id = $(".chzn-select-markets option:selected").attr('data-market-id')
    var source = '/markets/'+ id
    window.location.href = source;
  });

//filters
  var applyAllFilters = function() {
    _.each(Gmaps.map.markers, function(marker) {
      Gmaps.map.hideMarker(marker)
    })
    _.each(visibleMarkers(), function(marker) {
      Gmaps.map.showMarker(marker)
    })
  };

  var applyAllFilters = _.debounce(applyAllFilters, 10);


  var visibleMarkers = function() {
    var filtered = _.reject(Gmaps.map.markers, function(marker) {
      return _.all(marker.revenues, function(revenue) {return revenue < RevenueRangeFilter.min || revenue > RevenueRangeFilter.max;
      });
    });
    filtered = _.reject(filtered, function(marker) {
      return _.all(marker.days_since, function(days) {return days < DateRangeFilter.recent || days > DateRangeFilter.oldest;
      });
    });
    if(CategoryFilter && CategoryFilter.length) {
      filtered = _.reject(filtered, function(marker) {
        return _.all(marker.categories, function(category) {
          return _.all(CategoryFilter, function(filterCategory){
            return filterCategory != category
          });
        });
      });
    }
    if(ZipFilter && ZipFilter.length) {
      filtered = _.reject(filtered, function(marker) {
        return _.all(ZipFilter, function(filterZip){
          return filterZip != marker.zip
        });
      });
    };
    _.each(AllPropertyFilters, function(filter){
      filtered = _.reject(filtered, function(marker) {
        return marker[filter.name] == filter.value && filter.shouldShow == "unchecked"
      });
    });
    $('.deals-returned').text(filtered.length + " Merchants Returned")
    return filtered
  };


//filter resets

  $('.filters-reset').click(function(){
    clearZips();
    clearCategories();
    clearProviders();
    clearRevenue();
    clearDates();
  });


  $('.zip-reset').click(function(){
    clearZips()
  });

  var clearZips = function() {
    $(".chzn-select-zips").val('').trigger("liszt:updated");
    ZipFilter = [];
    $('#zip-boxes .showhide').prop("checked", true);
    _.each($('#zip-boxes .showhide'),function(box){
      AllPropertyFilters = _.filter(AllPropertyFilters, function(propertyFilter){ return propertyFilter.name != $(box).attr('data-property-name'); });
    });
    applyAllFilters();
  }

  $('.category-reset').click(function() {
    clearCategories();
  });

  var clearCategories = function() {
    $(".chzn-select-categories").val('').trigger("liszt:updated");
    CategoryFilter = [];
    applyAllFilters();
  }

  $('.provider-reset').click(function() {
    clearProviders();
  });

  var clearProviders = function() {
    $('#provider-boxes .showhide').prop("checked", true);
    _.each($('#provider-boxes .showhide'),function(box){
      AllPropertyFilters = _.filter(AllPropertyFilters, function(propertyFilter){ return propertyFilter.name != $(box).attr('data-property-name'); });
    });
    applyAllFilters();
  }

  $('.revenue-reset').click(function() {
    clearRevenue();
  });

  var clearRevenue = function() {
    $("#revenue-range").slider("values", 0, Market.min_revenue);
    $("#revenue-range").slider("values", 1, Market.max_revenue);
    RevenueRangeFilter.min = Market.min_revenue;
    RevenueRangeFilter.max = Market.max_revenue;
    $( "#filtered-rev" ).val( "$" + RevenueRangeFilter.min + " - $" + RevenueRangeFilter.max );
    applyAllFilters();
  }


  $('.date-reset').click(function() {
    clearDates();
  });

  var clearDates = function() {
    $("#date-range").slider("values", 0, 0);
    $("#date-range").slider("values", 1, Market.max_days);
    DateRangeFilter.recent = 0;
    DateRangeFilter.oldest = Market.max_days;
    $("#filtered-dates").val(dateToYMD(calculateDate(Market.max_days)) + " - " + dateToYMD(calculateDate(0)));
    applyAllFilters();
  }

//pins

  $('#placeme').click(function() {
    var lat = Gmaps.map.userLocation.$a;
    var lng = Gmaps.map.userLocation.ab;
    Gmaps.map.createMarker({Lat: lat,
                  Lng: lng,
                  rich_marker: null,
                  marker_picture: ""
                 });
    });

  $('.bouncepins').click(function() {
    var propName       = $(this).data('property-name');
    var propValue      = $(this).data('property-value');
    _.each(Gmaps.map.markers, function(marker) {
      if(marker[propName] == propValue) {
        Gmaps.map.bounceMarker(marker);
        setTimeout(function() { Gmaps.map.stopMarker(marker); }, 1125 * 2);
      }
    });
  });


//formatting

  Number.prototype.formatMoney = function(c, d, t){
  var n = this, c = isNaN(c = Math.abs(c)) ? 2 : c, d = d == undefined ? "," : d, t = t == undefined ? "." : t, s = n < 0 ? "-" : "", i = parseInt(n = Math.abs(+n || 0).toFixed(c)) + "", j = (j = i.length) > 3 ? j % 3 : 0;
     return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : "");
   };

  function dateToYMD(date){
    return $.datepicker.formatDate('M dd yy', date);
  };

//accordion

  $(function(){
        $('#multiAccordion').multiAccordion();
  });

});