package com.infralytix.util;

import com.infralytix.config.CompanyProperties;
import lombok.RequiredArgsConstructor;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
@RequiredArgsConstructor
public class GlobalModelAttributes {

    private final CompanyProperties companyProperties;

    @ModelAttribute
    public void addGlobalAttributes(Model model) {
        model.addAttribute("companyName", companyProperties.getName());
        model.addAttribute("companyTagline", companyProperties.getTagline());
        model.addAttribute("companyEmail", companyProperties.getEmail());
        model.addAttribute("companyPhone", companyProperties.getPhone());
        model.addAttribute("companyWhatsapp", companyProperties.getWhatsapp());
        model.addAttribute("companyAddress", companyProperties.getAddress());
        model.addAttribute("companyWebsite", companyProperties.getWebsite());
        model.addAttribute("currentYear", java.time.Year.now().getValue());
    }
}
