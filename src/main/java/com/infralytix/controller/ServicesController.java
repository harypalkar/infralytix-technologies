package com.infralytix.controller;

import com.infralytix.service.ContentService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequiredArgsConstructor
public class ServicesController {

    private final ContentService contentService;

    @GetMapping("/services")
    public String services(Model model) {
        model.addAttribute("pageTitle", "Services");
        model.addAttribute("activePage", "services");
        model.addAttribute("services", contentService.getServices());
        return "services";
    }
}
