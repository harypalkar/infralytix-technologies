package com.infralytix.controller;

import com.infralytix.service.ContentService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequiredArgsConstructor
public class TechnologiesController {

    private final ContentService contentService;

    @GetMapping("/technologies")
    public String technologies(Model model) {
        model.addAttribute("pageTitle", "Technologies");
        model.addAttribute("activePage", "technologies");
        model.addAttribute("technologies", contentService.getTechnologyItems());
        return "technologies";
    }
}
