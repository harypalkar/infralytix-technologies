package com.infralytix.controller;

import com.infralytix.service.ContentService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequiredArgsConstructor
public class HomeController {

    private final ContentService contentService;

    @GetMapping("/")
    public String home(Model model) {
        model.addAttribute("pageTitle", "Home");
        model.addAttribute("activePage", "home");
        model.addAttribute("pillars", contentService.getTrustPillars());
        model.addAttribute("solutions", contentService.getEnterpriseSolutions());
        model.addAttribute("services", contentService.getServices().subList(0, 6));
        model.addAttribute("accelerators", contentService.getAccelerators());
        model.addAttribute("whyChoose", contentService.getWhyChooseUs());
        model.addAttribute("caseStudies", contentService.getCaseStudies().subList(0, 3));
        model.addAttribute("blogs", contentService.getLatestBlogs().subList(0, 3));
        model.addAttribute("technologies", contentService.getTechnologyItems());
        model.addAttribute("industries", contentService.getIndustries().subList(0, 8));
        return "index";
    }
}
