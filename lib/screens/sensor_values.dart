class SensorValues {
  static double temperature = 25.0;
  static double humidity = 50.0;

  static int temperatureState = 1; // 0: Low, 1: Normal, 2: High
  static int humidityState = 1; // 0: Low, 1: Normal, 2: High

  static bool isWaterDetected = false;
  static bool isMotionDetected = false;
  static bool isFireDetected = false;
  static bool isDoorOpen = false;
  static bool isLightOn = false;
}
