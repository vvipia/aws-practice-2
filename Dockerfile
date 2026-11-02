
# 첫 번째 스테이지: 빌드 스테이지
FROM eclipse-temurin:21-jdk AS builder

WORKDIR /app

# 프로젝트의 Gradle Wrapper와 설정 파일 복사
COPY gradlew ./
COPY gradle/wrapper/ ./gradle/wrapper/
COPY build.gradle.kts ./
COPY settings.gradle.kts ./

# Gradle Wrapper 실행 권한 부여
RUN chmod +x ./gradlew

# 의존성 다운로드 및 확인
RUN ./gradlew dependencies --no-daemon

# 소스 코드 복사
COPY src ./src

# Spring Boot 실행 JAR 빌드
RUN ./gradlew bootJar --no-daemon

# 두 번째 스테이지: 실행 스테이지
FROM eclipse-temurin:21-jre

WORKDIR /app

# 빌드된 Spring Boot JAR 복사
COPY --from=builder /app/build/libs/*.jar app.jar

EXPOSE 8080

# prod 프로파일로 실행
ENTRYPOINT ["java", "-Dspring.profiles.active=prod", "-jar", "app.jar"]
