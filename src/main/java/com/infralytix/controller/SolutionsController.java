package com.infralytix.controller;

import com.infralytix.service.ContentService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequiredArgsConstructor
public class SolutionsController {

    private final ContentService contentService;

    @GetMapping("/solutions")
    public String solutions(Model model) {
        model.addAttribute("pageTitle", "Solutions");
        model.addAttribute("activePage", "solutions");
        model.addAttribute("solutions", contentService.getSolutions());
        return "solutions";
    }
}
