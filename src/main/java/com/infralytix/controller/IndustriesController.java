package com.infralytix.controller;

import com.infralytix.service.ContentService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequiredArgsConstructor
public class IndustriesController {

    private final ContentService contentService;

    @GetMapping("/industries")
    public String industries(Model model) {
        model.addAttribute("pageTitle", "Industries");
        model.addAttribute("activePage", "industries");
        model.addAttribute("industries", contentService.getIndustries());
        return "industries";
    }
}
