package com.infralytix.service;

import com.infralytix.dto.CareerApplicationDto;
import com.infralytix.dto.ContactFormDto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class ContactService {

    public void submitContactForm(ContactFormDto form) {
        log.info("Contact form submitted by {} ({})", form.getName(), form.getEmail());
    }

    public void submitCareerApplication(CareerApplicationDto application) {
        log.info("Career application submitted by {} for position: {}",
                application.getFullName(), application.getPosition());
    }
}
