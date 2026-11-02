package com.back.awspractice2

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.cache.annotation.EnableCaching

@SpringBootApplication
@EnableCaching
class AwsPractice2Application

fun main(args: Array<String>) {
    runApplication<AwsPractice2Application>(*args)
}
