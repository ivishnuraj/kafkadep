#!/bin/bash

keytool -genkeypair \
  -alias kafka \
  -keyalg RSA \
  -keysize 2048 \
  -validity 3650 \
  -keystore ssl/kafka.keystore.jks \
  -storepass admin@123 \
  -keypass admin@123 \
  -dname "CN=181.215.205.67" \
  -ext SAN=IP:181.215.205.67

  keytool -exportcert \
  -alias kafka \
  -keystore ssl/kafka.keystore.jks \
  -rfc \
  -file ssl/kafka.crt \
  -storepass admin@123

  keytool -importcert \
  -alias kafka \
  -file ssl/kafka.crt \
  -keystore ssl/kafka.truststore.jks \
  -storepass admin@123 \
  -noprompt

  keytool -list -v -keystore ssl/kafka.keystore.jks \
    -storepass admin@123