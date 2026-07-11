package com.infralytix.config;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Getter
@Setter
@Configuration
@ConfigurationProperties(prefix = "infralytix.company")
public class CompanyProperties {

    private String name;
    private String tagline;
    private String email;
    private String phone;
    private String whatsapp;
    private String address;
    private String website;
}
