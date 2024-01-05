class WeatherModel {
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '1';
    } else if (condition < 400) {
      return '2';
    } else if (condition < 600) {
      return '3';
    } else if (condition < 700) {
      return '4';
    } else if (condition < 800) {
      return '5';
    } else if (condition == 800) {
      return '6';
    } else if (condition <= 804) {
      return '7';
    } else {
      return '8';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
