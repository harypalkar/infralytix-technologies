package com.infralytix.controller;

import com.infralytix.service.ContentService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequiredArgsConstructor
public class PortfolioController {

    private final ContentService contentService;

    @GetMapping("/portfolio")
    public String portfolio(Model model) {
        model.addAttribute("pageTitle", "Portfolio");
        model.addAttribute("activePage", "portfolio");
        model.addAttribute("projects", contentService.getPortfolioProjects());
        return "portfolio";
    }
}
