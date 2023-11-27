#include "DHT.h"
#include <NTPClient.h>
#include <WiFiUdp.h>
#include <ESP8266WiFi.h>
#ifndef STASSID
  #define STASSID "Manape" //nome da rede
  #define STAPSK "kazinha31" //senha da rede
#endif

  const char* ssid = STASSID;
  const char* password = STAPSK;
  WiFiUDP udp;
  NTPClient ntp(udp, "b.ntp.br", -3 * 3600, 60000);  
  String hora; //armazena as horas

#define DHTPIN 2
#define DHTTYPE DHT22

DHT dht(DHTPIN, DHTTYPE);

double temperatura;
double umidade;

void setup() {
  Serial.begin(115200);
  dht.begin();
  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, password);  //Conecta ao WiFi.
  delay(2000);                 //Espera a conexão.

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
  }
  ntp.begin();
  ntp.forceUpdate();
}

void loop() {
  delay(2100);

  temperatura = dht.readTemperature();
  umidade = dht.readHumidity();

  if (isnan(temperatura) || isnan(umidade)) {
    Serial.println("Falha ao realizar a leitura");
    return;
  }

   hora = ntp.getFormattedTime();

  Serial.printf("%s,%.2f,%.2f\n", hora, temperatura, umidade);
}
