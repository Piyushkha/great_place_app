const GOOGLE_API_KEY = 'AIzaSyAn19Rmj_VfL5QUjn9vpTtBVKe3eEetx_I';

class LocationHelper {
  static String genrateLocationPreviewImage({var latitude, var longtitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longtitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longtitude&key=$GOOGLE_API_KEY';
  }
}
