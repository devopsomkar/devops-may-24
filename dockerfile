
FROM node:18 AS front
WORKDIR /app
COPY /package*.json ./
RUN npm install
COPY / ./
RUN npm run build

FROM maven:3.9.6-eclipse-temurin-17 AS back
WORKDIR /app
COPY /pom.xml ./
COPY  / ./src
RUN mvn clean package -


FROM eclipse-temurin:17-jre
WORKDIR /app


COPY  from= /app/target/*.jar 


COPY  from= /app/build ./ 

EXPOSE 8080
CMD ["java", "-jar", "*.jar"]
