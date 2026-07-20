package com.cognizant.springlearn;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.cognizant.springlearn.model.Country;
import java.util.List;

@SpringBootApplication
public class SpringRestApplication {
    private static final Logger LOGGER = LoggerFactory.getLogger(SpringRestApplication.class);

    public static void main(String[] args) {
        SpringApplication.run(SpringRestApplication.class, args);
        displayCountry();
        displayCountries();
    }

    public static void displayCountry() {
        ApplicationContext context = new ClassPathXmlApplicationContext("country.xml");
        Country country = context.getBean("in", Country.class);
        LOGGER.debug("Country : {}", country.toString());
    }

    public static void displayCountries() {
        ApplicationContext context = new ClassPathXmlApplicationContext("country.xml");
        List<Country> countries = context.getBean("countryList", java.util.ArrayList.class);
        LOGGER.debug("Countries : {}", countries.toString());
    }
}
