 // This example adds a search box to a map, using the Google Place Autocomplete
// feature. People can enter geographical searches. The search box will return a
// pick list containing a mix of places and predicted search terms.

// This example requires the Places library. Include the libraries=places
// parameter when you first load the API. For example:
// <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&libraries=places">


var position;
var geocoder; 
var bounds; 
var map;
var markers = [];
var input;
var pos;

function setAddress(address){
  $("#search").val(address);
}

function dosearch(){

  input = document.getElementById('search');
  geocoder.geocode({'address': input.value}, function(results, status) {
       if (status === google.maps.GeocoderStatus.OK) {
          pos = {
            lat : results[0].geometry.location.lat(),
            lng : results[0].geometry.location.lng()
          }


          map.setCenter({lat: pos.lat, lng: pos.lng});
          performGet(pos);
          
        }
      });
}

function performGet(pos) {

    var icon = {
      url: "pin.svg",
      size: new google.maps.Size(109, 109),
      origin: new google.maps.Point(0, 0),
      anchor: new google.maps.Point(17, 34),
      scaledSize: new google.maps.Size(35, 35)
    };


    $.get( "http://localhost:8080/places/show_json",
     function( data ) {

           var count = data.length - 1;

           if(count > -1) {

            console.log(data)

             markers.forEach(function(marker) {
                marker.setMap(null);
              });

             markers=[];
             bounds = new google.maps.LatLngBounds();

               var tc = 0;
               var id =[];

               for(;count >= 0; count--){
                var dist = data[count].dist;
                var place = data[count].place;
                var id = place.id;

                id[tc] = id;
                tc += 1;

                console.log(id);
                var lat = place.lat;
                var lng = place.lng;
                var latlng = new google.maps.LatLng(lat,lng);
                var marker = new google.maps.Marker({ position: latlng, 
                                                      map: map,  
                                                      icon: icon,
                                                      url : "/places/show/" + id
                                                    });

                markers.push(marker);
                google.maps.event.addListener(marker, 'click', loadURL(marker));
                bounds.extend(latlng);  
               }

               map.setCenter({lat: pos.lat, lng: pos.lng});
           }

    });
  }


function loadURL(marker) {
    return function () {
        window.location.href = marker.url;
    }
}


function smallMap(pos) {


   map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: -33.8688, lng: 151.2195},
    zoom: 13
  });
}



// This example requires the Places library. Include the libraries=places
// parameter when you first load the API. For example:
// <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&libraries=places">

function initMap() {
    map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: -33.8688, lng: 151.2195},
    zoom: 13
  });


  $('#map-tab').on('click', function() {
    setTimeout(function(){
        google.maps.event.trigger(map, 'resize');
    }, 50);
   });


  input = document.getElementById('search');


  var autocomplete = new google.maps.places.Autocomplete(input);
  autocomplete.bindTo('bounds', map);

  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var pos = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };

      map.setCenter(pos);
      geocoder = new google.maps.Geocoder;
      bounds = new google.maps.LatLngBounds();
      geocoder.geocode({'location': pos}, function(results, status) {
         if (status === google.maps.GeocoderStatus.OK) {
            setAddress(results[1].formatted_address);
          }
        });

      performGet(pos)

    }, function() {
      handleLocationError(true, infoWindow, map.getCenter());
    });
  } else {
    // Browser doesn't support Geolocation
  
  }



  autocomplete.addListener('place_changed', function() {
    var place = autocomplete.getPlace();
    if (!place.geometry) {
      window.alert("Autocomplete's returned place contains no geometry");
      return;
    }

    // If the place has a geometry, then present it on a map.
    if (place.geometry.viewport) {
      map.fitBounds(place.geometry.viewport);
    } else {
      map.setCenter(place.geometry.location);
      map.setZoom(17);  // Why 17? Because it looks good.
    }
    

    var address = '';
    if (place.address_components) {
      address = [
        (place.address_components[0] && place.address_components[0].short_name || ''),
        (place.address_components[1] && place.address_components[1].short_name || ''),
        (place.address_components[2] && place.address_components[2].short_name || '')
      ].join(' ');
    }

  });

  // Sets a listener on a radio button to change the filter type on Places
  // Autocomplete.

}



